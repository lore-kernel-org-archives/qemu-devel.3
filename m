Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DCDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz3-0007kB-BH; Thu, 11 Jun 2026 01:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyh-0007f2-7H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyf-0000nW-Cd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLtR2248044
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=; b=GDrqcrpT8/agkkdF
 5aCnCgo9lMocIwDTy3MSGI2LblNUOg+gSInVsMfJTyOJfIuT/ThYrM3izQ9FYRr4
 S4XYfULfz0HgMo8IdJmM9R3nO/MA17oyVtxNQ3gRsvu4a0feSbSd3qgHh1EyxtPX
 VaZc4p73F1EBUiPjHOnd8XLhk8QfGDRDRc8hmJ4MwSdIyeFfxsjWqBukBK3LgKdK
 v+aS31VVZkK7zPvfEmDzKE5OCTXHGqGexFg2CdXWjWsYcK19SezmDlfAdvL7epDj
 o/M1Uet1osqzuK2iZpqDinyJmBBDQWRQWw0lirZsY0tvk5ISU2x8WrkaQOOtFcXy
 pBFm5A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hr48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3074797dfa9so1746567eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155755; x=1781760555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=GOdjOWYddlobkEK40mnMA13vUwnfv8ctRE1PyavHNLqRys1z46oFPvar1M5fE/5bnJ
 vCA6I3ayzF+bw6y+h3RA2p4TCyzRUv/IaVm5LFn+LGdZcjtqeGdxAGszER8b2W+Y0Qez
 d8cWHw2FMJlTEcmyXI/Gsgm5i39CvWh8LukCaeqXJurKPIhSUTDZNOtpXr8m/sLgxHNL
 9QAH3mKaxYno+pp0FukYqha/Q/EIjcwyNedpYQZt2HmCW3/msQMzNj2g+pfXUL91Js/v
 XMW3295IptxttSTwgVuquX35hG0653GuRZrAq5qtnMbz5E32KdaC5GE4d/AZF+JK4Qik
 PbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155755; x=1781760555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b8voobbRHB+fEzV3OFcGYw0x0PvxvjT9mR8Wf/yF+Q=;
 b=IXzSv439DBVG6I/rf/Qs6Ln94zXwj3Pgx9o/XW9b3QW/MInZ+jUSYmnjWGUDRgIsA0
 9xme22wtuekUbDG5TPC/VyN6+/vCL/mslf6ZqMxQzsbohOPL+dm0hZLMDlOxqn8KScbA
 Zl0x6WpBZe+F/gKuChM3xar6LWw0j9aVhOKpXRR34+UXrpWTTxIj8S0eQBvpqlGDH/kI
 FTSwEiLWvJ0ZYN6zlLuSzXw8MbnP8Xi4z7M/2sUfTOv6Fu4GYAhL5Dk+4oOMZya3QlHS
 jpLxxCtHAp6iJ5pq1mJMemcNz2LOLCek6yCkDULOajZ8+PXiTGJwOPm+fFaGocUgqaJN
 tnWA==
X-Gm-Message-State: AOJu0YyXHH29s9mnC+yu5EDZ4V33x2AaCJmyB/tzVmI7YqmgOLKwl0v2
 jcLJMlmpT/xzBDiVSfLjorQErZRwM2yxkoDTigc2vEZxNzAx8NjODnlyOXMHAJfx8oqfPc2yScT
 WV7dc+t19l0+GqWHtNh9gFjzmXyUm4GsZDfBfi5YGt/kUhh6BLRII0uY4O7BOy51mwA==
X-Gm-Gg: Acq92OH0DXY9wQZ+2CkIPaEMp0Sf0x9XJM0OG/Dk8W9A8QyjafC0siS/1r3GEdGofqU
 ksTIeRkOJpaUBxbOMoQYnUgZ5iRttBcZvhGPcK9J8EChabuTldwcs9VvXyH/8g7bEN2Q7H/9IiD
 7XOsJK9+eGKVdnqFua2SNsbWVyudVTqjBdqTH61yo4dpR7KL++zjeShbq+X4YXh667zlQZCozNd
 Bktc9gUsjhDJNkdy+RylsM4SCL/W6hfToMCvmtgAbGoUnpybBEuwVNpTBBOtcLu2XVyMWv5SzPS
 yaTBRY2JINuuAsHDQwDJrDCUC5W18joqn2bnHCHsxV2UWCdyFWUMaIv26x/DoT3DIYZ9vPS6FlC
 fX2/oyaMvOzecs/k26EsAdOgfctV/2Baw+ZqiFW/eMmqrP3ohcUPVPqYteH6J3HpOCfKP3p9Dim
 0NGKEp
X-Received: by 2002:a05:7301:1694:b0:304:9b48:53da with SMTP id
 5a478bee46e88-30804a23e4bmr1092338eec.26.1781155755130; 
 Wed, 10 Jun 2026 22:29:15 -0700 (PDT)
X-Received: by 2002:a05:7301:1694:b0:304:9b48:53da with SMTP id
 5a478bee46e88-30804a23e4bmr1092315eec.26.1781155754614; 
 Wed, 10 Jun 2026 22:29:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:13 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 Brian Cain <bcain@quicinc.com>, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v8] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Wed, 10 Jun 2026 22:28:28 -0700
Message-Id: <20260611052857.3911981-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: h0WLd4d7w8B3h0-Rxal5n1c65dCkpbfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXxTdBI42D3CpR
 Duvk+EwYO/H+hNJ7vITaPUyim5rj7znyZ73frf6s+oimiMnUCDU2PnuwEyv/i2MIbrvsUKRwva5
 jvpzftVyuUk1kY/fD8pHKcm31BWnqPOs8IQ1n/qUXlBRTeZfYjMasxqndY7FgmsWNrsIWuT/Iv5
 hxJQkaOGhFgRow5vR1zlrAUT2kOs8J74PcQ1IqdZqkwRXMladPBFTv6WiaLnbYnpm+tc6vcJ/1B
 gZfDQ8g76JZCLUVi7BuzhJoP2zZ+TtS4dkCx3NlW2PQKNE/3KUJ0IjXVNYu+pk2FNuZErKOf/3q
 L1EDqpvuEZ9mrQiMguYo/rpdyiz+Rx5QEp9jp7/sGCZpt5EEi82+9h0ghPdiy8tnW/8+dkkLV1a
 uvIA53lBeoZzc3Al+2C9qhKLOIy9W7p6e+1hJRq+yfxjBzRR5dJpkQifHJ85jqGYL6Dqi2wt6JG
 iVPHJH9y7px9Iib5siw==
X-Proofpoint-GUID: h0WLd4d7w8B3h0-Rxal5n1c65dCkpbfv
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a47ab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX5TPqxF7Zyf2p
 9dW3HKtVyOMs4faEm8Wa320aB+90ZoLh1J/2MAyfsdwEadnRigLnhXUSZ3BSkEix243nELIQTWW
 KsO2jBuIhGtZJinfSG8nL99dTQ9hlcw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

