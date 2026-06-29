Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D0C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3gX-0007GW-5i; Mon, 29 Jun 2026 00:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dL-0002fb-Er
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dF-0000lg-Cs
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NHU91787648
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=; b=edym2n81jBCaBtAF
 Qx73e6DsUDuASJ39q0QJCi9kFkwgc8Lrz5b1IXSn/PdDFCO6l2nXKk65JtothHa5
 C3kw0gChm1aznOgGm4Y2qM+u+7M1OnfcxN9KmNQrTWMLW0Vq2/k46BBEwotyuAEl
 2k6PhixokpCNjK1rTHTyLf5a8fu+8Rn5mXT5qQq7vDUj+tSRMA0bADwdJ8Vj69rF
 Ljsgwy6eV+wg+nyWoinBa6h9ToEwXCbrJDDcOBBr8DZ7281/uygkPF2W1H8gAL2J
 SVPmrZ1CQjNI0RF/otyH6vO2FEl2HoPPgl1WAXwb5te8SgN8vTVJham52LeM5mK/
 9qeg8g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvfej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ed53abff8so201608eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707398; x=1783312198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=gdVBwVQmKCYL58NF5HO5vGFBgjtSL9K6kZtw5yGxb1MlOxZpwRJq92Ajj+UWWlOSiC
 sOREaVRFkVcVq7iw66XyFctWEe5IJvOdeXk0902rp/ozpYQbVwc6cBBVTLlVNe05DmO0
 41cAI+dpfgRZuGdVIoHen309hxx/GboMICaV/+/kvHi+PwrZ8OANSC2TU1RLUTxA6vx5
 7ghSd0oazInKVSnJuY8IWbXx9yXIy63Vq484p8MisL+yJKH1PXYrEnR1xR+rYST5wgug
 J/4GEdFPMof4Hg4g3mRB0ca13RvDgc7/EswR0xjvR8a1lbDCG5/9J+fKQhBP3bLEeFgb
 ifaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707398; x=1783312198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=kOwS/+Fey79343g0Yuwbq11eZEtDyRSLcQobCHSDJtAXb6V5OjbxXAgDVtd95z0IO6
 rRXg+c3dUDAE4ZtlT9lRXUh/vQb5oG8l1M9M2oW2CAG/ZodwWAGQwg1CNxg0IgL2OzNn
 tgFUG43GdfgvR5ypmBofoI+Yi6zWtuzmmPXSx+KiyaUC52okyanZNkxlybSy6pfz1ee5
 Ay9YWiLqLiz25jOhfpedUB3VpOix1gVODdOL2GSo+JHTwy7KIlngpEuBBe6s19Nd2pH/
 oR9ldJdZHRTtHH/XzJF9WuhHW8Lt/lq/Cpxen+eHNgpcfYPGfTlb9iW6y45yMxnpBRQb
 5IZA==
X-Gm-Message-State: AOJu0YxUW4yCniuB5AjaKo+p3l/dytw6HqbzNTaEJwN3KgkwqeJH/fZa
 LsxTdIi8ObQucb6bNC2n6ztkJTZYcs2vRZoo/BJlfB5r2LBUhCEKmFTztjhSNewP8kKtvxErx5w
 WJkw/TuO5YvHRtXNz2DETpQJpCVu4i1EOrJqN1DITAzq1kLsp6fGHBMq7gwfD9N4WMQ==
X-Gm-Gg: AfdE7cl4nY2C5LMqHTJMVy7mg19GQfvcWxQzfLU3GZYKQ+7jhMoLBoq472xQpsix0Ta
 itDrCSnFtBrq24KrhiPTpvAElIhJoi3Y/rRnyLo77nX2LKvj8UkrqLBItIm77FxStmMNVmgcEqw
 Dcoeb1k8oiVQNwQGHbUCCbnXFcq/AZbeDfdFsaSvkG7/G6aP0HWN4QLyhN974x/JZBjWXL3oYA4
 mfXnWXv4gZwYH85Ltpu/3S1dlnh4hPZzXr2/M/VH7Nr5xwYF/7VsL/dfmW1NMG5Ke/SW9VX2vTI
 ZZMe9WoBuy/dK4KDV2AGj2e0lf8ssqINrfkkMXFHC+tQ5jigD5X3HWJpQVZhrturzaYQdy7JxH7
 SZeFyKYDfig9o9+ewz3Or9NBmicOmg7MsI/OyEZVKU9fAlSamDWnRcJHUeFU=
X-Received: by 2002:a05:7301:9e44:b0:30c:55f2:1e32 with SMTP id
 5a478bee46e88-30c84cf590bmr13531796eec.6.1782707397742; 
 Sun, 28 Jun 2026 21:29:57 -0700 (PDT)
X-Received: by 2002:a05:7301:9e44:b0:30c:55f2:1e32 with SMTP id
 5a478bee46e88-30c84cf590bmr13531781eec.6.1782707397229; 
 Sun, 28 Jun 2026 21:29:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 53/77] target/hexagon: Implement siad inst
Date: Sun, 28 Jun 2026 20:58:06 -0700
Message-Id: <20260629035830.1520296-54-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX4SD4iXnafpHs
 DawDF7HS5thqkp/kc6QTnYikqxhwoxnoMVS8WYrF+vU3dakMJ21l9Da2xKSiRTaPXpMKQjqEYRt
 KmdynjnwvJccJV72ySGmygNxQ1YyI/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+6DDpYLVBVyL
 oMW9zbAY+D+u37OKTLGuEfPTr6wYPNozK0BUqcGXAbAXnu5CoCsEXf80VwS06OyVHwJHg5vp3m+
 X+2YQJGa3DHubJdYmbztBOMk274ODEAEWHplzhF4Ru04T9HIJoz3Mj03ul1Hhi2RJ9Ny+PuEgRx
 4CEEkUDUnnzJM1YQJrQdTbCVxSv1fqsXRLymnxoWUKBufCyX6u8QjWmA9w6v7g0YlL4wfoHCLTP
 Y5qKN88K7roiQ1vJF2yOYeA6/bNjgYkqcRSS4JmAcQucSN25Z366NTm1gdsYW/L30GSNKa93zbN
 seq5RHleCpm0DGwS1yRVSA250ejfZPzBLZf9Jd6NTNRd6MrcrdpVdZsS+3cAEBc6Ie/1maR8b27
 G443Qrxp2GQ3A4iKJwK6Pz2nP/8nBftFz/FTszQ8Vi1AN/Abx2vQImd9o4nnCnX/dQcwOVQB7pr
 HF1YiF10hOvQCGuHvyg==
X-Proofpoint-GUID: rFlNLGwXefzki_qwZz5v9P3HQcUAS6vU
X-Proofpoint-ORIG-GUID: rFlNLGwXefzki_qwZz5v9P3HQcUAS6vU
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41f4c6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYThiZjg5YWI5OTYuLjRk
MzE5YTI2MzdmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNiw3ICsxNDM2LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

