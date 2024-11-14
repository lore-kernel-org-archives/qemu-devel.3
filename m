Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE283D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBewT-00077R-Ev; Thu, 14 Nov 2024 13:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tBewR-00076r-5H
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:51:43 -0500
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com
 ([40.107.243.44] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tBewP-00078c-33
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:51:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olXY4GZdnG1CD2gAbJZPqXxybjRt8gYZ6ge81oILvmQJu6rtSbYIqbc2reLIBgUIAz0jdKvw1++i2zNbATeEjMpsUJoTxI/Tg6xI3FMzxj10MTEknpPi3ZR3WuIf8Ux0B5NMK27/2u2H6FAtEtXsK5xDj7tGijSuHmjeIYtM9c6GItAFVXIUMWVh/GkVfRhcEDtp3esgWS/sMuJHQ054hVgAAE6A1K0dcCqzqRsJWabm7wQ6GE4i5q+2u/XLnyThRPcCu2JwAVohqbrXasRB+CVEdT4coFySvbsVxFIkbaxaOtXoSKXQ62lWiCv/akfxYu8EJNUd3nOMOV7L+SuDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTLDmDuj3ZTrp1qejXNrTr/+ueGA1Yviiiuyx2tQN6g=;
 b=XgzbCC646z/wLpITqwPCdwtrhonNFXMcJBP3Xd7DLLG9tVz6T0TbODBJYcT9cS8DhUC0iUiy1zm6DdKiLhiEKAtF+kKdTmtrdd3jM9yPL/a0sCl/77mWrBdUNOryIQOFio9vD5u5sCexzgQEtnYSKVvCpjxGTwKsXuVCX9B/Yqgzm2Fl+HRMPLj+HC6LHFbmZoxpf6cfBfZwbqQYFG6YZPIPR8BzQjJbmO6ZUIZctwtnkgdkPXXsnd8T7osEYk10R+D0OjJbRWP5cygpI3dd1ndenzpjpiaLkw4wl+Pl+7hkftq/cRNVy/c2XkqB7cvt4V2jqN5ynGzj9u+lu5ZGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTLDmDuj3ZTrp1qejXNrTr/+ueGA1Yviiiuyx2tQN6g=;
 b=welflNLBelJQDv9u8iURdBYR7jeZ2Fz7/e7IChwFUcGNFjgceFkC4wvS8yzL4E5FFjs9ONQ+ozou4nwypRlNQwDDyKMGvLh7mdMEKZC2WcVJp2tJPWRPJ+h2AO1mk9h4MnEtnfIErLq/YCt8jvVtwi8EipYJDeOQZXaOD1HSUg0=
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:46:32 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::5f) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 18:46:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 12:46:31 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.2.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 12:46:13 -0600
Message-ID: <173160997306.3341618.1930137864330082213@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 76084624-64e6-4d81-bfa2-08dd04dca810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm5HSVFJamlKS1BlNjJFWGtoaVVjSUs3YXdwWldvcm1SOXNib0Y1VVM0VUlI?=
 =?utf-8?B?YXBvWEVyWExTR2RsYk9IT1cyWEpXWWhOQzI2VjhHNFpkMUo4R0wxSGZsTXZE?=
 =?utf-8?B?ZGlLWG0rTXFLbGtYcG1lQjdZd0VPdWNRMFVpd2g2NmEvNnJIeEtOamJHNHhq?=
 =?utf-8?B?SDAvelRkb2tKenoyeEl2Sll3WUVLWWcwSEdaM2NOY1JPOStWNmtNKzVKNEpa?=
 =?utf-8?B?UktaSjgwdTJVajdHNy9lWUJWODNiVzNaeUJaLzhXS3hDVkVCNTU1RFpaczI4?=
 =?utf-8?B?eldaMWhHYVdnNUZxSmZPWkl1bVNCSUZESlkrdlFhMEhkTUNMd0FpVENyNFRV?=
 =?utf-8?B?Y25TMk1tc2sxb0l1YjhSNXN0RXFkWHg4RUlPSmZVOXZTeTZWWS93NmdEUXBh?=
 =?utf-8?B?UGx6S3Q1cUVjblFHYUdHUi8vQTJ2YTdsK2VEdmpTczl0R3JUV1YyejNVTG1L?=
 =?utf-8?B?NnBFTGM0cDRtNmRiK2wrS01EWGJyaHkrcTh1RGp1TUc5WmVKaEVIa3kvUlNn?=
 =?utf-8?B?L0dZbWxmeTBKT1BWWEtBZWlYejR0enZ1ZE9wQUh0YUx5Z1VhbHd0KzRWTVk0?=
 =?utf-8?B?QlBoVDE5bGU5dks0OGV3Y0pYMnBpNEU1ZThkeHlHVnEzS00zY3drUCtUd3hy?=
 =?utf-8?B?VEpieGYza0JVbTNROGdmT1hUV3NXcTQ0VXd5Z3BzRStoVFMyV1hrNDFIRE5q?=
 =?utf-8?B?U1dWY0pSSlc5UzZQMFBjR0dTaWgvWjQ0Z3BXcFdJcjIwdWF5NGFZSXdWV21Z?=
 =?utf-8?B?N05RY0s5LzdIMzNMQXhJZEhZYjdXaW1rMmVsU1F5akd2OEhuNFB1aVh3VFMy?=
 =?utf-8?B?ZkhPcGx1dnRRK2tYVmZHQ0l3a0hEZzJHUHZjRkV4WUZkVEtlR1JaSVVwQjA2?=
 =?utf-8?B?c2dKbCtmTm9QRUljRVBQV1NZRksweFlBY0g0Y2FwSEhFZVhnakVWRmRTZUZ0?=
 =?utf-8?B?NzJJY3lxUnhpOHdoRnMvSnhveGliY2Y5eEZIaDVRL1YyTXpwSzdxZXhSdE9Q?=
 =?utf-8?B?YjZOcG03R1N2UWxQSkczZ25ObDQxdGdoL2dlaXl5cmFLbGZuQVhYQkhCUzhE?=
 =?utf-8?B?SnU0L3o2QmQrZXBNaDRTaTJscW1LUWN2bkdWZlh5NHZ6NWdzTFV3VXNNZisy?=
 =?utf-8?B?NGZTSG1EMVJqTE9ETkJQNGZYbkxqN2M3Nm1lODFIbUc3RGJhWjcvRGNQZjVl?=
 =?utf-8?B?MFVFR3RxeE9tTGxQQUZwVnlFU0hEblRwQXM0V2lNdDRZVlNuZzlyV0xIMG1Q?=
 =?utf-8?B?N1UwTXpteWIyTUxmeXhlclltOXEyb0JoY0MyMzd2U1pHOTM1c290MHEvampr?=
 =?utf-8?B?bVdpOUtmVlh0OGU5TVBRbThZU2FQRytnYlJiNUxDOVNWRzZrS0dXYzhXRWpn?=
 =?utf-8?B?YkRQTlU4eUtRRDdZYTVXa1NIR0YwZUVIZG9KbEZUclZyVW9RMDBJR3hRVXc3?=
 =?utf-8?B?RkZrbHFOZzlQaStVeXBMTG9TL2NQekxBZjRsUisxZFJoR1pQdDhLaTF4T2hz?=
 =?utf-8?B?UlE5dzUyQ1RlSnJQSUV6cVRrcXcvSHB5SmlhSDAvUWMrNllSR0R0YWtYZE1t?=
 =?utf-8?B?cjVMbjVMV0lVaFd2aTBxZXpyQk1jWk5BNXhEcnhvRUxjSGZMQmRsbVBLa01K?=
 =?utf-8?B?K2VwdEpSRTVFWThYUWhJclQ5cVlpNkFzSGFJaXdKVlVBbkdVR3hTeWhBMTE2?=
 =?utf-8?B?YWNzVzdmcElJV3FWYm5KSHhDM1NKZDZZWUhqUWZBbXZlL1Ywd0Z1eTJaenVO?=
 =?utf-8?B?SERaK0F4eXJ0QzR1eXBuOEZBRmFUaWJpRks1RlB4ZFRmdE54NDlTYlR2MHVr?=
 =?utf-8?Q?MCKBAsnwOX3mraGOLTEf/eI7jH80kwRTK8ba8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:46:31.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76084624-64e6-4d81-bfa2-08dd04dca810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
Received-SPF: permerror client-ip=40.107.243.44;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
first release candidate for the QEMU 9.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.2.0-rc0.tar.xz
  http://download.qemu.org/qemu-9.2.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 9.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/14

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.2

Please add entries to the ChangeLog for the 9.2 release below:

  http://wiki.qemu.org/ChangeLog/9.2

Thank you to everyone involved!

