Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE04BC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiyB-0003f4-63; Thu, 29 Feb 2024 11:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfiy9-0003eh-Ug
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:09:13 -0500
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfiy7-00017h-EX
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:09:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfsWPGlrVep+SkYEVKVf6aMyShRkRiGZrYv3WsM5uk7i4uo0jS4vOwIqZ18q/jdnpLqUTVPrCO/PvIPwBeOXggocWnc7RgkGzUtxCn65FaVIEYBMWwZp5478b0XGv912zyjSjXyY8QvPyL1QBdE9JrTFlaE5YU3y+Crrn8DnWt8xnMsrnQDRiTUeNzqLyohrJfKC08MINov9RxNSXQV6TE+NXiirl/F63fXR50e9j9DM+TyS0BO6siPYl4wQkJdxkeOGkoT5gfU0b3WW0f6KytbgrZXb9nfn6DZ8RyBeaKo8jyxxfnP+8Oa3zbQ4mqJ3CIouXk67M2M+/WZ/RyqcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01cXPULNaNDLwlKcw6k6w8Qvs3q/n2vwrnHoLuOLTVk=;
 b=H3R8kAiIHuF27Zu6JYQaI8tufftvXWl0c/1KzsV10ckK/pB7kPYqeZDf2txKdSmiLCRga/ldSV0eLzrGrQhcoVu0XDedZdn2jS6qCzVivReI3LBhwkE7Uubmd9oz6LPTUB65Yc3Jp6h9oMszkxTsV69TnNvwyY2ZI5ZC4WGKry3/2+3GxHnZy1dIzw4QRbYS2jdYqyYKIrCNhVDRiLeTK1kCnCKWSJ6XogGLwdHwLnf6sVBwnIIzcwffI/R+egUSVy4gsK08XD/iyJW9d2Uno9q64boOPAhBzIFXvJtc38z6wg8TdWU91JEM0wHxkeCm6VaTBdsg1g4lsFFD5a6SBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01cXPULNaNDLwlKcw6k6w8Qvs3q/n2vwrnHoLuOLTVk=;
 b=NQ2bXuWd12x6IHh+H6czFckVeYMCcU/zTOweuhMx/XbS2kEOM4NqAG9LNbQyl8ZvxgtU+hXQP501B4BXzo49rmTJZ3H93bcHnwQgLcbpyB0YKO+N8JdgTgtqzxOmKVgDZxfn8iCXhOu4FZGOLSBSGkY1yiDM22tLaR1pjJDahYD9BbUh+kbTYSl9r5ZZYHfmOnTeV4jfu10CybucjM2jmihZZRJo22+0XpT370Flp3tNbsDZ+VEGa3SNBRKDCZ9ts9BQhQplU3OYTIHPQAfc+EQ2ZeEgAQI5Ljt1lSYsN4TQZKU9n1ZZ+sLV7xJYYC1jykJ6kplUMkmMrzooBm0/HQ==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 16:09:03 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 16:09:03 +0000
From: Paz Offer <poffer@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: What is the correct way to add linker dependency to QEMU build system?
Thread-Topic: What is the correct way to add linker dependency to QEMU build
 system?
