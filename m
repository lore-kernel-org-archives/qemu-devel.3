Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF33C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L0H-00012H-MC; Fri, 25 Apr 2025 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L09-0000o9-ES
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L06-0003dn-5h
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so2161381f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595000; x=1746199800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73ZgrR3ch11fDTtEvClWbxHlh9knWpF4UQGpqnZ7id0=;
 b=v8yWNi8Yq1N61eODNDN0nbB5A0cc0ndW/TVocTC9NKoVtCVHIqF9Yimu+PQjp9dGj1
 smMRm7CjlL27UxfyIrppdAMzgh8+VxpZZlA3lObbtsYL6P6T1Uo8d7xmAL7pHgj/jTAa
 qJAktFmxGF40pl4UhZYLIp1gyCSXAlzD4RDdRRlzxJn3RJJNacss/gr9iq6QXY9TemTw
 Npyw7Uo/ykarutE6Fk9Uba+/6+/kHZ85E895BjsZAgxcU1d0yCXKWP49qQIQm22V6yq4
 smw2XKCLjV4TGssRvwxQqTzxXkgdcyab9ix40NJN8F/ioejvJE2xaqU4MgteYi0Xi5iJ
 KmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595000; x=1746199800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73ZgrR3ch11fDTtEvClWbxHlh9knWpF4UQGpqnZ7id0=;
 b=WjlKJ7FG5g7KZnJeSl17VLYv12PTH//ry3wyw1Vglkt9l67YcosSgG7U53u27qZ5jm
 kVLEygeFDrYVakzkK/OnApsMjGMATEnTaaCiehBLPkAg1TM0HCZR5EBri2iItC05Pj3o
 k+tMYNnpFnqy+4kxY1+Q/wsZ5SklaD9YhF+qFEirSGb4J0FhcOF+ZdqB+5X9LasPzk/P
 smV7fjcqjrNd1CQLE3KvES20+7mMwB/3TIp0d2SupeRuhJWlQhC9v2GXIVxOpV5aHUFd
 6q8JLnGX7mTo+Z8mTsB9de4If87zSTdkElyrTqfh+ieGN6cD+IifMugNBygElIEcFtua
 iz2Q==
X-Gm-Message-State: AOJu0YymLxLDhFN3tjGmpOjx4OOib03yTLkqlM2GPobCtHNGBgXLPsZU
 p3ltN5frdSdgG9sEBjrt6FnCVdj64O875V7lkPbAJIOm/klicXzyA6zRppH9+7OGHs19SxQPbCe
 c
X-Gm-Gg: ASbGncvOpGlmHVGF7tRJFSo75RqPGM2EMvqvwzhBt2PiXdRrqYpNbTg9bMIDTEmfPTq
 JenI13GA6DlpnImQITqaMjVkFfYDr2aSQxNu9PP2k9Xs+8KZPn4aS1jThhLIj8pmjLQbgKU47gx
 3nuqUtqXKpWzbVm4PjYBAgearsXMOfxtoQ5PX2Tu44jQOCVJ6SVD5ErwLFW7nFROCRuR5VVO83s
 CCKOch+Rpbl+M53TzhTMTrmmCRYqKourg61xEvOpQg4zbi5rAOcSjriW3tFQwTg5cI7U4nxokuQ
 EVOLxGO38I2hY7s4RpSbKmN/iqfpF3h09I7bbsI2HAwCM7cVHsOq06iIBq5XBYiYwvvjjYYYBzn
 ywgXyfS+sHQsnUMQ=
X-Google-Smtp-Source: AGHT+IEQ9V1Ec+S0QpJVtMn4Wv72kCCIMjvBJsqMLezZNDjiXBi4eN0xVkE8MrrvKfbn/baSxcm5MQ==
X-Received: by 2002:a05:6000:1864:b0:38f:3e1c:211d with SMTP id
 ffacd0b85a97d-3a074e1dbcemr2597595f8f.14.1745595000004; 
 Fri, 25 Apr 2025 08:30:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc1842sm2725233f8f.54.2025.04.25.08.29.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/58] qom: Constify TypeInfo::interfaces
Date: Fri, 25 Apr 2025 17:27:59 +0200
Message-ID: <20250425152843.69638-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250424194905.82506-6-philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 2 +-
 include/qom/object.h           | 2 +-
 hw/scsi/megasas.c              | 2 +-
 rust/qemu-api/src/qom.rs       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 567a9b0a9da..31ec144509f 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -256,7 +256,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, const void *data);
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
 /* Register virtio-pci type(s).  @t must be static. */
diff --git a/include/qom/object.h b/include/qom/object.h
index 42b75d10a43..26a45f638cd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -490,7 +490,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 };
 
 /**
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index b024905a01f..a39e3e0e4fa 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2486,7 +2486,7 @@ typedef struct MegasasInfo {
     const VMStateDescription *vmsd;
     const Property *props;
     size_t props_count;
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } MegasasInfo;
 
 static struct MegasasInfo megasas_devices[] = {
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f0a79f96d5e..f1b4022157b 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -514,7 +514,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
-        interfaces: core::ptr::null_mut(),
+        interfaces: core::ptr::null(),
     };
 
     // methods on ObjectClass
-- 
2.47.1


