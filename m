Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779A3CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkcA-0001Kx-Mj; Tue, 13 Oct 2026 18:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkc8-0001KQ-Ta
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkc6-00060e-Pt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:52 -0400
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B3E63F5D1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791929088;
 bh=FMw9kRqVy0zlzcfXTIOpMn0U+XSNkZXzyqZYfotPZgs=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc;
 b=JW1WPEcl8p+w7wOw4uGPNOw5dptNmm2RrH887InP5ly5n8bq479Dos2ukGm5DSJHx
 9J3GEXlm4fonXyeqvxH4RtpWtRD8upHk1Ar/ZKVFIjGVi4yu72Sq4abiyVY6BTPErE
 K71DgSRAD8RhNDNdD0zHX+3h1+0NFJavNcgJbvzrH/XFqI7fkSGaANJcocNEDSmJsV
 7Y+V0WL8Q1NYvdcWKp7qX2kdLo46uec14W2VE3dBalgfzxRti6unt2pvkHeR7p8Bq7
 0cspZ351bKLIx0b834wYprKKal/NjZ37Br3C2oNump5/wbqqcjGNfvcYSmM0ge+JGI
 K1XBnAm8qkw161U+koKXvfSwecwxCcWNSbixrq5PsID5ZOe0TGh9IENZo7nigKrg3W
 96uyUfuxLl/YN9v8WvXlY/b8Eq4qwt12/sguEaocNfvaxaPYRPi1G1TXQxS32FKfPp
 4XK+pCmh7Zdb4fTaENnzHuYfm4+elM3Pa89e33NDGg/OLVThHCJr8vH2hdG3VU/cV6
 BpdIqS2EpUroMH9Ckr2qa730dAV/c6qjl5H9NHqapmJ+T7R3+p0bPsRn2qP1f99KEt
 lkw5ALxFKKeDA7eHmsT0K0G890FqBXz49gsHMfjBb3kCGNq2nf14HOVBPj4/CkGJgG
 1iWoPkXt68kjyumi61BjK3GY=
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6756044f260so5014699d50.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929087; x=1792533887;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FMw9kRqVy0zlzcfXTIOpMn0U+XSNkZXzyqZYfotPZgs=;
 b=R1agLflIEOBP+OhC9qU4jU/dUHiXvBVI8yMTf74Ab4JJLLOogOWgc82DQipvKr6ilp
 WVJrrLOy2XuA80KZwpQBHCHn/EIIPN8bwWqVvF0KQN8Bn+xpdfviA9B0fvmg3rs5pSH7
 3oZ1vplp1tfxGUa7c4FZi3EYYZiVyGxqNRmGw8dTYSIY8+uYuPZ8X4jSILgHVBZhf/lZ
 GxvPlS31TWQvnirPsdpRW0WycW0W+u0WErePdjuvpJoFpWnkuuNztVdje/iYWQ/bmVpE
 sLDxtyf0CbpGXK61CpgxzbUklpz2QXY9RkILT3Y+AQLJy8wO36sq6Kw909QdN9NpvBsK
 jBrQ==
X-Gm-Message-State: AFq9FYJ0uuAxW1Zgmxl4epbr6sgAZiuMpZB+9BsxAsZkV9BTUdOIbGH0
 34QeoyCe26f88Fk+TrEGFHjC4alkuJb8KVzmsXhcyUG7DGgzrvxB6oUXGQb5USCj4ksTw5lUY6r
 fJ1Piwx0m9XMPXHryjYPLh7kP/gkXZYJAmnUyCaDU58DEXCBbZS0pgMZwGWu8H7fuDt4wBFdk
