Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67929C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfF-0001fH-PR; Wed, 09 Sep 2026 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfD-0001em-3D
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfB-0002qo-G9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh2o8PBloE0aQ+zk48uHsbdRMAdrWo9YGkNnH8a5/y8=;
 b=JIBWVZMgXU4XzD5eXg4P0eKIA8y6QmLYIazEIzPOwXDG83u4DuA4WtPJC3T5mO0jLrq0BJ
 DWGXfBqEeb4/cJ+zxjJgrm6jrnSTScfYcsYWuMluyALRr4EF6ORhmRVZY228f0d/itmjwg
 REciua42a8WlA3/2NikMFKPkHBiBCSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-BM7ysx6LPla5xMCxV2svZg-1; Wed, 09 Sep 2026 11:56:39 -0400
X-MC-Unique: BM7ysx6LPla5xMCxV2svZg-1
X-Mimecast-MFC-AGG-ID: BM7ysx6LPla5xMCxV2svZg_1788969398
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48436a5fb42so3380164f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969398; x=1789574198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eh2o8PBloE0aQ+zk48uHsbdRMAdrWo9YGkNnH8a5/y8=;
 b=irfIdcMIT9t9FYjRdCReX7WklK2VQRmVtmIGzFacI06sLOSNAG3oZ8OYJvOi9wkVYS
 FLwaBi/czK0jOfN7qbhnKBGs6R+/58mPGDeMdoQqrYwP64hX+UfIoVg8KqfMK/OA3Iqs
 ajoyGsMlM5RFft6KHFoJxYj37fUJFgU4nUAuOTi5Md6EtE0DWNf39m+mV01BXhEsoCbR
 ld1kLFO/fHPdPCXX+H2S479rIRhuzvXUr7mE9wAY1tCqCrLX+uzBIM6idlQu8zKD92fg
 Xg8/knP5SRAcSqka74H7+o9OlI0gxhA0dOiT9K1PmkZyQINKudIs7MNS0OeZyqbbJV4d
 sWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969398; x=1789574198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eh2o8PBloE0aQ+zk48uHsbdRMAdrWo9YGkNnH8a5/y8=;
 b=iBXzvEZSi/wwjwZp/SZHR5k5vaAVTeYpzBAEP51LPBBej46cEahl3qkWCuCvF12FJW
 YoZoEc5ChtUxq1CGEsKuHXrDZWZVpPgcP2Mz+D9gEpMkQCGA4shDdK6wMhIx0SH/8vjg
 l+SxG8MY4b8Db0/I3d17IbTBzsb8+1vRFzpyLwgLZOo9HslnIJ4H1OfFKHmEGj6fMA2V
 86opxqwZzSsm582e1Yt9dcVORH8muMXorBcsYxBy73mOCJMC+6HqmZ+dj9gGIkq3MvkT
 fsFFEekYLPie3qqrIBMMbhZe6wF039UQ83oqF6VuPOsjmnzSiOV7AZ0Zw+P0o1tZot8t
 jkUQ==
X-Gm-Message-State: AFuF++ktpgahfeDg4tkq06PbeEnC2pU6fVviHY+NcZOnhmm/c3/qJJGw
 McLhYolzQhFmCgX3hTCsJSuLYIKmATOM7I/8c8tu9YgHcBJMETEgqHhF92V6PqkkDxWCUQq2Zae
 gt9OlTG5OQnhSsti9Ef5CX2amfwihDb5/68zYeAH1BWptDxpzwAfn57lz8cnLh1XIJCrm7iVLAo
 KcL2nffV5cSAYwpmQfb+bjM8pCw1bLga5bsrLPj1uH
X-Gm-Gg: AYBFou3KVil8FOLlQymGbgArqd8XTr0Thg6DK2Fv+iBbefwX5WOtqrB7DHsW5+/iRGk
 JSXFm4cP9YYagsz1Eza8rPkGIQ6d9uOqTtoHwMZAIR6/CM04VocNs9jWoTJNVw9Ij9n9A7PEY7R
 /lenjBeJ46C4vDcHN3P1cmRETI9Oyfwd8uEMI6MYQKIGfPUxAYdRXigoPXdfUjYePCDmojPqkBq
 UNJn8WaFYFaJmfd2eBG3a0IrpkKrOIxa2+gAeOy3zyBRjXV0cTQj7aXvg+EAl9y0g5RagBLlfkh
 /kTUUbw5i0sby9ao+/egH0ZfkFORg0Wkd3iPgPTE0NU3L22eg64DvS3M8bAfCODJ/puyLpAjK1f
 hx4uUqHRQEQEICr4eJVFfCJUJo3+kkDZOZXrqLS2I4VODO5xm8dcQ3gr+lg2+SkiduLkPC08gja
 wrj8u6
X-Received: by 2002:a05:6000:186a:b0:485:8fe2:eda1 with SMTP id
 ffacd0b85a97d-4858fe2eedcmr29628673f8f.17.1788969397806; 
 Wed, 09 Sep 2026 08:56:37 -0700 (PDT)
X-Received: by 2002:a05:6000:186a:b0:485:8fe2:eda1 with SMTP id
 ffacd0b85a97d-4858fe2eedcmr29628647f8f.17.1788969397423; 
 Wed, 09 Sep 2026 08:56:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm43579129f8f.27.2026.09.09.08.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 04/12] target/i386: Update FPU tag word for FSTP
Date: Wed,  9 Sep 2026 17:56:16 +0200
Message-ID: <20260909155624.1082893-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Simon Scherer <scherer.simon89@gmail.com>

FSTP ST(i) copies the value in ST(0) into ST(i) and then pops the
register stack. ST(i) should end up marked valid in the FPU tag word
and the old ST(0) should end up marked empty.

helper_fmov_STN_ST0() copies the value into ST(i) but never touches
its tag. So if ST(i) happened to be tagged empty beforehand, it is
still wrongly tagged empty afterwards.

Mark the destination tag to valid in helper_fmov_STN_ST0().
This also fixes FST ST(i), which shares the same helper.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902120419.212855-2-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index df16c54c208..f42448ab206 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -510,6 +510,7 @@ void helper_fmov_ST0_STN(CPUX86State *env, int st_index)
 void helper_fmov_STN_ST0(CPUX86State *env, int st_index)
 {
     ST(st_index) = ST0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
 void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
-- 
2.55.0


