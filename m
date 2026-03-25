Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E949109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMS-0005Fg-NN; Wed, 25 Mar 2026 12:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMQ-0005B0-Q7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMN-0004gz-Mk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCwiRC482EaZQxhfSATpmEqEFzUxiMA0FuQ+ZG2bLL0=;
 b=FtJ/EGAfgyo7chvpMBkawk/fiW4W3FwPJUwvsDIH4TP3UpMlYGHpKv2HhY0LK5sqkKdoiR
 PDGva2VZC6NQeK2HtuD8rznKaUkNywHnMJPmqRe5LlQIjEfV3aviHA6tFWOUhPxzWF2cyR
 uf1CUkXVjYtMuHnnEblUto3oesRvoCA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-EEdCzltIOdqTnnzYiKwOMA-1; Wed, 25 Mar 2026 12:45:33 -0400
X-MC-Unique: EEdCzltIOdqTnnzYiKwOMA-1
X-Mimecast-MFC-AGG-ID: EEdCzltIOdqTnnzYiKwOMA_1774457131
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a277331b57so71514e87.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457130; x=1775061930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCwiRC482EaZQxhfSATpmEqEFzUxiMA0FuQ+ZG2bLL0=;
 b=gM2HwZOrLF1e/FKpmAyNko7pu9N1YMS57redulxb6NGBUxgwvu9h4a1kaXVvEWonS7
 MOcwtEvRPme1i/4oolQsNurfT6k5ymV3Xb2DBTRb0CE5xqbd8b8axU8bvK24C+D6GlKw
 b59tyZqoGtlLMdb52IyJ8/Rz7YOQWb0e5ggw2uNWFq+Ch2uDKdC7SC8Of2C3gEpDcGkC
 EKXd/weEsiNEs/65MQT6zaT+SZUfBy3VqnjmN24ZEke+xbxiPC7i4bboalXNiDoVoFRI
 IA87XwI4Wf6LR18nw+wlxfajWIwQU4I4KEMlHl6DNkowVjCOSW55mbtsxfZBHNqHcfUl
 ILVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457130; x=1775061930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CCwiRC482EaZQxhfSATpmEqEFzUxiMA0FuQ+ZG2bLL0=;
 b=oWLeAekmrhGxOMs36dBbJSRsy8kKStdZvnk5D/Bqy6priqv4RKmZxgZV/9TZBKSjid
 ikAIIA90wgInVapjzjxaV8ytGWGLkkfzR8nbESGyzdHqEIhjRi9JPea3xYe7+4Fg5qBY
 7yVcqjfVcfBaFLJ7fr8RzFpvZTsad2/aLhE9wy4MZKLiRrqp+Jdy2EBgcSzxUmZ6yKTs
 Ywqej/L3B2Al3NEW7fhANL8AqiMS7hp3LHRhYq/mWIWDjUzDlHsRisvDzjO8hUvOyqeI
 Fy/ln5abSQ+QOFfgHnbkRkjk2NCSnYtFyeyAIBaFeazBMxbeRFXeradEn2O1Q4qc+S/9
 MbZw==
X-Gm-Message-State: AOJu0YzSdrdEB5JW8j1Z/5jcVq4PKTtWtucaRUKHi8F4okK51bOKEwYJ
 ZpR9Jrh2qqruT7N+5QN9yYNZbFNHWYHIRf0TPXlH4pNXb1R+c7PuUvp3r6Os16uhztwE8vWi+OM
 LoXMPRmbJAmE1Qj12U6EGT87SARodrBXArM9p3J6Zm1iVcyWwVZhpghCbFB9lgleqKn6NYT/LCX
 3oLE4/tRYDpeLg14KVm6eT6I4lfsl2/wniwyhqcQyN
X-Gm-Gg: ATEYQzyXjcbT3Fd/YfYZKtxFsLma+yLy2aWUQMK/Gb5fdWdyqLFVLeSrMebHiiy2MKb
 1bE+nEhK5vQRtvPXcanaVc1p2sWxuh0cUyEIPBZSrIYl6KrihSopJQPg2X0PYatc2/8jO0nC5bY
 MHapv27JRmpD9ReGwTl6q0/8A02uY1rD7EBoa3FaQfDfmIPzWxfTLn5JG2pKYdAlle6qaj5Es5h
 W2ZYTgHln/5ELvcBdf4UJbf51P5z+9zlfCNFdJDT2zmTBLkImadEMFIVX1TIlpPIHH9JQTcMd9n
 RSbPuyePOxHjDmUc+bixjNmlLSAOKv9dkYUoCuBFeef2/qpAfMZ2VP1hiSw/5r2eBMARGhpEU2c
 zoaeN/XdpofrxeWjcmqnbBpgbZfrBjiSZHpEpxnTTc0/Zhnx8NC0Ow8Be+lrl4qW63oBN3JvfAj
 dTuWij7Sv29gkvjdF3V4C7aFXG
X-Received: by 2002:a05:6512:3d10:b0:5a2:851a:264a with SMTP id
 2adb3069b0e04-5a29b97ecc8mr1575625e87.10.1774457129893; 
 Wed, 25 Mar 2026 09:45:29 -0700 (PDT)
X-Received: by 2002:a05:6512:3d10:b0:5a2:851a:264a with SMTP id
 2adb3069b0e04-5a29b97ecc8mr1575606e87.10.1774457129255; 
 Wed, 25 Mar 2026 09:45:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2a064c17csm17482e87.28.2026.03.25.09.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 18/19] target/i386: emulate: set PG_ERROR_W_MASK as expected
Date: Wed, 25 Mar 2026 17:44:52 +0100
Message-ID: <20260325164453.72127-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Make setting PG_ERROR_W_MASK no longer dependent on the access
being a priv violation.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324230016.80914-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index ba0ebe4268d..1aa373f5b38 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -248,7 +248,7 @@ static int translate_res_to_error_code(MMUTranslateResult res, bool is_write, bo
     if (!(res & MMU_TRANSLATE_PAGE_NOT_MAPPED)) {
         error_code |= PG_ERROR_P_MASK;
     }
-    if (is_write && (res & MMU_TRANSLATE_PRIV_VIOLATION)) {
+    if (is_write) {
         error_code |= PG_ERROR_W_MASK;
     }
     if (res & MMU_TRANSLATE_INVALID_PT_FLAGS) {
-- 
2.53.0


