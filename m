Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0084DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdoF-0004eo-08; Wed, 24 Apr 2024 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoD-0004dz-Ix
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:17 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoA-0004ho-8w
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:17 -0400
Received: from pps.filterd (m0136170.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OEK2IU013179;
 Wed, 24 Apr 2024 07:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=IMuzbxjPbHRl
 Hr288hbE7zUCiI5PCEPsZkq0rEzMJOQ=; b=r5YH1mDeOQv6r6xcQoof0NJ3qOWg
 cqiAu8GLgZSDaAM+qrYDBpa1A/ZCTfT+DAYep11jyeZaEujNhkNeAf2OOSMKVfso
 fs8CQv3FEwDobu1dDz992PS1NCoyb/T+gYgi9/0NHgJuSJGk32NHUTjiNJAl8tTG
 R4VGMFRFf5om/fjmu+Lx1iu8gcwWtnwdW/6hFST3PXeuXqkBRrWs+92cMAs4GS1M
 Je9weUIoYXxT2y+7XS9ROgSShJD6G2tOkt9lrS2zRipmnC5f+8RV1do6fgqMFeAO
 /O0HJrtOBVUu7pafnWzshfa4ENACUYJ+mTiTYMgR6KfBnkGlBWPb0ojDcA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xnr369mcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 07:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRON8kBrmjWQiL54pAPsT7yOcv00CHHCV696/zSgoaoshpxd70o/yiKagjZOeg+Obm5zdSUHQVcaEc5CIEH6RkLUU9IEdsSv4uPexve5opGvICx/bMnR7ZMiacgZjDehVw/ae3wKbqntyJ3f2ad0AuZjXrxM8/j3BbkBcqA/Q6JS2lAGYgZl6o4eNl46QlxNthuXmbe+dG0ra58XqGmZQn+HvVSeJuF9uSGOG3Vfq9pBPC4mT48AwvVsuF4SAXxe50R3IV7XnpN9dNqts11TSYVeeTImODsFdW3lFa5b6XC+1qDOLMJe8H8pIqePtsqro0rIdErKD362MxFS81Ww9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMuzbxjPbHRlHr288hbE7zUCiI5PCEPsZkq0rEzMJOQ=;
 b=a9SziFWIFYNnXcLEJD/Y/QgpZoncvqDB5VhApObr9jY//j5FyIvnn64mAmg2J6fJC6VLtBkTjGZJpRwERzohVEPN3u67YZ7DzDCbOfL3agLe+KC37Wb+fnpEsru6mWjNbAD+9rrqtmHUf8H9FWV7oehlMGon3ULe4PUPyVbUD/uU4iewbS6HpGnJfvntfCvFfSyfBt8QNFaqxKHptIa07t2LNkw+nWElXmQAcIafijRQemMOdsn57bxZQk2wHPvwstjutPIDtwFwh3vzWCOrg6S7Ll88reL3DUr4jq1Oxe08b57coikudPfW53ohD0SAhYJwfhHEJKt0vtTRyPLwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMuzbxjPbHRlHr288hbE7zUCiI5PCEPsZkq0rEzMJOQ=;
 b=hADQadraCYp6lvC+jdX2I3Xt8rTP3/D1GhKIEqihPU7R/TEvETQ1s7GgASirBOASh81fo+eRbT9QPdcw3lnE0AVICRZel4kjU4tGUcf2UczIu7z3mbBMjY5BC4RUSsqhvCchfR840aUaoeLJIHx5lE1zN5sbXx6Hg6bXwpH8m+H/808EyKNKFGIHWkExDHQCvciJBQz9T4TXAk4yz3CNlnrf+5CCXyd5jBR+bNCkrYHWcLRMEdYLfzzuDoZA42UVedeMpQlaiJalC/O6uZvfff/IFib1BwTybdNwNuqtoMfZdC/h8mWlHoPBSDhfqDvnq7zd4n0qAcLHCDz5Zvw49A==
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SA3PR22MB4547.namprd22.prod.outlook.com (2603:10b6:806:398::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:41:07 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 14:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 14:41:06 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 07:41:00 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <demeng@redhat.com>, Aidan Leuck
 <aidan_leuck@selinc.com>
Subject: [PATCH v9 0/2] Implement SSH commands in QEMU GA for Windows
Date: Wed, 24 Apr 2024 08:40:27 -0600
Message-ID: <20240424144029.30665-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA3PR22MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b6df7e-b62f-461a-ef0b-08dc646c934e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ylC4hhkHLu9k6kv+3h16V1zSsoiIP0Y9HS4O7A3pruHBj5U7K0o3HZ7+z/g?=
 =?us-ascii?Q?bcnS851yqajHJP6qyt/xwie2STDrwsQW6MxAieEbCCiaMrrSZB7oOmh1heTO?=
 =?us-ascii?Q?VG67F/MWWjoJDztnCQcye/bokWDpSDOXPb2OvfWQQa0m3rV3Yu69/O2ePOl2?=
 =?us-ascii?Q?SnNUR/UMH82eTa2U2hkNxy7FZqoObDI/tHt37yVd7Xx33kjc/BJ2e7pQDBe5?=
 =?us-ascii?Q?MhQovipFkWNl+eavnUa6fsGPr8ho372mcmBdcaNMO0GdMoA7lnianq7rxLHj?=
 =?us-ascii?Q?3wvLA1B0cr4Yap/6cvGz4WCKfnZxqhv99Yec2gxZQGC0aYwRdla5tf8sfQ5K?=
 =?us-ascii?Q?aOCmPGv3F+Mo3mzqv/MKD0B0Fm1vy3IeEgvpYRLoUNrkNYAIzicPTx+MY1c9?=
 =?us-ascii?Q?PFa6psBJHyuh1gf7esyOJhoCK5Vk1BmW4LHxquAVhn5edmRD8K9NgE5YU+FA?=
 =?us-ascii?Q?hOzqs04W1CHZ1SMnOvLfq6wK/GeMyNZblybOk4cSAQzye+QtG9gGYV/7ZeT1?=
 =?us-ascii?Q?fMR/n2wbeh1pRW8Ynd+BGCN3yYT1y1Fwxx4vEOayFBgMJVNhiqY+2eOOGALr?=
 =?us-ascii?Q?cTlvyhH4g2loEZuHbGllhfI+hLNoyOwn8xmep55cbQI+GltJ526Hfiswyz1T?=
 =?us-ascii?Q?XGo5I/WCp7rL/4VWDTs/1VVhbtyV1nDGr65Tyu3asTPTTZs57ajExABLqefu?=
 =?us-ascii?Q?soZNG7TO6B1/egzKSXF1FyXbyRRTPqQwMLjyb+w3+sULaRcm/Dkh0E1nXCSV?=
 =?us-ascii?Q?UAHjQcLziT/eQcfXVoh0TCOSy7xFaoo7N+OmPTJTqadfYVw6CLt4fX1tG/xZ?=
 =?us-ascii?Q?iioF6p3rS/i7yOq8TlR7LVgjg14fUSwm8s3GOVQ2eeOKfDm65A8N438ekCqI?=
 =?us-ascii?Q?FfcCDsmf60MBkjXfor9bDCog7SKPYRtuoa/PK4O2mMzN6VI8Hq+HUDai00ex?=
 =?us-ascii?Q?WSr1CyU8BpAdf+88NKLghbn9ZxHvQIJKjEnI45ISf0IuMUO5bpxZ0hrkTkhd?=
 =?us-ascii?Q?6CTDNfdvydrQmN1/R2mohpjdZgpp5hCaG8E4Q2oCK/QCXKwoqzujZxtPDc9+?=
 =?us-ascii?Q?76A1+tabUcQsCndSaGKZf50FXSLa6lWsZ5+af0wIR1qcBPEpxZuF/ESiDYq9?=
 =?us-ascii?Q?mg58kHXMGbXdtcuOw1n+yTKCCQsE8WmtQNZza8T6Ov71yoEsbdjZ28IJAIhq?=
 =?us-ascii?Q?Rca1tzuqGMn+HUS0dJhYTyYq4NJ/1I3orHlIGpDG8LjcSfJtgx5rjChjApRt?=
 =?us-ascii?Q?xNP28q/iY+Z3w0yy0IuVx9mGNgwXoz1Q9646T/pBv5vVETSRUvwFEtN0O7b1?=
 =?us-ascii?Q?HBnTHpRm9rr/1C5+auya1jlQ?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:41:06.8718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b6df7e-b62f-461a-ef0b-08dc646c934e
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR22MB4547
X-Proofpoint-GUID: 4KilJNE8bV2IHegyCQmmjy8xJzDIsG7Y
X-Proofpoint-ORIG-GUID: 4KilJNE8bV2IHegyCQmmjy8xJzDIsG7Y
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=621 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240054
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=8844046850=aidan_leuck@selinc.com;
 helo=mx0a-000e8d01.pphosted.com
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

From: Aidan Leuck <aidan_leuck@selinc.com>

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys
for Windows. This PR is based on Microsoft's OpenSSH implementation https://github.com/PowerShell/Win32-OpenSSH. The guest agents 
will support Kubevirt and allow guest agent propagation to be used to dynamically inject SSH keys. 
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent

Changes since v8
* Changed sign off field from aidaleuc to "Aidan Leuck"

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


