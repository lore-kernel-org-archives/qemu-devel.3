Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74123E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxI8-0006Tt-Km; Sun, 12 Apr 2026 12:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHp-0006Pr-Fd
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:52 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHj-0004V0-I2
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:48 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4645dde00a7so2819423b6e.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009820; x=1776614620;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rm4n/Ct2kmMIgYudwVfyNN0Qjq7Jfkatneto3NuwicI=;
 b=Skal0CtZIXrqcmO/6I4uZVSXo3OObWWswrVP7HJ8KWgP0YpSy9bh7MUu26z1IIfNRJ
 +xh/TQa7EKdOlwX9jxYTyuxadxMq0wXtZj8IN5Q88hs0PrYDOKIEziqHgAyQyWuHcljU
 rhVxA8ntlzBq9rY3MJTOhh41wm3u0Mcu7rH4H4oMEY0ZVKlGHkOLuchnrNIIpY4jAHCo
 +Xa9VOQGxJD0TvTozs6j3By1+xxdAQFsoEh5hYV6IvMgUK56idGIiYbwraqSVEBZ24dE
 tLdMb4ZZkZbIK6Pe3EFokFF1sV8gaCpf4BdhPAbiIUeLYCpuSbwcF1TIbNGEfKaFhiaq
 8wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009820; x=1776614620;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rm4n/Ct2kmMIgYudwVfyNN0Qjq7Jfkatneto3NuwicI=;
 b=SaWsyDhPRbj6BSozR0bc4QcOjvpmsN8Cb+0oC6dCAGbsSiQeMpLcYlEo4/G4rV+oAc
 S/0WBa5sOhgzTugdsqCEQRLj/rW2PfFMnMWLNy3OBmeI/ac3L0iXio6gRpKgJ4nT/G9J
 qkIGrNV2QiZhrJDQdh4B4uZIc790f8dF8Jl/gpDcMjlPWNd8KzfgEs5gQ4T6KKd4W9ts
 96oeGLQeaOrIaDWbU6FzfnOVsGpy3Z0XLSm42IXNQFL1ywlhA0T7HOrcPM+7fsBBIEVb
 sCAAz08LlgraJDb4SQag4a0lmb/jzyudcNThKQ0ZCEy5aN17ejqm/wf2Y8J8glIBcx/m
 Dksg==
X-Gm-Message-State: AOJu0Yzx7ZupiDMBPC7KykndjvmKQG0u3yhtI6zXVhwumyKtssBJHWxu
 ZSPMAboVdrIP2mvqEl4QCnv5NXluxpaJA0JNKFx0+AEytOe1PiUusGx04/70XCIjUyF2nKS9/2s
 P7vANaKo=
X-Gm-Gg: AeBDieuxcd7DggGG/TzEzWtH+HOd7dYoDJE6JFvpSVi/VcrdgA283txq6hJLYkQz+4V
 e/LJfXzRqM+MXNN1ocLwRHiwYakTlzY8t4qZBgR5LZTX22FYmNy0WXs3QTnFNUy0EYH/daU3ZMm
 5JFfnyJQvC7y55gn11JVi5qhFJOb7H5H2skxFqHCtPR0k+bQirUPh7TG/G9oIUiP44+4n+sawIx
 Dw0D1JGhOm26DxFEgUzIdaCvjC4Dk0a9MYPMxAcqwDFYyT7vcUnkDT6OOJA6xvnKAji5lFw2vdM
 oxCkqSyaDetbdDRyrqOz7eTHSaoFXkVCx8e0a0WBGN5lHBygEG1r28AgAB8n4ZdeO1aYwL51Gw2
 ViOScwk1kVKLHl652nYQ/M4uhEWxGzpkB3WFrYXVIrrtCo6eUSSeZf+dpTrZbxE0nyt4SjWao82
 1YVSRzwHflvg==
X-Received: by 2002:a05:6808:11c9:b0:45e:d94c:70b with SMTP id
 5614622812f47-477272fe437mr6010188b6e.0.1776009819884; 
 Sun, 12 Apr 2026 09:03:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:29 -0600
