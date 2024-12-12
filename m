Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmSY-0002tS-N9; Thu, 12 Dec 2024 11:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.lucero-palau@amd.com>)
 id 1tLmSV-0002t9-I0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:54:39 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com
 ([40.107.92.52] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.lucero-palau@amd.com>)
 id 1tLmSP-0006oD-Ki
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:54:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk2egJqB8tsZiHj5c+EQpH1XPmc+9UaRYseZSBLxzStx293+I6Hv7ahozlwvJoDpLRW/gSIwalnDieNxMRHf0+D72VsfzQSl7cq1gg2w4Z83uJ2N/rsuHj0UzCW/nUyB2egM80bwIjoTgagBzVKJ2iXZnEkGnTLskQLnUrvDiXZvGLcdJtFnBysUY7dW4TCQGqb5uupxbDCoS/DntB8VtNx+LD3XELbvVfH62OYnsOhMI7Wz5YF2UPaxAiDTvkvVx0q+S8Vle2iKsEAJnGPkBoKCysQ+0JzzFsVX7MaxnYs2OIqiZ3iycaVRpB2uOYadOtew+bQZjbLjWeoiC9ZZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgHLP6+wp0ZcI63KUr+Ajubi2OQjv3yaFpjdoQ9SeAc=;
 b=FlEEYtIlSoC8upBFrhpVf8lD+EgEXKsaoMvK8JNIN6aZHZkA7u7qgXhJwtvuHSeqgx5rbjVfYXmKpFQhDD0yi55SGJW76bG2W3yWD8GhL4k3D9sUbLSziqIQoGxo37WYEMpai53FDt/e/dfJ+rTVRpFf46UhvavpUCstMIx4M74fqOV84WZizYGzWMP7tV1D9iXz/IQHFtjOgB9XoEW5qtP3XI9TsKyonH33aMLK4xNktcNpcsiuenHMTWO64035BRerYTfcfrILIZRpFhP+7NnYyJOYRsyLj1zDeAiLjzIEfOT/u+9VjxbTSpaidzlui4rgs9LRCis4D7sPSIq18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgHLP6+wp0ZcI63KUr+Ajubi2OQjv3yaFpjdoQ9SeAc=;
 b=tg6l6w7lrq60teYOOup0PTJc7ZZyCLlzUKPSf2tSGEPa0MlzmZhBsXnRw3wMcGKtiMHAmeu4aN7/17JWcQ0iuuOpiQxdERqVl0sqp7oijnq08XhK4jMUAALb8Jzgi8470gihvVRopNE8oYJSPm45VsscF8g5feoe0Tspc4GB70c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 16:49:25 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 16:49:25 +0000
Message-ID: <eb417797-04aa-3572-02cf-5b858866edc7@amd.com>
Date: Thu, 12 Dec 2024 16:49:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Introduce CXL type-2 device emulation
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, fan.ni@samsung.com,
 alex.williamson@redhat.com, clg@redhat.com, acurrid@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org
