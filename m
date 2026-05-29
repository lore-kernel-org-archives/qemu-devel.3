Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ED3CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bh-0003Oj-3I; Fri, 29 May 2026 17:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bf-0003Lz-CE
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bd-0000Mv-6o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2I0x199031
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=; b=eJNaK5lqGCEnsT2U
 h6NFpglijSo7YAd7ccHJWpUYlbyqMC1rBtIMwhJmqnEc3LL6Au5SoSun7fIH+a0Y
 w7LH4nx0qGyhIM5LgVA8LJieRS+UuIw2rOaMPtzNiUs8XkFgWHsbyewvxKRqAgbr
 b0xaWdPWPMJcOxjvIk8vmuyytdTuXY/5NfpVH+QZlsarnW+3M7+nZ1UNZnpGEpal
 oT469lXytDLws+cgczEh0SvfRK3M8oGdsNKblbVJvnFTZ5cf+2R1TE7Db5nOzw2s
 YxJZHNMMwRIwNOcNdgocDtGPCw6lG7xHqmt2gN5lbBp5GieWjycl/k937llNJsRK
 6XMXYw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnhxmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ea1eea05so3312515eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091771; x=1780696571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=E40E7QzOVbsydXM2vCYZrurOWM22EHiR58WMQig3qlPWgLJwhiocL2eU+6aZMw0czk
 YSiuCExZX9QYNpe0ZhTcLM2zsGxD5yp/HRB8TGYqtJAgHxb8CscI02vC4jT1zgwAiyAk
 tT0M0axZpmvfzR5fHqxHi/x/psEwJyuXC8vFIpR6iPOKtSHmJi7m+cvN3CUYm0DPCeme
 VjWH/LhcgJow91wWJKJgbNf57oRpWw8j/Pq8qylKT0sWab+0KebgKhEGJroI8xlMh0sf
 N6Jj8rNFcf9bjuvKzw4gU/sCuCT/Ugx5bHhmJxRTiqgretia51BgT2tZNidz+ESfUs5f
 wwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091771; x=1780696571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=d6YbEoE42c3XdPeAxmd8hXd+bQSsphidNKHG8JkKpDAgZSFApe1f6b+oIlpGHbfdHX
 0JPUUuFZuwQWS9dODGeuywRq3RKBor4RC+U9O+zV8vYvaJ+7Fw61Vdx1R+L5LbUCr9Bu
 bqmCyRzvATiEkQjmfhlzWan/DUI20Z/mzFNewKnS6n4gfIAUphE5oBGy8rivJMX2/RQu
 oZk2eVuo7I6njIUpAfTgWyFdUd5nXWyP03rb06y8FaOV8jNlRFm7d9sxU0YrRJlz8ieC
 M0QG8mS7ZNFS+qiWHR2IUHwGD4sI11qVDo8VQelKX3h+iA7Gvzr3r0LlXFYkAh/smRtd
 s5Bw==
X-Gm-Message-State: AOJu0YzLx/K0/zBZLyQdbC0P8qwi1rxvLmIvSuVOxBNPyB1c2Oe4lS3C
 uT07pHCGLcAr0JGmwZyWxOmeviZCMeh4ck+uYObn+qWAGhjzOCjO/1S00X37ZjYUeeLBzIYXNwx
 bXp27BpMIMO8/kHVSIDVzi6ZgIg7YDJJUEzxq1tZVzx5kcpDbz01/9ZkGx8ssA9Puzg==
X-Gm-Gg: Acq92OEfzLg7MRa9OYnuh6dJbNSCHiKwsmWgXai5XCrOnqVT+YHMKytx/woFq+PcCyn
 gpbUelCdhJmFzUU+fG8Em4QJZKlA4dlyNjhMyEoht3xabuopWnOS30qzu3OYkwBGOTAoeVmquH6
 +CYF3F7Abq/D3l2pETXDYHqu10vP/WodELulUfhSLbwBTSmGufMPubZR4yzhfk1+2N9wsZ1T8zD
 n16GmOpR1gsTKDbF2Kd3jXLsRzUshH9zjKpHJ/ZIbd35qaLEmKzQV9SC2nRrzP2IYY0OICNU+kI
 rQwaBofAsvPq61gHx5ff8FoQk8KZ9UmVwj+ee9E5FmLvX1YA6QTWpQh/s3MqAwMfRD4KEk2hraK
 doXdy0oAc/sP56LQdwr3A6upkWt7RyBr36q3eaoG94dBmyYMC70t/A/5PpMULR4iQfh6W000l2e
 fQIpvL
