Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9707C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39d-0001g2-Vy; Sun, 28 Jun 2026 23:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39a-0001f8-Sq
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39Y-0006G7-EM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d1SU1554638
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=; b=iz+g5/cp0SWPpOwE
 AoTFHsq7OMTWxsleRf2PVWmpleNtPUrT5mBe2yjSKpT1hDZ9P50+iJAT6jYgqwJv
 nYdv2LhnkOzIbWkWtYBsKxasjA3YuypA/vermOtY7an0gLF2HR8sWWjjT7JXt0ND
 jQ3AsxQD6JTecMpA7KcCVZHQqJEA6458nPDOMT86G5XKyUNKSPJnQdmzTLPLVuEn
 1p6F8kRzPKHeqwDoGPESHOLFA556igyWo8dPN7QUyzwnFdMLf2MgH4adQcU0sI1t
 iUymKDS/p9s9ABCq8RFYScvdGTsZh6oUUV9GJbxVzqCmigLyKL017EImBS2bY41j
 bASSCA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74e8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137f3465368so2930401c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705553; x=1783310353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=eVGjFFNe8SwzNF7OE4WskNbqdcFvdV87LuXrTbiIec+/O/NuHTieC6y9tF8ScVehuP
 KNWTHXia1nCu1TeUgkSAoF6YVF4o8YQmFkiKeyGy81gfLjcZkD2A8IH2pIVPqKwLg3JT
 PSYlq2cEWZSpTdZGY5dw48eLHZ7RxVuvfSSo8pAFs0K3TR5/3mTmktW342wtrBf3QxBm
 dbW4nJQT5+u7n7fMHW/jXVKbymh8PCdncRJIwOtfUFqoKIJBorodf03c9MFiP53VWHXn
 63Rco1brSnj5Uh2I6HomSI4a9UBLI7tTUcEPfJdhPJDXoqw+xrKrRWAJ1mz3fRZYPSFf
 floQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705553; x=1783310353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=OivvlnUeIi+Gt/Fnc2WTAK4bBy3Rl2NM9BPSeS5BOnMcF1TtBviGFl3UKB2q2vWJp8
 WVqAeiihELsfjfTzcwq4Ygnfzp9g93VS0VL1tm+hNNSaazHHudFLTF08ScyIu5oLul4w
 Q9GlGjCoVfpN1iPq6nOetbsL9y4LNZo04yeeeWqJ2/SQDEakfOJCFHn9ilK56Uzi7+0N
 7EbXEvo6nKekU5DNCVsUodXM3cb6hKR1OpwdOk9F+jxlHDLlJf+JFVvMRx8U4tW5h9y3
 UANuHXu0/0FGeKm8PY3CrlmFnz9uVC+/NzdlTvqSgjzkJUtTegCNrCnEAjwfTMaEq8ez
 es8A==
X-Gm-Message-State: AOJu0Yzgy7KWrobrKs1i340fi3CjZRs3W6QUGaaEkvKL5lCo8l9SSacL
 am0Z801OPFB0uilnygTVdXBhboKt8ltR7VLu8jtZ1af+KSM3iBPAaT5wLZljJkeC2LNDF+cWXqK
 v4xUr7vWrW6DQT0rlfblho+zdRsBGXpuYmgVy07EOa2JZcGxSnnsq7v+mPXEy/twvLQ==
X-Gm-Gg: AfdE7ckQ8fxdLpzwAidVOB6lcgyUO6e7LgojZzKTt2MeCAsTB3xJ9nvo2w0uP6w1ZTV
 yqVMPIJ8/aG8hbECfTSfshecdfb286lCJ5zTvAyVcrbmZJgWAi7tzcMHE+TvtDOqjZPg0Fc5g9d
 ZfPLNW2BLxM5hFJPoZudRYkyAGDOXm8fvSdlFPE7LWHimgZZ9AYniU9lJ47iwk0dsjL2n3R6oIo
 s7D3aKUKI5ohltDWBtIDWkkn0ss9VB4qayqG4AeFxVJXALWHuKuXD1DbCAf45T50hhTsBntIbId
 PgOyswG7xfBE+17fSBspbvzF1ioOtCwjDxaMjpp3grZ7BO99S0yuGR1w4L7E/W1ssLXlWo6jezP
 s24it6P/iXHAneadADxx23/Gf1FfpveecDFAtWCfwlKyWu6yselSU5CssO74=
X-Received: by 2002:a05:7022:6621:b0:138:6c:477f with SMTP id
 a92af1059eb24-139dbbc65abmr11474710c88.34.1782705552479; 
 Sun, 28 Jun 2026 20:59:12 -0700 (PDT)
X-Received: by 2002:a05:7022:6621:b0:138:6c:477f with SMTP id
 a92af1059eb24-139dbbc65abmr11474693c88.34.1782705551931; 
 Sun, 28 Jun 2026 20:59:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 20/77] target/hexagon: Add handlers for guest/sysreg r/w
