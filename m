Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DFFCA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3F-00082u-VH; Mon, 28 Sep 2026 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1W-0005ms-At
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1T-0004SO-E7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUbWkmVdUsblLJCrqB5DYTVHrugC5pYz+V1oMZNK/rg=;
 b=f10VK3xb0na21YZjwMjtVfDcAO61uDxfKn2icvSpSE4bRCdunfXdL+u741ykMxckzki5Xi
 oi4kjEgffiKDatZKGZZF4k43pf022b356Jl9+AxPlGOvNiF6wds6a0NabFXVstEYdL8Fk+
 ftyTnFyKuKv0pkRFaF4auiaa3WWS1Nw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-J1cDGPRAM7Oj5BkU9A3O6A-1; Mon, 28 Sep 2026 09:03:57 -0400
X-MC-Unique: J1cDGPRAM7Oj5BkU9A3O6A-1
X-Mimecast-MFC-AGG-ID: J1cDGPRAM7Oj5BkU9A3O6A_1790600636
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c210c66672eso431246866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600636; x=1791205436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HUbWkmVdUsblLJCrqB5DYTVHrugC5pYz+V1oMZNK/rg=;
 b=LuZ+YjIUp5S2gOnsjiNnJyJhc6c9NMa4G9H8ROs9fdyF5t9+4pGFcyvXAL9LwdThoO
 QwVAPU6aYt+PcHveZ7lGQ7ekUjnk6wnLYwbsOU67MgwTEOh9xeaBQ7PjGNHogGJ9XqNN
 ZskFg/m6rcZlVSwGP/L9eUwsziTnq1TwwVOIiscRkIo0wohEPrm2sMlUNMIAYLZ5CIcj
 bzdoRh5ENMp+hhagta3pEMEk66He3BVn36Eta40CYvw9ph9ecFJDklSktSc96WPeXy4V
 isvCYhEQvqrAg3Lua3PfeIVox+0xLyXhXkjmWZG0CvJh/L2ybiZLdK0ZhmZSCL5JR+FP
 265Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600636; x=1791205436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HUbWkmVdUsblLJCrqB5DYTVHrugC5pYz+V1oMZNK/rg=;
 b=cGarIz3yhzZHQnWSwXdxj0Xp3nBHBzDB768XcWrwaXOqAh8eW9U5s3sg4WpxmYAQvw
 74XUeXL6EPrSPz8EDjpy59C9ARent1e0UGQMOzRyO/6MhHDEQELkHqh7z26rWxf08Fn2
 i9h4EzOeSm7CTLrXeOPpD6XBlIvciJHDVXRoqvoza3jSF1hjqaoDVEl3fQTqJbrDZwkI
 mxUB8bamLGMRrPA2HaiAXidDGkWIkjMxQAhibUSIeptMG5iY+vvDSzaUyk3JJa0gh6B5
 EToDZuZ2lUMxsyI9pY2k9+hyLqXvGTFNif6Fa1gUpRgNpdl53e+fj8LPQIJDVDxwUU69
 RtnQ==
X-Gm-Message-State: AFuF++nTU24VZnOm+SQ2pGSnl/lvgoUyyc4hUXASj6ivDaRB1mG2jjUZ
 wjlm2X8CAmTa2cTyuiDghrJQJg49d6Skc4ytsRJ6751icTKj9kxAiKckQPjAVE9xXjQ6u/AYXpd
 SVojZIl3a+G+fWEiGp9PI7EKqj9CJ9YdQ0u1kXD2FT73JFwSIalFfK/otS/Qkk0m41YqQE3K7t1
 CfO7IBBAjls7IzzqYRLmTUbcCHaNMo8YCo1f4vWuVO
X-Gm-Gg: AYBFou1K0krm1awy/By2QnN+2QAsE4n6N4y0KLwkJnVChUk5hiGoQaDxJy+P8fDe7oC
 rA1rWQ0EHCxnX9n+/8L6+EorIL2tAvHMDWE9qrGHj5QlXBxmiMQWNgTqljuFW2P4v+AnV2jvoFL
 6dGcPXl2Ufqw4+R5YFLUX/KARgeMiri/aJLIvnPIPTobWrQ0L8YEEe1Kch8jc/eaqQ2/+T7p2qG
 eiYJZtHMlcU/CMU10OkBBKi9ksXqwMSRBIRe4QgvRfdzEE2oSV9b1W8QsGfvnUCSAAwtFc0G+Sd
 nOfjinE9rvQ6XUnUr7GpGgAxchtoYU2Abs3maRNRY+hvpeT9tEofk8PMcmLItXjLtYOqw3JY7Pl
 31+iBtmcuNDq/lD/h2m15kE6m0twi8sa753DT8JOjd1gnibF/kfzqxcoFbr9DUTguF02sPdeKw6
 lmyB0I
X-Received: by 2002:a17:907:96a2:b0:c29:f5d8:9c7e with SMTP id
 a640c23a62f3a-c2ac22cb906mr1124569166b.45.1790600635780; 
 Mon, 28 Sep 2026 06:03:55 -0700 (PDT)
X-Received: by 2002:a17:907:96a2:b0:c29:f5d8:9c7e with SMTP id
 a640c23a62f3a-c2ac22cb906mr1124566166b.45.1790600635286; 
 Mon, 28 Sep 2026 06:03:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae77be187sm467699866b.46.2026.09.28.06.03.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] target/i386: extract computation of no-autoenable
 features
Date: Mon, 28 Sep 2026 15:02:26 +0200
Message-ID: <20260928130228.877003-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

---
 target/i386/cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2a69ffeda40..b6ad69d5047 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9723,13 +9723,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      */
     if (xcc->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
-            /* Override only features that weren't set explicitly
-             * by the user.
-             */
-            env->features[w] |=
-                x86_cpu_get_supported_feature_word(cpu, w) &
-                ~env->user_features[w] &
-                ~feature_word_info[w].no_autoenable_flags;
+            /* Override only features that weren't set explicitly by the user.  */
+            uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+
+            env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
 
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
-- 
2.55.0


