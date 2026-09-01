Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51227C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UyZ-0002Iz-9E; Tue, 01 Sep 2026 16:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyW-0002HJ-0t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyU-0003UN-2x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgOvL3980075
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SVbvZ/JPvb8
 NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=; b=A2x28dCKTNaDZcRryj3wKnGPsbU
 OTbwSRT57oA7DNUfVICLXQdjyMgLYgvgvvmbG33tTyz3skApfD8itC3ubTGtGnZj
 S8VzG29VTJCOu7vX9rFoBKTv/7uhLvTnyb7ntPItq0pMezgQSyUtEqQwUDe2AKXa
 akegMhI1FdcEyKtkAXY6HnWjy7OPtqgfyNaUdrENER+nLrq5zQFEQSH2+ioA0UOX
 GHbZ0G3r2M1E1VMW2VdZLnifXeL7lgnb5mrR06obWXVgc8H8j5v2ALk5CWNF8hul
 VDQmwBzR8u1TBsc5FRKikf/tn0VLCaPMQtuGX5tbNoAB/UMj3V3ZIZNgjQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9nj5dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so2487605ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294052; x=1788898852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVbvZ/JPvb8NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=;
 b=FnKrHCUtJIPfzPqZlybwhncLyVIq0Ki5ty9HqMGLVj464KHqjvctSmlxG3j48Xj3Wl
 4QQJrny1I86K9G3LtHMWjICuDrikGpVEPXldX++3k1vVMI6qIHBTdzRelIsWhfvASudl
 Okga+gcrY2sMG/2mPDx6OlIsmBiQC5Vno7AZccNv7YgkTkU3otoeJW8dqGl6P6hVoIfV
 PRByizbj/PMe4mIlmLvwNBDIYQO0fVRQoCUvSzTra1S/NHQjEMjELa4oQr30AaF+lhOt
 D6UUlW5N85R7K/muO3Q9NdIlwaToQaQ0APXXDozhl8Aw13k1L0qMsIRbeBfbqWY7Yr3u
 8gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294052; x=1788898852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVbvZ/JPvb8NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=;
 b=DEm7tiW2z+JnK2O9hzHalvOvbXgvE/399LIBCkUNhIDXEaTyuwtvfCtlewUWMpX5IP
 Ix8YmaSufA/6pfL5YgC0Rkk24pYVahrNtL/fRlFt+3B7GssbfS0q3PJxBpOkqxChBM+g
 K2yf93/XzR/wC+PqS475kqpER2WHA6Gh4Ercq9PqA75KdsNMb32TWeSa6l+p/KfywKNA
 rzvkiZCrINTtah91SRSY7ZrSVANWEpAAk7xtnZELExipiqRsahadYUzxVzHmxpB8yORD
 6ImXbU4D2nFeLI7ZQi0HLQ/YmMi0UiHyjzQUrXScUHCYEpxYp47xUGjXqd7FieSLnZrE
 5SkA==
X-Gm-Message-State: AFuF++ko11z3OcYFlKUF874d0ZJD6CvMS2li2K4wxWLoDV1Le32a5yVZ
 LZ9siiPKncowb0xFMQuNNm9jZSwt+ZafcXtFwNs8cn7zixfQTLEX3GoijIAwvgLUZhnthScvTtC
 LTioQuCwZi+1G9hOwtzsoNFdg5Cj90Za0cMR+BADBqBdb5givHWlUIi+7vHaJWQ4MSA==
