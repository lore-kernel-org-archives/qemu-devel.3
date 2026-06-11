Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EBDCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3V-0002eQ-3b; Thu, 11 Jun 2026 01:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2y-0001jU-Or
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2v-0002hv-Es
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLi23724994
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=; b=maoZ57IV4RQb7qoU
 qdpyNeeDy1qCgLpsPf9y7Xvf1W4T50t46EqehcPq8aFczaddZQxtvwlDNvXNYScz
 S5QP8Pz2hp1VH4oPBIWIdl0oqc4vtPWSDJMvqx+Qvxsvcku43K/c2ScR64IjScW+
 piO7ERCBBuqJ6BisPkCNoCW42eOaATGB6gFCG0DdBp763iNDPsVhiXkztF0mane8
 QzSNumd2/8RUBbFU7GkPL4/mz+mLtkUy45aUcJye767NH8ZM30+xconobH9PXbjr
 XZ0bNCxkOmHfUtp3I8tiPNsQvYiMbo51bpbidHEOjvkHFDqIQHCJMqkgk4VdReH6
 uPuPeA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307fe856724so1885592eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156006; x=1781760806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=REIOKPutPpKOjc/I9wt4lcik81IHJuNYT3KN78Qy8rZ1TR9lSPJam77YkBv2IJN4EB
 Rd7W8VCGgnGt/OkAyUD+D6MKOX6TuvUeecbU2KcUrDZkm6AUF2Rpqixn0eYaHqHxP+1t
 ZZ2AqN0FGDcxW4Q79LJgHItOAMisGBHEnDDXUofKsPKitkD5liqkvSBIWGAYOCMDwf0+
 AKknRKiRiX+CFSz4XM32nIV6NkWBvyH2lwPtWVnDKqLnANa+MDRHD3ESMVYj0YTTOhuv
 fJ8AmlFCPf5Ykh9cqyThJQWblnegSSq66igZXYo8IFOSXHNA/0UPIaMUGUS3moib9t0p
 cibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156006; x=1781760806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=qP5Zhspywuc72xYNAKXtrJadwM4Ku/eXBPecTNRMAIcNcl4zDW3snlSmfcE2DxgatF
 w6zSa9iXd8BhZ2bZYVMgaUWWHwlG04bKRoC8cLenYe6ZKetdLx8qTmg2xK9Y8KAQKo8V
 NI6SFeOxE+8AQeieQocRjXKfatsTBrgSC5QJIUe6CgUrHQl57iuLrmL9szSdND1nSITR
 azwePfAlqRjkEdSBmsCDjjRBvV8gwF6S42rZOO3jytxpH4M/EPs0xo24Moncq9y8L+rx
 Qsj2Owi4CXLuYksSrq1zlDEIYix4mcGTgB57Vp0zZhcSyHUXsYn+d5gKVOoreDIBHNKp
 h+GA==
X-Gm-Message-State: AOJu0YxIMIfpO5yC/PHfZFyHw/03FauyLFUp63UXU2uE7EAHnMVgF2Wo
 hhm+xMdViO6RQ+9/0LhUq5n2kZFxVIA3C5GQCjCgeTRLHeTYzCUbJFt7yQrEaJ7NLXtoBzVDWhD
 QweGI3J2iWW5helcDvdHvrdgrL+l9e8O5YNJz8rrtWum7d+fOFRfc/XyrNhXLMYjWAg==
X-Gm-Gg: Acq92OGwXVCSTmUrbYdclCM3o3W0WVS0+CySy2XXRTBsZkI9X0aKm1FRtPkQMtzBzbb
 sIZS3zPRHVXcsSnkD4QxH+HETp8Zqx7Aws9GSpx2M6wjbnTxyWJnOeRaqTyh9oGBglzPYo/rsdZ
 4RtZquMlRrefZRuxxVha4bvGpFcsao7poRKcagD12B+oM3EOZsjUOyfDArLg+RgXonSMgsi5L5a
 //ZBYwrYoefG7WJI0TETW1XTYEDzWlqPyaQ2GVM1PZ4bhAuBGF2FtzF3EYs38/dxtLbwiAYsAH9
 H/e+Bs7zvS1QUE6ikKMnF3NVyFLqgbBMUuzdJ9oGtYoE9HMQME4gbGm1K/6eda5dvDR5JNSMJLQ
 JtgEWugN4Sjt0AuirSp5f+C/DiEuABE+rr0nWePGMgEgiOBUV7Vng3vJd+8BqLSFCUk2Kix8MYZ
 u7bIvx
