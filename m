Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47233CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsI-0007q2-JO; Sat, 02 May 2026 13:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsF-0007od-PD
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:27 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsD-00073b-TC
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:27 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d55b97f358so2109097a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741884; x=1778346684;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z6ybzUtaYWgMT9AvbGFtNBzZwiHN7QLjVm2tF+0PmRU=;
 b=yfyNOCgRIcvBVcIVDhxFafurb6IGWl4EXivYRT+mJe65Coc3CRQGmlFDe4wLVWy+cq
 noK6K5AiI76jDNOPfOtCiqmBX9zPuWzRm2h+p9hd+ZIKS9wf7fu3ipGSrqkjX4BwAmkG
 pvjUx2xMraS0y3HGq2nyXCCRu4mLRAq56fshGycjsAtBIARrKdhA0Q51fdY4xdO0AnLJ
 siZ/xH25qfLzY9F2g7tuRZRhJdW1vbqxw5Dv5KuVPHH+Q6kraibKEF+p4hymOiu+RMqe
 nlXdKHPiknCnm3NoOZ3HcTW7PCOjJE0OG+dqK01NOkTOrS78/cy449n0tg2ucC+5nchA
 9PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741884; x=1778346684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z6ybzUtaYWgMT9AvbGFtNBzZwiHN7QLjVm2tF+0PmRU=;
 b=ZBzSr5Ktj2DCKMqZw7gEKqThTelPKde0j0W+6gRZM+KKKtwPN0M6YIsbxPg/gRtVMU
 Y+fTxP18cgKT5LqlIeJ2W9YDAg18oXGlafKhJkBpIp1LePbctGnKC9fatmkVkkGIlJ+y
 iDvpJxjhLiBTMq49ptwbDuzEWPSJjYiZCRAsFHFVIz4kJQqvORC7VVI2K5eolzQdDD0d
 tOlChJIQQDTowD0HAEdH08kqajICNGqKKL5Ed9wuuO4CURZDeK36GGlNGTQ5DmWXkFu+
 3Ns/hje38Q7XaiFWggFomRFDtTpX359HKnZvRTzz4wZeXWhPVarShkm9QZtyc8Qd2bzf
 v4Dg==
X-Gm-Message-State: AOJu0Yyi2ysRRsKw06Hwb8a60uev5BZiP+FkhNLzauV7RsRd8D9ybNnx
 QH3cDUlr7awQf+7t38El+S7CXZNJlJIpdj7rf2HJe11ToIGVx/uM6Iq+xDedkLwG4KcOso6G/r/
 4Bv6txO4=
X-Gm-Gg: AeBDietn3JrAmIzAEhcVznChY2HzKnaHYxIPFdBER5XwOmf8Qbzuk8AJnzXerWFaQu3
 BofnFPzeHbAWuFLiAyaJpzRhEYzCFlQd3oeRryb4mpkGvNRNe9AOOzQJYyK3HJcxliKp8D8n4PS
 ndUbBSu2senkF95IZO0Nozis1u8iAykuYR39YZnmO21Y7ooWGMZN73Z90YYVa6m+Ho9qYhJuaEc
 7Dd9t9HUHbFdCoYUdixICYebLdDYtRILDUtVbt05Sm8e3dnj5pWlpk07aWsvYYWX4C9FuDTm31B
 rlPw3f3SawT2SIMakiJ2Vj88MQGTXl5dldqVj1W3vni/E83+I1/ydgwoXutXry9PWB78ICQdsCI
 kNB6XvRi4FPolp09gsozvaNms5rAx18tFhAn8XnxUJW+nfLePNIp8XKfKxNZ2w0eQ7jar6uY81d
 3GNMTev1O/C+KT2rbx+7dm2fqSCQVMunM=
X-Received: by 2002:a05:6830:67c7:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7dee137ffcbmr2502053a34.14.1777741884295; 
 Sat, 02 May 2026 10:11:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:28 -0600