Thread-Index: AQHaaye7zzXXB0UUjEeHX6OPGX7Hqw==
Date: Thu, 29 Feb 2024 16:09:03 +0000
Message-ID: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|SJ0PR12MB5612:EE_
x-ms-office365-filtering-correlation-id: 799a041f-ba0a-48e9-f7d5-08dc3940bf8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQDDIA+xpTgdy9Tc22TLKimpQGwrYWXPeX83CQCHMkLARBxubrVBn5u4svkqRCimdzbHXkcXJjLUM14M6DWyBkohp9diIfyFZrqsUbNk+Xli4qtnnLltXkJmv4WJf3GiXo2GvlfqAtp1a3xakkH7lPOHV/809RCnN5/fo2jlZ4EegyIQ/RVDGToy12kXIjPN9F0NE8VXa7dX59ynhTk+p8eyZGn6le5qLvqXawvBhtNSj7QbGF+s8fY7QgmusFyOTWyBaCoZs73EbrTKRtZWqNEu/wFSjyEd8ocfMAu67uHxRpyDqvGPs/jYtx8gJ6g+uvjD80C+dllKOgjjWaStG0GQzG1SIehk2QwqZFauiN5GAvSx/+N02RgiubnX5zObTnCejNHoR3G0chIL77cAK72fxrGPwA6s9fKcwcwgPWlYKK8Nd63wSEfNoAbbyRKG1855+1yGvV4gwd37ahcxi2CBsqcULT0kKR4lBBzuofCFP0mYEbZC9mNFpvmB5BcQK5ILIQrvYRfJWHmJ1BgM0gKfg6xv7dtFFKzTB5G8vjTBbczrRpq7xANFGtoR5rrFSyrY4r0hMuS8NQ4utCjp4UckiVhUfM6AsQDQptaWjEhKCLh9e/ZJCu8FIDTZhaDD278Dp+DuwXIXNP1gzQSIaXeVf5l7PpXacU3FEZdS11r8By/3dO5ui0gYOChlnxPJK14DvCTF7EucaPBLai+oFR9m09auaiuE3MYtKclErdY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HuVefvRueGQqMHazbDLSe2QRKFTM/pUII4fVZyTxBX1pB/n1CzJlRkzMZW?=
 =?iso-8859-1?Q?pTu7f7DdQliSUn7XcYIyCtwqhWw6BbrD8EHoyFeWoKBJHAktOKRIkJ67jM?=
 =?iso-8859-1?Q?xcxXUBjvAZo+Obc+kv1/OiZvlrGP2oi/eZwuGqOPPLqY0Dh1U936MMEU2j?=
 =?iso-8859-1?Q?UYKnEyRZhW5toSCS7mjM5XFUN0AhDFASSPeKDULOqPnssAlTTe3iIN9kIj?=
 =?iso-8859-1?Q?jEpItz8iMQ0wjXDIWE1pPudtVEsDya8iY+ibXZb1Aatys1/YPRhDfh4lBz?=
 =?iso-8859-1?Q?uOZF4iqnWYUHl/5JiNs5UjyJCd8UihZGvo+++Qmdvs3ECVkQtYbRQRQjog?=
 =?iso-8859-1?Q?6dVkPOjeDSNQmnZ/l9VFQms5uJ7pyT0wada459K8/2v2LYH8efpf1ozeW/?=
 =?iso-8859-1?Q?wHWeyOZ04nL7GdMvIGNmMUxYLj6SaVaLzyqzuJeagicb6CI2P8PX5zwWHm?=
 =?iso-8859-1?Q?8W1QJvQIXIevRE4/em5VLmCQ2RQFTAOH04ZufqllVye37rKu/+78cyn6qn?=
 =?iso-8859-1?Q?WBDeIa3cjf3/btwZ9eD0LoDb7fp5Iu9CY/QnpKBuMPVFuOIi5mIR6zAH7S?=
 =?iso-8859-1?Q?QJoUNGkMkx+mSkuyLcOtrWsmpJXwojRYDrZpjBpS8Yyz4ZfwQxhr+IOoUY?=
 =?iso-8859-1?Q?CHMdTDHr3rkBHw8WuD9FRYsRmBbB+4ASZhQZWOilMYtmLnOY3lLQFZknV9?=
 =?iso-8859-1?Q?LC8sCHnkcKO7Ufb4VLOMsCVMAll0VTlwQIXVGY+AuJAGSRhUKw4MGWFoaf?=
 =?iso-8859-1?Q?NUZz6I5cdYde88uOehlmJuUkOdfL2mi6JfcWSWh0vFF/uVLqINZkzH4t0B?=
 =?iso-8859-1?Q?P1lP5penrvoXGb0IUGe7Zu7msIDRd7KoJRpWk/dKbnnqOvFdMb/M6jC5eN?=
 =?iso-8859-1?Q?jSVSIoWw69ut8JKbVweoX9aR8Jc01VDgQkzBRinRPXmBMvXQYEnBJ7bayJ?=
 =?iso-8859-1?Q?un53d8OuKfdnXzyw6FcT4DzP0wb5OEF6CIMss55blIvaszfODfbrOQOv7M?=
 =?iso-8859-1?Q?+qjfjVVvAkVYLf6ygx9ioSaPPlccE3JJJTyzqu+d3fH6xm5t73O6koel1B?=
 =?iso-8859-1?Q?NFxF6GcnJoKtuSEafbX0w/9StviDs25yUsoo/t+OxloXRKQ641veIco9OP?=
 =?iso-8859-1?Q?zYyH6y61kJlmZzgD/o0AcA6C/bb8UrLCPzodZXLCWBSQv4fzibfAFJClp6?=
 =?iso-8859-1?Q?XJouwpFfch5IAtUg7cDtchhNlyN57/xohFpaHbQ4nFh7y1zinfkZqEAPb/?=
 =?iso-8859-1?Q?EHVvC2tpdcdFKemOCE5y6YHrCGIxOQWMQ83Q3zAf4peDzfnU7coiURkLHo?=
 =?iso-8859-1?Q?hpWbExeBmct83m7u+PD3zD6M+Rl8n9GA8HKvqK6fpmia1qiehmKkzSmIPe?=
 =?iso-8859-1?Q?VIasf/XLcleV4Aag515qpEBAIptbDWZMsRTVNuWMWBbaqzDDxy5n8EOIvU?=
 =?iso-8859-1?Q?vUepQX7h4C+t3vj2lsaU19hInsJ20X1OWyWANcPjuSN4ev5/MqoskOfpQG?=
 =?iso-8859-1?Q?syEAzjKEgnH1PYc73R6TWJ/rRVTZGepW5srBbLn5u4HaTds5++rhpPXuz4?=
 =?iso-8859-1?Q?zZHwKUhYoKqYVfy/jgAaHp1dSY4N70WhzUGz6gKoXx7EptbNwOo1J0YVYb?=
 =?iso-8859-1?Q?vKlhJiaynyUw4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a041f-ba0a-48e9-f7d5-08dc3940bf8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 16:09:03.3909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fcbHURfvClcVq/1uBwJnAO0ljyKgJcHqxgTp8ePE6Ar5dplMHRrsCEz2vOqIjoaZ3dVdF2UEX61TcR/ZfHAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
