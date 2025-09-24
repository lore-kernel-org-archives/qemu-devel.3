Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEC6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoL-0004aX-ST; Wed, 24 Sep 2025 05:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoE-0004XV-Bz
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lo8-0004l1-3V
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxCkSne5lIEz+6v/DtZSGsRBXxpV2mGxzrf4U3hlZ3E=;
 b=PEI6OK/gGyeNRZI/KglddCdc4j/Sq+mRFw9AHLTAnkRy30FaIWTaX574u3A/UJJCTJcMp+
 QarQUGwaJ0KL46uOW7npq4WRtCVuwUVAIEcw+GjY6jxq5+xiEmhZh4KhncohpuiHBAPIda
 2uQ/gSvKSmhNcTlN+7vyXFaMhte/1ks=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-VhKQ_cnYO02k3-A56ORUzw-1; Wed, 24 Sep 2025 05:28:59 -0400
X-MC-Unique: VhKQ_cnYO02k3-A56ORUzw-1
X-Mimecast-MFC-AGG-ID: VhKQ_cnYO02k3-A56ORUzw_1758706138
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2e9e07a887so205178266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706137; x=1759310937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxCkSne5lIEz+6v/DtZSGsRBXxpV2mGxzrf4U3hlZ3E=;
 b=Jgajjco0qRlGWIDcXrrEfGJy2dLZnI+d9gwsHWTEtoree76RSb/nAyIYjSfqp4UKw1
 92vPEQ6kxesDWlyP8+GiV3Ey8llZKHrvsZTr8p4Mj71epV0AO6pjYw+6QfZlCT977BET
 uNz5/Cek7z1n6VXoHEiGr7ugKg53fMhTAX8CNuwxdNVBVQsWw5Ph6bI6YIQpT7L7GJvm
 qQ6kzUUfWIcpOddcXuTYXffkx2GIq0KBXlIEo4z0GD9ppabzuMop2lR2kRE0VycMlNOl
 hUkO2llwAbAlGroAOem97bHoVHM7F+hPCJ+QfTWKMISBN4Yv2qhyMsBJb2AixG6nnKcH
 fttA==
X-Gm-Message-State: AOJu0YzS5WfJDd8yfaLn6Brf471Fk6VGOH5ERH/BggTTwOB9eMV8Xwpg
 X3/FTE+RuLPVW6icv7wbJBcdK4d8srVVeHGQCFZ0mQ5l4EBwoMjKe80GM87qZMu4MSYK3RKURth
 btQ0JDGJVpxVTopQMNEEvDq9OFu+rGbrHKdv4gpxvMWAILmUMrVoeyeglFIQyl/BWnmxga6R/Cq
 JsI1TKqgqPkQdxhB78r/m5IPH3Ie6avsXrHZsl1vQp
X-Gm-Gg: ASbGncsbeVfTUt9mUJxpKvjTVkCacvrj7ROiUyrKBhHX1cTmCI3MuqBBgxZH2LFuTuK
 x2WhJXf3UfsqV5khbG9a5BO3uDSa1bEeGr1zVHL50IaKDmF9/8ueSGLLhdlbkCCKVcr7hDhIi76
 DydLJTKqxJTzCc9bTGrzfrrpJsR8b1GmiyuUF2xQd8xuCG7srsE6Io1d3KXO3JXZMZTb56kPvw7
 zFJtBGx5C+X5dxdr/Wm2i/uSx9PIOBoMXRi0xzg3zXgEyUYXbxo82fCZOcuvmadDZcDQlj0osow
 VN2iUMWFSeIagJ7hsch7RWAA8S8v66vUvJPOJ551rW+wHDOOs1yOHFR3aRWV62UVp1xhYkCNsrl
 +0u81DDjK97Sa1PpoNkzcwMHX2SnjDgK5gMBSOl2Rfh3b3g==
X-Received: by 2002:a17:906:f590:b0:b2e:51cc:9b9 with SMTP id
 a640c23a62f3a-b3027d3e5a8mr550170466b.24.1758706137287; 
 Wed, 24 Sep 2025 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMW/EaiCphCU8LY3mf9U8MF3IfLZCXOhbU5+69ONTRLAqAHzNSWw8O9susRhfo321/NvySiw==
X-Received: by 2002:a17:906:f590:b0:b2e:51cc:9b9 with SMTP id
 a640c23a62f3a-b3027d3e5a8mr550168266b.24.1758706136793; 
 Wed, 24 Sep 2025 02:28:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3163e9b70esm236882566b.42.2025.09.24.02.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:28:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/29] rust: build: add back common and util tests
Date: Wed, 24 Sep 2025 11:28:22 +0200
Message-ID: <20250924092850.42047-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These were dropped by mistake when extracting the crates.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/common/meson.build | 3 +++
 rust/util/meson.build   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/rust/common/meson.build b/rust/common/meson.build
index b805e0faf57..07d073182ed 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -24,6 +24,9 @@ _common_rs = static_library(
 
 common_rs = declare_dependency(link_with: [_common_rs])
 
+rust.test('rust-common-tests', _common_rs,
+          suite: ['unit', 'rust'])
+
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
 # in a separate suite that is run by the "build" CI jobs rather than "check".
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 87a893673d2..96330504459 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -44,6 +44,10 @@ _util_rs = static_library(
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
 
+rust.test('rust-util-tests', _util_rs,
+          dependencies: [qemuutil, qom],
+          suite: ['unit', 'rust'])
+
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
 # in a separate suite that is run by the "build" CI jobs rather than "check".
-- 
2.51.0


