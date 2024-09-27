Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D67CDD1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 14:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suBhb-0007LB-8a; Fri, 27 Sep 2024 10:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suBhZ-0007Kh-It
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:12:09 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suBhX-0003pE-58
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:12:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUR+avCdbip+ZnbIDB3XmL3t70XX1k5jtvTSFxoufxJmXBLw7EDoagTR5bhGMewXzz1k1cJkTDK4M0NqS19J5QVTRVFO99dmIZjHtUxcT3V9PVecZTkP3snxLCyDgXh+PDV8kXSZvFmbU3Hb4oUhOuwqWaAIDdUYmVwilBiLuXiAZe4xBLJc0xm/nauLSm38rxBf2I9E0UJJpLEIqWrEZkkjmWPC7uw06rF4/nUHY2JjSCH2CYh+svy9R8gn7BUEk3kOaHahIHLa+oRzdQ6K9r64fR5TQabGbfp78Z6oBek8NzhcM32leQCNAV4ScCV1UPFvTdVMWF8fzyWUdEAd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0bSCknOOMuYPoJRJ770/PExP24C19DxVpIjo1IRfus=;
 b=ebVysDF5Uz1qyxfxts3HmiimNcB2yyNAMiUDUs351uN2q7NjjYkTUUKXltKncReNt1gRDy4//jAtsM0ipQzWA2mc7EPrN6xuLx6xPS7UA/zVuGu9Z3Ik0B/BrfJql+mAo5tbK/MdNtmubKc7/e7EE/r9FYuTrP3az59WKk4DfIRujFvqzirvLokCT0Ri27oVkO2M9Pomav7J+wugls4SetMtwIFofqODYc1tvWZYrsHm+Xh/DmX1PaU3y55GeMujQ+ajpJ0zRBDUchjqq6zWbtr/cjSFIPmuu7QiD0SQuMrhsXcO89rjoDRPFzmAwfdl1+7eQXhtYVqRU/t3ij/eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0bSCknOOMuYPoJRJ770/PExP24C19DxVpIjo1IRfus=;
 b=ma+Dx9UJJ6HAJjXKrdhC1e48/1LHj2y7Y8DtBX5Zwo61+Kyz5Bb9AYX+9H5IFnjAgVCBW1Qnjs4Izz1GqxusKbiioiVnQsNQvwdwxiErEdGSKQbxIB+WvP0TzWzjUeXP3HRcQVZGZQXQKdeQvipEB1cIiaQUBAG/in5Q29l/SZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 14:07:00 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 14:07:00 +0000
