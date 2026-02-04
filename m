Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA30E9537A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnab3-0000bW-D9; Wed, 04 Feb 2026 05:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaax-0000a9-AM
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:58:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaat-00024D-55
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:58:50 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145kUM33812661; Wed, 4 Feb 2026 02:58:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O6hymFtLqCiYWhLOAKVPiNfkbsWQBkcH5xzaIN9Fh
 io=; b=TmMegF/UcnAmdNdJSpk1RSIbEbvFE1pX1AFIfkS6joLhGTYOWivOMOa5r
 FPIJwcsNaVAucntAdxpcava/54x2+yeNsRpgSV65tkuldOOxgt6XJ+iP4nWtk1nZ
 GQlM0zYV2DHqCmWfx001hZvE4RJkc9ruIDQPHZ7FbsjZoaxckYkYmOPIGV//PA8Z
 PekgWT8Uqz9KbcErCv3cn2OYezhrwB/hxwbttBj3vqaKeykb5Q43ej+rcVUQvlUQ
 5uLBUYtbbSpaJIHHY1XPKcnhokXcwT/q52XiLlxpJCp+CCgElnHW/7/9s0/7WMjj
 O55gxNbHvOBr8J8niWv1yicklv2dA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022121.outbound.protection.outlook.com
 [40.107.200.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3nvva396-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 02:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUWfRJTP8NiTwTCgWWRN/8Pdush5SA6mRfMPtA1V3C36nrHF4ugUWH6AdoLaok1lrlphc9T6xoD6fZCT9ADWBMbUmeH3Tx7xKz7qleKTNEvX+Wce8ek9siMwZ4yPxOLMddhD5znyTmaggvv+yUJfbrSPjKNa7dY7qs2gUt9bC9wVAJwT4EH61XJ3fncsas5yGfECxVKrJsP/PVOR083GZcl2FL8z9oaazCKhGufNf7TQrSeNf5PmcxGtzIdQOqOBM2/FScg9z5dtfSkUblj1FZVjt3zFlY7GyX4d+kZQLSE01c9Bjg1VKss83+WS12UmYODoatwp+/xuzO77XP19YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6hymFtLqCiYWhLOAKVPiNfkbsWQBkcH5xzaIN9Fhio=;
 b=NMVfEkotVXwFknTliZKFm13ljkBPwzaU3cTnt+fL/3UQYK1vTpdLaf2AK1gu4YyjKaQxWPzMKSoEgSZKIyhcx4OBvLeclA80FEo5TJC4Kc3FgAScu7/reCd7xm1wNeiQKkQqRqOidmepvJG6Y52PDJ4gOJC4g/vyKh9LXxVJx7/ypgMVgf2GQZHJe/Msi5ERQ/ayAr4Cn4W6WD0r++RYc7ey/82UJXDwMb/41OIHmxm/yilvESzOUMIK/Sol/+/DLdw7K70TaY++Y9Mo6NCBJEM5ohRqdyunv7jYJrDKp0GHDTMa0pBsedFY+tQ9L5vvaSqQ3i3shMLQqKRSMJUFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6hymFtLqCiYWhLOAKVPiNfkbsWQBkcH5xzaIN9Fhio=;
 b=Su5FIKleKZr/XX+xbES8RmXK8aVAKN4TNQQR+H/d3/iGpAH6FPMOpCjBpTc7Z9/fOzzurlQeg8r0ERQQKC/Jcr3QeXOpWqV3F7fY87zaeoWZa1r2HyAOCR0lFf86ZcjfLlxfJ9NixbNQf2Ic1BNpRTuJMAwjpBU3TjKx/S5Bq0w0BJ+1TfcPyNsmy1OlcJG++mcghFVwnleK+cvKicwyhAvFIjXse3rQvjFdlch2/WE0TywymRVGRo9QPfixTrfs4I/86kNtZb8J+uXVXyIozisQro50cgRmMV8FJylXd7dS6aISSHV5OLTnweUCZel77V6zAodJ4p4/s/mRQox1kw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB9021.namprd02.prod.outlook.com (2603:10b6:8:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:58:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:58:39 +0000
Message-ID: <1d78a544-7204-4695-9fd3-fcde2fdbb7c9@nutanix.com>
Date: Wed, 4 Feb 2026 10:58:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/37] audio: introduce AudioMixengBackend
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-19-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2950fa16-ae5e-4764-e933-08de63dc5a95
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG11bGw1OEFUdzJrU2xUd2RUVWpZZU1BVjZLSTJCS3BUbjl6cFNoU2lLOUlk?=
 =?utf-8?B?d1YyRzFYN0JwY0g3anFJQXJxazMvT2xCZi9VQ2RuTHQvak8xVFFNTlFFenMv?=
 =?utf-8?B?MkREV2QybnNXRG9PY2lsL0JuY2xGMGZZTHZkTS94RUVFNmw2bHBtRnJqWkFV?=
 =?utf-8?B?N1g1c2IwT3l3YnFNZ0FkUW54VnFKMzZxVzdBTCtFNEJuQ2EyWmIzdWJWdVBO?=
 =?utf-8?B?bzBvdlZWZzkzb2NIckZrSkErbElZU3hXNHRaYzFOYWZ5V1VYSkJiclNxVXIy?=
 =?utf-8?B?dWV6R0tIbHprYU9YR1VuaDVJQWJXRHlzbDdsblpCL0wxVEw0TXlJSXBkQ0Nn?=
 =?utf-8?B?VXpBai82bjRlR2UyUHl6WlF4NHQzbnZLc0ZZRjlOUW8xMVoxNTFPRGcrZzJm?=
 =?utf-8?B?WkRwcHl1N0VFaEtOakRsUGJXT1FjdG1PQ1FpODJUdG1MRE4vejNzaXIyQk5H?=
 =?utf-8?B?NEhHZC9SWjI4bjQwZklqa1dVSnFmY083bGluYUNkVmRqaUlwdTlJcHBIaWJW?=
 =?utf-8?B?VWlDbWJyMkFueU5qK2JaaDJncmF3Q3ZkRHRrN21GMDVKbmNFbjRYNlo4dDFm?=
 =?utf-8?B?VWVTdzhyVjNHeGxCaG9JTHZXWDBsejVSRjYxWFRHcG05Y0RORE00VTg0NDJl?=
 =?utf-8?B?L2FvK2QwdHZuaHdLdTg1K0h5NXVxb0RpUVJWaXByd1dmRWZkb0tKRC81dzQ0?=
 =?utf-8?B?dXdDVmR5ajBSU2ZVRHNkYkdCZFdMK0V6Z25wL2tyS2ZMZTVLQmcyWTk2Mi81?=
 =?utf-8?B?NGFneE9TNVFMaStSR2JsSU53U3NkbFp2bG1na2E5UElPZTVvUHFRbmZRMFBK?=
 =?utf-8?B?RFFLc2N4aFNnRmFRMW1YZXlDejhvNzg2cGt6ZEcrbVorYkZpK3JLZnhhY1lE?=
 =?utf-8?B?c2JhU0l3Q2FHQ2FZL0ZUNVJIZlh3bmQrWEZScTVpRmk1Zjk1SWorNUFrb3I3?=
 =?utf-8?B?L1VPbTdQaWdjQ3dmM0JrQkc2b2Q4aERiaFNyQzl6WjN5aERheVh2eW9Rdkt6?=
 =?utf-8?B?aDd0UVJqajhGalJvanJGaWs5NytaNURFV2ltSTlYZEQ1bDc0dDZxMjNBZ2dv?=
 =?utf-8?B?OUl3T2dUR0ZzWWlxaXgra3FxMnlsOUh6V2hMRklURTNPS0xNRjdMdE1sZjBD?=
 =?utf-8?B?am1BSVA5WjVGWjFab3VHL2p4ZVkrNTVOWGRMNmxYOGNxZVZUMXBTcklzaFIv?=
 =?utf-8?B?WkJtbTRlbzBJZEo4cmRVNGw4ZzhaS0xCU1R1UHo3RUxyaW82K0NibHZjUlRP?=
 =?utf-8?B?M2lqenkydkNjbFp1c3VUUFhNeEJ3eGZKaDBiWlJpeGZqaTlRMmdTdCszNzA5?=
 =?utf-8?B?NmFiTmg0SFBTUjBmWjY0eE04cVVqekJ1ZWRGb3pEWFRLVUx0dnZXZy9vajM4?=
 =?utf-8?B?UjRaOFFEaGk1MlpWYVRwdUNtZDBvSFBGNkRETjMxZzNQazFBOUtFWlk5MHNs?=
 =?utf-8?B?dGhwWVlTS2p4ZkhKVWRxZHZIY3Z5QVVqaSs4OEZWQTlyZEo5eHk5T0RYK1Zj?=
 =?utf-8?B?QzVuN0dVeGUzN3ZTK0t5eTF3QlJHK0JFOEF3OXZ6dEE3N29RR1N5cmZLNGlm?=
 =?utf-8?B?KzhYWkdad0xZYmdZbWkvYkFVVUV5dmJVbFhONklZRm5WMU5hZVgrMHdVS3N6?=
 =?utf-8?B?NUJwSFpPSTZUV28wWHI2YTl4OTNWaU1TV2s1Rko4dHF2V2hBeUdtakY4Ym5V?=
 =?utf-8?B?ZWNNMXBpM3FVakU1RkJkU1B6czBCWFRpR3pLaXlmQVNnS0daZVNGMDJFMW44?=
 =?utf-8?B?ZWFXd3dGSnJMRDZrRWZuYnZXWVFxTEVRMHdncUhNWXV2bzhvUU44WnRncXZt?=
 =?utf-8?B?aXJCTEhlUldoT0N4VURsMTNvbXN2TktqYjN0cENseXJEQ1F4OEd1N1EwMDhu?=
 =?utf-8?B?ME9RMmVycC9TTWxONEZGMVFWcmlDcm83eEJvVS95MElBRUlUZThadmd6bVhB?=
 =?utf-8?B?SU8vSDd0TWhxaGt1WEd4dW9NT1gxTnozWHhmT25oaUQySlFaOFE5QnpSdmNG?=
 =?utf-8?B?QzlaTHhzNHQ4QXYreFBscWt4L0ZtTytTVWFEUzFpQTFGdUVRbEd3WDBQcjJa?=
 =?utf-8?B?OFRibmlIV3ZrcDMyVmROd0JSeEFHSTlzRHdPa0Rpd2QwN2VPNGFsRVlITm0z?=
 =?utf-8?Q?Q3C0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVrRTRxR3d4eEFuT3NvV1N4SktXekUweVVFNGxXQXlrcjlPTlhDTEVnUUdo?=
 =?utf-8?B?UFVmeTlLSmI1K3FlTzg3cFFlb3JoaXdSTXJOcFl6eDA0QWxXZDRoQVdwZmpw?=
 =?utf-8?B?N2puOXV2REYxQU4zTlpiQTdoUmFiVUJJV3lIUE1yUWdCZUdGRWEycDRCODZP?=
 =?utf-8?B?WHdCM3VLTWhGMjJLekZ1dUVoK2NKWWdZUWJNa3JhMS93UDhxUlNJVDhSL2xV?=
 =?utf-8?B?VjZWSUpuVW9iZHYrbVBFR1hneFdZYlVPVnc2UmVwN2k1c3RKcVdyTUNZUkZU?=
 =?utf-8?B?VXhSdXdpR0tyamR6dnVHbTg0OTYyZTdweG5xYzNEWDFxYU9CcGtlajlmZ3la?=
 =?utf-8?B?dnNuYXNoNWNzTk1wZGMyVWxyTFNpR0ZEUWxBUFZ0SmQ1Q1JKT3RjWjE3aGdU?=
 =?utf-8?B?N29LaTF3NG9pZFRGbjNONHBISjNFQjZtbzMzTGpSaVpadkRZeEYwWm50N0xP?=
 =?utf-8?B?eU9XelYxc2RuOFVYdi9mT0FHc29aVHR5MzR3cFo1cnZaNzZCWHpxbjdCTklC?=
 =?utf-8?B?QmJKU1RHREdPTlVDMDBrYk5nNm9xTzZnYzVPT08rRGg3Vk1UYmIyVWVwdWU4?=
 =?utf-8?B?QVNiQUptRTNJL3JyMzdXV0RRSm1KbmlZZThPeEtGY25EWUZ4V2VYeTl1Y1Ns?=
 =?utf-8?B?T3FIU3dCMmJGTFVGZWZwcDNmbW9VM0lUUEUwc2JYQU9HMXNWZnNGem1tVWhC?=
 =?utf-8?B?SjZ2ZDZnV2lUOUNCTE9Zb1NUeFpxT0F2aU9TcjR1NUl6Q09KUzRxQW5nTHAz?=
 =?utf-8?B?bXlWUHFaY2hsMUk3M0dwMWNnaFdiMXNsWVhtRzhQQ2REMHdGVWN4bWs4bzdn?=
 =?utf-8?B?cXM5OEE0NHVVYU40aUtvQkVFaElXb1dvTzRQUUhReWtqRmtaa25UVmpSbC84?=
 =?utf-8?B?TWt6clF0WGJwMndXOStXTzMyYnFLb1VIS21jVHF0bGNvS2VDSWFNc05DQU0y?=
 =?utf-8?B?TlZnZzNmYmxyMlBwbVo5UmtiQWxTeGhJM2piby8wWUtUeTJhYzM5MG1MZ3Rz?=
 =?utf-8?B?aFdkUUdqQlZWalNLZWQzQklOZGF1ZEViamxCdnE4VUU1R0pTSmtvcEQ5Vzhj?=
 =?utf-8?B?TEl6aFZFcXNCYkV4V2ttTGJQYU80V1M4QWVDeDhzdTVxZmpaS09yS3BTY3JL?=
 =?utf-8?B?YXF2T25Fc01FOUl1OFR3aDkxWjFHckowUTRocnpFaThmMDVBK25ZdDNtczVV?=
 =?utf-8?B?WGRkSzlPbU90ZUJXd2FsU1JPWkQwUGJodFJ5M3FXQmM2b2tqOTlaYkozR2pl?=
 =?utf-8?B?UlBDN1pISUhjaXNTMEZYeGhxelM4T09VN3hrbVNsMnFRdFArQnI3N3JSMEUw?=
 =?utf-8?B?YURKaEFFejUwK3J3VnhWc2Z5WGhHM3ZxZzBZRDdFZ0NvMHM0eEdpVXd1L2la?=
 =?utf-8?B?RnRxSFRia0dVUm1PeEFoVFlwMEszV2lCdUdiQzA1ODR4alk5aWVsMUE3Y0VH?=
 =?utf-8?B?aStrZ2Q2MmJSY2JJNEdXd0tsbDV4ZmoyajVTekljMUJPaDRKVGE4UU1MT3dL?=
 =?utf-8?B?cy9SdG56WEVGaG9zWDFGa2F2SU9RY2xZUHNFUFRCSkdKMVFOOFhJc0psdDVQ?=
 =?utf-8?B?VmhrZTRqQU9zcGFObGI5b3g3UWtJNGh0QjhidzhwdHc1Z2hjSmlhVGpBRThX?=
 =?utf-8?B?ZXN3UHhrMnp3ZEhscksvdVhqOFh5VTVIZFhqKzlsQ2k2a0VJcFZldmhWMzRl?=
 =?utf-8?B?ODZmSDkyT2tmWlZoRzV5SEo4by9HRUtveGdzKy9WWlM2OXVmdHJHSjErRzBB?=
 =?utf-8?B?eWtCeXVaWlB1WlJqMG5JSWxCUTVNNDVvbENMRFlrYnpGVzJMb3M4Y29RZVRD?=
 =?utf-8?B?bnVYTHpCUm92cng2a0xDLy96NHUwSnA1Rk56eXF4TVc1cEtQSlY0OUhXUS9o?=
 =?utf-8?B?YVdSWGVrQk5pcCtUWFNMNGpzTnp2Nnd4VDhJNVBLZVRiUUZwajZsMEk2Z3Bo?=
 =?utf-8?B?aFQxWEJQcG1aOEJmWFpiTXU0SHVwOW1Zc3RkRzJ0VnpjQWxnL3JCZ25NelZD?=
 =?utf-8?B?MzdJTGprUWNOR2NLdWJVVUpnQXlod3M2cmhMSytSR2xrS3JsMGZlQTNiTnhz?=
 =?utf-8?B?V1ZzcXpDcGIxRXJvQ3JCbk5ySG0vYlhweVhCblFKY0lMRnVlVW1JZHlVUWtL?=
 =?utf-8?B?VUVYV1BWT1UvOXFaUE1uZWJKQUw0N0RSWFpaWEpoWUdHTlZXL2VYL0JCZ2ZP?=
 =?utf-8?B?aGV5d29RZTJtYmx4d2txMVlsdHM3dUxTTFBQbmRSSWFKczZsZ1MvMDBmYjBL?=
 =?utf-8?B?MVFsR1NkSStQcGpOQ2pOM0gyU1puWGRZdCtmYzdYMkpmM0ZNd3hCMTI1eFQ5?=
 =?utf-8?B?NlpmUkloK0VqOWphNkp4Vy9pSnowc3o1WWM4SFFoNDkrUEQzYzBQb3daMEIv?=
 =?utf-8?Q?2dqCu3wG82cMD1vI=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2950fa16-ae5e-4764-e933-08de63dc5a95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:58:39.8170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLfh1CZBpoasYj1+r5z2T4HA1UsyXSeajOSPRKqHZlB56jQH1DzvsFCOt3aV5DILUdlPXd8DjaO4GyqxOFLvifR55ISsjGGmyl7zcaKtGVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9021
X-Authority-Analysis: v=2.4 cv=MupfKmae c=1 sm=1 tr=0 ts=69832661 cx=c_pps
 a=PlzX2GN61/O3EU/AUs1JWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=BhJWt65YX1AaYjb2LfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rQVA3Sl1waw06vWmtpCsjqUqbPPn2-Dk
X-Proofpoint-ORIG-GUID: rQVA3Sl1waw06vWmtpCsjqUqbPPn2-Dk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4MyBTYWx0ZWRfX4wrWJTBjXhn5
 b51C93+PlokxmwqOB64uZM8XRLvimPoPKJ5k57W2jTliIqqPyeT1QysrZmIYY8191+6EfTpAw3S
 ogIgHsuiwxuvfkWS+1UsJfdPGFwxqAmQIhgX9wIVD8nfJHZ0TuolFeYuD70eI319JZID54bZngB
 u1MIAToKHwp/CuoNKm/mi+BKZqVbHvnwpxpl5TkjGkG4iPC31/46Ca9oEsoCrIEq+XxKlZ1Tl+o
 Xlr8k6dB6FzoSQSL5/AKlz/NHOwx5ZwLG1Rp4Kpuq5b/WABNmXXx42I2a4VeMa6y2sAdNec9XHi
 73bttK7aMg/lzOpH4LfthkDvJtfMl90D8xL06SqPKMzJ1sTCGK40XJL6cp6ggbzXHjiTL7QU5LM
 MITM65kGOg9Sknqg8m6Y30QxS5MYimG3mHswUGQELJJIOJcjHzsw79KnpnS1uXr5XfLq79hTGrP
 QhpgNR7iDj09vx5KS2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Introduce a sub-class for current "audio_driver" based implementations.
> Future AudioBackend implementations can do without it.
> 
> Next cleanup will actually remove "audio_driver" struct altogether and
> make the subclass proper QOM objects.
> 
> Public APIs still rely on backend being an AudioMixeng. They will
> assert() if not. This will be addressed later to allow other backends.
> 
> Note that the initial naming proposed for this object was AudioDriver,
> however the semantics for "driver" is already overloaded and leads to
> confusion, in particular with the QAPI AudiodevDriver. The defining
> characteristic is of using QEMU's software mixing engine, so
> AudioMixengBackend.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h        |  25 +++++---
>   audio/audio_template.h   |  18 +++---
>   include/qemu/audio.h     |  17 +++++-
>   audio/alsaaudio.c        |   2 +-
>   audio/audio.c            | 124 +++++++++++++++++++++++++++++----------
>   audio/dbusaudio.c        |   8 +--
>   audio/ossaudio.c         |   4 +-
>   tests/audio/test-audio.c |   4 +-
>   ui/dbus.c                |   6 +-
>   9 files changed, 144 insertions(+), 64 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index a6276375887..06f5160e8df 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -61,7 +61,7 @@ struct audio_pcm_info {
>       int swap_endianness;
>   };
>   
> -typedef struct AudioBackend AudioBackend;
> +typedef struct AudioMixengBackend AudioMixengBackend;
>   typedef struct SWVoiceCap SWVoiceCap;
>   
>   typedef struct STSampleBuffer {
> @@ -70,7 +70,7 @@ typedef struct STSampleBuffer {
>   } STSampleBuffer;
>   
>   typedef struct HWVoiceOut {
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>       bool enabled;
>       int poll_mode;
>       bool pending_disable;
> @@ -90,7 +90,7 @@ typedef struct HWVoiceOut {
>   } HWVoiceOut;
>   
>   typedef struct HWVoiceIn {
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>       bool enabled;
>       int poll_mode;
>       struct audio_pcm_info info;
> @@ -110,7 +110,7 @@ typedef struct HWVoiceIn {
>   } HWVoiceIn;
>   
>   struct SWVoiceOut {
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>       struct audio_pcm_info info;
>       t_sample *conv;
>       STSampleBuffer resample_buf;
> @@ -126,7 +126,7 @@ struct SWVoiceOut {
>   };
>   
>   struct SWVoiceIn {
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>       bool active;
>       struct audio_pcm_info info;
>       void *rate;
> @@ -239,8 +239,12 @@ struct SWVoiceCap {
>       QLIST_ENTRY (SWVoiceCap) entries;
>   };
>   
> -typedef struct AudioBackend {
> -    Object parent;
> +struct AudioMixengBackendClass {
> +    AudioBackendClass parent_class;
> +};
> +
> +struct AudioMixengBackend {
> +    AudioBackend parent_obj;
>   
>       struct audio_driver *drv;
>       Audiodev *dev;
> @@ -257,7 +261,7 @@ typedef struct AudioBackend {
>       bool timer_running;
>       uint64_t timer_last;
>       VMChangeStateEntry *vmse;
> -} AudioBackend;
> +};
>   
>   extern const struct mixeng_volume nominal_volume;
>   
> @@ -270,7 +274,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>   
>   int audio_bug (const char *funcname, int cond);
>   
> -void audio_run(AudioBackend *s, const char *msg);
> +void audio_run(AudioMixengBackend *s, const char *msg);
>   
>   const char *audio_application_name(void);
>   
> @@ -323,4 +327,7 @@ void audio_create_pdos(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
>   
> +#define TYPE_AUDIO_MIXENG_BACKEND "audio-mixeng-backend"
> +OBJECT_DECLARE_TYPE(AudioMixengBackend, AudioMixengBackendClass, AUDIO_MIXENG_BACKEND)
> +
>   #endif /* QEMU_AUDIO_INT_H */
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index e69e6e74570..a1f78d8748b 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -36,7 +36,7 @@
>   #define HWBUF hw->conv_buf
>   #endif
>   
> -static void glue(audio_init_nb_voices_, TYPE)(AudioBackend *s,
> +static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>                                                 struct audio_driver *drv, int min_voices)
>   {
>       int max_voices = glue (drv->max_voices_, TYPE);
> @@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
>   static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>   {
>       HW *hw = *hwp;
> -    AudioBackend *s = hw->s;
> +    AudioMixengBackend *s = hw->s;
>   
>       if (!hw->sw_head.lh_first) {
>   #ifdef DAC
> @@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>       }
>   }
>   
> -static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBackend *s, HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioMixengBackend *s, HW *hw)
>   {
>       return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
>   }
>   
> -static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioMixengBackend *s, HW *hw)
>   {
>       while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
>           if (hw->enabled) {
> @@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
>       return NULL;
>   }
>   
> -static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
> +static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioMixengBackend *s, HW *hw,
>                                                      struct audsettings *as)
>   {
>       while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
> @@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
>       return NULL;
>   }
>   
> -static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBackend *s,
> +static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>                                                struct audsettings *as)
>   {
>       HW *hw;
> @@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
>       abort();
>   }
>   
> -static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as)
> +static HW *glue(audio_pcm_hw_add_, TYPE)(AudioMixengBackend *s, struct audsettings *as)
>   {
>       HW *hw;
>       AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
> @@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as
>   }
>   
>   static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
> -    AudioBackend *s,
> +    AudioMixengBackend *s,
>       const char *sw_name,
>       const struct audsettings *as
>       )
> @@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
>       const struct audsettings *as
>       )
>   {
> -    AudioBackend *s = be;
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
>       AudiodevPerDirectionOptions *pdo;
>   
>       if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 370e993f080..474d761f0be 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -44,11 +44,21 @@ typedef struct audsettings {
>   typedef struct SWVoiceOut SWVoiceOut;
>   typedef struct SWVoiceIn SWVoiceIn;
>   
> -struct AudioBackendClass {
> +typedef struct AudioBackend {
> +    Object parent_obj;
> +} AudioBackend;
> +
> +typedef struct AudioBackendClass {
>       ObjectClass parent_class;
> -};
>   
> -typedef struct AudioBackend AudioBackend;
> +    const char *(*get_id)(AudioBackend *be);
> +#ifdef CONFIG_GIO
> +    bool (*set_dbus_server)(AudioBackend *be,
> +                            GDBusObjectManagerServer *manager,
> +                            bool p2p,
> +                            Error **errp);
> +#endif
> +} AudioBackendClass;
>   
>   bool AUD_backend_check(AudioBackend **be, Error **errp);
>   
> @@ -125,6 +135,7 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp);
>   AudioBackend *audio_get_default_audio_be(Error **errp);
>   const char *audio_be_get_id(AudioBackend *be);
>   #ifdef CONFIG_GIO
> +bool audio_be_can_set_dbus_server(AudioBackend *be);
>   bool audio_be_set_dbus_server(AudioBackend *be,
>                                 GDBusObjectManagerServer *server,
>                                 bool p2p,
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 7d7da576dc9..814820e2864 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -41,7 +41,7 @@ struct pollhlp {
>       struct pollfd *pfds;
>       int count;
>       int mask;
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>   };
>   
>   typedef struct ALSAVoiceOut {
> diff --git a/audio/audio.c b/audio/audio.c
> index 6eb921f0cca..1c83dd4ce6d 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -36,6 +36,7 @@
>   #include "qemu/log.h"
>   #include "qemu/module.h"
>   #include "qemu/help_option.h"
> +#include "qom/object.h"
>   #include "system/system.h"
>   #include "system/replay.h"
>   #include "system/runstate.h"
> @@ -383,7 +384,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
>   /*
>    * Capture
>    */
> -static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBackend *s,
> +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
>                                                           struct audsettings *as)
>   {
>       CaptureVoiceOut *cap;
> @@ -463,7 +464,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
>   
>   static int audio_attach_capture (HWVoiceOut *hw)
>   {
> -    AudioBackend *s = hw->s;
> +    AudioMixengBackend *s = hw->s;
>       CaptureVoiceOut *cap;
>   
>       audio_detach_capture (hw);
> @@ -801,7 +802,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>   /*
>    * Timer
>    */
> -static int audio_is_timer_needed(AudioBackend *s)
> +static int audio_is_timer_needed(AudioMixengBackend *s)
>   {
>       HWVoiceIn *hwi = NULL;
>       HWVoiceOut *hwo = NULL;
> @@ -819,7 +820,7 @@ static int audio_is_timer_needed(AudioBackend *s)
>       return 0;
>   }
>   
> -static void audio_reset_timer(AudioBackend *s)
> +static void audio_reset_timer(AudioMixengBackend *s)
>   {
>       if (audio_is_timer_needed(s)) {
>           timer_mod_anticipate_ns(s->ts,
> @@ -841,7 +842,7 @@ static void audio_reset_timer(AudioBackend *s)
>   static void audio_timer (void *opaque)
>   {
>       int64_t now, diff;
> -    AudioBackend *s = opaque;
> +    AudioMixengBackend *s = opaque;
>   
>       now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       diff = now - s->timer_last;
> @@ -924,7 +925,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
>   
>       hw = sw->hw;
>       if (sw->active != on) {
> -        AudioBackend *s = sw->s;
> +        AudioMixengBackend *s = sw->s;
>           SWVoiceOut *temp_sw;
>           SWVoiceCap *sc;
>   
> @@ -972,7 +973,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
>   
>       hw = sw->hw;
>       if (sw->active != on) {
> -        AudioBackend *s = sw->s;
> +        AudioMixengBackend *s = sw->s;
>           SWVoiceIn *temp_sw;
>   
>           if (on) {
> @@ -1140,7 +1141,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>       return clipped;
>   }
>   
> -static void audio_run_out(AudioBackend *s)
> +static void audio_run_out(AudioMixengBackend *s)
>   {
>       HWVoiceOut *hw = NULL;
>       SWVoiceOut *sw;
> @@ -1293,7 +1294,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
>       return conv;
>   }
>   
> -static void audio_run_in(AudioBackend *s)
> +static void audio_run_in(AudioMixengBackend *s)
>   {
>       HWVoiceIn *hw = NULL;
>   
> @@ -1340,7 +1341,7 @@ static void audio_run_in(AudioBackend *s)
>       }
>   }
>   
> -static void audio_run_capture(AudioBackend *s)
> +static void audio_run_capture(AudioMixengBackend *s)
>   {
>       CaptureVoiceOut *cap;
>   
> @@ -1387,7 +1388,7 @@ static void audio_run_capture(AudioBackend *s)
>       }
>   }
>   
> -void audio_run(AudioBackend *s, const char *msg)
> +void audio_run(AudioMixengBackend *s, const char *msg)
>   {
>       audio_run_out(s);
>       audio_run_in(s);
> @@ -1560,8 +1561,8 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>       return total;
>   }
>   
> -static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
> -                              Audiodev *dev, Error **errp)
> +static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv,
> +                                 Audiodev *dev, Error **errp)
>   {
>       s->drv_opaque = drv->init(dev, errp);
>       if (!s->drv_opaque) {
> @@ -1593,7 +1594,7 @@ static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
>   static void audio_vm_change_state_handler (void *opaque, bool running,
>                                              RunState state)
>   {
> -    AudioBackend *s = opaque;
> +    AudioMixengBackend *s = opaque;
>       HWVoiceOut *hwo = NULL;
>       HWVoiceIn *hwi = NULL;
>   
> @@ -1615,7 +1616,47 @@ static const VMStateDescription vmstate_audio;
>   
>   static void audio_be_init(Object *obj)
>   {
> -    AudioBackend *s = AUDIO_BACKEND(obj);
> +}
> +
> +static void audio_be_finalize(Object *obj)
> +{
> +}
> +
> +static const char *audio_mixeng_backend_get_id(AudioBackend *be)
> +{
> +    return AUDIO_MIXENG_BACKEND(be)->dev->id;
> +}
> +
> +#ifdef CONFIG_GIO
> +static bool audio_mixeng_backend_set_dbus_server(AudioBackend *be,
> +                                                 GDBusObjectManagerServer *manager,
> +                                                 bool p2p,
> +                                                 Error **errp)
> +{
> +    AudioMixengBackend *d = AUDIO_MIXENG_BACKEND(be);
> +
> +    if (!d->drv->set_dbus_server) {
> +        return false;
> +    }
> +
> +    return d->drv->set_dbus_server(be, manager, p2p, errp);
> +}
> +
> +#endif
> +
> +static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
> +
> +    be->get_id = audio_mixeng_backend_get_id;
> +#ifdef CONFIG_GIO
> +    be->set_dbus_server = audio_mixeng_backend_set_dbus_server;
> +#endif
> +}
> +
> +static void audio_mixeng_backend_init(Object *obj)
> +{
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
>   
>       QLIST_INIT(&s->hw_head_out);
>       QLIST_INIT(&s->hw_head_in);
> @@ -1628,9 +1669,9 @@ static void audio_be_init(Object *obj)
>       vmstate_register_any(NULL, &vmstate_audio, s);
>   }
>   
> -static void audio_be_finalize(Object *obj)
> +static void audio_mixeng_backend_finalize(Object *obj)
>   {
> -    AudioBackend *s = AUDIO_BACKEND(obj);
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
>       HWVoiceOut *hwo, *hwon;
>       HWVoiceIn *hwi, *hwin;
>   
> @@ -1746,10 +1787,10 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>   {
>       int done = 0;
>       const char *drvname;
> -    AudioBackend *s;
> +    AudioMixengBackend *s;
>       struct audio_driver *driver;
>   
> -    s = AUDIO_BACKEND(object_new(TYPE_AUDIO_BACKEND));
> +    s = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
>   
>       if (dev) {
>           /* -audiodev option */
> @@ -1757,7 +1798,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>           drvname = AudiodevDriver_str(dev->driver);
>           driver = audio_driver_lookup(drvname);
>           if (driver) {
> -            done = audio_driver_init(s, driver, dev, errp);
> +            done = audio_driver_do_init(s, driver, dev, errp);
>           } else {
>               error_setg(errp, "Unknown audio driver `%s'", drvname);
>           }
> @@ -1777,7 +1818,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>               g_free(e);
>               drvname = AudiodevDriver_str(dev->driver);
>               driver = audio_driver_lookup(drvname);
> -            if (audio_driver_init(s, driver, dev, NULL)) {
> +            if (audio_driver_do_init(s, driver, dev, NULL)) {
>                   break;
>               }
>               qapi_free_Audiodev(dev);
> @@ -1789,7 +1830,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>           goto out;
>       }
>       object_unref(s);
> -    return s;
> +    return AUDIO_BACKEND(s);
>   
>   out:
>       object_unref(s);
> @@ -1828,12 +1869,13 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
>   static struct audio_pcm_ops capture_pcm_ops;
>   
>   CaptureVoiceOut *AUD_add_capture(
> -    AudioBackend *s,
> +    AudioBackend *be,
>       struct audsettings *as,
>       struct audio_capture_ops *ops,
>       void *cb_opaque
>       )
>   {
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
>       CaptureVoiceOut *cap;
>       struct capture_callback *cb;
>   
> @@ -2224,27 +2266,37 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
>   }
>   
>   #ifdef CONFIG_GIO
> +bool audio_be_can_set_dbus_server(AudioBackend *be)
> +{
> +    /*
> +     * TODO:
> +     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +     * return klass->set_dbus_server != NULL;
> +     */
> +    return AUDIO_MIXENG_BACKEND(be)->drv->set_dbus_server != NULL;
> +}
> +
>   bool audio_be_set_dbus_server(AudioBackend *be,
>                                 GDBusObjectManagerServer *server,
>                                 bool p2p,
>                                 Error **errp)
>   {
> -    assert(be != NULL);
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> -    if (!be->drv->set_dbus_server) {
> -        error_setg(errp, "Audiodev '%s' is not compatible with DBus", be->dev->id);
> +    if (!audio_be_can_set_dbus_server(be)) {
> +        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
> +                   audio_be_get_id(be));
>           return false;
>       }
>   
> -    return be->drv->set_dbus_server(be, server, p2p, errp);
> +    return klass->set_dbus_server(be, server, p2p, errp);
>   }
>   #endif
>   
>   const char *audio_be_get_id(AudioBackend *be)
>   {
>       if (be) {
> -        assert(be->dev);
> -        return be->dev->id;
> +        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
>       } else {
>           return "";
>       }
> @@ -2319,13 +2371,25 @@ static const TypeInfo audio_be_info = {
>       .instance_size = sizeof(AudioBackend),
>       .instance_init = audio_be_init,
>       .instance_finalize = audio_be_finalize,
> -    .abstract = false, /* TODO: subclass drivers and make it abstract */
> +    .abstract = true,
>       .class_size = sizeof(AudioBackendClass),
>   };
>   
> +static const TypeInfo audio_mixeng_backend_info = {
> +    .name = TYPE_AUDIO_MIXENG_BACKEND,
> +    .parent = TYPE_AUDIO_BACKEND,
> +    .instance_size = sizeof(AudioMixengBackend),
> +    .instance_init = audio_mixeng_backend_init,
> +    .instance_finalize = audio_mixeng_backend_finalize,
> +    .abstract = false,

Minor nit: you can drop the .abstract = false here.

> +    .class_size = sizeof(AudioMixengBackendClass),
> +    .class_init = audio_mixeng_backend_class_init,
> +};
> +
>   static void register_types(void)
>   {
>       type_register_static(&audio_be_info);
> +    type_register_static(&audio_mixeng_backend_info);
>   }

These days the DEFINE_TYPES macro is preferred over calling 
type_register_static() by hand.

>   type_init(register_types);
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 1fe7c4ed647..96d4fa3f471 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -464,7 +464,7 @@ listener_in_vanished_cb(GDBusConnection *connection,
>   }
>   
>   static gboolean
> -dbus_audio_register_listener(AudioBackend *s,
> +dbus_audio_register_listener(AudioMixengBackend *s,
>                                GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                GUnixFDList *fd_list,
> @@ -621,7 +621,7 @@ dbus_audio_register_listener(AudioBackend *s,
>   }
>   
>   static gboolean
> -dbus_audio_register_out_listener(AudioBackend *s,
> +dbus_audio_register_out_listener(AudioMixengBackend *s,
>                                    GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                    GUnixFDList *fd_list,
> @@ -637,7 +637,7 @@ dbus_audio_register_out_listener(AudioBackend *s,
>   }
>   
>   static gboolean
> -dbus_audio_register_in_listener(AudioBackend *s,
> +dbus_audio_register_in_listener(AudioMixengBackend *s,
>                                   GDBusMethodInvocation *invocation,
>   #ifdef G_OS_UNIX
>                                   GUnixFDList *fd_list,
> @@ -657,7 +657,7 @@ dbus_audio_set_server(AudioBackend *s,
>                         bool p2p,
>                         Error **errp)
>   {
> -    DBusAudio *da = s->drv_opaque;
> +    DBusAudio *da = AUDIO_MIXENG_BACKEND(s)->drv_opaque;
>   
>       g_assert(da);
>       g_assert(!da->server);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index c6cad47a015..6ad20ab1876 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
>   
>   static void oss_helper_poll_out (void *opaque)
>   {
> -    AudioBackend *s = opaque;
> +    AudioMixengBackend *s = opaque;
>       audio_run(s, "oss_poll_out");
>   }
>   
>   static void oss_helper_poll_in (void *opaque)
>   {
> -    AudioBackend *s = opaque;
> +    AudioMixengBackend *s = opaque;
>       audio_run(s, "oss_poll_in");
>   }
>   
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> index 38e30f47f89..e1e518df2a7 100644
> --- a/tests/audio/test-audio.c
> +++ b/tests/audio/test-audio.c
> @@ -165,7 +165,7 @@ static void test_audio_out_sine_wave(void)
>        */
>       start_time = g_get_monotonic_time();
>       while (state.frames_written < state.total_frames) {
> -        audio_run(state.be, "test");
> +        audio_run(AUDIO_MIXENG_BACKEND(state.be), "test");
>           main_loop_wait(true);
>   
>           elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
> @@ -419,7 +419,7 @@ static void test_audio_capture(void)
>       start_time = g_get_monotonic_time();
>       while (sine_state.frames_written < sine_state.total_frames ||
>              state.captured_bytes < CAPTURE_BUFFER_SIZE) {
> -        audio_run(be, "test-capture");
> +        audio_run(AUDIO_MIXENG_BACKEND(be), "test-capture");
>           main_loop_wait(true);
>   
>           elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
> diff --git a/ui/dbus.c b/ui/dbus.c
> index e44e2ff9877..0cac1ba8471 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -221,8 +221,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>   
>       {
>           AudioBackend *audio_be = audio_get_default_audio_be(NULL);
> -
> -        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
> +        if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
>               audio_be = NULL;
>           }
>           if (dd->audiodev && *dd->audiodev) {
> @@ -231,8 +230,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>                   return;
>               }
>           }
> -        if (audio_be &&
> -            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
> +        if (audio_be && !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
>               return;
>           }
>       }

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


