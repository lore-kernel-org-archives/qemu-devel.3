Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C1CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST84-0001yD-7K; Thu, 28 May 2026 01:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7d-0001qs-3I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7a-0003lo-G1
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKl91F1225043
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SQicLRGx9Aq
 NA2i+SQ+hciCKf46RCclwzpvjGIEa+vY=; b=Da8fwXi92CpEoa3jx63M4WqO4a0
 rzxMl56Ypy8OAh13Wm8hNYY0YNjRUOrdDvnleME8mNl8a1KzonI/VrdLblAAwknz
 FhQdMPlSVc5VVkgMJ86s0772gu8eu+IGUtDmsf2vafplEeJmFB9Oob81Qn3+qlsa
 aayjgRXKWQSQtGmSXhHN5p3S2Yd8oKBtw1MkSEehDtInXty8wHSilbZ4/89LFx1r
 WgwNmVzqtwjhOkflyEIsP/pZVxDhfgU3tMxSgdL5Gv2BfrXHDpyqB2p8Q9WWeHL1
 4NfisSeWzcLXn/TRK4kho+zrNXCyCsLQ+nuTwQBf9nAkn4RtKVS7N67BZLA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y1se5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304bbf2423cso1635076eec.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945439; x=1780550239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQicLRGx9AqNA2i+SQ+hciCKf46RCclwzpvjGIEa+vY=;
 b=id2dkt0d58k5myS2GVNTJr8+Fq8nYtyIQ+7UOZMcJiQ976pD6yJQvjmgqXl7GVWE8m
 DJ1+HTk8A0N8yBHm8yoJFRhtRzEmT/onq5M+Ecd+yTwnkqwRxT5Txo9D28EzlrTkoY5a
 Q+TsmE/yKi7ri380JdGLihQekhYsMWP7SWiH+gmXrlivDYzyGh8Hbph6/Pn6nKixucKU
 dlgDLdpyRRKN1rD+S4dqFm/E7nDAkqdQvcGRMPmRovjPYz7MljYJlXnnh1VoKL86C+Ea
 IV4VL7syj/qrMfn5FeMU4aNALXjSjfYCvkvzSONvM9nUdYB5KsJVFHPQO7JuExn0t9Zp
 RE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945439; x=1780550239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQicLRGx9AqNA2i+SQ+hciCKf46RCclwzpvjGIEa+vY=;
 b=tGfFDxAuI1a9hr+r0nLWCmjvtBMy0LQVJu8jr2E3E1/BrPuxZdWAyu5yFQFArQ/hJr
 4msFx+QBlEk6ID3DQAXYnmIXHALq3qm/UQk/uBnh/8ADEFATd/eAPoaxFsh7JVJkRuHl
 Fi3VdsPbE/GvYFrqGOSxav5iPZm/iGVNzs6ssqKyxpphjt+CQ9sj73o6j5fxg/uDnlbe
 UeG/epKAQWd2R09FEyEkYftvNR5LJSTBkgDpMfyt2zU7BaeG6vX1L0DEpnP0sJdfUkmH
 EzqT25GUnpjEs3tsgAehpI8XbnliKUSRUgEooA/KjeGlv8suTiapsOla4qZ6vI1YQUXq
 AZ6w==
X-Gm-Message-State: AOJu0Yxbd74IL+WNkqHuqxKgOOfEyIzj6ff1CdzdpcUwnt0Y2G/ABuls
 +Q/uUedsytIBxO71kMrPkMeMUzbzAsDGuQR06iVlNCEt/2PDAtIMkQTnM+sYxqx1kW3dzUFweEM
 b3KKIFsreAwwzKyslFSRBdagBY9qsz/+3njqNdoZW6VRXlp139EEIy38GNtrSq8KIaF0l
