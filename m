Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A93CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 06:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umR7C-0008Et-Th; Thu, 14 Aug 2025 02:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1umR7A-0008Ea-N6; Thu, 14 Aug 2025 02:07:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1umR78-0003fP-R5; Thu, 14 Aug 2025 02:07:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e2eb4a171so1029993b3a.3; 
 Wed, 13 Aug 2025 23:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755151619; x=1755756419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wC9KY/GiZj+Qq9l9QHFtj9nmi2ll+Pn8RNRuLGXU7Yo=;
 b=WlS4gN3qh9ddULicNY0tiEVuGNHFZRmMPY/9h6LAtKQ4Cy6XRUkaXrb0I9sBZ4YqtL
 UKSJxuBTWIU8Tg94vIL1EMP/zGJUrrJCIrott2dNJrjyWTEtfm0xsrZb0hFVOi4NUuLb
 B/sPW1lU2BbYTq3ldkDE6BPjmdvwTAf07vmg3yRSbMLIXv6ssGCXlFH4KYYRuBJm0/RX
 40iHMK8NwxeZPbSECCX2EE6yCQ6yifY0j1AbuioUTV9GQZD1/i03Xid6UfFGXySaJYhO
 qPTDaU6E2VFrRJKL5xJwLtN5ntsV2k30DiN2P3EtDoWTHGGO4JQoFp/rG+YT8+jaDi2r
 78Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755151619; x=1755756419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wC9KY/GiZj+Qq9l9QHFtj9nmi2ll+Pn8RNRuLGXU7Yo=;
 b=f+CxFv7KYUEpDv48h/+om+CkuL/F/RyQdZs7i4lFIo1H+rRLUbUP709j0Y+BOKohtG
 4ZckFMGEDAha7zkTS9TQyVoGMG6P+tlLa1veed5kKCOQM42VSxDKS+lA6YYrtqvbVLbW
 vafNbZPl7pjuVEgswI351mWf1Neb+s2D8T0YqAGrPFxlbCE141pbglcsFJGsy9c7ZBoX
 T1wZsHuk7gFNwIOmPbgOT28zxaLZ+YM9UyKNRBwCFayaPHnwUU6E0UNnrK3kSpHkz1Lb
 0bB8tHJtepGblAnmjLXqvhuHs0qy98nTYnLQtrIWSyQdZ0SwdVZC0ZmOosj63KHrYPoG
 Qj2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYl5Y6/GNWbikHhEZmxtZJ4/YoanODUXyzWM9E9AS9w98zl4vrH0717qfnG+rEO9QGd/M/Y3rOMUip@nongnu.org
X-Gm-Message-State: AOJu0Yy5klZvsgqXCv5Kho/CehdOS3wxWVqGBoWA4P0U+SmN+FdAP4z1
 Fzv1EmCHeDEYtQwaq7qtIHOdrs8Nq+doQkemvJgt6HwjnK6WNq61YNwC+KVtLQ==
X-Gm-Gg: ASbGncsBgENp8s8eCYaC6uqUlXmpTkX0H+cmYzt6TXouaZtIHyRTy8saQDzK/xaEmWp
 3uZ7QzVtFTxdqTGWyIYsNvmEEM449zktQwno5CKq58jOHxeDZq4aZxUNbXcHoobeyUwpE2Yp98J
 4kF0PyZGIS6/tKCtnuQm3O/Ql2XWzwQoHLbU0NcnguzLe9nkAnofNuH355uxQ0Pl3EuWpjQZPEY
 25GNIR7KcdeHQB4XrdvCveVToyD/0r/DVv1UEFlsf1Dt6BMQxi90L+ao7YvuN4c4R73yOQP+hdz
 uHqtW5FIcR9SF7lNTXE+kGqv3RsW49ceXkBhyef7OhO6M5C+o++rSyZ/rgIFgOL5JYHttkaf9Rw
 N84Ma1CM8bNxcdRygdCIUvMLw1g5hs9p+a2tknCg=
X-Google-Smtp-Source: AGHT+IFli+tBUhjA14piBIqme5YI+4DxXRJdzQy07MMieqnuDenpasXSJcazpu2zQQQrq9hL2Zr4Qg==
X-Received: by 2002:a05:6a20:3ca2:b0:240:16af:401a with SMTP id
 adf61e73a8af0-240bd286980mr2774107637.32.1755151618705; 
 Wed, 13 Aug 2025 23:06:58 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32330fe255asm646832a91.14.2025.08.13.23.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 23:06:58 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, jinbeom_.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PATCH] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
Date: Thu, 14 Aug 2025 15:06:42 +0900
Message-ID: <2ea746d2c2e0a2c62a411324cdfe1a28736b5711.1755150852.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
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

The UFS spec defines the PRDT data byte count as an 18-bit field. This
commit masks the value to the lower 18 bits to prevent incorrect
transfer lengths and ensure compliance.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 0577747f46..401aca311f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -224,7 +224,8 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
         hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
-        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
+        uint32_t data_byte_count =
+            le32_to_cpu(prd_entries[i].size & 0x3ffff) + 1;
         qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
         req->data_len += data_byte_count;
     }
-- 
2.43.0


