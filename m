Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF6EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQiv-0001A2-KM; Fri, 06 Feb 2026 13:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQin-00018c-RE
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQik-0008D4-QZ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:25 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616EqpGn2483302
 for <qemu-devel@nongnu.org>; Fri, 6 Feb 2026 18:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LeWn/rnkeIdof3Uh+foZY8TtCF2GD38j3/bVb9HIVR0=; b=jYRSDYZPXg9OvXXA
 DEWPObVU1TeZOvIZWnuM41+PST5DHKRxIDIIbCI3sZTXXt7S6ytBg04ubydacrMs
 wgfIudNVCWolxIO+fERpIR8vUl/ZK4iVZ/AG63lhIhsIBSRNkC0GEn74t0KCtMC8
 K8aDoJXVfaPhcYzfx8jv55MIbc1CL053xs2PW69/Vdfy/o+F31BJk3d9rcOvE1EM
 dvy6g4EAJXXmVTqVhgLR1QxHZ9XhIKrqLzey33YIDenblYP/cLQOTBzg+DmSgHzu
 Y1JlX0d1UwOp3oIwH0Jj0KuWwXmDQepdSllfnDx/b4lks44vEgTEPw//JwhgGDjv
 ziq8Fw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c1722t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 18:38:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b83787af4cso18451658eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770403100; x=1771007900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeWn/rnkeIdof3Uh+foZY8TtCF2GD38j3/bVb9HIVR0=;
 b=ZVqmQZEX+MzKJrorfxe7NI+o2Ofqkc+u5wSKiCVbcvlRiJ1vTHlb3z25ASS3PUy4UH
 eMz/ZTfx7FNf+6BTk7Bg0KYSv5Ujs3UBRmj7HuRBJ4CxA36sH7VYA//IHb1elLbg63a8
 kVBtT6GpsKfH5Syy7e8wRovIJOvBfCZOppLYHP8QZ9dL701SiA2MAO/rRKdlU80Qf7Lx
 yHQHqKoW7O0tb2G6C1WvrOyMPv0uK9fVxBcstxdffeG7cHq/d97aB2OHKK1YK8/WVw1j
 zCJFRXOBdqyj4l8Z5dMNSkZxxZqmLPFQOBSQHEwKgOxqh7lTFkNrtbZmR1uXayiErPLf
 8VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770403100; x=1771007900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LeWn/rnkeIdof3Uh+foZY8TtCF2GD38j3/bVb9HIVR0=;
 b=ldZ7E8vEPZf18yCL31pPX45BYKJyyM+UZBtUrJ73oAFpw0+DVjcDtL4vXdraYx9nl4
 gJrlMVi61VQl1BVRo1abXYq8nldZeWL75yp1v02edlWYNyAeYOBKUK5E7kNN2J0JnslX
 raONUeqh7C2m9vkoyCpEkuWvzDXkAHN7uudwFybAcjCKzxw2MrUzFoe6dHqRfiBFHs68
 TfGb5RsCvGwY5FRPEFJSYnl0tOGFa6xQHm871UUGz9XAkgkmLcbNHCt0cdac9rEuHEsZ
 p8p/x79oY8/lfG9Wbuho4GUkCh1Y0ry9jsvJQSwNwCbNCcaArlhYei7CPvIRjLTTxNsw
 Ok1w==
X-Gm-Message-State: AOJu0YyctbXzB36iBke96FyebIK6bT+EKP7YNFnqo31TaM0rw5HO1fzG
 NVPhI0qGzDcvP1N0z+W5dN8rEyS5W7l83OtaY5PvoiwJR6fw8AUrL0FL/5DHv0Kgu34QbjFRuq5
 JvK0J/FDlgKLRIAMOig7cbwmLUZP/zI7/Dl5kdyVl3RgaR4bl2RJ5sFf0ue/IxDdyHQ==
