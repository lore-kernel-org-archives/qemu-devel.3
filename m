Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A05C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmoZU-0000it-U6; Tue, 25 Feb 2025 01:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tmoZR-0000ih-DF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:37:33 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tmoZP-00025k-6q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740465450; x=1772001450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ovUtosmwyUeGJhsRIIFQzzzz5f8v5pav9kgE1x8vZ40=;
 b=CqhwCOp/LqdGb6at/9N2BGg9d7cibwd/KP6W/76CAkOcYTPjeA8ftWCg
 ZcmMJaVf2Nto6CHmc1Pa75FTc2Jiz8y5mMOlVxg2YzdRBcpGGg6NZ+wzM
 Rh7cyAQpzfMOkvInvAvElje52nT6okg5e0NSGldgiZHFbdFD/iXtgZlVQ
 E4EA4NXg99t/7NvQBejZr6ipitf+regwm7IXOfdyqDiQJDUMVSBjpVGS4
 muaEMIHctbz90mzX4bZYro8A0Cm3OpRfuWTU741RSCPqpXgw+rJfFNbbe
 C8p0bB0pEWeEbAWTLK052VW9u9+fS4yiVYFA8xJapeuV8rSYk/EZG4ycT Q==;
X-CSE-ConnectionGUID: GxJkif4/RaGltMk6iBamqQ==
X-CSE-MsgGUID: qWq8OGnnTHKb019w693w+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="147553164"
X-IronPort-AV: E=Sophos;i="6.13,313,1732546800"; d="scan'208";a="147553164"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 15:37:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl+7o7WJz+QAkrZUz3ZaJI7i2JobgmP1l/jKPqLVtPeRSEdqWlytCOmDNXjwI2pzGcq+b3HI8J9WLmeNMmByf7niv0L/zYryM5fhzR/GCMXc5NY2zP3wAWki04TgA03fZVPDjmnXaT/Sdt+jRiQgg31cY7vwIvtKYxTZ/WcdsG1NPZpf1f6p6dbhNCpXRqoiYu04yHCt8P/9t2om9+X2DX3A5apr7ynrvWRdo4vY6m196eh6d1F3BGihfnXQ0H7/jTPgHdmoYCnrOstf/2Dw82u97R5WXuYO9iA/HLX+WGwONYdHGabZ30s+3mTtH9enDbbjzG3QhHQGSxkL+z3rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovUtosmwyUeGJhsRIIFQzzzz5f8v5pav9kgE1x8vZ40=;
 b=A/+ag3Vb1hM5EsWO4YhrtI0X+/pgPrH8kWEBvtUqmwgJ2c7tDvSP5MmwCMr2KbPtRpfD2gh1zyCvYzIt5pwDsfMkJtIhocBbgrIUUYdLqD64U8bouVyKe2h5tICJtbdwTg65BGwDS7YJKRtXv6cXpZ/UGgUJYMahs9fNK4v37AQCOaorHvkGuDZVJuFiu9CvLIK+IGLYlIKFKOhQRL5w0hy36+Be9hOFDkOwjRt3DLrx1wwg/SHj5faGTna6B8Nzuy4SkOj0KTDKpDFl/pWLrSwbHaWptXx4sQ1rmfS0ab471JANswAtPWEiyDcyPhfUMP7zNJ3GmJu2uZSu6uQYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB12145.jpnprd01.prod.outlook.com (2603:1096:405:f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:37:21 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:37:21 +0000
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Thread-Topic: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Thread-Index: AQHbhCrAGTsslv7mgkOBXKbI2mkTBrNW5JiAgACyeQA=
Date: Tue, 25 Feb 2025 06:37:21 +0000
Message-ID: <8e363920-aafa-4991-b633-fa9473406b17@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-6-lizhijian@fujitsu.com> <Z7zPYfWp2fLRB63W@x1.local>
In-Reply-To: <Z7zPYfWp2fLRB63W@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB12145:EE_
x-ms-office365-filtering-correlation-id: b575c02d-002b-489a-5f8f-08dd5566db7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QXgxTjhNVzR2NVpKbHBUQ0pEMU8ybnNjSVRpaWZtRkEvZ25wZHlqNDlZUWVu?=
 =?utf-8?B?cTlnTU14aXluR0RBRitYdjZFNXlONWRnOEoxNUhIaTZUU0lNT3F0Tk1zWm54?=
 =?utf-8?B?S2Y3bXVxSjU1TTZFeDdNM0NhMllxaGlDVTNLdWltZmhTckFNdWlLMUdweHNw?=
 =?utf-8?B?eVFmK2k5eGl4UEtyaWJxMUdxb2FvMFhLQWZaTzRMbUUwZXp5c29hWUc5YXRo?=
 =?utf-8?B?TmIxNkdSUXRleGw4TnhObVcxNFkyQ0t2ZCtTSHhldGhvdkZTREtlNkVqd2tR?=
 =?utf-8?B?aVpDOHZWZ2xra0puTEVMZXFVNDlFTXNxS0ZyK1hLdHRKVDFqWDRPc08yeDFP?=
 =?utf-8?B?WGlKSEh1MHRwTGxoZDZGSFpYV0ZPYU9zbSt2b3BQTlRETnRtZmwxMjdpU3M1?=
 =?utf-8?B?OCtNbkpYTWM0anpaLzhzak1Cd2M0RURPbWZiL3JDMW9Sb1FjTTcxd2o2NkQ0?=
 =?utf-8?B?SDgvZ1gyV1NpaDl3djFHdkhscjJhYS9veTkralhJRm13V25oQjAzTlg1UzdT?=
 =?utf-8?B?Tll0UXpvdFByL0lPdzhIcU9tZ2JjZUVKRDNFcEFwdFQ5bWZNQjJwYVFJZ0R2?=
 =?utf-8?B?OG4vblVwZHpOMkhyMjI1VDdpR1dCT1dZSFAzSmx6a1FQMnFjSGc3dUJBN21u?=
 =?utf-8?B?V2JVNW1COXJSeGZ5R2tocjNqSWhLTlJnTFVMZFp4QXFxQXcvNm9BQ3lqUFZa?=
 =?utf-8?B?WDBtVzdKS0E3dE5aazE1R21oMU4wTFdmc09WelV5ZERZVnYxT3dMZ0F0eTcr?=
 =?utf-8?B?elN4S2VNa3pySjF3T0U0UFBWVzZNT2JUMDJORTNScnpUUWI4VkVoRmxYWitm?=
 =?utf-8?B?MEVYUlhjY0JwSERxcmUwOUFXelVqVit5MUlmRXpkUnM0UUlGY0lobzg0T0Nh?=
 =?utf-8?B?L1JpSkViSklra09XTFBGclRTOGpycEhDdEJSa1gwSVNQQndVZlhFcHVja0NH?=
 =?utf-8?B?T0g5OHZzVVRKMjNuK1BTU3pDeXJ4bXdZbEUwMGtlV1hpVURIaVlzZVhOcmpF?=
 =?utf-8?B?RndicXVRYy9rd1p0QWk2U2JKZ0syNm1JSHFlaDJ0M1o4VDVWaTNnT016Y2ZE?=
 =?utf-8?B?TG9YajFHcWY0VXJ6TGxkZHJkd3c2bnNyMlFDeFBzQWpuY1NvT2x3ampuRWRh?=
 =?utf-8?B?MVNUWFBJaWtKNVYrZTVnY3pyVE9WZEpGNGZZaFI0VHQ2ckgrdXdyNWtwdmYx?=
 =?utf-8?B?K3Q1MWtyaVNiOUlNYlhseWp3ay9uS0t6amFpZHJ2ZDd1VVo5TnVWZ0JEaEhm?=
 =?utf-8?B?dWJPaDN4Q1MxdjZUeEZlTlhHZ0dWTjRKb3dWb0c1Z1ZkeHhnNUtNemNUcm5D?=
 =?utf-8?B?K0Q1anJvN3d3S1BOM2EvRTd5QzByOTdJMHRjeDVnWmpZUFJSMlhkWjV0YkJD?=
 =?utf-8?B?RmoyMTlqNm9kQzNyZlJmVUR0K3lCeDExaW9lSUR3cmdDRklQNkR5WHh3WlhF?=
 =?utf-8?B?Z2doMnU0UEk4YkUvWW1hSUphZ0IzRkxxNXptbXpkdFFwdUVpTVIrdkZXcEw0?=
 =?utf-8?B?U0pRZUhnUk5SbFFZWG95WmhoRjVyQXUvbUl5eHBEMTNMTDhKUVJaWHlhU2lq?=
 =?utf-8?B?Y0Vpb3F0cmE0ZWpmK3ZqK2FUSlVaQ2lZZHpJYkFJcWxxVHhaek9GSm56dkpo?=
 =?utf-8?B?c0dNc052WFB1VXBnakswTXZmU293aW9kRGFJVnI3dWliSFVZS0NJeEY2TDND?=
 =?utf-8?B?S1FqeStsTVZBZzg1aHBQSGxma2ZveXA1OCttbzZhTUgzU1QzQ05GanVsY2hX?=
 =?utf-8?B?WW5zZFljRXg1R2FJNytSMUlUZ0s3dzM2Y202VzZOK0lab05zSTJxNjdaVGN0?=
 =?utf-8?B?R1ZESHkzeEtIQS9XRVg3b0o4SVdUbThSTDhBbk5VRUNXUnB6OElKTTFFbnRh?=
 =?utf-8?B?TmF0Zk5aVmJZak83MW1zWHRxVkV2dnY1eXdDQ1drWGZNb20ycGFCZU14cWdt?=
 =?utf-8?B?NTlhcXFPQW96Yi8xQWJuZ0EwMkFWT1Q0NUt3S0ttTUY2L3RwcnZ6b2o4L0dw?=
 =?utf-8?B?R0ZpNncreHZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEo3M0I0QUp1bUxqb0RwSSt6T3Z1bWZMMHdOWkp5a01xL0x5NTJvYzBZaXJn?=
 =?utf-8?B?bGZTMmprYm5pYUMrNlUzc3pDaEpsdHI1dkdrbEwzWHdmZU9abWVzY3BleVB0?=
 =?utf-8?B?T1dlVG9jVFJPd2RIcCtscWlnZXZrSG4wUFFjdzEwWVNVSUpzY3I2ZkVpd2tI?=
 =?utf-8?B?SXkyVUpjZ2ZSVk5semJiUU5wWVZzcjJpcGplUkZvMFRYbzZ2T3NLenByUUZa?=
 =?utf-8?B?akIvSlZTbzA0dTlwYUo2d1VEVEIyZkxLYTdHaWlUajZlYy8vL0RtNlMwMk9P?=
 =?utf-8?B?bTkvNzdkSjJTbXJBWWVPakZBZnk1T1QzK2tEdVpMVXNzdHVYdGtkNlk4K2xh?=
 =?utf-8?B?R3ZVUVRvaGluS1poTThVUnNSYmFMVnZTTlBLbUpING9qVlZKdm5GaDZ5NWJM?=
 =?utf-8?B?akl4WlQ0SkRxZ0lUNk5YQTRNcVBiUVVQNWhqTVpqU0NQTXgrTHF0VnJnalVk?=
 =?utf-8?B?N1pvN1gvUWRDYjUvRU12aXhJdjgvMitJam90Y1o4S2dQd2Q3dGRkaDlDZUsw?=
 =?utf-8?B?dFBXMnI5eWJlUUQveWhaV1VJRXR5MXFkY3dBOGFwMThONXRQNHhRMk85VHhW?=
 =?utf-8?B?VG5wTlpMc1Bha3REZ3VMWXZscXAyOFR0eDIzMG9ZNE5oNThhQlFnUFVOWm9C?=
 =?utf-8?B?dUFOTUNBRUZsRXdnZXFJeDUyeGIrdXhsbzBkWFlXZElpaWxjOHptblFTSDZK?=
 =?utf-8?B?Ri8weFpKOVl0UFZhblVxbmJ5WlRDZlhVRmN5YTFTZVRkNlkxNTFTMUt6L0Nv?=
 =?utf-8?B?N3lGaTl6aVJWaStxVUV5OXNIUzl1cjg0MkN5WjFPSFowaDA5b0dwRXhYOTJ6?=
 =?utf-8?B?YmVmSjJVQXpvcmcxOEpyMWp6UXh0WmQvYWVlb1JUS2hka05sckVtcU5qN29a?=
 =?utf-8?B?ZFZXc0dzN0x3VnM2aGpqTDBnVnRIVVFhVDdCY25vdEdoV2VidVQwSmJZb2FY?=
 =?utf-8?B?YThoL0JCZ3lKTFNUQ1FUZ1F5MjlIZ2tEeXFvU0ozemdLV0FNZ25WMHhkaDhH?=
 =?utf-8?B?Z2ZlQ1FxQ0N1K1M5a1F3cDRxMTJiTkRmRE9pN3B1M3RTR25iYVl2MkVtQnhw?=
 =?utf-8?B?enFJT244UDZva3ZOSXNmdERuL0hsaGVpZjJRbzR4QThoM0pHL3BNWmtlU3BG?=
 =?utf-8?B?dDl0Qnh0RzFqb0lYbGpITHZzZlg2ZitqbnhDbTVDMUk1VTVNQWgyVkE1OVYr?=
 =?utf-8?B?a0JkdFI3VGd1RUw0RGloWEtDdTVvVWNua1JpdUFQL1RWY3E4Zk1GTk5WQXgr?=
 =?utf-8?B?dmlmSzlTWTRxajJxSGQrMWFLQzN0UmE4cEVmeXpGVmREdDY4OC93MkJ2UkVp?=
 =?utf-8?B?OVkvSitsOExGN3liK1pER2FzWko0bnRLdkRWdHY1S0pVMmwzY04wWWNzUG1a?=
 =?utf-8?B?dUV3anlDQmNyRThFaUdIa25pRGg2Mks5OFBvd3V1NUZpMkdSVVhIV29JMENK?=
 =?utf-8?B?NXRaSzFwMFJiRGFiei9oVTJRNnBVT1E0bXRLM1NVdGtIM2lUVUt5SmNCVldI?=
 =?utf-8?B?Unl3d0tUa0IyTUp3ZTJwT0FyNUwyc1hlUjRrbERvVVYxZE5TOUtFSXRFam5a?=
 =?utf-8?B?V0JJME9Qa3REUG9EdHg3dWdsZy9sS2JseXJaMU14QnVDbXpna1VGb0djTEt0?=
 =?utf-8?B?eGl0ajBGUytjOCsxeE9qRTJUS0tDQWNTb2pVZXdIYTJXd1FnOXlabkFHdjVt?=
 =?utf-8?B?U04wd2kybmZqWmhUR2p5dE1VZklsM2FBdTJiVFNDM3hqMEhzNnhOT3Z2cXRm?=
 =?utf-8?B?Y2xkV1dZdmZ1aEVxR0RDakZRZlc5dnNha1VjbGZnWmN1L1VZWUtiTHovRGxs?=
 =?utf-8?B?a2NpN29peDBpa0YzMThNSDV4ZzVmL2I1azY4MzdVd2dwbHFlek8yYTJCVnhR?=
 =?utf-8?B?WnZIZTFobnh3dDd5SlY1Z1U2QjJiditqaTB5Tmc4K3BPYXpXOC9tbVcyTDAx?=
 =?utf-8?B?Y1NuenVHNTFUTzhSeEpxaXRxcjBRcDdxZlpQVy92NE1teFloNFdlTk52dk02?=
 =?utf-8?B?dXZGWmxxeVJYamlYZmE0ZDFmUEpqcldKTnNCK1VxZy96Q3d6ZFM0M3hpWlJm?=
 =?utf-8?B?SzhEVndVTzduQlZDUXB1Sno3YnI3Q0dZWG8wWXVRLzdFZG1ZNSsxUmNnMkxl?=
 =?utf-8?B?OXREaDIvZVNYcHVDTVd4bFFuamp2V0ttd1ZKOFNwUGZSckJ5NWczU3loMjFL?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DBB9FD0EE239D45AAB0D2605B069D1A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HDVsaes2cPiUT+DISbAwGsfnYBXq0LGO0bH8PMTo3D55rsixmOWHIRfyNIZ8F5lpQzrilxiOaw4Pguxlel3cumUzscXgYzEZNKt9WwHCJEilFSvIiDyKT9wOGAJvBxGCfUd7chJszTS3CGoWxPF6pUnmS+DlQcmjdTyRiTtAJiRVWv86tWgizQgqavLzJFe9Iox9cOUk0JWhxx4B+EZBfT9MnUkh6/9N/YlyG0ww2FZXrVcQCnF5CRc/boRvg1XGnaz19bX9NAUWFoq6WBpqUd//PvhHyqx++Fi8X9kqwsw27P+KBCasIgQDm44tW3ZcyKnN/Umqdb9jI4cYjlr/XyaCWMa4LGojkQ71mDzgrOxIE5+Sb1sdtC/AKZdsGlyBpTyUJ5sQZ64URi6EB5oA8CapCBeqdh0Z0B15DsLATiAQq/XEODsCzLZDYIO5ygqG+r8EmhgRe5qxDySuLSUv9bL2lW+fPcheh2tagEPxiOET3IJpCSSDuERyiCZpkNZZhCpsV/63J2QsYiuzJPk2x6uq9DhRDc/XD2nLG1PRU7LF9hLP9W9bM24dwJLT3CNyqZLJ3c8wzZTOGWitb38wRRlotD2khFCEbEEvGp9NDxskFGqqw//vthI0RueQjmXV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b575c02d-002b-489a-5f8f-08dd5566db7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 06:37:21.3929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSPE2u87i3uExkqNOPLf5ATGoQGaPMztPhu9reE5o43hRmh/kfhk7VFX1bdSIdYeIgfyxmI4heMMsiDOjm7F7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12145
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDI1LzAyLzIwMjUgMDM6NTgsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBGcmksIEZlYiAy
MSwgMjAyNSBhdCAwMjozNjowOVBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gU2ltaWxh
ciB0byBtaWdyYXRpb25fY2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKCksIGludHJv
ZHVjZSBhDQo+PiBuZXcgaGVscGVyIG1pZ3JhdGlvbl9jYXBhYmlsaXRpZXNfYW5kX3RyYW5zcG9y
dF9jb21wYXRpYmxlKCkgdG8gY2hlY2sgaWYNCj4+IHRoZSBjYXBhYmlsaXRlcyBpcyBjb21wYXRp
YmxlIHdpdGggdGhlIHRyYW5zcG9ydC4NCj4+DQo+PiBDdXJyZW50bHksIG9ubHkgbW92ZSB0aGUg
Y2FwYWJpbGl0aWVzIHZzIFJETUEgdHJhbnNwb3J0IHRvIHRoaXMNCj4+IGZ1bmN0aW9uLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4g
DQo+IFllYWggdGhpcyBpcyBldmVuIGJldHRlciwgdGhhbmtzLg0KPiANCj4gUmV2aWV3ZWQtYnk6
IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCg0KSGkgUGV0ZXIsDQoNClRoaW5raW5nIG9u
ZSBzdGVwIGZ1cnRoZXIsIHRoaXMgcGF0Y2ggbG9va3MgcHJvbWlzaW5nIGFuZCBjYW4gY2hlY2sN
Cm1vc3Qgc2l0dWF0aW9ucy4gSG93ZXZlciwgb24gdGhlIGRlc3RpbmF0aW9uIHNpZGUsIGlmIHRo
ZSB1c2VyIGZpcnN0DQpzcGVjaWZpZXMgJy1pbmNvbWluZycgKHdpdGggdGhlIHN0YXJ0dXAgcGFy
YW1ldGVyIC1pbmNvbWluZyB4eHggb3INCm1pZ3JhdGVfaW5jb21pbmcgeHh4KSBhbmQgdGhlbiAn
bWlncmF0ZV9zZXRfY2FwYWJpbGl0eSB4eHggb24nLA0KdGhlIGZ1bmN0aW9uIG1pZ3JhdGlvbl9j
YXBhYmlsaXRpZXNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKCkgd2lsbA0Kbm90IGJlIGNhbGxl
ZCB0byBjaGVjayBjb21wYXRpYmlsaXR5LCB3aGljaCBtaWdodCBsZWFkIHRvIG1pZ3JhdGlvbiBm
YWlsdXJlLg0KDQpUbyBhZGRyZXNzIHRoaXMsIHdpdGhvdXQgaW50cm9kdWNpbmcgYSBuZXcgbWVt
YmVyICd0cmFuc3BvcnQnIGludG8gdGhlIE1pZ3JhdGlvblN0YXRlDQpzdHJ1Y3R1cmUsIHRoZSBj
b2RlIG1pZ2h0IG5lZWQgdG8gYmUgYWRqdXN0ZWQgdG8gdGhpczoNCg0KVGhlIHF1ZXN0aW9uIGlz
IHdoZXRoZXIgd2UgbmVlZCB0byBjb25zaWRlciBpdCBub3coaW4gdGhpcyBwYXRjaCBzZXQpPw0K
DQogIHN0YXRpYyBib29sIG1pZ3JhdGlvbl90cmFuc3BvcnRfY29tcGF0aWJsZShNaWdyYXRpb25B
ZGRyZXNzICphZGRyLCBFcnJvciAqKmVycnApDQogIHsNCiAgICAgIHJldHVybiBtaWdyYXRpb25f
Y2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKGFkZHIsIGVycnApICYmDQotICAgICAg
ICAgICBtaWdyYXRpb25fY2FwYWJpbGl0aWVzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShhZGRy
LCBlcnJwKTsNCisgICAgICAgICAgIG1pZ3JhdGlvbl9jYXBhYmlsaXRpZXNfYW5kX3RyYW5zcG9y
dF9jb21wYXRpYmxlKGFkZHItPnRyYW5zcG9ydCwNCisgICAgICAgICAgICAgICBtaWdyYXRlX2dl
dF9jdXJyZW50KCktPmNhcGFiaWxpdGllcywgZXJycCk7DQogIH0NCg0KICBzdGF0aWMgZ2ludCBw
YWdlX3JlcXVlc3RfYWRkcl9jbXAoZ2NvbnN0cG9pbnRlciBhcCwgZ2NvbnN0cG9pbnRlciBicCkN
CmRpZmYgLS1naXQgYS9taWdyYXRpb24vb3B0aW9ucy5jIGIvbWlncmF0aW9uL29wdGlvbnMuYw0K
aW5kZXggYmIyNTlkMTkyYTkuLjU5ZjBlZDViNTI4IDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL29w
dGlvbnMuYw0KKysrIGIvbWlncmF0aW9uL29wdGlvbnMuYw0KQEAgLTQzOSw2ICs0MzksMjkgQEAg
c3RhdGljIGJvb2wgbWlncmF0ZV9pbmNvbWluZ19zdGFydGVkKHZvaWQpDQogICAgICByZXR1cm4g
ISFtaWdyYXRpb25faW5jb21pbmdfZ2V0X2N1cnJlbnQoKS0+dHJhbnNwb3J0X2RhdGE7DQogIH0N
CiAgDQorYm9vbA0KK21pZ3JhdGlvbl9jYXBhYmlsaXRpZXNfYW5kX3RyYW5zcG9ydF9jb21wYXRp
YmxlKE1pZ3JhdGlvbkFkZHJlc3NUeXBlIHRyYW5zcG9ydCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICpuZXdfY2FwcywNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQorew0K
KyAgICBpZiAodHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSkgew0KKyAg
ICAgICAgaWYgKG5ld19jYXBzW01JR1JBVElPTl9DQVBBQklMSVRZX1hCWlJMRV0pIHsNCisgICAg
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJSRE1BIGFuZCBYQlpSTEUgY2FuJ3QgYmUgdXNlZCB0
b2dldGhlciIpOw0KKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgICAgIH0NCisgICAg
ICAgIGlmIChuZXdfY2Fwc1tNSUdSQVRJT05fQ0FQQUJJTElUWV9NVUxUSUZEXSkgew0KKyAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUEgYW5kIG11bHRpZmQgY2FuJ3QgYmUgdXNlZCB0
b2dldGhlciIpOw0KKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgICAgIH0NCisgICAg
ICAgIGlmIChuZXdfY2Fwc1tNSUdSQVRJT05fQ0FQQUJJTElUWV9QT1NUQ09QWV9SQU1dKSB7DQor
ICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiUkRNQSBhbmQgcG9zdGNvcHktcmFtIGNhbid0
IGJlIHVzZWQgdG9nZXRoZXIiKTsNCisgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgICAg
ICB9DQorICAgIH0NCisNCisgICAgcmV0dXJuIHRydWU7DQorfQ0KKw0KICAvKioNCiAgICogQG1p
Z3JhdGlvbl9jYXBzX2NoZWNrIC0gY2hlY2sgY2FwYWJpbGl0eSBjb21wYXRpYmlsaXR5DQogICAq
DQpAQCAtNjAyLDYgKzYyNSwxNSBAQCBib29sIG1pZ3JhdGVfY2Fwc19jaGVjayhib29sICpvbGRf
Y2FwcywgYm9vbCAqbmV3X2NhcHMsIEVycm9yICoqZXJycCkNCiAgICAgICAgICB9DQogICAgICB9
DQogIA0KKyAgICAvKg0KKyAgICAgKiBJbiBkZXN0aW5hdGlvbiBzaWRlLCBjaGVjayB0aGUgY2Fz
ZXMgdGhhdCBjYXBhYmlsaXR5IGlzIGJlaW5nIHNldA0KKyAgICAgKiBhZnRlciBpbmNvbWluZyB0
aHJlYWQgaGFzIHN0YXJ0ZWQuDQorICAgICovDQorICAgIGlmIChtaWdyYXRlX3JkbWEoKSAmJg0K
KyAgICAgICAgIW1pZ3JhdGlvbl9jYXBhYmlsaXRpZXNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxl
KA0KKyAgICAgICAgICAgIE1JR1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSwgbmV3X2NhcHMsIGVy
cnApKSB7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCiAgICAgIHJldHVybiB0cnVl
Ow0KICB9DQogIA0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9vcHRpb25zLmggYi9taWdyYXRpb24v
b3B0aW9ucy5oDQppbmRleCA3NjJiZTRlNjQxYS4uY2E2YTQwZTc1NDUgMTAwNjQ0DQotLS0gYS9t
aWdyYXRpb24vb3B0aW9ucy5oDQorKysgYi9taWdyYXRpb24vb3B0aW9ucy5oDQpAQCAtNTgsNiAr
NTgsOSBAQCBib29sIG1pZ3JhdGVfdGxzKHZvaWQpOw0KICAvKiBjYXBhYmlsaXRpZXMgaGVscGVy
cyAqLw0KICANCiAgYm9vbCBtaWdyYXRlX2NhcHNfY2hlY2soYm9vbCAqb2xkX2NhcHMsIGJvb2wg
Km5ld19jYXBzLCBFcnJvciAqKmVycnApOw0KK2Jvb2wNCittaWdyYXRpb25fY2FwYWJpbGl0aWVz
X2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShNaWdyYXRpb25BZGRyZXNzVHlwZSB0cmFuc3BvcnQs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCAq
bmV3X2NhcHMsIEVycm9yICoqZXJycCk7DQoNCj4g

