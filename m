Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDBEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtC-0002hw-PR; Mon, 06 Jul 2026 18:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt6-0002fb-Ai
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt2-0005LQ-TA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxaX1478019
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=; b=aDoDvkyFhYJw1Wjo
 NKLNTYxREo/+eakkXhk3kghiqWg6GA5BaH912IM6tCSssCuFlp5lxU35Kr9hkOGA
 fil1ukGIY4b3P4EGe5MwIBWJoQ/OXK935RLAf0qbyrimBATnH6vnqDabBpR8WTYu
 AiGHpkw/V5I8w2SezD156Ed3JQVz2T25hWKnz38OXHkeQ1OSz+bZrqzThkyQU1Ff
 rpVUAMJ7TeE+rxOBIHeOHia6/zewZAsnF6ybjC2F4JOjc9g1uYIgI+gK8AhJI4Fr
 u0+Jjf8wQjLjEgO8ToMMzJ0eZjRc19GRwQZub0sI6X481XIGlmVDC78oXFColhxA
 20MOYQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbkvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:33:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so5454427a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377238; x=1783982038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=;
 b=frfj5XiDFd+X7RfecC1KFU4D+sfzwaVDY7365YBA3FITs2WiSI/np1nFbjR7YJUD2s
 TltcST4K2vfyLhjAeXQF922ctXFgWgiUSErSmLOI3hQlnsQmyBeg6xz8I+O6Efu3z5qw
 MNbgvAOV0dsDzB2P0dtspARrn4dqmVRpkMp2f9Wza39R+zrkejsRS37XcGS6L75ax3xg
 tpZ3ivRuBP6+Ri+cFwErHDZAUcURPco0amxuwAZjyv0XJw23+0oTVyFU2oGA25uQYUuf
 2O9dbBHiFtuqkq4F1QBS1vHiOr7XKSDZifE7xbSFNV1i6sYXTHQ6CLyEjAqydFkxsj3u
 bmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377238; x=1783982038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=;
 b=p/pnxxdT6q8QSgzA81B47UkhEi5v1hjrpU0LyMKDRy4+XgT1B4oMTBEia2E7kAFuUb
 RKIfaCZDwTQFgAbJS9UofY6acUS4dHmSW+8kf8CKbjFfgR7eJ2ErsCpPjMoCWAvzFLQY
 eQ4/pX6ThEVZvZ3CBOIYbnYBEeUFiVRDxTXKxMOdVJUWAZYHmp88PHRY4GYsnFP9mu+A
 K5AnwtMtMe9JpWg1UXCUvIaLdlR1/yCVcNHOF9PzIg+vqT2ubZ6pRwC7bBiKyS/tth4F
 uKDwCVw4se5bGxCtZiKyb8apd5sQUkkPsKL0qfgiXnu8T4EAQpqNYAuq7EPqMVXsJnm2
 258w==
X-Gm-Message-State: AOJu0YzAYF75+SqRI6L9yWItcJC+BGOqwt1uWRcik77493YMhNsu5nqo
 pI9OX72WeFEOzkhtFop5TCiYSDM2wyWyJGDs16QRopwpHtS7n+8R/5SgFBS/tOfoYp88VcWIQ0q
 4hksuEOpAL8Zte+USF+8YCPrzVjZemqPvyfRwvxZLoq5AAXfH1DUx/NlrUHjbunFTEg==
X-Gm-Gg: AfdE7cm0BCiGw1DCu/dznn7kLQ0hwjRnuMWDEeoD04aSsABsl9PZhbZKODYqTjh9R3l
 OoI3ahFot8cTiBlnFtE/S9OVH+kUZfsKVaJuQ1mgUnUOZ4LEHwkh+pB6qOOXKHdsYU1Ql1vTkU9
 RD3FxkaEmIGGOnAvE8HgHyBY1gLM4nR0rTQRw/ZeIcPDMteSjtrMrJgUHKsRXIRVRbvZH0aMcUf
 7wnO3ILQfuf9Eh1Y4eRa5STA5mf/eYU0z9QroTJnG8iVwK8PjG79HtoHQzpz8oHSA7pFD+SEl3j
 a0KkwnKDZkodolaaBGWtpad3PItzNT/CYrFfhpTkAV56Vbj6t8s0vM69rrkCKjOWbMgidTfJm/C
 OIj0/T+HaLncAiKFKUs4j1BpG/ZuDcdUqyeI7w3ucyuxkpcT/SFMhe9CiJzM8rTgrGWe8+cNbqi
 UEEVmOpw==
X-Received: by 2002:a05:6a21:a8e:b0:3bf:e2f1:1b17 with SMTP id
 adf61e73a8af0-3c08efa0ea9mr2900344637.50.1783377238281; 
 Mon, 06 Jul 2026 15:33:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8e:b0:3bf:e2f1:1b17 with SMTP id
 adf61e73a8af0-3c08efa0ea9mr2900313637.50.1783377237843; 
 Mon, 06 Jul 2026 15:33:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:33:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/91] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Mon,  6 Jul 2026 15:32:15 -0700
Message-ID: <20260706223343.988769-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iaGzpNed8QObKMbIHkW1cYzQwGel-i9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/dW8tMc3Qdy3
 sNDQS2mzMfaJI8Lr8rIgJzGMkPQJJDM3VGzIdBcZ0qZuXXeDNDpzPI5/A9E6h3R0akMDdlWNYK2
 VvBysGVoOHWHvprbS2FraN2tTcGXaHkfSINBpQLmXnrOjYhZL4todOYbYzpaoig3pd4iv3dCJKw
 w0GnP5RZwZshXKf3sL72nSv6sAd4grWW93qzXnvSM5kX8z6x/je8aGfUtlcyHYJXs8rkogBnAd8
 y6ejAwpMaLRSXvlzW4AWy6amEmsYOFZCU0bQGAoj9dIsE3kNP/LZVcV+ZN/JRYIc6Q+Iqa1NcPz
 6DBgsUjYitBmg3Az8SzGtg3Fxj1ihKL5bM3sDpwkrf2yzgu/pxqv3+qLf6ix/ZjlIiPmb23oEBB
 z4QIkpta9jwxOyvI+qcZR+Spm35i4PLzIgmXQlWAqX9BN8DT5pJshEuJF5SbvimAyZFKAzJic64
 sCIC2F6UpmIMKn0TQag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX7xtubH2HZmaJ
 8Q7p38Wweopq1KR/aptleE/RFS5a3DA+O679GRiIIZAJJpM8Pumn81Pxejpe5G/NoTf3H2gDiLF
 1r6grPvJ93gfgORgniB4Ep+Uma5tquU=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2d57 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KOwsCq-n9oHDdLkyY2IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iaGzpNed8QObKMbIHkW1cYzQwGel-i9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f46983cc76e..6907c2830aa 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -211,7 +211,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.47.3


