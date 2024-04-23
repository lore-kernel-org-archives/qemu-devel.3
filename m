Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E42C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHeV-0008PQ-VV; Tue, 23 Apr 2024 11:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8843110a50=aidan_leuck@selinc.com>)
 id 1rzHeL-0008Od-Is
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:01:43 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8843110a50=aidan_leuck@selinc.com>)
 id 1rzHeH-0006tv-U1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:01:37 -0400
Received: from pps.filterd (m0136175.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCKHPJ012153;
 Tue, 23 Apr 2024 08:01:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=4RVOFujWbScQ
 C5S1RVlUOEUpYh/wQsKyMTlqOZvSMOg=; b=LqQHDuG4D8vF1SWLONOCrzubCLWX
 YBaQoUyY6zCVoLt0MOVsqVSOqeiqY0uNU07Gci/uR1MkYA0SRtrGnRRAi4UuhftM
 KLa0pwXz/pxwJ4iDhBJrF8i3aWuhP8GgYFRwTQVwp+3xXSczJ5XGq6HHrJgxEjEa
 NhozHWxTFnuzAY1821yxw4raqhqBpL9bzsnpdSzMK9YDZqXufWEP+vkW4OvqL/hI
 rY0k1E5SjxFCBYOMZtzGIdblr+18M4Mw7OF5pQAo+0ePrl5iochFSJsaSZvhzBQ+
 S4YX4HKtEQI0NY2/mu1ZlSlrvlBl31oVIlMMYjpBBdEjyAzzzGQ5Klx1MQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xnv6qgkth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 08:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6kXAOec++OJbqv6apY7vgQf/0qLfjDK+DteYaZ+IzN9QAITa0xp80mU3Bqd9/a1aWtBzWp6hK28Sqd4z+6j3sgV+Ijt9f3O1MOhUS2xNxHGo/G/b+iaSAH4B8SZlcBpm2aaEB4zpPSI7TUjgaYDB539nV2nqMGafW/vUdgtAQgH37d+KTyFZZzEbD18oAhyJ+G2/4KLGSr7qQ8MFXqI+fvGcOfeA5puq0XjxtGq+lfOoBkCIOmEGL+nwBLCH5BV2KS3+qfZWGSTeG95HNkvhKMvDL2Hum1oT4uDGwHYmubJsWrC5tETGhvSk9QSdJipCH2ZgCvLkuAu5mgGfMyIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RVOFujWbScQC5S1RVlUOEUpYh/wQsKyMTlqOZvSMOg=;
 b=VfDCDXW+EShpv92UG50f1HPdVEOzc6K+BCOFkClmfhMr9GxFgeVsaY2lNG+xS3cyL25E36wdhfFWBPCxRs6/4k/Ks+wzY+5gy3R0HmofTXptuAaxvd4TRKL3SAbJY99QDyucF+K5BV58btUuvV5C1ecamIijh5hJeO5NHsAsH8sI1uaHJ3dYmKNm7bXZl3Vgijv0Z205SOLnosO9JwB0KQ6ficZyQmt+ACyvSk2sZwXYahw7x3RATVbwf0NBg89zYEBLo6Xnr1CN5lJawNuIKg809j/B9Eqz3j9cFruRbc9lXY0IzUCOJgvjyZqBWOpUqm0+vKtf+wM78p/ReShNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RVOFujWbScQC5S1RVlUOEUpYh/wQsKyMTlqOZvSMOg=;
 b=F3umKReT5nBJkQN71P8ndJbg5mV6Rzo/FtHEOv1LBVGzeGfjCRLcSEMQUelG4yyvdRqh59I37G3JYIBZXNRHT9LySjzxwvHz+sx7QDWxAU6ivqozWkPVGABdYPhEtw008quWhu7HIyljkpBt/7WHHtTI+GZFL4swfirgprL2XLyQyWRaDI/v3HRaK07WWySMbMK0KrupR0VzSq6HdDVMeTHv24Ur93NHBxq7DnpV429IIYKktoDuhQhqnHd3uVSVwCImz9oo/KAgVZgnzrsZNOIITwfH0U2oAwxFEGS/TyUAkCClSuN7VtJN2ctuF5s0OwbiZvkdZhk6U2xTFsVy+g==
Received: from MN2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:208:134::36)
 by SA1PR22MB3925.namprd22.prod.outlook.com (2603:10b6:806:332::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:01:21 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::3e) by MN2PR16CA0023.outlook.office365.com
 (2603:10b6:208:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 15:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:01:14 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 08:00:24 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v8 0/2] Implement SSH commands in QEMU GA for Windows
