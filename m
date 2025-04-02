Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03393C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 05:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzqPa-0000hU-23; Wed, 02 Apr 2025 01:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1tzqPX-0000hG-KQ
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:13:12 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1tzqPV-000388-5s
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:13:11 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ed1d8ff85dso1171555a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1743570787; x=1744175587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tfdn2BU+wITp9h9wEQwWjMQLjmnHPR09C0F2fGaiGF8=;
 b=dD2CuUe62nxotglLuZmraOom3f/vcl/UYnz/xVpIZoGek1wW351Y5iDzmlO4BM9pne
 /NH+coySMzdlR3km2pp+m3ZBOXFGCvMe6kwxfQ/Y2t5R40q7DBJSAwD4/Lm2WSWA0JWP
 ap5H9o9YrBcjX4+7xJYflzL+n8mn3/V+rbaYghd37YVXzRtw89Q4GDDbLS5UHmp2wx+3
 DNk3i4FRUpGuthQJJaM/GKr7aYCWVNwYjg5vu6dvdW0gyY66+0qRKhRfjjuNBakOswoh
 Ci48Bzr0t5jvPp5lgPXrJTUI+wBi7YK9nKVgYMaskd4gTJr5HNORWjnsilDa/CGhJIzM
 885Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743570787; x=1744175587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tfdn2BU+wITp9h9wEQwWjMQLjmnHPR09C0F2fGaiGF8=;
 b=fGGCsZ2GwOOUFxadbsYrYFE0sk/NoR9uyY83V+YcQ02xcZaxvZ+iI2n6wYRN13V4eT
 5MXL+dX1Jo9sgUKHzI2yfusJYRKw9/dkQ5DtJX+90TNlPufvACGyMo+oHLLxtqJ89Low
 ITORETM9jIr2T6ll34Ls2jq5JFi5enH3m6mgtsOYH+WtvZVIpxbNbrCbqfP7uCtAZabh
 TCu5sGl77T5gp6r1zZLCmY55I1Qo/FcBqmtkVkLy95IyPOCAYpWnGTFqxv9ZWLsCfpDw
 a5E4HWwUTvxDa0FXy1/q6RgDJmfAPvh/PCDhFpkb9snFo+mPX7oedMTB6Gjl2d3B5UiS
 BLAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Tkj7EPcAF4Gc+arkq82jgcogkJDlBDykxCyFApxXNBb2/9usyBp0g43QhvrOF1ha4a0JOv2nmizP@nongnu.org
X-Gm-Message-State: AOJu0Yx/Q1URSqTHDyBqvQZzrAgxMKGMNS9H1zMOYpYYqA6MBgifXvO9
 OV0qz1FtsPi+OpKMV3sb4j5roM5iH5UXXl5OoJ+xGrtl8Une6xdFGa4MZWNW3s8=
X-Gm-Gg: ASbGnctqCcHzic1zsneeRyKfJIowOYY8yggBqTkLrwLto63Yn6CWuHG2yi8ujYXB5yt
 BH8Dme8gruCtOJDpRZ0yJ7p2HRcHUXyKLeWumcqPNsd5Z0cv2cHYDzm0C05Ecct0V9X/xnXhwkP
 jVK6VPCNqydYHQ45HmA0F3yKV32se9v52p20MXCoSwRaG1in7vsf44gCLGOWVxBJwJVKk2NjuXN
 UYQEsD2mPEB1BcVGqvGKpPfPPnYZeLVcUApyiZsWMqodMvtDOOzZsac1dffTjSK5UX05vhu3Qln
 f3Bjie0AqOUVUQmNDQYgXIpnAwKJkHWMD/XYHCOmB0ddMzt+jpbt1k0=
X-Google-Smtp-Source: AGHT+IGZQklArU44+6jqyQBLkNUPkS8PGaCrdODkUXOFf7PFIkWqoyaG4U1TJTTIelPExgY1dlbhxA==
X-Received: by 2002:a05:6402:34c9:b0:5e8:eaa9:23c3 with SMTP id
 4fb4d7f45d1cf-5f03d952b74mr1320773a12.10.1743570787353; 
 Tue, 01 Apr 2025 22:13:07 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1475:3300:fdc6:d1d1:b89d:5668])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17b2ea0sm7897118a12.53.2025.04.01.22.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 22:13:07 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Yu Zhang <yu.zhang@ionos.com>, qemu-devel@nongnu.org,
 michael@flatgalaxy.com, Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PATCHv2] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Wed,  2 Apr 2025 07:13:06 +0200
Message-ID: <20250402051306.6509-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::52d;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52d.google.com
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
Cc: Fabiano Rosas <farosas@suse.de
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
---
v2: cleanup unused err, update comment (Fabiano)
v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

 migration/rdma.c | 178 +----------------------------------------------
 1 file changed, 3 insertions(+), 175 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 143008a28a20..35cd3e1a2976 100644
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
@@ -917,7 +774,6 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
  */
 static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_addrinfo *res;
     char port_str[16];
@@ -953,9 +809,8 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         goto err_resolve_get_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses, exit loop on first success of resolving address */
     for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -964,25 +819,12 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
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
-            error_free(err);
             goto route;
         }
     }
 
     rdma_freeaddrinfo(res);
-    if (err) {
-        error_propagate(errp, err);
-    } else {
-        error_setg(errp, "RDMA ERROR: could not resolve address %s",
-                   rdma->host);
-    }
+    error_setg(errp, "RDMA ERROR: could not resolve address %s", rdma->host);
     goto err_resolve_get_addr;
 
 route:
@@ -2611,7 +2453,6 @@ err_rdma_source_connect:
 
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
@@ -2661,9 +2502,8 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         goto err_dest_init_bind_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses*/
     for (e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -2672,24 +2512,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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
-        error_free(err);
         break;
     }
 
     rdma_freeaddrinfo(res);
     if (!e) {
-        if (err) {
-            error_propagate(errp, err);
-        } else {
             error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
-        }
         goto err_dest_init_bind_addr;
     }
 
-- 
2.43.0


