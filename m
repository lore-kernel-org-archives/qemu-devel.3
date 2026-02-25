Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD9CF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wJ-0003OP-LE; Tue, 24 Feb 2026 22:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wG-0003Jx-8D
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wE-0008Do-Es
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=bwMREnADm6eHqmFk5CeXY5FqfCdSiwFlS3xZB+VDIhwim2wa4eicxNFZ0Qh6lbRxxJ4GlV
 g7tADdRbVjyZDJBxLMIiFI336INWGuJvzlUOAd1hhEpziqS436WcX6h8WGlZ76R3RqPhLO
 CKYTJttHcAAahJ/q4a4qVNxMGxUT1Es=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-JPlpzmUfM2mQ38_1IvZS8w-1; Tue, 24 Feb 2026 22:51:48 -0500
X-MC-Unique: JPlpzmUfM2mQ38_1IvZS8w-1
X-Mimecast-MFC-AGG-ID: JPlpzmUfM2mQ38_1IvZS8w_1771991507
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358dc09b43eso1476738a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991507; x=1772596307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=JuRIHF3QM7+OPXC5bKrWglnjk1+sUs9bOyNIZ1GvtBvr3codQXCRgtzpkPYxpCuMVM
 EikbtLa7U4u6MGV1S+o2rlrtPhAS/sz+diqCw9Y3t7JlI0k+ax/MRkarQuuCHz4p0Ztd
 x13PPzwhwKQoDrEOSFReAbKpMCx6zUQeArcAIo+vM04K0zvtykzDiSGUUL/eu9QRLMyH
 ekyvFCUdnkGvCXMVw5LEqVMq9JKEmXf2rwn+FJmPOqcwx5W+FzOHOqYmxBWoAADQurWS
 iSM6rHmoETYH+3zUX3JUKQSsBZqrWKoQbRmCzwC6Mhr58T1FVon+fDa7m1tXyxqnx7mh
 4Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991507; x=1772596307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSI26ec30q+LRwqH4eGYpPIQO82uWHXpsee53xL/4Nc=;
 b=vjhNSuLp+wFz9WTZCC4vSzBTipuiEAZDllk2oIdo8JZmiJRkbe6qm9pgDmSH9kiWJd
 n1Q/xU6LJmvpCNzk7oQ8FNry6HS3blN+dwk4LyuePEU4h73y+nzV8G0RjhL/FlLs4mIK
 G6LYWZOVJkEhS4ZiM0NqDsIYDk6q6zp57h0cw0MKWdyFWeoCmTFYRkVndwWnpHcegtx6
 G6dHEhxWjGARfot4vmPCPhZBRGzedV9hSuAAW9wdg3TfSQ3ytVP6FE+gUWHs2g9uNUBj
 6K6NxDLtBqac7kzAUNUg1tv+Peju+ufP6pUY+xyEpY7uK9cUF3XfB7b5tU5SHONm1F9A
 bpvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIBeiqcbWT1mukOXE21dZjj7pcmr6mMQv9xUbY4XmCFLCqJuh+YlSpRiNnLtfjPljjymZMCyhI2mOJ@nongnu.org
X-Gm-Message-State: AOJu0YysVdQawOOfLxgbRpTDwkF09rYp0ClreDb9eDw6xWl6i8eHoJkx
 xxX6FsES78FnUZt5TGBdFq3dyHO6tqdNRWue8ATwdDTFsrgLtOB4Cf3kzohY5HvfzuE+nwQzd7D
 H01+Nq0f8qtB/ULhhZNfQl2VXNYUP50k5shwwsQf0dyeoBz3wOtU2/2KbDrn0cT97
X-Gm-Gg: ATEYQzy/Ru1o6qZgn7IlaBu3bpdLhXufLN1JyMkaiaGOXXB9Phv/D6rk1sX286wnrUT
 k3HJTepS4j56PNZJt8VPNwT0GSP9GPInIdBdR9vY2eQSCCGrPRixNNhybHUg+rJBSRbKr8EuKH9
 HiRLrwL4sQ9U38+ueH+6HiSXh5kGtLMkNlkS0iYLRu6w1KPVTwSsyNAMmcTYzSC+hPeVBw4n5Xc
 siOPK1rPcvnGgoxmtEtXSeosr6hJZoI7pUquI9dKIxCsFT1icgJYIpZg9L/O3zFvvsvKZ8g02wj
 mGDjsZkz0rsSsHVjGSq2YcY6ep0EfVDioAZDAhkOMqtzpb889SOulrvb5GXZltccE2uIuBTGkcR
 AVpHdvu+7aJOR/EGEmjxxrs1+rywQ9nPnkRVPMuDgTvC5uWG4U4o1KII=
X-Received: by 2002:a17:90b:540e:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-3590f13bac6mr925327a91.20.1771991506835; 
 Tue, 24 Feb 2026 19:51:46 -0800 (PST)
X-Received: by 2002:a17:90b:540e:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-3590f13bac6mr925314a91.20.1771991506450; 
 Tue, 24 Feb 2026 19:51:46 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:46 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 29/35] ppc/openpic: create a new openpic device and
 reattach mem region on coco reset