Date: Tue, 23 Apr 2024 09:00:03 -0600
Message-ID: <20240423150005.48175-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SA1PR22MB3925:EE_
X-MS-Office365-Filtering-Correlation-Id: dca43457-97b4-40f7-d1b5-08dc63a63a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Og/V3D9JwYMcabhHKacpj4GnONbT+Zi9RXhrfcV1FFFfqRcBkwtZJOL6hUPt?=
 =?us-ascii?Q?C2WA85qXDdr7OLopVlZ4vv0DILKsi4fRcPFsCBUkTv3Go9ahyqWh0IBOrBky?=
 =?us-ascii?Q?Z52bBV0aMRzt6nF19mnvrlIPNE2JHRfsoZUqHrK8rK/uDVdR1EiqK4iJln3n?=
 =?us-ascii?Q?EIaW/SIumDeJeMfJHwnWBOh9z9eDl0KWNZXBp4XuOFAb7WLYHu09cBwdv3wo?=
 =?us-ascii?Q?Ry7yTEyNNAy3donZLeUjaZB0ATZYuKtDupmNjre0N6ZijXfD+A4oQBbf3NDh?=
 =?us-ascii?Q?RWqYjdTOOlg09+xYcXCkaki0nGC2P7AsVngBBLzZA53tBCWOSQU/FSDSyxRE?=
 =?us-ascii?Q?cRxowyoz02df3wCmhAUg44K/uLhwoh3+ndGiufVwUTm+izbzRt7tnMqL0p94?=
 =?us-ascii?Q?t/7KyrYruNTsSdp0zcgWDCveMnG9OZ9W6lz9aQAVlSzTAUpJ+gu3Pj2DPfY4?=
 =?us-ascii?Q?Ts8CH37SIYmXZYRWbHS2oEC0neDCM9GYwBvD6mIsNFZLb6kEWPeLPe+z04bz?=
 =?us-ascii?Q?iF4fJoDH/Zo5Gww9RiimR2yxN6d/3+F0ft+/4lCKXu61swvhJdKk3vaFEdaU?=
 =?us-ascii?Q?UGRiTBmgg7QbVg6K7NmfUVZeFPhTzoS7JEOedLGFMXEWa58lVrGzLhPXkonz?=
 =?us-ascii?Q?sHr33IrYAihEysRXXb1sbcc8NA2yo69ZmCEqZEb0+WXfmMrN20zniCgwfwGR?=
 =?us-ascii?Q?BWVHX3p8hMQrK2Vy+DVfkmf+mxJYvisifKm7al2yNIkuZK1HkPN7h7i3Qws+?=
 =?us-ascii?Q?fw9n+E13UtvSQCE4cU6lUQT4g55qgWj/QQrI9i0qngcSMfF53qzjoVmKBKgK?=
 =?us-ascii?Q?XT1VSjDL29gMuzA/nYHoHR3B4XzAa59CMksjjCbgZsrdU6DB7on/hqHMFY+2?=
 =?us-ascii?Q?ISGawP1/KIgHaEGHFxM81OKJI/AYGxMo5fJEnaOMMnoxYrLNi+GIwI3yN3CR?=
 =?us-ascii?Q?6y9BQ+MAN9KKBpMBcUPjEg27mULOiS6hyHpwFPv9gmT9o/nZEg4B49APzmVb?=
 =?us-ascii?Q?aV3H9VPkxkaByq2jx8OA1+tj2VWfaC5E2nGeLXhCJeNXIdMgY4XcQ5Izrao+?=
 =?us-ascii?Q?5JzfoNRd4gvZVfBs9wrnYpIgr6gbKBEJrfk2aWj51ZZa4/dSJPR1LZcFVsb+?=
 =?us-ascii?Q?NdcAkO264BAcwekSBuaPmJNBgLchmAfktVIp2drtDzy6do91Pyql+n4BmPDi?=
 =?us-ascii?Q?inTk11ojDJgBcfnWzZ0l8JKzRkVCaDUobT92yK6ScL1PcCUcTu6IUpvUUvqq?=
 =?us-ascii?Q?BK9wgKn7y9LwtFqr+Ve7DM5ceTZ+JVTAaOFrRZcb9lzPilGrfdoIUlHsUhQy?=
 =?us-ascii?Q?HjAYmTy8+FK9lQGnvTkBPqdT?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:01:14.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca43457-97b4-40f7-d1b5-08dc63a63a4c
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB3925
X-Proofpoint-GUID: 3gKsnPJfbihbP3X26yaXMPXqsK48s962
X-Proofpoint-ORIG-GUID: 3gKsnPJfbihbP3X26yaXMPXqsK48s962
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=612
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230036
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=8843110a50=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: aidaleuc <aidan_leuck@selinc.com>

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys
for Windows. This PR is based on Microsoft's OpenSSH implementation https://github.com/PowerShell/Win32-OpenSSH. The guest agents 
will support Kubevirt and allow guest agent propagation to be used to dynamically inject SSH keys. 
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent

Changes since v7
* Fixed missing line ending. Thanks IDE. 

Changes since v6
* Fixed issue with file permissions causing public keys to be rejected by the SSH server. credit (kkostiuk)
Older versions of OpenSSH such as the one shipped with Windows Server 2022 are more stringent on 
file permissions.
* Removed everyone group from create_acl
* Disabled public key file inheritance from the parent folder to control permissions in a more granular fashion

Changes since v5
* Fixed spurious formatting 

Changes since v4
* Moved qapi/error.h to commands-common-ssh.c
* Changed <qga-qapi-types.h> to "qapi/qapi-builtin-types.h" 
* Removed stbool.h from commands-common-ssh.h

Changes since v3
* Renamed commands-ssh-core.c/h to commands-common-ssh.c/h
* Fixed styling errors discovered by checkpatch.pl 
* Moved some header includes to the commands-common-ssh.h

Changes since v2
* Set indent to 4 spaces
* Moved all comments to C style comments
* Fixed a segfault bug in get_user_info function related to non zeroed memory when a user did not exist.
* Used g_new0 instead of g_malloc where applicable
* Modified newlines in qapi-schema.json
* Added newlines at the end of all files
* GError functions now use g_autoptr instead of being freed manually.
* Refactored get_ssh_folder to remove goto error statement
* Fixed uninitialized variable pgDataW
* Modified patch order so that the generalization patch is the first patch
* Removed unnecssary ZeroMemory calls

Changes since v1
* Fixed styling errors
* Moved from wcstombs to g_utf functions
* Removed unnecessary if checks on calls to free
* Fixed copyright headers
* Refactored create_acl functions into base function, admin function and user function
* Removed unused user count function
* Split up refactor of existing code into a separate patch

aidaleuc (2):
  Refactor common functions between POSIX and Windows implementation
  Implement SSH commands in QEMU GA for Windows

 qga/commands-common-ssh.c  |  50 +++
 qga/commands-common-ssh.h  |  10 +
 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-windows-ssh.c | 712 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   6 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 811 insertions(+), 57 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.34.1