X-Gm-Gg: AYBFou2zsuTEmjJyzBo1HrGu/+nQAzmJ83aYteQeHq5HI6RL0rxJd/wwuma0WbJAvPN
 ZpBT7Kj88TazECfhSZIB37ygKMo/jmPj3FwN8WvB/koQfQ/7aaLWnX1OPP48Dn9zlUd5uFkkmAx
 Pc6O1IulysCjdlab33v/9W2NH/FjW5Y2FiiXPKi+BhKLBKdTExMDGUNyik1JWkBC6W2BPIedMpf
 qKoU+tSnN5DapO/mDrRUpG8N2+Uz+992z2rClbVPlLuKYuMuaCRXTPcZFSaHQQpZzGZHIxjmAVJ
 uNiVHkPxHgfFkBjQqyKWSAqCxJWD0ANh8aZf802k7oMsFRQnlLpo85j/7pVHtizA/sBIJ7QpgxE
 sAyxkY7W/x9fczCUSgwqiIlV9Nb9UBW6xbBmyOhyrZYeqWA==
X-Received: by 2002:a53:ecd3:0:b0:677:d05a:4800 with SMTP id
 956f58d0204a3-679368f5337mr3364566d50.25.1791929086844; 
 Tue, 13 Oct 2026 15:04:46 -0700 (PDT)
X-Received: by 2002:a53:ecd3:0:b0:677:d05a:4800 with SMTP id
 956f58d0204a3-679368f5337mr3364564d50.25.1791929086506; 
 Tue, 13 Oct 2026 15:04:46 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67986a679ecsm336019d50.13.2026.10.13.15.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:04:46 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: [PATCH v3 0/2] util/coroutine: Reduce default idle pool max size
Date: Tue, 13 Oct 2026 17:00:59 -0500
Message-Id: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQ6CMBCG4auQrh3THwLoinsYF6VMZRJsSYuNS
 ri7haUbXb5fMs8sLGIgjOxcLCxgokje5VCHgplBuxsC9bmZ5LISXCiIOEOPVj/GGSbvR4j0Rmg
 6WRtujW5QsXw7BbT03N3LNfdAcfbhtb9JYlt/iUmAgLpDcSq51LYyrdHOOzJ6PBp/Z5ua5F+SB
 A62tH1lpVaKq29pXdcPNn8IPggBAAA=
X-Change-ID: 20261013-set-default-pool-size-8b27c0fca8e3
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=IkZwjmkBoTbP6txfzYNvfbnWcLKwrp5RX4BwTB+IbOo=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzqr8Tz6IGRnCsDl0AeqbB+zekzr/1EKDs+K7V
 4rG4b8+WK+JAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas6q/AAKCRD5KICs4jod
 ubVnDADO9o0jdFIFdTb0/lQpmfsmlHRyDdEMRetY/AIpyqlXIji5Pb42DBrYBBte0YKz1+RzLWI
 RQ0BiqTT7l11O1iRYezBkKoJCCVTQbHbMSGFcnAsPdXI85Jy+duY9E/7/V9uH8QAoyR/0Favzhx
 XO/bPh9AO9LQyL5q1oZOrf2NpMLYE8gQoaY03dqDOlEHuu+8Sho2Jf2JU2MYr9HrH43t+0HDKUa
 /uT8osEyZV7icxm/ZNWmtGLc8SvhjtKohR1gn9MKj6L39uOGf+G7VcPjEJW5AbN1hoeQY5P/GyM
 xCGyZiDbA14wbDKeHpVCU7E+CWNNF4dSZ6K9Rh1MdkbxExTEkDGLMSBRq8Sdn872VxmFuSWxxQH
 bEesUpNOzLrKol2NMqU49puJ/bmkRwvlT1n81lAiDkaNz8F6yDEwQ9OBaEsx1nsYQ1qFK/HjwiV
 BcQLdwgIWVsZHg8ndAJIEl/VlzxJElGZ5FF1RNXV4Gf6zyycI1rwTGVpak+zCbvNe9OQw=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adding Hector's patch since mine depends on it; please let me know if
a different approach to sending this would have been preferred.

Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
Changes in v3:
- Use Daniel's suggested implementation
- Clarified comments to drop "LSM"
- #define DEFAULT_MAX_MAP_COUNT
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com

Changes in v2:
- Rebase on Hector's patch
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com

---
Hector Cao (1):
      util/coroutine: trim sysctl's max_map_count newline before parsing

Wesley Hershberger (1):
      util/coroutine: Reduce default idle pool max size

 util/qemu-coroutine.c | 75 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 25 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261013-set-default-pool-size-8b27c0fca8e3

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


