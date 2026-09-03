Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DDAC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cby-0000X1-LG; Thu, 03 Sep 2026 14:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbv-0000Wi-RB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbu-0000Wl-Bf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3eY11209693
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HOSm9bsLEij8m7lAxCnEztwmaccyQJ0a8WhznKJxC7A=; b=CAQavbdP5q+tvaaB
 z8hH5+gG+6dLe9dy0loozUH25d6qqR8pA9nTADIP/9xOrFu6Y3syS83q+jC78tC7
 oeHkyLm0otmuuhD4aWhW/8oYGof8Q6Pv9S6mfBX2k7lc/H4TxQqLsP65Yaa8wOPy
 C9ea6AIRMFTrNfMFOclNMTfnR9yVZesnWgo/3R3J6g4YdqW9NugS1HNj/nroh91E
 5SoT+bk37SAYy32rH6/LFfBNwe/7g0rqONv6eAotdOfgmmtbf1eUZ0x0KRB5/InY
 E8kZTkyQS113hfgVvNkwniDk9oHIviseD4qYmgudLeyy/K7vui+3LiCAxuHpu0iR
 0o4LHw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p72edg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398e1f7d1a5so227217a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461787; x=1789066587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HOSm9bsLEij8m7lAxCnEztwmaccyQJ0a8WhznKJxC7A=;
 b=XJSOXOqXQGRs3DEq6BKqpbCGu1Uk63QINnanHqC2iSe9Pw1xtyhtipF2LAoX4TI3Pj
 840F++MH+I8kfurqV1zwO2w+VI1DM67HKIsR78sGKegq0WoOzM6yZjXA9TvY2ajGFO+9
 GAI6NmNnCmTZ0D/hEBfF25/6Qpz28Od9ZNydaj9iDBR5cI106ws/c+bO4P/i3vpF0dEj
 ZBB0amlyuGHFkH103tVZ67+UxYLCyLTfXVoQHgQPSW8T80k77sqpES8LZ3ulY9IJiF1o
 TVT0kGJEXn1+fOluDYq+4FJbGNXH05cck++sIXK2JIg/ncesUFAZ5in7fjQeYWANA4yV
 4rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461787; x=1789066587;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HOSm9bsLEij8m7lAxCnEztwmaccyQJ0a8WhznKJxC7A=;
 b=J1EzrlUAi2Op+fmmseiG3FC7fwdHKWOQ9o41yT2XfZU/nL5YJMln4Gso9APFra1u6F
 Gq+dDL+K7RvalOigQtI9nKlKEzyFLN142Daxmc1MavLGcGmRXB4YYMzfJ9cuJMtGvlhW
 dVjxIgPU7cBDSPRfPAJMEeX+8B98sF9rpDbvJXv8rxOtylQZGOpDSP8cGh+ErLkYvfvF
 T6pvt7dapBAuraslHlBqtWSkjnncOY6TJkzNmah44ArRuvQhVNaUUA/vjfmFatZSDHF4
 2R6JSoHJXa7dJ8BuCXWBdauXHmJJdiZ7jq5XHV/+qfeUiWtMH8XvQKg8AHnVwgvScBR3
 hQiQ==
X-Gm-Message-State: AFuF++kMD35cb3F/Xh0SPj+dyY8LP+QkMs7ldn7Izhqjjf5F2A5R6552
 891e/tZKJOoK3Daw78g1UH7j2p+Bw8i6ryrWv3TS4lJMt2z3mQ0EzEDz2a+6OdBq1vfBBTv91Iq
 +4G1mydRZofLFe/1D0zalH6X2AeCRgPIX0/im5Jgb7DTaR999rH1SYbsJ0s4yuk4i6w==
X-Gm-Gg: AYBFou0U1Ge3/vpBfV8SBvXtwKVVcVTM0nrNY7VutYBF98HNvLXhSarr/oL7Tt7IQAy
 EZUz8dQ+S/FCaWubZj6Ibt9rZS4oKR9HvOGIftZCrIxNfq1ww29opmWfNibyi+w896gVPemitdE
 3fJfKyAEURB9dp5j5NOVOsrFOb3UMggRM8vG/kCIUMGxYU0yScQCTiRl0M1tGEnklKUz4xPWOai
 3MSp1zJmz3Dua1OiUrzMZ6CLV5UmDgpS+8aBmEf2pLFN0KDedI7Kd8lNcJ3uLVyD00vGtsQih5W
 WTW2rnULYcPiCv6+zyFRq6zGAvi0J3Fo1NdUspoY5Ck9cgf4Rx2wzpKnWq3DgYvleOBvCLEr9Iq
 LvRaiJjiNykmOGUs+KMP3mHhsla4wQKSxT69TLpHixVqP8jjo
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39b26277b88mr783761a91.24.1788461787321; 
 Thu, 03 Sep 2026 11:56:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39b26277b88mr783694a91.24.1788461786824; 
 Thu, 03 Sep 2026 11:56:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/8] target/hexagon: read BADVA as an alias of BADVA0/1
