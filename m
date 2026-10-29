Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jyF/AxtL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCT-00041h-Qx; Thu, 29 Oct 2026 18:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003vC-Ce
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:02 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006W6-G4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311301; x=1793916101; i=deller@gmx.de;
 bh=Kr8gRoVxHeA0pw6gwWCeD1YhtCT9+xXxkGRgpOqYXsE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jyF/AxtLSL24TEjG89Alz4w3x+j13zjScpymsc+tzINT0cIfqZex1AQ5VMyIt9ka
 LTKBnwApJu+qF6yDImH7Z1KyfPVxlDW0iu1F0kbKYvisHOKLvgS22gc8WdK5TQ6/E
 JxVHsKHNO/OW6BPxtpUz5uGqgEwoQJ4U9vBYCM0gc8XzwnVlUGWcaMDjuu8o3RteH
 2xqk9Ou6ekMQ/98Yk6uOwmyboDqD/e80PxFEmFnTYnkxw3fwf63NZw6HhxBMOpJFs
 f9+tmLG2a7LHRC/S5rnQ9voep0tW+sIZgR9GmimX9/psOBN+uUk15JZ1JtK3Bkm3C
 Nxsq7Eg/v/mvO4uXrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1x6XTa3wQk-00NPX9; Thu, 29
 Oct 2026 23:01:41 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 04/10] target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
Date: Thu, 29 Oct 2026 23:01:29 +0100
Message-ID: <20261029220135.412284-5-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPVlKjianAianT7bjZp23LH6PbYufvO5e3gr/rhJMljlWPYwE4s
 1FJRr4Tp2vFD1K0Jd/HQq4a4fMWUObHhLXwPTZqIdjxnjpi8UTvmPWm9Ayyh/3j0uFh0XGF
 1uTySa+PKrCAFqWistDBrTcAGL/wzAtoeDQtXGFDLUszd373WSKNaF8rCWe7oGutV9VORBC
 L/bnldG3ZemF6S67pt/YA==
UI-OutboundReport: notjunk:1;M01:P0:BDn4c1z8pyY=;xb2Bj0m4P0UAJgu8aYbGLrr4xWv
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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


