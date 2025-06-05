Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB8C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eU-0008U1-L2; Thu, 05 Jun 2025 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7e6-0007WH-Gx
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7e5-0001Mq-6F
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2/G/I18Ub2g4XeJAVy21hDOpNlIY9B+vDIlXLdnVeU=;
 b=U2riWgUVZeR9skFwbixC1zA0Y736AacObZh0KUwz78LGGvso/NCRZn1LBYqaHYCCaY3wi4
 Upnh3Ds3+4GMbnx62X7MZx/awZHRpGfDnnXQ6xMfC0HL3KxVN04ZhZJUhj+RlQukIxnl4j
 G+cmfG1PHzZzAc45rgi2CjUQugpqZnk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-6Z9zl17JPS6Z8MhzRZQTdw-1; Thu, 05 Jun 2025 06:16:23 -0400
X-MC-Unique: 6Z9zl17JPS6Z8MhzRZQTdw-1
X-Mimecast-MFC-AGG-ID: 6Z9zl17JPS6Z8MhzRZQTdw_1749118582
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a5232c6ae8so348114f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118581; x=1749723381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2/G/I18Ub2g4XeJAVy21hDOpNlIY9B+vDIlXLdnVeU=;
 b=BLz8dwprmTXlVQ2xwzsfigE3a6e5oFKWuMHrUcK0f5tpIhz9+tnSDBqpQ3eG9iiT1D
 JBW/3PP6z1rtlT+LyT+oHlFEhsbVKYfUXPLz3YbMkfJh4XNfo3Cc6PmnAgB2AynrixCl
 LQnUHwF5BGE+jW8joeMh/Nld1Yptu7CKsUNdWO4E9u/XioxVx4igcHajEKmxmDiLf8zL
 y5CWjECj8sVkq1D+C68mPJtDmV3pi2NWByeswtBc3P/ZRoC4D8HZHWhjXcK18xv+X9Na
 eTiaG0qA0yCNlkZctS3UBI5eSbyNEYMzHOwzzIec01NosUX3Im7LXs7F0BznaOnmlTnL
 8G6g==
X-Gm-Message-State: AOJu0Ywjd+A05Ky/N8AspwR9KHiA7ZhwRPuAd6E+uaNUylpXi72OfJmv
 fPpDSyDZ1Qb8OrZ4Rr1gwBh0ojbQueeuNSUj1Mh3AQ4ErKVCaylFbQnFXV0b4wys1g1Dey4/IEt
 kEymGbZX7G7dfuMn34Q9rESHBgzAl7QvuRQTl0LzkroRJWCHIRlZtyVZzLRtBhlepkCnVJwHmvD
 15aqpE46Zr/q2AiYbSz1fwq0NyQeHN8KVn+gNeG0fM
X-Gm-Gg: ASbGnctV6Gi+clWF4IYJhUeK5JjDX+UOvzF9YCeR5gHUVN1D6g6RQkIwri7yxmnS/A4
 C1iiZFxfv8/655Gc5uzVpwsW1mUTzG2UPrKtYXEv4c66xodoaC7mlv7J6vLs3bOSIEAa1mXq8fh
 xFXFWR4Sa9dMaKfCWzGchNT5MVQoeXkOwB7019km76Bnw1Z5R3UL/iSbpOX+yG0IVKDQm9HOjBV
 rtbE5YPe2bUquLzqsrIzJUYmXJYxpBhsoYGX+Hp3PJYMlQR2/S/tFAn3Fr2MMsf/YCbETlSS05d
 xuQpWgL9X2/72Q==
X-Received: by 2002:a05:6000:178a:b0:3a5:1266:e9ce with SMTP id
 ffacd0b85a97d-3a51d96cfffmr5407108f8f.36.1749118581602; 
 Thu, 05 Jun 2025 03:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtRlP5OI/J7L/pYLg9MBXPQdHxg/DXcrykIZPgtzrujpMWWBR1Nybv967jyEx3qxLN3ejSqw==
X-Received: by 2002:a05:6000:178a:b0:3a5:1266:e9ce with SMTP id
 ffacd0b85a97d-3a51d96cfffmr5407074f8f.36.1749118581134; 
 Thu, 05 Jun 2025 03:16:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm23676310f8f.42.2025.06.05.03.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 14/14] docs: update Rust module status
Date: Thu,  5 Jun 2025 12:15:43 +0200
Message-ID: <20250605101544.368953-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

error is new; offset_of is gone.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 98803d5e8dd..67acd7d2867 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -160,10 +160,10 @@ module           status
 ``callbacks``    complete
 ``cell``         stable
 ``errno``        complete
+``error``        stable
 ``irq``          complete
 ``memory``       stable
 ``module``       complete
-``offset_of``    stable
 ``qdev``         stable
 ``qom``          stable
 ``sysbus``       stable
-- 
2.49.0


