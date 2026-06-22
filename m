Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA65CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndK-00034l-4T; Mon, 22 Jun 2026 19:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndG-000308-M7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndE-0002U2-Rp
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:46 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaxca1902568
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=; b=jRfpcgKo95iePReb
 xvSNekHPeH+AP8KrAMGw4AMgVCEYueBMMY3Xk78ZSiSUGMxIsN4nPsoF7V5D1TIy
 dDDFnggYgqRrgAb3EX1FFhLsC8wdXUHsTMNGX0dge/mm5U9X9ZKckdd4IaRMF4Ab
 8IQMxZ34q1AzmFb/xmZZsyRGLQEw7RsO3aH4n6rEiT7Xn5vN0LlVMyn2euSMEDS1
 0S5OIC83J+b6f27cTXQgWrUZXt+kflHKU83ir6fF0g1jNxX+DjoUYQnXh+hPuXAN
 +PLP/wnc/jgrjwtNSPYy0ePNbG+aF6jIy4F4wB2aaLkvuCNIqg2OlSeAK02hqUM8
 O4RXxA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1ung5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bf794ce48so380208eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169233; x=1782774033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=AAxaWG80b38sRIWywRKAmbxNOveajMxHhC10ajHwLrAlk4eI3gVVF8up53whxKgHwH
 8mBgHcEcZIstHxkw/+eJB0t5P65npYuclKgLad3CBUhGF2c4NSnhX+NOJp2bq1VxTioW
 ZeJKdhsUbjs3NgUyB7FutRyiH1sG9LuyT9BIMm/xsq87FTlOk9onDbMzgvugVVTL/7j+
 sHC7wISo38g3kkCDU9w6KNAXnvLp+3YthnAzk1nikUaus/UtxLP7FmF7V1NKFI7vs8n3
 zXK3/u10AmRuY3UAlsTY3ABh9pa0C+wU5WVul2/SMwTpTGJpiNQ3/H5qn3xLJ2FhVf6g
 t/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169233; x=1782774033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=gaU58ZCr9qHz6qLxygGYgTXde15MogZeX2+Vtk4REZBHrhSbuy8k3k73Yz5kJUbdLW
 lZBOiWvHc8QqTPFDfsP9ck5ClBZw2dUfttVn1B7nD+g42qO0kINhoAdAruku9o9vKgS9
 TRFii5x/1EFAgi10wEBcdR4ruc4WoRbFFPWqHYB+umJ2uIjIFL/2MqqYnBKojzJpSumY
 3ZJ3Zza+z1Tif1ZuSwGz6f+DqRYVfsKgB3l0gBzsVEOCHbvHL4qkKsgJOa1pwS0OwmbE
 Gs+IohSotkZrNcyu/Sdg1YFX/iHftdNqiI5d/SNPwzl2vqQ1X94Us0SfMbeUlUVT99E1
 ecJA==
X-Gm-Message-State: AOJu0YwU1bk0VSXXhU4Z1tNUJhCd3DyTZNzSBnjhh/oLDWsf1J0BHgwa
 +WaHRECn0EcmGSWBYSoomCgNH9JtHQpX9VdOGBBJwnVpN+RzrmPgfvlp6u5evudVa1XQmpXqoUo
 lbQMLJ7w1xG+gjXWQN1jvbBJdCpc3t28zc86Kq3p6C334eN9go06mCqlXRZpp+0wsPw==
X-Gm-Gg: AfdE7clikXkLqzPbxhc5mO6dRPljSvikrkBILuOs6GhF5rF7VMFZLq1m6QCREc1ld2E
 CvnjTE0Q9D4WWFSPnppTvyKcSHxZ3jWadBLHE04kt2UnDTVv1Un+BntPRgm9sJ3i6d8aHbzEUZC
 Qze8h/X59amy50q4wuJ0NA+LuzDFIocr2DgHdNoqN3TMVLCx62I4egNr2jHvzhSjuKgO/g3WpaE
 ivUkBPghDWUC1rbvhLOdw+LLjKC1tOkH2ad4SWIs4Aco693DrMJrZutYDZu9SNwl1mFiW4a7GUR
 g1M0PXfTpZa5aBrNEELOH2vEmxPTemaReEBbu0w+aUX/oWHU9YXekFwmsUp5VdOYMbjBCd5/Deb
 EEzr/CWuMsaXyQB9uR64WGMMTW2nCKCjxkd48h1spOY6lWBm+cyeDpjUPTOI=
X-Received: by 2002:a05:7022:410:b0:138:501f:46b2 with SMTP id
 a92af1059eb24-139c3c124b4mr934568c88.1.1782169232705; 
 Mon, 22 Jun 2026 16:00:32 -0700 (PDT)
X-Received: by 2002:a05:7022:410:b0:138:501f:46b2 with SMTP id
 a92af1059eb24-139c3c124b4mr934532c88.1.1782169231971; 
 Mon, 22 Jun 2026 16:00:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 57/75] target/hexagon: Add pkt_ends_tb to translation
Date: Mon, 22 Jun 2026 15:28:46 -0700
Message-Id: <20260622222904.607771-58-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: c7uSgQHJDUvB0Wzo4RJiom-ykjrmk_Ep
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39be91 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX6RcDPMF+qmgd
 vzEYF9FTGL4Fmixd5apf/1Qe1+2zwUMYIb7PZkjXeBG/mVoLPoLXPC8oB82Is99czCPNVEbcDJy
 hc44/BdewsFpbjj3zTuhRwrPEI6uZaw=
X-Proofpoint-ORIG-GUID: c7uSgQHJDUvB0Wzo4RJiom-ykjrmk_Ep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXyTSPmHHjtwo5
 5r0+lcwV2z4/GL3Du/3kDlXVp8NfWer6QPQ3n9ViL3HSMr8L+bp1ULmE37WnLR+QvRbcA2xALOH
 aa24hLFNA/a39DOR3lKigggDYCln8kyQemEbBuu7acusfevRAi4r0tLuYVYPwdBlxOvO50lztOq
 1og+sn07j6RTUd2mDIkz8gLUcrQJ+nVHLt4n9QWD7Sa+Y/xTJxTH1GDc7s9R0h6qLaxyRHqIVZx
 Wzhd1OyE8mSdXKQza5A4WZB8zPoCJi/sAHxn3W+1VjH8QOLKJ9mvZse0h0GZWHaEMWsPt+atM1S
 zOllQdCJXqtimSzroG2anGMyhDxFLBz+BFAbu8LbKl4VpAfoe3nBVQFVIaBgdR//9/UxOMqWvCX
 D08sJx7z4GyhA4lkLe+WTZKE6PQysXkxI0cT3v8xgi80J5OqEvk1nc3k9Bm4GVzU49xlZe360gZ
 KxygP9b3bft41WgFKIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