Message-ID: <02481710-7f77-5b3d-cfc8-effd49e67d76@amd.com>
Date: Fri, 27 Sep 2024 19:36:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/5] amd_iommu: Add support for pass though mode
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-3-santosh.shukla@amd.com>
 <d70a7757-4c39-4801-857c-607420cad4b5@oracle.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <d70a7757-4c39-4801-857c-607420cad4b5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::12) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: b5912f4e-0015-42a4-cf04-08dcdefda763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJqRmcvZ21CdzNxSVNGa0lkTExOdGFUUXd0KzhjdUJGRUg4QjJkc0NQR1ND?=
 =?utf-8?B?VU5ERFpkWDJqM1RNbFZla2ZlSWZGb2VMaWE5M2doMnNKcE1CTXF6TkUxV3ln?=
 =?utf-8?B?ZGpCL1lSOEZWOU1rVkJ4VHpNVWFwb0ZMTFc5TmowZDFSMjRzT2lFY3pFOVVv?=
 =?utf-8?B?SjhYTm5HeC85NnErQjVmSTY0ay9BdjZUZkY2cjhGb1BXcFZlSkxVM0xtOVVB?=
 =?utf-8?B?NVUwMWp2UTdheEYwcmJocFp6Sk1uQ3BRYU9sdElVTW1GeHBIQXEycFNEVVZ6?=
 =?utf-8?B?dStlVXlQeDIyZVFwdkVNMUVlUnZHYmJWaXNPdEMybGpnY1ZCVTdDeVk2WW8x?=
 =?utf-8?B?RmFHZkhqMWFobzNPTUFEOEw0MU41V0ZyeFRFdDQ2aUg1anVFSjhuT1p0emRX?=
 =?utf-8?B?bHpkR1pvSEFQYUZpaXZLWkw0cWNsMmZCcGhXK015UVpDVmtGWmplcittNDkv?=
 =?utf-8?B?d3ZhY2lTcjZZUzNvbUdiNkFZTHRyVDBETWJOaHRLYjVwTWg4bnBFK0VCMm1z?=
 =?utf-8?B?SDRrMDN3WktPQUZ4aCtDL0trYnhVcTI5aHdYNXpVZzlDRGNJaVdPYkRKWWVi?=
 =?utf-8?B?b3Y5S1ZLOUd6SnU4QkMyc05HeUhiY2JhNXZFSFp2OCtIbGZwbWFqb3B0M3F2?=
 =?utf-8?B?RDNad01uZkIvN3JsOUtiUHpHY0ZVUm1Oemg3RVhTcTg4dUtPUGtBUHRBc244?=
 =?utf-8?B?RFROREgrY3lRMzVER08wRkozUEVsdDBrVmllT3ZYTU1zbjdVOXJjMlExN2tH?=
 =?utf-8?B?U015NHE1aGVXRFF6T3dqcW1sRVE1M0lQY3VJQ3dRSVNvL3dQNzkwUTlybnBJ?=
 =?utf-8?B?SDFrRTg3ME9SYlQ4dXQ1S3VZVVFEL3RHSmlpUXQxV1d3Z3hBZmhWckF4NnJ0?=
 =?utf-8?B?czV2Um9LVCtsanhWM2FoMnpud0tSRVNEMjZGSzhGakp4WkF1VVNQRVRsckRM?=
 =?utf-8?B?R3NqZTNzMGxiS0Nqd1kvN29Wd04yMW5VWUNYU1owNDNWck1KY1U2aHlNK2Zx?=
 =?utf-8?B?Ty9ZczdZb1h5Q1NkNndVLytEclZDRDcwQm84SzJYaldTMTUyaUJoaDk0azZz?=
 =?utf-8?B?QS9Vd2ZTczJuOWU2UklaZXdpR3ViN2xKVVhocXQ2T2hTWVptblVHbzBZbTVm?=
 =?utf-8?B?bUJNRmFGMEZlb0tTMlZKWHJaaHRRMS83UnZtd2lBUHR4TEIwWHpuMHpCWlJ0?=
 =?utf-8?B?WC9YdHJzZEhjOWdVeElCYkJxTmIxck16Yis1MHUxalFGNEpmSlVxc0ExYjc3?=
 =?utf-8?B?MXdXMzN4YitReDRXMW44d2lYdXY2MTZhL0hxVS91QjJPRE9qbXFVRXRCUWw0?=
 =?utf-8?B?NFFVZzUxa1JFaEdmRUN5UktQZzNQc01Tb2sxM3dJS0d1ckQ2QVhya1hsR3dF?=
 =?utf-8?B?Sm1ZVjRacWEyKzViZEV6MGwrQjVEV2F1L2dlQUtYcG1JL1FoenZ0VDIxcURs?=
 =?utf-8?B?a21iUkhpRjVjZGc3UjF5STdGdXlVNGNscWV0VUtVR2VrU3M0L1RlUFNJajFl?=
 =?utf-8?B?SmZvR0VYdU1kUDZCVDhSYzREa21zakw3MlE3Z1Y5dTVYL29sZzNvUEdieXN1?=
 =?utf-8?B?UlBENzNRVVZ3YldOTFNpanFab0F2di9pNTFaMVd3ZTl4Wkg3bzY3YVFlY3Y0?=
 =?utf-8?B?ZnZNQ3FORW5UNXdZU0F2TjIyMWNGVGRqci84Tklja0tEMy9qMzNTOVVYK2xm?=
 =?utf-8?B?VFVNOFVhK1VTSU4wMFhtRGk1bmV1ZUZhMlpKZ2dmUTdFNGx3OWI2ZWpyTEx4?=
 =?utf-8?B?OExJek9iSHJrUVc2ZUdGUFVJY0p4b0ovZUtkR2FNSE9jTDJZZU1zTEpSaVhZ?=
 =?utf-8?B?QWJCZFg2YmVJUy9SZ2xOdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1BGSnErNjdvMVo0UmxmZGRaSHlGazRNMnE2VWJSYi9Tb0daRnNSVXdLWFlC?=
 =?utf-8?B?TVg2WkRlcmg5eXdaVnlVQ21qK2JNdU1wcjI5bzNXTytwdHNqVFNNQ3FiZHI3?=
 =?utf-8?B?TWJIVW94Unh0U0x5REs0OXVYNEI0NHJ2bGViZGljM3l5L0xxN1d6eXprc1pC?=
 =?utf-8?B?aWlrclRob3ora21URTcvMjNpTEpONnl0N01tMGNNdUgyUGE1SERQSDFBQjdx?=
 =?utf-8?B?eXRJVE91UU43OFRxME5oQndxQ21Qc2NQdmRiWGxCZ3Zsc1FVMmF6b1RCS0Na?=
 =?utf-8?B?dHhaTmV0S3BpcFB0ek1PTzM3bURKZXhiVGpqTURhRUVmMzU2dTR5alkvVllp?=
 =?utf-8?B?SXVvWVpRVVlEZEJzM1l0OUIzc1VBZS9INXVZcjE5MFpuZjdTMUlUNWF3MEdl?=
 =?utf-8?B?Z0RHM1dreG16SkovWXdWbnJuMVNjMmhyZWovT21OQnlkQk1ITmw3UFJVUE9o?=
 =?utf-8?B?U2c5dTduR3R6MU1jcSt6THF2ZWVyK2ZjYWdRY01XVTNkanhZTWZIYXZ0Slll?=
 =?utf-8?B?QTdCTFl4NXNkVFg5ZlZVTDBzcS91N1dUTG5XdTN1MzA1akJWOUZZSmlJUE5O?=
 =?utf-8?B?WGhIRFdiVTJ3L1lDbEhoVWR1cUhRaHc5UlpUTit3YytqQkZSRlR1NS9aSStV?=
 =?utf-8?B?NTVzSjRtVEplbHh0dGNtZzZ5VkdZVGszUTFySDBhMDRTZUhFbGpBcnBnRUhB?=
 =?utf-8?B?TnZkS1AzRGxHUjJBdmNJZUJ2dGYzV2xNOXBzTGtWYmVBSitoaDM0OHdHSHFR?=
 =?utf-8?B?ZDdkQ0YrMUZjOVI0cEUrN2pja3RhcFJvME8yZjV1S0VnSFc5Zm1mMU1ITUZI?=
 =?utf-8?B?UEZTQ2JFZnMwSmhDRXNBVGk2Y0Zpc1FsNTBUeXNidHAxVFJEbEQ1RjY3MHgz?=
 =?utf-8?B?M292OFFyNHI4dTltV0NEZmNuWkEyd25RS2RsSE9qcHJaRkE0OEQzeFVsTEFt?=
 =?utf-8?B?dDJOUXZUYkFka3M3OTR5eElyeDZpbTJ4dWpvTFlmcm9OeUpuejFrYkN4bzIr?=
 =?utf-8?B?dVU1eFFQN1gzVW9MQVNHSmRTVEtkRjVidXh6TmVvTVpzalNEWTBZUlcvRnk2?=
 =?utf-8?B?WURCTjNEVDlVODc0V1lNeGsyZHFWRzdYd25PT0NZcWExL1hjQlNaY05xeTZG?=
 =?utf-8?B?ODJrMVRMSmY3VzZVUEphVllzZGdoVlo3NXBFVVJUNVJGMXlhUDBKR1UrYndO?=
 =?utf-8?B?bmQ0UWNLMU0rWnFXWDdaT09wZDhGNStESWRtL1NrMFhIK2dtUGNQOTdsYktu?=
 =?utf-8?B?amJCL0w2ekpiZUF5Q2tVTkx0V1hjWENrQnVqdnJGMy9YTEZkZnYwSjg0RWZR?=
 =?utf-8?B?cktyNXRHNkxMV2h6ejE1SkZ4c0c4Tm0vVnBSWUhuMHM0Q0NPK3NRclZ6Q1pa?=
 =?utf-8?B?aUlHbXNEYUc2dlNuRmQ1Rm4vSjQzL3RlQjRVdHRHa01JdXdZelI3Y05RdWha?=
 =?utf-8?B?VjhSUTdFeWRtL2s0KytJTzZUcmorS1hoMXZnd0tBS1ZTZmo3Q3A4cmFhaFVF?=
 =?utf-8?B?bGVTVlBvZ3VqQ1puYkpKcXFCbWlZZmQwR2VaYzFqMFRQTnl1eGFzV2ZPNXZz?=
 =?utf-8?B?SWZVek15SnlGenBGRU9USGZCRFExTnpxeHFmOWNiOFdHNHJhMHJXcFBtbzFa?=
 =?utf-8?B?MFZjcE95MnNYRmc5Q0tZVjNQZ2N4NzdrOUY0amZCRitucnhhVityUHUzdXl6?=
 =?utf-8?B?ZTZZb1hLOGd1d1VFd2UzZ2tidFAvRkFhQ3YyTzRobXNIcG5UNXg3UE9MQzFF?=
 =?utf-8?B?N3B6a1BadkJ4dEp3SGhCOURHd2VDN3FxWEVoVmphZ2U0N09Zbjk1NDBzVFpJ?=
 =?utf-8?B?eU8rY0VaNTRrUm5Lb3Q0YjdXWmZ6MnArY3ZNaHNlMm9mUndkTWR1d2ozN0hz?=
 =?utf-8?B?ZUNHdW9vOXREYVIrL01CZUYzK01CZ3VUeVk5UzhJbmgzTUovTEVSUkNoSGQz?=
 =?utf-8?B?UjZOWG5qV08xd1k1SVBpZWhpWUl3Wm1JTEdWeHhXREo2TEhZTzNZcEEwRVYr?=
 =?utf-8?B?M2Ewa0Jtemc4T0Q3d1lOenAvRHd1emdnNXdFRkRmejIrQTBiMHdGNWw5cS85?=
 =?utf-8?B?QWducGNnUEI2aERpS3VxZ0xWaGJmaVI2QjhDbG5lcnBMY29pNTYzeWRWejAx?=
 =?utf-8?Q?AdYFPOZp8+oHisfnRVNziMHHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5912f4e-0015-42a4-cf04-08dcdefda763
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:07:00.0865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVyD/tEACIM2bOgallMlzgGzdnXDfm9eBiwy/11CrhN4OiuQxF1azH1B3z437zXe2tBfvjEaIsnRviEbCIgbxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
Received-SPF: permerror client-ip=40.107.236.89;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.268, RCVD_IN_MSPIKE_H2=-0.769,
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



