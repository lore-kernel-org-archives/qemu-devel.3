Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8448C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNRC-0003fg-1N; Wed, 26 Mar 2025 05:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txNR2-0003dy-WA
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:52:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txNQz-0005VH-KL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:52:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ab85402c9so258334f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1742982746; x=1743587546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fYv/+j/ZIsFHETZr3Kpyp7xertxIvS+ljCMnTlxQff4=;
 b=Qf373FF/oTwzzum+LPuh8fvQvgAhbbqQzDXAAFL3DWEW6KC6mFQvWIbETOxkrgDJOn
 3b7vRC0e4jzdAe8oK6Ferld4MJlu5PhrWkQ3Pksdj3BAMeYv6Vzo+KLRukE1iIYHPwxw
 F6AlB5CY7QZStzGGd3lFZmU7waFVO3CGakCDTSJi1Tr5fOBtK3igY01n0zskPesUWW1U
 ykUuk+1aD6y9l4kp1yUerY0HIY5pVFRI4uyfBSyFAulb9gxqED/gqjrxB7bWTX5acGD7
 zTQ4vQLK1LfVaSBPSfFIogmrDO1AIY+LTxGFuom2zVazqosDl1c9eXg2iP8T+m8Egkz4
 aN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742982746; x=1743587546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYv/+j/ZIsFHETZr3Kpyp7xertxIvS+ljCMnTlxQff4=;
 b=jBa89c8clnkllRj8s3M3TKV+uZz4svoa1IJK8GSxwO16ekoIIXINqfoqRen4vbXTRD
 EpENCuR4SuSS+FNzA5UvnfVl6t4vdBU+dh5Wzx+cPFP1tjzJn9tJNRXpKSjG1KygX/lV
 jUI0chfEfyp1ORy3yxdXrA4kTVNcSIav419si5qQ7ouANX4xi9wTxG4MGCKxuJKzVWga
 yaCN9OnEIPDFhCSEN/71g4l5fSMTl6v9OU2A/lRvthjZIjQ/dj16XdD04IrTTuXeQAeu
 UeVQEJA9NqPTZg2V7fYuSQ88qqMMDrGuWuzudwo5KlplhILIa4veBD/3UcqoeM6SLVHK
 tD5Q==
X-Gm-Message-State: AOJu0YwZlI6WKAqL1SheGAc3CC4hVYfUFpD8pQ3I2a/oT4lOVxJx524m
 VeVelp9fGsBAb/9zQeq1Iyo2q/2n4AEx8nKYcRy7Jsa6kvoUdw5szMmefUuboBglDih8rjLPXQv
 LTs4=
X-Gm-Gg: ASbGncsccwASAg9C9Mt0115sPtY2jxxjWxVL2yDfNICg14spep43RTLEvk+3UbGK094
 Z5iBGUza6Mmck2Zflm/V66JDGvmtnfE5WV6QR/NwGIoqa0gn8dWOXamMS9Gfjd1htgOMSQRQ72x
 Sn6jr80CCAECHGUBakhuQzKaWW45B8i5WZDJGXI08kOiUImov4oe339IVwqGvEjOg63koTpEZaI
 Ryu6wzKo3oJXH1N/ORfPgzVojieXehRo8Xrm2qknjti8YSchBjvTX03/Do/5QpjiK3bCiD8VV75
 Tq1L0LwmhokCRbujV1ucyro0nnkzF7QSt5M80Ofi58O+mw9qWq0oxvwcZqc4vepSd6s=
X-Google-Smtp-Source: AGHT+IEuAjg/Mj2CyfTUYpQWtNBNkvgahfQSjNDPUoeXO5J7ktV2jMV4YG52AkzJvkT+dyPIn9JSoQ==
X-Received: by 2002:a5d:64c6:0:b0:390:dba1:9589 with SMTP id
 ffacd0b85a97d-3997f936773mr7288811f8f.8.1742982745943; 
 Wed, 26 Mar 2025 02:52:25 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b409fsm16576812f8f.50.2025.03.26.02.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:52:25 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org, michael@flatgalaxy.com
Subject: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Wed, 26 Mar 2025 10:52:24 +0100
Message-ID: <20250326095224.9918-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::430;
 envelope-from=jinpu.wang@ionos.com; helo=mail-wr1-x430.google.com
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
---
 migration/rdma.c | 157 -----------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..5ce628ddeef0 100644
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
@@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
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
@@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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


