Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63A1CF6498
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 23:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLrrg-0006aR-2z; Wed, 19 Nov 2025 18:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vLrrC-0006YU-Uv
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 18:45:09 -0500
Received: from mail-northcentralusazon11013033.outbound.protection.outlook.com
 ([40.107.201.33] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vLrrA-0001Yu-TK
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 18:45:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIedILj+doLRfM5djeSi2guh0ZHevjUmAHOjmm0YP8T7gi/0FpX5WH5XuRCmVqsQitGOtJI+HaINy6Gywt5ysvinHreb5JmA0ea4OoY0z1zUzNZrC+f4gh5fSooCObxnJShZX7OkoMClzbyAJgNbzxAImrux/nbGTZqw7sLJblPaY+fVy5cDsQMOb0EO6PS9MXUaGTEK0gzouyCNkCNi93VRbhdpwLQUo5QWhQ0kbJlAyiprhuemR3EqdxyPHfsqbu6hHeHuz1C6GsktuY5K74fnmJnf4EnIwUjYOLFoIabVMa/DSJPZGWbck7zg/4rC1h1LoWUqvBQT91TrPHxeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W759+9hVF/iqfyZNL+SQy71jg2PYEi+Zhug0q+Sar3Y=;
 b=HLzoNDTwRYOug8xrbbwDb2gZX23muBVVtSxUHR8h+yGbqnsLfYO4nutK3tCOl7YEfCmyiIPfp3t+TRCcEfs/C5/lC61+vMtMzayxTKKD/Wf9weArKc3Jt1Sr6xKQM6Tt3YUDwi7ILoVTRNuDez8mfHS8uv5dyZzqp2rN68yMFH3wyTsa68/Tbylth7oxfrgRIb5GS+1CBk8om9xKQzyarg8jALyRc2QpQN23hQwDiy68Ip4zLT60P45Vz6dQ4/j8vTGtBWWG+RlnYmLMCxExv0d64XauEZSYn9jhJS8S2N80sND+PUbKRVByGieRk0G4gs1bP4g6XkpU7p4hxFJuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W759+9hVF/iqfyZNL+SQy71jg2PYEi+Zhug0q+Sar3Y=;
 b=rFVdho+sPoZd1Ncsic9htMEx/EngIOamGY0+Gfc94EFVWtS1sPVrWtAaXGDQPs8khivjM24dsRGEHDF2Up1kqWrzGsq52qFpPGu9Za3gPwcz0w+IeuUHfi1zjQazknchWmwea9EAHvIs8Xo1kzSz0rQeOjt4Hz8ICppKNkjaONM=
Received: from PH7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:510:339::26)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:39:53 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::b) by PH7PR03CA0001.outlook.office365.com
 (2603:10b6:510:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 23:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 23:39:51 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 15:39:51 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.2.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 19 Nov 2025 17:39:35 -0600
Message-ID: <176359557511.1845377.6752982148248088074@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 6760c18f-1a55-4b3e-d3fc-08de27c4ef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHJ3d2JaNHFJaTRvdWZ0THdHdjkwV2VQL28zeGFvUGh0WGRRN1prTUpHaGJC?=
 =?utf-8?B?WkhDYlViL1dwTThETktmTHdUWXRYSzdTb3plZWlMZ3lTVWJha0swdC84dW9O?=
 =?utf-8?B?WDFuMXZ6elJNMDFicUJBb3owY0g5NmpXbkZYRTNRR05TeUd2NGZFb3lKMTBw?=
 =?utf-8?B?YU5JUUNESEpSS0FQQzc1MnVrQ1N2b2t6ZEpNYk1heHQ5ZmdHNW5XZDg4YlMx?=
 =?utf-8?B?YVZGeTVzV0MyWkJMUXIrdlJVeTNIOS8yL09YZmljRy9YYzIwNXdocngrcWxa?=
 =?utf-8?B?TjNnVytwdG5NT1I0NXQ3ZGsxbCt4cmlFTWJuWU1aMCtyMkd6Y0VKd0w3R3Bm?=
 =?utf-8?B?UEkvVnpsNEN3Y0RvUXZXWjl6MEFPZEorbjRZeGlXdVVWaW5pa29VZlVyNWZR?=
 =?utf-8?B?RW5LRU1XNHlGRWUxUndKNUhtT29ibHY4aWxRSkl6WmFrWjBZR3k4MGFYNk9p?=
 =?utf-8?B?TW81QlVRMmZkbzhReWI0cVJGaUFYblJualZYNTdXR0dwd040WG50cVhjUHFz?=
 =?utf-8?B?TDZPT09hTC9vdm0yT2VQdTByTnhTT2tqbWR1dzB3R3VlWDJua0MwV1lXb1Nu?=
 =?utf-8?B?OWJVRnRwRit6QmFvMlNmbUZ2TVgzSEhkNEZSWEcrRHpuekw2VW9DeXNRa0Zs?=
 =?utf-8?B?cytUdFlIVndBYzlCSFlPY0w3cTNHb0hWdTJSeTMzM1hlQlUyRlV0WHNFYXpY?=
 =?utf-8?B?VmxwWlFWNEx4YkIzZUNCQmg1YjVtdXMvZjQvVlRWMVVOR0RVVE5CSFhLeTlB?=
 =?utf-8?B?dEx2d1RlRzArbzFHODdiOUVDQXI4SHBqTzF5NmlOalR6TVdiOUYvY2prdGlG?=
 =?utf-8?B?VUlMNFJwaWNJTWNrc09rd3lpd014bzhFeUZtMHpESUZhUUsxeXdXMlFBTk02?=
 =?utf-8?B?TmZtRmx5L1dMRUZqZTFxMGJNK2JKa0tEOFdGcmNPU01lSWkweDEvNE1YNUdX?=
 =?utf-8?B?TlliVlNPRTVaVloxa0FhSDZGOWpQblFXZGIvbExZb0gzbFRWUE5uaXlGbDJS?=
 =?utf-8?B?eVo1M2dlaTA3QVFHcEs1TVBQa3d3RnVMZUxoZkVpWVg0UnQ5STlNdmgwK0g5?=
 =?utf-8?B?SGRkQ0diWGF4cVcwYjBWK3ViWVpwSnNOczFzQjFiT1cxL3dEWk1HdGswckFu?=
 =?utf-8?B?RjBHeklSVkV1VGxERytZMDZtT0hEdC9EQnZyS2gxUzhMVlUvTnpPSmQ2eGcz?=
 =?utf-8?B?SHpBMGhpNGZScUZNREE1YVo0SmlpVHlKajRSL09GY3ZMS3RLMzFMdHRyMWZO?=
 =?utf-8?B?Z3ZFRzg5OXd4RFY0bzV5b1I1Mm1jWE82ejdUV2RCYzU5NmxwM1ZreDVBK3Bt?=
 =?utf-8?B?OEJqSk93WVQ4QTVteldNOWxJNnNQaGdMMGxaR3hPTkhoZVd1MmNuRDFXZkVS?=
 =?utf-8?B?VVNYekc3cEtTSjkwRWpNWmRaNlppV0dMa0VpdXNuVERjdnM2TUUyL3dtTnlX?=
 =?utf-8?B?VURsZnJ1TGZnUElVV0M3dDRnMlVIN0Z1NENLbjJma01JYUJhV2VoQWRBOXlS?=
 =?utf-8?B?NFROekVGeW8ybmN6NjllR243Q2VodjllVXE0eG9mWVJJZUF3YnlyWTVPMGN1?=
 =?utf-8?B?QWNYQkk1YUVXYkdVRXgxeFBzMUlZalROTkVIR2YvWE8vNkRwUitvYnpVQnhJ?=
 =?utf-8?B?NS85aGppcFE5MFdtTkVKTk9nUWNuQ3JteUY0di9IaGt3dEhsT0U0Q2oyMGtC?=
 =?utf-8?B?b0k0bDE5bm0rR2Y3dzN0N1FsU09lU25YblM5RUNXTEkwZ1YxM2lEVUFQM0NC?=
 =?utf-8?B?Y1p6TzJaMU1STlMzN2xvbWFPVFhkTytXV2hRMmtDajh6VTJzYllCc0tlWGUr?=
 =?utf-8?B?ZkJiWU1FeTFtbWl1djExaEo2bGpUdUU2Z1pPaS9QQjFmNVM2bnY5T0p0eG05?=
 =?utf-8?B?VTBCajJqbkJSYWJ0eGhNOUdRQ05NY0VQT3pDNHJIQUVHU3FCZGEwaGNnQXlS?=
 =?utf-8?B?cUtFb2FXemordVliR3BkbnM5R2Y3WkVXdXRDWjFqVkdXTEROWmNjb1FOMHJ3?=
 =?utf-8?Q?4cykyZoBj+yWh1t6xs1H8gNKYx93mY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:39:51.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6760c18f-1a55-4b3e-d3fc-08de27c4ef98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019
Received-SPF: permerror client-ip=40.107.201.33;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
first+second release candidate for the QEMU 10.2 release (there was no
rc0 published this time around). This release is meant for testing purposes
and should not be used in a production environment.

  http://download.qemu.org/qemu-10.2.0-rc1.tar.xz
  http://download.qemu.org/qemu-10.2.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 10.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/17

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.2

Please add entries to the ChangeLog for the 10.2 release below:

  http://wiki.qemu.org/ChangeLog/10.2

Thank you to everyone involved!

