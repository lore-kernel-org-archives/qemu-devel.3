Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3496FD88F7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0As0-0000n4-IT; Wed, 11 Mar 2026 00:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arr-0000l8-1h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arp-0008TH-90
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKoJEO1863538
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T9JTYXW+AYZiCgx4x8J2yUvCzjHE/kbJu94Psbyy1pA=; b=HRm8g1vpdGPoecVn
 XRv7fikh4erMvqX6rQzYcywYfkL/YzoTjTMosg1cET2tXMKkygkyi4yUgieRFPkh
 84kNOuBOqlErCJLxI1eKBTmMwlyOifnqh2C8NT0T4ldxQUEakjOKdL69XFlI4Q1K
 Qu62sIHIbSyE+Uv1Q9ljCkrHvCEUJSAq+TtAsFg47fHLmZ5ri1PgSGrGkA17GuVL
 UERLQbN9+w3CNqHLC0H7pmD1savkwDvB03Q7N6D02ANyRvWMD4qYM813vVFuBH8e
 CTJiflVcHmcP7eW/yyDBCvfYd1Yatnf/eKu/nRYrEUDnYiAWMiQR+nANyYZuF1Pf
 cGc/2A==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82q1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:15 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-417120d5378so27421849fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202095; x=1773806895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9JTYXW+AYZiCgx4x8J2yUvCzjHE/kbJu94Psbyy1pA=;
 b=IWvf4+uVCLOAPi1yyEhXHzwJgXEMmmYlZYEK9LY5M4f8Qap7JaReNeJumJQZl9gl5X
 LbE0V/d04JwO+48tToYLKO/VZSXn2wycCN8KOKNYCVIsJwrB5/qp5DtipDa5ID8TapEc
 oNVGSlySFQwkqUYyVZDU/lY5jHockZfsSd//gi2nihjFN/lz7/Ls/FYKeXGZxXBu+Ap9
 ps/mGiq+3Sdskx9y26s6lxzyHTPQRTC1Rb1w54LPrVPyynunTfpuZHL5aKVFJZhLA9RM
 spvY2WONzVjlNJw1ANzQlcZqaXkzMImFuhwGu4mTcPFiAKEBNZax1Q7ge1yOqFtSTt4k
 OJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202095; x=1773806895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T9JTYXW+AYZiCgx4x8J2yUvCzjHE/kbJu94Psbyy1pA=;
 b=MCJsBjORFGaNARYR0so8HV0fQwxz887VnVd2QnmSiU146iG6xg3OoSkh62p6V+6Gbm
 tVbdbl74uaUPbKxXoF+mUXgLN04rI49rA/NJUo85535Iop5WrN/5Y+vLQcoO401oXp/L
 PmGOcEkOeyUmgM8XZnWUyg31xU6SMRh87q4cw/vX7Qg0/FoU56I6HWlw24FS82Zu0hvY
 1Q3LpXkAF5iqtmh73GiC2Kk4OWEKK18s1rSj0zMOg0iXCj1CIOi8yVfcTw9OVO+JTVv0
 mUXOCMjYbVYztUQxLwyfcjD5aqA19LIcZ8fYrhR5Wr5xeGrMgyg1TyGxCa4Ije+AF08b
 31bQ==
X-Gm-Message-State: AOJu0YxBvS6D6ge5gwFNXYpBqmHSmxzLGDZTIANY9x06HJ1cgO2JoxTH
 91kJyyVqQqTlS94zYSUI6VALGWX+hWDm2OI6nnFM+AhVcasOs2iIE98yKr3a/NFjh8sJ6qKOot7
 tyvq76n4OiCB21+wcibUKEzAaXM6QHPXEmmbc9A/UAYq9tRibzf23325DtTagOXh6dQ==
X-Gm-Gg: ATEYQzwT0/agPnDTU+N5CzCXbc5EJi/FL/Yjek+uCFGDwWleFPnwLpJ9fI6A7QTm6B4
 iK2I+xwtmPs6tjgsvOfns8GvbX95W58cQ6Lb0poXG7fetNlu41yG9k3oWmdo0a6y+nxKlOqSTIS
 R5zW4fFhlGzE/oVR+6R64Fi+t1cbZtqFRYtzJA1IUYjxHvCgII6anEODHBqOSzhKrkrWbgWJoMR
 q2k9gTcdnzbdt1GQIr0gaFHP4lmqMmTWP0X8frtTfx7H33nvA0vGqM4sa52bFtHf9aZ7/Tf3Hud
 k3c9JYwNzJkfdPN0dMkElt5IhLMVKZA23g1ABAvcBDlbSw5sUCgG4mT7ZImG5viD3Ewfyn6QsHG
 9pioKRjT5X0m6i9kKn6k/jwfHZ0rDIPy8nVO/U7n/HJV7sa785oIMJkcCqdC6thTSfjl/+g==
X-Received: by 2002:a05:6870:ebc7:b0:417:6c45:b92e with SMTP id
 586e51a60fabf-4177c6895fbmr794417fac.19.1773202094937; 
 Tue, 10 Mar 2026 21:08:14 -0700 (PDT)
X-Received: by 2002:a05:6870:ebc7:b0:417:6c45:b92e with SMTP id
 586e51a60fabf-4177c6895fbmr794406fac.19.1773202094532; 
 Tue, 10 Mar 2026 21:08:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 06/32] target/hexagon: Implement wait helper
