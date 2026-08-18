Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgz-0002AE-AM; Tue, 18 Aug 2026 19:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgx-00029m-0p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:03 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgu-0005Fs-Id
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:02 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a45b3f0becso381899b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097479; x=1787702279;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P05gKFAhnhtv6wMGKTIwVZmLdqAW4DZ8XvSW9UBujCU=;
 b=FONM9E610v7C68Ex9ejfFJKrBtbLRMqmbnwLaaZr6WW1a9StBJaIIGcMZxUQepTDNi
 fsl6//NqEhlIVMmr+M1a4LDfxR1T4asnS8YwSkBzOOwvlCaHosuNwkZ++ewG3+b/BqYq
 aNP2zDYYKfXeLL31At5JLkLdPplkrvJMsZIwX7qzDTfBWNx+HPeWHUEtCAK46m2S6T10
 0URO4KlJ1xzPhFA/HMs7RkK2zoGF1kqL+doU9x5oj31BhF+rm0ZHnoKgUWjsKXcScFp5
 oovv98utRZ4I4EkYq+7B0DLpaeMLo/bFO0upf/QLzxlFM2r/5hJbRc4J3n6X8h/G2VUI
 4rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097479; x=1787702279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P05gKFAhnhtv6wMGKTIwVZmLdqAW4DZ8XvSW9UBujCU=;
 b=LiXC8LfzBL5JzosdWfxhpRfvEh/wgRsPo4gV8pK8al6k5/jn86F5W693889kkGCTOz
 /6msMuxc+nMp9PmirpLFuwMXcz/zxwVEIi2vlx8tCoX5Rieh+xIVghXt1Xox/gTREBYo
 5Z1LJA+3Vnv2oPLXpl87C9IeXuO2i44fiDoE9bPPbsXjIg4YHA0ZjQPogWQ2jfTd/Vmy
 4FXFcZiVZKRtAV2XtDoKZqAMuxkBw950ENp2K0EM1J6mZZtIrqca8ooNuEwHup8+Hv2I
 CaqN/2Yi4+f16Eg+6ArdA5CoiZk96Tig0XWRhOpGmLsX4ULNuFDgjNufg7WyYjiYkTgD
 gyZA==
X-Gm-Message-State: AOJu0YwpqOpI2cv6jWVqOQrJfOomWYLCNgm99+SQ57yPxl7qqf3F2/zZ
 dy3CdsXAyPbJIA/ADliJ+JI3XKPiJ6Gts2VuNc1OpXPwg+3R/R85QctiVgat/PeS/9c=
X-Gm-Gg: AR+sD13wlOS2ev94yjPQcEihYiFyNCbi/J3ue2l3Mu71FPdaSbs0NBGuhV70BenBreR
 yINITdbF3YvvHFu0g8wezXH5+FhtMVpZtikvzB7q9pZC8lxiFQULeQYflxlykVuS9kRjihrY1zM
 ZY5mQlgjPGbAlAhFqsqunM7C4W6a+jNp5x+6JAhYlIuZryW64GmvHeEKf2V4oOMw4vweOUGdA5r
 0veV/p0hl1PwbPjg8kQPsBbohN6zpt5NNSq9iJAioNN3M0c0gjf+fPBRNcbm2hPxlA+i58MMiA+
 xVRqCrKjlWKMPxlq2TBeRil/a18n8EaQMVj7HJUrgfyZ4kERaFRcBvVVDRXKdxW3x/93PWfjaqy
 5NcwmucLF4/fj3cqzomLjeJYx/bmwjr6MP/s0f66cj+s6bxDUgOa+aqfZzTUuSflPbQNserViMi
 7KjHhIusPUkYa7IfkOPHzMHS8yzQgmAouZwRyMcqenKa3AMMwwMERdpU2CVA==
X-Received: by 2002:a05:6808:bc5:b0:4a3:3108:866a with SMTP id
 5614622812f47-4b2bcba1303mr342862b6e.17.1787097479208; 
 Tue, 18 Aug 2026 16:57:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:09 -0600
