Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB70FC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXi-0003Ie-GP; Wed, 14 Feb 2024 07:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXd-0003GB-2I
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXb-0002WX-2S
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:08 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EBldNM019239; Wed, 14 Feb 2024 12:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=sVNGWIN4J9INuJRKmm2Cn2H7XJO9OKuH5ssQ1dIkszA=;
 b=I7DE+q3reghnM4AYFzGSuHskNVZFKbnyjatezi355j0PrfR3TEVmAHCMDENR8oj/mGI3
 cG+xlyzuMO+BL8dTleFVDidNgTYaA+5XP+3jogKO/WjIh31EgO3BITjrZ8HM7rzII9Fm
 PH0zbIfubMqMg5FAxsIxa4xscXIN+Y6CmUP+0o8kgqcUB345Ip24ER5J1inBk7IBbv6H
 PRBRvvkHTmbDYbVVfdz2rCJtuHtvR7hSN4PGXadN+EOauxR1iewG9L/efZEsjP6ujRov
 eTj+r7732r2AQIRaZ64MkQiwHpQZPmlWXbKYs8DikZ0OkJtRCITBm6R0PEL29KKOcwqJ aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8varg5cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:01 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpd013766; Wed, 14 Feb 2024 12:39:00 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-1; Wed, 14 Feb 2024 12:39:00 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 00/12] Preparatory patches for live migration downtime
 improvement
Date: Wed, 14 Feb 2024 03:27:50 -0800
Message-Id: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140098
X-Proofpoint-GUID: kNQ-I7e6VVPeoXj6I_fI376EiWQVdEOk
X-Proofpoint-ORIG-GUID: kNQ-I7e6VVPeoXj6I_fI376EiWQVdEOk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This small series is a spin-off from [1], where the patches
already acked from that large patchset may get merged earlier
without having to wait for those that are still in review.

The last 3 patches (10 - 12) are bug fix to an issue where
cancellation of ongoing migration may lead to busted network.
These are the only outstanding patches in this patchset with
no acknowledgement received as yet. Please try to review
them at the earliest oppotunity. Thanks!

Regards,
-Siwei

[1] [PATCH 00/40] vdpa-net: improve migration downtime through descriptor ASID and persistent IOTLB
https://lore.kernel.org/qemu-devel/1701970793-6865-1-git-send-email-si-wei.liu@oracle.com/

---

Si-Wei Liu (12):
  vdpa: add back vhost_vdpa_net_first_nc_vdpa
  vdpa: no repeat setting shadow_data
  vdpa: factor out vhost_vdpa_last_dev
  vdpa: factor out vhost_vdpa_net_get_nc_vdpa
  vdpa: add vhost_vdpa_set_address_space_id trace
  vdpa: add vhost_vdpa_get_vring_base trace for svq mode
  vdpa: add vhost_vdpa_set_dev_vring_base trace for svq mode
  vdpa: add trace events for vhost_vdpa_net_load_cmd
  vdpa: add trace event for vhost_vdpa_net_load_mq
  vdpa: define SVQ transitioning state for mode switching
  vdpa: indicate transitional state for SVQ switching
  vdpa: fix network breakage after cancelling migration

 hw/virtio/trace-events         |  4 ++--
 hw/virtio/vhost-vdpa.c         | 27 ++++++++++++++++++++++-----
 include/hw/virtio/vhost-vdpa.h |  9 +++++++++
 net/trace-events               |  6 ++++++
 net/vhost-vdpa.c               | 33 +++++++++++++++++++++++++++++----
 5 files changed, 68 insertions(+), 11 deletions(-)

-- 
1.8.3.1


