Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D49CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT75W-0007RG-Gq; Fri, 29 May 2026 19:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75U-0007QA-5I
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:58:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75S-00054t-OB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:57:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2HrR198956
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gMsJ0gzS+JRImAjBCEAjfDSM8Bn8q1rioDGzqCKaZYs=; b=hX3h5Ki8ooLb6U4i
 6kosEJKjwuf0rOBFyvRPrcxTkiyIYH15smAJpzidXzj1zcDJJXSK2IoMN8Qzz71b
 TXZw/0MvYSZwxJo3+9fZX4yq/NzrOS+8IORzYUh/x8ZDzSeCsIGrpCGHz5+PEVOG
 zQLF01sBKUQX0ygslueXuX4CVyeZSTaKC4wxzBOlN4W6prG6GXfZYtB+9jI8tL/Q
 IP8DNJUlBlCSyZU53nu3NZSrrUntLyoDmEuKqoDc1kSdH+1T/KhUTffgxE9GXUY4
 8SkFH5bccAIdeIpp4FDfOh15mfcbt/RBuL2Vy6qzrJ97RsrAcUIOcun8iaO9xJdt
 eriaSA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnj9pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:57 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137731eae44so9030808c88.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780099076; x=1780703876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMsJ0gzS+JRImAjBCEAjfDSM8Bn8q1rioDGzqCKaZYs=;
 b=aYlXWVUtmGDCezny+WXo7IcX0+lBZD8BL3ZBRdzNi/6fzXCzdCUoeM2O7Dv5kHRNfz
 jTZBIdJaHfyWLk6fZMfl0laJdJzL0rY+MseDs21bkGyjVM802lv9uhurdxK3eAzemVf9
 qSQEWg+9s/+xMZtNEGkmGBBeqj3pWdjfYHBafnxLGTUl3VtH7AE7XJ/FnONhaUkyYnXR
 SOvgxwPU1aheklL31p2/ZySPc7AxLmH8d968UPHcuIdT6/jeZ/as6ZUfgmko2qkKAQd5
 As7N9QVnia3bKtyJOiwVml7Zhb+HzKvJSOJ7taOEd6R0jyczJwrqIro5fNVHmuPTtCPi
 75mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780099076; x=1780703876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMsJ0gzS+JRImAjBCEAjfDSM8Bn8q1rioDGzqCKaZYs=;
 b=cM3CcgIUMrc7UGtrq4CuiNZcrIjdbdeja3GafFVrAWxHPuyq6twulKWwZsBO+vFm1M
 lkwdXxY/lsRgs9/5GM1Pkg18Aqrd3fWFIDvEDkTbx78BK7bbCfY2QVFxKWFl/I2zDllt
 9fx/FBmQtQeOzA4JCge4ZimXHi2iz8weDZBrF4SC1c2iW4GQOmDazfeY7tZoDAubqTQX
 1F+CaQZ9hsCsrt5f+cWgx7rK1eJy5lyta/wmL7qcxrOrs1+yONGvOKkUDSOhRuqOdr3J
 SwqzT2pBhhkhedx/HhduHsrgkyoavDL/G6mLEsllWLLoQebzjjNrIgoPEGVgKrDxu6qb
 arkg==
X-Gm-Message-State: AOJu0Yz+8vmbWlMxFwRvTFEai+n9mmPAwa8YEJceazXpe6IQbSCRnz6h
 JhY7FMfKi2/Az+Dlxp1mPRIuGep9qyYROWjl5OHAqOq6UsnZen3voh/4PRD7Rft7wBuoXnaqk36
 VA1C7b20H5XXyzsci3ZdxriEpPSDzF9Kcm+dZQnNG2ZiM9t/l+o/JCE9CET0Teld0Dg==
X-Gm-Gg: Acq92OHrVxXmQ0ePrmbnm+bOqNwl9vA4A/BxmUtkHdX42E9EEqUmyLvzQ9AIKLb6UJM
 NnErk5aZFDXzHvVkX72N9F7tVew9LcDzoCRUdrdPG2Xiy3zk+4WhXYJDGltOnft7Q6oKCarAwmN
 JO4Fmw5PhrYeWv1jcrAl9XC1I26lp+mg0wc8nMFoZ1rMVW4oBMemR6dsb1015GM5MdvuQgHDp4i
 w0I5Yg5doQCFm0eSPIghNLgy7eH+/mwPT6m5sh0Xdpm7VLQpBHjiH7QtaCMizC4jQDWKbKsViQR
 2DT62JrFvVshEoeDF93bUuYZItc7z3Yq3TCfjDUEVEBtOWCSNuEnf2Fh1IQ09+qgRzSE6jmKdUZ
 gc4/NJoW6O31jfDgVHWp0c34OotPsAqoZS/nx0qE6utGb1aZ4CiVDRh1zp+BLVHHPUEJM7kirNz
 BkLJhY
