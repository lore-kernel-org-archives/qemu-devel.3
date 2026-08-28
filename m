Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C75C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mp-0007Oc-Oj; Fri, 28 Aug 2026 16:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mo-0007ON-Sy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mm-0006Xs-Ug
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7OMZ3675418
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1s0P5B2MvNt
 k9EcRSkCNojw71UYquf0FvtqslxyUh4o=; b=IABFpI4Gs85wc19J50jzxfZYAiD
 CeLgELqtWaiIwVOms2vXH6HFtoafjttxkMB3Aw7LDlEA+xF7UrZGSP5iU2O566+5
 Ct+M6b/MD4CzVMH2NZaPa4ZbPDE+AWrDi7OJmNdCEme1ij2tdZUwDp+nKzrwW0XQ
 3c3blHFLc5ldotGA/TmWzyEN2tm5mZuVHXeMAusGLX2BogdQzlD4rlXM7Xm9kqeC
 KSe3ij6YMxuZfb86eAaxPRaAaENt0PUHDjExbxujMvi46Y2gCifHtnfeUzPiQcGk
 yK3UEebsM7bFwIpAxwKh+Qh8D2TZmtiOVKHOrLZWpnF2yFY5lV6AqW9cMzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs3jj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93918756165so238891085a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949589; x=1788554389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1s0P5B2MvNtk9EcRSkCNojw71UYquf0FvtqslxyUh4o=;
 b=PIHZtRavl1jwRJsIAAkGuKia8FWoUAAFsiCJT8M7SSRU0Wa3h0YswHISxLSrQqk6zf
 01hZhzKDLfTtb3HbcEgCXvdv2MyuZGV5/SpxtlaKlN5+GW8Vc2Uqr+CqPUGtDRA56TbP
 oES9ULyktSlPs0Cx1+fY0w9IRV3+U1grgDdJeLYOLQKn5lBNyTGn2KmUzdtnWnmY6e4Y
 L3bJkOMQRwRNOhxZVw2puPznZNJ3SFiZFWBlATEyAi+XZFbw4opirLtRs0l5xJKzobre
 F1T1w+LN0TL+u3oBmsgh7P4aBhQOvyPgGDB/ZIREeCfXLkOk6Pqu4st36scyyiNzOh1l
 q31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949589; x=1788554389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1s0P5B2MvNtk9EcRSkCNojw71UYquf0FvtqslxyUh4o=;
 b=cYJIagknkk76/JkC8MZMiGA4V4FW/cd92yv8xEj1mRGn8bUqrXs9a8Dl/ZZbRrL/xJ
 Xwx23VZgc66hMN7bA88APywjLSrra8/Xmj/YN+FFsR5XpkMcLbsj1EMQampDfdwX5RdT
 pOeGdmLh+2v8hP1zR5paxkWpJnId/lObiQtth/JWUzF4z/+1do5EWDUeZs5SzZbreEUJ
 Gnn13JoOvqrDKQlptOQIll33RspnnXfneitHNVUwtl3e4F/Lo1GKdN0FHFQp+10iBm3F
 e8hxqYuzyx/IFEqpLcF115/jKd60ADzK2ZX79K5MQ8XsbbctvswbH0zpE6R8sDqCl3N3
 5Syw==
X-Gm-Message-State: AFuF++kw7V5JJHFhRiCMvY24+fL8pHQPqkevUsk0YddnQ2Bx3GYWZJ89
 bCapT0w11KMYSxMVUS43sKKuOC3Gg+1P8OweY4sSBf6/Y3HvSTgYTtL3aTdKCtBGOCrbgtEFQJ3
 tq+8uGYoRu12hMYtv0RxyZ8rPI1bQpnx6jd/Wje0gNm98jdQgxW6KZkzs2IZY2l0nrw==
