Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FE0C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmr-0002CV-Ai; Thu, 06 Aug 2026 00:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmV-00028O-03
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmT-000461-GE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbISx170270
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lMrOYVV1lXui4kcopBU4l1JIok+w71OlrrEVUyncEEM=; b=M0pEMEcqJEqLurNB
 azY1nmQu6oaab5RIKonCJWNZmLPC+aboE6ldVw2/JmPeX82Wdus6vwC9BENcbhfv
 EgeXPgvAEMCldidwklHDHOsg8Y3l2pmaT6DRqJklBFuThCqxy6aAv5wYbwQhdSZx
 a4DKaQvrKm+oDhUCiDDtg5eiinPVOvPoaXphlfDp1ez7IQSo/X8nqCZmoVzj8/kJ
 3qV55MAuP6JlaeMqV1FeHRh128B4V8sEMkgZGxnQfr0LagMCNomujos/tWPz7i6Y
 CaGkjuQvUKZvPmn/53y5t/vSeMBjxQWZrcOxR7fS71qE2TEM4SBgLEQBjXwAz+EO
 POb/SA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5uk2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso22458755ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990751; x=1786595551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lMrOYVV1lXui4kcopBU4l1JIok+w71OlrrEVUyncEEM=;
 b=X0KrACkXioYCMSJFV7qXdyx2Hf2781dVF1r/RGnEJbTUegVQdOFSWvhtJj6Vw8xY9V
 Y4nrAJA0RjatSLbfrjoUP29pfhXI5zCqR/IwRZjPU5UE3Toa9DDUy2VG4NqzTeC72THp
 hUb39wuY4rX0l6i2OjklTQ3erdT3VFikv/Yw+soPxLXcyKqLl8SrJHazSvJDMAVZYayh
 8gL0PdrkJ+OfukEsw5Dg/+TzpWbqyfyU0vS+xqBxYyYe4MsziIW8POu919HupdtLa90c
 CdurL2f8s43WXXIkXCrAJChrcnIkR2qQAIo+jD2etqtajfjbALJ6t9lHO65g57k8qx/Z
 ls3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990751; x=1786595551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lMrOYVV1lXui4kcopBU4l1JIok+w71OlrrEVUyncEEM=;
 b=KTX7eC84vF44xi7QT5EZcMahCUbvbMx6YDvdwEOI0emSmN2xHWsgRkA648/eMi9x1H
 Wgm1DvO3SVLPvBh0f/Xrn8eZaE5tHingZ2wjqpvj91lvrsSPjemjfL14DDrxs0v1PCl2
 pE2VtZE3+VO/cHOi5s4iJqFo2mOTG2IonNC4FaQ3X4BGqYxDsTwT/rNg8D1T5GZMT8TY
 v74hSXQi+wD38+00aIW3FEMy/Zlecpw+V0xYuEybV1KR+tgQHNi4jgVOZhG6Ql2SVFRn
 rL3+BvY/iu4jK//hshrcMEu/8t2gkgW/0cwJkOcdEF9NbKgt3PVe8K/EG4aHkARUATDq
 +vIQ==
X-Gm-Message-State: AOJu0YzfKYNS4pLwcdJUfHweIniZrgtsyXGhxYxnLMuvcbE+JMfbI50E
 tY+sKggCuTMKDdqXwGuAY+Pl0w3tjeUjJFUSBiev6l6B+W936gLogEHV1VX6bx+e0HXN+5GHVbR
 p8shi9SBtulJgAy3HdV5XP/ncz1Auy15BRF83bujUKfvay0Jmhr2z8npw8lMhDggf+Q==
X-Gm-Gg: AR+sD10G7p/UEuo7IGaZXaO8r0+fFh3f4ejIwbHYeiK/A/wtMsN23HTlrGv003E+4cF
 on304K2eNu3rKBCWTC9hx9P+9ru20aFrvt8PRAdZS9JK9bem98xPssWB8kvGO1JN/sNYakuVGiI
 /2jL9kckNSWRfoI2BcRVllFZSRu4yiYpv+UAtrnUgHRu+K/pt6YoRwQQrVWTbzHRx/VyG6L6HMH
 txbE+95wfV1wGdnYYRiaN+QN9h8N1KfIYpYcxL95xdiUBHFgDYNrwTB7gzn2lydpvtSqBBdaZwI
 otS3pxK/eL3+GgCM526/eqG3uPOUmYA2I/l0U9IgtmsDE7WahIDRpeDUyeqKM+JnDyH3tEgPISZ
 negCLLyfBBYXU/SO2EKjnnv8zztTKPVg2Yc7NEqe2MLT6F0l1
