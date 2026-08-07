Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25893C5AC9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPL-0000id-4B; Fri, 07 Aug 2026 11:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPI-0000ho-Ng
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPG-0006hj-VL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677DdaJ9849807
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=eqTI+WZGU/i
 ByIwhcAwR3vbkBNlUtC6LgCcb1u0uHcI=; b=I3OYlGyx3ssXzuxd4YSce5JyDcF
 gE4w/fHE6TXi4/uPrKketlIDPpK2qhtA/Y1jdFFKlJPnZQofd0Os5/XBSZRp0FpP
 ZG/Q1Hu68uh2U++hqvajlZkiE6jPzqSduUJVMxiHP26Ke5Ptj4kGVh+bq4skyG36
 i9wsjvelCAWkDxyzfSQ+veSoMJpDiHV5NE2uShqWhhDHoL3Xh8ynxRFen+BKnofs
 sHL4sRgiUsFELf8xxvFkrrGIRPzc4R669cy48sVN3f55c7YTj2UoBYLEKPP9b9Wt
 WDIVBglISmOwWqAHN4FoqjlCw/8goW60vn2lRucjuMJSuKtPcDvzbMy6UMg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem8e8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so4445435a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116163; x=1786720963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eqTI+WZGU/iByIwhcAwR3vbkBNlUtC6LgCcb1u0uHcI=;
 b=UWq0mGTxDpI4vSrWpWkVWBTWCLKAqhFGMJoVzZm1zG8DbbOCmQoIDbOx3TzbhjV+RP
 2HMEEN8RKTzfGQF84t2kPcQLbcb68EDpF3OXNMAdfgl90eCvlXaVKc3bGBB8Suxy04JD
 TyivpsMO/J4PSzVx/5STWsjfGXVFgAJiNtWR4MzY7R+4UkdnFLng9y1z/8/KtLBbcjia
 rBxg5BUUnGHQICESTxcPl9sRa9MT4/t7IHNLiC93sw0iegRYYi+WB0vM7rDDswnHw0Ha
 a48W3RcP1cPLH7abWQhqoS49A4/yraBmSUMIJLDWVyYrL2Z7ora9TjUGWzcqgNiXh+33
 FsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116163; x=1786720963;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eqTI+WZGU/iByIwhcAwR3vbkBNlUtC6LgCcb1u0uHcI=;
 b=dA3S0D/49RqUwF9H5wXC5VmVKbhtRKkHjipBvu987C9Awi6GEcfTV/C9PsL7/Iz3gb
 FlngBtCVpgnnQcfU3YrqiYpm6EdjfoScA7AnJ9lSmA3aZliLEuma/Xd3Iv+3IBXVnowl
 UHgAjHwB7Emo2okKwEW0MlK8VI7rDkKLgQZv6ZEBTQ13o1QiPlF4TZGS5yfeq0u2BEos
 3SF7qHecNWQnhMjBASAAmKHP1gcbi6FWDBi+819DqjlAvINNsyXunDS/bREUjajZqYpX
 +rjuCWozFoKmUrHbVMgwSA9hoJWxZnDI21i/9xiLWo38ORiH8keODviE5yMGyEC9y9Xr
 nfWA==
X-Gm-Message-State: AOJu0YwSxUC4JMkYePjzUdYKDKf/DKdhk2NvCINqIk8ZbQGTyNmRfa2K
 8J8RYfjnd5Sldt3L0QFR/gz+HkXl8rGH4mgavL3zMBgPO/okuftJFjexuiFEYh35y17XtKxxrmP
 K5ULw/Wg2zsMsBKzYKqxtxzh54gFqd+OlKD04V4UkpukMRef32qm68XVyueNJPmsqTg==
X-Gm-Gg: AR+sD12vAgvL+rkbX468aWD533j+ANg4tZBjzeBL1GE4ihZyEH/Q28Zrz5KG5WPzX7m
 ACtRJxHTp/X+cNqnnQW6SSwQJo1vIidWSCF533H4Spjrph57qw6W6fqlAwuOj5856DNodUunT+m
 s+bSddkdglGlyHUBc8vbB3jRkrRxwC8goJs9VtYICbbwxoji+rUSCQarLHFDL9sNkGPN3gJiGFN
 il8tnXlvep8cJUO8qW+X4i9SfBRFHFkEOJb8In3qmfxDVUwnXbXA/QkzO8hVQ/KEP9Ha1XaiNqk
 S2Tvt0q8X5b6dKYuXggMieThomkcuq1SfCBLnKGjDJETahlE9MlIsxFJIsod9B6TA7l1n+cxKJm
 mMgqF38V3NVce9tqCRUTAP79L3fzmCAhFocVhv9YJQO0U09zb
X-Received: by 2002:a05:6a20:144d:b0:3bf:77d7:667d with SMTP id
 adf61e73a8af0-3cb85efabdemr30176545637.28.1786116163319; 
 Fri, 07 Aug 2026 08:22:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:144d:b0:3bf:77d7:667d with SMTP id
 adf61e73a8af0-3cb85efabdemr30176472637.28.1786116162794; 
 Fri, 07 Aug 2026 08:22:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 0/7] Fix host-utils sat; Add GVec overrides for HVX ops
