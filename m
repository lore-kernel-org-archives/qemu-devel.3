Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BF5FCA18A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPI-0004l3-U3; Mon, 09 Mar 2026 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fg-N6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007hp-Mc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4Vs0ZPen7aMfB8K8UbHiZRosOKI+EWKjN8E+7wSbK8=;
 b=Mp0GaK0tGLOcOrer8NZRj4Y/Fv19FaqGB16XUtrtWQqPk9CmtckFPCAhkPUkVFArWDaS/i
 LWsxNYZ2yEHWSRJg7ap3J7p3mWPS+5Gt9Hmb+cLZ8OxaVgRkxkvVIeWYPYymCoSyD4NYtA
 f+KC4L9SZQVN4aJmdrVguLZsAxvdjdY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-lxvhADGkOzW9SUCAeXYDtg-1; Mon, 09 Mar 2026 16:40:26 -0400
X-MC-Unique: lxvhADGkOzW9SUCAeXYDtg-1
X-Mimecast-MFC-AGG-ID: lxvhADGkOzW9SUCAeXYDtg_1773088826
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7fec8d44so931585985a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088825; x=1773693625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4Vs0ZPen7aMfB8K8UbHiZRosOKI+EWKjN8E+7wSbK8=;
 b=F0xY3kzALrh2cyrHTxcRF0yggbvBdJY87hIDDjuABClNQca0o0YU8VtccrNfNfM/np
 im7KkB429AO+/E+BXpNCJgOx1ibYJUEGctax0myNojX01Nt4PlO8Br0s3Ai2JYjG+0AD
 x+W9gZy0F9Y452y4yJFsIlvycY2NuVMS3vB8Zp6fv9xnyEM5uNr3tAYSUW9GonhiSjHS
 ZnS06Z816ayCpH7haVTsJmHvk8bZADHCiMZfBfXIOTRctpH2GWso43WVZ5ZcFD3XVmR5
 GlB4Zwu/vsrrkGccClozTKU70UWScz37LHjIsBoWE3+aXw59L+pikwDtB4GuWMSf7Lij
 8wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088825; x=1773693625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4Vs0ZPen7aMfB8K8UbHiZRosOKI+EWKjN8E+7wSbK8=;
 b=goWqJa/soJbcp8dLpjLORf6MRWrSlzCyQf6qzxXvlfpC+KKHNgnmHjcqHwtfk914wy
 /6k+WylwGI1JFkCAzs0GOWxaMlDJRuGlH2xain+qCY0HqSTRstnD3cdyp3wvlBctvey+
 GFT/zP1yJCyLto37smHB2SMbbuVm2k4abm9izCucuReQrzhz09AjEBXkahxiycMEwrIO
 BhiE8b+8zecLIORdDHq7lDZxDJd8oA82D3w48sOxYnOuLHUYSB+fZpM4B45f7encPMAX
 4mZQA5phEWCRV//MhnuCViXIwIkWrLwECCW/P4WBdx96UBGqOL7wiE/W5sdGt6EV0ZhK
 pjEQ==
X-Gm-Message-State: AOJu0Yz31XY/ANKj6fTfhse3zN67hSGOz7ZL05LZ0SdvjC9VaN62eR6V
 WQ1lVU7TIJWBHFN8l2J3VX4tj5wRPSg9dc+cFEiRVVv9htL+Erz/hhgipmbbghSEPcfUr2mRML0
 nbXzmp73+i3NQHtLFPmqqnpkkW+ooEQB++F4nh4f+amNcgyHCsfwHDdhwXoHCJpgaT4CPan64Wx
 PzEeVsQbFm7JrBATLSZ7XhON0n5oD+uc1VgfZ5dQ==
X-Gm-Gg: ATEYQzyY6c0Qk8YLbebO8SsE0ixC3os/3HmntI6uwMID2R/xFFqn3zWusnS27rCCDCI
 4AKsbQOgRzhPaCGgUOtavPqAdQwNevVEXoEABNgsuMat5XlhF9CitCPGgFBHCg1y92TDPwoIgxU
 mWhiaPlib9kAY3tJQ9cEfXkCzgb5k8QV5aZ5XlfHuZMsLV8AuIImTp9louA7VNvOVr222ENtdaT
 PhNL1jsL/EBM4j/kp4ehP9XBNbe6LiBUcXU4PYdEC+MEU+r91N/4nczrQMM+4z2QeRu0SfAxyMR
 w6fGbS6XYbz2q/0yAreAubY514JxmKs4hw0VTzlNk+bwaCoflGMMiMCu6WE/NDg9N+H01luwmyI
 KPd3kqBt2FKJWPBzcrXRWjoXk4/PK0qgAaoIH8tDrKLvXtMKFEHI0OcxLWQ02VfV5zkxyNEWZ09
 UEnDS+VQ==
X-Received: by 2002:a05:620a:4001:b0:8cd:933f:d909 with SMTP id
 af79cd13be357-8cd933fdca5mr180896685a.64.1773088825163; 
 Mon, 09 Mar 2026 13:40:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4001:b0:8cd:933f:d909 with SMTP id
 af79cd13be357-8cd933fdca5mr180892285a.64.1773088824613; 
 Mon, 09 Mar 2026 13:40:24 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 07/18] memory: Add internal memory_region_register_ram function
Date: Mon,  9 Mar 2026 16:39:56 -0400
Message-ID: <20260309204007.1709441-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Factor out common operation from memory_region_init_{ram,rom}
functions to register the region for migration. This avoids
duplicating the long comment in several functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/1f0bcb38e59456aa910376df6a375d63c2f3f442.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 80 ++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 13d4e3314b..9a12224555 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3676,18 +3676,10 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-bool memory_region_init_ram(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+static void memory_region_register_ram(MemoryRegion *mr, Object *owner)
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
-        return false;
-    }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
@@ -3696,68 +3688,50 @@ bool memory_region_init_ram(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+}
 
+bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
+                            Error **errp)
+{
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0,
+                                                errp)) {
+        return false;
+    }
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
+                                        const char *name, uint64_t size,
                                         Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
                                                 RAM_GUEST_MEMFD, errp)) {
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
+bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
                             Error **errp)
 {
-    DeviceState *owner_dev;
-
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0,
+                                                errp)) {
         return false;
     }
     mr->readonly = true;
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom_device(MemoryRegion *mr,
-                                   Object *owner,
-                                   const MemoryRegionOps *ops,
-                                   void *opaque,
-                                   const char *name,
-                                   uint64_t size,
+bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size,
                                    Error **errp)
 {
-    DeviceState *owner_dev;
     Error *err = NULL;
 
     assert(ops);
@@ -3771,15 +3745,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
         error_propagate(errp, err);
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-- 
2.50.1


