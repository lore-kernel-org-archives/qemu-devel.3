Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C18E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1CW-0005iR-BH; Tue, 10 Dec 2024 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbolshakov@ddn.com>)
 id 1tKwR2-0002GQ-18; Tue, 10 Dec 2024 04:21:40 -0500
Received: from outbound-ip191b.ess.barracuda.com ([209.222.82.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbolshakov@ddn.com>)
 id 1tKwR0-0007I4-62; Tue, 10 Dec 2024 04:21:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44]) by
 mx-outbound22-132.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Dec 2024 09:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWwxojEPYoI3rNwE90IewCfs4aLBsxiu3CmWQiVyQ9FZKhyIxQY5hSw9uOtV2cC0ktmsjIAgygHoiqGusESMgHJsB1jDUSEHBEq6I5uWxvyXse16JUqgbiax9rMfG4j+m0tWuUyU9TlObd9D8bdTqpDbVkwUYi4wHO9IGrmNcc1mcLaJUm+GXQyMW2lfGEW2QRImuYlPeUM49GCL9brmhSNo2nWFjkbvAvNc7Q5tI1LZSYgtUrdw3qeTIDjO2A3EMvotO9rjXlHeZ9SCdPCwSOH98RFaXnqs+iksqIAAX8235pV5d6juWDWALVpzmx5Ah/1IvNcm86OPV9dEIK3gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2N4rbrgOJ6aK1O7IcBYIYoIyrb/Jd5xnYk05g8Aro=;
 b=RO6c3It4iQLBq/ZBuaP4oM8FhwOtK7gB0VWB/pJ7/rsZ0liQ47OTyHhxbi/oJmMip77aDkEHV6VO3xar9ien43qhzz49SofeKrm4kSJaPwPPUPnfmMxDmqdE9G4VpIOaMQR4tGJSFZ8HHeUsVFRv33Cbttmo/slY6h4ASLxKCkp/6u1PiQr2SqfJuYIEIf7edhsz9JPSQXrLVIr5PY/V6RQhrwU08AXd14Psw0lHzCoG9GKVI9B877GHzsl+L2VoA/umhFhjznWkNF/XVYOA+HTLjHtQKNtqWfguDq3OLWfX4bXjW83BWQZ2BeLf/JVBJkEshxDutovLmq9Mo2+eTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2N4rbrgOJ6aK1O7IcBYIYoIyrb/Jd5xnYk05g8Aro=;
 b=VkApHcmDTaF+lnm4+huzOcTszfhkHR5sZG+qfoi8a3YFhSxlewgInhp6El3+S45Y2bGe7l/EWtmtMLw9sdv+ILBqFtnzcKP7cwLGRGM5lasvVMgGdQJq+6xtJy82u6kbXUFauBk6bt17N0cMOdA+l34z2eykzJ57Efidjx0nOC4=
