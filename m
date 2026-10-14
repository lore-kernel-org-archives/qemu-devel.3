Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63B3CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtcE-0002NI-AV; Wed, 14 Oct 2026 03:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGtc9-0002N7-Jz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGtc5-0005yf-Ov
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791963683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=280cl7ne4iOxqZm2N09/36BAG06GMdoRwxpoHaPQ25g=;
 b=O3nPixloMoAxtO8h17egXtZ2R4GB4KcqYQjXxarn1/SbTqf/PsDFpSXYk+S8mh2t3L0ZKc
 0ubzCADxZAdcOq7OYXAhouFj5fFmx9n240UeEr67SUSZa6aJZV6OlcYYiFyV96AYRiHYkY
 NicwZWEIWi3p9/y8X5j51jWFw1w3kU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Eg1BTlXgOruvkc3KSws_dQ-1; Wed, 14 Oct 2026 07:41:21 +0000
X-MC-Unique: Eg1BTlXgOruvkc3KSws_dQ-1
X-Mimecast-MFC-AGG-ID: Eg1BTlXgOruvkc3KSws_dQ_1791963680
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a17e77c5b1so5720075e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791963680; x=1792568480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=280cl7ne4iOxqZm2N09/36BAG06GMdoRwxpoHaPQ25g=;
 b=ismgY9vNJDM6cLJh+vrhGTROD5HNXar5NspkJZY6nVDNlP1ZxfPVDJGMGhc4YXh8mO
 klegMYV/t/AwghIIqZD9BqsCTfOmmQVN8omlhk1osMPbyJMNdYLu1HlLiYHhXQABqEdP
 9xq8rCVEtG7gEm6GjK/lp8A/jjsB6bf149pqAkfRk1k/EowoJ9oq/RU0vdxSXKmWuGuh
 XF26+lIPThN4ojLxMngBG6JWQOm9VzCvHazLBSqJY9fZQW+YnZz3ZYzfiQm/HydMqIBx
 otUfqG+dUZZ4B0VqqJU4OahAxFlWy6zvpDqSAw8f7ybiQbG1kY/IjDvRFtr4zw8CeRZ7
 +MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963680; x=1792568480;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=280cl7ne4iOxqZm2N09/36BAG06GMdoRwxpoHaPQ25g=;
 b=BlmBVDs8wQ3VyoOuKOxKMGH1lbhvVnp0cMt1S+9U+R0tI7kRKerPnPfMTLYyj7AOXy
 dBmK/9avGbDQOLJQVvT3a42hUZ3FlKAOrCQqyVfWdBWT0VyaT9syqCPYhsDgyor6DBRS
 aw3H8dgLS7bQj22zXH3rbwV/9w/pGpuqhFsqUzEDltEEufFEXJtIa41kaW2ig1LvSGVD
 7yPEjPIaLQ38Z8uE45r509oHipPptgux4S4CtsFLYHoO4Gkk1UiT16R5ApXiwE0pdi7i
 bhVEEOovCJ0PZU+Xb7OiIPMDAl/lIFd3kCZOTsD/yvrrL3ns0RFP9NjtGn7nQ73SsSv9
 67DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOFmqrl+fDBK+dntE+Sou1V8SrDqaj87UxXZLPQbWSfRsD8siBuxZNBIIcEmes96zicek1gb3QPSgP@nongnu.org
X-Gm-Message-State: AFq9FYJUCqMqF6Xva2A1mL7pHbLUw6I+YT1KDr8zmPrIr0FA5lJUegDL
 jDQO9HOjN8VVP0uj2c6ewhmAO2aI3+SXCkjAKgISaqD600JVdCH6E/akrZkQaz1ti3a74dvJmTL
 /uyNHU91IpAYZsX0PWKhmkJX87YGB41q/pFZ9uByAovW8sVKQmMNhEV0l
X-Gm-Gg: AYBFou2BDuvU53Ib33ORi8OD2FW+whZDI1YvhfLKa0GyLWAh6GYmcMUm0mopf6aZ60l
 SUQbRSx4c2Jqv9AviMObIjyN924WFuvRXIvHsVldHfnfxTaji0i0a2itCsTaIhjAnunkAGW+bVw
 +OZ6GHGz4Y977OmroCNkk1zKZkDWIce7HzVpt/0m6vvnC+3pWe4R1uShtlupFaYq/ymeslhJA5Y
 OcZIPyDRb1c87VD93PmzJ+cMSwfdPUxmfl6LzxpmsB7c5Hij5LkIAYRnh1xvvAb1a7wkhi8QCZG
 wyalRvyLLmpAerEvphnFBOVjor1CsH1yV//dvUyO5OBy6lw00YHMCBYpP/aKfLweE7oTLPbgNbl
 PQ+NQ7Mztx7CRGl7+ea9z5/OTTiARGd8auiI9GC8R
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr311573395e9.6.1791963680008; 
 Wed, 14 Oct 2026 00:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr311572255e9.6.1791963678896; 
 Wed, 14 Oct 2026 00:41:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de70079e7sm5012682f8f.11.2026.10.14.00.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:41:18 -0700 (PDT)
