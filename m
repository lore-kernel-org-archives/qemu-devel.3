Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4999FFDEE5D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6P4-0006ke-41; Thu, 23 Apr 2026 22:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P2-0006k4-R7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P1-0008KH-4P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O0WoY2154579
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z2MDxjjQJbooXhtfrG3OMxDS++cZUaWGHcLuK2xhE5Q=; b=QH+fRniXg46bixt+
 rhukIQVwSHSIGyJqNL/B4KHjRUJgChCIoTf/sS7euzI9z1H6cc+jJ+XfUgy+GiEF
 MlgZezFkkNdFbYqEKPuApMeSN8JUilzIIGN26dzHXvVgT6Zy4Na4IrbRoxn+m+9x
 6srWjZThkIGTc/Up0CkmclY80E4j5+NTc+Fk7ATzLU1azNWs6MVxYGwfYdeMdNyp
 U0oslhh9egPO2P7aOPYsZ+mstcHIMkR1EhJqF0myTumiz/czacSkxheGu8ATbkDm
 L2QWLQTdz5apLODUWyps0SXfkcIZDPmH8F11gMFFEKseQyY7b1xx6oG35gTGb0gg
 7wMzPQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpf629gm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2da19227bc1so14690698eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998181; x=1777602981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2MDxjjQJbooXhtfrG3OMxDS++cZUaWGHcLuK2xhE5Q=;
 b=M8FVsxGLYj3mfpffkBzA/uAMSgNp+uOTqGHXcTUohmwb3ZN7cGiAvp1chXnUzi8VXa
 pslFtJY/yCWi0xcYEqi1W7cdOGUBbYHnLkgXFMhggHiQdxZ7b4fAvq6bjYFmNq66xODh
 PxPK6MWHw9hDQc1ShS8sJsRFr7a8ueX/mO+BRbGUB8qDdHBhkyhAxHoKEL0GK6FsxmcK
 vdkWOSd+DHk+tnCooP4buwyVCpyewpTm/+q8VLnPwMaywttbgqVDiUG3T0eXi2nlwdwo
 lmBUgBrmHQBQqvzEuScdQ+7sMljPkBzQ898twILiIc5dArBlCAlUNyiy/wX2zRY1HTjU
 TF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998181; x=1777602981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2MDxjjQJbooXhtfrG3OMxDS++cZUaWGHcLuK2xhE5Q=;
 b=d6yFF9E0I22WkMGCu19xYSgV6LKkpHevxmtr2JZOlqobEpEwC1pwzsvjRaWR0JeaaX
 R+TPVP6C8tHq7GCDBvKCYd+VyLtNY9igOXybWUB2iwRumiga3TVD/n7wNAJ5J2UAnP+c
 fS28hI0I9YsuXC169dBBsEVbNzSmuAOptVmNPV3VvzfP9PmMvaiLMP+qgFeq9uValpxD
 4lZiNlqfvibUIPVVpVYf+yVaZsgIhJCnEOnjjE6+Xo4oCECfOWzAXXR1JpUHFDuegJEZ
 rStGyydAOH7cbWKnGbXmmYS70csoSlnp5UDYt1MRpAkTeiKpBi+Phcf62ufIcGU6cDmo
 uTmw==
X-Gm-Message-State: AOJu0YzTVr7Bf1noTT6wjfz7wOMX975SaglSgfbeSJicev/ewVFBKDjY
 G+WxSoY1kk9u+SJUHM2It80ITT+jqXDanMLMQulz7gZKDKOHZP11aH2f6XewvdwAzvAtoi+b44k
 442IFs1mVp7Z+9eiH1ZbnCALI6BqhR7uOtrYQfdYN7Ot1vzFnsZp5b5caCasepmX+QA==
