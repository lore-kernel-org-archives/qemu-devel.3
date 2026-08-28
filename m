Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA7C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Y3-0000RQ-80; Fri, 28 Aug 2026 18:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y1-0000PS-Hz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xz-0005kw-Ss
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMT678731508
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pDeRBxB6m3+
 iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=; b=PzQT4S7yF6EPn2boPU5peOhixN7
 LgfffTGfJTDJq0u6zQM6wWU+4uRlmmSMWvLjigaTHyNH0n+KG70/pF2jFCtcyuhe
 j6QO3XxVi/a75NaN73UNiSXNyE0wWuZTQAxEABIukMMRXmnzHG0UUIRPuCco3Uxx
 NiFs8lcWLr6Fzb4ktDjb6J7xU0VBJa6xUd67PWf8y2KEVu+54ukxPfPcw04KN9vA
 lgHBjqoy8vU8bdLvZ/ALF3dcOA/tDbohvjnxsZT2NNtIMGf58y3+V6Uwo01fKWVT
 kTCNxROzsHvqt5R2KnauE5+YjfNZH1OzNzVTHK2f0p0tQtFxOU/Hf72uDfQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgtrbh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso3258516a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957972; x=1788562772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pDeRBxB6m3+iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=;
 b=OQC8Ba+KPy9eH1jxMXQ7VED1HigwmWbx9m6a57rlUSlEelUAI11llFlvdhPVht+/+I
 8YDJJ4vymg1I5mJ6pkBkAYXDdDQACJrgl3uYt57tXWdFqdcWHpzmWPDWUjOdc09ThVtV
 DudsOlsPMTGjQ5BV6swIVq4kbC+jh2N1jZDFnezF0m1zMoW44I10ceW5EiOPQnarCj7u
 R4do3OLhVue2w0FIeY1xQx39PyY9HZe/z895qB1b6OiSFHsCi32SZmAmIRvByJJCsAZ2
 FOuCgkB4DZkIMl2OPQEFCnFUD9vAb7bZph0MOpLRDn40PnA3t4xRc6ljFTlwP+akAvL3
 Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957972; x=1788562772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pDeRBxB6m3+iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=;
 b=nRA2a77LcQyZ2bP9ZO58nnWBkoeJUYic0dIqlwO5P+/P2G2oqCpAyvoc6l4WEuajII
 TKZB/onBpmhpAq+Rd61TNeUHeMMgr6HEES6udWDDrRMSZ4mJx1fjzJeP9P++qlCa8qJs
 MI3JuUo8mHcqqPmAFIwYr5rkWFX76vj3moH/8IrVozhnIROg0NoiuLTwalefWdEDhXGn
 RG5BbHuluIz0YMsD89kk7q+6wgKe+EQQiFuZi4sE4DSN0dWi6L7rZedFjKPYhS5GdDsG
 eff15EHWlSlDUOavGb/Q29fKUvZ2s7sd0exW6EMh2Qi9fRMwbYf7ieU93dvsRNkaGojp
 n9yQ==
X-Gm-Message-State: AFuF++kCss7NZe7WJ95Syu+Y81s3rfXda3497nSnY8Ykjb8lqjtEFmDU
 y2inXS/I3SgCwxbEsO/zgAtNOwJROQKaJmOOG+FcpFEgWBOrOlwGQnn1b4qHIfSbwJLjxIRweMd
 r651uJv35nZSgAMQOs2IOhvTa+XtPk3KGsii3t645JrMrYllOATVIhG2Oo/FndrXDQQ==
X-Gm-Gg: AR+sD12bG2vRAGGY8VIBS51GBfK99l+IWziWFl+Y+MvkUgsNC6j+g1+CIBlGUk9qZt0
 9Ee381AMJ/dTiSmTiUT9GvXujPaZ/+03qTIXlJBzh7m5kRzETuBptmFNC+ewY0X57rOF42Peect
 i56s3eoRutErheJdEz0hJBIzTfUORWhw4UJnHp9IpFC0MpoLqe9JB1TV5C3EuhmS8S1aEvincP5
 8uHlJNdSOWnXWJP4f91p5PZ83pPBgPdNsZ/XwXqGX43GSjdw8AIPq1yo8/dbjTdPwRjDehMqVpp
 QVo+9bgUtW12/0jdE3XMuCEfi+eL2D84c7jJNOGab34GfjqSskKR/madKlaVFyTNHyHhsknaWqA
 n1tpTmNCRwiGK7Itkmcnd7JoeW/Y6bwYeEnrQGDx2ZauArANlOSc2UBsYomI=