Subject: [PATCH v3 07/19] bsd-user: Add FreeBSD IPv6 ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-7-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8944; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=d/ijr+9hjS5rLAbqQ7xaWCdG7PSslSj/yLRuf+D9UJI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/PfEg5KXbtBUN5o3cTuI30iqi4PuodHo5K5
 WGqBJQB3H+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 AI5XD/9Y2jUW9ALdIs8K90wD22MQU6IjbJb2wVlC8Mm8frqgwQFceBQqmqHUl7lQq6w56MyA2dK
 FQrj610gZ/oGexDkU5nYnVZFbq3dxuIu0/7NX4tFSXr7TsjHhvE4VW1KJ1olkRQo/N24M18DJ6n
 sAhuneoo2muVIeaYhoNedVkH2S3ATxFg5PQnl8i4l3Iitai8ecURpZuYjxwcIiFaDNfY3zHf0a+
 +DJndJKvF/KucaPqf09d48phYr12S6CSDfiuiJH/Q9KZ9B9Fy3SCfbrbq4NJBS9t7B7pmqsrs2V
 DCLAQbz4OP0hT3ZTMLcYtC/8c6o6B3DSTJ5sA8PdxiLWHOhsLj4ZskCnmgOJN4VAWkssiM26eBU
 WWgEObsP2v0TClBKzuv7ZAQSl4IirWfSrv6A3uOGaZz0mi8deWAQdT4+i2UP+/qmJWhXaoVJd5x
 wL3Fk1u0iOwvzU4B0+D/c9VXYy4Xvc2kn80Va4gZq5KEMivqzvrgNA/TdN+sgaIu+M+vQw3CaG9
 /a6BgWi+AyOZJ/+oiey7EisOsR9prm3s7ldENOaHeCc5MeXfiI/CnDSRB5k8CtP9iUzFUp07WoZ
 LgRppSlIRAbpcOVihoPKZyravUx1C9ahpwJ24Et3cmRufkmmbjGsOYYNuhRYKMDiBd8HmOh2CCm
 MN9mI0KaPIe/wag==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-in6_var.h | 226 ++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-in6_var.h b/bsd-user/freebsd/os-ioctl-in6_var.h
new file mode 100644
index 0000000000..82f0514c7b
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-in6_var.h
@@ -0,0 +1,226 @@
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
+#include "os-ioctl-sockio.h"
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
+struct target_in6_ifreq {
+        char ifr_name[TARGET_IFNAMSIZ];
+        union {
+                struct  target_sockaddr_in6 ifru_addr;
+                struct  target_sockaddr_in6 ifru_dstaddr;
+                abi_int     ifru_flags;
+                abi_int     ifru_flags6;
+                abi_int     ifru_metric;
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
+    char ifname[TARGET_IFNAMSIZ];
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
+#define TARGET_SIOCSIFPHYADDR_IN6 TARGET_IOW('i', 70, \
+                                             struct target_in6_aliasreq)
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
+#define TARGET_SIOCGIFALIFETIME_IN6 TARGET_IOWR('i', 81, \
+                                                struct target_in6_ifreq)
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
+#define TARGET_SIOCSIFPREFIX_IN6 TARGET_IOW('i', 100, \
+                                            struct target_in6_prefixreq)
+#define TARGET_SIOCGIFPREFIX_IN6 TARGET_IOWR('i', 101, \
+                                             struct target_in6_prefixreq)
+#define TARGET_SIOCDIFPREFIX_IN6 TARGET_IOW('i', 102, \
+                                            struct target_in6_prefixreq)
+#define TARGET_SIOCAIFPREFIX_IN6 TARGET_IOW('i', 103, \
+                                            struct target_in6_rrenumreq)
+#define TARGET_SIOCCIFPREFIX_IN6 TARGET_IOW('i', 104, \
+                                            struct target_in6_rrenumreq)
+#define TARGET_SIOCSGIFPREFIX_IN6 TARGET_IOW('i', 105, \
+                                             struct target_in6_rrenumreq)
+
+#define TARGET_SIOCGETSGCNT_IN6 TARGET_IOWR('u', 106, \
+                                            struct target_sioc_sg_req6)
+#define TARGET_SIOCGETMIFCNT_IN6 TARGET_IOWR('u', 107, \
+                                             struct target_sioc_mif_req6)
+
+#define TARGET_SIOCAADDRCTL_POLICY TARGET_IOW('u', 108, \
+                                              struct target_in6_addrpolicy)
+#define TARGET_SIOCDADDRCTL_POLICY TARGET_IOW('u', 109, \
+                                              struct target_in6_addrpolicy)
+#endif
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H */

-- 
2.52.0


