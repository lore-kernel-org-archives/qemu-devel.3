Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462F9EFCD93
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXuX-00068m-Kj; Mon, 09 Mar 2026 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-a36d955be56c46859e5cc1879ee4326b@bounce.vates.tech>)
 id 1vzXuR-00064Y-7r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:25 -0400
Received: from mail132-19.atl131.mandrillapp.com ([198.2.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-a36d955be56c46859e5cc1879ee4326b@bounce.vates.tech>)
 id 1vzXuO-0006Z2-9K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773051335; x=1773321335;
 bh=Pua1OJrjA6lG1CV3UdQchybQhIhmfZiQtOh7j/W3fSU=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=b1pvXDGd2XW8hQVJysi8c5nExA4cVpZtVzDbGX0UWvMqOMd3Q8K2t0wLTNv6xaFLN
 GmcePhp24HMdZKSNzBLGcflKhMMqO9vqm5hWKl/YI2n1lBXoU0TiXPF9u1Iha6J9mr
 +lHJEhqQncH0dBeDtPIDVt+1VbwWCTJUbOZThhJEHHUTpDHFC3l//vu6d8VHb/sDdX
 AEwo9SBcyuqUv2RKm4Y7C8jdvXJdQXKHJgazxTY4Wo/faomdnAH9MHlc4tWw6iiLYy
 erqO35hjhtrV2hSX6Jaf3zk+CP9PcQkCkU7hw5TZhN4ZtybEkTULYGyHBGmDaMhVTY
 BGBIiNGJQ+7iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773051335; x=1773311835; i=anthony.perard@vates.tech;
 bh=Pua1OJrjA6lG1CV3UdQchybQhIhmfZiQtOh7j/W3fSU=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=llvTkPP92ALukd0UYKglpgCWRfp+QW4Uwe3Hxa35JSVE7avrvaRxc68OqDnPTMLJe
 saAR7Ws/8NEZ+Ly6TcJUBNIbnSa0VmuFb/7RLSW9fpMfeX/w44hkeoeHZbcwOuNB12
 X7BmIPYX5dUJ39BZycW1Xjf0VBhZCKpiBoHQiEUjPggmT2SqsvSZYSW2kyZwOsJKpG
 xp1Yz23akvk0CceG+oxRULn0JMwVR6w5AHGh6PknGQlJBCXiupb3flIgIdRnLY9t+e
 xf7tASoDU+RHSffkFstMJXZSM+07BNW9Ui8Bcu9+detwlIj4x16sZc8+O8skpB4jYo
 OytYkoPM27QNQ==
Received: from pmta09.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail132-19.atl131.mandrillapp.com (Mailchimp) with ESMTP id 4fTtF35Cvpz1y1
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 10:15:35 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=201/3]=20hw/xen:=20Fix=20trace=5Fxs=5Fnode=5Fread()=20params?=
Received: from [37.26.189.201] by mandrillapp.com id
 a36d955be56c46859e5cc1879ee4326b; Mon, 09 Mar 2026 10:15:35 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773051335049
To: qemu-devel@nongnu.org
Cc: "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20260309101529.25695-6-anthony.perard@vates.tech>
In-Reply-To: <20260309101529.25695-5-anthony.perard@vates.tech>
References: <20260309101529.25695-5-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.a36d955be56c46859e5cc1879ee4326b?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260309:md
Date: Mon, 09 Mar 2026 10:15:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.132.19;
 envelope-from=bounce-md_30504962.69ae9dc7.v1-a36d955be56c46859e5cc1879ee4326b@bounce.vates.tech;
 helo=mail132-19.atl131.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Liam Merwick <liam.merwick@oracle.com>

When the '--enable-trace-backends=3Dsyslog' build option is configured,
the following compilation error is encountered.

In file included from /usr/include/sys/syslog.h:207,
                 from /usr/include/syslog.h:1,
                 from ./trace/trace-hw_xen.h:224,
                 from ../hw/xen/trace.h:1,
                 from ../hw/xen/xen-bus-helper.c:13:
In function =E2=80=98syslog=E2=80=99,
    inlined from =E2=80=98_nocheck__trace_xs_node_read=E2=80=99 at ../hw/xe=
n/trace-events:41:9,
    inlined from =E2=80=98trace_xs_node_read=E2=80=99 at trace/trace-hw_xen=
.h:903:9,
    inlined from =E2=80=98xs_node_read=E2=80=99 at ../hw/xen/xen-bus-helper=
.c:154:5:
/usr/include/bits/syslog.h:45:3: error: =E2=80=98%s=E2=80=99 directive argu=
ment is null [-Werror=3Dformat-overflow=3D]
   45 |   __syslog_chk (__pri, __USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pac=
k ());
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~

Add a check that 'value' is not null before passing it to trace_xs_node_rea=
d().

Fixes: e6cdeee95990 ("hw/xen: Add xs_node_read() helper function")
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Message-ID: <20250523160134.218997-1-liam.merwick@oracle.com>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/xen/xen-bus-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 288fad422b..1087a585cc 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -151,7 +151,7 @@ char *xs_node_read(struct qemu_xs_handle *h, xs_transac=
tion_t tid,
     va_end(ap);
 
     value =3D qemu_xen_xs_read(h, tid, path, len);
-    trace_xs_node_read(path, value);
+    trace_xs_node_read(path, value ? value : "<null>");
     if (!value) {
         error_setg_errno(errp, errno, "failed to read from '%s'", path);
     }


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



