Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D24CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXJf-0004PV-4d; Fri, 22 May 2026 17:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJe-0004PE-EP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJc-00032Q-9K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfQS23601005
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n7WwTwYNPg3raDQE8SNVbxzVKdXQllFfZeGCWnkWOG4=; b=Z5Rpv52hGqxBckCQ
 4KEl+GNySD0RY8qeXp3oyjp+m8/eqCDaGsKjFPx546PTIsLdoY1bvI6AKowj0FVo
 FcwI2j42CqU60ez2OEHk/xvmikszMAWPb7o/5rWEPZ7F2fcZFgPipoe9S5j6WhfS
 g7yWZITVXVS97qyh4iHiwoQQ/hLkf5xWgT3s4Qhsv77RbWIAvmSE8F3tVEGG9oNL
 MdY/UftFaTETrlkK1IVrCBUbvzFwrNRboPjsvorqfVQluKLuDaBsXZA+PmwKhKLo
 v7L2peVWxw+f99zj5yaRSaQ1JJuUXIcW4a55MG8516zLvlSJ9W1819QK5BghsPqx
 KVDFKg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury0ngp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304448ab58cso5356785eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779484913; x=1780089713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7WwTwYNPg3raDQE8SNVbxzVKdXQllFfZeGCWnkWOG4=;
 b=hLsn69EG0DDBJYiFWP7DwMmMiReRhDm8Uj1LMmAw77kl514kXTow2AYyRt19aGXpfZ
 lCVSxQRMHMf3QAJ7s1J1+XwIC2j/9qQJq08WGZCmaACRA53UbEJRZZEW5r7XwivUfLnt
 Cw15BAwdm3Em/wzAl5ellMHTjxuiyGKeoDuPrIYhtVfarljtexE3PlpX0cLx9KMGuaK1
 oI/9AS7T2k8wISpUsJo3VwPut9b0IFX/dnTJVHQ0Z21ZkA3oN/0Iv5ERIXgf+PBUGHBO
 bmm75lqjOzjrL6dSPfex6rg6t32ydxGDpVId8hVRuhL+0bznAlRz9iHTK7mM8d4GC6/l
 jqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779484913; x=1780089713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n7WwTwYNPg3raDQE8SNVbxzVKdXQllFfZeGCWnkWOG4=;
 b=gKTk2fmx3ORSquPfl77QF7aEQ98jdEHkcVDMXQ5uTQtLpKgoxTRuyN76yTKNJrTYj1
 XdGE/IqTQmLSSYq4jgYWeFkZSQvSwr7tMVFc0vIW0hA8b6famAbTzLjbzs7fEHLSWz6y
 V70MQotPYresPiA1RSCC1r6beMq3b47u6Gk9wKskF0sBj3lg+P7kViTp7zpHeRB+dW8O
 ByYVX5hDNZxCS6UJC6YQJatBAfDb5qt4TbU037Jq5w6WKQJqs39SdRDVm3mnAGFjjxvb
 f91iZbNyzL3aAweDG8L38VAcdJ+quBsXzRWC8/oAO+r2zSD1pYOJHNCKVp0sJti8TUaR
 RKcg==
X-Gm-Message-State: AOJu0YxZYrisMdEeZDbnONmnRgRiKqeAvEbo8d6OnibTqSPh1mTr7qzU
 uEag7Ft93iBjnBTwWdA2DpwstMdEaCbmAYrBkjVL7LO9K+otJ+TNfe1N7yVoeVRrX+r9rWxVNuw
 NpZOfDl7X+0jaZOhDPr0cDGySlpUyGOxM7NYcIbPEfj52z88jgdr3ve92BY7aq0M4/g==
X-Gm-Gg: Acq92OHRwQ+GTYqk+OHjrV9yOSPOBqkTzGoomGF2nEGYgJylE+LhIJpOOhz3vq3Ea6m
 w40QWUFwW2hGWklFD+xg2/k3SwI3vKyAY289UpKcg340UGXbijvtoVsFDuQWmaULI4X1MQ3FN4a
 4vHIrKimQM6I99NE4rsSWGmkva/ZLnov1ZrR/n0JGvuMENX6L6pGOlPN+WsnlZj0DalXvKga6Uu
 rRCI4Vo0qyXU75jyO/Tw4s3+ZEl14joBXcqpC0qHn7UFleTc2D6Wx76AOtilnXEx78GPIG1fFaG
 8Na6GBTxpCC84PnEQH9SbdcbSzWJDe3ewtUvD5xfeaRkioG1NOWserLh0RyXw/PXHkI1JeR7AhJ
 5SMyEUggOsYmL/YNlBmxu3eMkUuGsshUKpsp3XepOxNnPY6c48XR9UW63iBCVBfPjmHMsnQ==
X-Received: by 2002:a05:7301:7c0e:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-3044905fcc3mr3155267eec.9.1779484912795; 
 Fri, 22 May 2026 14:21:52 -0700 (PDT)
