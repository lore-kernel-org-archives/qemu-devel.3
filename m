Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66773CD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 17:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnizH-0007cc-Ij; Fri, 22 Mar 2024 13:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7811d50a34=aidan_leuck@selinc.com>)
 id 1rnizF-0007cR-Vf
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:47:26 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7811d50a34=aidan_leuck@selinc.com>)
 id 1rnizD-0001uL-1l
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:47:25 -0400
Received: from pps.filterd (m0136171.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42MClIob012637; Fri, 22 Mar 2024 10:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=3YP3oqmqoYxL
 LM+XJoiOaHsnYQ7IJasfb9tsvXaH81k=; b=rBxOi9kzFagfByjCGbWApdjhOylD
 N/aisnFDhTpMLSnfcmgLo1GYzoKRCuOY11uShZ96SEUpB+63C5uQTBJP+bVa9GR/
 CtuhzxR9+O23e/6RU3Sa3Uz0dK7jRN9xYlfXVfVZyrwpvRpFI0T8Vd7RWR8BhZYi
 e+3lb7VLHFRfkfTyq1np7Hb+WDFTWGVBx8fgU4jBWDsnfQbfCX3/piohbB3CynYB
 PW0QcFNrnaKS62cptPpjukhc+LT3KGFByA/vJDbg5TMM2T9lN9Su+Uqq32nsvJgj
 +I/yfCt5j/gPfDmUEuPSg10bIwx8iAj2VrhQdrOoPcQETEx6p0KV1e4BzQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x0wy4ghs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 10:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbNO8SS6aE5W+2XxQorAzdEPOpv128GDYv/tYvyTRxWUAP4NQ7FsWgLIuBqDqo/VHop2f/OyKR03yZE4dSaeTFBDncbEmuMY3vablKAjlwbI+zdGy5enRnKU3EtQvbJ7TmgGw4sGUAMr1pD0ZLfUI7rHovdw7dcuFst5E6d2zdtZLu8mQapqvUKI7uoQUmF/zmoLokKcJ7Exw0/kJf8qBoeOcD80KiWy53cqhSszVd0C927P226i7qOTFSfDFljHDB2tIS7vP6421kTNXgU5nq07kDf5cP8YiPEugWUNv3odEaIFM7TyJPl0H6fkGl0McaGw4vBjHhXzpWA/BjU8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YP3oqmqoYxLLM+XJoiOaHsnYQ7IJasfb9tsvXaH81k=;
 b=SnGMQqfqGKASmzDbj6vXUTDRAgRaOgOl/TIRbW18XLeZ68zU7aLuPwZSTtJooHuwm8gavjZjRKLkyamehjfhuqmt4fsB//lRko5qfzvNKAbQnLj17dky8rRzYnL9hqiJZmKhik7SwJA/yFceujjJW72nvjGN1q9Mhga3dCmfuLLTw+T8zAAAn2/kvSn2qbZrDSpOCn7qW/BuSWvz/3tk+EibhRt6Wvd/iDlSjc5FIeidXuzVXfLJWnFJcWB20NNdgPm5fubsjHqOrJ56qtxXdCb6S2yD36n4ph1N6M5glRHeMd8s3JtRNxQFeKu9Q1YiQnPQKsypqKcL+LBjTGiUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YP3oqmqoYxLLM+XJoiOaHsnYQ7IJasfb9tsvXaH81k=;
 b=t08qvihjBI+5Tx7cjo2lyWt3ImD4oJt6w4gjxOLhL5/lOSE49cqOoY038/0aScFBTwrw2i/OZaZz80eP5kv9LOWnSTP8/D0ftfpKfcjbOq6L1t1Zv7MqyFtP2BWQf7PQPXvUkWXUKVkj4nUcXl3sI02ds+70Hz5vr7z1jgrfNab24ytxP6qde3+kwSf46tOOEW9AI3rt8fhCiS/w6N/S4OFP+1JK4TBo86c8SqDxjXjAClfacFnBZpjrDOkXE9MXLIW2HKbEqIjeLxPvqPJh4pew68PvBLPPu4lcrxVvp426L9W7+jUijgn9KdCRTQC5qfMjexgV0W7zgrNAeia/rg==
Received: from MW4PR03CA0064.namprd03.prod.outlook.com (2603:10b6:303:b6::9)
 by PH0PR22MB3200.namprd22.prod.outlook.com (2603:10b6:510:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 17:47:18 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::69) by MW4PR03CA0064.outlook.office365.com
 (2603:10b6:303:b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 17:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 17:47:17 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Mar 2024 10:47:17 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <berrange@redhat.com>, Aidan Leuck
 <aidan_leuck@selinc.com>
Subject: [PATCH v3 0/2] Implement SSH commands in QEMU GA for Windows
Date: Fri, 22 Mar 2024 11:46:35 -0600
Message-ID: <20240322174637.499113-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH0PR22MB3200:EE_
X-MS-Office365-Filtering-Correlation-Id: 066c3c2d-3e9d-455a-32c6-08dc4a981e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QkleSbsVsxo8t3jNO/TOQpXRwdK9a8mFNxdNIVlEjUJ7SKXi+UGemJg7HZ+4SEjcH96qZi+KNyVb24nHAa+Agrp2TbvvQ7y5oKJjyVWv0HJuUtxhM81AuxdQbXoxqu7ZjVCx+irnAc1z3odoQ8GzMYj18VI1xm8Xo/bRczO0MdLaETq+V9JQkdE9SwWe3DfLX+9S0OKKXVcJdNaNwEAGUwtEvYojPV8fgq4/jTGy82IjxM8RnsfwcdvkS2YFoVdj4vupxpNkdIsWMxk53ZrIHxh1+X4x5tUaRFQZqeYeWdC1WZmuEJB9XqQbh2ulaRkwF8wMuc9C5fh6q57n6nBrjxTurnxDq0Wj9NoN18ntSRuclRAnVQh3f/ZjioPHbB497OSMw89h5v2ZcNGGQaawdUFnSt5XZGlkTy44y1jQC7BPHEwNVZJ6T+LIxj95e9nSiGEesYr1/H7cPGK8u+YMUoLjTLVOSFIISPYCjknqex+Hij/I37MOhm8bXjlW+kqEYHWlDBDFZpnR0Szk8GA0BRnnYQpp8VWbRThPcPyysHz0TN1vY6WLlGUXmz/Po+q0d0qTmBV7G3jS2lQe0/YK6wCNvlqgzd1JflLO6jbIS6JQaZgLzcGsnspYCA5+mf9bIMnzQDKsHoGrKzkxiZtqsJA46hcJyCKMl8wu8RqUVJ3/OP5PN7xyLDRqHllrSgGsf5mooVES6XS40QKu20TIA==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:47:17.9423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066c3c2d-3e9d-455a-32c6-08dc4a981e14
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3200
X-Proofpoint-GUID: x4KSBfMr7cxhM9DQeFjTH0RfdnvKJDbX
X-Proofpoint-ORIG-GUID: x4KSBfMr7cxhM9DQeFjTH0RfdnvKJDbX
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=750 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403220128
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=7811d50a34=aidan_leuck@selinc.com;
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

From: Aidan Leuck <aidan_leuck@selinc.com>

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys
for Windows. This PR is based on Microsoft's OpenSSH implementation https://github.com/PowerShell/Win32-OpenSSH. The guest agents 
will support Kubevirt and allow guest agent propagation to be used to dynamically inject SSH keys. 
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent

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

Aidan Leuck (2):
  Refactor common functions between POSIX and Windows implementation
  Implement SSH commands in QEMU GA for Windows

 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-ssh-core.c    |  57 +++
 qga/commands-ssh-core.h    |   8 +
 qga/commands-windows-ssh.c | 791 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   6 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 895 insertions(+), 57 deletions(-)
 create mode 100644 qga/commands-ssh-core.c
 create mode 100644 qga/commands-ssh-core.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.44.0