X-Received: by 2002:a05:6a20:2d22:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3d265a33636mr22383652637.5.1787957971744; 
 Fri, 28 Aug 2026 15:59:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d22:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3d265a33636mr22383605637.5.1787957971354; 
 Fri, 28 Aug 2026 15:59:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 19/47] hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
Date: Fri, 28 Aug 2026 22:58:33 +0000
Message-ID: <20260828225901.367438-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX8nCnk6Z3TQZC
 bXRM0LE+0vpKjmg3WGlYMrXuseb90O5JVWUX+GkRXvh9YE09jD43GRKxwJ2pn/+wA0VE2JAklVn
 tQE1XeXk8XUBjaB61fCLu1krJJs967E=
X-Proofpoint-GUID: 8VIOa_LpNYW9Ww0VNevdYbR_17C-GDX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX6i5ADuVssAPx
 6Fe1aUep+l9jEytUo8s3T6fCalpjkFjfTSfeEE9NL2IjTj8NF7IH37Cw4ek9jKONG3uQQbeMeur
 aCJ4dBp9z3vlKAWuH5VxgKp2hV+4nwhw5/Qo3nDwXOTYKr70pLGBQhB2TNAI7nmKiXrfINe/J1p
 s3OulfjluoFRqzeVbdi2t3sFv9C3nBHdNH4UJzn0jte42CBzPrESXQDTMmYPiT/lqBJWwJKydCC
 u14gFVV4Tas+x8oloo55IAfA7/fSdEgJ7HB98R200cNCp8lhhbmqAzPjqn3VvMs210mZDlGA7Ho
 3lvKpJLwp7RmO/Vl3iAph7URd24rfwjZKmVgRKr6HCp+dygB3cEWFEQzjvdbrxhX0qb9ojz/+MK
 5pVMkAmt2Ig49I/M/UxysiLXG2OXtGFZ9KZpGtWkjMPt8vF5gNgHH8CSUmQ8W6MwlMJJktT52Io
 SDZppldKBPcbjaRUBFg==
X-Proofpoint-ORIG-GUID: 8VIOa_LpNYW9Ww0VNevdYbR_17C-GDX5
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a9212d4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=w3swJZ6BnakM07JXKC0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/null-machine.c          |  5 +----
 hw/riscv/virt.c                 |  2 --
 include/hw/riscv/machines-qom.h |  6 ------
 target-info-qom.c               | 13 -------------
 target/riscv/machine.c          |  4 ----
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2aa748233b3..2f008c4a702 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -56,7 +56,4 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_RISCV32_MACHINE },
-                               { TYPE_TARGET_RISCV64_MACHINE },
-                               { })
+DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d1..d2ae321a376 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1811,8 +1811,6 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_TARGET_RISCV32_MACHINE },
-         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index ee346227bb2..6c0bbdfc159 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,12 +11,6 @@
 
 #include "hw/core/boards.h"
 
-#define TYPE_TARGET_RISCV32_MACHINE \
-        "target-info-riscv32-machine"
-
-#define TYPE_TARGET_RISCV64_MACHINE \
-        "target-info-riscv64-machine"
-
 /*
  * Interfaces specifying whether a given QOM object is available in
  * qemu-system-riscv32, qemu-system-riscv64, or both.
diff --git a/target-info-qom.c b/target-info-qom.c
index 7959853e0da..f98d3d7698e 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -14,19 +14,6 @@
 #include "qemu/target-info-qom.h"
 #include "hw/riscv/machines-qom.h"
 
-static const TypeInfo target_info_types[] = {
-    {
-        .name           = TYPE_TARGET_RISCV32_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_RISCV64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-};
-
-DEFINE_TYPES(target_info_types)
-
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
     TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 31c49ca3e6a..59676c94470 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -582,17 +582,13 @@ const VMStateDescription vmstate_riscv_cpu = {
 };
 
 const InterfaceInfo riscv32_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
-- 
2.43.0