X-Received: by 2002:a05:7301:7c0e:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-3044905fcc3mr3155245eec.9.1779484912220; 
 Fri, 22 May 2026 14:21:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm3005755eec.25.2026.05.22.14.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 14:21:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org,
 berrange@redhat.com
Subject: [PATCH v4 1/2] tests/tcg/hexagon: fix check_rev_gating with newer
 toolchain
Date: Fri, 22 May 2026 14:21:46 -0700
Message-Id: <20260522212147.3089295-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
References: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMiBTYWx0ZWRfXwxKc/pKFM/Xt
 Wsc4U5wUVsBFKps3gqG+SOWIsFy9Oz91aGCdtvns+z8Kijm2Ys3560VdCQFzSf795kclYOK2IBp
 7WxQz8xrYxSeBvzedT8fTZuVAJfwAHTlEJh6h/dLk1fcFAHpsivj8GdcLs8OL8jC8m6E4tIx83a
 /nNyChcRXpXhGhCC0LT3NaXNnDrBtKFWvrO6JlskTzBPlqbYplCBs14Kkrlb6xSgg+HILxRrngx
 rqExCS+Emlj2ChVUmPu307QuBZSAH+MdZrrGgJ84ieRAjCvx/e8wsCbcLNPITm87DNuvGN3SmYA
 S8MxTmu5XlM+3r1nNn6iKk56EkiiRjaV0lMo5mJV3kYIIK52G4cK1i1ZcWaYaWZgQXWtYxiq034
 Lcx4/WkWpFAAkKzyBEqiRMte94IZbzFhxJCHfxA38Ghh1MRFb61uenX8DIfX9gsAKSqH+T3WZgm
 Cnx7Lgqpij+RfCWxO8g==
X-Proofpoint-ORIG-GUID: p2pRtTlTeZfh6QacdmfaWSaia6AywURX
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a10c8f1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n1c-No9V6JhszW1LBLEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: p2pRtTlTeZfh6QacdmfaWSaia6AywURX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220212
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

VGhlIGNoZWNrX3Jldl9nYXRpbmcgdGVzdCBpcyBjb21waWxlZCB3aXRoIC1tdjY2LCBidXQgdGhl
IGZpbmFsIGxpbmthZ2UKc3RlcCBkb2VzIG5vdCBzcGVjaWZ5IHRoZSBDUFUgdmVyc2lvbi4gVGhl
IHYyMi4xLjAgdG9vbGNoYWluIGNvbnRhaW5zIGEKY3J0MS5vIGNvbXBpbGVkIGZvciB2NjgsIHNv
IHRoZSBsaW5rZXIgcmVzb2x2ZXMgdGhlIHY2NiArIHY2OCBsaW5rYWdlIGJ5CnNlbGVjdGluZyB0
aGUgaGlnaGVzdCB2ZXJzaW9uLiBUaGUgcmVzdWx0aW5nIGJpbmFyeSB0aGVuIGV4ZWN1dGVzIHY2
OAppbnN0cnVjdGlvbnMgd2l0aG91dCBnYXRpbmcsIGxlYWRpbmcgdG8gYSBzZWdmYXVsdC4KCkZp
eCB0aGlzIGJ5IHBhc3NpbmcgLWNwdSB2NjYgdG8gUUVNVSB3aGVuIHJ1bm5pbmcgdGhlIHRlc3Qs
IHNvIHRoYXQgdGhlCmVtdWxhdGVkIENQVSBtYXRjaGVzIHRoZSBpbnRlbmRlZCB2NjYgdGFyZ2V0
IGFuZCB0aGUgcmV2aXNpb24gZ2F0aW5nCm1lY2hhbmlzbSB3b3JrcyBhcyBleHBlY3RlZC4KClN1
Z2dlc3RlZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlu
b0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90ZXN0
cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmls
ZS50YXJnZXQKaW5kZXggMDlmMDUwMmFiYzUuLjcwYThlYzJlN2ZiIDEwMDY0NAotLS0gYS90ZXN0
cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vTWFr
ZWZpbGUudGFyZ2V0CkBAIC0xMTIsNiArMTEyLDcgQEAgdW5hbGlnbmVkX3BjOiB1bmFsaWduZWRf
cGMuYwogCiAjIENvbXBpbGUgZm9yIHY2NiBzbyB0aGF0IHRoZSBFTEYgc2VsZWN0cyBhIHY2NiBD
UFU7IHRoZSB0ZXN0IHRoZW4KICMgZXhlcmNpc2VzIHJldmlzaW9uIGdhdGluZyBieSBleGVjdXRp
bmcgYSB2NjggLndvcmQgaW5zdHJ1Y3Rpb24uCitydW4tY2hlY2tfcmV2X2dhdGluZzogUUVNVV9P
UFRTICs9IC1jcHUgdjY2CiBjaGVja19yZXZfZ2F0aW5nOiBjaGVja19yZXZfZ2F0aW5nLmMKIAkk
KENDKSAkKENGTEFHUykgLW12NjYgLU8yICQ8IC1vICRAICQoTERGTEFHUykKIAotLSAKMi4zNC4x
Cgo=

