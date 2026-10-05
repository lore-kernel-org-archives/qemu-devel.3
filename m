Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33945CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqk-0007f7-VZ; Mon, 05 Oct 2026 14:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqM-0007PX-OG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqK-0005iq-73
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLENS2567954
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Och+9SXW2z7DeMcLt6DXxGpQ0cIDt2TdSQVeF4ljIQo=; b=bJ+Lk7SR3tYpEP/T
 7G8BIghXMccx/cuCDFsyjtvUKKllPSsmWij9gKb7W4TCjqrQZWJDBJHwICje/ypf
 rRORvViNg23uu47XzvfCInZcRXJRIjEzFAuSG01tIbt5lXoGIZzY5yYqNvTggczh
 Fhqqni5T6KR4wwlWF/ztoolNj+nW5Ap0G29nsOt16TGBMW/pYss16tm4nyJxutfm
 hPKn2o8IXSuhSZoxPAOQj83nFcAhlKfppOsNcm4kL2x1Yb7EnvgMXw8uX+/rEH3R
 jiFy/vTsbs4QsDl7OlbDblWIF1O+igIKdwbB9GZ2PSykLvIBSJt/qSFu/sV0kAH8
 blmHeg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj61exp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1438fef603cso4712980c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226518; x=1791831318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Och+9SXW2z7DeMcLt6DXxGpQ0cIDt2TdSQVeF4ljIQo=;
 b=VcuO3fhMJMjTMDHIE8CZFRKhR1wU7HfeJQKuj7LgaJQWQtsimzahJfiR2qCJ5pjX5b
 qDpjuIvwUShS498oLpA95kuICw9osvJ3SSQpXdG99QSoSOJy7akkQU/8Du4aQFXMV/6X
 R7c3ZPU0C7Y1NP7CLXkzlk5TP1sPV5RvBFoz6D3qtTwd16uxq03wB9xdNEgMpi/tFwmC
 4QrJ/Svwv+tV4w1ZWLjMnCJd6whPz5tm9IjKPL8KdPF03bMlzkEQL0xD3BFwk0TOSco6
 Xl26V1czjLnU2fmqk5V0OfejSn6O6XeiwrDSNrjsgjaKeAJKrnXx1OS3RPPOo6t9uPCf
 mYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226518; x=1791831318;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Och+9SXW2z7DeMcLt6DXxGpQ0cIDt2TdSQVeF4ljIQo=;
 b=FhVgtaFWuzPg0mQqaBVhtlmfko+mqcnebWiJF+ZGchF1hF4/T9nkoM+TGGApH3FFuo
 bqAujzVli184mWjZOp1C4CFPKOGumc4GNYhh5ds5JrR77KORTYgEc024sB5mhq8hSMDL
 QcoRO+hEnt+inlDi+gm3dJRYGe3cFzBLncQHQOk7TCOTKl7hNid6R5Upfe67+ON7xUHV
 Wm8xElVlk30b35sdGRWoZLra/im4dfW8Sr/YEw+6S46nx0sDCOSg0HBCXuJdc6islZO+
 g05q6LVsHbzc+9lvLhvAEq5Cq0JAc907gJEINPEURDH/rGG5jnp95IOeoem3R3tVlW2u
 i8iw==
X-Gm-Message-State: AFuF++kC0I90IF6ZzZPL9HauZ6ylKSnsQF0Sid7GWoMbEG45wkLmelkV
 xAjxSRyCoftzBg5VwtFH2gy6gJ5VrcnBPyo9ysEGHUT3v/p/zFZICYf26lxwOfqaxu/rG1NGGcA
 GKxRxKLshwUo4fWIkhSLjT1o6ljc2ELPzzvhTh9NyUk2hR4dqujFYzTRd8ZqG8NgnMA==
