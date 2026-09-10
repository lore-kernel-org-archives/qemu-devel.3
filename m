Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2898C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4goV-0003vQ-Vf; Thu, 10 Sep 2026 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4gll-0002KX-3E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glj-0005QG-KG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4XoV107121
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tZMgSw0+Q91bACgsnDdC8hHrp5qT6Ry60fg8WAP88z8=; b=fJIeQeZvZQ7n0aFS
 +i5i7dsW2RktfbSDWS0exXdMwTPl+bmrRERVgObCsaGfM195pouXDLxYIkyvq0tV
 oeVeFvRWVq1aMmOcTmaa6esoNSIOesnWzoQ7v77EjRsIjcoWTt/qFLlOZjyPH4iF
 4ESJTdsMZDW5TEqox2VW3KDixpZwFnukIZq3JGxNUNwWNdd924/1g58dbk0Gjovh
 xkoxruB7u0YcYaziApM6nWYPSO01XhzDxlZEFtgM8kGIQFEORgQehMN0j4DtyKDr
 WRIEM31vYNcgg99SKlWml7vOZRuIq4VN2Hwe2I3VTnEy2bYjcVOrRSvSVB7cJAmz
 4KFtQQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gksh8srxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:54 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9e2db9914so1350273a34.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789054373; x=1789659173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tZMgSw0+Q91bACgsnDdC8hHrp5qT6Ry60fg8WAP88z8=;
 b=ONTp0TFn9e9hCYdK2IkOYH4WOvmEKJP3JAldGK7ZFRlyXfVwFWPg6XdRrmszSSJ9f0
 Pkfb/lHKBK4CEnVNlTd5O4IdfbuLDWxoy9E7QqkivcVMSp68vpN6Je5vYMEw4YVRKXZe
 U/OS6RZx8uwMF4hUmSHO2JRZwnF7Mdkg1iZo5i55DWnnVpwcMk3j4J+17p57S6cY+xJH
 7DKpXTI/nbfSMTgUElmEnIy8xu3/CTYYVSLxB8unLIvYX1ODVAnmh2CiBUjI581fCpmA
 OobyC/2g4TMGtRgAziJjwfnTG0bxU9kpPlCWnbf40IfrYpQIfzUbDuke/nBIJ1o5XBZm
 q7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054373; x=1789659173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZMgSw0+Q91bACgsnDdC8hHrp5qT6Ry60fg8WAP88z8=;
 b=iplkD3aMycF4Kt3E2EzqzwtIebIQpc5x42Qq43qESLnwQ9I8xObFR2XQlcDRMppCSD
 dEMLd3sTtuwU4j1NbTK7pDHJvTZ8/6WCZsRQPqKeauwZv6vqyQ1CYrvZHgglyD+iBGM0
 X3sAw5Jnv9hKDQlnrXIZ817YNgkDNUqcPAqelBAKZFVidNiAM2zYFB8NiZye/6A82BaQ
 lIQWPNazGOEkr+Ur2ync82pxXeUX1AaH62byFxgVyb32YQXg8DjyXfbM6gXGkH89kLfZ
 zOFDVR6xBq7opdp8uVU6a6z9fu16SzObX33LaKaiWAUm7U8OI3Thc8blcyZZjkOoyKcT
 yKvw==
X-Gm-Message-State: AFuF++mrzjlV0jzH84NkdJ2gGK/V5okwajwAFux8GlYSXeDuBwtfKxaw
 5TxLUwR0QU+/LZY5hzq1zVvUGZOqJIVFNx+UeAuIYz4U35jML/IneBx11sFjmwyMvStawFAruV8
 TV8BjxJgG5DD8Z+cZX8ruhPbRPvti31icUJTxC7EzoknYZrcdWKqwIry83rE1qlqWqg==
