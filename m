Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF31C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SNA-0005at-Q1; Tue, 01 Sep 2026 13:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN8-0005ZT-7O
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN6-00082F-9a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HY5cn3285336
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LA3LpPUcsAsJJH0v7IALoyhsek3de2dSlP0tKUJxcdc=; b=lAMcI6JBQwFmPto6
 QVNtbw4m4Q4SSMaMl6HDhD2U3vYIRAZ3BNiVhnDJ0yFxI7l3IL23BFOVHzwM3Ys0
 mZ8mQOpF3O1R2nsfytNOIwS/A7FTNNHJW7VI3FYIXFUWZ7J6ZVPtK2eQ7ml5niYF
 rQv1L4P87HPdcGqWaUQuo3MQEtiIoRkA4kPYQ+I2nxdB/zR97hbEAj/L1k4Lgik9
 DHMEkZbhdOj0lzVW9P5smwhmqw0eluCu84s7yAF4vnHQmZ/GoCGklj4wpGZevlsh
 gF8FDaj9F4Cg/Ymoz+mfK1nQClRMck1uXhh66+oDFuiqh9FdkUO8MK4dUABzpIZ9
 W4RExg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j000k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so201209a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284046; x=1788888846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LA3LpPUcsAsJJH0v7IALoyhsek3de2dSlP0tKUJxcdc=;
 b=TExzt87Y+Q2nAJ+hmD9zfPBqY/nVnQ7lYW3aeqA0ScOukr3MQUK0C7w0Jw/o/NfHyQ
 X6F+0shbdFoGnPvjMxexL8gs8MSchJWQN8nF9CNIdplpUEza1JgkS1DuZHCj15m1MP+5
 yy1welOFctnWpj4eSi3EkeMSzQuQljgY4BxCpwNB/zrU5FpaWmfjfAqNYcOb/EaLiBns
 TAtj/fIR71ARgndR6V3/iE5yaqaMnTXqvCZodJjwFWv+tYlR3xpkZAQOuq78AsNgMjrH
 /J/dEs9KeTjMdr47nepDcAnQ+Frex2qXNdl6uNxe6krIKFJvXo9O8gOUQ43hgjCU86a8
 4flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284046; x=1788888846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LA3LpPUcsAsJJH0v7IALoyhsek3de2dSlP0tKUJxcdc=;
 b=F9RL2ZKXxYbpr9NinyXFe0iaEXJtTyZ19srD9VhUDXtJk6Sz94b4Pf4mB61ne8uTr1
 Tv7WVNqGUasFwFSgWfYVZwiXy+JLNMi0qHIinhcrKeRxt/NbpnrHv0+p3Foj6Ump03fd
 S6q6JJynW/rg3Qad0/xmpjcrG2hzDe49v/aqDkj2rW2wvqZ3P37wB2BZoEY29AFDxWAJ
 VLz4MEAnlxZ8USTpS6SYJmsl86FQYHTzq73QQURW/jUD2FA0MwhH8966hd/wHdzmKzbl
 lu2euOLeRUqpQ7OnPfuFYN/GBjoDktyL+MNjLdudsE/xFjETBOvgWBFnh1HxP7NcPSUm
 Ssug==
X-Gm-Message-State: AFuF++nnkJw2YVLfMiGKT8cEJU91kdhi4CKEHbe8oKQbHaO5gmcq52Q9
 Px6f+U1eoUjfd99OYdgm7sSSJqTHcmN+ClM1f7Q3hC1e2rb4dZySspLgJhoI94nvCTxu2+SIjo7
 Wnm8Lta06iTip38mrIMAzlKcBJ1pnxxq/9MBJm/M9LoN3F0JSRN7k0UK2Z4gIwmSMYg==
