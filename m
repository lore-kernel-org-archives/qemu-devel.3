Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A63EA813B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq3H-0001gf-6w; Tue, 10 Feb 2026 10:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2u-0001bM-H1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2b-0003hJ-Kg
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A8irh0111923; Tue, 10 Feb 2026 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=E8igI91UUDEav+IZ7k6eK2WQnszMLcGcT7KK7jFIT
 wQ=; b=ZW2LfxTVfty0gVMf/VWTYbYQTcmca1H+g7l1Y9bCjUx6b43QqwqyCditR
 kO/CsuyGEsKHFsqfVwyzZ0emGNrzfF3xz+ID0BtVF4YX3a2I1zJ+VrZlLPecrcJ/
 RwJevEBf7n7c1c+IpOeOFVy1xMEe2Fh6EfoDcp29F59+9/wOOlH9PCj/wIAtP7Kb
 3p3sB7rQwLVj9PdpDoJdACHhTsf8NtbQt6rP4FfhyRnm+7BXR8trZVw9ItmcRrEx
 nymOn9IDfYnFHea9yMLJbp3FpDHSUDsYyrDm0FKgyufu6EcAOcY9fbGuUI90F9et
 9kCjb/J+LsWKzB25EAtkM8f2/6Dlg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucybr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AFaw1J019221;
 Tue, 10 Feb 2026 15:48:04 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk1qrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AFm3el24445504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 15:48:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7663F5805A;
 Tue, 10 Feb 2026 15:48:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0840D58054;
 Tue, 10 Feb 2026 15:48:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 15:48:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 0/3] Merge tpm 2026/02/10 v1
Date: Tue, 10 Feb 2026 10:47:58 -0500
Message-ID: <20260210154801.1662032-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698b5335 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=zQcoHlMhbyZOw7esTl0A:9
X-Proofpoint-ORIG-GUID: xyg7bbNpgBXJsY9u-_DN1ZT2obL_IWNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEzMiBTYWx0ZWRfXxf19qVBWR7Y6
 HALQt/Lblpu0qGOw+4mapLd4qIBtMqKxFuzHcHVyg9ywaU1ESNLxzQfC9oHb0+EQ+P0gAXvhQRM
 iE9p/Gbt826hTS3OL/geKusIWwdsQwOdPZ6TO8YiAJqozLFk8J+Fsj67dB5XDK70/O0Cccj7feY
 CWWJ21tRvfq+r5Ti7DxmZ/rkukQvGIj2zmmbilhNZG9GTJrseVvOoJHfhmiPuSjIM24qndMD9PJ
 oFBm0pf77Auua+DPkpn7pIobpRj2v4gUnPutN6KMcmoXYvjBZmjxyyoMgkYZtgLBsJEHYbExzKK
 I8/ZuFsAptGOLRh24E2onG0kuppMzmimo21VBih6jxV/F9nB3bFeUMB1i74dM0j2sy0s3FDPV8X
 uoV7xGl3GS0pAVq2nnLsr/00bCsecIlMRE907U6WuFc3O3Qvpu42eWMkkb8irwbCXakSHTY4ZUJ
 1Rs5mF2tqJNHojlIfuw==
X-Proofpoint-GUID: xyg7bbNpgBXJsY9u-_DN1ZT2obL_IWNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello!

This PR fixes a few issues with error reporting in the TPM code.

Regards,
    Stefan

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-02-10-1

for you to fetch changes up to 46565a8db1fd1e41485341fcf51527047551f6a8:

  tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return (2026-02-10 10:35:55 -0500)

Vladimir Sementsov-Ogievskiy (3):
  tpm_emulator: print error on error-ignore path
  tpm_emulator: drop direct use of errno variable
  tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return

 backends/tpm/tpm_emulator.c | 59 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

-- 
2.52.0


