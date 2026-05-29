Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B27CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5ES-0006Bg-CT; Fri, 29 May 2026 17:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EK-0005yv-GW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EH-0000yi-KR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2FOS518305
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eP6hz/AmRKjYoNqmBmo0YYeVSElPia5t2McZa+K2uYk=; b=GYNwfRz1BosDasDY
 bpjhIqkYuGqnUX2tg7B62dn8U0+PDLyUhQDbEfFQNlys6by3OjK0NWjYBli+ASzA
 O+KH2R9OCfQNDT2QQ8WYzJvWdzK8qk5NEew/L/l4C0QEl8YglgFfXR6KXdRkuB62
 Ya7CsC3VuY8Yl5bPZ8GGOu7KYllynSktynXWC+ZP4iqujKM/6MU/qFiDm2ciRRTw
 okj2ag4YiAA5o74PtXTBcR3gI6RirmNtTBZNhRI49w9WHOvbwCgO3371SwLqrvkd
 JGil8G2l+DjXrKXzg+6Q6hztdc2paYxsvthMq6tR12hSjKbVzCD5VOtV2X28KQJF
 ETmDGg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechhm0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-135916eefa0so5175689c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091926; x=1780696726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eP6hz/AmRKjYoNqmBmo0YYeVSElPia5t2McZa+K2uYk=;
 b=IBTgw5fSYqPj/qV/Hhm7ibiXzY7s8eW4ePoW8OcdyAIuKH8XQkuwnmbeOf0Yq6O46y
 88lnjgCs/O2NdeFc51BCyoe/RiEywq9wptQX/DOndOd/PeEEYZCe9tC+8pVyNw46mRxD
 /P/GS9mzi6/W5UGhMltwWUDomZzigwTFeHXDjo1dZWuMcn4gqYHEdER1EbewLfeeW3Vz
 ZcY4EwKzx/ji/Yi/61PklxZ2WTQVqyGPc4gC7bVqR5BW5eSRTRjMc3o4qyhdz97eotbJ
 PGSx0TQz5qZGhAPSanoPsXfRFRHNjLbdO/NzM9kATa1mdFlvtvlewHDB/LaRFgX5fvyj
 qspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091926; x=1780696726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eP6hz/AmRKjYoNqmBmo0YYeVSElPia5t2McZa+K2uYk=;
 b=Mkob8KXwoeXHABNjSyrfGX08nQFMLU40fs7mnKgUNkPDFKnYRCaLy5DsyOko2dJRj2
 sMdDqJYHvgmUzQey9MWhy1NA5AQFLP9d8Rwf4MgJYE+WpyumP/K8AghKMtSbA/G6owNt
 pR22PtERnicBgLhDH3GUcEzRYzyv7xOVrxEQ/O/oggTe3oF8fBjK+GBMU8jbT5Oke7qr
 SeIPsy4/x0GYSzXOyfzTdmrhn6SSPhWOjiqBO7o/Sw7R4ucVQLTbOxTRNJY8T3lkbVm5
 tH6vGzXYrBet/cGsso2xNvrJfHmGTFVnwZSTgUlOZWs/NHGwsghHlHU8XMqezjVQpTCa
 DDTA==
X-Gm-Message-State: AOJu0Yx2an8daZoNGSwOn32PkMFpxpOr84XlXcWcUFvSXnxZg7/seDwo
 3A7yQKBEbObHNcyxwArhYmA6Ro2Rk9VOFrSj60mz8VJbQfbSbHraHP4ate2sUWk0ZfDQbCb/e2B
 4NMX7m6eaW/G8T+1IXRXKNTdhefnp3A1AIM9Hqp/x6jf8QFWNnrCCHBSgDyEPSJav4A==
X-Gm-Gg: Acq92OEP+BKntHjhlClCFA0ASrgTMklDebBCsCqbB4TvtF69dfLUnTjTi/xP+pB5H78
 FT1UeMi3eMN6SAdgNVVUu6zcwJmm1thAn9wwMhLwChaVoUyyodFYZ9QVKELTnW7+1eAYsW+ncyy
 ZTDs73ycCC99Fx6lK3uYDcwUguDLIIs88TpmA3epAa1IJn9XwsGq79WpgxEnpnxHOeCWtu0tj0Q
 sRNXf6zfVke8eiiEjx3CfajjPhHDd7D2z3/xUCZAGy7wCYDOTJuoI3cRZLSRm0ayVh5iLLbva6v
 YCGjkeskTk3AJrVmsCh/mx0Kt0DUoPdlsX4hGvT3+HF9Amj1b1zFUxNyisYk0d1l7JWX8+AtAbo
 PIX4uyYtMug4oilbrR2J8IkqJRs8DThP54RL+2f6QHsXmkaqaM3DWyT4BF2TUexoDDQcisYB1SO
 h8nYAH
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id
 5a478bee46e88-304fa5295f3mr788667eec.6.1780091925639; 
 Fri, 29 May 2026 14:58:45 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id
 5a478bee46e88-304fa5295f3mr788644eec.6.1780091925094; 
 Fri, 29 May 2026 14:58:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 26/28] target/hexagon: Add TCG overrides for transfer insts
Date: Fri, 29 May 2026 14:58:04 -0700
Message-Id: <20260529215806.608770-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: a7I4ll6FeWM3Bw3rsBC48KjqOgq7z8X8
X-Proofpoint-GUID: a7I4ll6FeWM3Bw3rsBC48KjqOgq7z8X8
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a1a0c16 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/U4+gvGWtr3z
 OFwF+2g0/qd7zbND5SMbKeO05R7emmzlo9RYoiNatsU5Z9wSfOyT0aWC7skmGpBAVNPbEVsRHpx
 pft7hxoj4OKPBHBICX8RZSEI/t3e2xtfNFF0zLBIBZrgnUhIVZNRP62I6P38TEPUC3d2pVVk3gm
 2excYH53awuWag9C8FTPuhcA9EsKfZHChphlb+CNpMfdt9Jli14DsK7tVZaCxb6BoGUeXwT5N28
 JFbw4Glr1SBErVs9lrtbII+HO2emJVybnOKy8y4WhjcBGvlYafazDnlgNYFyDvy3mEjAPPIcuJI
 6iPQjb2a3WOUqKaQj5R6SdmMXrCLlLG+B91xpiN8rxnlETcjkod8OOEb/CsLWz6iQeaNPFZyXr0
 +uZ6LoCGdoKhtxgbdGi5eHMCoIH2pbCai3QLJhYiz7kU2xpHX5sd5NLh+nySgCaLU3A72ZRUynd
 loJEDyMp63cAj3T8WPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDk4Y2Y2MjE2NzgwLi45
M2NkNGU3MjRiOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

