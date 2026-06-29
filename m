Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13041C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3gf-0007ts-Iq; Mon, 29 Jun 2026 00:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dH-0002fI-DG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dA-0000l9-PQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NTRt1777377
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=; b=jK2GDd5PpwtMN67f
 EZ56v3Dt4SfvOHn6EUmdJJuABqPi+rWp17MGSRY7TaGyRlqoXnsLGiEsr6TeigAG
 KyIV/HYn4XouoF6TxKDoLYTBx33U0L/i6/77KtqkktCY5Nv/I3ls6AAlWMjGc5pB
 DfwdN9vk1I9GZCt4R9ZdV4P5i/yNkyBRlB/5SBWBbEqDW0VX5gEbZGohPU1hHtqH
 FyZHzz/kmHdYJGJ26UbnpHYHrkcrCcClyzOnZ8GKkYBg0jQ4GPFsw9emvCir1uDt
 Od+a5SssrIxU1xy72vzHC2VDTm2UFqjUPPpKvnmHCJfpqbsUOT57klOac6XRrgP7
 Tg1etQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mg7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so3245663eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707394; x=1783312194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=K4JVDe6tOaOp8aw0Ma56PJj+JbgHgAoglQIiWCPsbfgz4ZGePUqYqzzbvlqGTyzavx
 tHT+IqL4QJ7sUwabe7hQCl7AEV2btG0FVe93w6z+tZwARRXMtQdzBNyoBMQla3IkQhNr
 qMmWhLC6CUBM+HtTqjja+A6ZgBW5+iOurjZdZoAEzleNK1n5O78aNM1E7MNGI7t/fLDS
 7HGAemDa6RIR8V58c5N9dosms7AtvcV6gY9ls4uPla06ieZs/8BuoA0/BJgp+Ffpu1vk
 M+1BPBaYlwVVMkuK+uHU5ICBfZ7Bje535uRLIJ/JUboKbr9DmH9x9xUPzEYxHI7cE+eM
 HLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707394; x=1783312194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=epMzVhboddbCKFKNSEOJKdzg1upF/1HWkXZmsOwah0LjP9MLwhd+3wAL2H5Kk6OpEg
 nGufh5/CzS87R434GMkL85GDRpaX/Zm0QEnuGJ4JFU3ItVlF+hEn/WTIf4npfiftebpY
 lb2h4OoJoQewr1II/oCHdWinrsmPmZ0S2Jn68BK305dRry231etx69j30nbHQusTnu1q
 RFa6ji6XOTfZcUhh2KsK5eR3h/qnyF/xV8V+SUQ5ypWB5GNhRW9woEcKxk1WhIeWIsgx
 8ilzuVHP+hgoXvSFoPFgcitI4Uek4XjIxenGw4a3nN3xEiS8Jd4XQ8oHuoGTMkz60eyw
 Vuog==
X-Gm-Message-State: AOJu0YwtkV/+0b4d01b/yc/KpIjlAngiWAyjcMBOiIlmI60EjODa3LkV
 XkyR0QJRoe3hqdYhBNYlpWmLnV+XmFbWRnSru0II+gfWZ+tSBr+EtqRpIwmNfCm5hCSaRt14YjE
 54Ns2pZLeov1aS+MTWDMfC8rAwv97iCIpCrD2YVvtwAqg/XeLHKxwWzxQEUSjXUvcIg==
X-Gm-Gg: AfdE7cnRNRkLvCUPMQ8oMifh7+uQEdfJw5hDi6HPOveobX921fq0jOKjM3k7ovJhmyC
 ZDGeXFm83qbgJ+afsrSJjL6wCmtpDjMv1WSjPZM4KCTwYpi8D7tDV5hDQeJgGd8jkqnZP4uS38q
 ACypF4Ul03VW99+CdRANgYv7gfw3T6CvykveP4mvRVhLGbN8ePlEuUwVyjxvuvixQ0Hz+pFZji8
 L+Q5xEfx9ttmddb8g1riaZAxS8BQ0f9ITucdh/G2acy/ewugsDHa3DY6wr5p1SjH98nB6NwczQp
 H/87W/QkP1CRfN9cWEyAKotwz9U2uFdQaFBMJh+iwPZvs805dIhUXAJMWWHJunMa/1H+zkLzaxg
 oLPKHEdvKsfdAVe+1yuLm6/GqGk6LC0z2dU+3qRK2a+nvcN+Zplxw8z4RvHI=
X-Received: by 2002:a05:7301:5795:b0:30e:cd78:a6b2 with SMTP id
 5a478bee46e88-30ecd78adf8mr1343158eec.4.1782707393668; 
 Sun, 28 Jun 2026 21:29:53 -0700 (PDT)
X-Received: by 2002:a05:7301:5795:b0:30e:cd78:a6b2 with SMTP id
 5a478bee46e88-30ecd78adf8mr1343139eec.4.1782707393112; 
 Sun, 28 Jun 2026 21:29:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 50/77] target/hexagon: Implement exec_interrupt, set_irq
Date: Sun, 28 Jun 2026 20:58:03 -0700
Message-Id: <20260629035830.1520296-51-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX6vBv9LwFdj0N
 t6QbKDYJZpoN4v7iMI7U92YHQxjku/26oKqyIDT0vmKh2BAt3TH1XJbtOmDJisraP1l9eUe20CY
 Wobjft67tBo5FcVUskeN2OGmXR031N4=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41f4c2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Gksi4alM-5BSUnw8-m-unPhZjNJiWZ9y