X-Gm-Gg: Acq92OFeiivuKP5ydSwveWYEXIR1ZXPfKZzRKyLXIeGu5ThOQw58SMna0xselV1znza
 A+OAamDhZEsl6bF2scZ1K7JEUFN1LZeDJmgiwlbjnDlCBkPj2Sn76C+6uAiw3qsSbELmRQZspVR
 lo4Au2COODPaJ7cBwpGOktoOvdfgLG/3rgbzxjiqRUwsVg7iJ20Fop8B1m03uYYPMcGGFR9jJk+
 hwcUBn+df6js/HQJ9xAGRt6iqa+Dw8hb6m9Y78bVGl+pkDK2C9FulIr8tFL/5G8BF5xhFFokWd9
 9yRgGu6P/nNr1+i8agvYEz/lRHSYykRalNZcDydWjLA1rEMHXHB1JMBsGVTgtAhE4lrYLd46RBs
 6nMt8v08urjw/lw70ccSH4nZGjiHWxraNXnnb0JRB+pVzMPTmqZk1RZQI15l12rnkZ/vGzfTAOD
 iCr405JGDt0gWZSvbG
X-Received: by 2002:a05:7300:cac8:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-3044924e434mr12154111eec.33.1779945438199; 
 Wed, 27 May 2026 22:17:18 -0700 (PDT)
X-Received: by 2002:a05:7300:cac8:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-3044924e434mr12154072eec.33.1779945437681; 
 Wed, 27 May 2026 22:17:17 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 05/10] meson.build: move some subdir before system lib creation
Date: Thu, 28 May 2026 05:16:37 +0000
Message-ID: <20260528051642.115721-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DsNmPm/+ c=1 sm=1 tr=0 ts=6a17cfdf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=U9fdQpnawWpsFQoWsjIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: WNwkTIKx9b4gknz7b66FCPTTB-riIFes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX90itOxhWUJsl
 TZS49iUTCi70nQuNJrPXxWJ/wnVBFuwU+jnnelAymceh099jsXx/6pYsPF0RZK86UgzmxEm7ygH
 n2d02zWh2S6o2V8bZ/fibHXLcw06XIKO54EB8tg7ImX9Aj9ZWlPUe2ndymXnLumqnpoccITyCY9
 Gu4Z/X2auaWgTwuMUR++dp+vmNiRhvUUhb/qwV3JtmEm+i2prNcHvLRQJflEyuFqv/e5CtrIZFh
 hpOgpp8tEmxSt1E2fMLV95WUQ5yFix0tZm4/+N/foX/iglgQ8JDScHCGt4vBoPoScJrtMlKjiq0
 4oZna07Lf1v6VwA8Qqak73XvkaWY9tOrAHnROnH5IugGZhGwnMhVYJKJqeCkgIZPkx9V6wgx+7Z
 5WBYWLdiPjbmw+xOZH3EZ6iHZP+v2/t+SeO/5KG/ja87uSR0om5N97E29ihF6fVDNqzjwrsi/ni
 gHSCQIa0OxGDgFLJU8A==
X-Proofpoint-GUID: WNwkTIKx9b4gknz7b66FCPTTB-riIFes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Allows to use stub_ss in those sub directories.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index eb074918193..e3e8f1ffcae 100644
--- a/meson.build
+++ b/meson.build
@@ -3730,6 +3730,19 @@ subdir('fsdev')
 subdir('dump')
 subdir('accel')
 
+subdir('backends')
+subdir('configs/targets')
+subdir('disas')
+subdir('migration')
+subdir('monitor')
+subdir('net')
+subdir('replay')
+subdir('stats')
+subdir('tcg')
+subdir('fpu')
+subdir('plugins')
+subdir('ebpf')
+
 if have_system
   subdir('hw')
 else
@@ -3838,19 +3851,6 @@ system_ss.add(files('page-vary-system.c'))
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
 
-subdir('backends')
-subdir('configs/targets')
-subdir('disas')
-subdir('migration')
-subdir('monitor')
-subdir('net')
-subdir('replay')
-subdir('stats')
-subdir('tcg')
-subdir('fpu')
-subdir('plugins')
-subdir('ebpf')
-
 if 'CONFIG_TCG' in config_all_accel
   subdir('contrib/plugins')
 endif
-- 
2.47.3


