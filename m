Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=tOAC6HNI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSt-0004em-TI; Mon, 09 Nov 2026 08:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSX-0004cw-3J
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001a-snip6-11.eps.apple.com ([2a01:b747:3001:206::b]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPST-0004YN-6L
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:52 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 2C1451801947; Mon, 09 Nov 2026 13:30:40 +0000 (UTC)
X-ICL-RepId: 01a1c080-fc79-7203-94df-3c614f3728a9
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpfHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231042; x=1825767042;
 bh=+gjfLSupQTIdyPGJix0uhYCN1wpSeNy8Pp3gpd3XAmc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=tOAC6HNIKGFBoMazjbqbpx+w0I5JHFnPABpja+fmvKvGa7lTourvOe0tResXL+tkgAiUE+9aCYtpM9jemR5LCaLR64c7wwwGsPEGPIVRJ9cis+e0s7SloWAyDQufk6YmO4IFAXTwO+i17nksJSkNAK23XtaDYy8BPQgiKu8myEDcxBywKwR5zaC/yjLEV0kDJkAaufNhmVNqsBLlpb2YX/RshBNvaRJoThDcIU+KUD6VymXd66zbErfo76MKsOHw8uwxdb3XfFGC8aZuDl9MsdbRE7kXXTSoN81fusemu5vw8znF/Ce25fVFcip5ncNhwk3fJLiNnRCsYvpNDrdzMQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 4438C1801356; Mon, 09 Nov 2026 13:30:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PULL 3/7] whpx: i386: avoid updating hflags for vmexits
Date: Mon,  9 Nov 2026 06:30:31 -0700
Message-ID: <20261109133035.7985-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jEa09K_xPzRrxhIYcC43r-IZAdAshfth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfXzHonwojC9TBU
 7aksJ3p1KUpql6Y0NuuGEh3RxnqtqDH/bvEAy3CO016RjFZFfKXRhRQu1St4a7kJi0qEeYOca71
 1ooX/vnE/rBowNGVWm6APpMRWd9+t4ZMNz4OpkqImLLMlMVh4NFrg/VNsoQlDjBpR+WotKTQqgH
 TMNK7bEFmEcUIH2KPLd+uA4Fpw3lWFTGW0Drq+sLHyV4V0UQ3mbsXUPVk9PVISOOU9LIwAm7khc
 GuvZKpThgKO7KuujIXuhH+Vl7dUf5JWhcVe3zoe+yGXY4PyKdxtCWz4yXWfVgqAIwAKT7nZ4j3N
 Qv3tVA4WaadA9FVksOPIb1ckQcxyGJuRigOU3pYL4HqZdUtfmohqoXERbzv/6Y=
X-Proofpoint-GUID: jEa09K_xPzRrxhIYcC43r-IZAdAshfth
X-Authority-Info-Out: v=2.4 cv=Aei83nXG c=1 sm=1 tr=0 ts=6af1cb01
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=XFq3rTXSGl1-eYzejacA:9
X-JNJ: AAAAAAABBsYfPTDmm2dR2njG8SuwfxPjBPnu6YJonYjs5CBAczx5Yo5Z4ng2HOjv1lF0y5
 D9RUW89mriJOzjsV6Hoz3mbWEq2+J4pkMoauMQS9NOShYR1+/p0Wk8Qdnvtsmyo2mAR/Gz
 VPlwuU19CEfl2OnZsiYke6K4ec1uJm3h/5K8ZPxdGkQtDzdAJj7VB8NX2PwsyyIL0ThBxa
 vVEcUnNTQoaNHeYm7b0emQAtXVSky9+JbO1MPcodz3pVDQe20TPU1CN/6DMr/p4r3JrAKa
 xvEI2g4UKSnzFMiqLkbfH850r+TKw9CxzjIjPdRJWWFCcMjrk/Bjg280f7qSUBCX+mmvu/
 bZ90BOL0qcOKuFEeT9GdEgnt2u8OMEj2h5VoWx9IH7wZ0rudwg/LGhxblpOb99MSRfrsbH
 wzSDS/7yeOxlCoD4CC+NfqCeTO31TZ5Gs4HQKJPLNRbtSVet+x67MORVJT23tgRt2FMiea
 LNQFYJobYI5ZqiufVT4kQBUvkAtmLe3Jp0PD6flQgAsSTxreUHbax5UJ4K7zS8huS6C4G3
 GPR70s5DvZktaRlnYNitj+uSIkY3bMWQpUeFHnyLu/QpBnzZdVvqZeAYWT/C/IYF31cF/N
 3SnRQ21UxpcLRmbvFcqdrUvLRfci0YDLhqYlFFTKMOCFCjrpPLTESwZNPnaKX9Ug2BNXoM
 ZP3YCZd+sH00gPlXlrhMHjMnP1jiE0twBSmH/ueH4CEyVtqE8zWTvKx7kUcjoA6PUZlBe1
 mBOmo7nWLn3uhV
Received-SPF: pass client-ip=2a01:b747:3001:206::b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Boden Randin <bodenrandin1@gmail.com>

whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.

x86_update_hflags() depends on state not refreshed here, while the code
using the fast runtime state does not depend on the hflags it recomputes.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f5f5c3b462..fd3b2acb58 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -744,8 +744,6 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     rflags_to_lflags(env);
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
-
-    x86_update_hflags(env);
 }
 
 static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


