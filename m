Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF4CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcg7-0002cE-RO; Mon, 22 Jun 2026 07:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg4-0002bn-54
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wbcg1-0000AP-Vj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:18:55 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 35A0A3F27B
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782127130;
 bh=564tEES3OR1j7pKdJWkwdv7Uqm4G0duQBcH28E4DeJY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=b+F6Gs+R8quhOafCzQ/8L1yGkupl7yDKcdCGyfXYdbtEXVweI/JXlMMJECyPUhg1N
 VXi3X74Fnrvmtcdn+9lPM+XpKWuxzcnQOwnokKZW5mrcIUG2vQbwkEiNshQNgsqN0N
 w24BcNzFL0VWGjRjywiw2rtaoKYT9KcOojub4j581HRbtMXOTgTKmAGYZyfdz89egt
 dvvu706fyGgxr1m6vSlsQ/NLOI66Ykk0h26qV4FByEbS/P2LyRjPf6I/pxduP3UINp
 CaRmH4esOWr7N7S5EZ2x+lOZoOzlDNrq7FqN2EmLgsEa+ETEGhiezYp47IrRNd8n1i
 oNjGF0N5Sr+2XmfVFSicplOHhTe3xsw8HY+fd57YFDFGMb64bxMH17bA+SxTUgSL9e
 HvmUmo7TD9pFEtHWzSNxXCP4yoHSh8cmmYUU7+awuhSLSymLXSWKD/TcuzK484Z9cm
 fuSBf9iumOHUDZlXitXhjckjx5nVGW/WprVGKmLFTi5jKeyNzz1piAahS8QJwanMGw
 r8foyO2PJAki9uun1M+DE8z+VAqzRfEbCqTckkcodGL3jd188UTrw0juqjKhX95Ei/
 ldPlNI8bfkXUYP7tSnPeSj/Qi0jnMamPt4sjAFDFaBGuRchGQ6enPwoJen8Vea6gmC
 RvDHIPxnVuO5fpU4H3VVDnHo=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-465874136a7so1819034f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 04:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782127130; x=1782731930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=564tEES3OR1j7pKdJWkwdv7Uqm4G0duQBcH28E4DeJY=;
 b=JOgdy+N6eks5o27dPaURmeKnd2NsbJ6Fm1nB0fJ7bMQ74GGy7OG3lOouXJdiYlSfC3
 UKb9/aUss32hfNvCnOonB8pvPeP7zve/a/MjRsqwiKCRYFTM+38107UGueCBIK3skj8C
 lPj7Hz05+mpGAkrAwbcyYf6p30yxw9BNp24FWMxF3sl5aTAe1zErMbJ/7xQLd9WVdbqU
 ZIsGrpdK1qauITiY8q4mwPRKEMyWJjERNIkUgv3vxBz4C5v68cI9yIVACeosbar2yerc
 /XN8q4jo6TIwW8a++znOJPjY5i4gky+/ZRcb3Iy8ug8wgKO0AqdUuTkzZ9eUo9IsqIIc
 lFDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZIvO4/w4K9/OjDf3KyN3c1HTd+ZHuBizEjo5T3QnEqxx6cWAWRzneNUhot0gbLDH6f8l5XfWVU0Xk@nongnu.org
X-Gm-Message-State: AOJu0YyJtdBd2oPhcN8g9x82O38RZEusO2eEiR6o/9oKaxMFrEW9BuHh
 mycc7yJe7Wo0jxiusfi/GW920FQ7qdP7rlpxHpfMWXJxwg4FNM8klkivvnixK2cXPxa5HRSArFR
 ZavZdKl0T1bL5/oT6i8z9JREgWS3c4n6STidLexsTgSF/mBM1gH657VL75NyZuby9bwDoOTDF
X-Gm-Gg: AfdE7cn++O5+VpAb5oi1NJC/mGCrk0LSnCuIdpQYzsGZ3ZxuV//yAd+Xae828S7Xkbm
 8yMTrzqEpXctLLKlCoNgwQcn7OdytXEhtZBtnfR8pAr2R8GQK+e8NDfz0lK5CbjW81FDhetmJ42
 L0di5QNYITTSIRBbAu03XC6xf2Rry9HASX/+cUZX8nSVxeerk1+EqqJZOSS/6GlM3ituXDusUPQ
 PI0iyDTPUSHxq6wsQ6oTlQz0ZsWRxQ4sEzHCT6G2VUI4SmemcNJy2qCZkR/7GYa0JY6N3qwd/l/
 MM60rdbFTYAfPYdMfOzG06XDvw39zd8F6Dwgaw49dlRphz5+2UzetnrZonb2bhrxi+F3AqoyVd/
 sCc9F+8voDZnSlODw3eT+q7L+e7GYO97wFD55rC7eqd7A3w9xaDAtg0x2X/HPW+XQMQ==
X-Received: by 2002:a05:600c:34d2:b0:490:b115:e03f with SMTP id
 5b1f17b1804b1-49249083bb5mr140120415e9.8.1782127129742; 
 Mon, 22 Jun 2026 04:18:49 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:490:b115:e03f with SMTP id
 5b1f17b1804b1-49249083bb5mr140119855e9.8.1782127129374; 
 Mon, 22 Jun 2026 04:18:49 -0700 (PDT)
Received: from workstation5 ([2a02:3035:605:b91c:8708:9b24:1b42:7a43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm313672525e9.14.2026.06.22.04.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:18:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 0/2] hw/acpi: correct field sequence in SPCR table
Date: Mon, 22 Jun 2026 13:18:41 +0200
Message-ID: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=0.645 autolearn=ham autolearn_force=no
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

On LoongArch and RISC-V invalid SPCR tables are created:

    Terminal Type : 00
    Language : 03

The correct values are:

    Terminal Type : 03
    Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Add test data changes	
v2:
	Update commit message

Heinrich Schuchardt (2):
  hw/acpi: correct field sequence in SPCR table
  tests: update SPCR loongarch64 and riscv64 test data

 hw/acpi/aml-build.c                   |   4 ++--
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0


