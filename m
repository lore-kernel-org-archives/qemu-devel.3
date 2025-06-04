Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C6C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMn04-00006P-O6; Wed, 04 Jun 2025 08:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uMmzt-000059-WB
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:13:34 -0400
Received: from mail-bn1nam02on2081.outbound.protection.outlook.com
 ([40.107.212.81] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uMmzp-00034L-Cp
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBuai2So/Ge/3o3p3gF8wFUXAhmwQu0oas2aCXuMcVkORceAT+vC96KGIWfbY1kAAqI5qRSAaFu1R1ybKpheHKj3bBhaBPeVEV83l/UUrIOoKiU+9g5JnqVEHFlChBj2rxins9RJd2YM52f5HNcRIP8mlzUlBSdnVsZjRMPaDt+xkD92BLukGeg939MZ3VuG82A89H9XFWOBRq93EUuIoSMlG1AR2N/q3Wy+OpMTpl0E6uTjRlr+JMOZtRMCPkala3lJ77NCtouUJebu5lFE4YvaQ6Vkd40BSltSpvyhZs88suYUmdf6z9+Wryq+tZ5osz3rUW2Mx18vjy8lkvF+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXCYBCtEVfvGP8fC5LHCEhpgxNDHP4sBjuxIK+GctAM=;
 b=jkMsKdr/3BIuktah2H/VHQH1MaYxWxiOTTufeORaAd921D7TOCCGPNGNo3ziX2NjZIXt+E9bbrwUxpF7Tr4dG4fI88OKG1w1EQZlnLoT/rof7uqLHdPLfSjHTIO7zw/T5EtTexcn5WUA3nEF6FsZsEWiukoGWnZoExhI5hGu6PMdo2fu2hk+eGnYfJ42PyFf3Ojqxg2kIaZujtnLo96YiPonnf7f98iDJfjENhoXHeXQBLqJJn19Br+uMHGNKWGUTEmzd7LmAw+DaoQgdB/GPorP3sPHaaurHTpcnokB9eF0FvI0Sdu5aCBd3yrM4/ZFw5POmfGqbVqGgNUWdBWNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXCYBCtEVfvGP8fC5LHCEhpgxNDHP4sBjuxIK+GctAM=;
 b=YkGvw3wBinGwaWqf2L+D64TLNv2d5ypBWBzJnktFt03/ULBsWfwXLVLc17fqL87POWMWu3rMUXqM1AbraCz+Y++HwPgTDs9Ry/AbiGc+ltYNXJrohajQM0deISsbOeyQe3tucJxK0uvCmPxtG3+aGZJMCkrkLg4RhOnnQYNWd8VOz6YrFPC7t1YshZULNHK5EV+n20Wxc1XhNhJTSK7B3FRHptuY92koQdTD5r1ekM0KN/Ec25olr5UY+btNp8Jg6VdTGcF9F/pyNMNhQHVPzU80viW1mJtSe8UOfw5IvNR/4Bw0cvFL3/eoMulBhUnGM8jhdoblw+T1ytp42oTr6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 12:08:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:08:21 +0000
Date: Wed, 4 Jun 2025 09:08:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/4] VFIO and IOMMU prerequisite stuff for IOMMU
 nesting support
