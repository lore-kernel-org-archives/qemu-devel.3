Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA74C79F8B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weH-0001Ti-78; Sat, 05 Sep 2026 16:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weF-0001TD-GM
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:05:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weD-00060Z-C4
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:05:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HblXp2297303
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=w1MfoewwaYL
 +2UY83+MJLG7ypvRZnEvlWq9T2CpsVrE=; b=U3T+1TFnrhhj2iMKpHjJpFYNbpD
 BRMnwSfad/1YvLWmBAxsbqQ/B+kfkPIDlwXfyX4s+GO1D3L9WYNdGGomoY2ongRy
 wrQsdeeWGIGP5bY/UkPk6S6B9cnucHgVGCI4LxZ9qf6UTclD6ngsYtlKXjlOnUjS
 YME5xmO+O/zh1YUBanaYEWZ2E0w73Bq7nM6eWbEB//Vt6y21Xkmxu8EWhNbJ+1Sn
 xnNYOKutIUxJAw5bw1csEIBXABSes1fhYtMOHjlfb9c57fd9QK+zvx18HPN8n7W7
 BzHXmvNSAtnrUNGIG9eSTIkhq9N3qmXmW9o2Xuhcmhea1KgTLCqqR32vn7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggcca1xr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:05:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so3282928a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638754; x=1789243554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w1MfoewwaYL+2UY83+MJLG7ypvRZnEvlWq9T2CpsVrE=;
 b=W3y4Pb9/6aZDL70HQoCFmy3KfC4/Nyo6amqV2VcQLGBUICYfOqhsDP58HlnUZYLaR8
 X1Lp5WlmTKmd/JJ1mFLurM+quyW+BZFNEmqvOBLwBMM52A+Vc57eZX63inNJtEPWQ09/
 nSGHXX39FB9fitBfcrwovr0facKYY6xQ6M0TiDdTRDc9h7HZ6A8z6Q9dcl//zvSYJ+Mi
 joxTv6piSOpS7Be9r2+fhc42Pb4tEMq6bphB6nqMIiMes1puhfkW6a5i9RGwWm1yPqaK
 aXCUJKkhvHtumf+Hybi2NgeDQswyig2yE+VIprUsvFwDXPxpOU218TvGUZjFG5ZYWzLp
 Rzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638754; x=1789243554;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w1MfoewwaYL+2UY83+MJLG7ypvRZnEvlWq9T2CpsVrE=;
 b=bonp3BpwnV+OMXTaIyYytvPPwyADnVISxGYuJ7mHp6/xuOGcJkES/ZPCpYYEazBcUp
 W7A4Cxo4xr+BThgZkSju/cKTf8AyX+UoLuVARlVpWVnNv1WjhTFh/VVFSCdPXOl/m/x1
 +KdEI+WYlIPgVxK3F33UyQsMWMBj3d2WqijLd0s4sOu1Hi0zVxa9k2GUyD/OsG8/gZ+e
 E062C2IoZg1Yf9KIYnai0VirIG53lXeZlUw0om1YZIx7Ji3qAXyxV1vehjb9x3dKDHmy
 evnvahu3+FoK8iPmcbdVxp6C5z45HAZScdis2xBdR+8PQxycdFoLG+Ff8Fk9ngLQifTL
 fNjQ==
X-Gm-Message-State: AFuF++krU8Og5oEWqUdPN/M2Ye5/FrvKYHeV1LxEvY+LtqA2kKuXcYr9
 Z0DJeYzcylfXIAMPRPHGZdCLzVaH86XP6sPnwhLmFJQQqGoc3ua5IXLN6m5IVACNdFXsd/hPs46
 5oPXx39wt1/T8xWAN3mZCCh8rb+ikEKLWDWATl6SkcS8+XYPBWV8k4MWzToeR+CGsRg==
X-Gm-Gg: AYBFou2N+2aeokBMweLTVa+RDPm8rEiWEsiqHPRQ36QggSQ3YeV5sLUfeedm7/+p5ku
 y8oU0YHkV3oc87r2QVvgjJhgkFlouWr85jlO40W6p4FAHyn6QImp7eS4nFtuVFI+0hrCpxrUZid
 Hp/gSFlxWXbkZiw6Hda+w7kD+RSFSYPI2mWtYeKSfLChx/K8AQGn1VaGFrNsBTIbVAfujuOoz5Z
 /5WqDdKK9UzYs2YoLvCQw5XbmhxjkjNO6ETqIMHuEWYTO0gxdRtS/Y0w0Nt0eIqhuglWkFZGtxR
 rob/p4sPA8fO7ktdWBVc0qTbB9vJjuPmvV3hH5f1ou3g4YY7qJNvCqNiJfftN6Uhsg6AqkgskmZ
 BXrlYomOljHGA7lcONpGGglEp6cyKZSFWU4IMncnXVHWm+h9+
X-Received: by 2002:a17:90a:e18b:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39b26155274mr20057797a91.10.1788638754225; 
 Sat, 05 Sep 2026 13:05:54 -0700 (PDT)
X-Received: by 2002:a17:90a:e18b:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39b26155274mr20057735a91.10.1788638753636; 
 Sat, 05 Sep 2026 13:05:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:05:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/9] hex queue
