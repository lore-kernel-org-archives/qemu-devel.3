Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF40CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28pO-0001qI-Pj; Fri, 26 Sep 2025 09:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v28pH-0001p2-U3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:49:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v28pA-0001zc-Ck
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:49:31 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58Q7LCNN1598878; Fri, 26 Sep 2025 06:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TRStolNviiCrj53mWYIw3PJHItsmrZiK7+NuIeAy5
 lo=; b=xJfrUHQte8mrrRyueE96htqnWJ1HqjH6Lj7KZL5Z2GZmakh20VEBd4or9
 A5sBngvIuQjZRUDmg1l4p9MoQaCyacGpmi0fejfxfIBrrajTvUqC12Jrru/fbn3e
 uBTpAjMuzYBpi1dqER5hl0CxPFDEYF1o9HkQXFz9GVyMEPJVBcAxkeZh3cAFqsIW
 QJW3VWjRHiMFpSQvlF9gcY0D+2IYup7BkVZQ2upkPfXWA3WqyMtL8tfyHVFJjUEP
 xdUtPfSlO94KookKfx2myr/HNgMemBH+/7xPpRn/PDqIVtoUFJeoCaGgMN35Zz2D
 FmGdlTFrS+g8lNlLP83Z0Q+gw7Zow==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021077.outbound.protection.outlook.com [52.101.57.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49dbrf246s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 06:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7/xgnw8AovBzOhR3ZS6bDyDJhKQDqTb7oxOzBy+yWsGHbbs28BDnpz1oLHtgaNjvg/EtOpHDBZykHORbZYuHNM6H+r+cJEx1xI0s+NaFiOFN+eyGEnka5PY8Dp98Y8F1qBHPNcMaXX4P+5XdGe15aOyubjl/8ndMk83aJZbCb+XZuh1NjeTvAwNo2Revs5bqad9UJJCpxlC+jaLAhrmHZYWBsee254jJP3xivBKwyC41S0lML1qQ8mSGodgJs949xphe0fsVkysky+hWwqDVGuozqaRNEYFzmlZ6wS1waJD9gqjr3UA8KQJS35T0C7X0h7v5HibIHTDABH3GDVlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRStolNviiCrj53mWYIw3PJHItsmrZiK7+NuIeAy5lo=;
 b=UYquzZX1wpIMYSehrCa1RXUQU6PErS7z7t7+wljwIxB2X3+mV3xJL8UYvfGUtBCzrZCkEZmRskndJtDiBMB+hg4mqkSieRV0lyeEBvQAg5xtSBrd/dlatewtJl9yET/oG4Hc0sJ9y0NnqDG2PfnMcEuuCb2WdTjIz4i6nkqSzdWrtIq7NentTxpCATzKi/nmb2jFwPLioNbeWgq3n/b6jOAmdb1WOCPnTDS22tmaWPoHo77eUPVxQaimB9DZnUaRLZVFawnOUFs4zc46AokUAbeBKnlVrx397kyMxvzjBFHIsdQWaTkfeCmMpl3a0IyEzBgMuOcIDTV9pEoUicjvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRStolNviiCrj53mWYIw3PJHItsmrZiK7+NuIeAy5lo=;
 b=ZMJY2j7a2I/XxBPzH0xnIdFn+NSFATqUIdSSs95EGaz5Qep2RByn+zXIjuzUw+701m4hdHcsECwnUr3s43NnKqZpQGp+S9IRNQZ4ftV95wlkpAiGm2azrzIOtcI8yfCWybHobnGF3V0tNQrS+1hZO1wSKByc34N7s7aEQ1t7WGkEPf5ZPmQ6Cs6a56CdPwfuKBBe3gQG9TtjWZZ6e98jlWYzoWx7XxdDFSF2FpxA0AsZ1AEXyuT/v/gSzM3ew3NMutJQTmziSolNPJ/LyFpuYO3DtM97ce/c6Ouwte995Ke4TPFZQC3i9jnHt/auhkrw2CJNz20UWkYfUIfreUpsDw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7778.namprd02.prod.outlook.com (2603:10b6:303:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 13:49:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 13:49:06 +0000
Message-ID: <70ff12c0-9ed7-4c19-a7cb-d14a5176d3f7@nutanix.com>
Date: Fri, 26 Sep 2025 14:49:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host and
 -cpu max
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: imammedo@redhat.com, philmd@linaro.org, jdenemar@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
 <87wm5lo37q.fsf@pond.sub.org> <aNaJl3J5dZEt6n4_@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aNaJl3J5dZEt6n4_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: f71f9063-373d-4117-c3c5-08ddfd0375db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alhXa2MzZGx6bFN6cGNidmlvb1FUZUFKektTdk9XQ05QZ3Z2MTN5OFIrd1JV?=
 =?utf-8?B?WXU0MzVqdHdUeHFDbUFsVjNjTFhmdjBPQVkySjhsUThYUndzVU5DTzFzTm05?=
 =?utf-8?B?eW5wSzJ3MThYeFlhbDl5cnZxanFVOS84dllqbmF1UTVKSXhIUmhQWi9SN1JO?=
 =?utf-8?B?ZGt0UkNLRzJrZ2hNRVZ2TTg4dUZ1bVJhWjlFSzc3QjZxQkNuQ2l5R2EvV0FF?=
 =?utf-8?B?K2p6SThQZzQzejFHTEVMZU1RMk5Uc1ovWGk4WGlIalBmNCtPSmhXOVpxdE16?=
 =?utf-8?B?WlNFMjA3UjVYZ0JoT1JSZ1JPY3UzVFdBVHBxYzh0eUtVMHQzNFc5ZWdCbHBZ?=
 =?utf-8?B?QzV1UjJmSkozM1I4ZHAyRFFKdnVScWlxRWU0RUZ3SGxMTVFwRmFSVTBaVmZm?=
 =?utf-8?B?N1dMTGNuSXJxRlUrWHB3Nnk5NkZyWjJFb3ZkcmhkVklwckd6bi81MWZ5WE0w?=
 =?utf-8?B?dGtaK2pGWFlUT1ZsaU1qdll6ZXprWEFnOVRrR3d0bEtUT3h0WDdaRFZRSTUz?=
 =?utf-8?B?akE1WlY3bVVzeWNNTmdGUFk4dFo0R3VxdjVZdjQ3TVNlM2Y4M2JhbE5RdXp3?=
 =?utf-8?B?SEJVejd5QnkrZU1WYS9VVXFaQ2VtR0ExYmQ1NEVCV1A3OU8zVjVHa2tuL0dZ?=
 =?utf-8?B?bFBFZ29DQWtiaWlTNzcyN2krR29GMEtnRVFOUDFaWjAxWmFlV1V1NFV3bnN0?=
 =?utf-8?B?bkJ2UVhLazhvaGVTY3ZQNlF3U1lwcWZHbW5IV1hVQjJLV1dudmdERWdvZXVX?=
 =?utf-8?B?WUpoQm4yOGVpNzR5NVNkNG1oOTcwdGRqdDNNQzFSODQxdkJYTVoxQUxlNytX?=
 =?utf-8?B?SkZHczFxc2QyNzFhNW5RUUdGaUFVZ2QzVHdsU01YRmlDaGRteUhqYWdOQVlU?=
 =?utf-8?B?ckhyTXlPS0hDUUJtbkVzcHpMemV6dnFtMTA0b3lGLzkzZTBkUmhFTVhOcEVh?=
 =?utf-8?B?NCtQVGgyclBxVU1yMmtMd1lmRlk0aThoVXNRRkt1SGo5dStqMUNtb0o1c0hs?=
 =?utf-8?B?V2FHd2J1bkh3VnBVZDhEaVBTRHZxNG1raXpyNzNoV2pUK2VmNWQ4QnQ1ZW9i?=
 =?utf-8?B?N1BuUGJ4SFNQS295MmhKeTMzc2lYY0J5cUl1R051dFQ0VWxob3dHWWdRajVo?=
 =?utf-8?B?SXV3MnVxZ2wvS005b3N1RmVMK1JycGp6N3ZuSFI0K3E0Z01OQ1ZiKzlZUUow?=
 =?utf-8?B?MjRKNlQ1emRlZTN6dWQreGtDVTVUajV6Vng5RUlaMkVGVmF4NEh3OGp4cThI?=
 =?utf-8?B?bXVKdHlPcjVCU0tiRVpMUkZndEpIejROU1NBZHkrS0NVQnpUeFVlU2pWRGFC?=
 =?utf-8?B?WGVZaG9RUlpGK0p5UmZEckJBbkFpWUR4QURZVjgyKzRuYy9XYzM5NVFTd3Vn?=
 =?utf-8?B?dDlueDR1SjFGNXhieThObFNwc2xyd3BzQUR2RE8xdkxLYVZXbnNkajdGT1pL?=
 =?utf-8?B?ZWNVUkZHeG01U09PN0ZUMnJOdFJpbjArdVg5d3doMXFvTEQ3eTVGbkhRbkFF?=
 =?utf-8?B?bm1oRkRid1llb0paTGVWK0ZqMkNpcjNlSk1nMGZucDhwSnhNcWRhQmlqT1d6?=
 =?utf-8?B?cWg0clNhQUo1K0pKblJYYmJYbmlhVDBsL2xsbENBd0tCSzN2WTExNmlZbmZ6?=
 =?utf-8?B?dG5ydEdIV2wyazBDMUpIQ2JIbFNyejhOc2RTbkZPaU5PZ0NtaVEyVWdqTmFw?=
 =?utf-8?B?aEc2OHhlVDVVVVBsVmdnUXVMUFZwY3c4Z3JZa0p3SWg0MWtSc25QRFRkb0p0?=
 =?utf-8?B?ekxSTzYwcEtsNTZmN3RENGdRNEd1YmwrWG5IYjFjMUdDNVJvNjF2NHBXeGVm?=
 =?utf-8?B?UEJ2bDUrcWVPc1RPc1pOdzhSRXZUaHl4OG96NVM1SWVTVnQ5MXVicm5qOVlY?=
 =?utf-8?B?V1JwYllYdGx2QnZSc0VucU96RVhkZHJmT1V0SmowQ282R0phTU4wUk1LbWNG?=
 =?utf-8?Q?uC9BunqLeEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JxMHJPeEhsSVNOQVlWRVBodDBOdndSdU45NWMyTEVrblNtcGRKYTFtUzJR?=
 =?utf-8?B?bHZqT2g3dW1rQkxzTXBQaVNNMTRIYTZBdXBLTEthcWx3aExsc2lodW5ZZW9Q?=
 =?utf-8?B?aFlvclJUL1U0K0l6UHc4VGt3U1RTWEhsZVVmSGtGcGs2V2tWanJwNXk1OHls?=
 =?utf-8?B?TFpROGFUbTZ4dy9XMVdiclgwYTY0ZHFyRDNVbFNjS2hZM3YzaVN0cXpZc0ZV?=
 =?utf-8?B?eVU3bXVOZXNiL1FINFJ3Mld6V0NMTGFKeC9uY0g1WEp6UzZKK3MwdG5qenZV?=
 =?utf-8?B?UGl0bmNTNk1vYW9UMjhXTm5PcGozL0VvTVE2dllWanVCYVU4c052eFBhSXdu?=
 =?utf-8?B?a3c0S213aG0zbVNPZXFFOUpWeDVvcmlFdytEMXNXRENKSzcrc1VhM05vL3Jm?=
 =?utf-8?B?MzRHODhabzNjQ2srUkhUMDdkcFZ2MDBKNTVTWlBtOGIySEIzSyt3Tjh5VGNr?=
 =?utf-8?B?K0NPcXk3NEhJc0hxckRSRE5GUkREWHdMdzFjcWszSzlqRXlkSlp0UmxEZ3g4?=
 =?utf-8?B?OXo0K1Z2ZUdodzFNQW81OEYwVW45OEUxQU85bmJiTHkrdVRyVFhPQkwxL2Z6?=
 =?utf-8?B?WjFJNHN0L0IwWGVLZmNxSkVNMVJMSlVvbGovRm5BQ0NJOU5jbXFJOGEycFh0?=
 =?utf-8?B?WHpXelFiWS9ob1c4TStjektUUVhGQVNmakppOTJObUdVTStKTFM1dXBnYzFr?=
 =?utf-8?B?WklGRzlQNVNDdDJGTUdGbTVJd2hkRmlMUW9yMFNiYTZyWmlCQXNKd05LQXhL?=
 =?utf-8?B?ZHEzMDc2dmFlcC93VUxlU2VORXVKSml6YS9qYk1OUEJiWFpncXk0SEIyOEpE?=
 =?utf-8?B?MnBwVytKTmVKZ0taZHpKMU1XL29sWWtJMys1SVdESFpPUXNHUmZBeUFVMUdF?=
 =?utf-8?B?R0dRL2p5TWFvbzNGMG80eG1RdGt6L2Ribm1OeVh5bnlKLzVQaTQwS01WRXEv?=
 =?utf-8?B?dG5sUVpJNjFTTm0zKzU5V3d6aEx4TTh5UGUxZDJwdG5iejVmS2o3WWdLbHZj?=
 =?utf-8?B?VUtndWgrRlh6MW5meFNLK2hxSUIrMEpkbnpWeGFXcEx4WXJuWi9uWFBaMXAw?=
 =?utf-8?B?TzRWTzZiZEpiN0kxdlUzdUMyUm9hTVZmMmhYRDB3MHpBYnRxWEJpWGpmTWZL?=
 =?utf-8?B?bzBBZGE4U0dYaE5sOEhjWURFMG5yWUJjc2tHT3NDTkl2NU1aR0VGK28zNFlM?=
 =?utf-8?B?aWpWcitsNlN3bHZ5NXIwYy81clI1Y0o4allnbHd2OXM5Nmdhd3g5bzFxbGsz?=
 =?utf-8?B?blBaWWV6TnFNRFhvR1ZwWVJXYjB6UmRGWUczbXkzSkZQUnZVOFRUaFUxVGV3?=
 =?utf-8?B?dk1hU3ZhVUJzamt3YVdRYlQrTEowQ2tzVG8xWjZ0NDlFTjRWemRDNktXcVh1?=
 =?utf-8?B?azI5Mi83R0QzQklNeUFhbEVqQ1A3a1R6NTdmd0ZWbEVGckZtNjlQay9QSXdQ?=
 =?utf-8?B?VS9NaEVKb0oxWnBZL0RVcUZubmxsVDVwS1BSSEc3eW5sZUZ5U096NGJnaDRm?=
 =?utf-8?B?azlTSDUxYmFpQnlHK2kvejFnOC93NUF6U0tiRkxUajhEOTdOaEtqTTc3ZE5j?=
 =?utf-8?B?b290RTJha2diZkkxZ09OZmE5OUs4V3R2VTNrcXk2T1JXWDkvdU41RUdpYkE1?=
 =?utf-8?B?bndFTXpHM2Q3Z2RudmcwcTc4VG1oZUlnN29LLzgrc2pENXFCTVZodjRtOWtL?=
 =?utf-8?B?NktZZjZrQXVNNkZRMnVsbjRGY0RIcitSbGVyK2s5UXA4bFlMN1NqMkRucUtG?=
 =?utf-8?B?aHZOdDUzT2NiT0V1YTRZL3JVQjZ6VnB0YmRXZzFOVk9RSGF4ck01djkvdU5w?=
 =?utf-8?B?MlJUN2Fqb3JFaW1Ba0Y3Zzg5NURTWDBTSmxYZFVqVExJWjlIakhJVXpQV0Mv?=
 =?utf-8?B?aWV2cGMzYno1UTNxVmNIOXorR1JrbENqZE80Y056dDRwZ2dSRndxazVCMXgz?=
 =?utf-8?B?SWtCV3V3ekZ2akpzQTNaWWVPaVl4K0dVNm1hemIyb3RKVzBxZ0NLM3JXY2Rl?=
 =?utf-8?B?eVlWNWRtTnAxOWlaTDRJZWJJdU1oZVh0M1U0OThVMm5rTExqWmMwWnhsbHJ6?=
 =?utf-8?B?QVdQMTUzbHNob2JPYlZrUitsL3ZzZDZWTkxvSkNlZHU1QU1zRko3OThEWUhp?=
 =?utf-8?B?M3QrNUJ4RTBQeVV5dGtjK0w0RGpVYUZQaFErQzc4WjVxblRMRklYL1k4bXQr?=
 =?utf-8?B?NGVyQi80L3p6VWdkTWY2SkdGdHh0Si96ckVUTHpvWnhrcjFRL21Kak90UWRW?=
 =?utf-8?B?ZHBGcWRaemY4WlViL1luaFltSHl3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f9063-373d-4117-c3c5-08ddfd0375db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:49:06.3107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20TGFVKnwzxKJrmHYA4E92mAm15DVjHCbwY8kWhIbhfHBM71ge7TiWBdQclnL/+q7YN6r++b8UlmMv3gzKoajyrcQJwfDA12WqhPBcWhMRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7778
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyNyBTYWx0ZWRfX58EhJQTMsGCd
 xjzDZtDCr+MvLj5x1TDj8xUy1pGWz53nDRSGL2O81oFr/xr6wihHE2fvyQoD56gWK/+/RcbDZdY
 iIMmpm/RC5MPbq9si1v/cdRkOlDBjQO00QmmCQvK2lfJAjGa0WXsTp9XzlIHUsWxWwQcfh6A53w
 t6etcOqscd//vZY+PadiY+pIl7a44lVz0Do+ODjJz3qi0kRiukGBvA/ur0W4h57gYkfeveDfYxE
 rWAOYR9DDT3enHHh9nbvSN8mvgp3qVI/+ZkO7SzZupQCC1hrVwla/5MnJC3rRSxlByaTnWTdrnW
 NC9I9Tx5DNeU+pGOqZlgzdyZhJ1lUk5oUOErh2Duv3jno2nuvmwDD17KTavesBirbVt4+Wmiphi
 JF0yU4m2/jZGBgPtOjG0RboKB2liRQ==
X-Proofpoint-ORIG-GUID: 3vp0OVLephxnrVPLBuspbsjSBy5iTCnv
X-Proofpoint-GUID: 3vp0OVLephxnrVPLBuspbsjSBy5iTCnv
X-Authority-Analysis: v=2.4 cv=aKj9aL9m c=1 sm=1 tr=0 ts=68d699d5 cx=c_pps
 a=BLvYkjn5u0YClySNKAgoiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=6JxS3F3QDc9GM06VSIMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/09/2025 13:39, Daniel P. Berrangé wrote:

> On Fri, Sep 26, 2025 at 01:36:25PM +0200, Markus Armbruster wrote:
>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>
>>> Following recent discussions on the mailing list, it has been decided
>>> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
>>> it is preferable to disallow them and use the existing valid_cpu_types
>>> validation logic so that an error is returned to the user instead.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   hw/i386/isapc.c | 27 ---------------------------
>>>   1 file changed, 27 deletions(-)
>>>
>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>> index 44f4a44672..6c35a397df 100644
>>> --- a/hw/i386/isapc.c
>>> +++ b/hw/i386/isapc.c
>>> @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
>>>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>       int i;
>>>   
>>> -    /*
>>> -     * There is a small chance that someone unintentionally passes "-cpu max"
>>> -     * for the isapc machine, which will provide a much more modern 32-bit
>>> -     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
>>> -     * been specified, choose the "best" 32-bit cpu possible which we consider
>>> -     * be the pentium3 (deliberately choosing an Intel CPU given that the
>>> -     * default 486 CPU for the isapc machine is also an Intel CPU).
>>> -     */
>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>> -        warn_report("-cpu max is invalid for isapc machine, using pentium3");
>>> -    }
>>> -
>>> -    /*
>>> -     * Similarly if someone unintentionally passes "-cpu host" for the isapc
>>> -     * machine then display a warning and also switch to the "best" 32-bit
>>> -     * cpu possible which we consider to be the pentium3. This is because any
>>> -     * host CPU will already be modern than this, but it also ensures any
>>> -     * newer CPU flags/features are filtered out for older guests.
>>> -     */
>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>> -        warn_report("-cpu host is invalid for isapc machine, using pentium3");
>>> -    }
>>> -
>>>       if (machine->ram_size > 3.5 * GiB) {
>>>           error_report("Too much memory for this machine: %" PRId64 " MiB, "
>>>                        "maximum 3584 MiB", machine->ram_size / MiB);
>>> @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
>>>           X86_CPU_TYPE_NAME("pentium2"),
>>>           X86_CPU_TYPE_NAME("pentium3"),
>>>           X86_CPU_TYPE_NAME("qemu32"),
>>> -        X86_CPU_TYPE_NAME("max"),
>>> -        X86_CPU_TYPE_NAME("host"),
>>>           NULL
>>>       };
>>>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>
>> This reverts the "smart" part of recent
>>
>> commit e1e2909f8e74051a34a044940f90d4650b6e784a
>> Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Date:   Thu Aug 28 12:09:44 2025 +0100
>>
>>      hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
>>      
>>      The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>      possible to specify any CPU via -cpu on the command line, it makes no
>>      sense to allow modern 64-bit CPUs to be used.
>>      
>>      Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>      handle the case where if a user inadvertently uses either -cpu max or
>>      -cpu host then the "best" 32-bit CPU is used (in this case the pentium3).
> 
> What is written here made sense from the POV of use of isapc with
> qemu-system-x86_64, but in qemu-system-i686, both 'max' and 'host'
> where already 32-bit CPUs IIUC. Both this original patch and
> the new patch block them from being used in qemu-system-i686
> which feels wrong given the justification above.

I tried stepping through with -cpu host/-cpu max on qemu-system-i386 and 
it's a bit confusing: I think we end up with some kind of custom AMD 
vendor CPU but with LM disabled. I can't easily see a way to understand 
what features are currently enabled?

I must admit I'm struggling to see the usefulness of -cpu host/-cpu max 
for isapc given that older OSs can be quite picky when it comes to hardware.


ATB,

Mark.