Subject: [PATCH 06/17] bsd-user: Add FreeBSD IPv6 ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-6-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8387; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gZmM7uu3K8cX/RwjkkOXNVmFwtWCH9uYOgns46xr4Cs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgwmGegezCGfWwwf94NHhmYmprv6bQ9Qar9
 JdP0FVzrU2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 AMWSD/92FIysc0bVNmB6GbvQ7JohBahuJ2a65z1vQZ2bHgRUD5k3efWMuG2jFkElZh2kqhFaWnv
 hD0aZHRlKHNzcRrZlol3CtKUnLXzkAWPqRzLZ4m7GcxzRBSevqUBt0xiARrhfwZpP1ymqDhD6Xa
 hYoWNeg17fEYb+hzlUmcbd8bh8kBe07+ZEx0zZbsX+C2I+/vjG+/NXEXq6+PfvZESWbq6e1DaQC
 2GD9rWfinZ+/Wri6EZuCD/usMkJf7XGKEt6ffgUHfCHlwL2h3Ub9OBvTbz206IA77XgXxikPnEq
 SSgAE9l/IVKMj5Mi988q4e46lQN/g7Z8MgIGsgVLoR+bzB0PfsZK8Epz+Q9rp9uiSq8Vqja+2mf
 Nogd1rr37XSSa1euuadOGnI31uozth7JK4K9C8CxD/xSuUAsrSGBulzNEq+2AdEkQuQyeQnwxKQ
 byNOfV3iP2CjrpkvrsA5asnbrAPl9fp9lqL3tPn1oCQrTrrurUbmKAirBugcTmpuiQdUVxCf1bN
 AQed4VQ6qT/a98UDkiizH8nx1CFaMIXzXJ7tryH8rdyxhbdK4aWsB3oNpCK1JtWKdqzlEdhZ37l
 7a6sQXju7NvDU2roPcnk+Oa1mQYT0F0fHMp0ILuhFcbtkriTUVr+JHwfm7sLTu1/LCDIqyB49aH
 H9wL0Tl/8vfFPYQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

