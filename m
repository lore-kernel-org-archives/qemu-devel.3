Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2FFC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tq-00076R-JR; Wed, 12 Aug 2026 02:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tp-00075j-6D
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tn-0003o7-Gu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C629p34090916
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=; b=B0
 FNLp2oGrGpkRlZRXAc4MrWrEdmJVzY7+zWmTT70vqS/yIBw18N/+u+At+cn29v85
 ufJSjaj2HoMa2tlHnC8mC2BvcvOCZAYUtqt8RzAojRIrhQpdofEgB/EsrXz3MBsw
 yJuixllTft9Jf1PeXp9ZYTry+/jhndTQ+TOMV4AMXThsLXA+bZ3dpJhq7AzZVkmB
 em2oO/5IYvN9/BxpjVhjkFs9SNOnLy2joqNppCzFDCGvmMWn/MSKUaaLK4IAsbjJ
 XON0oIQq2SLIYJ8XwH1vwlfwHHQ5cZUAnF93K8Lgf1zL3jJ6SXqsuJqg/x9pQg1N
 Sf5DEBIDjU9MF0m5Ik6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049butrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so1550578a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516221; x=1787121021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=;
 b=SzKD0DY/qUaH01YJMzEz6B6g0i8Ap7rWe9POs3zNhWelq4+qOLSJT2/EMbIItKboIz
 KQtiCbgWTORqquKvUiVKwfg6cdb0IxnjV0TMzTybivNLIGD9i9b0qI+5rJTm7zJI5PaU
 FhKkN5q/CRqVEzytaUdBl8Tz5oshT4yoxgyxyP+P3xNRuJLod8P8Wicjr++qZXHBZeKc
 HKiXpgQmd7lPVqXa9Avrvs/iuYhDrrIe4MnmXpK2NQ4Hf0RNQrn7fGlmmQVUqNMYJ1VK
 GjXHuldtLGADb5ZoHpWyyQJmE6kW8Ic9dceQAD9f0MPJkIR1wNppZhquRccXgG423G/S
 +8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516221; x=1787121021;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=;
 b=TIORo+pqWbLUX1ilbqcPS+qJDxZlEFEzI4jBRhWk7kYdB06M/XFDqT8UkzbDArFvdY
 X8uTcDiQDDUSpTJ07O1cpRe69WHWYTjEujzNiNUT6Kjeg6NO4BgUI0KIvHFqc/hXi9uD
 0n4bhGShIMdUvdHM6Nj043TVyTEeqfTJNpqbnHqMUEsr3kqdXBUGQQXiGByQYNYz+SP4
 PHT9L40dDcAJ5xylLuZ1eL3ehosXW+mJv4BHTr+E87EphYafmW46nLf4CF34MMljuntU
 EOsH85YtwJFIO0eBXf8uCgJ54+bxpluc7bwIehHMgtc5MBRLQbYw3gAusZ2JJTBM2Baj
 dfrQ==
X-Gm-Message-State: AOJu0YwmsW1xgGySaW6+IOxHxiZ9WTvJJ52w4RUUz5rMEyVxv3E+8qkZ
 v0eyQb/PZKlpTjE8h3fbkDiEexWcSB2tt+9QG7tVCIy7ifKEpjdRutWPGisvfDC6iAr3GHVmQRL
 DulDrzULrxnEMbaVkZz99eOH1tKGviLO5Hx3r9wRXyIE4OElv7x82Bjl/mjZL0pyX/A==
X-Gm-Gg: AR+sD1019DrPxD5rwaj1CEik+xVR+Xe1SiUllq5f7sBf1LjMW9Qb/DqP0KuNjBxUnfO
 laM0rHCxXM5ohXvMBwJXv2VTbqiy1XqCCjeCZepl0/WjH7dtaAvvnaBHK8ygz0C54ckZamnJaPx
 7948Fn8LVkU57LAYykfS45ana40gUwBrtTBnXCO+ztV7qi7iCj7hpNO5mtc6jIPhTtztOSwNbMT
 XdK5gBkZ8kDFwoOG270j+n6mRxaM+yF4isrgeTGoBi0GcR7CbLa72QhlzVHeynYiYVablJAXsrp
 YYkbY0BbeSPQq71xOr96itxHhljAlWznsJMyUoqlsyly61gcups801g71TDunQp/8szay03Vaqr
 vhjCvTs2Gh5oGZWdJv0yiEUA2jhFxM2uK7xjFRxLqZ6EZxrck
