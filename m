Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57761CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSJ-00061r-Kf; Mon, 08 Sep 2025 06:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSC-00060O-LQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZS2-0005x4-MI
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVpnMdG2AHYpvMFodnCVPf0A2jarENFLPLqWFsrrhQw=;
 b=Z7zixlUocXvTpqPJZDeXZsQUZgSvmdhCi9dLkiVIWMjb00Y/oOZWH9GoxIPVyCoAnsyh1S
 je1T9zthvYER45Omv0v+2VrXSP8CdiXJqnu345B5F5h6Xlf+RQPpR3vzWBB8gznmnFMjnv
 5EJYV2+i6p6uGvvas72nuLUIb2o3CrA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-R9WaXgtSP_Wr_1VTO_3eIw-1; Mon, 08 Sep 2025 06:50:10 -0400
X-MC-Unique: R9WaXgtSP_Wr_1VTO_3eIw-1
X-Mimecast-MFC-AGG-ID: R9WaXgtSP_Wr_1VTO_3eIw_1757328609
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso20704765e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328608; x=1757933408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVpnMdG2AHYpvMFodnCVPf0A2jarENFLPLqWFsrrhQw=;
 b=G1GbNuYysipI++DWGJ2UudUo+aK1pgo5yDDsYOZXnPOIUFZLPWiT2EElHqNgqxLJiA
 VOjzjM3xRxI68SdPEIbdarOGTtOnj4vcsCDyBTgSZay5ctcfX2nJugFAaY1+xv5TpiLd
 NBwAx6VGPbRvCv7+xGIlgiQHIq7RpRGdXvwLNlfjDbY7m+IHOS4iN+CXb6R4Dw/bGUpu
 /F8pdVDEbT0lbY4pRleq3Qd5UN/AaEfIJmgzKGbHidY3Rvn4NWiyivx7Mr+kd3s4OWo9
 TGTmCaRjuVu9SATgx7ULFPSKeRf+6oyECuYspGG8W+oWzR/Q7ZJ3Jkeaa3SpgIZiQEzq
 5UTw==
X-Gm-Message-State: AOJu0YykdxP22khuZHZuvc1knIGN5k/6eY7tjtQzveaMYVGTDPv37qxN
 IMSmPCD+8EYv0jq9yms0c4XYH66BY7g7qWA1waOmmZl0nyeY+U9UrnuPQiLaVPnTv1lJs975h6P
 TNMMPSiLmLiha/W4XsZMITQu0aLD9HvTRSd27M3wfgpf4J+AFRYiGQGomcD/Vak1ozI/EuFlvEu
 WgVcNA2oIwyAiVl7WTfK3yaysGE5pOARFShFnbdrKw
X-Gm-Gg: ASbGncsFK7oosdI5dCygxKdgyKPUFRbWW6pNmSML0Ao/z0yc8Tp2RSNNyVS3WmeqPPR
 3tUU2rm8ap5uUlp+/LAQYvhRR63xaG+g5Cxlm4/qaQc6Lj04gzYmTcHu0DS56aIVNmSwHCsPwUO
 Lh+98Wm2ySGm74+ZwhkBshLFMHXR+Z0ppeqNfO5V96vpDf6qozXYX9NoDY1PusX0SwEz4PKf6h8
 ONZzziXvdjezHDpPa0laZLI/60ZyjRYz8UWpV97N/iO0qvhTGYJhZUMc7ywnEo6mb+ofSn5Tkzp
 oIPFGPwQYffKP2wVdv7G62Qcoq2U+jQ70YakC5bY1Xqi5RUAEe0KA9VnplOIth9bM8UfDZhmWrb
 OCMc9FD7m+RQN+vMonGvKM6mBy/pyJsWfd7L4b9gKmL8=
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id
 5b1f17b1804b1-45de110e75dmr48761245e9.14.1757328608474; 
 Mon, 08 Sep 2025 03:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgQ0qn4t18SGH709o1Hi2rlbWvtC1u06LbW1J/km0098TNSUANF5g2CVBKZZGCLYf3fYsUFA==
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id
 5b1f17b1804b1-45de110e75dmr48761035e9.14.1757328607969; 
 Mon, 08 Sep 2025 03:50:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de16b8b58sm83470415e9.4.2025.09.08.03.50.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/33] ci: temporarily remove rust from Debian and Ubuntu
Date: Mon,  8 Sep 2025 12:49:33 +0200
Message-ID: <20250908105005.2119297-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a600637..47dbba9d0db 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -39,9 +39,9 @@ build-system-ubuntu:
     job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
-    CONFIGURE_ARGS: --enable-docs --enable-rust
+    CONFIGURE_ARGS: --enable-docs
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
-    MAKE_CHECK_ARGS: check-build check-doc
+    MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
   extends: .native_test_job_template
@@ -69,7 +69,7 @@ build-system-debian:
     job: amd64-debian-container
   variables:
     IMAGE: debian
-    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
+    CONFIGURE_ARGS: --with-coroutine=sigaltstack
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
       sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.51.0


