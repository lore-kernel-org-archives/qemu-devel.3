Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA25C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wba-000494-J9; Wed, 23 Apr 2025 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbT-000441-PS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbS-0008JT-0S
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I94wcuIjpCSwv4K7/E+7/Tfezi1orTnp1Ih//GpLUwA=;
 b=RNMgOF/gcrkrVo7mFjBLnj8TWhREWWvZt0Q6PBIh7H8gS8repIHufLPbQNWMvF/L9NNkX5
 EkDdbiQXFsxAQdzipU/2CMHS9f9gLIUzbHczH9LC2nu6CY+Ppxk0C6QNNAV+ZYGI1lCcyu
 aYS7AfKvzQo+DhDFPNZiSdSDmqZT9pc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-cCFw5HMIMx2zoA9ssQbTog-1; Wed, 23 Apr 2025 05:41:10 -0400
X-MC-Unique: cCFw5HMIMx2zoA9ssQbTog-1
X-Mimecast-MFC-AGG-ID: cCFw5HMIMx2zoA9ssQbTog_1745401270
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac297c7a0c2so391378966b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401269; x=1746006069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I94wcuIjpCSwv4K7/E+7/Tfezi1orTnp1Ih//GpLUwA=;
 b=PwBtj4GcuYXVShGfbaC3J2jWIdX+a955+5Ho++YZ8MrsVqOovOQGE90+cvGgZ8FuaG
 N8u97FRTMRHmglao7wkyfSaeNPn2gzhhIBiSbsEspCWzKh8u+sCBj3l4fo22CIdIWgvc
 5YNOKOG+nV391/TFtNAmj21R3uFH6Hd3l9PA/XbOBrOEDTNd5yD/WO+S1mBZLuerLdsh
 s119miQGOzJt/BasjFrUqvxyJGHcfTjtl7GP7s3VIxF41yjBTf0l5fGAVjX3zKHsngTv
 zQIs3kp0/uOB06P2dH0DC8f3awZebJznakGlVWnD2YLuTj38shxUfmXqNIwwGt4N9KA4
 jDsw==
X-Gm-Message-State: AOJu0YynKy1tmA2oqFwqlUkp2T0bg2PRdvMKiyJFl4HQRQLny/wLNIRd
 /i+SGz8y81GKilyU8F/vakMhm54kixHgXYiWkBo+h/MMJMEquNdfLz6rq5+uuj552VNQMj4G+S+
 35gTMbTNr6m+bN14T8+5T5FwZMbV9yejiWUZaCAqteApVvieBb/aA2/8zJ/XtIGt+UKGEu1meO9
 YycG6KCO46A6HgDa3ryAHxzcmPEf0pG03jwUdo
X-Gm-Gg: ASbGnctP6QdfWokZ1du04qidmLA1mG6R/J1ULkFnXnGsD2olRaKd0XfvrZUzkUlf+dD
 IQZSu9OYMOQfuz9kE/4tZguI+TNdbpkhDox2Di1gzDlGqx6Hot7JWVYw1zIrriru8Pbkbm3K0ds
 Y7hk05i3orhHSOqIOMegMmAU1Nx0i8kR2lAacjywC2L3OVaQNzO6VY1I+NfhXQrIvCEHNUaf0+b
 fix3EWO//q8vJS/qKPvT2sKcImlAAvT0Y9QBprenA9PVMFQ1bYFuwWmXPniciOl6cEDwv/mRfzS
 Y+Df5jonkGVq/HjM
X-Received: by 2002:a17:907:2ce4:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-acb74ad93b8mr1571267766b.7.1745401269140; 
 Wed, 23 Apr 2025 02:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ4Vu8wGobWhPIPJ4+gO/prXDfemcKA5RiFSyJK0+kpo8vHE2AoZIMMIWDO4XUSJ/IhT6daw==
X-Received: by 2002:a17:907:2ce4:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-acb74ad93b8mr1571265766b.7.1745401268632; 
 Wed, 23 Apr 2025 02:41:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec047b3sm773650966b.28.2025.04.23.02.41.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/34] scsi: add conversion from ENODEV to sense
Date: Wed, 23 Apr 2025 11:40:31 +0200
Message-ID: <20250423094105.40692-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is mostly for completeness; I noticed it because ENODEV is used internally
within scsi-disk.c, but when scsi_sense_from_errno(ENODEV) is called the resulting
sense is never used and instead scsi_sense_from_host_status() is called later
by scsi_req_complete_failed().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index 357b0366716..545956f4f95 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -587,20 +587,27 @@ int scsi_sense_from_errno(int errno_value, SCSISense *sense)
         return GOOD;
     case EDOM:
         return TASK_SET_FULL;
+#if ENODEV != ENOMEDIUM
+    case ENODEV:
+        /*
+         * Some of the BSDs have ENODEV and ENOMEDIUM as synonyms.  For
+         * everyone else, give a more severe sense code for ENODEV.
+         */
+#endif
 #ifdef CONFIG_LINUX
         /* These errno mapping are specific to Linux.  For more information:
          * - scsi_check_sense and scsi_decide_disposition in drivers/scsi/scsi_error.c
          * - scsi_result_to_blk_status in drivers/scsi/scsi_lib.c
          * - blk_errors[] in block/blk-core.c
          */
+    case EREMOTEIO:
+        *sense = SENSE_CODE(TARGET_FAILURE);
+        return CHECK_CONDITION;
     case EBADE:
         return RESERVATION_CONFLICT;
     case ENODATA:
         *sense = SENSE_CODE(READ_ERROR);
         return CHECK_CONDITION;
-    case EREMOTEIO:
-        *sense = SENSE_CODE(TARGET_FAILURE);
-        return CHECK_CONDITION;
 #endif
     case ENOMEDIUM:
         *sense = SENSE_CODE(NO_MEDIUM);
-- 
2.49.0


