Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ABEEF99DD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 21:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr1Aw-0000oB-Km; Fri, 13 Feb 2026 16:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crichez@pm.me>) id 1vr1At-0000nn-Ce
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 16:58:07 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crichez@pm.me>) id 1vr1Ar-0001JK-2a
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 16:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1771019872; x=1771279072;
 bh=46PDkYIs1PJ0gevHFfEmkZMBRlQ4IZCSlCTfA41mf7k=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=K7yuXvRGZEPYemeEMQuIAOF9Gr5pY8/Gaim2D6PrnCtVmT3yc4HXv3VYbg+f9We2j
 OoSst1eZVbGnleS/m+bZ9kSscj8U8tFgTmycbP71x5mfHmeCebHb55a92e4QA+a7pb
 ySIfzYliP2e8SsIdDXpBtN+plDVaCQfL5ONUdUShZK8vYTJZq9/G/i1HZQUUxCWHGN
 M9QSLTc/5ae70jbc7J53XZ87Z8x3iSs+winQCPCARByHE5IffEkMQzpKdD9A/Y+fhJ
 cbkjHAvKY77Kncqp2MrZImH4CM+y3cPRKCJ/UjrAAgv0aSOY2Ug5Wj0JTN900qXJOC
 aZTNn7/WMwRpw==
Date: Fri, 13 Feb 2026 21:57:47 +0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
From: Christopher Palmer-Richez <crichez@pm.me>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>, Christopher Palmer-Richez <crichez@pm.me>
Subject: [PATCH] net/slirp: allow hostfwd socket paths with dashes
Message-ID: <20260213-fix-hostfwd-unix-dash-v1-1-9e26fc2b63d6@pm.me>
Feedback-ID: 5960063:user:proton
X-Pm-Message-ID: eede0d838983f5b687a7d53726dd6a73156f882e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=crichez@pm.me;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds get_last_str_sep, a variant of get_str_sep that checks for the last
occurence of a separator. Updates slirp_hostfwd to parse unix domain
socket paths with dashes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/347
Signed-off-by: Christopher Palmer-Richez <crichez@pm.me>
---
QEMU added support for `-netdev user,hostfwd=3Dunix:/tmp/vm-:22` last year.
The implementation detects the first dash, and interprets the right side
of it as the guest address (or lack thereof). If the host socket path
contains a dash, the invocation fails with "Bad guest address."

This tiny patch adds a variant of the `get_str_sep` method previously
used by `slirp_hostfwd`, but that detects the last occurence of a
separator instead: `get_last_str_sep`. The only difference is the use of
`strrchr` instead of `strchr`. `slirp_hostfwd` now uses it. It ignores
dashes up to the last occurence, which allows unix domain socket paths
with dashes.
---
 net/slirp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 04925f3318..968be9cc99 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -69,6 +69,26 @@ static int get_str_sep(char *buf, int buf_size, const ch=
ar **pp, int sep)
     return 0;
 }
=20
+static int get_last_str_sep(char *buf, int buf_size, const char **pp, int =
sep)
+{
+    const char *p, *p1;
+    int len;
+    p =3D *pp;
+    p1 =3D strrchr(p, sep);
+    if (!p1)
+        return -1;
+    len =3D p1 - p;
+    p1++;
+    if (buf_size > 0) {
+        if (len > buf_size - 1)
+            len =3D buf_size - 1;
+        memcpy(buf, p, len);
+        buf[len] =3D '\0';
+    }
+    *pp =3D p1;
+    return 0;
+}
+
 /* slirp network adapter */
=20
 #define SLIRP_CFG_HOSTFWD 1
@@ -848,7 +868,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)
=20
 #if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
     if (is_unix) {
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_last_str_sep(buf, sizeof(buf), &p, '-') < 0) {
             fail_reason =3D "Missing - separator";
             goto fail_syntax;
         }

---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260213-fix-hostfwd-unix-dash-b3fe7b49a362

Best regards,
--=20
Christopher Palmer-Richez <crichez@pm.me>



