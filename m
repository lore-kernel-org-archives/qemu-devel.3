Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED443CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5E1-0005dZ-EA; Fri, 29 May 2026 17:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dy-0005TF-Q9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dx-0000w9-7Y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2I7n589642
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=; b=D4DbVAH53YkRgM6V
 lTiiouNr6ooBmWLijOPWnyL4K43+t6m0fEcc95dvYPeEGwI9SzaaeR/Bsv3sUwHc
 60AAsw30WwLaJSwN5zTkYgyP0LZ1W71OWBVT5+4tUOQjZN7H4aluMwWV5SxnPO9f
 vK2IGzM3bH4CnMscbkLItfCoyk5WBhXcPRZxrOvPdKevcvtZGLRRPYiNwJk/b9FY
 phwQRuI2K3yXXfQ/my2wDCr3E8XlYjMzBk2bHTafZmuxu4AxPBV/ExOePTtl6Vnf
 5eiBqlrdAYN+kjZW8T31BSYR5yXvMp3/z53sevV46KQBDp9Rfm+BHDhE52Lpy9rP
 ymSnqQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rckbx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so6174588eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091915; x=1780696715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=;
 b=h4JWI1/SAW5A9vJgrzCIAgSN8v151xtoupz004xf6vwjpgj25PmoEonKajv5kyPkS6
 NK8Qs6WP3il6RePTkowlEhud1bGzeHuCYmwBT5bIDdUFwGvCZPLFLiAknMPp3NSSVw/W
 XEk2YSbF+LksobiUwJnmH2f1kjEzDkmiR4J92Mg2AlNUDI2FnXHWsKNRi2+3Mp+LuUXa
 iwdygp1KgtX7hFV0RMYRpJVJmsfAJLmJ/WpScL2MJM8t9txWoagirSqdvGFczOpcbdRj
 1Bc+YRuar5Xg6FF1GWmLHngZ4iGe/E8+ej2Qxf6v51qfd2+OjnC/lfynxnJaT2OpBtmR
 /SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091915; x=1780696715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=;
 b=mcWAzDAzZt2PrsRP+nS7aNIFkPu4fV+Vq3hqN4D3eZZbIsEFTpiTtwYMD5+ETESqex
 NEWKj/WiUZlXnb0QCnWOy2wriK2Vub99FKoOEOak4JV1XcqrwgiiAYTEIecNFXoBkX5g
 y36zCId1WiihppJDHiDJoyQjLwKH4eMw5IM+Ph/8OBk5fSOiMuC95ESdpPCK/lbj/glp
 xMbgGwB0bUQ8CMdzy++aacEO7A6hsRfm9JApI4Eob6TmHRkPnzdYVVxmQs2JrsftKr/g
 M1jOpixiJfBgYPmzYUWGNueavjCXbhN0NbohUhnyQAkk2fDbfPOqQu41mhmyfxFG6+Qz
 hT6A==
X-Gm-Message-State: AOJu0YziB9YwSUvjdlBIIOtdbVm7VmOzfw9I4BRS6aWvMk2Oc3gaFG20
 W/oC6Q9Ro0FxT3B17QLGOdTsyMFu8vYhkH1EhqQv2WDWlh7oRTazrEL7FsQXXssXkqYqM9mgVqS
 voXL9W9ntsx+GvYD/U69W3A5mq94sg66bRWIb7vlE+cabSnwsc0V8DOtVS2Ob2L3IoA==
X-Gm-Gg: Acq92OEZSj4qEpUjgyhY50wRUvqFradKw1FYtA7JftBKCl02NtfuqgZd7S1fXB00Eu/
 t21l9Z1GI8057O7m1Ojp27XlfDJ6guajhgp+Uqx339hw4rmijpDq8J4u+k5YpQRhuBhTN+Jy+b2
 mEn3d/nSfv+OLzkYe1XdORVx/2rTkk12EyS34SXMlF5oCVaJRrwt3UYk7m6B/NOvbhgtNzBnDWh
 pOto4bs+izJ1KJjyKpdEK9L7CLrirEYTpca5fZJ4Amlpx54NAC8R02siCvBt017cBMwGDKN3KBU
 bLe7N1qcIP8ksgHG+OV0FapZrLbV7Rwp1aglUSfotDdRemRDMbURJOzFDjvqAFv127+S5D81a2k
 4BTAoUvwiFnSsRTVmajWkQ8qsthNMk+G2WsiXhrCtZHWymM6yTqglMCCA7TQl+W9R5t6RnumpYL
 JAusaq
