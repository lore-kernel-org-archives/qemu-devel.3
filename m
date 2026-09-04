Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DF9C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TL0-0001ed-8Z; Fri, 04 Sep 2026 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2TKy-0001eI-NV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2TKx-0007CV-51
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788526085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=JbDYibcob55vf9zHTYqLmJEh49d06d43zIWiL9mYY0Ro3YsBb218ioUfpeXxFRZS8O0Kjm
 OPrWuvyiCjuwXsIlcfOLYre9IVfVFNYqJ4HHgUT6hIGtKqHhjjYyrkBLfFgTeQIrnAHc+n
 mHIAiOU/lJ9D3ToVOIvsMagy8ZT2roc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-D-tIzwJJMHqHFp4q6s0bdA-1; Fri, 04 Sep 2026 08:48:04 -0400
X-MC-Unique: D-tIzwJJMHqHFp4q6s0bdA-1
X-Mimecast-MFC-AGG-ID: D-tIzwJJMHqHFp4q6s0bdA_1788526083
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cc9f5bee2so8063335e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788526083; x=1789130883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=doQAGQ2WeRyvcKZ+DywYKGpOW9bw8TBEGjjzFGTPvfRIHDjfHy/I/w/zhL0sH90+qD
 I9KCMowOWat01R8U4bA2Iq0s34tCp7iHGPJ6Aj4ypAu2JvoXpqCDIM2p02aOguDLio6/
 m7rkFnlFyxx1puMOcqivwfoqpxPkfC3PTsQOarI+DAgvnIjbAlO67CILX6rHZK9JOzyw
 4q5oTeUDWG0+f1SX8AGZ1xC+5nL+pMA7psAKJWz5PAk+E4zroIYZgA3dIMT9SVGaUx+U
 l+/nwD3VZp1+mmELYPQyFjQc/SoSlRMHI/qmulKVTyAqCmhqwprFEpPrHOFH7nacsT1c
 j11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526083; x=1789130883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=AXvUN7NwQXcIz1kSsSHPa8TFOUvNmbcQ8ak0J1udgF6CvIGiLR+gSSfv7jbO198I1V
 wqxBLffM4x7mM0Cb9OQmXinN9qFmSx3s3hxbpdumY+406EEOWDH1qrisMEdkepVOjIij
 So1EcunKRG1YHX7tSzT3vXJu/V3CjVWb8Mmy4w/yisB9Z+XWlJJYnQnyjTczPuIybWeI
 9iUDqwEpYX+IjuRE01wPQ3BaaA1cJNVZtTQwcy5+YW9STMxJTOFua4h9uFEjXFEbAsOk
 xCrCgpUEI2i2LaQDnNpVjqMIQOkqK8aXv7PU8BafmX8fyfQoW4+zPmQyjFxwwVU05+WT
 QWmA==
X-Gm-Message-State: AFuF++lq8TCkFyXjjzh9nbvkK2MRLuuISw6EVtKEePGusBPeBjnqSagA
 J6X/jXePqthP9nLLbYBipT5pBCFilLrc7IhCTQO5JM58T26YsMwIeB760sYLdlW+SxIzO/y396l
 a1GsLgVM12GkeY1ujq//zJZCptIRPozhWQo5RTRoKtf18h8j1wEv7kwm9DL1g9Aq5CaIxC++HRW
 N5dqVygC0J+S0JPdJvdlOBW9FqgyoSk1muZMkTuUEC
X-Gm-Gg: AYBFou009Hi5AyBfn71pIGal8+1sXqrWGPh1KoQQOj7UBfI3DAxCkTK8rryfLNqvEWG
 JFt9tTpTVNFWV7bs+QwFNFCXpDq6slRDJzL6lN9xmvTFUe7MMc3nBOP1IYfEuYPkANMF+h94NbN
 AiJe81oe8kbmH4KJsv2pXptsBsO1dAQAV0oFFiuB0baqKl02bG4exSttvJWr1zupZPduseCyc1X
 nXPoyrlJHSCpxbNEQSaG9jNw9aDRI7cmeUmoxAjdCFB2kGU+P5wfG/yki8WpnRlrbblelNiLSHP
 XyGKDv+ZWCpf+VA6aWgCwUOYEYMnOv3+ri4JRU0IcmHb9o3GteMHtSc0/kUD3/yg0WL1KhIlcj5
 4NP/lEukHuirf+MEgwTdfCrV90/KPBAzgG5dj6UUHJxemo20ljFlZY6qalqBFU434seHUKnAP5Q
 RTRRp/
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49cfa211d5fmr39915685e9.30.1788526083050; 
 Fri, 04 Sep 2026 05:48:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49cfa211d5fmr39915365e9.30.1788526082702; 
 Fri, 04 Sep 2026 05:48:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm6895039f8f.25.2026.09.04.05.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:48:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust: qemu-macros: remove redundant clone()
Date: Fri,  4 Sep 2026 14:48:00 +0200
Message-ID: <20260904124801.1144707-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This is reported by Clippy in the latest nightly builds.  Take
a reference instead of cloning.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/src/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index ee417bb4b4e..271125185ec 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -261,7 +261,7 @@ macro_rules! str_to_c_str {
                 }
             },
         )?;
-        let field_ty = field.ty.clone();
+        let field_ty = &field.ty;
         let (qdev_prop, bitval) = if let Some(bitval) = bitnr {
             (
                 quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO },
-- 
2.55.0


