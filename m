Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB4CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpW5W-0002W4-Kz; Wed, 27 Mar 2024 12:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpW5S-0002Vi-VX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:25:15 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpW5Q-0003Gn-55
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:25:14 -0400
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42RF1C2g009268; Wed, 27 Mar 2024 09:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=jOiq8je/ZX39
 LtBoRUAM52d7LvtwzVKHus+zlJtzsG8=; b=InYCl97Vjz+FCkDPWSmG3ab5CU1y
 NXUrd3zCTbfbAjnbgi7Ytkk3MphfhbRPH9TUMXoVH9Kp1O2SGXsjTH/FVRi0FJrb
 3Al/edTTWMXrDCThZleuhcQm91dtB2PZfeFnGwHab4/Yf2aICdLBGIh8CjnhWVOt
 r1gdQr+ttm2slb/xjXzOXk/iLzG0TuoDDXIvEWCZccJu3fXeHvZpiMI48dOFTX2y
 8obi9+QFeYAMl4nizSuuY4r1MzRIsqI1NYxzsdtBK0GACOokLAXXQWOIwRWqygIT
 x0smE5joY9Ie/YtGVpiX5eu461a40nvZhPf4dPP+RAQzhVfBRIfZ9aV9Ng==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x430j8pfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 09:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0LF8xFfzxQQrKgKsdrNExUTFRbX1doL27fEuZQm3EsAbYmgXsy7o01zJPPuu8HIKaFisgLobByKr23fxBflHreKJdif7At7V2N7uTAzr06nTwyYf/q6OOQweAu64wb83MIl+8n9nsE0PzWBojI/E9Ky+2td1lar0nS05zIdcDxZI/mSSkATxGUAN7sUq84NUrdNLDCkkD0hcEbFWUKHiXjm+nqW+UQ/GdFrW9EThcLhcTflxNemEtdx1Xbdn0SWYxtf5BmdrRIZOTx5ileIZgdTSToBPbwlp76wiE71NWZPPUhjYzs6iSpZsfj1FRs61ED55buCmy3mACfdEPBJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOiq8je/ZX39LtBoRUAM52d7LvtwzVKHus+zlJtzsG8=;
 b=ds+3kG1Pv6ezaezHEWuTH1iUslmg/nMQgvlyadpVS35/H1VXGjwZ/DN6j1qezUwyupyOvhquISNEwE9x+yUvF1lN210BZXDahlenKauDkU+A75M7FEQeZer5BjUWJQ5vLuCyp50QqSExwTa71gGwyTOKUSPjvR1gJt7cALarCRMdq9N8RaCJF55tcYvAHtW5r1MeYDa4N9o9OBAj1P7grbShU75zWmdTu1SeGg4e24q0x+BTjqTFmFUuhDCC+9hje/J4IcgMlEWxti/Zbetg7lijLziU3wXXiAgdQ+hQVWQdpry9mC+qXeuiYpAaLXYQ1lu4Ce7o2ww3UvQ3YMAMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOiq8je/ZX39LtBoRUAM52d7LvtwzVKHus+zlJtzsG8=;
 b=sFtkuCvwKzoVYBRuX05yB2G/NvEoNs6X3J6sHy/fItHmolt2m4npgnECXSNKROzON2UoGQxAE8OaS64nL4ov6PTP6VWx3Zk/YvASX+GB1PVY9LwfQB/wKrQHnNFXDMKIbQxDZTgPc0T3t+waphVuo81EfQzRXYwu1DP5ttMKtWBIKtXpO8jLzhRVjx9mlOUK+YahmeRvqw3/kpyQnVx7OHYZxUYKn5HhmDe2VGRjRZCJo5sIww1M7xL2WiYA3bWUrPS0UgexR5VmkxT2uKL4p5GCYGwx7HkrQTZHdB1OFJQKtOYl7vK12BxYZBiXkbv5bH25Vb2c+FhPDUFQC0RhUA==
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by LV8PR22MB5456.namprd22.prod.outlook.com (2603:10b6:408:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 16:25:06 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::f2) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 16:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 16:25:05 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Mar 2024 09:25:03 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <berrange@redhat.com>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v4 0/2] Implement SSH commands in QEMU GA for Windows
Date: Wed, 27 Mar 2024 10:24:48 -0600
Message-ID: <20240327162450.888453-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV8PR22MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: db2e5f06-1627-493f-2143-08dc4e7a7625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czM8631XQqVLvgTf8LOWKcp5udpvbKCXpY/aChc0sE2aN8+UeCWShNuNxY/SLuQHpmD95aZEHlxrW5TlSMTP9fiJ+9n75on9U97JdNOTHCadfpceEEp1cVbOXdch0xV9So0NQRYJ1e+qnLer3oyrMxb0ZBVDCwrro911GFBxZ9smtTSGo87Dlr2VxAuh6sW/x64N61r5wxs+dnN3G8xc/v5kDs0RH9mQ7uIUBTLwgPwvMdG/qP0UNccGOvjgYGE/2SHSAsUnj6nLWxWRLz3m7Mfk/7NxETxJCuZrcBTJFGxY5bU9IHpq/sQwMtu60quLTPQg6IBwXYTJ5epMr0fUjauMgHc6SMTYimITkphMXe+OTkEwBVSt9WK6XI5WkiM5mf/e6mq0gnz9NtfJ0iVUXh0MmUxzGPdVYnJ77+QW3J7UYxVOVSeRg4jc0T7rqUT2AZVoXpdDQxj4dmg0nZzh7NbN9Kt8b0H9b79XQanBQvmFvZJ0z8Udnc0nrGowR6vrrSQwpLIANLoYEFcf4Q1WHcABKPQAdzdcU9LE2vQzDHhb/P4fvisKU501Npe0/A0Wlewwmg5vSSb0XKlFN39gbPwtbPi6oa4GRhpYlipnJTYj/+q55g7IENZ/lyHe0KhDJwLv4ATAW3ZEldZ7dR2SIJGWubydzyVgghYJltvsiw4WfVvB7njpG1GUBqBPzGdDWjQM49a5EqzYTXFNcyleHA==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:25:05.3482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2e5f06-1627-493f-2143-08dc4e7a7625
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5456
X-Proofpoint-GUID: 5rMFYZckmTlLJkOU3AHUkmfXLO_o7GDJ
X-Proofpoint-ORIG-GUID: 5rMFYZckmTlLJkOU3AHUkmfXLO_o7GDJ
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 mlxlogscore=710 phishscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270114
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78160ec3c5=aidan_leuck@selinc.com;
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

 qga/commands-common-ssh.c  |  49 +++
 qga/commands-common-ssh.h  |  12 +
 qga/commands-posix-ssh.c   |  51 +--
 qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   8 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 892 insertions(+), 60 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.44.0


