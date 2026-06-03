Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD1CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZX-0007z3-3j; Wed, 03 Jun 2026 16:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZR-0007xh-Ak
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZM-0004CX-Jz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653K6eVu2076419
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t5D9fCZRFja
 Zo3dxmMgfect8txWU4hAoTsxjlMPqDAA=; b=frOaEuFRH8TeiLlYu1I7DTRAcrW
 JwEZQD3G1zZGvT2M3x++cNSUZuPLdmiVM5USIdX3zwILGFH/s6wXl36V70AFCR+5
 F6Eoc26T8hpjq5yh8hXN+10SVp05rPfLmZmjKRsSgBSAirSskFwcHLCOFQQPRL+y
 Jvk6dVfY6YNmh7UE4GP5IpnIVzgDCT1RIjHIaX+ClQu/S19HQ67c1HROirocTx/9
 3eN/PqQ8/7VvP8vF5Eeh71O/ek0Ro/DJv+1YJNqWCoOkNv2HMawHd726yRJ1T95q
 6m+B5WCbcYL1b3y2zP0aTA3Fx+OXjrfWEqRuCIub/E0JLI02BoXzphcviKA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1bmmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30761ab3483so1304736eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519926; x=1781124726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5D9fCZRFjaZo3dxmMgfect8txWU4hAoTsxjlMPqDAA=;
 b=IspPV1UaU1edFogbxWYMpTpoHsXxYAlOvdsaPaoQnkwDg7uc374EgXjCvgkbCbqf/b
 dz9JOUOpoC2kbFSMVz3tbFtphTzSQhQiAUW5iE16V0ckBgqc6BMlJrskEo6SNufH5gSp
 BofYGhUhaFqlKJqNQ4bU8V8CEmKVxgGk3wPU7+q6mLf+n6mts6DFakF0d9sTGEIsPoNe
 j+X0nb9G7+0mpEWMqE9Yq7blZfCDmjWHnkDX+w785du84icsksr5GvlF2TxJwpj8qgdS
 UN7DaeGlvYeCG3hs4HdsMdvVwHxY1EjMqTZno0sRThEZTym/21LEbTCxitaYwoIP6gFH
 c4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519926; x=1781124726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5D9fCZRFjaZo3dxmMgfect8txWU4hAoTsxjlMPqDAA=;
 b=BUk/8EjqGQOilBJb9H2+/Nzjcpyuzo3ZVG1uEN16aVYNDC0aCLiQneLzLkZtLWaSqA
 vhwVR+yhqDLFHLLv8+0OeWKmx1Bi1oNqYLd8fog++TNXHYsQUonvNXD9s18V0kspAZ28
 AHq6I96fXbXPlsNqmnt5pHPXMO+R/boYt+p9R4nSnF6rb2gxlJ8QySzR1Dpt/kEJxGFv
 dj67pGHYhEnDzDLadCaTH346/PvHGnu7X6v7+44FVfhYfzxYkaeFjQ3T2e+CSo/A4nK3
 TdpuQpgk8V9sYiuV8O5qB+Wgu6EVMmrdiiF2TL0C+vou+j/zxi12sYNCQD0V9PSZrlTI
 jtgg==
X-Gm-Message-State: AOJu0YzYg+XTgbCdZwLrucjC+f07jQE1wLdN7Z6Tz3BWbSDg3/EdRTDj
 BNzOG1+ode1bt1kGgY5W6iOGPJCP3DN6IN4wJ/8LuNiBVEFKS8n7m/HL0LwpN+Kh+LcMsNlIHfI
 4qqdcOOyN/q7fR8Mboc5euFAY8mKruv+PvWvMeeX+4sqMf65gTlJjXfnB36cqEIWekh/l
X-Gm-Gg: Acq92OG4ITxMzTFMdHEtHFpQFK90d87wxAc5VXtGlCxsaHEYnFr7WPpRsm+TynSUFfL
 crhq7qkPL54rTTwNM13XYQ8VuktcEdOv0oKSHEpYSKuds6UfDOF6IkY2hMAPCYSDxoFxXaVERWS
 nkkaSpAPGFGd4P9kBeY4PigJUAWyIm6Ftg+ZUzlkdgea9gPr3RH4gBLYRF63AG/rHO5cultwu9z
 eZJi6tsFNlIQ5L0+O4xvDF+vD5uzboCRRkNLiH5rOqKAdzd7M41f4RBlxnQ9Z1Qn+CRVLLGFTWF
 OYJBphSb9EPtsM+CKykLPaKRIyf0d9C9LbkKigtqC7BLMw1dNONqfo42XQbG4k4pVHho2g2JE29
 qRkKM1EMAIyK2LpR5l4VVXIy0QTNMbosgk4DlyFZ3lizAK46MQFdyeoIYe2vi2gnD8VnwrSOkAT
 vi8ToOs/hton+UP1xh
X-Received: by 2002:a05:7301:128b:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-3074fa80739mr2651141eec.9.1780519926340; 
 Wed, 03 Jun 2026 13:52:06 -0700 (PDT)
X-Received: by 2002:a05:7301:128b:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-3074fa80739mr2651131eec.9.1780519925828; 
 Wed, 03 Jun 2026 13:52:05 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 04/25] plugins: remove type qemu_plugin_simple_cb_t
Date: Wed,  3 Jun 2026 13:51:31 -0700
Message-ID: <20260603205152.1440291-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8Bm-LBU-LiKWR59c1TvJTcwJHLyae0G-
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a2093f7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=v0NQEDj6idUmN-g72lQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 8Bm-LBU-LiKWR59c1TvJTcwJHLyae0G-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXzaAMtw5qHU9A
 YfTIoqfnmkTfNIW1fejEQLzQQwmmd959w9LgF4I9DCgsrUgIgURWAg/cotyzlD4USCHqfM5SYRW
 u0E11DqBuUhzlx4LlL9p4axnil1vaOOMufuD9pdINLqEVVMyvXlpVSO3TfxwTyKxnPEc+Xjj5Q+
 ZdDzOMIoPekwYwECpDxxccS07vxxELz+uX4YDJbtyhvZndAKX1DEho5DIqPSMic4smR12Ae1CgV
 ICuNvo4YlEtI85QDNOHphGVyCDEvsQxdxCi028LZijDOavXl99eckbAUBbL+fQHrik9gGM0kOBk
 RfKO4etrPVSvX1aVcz3cB9PIdXDOsnAXtFfjmH5kD0AlICyVgQUplDsbcpbwjiomxp6msyAYcHj
 +OtZM+JDjWj0yu5SI4NehkT6eybftU2mDUbxoJ66l1t5dYoRPgW/evm+s9q+yj1rFVhtKnumANP
 G1ryPtayIktQLe92b4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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

We removed all usage of this type, it can now be removed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 --------
 include/qemu/plugin.h         | 1 -
 2 files changed, 9 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 499441bde23..3c6f32bacfe 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -140,14 +140,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv);
 
-/**
- * typedef qemu_plugin_simple_cb_t - simple callback
- * @id: the unique qemu_plugin_id_t
- *
- * This callback passes no information aside from the unique @id.
- */
-typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
-
 /**
  * typedef qemu_plugin_udata_cb_t - callback with user data
  * @id: the unique qemu_plugin_id_t
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index ddd77bd82c9..dac08cdc60c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -55,7 +55,6 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
-    qemu_plugin_simple_cb_t              simple;
     qemu_plugin_udata_cb_t               udata;
     qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
-- 
2.43.0


