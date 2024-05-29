Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F040FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCN75-0004Pe-5a; Wed, 29 May 2024 13:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>) id 1sCN72-0004Ne-VQ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:29:21 -0400
Received: from mail-dm6nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::631]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>) id 1sCN6z-0008FH-Tc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZyNVphz48L5Rgq5dbFdGCItOAehLR4V8phSxQkm/M7FuZE/lmirdfDEy25hZOLT1elerjbLuCPfRzxxIa5eUfk7E19AO43uzrpJyxBluI/IvDwrOCOdLmN56ptl6U2v1POv4mcDYxACGo7KHjLUzNK2CleFYoNRQk5SWdmIDfh/kGhYeL0XXMdyfQdW5j32q09dR25Y2jdyp8hmIybF/zNz1U/wkA+5wNIB0p/FNBa0OxxeF7lvIrwGtCtxfrK5/de/Bhcu5ShvUGfB6Vw9JbQkgPkTJ2WayVQuFKxmDgRerCqVI3qUDKvEf+5gXiRlTzLKvGrsju3SXUF5bg4EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du0Sz15SJzpo5OUy9RIFexvmnkpOYY6yiuvclEeUY4I=;
 b=XcBAVinjokCD36kBm8pXtoj9YdqhVvV8h/vQMtUoNxaH6iJC3LgJdHd834vmO/mUE10v6ij0BkFiebn2rvpWkeJSkTclN04Ip3qCeXZUYxJuMvaUivyz3RLT5+HianoZbL8Zbzep21TZMYmiRoGb73XBhYdQ4vl9k++xVgMhgNIWZZl6WeJTLkwtDOpHCmB1524dk42h4Gn2EVAEz6j2fKMgsqxwLOXbAunyJ6urWu/6bIOiBSv9KM4IhFHPsr7sYCQutbZ1JLnasy15KoRIb0xELZc4b0TZLBRQ4DqygfLspyjXBLZO034HZ+bt0gvdf/yRTLmagnyOaHYVpNfXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du0Sz15SJzpo5OUy9RIFexvmnkpOYY6yiuvclEeUY4I=;
 b=n0UzztakjlOmLQzOeP7Pu955n4xR1ZG8X3bFLppFCfXZPPH+PM199b9jCFtCBFTbISw/5CKG+zr0g4vfJS5csiUfzyPfAgNT4sfFuLrt9ir1mrGuq2oeuthVTcTKbk08ogPeYL3Em/5XwXQ3jQLZFmXtHFhAw28Yhp4Ew2YyJT0=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:29:11 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::8e42:5bb3:95fc:7da1]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::8e42:5bb3:95fc:7da1%4]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:29:11 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] qemu/bitops.h: Locate changed bits
Thread-Topic: [PATCH] qemu/bitops.h: Locate changed bits
Thread-Index: AQHasYTzZ++sSMz8rkeYPW9UWsoyK7GuOa8AgAA8lwI=
Date: Wed, 29 May 2024 17:29:11 +0000
Message-ID: <BL0PR12MB488246FC1CCEA16F7F34BA22E6F22@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20240529045909.1796787-1-tong.ho@amd.com>
 <CAFEAcA9YB+=V5Vv=UKK_DRbLMc0kv1T9xqiu5J2Z2yVLk459Rg@mail.gmail.com>
