Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6BE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN29g-0007vM-Cd; Sun, 15 Dec 2024 22:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29f-0007uu-LF
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:52:23 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29c-00063E-Be
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:52:23 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f2d5b3c094so769361eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321139; x=1734925939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WKxMv7NfWNW6RW220XWcTB/ZTdPeQbEkGYms6s0BQA0=;
 b=h8WQ0v4jdQg+a5xxVz0MfM24l/f11EiN6vVAkxE4WXAcnAn5zAGhsATXMbIyWVFtwp
 JhiMFplgBgqJHC1eqmwloEJ2FngRTfkEdBNuvx3fnI+YMuhMpCnWXGN72i660hBiKQhR
 I+mWmnf/ws7syukEnT1OAhPsa8jsGe9iUcZuPESEsUuWyHCjC4pvzNZqvMmcSBfz7gdl
 kfd8F7cs8s942ojA4X5eHuMQZ/ynCzqrk9+QyVVh/v2uYU/EHcdMaajwit7WVhvZARf6
 1awkiacIdVYKM//nc744qWI0HNkTY4Tbf7WEBaTw2MhicQ19Y0JTx4t3iCu/V2mVBFtH
 q1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321139; x=1734925939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKxMv7NfWNW6RW220XWcTB/ZTdPeQbEkGYms6s0BQA0=;
 b=vDMCef0Cr8hv+p03il252u/aMSQvIE+pibvt7Dte6zr1v104Nce32ii0hkYqze0maV
 /4vojCpuNK/qi05l+pnJu6Mufxk0JlJ0f1KYFbVgIzvakUsdlD1o+bI5tJv6ccMVHkan
 Y3FDHCBiQXShZrn0J/AvUDu+vPkKE9eCkvVEB+5tH174sjxzJvJSusD3Ku077t73+n3t
 dVPNZfPjYkYIarL9vd6UqiETgscgvmnXsW8lWBNZeIalObq3mdoU2uTGZRrSMkPUjvos
 spJ+Zk29WWZx8LsHmVK+RdhHOTGgZtjRG39qHFNVahCoZ70nmsT14DQzZuwcgG4goCs1
 V1Lg==
X-Gm-Message-State: AOJu0Yxaps0oLFDO8nMo3vHSTRhnHKV8df+ZI2GRFv80HhnpixA2gXW8
 lOcV6zIaMEoZcRUJvHf6+w4+TXYukg0cjdjLd7HG5EQVcihjcYCMO9Kc04huTytuKCZdY3D6Lk8
 rmvjQYxh4
X-Gm-Gg: ASbGncv1DSftz7TP5XIMgQfxlX091VQCqR9dnEXgtbfk4vJWFUaSS06h6b1QHXaI1vp
 wOJNdk/6+OsyPnm5zvWROW32nH+R2XISoReqh3Dfu3ucxMBslU/yRLTwDOhM9RYRl4SPql6meUD
 ahBDesX/PiuPaI7h6ELMZZ1vVIAwiKZtlVJ0vQr0+XMUlIRj2aAAtUOQnwblM+DdF8dH1og3yGG
 yKA6YvaRCx72y6qH0U31xH7SN/LqgRuYkCrB7oITEJU/xhxVQaQOIg541+GvnLzrouCQu7C6aEj
 xpsvu+0jBAe60ZbMjfhMy0cbnKIk3Hwt1O8jmPVDWJk=
X-Google-Smtp-Source: AGHT+IELZFZLULcp6I6RJJScoq3iuS3UBd9K0qlvJj5NO6gJ0JKnusk1JuY8byg8djt91fPpf+BIEg==
X-Received: by 2002:a05:6870:2104:b0:29e:684d:274d with SMTP id
 586e51a60fabf-2a3ac5dae5cmr6160433fac.11.1734321138814; 
 Sun, 15 Dec 2024 19:52:18 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.52.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:52:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/24] Constify all opaque Property pointers
Date: Sun, 15 Dec 2024 21:51:09 -0600
Message-ID: <20241216035109.3486070-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

  s/  Property [*]/  const Property */

