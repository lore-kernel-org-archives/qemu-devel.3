Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45004F0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQcS-0000z8-GD; Fri, 06 Mar 2026 03:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbF-0007Id-IT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:02 -0500
Received: from p-west2-cluster1-host4-snip4-2.eps.apple.com ([57.103.68.75]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQb9-0002Uq-IZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:54 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 698EE18003F9; Fri,  6 Mar 2026 08:31:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785908; x=1775377908;
 bh=piYFY6zwrd04Sa9xxLjLf/dk2zFIxF6bTXzzDY0hs/Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=SnLuLmJjdk8Hec2yCLCf6aY2OBzmu9KJDWWFu71UxLfmT7BQp1jsoml7EYDpHZScSobQe1AQzy3lqRO+Dnks3S2jRjXTPqpdeRwx3FF1NqAXcofu4YgI94cBroBdKkj/TpDZEkTlNEqxzsldu19BUljXlmNyd/4TaUlrsnQKIy7cJQVBlhgSdjRJ5NCJ7HEYQ5LlEf07q8bocuQstw6cCRYn1VhiJQOQL5ZkpeIxzhbMfyu+Ub3AViq6L7qZ8HvbQ2HEgdu2gSh46FypnLU6NOqpChIHZKizJ8iD1vlOIvl0Bps2SHZ0+pg1fYQzzi2qctuFCwCCEebJhhoIDpoaEQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 EDDE918001B2; Fri,  6 Mar 2026 08:31:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 11/19] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  6 Mar 2026 09:31:05 +0100
Message-ID: <20260306083113.74177-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=T7iBjvKQ c=1 sm=1 tr=0 ts=69aa90f3
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _nvqsJzaQ0smbBP5-os_ORlCfmwoJiUR
X-Proofpoint-ORIG-GUID: _nvqsJzaQ0smbBP5-os_ORlCfmwoJiUR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX5l7Qsor25inf
 a2i2SOH4ZlCB4RK81py6G2ZMDlGPMMJLJ63xkbiMEr76uBJeM+g/JpLv796fdcjcJK1suqNqW2g
 5XV6cgqaNIZCcK7ANFJs9RNO3w9oCGgAX/MoTR6hE/4XHwWc4DPWE+e03jqIjvZ2F6IgCsy0f4f
 p5f0U1S3DLXgSxTick9nzcFTjAekwsnf672jYTsxnpflYtyjRvvBYQqDWYcHDyvDveB6CdiEqGK
 9bS/wCn7srLPNoZaA0VOB7UBAB2+3iaOSDuKtS1sl90NcU3NrUskbgJ7PNi3svpZWfKkWRqNawe
 1AQ283a7Okl//a7DNal0zHIkUKw522Y/Ns7RurwCQWmrw1+s4JvJ0X5WQJu99w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=905 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABr494RXl3VxSkM5o3bKsvs7pYCNXGBl8pyxQTcP4d2N1sAR7P6AEm4i46ZzwQad0IuHgZRvBXYldrAY3wSunmTFlyLP75XOchrs0YI9S0Q1a9wZkv1ONgbIHMeJYbRJPbOWLn5nuAgvzA1Yhv8pq95GnERJDDYK1ipELxVfPvxjySSebeDYwjyc5QxXV9fbOmwnlff8rtbmyVcDClx+m7obowKLon8C8MQUAoB2wA/0SoeYwLnyoNdnjskS0HRBIgrSSSQe8w1rqGXvEG+LeSGfx+ZSh7tY6TqyYh+SoNHREOcbFlQYGvukt5qrlzakhLD4I+xusts2d63jvaRlJnKzYlT3BLKJ73+EyNz4w3Dqwr+juPOdaIPL93J0FVOt2mVJQhV6qDXxG/mi5KucoSDVvrGOPbxPTqiJ4WlemO8OyFTr+g/y5/kc4LFSP4XM5rSfQt9HZkZE5cf9Y8Z5oyne6trIZ/Fyx43+pcbUX2yxE92A/S02jsfiRm1vazm4v5jD2E9O5zMRO8/uYfcCV2ewMdMA5xXpsbc9BQ/hTKg5TxtK7WXdimz/VF4wykINJmZj621JZvrOKdD2+9CKfA1k+rcaLNJZsQfSpMK0ekqz1VTqosDEczgsylflXa/NN8S2eTioIvdnx5c4D6aHUq1QE27SrmCmIOkm+u9Bvm6yoB4ZvwhcbV9W6vSrmEQ0VAJpWyAG9Ey2TJ1DBc0QJQAeOO4kZhW7ks/SyIMvKXhbdN+fh4fCPnD5N9dnW3RVxC6XaY2W4eS96T4A==
Received-SPF: pass client-ip=57.103.68.75;
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


