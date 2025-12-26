Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF5E8FDBA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFUo-00085T-0E; Fri, 26 Dec 2025 16:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZFUm-00085G-Ob
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:37:12 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZFUl-0007Cq-1E
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766785028; x=1767389828; i=laurent@vivier.eu;
 bh=QAQqEihj4nMTSUsATOWQ2IgxXdkpAiIMkGFxoNhuc8M=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TwO84/dA1S8s3wsu+oxslMTAv4nXF0Ouu342AAqDijkS7koZrZm1e+du9ZfQcK8n
 hhY1TPcP4m1FyNvObnlCbF6E7kFC3n+e/pblxe2Ilot1vXrAqc7RRFV3tWDREve1b
 W34M0RbxV7Cvk0Yjkne4vPB+dnSGUFvy2eVz6yEi1+qc/wtJRyXxl2PQvh1J3xE4c
 wHkQw7bhj6QvaF3CPygVcDuqmOol781gp0xlG7d3aMULsRJgTGPh8Dqn3GwjM3Pax
 HBrl7zyugtV0NMtP0/+hwvICSfJiJ2jJmkx8lEkkMds5onRPKOPFO1X2TfcnNV1Tx
 Yl/U1C5whleJ2cn4iQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M91Tq-1vc1S62LO2-005h6u; Fri, 26
 Dec 2025 22:37:08 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] m68k: fix CAS2 writeback when Dc1==Dc2
Date: Fri, 26 Dec 2025 22:37:07 +0100
Message-ID: <20251226213707.331741-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BgZh4fArkLsX1kI/w3LXy6s+g61EUJt++GXLNdA8eEEIaJrqwkW
 zG4YfD1hQzkyZ1AUGnF7qdTCU1YXbNCPGL/3K/T5WOmmSHT3NPua25jQfz6AbSOHKEl4jRR
 rSCl/4tXhACgnmPCTHC2gNV77+NplVacDq/o5gpAfENLb9TY4KzZThfnbi9WHtxyDFU1wox
 op3vPVYXVXD3usWWE7+qg==