Message-ID: <20250604120820.GA5028@nvidia.com>
References: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
 <22733f4b-d759-448d-8cc0-ce25e723e859@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22733f4b-d759-448d-8cc0-ce25e723e859@redhat.com>
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1756c5c1-c54d-44fa-508f-08dda360800b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTNqdVNyblZac3FMWW5Md3FRdFNKWlhIN0sxOFh3Nm50Skp6dUVUV2twQ0F1?=
 =?utf-8?B?bDlmK2V2dEVpcU5MZmhFV0pjYkNHcDhuNThrcnc0N3NNRDl5NEpTeWlzZEVv?=
 =?utf-8?B?aFJHempaWVJCcGg0SlN6bjNIT1NnNU03NlFvN3Vhc3h1RmdIa3ppOG5Jc0Q0?=
 =?utf-8?B?N2k0dlUzd0RUMGw4THRuNDhjckVWTXVNcXdzZGZMWkJwcVhYWjBBM2xMRFVP?=
 =?utf-8?B?cDlqWFo4bUptV1hGd0EvVUVoTUxzSllJOFhQWGcrNkF3cjVoUlM0VmNuQ0pu?=
 =?utf-8?B?NU1FQk9aYnZCeVN5ZWg2dFZMbVl2eTIweGtrZnBucTFjaVUrS0ZUSkl2aXpC?=
 =?utf-8?B?Z0tWRFJiOW5KZGhPTU1nYStyUkg3QzlFVm4vcHc4ZTRwWVE3UHhpUnZZRnNX?=
 =?utf-8?B?MitiaUFIK0tlVVVFdFVXY3lWSktzZGt6R0FQVUNzQy9vRVNsZzROcFpMTGJC?=
 =?utf-8?B?bUhDZkJuNkI3alhPZ1lsS0JMaDc0THM0b2JqbEpMTDFlQ3pBanVtK1BERHZC?=
 =?utf-8?B?WFpHVE1XUkpYK2prUnpZQmgveTJnKzhNZHFDUVZRYzVRTys0NllCTjVHNXdW?=
 =?utf-8?B?b2xLRXVuWXkrc1U0bHV1VEd6Nng3UFdHeUpLdDNVU29nOGpUVDNlVUZBRk9r?=
 =?utf-8?B?RDZxZXdialRMSi9rU21XQkpFRUhFZjNKTnZGK2oyVGowOHhBS3FJZVpJTGk2?=
 =?utf-8?B?Vm5wY2JqTlIxVi9nYVpNdGlTYVlUQ1VlQlRuZ2JOcVRzMTQ4Ui9OTnBuMTdq?=
 =?utf-8?B?QlVBdXRsNXkxeG5nbjZBc2UyZ29CaXk4WEh3Y3g4dFhCLzJCMXRCOEw2ZzVt?=
 =?utf-8?B?K2hObXpQZm0rS295eGVtUUltYmJNbXJQcXNjRWFOcWFJanFCYXRObDJpdExH?=
 =?utf-8?B?eUt6VkZ2U0ZaTkRidDkxNXk4NTcyZjZtKzAzVG5LeUFaZ3E3ditxanZjMm0w?=
 =?utf-8?B?S2h6MEtXVWdUaElLZjlydmNZNm9JSVFRR2FxelNnSlJUWkREZFpMT093QkdI?=
 =?utf-8?B?Wk9HK0l6RjlMNmpqSEw4aDFMNWMwMFZHZEV6U0RuM0pHL085dTFCREs0K2hu?=
 =?utf-8?B?ZUhtbnQxOXQ3T1owSnNOU2FKV1ljbnozR1IwOFdLbUVjbjRGQXNuM1dySE5n?=
 =?utf-8?B?Zzdqd2hwbGhPR0Vad0FtU3lJcjVaYU1MMVlLNGRJVHFsWEs1a3AvRmhkaU9Y?=
 =?utf-8?B?d1pkNDYveFhDeDVLdFVVcWRRbUhwYkplUENmemw2ZjNjMUFrNjdkak1pRURx?=
 =?utf-8?B?aVdnS0NhY0dTNGFEb2ZBK3BEOERtL3EvbUdaWUlTaEt2a0NvUVpoTDlBdmdO?=
 =?utf-8?B?UTZvaEcvUDZ1Q3N2eUNIREZibW1jV2VCRytNZkpVbG10Vmt0MnlmdlpmUmRJ?=
 =?utf-8?B?b01JZmdWSGsxTDVoZ3psM2d6bmMyK1hMN29KcklZVU1RZW5odTN6cTdVUW42?=
 =?utf-8?B?VCtMNnBTakRudHV6NXhwdlNCNWRxeUg1TjVhRWZiN1pJWmdoZFZGYklLOUl5?=
 =?utf-8?B?bGlYQzUrMGEycmh4Y0kvcWZRNGhSRmRscldCNDBUdDAxZjNYNmdBc0RIaWxC?=
 =?utf-8?B?aU4zSHJydFI3OStQOTZVdmpRZnU4TXViR3RYUCtZRUlJVXJzWmpFVXpsc0Fh?=
 =?utf-8?B?QWVTNFByM3lhbktnUlVqYlhHL0UvRkJ0ZjRrV3NtQ2h5a0ZLeVJLanhYUUEx?=
 =?utf-8?B?UWhNVzEyWEk1K3hMZE9oUkNWUXU2c2JBU2xGUFFQTEtycWZpSWlwTCs0c3Jv?=
 =?utf-8?B?bk9EWHVTYWlxV1BlWHZtOWdxbTh4VHFrWXJGemNDU0llcXFXZFdWM0hoaVEv?=
 =?utf-8?B?RFg5YUpxM1ZsVm8rQXJOeG1DdTRSVTNmRlAyMEUvb3pHRjZ5cG4xOTVYZ1lJ?=
 =?utf-8?Q?mWy/uKs6YJm0k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENHcG5QU0V3UEhJUDdBNDJwM3BUcHFVbFp5RzM0QU1UMjB6Y1lPQkJ5ek8w?=
 =?utf-8?B?MDJaY0haWDRNTkpwdFAwMUdVc3Rka09MaVNUbmNRSWpTbE5hdnhVWDBISFpU?=
 =?utf-8?B?TE9ydnV6OFBoSHU1WWxuUlEvcDVZWE95bXpCR1FTeWdBamJ2S3JvUU1FME1F?=
 =?utf-8?B?cFg2NWxFTkVNaHI0QXZaczlVUDBaMkNHbGhZc2ZOamtVRW5lN2JyNlV2ZW9E?=
 =?utf-8?B?dS9yVzhFQXdKbnVNVE1uTVEyTXZPZFI2TlB4MTBFdE1hYTN5OUx5Z3JMNFN0?=
 =?utf-8?B?cjVJZWZQa0R4WWFaSFd5QzBvMkdHNDJsMzVGZlhvS3JHYisyZmwzRkt5MFUr?=
 =?utf-8?B?MWlsUUJNKzcvM3FJOUF6WW5oSFExUmJGZ1NWTUNpQ0pOYUIzU05vcEhua1Uz?=
 =?utf-8?B?ei9QVzR1MzBMZGVUNVJnTUIrOWR1cXJyQStNOGU3TjV5ZzNrank5czVMTDFB?=
 =?utf-8?B?NnJLUkhpVnk0RW9iR3BjTnV0dU1Qc3lTelJFeFFWRmtHRkpHOFZ2TTRJbmxn?=
 =?utf-8?B?UjBDQmhPdVg5RGxwWVcyTml2N1hRbXIrdTZMZXVVL0RTM2pubW11TWg5dnN4?=
 =?utf-8?B?dlVGQmpPU0JqeFUvN05tWEo1TVVZdWNIRVVCc3BUTzdoUndSVDJLK1JBbUFn?=
 =?utf-8?B?VC84OVJZSW9zdE5QODV6aWpDbGRwSzVCNDAxeVFlLzZkemUwUkdCM2pITU5s?=
 =?utf-8?B?QmthczBkd3FXbU56QUJHc0ZOd3ErWmFPZDFMTk4zUlRXNkdkbkRXdEJ6a3RV?=
 =?utf-8?B?R2dTcEpnbWE1SzZJL0UrM1VMbDh4MUZVYWZ3WlJLd1ZJR1pnYUFwQVpEY0Zz?=
 =?utf-8?B?OFpoK2xnOU8xZjN6N1drUi9tNFgrYVNRc2d0SmxoZ0N1K0pKbU9QaXdCMkw1?=
 =?utf-8?B?REZHOU9mQm9DdG9VSVBBZ3FsSTdoOWlscUVTdFc4VU9Hd2tNbGQreFcwb25U?=
 =?utf-8?B?ZXF2cEFxZlRIRGZlaUxEblBrb08rUXorb0h4UXZXWWpZN1VTcEZSMXlNOHVw?=
 =?utf-8?B?ZGVDZkRSbG51MjdLWGpKZmRGZlYxREtxRUlnR01jbXFsK2w2d1FyM2wxbXNV?=
 =?utf-8?B?STNBeGc3VWVHNnptK1hpanBnelZhUVFkY2o3ZktWdzZQbmtDNTByZjFvaTJ6?=
 =?utf-8?B?QnBZZWpQM0lrWTArdWhPdWxLUm5GUjlmemlFcVNYSW9ySDhjQmxtR3BwRU9R?=
 =?utf-8?B?bE0ySGFOdFZ4MnVmY2o5NklQUmNFQ2gxZFhsVG4vTDBoRGcveldYbGFRbGZl?=
 =?utf-8?B?MVFCazVlbEVHdnJPMVBxTGorckZscjRJLytqWERXdllmVTh4S0lTTWlDSEpw?=
 =?utf-8?B?cWIzd3FiRzRhYWMvRWsrZTR1L1VvVm5keE9mRWhWMktaMjlwZzhIRXZPN2xI?=
 =?utf-8?B?WkpwNEZtU0pORjNRT0c1cC9haUw0cml6RnFjZ2VyaUV1VGpmU1dnVG0zdEdO?=
 =?utf-8?B?STA3OEdCdFR6ajdCaVN1THRaUHVnb05rd1U1cFlNRDcxL3pHQ09uYzRXTEpW?=
 =?utf-8?B?QzlRRW0xS1hpUC8zbk9PZzNiMWN4UVQ2MVZFMUJlSzZIZzljRVVObDJuSGNC?=
 =?utf-8?B?ZDFhaUhGOTA0aUwxZGJwZW9UMEtEWEVodG5QVUVESmFHZnMrUHhkQ1NSSWpl?=
 =?utf-8?B?QWFSdHBkOUxNekYrTUJ1a3gxQ3BoS1RERERBY29ReDdDSEFlTzFHZ0pOK1hT?=
 =?utf-8?B?MWdYOTVMVHptZ3c3TWlvNnRuakUwZi8yWXJNRXVJSVRCS0xVTDVVWkRnUmVL?=
 =?utf-8?B?OGhHVkJtNW5abEtrd0V2TVFrZzk3d3dzK0lWY1JzdENjdUp1aFhWRXAzVEtE?=
 =?utf-8?B?STJBdHdvaDhaa1dEUWljMElCM3BWcnZuUDJRNktIbkZONEpnZy9wVmFyVHhy?=
 =?utf-8?B?MTRBaGtiRVNwejlzNTBKbUc0UEllcnBoSktabjMwUFdkM0dpUm5kZTlwNzZL?=
 =?utf-8?B?NHFRdlNQRkhVWkFnMjdDVXJ3Nk9uWm1Ja0ZETEdpQXhvM2ZzU1R3VG8xS3hP?=
 =?utf-8?B?ZHlUaTdTY1MvUk9jTUlKRE85YVNFZ1A2M0lzSGRBRE9KT0hOekJEU3c3VXFr?=
 =?utf-8?B?VWJvM3ZxRW1FdzJ0RWY5ZXFqZGtaZlRWTVQ2dm1MWFRxajlubDZmTzJnK3JH?=
 =?utf-8?Q?xs2Q6uHQdEdBRsS8ztgD5zVQN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1756c5c1-c54d-44fa-508f-08dda360800b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:08:21.9194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFNkDAhQbxlEytvJgiZlFC4vhoXXdBcWQYxaBZtdTvxQwl3HVMyQWTcJSx+fLlbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
