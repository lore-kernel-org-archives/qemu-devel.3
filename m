Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B8C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FY0-0005ka-GQ; Tue, 07 May 2024 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4FXw-0005iT-9H
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:47:32 -0400
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2409::601]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4FXs-0003mE-KJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSqNWG60Q2liJ0YPkfE+/V/wRoWzDt3Tn/M0MD9hDufkVxwL3KU9Uf2D3f4I2eWF6E1U0X3ioWH/lcVeklMyV/947Ql6hYEKXIWGapC0qCHdVIkXPaiOe2Kvhz9ZCJAFMqCRSAqn6q5PteTiCliRDNWm5K0Jb/atUGlr1qB9W2QCNBQto45vClGw+WIe6SyyRKQYmBNc9xI08xtxaC86chomhGZ32/asXNxaqJXSfSJ8tYOLpLs37v7rBnWlLKgxMmFwpm43lXK1dOKTtA+zjrP3ssOOMpj/58oah2HRH5/jiToGnlAdrbkiGvOGBsEJShPamACxpHXVBSvyo1su0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpqZidP2hYiyMkC8Gf5JDet0mYsKW1d5XZAqHEv8OS8=;
 b=ig8A75bp/Ec6UtoYEwvOKgduAtIf4fIJBzCHzYSWonKv9wDPLEHZalhonnTEaRQv06ArR7n9u1aT0oBDuGPlgY+WysBaTUg+OHNZiKTa4l9/WdyUOMYpRVZ37hTzQ6QeeC73F3v0zuBYpgChPRxobePIWbKA1x26Tt0DARPWQCQ9jBjW+vVCqH7wZyaubm04n+wH08aphB7teKnjwzudDOzZEIjbcZyHlW2s1i/keuBJaELqIF2RXz7ziBzYDr6x1r0aotJxm4sK/W984LW5Pupl9VVdkjey3aD9utrSDfSNK7KjJnHXy71ii2xfwejXapAuDNm9riOyRayKIFvMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpqZidP2hYiyMkC8Gf5JDet0mYsKW1d5XZAqHEv8OS8=;
 b=kerphw0hmeaVQKhYDhZieNUSN2pkfRuXqmIa9D/a6aTXk8yhEMC5AYFmmDdce08Im9lY0eZwsDqAl3FpYWRwO8OTC/zZEFpHp1m+GU5D3Tiw0UzOz6L3g8wtI+X7DgM8y9ofIi/isHfP5iB1FDnJT/6rksD+7swUOFUAJQfMTU6ARyUi2DtuvFOq8x+JYIfKgr6krDLHqcqLCpowaCqsdrP0Yvq2GGc7bKklecUjb2rkn22Q7jjNsSx723Nb/kBxoROMHAU7UXwIzCLkDwJGQ68Dsparn8vTCpiQFjcMBM8TSkaJlLvJJ0MQ6+YUbltQO5F+/Eb4xqI7LQH0QEEMWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 07:47:22 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:47:22 +0000
