Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DFC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcA-0005Hd-1D; Wed, 23 Apr 2025 05:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbi-0004Nn-6e
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbg-0008Lc-MY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBSmWHtRLE+5d4wSOyJC5GTKnwxPIKfO6ljx7dHaimI=;
 b=F2sG6lSFym4ed/jO8UKiYIpluBsX9NpfN588mWWr0azWJuaVyfxHg+llEPdoTa4hq/0At7
 HZehadMhWoGPqyDD3ysyAwnuXwp4gVMnngchAiZZuT7T0f8Gn3NoVtEXDFA+PMnCKrBo2C
 653VCWTupm68mFYgHyYtxvtL7ROgAmA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AI6yq_G5Ot-9h8M1vxEC6Q-1; Wed, 23 Apr 2025 05:41:23 -0400
X-MC-Unique: AI6yq_G5Ot-9h8M1vxEC6Q-1
X-Mimecast-MFC-AGG-ID: AI6yq_G5Ot-9h8M1vxEC6Q_1745401282
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so329262066b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401281; x=1746006081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBSmWHtRLE+5d4wSOyJC5GTKnwxPIKfO6ljx7dHaimI=;
 b=YAsTD18JqHh/12gB6vwilT77QpE4QfAagroVhoyRzyOAcKKudXGGw6hugNaqJYOpFx
 QS0YzO5kSPBhXYn04JFOi9B8bnIFiayBzTW+xS139hlJvv/D25IZtf9DvcM04XUgpZom
 LyEsETKzIK/qUPH37641aBF4ni0kTbqaNZWBEchJK+8DnalqnYpwjhAN2LSadjtUOYr/
 sbK1/XePIHK2z1mK2KCMgnxH0aWUs30aw38ahYHT38PW2oHkisGa7/lBAeV6F6EUqFXN
 kEsfnJfic1EdBazERrwxEPkUL0VPhGWFZXJhLhrEGa+5Ulq4D4q0O0UYOzfuHvfcUN3/
 6X7w==
X-Gm-Message-State: AOJu0YykOA0qTwsmwFORDacueKze+KL83JDVCBJ9o1SpK5tK6rNy9ump
 CWvSJZMDGlV6WXLKA/bG2OZRMjf5vQoi6uunF+SeeYrz+oak2VsQrrT6SqSn3UxDvovBuHA03vJ
 rGbHeviFR2xUxVPwhn87b9bCe7zFWyrHyawWLLTA47OKPatVufsxLYRTOqvks7Un/K690BNXXSe
 1xAxF4jv+lq/3jJt5UMB1e9CcwtW+5cw9Q0ABD
X-Gm-Gg: ASbGnctSd2afNNCbdJ402EYZMZoSgDqijEfi0WPwvScuWNXYouL6ol/LIa1DG5peTh6
 efsaSDht9kBMWnBzHoCv4bVIq9+sVVDeBOg2t9ivyXKgkVOvUQgqPO7Tp+DGOjbwAj2cAVtiXzd
 RyBKQJFtoyg1al3EUrLPr6UMt/dw0Gc3Z4m7L/VS19yoafP5DZ2AWDji2xKTKytgUj4Vnqqtjl+
 qmNOxQOYqTLDkakbXiBRjzS/iwOm6n3Ws7p6TBEiMvh4+lF4TuJB6EQkSKQfkht9/fY4rphwDmH
 9vwsVKt1EFnxEkEY
X-Received: by 2002:a17:907:3e9c:b0:ac3:49f0:4d10 with SMTP id
 a640c23a62f3a-acb74d65b57mr1764243066b.38.1745401281001; 
 Wed, 23 Apr 2025 02:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjc5MyRPCXic4HwK1xmfPdsifCCkihTC1YAzo8LOifCfS2IWWjLhopvFV72AoZGNBd47LMGg==
X-Received: by 2002:a17:907:3e9c:b0:ac3:49f0:4d10 with SMTP id
 a640c23a62f3a-acb74d65b57mr1764241466b.38.1745401280521; 
 Wed, 23 Apr 2025 02:41:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec42adfsm764159066b.42.2025.04.23.02.41.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] target/i386: tcg: remove subf from SHLD/SHRD expansion
Date: Wed, 23 Apr 2025 11:40:37 +0200
Message-ID: <20250423094105.40692-8-pbonzini@redhat.com>
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

It is computing 33-count but 32-count had just been used, so just shift
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


