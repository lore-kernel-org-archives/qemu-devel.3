Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B80C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqK-0002rp-54; Sat, 05 Sep 2026 14:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq9-0002mE-17
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq6-0001P8-Bq
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbmOk3520150
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zoMJ8ubNugqDYoJRWFaRKxHdSYdWnZjnKAd139odpbM=; b=JZs/VMZTImYzKcPh
 GymjAc5y/PDZSXQJer1eHSuqL7TXYr/trkny9A8G4I6qmU6to5QFp7GmCJBSjvcs
 Fx4kUgrGv0kcYYvmKz1nYu/RHH3I8JVpRkAdJLSnlTtjEjP8mt9XfQHvisFHWIIw
 SaqAc43oyD3MRCw8NNPANHgmp4RjmEpcntWo9jg7ozMkCQueixff1VygRRwUr79f
 8nylDhq8MiKGbKVdmCS9HOk8nl2M+OQfAIM9k/X7IoFazwE7gPLspoPE95s6bxys
 kqQld4AbPQ3uEUENqggv8ai4B2Sfj49IzLMYK4eoq34coBvwyiWsurAA6KwfcdHL
 bmBqdQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany1xc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:09:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1eb205d31so2734912a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631798; x=1789236598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zoMJ8ubNugqDYoJRWFaRKxHdSYdWnZjnKAd139odpbM=;
 b=NQsxeFnTW+lBKnOOiU4OsiTDKi644jduuGQnhdB2KtfgjR72viao+QXOAP4YVeXpf0
 TG6DsHSLofEglStbP5E3P9M6VBSeNEZ32TcrV4h+N2oWpJ2mAuzahoatiN91FncfVGM1
 RrXXQXBWZzGi9ngvAV3L0CUXNn8oIoii3AGNbKsHP3dl3rxFMjjtDJjk+rk42uOARC64
 KH1Gsc2we2TQh52RPuyM48J8me/Ybj2hwAPJ5J1gu8RN9wKgDOxzNUd85l9SJWd2TOdR
 7RDQA+VI8aDjzwNKDTfgAq8qPhPpZjszKJHbIT3O9l3EVRXNKV0z878Br8D1N0pkjfAb
 TU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631798; x=1789236598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zoMJ8ubNugqDYoJRWFaRKxHdSYdWnZjnKAd139odpbM=;
 b=Wkta8WHhORj6jMkYMinCsjYrEvYb1YBZ+Rm05o7JlFRN5TEJz7MU7rVVPPm0EVltY1
 tvkWWuqEDje3LJZk7KvwKx0C1KrnNz9xn3Z6jA0oaqOGkMYDYA+B+usIqdYAxn0mkhmJ
 xDLTve/vogJ5/SQdiZpIwcC2ylbvNsoTnG0pYXN0b7WV4dpecZKefwjc6oFHHST3qRlb
 laCSOUEAaj7LdW9JHrAw3vNYvU3bppZjtVc1LjXlvILOfjmU09IAbGhDzt7DDRUD6rN5
 RMzv/9VN4ftIgzfN7W+SrwTdlbxg0SbOsQTQNuFHd9e544099o4OKMJU58zeqevoYx9F
 E35g==
X-Gm-Message-State: AFuF++nBUq6zhoBoBP0NPcWWxHwuxVFIyvczPg7iPNWNk+cDVkLNaoxO
 WhDeVA5BRgKLnz/lOtj4QXGh6B1Icch1o43H4yWGxJ52f0xXwZJK6jGueaeB/OOY7qe6LLOaLGG
 kIbMCRGS53C/fD8gHuanMQ+ZavJZjaZBpV8buRfWwcSzq6iYcTjy1Ndl7ly7XYbNVjA==
