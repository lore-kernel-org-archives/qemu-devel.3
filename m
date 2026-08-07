Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC85C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKU3-0004DV-DH; Fri, 07 Aug 2026 09:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKTr-0004A6-8Y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKTp-0005k5-Qo
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786108760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aqi5s2GeDgP6bZawhS1Tu8DxTdbEaLI0xAAqmk9Swl4=;
 b=HteIMFyw+3eJyh/V5T7KMW8kRGmk61E9AZSDJaWmGQ3lo1gs/eLL8c1RVjLXFg47ao5Lzo
 Qi10w74mB6N1KWipNJMBun0g5GqMgPNm0XIEAADzwr/2E6HWihBLvEDu+3U77P+L7vVbx1
 kLjrOPcPdSCSbp4yB+lCFizRwL1aKiY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-xL6jd8gyPCKU3irw25l4yA-1; Fri, 07 Aug 2026 09:19:18 -0400
X-MC-Unique: xL6jd8gyPCKU3irw25l4yA-1
X-Mimecast-MFC-AGG-ID: xL6jd8gyPCKU3irw25l4yA_1786108758
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so33496085e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786108758; x=1786713558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aqi5s2GeDgP6bZawhS1Tu8DxTdbEaLI0xAAqmk9Swl4=;
 b=sWfIverKlOQrr6vfskUZPl4itU01AkAiscZh6D39EQFtmwUgQ3U16SQa4O9/gSYLnD
 eKnb5dI0xbgrYuqDh8+pl/eVYjx5eCcGFSbvv/PT15qfQhwo6XvTxM2qeoZoNhGawY1z
 A1Xw2ILDRCNJWZuavjHzOcUNJymh9+yMinWwlGQpPE5cdCfAP6/2Mgwx2VJmc20wHv/m
 TO89CTflXAkeWf+6TJ6Rk9tLl1Yx3IVR0Gm0OST7BzsQBR4xCh7UsPv1pfL1s2BgZtpV
 0vzBIahSDbr9eVgtppDoyql6FRRlvkrg2s8yLhm5+cQayHqxabeqcVy83cWtBDJ2Imi8
 Xk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108758; x=1786713558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aqi5s2GeDgP6bZawhS1Tu8DxTdbEaLI0xAAqmk9Swl4=;
 b=ksQEmqar14AsPCSGyK0KwTMq28H2HM5qCXrl7NLkQy49yWX2xCnP1P7Yecm1sjdr57
 OdWfsvCknQ34xW/3z09k1yZfnEMpc7sQ8AsGArJHXI8Dax5M3twmqOH64Z89JIYC8x02
 rW5V3j9FRsF3XwcTrVNlOmjKOuJvDgo8UwJOihB0pFFqEcJ711qaCEbfD3YXv5SjUiIu
 /LTgzKAYQvWsdxm9EEXTGWbMAVMIhLnmtXqLX2Uha+5icXsod00ZYcOpPbPO2fao1SnL
 Jy2b+HJBb2X7EsK/OAbu/auLLboC9LyeyVYNa1tsnaD8sr+GgDqWR0YjeBjJ46q7OauH
 E5og==
X-Gm-Message-State: AOJu0YyPeCDDynfFtoacrmOxxvGah7beY1Jmbk09yoBxxk5GMsKaEcYJ
 /SRNmYrdabsXYmM4sy0NeNSBsjuC2f9bo6uhcXT4yCVW8c8AFC2a757AQuw7hDUI2HRbsYp11hZ
 LYVLehMIdqSgEt7iQh5TPLq/vxR1kIQ42jro95RZx1cv13d/ZlZXaebKLbE6JvqOvOfyJsxAPlR
 DsWDU5b12vd3uCx5DaPKppFoOx/ggXiefEKR6YWve+
X-Gm-Gg: AR+sD11ThusxcJCGcDxD5ICvrDx+IwKPGxbVmvSU34TRFiFURAt6Ck9h39dudt0So3L
 LGWvQLPnge4EF38MkgzYMP9xcvYpO/byupGkhK9haxlcf1XImW7WvwVMbw2WBJcVV87wMZsZO8J
 9/ilepnxxGv19k6m//J0QR5ZKltC+OIgk67EUVAaggrjXJt+0jkaU6u5cbhk42MBJrTE/CyIz1J
 rVruHdV8gnyVpC9U5IHt7mEAeTxLSvO2Jr6x/TPQX5/ugPTxn0DC5gYW/GLQhm76lSyD+0PX9WZ
 Sd57CyigGvYRM/dLK9c5u9wEBeYYt4iDTumKmJ0ZYym9ULD7Qa72bpXhEDQzg+3yity/87sOTUh
 XSl5PvwuTO7gUxdnEsp+ylOD5Jdrm1tSHWqZ1AQ3yb4pyaOCkNn1a4uaXCvBMeYI0RCYQFIC0AJ
 0moxY=
X-Received: by 2002:a05:600c:19d2:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4994e7c10c6mr296310365e9.12.1786108756753; 
 Fri, 07 Aug 2026 06:19:16 -0700 (PDT)
X-Received: by 2002:a05:600c:19d2:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4994e7c10c6mr296306525e9.12.1786108754057; 
 Fri, 07 Aug 2026 06:19:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7164sm46358435e9.2.2026.08.07.06.19.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:19:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: use ESA_FEATURE_ALIGN64_MASK
Date: Fri,  7 Aug 2026 15:19:12 +0200
Message-ID: <20260807131912.2608661-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

Do not hardcode bit 1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/xsave_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 1fa3133b1a2..666a2810029 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -382,7 +382,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
 
         size = eax;
         dst_off = ebx;
-        align64 = (ecx & (1u << 1)) != 0;
+        align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
         supervisor = (ecx & ESA_FEATURE_XSS_MASK) != 0;
 
         /* Component is in the layout but unknown to the guest CPUID model */
@@ -394,7 +394,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
              */
             host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
             size = eax;
-            align64 = (ecx & (1u << 1)) != 0;
+            align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
             if (size == 0) {
                 error_report("xsave component %zu: size unknown to both "
                              "guest and host CPUID", i);
@@ -530,7 +530,7 @@ int compact_xsave_area(CPUX86State *env, void *buf, size_t buflen)
         host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
         size = eax;
         src_off = ebx;
-        align64 = (ecx >> 1) & 1;
+        align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
 
         if (size == 0) {
             /* Component in host xcr0 but unknown - shouldn't happen */
-- 
2.55.0