X-Received: by 2002:a05:7300:7493:b0:304:fa0d:85ba with SMTP id
 5a478bee46e88-30804789220mr1180689eec.12.1781156005581; 
 Wed, 10 Jun 2026 22:33:25 -0700 (PDT)
X-Received: by 2002:a05:7300:7493:b0:304:fa0d:85ba with SMTP id
 5a478bee46e88-30804789220mr1180664eec.12.1781156005111; 
 Wed, 10 Jun 2026 22:33:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add pkt_ends_tb to translation
Date: Wed, 10 Jun 2026 22:32:41 -0700
Message-Id: <20260611053249.3918491-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: wCkcjBapoFYU_PMziEU1hN95fomhN1_u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX7JaFRgVoCyqP
 APqOmpIQM02AZU+KwhyYBqMqDOKQej43tbEYhbV4D6ml2esEsjonddX4eIXDCl7tkn957Bgpbp7
 30XR+7ENZab+Mgov8EtvjclKQcCczmU=
X-Proofpoint-GUID: wCkcjBapoFYU_PMziEU1hN95fomhN1_u
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a48a6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX0JLFuAxIzICu
 2408yn8Wp5RY5pkMg0yOMtIYcYbohrBiAXl+F7FNLtk+PoDQZRpsrXyciWU27MmXMFTWa8NWk9a
 3d4HOGIJwMF4GzbEaf3aefljsy6EgNRlh7pojS83wKl5WwIDvTCsvb7SK6nGr6cSHiZoItsZBmE
 lAuGEPMbCycKel42tEndLC25a3msg7KA02yt4Ktk+SxNRPJIBfq0UjrE8c1QX1kBDjGkQDhFfrv
 ZHXVkUHEgDWa2BnSw/fydQhYsfwK244PPHRUnGz046VCJiXOujLcLI9yek2FMdXi28KCjuRd+rP
 uFGE6xFjb1l54P/TAqnZXZ/w4+AmKTJuExtcSqV2tBRtUZnewy+EA1s94n3MH5OW4spXrc2xofs
 xKisSQ/x/knH3zCtpbYP3OGlClrPYIPsGVuhbApbTZ0VsozSdmldAAbKU2r3ZyeKMIwlGlZmlRW
 ysvbYuiJpZQzUc5ACcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTAyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTAwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmNzliZGVkZDdi
Ni4uZmVhODhjYjJkYjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04Niw3ICs4Niw2IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOwotICAgIGJvb2wgcGt0X2VuZHNf
dGI7CiAgICAgdWludDMyX3QgbnVtX2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCmluZGV4IGNlNWJiZTkyZDVkLi4zNWU5MDM2Mjg4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTI3
MCw2ICsyNzAsMTYgQEAgc3RhdGljIGJvb2wgY2hlY2tfZm9yX2F0dHJpYihQYWNrZXQgKnBrdCwg
aW50IGF0dHJpYikKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBib29sIGNoZWNrX2Zv
cl9vcGNvZGUoUGFja2V0ICpwa3QsIHVpbnQxNl90IG9wY29kZSkKK3sKKyAgICBmb3IgKGludCBp
ID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKKyAgICAgICAgaWYgKHBrdC0+aW5zbltp
XS5vcGNvZGUgPT0gb3Bjb2RlKSB7CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAg
fQorICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBib29sIG5lZWRfc2xvdF9j
YW5jZWxsZWQoUGFja2V0ICpwa3QpCiB7CiAgICAgLyogV2Ugb25seSBuZWVkIHNsb3RfY2FuY2Vs
bGVkIGZvciBjb25kaXRpb25hbCBzdG9yZSBpbnN0cnVjdGlvbnMgKi8KQEAgLTI4Myw2ICsyOTMs
OTAgQEAgc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKICAgICBy
ZXR1cm4gZmFsc2U7CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIGJvb2wg
c3JlZ193cml0ZV9lbmRzX3RiKGludCByZWdfbnVtKQoreworICAgIHJldHVybiByZWdfbnVtID09
IEhFWF9TUkVHX1NTUiB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NUSUQgfHwK
KyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JTUFTSyB8fAorICAgICAgICAgICByZWdf
bnVtID09IEhFWF9TUkVHX0lQRU5EQUQgfHwKKyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JF
R19CRVNUV0FJVCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHOwor
fQorCitzdGF0aWMgYm9vbCBoYXNfc3JlZ193cml0ZV9lbmRzX3RiKFBhY2tldCBjb25zdCAqcGt0
KQoreworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAg
ICAgICBJbnNuIGNvbnN0ICppbnNuID0gJnBrdC0+aW5zbltpXTsKKyAgICAgICAgdWludDE2X3Qg
b3Bjb2RlID0gaW5zbi0+b3Bjb2RlOworICAgICAgICBpZiAob3Bjb2RlID09IFkyX3RmcnNyY3Ip
IHsKKyAgICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc2luZ2xlIHNyZWcgKi8KKyAgICAgICAgICAg
IGludCByZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0
ZV9lbmRzX3RiKHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAg
ICAgICAgICB9CisgICAgICAgIH0gZWxzZSBpZiAob3Bjb2RlID09IFk0X3RmcnNwY3ApIHsKKyAg
ICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc3JlZyBwYWlyICovCisgICAgICAgICAgICBpbnQgcmVn
X251bSA9IGluc24tPnJlZ25vWzBdOworICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190
YihyZWdfbnVtKSkgeworICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAg
fQorICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190YihyZWdfbnVtICsgMSkpIHsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAg
IH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisjZW5kaWYKKworc3RhdGljIGJvb2wgcGt0X2VuZHNf
dGIoUGFja2V0ICpwa3QpCit7CisgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKKyAgICAgICAg
cmV0dXJuIHRydWU7CisgICAgfQorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyogU3lz
dGVtIG1vZGUgaW5zdHJ1Y3Rpb25zIHRoYXQgZW5kIFRMQiAqLworICAgIGlmIChjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfc3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
Y3N3aSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2NpYWQpIHx8CisgICAg
ICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9zaWFkKSB8fAorICAgICAgICBjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfd2FpdCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3Jlc3VtZSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lhc3NpZ253KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc2V0aW1hc2spIHx8CisgICAgICAg
IGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9ubWkpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNv
ZGUocGt0LCBZMl9zZXRwcmlvKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
c3RhcnQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zdG9wKSB8fAorICAg
ICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfazBsb2NrKSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfazB1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUo
cGt0LCBZMl90bGJsb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxi
dW5sb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfYnJlYWspIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9pc3luYykgfHwKKyAgICAgICAgY2hlY2tf
Zm9yX29wY29kZShwa3QsIFkyX3N5bmNodCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShw
a3QsIFkyX3RsYnApIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ3KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTVfY3RsYncpIHx8CisgICAgICAgIGNo
ZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV90bGJhc2lkaSkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7
CisgICAgfQorCisgICAgLyoKKyAgICAgKiBDaGVjayBmb3Igc3JlZyB3cml0ZXMgdGhhdCB3b3Vs
ZCBlbmQgdGhlIFRCCisgICAgICovCisgICAgaWYgKGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX0lN
UExJQ0lUX1dSSVRFU19TU1IpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBp
ZiAoaGFzX3NyZWdfd3JpdGVfZW5kc190Yihwa3QpKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyNlbmRpZgorICAgIHJldHVybiBmYWxzZTsKK30KKworCiBzdGF0aWMgYm9vbCBuZWVk
X25leHRfUEMoRGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogQ2hlY2sgZm9yIGNvbmRpdGlv
bmFsIGNvbnRyb2wgZmxvdyBvciBIVyBsb29wIGVuZCAqLwpAQCAtNDM5LDcgKzUzMywxMSBAQCBz
dGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZv
aWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIHsKLSAgICB0YXJnZXRfdWxv
bmcgbmV4dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgY3R4LT5wa3QuZW5jb2RfcGt0X3NpemVf
aW5fYnl0ZXM7CisgICAgUGFja2V0ICpwa3QgPSAmY3R4LT5wa3Q7CisgICAgdGFyZ2V0X3Vsb25n
IG5leHRfUEMgPSAoY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2swbG9jaykgfHwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxibG9jaykpID8K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCA6CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBjX25leHQgKyBwa3QtPmVuY29k
X3BrdF9zaXplX2luX2J5dGVzOwogICAgIGludCBpOwogCiAgICAgLyogQ2xlYXIgb3V0IHRoZSBk
aXNhc3NlbWJseSBjb250ZXh0ICovCkBAIC05NDQsNyArMTA0Miw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPnBrdC52aGlz
dF9pbnNuLT5nZW5lcmF0ZShjdHgpOwogICAgIH0KIAotICAgIGlmIChjdHgtPnBrdC5wa3RfaGFz
X2NvZikgeworICAgIGlmIChwa3RfZW5kc190YigmY3R4LT5wa3QpIHx8IGN0eC0+YmFzZS5pc19q
bXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKICAgICAgICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0K
IH0KLS0gCjIuMzQuMQoK