On 9/21/2024 1:56 AM, Alejandro Jimenez wrote:
> Hi Santosh,
> 
> On 9/16/24 10:31, Santosh Shukla wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Introduce 'nodma' shared memory region to support PT mode
>> so that for each device, we only create an alias to shared memory
>> region when DMA-remapping is disabled.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 49 ++++++++++++++++++++++++++++++++++++---------
>>   hw/i386/amd_iommu.h |  2 ++
>>   2 files changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index abb64ea507be..c5f5103f4911 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -60,8 +60,9 @@ struct AMDVIAddressSpace {
>>       uint8_t bus_num;            /* bus number                           */
>>       uint8_t devfn;              /* device function                      */
>>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>> -    MemoryRegion root;          /* AMDVI Root memory map region */
>> +    MemoryRegion root;          /* AMDVI Root memory map region         */
>>       IOMMUMemoryRegion iommu;    /* Device's address translation region  */
>> +    MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
>>       MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
>>       AddressSpace as;            /* device's corresponding address space */
>>   };
>> @@ -1412,6 +1413,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       AMDVIState *s = opaque;
>>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>>       int bus_num = pci_bus_num(bus);
>> +    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>         iommu_as = s->address_spaces[bus_num];
>>   @@ -1436,13 +1438,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>            * Memory region relationships looks like (Address range shows
>>            * only lower 32 bits to make it short in length...):
>>            *
>> -         * |-----------------+-------------------+----------|
>> -         * | Name            | Address range     | Priority |
>> -         * |-----------------+-------------------+----------+
>> -         * | amdvi_root      | 00000000-ffffffff |        0 |
>> -         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
>> -         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
>> -         * |-----------------+-------------------+----------|
>> +         * |--------------------+-------------------+----------|
>> +         * | Name               | Address range     | Priority |
>> +         * |--------------------+-------------------+----------+
>> +         * | amdvi-root         | 00000000-ffffffff |        0 |
>> +         * | amdvi-iommu_nodma  | 00000000-ffffffff |        0 |
>> +         * | amdvi-iommu_ir     | fee00000-feefffff |       64 |
>> +         * |--------------------+-------------------+----------|
> 
> Minor nit: I would keep the original indentation here to help reinforce the concept that iommu_nodma and iommu_ir are meant to be sub-regions under the root container. It would also be great if the table could show that they are 
 V3 - Thank you for pointing that out.