X-Gm-Gg: AYBFou2R152GCYr+fKIb231WoDMn4xhlgfxS3F0l21Ex1uy06oZ6ihiIAbwhYC5VYey
 uOjBhTK4yDn8KSC33h1pk8CzEmyR8G7Kx16yU4SdPwiHu8T4sBIpLc7M2WLF16nBPFRHPTnwKNF
 cDlfgMhLwZiMCsJwOEMCE0HHo9AOnYrzLeI3q6Yel7hrOUv/K3YZ+woq/2BlXNb9a4V0y/v1aaA
 FQ4qmn0fhluMhjVTe+wqqjoKDICjYxFEVQYJeHcrw/zL/07IPF8vv3a/XhKUqpecduPMtQz93AZ
 RhIPwydWqMC0bYgvRmBeNnBUuhANWJhExnaYb21uYWD75WjEqRbZwr7p2GYZQ+AOF1gEtxteFAC
 nBRTrpD1nFgWt3bcLZUGrF3Jw58MzXIAnEoUP2/NWL46vwI6t
X-Received: by 2002:a17:90b:17cc:b0:398:d8eb:cb2a with SMTP id
 98e67ed59e1d1-398d8ebcd21mr21258596a91.23.1788284045616; 
 Tue, 01 Sep 2026 10:34:05 -0700 (PDT)
X-Received: by 2002:a17:90b:17cc:b0:398:d8eb:cb2a with SMTP id
 98e67ed59e1d1-398d8ebcd21mr21258507a91.23.1788284045070; 
 Tue, 01 Sep 2026 10:34:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:34:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 07/11] target/hexagon: read UTIMERLO/UTIMERHI from the
 global timer
Date: Tue,  1 Sep 2026 10:33:49 -0700
Message-Id: <20260901173353.200474-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: uMtElhgjsxy-lMOyp8yuPW0qUCUpyFoi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX1Or86lHnmiZx
 J2dAAoyMiLHkUyVbtQPmATWDQcfPrRlhpWL/6+S+GlCH88wvPFQWfd4ICrKhlqbXsr+ncSCz82M
 +E+I9BFguyPYyOoLBTsCh6nXA8cyLvw=
X-Proofpoint-ORIG-GUID: uMtElhgjsxy-lMOyp8yuPW0qUCUpyFoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX213QytYJnEyg
 PtKxGFzPLSgV4oQvzl0nsE9OAhG6h3cNbQDBwQUJmvRIRMmoamGvybFXqxzuzCq6uJY2xlHDgBO
 G4E/PGT3SnGj8N/EnLLP8RSHbFPcJzo+wqWcOT1iTBGUuBbIH3Oqp4pe/Q2uXD7aj3KlUefiFyk
 m8QMML1yzGlwiY/pqy8l0VmKCaNvXMj0sT00bFNIE0wOydxkwda8kqK6siG2fJG4SPQrzwxIkMc
 +hd4WygppImrScyLcnvxOYVAkIN60Idk9Y8tipTUJSA8Jw/ewEb9VqlQh/xc0yMtBYWN6m2k9k4
 6YDfEqVvbk4mTJylFuphFg6lBq0EcCeRS9ejSvQOw4+mtM0igCTHBTqqJEERoII5GjyNmM9wipV
 dKGgMCcQivfuN/aDdFwBzZWCBbaXfH6ZOuBPxkEbyKddS73Pkw6vF3w7lvLT/66zKWrtfPVYuJh
 EpBWSGlA1GLAPv5GrUw==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a970c8e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=q_fxtLUCAn1J2UUIEkUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
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

