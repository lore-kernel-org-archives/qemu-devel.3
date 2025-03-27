Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B3C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 06:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txgSl-0002xE-D4; Thu, 27 Mar 2025 02:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgSg-0002wk-JW
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:11:31 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgSd-0000Kz-C2
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:11:29 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dbe706f94fso116316a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1743055885; x=1743660685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MZf+ZSYR6fIPp4jsPiKvTkvw2gubQAjPggbDk/bBS4=;
 b=d7PFSz6e5q30OMWQ2p/J7EWV+ZRSoIak+7ZLDwOLCs6FRVUua0TkcvCeX8gbkesh81
 iDUnxB4IZd7FPSsIorpCPMzrT21Rxgyy9FqKBefBDSPJIkkcHwTKNecsV73JPQsrBaif
 fCMrHJgSXBkaD5HnPOJsk4+LgPFCFdoIjpFSlMY6iky1JVQC9iP8rTACWC8TwA8igXvs
 j8REwb2Z8yKS6Bem4UVECn5XeK9Cmd230tsMTp08i42eivak4jCtvrbPHEjUDuZ9S/YC
 0u62cmmjO43V/f3C8PCXaQwwLTXeEZJ1dtTsim1G5Za4gemtzSo9gROrqtATyGS5BW/6
 0HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743055885; x=1743660685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MZf+ZSYR6fIPp4jsPiKvTkvw2gubQAjPggbDk/bBS4=;
 b=ZOxEzYnf5VMHDaNZUC57vMGjs8IAQlegvSRKJ1ZXFjLlAZXqn15zoiz0pWhfNfsWrZ
 o5A4QPONNyMQ32cTTiLoqSmCh0/brZxREwDXgPZj0u5rrty44vBVql93sR4KcSpp3MW/
 UWuOtzF9ah8rTJcpAJenDku/kKQ1vJ3a6G7uHNueg2CdfHb3q5bp8Zq/v+NeiFDOR4X1
 XNnjWCxl4rrNYh9ANR3MnHjYxIwoAoCpCDdv90k+cfUvPIX0zvD85+2YpIoX5DIuh6l5
 fEsIQkFD16aeVAhUuwrYIOAQRdm7a43f65giFDEKmg03IFgh2aOjs6qAfxdeNSah5X5a
 Xc2w==
X-Gm-Message-State: AOJu0YzoViVXc0UpNM6VYBkWi1rwFusuxeMHBQZHzM5Yy5ELTgmuI43t
 TDn+eIUsY9EQeOr4keVb75nvU4a70IF0yrpGnjlKVa4ijfhHRtJvVa8ejYDT0WAuo97BJiBiqwA
 VFTA=
X-Gm-Gg: ASbGncubIsTk0N/u2yqNSQO8GY4OyTuToytJ3Z9Vs3dTKSIefsVGSKy+XXgvbmhojfh
 i27QXGEryfpuAQdH9xhcmFewdiX7xURuy6pkDB9fDQU9hPMOCNKnq1pMgTvbZtafterReCDsBFf
 oh+qNlbQch3vae1ZOlQEIead3wpVg1ErCaRxtlHYe59zeGG7Rn5PnXAtsTfDP6CJO8/WOe2KusR
 O8EjE+VWPlh2WsZh5Q8f8/GLsbP9pYVn5VKbv9NpxkfY/f3QZpCeODUcbqLO40Us7KFK9ZxOaAT
 VRaLkEwlu8BY/FfOAoYyJ82/Oq0rgRF0TvQuCQHsOBKIyU5GKU/jE4w=
X-Google-Smtp-Source: AGHT+IHbWsSIAIW0UA1kZVQwwgRV3ZNaGr9o7plLVVIZ4ygGwbk/67YFocWuSYvzNriggXVQi0wNNg==
X-Received: by 2002:a17:906:c147:b0:abf:663b:22c5 with SMTP id
 a640c23a62f3a-ac701c34213mr53152666b.13.1743055884525; 
 Wed, 26 Mar 2025 23:11:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1460:e800:83eb:8e1c:ef0f:4d81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efb64895sm1155894166b.113.2025.03.26.23.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 23:11:24 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org, michael@flatgalaxy.com,
 Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Thu, 27 Mar 2025 07:11:23 +0100
Message-ID: <20250327061123.14453-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::529;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

I hit following error which testing migration in pure RoCE env:
"-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
systems and your management software has specified '[::]', but IPv6 over RoCE /
iWARP is not supported in Linux.#012'."

In our setup, we use rdma bind on ipv6 on target host, while connect from source
with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
fine.

Checking the git history, the function was added since introducing of
rdma migration, which is more than 10 years ago. linux-rdma has
improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
back in 2016 seems related to the issue, eg:
aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")

other fixes back in 2018, eg:
052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
3c7f67d1880d IB/cma: Fix default RoCE type setting
be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
63a5f483af0e IB/cma: Set default gid type to RoCEv2

So remove the outdated function and it's usage.

Cc: Peter Xu <peterx@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Yu Zhang <yu.zhang@ionos.com>
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
---
v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

 migration/rdma.c | 159 -----------------------------------------------
 1 file changed, 159 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..e228520b8e01 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
     trace_qemu_rdma_dump_gid(who, sgid, dgid);
 }
 
