Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E8BD2A525
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 14:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t15Sn-0007fs-RJ; Wed, 16 Oct 2024 10:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t15Sf-0007ep-My
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:57:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t15Sc-0005ls-MV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:57:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDo7VQ029354
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 14:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vqVp0vNPIl0U473cpgTXlXdat8ImDiKH94niA7L/j
 RU=; b=mY5a1rtJOhZBHAA+UPzqdyXWIfPDTTfuhID7WjVHPWuIOC/rMCYGMOj49
 nusHXFP3+PdabDVhlUFlv4pC2UNEce4nWo/hnRgBAl6M3Z2LFbfvCIJ2hqwPDczN
 7fbLDUnj3H3DXeU9lNvBh+Wsj2EskDBJxuv+66qqK+TQjR5OaLuakvl2jlFfzI61
 e/PMAiXzMpzbXcYz4wm+neGfhDMXHe68c5wdjHmB1gro9XKNcxUQj2kMdfVNA7ur
 +ysbZMIp7XiV4RN12UKEKyaHujltePFF8MU8EzmcF9B42/5LFQpqnlk7zzbrsgHp
 LB2+phK3cifhVgnDndFh8XbqobPlQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aeqfgcd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 14:57:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GEvC3t006742;
 Wed, 16 Oct 2024 14:57:12 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aeqfgcd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 14:57:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GESP3O005374;
 Wed, 16 Oct 2024 14:57:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj9qsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 14:57:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GEvADF24511024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 14:57:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2BCE58060;
 Wed, 16 Oct 2024 14:57:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E43058056;
 Wed, 16 Oct 2024 14:57:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 14:57:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/2] tpm: Resolve potential blocking-forever issue
Date: Wed, 16 Oct 2024 10:57:06 -0400
Message-ID: <20241016145708.1166471-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SWAGyQz9OjgROG0f2VBcvsP3K3XhJYI0
X-Proofpoint-GUID: d-h0uoTnjEJVGZVZBXPeZs42aybbD3k2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=725 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410160089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In case swtpm was to return a control channel message with an error code it
would often return less bytes than the full response. In some cases the
current reading of the returned bytes would get stuck since more bytes are
expected. Therefore, pass a separate parameter indicating how many bytes to
expect in case of an error and read that many bytes in a first pass. Check
for an error code in the first 4 bytes. Read the rest in a 2nd pass.

   Stefan

v3:
  - 2/2: Pass size of return response for error as parameter

v2:
  - 2/2: Added special handling of CMD_GET_STATEBLOB



Stefan Berger (2):
  tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
  tpm_emulator: Read control channel response in 2 passes

 backends/tpm/tpm_emulator.c | 77 +++++++++++++++++++++++++++----------
 backends/tpm/tpm_ioctl.h    | 13 ++++++-
 backends/tpm/trace-events   |  2 +-
 3 files changed, 69 insertions(+), 23 deletions(-)

-- 
2.47.0


