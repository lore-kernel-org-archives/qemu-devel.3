Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B348C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWPl-0007dH-CI; Wed, 09 Jul 2025 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uZWOZ-0005OA-Bg
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:07:49 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uZWOW-0007KL-B4
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFnfctlrG28wqFPLr/x2Sske92VIV4DLjelTqd6ADnFApGNZ/6CIlTlfDxyBhWuU5X+/ycUOIisO+u5hGX9f8et9eNTk9rqE+fe+nKVmGxSBR2HmVQ0nhQLITISFA4VneOLxJPNlG+ai5jH15ZV6mZToCyH6F7YgzF+lscbaGGHM0wxk2YNAeuDEWHi+JG6S/fbMHK5p7OAgm954VAYQBmaLSMzQ0gAG5Mtg3uZBeEsSPnkto7OpW4p+rfmwyp+TJ1Q8iWBIpA6uUSRhRqcJFdAtbbmdtt7OS+PnimbZ12j4/20PLyobYnV/yGyzBLPxEvDl6H6W+b3L3hFcOwlM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPtkMV6deUaIi0QeXGZnuKSMEgkYgBpfUZZPk5Zy3pk=;
 b=xMvUnVlJ9E4PApJWigA124utz7YMUiHD0NLikWXtCTfLQDZlftr+cZquOw5Z3/aM28f1HRbobiEngv8tiRCDBknT+u1vSSF5Fcj8Qpy1NwgLi4kKWmsWdoyMbplVAKSIY8dkBlRltp+ERHtwGZhmLM9yDGHOFPHm3el7fNwBLyQK8WqPEUPxXBuo1yoDf/lI/ZlQ/a/v3lZdCa7Sb4OiyrlkRpzBCgTpLCj5tFVe9a1fcQqaAZ0U5ffk8y+yr9RzYI7r396WE6JJ7vJ20TkheuInoTmedfOZEB4kIGBNNZISMFE7AjtANtrVlh7yc/B1dTyjtJbrpmRd7DK12uhNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPtkMV6deUaIi0QeXGZnuKSMEgkYgBpfUZZPk5Zy3pk=;
 b=DBwGOzi4uZfo3c7EGt+CdK659Vkl73+ALlOwEp2nMUjNJieLkw78P/FdyIy2mIwwvZj4dmcJOxiLWqe6rby/49ZHySjkiKnBrDIQbNjFU2Z1Dc01sNJaBie/SYsijzvLNVUJ/MX3aud2nqUsHkWMe+T3jSSadUhym4co4L93QR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 15:02:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:02:21 +0000
