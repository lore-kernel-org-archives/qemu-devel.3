Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3FBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPix-0007zR-9V; Mon, 29 Jul 2024 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sYPiq-0007od-Gu
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:43:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sYPik-0003dB-OE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:43:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TBFVJM002374;
 Mon, 29 Jul 2024 05:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mqolJ2IWn16dqTbsyahK/Vt1qSegLP6o33pgC70mH
 Qo=; b=hxkVAbaErEfdmBxQt+6K718qYwSCNoAW4rOpyVNdqe3OPI6OEnzxmQy+b
 x5epIABBznkjODYCN+Njqvvgn3BAzITPaL8XbGZfft/FdEz6saN6relRVUmXCyg5
 BVik9I994qu5tF2J4UcE+ZtaccHjV4LQnkb4GAN56gqlPnWaGrCdB30MdPXLUFrP
 3NblkhgJDJKuXl2IgE6k70OhGKClukeD5zocOutjdY28VgtZYT573pcixSWkR33i
 lQucTZxVJoznCrNULLcJtR/BiibolUmWnTP9YaX5iL34GDBWqHvQyUzGxxYcbkU0
 HoiK2GSHja41HFSyqS7krZ4P4UwWw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40n0evb4ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 05:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPeoJvyVEBcGQhez0mB/A+yKGnPggmbfpfAWLK1noPRkholRdKfAq2k/qwl/WfEZkk5d+F6w82FXi6n4dbt26715UJ5ie5EAhs18HXg5meXfBBFA+4MggR6/3KZqWYmt3Sa8B6iQ+x+NNAlLU8wDWq41JP1cAKo0sanRCleULiqqKkcu6RAersn+2KOKPul5sYY2pagoe9Dm+QsHO/Vkq7f3eThHiHwHmU1/fYrFRbJb3gOQaW3eC1PHwrHUiFJ9689VrrFog3clNEOo7I9FN4uJDRvtMPv/ExrlidztBVwXmf9R60UR0y9dJl41P2WK8HexGrp0Ppnq2OanfYlbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqolJ2IWn16dqTbsyahK/Vt1qSegLP6o33pgC70mHQo=;
 b=Ju9stWjNE6MTGj0ldHw1v5wbx2kn6i4lZWHP734SiVqWr3f+XnnG4LAq4SuPbedz2cHVjbH3O4h5UYs8rNfDLq7fv7yBB7v5HbFYUIJjndx9/pBMPPcbZMTashPk1BWKctXdAJZPm87XesLQcelFRfC1b/mpLLtkVXpT3rt7gWCb9rZcXrkGxVGsDeMQ7qwMV4Zrog9m+6QwB37Jt30n3yA2Kl9q736MTHYOCG3q122rIA495L0wj1akvyIPZ/hiDnfwBLnzEkOIEumhKbvzrLynFKnAGkHCZwXFaDouz2AtXLdR0h9WITPWAGs9b7DhkaaRW0hCGaQUgDA7enh3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqolJ2IWn16dqTbsyahK/Vt1qSegLP6o33pgC70mHQo=;
 b=Cpw6YBDokWI4JliRl5jxWsLY39BB/nVYbRDxonJuUxNs2G0nQpFTQqEY++Em/R/KRwbFWui5N8a3I7y2a1WKaBg+i1zzth1vHDsMbtNUvN4mqpeBbJt8n2m+AzvAWH4VVkEBU2aZwpbRp611HMEu9rwV1BANZ23TaF3nNgCw04c2CFb1dWnMO0inIWT9n/v9rnJjLY9TqjiGlIRinJ5Ms1arPm6kcynTr6yWBbwJwt74YZL8GqhQFViDnksIJ/g9cl1GhiCbfh7WyAuIurY9jyZACg9kDWouBwHAOwKZphpjRGJpky++paZpzQljxEsFxe6+Bg5tdEAzR0OkF05T4w==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by PH0PR02MB9307.namprd02.prod.outlook.com (2603:10b6:510:286::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 12:43:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:43:01 +0000
Message-ID: <96caae6c-5263-4b66-ab72-65f34dc63c17@nutanix.com>
Date: Mon, 29 Jul 2024 19:42:39 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, bob.ball@nutanix.com,
 prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com> <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
 <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|PH0PR02MB9307:EE_
X-MS-Office365-Filtering-Correlation-Id: 624655b1-0554-45e0-de17-08dcafcbfb66
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWJ2RGNvbk8wRUZ6Q0lqcld0OGVWKzBSMjJwTTh6WG9iQW44Z1dodnYrUHZy?=
 =?utf-8?B?T3BmR2lSSWhaZG1vRnc4WTcxTWFpNUt4WUFiMHk2K3N0MER4SkhlKzA4RXJC?=
 =?utf-8?B?YjZhRzY5QWw2bzFsbkFRK2hOVldkdVRxczkvV3N0VTBwVnNSblZiUjMwWEZU?=
 =?utf-8?B?US93Z21oTUZpNDVKcDA5YmhUY1ZWWlIwYnVzelFTWUhKeTIzbFR6VnExcE9x?=
 =?utf-8?B?MVdLa05zSElaamR0VERrOUtsem91cUI5NWpRMTNDekp4UUVsTHZ4Y0dsOTZh?=
 =?utf-8?B?OFRJZkFzcG5ISHhjcmgvMkF0b2pQT3JjRWNSVHlkSDhPRHdOS2g1N2R1aWwz?=
 =?utf-8?B?VTZ4cHBVR1orMGV0bXNLKzVxSld4ZjBxTDNxbUV2bUxSamVwalZaQkdUZitU?=
 =?utf-8?B?b016OGlKMW5OUFVvWDRoSDg1VTVKN0ZjSWVJVlhmZ0Mvd2kyTlNKYXZaS0gv?=
 =?utf-8?B?V2o0M3FwZmtJZ1dZTnZieUxCVXJOUHZHaWxrZmMzVmowQ3REZzBOeGFDRTQw?=
 =?utf-8?B?RE9DSTVXWk9KU2ltVFNrbWJWbVVvZWRtMUo5Sll5S2h3UWFJQlVjZlVRTzM0?=
 =?utf-8?B?bUJDblJVcTZBdnVWdFZ4TTREVnlpcUZOTU92NEFBYkU4OWVWTUJrSDVIU0hk?=
 =?utf-8?B?M2FFMldvK1BqUWMyQzhxTEdmeXFEUlEzTEYxVWNDNmxvTHdmOU56RlBWVER5?=
 =?utf-8?B?eTJmTkgydGRGWk5WckNRMERkbHdLTVhtNUhZNXJaTGJEZHBOSWNVeW94T0sw?=
 =?utf-8?B?V2dhbE9nbUxjMFZXZEwrUjdRYkJJdjhBYk9xcDdpUVdTRnlQUFJlZTNsYWtz?=
 =?utf-8?B?cWVHcGRUMzJnZStVYTIzdWRHdlVYTEFiZEwxczhMeUg5YjFpYkNZZllabCts?=
 =?utf-8?B?dEp6VlN0aEJUL1EwZEthbnNsZmZMN0hiMjJYT0ljU3QyRUY4WFdoVHYxK1VU?=
 =?utf-8?B?ZXlVZ2ltK1RKSnluZmRsRytQK05UL1QyS2Y1SG44SXA0OHo5MXdsN2Jpbk5Y?=
 =?utf-8?B?MHExdDIyUGNjdkNua0dQeFAxanRpV1MyQ1dRU3NLbFg2cUFDNTZ5azRGM3BQ?=
 =?utf-8?B?OS80dTJXN3lIWnBpV1lSM2lTWTFyRENDTkNpN3ZGYVYvQ250NVBocEpWL2dD?=
 =?utf-8?B?d0hmK3c3SzI5dmc0SldYZVlyNUhTTmhyQWZaSTU1bnhlMEdRRGQwS21IMnk3?=
 =?utf-8?B?RVZhY0NDRllWb2REKzk1RldJQUZtU1M3S3Y4bUxUOTVUb2FxR0JtV3B0eHN5?=
 =?utf-8?B?T2YyZFdCQXFqMzMvTmhDNU1pOFh2SWltYm1VVmRJVldLYm9VYWdnUnNSNTgz?=
 =?utf-8?B?NkREaXNnaTNUeWJHYVRqRWJKalBVT2pJTnZGTFk1M0o2VVhxL3ozK0t2cFli?=
 =?utf-8?B?SzBGSVgyT2lWM1BSd09peXpWa1JMNDl5RGlQSmlPYjRmcWhaR0JoZEh5K2sv?=
 =?utf-8?B?bUZUTDR3eDd6VElITGFxUkxaV1ZpSjNJSXJ3RzdEb200ZVo1T1BlWlBKRS9h?=
 =?utf-8?B?UjJXb1Z2allCYlJ2aGhmM05jUm92RTV2WEpFa0JmZjVkdnVNdXMraUhVamlx?=
 =?utf-8?B?QTZqZGRtSCtJd1djb2FWUm41WXYyMExITlcwY05PL0EwVU43b2htVDd5cnBz?=
 =?utf-8?B?TXpta3JvNkFtcmloQXRJY1BJTkZVVXMzZW9YdldJS2k4YURzSE5lc1AwS0E5?=
 =?utf-8?B?d3d1bmNtazdKc2diZGNKb0VHN0tMVDdJMkNqeXpIc3hLbzFGSDBZRkluTEhs?=
 =?utf-8?B?eDdVV2hYWjRDUjA2TzdiV2pmWjJwR01hOHppTGlTNHFlL2tGVG0zbVJnYUR1?=
 =?utf-8?B?cFJaL3U1VHVmM1RFNnlNUlczTEFxZHVscVkvUzdYUWdiQWdmQjc5Zk41MFJW?=
 =?utf-8?B?NWJoZ0pOQUFpZ0xHclEzSExaSTNGK0VKVkQ5c3ZRMVc5RHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGE1OTlNRUtVSGVsRlRuVWMyYVQyaHN3UTZqNmpURm9wemU4V3JXeG1peU9r?=
 =?utf-8?B?OFdIVkRiTmJDWlFFU3orSVB2dWNoaWJud2VoZjJBaWtQSFNiRlJVZ1ZxTTV2?=
 =?utf-8?B?dk1kdERUSzAxRjY3cWhqdWkxTER5cW40TWpQbTU5d3pyNGwycEpJNVkzMkxp?=
 =?utf-8?B?NFJRZ1ZrTFByUmxVWnpjWlFqMXB1NGZVU0JvYU5TR2dhZml6VHJrbFlva3lV?=
 =?utf-8?B?QUEvME1QUitxSmsrL2I1RC82WE84OC95dWM5WHZBUHFTSWlSSlAxVDVSa3p3?=
 =?utf-8?B?VFUwTXpwQXg3SXljKy9sdTEvT2ovSVpyL0Z5bjZKTW96a0c5a2QwaWxYR3pt?=
 =?utf-8?B?NGIvQmpGamFjVlhoUjhCOWtzM3ZVanB4ZGlXbm1GdmtjejlxUU9vdVRKOFdE?=
 =?utf-8?B?YzJwTysvZlMwUTY2T3JwdEJoVlZrZEx4Vy8veUdpT3dRRjh2bDBtRmU5OEpN?=
 =?utf-8?B?R29MS2lQSTdnaXpkT1FLeVN3SVhkRUhNQjFUNUEyQ3pyYmlpSXdKRlhyNjZQ?=
 =?utf-8?B?YUI2N0R3ZnVqajBDTks3ZGJHSXVoajJSSjlvRlo4b2p5bWVnaW0zeUVnZVlj?=
 =?utf-8?B?dUxyY3NFRXkxazhvRnNsUnlidU1ZbkxWTXVQeWszb3pTNkI3K1JnL2xhZFRk?=
 =?utf-8?B?WWNmNG1wdzZvcUd1T2tzeTl1SjZsUVpMTU1aeVM5WGJhbUxaQ01POG9JZ2NY?=
 =?utf-8?B?RTFXRjBPZ2hoS1dHaE9wZkRpcDB5S2x2cXBmSy9Obm5qaDh5QjJ0VERVU1hF?=
 =?utf-8?B?V3V3bDhrbHNZVU9PbnJ0UEhxTkVPRGFibGd3ZkkvU3hkSEFNSGlpb2tnSkZK?=
 =?utf-8?B?RnNxQkZpbWpmaCt2cUJKL2JOdGVvdGpDSkRFNFBwRTZ2S3dKc3ZWMTExM2E0?=
 =?utf-8?B?VEJhaUo1eWg3bmNOT0V0eUpaM3M4VGpTUlYyMTNlanpXZjh6ZTZzUGFlK1li?=
 =?utf-8?B?VlFaT3NpdVRLM0JtT0YxVEd0VXdQL0t6YjBDSHg0TmdodklzQkRtMHhpVUV6?=
 =?utf-8?B?eGZYamdyOUUzOXppR3dBdERDUVJiRlRnazUxRy90ckI5NWN6OHliYTNseVBI?=
 =?utf-8?B?Z000RXYzVWt1YXVReFpWL2N1L1M2TkFVV3Z1SndBNHdKMytiekNoTXF2WE9E?=
 =?utf-8?B?U0xpVng2RmlBSXIxZkJKSDh3YzdtWUdld1pxVVJIb3NwRE5HZU9UTmRjbXZP?=
 =?utf-8?B?K0xTK212WTBsNnhqRW9PT0llS0haT01JVFZoS2Q1OVhwV2Y2UTdnNVhBOU5q?=
 =?utf-8?B?QWhiOG4zU2pPSTZZeHBTT00waHdkc0F5SVlxemdFK3RVSXMxbkZWUE0vVnNY?=
 =?utf-8?B?aWRWcTVQamhzblJEaC9OYXhZYVNZbUdVbDhramZOS2JpTUFwaW9PMFYwY25n?=
 =?utf-8?B?UldQV1NSYjlnOVdyYk4zNkV3bGtNbG1mNFhxTjNMNUl4bDNxTU1Bb3k0MitN?=
 =?utf-8?B?UWVWTm5FT09wd2Z1dXFFUHo3RVFVUE9IbUxYcmtVSHRlNVcyd25qeXdPY1VL?=
 =?utf-8?B?MXI4L2JBQUQwZWFJK1gwZ2dCK1MyVktFY3dnVkZEM1dPRzlLdEU3Qng1SGsv?=
 =?utf-8?B?eE05cFdvQlNlWXhRR1J2b2ZRcEFkSDhJTGRKRFRyYWZhT2R5bVJzc2Rkcm9F?=
 =?utf-8?B?SExIQk1OSFc3cktyTW5qSGNsL2NnelE1dWZrN3RnenRZb1FqWTZZRDBsUDFy?=
 =?utf-8?B?cTZmbGlNeVpKcTZpL3phOGFPZit2Y2tFT0V2MG5PWjc5LzZsR2I5STIvNEFJ?=
 =?utf-8?B?TGJaOXdXZDl4dE8zc24vQkNNa3JrTmdoMldKL1pHL3dwMHFRUHRJUlQ2RXVP?=
 =?utf-8?B?QzlkWnc4S0lNaVgxK2lXLzdiZmJTbFl0UFJvdFoxemJyN0IxdXZiMTl5bmhh?=
 =?utf-8?B?emV4R3d6eEQ5RDI1dlJJZmNtdmtKSUZkNytBalpUTHptNmhxay91bTJpTVNp?=
 =?utf-8?B?ZGxNZDVKRVdHdEswc0IyZ1dyZzNwSHFhY0VvQlF2Qm9mM1pPMVBLSkRaeEdF?=
 =?utf-8?B?cm9LVS9vMjM1aDNSanBOdWlOVmJCcDJwTzJ1S3pKVjVSOUhDYWdVOXAxRmx2?=
 =?utf-8?B?WVlPR3NJNzh5d04raHhQY2Y5K2VWUjhLciszYUdQTHQyUWxoL3hmdDNNdERG?=
 =?utf-8?B?bzMxSGJqTFg1SS92Zk5hZDZ4dE1SSmhTT2N2MHNsNlNuU00zcnczT0VLNG1L?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624655b1-0554-45e0-de17-08dcafcbfb66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:43:01.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLLUQ8QQyqU11EGc7lPbllk2H7c+C3YZ8tvIbjQwDmejCbxFUdg9jGfVhsun48jzeica/QPjQlLqEtQJx7W5Z2vz7tc76gsXlDBTZp1A+us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9307
X-Proofpoint-GUID: o72BviO19jKtFWgloBoBEbVpEZns_0b3
X-Proofpoint-ORIG-GUID: o72BviO19jKtFWgloBoBEbVpEZns_0b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 29/07/24 7:18 pm, Igor Mammedov wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Wed, 24 Jul 2024 23:00:13 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
>
>> Hi Igor,
>>
>> On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
>>> Date: Wed, 24 Jul 2024 14:54:32 +0200
>>> From: Igor Mammedov <imammedo@redhat.com>
>>> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
>>> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
>>>
>>> On Wed, 24 Jul 2024 12:13:28 +0100
>>> John Levon <john.levon@nutanix.com> wrote:
>>>    
>>>> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
>>>>    
>>>>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>>>>>> to 0xb by default and workaround windows issue.>
>>>>>>> This change adds a
>>>>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>>>>>> case extended CPU topology is not configured and behave as before otherwise.
>>>>>> repeating question
>>>>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
>>>>>> that supposed to have it?
>>>>> As i mentioned in earlier response. "Windows expects it only when we have
>>>>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
>>>>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
>>>>> to 0x20, so we starting seeing it with SapphireRapids."
>>>>>
>>>>> Windows does not expect 0x1f to be present for any CPU model. But if it is
>>>>> exposed to the guest, it expects non-zero values.
>>>> I think Igor is suggesting:
>>>>
>>>>   - leave x86_cpu_expand_features() alone completely
>>> yep, drop that if possible
>>>
>>>     
>>>>   - change the 0x1f handling to always report topology i.e. never report all
>>>>     zeroes
>>> Do this but only for CPU models that have this leaf per spec,
>>> to avoid live migration issues create a new version of CPU model,
>>> so it would apply only for new version. This way older versions
>>> and migration won't be affected.
>> So that in the future every new Intel CPU model will need to always
>> enable 0x1f. Sounds like an endless game. So my question is: at what
>> point is it ok to consider defaulting to always enable 0x1f and just
>> disable it for the old CPU model?
> I have suggested to enable 0x1f leaf excluding:
>     * existing cpu models (versions)
>     * cpu models that do not have this leaf in real world should
>       not have it in QEMU either.
>
> If cpu model already exists, you'd need a new version of cpu model to
> enable new leaf by default.
>
> For completely new cpu model, it could be enabled from the start.
> i.e. workflow for enabling that should be the same as with CPU features
> (or as you said 'endless game' of copying base model and making it look like
> should be according to spec,
> but that's the process we currently use for describing CPU models).

Igor my understanding was that there are two type of features one is 
real CPU feature, yes those makes sense in CPU models. But on other hand 
there are features which are emulated ones i.e. kvm-*, these make sense 
enabling regardless of any CPU model and we usually use machine types to 
enable these. Does not this features makes sense in 2nd category.


>   
>> Thanks,
>> Zhao
>>

Thanks

Manish Mishra