Received-SPF: permerror client-ip=40.107.212.81; envelope-from=jgg@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Wed, Jun 04, 2025 at 08:59:37AM +0200, Cédric Le Goater wrote:

> b4 complained for a couple of trailers :

He re-reviewed patches he contributed to making :)

>     Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✗ DKIM/nvidia.com)

But why do you have an X? The messages are properly formed leaving the
nvidia server, I checked.. And my b4 is happy:

$ b4 am https://lore.kernel.org/qemu-devel/aBUHLWY1Qdapgl+Y@Asurada-Nvidia/
Grabbing thread from lore.kernel.org/all/aBUHLWY1Qdapgl%2BY@Asurada-Nvidia/t.mbox.gz
Analyzing 50 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 7 code-review messages
Checking attestation on all messages, may take a moment...
---
  [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
    + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
  [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
    + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
  [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings code
    + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
    + Reviewed-by: Eric Auger <eric.auger@redhat.com> (✓ DKIM/redhat.com)
  [PATCH v2 4/6] hw/arm/virt: Add an SMMU_IO_LEN macro
    + Reviewed-by: Eric Auger <eric.auger@redhat.com> (✓ DKIM/redhat.com)
    + Reviewed-by: Donald Dutile <ddutile@redhat.com> (✓ DKIM/redhat.com)
  [PATCH v2 5/6] hw/arm/virt: Add support for smmuv3 device
  [PATCH v2 6/6] hw/arm/smmuv3: Enable smmuv3 device creation
    + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)

Jason

