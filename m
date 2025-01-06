Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B4AE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUpUD-0001Oe-TR; Mon, 06 Jan 2025 10:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpUC-0001No-3B; Mon, 06 Jan 2025 10:57:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpU9-0000yd-P5; Mon, 06 Jan 2025 10:57:47 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506Etp0G020441;
 Mon, 6 Jan 2025 15:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=0jBNISGXcuA8EeHP
 AmXmbcIb+ZRHr731HPiFbHIlMdY=; b=mYDu/tDQOhf/BKtrA3bYzCOU5iEfeknx
 klWSOPg8jER6gad1rp8QNHPPlIGh3fKph0Mh8vYEVHWD8FMYuoSdnzRsvtyws1zn
 TOKJLR/cvlcW0LJRQYbNrwuCJVBFYCq6y36YtXYgWIz05MMbroT92J5J+3sgH/yt
 ujTpnP6phCCHNzcn0PBwzYF4bf46GgF/m5JWNkr9cooO6fW93r5GA6VwjB/9CUAt
 wea2Toch+65nh0hVO7vKNF9AfylxC9iG2F4zEbi775i6xSjh9kiV4kFZJsJ7ZXAx
 3vGUalICSXC8zVHxfSUMYhP/tdot/UUwsHSe5nYqnhu39juiv1fhrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk033fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 506FQTWp027555; Mon, 6 Jan 2025 15:57:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue7nw3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 506FvegD016161;
 Mon, 6 Jan 2025 15:57:40 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-185-77.vpn.oracle.com
 [10.65.185.77])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xue7nw2a-1; Mon, 06 Jan 2025 15:57:40 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 anisinha@redhat.com
Subject: [PATCH v3 0/2] Move net backend cleanup to NIC cleanup
Date: Mon,  6 Jan 2025 10:57:33 -0500
Message-ID: <20250106155737.976977-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060140
X-Proofpoint-ORIG-GUID: 1uJTZ1QsFTlS_Li3Kva5wPlAr8D9KfyW
X-Proofpoint-GUID: 1uJTZ1QsFTlS_Li3Kva5wPlAr8D9KfyW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
structures if peer nic is present") effectively delayed the backend
cleanup, allowing the frontend or the guest to access it resources as
long as the frontend NIC is still visible to the guest.

However it does not clean up the resources until the qemu process is
over.  This causes an effective leak if the device is deleted with
device_del, as there is no way to close the vdpa device.  This makes
impossible to re-add that device to this or other QEMU instances until
the first instance of QEMU is finished.

Move the cleanup from qemu_cleanup to the NIC deletion.

v3:
Remove shadowed declaration of NetClientState nc variable in 2/2.

v2:
Remove NIC peer also at net_cleanup. vhost-user trust all the
backends are clean before qemu removes char devices.

This is not a requisite introduced by this commit as
system/runstate.c:qemu_cleanup shows.

Eugenio Pérez (2):
  net: parameterize the removing client from nc list
  net: move backend cleanup to NIC cleanup

 net/net.c        | 44 ++++++++++++++++++++++++++++++++++----------
 net/vhost-vdpa.c |  8 --------
 2 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.43.5


