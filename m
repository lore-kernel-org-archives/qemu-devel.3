Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B0CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkOX-0001XP-OL; Mon, 22 Jun 2026 15:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOG-0001Hy-Pk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOF-0001ug-CD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXVaf1647501
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aSo2kC2MH7h
 pLxfCMiCuwltWVVJs8yBNERrFBxnLqA4=; b=klSavXZ1HesCnmT+jx/BPtG+a+/
 jS2ayw7tEiuZXm+DLL/ndX9U30vbH24Z7pldK/dFG9AyTs2Tb1IZRozM0eQJ7Eg5
 BhKxRgVm68gkhXUJvZM2Zv4L1PgosbDLH4fprliQJVms3EZ3fC5OiKXGfwhHAIzz
 oCta56X66w6A0ohdKC8km1jI2NQdtxpGecG0/sKccEqwezhUd3bYjrFkgbQbAScE
 4KL3oAZv8LF4t+9H/8wtB4e9a4L3TdNjc0aBw77rxN0Mkq4pgoZn7RkKmv/Be1NP
 Eoawt6lqpAtWzQGPRFezjrzj4NGClGQFFB09d7cQEFoyzQFd3Y9ZMGQcdjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h9yc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91598af506cso461011785a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156771; x=1782761571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSo2kC2MH7hpLxfCMiCuwltWVVJs8yBNERrFBxnLqA4=;
 b=dPq6db4CvXHVDpdk4crFdVZEhQZG7/juaLkVSoTdHWstlrKEdMueDkXnLAlAJDZCA5
 jXxf7Fbu2ckT3FNim4OIZLmn1qysbOK3uXXyT69xVlIG8WvvFkW+DtgUAEgcNh2X8BNp
 JlSor7R9kDPvsZniKI6PE9ilKIK2nySfQ5B+rROO2jD/+ZKeSStxG3OwQAfdFQVcgdod
 hIt6jJYDlFUmNC2iyeI1MAYAx07+V++m597RrS9VsC9SybB22F+c142A7ECSY/LCgF8q
 8ZkcK4Iaig2DakjQM9XDMvF/kPO1FUOcS5JOXYUr3NcE+c7zsYRWjHpayfBIof17g1n6
 268w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156771; x=1782761571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aSo2kC2MH7hpLxfCMiCuwltWVVJs8yBNERrFBxnLqA4=;
 b=YQ12GrNYrBfNmfDfDfaN9sffdB6gtrsVPDrfcYyNfLLAc/GrXe8CZs/oANEcJSCSrC
 iurnSddTJCbbg4FBK6WPUplsy2fsbMC+Pjz2JOpUvmHASAZDUqJK00Ww0SWESD7NzyOb
 o8BZXz2agkL7FzmclSI+1xj7TzQ9IvWkmEbF5g64M8mW/oJiGuvpD137T8S28Ye2Ten9
 BlE1krHCcnB0K1tcD5KfqKFUEVUCbmoT81srKDyOH9zan4xu8Ydqbk7yzAJVziycwhIu
 klsecb/e8/J8CwhuzqA47m8mqZjIjBPpesL51lRPrvwE9PvC6ifkbUINkdmK+IgFJf8O
 fixg==
X-Gm-Message-State: AOJu0Yy5hzS6WIpbni8ZwSZBoQf34q0Uy4Xemg6wq6e0NxV/2nCJKg3D
 HCsToNT6/517ZEI/T5KoBFOPcze2seVg/oM1l6ZPiegeYPTRikcynnuEUa6CaBZdwMFqhQa7Lu5
 cOlwEVSHg1HuzgnQ0NUUqVxWaLL7CQ3eyuDQzhLgEIVs2NnSqg9kyd/Y/zmxXbHZ2tA==
X-Gm-Gg: AfdE7cnucDSaYpQ1dr2H17Um4mDgyqwLu9TUcL7r08iYHWbbzAjdWKl8eZamal/LlVS
 uq7nwjS6DrzCz/fLDtUt30k1PnD1E9ji+S+7iFCkDnWhlYrszGXlV5QV3l7heWH3jobaPKoJAsE
 xhqFD8VKlp4gYy2OllxmQa342iwsqq+poP5CEvZz9iHJMkCI7uBRhxCj4y/dtjJLa5JVY5Jyh6u
 P91zLYOy7LEhaTkULrdZIj+Ejc95GwtMe4wK8wYDVpImBlu7ULdt/XHhftSfXM3Cge2NMZnapyl
 S0uwO+WvOFJvua/HnDw/MJkOt5NUAYm7I0VeFJRDy4LBjFCZI63+Bvr5jdkmiXDyHsXX4LnZ+03
 031gtC7ieHhhidsdM5komrSMNb41bDcozJ0mb4Ma6YF6bxQ==
X-Received: by 2002:a05:620a:2947:b0:915:a101:48d with SMTP id
 af79cd13be357-9208ddc3d63mr2663183485a.56.1782156771027; 
 Mon, 22 Jun 2026 12:32:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2947:b0:915:a101:48d with SMTP id
 af79cd13be357-9208ddc3d63mr2663176085a.56.1782156770516; 
 Mon, 22 Jun 2026 12:32:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:50 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 21/24] target/riscv/tcg: remove unused riscv_cpu_get_geilen()
Date: Mon, 22 Jun 2026 16:31:37 -0300
Message-ID: <20260622193141.1449724-22-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FrZgh3us1kEml7tvKUt0AcH3rXulHm_w
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a398de3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=tH4yzZzyKPjBQqKxX1EA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX/Uw6XIZVkI2W
 wYkAAdo6u8Vwubsr5uPTqcu5XPsLI1qpmwmp5RWToJ6BX6u9Ync5N4E0qI/ai/Xm09jsDjqoAsp
 2U85wGEm1u2i+LkXq0NWbhRhKfSYgx0=
X-Proofpoint-GUID: FrZgh3us1kEml7tvKUt0AcH3rXulHm_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX2GccqJbNW2gk
 OiZeqgydPgrIMPONr+dpivY1UHCUK26T6WgY1WmvDigqIiIV+AcoixOCyaGnIh0YyewQqhMDH0O
 pzgC763MS3dxroRuIQjwxuZ7cI/uMQIdDhlvUwQz7fsS0ep1RjDbkOvLwV202kxiOlaDqw8wbjJ
 PpoqmJFR8ek/g44wRWEbxnugh6sjJO8Fx3iS8ZwuxFH6mCHIrW/pwt/glOIs2vqDX8xmAMTwjWd
 c1noUtuJ6VrJVVimghFKPjMtT12enPB4Q+sahzVIaHeTnPVeUqeNhWmmL2VDcMLLP2prbCJU2Ue
 xXPHqOqrAzLoEWx9OR4jgi9LF2H7+jGAvGHYv1mSNu+rn3n7nVLjRUqKtOvRZgQ90NlllvFQatG
 W/3rjLZyh7nYJGuPlFbtKwmhqtS+PLS+CSsZr4tJe97QJqOsh/KesvfwjWziQrPRbIHxRRPSWBZ
 s9t4xUfHdyEtC8FqW+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No one uses it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h            | 1 -
 target/riscv/tcg/cpu_helper.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9ec86069a6..aa67999005 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -644,7 +644,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index d0d74c3597..1f13d257f6 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,15 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return 0;
-    }
-
-    return env->geilen;
-}
-
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.43.0