Received: from BY5PR19MB3889.namprd19.prod.outlook.com (2603:10b6:a03:218::8)
 by DM4PR19MB5691.namprd19.prod.outlook.com (2603:10b6:8:5e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 09:21:21 +0000
Received: from BY5PR19MB3889.namprd19.prod.outlook.com
 ([fe80::e67f:97c5:5d65:a269]) by BY5PR19MB3889.namprd19.prod.outlook.com
 ([fe80::e67f:97c5:5d65:a269%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 09:21:21 +0000
From: Roman Bolshakov <rbolshakov@ddn.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "phil@philjordan.eu" <phil@philjordan.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@csgraf.de>, Peter Maydell
 <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
Thread-Topic: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
Thread-Index: AQHbSnodWTg5uC3pPk6IRV7wd0lkGrLea9AAgADI+gA=
Date: Tue, 10 Dec 2024 09:21:21 +0000
Message-ID: <0aa33648-5a30-4302-bf7a-f31cab0b327e@ddn.com>
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-4-phil@philjordan.eu>
 <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
In-Reply-To: <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3889:EE_|DM4PR19MB5691:EE_
x-ms-office365-filtering-correlation-id: 8f17e6fb-9b44-47f1-0a4a-08dd18fc02ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q2x6SDhCcWpOd1BMR05nZ2U3WXU4MWVBdVZZVzduMkw3NXMzeWpIaUJTMlk5?=
 =?utf-8?B?NWpSS29zeUt0Y1dFK3lkVEZrOWVyWGgwekprZ2FZQVpoM3gyWFJMeXpGVU9o?=
 =?utf-8?B?aUZxVk51Nnk4WUczRFdvaWdQUVdxWGdPbURTVkRhc1phNzgzNUt3aEMzVXln?=
 =?utf-8?B?blAxV2hNTXJFaXdxWFhHSGtvUGtXMmNkd2VSeFRMbmYreTFhUTZOOENPNCs2?=
 =?utf-8?B?TFdLYklPZHA2djFsbTFNaTRXcmxNazBKd1Z2a0xUOTVzNExEQTVaMGFKczZ2?=
 =?utf-8?B?NzRSaTNraTA5eEhiRjA0TmllVUFkMUdTeFJXL1hYc21nQXVBSVgrQ1VTSlcz?=
 =?utf-8?B?b1BGWFZTN3JIUEhZTWpIdXJtc1oyWlB3SUpTblEyU0RCYW5acktubnQwTGww?=
 =?utf-8?B?eEFITUpsNE0rcldzcnlVQ29aeXQ1Rm45QmQrQ2RyZnY1S1BUcDlMSSt6UG1n?=
 =?utf-8?B?UDNOSnBON3NnTlNEaTYvQUV2R2lzcmJCT0ZlYmhibm90Z1ptSnZKRlJvaEJD?=
 =?utf-8?B?dDFWSThxK0JMNmtwMG9lWksxZy8xZVVtVE5UQ0J4TUg2bnBoTVkwY3Y4Y3F0?=
 =?utf-8?B?NFdZdGpOL29VcVY0elNpWXQ1NlJIQUE2eDlMUHRxOW9CVzJGRmdHT0JadDlW?=
 =?utf-8?B?b0pEcTFsNDRTS1NoZUhGcThLc2hnSjNUMWt3YjBEZWFRbkRPb3BLbGxDdEdo?=
 =?utf-8?B?eXVhQXBPek9iTndmS1RqOFNyR3crQzF5aEppeWhJUnhIVmR2Y2EyaDcweXhz?=
 =?utf-8?B?TGVuMTZtcTRFVlBTMnZ3VGNucGFKWE5GMzZHM1d1Uzg0VDlDS3ljOGlSMzBC?=
 =?utf-8?B?OU9TcHNKUG1COThQNlVRRUFxZEJOTDJHOUE4OWZyZWc0Vk82UHNZc0VyYWtt?=
 =?utf-8?B?MFNKU2xTV3dUVWRJTUtyaUd4UXNTOFYzYnFiSDNhZnpjUFd1cU43c0o3cjhp?=
 =?utf-8?B?QlZGT1ZXNllwRllMd0tKbm1CYmtnL1lHSEVvZ3dYWXFHRzZMeDRLYms2UGRa?=
 =?utf-8?B?aTcyc252SDVIL1lZMFJZdFV6M1JadE1ubGhySlR4RWZTaXFkM2ZwWTdjUml3?=
 =?utf-8?B?UWlQTmhXcWdKZ3VPZExsWHBEODErRXZIOHRESXhTVXlHYWZianB5SXNwOUdB?=
 =?utf-8?B?UDZwTDRCVGYvb05sOFZNY090UnBZNER6eTA1eldGMGlTZUV6VERMcElWNjZE?=
 =?utf-8?B?M05zdWFudjljemdyMTVWMEs5TVdTRFJBYmk3cU5TVWVLUFM1dG8wa285UmxJ?=
 =?utf-8?B?cnlFeWJEcktSTVpuRFk5WE1PRTJ1Wk8zVVREWDk5S3ZGTFE1TC8yNi93RE4x?=
 =?utf-8?B?U2toci9tWmxjRXFNWHo1TkRjaGhmZ0d5ck4wbnI0bDkrdWk2eEdjTjh4bE9m?=
 =?utf-8?B?QkxsV1k1YmljMHRhY2pBanZhb0hLNDhxQzRjOFp5dndSMEpBbGxZWVBoOUFt?=
 =?utf-8?B?czFwM3R4cGxEa0xoU2lpeVFVbzBLTXJycVhLRjRuSUlFODBER0hta1NtUGVK?=
 =?utf-8?B?ckx5S09IWVBWaFJ3RTNVNTlJMDVDMlIzQkFJNGRUTERSRnh1YWVyczhlbEFJ?=
 =?utf-8?B?Uk1zRFU5SWpQaFU5S2VIWXhUeU1UdCs5M0dUUEpkQlJ6enRGTmdSMTRlMnlZ?=
 =?utf-8?B?RzFQSVo3bmZ5YVcvcXd4MTFpMEFQWE8xOEkwREd6MnZ4cDBYTjVmUWcrRWlu?=
 =?utf-8?B?YUs5T2RJN3c2enlNWG5vb0d2ZnhFRkpnckl2TTRsVzd1YTMwQU94MTZwTXJp?=
 =?utf-8?B?TktsQUN6cnQ1cTVSdHllL1AxRkFwdjVubERLZjVPSVJITG93R3A4QU15b3Uv?=
 =?utf-8?B?TlZJcXNJcEdLeE5CZVdEMWpzNVdqWGZvUDhpc1Q5SlpDcXdrMmdPTVV1Q0h1?=
 =?utf-8?B?cHZqWjhXcDdRRUpxYXlqZ2ZQcmZaU0kxdEpnN2s2Q2pSTnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR19MB3889.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBwUGN6UmdYdldlTkxObEZvd0Z1ck5wK3UrQWJjLzRGTFJKSHc4Q0xIQkxZ?=
 =?utf-8?B?VE4zcnk1ZlVFMzRMdy9Lc0pZc3UrRHZCTnY2NFprQnRSQlpKK1Q0eXJudG1x?=
 =?utf-8?B?VUN0dzcwM1hpSVpPQTZQV1ZjUWUxOGJZTFpWcWJZTnQ4aHl6eWtCbnBBU2Vo?=
 =?utf-8?B?TU5ZSjR1MGVhY3E3ZjZST0FvSmJ3OE9Gdy9YaEtTUnY5UDg4SzVTS3BZTVh0?=
 =?utf-8?B?UnBCOVpSUEpIQnVENlVyYkowYXNrU3g4OUpjdmRFbUZaZjB5OXMrN3Y2WU9h?=
 =?utf-8?B?dEFoN1JDV2l5LzZPdXJGbk44LzVNaGNyT3RtNXFwejlZV254b09IMVhDUXNV?=
 =?utf-8?B?VEVHUUw3ODlHSXMvUG1ycW1oSm85Qk1qNTJ1US9jSEVVWWFSS2NmTHRXQmJs?=
 =?utf-8?B?VHBxUEVKMFdlOUlDaGhBYm5JdVhQSGgxNmF6OVZYcXcvQi9QY0hidGZ6NHpG?=
 =?utf-8?B?Snd3ME9PcXpPaVFZOU9DT29HM29mVk9yTDVlZ3ErSlExSnd0a3hxaXlZTEJO?=
 =?utf-8?B?TG5PaGhpYmFyaUlJOTlTNFlaTXFDVGpHNGs1cjk4djNZWW83TmtPWVdvTUxk?=
 =?utf-8?B?MzZMaUxhMEdtWDkwQXo0N1FFTWh0QUl2SmlYZnZHVXdOSDZ5RlUzWTZyYm1O?=
 =?utf-8?B?bEFvU0VFNHJWTDU1SlpnMTYva2dGOXF5VzRNS2FKNEkvV2JjRGp5N0E1MXdH?=
 =?utf-8?B?SHREQW5wQlNYQjhZM1pqR1RIUGVRbXNrQzkzbFZxMjhKamJtc3IxQmMvUlp2?=
 =?utf-8?B?NmVXQWZyZTJLbERzcHcrSWpzeXVOV1ZDNEFQVjhkM1ozSzJ5NllqMXp4dndu?=
 =?utf-8?B?NGh4N092akYyUmVYbjM4UEk1eFpweWN5TC85SytURHptMlVKMkxVdjg3bTFK?=
 =?utf-8?B?YzZOMGhXZFdNa29vZDVzRjBCUTdJV085QVYrWG80cDNlbkEydWhReEEvTWJk?=
 =?utf-8?B?SVRWMzlJRk5qSFk3QlpRUmFaVTZWT0Jzc1pmVHBMdjBtTWozaTZIcHZwOGtE?=
 =?utf-8?B?a2RBMmpLaWw2NjFqUSsweTJKcFFPbTJJZkhaMkxzS2lpdTE3ZjRORG02ZnI0?=
 =?utf-8?B?WG9YUnRsRSt4OEdqUDlmTWk3elpJbXJVNVZQMGEyZFhDdS9uSWNZSmJGU2VX?=
 =?utf-8?B?bVMvUEFwS2xxQmNVSHRlbGt0eHc0ZmV1bVRoWHZQbTkvVk1KNWV5R1dBMGZy?=
 =?utf-8?B?TktmblNTcG9vMWhTOFVlc1c2d2VDRzFaeDRva3lISVkxUDVRcWpKVThYa1Ns?=
 =?utf-8?B?K1RoU0VGRlArRXRYVjhMcTZJQVkzM2p3M2NWWFRQV0RiWUgycDh6djZNUEhH?=
 =?utf-8?B?QUZrQ3U0RWIzcGVnOFlJVUk2WllPYVZZQWtqRXloMktxWTlkNzZjOUpRVEZz?=
 =?utf-8?B?YkwwckdJWUxoZU42WkpNcUlMeXhNKzJXTjBsT2NtNW9xZFdJMTN6TmlReHBq?=
 =?utf-8?B?WlBRbGhod3h4czRKeGNJOTFYa3RTUHlETUxwVnllTjh1Vmx4ZGhOMXVSK1Yy?=
 =?utf-8?B?blF5OTVJaDhKUzA4MFJsWnRHRG1DUGo1elpUcG43Nk1YTEVTOHZBdzVmTFJK?=
 =?utf-8?B?ZWlDbURxVTFQbW1RSjNzeWdqTWkyRWIwN0FHUzd3UTZJLzJyZWNnYTg1Yko1?=
 =?utf-8?B?YUZJK1Bob0ZqbG9mbzU1dEdzTUdYZ1lRcjVmMnVoeko1Mmdhcy9tWjRMYWVU?=
 =?utf-8?B?UmNOaEZtMENudFloM0tTQnc3UzU1d3BKNk41K3FvUkRsWUVBUTl1TDh2UEJ5?=
 =?utf-8?B?MVJYYXF1MDFoMEFLeXNmbE5ybXpoVlRGaWZCMmk1QmhDY2VxNDY4NnFWQitW?=
 =?utf-8?B?SzVZYXM2K2xKTUdCaHFTQWFZKzkwN1llYWNmK2V6NGg2aU9LOXhpODU2VE1M?=
 =?utf-8?B?RWpLaEE5SXhuWmVqeTFXcEVJUmVhRnBITERSTTlweThCT290aG9yYVF2MGZB?=
 =?utf-8?B?dHJudzUzUVhjS3ZMRnNXYnIwbFRLZGIwMHJpdUthQ0ZSNnJ0ZDM0engyQ0dS?=
 =?utf-8?B?T2I2Mm9od2JHMENOWmNRQUxOM2N4V0ZOUDBkS0JwcHVkWmZpMUFBYnZWQStK?=
 =?utf-8?B?NkpUQ1Z4aWdTNWt2RitMaC9jT1hlbUVzMWtOVzhnODZrQ1dQWXBzY2lhdHl2?=
 =?utf-8?Q?TK4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107A070406D1BB46A88A7919E80947AE@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y2Aw5XsyPujBQ95YIsqLtC2N0f7Z0bK1nLh+NB8+DMN9iiSAnWHz7mQXHD5EDVURV82dXszvcuTqkmm52C2f1F9jgMbPhtgYlkXV6pZ9r5rRaCSxuwSSRUCopQTBkNmEfzrA3T6PKWGxSCUZwd52Eyeek6uDeBnnfT/nEHK6iNw2DFz8g6pLeJe6VKJRtKH/+b5d5ZXqRTd6UJgjkH2yjkqHqSSHqMQo/MzUF+Fenm5diz+1te1X3R2UyOe+Z2r7NcxINvLQvg3gRGeT+XLpNdooopSH0/EO4iHYq20Cfy83fUfOtombz7Z3pc1MBcXaQea5O9JWMxc8Z1+ZqGC6oszf6O1dvwboo4JVX258JnOVwT0CVuuTsduciDTs2yP806A0IgIdQGYBHiTAOaRGd/1pfEtefaNZe2VzW+I8aK14aR5uslhDJtKpLDr/soXnk41sTOQCD0Y8Qoc2mW48+traaQQdhVxJgDWEjzQXSWsMKnCz0e6GHqI4VkiXrvp+ax3ekgQqMU/Ae6/Mrr1C/Q0e+f5iO4H8JaCLvqFxNke4sjrzE2Aa77kj5Li+vaQ2cs9U3pRAKlG9FbvigJIO0oDVsq3y2L70lvDR2gR/qFQmR+yNU9NF4bYlzyzWon215lJbuqhriXSD7GBHfNaCew==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3889.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f17e6fb-9b44-47f1-0a4a-08dd18fc02ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 09:21:21.2743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1z/VTZzjkFQ1WJvKDmZx/N7qChDqbRS5YwOc7EoYZ+v1gpvqeUyYi3gEWlKirmPOXDg8VfIT28p+sIQ+OXvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5691
X-BESS-ID: 1733822484-105764-3523-20120-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.56.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGBpZAVgZQ0NLYMinFOMXYIN
 XCyMLYKMnQKCXV0jzR1NzY2Cw1ycxQqTYWAFIxE2BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.261012 [from 
 cloudscan8-185.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.124; envelope-from=rbolshakov@ddn.com;
 helo=outbound-ip191b.ess.barracuda.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Dec 2024 09:26:56 -0500
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

T24gMTAuMTIuMjAyNCAwNDoyMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDkvMTIvMjQgMjE6MzYsIHBoaWxAcGhpbGpvcmRhbi5ldSB3cm90ZToNCj4+IEZyb206IFBoaWwg
RGVubmlzLUpvcmRhbiA8cGhpbEBwaGlsam9yZGFuLmV1Pg0KPj4NCj4+IFRoaXMgc2VlbXMgdG8g
YmUgZW50aXJlbHkgc3VwZXJmbHVvdXMgYW5kIGlzIGNvc3RseSBlbm91Z2ggdG8gc2hvdyB1cCBp
bg0KPg0KPiBTbyB0aGUgcHRocmVhZF9raWxsKGNwdS0+dGhyZWFkLCBTSUdfSVBJKSBpcyBlbnRp
cmVseSBzdXBlcmZsdW91cz8NCj4NCj4+IHByb2ZpbGluZy4gaHZfdmNwdV9pbnRlcnJ1cHQoKSBo
YXMgYmVlbiBkZW1vbnN0cmF0ZWQgdG8gdmVyeSByZWxpYWJseQ0KPj4gY2F1c2UgVk0gZXhpdHMg
LSBldmVuIGlmIHRoZSB0YXJnZXQgdkNQVSBpc24ndCBldmVuIHJ1bm5pbmcsIGl0IHdpbGwNCj4+
IGltbWVkaWF0ZWx5IGV4aXQgb24gZW50cnkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGhpbCBE
ZW5uaXMtSm9yZGFuIDxwaGlsQHBoaWxqb3JkYW4uZXU+DQo+PiAtLS0NCj4+IMKgIHRhcmdldC9p
Mzg2L2h2Zi9odmYuYyB8IDIgKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9odmYvaHZm
LmMgYi90YXJnZXQvaTM4Ni9odmYvaHZmLmMNCj4+IGluZGV4IDNiNmVlNzlmYjIuLjkzNmMzMWRi
ZGQgMTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQvaTM4Ni9odmYvaHZmLmMNCj4+ICsrKyBiL3Rhcmdl
dC9pMzg2L2h2Zi9odmYuYw0KPj4gQEAgLTIxNCw3ICsyMTQsNyBAQCBzdGF0aWMgaW5saW5lIGJv
b2wgDQo+PiBhcGljX2J1c19mcmVxX2lzX2tub3duKENQVVg4NlN0YXRlICplbnYpDQo+PiDCoCDC
oCB2b2lkIGh2Zl9raWNrX3ZjcHVfdGhyZWFkKENQVVN0YXRlICpjcHUpDQo+PiDCoCB7DQo+PiAt
wqDCoMKgIGNwdXNfa2lja190aHJlYWQoY3B1KTsNCj4+ICvCoMKgwqAgY3B1LT50aHJlYWRfa2lj
a2VkID0gdHJ1ZTsNCj4+IMKgwqDCoMKgwqAgaHZfdmNwdV9pbnRlcnJ1cHQoJmNwdS0+YWNjZWwt
PmZkLCAxKTsNCj4+IMKgIH0NCj4NClNJR19JUEkgaXMgbWFjT1MgY3J1dGNoIGhhbmRsZWQgaW4g
WE5VIGtlcm5lbCB0aGF0IHdhcyBlc3NlbnRpYWwgdW50aWwgDQpQaGlsIHN1Ym1pdHRlZCBwcm9w
ZXIga2ljayBzdXBwb3J0IHdpdGggaHZfdmNwdV9pbnRlcnJ1cHQoKS4NCg0K