Add os-ioctl-in6_var.h with IPv6 network interface ioctl definitions
including SIOCAIFADDR_IN6, SIOCDIFADDR_IN6, and related IPv6
configuration ioctls with target_in6_* structure definitions.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-in6_var.h | 217 ++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-in6_var.h b/bsd-user/freebsd/os-ioctl-in6_var.h
new file mode 100644
index 0000000000..3656b27918
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-in6_var.h
@@ -0,0 +1,217 @@
+/*
+ * FreeBSD in6 definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2014-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H
+#define BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H
+
+/*
+ * see netinet6/in6_var.h
+ * and see netinet/in6.h
+ * XXX target_in6_addr and target_sockaddr_in6 should maybe go
+ * somewhere else.
+ */
+struct target_in6_addr {
+        union {
+                uint8_t         __u6_addr8[16];
+                uint16_t        __u6_addr16[8];
+                uint32_t        __u6_addr32[4];
+        } __u6_addr;
+};
+
+struct target_sockaddr_in6 {
+        uint8_t         sin6_len;
+        uint8_t         sin6_family;
+        uint16_t        sin6_port;
+        uint32_t        sin6_flowinfo;
+        struct target_in6_addr sin6_addr;
+        uint32_t        sin6_scope_id;
+};
+
+struct target_in6_addrlifetime {
+        target_time_t ia6t_expire;
+        target_time_t ia6t_preferred;
+        u_int32_t ia6t_vltime;
+        u_int32_t ia6t_pltime;
+};
+
+struct target_in6_ifstat {
+        uint64_t ifs6_in_receive;
+        uint64_t ifs6_in_hdrerr;
+        uint64_t ifs6_in_toobig;
+        uint64_t ifs6_in_noroute;
+        uint64_t ifs6_in_addrerr;
+        uint64_t ifs6_in_protounknown;
+
+        uint64_t ifs6_in_truncated;
+        uint64_t ifs6_in_discard;
+
+        uint64_t ifs6_in_deliver;
+
+        uint64_t ifs6_out_forward;
+
+        uint64_t ifs6_out_request;
+
+        uint64_t ifs6_out_discard;
+        uint64_t ifs6_out_fragok;
+        uint64_t ifs6_out_fragfail;
+        uint64_t ifs6_out_fragcreat;
+
+        uint64_t ifs6_reass_reqd;
+
+        uint64_t ifs6_reass_ok;
+
+        uint64_t ifs6_reass_fail;
+
+        uint64_t ifs6_in_mcast;
+        uint64_t ifs6_out_mcast;
+};
+
+struct target_icmp6_ifstat {
+        uint64_t ifs6_in_msg;
+        uint64_t ifs6_in_error;
+        uint64_t ifs6_in_dstunreach;
+        uint64_t ifs6_in_adminprohib;
+        uint64_t ifs6_in_timeexceed;
+        uint64_t ifs6_in_paramprob;
+        uint64_t ifs6_in_pkttoobig;
+        uint64_t ifs6_in_echo;
+        uint64_t ifs6_in_echoreply;
+        uint64_t ifs6_in_routersolicit;
+        uint64_t ifs6_in_routeradvert;
+        uint64_t ifs6_in_neighborsolicit;
+        uint64_t ifs6_in_neighboradvert;
+        uint64_t ifs6_in_redirect;
+        uint64_t ifs6_in_mldquery;
+        uint64_t ifs6_in_mldreport;
+        uint64_t ifs6_in_mlddone;
+
+        uint64_t ifs6_out_msg;
+        uint64_t ifs6_out_error;
+        uint64_t ifs6_out_dstunreach;
+        uint64_t ifs6_out_adminprohib;
+        uint64_t ifs6_out_timeexceed;
+        uint64_t ifs6_out_paramprob;
+        uint64_t ifs6_out_pkttoobig;
+        uint64_t ifs6_out_echo;
+        uint64_t ifs6_out_echoreply;
+        uint64_t ifs6_out_routersolicit;
+        uint64_t ifs6_out_routeradvert;
+        uint64_t ifs6_out_neighborsolicit;
+        uint64_t ifs6_out_neighboradvert;
+        uint64_t ifs6_out_redirect;
+        uint64_t ifs6_out_mldquery;
+        uint64_t ifs6_out_mldreport;
+        uint64_t ifs6_out_mlddone;
+};
+
+#ifndef TARGET_IFNAMSIZ
+#define TARGET_IFNAMSIZ 16
+#endif
+
+struct target_in6_ifreq {
+        char ifr_name[TARGET_IFNAMSIZ];
+        union {
+                struct  target_sockaddr_in6 ifru_addr;
+                struct  target_sockaddr_in6 ifru_dstaddr;
+                int     ifru_flags;
+                int     ifru_flags6;
+                int     ifru_metric;
+                abi_ulong       ifru_data;
+                struct target_in6_addrlifetime ifru_lifetime;
+                struct target_in6_ifstat ifru_stat;
+                struct target_icmp6_ifstat ifru_icmp6stat;
+                u_int32_t ifru_scope_id[16];
+        } ifr_ifru;
+};
+
+/* netinet6/nd6.h */
+struct target_nd_ifinfo {
+        uint32_t linkmtu;
+        uint32_t maxmtu;
+        uint32_t basereachable;
+        uint32_t reachable;
+        uint32_t retrans;
+        uint32_t flags;
+        int32_t  recalctm;
+        uint8_t  chlim;
+        uint8_t  initialized;
+        uint8_t  randomseed0[8];
+        uint8_t  randomseed1[8];
+        uint8_t  randomid[8];
+};
+
+/* netinet6/nd6.h */
+struct target_in6_ndireq {
+    char ifname[TARGET_IFNAMSIZ];
+    struct target_nd_ifinfo ndi;
+};
+
+struct  target_in6_ndifreq {
+    char ifname[IFNAMSIZ];
+    abi_ulong ifindex;
+};
+
+
+#define TARGET_SIOCGIFDSTADDR_IN6 TARGET_IOWR('i', 34, struct target_in6_ifreq)
+#define TARGET_SIOCGIFNETMASK_IN6 TARGET_IOWR('i', 37, struct target_in6_ifreq)
+
+#define TARGET_SIOCDIFADDR_IN6 TARGET_IOW('i', 25, struct target_in6_ifreq)
+#ifdef notyet
+#define TARGET_OSIOCAIFADDR_IN6 TARGET_IOW('i', 26, struct target_oin6_aliasreq)
+#define TARGET_SIOCAIFADDR_IN6 TARGET_IOW('i', 27, struct target_in6_aliasreq)
+
+#define TARGET_SIOCSIFPHYADDR_IN6 TARGET_IOW('i', 70, struct target_in6_aliasreq)
+#endif
+#define TARGET_SIOCGIFPSRCADDR_IN6 TARGET_IOWR('i', 71, struct target_in6_ifreq)
+#define TARGET_SIOCGIFPDSTADDR_IN6 TARGET_IOWR('i', 72, struct target_in6_ifreq)
+
+#define TARGET_SIOCGIFAFLAG_IN6 TARGET_IOWR('i', 73, struct target_in6_ifreq)
+
+#ifdef notyet
+#define TARGET_SIOCGDRLST_IN6 TARGET_IOWR('i', 74, struct target_in6_drlist)
+#endif
+
+#define TARGET_SIOCGIFINFO_IN6 TARGET_IOWR('i', 108, struct target_in6_ndireq)
+#define TARGET_SIOCSIFINFO_IN6 TARGET_IOWR('i', 109, struct target_in6_ndireq)
+
+#define TARGET_SIOCSNDFLUSH_IN6 TARGET_IOWR('i', 77, struct target_in6_ifreq)
+#ifdef notyet
+#define TARGET_SIOCGNBRINFO_IN6 TARGET_IOWR('i', 78, struct target_in6_nbrinfo)
+#endif
+#define TARGET_SIOCSPFXFLUSH_IN6 TARGET_IOWR('i', 79, struct target_in6_ifreq)
+#define TARGET_SIOCSRTRFLUSH_IN6 TARGET_IOWR('i', 80, struct target_in6_ifreq)
+
+#define TARGET_SIOCGIFALIFETIME_IN6 TARGET_IOWR('i', 81, struct target_in6_ifreq)
+#define TARGET_SIOCSIFALIFETIME_IN6 TARGET_IOWR('i', 82, struct target_in6_ifreq)
+#define TARGET_SIOCGIFSTAT_IN6 TARGET_IOWR('i', 83, struct target_in6_ifreq)
+#define TARGET_SIOCGIFSTAT_ICMP6 TARGET_IOWR('i', 84, struct target_in6_ifreq)
+
+#define TARGET_SIOCSDEFIFACE_IN6 TARGET_IOWR('i', 85, struct target_in6_ndifreq)
+#define TARGET_SIOCGDEFIFACE_IN6 TARGET_IOWR('i', 86, struct target_in6_ndifreq)
+
+#define TARGET_SIOCSIFINFO_FLAGS TARGET_IOWR('i', 87, struct target_in6_ndireq)
+
+#define TARGET_SIOCSSCOPE6 TARGET_IOW('i', 88, struct target_in6_ifreq)
+#define TARGET_SIOCGSCOPE6 TARGET_IOWR('i', 89, struct target_in6_ifreq)
+#define TARGET_SIOCGSCOPE6DEF TARGET_IOWR('i', 90, struct target_in6_ifreq)
+
+#ifdef notyet
+#define TARGET_SIOCSIFPREFIX_IN6 TARGET_IOW('i', 100, struct target_in6_prefixreq)
+#define TARGET_SIOCGIFPREFIX_IN6 TARGET_IOWR('i', 101, struct target_in6_prefixreq)
+#define TARGET_SIOCDIFPREFIX_IN6 TARGET_IOW('i', 102, struct target_in6_prefixreq)
+#define TARGET_SIOCAIFPREFIX_IN6 TARGET_IOW('i', 103, struct target_in6_rrenumreq)
+#define TARGET_SIOCCIFPREFIX_IN6 TARGET_IOW('i', 104, struct target_in6_rrenumreq)
+#define TARGET_SIOCSGIFPREFIX_IN6 TARGET_IOW('i', 105, struct target_in6_rrenumreq)
+
+#define TARGET_SIOCGETSGCNT_IN6 TARGET_IOWR('u', 106, struct target_sioc_sg_req6)
+#define TARGET_SIOCGETMIFCNT_IN6 TARGET_IOWR('u', 107, struct target_sioc_mif_req6)
+
+#define TARGET_SIOCAADDRCTL_POLICY TARGET_IOW('u', 108, struct target_in6_addrpolicy)
+#define TARGET_SIOCDADDRCTL_POLICY TARGET_IOW('u', 109, struct target_in6_addrpolicy)
+#endif
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H */

-- 
2.52.0


