Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F84E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvd-0006VX-Gj; Sat, 27 Dec 2025 04:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvb-0006U3-JF
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvZ-00072g-V2
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=gT3ZTZwc9NHbhRsK1mjuXqdhKfLPws7p4QW0XDARRR6YaeamPbePipJ73xyotRPuAw5lbi
 4yRQFT5D/QY38MJiO81qJW+6QaQqJszA7Fvb1SKRRHQzSx5nKEtaB7ZZuuHPCO4bRbNQHK
 tyLXujuNFBYTpzYmA4sakb5wZyHt2z0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-sdlLkZHLMhSoQbIEyZMIJg-1; Sat, 27 Dec 2025 04:49:35 -0500
X-MC-Unique: sdlLkZHLMhSoQbIEyZMIJg-1
X-Mimecast-MFC-AGG-ID: sdlLkZHLMhSoQbIEyZMIJg_1766828974
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so78151035e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828973; x=1767433773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=lEQyELETDjIgmUtCXxgvjCLREsh5kesG8YMrhYkhe4tNG7SXQFPf/g0u0FBfD+gOkr
 ciIQm4OP6l+yqQ1K3dm+yAQ+AKSB0NL0ZSw5K7UvorYQjaFnW/vYhsln8Z2SqPb1EDrv
 zhr4MB0CJNYQP6qtf1f8PGDmfG1JBmeWOxjFbw0HFdXg0zDE/GUk2gO3B0hSN7a8xC58
 wUl4JjlYLnzlTLwBOYsWuiyRbOmCajbdVdiVUbRNN239AnqGS3B0JyrgYkigk5AT8w+0
 emTWIUwYeQTPBSlNW7kSZK3NfecCG86ADkfH27wPVBS/1LM9RAbA5ZoHeB7RcXmx4I1g
 JoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828973; x=1767433773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0bWfEi5YvsxXPan+R5X2P9dFKSiDKmgH0HJ5Od8B3k=;
 b=paHMAaNQaRpG0gYGOQXt/DYbKPBV48Bpgw2HNxmdrwOpBwUQdcRJCLBIp3nXm6XFOQ
 BtjB/d/Ch2wCvsWVb6t/dgksm6dnzcSu4F+SZSwDiOi7Fj78O2n4OrGkjLjrwIrAC3vb
 7Q5RLL9nEO/8ScJ/5Z04+qF5MN28kyHM73JlxuaSnQyc+2d4r7zfo1oD+y5q6C+0sdPt
 PqIvLSXwH4rXMtvJlazRgLm12bFDb65y6BNHADBpa8A1PLPmyicnzyACJ6NGRPlw9sjP
 cb5QGUBinr7qtfKNyb0mm19QEszeeH0UWAdAZOYUgM9YhekTOfPdDxsbW4SLe62gs2P8
 B2pA==
X-Gm-Message-State: AOJu0YwTL1pTrLKAOXU6dzDULfh/ThAnhwLtGRg60/QxzZYrB0JwhWMa
 1xMb/X8vu2FAFjbnlT7Ua4qr5OHDTC7oDamOUWRnOwJ1NEWn7zL4MsfquyjyeiW7h02FsixbfWI
 u63GGvXdS1T1Sr9cDyvAH5YsWBw+lROl+s3tJIC7GZmgwoZ85Is2q2aAg0CVARBGwGmU00lwv+o
 nJ86NJDMvpokhbKlpJb8eVMSimCO4SMZfLx9OdauO2
X-Gm-Gg: AY/fxX5zxvgalgiyHT3zNemRBCEx5v4eWuiNG67BVkQjzP1Z6MqBcHxQneCmpqAhzCe
 1AFT199onLbT8ie7zcPaGC9x9+u4i+pyOZPNgoWnjxPAtkduqpvASnrmLyb4bRW3SXb+YovI3gf
 gzmjoAwvho8nog8S1Chq5+9NgtnEUP1OJrflyPH8cgWESadeX2eH6SWkw8t/q/HgO4pS/Pef7Me
 uvJTuR3oFsUDwXZPtH6gmUuibWrqeXrn0lBoFaE76msyyOO3IDypEOTeTgAC+bJZ3vUjX05ubKs
 QEdprlid3OJ31KjHIkL8sIKnslxN+Ubu5yeCpUkS9XkPUX4cqW76Rq0S6GNgqHlF5nn7rBYfMtB
 GBzlqSjcw6v3zgy2DRqllNTtI8h+YULUXT9vZQw0px7IPv9ZlSP3G8bdtjtq8b9okXCS7IPdt8+
 2O5UN2yBOZU+G9FSA=
X-Received: by 2002:a05:6000:2303:b0:430:fdb8:8516 with SMTP id
 ffacd0b85a97d-4324e506039mr30790673f8f.35.1766828973594; 
 Sat, 27 Dec 2025 01:49:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGICzT7ij9aA5fzIIvS1TMixAA16ETdMeOCS2yKrIlr6Y139X5eiemr4rOmQdNohDKbEK2UPw==
X-Received: by 2002:a05:6000:2303:b0:430:fdb8:8516 with SMTP id
 ffacd0b85a97d-4324e506039mr30790652f8f.35.1766828973184; 
 Sat, 27 Dec 2025 01:49:33 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1af20sm47315517f8f.2.2025.12.27.01.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 109/153] lcitool: enable Rust for Windows cross targets
Date: Sat, 27 Dec 2025 10:47:14 +0100
Message-ID: <20251227094759.35658-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The issue that is mentioned in the comment has been fixed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora-win64-cross.docker | 2 ++
 tests/lcitool/refresh                              | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 4f743c00434..c5e1fcebf51 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -120,3 +120,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9df607a55f8..01a71929542 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -291,10 +291,7 @@ try:
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-                                            "x86_64-softmmu"),
-                        # linking with rust is buggy:
-                        # https://github.com/mesonbuild/meson/pull/14991
-                        enable_rust=False)
+                                            "x86_64-softmmu"))
 
     # We also generate some docker files with minimal dependencies and
     # as many cross-compilers as Debian will package for building TCG
-- 
2.52.0


