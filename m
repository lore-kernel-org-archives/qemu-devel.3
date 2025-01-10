Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC04FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBCj-0001AK-AA; Fri, 10 Jan 2025 04:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tWBCY-0000oV-Aj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:21:11 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tWBCS-0007iJ-NY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736500864; x=1768036864;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=qdD6Xmpk1a58FG7CIp93LfeAEw4z6ZUt3YXh2AnhGYI=;
 b=gByzOVh9s+C7RNO9fyer9VgJldYazY3QSnIcxin/6gx47Ueuey3gN7KP
 /pHlvWlRbM08kwcIIA6+fhA0qa3Oannbt9Fp7BN16ItXF+ZdujOogPcjb
 3pRxqNoxT5sBc62av38Ry+f6rFBHRo4jdR5CiNAxwDN9M+ZNoAK6X19gc
 +FDzlpwzcHu4ItwJYcX6UeISbvNq+NsOCu+sCIRdhqD7K3HUlLZbjjC8F
 EZrTvthr5EZOSAHa4+pXggVjQygwYxkvJEeGiwTnshccA+CzArCkzRfZ1
 8V6GcvCEW4XesqHz/T0r2ja9j7Mwc38gZ7pwH0EVMaEOyUsTf7f40J9t6 A==;
X-CSE-ConnectionGUID: 9pzfL6lmQWSZIpf1tgl52g==
X-CSE-MsgGUID: DE2pKxT3SAen5t6+khHIkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="142627745"
X-IronPort-AV: E=Sophos;i="6.12,303,1728918000"; d="scan'208";a="142627745"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 18:20:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUR+2Szx7xgKpaTy49P1XZec9GOiWrL+HS7X3KcGbAjRN+cG6SwHywjCVwaHYcwpmDy71zTAWB1b6FnTa/HRGb06fOUa0V7Z7JjclVRBoLsLHIcC4kgfDq4IQzJgbl34XyHhFUhormX9Fg+nGUNz7juwFxPRVQnHWs/CFnPMaS6RxF5fgMIRCPf5r/4im1n+kqBUMgHDNj3nqQAoq671xjwUFgZvirUgp0xRMrhItPjQdyw4kH0n/RsYiU93JIagyLtCkOVat10+ZPusIv/kQiE6POv13Zm8zAee08QG5iGOCap9Hs8R9sq510Vtt/qxiD87zPYgJiHOq52/m/v+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdD6Xmpk1a58FG7CIp93LfeAEw4z6ZUt3YXh2AnhGYI=;
 b=IST2AzttasMmOMMBqYy0wQ7MwSZ/gIU8nsciODndFn6Uuh16sqHvTU4LhQI/kCtJXU1CMYzijGANNNB4Asa8wxyzlmlnOZeEAUIzExc7A7bFO4+zJVdXkFO+Z13jkQCuXQw+9shVtwqP+yWcOj4G2ssFY/wQMibfyEutxyz7lHcg56fVevYu+hIpriXLAuag5L0PG1F5ToOa2rUR+YslUuSm5K5DhWdOAtR2rr1M49cJmNaL3y8vMHeowCzsCLtqqkyvU92oye/f/W8VsVhEkhTdaVpgFn7L54ShZu5L+58wLCO5DBfSJ8NMZCwIUtWalOS93tpK5UkfCNx8AMfARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB5695.jpnprd01.prod.outlook.com (2603:1096:400:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 09:20:55 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 09:20:54 +0000
To: Itaru Kitayama <itaru.kitayama@linux.dev>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: CXL emulation on aarch64
Thread-Topic: CXL emulation on aarch64
Thread-Index: AQHbYyDLXGM/14SDRUiD8/oAQjWNxLMPu6EA
Date: Fri, 10 Jan 2025 09:20:54 +0000
Message-ID: <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
In-Reply-To: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB5695:EE_
x-ms-office365-filtering-correlation-id: dcafe20e-6f29-46a5-7672-08dd31581559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?eWlaT29qS1BLYUsrbFczVmQ2cldpYUtubkExTTY5N2lxRDFvSTYxVTIzT2Ns?=
 =?utf-8?B?QXR5eUZqUmFKaWVVdTdXbVJXWitraTErVkJCNWFPWVd1ejR4RjBpbGE0bEdQ?=
 =?utf-8?B?V0JFNWJORk5JZ1RNWWtzVlhpcmt3RVJpcDdXTk1IMGtkbWUwZ0ZTTWkwWVJZ?=
 =?utf-8?B?YzRxenFuZFV2cXZpejV0TUpNOS9xbDJ3R08wQkVQM040UnBHc2QwbXQ3MWJC?=
 =?utf-8?B?NlFDM2laMUgreVN6RzN6TkswSmk5ODZBdFc1YUQvdDFRdS9oSENESmVZTTBl?=
 =?utf-8?B?NFcvM0FHbzR2V2RUaHB0M05tMnpGSHN1d2l5NGwrWEVUcVZEZ3VERnd3akdM?=
 =?utf-8?B?a0RmY0RZNUJ2Z3ZEb01vNDE5eFhSRHBaemQwcHBxbUxOV3VpUzZBcVRJenBw?=
 =?utf-8?B?YU9yYWV6ZjJZaXg5ZUNDZDBOQ3ZSc0xZejRIOTdGWUE4N2RxUmhzSGpXTnVG?=
 =?utf-8?B?dXhwcmwxUzlvcjB2Mm5obzk5SVRUZlp2MFR6R2hEdlh6TG53SkJNaVMybEVN?=
 =?utf-8?B?aTkxOVNkN3V3d3J1ZFZqNVRlUWk0WmVKMjVtb3RNUVNBZExpQk0vWE42WUtX?=
 =?utf-8?B?SFNvQ1VUWEpjNnpRZVNlSk53ZUc2bjlzRW9FY0xzcVY4WlFKbHBwNkN1bkZ6?=
 =?utf-8?B?Qit1YVp1M1cwRWNBY0dTMzZUMi91TStGMUk2RklNdU5UTzEvRDFtSGtYZW9o?=
 =?utf-8?B?UGlwM2V2Z0o1V0FOanpTeTVMRm4xQjd6VzB6eE5mNWdaY0JnYVYybU5xcUhU?=
 =?utf-8?B?ZHhzdWNJZCt6eU41VFJPQzAvMm1yam9Yc2MzTGVKSjlhdmVFN3ZPd3Z5Mllj?=
 =?utf-8?B?aTVFZHdVekFmVXJUQWZVb0VkUlE4L2hpOHNObStTbWs0NnpwU3dvamJsaXBG?=
 =?utf-8?B?Z01YWml1VEVoYk9ZYU1rMW5yZkYzdmlMbzl3azlRK0tQemZDUkV6WGcraGMy?=
 =?utf-8?B?Z29zV0w3aXhPWjlwRUdVLzZONld6VzJlaHFBUE5uL1ZsN1N3Ni9hM3VEUGgy?=
 =?utf-8?B?TlFvQzZhbUlxT2RPbmEwZE9NUmphcVNrcStHUkV6THcyL2NzblMrSFdKZVpP?=
 =?utf-8?B?UTc0RjVjaDBRbTQ1RkdCNlZjNXVnVDcxWVBRbkxXbzRDcm5oU2hIa3ZTOEY5?=
 =?utf-8?B?SmxhaXNaYlJFMDRNcDZYelNyWWhHYTlvV3B4M2pCZ2xXTW5BQlpGUi9sT2hY?=
 =?utf-8?B?MGFvb2hHYUw2WStqblBESkxnb0h0WTRvK1NhbE43ZUQvaXRiTHErREQ1MTQr?=
 =?utf-8?B?eklOWUdaenMvYmV1eU1uV3ZGVE9NZE9hbG10NEFyUk5lcTRaM0o2ZXd3TCs5?=
 =?utf-8?B?RDN5YkVhWGdqVnVDSU84M1ZMSkNpK3R4MWhMcUZ1bUdCUWNwNVlPbVBMazQy?=
 =?utf-8?B?TnJlRzlHaW16V3ZYU080N2pFUVQrbEJhcjkwalplZlgyVlUzc0VSd3V0dDBi?=
 =?utf-8?B?Y2x1MHVMTDRIVEIyU0w4N1ExTkhLNGxnYjVQUTlrL0U4eXR1N1EvbWs1TEcv?=
 =?utf-8?B?MnB2dGQ4ZGRqYXNOVUVJWnVLSDFDbEx0anpTcFlCZU83VlRFdVUvNUtkd1NB?=
 =?utf-8?B?U0JjZXdsZkJkQ2QzSEdsdG5yOU5HbHo4TXRCQ2ZBb1d3cmJROUZ4aGs0cFRl?=
 =?utf-8?B?Z1VZczdMcnNWUjVWTGdIWHRrUlhYVXY5TS8xZC80R1pQUWFDWnpVb2pXYjJY?=
 =?utf-8?B?QWpkVW5TNDBUek9wa2dDeVN0RDlqbnAydGUwV3J3dS9YWVAzSWhheVNneVpF?=
 =?utf-8?B?bnplV1p0Tm9lSGg2UVRVaHU1enQzMUhtYXd2Y1Q4a3dFSFBjTzZPMlppK0RM?=
 =?utf-8?B?R3NaN3ZBQk9ob0JLTXEvZUlwRkw0eVZTOEQvMjZpSFp1S1Evc1VGM2p3Wm1m?=
 =?utf-8?B?MzNJcDVEVXVjejQ2ZmtZaDZqTk5kdU1ZUWpkNG04WDBvOHVzWnhrd3FEQjFE?=
 =?utf-8?Q?hfrL3y8cuZc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0FDdTRpUGoxQXpFNHk4cFl0RzRVRmFod3hiZGlyeHFFOUhhV0xqTzVpa0Zk?=
 =?utf-8?B?Nm5FVTdveC90M09XbzkrS2l5M1pUYUZwdXN4SjlVbS95Q2xrRm1nV1pOTVVr?=
 =?utf-8?B?dEpCUFRINmFxYW00VEQxMVNpK3kyakVoSmdDOXI4NCtRRE5EVEZEVVRvVGNk?=
 =?utf-8?B?N3JHS1JFVmR1SHZ2OWJFTDRDVWJubVVtWk9zbWo2QnRIKzVQMVpzSG03SnRZ?=
 =?utf-8?B?ZEJiUGZPenNHZEJJRi9aNTdMNVJYdHppTi8rWEpWSVZwa3FBVndOMHZ4aGJy?=
 =?utf-8?B?cGpBWHFxekUrTTJLOGZLczFpYStpOHprNW9jOURrb2p6Ni9oNksvZHlaMGE1?=
 =?utf-8?B?bEwvcVc1dUgvTXlHVWJOOXN6d1ZRTG45Y1B4OUxxV2F5S0krQXBTRktmT2dx?=
 =?utf-8?B?MHlhUjlCNEl0bHYzTUxCdExrQWMxdjB4Y1BCVEIvQlpUU0pIeWlUZ0t0dmph?=
 =?utf-8?B?eUlZSXBXa3lWVVIzWk9SOW1ENElaK2QrZG8xS2twUFEvbkhadStsWWVxMlNY?=
 =?utf-8?B?NWZLTTl5VzR1ZWlhRllqSjk2WEt1T1Y3RW42V1g0QmNxYTl2eW9ObUljczdL?=
 =?utf-8?B?TGEyTlVYdGpmUUErSW9pNC9wSFVQZm9QWUFlNzQrVVE0TldkRVBJWGU3WWZu?=
 =?utf-8?B?YnluSExPdDRObnk4b0QzRFFuWGZHVmFod2xwbTFrZlk2SWtWQk9tVnZzWVBm?=
 =?utf-8?B?ZlM5SExkUzJtMG9QY0s3MUR2aWhLSXVWMmdkTFd6SGxRUXZ5ZVYvQXZDZTY5?=
 =?utf-8?B?UFpaeU5ObzVDOWJtWUhtd0hmc2ROMCtOR096TkdDWElMb3h2aUN3NVdCNWph?=
 =?utf-8?B?VWdwMjYrcFhxMkxZWlc4c0FPYXZSdVdReXpTbER2SHFtVngrYWZUSkxXVDRu?=
 =?utf-8?B?dFl1ODNobjU5NndHaHhEanB1eFo5b0V4em1RWHRJRHhMLytUaHRoM3h6SkhZ?=
 =?utf-8?B?RkpHVEZDZ3BjREF2ZVZuejh6cVdSb01XV0xQakZoeXBkUVkvWWVTUURrT0Fn?=
 =?utf-8?B?RUIrU2JJdXRBZnhuMjExTDMyMWwyaHJIckRRWmZQaFczRFhVczdlRzdTa0ov?=
 =?utf-8?B?cGI4QTFkcHE1ZVBHY01yZTAzeEt3V2t2YzJ5U2xSUEZ3bzBhV0prN2xFQzZX?=
 =?utf-8?B?OWgrR3IrZVRPV01DbzlvbFVNU2l1akF5LzRkejUxbXZjaFZybWlyMUxpanAy?=
 =?utf-8?B?c0hLSEFUUGdaeUE2bHJKMUNyQmRFa3lvMXFOeTB5VU5mcTBlby9WSEJ3THUy?=
 =?utf-8?B?eEdza2dibDZ2RTI2RFR6NmxMdDdYTm1heFk0M2dHbGtjbWttL2tzNTlhYlFI?=
 =?utf-8?B?NzlDakhpaDhhU2hCK3ZITm9JRXdXMlhQUDN6cDM3ZWQ4NGhVSU9pZXo3Ym4v?=
 =?utf-8?B?VHUwbk5UeHRoSklZaFdHMmdsQlRBNDlzbzhiN3JsaTNnck90ZVloTzRPdEZ0?=
 =?utf-8?B?MEkzNXk4SDR2THVoVi9zaitGQm4yNEdVY3BaYk4yVlZQNXhyVG5vWEo1eUZW?=
 =?utf-8?B?ZFluRERadjljRXRPZCtqZE1SeC9zY2toL1dnRVJaK3RNOGpSK0FqVTNRVjNp?=
 =?utf-8?B?OGpna3g0dEc0c0Z6RmhMY2dTKzZHeU04ZXhDeWgvNGNrT2N2RzgvUFBCcmdt?=
 =?utf-8?B?UkxrVHp1QUNXT3E4Q2tpUzc1SjEyODhBaENNUmcvQXVLb2VQTUhxeXQ5bkVs?=
 =?utf-8?B?ZHAyUlYzSXIxZWh4cXZkd2F0Vk9kRVR0MDIvb251NWlka1p1VDVJUVZrNnRW?=
 =?utf-8?B?VnlkMkJmK3c0MkpTYjZUcW5wNUkyaEE4RzMyblg0Q21oYkpjYTlUb3BnRUlV?=
 =?utf-8?B?OU9uS0RzR1U1S3JuV29DUXZZVUZxWEpYazIzNFZidXptc3NJR2d0enRubDdQ?=
 =?utf-8?B?ZUFsOWMzZG83ZkQ2NEU1RTgxUU1kRVBUallrMUhCZy95SlJnTWlWamJDUzRC?=
 =?utf-8?B?ZGRaTW11TU5NbTRvL3JFNUZwRFBoMUtrbTRTT045azYyYldSUnN6U2w4MXNK?=
 =?utf-8?B?akM4ZWE3RlZObjN3RlMybUQ2RC9pWXdPVnJhRXJ0cjdjNFFoUlljZWg5RC8v?=
 =?utf-8?B?SkQvWEdpcDR1U0syY2ZHR2M4TDFpVnZ3T0xBOHJ0Z3dQZ1dUUFN1NUQydXc5?=
 =?utf-8?B?dlBzcFpQZEV2MWJXbDAwTUZCZVlMb0dZeUhtSmx0L3FrODAvb1dzTFA4anNy?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4263A32E97DEF4798DCE96DBC1D031E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TVkf2aZhmxBZZJANQKTPvATZfYbBVP/UDpe1jtS04/dkZs3wIbJid83WkBFoYSBh9b05kQOTGbE/GXgdmwZZCItCDTPtHbuOi/688OXyIV77Tvsd/KzbG9Gn9hyVq4CfCtuYIyMVlfJKZ1XjhlgYBFvejTvuge60X1BOLCs7FbX990BCV1hbbhkYSMrmA93QDDe+rhPjLXz63cqHasf3WFdLljahKCXMivR2nMWlnj/qD6atB5V6xwAR2UdAmYTej3khoba/s36d92rzh69UGwzXk+V85+cPUS5D/lDmGaj9361E3p4li4Ctxq9BFzaRklixOVK+oTyHH/u25//mBz3hSaOem0JNLRsYD2ilsjmq07n20x7WMnnkM9ZB+69Rlens4gsD+KKLH4aAHjo+1MRmYMy+fGfj+YLTt8Q5W87Ib7Ef4t9N0ke+RhG7QcUItIQSowfWv3mafctHCLQvNNubqdrPwVv3l4XWWhtP0+qy+88vUv7HD8ba8KLkTISKyJhiiiHoJGQPa7pDsSuGSQWUBzKO+obbkWv9mKtn6cyVjv7H5B0Zgf+fmardQulu7Xme7cjEsuAL02T1xJpkytt9Rs1sSOo7vVV0/+LpUI5B/tiTlxBETueSp61nv8nz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcafe20e-6f29-46a5-7672-08dd31581559
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 09:20:54.1413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZW4lkf3/CwqPnBfgNPNIOwC54DuLU7FABe0G8XpBx1YFOQJxm96CZPI/HeoLXLnkUfkKeO9xCFEhlDfOcfIXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5695
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDEwLzAxLzIwMjUgMTM6MjksIEl0YXJ1IEtpdGF5YW1hIHdyb3RlOg0KPiBIaSwNCj4g
SXMgYW55Ym9keSB3b3JraW5nIG9uIHRoZSBDWEwgZW11bGF0aW9uIG9uIGFhcmNoNjQ/DQoNCkkn
bSBub3QgY3VycmVudGx5IHdvcmtpbmcgb24gdGhlIENYTCBlbXVsYXRpb24gb24gYWFyY2g2NC4N
Cg0KSG93ZXZlciwgSUlSQyB0aGUgQ1hMIG1haW50YWluZXIncyB0cmVlIHNob3VsZCB3b3JrLg0K
aHR0cHM6Ly9naXRsYWIuY29tL2ppYzIzL3FlbXUvDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4g
SWYgdGhlcmXigJlzIGEgV0lQIGJyYW5jaCwgYSBwb2ludGVyIHdvdWxkIGJlIGFwcHJlY2lhdGVk
Lg0KPiANCj4gSXRhcnUu

