Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8984FCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hA-0002z7-5t; Sun, 21 Jun 2026 00:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h4-0002y2-8l
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:02 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h1-0005AH-NM
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:02 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69e8aa31e9fso1620642eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015718; x=1782620518;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O2uW+td9IO/G7jmrt/6okiq1Qth2Hfkxcn/cPw1X3vU=;
 b=XAGr+NWKBcv8VGsHsztpSmUDaCTNBPRfbcvnm+7tuFLsXLn9ICh6nIdZrKf9Sf7dyf
 k1nt8WA+0uLISlxXZv77AeT3Kv5uMfRdkhMY3qKTReRLBml8qE62LPcOFNHFhiVl5ePt
 bkgIPWW5b7brj+nPo/RoUPqiuw/3dK9OLld86TJiKqiycrql2fGo+qLUdfQ4qGWceTao
 Q942cbt7jsf2DtqredrI2M67pgOMFbptoEoVFjwLbel0tHh8FqZx5j2n+dpRTGhvRRuz
 UI15EfrryyAypHWlZPWr6YSlb5PcdiTcKxMc7244+U6W+RDqKcTK9gFezqTaDHY9YIgl
 tlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015718; x=1782620518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O2uW+td9IO/G7jmrt/6okiq1Qth2Hfkxcn/cPw1X3vU=;
 b=SJm13zm4qDWDjqf3Mz4ddIEczFoR4cd2nOmQ26AiBzoiIyI2Qc3RUOyRYXwV7X4Q3z
 mASd15PXPim6jjCZXsAU+GCqUNzG1O/ykKAgpMK59TqshR2wT+HFVFfnFb+P/jxdNzEg
 RLdG6uYKqfuR6vW6rXmWltj/V30n4yWgP1ZvT9k46abbesIffPgK3AbyT007TWg8VjyX
 i61eERRflQDXsDyjfhLcMsPbBImKD+AbqqBQee3J1X5j3d/nywuppt5yZwk1c6m+sapd
 5YmEReoLOFIIFtKERWEYWcwuloNxP568J6RT+ES7tilfCpq6tdw8O/x2Dynb7VQFR6pm
 8FfQ==
X-Gm-Message-State: AOJu0YzNxhA35Sv7/dPzNWG1T3lP1pJz0IysAl6Cv6l8QdijNLRLf3ko
 dYRrXCESuZ5YH4S0P8AV/kwApvXfCH54n1XpzOMf2qu4SSg/dPLfO4Axp/3QL6kemW0=
X-Gm-Gg: AfdE7cm+nqHT8zP6+6oxp0yuAzDfM449L17js5aRg1yn/0WbB8ERCgn7Hi49tBcHVEm
 c26CI/EY5Q+3DjKnE0KUlEu9mpla4WbY7SJMlFW9IqTUW+IAf51TSamIIA+3Cmsv/QRf/j3Jiwe
 knPjLpRKulAUqd4AhZzAGTjFMHXm8fGJ/dI8NyGfvMCEGcWyTmL6jubSMPgRfDu+UO/oQMAPWGQ
 mRe4uRw8z7ubT2yZzXS1eklKCgcmWEqXry6j8vctV8O2MRdAc0z6NsPdLQHo0AdpEbCgrjaLxyW
 J+t5DnOlZVkL3gI8Wncu90CMH1qZ4dJlewefYgk/JHWMKDUPTTLVkLz+JcDvZ2d6W9R/Vdf7yMD
 MoI3voq/1q9DfWfUZnKdAk7wPO0z1T2dMGNLqXHmUJ9PgudS6Y31mrm21GQL+ObGqvmWuFPr10g
 g=
X-Received: by 2002:a05:6820:2220:b0:6a0:a791:6885 with SMTP id
 006d021491bc7-6a0ddf1fa0amr6469962eaf.23.1782015718407; 
 Sat, 20 Jun 2026 21:21:58 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:01 -0600
Subject: [PATCH v3 14/40] bsd-user: Commit the generated os-sockopt.h files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-14-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20449; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=daYv8NlB0VYVi3lTp8iCY/xmTz0OF/DUPiRwFyF0pyU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+nHi9ZcaqOMjCnK4L352EuuoH+TGJTOZyH
 d9hNlPOVLGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 AIjBD/9HeuqDud+01nzP3V6ElqCJrFyFpPNCcMrJ3KHq8UNGPNOBJx0CuP8i8Eu47aWOKQlhuJX
 ye9gu/yU8Kb2SrRespcnspGWFQSvM5/ENJMJrALbqx0MtSUSY/I6qGCVi4Qvn4w0g6eYfKxIDii
 Gpn6gDDv4QUeTtpn9Lno4vtwH7zpBkMl7o3bNomweafTejUyptcfTCX43YRUFEagQbh8ZcIxQ6h
 jJefnqwplkeq6r7wW52PBTgPigzOmu14QmZFiSHbGQEB+rnFOa7lcSGMDaSSlpzIDvrrA7M37zK
 OmeRmgB2l1tBepvhdXFfWM5OCUIuNcAfnf0pPsQg3QIM3cLtLh0s/ZiNg3EwUB2E7U/EubWtUuy
 AAVcKoe7xM5GB/3Mv7tWP5efxSh0CZQfm94Bj6pdUgvJSaqHbb1y+lwcneRH8bU5Vg9OLmbKnuS
 +kyh9Gy37oOKb+YizPwl2/D63vI9eB0cIYFFBQfWwWEDNKJww6bDnPIdxgrOLWPukXsZX0u3NoW
 hR0NGuUiy5brjvVF1iawvBkZizPsaeqlBeDO+cV7I30XWViLsTX5trbq/jF/yqu4Sml1w6BKgc6
 YMR+hB4eHbqUmPq9Y9kUvFfk2N9AZ2PsmrvHzT8F7U8iSoc4U+4+vPsr++uNzDwAeJ/7UZwTHQt
 10MSZkeQdbczG6Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc36.google.com
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
2.52.0


