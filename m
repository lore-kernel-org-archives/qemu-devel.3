Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898E2FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee9-0002gW-Pd; Mon, 09 Mar 2026 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee7-0002eh-2d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee4-00026H-Ct
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=dm2WTp+gRLFz6JvZNw7TunmPs39EuuFZZxR3oyEMrO9YOCbVuRFHWGJT8RBr1oyF1FLbSL
 B2gFheTjs27yP/uDR6nLRI2BDsO3iil5tyJEpsRidGnGj609f/xo08FC++tVc5MHndgVda
 1H5g+U17RGU0RcYc+rj6teAnKnVoJZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-FYnz75kjOW6aTycuTLRlaA-1; Mon, 09 Mar 2026 13:43:53 -0400
X-MC-Unique: FYnz75kjOW6aTycuTLRlaA-1
X-Mimecast-MFC-AGG-ID: FYnz75kjOW6aTycuTLRlaA_1773078232
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so130492505e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078231; x=1773683031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=GQGMj3SEou+KmW1qM8q7MR4Ku+ObWMOfeCHoRzbfrTwQAd6SZ5I38VbzNCyJRaz9o2
 KtZHaVtFQ4wldF9LrCRazKhrR20kA+PRBic/8lQgf6bIdX29mMXQmw12RJVtcav1ji+U
 TTVFf+W70pRkr79GqZCSOtXSayH1pmpvLDaiwihLNU1gh524wvjs6H1xtVkxjI/2xbMb
 4zhYk77exep9xWnlWB7CYXpWAQJr+c4SY0J+qAKPHh0nPdXog/ib2Y7GnGzlMWYUJa2G
 mt2DbdtidqYDrpbkrLVdWxIpxy9AYYIVFkSkwWEz5IdGXtmSiZpV06m/OZJsawCTdgOP
 pwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078231; x=1773683031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AyUHplPpiVSHERYHzgWs9PHhQD8nuM7rmDxiD4Pc/6s=;
 b=Naaw/ucmab7UUmWYXsKqcbo/vazgsPYbcHeMrR9xbsyOINmjGogulLFrTqG4I3EiZm
 tI6DRgV82y9tNZfpLsJcfhQOLfHpn5PEBH5OWAMKJyRJw/4nwyqiTABco9lF9UxJRb1Q
 tJcneHPdUhPcYtsOpEFtUsGEy4aG+f9acXHqvs50vfzP09Xa1I1LzPhDjxTFVw2CA6Np
 jbSVMI0V/GLsO7R1NLXc4/mSwBAR0AajvvngSKBLmTJuHUYaou2yaJoGQh10n+03CnCi
 vbAj0j2V/PS7ART/AoejJT/E9iyyVrp8aW2AU5u+n4xMbprw6UeiQXy97nj8zlyJGc0e
 j5VA==
X-Gm-Message-State: AOJu0YyJBOq/ABF7Krk/AeypZSx4xPMXLiWdK+16pfZZW/Avd1xioIJU
 s/NrceoNwTIEPEHCaGZ01c/OOGI0f+m/0T3ZFBuNGEQ0ixFrdMn1AWcyzHedbzmfyyUKNK5AXRc
 GKgjBd1A7Gmfzbf1d7aGV0RdjIf6I372DlDv4DjJVt/t6R3XvJo2S8txMO0cgRRG1+s42hA54hM
 4RfcnQdtnCVKgSFJ/KyVJ1tVDCfs6m7qNMivNimV2R
X-Gm-Gg: ATEYQzwCXdV4QzFGuOcfH5JyK+LcpVQYuyv5jSDCbiAwOpSr3iSC15AVG5BprtxBbyz
 +mQ+T9bov1cRC+1oNrDGX95+vMRKpKiCa2kL0KbbxLTbmW6aY1kZjHTuQbuTamptMZ04FzSlEt5
 exxNnksW03vOv+9gkO4VYFGH79uQSgteOuiv/vLzHgzdDanVpF5naUuGQ1JUOSbvnMyeTWxScOz
 JWOBBAzZzAdhPzeFQy5zaHPZBGcp9jBJRPuD8EADqoEGyN+bvNZXQfAaExnKMYq7YoYdi0Qo8OX
 2c1Bx4T01Udj6GhCHRv22Pl0ui9aIC4lF19xAOFOchpEq48lI0mode4nfxUhrGZLe9G5fveonLl
 IWhXEsizZzWb6pxksTTL34jqTyt5V2lzTQkt/6LEOSkpLCtQKadBN810UxDWE39Yz1QE7jRe+NT
 F1hfD63rUdC0G9FB6wXbLmmMJyqCM=
X-Received: by 2002:a05:600c:4e4f:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-4853f4214fcmr41091745e9.0.1773078231262; 
 Mon, 09 Mar 2026 10:43:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4f:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-4853f4214fcmr41091105e9.0.1773078230543; 
 Mon, 09 Mar 2026 10:43:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f255sm6492655e9.12.2026.03.09.10.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] hvf: arm: unbreak the x86 build
Date: Mon,  9 Mar 2026 18:43:34 +0100
Message-ID: <20260309174340.52174-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
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


