Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA4FCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 00:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYCKj-0007Xg-Ln; Fri, 12 Jun 2026 20:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wYCKh-0007XD-2D; Fri, 12 Jun 2026 20:34:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wYCKe-0006ns-Vt; Fri, 12 Jun 2026 20:34:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CNLMAj3113361; Sat, 13 Jun 2026 00:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2m6DPr+AuQQQSCNQl
 PMiXGlvYGuLdakrZ+nFlps0/iQ=; b=kJ9ED9y4oPAprMISSllkoZoBX3O0+fs3V
 INdi7JxYEUK9fW2efaJJ8tmHKOwcOniz1bdA0+AlbFmywC4eCXlq5XjazKGTm5wH
 7y0gSAuoMgr0BTTB2DtKr3Z5D5tdRpP7xilO+zhV78BZs9TU/dzhk/MqLD18QbLH
 wQ/vFDhks46kLl7wMINMGEUjWkDN+dE6jsu5SZxA6Ox24HEHhBfw19hDYviScnvd
 iinaxDHcBwBZdVzOOPQ4fqjyDnWwSVNy3Bzc9KHP3eVK9cj3bRfICnZtDrdDggZC
 QhUko0wc5kesAJ9fvuqF44M+bWaGqwP+gdEsO7NCn4mltxpVnxYSQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8aty58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 00:34:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65D0JdD8017722;
 Sat, 13 Jun 2026 00:34:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09t890-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 00:34:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65D0YQS03408522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2026 00:34:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D4475807A;
 Sat, 13 Jun 2026 00:34:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03FB058071;
 Sat, 13 Jun 2026 00:34:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.131])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2026 00:34:23 +0000 (GMT)
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: deller@kernel.org, harshpb@linux.ibm.com
Cc: deller@gmx.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Implement /proc/cpuinfo for ppc cpus
Date: Sat, 13 Jun 2026 06:04:14 +0530
Message-Id: <20260613003414.23336-1-misanjum@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260609220929.83951-1-deller@kernel.org>
References: <20260609220929.83951-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -7HrXVDzbu2WigHve8pSsom_WMkNMjZD
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2ca594 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GtmRUcFNR2mHwVtkHvcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIzMCBTYWx0ZWRfX+qGla0OK6Is1
 jEu4yLyuDh8sRpRbTlMz2KPjGGcCHbRLHz5xCRg8Xc8qlKirw5zIwUHwGbT5fXUxsBVYTonWo4h
 hgJFCv5uFBuk+GfhUC33GUsusLuw99RYrSCUvgOjtoF5S9NfwHIWkwJXwmzN7lQHdhPjX9nB5Af
 AiDEJmXEf6NglZvo572maHvy0D1YvVAJwS11EdL/q+Rmkq+/k0Ljcz0kXoNqmyBxaWhpSwRIDvy
 Uj5gyVD6OI7zScOwQfuW8QpcUGTbdu4OiBN1HQsc7zk0cPTXLcjO4pZSe/v8ZJm0c5G26FrN8rs
 uYZJNIHGsZDJCzRRftwn1D01u44AT5eqClH1zCrlFtqJQ3V1dUj77/88QH7yzWWWlDr0PtCzvwl
 nzjCSIRjI1wubRpCHFNi54EQeHqgr3l3G2IBTzPu9VLBjqkhko3XdOl+rUKkAbvc+Da+/2r1Wdb
 RWNCKeFmw2rAs0GTLFA==
X-Proofpoint-GUID: Z7FlYoIF6IqEnJIHnObkwJat4Wfplw52
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIzMCBTYWx0ZWRfXz2x3a+2W6Ers
 f8GLsIZwOEi+K1UyZjKE+FkPszhoecM7hGG72n/Y5nwk9tV1JDhV4p53vcFmNbKGwyH7qWDtQRL
 cAZ79Y0MFkJHmB3L/7KqIeiuUXmWgpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120230
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Built and tested qemu-ppc64le on ppc64le host

Test environment:
- Host: ppc64le Linux (POWER10)
- QEMU version: v11.0.50 (v11.0.0-1849-g193963218a-dirty) - upstream qemu with patch applied
- Target: ppc64le-linux-user

Manual tests performed:
- Verified /proc/cpuinfo is readable by PPC binaries under qemu-user
- Verified qemu-ppc64le -cpu POWER10 /bin/cat /proc/cpuinfo returns the expected PPC-specific cpuinfo output
- Tested POWER8, POWER9, and POWER10 CPU models
- Confirmed different PVR values for different CPU types
- Verified all required fields present (processor, cpu, clock, revision, timebase, platform, model, machine)
- CPU count correctly reported (48 online CPUs)
- Tested with both custom test program and system binaries (/bin/cat)

Test Logs:
1. POWER9 CPU model test:
$ qemu-ppc64le -cpu POWER9 /tmp/test-cpuinfo | head -10
=== /proc/cpuinfo via qemu-user ===
processor:	: 0
cpu:		: POWER9, altivec supported
clock		: 3425.000000MHz
revision	: 2.2 (pvr 004e 1202)

processor:	: 1
cpu:		: POWER9, altivec supported
clock		: 3425.000000MHz
revision	: 2.2 (pvr 004e 1202)

2. POWER10 CPU model test:
$ qemu-ppc64le -cpu POWER10 /tmp/test-cpuinfo | head -10
=== /proc/cpuinfo via qemu-user ===
processor:	: 0
cpu:		: POWER10, altivec supported
clock		: 3425.000000MHz
revision	: 2.0 (pvr 0080 0200)

processor:	: 1
cpu:		: POWER10, altivec supported
clock		: 3425.000000MHz
revision	: 2.0 (pvr 0080 0200)

3. System binary test:
$ qemu-ppc64le -cpu POWER9 /bin/cat /proc/cpuinfo | tail -5
timebase	: 512000000
platform	: pSeries
model		: IBM pSeries (QEMU user v11.0.50)
machine		: CHRP IBM pSeries

Qemu Unit tests:
make check: 118/118 tests PASSED
Ok:                118
Fail:              0

All tests passed. The patch correctly implements /proc/cpuinfo for PPC user-mode emulation without breaking existing functionality. Output format is consistent and provides accurate CPU information.

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N

