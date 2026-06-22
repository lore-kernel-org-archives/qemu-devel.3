Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AE9CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndG-0002zz-AL; Mon, 22 Jun 2026 19:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndE-0002yu-OJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndD-0002Tg-7r
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJanMd2177025
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=; b=kPrjI/y74Mrj1w2d
 Lf5zTblfmecPSJYYxyAWACF0OaJX5gCmDTbaidI3Z3X2x3tS/38IFttZZ+kmZWkz
 xApwxB1ArF9iuMlZtnB1mTNAHQWCUYG3cV5GaCh/k5gK155F6SKB6ANyxWKBPEE9
 E69lG3glna6pcgiYJ5iCQYFrZgbei0gEmoory6joT/1WjRA9uV/0q3EPraCMleBI
 jkX+DlxhHRYId5AtH62QKexS2XJ6iZWBQk0380deiL6aFdezfBzMav8EPXC/pPr0
 GO9FU/hh9gCXE601endsHv/RnupZFtTzm9/vWVuNo0OT1wJnK41poS7jnq0CIvwT
 1X8zLQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hakmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13980b6561dso11642582c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169231; x=1782774031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=dqYA93AHWrJgMymUxL36Jd5WtOa3mP7Wo8WU7d3b35xxr4m00Rhn3KvPjAdeqELTI5
 KsO7R7QDPntMaLcFfj2HvAgs9XwfjvlliCAdLyBFai8YCYODAlyMpeiHYylHDPu3ayN1
 t3ds3ahCpHbOreCOXcO887hEodd3jPF3ZM+JBljjX4PipTYWDZHL8LbsYbfuRztAgY8X
 gaWMR8MWOGF2wFiXj0QVIppBQKlPuMjqCIDcxzMx45yUdRQEpmvgnvqA+sCJY0FASC/N
 tP/67XksFvoXuOJC6vSf8iRZWb8ZsFKhRFUqK5cBJ+Vz+urgMtZgfDM/43ueHRlKhB8W
 E6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169231; x=1782774031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=cGxblBYrZ3BNsiQTAEEcg/mf10Pqw7Vdb76H+tAkWOusSg1S41JyVx5QMPIDUoSIlT
 HVMUTliYAb5bqiMUJ0JBnpXCuiRAN53yMAXMbJ3cIuC4vZjnrCymM0wT6AQvtSXLoEBJ
 myZsU6A3Imt0canZ9GJdo/ciy0EyI+S/AmF1G+ntTQkJZKumg2OefKKSdaSLn+aTml+S
 KCn+GQ6Jc4nZ3VWpyL2czICr6ycDjP3Ph2DMSPvt/HykLalMbI1kWRLoyCcVSeGsjubL
 QT6CJDSXubo2O9MxcGMuPrGX04rNA92Ilt2/2P+rV/MgkX5eek6tZwKdRV1z5OUY8/ZR
 ky9w==
X-Gm-Message-State: AOJu0YySoXcQ5YdXEWArmNf6Zkcr4O8GfOpIW7W7IrNUmPprw3M6oPwP
 1G2QISmp5K0iI+guxwK9UoQ877TdHsLNgW1k07B64/5FBP8hEi4lQeJX0fHl/0qC2U+qM0BA5dk
 lWWuXFrcMdNkyKDXB1icdx3dGlqlhNzrSAZVNOFzqcWOjm7779S3GztIyDVxRUi5+ew==
X-Gm-Gg: AfdE7cm5pp+upXcQKTv0vCbbuHXbaXbOL9TSfKzZLt48vL3QmK8fLBxo/e/VdrviLlO
 D4gHo7mRh3n7w4MfHDqFzB5lEvYFmrDUXjrhlggy1gX8I+eAkACUASoHe6R/qiQjyzJlnTSWR3B
 SAH8WifkeKTz57W137zvQouyKBKQuXsmYTWFFEf+rekA3kKC8rHBzdirQ+dcakDf5T595q033oG
 vmlqbgMsPICuNzfCdv6ksE7tXCnu76CEGGtYH+CvHxK4D6mSZg3EZmhRz3GCwO7SgnN6KXVo9hL
 75CL8MvED+YPafviKrphbrIRZJrOKcZQUzj+tHChzwOyvtob9lFCNtnkox5VXe0GFr2EfC2oAa8
 ariD3cVVOryH5L/+Kh+HaSoddWPD/DH2wibigQYyl1+src56X+yNbDr6gfYU=
