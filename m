Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F951C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Nh-0001sG-EK; Fri, 11 Apr 2025 04:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ne-0001rQ-Nx
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39NZ-0004ga-BO
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:54 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso2017147a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358683; x=1744963483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9ic4B/rwU6lGVm2qywvY/LkwDOCVoie+dMhossDunE=;
 b=mN5WMkC3wJeT3Kq35vl4d+yK3JKfMydTtwBYiRa8hIngzKfdyPf8cy+wzM3oQFAdQX
 o/cr8GRDWHb9WT2nLfwAO0PbWF8R0Gw16Wuk2ed7PBh3vr9jp7PSePmB9TbzPGgGkgm8
 mPcVQGVp6e4W8TB8v3efBYQd9WeYzM5SGPKbY1tHWO4aoN2cKz5uLfjHVGPV+zvbebCa
 h34HQ6RvT34SZChGpsKDbJVhP2r57agqKJcYIQRsrsreTLA+/hJ+vmz52Z/5VhRwggXM
 qu0F7+wImZSJ7yR0+AvOXutWzoz/cvQfjMjHNAVocltgGhApqM/oPprdpClVQcfriSrb
 toSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358683; x=1744963483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9ic4B/rwU6lGVm2qywvY/LkwDOCVoie+dMhossDunE=;
 b=uwGAs+SuWlD57wS2y8P4a00OiyKEFiiY365pKh88q6w4k39dmGsI2QhS5wGWwMUOgK
 FS0HwomueTedsEwvfm4NrprwirxP0Uc59SNqsT80KtCyjSjTLjOpbeVGPMt2a5l1bp3A
 4QTEPsf5QoZTYqtluv9q3tyvaTRj4UGsoh1jCzJOMVmMVtVAjzwfsDZkKEBLRDbrDLxR
 cGWAIepb7iEDuzsGYZgmvMVtC+jQSftZDlsE0v/dUIsD6X8RNU6DG8NnDmE0n62IfN1n
 zf4UKGpoC3uFeopR4V5Z9pDyxXefgxJQe708TkNo6JNtbFGWxVcyu6Rfn88+GBtqcQId
 o9SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPXZ+PHCDiSnq5s7r3uGf1/SlpDtQggBzNZK6mkqPZshZ6PkR9XJ0M8J//V9SrN7pjNUY9QV8f36Lb@nongnu.org
X-Gm-Message-State: AOJu0Yxw8iTOZu/2XySqXp3sVyMFj9DVWGY8YZqS/goAfx6sBSxhkCHG
 UWSqtJYcjPCZppoZt7IHSARgh0sCHon7RZqCmX+IYZxV5zQI/SldlivnXA==
X-Gm-Gg: ASbGncuXKMdQin4ttVkeS5CKQTbdcehLRvPV5fkMNcDvJLBKNnYhz6PrpmgIWTkUMyk
 mqEUFfeoQRs3EYkyVxyQNpcKRPY5jQYgnCqaXqTsnQO3RWQEwKdYA8C3HlzLt8W2KAUVkQoVr/j
 CoqYqF8ADolaiiSCR9XpJlm3Fc51QdEuoVjbSlvhwTSFN8eruc5QYIYs1jTh2y2ljF3lh8C4w7c
 vmAkM0LrfPIh+6FaM3QjuhUYWVUK9s/bEx0wO3A3ByFckwjgb0IVyA25PLk3SypdxgLn+GlI4rW
 D5Zw4hap1ePlfDJB+uyp7R91GSRknfGJ8F2FZjBdjeB/iHoVw13tC3E=
X-Google-Smtp-Source: AGHT+IF0OPk/55gcEkFEpI6rO3/SP7YEYmaeTnn7a2qa0EHNLOmfwGxyvgIXfMNu1JRxstPq8lsxNw==
X-Received: by 2002:a17:903:1b67:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-22bea4a1d11mr30990005ad.10.1744358683451; 
 Fri, 11 Apr 2025 01:04:43 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 02/10] usb/msd: Ensure packet structure layout is correct
Date: Fri, 11 Apr 2025 18:04:23 +1000
Message-ID: <20250411080431.207579-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

These structures are hardware interfaces, ensure the layout is
correct.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 2d7306b0572..87c22476f6b 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -27,7 +27,7 @@
 #define MassStorageReset  0xff
 #define GetMaxLun         0xfe
 
-struct usb_msd_cbw {
+struct QEMU_PACKED usb_msd_cbw {
     uint32_t sig;
     uint32_t tag;
     uint32_t data_len;
@@ -636,6 +636,9 @@ static const TypeInfo usb_storage_dev_type_info = {
 
 static void usb_msd_register_types(void)
 {
+    qemu_build_assert(sizeof(struct usb_msd_cbw) == 31);
+    qemu_build_assert(sizeof(struct usb_msd_csw) == 13);
+
     type_register_static(&usb_storage_dev_type_info);
 }
 
-- 
2.47.1