X-Proofpoint-ORIG-GUID: Gksi4alM-5BSUnw8-m-unPhZjNJiWZ9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXwM6M6k96a6VW
 H1CgI75/Y08XGEWZx6y3RCB7LLJ7JCgdrb5wpjLQuFGmkt7BffO18Chr0U2KuU1dKnbMwVxbkFJ
 y5C4VkWaptcWdQWbtKlmvqgpBuYt21/KkJLfKhiRmUppH+XBa4OOdV7FdQpQ/2tkt4HzQ0Kz/jR
 CW4dUWojZN3/izin39IRzCgebsFJZOkKAEYGZZLBHutYHAFzjnqiHde3kv8ktI1OWLlNrrmbVps
 i0JJ+Xa48WNdiBZAcQ4Se4qUgemWdCHMG98rDK0I+PNkvEomjfbNAKbp7K1IYRjHMDmOL64wj6u
 1FyApyI1G8cBWpLnZyjcNcfOCyjH2qsQrq/4dppKfbMPY9nj9JRhImXdZekN2asZYKI07+G54oH
 XoocouTCL520iczS84A441S0CqQsJqH0sGhc+T/t+EwRwe7nu9L7ex0cS2Nl3dxrL6T328ydqrD
 P7qfDnobTPVOwGLiarg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBlYzBjYTNlZTY3OC4uMGQ2NTUx
ZGQ1YjYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgog
I2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIg
QEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2lu
Y2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2Nl
bC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5k
aWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1lKGNvbnN0
IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTMwNCw2ICszMDcsMzYgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfc3luY2hyb25pemVfZnJvbV90YihDUFVTdGF0ZSAqY3MsCiAgICAgY3B1X2Vudihjcykt
PmdwcltIRVhfUkVHX1BDXSA9IHRiLT5wYzsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
Citib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7
CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICB1aW50MzJfdCBt
b2RlY3RsOworICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21hc2s7CisgICAgYm9vbCBFX2Jp
dDsKKworICAgIGlmICghY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyAgICBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIEVfYml0ID0gdGhyZWFkX2VuYWJsZWRfbWFzayAm
ICgweDEgPDwgZW52LT50aHJlYWRJZCk7CisKKyAgICByZXR1cm4gRV9iaXQ7Cit9CisKK3N0YXRp
YyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKK3sKKyAgICBDUFVIZXhh
Z29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgcmV0dXJuIGhleGFnb25fdGhyZWFk
X2lzX2VuYWJsZWQoZW52KSAmJgorICAgICAgICAoY3MtPmludGVycnVwdF9yZXF1ZXN0ICYgKENQ
VV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJCisgICAgICAgICAgICB8IENQVV9J
TlRFUlJVUFRfSzBfVU5MT0NLIHwgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSk7Cit9CisjZW5k
aWYKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN0b3JlX3N0YXRlX3RvX29wYyhDUFVTdGF0ZSAq
Y3MsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFRyYW5z
bGF0aW9uQmxvY2sgKnRiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCB1aW50NjRfdCAqZGF0YSkKQEAgLTQxMiwxMCArNDQ1LDU4IEBAIHN0YXRpYyBpbnQg
aGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0YXRlICpjcywgYm9vbCBpZmV0Y2gpCiAgICAgcmV0
dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxldmVs
KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9wYXF1ZSk7CisgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKGNwdSk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52
KGNzKTsKKworICAgIHN3aXRjaCAoaXJxKSB7CisgICAgY2FzZSBIRVhBR09OX0NQVV9JUlFfMCAu
Li4gSEVYQUdPTl9DUFVfSVJRXzc6CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQs
ICIlczogaXJxICVkLCBsZXZlbCAlZFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgaXJxLCBsZXZlbCk7CisgICAgICAgIGlmIChsZXZlbCkgeworICAgICAgICAgICAgaGV4X3Jh
aXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGlycSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsKKyAgICAg
ICAgfQorICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9p
bml0KE9iamVjdCAqb2JqKQogeworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgSGV4YWdv
bkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqKTsKKyAgICBxZGV2X2luaXRfZ3Bpb19pbihERVZJ
Q0UoY3B1KSwgaGV4YWdvbl9jcHVfc2V0X2lycSwgOCk7CisjZW5kaWYKIH0KIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKK3N0YXRpYyBib29sIGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0
KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQoreworICAgIENQVUhleGFnb25T
dGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BV
X0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAg
ICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsK
KyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChpbnRlcnJ1cHRfcmVxdWVzdCAm
IENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsK
KyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sp
OworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0
ICYgKENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJKSkgeworICAgICAgICBy
ZXR1cm4gaGV4X2NoZWNrX2ludGVycnVwdHMoZW52KTsKKyAgICB9CisgICAgcmV0dXJuIGZhbHNl
OworfQorCisjZW5kaWYKKwogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29uX3RjZ19vcHMg
PSB7CiAgICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6IHJlcXVpcmUgc3RyaWN0IG9yZGVy
aW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29yZGVyID0gVENHX01PX0FMTCwKQEAg
LTQyNiw2ICs1MDcsOSBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9
IHsKICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5bmNocm9uaXplX2Zy
b21fdGIsCiAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4YWdvbl9yZXN0b3JlX3N0YXRl
X3RvX29wYywKICAgICAubW11X2luZGV4ID0gaGV4YWdvbl9jcHVfbW11X2luZGV4LAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLmNwdV9leGVjX2ludGVycnVwdCA9IGhleGFnb25fY3B1
X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCiBz
dGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCBjb25zdCB2
b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

