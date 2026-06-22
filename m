Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E92CDB47A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9L-0003PM-6P; Mon, 22 Jun 2026 18:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9G-0003OP-IG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9F-0006Th-5x
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaEId2101429
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=bssvMdZ8S+D6i8RW
 JfmpLX2NBQLWcg2pmxHWGcVUsSdXHndso3n45t0E03+BFOO8N3QsfIZsYk7SFcHP
 89zmt/YLxxt/JO5vITmFwdVKVBFsjCDGmRx33BajX8AagUUUGlJuMn1kD1qeL752
 qUKQt+5RAHl2elzhpJRih755HOPUJg9vV90l6fPaiaZCSxJpuDg9wrauKnG96iqQ
 8DLtvAkWeY/E+PCvHUHjEyu/h4whCI55f6sSJ7R0rj8dEfN3OEAxVsHMGNrZetwu
 5ORDcE6hj3LQIPUNdUt+WKUAmKCxghl6zpTBFOEwnXW7nuWl2YyWDrH/hbGIWpM3
 BmHLSQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebaeuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ba395b047so3609240eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167373; x=1782772173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=RxBAj/nu+TjKJ7hlmRmIHu5t17nHWBMZpDHkJu9yxrCh5JvH0ptYBmIoEFt+W4PH+5
 xW9Fe9apQBgZFkW2hjCjLrpB002ag0uAiEk7CvqeHR3Ol3waJADwlDuTT/1mhMkLtMPH
 cUs5INOPQt1ISxElXwtLFn5jAOi7evwWM1CepZz9faRqr1y+uJf9Drg+189zQpZjjY+f
 DSJXm7omCRk4IU/mFMJk/u7o5bfYTp+mWgPFykESjNfkZ9CNlaGIWZhyexQVTS7nOfWy
 yIW8h5vyL+egh6BRvgIWS8k261zkGvEDvKgew9ydlnZngs+M0Gariy0Pgzt2UsSSbTNM
 beOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167373; x=1782772173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=ikumGs0PaR60Vo42YfYDFXd07fe13DxoDntj9sSyv+UOhGul9JzZ/TQ3xHIcpKaKa8
 co0L00LqHT/jgq0wRCsX4bksz5LvXEukqTV7z/7PfOnLMRdHzkyXkhsRUh7Z1v9BK58c
 SSKJK1tY5aRtTusqr6Q4DB55/g+ErJQRbRjk8uTOLT7GQDYOLrXMdBotZchAcuQ/8ii2
 63EKkZhdXGngGxAsELJjKf42FEODkwSLQPa2pWXuqTKrOoIGSnXxx/Hbmu5DYd98x07P
 o42Ht9GaAUkZijplmkjAP8Jjm3ffhTN2kQOJ7RjynNc08udmUgLKVRsCuANSmwtwlQeQ
 1Rlw==
X-Gm-Message-State: AOJu0Yxm7cDc9CMlV2uV35JYXv1rVVV8uRJvRPbdqdJMM/e8AcC6k8HZ
 pk3OhDuczGDVSIsanCd0jc/W2Oih2SepklN1qCYCK0v9O9T7MgTC9txQ7wDONIcsBwIFUXyfbTK
 SpF9IiFGhPI5uEVnzCCIkJNoex6RorAeiqmpPysGUDi1zXGx/w0nYHc3sJtB59SZz2Q==
X-Gm-Gg: AfdE7cl/iGmN2vzy6hbvMsXrN/DXPQ3C3nM2jIqPDmNsxP+8jzC2NOGe928BfHxORWu
 fPDBGq7qERx2Yf7CzAG9nMB5NQHVFuEizx3po6FXYcCZtcKr3DZevCY97kg2GUO7zRoXoCSOtRU
 IeltSv9EbMHGauv4qB7OdhYLw+mymodxxrWTCp94QiZxVW5u/9IDcdtCI2dPh8YZY2jRtPaqHmL
 5pfGJ5rQK1Is+Ss7G2VmoeCBAPRHtPjtGQyWOzqSX5Tc8lQ233rGDgzaojq2ajErbXBZxT7dKb8
 v7CNMbLFH15XVS2hsDtWC2CEsBd5xOirIXZyIlTOGEViFBCh7C1YauulY6ztoKKS8yBhyxKhyTL
 f21L3g4++DfSoa/2XdMwSx8aDm9noTnLZ3wfrQFT9rY72vlB9yfaJOHjqR+U=
X-Received: by 2002:a05:7300:a94a:b0:30c:38ed:46b5 with SMTP id
 5a478bee46e88-30c38ed51cbmr5172464eec.12.1782167373101; 
 Mon, 22 Jun 2026 15:29:33 -0700 (PDT)
X-Received: by 2002:a05:7300:a94a:b0:30c:38ed:46b5 with SMTP id
 5a478bee46e88-30c38ed51cbmr5172447eec.12.1782167372611; 
 Mon, 22 Jun 2026 15:29:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 14/75] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Mon, 22 Jun 2026 15:28:03 -0700
Message-Id: <20260622222904.607771-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXwH0LYlPPe98C
 nizqiRNf8jPIRneCeACOYcMKQdcQhYyPGuvb5F5LPQ54NuVyQxUW3pn6gNnU8Fd90CfDRUnN5Pu
 VOqORAE3Xz9/j+NjSwTCI7xmhZ9pVTE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXz9iiZn9WybOG
 aYNuHnnarcHK1RwWWLlbpfOWlzBAAjoEplgOlGMHeC1KXFMNx/zk8LFRmFEpoF2szHNtmyiWpXr
 d5UA3TUEvIJIp/5sqTjBqEuxozknSglZTy1SRR4vnHU0u9vHVDKU2nF/obVdDyScy2N2+g3QV93
 9KHYJQfQIMGTmzQryZXadoUgpnQQdA+d25H7uEOmBu3ELjxy/btoPGJbAr5rstfo1WfInX56jsf
 bAfRA7CRsWVwYaqE2Oh34hYvdiBTOhnkgbN8LWKotp+ViJH1WlBfB3Xmb4hO3aT4OTm/eJY3ttW
 IGCUDMBm/+oX3/Y7drpICQ3wKCcEsyEnlPfVNCGfcW/NJq6q+IzYX7JWdEKuAo4yAQR05Cpv3nQ
 luZlHJyqCtn5xoQdZd37OVRw62nVC02oYaz2lECb89BaDTdCHQGrKJiVX1swwnyIQMZhVf1Xh6l
 1pZisby/6jDTX+4zgOg==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39b74e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gxqkaKxCDwGXCu4JEcL7TW6XOFsi1MPQ
X-Proofpoint-ORIG-GUID: gxqkaKxCDwGXCu4JEcL7TW6XOFsi1MPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

