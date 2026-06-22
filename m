Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BF7CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndC-0002te-EZ; Mon, 22 Jun 2026 19:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndA-0002t1-BV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnd8-0002T2-Rn
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbA0Y2122413
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=; b=IhEpsC6Sh6q3+RLY
 eSmWZUZK3heXET4eyHZBa+MeV9Jel/zap5R5Td7EztGTK5KLE3E+ghNg0iojVqN+
 dJG31J1l4dUlHMKI1H6FKwPbmUpTnM2UeptCkTI9uvgK5KIKdTDKloCcnui7wVcc
 dR+/G8SKXhCO+f4RAnjnOGr0NxRaTHzyjR7FCGQJi7ORbMBbAdmEjuiSk0KrlG9k
 zGOWFG5vuasLglRc7UJUmnMSFU2BjJZgkJerYpAfxBhww22YD8kiSqciXPeXDl/7
 JCJ/s9xdiy51BOQqWDWPT8qgRGGvdDrW1M3WOoq38Bcl/cRI4iUYD6U4kemJr+9f
 dlRZFg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n421ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so24364336c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169227; x=1782774027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=M+LUNhqBxPofRQHCCzWKUVScnZAULcBrrrBB4joMel6d4wHWBUufqMWoZuPmuoG7OB
 D8344u3gtR6k+XFhhZhA72xhBfHXjj6ztmlOgi4IBozaDcur+Qcv2cNIRFeCj1WN+3nj
 Yz0DOaDprF7G1TJvxI6ew4Lg0Fg7LYVDO0tLV8NHG+DMTY87zNEXekhgb51/6EDrhJcE
 wgme479KPQdGpdRK8uxuzYsr0t21ObCsCez391Vuz3BIU9G8CmFPeq9Romg0LVjWOiPE
 z0ddmJOxojRB3IPYWd6hKTn55QAa0NlLRoHD5Uv0Q9URhwphQFQK9+7gAiQtnI31V/MK
 FioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169227; x=1782774027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=bVpngneZiMhHfDnPLFqzCS/DyXAT0xJvpJ1NsTSUf1y9zF9AnyR9VQDTpb8vD0ZaGZ
 o6xDOrIYZA1yDY2+muEwJ0kmlxAhQzeC8d+KGFvpawYuqAQSPw/xY3V5rKgldlNkEJjj
 TtTc/1XsObvWMyqEn7/rnscLfQzPqXsqymSIuJt8aQlr4anIaZpeCMPcjia4CSj/fMGf
 1m/JkNAZj7jHDujhf4jZkLu9yTeMQnlz2Nbv9yLJuIx1lEleTdMMNkN7d22Zpqofsijb
 Eiap5FiubyL7/ATSD1B/jnot567KYo5BOSGzwznxHgFvD2HmIEOTYU1Ba9dq153gGZB6
 5jPA==
X-Gm-Message-State: AOJu0YxpyglnAH9VFGWbs77N1RFMDoOgfgQJ6D1YRSkNX4wCfK0p773u
 eoWsQ7aVDmU16rwWeXn/MSptMmkYDVZa9hm8ZMj0WVkV5N5kchlHKStcLVgLEyqOCz0UhxXrvkZ
 yXCpEAWNq7K3CG5xavW23kGEndq/80FTauHGWLW/+SiVOgv3fkxipmoiQRLHNwoI4cw==
X-Gm-Gg: AfdE7cnVDiFGE8q5JYlDd5URVNWGKuKJ6N6LdJ67SwKAlmJqLxZc1S9Fe9oL4dW++Nx
 48qEUfV+byG9PEpl5jrq/xNayum6xROjeRouIndSKx0HDycmBRyLnLczwGNxrdBvef7/TehqYZr
 wLwN6BAsJYMJKv2AkFex+FufcWG0O8x3G1LQ/j01nlt0jc14DFZPe8AvnAhqGA/mAcoIQjvQysu
 nIj2eG+Wl2YoBtS5+pAcTbK5OFMTi6gsnL7UwnsiaqDxnuSYXncDBxG4x+eGRgBkB2Um5jgEJzq
 1zTydcaynhXo0KbBto6icnZimHqw6bC9JaeL4qFxVptskXhrgHh7T6wWYm7mCiR8QRap3qV3SYp
 SPynxXDHaSRdN3j5N1AAoQfrzeJZaG0C7o96s9sRA42/TdEe1ZZEls/8yL2c=
X-Received: by 2002:a05:7022:68d:b0:12d:f0e8:9696 with SMTP id
 a92af1059eb24-139a20361cdmr9696761c88.4.1782169226632; 
 Mon, 22 Jun 2026 16:00:26 -0700 (PDT)
X-Received: by 2002:a05:7022:68d:b0:12d:f0e8:9696 with SMTP id
 a92af1059eb24-139a20361cdmr9696747c88.4.1782169226084; 
 Mon, 22 Jun 2026 16:00:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 53/75] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Mon, 22 Jun 2026 15:28:42 -0700
Message-Id: <20260622222904.607771-54-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX3xOAUzyK/vW5
 kR0cor6M2SUuKwAt7HT9nD+A6U1F6b/L276jfRviJqjfyEWYJnicJ3Y72OhXrxplCoUmhqbiesf
 ByMaTn2qR18ETGiq9y5v/VYf1uaOPUg=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39be8b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DaJ0YY1rdwRHmHjU1Tw-ema3SpynwY30
