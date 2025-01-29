Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3A7C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3Ji-0006KJ-3t; Wed, 29 Jan 2025 03:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3Jc-0006IB-Tg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3Jb-0004EU-2k
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738138850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kmWDchkgNMCOHLnNxHT63tYJxxCZKeV/TOaAclkBW9w=;
 b=jQWF2Ss0bSnPjj2lR4DpD5z/ynxYlVNoDWJHIBNCNX+FWWnBjU0x7fJO5Z1aCV7lTlkx/E
 iaYpFgUYEUGmKLbpoPiVL8DvRWn4uzdnB6uu08ugeb/EgRRqmb2Rx2azzig5O8IrHaMtP0
 Sh/Wz9bqAY5bioxnjSV42dMOtxJPqfo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-pRVv5uOIN42CXlnyv7vcPQ-1; Wed, 29 Jan 2025 03:20:48 -0500
X-MC-Unique: pRVv5uOIN42CXlnyv7vcPQ-1
X-Mimecast-MFC-AGG-ID: pRVv5uOIN42CXlnyv7vcPQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so51136095e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738138847; x=1738743647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmWDchkgNMCOHLnNxHT63tYJxxCZKeV/TOaAclkBW9w=;
 b=KfLuKWK2TTJfbtRMT2c5LVY+oYz0H6nmhNzXkIqU60iOpddQzERNYGc7/HwsXgopY3
 R2u4V9RaSx3jLmMERuvXYMCOZt/aos+c8v4H5CrVNp3IpwhBpsaoIgo+nWPvB0RXk09J
 6NCb32rOUMej0OD2HbZIXAXScK069VFErXfR1Ig2BVkuHUqumVrinsbyQUcri98gzgjy
 0hEw0oHT/2YSRM0Gc/lUDHTSjE/bE9y/Z44ZWcWgmf4jeOYR9KSQ2QNllKyjTQmSEKIL
 zaxn5Yq27406IDjQDnuTSyPq4ARdvDvAV50Op9NcuKREs7WfOWZ4ViGl0FEJWVeugB3i
 3SBQ==
X-Gm-Message-State: AOJu0YwiIG+UcFhfkKB/+gUL4M4kYDbMcjfu/47MyUdUL8c81+GKD/5a
 sZik7RvBL+G57pegC6wC7Pdccmf2ywIoZMAlUrYBitPHlTYP4y4vWxtEDwcHkHr50RWB/SmyOeS
 cHnMVu6yEJ80Ot/oKon4Zn6eY9Co1fsNdCWRZxHC7Pgqv8K+iIpxeowPSv9PZFk9vbWa6Vb+72M
 mz/WUxMf99AZDCeVPKuQFRYxjomD6hiK5/aWc/GFk=
X-Gm-Gg: ASbGncuXlG+jNFDDkQlZ+kRlkupLOSU+vGkAyeRmycssoQklQbVL1TG/k12NjXt5U2X
 yUqKclgSF9/M8ZRWsQjK0+UfhouQGS9ds6U16yRADjUSzUVYC02kmSVXSjq486GNILvlt45nrdl
 jMFB/ar6occ7QmTKbbV/82ije49C7hfJ7as9NJSfEDJRM294U9cycS1kS2rihajJvC86k+JYdtt
 yXposOjwiVgpgBwg+tkatLcsWgAE6tif6i5hR5mtWFlFdxiM2TnvYqK1yRwjiS0dZx4cA/2bsEk
 SkvmAQ==
X-Received: by 2002:a05:600c:1d1e:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-438dc3bf129mr15945295e9.12.1738138847147; 
 Wed, 29 Jan 2025 00:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEweJxqvsTxtpXAZYVjRsKDWKJMu638NkLjAIdF/obghHTcAmSBVPrca+kwQ+jgaANhjGsSgw==
X-Received: by 2002:a05:600c:1d1e:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-438dc3bf129mr15945025e9.12.1738138846761; 
 Wed, 29 Jan 2025 00:20:46 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de7csm13675845e9.32.2025.01.29.00.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 00:20:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH] gitlab-ci: include full Rust backtraces in test runs
Date: Wed, 29 Jan 2025 09:20:45 +0100
Message-ID: <20250129082045.1319203-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b09..4cc19239319 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -63,6 +63,7 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
+    - export RUST_BACKTRACE=1
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
-- 
2.48.1