Basically all of these only feed object_field_prop_ptr,
which now takes a const pointer itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 backends/tpm/tpm_util.c          |  4 +-
 hw/block/xen-block.c             |  4 +-
 hw/core/qdev-properties-system.c | 48 ++++++++++----------
 hw/core/qdev-properties.c        | 78 ++++++++++++++++----------------
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/nvme/nguid.c                  |  4 +-
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  4 +-
 hw/vfio/pci-quirks.c             |  4 +-
 9 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index cf138551df..485982b17b 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -46,7 +46,7 @@ static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     TPMBackend *s, **be = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -66,7 +66,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 
 static void release_tpm(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     TPMBackend **be = object_field_prop_ptr(obj, prop);
 
     if (*be) {
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 56a6713660..ec3413f116 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -485,7 +485,7 @@ static char *disk_to_vbd_name(unsigned int disk)
 static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -545,7 +545,7 @@ static int vbd_name_to_disk(const char *name, const char **endp,
 static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
     char *str, *p;
     const char *end;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1034e9b580..1bae135276 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -90,7 +90,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
 static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
     const char *value;
     char *p;
@@ -116,7 +116,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
                              void *opaque, bool iothread, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
     char *str;
     BlockBackend *blk;
@@ -225,7 +225,7 @@ static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
 static void release_drive(Object *obj, const char *name, void *opaque)
 {
     DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     BlockBackend **ptr = object_field_prop_ptr(obj, prop);
 
     if (*ptr) {
@@ -269,7 +269,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
     Chardev *s;
     char *str;
@@ -305,7 +305,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
 
 static void release_chr(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
 
     qemu_chr_fe_deinit(be, false);
@@ -329,7 +329,7 @@ const PropertyInfo qdev_prop_chr = {
 static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     MACAddr *mac = object_field_prop_ptr(obj, prop);
     char buffer[2 * 6 + 5 + 1];
     char *p = buffer;
@@ -344,7 +344,7 @@ static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     MACAddr *mac = object_field_prop_ptr(obj, prop);
     int i, pos;
     char *str;
@@ -406,7 +406,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
     char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
 
@@ -417,7 +417,7 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
 static void set_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
@@ -485,7 +485,7 @@ const PropertyInfo qdev_prop_netdev = {
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
     char *p = g_strdup(audio_get_id(card));
 
@@ -496,7 +496,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
     AudioState *state;
     g_autofree char *str = NULL;
@@ -578,7 +578,7 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
                                              const char *name, void *opaque,
                                              Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
     int value;
 
@@ -614,7 +614,7 @@ const PropertyInfo qdev_prop_losttickpolicy = {
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value;
 
@@ -737,7 +737,7 @@ const PropertyInfo qdev_prop_zero_page_detection = {
 static void get_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     char buffer[64];
     char *p = buffer;
@@ -753,7 +753,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
 static void set_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     const char *endptr;
     uint64_t lob, upb;
@@ -815,7 +815,7 @@ const PropertyInfo qdev_prop_reserved_region = {
 static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     g_autofree GenericAlternate *alt;
     int32_t value, *ptr = object_field_prop_ptr(obj, prop);
     unsigned int slot, fn, n;
@@ -895,7 +895,7 @@ const PropertyInfo qdev_prop_pci_devfn = {
 static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
     char buffer[] = "ffff:ff:ff.f";
     char *p = buffer;
@@ -921,7 +921,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
 static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
     char *str, *p;
     char *e;
@@ -1011,7 +1011,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
 static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
@@ -1045,7 +1045,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
@@ -1093,7 +1093,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
 static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
@@ -1130,7 +1130,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
@@ -1181,7 +1181,7 @@ const PropertyInfo qdev_prop_pcie_link_width = {
 static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
     char buffer[UUID_STR_LEN];
     char *p = buffer;
@@ -1196,7 +1196,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
     char *str;
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 61929b2865..434a76f503 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -61,7 +61,7 @@ void *object_field_prop_ptr(Object *obj, const Property *prop)
 static void field_prop_get(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     return prop->info->get(obj, v, name, opaque, errp);
 }
 
@@ -78,7 +78,7 @@ static ObjectPropertyAccessor *field_prop_getter(const PropertyInfo *info)
 static void field_prop_set(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
 
     if (!qdev_prop_allow_set(obj, name, prop->info, errp)) {
         return;
@@ -100,7 +100,7 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
@@ -109,7 +109,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
@@ -131,13 +131,13 @@ const PropertyInfo qdev_prop_enum = {
 
 /* Bit */
 
-static uint32_t qdev_get_prop_mask(Property *prop)
+static uint32_t qdev_get_prop_mask(const Property *prop)
 {
     assert(prop->info == &qdev_prop_bit);
     return 0x1 << prop->bitnr;
 }
 
-static void bit_prop_set(Object *obj, Property *props, bool val)
+static void bit_prop_set(Object *obj, const Property *props, bool val)
 {
     uint32_t *p = object_field_prop_ptr(obj, props);
     uint32_t mask = qdev_get_prop_mask(props);
@@ -151,7 +151,7 @@ static void bit_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *p = object_field_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask(prop)) != 0;
 
@@ -161,7 +161,7 @@ static void prop_get_bit(Object *obj, Visitor *v, const char *name,
 static void prop_set_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -185,13 +185,13 @@ const PropertyInfo qdev_prop_bit = {
 
 /* Bit64 */
 
-static uint64_t qdev_get_prop_mask64(Property *prop)
+static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
     assert(prop->info == &qdev_prop_bit64);
     return 0x1ull << prop->bitnr;
 }
 
-static void bit64_prop_set(Object *obj, Property *props, bool val)
+static void bit64_prop_set(Object *obj, const Property *props, bool val)
 {
     uint64_t *p = object_field_prop_ptr(obj, props);
     uint64_t mask = qdev_get_prop_mask64(props);
@@ -205,7 +205,7 @@ static void bit64_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *p = object_field_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
 
@@ -215,7 +215,7 @@ static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
 static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -237,7 +237,7 @@ const PropertyInfo qdev_prop_bit64 = {
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
@@ -246,7 +246,7 @@ static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
@@ -264,7 +264,7 @@ const PropertyInfo qdev_prop_bool = {
 static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -273,7 +273,7 @@ static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -303,7 +303,7 @@ const PropertyInfo qdev_prop_uint8 = {
 static void get_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint16_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
@@ -312,7 +312,7 @@ static void get_uint16(Object *obj, Visitor *v, const char *name,
 static void set_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint16_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
@@ -330,7 +330,7 @@ const PropertyInfo qdev_prop_uint16 = {
 static void get_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -339,7 +339,7 @@ static void get_uint32(Object *obj, Visitor *v, const char *name,
 static void set_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -348,7 +348,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
@@ -357,7 +357,7 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
@@ -382,7 +382,7 @@ const PropertyInfo qdev_prop_int32 = {
 static void get_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -391,7 +391,7 @@ static void get_uint64(Object *obj, Visitor *v, const char *name,
 static void set_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -400,7 +400,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
 static void get_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
@@ -409,7 +409,7 @@ static void get_int64(Object *obj, Visitor *v, const char *name,
 static void set_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
@@ -432,7 +432,7 @@ const PropertyInfo qdev_prop_int64 = {
 static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -452,14 +452,14 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
 
 static void release_string(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     g_free(*(char **)object_field_prop_ptr(obj, prop));
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     char **ptr = object_field_prop_ptr(obj, prop);
 
     if (!*ptr) {
@@ -473,7 +473,7 @@ static void get_string(Object *obj, Visitor *v, const char *name,
 static void set_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     char **ptr = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -507,7 +507,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value = *ptr;
 
@@ -517,7 +517,7 @@ void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
 static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value;
 
@@ -557,7 +557,7 @@ struct ArrayElementList {
  * specific element of the array. Arrays are backed by an uint32_t length field
  * and an element array. @elem points at an element in this element array.
  */
-static Property array_elem_prop(Object *obj, Property *parent_prop,
+static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
@@ -582,7 +582,7 @@ static Property array_elem_prop(Object *obj, Property *parent_prop,
  */
 static void release_prop_array(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elem = *arrayptr;
@@ -609,7 +609,7 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
@@ -685,7 +685,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elemptr = *arrayptr;
@@ -928,7 +928,7 @@ void qdev_prop_set_globals(DeviceState *dev)
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
@@ -937,7 +937,7 @@ static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
@@ -1020,7 +1020,7 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
 
     char buffer[1024];
     char *ptr = buffer;
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 0419f648b7..dbd9b58a4e 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -641,7 +641,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *events = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint32(v, name, events, errp)) {
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 829832bd9f..be63cb75e1 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -149,7 +149,7 @@ static void nvme_nguid_stringify(const NvmeNGUID *nguid, char *out)
 static void get_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
     char buffer[NGUID_STR_LEN];
     char *p = buffer;
@@ -162,7 +162,7 @@ static void get_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
     char *str;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b2d5327dbf..4e27b2961b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2463,7 +2463,7 @@ void css_reset(void)
 static void get_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CssDevId *dev_id = object_field_prop_ptr(obj, prop);
     char buffer[] = "xx.x.xxxx";
     char *p = buffer;
@@ -2492,7 +2492,7 @@ static void get_css_devid(Object *obj, Visitor *v, const char *name,
 static void set_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CssDevId *dev_id = object_field_prop_ptr(obj, prop);
     char *str;
     int num, n1, n2;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5fbbf41a3d..94b1a5f639 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1453,7 +1453,7 @@ static void s390_pci_device_reset(DeviceState *dev)
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -1463,7 +1463,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     S390PCIBusDevice *zpci = S390_PCI_DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint32(v, name, ptr, errp)) {
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index d37f722cce..c8e60475d5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1499,7 +1499,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -1509,7 +1509,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t value, *ptr = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint8(v, name, &value, errp)) {
-- 
2.43.0