X-Gm-Gg: AYBFou1fFtyUfIfT3EHuimCyjT3tNnwaHxnLVWIJ0NsFJtTNVNR7nwXG6wmvmzW7klf
 eT0363eWMyHkG8sKs1V6ADS2Z0f1wsLbI4RZD/NhTSEDqQDiiKHo5kDO8MZ4pLrlzzP3SMhZ7xq
 FNSmtIZUvi+4t6HGkkn1OzqTBLlS9p2FexPTREX6rtUn9Q0/ezdmfOqTJjO/YgZH2SR8x4xV7Xu
 8fj9kxMwFU/+s5XdWl+egwQ3qUZoL3MvUC21KzR8rAz6rdF4+eM9X3OFHtJXXt+4i+NHfEnbGwa
 fM+4wteUwnPsNu6+j9X/HKM8XX2RT492YmOkgo17KUc5yLH26cP+I4hcsULSVzD1VCC1Z7Ad48g
 kE1OOoHRCemE7gsRqseY00eI7aQgEOmYubxAQipAYRHLtRN4P
X-Received: by 2002:a05:6820:1517:b0:6b5:ec2f:3576 with SMTP id
 006d021491bc7-6bf47581eeemr2450506eaf.39.1789054373581; 
 Thu, 10 Sep 2026 08:32:53 -0700 (PDT)
X-Received: by 2002:a05:6820:1517:b0:6b5:ec2f:3576 with SMTP id
 006d021491bc7-6bf47581eeemr2450491eaf.39.1789054373160; 
 Thu, 10 Sep 2026 08:32:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm19563727fac.6.2026.09.10.08.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:32:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 9/9] tests/functional/hexagon: add test_hvx_context arch test
Date: Thu, 10 Sep 2026 08:32:21 -0700
Message-Id: <20260910153221.1674285-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cECSHsnptN52-doHYjAANBJs2HgONorb
X-Proofpoint-ORIG-GUID: cECSHsnptN52-doHYjAANBJs2HgONorb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfX6U3FuseadKpF
 clobKOYTw3yRq1bwVm8J4YMDT9v52SVA28c6nekycwuFXEQh/CgDyqjlOLXXL7jhYnVHUomlH8P
 Sm7yP4W/aA56K5gtR0x0RHp3ViXeY675ujuaZj7dqnv864j4n62OXxoNYAPR0MmIR9Eh5U0AVD4
 Ux8KVOpgeoTFyo+bk39AAV4c5CM3Y6RZaVZthh697OI/PmXWp2A0MB492UsW/G/T1NNR88CW5y/
 INMmDZP6vTH4U4kapZyJDLc8mDcdG9Z8PJMhV3WRcCNlsydpfft2f2G27gOzXQggyVVEPGpy90V
 QsrKj0mueGY9mPfWUotxCx2dr2C+MM7ekaRkdE2+2RPhviak9b3JFIYl0hBPOOPETFAEDROhCo4
 fE9sCIL9utJFNNKJXXtbj2G1rINz/r7I2yx/K0M29XEOYzauZEqg49Q6zNI4JZLaWd44AKD9pbr
 xJEB+ULDB53ZWh5iPPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfXy5bz2Ubj8BEJ
 YCzO0GW3F5yfz0X4MfOxzq5s2eCMVsrV3eycqaR4Ho4Os524jJpcjCAql224OWlZLpOrZt55kLD
 kLurNqN11todI+BqCvrYYiDuWd+ZDyc=
X-Authority-Analysis: v=2.4 cv=a56lZkSF c=1 sm=1 tr=0 ts=6aa2cda6 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bgrJZOaH1VlBtLBOFfcA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100187
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

UGFzc2VzIG5vdyB0aGF0IEhWWCByYWlzZXMgTk9fQ09QUk9DX0VOQUJMRSB3aGVuIFNTUjpYRSBp
cyBjbGVhci4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
IHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKaW5kZXggNWQ3Y2U0ODc0MzYuLmY3
M2MxZjQyYmYwIDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNo
X3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMu
cHkKQEAgLTk4LDYgKzk4LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgog
ICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3VzZXJfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJU
ZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0IHNlbGVjdGlv
bgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUgTk9fQ09QUk9D
X0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlzIGNsZWFyLgor
ICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2eF9jb250ZXh0
IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1h
aW4oKQotLSAKMi4zNC4xCgo=