Date: Sun, 28 Jun 2026 20:57:33 -0700
Message-Id: <20260629035830.1520296-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXzouopNvXpItu
 /6s1CJUZTeOZivGTY5IBqDQb4WV2yFu62rhXLxyIYpPqkA9xxp1RrH/wTqSTfEd+JcYk/ySfld6
 lJlk8VWfiu3pJ4KiCKev1vnSX/QV5xQ=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41ed91 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bD3HuWSHJh72aO7JEkdmH_bO-4C33Qo9
X-Proofpoint-ORIG-GUID: bD3HuWSHJh72aO7JEkdmH_bO-4C33Qo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4suMS/gOfwcD
 Z4vDbLhmfhXbhQHsCGlwzuCgRe0QCNSbsUHNx0HTMs5LuxyM+d+15iyb0G6zkdAaD40gbP2w5c7
 W0khbW/CHAhEuRGtqj+UY9sm36LoTw+QjWDl2XwMN4Rvnk8+W/H6LmWNOYz5KeW+2mq8c1BW2OW
 9n9QeKB3E3yn5aX9BfiJLIW1H34IT+pokLjXCkd2aIScWRT3x2aAuAJbMc8Rx/unue9T2AKus/l
 Tt4rEnL4s/piiVsypmBVYNDzCS85DjMFCjwkU8CnCChQGWN2Y+GdbPkU0KHmrZ27zDIZ+rH8jok
 FcdULxHBMsnHZmftvuqf7gosFcDABh5mYkMzExST1uZnlkk4IY1DQkBJlCrG8Gfe7mUTwX6yUc5
 s4LEBoTEAYj1vKvMlk2PrjtSNx5zfrg34UDwlxpFDsSXSDSU1Mc00qyMR3OzrbPLwvm48DhLwd7
 yu2uIE8sdYVi3GeImlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDE1MSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCmluZGV4IDVkNWFkYWNlNGIzLi44ZjE5MWY4MDYxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTIzLDYg
