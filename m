Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23D1C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 02:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtxn-0000TA-AL; Mon, 24 Mar 2025 22:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1twtxk-0000Sj-6m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:24:20 -0400
Received: from mail-dm6nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2417::622]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1twtxi-000436-46
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UieksE1EP8BF17HBIyFvMpZz3YpVFcYqf7tKGORslSnZ/l/eydMxsCWCjOD3B4DPKFjGdy31GpMzQBskQE9zUf3fqmKiigLC21iUPf9psZM31HIUfjBKNwowK0o266JDZTt8x77ECpkbN3wlscMVchQFnN5Z8D/760gB9Q2eqcQyzXm0ri9I5vyQWdzi0GEjkruKLkKLsfATgmgSnv6GwObaukp2/XFn3BI9Fl3UxL7rnm2XcwYA1AgU83LXxyOi6UnUwaJfOJA0VzGUgANxwzQPr08qIaj1RNDPzH8o/l3ZtI93JlAowhj5vw8dCeo+STBSW3zleowKNW187ksJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OcquC/mQ1BmZLhZPxM5CDWjJpBGTc0UDzl0h5aCy3g=;
 b=Wv1wmK/ZOHrjA0HPYPsSSc1UeVzH8l1IQLUe2NrR32ywNJ8fyeYPHIibTFbTJnfHl3PBT579rc5Ui/f9moeZd9Zsngxe82Qg6/TAPky0yRJWl0dgUWKWk/HjDSveRYVyF7nvB2+g+d81HRbgIE0KY5YxQ6xkejBo9yIe77G9+4SdgU3iY8PrH0iVQKKxPTHd//bbULBSKrVQGryYToxF2Qx0Ngx4R4wl4KzL2kT7Sm5EC8qA8i095Suw6ExJsMJCA5Upa96c7mTKyLUp8ZUTUzjUs9DhJ6h4oYoZEBUlUjIqqpzRgO6HfO9McAHXiosoryd4NAJAeg/bb8a2K9WXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OcquC/mQ1BmZLhZPxM5CDWjJpBGTc0UDzl0h5aCy3g=;
 b=DRBsgaiM0JrDtQ1kjA7dI8Oex2c/Mj5BM2faZfoT8ymgDMD4y8XQQAL5tRdV4JNwQQwpKNUII7WjPmi0j6SGILplucFyXoX4qDXbkuIBNf3GZowBLkB1Jqe5JA2saZBXrXI4idLPEhi2eJSJYy3SCZt/v+oguDQpQswJcRJYb0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 02:24:11 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 02:24:11 +0000
Message-ID: <7ea351ef-02f6-4c6b-badb-278aab132da2@amd.com>
Date: Tue, 25 Mar 2025 09:24:02 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] hw/i386/amd_iommu: Add migration support
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, bsd@redhat.com,
 berrange@redhat.com, joao.m.martins@oracle.com,
 alejandro.j.jimenez@oracle.com
