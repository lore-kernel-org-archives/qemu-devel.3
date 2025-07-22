Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E5C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueCKq-0003cK-QM; Tue, 22 Jul 2025 08:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJQ-0002Lh-Ge
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ueCJL-0006KE-O1
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:41:40 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAKD024432;
 Tue, 22 Jul 2025 12:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=IsLv/
 76PdAm9fyknh/wENGfwWc4cVutv2fWza08LdOQ=; b=T62OvdVeBU01GH5Ts4TbB
 Wta9et7yTHl585jkXz09lBrHkgDNBxvhigHZsFacL600e8svk5E3HEQqAKeJLmur
 8xWmyvFwb1E+Lj2McHnovbKpeIl4qy3iQ5ntnT8o5foxrru0CUccnVtEV/kt6i2Z
 i1gJOC6FhWx8OHhhtyOPWeOUE8gejl8niB7ohjBlX3tIAvt7+9D3ekvF43r0xFQy
 v9uz1Nb2G2Q/wsFZnOgrRS9piVh6HCvZ0N160KS9dw/0+yX75GEgkrRW26lyyhEQ
 qJCd6Qa+NdPq9x3crQ+/9d+VrcgWIwNcdocxK5Eg1DvnqF1cBScIl6b8a42Jdtmf
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qw70s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MC5xQE010475; Tue, 22 Jul 2025 12:41:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t99gah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 12:41:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56MCfT3p039536;
 Tue, 22 Jul 2025 12:41:30 GMT
Received: from jonah-amd-ol9-bm.osdevelopmeniad.oraclevcn.com
 (jonah-amd-ol9-bm.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.252.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4801t99g9h-2; Tue, 22 Jul 2025 12:41:30 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 1/6] migration: Add virtio-iterative capability
Date: Tue, 22 Jul 2025 12:41:22 +0000
Message-ID: <20250722124127.2497406-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722124127.2497406-1-jonah.palmer@oracle.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220104
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687f86fc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=ipTBKrNiw92s7om4A18A:9
X-Proofpoint-ORIG-GUID: vYjqTppBd9-jBcwyS9McPHnwNLoDS2Nf
X-Proofpoint-GUID: vYjqTppBd9-jBcwyS9McPHnwNLoDS2Nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwNCBTYWx0ZWRfX5/tbHfIJfJ7R
 XJUy+eMzoL/A2KRzmYWT+CWMDCr7bNAc2MTBT6Xh3qFbZ1JLheIaQRBLLun/lP+Rk/M4mtfTfbP
 1CXWTGjGq1dF1a2ZcL+gcxY0aKPCMps5Mvd2051f5cGWm5BlYhjQDC6Wly3idJhTP/ul1m1crel
 lVIh+7jbCN5WcfnH9sJ/rET/hPUMKZGRGUOuAQgwL7UXsx+TI/Fs9YAF+Dn0ra1h7DgzCR0QONU
 USM4bSa6wiOX1n91jXfz2NN3NZWD2D2mCbi4PXdnw9knhNMVACLgPglkseT6d9a3r2gnqUEzqqM
 rfjGTYsbifk6iGpLRJcjsFstQ92aHPtcDSdnnVVMtAibx99YXaxa/qnYZ8bepnV4yjVKAyFMmf9
 dDYx4nvXcbztcddX4pU4wnduR4d9JkgriO0ILAs8GCo/Qe0TVHR2fol/+XnsKOkICdiH1t3B
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Adds a new migration capability 'virtio-iterative' that will allow
virtio devices, where supported, to iteratively migrate configuration
changes that occur during the migration process.

This capability is added to the validated capabilities list to ensure
both the source and destination support it before enabling.

The capability defaults to off to maintain backward compatibility.

To enable the capability via HMP:
(qemu) migrate_set_capability virtio-iterative on

To enable the capability via QMP:
{"execute": "migrate-set-capabilities", "arguments": {
     "capabilities": [
        { "capability": "virtio-iterative", "state": true }
     ]
  }
}

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 migration/savevm.c  | 1 +
 qapi/migration.json | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index bb04a4520d..40a2189866 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
     case MIGRATION_CAPABILITY_MAPPED_RAM:
+    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
         return true;
     default:
         return false;
diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca12..8f042c3ba5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -479,6 +479,11 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @virtio-iterative: Enable iterative migration for virtio devices, if
+#     the device supports it. When enabled, and where supported, virtio
+#     devices will track and migrate configuration changes that may
+#     occur during the migration process. (Since 10.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -498,7 +503,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram', 'virtio-iterative'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.47.1