X-Gm-Gg: AR+sD12BElU4tntFYC4X71KNcVQCmELdgI745XWj3TL0RgDUx8ddq2l4mmjXrwHPXeN
 oLsehsi9qrUR6FQSPzzu5C8IawtKRe+wfb/G5IE8K139SF/dQyrzET1/zfJK/xfsHwSTxXgJaZt
 fiLU2rCh9QsJe/S7dTCXFPPdIBWlkCZROYde/yoP3kZl+jKlB1/ERM3v5DG5QHm1Y8JbPTR9fIu
 GP4lI3PYoK8KzIJ41Yie9uqbL+jNVAapxkLrVxWh4I5S7seL2300ZLyC4slbwjan/vayYyLD87j
 qpXn8KkKPolYC3likv7RzhVGdYHB+VZe9JYVPtQLR5IEWMkhljqvOq2RffYEVZVROtaIA6S14r5
 VSLvxbLbAeqOP8g2AdR2p7MlK/vwEUtCjo2y6JQ==
X-Received: by 2002:a05:620a:4555:b0:92e:4927:2002 with SMTP id
 af79cd13be357-9391392b9ffmr1174106585a.39.1787949589420; 
 Fri, 28 Aug 2026 13:39:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:92e:4927:2002 with SMTP id
 af79cd13be357-9391392b9ffmr1174100585a.39.1787949588872; 
 Fri, 28 Aug 2026 13:39:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Date: Fri, 28 Aug 2026 17:39:10 -0300
Message-ID: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a91f216 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=kzI3X2J7bCQCYuGL4vkA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX5L/7PR1ikE+k
 N14Ddxo5aTYgoyH031yv80yJYQPdGccS7RJq7cmj4v+3AW6mv7jZ+AB1F7eeNoHbPIu2O5URy4X
 hHIlFTcH9MqEK1cMGWBZPh/GuEs4WUpDflT4GsMwJXTnPmddQWOEoCM+xbiv1ZX5AA5oJ4HRWi9
 colAkQ2MYNkkzuN3f3i0AaXKU0auuh6Vnotv7DNSiAOWexKswDC4Z0G9/NrsCLQWvrIOstPTIA0
 S+9ZetVO30i36Q4C7oEjMR6qeOadiCacdtWfZx03eLpaA6rpSvouVrVx85EPUZh25vvdf//avFy
 TeRgAKuPOhyAfR5/NZiDGMtMrjSQZpbjZTUUNyp0WcmpDe+uQoQ7eidD33M8c/rWasEFzz+l/8a
 2Fw+guK2ayFBXCw7rqhRHo101DaeDtPG0qB1a7TsGLPmCTyaZHR5DR6eRoEPhG1Tu63Qt94KRbd
 4ADuW8nvH/LAJbX58Sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX5DPHpZmy6An1
 jh++UwBkuGHvF20CMgMLx08HJTTnx00N6R31k80cV5C9T5VpWv28SN0zx8JUpuIYLwFjOq7Ahoc
 aVxlC9U//AawlDOZmTHq45mv843fWUg=
X-Proofpoint-GUID: 7RaXM7rnl251-K6rrkkTBtfP2vNHTYDb
X-Proofpoint-ORIG-GUID: 7RaXM7rnl251-K6rrkkTBtfP2vNHTYDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Running 'dtc' to generate a readable fdt for the virt machine produce
warnings:

 $ dtc -I dtb -O dts virt.dtb > virt.dts
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"

This happens because the 'reg' field does not match the address in the
nodename.  The right fix, pointed out by Chao in [1], is to make the
nodename match the reg value:

"In the current QEMU implement, `addr` is the MTIMECMP base address,
while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."

In other words, the 'reg' value is correct but the nodename isn't.

We'll make the fix now, allowing the next patch to move the fixed version
of aclint FDT to fdt-common.

[1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/

Cc: qemu-stable@nongnu.org
Suggested-by: Chao Liu <chao.liu@processmission.com>
Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a6ec9def16..83a4b7710d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
                (s->memmap[VIRT_CLINT].size * socket);
         size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
     }
-    name = g_strdup_printf("/soc/mtimer@%lx", addr);
+    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
+                           addr + RISCV_ACLINT_DEFAULT_MTIME);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "riscv,aclint-mtimer");
-- 
2.43.0


