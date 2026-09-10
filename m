Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C8C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mcj-0004ou-DJ; Thu, 10 Sep 2026 17:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVh-0006PL-SB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVV-0003BA-2l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=HTJFBpsDbuUT+zPqEIfA3wrDVpmTDdJpmbTOrZwp2VFe65iA1+yz84ch/1DnDAqIU80bLu
 f0YDI9ZYYT8T3My+BHRY0pJ4yOkrCvU5Y4I7GJaUM7x25AiWIEM1GE2JXJqC/O9acGevdx
 N0tUaBGnAeZ+iBuHcuAWHKZe7qkaqWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-A_Yw0YZ0NeSDUGVtiwI3xQ-1; Thu, 10 Sep 2026 16:13:51 -0400
X-MC-Unique: A_Yw0YZ0NeSDUGVtiwI3xQ-1
X-Mimecast-MFC-AGG-ID: A_Yw0YZ0NeSDUGVtiwI3xQ_1789071230
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4843e59c32dso64089f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071230; x=1789676030; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=VwH53Nj7UDhMPr5kx1p1gR9qQPOkgL3sVvkc/B+pqQW5SQ7QAbtdVker1hw49CG098
 dHkqe8UqmhQoNY0FMLMJrzQhHCSZd1YRRDFbfxlN/CbyrzsNw09OmeH/zwRv2DcMVpxW
 lb/wRNw4ZJO8yYUrFAkP+2PYkWejzKbIcH+SIGN7PDvkhdTvP5ppckfJ6NPnyltMJEt6
 CTPqxSgHddmKg2G02uuj7BAZPokigOTmOXxGP0exP5pN4ikn06Iy1Bgd5sMXWPOuFIEM
 AoQ7B1n6xcug0oV7xqfHOjlqu6kshcijcqEsMRtDpyMfHa4yMIjo6nLsjY4/5laqxmWp
 cqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071230; x=1789676030;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XBW41WApnawDSx9a8mqXcCXFaaQqc3qyywi8ob8BaOU=;
 b=s8F+LaEQMy5jc/MhZyiQ80XVc9EaHwb/BaZvbRVRzKv20qIlDs80kczxBTK7g3Fm/R
 mAFYoVr+1TLkEPd3Nn+jV7KQxIJsi0WXu842zvdawObAO0v2XU2d2Y1+ZzQRCfcKUGDe
 mX2JbUzyG7OxTZVAN9isFaM+wxODuPnE1gLWy2eAc5wMzHijsBJvB1Nc8D3Y4VZVqhdr
 4dquExrGjDtAoG5J4eKsGo5Dw7sWLx7o4RAj2HYVUb8a6plLB2ur/YFK1A9hZyarjv3b
 rx7vdQXt9OMmn0qFdAf7U61qQ7zPtFOTNJy95L8JeX2lyYzPf32CU7zYJDwq/gyyQNah
 PofQ==
X-Gm-Message-State: AFuF++my9D1l9EwGqAmapaOz2CNI7v94PDQ43BEEy2oRfqQbDpm15AO9
 kdFPNizcgsclKzNLIC9IFZ7so5Y3zJhEnXitC/L1ToKNxiTxQe0IIj4vIVODDaGw4z0zEy8bTrU
 UEXyYKHLKnbYK8TRm1/YNApXq9zK7O6VSfQWu/9cEYfGXp1Oi44Ad/LIFSUokEZiLu3hWJupypF
 rNj90RCnC3Ex0yh1a1Z7ObByCPHaGQYLOFfg==
X-Gm-Gg: AYBFou1nzAIYSnnltlHiigkEqaw1SkXOKgtfaDl3Q3bBDQ90E/YrrWT+G0FZu4ZWDNR
 cgVZCh18OjdyPLC7h83WqSAS3L7dL0OY0eUFxp8f5yCi99wg8KAsCeQFXa6rBgEmzG+yvwPudcw
 S4BBw6x8aAmsbOHnj1USAh+MNtNxnH1+JcGC5gCWjFvxbB5GjbeFf1QjggUC7rTKUZLojFjeCI9
 yvA/xzkpwR89Y/oOvbIo8wkpLPf+3IR9JAnn6mFnOixvHXQfNXEfTUbe8qUuOEif//zN+FWrJt2
 nyiy6zTC6L9i7mvVlQGnEjBCRIMEFts89ttZRwv+jv+SsIEmNGjqZfb4urmq0PeDPeZtCrivX/7
 UUY50AlBYZHfEv8jUs7+JAsY=
X-Received: by 2002:a05:6000:4007:b0:486:ed36:b99 with SMTP id
 ffacd0b85a97d-486ed360d6bmr192842f8f.55.1789071230221; 
 Thu, 10 Sep 2026 13:13:50 -0700 (PDT)
X-Received: by 2002:a05:6000:4007:b0:486:ed36:b99 with SMTP id
 ffacd0b85a97d-486ed360d6bmr192802f8f.55.1789071229754; 
 Thu, 10 Sep 2026 13:13:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ebe4sm657519f8f.14.2026.09.10.13.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:49 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 56/90] vhost-user.rst: fix typo
Message-ID: <7b37b1670c0d09d100afb73b99c65ea33082909e.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Alyssa Ross <hi@alyssa.is>

The protocol feature is named SHMEM.  SHMEM_MAP is one of the
requests.

Fixes: 588acb45c2 ("vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260804121000.444745-3-hi@alyssa.is>
---
 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ae8c7ed995..fbfb9d01c6 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1158,7 +1158,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
   #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
-  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               22
+  #define VHOST_USER_PROTOCOL_F_SHMEM                   22
 
 Front-end message types
 -----------------------
-- 
MST