Date: Thu,  3 Sep 2026 11:56:16 -0700
Message-Id: <20260903185622.3234171-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5CyGiRlEwNJWdNY0PCWeKSnLkscvVDuJ
X-Proofpoint-ORIG-GUID: 5CyGiRlEwNJWdNY0PCWeKSnLkscvVDuJ
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a99c2dc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=feXoTaF-XZ6kQvkB_U8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX/QUNB3gbY4Yq
 fjXoIxogv9dJTHGPj0tiFokhy/92giHaPVPVBRvjgdI+YDabk90++cQRdDq2kn9JxSnRc5y3rUK
 QRJLSrZ+rz16ygVaJhLGXGu+Ymm9kz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX9d/I6WQGci6D
 KCUOXiKfKEmxAwkaWnimOLSpC1jo10Xz+k0bhOd2/lDLGR1giPYTplHVT3rzx4oTwfQeboSXw35
 z5rjTo2YnVv5CaWtsC8m0Mjg378vdeJQx7hieO5kA5ob4O40EuoPjtAC7qV5PUFHAgZ0PGQJeLX
 WsHav7ftIwLk5CkqABy92CWTrnbGkrKOMS2Y+cIKrprZvMprUWjkMQbdh69Mw6myevRxr82cOAU
 O4Pebued5jl4m7+Ee21H3cH6fHhRzP/0uZF5ojFxbLZ3A+QeGivQg/sfDubPPvwMe8ip/r+a3DA
 SQGnU9iFGnEBwOBDPxMeLO4X5jbdD8mZrnhvq0xgS4p6QsXFKDnvEfuHGPSezG/wE8HxE3685uT
 q+M/dSI1iNBiEYF/KwtMTMRlINonItn/2BQ9+/UKmqtXBcNm62uU2qDhC9EEUKt6qHyYh3J8Pm4
 AmyO19PNUkdtst8giMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
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

QkFEVkEgaXMgc29ydCBvZiBhIHZpcnR1YWwgcmVnaXN0ZXI6IGl0IHJlYWRzIGJhY2sgYXMgZWl0
aGVyIEJBRFZBMApvciBCQURWQTEsIHNlbGVjdGVkIGJ5IFNTUltCVlNdLiAgc3JlZ19yZWFkKCkg
aW5zdGVhZCByZXR1cm5lZCB0aGUKc2VwYXJhdGUgY29weSB0aGF0IHNldF9iYWR2YV9yZWdzKCkg
c3RvcmVzIGluIHRfc3JlZ1tIRVhfU1JFR19CQURWQV0uCgpHdWVzdCBjb2RlIHRoYXQgd3JpdGVz
IEJBRFZBMC9CQURWQTEgZGlyZWN0bHkgd2FzIHJlYWRpbmcgYmFjayBhIHN0YWxlIEJBRFZBLgoK
VW5jb3ZlcmVkIGJ5IHRoZSBoMiBoeXBlcnZpc29yIGtlcm5lbC9tZW0vdGxibWlzcyB0ZXN0LgoK
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCA3MTU1NWE3YmEzNi4uNWQ2NGM1
NTIzYmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xODg5LDYgKzE4ODksMTMgQEAgc3RhdGljIGlubGlu
ZSBRRU1VX0FMV0FZU19JTkxJTkUgdWludDMyX3Qgc3JlZ19yZWFkKENQVUhleGFnb25TdGF0ZSAq
ZW52LAogICAgIEhleGFnb25DUFUgKmNwdTsKIAogICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7
CisgICAgaWYgKHJlZyA9PSBIRVhfU1JFR19CQURWQSkgeworICAgICAgICB1aW50MzJfdCBzc3Ig
PSBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdOworICAgICAgICBpZiAoR0VUX1NTUl9GSUVMRChT
U1JfQlZTLCBzc3IpKSB7CisgICAgICAgICAgICByZXR1cm4gZW52LT50X3NyZWdbSEVYX1NSRUdf
QkFEVkExXTsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4gZW52LT50X3NyZWdbSEVYX1NSRUdf
QkFEVkEwXTsKKyAgICB9CiAgICAgaWYgKHJlZyA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAg
ICAgICByZXR1cm4gZW52LT50X3NyZWdbcmVnXTsKICAgICB9Ci0tIAoyLjM0LjEKCg==

