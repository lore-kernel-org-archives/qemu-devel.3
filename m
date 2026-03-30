Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC4F10D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BA4-0004mN-G0; Mon, 30 Mar 2026 07:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8u-0003bn-J8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8s-0005x7-56
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sJu2rHkLQmtf44os66TEn4JFKTj0rKBgEnPKUk/PT8=;
 b=BeZokOkNWkWHELZWLfVcpbi9JZsg2oCq8Ltyy9ZOOtq3+HPQMmff62Gzq5xzEzDryL6ZFM
 JI2NGgPZ1QlFatowOkfUYiqO7eZDj9MR0IaUDUJ4kXX0sznno6/yvGdU7XBBNfZ9Vnr250
 6Rk+lYSFVS3GXUc+DqXH4rSqLX0Rymw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-4LS_5xVQPNSfAeTGx6issA-1; Mon, 30 Mar 2026 07:50:42 -0400
X-MC-Unique: 4LS_5xVQPNSfAeTGx6issA-1
X-Mimecast-MFC-AGG-ID: 4LS_5xVQPNSfAeTGx6issA_1774871441
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43cffbe261eso640398f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871440; x=1775476240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sJu2rHkLQmtf44os66TEn4JFKTj0rKBgEnPKUk/PT8=;
 b=qnnJPLfpJhjSD4LtO+ZEG+erqNEhqysv6HKKsvUwxzXjuQ3/2q9T09+SlgXG1h+bGp
 CUS4yPhT6N/sf0gm9yCs/PpW8Sf3KKLpOqukz15bUHDSeij8ZjmWLrF00pZ4nS8A0Xrt
 s06pr/xmr14IttVMFsXQohapBUZhD/Jm3a81dXnPtJ1i0wSnTNS9kh+yaw5YuBRgT1tR
 nszE4C7m9w2pLtDfPyAETIHqV0g44SYJz72jxL5ZgfgPQCCQIyFU8GzRFy1IgfxLcIta
 Ro1A1n6IuJ6ZiUaweV679KW+25jKfGXzPV23+4cbLgkRxCfdvh7DzOegubl/4eW854iW
 WnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871440; x=1775476240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+sJu2rHkLQmtf44os66TEn4JFKTj0rKBgEnPKUk/PT8=;
 b=cDoTgFcQIT29tdOO2ufJHI+vu3lNf0IzmmJ3t/zd9nOKkArP8LD4tRXthG/i8OrEya
 atMBbVtdL1XwKuCBibwEDgIM4rVxARBCjRKA6nDmsg9zn2M6Ixzp7vvhZRZL/eUmcJqu
 M5CskKGIeG24xE8YIQOyyEt9h2kOfCpwMG722QQAG7kS9zzuEMDWkQEp6d6O1beOaLW8
 cGS920Ms4RXh3RLDE8y0wJmPKga9fTa0h+xa6jm5Nwow9S5vPJXnxr/xwnsdYC4jZSEt
 XWcFTgcOpoKfRrAbmlhIeIjHDn94RX8uzqS7LioHl1PcqcGIx6Bdy5seVCN3r6fudfSc
 y4LQ==
X-Gm-Message-State: AOJu0Yw2c85UWll2s0dqyihTPTPAFBVbmgVWbsBiFbH6gRRVwTkYYAnf
 5drEmnaQSb9UQsmbalbRuhq244iQ89bb8ML6tpDhgPtBLC0swOTFRSECIRPg3gmPi9PYYhtj1p+
 tWI6g1iSqV0OptIXaW2uxT9PuSb+y1+/8RDfYLWXbip1YJbVpfh4m0kp1+LIzoLRkMtoe+AN8Ty
 0EsegGKKtxybYk31GcwS1CAU3iOM/600q4AO1eTAX+
X-Gm-Gg: ATEYQzyUPA3sxfp5KsL2QTYF8I2WhmeMEd/Qr3bGMV7x6AYyQ1p9XvjLtb+CB62GwOW
 slBTrXh1ouw+oR81/SCodgdBJg3kfueqq1d+mAvc4GuDeQ0hwmOq+j1Cdue45UJ/2AxghVd86+m
 kPRWezVOoCTwBWqQmJbnB1cs0n23SWt2HnZKzGpuUytQ4gigkEONnuJCilFqRQIv3ZvTSekOtwP
 4gYfZ5Xrzfbf92uSAlB64Dtsphr73t3qzczg2S0N6NPnnSVD5coO02gZtzA6JRJMmh89pNxxmQ3
 7uuJEevjnVj1DTb1ijmtR9M94EIgal2tSWKFlpqDRLrM5xd55I0mVSrBg4szw9c/FacMB3qObTg
 8qFERxOsQ+PCnu25oFRKf7H7hct4CGJ1XUGm0gSHKI3w8FJIrM6Redndbfk4f/Q3QGO/S1aXLME
 q0qy2ZMARs0JprGw/4PCCeuXqP
X-Received: by 2002:a05:6000:26c2:b0:43b:4989:869d with SMTP id
 ffacd0b85a97d-43b9ea4a46dmr19121633f8f.33.1774871439824; 
 Mon, 30 Mar 2026 04:50:39 -0700 (PDT)
X-Received: by 2002:a05:6000:26c2:b0:43b:4989:869d with SMTP id
 ffacd0b85a97d-43b9ea4a46dmr19121592f8f.33.1774871439364; 
 Mon, 30 Mar 2026 04:50:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2463dc2sm18578176f8f.23.2026.03.30.04.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 08/12] lsi53c895a: do not do anything else if a reset is
 requested by writing ISTAT0
Date: Mon, 30 Mar 2026 13:50:12 +0200
Message-ID: <20260330115017.256211-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If the device is reset, anything that is done before will not really
be visible.  So do the reset and exit immediately if that is one
of the requests in the value written to ISTAT0.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 90643b26ab8..81b4f93f4d3 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1949,6 +1949,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
     CASE_SET_REG32(dsa, 0x10)
     case 0x14: /* ISTAT0 */
         s->istat0 = (s->istat0 & 0x0f) | (val & 0xf0);
+        if (val & LSI_ISTAT0_SRST) {
+            device_cold_reset(DEVICE(s));
+            return;
+        }
         if (val & LSI_ISTAT0_ABRT) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_ABRT);
         }
@@ -1962,9 +1966,6 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
             s->dsp = s->dnad;
             lsi_execute_script(s);
         }
-        if (val & LSI_ISTAT0_SRST) {
-            device_cold_reset(DEVICE(s));
-        }
         break;
     case 0x16: /* MBOX0 */
         s->mbox0 = val;
-- 
2.53.0