Message-ID: <8ba851bc-e7b3-461b-9bfb-4d7018771f0c@amd.com>
Date: Wed, 9 Jul 2025 10:02:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Add TSA feature flags
To: "Borislav Petkov (AMD)" <bp@alien8.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: daeb2979-b096-45b0-db8b-08ddbef99afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3c1T3QvcEtQSUQyeUQ0QndwTm9JdUNuNE5TYnpJWUZIellsWkhKNkFJYTJI?=
 =?utf-8?B?elJOTVBpREhMZkliTnlUQWVyMFRGMXl1RC9kRHJibGpnVEFUeldveC9SdGE4?=
 =?utf-8?B?K0ZDclBvU1E4L2Nrdmc0aE1QVWkzaGZuK1QyUEJZellxaTJIOExNR09EOGQv?=
 =?utf-8?B?WElycW9XdUIzUFRQOHFsdnovZllRSXFZVzVYL3pPdlczaUx0c3FJdmUza2Jr?=
 =?utf-8?B?YW9nREpzWGNhTExwMTBWOTlWZWtRMFFRc3ErL3NhZjNvNU1jUkNOZFMweTU1?=
 =?utf-8?B?VklKQWVjVStrYmlId1hKZTg5SCt3aURDNzh6U2VmaWZ0RkdubGpueXFzOTQw?=
 =?utf-8?B?TEh3UkRydzQ4ejg5dHhsdnkrcTl0R0tlRjZBSUNVRkJtRDgrdU9hVkExR1lB?=
 =?utf-8?B?aHNzenFTcUd5MjdOMHNtOGd0SHhKUldmTjhWNTNwN0NMcjNYY2paWitqQVUr?=
 =?utf-8?B?WThMV1cveGFHMktHUHNsUlp2b0JHZ1FyNG9FaVVWWWIxVldIRllUV0txSmlE?=
 =?utf-8?B?TU90VTVrV3dzdEdNR2JHRUVQMVptVlVlOHFxMExBZkEwSXE5d1lPcmpXaWFP?=
 =?utf-8?B?Z1RXUVVnR1VsNUdocG1ycmVlU0FEbklKMHlyaUw2RDdxTFhZS1BzTExuaGhE?=
 =?utf-8?B?bG9TN2xUcXlGMDRuYlhHUHVwSitSbE04VTR4NFZ3VVN6S2QybExadUNiZFRo?=
 =?utf-8?B?OC9KRW4xU1B4b1RvZ1VMcjhabjk0b2pZNHNvUkdtR1padXNleFdvbDRwZ2FO?=
 =?utf-8?B?M1c3aEhiNGNNdW51aTU5MGlYWXd4V0E0RDN0d09EYTNubVFFYVU5T1dMbzVi?=
 =?utf-8?B?ejlXVnpXWFBITytFZlNWcGpjdllYcW9NdnUwbkZGbHJtNzFtdllFVDJTVmpV?=
 =?utf-8?B?OUYxWUlRdkw0SDNFazdZTEVvbXgyUG1vaEpRNFdNS0hzeldvUmNCMXNpamt2?=
 =?utf-8?B?eFhGdkdFMjNYYmVkanZ5WTdvb2l1SU1Fd1YzQUNVVDRqMTJLTXlnSkFKdUpE?=
 =?utf-8?B?L3FkdzZLa3RKVm9YbldNYjZuNVBWZW1iclpQZWlkVko0eU9raFpRZWFMSmpI?=
 =?utf-8?B?WkE5bm01b0tpWndFR242K1YrMVZ4NkFhbGpSSkR1Z2dLUGROSTY3K3ZnZThp?=
 =?utf-8?B?aHZWTEd1VXoxWWFRNnNqQkhFTnVWM0plT3M4ZS9kVGhFMUpqYWRISFVvOWlK?=
 =?utf-8?B?bFpNUE42S2JXcmpJNitCdyt6QVN2RzJIcU5xSnRQM0EwUFBtWmFkNU5rRFhK?=
 =?utf-8?B?VzNhR2lwTEVCMG1yaCtTVWF1RUVsSE5Qei81ZGxKVlV2NjBFQXQ5dGtFdy9i?=
 =?utf-8?B?VEg2Smwwc00zZFNnNlN6VGpjL0hmR0ZNNmI4bHBpZDFzaTd4YXAwY1lOcTNY?=
 =?utf-8?B?T2dUV3FzbXl6VHYraHpKVUo4WHBicVBRZGFuN0cyTGdDT3ZuTTZzMlFHNGhI?=
 =?utf-8?B?K1ZKRTlOdVQ4K2cyU29BSzFmL1pMUUxrU05IeXZOWVIrSTFKOHBLN05lUDZB?=
 =?utf-8?B?bmUwUUIwR3pGalJRczZHY2gvbXZUWGtoWFhaSERmcXdOMEphYjNrTmxKNHVR?=
 =?utf-8?B?VThYckpTMFpPSFlQcmpUdTIrWFJQQ3VYemJZOTFXbHduTWNVVWJBdmwwQ2cy?=
 =?utf-8?B?TUpra1ZtekRUcFpQTlg2WjFaRkZ1Zy9LaUFMQnRBeXBQeXpyV2YrNFFNcHdr?=
 =?utf-8?B?aVJUU0hPUlNPOFhZZkZCeDlIdWQyUmllYmt5N0hYR24xV1JXUC9teVFzSEJM?=
 =?utf-8?B?VG9UcDJWaGtnVjhYL2xBUVRSc1hNZzZpWWhZNWVxek1YRUIxZ2pmd095N3Bp?=
 =?utf-8?B?cldXclFDYUVSQXZkbnhjSFYyL1c5bmU5M3B2SFEzWDVaMkM2bXY5KzFGb0I3?=
 =?utf-8?B?NG50S3J0eVptNUM0SitKZmlpK3hsb21TY1dFWHBPR24yMEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szlud2MrM0xqdXpTdnhoamlhRnlkRTNoV0VkQnJaZUdxcjJ0M3M1NlpFbHRy?=
 =?utf-8?B?b2FSU1RudForUnhDUlZXMG4za2xkQ21xcC8vTWMzVnhtRGR6bzVzaU5tRzMv?=
 =?utf-8?B?Tk1LS1UzQ1VtV2wzdGVwM0t5Tjh0M0dKTGlIMjV6bjRQRFJyNVBRR21BaWEr?=
 =?utf-8?B?OUduMEJWOWRtTUVFY0NzZm5KSGJiMUwyWGtiaHRnbDFheFQ0VXc1N0JHL0gz?=
 =?utf-8?B?RWdwcUhDVFp1M1NLb2o0R2xHTFdObXRUMG03Rm5STXhrVGlnUUlGc2hUdSs3?=
 =?utf-8?B?R29kbnczQmVUR3ZXNmp4WTIyRHVabU1BZXU4d0hNcnVhUWxwN2lhN3MxN1NO?=
 =?utf-8?B?ZWdCUUJtV2dKVEl3VXU3T0NKZmhuczNHMGcyKy9ORFNuSFpEZEI4dmNIbzNt?=
 =?utf-8?B?YXdkSG1ZWWlTRWdyKzROWmwvcGlRTFEyWlF1QVR3R29Qc3htMDQyRVUxY1VS?=
 =?utf-8?B?TTBYMVFiRWdWRUYvU215NU96V2xHazB6dTJBZXovSVo3WFNvVlR5WWRldmxG?=
 =?utf-8?B?aGtONVVaTUxpeFphaVFCblIxbTJlNS9iR3NWUWt5N2xza2VSSnJUQ3FCR3U5?=
 =?utf-8?B?RHY4NllIM0tlbkpFemdoVzZNN250S0sxWkxTZUdmdlR0ZVZ4TGZiZ2ZZQk9r?=
 =?utf-8?B?MVRweENFQW9QbDRBSmE4QkJQRjBQQVFaZGFPOXBEVVRiQnN4Y0ZvN1FzVkhr?=
 =?utf-8?B?TUx4RkpadVhsM3ZNMWd2WDB4ZGpRamxEdDYyUCtjQ3ZmM3N0d1VibUJwRGM0?=
 =?utf-8?B?L0Z0cTdyM2lpZ3Rrb243NTRzcWpGL05DNThqRDVOSS9zM1c3UUhsMnpZWVhN?=
 =?utf-8?B?OE9zSHBSRjdyZXFKODZmYjE5L2hQU0wwTTNYZjRIY0N4a09tMVMrMnk5ZXJR?=
 =?utf-8?B?aS9HNyt1VHhkdW42SEJObnRhaDhmZ04zNU81ZjJPY2FDYmlYOGMyNHdwU284?=
 =?utf-8?B?cys3OG5KREZyRFNnMU1PM0l0VU9iUXF1cWdrb1FKRS9zSTVuSHlNdDN1MU8z?=
 =?utf-8?B?Q2ZUWDRmbzFpM0xLb0UrY1RwU3VwbW1IMk9NWWFXS0tVaHUwaURCMGZWSFdr?=
 =?utf-8?B?Z2FnbVAwNUdUWFFxaUNxL0NGcE1HYlJTblhyblJyOWE3Yjl6ay92clRNWUp3?=
 =?utf-8?B?M3ZHMjRyOGhXVWgzMWRUTnI2UWRhYkpSR215UTBGbjJXT1QyaktnRjJubmtk?=
 =?utf-8?B?dktqVnZSWDJtMG90czNLR1dLOUpaUzJkTVB3b0hFZ203TzZESFJobUtDdUox?=
 =?utf-8?B?RFU5ZmFjSUprSGtGNjIzUFdNTEVCNmhoU1NaVWp6WU9MRUFSVHdYQ0VNMmIv?=
 =?utf-8?B?bG4vSzVmZkYwNzVHeU5EYnkxSDJnWUEwRlBYaHFjSTl6M3E0eEc3enBLNkpZ?=
 =?utf-8?B?dm9xWFlQNm5jTC9xdjJoM2dlZVFVMTREaXo1NHlNTW9xSldlQUgxNnZnQTVB?=
 =?utf-8?B?NDdpLzZhdVZqT2dmY25IU2lFbk5hc3dNM2Uyd1pXU2tpMzlQZnRBOThnWnRD?=
 =?utf-8?B?elVGNlp6bmNnZWphL3g0enpUazhEYjRVd082aG9Yc0N1YmFFOGhlVk56aUJN?=
 =?utf-8?B?SUVoOFNKck5WaW5zUnlpQXEvanJ6cWY4K2sxb2xBeitQTTZBbHVnTXVKK3pW?=
 =?utf-8?B?Z09DRXB6WkhhTzUzM3Z1ZE1pSnZoV1AyZGMzOVBHYm9KeVpKVVRlYWtReXZB?=
 =?utf-8?B?UUtDMWZFcC9XTWJLaXlGYjRrRnhXby93U0RaUnRKaUJHNmdWdWZwaHl5b2Fv?=
 =?utf-8?B?SnUyaWdjZVYxMmdoM21XemRaeEw3R0JMY3c2cGxSeGthcExMbldFRTJIYTdE?=
 =?utf-8?B?WDhSQ2tvOTJvbFV0Tm1ldlN6cXBDUnhzVmZ6Y3A3OG9ZcFRwc0tjbW54RCtV?=
 =?utf-8?B?S1JnaWN1SHR5eVd4WGIwT3ovRzg4N1lrQUZKYndFSDRJaFQ4blVRZFp6RFh3?=
 =?utf-8?B?N29qQmNydDB1YWRZS2I4QU5VYmNtV3VHL1FDNXRqaGFUVVByanBJT1ZlZ1h2?=
 =?utf-8?B?azJMWDhYTTNCekpQTWhLTEdkQlp3dTdibEFFb2pJTWdBT3VMTHhQWGZvblhJ?=
 =?utf-8?B?K3ZVMjl5UFdSeCtnemp3WFB1allhdkhaL1IzdmdNUjJrSlBaYUgwTy9qKyt1?=
 =?utf-8?Q?JO/s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeb2979-b096-45b0-db8b-08ddbef99afb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:02:21.4533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ytaaW8qG6zOKz/gNNasSGFCJG+9rV8+jm7eqxRO/CmUpUKjY3+3BJVpEQFqWhzk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
