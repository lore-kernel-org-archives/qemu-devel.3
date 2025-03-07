Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C68DC282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNql-000301-O2; Thu, 06 Mar 2025 21:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tqNqj-0002zR-SL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:54:09 -0500
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tqNqh-0002Y0-Qk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:54:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAKcrkrn7svXHLs5M+PSicl7SPG1QGOrbHQ+FtkE81BsU4XxNgOKkvdSJOdZDNHSdGDLrywv/g1L3XRoNf8t7sPF4BDOkFL4BRjSYUO8nf489Eulnf7X+QqlWSN8qEul7ZEyp3Wr3CVedL/qNm3T8kI2+5hDd53mtsKOWZjnTyQbYn3DMEQ09WKIUXVjJErqjzHu2QZ5y7DgCjMrq1RHkc0o5BHFgJxAEalYCjsIcyNl5/nWQI1a57psgxpIt4OaFNWssyihEDByLpxe0dNgJR460oyyCLNPbAPR7DdrB/dRM8UDJ8WtuExyyieVjL6z/fPStQkfqYetYOBoBuPpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3+1pGxmjmAoVoDQ2hIawWxbvVZ0mjQAAq1Bp2cmJpI=;
 b=M0W79pldv7/L7SV1oKnV6r0H+slm3T2cqXfhPIbshY9LHgUC+iYvVYzyM5K61x7afjdo244ZbhSnTzDYGWEp2rooVzK4fJLDGSqfEppxc5DayAPxdSfHTlg7p544oGkWgyoD9VUTG7Ck6wFA6KEyjfuccf2XudSH8KYLibaGKWogfTskM5XET9GkwwNQOnFXg4hN3L042Z3BrnneD8U9huqHI486ajcRYy62ikE1BRihervVuDM6rHziL8ihSkcCx5nKH3Aslx1rniMtMzH/VvkU6R4jVGBlmtYrB2A+f46Nx8gbG4+0K3GwZMHC+A3ON9SNcrdR98wlv3vENrbaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3+1pGxmjmAoVoDQ2hIawWxbvVZ0mjQAAq1Bp2cmJpI=;
 b=kj2Vh4IO7hirt6+hPFEFXiq8KBmmbCfNA98LluvOc5kdBkxN5dMORLddkHz0qzZGOcd8ZaxhoDAzFK9tbEcagMC4/XsAOuOxI7iPE9Hpyi4v6UGt8Uzz9RbxnzBpB1CKwUFX4yRiA6IA19ZevuKjZSvz+VenGSo7WiQmiMj2V+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Fri, 7 Mar 2025 02:54:00 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 02:54:00 +0000
