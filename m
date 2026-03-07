Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0A1FCB63F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnP-0002LG-G0; Sat, 07 Mar 2026 10:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnM-0002II-LK
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnJ-0002an-KP
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483a233819aso101063835e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898139; x=1773502939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QMzd5YEWPj9Xk6Qsl6F51AjQBHHbgm82IdFibYrq5I=;
 b=uJHILmkzmP3gQ8oppduaBpM6UUutsq+jFpiuh+7s562t9ANNXfHZCVAISU8jtu/Wg9
 cD275ODc25VzIxufnDCtv+DS7JBP2Fu51rJ9HZr0r4rPp7WJ0U3nl52p0r3LaYJXVDES
 4KpwZo9fQ/o7m3K9VsJ68memv1tQcFCTMsU5OpoIZbxuTyh6YbkElVZYlSHHOEh46c84
 p7iJi2wbNmpBSgYbwI6YQgrVbuMUuIlZpzQOFw5Hw1f937fys2N4TK5hg+P1wGlDXHkF
 hK8anmm2GZ9ROkwYToFYopyblfPA+voCfIPRnaV/d1fP7nkfBjR3nvzuh0XYUkFh2IGi
 /cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898139; x=1773502939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QMzd5YEWPj9Xk6Qsl6F51AjQBHHbgm82IdFibYrq5I=;
 b=a5yQ5gocMIEwLjZcEMDQ2ehyXkeHBpxiKbOWzZwWTW31Lf0cszQnE3zsmgSIsDHzSU
 y9ln+AQmpQmSvubJxOrSZHEgtzvStWZNgTvN2kidqnzUcTrIPAdp4+3wSkwEIHxcHJVA
 2kYk7dgz6dU7Yi470P3iqIZEs8pCzvKCcXSafo+ZOeT17iePD/twbUvAOwOK1HW+7nlu
 chTCzBUyDyAeYgFd6xMHWdbHM9iiYHKSPGopHNqrAcNqy6PgqQRQqx4+F+tcoDCmrTXl
 5xc1ZxmeXmwrKrZKOK8+MIr3xM/CgOlfOGIAqAapipKdxAc1pulVSruwoJHy4EiNPlBT
 UzLQ==
X-Gm-Message-State: AOJu0Yy/XT7dM5pqyUibDFhVZ+OLtSVbzDEoBR6SaFZf0KNE0B74vUZm
 2LTK2lJG4IYt2KPMRnp94+1i7g2sAWaFVtlPi+k7K28NKpx9aikxTYaUZ/U2fqRGwJ0RP9FsHxk
 ZT4HBR+g=
X-Gm-Gg: ATEYQzwL+YddNe/9f3U46ZBTURh/2kGGDxsR0sUiXej+py2VXT4QOEIKymrCjDS3rwh
 etpomgSvrQxvx0tcbsCeLn32BIuJYbKSkL9CdXs4yCnkXM2IlDUjq1DXA+VTuGMH6ITsGJ8GAmt
 ZPcT43XG8nUcYAI6Nyqg9Il7kcEPXHBhWCtffeiGuMKHH4OCUahi6ThBP28IriuNpQLmp4SGp1u
 9bd9ZTPs9hyE5MB+Z6V3IZt700DaJTRHy3ZI68ic4Ev802PVtoEPhebsCpmkJ8RtsMKusf2cXNe
 qOrAd/nqwqa1UWh2ZMmpihqMEoxrnxytMbxomO0DnNUgohdp/MO9wx11Z6P0Rv5Kg1hhnXxw6kg
 QSJosgZ1Io5bckLNare3r8rvfleVyQ8w6i1YQ+HYFrrfX7YbqhAfzVCBINh3BeZL7sOEsn5QDbk
 9T07XaicCvIAZmshAO2zFGW3L/ofPiNN6B7RJpVRGAum9/3uYgo6bAqCbAQ7ygFAEb1VW7zmjN
X-Received: by 2002:a05:600c:45c6:b0:483:c35d:3662 with SMTP id
 5b1f17b1804b1-48526957c37mr92738305e9.18.1772898138847; 
 Sat, 07 Mar 2026 07:42:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm110315295e9.8.2026.03.07.07.42.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/6] system/hostmem: Remove
 HostMemoryBackend::use_canonical_path field