In-Reply-To: <CAFEAcA9YB+=V5Vv=UKK_DRbLMc0kv1T9xqiu5J2Z2yVLk459Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|CH3PR12MB9454:EE_
x-ms-office365-filtering-correlation-id: 13704f3b-8563-4b93-0962-08dc8004da92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SJWfejgPhyglIhwlJIAaPI5GGO8McowJ6Tgw78S9Ic23aisZwk42W8zlDu?=
 =?iso-8859-1?Q?eDrK6+QgrppZHavEfzEMCX8U1PxyGhrvGl9c8lri/v3xq7uLouEun5uoYu?=
 =?iso-8859-1?Q?KwiIDgTBAlnNZlCiT9okWgjNhEgqAwJk3NvIbqPT5rbssoRRFcA0tgTeUC?=
 =?iso-8859-1?Q?BtWBg/c1Fc0Eh933u2zJ/HanW4YyXueftR63DRBBbk9yAm5AT66KS+WOZH?=
 =?iso-8859-1?Q?utwjhTG8nyftNpAtWkYeyXz0i4OElYxI88WiY9OM5OwWchcnf71JTePuMz?=
 =?iso-8859-1?Q?zpz9xYCmGBxdqdGnm6p9m12EBa/4d6QZC/WHMx0JV3ifnZRKJfXPptM33O?=
 =?iso-8859-1?Q?PkHBWzz13pRAvgOIVaYnwG4+8UEn80LLrL58KxeBGtIuwbdVD+FUQxJ76u?=
 =?iso-8859-1?Q?GxS026ly8kSnWJ5SHveOChR8FJhrgwoRgfudWCsrBq+Gax6P8/rfgQd+J1?=
 =?iso-8859-1?Q?np6Y0Tp2/C0vPb1Fc+nzbQH7PkDx/OUlh7MGlA/qP304KSfy+LiwkXOdFa?=
 =?iso-8859-1?Q?K9KfQPKMrqmkHC6+r+qvblIt21Z8Kw+n8WvdX25Hf/bU5zgIOzOrO+WKup?=
 =?iso-8859-1?Q?pbFtAjEuue2EC08+7Lhmdv4nsxvKgYhyowTPi4Mns9YBHn+S/kNfv86gsH?=
 =?iso-8859-1?Q?I+UNs2veleyapM3XZ8UPHNYi/goneipJKXKAUJx1nLXISdE8V8jB+m32ao?=
 =?iso-8859-1?Q?54zjxNMygRz9yV3ywLs10NEO8SZQpxwnKfATF/C/47cg1Y7yulhaFDScWw?=
 =?iso-8859-1?Q?lfLoP09c5NslXkWR73GbE6MpBwmC7Ta3vBxUGJo8baAFewGasuoxXWqPCa?=
 =?iso-8859-1?Q?I2Xv+KEPR+pVh9GwM9u7pXWFRx1m1jzGoo3LETcQEEN56LaQZxPGVtXYb7?=
 =?iso-8859-1?Q?wKZAXHM1zgJ5QvRW74IMP2xjz9ob4ovr6CN0TCkwVd2xK57sa0vw84LC/s?=
 =?iso-8859-1?Q?mZUDzdNJrEFzZ/+0ukL4JkR0vtJuD8gV2gnmw86qfQh94L4sxbQWbaR7OE?=
 =?iso-8859-1?Q?WGG+FwyP3inFCavAjIM2dBf1Oq02rd+0Paorw82MZxNpzM5xYZf+PC2MpG?=
 =?iso-8859-1?Q?TEptY+oFxkPBr+uQfXP/PNkS3VxeQTYBskq0lFmFwid2TgHV+TuAT0NR0h?=
 =?iso-8859-1?Q?lDYH/JwrIcPQJEkFrdoGIuC2ftdp/tH9oHSY0MKupw1U9l6Q8s7Yq9TG7f?=
 =?iso-8859-1?Q?v2aOzO4f03Eeb8R0WwcZqeT7qP8qxcxhjcWUPAdG/ZUsotqc7sUt427s0B?=
 =?iso-8859-1?Q?eMVEcRE+m4HA8Q3GPHSx/srrdpkcLmttFQc6ZpGpXfyqXZjJm+/K9zSLY4?=
 =?iso-8859-1?Q?7uSSqJe6MFhmDT3nbll7iHyLTkEPmrH7wCmy+l9fm6oQxa4US/uZkEtE3o?=
 =?iso-8859-1?Q?0fdrkZPXLRS2usgWPcyeJJFZvdlM2LFQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0wD3wFCDFXHdqkYuWuAdLJhW4OekU3OmmWfR0WCm0LCO+nS6yX7UIBIvMD?=
 =?iso-8859-1?Q?zQOo5mVACetIl6+VkW4hjb5jcUIREyRtbcXIHWfLCIihsX2PLaInigNyiu?=
 =?iso-8859-1?Q?V4+OEI2EQwM6wUm3RbZWuqSXmNRaLc1Ws3Wd3vMoTWEC+YpOhnIbSgr+40?=
 =?iso-8859-1?Q?rDFsuc9WF0h2zBa0QmYf9INguQvFsTOYR/1CuQw9PMhh4gttpzWiGzUMOh?=
 =?iso-8859-1?Q?XZbpeXR4sUsiZSJtNuWgD+KJK6cZOLqjaEX24wLdv3b0ljx7yKAhQqcno8?=
 =?iso-8859-1?Q?E6eB679NfQxHwMFCjPcnVLLvxbUoT5MRg+hYwvHf7y9bbjel1GOu8yR/oj?=
 =?iso-8859-1?Q?TTDTcbBInD5rTFR4x+Rg1oVQLjSP+DEmzKEmjhii2OdqynH6eJSWHVWJ1Z?=
 =?iso-8859-1?Q?17/fBsbrIUfEa/rDXTEOgj8ZGZlvIIwz2ttKE2jqRfdutuN/CsBAeQe979?=
 =?iso-8859-1?Q?D5gFk0r9GmN5DrOf3JQXxQVPp59gcDqZ3jh+AyWP9DD6vxAVnu9d14Lah0?=
 =?iso-8859-1?Q?5SlXYBu47Wpcb3Kepx/vnbjH3HMDQZnFoKchwM4OuBjD/7kcsmN/Cqb5gd?=
 =?iso-8859-1?Q?rDElQblutYn1nFZ1NEJI/Ub3gTvPI2JbGRpmd60vsgtuDufeHOHQVjQNZ+?=
 =?iso-8859-1?Q?4LWaxciEHfwm8TWz70K6DrpIhzEPbFGZtQtQeSxiT4Ie1UBn6tiTjj5YBD?=
 =?iso-8859-1?Q?FgqK38OFReVBt+xZaGTBeuxH4hxgOKd++CmwwgR5mJdBzYqZwVB1ven5wA?=
 =?iso-8859-1?Q?rpwkuWRZvWFa1dbWCok9ivHUqysm0BW3kAQ5CweDAKKidV7nIsB8aYE+Y6?=
 =?iso-8859-1?Q?42Wl+7q4+0wBePHn0rd0W0ppw1MlZdbBKLI6oc6fMmKqz3PzbEh/llaz8b?=
 =?iso-8859-1?Q?1UNwYUkBFPl/69eOnOMykb2AFIwcxGiDdH4h0jjkgI71zI+H+DXCcq5ilO?=
 =?iso-8859-1?Q?Aw6VQTMKDnFxwbg5W0mF5z29beZ4YoZMSAkAwa5FUEyrYwXxk8NFmrbFlK?=
 =?iso-8859-1?Q?U6j+UIDNLRzV2YdwFIXPUjbTYhOu+2Pzr842tS/Fuu++oC/TQRNaPsSA5a?=
 =?iso-8859-1?Q?Xnmpeyq2xYCN92V1v9NJBrSX8CV45gPQAX80nMfkhh0gw2gXqKsPwaS2T1?=
 =?iso-8859-1?Q?hxCXL4nfZoagTY6rQ7JYPsKdC0TiO0bZoTAPe+HFP1VDCqGQ15LMA1Z0sE?=
 =?iso-8859-1?Q?zWie63ViB/ZWSjtz4yz2XTYKpGj3cRdfp4INPwP3H9SSdLrz1ASuI+dEqF?=
 =?iso-8859-1?Q?eALsh0iiLX0sGGKO3d4U+WhMlE6kyYTk6CMHLSFg59IB1NnYEU+HMSUAk4?=
 =?iso-8859-1?Q?bLMb45rCenWB1iWoWiTtoP2Hvl2pU7GZxsxtlhcSHadc4vmV1DSZN1AJ5Q?=
 =?iso-8859-1?Q?fkyTkwcVeDUEiPvPC+jvF/jHuAE8bSGVaGDDIBlL7rMGaOOOgIZ7Hr/mkM?=
 =?iso-8859-1?Q?wpJaIai7j0YIm3MZsoqrdTD7HYToRorWDkf0AiuvC48af6Ww0AjKAoxR8U?=
 =?iso-8859-1?Q?bbzufL9yLkvDtVshPQ79Z/YAX3BScX2IeAkEQUZLRAQSKEBssIKpdyWr7E?=
 =?iso-8859-1?Q?I9JfMxKgSgDHVTwUYi7ErtPsnYPjsL3ctmdf2USZ66mIqSPEivYe4gde1v?=
 =?iso-8859-1?Q?xVEV6rkfdiuwQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL0PR12MB488246FC1CCEA16F7F34BA22E6F22BL0PR12MB4882namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13704f3b-8563-4b93-0962-08dc8004da92
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 17:29:11.4932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChjMpU8PGzfJzRoIBSFn55M+O9uMvirYnCcNjzbpoNaLRFmiF2y++GBW19+v32FC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
Received-SPF: permerror client-ip=2a01:111:f400:7e88::631;
 envelope-from=tong.ho@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_BL0PR12MB488246FC1CCEA16F7F34BA22E6F22BL0PR12MB4882namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Point taken, and I am withdrawing this patch.