X-Received: by 2002:a05:7022:503:b0:136:85e2:9c8d with SMTP id
 a92af1059eb24-137d4025ecdmr786306c88.1.1780099076099; 
 Fri, 29 May 2026 16:57:56 -0700 (PDT)
X-Received: by 2002:a05:7022:503:b0:136:85e2:9c8d with SMTP id
 a92af1059eb24-137d4025ecdmr786298c88.1.1780099075557; 
 Fri, 29 May 2026 16:57:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36aef95sm2143282c88.4.2026.05.29.16.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 16:57:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/2] tests/tcg/hexagon: fix check_rev_gating with newer
 toolchain
Date: Fri, 29 May 2026 16:57:48 -0700
Message-Id: <20260529235749.879787-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
References: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIzOSBTYWx0ZWRfXwRwS/JGAEAXE
 SqMnWUf7DpDZkD4thzWf3+6K28JLZbwLdgl4jMvgICZABjCao3ic76snffvKOuXjrpZtlIDKlnh
 EsAPRZpOCOD0yxviLXlJfaSrQ98byd0bVl8pMMzPkx+518eqZqjOpgWMUjtYxkhRnViwQGXIsbL
 I9/tSL6ZYMpUwdS4Qwd+YUO+NikHJqnmZ20aD0M9+Zr9dICaunXFOhxZQbiBcu3XG5WwAnk4GVC
 BfLLgk6Ht8GHOcHL7s1FOV9bcmAl+jU1gZ33AgDtQDEXlqCgB9bMI5fR3sFb4/g/taH3roTyYyN
 y+4BTcm2Tqm3DsrLzIHqEc1UkLxMxYwwM+RGit7a8txdVXIx5wGCa2FzRKTh9NreCUcWUdkW78l
 AqJ7S0RzwHrn1jduuQk2fTipV5F8hRR3HZ8zlZXXsytHathZ99j2pgPcX1isu1YL5j6NYVlFevK
 7eH3C1dih2Ea9I6r0tQ==
X-Proofpoint-GUID: B0hy5i0oa9duskX1CE6sWnCp6IMEpt3x
X-Proofpoint-ORIG-GUID: B0hy5i0oa9duskX1CE6sWnCp6IMEpt3x
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a2805 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=n1c-No9V6JhszW1LBLEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290239
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
b0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZp
bGUudGFyZ2V0IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgYi90ZXN0cy90Y2cvaGV4YWdv
bi9NYWtlZmlsZS50YXJnZXQKaW5kZXggMDlmMDUwMmFiYzUuLjcwYThlYzJlN2ZiIDEwMDY0NAot
LS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVzdHMvdGNnL2hl
eGFnb24vTWFrZWZpbGUudGFyZ2V0CkBAIC0xMTIsNiArMTEyLDcgQEAgdW5hbGlnbmVkX3BjOiB1
bmFsaWduZWRfcGMuYwogCiAjIENvbXBpbGUgZm9yIHY2NiBzbyB0aGF0IHRoZSBFTEYgc2VsZWN0
cyBhIHY2NiBDUFU7IHRoZSB0ZXN0IHRoZW4KICMgZXhlcmNpc2VzIHJldmlzaW9uIGdhdGluZyBi
eSBleGVjdXRpbmcgYSB2NjggLndvcmQgaW5zdHJ1Y3Rpb24uCitydW4tY2hlY2tfcmV2X2dhdGlu
ZzogUUVNVV9PUFRTICs9IC1jcHUgdjY2CiBjaGVja19yZXZfZ2F0aW5nOiBjaGVja19yZXZfZ2F0
aW5nLmMKIAkkKENDKSAkKENGTEFHUykgLW12NjYgLU8yICQ8IC1vICRAICQoTERGTEFHUykKIAot
LSAKMi4zNC4xCgo=

