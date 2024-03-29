Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7633EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 15:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqEDT-0007hl-7i; Fri, 29 Mar 2024 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDP-0007hN-8x
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:23 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDM-0000ah-MC
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:23 -0400
Received: from pps.filterd (m0136170.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42TERXd2016032; Fri, 29 Mar 2024 08:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=dIPH6ar9zyRs
 6oi4koMbKhSmQElVPkJdQkU7/ZSL62c=; b=fqk3rqH4qmI4WZd5479lqzOPE+Rz
 NmpC3u2P4fsnHqeeoC8HsnKqEpW/yyC6Feperjkb9SORzbN3pGzph5PxUmg5Yybt
 BPSzQ3FEnuJCdVZChwNQtt9pKDG/ODLjaDOMQBesgBFGHAY6QlBclvhBLw7FQFnj
 8YrZsInFAPKS+L6yNUOeYRBTh2yQklek/fDA/mi80AFRmiS4jciGIirCJh9Knb0m
 Lr3PvENUb/wwGZQi3OLyEEnElOdjVvAa2rnqjE9Jl+sDZ2XgzYJnUz6D6Zmh34Za
 lAibdodup8RXLn1Z0lUzKbu58IMAXCQErOfnXYDh/QU/Jm1JAxP2PvbgsA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x4xnj971r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2024 08:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj+f/1Lwxi6Lsy7K+d8dc2mfGO9nLTMIB9kZ2YHEq+5sjzeGQUm4EBFwl5Fi5JYnDJzsYrwgOVD/bR11E8hXfYGZNvmUZbziY+TXQMHr81HZ9F/vUH2fp/u4YFSbyCodA8XVhXvm2sOl2Z9WK8zeHA01iTmFve8FO9Hvp+JsfaTXpVJkFWt9R8J6oFVsEWvjw6yeZ1+RkX8nxOEWC+sWqtO1K8fG8Fb2AmGWMtY4q9pAE02/dmc9RRvEXA+rWcEZE7j7U6OLSqN0bMisiQOxDUm6nFNL3OGRJ0EyzrUCIP1WAX/pWSnC40Gcwq6yMA78GcpynpjhZuzrKXUWLTzvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIPH6ar9zyRs6oi4koMbKhSmQElVPkJdQkU7/ZSL62c=;
 b=A7QHf3Jnd8+GF1spHk3IbdfGDtT5DPvEvmcYN2rW8RcJRKs0g2dzpf+fcfOBQBOesuKyo1NOOGzufvIX5ayWFybUedBahNlKqqrS91ExGP1MxP8Q3M7R/zwcMdiLcYznWOaYIJTQhABYApFV1R+ovBCdEmruWxMvipm9FRo4K3fJDVE/tlO59os3zVfvKwFrddsFommsE0DekoL/TS6+G7qSfFu1/dSXIl4P13HjmQmukwaC5IHjImDoNuJ6L4P1mPB5/0f+DY31FOTFCh00z6Ni+GTBAs6DRPcuzt+7yttOXVSQR7RnSMisYzHD7S3KjiokuVRPSZ3Gqzpa3tVLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIPH6ar9zyRs6oi4koMbKhSmQElVPkJdQkU7/ZSL62c=;
 b=IIDjLgVMpp69+42w52UHbtnsb1HgBb/qihSGuGjZj82Rgw4C/KLNQG85yMjaQjboQkAHTrLfYpYzTZgOfWm5oG2Iw2psgmxvYB8YvvCun5hZkiGobu3zmBeXn6dmEQbXCiyNcf8WAmjd3bTkP0nOCqo12wuiYi+48ehbr6KsL0y+IjkXQEafgynZPvHvhbpb5xTikU0QeYIemvLiHwM3WEZq8DRPr1vrbGmK3/x1796aBcM1nRi/12qw6HzCCQCvRucEF0LZXdSJNTOHFzRw1mNriCIsPYu2GrCR7SSALsIJLq9XG5NUgx3USYw08ttkcSB5tKqelc1MpWqLAZZkFQ==
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by SJ2PR22MB3992.namprd22.prod.outlook.com (2603:10b6:a03:503::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 15:32:11 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::1f) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 15:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Fri, 29 Mar 2024 15:32:11 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 29 Mar 2024 08:32:09 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <philmd@linaro.org>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows
Date: Fri, 29 Mar 2024 09:31:53 -0600
Message-ID: <20240329153155.17840-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SJ2PR22MB3992:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a19df8-e8fe-4b0a-5837-08dc500566f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+a/o3wPygngkpXhw3/hasuB13mnKjVvL1fzWrD6ojby+NGJVaF69Pc9K8It6FHa2hUtRgAuuq55lzYNZIT0pBcQ0GrKmEB8BDpxCqbu+tCZMBl3R6GKRF3QSAJHoO/rG0dGbMVKI+di2AS4on7Y8dVKDIdDY03LsbxWaEIK0JCugj2zEebv61HU+X3dQ50hAdWeFcCJISkWpH17jLRmBhqHcU8yV4rvoRbcvfLZMUuv116AHYr3E3Nvv1WhBbZgOKAJpTJ8FQ0LxKN21Sy98/qpE8/9b2fGg3AbnxBH9Pmk+q12dpwPDkYvJm9eCGaAWAOPp1J6AhayZas29eKCBFD7OM5HTS79/o75IfC/nMUBJvnGIC+TdTiUqk9qso4rH1b+q5yB5qkMddUrT8l4hmcz06EtP+aSgAvdCotLG6mYtf6G+ldzLJ/ZSDMuGifHMtHg28jzwVdyFCR0Tj2ASObVyKzGveP4E9TagduABFwGi2HjH85IHh/AaAm6wZiCycS6Nx1D5Dthjq3HPGQDMW1InVjHcpX7zaCfyxi3KUF1ZZtvY3zaXomr03bMRXneUPu3SWJEyAk0hCRZl5Nk+NJD6n1Fcv4CZBwOQVylS3NjT/5relmJnGfDlOacWHjxyFORcUBHmpHAtm0ECC5Y/9L6nkk2sXdSgTaNrubvyrk=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:32:11.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a19df8-e8fe-4b0a-5837-08dc500566f0
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB3992
X-Proofpoint-GUID: 9izebNGypzFUTC_-xlqR9uP_rSdlZM7N
X-Proofpoint-ORIG-GUID: 9izebNGypzFUTC_-xlqR9uP_rSdlZM7N
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=702 clxscore=1015 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290137
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=88182a685f=aidan_leuck@selinc.com;
 helo=mx0a-000e8d01.pphosted.com
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

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys
for Windows. This PR is based on Microsoft's OpenSSH implementation https://github.com/PowerShell/Win32-OpenSSH. The guest agents 
will support Kubevirt and allow guest agent propagation to be used to dynamically inject SSH keys. 
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent

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
 qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |  12 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 893 insertions(+), 58 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.34.1