Message-ID: <23edb44a-7147-443e-b0e3-2a832aff5aa4@nvidia.com>
Date: Tue, 7 May 2024 10:47:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, qemu-devel@nongnu.org
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
 <87pltzsfl3.fsf@pond.sub.org> <87ikzrm2ev.fsf@suse.de> <ZjjyPESK-YC-XtFO@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZjjyPESK-YC-XtFO@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: abd015f5-baa6-4674-1acd-08dc6e69ede9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXltdEt3MW9KU25UMkQrVk9TdWNSdUtjYldGOVJHY3YrOHNIb005V25sK1BP?=
 =?utf-8?B?bGg1OGIxZ0pVM1RaUk5qMXVNRGsvSHBiKzgxbU11ckh0Vmp2eDlSRW5KWTZG?=
 =?utf-8?B?Q2FpQlRYdDBnSUNaTFMxSE8vd1ZJb0FnNnFFMHpIMXJWZXhRanhWaWJHMFNQ?=
 =?utf-8?B?bXlLc0FRak9sRU1ycEdtbXZ1VUQrcEZjdFRWaHl5cjh0N05tQzY4S09tamtS?=
 =?utf-8?B?QlJtTUZtaEg4cGEvYmpFTllzbXhSSjU5SDhPSnRuV0FEWEt3Q2xoYTNabTJJ?=
 =?utf-8?B?TzBSVXBUbzVPTForbGF6N01VOHBwbnpKTnA4WnhJY2h0MHFXVEYySWlmdUpC?=
 =?utf-8?B?SnJKcXprWmdwODZiQ2puQ2JWL0dGV3paTmZUemVTaGtDakRIVWZOUHlaTzFI?=
 =?utf-8?B?T2MzWU5RbHg4d1NkNE1RY1pmMEE4cmJvYVBYa003SWkzN0FMTFFIQmg4UGw5?=
 =?utf-8?B?dVdxbUl5QlN1TERtbzNzb0trSTVNdWRITmFjblVyeDN1ck01LzdFUUk1bmVW?=
 =?utf-8?B?UlkzVGVwTTB6QzcwYVBBMzhCaCsrMC9kbk12MEJGVWZpMHBzaWdUdVRFb3ZJ?=
 =?utf-8?B?eUdxVWgxYkRnUWhwenhDdTQ5UzBRTXdXRHdwR0NwRExBa3h4MlpXekpSQis4?=
 =?utf-8?B?Ym1Ua2RzbFUvTTNORzM0N1dHRWFROWtXQmljM0dYNU9pMWF0dTgveDI1b1ly?=
 =?utf-8?B?V1Ixc1hUMDZrczFUamlmdFNzOEpvTDFBcWRzTjJxM2E3YmFqWkFkZG1KMTVn?=
 =?utf-8?B?WVlOQnFXbklLWmp4S3o3eHo0Y2RJSVg1RlEvdHlKeXNHRTgyMGlnR3gyek9p?=
 =?utf-8?B?ZFlWakl5NWpEanBOMnIwRS9iQkxnYWl5cnZ0Q3ZqWXV2NExEcStnalBiamV1?=
 =?utf-8?B?ZlA0V0VSMWZFNkVET1dDd2xTZFNoYkEyK1JKWGRUTjR4UC9WUlRjd0Zidmg2?=
 =?utf-8?B?VnYzZlpkYzV0U0Fsak11TkExMHFjRVhNczBDNFJ0SUQ5SWFpMUk5b29YOEE4?=
 =?utf-8?B?ZXArVlhsbWdxOGh0c3VlQnRjcy8wcmJOWTY4aFp6cW4rM2FHS1BQT2RXVzk0?=
 =?utf-8?B?Z0tVQW0zK01hVWhpUnlsNk50bFdQUE9iMjViSFYzeU1pTnhJbUJERzBlTFhh?=
 =?utf-8?B?SjBBd3VTNm4yZ28xMFpKMjhyekxUSzVXbDVDUElmS2xCV2wwc3VhOWFDbExl?=
 =?utf-8?B?MldoREdHaEE4WS80d1dpOXdSbTVpVGRLb3BlRDgvWTgrUW1NK2s4RFpFVVRD?=
 =?utf-8?B?VnpDWEhkUGcyOTFDMFZLNGJVRjN5b1lraE1VWmw5NXpQclZrWlVQTHNaUjhW?=
 =?utf-8?B?dENkS3JKdFU5WHhGbjlDZ2gxWFhKMEl6M1RseXFLdzlvT1VYZ3VqVm8yVlU4?=
 =?utf-8?B?R25nYzg4cU9ZMC9HYTB3cmJxbWswN0dabUxGcnhwYXpRcWhyOWdSRUgwK0tn?=
 =?utf-8?B?VDZBOC84MTdQUCtZQXFlMkk4eklyTjJSNWRWUGJ2UkpRS25hMG5Hc2VJc0kr?=
 =?utf-8?B?dG4yRThRQnVtanNQRVJlTzM4bUdLdmw5M3dEQ3hBTnBqQXFhVUUzMWs2dEtO?=
 =?utf-8?B?bXBnemp4R2t0TFdwdGgyYkRuRE9KcTg3MTBWWU1tL3dYelZRUlJ0cHcxQnVO?=
 =?utf-8?B?UFE4RVRPc0c4aFRBYkFuZXdqZHdwMHE3MDdrdlVGUmdwS2tzRzBZWlNka29q?=
 =?utf-8?B?S1hleTU2K2VrT3Y5Vnp6alRydFUyYm40SnBmMUFFK1N5N2pteWlWZ2NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RZaGY5bVh1ZDJLKzMyN2Y2QXJXWkorVTNYRzN1N0pQN0FzR3lkdVlYaVFE?=
 =?utf-8?B?SHBVZXE1SGN5Y1VmYW92WHpLV1UzSzVrK0gxVU4yYjJjZWlOdjl2b3BPNitL?=
 =?utf-8?B?SnFPSG9mUktvMGdpOG9oOXAyT1ZjYkhPanZ3M00rd0RndDB6VG1PY3BiUDFP?=
 =?utf-8?B?SUFuN2I2ZmNITm53Q2c2a3piUDFNWFI2cDczeHJWR1RLWEZQRnlBcTRoUTRJ?=
 =?utf-8?B?amJrQzY3SzRiQ1Zvb2F0VzQrRURnUGVWQWdITWtWSDMxVDhEOVdSZFdXZmhD?=
 =?utf-8?B?L244TmZNckQzREdxSEhmQllUV3NLM29TelNpOGplWVpucHBSaFdrTGYyU3c1?=
 =?utf-8?B?OHdPeWxxaUoxOEtJMmY0REUxcXVDSUdJVkllc3VHZzZKY0w1Q1N6Qms2MVM0?=
 =?utf-8?B?Q3loNm4rdjJGTnppekNuaElUUnRJWkxyR0hPM2VYSmEvYWRUTTVPMitDWG1m?=
 =?utf-8?B?ZHBKSWYraGFGNk9IN0t2b1NqUW1kc1NSN21sMngySWxhZGx1U2RpM01naVpk?=
 =?utf-8?B?d0Z0Q1p5Z1ZwaWxsbUFpbTJsOFRIdlllQStIeFhGMy9QblBVRmowV2orRzVw?=
 =?utf-8?B?eWNsRDJpaXpzWktocks3YThHR1lDVE9Pbi9rMmFmTk1wdlZaVkpQZUdhMGV4?=
 =?utf-8?B?UVJtYU1TeXFHdWNaVDhIdlVBYkdXQUtSbXd4dU96dkRMNmhKN0ljTWkvSlFj?=
 =?utf-8?B?MXZWdGorTEgzclNkeGRBZ0tObXpUbXV3b2luUG9uYStqQ2k5UW1VUzkwZW01?=
 =?utf-8?B?ZjVBbEZaRGxpQjdZbTJIWUN0MVp2bGdZaFc3dzFKdVlTeEZZSlNFYVQwTXNX?=
 =?utf-8?B?elBRRDNQMS9QL1picm90WVRwS3JHa1FuRFVXWnNwRnd5SmdtWDVUaFZsRitj?=
 =?utf-8?B?NW9CMVVEdXdQQ2twYWZYZmRGVkQ3c2tTUy92L2pOaktEZXF3d3RzUStKNnVH?=
 =?utf-8?B?K0oxSzlvampJeXBZa2R0b3Byck8vajZMemtmKzUwZ2d5cGlMdGh4akdLdmd6?=
 =?utf-8?B?Q0NmWjFoSTVFRlpRMi9YSmtqUVJnbmhnOWtDTnJTL1gwM2R1OU5yaDc4V05j?=
 =?utf-8?B?NzZmYk1ITjRoODlxU3FINnNqVTVyTDBDd3FSSTBpN2xsQ1VVeml1ZS9HeHdk?=
 =?utf-8?B?a0k3NkhKZ2tpcVFsMnRWNmdjQ0dyd0NGYndpem43ejcwMFRzUnlIZDAzQkgy?=
 =?utf-8?B?TmRNbTZQOHUxL1Jzd1A1dkc2T3MxZnc4U3JBaHVaVUx5L2lvREtVRzdYdGw4?=
 =?utf-8?B?b3hCYy91eWJlV0NxMi9PbjFndm5jM1JRNUVkOENxczhwOWFlSHRpd2JzTXdz?=
 =?utf-8?B?eWdPdjlWK2loQkdIdW1PMk44bHpxOEdhM3AyajEyb0xYd0RBK2svSEZKTHNS?=
 =?utf-8?B?NkZkUU9LMG1UUEhRSytVNjByeWRTbFQxM2Y2U0E5N1Q4dlVUQk1ieTJMVFhm?=
 =?utf-8?B?NTlDME92bDkzRE5QQUxka1E0RGR4QnJ0NHB4a0pxWWd3R2hjS3NEcG03YTND?=
 =?utf-8?B?NDduS29HbXY4WGJXcWRxVmUzM01yWGxmblJUd2c2M0Y2RmtzK2VISFZqZDJa?=
 =?utf-8?B?VGdscHJZNmI1SWlyYUZEVkg3SlNET0Z0c2hPZlZ3ZG5kaUNpTEtNaTk2Q2lO?=
 =?utf-8?B?N3IyaHpSbGRsejBSQ3hpYkNIbFF3aGovOTFPYVozM0dURzZIYlJCRnlGM1ZJ?=
 =?utf-8?B?a1NLdmVJbk9PelplT3Rid29EYWQzS09hVktDTmNobEgvalRUajN6ZFZYMndH?=
 =?utf-8?B?RHAzN0t2Z2RIeUNab3VLZXhSRXdseFlVNjRpaTRvbWtEV2VMSDJqemRnMWxW?=
 =?utf-8?B?K3REdjdPY0k2UzNuVzYxRmRFNGYyRzZ3UGc2L1hFR1BpZ3RsN3pDcjUvVU5j?=
 =?utf-8?B?WTJKVlQ4Vy8zeldMbUJWdjFCNGY0MytwQjhGTDRSc0FCb2g1TDAvRFV2a3c5?=
 =?utf-8?B?anNBL1dHYWRrcVdTVTA3d1lLSjdSL1NrWTRLUWk5bUJXS1JXaWU5ZVN0OXZj?=
 =?utf-8?B?SXhiVFhuTDFBaDd1K0tNcTl1MTlWZ2wrdjBPWmE4NVdwQXJaSTUwV2VORzY2?=
 =?utf-8?B?cEtTVFJFUXFrQlNDUFArbHc0bFF2cUdhMmIwalNPV1VlZWJDN1hzOFNUcUs3?=
 =?utf-8?Q?0+6MD8/4G6h+V9T+TsKtDL9n7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd015f5-baa6-4674-1acd-08dc6e69ede9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:47:22.4046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc9rvdgswJvS2L6lHSMgDn3A9fs4w6dEyvcdBbWSjT1TLoRTxSfMQaSeo3ZXoMVIYZmk/gbfUED/lqwoaKVSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Received-SPF: softfail client-ip=2a01:111:f403:2409::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 06/05/2024 18:07, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, May 06, 2024 at 11:38:00AM -0300, Fabiano Rosas wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Peter, Fabiano, I'd like to hear your opinion on the issue discussed
