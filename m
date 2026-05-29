Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C6CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5De-0003Zy-Qt; Fri, 29 May 2026 17:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dc-0003L1-Pc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Da-0000qG-TH
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIsqJT3526533
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=; b=Rta732AVNgB2oLh8
 bps81EBt0APqoOv3V/S6C9eOQBmrsCJKeWZxWQjg8AVyTNJpakq0QBNt/wVIHEjy
 xafci3siCVcUxIj+23eJ8h78ff1omUqGGWbxJpCDDf7MkspG7QY9jKzteBR1NkPz
 X1ILHRCCbM9+0tUbmh9FgiNsxyp/xel8Y6G1NpQP+4a3S6qVoyQ/7cfz2KkhfLo6
 NioFNpougDiDGZFiFXTWrC2Bs5knQ2jdYorjN0yhrDe3FALIFmco39GYYm/Qh8AZ
 f0WUt281mcfsfUbHF6b4PsOGJTohD2i1EG7I5snzPMhHh44BYDaZuLEUx77qrTco
 imZY1g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efgge8p8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e4636205so3327407eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091893; x=1780696693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=;
 b=CAgDWneejOGUwzJFNKiyyA0zHoOdh4zu7cwHyRUMO0jpmIuPIO98jwFsLhw/psZU/s
 xGPd+P40m9NRZKJoHUsftYXUwpW0yo1CsEG6hUUEkJT3b3pAfMDMy34+VrOSpaPdx4xK
 vJdG9DYgwUEe6d4UTVQMpBWwsQt6Azkv6fvuOsdwjsj1zXfnhMYQYpT4asZYwZoLM2e7
 wf3qvk0e0Lej9aJHpaBDfN8DgcGYWoqxkrcBQQMuqG3STxz1977sdcqNPYocqZorJJvC
 bKYiBhu59N+sYqvWkqdotPbyOjO9ytGJh4FCQ7TpWpZEBRl/ie41vYCB+XxrtPXzp00Z
 MPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091893; x=1780696693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQPx51Ys0BSe0nfcuWwE/ESRFU/f2P1cefwHo05cHP0=;
 b=gIbnPgGPvk6ThFwTaoo52ddjSnXFkmgvkz8XLO+/gyTQ84gL/GuAeucScvJ9syPhY0
 uThJxzTu8e0OSouVKism8QGlio7UJt2zLkAQtvJkBNc7+O3ikQ85ofj2HamBL8iGdHZz
 4pcs9GHf/pOeTcWMffEEOBIIVrQu/YcXfncPJj7dFhwXnDQtpiHXWiMRd3X5kn/GY/RD
 Y85uh/AEbd9wz6MA9vG/AK+7CsVfLfO/g6/Fk9v1H7xxRctZED+J6tintRSBFoR8J1pV
 07weidGWeKuDR2dJpp3ib8NaCXytczXxNSzAfQ/aPzEOOqTcurMeOrSKWpQR7eEsR5WV
 aClg==
X-Gm-Message-State: AOJu0Yyy2pluWWoS15kcyQMDlYHRX/gSe6Ek5u9a6E/yRiFuOcZGlp+5
 EZDhJcSfZg7S8eIs17NnF2bXwAcNv8CFSGJIvXa1klYf1nQn/8zQtFnvJY0Mv2gKsUoJqj/uYP2
 4SE8eNPoxHSEzw9GRSCHG8IJHug8brlkbUoR7Q8qPQS1Lw65ZJOTBjiPFxrhKkCLaBg==
X-Gm-Gg: Acq92OGHhaBx5ncmWMpUC2rWuA+0/rY+VyEJSAQMVJCuz8PoUDo0q/qC+2QdF8WgVwK
 Iw5/gtLJaN+1iBVwGn7TrOHKRMTKjvZr1r1riDbd9EmZvfuMXwhuRSDYXd0hasm9vYQhYubZdXv
 rF3LSSDFP7/N2NaDbWS2j4JZ2xFxZAE5KZgEpQ/zeJxUlb5T2/3PRWmZSeu6mG1nwJAJyqxkKLH
 exXkHNcdUMqjAM/YbYp9nx9Ee0LVyOGCrL8JvCkcf1LC7Mxc4IPcqmJQgeT7r58QHM1GA6hDOlP
 mK8PSUlmhLrb5aVn7Ll1FsP4dUmbLAzqYZVkpuP7tUZ6gM/6nFwRmk0Usgu/I5QfoABTvDfbCd9
 HARq6LGk+GpsiNR7SZor4nnIz0P8QVfGCb0cFyePPoJHVaA4JqoxSMubLnd0s4AxhC/qQRqKEb4
 ttVUy4
X-Received: by 2002:a05:7300:a44c:b0:304:67ef:41db with SMTP id
 5a478bee46e88-304fa75e16fmr755946eec.28.1780091892779; 
 Fri, 29 May 2026 14:58:12 -0700 (PDT)
X-Received: by 2002:a05:7300:a44c:b0:304:67ef:41db with SMTP id
 5a478bee46e88-304fa75e16fmr755923eec.28.1780091892191; 
 Fri, 29 May 2026 14:58:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 02/28] target/hexagon: Implement iassign{r,w} helpers
Date: Fri, 29 May 2026 14:57:40 -0700
Message-Id: <20260529215806.608770-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: -1clpElxYc2-Qa8iYerFDcDt3MUpWxWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4H5Mv25jbuM7
 6zlRz33drOezDMnQWsKnWJOlom3IQdPrpUpwkzWBiqhaGdgk9AD9yzUo17LCwHpIy9tGkz7wXfJ
 1HeRgPHrVGEr5eV1XZaRQOlmtN+7kxzekobhc/yki78Y2dx8XovLtjtARn39gmBpcNtV8H6/KMt
 ecxkbISO7w179T1SUCcIWwXtT3UoahonRPXr3lv5zoKqapQYeBgEq7IZfxBB6jcE+GkNkY0mOQl
 UBgHg4UAVabtQE5U/At2j5vV6a/gKDDjKvTcwWjoS44c9mjm4GgnIWclb5sqcmm642I2G44D66l
 a3WyBZ+D8gUD44RBC/17nd8ZqTQeVbTc66mBpEWiX60SkEWjRENIRxgEwuq8YdY3RJ1koyl2C6o
 DGZRZzAq6G4doJRtxA0gLP7g6Chp0idW+Ds5XAqB3OKOTeKv3cQXGbMQvOYoXo31ijDzCwSntEY
 nSWvh03AjAZyrUU+8YQ==
X-Proofpoint-GUID: -1clpElxYc2-Qa8iYerFDcDt3MUpWxWn
X-Authority-Analysis: v=2.4 cv=Z4zc2nRA c=1 sm=1 tr=0 ts=6a1a0bf5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDA0ZDlmMTI4NmM5Li43ZTZlMDRlNTEy
YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTYsMTIgKzE0MTYsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

