Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611CBC5DF98
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxZ1D-0001Tp-Ay; Fri, 21 Aug 2026 19:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ1A-0001TS-KL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ19-0002GO-6d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LKBr5X3215585
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e8T4TZGJ8Jh
 Pz65QQ8ySOTgRRlvTA3K6JUsNZmBsnlM=; b=o3Jofq7YylTVtZTNAqO8l5EhSHh
 HmpsINvjyPd2tOh9kSbUUHq8HJA/itD+b2UNPuC8nJxKs7B7+IVFXTU6Oy3v5Xus
 k5H6mwM04B+XGZ6e0R3ck4htDHMASHA87fLQaULPFhql/vjVlJIvEc6S1wpOa8Ab
 MtGZ+Fq93FdAK2yovJNs+IGJGRFrHCHBNRosbpscJWgS2M01BywBdcQGfNmomLke
 WEyP1RXc5+WWq2l7DwTsvm+GNu8h178zi+JkFwO+QWh2JKFF+nJJVdU5wxXPXaOX
 S43WYltx/4ok/KDYJHnTJG+Hgj1Cp5TDY4O06Y8EVz53NDf/K0DdwUyMnxg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6wgh8hk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3931cd2e4cbso1846301a91.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787356281; x=1787961081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e8T4TZGJ8JhPz65QQ8ySOTgRRlvTA3K6JUsNZmBsnlM=;
 b=Zf7F75srFHTzzkMmkqA8wq7+XxamjPoPZgbdFzkVeB+x9SaPSo7IhaG75X9yofw8iI
 kcAHWJR0IEsiqCwrUxHkfR3GMttmLiieo9gpG6hlY626LnLv99kDLIrebngmAAX6WOvU
 iozBjGMWwexIn24GfWog1sDKhJIAsBLaA8swZ4t5015LkVwXW91++k4Eu+YGye0ICfGk
 Mw13lTpN71GCusluJHmztFYKp1SOWO2d7XCf6jxBylajQ3XD+my7xx/Uss4Z1/lux5ff
 KVdnLXqlh05j+jbWSbvH8fMMuoCGkpvO5XtN05X8VFiyGRN26vnonzc9N7WnCDTQSNhE
 D67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787356281; x=1787961081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e8T4TZGJ8JhPz65QQ8ySOTgRRlvTA3K6JUsNZmBsnlM=;
 b=KOOi9nrJZXK04EPmisn+vKfjRpGsyTd730ZLd4iP2bZVU2Xm4/njr76rABJZEeep7y
 wSjRAVgZhjjGi3XNBLmS0YGuqXauOoWQDu2aDOrD1xvapHFmY3/IUCqB98dKNs9K8WIi
 v/VpyS0djHbn8fuXQ1onjvVO8Y2UwpNaeQiLPo2U6dHPgHgeyk7J4Pp90QFX3eAno9+m
 Ls3zy7ZlBsiwNLO+tl4d/KpoEKhqBAxGgYq7rRz94M8229G9pywZ33l/5GDbtiDeBMh4
 2+CFkmrfYQ4XZwYbToK/mOoWUv1M1ZpsZWlkWAtnC44WqHurzUae+1WKhDXkd5N8Zouq
 83Sw==
X-Gm-Message-State: AFuF++kWoTFulXv8tT8okbvmOq8IKFvi7dSR8P0oVvoLN9hJh0yVbnJn
 B7fTQPlYujmN9FW4tMMW7Z7F1s5MT1J220Nx00r1Ok2TBKhJEFZe2974wBMTTDZVTsmQM0b03Tl
 osSTcwrFs3hEqAAxFe6AURn2vauDjEj7nOWDvneARWHhYvdyyRQVZ4FdFGWSjfGuc7A==