>>> below.
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> On 02/05/2024 13:22, Joao Martins wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 01/05/2024 13:28, Avihai Horon wrote:
>>>>>> On 01/05/2024 14:50, Joao Martins wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>>>>>> Emit VFIO device migration state change QAPI event when a VFIO device
>>>>>>>> changes its migration state. This can be used by management applications
>>>>>>>> to get updates on the current state of the VFIO device for their own
>>>>>>>> purposes.
>>>>>>>>
>>>>>>>> A new per VFIO device capability, "migration-events", is added so events
>>>>>>>> can be enabled only for the required devices. It is disabled by default.
>>>>>>>>
>>>>>>>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
>>>>>>>> ---
>>>>>>>>     include/hw/vfio/vfio-common.h |  1 +
>>>>>>>>     hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
>>>>>>>>     hw/vfio/pci.c                 |  2 ++
>>>>>>>>     3 files changed, 47 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>>> index b9da6c08ef..3ec5f2425e 100644
>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>>>>>>         bool no_mmap;
>>>>>>>>         bool ram_block_discard_allowed;
>>>>>>>>         OnOffAuto enable_migration;
>>>>>>>> +    bool migration_events;
>>>>>>>>         VFIODeviceOps *ops;
>>>>>>>>         unsigned int num_irqs;
>>>>>>>>         unsigned int num_regions;
>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>> index 06ae40969b..6bbccf6545 100644
>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>>     #include "migration/register.h"
>>>>>>>>     #include "migration/blocker.h"
>>>>>>>>     #include "qapi/error.h"
>>>>>>>> +#include "qapi/qapi-events-vfio.h"
>>>>>>>>     #include "exec/ramlist.h"
>>>>>>>>     #include "exec/ram_addr.h"
>>>>>>>>     #include "pci.h"
>>>>>>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
>>>>>>>> vfio_device_mig_state state)
>>>>>>>>         }
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +static VFIODeviceMigState
>>>>>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>>>>>> +{
>>>>>>>> +    switch (state) {
>>>>>>>> +    case VFIO_DEVICE_STATE_STOP:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>>>>>>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>>>>>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>>>>>>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>>>>>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>>>>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>>>>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>>>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>>>>>>>> +    default:
>>>>>>>> +        g_assert_not_reached();
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
>>>>>>>> +{
>>>>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>>>>> +    const char *id;
>>>>>>>> +    Object *obj;
>>>>>>>> +
>>>>>>>> +    if (!vbasedev->migration_events) {
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>> Shouldn't this leap frog migrate_events() capability instead of introducing its
>>>>>>> vfio equivalent i.e.
>>>>>>>
>>>>>>>            if (!migrate_events()) {
>>>>>>>                return;
>>>>>>>            }
>>>>>>>
>>>>>>> ?
>>>>>> I used a per VFIO device cap so the events can be fine tuned for each device
>>>>>> (maybe one device should send events while the other not).
>>>>>> This gives the most flexibility and I don't think it complicates the
>>>>>> configuration (one downside, though, is that it can't be enabled/disabled
>>>>>> dynamically during runtime).
>>>>>>
>>>>> Right.
>>>>>
>>>>>> I don't think events add much overhead, so if you prefer a global cap, I can
>>>>>> change it.
>>>>>> However, I'm not sure overloading the existing migrate_events() is valid?
>>>>>>
>>>>> migration 'events' capability just means we will have some migration events
>>>>> emited via QAPI monitor for: 1) general global status and 2) for each migration
>>>>> pass (both with different event names=.
>>>> Yes, it's already overloaded.
>>>>
>>>> In migration QAPI it says: "@events: generate events for each migration state change (since 2.4)".
>>>> This only refers to the MIGRATION event AFAIU.
>>>>
>>>> Later on (in QEMU 2.6), MIGRATION_PASS event was added and the events cap was overloaded for the first time (without changing @events description).
>>>>
>>>> Now we want to add yet another use for events capability, the VFIO migration state change events.
>>>>
>>>> I think what bothers me is the @events description, which is not accurate.
>>>> Maybe it should be changed to "@events: generate migration related events (since 2.4)"? However, I'm not sure if it's OK to do this.
>>>>
>>>>>    So the suggestion was just what feels a
>>>>> natural extension of that (...)
>>>>>
>>>>>>> Applications that don't understand the event string (migration related or not)
>>>>>>> will just discard it (AIUI)
>>>>> (...) specially because of this as all these events have a different name.
>>>>>
>>>>> But overloading might not make sense for others IDK ... it was just a suggestion
>>>>> :) not a strong preference
>>>> Yes, I get your rationale.
>>>> I don't have a strong opinion either, so maybe let's see what other people think.
>> I don't see the need to tie this to the migration events
>> capability. Although there's overlap in the terms used, this seems more
>> like exposing a device feature via QEMU, then a migration event
>> per-se. The state changes also happen during moments unrelated to
>> migration (cover letter mentions start/stopping guest), so I assume we'd
>> like to keep those even if the management layer doesn't want to see
>> migration events.
> Yeh makes sense to me to keep that per-device flag, as it's not a generic
> migration state change.
>
>    @events: generate events for each migration state change (since 2.4)
>
> The other option is to emit event only if "migrate_events() &&
> vfio_dev_send_event", but that sounds like an overkill to overload "events"
> cap, and doesn't look like bring anything better than just keeping them
> separate.

I agree, so I will keep it a per-device flag.

> While at it, another trivial comment is maybe it's nice to have a helper to
> both update the vfio migration state, plus emitting events when necessary.

I think vfio_migration_set_state() does exactly that, no?

Thanks.


