Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBCCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5E0-0005bs-Vb; Fri, 29 May 2026 17:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E0-0005Yg-0o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dy-0000wE-Ch
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2OmR1862753
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uA/ZdyibhVq3w7u6SVL95n2qojKuqLFxM6O/1uzo4Aw=; b=F9F4WqFculFsoM4C
 vkLglMH9jYSOLfkKxBX9SRO8Itl3Wg4wbhmxW4U90v14LNDlgdmBVAt2l+OwGVNQ
 plkeEfVfIZw6jtOCbk8Mkdf31c6PW4vMvNjaV8/QqiGRGr/648q1THCggXXwNkbp
 MSrPz54PI68ayUt6DQ7M/dask8eKwi6/359qk2DBi6UqBIuT57ql904zn7+tTGO3
 4RF4cVpuAtpr5cXdLz/nTYWay/kypq3XpyLKBbUq7yEnloagZs1yPA/GRHfzQstB
 /rwNDt5MsAEAWZWX8FaOY42Gvu2e8CB0XK6p0VvplFx1/LBYQLBwa0kjf6qqoISE
 xN7ZUw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te4pj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so2001621eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091916; x=1780696716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA/ZdyibhVq3w7u6SVL95n2qojKuqLFxM6O/1uzo4Aw=;
 b=Ol3lEoNRjpa4u8hloZ9oSoxSNZTBo0O18+TG6SYibpCgiC2Ud61EE6cnhPF3b7UvSH
 aWLfdTiT04Y0ABJX4GmOwSqBq8RHZ8nlE9UcmDXMsoIXlQWAmwjIxAq5BFiuo6et4/91
 OVhBKhw4n9x7OCgwsV2WR7pwUxMUbdjAc9TE5RV8XNTVPASYwuVbVXERgHUjfJ2ZyTt4
 W6l8DC210Qq/Qql6Yp4SZeOHovJxRt+Aznd8yRCQ6HGhhNvq365a9/ElMtVO7pmx0I8H
 xjyDbhY1epg6BnklYyz+GobW37gSgoQy5WKM5flPQYNhgI/DrxhosLsW3lJ3+nzvgQ4R
 CXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091916; x=1780696716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uA/ZdyibhVq3w7u6SVL95n2qojKuqLFxM6O/1uzo4Aw=;
 b=HhjSkkovzpo5B6p6KKj+oZSXEz2LSMfTpeFx9IJsesEs1Wgour3PvNq6vG85a7myJ+
 bQV6K1L7OWudch0LcSbDRI0f3uVA2NWMUX2DfUoAUo5AS5paF554TuRNHVfi0KAufv9T
 sU3x+2IvLpvD6/KHISqxdDQuz02MIQQzbNm+8Is6W0KqREkq1jzV53dDX+FdDF0vqjwG
 xPb+F4sUzbZlEx+rlj55vNJzSyo6cn1iRwtfaGMT9VqE0cTJs8sB0ZNgGxk0e/MsbFWI
 Zgk6xOF8LohOtfotlhCLHim4dF/KM+cYoObHfuTGpiNbB+E/yq7f+P8dZw32+u5ZQjxR
 JtHA==
X-Gm-Message-State: AOJu0YwSSKtRwRfSOwLU48L057Jg4m+W5HqnjT/ZrpAv6mzcMTw+qfJV
 NQN08JFIyLFM43q/ybgBTYHYB79miWR5kLuaB9EyGWryvL4cK9vIwopyC/ga1LzokNdCkRdTeKv
 UF2Ksrgc+zjIx9eOP7ITc9UZNpFIHUnjKgwavuYD7hkhhrfX57TEuGyAQESYp2XPpdw==
X-Gm-Gg: Acq92OFtfxoFKPNRuLxbQSu3QZOiLW1hsKSCuhQ8XgsW+O64dUYuFSjO1k/iAv6tNKt
 31n3ikl/3Pe4MABTF0XPCbiI0WGeHwMnIdkHuGjfTH6/EolqIe6c6WDhaqW+y0kwlB/XioUNMz0
 X+jRjXnYheIQheUsCzCnAhORUbxjNP3bjrW+9UrzehSir5hoTtFlDPRpafoWIC7NjPyJGcrShwZ
 b/d9/lJC8WYwDKsLwRNplr/VtbgyhQYX5yGAPwmGF+dBVF7ppFaZpwQF1UXX6pHjEZtxKrm9A/7
 qqYEnNtkzFHQTE0Pk9t1lkwGq/w7+1Yrx1CSBqLl1AwRaw5N2T/GKg6Ryk+zRVKh9idI8p2O+dQ
 O4xjc8xD8/0zJOTsHgpa/u94XJBxAvXXdXzPQ0PZysmu+rfX4ltoYCCVKCh2gKoutuni89fTMQ9
 F5Ix+/
