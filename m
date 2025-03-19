Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F54C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCzO-0000WM-C1; Tue, 25 Mar 2025 18:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txCzM-0000Vm-Uz
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:16 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txCzK-0006sr-Q5
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+UTuQocK3Z+X6ayAui/cNsyC/aQnv92qJ6xJn/FqfEBsi1PhdphUDTvb+IZ4Tivhkds9lkZL1lz/4RtY6nnRf6xZqxhklJVxi8BsTc1QZbV6kpDGYiPqNdjEa6/id5TipzdQC58EzXmAkvcUTtOAiehU0lpzylN9u3I+dDLt3OL5D6M30ndRgBUyiSwBAubJku5wGwnZW9VQrRVR2WRe74a57vMHhRG5Lk+983KnYdqpDRd8+ha7X5jHCGJ6gRBBXgvgmJY/kncC+KNcEyURt87ciyJYWO94LMEoAteJdao3ZSmDIqrnM0Hg9v+ZpQrozE2k8gd8QCDZcy226snEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdAmo88igy6IkK4/zTp0s+JA+J+eGwkGwEMeaREeflI=;
 b=YamNbIuK4qF+mmLg7/GsnD179ovvIF3IQL/xbvxXjsdvN1sNJrri7avijbaMU0glV6mRIrcmbIA4yI6STlDdts5yjrbOKYzQa6KOpLlflBzC4SeEOFYKHXLqH5KMA2FVT1qRYcSvNZFc4LjZfqPBgx/041+qPwpcB2scokoccislLV31esndxeVuk+HF4p3BVPy5/zQG2oxFhKeT++yV2FeS5WDrt3t5ooSpyRUPKGtOMDli5yeW8hKn5Ja3Q2Acz9V8gPAUdpdYKuz8lGs89plKSYO8nkWRAEwpOLH3ki0AC/JVyqgBidTiLl4q8c8eoS3FkYOiv1FAu4KbRHxrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdAmo88igy6IkK4/zTp0s+JA+J+eGwkGwEMeaREeflI=;
 b=hUau+8500103qXuqWRjCI7OuYobt51KmYSboWLy+bhsU7RJoPocn5TDDZkeQObwGBPdtuR9X2GVFtQpT2EE39qn1Bkz9W4m/oUO7Ovn8zM5bgSL/DtG02kaWgOXhelDwX1xV45P+D/DgKOOdlDKefNUev2RGpHQIXbW5q4IrdiM=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 22:38:08 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::3a) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Tue,
 25 Mar 2025 22:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 22:38:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 17:38:07 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 19 Mar 2025 07:08:40 -0500