X-Gm-Gg: AR+sD10uTtYesKPv+p74FWjgKpRmA5HUBAcCEfYLWY+LbScbDY7RF1nFsWoQA1NRwPH
 b04Cd5+CkaJTi1SXjULj5r15SdQeI5odEiSUbsfRxKz+7qjj312rIrVL4e6zU1gywc0nrsp0woL
 l4YlQS0dPXyHuvsrF7HvjcT0db8ayjpl9dGE6muKCTsj9Qba5wYn7xKnerZ9436znKKMyCVfOzv
 Hpzv0dNkzWv4rRsd+sAFMqouc7Mx6BXtNJk3bEBgez1VymQvnBGChHvn9UcGJtG8qnejxqKr29f
 +0nnFMhKjuLLHVlwJaGRBJmDaQISOZWLW4W0z3JnD1fNQcP7wpVXJJgrEDVvYiaPXbsgQVv27Zy
 Rvq2q5TSRn0v6bfMgVFOxENadP2QEUU16NBE6NF473U7y1BZPugrO9intG70=
X-Received: by 2002:a17:90b:3d85:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-395c3573af2mr17482304a91.11.1787356280815; 
 Fri, 21 Aug 2026 16:51:20 -0700 (PDT)
X-Received: by 2002:a17:90b:3d85:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-395c3573af2mr17482237a91.11.1787356280420; 
 Fri, 21 Aug 2026 16:51:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm605618a91.9.2026.08.21.16.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 16:51:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/2] remote/machine: add available_if for x-remote machine
 type
Date: Fri, 21 Aug 2026 23:51:12 +0000
Message-ID: <20260821235112.193381-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfXx1PGRFpgUzIe
 U4uJhdE4e8tIRxi9d+RQ8+wymOLv/SBKYamUpDLOKtVIPaPTDkuGqjVNXLBleRqw7Q8MEAb6+jG
 ebxROIGb8XeloVseTCPes+udquUGIv/yhwhLUFN/FXAjFDioW2ent32VKpQpzHbuo6sA/9I8mzw
 P9WNAZ0MBK39trE6IaR0waS0Ew0iNgWpSKA9cC/OCNDYzVJ0J3RYZe5lE/OSYWiuC3xrHa1xFeJ
 8GLK9vojUWGLyIey8l1oN9NsKysGDL3jPFGkvhhiN4DYlqXqckCo0TeESUllvLN5MlIg3AfhsFF
 xNVpj6a39CpPH3avDFZNXnAhv20E7Ct+npJrWNBg2Z7vjdE4t8RuzZ9jA55kRUEpun5UqvMWDMy
 50Pn5HHnhxAJAhIRRVhy7C0wbzmZnKwUEzOK42IMcYXav0Vr9jgRs2zIsyGONSrR+WDzFfrUSpQ
 amfgJtfBzgkRdqCisug==
X-Proofpoint-GUID: Tl8kw2JNixUy93WstwFEiJJpt6YZidAw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfX5FPBPkTNQ6dI
 XXzuOHbMxoWTRb1CRvXxmbdFK94fGFXGkNZueI9LiNJq2KJP5sSf9Q5CIHH1dVU4gpE+JOrrcpr
 Ac0RS71bkC2+e+SYNCbNGNo+1Z47jg8=
X-Proofpoint-ORIG-GUID: Tl8kw2JNixUy93WstwFEiJJpt6YZidAw
X-Authority-Analysis: v=2.4 cv=Xq3K/1F9 c=1 sm=1 tr=0 ts=6a88e479 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1ebxPVMK0uwyyQgDTcMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We don't remove yet existing interfaces to not break current binaries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/remote/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index df08f640199..a62794dd2a0 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -152,7 +152,8 @@ static const TypeInfo remote_machine = {
         { TYPE_TARGET_AARCH64_MACHINE },
         { TYPE_TARGET_ARM_MACHINE },
         { }
-    }
+    },
+    .available_if = TARGET_REQS(TARGET_REQ_BASE_ARM)
 };
 
 static void remote_machine_register_types(void)
-- 
2.43.0


