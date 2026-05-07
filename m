Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED50ECD3444
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPi-0006ED-79; Wed, 06 May 2026 22:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPg-0006Cz-Oo
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:32 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPe-0007dU-My
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:32 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6949831a7bcso184805eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120669; x=1778725469;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HruOPtNX7hnIWPn24gtKSGxrywCEy0L6f5iPKD3PBNo=;
 b=G3XVmYumO/Y5NiNgfFNlD2LaBjrbZnZIZX0y+we9mF1stYhu6I7kXb34gznrqt6WZM
 PS4nslY5DVCVHdU6xG6ewjSSNL/55+YnHvwIWKRoqVx8vsnF107uJauQaqg6+3OXlpfH
 h2EoiSTrZYtjrsoMZn6MijbRBNb69gWnPQbQnkmLl73W+5vr3aPN4im77v7zJyuhU3Td
 4Gyad4lPvPocDQh5XzyOsVxdPJcVEdkVUwPv2TBqNK6NOYDRMvFY+tPIGAfrl5hYe1bu
 XEOd/RFaPvQcZCa+xaGdyIjziRyeN61ldXdOqpEF7C17ttM0wRIfmkrfKnDO0GuTYGUm
 h1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120669; x=1778725469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HruOPtNX7hnIWPn24gtKSGxrywCEy0L6f5iPKD3PBNo=;
 b=X5vEipz+dtom8TwuZaoFgO4C+VKs+m1FEpLcRR4tYRkWs3/zoQ4qspayKje3Agqeow
 LVJpv3DQG2Tbo+rsa2eDJ/7Qr/80Zk/PtWc4gzWwVfEXeg1L84gm7oTk5z2cskzQSSQu
 aPxiEhtsecE74UheymbhZvXi9eAYsp2brwhVYPPEsSMuwLQ0tD53eVzWkEjyRpH/+xkL
 WhwPvCQndRsCOX03qn+VSYilmvWEc67x94K7cGmETx4ym9tavBN2vdLdv/xwoPmBe0Ny
 3fA12X1+tGUWtj5gwNTj3EDTdeR55BcAG4bZAcZi2FQ7V0ousxNSuZ0QQZcFyuIJvydc
 llFw==
X-Gm-Message-State: AOJu0YxtLlZnqm/UUg6gi/ATbFxXe/oFDZ7o9taR9glqDDp1WGgw4+2D
 UGMImz5v+vic5HcMZmExIz45A30a+Apu1F3ivH5wB9wr+BKEG/FZslArPJQVWrIhU6u1rawiEcT
 hpY+HZd8=
X-Gm-Gg: AeBDievnc3zihV2htwd4llpKFQyQ2i1y25R9fluurih731TLEYEx0I3hxprjdolTMwQ
 y+1nKgFV0yJGCnnP5yz2JhjvRdBWNEsRw/42Kmcv8ojyD7th9YKoWbD4J7aIEZ8kPFmoet5c+wN
 7p03lydaUZvSM0+L8PRRNXu9bdiJw0cCajkfOutK9w84eI1YWiMix3GX3GCPOx3dqj0XILliVRc
 TGr636fJDtPvQLz1cTcG7OZdOvTQ66tpSRLnN6Ft/C47bL4qjmuDwTFT+x2J+7nZ36G4HakKprN
 hCEAWyuC+0O9AuAeAumG8bIRS13r+24fG+1FOS4maa3ZQBzWudyyAzs7Q2XQvCpa769TtVrkr1a
 kNle6OuJg8X84q15NO48PQXHZkImzzIgP172rI46aqeaTZjPKhagr8MRZFsNphmaQTGVn6DD2Ub
 wDsKRPG0U5Du7qFfeBeQSiCY1ua0jrIeU=
X-Received: by 2002:a05:6820:1789:b0:695:a638:c6ba with SMTP id
 006d021491bc7-69998c8c89cmr3437844eaf.7.1778120669075; 
 Wed, 06 May 2026 19:24:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/25] bsd-user: Add FreeBSD socket ioctl definitions
Date: Wed,  6 May 2026 20:22:04 -0600
Message-ID: <20260507022219.44171-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add os-ioctl-sockio.h with network socket and interface control ioctl
definitions including SIOCGIFADDR, SIOCSIFADDR, SIOCGIFCONF, and
related network interface ioctls with target_ structure definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-sockio.h | 246 +++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-sockio.h

