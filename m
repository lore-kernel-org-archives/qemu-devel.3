Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EEEC43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3da-0002n8-9W; Mon, 29 Jun 2026 00:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d1-0002d7-OC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3cx-0000jd-Lb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJRb1724660
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=; b=T93HbzR4/22pTHGP
 hSBJjyXIV6jMg4m3WcYHTvKczYpSSvkd19Ao/puN5qrpK3BWiC4kT4HnwvwN6wVL
 VoV3Tdx2ka+BcxxWm9dvAOm5MbDaoSxmHxhM9YyXBL9diglMrtN2dss/lREoVe+u
 KOmbJRsdDHDKJBS3OF9zklhaY+llFUCO2a1QK8NPLTAAxygKV06h6t3i+CMZnKrD
 b0a8PheJfnaKntQEgKWb9QwNrcINcvt/SGeCsfTqKK4Ll+Rkqi9InIVgrpZmm8Ot
 wA/leIH7o8GDk5SMbWoc+bo3YJckcRCfW57p2Wotw3bwQiLvkSwze6gbGbozCj5u
 VdfToA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6mfms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13980b6561dso7392920c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707385; x=1783312185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=TpUT54LIiaeDYhPFU55rEUoy5tHyX/ak41J3dleCH/XwMJER4ZKS96j42P8Wd3gBdx
 p7/r626sqZ2lpTAuU2MxoPFv1K1CTF/DmJmzbGuD3/FMpQ59ig1Inqwl7Npsa1c5BIKR
 9Kouv8zCBeW7HlvBW9jnB+Ea5lie/CcDoF1W24qpeNpuh8H0mh/O6UfZJp/36olIDaTf
 vCOUfbIqzB1wteiqtt2VQYPP+adIDUHT0wU70hiHUTnhyzLO7V1iwYKLePGICpylyft8
 gqG5nc7nNR6yikDDepAqOq5qToiQbyF9urhl0yQH8fefL9KpCAFIQrTsCLIqw/Syvokj
 gXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707385; x=1783312185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=WX0LHGYgH0SHWOheCLqr7n7A5BX/oXXOCZs//AOv35urGRXxmf/zK69YxIiv95oObg
 yohRUobMDobmVxwmutPBSuep5sAFJKdqJHUUHFWM0DubRaSzGu32zBMeq+D8enR9l2r5
 EsMR3t7/MkR5cybvsrHUS8ie8VIIXBgg9umtRVgL5Klw8tbRppOWmp7+VtoHm1OXyK26
 Pt/UraPwlgnilgZLEEzRqKx/umpp4AzzTPe+hqiLtJQ2ELVN/7307AcDJcjHJKFJFv/W
 1mXTWSIU/E+QhWdBjhBOqA5CbbyFRkXprr5pU8lGFW1yrhBf3FO1Ys+bttGeDBCJyLnl
 aBcw==
X-Gm-Message-State: AOJu0YyGh7DknIN8st6kcpnHhhMq5qQp7w4ZYagohlb4/cmbI0CiVUF9
 CjpWo4A1HHIl1M9eaV/5sJjoL00ji1jOq4r1+x8nMK/ScYtreM9kyeSu/JopvIEU6Ct/eovn2pQ
 AG2NIMWwHJwOXGB5QaZ86Yhhsz7imKZ/VIO4bZa9JsaSUg/NEy+D8zQLtfLUxQkfkzg==
X-Gm-Gg: AfdE7cn+QcnmSbCtow205xUQG14/Ddm/3pDprC3zTWMaRz1hcKAu3nU79YH0sPQYNLM
 JP/0H3VofSe3fTaZcDynnujigutpY8EqbVFxtRYn1sczvDj59GU0fx3Z8VINTzdQbXGhgnIO4hs
 b8bfBcVFAYkowUuRIq5fwCFnr5sM8fhzfDbmUSMn5Zox4V8940DSMyA0wTUbefweUOm5I/A8RmZ
 h9sbZlgJaZwpAik/4+Vsxs/5lbVEtkLZZIeaYRK/guTBA1DUYgNqvuGKKh5TYGj/bQ1H+YpdBjI
 jqVnTerYozzMhyOiv39KNmpkXew9xqaDpryVM5NergMk+GWhyhvy7ewTWe2AjJ4GrtsZ4i27GRM
 a8k6I5mbG4oqZ7kw5/h2DKVA3CaqpJD5KB9rMZW2Y1MJwt8JOJODJvr9JZQg=
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30c84e2074cmr15037409eec.11.1782707385127; 
 Sun, 28 Jun 2026 21:29:45 -0700 (PDT)
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30c84e2074cmr15037394eec.11.1782707384537; 
 Sun, 28 Jun 2026 21:29:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 44/77] target/hexagon: Implement {g,s}etimask helpers
Date: Sun, 28 Jun 2026 20:57:57 -0700
Message-Id: <20260629035830.1520296-45-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: PoqOocsS-Wl3afSIid_C4kvfp9khR4-s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+6Ux2rMh20ka
 FfM6uZoPXIQ0fLkPcFSl5QNnNG8pqhNYct76PM9YmtqkJ5rE0F0PAEV5HhxnEvGwMN9KdHIhBJY
 4yfB7WwNew4LNzDp0AIvcvoI5zrtsug=
X-Proofpoint-GUID: PoqOocsS-Wl3afSIid_C4kvfp9khR4-s
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a41f4ba cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+e8Z+DL3kOrm
 we8UiJeHNhMDSnHJATIW3aOq0Ow/iUmzSFmJNx+dEfN0aLmU+6eHAjZwysAbpwJvLRxHPuCaUre
 WKXZp/M/e51MaGjQMI1opw5ILkG6OOmdoilSJGHLw5LRa3j937BP/GY3/BiuiGfE9u1A7UsyIv5
 H7qeXdXRX3NmvY7rtswmteSMNak893I34i9uH3g+0/I1IZe0vFcxvTbtDOyk5Kc+DO7EzQEhvgg
 C0g7RRP+10royqPaMoKKS8oT14Uhiim7WzQ7YXL1MKCaF0oyr5E8ZpYmpF/Byts18S3dI9669Se
 S61iQIyP2uHaIWX69ArlG88chvFh8134SLqPtyJBzzXD8X6S7fqkHqYPu6OdF5MoyV6vAkzD6n5
 zbkCem65bNzOUoXPTp3GwrZ9SuNqymiLWKa7KhxtnsQvkASnr5rAXf5Yiqt2z/ihuHpMtsE3141
 fp0dgsP3IKrq7dMzJwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGI5Y2YxZjE4OGJiLi4xNjgwZTMwMGVjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTks
MTIgKzE0OTksNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