X-Received: by 2002:a05:7301:1f06:b0:304:8881:b82 with SMTP id
 5a478bee46e88-304fa4cf1fdmr823953eec.1.1780091916354; 
 Fri, 29 May 2026 14:58:36 -0700 (PDT)
X-Received: by 2002:a05:7301:1f06:b0:304:8881:b82 with SMTP id
 5a478bee46e88-304fa4cf1fdmr823938eec.1.1780091915874; 
 Fri, 29 May 2026 14:58:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 19/28] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Fri, 29 May 2026 14:57:57 -0700
Message-Id: <20260529215806.608770-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 1FMNDC5RQGiog-vDakbNQ5cK2BW4WgLv
X-Proofpoint-GUID: 1FMNDC5RQGiog-vDakbNQ5cK2BW4WgLv
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a1a0c0d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=w_Ktf-yQGdqK2aTfpWsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4J7DUanBmf5A
 ZEINaK2Ps2VcB17uvEqZBYi+tFHRyN4y+CI4AT48p/Tz8WWhO/QIuGyiycrD1m4LBJywPmrFwn9
 iE9fEYIry4qVxIdXVOHzxi78V68lj9MxrBY/DYCjnrLWJM8fJRBR2Kw6OWIsJDl9Qe2lOEpZHqR
 QJ1KOooilmb1oduVMNxWMnXXYbzfM/RAx8l3CKmnlpA+HZdEcIfD39nSCOqV1OZE8Tw8AcLjEpV
 8hDyqOAxjJ60xcKRX2RM9JCFLyKQ0SnoJnFtay2nH6L5pZ2J+5ROwSjmjpKlvWZsplJlDDbMfip
 ho3R4136GvvocxkMAmNc0+g2nfyc9yVo/LOfQK7dsmvGjVnEQRhpf7dqiWEag+Na0cBkTUJFcF3
 z2u5sDLka4sViKLjWaOINXniniW1mMtFwFSoZc7I0QuHjb0piAuPnNJdOL23nOSmuqkAWUr5c8h
 5sWNzzcFe/vJiHC1F6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDIwICsrKysr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5o
CmluZGV4IGViY2Q0NzFlYzBhLi4xN2U3NGIxMmYzYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyOSw0ICsxMjks
NyBAQCBERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQogREVGX0hFTFBFUl8yKHdhaXQsIHZv
aWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIpCiBERUZf
SEVMUEVSXzIobm1pLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShyZXNjaGVkLCB2b2lk
LCBlbnYpCitERUZfSEVMUEVSXzMobW9kaWZ5X3Nzciwgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RF
Rl9IRUxQRVJfMShwZW5kaW5nX2ludGVycnVwdCwgdm9pZCwgZW52KQogI2VuZGlmCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jCmluZGV4IDgyMDYyYTJmODAyLi45ZDliMWQzNzgzNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEy
MjYsNiArMTIyNiwxNSBAQCBmbG9hdDY0IEhFTFBFUihkZm1weWhoKShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgZmxvYXQ2NCBSeHhWLAogICAgIHJldHVybiBSeHhWOwogfQogCisjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKK3ZvaWQgSEVMUEVSKG1vZGlmeV9zc3IpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKK3sKKyAgICBCUUxfTE9DS19HVUFSRCgpOwor
ICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIG5ldywgb2xkKTsKK30KKyNlbmRpZgorCisKIC8q
IEhpc3RvZ3JhbSBpbnN0cnVjdGlvbnMgKi8KIAogdm9pZCBIRUxQRVIodmhpc3QpKENQVUhleGFn
b25TdGF0ZSAqZW52KQpAQCAtMTY0Nyw2ICsxNjU2LDExIEBAIHN0YXRpYyBpbmxpbmUgUUVNVV9B
TFdBWVNfSU5MSU5FIHZvaWQgcmVzY2hlZChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICB9CiB9
CiAKK3ZvaWQgSEVMUEVSKHJlc2NoZWQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIHJl
c2NoZWQoZW52KTsKK30KKwogdm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFBDKQogewogICAgIEJRTF9MT0NLX0dVQVJEKCk7CkBAIC0xNzgzLDYgKzE3OTcs
MTIgQEAgdm9pZCBIRUxQRVIobm1pKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhy
ZWFkX21hc2spCiB7CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KKwordm9pZCBIRUxQ
RVIocGVuZGluZ19pbnRlcnJ1cHQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsKK30KICNlbmRpZgog
CiAKLS0gCjIuMzQuMQoK

