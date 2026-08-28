Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FE4C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xg-000099-0H; Fri, 28 Aug 2026 18:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xf-00008g-2W
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xd-0005jo-8P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTVdo1173263
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SVbvZ/JPvb8
 NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=; b=GsIgWL378WNY3mxSBn9qi2V8j7F
 q/70YvP2zHRlKvATdcaKUYQ6/xv6Hwd/YTR+4lbMSjV4AoUS6nWkuOLteZ5a5cXH
 d4dypPngGhb0V/ZQW/Zg1EHof7crPnZO06b5ZyhBTQQ60OI85bSwGtemA2dDzXG4
 4/AipHdv6I9S3Z0hXG6Z+xA/WJ24VmQ94cHvgwlwEG+INv5JHVsrz5MxjkKRzAZN
 QkYQporVidc+0A5WKO3qvUotMZ1o1GyEAJQ7nQyvBDxRi2QPcNrqXp9nTgLySy0E
 83Ud55bXXaxu5ovjqeG36mgVMoUP2Uut+bY2va4SvcX5pTsU4PWQ/I7cOTw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjk58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2526191a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957959; x=1788562759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVbvZ/JPvb8NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=;
 b=E2tlNKzcj3BU0quTZFJRU5mivkzLsWrWbfpWXLU1ipBFEH3KMAGEAMjSDwr64qOohh
 wyHt7OhAFPM10+9kLkRMkOo2wP7rQten8VWGknpT9NHiRroWzFSLthx+CL4jcStFo8rR
 HBRYB9GUNoCa+Lo32N982Xu77gIucDZ1bDvRWpU6s4QM2pnCWJLtWsQ6NiD8N0YcH6ja
 V0s2uk0hzQpg5qKBjNSItB72mPQPkO7nuqkPGFFDblGzO+c3miY9OrIH81Sio5ecOnrR
 ZqG9ZV1NlazVkajPMVEbnB1dWGMhKLivxrEi2qRWfdEs+CIqINaoNpo5hQY6JAXOZo6a
 rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957959; x=1788562759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVbvZ/JPvb8NlBifldsVxKVfKAORZIlZLB2gJG6Jc3o=;
 b=L1udY++5B/hmLQcLXr5PRi4uYWBLjmJNp8/CkAxBLwJo6+22e21K30uJQ0JsK8O1px
 q2j//9VpY/5GjEqZO3b+llsyo9rHkF/8kXST2eyNpQoi0h3/FgnsOKssmaQOnaJrEUkZ
 +bT6mb3E69/Wo3QTuAA3fiZXj0NSdk/SV24Bh4d7MZcDcgsI2cvmF6MLbciNz0yPeeW0
 uDLOKWVrjUTIdhpHLWEv3PCrUp8ONUHp8oybjNtHwm1zIp8vVS+5lt4QGHX4/ZfDyLb6
 bLIfFrB878s8oSfechGuR0y4Kl3gwVSkbTmc1xNSHuVrVQn0iYXmKekU2k6UK/YYtL1C
 i4cQ==
X-Gm-Message-State: AFuF++mEM8iOKdjLhsyYoztZfhOgIWGJA5npWUa4izzSYIEbjm2Cndzo
 GN2Y0Arylhs6RceoxUHUHAnvWKe4pt8MTMMmpgQIeZpDMXTnegq3iJhuzAi5JGhUfHE7U6pO3/H
 AICEBBnzN836dMgS7JISbJ/2orNyWwZ6YYF6jRvbChsvYxcQAMTJO+XdvfWWjZJRmYA==
X-Gm-Gg: AYBFou0QKAIpbBZj8qTskBVbrQCKH8a03+UOh8qszrlXAosf58G6CQQ7u2NIF1Jq6/1
 9aHvkmH910ZhAmwMcW/X1x89LtXU4eun/3WpADb6cGYdAaYSWTL/a1M+NQ5xeSabRdKYo3GiG7H
 N/PYjLXW+cwgNWqjc3lX2cs66zy6OOktXqxcL7tA9+FMhvXwyP7kOjrttg16IsVTmFeK6ArvRHw
 OwFa33RQm1pKVfA2/cLrbRsSJI9FFuLHbQtsixbgeHsSm2URMcXdyNi3Mn7AmKck35jjDf5bttr
 aDbAgCtU+jMprNVsYo6mvbnAN6QMeukMD10OGDKeJpnZUG8KxETwa1sIYH0V/E2GS7Agv+DkILh
 mM4AMXhaizGewOmfccyt4Uf66rfmnpKeCyidR/0k/dSgsh20ODA843bP7k7I=
X-Received: by 2002:a17:90a:da87:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-396d0d4c42fmr20278114a91.2.1787957959072; 
 Fri, 28 Aug 2026 15:59:19 -0700 (PDT)
X-Received: by 2002:a17:90a:da87:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-396d0d4c42fmr20278075a91.2.1787957958679; 
 Fri, 28 Aug 2026 15:59:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/47] system: query machines using TYPE_MACHINE
Date: Fri, 28 Aug 2026 22:58:25 +0000
Message-ID: <20260828225901.367438-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hhooUhrhXK3KHuQoLFuj0T_--QTXWaME
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX72gThGA1yF5s
 wLCyFjZkaa6VhaaACwsxpIEf4Un8L8OQpmozp4WMDVavkrDBXEiv85KGdYnYgJKVhWqAWsiyWNt
 +zGMrJMCvBxYxOSE6aKJgK/SymvHyok=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9212c7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1bRhiYiS1JNjwnGb910A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9HjGFgwIwho/
 1wllCaEnTtsMT4XIky8V3zDsPQgUND1DIXktIgRAUuk0obI42pSHYSkldXOWdu0L+bdmrGPETb/
 ux36q/CRwwC23X3Xj7iE18XL70yRiiM31/eViRxeZz9I+apnABmL80sH7IyTku9MFxRxvR8IIVT
 cd0wAZSGzxSWzqeIbcixFsfxjJjHmjK1/7wGOkZzN/ssqyYq7ZHlY/4flYDWolh3MH0iWQ8MeEI
 FEPfzmWd/3pATpv8r7yhBWcidHPVQP6sd/0joYEmpMYSaulaomHo8z8KEIQB2toz7L7SV6FOPfE
 u+s6uS+ptKpTHJcE3M2+CFXgQfU/cVnQtvibIm31YvZo7u5Ulj93xbmcxhGZIjjN+k0bYSgi0DH
 r5PZdkwMLWl4IGE9VZzmgR5r+zmGVe7cZzqE+L1qj6+RswohVAw2BTl8AHQg+sEveg61DrAwqeF
 QKSsuYvW11VfT+TBlCw==
X-Proofpoint-ORIG-GUID: hhooUhrhXK3KHuQoLFuj0T_--QTXWaME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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


