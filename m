Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2296FCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C5-0004Rf-Oz; Fri, 29 May 2026 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C3-0004EC-2A
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5By-0000RQ-MV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdlQr203280
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=LZeGbcg6XvvYneYj
 T6z6eoqo13/7h9o7jDPwh5lBNltrTXAOjxZ7KZROQPeNdXRLM5ab4DijjrNtTZy/
 i3cwExTYT5V2hcLptDSXcHSbC1WnKgz6rdJZ/JdY7GzSa54U/u3JF4rfjLmIjjL3
 wLHpZNTHCF4YppE3aCYdw611rpuLOZ4jaLE/mRGnUlxyiRU3Y/iJoNryTVHr0JIe
 PBpdd8KZ9yCOsJZl3y9B4QtT7sRhjQBh9yY5Akxm9JP0e8JK7Q/ny7KK2sRcwDvd
 9cid9I9Mm50yaCXSXX6mbPvbZFsSc+OAhJxR2yF6wRGwVDLqYWIoJPcL/3+ZaU3g
 cayCdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8qy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ec73b015so965745eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091783; x=1780696583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=g4Lov/ZqI1YgPv+dphrfRbbmhdnW12WJD9UE9QBHNWlm5xhudY73Q5r0YvBO5O06n7
 WOWTX5eqV/MoxhZHApFbDdltXR2Ye4QidHAvAD5AwPOWmdWkVyhtnlg8BQ54vyvq7NB/
 TZQBCsiFPalu5Y08JQDqLwXlpHDxUFaC89AzZmluhzpQNmpfvX7ieUhlnog2ZgWOkPd4
 LUCao3YBgrOO/VHYfZztFFQumhqDChmqlGiYA8wwlnwy9BkWy2NsKOScQthsVGU2N7jq
 wv2mNGq/Pvzk/YoD0GJHpUcG3Q1TVsBv1TDi3uc/5Smacmu2uUN+y/k52pJxFbY1CQ29
 TmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091783; x=1780696583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=lvTPdFRkgKIOC9bW6s5wqtRU23yfOk1lgjHMXNP9ZG5+IXU4mK4mp6rOrzz7zGon1r
 Cc3KRbQ9nzhPqIKdojFzy6t9bbtNfS9fwB3L4D93wLvba+lkS8RYEFW82zCRAMggk4Os
 lKsgKl41L6GJpN/5K+Jh3Y5z1ufqb+0sO9K5Pwuyr3imS3mWXnJvo4MHrPvJalaorGwe
 ZGWwnFnPiUqkm8KyRr6G7c2N/LA6DtEFxQ0tOkdjBGsRSYh6999KQepx1rksaEgoV9wF
 nmi/QiB/jpx+QW+K05mlsPf+PF47nXe3CLBtKy2H7Zpbxb2oJChp5VwOLs6f7KM6O8db
 rtLg==
X-Gm-Message-State: AOJu0Yy4w6JhOgqO/+0QS9Gxb6Xa7av/fjEImPMZ0XWI2Kd7jX0GnX5B
 RVLGBRO4phk7LKMYuloyMBnSvKA1QWQgRNqETx6SyK6fZhE30e8iw/ZN9Qx5AcMWwsv+2/rX/C2
 0YUNQ8aUr5wrn0ecN9er4T6rJyE82nQFqMGKJnfntZ5OWwPdhsoKSUuTYy6AlVoe5YA==
X-Gm-Gg: Acq92OHQTtsIrf1kG5wUFj1n8+b490FKACO24zoj8VqEqQreHvjCY3Sj1LcrVtEJpbo
 nU6rM022VGGjBn9vTrzB6t0/EdYOkWMhabeVRnCLXOJNkgf9AQfCmtOsBzxZeUui4+emYfmJwJW
 uLQgQgPjR/scr+IgTMI6/6H6DwPv2B4i8qqjLaMFX1pli8amu0NZ1qf3D47CNQi7TbVEbJ7sgXZ
 UE19eoocMSo0B9pRgLA4wOorqEKo/4GD7k5wbULfpv2rKaBATzyLKwrrDChkkGSujIt6n32jjIS
 CxDZH7bsWx+bslfhpUHhzQLuLEmdc2/pBJe6kw5ftxFHUUjXnritxstudlsIYkhQ7Er6IJpvmNw
 xYV/Abt9wsPfkdDdWpPik/qezXjgCwjA9GauUfB3l00BbSvYtKQQ3w/R6YWPGfGNw89qNpd24K9
 PKdwJ2
X-Received: by 2002:a05:7300:d509:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-304fa30cd05mr830136eec.0.1780091782818; 
 Fri, 29 May 2026 14:56:22 -0700 (PDT)
X-Received: by 2002:a05:7300:d509:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-304fa30cd05mr830121eec.0.1780091782269; 
 Fri, 29 May 2026 14:56:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 14/38] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Fri, 29 May 2026 14:55:30 -0700
Message-Id: <20260529215554.606133-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfXxm0ymHE0ctVB
 WpC9qISCiuIFpzmCIohNwKQGA50lMlVz5HIRBF1QS+OPfCo8DqqaYFC0d6N/G5foX2jl+p2WzPD
 fFHase3lrwMCiifDF80bXrIsHHxWr8o0sQMy4db7+ktWzEYX+XKXJF7wGafgP99enxoyREoPw/t
 m8YIIPVxa5dnht/wPtXNooDgY5Dh04kfh6wpRySbw78syiaxO3JiWRQIcbB452kiWUVgUnLWIj+
 ItJjTIxMSJYlK58cwYFSeUoCT0N4yoYYvcos/3YRUFg+ms+qWHNTXEvDSeRMCUOWCciNMpqyW2g
 J8CSGP4+WFlQgMjipCt2tlR8inZy7rtkZnjM/xTEpIGOF+vX42N1TbG3Btp2yTBHvj8HIanpayY
 6gedU4hisSigykxrRXTBHsTRECXQKd5rFAUhA8EI62Z8h4kolZDMny1/e6c0hBfW46b5RShAKi9
 hA2nLTyUEVlOpVgnv9w==
X-Proofpoint-ORIG-GUID: BDSpg0WHxTz1Kbg2vWaUG_eyKsIziXxD
X-Proofpoint-GUID: BDSpg0WHxTz1Kbg2vWaUG_eyKsIziXxD
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0b87 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDhlZWE1NjE5
MWQuLjU3NzY3YWNmMDAyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODEsNiArODksMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
bCBpc19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdf
RzMpOworICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICBj
dHgtPmdyZWdfbG9nX2lkeCsrOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGFzc2VydCgh
KHJudW0gJSAyKSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
Y3R4X2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBj
dHgtPnNyZWdfbG9nW2N0eC0+c3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xv
Z19pZHgrKzsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWly
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUo
Y3R4LCBybnVtKTsKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0pCiB7CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdz
X3dyaXR0ZW4pKSB7Ci0tIAoyLjM0LjEKCg==