Message-ID: <234a0790-e256-4cd8-808d-90f821911881@amd.com>
Date: Fri, 7 Mar 2025 09:53:52 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com,
 berrange@redhat.com, ddutile@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250305015122-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250305015122-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abebd63-3d29-4fed-ddee-08dd5d234fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWxkQTVYWTFyVjB1TXZqZ2dxUnV5VTFrZTZLWU0wZzd5TnhPbDBjb0FBK1BV?=
 =?utf-8?B?REJOYnlPUC8rRVlVSS8rdE1qT2xiUEdoRloyRHh4NFYwcXlBNGcxU2ZRbDd2?=
 =?utf-8?B?Z0JoS3BiS3Q4VGJ1YWY3eXRQcGRXd3Y1VFl1NkdzNWhTSWhlbGtDWDE4RnNV?=
 =?utf-8?B?aksycUhxYVBqS3dVS2hpNWRWbXBPc1g4WDdyWFl6WnlyKzhESXZxSGE2ZVY1?=
 =?utf-8?B?eEs4dTh4ZkpqbCswZFRVbU1saWhTR1lnUUZWV3NteWs5cGtSYkt2cVdXUWRH?=
 =?utf-8?B?RERNb0dZZFgrSWZob2I2eDU4MTZuLzFwNFJLRWZGMFcwYzdVUnczcGdZdER5?=
 =?utf-8?B?ekR1MGpoYjV2ZTRXdFFOdUV6RU54MDZ6cnY1SUEyNGQrWFJTYWZMQ0FVQUdS?=
 =?utf-8?B?WG50VjZ3RkMwT2VQcHVocWRWcnRpMkZhNnY0UHVtbnNUbklLRGRPdGYvbFZF?=
 =?utf-8?B?M3FmcW9RRW1ZSVIvRVNjM3VKbmpjNG1oZVh4eFdjb1Z0UFRBU1JiNk9SNUxn?=
 =?utf-8?B?TCt6K3hYakJORlcyd3JueUJJR3Z1LzZ5YjVuMW1yc3RJd1RJcHdGckk3RW42?=
 =?utf-8?B?T21XY0lOdDhVb2dkQ29SK0s1L2NWYmtWRC90WE1MQ0FXY28xcGp6eW1XOUNK?=
 =?utf-8?B?NnpCSU9tVDhGRHJMRnlFOWluUEhxUFUrQWpHcnFoUHAwajlCUWR4cFIrVnJs?=
 =?utf-8?B?OUZ4a1BRazdpTEJaN0UzeTlxVXdYT2x0WVFsY1lnUjJFeU5LUUVoWk9EOUJk?=
 =?utf-8?B?Tk1KY1dqb01KeEs0WWkvdE1OQ2tOTCs5b21EdS83a2RyQWxrazV2T1FTbTdK?=
 =?utf-8?B?Y0FibjIvK3gvWXd6UEFzWGdzb3M0ZXBVaDVMdU5DMC80T0h3bVZsWU03K3Z6?=
 =?utf-8?B?dmhZem16dGtSRGEwUEt6TjBBZS9BdXlOMkk5QmVmTXVEWDRFYytKVTFyeC9W?=
 =?utf-8?B?Nys2L3pMcjJURkZ2dDZQWjR3QVJGQm56cE1Qdm1LN04xVTh4em5YTGM2OEhl?=
 =?utf-8?B?TXhRcGJ2T2VRUVlrT1VWNnl1L2hWNkNoVkdKdzZtem1mNDNFL0hCMEZKampu?=
 =?utf-8?B?QTFCSVEybnVVcUE0ZU5SWjRXVWxqVWJERTRoazZFQ0ZZbFhuNy9qSXNsVVZG?=
 =?utf-8?B?ZEs5Ry9iREx1dEpaaWlDWFJwRGU2OFhSUHZLNzBEZlBHNVM4QzA0c1NOQlRz?=
 =?utf-8?B?SnVRb0xKVUZqU2JndHF0U3hUK3VhMDBqYU92bzZWQzV0TUZrWFU2QTBwQXZX?=
 =?utf-8?B?czZ1d3dIWEYwTm9QZDVEN0VSZC9hNHNzcG5sOC9KcXYxc3hJQkdEMUdoWlEx?=
 =?utf-8?B?YlBDdy9XbVdPSmxIaHIxWTVXcC95V1ROY2hKWEpMZUdKWmdrdWJTNWtNME82?=
 =?utf-8?B?ZHRZSndBVWJIODArZUN3dHNLYnQ1N2haaG5YRk9UVVlvL1hNeE5QdGVZOFFZ?=
 =?utf-8?B?SFRtWGFWazIwZkl4MUR0WmpHNUt2cFZkbWVHc05tTEtBWDZIa1dCSU1YOEQz?=
 =?utf-8?B?dWwzaHpYRTgxVUtZVjBva3lXMG1QcVlpS1ppenRtZ2hrZ1JBYUw5TjhOWDVS?=
 =?utf-8?B?ektuM3NwMnhwRVVwa2loUElpT1VxVmNlL2JnV1d1dG1rTzZpYTRvVDYwRUtj?=
 =?utf-8?B?NDJOY21kSXNZeE4rR2QzVmFNY21jNlN3ZkNLcEkxbUc2eFZrSlFUdHlkRVE1?=
 =?utf-8?B?NDFMMkhsdDY2dkVrQVhhMjhHaDhXbmE4b0cybGtXSHQxUGV6L2x4QmFZMzhC?=
 =?utf-8?B?bXJQSFRUcjVZRWFOeHBhZjlHQjNpN3g3NkhxQ3VCUVRLc1h2dlgvWS9LUUYr?=
 =?utf-8?B?bDM4T0VRcjRBUnA4aW9sTXF0MWdLZ0FhSHFpMTdPVFJTMWd0WGo0cVY2TXMr?=
 =?utf-8?Q?IuPEaZOPuSpbV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtKckYxaTBBZHloTW5ENDdSZGUxWStEazdiUlBtVEZFQWY5Z21XMDU1OXRP?=
 =?utf-8?B?UTFoeVkyWjJpVEJWeFp5Z3p0ZGlMYlpyU2NRblZkbllaSnpOSUt1TFU2S3FX?=
 =?utf-8?B?RUdYdmVLR09rbk1oQnQzdlFUcGdHcUNaZFl6Qzk3OUJoTjVETS85b2VXMVZx?=
 =?utf-8?B?SmRMNnVJMEpmeG43UG1CWkFMVlB1OE9aYlVXM3d1N3lpeHpZK1N2OFZzYWYv?=
 =?utf-8?B?TjRQclZKbEVRWGpIaHBZc2dpVXU3ZjJhdmhqbVkzTWl1N3NtMzA5elJ5Q25L?=
 =?utf-8?B?ZzZ2a05rektSMi93cmhSSGNNUTVSLzZJWUhUTC9JUUJoQ1VYWHFSMXoxUGFj?=
 =?utf-8?B?dEtldjJHdUh3cFhFNlZQOS9EWGxqTDFzNlV0UUpRRE9ZMFBDTFhZUW5GWndv?=
 =?utf-8?B?Y1hyd2xDYzhzSlZwWVRva0pNMVZDQUdueFZ1S3Y0aG9qUWV0QVloVjN2cUJi?=
 =?utf-8?B?Z08rczhOQnZWQU9tV0YzOG5sT2E0SjdMRzQrdDNPVThsTDExZHlnMG9tNG9D?=
 =?utf-8?B?UW83RkZkclNJMVVRRWdrV2VFbEdqTDJqbGtPTDB6ZWVhOHZnaFVmMng3enFK?=
 =?utf-8?B?eWdvYlAzVmJHamJJSVNROHVnSWNmUlB0OWN2ZUhSQnpxSWJQS3dWQnRweXln?=
 =?utf-8?B?SzZ6alNneGpNZUFpT0c3V0d5c0VDcmw2WWJHamI3UjFTWEhhbTJRbDZMSnNX?=
 =?utf-8?B?bDZFamVYSzU0QkM5OXhSdVByN2V3aDV1a242SXBsMXc3bWF6SDZQRkRCWUc3?=
 =?utf-8?B?bEd2SUVRcDkvVXRYWGhIMFRmOStkaDhQd1hXSVFob1d4UFhCTlNhY2tsU2FF?=
 =?utf-8?B?QmdoVi9xOTlLMVBxdzhqMDBaSCtkQVJQaEEzd2luZ1J1bU9YZXdIbmlwWlFw?=
 =?utf-8?B?VWd5bWxhSWNkaEFrVGowVXV5SXVOZEFZUkhIdWF6cE1mYUxmQlJlYmJIZERS?=
 =?utf-8?B?V1BmSDNNcEk3NmlxZ2lOeUN3dnM1VXZHOXJMd1BLWEFKV3JUWU1kV2pBN3I3?=
 =?utf-8?B?WEtpZHhHTDBVOWNVandCVUwrSk1QTnJUb3NhNDNyM3dsRENPemVac1Rmamgy?=
 =?utf-8?B?MXdEaFdhdStBYkxmWDV0OVlPN0VoVVRqRUZzTVZ4eHlwNXNoQ3IvallLWW1p?=
 =?utf-8?B?SlBOTlIvb0ZGWGVGZVhxU0pqOHNycmIvdjRwWE5YMld6VXlEcjdOZ0tkaHdw?=
 =?utf-8?B?Vk8xcWorSUhFeDBkOHhvTm82WFQwZEpRcVZFeVlxUHhXY1RaM2Vodk5kOFRE?=
 =?utf-8?B?aFhGTVVjOU1iTXUrbFYybXMvL3dzZmJUTnR4Yk1GNUtoZ0k1eHdGTk52c2dG?=
 =?utf-8?B?UUQzMVc1YmF0cDR0WUI5UVlSVDV5bm1MdGdjbjNZN0t1dkovM0hxVlRsakRF?=
 =?utf-8?B?bFRETFpockljVzhlUDUrdEgyL2dNT3VhSk1TMTBOWWJnS1hlSSs4NHZMbVY5?=
 =?utf-8?B?VWJQdTVlWk04QXpnMXBSK0dUOGRoUk1pU3o4Z0gyREY5WUd1amdac2xIdWNa?=
 =?utf-8?B?WWduc0lPNDB1UVNvRVhrajNtOGg0YnhybGlReDlzMi92d1l1SnRPSHBMRVR1?=
 =?utf-8?B?QnFQRjJ2YzZwamdCMU5VR2NmZDVpS1FXUWgrQ0dKQ3VrMkRqckZGb2NPNk1K?=
 =?utf-8?B?ODV5OHlyYU4xNWJMVUJLeFQzMUdyY0JPSE00MWEvTVJ5R3dicDhaTkN0YlBy?=
 =?utf-8?B?bm9PZktnOXZwTlY3akwzRVZaQUovamZjbDFGY01MOGd4UzNNS2plUFFsSUNv?=
 =?utf-8?B?eEh1M3A1WDRHVDlvek1Oc0ZqaDg4akhyKytmK2NVRHJlNnRQbjVhM3czZjQr?=
 =?utf-8?B?NTlRQzFOZGNXVjZxSG1LUm12RDg0eGc1ZkgwVG44RmZKaGpFMklQbTA4YXB0?=
 =?utf-8?B?SUgzOUw4OGw5QU5MandialdObEFranE2dlJESTRSKzNNMEovQWNDVUIvV3BJ?=
 =?utf-8?B?bDk4K2pxY1VoUVZmV3F5VWhYdzd2bkZXYzlLa3dtZzhkRDdKZVpWQlhvUUpi?=
 =?utf-8?B?T0kvZzZsYzgyZk42WnZ2b1FnVmJxSjZlVlVqaUowWFdrc01QRWQyanpvWUZh?=
 =?utf-8?B?NWRCSC9qVzF3Y3hGdGhSbG01WlFGamV6M1h0L1l1cDh2T2VjY2NLTWhNVGtu?=
 =?utf-8?Q?75dqKDvPcpJuplsiCCdSXuvZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abebd63-3d29-4fed-ddee-08dd5d234fa9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:53:59.9778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0giXL5Jo6PpR+i4AneUeYPn46SthxU+a+uEvFjqphy08b7yLI8nIb35ICTIa8yvJXbY6zWHTnhl/zrO3PuN02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
Received-SPF: permerror client-ip=2a01:111:f403:2409::600;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/5/2025 1:52 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
>> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
>> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
>> device is platform-specific.
>>
>> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
>> undefined device id.
> undefined?
> 
>> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
>> device id.
> Won't the drivers fail to load then?
> 
> 
>> [1]https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/ 
>> specifications/48882_IOMMU.pdf
> what is this link teaching us? It's a 300 page document. Where to look
> in there?

What I am trying to say is that all AMD IOMMU implementations must 
adhere to this specification including the QEMU-emulated AMD IOMMU. 
Unlike cpu emulation, we don't need to exactly mimic a particular 
hardware implementation.

QEMU-emulated AMD IOMMU device can have its own set of features that it 
supports. Going forward, we might even have QEMU-specific feature / 
behavior. So, we should not be using an existing PCI ID.

Thanks,
Suravee

