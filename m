Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED60CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dz-0005Wt-O7; Fri, 29 May 2026 17:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dx-0005NU-Lp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dv-0000vw-Uu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQeRa877141
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2VNTg2hRB7sMnPAli+/93SbHw6Nr4/kM39xvLcXxGeA=; b=K45NerKAIVVQovHX
 YFbqQNBLl+UgjGutm0XzZsDcbl4cSrFohHjy+cBhj6zSXdri6x1fG5wDay0w77K/
 WAkiXTkqxC7mUXpId8MOgXC1+jW/LoOs0pH1PsibM9AgkhzgG7w+7eCAxerFszcb
 NjhR8PG6axLTTNya8SZi1Ag1ohiPEJL4NLKXCuxN2S6Y9Odg1EeTfYPODyv4MVuP
 /imQBJ3j9sPECKiAyCLfFSUuDlfXHxRJ4QCfSgyn72J+JmhU1TWFisFFN7d3caSC
 4mDMHz9VmS1D7AEJiXBEhhuWO/qulJcFc3NWZkmfV/V4tiwV9poRuXndcASzivnL
 +3i+xQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg340ucp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so5110468eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091914; x=1780696714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VNTg2hRB7sMnPAli+/93SbHw6Nr4/kM39xvLcXxGeA=;
 b=OEgiKO5/miAX2JwDGkgiaQ5HodWWetV2OghSQb6HTaKUUtR8cvznaf16/IDM7iLA5I
 CS6MSajkHB4OOazJf4NGJObk4qth+mfAOpqa735HVLJ+xVFdyU2ht+ZTzPdJURc0usg7
 tcvZEo9fJCiQRyr5ekpuXAQksm282e87lxdfMOtlHpi+mrVc33owTBieRRHjgkcjU6OF
 GR7WalFBrjQM70vlU+VYBcj9MKbVoKYXb2u6chzBg3Nm8H0adxjKuYpDln/i812rHYYC
 N6g6w6rtC65Iup/Qghb6CBtCWY/W+0BCJxiDoBiwnwCoKiZrcwmSvR67LfNaIHpHP8hq
 0oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091914; x=1780696714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2VNTg2hRB7sMnPAli+/93SbHw6Nr4/kM39xvLcXxGeA=;
 b=a8Sr5OoCdWIqrERlOfGNdDBxckbd/dy+zqbhb4Q/ipKkLDm/R66emi8EqmglClMxx+
 bwuo3i1/ubC2db+OwcFW5dx/+0iTKa2cB2GzkG4m0NbQkZwUFbAq9OjOeuAxnZXC/EJg
 kQyYXeVknpWGR7v/w0VlWgpNoGolvOCXAJe1o0Xw0YnSeZOwh5pW9++Or5fNLLvZlmWA
 rneDNZK4zD9klawQaHkxZR/QIo+Yt2xOZ6e+qn1oRIZjl9xVsBEf/GVGE7QlQABarArO
 6huw5vjSwokhpfKxsv0WyzbJnOk7CdAMzku/5O/18mgW9kx3+Dw3rugZIsDoN2rin6nx
 dbNA==
X-Gm-Message-State: AOJu0Yyr4bcsxhW2NYDwS4JvTCeF3Wo0AKvwDn7/7wRoGazkNPkRvT5X
 wR2jNzzOF3nEpea1pEHYyhEeAKXmTgKbrKh5ExkHGLN2GwGtHB9e7OrjhIVrTMa7w8B7SHUK8Gg
 wi2vT4fOJzp4qVdTrsI5eD/EcM85EAKuxjpFMz5BWxFFB2bYw8C2jPs447/P5DWxiZg==
X-Gm-Gg: Acq92OFhxNRXFgc8f2ELthEyOgtHi/NvmdCJ5xzpjqJkSVp7SL1uBVM6BTazHhid/RB
 5hSlzF/APlnGCm0MAixd6ImZ+mipgG6GA+TMc6W+sXjPaysGacotIDMOpRyXLOZFUYzKyauhwLg
 fgafuPCm4afRKRmOufyAwWn5O7o+fGcg/v3MN6ZcEmyRVXiZnX8JJCt6QQsjKCTFC+euxKnDLKp
 8NZLcWJWb33YPxCBmfCHRK88Ju7JMs0WgRBTwIOHyh800Ml/s+dy7af+sJOMzX+Fml+V0en8x4a
 NFBKN2WKc0Z52BTM/YSbuP5LXMSg8wX7Pswm5g6bKuTWqnMWAofuz6N+/aj+hW1Z3KoKGGOXx0k
 +hnS7cM+aVCklDRe1cLO4IOvMF4z0c7tHphSYYuZUJALR0vTGct5lsrzZ+XuHjH4ao5zwVt0iiR
 IRFdd8
X-Received: by 2002:a05:7300:2313:b0:304:2af3:5ffa with SMTP id
 5a478bee46e88-304fa5a949cmr907641eec.19.1780091913930; 
 Fri, 29 May 2026 14:58:33 -0700 (PDT)
X-Received: by 2002:a05:7300:2313:b0:304:2af3:5ffa with SMTP id
 5a478bee46e88-304fa5a949cmr907623eec.19.1780091913450; 
 Fri, 29 May 2026 14:58:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 17/28] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Fri, 29 May 2026 14:57:55 -0700
Message-Id: <20260529215806.608770-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: yql68BEHmGVvNLAcZfWfPhq9hL0p9T5u
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a0c0a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yql68BEHmGVvNLAcZfWfPhq9hL0p9T5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6MrpVsH4KIh6
 2HmA9G7R9tTf4YXHTOBEbrlI4Q87xlLas6u2HvVTPpJ+7NrvkHFDDJw6cd4rSKQPd/WRwI6n7Gz
 NOWN7/1iV3RQJppTTVR/IR6iBTQf/9z/v0hnRNkb0iuNrvgfatsRMiRrHaZECdQeWsa0o+Z7dDg
 gwqSaqir3kAOLinVitfdTO8aMby6RGLy6vLnU+3Fq1zj5R6Wyol7dWdNZdHqgGEhOKskl4ASi1z
 G62VYJPMHmJTCrAn3AsPvSJq30Mo1VqK8vfPj8VbSxaF1uhGntD21FaYLFynBAuUuHNLHIXE+JV
 1yhc3ueGUs1H+tLg9qD1h5Kgq78n8HAxRnm3FktEc7D8woVysLn0frVTjmmPDVCFF6crG70/ggH
 qoJz0Nuir+uKuqaO246muRMRzgv17iE8H+g5IFwuBT97xYTM3UGIYhzsw0v7r78Do3yTjjM3G28
 xBvznZF5cDjitHu/MtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZDdlNGM4ZGVjYmYu
LjRiZmZkYTAzZjhjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ2LDYgKzQ0NiwzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