X-Proofpoint-GUID: DaJ0YY1rdwRHmHjU1Tw-ema3SpynwY30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/JVElZ2AHlqR
 gkk6I/9lDxEF+fSIyhgyvXnsJ4D6uKgeVfHpBffi1VNQ8ITI/8+uNZk4zFAoMvMoCS7rgGDaE9E
 gBcWeWwbR3hw9QogeTnB0wQjxUpg2NbBAFk3MJ3+FyVNMTr8BZlhxTLo9Vhvb8NydAfBnGCXZH5
 ea7j//NgJ0pSrZLjTMP/B2oIGIVmE187K0L+R1m4IYJf+G4ti7gnaEVQUIeYWa1vyt7Lb2ShgmL
 4VjFKMIwyX/N4Zu4dkp7qqN52JVPyTFXvzfsTWVA87GJ+4qTN2jvxI3g0ixEQcPMl3Fj2Ra8JMo
 0iqrPiEyvQNdUEFXtM08BJ+ys71Q7oRg+CPx1Aum1Z5HMndCYfNJKn2A95YlmVrAdnq3JSop9wx
 zJkkTOlWuK0QubrT1e7xkSq8C9gPr75LEG7QAY3YU/GGPQQsOSBE1nvbrkbOOwSux94ybnQKh9r
 CDBLoaUo5tU8gEndGbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0ZTVhMjU3NDRhMS4uNjcwNjY4ODA4YTggMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCkBAIC01MDQsNiArNTA2
LDI0IEBAIHN0YXRpYyB2b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRyLCBod2FkZHIg
KnBoeXMsIHVpbnQ2NF90IHBhZ2Vfc2l6ZSkKICAgICAqcGh5cyArPSBvZmZzZXQ7CiB9CiAKK3N0
YXRpYyBod2FkZHIgaGV4YWdvbl9jcHVfZ2V0X3BoeXNfYWRkcl9kZWJ1ZyhDUFVTdGF0ZSAqY3Ms
IHZhZGRyIGFkZHIpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsK
KyAgICBod2FkZHIgcGh5c19hZGRyOworICAgIGludCBwcm90OworICAgIHVpbnQ2NF90IHBhZ2Vf
c2l6ZSA9IDA7CisgICAgaW50MzJfdCBleGNwID0gMDsKKyAgICBpbnQgbW11X2lkeCA9IE1NVV9L
RVJORUxfSURYOworCisgICAgaWYgKGdldF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXNfYWRk
ciwgJnByb3QsICZwYWdlX3NpemUsICZleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhZGRyLCAwLCBtbXVfaWR4KSkgeworICAgICAgICBmaW5kX3FlbXVfc3VicGFnZSgmYWRkciwg
JnBoeXNfYWRkciwgcGFnZV9zaXplKTsKKyAgICAgICAgcmV0dXJuIHBoeXNfYWRkcjsKKyAgICB9
CisKKyAgICByZXR1cm4gLTE7Cit9CisKIAogI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKIApAQCAtNjExLDYgKzYzMSwxMyBAQCBzdGF0aWMgYm9vbCBoZXhhZ29uX3RsYl9maWxsKENQ
VVN0YXRlICpjcywgdmFkZHIgYWRkcmVzcywgaW50IHNpemUsCiAgICAgZG9fcmFpc2VfZXhjZXB0
aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFk
ZHIpOwogfQogCisjaW5jbHVkZSAiaHcvY29yZS9zeXNlbXUtY3B1LW9wcy5oIgorCitzdGF0aWMg
Y29uc3Qgc3RydWN0IFN5c2VtdUNQVU9wcyBoZXhhZ29uX3N5c2VtdV9vcHMgPSB7CisgICAgLmhh
c193b3JrID0gaGV4YWdvbl9jcHVfaGFzX3dvcmssCisgICAgLmdldF9waHlzX2FkZHJfZGVidWcg
PSBoZXhhZ29uX2NwdV9nZXRfcGh5c19hZGRyX2RlYnVnLAorfTsKKwogc3RhdGljIGJvb2wgaGV4
YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVl
c3QpCiB7CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKQEAgLTY1Myw2
ICs2ODAsOCBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAg
ICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9wb2ludGVyX3dyYXAsCiAgICAgLmNwdV9leGVjX3Jl
c2V0ID0gY3B1X3Jlc2V0LAogICAgIC50bGJfZmlsbCA9IGhleGFnb25fdGxiX2ZpbGwsCisgICAg
LmNwdV9leGVjX2hhbHQgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZG9faW50ZXJydXB0
ID0gaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZ
ICovCiB9OwogCkBAIC02ODAsOSArNzA5LDEyIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9j
b3JlX3htbF9maWxlID0gImhleGFnb24tY29yZS54bWwiOwogICAgIGNjLT5kaXNhc19zZXRfaW5m
byA9IGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgY2MtPnN5c2VtdV9vcHMgPSAmaGV4YWdvbl9zeXNlbXVfb3BzOwogICAgIGRjLT52bXNk
ID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CiAjZW5kaWYKKyNpZmRlZiBDT05GSUdfVENHCiAgICAg
Y2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3BzOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAq
ZGF0YSkKLS0gCjIuMzQuMQoK

