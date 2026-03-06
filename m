Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE5F513F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdx-0005tk-DH; Thu, 05 Mar 2026 23:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdw-0005qN-DP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:28 -0500
Received: from p-west2-cluster5-host2-snip4-6.eps.apple.com ([57.103.71.119]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdo-0002VY-PN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:22 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 834A31800568; Fri,  6 Mar 2026 04:18:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770699; x=1775362699;
 bh=T09YaB2jPYeKCsoJalctReTDeuCKV9icg1YoMmiUMB4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ZQqbGcuV5ZkdGrIeH9KQv/Hqgt79bkoOz4UZNNyLYqjDdLl5EMwJ1eTxwnjlCRzir/Svmt2cW9oU3jf8jjhzRDqiJMACqCpPbB25QJ+fa+iCVPedCCaYOMHXt6pnA3H5Xszcbwt34xzLr1rQyHvi+RgsnXMnIUj91BN6ZCmD0g3fI/c7Qk5mk57P8tvQ8a6CgpzVoHDwj3q5BgbHSGwSyu6VQgoU5yRJPZD+doEGfbips7wZzCT3FDKYEAqX4a5mvlN++rm2JPtWO3yYgsGSuGsmWOSCKclsbyQ0sfGN57SkbpaqItVD3sMIcucyTsjEWR0qaxF0vz0pmA2htq9/ug==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 5876F180054A; Fri,  6 Mar 2026 04:18:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 11/15] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 05:17:42 +0100
Message-ID: <20260306041747.54554-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fuLRpV4f c=1 sm=1 tr=0 ts=69aa558b
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX4eKFxvPUhjBx
 JHFZ4YW31dopNcGXJ3r/EpFxbMma3IQMP9e9Z6VOahYcpoOZu7E8ZXrIG/1QZeRpGWHE4vugBKR
 gw+TLoHcrLVZZejpm38+WU/ixM5wwV4E1ctnaMltbl+c2u2sI1znjNmQs1IrjAqoF0yG47J19DM
 WFRQUUFwpaVZu6TxJLG7IM/jZJuU7UcyJgDc4Qe09/09s1/ZoSDCEYVTuiaYy1URXSbnZHnZq5v
 JzYA9668aL1ePj8dyBB/evrb1wmMFNcbSL3LkXkhxwM4PxaVJxPlkAOU+KTGroTrzPrqyxQFSL7
 qc2Dn7vceGqWOrAzSDV7gRxHGBQElm1rwHAPfwPngxM53oTt5xSeP7wVjDBuJc=
X-Proofpoint-GUID: Wx6zHWv9wrv4H-eBSfl6sA44u-qHTMm6
X-Proofpoint-ORIG-GUID: Wx6zHWv9wrv4H-eBSfl6sA44u-qHTMm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=540 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABEbFGoFqs3JSn8btZloiwdjCgz+3XuFvh8r1eUKExBJb9aZfPX9MzZggZkEpWkaH0wjyvJzQ78edISGyJPEBPUMo7XZDztP5Ur+ERogyx/1GFu0vLzQN6j23p05RiFp4EVCk/dGi5Ja0jzTNahIsb1usIekGBWxSqhBa0fnwdC7QFOyB9rbZirU/bwNJLGwxlHmDlau/0wQJ1TxXQeSHzTOeq3e5XxzjaLo4JWUJE6cKGaqwScX5RuMrMY3losLYBME1tXBgKb/o+eosRwtLZBHc+zhRPzq3p7vPzRX7oLZwD3v5Q7Thx6SNb2at9r76aAzsspAwLMJeVqBWYgV7ryUVun86wz28HN8z9GY1Dm25nzDPTBScAtLH/V6gudie4HNgKSaoITQHrl13fEAMuhTmXI802x+aoZqHcqZxehthnoFeaxU1MzGX3xyxmY/VLjGWuGMlMIpc2kkRD7zVxbO5q7fIChGgw+jV2ku37yWAo90BTguCn9oOvY+32IZq/HxH2RPZ9XrB4iD54HPMKA+m18jWc1FGpUSui9BsrglBW6cD2Qc1WmS0+qRmEeP/lXHu3Ovl3Uv59w3T14+uUBmr1ZljcdrOQ2P5hjur/MXoC1GC56SYzCahvt1J7Z1zQoSV8tmepF345PxeQm3fCJVxrX326eBhQh+D3+oYOPGEte9jCG+AGwQuLixMngTW0G3KML3+ZKILYn5D0Y4H9yxj7Ie4976CATsH043+lAWgq1w==
Received-SPF: pass client-ip=57.103.71.119;
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 212efab731..0c96119ab9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1647,6 +1647,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1937,6 +1938,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2344,6 +2346,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