X-Gm-Gg: AYBFou3dq7TQb7n2Kh2F2oIW1qRJgMaVqda7867Umip+fUFhTi+vGmcyFsfhWB0MUvD
 lcKhMvpVG8PxRo5XgKLIlZB6ZPUxzZh1M91HxcOvsqWZt1CkzBx3rxJnGQq/6Gzs9gl8kwJek+w
 SDwwvfbXcwFdagl7GJsMwc7x+1zVkZFkIeeHiilLC1oVNkPGy1W8PlFtC5B6iKe3dPqLpHUQhSR
 fr1nsKbIc53OsUegRV1YTFpYSs+HaMbuVkDRYY2FdwaAFkSNwnt99J37It9rjbOmfJNj2tXhNa1
 oZjEFmgMOxx+iYWq3SdBSFBg57I3ZptAvUI2ntT8we5docSHgz56Lhemw1lkEtfxqaKNZyM7Dza
 1Zuh4SMjCHzC93V40DsDrB7GUHCo4nMAvsK1jWyDypm4r71r7
X-Received: by 2002:a05:6a21:6e95:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3da39ec3ebamr23253501637.8.1788631798011; 
 Sat, 05 Sep 2026 11:09:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e95:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3da39ec3ebamr23253433637.8.1788631797489; 
 Sat, 05 Sep 2026 11:09:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 03/17] tests/tcg/hexagon: fix undefined signed integer
 overflow in hvx_misc
Date: Sat,  5 Sep 2026 11:09:35 -0700
Message-Id: <20260905180949.1852673-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9c5af6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7jozP2JQLfe_envvOV8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: dUJlrLWafqFkh5VXxCOu16XNUq1qxW_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX2hHMwY8zwmjX
 9CGdZwvEI1dxKnUske53thZSk6WWMILJTYojcKkLlKOz3SEsFoLPOzDlQum7/u7MYDvhZZ2jtX5
 CHPcZy1xRxrr+74Zx83li0Gu/fgmQr2jclitfUTjSsavxX65zpH3+8tFIRu9/2lOetFzfgYI4gE
 BgL/Yk38XK1TFZnydoFRqjCxJLBkuHP1xc7NtXu8tBDPAMebHgs+uxRLeRpOWymD0LlyzbZASZ7
 l+eqZR9/uaEuVyae1RBBZpF47e8MTI2ZMoA9mknB2E6u21TavRXJi9Bw4QSFAFldN+1JM368i8Z
 3IiwoEwUX2eZHjimW/9QhFhXv0AW7H+uTZoRlFRnROmgtPsyHEZgW73ZxojdEGvaWTDHGESqnR4
 BiyBDuSbl/vY1SQWz0Nc+rkeGljTjYD8D8B9SNIPBpwYED2lb+UBCoHh/RtqmHQg/QK8AXh2rLX
 iQ2vs8ywYagAGlZzDGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX/rV8FT2OQQDM
 o49ZPb51HzYFYMECBQLVTDfHyWm0kuHYd/B4JdduAIH+P3m6eD8k+YHrQYmAxbWfBoLBtwxNAS4
 zKFFoHr63banC6RSxflEq20a3mdvkEk=
X-Proofpoint-GUID: dUJlrLWafqFkh5VXxCOu16XNUq1qxW_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