Date: Tue, 10 Mar 2026 21:07:32 -0700
Message-Id: <20260311040758.1068731-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: yxq-Hu9UMo3X-dpABzoW0FKrMLLDWpJa
X-Proofpoint-GUID: yxq-Hu9UMo3X-dpABzoW0FKrMLLDWpJa
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0eaaf cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX9Air2kO1HT+X
 QKY4iGVv/PMmGmClZnh6uAEoSFzY4tzuQB4LN9ocZCif2EmgYa96IOw35mrvO6uiMkFcXjoGk3P
 Hb0ZSJVq/epZkNoVWU4MX99N1HL5d5ACxNu6Qda3/dXFM7aLd9eJhkIcGGbSTlYCqoFj8SNRAZo
 KhhfHhB2WEFfPGZhYZsajAPi9W6iHhadXaOtldvZAlTy1t4Dpsab7P598K0+2G6hg5WssB+lMKJ
 0w3JmHJe/j1qH2WLCiNuesYky67/YrrPO05EGxs03PSZm38yDxMCOUjyedg1xKAP/afcFEPVJGh
 N845sLpDSfQVFMWL5xt1AwVpeZJRriEuJPMr7bg19as3/p6tbSj6PUBvEv4F7cV735tIgbT5tkC
 MUwp6NP+0c2Wein0xM8l0uqlQWI7kGedgfwGVjizMO45qyc9U/BPewBI6MZYwRnHmFzQ6fYt3wj
 Y+0qT7BlzDVn2hIfgog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYwppbmRleCAxNjFjN2VhZjMxZi4uNmRmYzEyNjk4MDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0x
NDg0LDkgKzE0ODQsNTYgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYp
CiAgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCi12b2lkIEhFTFBFUih3YWl0KShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQorc3RhdGljIHZvaWQgc2V0X3dh
aXRfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpOworICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7CisKKyAgICBIZXhhZ29uQ1BVICpjcHUg
PSBlbnZfYXJjaGNwdShlbnYpOworICAgIGNvbnN0IHVpbnQzMl90IG1vZGVjdGwgPSBjcHUtPmds
b2JhbHJlZ3MgPworICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVn
cywgSEVYX1NSRUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYt
PnRocmVhZElkKSA6IDA7CisgICAgdWludDMyX3QgdGhyZWFkX3dhaXRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX1csIG1vZGVjdGwpOworICAgIHRocmVhZF93YWl0X21hc2sgfD0gMHgxIDw8IGVu
di0+dGhyZWFkSWQ7CisgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX01PREVDVEws
IE1PREVDVExfVywgdGhyZWFkX3dhaXRfbWFzayk7Cit9CisKK3N0YXRpYyB2b2lkIGhleGFnb25f
d2FpdF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFBDKQoreworICAgIGdf
YXNzZXJ0KGJxbF9sb2NrZWQoKSk7CisKKyAgICBpZiAocWVtdV9sb2dsZXZlbF9tYXNrKExPR19H
VUVTVF9FUlJPUikgJiYKKyAgICAgICAgKGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19V
TkxPQ0tFRCB8fAorICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxP
Q0tFRCkpIHsKKyAgICAgICAgcWVtdV9sb2coIldBUk5JTkc6IGV4ZWN1dGluZyB3YWl0KCkgd2l0
aCBhY3F1aXJlZCBsb2NrIgorICAgICAgICAgICAgICAgICAibWF5IGxlYWQgdG8gZGVhZGxvY2tc
biIpOworICAgIH0KKyAgICBnX2Fzc2VydChnZXRfZXhlX21vZGUoZW52KSAhPSBIRVhfRVhFX01P
REVfV0FJVCk7CisKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgLyoKKyAg
ICAgKiBUaGUgYWRkdGlvbiBvZiBjcHVfaGFzX3dvcmsgaXMgYm9ycm93ZWQgZnJvbSBhcm0ncyB3
ZmkgaGVscGVyCisgICAgICogYW5kIGlzIGNyaXRpY2FsIGZvciBvdXIgc3RhYmlsaXR5CisgICAg
ICovCisgICAgaWYgKChjcy0+ZXhjZXB0aW9uX2luZGV4ICE9IEhFWF9FVkVOVF9OT05FKSB8fAor
ICAgICAgICAoY3B1X2hhc193b3JrKGNzKSkpIHsKKyAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVf
TE9HX0lOVCwKKyAgICAgICAgICAgICIlczogdGhyZWFkICVkIHNraXBwaW5nIFdBSVQgbW9kZSwg
aGF2ZSBzb21lIHdvcmtcbiIsCisgICAgICAgICAgICBfX2Z1bmNfXywgZW52LT50aHJlYWRJZCk7
CisgICAgICAgIHJldHVybjsKKyAgICB9CisgICAgc2V0X3dhaXRfbW9kZShlbnYpOworICAgIGVu
di0+d2FpdF9uZXh0X3BjID0gUEMgKyA0OworCisgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lO
VEVSUlVQVF9IQUxUKTsKK30KKwordm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IFBDKQoreworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisKKyAgICBpZiAoIWZJ
Tl9ERUJVR19NT0RFKGVudi0+dGhyZWFkSWQpKSB7CisgICAgICAgIGhleGFnb25fd2FpdF90aHJl
YWQoZW52LCBQQyk7CisgICAgfQogfQogCiB2b2lkIEhFTFBFUihyZXN1bWUpKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQotLSAKMi4zNC4xCgo=

