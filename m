Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360B2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 18:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryyLT-0007Bx-AY; Mon, 22 Apr 2024 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8842f65a37=aidan_leuck@selinc.com>)
 id 1ryyLS-0007Bl-1q
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:24:50 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8842f65a37=aidan_leuck@selinc.com>)
 id 1ryyLO-00019W-Ai
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:24:49 -0400
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MFZxYF018340;
 Mon, 22 Apr 2024 11:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=yyD8dG99ksKt
 Yac18b9Q8D3fBJMu7faL0wtDWvlzwaA=; b=sF3fSkFXQ9/dHcTVqL4WZr743W5O
 hch/hfwYp9AvaFMCNISXD92lKYRgdOYr2fQIYXpWZAtqljGJQPgnyyddvVKzvJvk
 /HUDTAiDdjmp4nZGuxm5lJ3eTsMNrQIaCJhbB1JKm4bw4d00zvkVG6P47Sv3w5Bw
 ObINLz8XTIrAVMCgoAwTI8hRwRZKiShGYdyCEJ8U20sKvEwKCSnESI+rPmMeLebN
 JbwgGDqhRZWPcNBTrAAlLwBrvI75ACiTTC2v+p1YhfL/ZqXRQYLQoARDKHjTpi76
 APV6pC6/Y1bIs+aUO3BUjN5bjN3LTYkgXaHmZbSvw4A6fVLkyFm0pzMwRQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xmarts71f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Apr 2024 11:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+no++3pcdRkWYs02664dMSAZd8DkYVMy3fWwoi+fV7Wi2ygwsEzgAsJikhYGCbKBZ/aOcJxhnfqqXEE32ekE0REfkvfldfyPppNiM5FDzscD8IMJ/2hIoBZ6l6vHbntL5Pi/NjhYRG/MkelgUp5vjxTFCUX/K5jGtb/frZazoFn352ToaJVIjEyBpLNfr7HRcLg7+TzXSuZZDKoiyayTnBqQml61fDX5xZxxqlAvmzXjjcBYno6Z7ypdZlYvFKqLf6lI9C8mwEZMZYWVo7Gi1uc3Rzum0oHNOpAVG4eig0P0xNzsNFC0OkW4UmgFmY5XthtMGt1wHVGJsOfKvqa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyD8dG99ksKtYac18b9Q8D3fBJMu7faL0wtDWvlzwaA=;
 b=FtIsde5Y7AlrVIi368tnGAvUw2i6n/GRy7qCz0kD9FNp6QfYnfzKfAfNH8PUMaKIjUbOakCwZjhBNC981fUT8/toEj9WqIaQSaEQHPR6U+NO6P7sjMVeb/0Lkc+SHCXGt2N9ZnX8eY3MmK8Th4dno7KxNMZukLsHk4pFfGtWokIkk/Br/bBWjP8d+KFDEMxzMfsFKr93bWKQKTmQNTwpoh9YozCcgKdlNlgnowTYjfl7cJbGtvFGYQK++RRFXUlY9XojzaNZELiAPBRfsXDom4WddcNqAcXyYElP5+W1p9ZPIEzgVv57WF3a8p+iS2PoSZTIY2VYoeaZA5DzZzvJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyD8dG99ksKtYac18b9Q8D3fBJMu7faL0wtDWvlzwaA=;
 b=v+KXqEKzzXRiJaaXR5kjAKGAoO6LjywnG/+Ava+bIFY+7Pbe3Iw7CYfZ1epxmxzVvK+aAI4fb7ilYvFuTmvH4U65jW6dY0MpkHWQmlif2Xbsb3AhVvSLQc55v9H1lvfxCJqWLfWAvggqGLlpAVYgBNazOqMBxtVwL2qd9TMg5cI6NRUAuamgdpPLkB3Cf4PgfvhutTDBW0uroaLVff+ZMkXoATxprMWFWMmuVlMJtD2sFM6gxtAyghVzZnz+5ZQ8AyXQrE4Z5G0Ruka17hVGx5ZBy2LNSJFhmkL9kyu6E3Io7oKp09kFjx4T4Fc8Vr6n/enxGTEOP+RpJO44B3j5fw==
Received: from DM6PR14CA0067.namprd14.prod.outlook.com (2603:10b6:5:18f::44)
 by CYYPR22MB4315.namprd22.prod.outlook.com (2603:10b6:930:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:24:40 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::92) by DM6PR14CA0067.outlook.office365.com
 (2603:10b6:5:18f::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 18:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 18:24:40 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 11:24:37 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v7 0/2] Implement SSH commands in QEMU GA for Windows