VXNlIHVuc2lnbmVkICgudXcpIGluc3RlYWQgb2Ygc2lnbmVkICgudykgYXJyYXkgbWVtYmVycyBm
b3IKdmVjdG9yIGFkZGl0aW9uIGFuZCBzdWJ0cmFjdGlvbiByZWZlcmVuY2UgY2FsY3VsYXRpb25z
IHRvIGF2b2lkCnNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93LiBXcmFwcGluZyBhcml0aG1ldGljIGlz
IHdlbGwtZGVmaW5lZCBmb3IKdW5zaWduZWQgdHlwZXMuIEFkZCBDSEVDS19PVVRQVVRfRlVOQyh1
dywgNCkgdG8gc3VwcG9ydCB1bnNpZ25lZAp3b3JkIGNvbXBhcmlzb25zIGluIHRoZSBURVNUX1ZF
Q19PUDIgbWFjcm8uCkZvdW5kIHdpdGggVUJTYW4uCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vaHZ4
X21pc2MuaCB8ICAxICsKIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgfCAxOCArKysrKysr
KystLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5oIGIvdGVzdHMv
dGNnL2hleGFnb24vaHZ4X21pc2MuaAppbmRleCBjMjFlYTk3NWMxNi4uZTMyNzE1ZWQxMWQgMTAw
NjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmgKKysrIGIvdGVzdHMvdGNnL2hl
eGFnb24vaHZ4X21pc2MuaApAQCAtNjksNiArNjksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2hl
Y2tfb3V0cHV0XyMjRklFTEQoaW50IGxpbmUsIHNpemVfdCBudW1fdmVjdG9ycykgXAogQ0hFQ0tf
T1VUUFVUX0ZVTkMoZCwgIDgpCiBDSEVDS19PVVRQVVRfRlVOQyh3LCAgNCkKIENIRUNLX09VVFBV
VF9GVU5DKHNmLCA0KQorQ0hFQ0tfT1VUUFVUX0ZVTkModXcsIDQpCiBDSEVDS19PVVRQVVRfRlVO
QyhoLCAgMikKIENIRUNLX09VVFBVVF9GVU5DKHVoLCAyKQogQ0hFQ0tfT1VUUFVUX0ZVTkMoaGYs
IDIpCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNn
L2hleGFnb24vaHZ4X21pc2MuYwppbmRleCAzMmEzNjYxYTg2Zi4uZjIwYWZjOGU2NzAgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFn
b24vaHZ4X21pc2MuYwpAQCAtNTUsNyArNTUsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2xvYWRfdG1w
KHZvaWQpCiAgICAgICAgIHBvdXQgKz0gc2l6ZW9mKE1NVmVjdG9yKTsKIAogICAgICAgICBmb3Ig
KGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgewotICAgICAgICAg
ICAgZXhwZWN0W2ldLndbal0gPSBidWZmZXIwW2ldLndbal0gKyBidWZmZXIxW2ldLndbal0gKyAx
OworICAgICAgICAgICAgZXhwZWN0W2ldLnV3W2pdID0gYnVmZmVyMFtpXS51d1tqXSArIGJ1ZmZl
cjFbaV0udXdbal0gKyAxOwogICAgICAgICB9CiAgICAgfQogCkBAIC0yODUsOCArMjg1LDggQEAg
c3RhdGljIHZvaWQgdGVzdF9tYXhfdGVtcHMoKQogCiAgICAgICAgIC8qIFRoZSBmaXJzdCB0d28g
dmVjdG9ycyBjb21lIGZyb20gdGhlIHZhZGQtcGFpciBpbnN0cnVjdGlvbiAqLwogICAgICAgICBm
b3IgKGludCBpID0gMDsgaSA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGkrKykgewotICAgICAg
ICAgICAgZXhwZWN0WzBdLndbaV0gPSBidWZmZXIwWzBdLndbaV0gKyBidWZmZXIwWzJdLndbaV07
Ci0gICAgICAgICAgICBleHBlY3RbMV0ud1tpXSA9IGJ1ZmZlcjBbMV0ud1tpXSArIGJ1ZmZlcjBb
M10ud1tpXTsKKyAgICAgICAgICAgIGV4cGVjdFswXS51d1tpXSA9IGJ1ZmZlcjBbMF0udXdbaV0g
KyBidWZmZXIwWzJdLnV3W2ldOworICAgICAgICAgICAgZXhwZWN0WzFdLnV3W2ldID0gYnVmZmVy
MFsxXS51d1tpXSArIGJ1ZmZlcjBbM10udXdbaV07CiAgICAgICAgIH0KICAgICAgICAgLyogVGhl
IHRoaXJkIHZlY3RvciBjb21lcyBmcm9tIHRoZSB2c2h1ZmZlIGluc3RydWN0aW9uICovCiAgICAg
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gMjsgaSsrKSB7CkBA
IC0yOTUsNyArMjk1LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9tYXhfdGVtcHMoKQogICAgICAgICB9
CiAgICAgICAgIC8qIFRoZSBmb3VydGggdmVjdG9yIGNvbWVzIGZyb20gdGhlIHZhZGQtc2luZ2xl
IGluc3RydWN0aW9uICovCiAgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTUFYX1ZFQ19TSVpF
X0JZVEVTIC8gNDsgaSsrKSB7Ci0gICAgICAgICAgICBleHBlY3RbM10ud1tpXSA9IGJ1ZmZlcjBb
MV0ud1tpXSArIGJ1ZmZlcjBbNV0ud1tpXTsKKyAgICAgICAgICAgIGV4cGVjdFszXS51d1tpXSA9
IGJ1ZmZlcjBbMV0udXdbaV0gKyBidWZmZXIwWzVdLnV3W2ldOwogICAgICAgICB9CiAgICAgICAg
IC8qCiAgICAgICAgICAqIFRoZSBmaWZ0aCB2ZWN0b3IgY29tZXMgZnJvbSB0aGUgbG9hZCB0byB2
NApAQCAtMzA2LDEwICszMDYsMTAgQEAgc3RhdGljIHZvaWQgdGVzdF9tYXhfdGVtcHMoKQogICAg
ICAgICBjaGVja19vdXRwdXRfYihfX0xJTkVfXywgNSk7CiB9CiAKLVRFU1RfVkVDX09QMih2YWRk
X3csIHZhZGQsIC53LCB3LCA0LCArKQorVEVTVF9WRUNfT1AyKHZhZGRfdywgdmFkZCwgLncsIHV3
LCA0LCArKQogVEVTVF9WRUNfT1AyKHZhZGRfaCwgdmFkZCwgLmgsIGgsIDIsICspCiBURVNUX1ZF
Q19PUDIodmFkZF9iLCB2YWRkLCAuYiwgYiwgMSwgKykKLVRFU1RfVkVDX09QMih2c3ViX3csIHZz
dWIsIC53LCB3LCA0LCAtKQorVEVTVF9WRUNfT1AyKHZzdWJfdywgdnN1YiwgLncsIHV3LCA0LCAt
KQogVEVTVF9WRUNfT1AyKHZzdWJfaCwgdnN1YiwgLmgsIGgsIDIsIC0pCiBURVNUX1ZFQ19PUDIo
dnN1Yl9iLCB2c3ViLCAuYiwgYiwgMSwgLSkKIFRFU1RfVkVDX09QMih2eG9yLCB2eG9yLCAsIGQs
IDgsIF4pCkBAIC00ODksOSArNDg5LDkgQEAgc3RhdGljIHZvaWQgdGVzdF9sb2FkX3RtcF9wcmVk
aWNhdGVkKHZvaWQpCiAgICAgICAgIHBvdXQgKz0gc2l6ZW9mKE1NVmVjdG9yKTsKIAogICAgICAg
ICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgewotICAg
ICAgICAgICAgZXhwZWN0W2ldLndbal0gPQotICAgICAgICAgICAgICAgIHByZWQgPyBidWZmZXIw
W2ldLndbal0gKyBidWZmZXIxW2ldLndbal0gKyAxCi0gICAgICAgICAgICAgICAgICAgICA6IGJ1
ZmZlcjBbaV0ud1tqXSArIDI7CisgICAgICAgICAgICBleHBlY3RbaV0udXdbal0gPQorICAgICAg
ICAgICAgICAgIHByZWQgPyBidWZmZXIwW2ldLnV3W2pdICsgYnVmZmVyMVtpXS51d1tqXSArIDEK
KyAgICAgICAgICAgICAgICAgICAgIDogYnVmZmVyMFtpXS51d1tqXSArIDI7CiAgICAgICAgIH0K
ICAgICAgICAgcHJlZCA9ICFwcmVkOwogICAgIH0KLS0gCjIuMzQuMQoK

