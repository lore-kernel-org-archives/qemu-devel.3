Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97DFCD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsH-0007pF-8u; Sat, 02 May 2026 13:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsC-0007o8-Ur
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:25 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsA-00071K-Ld
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:24 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de46b8e432so2764831a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741881; x=1778346681;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pzQlBpwbjHKfNIX1F8NUcqNQc7eo7uRyI8xNbg1H5G0=;
 b=KfrJwtSH1FOyvRfcjPxqlzgPmprP/5QHNJ4Dkr+A51SWKAHh3jFVnT988KqVhdXXwv
 uQQGylYrVDsRZA20ef3PbnjZK8o6rkKs/tkcdzg01tXEsph1nCIzI7McFJJoJO+CbdcG
 kPUkAuizf9VwBGAT+u3tUq1y7wmDlofYWKRihPGqaTF3lYPoRkLchayW5+glit3HLCIJ
 PH/yYys3pb5ng4nEqceUkIJPY3DKvzMMPR/Zdog6PSIbJO/lqhkSofynO8VAcZWmwO7C
 NuuD//1InnDKDLC1YzRwAnu8g/cMsGYrF+nn38voVpEqKarT2AVboEJ82ICfSeu4qrjv
 9uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741881; x=1778346681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pzQlBpwbjHKfNIX1F8NUcqNQc7eo7uRyI8xNbg1H5G0=;
 b=GvqUfpWQBjuIFJJKdVKBN7COyWc9aNbi/rRrfx2RO9xhv5n3V3qv4R4UuY04cTHoK5
 4yLJosJNFF6TzLkssAvWjiLh97st1+PmrrnbqzTbe7a9355XN4zvywlyFM1UOYzlau5L
 Mje7G9QBuutNap15xGaXdDEvM8THGglmN2ecDnJvK85VRZ8TWM+SoC6Ckzdgt1Oyi3Qk
 lnirSDCvwgrQcamKLXBcJFUGLmNe9ehxL79lGxBbwSVobemqgIpmt1SHy9/dAQnk3X5m
 MO5jauGNrzEzA548P8y/V5Ngy+s7oWDC5OHohyPxy2lHHYHheAjihLf0Nj+znx1toj81
 5Vyg==
X-Gm-Message-State: AOJu0YxqVuINlc+jmzGYTUBehtVsvYy5JE+4eo8oKWAZB/qXz3KePqn7
 WEjBpkcs+k32okwQCR86BvfMTG5oqqEUaRPL3axNASPub11FWgEpTZwP1SDiX5RbiMrMZl/lIYB
 c1J5VMGg=
X-Gm-Gg: AeBDieumO7A6cHuaWyGlffXhzUlzIHyJDwI85YY+av2rxSF9JLqUBl9KWmOK/hgIn6k
 eL71+wZefQIjXthpB8+sCQ12paeipSmodHQ7pa/ihob7einKBn5imQmUEyzf80SnW3OSzwIQTyX
 /K28KXD3zevMFuC3R1WUMgpfV5eUBPbQhnqOsC7VfRDwq5LQfrZS6+KdUdDOCSUOEI038WIyDJP
 VCAdqMW5FK+hAmh8WkgO6rwTFv5aW7n+EpU1qwx9O7jMCitmwoIjIGAL4pKTK3OiIrHn4srWs0C
 bHim7kFGZeYi9LEbCvfFO28+4XBDPHZzUDX2mM3YGCRXOtxnnhLkEpZoe4lvFJ8LN0cN4H0n0Nm
 SfeCW8XvBj/DQ7TUYydJ4J2p3M4I4ZRMXWSibdIRcnPyUZfBz+ehIzRvm/aSoLm30hPtUoFljcV
 1bSx0hGCuqIuG9Bjh7rxew
X-Received: by 2002:a05:6830:2690:b0:7d9:b338:a695 with SMTP id
 46e09a7af769-7dee11f9cacmr2324682a34.5.1777741880987; 
 Sat, 02 May 2026 10:11:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:25 -0600
Subject: [PATCH v3 04/19] bsd-user: Add FreeBSD socket ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-4-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10291; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Ou0K8wtzOZ5vOnY95dtBNYMlFjgDPOiJ0Dxme7+Y3Zs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/PwlyNMocNMwkYFZ4EvrpSrj/FPJDUDpQVa
 qz5O5lEbdmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 AL0nEACWnY2hGUnTQwJvlTkZoZPI//2kASg+BpQ1ZgHWRC1PpHyzOWDFtQS+/feL77e+WHngVm9
 T6P6wDRknU462PoAiES7vJAOmSYv4gsZ7JC/+9xgHC3MnZa+cMS6qRMcDVo6tOiIJaH/5VgmPAA
 2baJoe0GkRk1Y8N3tRtVZB+oN1CEP5vkhfcUbSc0c4GGCNnGKqSoIa/5U72TDvCrIDgvZ0sK4Gx
 Cpd94po2Z3bPQd6JWZ31sjJfl4FkAp/lBijNvuM/TJ0zkusv28EippJcrtgAfoBUgzCxUtx5thp
 orm1tp4ycGPD2dDlDb0Ohhqx0UTGvpMEtGOzZJ4QRmfO892Qg7wf8CvzNEQW6vBQFW3STEYR7wz
 nK8bQpd0kSgzdJS6n5J1XMEKSY/b4eqrkZ0P80Clo7Up28RZGmDYuFmtER/VMhrAuVgGeZH6q3m
 L/OrGgCjHm1MIW9G1xXSuSMfi6jku9nlU7jQPaMMakbUEtWdRqbaXZE43gb39bBROyvK2LAkdmv
 unhhfL3+MGlBFlkE/TwnpyBschdOUhbgMBBg4DoqkZ2eik41NRPn9oTP3IC/5326WTQJvebRNFT
 oZD0dgV/JnNZJtjabFsYNKdim2S0Z0JmbK4Jh5JY8b465XBla79XfQPdqX+BK+x05tLt5c3cYN4
 HIyDkZy0l4OR2DA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-sockio.h | 246 +++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)

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