Date: Sat,  7 Mar 2026 16:41:58 +0100
Message-ID: <20260307154202.86309-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The HostMemoryBackend::use_canonical_path boolean
was only set in the hw_compat_3_1[] array, via the
'x-use-canonical-path-for-ramblock-id=true' property.
We removed all machines using that array, but the
comment added in commit 8db0b20415c ("machine: add
missing doc for memory-backend option") requested to
not remove this property "as long as 4.0 and older
machine types exists". Previous commit removed the
last machines in this range, we can now remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/qom.json            |  8 +-------
 include/system/hostmem.h |  2 +-
 backends/hostmem.c       | 34 ----------------------------------
 qemu-options.hx          | 10 ----------
 4 files changed, 2 insertions(+), 52 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85d..3e13e3fd25c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -660,11 +660,6 @@
 #
 # @size: size of the memory region in bytes
 #
-# @x-use-canonical-path-for-ramblock-id: if true, the canonical path
-#     is used for ramblock-id.  Disable this for 4.0 machine types or
-#     older to allow migration with newer QEMU versions.
-#     (default: false generally, but true for machine types <= 4.0)
-#
 # .. note:: prealloc=true and reserve=false cannot be set at the same
 #    time.  With reserve=true, the behavior depends on the operating
 #    system: for example, Linux will not reserve swap space for shared
@@ -683,8 +678,7 @@
             '*prealloc-context': 'str',
             '*share': 'bool',
             '*reserve': 'bool',
-            'size': 'size',
-            '*x-use-canonical-path-for-ramblock-id': 'bool' } }
+            'size': 'size' } }
 
 ##
 # @MemoryBackendFileProperties:
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac78..cafcf9c9c74 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -74,7 +74,7 @@ struct HostMemoryBackend {
 
     /* protected */
     uint64_t size;
-    bool merge, dump, use_canonical_path;
+    bool merge, dump;
     bool prealloc, is_mapped, share, reserve;
     bool guest_memfd, aligned;
     uint32_t prealloc_threads;
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 15d4365b697..7da7cd54e05 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -40,10 +40,6 @@ QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_INTERLEAVE != MPOL_INTERLEAVE);
 char *
 host_memory_backend_get_name(HostMemoryBackend *backend)
 {
-    if (!backend->use_canonical_path) {
-        return g_strdup(object_get_canonical_path_component(OBJECT(backend)));
-    }
-
     return object_get_canonical_path(OBJECT(backend));
 }
 
@@ -484,23 +480,6 @@ static void host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
 }
 #endif /* CONFIG_LINUX */
 
-static bool
-host_memory_backend_get_use_canonical_path(Object *obj, Error **errp)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-
-    return backend->use_canonical_path;
-}
-
-static void
-host_memory_backend_set_use_canonical_path(Object *obj, bool value,
-                                           Error **errp)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-
-    backend->use_canonical_path = value;
-}
-
 static void
 host_memory_backend_class_init(ObjectClass *oc, const void *data)
 {
@@ -563,19 +542,6 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "reserve",
         "Reserve swap space (or huge pages) if applicable");
 #endif /* CONFIG_LINUX */
-    /*
-     * Do not delete/rename option. This option must be considered stable
-     * (as if it didn't have the 'x-' prefix including deprecation period) as
-     * long as 4.0 and older machine types exists.
-     * Option will be used by upper layers to override (disable) canonical path
-     * for ramblock-id set by compat properties on old machine types ( <= 4.0),
-     * to keep migration working when backend is used for main RAM with
-     * -machine memory-backend= option (main RAM historically used prefix-less
-     * ramblock-id).
-     */
-    object_class_property_add_bool(oc, "x-use-canonical-path-for-ramblock-id",
-        host_memory_backend_get_use_canonical_path,
-        host_memory_backend_set_use_canonical_path);
 }
 
 static const TypeInfo host_memory_backend_info = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 890c4f1d230..dce5d8cd5d2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -137,16 +137,6 @@ SRST
         * as backend id one shall use value of 'default-ram-id', advertised by
           machine type (available via ``query-machines`` QMP command), if migration
           to/from old QEMU (<5.0) is expected.
-        * for machine types 4.0 and older, user shall
-          use ``x-use-canonical-path-for-ramblock-id=off`` backend option
-          if migration to/from old QEMU (<5.0) is expected.
-
-        For example:
-        ::
-
-            -object memory-backend-ram,id=pc.ram,size=512M,x-use-canonical-path-for-ramblock-id=off
-            -machine memory-backend=pc.ram
-            -m 512M
 
     ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
         Define a CXL Fixed Memory Window (CFMW).
-- 
2.52.0