X-Gm-Gg: AYBFou30YjQhl5vEr0DCbDyuBdoBsuBArVTwbIUudbWUpsrwN47SCfIeDWWwSGQydHM
 UrlkVvl68Gmhn5ghAiJZRMnCAmhcL17JClGtazu3hN3qfVWde/NePUllCSBBw/Anu1PkBJhFSlc
 TO6bwNX/ToAcWFWU5gZJoZqvfIhDWCo98DSkP7wVoCto5MgMG9pv2aCaiJWX69pNMi/LC0ywYDk
 7JmQPjaIHGsnmimDz8wQP3VRlNOq4wHj4ENp2aSAplDum8pEpi/JfS7Cs7gALzYpQx7tlbLlmt/
 /dpCRN4af31AwUTjUZKGM09txA4PgA5jji7uSiPXMTgIZ2p5OgTd18LHSul27dUNfkvUgI063Hg
 uDDg6at1YhskOSIf85xhVAdacS1EikDeMfuXFH+yGqckGD4gcxKWL0UQ7U1i1
X-Received: by 2002:a05:7022:f90b:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-14f5c2ee7bfmr18593415c88.21.1791226518060; 
 Mon, 05 Oct 2026 11:55:18 -0700 (PDT)
X-Received: by 2002:a05:7022:f90b:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-14f5c2ee7bfmr18593364c88.21.1791226517446; 
 Mon, 05 Oct 2026 11:55:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/22] hw/m68k/virt: make machine available for m68k target only
Date: Mon,  5 Oct 2026 11:54:42 -0700
Message-ID: <20261005185458.405929-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX5xMg2LRMNfEB
 AIQP42RaOsDG4WLyxNls94rxdB/eBPmnFJgumyMd/UJMASASgQICsCaXMAZYa7IOq6qZgBMB3wl
 I+WQ5m+H7BFexDem/g+KwY+Z1T5LCm/1Xi8mPj2rRetATSOpbK+2n8q+8+8+j+hSKQDOEUhwZDc
 vRfDfGqls6ixTT0tQOnlhsuKSCFHpJhVhfkY7Yuu8pHkIXisn/GcOZiWZavN7FY1Wi+IOGqz702
 3Jgm5AM79RPVU6bqrqpx71cNNiPELql6XF2+1fsagyFYmHtj+RBEdp4WHek7ZB0fyN6UZ1lvj8t
 AkiwnlLIL58ey3pUJZlqxYDZd47ZXOteKTlQYsRG5sDCR5wW0hWRXBI2mYs4Ltx2/LuQrt+YE5A
 jOyjEkOadb3lRT9cmEtY9sikrAaYBYZ3yPQ8AYndbqM0YdP8XE7yaSUePLd+406JIHS4Z5b1Oh4
 DQIgkQD2ZZQc/qkaQZQ==
X-Proofpoint-GUID: QnEezZIBRtrZpXNEyjp2mJeYrfLGoV74
X-Proofpoint-ORIG-GUID: QnEezZIBRtrZpXNEyjp2mJeYrfLGoV74
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX8yJKrWOixHUD
 VlFz1en6vPGfOInHmKWHGIeDnd6yeVyPFAc+LUAqLSrxepRusW0q9unsfNrrW4ilouV+omcPlhA
 bSgFXbmbp2J7rdUUQ9P94mAZJvu/I/8=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac3f297 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=HvV90vnVod70Pf_NeXQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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

The virt-machine type name is shared with other targets (arm, or1k,
riscv), which conflicts in a multi-target binary.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/m68k/virt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 274970978ff..e52546e4fab 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -323,10 +323,11 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo virt_machine_info = {
-    .name       = MACHINE_TYPE_NAME("virt"),
-    .parent     = TYPE_MACHINE,
-    .abstract   = true,
-    .class_init = virt_machine_class_init,
+    .name         = MACHINE_TYPE_NAME("virt"),
+    .parent       = TYPE_MACHINE,
+    .abstract     = true,
+    .class_init   = virt_machine_class_init,
+    .is_available = target_m68k,
 };
 
 static void virt_machine_register_types(void)
@@ -354,6 +355,7 @@ type_init(virt_machine_register_types)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = MACHINE_TYPE_NAME("virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_m68k, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.47.3


