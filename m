Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A9CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxB-0001HE-Ug; Fri, 15 May 2026 17:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxA-0001FG-BM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:16 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx8-0002uQ-4C
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:16 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso322586a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880013; x=1779484813;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=azuMvEPqxf03PBzIl3TO6hsWCvJlx+kQZvV9xsGRaOk=;
 b=SssQFvOuNffpI+KvurGk1sOcePAfy3bNA4yhiYSZdNlkuugYch4hERE2WlU5TrKPqQ
 kMC/Z7hkTZI/wL4jepIraIRqa6Xn7rJ5Ie+yWs4fhGVgbeqO6ptQYJKA0h2Uu97cAWFT
 UGpoS5CON9bpcvRMcwyNvdtcvX4TKPvSeAXowrCOGiw3QWHGQLqD8w6jdKd8Xr4xENtj
 JFpfXaRXkaY3CKT+xsdTuzF65LhuJwTDk3Euf9cn/OQ3eEWhAelAuJodfzZGFfqp6gJW
 uD6DfCJoARXZ5QudvjYLbj5hbx2S5j95Ao9EcSIgUwTE1KySusGdCtIetds62vSuL9GR
 r82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880013; x=1779484813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=azuMvEPqxf03PBzIl3TO6hsWCvJlx+kQZvV9xsGRaOk=;
 b=jz4jIBgK4u0UyaJvXLqZXkPIgYgN0IXcTFqJG52cnuqtCto43yEWjyBeDCFbAFK6Ie
 hbcHXuEphrkE+aKW5ii+XxdKhdODcaymO3O6CMf5Pt8Hrk8vXRFpp2TFjZLMYGVd9s9L
 su54mnTVvDXyA5Gwa1p+dx5/ECpgZO4tbal9t6lGF/siIyI2DOPYi/SJCTnFUQcseq2o
 E3NfFg7AXQXE7DxJqiPozyGZM/ITK4NklElc3YjkSNihtxPVtEZqCWxaMxQ8xQh0VmtX
 yZbrDUZ5axFju/jk15NQS8qYbBMOpCXtftbKJryotmHf9zc4z5QfGNKADGvVbDvFk44A
 sj7w==
X-Gm-Message-State: AOJu0YzrJoSbite1iSZUIVjKdfDyEDY4SMAlN5X3d3lS+EPd+xm0agB1
 ZHj14rf9HfJtJ/kNwcmNCTAHvapdFlOgvK8GT3MyL6WdJuhCmoaI9uHMKPS+EQdVLUI=
X-Gm-Gg: Acq92OGkYN1gSYcbrOjG/9IoB91H/+qFcOk6weTaF8ibWMD9cEQsWJclUQEFltVeM23
 Fr784CYQlDGv4DPCgXjQTT/Mp/WNhFwJe7dvqnG/ljmLo1G6eA4qU4AXz0Ts9b8lqTgWqJ/aRcf
 VwrtTr8Klai2z3m6cRMFtduMtYRHtNcOBFEQp641ZYaNd5F1bOXK9OdXS03578zo7/VHhjDpOed
 pAs4Yr52fm1lWYz/ygymO2T+zIZYOVJKP/OBsHc0jAF4KYbct0zRbdwths4JoZ9Fh4pP/iUOFbQ
 Pr+sWaKtCOLF7mEGykk0eHu4FyI/kyGbTQqD2K/rF6QnMe5KeMDsjKt3tSPPZeUhogUvBBQfbTw
 RyVPCqVemwXBiKVq7sUeDeU6VAr6ohBGt1kOnJJ67d2+i9kV/Pr2m/P7iEuEbIZhXdPELtGl+SH
 z0XNZ9aRi3Yg==
X-Received: by 2002:a05:6830:334b:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e568d053f0mr1082915a34.19.1778880012877; 
 Fri, 15 May 2026 14:20:12 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:11 -0600
Subject: [PATCH 12/66] bsd-user: Add do_bsd_setsockopt and socket option
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-12-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10846; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=LO3prUvkr6fVoeBG4al+7K5tjdPVDD+KIKT2DCcAJ78=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43iumBwy2fqkfuPggssjIcjstAcw2xrLrXQR
 5Pwh9rz01eJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 AMntEAC8J/Mctmw4StNg31OvSTH4HliJgLlK1kY/Aa2Sc07eBJZfWoYlXV0FIT8/X3OwMcIDrfR
 PgqqyLAqZ5kKKmS3AV+kgaBr/87dAuf3eUPupNAG0vYIYKFjm8+KuRcuhemD9uuZoHTMXilbCX5
 TCqMvBPC0BjGu8saqAvqm2szCRyoLjynkbiqjEoH3FwMl6CojOrPt1lmx/rQjExwZiNp5Bhfn3Y
 NTw4RH82S8nigu3OJK9QoZ8PUWQWVdbFexVqj0opIOE8aFTvodxr+Yy3kCdyjtZx/ndFsw4TcSo
 xSNfIZLSadLsPok0Jhm5+0p70oeOBXrFPl3qJu+4wScDSalIXTP/bsMlzSZYhKyoy6NgkU5cOiu
 nR/5rlZsCwO8EBzXiMUz3h/DK3/23WVujhagjVCt3PYqq8wx0f/rYD5Sh6o2EnR+b+Yc++ndcMF
 PPvt9Kmm96GJJSqDtZy0IVaUVv7vJcwXUX2SbjqLX2LO+T/FqjD1Hn5q3SvqVv9+geik5Wkcgi3
 aZ9TkeVbi6wd6bxAAXxG44pIzwaMbLTA8cj6g3srff16Peq/c4N1QYdc/Cm4IyqYcofIQqXf6jk
 +zdjBBVgQS9XGu4DnQ0RpJ1AZjfsjPRDVumleLZ3LdedCZ+ZecOSQwShZ0Oe7pZoDA6QKTmfJXv
 A37eoLGISCNDcGw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Add the setsockopt(2) implementation handling IPPROTO_TCP, IPPROTO_IP,
IPPROTO_IPV6, and SOL_SOCKET levels. Also add the TARGET_SO_* socket
option definitions and TARGET_SOL_SOCKET to syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-socket.h | 258 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index 279157dd05..c565170d09 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -138,5 +138,263 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
     return ret;
 }
 
