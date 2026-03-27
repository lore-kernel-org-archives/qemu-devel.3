Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67C10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Eh2-0002nX-SD; Fri, 27 Mar 2026 17:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Eh1-0002mz-OM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Eh0-0003ZH-Cz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFuDFxFNBz8vOIyKGhG3CH3xVbSczlhaNd9Na1ywSeg=;
 b=XdLPOvEwosTVwZ9qPP9Wqblh7u0GwpTAyl70GFjfvPKiFoVNXWRVSwSac3ptIBilNQixzG
 po/mtO0CP4u7xg30kFAZDH37DF85alBhpsEKGzknkRHicIHK4sis4Qv38hcK80vonEKqcB
 vgmXKaLxt6uXhTFw2MYdMFbkGWhiW3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-xb1ssxpIN-C3VSlnInsv4g-1; Fri, 27 Mar 2026 17:26:08 -0400
X-MC-Unique: xb1ssxpIN-C3VSlnInsv4g-1
X-Mimecast-MFC-AGG-ID: xb1ssxpIN-C3VSlnInsv4g_1774646767
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853466655dso10106695e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646765; x=1775251565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFuDFxFNBz8vOIyKGhG3CH3xVbSczlhaNd9Na1ywSeg=;
 b=IxmJJrM7LolAv7QTDnSCejukZ+ES7R8UdGyklccecEWiq0cnhYtddC9IxfttIEWzjB
 rs75THSrmUczZ2DckbnOmsxTRwISXKrdUkRJQnj5i0VdUFY3GwEnbilwaWBhOgFjM6mf
 o1x3vn8pWpA/JjeIrpXgwaGM/q6H2RpOw9px7hlDRc0AUyhGUPMui1NPKbc3yaTrVlFf
 FivfCFk/BMtk5JfkMlwvgYU0pT52468b7xDsPNiQ1o174JGwGnO0nFO+KeubJWulZkj1
 YdjSVxPk99pNn3Agbiy4Z+4Itn5lnAhNC3ZxGw0Blt8IIbSMKJ7XsR5XgWo6lFkiCr6O
 WHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646765; x=1775251565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFuDFxFNBz8vOIyKGhG3CH3xVbSczlhaNd9Na1ywSeg=;
 b=OiC6CUdcgQbsjTYUrDMEp1ME+p3fJn7J7xIgdBcy5eAh62w19kEWQzx+qD+X2cePed
 jkZMxotuaTcmWUJxYopZyUDoLxmFOF8LdwSTta2m1/csLs0V3Cn75FJ1lBRYPBZ7uPJo
 d5BiVh9uvYGSgihdZjzJ902I46qm8bx5vURJuhDGQZPGxFGTcJzW5n22f/Awbgv8kl31
 eKcOIJf9wvc1HEOogZGnkXvgTNFJflNHRSfCrfToRPuR11FlkqMdU/6jOF68OtA+zOsV
 pXnBqTOqsbsDWlU6DGS9+8Ej+5C4f33HwFrCAtfAMoGtB1eziN/v8Z2ga2ht3f/pYFv/
 KUJw==
X-Gm-Message-State: AOJu0YygIKBoUnMQmx3cWKqhP7WICdEwqIdsYjJIl+UXDj9O2zW7XF3J
 7uoKpMo4yw8bJfrSDV//AwqdlM4piO4KnuQkOGl/W9z+4TeOr3Q5ViLZ7ulxpjq+k/EBMdd5BuE
 +NzIfAAa8GYLSvzdje5MvOO8kPuDUBVcy6c+JfrwDkekaHH+lb444pr554LPPjCk57dKAKsIH3/
 90/XSJ9Km1GACKUuFNPinPYy9r9F1svz3e/RpLA1XZ
X-Gm-Gg: ATEYQzxVD7TBHNTqFEXwq6emBhhpAymzdAXlCLh5WqtiK3B6/QOf8mAchXr1LFQ8LLg
 5iwKXtWKrmJx5A0muquYJw35VJTlTlnH6aL44KfxlWKoSj5tnnBqGPzKGui1DkomeyimSQ1ohrN
 3UvI4G8es/n1bMv9G7gf8oFhaUkEfd0AJI5Vkr12Kf4oqgbo0AIbEsqqQQBtZUsPrStdVgEApCI
 KxhjpUNpfHa3ppiwy4PJ9Ml/JgBNq00cAtH/EbjPt0kTJ0iKpBiuRG4DPl2EfHlGna4SEfCRGOD
 i4gqHGB4TzpK2VLFWmBZ7u7IQkuO67R4ZMOSANBBy2oZal6aQJl16Z7FuoO4grg8kNqFweouC5s
 dfW3hUCRBuv9fql9mtZXzDyae0f+LyeEyC0dEJhYBFkDlZjwY8waclUIOBGQWvKM1BN9fApzdDj
 Eznfa5Fk5qfvsKyLoXuxU5vd9H
X-Received: by 2002:a05:600c:81c5:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48727e90ec7mr60750035e9.15.1774646764876; 
 Fri, 27 Mar 2026 14:26:04 -0700 (PDT)
X-Received: by 2002:a05:600c:81c5:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48727e90ec7mr60749765e9.15.1774646764337; 
 Fri, 27 Mar 2026 14:26:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4873068858bsm6251665e9.9.2026.03.27.14.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PATCH 02/16] lsi53c895a: do not do anything else is a reset is
 requested by writing ISTAT0
Date: Fri, 27 Mar 2026 22:25:33 +0100
Message-ID: <20260327212547.460420-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
if the requests in the value written to ISTAT0.

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


