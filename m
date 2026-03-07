Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB93F55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0R-00022L-RY; Sat, 07 Mar 2026 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0O-0001nG-BY
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:00 -0500
Received: from p-west2-cluster4-host6-snip4-3.eps.apple.com ([57.103.69.164]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0M-0003Wt-Uz
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:00 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 03220180062A; Sat,  7 Mar 2026 18:03:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906638; x=1775498638;
 bh=sRTxu5Fw8UCuti2v1JoZDXJD4wZeEKjL5lX/8pIOKiM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cLDq2l7Npq9QBqV9W+fC7RFWrfizqKKDBOv9g1n0/+YGyR0EwSfaDU1UrIUmUd3dF/RasfHA5DZXgD9PErkAUbFwY2p/ijlalVwnWG+vjOeZ4+HmLf5RG9MlI7fhY5otDfb2PeL+5HJCG7dIDV4Hi+Ci7UnQLVqcqivcHRaBrxl1RmcFjeSSqJE7ucawNZoz4szlGqCX5CtVAcHEz0iWBAG5ZKXAwgHf9EriDFYiJuswD7j/WX/L3jtH52NPhyvFAx2n9oHRIhIB9Lnnvp1Dlo/BmepuC1IQvhhgJAmRQD3qPRP6HuvsbbDT/1DGzPZenRVvnLDetWx8Wy0Q0NYVxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 8D2A91800E33; Sat,  7 Mar 2026 18:03:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v19 09/13] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Sat,  7 Mar 2026 19:03:26 +0100
Message-ID: <20260307180330.75168-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0ai9M95ufBgUv7l8GQp2MEgzdqj8eXyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX5OPBgFaXZ/D6
 C/cQRJwkDs/dry+BlbsRORqy5CNxcLPwaPLJBGdvt+R1Y5Y3JdW3V87tCqWexaAvv/z28CnYk8A
 Mgm38+7jmY8vgCNHdZxIJBAd0fQAEUTWw9tOKk1S1rF/73IHU8+rA/fh+JLoyZJNTg4t2wqBXfr
 KdqwEr+0QsSBdOqVJA9Rn+VMH15hwwK29/A870HRHjhdXQDFJJW4LsVJswUAxMAz1527blUYz3w
 u9wPaTf9i75bs1/ITK17bnFKSlIvDOTJMZs4MjEl/+F+kLmzc0OLqURPjrehU5VY36945bAjXB4
 xRmbJ5RfCKWAEmBMs1ajtDOqbBDgLOHB78iKscsTrGLbRaD+ghCcRzcEegFWbk=
X-Authority-Info-Out: v=2.4 cv=FcI6BZ+6 c=1 sm=1 tr=0 ts=69ac688d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0ai9M95ufBgUv7l8GQp2MEgzdqj8eXyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=526 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABnsai4jptEjuLRcAf8V8YqNyfQAUnY0FbuuEyUxIe5vmCRhg+typbrJk7gSJJxzrkPfzjHc4uwdY8Bm9Yie1QAfqxkG7hl0vTXs2WgdVZFrT23a4wYMZPPDVhCWa6zqHNq2Ns74F9/y+ZFxUYYVW+LDxRnDfgGt6hdQx8QmrAWKgPgKVXKAEdV4GWNw+p8fv+DZzN+v1ydSBXrJuwPHXbHCu+pwkR1tcLwbsvD/UBf2rrxQENoWq6iXOEavUMoTIiMGE4eLwenN3bRtG/1+TnscdufjHfclBi0xGJ0upHDq1lvT0dM9GtaUrVUT1V015s/Dgv3kcsAldtFIyphdEb3tBLqO+gJLnD6d1T7gt1hivPunqm5tlgQEVQ7vxS/h+KvUThsegDwHP4S/47ODaunXxfDUEEemo5/eUD+5fsMjieW9gGxopR7tQWbnKA5uRU1y3hOPkLTj5qT2dNSMC0stNEcmZF1vv9wkRAQefbWxeEWey12nH+wB+Tq8tUspOuRQH7xZPxj3V6sjekllw+K+znylSbQf26OGwSFlkGfCV5e5ALpchdDHfRsPssdt8qlQQvY+yS2Djb4FNaK3UcF6mrS+E5h3LakR9YJbIDr5Afx3TMjUMAuELs24rIwzUfB+wdwank5j+y/4pdAIi/d2DbBBR3EJPT7G8W2hSh+C2+OjgwbzGh7Ua0MjvaUcg3HKqMgMAJAbEpI5APaMlwBQb/ZUm3CHILXtThKB1IQYisWJDgTb6U4XDV
Received-SPF: pass client-ip=57.103.69.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8c568d60bd..fe5a376aee 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1681,6 +1681,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1971,6 +1972,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2378,6 +2380,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


