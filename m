Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB2BCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY03-0000QF-Ho; Thu, 11 Jun 2026 01:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzW-00087l-C5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzT-00016U-UZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GFrf3791624
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=Bv+CMa4drIhLXUxz
 31kUmojxNkG8bSe1d8aU1CikPoltJazjoyGoatZsx0Sq/P9nMwYwUVWBuPwzK9Y3
 3YOVdkc8BYqKiKZ2CgciZXqqgsrMJqcoQcOV17GGxpcqGNcGvydE5ErB7esGLrnt
 k1nB0NXGN/N2O5qzk0V5BJF8SqU7GTz7GJl71pUurtS0nQjn5otH8kElnGeu4Kah
 FGRou1ektIiRvjAV5rCrVK89QZ5lEvrBNken6Rq7W23+8cRdmmWjAsEvBQ59uBlB
 ayG/t6mPustSNOf89ULqrGlKYn2CtIR+uLu8XqI1nWGsctX3T4QcOl03mGZLn39X
 UemGuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701s3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so9074925eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155796; x=1781760596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=H3ZCoAyYTm1qpMrWXAuCTo9proH8TXtEJ1LBEDVXtbjqUy2fAkOcr94iXQzj+TbsgU
 BDSwF3MKS9B/FUIjUml2wia/yvVqy5mmuUyU1edt6ks1KZXSXZXaVSf0WMaSaS6ZCrB3
 TA7rpTW0ejpiXOWLA2Y5P0GHRih2K9jZcjYP4r/E7L6/tCxlxE+La3d/pp5AdXi+fZYl
 2yCNgI5+G9nLYBSU+hvsZlIxh1/aeIPL8Oa0UNXAlEdiyJkAajKzMZ3xWAWeEj1P/xWK
 zCDubK1XZfmlyEZ1EIx7H9AsewR9rOUZSpt/KJecHONPgtMlmx8NTlsyJ8jqcnzLYe7e
 JwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155796; x=1781760596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=E+/YCAA9rD/v6Q5T25ISs85DsmngmQ9wizJmJVtpK4QHVC9xx56lcE1HDz0F+Q2TSU
 vnTPMHbRpT0qnKye+LyIx/YLINTJgiYjsO4EVzaInD5MRpF72im9dLHidXXesSNS99+Q
 1jyI1O7UawufTIT5xXXD6rHTGgCSQRHFzK3xziJieTpvlMZPInHZPjtTH45N1C3iyg8X
 coi0ItzPPGmdCNYbc4nUja4zWQ/CqW1XMYhM2URqc4gvhdOAjR5Sv7gb/cwAfnNWarCm
 kXC1J2+fXgIASTS9sEekn+kfkgau2ZFWEGUsiehEzT3UD0a6rzZ7lsXRc443JyJg5xpt
 slAA==
X-Gm-Message-State: AOJu0Yxl4v7u1h5q7wtxyrx+4gBGfwLy170doAH5MFL8PbQsiaW+jA3P
 IoLDkOFzOWe1FkNyPPgQhpUGaCcOSpr7ogfc3cMQY3Z/8IflUegZX3q7YbooDfbHaFe0Myl4Izx
 NRZXqAMHbAY8dcPOB9EiPPK3/xhI+lYdCJykWtxDTRQg6M/4pfQdT4oUJDVyOPKkLoQ==
X-Gm-Gg: Acq92OHieO1oGXLr6Sb9K0EnTef80H1xYEgzyihInD79d0cTzwAuwYhxVu9zTEHcRKl
 n7ao4tezaY2FokzxC9qjGNYlAOZvdJr/sfYD+Ws76KqYOsZiRya01UI30+SYbjsRS53D86C+G77
 +u/e2djTbIdV7hXw0DQm42Y2m5gM0L+pKpLqeVn0NoGVnbGJGYVJwTLMDcN8s3W3sbnkbPIWgQb
 Tfd8lnVyOsxWJt1KuLMxtMi3ti8AMJGt06x9MV3N80W+2kwEVz6U0yEXnM9OMzX2lmqA6lnxWUO
 QNFC2tyKtDKHZBdjItbBQKwdGWd3Q4lZP5/na+sdoHJhHzoBUeG/tbXrKK39Bs2+QzsEZOrwRhz
 Rz1/e4QqHg0qCmbr0pXIvEMi4c4ov1+YvNqFo8D/bqb06hA/6JcfqZv0zWtE7RDpMsmGU3PPeS3
 UR84KI
X-Received: by 2002:a05:7022:258f:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1384240c743mr776761c88.32.1781155796024; 
 Wed, 10 Jun 2026 22:29:56 -0700 (PDT)
X-Received: by 2002:a05:7022:258f:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1384240c743mr776739c88.32.1781155795578; 
 Wed, 10 Jun 2026 22:29:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Wed, 10 Jun 2026 22:28:56 -0700
Message-Id: <20260611052857.3911981-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfX9Qo7jFdhiAvx
 w178kjcCJV4BoF8Ux6PQ1ETOHBEj2K2/sZBeCxgfvtC4upmf7YMnPBtLVHTSg0HOp0ELmpUPgVQ
 zH0ALDrKEAOMyRIWJStc20wK7aVn/4G8ey9jNPdR72Xmz4wOzG9NFykr6ldilbJ7iVELn/uJSpu
 5Ib5ddNvMm7yaKttr8Uj6HU8DLoc7DJsqDJZkLf4gjhsWc1sTufnvui7hgaAzcqbXhDb8/atPIe
 RGU6tQtrDP+CpWe57fF1/1Ubm3MAx+ycLwVhzesqGtZ9nXxGQ+ywh6GNJJOoII4jWvwu2YA0J0r
 Yr6sIlrz28zKvxsfiIkv/LDaIxbdUa8AsY9kyFnMjYgkObgQAaAdI/C78zz5QbKrPjx515JY33B
 qjAc8anZozXuH+5UOwiS5jIKO7go9/WEe2UGemawTvXn6esw3gyigzzpjvQFJR/sQ1xYovmzgmR
 LeOD549pGZw4DSWjq6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfXxHGAQjf6a0Vn
 HDq9GRfMoDQ4+pnlKtWvMzIfxGYrpP2DAbbqVSqvgqBFoZwsbbAY6rsIWod4LWjxeGsKXHjq/Lj
 nR4aX+TqBjFYxW8ookotLb9WnIn3YUQ=
X-Proofpoint-GUID: yxFYsNkfWYPB4JNxy4Uy2PVUdenN1ZYL
X-Proofpoint-ORIG-GUID: yxFYsNkfWYPB4JNxy4Uy2PVUdenN1ZYL
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a47d4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110050
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

