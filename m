Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445C0E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxb-0004Rx-8x; Thu, 19 Dec 2024 03:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxY-0004R2-EY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxW-00053t-Rq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WE9KFCxmYVUk9291lRKTVOkRERI6hjq2PtIskZNM7k8=;
 b=IBSurRcFykpATRmCWkDqMOcjUeAKSyl/bT3oh5H7ZIEW6DUV6Y/jilCdf3eIMOaay0FEeq
 Jf+rupwT/bmtwTzKo2OMBuGGfuyBUN7CP8+IkNS54/tWwUu5kbuch/+Mx0YpaPLyUg9JU+
 4Nsi4NQPhNWuo87q5mT9Vmavnk9+jFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-LKQujxB6Op-t3n5_dxSyXQ-1; Thu, 19 Dec 2024 03:32:36 -0500
X-MC-Unique: LKQujxB6Op-t3n5_dxSyXQ-1
X-Mimecast-MFC-AGG-ID: LKQujxB6Op-t3n5_dxSyXQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436248d1240so2774145e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597154; x=1735201954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WE9KFCxmYVUk9291lRKTVOkRERI6hjq2PtIskZNM7k8=;
 b=AUFgYlP2+HPfx69kHVkfgiAz9Xy8vLmjqasPj1JOWIzLXGjOI/OCknwKwuqRxdCXYY
 /WbzgEjyZTU/VTO7JkwVAyoem+rT8kddqTO4lXgkbOJM/6+RV4Hkh0keJc/dpbKiGLB1
 pvLpqA+dRw4UxYvi+lQQotuhTGCVD7Sdey6biKV7WLTnaBXrZj7Yf5knhBoJx+zeSrXn
 HZyXyDhLhhPe+krRC3mE+V83oTniy0k/4pla1+BC7zwrhNgKpCyuhEcjR6bUmyFHxky+
 fWrcViWKzb0MK+hL591fh2kaMu9rZ30IfseP0q4FAEbYpwfpqEKNrbGRf3cBI21jMRnd
 SNmg==
X-Gm-Message-State: AOJu0Yx057hs+3WcLgc/cf2aRmW1JMMNRYF0uGdTfCk2c/rHAHxHlsNx
 CiTm9syiSp5njfPD7Y3xNdd/Land9RQ/RiqFOENQt7j8fO/WII3N6qBzyuzKiF2yYYTik8TcBa3
 Hgtikc6/V6Ry+mgxC0hjrNDb7UPx+rzKOoWxV9plyBXywsGbO0xo5HFXX1fecmJfWSkjPB8HfRR
 eTUmC0GhBVdQHm/rymjxghFs/tcEuE81bvjZ75
X-Gm-Gg: ASbGncuN/D3DfMtRh/7wojIijBukQ0ojkf4PPJPRL0kkBMdyptjQpHsRSFgqHY0N79B
 VbskUaGe4L918rn6zstXru3zK5ae7xr7RDoJ0qdE7aXhpVw4FeY/Ptu6ChAQ1iNEIRyjDSh0txp
 IDllAAlRGfXE4oOJcdUn+nh+GJtMSQXjVW7NfcX8ePUbvjgJMrgJ7EoCl3DwEo83L/AOy9fdidx
 WxZIWUFQgF7nh1oXQGg3JGQRZTlWMqNEBHJDEr3FlXaCj7upbHmjyZ2/1/V
X-Received: by 2002:a05:600c:46ca:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-43655426983mr48859595e9.21.1734597154452; 
 Thu, 19 Dec 2024 00:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE12NLXDvv4ugXxw1LDuIGbypwM/9didO30SVTtU9JCv9/7K+CKrdIruc+42G7t9pAbiskHxQ==
X-Received: by 2002:a05:600c:46ca:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-43655426983mr48859335e9.21.1734597154044; 
 Thu, 19 Dec 2024 00:32:34 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm11171835e9.26.2024.12.19.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/41] hw/ide: Constify sysbus_ahci_properties
Date: Thu, 19 Dec 2024 09:31:49 +0100
Message-ID: <20241219083228.363430-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci-sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index d43db0923f1..2432039290b 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -62,7 +62,7 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
-static Property sysbus_ahci_properties[] = {
+static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.47.1


