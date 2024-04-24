Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D4AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 01:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzRZQ-0006n4-RG; Tue, 23 Apr 2024 21:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rzRZP-0006ml-9Q
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 21:37:11 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rzRZK-0008Np-4n
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 21:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1713922626; x=1745458626;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3PzX3wNXrALaceMqp8ah0pTW1aW2CRWEDHNkJHne7/o=;
 b=exhGWdPO7iotyJ6nYfiyd1K36ccsXidubvCtvYRsdA1wQVvx7lGc5Tuz
 zFa0d36WA42CkL1FPzJk6tlBzHGR88cU5cee3NvVya0rsfWVIra3JRluz
 x9uoy3Zt1+s39QW+kMadJlng/6ciPQB1uzPuiBFs4lVTlr/2rE5nK1mHb
 FSgd+dWNI/bK3jQW0yucg6E1N/IWcYnZj/Qa/Xl7/AftSYSIpnl6oxi4H
 +2QEsxMKQmwiDw22B3VvTHxuF9lhUmr2V1vRuJR0hbtfdQ7QBpbJKFF+g
 0LQkrOyDAJmaQvgHsV0fatX7tZ1KYD2R52bbVh6BRQqMFZoXCC5WWTFMg Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="117545274"
X-IronPort-AV: E=Sophos;i="6.07,222,1708354800"; d="scan'208";a="117545274"
Received: from mail-japanwestazlp17011004.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.4])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 10:37:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHayr/rHfiAkGSBwlMYljDgvabepDcURFmTotVltZlqKLoZ6BwQWvW4l83w8SOkbH8pWNYLdTbdgbFKDfeuy20YgzRKnnWCOq7FR+hr0iXcpMtu4mXlKVDiKYudrkkrbPoZkAcmE1flFuzgXQvQVnjfmahh5DTxSLXaVZ3rpbE8sm63Gn7tCRJHVAf18apmUrBWVXnUwty7xBqFh35Q5Hn6Oh4lxdeEKp6fL5hd3ewfkGWI3s82I08vvvU80bcNpIXCOdb3Y2pZjUvcixPeHbIP85q4qhQnxGCNfwDslOsVbGFs0C2YZW7De/Wqmu34D7VPb/ybM4RZU60SNnQxApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAmfW8EpDrG5rNJn1l0I556AJIgK4hjB9yycNhzL97I=;
 b=QRJh5KX85k87pD2zVzST9HzmZjL8qeYjYVpdUxhDCLfX8GK132k6ZRtY+1oEoigdMVSr+h19qM6g59ReQGMi9HD4/XnjMhRCFfpo/eu+OV90tUKqJRtIZ4riooCvi7zGBZgqngvJicsL3rYuaNe/33wB/4FByXU48VWIHyFlSJFcG8C2rVzNwqGYjjhs0yS1pYWkIDz5X/XoWw3p+9VY9b+2A4b4iJndcdjahC6IphZMsTQ6xzfjS4wzBgcUcEfDQHlF+DAaaaQVCw7mOURPqdANYno2jI27oHuHEkBaPbJWTgGJvgAJrODNiQ+2prId7xcCSWDuylrFdw9Mke+bHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB7455.jpnprd01.prod.outlook.com (2603:1096:604:14d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 01:36:56 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:36:56 +0000
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaiJjASti3D6SWj0SM7FILST9OMrF2vnZA
Date: Wed, 24 Apr 2024 01:36:56 +0000
Message-ID: <OSZPR01MB6453EAAAA6C5CDCF87422A588D102@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=42eb8e4e-8391-4a7b-8989-fe1b785fc6be;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-24T01:36:34Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB7455:EE_
x-ms-office365-filtering-correlation-id: dce788a0-a146-48c3-64e6-08dc63ff0724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|38070700009|1580799018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?UXY4b25PQktzZCtDVjArdWMrUDZRVVU5QnFSTmc4Yi9OL1owVHY2Rlk0?=
 =?iso-2022-jp?B?VlZjM1I4QXZha2FCZ2grRStvYXRKb01YR040Q2hLV3BPUWpWblpFQVl1?=
 =?iso-2022-jp?B?RFYyRkFTWUJzajZMemFqRkVpc1h2ZDFHcmpTVXF6ak9yb21jRHhDb2xq?=
 =?iso-2022-jp?B?NnJ3aGpPUGViYzQvdFB5eU94aTl6T0Q1elMxUXhRK0JaVGlFRTNyQkdS?=
 =?iso-2022-jp?B?bm9CYUIrbElEYnYySk4xdElEdGFzQXFJSW5tNUYxK0pJV1ZxQ3lyQmg2?=
 =?iso-2022-jp?B?bUtJU0Q4VFI3a1ZJekl1NWdBMi9pRWtqZjdxRjhyZjVUSlBLcTF4eDZD?=
 =?iso-2022-jp?B?eXpmWExsbTZzMjZvU2RXZlRGZkcvb2pPUzRXMmM1aDhXRUQxdDhrWXVV?=
 =?iso-2022-jp?B?eEZEU0NxRUt2eG51d21CT3YzTTNaVWVOUVUvOGYrWG9VNkwyTmt6WGlo?=
 =?iso-2022-jp?B?eXhpYm41WG5WNGM4SXpUQ09ma0RBOGY5K2hPdUFPdXNSQVdpN0V5d056?=
 =?iso-2022-jp?B?YjR2NEFZZnFzdnNLdFo1YitmUmNFcnR1enJiem53OVV2Rk1GMlhpK3pn?=
 =?iso-2022-jp?B?NTVRZWdpSDNGc2kvWGFlSWFVUkRWVi9WWG1Cc01pcHNxb0dpbXltVTVt?=
 =?iso-2022-jp?B?cG1FUUttdVhkU25SVGxNZWd6WjR3WWErUWF4S1JBdlZVaDlUWWIzL0Er?=
 =?iso-2022-jp?B?ZXN3dDkwRWV1cGdjdVRsekZkanNGcktUVXpBVGlrV0lPM0RBSGVVRUpB?=
 =?iso-2022-jp?B?YjdTejFlaGlKL2JoWmlpenNsdlcyZ1ZVU3Z0TmpZNWVDSzYyb003a0Y2?=
 =?iso-2022-jp?B?RkRPN3lsMWlBODBrZWVKRVh1UDgxUzk4QmpHa0xPcWVtbU9WaXpuVHZi?=
 =?iso-2022-jp?B?YkYzSU1UcWhibHpLQ1k2V056RHhhN3Yvdkt5bnpCd1hNaS9obVp6VUw5?=
 =?iso-2022-jp?B?SVoyVkx6bFZTS29BcnlRdytLOEJNWFp5SG8wYk9raHFod05iNStIWTJ6?=
 =?iso-2022-jp?B?RkpkSXpkZk9ENm1rMVV1Vk5ydEMrQ1NiN1VUSGx0bXhxNEV1WWN2MDBy?=
 =?iso-2022-jp?B?MUxOb1hVVmQ4dkpld1UyT042cnhjMDZtM0lrOVRaRkxzRzY1bGlaYVI1?=
 =?iso-2022-jp?B?REdYYyttWkRzM0J0RUZtWk5KRnA1VjRlVTU2eG9Sd2YyK3Z4bWc1N1Zq?=
 =?iso-2022-jp?B?NHFaVkdwUk9SS0VOUzBXZkxDdkJraVA5SmhsT2ptRWlxQVg3VVduVVNk?=
 =?iso-2022-jp?B?NThac1V4SWZLR3BndGZnVjJlckYvb2I2V296aHpMMGJ3Tk4wTHVqaHBT?=
 =?iso-2022-jp?B?TExDc0NPTTczazB6NzNlT093L2tDbTBwOVJWaDV2U2JZY1I0QWF1L2Fx?=
 =?iso-2022-jp?B?ZVBxSCtrd015V0o2RDNvaDZhSFVLL1pmaU1iTE9sbkY1RlR4T1ViWS9N?=
 =?iso-2022-jp?B?dWJsblpXMlVmQXRya2J5ZXFTZndKMkp3ZTJhSGtQS3lvV2pnK3VzaDRa?=
 =?iso-2022-jp?B?WDRabGR4Yi9TNzZ5RWpLVzBnTXh5TE9yUDhlOHhxZWhpN1owalUxS3p2?=
 =?iso-2022-jp?B?b0ZjQ05qT1lNMEZNb2tyWVhmM000czJiUTI1NUVkSURXTEVjRTdya1JG?=
 =?iso-2022-jp?B?bXIrc3FRakl4UzlhVllXZ2dkOWM3RjcxdEVVOU5XamhYVW11bkdWT1VW?=
 =?iso-2022-jp?B?bWdTOWkxY28rRmwrbWNBTE4vQzBkbTcyT3BNQ0ZJcTk1a2xhUG05WnVv?=
 =?iso-2022-jp?B?UE5PN1I2Uk5iTTZDdW82RXVTaHNSR1ZYTWdNUWlkeWZHUzdreUhBTTFQ?=
 =?iso-2022-jp?B?cXViYzltdXA2SkFvYWVxbnh1Zmt0Wmdvb2p4emtWekptK0p0d0U1b2R0?=
 =?iso-2022-jp?B?Qzdmeml2SHY5OHhTVE05UFRodmxZVkpNSHJ2SW9MQnJmKzNEV3ZVZDhU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?c1V6L1FkYXZ4azAzRjg4RE9NdE9LMlV4KzFmY3Y1ZmlqbnRocXpQMTBN?=
 =?iso-2022-jp?B?d1JCaFh1dFpEaFU4MVF6THcwUmlWL1VXUVM0VFAweFpZSFVTenZJQTN0?=
 =?iso-2022-jp?B?Y2hraHEzUkVSSHg4U1ZPZTNVcHBIeGx6TXNLekZuOVdGU1RpT3Z3am4v?=
 =?iso-2022-jp?B?MlJjUC9IbEhpRWd2b3VibjNwWEFrNHQrWFpRRGNsNzJEelhZUG9BbUVk?=
 =?iso-2022-jp?B?SEszY2xKR1dsM1ZvVk5LN0tUZjhBSGpiTEU4eC9yeG9FYlRab2dzU25n?=
 =?iso-2022-jp?B?VmUrYVpOMFJwZzZiTGFKdmQ3WE1KOWp0YkE3WFhOZmhwWkZNdmt1b3F5?=
 =?iso-2022-jp?B?L05pTS9DbXd3cDREeExpUzB2TnVrMU1wNkk2Rkk0T05IMUVVLzBpanZw?=
 =?iso-2022-jp?B?Ky94UnFBRXZLMjdCOFYyOGNnS3BSVnNwWlZvWGFZUko4YnVOS1JVZjdH?=
 =?iso-2022-jp?B?UmxwcFU3WVFVT0dMRWV1UC9LSlZBOEFlaTRxWHJDRmVZZjdjRjJnZ1pE?=
 =?iso-2022-jp?B?OGZWcU9xRERDYUxZL2wwZ2FwazA0MVNzVHJ0d0hva2pEazRvblRYTVVM?=
 =?iso-2022-jp?B?TFl0M2VTeGFkQ3IrWUhmZjZMTUJTRDBsTG5DUEpuZ0hUb2ZnRnJZRkdJ?=
 =?iso-2022-jp?B?WGg4Kzd4N3RLaTFJb0FKdVBHb0FhRlJMWmlBTHJ6NkxJUWlzTFBXaVlJ?=
 =?iso-2022-jp?B?eHdqekI4VXRrU1ZzRi9NN2dpQUFKbkNUTUluQXBNMWt5TG9xekpPZmdl?=
 =?iso-2022-jp?B?TUZMSUYxc1djK2duczQwRUdaYjYvZ3NFbXR6SHRUTjRVdUNUVmJFL0pv?=
 =?iso-2022-jp?B?ZDUxUWc4NVMzSVZUK2VvRnVHZnBVQmluWU1sdWpEOHlNWG9VL0hxMXlO?=
 =?iso-2022-jp?B?anRSNzQ5a3dyZy90M1M3Y096THV5MDJ4b2MydXM5WlpnR1Y2Q1JXaEJt?=
 =?iso-2022-jp?B?OVY4NlZzKy9uaVZwU3h5WDBJMFptd2M3Ly9COGYvM1pUV3pnNE0rcVY4?=
 =?iso-2022-jp?B?ZExpbjRuaXFjOHNjUzREbG5FS0JZUFhTUWZoM2pRMS94R3ZndkYxYW5W?=
 =?iso-2022-jp?B?L1VUUG5oYXZUcG9teHcxbUhFY21rSmcwUkhPUHNXMnNzNGdrWTFxVmJo?=
 =?iso-2022-jp?B?OXpIWVNMSENCbDRNSUlaeWNKUmk2Z2YxYjNlQjh1ckJpN2VUZTJlSTJz?=
 =?iso-2022-jp?B?VU1aajlqU2tscXduWmVDdkVMZjZUUmN1L3hKZDVycnJxanY2RUtpM280?=
 =?iso-2022-jp?B?SmZYb0tpZkpHZFlJTjhYcVMwUE1raW1wbFpaMXNNL0ZDOGE2QWcxRjkz?=
 =?iso-2022-jp?B?NWhYclc4Y0ZhQ0pEWUlLZUMzc3drNkZIb1V2dGdaSENGRFREQTBuN0U4?=
 =?iso-2022-jp?B?V1NGSWJ4aVVUSFp4bThKSkdLNHE0U2djMytFL2l3RkdnUTdRU2VWU3hr?=
 =?iso-2022-jp?B?RDVzK0ZwMEZBdFRCRWdHRnRSdE1DTnN4R0FoeEJGRE5tZ3dpUWNtZmc3?=
 =?iso-2022-jp?B?MUpFZHZwV0IyOTB2SklGOWtKQnQ3SjJtVFRtV2t5eTRNL2pHeW45OXFF?=
 =?iso-2022-jp?B?TFJuSE5KVmNNK3Fjem50elhKQWhoNFFtbVhOdE4vS2Y5YnEvbzZPR0xR?=
 =?iso-2022-jp?B?ZVBuc2FXVXRkNEJwV1pLVFdEekZ0NmRLS0dpNktqUFB3V1M3V2U3d0Qr?=
 =?iso-2022-jp?B?NGk4NU5HVDZTV00zMHUwZEdlcFA5eDU1dzRXcGhneEJ6L3BiSU1IcDNh?=
 =?iso-2022-jp?B?anQ0bmxJY0JlMzgyME5MWnhHOXlJaHpkMkxNd3ArUFI1blZQUE1XZWZV?=
 =?iso-2022-jp?B?d3dLL0hYN0NMaGtoTkhTdkJHSUttY25uM3VmWEZjV1F2ZmYxT2NuMHJ3?=
 =?iso-2022-jp?B?b1hnYmJpOS9ISU5xVHZSTjlQV2pXWU1ycXMwRVBYa0dZdGh1R0xPVmZN?=
 =?iso-2022-jp?B?cTVKL3VXV29XUkpJeDk2YnRVMGY5aUFyMHMySjRvbXB3OEkzbzZmTENm?=
 =?iso-2022-jp?B?MFhnKzBiQzBLdW9tWHhOYm5GT0lkTDUzU1dPSzU2YVlicmlFRktTaHFx?=
 =?iso-2022-jp?B?Q01MY051d0VrYkVlekN6eDRPZG13aTdFeW9VbTJ2VmdHVHFWd0ttQlRZ?=
 =?iso-2022-jp?B?aFVyMk1BWEpzQzRydWllMEsrcFpqWWRzNnoyRktacW5MNU5hSXB0cmpS?=
 =?iso-2022-jp?B?UEdsUTRtNEtLdG5lSDFNV2ZpS01iU2ZnTFltaTloSnZCeDE1UVEwWmp4?=
 =?iso-2022-jp?B?VitpNUl2SjdEY1FpeDBRTy84N2lrZkFEZDJuMFA1QmVMaHRXTzd1WWZi?=
 =?iso-2022-jp?B?OFo3cg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ibwLuTVzhtYyz2i0giTXwJrilExlSgig9Q/WMHCTxFIP/QZGtsI/qRFxRHaY8PYZdfG44EaD+9LjTKa/hI2nxc/ajAuNLfXG21vUVearuA6dQovi+u/PuVS1fES2bSPQCt+lDOZTZ29slekYHjmQk4jO80YijWTk8MHAeUc2iTqs64or3SrTso5iQv5GA/rw4oJ9DKUw8rj4lqxeDF9s0Mye2nDeYBAB0WgKot8EcgFg2O4ZRApgt0Je+Yz7IP+P6wPv+M7bPwlkWcoDgetlm9h2Wi1bkJ3sq2W0dJ7Py95qLjXb3kbxXRk1SG2cVyCiIW1QZXBV/5HU6p0V+dw9XL3A9ta+tUDdVuNrx3Ae3UNPvF3CnZQ5cMRlZW48clXzz2RuYJ1pJaApXh+mi4ItD0xvQOpn9EOQgOJU+vABrH1sBbFRnCJg8zLzFOPf7ff3lTqj6/qymXFjBpQL/HXisX+n2aWayyPbadsQndxFOQBkdnsy7YNfrg0wvtHVdbfOOgRTxwDuiMuPsUTdPBmirgMOTJihCq1AAzzO1GPv6zzJ+JBgQeFYFPQ/t9zspuh2JESx0XNYE6SRDBe3uRi61e283Xp+nmu4K2rrUDAPJMCNNfM5NbYlVUcm6NfU9LD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce788a0-a146-48c3-64e6-08dc63ff0724
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:36:56.6863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxEvvOCpLgeIx912xnK/sR104So0jRIdgKQBrVIUReGKWljs1v+Ee1tWuEEGWA01Arx97wU4wUToqZBIaH0E4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7455
Received-SPF: pass client-ip=216.71.158.65;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa20.fujitsucc.c3s2.iphmx.com
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

ping.

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Sunday, April 7, 2024 11:07 AM
> To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaox=
t.fnst@fujitsu.com>
> Subject: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave way=
s
>=20
> Since the kernel does not check the interleave capability, a
> 3-way, 6-way, 12-way or 16-way region can be create normally.
>=20
> Applications can access the memory of 16-way region normally because
> qemu can convert hpa to dpa correctly for the power of 2 interleave
> ways, after kernel implementing the check, this kind of region will
> not be created any more.
>=20
> For non power of 2 interleave ways, applications could not access the
> memory normally and may occur some unexpected behaviors, such as
> segmentation fault.
>=20
> So implements this feature is needed.
>=20
> Link:
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> u.com/
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b..d6ef784e96 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr
> host_addr, uint64_t *dpa)
>              continue;
>          }
>=20
> -        *dpa =3D dpa_base +
> -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offs=
et)
> -              >> iw));
> +        if (iw < 8) {
> +            *dpa =3D dpa_base +
> +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_=
offset)
> +                  >> iw));
> +        } else {
> +            *dpa =3D dpa_base +
> +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset=
)
> +                   >> (ig + iw)) / 3) << (ig + 8)));
> +        }
>=20
>          return true;
>      }
> @@ -906,6 +913,9 @@ static void ct3d_reset(DeviceState *dev)
>      uint32_t *write_msk =3D ct3d->cxl_cstate.crb.cache_mem_regs_write_ma=
sk;
>=20
>      cxl_component_register_init_common(reg_state, write_msk,
> CXL2_TYPE3_DEVICE);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 3_6_12_WAY, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 16_WAY, 1);
> +
>      cxl_device_register_init_t3(ct3d);
>=20
>      /*
> --
> 2.37.3


