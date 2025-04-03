Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E65DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gn3-0006eW-6x; Thu, 03 Apr 2025 05:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmz-0006dT-2f
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmt-0007pn-DC
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjr1Q2u2RLDvcfnFH57/OQ7Fwo4fwLlDYV4Pu+xgXqM=;
 b=Eht/60U2JHniKS00/kRF2jUUV9utJGoWZiwa5V84l/7oUivuBWmZAdOGfBxJNNcSJeqR9B
 +3jrIu24nfawy24rOMjj7wULxvxJz4ltcC+4nbnb2x3W5SMXBuy9TP/uWecEzQMTkZd7X/
 sUfd9tfsnztdtkhZawzHnM+u8DNeO0o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-obojwBKaN92hkVFhz4mCBQ-1; Thu, 03 Apr 2025 05:23:00 -0400
X-MC-Unique: obojwBKaN92hkVFhz4mCBQ-1
X-Mimecast-MFC-AGG-ID: obojwBKaN92hkVFhz4mCBQ_1743672179
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so89027266b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672179; x=1744276979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjr1Q2u2RLDvcfnFH57/OQ7Fwo4fwLlDYV4Pu+xgXqM=;
 b=OMzISVz4r73IRzt8iEL3edkbRN2Q+cRMqe97ZovuppavsO6X4h/oXgvQX3KadztjHm
 rseXJcwdYnz9YuyTuC2QYnJm9yxJ5YPaq7G8PESZZLnGqHq/hWgMNKxGDn+wIe6r3SS5
 mKUhErV1Q5oBXQP0ukBtM6Inbky8SzeeHQsJsF9rkS8bAi4V/MDIjpFsOyeV2xuENTdd
 xMOF349kzKJYZEzfUCfPMn5V18XKGVjMsAPRg+jGaI4AGL2bBbs8KntEKBj/yRqRaNTO
 sITDRzWvl4pAkmHY/8o1oV5mjtoJ/Gc/pVvHUAieS8PIswKs2f1fslTYSOkoJVKjGC4Q
 CyPw==
X-Gm-Message-State: AOJu0YzrTE2jvjW0yHf1ndgnC76xyqpOXG7piTzyx5yrulbWYKpAXGjn
 PbybzlMK7I+dceEo7+VDW3tktT7/5mGEYi/OfLjygxj2/DjDtJ06FALGHUwQxh+cRP8YzpQVExT
 4NishScgXvk5ZZP2/pRTase9JAXZoeQj94shWi5vQd4gOGbUYBpYpHhLAkU9wflRat5aJ5MwgJs
 Xt5Au+MWwFzrktyyjM3H2ABqpQqZ8RLyCqRtjB
X-Gm-Gg: ASbGncsCQiAX0+7spzrlR9VAtkkEyGpdvTTXj6u/xtQHWZL1fp1L6IMxmXSp65Rc1Lo
 hHAjTio0VDD8gMgZedtBsWtXg8C58hUL10z0FNsrIeSj+EzIDvAfwneMuxyuh0fqo9ub/RnhNTi
 /3TmGdGQPYT9YdQFfqlHzNI7a8o/ednuESKMi7B293vZuXDm6lQUyD/avxYrNanLaz1s3XFK7H9
 gfry+wSKRZOH5hBtwj6/r6NCl9hb+65vybmNRSju/rqLm4HcFUvtFxMrnqZNGUSlj/4Qhv37BMQ
 jCh//48anhurAraduGb1
X-Received: by 2002:a17:907:7e86:b0:ac2:29c7:8622 with SMTP id
 a640c23a62f3a-ac7bc298e82mr175759666b.54.1743672178856; 
 Thu, 03 Apr 2025 02:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9zz1ORgtnkzVnq5hXFLvRIgGShYlXCFcsBgapUIii48CLk9oHEGKNH2fsvGA7Lr8Dl6KcHw==
X-Received: by 2002:a17:907:7e86:b0:ac2:29c7:8622 with SMTP id
 a640c23a62f3a-ac7bc298e82mr175757066b.54.1743672178386; 
 Thu, 03 Apr 2025 02:22:58 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe9aa65sm61892366b.45.2025.04.03.02.22.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:22:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/i386: tcg: remove subf from SHLD/SHRD expansion
Date: Thu,  3 Apr 2025 11:22:49 +0200
Message-ID: <20250403092251.54441-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403092251.54441-1-pbonzini@redhat.com>
References: <20250403092251.54441-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

It is computing 33-count but 32-count is used in the same TB, so shift
further by one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5529327680d..822dbb2e9ae 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1633,17 +1633,16 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
         } else {
             tcg_gen_shl_tl(cc_src, s->T0, tmp);
 
-            if (ot == MO_16) {
-                /* Only needed if count > 16, for Intel behaviour.  */
-                tcg_gen_subfi_tl(tmp, 33, count);
-                tcg_gen_shr_tl(tmp, s->T1, tmp);
-                tcg_gen_or_tl(cc_src, cc_src, tmp);
-            }
-
             /* mask + 1 - count = mask - tmp = mask ^ tmp */
             tcg_gen_xori_tl(hishift, tmp, mask);
             tcg_gen_shl_tl(s->T0, s->T0, count);
             tcg_gen_shr_tl(s->T1, s->T1, hishift);
+
+            if (ot == MO_16) {
+                /* Only needed if count > 16, for Intel behaviour.  */
+                tcg_gen_shri_tl(tmp, s->T1, 1);
+                tcg_gen_or_tl(cc_src, cc_src, tmp);
+            }
         }
         tcg_gen_movcond_tl(TCG_COND_EQ, s->T1,
                            count, tcg_constant_tl(0),
-- 
2.49.0


