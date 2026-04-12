Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D8DE937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIA-0006UR-R7; Sun, 12 Apr 2026 12:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHn-0006Pj-J2
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:50 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHh-0004UV-O5
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:47 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4be94eeacso3966266a34.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009815; x=1776614615;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BTe/D/bvROg9C7EiZvO4+y9jfPH29sCoFwKyN55BCew=;
 b=qdiJoEK6hRiWP0yuE4g/ifj98eE7RK1d+9NGAxbsvjch2T0JkbKQKdRKjo4B/MJxHt
 Afm4d2f4sqNYq0OL/2dn0yQOj1G+vW9wW7+fpQh2y9MEDV6XXhwI7K5UTEzCwxbqD4sB
 +YTq6qG6XQgi1Rjq7OLedDvnp3tdO+KKhx0E8ZSeZPNTYywqySBMO/Pn8hNQcNTQlvhN
 syeQadUTHwThmyNHdc6tjOnXMW0Ff+s6Gu8JCuIGQnMoMHZ6SB4hJv9DccwUqFxabEo5
 EGqtFuAXNBapwlswTgTC8EqJm8Ijoo0K346QntJZg0455V3zxUde52E6N94uZXJBhNEF
 u/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009815; x=1776614615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BTe/D/bvROg9C7EiZvO4+y9jfPH29sCoFwKyN55BCew=;
 b=SR15rVPHZiTaT+0gy+XFoee+hG/7gWdZ8I0ELU+6q/Ne6uf2RHvdsaX5Nvh17ZDWGg
 kGo2zihxOEc/6EB777w/TFO72n4YlyMSW6va2wNBOP8iltKPPxLB+Mjvt04g16z1CtQG
 E+10igsIUMn5C6ahdNBxzcXa9vqy0uI1+12y6wmVUXXYy8nHRK4z+7PckltywYD9f7Ma
 Ke3HX0ru+sK6KZLs7ZD9LamOsnrfiMk2Bp3e5wxV4tpaiYM+jwwC5PH3vegqnIKWiFQC
 EcR5ZshpfAwzrPJVQ1cnbHh6Cyp7eF5TQAkYfSwZkhQIFPb1D22aOQWZkx+UguxinQU1
 qNkg==
X-Gm-Message-State: AOJu0YwFgdseWQc/URU8+Hs130Ssq7uA5A7NAk+8/Xq65ab5dJeYaNbs
 IqL4+cWrYYFUmE66BgM7aTz3eI8VUQOMDXw/zREZdCsRgEKFwb+hvCPq3kQtks3Jm9F62UV0KRD
 waoRc19Q=
X-Gm-Gg: AeBDiesuE2QVx5ENjKQ6AYJStOPUu1+KkWK5ZZzDLXtyQN2lA7CTLAM+OjpCjiWYJA/
 LVqxhZMecnyYcdfXQXN2YXw/4ZoYdajYIcH3SyCTrQ3zmbWTB1LDFqLi8/0ws2NsdYg57UWsenE
 bysqa6ZSskZ92xcgwlhIwUo51SknDOdhyMjx4rTP7D00PTqs/dpIBPa9WjPYwS4y+bf0BRP8Eni
 NDNDdqcI4m2ue4heCPUrr2JW+wY2bEGffQNRGc7bheb7bRCNRYvWgf/LMHJhbA6E/mUyp8egXzr
 ESwcT/qPTu150I8+Rtd9JlEeMDvje3SwJ3GG5u5nFGSD3YpQpobDrFEQiDeUQu5acfQBs7DQ/hd
 /hJfXE9XdVEnMqFZYxgikvtscCgazBPFq6Pr4SMvwjCv6Mnyc8BSa4SPGo0gxWoO3jbB1KyhYUW
 /NMK22K5k9ZQ==
X-Received: by 2002:a05:6820:6306:b0:67e:16b4:aa07 with SMTP id
 006d021491bc7-68be8fccf9cmr3747802eaf.61.1776009815390; 
 Sun, 12 Apr 2026 09:03:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:26 -0600