Message-ID: <174238612063.1594466.4005439602392444073@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 805c23ca-5f76-4286-878e-08dd6bedb73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1Y3VXZCS0pDdUN4dnVDZkQxc2U4QnVDblBwRXZ4bVR3STlWKzVBYTRYVGQ1?=
 =?utf-8?B?aTd5ellzY0t2Y0I4bklaQlNWRFBQZjJtd3hCOE1tYm1Gcm52UFZUUnFHeU1p?=
 =?utf-8?B?SE5zL3JWaTlOZ3oybk94UzY2NDltVkFybExyL0dOd2lqZjhUODM0RGxCMUZa?=
 =?utf-8?B?a2Fvd0Z0dmhCUHpMK3BBc0RoSG8zRTg0bE9nQVl6eDVUSUdVSDczZDNWSXJG?=
 =?utf-8?B?OGRaek9sdHVJVzh2eThCa05RSVZGUEJOdTRoc2lFMC9TT05FaHc4a1V1NG9Q?=
 =?utf-8?B?Z1BsUEo3NVpJYURSMFB2clE0Zys3YXZIOE1MTThCTzdNVDR4WStWUktzUVky?=
 =?utf-8?B?Q09jTEkvVnJySWpXSi9TSHJKVDR6VGFib250RERhbXJ6VEhCOVpnMHdYZlBC?=
 =?utf-8?B?bWI0dll6QWhjSVRrVktSV3lvVlBSaTdkZjZtYmNRT0RySy92eC96TkFvNDJL?=
 =?utf-8?B?UmZKM2JyL0FWQ1dOYlhMSjBDMzRKcjlLUFhFN0lJZUNodkkzSC9sd0R3MHFK?=
 =?utf-8?B?UGdGZ1ZBOEJXWUREbTErTmpHOGtCQmFpS1hrTk5UQWdCMkdhSm5uWmN1VkZr?=
 =?utf-8?B?aFpHR1RRQW5CWHNsdEF2OVdaVURPTElLc0t6TFd2QmhKVzhtbWhsRC9HQ0c5?=
 =?utf-8?B?VjVJN0dXV2hsak90Vmw2TFpUL0tLUzJNUTBLK3J5NkFjNFkzR2xaS1JsQW9F?=
 =?utf-8?B?R1M4ZU4xaEFkTkNabjdVdWpUZ2MyMnJNNVRrSXNxTlV2WTRpMS91aFh0aFVU?=
 =?utf-8?B?YmF3YmpjemRSaW1uUXpJSXdwc2ZrYXpNMExGcE4wcXFTQmFBcnB4RC9wcWlx?=
 =?utf-8?B?T3lDNEZKcXhneXpaU21IcFdoem1HZStiaGRZWWN0Tm1iWDl5Y29SVFhoSVlt?=
 =?utf-8?B?QWloVitYR3puWkZ3QnFEeXdSTXRSZXJhK1FVTzljZDhmMG1MOStLbmRGVEt3?=
 =?utf-8?B?WnNuSTZzNVJBQ3hGZkVRUlpNamhJUEhUNEFiL3ZqRGp5elZZdmFZZEYzMEM2?=
 =?utf-8?B?ZEhEYSt3NHZObnZ1NVZkcnAwZ05QNjR3QXRlTThzcWFzQXlKbXhYTk91bTRY?=
 =?utf-8?B?and3TzNqQU5QVnZjQWVtWEVVRVNycjFnU0U5d3NiZ3ptT2lUSlJlM2ptTGE5?=
 =?utf-8?B?WStuK0krRkZtbkN0TXd6Z0tVZlhSTHQ0c0t4V1ZVclU1Y284aEkzbFhQM1Zw?=
 =?utf-8?B?eUdJbitCL3h3ZjMrUksxczBvejlrVWU2VWptUko0ODJ5Tk5iclVieTA4b3lv?=
 =?utf-8?B?b3hmYlhSZUhLNDdzeVo3YWh5S28zZUtIZGxSL0J4a0N3VGUxa0J1dm55SmJv?=
 =?utf-8?B?dEpzU0tmR2xwa0lMT25LRDRoQXdrVTlnSjNCVDZDbDV3bysyNzE3emc4N0pL?=
 =?utf-8?B?NXZQdVFVTkw5akVwd0VJTzJNWkoyQ0Z1TkRsMlU4dmNwVFYwckdGQWZrV1Fj?=
 =?utf-8?B?cjBxc3NyRmc3dTBzQ0o4emc1dmJEV3hubEUzTnI2alZVWUZmWE03OGxVbTc3?=
 =?utf-8?B?ME5vcUxYNUZqTmJZbUhOMHRpNGQ1Tmt2ejNmTHB4bjJpQ1MwQUVkdjZ1OE11?=
 =?utf-8?B?dldDeXVkelBBQjR3cWc2L1JZQk44dGpKTDNiK0xEVVJhQWJrOGhLOTk1VmV4?=
 =?utf-8?B?d2I2bVpLWGJOdTZXQkZZTXJUbERDL1ZCaE14QXo1T2Z4bm1WelQ3cDFSRXpq?=
 =?utf-8?B?alczRElTNHdKeVVmcGN0WWkyL0RTYUZvMzlwRE1IUnJVdHpEWFJjWlpndjVN?=
 =?utf-8?B?alNGYlliamxsVlQrRXVlWVFFcU8zYnpRdFZlOXh1UHByUEE3Um1Za2cwejli?=
 =?utf-8?B?Rjh0b3ZXSFFaZFdweHV3a3h5ZEpvQVZtTTBqanBkTCt0SU84NzM1QTdCQXZq?=
 =?utf-8?B?R05QRFh0MDFMUG1OUlFBcUJrSlQranFlUzF1KzBiWVI4cit1OEl6UHArOWdq?=
 =?utf-8?Q?a0rvw9/ZOI3ie6o3hofDKFiLZnwTrUKP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 22:38:08.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c23ca-5f76-4286-878e-08dd6bedb73e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
Received-SPF: permerror client-ip=40.107.237.55;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 10.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.0.0-rc0.tar.xz
  http://download.qemu.org/qemu-10.0.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 10.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/15

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.0

Please add entries to the ChangeLog for the 10.0 release below:

  http://wiki.qemu.org/ChangeLog/10.0

Thank you to everyone involved!

