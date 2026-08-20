Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E26C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5y0-0003fW-V0; Thu, 20 Aug 2026 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xy-0003eT-Is
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xw-0005KR-FU
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S7x7mnliwyjD2cUQSXzS+dP8lkV219BxBtpL7Cvczc=;
 b=crhHCG9w0vqkACpWWSJ/5MtSkX4Nll58SbZyonsva4+xQrfwij256IbwPJYrFOTzTrIJjV
 OzzGbZLvuDKfI/O+/fcbvD7OuJ8IJthoGt92QfDDdksPBEpvuSirWVL6+yGC2Xe6v9rCAS
 6E0LC0zPpWq2qOMRU6g9NkSNQmXO8+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-2zrV4qa9N5mllL9uygEbZQ-1; Thu, 20 Aug 2026 12:50:04 -0400
X-MC-Unique: 2zrV4qa9N5mllL9uygEbZQ-1
X-Mimecast-MFC-AGG-ID: 2zrV4qa9N5mllL9uygEbZQ_1787244604
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f4601af62so50344f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244603; x=1787849403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6S7x7mnliwyjD2cUQSXzS+dP8lkV219BxBtpL7Cvczc=;
 b=M5T6eTRHQOVrXM7dUV3FSEPkVx+c3iK2FeaOWzjIyGTMQIpplyj1ySvdOVbDpdqiNt
 spWnoyLpdkZyyY/Q8beSBOQ6v4bF6lLzV4/uYW9ROpTFG7E7tGKIgETPgvvuvhw3Ji5X
 oI6jZyW/+FnigByh2/o5HK8Cfrw3IhBQKtu2uZQQd2MHf1NJGt3knCaIdfJjGeFj0HOO
 iNQZF0Zpu/3DUMHIxMayxD/iMt/Tss7XYlPB2mM/6pzZO+OzUWiZJCt4eCxfObq+/4/K
 wHPXAXuHTWcykx0FIf1v2NqPePtcPwb3WF8tDhNsgDpAP1jdCT/L4ZI6YzMG4EJzi9oI
 0Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244603; x=1787849403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6S7x7mnliwyjD2cUQSXzS+dP8lkV219BxBtpL7Cvczc=;
 b=SaCQVt8NT7MUUWsOD03LwS9ZIOAHwOKjdHChjZ0WpebRch0xmxu7HRKP8hF5EkrDTo
 0g3I8HW6VL5dmj1vpDdMfWsHtz0VnoS4iDNUU9NNtZx4mGhLKrvEhYXxiEHQPitGYugc
 qm2+I+tbtyfH1mIi7bdsiXf8iYaCkBh3Ukqi0mQryMLSfjufn3olmXMh5KPbb+tyUS0O
 gS3YYdk/K7oUrt6Ua9+5TlHEjx6amm4CbgW4j99WMbBUcN/kXqFwLaxeGmJZO35xq3lV
 Nygs6KsQjy0wrAsBW/SdKyqVsBDYazOfQ9xf1+Y2+amBxKMuVxFrH92L7fBmJMR2ElMJ
 4+lw==
X-Gm-Message-State: AFuF++k85mnRaGvhSK9HFL6nxu2HBG/g3rbhI7BVupuv2Nu/MglbrxHU
 CfrkMvy3HrAvxxF833uQtdDdqYcAjrURtQRywS0t1nDOjicvZLwEfCT2EjKtcAYFTWkQqdNLHSY
 t3kjTLcgBHKgerPDVOfkU7vBQVVxLC1ZyJF++JYRPGh3SoNAQ/FbjXBAc3mQQohr9dZ4Tis20tv
 gGDI6hBZG3Sk9qXxyyX0TTsEAKuEcU1pymSk/6DTNL
X-Gm-Gg: AR+sD103JHuWG8hOBIQVAhek++XY8rxcKc9ZKn4xZ3NaQ13bE4vrA8gcGy31AwMrl/t
 t189rNKaNz3vUe9X1CeeGZuHKuA7SGYRTqjmz28VYvfVOtuQUxKjCQIw/SdESY1Avf1INLutciD
 vQMLKWFEKFnAqzN9ISYaB79WjfxGOh1FeDKj+HRApIz0Ex31hm6aQabkdhzMYCif/fJD6BXS1SK
 PdLntEG/u+vIDm3DWgfmqCBA6BZfaLTGEikyGl0U17vqF0oOOwaKXN/0Pn5oerMBwXHDK+d1AUC
 7TwYyDYGGULmczN8ftkhsIqZMf6q/BGkZj7VNDinfjNQ9D2YvIptOswAzA0v5JoICQxQfZk0H12
 k7r9eNn2i6Vfq7xJx0QQzW24PdqpjNIQFM96N/R723wVviFGga7mQ0vbHfazMz5q6havxP0FuC9
 gjyu4=
X-Received: by 2002:a05:6000:1449:b0:47f:8183:e9b8 with SMTP id
 ffacd0b85a97d-482b1feeb3dmr23105698f8f.22.1787244603515; 
 Thu, 20 Aug 2026 09:50:03 -0700 (PDT)
X-Received: by 2002:a05:6000:1449:b0:47f:8183:e9b8 with SMTP id
 ffacd0b85a97d-482b1feeb3dmr23105619f8f.22.1787244603057; 
 Thu, 20 Aug 2026 09:50:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c78sm13877367f8f.2.2026.08.20.09.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 01/53] target/i386: Clear OF, SF, and AF for fcomi/fucomi
Date: Thu, 20 Aug 2026 18:49:04 +0200
Message-ID: <20260820164957.1895963-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Simon Scherer <scherer.simon89@gmail.com>

helper_fcomi_ST0_FT0() and helper_fucomi_ST0_FT0() only cleared
CC_Z, CC_P, and CC_C before merging in the comparison result,
leaving CC_O, CC_S, and CC_A untouched from whatever they were
set to beforehand.

The Intel SDM documents FCOMI/FCOMIP/FUCOMI/FUCOMIP as setting OF,
SF, and AF to 0 unconditionally. The AMD manual doesn't mention them
at all. However, testing on multiple real Intel and AMD systems confirms
all three are unconditionally cleared regardless of the comparison
result or their prior value.

Since fcomi_ccval[] only ever contains CC_C, CC_Z, 0, or CC_Z|CC_P|CC_C,
and CC_O|CC_S|CC_Z|CC_A|CC_P|CC_C already covers every flag bit, CC_SRC
can be assigned from fcomi_ccval[ret + 1] directly instead of ORing it
into a masked cpu_cc_compute_all() result.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4133
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260807062831.19618-1-scherer.simon89@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 978eb1411b4..b812125efa1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -550,12 +550,11 @@ static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
@@ -563,12 +562,11 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
-- 
2.55.0


