Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA5E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx4-0002AO-6Y; Sat, 27 Dec 2025 04:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwt-0001kL-Ox
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQws-0007Q2-Gb
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=Nk4pfqVnfrpDcneH5p8xQ8TO8UjLrV3LU6A0Iy0vGSxNWB/mNVBTKS5H4DoCr0IRbIF3HA
 LqWPjh7/48hqcrdEaZOrDKQSYq1u/AnHmVzMp7qq4O/l1ZEJiWjKq+aYxWvs8ucdI828pY
 bFn14OGSjF5PXgpGGY8g9dIRjlPF1vc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-AFC8PDljPIm83cFy8_MT9g-1; Sat, 27 Dec 2025 04:50:56 -0500
X-MC-Unique: AFC8PDljPIm83cFy8_MT9g-1
X-Mimecast-MFC-AGG-ID: AFC8PDljPIm83cFy8_MT9g_1766829056
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso53737455e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829055; x=1767433855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=Tb9O3K+q5q7ip9hfIKyKp7baCcraw73uBz288WTjCfbY0VDYT3M+TagNbHRZ4zuK11
 PxuJ1yYCq2dC0y9pn8cUE03cdvHOhSjuzV5ptFDIcVR1Q5o8UKx4HC/1WiqlbyMRc141
 Y/8NePHrp+NbsaXAYuyfeww/c/E8/YXdVfZWbMoO2Y+BhXMb7zznKosd4f5czwI1yrwk
 AGTr023LL/sruWOq0RgPgYYO78XxkoLl0yx3A+62SA6Au7e6alcqudCNeSe//h1OV++K
 hWccCIVr+jVxnlDoHSOyiDmBSu3V44ejhE9eJRQldEuLmnFuGesskV5f/6aWE48su9IU
 AhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829055; x=1767433855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DpAQdRPaPKRyiOmMwXXRBfnRYyd2O+ap7Xt42yFHf5I=;
 b=pbVWz/jVPIVC1qfDin98v3WvoqAP6cPqX7IU34GkkXykp8i91UmfE6RAc/aCJhmFoJ
 VIXjDLK7u6yZRjchAIPvGvMS3LkFtntnlAwBk7uql+AHIafogiQkwzIkyLbvejIQVBcx
 8tvmzxHLwCrKZgmbCe6w2b5hOIBJyJOhUuC1qU5NKpA1XvYAO+AwpP9b45PeoaSnxDau
 LwEZcN2hcslRlo+RU9Su1XJsSnQP0FNOrk4rWZ9AZqXx6nP/pYWy12QTtZ7IT93NHuvX
 XiNhhDKmwajfnlLN71w4HGyrblhbiPe7KoFdnyK5H0p4IKKRknORV4lpzLuFv2Z3NvPi
 3jhA==
X-Gm-Message-State: AOJu0YykJ6g2PKhRW3sVo2AIJa8owBY7djzewDgdGadjw/Ni6tlynN8X
 nLsjVVeYw50QgS83MRWxXHJs4DjYv0ZuBXy5Ww8XXPiz7CEEu355oSSXAg3LlzfwWyIAzYivrro
 Z0YOxWxAq37MRP2UpQGLemNv61pFJICLhBfz2RCE0A64ISe0hiBjICv8mMe1zYkW2EvVB/Wkt3Y
 PxlhpwX+gqQ2F5O+8WdQxvWddU1nLNjBLUAZBkTyAe
X-Gm-Gg: AY/fxX6KBqC2sF2atKvIzk6g6hREec0SsmObcVAh/vGXJHIzFZoW8uwuvTshR9ZwkaR
 Q9aUErXZC2oyhGASjk5K9ozgcfC2QjsDmGZArXWQeyKMR/8f9fV1fyt5+KfOtkaE0pacUzU8Czr
 235sktujdv1nkLXYSJGG6RVuKZyB8cpP3m4Zy4EbsWg6GFa0oKzwZmRbP4BUkDgonjhiKsYZuyf
 c+Tc6zSidd+XjbAD64bEeFHRh5EC/hqJ6el7qjZWWWDb3VAdtPaZbzhqaHYM5sZdgzEW9RNMh1C
 0kxrkPkSVUbG3/gaGz3Kxr1zfCztQY0cqXRbI2qh/3HaX+CtqJWNhatwhtQ+Zxv6aLzWApHhQ7x
 zCX6FOgJkZnLn09IIURRkNbJGhC8XcgwfkRGoWFF4FsYcqEVS7N5FxC8ZKIX7gonwUdlI4zv7uB
 v15aY5sagz1Juii6I=
X-Received: by 2002:a05:600c:8287:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47d1955578bmr327635215e9.16.1766829054883; 
 Sat, 27 Dec 2025 01:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI+DN2pO1c5bQG2hAXX0w9ude8mPCpP0RKLBxXRQAqFr8/3qw0MuJc7wWa5CCCqbw0ZzcDrA==
X-Received: by 2002:a05:600c:8287:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47d1955578bmr327634955e9.16.1766829054386; 
 Sat, 27 Dec 2025 01:50:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be395d9cfsm199755305e9.0.2025.12.27.01.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 133/153] rust: skip compilation if there are no system emulators
Date: Sat, 27 Dec 2025 10:47:38 +0100
Message-ID: <20251227094759.35658-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Otherwise, the Rust crates require the corresponding C code
(e.g. migration/ for rust/migration/) but the dependencies of
that C code, for example the trace files, have not been built.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/meson.build b/rust/meson.build
index afbeeeb47a7..bacb7879102 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,3 +1,9 @@
+if not have_system
+  subdir_done()
+else
+  message('Rust enabled but it is only used by system emulators.')
+endif
+
 subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
@@ -30,6 +36,7 @@ subdir('qemu-macros')
 
 subdir('common')
 subdir('bits')
+
 subdir('util')
 subdir('bql')
 subdir('migration')
-- 
2.52.0


