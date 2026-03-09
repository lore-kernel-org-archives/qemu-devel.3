Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A335AFCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfnu-0003ss-TB; Mon, 09 Mar 2026 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnt-0003sW-4W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnr-0007oG-Ml
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=b4hTT+ehflgyV4kO5eNLQth8dR4LruYxF/TIplBbWK6rqgVovuwjPG9yRh8ki4tp3Q8nuQ
 lTfdA6xb68EcpBm6MxsaHVHcfWl9DeTFagkdMx0iJ9NjLAWHSchwEB3pGn5UdqZDeinkML
 ahWoWWH6Q4Bh8l/v6W3YUI85KtipOL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Jc2cLk5LOmOS9CgZCdhfow-1; Mon, 09 Mar 2026 14:58:05 -0400
X-MC-Unique: Jc2cLk5LOmOS9CgZCdhfow-1
X-Mimecast-MFC-AGG-ID: Jc2cLk5LOmOS9CgZCdhfow_1773082684
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485375aa56eso12879265e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082684; x=1773687484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=Zfzm4J9K+D3bASwv0Qf0nyndSj03QRF02zX0NWmR5GOJkVFjTS+8Xp/c9B1cOISsrp
 ccWVvV/L7gTAsTup64J8f854JOtlGrdyg83QpGTsno0ivmMauxJMFrDN3Nv+5adUqAjh
 B3ourxrUsdbpqg5lPnZBcL2sl58ex7JNNj8Md/fVukHQdi3mmBiC44Uj54TbMinMY/sB
 0D8YDFbYmRtrAuI9XJi0IuXDAADpZzMSf8npuBXfMHq4hgXV3zFn+DO0FMoO7SNMQDZU
 /m3/FI39d5I9LjYnVAExjSzdM05aAcG9JqIz9hAcgZKIC8sO8TuvC3CFvL9KfUrhVonB
 r8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082684; x=1773687484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=It0uGfUKAyP1AEew3D0gQGE+Qr1H5FoSTlbFgODhWcUmYG6xQLnoFM09wQjWR+QfAL
 4IJ0Ih1XgrkOQA99KXLtXZckT4XfBoGxPxWPr4g+zU8l/1/0mWPYUfVDzZ0DFWiI2hy2
 GQyiLfmRwdw9wfdVQkzxKQUwO5tR/wSFw6KBEvZIdnDdu7f8T05eT1KZ/B9gm970mc8S
 RIM2nxj7X7U6VVG+RB+1xLoibCfzjrmNOq+9qxnYVmbswd6Xv9FnNQxUMdv8alleKZnC
 N/bAu3YiYqjqrZvEy9AoL0Is1CX6HOhCp1AUSmM1T1Ok9ZSz79pSlNoNG/LtBXzgYJ8p
 JR2Q==
X-Gm-Message-State: AOJu0YwR/SFpWBS0yXLx+mQPE3Op1VMVtTkGRS4F1EpI20nZ9rr05nyG
 xmHOfhVLtP70XwqyGc2VJVFBgVAj6hBqPjiSqJgpg01Ad6UXiPuxw0rSML+Eo6pJ0cO5HxP8LOJ
 75LUdkKwpBjbE6xfnqxsxvNjYUQkEw8iuCbi5EmCrJbCIEP2230xBpHe5Mw6+rWWqDH5o9StwVo
 6nSTF1XAuxWd0L+8WwecObNMCAc992Id7JSsDOnZ9I
X-Gm-Gg: ATEYQzxTdvWx/4VDc9eVwAjjG8RSQne5FSZFRY0HKTHMv344YI8isf/2xX2XfoVfp8F
 Bk93DgF/FyVHFBGMQpVJrQliMk20YgE18MLj2aJXTomkFkxxjPNAjUthOMMSMCrcSEnGF0nzdSK
 pxNcTGrL5K5ZOD19CMcvVJjHbADxAuBEX9UryvuyradzZRlkFxySdOXYc9gPhxzHra0BPH+CYlP
 8f7GaD0KiAK5SS+1cRut8ANaBtNg7fw77DIdlMKZlJ9uG7GN1ZpJ9t5nDacea68sHzQze4vcmus
 MVkpd3ZVrfWNHwz67vk5unQBQju8C5Oq87lLw1VTW4j9RqMsbc+uCl9TrFUT6NkqJjYiMVBX1ye
 dxmGgJMujhzlmkIiXx4cNKOXxVVx8zhlDZheZVVzdZ8wRPh58dbjD67gJypGtf2D/GacybvpGjP
 AXgnwSmij2+oHZvZ9eUUZo2vDxYnA=
X-Received: by 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48541369c0cmr22242875e9.22.1773082683981; 
 Mon, 09 Mar 2026 11:58:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48541369c0cmr22242455e9.22.1773082683510; 
 Mon, 09 Mar 2026 11:58:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485359bf807sm74317815e9.2.2026.03.09.11.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] hvf: arm: unbreak the x86 build
Date: Mon,  9 Mar 2026 19:57:46 +0100
Message-ID: <20260309185752.76865-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

We don't really have any great choices here, so use the __aarch64__ define to unbreak the x86 build.

Once the CI moves away from macOS 15.1 SDK to... 15.2 even we can get rid of these SME stubs horrible hacks.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260307181856.2209-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792d..8029d48caf5 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -27,7 +27,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
  * headers are not available until we raise our minimum macOS version.
  */
 #ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
-  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) && defined(__aarch64__)
     #include "system/hvf_int.h"
 
     static inline bool hvf_arm_sme2_supported(void)
-- 
2.53.0