Message-ID: <458252ce-c1b8-4df6-8268-4ae09cd96d56@redhat.com>
Date: Wed, 14 Oct 2026 09:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
 <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
 <12afec43-1da5-4326-9395-73441effe9c6@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <12afec43-1da5-4326-9395-73441effe9c6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hello !

[ ... ]

> Choosing between qemu_log_mask(LOG_GUEST_ERROR, ...) and
> error_report_err() is also a machine decision. The caller needs to
> distinguish incompatible backing from other failures to select the
> reporting path; human-readable attribution in Error * is insufficient.
> 
> The -EINVAL ambiguity therefore remains. vfio_device_get_feature()
> also returns -EINVAL when the backend lacks the operation. If we
> propagate that unchanged, your diagram classifies it as incompatible
> guest memory. Using -EINVAL for that classification requires an
> explicit mapping that keeps these other failures distinct.
> 
> Regarding -ENODEV, virtio_gpu_device_realize() already requires
> virtio_gpu_have_udmabuf() for this blob path. udmabuf_fd() caches the
> opened fd, so the availability-related -ENODEV should not occur
> after successful realization.
You raise valid points :

* -EINVAL from vfio_device_get_feature(): You're right. That needs a
   remap to avoid the -EINVAL collision.
* -ENODEV: Correct, I'll drop that suggestion.

So, we just need the one-line remap above to avoid the -EINVAL collision.
See a proposal here :

   https://github.com/legoater/qemu/commits/virtio-gpu-dmabuf

Fixup patch :

   https://github.com/legoater/qemu/commit/653c41e89468f82bbdfcaeafe75473b84f5a1e49

Also below,

Thanks,

C.



 From 653c41e89468f82bbdfcaeafe75473b84f5a1e49 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Date: Wed, 14 Oct 2026 00:00:00 +0200
Subject: [PATCH] vfio, virtio-gpu-dmabuf: Replace custom error enum with
  standard -errno
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the VFIO_DMABUF_CREATE_ERR_{INVALID_IOV,UNSPEC} enum from
vfio-device.h and use standard negative errno values instead:

   - -EINVAL: iov addresses are incompatible with this dmabuf backend
   - -ENODEV: required backend (udmabuf device) is unavailable
   - -ENOMEM: allocation failure
   - -EIO: VFIO feature call failed
   - -ENOTSUP: VFIO not compiled in
   - other -errno: forwarded from kernel VFIO ioctl

Remap -EINVAL from vfio_device_get_feature() to -EIO so that a
"feature not supported" error is not misclassified by the caller
as "addresses incompatible with this backend".

The virtio-gpu fallback logic (try udmabuf, then VFIO) can now check
-EINVAL.

Also fix several issues in the same code:
  - vfio_device_lookup: use global_next (not next) for vfio_device_list
  - Move vfio_device_create_dmabuf_fd/vfio_device_mmap_dmabuf
    declarations outside #ifdef CONFIG_VFIO guard so prototypes are
    visible to the stubs (fixes MinGW build)
  - Remove trailing \n and trailing space from error_setg messages

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
  include/hw/vfio/vfio-device.h  | 17 +++++++----------
  hw/display/virtio-gpu-dmabuf.c | 22 ++++++++++++----------
  hw/vfio/device.c               | 21 +++++++++++----------
  hw/vfio/dmabuf-stubs.c         |  2 +-
  4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4b8fb6205604..473623240877 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,13 +41,6 @@ enum {
      VFIO_DEVICE_TYPE_AP = 3,
  };
  
-enum {
-    /* The Guest passed addresses stored in IOV are invalid */
-    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
-    /* Guest or Host may be at fault for this type of error */
-    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
-};
-
  typedef struct VFIODeviceOps VFIODeviceOps;
  typedef struct VFIODeviceIOOps VFIODeviceIOOps;
  typedef struct VFIOMigration VFIOMigration;
@@ -331,6 +324,8 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
  int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                  struct vfio_irq_info *info);
  
+#endif
+
  /**
   * Create a dmabuf fd by first translating the addresses in the
   * iovec array into VFIO region offsets and then invoking the
@@ -340,8 +335,11 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
   * @iov_cnt: number of entries in the iovec array
   * @errp: pointer to Error*, to store an error if it happens.
   *
- * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_ERR_UNSPEC
- * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
+ * Returns the dmabuf fd (>= 0) on success, or a negative errno:
+ *  - -EINVAL: iov addresses do not belong to a VFIO device
+ *  - -EIO: VFIO feature call failed
+ *  - -ENOTSUP: VFIO not compiled in
+ *  - other negative errno from the kernel VFIO ioctl
   */
  int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                   Error **errp);
@@ -360,7 +358,6 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
   */
  void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                                Error **errp);
