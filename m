Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08A2CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmfP-0007f4-0O; Fri, 16 Oct 2026 14:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmey-0007dB-4C
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmev-0002xQ-KQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5qQ82153852
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Fmoo2AqCklW
 PRSbErIJkWPctmc/1mRQ78pftTrEVuC4=; b=dkK+DEGaxv0g1RrymGcp2pf9zci
 lH8Odnmk6f2O+26Drbh1OBlNcY99SXvfLe+f5JpliGTP7lcYFqaAMXDIeZ/tRvEQ
 B5/GEcjCocyJAG7kq1y5YcXIG2tpMdZ4HX+nY1niqtZBArS5Vu7cLrTFUlc5FKGq
 L3RfJLTneSvCfXNgTjiLgszfFgw4ju0tMa1xspKdDsHFU2HOrhHTmqBDfd5BnEdn
 RGdlUJ+aMDSLmsj2G75vpL50tqINqmiyvErhBjL10FCVA/+/mGw8xMMTb5PS0F4e
 DR3cG4WH+Lv7Y8wieYVACJNVorpOgk8BIX6sD4ldsYSv0AgTsue45n4bL4g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumsue9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1259663a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175280; x=1792780080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fmoo2AqCklWPRSbErIJkWPctmc/1mRQ78pftTrEVuC4=;
 b=CfqHUWnk4Y/2OGK0mguEM+r1UtgSP1+bfZ1uls0nrM4N7oYq8hO0ilRzfFJi8S81uR
 O5RLdsvfBwTSn0++qK0k2Rg6mvYPOVxG4cIIY88q8N3mhSR0tCFF+21Ox0rUD/w1hQxa
 45ANTpdnevUQ7MoMPqPvbd+La5DYyLdTemDbKOxP5YtT6gDN3EPKT7YbfJ2e0vn/ayiV
 qyTiUQmnsdJWxdn756qpEE2Q5PaUk2DZRSGeA/zUbppIXMtxddN3V+TfEcXGVwTMidpy
 GOuvOUxf71ye4LVCUOmUc/vXzXRE30u+VgpbNF1+K03sP1MjNYnoe22Bb2lf8slf8pot
 mF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175280; x=1792780080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fmoo2AqCklWPRSbErIJkWPctmc/1mRQ78pftTrEVuC4=;
 b=HAY9afxZN4/JkNdjeOhXRqo/qKgGXtvOxuny5hCOZEVwONBKwUw8jmg9XzrP2v7j0V
 S4h3BDkff7N37yu5e28QE/DWpejnNMY3+JqN8S2rcx2whIwEY46q/juwJjZO3YopQ7ms
 nRYOPqeZlPY19rdiWoGVrtsgftJW5/V5ELeCrDw8E45EiddoBK5C7eEQ7dvzfe5y1UqV
 Nleug9hJcoLyybXd+cPRa9ZGwi+etvoJrHdDbRSljhci5wY8wLrWC4V6CMArnu6H8MX9
 /5LvHj9ZAkBzbvu2qivUgqY7DoCPLWxQcR2yTcI4CFETOBE9bssOQ1NB58kGxSJfizjN
 J/SQ==
X-Gm-Message-State: AFq9FYIlUFsqAbX/l1fXK4LpQg3+2vDcRN1wD5j2C8hXhD0cuaQ3FKZk
 Ib7NARYAP+VNLL5d3Sj4zA4UNYjDPUq0aNeFdd9MhLDqEbAzmtV3LrqJ9W4EDKe/xamQz4eDoRo
 8XYwCI4Pb1SSiumGTcW9EPKR3tPcbxBT4ktIgOnEYO1Ao1P6sKJZMaZNu3Nt8j9X+Zw==
X-Gm-Gg: AYBFou0GbLDhLiLFus7TOG72fqZ/9u3Ui8ir/9oIylZjgpbcOxAdENyTShhYoHkxs4f
 /Fn14x316wjqDYbnwgSBjEy2Ij7q6/VC4tQusEdIZ2XLaCK394x1kozc83t41ZC4/uZvmrj4173
 snCFlVY/ZzrhBT3AI9tZ/e+f3IzYEX0d/xQEg762IOfJN8pde5Rs4vZR1G2e4d2W9c16mgsFM+/
 vSrtDUXwFbvz+2ZmMyebItWp/Jl8V4wqN4s3bGzvBY9X9SH5cE1u0FlL0TxUR5j5KrggAbqSOX6
 SoYNfU5jRsD/lMFh4Bu+kXrucs+XffD/wbEJYELNu8ohP2N4cmGAAfzJXpQeUTe8OxuuVx4+VwU
 QVAA64gzhzoLU8rz2APXGOtFznGRfvKCRqDwCpIk8L1JAStPGvEMPHp9FRNxJisg=
X-Received: by 2002:a17:90b:1a92:b0:3a8:c3b9:4b38 with SMTP id
 98e67ed59e1d1-3acbb87b554mr3335239a91.14.1792175279742; 
 Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1a92:b0:3a8:c3b9:4b38 with SMTP id
 98e67ed59e1d1-3acbb87b554mr3335217a91.14.1792175279260; 
 Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/6] target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
 targets
Date: Fri, 16 Oct 2026 11:27:50 -0700
Message-ID: <20261016182751.264704-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX9aDStljc3EzU
 wKzzHsYUDZULhA1XHwshQ9T5ey21hbwRieo7a7saX1kzSX6t0ZiP9lylQduYBMGXjyDrdFsEots
 XwnDDo3cvYyWAmus/D93eLKCZY5Bd8E=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad26cb0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=DwCSbAth9W79kPmtiZMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: nDfydzwEW4S58z_4l168BlpELiJ8cg7l
X-Proofpoint-ORIG-GUID: nDfydzwEW4S58z_4l168BlpELiJ8cg7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX9owT3XavLKV7
 py+PcwahXAkKthvIvk8wjvimzS1nXJmZUgasRbWkqSGDgsDgZoa4ba0c1pXaW1/HSGnCPh1xiJR
 LVGbfPkyuT7r8PUivLrAE6JKzSkUA2meFpAo9XDWp4k6yzsgLTxS2M6Z+1XbfXPOSRXUWPCGGhw
 E0vn2Yzpo5xlJ885mvq5XeXze6uWdKNGB94VJT8VvWa/RpcoiA7/sQ2H0ooTJT8mrCv9rVOdVrn
 UhHmoqtB9kGPeaObFXoZONs8Ivccqd36iZHpPnbx6ixGl5qY8lK98OJnQgTfEg7S0lljRty60fA
 Zgp+SyKORQCbjuCR9vxoeKHhmVyq/XFFnwITgtA2fxQTQ5Rd2qMx3/wR5VujhVF6jlbR5RGEGz0
 S+Pn61hQ4fqtQwE56yGQKsUAlrbaIDKYreFU8S+IkC2LT6LHscsHTqOShEreBsEHVAO3qqMltld
 fXk1JlZw0Tz2ZaB2qOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
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

$ ./build/tests/unit/test-multi-target
Type 'tcg-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
Aborted

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Multi-target test takes the first target available, which is not
riscv in current state.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e07ca95e49b..be913602489 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1749,6 +1749,7 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
+    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.47.3


