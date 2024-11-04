Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4961D132C7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xLF-00017h-Gl; Mon, 04 Nov 2024 08:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xLB-00016d-6h
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xL9-0002nQ-DJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPthFrMxmhKGom/Zvwb9lQV5GfKcxFkTWB5GPax1qUo=;
 b=SNisPrYrvsAHV4d3QfgcVWSxUXgcTSQeqV1icRx2hB3HIPlsmSsl0uOube0ZIPYWzfMdlK
 HuAWRPJ1whJSFLmRseyHtcuxdNcNjeSpTpKPdle4U15tyes9tw9g23APDyV5PCA3+RfQq9
 ifzmVRfGupcLrwiNcIJKfolrlNxJO+I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-Ts0PFCkjPdmCvAydVlMPLw-1; Mon,
 04 Nov 2024 08:41:48 -0500
X-MC-Unique: Ts0PFCkjPdmCvAydVlMPLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7215419560AE; Mon,  4 Nov 2024 13:41:47 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25131956086; Mon,  4 Nov 2024 13:41:44 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] qga: fix -Wsometimes-uninitialized windows warning
Date: Mon,  4 Nov 2024 15:41:37 +0200
Message-ID: <20241104134139.225514-2-kkostiuk@redhat.com>
In-Reply-To: <20241104134139.225514-1-kkostiuk@redhat.com>
References: <20241104134139.225514-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reported by clang, but not gcc.

[5123/5678] Compiling C object qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
FAILED: qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
"cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi" "-Itrace" "-Iu=
i" "-Iui/shader" "-IC:/msys64/clangarm64/include/glib-2.0" "-IC:/msys64/cla=
ngarm64/lib/glib-2.0/include" "-fdiagnostics-color=3Dauto" "-Wall" "-Winval=
id-pch" "-Werror" "-std=3Dgnu11" "-O2" "-g" "-fstack-protector-strong" "-We=
mpty-body" "-Wendif-labels" "-Wexpansion-to-defined" "-Wformat-security" "-=
Wformat-y2k" "-Wignored-qualifiers" "-Winit-self" "-Wmissing-format-attribu=
te" "-Wmissing-prototypes" "-Wnested-externs" "-Wold-style-definition" "-Wr=
edundant-decls" "-Wstrict-prototypes" "-Wtype-limits" "-Wundef" "-Wvla" "-W=
write-strings" "-Wno-gnu-variable-sized-type-not-at-end" "-Wno-initializer-=
overrides" "-Wno-missing-include-dirs" "-Wno-psabi" "-Wno-shift-negative-va=
lue" "-Wno-string-plus-int" "-Wno-tautological-type-limit-compare" "-Wno-ty=
pedef-redefinition" "-Wthread-safety" "-iquote" "." "-iquote" "C:/w/qemu" "=
-iquote" "C:/w/qemu/include" "-iquote" "C:/w/qemu/host/include/aarch64" "-i=
quote" "C:/w/qemu/host/include/generic" "-iquote" "C:/w/qemu/tcg/aarch64" "=
-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=3D64" "-D_LARGEFILE_SOURCE" "-fno-stric=
t-aliasing" "-fno-common" "-fwrapv" "-fno-pie" "-ftrivial-auto-var-init=3Dz=
ero" "-fzero-call-used-regs=3Dused-gpr" -MD -MQ qga/qemu-ga.exe.p/commands-=
windows-ssh.c.obj -MF "qga/qemu-ga.exe.p/commands-windows-ssh.c.obj.d" -o q=
ga/qemu-ga.exe.p/commands-windows-ssh.c.obj "-c" ../qga/commands-windows-ss=
h.c
../qga/commands-windows-ssh.c:383:9: error: variable 'userPSID' is used uni=
nitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitializ=
ed]
  383 |     if (!create_acl(userInfo, &pACL, errp)) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../qga/commands-windows-ssh.c:415:15: note: uninitialized use occurs here
  415 |     LocalFree(userPSID);
      |               ^~~~~~~~
../qga/commands-windows-ssh.c:383:5: note: remove the 'if' if its condition=
 is always false
  383 |     if (!create_acl(userInfo, &pACL, errp)) {
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  384 |         goto error;
      |         ~~~~~~~~~~~
  385 |     }
      |     ~
../qga/commands-windows-ssh.c:380:18: note: initialize the variable 'userPS=
ID' to silence this warning
  380 |     PSID userPSID;
      |                  ^
      |                   =3D NULL
1 error generated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20241031040426.772604-6-pierrick.bouvier@li=
naro.org
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-windows-ssh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
index 6a642e3ba8..df45c17b75 100644
--- a/qga/commands-windows-ssh.c
+++ b/qga/commands-windows-ssh.c
@@ -377,7 +377,7 @@ error:
 static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
 {
     PACL pACL =3D NULL;
-    PSID userPSID;
+    PSID userPSID =3D NULL;
=20
     /* Creates the access control structure */
     if (!create_acl(userInfo, &pACL, errp)) {
--=20
2.47.0