X-Received: by 2002:a05:7300:5712:b0:304:bc25:3d19 with SMTP id
 5a478bee46e88-304fa774f33mr850371eec.32.1780091770908; 
 Fri, 29 May 2026 14:56:10 -0700 (PDT)
X-Received: by 2002:a05:7300:5712:b0:304:bc25:3d19 with SMTP id
 5a478bee46e88-304fa774f33mr850357eec.32.1780091770393; 
 Fri, 29 May 2026 14:56:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:09 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 08/38] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Fri, 29 May 2026 14:55:24 -0700
Message-Id: <20260529215554.606133-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX47UaPiWbeuBQ
 NkD15Z41AoImqmrtCs+jdBm6mGtJdbtpC4IvNMpWh0STb7YBB48Q0jPTL0DoHfh3S+Ocy9pNW8U
 ogezp4k/ZeDzm3Q1DPCw2G5sIcUWTT/N3h0jV/UCuUsCL2iPQl2lNtGbDIyhWJEFMVHG551dxDa
 RkYQhX+iyQ5o6/gNSvRBY269rUDqOAXt7a+IP3XWKtY1sQ+RvBc0pecU2DXzHIAaO2PwJHRXj2V
 CGzMUkQjrcLHh0bws3ktX0bwIDGsTe3tX4WoRwyKPIIwgjmUw024eNL3cFSkt90ItjwnITX5rvr
 1aH2OjPWC13AS5Ye18hMZ9feUzVtJcqrCm1hZn1+eVZY2a56ihc8MuhuoABO4V8ujv7Znnh5mzZ
 BOvejfq1wmjT/bwCKFdbUAR8yjBb1K6pRIcTkBBj0+8889K89gjxliFbi6hlY10uACSqe3u7vN+
 39ztSeJQqldeXQ301LQ==