-#endif
  
  /* Returns 0 on success, or a negative errno. */
  bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index f59a5e76ff3c..82769eed442a 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -39,21 +39,21 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
      udmabuf = udmabuf_fd();
      if (udmabuf < 0) {
          error_setg(errp, "udmabuf device not available or enabled");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -ENODEV;
      }
  
      list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
                           sizeof(struct udmabuf_create_item) * res->iov_cnt);
      if (!list) {
          error_setg(errp, "failed to allocate udmabuf create list");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -ENOMEM;
      }
  
      for (i = 0; i < res->iov_cnt; i++) {
          rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
          if (!rb || rb->fd < 0) {
-            error_setg(errp, "IOV memory address incompatible with udmabuf ");
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+            error_setg(errp, "IOV memory address incompatible with udmabuf");
+            return -EINVAL;
          }
  
          list->list[i].memfd  = rb->fd;
@@ -66,11 +66,13 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
  
      fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
      if (fd < 0) {
-        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
-        if (errno == EINVAL || errno == EBADFD) {
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        int saved_errno = errno;
+
+        error_setg_errno(errp, saved_errno, "UDMABUF_CREATE_LIST: ioctl failed");
+        if (saved_errno == EINVAL || saved_errno == EBADFD) {
+            return -EINVAL;
          }
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -saved_errno;
      }
      return fd;
  }
@@ -150,13 +152,13 @@ bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
          pdata = res->iov[0].iov_base;
      } else if (res->blob_size) {
          res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
-        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+        if (res->dmabuf_fd == -EINVAL) {
              error_free_or_abort(&local_err);
  
              res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
                                                            res->iov_cnt,
                                                            &local_err);
-            if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+            if (res->dmabuf_fd == -EINVAL) {
                  error_free_or_abort(&local_err);
                  qemu_log_mask(LOG_GUEST_ERROR,
                                "Cannot create dmabuf: incompatible memory\n");
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 5bc044376441..28cb23f3df6a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -686,18 +686,18 @@ static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
  
      first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
      if (!first_rb) {
-        error_setg(errp, "Could not find first ramblock\n");
+        error_setg(errp, "Could not find first ramblock");
          return false;
      }
  
      *first_rbp = first_rb;
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
          if (vbasedev->dev == first_rb->mr->dev) {
              *vbasedevp = vbasedev;
              return true;
          }
      }
-    error_setg(errp, "No VFIO device found to create dmabuf from\n");
+    error_setg(errp, "No VFIO device found to create dmabuf from");
      return false;
  }
  
@@ -716,7 +716,7 @@ static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
  
      rb = qemu_ram_block_from_host(addr, false, offsetp);
      if (!rb || rb != first_rb) {
-        error_setg(errp, "Dmabuf segments must belong to the same region\n");
+        error_setg(errp, "Dmabuf segments must belong to the same region");
          return false;
      }
  
@@ -725,7 +725,7 @@ static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
          *regionp = region;
          return true;
      }
-    error_setg(errp, "Could not find valid region for dmabuf segment\n");
+    error_setg(errp, "Could not find valid region for dmabuf segment");
      return false;
  }
  
@@ -742,7 +742,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      int i, ret;
  
      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
-        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        return -EINVAL;
      }
  
      argsz = sizeof(*feature) + sizeof (*dma_buf) +
@@ -757,7 +757,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      for (i = 0; i < iov_cnt; i++) {
          if (!vfio_region_lookup(iov[i].iov_base, &region,
                                  first_rb, &offset, errp)) {
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+            return -EINVAL;
          }
  
          dma_buf->region_index = region->nr;
@@ -772,7 +772,8 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      if (ret < 0) {
          error_setg_errno(errp, -ret,
                           "Could not create dmabuf fd via VFIO device");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        /* Remap -EINVAL: caller uses it to mean "addresses incompatible" */
+        return (ret == -EINVAL) ? -EIO : ret;
      }
      return ret;
  }
@@ -811,7 +812,7 @@ void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
          }
  
          if (vfio_device_get_region_info(vbasedev, region->nr, &info)) {
-            error_setg(errp, "Cannot find region info for dmabuf segment\n");
+            error_setg(errp, "Cannot find region info for dmabuf segment");
              goto err;
          }
  
@@ -819,7 +820,7 @@ void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                        MAP_SHARED | MAP_FIXED, vbasedev->fd,
                        info->offset + offset);
          if (submap == MAP_FAILED) {
-            error_setg_errno(errp, errno, "Could not mmap dmabuf segment\n");
+            error_setg_errno(errp, errno, "Could not mmap dmabuf segment");
              goto err;
          }
          len += iov[i].iov_len;
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
index b9e03a162a75..241a9761ef5e 100644
--- a/hw/vfio/dmabuf-stubs.c
+++ b/hw/vfio/dmabuf-stubs.c
@@ -13,7 +13,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                   Error **errp)
  {
      error_setg(errp, "VFIO dmabuf support is not enabled");
-    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+    return -ENOTSUP;
  }
  
  void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
-- 
2.56.0