Received-SPF: softfail client-ip=2a01:111:f403:2405::601;
 envelope-from=poffer@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2MW4PR12MB6997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I want to add library 'libdl' to be linked with QEMU build for a particular=
 target (e.g. - qemu-system-arm).
Using meson I would typically do 'compiler.find_library(...)', and later ad=
d the returned dependency to the binary dependencies list.
However, in QEMU I understand that these configurations are done in the './=
configure' file?

What would be the correct way to do this?

Thanks,
Paz




--_000_MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2MW4PR12MB6997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">I want to add library '</span><span style=3D"fon=
t-family: &quot;Courier New&quot;, monospace; font-size: 12pt; color: rgb(0=
, 0, 0);">libdl</span><span style=3D"font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">'&nbsp;to
 be linked with QEMU build for a particular target (e.g. - <i>qemu-system-a=
rm</i>).</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Using
<i>meson</i>&nbsp;I would typically do '</span><span style=3D"font-family: =
&quot;Courier New&quot;, monospace; font-size: 12pt; color: rgb(0, 0, 0);">=
compiler.find_library(...)</span><span style=3D"font-family: Aptos, Aptos_E=
mbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">',
 and later add the returned dependency to the binary dependencies list.</sp=
an></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">However, in QEMU I understand that these configu=
rations are done in the './configure'
 file?</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">What would be the correct way to do this?</span>=
</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Thanks,</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Paz</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
</body>
</html>

--_000_MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2MW4PR12MB6997namp_--