X-Received: by 2002:a17:902:c40d:b0:2c9:9a19:df with SMTP id
 d9443c01a7336-2d0ca945b59mr130568755ad.18.1785990751150; 
 Wed, 05 Aug 2026 21:32:31 -0700 (PDT)
X-Received: by 2002:a17:902:c40d:b0:2c9:9a19:df with SMTP id
 d9443c01a7336-2d0ca945b59mr130568275ad.18.1785990750695; 
 Wed, 05 Aug 2026 21:32:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 4/6] target/hexagon: add GVec overrides for HVX absolute
 difference
Date: Wed,  5 Aug 2026 21:32:21 -0700
Message-Id: <20260806043223.3787083-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: XpsgEcUKCgoRCEXVOcqn9sQ7Kso79Sxd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfXxA8LFPOitHbU
 0IqfJ0mlI3HYFqBiVSgmheMCI0y+L2c7e/bhvSgHsJZYCgGOyQxK7nSEFlO5x0v4BaGLdpFgAXy
 i+ifjFnbQPsABLPmypeMaFNoYwSzak8XNwNm6j7hg5PbWKym1n32/4Xg25/WllLTCFvZxwn8t18
 qk0tMBcVCTfkjRIfGade59zHLy+7POgY7YRV/wwpIVuh/LFecV2QFBqp+ASObYY0nCATD/5BIZY
 6xG2xAZLIcRt06XUoADEUYhYKOV9uuobBJ7oX9QtObAk3t4Nq9eKiBcchOZZN1F/VmhLaFg7TBZ
 RMyoNgMPgIbcyJTu1EFu7Nh4yWTltEypoju7EVh5WzbxAqjDF7xsunhp7FSHH5LN/CiXSOtEo2b
 d1N797+ZPTbxQfXRilZancARNas9K9idA9NWv5uG3K0ETXkA/aTVsXDkJFMzfSC9XHGxNdgSidu
 HLDjXAlRkJDQyKCE3fA==
X-Proofpoint-ORIG-GUID: XpsgEcUKCgoRCEXVOcqn9sQ7Kso79Sxd
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a740e60 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bqCQIhKX8jNGfYgsMrQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfXwkSkh8SyZvO1
 KGzrWUon95situpn8rWzCS5Km1BdyUKbXXgkki1sg6BkJJHw+QfSOI2zubnh8oJ4t71mrQkWiGl
 yrVsvWi/sudkEMZJkUJXuoNCt1I3HvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060031
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgK
aW5kZXggZjg0M2ZlNGUyZTEuLjNjYjUyYzc2MWFlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX2h2eC5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKQEAgLTMz
Miw2ICszMzIsMjkgQEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXND
b250ZXh0ICpjdHgpCiAgICAgdGNnX2dlbl9ndmVjX211bChNT18xNiwgVmRWX29mZiwgVnVWX29m
ZiwgVnZWX29mZiwgXAogICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVD
VE9SX1NJWkVfQllURSkKIAorI2RlZmluZSBmR0VOX1RDR19WRUNfQUJTRElGRihWRUNFLCBNQVhf
Rk4sIE1JTl9GTikgXAorICAgIGRvIHsgXAorICAgICAgICBpbnRwdHJfdCB0bXBvZmYgPSBvZmZz
ZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZ0bXApOyBcCisgICAgICAgIE1BWF9GTihWRUNFLCB0bXBv
ZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUs
IFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgICAgIE1JTl9GTihWRUNFLCBWZFZfb2ZmLCBWdVZf
b2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1Jf
U0laRV9CWVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfc3ViKFZFQ0UsIFZkVl9vZmYsIHRt
cG9mZiwgVmRWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZ
VEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBmR0VO
X1RDR19WNl92YWJzZGlmZnViKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BQlNESUZG
KE1PXzgsIHRjZ19nZW5fZ3ZlY191bWF4LCB0Y2dfZ2VuX2d2ZWNfdW1pbikKKworI2RlZmluZSBm
R0VOX1RDR19WNl92YWJzZGlmZnVoKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BQlNE
SUZGKE1PXzE2LCB0Y2dfZ2VuX2d2ZWNfdW1heCwgdGNnX2dlbl9ndmVjX3VtaW4pCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdmFic2RpZmZoKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19B
QlNESUZGKE1PXzE2LCB0Y2dfZ2VuX2d2ZWNfc21heCwgdGNnX2dlbl9ndmVjX3NtaW4pCisKKyNk
ZWZpbmUgZkdFTl9UQ0dfVjZfdmFic2RpZmZ3KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZF
Q19BQlNESUZGKE1PXzMyLCB0Y2dfZ2VuX2d2ZWNfc21heCwgdGNnX2dlbl9ndmVjX3NtaW4pCisK
IC8qIFZlY3RvciBzaGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9U
Q0dfVjZfdmFzcmgoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

