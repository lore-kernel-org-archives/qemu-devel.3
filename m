Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B934D105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drO-00041h-TY; Thu, 12 Mar 2026 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr6-0003r7-J2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr5-0000rw-0J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+ptTvPeIbxBvqE5tLDCF1S7byiSwUwcEB0ffGKajaI=;
 b=O9/vgQRZIIXY+MeksDSc0SALvNq3NlVV2yL8K5bXHJtrSGHYfI5ZUyBafQdsfODDebKtj7
 XzaAwm0068KnwUxKt0iJftO47aoH0zr7zbf0aaNZI5ngKoBloNL2f+bOWa2lPX4Nu1dvfI
 6RtK51s/SX5MuBtSk8O/1Livjqn7YLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-8HVTQW4qMqK5EqeLJUsTuw-1; Thu, 12 Mar 2026 07:05:24 -0400
X-MC-Unique: 8HVTQW4qMqK5EqeLJUsTuw-1
X-Mimecast-MFC-AGG-ID: 8HVTQW4qMqK5EqeLJUsTuw_1773313523
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so8268365e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313522; x=1773918322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+ptTvPeIbxBvqE5tLDCF1S7byiSwUwcEB0ffGKajaI=;
 b=Cm04j2myj4u+u4gm0LQc+5VBo7f94Z/kXNedjpIkk5GMXNrk4Kdjmd0rrGk62EfhVp
 whFN2m+i+As9iFdt4X9tBRRDetN+pAyWt8Dz5B0nJXIlwHC0RVjil9KhXJ2/ARVAvY9y
 e2+/hLEZxdK1h+zlBldWDwxu9cBVaXw/R5zZyJ7w3ENMqRz0WGeIMQ5EvO0X+SiAiD20
 Dur5UcNJnCf5AxFhPuC9iYG4aPgIA6A4bttDVDv028BwUX4eps0JawnupCiWF6Rz55o6
 sXR8/Xa6Eh6SbW67r1xMloAf2WeWo/HvulOp+GUj0LFkH72tpJtuKL/OpQhhidDbqRzB
 /4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313522; x=1773918322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+ptTvPeIbxBvqE5tLDCF1S7byiSwUwcEB0ffGKajaI=;
 b=Etz/WiA40t3+Jb2DVSCvlRB8JnuUKrWfyRcKD5+ns3YLfiImN//gVFnM5+Y8V1joZb
 afqzTybU7OkJl0wvNsKD5ojOAg5efS13Aw6qkcEvRYxEB7Y+Kdy2m6TDIxfeUq/osJ6B
 EZphjw0MrMHjIsSYEFoWrWng9+WtsHm4DbKC3gd7VO7HuWC3pevTmsxkoyHOD1VJ2N51
 zOOI47Svj6iW1yNBD4JjPRQctVFIKuUGknsofWNmWThuioGgpK65EYNBR4E60wIhfxxH
 gge8IdOPTTxqtFkhKR8kGeFMb/xFooQX31RX7kYSmFd7YECFE3rjMkClaAv8SoL7oM9A
 rCag==
X-Gm-Message-State: AOJu0YyYhaXMvjpIoT2FajxtelI5DLEZnl+7+LtMEr64vlF7SIvwlBxo
 i7zyZ5LwdoJWXVxC+ClR+89ff3csNHoHIdHTYxYaXTxtOaZwtiPayTcueXfb8KRkOWPasH8rLOi
 ovGjCqgGIunLhweN+gyobOfEfKfu18GrWEJ5NM/UhmZ9aKb8hZlbnnvQjFPqW+j/UzM0ruzRwxC
 gUGy/vVDQi1Fg25A7M1mMlEoZnW8QP+EaGmIYBj8MM
X-Gm-Gg: ATEYQzwM/P+MWydZwlKtBhyWcw5yO+QWbE+Fz85x4FCxVcWMkARIqYQflMiYYo/RihU
 qV22Q/vKhqqwcRyL3+MXFWo+2tmp3xLP7Z1CxQYH7Ndm8iOkUnUm5lVYoXkCp15MAwYGV5S85Cz
 /3j6mrNdeQj8aXAX65IpWVNnMO9dJ8A2HD7aDuJV/NAJ6GDfZW/TIXkhuZS2qExwBuUvqzW/vCv
 f9hcRJv0pw9GQgZ/wNG6oY8eWWZ++JhZLmbATypD0eTi6qFx2zCQ7piXEPjYgV4uqDAnBqdCbge
 g554dSWySQyR1+sJ3ahOe6C/0bb0xXDSq3ZO9/wyudf4ad/KqBauNN3pNZQWrIAFXYTtfZA6Jnv
 wtN3Yd/yoXHahiyFWk/Mc8KcTz8trlX0aoD5pUq9SWJC8LREMSaSA2j0eVruInI68KwBaKY2h3p
 7licVSK1waZ4TAgBzvLtnxz1G65cQ=
X-Received: by 2002:a05:600c:8a1a:20b0:483:badb:618b with SMTP id
 5b1f17b1804b1-4854b1b1185mr72193715e9.24.1773313522160; 
 Thu, 12 Mar 2026 04:05:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8a1a:20b0:483:badb:618b with SMTP id
 5b1f17b1804b1-4854b1b1185mr72193195e9.24.1773313521556; 
 Thu, 12 Mar 2026 04:05:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6b7sm278439905e9.9.2026.03.12.04.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 11/14] docs: mention that WHPX supports Arm too
Date: Thu, 12 Mar 2026 12:04:43 +0100
Message-ID: <20260312110451.685161-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260311102626.46546-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst | 2 +-
 docs/system/introduction.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index ae138ff0e02..6e3088d524a 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -43,7 +43,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - hvf, kvm, tcg, xen
+     - hvf, kvm, tcg, whpx, xen
    * - PPC
      - kvm, tcg
    * - RISC-V
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 2dfa371e0f9..be387a66458 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -31,7 +31,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - x86, Arm
   * - Windows Hypervisor Platform (whpx)
     - Windows
-    - x86
+    - Arm, x86
   * - NetBSD Virtual Machine Monitor (nvmm)
     - NetBSD
     - x86
-- 
2.53.0


