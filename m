Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCFC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprsY-0002td-HB; Thu, 28 Mar 2024 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=881719a93e=aidan_leuck@selinc.com>)
 id 1rprsV-0002st-Ga
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:41:19 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=881719a93e=aidan_leuck@selinc.com>)
 id 1rprsS-0007Tz-3X
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:41:19 -0400
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42SEhNEP001504; Thu, 28 Mar 2024 08:41:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=WE9ALiH0/uCl
 C6/yRUByDpTzKZ0M0OfKRyTvl+XREII=; b=tEUkeqHaLXdrfkdVIaFNmuPyril6
 5z3rTlZc5VXKRQGMKpcIbOLG9r5tyWPKiNiVCUc4fqUqv3f1DKRlYrBHDKDV1vLG
 K+eG6W+RcJ80d4RAEgN/7y+kwiENuDhovOozEzZhjz3QisnDB1UoAqRad9UVDGIY
 kE7ZRnA7gO9r7OlNIZ1jVtIN+lAT39TJe1ZUTDe98OtTcer30L8P+baRSMrXU93o
 p62nQrB8M9568LLb6RC99JvAqur4JgR67iELtnfEby4m2Nee5M27NqDsiM07M06b
 irxAyr/bW1OJiGxAEC8L7RDBYHaXNWzjeUMY8jHredmji6hqVEydJA/D0w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x4xnjghac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 08:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/m2tLt0dKh4c19cHPhouW9ifMKaiU/Dj3lOJB5C3haCdzvfCRcmKug5YAKfgOk9w+NpTTCVQZpVnZh3fpOqdSzmZVuZ81eVAUUasS01JtXTow/0p00pRnnu4E6RwGTxPvVWitc2utir3cuUiiGu1U+UZ4DSKGrrTusZfgim6NjyL9BOhoGwLFqvRe0Vt1B1BtQ1J2h353RwM7BZZNXakGQKLyhTaG0SgGVW8Y7II3QjQwEoUr6t29kV4RAils3uyI8BYRU18/8K0xaOzD8dlRBJxUyuegx6Rou5SGb1pMvvhH5vMzVfm7mjoeZd6OJbukkynbW0l9blr/1gMLZzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE9ALiH0/uClC6/yRUByDpTzKZ0M0OfKRyTvl+XREII=;
 b=Up7KP8Ndok97LPLgiQw06zpNDvLk4C4/k2XUrosa/LMdjdEsFyL510sAjEhjwQda5+8OPL6rY0g5UecjjsBZWJdN7kSR3b9QJh34+vlwyb0GWgAKX6Y+/gSKo0EtsWy+yjiG8MDFE2Xbh3xf0XDAodmOdQOQE00LMlvK/dtNDfbBH4eHBMHwrWtxHvw/1Zcn6Ud/SXuhlSGN1B7tMF/CJK6TCnAn1v0/eLgSiq1043G67haGHbbhzBYCd6B5E3PfDEDluGUttXI9MINEiIO4UF5U5DQMXl96mw4tVUgTvICqCMTuqrye9azxhvA4UmDBshD+/wrI79/zfqKP2nF1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE9ALiH0/uClC6/yRUByDpTzKZ0M0OfKRyTvl+XREII=;
 b=O+qXB42Z1MugpoifJw5v9DdUMjc6RGHmMA4RH4/L2Bf534z66KIw7leUh9lb1EdIdASHAliGRkB7Q/VyndI54RYMg7vdTlUZ3QcokAR80K10II1Ri0Qo+ZdsLFhqx5UOEAAtOjbwx6xPIO3Na8BOor5fav7cS/NGMJf/o2duNVd9RsJ+6o2OwYqojt4J/96DwWV9Jik035jJn+j3wStsgJqmj/6DBmlTW0fbI/wmS9TnkqIsSlqA/Ma05877WKnZJk0NKEKw/zrvnFNXfT4+iKp/kO5a3WSCHyMcjsFmCXdPTDbW5HTRjGkwxwnIc4E7k6LFe+SKnefJh6xzLy+OqA==
Received: from CH2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:610:51::20)
 by BY1PR22MB5630.namprd22.prod.outlook.com (2603:10b6:a03:4a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 15:41:08 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::7b) by CH2PR15CA0010.outlook.office365.com
 (2603:10b6:610:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 15:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Thu, 28 Mar 2024 15:41:07 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Mar 2024 08:41:06 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v5 0/2] Implement SSH commands in QEMU GA for Windows
Date: Thu, 28 Mar 2024 09:40:47 -0600
Message-ID: <20240328154049.3090753-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|BY1PR22MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 451ad921-916b-4795-451f-08dc4f3d7c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upeu6tujHsMy3eOMIjI8PH4UVgJ4bRwuKRaw6EPGIK6h9nZMdeGpg0pwZ+x2tLYqp8054aiY+VPcX6W8ijzRKjDR6Iiz8kFK1iEPj2VNGwh3GvypSSREydHUVWHI94+XeHsEJrn5e8woSdS6Uf9LaS0LJfuNZEqgyIkg7ZoliudV/Crp970HN7asEp8NzwAxZz9na3DexWsarCiKGGLMozM9f0RzQ46FFcmftv99Fdw+kWgKOSiZV3D3W9A/3TZPs07Zx1L/JqnkeboOx16UEtMwPxXfFmZY7gEM8IcOT9jsMt2zsXEgkQFPNNhv6AKNcd6Yj//Fh2SLkSBlKLNfe27d9jGXlqrUVagk9zIk98rmxjbFGKAbBvx6K5By19CGeo+Fj2K5efrCHMw9idT6rQtvFo0HTTUxFM4ZucorjZza/JXmEKuuWeEEqRuPo4gGQ/bMO5o2/4IHDswHd0jQXqXcXXQksM/6mrLALya8+63lJzdlzcGFoQGn5Vqso0/GoiQhqvx/m5AwmsKXSq21ZRc2ZsMPPL+wHzVBicJtR4nZjIwpW59bG8GSbiUeBBBO9MqsNDU6Ohq0PC0IEvMjbZuLrh8UUujHkAelXznDwsn/myYngqjZX6K5+lwxaNtfhrcA4N5Dgwy+k7EWA8QEFMH2JULjHfQa686OKyzjv8qnaPHq9chaadoExnEDe3NWHMH5Mxp2vNBfTZlVp977ig==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:41:07.6528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451ad921-916b-4795-451f-08dc4f3d7c63
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR22MB5630
X-Proofpoint-ORIG-GUID: t7tJgfcMMZNPe8hi-WE7VE1INfAl52vM
X-Proofpoint-GUID: t7tJgfcMMZNPe8hi-WE7VE1INfAl52vM
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 mlxlogscore=637 lowpriorityscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280108
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=881719a93e=aidan_leuck@selinc.com;
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

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys
for Windows. This PR is based on Microsoft's OpenSSH implementation https://github.com/PowerShell/Win32-OpenSSH. The guest agents 
will support Kubevirt and allow guest agent propagation to be used to dynamically inject SSH keys. 
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent

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
 qga/commands-posix-ssh.c   |  51 +--
 qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   6 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 890 insertions(+), 59 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.44.0


