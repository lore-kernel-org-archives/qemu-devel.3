Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3C8C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz04S-0006Xf-Tw; Tue, 25 Aug 2026 18:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04Q-0006Wn-RV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04O-0004w3-Pp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:42 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PFts1o332018; Tue, 25 Aug 2026 22:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=0LjlVlifnfORf+XK4z3KyFkKkIbLW
 oMSfqu5S3DZIUA=; b=D+6VOB5Hx2c5OlhJKhdbBUE8xG+5OTYxfRGzqrSJWYLJ3
 aBqSjCKK5XUSwZIScUTJpzTbPdFrOevUDIha/qFQOVIAmBgU5v+OB3CXhjzvjZt6
 bzKU1dACqLVQ0YpGnYbT5tGu5rf2CWbzwYQPIV9EboVUNylUTE2HjYhmZHydA0vg
 pKVEkS/rGejczEWcaoBsgz/Yul+D047gUXX1ErjSFt75zZiodhIHowC9lb6Ci+tm
 VgswJKL1GQQPOAuO5HgRDIIZx0oTqWmyjoasnkyXGfhZKa5AlLpjdsjUTYPsGVSp
 fWdNAtLpnPA8iB7YBHRCZSaSpOv06r5Go9+kkC6QQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72p9w6wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67PMo8tl016604; Tue, 25 Aug 2026 22:56:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g850vdmdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:35 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67PMuY4D034200;
 Tue, 25 Aug 2026 22:56:34 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4g850vdmdc-1; Tue, 25 Aug 2026 22:56:34 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 joe.jin@oracle.com
Subject: [PATCH 0/2] cpr-exec and cpr-transfer: Fix failure when using
 mlx5_vfio_pci
Date: Tue, 25 Aug 2026 15:49:39 -0700
Message-ID: <20260825225054.807116-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=700 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608250195
X-Proofpoint-ORIG-GUID: DYvkA4wNGkUS_odVnYayUpeXxYHKVyqW
X-Authority-Analysis: v=2.4 cv=EqfiaycA c=1 sm=1 tr=0 ts=6a8e1da4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yqzX0Ed36s_VLx8hkpkA:9
X-Proofpoint-GUID: DYvkA4wNGkUS_odVnYayUpeXxYHKVyqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfX9/6fvS/v8tfP
 sUcoLqe3CHblTLUtMAS1FFgaxtaILYrkDHQL4ukQ/xaBHbE0HntLE321cpGIvJu2EkjUC8SsyPs
 m2omQ95f/uZuKiE8KnuyrqGR+cx1/ibOQjJisHxEVT4QP7PBSNcsNoEG+RPBP4GKtdv8Ohi+nqu
 MeoKMLFD4CzJwjCsa+clBEkNXfGaDBGquGebZxjtH7Zd3u772iyt2/Az8e+FCBJ13W8lbGyLLSp
 GbBR+wJIX/ctQHzMLzWzmq/rXAU8HwzqnZdBfvq85bzKLmKqKCv9CwS/IzEVGCO32QyHOvEmKYp
 PP2syA2JwPGXbv+6J1ptdtklwfUsuL2lRN5/n0J7dnb9WSKmlJPuhNpkNHkcIJaguVfS7+jauZQ
 7GIJbmtFUSMFv2bCIcnRUkwFlxldvgwJrNtwfGOakBA2vDSfV8KqH/WIxMn1B7LmW84KFIND2AQ
 +isBMXyJQwGHH+l+tCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfXzl2Az4OMCjX+
 cNDvCx3z5Ea0+QQiB+OqbXfTY/HH/UTbiE74jcfkv5ym1fLbhUX8WGoTuYyjN5c5mtpQuxi7chb
 D7etDPP6UJjOBCd1YH81LEsKqYeXKLW0arHrDovjic2XsRfQQSyI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Support mlx5_vfio_pci style VFIO drivers (which support live migration) for
cpr-exec and cpr-transfer.

When the VFIO driver is vfio-pci, vfio_migration_query_flags() returns
-ENOTTY, so savevm_vfio_handlers is not registered or involved.

However, VFIO drivers that support live migration, such as mlx5_vfio_pci,
do support vfio_migration_query_flags(). In that case, savevm_vfio_handlers
is registered and may be used to save and load the VFIO migration stream.
This is expected for VFIO live migration, but not for cpr-exec or
cpr-transfer.

For example, the cpr-exec below never "converges".

(qemu) info migrate
Status: 		active
Time (ms): 		total=6438, setup=15, exp_down=595047
Remaining: 		6.47 MiB
RAM info:
  Throughput (Mbps): 	0.09
  Sizes: 		pagesize=4 KiB, total=0 B
  Transfers: 		transferred=71.9 KiB, remain=0 B
    Channels: 		precopy=0 B, multifd=0 B, postcopy=0 B, vfio=0 B
    Page Types: 	normal=0, zero=0
  Page Rates (pps): 	transfer=0
  Others: 		dirty_syncs=4033, downtime_bytes=32256

(qemu) info migrate
Status: 		active
Time (ms): 		total=7141, setup=15, exp_down=598507
Remaining: 		6.47 MiB
RAM info:
  Throughput (Mbps): 	0.09
  Sizes: 		pagesize=4 KiB, total=0 B
  Transfers: 		transferred=79.7 KiB, remain=0 B
    Channels: 		precopy=0 B, multifd=0 B, postcopy=0 B, vfio=0 B
    Page Types: 	normal=0, zero=0
  Page Rates (pps): 	transfer=0
  Others: 		dirty_syncs=4478, downtime_bytes=35816

(qemu) info migrate
Status: 		active
Time (ms): 		total=7682, setup=15, exp_down=595047
Remaining: 		6.47 MiB
RAM info:
  Throughput (Mbps): 	0.09
  Sizes: 		pagesize=4 KiB, total=0 B
  Transfers: 		transferred=85.7 KiB, remain=0 B
    Channels: 		precopy=0 B, multifd=0 B, postcopy=0 B, vfio=0 B
    Page Types: 	normal=0, zero=0
  Page Rates (pps): 	transfer=0
  Others: 		dirty_syncs=4820, downtime_bytes=38552


Even after migration converges with
"migrate_set_parameter downtime-limit 1000000", the target still reports
the following error:

failed (load of migration failed: Invalid argument: Failed to load vmstate version_id: 1, ret: -22)

Skip savevm_vfio_handlers for cpr-exec and cpr-transfer.

Dongli Zhang (2)
  vfio/migration: Avoid savevm_vfio_handlers for cpr-exec and cpr-transfer
  migration: Avoid inactive SaveVMHandlers in qemu_savevm_state_non_iterable()

 hw/vfio/migration.c | 8 ++++++++
 migration/savevm.c  | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95

Tested with mlx5_vfio_pci using cpr-exec and cpr-transfer.

Thank you very much!

Dongli Zhang