X-Gm-Gg: AeBDievJNS8U9j8xlw9Y84bmEIrIsUE9VxYzghbfutK3azQxQP4BL9xPNLsuC3QKkeV
 s/TqkPvKK7bXLon3Kq2d18bqMlVftA2ESDTLBZmf91UXTREQ6CQ/vX2qPlnHm47eEADvs08dFLc
 q5TWVFoqT1mHChGaY0MYGGBYO75LX09Zj8194Qlu/ZTilMnKBtKts/0B+K8DnR1dzP2liDuJ4nR
 3JEoKM1HAZS9MbT9GqvbAMCgKDFwQJbC49nS5LeTf7+LK0P2TokvntliJi83yKvF64yDmADIi2G
 1N+s1FL7bqWu7KRbNzA47roXgNBg89r/5L0m6rfDV57DMJT+zFzXPdblxm3kPMPKEthH+vv2zfX
 I+RfYNTSKSlby1AKqCixKdyXYSi93YjgfSS+r3uykzgP62n5H2ZcTBBsPCxBrfUbTgBZhQjCtA2
 fAjtlj
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2e4786460f9mr16344712eec.16.1776998180966; 
 Thu, 23 Apr 2026 19:36:20 -0700 (PDT)
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2e4786460f9mr16344693eec.16.1776998180499; 
 Thu, 23 Apr 2026 19:36:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 5/9] Hexagon (target/hexagon) Check each opcode against current
 CPU definition
