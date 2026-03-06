Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A2F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4t-0007XN-93; Fri, 06 Mar 2026 02:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4s-0007X6-G2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:30 -0500
Received: from p-west2-cluster1-host4-snip4-7.eps.apple.com ([57.103.68.80]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4r-00068K-01
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:30 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 07B4218001B0; Fri,  6 Mar 2026 07:58:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783908; x=1775375908;
 bh=piYFY6zwrd04Sa9xxLjLf/dk2zFIxF6bTXzzDY0hs/Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=OxWPslXhlelIOhMpiB1djCIFc+yktjCFcKQnBBYcCzlegJLkfi63j1VktLgEvBlecsMOc2tl9wEmK8b6a87c00+UHryL1/+Yy1HZXG7DUH1CVjpAd/1J44/tDER51gi7MRbI0Oq0M3DK+PozV7ZdjaWEPV38hwwPx24VoIbJlJZ6E4tH3fDsRsI3Jzi42DykW6hkrkLu+Fy6QxKACPJYfOZGIvsj4lPT5fmSNE5Qpr/nmwVnfgzbEaywbRHCyLoB7tMAVeAzbonbjK6OG0e+6udURn8eXlx8G9bFgrEQY+WqNE8SY9Y58RwuKohCvgNOpJadYwfNwDHZh9BbX/cDkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 30993180010E; Fri,  6 Mar 2026 07:58:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 09/17] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  6 Mar 2026 08:57:48 +0100
Message-ID: <20260306075756.88922-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G5016BvUvyBoON6hkDmcxhor1BJEKsFN
X-Authority-Info-Out: v=2.4 cv=PZzyRyhd c=1 sm=1 tr=0 ts=69aa8923
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: G5016BvUvyBoON6hkDmcxhor1BJEKsFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfXx3c2XAwEViBf
 KH+shMLwslYqHF1tZ/8WIxdcu+HgsGQ0A8vmPh8J5e9pvujB/E8kgPxFc0Ccp8naLUrFixMhQqn
 cpyId+IwiaLYvEYc9qZLE57GGlkER6u6/ys/o/I4jdgnrqOHm8SnfzS48NB1TnY8DcAFhaihKOY
 +iu9k6dMKAKjuWSjt8I620+nxbRwsNiGEujFO7CdLplaANdUNMQejtWC5dWJyQUEtFDk8v6fqAN
 iHqTly/Bu2UenHv5gbO/Lhl3km7c7mtdJcH/kUP3cENpJAH0caN71fPF4daK2gveFc7Zg8SXjDS
 fQkPS2A7C0RHXeNbDivi8dniELbbsyVTkRZ7ySDg6NvG6GIzqldg0XmqB25Ylk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=910 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1030 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABNZaAuHdPsO36rx08mQSsWrZICTEESUzjZTc3XLVsAdnLNuXTF8BazbYOatDK5nfV5l8gtd23FWVaXfXv9QcrWoqy9hxzOzT0B3hgKRzrkgKn56b+GygY/JAq4n+ODn6gisX7jD1qUwKuPs2NmUGG/3hFHAl7Il4Zbn1uP5HSgEyTCY9rQbtHLH2liGn/rvSADKtNBhmSroeX3dPZ9bbgQsRCu0yzPuNf+pDuEwtce0iiTTGxQ8Sqlja7c688FOkw2W9rpKGnsTKP2EvvsmNsVlyZ/PLwkv7kSjajSwljbANlLLAI5KF1+BNSghbGHn6aNExttmpuGXNWxReaasryjk5uG9AmxblbNpOfNB7cJkzh89t+OS9AFLalGdVUR2jYXxVqBucYuy3sndSMN9fQDcXKHP9shcEJg2gbzp3QFuvRiN8NAU84N+wVfGI5NX/ele5VCCqVbRqgPf43We9IzUBhvvpzpCGobhjUvZraQZvTHISYNX7WKczrUX07E8UAWaQJZBZTjhvCBZDtagQF0y1UFRv26RxljegiJ74KACPvr3/MFEFtxuq08O7ojsdpwL37GuVjrrmO0+8N7juy/vbCmwQS2Hd6WMHBIfnzQIr0Ah0SA7VfWSVCPBWUv0mFReSAuzZUQdRPnEeeAYHNtTl6buIsgkKNRtj/C6mmEFA2OaBPU5jLes7I+uXTrK4nw6ywl3FhxgDUy1SxksWgIVn7ZfCRqrp+FowCI512qNz5ia6j3gU5mZk=
Received-SPF: pass client-ip=57.103.68.80;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c90124338f..047b3601c9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2334,7 +2334,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.50.1 (Apple Git-155)


