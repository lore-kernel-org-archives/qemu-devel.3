Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACCDCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C3-0004IC-Ne; Fri, 29 May 2026 17:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C1-00042V-M6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bu-0000QM-MK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIesG9117825
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=EhG1Z8+z+lmM5fNK
 yFyF8/qUOy4vrwjrk7ML0pWGLPLBqEcE56l6pcyUhXPgFUso5DCGckGcecVE2ct8
 s+pbiqm7UDUBsfXWCbXaMehr6hMAt3owD+wOLQEVavBxYzP5dwLiB5W4GXzo3V0i
 sFUjtHGYjXSnO0W7sliU0CAOjpBNUojy0Kt0hkGM/wjfkTgazGeZTMNnVdB0jv4Z
 eTf5dIHXr8BLhtHPv81m7t3YzPlMJA7af99Qtlg1Iq1IUUZotM/DS8Q3jK8SSGf+
 a3QVY3zOTQEqgNp/4Dcdr0C3cOK4OJKcuffHzzUVbKLJgOmHzyO/Oz8bz+5j96Uc
 hSQJCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrq93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f1820babso1363964eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091779; x=1780696579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=Lgpc5qUOHUE42WXu5L3lHEwFb14+rL+AkAch8E5P6LRUo+N/0uyQ36ikFQAu1CnQQz
 91E/DVpnZnrQnE9tOqcfBVRzCFNGo3kNeztpjC3FCny3/2mt8tVK3dZy6x2zxUU3UH0P
 7LPC1KvwKiGB76YynDlBn7xdLBr5IrPZmd6WjOtVNt/ha4+JWJEXWrUtXD+B7R7c6DNs
 h1dkmkz+UC9sCChEshrs7kEAhTlTHAn7tS5TqKMMr/8LEdrKge+7Nb1rj31FYD1KX+BZ
 Y1Oyg38vc/xP43FDdf9pDyNo4tnojDBJ3aP+hFnuMR3vi2EWCi7N4Bl0HGYv3chUFKhn
 KgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091779; x=1780696579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=Py+33LiVy97Npi+krlUvGyNJK3tRqG/P2cI1CHi2GGn/hcqsSWXNfiSfimrdtMVasS
 BDyylolt1C95zo80jT/Jy/Xe7az+0mJFR1SpH+t7Wp6EoBlgs7YbRorr6lHJGXxvihZP
 V2+wAXd++8y5sFr4tuobluR0CJwidybFrrTMv8u8Lyj1BAD1jPlSsWop+f9g4SWtuHM3
 C3sIFimyFXswvTgiSA7h/ohT+/mvr+Q31YfCiW6N8meySz2727piMj4mnLH8nJJB6RgR
 hywURfqEAaAkTi0cOJYKYekEae/7K3d3VOVwDoAfQZoh6zIM3NwgMWOKo2GWehMXcgFa
 7LTw==
X-Gm-Message-State: AOJu0Yy7Vht9ZndRpWOWb6575bkdmSxi+Dqzfrm2ReX3EMyzSLwnmj5I
 GrkFG351pQ3nStvO1U93o6EdCyc8VbcM8UxmsCJ69K7qQcQZENsHXAxl2aLXDvy731MBHvaZNJN
 PGvJ/0kfr8C+t2eovRpo4jOI2ooFwma8gpBokjc0slElTT7h3VjN9Lot1XHziYq1OMw==
X-Gm-Gg: Acq92OHbq0W/20ggYA2CDryZyIC9X+msar3U+1epxk8uXTLb9CV0575OrtPPUAq1F8o
 upkkaOplHZUT58LT9DXCRXYhT/UdpNxgfEMEBIELsTP4x0v1B1BdXPeh/uTtmlN1srTTM1CA/Lt
 gBWQeGO5yS6viV6l4B/jbUcEOQUQpY8pjmXhC8RYcs5eH65z8EtKe563nR2Vs8nOd1vcs2waDCF
 PFZC2rUleku7PT/Fq6ka8w2mzO77+kaVT1wS9pWHWJzPC8YD6XfKliOjA3gHY/2rORHSrGDAfNy
 gvawn0ip2ZhQ9gm0EqP0UveaXFsPHMrpT4hXCl+LYd9B+rGfieXFHr+mGHIdcV6C7gp+L6BOkOL
 0Bw8w0bbJDW0kFnzoH+v3OEsF7UQPa2QWVyxcMb/i0xwd3U562sf+EXP8+Wvlx8CDtVZxlsU+op
 0n9p1p
X-Received: by 2002:a05:7300:2214:b0:304:b93a:5107 with SMTP id
 5a478bee46e88-304fa5e84a1mr881167eec.21.1780091778836; 
 Fri, 29 May 2026 14:56:18 -0700 (PDT)
X-Received: by 2002:a05:7300:2214:b0:304:b93a:5107 with SMTP id
 5a478bee46e88-304fa5e84a1mr881150eec.21.1780091778289; 
 Fri, 29 May 2026 14:56:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 12/38] target/hexagon: Add guest, system reg number state
Date: Fri, 29 May 2026 14:55:28 -0700
Message-Id: <20260529215554.606133-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfXykdnqhUM39mb
 EOmoUVPUJfhLhnHbGl7vdJdhkY6wRzdqttRKg0eMmRlPh0iaxH3s0HCwLvN02n6d0DmvPYIqJRj
 w/yK4u9uCe4+1zdQO+RAX0tFHcACUtBgLP62ccs9Q7HYisEsP+pzhqzcGAHoC7qpaRZShGICgqH
 +OSJnZRVjS4C+DDNT2pMmfDf1GYylFqqNOEj/V9v56SXbZQLxTfp2c2rPoezb8F2Q6cw4HJLmDt
 tP3PTC/oHi9NHQP363LnZF+1OGFpf4GeQIlP4sfcVjv9BvMvzkYAIhEAcxxsUPOyW8DotzfMEkQ
 t8GZi0nZOs++pJBPyXptg2UTIayNBVynTKyH1BjxIQR2AZmh+2bNB7DsNWsQDoWxlnao2J0zMte
 o+P5oh4/FNHnfE5ItkTtZK6Lnb04IZHkl4n4JohM1979yZ/4HWaIDKOD/50krzsUdjwSq6FptZx
 wLDVDdHnoQa4Py0bkmQ==
X-Proofpoint-GUID: NNeandZt5D6G3k--Z0hrZgmsZwqMMT1R
X-Proofpoint-ORIG-GUID: NNeandZt5D6G3k--Z0hrZgmsZwqMMT1R
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0b83 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

