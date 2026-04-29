Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21786FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6C4-0004l3-DR; Wed, 29 Apr 2026 10:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bo-0004Tt-P6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:01 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bm-0004Z2-HH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:00 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so11258731a34.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474017; x=1778078817;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rm4n/Ct2kmMIgYudwVfyNN0Qjq7Jfkatneto3NuwicI=;
 b=x6AkrhIKS0mvF9w/GElCBk0WEkAySyup4IlYNCZE9Ffe5YS6xHYGfaF+bRJnAUkNOD
 GL1xaGLCR2NIMt+KwLAz0H/I5nOcbX1BaALK5rQX+LPCIEQrwn76NfOB0Tk7SRreuTDR
 mV9q4zMybfE15bebD160KziVaxR4CrJqCf0/rey1pE1oMSoXqFegiLsQ2gITj339NzCe
 HaSRxGMg8D0CZNCYk8U8JChSrFgukCRryw1teyfd8J7zqKV5S2UWoIUw2m1AEs8dV7DO
 NiGjVfsiUAk3CMdlXPCHUtkP0hAAZdqoe8xWsAGhcX2pZhf2jCapqM4PfJqfg1j5Oszb
 PeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474017; x=1778078817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rm4n/Ct2kmMIgYudwVfyNN0Qjq7Jfkatneto3NuwicI=;
 b=DuWCGBx6GYyfIlscrt2W3noom6Mk3PqvBaiiai7Y1MxRLZdx/9fKvrOJZlNvUQ2Mbi
 tXCOWeK90wy8m/nXyZd31NOwsLNUj0rMUHUrD7wiC8QrF3H2H90hHOAZWbvXsmbdtXiY
 /xE41y4k94G9L2egp6J9vLxDc9rUm5EUcK3YT7WlPv6WVCIXz0KDZge4eOQL8TWFyp3u
 ldwHhNVzPd51RD+/+7Rjp/8qCHPVowNW/zFmFnNsy6J5eMZBFx436rP+eGk42PwT0L5j
 3uhvSrgnQ3jcffdNX/1caDjdHlTSisTi8R9exr12KX0BbAIKaBVvSCkOnJOU0/4APxKb
 lj/g==
X-Gm-Message-State: AOJu0YyWOraPTV0Ia+qf6MW+Q98C3FhIQ2pKmVJfSWSqmWhddqhQyh6o
 d9OS7D1uRzN6HW57q/5JKT1MT+PnEA2LyAmziTVVwSkyF+HFPl9OKJDGN7pdZJ/5JxvSPbo7NOE
 R2Thu77A=
X-Gm-Gg: AeBDiet/oVinZX639RrFlQak6zgnvVaCLfSN41efZM480ieDIcetqVfmmEwyb28DqSr
 nf5T/9a3jbsYZq21P9HMv84bOWv3+hdhZDd3wfv0KI+udanbj4teldnxILmyiir3aE3zVx/SRXw
 a7900gkN6JmyikcdGNabKFgd145x4b0LlPTCiBn6KrMT3NcgFVUXYE4ktORDda3l3X06RlQspOy
 S9wkUrFet2BvmVaBzXJnNAwO09So6Yu8cCc4em0yXi5gwPqxRV9EcONgEvrzcDoLpr06k17kWjG
 ZiL1YFILT8M9RwMRNx9VEABrtwzh4aKj6hv38HUr7Be6zUgA9n/PLvjrw/IC3ye9Z1qcQVhMxTC
 pQdN2f3VYJIEke+vk5nTz8wr59qC90mnlKlSpWmwM+6Ea/H0o6hd+MBUQiti7ZkNAPOzoyf8VEj
 KItZ7GnFiBLwv6QG/1kdU6
X-Received: by 2002:a05:6820:1504:b0:695:818c:e56a with SMTP id
 006d021491bc7-6965cab1292mr3966445eaf.27.1777474017162; 
 Wed, 29 Apr 2026 07:46:57 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:12 -0600
Subject: [PATCH v2 06/17] bsd-user: Add FreeBSD IPv6 ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-6-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8387; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gZmM7uu3K8cX/RwjkkOXNVmFwtWCH9uYOgns46xr4Cs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl8Vw5PyxgJvSlE6FBl/NGDYU1e9bpRKpkAN
 Pob4GqsEMiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfAAKCRBsHNEofbAR
 AIQAEADQvPzzIuxY/uUyPXswa0ijSNCi+vuI2tKafW2syPwA7qNbralxLnso69etA12luZFwDzA
 sM993+vzdMtzDhHeKis30RCEreq7asxkoTrrGD75TRVoEwR55mR+077HJADZIqr1WMgZKv1dPaq
 2NgDPgUbXG8l74vGfxJadPyXP97eJwti7kx49J4p8vwWfm7jZ7fYAITb3vOU0SpIeOAGPUR5M9A
 HfLG/eUjujWCGBHitPoiNJyf7CtV7ZXzMW92B7O7wfAihCHK4VXs/UGoJd7qK+EW4f8b971lERP
 5lqVeY19PKX7lr5bJJstqyBlExivmoMTPK6XUP6MjAMxJw8nPg1Wx01hJkx5iDdLJl4KmR+VKS1
 xRPO+0bGxGVlKO8ozLWN735XYUPiKbN2dNWC/xIjv3ZihehSkETOn8Mkb/oReTh0w36sh8x2V/i
 1t8Jo3S69WXmlYeFuw5PUiccwuT1owe0+7ZDY5kaRHRAmPBK+6u/N4OucBJch8s9828kET0X55P
 185n4RgO1TUXEGkIw8nxD2v1iYAtvgqnjxgJJjZK7ufTeJp4eCSYAAWT77FJ4WoBN6z87qKuh7z
 rMkrEolAOTsGtpqgTEzHDAmkm0DohtEjpT1DOO4Gowx8ZmUKK0hF3eatc5yism63EAYkq9f9k1t
 NOazMwUk6cjx7Sg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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


