Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C93CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTX7-0000xB-JA; Wed, 07 Jan 2026 08:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTWs-0000kB-S3
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTWq-0005eA-FX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767792287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=PMrGxDUOw+6egKZEjcoDkB5NFB8+8OyvW2jMhK9If/o=;
 b=UY7cjo8focNRgjdW5QVA4zvD49k9M2asfeHBlB4pMvh7mK1Tsg2+AvHcfpP2oZwaH7CFfV
 jKi+IdQb4sohRTAVs6bse+YYGmVcKHRdfV6LvtGXl7Gef7APs3zh3KdwbJQFrAnWqImlMy
 PdnP7BmH2fuToi/KvOFUDeG6Pwaq8sU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Sqt4pDzgPkGaI_wepIfKkA-1; Wed,
 07 Jan 2026 08:24:44 -0500
X-MC-Unique: Sqt4pDzgPkGaI_wepIfKkA-1
X-Mimecast-MFC-AGG-ID: Sqt4pDzgPkGaI_wepIfKkA_1767792283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8AB21956050; Wed,  7 Jan 2026 13:24:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 358D530002D1; Wed,  7 Jan 2026 13:24:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F39A421E6934; Wed, 07 Jan 2026 14:24:40 +0100 (CET)
Resent-To: philmd@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 07 Jan 2026 14:24:40 +0100
Resent-Message-ID: <87tswxh7xj.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Jan  7 13:43:41 2026
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6707A21E6934; Wed, 07 Jan 2026 13:43:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/17] error: Use error_setg_errno() to improve error messages
Date: Wed,  7 Jan 2026 13:43:38 +0100
Message-ID: <20260107124341.1093312-15-armbru@redhat.com>
In-Reply-To: <20260107124341.1093312-1-armbru@redhat.com>
References: <20260107124341.1093312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A few error messages show numeric errno codes.  Use error_setg_errno()
to show human-readable text instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121121438.1249498-13-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev-lkcf.c   |  2 +-
 hw/ppc/spapr.c              |  6 +++---
 hw/vfio/migration-multifd.c |  5 +++--
 migration/rdma.c            |  3 +--
 net/l2tpv3.c                |  6 ++----
 target/riscv/kvm/kvm-cpu.c  | 11 ++++++-----
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 97a8a8812c..40c7bd3c5a 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -218,7 +218,7 @@ static void cryptodev_lkcf_init(CryptoDevBackend *backend, Error **errp)
     }
     lkcf->eventfd = eventfd(0, 0);
     if (lkcf->eventfd < 0) {
-        error_setg(errp, "Failed to create eventfd: %d", errno);
+        error_setg_errno(errp, errno, "Failed to create eventfd");
         return;
     }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b3c5097bf8..f129e4ec39 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2700,9 +2700,9 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
         ret = kvmppc_set_smt_threads(spapr->vsmt);
         if (ret) {
             /* Looks like KVM isn't able to change VSMT mode */
-            error_setg(&local_err,
-                       "Failed to set KVM's VSMT mode to %d (errno %d)",
-                       spapr->vsmt, ret);
+            error_setg_errno(&local_err, -ret,
+                             "Failed to set KVM's VSMT mode to %d",
+                             spapr->vsmt);
             /* We can live with that if the default one is big enough
              * for the number of threads, and a submultiple of the one
              * we want.  In this case we'll waste some vcpu ids, but
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e4785031a7..4a855f4e12 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -725,8 +725,9 @@ vfio_multifd_save_complete_precopy_thread(SaveCompletePrecopyThreadData *d,
         data_size = read(migration->data_fd, &packet->data,
                          migration->data_buffer_size);
         if (data_size < 0) {
-            error_setg(errp, "%s: reading state buffer %" PRIu32 " failed: %d",
-                       vbasedev->name, idx, errno);
+            error_setg_errno(errp, errno,
+                             "%s: reading state buffer %" PRIu32 " failed",
+                             vbasedev->name, idx);
             goto thread_exit;
         } else if (data_size == 0) {
             break;
diff --git a/migration/rdma.c b/migration/rdma.c
index 337b415889..9e301cf917 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2349,8 +2349,7 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
         error_setg(errp, "RDMA ERROR: poll cm event timeout");
         return -1;
     } else if (ret < 0) {
-        error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
-                   errno);
+        error_setg_errno(errp, errno, "RDMA ERROR: failed to poll cm event");
         return -1;
     } else if (poll_fd.revents & POLLIN) {
         if (rdma_get_cm_event(rdma->channel, cm_event) < 0) {
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index cdfc641aa6..3044fa4608 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -639,13 +639,11 @@ int net_init_l2tpv3(const Netdev *netdev,
     }
     fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
     if (fd == -1) {
-        fd = -errno;
-        error_setg(errp, "socket creation failed, errno = %d",
-                   -fd);
+        error_setg_errno(errp, errno, "socket creation failed");
         goto outerr;
     }
     if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen)) {
-        error_setg(errp, "could not bind socket err=%i", errno);
+        error_setg_errno(errp, errno, "could not bind socket");
         goto outerr;
     }
     if (!qemu_set_blocking(fd, false, errp)) {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5d792563b9..99284abbc6 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1996,8 +1996,8 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
     if (riscv_has_ext(&cpu->env, RVV)) {
         ret = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
         if (ret) {
-            error_setg(errp, "Error in prctl PR_RISCV_V_SET_CONTROL, code: %s",
-                       strerrorname_np(errno));
+            error_setg_errno(errp, errno,
+                             "Error in prctl PR_RISCV_V_SET_CONTROL");
             return false;
         }
     }
@@ -2032,7 +2032,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_setg(errp, "Unable to read cbom_blocksize, error %d", errno);
+            error_setg(errp, errno,
+                       "Unable to read cbom_blocksize");
             return;
         }
 
@@ -2051,7 +2052,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_setg(errp, "Unable to read cboz_blocksize, error %d", errno);
+            error_setg_errno(errp, errno, "Unable to read cboz_blocksize");
             return;
         }
 
@@ -2073,7 +2074,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_setg(errp, "Unable to read vlenb register, error %d", errno);
+            error_setg_errno(errp, errno, "Unable to read vlenb register");
             return;
         }
 
-- 
2.52.0