X-Received: by 2002:a17:90b:48ca:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3930142adf5mr3272125a91.15.1786516221029; 
 Tue, 11 Aug 2026 23:30:21 -0700 (PDT)
X-Received: by 2002:a17:90b:48ca:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3930142adf5mr3272084a91.15.1786516220652; 
 Tue, 11 Aug 2026 23:30:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 12/41] hw/hexagon/virt: connect pl011 UART interrupt
Date: Tue, 11 Aug 2026 23:29:03 -0700
Message-Id: <20260812062932.543840-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: mld7U2rHcx1ium5-ykFxJ2MFqvhHHHGV
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c12fd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AqOQjYCRd4s2zt9NDMsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: mld7U2rHcx1ium5-ykFxJ2MFqvhHHHGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX6++xdrelFtEp
 S2ZIIF8OvTO8EHX2SYQgNIAUv83lrJZ3tkRF0KHT3i5IEcSTUs8IWQeG/lhYVbLpKkFhJwXfal9
 lTEvZiXK+iMs7q6fm6eHlPjkLqEJ71lqCl/cIWAWW/NmjpYjGXOGXRmpGDuIxksSY7gkwTzGjl8
 X2SGCq8rMA1OhFcNHmhCeXYoC/cFH6OvNtI0igAedO6oNP4wZfx3qjfNnxfrxVxihbLyt0o6zws
 OU/Pg+YKKKoW8m90QWq3/lwnfpIY+mncsx8u5EEYAnQbnBVYK6ht/WNQ60FDozImx7iHKfUvom0
 bbOGX2V5nBKBN9WAuVjdV5BHJh4f5ZQkqadcJpIuvUfXN9RAOAM7s5KR89JcS1ZRMcLaw6fXUSR
 dfBTQnxiz0/IV32rNSlpZDL3ZG2/KRFdkLU+buQoYPdpofuS/p1A9uX8eMLWurJZJqUsjI0w3n2
 sqXjrGL80y+zpWPrQxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX9hxQGQbbr2yO
 5Gtb+FQZ6v9U+0lgGUX7kkPmrHPDBSb7Rmv8c0e9vnQGAhv1tDk6l968/juOSBWUX+JyfnnwHRi
 TjtMbF19jHhMISexYDaVB09IJ2ic714=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