Subject: [PATCH v4 16/40] bsd-user: Commit the generated os-sockopt.h files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-16-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20509; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=mhEZGt3LGJuLt7Cq3uvWkaPE0b5klyv5X3fj+jZ4BHM=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE48p33kCfcV9dgMDSGP4tYF+tucXLkhmlb+
 +ltWqpQ8vGJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxOBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBg9BAAuex/885Bj57gaaU+UhF2c8fvjh+wUEe
 IC3yN1KGRF9YtYgTwKe75PLJ+LNlUoV/yZntIQsVIviB5L9QLXP9IN5kmRPoJDnm4dXg4mNFAQf
 Kbf0BVJrPLy3swm/I4xjpH0YurnvcsGLJavNcQKdeJAYZRlHz/Y3lgJ5adyMtP/O78okNF6qU4/
 iwX0UZAiNloiKjaVsImkvArgnfmkY4psW5bpVRH/bta4HGjcEWSbaDPCoCtfZuWTtlxFcMXFRfc
 F7LXUONwvGwQfnsJlHTgAXeubp6yq9KGc1g0UKmOuKY+f4X9OHNq4/78qc+Be7BOwG9KkBdKo8g
 9LkhS4tDEtULqXjHYpXh0W0OZTeljpuQq4YcQQzYA0HJCpPMLuA8BVJXKPTADp/oQveC1NYuGLP
 qTjQvIB0mANtiNFihp1EKnwvHe6SWxBGesfF2AeaT4ISnJ0TpJJAUZ+ec4o9UFg+6KfkWeBjzsA
 7Sw0uCpBVvvDq3WVhlVbRZTQznwa2DS1/9hFVIJkCLchy53JzNawj96cxI3IxSKxFCCTBgmnUyX
 6XBUv/Uy/4ClJRLxasXUUkFsX02+ET2R6pRqM5FUImCpEC+gtSMvtudNCUVdwTgSWbGgYW/KXV5
 ELHyejdHrxmDmrvbj2WQ/cXNxDTFn7uNPWHD89oo9YJ45jV371m8=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

Generate the table of all socket options in FreeBSD. This only works
against the latest FreeBSD, so we have to commit this table for
now. Once the supporting machinery is merged to the stable branches, we
can move to generating it as a build artifact.

This uses BSD-2-Clause because it's derived from BSD-2-Clause
material. It's likely in the public domain, though, since it's a
generated file.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-sockopt.h | 316 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 316 insertions(+)

