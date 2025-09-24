Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B40CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lp9-0005OW-L0; Wed, 24 Sep 2025 05:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp7-0005Nu-D2
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp0-0004qZ-0Y
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8cEfG6CElNn+HuO5d12EMpl/GXUm1guGpqHc+tS2vE=;
 b=dGhEq7vwqz+Qf04vDB7unaj9XFC6W23S6sMicFQc8R+e3Dw+v4sV4189aUTmxIWj20V53e
 nTtG6wsIb+NtjyrCMy7elU5Q8O42pABqMifff9YlLoppHtQrr+3Odszfre1a6xyzPa+r+s
 YxwHP2icmDa5Sltwbgo1H415WAff68E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-KRsb8OqoOaOFSpE-DSDJEA-1; Wed, 24 Sep 2025 05:29:54 -0400
X-MC-Unique: KRsb8OqoOaOFSpE-DSDJEA-1
X-Mimecast-MFC-AGG-ID: KRsb8OqoOaOFSpE-DSDJEA_1758706193
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6345ebdf489so2327362a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706192; x=1759310992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8cEfG6CElNn+HuO5d12EMpl/GXUm1guGpqHc+tS2vE=;
 b=S1Kk4d7k7H6Eb07oHzB52+YFHF3aLpY6RL6JPx+0lHVZtH6lYmd8s6zddB60JuNsMP
 O+eARMPC1XitnIVBr+sZBc0//PtFWTg2LR1tyOR2N9X+cJVyzaRWecFRqHNtJry8vUVe
 qjDCWYiLXtm2w1zjCM+j42y5qowIJ7ilkrw63KTD9X2XotKINP/jlqC/u4PlQQ1i1rX3
 +kBG7+tLSYtMRTSdm6672M3jYiRHWkjnrRmXGLm1p9fcoYV7oyk53x/LzIrR4nTakgwV
 75FLFJ30DnpVLVEB3iGSwbqnClTdBlpbLxBlhm1iNHZrkuutW76L5wlb/+CMKtzCwECZ
 E4BA==
X-Gm-Message-State: AOJu0YxzO+Rx7ZNeuXUY2FwQUVrbdifXkjp1oNNlsaHjf6ABEMyEMTd4
 JjVl7jFlbpOXTmwZcf4P53nD1DB03qZwqFUfb88KmjEGmUXLg1LrNbemJ6TdlsEPNd7kvWDzJpT
 n5Sp1fpKsb0WxInIttssTPPSZNu4V2OQ9Jn3QVZd3XuQ737Hzbsw1nVwGM5RSOpL211H9k0K+Sh
 n3EqGFgTcwH/HA1VbXT2D7JhDrRLCuKejWRAxPPVgb
X-Gm-Gg: ASbGncsUTNxGeVEFEFmWAPmN+G4u7P8Ix8q12ZDcq9ELVlbsqnPVvPUP9LKrW88iOWJ
 Go2vVyTjhbBvz8YiXRzaoDRwIavLe+azEJqeLMhIj12Q1Y9b5MkC65E/9bdnVwSkoOgOFqKKMUu
 AEQurLo8zFeTTZBi1WyZVEzobaOsbgKpdMV42KRPtFy4aVPRdKYZGhUBuwZGy8N5RtuK/UmMmMD
 8u4BUUF2jNDdPgKGNggW3a8VH66PTJlvXvMwhiDSyyPqY/1sfcnGkTBIIE4q/tcFKFQsd1oFIq4
 emBSEAwd69gg3L1FGIKT6vRHj0T/cujOBr7NqxaOdybuNEOJvmbpb/hUwfikbaXC++VJGiIbpmw
 Cahy881BDIMhN0Ga8r7OKzkut98KiQJ7YLNWSRhwAHAq9cw==
X-Received: by 2002:a05:6402:5246:b0:62f:26cb:8072 with SMTP id
 4fb4d7f45d1cf-634677b5849mr5033808a12.13.1758706192583; 
 Wed, 24 Sep 2025 02:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjVEYltsJo1r+6P6oKmTUcpZaXo+ShhEFNdBI4+yNKm2nKg1uTx1QkX0y7LQR5Kt3m7vec1Q==
X-Received: by 2002:a05:6402:5246:b0:62f:26cb:8072 with SMTP id
 4fb4d7f45d1cf-634677b5849mr5033733a12.13.1758706191284; 
 Wed, 24 Sep 2025 02:29:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63469f30772sm2789490a12.22.2025.09.24.02.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 20/29] docs/devel: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:40 +0200
Message-ID: <20250924092850.42047-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Remove the instruction to call object_unparent(), and the exception
of the "do not call object_unparent()" rule for instance_finalize().

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-1-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/memory.rst | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 42d3ca29c43..f22146e56ce 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -165,17 +165,14 @@ and finalized one by one.  The order in which memory regions will be
 finalized is not guaranteed.
 
 If however the memory region is part of a dynamically allocated data
-structure, you should call object_unparent() to destroy the memory region
-before the data structure is freed.  For an example see VFIOMSIXInfo
-and VFIOQuirk in hw/vfio/pci.c.
+structure, you should free the memory region in the instance_finalize
+callback.  For an example see VFIOMSIXInfo and VFIOQuirk in
+hw/vfio/pci.c.
 
 You must not destroy a memory region as long as it may be in use by a
 device or CPU.  In order to do this, as a general rule do not create or
-destroy memory regions dynamically during a device's lifetime, and only
-call object_unparent() in the memory region owner's instance_finalize
-callback.  The dynamically allocated data structure that contains the
-memory region then should obviously be freed in the instance_finalize
-callback as well.
+destroy memory regions dynamically during a device's lifetime, and never
+call object_unparent().
 
 If you break this rule, the following situation can happen:
 
@@ -201,9 +198,7 @@ this exception is rarely necessary, and therefore it is discouraged,
 but nevertheless it is used in a few places.
 
 For regions that "have no owner" (NULL is passed at creation time), the
-machine object is actually used as the owner.  Since instance_finalize is
-never called for the machine object, you must never call object_unparent
-on regions that have no owner, unless they are aliases or containers.
+machine object is actually used as the owner.
 
 
 Overlapping regions and priority
-- 
2.51.0