UI-OutboundReport: notjunk:1;M01:P0:m0H7JYxhAQM=;olG+EVAawZAqF5jdyaqRbMfN7ah
 7hF2QF6dwGBF/7IeIu32W/0f1my8ywv21Rmgo+gckNiZku5bWky+80ralRj4TQgk2D3DGBXk8
 kMDIQZ2dVZTwZ9GmYCmm+nJw41ZGzb/AAIUukkxuQrI63YSIWicHFFM2wDbMQoDFUNLfHOmpu
 CqasHrLcmr98FwbnRSLTPQ2LTPSmoFSv6LNuDF+niJszRyjUxSYKHUdA3JQYluOWCub2dSRvJ
 cvHDelS6b3CyEGd2Il6bwCK40q62B0pwcaKCfLMcvgoWtS3coIl571TSIFkVmSkeqX9D+f3w1
 zjqbNv/9lT+DmJDm55ZSdmfGKNLdqHlfUsQdqnFDeo7JTS9u2bNCRbYPMOu4pc/YfK5aHXVCm
 JBIF6BLSDLWgdEalNgG5E9HDUuhvjPgtB5PiJnRVi3aiQ6fzCDXE0AtEpNafTt7CjxGUCOLw0
 kXd/wkZquZo+CB5yai8df18AFjmwTXbe5i8VGk4OYFNksdeef/C6ZKK8qX0NImKeQiHymH/OD
 DQsHR1os6LfRLaGa+69OPwxYNlSRuq83dAWpxizp6+X5B7w9U6PcZiHd+gcQXbCJrCh0wI7Rt
 aKZG4uO37AB/bnvQxUmnfOUCYcKurgKVkGx431JXizdwLXzO46uNTLiAXplvMwNtk7Kpllbvv
 OYxfKrSUQ7YhFzt12uu1Ff7gCwZqaLqfzPMu+GsnBNm1vex5Q9neUpiMMMDfcs2f/1VTdH+N+
 HtRf6BJ//u4kwFyiskLV73BH4E9WzqkDbYAIULBNKuPH08C7S4y48LVbVMEtOpk6I3gzQ+F8z
 RZG2SfBs6BbJxnuezCwCXwy/0fRHPvbaRzEM+UvWJ5Wz8exmvyYsuZskevZ9Lcb4Ji2hvmaRB
 hHTL9xLAHrpUQOxnZhB56qH8NMv7x02TByfRrGmUgdAeGsbgkRtsfSEDsWkXnRY53LyS4vM2M
 /YdZ4ryB8QWXr6fPBcv3ZezMbxZ7P4nhgI/ugN4dRy3PbIpf9thNGx6Z12ekCqsW3bWEBJRMo
 o4kai86Q+K7cXzL/FNPe2hbqa+dGLbSDWrhLIgwDMKSzPUGFbqd+/MgEeRA5uJFYaoD/VYpf3
 WM+VvFG7gtISckWbiOfdYPcpGXsQ2YoITrFMd6toUxL//DM7VNYEo56JlUAtClrhQP+UcQo5E
 4z1Lf0AbuWwJ+yOfX7p5SGSGYnfoU7fUO6OJ1S/fqg4vkFHEFjoI/H25ofSCbFlFQKFfmmUOd
 wKYi2ycElL/uEediETTt5ObqnVzJAtZ+VzcmJv3xKMKZ/MuBqZLOMN4tQJv4DrP9E/q9K54KH
 FG628uAmRSn4suidwKmM+nAkET08ioQR6b9HS0ndlSssaKB7An73iaqyCIuc4SkMAV5onwp/B
 kcmJjGhrHjo0K2WTfRkM9QhIGLE7ZWX1yjKwwYqYamZzm7QF2od9q1bd9SsVWZFtmFatis8gg
 mBFKiZ3f/kf5nVryAYzNeP3nKNE1xREcw4gHMlfzj960HNVViwMMFHQ6ZAI7x9j1+7dnqFQzP
 59QRZafOu8Q25bQ5chywZuKEgN6QDT1xBPb3zIXCuze/gBl3aowq3UH/uKuNVvX+UWGaz6bST
 VHfOhapYRYDt4DavRh0MDBj/lnJe7J+64HMSd1us0AykiQCP3pbN19n2AyicWKza6RwYVcs02
 rDbr7O66izuGY9r6VGB6wSEkMtdvJmMcBkcd/q7Y12+nBcULWwtZnUCo47X+6Dc/CGl0d3vcR
 GFC40wgUTZ9WLAfKv9SSczWxrUYhmaqMvH5hWX2h8PTj6BPMrcIHWCFU=
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
same data register and the comparison fails, memory operand 1 is stored
in the data register.

The current helpers wrote Dc1 then Dc2, leaving operand 2 in the shared
register.

Swap the writeback order for cas2w/cas2l so memory operand 1 wins.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 target/m68k/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e9c20a8e0322..10266b1e0e8b 100644
=2D-- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -799,8 +799,8 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, u=
int32_t a1, uint32_t a2)
         env->cc_v =3D c2;
     }
     env->cc_op =3D CC_OP_CMPW;
-    env->dregs[Dc1] =3D deposit32(env->dregs[Dc1], 0, 16, l1);
     env->dregs[Dc2] =3D deposit32(env->dregs[Dc2], 0, 16, l2);
+    env->dregs[Dc1] =3D deposit32(env->dregs[Dc1], 0, 16, l1);
 }
=20
 static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint3=
2_t a2,
@@ -861,8 +861,8 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs,=
 uint32_t a1, uint32_t a2,
         env->cc_v =3D c2;
     }
     env->cc_op =3D CC_OP_CMPL;
-    env->dregs[Dc1] =3D l1;
     env->dregs[Dc2] =3D l2;
+    env->dregs[Dc1] =3D l1;
 }
=20
 void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_=
t a2)
=2D-=20
2.52.0