Date: Thu, 23 Apr 2026 19:36:02 -0700
Message-Id: <20260424023606.2556830-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Iocutr/g c=1 sm=1 tr=0 ts=69ead725 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UzSeF1EqHBairItpb9sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: QY1quVrNGqubEhfXQ-8A9U0dQbUoJhbB
X-Proofpoint-GUID: QY1quVrNGqubEhfXQ-8A9U0dQbUoJhbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfX8u2qlo6L6o1M
 frvRBA2uHrcRT5CMg0y0xXFnszwgxRkZK/DhuON/J/7IfM6XOCd9kVXw0B1x//mrM9er9EIfl0e
 9vPHlhBm4H1eSc3Ohe8voWB6vuhKshnO4GcON4oEkjAwGVgWTBpqi0rEb2k/cJzg53h4bytYIIc
 YvmSW2erV5zJuqIyuxqWhN4K46ZkDPSM3m1LUJlV+zR4yN84VG5k3eYibzZJM1ZxJql5gddUv+8
 pVp/h7DPeEZcxwcGeb23TriceWCtsbdG2V+qWKfT4T7dnBG/2RlL+Ab/UFCgd94VEjLkfQugfbq
 8BuYBwSnH6uzPA9eNslX+xXVL/pgghbpWDB8yBuFZQrrLT3F4EH30U0T/3BE/RctI6mWJo/B4D9
 vhUOY/kfxTYXjqyjsEMaD25D0nap0AGP0hunmRaadIVM9dQn3TGWLp7msOvjYw7Y8x3zUNulZUo
 jB+jZ///gXxqIJA3SBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240020
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkR1cmluZyBk
ZWNvZGluZywgY2hlY2sgdGhhdCB0aGUgb3Bjb2RlIGlzIHN1cHBvcnRlZCBpbiB0aGUgY3VycmVu
dApIZXhhZ29uIENQVSBkZWZpbml0aW9uCgpDby1hdXRob3JlZC1ieTogTWF0aGV1cyBUYXZhcmVz
IEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpDby1hdXRo
b3JlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdl
ZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5oIHwgIDIgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jIHwgMjcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaCBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5o
CmluZGV4IDNmMzAxMmI5NzhkLi5kNGIwNDk5NjFlZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmgKQEAgLTMwLDQgKzMwLDYg
QEAgdm9pZCBkZWNvZGVfc2VuZF9pbnNuX3RvKFBhY2tldCAqcGFja2V0LCBpbnQgc3RhcnQsIGlu
dCBuZXdsb2MpOwogaW50IGRlY29kZV9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgsIGludCBtYXhf
d29yZHMsIGNvbnN0IHVpbnQzMl90ICp3b3JkcywKICAgICAgICAgICAgICAgICAgIFBhY2tldCAq
cGt0LCBib29sIGRpc2FzX29ubHkpOwogCitib29sIG9wY29kZV9zdXBwb3J0ZWQodWludDE2X3Qg
b3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKTsKKwogI2VuZGlmCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmlu
ZGV4IGRiYzljNjMwZTgyLi5iOGExY2Q1YjEyYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTY0Nyw2ICs2NDcsMjIg
QEAgZGVjb2RlX3NldF9zbG90X251bWJlcihQYWNrZXQgKnBrdCkKICAgICByZXR1cm4gaGFzX3Zh
bGlkX3Nsb3RfYXNzaWdubWVudChwa3QpOwogfQogCitib29sIG9wY29kZV9zdXBwb3J0ZWQodWlu
dDE2X3Qgb3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKQoreworICAgIEhleGFn
b25WZXJzaW9uIGhleF92ZXJzaW9uID0gaGV4X2RlZi0+aGV4X3ZlcnNpb247CisjaW5jbHVkZSAi
dGFnX3Jldl9pbmZvLmMuaW5jIgorCisgICAgc3RydWN0IHRhZ19yZXZfaW5mbyBpbmZvID0gdGFn
X3Jldl9pbmZvW29wY29kZV07CisgICAgaWYgKGhleF92ZXJzaW9uID09IEhFWF9WRVJfQU5ZKSB7
CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBpZiAoKGluZm8uaW50cm9kdWNlZCAh
PSBIRVhfVkVSX05PTkUgJiYgaGV4X3ZlcnNpb24gPCBpbmZvLmludHJvZHVjZWQpIHx8CisgICAg
ICAgIChpbmZvLnJlbW92ZWQgIT0gSEVYX1ZFUl9OT05FICYmIGhleF92ZXJzaW9uID49IGluZm8u
cmVtb3ZlZCkpIHsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByZXR1cm4gdHJ1
ZTsKK30KKwogLyoKICAqIENoZWNrIGZvciBHUFIgd3JpdGUgY29uZmxpY3RzIGluIHRoZSBwYWNr
ZXQuCiAgKiBBIGNvbmZsaWN0IGV4aXN0cyB3aGVuIGEgcmVnaXN0ZXIgaXMgd3JpdHRlbiBieSBt
b3JlIHRoYW4gb25lIGluc3RydWN0aW9uCkBAIC03NDYsNiArNzYyLDE3IEBAIGludCBkZWNvZGVf
cGFja2V0KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbWF4X3dvcmRzLCBjb25zdCB1aW50MzJfdCAq
d29yZHMsCiAgICAgICAgIC8qIFJhbiBvdXQgb2Ygd29yZHMhICovCiAgICAgICAgIHJldHVybiAw
OwogICAgIH0KKworICAgIC8qCisgICAgICogQ2hlY2sgdGhhdCBhbGwgdGhlIG9wY29kZXMgYXJl
IHN1cHBvcnRlZCBpbiB0aGlzIEhleGFnb24gZGVmaW5pdGlvbgorICAgICAqIElmIG5vdCwgcmV0
dXJuIGRlY29kZSBlcnJvcgorICAgICAqLworICAgIGZvciAoaSA9IDA7IGkgPCBudW1faW5zbnM7
IGkrKykgeworICAgICAgICBpZiAoIW9wY29kZV9zdXBwb3J0ZWQocGt0LT5pbnNuW2ldLm9wY29k
ZSwgY3R4LT5oZXhfZGVmKSkgeworICAgICAgICAgICAgcmV0dXJuIDA7CisgICAgICAgIH0KKyAg
ICB9CisKICAgICBwa3QtPmVuY29kX3BrdF9zaXplX2luX2J5dGVzID0gd29yZHNfcmVhZCAqIDQ7
CiAgICAgcGt0LT5wa3RfaGFzX2h2eCA9IGZhbHNlOwogICAgIGZvciAoaSA9IDA7IGkgPCBudW1f
aW5zbnM7IGkrKykgewotLSAKMi4zNC4xCgo=

