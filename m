Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9036CC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKxz-0004LW-Nc; Thu, 21 Mar 2024 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78105fa443=aidan_leuck@selinc.com>)
 id 1rnKxw-0004Kn-Br
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:08:28 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78105fa443=aidan_leuck@selinc.com>)
 id 1rnKxs-00074G-3X
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:08:28 -0400
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42LEPx2J028890; Thu, 21 Mar 2024 09:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=cfo1vGQzS/Bq
 2MuBkkwkDXR3+Gjdf8KkGnJbQkaG7O0=; b=ZC4roUyoHireahayohNgtdwfGaWA
 KkByKr7K9nJao2XesC3fblqmk1DXKP2kmIc6BrQPtXU2lWQY6PIqFRtxjBqVRTiA
 IBZnI5tZvd/A1A/wn3FExforhU8FkV47WuighlqbeHSZnA7bxT8v2EGQd9PsX19t
 3+QgtAGzt2+d4npSSV/lClANWz7dJz43JPTOG/NbxvOSIIng7MX2leHEFDOjVxPG
 so6KSY5swDgnoiB6S38AtUHeJwCidJ91WPyI9j5wNg2f3LEV84cPRAetA1aFzT7i
 F0A0ZTBBSL/5Gv7TgrxrzdXHfSR0p2JjpUplzePEYpIi4raUdJkFhwLXjQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x07y80fuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 09:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrrXDrunKNw45EBBGPAuQyELbq6v9GkgthcuLcOUHwTlhcPpVcvETEv0FsPb6R/oHvVqnHlzSm+rURTZeLvRNM+yx1+Ewnhc1ZauyLCHLaSHP5ko/BZM/x52PU/pRCHRn96D9bfmXyuKnr7nMxLEyI+pyhG+PNXUZQoNpISbKJdLfIq7/tZTK1IUgU3ufbiX4Pkkehl2ci2rBMLduwJtJR/BOi3G8Qikn9vLc4VTIqHDgiq7J4KwNwCgeiAxI7O2lzEYXbahXQK27koaEg0wfCET1z5RtXb45iV9J0lkp+68IUvmBWvKlnl2qZ05ppeFmiiaEfuRwuOv5wjDlCqKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfo1vGQzS/Bq2MuBkkwkDXR3+Gjdf8KkGnJbQkaG7O0=;
 b=Sj36bKRjj5GPiFX7CNEqItlLwCg5+YQmvP0/LdzGLUJvTrMt5X4BpvmHRhw8ycfnAXYKVPUwZ28xPtUsgSYsmUgUgPnGzLaCdo8U8iSNEC//aW13m+4mMIGBKE7xmMzvJ+GCtamDC5EujuJzQoYaRRh8RctovWWJut6H7zZsf2Qhz7pSR7Jncd7klDWs4VD4DB98wmHDt62lJGrTpGv2FPmCXb/JWzBpyoov/TuNYbBZ6QOhXq0ySjnsaLGrEgHZm7LAOA6LNPiSohEMpLCqOI+8cR5Livbv1GewI3H3sdM1jf5gM35aQZ8UdAxBXotpvyyfwC5buIk1UOLpI2Vhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfo1vGQzS/Bq2MuBkkwkDXR3+Gjdf8KkGnJbQkaG7O0=;
 b=nV/i8tSYBppKEPVJK8RgT2QwuEnHl31lV8zayP4hWAdHlq7t8XVqROwuB1zNutTHvH/Q2r1gF+553qmIT1N3GGU7BAxgpyN5nmHOVOdq1+43uUuaH3uD5p4Q+G6nvsLXMV0eox2i8Wj1ZcijOGZL9i8/JzAdufLuX3u4DSpgAyq12kTxcsswVZ/G69USv2J/6/zvv7rYiMr1TpyB9j5aYSPWqhA5f5VfekT/eL+KDA3GjZXM+IRU1syPzZkDW4Go41xQpelLk1MWgqQ8enF72/mtn3VNKZK7y8uKj2b41tc+eZHzYik7o3oj+8hHpCJBw8pNNNn4e0noZSuAcJjIgg==
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by CO6PR22MB2883.namprd22.prod.outlook.com (2603:10b6:303:14a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 16:08:18 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::99) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 21 Mar 2024 16:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 16:08:17 +0000
Received: from localhost.localdomain (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Mar 2024 09:08:16 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v2 0/2] Implement SSH commands in QEMU GA for Windows
Date: Thu, 21 Mar 2024 16:07:23 +0000
Message-ID: <20240321160725.340341-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CO6PR22MB2883:EE_
X-MS-Office365-Filtering-Correlation-Id: e6083c7c-1f44-4ef1-c256-08dc49c11f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXTxpuNEENxrMNGVp5nBInbujQDC6vAkRREiBj+xGVlxGGYRFpVP2v6LsF+dKiGCOBvvWQiBFn6azVV5rEaqPsf1R1TnfnN+RP/tufe9FAXy4UporDPkDhEGn70/3VwObQMh2o0AvOzzxme1p7XpPMGNemkD5NLit//Y3t5vw7tYzWV2GF6GMEfm5H5Fna5QnfTisQOKv2DF4fzFaamGTp9L/9ZqcFkXykUXpZhOLVMRwxQua4KDfEhY32MtbSWwOuVsUUPlZC9yxo58Oxsp8rHeBdr/4Na7qIqvnRQUUWJRGC8W4Mxjcus6a6k43Nd007d741/IcyQg6H89nOdxGqDT4xXao7iZ4EyaaTk4rqpqrdWozHk+BhFBTnOjbLYeek4ZUZZZxR0qa9yw6K3wTDYX02oBYk3Zy6oX3l//DiRdwbtIcM/xi2C87JSmyOK50RQxzaLmKXzEv4otL0CK81EnHdjd1fRAgYCK0yP1Ce5a+L0VF3yjk/WzPzyBOL+jRj2XMmlsF6eDgeBybL92DUNHEzX97U87FJ29XkWvKn8xh8elGUFSWfwrWUAnoITTl6rgyav5QiATTkPrRqe459RCjkYKm1/L6tUHdj4A+chIhHJ7cech+i9JGgXUzUIuB/0Oh+BIRDqiyMXilkGiGgw7SoQ04YU+FeVAPlybC06FlQJJ5Me00mYR9CwbcYzH
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:08:17.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6083c7c-1f44-4ef1-c256-08dc49c11f0b
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR22MB2883
X-Proofpoint-ORIG-GUID: PJHf-9hq8gcahWp4EbFbQ8BOTiqCBroE
X-Proofpoint-GUID: PJHf-9hq8gcahWp4EbFbQ8BOTiqCBroE
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=690 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210117
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78105fa443=aidan_leuck@selinc.com;
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

Changes since v1
* Fixed styling errors
* Moved from wcstombs to g_utf functions
* Removed unnecessary if checks on calls to free
* Fixed copyright headers
* Refactored create_acl functions into base function, admin function and user function
* Removed unused user count function
* Split up refactor of existing code into a separate patch

aidaleuc (2):
  Implement SSH commands in QEMU GA for Windows
  Refactor common functions between POSIX and Windows implementation

 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-ssh-core.c    |  57 +++
 qga/commands-ssh-core.h    |   8 +
 qga/commands-windows-ssh.c | 784 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   8 +-
 qga/qapi-schema.json       |  22 +-
 7 files changed, 894 insertions(+), 58 deletions(-)
 create mode 100644 qga/commands-ssh-core.c
 create mode 100644 qga/commands-ssh-core.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.44.0


