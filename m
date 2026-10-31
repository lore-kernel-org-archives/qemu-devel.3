Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6908606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gHuzTqFk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4St-0001nS-78; Sat, 31 Oct 2026 04:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SX-0001jE-66
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:06 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001sL-38
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435336; x=1794040136; i=deller@gmx.de;
 bh=Kr8gRoVxHeA0pw6gwWCeD1YhtCT9+xXxkGRgpOqYXsE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gHuzTqFk2/FulVcpUR1hPh1cXihiidaT5/zHOibxQYatZN3dVA4Y0h6v72TBAIi/
 fS6FzBFqhTLlMS0BlTNXkTmf2fqAk51Ns/h3TUc7l5ZJzTFlVcjhv0Fhs6Ht72avj
 9ogV4m3TE5PikZ6ODWaQJ9JcvDrgdq7ORuVvWbm0XrtDWJqTP9qdB6FcOB9KxNn1+
 zwOG74hNc5cdaZWFv5tIpndTLcd2O7C4k5MoXz0d9SkeG0v7fEChcXIpxHxCBAR+n
 090ghxjxxCCTPFOGmCnVHgI0OO5DRIk09DoPw4L/qZigLmDQ0xFMdd6ut6snHZOqJ
 sb4n6xDcJK9XaFKeDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1xQepb1eMh-00HLWc; Sat, 31
 Oct 2026 09:28:56 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 04/10] target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
Date: Sat, 31 Oct 2026 09:28:44 +0100
Message-ID: <20261031082850.439293-5-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r8Xt59MLu1sRjc9FavWS7nt1kl57g3S4zKSEn4DoUHjZO1IGs/Y
 EVkCLPfO7WBG1mZ8I62ACYOKdo7tiRQtULjEahgAFm6s/Wdt/t1vDhffxT3/YTBtFXaXXBE
 0O9VXnrDQf0ZCdZWghtpt6hBuQldXvh09NAwFxHXngZKkLlR0vRYcKD6QbABiB1iTMmXJwi
 XOsIfg1rRNSasFmlD8QeQ==
UI-OutboundReport: notjunk:1;M01:P0:aUGlXdRTch4=;ROs/1h/KE6cQMhBVI0cFXm07SPg
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The physical PA100LC and PA7300LC CPUs implement 8 BTLB entries only.
HP-UX 9.05 seems to have problems if more are available, so reduce the
number to 8 entries to allow HP-UX 9.05 to boot.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/hppa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c0ba787974..da48a78569 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -248,7 +248,7 @@ typedef struct CPUArchState {
      * ??? The number of entries isn't specified by the architecture.
      * BTLBs are not supported in 64-bit machines.
      */
-#define PA10_BTLB_FIXED         16
+#define PA10_BTLB_FIXED         8
 #define PA10_BTLB_VARIABLE      0
 #define HPPA_TLB_ENTRIES        256
=20
=2D-=20
2.56.0