References: <20241212130422.69380-1-zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212130422.69380-1-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5aa98d-5d6a-4794-186e-08dd1accef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckRjaWg2NGk1TWxUblJPbzBtQ29FSUNkVkpvMlpTRXFhVDhtWnFnRkJkMkRt?=
 =?utf-8?B?OFNkY2djeEZpWEU1d0wxTlRsMVJTdUNsL3M1WGxJSTZBdUtrRGVIOHFJTFQx?=
 =?utf-8?B?aUxJVDYzZlBrb1QzVU5lKzk2bTZTdkp1b2VVbk1pRkI2bmpEN3ZRc0hTQ2R4?=
 =?utf-8?B?VjNoK0NUZi9IYUY3N0Y3Q3ZZbjkxQ002MTVKVGVOVi9SNGo3clp5bVpjeVJn?=
 =?utf-8?B?MVN0UWlzQVU0azRQa1QzOU1zeVA0b1B4aUxjUlREckt5VTlmWmMvV1liZzBM?=
 =?utf-8?B?ODByNFRGVjRQZjlXcXIwVi80ZWJVYjdLN0lRM3NCb05qcWNlcXZKdmlBMjM0?=
 =?utf-8?B?NFNNNVFRQkJkd2EyRndWWmhiOWUwclBtNEcyeXEyaW9FZUZURnlqMnU0dFVt?=
 =?utf-8?B?ZWdFb1FMSjUzdWtITzlCQjliY3luendqVmw3MEE4c3Zoc2o0OFJZN2pFaTBo?=
 =?utf-8?B?Z3d4NmU4cGRuNGhhejNxc2IvdVZNWTNRVU5zQnRKTmxReVNEVi9UamNjd2Fo?=
 =?utf-8?B?TVhmMFZHblNxK1hLbXg3K1F6WjB0TWVlS05RVXJ4NnhkWGtJZDc2N1RvUkJY?=
 =?utf-8?B?blJ0bmE5ODRnS0FXdVpMSS94UWhmU0pzOVVWREJiNy95dEQ4Zk9oRit2a0N2?=
 =?utf-8?B?L3hmTHZFVkVSOHZ1dXJIL3dzZGU5TmZ5T0tSUU9ZV3Y2Y0h4Z1dwTXliMUVN?=
 =?utf-8?B?a2JpeDBneUNIeW0yNFdsTXl2Ujd5eklROGh6NmVNS05sL0RyOEJjc1pzcFlk?=
 =?utf-8?B?UlhIeFNmc3ZjWGZmeFd6V0hXNE84UFNRT3N2NSs5UGZBR2trYWhXejI0NVRD?=
 =?utf-8?B?U0hGOWlzK2ZlQlVLTmFBb3RrZ1pnbHd4TmhxOU4yUnNxdjRFcUsvRHRsaFJs?=
 =?utf-8?B?cmE2dS9rVEgwaDRoS2ZoWGczSkdFdHdOTVJJOU1UMHlqOW5lcTFYd1Y3eVhp?=
 =?utf-8?B?cDkzU2tDVGVJUUpsbzNMbTNGc1htMWZ6bG1hOWVZVGp0K2ZOZk9xVWtUeUNu?=
 =?utf-8?B?ZFhPR3h0WjdDWTJoSnZkQ2dGejZwREMrYUNpaEhqZG9zdlhCRW5lQnE3WjQ5?=
 =?utf-8?B?WFowVDJ0eUxKUVhVVmlMbzlNZ0M0T3FHbEJPN2VOMmZrTUJGTGpycDdBVE11?=
 =?utf-8?B?Ui9TMFROMEFpSjFzdTAzQlA5R1Y5cldSaWo4M0hOMmphTEVWazZTOXcycWpu?=
 =?utf-8?B?ZjRLT3VDYklqbHZNRUFWdXlyZU9rQjI1cWlYYmNROUQ1a29aa2krTWVSR3Js?=
 =?utf-8?B?bGV3eEVMeHJMWC92TklNY0p3Uk9qKzlKQlhxZVJSSGRiWC9vWllKcHBJTGFG?=
 =?utf-8?B?endIK3VCem5aclcyUTNwdTUrQlZGTUFGYnFkeUp5cjVveXozem4rTHJsMFlG?=
 =?utf-8?B?UXM4NGNFZFVOWUVod2p4N2dkcStUMGhnT3VXNjV2S05QUjduNHVneFJlazdI?=
 =?utf-8?B?Wmdic3VpOHlUVHFZbERLSVdLeUtQUldhSUNpbCtUK0psSzUrbytueU5VVDhL?=
 =?utf-8?B?S2QxbFZlMGliUDh4ZmRMOWlCT3hQdDV6d2FYQzdXTUhucGpzYnIvb2pMcDho?=
 =?utf-8?B?eU1SYkt1czdhMGRLTG9QUGtBZ1d1ZUxrcVF2dnlGUE1LNzJBV3NQaElDMFlp?=
 =?utf-8?B?WWNYWGRWei9JN09TUkx0R0dxNVRDU0xRWDlmQ3ZwME5tUkpoeHk1bkV4QTBK?=
 =?utf-8?B?UmtycEcxR21SVVZic2h1ZWpuYzNJczM4NWo5dkZaVkhMWlBrSzZzWFFSRkFy?=
 =?utf-8?Q?ZmyB+E4am10hPvFSzE1aZxvfcmoFZ3Tp8AgKaYV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4202.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VJODBlMkMyblNpSDhPM1VoWFgrdDNrR245djQwOHZXWjVmU01JWkNrQkJR?=
 =?utf-8?B?a2pJMjFIWStkRCtQOUYrQStMM0JhOVNBL2JjY2E1OFNaVGNxcERScmRnaXd3?=
 =?utf-8?B?cGNpRnJJaDFjOExnQjZsZENMSzdkUUhmSEtaNWtPaitJc0RuQzFPQ0d1bE1V?=
 =?utf-8?B?amlTdXdjajh3RzFEQndZRXFpY3FFem9wckhhVGJ5aVlzcVJHcVdPOWdvSjh2?=
 =?utf-8?B?YWtoWXBpNVc2bitkWWhOUmx6K05nNnE0VjFJN2NpWCtuZFhUYWgyNzNEdm4x?=
 =?utf-8?B?SW55TnVEN2RNc0c3Vk55cGY2QmZYUW9STThjRlVEd0hTaTVkc3N1TmVWYlVO?=
 =?utf-8?B?MjIrbjZuVDUzTzFXZVlMYjdGNDA5OUlaWTR5bzRhNW1FUjYydUp2eEkwajBB?=
 =?utf-8?B?WkhUVGkvY3YwTXJOanl1YnJKN2VBdDJSODdoZWpPM2h3eEZDRW1tb1BVUDRp?=
 =?utf-8?B?b1ArSWVSaURjS2tYQjcrSkJXUHFCR04zSEdOT29jTGFxbDlQVjBCWkZxd0Ez?=
 =?utf-8?B?NE5TQysvMVNGQW1SY1puRjZ1bDZuMVVNT3JKLzFGOUo2UWd6MEJzK3hRRmVt?=
 =?utf-8?B?ZUZ0bklZdEd5bUpXUTZoZjBXTU5rUy94bURKN3M4QjZjaGE0Mlp4UktGMHhs?=
 =?utf-8?B?emhzS3BVQmNMMWljejlwNTBSMFkwMEtUa1MyRWlpdC9oRm1vWkY3aFdBYUJv?=
 =?utf-8?B?aXBFZktzZVJUckRhbGk2UWMvQWpsdTRvWXRyMFF0dXRHa2EyVXV1blRoUlU4?=
 =?utf-8?B?VTZ0UGJDS0cyNEY2bkVUSTRYTEtkTXpJTFhOS3NBdnhOclU2dWo5NEoyRFdQ?=
 =?utf-8?B?RFUzR1l2cTJVREgwSmw1OGhCeWJUL2s1TkQxc2xHcGR3Z0pHSWpZek9aU0Vs?=
 =?utf-8?B?NkZ6eGlFZjdPV3RrWjgxZnRjQ1hZQ0grRkFlZThCa1dZN0pydW1hQVY5bnVQ?=
 =?utf-8?B?TG5xNkYyZmp4WGRlcm5PUEpVVlU0WjBNYU5mNUo3MGtRNm5KL3ZVVXY3Y1p5?=
 =?utf-8?B?dDl4TVhlbFE4cGFROWNabTUyZS9TYmxjNTVEbG0vOVpxcm1KaGtpVTRPOVFN?=
 =?utf-8?B?Z2Q4Uk9neGNSTC9LSmhkeW8zS1M2eXIyRTB5VHN1NmhIdFZqcDI2eW5JVkRk?=
 =?utf-8?B?Vm1rSnk4VnZWNXZUV2YvZVpZQ1JXT3VwdkpGUk5UY0EwanROMkJsUHRYOWd2?=
 =?utf-8?B?M3dZemJjQXMwZnlxaCt0WEdJbUNtd1ovMVpCckxvU01rV3NMOHM4T3RxeFBF?=
 =?utf-8?B?WXFxRndsVHptZGRsU09ORkRzRlJNaWl5M2lsS0t3eGhJWUtGcTRmaEJEMTB3?=
 =?utf-8?B?WlRSVFUxNnJPa29lSjNKSE5ja3NqNkRRMlArdEE1N3NoY3crYitvVklVb2Vh?=
 =?utf-8?B?V0xBM2EzS3BQcGlZMlU1a1gvMnZ5aXNUd1VjZG9Vc2RNWjVuSHRVWDVLTGhG?=
 =?utf-8?B?bjdUT3RLaERPY1VUdFV1YXgrZzA5MEs2bkpUSGxCVHJjVGRoQmpPUWF3Vld6?=
 =?utf-8?B?dlNNU2czV3lHWDY3S1ZNM2RsSVlPVlZjOWlKYXVrQ01vUHFkWnJkM1haUkJ2?=
 =?utf-8?B?SCtrbHJlZm5jTnhJclZhclBUZ3huMzd3Y0tHbEo1azZqaElUVzBFY3pBOC9p?=
 =?utf-8?B?R3NWSFltcFIzOWx2UFBmTVl2RWNXbGZFb0hCRTh2aEo1OFB3Y0hMSG1Yc2tR?=
 =?utf-8?B?d2srVjgrbXBoYjU1SWw0Z2EwT0lLWm56ZEc1SU5hUUVzQWg3RWw0RVZ4YU9z?=
 =?utf-8?B?QWZlZkp2dEdmbWNnTTZIRnRnanVwL25JNTVTbElrOFJmaVNLb2dQY05kUEVk?=
 =?utf-8?B?SlBsdUlCRllCNXRYQVAwWTlhTXJUQVcvYUE0OXNLZzdHaTdIWWpKUHMwN2pH?=
 =?utf-8?B?UjNNU3NkODRZTzBpWCswaTRrcXdwbWo5UzhyZ25ESGlWaEI3TWxUdHVTbWhE?=
 =?utf-8?B?Nmd6WDhLSTREZ1B3Qlo1Z3N4OWNoeVJDMm5BQ0lWaDR2UHVJYXptTHk1WUpt?=
 =?utf-8?B?bTRRMFB2L0FlOUJWeVVFUUtzTzIwK2ZVdXBzckhvb1MxRGZBMHlYd2xwRk9x?=
 =?utf-8?B?elhCMER1aTZNdjQ2NUdDVWZ5R2NkejBvQ1pQRFBzeFp2MWxvcmxEWlc2NUZC?=
 =?utf-8?Q?yRH1/3Mtp5OQIHi6ZzrqcGIa+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5aa98d-5d6a-4794-186e-08dd1accef7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:49:25.2572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILieOXNfxckyPeZbmkCj6KhAHfAf54X4qs2ZAdGex2l2eNlUUT12i1BIVSc2AdS9dF8J2B8QWdDBOi37nqG8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