- Santosh

mutually exclusive based on whether passthrough is in use, but that is probably too much to include in this format.
> 
> Alejandro
>> +
>> +        if (!x86_iommu->pt_supported) {
>> +            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
>> +            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
>> +                                      true);
>> +        } else {
>> +            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
>> +                                      false);
>> +            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
>> +        }
>>       }
>>       return &iommu_as[devfn]->as;
>>   }
>> @@ -1602,6 +1622,17 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
>>       memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
>>                                   &s->mr_mmio);
>> +
>> +    /* Create the share memory regions by all devices */
>> +    memory_region_init(&s->mr_sys, OBJECT(s), "amdvi-sys", UINT64_MAX);
>> +
>> +    /* set up the DMA disabled memory region */
>> +    memory_region_init_alias(&s->mr_nodma, OBJECT(s),
>> +                             "amdvi-nodma", get_system_memory(), 0,
>> +                             memory_region_size(get_system_memory()));
>> +    memory_region_add_subregion_overlap(&s->mr_sys, 0,
>> +                                        &s->mr_nodma, 0);
>> +
>>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>>       amdvi_init(s);
>>   }
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index e5c2ae94f243..be417e51c4dc 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -354,6 +354,8 @@ struct AMDVIState {
>>       uint32_t pprlog_tail;        /* ppr log tail */
>>         MemoryRegion mr_mmio;              /* MMIO region                  */
>> +    MemoryRegion mr_sys;
>> +    MemoryRegion mr_nodma;
>>       uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
>>       uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
>>       uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */

