Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB0AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2thc-0002kz-Vc; Fri, 03 May 2024 10:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s2thI-0002kk-7N
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:15:36 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com
 ([40.107.94.43] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1s2thF-0004kk-7v
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VppylSbj60Ih9yQnr4XQBuB53Av8KtJa6+ouJoQwuxbxKPO2KhRTR6VWvsZ+sesrH1cgOZ1MKMlOPvJs1MTWNnlbgHojrccVvR+7Csgom7K73fGMcbP89vaa1LZql9fqoTVmKcGO4F/Sv7E/dvHxO/evr3859TqaWr1EhgwA3QQOpjpOo1op8y/xON5LW88g9o47X7RkxPxjJeK6qI/x3SsxQiB4V8FmIWb8tSE8oqMg9JRX1Do8fEo91gK6KioDRqpn0Q3lMi+9AeMHHYcc7PGq5kgP3JAEMjh8jZ39nQRad4AhIXvG7QTPuLPhoQNQrK/2ZWWjdUNmUvVRg8vkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3mDRN9bWHOE/beCnewq7pnnCt25J0twY7RKvuSJfeg=;
 b=SZiPPdelpUlzzw7VCErgE+l8UBJX1yXPVbHR09L5o0oZOaFMA8Ge47Ov7KDCEewY3dsp0ZeL9E3YS4QHlcaUe5cXdnQVvhXy7TJCvzHY1pUv52AxyFBT2UmBQmXlP0Vvu6bSM+gMAD6eMR93m34xWBjcnMIsvytGDeA5khQoO47PdQKiAKIEibh5an5Zkz0SP5x4QUGXV85G0pg6qq+gjbgG/b2xwjsGA6MGjWonOtB1O1n0RAAOQagpNU+Lu3ybaDL6U90Vr+z04RVmuoJhXr/A5VjjCNFY3xWQOqDEUGnFZCIN+SVqIfNbUHB7yikeoWZ9YbvspnSIu7miUwXBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3mDRN9bWHOE/beCnewq7pnnCt25J0twY7RKvuSJfeg=;
 b=GGxsbr1n6TKQowZwWC3e+f1uZ1/Cfeck+AjOhaEBemzwT2aQ20APqTMgKJonw22vp/kn2fG/Vkyl5bIR7+Mka835EbkdbC5PbAGHtuNsToPtlWmfBGhXvWUwXU/W4KOPx5mJyHPAelA1nuJ6/9R0DRv6a6lg3orphdhstWFk6sSP/Q126LBuBUnaZDbVNHM8srKUbmd9jKA2BU70PU+0bTXCiMwwkM27SERR2xRuXumfgMrQSRhE7EXd1c6gD8tZXeMI5M9TrLv2HNksciB8jrqmDA/EsKAW/1ZiZnKPUhe2XonRqZP1yx9xohBvjnDGIeODIOf6BUSKi45kYsxZIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 14:10:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 14:10:25 +0000
Date: Fri, 3 May 2024 11:10:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Message-ID: <20240503141024.GE3341011@nvidia.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
X-ClientProxiedBy: SA9PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:806:22::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: fa23c992-7974-499d-bdf2-08dc6b7ac75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVMzTmFzaDRvTm1VK2dWaEtkc2dNUmJ5VktHL1JIa2tVaVFLc0xRZm9vQWV5?=
 =?utf-8?B?Mlg2T2g3azBIOFZjTng3Y0hWdW9OQXJFVUNaa3RFdWZMblFSVUluNytDeExo?=
 =?utf-8?B?MkVUZmhwYXl5Rmp0QldFdVBCa1cwNWpmbk83clBtRFRBdENPL3hjZjg1SEFF?=
 =?utf-8?B?a2w4cUc1NUhnVnRhYThDTEVja3VPR1FSYnNKYzF4RWwwbjRIWG90UWEzSFdY?=
 =?utf-8?B?dWwzNldKeXBYeDNwVUVzUTdnWE94YzFKNzNUZGJDTnRzVTZ2OWxEYzhJbFVD?=
 =?utf-8?B?a0hvbG9OQUNrTGxFT0YwUEhzQTJ2N2VQbjEwdm83QVZlU3N0dGFnQlhIU1k4?=
 =?utf-8?B?OTZUTlZBell6NWNiNEt0TklhbDJ4MkNiSnJZeXFyNGRMZjdINTA4Ym9tUDZh?=
 =?utf-8?B?ZkV6THYyR3h4TTFOQUxOelVBdFZSVElQU0tPUGRJQ3Jvem1uczNoV0tuUzhF?=
 =?utf-8?B?Ui9NNURiY0tDN0FXWHM1MHV4Ulg4dElvcUVyZExJZUhybFl5SVVicUYzcHUv?=
 =?utf-8?B?c2o0UnFHemIzL21LMHd4Nng3bTZzQVRhbXVmdGZPcXZGeWtpM1FJeUVvTGZ1?=
 =?utf-8?B?dmxOVXBJWi8wSWhvcVFsR1UwRlNPcmZJVHFsa3RYWHNZb3p6SE5XK1IyakVo?=
 =?utf-8?B?UkhxZ2JlckUyYXFiSFY3WmcxSzgrVHpnaGtvQXJZZ1BpczdwSWxWUkdpbGpF?=
 =?utf-8?B?elMvZFpTNVY4bTUzMWRPWXhOQVA0Rnh2cVU5SkNtZnZmVTRYeWZ5TTVJQWla?=
 =?utf-8?B?RkNjTlVOdXBoaUYvWmZmU0R5SlJ4WjVUVHJ6WGFDRlB4eXNWMk9jY01Ja2Iy?=
 =?utf-8?B?T29yN3l5Qk1jRE9Fc1AyRGtLR0RQaGVBSTV4QUFja09LRmFPa0FDdTVWcy9P?=
 =?utf-8?B?SXBBdUVSa3lkZ2tCeUxjb0EwQk8xR3RPVEUvSkl6U0lFRnZCWlJwcDM1UmhP?=
 =?utf-8?B?eG5zanRQMU5ZRlBZOVNGZHNPUDNQZ21PN2JVaHpXN3F4QlhYUlM3VFhvN1ZE?=
 =?utf-8?B?NFlYcEhGUmtUcnVSNzZhWE5ZdXYzQldiWTRLeXp5V3ZZV3lpdWg1eWRLczVM?=
 =?utf-8?B?elpRZEZsak45VmNLd244YmtpUVhDR0dEY2xYSWZTTUJRSExIcXhaVXEyUWNz?=
 =?utf-8?B?RXZDMjZGdm5WRFpqUk9uWEk2WXlCZVFBSFNaZU9objAwaCtSWEhjS1NtYmI0?=
 =?utf-8?B?dnlzMEdBOTVEMEJSTjd0YTcyczRDOHZkY2w4a1FtcTVzUld6anlDaVpkM3Y3?=
 =?utf-8?B?WnRBbTNkZTNTQ2Z5WjZvTk8rcUxsd3NKbkZNbU00TnplQ21RZ2hZWFBNbzhB?=
 =?utf-8?B?UTFNb1BrUFgxTVlsUmVrSVBaL2NvaHJPMGs2MmdQVnROVmkzL29JTGtNblFr?=
 =?utf-8?B?NXdMRlhPZk9qQXNQcVZmeXBhdGFySkwrNW82WVR4cGZTMVVvWmJrNklLMGpN?=
 =?utf-8?B?dk5XVWFTTmYzdnk3RitjMlMrbVdMVlBFUGVGekczRG9PcXVtcmFKMXlTQ29J?=
 =?utf-8?B?eVZmcXE4ZzcyM20zaVRhaTc2aVVUMGNkTzZQTkozUmw1TitVQ2ZBV0owN2R5?=
 =?utf-8?B?R0ZWY2R6RnMzME9UOWUzeXc3L0hxT1Z5bXRkTmc4K2hBczFrYTA3YTdENkho?=
 =?utf-8?B?L0tMWTJ6QlJRSjJ6OVBjWEtObUdUaWExUDlLbkUweHhIbFlSak10NG5LWXpw?=
 =?utf-8?B?UTlGSW1SdUkxK1lzS0t1L2hkYUx4VjlXbHI0WU5tMVRVWnZaUVl4ZFZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UER4bko2U2J5NGh3RnBDZ2I4aWZNSENhQTh4Mm9WOGhIVTJXazVMQ3FXd2wr?=
 =?utf-8?B?dFl6c3pLTDhWc2NST3hLTDdrdUhEaDVRcGlvSytTcFJ1M0FobStvN01FdUZR?=
 =?utf-8?B?OFp2QUgxdEJFb3ljbkdIQ05RNWZDaTlmbUk1VENEd1dUSVFCSlRmbi84ME93?=
 =?utf-8?B?cjkycStUWlNjQ3FKU1BRVTdJN3NMeGp4YklrdDJOaE1ueVJpVGlPUWNQU3Fi?=
 =?utf-8?B?SEJXSDJKUVFoRkJyeXVEMlJ4Q3FOd1JrVGJTWTd0ZXoyTnRoTFVUZHRhRVB2?=
 =?utf-8?B?cVF3MW05SktoNVdzQXY2UGhVdkZoTENXVTlQMk03VFFJSGlDcElKejd0QmJI?=
 =?utf-8?B?YkN3bnlZcWd1NlhmckJEM2R2eGdzTnFrNnhTZWVnbVpPQ2ZSNk9pZUhhWk13?=
 =?utf-8?B?eHRqTHRlZE5SZTVESVZWU2ZNRVlOM001UjBMdm1ac1RRb01wRFZGWTYzNHY1?=
 =?utf-8?B?NW5iTm51eUdzZ05DQnFITU8vNnhSSEwrY0UvV2FzU05kQWdHQTNKdmJ5SHA0?=
 =?utf-8?B?cGdjcEFOMGl2bGVNZFh3V2hWL01OZ2o4NU9rZ3ZUSG1JTGgxSW10cVhKSDlO?=
 =?utf-8?B?c2tpRXcrYUNtZkZEblk3VDJTb0hJUWhsbFBuTWlWMFRoeEc4SkVGQWE3VXBn?=
 =?utf-8?B?UnJVY0pRTUExZno5ZjRHb2lQR0ZBVkU4MmxaZzRBMFV1OGFWSUtrNCt2WmNm?=
 =?utf-8?B?aEpOL0ZTV2VIV0JpQjBDWHpzRXdaWkFWc3RGMlhDSFB1MFNmWVFkekpjN2Q0?=
 =?utf-8?B?cUc4dngzK3lpZjZOdlhhQnVTZGV1NEFwci9zZmUrU2d4RGlPcGRHS1U5UWlv?=
 =?utf-8?B?MmdnbEdGc013VXdMQXQ0a1pxT29FVkNNWGMxYThMWFdIa1ZJL1BXR013ZGRu?=
 =?utf-8?B?dFVLTFBoV0I3ak9rUHUrTHczSVkraDJrTDNubDE2U3hoOW5aZDV1MlhTZ00r?=
 =?utf-8?B?MVZKd0N1bXprbWRHMFAxV3dVckJ1bStXYWpZTlljbUJ3bEFDaWFxNENGaGIr?=
 =?utf-8?B?alhGOHhOTWJqLzdDQ2xxbXFrNlVaV3JvVzFGSWJRM2NvbjdzODZLT3hBejNL?=
 =?utf-8?B?bS9ScFpqazBZUklnRnBuVmloMXBablphN3AxY3Q0dmFPUVplc1ozdlhNelZ6?=
 =?utf-8?B?WFpENzFLSVdPVUNoa2xuV0NVUDFzZVFXWWF4WmRHUzd3TkJYY092N01pWHBC?=
 =?utf-8?B?Y0xkWUJVLzNWcXZDbGVjT0tNTnZIT2E5M2tZV3owdzdxcy8yNS9HVHhHb1pH?=
 =?utf-8?B?ZVZ1NHJNcGt4QzlxaGRYbFVzYlE5WmdxRnp2cDIyOG0zZ2pTY2xVY3lEZFpw?=
 =?utf-8?B?V0F6bjVFYW5wck9SMkt3Sjd3T1B4c1A5RUNzc0ZhS0U2cmk1UkxyNUhwR1c4?=
 =?utf-8?B?KzlOd3VmY3V3dHBNYm1qaHRlNjBFTjE0NXJZKzNTdE9LNGM2NUo0MmVkM0NP?=
 =?utf-8?B?NWc3VDZiUGpzVEwyNUZGZC9VbU9ha280QktWN3h1bGhlL2RIZ3FWMnN6UDN6?=
 =?utf-8?B?MS9lUngxMC92M0YyRlFPd3ZGRnBjeXVlYkVDd3JiV2ttTWNjOFJjbDEyTy9s?=
 =?utf-8?B?ZjFIK0ZRN0xDZ0h5RnJLNUU2L1JjVmZNMGRubnIrb0k2eUw0ZGovOHZoVWk0?=
 =?utf-8?B?SnZNZ2NmQzZsL2ZDVS9FQkhreDlacFFKbDNxOWdTWDB5N3NlUFF4NTArRGNE?=
 =?utf-8?B?WlhXaHZKbXFRZGI0cmNTV3grdEYrZ3VRNU1XQUdYelR6R2pkdlpVMUZrUi9v?=
 =?utf-8?B?TFZOdmxHS3JLTnk4ZGVwUmt1UWNhVzdad05MMWUvSmF1UHlHaDdkcGx4emta?=
 =?utf-8?B?Z2NxTlp5NlpHaGdCSGs5NVhBcUhLbnZTMGNob0ZoenVDRnZhVkE0T3lORkxk?=
 =?utf-8?B?UHB0MWFteDI2S25wR3hON08yMkxDaG1DVzA1UUtYeE4xZnJ4UDl2M0pqVjB6?=
 =?utf-8?B?Qm1vT2NvRXg2R0JVVGVKWE5GckhZaFJPbkpzeUM0cFViY2tJVHB6cEZESW9K?=
 =?utf-8?B?cTl1VjNLUlZwV1dUOXNjbFFadVdYOEVxdGxVT1AybnhVUlZGMTkxRkN2RXRl?=
 =?utf-8?B?WU0wcGR2VWhjaTUyOVlITEY2MWNOTGNtOHlQMjhNU3pocTVxY2Q3YzR6Z3hh?=
 =?utf-8?Q?pMGRlfT6Y6kJ1n5xYSZ1ddd0v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa23c992-7974-499d-bdf2-08dc6b7ac75f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 14:10:25.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJZGBx4tnULTHlGfdWLLNbaQzvlhjruiuFm4lwOxliMVLT5v7YK7k6ArClJdzGMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
Received-SPF: softfail client-ip=40.107.94.43; envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Fri, May 03, 2024 at 04:04:25PM +0200, Cédric Le Goater wrote:
> However, have you considered another/complementary approach which
> would be to create an host IOMMU (iommufd) backend object and a vIOMMU
> device object together for each vfio-pci device being plugged in the
> machine ?
> 
> Something like,
>     -device pcie-root-port,port=23,chassis=8,id=pci.8,bus=pcie.0 \
>     -object iommufd,id=iommufd1 \
>     -device intel-iommu,intremap=on,device-iotlb=on,caching-mode=on,iommufd=iommufd1 \
>     -device vfio-pci,host=0000:08:10.0,bus=pci.1,iommufd=iommufd0

? The main point of this is to have a single iommufd FD open in
qemu. Not multiple. Would you achieve this with a iommufd0 and
iommufd1 ?

Jason