Date: Wed, 25 Feb 2026 09:19:34 +0530
Message-ID: <20260225035000.385950-30-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

For confidential guests during the reset process, the old KVM VM file
descriptor is closed and a new one is created. When a new file descriptor is
created, a new openpic device needs to be created against this new KVM VM file
descriptor as well. Additionally, existing memory region needs to be reattached
to this new openpic device and proper CPU attributes set associating new file
descriptor. This change makes this happen with the help of a callback handler
that gets called when the KVM VM file descriptor changes as a part of the
confidential guest reset process.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/intc/openpic_kvm.c | 112 +++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 24 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fbf0bdbe07..b099da20eb 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -49,6 +49,7 @@ struct KVMOpenPICState {
     uint32_t fd;
     uint32_t model;
     hwaddr mapped;
+    NotifierWithReturn vmfd_change_notifier;
 };
 
 static void kvm_openpic_set_irq(void *opaque, int n_IRQ, int level)
@@ -114,6 +115,88 @@ static const MemoryRegionOps kvm_openpic_mem_ops = {
     },
 };
 
+static int kvm_openpic_setup(KVMOpenPICState *opp, Error **errp)
+{
+    int kvm_openpic_model;
+    struct kvm_create_device cd = {0};
+    KVMState *s = kvm_state;
+    int ret;
+
+    switch (opp->model) {
+    case OPENPIC_MODEL_FSL_MPIC_20:
+        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_20;
+        break;
+
+    case OPENPIC_MODEL_FSL_MPIC_42:
+        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_42;
+        break;
+
+    default:
+        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->model);
+        return -1;
+    }
+
+    cd.type = kvm_openpic_model;
+    ret = kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
+    if (ret < 0) {
+        error_setg(errp, "Can't create device %d: %s",
+                   cd.type, strerror(errno));
+        return -1;
+    }
+    opp->fd = cd.fd;
+
+    return 0;
+}
+
+static int kvm_openpic_handle_vmfd_change(NotifierWithReturn *notifier,
+                                          void *data, Error **errp)
+{
+    KVMOpenPICState *opp = container_of(notifier, KVMOpenPICState,
+                                        vmfd_change_notifier);
+    uint64_t reg_base;
+    struct kvm_device_attr attr;
+    CPUState *cs;
+    int ret;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    /* close the old descriptor */
+    close(opp->fd);
+
+    if (kvm_openpic_setup(opp, errp) < 0) {
+        return -1;
+    }
+
+    if (!opp->mapped) {
+        return 0;
+    }
+
+    reg_base = opp->mapped;
+    attr.group = KVM_DEV_MPIC_GRP_MISC;
+    attr.attr = KVM_DEV_MPIC_BASE_ADDR;
+    attr.addr = (uint64_t)(unsigned long)&reg_base;
+
+    ret = ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    if (ret < 0) {
+        error_setg(errp, "%s: %s %" PRIx64, __func__,
+                   strerror(errno), reg_base);
+        return -1;
+    }
+
+    CPU_FOREACH(cs) {
+        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_MPIC, 0, opp->fd,
+                                   kvm_arch_vcpu_id(cs));
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static void kvm_openpic_region_add(MemoryListener *listener,
                                    MemoryRegionSection *section)
 {
@@ -197,36 +280,14 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *d = SYS_BUS_DEVICE(dev);
     KVMOpenPICState *opp = KVM_OPENPIC(dev);
     KVMState *s = kvm_state;
-    int kvm_openpic_model;
-    struct kvm_create_device cd = {0};
-    int ret, i;
+    int i;
 
     if (!kvm_check_extension(s, KVM_CAP_DEVICE_CTRL)) {
         error_setg(errp, "Kernel is lacking Device Control API");
         return;
     }
 
-    switch (opp->model) {
-    case OPENPIC_MODEL_FSL_MPIC_20:
-        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_20;
-        break;
-
-    case OPENPIC_MODEL_FSL_MPIC_42:
-        kvm_openpic_model = KVM_DEV_TYPE_FSL_MPIC_42;
-        break;
-
-    default:
-        error_setg(errp, "Unsupported OpenPIC model %" PRIu32, opp->model);
-        return;
-    }
-
-    cd.type = kvm_openpic_model;
-    ret = kvm_vm_ioctl(s, KVM_CREATE_DEVICE, &cd);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Can't create device %d", cd.type);
-        return;
-    }
-    opp->fd = cd.fd;
+    kvm_openpic_setup(opp, errp);
 
     sysbus_init_mmio(d, &opp->mem);
     qdev_init_gpio_in(dev, kvm_openpic_set_irq, OPENPIC_MAX_IRQ);
@@ -235,6 +296,9 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     opp->mem_listener.region_del = kvm_openpic_region_del;
     opp->mem_listener.name = "openpic-kvm";
     memory_listener_register(&opp->mem_listener, &address_space_memory);
+    opp->vmfd_change_notifier.notify =
+        kvm_openpic_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&opp->vmfd_change_notifier);
 
     /* indicate pic capabilities */
     msi_nonbroken = true;
-- 
2.42.0


