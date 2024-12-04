Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEC6E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvPN-0000ws-Jd; Wed, 04 Dec 2024 14:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIvPL-0000vY-Hg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:51:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIvPJ-0001Jb-Pt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:51:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-215bb7bb9f9so919945ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733341892; x=1733946692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hJnVqGKgE5xAxt3ubjaUh4ERJ027DT3bfz1Npiam3ec=;
 b=fQUmkMwSH9A0zRy6igpDPcE8Bhu0o+MkAgnw0fEWDXaZj+Z17SgJwsPPrFaPNTcNjY
 1xAjYV7SR3HmVbG72/XX6HiaRK0Hg9Te8IYcZyNu9wkO0G0DAamrmqNs1gEL8zQE6Mdd
 Qi04YRBFANa43KHKCCh48bJHzh52wOiuUnCq4wjVNAjTV/MxK0pXXwqD+qL11BMNCx9j
 U8GEg8bCMrd2gUQDfluhytDKSW5ffGOCXWBJcYdvzJDGtCSexotyw2zsI86w2uRViCmf
 rBmH1wKL0Iqyw5b+qg2gl8APn9s9owaLFII1+Pmmq9HzNNm0cYAX4PRJkVjURAcjxH88
 aN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733341892; x=1733946692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJnVqGKgE5xAxt3ubjaUh4ERJ027DT3bfz1Npiam3ec=;
 b=KrHO6ZOYqVO+hBrElorl4vPDhVj2EUI1kSoqfupSHbEQr+zXVYN0n2No44K5h3XsRU
 rTcWveuyjVZ4cRjNbO+nnvYyXU4xChganD0S3g6DIHCzoAtOOeoGd920dNq1+oR6OOu7
 U3VwNdA9SprPIGpBywZSDecrcjeYfpEa7NRFd3KvTOIAuJPtA7aXva24bnvVCN30ZjVa
 F8Ncue6ud0tEHPFAqaxCCj9/n5m93oY9rEJOpKkZruevuun1JnhTzYNYtzR9TpBnhuFt
 nPF4waSAtTkNgNEpD6nd+5wUGgtpuVb276Oi8nV2ipnN4mUQ0oAQArXwV20Sy5ePgqOe
 sc/w==
X-Gm-Message-State: AOJu0YzmQIi9m0mVPT4N5AJCWe4hAg59t+MKLQARGA/yF7FG3U3idsFl
 +qu42pOnVQVNncWlBwYxj6WiZEZ8Qz/4o+AujFmj1YBtE9QwAKiQRn3hYZ0UR8w2+u5ijKM+5Nl
 fc7s=
X-Gm-Gg: ASbGnctcSgx/z9cd8HpZmg6IIqA9CtN8XouOvIMZQ0JZ7HUQktGr3sqBj0eTm3+ZWhL
 EoIc+cuGIxONcMN7VCmRrzadDv/eRt2EN2fFAINE/cjFEaV7YCh/MLEBAqxGegeOddnLC6W+Qig
 MLpXs1ZE9TYkCrZyWKIJVpV7Qf9oWm8K1OdnicfwkVTVRwghP5WBIO5POp7rogi+jwCPCedVO/4
 pSCi/Aoj4Ky8x+oW/v52QJlfVxfdSAtTtF1s52xjtjltHZqSDwqbnmvnsWerUF2ubHmMX2qevXE
 2etjZm8D
X-Google-Smtp-Source: AGHT+IEc5o482XvFsTuGa+jVkcRuMmQ1DxT/XiVkWwea7w/hegSTjwLtSYRabolSZoZdjdxoHKsAYw==
X-Received: by 2002:a17:902:e744:b0:20c:5533:36da with SMTP id
 d9443c01a7336-215d00b8806mr81359925ad.42.1733341891825; 
 Wed, 04 Dec 2024 11:51:31 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417fb950sm13162824b3a.121.2024.12.04.11.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:51:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, alex.bennee@linaro.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 peter.maydell@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] vvfat: fix ubsan issue in create_long_filename
Date: Wed,  4 Dec 2024 11:51:11 -0800
Message-Id: <20241204195111.2921141-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Found with test sbsaref introduced in [1].

[1] https://patchew.org/QEMU/20241203213629.2482806-1-pierrick.bouvier@linaro.org/

../block/vvfat.c:433:24: runtime error: index 14 out of bounds for type 'uint8_t [11]'
    #0 0x56151a66b93a in create_long_filename ../block/vvfat.c:433
    #1 0x56151a66f3d7 in create_short_and_long_name ../block/vvfat.c:725
    #2 0x56151a670403 in read_directory ../block/vvfat.c:804
    #3 0x56151a674432 in init_directories ../block/vvfat.c:964
    #4 0x56151a67867b in vvfat_open ../block/vvfat.c:1258
    #5 0x56151a3b8e19 in bdrv_open_driver ../block.c:1660
    #6 0x56151a3bb666 in bdrv_open_common ../block.c:1985
    #7 0x56151a3cadb9 in bdrv_open_inherit ../block.c:4153
    #8 0x56151a3c8850 in bdrv_open_child_bs ../block.c:3731
    #9 0x56151a3ca832 in bdrv_open_inherit ../block.c:4098
    #10 0x56151a3cbe40 in bdrv_open ../block.c:4248
    #11 0x56151a46344f in blk_new_open ../block/block-backend.c:457
    #12 0x56151a388bd9 in blockdev_init ../blockdev.c:612
    #13 0x56151a38ab2d in drive_new ../blockdev.c:1006
    #14 0x5615190fca41 in drive_init_func ../system/vl.c:649
    #15 0x56151aa796dd in qemu_opts_foreach ../util/qemu-option.c:1135
    #16 0x5615190fd2b6 in configure_blockdev ../system/vl.c:708
    #17 0x56151910a307 in qemu_create_early_backends ../system/vl.c:2004
    #18 0x561519113fcf in qemu_init ../system/vl.c:3685
    #19 0x56151a7e438e in main ../system/main.c:47
    #20 0x7f72d1a46249 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #21 0x7f72d1a46304 in __libc_start_main_impl ../csu/libc-start.c:360
    #22 0x561517e98510 in _start (/home/user/.work/qemu/build/qemu-system-aarch64+0x3b9b510)

The offset used can easily go beyond entry->name size. It's probably a
bug, but I don't have the time to dive into vfat specifics for now.

This change solves the ubsan issue, and is functionally equivalent, as
anything written past the entry->name array would not be read anyway.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 block/vvfat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ffe8b3b9bf..f2eafaa9234 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -426,6 +426,10 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         else if(offset<22) offset=14+offset-10;
         else offset=28+offset-22;
         entry=array_get(&(s->directory),s->directory.next-1-(i/26));
+        /* ensure we don't write anything past entry->name */
+        if (offset >= sizeof(entry->name)) {
+            continue;
+        }
         if (i >= 2 * length + 2) {
             entry->name[offset] = 0xff;
         } else if (i % 2 == 0) {
-- 
2.39.5


