Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAACC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSenh-0006Uf-UQ; Fri, 20 Jun 2025 12:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeng-0006UT-Ig
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSene-0000EU-CN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUIvp1cz9YnyvC95Tjas0YvfK3IAXVWPKg+/hWgdCnQ=;
 b=Inc0w13PhfiQpw8DytpvqqzYcWWxNLcczqph/zkHP/Qsgmn1JKqLuBNEo3IBzq4kFzdgbT
 kYrskESDVsbQIcyq/p7RpSYujZ1G6a2/jCLDB3mZ0MVeAK/FuX2PFZg2NcRKjMNp42JYSx
 oDGRRu8qy/d3S93COqFTdkB+TK6sFq4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-m0MttppVM1OQGkio8HV88A-1; Fri, 20 Jun 2025 12:41:07 -0400
X-MC-Unique: m0MttppVM1OQGkio8HV88A-1
X-Mimecast-MFC-AGG-ID: m0MttppVM1OQGkio8HV88A_1750437666
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad8a0eef39bso116584866b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437665; x=1751042465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUIvp1cz9YnyvC95Tjas0YvfK3IAXVWPKg+/hWgdCnQ=;
 b=G0wPUhauFax97mLMSm7tBdBki2C7qjbawajeSHBQRpsfBYs6/KATdjUY9WiHQnwYdj
 7o47hHAC+acmkPPApGatZ56NXo7UUh/Z7eIvn9zK5mZipVYlyuHMGADktxlSpt1Q4KXe
 ZkH/4B4Eqxmgv16f33HPH97ueSxX02tZOHOaCN2OTx4xqaaOVnJ/uqotVf1TLL3L7icg
 1mKteEXRvNhBMmAFytemwl6yvU8zaLCSrBvGjgGzrq4NAoPhbWI/zSmiDltrESJuz74H
 1YRk+N79lu9KxZiHAMmazxJJi6oqhHy+Mbe780lgEvpfJCy2mgzp6r/PX+gQ1EUJAAWB
 X/+g==
X-Gm-Message-State: AOJu0YzOxnQFwkcm+qcr/5zRXQA+vU4aGBplg5AzY7o+im9tOKqKUO7b
 KVF4f7chFQQh8OqojUPJKwQIHeYqBCJcw1nEfh+R8Vx3c9c5SmZzTKKC/XO3Op2OJYK7Gr+dhKv
 MxkoNdeOZIwdTwhBPDaDD31I09TOGFwAROt8++Y5ujm4Bqjep24B+uXFEhQjXaPcfMEKNDXfdz7
 1DPyXNtMG1NS0y5q+oZRyyyHJXiN8V244f5G1UMoSQ
X-Gm-Gg: ASbGncvccUYYEjK2FTYkB4bZ2wBxelfrMpeqmZXnpBa5EpAmMEI8kLlk+PalTeTjmfI
 xmwpIJts6+kqLVj0vclPeZNk3kSaZcBcTuF8vtcp+CABkBtsQtwVcL+TnJ19WLg7XHLuolslU/8
 u2m+Ov3zoCwPAj9y7L4uyqnf6m/NTHVYCdq737Dob2o3MXYX9255LLFIQKJ5DMqRBtU4kRSXV09
 25dL7gw/k9XSVWshuHPP1j5nygWyNMT/raCXANxzPDbBGgXtnIqhnsE07gxCIELsMWYLlOHqv90
 TOa14HlEnFsk2EKRc+fLXkUSuw==
X-Received: by 2002:a17:907:3f96:b0:ae0:66d2:8953 with SMTP id
 a640c23a62f3a-ae066d28f02mr108144166b.45.1750437665213; 
 Fri, 20 Jun 2025 09:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL3bZFmb97tLVSwdIlp8JlmRW6LpCBRtS3g49u09GT9AY+SZgEIkx0yKcWv1AYOJuy3020Sg==
X-Received: by 2002:a17:907:3f96:b0:ae0:66d2:8953 with SMTP id
 a640c23a62f3a-ae066d28f02mr108142066b.45.1750437664767; 
 Fri, 20 Jun 2025 09:41:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7f53fsm186007866b.28.2025.06.20.09.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 04/24] pc-bios/dtb/meson: Prefer target name to be outfile,
 not infile
Date: Fri, 20 Jun 2025 18:40:32 +0200
Message-ID: <20250620164053.579416-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Makes this custom_target() usage consistent with other ones in QEMU.

Fixes: 6e0dc9d2a88a ("meson: compile bundled device trees")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20250610204131.2862-3-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/dtb/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
index 7a71835bca7..993032949fe 100644
--- a/pc-bios/dtb/meson.build
+++ b/pc-bios/dtb/meson.build
@@ -9,7 +9,7 @@ dtc = find_program('dtc', required: false)
 if dtc.found()
   foreach out : dtbs
     f = fs.replace_suffix(out, '.dts')
-    custom_target(f,
+    custom_target(out,
         build_by_default: have_system,
         input: files(f),
         output: out,
-- 
2.49.0