Date: Fri,  7 Aug 2026 08:22:34 -0700
Message-Id: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ylwkT8-WLQcFrmqbddmosWmSo3knclwn
X-Proofpoint-GUID: ylwkT8-WLQcFrmqbddmosWmSo3knclwn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX7iYVCKmqVzHS
 uP5rYyD6Wm1P1WYKXCzC1iFQCmr5kYniq66SeiUM3kLsCpbP2tVMIb7QaInOHHNsnryTtBxiyfP
 x8E6fT4/DBQ20OyVCdqag2+FBjKVCBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX+W1l5abzT4Lf
 bjCZBMz/I98LZjW8kMKSuwlpgjc1qv3qc63t0Thxj2xZglqaBoJFa3tr2fts6nyseJKnmr2lKML
 TWk30zgABBDOejBUK8SdV4wkzgd7RwhZnoUIPLpxGiti/5foxg27aHJ5K61csTu1huMsV2hV87b
 ZWMONb7DthZ4bcJo+BGm2eHA/l+9QE9fN/ivT1uj+eowwxw7M+j8HUVoMxccPWmQgYuYcCSjpGP
 9zF3+Yl8riULV214tzaBifJvplA/Coo39HqtOMl7ZFIpXdhlUJOFaTAHeZTPBeGdr0zqJ/z+wHy
 Dts2R+K5yExjk2oBTbc4o0gdGUePV4CqIqxnwgqFOTr3haP4HSc7bSPTwjvOpTawqkuBf68Ycvj
 viLRfsNf4Titis+S9NT6SNZN5T1niUYYiCnJrcNLB417HhOTh6ATgmUMqQiwaXLtj8ffBRCeZvZ
 Nmt5rk1bB7gbRylXGpQ==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a75f844 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=US7OFz8TDSOAQJmZ30UA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
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

SSB3YXMgZ29pbmcgdG8ganVzdCBzZW5kIHRoZSBob3N0LXV0aWxzIGNoYW5nZSBvbiBpdHMgb3du
IGJ1dCBmaWd1cmVkCml0IG1pZ2h0IGJlIHVzZWZ1bCB0byBoYXZlIHRoZSBtb3RpdmF0aW5nIGNv
bW1pdHMgdGhhdCBlbmNvdW50ZXJlZCB0aGUKaXNzdWUsIHNvIEkndmUgaW5jbHVkZWQgdGhvc2Ug
aGVyZSB0b28uCgpJbiB2MzoKCiogQ3JlYXRlZCBjdXN0b20gZXhwYW5kZXJzIGZvciBhYnNkaWZm
CiogTmV3IGNvbW1pdCB3aXRoIHRlc3RzIGZvciBhYnNkaWZmIChvbmx5IGNvbW1pdCB3L28gUi1i
KQoqIFN3aXRjaGVkIGFkZHN1YiB0byB1c2UgYSBzaW5nbGUgMnggdGNnX2dlbl9ndmVjIG9wIGZv
ciB0aGUgcGFpcgoKdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4
MDYwNDMyMjMuMzc4NzA4My0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENh
aW4gKDcpOgogIGhvc3QtdXRpbHM6IGZpeCBzc3ViMzIvNjRfc2F0dXJhdGUgcmV0dXJuIHR5cGUg
YW5kIGNsYW1wIGRpcmVjdGlvbgogIHRhcmdldC9oZXhhZ29uOiBhZGQgR1ZlYyBvdmVycmlkZXMg
Zm9yIEhWWCBzYXR1cmF0aW5nIGFkZC9zdWIKICB0YXJnZXQvaGV4YWdvbjogYWRkIEdWZWMgb3Zl
cnJpZGUgZm9yIEhWWCB2bXB5aWggbXVsdGlwbHkKICB0YXJnZXQvaGV4YWdvbjogYWRkIEdWZWMg
b3ZlcnJpZGVzIGZvciBIVlggYWJzb2x1dGUgZGlmZmVyZW5jZQogIHRhcmdldC9oZXhhZ29uOiBh
ZGQgR1ZlYyBvdmVycmlkZXMgZm9yIEhWWCB2ZWN0b3IgYXZlcmFnZQogIHRlc3RzL3RjZy9oZXhh
Z29uOiBhZGQgSFZYIHRlc3QgZm9yIFY2X3ZzdWJ3c2F0IHNhdHVyYXRpb24KICB0ZXN0cy90Y2cv
aGV4YWdvbjogYWRkIEhWWCB0ZXN0cyBmb3IgdmFic2RpZmYKCiBpbmNsdWRlL3FlbXUvaG9zdC11
dGlscy5oICAgIHwgIDI0ICsrLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgMTcw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5w
dHIuaCAgICAgIHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgfCAgIDUgKysK
IHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgfCAgNzAgKysrKysrKysrKysrKysrCiB0YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDIxICsrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9o
dnhfbWlzYy5jIHwgIDc3ICsrKysrKysrKysrKysrKysKIDcgZmlsZXMgY2hhbmdlZCwgMzU5IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

