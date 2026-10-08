Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692DCCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt3d-0005HX-7o; Thu, 08 Oct 2026 14:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3a-0005Gm-Sa
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:30 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3Z-0004k3-F2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:30 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1419d3416ceso10811748c88.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791484888; x=1792089688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Coay2iJup3vt2jSpwy61T61mAcTWFfpN94b6Bgeru2Y=;
 b=bF57W3FU4BDETVE9dWB9m6oV/eeZ2KnjOJRS1gPlyjjU1Pwk5DBArzAo+nzg4boEca
 vqYZ94iUMgU1CCFxQavGzg+e1/ef/SVD9bAw3Z4RDezZGCZqkYTV60Tn8bIIh7q+Oal0
 zJdo9UtxmwcWJZKkHou056SiubHx7UBfKBX7aqN1IzbKy40Cjx589ph61UiRzuYxMFRg
 dBS7PB9yvSTJ59T0xXkat0eGWifn7Hle8/CQwdHYxwtqbsMv7C93OZxjMptx/XbGAw2P
 qYj+bq7tCqzMa2QuUZomFIO2rEDYPer1JmQTgCG6nJeMTYRTsDUyMJI00cSzpZZB2gln
 NVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484888; x=1792089688;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Coay2iJup3vt2jSpwy61T61mAcTWFfpN94b6Bgeru2Y=;
 b=T3zV5KCbdP4Sgko4pxDB0IIGCPMQdrYwE9I2p3EmYKg3DVAtfXp8KchSR3kAxXYOkU
 Y8gB5iInlvNvy4eKfCdum5elYmONiE/BNK32YAsBmmku76pa28038itq18yYQP1D4eog
 e9HhXi5GMi9iKaPMwNUeNL7HzpFhtSmMp8WsojlZ8R7pd1h7RWKdFkyOTyhnI+9BgrIp
 NDulF9S9sMb7c+QxmXcXoPE0ajVYJpBY/Sc2eZ3EUSJrq15RLeIUtisQ1jX54qlXujDy
 BKi8Yw/tlHgARkBf3F7ZLgCaT43aVIh96V0+s2spYqWuGtjahqLlcBQzetNup42u+fD7
 Zm5Q==
X-Gm-Message-State: AFuF++nUAR8NjJHHeBA/p0ATC0tjCzsKBmKIjK9V7ggTUkWTegUnIrf7
 PuBdBNO5d0ydXuh0G9PdNWdiqKZgKeBMnrbui9b8AEDzYaBYouLXGEm9AaiC6YJN
X-Gm-Gg: AYBFou3gUGMLIqKZTJbNLoq83AhDIq3wKJ2Qge7o/m+8E1tGPfSmgD0uIlh83SFkpLg
 pyCUTfVhX7dqvPstRN0M+EDGznalPqxnRc84V4nhHyQAketWjNnWOMjt9MEAGQtTACFRuqjlSRS
 N/qxiI43U5cmUxm/80gyC8ZdU+dy8jgDRG8p9FN/BNJhuUUOC+PCGBdMwu5HYu/4d9lO46jvNZ+
 BRHgEYcI+n2yl/ztMD6LzQfKLjvZOBLbqB5C0z03wu00gzvj+hYZ/HdoxbkoXPQb36Yc+xiqcua
 ttY71J73b/J0BtZ+gT6lYvB9cBqjks5ybYu7nd0N89tyiXfClN44Q632kN61MPRmroT1uQnKciN
 aa2g5OKoxktLw/f7BbAP/+uGZQNDJTqJF3/YokVCqahnGg18RC45zWhyFUHxAllfT9ZMjRfgxC7
 IjM8VAF4ttTw4+/RXelrFoHAlwC1V+07IFBs4+AgPReiaiSqoLS2FCs9LLQL0ZB9MPviNsWqBJ2
 yPwS1dvEvZKHN6kGg==
X-Received: by 2002:a05:701b:4306:20b0:147:8a40:cdf3 with SMTP id
 a92af1059eb24-16204a8283bmr7389824c88.24.1791484887770; 
 Thu, 08 Oct 2026 11:41:27 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a442ac67sm259515c88.18.2026.10.08.11.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 11:41:27 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW
Date: Fri,  9 Oct 2026 02:41:17 +0800
Message-ID: <20261008184119.142-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace MinGW-incompatible memmem() with a bounded memcmp() search of the
s390 BIOS image.

The Windows cross-build did not enable slirp, so it skipped building the PXE
test. The series enables slirp for that build, ensuring the test is compiled
and the MinGW portability issue is covered by CI.

Yonggang Luo (2):
  tests/qtest: fix PXE test build on MinGW
  gitlab-ci: enable slirp in the Windows cross-build

 .gitlab-ci.d/crossbuilds.yml |  2 +-
 tests/qtest/pxe-test.c       | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.55.0.windows.3


