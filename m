Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5930FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVWe-0004Op-0h; Thu, 17 Jul 2025 16:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW7-0008Vt-Qu
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00008S-JP
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0jQT010788;
 Thu, 17 Jul 2025 18:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=mI9wq6ts
 Lhj/wmKRYOT5+iyxzr7rQRgzM/2VWgYKq1s=; b=NEIEr7NIljj3tnoGnCCaFDce
 V3vFIFwEmbN/Tds/gIHzCvBN8LwlR8nU+/+j9KQLjEZKDXkVoLoQtpC4sXddhSbn
 Y7Ccrllqz34KNq1z2b5/F93n/0MOEZ2doa9Tqw8oADx5ILvVcCA2XZ6qupDKX6wB
 Anb6phQAO5GG3FSQgISJTNBgjDNXw4kVAfsYnEygdNKn1q2WVBcVe5VdHFzMesfo
 jIEXFWKGyY9x4S0DcZfdtvSehgcPJ1N/FXcI2coObtgVaMHjy6dSD1J0YwVwNxCD
 1yepv82xchkyqwQr6wkGdaWrDXqzIqBnMCN2W30B9HrUqS24HoPkpa/YElbzaw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfcacx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHgBou023735; Thu, 17 Jul 2025 18:39:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2t8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoih007425;
 Thu, 17 Jul 2025 18:39:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-1; Thu, 17 Jul 2025 18:39:29 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 0/8] Live update: tap and vhost
Date: Thu, 17 Jul 2025 11:39:20 -0700
Message-Id: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=745 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Proofpoint-GUID: -RvsLgPNzFpLWdcK6NrbZUg9uCva7J9m
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68794362 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=4o5NCgjuJ1xDdWi_kjcA:9
X-Proofpoint-ORIG-GUID: -RvsLgPNzFpLWdcK6NrbZUg9uCva7J9m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX03J1GAD2i76J
 M/mnY40iiMDH04KGRBNSOw8IEzSb0yFqlzFMX/PKhTz0ecEMMzQDHW7EXfje6BSogdnVOSxvHvc
 8+X+47drA9+Z4+y2yrFSM285o2OAYAMmcNCtezVpU+YMsLDT0dFED7gmFIXwp0l4JHfd0Xl8jhj
 pRLAvB/jby2vtBYsse6P1o/MuezGdQKmXVYhXIKS7Xmo16cG3QsDAVZuZ/PJ6JFxMI5T8ZlVRQY
 gVPYBk5ceUPPdrMi6wv/IwmfqTB9o1L7kc0sjSUBAqFdU0/5gpdcwolpezCGzTmbOf6qKuosjX+
 N4w06pdFPHRxmgXuka1xf/Ftgwr5NIzSH6we+YFaPCqDQLR0V4Uxv6Fhj43fEWI+wzOf8H02CpD
 xOJm157MD48UqloxwE2Ci1QPe3NQN70s23oWwccmzGfLuWYEoU577cqE9l2qOO1cvJya2y5g
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tap and vhost devices can be preserved during cpr-transfer using
traditional live migration methods, wherein the management layer
creates new interfaces for the target and fiddles with 'ip link'
to deactivate the old interface and activate the new.

However, CPR can simply send the file descriptors to new QEMU,
with no special management actions required.  The user enables
this behavior by specifing '-netdev tap,cpr=on'.  The default
is cpr=off.

Steve Sistare (8):
  migration: stop vm earlier for cpr
  migration: cpr setup notifier
  vhost: reset vhost devices for cpr
  cpr: delete all fds
  Revert "vhost-backend: remove vhost_kernel_reset_device()"
  tap: common return label
  tap: cpr support
  tap: postload fix for cpr

 qapi/net.json             |   5 +-
 include/hw/virtio/vhost.h |   1 +
 include/migration/cpr.h   |   3 +-
 include/net/tap.h         |   1 +
 hw/net/virtio-net.c       |  20 +++++++
 hw/vfio/device.c          |   2 +-
 hw/virtio/vhost-backend.c |   6 ++
 hw/virtio/vhost.c         |  32 +++++++++++
 migration/cpr.c           |  24 ++++++--
 migration/migration.c     |  38 ++++++++-----
 net/tap-win32.c           |   5 ++
 net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
 12 files changed, 223 insertions(+), 55 deletions(-)

-- 
1.8.3.1


