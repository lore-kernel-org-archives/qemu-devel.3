Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73A7C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY53I-0004iQ-Az; Thu, 08 Feb 2024 09:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kolpa.me>) id 1rY2Jq-00074Z-Ol
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 06:11:51 -0500
Received: from dane.soverin.net ([185.233.34.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nathan@kolpa.me>) id 1rY2Jo-0001qI-5c
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 06:11:49 -0500
Received: from mail2.mijndomein.nl (unknown [10.10.4.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by dane.soverin.net (Postfix) with ESMTPS id 4TVvSX10wwz2xW4;
 Thu,  8 Feb 2024 11:11:40 +0000 (UTC)
Received: from mail2.mijndomein.nl (mail2.mijndomein.nl [10.10.4.133]) by
 mijndomein.nl (Postfix) with ESMTPSA id 4TVvSW3hDGzyP1; 
 Thu,  8 Feb 2024 11:11:39 +0000 (UTC)
Authentication-Results: mail2.mijndomein.nl; dkim=pass (2048-bit key;
 unprotected) header.d=kolpa.me header.i=@kolpa.me header.a=rsa-sha256
 header.s=soverin1 header.b=ruzVELs3; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolpa.me; s=soverin1; 
 t=1707390699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A0GJtQM9byRWqwr/UNXL/dr0YjOjdeS7cQERAt/3XBk=;
 b=ruzVELs3sFXZw54H1K6Rvtkl213BiLOnS2yJmK9g13e5RfMAE/ATCxQDu+UUSaPhquVT9n
 52s5z35cAkC5lL7E5jPJQ64OoU2lrTWoft4bwCIyEz6iOS86CarKgnsAM9FJzETt5/QkpY
 Mop5A48wnTxFfyUN+JqmCGWKECUao5dTu1opAt2PQEn9FFlsAizAz3S8sHF5LOjCe01MMA
 57g6AiY8keShCMeHrq82cdypqdhl9kbD/14wWDrL2eAqyATCpnLihn7wVUxjp8PTpiexcG
 PgXewQkgNADaz8cS2P06sf2ylH7UC4QyFy1yQkTTGcH3RaV+cEtfLC06cM3Igw==
Mime-Version: 1.0
Date: Thu, 08 Feb 2024 11:11:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <9939bfcd6fad908c21bbfb751a2896d7@email.mijndomein.nl>
X-Soverin-Authenticated: true
From: nathan@kolpa.me
Subject: [PATCH] hw/i386: return an error message when mb magic/pvh note
 could  not be found
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com
X-Priority: 3 (Normal)
Received-SPF: pass client-ip=185.233.34.31; envelope-from=nathan@kolpa.me;
 helo=dane.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Feb 2024 09:06:47 -0500
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

When using a non-linux kernel where the multiboot magic is=0Amisconfigure=
d the following message would display: "linux kernel too old to load a ra=
m=0Adisk".=0A=0AThis patch instead, displays a more descriptive error mes=
sage: "could not find multiboot magic or PVH ELF Note". The linux specifi=
c boot sequence is skipped because earlier it is asserted that the linux =
protocol magic field could not be found.=0A=0ASigned-off-by: Nathan Kolpa=
 <nathan@kolpa.me>=0A---=0A hw/i386/x86.c | 5 ++++-=0A 1 file changed, 4 =
insertions(+), 1 deletion(-)=0A=0Adiff --git a/hw/i386/x86.c b/hw/i386/x8=
6.c=0Aindex 2b6291ad8d..b59f1180f5 100644=0A--- a/hw/i386/x86.c=0A+++ b/h=
w/i386/x86.c=0A@@ -902,7 +902,10 @@ void x86_load_linux(X86MachineState *=
x86ms,=0A =0A             return;=0A         }=0A-        protocol =3D 0;=
=0A+=0A+        fprintf(stderr, "qemu: could not find multiboot magic or =
"=0A+                "PVH ELF Note.\n");=0A+        exit(1);=0A     }=0A =
=0A     if (protocol < 0x200 || !(header[0x211] & 0x01)) {=0A-- =0A2.43.0