X-Received: by 2002:a05:7300:5726:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-304fa5232d8mr926278eec.2.1780091915200; 
 Fri, 29 May 2026 14:58:35 -0700 (PDT)
X-Received: by 2002:a05:7300:5726:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-304fa5232d8mr926262eec.2.1780091914664; 
 Fri, 29 May 2026 14:58:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 18/28] target/hexagon: Decode trap1, rte as COF
Date: Fri, 29 May 2026 14:57:56 -0700
Message-Id: <20260529215806.608770-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: kuMfyItvqZhNOTO1t00D6TR-NH9tagZu
X-Proofpoint-ORIG-GUID: kuMfyItvqZhNOTO1t00D6TR-NH9tagZu
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1a0c0b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX3y2lyGCIgntk
 ph9JwGexLEYPQKMq5zaGWY5oE8f6MWKfUFjRVpvkb4VwR4Bh1iL2MGTCyFHRgx9Zz7o8k8AASgx
 k40r/iQzMuVDbbzJ2OktHkYgAOxA2POPFI+Ci2Fp2yIbDHAO8DJ6H0wqX1YCmQfFVvx94Bg04UX
 xmF2LdnFGQTqUtTCCxS2kuOmuIrKQBPv52xmHM3y9B/s7lRMHSDYNBcpCT+dAdiCAc4pW0nG+zA
 fTBUXrGhIZKYhB1/FiTmNQfkYm3FNWXUplbvZVDW3eSpgmssyIKzx8X2uPB9LadC2a9mMC491iU
 fRzCGY57A5VaMpKIWO5dHLIe1vGYGFH3IdpgiYLoNmrc8HnsUNFzb+N346rxT4S/boy9mREjvDP
 jMwmNztLwv3ZW4EP5tMfp8OXSs7xRaeoa7d85IFO2XfaBbsQEgFwbE7/9blT9fuVzCG7ECCcZ49
 aMWqogQXwyZ/ginu70g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgoKUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9k
ZWNvZGUuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmMKaW5kZXggMTU5NTQ1MThiODMuLjZlZGRjY2EyNmVkIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAt
MTg1LDYgKzE4NSw4IEBAIHN0YXRpYyBib29sIGRlY29kZV9vcGNvZGVfY2FuX2p1bXAoaW50IG9w
Y29kZSkKICAgICBpZiAoKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0pVTVApKSB8fAogICAgICAgICAo
R0VUX0FUVFJJQihvcGNvZGUsIEFfQ0FMTCkpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfdHJh
cDApIHx8CisgICAgICAgIChvcGNvZGUgPT0gSjJfdHJhcDEpIHx8CisgICAgICAgIChvcGNvZGUg
PT0gSjJfcnRlKSB8fAogICAgICAgICAob3Bjb2RlID09IEoyX3BhdXNlKSkgewogICAgICAgICAv
KiBFeGNlcHRpb24gdG8gQV9KVU1QIGF0dHJpYnV0ZSAqLwogICAgICAgICBpZiAob3Bjb2RlID09
IEo0X2hpbnRqdW1wcikgewpAQCAtMzYzLDYgKzM2NSwxOCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
c2h1ZmZsZV9mb3JfZXhlY3V0aW9uKFBhY2tldCAqcGFja2V0KQogICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgIH0KICAgICB9CisgICAgLyoKKyAgICAgKiBBbmQgYXQgdGhlIHZlcnkgdmVyeSB2
ZXJ5IGVuZCwgbW92ZSBhbnkgUlRFJ3MsIHNpbmNlIHRoZXkgdXBkYXRlCisgICAgICogdXNlci9z
dXBlcnZpc29yIG1vZGUuCisgICAgICovCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkK
KyAgICBmb3IgKGkgPSAwOyBpIDwgbGFzdF9pbnNuOyBpKyspIHsKKyAgICAgICAgaWYgKHBhY2tl
dC0+aW5zbltpXS5vcGNvZGUgPT0gSjJfcnRlKSB7CisgICAgICAgICAgICBkZWNvZGVfc2VuZF9p
bnNuX3RvKHBhY2tldCwgaSwgbGFzdF9pbnNuKTsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICB9CisgICAgfQorI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkCi0tIAoyLjM0LjEKCg==