Date: Sat,  5 Sep 2026 13:05:41 -0700
Message-Id: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: KMbhpvlojii1YOtg4EeAI2yQuHt-YrLS
X-Authority-Analysis: v=2.4 cv=EJo2FVZC c=1 sm=1 tr=0 ts=6a9c7622 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=u77sMaEyKMBnUSgVVTcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: KMbhpvlojii1YOtg4EeAI2yQuHt-YrLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX6oDBv+zoU8iG
 8O47xmr5NDdqqtDklqlE4l5TA834gTgL3zdsddo1cgsvsvGuqtNmlIetNSbAXeZi1JEYqDx/NZb
 1MRqXWZwYbzZ6rDmi++rn9motw5cfvtKd30dfnfkirql5LOR1+gSg9T0w6DI6xrvLZi5P816zHG
 IP+eyycjECnrgKQ7KMnWIUtjNTijy2cEHptjxu5ASCojWXxYOde+I6Z2xZXIh812bX9R1RCrrrD
 fUiuny3yJzJqSPoOqmYAIOI18BVN6Db7xfkmI3DCJ/1zEedY1Z+kG4GpvmZZ/nILRN84F8Cwb7g
 ZD7hdAgFqp2Y0kAo7yL8i0okA8SKWZOjBB5nOG9pbWT+aFc6/X7CSzqdYOfmanZNeZc4ALbmAEq
 8r6h6pee1VhcJ9SgbfKWNbX+NaZqd6QQq4pxgZtlthSFyR7jNdtSYm8JMf3RtWYRWbjmmC+DoIl
 dViQM/YQgKFjLqORkKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfXxNHbYx7qjmrW
 8uUf6882e77jKNrmUG0N1/psA2y1dnb1uov7Learm9geYD9Kkvcpgru6+1k7WfOZLCgHnieUePE
 unGVE2yTLl7QKot9JTHlbd1XvTxa96E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050223
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmZjFkMmQxOWQ3ZTI0ODkzZTIwMTJk
ODc5ZjhlNzMwNzdlMTdiOWJkOgoKICBNZXJnZSB0YWcgJ3B1bGwtMTEuMS1jaGVjay10Y2ctbWVz
b24tMDQwOTI2LTInIG9mIGh0dHBzOi8vZ2l0bGFiLmNvbS9zdHNxdWFkL3FlbXUgaW50byBzdGFn
aW5nICgyMDI2LTA5LTA0IDE2OjUyOjU4ICswMTAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11IHRhZ3Mv
cHVsbC1oZXgtMjAyNjA5MDUKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBkZmFkNmY5
ZmYxYTQ2MDA4OTNlZjZiM2MyMTM4MjIyNWU2MDQ1MzVlOgoKICB0YXJnZXQvaGV4YWdvbjogZGVj
b2RlIHRoZSBETUEgaW5zdHMgYXMgdW5pbXAgKDIwMjYtMDktMDUgMTI6MDQ6MDEgLTA3MDApCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCmhleGFnb246IFRMQiwgYmFkdmEgZml4ZXMgKyBETUEKCkFkZCBmaXhlcyBmb3IgVExC
LCBiYWR2YSBiZWhhdmlvciBhbmQgYW4gdW5pbXAgcGxhY2Vob2xkZXIgZm9yIHRoZQpETUEgaW5z
dHJ1Y3Rpb24gc2V0LgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpCcmlhbiBDYWluICg5KToKICAgICAgaHcvaGV4YWdvbjog
cmVnaXN0ZXIgdGhlIFY2OE5fMTAyNCBtYWNoaW5lCiAgICAgIHRhcmdldC9oZXhhZ29uOiByZWFk
IEJBRFZBIGFzIGFuIGFsaWFzIG9mIEJBRFZBMC8xCiAgICAgIHRhcmdldC9oZXhhZ29uOiBraWNr
IHZDUFUgd2hlbiByZS1hc3NlcnRpbmcgaW50ZXJydXB0cwogICAgICBody9pbnRjOiBuYW1lIHRo
ZSBMMlZJQyBlZGdlIHRyaWdnZXIgY2hlY2sKICAgICAgdGFyZ2V0L2hleGFnb246IGFzc2VydCBn
dWVzdCByZWdpc3RlciBwYWlyIGFsaWdubWVudAogICAgICBoZXhhZ29uOiByYWlzZSBpbXByZWNp
c2UgZXhjZXB0aW9uIGZvciBtdWx0aS1UTEIgbWF0Y2hlcwogICAgICB0ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb246IGFkZCB0ZXN0cywgdXBkYXRlIHRvIHYwLjIuMTQKICAgICAgdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uOiB1cGRhdGUgYXJjaCB0ZXN0cyB0byB2MC4yLjE0CiAgICAgIHRhcmdldC9o
ZXhhZ29uOiBkZWNvZGUgdGhlIERNQSBpbnN0cyBhcyB1bmltcAoKIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2cuaCAgICAgICAgICAgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwgMjMgKysr
KysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vaGV4YWdvbl90bGIuYyAgICAgICAgICAg
ICAgICAgICAgfCAxMCArKysrKysrKysrCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTMgKysrKysrKysrLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMg
ICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRz
LmMgICAgICAgICAgICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jICAgICAgICAg
ICAgICAgICAgICB8IDEyICsrKysrKysrKy0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAg
ICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAg
ICAgICAgICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAg
ICAgICAgICAgICAgICAgfCAyMiArKysrKysrKy0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdv
bi90YWdfcmV2X2luZm8uYy5pbmMgICAgICAgICAgIHwgMTAgKysrKysrKysrKwogdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZiAgICAgICB8IDExICsrKysrKysrKysrCiB0YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZiAgICAgICAgIHwgMTEgKysrKysrKysrKysK
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgNiArKystLS0K
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5ICAgfCAxNyArKysrKysr
KysrKysrLS0tLQogMTUgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKyksIDI5IGRlbGV0
aW9ucygtKQo=