X-Gm-Gg: AYBFou03dfOnIALuTzxfMBNmnyC5hI17CQ9s1pK6Bc4o9fPUv5eEq5X7VQxAlV5b8AG
 10OWfrJh7gyN+Q9T0GteJv2tdqajob/VZFCq9J3p16eeTkSTY80XzVwvqukuytljceKQ6HTunfD
 YYdg1FdZFCxkX5Vnd8+bSr2PxpZkRHfLoHJJf3+677FTYdr7lNnwThSnq9FcBfryiwXk+BFHuOj
 I/lwiMNAFH7vQdKFQPcH3z/u3bdMt9Q4kgBiraI/X390sIn9VlFQUeNZJioy6zhx4HYeHYRovNZ
 RXi54RDmT4R232Smn4q8rZS4mIVR7WrP0EnMQEjpirlDAGZ/bSy2i5EdV6Z3lmS0puvQEBrA0Wj
 RKQM/CRfmpqE1qK1JlK+sujAZZrG0ARiBuQJ5W7UT9hsTeEQ6XsRdK9WkJ1g=
X-Received: by 2002:a17:90a:d646:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39907231958mr17097314a91.0.1788294051938; 
 Tue, 01 Sep 2026 13:20:51 -0700 (PDT)
X-Received: by 2002:a17:90a:d646:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39907231958mr17097245a91.0.1788294051393; 
 Tue, 01 Sep 2026 13:20:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/14] system: query machines using TYPE_MACHINE
Date: Tue,  1 Sep 2026 20:20:32 +0000
Message-ID: <20260901202043.26532-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXx9xvfzTktUUD
 QTC0L/SUa478yqLTQz5CMlTtQgf/myg1upbO1A+ioIldEvVdPJ5/vzaOSN7fMDaJ07seINY2uAs
 YrJIlcLX5ZqDmnr7aJkmhsPRGWYkxIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXwN96Up+ij0Bo
 Mt9obLQ4jWBDweQePpqjDPNEJ50VdzH/wooy7dFU/JRSNF2YBZoM28B+55NmK7v2FSAh9Wht/2T
 hWSLH0IDlk/4TA/GgUBEP3tXJTQ83m99QuZAWqkPaas8511q5qVlQbhicLgqlcfQIk4WYN9xYJD
 EGnxTiG78Bdr+c+RsAAGE1eMv4A3ufZT+gVQ0POVDm5DrG90QenwzRUvW6PV55ZiR+QruEDGUSz
 gXPnuernoWR0bZ35kZKZ1Gew/OoAuuqyx+O//yNBlFy/IcFxa5wtufdW39FFPQlmyLWj36XwmbN
 bCBH50h1igk44c12oO7QeRhnTXJLcKK4KPbJfKBE5tW69jjaSuSuRdE1gLhFgNtLkGyNHJwcm4m
 v0+u+fxFJCWr6rIBYzJdjO0hSQQDLN6xWKWcwaqFwY6qCd63qsgWBSF0k8ZYhE++znUk9HJBpWH
 dOumbPwFtlHFW6iQoqA==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a9733a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=1bRhiYiS1JNjwnGb910A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: JWdzgvZUKFUQ_0fA8bztEVsZO2DBzN3j
X-Proofpoint-GUID: JWdzgvZUKFUQ_0fA8bztEVsZO2DBzN3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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

We drop the target_machine_typename() we introduced previously, and
revert to using TYPE_MACHINE. From there, we'll make sure only the right
types are registered at startup time.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c | 2 +-
 monitor/qemu-config-qmp.c  | 2 +-
 system/vl.c                | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 1aa5f262298..543dd3201b5 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -99,7 +99,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
     GSList *el, *machines;
     MachineInfoList *mach_list = NULL;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 29801023564..a680c9feca5 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -129,7 +129,7 @@ static CommandLineParameterInfoList *query_all_machine_properties(void)
     ObjectProperty *prop;
     bool is_new;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     assert(machines);
 
     /* Loop over all machine classes */
diff --git a/system/vl.c b/system/vl.c
index 061cbdf860b..f7f8aabd122 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1570,7 +1570,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
@@ -1682,8 +1682,7 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
     ERRP_GUARD();
     const char *machine_type = qdict_get_try_str(qdict, "type");
-    g_autoptr(GSList) machines = object_class_get_list(target_machine_typename(),
-                                                       false);
+    g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class = NULL;
 
     if (machine_type) {
-- 
2.43.0


