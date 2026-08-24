Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB1BC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4e-0005R4-6X; Mon, 24 Aug 2026 11:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4Z-0005Eu-PI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4V-0001nK-V5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFn11G3329650
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UDeojLsNz6n
 ZHUk7ltxgu8zRajFPrf17pQGtap9RkYY=; b=eriQaQSCfJ00y1KEqhjX61ytAns
 xXQF6bPupdNgEpOyZI6Ie4LOCT0Bhl8AmZIPv27+J69yIqVp6P1+B5jSNOzGLlup
 NI9zqmlvd2RmDqt2kyt40GsSLCKyxtSyvw9ak4gUFbnW9nFY2ROZaUIqFQiA6r1Q
 Uk07TcB0yxCRPuhQRHb4+qm0KpvmqYYlxn+Opr1UnLdbFr6tYgkXoY9VVOvyMCFJ
 /QOlCZsG3gb338uIHUzVgS6iwBOitq5EV1k0W+2wKLU2cgrBXmJzu8c6UdYQZzow
 IlWse1QFX36Rv3kC0Bq/oXAiSrhI/MfZGNLgxxVhki3StTXvGlKvz4XABGg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedfa3898aso3425249a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587120; x=1788191920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDeojLsNz6nZHUk7ltxgu8zRajFPrf17pQGtap9RkYY=;
 b=ZwGZWTqBt6ADOR73dgN/3L4WwmzP++lMpamhv5ml8vohx5maQ8IcK5vSA1C+MTTaD1
 mWbF8/bq1BN6j47Tzj4pRZQY2V3y0uggHtz1/YIuk34D4KZDgY28jIAhNHIU5iy+1XJN
 UkfPIJGe0rb6RkDhucnjudzv/1srDuPMrP7Mvg9hGj0aw6ADb/faee/S9Z4qN+vIeU/F
 NJ12wISUPJG86mfXZEwl0pFVlLelICDIU/5Ik0tJ77d6VTkPBsEqAXobXDx2p2v37Pgw
 PsiozwqddGUKsBMK5tH/6shum7f2FgBJV8sGP6nh/9c4K5oEKp3o0JfTzp5SCqLUWiz2
 pucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587120; x=1788191920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDeojLsNz6nZHUk7ltxgu8zRajFPrf17pQGtap9RkYY=;
 b=IE/se6ULaIIkObXGq3DDB3sCSIzR4Zpz9/I4M3h5M+XSKT37ErAt2vys9tfxWImmOP
 V3iGU5dMEd38I5GNvwpTDXV6bWBQAFvQ4cF7PZx7sz56GrFKeBJ8XFRS2Lhz5A3gnNzz
 2EQQjhJP+L++YY7XFROGupVgOf0hnB+Jwu8SWJna1qEdBC+G4Cazg3mW2+tx16SzZY07
 qAvWwu1zLtBWvcLzeLnfBmH2A3Hu28eUzElQSbnYadviS+kYUkRZqeFD/1vT6XQeZSgS
 3yeeLAT/ulmSVFIE2XhxZwvunCOgsP6cftGD4H6FGJAu6kxLHACgm1+Lr0nfQ/xI1Pel
 pfzg==
X-Gm-Message-State: AFuF++m7p0Cses829DGVYKyFrH69AvIz9DqZis5/MJCEfBImdT2RCd8c
 XGVALU7F8OYWdgLQsVLIZuXl0ciPE4EJ836fgkGA4ZwuKt4D/ECobs+ZAxgs99kgT8Jtc8KGcTl
 SDmDHvuxzinv4uUVfFq/UhZqjViYasQ/S2VvEPYVutSnbJktU0Yw4IUvT6v2s9ADgSdYG
X-Gm-Gg: AR+sD11qagKf+QYQgZ41bHLeFzsrnc6UXBHYRC2Ton79gwlqWbZpgTHNSUygXmLw8ln
 n5iMfWmrn/WbrcDtvmz3J3qFWByIj4M+yj+QT+BaKLYt3u4g5urrRQ2va9Lh400scFcDHrJhpXO
 +IqJp3MiEP8JAP9qlJTJg5sJxxXCfTGYlJzCyiPydFnI/VcWjh0S/mJ6waC5izbc5JA+mJx/jUT
 k+VUCFOlCfanXyBMSTRP+ZgFTOhH+vhihjsUirJXRpHilXbAYJilVA9MgTP6v0zL1wmnJ8uJsvV
 C/g1/3MvuVQ77V8WnOGFlmwOqa+RIS17oGPli7qAxibhJ/cPwUGiiu9uZy72bxdaIUOfu/FUTeg
 t+y0tojLTP3mHueOGGaCdbPljHBBx5nLqYZlhX2lUcXryNmypP3H1LLw88SI49N0=