X-Proofpoint-GUID: ejTQbifjJGQdzbuMVfo2isWN8R4tbpK5
X-Proofpoint-ORIG-GUID: ejTQbifjJGQdzbuMVfo2isWN8R4tbpK5
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a0b7c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl9oZWxwZXJfZnVuY3MucHkgICAgICB8IDI2ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIHRh
cmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICB8IDIzICsrKysrKysrKysrLS0t
LS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weSB8ICAyICsr
CiB0YXJnZXQvaGV4YWdvbi9nZW5fb3BfYXR0cmlicy5weSAgICAgICAgfCAgMiArLQogdGFyZ2V0
L2hleGFnb24vZ2VuX29wY29kZXNfZGVmLnB5ICAgICAgIHwgIDUgKysrKy0KIDUgZmlsZXMgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9oZWxw
ZXJfZnVuY3MucHkKaW5kZXggNjIwNjEwNDQyNGMuLjE2MjllYmMwZTFhIDEwMDc1NQotLS0gYS90
YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX2Z1bmNzLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dl
bl9oZWxwZXJfZnVuY3MucHkKQEAgLTEwNCwyOSArMTA0LDIzIEBAIGRlZiBtYWluKCk6CiAgICAg
dGFnaW1tcyA9IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQogCiAgICAgd2l0aCBvcGVuKGFyZ3Mu
b3V0LCAidyIpIGFzIGY6Ci0gICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi50YWdzOgotICAg
ICAgICAgICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJB
X1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgotICAgICAgICAgICAgICAgIGNv
bnRpbnVlCi0gICAgICAgICAgICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAg
ICAgICAgIGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAg
ICAgICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZmxvYXRpbmcgcG9p
bnQgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBpZiAiQV9GUE9QIiBpbiBoZXhfY29tbW9uLmF0
dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMg
U2tpcCB0aGUgZGlhZyBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlh
ZyI6Ci0gICAgICAgICAgICAgICAgY29udGludWUKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZf
ZGlhZzAiOgotICAgICAgICAgICAgICAgIGNvbnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0g
Ilk2X2RpYWcxIjoKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLmdldF91c2VyX3RhZ3Mo
KToKKyAgICAgICAgICAgIGlmIGhleF9jb21tb24udGFnX2lnbm9yZSh0YWcpOgogICAgICAgICAg
ICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICBpZiBoZXhfY29tbW9uLnNraXBfcWVtdV9oZWxw
ZXIodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQogICAgICAgICAgICAgaWYgaGV4X2Nv
bW1vbi5pc19pZGVmX3BhcnNlcl9lbmFibGVkKHRhZyk6CiAgICAgICAgICAgICAgICAgY29udGlu
dWUKKyAgICAgICAgICAgIGdlbl9oZWxwZXJfZnVuY3Rpb24oZiwgdGFnLCB0YWdyZWdzLCB0YWdp
bW1zKQogCisgICAgICAgIGYud3JpdGUoIiNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKVxu
IikKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLmdldF9zeXNfdGFncygpOgorICAgICAg
ICAgICAgaWYgaGV4X2NvbW1vbi5za2lwX3FlbXVfaGVscGVyKHRhZyk6CisgICAgICAgICAgICAg
ICAgY29udGludWUKKyAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfaWRlZl9wYXJzZXJfZW5h
YmxlZCh0YWcpOgorICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgICAgICBnZW5faGVs
cGVyX2Z1bmN0aW9uKGYsIHRhZywgdGFncmVncywgdGFnaW1tcykKKyAgICAgICAgZi53cml0ZSgi
I2VuZGlmXG4iKQogCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX3Byb3Rvcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9o
ZWxwZXJfcHJvdG9zLnB5CmluZGV4IDc3ZjhlMGE2YTMyLi41OWM4YmRkMDVjMCAxMDA3NTUKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX2hlbHBlcl9wcm90b3MucHkKQEAgLTU5LDI3ICs1OSwyOCBAQCBkZWYgbWFpbigpOgog
ICAgIHRhZ2ltbXMgPSBoZXhfY29tbW9uLmdldF90YWdpbW1zKCkKIAogICAgIHdpdGggb3Blbihh
cmdzLm91dCwgInciKSBhcyBmOgotICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoK
LSAgICAgICAgICAgICMjIFNraXAgdGhlIHByaXYgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBp
ZiAiQV9QUklWIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKKyAgICAgICAgZm9yIHRh
ZyBpbiBoZXhfY29tbW9uLmdldF91c2VyX3RhZ3MoKToKKyAgICAgICAgICAgIGlmIGhleF9jb21t
b24udGFnX2lnbm9yZSh0YWcpOgogICAgICAgICAgICAgICAgIGNvbnRpbnVlCi0gICAgICAgICAg
ICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJBX0dVRVNU
IiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAgICBjb250aW51
ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZGlhZyBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAg
IGlmIHRhZyA9PSAiWTZfZGlhZyI6Ci0gICAgICAgICAgICAgICAgY29udGludWUKLSAgICAgICAg
ICAgIGlmIHRhZyA9PSAiWTZfZGlhZzAiOgorCisgICAgICAgICAgICBpZiBoZXhfY29tbW9uLnNr
aXBfcWVtdV9oZWxwZXIodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQotICAgICAgICAg
ICAgaWYgdGFnID09ICJZNl9kaWFnMSI6CisgICAgICAgICAgICBpZiBoZXhfY29tbW9uLmlzX2lk
ZWZfcGFyc2VyX2VuYWJsZWQodGFnKToKICAgICAgICAgICAgICAgICBjb250aW51ZQogCisgICAg
ICAgICAgICBnZW5faGVscGVyX3Byb3RvdHlwZShmLCB0YWcsIHRhZ3JlZ3MsIHRhZ2ltbXMpCisK
KyAgICAgICAgZi53cml0ZSgiI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpXG4iKQorICAg
ICAgICBmb3IgdGFnIGluIGhleF9jb21tb24uZ2V0X3N5c190YWdzKCk6CisgICAgICAgICAgICBp
ZiBoZXhfY29tbW9uLnRhZ19pZ25vcmUodGFnKToKKyAgICAgICAgICAgICAgICBjb250aW51ZQog
ICAgICAgICAgICAgaWYgaGV4X2NvbW1vbi5za2lwX3FlbXVfaGVscGVyKHRhZyk6CiAgICAgICAg
ICAgICAgICAgY29udGludWUKICAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfaWRlZl9wYXJz
ZXJfZW5hYmxlZCh0YWcpOgogICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAKICAgICAgICAgICAg
IGdlbl9oZWxwZXJfcHJvdG90eXBlKGYsIHRhZywgdGFncmVncywgdGFnaW1tcykKKyAgICAgICAg
Zi53cml0ZSgiI2VuZGlmXG4iKQogCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkgYi90YXJnZXQv
aGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkKaW5kZXggMmY2ZTgyNmY3NmQuLjMyYmNl
OWIwMDI4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3Mu
cHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5CkBAIC02MCw2
ICs2MCw4IEBAIGRlZiBtYWluKCk6CiAgICAgICAgIGYud3JpdGUoJyNpbmNsdWRlICJtYWNyb3Mu
aC5pbmMiXG5cbicpCiAKICAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6CisgICAg
ICAgICAgICBpZiBoZXhfY29tbW9uLnRhZ19pZ25vcmUodGFnKToKKyAgICAgICAgICAgICAgICBj
b250aW51ZQogICAgICAgICAgICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKICAgICAg
ICAgICAgIGlmICJBX1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgogICAgICAg
ICAgICAgICAgIGNvbnRpbnVlCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fb3BfYXR0
cmlicy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9vcF9hdHRyaWJzLnB5CmluZGV4IGJiYmIwMmRm
M2EyLi45NGRkMWY4NzZiMiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX29wX2F0dHJp
YnMucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX29wX2F0dHJpYnMucHkKQEAgLTM4LDcgKzM4
LDcgQEAgZGVmIG1haW4oKToKICAgICAjIyAgICAgR2VuZXJhdGUgYWxsIHRoZSBhdHRyaWJ1dGVz
IGFzc29jaWF0ZWQgd2l0aCBlYWNoIGluc3RydWN0aW9uCiAgICAgIyMKICAgICB3aXRoIG9wZW4o
YXJncy5vdXQsICJ3IikgYXMgZjoKLSAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6
CisgICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi5nZXRfYWxsX3RhZ3MoKToKICAgICAgICAg
ICAgIGYud3JpdGUoCiAgICAgICAgICAgICAgICAgZiJPUF9BVFRSSUIoe3RhZ30sQVRUUklCUygi
CiAgICAgICAgICAgICAgICAgZid7IiwiLmpvaW4oc29ydGVkKGhleF9jb21tb24uYXR0cmliZGlj
dFt0YWddKSl9KSlcbicKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2Rl
Zi5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2RlZi5weQppbmRleCA5NGExOWZmNDEy
ZS4uMTdiYTNmOWRiOTUgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcGNvZGVzX2Rl
Zi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fb3Bjb2Rlc19kZWYucHkKQEAgLTM3LDcgKzM3
LDEwIEBAIGRlZiBtYWluKCk6CiAgICAgIyMgICAgIEdlbmVyYXRlIGEgbGlzdCBvZiBhbGwgdGhl
IG9wY29kZXMKICAgICAjIwogICAgIHdpdGggb3BlbihhcmdzLm91dCwgInciKSBhcyBmOgotICAg
ICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoKKyAgICAgICAgZm9yIHRhZyBpbiBoZXhf
Y29tbW9uLmdldF91c2VyX3RhZ3MoKToKKyAgICAgICAgICAgIGYud3JpdGUoZiJPUENPREUoe3Rh
Z30pLFxuIikKKworICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24uZ2V0X3N5c190YWdzKCk6
CiAgICAgICAgICAgICBmLndyaXRlKGYiT1BDT0RFKHt0YWd9KSxcbiIpCiAKIAotLSAKMi4zNC4x
Cgo=