Received-SPF: permerror client-ip=40.107.92.52;
 envelope-from=alejandro.lucero-palau@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.217, RCVD_IN_MSPIKE_H2=-0.001,
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


On 12/12/24 13:04, Zhi Wang wrote:
> Hi folks:
>
> Per the discussion with Ira/Jonathan in the LPC 2024 and in the CXL
> discord channel, we are trying to introduce a CXL type-2 device emulation
> in QEMU, as there are work currently on supporting CXL type-2 device [1]
> in Linux kernel and CXL type-2 device virtualization [2].
>
> It provides a bare minimum base for folks who would like to:
>
> - Contribute and test the CXL type-2 device support in the linux kernel
>    and CXL type-2 virtualization without having an actual HW.
> - Introduce more emulated features to prototype the kernel CXL type-2
>    device features and CXL type-2 virtualization.
>
> To test this patchset, please refer to steps in [3]. Use this patcheset
> with the latest QEMU repo to be the QEMU host. It achieves the same output
> as in the demo video [4]: The VFIO CXL core and VFIO CXL sample variant
> driver can be attached to the emulated device in the L1 guest and assigned
> to the L2 guest. The sample driver in the L2 guest can attach to the
> pass-thrued device and create the CXL region.
>
> Tested on the CXL type-2 virtualization RFC patches [3] with an extra
> fix [5].
>
> [1] https://lore.kernel.org/linux-cxl/20241209185429.54054-1-alejandro.lucero-palau@amd.com/T/#t
> [2] https://www.youtube.com/watch?v=e5OW1pR84Zs
> [3] https://lore.kernel.org/kvm/20240920223446.1908673-3-zhiw@nvidia.com/T/
> [4] https://youtu.be/zlk_ecX9bxs?si=pf9CttcGT5KwUgiH
> [5] https://lore.kernel.org/linux-cxl/20241212123959.68514-1-zhiw@nvidia.com/T/#u
>
> Zhi Wang (3):
>    hw/cxl: factor out cxl_host_addr_to_dpa()
>    hw/cxl: introduce cxl_component_update_dvsec()
>    hw/cxl: introduce CXL type-2 device emulation
>
>   MAINTAINERS                    |   1 +
>   docs/system/devices/cxl.rst    |  11 ++
>   hw/cxl/cxl-component-utils.c   | 103 ++++++++++-
>   hw/cxl/cxl-host.c              |  19 +-
>   hw/mem/Kconfig                 |   5 +
>   hw/mem/cxl_accel.c             | 319 +++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c             |  61 +------
>   hw/mem/meson.build             |   1 +
>   include/hw/cxl/cxl_component.h |   7 +
>   include/hw/cxl/cxl_device.h    |  25 +++
>   include/hw/pci/pci_ids.h       |   1 +
>   11 files changed, 484 insertions(+), 69 deletions(-)
>   create mode 100644 hw/mem/cxl_accel.c
>

Hi Zhi,


Thank you for this patchset.


I  have a similar work done for helping in the Type2 support work, but 
it is all quick-and-dirty changes.


My main concern here is with the optional features for Type2: how to 
create an easy way for configuring Type2 devices using some qemu cxl 
param. I'm afraid I did not work on that so no suggestions at all!


Thank you