X-Received: by 2002:a05:6a20:12d3:b0:3c3:7cd0:fc27 with SMTP id
 adf61e73a8af0-3cd2fd4d795mr50484953637.3.1787587120014; 
 Mon, 24 Aug 2026 08:58:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d3:b0:3c3:7cd0:fc27 with SMTP id
 adf61e73a8af0-3cd2fd4d795mr50484805637.3.1787587119581; 
 Mon, 24 Aug 2026 08:58:39 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 13/14] python/machine: support routing semihosting output
 to the test console
Date: Mon, 24 Aug 2026 08:58:22 -0700
Message-Id: <abcd31dac2e35f91d306d9d79a7381d073057f60.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX12LDdz9uykFK
 IiYzrSyVOVPlkahQG+gw4x1r87M/kUN9CJ2OWsyZVIsF0ZszUxfzIFtKE+Tc5+ZUGwH8gH8Tz8g
 I3K1IokBtTI5udYLrxKVDDJJph/l2kBkx443jppf/3RV2djJ9qxbnUkZim1n46dKW8F6+h2VQjW
 NgJ0jg9fnRw21cyActKYBHJK9ArvVHIF9ds+Cagykl0WDFONyapEIZnW1iyk8YmBP6mprKwT7AW
 nC5sndYPSugAwZjRPNaf8Zr65xpWVETDtURXaFseMVNrRrLm5E/nyoSLHBDkXxz+xDQFtxI4MWj
 zvQWp/J6wLdQUuM89ocuefqyw6JBn4lkgjPQOy1RwY8eixQZOQd6FUC4BXosx381Mb9as+g+OM3
 f24Gv2i9Ml5lqQsnrXbwU/QZdOpkThIYkWXeFVB5iNVLj/IzFh/RcvnE9ldVoMuYIIKwQCAV9NW
 9Sx3PqgZwufcy05cjpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX10xcG8HEUeKM
 7JkB53r9xMKLCQivO6CH1t3RTfoKBqXlIsMH94/iCSu8o3tOmbL9Ir+lhOW8ETp5v8JvwK0SgLv
 yEoerR3JDW5m6qaSR7OmerwHqzDtC+I=
X-Proofpoint-GUID: LOxrXTYDXd1B4QzYEczpcsARatg8rc1n
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a30 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3vhqsrBKo-Q0muh1UiUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: LOxrXTYDXd1B4QzYEczpcsARatg8rc1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The hexagon semihosting systests will wait for output on the semihosting
console.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 python/qemu/machine/machine.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index bfb59d4c0b..3937506555 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -186,6 +186,7 @@ def __init__(self,
         self._console_index = 0
         self._console_set = False
         self._console_device_type: Optional[str] = None
+        self._console_semihosting = False
         self._console_socket: Optional[socket.socket] = None
         self._console_file: Optional[socket.SocketIO] = None
         self._remove_files: List[str] = []
@@ -321,7 +322,10 @@ def _console_args(self, interactive: bool = False) -> List[str]:
             fd = self._cons_sock_pair[0].fileno()
             chardev = f"socket,id=console,fd={fd}"
             args.extend(['-chardev', chardev])
-            if self._console_device_type is None:
+            if self._console_semihosting:
+                args.extend(['-semihosting-config',
+                             'enable=on,chardev=console'])
+            elif self._console_device_type is None:
                 args.extend(['-serial', 'chardev:console'])
             else:
                 device = '%s,chardev=console' % self._console_device_type
@@ -892,7 +896,8 @@ def set_machine(self, machine_type: str) -> None:
 
     def set_console(self,
                     device_type: Optional[str] = None,
-                    console_index: int = 0) -> None:
+                    console_index: int = 0,
+                    semihosting: bool = False) -> None:
         """
         Sets the device type for a console device
 
@@ -921,6 +926,7 @@ def set_console(self,
         self._console_set = True
         self._console_device_type = device_type
         self._console_index = console_index
+        self._console_semihosting = semihosting
 
     @property
     def console_socket(self) -> socket.socket:
-- 
2.37.2