diff --git a/bsd-user/freebsd/os-sockopt.h b/bsd-user/freebsd/os-sockopt.h
new file mode 100644
index 0000000000..2f984cf8e3
--- /dev/null
+++ b/bsd-user/freebsd/os-sockopt.h
@@ -0,0 +1,316 @@
+/* Auto-generated by gen_sockopt.sh -- do not edit */
+/* SPDX-License-Identifier: BSD-2-Clause */
+#pragma once
+
+#define SOCK_LEVEL_NONE -1234
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <netinet/udp.h>
+
+enum sockopt_type {
+        SOCKOPT_TYPE_NONE = 0,
+        SOCKOPT_TYPE___MSFILTERREQ,
+        SOCKOPT_TYPE_ACCEPT_FILTER_ARG,
+        SOCKOPT_TYPE_BOOL,
+        SOCKOPT_TYPE_DUMP,
+        SOCKOPT_TYPE_ICMP6_FILTER,
+        SOCKOPT_TYPE_IN6_PKTINFO,
+        SOCKOPT_TYPE_INT,
+        SOCKOPT_TYPE_IP_MREQ_SOURCE,
+        SOCKOPT_TYPE_IP_MREQ,
+        SOCKOPT_TYPE_IP_OPTS,
+        SOCKOPT_TYPE_IP6_DEST,
+        SOCKOPT_TYPE_IP6_HBH,
+        SOCKOPT_TYPE_IP6_RTHDR,
+        SOCKOPT_TYPE_IPV6_MREQ,
+        SOCKOPT_TYPE_LINGER,
+        SOCKOPT_TYPE_SADB_X_POLICY,
+        SOCKOPT_TYPE_SOCKADDR,
+        SOCKOPT_TYPE_SPLICE,
+        SOCKOPT_TYPE_TCP_FASTOPEN,
+        SOCKOPT_TYPE_TCP_FUNCTION_SET,
+        SOCKOPT_TYPE_TCP_INFO,
+        SOCKOPT_TYPE_TCP_PERF_INFO,
+        SOCKOPT_TYPE_TIMEVAL,
+        SOCKOPT_TYPE_U_CHAR,
+        SOCKOPT_TYPE_U_INT,
+        SOCKOPT_TYPE_UINT32_T,
+        SOCKOPT_TYPE_UINT64_T,
+};
+
+struct sockopt_entry {
+        int level;
+        int optname;
+        enum sockopt_type type[5];
+};
+static struct sockopt_entry sol_socket[] = {
+        { SOL_SOCKET  , SO_DEBUG            , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_ACCEPTCONN       , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_REUSEADDR        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_KEEPALIVE        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_DONTROUTE        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_BROADCAST        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_USELOOPBACK      , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_LINGER           , { SOCKOPT_TYPE_LINGER, } },
+        { SOL_SOCKET  , SO_OOBINLINE        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_REUSEPORT        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_TIMESTAMP        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_NOSIGPIPE        , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_ACCEPTFILTER     , { SOCKOPT_TYPE_ACCEPT_FILTER_ARG, } },
+        { SOL_SOCKET  , SO_BINTIME          , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_NO_OFFLOAD       , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_NO_DDP           , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_REUSEPORT_LB     , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_RERROR           , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_SNDBUF           , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_RCVBUF           , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_SNDLOWAT         , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_RCVLOWAT         , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_SNDTIMEO         , { SOCKOPT_TYPE_TIMEVAL, } },
+        { SOL_SOCKET  , SO_RCVTIMEO         , { SOCKOPT_TYPE_TIMEVAL, } },
+        { SOL_SOCKET  , SO_ERROR            , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_TYPE             , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_LISTENQLIMIT     , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_LISTENQLEN       , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_LISTENINCQLEN    , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_FIB              , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_USER_COOKIE      , { SOCKOPT_TYPE_UINT32_T, } },
+        { SOL_SOCKET  , SO_PROTOCOL         , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_TS_CLOCK         , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_MAX_PACING_RATE  , { SOCKOPT_TYPE_UINT32_T, } },
+        { SOL_SOCKET  , SO_DOMAIN           , { SOCKOPT_TYPE_INT, } },
+        { SOL_SOCKET  , SO_SPLICE           , { SOCKOPT_TYPE_SPLICE, } },
+        { SOL_SOCKET  , NET_RT_DUMP         , { SOCKOPT_TYPE_DUMP, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_entry ipproto_ip[] = {
+        { IPPROTO_IP  , IP_HDRINCL          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_TOS              , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_TTL              , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RECVOPTS         , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_RECVRETOPTS      , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_RECVDSTADDR      , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_RETOPTS          , { SOCKOPT_TYPE_IP_OPTS, } },
+        { IPPROTO_IP  , IP_MULTICAST_TTL    , { SOCKOPT_TYPE_U_INT, SOCKOPT_TYPE_U_CHAR, } },
+        { IPPROTO_IP  , IP_MULTICAST_LOOP   , { SOCKOPT_TYPE_U_INT, SOCKOPT_TYPE_U_CHAR, } },
+        { IPPROTO_IP  , IP_ADD_MEMBERSHIP   , { SOCKOPT_TYPE_IP_MREQ, } },
+        { IPPROTO_IP  , IP_DROP_MEMBERSHIP  , { SOCKOPT_TYPE_IP_MREQ, } },
+        { IPPROTO_IP  , IP_MULTICAST_VIF    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RSVP_ON          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RSVP_OFF         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RSVP_VIF_ON      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RSVP_VIF_OFF     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_PORTRANGE        , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RECVIF           , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_IPSEC_POLICY     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_ONESBCAST        , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_BINDANY          , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_ORIGDSTADDR      , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_RECVTTL          , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_MINTTL           , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_DONTFRAG         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RECVTOS          , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_ADD_SOURCE_MEMBERSHIP, { SOCKOPT_TYPE_IP_MREQ_SOURCE, } },
+        { IPPROTO_IP  , IP_DROP_SOURCE_MEMBERSHIP, { SOCKOPT_TYPE_IP_MREQ_SOURCE, } },
+        { IPPROTO_IP  , IP_BLOCK_SOURCE     , { SOCKOPT_TYPE_IP_MREQ_SOURCE, } },
+        { IPPROTO_IP  , IP_UNBLOCK_SOURCE   , { SOCKOPT_TYPE_IP_MREQ_SOURCE, } },
+        { IPPROTO_IP  , IP_MSFILTER         , { SOCKOPT_TYPE___MSFILTERREQ, } },
+        { IPPROTO_IP  , IP_VLAN_PCP         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_FLOWID           , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_FLOWTYPE         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RSSBUCKETID      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IP  , IP_RECVFLOWID       , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IP  , IP_RECVRSSBUCKETID  , { SOCKOPT_TYPE_BOOL, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_entry ipproto_ipv6[] = {
+        { IPPROTO_IPV6, IPV6_UNICAST_HOPS   , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_MULTICAST_IF   , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_IPV6, IPV6_MULTICAST_HOPS , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_IPV6, IPV6_MULTICAST_LOOP , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_IPV6, IPV6_JOIN_GROUP     , { SOCKOPT_TYPE_IPV6_MREQ, } },
+        { IPPROTO_IPV6, IPV6_LEAVE_GROUP    , { SOCKOPT_TYPE_IPV6_MREQ, } },
+        { IPPROTO_IPV6, IPV6_PORTRANGE      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, ICMP6_FILTER        , { SOCKOPT_TYPE_ICMP6_FILTER, } },
+        { IPPROTO_IPV6, IPV6_CHECKSUM       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_V6ONLY         , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_IPSEC_POLICY   , { SOCKOPT_TYPE_SADB_X_POLICY, } },
+        { IPPROTO_IPV6, IPV6_RTHDRDSTOPTS   , { SOCKOPT_TYPE_IP6_DEST, } },
+        { IPPROTO_IPV6, IPV6_RECVPKTINFO    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVHOPLIMIT   , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVRTHDR      , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVHOPOPTS    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVDSTOPTS    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_USE_MIN_MTU    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVPATHMTU    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_PKTINFO        , { SOCKOPT_TYPE_IN6_PKTINFO, } },
+        { IPPROTO_IPV6, IPV6_HOPLIMIT       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_NEXTHOP        , { SOCKOPT_TYPE_SOCKADDR, } },
+        { IPPROTO_IPV6, IPV6_HOPOPTS        , { SOCKOPT_TYPE_IP6_HBH, } },
+        { IPPROTO_IPV6, IPV6_DSTOPTS        , { SOCKOPT_TYPE_IP6_DEST, } },
+        { IPPROTO_IPV6, IPV6_RTHDR          , { SOCKOPT_TYPE_IP6_RTHDR, } },
+        { IPPROTO_IPV6, IPV6_RECVTCLASS     , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_AUTOFLOWLABEL  , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_TCLASS         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_DONTFRAG       , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_BINDANY        , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_FLOWID         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_FLOWTYPE       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_RSSBUCKETID    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_IPV6, IPV6_RECVFLOWID     , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_RECVRSSBUCKETID, { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_ORIGDSTADDR    , { SOCKOPT_TYPE_BOOL, } },
+        { IPPROTO_IPV6, IPV6_VLAN_PCP       , { SOCKOPT_TYPE_INT, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_entry ipproto_tcp[] = {
+        { IPPROTO_TCP , TCP_NODELAY         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_MAXSEG          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_NOPUSH          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_NOOPT           , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_MD5SIG          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_INFO            , { SOCKOPT_TYPE_TCP_INFO, } },
+        { IPPROTO_TCP , TCP_LOG             , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_TXTLS_MODE      , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_RXTLS_MODE      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_IWND_NB         , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_IWND_NSEG       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_LOGID_CNT       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_USER_LOG        , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_MAXUNACKTIME    , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_IDLE_REDUCE     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_REMOTE_UDP_ENCAPS_PORT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_DELACK          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_FIN_IS_RST      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_LOG_LIMIT       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_SHARED_CWND_ALLOWED, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_PROC_ACCOUNTING , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_USE_CMP_ACKS    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_PERF_INFO       , { SOCKOPT_TYPE_TCP_PERF_INFO, } },
+        { IPPROTO_TCP , TCP_KEEPINIT        , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_KEEPIDLE        , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_KEEPINTVL       , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_KEEPCNT         , { SOCKOPT_TYPE_U_INT, } },
+        { IPPROTO_TCP , TCP_FASTOPEN        , { SOCKOPT_TYPE_TCP_FASTOPEN, } },
+        { IPPROTO_TCP , TCP_FUNCTION_BLK    , { SOCKOPT_TYPE_TCP_FUNCTION_SET, } },
+        { IPPROTO_TCP , TCP_FUNCTION_ALIAS  , { SOCKOPT_TYPE_TCP_FUNCTION_SET, } },
+        { IPPROTO_TCP , TCP_REUSPORT_LB_NUMA, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_MBUF_QUEUE , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_TLP_REDUCE , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_MAX_SEG, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_ALWAYS, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PRR_SENDALOT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_MIN_TO     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_EARLY_SEG  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_REORD_THRESH, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_REORD_FADE , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_TLP_THRESH , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PKT_DELAY  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_IWINTSO     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_STARTUP_PG  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_DRAIN_PG    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PROBE_RTT_INT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_STARTUP_LOSS_EXIT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_TSLIMITS    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_OH     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_USEDEL_RATE , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_MIN_RTO     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_MAX_RTO     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_ALGORITHM   , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_PER_SEC, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_DEL_TAR, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_SEG_MAX, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_SEG_MIN, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PACE_CROSS  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_TLP_USE    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_TMR_PACE_OH , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_DO_DETECTION, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_RACK_RTT_USE, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_RETRAN_WTSO , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_DATA_AFTER_CLOSE, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PROBE_RTT_GAIN, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_PROBE_RTT_LEN, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_SEND_IWND_IN_TSO, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_USE_RACK_RR , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_HDWR_PACE   , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_UTTER_MAX_TSO, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_EXTRA_STATE , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_FLOOR_MIN_TSO, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_MIN_TOPACEOUT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_TSTMP_RAISES, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_POLICER_DETECT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_BBR_RACK_INIT_RATE, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_RR_CONF    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_GP_INCREASE_CA, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_GP_INCREASE_SS, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_GP_INCREASE_REC, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_FORCE_MSEG , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_RATE_CA, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_RATE_SS, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_RATE_REC, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_NO_PRR          , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_NONRXT_CFG_RATE, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_SHARED_CWND_ENABLE, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_TIMELY_DYN_ADJ  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_NO_PUSH_AT_MAX, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_TO_FILL, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_SHARED_CWND_TIME_LIMIT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PROFILE    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_HDWR_RATE_CAP   , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_PACING_RATE_CAP , { SOCKOPT_TYPE_UINT64_T, } },
+        { IPPROTO_TCP , TCP_HDWR_UP_ONLY    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_ABC_VAL    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_REC_ABC_VAL     , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_MEASURE_CNT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_DEFER_OPTIONS   , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACING_BETA, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACING_BETA_ECN, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_TIMER_SLOP , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_DSACK_OPT  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_ENABLE_HYSTART, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_SET_RXT_OPTIONS, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_HI_BETA    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_SPLIT_LIMIT, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACING_DIVISOR, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_PACE_MIN_SEG, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_RACK_DGP_IN_REC , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_PACING_DND      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_SS_EEXIT        , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_DGP_UPPER_BOUNDS, { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_NO_TIMELY       , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_HONOR_HPTS_MIN  , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_REC_IS_DYN      , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_SIDECHAN_DIS    , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_FILLCW_RATE_CAP , { SOCKOPT_TYPE_INT, } },
+        { IPPROTO_TCP , TCP_GP_USE_LTBW     , { SOCKOPT_TYPE_INT, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_entry ipproto_udp[] = {
+        { IPPROTO_UDP , UDP_ENCAP           , { SOCKOPT_TYPE_INT, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_entry sol_local[] = {
+        { SOL_LOCAL   , LOCAL_CREDS         , { SOCKOPT_TYPE_INT, } },
+        { SOL_LOCAL   , LOCAL_CREDS_PERSISTENT, { SOCKOPT_TYPE_INT, } },
+        { SOCK_LEVEL_NONE }
+};
+
+static struct sockopt_cache {
+        int level;
+        struct sockopt_entry *entry;
+} so_cache[] = {
+        { SOL_SOCKET,   sol_socket },
+        { IPPROTO_IP,   ipproto_ip },
+        { IPPROTO_IPV6, ipproto_ipv6 },
+        { IPPROTO_TCP,  ipproto_tcp },
+        { IPPROTO_UDP,  ipproto_udp },
+        { SOL_LOCAL,    sol_local },
+};

-- 
2.55.0


