Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA18606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Aa9Zd3gA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gr-0002kX-8X; Thu, 22 Oct 2026 19:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gp-0002ji-Gt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:19 -0400
Received: from mr-2003j-snip6-6.eps.apple.com ([2a01:b747:3000:202::61]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gn-00027Q-Su
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:19 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 7E3001800169; Thu, 22 Oct 2026 23:59:14 +0000 (UTC)
X-ICL-RepId: 01a1660d-fa06-745d-bd09-c391c0d72d51
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQABGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713556; x=1824249556;
 bh=dSrwibXLl61KPeY0mbb9Kw6Bj1BM0S+HBdlSgsEMB5s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Aa9Zd3gAevmxIxwmkE4UBieEDBnFrcVtAQF8s4ZfhgcTFNs3joZ8XW0j+WxthVtqPwkZABz2mHORSmlMhOsqdnyP+eKkiYnbcckafZC/1LpgDheW8BBDonaeQa30taFpGvZzuCLiiXIDamjBV8AAEH+292/1XUpWzgWL8h1CbqkljP/nZ5xIL1+ifso4/0JCbobBbFe8BKlu1pdtgN9XnZwZpw1sUxz89X3UKfdG/FwupB9hqdmUdYSgLYhVFmkjD02dMncwPI46Ea1A9iwiPjDtTe9hi+QVBTwCNkhObDVcJCrPTHPVpnyEqINypzmLlGeHSJ7uIrHCftjj//707g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 AF5D818001F0; Thu, 22 Oct 2026 23:59:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 06/11] whpx: i386: make nested virtualisation init failure
 non-fatal
Date: Fri, 23 Oct 2026 01:58:54 +0200
Message-ID: <20261022235859.88753-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=O/A0fR9W c=1 sm=1 tr=0 ts=6adaa353
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p5XUOwc6s_shZ6Vv324A:9
X-Proofpoint-GUID: s_RQajk0cAED3jfCkRYERVFADkkeq7le
X-Proofpoint-ORIG-GUID: s_RQajk0cAED3jfCkRYERVFADkkeq7le
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX6pS3+URRdPs1
 SBGc9lJqrkggs+mVuDtEPPMQsn0cuC04sQJt+oeF0yLhC5xMVJrQQeITe4VhbSk8iLNrOV6D+VM
 +oEtuxExvk/SjvPG1W4JWrl1ozS7DTe57wiRv/mVhvPNNX7JgC20ZPZe4hTeCSTX29fD7nLt9dV
 xz4dbwU1gxhgWVAEqQCOOBGQH5XrB3tkfdRo7RzwJD4f+tQ+eWxKHEKUM8d7hwv+r3U+H//FHbM
 tLoqW+OQAqBJkMMnH54vKuhBmlzqus+gWU3qcVwMbL8rvyAy6NDxtsVgK9FHCqZLra9TIxSFBLo
 9GSgW52CtUtMzUgeMrUM8yBgcy52brNGg0WWWAJDQo5wot6WlZOqtfDQKiXA2k=
X-JNJ: AAAAAAAB2NmEXMuJCSPgz7XgTqD/7b/b7Xo+QSzwh4ePoKVxUIVyOIQgvYjNUmoiVCM1Jtluo6t1L2Pr++bqsnN4ekRmZ8D7UGfw5w15TokKeez0Sx+QfL/n49YZ3d1LFtiVe3a92M918nCVTdBbqMYty08PndRu3JNrhWQScW7MOi3+2Z8Zt9lXoMVC2JzzBzdyVZDxKlSK06qPPtFXyv1PA/2qM7FOLTEUE5vtWxK0JNfGwhLqoxI1Y11XZ6uorNP2VAMUCFcFtumzopZeoui0BHen1hs5GwDl7usyM9/jR85Fn4SWcNRNsIb/ImqHwx+smjv4xbt0FIAwLc+E01/0iSNvWznIq5D/w/TVXQTWQaEM2Huk7yRWj0r+HF7+2ZNarNFIheV3aZJwq8mR07w31qpB9HdA587HqDx6C3zb5Ia8fYX5VqNzITgy3Jn7ZEliR4RX/DfvEOE6EwexD825VEIGY7AMwpqD/j8x/KKZLjWfkzJ+JPZYIOPZfarT30tzHe/bVDEibVmNbS9tk3nbkqcBq21TzFVo2PUVyG20JlsNCxdbqYs80QQ+I++cxbuSkylIsztGFhAYWJYKk8EuTp0VINkYapdgO169SFRec6j933oUZyEvzPw7R7G1CFce0nD6OnfduJaVSmdIaa4mEYcu8E9/PpO76D99ktsehLaw0g8nGwKb+ggsr3qSz6rc/zfqQi+FPzRwOCpGOiFBjo4DqJe2AgneiLuXjrMZ0buTPSPSNdvLAaayMr8rQU2GZvUDHtzmZ32O0ZRBLfI/N5D6SH3Y0av7vjUjAbMLYweCBGifPQ==
Received-SPF: pass client-ip=2a01:b747:3000:202::61;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some CPUs too old for Windows 11 (Skylake) support but running
it anyway, WHP advertises nested virt despite it
being unavailable.

As such, make failures to initialise nested virt even when advertised
non-fatal.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 408a1667e0..d13513985c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3302,9 +3302,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
             if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+                warn_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
         }
     }
 
-- 
2.54.0 (Apple Git-157)


