Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8639FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiFP-0001yl-HD; Thu, 27 Jun 2024 02:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMiFN-0001yT-7C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:04:41 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMiFL-00025q-6B
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719468280; x=1751004280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ln8mMxjgrKo7M0uR48905CtJOv4LM0cdREagL6+Fmfg=;
 b=EQKy/b/Me6FvK56JDORHJUiEQgw5UwunuZF7jhXROubqPg5nKzIUs8Ce
 hXpowWAsS/bChsViswE4g8BNEpxkG+9SYLbVMk2TS4MaR+r6lM8abukDe
 VbB8Agqrk1BM8OFUse+F8ExR6jsVzI8ncmarWjUsZENBnlZ8f1NqfZCqZ
 0692FwMkZ91QlMmujuRP7+7Lyafr5YsXDb3pRUJ2/YuEcE+Up9rEck2fq
 gFzw4BBoUKINPMFrS+9euHbngke8O1HA4GEt4wodBb/YgFSeTSIAWGiIN
 1aMvvPkZXG4Vcq9JVwi96xAmiOxHmLXi+HRAszKpoZgmHaKMQAYay1qM+ g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="123503859"
X-IronPort-AV: E=Sophos;i="6.08,269,1712588400"; d="scan'208";a="123503859"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 15:04:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg533Ms0Aj/DTalgQW15yICpQZTEPKhqT6g8ITVXYgOfrJOMZmnAS4Kq8uxT2UMEzr0EZ4eZp7dp5naqCOinBsw1nqgBSelheIcGC3Ap/RA9Ob0rmLh/ueWGBkCZusShoH3HimIpoNj090udvE51+hN/7GrWXIfp9ftVKGHevefbDuPfru8suDSRa1UD9RiV+lnzGVVWYPaAMu12ZB2wWo0Qeumwhrc9zwINpgKQntBr0jNdp/QF6CJdSsYFGvCHHWRJYFVmiAkSjc+mUpgjeVqkp7ULxPaCiGmDUtl+0sPxLzkeW0bPQmA70yQrTbD3gPNfG0KAUzDwh0qiU68/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln8mMxjgrKo7M0uR48905CtJOv4LM0cdREagL6+Fmfg=;
 b=ZAgSbLLO8FZC6G/P/L72se4PIbeFfdFdv3JXN2X9B+nEmZd9qEwbmcJK4Dq/CuyL8loESnoh5LYDQo6kl5HzaksZ1IORwKDkPOFM1vaF1VpO36Zb7tGm1fbrty8ON4TD+cR+N7pj48TQ4rZ1IL3PhI4Rnx9noOhNiSoz/ovD2GuHDMUEulVjLtvemCVUO7GHBuelO1RExcjrO01XL3klAtkHXdAUcEnCmQS7Yvi7VBr4UCSNmiimGdBPmi1pNMmaIBFd5/g5rFbeDM095ZmzezE62M2e1QfTKwTeM4HWuUsR+Xn9GZOMd2mgjL3zpACCRLJzTd95ViSpePpCRaWfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB6195.jpnprd01.prod.outlook.com (2603:1096:604:f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 06:04:31 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 06:04:31 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
Subject: RE: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Topic: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Index: AQHayCIsi4GywkD2VES3ue7CW0mN/bHa75hAgAAmBgCAAAhTkA==
Date: Thu, 27 Jun 2024 06:04:30 +0000
Message-ID: <OSZPR01MB645303F9F5E92FD3384D4E8A8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-7-pierrick.bouvier@linaro.org>
 <OSZPR01MB6453C257EED6AFD784FFFCDB8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <b34d0699-42cc-405c-a511-e58445bc362d@linaro.org>
In-Reply-To: <b34d0699-42cc-405c-a511-e58445bc362d@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OWFiODRjZGQtZTdlZC00MWU5LWEzNGUtNzEwOWU4NDEy?=
 =?utf-8?B?ZDg3O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA2LTI3VDA1OjU5OjA2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB6195:EE_
x-ms-office365-filtering-correlation-id: c765b94b-4d33-493b-5e67-08dc966f02ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?VmxBK2RETlNYN1pJY2ZHN2I4cmNZdkFTODNVUzF5L0IzMHpRci9HOTVRemJX?=
 =?utf-8?B?WThiNGFzTGJMRlFNVUJVRHlOcmhGdEpCMS90eDlIaGs1S3RpRTdGdnRNQkJL?=
 =?utf-8?B?bEtWaXhaOWU0eU5hQWpHSTNYamEzRTgxV244WUZLL2lHSStBbXhSdnFQUkFp?=
 =?utf-8?B?VTRKYlJ4RTM3dmpBQ1ZlNm1KSlJsMnNzMy9tZXNOMHYzQ0JGMnZXZGZjTDlI?=
 =?utf-8?B?OEM4cUJTSUJlM25WL09QcTYrMFROM0x6a3g3TDdXZUZ0TUhDV3k3SUx3cGZ5?=
 =?utf-8?B?YnE4UWoydVBEQlNDRVpmRjZUSm93Zk5Pb3JqYzFNL2Q4NmkzQURQNUhHNU1W?=
 =?utf-8?B?ZVRLQTgzRmhJTjhRTzE1cmFZNFY5NkpZZEJOV2NMRUMweHhNMk5RcWVyRTI4?=
 =?utf-8?B?aXV4WkpsTGd3amhxR1A2cjllMG9uUzRReDlicGtMazZhdE8yM1Q4Rm8zd2F6?=
 =?utf-8?B?S09STm9XeXhDMWVIeGJ3c2xpMThlRkJiSUlRVDE1NHpiZHU5RzB5TGJkeXQ1?=
 =?utf-8?B?Tk40KzE1Y3czSnRpR1Yzc3hqYXBMQVdVNXg2SUlWa25ZZUNZemVnNDJJbFJP?=
 =?utf-8?B?UXMwT3Nydk4wbXZPWlB4ZkZJdnltQW9VUmVDcHJCeU12djRMNUxFWjZJeVhK?=
 =?utf-8?B?d3VZamppY294YlR4NFgyRlR5UysyZ2xPZEFIYlYzMnIxTThZb0ZnWE5BTExs?=
 =?utf-8?B?M1hOVHE4K0kxdmRMSFVidG1xVWhnU1dPSlV6M1V5WkkvbTkrak5FSFlZSXEv?=
 =?utf-8?B?TkIrNi9NYnY4Y3ZIU2I1Z3M4bHMyc1FQb0R5ZEJ4OEFBdlNqbm4xb3JzTTUz?=
 =?utf-8?B?ZDVZU2lmcjZZK3NYWXVCMHk4cUtuOWg5OUZVRldiWU1VTGJKdFBzeFZJZWky?=
 =?utf-8?B?WExNb0NUY3YyZFZ0U0hFK2RmUHJnSFhWUmVZd0dCUjBNcHpTOGZWYlhWd2p4?=
 =?utf-8?B?aVdpNENaSThKNnpKeXRmMVArWFpoQk5maGY1bldCdDU0dExrZmlURFQ4dFR2?=
 =?utf-8?B?aW5LR0tEUWxYZFVkb2l2Ly9WYnRZemhzS3pLd3pEbkFHejB5dTFvalVCY3pp?=
 =?utf-8?B?OW1DVzE0OVpYcVhKNlJTenpMcFRhM0w2UzZ0bjhSQThsTDkxMi9hbDdvMGt4?=
 =?utf-8?B?V2MxMFNWNllhU2M2c2NlYmVxZ2JKeVJ6MEVUalQzcUQvWVhQaGQzUENYTWhh?=
 =?utf-8?B?WUFHRUxnU0pnb0MrK1dIS1dRNDd3Y041R0pOcGZUQ1BteXlkOEpPazdxRUx4?=
 =?utf-8?B?ZEFlVUxJdGIwK0NBTmJGWG1yTnN0NmRPdnJMQTdqcUlpeGRYcjczOVY1ZWwv?=
 =?utf-8?B?akxwMVdvVmNFL1FNT04yRXdoeXN6NFROK091ZHVWQ3QvVG93VTQrWjR6QUVC?=
 =?utf-8?B?dUxCYUp6bnRhQ2JsNW5RWEs3Q3JoNHBObU9Ybk8vRnQ4N3FwdlRtZGcwbHFi?=
 =?utf-8?B?dFdndWJFZ3F5TkVrYTMvTmRkSTg3NG44NmRnelBxOW9Xa0hJbnoyT3JzcGxk?=
 =?utf-8?B?R1FyelZGdFJsRXQrdTBnZ3lUcHNZR2Y1c1dqUktvYkVtaVdMYWk2NWtSSUY1?=
 =?utf-8?B?MW10YzZrZjlNSk9pQ1oxOVhKQ1VVVjNpME9GczNldVdCZVpkYVk0QWFHa21R?=
 =?utf-8?B?YUdXSXJSKzRyL0VsQ1QxWUVsY2J5KzBiQnVZM1NJZjhDQVQ3OUI1VUF5Nm1w?=
 =?utf-8?B?ZjhPYzN0ekk2cVVYaEJqZWJremFZRkc1QkRJWlZtZHF1NkJtZlZKM3EzMnY2?=
 =?utf-8?B?eG0zeWRYSm1waUlJNmVaUWcwUTB2ZWZPMTgzVkxpajhISjhuRGJhZU5BNEk2?=
 =?utf-8?B?eTAwd3l3ekhCeFFjanNvT3VBQ095Lys0OWVBSDhYRHltUWQreW5naGFmcERh?=
 =?utf-8?B?NUUxYSszSzYyTnpodUVSVDhZbGhsSGY2aFc1dFdLRUE1ZkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXhxVVE2bkQrYVpKMFVUVWRtSGV3Y3I0eFRYTUtHcFBhenk4UktvNlZlV1ll?=
 =?utf-8?B?S3NFcUpBeWFFQ0JkVlN4bTRRZjZ2b1d1VnVKY1NxMHN0V2FzNkxTeVp0K3VW?=
 =?utf-8?B?amZsZ0UraytxVFFoWUdmYktJZTNMMWszME5xVjBHMUR0dHU5bEZkNFRUQjgx?=
 =?utf-8?B?STR4bURFSlVCRk5YWjZXNDM1UEtWcnNQZjh2R3R4cUxGck04bExiMnI0R0Ro?=
 =?utf-8?B?WWNpaXdiY3RuRHlLSk41RzYrZ0g2V2VlVGpzVkVLYVJOUEkrMUt0UEpZdTll?=
 =?utf-8?B?RXNiT3N2UW5EZlhrRVh4cDVUWEVQVGNhcDhKNFhYVmRwOFA5ZEVHcjdrNElX?=
 =?utf-8?B?YURJdGRCbTVTOXpMMjgxQTRLMzBBNUwrbFpUN1phWjV3aXRLUTNkN0JhQUQ2?=
 =?utf-8?B?bE0zeGJLSXVSMHZrdWl4VE1hWEFoczNpZVIzcFRKUnJrbVpKMEw0dDhEckYy?=
 =?utf-8?B?V3lac1VFL1hNeDFscUVVUWFvQ0FwdGVOQXJEcGIzMDVyOUNoLzNFZGZmKytO?=
 =?utf-8?B?bXJvMUd1OUFsU1hJeTBYbHRyRVNNWmZFRGNUL1B0d2hmeGtLS3NoQ0w3aVVI?=
 =?utf-8?B?ZE5XL3VyakdHZmQrd3dGaTVYZ3JwTWhnM01VRVdQMUZ6QjIrWmFtOFkzVFhW?=
 =?utf-8?B?WUhBQjJQMU5GOC9lUUMzMXY5NXNpTncxTWR5bkVOWnFlLzM2b1hsOENRVCti?=
 =?utf-8?B?aHB4citVa1B0NVZtaXFXVzZwVXBpQ0NzSlBrSUJ0M3FXRnRVM2VBTE9qZitn?=
 =?utf-8?B?SUdIZVNaUTloYVRtSi8reVZOUnl6eXlZNjduK1ROSEdBbzloT2xqaVo2d1Vr?=
 =?utf-8?B?UEVUaWh5bDFrcG1IVWFveklRd1l4YnVIMWh1aVE0Sld6NkM3cVJiUFlrazRh?=
 =?utf-8?B?dXN6WlQwSVBldndGejU1WDFNbm53UXFIOVN6K0dNbC9hcmRoSTdtRkt1eGZP?=
 =?utf-8?B?aGlLQ1M1QkZseEFQZFZVSUluNFJHbWJQL2cvR0JtL21PMHF0MCtWRlRJQUpq?=
 =?utf-8?B?cEc5L0VjSDlZV1pVSUc3VFZmcUtrcVljM0VUekJsVXZxd1AxV1JvOXBFdGV5?=
 =?utf-8?B?b2dzbk5EUWpNYVNZQThubXRaQk1hSTZmWlVaeDZOOEZkQzhMWVcwQzRwVGt1?=
 =?utf-8?B?MDZIVkFBNThJRzNXcmE0OXIvcDczbEpCVkhnN3N0Zlo3QXBWcXJtR3gyQWN3?=
 =?utf-8?B?VW53dmxiM0ExZk92eWEyT0l6cXpnQ1pGTzhHbHRBNFZWZXMxTVJWaERQWmox?=
 =?utf-8?B?K0RGNVY0anJTOHBkN3VWWjUzaVFpbVNSdE14TWdsd203RDhMcDkrTDR2RUxX?=
 =?utf-8?B?cSszR1o0R3ZoL0NGZ3U1U1NLSUFTRk1iNDBRRDJZb2FXSU12cndFZEJ5SGow?=
 =?utf-8?B?QlpobmRRUDFEQUNiWkVGdmpjb01Xci9MYzFpak9rTlpLc2w0dnIzOXQ2Q00z?=
 =?utf-8?B?K3ducXVJRTEyak9NNjJpSllLbFIzcnF5c3VZR2NLRk1HWW1ZU0c1N0tFWGVq?=
 =?utf-8?B?YjRFUG1MN0diV1dySWlOS3d5Q2N6R29nQkNVbzdudE5Kemo2SlJNQ2E2eUVw?=
 =?utf-8?B?UzdIRWk2aHVscEVWMnM2NEpRUlB5b0NsQWxCUi93SnBNc2lzTXQzWGRaSlBJ?=
 =?utf-8?B?M1g5eXlmRUtQc2lEUlEvcHFjQXhNbCtuK216S3VXdnAwdHlkeGF1RWhqNDBz?=
 =?utf-8?B?aWJvM0xBNGVUVC8xNDhNUlpKdE5ZR3d4V1dLZXZxcVlHSEJtdkhGdnYvK1Ba?=
 =?utf-8?B?MTVUMUdtUXpiMUFWNit1a0RlQ21tY0tLSXJoMTlsc3ZYd3dkdXA0ekllbmtt?=
 =?utf-8?B?LzlMQmVZc2l6dmVjVUhTYW8rclNJZ0l6MTl4VnZHdTI5WHl5RStWaEtiSTZn?=
 =?utf-8?B?cStvRUR3dFlYNmcxSHBtTlR0RTlYQmJBUzFRZDdxeldUT2ttL1NjSWxuTUFu?=
 =?utf-8?B?UFVsVDFuTnI5L3Q4TTQvQzVEZ3AxVTJ1amRtTWlaWm9HOXhmV0RHQmE5UWxl?=
 =?utf-8?B?WEdFank3VEFId3pYV05za2FETk1qQzladWFtZytuUzZPRXVmZ0xHZFlMNFFJ?=
 =?utf-8?B?MC8vSkFYaEZPendBUXZlQ2FlemJjbnhCY1VmQ1dWcnJYM1d1Sm1Sdy9pZ2lj?=
 =?utf-8?Q?OrSWyI0FuzUVYQgT9VWe2sTas?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JsDK7gtwFBuZ1q8S1Fh7U3vVsfjOWrRrMkdbTo3jg70zITMPzgWmdIK04N3lyYOpe/BuZNGmKmhRJ4iYsytQDRVnfbAT+Qs/gxF26fboBh9J8siycakXQSh9dYNVvyQ00WMvs8caY+II/J8CErQ7mps1Fymn2mN+rScov79Vr0Klcz3dN5RKSl/ktJg3H5TkIQ2WqexJ1GNBsF2zoPEYuUe9wj/+5AfQ7DKEBRsPVo7ioqxsqYxcsYwgN8JJNdHYTeGNz+eTlPrRg1PbGz9ATeKy2Hp2xo4f1HE3HXeB8GWb5+1bdmaG2uJfMcD9FNIvm8QjkyhPzEfYOZf5nfE25T6/PCLWHvR136ge/Axwigb/r1kQva00tgJpQz30QiEWN3lrT8H8IA1BW7ZL0mw3Sfg6OnTFEntf0zdHWWVxsgxOg9L9RglQxBEp1FowoX1z/dAVk1dHq6fUzU8ofAYg3sNDpD9nXCPigSnKe8UC9PnIZ8lkkh/+b4b40gsJ9nBbDggROHTl8cA4Hj6YgnJdZImAj1A91jNzjoARt+K/ri4GAzbDKj6gLzH7ZfyveafrZ6REqYpOIHhYfIYrU2dooMT8L4uRkErLtVC1T/4zyzmRXFmhMTcwE++Rv9YIAUnM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c765b94b-4d33-493b-5e67-08dc966f02ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 06:04:31.0200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGZIdCplBxuHOJG2Q1iemSD7g0/9Jw0lCS23TkI+HfwHe08yVbU+7LiukNYhxVGaQLivynNAIVzbt+lKZ/8XBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6195
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAy
NywgMjAyNCAxOjI5IFBNDQo+IFRvOiBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2myA8eWFveHQuZm5z
dEBmdWppdHN1LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQWxleGFuZHJlIElv
b3NzIDxlcmRuYXhlQGNyYW5zLm9yZz47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGls
bWRAbGluYXJvLm9yZz47IE1haG1vdWQgTWFuZG91ciA8bWEubWFuZG91cnJAZ21haWwuY29tPjsg
UGFvbG8NCj4gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IEVkdWFyZG8gSGFia29zdCA8
ZWR1YXJkb0BoYWJrb3N0Lm5ldD47DQo+IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnPjsgQWxleCBCZW5uw6llDQo+IDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDYvN10gdGVzdHMvcGx1Z2luL21lbTogYWRkIG9w
dGlvbiB0byBwcmludCBtZW1vcnkNCj4gYWNjZXNzZXMNCj4gDQo+IEhpIFhpbmd0YW8sDQo+IA0K
PiBPbiA2LzI2LzI0IDIwOjE3LCBYaW5ndGFvIFlhbyAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gSGks
IFBpZXJyaWNrDQo+ID4NCj4gPj4gK3N0YXRpYyB2b2lkIHByaW50X2FjY2Vzcyh1bnNpZ25lZCBp
bnQgY3B1X2luZGV4LCBxZW11X3BsdWdpbl9tZW1pbmZvX3QNCj4gPj4gbWVtaW5mbywNCj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWRkciwgdm9pZCAqdWRhdGEpDQo+
ID4+ICt7DQo+ID4+ICsgICAgdW5zaWduZWQgc2l6ZSA9IDggPDwgcWVtdV9wbHVnaW5fbWVtX3Np
emVfc2hpZnQobWVtaW5mbyk7DQo+ID4+ICsgICAgY29uc3QgY2hhciAqdHlwZSA9IHFlbXVfcGx1
Z2luX21lbV9pc19zdG9yZShtZW1pbmZvKSA/ICJzdG9yZSIgOg0KPiAibG9hZCI7DQo+ID4+ICsg
ICAgdWludDY0X3QgdXBwZXIgPSBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlX3VwcGVyX2JpdHMo
bWVtaW5mbyk7DQo+ID4+ICsgICAgdWludDY0X3QgbG93ZXIgPSBxZW11X3BsdWdpbl9tZW1fZ2V0
X3ZhbHVlX2xvd2VyX2JpdHMobWVtaW5mbyk7DQo+ID4+ICsgICAgY29uc3QgY2hhciAqc3ltID0g
dWRhdGEgPyB1ZGF0YSA6ICIiOw0KPiA+PiArICAgIGdfYXV0b3B0cihHU3RyaW5nKSBvdXQgPSBn
X3N0cmluZ19uZXcoIiIpOw0KPiA+PiArICAgIGdfc3RyaW5nX3ByaW50ZihvdXQsICJhY2Nlc3M6
IDB4JS4wIlBSSXg2NCIlIlBSSXg2NCIsJWQsJXMsJXNcbiIsDQo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgIHVwcGVyLCBsb3dlciwgc2l6ZSwgdHlwZSwgc3ltKTsNCj4gPj4gKyAgICBxZW11X3Bs
dWdpbl9vdXRzKG91dC0+c3RyKTsNCj4gPj4gK30NCj4gPiBJIHRoaW5rIGl0IG1heSBiZSBoZWxw
ZnVsIHRvIG91dHB1dCB0aGUgR1ZBIGFuZCBHUEEsIGNhbiB5b3UgYXBwZW5kIHRoZXNlDQo+IGlu
Zm9ybWF0aW9uPw0KPiA+DQo+IA0KPiBZb3UgbWVhbiB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBhZGRy
ZXNzZXM/DQpZZXMuIGN1cnJlbnRseSB3ZSBvbmx5IGtub3duIHRoZSBtZW1vcnkgdmFsdWUsIGFw
cGVuZGluZyB0aGVzZSBpbmZvIG1heSBoZWxwIHVzIHRvIHRyYWNlIHRoZSANCm1lbW9yeSBhY2Nl
c3MuDQoNCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gPiBYaW5ndGFvDQo=