V2lyZSBwbDAxMSdzIHN5c2J1cyBJUlEgaW50byBsMnZpYyBhdCBJUlEgMTUuCgpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUz
NjktMTMtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL3ZpcnQuYyB8
IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi92aXJ0LmMgYi9ody9oZXhhZ29uL3ZpcnQu
YwppbmRleCBlYTIwZWEzYzUwYS4uNjRkODM2NmQyN2QgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24v
dmlydC5jCisrKyBiL2h3L2hleGFnb24vdmlydC5jCkBAIC0zOSw2ICszOSw3IEBAIGVudW0gewog
ICogVklSVElPX0lSUV9CQVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEKICAqLwogc3RhdGljIGNv
bnN0IGludCBWSVJUSU9fSVJRX0JBU0UgPSAxNjsKK3N0YXRpYyBjb25zdCBpbnQgVklSVF9VQVJU
MF9JUlEgPSAxNTsKIAogc3RhdGljIGNvbnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10gPSB7
CiAgICAgW1ZJUlRfVUFSVDBdID0geyAweDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCkBAIC0xNDMs
NyArMTQ0LDcgQEAgc3RhdGljIGludDMyX3QgZmR0X2FkZF9jbG9ja3MoY29uc3QgSGV4YWdvblZp
cnRNYWNoaW5lU3RhdGUgKnZtcykKIH0KIAogc3RhdGljIHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0
IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsIGludCB1YXJ0LAotICAgICAgICAgICAgICAg
ICAgICAgICAgIGludDMyX3QgY2xrX3BoYW5kbGUpCisgICAgICAgICAgICAgICAgICAgICAgICAg
aW50MzJfdCBjbGtfcGhhbmRsZSwgaW50MzJfdCBsMnZpY19waGFuZGxlKQogewogICAgIGNoYXIg
Km5vZGVuYW1lOwogICAgIGh3YWRkciBiYXNlID0gYmFzZV9tZW1tYXBbdWFydF0uYmFzZTsKQEAg
LTE2MSw2ICsxNjIsOCBAQCBzdGF0aWMgdm9pZCBmZHRfYWRkX3VhcnQoY29uc3QgSGV4YWdvblZp
cnRNYWNoaW5lU3RhdGUgKnZtcywgaW50IHVhcnQsCiAgICAgcWRldl9jb25uZWN0X2Nsb2NrX2lu
KGRldiwgImNsayIsIHZtcy0+YXBiX2Nsayk7CiAgICAgc3lzYnVzX3JlYWxpemVfYW5kX3VucmVm
KHMsICZlcnJvcl9mYXRhbCk7CiAgICAgc3lzYnVzX21taW9fbWFwKHMsIDAsIGJhc2UpOworICAg
IHN5c2J1c19jb25uZWN0X2lycShzLCAwLAorICAgICAgICAgICAgICAgICAgICAgICBxZGV2X2dl
dF9ncGlvX2luKHZtcy0+cGFyZW50X29iai5sMnZpYywgVklSVF9VQVJUMF9JUlEpKTsKIAogICAg
IG5vZGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvcGwwMTFAJSIgUFJJeDY0LCBiYXNlKTsKICAg
ICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlbmFtZSk7CkBAIC0xNjgsNiArMTcx
LDkgQEAgc3RhdGljIHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0
YXRlICp2bXMsIGludCB1YXJ0LAogICAgIC8qIE5vdGUgdGhhdCB3ZSBjYW4ndCB1c2Ugc2V0cHJv
cF9zdHJpbmcgYmVjYXVzZSBvZiB0aGUgZW1iZWRkZWQgTlVMICovCiAgICAgcWVtdV9mZHRfc2V0
cHJvcChtcy0+ZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLCBjb21wYXQsIHNpemVvZihjb21w
YXQpKTsKICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVn
IiwgMCwgYmFzZSwgc2l6ZSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5v
ZGVuYW1lLCAiaW50ZXJydXB0cyIsIFZJUlRfVUFSVDBfSVJRKTsKKyAgICBxZW11X2ZkdF9zZXRw
cm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgbDJ2aWNfcGhhbmRsZSk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9j
ZWxscyhtcy0+ZmR0LCBub2RlbmFtZSwgImNsb2NrcyIsIGNsa19waGFuZGxlLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2xrX3BoYW5kbGUpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMt
PmZkdCwgbm9kZW5hbWUsICJjbG9jay1uYW1lcyIsIGNsb2NrbmFtZXMsCkBAIC0zNDIsNyArMzQ4
LDcgQEAgc3RhdGljIHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRf
YWRkX2NwdV9ub2Rlcyh2bXMpOwogICAgIGNsa19waGFuZGxlID0gZmR0X2FkZF9jbG9ja3Modm1z
KTsKLSAgICBmZHRfYWRkX3VhcnQodm1zLCBWSVJUX1VBUlQwLCBjbGtfcGhhbmRsZSk7CisgICAg
ZmR0X2FkZF91YXJ0KHZtcywgVklSVF9VQVJUMCwgY2xrX3BoYW5kbGUsIGwydmljX3BoYW5kbGUp
OwogCiAgICAgaGV4YWdvbl9sb2FkX2ZkdCh2bXMpOwogfQotLSAKMi4zNC4xCgo=

