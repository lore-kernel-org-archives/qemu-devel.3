Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5A1D2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4x-0000ss-Fr; Tue, 27 Jan 2026 13:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4f-0000TY-B7
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:02 -0500
Received: from p-east2-cluster6-host12-snip4-10.eps.apple.com ([57.103.76.251]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4X-0007dq-6i
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:56 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 0CA3618012CD; Tue, 27 Jan 2026 18:45:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539546; x=1772131546;
 bh=AgHjuAWT24LVcmNDUBGquSAcsj+ZgzEt7b/O22tXZvg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hy6Q37i6dtklSBEu9eNISTf2o92ctSOmk8yB8/xdm3wLciZdSUAzYGe5YpKZpiSsW5g+du2m+UEVFCWx2YWfWGIeB3M2BR0CekhXi8GRqqFx8ZjUspesMBlxwzt1wXU7dgVofEj6qoPS6idq2aY7oynC7tHtTU4yT1tevvgQKu7G80I8mHNOOWqwTnCmxIVJHfrCGGvkFGY94MeieTDI4TuekQw69x/NnvENRVAn/qhJ2EI1g6k+a6HPg0tJhzQK3ScpC0b4NvJtScgTrMuKs2LCTGbwbXH/tnGuUbLWvyudR6z1CFiHmzY/oS7pT1FY35g/dA3zQPhHr+gfkxtqOw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 AD54918000BF; Tue, 27 Jan 2026 18:45:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 09/12] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Tue, 27 Jan 2026 19:45:20 +0100
Message-ID: <20260127184523.5357-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX8OErG9yO0ZZm
 k+yzGNVzs5p7RawkdM4xvo8+F3o/UBkurIJyXVInBow2QZoEQIRmBF/mTA0+Y+P1xarpbZz1u2Y
 NJoqz2YsqZscVcMnvIjp+nLQncR9sItPvx+wJgRG0RQuW/8gx39Zom0550emAVZqMWyrD7F6lMp
 VHVLrm+2eqvovdQLwYUWoEkcai10FI+1c7x7pxYu+2NcjcqHuelw3opftLAu+QiuP0BwEKOs/yN
 IYtWNLr0iffhcBmkLqCxFREuA1Ub4j8CpHU7zw7cnvUcSO9fjrE/EErC1jHiauI+oUmyZlaZ7VC
 4RoWNLUlAc4gXFcJRGHymwmafIqdmf9SJMGH12KWCHSrCFMFZ/jeBjggOPdBLs=
X-Proofpoint-GUID: MtgpCHzZHzvcC3eJ0wAIEooo8GHBJuTf
X-Authority-Info-Out: v=2.4 cv=R8kO2NRX c=1 sm=1 tr=0 ts=697907d8
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vbFX7M0ab_H1AmF9bzsA:9
X-Proofpoint-ORIG-GUID: MtgpCHzZHzvcC3eJ0wAIEooo8GHBJuTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1030 mlxlogscore=520
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAAB7m/x1x/7lUgL0TA1+6+/Sz3fmBgCvyu7mtWkjY5GKBu9Ei9VgZpDgUi17G/BcbA++aj1C8KrppdcnWMRwWJA2TLO8g6TjFLfsi2x/M5JV+gyFOBwdjIuZW89L49hVqmh4eFCoWseHb54Q9Po16XyIUTnsOmkVoFSbnP/+yYu0zNe1i/N3oY7QqC/XnVRFqRMcTU1VOKV90Nz1g9cHhtoOcWsHKETrFfM+SWHB6PTNxXKd4Vi7jWLd9ijgIc6sMppHjOrTZkaVjYgpjUs4zzhVl8ZdibtA5WBPnSO58Pm9/OHJferyEtfLAliVIwpr6cdqjqzZRkUxXRSZw7kgCYmNUimGge6gpfuAOjkgvzrseaDY+NORg78M0uDMLwvd7DcBmkvKx3Xk4AMyetbo8rqr3TTdziJX5mIemyg1joCQujoSHeZSOLP4SyWN9Ra/ioKY+em/5UTDskgJEmFJMhkHB5jajY87RfXtVnO2zFNdKYM0CRxy842SAwtYOxIJ35yjhUezUriauGd5i3+vjjlTuxzvZnxtDoxyr9OpDFztHtDHDSZoeMiarGmdFIJcHrFBP0/At86O6M0gn47dqEf6EBoVkGdp6h4JS21hWxRMjxLNB8iigU5knm70W5TWtggYgRALrEa79ttthrLMsB5ttYACZrtDyw7KykxDM1NPGOxhypTp5DsJOEFnbypDdkxDjsfIe+iUxj3XkpwGg==
Received-SPF: pass client-ip=57.103.76.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7701d250fa..4ecd8907df 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1334,6 +1334,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1655,6 +1656,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2062,6 +2064,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