X-Gm-Gg: AZuq6aLyiBv+cEmpORRWmdgDPwWUKQ9Po1pqOWKFLobmnFm0zgHUa7PmAZihEFR5OLY
 wsfiIkNNuUm0P9wKiKDnBQiuQZjqkon/5SNy7GkGER7drMBPcLrwznqKViF5naWGDOy5c87T1F7
 3GbqEsBqwTu6HQE74R2+xR/zZE4Be/35yMaIejZ4z81+01p3Ai1yBtZgwUEGBcGum109Uc8f/lf
 gfGnjiwYOCSCbedBeA9zlEodGNqrgtKScCY4AnEEOjvZ5Qsoz1oFbvM6bQhxOOlrAo6hmq91IhP
 U1bRHvqP/Rai83ScDqOSQjYG9Jiem5hKN8e170oE+lWiq/U7a+xqpJUfyCfkE1b7NyVFRHABRvE
 UDwZjSTOnIPYQ/PPCPCDdSgB0I6UQAPBt9DigZFDRC+cM0mNgNvEyyZuxJQ==
X-Received: by 2002:a05:7301:3f18:b0:2ae:5b54:523e with SMTP id
 5a478bee46e88-2b856a456b1mr1389008eec.40.1770403099558; 
 Fri, 06 Feb 2026 10:38:19 -0800 (PST)
X-Received: by 2002:a05:7301:3f18:b0:2ae:5b54:523e with SMTP id
 5a478bee46e88-2b856a456b1mr1388996eec.40.1770403099037; 
 Fri, 06 Feb 2026 10:38:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c3c846sm2270605eec.16.2026.02.06.10.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:38:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH 3/3] target/hexagon: Return decode failure for invalid
 non-duplex encodings
Date: Fri,  6 Feb 2026 10:38:13 -0800
Message-Id: <20260206183813.2573541-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: sa-K_pRTalGw6htUUTbOUsrraS3oAzlJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNyBTYWx0ZWRfX/rv+nIsclXeZ
 o1nqtlcB/jJetVo3sURjmCJUOHnxe/wwAzTyW2b/cUginmsHi2Wm4b2cgUQO/emh+OaL2ERigK/
 GlC+kntO16gN39VaELlo83jkfYPI+EWTsTZr0THpH700zzT0X90Cw4W4I+ZFvHQAskkK4Kjtmm0
 mVsK7Kjt0sECaM0Ur+UTeWWNCm02hO5w8yTfF5yl2Nh5G3ayzhAgs2nElfcajVPBAd8cfCh7l9C
 pp952L2C77E1Kcc295LgWPHvuwlUIqHkiJNcGz5QE0OOFAtxF3U8cbk0HpEPHWMV9rXKhErs3OB
 mRNZgmk8AEYOJHt9ssPrw9z4zJRVVlw1w2P3BtkDlR5NVqG+kHkddogaGhZq/+pU0CeXDlG9GWv
 6a+Xpvod1bqeoULxOFKs3X+MBy1de4AOKy3+4W7s3aFpmnqBx12Ntgn6q0ybcBwkowAbBUqAJAj
 SDb15pyBhQImUlCy98A==
X-Proofpoint-ORIG-GUID: sa-K_pRTalGw6htUUTbOUsrraS3oAzlJ
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=6986351c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=JVcbmikgOCOOM7YXfUEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060137
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