diff --git a/bsd-user/freebsd/os-ioctl-sockio.h b/bsd-user/freebsd/os-ioctl-sockio.h
new file mode 100644
index 0000000000..5c1a619400
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-sockio.h
@@ -0,0 +1,246 @@
+/*
+ * FreeBSD sockio.h definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef OS_IOCTL_SOCKIO_H
+#define OS_IOCTL_SOCKIO_H
+
+/* See sys/sockio.h */
+#define TARGET_SIOCSHIWAT       TARGET_IOW('s',  0, int32_t)
+#define TARGET_SIOCGHIWAT       TARGET_IOR('s',  1, int32_t)
+#define TARGET_SIOCSLOWAT       TARGET_IOW('s',  2, int32_t)
+#define TARGET_SIOCGLOWAT       TARGET_IOR('s',  3, int32_t)
+#define TARGET_SIOCATMARK       TARGET_IOR('s',  7, int32_t)
+#define TARGET_SIOCSPGRP        TARGET_IOW('s',  8, int32_t)
+#define TARGET_SIOCGPGRP        TARGET_IOR('s',  9, int32_t)
+
+/* See net/if.h */
+struct target_ifreq_buffer {
+    abi_ulong  length;
+    abi_ulong  buffer;
+};
+
+struct target_ifreq_nv_req {
+    abi_uint   buf_length;     /* Total size of buffer */
+    abi_uint   length;         /* Length of the filled part */
+    abi_ulong  buffer;        /* Buffer itself, containing packed nv */
+};
+
+#define TARGET_IFNAMSIZ 16
+
+struct target_ifreq {
+    char    ifr_name[TARGET_IFNAMSIZ];
+    union {
+        struct  target_sockaddr ifru_addr;
+        struct  target_sockaddr ifru_dstaddr;
+        struct  target_sockaddr ifru_broadaddr;
+        struct  target_ifreq_buffer ifru_buffer;
+        abi_short   ifru_flags[2];
+        abi_short   ifru_index;
+        abi_int     ifru_jid;
+        abi_int     ifru_metric;
+        abi_int     ifru_mtu;
+        abi_int     ifru_phys;
+        abi_int     ifru_media;
+        abi_ulong   ifru_data;
+        abi_int     ifru_cap[2];
+        uint32_t    ifru_fib;
+        uint8_t     ifru_vlan_pcp;
+        struct target_ifreq_nv_req ifru_nv;
+    } ifr_ifru;
+};
+
+
+#define TARGET_SIOCSIFADDR      TARGET_IOW('i', 12, struct target_ifreq)
+#define TARGET_SIOCGIFADDR      TARGET_IOWR('i', 33, struct target_ifreq)
+#define TARGET_SIOCSIFDSTADDR   TARGET_IOW('i', 14, struct target_ifreq)
+#define TARGET_SIOCGIFDSTADDR   TARGET_IOWR('i', 34, struct target_ifreq)
+#define TARGET_SIOCSIFFLAGS     TARGET_IOW('i', 16, struct target_ifreq)
+#define TARGET_SIOCGIFFLAGS     TARGET_IOWR('i', 17, struct target_ifreq)
+#define TARGET_SIOCGIFBRDADDR   TARGET_IOWR('i', 35, struct target_ifreq)
+#define TARGET_SIOCSIFBRDADDR   TARGET_IOW('i', 19, struct target_ifreq)
+#define TARGET_SIOCGIFNETMASK   TARGET_IOWR('i', 37, struct target_ifreq)
+#define TARGET_SIOCSIFNETMASK   TARGET_IOW('i', 22, struct target_ifreq)
+#define TARGET_SIOCGIFMETRIC    TARGET_IOWR('i', 23, struct target_ifreq)
+#define TARGET_SIOCSIFMETRIC    TARGET_IOW('i', 24, struct target_ifreq)
+#define TARGET_SIOCDIFADDR      TARGET_IOW('i', 25, struct target_ifreq)
+#define TARGET_SIOCSIFCAP       TARGET_IOW('i', 30, struct target_ifreq)
+#define TARGET_SIOCGIFCAP       TARGET_IOWR('i', 31, struct target_ifreq)
+#define TARGET_SIOCGIFINDEX     TARGET_IOWR('i', 32, struct target_ifreq)
+#define TARGET_SIOCGIFMAC       TARGET_IOWR('i', 38, struct target_ifreq)
+#define TARGET_SIOCSIFMAC       TARGET_IOW('i', 39, struct target_ifreq)
+#define TARGET_SIOCSIFNAME      TARGET_IOW('i', 40, struct target_ifreq)
+#define TARGET_SIOCSIFDESCR     TARGET_IOW('i', 41, struct target_ifreq)
+#define TARGET_SIOCGIFDESCR     TARGET_IOWR('i', 42, struct target_ifreq)
+#define TARGET_SIOCADDMULTI     TARGET_IOW('i', 49, struct target_ifreq)
+#define TARGET_SIOCDELMULTI     TARGET_IOW('i', 50, struct target_ifreq)
+#define TARGET_SIOCGIFMTU       TARGET_IOWR('i', 51, struct target_ifreq)
+#define TARGET_SIOCSIFMTU       TARGET_IOW('i', 52, struct target_ifreq)
+#define TARGET_SIOCGIFPHYS      TARGET_IOWR('i', 53, struct target_ifreq)
+#define TARGET_SIOCSIFPHYS      TARGET_IOW('i', 54, struct target_ifreq)
+#define TARGET_SIOCSIFMEDIA     TARGET_IOWR('i', 55, struct target_ifreq)
+#define TARGET_SIOCSIFGENERIC   TARGET_IOW('i', 57, struct target_ifreq)
+#define TARGET_SIOCGIFGENERIC   TARGET_IOWR('i', 58, struct target_ifreq)
+#define TARGET_SIOCSIFLLADDR    TARGET_IOW('i', 60, struct target_ifreq)
+#define TARGET_SIOCGIFPSRCADDR  TARGET_IOWR('i', 71, struct target_ifreq)
+#define TARGET_SIOCGIFPDSTADDR  TARGET_IOWR('i', 72, struct target_ifreq)
+#define TARGET_SIOCDIFPHYADDR   TARGET_IOW('i', 73, struct target_ifreq)
+#define TARGET_SIOCGPRIVATE_0   TARGET_IOWR('i', 80, struct target_ifreq)
+#define TARGET_SIOCGPRIVATE_1   TARGET_IOWR('i', 81, struct target_ifreq)
+#define TARGET_SIOCSIFVNET      TARGET_IOWR('i', 90, struct target_ifreq)
+#define TARGET_SIOCSIFRVNET     TARGET_IOWR('i', 91, struct target_ifreq)
+#define TARGET_SIOCGIFFIB       TARGET_IOWR('i', 92, struct target_ifreq)
+#define TARGET_SIOCSIFFIB       TARGET_IOW('i', 93, struct target_ifreq)
+#define TARGET_SIOCGTUNFIB      TARGET_IOWR('i', 94, struct target_ifreq)
+#define TARGET_SIOCIFCREATE     TARGET_IOWR('i', 122, struct target_ifreq)
+#define TARGET_SIOCIFCREATE2    TARGET_IOWR('i', 124, struct target_ifreq)
+#define TARGET_SIOCIFDESTROY    TARGET_IOW('i', 121, struct target_ifreq)
+
+/* net/if_gre.h */
+#define TARGET_GREGKEY          TARGET_IOWR('i', 107, struct target_ifreq)
+#define TARGET_GREGOPTS         TARGET_IOWR('i', 109, struct target_ifreq)
+
+/* net/if_gif.h */
+#define TARGET_GIFGOPTS         TARGET_IOWR('i', 150, struct target_ifreq)
+
+/* netinet/ip_carp.h */
+#define TARGET_SIOCGVH          TARGET_IOWR('i', 246, struct target_ifreq)
+
+/* net/if_pfsync.h */
+#define TARGET_SIOCGETPFSYNC    TARGET_IOWR('i', 248, struct target_ifreq)
+
+
+/* See net/if.h */
+struct target_ifconf {
+    int32_t ifc_len;
+    union {
+        abi_ulong   ifcu_buf;
+        abi_ulong   ifcu_req;
+    } ifc_ifcu;
+};
+
+#define TARGET_SIOCGIFCONF     TARGET_IOWR('i', 36, struct target_ifconf)
+
+/* See net/if.h */
+struct  target_ifdrv {
+    char            ifd_name[TARGET_IFNAMSIZ];
+    abi_ulong       ifd_cmd;
+    abi_ulong       ifd_len;
+    abi_ulong       ifd_data;
+};
+
+#define TARGET_SIOCSDRVSPEC    TARGET_IOW('i', 123, struct target_ifdrv)
+#define TARGET_SIOCGDRVSPEC    TARGET_IOWR('i', 123, struct target_ifdrv)
+
+/* See net/if.h */
+struct target_ifg_req {
+    union {
+        char        ifgrqu_group[TARGET_IFNAMSIZ];
+        char        ifgrqu_member[TARGET_IFNAMSIZ];
+    } ifgrq_ifgrqu;
+};
+
+struct target_ifgroupreq {
+    char            ifgr_name[TARGET_IFNAMSIZ];
+    uint32_t        ifgr_len;
+    union {
+        char        ifgru_group[TARGET_IFNAMSIZ];
+        abi_ulong   ifgru_groups;
+    } ifgr_ifgru;
+};
+
+#define TARGET_SIOCGIFGROUP    TARGET_IOWR('i', 136, struct target_ifgroupreq)
+
+struct target_ifmediareq {
+    char        ifm_name[TARGET_IFNAMSIZ];
+    int32_t     ifm_current;
+    int32_t     ifm_mask;
+    int32_t     ifm_status;
+    int32_t     ifm_active;
+    int32_t     ifm_count;
+    abi_ulong   ifm_ulist;
+};
+
+#define TARGET_SIOCGIFMEDIA  TARGET_IOWR('i', 56, struct target_ifmediareq)
+#define TARGET_SIOCGIFXMEDIA  TARGET_IOWR('i', 139, struct target_ifmediareq)
+
+#define TARGET_IFSTATMAX    800
+struct target_ifstat {
+    char    ifs_name[TARGET_IFNAMSIZ];
+    char    ascii[TARGET_IFSTATMAX + 1];
+};
+
+#define TARGET_SIOCGIFSTATUS TARGET_IOWR('i', 59, struct target_ifstat)
+
+/* net80211/ieee80211_ioctl.h */
+struct target_ieee80211req {
+    char            i_name[TARGET_IFNAMSIZ];
+    uint16_t        i_type;
+    int16_t         i_val;
+    uint16_t        i_len;
+    abi_ulong       i_data;
+};
+
+#define TARGET_SIOCG80211 TARGET_IOWR('i', 235, struct target_ieee80211req)
+
+/* net/if_lagg.h */
+struct target_lacp_opreq {
+    uint16_t        actor_prio;
+    uint8_t         actor_mac[ETHER_ADDR_LEN];
+    uint16_t        actor_key;
+    uint16_t        actor_portprio;
+    uint16_t        actor_portno;
+    uint8_t         actor_state;
+    uint16_t        partner_prio;
+    uint8_t         partner_mac[ETHER_ADDR_LEN];
+    uint16_t        partner_key;
+    uint16_t        partner_portprio;
+    uint16_t        partner_portno;
+    uint8_t         partner_state;
+};
+
+struct target_lagg_reqport {
+    char            rp_ifname[TARGET_IFNAMSIZ];
+    char            rp_portname[TARGET_IFNAMSIZ];
+    u_int32_t       rp_prio;
+    u_int32_t       rp_flags;
+    union {
+        struct target_lacp_opreq rpsc_lacp;
+    } rp_psc;
+};
+#define TARGET_SIOCGLAGGPORT TARGET_IOWR('i', 140, struct target_lagg_reqport)
+
+struct target_lagg_reqall {
+    char            ra_ifname[TARGET_IFNAMSIZ];
+    abi_uint        ra_proto;
+
+    abi_ulong       ra_size;
+    abi_ulong       ra_port;
+    abi_int         ra_ports;
+    union {
+        struct target_lacp_opreq rpsc_lacp;
+    } ra_psc;
+};
+#define TARGET_SIOCGLAGG TARGET_IOWR('i', 143, struct target_lagg_reqall)
+
+struct target_lagg_reqflags {
+    char            rf_ifname[TARGET_IFNAMSIZ];
+    uint32_t        rf_flags;
+};
+#define TARGET_SIOCGLAGGFLAGS TARGET_IOWR('i', 145, struct target_lagg_reqflags)
+
+struct target_lagg_reqopts {
+    char            ro_ifname[TARGET_IFNAMSIZ];
+    abi_int         ro_opts;
+    abi_uint        ro_count;
+    abi_uint        ro_active;
+    abi_uint        ro_flapping;
+    abi_int         ro_flowid_shift;
+    uint32_t        ro_bkt;
+};
+#define TARGET_SIOCGLAGGOPTS TARGET_IOWR('i', 152, struct target_lagg_reqopts)
+
+#endif /* OS_IOCTL_SOCKIO_H */
-- 
2.52.0