Date: Mon, 22 Apr 2024 12:24:11 -0600
Message-ID: <20240422182413.230378-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CYYPR22MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d90c7ab-a842-4fec-b66c-08dc62f97955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7N0HNbR2VrWr+WxL4itjUua1jMyVO4yScm4RKLxuEiIbM5qLCQK3thD7uqlG?=
 =?us-ascii?Q?K6N8TZtUztMXyzCzcQ7QksFYwd5V5T5Bvx3ghzoexznHej65ESwmEy7Y8eJS?=
 =?us-ascii?Q?7wch25RTK3HQfuxNExWbHwKKtdB0FVfpAuqT69SVEcTZOsulo58QxRwnGQ4o?=
 =?us-ascii?Q?j70fatkI9Iif/eiUH9237l2fNGO/rospjZvbMmgZ4+s77bZdm0xopz1rgxwL?=
 =?us-ascii?Q?6GCYyewBuYCeaJACdaPsnIeJ3ZDW7i8UAncitKvSSbZXX4cfhWlysCxA3esF?=
 =?us-ascii?Q?vrfannRuRkh7rVFWPbMa5C4URV3VqBy9oIJ92Lwld+MdEzT1uL9Sea73/ssj?=
 =?us-ascii?Q?E+XVmJDZWmrCmCdG6qRfQOZR5RXVG0q+OBTSb+lpV7Rq7gV+et7s89NN3AeB?=
 =?us-ascii?Q?U2kV+PrT0bvR8irSrKJ+jt7GRe7oXGegVBD0mv9DRNH/f1TxSNIfTGiKroI9?=
 =?us-ascii?Q?j5XMZbglT2UfwBHDONG60GrG21rri9M33Fa57DmxboKxq2cgJ2KeiUQoMgAj?=
 =?us-ascii?Q?Utvomt9CIRov/+pmymX6S10J15Z8ZpHf6LK1CTftg+NTvMzW6aeFbgOsT4Lb?=
 =?us-ascii?Q?ibRUtlzqH6L7fMEKEVQTa5/gYHxiybOoV6f/DUekB9cGtW+yEGGRsrBG/32d?=
 =?us-ascii?Q?wYdgXaBxaEtiFcaPFlqK8neoBkhxClFRE4TBneCnSL4hz9zNus2mfMRX1WNd?=
 =?us-ascii?Q?OEfKxjUmtBJrZDgmrK25DRpEbqUDdlJVYkf0y6ubI6XqvIXOgQken1IdCqXR?=
 =?us-ascii?Q?tky1qM6so2p7PVaIlz0gTeAvWsfPKn5fOM5aqKuq/GtUEYBthsjW97vteNgp?=
 =?us-ascii?Q?4jVVauvPWNa1BFXusshWpBb7wd6ysH7Ds6SY2QynAOytlYW9gakqGV2D3Aeh?=
 =?us-ascii?Q?ozv3/Gd5/cJKgYyIW1XWM/QBCgQgGLfjxmxmde6l1Ro+ExPHuRnVZjwqWt++?=
 =?us-ascii?Q?P4ZVBuQdywU5jVlucFDgo10a2pFvHs3CIdGCjUjXQ3krBLcbu/AAk8/74taP?=
 =?us-ascii?Q?aGWkcCI9GiYSxPP4r7o92YdFKjBD+bVcrm1+SvSbrJOp9jAm4RNbEj1SNVgJ?=
 =?us-ascii?Q?HmjmkBfzfYp4fWtNebLS7m/II2v43yuFjN3V71pQI07e0vmbfw8vdLzYoGXQ?=
 =?us-ascii?Q?GqxCl3pMgYMNQdORrOjY/27XleEO2VZruWVBh2byhrRQtXBkx7uwFF/XGHJD?=
 =?us-ascii?Q?EtSatty3oTPftqsPkycZeVdWJuBRruumYuttHcF2vZ1u+RJKnXEs96gIe3HG?=
 =?us-ascii?Q?1g8+dc9K1HD4LySAq5oDYN/GZ0XwDH2eJFQ2CwEJxmGm5tovTvVmUGbXEVvK?=
 =?us-ascii?Q?AoTYLY1a+OCgWm2C9nnTdxDaPENSWGSk+1okBt3nz36Znva+UGvy8dVJYBK1?=
 =?us-ascii?Q?OUTkyV+Xh+oDPfAyoP9z5TCe+nyA?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:24:40.0088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d90c7ab-a842-4fec-b66c-08dc62f97955
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4315
X-Proofpoint-GUID: vRoNYak8Et7OMnDJGwFG35Bnc9OGTj61
X-Proofpoint-ORIG-GUID: vRoNYak8Et7OMnDJGwFG35Bnc9OGTj61
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=367
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220078
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=8842f65a37=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qga/meson.build            |   8 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 812 insertions(+), 58 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.44.0