Received-SPF: permerror client-ip=40.107.94.58;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Boris,

On 7/9/25 05:49, Borislav Petkov (AMD) wrote:
> Hi,
> 
> I *think* this is how it should be done but I might be forgetting something.
> It seems to work in my testing here.
> 
> Babu, double-check me pls.
> 
> Thx.


Patch looks good. Few comments.

Is KVM aware of these bits? I didn’t notice any patches adding support for
them in the kernel.

I recommend splitting this into two separate patches:
a. One patch to introduce the new bit 0021_EAX_VERW_CLEAR.

b. Another patch to add the new feature leaf FEAT_8000_0021_ECX.
Also, don’t forget to define tsa-sq-no and tsa-l1-no in target/i386/cpu.h.


> 
> ---
> 
> Add CPUID leaf 0x8000_0021.ECX support and add the TSA CPUID flags.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  target/i386/cpu.c | 20 +++++++++++++++++++-
>  target/i386/cpu.h |  3 +++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430fe..b889de61ed9d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1274,7 +1274,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
>              "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
> -            NULL, NULL, "null-sel-clr-base", NULL,
> +            NULL, "verw-clear", "null-sel-clr-base", NULL,
>              "auto-ibrs", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> @@ -1308,6 +1308,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .tcg_features = 0,
>          .unmigratable_flags = 0,
>      },
> +    [FEAT_8000_0021_ECX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, "tsa-sq-no", "tsa-l1-no", NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 0x80000021, .reg = R_ECX, },
> +        .tcg_features = 0,
> +        .unmigratable_flags = 0,
> +    },
>      [FEAT_XSAVE] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> @@ -5835,6 +5851,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>          .features[FEAT_8000_0021_EAX] =
>              CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
>              CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
> +            CPUID_8000_0021_EAX_VERW_CLEAR |
>              CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
>              CPUID_8000_0021_EAX_AUTO_IBRS,
>          .features[FEAT_7_0_EBX] =
> @@ -7934,6 +7951,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *eax = *ebx = *ecx = *edx = 0;
>          *eax = env->features[FEAT_8000_0021_EAX];
>          *ebx = env->features[FEAT_8000_0021_EBX];
> +        *ecx = env->features[FEAT_8000_0021_ECX];
>          break;
>      default:
>          /* reserved values: zero */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 51e10139dfdf..8b2703f41b73 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -641,6 +641,7 @@ typedef enum FeatureWord {
>      FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>      FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
>      FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
> +    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
>      FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
>      FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>      FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
> @@ -1101,6 +1102,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
>  /* LFENCE is always serializing */
>  #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
> +/* Memory form of VERW mitigates TSA */
> +#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
>  /* Null Selector Clears Base */
>  #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>  /* Automatic IBRS */

We need to define tsa-sq-no and tsa-l1-no here.
These definitions can be used later when adding a new CPU model.

-- 
Thanks
Babu Moger