SW4gc3lzdGVtIG1vZGUsIHJvdXRlIGFjY2Vzc2VzIHRvIHRoZSBxdGltZXItYmFja2VkIGdsb2Jh
bApUSU1FUkxPL1RJTUVSSEkgc28gZ3Vlc3QgcmVhZHMgc2VlIGEgbGl2ZSwgbW9ub3RvbmljYWxs
eSBpbmNyZWFzaW5nCnRpbWVyLgoKSW4gdXNlciBtb2RlIHdlIGRlcml2ZSBpdCBmcm9tIFFFTVVf
Q0xPQ0tfVklSVFVBTC4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFu
LmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAg
fCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgfCAyOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgMjEgKysrKysr
KysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9yZWdfbXV0LmMgfCAxMSArKysrKysr
Ky0tLQogNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNzhkYzI4Y2E5ZTUuLmUzOWFmZDYyM2I1IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTEzLDYg
KzExMywxMCBAQCBERUZfSEVMUEVSX0ZMQUdTXzQoZ3ZlY19zYWJzZGlmZl93LCBUQ0dfQ0FMTF9O
T19SV0csIHZvaWQsIHB0ciwgcHRyLCBwdHIsIGkzMikKIERFRl9IRUxQRVJfRkxBR1NfNChndmVj
X3VhYnNkaWZmX2IsIFRDR19DQUxMX05PX1JXRywgdm9pZCwgcHRyLCBwdHIsIHB0ciwgaTMyKQog
REVGX0hFTFBFUl9GTEFHU180KGd2ZWNfdWFic2RpZmZfaCwgVENHX0NBTExfTk9fUldHLCB2b2lk
LCBwdHIsIHB0ciwgcHRyLCBpMzIpCiAKKyNpZiBkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitE
RUZfSEVMUEVSX0ZMQUdTXzAodXRpbWVyLCBUQ0dfQ0FMTF9OT19SV0csIGk2NCkKKyNlbmRpZgor
CiAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKIERFRl9IRUxQRVJfMyhyYWlzZV9zdGFj
a19vdmVyZmxvdywgdm9pZCwgZW52LCBpMzIsIGkzMikKIERFRl9IRUxQRVJfMihzd2ksIHZvaWQs
IGVudiwgaTMyKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQv
aGV4YWdvbi9nZW5wdHIuYwppbmRleCAyYTk4YjEzYjcxNC4uMjgyYTY5N2QxOTAgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5j
CkBAIC00MTEsNiArNDExLDIzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBnZW5fcmVhZF9jdHJsX3Jl
ZyhEaXNhc0NvbnRleHQgKmN0eCwgY29uc3QgaW50IHJlZ19udW0sCiAgICAgfSBlbHNlIGlmIChy
ZWdfbnVtID09IEhFWF9SRUdfUUVNVV9IVlhfQ05UKSB7CiAgICAgICAgIHRjZ19nZW5fYWRkaV90
bChkZXN0LCBoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhfQ05UXSwKICAgICAgICAgICAgICAgICAg
ICAgICAgIGN0eC0+bnVtX2h2eF9pbnNucyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAg
ICB9IGVsc2UgaWYgKHJlZ19udW0gPT0gSEVYX1JFR19VVElNRVJMTykgeworICAgICAgICBnZW5f
aGVscGVyX3NyZWdfcmVhZChkZXN0LCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0Y2dfY29uc3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSTE8pKTsKKyAgICB9IGVsc2UgaWYg
KHJlZ19udW0gPT0gSEVYX1JFR19VVElNRVJISSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdf
cmVhZChkZXN0LCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y2dfY29u
c3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSSEkpKTsKKyNlbHNlCisgICAgfSBlbHNlIGlmIChyZWdf
bnVtID09IEhFWF9SRUdfVVRJTUVSTE8pIHsKKyAgICAgICAgVENHdl9pNjQgdXRpbWVyID0gdGNn
X3RlbXBfbmV3X2k2NCgpOworICAgICAgICBnZW5faGVscGVyX3V0aW1lcih1dGltZXIpOworICAg
ICAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIoZGVzdCwgdXRpbWVyKTsKKyAgICB9IGVsc2UgaWYg
KHJlZ19udW0gPT0gSEVYX1JFR19VVElNRVJISSkgeworICAgICAgICBUQ0d2X2k2NCB1dGltZXIg
PSB0Y2dfdGVtcF9uZXdfaTY0KCk7CisgICAgICAgIGdlbl9oZWxwZXJfdXRpbWVyKHV0aW1lcik7
CisgICAgICAgIHRjZ19nZW5fZXh0cmhfaTY0X2kzMihkZXN0LCB1dGltZXIpOworI2VuZGlmCiAg
ICAgfSBlbHNlIHsKICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoZGVzdCwgaGV4X2dwcltyZWdfbnVt
XSk7CiAgICAgfQpAQCAtNDM5LDYgKzQ1NiwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3Jl
YWRfY3RybF9yZWdfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgY29uc3QgaW50IHJlZ19udW0sCiAg
ICAgICAgIHRjZ19nZW5fYWRkaV90bChodnhfY250LCBoZXhfZ3ByW0hFWF9SRUdfUUVNVV9IVlhf
Q05UXSwKICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+bnVtX2h2eF9pbnNucyk7CiAgICAg
ICAgIHRjZ19nZW5fY29uY2F0X2kzMl9pNjQoZGVzdCwgaHZ4X2NudCwgaGV4X2dwcltyZWdfbnVt
ICsgMV0pOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgfSBlbHNlIGlmIChyZWdfbnVt
ID09IEhFWF9SRUdfVVRJTUVSTE8pIHsKKyAgICAgICAgVENHdiBsbyA9IHRjZ190ZW1wX25ldygp
OworICAgICAgICBUQ0d2IGhpID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgIGdlbl9oZWxwZXJf
c3JlZ19yZWFkKGxvLCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSTE8p
KTsKKyAgICAgICAgZ2VuX2hlbHBlcl9zcmVnX3JlYWQoaGksIHRjZ19lbnYsIHRjZ19jb25zdGFu
dF9pMzIoSEVYX1NSRUdfVElNRVJISSkpOworICAgICAgICB0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0
KGRlc3QsIGxvLCBoaSk7CisjZWxzZQorICAgIH0gZWxzZSBpZiAocmVnX251bSA9PSBIRVhfUkVH
X1VUSU1FUkxPKSB7CisgICAgICAgIC8qIE9uZSBoZWxwZXIgY2FsbCwgc28gdGhlIHBhaXIgaXMg
YSBjb2hlcmVudCA2NC1iaXQgc25hcHNob3QuICovCisgICAgICAgIGdlbl9oZWxwZXJfdXRpbWVy
KGRlc3QpOworI2VuZGlmCiAgICAgfSBlbHNlIHsKICAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMy
X2k2NChkZXN0LAogICAgICAgICAgICAgaGV4X2dwcltyZWdfbnVtXSwKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5k
ZXggMmNlYTE5MjcyNjMuLmRmMzFlZDI0ODhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMzcsNiArMzcs
OSBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNpbmNsdWRlICJ0Y2cvdGNnLWd2ZWMtZGVz
Yy5oIgogI2luY2x1ZGUgInRyYW5zbGF0ZS5oIgorI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyNp
bmNsdWRlICJxZW11L3RpbWVyLmgiCisjZW5kaWYKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQog
I2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKICNpbmNsdWRlICJoZXhf
bW11LmgiCkBAIC00Niw2ICs0OSwyNCBAQAogI2luY2x1ZGUgImhleHN3aS5oIgogI2VuZGlmCiAK
KyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCisvKgorICogVXNlciBtb2RlIGhhcyBubyBxdGltZXIg
ZGV2aWNlIGJhY2tpbmcgVElNRVJMTy9USU1FUkhJLCBzbyBkZXJpdmUgdGhlCisgKiB1c2VyIHRp
bWVyIGRpcmVjdGx5IGZyb20gdGhlIHZpcnR1YWwgY2xvY2sgLS0gdGhlIHNhbWUgY2xvY2sgdGhl
IHF0aW1lcgorICogY291bnRzIC0tIGF0IHRoZSBxdGltZXIncyBkZWZhdWx0IDE5LjJNSHogdGlj
ayByYXRlLCBtYXNrZWQgdG8gdGhlCisgKiBxdGltZXIncyBjb3VudGVyIHdpZHRoLgorICovCisj
ZGVmaW5lIEhFWF9VVElNRVJfRlJFUV9IWiAgMTkyMDAwMDBVTEwKKyNkZWZpbmUgSEVYX1VUSU1F
Ul9DTlRfTUFTSyAweDAwZmZmZmZmZmZmZmZmZmZVTEwKKwordWludDY0X3QgSEVMUEVSKHV0aW1l
cikodm9pZCkKK3sKKyAgICByZXR1cm4gbXVsZGl2NjQocWVtdV9jbG9ja19nZXRfbnMoUUVNVV9D
TE9DS19WSVJUVUFMKSwKKyAgICAgICAgICAgICAgICAgICAgSEVYX1VUSU1FUl9GUkVRX0haLCBO
QU5PU0VDT05EU19QRVJfU0VDT05EKSAmCisgICAgICAgICAgIEhFWF9VVElNRVJfQ05UX01BU0s7
Cit9CisjZW5kaWYKKwogI2RlZmluZSBTRl9CSUFTICAgICAgICAxMjcKICNkZWZpbmUgU0ZfTUFO
VEJJVFMgICAgMjMKIApkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jIGIv
dGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jCmluZGV4IGM1YTM5ZTU1MTAwLi45Y2UxOGYzZWJl
NSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jCisrKyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL3JlZ19tdXQuYwpAQCAtNzcsMTAgKzc3LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCB3cml0ZV9jb250cm9sX3JlZ2lzdGVycyh2b2lkKQogICAgIGNoZWNrMzIocmVzdWx0LCAweDAw
MDAwMDAwKTsKIAogICAgIFdSSVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAidXRpbWVybG8iLCAw
eGZmZmZmZmZmKTsKLSAgICBjaGVjazMyKHJlc3VsdCwgMHgwMDAwMDAwMCk7CisgICAgY2hlY2sz
Ml9uZShyZXN1bHQsIDB4ZmZmZmZmZmYpOwogCiAgICAgV1JJVEVfUkVHX05PQ0xPQkJFUihyZXN1
bHQsICJ1dGltZXJoaSIsIDB4ZmZmZmZmZmYpOwotICAgIGNoZWNrMzIocmVzdWx0LCAweDAwMDAw
MDAwKTsKKyAgICBjaGVjazMyX25lKHJlc3VsdCwgMHhmZmZmZmZmZik7CiAKICAgICAvKgogICAg
ICAqIFBDIGlzIHNwZWNpYWwuICBTZXR0aW5nIGl0IHRvIHRoZXNlIHZhbHVlcwpAQCAtMTA2LDgg
KzEwNiwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgd3JpdGVfY29udHJvbF9yZWdpc3Rlcl9wYWly
cyh2b2lkKQogICAgIFdSSVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAiYzE1OjE0IiwgMHhmZmZm
ZmZmZmZmZmZmZmZmKTsKICAgICBjaGVjazY0KHJlc3VsdCwgMHgwMDAwMDAwMDAwMDAwMDAwKTsK
IAorICAgIC8qCisgICAgICogYzMxOjMwIGlzIFVUSU1FUkhJOlVUSU1FUkxPLCBhIHJlYWQtb25s
eSBmcmVlLXJ1bm5pbmcgY291bnRlci4gIFRoZQorICAgICAqIHdyaXRlIG11c3QgYmUgZGlzY2Fy
ZGVkOyB0aGUgcmVhZC1iYWNrIGlzIHdoYXRldmVyIHRoZSB0aW1lciBzYXlzLAorICAgICAqIHNv
IG9ubHkgY2hlY2sgdGhhdCB0aGUgd3JpdHRlbiB2YWx1ZSBkaWQgbm90IHN0aWNrLgorICAgICAq
LwogICAgIFdSSVRFX1JFR19OT0NMT0JCRVIocmVzdWx0LCAiYzMxOjMwIiwgMHhmZmZmZmZmZmZm
ZmZmZmZmKTsKLSAgICBjaGVjazY0KHJlc3VsdCwgMHgwMDAwMDAwMDAwMDAwMDAwKTsKKyAgICBj
aGVjazY0X25lKHJlc3VsdCwgMHhmZmZmZmZmZmZmZmZmZmZmKTsKIAogICAgIFdSSVRFX1JFR19Q
QUlSX0VOQ09ERUQocmVzdWx0LCAiYzk6OCIsICh1aW50NjRfdCkgMHgwMDAwMDAwMDAwMDAwMDAw
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgQzlfOF9FUV9SMV8wKTsKLS0gCjIuMzQuMQoK