I will post a new implementation following the arbitrary-length array patte=
rn
in a later date, and only as part of a series including the consuming code.

Thanks,
Tong Ho

________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Wednesday, May 29, 2024 6:44 AM
To: Ho, Tong <tong.ho@amd.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: [PATCH] qemu/bitops.h: Locate changed bits

On Wed, 29 May 2024 at 06:05, Tong Ho <tong.ho@amd.com> wrote:
>
> Add inlined functions to obtain a mask of changed bits.  3 flavors
> are added: toggled, changed to 1, changed to 0.
>
> These newly added utilities aid common device behaviors where
> actions are taken only when a register's bit(s) are changed.

Generally we would expect this kind of "add new utility functions"
patch to appear in a series together with some patches which
actually use the new functions. Otherwise this is all dead code.

More generally:
 * the other bit operations in this file work on bit arrays
   which are arbitrary-length arrays of unsigned long, so
   these new functions don't fit the pattern
 * we have the bitops functions partly because they're inherited
   from the Linux kernel. The use of unsigned long works quite
   badly in QEMU, because for us 'long' is a type that is almost
   always wrong. QEMU devices usually want a type of a known
   length, which is either 'uint32_t' or 'uint64_t'. So I'm
   dubious about adding more functions that work on unsigned long.

thanks
-- PMM

