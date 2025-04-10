Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF08C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2u3m-0001ag-9b; Thu, 10 Apr 2025 11:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2u3g-0001aJ-Jo
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2u3f-0000PQ-5D
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744299793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WIe8rr7qXA9X/L7zyLl4Q1mOQr4Z9cUTC0kxgIoToes=;
 b=BgXK/1PXXrd5g0J2SJNHn5VW0NHH7b96bKxs0J2ws5O2HBhXQqKGc4gNnGdj5XRM/408kO
 +n8yKw9hApW6s/3f4Qrsg4ZYB4s/pRu2gMP5r8Ire70zJvFmyA7nrVbPQnZ1fraN1KsVBB
 QcEQsV8TbzOK1X6Yv+LCgkO95qTTKFQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-m6lD1BCQOM-YlGdmWoXYRg-1; Thu, 10 Apr 2025 11:43:12 -0400
X-MC-Unique: m6lD1BCQOM-YlGdmWoXYRg-1
X-Mimecast-MFC-AGG-ID: m6lD1BCQOM-YlGdmWoXYRg_1744299791
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e72c1bf151so1058147a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 08:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744299791; x=1744904591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WIe8rr7qXA9X/L7zyLl4Q1mOQr4Z9cUTC0kxgIoToes=;
 b=Hc+3e91A+0ufGRNccmr1wHr7PINDkiKHK8Ydtjote/qSHThQ6kqKcHqgjf2jmMlEZr
 V0AXz1y3vq3/qoV/d1soGxmcwEFQXm7gUwnu45QCu4+DIXv59/5ITO/ey8AlSrWcNPTA
 0sFLFcdgDnq41a8A3nGVGL2bGLXo+P+vCoyIBfUjw16I+fieTSMqpWNvjyEVRIVQffF3
 XgGUs/QYu7HJEMpImku6TleqR3P0Spysb2AeFZielRS6zc3p7CJ78M19yOSqtuqUb5+k
 /dCH8wr+hGSbDtqm3DIoUOm55hpHjATEgPa1LLxc2TpVf6oCQgqIG5ffEEgrCYzcrxYU
 kcWw==
X-Gm-Message-State: AOJu0YzCcz0TCX1GRkOseRg8ysa4hMHB3y+U2RMWYxGAtQGc5h7e4vNZ
 erosEGvnC8pXDjsqcLWngRmusp5udm9n0pwGTRCR8mBRx6Bk1PoE65Osbo52xn35WUgESaNJgiT
 ZMnF6I0VBHVReyIfdQW/BiMAfiZWchaiXP/OoapMFbc5OXGvc3KaXlpLzhhIODVHBmtQDgUgurS
 oItIU1tvYSeIJoYXeQ0HAkYdZOXmrKKP0u1OHi
X-Gm-Gg: ASbGnctQ1TmcFTLK8qkxkgQE26gZF0JWup6dqkR2NjpvQrOyLlxAXYI/Ue+d8/McYJV
 8hGiMJY1onnuLmfYefQ2sbExLl2rak6DuYjTE0aJ19lZf48DCYQvge+hF1Q69dMq7WnnhUetjsB
 7nWowNuE3mho1hT2oN2R2sDVzf0zRjmSEITf1jig7p8+mCwy6DgKp7zERYRev8oUMFaSy7VFFfT
 jjVSoFmtPeYO8+U078BLYT+r3Y5cF2WCmqbpHcU6CdqsK9+Pb5TKpftgsqZzoTvl1wNjUDnN83J
 tMXipeWbjX2CZdmsM0I4ucpVhEJYUP/hb1ePjpOvilcVQbI=
X-Received: by 2002:a05:6402:2106:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-5f32932c6b1mr2681402a12.29.1744299790921; 
 Thu, 10 Apr 2025 08:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBC6NDw99ljyq+Q2piO0/mjadsh+zyhCMppWzoVK9GePcp0knfJK4mZW3YPYUlgPOI55+ywA==
X-Received: by 2002:a05:6402:2106:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-5f32932c6b1mr2681380a12.29.1744299790514; 
 Thu, 10 Apr 2025 08:43:10 -0700 (PDT)
Received: from [192.168.122.1] (93-33-70-196.ip43.fastwebnet.it.
 [93.33.70.196]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbd34b8csm2460588a12.65.2025.04.10.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:43:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH] scsi: add conversion from ENODEV to sense
Date: Thu, 10 Apr 2025 17:43:07 +0200
Message-ID: <20250410154307.589318-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 scsi/utils.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index 357b0366716..c6d9e04cb19 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -587,20 +587,21 @@ int scsi_sense_from_errno(int errno_value, SCSISense *sense)
         return GOOD;
     case EDOM:
         return TASK_SET_FULL;
+    case ENODEV:
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