-/*
- * As of now, IPv6 over RoCE / iWARP is not supported by linux.
- * We will try the next addrinfo struct, and fail if there are
- * no other valid addresses to bind against.
- *
- * If user is listening on '[::]', then we will not have a opened a device
- * yet and have no way of verifying if the device is RoCE or not.
- *
- * In this case, the source VM will throw an error for ALL types of
- * connections (both IPv4 and IPv6) if the destination machine does not have
- * a regular infiniband network available for use.
- *
- * The only way to guarantee that an error is thrown for broken kernels is
- * for the management software to choose a *specific* interface at bind time
- * and validate what time of hardware it is.
- *
- * Unfortunately, this puts the user in a fix:
- *
- *  If the source VM connects with an IPv4 address without knowing that the
- *  destination has bound to '[::]' the migration will unconditionally fail
- *  unless the management software is explicitly listening on the IPv4
- *  address while using a RoCE-based device.
- *
- *  If the source VM connects with an IPv6 address, then we're OK because we can
- *  throw an error on the source (and similarly on the destination).
- *
- *  But in mixed environments, this will be broken for a while until it is fixed
- *  inside linux.
- *
- * We do provide a *tiny* bit of help in this function: We can list all of the
- * devices in the system and check to see if all the devices are RoCE or
- * Infiniband.
- *
- * If we detect that we have a *pure* RoCE environment, then we can safely
- * thrown an error even if the management software has specified '[::]' as the
- * bind address.
- *
- * However, if there is are multiple hetergeneous devices, then we cannot make
- * this assumption and the user just has to be sure they know what they are
- * doing.
- *
- * Patches are being reviewed on linux-rdma.
- */
-static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
-{
-    /* This bug only exists in linux, to our knowledge. */
-#ifdef CONFIG_LINUX
-    struct ibv_port_attr port_attr;
-
-    /*
-     * Verbs are only NULL if management has bound to '[::]'.
-     *
-     * Let's iterate through all the devices and see if there any pure IB
-     * devices (non-ethernet).
-     *
-     * If not, then we can safely proceed with the migration.
-     * Otherwise, there are no guarantees until the bug is fixed in linux.
-     */
-    if (!verbs) {
-        int num_devices;
-        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
-        bool roce_found = false;
-        bool ib_found = false;
-
-        for (int x = 0; x < num_devices; x++) {
-            verbs = ibv_open_device(dev_list[x]);
-            /*
-             * ibv_open_device() is not documented to set errno.  If
-             * it does, it's somebody else's doc bug.  If it doesn't,
-             * the use of errno below is wrong.
-             * TODO Find out whether ibv_open_device() sets errno.
-             */
-            if (!verbs) {
-                if (errno == EPERM) {
-                    continue;
-                } else {
-                    error_setg_errno(errp, errno,
-                                     "could not open RDMA device context");
-                    return -1;
-                }
-            }
-
-            if (ibv_query_port(verbs, 1, &port_attr)) {
-                ibv_close_device(verbs);
-                error_setg(errp,
-                           "RDMA ERROR: Could not query initial IB port");
-                return -1;
-            }
-
-            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
-                ib_found = true;
-            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-                roce_found = true;
-            }
-
-            ibv_close_device(verbs);
-
-        }
-
-        if (roce_found) {
-            if (ib_found) {
-                warn_report("migrations may fail:"
-                            " IPv6 over RoCE / iWARP in linux"
-                            " is broken. But since you appear to have a"
-                            " mixed RoCE / IB environment, be sure to only"
-                            " migrate over the IB fabric until the kernel "
-                            " fixes the bug.");
-            } else {
-                error_setg(errp, "RDMA ERROR: "
-                           "You only have RoCE / iWARP devices in your systems"
-                           " and your management software has specified '[::]'"
-                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                return -1;
-            }
-        }
-
-        return 0;
-    }
-
-    /*
-     * If we have a verbs context, that means that some other than '[::]' was
-     * used by the management software for binding. In which case we can
-     * actually warn the user about a potentially broken kernel.
-     */
-
-    /* IB ports start with 1, not 0 */
-    if (ibv_query_port(verbs, 1, &port_attr)) {
-        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
-        return -1;
-    }
-
-    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        error_setg(errp, "RDMA ERROR: "
-                   "Linux kernel's RoCE / iWARP does not support IPv6 "
-                   "(but patches on linux-rdma in progress)");
-        return -1;
-    }
-
-#endif
-
-    return 0;
-}
-
 /*
  * Figure out which RDMA device corresponds to the requested IP hostname
  * Also create the initial connection manager identifiers for opening
@@ -955,7 +812,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     /* Try all addresses, saving the first error in @err */
     for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -964,13 +820,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret >= 0) {
-            if (e->ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
-                                                   local_errp);
-                if (ret < 0) {
-                    continue;
-                }
-            }
             error_free(err);
             goto route;
         }
@@ -2663,7 +2512,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     /* Try all addresses, saving the first error in @err */
     for (e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -2672,13 +2520,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         if (ret < 0) {
             continue;
         }
-        if (e->ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
-                                               local_errp);
-            if (ret < 0) {
-                continue;
-            }
-        }
         error_free(err);
         break;
     }
-- 
2.43.0


