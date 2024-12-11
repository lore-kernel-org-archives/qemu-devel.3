Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053A9E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZW-0005D6-Ip; Wed, 11 Dec 2024 11:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZR-0004SF-61
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZP-0000RD-6W
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRzo14bKpEKjmhkHIMTDgnInrU+hYkam34e6roO9xNA=;
 b=DUFTkZX4645VLOw6m7WB7B3jU5HKqUG8LgDbA7nqYQcOv+vNpq+LP0+4e323WOWXFSMPEP
 heDpN9uS7tnTkSTmYgeJ1VqsxdC73dKSPcI5SCaaJjo7fpOdnCEwSnfmy/CWuSDFLVhlkF
 tKtUPPpdw/oNIwi5wlqk/u/OorGJxXs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-DlHRnKxoNTWm4DY7x3OG0A-1; Wed, 11 Dec 2024 11:28:13 -0500
X-MC-Unique: DlHRnKxoNTWm4DY7x3OG0A-1
X-Mimecast-MFC-AGG-ID: DlHRnKxoNTWm4DY7x3OG0A
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa67f18cb95so389719966b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934492; x=1734539292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRzo14bKpEKjmhkHIMTDgnInrU+hYkam34e6roO9xNA=;
 b=Qxpkh6+IHPvdgDI5nLFvhj+HB8aI3J+wURvdaDTP5WgyIgquTHgd+Ibt8DeUNI3N7D
 OGYzexWxhQ86ZczodI2CygBHmh2rPhTZzvVhvExJrydh2+PeziWbkoINxpJBRh34DAlm
 AMr+ic9IQQfF3V8kMYXsbNzI0b3kJ96WDyBCnTcVLIPnGctT3GW70k/tpzGPY+jkwKeF
 kDORk3ZzRZaTDUsetcuKGhI3uBmAdJALuGfr0YJt5LcN1hFAgeTaKy6RT0oYwziQ5K0S
 IioPI7D3odv4FN2tTVSKcn1Mxwhoafq6Ybi2Dju6dWZ1tr51bT1V1dXdTNuQvF892i1h
 9FYg==
X-Gm-Message-State: AOJu0YxWr6iB4Xn9zpD/YIp7dw6ltxzDKGgTd1Qs2Ac1Ey66WFcLsQL1
 XUF79xR4NDMXzU+e7jGD/VVvp9DnZkgUsb2XGVzm0E07tK6FeVijwM5qnDhMfiHHxLcN8KhEnaE
 vOW2fnwU/7W4zK0yTd+V44Is8dQAyxzkC6hBQtzjtT9AodAfo3ifQst0Ho4TD89jAQds6mypvui
 2T8t23UeDs66t6lyg8s1VRptYKbYD9EaXM2nKU
X-Gm-Gg: ASbGncspu0MdpwI5NCsHu4UTB9dSPpNdU5WAYJ9dWHd572SCxDDqerImaXDsOVoxh/H
 AFFxC2UrtX4bKsrflzvdpI7HJLVEVve5HUaqiIChSw7G1QR72LYUzngikZOOlKU9VVOLmv/Xzn1
 b5/SuGaX5ckEZBMCtHfGYlvma2ahoVDZ2fhsEGrL65R+k94A5zJbArXosx6AUqXwbX3zBRHsmr1
 BgIufE+1mIErkE8edZRMYkDUqcZXhYL4e/vv1jJb74YxsZXQ2Ggi6kh
X-Received: by 2002:a17:906:2932:b0:aa6:8b4a:46a0 with SMTP id
 a640c23a62f3a-aa6b13faabdmr362863366b.57.1733934491830; 
 Wed, 11 Dec 2024 08:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPUb7kRnCbfIIenlBIwvT9AgcRApJp1EKww8eqMa/62iY9Td5ZUPZk14Tr/+no9VStT4ssXg==
X-Received: by 2002:a17:906:2932:b0:aa6:8b4a:46a0 with SMTP id
 a640c23a62f3a-aa6b13faabdmr362860166b.57.1733934491386; 
 Wed, 11 Dec 2024 08:28:11 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa698e922dasm381842566b.84.2024.12.11.08.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/49] hw/block: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:50 +0100
Message-ID: <20241211162720.320070-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-3-zhao1.liu@intel.com
---
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e2e84f8b5f8..748594524e3 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1894,7 +1894,7 @@ static void m25p80_register_types(void)
             .class_init = m25p80_class_init,
             .class_data = (void *)&known_devices[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
-- 
2.47.1