--_000_BL0PR12MB488246FC1CCEA16F7F34BA22E6F22BL0PR12MB4882namp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Point taken, and I am withdrawing this patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I will post a new implementation following the arbitrary-length array patte=
rn</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
in a later date, and only as part of a series including the consuming code.=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Tong Ho</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Peter =
Maydell &lt;peter.maydell@linaro.org&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, May 29, 2024 6:44 AM<br>
<b>To:</b>&nbsp;Ho, Tong &lt;tong.ho@amd.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] qemu/bitops.h: Locate changed bits</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">On Wed, 29 May 2024 at 06:05, Tong Ho &lt;t=
ong.ho@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Add inlined functions to obtain a mask of changed bits.&nbsp; 3 flavor=
s<br>
&gt; are added: toggled, changed to 1, changed to 0.<br>
&gt;<br>
&gt; These newly added utilities aid common device behaviors where<br>
&gt; actions are taken only when a register's bit(s) are changed.<br>
<br>
Generally we would expect this kind of &quot;add new utility functions&quot=
;<br>
patch to appear in a series together with some patches which<br>
actually use the new functions. Otherwise this is all dead code.<br>
<br>
More generally:<br>
&nbsp;* the other bit operations in this file work on bit arrays<br>
&nbsp;&nbsp; which are arbitrary-length arrays of unsigned long, so<br>
&nbsp;&nbsp; these new functions don't fit the pattern<br>
&nbsp;* we have the bitops functions partly because they're inherited<br>
&nbsp;&nbsp; from the Linux kernel. The use of unsigned long works quite<br=
>
&nbsp;&nbsp; badly in QEMU, because for us 'long' is a type that is almost<=
br>
&nbsp;&nbsp; always wrong. QEMU devices usually want a type of a known<br>
&nbsp;&nbsp; length, which is either 'uint32_t' or 'uint64_t'. So I'm<br>
&nbsp;&nbsp; dubious about adding more functions that work on unsigned long=
.<br>
<br>
thanks<br>
-- PMM</div>
</body>
</html>

--_000_BL0PR12MB488246FC1CCEA16F7F34BA22E6F22BL0PR12MB4882namp_--

