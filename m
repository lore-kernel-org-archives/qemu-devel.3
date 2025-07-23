Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87A3C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 22:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uehmL-0006GN-KQ; Wed, 23 Jul 2025 18:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uehmG-0006Dk-Fp
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 18:17:32 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com
 ([40.107.223.88] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uehmE-0002l4-4H
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 18:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPn3/yI3mxRcimmXgzP/Gq1MwrpQseckootb/4PkqxNoeQjtaTHUrTDjwGDMgaWavLBrwtWVqqtbRGaRDv8SNG30UIzp8nQReFG9tLguXAWJiC8Wx9mL5QJOdHM9ddrhLrinhB8G1gfcIB87gjQcWHB0us4BDuENSsaaIMh4iSjyKqVbtIs+vRFxtWZ3noGAlZAYrJs9kMwEYP3wCF77GzmgqoSMsRk7fW0oG94mdgvlaERBXOub/KEN/IGp4rbbauMWurrtAB15a2uHuN1vligKLvnS6zEKMegAWIriybsqyq8ER97jIZPxKzPA1dtdD+XrcNZrq0MCmcUBTBznYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is35CfYhkDahk3QY2IkosIUPdxi+6y8Hx4TEIJwlXKc=;
 b=cS+3Cp81cxWHow/DNR8HVjkRbFgdKcx9iIOjBBOuRKZUbe/cr/3fQZ46PCF2aro3Yp/tkQ6oKEXyMX7jHg4w9wxBBog7AYbwwkqrpQePLjVIMKZb5ZkHIXtDX7aDL9wWNcHIJohXLWzOCIj35ebMgvxLG5koz1VS2th3biAb/iLPzcwlgHS5MOtJT10pqL4ttN893ZmmKoGHP3NwlE63QsBjf/jjOfnpmSCAVuFmdXgv2li2cnqPAE/vKeUtip4ctLCxauVyvsMVWyFu9rz426TQrRNtN/6mJhaj5zJuTTp2z1v/4riIFS0I4v/moN1jPZREEqdAh/0kdkpzFyZTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is35CfYhkDahk3QY2IkosIUPdxi+6y8Hx4TEIJwlXKc=;
 b=exDbMRQa6YMs3G7oc6zMGj8MHaZT+2AKzIaajVVZ2XsWcm/yxjZ+uLTBmQ8l2v8rhMlPDmp1r4Y4/fL58J9xZxxMZTamm2u3Ei0imsqxIuy4x0eoxn1R9A1hDUyAXfn/BkVdxyI/DTGQPb19R+Z6VTXos+8NdpYKhuqtVoMEJmA=
Received: from MN2PR15CA0061.namprd15.prod.outlook.com (2603:10b6:208:237::30)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 22:12:23 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::2f) by MN2PR15CA0061.outlook.office365.com
 (2603:10b6:208:237::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 22:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 22:12:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 17:12:22 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jul 2025 17:11:55 -0500
Message-ID: <175330871526.2488448.4100316387161263035@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2f1291-7224-4fc1-a5b3-08ddca35ffbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1M1RENJTG53Z2M4OTFOK3RkeWkwUlZEMjFMRmh6dmhiS3lVeGxyTlYzTHVs?=
 =?utf-8?B?UXBNcnZtVng1QjFTZ29sbW0wUFQyaldCVXlxYVBXTUVhcHJxQmZoYnZDUU1B?=
 =?utf-8?B?M2Q5YWhNSXYyUVpoTWlwVDZxL1RQUlc1OVc1STRucEwvQS9US2NJdWMyWlJ6?=
 =?utf-8?B?MU4wa3oyd0hydXRSVkZmMDQvOWRNZGNSSUM0NDl4dm02NG5JcVhVMzQydlRK?=
 =?utf-8?B?OTVHK2s3ZGV6dUcyaGtBTWhQV1JWV3Z1ZTN2cGhkdmhCOW5DOG0rSTVoaDZ6?=
 =?utf-8?B?b3lPKzZFSFFuejNHWWhvN0lUS1NHSTRHTmZrUUpjRDZjcDBoUnFzS0V5dWsw?=
 =?utf-8?B?L1ZyM3h2UTVVd1R5QUFtYlVpZHlGaTM0Zm16cHRtMXFTYWU2SGh5V2xyOEFr?=
 =?utf-8?B?azdJanAvaXJBN0c0dFE4SGR4Y0pseVoyNVFxYjdZN2kvMllOZHN2UnBzUUxH?=
 =?utf-8?B?cnZIRHZOZXltZjFiU2YrSy83Y0hiTmVKbDNjY2YrQnE1Q01IRXA2WktXakVy?=
 =?utf-8?B?ZjUyUUFRcVA5bkdvYVRMT3IvZXFMOVB0bFZndElkV0g2dmJvZHRtOUFaSk9W?=
 =?utf-8?B?RGZSeTRQdXNqMkhYK251TDErVkVST0R1c3VUNmZramJ6WVZURVRLOEhtTXhn?=
 =?utf-8?B?YWs2OWc4MXVLMDV2MjhQSDBwdVhPL0Nvb1V3RVR0OTZnRiswNWFDNUpFVUpq?=
 =?utf-8?B?UkFwZm9XQ1NUWXNzV3pnejh3UDIvc1FxbDdJYWcxSDdoNzh3dXBiMHBqQXo1?=
 =?utf-8?B?K3p2TFpNR3JZUlI2aCtrZ2RXbzhNaTBaUWlxM3ZIbmdOT0NzRzdJbkFFZ08y?=
 =?utf-8?B?QnE5RGF3S3pNVFVYQUh4QjJFYWFOTHVMcWZYU2NTVDZSamlITU9RZlZ0Y08v?=
 =?utf-8?B?UUtRYWtZaTE0amVtY2V4MHZ5VVJpVHp4MzY3MHJRdEk5Y212QitaVTNwWUU3?=
 =?utf-8?B?aUc1a2s5RVo4ZFFnMFNpb0x4L0xDQXpSR0IxTjMyajJaQ1dpY3hIVnM4RG14?=
 =?utf-8?B?N3hnRnhkK2psMkNEVHNzRHJneU5pQzZSYUhQZ1M2enBNb2s0c2RDUThxZjVD?=
 =?utf-8?B?UVl2dXR6S2FNVjRoQjRXOHpXU1JjTVFoaE0zMmdlQWMwM3dqWTJqQzJ5SkVp?=
 =?utf-8?B?Z2E1V3VYZ2dEN1N6UkFyYzd4OGtWc0NDNFJuVzUrRTN4ODB2YnAvSmhnSW1y?=
 =?utf-8?B?NStIaCthR1Q3c3BPZlIwaUVITmluZ2hRNWg3V210N2NBblFmSEI2OStVVnor?=
 =?utf-8?B?L1hHRFdiaTgzTHk3ME5iUlBiYmxUWU01aG5FeTRTMHJSbGVlRGRHNTQzVkY4?=
 =?utf-8?B?TXVMK05maFdCazNnN0MySEpIM2UybVY2d3dFZm5oOGhqME9kUDI1ZXlpK1ZS?=
 =?utf-8?B?NE9BV2xvMDNKY2UrY0l4aXl2a1lJTVB1TEJ6TzhWVkw3QUcyN1cyM2hGVmNG?=
 =?utf-8?B?eEg2ditIM2UyYStuS2RVYmdBTmVxY0dGcDJWd0lSRUQxcUdhR3R1MkQ5Ymgv?=
 =?utf-8?B?WThFMGRGZUFlbkNjSDJKZEM3eVJnNFhZR1d2bVhkUW95UjFzaUo1NldYb09E?=
 =?utf-8?B?WTFBdVFMcFcwS21OTjJXaW5nMncxVjZpaWpVTjdsU0hKZTJMajRmNWl1RTRX?=
 =?utf-8?B?SjIvcVhScERLN1ZkcS9KazlxdCtJWDk4MW1MQnR1bDhrcm02b2Z6dHNMZlBk?=
 =?utf-8?B?Z1ZmQUliZS9EUm9LeWNKKzFlZWp1QXZCSkhhNmRacU96UkI5M1QzUGRHVUJZ?=
 =?utf-8?B?Y1g1UkhOa25UZkxRRUpoSWF1Y1Q1VkhaS3lpanZUOXFwNGN4Qjhvc25PVHFR?=
 =?utf-8?B?VGlkTFhFMmtaNXNON3ppSUhjaDFaUHE5OUhEMk1lK21JS2Z6SUdaYTVZaGN5?=
 =?utf-8?B?aDl3RXd1UCtPN3VQYVh0WTFTM3hGaDRvNDBVRFVidG9vMkxvaCtBeGp4SmhY?=
 =?utf-8?B?cjhaZTE1S0lFYjY5N0E5QkVUME1EbXF6UjRzczZ1cnkvU0w0dmlibnBvZk92?=
 =?utf-8?B?TnZ6NFlzQ3hBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 22:12:22.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2f1291-7224-4fc1-a5b3-08ddca35ffbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
Received-SPF: permerror client-ip=40.107.223.88;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
first release candidate for the QEMU 10.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.1.0-rc0.tar.xz
  http://download.qemu.org/qemu-10.1.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 10.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/16

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.1

Please add entries to the ChangeLog for the 10.1 release below:

  http://wiki.qemu.org/ChangeLog/10.1

Thank you to everyone involved!

