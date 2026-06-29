Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4EAC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dh-0002v1-RL; Mon, 29 Jun 2026 00:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d3-0002d8-Kf
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3d0-0000kB-W2
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:29:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJI91724605
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=hnowjhamfs643i6O
 9PIlqynfZVRCCjMqFe8r6GZ2io31f3f5hInKPdZGuWeIWhubkkevWuklN9Jzl9HF
 4Ldfb/V+AQwjqfbV6lcSY4/qXY8LFNpXfflvKj3yTCRlXMz0orTAN8g9j6dhKwPu
 EQAfX6xXpXOMOrgkjwD37wXfXcp9XEh/xAg+bnZkz05fzgv7cwNqtCW8Xce5yQd4
 NoBZOGidnx+lnrgKkUD3wZ+1fFrygrP2ZlgaOSjxICWePKwvvmWi/3TDUktFIm4Z
 dJRaSgVPo6FTkA17ngvg1VEq3ssmDIUybl+anztCxhJi0sKiBJi83rYpbJ7UuFhP
 KMB36g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6mfmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13980b6561dso7393061c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707388; x=1783312188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=F5Md8WRMFee76uzU3eQFL7XbudSwQ/52BR4POoe4JaYoMmmruTETJ4tXdBw1I0ysIf
 Au+u7/JZbGZekvlgss5k/tX2nao0chCxkW/nj9TXkizwU8N70ul5kEFZvOfMgL01Xeu0
 7Dy6DAXyOF/IfUUK+hLBrUVFasnmSqrQ8Fdu5IbpYnpkk5qpXJvI5av+CqQ31e/vWJ/g
 pIazNz0yEeYX/Tr8+lPGGZ19QNQpuWCpBlA+qvPmAWGxLPbCj3vZsMcdutNwMWeIRMWd
 MYvKzLGPfL//7EGrR6QDHS11nr+lL3TntklKA86FoxeD2P9QrpDVpSf7bOI3C/RhMD48
 mb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707388; x=1783312188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=gMRDDvSSY9C/9ovnxl7tMbi5F2jDChkcqkDjvg1qr+Rw5NSv6onHGVZV7BkzjTfOc0
 e2Mw8wdK3NuOiNxVg5vOdvK2H0MYIgz+KSB46ubTz7rCgf+XKtC2NapaOzdDzAIB83Si
 Xf0L4q1Tqx2iAwpRbfanCegZ+xasYCR3DG/Kb5pnmgFOO2QwuJxTkat8NHTkharDea0q
 j2CeeIkv/VV/KyCvdojbkoG1WOGfUf2fWhk4Oc3v0bs20aLO/jY/2MC8G9E7QA/aNmQs
 nE3jEgmPfDD/RXx17rj+VoaAfYp124C9Zjwh2pgEp7LDbP8A9XdGDX/FAOBsJSRLcu6k
 iNYA==
X-Gm-Message-State: AOJu0Yze5Rw0ahRF56igUvjw50awTAsqN/sUUqq9OJ6Psz37fb9xW/BO
 ulNLOL15xmnKLaqyIEenD+3A6fwLH3iK3QlY+2DssIAH0X/bN6lyqFaMKmEMSJ2Yy5gTwC1wgbr
 8rcj6YnScBv789/UoZbH/WeHg9f9hpBgREBuxTRiqg32Qb5xR+QYrtBqGiDvakP8VxA==
X-Gm-Gg: AfdE7ckm9P60TFagj6vePh3YaMt6OuGpxLdtLDJcIG4Lo0Nab8ln9lxs2GNI6Z+yZAV
 6/H7lSJ3wKk3GyXbAGTYXHl2hbBiStgKoA2PgdIHAk7eEATV8vvBI2dAFoIAM3o4ZWUTIrGKr4a
 RxYlxZBEVBi0vf7vf8GaBYnFENp/KErEs6W63RkdAAzRtatf+4c3wKh4UsY9QLSTB4WFuFNt2yJ
 Bpvt4tOYNMdnswzQQMkPmEC+UzhIg5B0eQBI97i/gLPJuVKMDV5BvPicLaPeCYlvDmv4gGbHrX+
 Fu6LtvVKQ5RbCnsDqVvI4TfRCkoEBYIHiArwV9fXWmTrzAFE4AoC2cqrIKjnVXxUqAKB7Paz3gL
 NT2g+7LJPmqPqc069BOzHaGqoJX4+65tjkUQFXr4jqbDBuNhIjSDH2SMhbyQ=
X-Received: by 2002:a05:7300:8ba7:b0:304:d14b:b706 with SMTP id
 5a478bee46e88-30c85069850mr14128010eec.27.1782707387712; 
 Sun, 28 Jun 2026 21:29:47 -0700 (PDT)
X-Received: by 2002:a05:7300:8ba7:b0:304:d14b:b706 with SMTP id
 5a478bee46e88-30c85069850mr14127998eec.27.1782707387183; 
 Sun, 28 Jun 2026 21:29:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 46/77] target/hexagon: Implement get_exe_mode()
Date: Sun, 28 Jun 2026 20:57:59 -0700
Message-Id: <20260629035830.1520296-47-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: heG-g0ZafeUYlB-cgmWLkPBqFJWSQ3BK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX4vZPoDmJRsxA
 SoGnEl7lwQNZgKcGpI3LgZNUrNfYC9Er7LlC8awGtYHNh35DdC7XPv3PeGDdg+HX7BsDvCfbCnK
 mszuuHWGb95HfslWxU4+6PBvzBBSAVI=
X-Proofpoint-GUID: heG-g0ZafeUYlB-cgmWLkPBqFJWSQ3BK
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a41f4bc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX9hCqkPIB4N+T
 rIRuPyc/uVTZLczust8wj8AXAP3NoLSDlflGwLUfH4TBhPbZcCafqQoeI4/OSJ1baPJnJzysC/I
 xs97VoLFioWGBhiQIPeIFwZJHyWMsVW2Q5v3QOKgYI9iisp548lzuw7cMHMLAr6enAl8e3DyNBv
 MEArYwgFMHawYgosTDkpVJWzxQC1/BedPhvKRDlJmBDbGLqTp9KoYtVoEu7Q0LHOh6d+/RNgumS
 gYYOKgr9Det9yc+MnX3SM9VUlcjd4mCXAvEcGgP2NOjl0Ri3wNsI/FcQsIdzTlJNSoBWYfzwLvs
 1Tk+0Q9s+sRcB+2SFpZ66Dx329HN6g6sJUGCxyI/1z/qFuhrr7xxv5V0ifawqbxGW6V3I5HpoWD
 vx6ELK1KQ51nJ8hSYhm1Y45cMMYA7IauYeXmWuYzpLUBrnwnKzHbrTr7noa0by9DyA1FYrds+El
 nOPO4ijvOUaHK+4CZ+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