X-Received: by 2002:a05:7022:3d12:b0:137:ed87:8194 with SMTP id
 a92af1059eb24-139a34e51cdmr8550847c88.4.1782169229872; 
 Mon, 22 Jun 2026 16:00:29 -0700 (PDT)
X-Received: by 2002:a05:7022:3d12:b0:137:ed87:8194 with SMTP id
 a92af1059eb24-139a34e51cdmr8550817c88.4.1782169229204; 
 Mon, 22 Jun 2026 16:00:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 55/75] target/hexagon: Decode trap1, rte as COF
Date: Mon, 22 Jun 2026 15:28:44 -0700
Message-Id: <20260622222904.607771-56-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 3sDOWjhMsyglXWUHpNzNZ6AZX_fvr7R_
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39be90 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX7xEx4wrS46ls
 ecrFH7xqLxEsWgJqlp0j1B1z1jQUx6BdkKSdSChi3/LGF0SCGStwkB9DewXoGJkKqHuuKlCRTVt
 QXJGf/+gnnDy4RKQ3DPJ/QamsXzft6s=
X-Proofpoint-GUID: 3sDOWjhMsyglXWUHpNzNZ6AZX_fvr7R_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX2RkSq1hyV+9X
 RQbt70gVYdGOlqx/o69T4h6l/NpOaxs8F8Lkt9omNtP1i8CFa/avXQl/M36wqom8rlYWVr2MSez
 w4TIfxdaloIpfLlDYIPv7XcNtEwQHIc6cAaj3uqdl7GFwGk8pM2b4zPo5taJyJiFVKXMuNFmYSR
 3r9x21dpHG2dnGGVsV7K1ygtUe3fEdgplHvcMRuUd6mZe7bMC6WpzDeJT4jovWabXJsG/Xcgx/6
 8+gLe8yrok40Xr0ehFUourHF1AmNIsjxLrMz9nvtNcs79PnuRMW7q1lmVt1/nsX0i2aeXWiQlii
 cMqoxyYiTUuJE1lbyzmw/vJIU5Yvj2RabjvGi5x8F6M8xiLGVgeRwafqK9dF2i31O1+Ktg+G6rr
 UvMkJfw1lYSP8rIAjhfz4m2xFDAmSqzRPvw275vRkdR6ICnb1RU/3opTd9Hpq6W3LdW5pJiXTpc
 YI09tKcmTXDF5/jXxSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYwppbmRleCAxNTk1NDUxOGI4My4uNmVkZGNjYTI2ZWQgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0x
ODUsNiArMTg1LDggQEAgc3RhdGljIGJvb2wgZGVjb2RlX29wY29kZV9jYW5fanVtcChpbnQgb3Bj
b2RlKQogICAgIGlmICgoR0VUX0FUVFJJQihvcGNvZGUsIEFfSlVNUCkpIHx8CiAgICAgICAgIChH
RVRfQVRUUklCKG9wY29kZSwgQV9DQUxMKSkgfHwKICAgICAgICAgKG9wY29kZSA9PSBKMl90cmFw
MCkgfHwKKyAgICAgICAgKG9wY29kZSA9PSBKMl90cmFwMSkgfHwKKyAgICAgICAgKG9wY29kZSA9
PSBKMl9ydGUpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAgIC8q
IEV4Y2VwdGlvbiB0byBBX0pVTVAgYXR0cmlidXRlICovCiAgICAgICAgIGlmIChvcGNvZGUgPT0g
SjRfaGludGp1bXByKSB7CkBAIC0zNjMsNiArMzY1LDE4IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9z
aHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0ICpwYWNrZXQpCiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQogICAgIH0KKyAgICAvKgorICAgICAqIEFuZCBhdCB0aGUgdmVyeSB2ZXJ5IHZl
cnkgZW5kLCBtb3ZlIGFueSBSVEUncywgc2luY2UgdGhleSB1cGRhdGUKKyAgICAgKiB1c2VyL3N1
cGVydmlzb3IgbW9kZS4KKyAgICAgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQor
ICAgIGZvciAoaSA9IDA7IGkgPCBsYXN0X2luc247IGkrKykgeworICAgICAgICBpZiAocGFja2V0
LT5pbnNuW2ldLm9wY29kZSA9PSBKMl9ydGUpIHsKKyAgICAgICAgICAgIGRlY29kZV9zZW5kX2lu
c25fdG8ocGFja2V0LCBpLCBsYXN0X2luc24pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
IH0KKyAgICB9CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQKLS0gCjIuMzQuMQoK