V2hlbiBhIG5vbi1kdXBsZXggZW5jb2RpbmcgKHBhcnNlX2JpdHMgIT0gMCkgZmFpbHMgYm90aCBk
ZWNvZGVfbm9ybWFsKCkKYW5kIGRlY29kZV9odngoKSwgdGhlIGRlY29kZXIgaGl0IGFuIHVucmVh
Y2hhYmxlLiAgSW5zdGVhZCwgaGFuZGxlCnRoZSBkZWNvZGUgZmFpbHVyZSBhbmQgcmFpc2UgYW4g
ZXhjZXB0aW9uLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICB8ICAz
ICsrLQogdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jIHwgMjAgKysrKysrKysr
KysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCAgICB8ICA2ICsr
KysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYwppbmRleCA5MDQ5OWZjMzIwLi5lYmI0ZTAyYTE3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtNDg5LDcgKzQ4
OSw4IEBAIGRlY29kZV9pbnNucyhEaXNhc0NvbnRleHQgKmN0eCwgSW5zbiAqaW5zbiwgdWludDMy
X3QgZW5jb2RpbmcpCiAgICAgICAgICAgICBpbnNuLT5pY2xhc3MgPSBpY2xhc3NfYml0cyhlbmNv
ZGluZyk7CiAgICAgICAgICAgICByZXR1cm4gMTsKICAgICAgICAgfQotICAgICAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOworICAgICAgICAvKiBJbnZhbGlkIG5vbi1kdXBsZXggZW5jb2Rpbmcg
Ki8KKyAgICAgICAgcmV0dXJuIDA7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaWNs
YXNzID0gZ2V0X2R1cGxleF9pY2xhc3MoZW5jb2RpbmcpOwogICAgICAgICB1bnNpZ25lZCBpbnQg
c2xvdDBfc3ViaW5zbiA9IGdldF9zbG90MF9zdWJpbnNuKGVuY29kaW5nKTsKZGlmZiAtLWdpdCBh
L3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyBiL3Rlc3RzL3RjZy9oZXhhZ29u
L2ludmFsaWQtZW5jb2RpbmcuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAw
Li5lZmU5MTRiNGU0Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaW52YWxp
ZC1lbmNvZGluZy5jCkBAIC0wLDAgKzEsMjAgQEAKKy8qCisgKiBUZXN0IHRoYXQgaW52YWxpZCBu
b24tZHVwbGV4IGVuY29kaW5ncyBhcmUgcHJvcGVybHkgcmVqZWN0ZWQuCisgKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
Ky8qCisgKiBUaGUgZW5jb2RpbmcgMHhmZmZmYzAwMCBoYXMgcGFyc2UgYml0cyBbMTU6MTRdID0g
MGIxMSwgbWFraW5nIGl0IGEKKyAqIG5vbi1kdXBsZXggaW5zdHJ1Y3Rpb24gYW5kIHBhY2tldCBl
bmQuICBUaGUgcmVtYWluaW5nIGJpdHMgZG8gbm90IG1hdGNoCisgKiBhbnkgdmFsaWQgbm9ybWFs
IG9yIEhWWCBpbnN0cnVjdGlvbiBlbmNvZGluZywgc28gdGhpcyBzaG91bGQgcmFpc2UgU0lHSUxM
LgorICovCisKK2ludCBtYWluKCkKK3sKKyAgICBhc20gdm9sYXRpbGUoCisgICAgICAgICIud29y
ZCAweGZmZmZjMDAwXG4iCisgICAgICAgIDogOiA6ICJtZW1vcnkiKTsKKyAgICByZXR1cm4gMDsK
K30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldAppbmRleCA3MTk5ZTI5YTMwLi43OWViZmQ1NmNl
IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVz
dHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CkBAIC01Myw2ICs1Myw3IEBAIEhFWF9URVNU
UyArPSBodnhfaGlzdG9ncmFtCiBIRVhfVEVTVFMgKz0gaW52YWxpZC1zbG90cwogSEVYX1RFU1RT
ICs9IGludmFsaWQtZHVwbGV4CiBIRVhfVEVTVFMgKz0gaW52YWxpZC1kdXBzCitIRVhfVEVTVFMg
Kz0gaW52YWxpZC1lbmNvZGluZwogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwogCiBydW4tYW5k
LWNoZWNrLWV4Y2VwdGlvbiA9ICQoY2FsbCBydW4tdGVzdCwkMiwkMyAyPiQyLnN0ZGVycjsgXApA
QCAtNzQsNiArNzUsMTEgQEAgcnVuLWludmFsaWQtZHVwczogaW52YWxpZC1kdXBzCiAJCSQoUUVN
VSkgJChRRU1VX09QVFMpICQ8IDsgdGVzdCAkJD8gLWVxIDEzMiwgXAogCQlURVNULCBpbnZhbGlk
LWR1cHMgb24gJChUQVJHRVRfTkFNRSkpCiAKK3J1bi1pbnZhbGlkLWVuY29kaW5nOiBpbnZhbGlk
LWVuY29kaW5nCisJJChjYWxsIHF1aWV0LWNvbW1hbmQsIFwKKwkJJChRRU1VKSAkKFFFTVVfT1BU
UykgJDwgOyB0ZXN0ICQkPyAtZXEgMTMyLCBcCisJCVRFU1QsIGludmFsaWQtZW5jb2Rpbmcgb24g
JChUQVJHRVRfTkFNRSkpCisKIEhFWF9URVNUUyArPSB0ZXN0X2FicwogSEVYX1RFU1RTICs9IHRl
c3RfYml0Y250CiBIRVhfVEVTVFMgKz0gdGVzdF9iaXRzcGxpdAotLSAKMi4zNC4xCgo=

