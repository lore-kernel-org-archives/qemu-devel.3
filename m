Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F06EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3A0-0002Yo-DN; Sun, 28 Jun 2026 23:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39v-00025s-KH
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39t-0006MS-CL
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cmBu1514032
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=a3IOOFbdX8QHqyGt
 vgLST8+N2+9NLAfm87uU2g3lFrfaHf+kKJLqom61QLT2OYQSJlii5eUUt9kQZGM/
 ChBRWbU6/IoBWgDoNLtG2CAMe0paVCzmTyfSnI4xxPZ8mVIyxUtTAwFEBCWD2SqD
 scs1iKlpKrD7pOblx+8eA+MKtE8nXkQHm0CuCsChdI0JRCbkMeG2FvZ5r9+XbiEP
 lV+YUEcJaRfI4faH7+OFVMtb5iVItGkOImtpvSBJHuDfXOqkjxvm4hbsEn4WTh/C
 661RCB3GbRz5UV0LHjH+lEZv7sAc23Y0Y3acar0l2lYMaudd8BzgI8m9P2JbK3mP
 fyZk0Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cm8x8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139fe708181so1159091c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705573; x=1783310373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=H/BMfyyfMsTeQjeQMuorTl2KLAViMCm+rXetswsOMypHwhfL/yXgnp6ByJpqXD4JpU
 yUsRf0l/GRbvxBDChNIDf2YjyffwvZnTrfsm//48Dlm8nVc1V2YlGTQiFPfZuCB6hvJX
 kjF7OGyrFN6Bl0gB36cY84xpPK3AvPG4E0dm3T8I5mQeZzxdEZzflUdWN0bYBEIB4fDm
 fi2F5sn17wMIbZrTgRkGUgqac64K8zOEiKVitFJBvbp1PlyNxx9VhlpBsd1NofoQ6Wx7
 UvLAwDVqtz6tc0Gkf/Msbj2zGfXmBnwA5MWt9awRHUn6CO76aj5Gb4BcP/YZfPzBFGNb
 062Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705573; x=1783310373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=j/OJssO1leBHvJIMXEOZzeJNq/vFxkQ0n+ussm3FMkr/Y9O/Gu9dP0MVkJ1xvcunaR
 kLMhqOl3CUFTaLIXqucqKRj2Ls0TkQjrPWtveGTvYrH/9/g9d//3k21vvzrufWCCCkoP
 bZbK7pSa+jZhypcdI8gymMbCfKmBtQJAHubYnZ0EvtgJ3rCG5UGOeOiFnTsM6py5Y0Qu
 Fw17MP1PJWU9f+zVbf32YSq653l3V2Vh8BYimqmviRQ6Hmk4r9LEn2/MuaxZ6wWKU8MG
 DIJvkq7YnCjczAnBvM4XqM5CTVH0l4TvBkjAJGPYS9VtCZ0w62MaLXaPW3YkxCxLRhGt
 xgWg==
X-Gm-Message-State: AOJu0YwrX5N3lfMqc/hhe5fe7P73VxVJb6wU3bKN/RqOK31e0fCFGvY8
 ixDnsqMuwj2KAlUE+Dpbnbhwd15tfRlj+zd5ASKeaw7aKebfF3npFY5K8wP+YNP2M38UeKjJrpp
 g0VWFq1dOsuuDvOs3Noh9nR+gW+rWqY1KLPOJHC+Or4lCUqR067HfAfV9i5FN1quM8Q==
X-Gm-Gg: AfdE7cn4lts1gECN8dG1kntIVoUw02kHz8Ui7AZamtHMq7h9WEGpErtniBS3H67+W/o
 SX3Tl5MR1PJEeeHmw/jZR4c3Zut3ZPuylmvCsXmmqBOrWyAYrygnr9uKSIhFt3eXryDtMGnWET2
 63PMcNr5OuwuRon3JmYVL5oSey6hn58csGtRbncW+vaKDmM6SkSFG9QnGi3T1DnkTNdnzjApU0B
 a5A+39d9gPGJkO3m2JJwjIjTaK6K8hxbrqhSuYSnXMY2q7osIGnXzkVXScI2y+CqFmxop/ciDrv
 yXjHv021l2WuVHURbhPwBs/hgjEI/1mm/h0L5YUUapSV7b/I9f6g2FFghkMvS5bdOl0RwbF7j6w
 Q8gRmixjn5FkHrVe7BBRxODTJFx0IULz4Kgx05fqtSnvCavbD+brllGDPh/0=
X-Received: by 2002:a05:7022:b86:b0:135:578a:cde2 with SMTP id
 a92af1059eb24-139dbac7ddbmr12472105c88.34.1782705573277; 
 Sun, 28 Jun 2026 20:59:33 -0700 (PDT)
X-Received: by 2002:a05:7022:b86:b0:135:578a:cde2 with SMTP id
 a92af1059eb24-139dbac7ddbmr12472086c88.34.1782705572720; 
 Sun, 28 Jun 2026 20:59:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 35/77] target/hexagon: Add pcycle setting functionality
Date: Sun, 28 Jun 2026 20:57:48 -0700
Message-Id: <20260629035830.1520296-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a41eda5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX3eU4heX0RSzQ
 WiW/p35sliTuXoIO1aewqnDuUXqaGLnopYdsxCPhMWQWF1llsipCBZgRvnDAyg9bldVQesvh3aq
 cS8QjUuz2Acs8s3ReCcFUB3NJkLaM6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxvIKw6xzxU8K
 3giIJrO4/AsGaIvuRAn/chmOyEgAse4KYr6ml4+9goBg1sSMZnybSgn4FgsWl/YwPaYMr3Jqxuw
 +33pfW9KyVui7W+uwY+CqYGEFsQRkvh+hzMTRvrthmJUzhagAtVbfIR6TZLlaIMAO/S83aKaeFs
 u1OpqEeO6fdMeBmTxxJ4hpnpYwv8EiDCAJqKfkeEgJJ6KG/KoHsyULbbzaRMxhGt83v4/bUO46P
 tskxglpEH4lNcUWfdl8i5P5hyhI0jMLXy4RSwqAxPmc9jvxUEFA1xXDihmU1YL9QHVEgw8x/A2v
 roE+nmWwsdSKU7CDRbiWWQEy2i0x8S4oeMotUpdx+y6NZezxkDSiz3FfjZGwP9ff0Gln7URx3UN
 eQorhhA90WR7SWISKafnoTTmdrhpgYdNNmvWq4vVgE4Ko921UyTKxaP+O5qlmeZTatPIMd80xPx
 ID4+h6z3LcOQKlOxKUg==
X-Proofpoint-GUID: Ds3G_7ldjMPu4yeckPasnFobbpoOzb0g
X-Proofpoint-ORIG-GUID: Ds3G_7ldjMPu4yeckPasnFobbpoOzb0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