KzIzLDcgQEAKICNpbmNsdWRlICJleGVjL2hlbHBlci1nZW4uaCIKICNpbmNsdWRlICJpbnNuLmgi
CiAjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNkZWZpbmUgUUVNVV9HRU5FUkFURSAgICAgICAvKiBVc2VkIGludGVy
bmFsbHkgYnkgbWFjcm9zLmggKi8KICNpbmNsdWRlICJtYWNyb3MuaCIKQEAgLTEyMCw2ICsxMjEs
MTU2IEBAIFRDR3YgZ2V0X3Jlc3VsdF9wcmVkKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51bSkK
ICAgICB9CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorR19HTlVDX1VOVVNFRAorc3Rh
dGljIGJvb2wgZ3JlZ193cml0YWJsZShpbnQgcm51bSwgYm9vbCBwYWlyKQoreworICAgIGlmIChw
YWlyKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAgIHJl
dHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLAor
ICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdpc3Rl
ciBwYWlyIEclZDolZFxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAg
fSBlbHNlIHsKKyAgICAgICAgaWYgKHJudW0gPD0gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAg
IHJldHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdp
c3RlciBHJWRcbiIsIHJudW0pOworICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKK0dfR05V
Q19VTlVTRUQKK3N0YXRpYyB2b2lkIGNoZWNrX2dyZWdfaW1wbChpbnQgcm51bSwgYm9vbCBwYWly
KQoreworICAgIGlmIChwYWlyICYmICghZ3JlZ19pbXBsZW1lbnRlZChybnVtKSB8fCAhZ3JlZ19p
bXBsZW1lbnRlZChybnVtICsgMSkpKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBndWVzdCByZWdpc3RlciBwYWlyIEclZDolZCBp
cyB1bmltcGxlbWVudGVkIG9yICIKKyAgICAgICAgICAgICAgICAicmVzZXJ2ZWQuIFJlYWQgd2ls
bCB5aWVsZCAwLlxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAgfSBl
bHNlIGlmICghcGFpciAmJiAhZ3JlZ19pbXBsZW1lbnRlZChybnVtKSkgeworICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19VTklNUCwKKyAgICAgICAgICAgICAgICAiV2FybmluZzogZ3Vlc3QgcmVn
aXN0ZXIgRyVkIGlzIHVuaW1wbGVtZW50ZWQgb3IgcmVzZXJ2ZWQuIgorICAgICAgICAgICAgICAg
ICIgUmVhZCB3aWxsIHlpZWxkIDAuXG4iLCBybnVtKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVT
RUQKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fbG9nX2dyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpj
dHgsIGludCBybnVtLCBUQ0d2X2kzMiB2YWwpCit7CisgICAgdGNnX2dlbl9tb3ZfaTMyKGN0eC0+
Z3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2
b2lkIGdlbl9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwg
VENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigp
OworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIs
IHZhbCk7CisgICAgZ2VuX2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAg
LyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOwor
ICAgIGdlbl9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK3N0YXRp
YyBjb25zdCB1aW50MzJfdCBzcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10gPSB7CisgICAgW0hF
WF9TUkVHX1NUSURdID0gMHhmZjAwZmYwMCwKKyAgICBbSEVYX1NSRUdfRUxSXSA9IDB4MDAwMDAw
MDMsCisgICAgW0hFWF9TUkVHX1NTUl0gPSAweDAwMDA4MDAwLAorICAgIFtIRVhfU1JFR19DQ1Jd
ID0gMHgxMGUwZmYyNCwKKyAgICBbSEVYX1NSRUdfSFRJRF0gPSBJTU1VVEFCTEUsCisgICAgW0hF
WF9TUkVHX0lNQVNLXSA9IDB4ZmZmZjAwMDAsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gMHgwMDAw
MDBmZiwKK307CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9sb2dfc3JlZ193cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0sIFRDR3ZfaTMyIHZhbCkKK3sKKyAgICBjb25z
dCB1aW50MzJfdCByZWdfbWFzayA9IHNyZWdfaW1tdXRfbWFza3Nbcm51bV07CisKKyAgICBpZiAo
cmVnX21hc2sgIT0gSU1NVVRBQkxFKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX1NSRUdfR0xC
X1NUQVJUKSB7CisgICAgICAgICAgICBnZW5fbWFza2VkX3JlZ193cml0ZSh2YWwsIGhleF90X3Ny
ZWdbcm51bV0sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0IHx8
IHJudW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMy
KGN0eC0+dF9zcmVnX25ld192YWx1ZVtybnVtXSwgdmFsKTsKKyAgICAgICAgICAgIH0gZWxzZSB7
CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMyKGhleF90X3NyZWdbcm51bV0sIHZhbCk7
CisgICAgICAgICAgICB9CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICBnZW5faGVscGVy
X3NyZWdfd3JpdGVfbWFza2VkKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocm51bSksIHZhbCk7
CisgICAgICAgIH0KKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9s
b2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdl9pNjQg
dmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigpOworCisgICAg
LyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIsIHZhbCk7Cisg
ICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAgLyogSGlnaCB3
b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOworICAgIGdlbl9s
b2dfc3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK0dfR05VQ19VTlVTRUQK
K3N0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sK
KyAgICBpZiAocmVnX251bSA+PSBIRVhfU1JFR19HTEJfU1RBUlQgfHwgcmVnX251bSA9PSBIRVhf
U1JFR19CQURWQSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChkc3QsIHRjZ19lbnYs
IHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgIH0gZWxzZSB7CisgICAgICAgIHRjZ19n
ZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0KK30KKworR19HTlVD
X1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3ZfaTY0IGRzdCwgaW50
IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgaWYgKHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7CisgICAgICAgICAgICBU
Q0d2X2kzMiBiYWR2YSA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICAgICAgICAgIGdlbl9oZWxw
ZXJfc3JlZ19yZWFkKGJhZHZhLCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19CQURWQSkpOworICAgICAgICAgICAgdGNn
X2dlbl9jb25jYXRfaTMyX2k2NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0sIGJhZHZhKTsKKyAg
ICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kzMl9pNjQoZHN0LCBo
ZXhfdF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhleF90X3NyZWdbcmVnX251bSArIDFdKTsKKyAgICAgICAgfQorICAgIH0gZWxzZSB7Cisg
ICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3Rh
bnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lk
IGdlbl9yZWFkX2dyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sKKyAgICBpZiAocmVn
X251bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICB0Y2dfZ2VuX21vdl9pMzIoZHN0LCBoZXhf
Z3JlZ1tyZWdfbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9ncmVnX3Jl
YWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisK
K0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWdfcGFpcihUQ0d2X2k2NCBk
c3QsIGludCByZWdfbnVtKQoreworICAgIGlmIChyZWdfbnVtID09IEhFWF9HUkVHX0cwIHx8IHJl
Z19udW0gPT0gSEVYX0dSRUdfRzIpIHsKKyAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChk
c3QsIGhleF9ncmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaGV4X2dyZWdbcmVnX251bSArIDFdKTsKKyAgICB9IGVsc2UgeworICAgICAgICBnZW5faGVs
cGVyX2dyZWdfcmVhZF9wYWlyKGRzdCwgdGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihyZWdfbnVt
KSk7CisgICAgfQorfQorI2VuZGlmCisKKwogdm9pZCBnZW5fcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogewogICAgIFRDR3YgcHJlZCA9IGdldF9yZXN1
bHRfcHJlZChjdHgsIHBudW0pOwotLSAKMi4zNC4xCgo=