Subject: [PATCH 03/17] bsd-user: Add FreeBSD socket ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-3-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9965; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=E5TcCxhlYakiFKXgpDFbtw1vmY+ujW4UaM+sGPBsaMY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IfQLUffg/sqZ/ObIK85gemryruK6Ywesy2S
 SJCi25wa7eJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCHwAKCRBsHNEofbAR
 AHakEACun4hjYy8vcIKW9J698+tJTDomk3ntwNj4sK1IW8hpxbFO1bi5LNLzNFhcOEGLqpjWl/n
 JtHqMgMbPvkegE+oQPJc1giqvlHw73wKQyLnotATN9Zqe+ZvgKherTC21t60EXvxNmIBJPlU6Vu
 Ydi8Z+9Mr2svXj8yG9keqfgBSW6MOot+hmaLbZuGkC1I5SRgsOJrwHzKDlxWnLBCl0IbYrvs/I7
 4kqLezLK7Vb41vyalGdYq32q51HkMy/BntFyrztwXQa/z250A0SHekTcADxirABvNQvLRo4/a6X
 Cf4gCdEbJuQ6hrh0D5zg6ejaX++Z2n6RcP5ZrSxWwo1qOVP4En+UxgXB0WrkGCR+3Tct3hRBpB0
 X6jpxbGf4dO5/cUkt8dj/Sk6ZV4hr8ESDKwA+APwIPPx+nJ3mXLZ9MCzjbQf1I+BS4rYQzWninP
 sSulSv5tSIGZXdV6DAOjnd4Uct0RZqKb5kAxo0EgsA0xRreMG/aukqOHBGYKoFC3b6IREt5MWM6
 HFoaD9vehGHo7bp5QocX+MOrvl7zgrQCaQQSxK18oRtrZyk85UuKQi9ZzjtuJbFnual38yAY2Aa
 T5S/WllZ+4F1XrgZ2EsRCjPuXzn5pu+somCCWH5yRMC6/7nkr0IMNBxHJYyTKe9bt7trKH+Iovc
 +9uzvnvKdKICBuA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-sockio.h with network socket and interface control ioctl
definitions including SIOCGIFADDR, SIOCSIFADDR, SIOCGIFCONF, and
related network interface ioctls with target_ structure definitions.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-sockio.h | 240 +++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-sockio.h b/bsd-user/freebsd/os-ioctl-sockio.h
new file mode 100644
index 0000000000..90a9950177
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-sockio.h
@@ -0,0 +1,240 @@
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
+#define TARGET_IFNAMSIZ 16
+
+struct target_ifreq {
+    char    ifr_name[TARGET_IFNAMSIZ];
+    union {
+        struct  target_sockaddr ifru_addr;
+        struct  target_sockaddr ifru_dstaddr;
+        struct  target_sockaddr ifru_broadaddr;
+        struct  target_ifreq_buffer ifru_buffer;
+        int16_t   ifru_flags[2];
+        int16_t   ifru_index;
+        int32_t     ifru_jid;
+        int32_t     ifru_metric;
+        int32_t     ifru_mtu;
+        int32_t     ifru_phys;
+        int32_t     ifru_media;
+        abi_ulong ifru_data;
+        int32_t     ifru_cap[2];
+        uint32_t   ifru_fib;
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
+        abi_ulong   ifcu_reg;
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
+    uint32_t        ra_proto;
+
+    abi_ulong       ra_size;
+    abi_ulong       ra_port;
+    int32_t         ra_ports;
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
+    char            ro_ifname[IFNAMSIZ];
+    int32_t         ro_opts;
+    uint32_t        ro_count;
+    uint32_t        ro_active;
+    uint32_t        ro_flapping;
+    int32_t         ro_flowid_shift;
+};
+#define TARGET_SIOCGLAGGOPTS TARGET_IOWR('i', 152, struct target_lagg_reqopts)
+
+#endif /* OS_IOCTL_SOCKIO_H */

-- 
2.52.0