+/* setsockopt(2) */
+static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, socklen_t optlen)
+{
+    abi_long ret;
+    int val;
+    struct ip_mreqn *ip_mreq;
+    void *p;
+
+    switch (level) {
+    case IPPROTO_TCP:
+        /* TCP options all take an 'int' value. */
+        if (optlen < sizeof(uint32_t)) {
+            return -TARGET_EINVAL;
+        }
+        if (get_user_u32(val, optval_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
+        break;
+
+    case IPPROTO_IP:
+        switch (optname) {
+        case IP_OPTIONS:
+            p = lock_user(VERIFY_READ, optval_addr, optlen, 0);
+            if (p == NULL) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname, p, optlen));
+            unlock_user(p, optval_addr, 0);
+            break;
+        case IP_HDRINCL:/* int; header is included with data */
+        case IP_TOS:    /* int; IP type of service and preced. */
+        case IP_TTL:    /* int; IP time to live */
+        case IP_RECVOPTS: /* bool; receive all IP opts w/dgram */
+        case IP_RECVRETOPTS: /* bool; receive IP opts for response */
+        case IP_RECVDSTADDR: /* bool; receive IP dst addr w/dgram */
+        case IP_MULTICAST_IF:/* u_char; set/get IP multicast i/f  */
+        case IP_MULTICAST_TTL:/* u_char; set/get IP multicast ttl */
+        case IP_MULTICAST_LOOP:/*u_char;set/get IP multicast loopback */
+        case IP_PORTRANGE: /* int; range to choose for unspec port */
+        case IP_RECVIF: /* bool; receive reception if w/dgram */
+        case IP_IPSEC_POLICY:   /* int; set/get security policy */
+        case IP_RECVTTL: /* bool; receive reception TTL w/dgram */
+            val = 0;
+            if (optlen >= sizeof(uint32_t)) {
+                if (get_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else if (optlen >= 1) {
+                if (get_user_u8(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname, &val,
+                        sizeof(val)));
+            break;
+
+        case IP_ADD_MEMBERSHIP: /*ip_mreq; add an IP group membership */
+        case IP_DROP_MEMBERSHIP:/*ip_mreq; drop an IP group membership*/
+            if (optlen < sizeof(struct target_ip_mreq) ||
+                    optlen > sizeof(struct target_ip_mreqn)) {
+                return -TARGET_EINVAL;
+            }
+            ip_mreq = (struct ip_mreqn *) alloca(optlen);
+            target_to_host_ip_mreq(ip_mreq, optval_addr, optlen);
+            ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq,
+                        optlen));
+            break;
+
+        default:
+            goto unimplemented;
+        }
+        break;
+
+    case IPPROTO_IPV6:
+        switch (optname) {
+        case IPV6_UNICAST_HOPS:     /* int; IP6 hops */
+        case IPV6_MULTICAST_IF:     /* u_int; set/get IP6 multicast i/f  */
+        case IPV6_MULTICAST_HOPS:   /* int; set/get IP6 multicast hops */
+        case IPV6_MULTICAST_LOOP:   /* u_int; set/get IP6 multicast loopback */
+        case IPV6_PORTRANGE:        /* int; range to choose for unspec port */
+        case IPV6_CHECKSUM:         /* int; checksum offset for raw socket */
+        case IPV6_V6ONLY:           /* bool; make AF_INET6 sockets v6 only */
+        case IPV6_RECVPKTINFO:      /* bool; recv if, dst addr */
+        case IPV6_RECVHOPLIMIT:     /* bool; recv hop limit */
+        case IPV6_RECVRTHDR:        /* bool; recv routing header */
+        case IPV6_RECVHOPOPTS:      /* bool; recv hop-by-hop option */
+        case IPV6_RECVDSTOPTS:      /* bool; recv dst option after rthdr */
+        case IPV6_USE_MIN_MTU:      /* bool; send packets at the minimum MTU */
+        case IPV6_RECVPATHMTU:      /* bool; notify an according MTU */
+        case IPV6_HOPLIMIT:         /* int; send hop limit */
+        case IPV6_RECVTCLASS:       /* bool; recv traffic class values */
+        case IPV6_AUTOFLOWLABEL:    /* bool; attach flowlabel automagically */
+        case IPV6_TCLASS:           /* int; send traffic class value */
+        case IPV6_DONTFRAG:         /* bool; disable IPv6 fragmentation */
+        case IPV6_PREFER_TEMPADDR:  /* int; prefer temporary addresses */
+        case IPV6_BINDANY:          /* bool: allow bind to any address */
+#ifdef IPV6_BINDMULTI
+        case IPV6_BINDMULTI:        /* bool; allow multibind to same addr/port*/
+#endif /* IPV6_BINDMULTI */
+#ifdef IPV6_RSS_LISTEN_BUCKET
+        case IPV6_RSS_LISTEN_BUCKET: /* int; set RSS listen bucket */
+#endif /* IPV6_RSS_LISTEN_BUCKET */
+#ifdef IPV6_FLOWID
+        case IPV6_FLOWID:           /* int; flowid of given socket */
+#endif /* IPV6_FLOWID */
+#ifdef IPV6_FLOWTYPE
+        case IPV6_FLOWTYPE:         /* int; flowtype of given socket */
+#endif /* IPV6_FLOWTYPE */
+#ifdef IPV6_RSSBUCKETID
+        case IPV6_RSSBUCKETID:      /* int; RSS bucket ID of given socket */
+#endif /* IPV6_RSSBUCKETID */
+            val = 0;
+            if (optlen >= sizeof(uint32_t)) {
+                if (get_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else if (optlen >= 1) {
+                if (get_user_u8(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname, &val,
+                        sizeof(val)));
+            break;
+
+        case IPV6_JOIN_GROUP:   /* ipv6_mreq; join a group membership */
+        case IPV6_LEAVE_GROUP:  /* ipv6_mreq; leave a group membership */
+        case ICMP6_FILTER:      /* icmp6_filter; icmp6 filter */
+        case IPV6_IPSEC_POLICY: /* struct; get/set security policy */
+        case IPV6_FW_ADD:       /* add a firewall rule to chain */
+        case IPV6_FW_DEL:       /* delete a firewall rule from chain */
+        case IPV6_FW_FLUSH:     /* flush firewall rule chain */
+        case IPV6_FW_ZERO:      /* clear single/all firewall counter(s) */
+        case IPV6_FW_GET:       /* get entire firewall rule chain */
+        case IPV6_RTHDRDSTOPTS: /* ip6_dest; send dst option before rthdr */
+        case IPV6_PATHMTU:      /* mtuinfo; get the current path MTU */
+        case IPV6_PKTINFO:      /* in6_pktinfo; send if, src addr */
+        case IPV6_NEXTHOP:      /* sockaddr; next hop addr */
+        case IPV6_HOPOPTS:      /* ip6_hbh; send hop-by-hop option */
+        case IPV6_DSTOPTS:      /* ip6_dest; send dst option befor rthdr */
+        case IPV6_RTHDR:        /* ip6_rthdr; send routing header */
+        case IPV6_MSFILTER:     /* struct __msfilterreq; */
+        default:
+            goto unimplemented;
+        }
+        break;
+
+    case TARGET_SOL_SOCKET:
+        switch (optname) {
+        /* Options with 'int' argument.  */
+        case TARGET_SO_DEBUG:
+            optname = SO_DEBUG;
+            break;
+
+        case TARGET_SO_REUSEADDR:
+            optname = SO_REUSEADDR;
+            break;
+
+        case TARGET_SO_REUSEPORT:
+            optname = SO_REUSEPORT;
+            break;
+
+        case TARGET_SO_KEEPALIVE:
+            optname = SO_KEEPALIVE;
+            break;
+
+        case TARGET_SO_DONTROUTE:
+            optname = SO_DONTROUTE;
+            break;
+
+        case TARGET_SO_LINGER:
+            optname = SO_LINGER;
+            break;
+
+        case TARGET_SO_BROADCAST:
+            optname = SO_BROADCAST;
+            break;
+
+        case TARGET_SO_OOBINLINE:
+            optname = SO_OOBINLINE;
+            break;
+
+        case TARGET_SO_SNDBUF:
+            optname = SO_SNDBUF;
+            break;
+
+        case TARGET_SO_RCVBUF:
+            optname = SO_RCVBUF;
+            break;
+
+        case TARGET_SO_SNDLOWAT:
+            optname = SO_RCVLOWAT;
+            break;
+
+        case TARGET_SO_RCVLOWAT:
+            optname = SO_RCVLOWAT;
+            break;
+
+        case TARGET_SO_SNDTIMEO:
+            optname = SO_SNDTIMEO;
+            break;
+
+        case TARGET_SO_RCVTIMEO:
+            optname = SO_RCVTIMEO;
+            break;
+
+        case TARGET_SO_ACCEPTFILTER:
+            goto unimplemented;
+
+        case TARGET_SO_NOSIGPIPE:
+            optname = SO_NOSIGPIPE;
+            break;
+
+        case TARGET_SO_TIMESTAMP:
+            optname = SO_TIMESTAMP;
+            break;
+
+        case TARGET_SO_BINTIME:
+            optname = SO_BINTIME;
+            break;
+
+        case TARGET_SO_ERROR:
+            optname = SO_ERROR;
+            break;
+
+        case TARGET_SO_SETFIB:
+            optname = SO_SETFIB;
+            break;
+
+#ifdef SO_USER_COOKIE
+        case TARGET_SO_USER_COOKIE:
+            optname = SO_USER_COOKIE;
+            break;
+#endif
+        default:
+            goto unimplemented;
+        }
+        if (optlen < sizeof(uint32_t)) {
+            return -TARGET_EINVAL;
+        }
+        if (get_user_u32(val, optval_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val,
+                    sizeof(val)));
+        break;
+    default:
+unimplemented:
+    gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+        level, optname);
+    ret = -TARGET_ENOPROTOOPT;
+    }
+
+    return ret;
+}
+
 
 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */

-- 
2.52.0


