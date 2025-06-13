Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEADDC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6p1-0001rp-Pn; Fri, 13 Jun 2025 12:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1uQ6on-0001nZ-HW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:59:49 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1uQ6om-0008Oq-2b
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1749830386; x=1750435186; i=j.neuschaefer@gmx.net;
 bh=xsSRgWgcg+SxnvKNG2VkY2gFYCH4Xc4FvVyni4w7Ask=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TQxqjva3F2FgoQ6v5d93IRv+aWgYJMPAMK4dWei9P2eIIfixLpNgN7dhZnue6Qky
 qFHJ+YGgcDiL5W9QHXf1X7oqB2J1esBYbJ/Bw5lLXDesM1iFmDO3ggaz2JFyMIt0s
 ydQENDB7cS3NYxoT4bYZNnNpXdKsRCcaZe3+pepQzymZi1uZV3fZWG6rtp0bDpw8V
 n55gLoxHdC4aPfygETcPxwfbykQOvJd2CxMJH1Eq5gtH1VQbOIYNa73ooe/qaWbVM
 cFZRN5O6GSm9iFN4i+7Kd9aunJoZvuF10XTgc6O0oLIDVRRVV6uLY5Em9oVNDBRsQ
 NHqU4YOqqcD91H5GPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.210.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1uUnmF0MmP-007Hbl; Fri, 13
 Jun 2025 17:59:46 +0200
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Fri, 13 Jun 2025 17:59:32 +0200
Subject: [PATCH] linux-user/arm: Fix return value of SYS_cacheflush
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20250613-cache-v1-1-ee9f4a9ba81b@gmx.net>
X-B4-Tracking: v=1; b=H4sIAONKTGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nj3eTE5IxUXXMj40Rzc0Mzi2SLVCWg2oKi1LTMCrA50bG1tQBLmQ4
 mVwAAAA==
X-Change-ID: 20250613-cache-723a77168c8e
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Cc: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830385; l=982;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=iBmFThkbLN1Y6xJC1Mw0h3DuXXRcCSecP9DKmG8UycQ=;
 b=5cUiJu1/wKPmmTwYK7L0wowRAZbsG42QYjhd84+d/vEstljLRjl5k2WWpf9OjKw4BzNnYWure
 1pGdmRDEGxUAgFbnBXGcZrEZHtQs56lQK8Qc9YgXFvWCl/+I66Z/A/V
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:wrup2wGn0aHadN1LQCJk6S59+tfahLiY54Dwom+ESLpvrA1pD/j
 ZfTc3wJhbvlGbqRKqMgkhlyZG4NtdrJe0HV90e1bqpQ3fh9IWT/V2Bw/Md9+U1pO7lAUTjp
 tMKxG/EpSdhGzj+MdivHLef7mPweFfdknkFtLeCv839Ast4p01PxkDdj8nIWWnXBeCFVWoH
 pepSfVkMsGLNzayHkVBVg==
UI-OutboundReport: notjunk:1;M01:P0:TwKUZyFKMzg=;PceM4vB09uYkIPP2XI7SGt4uKLV
 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
 ZcgLPhs+cd93gs78YD1/qy5HngJ/eTJd9Y3P6A==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=j.neuschaefer@gmx.net;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Although the emulated cacheflush syscall does nothing, it still needs to
return zero to indicate success.

Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 linux-user/arm/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index e8417d040691a04a3edc0f5508f047571beac8fa..33f63951a958a5a48ced2d1e18=
7264d691e5c940 100644
=2D-- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -363,6 +363,7 @@ void cpu_loop(CPUARMState *env)
                     switch (n) {
                     case ARM_NR_cacheflush:
                         /* nop */
+                        env->regs[0] =3D 0;
                         break;
                     case ARM_NR_set_tls:
                         cpu_set_tls(env, env->regs[0]);

=2D--
base-commit: d9ce74873a6a5a7c504379857461e4ae64fcf0cd
change-id: 20250613-cache-723a77168c8e

Best regards,
=2D-=20
J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>


