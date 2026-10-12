Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51569CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuC-0005kM-6l; Mon, 12 Oct 2026 19:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu6-0005hn-Ln
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu4-0006I7-U4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgNka2686087; Mon, 12 Oct 2026 23:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=XZ/+K
 co7FVYbWyapH7PzZuGCxlGgG0FrWk978gMI9Ew=; b=kG9gOCbfw2XXkyAbXJY3p
 WfSSBvC/ORVjABeR6n2W7TcWMm78wysJJcwdZjddyzkmcU+kqXdcB5X22I21qHY1
 BC7LhK6wtg+TIJNAPkP1hchnTw5swilc744SD+ng7o7CCm5AX8mh/Rrk30wbq7nE
 cAKDRKl4XxVBVtWxC9JcV/nS6O9BYukDpGWV3p7zAaftscg0kAD1Ys2DMrff8aMn
 YQl6m7/qsaC3jKO9lTxJ+rhP6Jv7NgY4132YXZ9RGbbwe34kIDGM3GAGsx9X/Vjh
 sNIVgZSzF0008xiWO12ki0XlYaPBO4Z8o+S9JOqSi1IuaN+/+kYPwT+1D9jS24P+
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtb598-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpgPP015173; Mon, 12 Oct 2026 23:57:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:54 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHn025328;
 Mon, 12 Oct 2026 23:57:54 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-22; Mon, 12 Oct 2026 23:57:54 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 21/21] migration: cpr-luo documentation
Date: Mon, 12 Oct 2026 23:56:17 +0000
Message-ID: <20261012235727.398133-22-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX42Hp+RlSzhPq
 HaVy2NvHssxvKiZBcawgns9jSAQ7Vi+Xqo0iEWYSJRBR4poA2pFof/qsJ3B2vZ9dtM5A1g5V0GM
 O/8qs60pqJfX3Y0DJYfQxe8XLUhl0I/ZTfX36C78WIBlfMa68mGds5ra2XYvIzzUDehPVl7tJWE
 BkSuE24kdGePrJGfIT5xyiMEngCf8wNgtvjJ8ZaFFR4xDu9PeyqVhhfQN82+8YaI1tSjtyou4oG
 qcIk2Hm7+k0iBwamnqrWVRa4TMF5d1pJUTVsI8FWT10mm/14ZzMQTpneHrG2AzICvjPOFc8k8P5
 7jUvM4Tag1ygiyt9W9HR0K+Pe3qZ0aRbzKmDZ9KeXsE6pEi0slkuA2ACdHb6F8833WB+cgxqiuV
 vk+wFt+8WY2JiwjWqNbxnw67E9Yfl4RQhHpnz/Uln6ISBWKmm95WMhKqJW8AQwyqcMLBI7I4Tp4
 HNSChO+sIB4gf/dtOT45m8Zd7cDeaIqFIyo3jP/Q=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd7404 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Ut7Bde2QAJnn7of9UtAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: vhuuw4f6sYwZinfB-ZOLL8lsy9LElUqT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX97ZAdQxPkx8E
 egJKO98naEFz3KLoDgqZ3DV7tjZTsh4OlgLjM6CSD3LRBSRGOUBhAsyIlxu4VrYb+gxEba/KjJd
 N+rKsWaXchEYyixkDRXoeKe58tL1IHEvk87sr7mhcAcI7Kv1v0jV
X-Proofpoint-GUID: vhuuw4f6sYwZinfB-ZOLL8lsy9LElUqT
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

Document the cpr-luo migration mode, its LUO and Kexec Handover
requirements, and its outgoing and incoming usage.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 docs/devel/migration/CPR.rst | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index b6178568a8..40baf3fc0f 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -434,3 +434,67 @@ cpr-exec mode requires permission to use the exec system call, which
 is denied by certain sandbox options, such as spawn.
 
 The guest pause time increases for large guest RAM backed by small pages.
+
+cpr-luo mode
+------------
+
+This mode uses the Linux Live Update Orchestrator (LUO) to preserve QEMU's CPR
+LUO state and the file descriptors backing guest RAM across a kexec handover.
+QEMU writes the remaining migration state to the migration URI.  The outgoing
+QEMU must remain alive in postmigrate until the host performs kexec: closing
+its LUO session releases the preserved file descriptors.
+
+Both the old and new host kernels must support Kexec Handover (KHO) and LUO.
+KHO must be enabled, for example with ``kho=on`` when it is not enabled by
+default, and LUO must be enabled with the ``liveupdate=on`` kernel command
+line parameter.
+
+Only RAMBlock backing file descriptors are currently preserved in LUO.  The
+target must rebuild any non-RAM file descriptors separately. VFIO is blocked.
+
+Usage
+^^^^^
+
+Memory backend objects must use ``share=on`` and the machine must use
+``aux-ram-share=on``. KVM host kernel cmdline must have
+``kho=on liveupdate=on``.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-luo``.
+  * ``uuid`` is mandatory.
+  * Issue the ``migrate`` command.  The URI must remain available after
+    kexec, such as a file on local storage.
+  * When QEMU reaches postmigrate, perform host kexec without quitting QEMU.
+
+Incoming:
+  * Start QEMU with the same machine and memory backend configuration.
+  * ``uuid`` is mandatory to match the LUO session.
+  * Pass the UUID and migration URI with ``-incoming cpr-luo:<URI>``.
+  * If ``-incoming cpr-luo:defer`` is used, ``migrate_incoming <URI>`` will
+    be required later.
+
+Example
+^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+      -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234
+      -object memory-backend-memfd,id=ram0,size=4G,share=on
+      -machine memory-backend=ram0,aux-ram-share=on ...
+
+  (qemu) migrate_set_parameter mode cpr-luo
+  (qemu) migrate -d file:vm.state
+  (qemu) info status
+  VM status: paused (postmigrate)
+
+  # kexec -s -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --reuse-cmdline
+  # kexec -e
+
+  # qemu-kvm -monitor stdio
+      -uuid 6f1b9f5a-6b92-4a5d-ae57-7a0ddabc1234
+      -object memory-backend-memfd,id=ram0,size=4G,share=on
+      -machine memory-backend=ram0,aux-ram-share=on
+      -incoming cpr-luo:file:vm.state ...
+
+If ``-incoming cpr-luo:defer`` is configured, explicitly complete the
+migration with ``migrate_incoming file:vm.state``.
-- 
2.43.5