References: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5c::18) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 2076ba6b-aa1e-476e-6a11-08dd6b4420e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZOVmNYNXc3eW9wYWpqWmFjc09kbVhXOHRldHlNdHB0U3lESVZHbUhRRE05?=
 =?utf-8?B?SGVLaG1ESzh0U1ljZXd1SnVTeGlPUHVTOHlsdGZ0V1Jjd0JHeDdpSXlUOTQ4?=
 =?utf-8?B?NlhCa2V3Sk92QmkrdUllUHNOb1N1a0VMblVQMVgzZ2ZaeXZ4TVNoZlZxZVdM?=
 =?utf-8?B?MGY2WVhTRlFJdjJ1bWoybkxhTk1JQVRORTF6R3VIcThMVEhhQ1l4NTl6UHRx?=
 =?utf-8?B?ZW9oNmtzUkxkUndpNUhQVHRjbyttWUp5Y3kvOHpHL0lPMzBUekRuRkE2Qm5z?=
 =?utf-8?B?NWU2RDF6SWJQRWpWUHhxa0x4clBQbkVZSTRJKzkxVEMzYnJ1R1RvcitDUTQ0?=
 =?utf-8?B?a0ZoWG9scUhwSHZBUWFJMFE1eDR6VXZkOENMcjFyalhOWUZ0bnBpelJUZHVa?=
 =?utf-8?B?b1JVbE9kakNKUkV0bmxoUFNHS1VJV1M3NElqelhPODBJZXZCc3NWeVNGellh?=
 =?utf-8?B?QmNBamNJV25GdXU3ZTkzN1FGRzJmb3FDdEdCK1IybnBPOWMvRmNUL3dhYlNY?=
 =?utf-8?B?dDFCbjVrOCtxOXlMb2c4cVQwSmhrdG42RnczUmE4dmRPcFpheTk0REdVdUg2?=
 =?utf-8?B?UE5wbiszcjBSTXYzY3VrNG9GZ24ycGlORXRhVlU0anlLUDA4SEQ1RjVJQUg2?=
 =?utf-8?B?N2FPZ1BRdUZMdkE5anZRZ0k2TkN2SnM3STZDYzZhNCs5S3AvWDRwZnEyTm1w?=
 =?utf-8?B?dEJCTGI4MnlwdDdhZmM2MXpaVC93QklhR2ZqekdTNWJYT04yQTkzWmNidzUv?=
 =?utf-8?B?L2FVUjh3c0RmT3d0ZGtxL2NHRnJnUU81aG14cmdJQkFpNWx4YjMxdDk0TVYy?=
 =?utf-8?B?QU9KNkY3L1E3SXE3MTBuRmx6VGlFbkt6S3FjanlxYXVtcVhEdWVxc09YQ09C?=
 =?utf-8?B?d3VubmhubDVtRU9kZnFlMGw4L1NkUHdFWmwwUUZ1RlZlTlRwdEVhaTJiODR2?=
 =?utf-8?B?YkZDaUlsT0JYYzM3SjU5ai9sYm9paHd4RVZ1TVMxQVl5MGE3c1o4L3ZZenk2?=
 =?utf-8?B?a0JWdHcrTnRpWnZUWlliUlVpQjZLVjN4MG5WekxHNXhqSkZDbGk5cjB4b29q?=
 =?utf-8?B?aGs5TG8ySFI0QTJaa25abzNQcldpZmxyTi9pVW5BY2lkY1gwWThKbmtLL3Yr?=
 =?utf-8?B?WDZleEpWTTZlVkQyWG5zU1N3citVWHByZVdhV3RJY292SkZCT09oT0QrdUFN?=
 =?utf-8?B?bWQwdUtTU21sOWo5MHh3T0hZUE9NMHYrdm81NERrcXlJK09BbUs0ZUFvTEV2?=
 =?utf-8?B?SWU2MnNXaWhIcUFLcmZrMjhZRkJtUERBTUg5c2J5SlVRbXRZNzl1L1R5MVUy?=
 =?utf-8?B?L1VCQVlISHphSkt5L2hWeUc3bUFxc1NvYnRlYStrVWR0ekp2SytaWGdmVzdK?=
 =?utf-8?B?ZzAyb2VhNm5sanV4OHUrdFhqMkVHWHdraHlkRnVjTW81MERGT0ZCcFZFV3ZW?=
 =?utf-8?B?akNKbzJsNHZYSjZLaExmenR1aWUxNjJzUXdNaVdHU0pvcXBzQ1NvYzY4cHhD?=
 =?utf-8?B?cUE4bU1TelZwcUJLbWU4bWF0YzR4OWFQM1NBeWhPS1lHNEFmb0pCZ1FodlZ0?=
 =?utf-8?B?U1NkV3lvZ296U1lkejVsMWF6WkpIcHBRV3l5dklEQzJaVDVNeWMxYkowR1hC?=
 =?utf-8?B?NTF6b3BrcldsLy9OZlo1Z0JGb1Z1eG9GYzFEOWRxOHVVNExvSUtrU082RVlP?=
 =?utf-8?B?RGF2Q1RxeVMvcDJPOXkxR0NqNFM1WXdwUTZzbUVWVFplUWtQWVZ5bTNwcWN0?=
 =?utf-8?B?MWl2RlFRR0ozc2k3eThiRkhWTFNBS2VUZURDVndMSmtHa0h0ajhNNE9HbUtN?=
 =?utf-8?B?NDBRVXRLWjBYQ29QL253VGczUXZTbXB0YkdaOGVCV0JQWXNManlVZW1meE5l?=
 =?utf-8?B?c1RaZm9OT2s4WHE4SHZad0hRVlBGNk5QWU1jQUo2dlN6dVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZ4SUhLSzQ3SlJLalFaWEZ6MnF2T3ZBTTR0ZFBqandlOW8weGxMTXJLekNB?=
 =?utf-8?B?RXFGTjJjYUlack5xK05QNHZFNklKZ2xvR1hWSEpaREpQVE9RNFlnc2ZadFpK?=
 =?utf-8?B?Mmw4QVpCWFRNdlBiWWtURDVIOU0rUEdtTm5kSEt4d0lpWDRBY2hqc3o3TG9v?=
 =?utf-8?B?alBwSFpIMjlXaXF3bCtza1lSSDhGY0dYRFRQZVQweTgyYnk5eGFadnNPdVBn?=
 =?utf-8?B?ZzVPTHZSZ0N4OWVKbVkrdG5RSU1Ob1ozRmhSSlFwcFRSa1J6K2ZCTHBnekd2?=
 =?utf-8?B?RjZHaU1Ccmd6c3dmRVhnR09oN094cTVSN0c2TVFxc2VmTzRZMGZPZVU3QUFW?=
 =?utf-8?B?UVZBbHlJSmhtenhsWkttWWRENzdGSDgwTzQ3R0ZWenNuWkhrcUhvK01Lcmhm?=
 =?utf-8?B?Z05yTU53ZGlXV3R4ZVBJbWZLbldVS1dpY3QxRmt2M0oxRXRSdElPRCt4RFl6?=
 =?utf-8?B?T3hBZ0lyRVBDdVRkVmoxTXN5Q1FqN25VUU5UQ3NwbUt1Y1V5MWlDaWZzSlVE?=
 =?utf-8?B?RmNPQ0hIMnFoUi9YYjNGbyt0cFFuU3h3SThlMEF4cEZWNFZDUlM0RkhTdEFG?=
 =?utf-8?B?emo4aVlDemFOSURmWllxc1pWUW5KSk9veWo3aVp1T2RaZ3EwSmxKR3JjcDdZ?=
 =?utf-8?B?M2xSL2ZDdnVhYlV2VUpyUUdkQnUzWDVVRjJTb21JU1dJVWhTYndzNld6WFcr?=
 =?utf-8?B?eE13QkJzSUhScGFCSjhoenA3WWtoamVSaTR0RXUzYnp2bVNKc1Nmdk5QNmRC?=
 =?utf-8?B?ZVVDOXhIa3JXRWpISGdJck5rU3JXRFFJT29rZUIxYzlBS1hvNXVsTGJzTndv?=
 =?utf-8?B?bU1sN2ZDVnhRS2xxc2pZdHprRzdsSGhRRzZwcE5pK2M3S0dFUHpnRG8yeWxS?=
 =?utf-8?B?WEVSdmdKNXMyYU5jMkc1OUtUQ1JnSlQ1QkpPTm1VdUIrNlN4OWlidStpWkNi?=
 =?utf-8?B?M3Rta0pEN0orbWxYS3VyekhmdGJ1cHBmODhBUkptaG1ZMlhWQnVVOTZnTzBk?=
 =?utf-8?B?RFBiTGlTMWlBTEpvLzRNZkZpSmx4Zmd4ZldnS2EybmloQURSWGJ1Vll0TG9H?=
 =?utf-8?B?ZkxMZ0xjRW5kNGh1WVhTc0RzWG9kS3BHL0xmcW5xQm9SR2ZXN1l3cm9ZOUF3?=
 =?utf-8?B?Mmt6RktzNHQzUkhDNzZOcCtVU0RqVjBlOHE0SE1GNytKNm5NT0NwTGRCdUll?=
 =?utf-8?B?MWRtREFGUEFRRElCRXF1OTBDcDJTc0w2Wks1U1VVc3JpUThjcnYzTy91Yk5m?=
 =?utf-8?B?VHNNNHhmV1ZwNXAvSVNNaEh1SUtJaHhaTlROYytjT1ZEUFArQXpTelZiOW5j?=
 =?utf-8?B?MEpKekR4Rit6UmY5Mjlacmdra2ZTTGdNRVBmU0Y0Smk0bStrMTZTMU1jd1lI?=
 =?utf-8?B?R0VZeDNpc0FVUGM5SHNOY0UwOHcydjRmNEpYbjZ5a0hYbGZmUmdsQUJMUFky?=
 =?utf-8?B?ZkRpM1h5UUgyUkpNbHdQOGhQSXo2cHZML3RPVHBuNWtZOUtCZ3hhazVxdEYr?=
 =?utf-8?B?Q1E3SDgvZ05ETTh2cUxQQ1RxWGFteElma0VSOHVCS1hjbTYyRk9FekQwQ1ox?=
 =?utf-8?B?Qm9OMTF0V3FjWjYyTlpucktXN3EvbkR1SkV1RzFRcnFmZU1iL1UzSHQxUW9R?=
 =?utf-8?B?TTl1b0w2aFlMbzVCWk1NNmdwRFU2WXBDdDg2VnFhVEVjeTNrVVl5V3A0d0tv?=
 =?utf-8?B?VC9tZFFpNWl1TDhqbGdOT1hHWHN2dkwzektEVDhRdmY4TTFzMEZJRlkzTmJ6?=
 =?utf-8?B?TGVpTndYZUZTeWsrbXh2QmRjZjJvd1dieWhwSS84K2xtMXYwWGFWaDRDaGtD?=
 =?utf-8?B?RE1CbkMzeEVpVlh3TnE5Wm1lS0xSNjNlRkNuV2tGQWFUaEVRaGV6M2EzT3Qw?=
 =?utf-8?B?NzV0ckpBR0p4UVBKcEZ2QlNyWG56cHlSS2lLeGVteWZJODdxNDYxSC9OcnNh?=
 =?utf-8?B?Q2xCUHBRcmhZMGRFYTR3WmNaemFLRWNIOGg5SjBCcDlOQWlrZEF0bkQ4KzhB?=
 =?utf-8?B?Rmt1dXJ2ZnJTWld3OGdjMHNvWVFSYnpBUVExMXJjdDlWdk5BZTdGSWdkNTA2?=
 =?utf-8?B?YkNtOTVuUURiWDBVK28zMmhHTnovMGRoVTNNSVlLNGJNaWdEYzVwQ3BsaXV1?=
 =?utf-8?Q?PT2scLtNZZqZvseykJgE/iIzP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2076ba6b-aa1e-476e-6a11-08dd6b4420e5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 02:24:11.4051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYI6c7j3OwJ7KZg1jmjRll2596pgapqKrs28yQH0xBrSjSmIe+JcD3hz3FHWHj8be+tSVvmmYL5FsvkrhwJ6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
