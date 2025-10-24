Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A4ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGps-00055M-Hx; Fri, 24 Oct 2025 08:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCGpq-00055C-Aj
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:23:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCGpl-0004Ss-6H
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:23:58 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59O6FapZ899992; Fri, 24 Oct 2025 05:23:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GvKzgTwbVv7ObbX9pKwItKBAu8q6A/6rtoc1nTKKb
 Uw=; b=yQqne+VueQaRPTwj3KE0EnCIQ87Qm3Lj6zqZmvnjTKDFrQbS860CLFPWG
 wSL5UsEIU1UxqE8a6kL26gUqlm31nI+F4qeo5yXUtFGg1PXu99H3gej8UyBuRmpx
 7sUNbi6SRSKfZ32B0iVqHU/nuTzZLFRnFOEWUWgIyZm6OAaRht+JzlP6VuEwfqmO
 06cpzy18zdZmj8yef8uE/IJHOfYB/RyIpN4j3Pm0/K60YnBzlKhuvS5wFY+NPNQ4
 lRPys5OwL1VJtItRoYzw40ahAxDACrtRz24jbE2gNfooct/KJpBtdbNePjeH7J0j
 XSRaCEpYjaw7JV2smshRJsQC/OsUw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020117.outbound.protection.outlook.com
 [40.93.198.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49yqfyj3k8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 05:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx6c2LwYk69EYjkUqyxLezjbjGshAQrU8HXxhHXEvHnOkyZ3Epf4AIlnTY00dekWUzo3qZAY4a3sGUCZ05z4pcTbPwwpX9pW7wLtxNtSj1OJQJKbD3woU3e7z1uCSOUC92V0+0cl/KRrcjL+1i3Gl1g8W3kffdXBdnKZALxWhmwhDmwGs6n9PbhiO1ErtjbOWPiXxQUO28sv9dObAJgQgVOQgAR66ejm6ZK4F2uddGYVdF9wTI1x0NSNz/61eyAh8yTRmVRIO4FH9IaAOYbMxbRMjtfsnU/4i5PmoT8OOAehk8227pPaL6AoMU0Uq2dcDstaXtstZwBNDWldyJBVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvKzgTwbVv7ObbX9pKwItKBAu8q6A/6rtoc1nTKKbUw=;
 b=EWsU+iCktl5QaclEjGJL0H7eWAXg1GF88fi5QSi2ar7OaRm+yPxswJKAIS5ozmKR+XCLIHAZSvjhpvxPLBd3DbQ8sZtBayBUmLsPJyrqYeWTtuU/Q2NliZDS9FjmmoJTfic0jJYKLjZIaQccwHEQYAPeA7Z/ugXy6Yl/JxDm8FftummEeo28smW6IXe5me/jl4k9geg+cbTdA62UesE6/nR8DYwWcPw57PGMwCrrhOidUhi2/I6eigzbW0sOkk5m0eLoTz3E/JVsQvIszCJQz5Mn5plye+/DDrc2maH/Rnfevof1SQkDglSh1sLXPqT1doPPsF2fru29M9IjssBglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvKzgTwbVv7ObbX9pKwItKBAu8q6A/6rtoc1nTKKbUw=;
 b=OkM0OPmCecFjSriLF/xeLKPYvNIpJccOK2hlVsiDQ0NoGAaQaZ+ZqMEVlVEED/ZeF3ONXk3LSScx/q4Y9HkpiPgqtIspcQqd4CUEfgpZDJQE+Uj9UpELCH1JyHNJWZqbphy7JE0MTixhV53v7M3OVC0a6uyxMHrWF58BTEkwFTSOoUQUTtSnyvglSL6ufoaaNy/Y8fHeO0eKAfSsh+cPQz7I4Cwd2exkeSg7w8JHuBahQL8otQLvt7/tbFKgh9U/OcJ7srHEztJJsmuabVgXgmDJoPgVmlnDgiHKhQStadGtRlVJDP9QO5GvoL5PiQoHqHQZbKK7tBihWgINq+ZDXQ==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by IA3PR02MB10392.namprd02.prod.outlook.com (2603:10b6:208:536::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 12:23:44 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 12:23:44 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Manish Mishra
 <manish.mishra@nutanix.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Topic: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Index: AQHcPCLQIrO+EaLeX0uyMT4Fy7m+a7S/0e+AgA0B8YCABHTEAIAAAR2A
Date: Fri, 24 Oct 2025 12:23:43 +0000
Message-ID: <F2EC059E-FAD8-4ACD-ACF4-2C4F1E37AC8E@nutanix.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
 <20251013092126.3480671-3-tejus.gk@nutanix.com> <aOzIiVdUCoNKoWb5@redhat.com>
 <2183D087-3126-4928-9DBE-750E641B519B@nutanix.com>
 <aPtu1px7aT9fk1a1@redhat.com>
In-Reply-To: <aPtu1px7aT9fk1a1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|IA3PR02MB10392:EE_
x-ms-office365-filtering-correlation-id: 5afa33bf-6ff8-499d-96ee-08de12f82c72
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WVVIVWNnUGZOSkNYbEMzMGNkMHVGNUpGdVlhK0E2NFdPSFQwMm8wL0hMN1Rj?=
 =?utf-8?B?K3Z4S1BIWjVGU2pSa0Y4M3ZQVDZhUWdrNmNSdDRZNzJFNlJRd2Rsd3ZxY2FI?=
 =?utf-8?B?VDBzZGkrWTRtenhnaHcyYld2M0RMZG9mS29JelZnaTBRd0ZZTGhDeTR2YTFz?=
 =?utf-8?B?MkRhMlZzSmFLRUJPNi9Jb3FTb3ZUUUJibGdpbFdCYnFGN0hVdWhTL0dlRFZF?=
 =?utf-8?B?UHU4NzBqK1JxZWFSWlJneVYvUjR1YmZ5L3NxYXFOWDlJYWw1aE9rOFRlTzJj?=
 =?utf-8?B?SEdNUFVZaGNXUTFUdTNkZm1OY0c3ekZIM0EvWHJ1Z082Nk5hNy9meGJjUDdu?=
 =?utf-8?B?V1hxaWgrTllBRlRERmd1MnZiQVJTWXpCTHhRdUFudjV0a3lOTkxLL3BGYTJG?=
 =?utf-8?B?SlM5SHgrUDJmVng3WHV6SVJMQmlrUWI5RThDTEx3OEt1ZjFIOVZsSUwyd1k4?=
 =?utf-8?B?L0lKMkxNTDNaVWViYlFucWl6OVp2cEJJMnJIUEMyMXQva1VxMzNpbGppbm5k?=
 =?utf-8?B?ek96bGV0R1lQSkE5akZnTDM1d1VSRDdKckZuNFN6d1VSVTJGWEc5V055NThs?=
 =?utf-8?B?UE1jSlBZTjFzUkxYZVNZanZVTFprZjY3VldKM2QwMmlObGxPeXpDb2V0TS90?=
 =?utf-8?B?MFpmeHVicUdRV2FnQjg0L0drdnR3eHArSitXMTNJSzJpTk1oWjJNOWczd0p0?=
 =?utf-8?B?QjA1NnBwWjRrSFBPajhSYmM5dVdkaHg1bzJxZWx6SUJwc1NHOWtjSitFK3lt?=
 =?utf-8?B?citFc09uSUcyQWY0aG9FZlFaeEFSeDBFWWJDby8vWTdFZFdMVkJHaDkvY0FF?=
 =?utf-8?B?eEJVNllhSDhQaXowK3VRZ3Y0VG94S2JOc1JObVJYOTh2VmY1cGZuNnNuRkVp?=
 =?utf-8?B?dzdERzRXQ1BWQmdSMDJSQ3UwdWtmSlMraTBGeVdaVVJRVWlGSHNPZ2dhV0J0?=
 =?utf-8?B?YVJiSDArd09oOC9zZUxybTNPYzYvbDBBUjhHM0hNOGF4Y2J6YkNFWitXZnNL?=
 =?utf-8?B?WEpSMjJrM2QxZjcyQ0FMR2kzUjBoV1luVzhIOVptUVd1SVl5RzBUaEloa21S?=
 =?utf-8?B?dGxPUzREQjh3eTlPM0FDZUVwdzZCbUVRaXpMbmdYYkdUVUo5eGZ4Vkw1clVX?=
 =?utf-8?B?TlNWNG1oL2JqOUpZNldrRTZUL0duMkJzZFd1a1V5RjVEa2VDY1I5cS9RcGxl?=
 =?utf-8?B?TENSVmV5SXBlYStCaHZKdXZvOFVHbmtKeU5HaHl6d0M1dm0xZFhUOWRWbURB?=
 =?utf-8?B?OXpsT1NDMzZIQml6b0M2dkxKWFc4MFV5VVZtUkZIY3h0Q0EzK2h3SUhMaDhp?=
 =?utf-8?B?cnZzc2h0a01zSjQwUlBDTk5XN3dKS21ZTjFJazJWekRKb1dmbEJoUzJjeHFi?=
 =?utf-8?B?ZkVaZjBwNVJzalZnb0ZuOHR0N3BTMGwyWUtockJmdWNtNnBLbkZncENwSEJS?=
 =?utf-8?B?a3Q5d3hhWEt1dWxSRGpSSCtyekEvTWR0K1NicDhjaVhXTlp3NXZVbVpsQ3NV?=
 =?utf-8?B?UUNXajdrSWlldkhDcDR1QjRBZDJhekdONVdKcmlUYmNTQnBLMGxYaU5CTkVu?=
 =?utf-8?B?dEZ6SzRHU3UyNUpOMW9OQ0tiL0g4M0pvZDJoNURpQkR6cFE5S1AyMmw5Wklp?=
 =?utf-8?B?V21KakEzNEtPSTFiQ0NzL3lYam9aK05LYmZ5YjlRZ2dRdlkyYjVJWUM3Wi9k?=
 =?utf-8?B?OWsydFAxMzdPZ3cxWlp4ZGEydjBVcVgxc2diUW0wRlI3QTdiMkhaMTNnNjY4?=
 =?utf-8?B?NTdETW9xRDVXaW9nZUlTd3RTMDRibGg3d280Q1NYTEZiWkl3VTVMV3plYm1I?=
 =?utf-8?B?SkFoMFBMc0tUYTE4UC90ZGNoaHhXdlUvZHRmcU5rbGlVcEZCQkI3WkxER0NM?=
 =?utf-8?B?TktnR2VKUzBoZi94UWNxTzJYRUZxbzc5MUlyaHF2MjQ1eXFnOGx0TUdPekRN?=
 =?utf-8?B?RXVuRkt2MW4zazF6Wk1Dek5keWVtNHdxMnV6NUdJRStINkdMRFBkeFFWQkFS?=
 =?utf-8?B?RzdWTW80Q3BxR0JueGpkVkJqc05rd1ZKdkV1VEthSVdzMWdjZ3F5RUxmWU1h?=
 =?utf-8?Q?q1wwho?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckQ4Zmw4bnpPaGNoakdMN0tGc241TGU2SzZzZm9LK0pPR2ZUalZuaVAvSEsw?=
 =?utf-8?B?OC9vYnI3UWs1eTkybVVleE1TZ3Y0RExNTmZSTHBYanRiTTdCbFFKVUJPMnpF?=
 =?utf-8?B?dVEyZ0M5dVlhRTdKdTE2Q2VvV2k1NW4xRHRRa3dsczFUd3E2YnlqVTBHYlRU?=
 =?utf-8?B?VndTd2tybHI4eWIxTEx1RXVvVnB6ZnpraTcybTJPYmhrWGdVRFlxYWtHOHBu?=
 =?utf-8?B?bTI1UUt3NWlOZ09yeWltbHlheWhYZEQ5ak9KcVc2d0RKSWM5RmhGSU1ic3J1?=
 =?utf-8?B?bHNrcGdNSmZ4MXAvMHlFOC9Ib0h4OFBVNlBDYm5JY2N6SmF4a25LNytpcGhM?=
 =?utf-8?B?TDEwWGJBYWhyUHVlM2ZtdGJKdlE2OTJxYm1aUnVlak9LNDVaYVo0b3hYYjh1?=
 =?utf-8?B?K3J5RmQ0WWZ0VU9lbnZ1bSt3TkpjeUJyTnFZODJvZ2V0eDk0N29uZGVrQ3hV?=
 =?utf-8?B?OWNoczQ3OWFRcnBFeXUrc1RiY0N2YlJqQ2c1c3hxcWJabmEwVFVaWUNROXpD?=
 =?utf-8?B?UnVHK05sNkp3V0FBNnZ3YXIyNmEvNm5sTE9GMEphTGFMdzhhUDdXMVM0Qk9s?=
 =?utf-8?B?ek1URGVyVEpVTi9kWU9PdUdRbkZ4dndzWnUwcExxVHdUeGxlSTdYZExNbnhi?=
 =?utf-8?B?YllzdUw2VXdldU5DV1NEVUZOZ2dBS0VWWGNBZUxxSTg1TEdUdEJ1c3FTS1dQ?=
 =?utf-8?B?TW1ZQldSSllOLzBJbWU5Y0pOOEIzTysxc1Vja29hVGYxSDhpS01hdzd0WWdR?=
 =?utf-8?B?UFROL1NZcVo1T0NBOEpqWVIzRjVNVEh4RWZyN2xoTzZKRWwvVEJLaDVFd3JS?=
 =?utf-8?B?SlF0NXJhT1VDemgxV2c3MVFZcW5vS1ZNYzJITFlMNGF3OTRRWHJJRlhYa3FI?=
 =?utf-8?B?QStqUWdEQm81ZWRnM1ZCSUwwVjNiNlpNT0RhWTBXZTAxZGdTNGs1bXUwcTIw?=
 =?utf-8?B?ZWFYZkZkM1k4eTVTejZrQkNMc2YyMm5DNWp2REllMkZ4WVJyRzhsTG9DU0dT?=
 =?utf-8?B?WEZaL1g5N1JYelBBWitXU0FMYVRDZlRHM0w4eTY0N084cFFZOEJnZFNXL3ZW?=
 =?utf-8?B?Y0pmSGxoYnlVQXdUZTRzMFJTbm5QSkplOWN2L3Rtd2creVlvNXJKVytnZ2tr?=
 =?utf-8?B?OXhLT3Z0TjBwcThFT08yeFR1Qm5LdXFGa1VLaTZvUzJJN2hKanpyWVdsdFRK?=
 =?utf-8?B?VElBemJQdDlGWkc4Z05JSlU1S3cwalRpZVhtWEsxOWY2Ymh2K09xcXZzMEk2?=
 =?utf-8?B?dnQvWWcxZWQ3dXpmK3E5UGZOWXFkTGV1ZFFnN1VrUzZPQS8vU25sRVorRDVC?=
 =?utf-8?B?WlByUlk2QzlVQ3JEdW51RjJTaXBFeVcvK3IrbmFHOTJlQWdmeXRwV3UwWWJa?=
 =?utf-8?B?WGZxb0MvSEJwL1B0Qy9sWlV6SXlLNTE2V3hQWHBsckQrSFJNZGpMMTFCdXl0?=
 =?utf-8?B?cVhnaXBDbVlqOFNDT051ci9RQ2xPUG9HM0lFQ3c4cHpkWGhCNEx6SGQ1dFBk?=
 =?utf-8?B?akdMQWpucEw5aWZrU2htQlYvT1NGRlQ5VE5HUUx4RWRBcE9EU1RyS3RRdDNO?=
 =?utf-8?B?UmN3Sm5KN3J2QURBZ3VpSUZ6dW1FTVdjOVp6a29oa29STHZDSFhQSVV6R21u?=
 =?utf-8?B?a0VHcmRGVHFYVUFvVXZpWDBLb0x2cXoyNFh2MHIrTVU0ZHZHaEdGOTVyK09O?=
 =?utf-8?B?T3UwckY2RFBkTmR2UFYvaUM5MWhHOFgzeEVwRDM1V2ZqeSs2dFR1SGFRbklk?=
 =?utf-8?B?d0x6RmFiZlg5amRZcW9DV0g5TllrcU84aVFEUXhlTVZCWDgyYzIvR0R1S29Z?=
 =?utf-8?B?MzhhRElEK1creUZtUjJDcTdQSWNBVkZ5ZVdlSng5ZmF3c1J4U2NxUGduNnFk?=
 =?utf-8?B?cmUreVovdWJHWDRWcFF1b29IWkJ3Q0hranp5UG91WlEyS01xY0ZteHJkTzNY?=
 =?utf-8?B?UUI0aTNva0hObzhEdjhNWFk1a3N4ME1CaEVSSVROU0tncXMxMFBibTlPczVI?=
 =?utf-8?B?WVE2dUc2bFIxQ05SaFV6QlpPYVZMblYvQ2dQbEExMllDaFdEbmgxUGdnM3pO?=
 =?utf-8?B?QVpqMjhhdGhEb0ZHbjRuY0hWVGE3NXRnNE0xYjFIK2N1WUxBZ2xwSjJFdHNo?=
 =?utf-8?B?UVFBRVRJQ0JpaDFnV2lKNjBYS051eEJvV2c0V3lmRWZwQ045TklJQTlVWnVP?=
 =?utf-8?Q?7l4ujJ2kJB2CSQe9LE+etXmpqLwVAZSK51nm9TLToG+9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FD550E5E5709946AC78C7C5E2FD0209@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa33bf-6ff8-499d-96ee-08de12f82c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 12:23:43.9561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyJAk9VHyLSZzOnMKxnyVq6JicDRwQ1addtsUZUQk8XrzH6yxaoFX1cPFmzc3jF21qXm7vFDgy0L5kHP43d9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10392
X-Proofpoint-GUID: _qUcScqgjkVmGs-gst0Dmb-Shv5tUxa8
X-Authority-Analysis: v=2.4 cv=CcsFJbrl c=1 sm=1 tr=0 ts=68fb6fd4 cx=c_pps
 a=UIcKv52QUy3ZqpRAVMOEHw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=SozftdaA2LAQDQRyowUA:9
 a=QEXdDO2ut3YA:10 a=pRRNJOJqb3sA:10
X-Proofpoint-ORIG-GUID: _qUcScqgjkVmGs-gst0Dmb-Shv5tUxa8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDExMCBTYWx0ZWRfX6cbMtcAwow3b
 bcDfi3ofS6ZSnCJnC50w0P52dVinEQKYjIbvi1ydrCzSTwx5LHIs5eZHYxk5WDYxXKwdXHt/jmd
 iml0vydoPXowe8mYADPbUrOe5Uw6WJFpLNsJ9B4Ae9zRJNjIDL0iUO2AJEx6uBv86JONBVmUZLj
 zkpgPQlCaI6y6Sxqnn4KGtnhCrCjQ6NjHsLsb1cKpxcWYUeXlSATbXhL3RXWpQBTwpqVOJAfiZE
 SpDuwbQfF9TD/RHCHxQFN/sRUfW9mn8nsDb9oidD97rVQRhn/f3hxSVYTylJoV0dJJqozEatYdn
 niMCamFKoNvL+bcgo+zl8ofRoLt+x1vwAI7fuj0hKtV16BvF+szLvG3YArnLvG8iRPelM+Bi17O
 lNr93Ej1xT+vcbjYgvHLbvPkctiouA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gT24gMjQgT2N0IDIwMjUsIGF0IDU6NDnigK9QTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFR1ZSwgT2N0
IDIxLCAyMDI1IGF0IDA0OjE2OjQ4UE0gKzAwMDAsIFRlanVzIEdLIHdyb3RlOg0KPj4gDQo+PiAN
Cj4+PiBPbiAxMyBPY3QgMjAyNSwgYXQgMzowOOKAr1BNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiAhLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4+PiBD
QVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPj4+IA0KPj4+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPj4+IA0KPj4+
IE9uIE1vbiwgT2N0IDEzLCAyMDI1IGF0IDA5OjIxOjIyQU0gKzAwMDAsIFRlanVzIEdLIHdyb3Rl
Og0KPj4+PiBGcm9tOiBNYW5pc2ggTWlzaHJhIDxtYW5pc2gubWlzaHJhQG51dGFuaXguY29tPg0K
Pj4+PiANCj4+Pj4gVGhlIGtlcm5lbCBhbGxvY2F0ZXMgZXh0cmEgbWV0YWRhdGEgU0tCcyBpbiBj
YXNlIG9mIGEgemVyb2NvcHkgc2VuZCwNCj4+Pj4gZXZlbnR1YWxseSB1c2VkIGZvciB6ZXJvY29w
eSdzIG5vdGlmaWNhdGlvbiBtZWNoYW5pc20uIFRoaXMgbWV0YWRhdGENCj4+Pj4gbWVtb3J5IGlz
IGFjY291bnRlZCBmb3IgaW4gdGhlIE9QVE1FTSBsaW1pdC4gVGhlIGtlcm5lbCBxdWV1ZXMNCj4+
Pj4gY29tcGxldGlvbiBub3RpZmljYXRpb25zIG9uIHRoZSBzb2NrZXQgZXJyb3IgcXVldWUgYW5k
IHRoaXMgZXJyb3IgcXVldWUNCj4+Pj4gaXMgZnJlZWQgd2hlbiB1c2Vyc3BhY2UgcmVhZHMgaXQu
DQo+Pj4+IA0KPj4+PiBVc3VhbGx5LCBpbiB0aGUgY2FzZSBvZiBpbi1vcmRlciBwcm9jZXNzaW5n
LCB0aGUga2VybmVsIHdpbGwgYmF0Y2ggdGhlDQo+Pj4+IG5vdGlmaWNhdGlvbnMgYW5kIG1lcmdl
IHRoZSBtZXRhZGF0YSBpbnRvIGEgc2luZ2xlIFNLQiBhbmQgZnJlZSB0aGUNCj4+Pj4gcmVzdC4g
QXMgYSByZXN1bHQsIGl0IG5ldmVyIGV4Y2VlZHMgdGhlIE9QVE1FTSBsaW1pdC4gSG93ZXZlciwg
aWYgdGhlcmUNCj4+Pj4gaXMgYW55IG91dC1vZi1vcmRlciBwcm9jZXNzaW5nIG9yIGludGVybWl0
dGVudCB6ZXJvY29weSBmYWlsdXJlcywgdGhpcw0KPj4+PiBlcnJvciBjaGFpbiBjYW4gZ3JvdyBz
aWduaWZpY2FudGx5LCBleGhhdXN0aW5nIHRoZSBPUFRNRU0gbGltaXQuIEFzIGENCj4+Pj4gcmVz
dWx0LCBhbGwgbmV3IHNlbmRtc2cgcmVxdWVzdHMgZmFpbCB0byBhbGxvY2F0ZSBhbnkgbmV3IFNL
QiwgbGVhZGluZw0KPj4+PiB0byBhbiBFTk9CVUYgZXJyb3IuIERlcGVuZGluZyBvbiB0aGUgYW1v
dW50IG9mIGRhdGEgcXVldWVkIGJlZm9yZSB0aGUNCj4+Pj4gZmx1c2ggKGkuZS4sIGxhcmdlIGxp
dmUgbWlncmF0aW9uIGl0ZXJhdGlvbnMpLCBldmVuIGxhcmdlIE9QVE1FTSBsaW1pdHMNCj4+Pj4g
YXJlIHByb25lIHRvIGZhaWx1cmUuDQo+Pj4+IA0KPj4+PiBUbyB3b3JrIGFyb3VuZCB0aGlzLCBp
ZiB3ZSBlbmNvdW50ZXIgYW4gRU5PQlVGIGVycm9yIHdpdGggYSB6ZXJvY29weQ0KPj4+PiBzZW5k
bXNnLCBmbHVzaCB0aGUgZXJyb3IgcXVldWUgYW5kIHJldHJ5IG9uY2UgbW9yZS4NCj4+Pj4gDQo+
Pj4+IENvLWF1dGhvcmVkLWJ5OiBNYW5pc2ggTWlzaHJhIDxtYW5pc2gubWlzaHJhQG51dGFuaXgu
Y29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBUZWp1cyBHSyA8dGVqdXMuZ2tAbnV0YW5peC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiBpbmNsdWRlL2lvL2NoYW5uZWwtc29ja2V0LmggfCAgNSArKysNCj4+
Pj4gaW8vY2hhbm5lbC1zb2NrZXQuYyAgICAgICAgIHwgNzUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPj4+PiAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyks
IDE0IGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaW8vY2hh
bm5lbC1zb2NrZXQuaCBiL2luY2x1ZGUvaW8vY2hhbm5lbC1zb2NrZXQuaA0KPj4+PiBpbmRleCAy
NjMxOWZhOThiLi5mY2ZkNDg5YzZjIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2lvL2NoYW5u
ZWwtc29ja2V0LmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oDQo+Pj4+
IEBAIC01MCw2ICs1MCwxMSBAQCBzdHJ1Y3QgUUlPQ2hhbm5lbFNvY2tldCB7DQo+Pj4+ICAgIHNz
aXplX3QgemVyb19jb3B5X3F1ZXVlZDsNCj4+Pj4gICAgc3NpemVfdCB6ZXJvX2NvcHlfc2VudDsN
Cj4+Pj4gICAgYm9vbCBibG9ja2luZzsNCj4+Pj4gKyAgICAvKioNCj4+Pj4gKyAgICAgKiBUaGlz
IGZsYWcgaW5kaWNhdGVzIHdoZXRoZXIgYW55IG5ldyBkYXRhIHdhcyBzdWNjZXNzZnVsbHkgc2Vu
dCB3aXRoDQo+Pj4+ICsgICAgICogemVyb2NvcHkgc2luY2UgdGhlIGxhc3QgcWlvX2NoYW5uZWxf
c29ja2V0X2ZsdXNoKCkgY2FsbC4NCj4+Pj4gKyAgICAgKi8NCj4+Pj4gKyAgICBib29sIG5ld196
ZXJvX2NvcHlfc2VudF9zdWNjZXNzOw0KPj4+PiB9Ow0KPj4+PiANCj4+Pj4gDQo+Pj4+IGRpZmYg
LS1naXQgYS9pby9jaGFubmVsLXNvY2tldC5jIGIvaW8vY2hhbm5lbC1zb2NrZXQuYw0KPj4+PiBp
bmRleCA4YjMwZDViN2Y3Li43Y2Q5ZjM2NjZkIDEwMDY0NA0KPj4+PiAtLS0gYS9pby9jaGFubmVs
LXNvY2tldC5jDQo+Pj4+ICsrKyBiL2lvL2NoYW5uZWwtc29ja2V0LmMNCj4+Pj4gQEAgLTM3LDYg
KzM3LDEyIEBADQo+Pj4+IA0KPj4+PiAjZGVmaW5lIFNPQ0tFVF9NQVhfRkRTIDE2DQo+Pj4+IA0K
Pj4+PiArI2lmZGVmIFFFTVVfTVNHX1pFUk9DT1BZDQo+Pj4+ICtzdGF0aWMgaW50IHFpb19jaGFu
bmVsX3NvY2tldF9mbHVzaF9pbnRlcm5hbChRSU9DaGFubmVsICppb2MsDQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGJsb2NrLA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KTsNCj4+Pj4gKyNlbmRpZg0KPj4+PiArDQo+Pj4+IFNvY2tldEFkZHJlc3MgKg0KPj4+PiBxaW9f
Y2hhbm5lbF9zb2NrZXRfZ2V0X2xvY2FsX2FkZHJlc3MoUUlPQ2hhbm5lbFNvY2tldCAqaW9jLA0K
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+
Pj4+IEBAIC02Niw2ICs3Miw3IEBAIHFpb19jaGFubmVsX3NvY2tldF9uZXcodm9pZCkNCj4+Pj4g
ICAgc2lvYy0+emVyb19jb3B5X3F1ZXVlZCA9IDA7DQo+Pj4+ICAgIHNpb2MtPnplcm9fY29weV9z
ZW50ID0gMDsNCj4+Pj4gICAgc2lvYy0+YmxvY2tpbmcgPSBmYWxzZTsNCj4+Pj4gKyAgICBzaW9j
LT5uZXdfemVyb19jb3B5X3NlbnRfc3VjY2VzcyA9IEZBTFNFOw0KPj4+PiANCj4+Pj4gICAgaW9j
ID0gUUlPX0NIQU5ORUwoc2lvYyk7DQo+Pj4+ICAgIHFpb19jaGFubmVsX3NldF9mZWF0dXJlKGlv
YywgUUlPX0NIQU5ORUxfRkVBVFVSRV9TSFVURE9XTik7DQo+Pj4+IEBAIC02MTgsNiArNjI1LDgg
QEAgc3RhdGljIHNzaXplX3QgcWlvX2NoYW5uZWxfc29ja2V0X3dyaXRldihRSU9DaGFubmVsICpp
b2MsDQo+Pj4+ICAgIHNpemVfdCBmZHNpemUgPSBzaXplb2YoaW50KSAqIG5mZHM7DQo+Pj4+ICAg
IHN0cnVjdCBjbXNnaGRyICpjbXNnOw0KPj4+PiAgICBpbnQgc2ZsYWdzID0gMDsNCj4+Pj4gKyAg
ICBib29sIGJsb2NraW5nID0gc2lvYy0+YmxvY2tpbmc7DQo+Pj4+ICsgICAgYm9vbCB6ZXJvY29w
eV9mbHVzaGVkX29uY2UgPSBmYWxzZTsNCj4+Pj4gDQo+Pj4+ICAgIG1lbXNldChjb250cm9sLCAw
LCBDTVNHX1NQQUNFKHNpemVvZihpbnQpICogU09DS0VUX01BWF9GRFMpKTsNCj4+Pj4gDQo+Pj4+
IEBAIC02NjQsOSArNjczLDI0IEBAIHN0YXRpYyBzc2l6ZV90IHFpb19jaGFubmVsX3NvY2tldF93
cml0ZXYoUUlPQ2hhbm5lbCAqaW9jLA0KPj4+PiAgICAgICAgICAgIGdvdG8gcmV0cnk7DQo+Pj4+
ICAgICAgICBjYXNlIEVOT0JVRlM6DQo+Pj4+ICAgICAgICAgICAgaWYgKGZsYWdzICYgUUlPX0NI
QU5ORUxfV1JJVEVfRkxBR19aRVJPX0NPUFkpIHsNCj4+Pj4gLSAgICAgICAgICAgICAgICBlcnJv
cl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIlByb2Nlc3MgY2FuJ3QgbG9jayBlbm91Z2ggbWVtb3J5IGZvciB1c2luZyBNU0df
WkVST0NPUFkiKTsNCj4+Pj4gLSAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+Pj4+ICsgICAg
ICAgICAgICAgICAgLyoqDQo+Pj4+ICsgICAgICAgICAgICAgICAgICogU29ja2V0IGVycm9yIHF1
ZXVlaW5nIG1heSBleGhhdXN0IHRoZSBPUFRNRU0gbGltaXQuIFRyeQ0KPj4+PiArICAgICAgICAg
ICAgICAgICAqIGZsdXNoaW5nIHRoZSBlcnJvciBxdWV1ZSBvbmNlLg0KPj4+PiArICAgICAgICAg
ICAgICAgICAqLw0KPj4+PiArICAgICAgICAgICAgICAgIGlmICghemVyb2NvcHlfZmx1c2hlZF9v
bmNlKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIHJldCA9IHFpb19jaGFubmVsX3NvY2tl
dF9mbHVzaF9pbnRlcm5hbChpb2MsIGJsb2NraW5nLA0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCk7DQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLTE7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIH0NCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgemVyb2NvcHlfZmx1c2hlZF9vbmNlID0gVFJVRTsNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgZ290byByZXRyeTsNCj4+Pj4gKyAgICAgICAgICAgICAgICB9IGVs
c2Ugew0KPj4+PiArICAgICAgICAgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVy
cm5vLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJQcm9jZXNz
IGNhbid0IGxvY2sgZW5vdWdoIG1lbW9yeSBmb3IgIg0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJ1c2luZyBNU0dfWkVST0NPUFkiKTsNCj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC0xOw0KPj4+PiArICAgICAgICAgICAgICAgIH0NCj4+Pj4gICAg
ICAgICAgICB9DQo+Pj4+ICAgICAgICAgICAgYnJlYWs7DQo+Pj4+ICAgICAgICB9DQo+Pj4+IEBA
IC03NzcsOCArODAxLDkgQEAgc3RhdGljIHNzaXplX3QgcWlvX2NoYW5uZWxfc29ja2V0X3dyaXRl
dihRSU9DaGFubmVsICppb2MsDQo+Pj4+IA0KPj4+PiANCj4+Pj4gI2lmZGVmIFFFTVVfTVNHX1pF
Uk9DT1BZDQo+Pj4+IC1zdGF0aWMgaW50IHFpb19jaGFubmVsX3NvY2tldF9mbHVzaChRSU9DaGFu
bmVsICppb2MsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApDQo+Pj4+ICtzdGF0aWMgaW50IHFpb19jaGFubmVsX3NvY2tldF9mbHVzaF9pbnRl
cm5hbChRSU9DaGFubmVsICppb2MsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIGJsb2NrLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+PiB7DQo+Pj4+ICAgIFFJ
T0NoYW5uZWxTb2NrZXQgKnNpb2MgPSBRSU9fQ0hBTk5FTF9TT0NLRVQoaW9jKTsNCj4+Pj4gICAg
c3RydWN0IG1zZ2hkciBtc2cgPSB7fTsNCj4+Pj4gQEAgLTc4Niw3ICs4MTEsNiBAQCBzdGF0aWMg
aW50IHFpb19jaGFubmVsX3NvY2tldF9mbHVzaChRSU9DaGFubmVsICppb2MsDQo+Pj4+ICAgIHN0
cnVjdCBjbXNnaGRyICpjbTsNCj4+Pj4gICAgY2hhciBjb250cm9sW0NNU0dfU1BBQ0Uoc2l6ZW9m
KCpzZXJyKSldOw0KPj4+PiAgICBpbnQgcmVjZWl2ZWQ7DQo+Pj4+IC0gICAgaW50IHJldDsNCj4+
Pj4gDQo+Pj4+ICAgIGlmIChzaW9jLT56ZXJvX2NvcHlfcXVldWVkID09IHNpb2MtPnplcm9fY29w
eV9zZW50KSB7DQo+Pj4+ICAgICAgICByZXR1cm4gMDsNCj4+Pj4gQEAgLTc5NiwxNiArODIwLDIw
IEBAIHN0YXRpYyBpbnQgcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNoKFFJT0NoYW5uZWwgKmlvYywN
Cj4+Pj4gICAgbXNnLm1zZ19jb250cm9sbGVuID0gc2l6ZW9mKGNvbnRyb2wpOw0KPj4+PiAgICBt
ZW1zZXQoY29udHJvbCwgMCwgc2l6ZW9mKGNvbnRyb2wpKTsNCj4+Pj4gDQo+Pj4+IC0gICAgcmV0
ID0gMTsNCj4+Pj4gLQ0KPj4+PiAgICB3aGlsZSAoc2lvYy0+emVyb19jb3B5X3NlbnQgPCBzaW9j
LT56ZXJvX2NvcHlfcXVldWVkKSB7DQo+Pj4+ICAgICAgICByZWNlaXZlZCA9IHJlY3Ztc2coc2lv
Yy0+ZmQsICZtc2csIE1TR19FUlJRVUVVRSk7DQo+Pj4+ICAgICAgICBpZiAocmVjZWl2ZWQgPCAw
KSB7DQo+Pj4+ICAgICAgICAgICAgc3dpdGNoIChlcnJubykgew0KPj4+PiAgICAgICAgICAgIGNh
c2UgRUFHQUlOOg0KPj4+PiAtICAgICAgICAgICAgICAgIC8qIE5vdGhpbmcgb24gZXJycXVldWUs
IHdhaXQgdW50aWwgc29tZXRoaW5nIGlzIGF2YWlsYWJsZSAqLw0KPj4+PiAtICAgICAgICAgICAg
ICAgIHFpb19jaGFubmVsX3dhaXQoaW9jLCBHX0lPX0VSUik7DQo+Pj4+IC0gICAgICAgICAgICAg
ICAgY29udGludWU7DQo+Pj4+ICsgICAgICAgICAgICAgICAgaWYgKGJsb2NrKSB7DQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgIC8qDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAqIE5vdGhp
bmcgb24gZXJycXVldWUsIHdhaXQgdW50aWwgc29tZXRoaW5nIGlzDQo+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAqIGF2YWlsYWJsZS4NCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICovDQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgIHFpb19jaGFubmVsX3dhaXQoaW9jLCBHX0lPX0VSUik7
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+IA0KPj4+IFdoeSBHX0lP
X0VSUiA/ICBJZiB3ZSdyZSB3YWl0aW5nIGZvciByZWN2bXNnKCkgdG8gYmVjb21lIHJlYWR5LCB0
aGVuDQo+Pj4gaXQgd291bGQgbmVlZCB0byBiZSBHX0lPX0lOIHdlJ3JlIHdhaXRpbmcgZm9yLg0K
Pj4gDQo+PiBBcG9sb2dpZXMgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBQbGVhc2UgY29ycmVj
dCBtZSBpZiBJIGFtIHdyb25nLCANCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fZG9jcy5rZXJuZWwub3JnX25ldHdvcmtpbmdfbXNnLTVGemVy
b2NvcHkuaHRtbC0yM25vdGlmaWNhdGlvbi0yRHJlY2VwdGlvbiZkPUR3SURhUSZjPXM4ODNHcFVD
T0NoS09IaW9jWXRHY2cmcj12LWo5a2tLY3RPVWNFV21zTzFxMFU1R2g4Z3ZZMTVoclgwT0dTMXRF
cEowJm09aWFZa3ZweG13UjROVXNKRVhsOXdUazZQclJCaE15MERxZnVScXNMYVBndnU5U2xhWjBh
S19CZ19BY2hERDM0ciZzPXQwMjBET0REdGE3cHRKX1VXUHFJU2hUYmVYcXplTjNOY0lJUm5rN19k
RDgmZT0gDQo+PiBtZW50aW9ucywgdGhhdCBpbiBvcmRlciB0byBwb2xsIGZvciBub3RpZmljYXRp
b25zIG9uIHRoZSBzb2NrZXQgZXJyb3IgcXVldWUsIG9uZSBuZWVkIG5vdCBzZXQgYW55IGZsYWcg
aW4gdGhlIGV2ZW50cyBmaWVsZCwgYW5kIHRoZSBrZXJuZWwgaW4gcmV0dXJuIHdvdWxkIHNldCBQ
T0xMRVJSIGluIHRoZSBvdXRwdXQsIHdoZW4gdGhlcmXigJlzIGV2ZW50dWFsbHkgYSBtZXNzYWdl
IGluIHRoZSBub3RpZmljYXRpb24gcXVldWUuDQo+PiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCB0
aGUgZ2xpYiBlcXVpdmFsZW50IGZvciBQT0xMRVJSLCBpcyBHX0lPX0VSUiwgd2hpY2ggbWVhbnMg
d2XigJlkIGJlIHdhaXRpbmcgb24gdGhlIHNvY2tldCBlcnJvciBxdWV1ZSB1bnRpbCBhIG5vdGlm
aWNhdGlvbiBjb21lcyB1cC4NCj4gDQo+IEFoIEkgc2VlLiBUaGF0J3MgcmF0aGVyIG5vbi1vYnZp
b3VzLiBDYW4geW91IHB1dCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUNCj4gdG8gdGhlIGVmZmVjdCB0
aGF0IHVzZSBvZiBNU0dfRVJSUVVFVUUgcmVxdWlyZXMgdG8geW91IHBvbGwgb24gR19JT19FUlIN
Cj4gaW5zdGVhZCBvZiB0aGUgbm9ybWFsIEdfSU9fSU4uDQoNCkFjaywgSeKAmWxsIGFkZCBhIGNv
bW1lbnQgaW4gdGhlIG5leHQgcGF0Y2gtc2VyaWVzLiBUaGFua3MhDQoNCg0KcmVnYXJkcywNCnRl
anVz