Received-SPF: permerror client-ip=2a01:111:f403:2417::622;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hi,

Any other concerns for this series?

Thanks
Suravee

On 3/4/2025 9:17 PM, Suravee Suthikulpanit wrote:
> Currently, amd-iommu device does not support migration. This series addresses
> an issue due hidden AMDVI-PCI device enumeration. Then introduces migratable
> VMStateDescription, which saves necessary parameters for the device.
> 
> Changes from v2:
> (https://lore.kernel.org/all/20250212054450.578449-1-suravee.suthikulpanit@amd.com)
>    * Patch 1: Fix build error
>    * Patch 2: Fix 32-bit build issue.
> 
> Changes from v2:
> (https://lore.kernel.org/all/20250206051856.323651-1-suravee.suthikulpanit@amd.com)
>    * Add patch 1/2
> 
> Suravee Suthikulpanit (2):
>    hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu device to allow
>      full control over the PCI device creation
>    hw/i386/amd_iommu: Allow migration when explicitly create the
>      AMDVI-PCI device
> 
>   hw/i386/acpi-build.c |   8 ++--
>   hw/i386/amd_iommu.c  | 111 +++++++++++++++++++++++++++++++++----------
>   hw/i386/amd_iommu.h  |   5 +-
>   3 files changed, 92 insertions(+), 32 deletions(-)
> 


