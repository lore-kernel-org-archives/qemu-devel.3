Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F6C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkU0-0003x3-Kh; Wed, 06 Mar 2024 01:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rhkTx-0003wo-3l
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:10:25 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rhkTt-0005MV-5c
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:10:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvDjnHeueCs+IjhupNR7I8Jda/NVdMZdznOdZ3T1NcNKgtzd/Ufcbs1qEwT+NuskQpWhju2NLYi+knJVDAqcgFPLnLOrsR19WUDe405n7zH4DB+7oAcJsir5SW+ImyUTTUZMpUg6UYORNX/SjAY4E7W9OVLx4JpXxT7nB6oboTfjeASGAYmLFZFuAk6ZSx7I16OHZi+Lj5vZ1c1RnBCEVA8c/l3Rc/4E66qltd6edFJbPnsWBePahVG971UrM4g6S+yE7XF/eZiMZbLu4+CloFXHBaBglht1wzEJvI37AglsBrLut5FIsRwnGCWh6i57+NJGcAF5z2uiRN/KMm7vaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDkgFrS7xNtaGhfn3rm7sp7o2dLT+N1RYXYSiGInfes=;
 b=aK+PlN7rAVHkmwG0pNkjyytbVVs3eqFf0fhUmTJobCJo5dh3JbqXWN3nqCZ6XzS8zMwJCqRh+1KEfXCWkfDL9uFhJE5ul6+9LZ4B3NalfK6IL1sfi0OjNETXtn7O5Q5DBJuLAEfcZQw2B2hKDqKCxuYvzx6vkKIrOjyqbWVekQxN4rq2f6DPRHD+EgMDs6FVRrdt+CCwfWc3Op6t+DOc2LfyuP2Rp7qQw1TheHgYstxi+ylP7qekWMElvQTEDL7EiTYk4pEKXfNK5vPgz7RC0xioOwltpCgpCfXzyg0XmO+aeAHC2aWNn/JQoiofDbrg3DB85MTlYU+Fty+/l/afNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDkgFrS7xNtaGhfn3rm7sp7o2dLT+N1RYXYSiGInfes=;
 b=MiLUieoCQ1huwvny5xcJsRKo+L9EDLecPF1UTwystHUvFAWXOppqwhg902uPtv0v3pGNXUYx7SaSPybZX1iorHy5tfEp6SkCwQK28yhkELMT+RSYuvj6on0od/zzge5LHM0UehuW90x3X+S9kggw8gHyDzZpTEcv8hQ1fLSOk+BXzrHYuACs0VwbWOg8dghoU3PdBzlEM9qiFNPzceBd9tOMv2nYhNx7xg0HSTWY9a84qkBgXI1lbEtCrx8elBXigpG9YQ814bw5qu/9+rdAxEGVRLaoHb3nI3phKV5zQYBydXx3K5M707MmTaHXwOVgE+w92KRizo1JBv4fa/3ctw==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 06:05:11 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 06:05:10 +0000
From: Paz Offer <poffer@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
Thread-Topic: What is the correct way to add linker dependency to QEMU build
 system?
Thread-Index: AQHaaye7zzXXB0UUjEeHX6OPGX7Hq7EhlMAAgAiqnmY=
Date: Wed, 6 Mar 2024 06:05:10 +0000
Message-ID: <MW4PR12MB69978FF0504C5B108E409656A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
In-Reply-To: <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|SJ2PR12MB8689:EE_
x-ms-office365-filtering-correlation-id: 766c5cf7-2f97-4a54-c07d-08dc3da361c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTsNtRGG6ZK7uY42hah46vRwPrA12H+6hLFy+LMigQhmNril9c3bO3Q+1tTwACgW+cfsf95tXk1PLoiaS2GfbJ2ag9nUt7FPgKL+QA4u4YdGQrxdKpipTXOP1UCOl4415pRXOQUjPYPvK2KHqfRXagLrHDcPWfEDHX8/pWku3DwSeJo6zXNLkn1Fi3dfU2ydkzKdSFlq68+qTD5BsLAEXPuMNXwMTjLN7Nqt/9m/2fXLFk8b44uOXkOvUeEHDc/DF7vTkumLU3OZnzZYWLkcU/fqGfQKpNzDunCr5swJ1SxieR8XuEhlvzyGrWHSexswh9gpVObDS0b42erPLEaevcmcqirb2KStSeZ9ndGGhhM8zGKYdiDIu3a4ovmo9Xa+/yh5dbOMH5Qn44SEHB3fLVxqh+Af4E1MB52Bo9SKm/bHZc87kTg8qky90anEqkFv2rrvwfAtSJIRR4jqxdoXjPOtuuDYVTHSI5+zZUco98VJrl33XTVmMMXvv69L3nnZZg/gqGtNs2p99a3EMDCfmqh803MjOdf7KpZgLADP6D/IF7wVaGpeKR62BQUCHBy6PTgWupl3TPT/D+k+PYqORhxKtDKbGSujnEzprUHsaXR8AWSQr8wV4DfXTQH+9/fnKabhnfwmIvG/hw/XHFHAS3vvMvaN8iVUctF+qHRw6nvk50FGm0XU+HxoBvnMkq4JPLS8Uc0/c7DzRd799oJjODeerU7Upwf4MbjKsykRVzc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0wvvI4bT/XTkMpVNMLmmliYkTPN3lmfvu62k+v26lnq3BL1LyJ2GsiY0xy?=
 =?iso-8859-1?Q?2vhtR6UD22KuqG23EfRp4Q76mMF3i2O+q84IINmgc8+uCATbIkj75ys1BM?=
 =?iso-8859-1?Q?0vBCla285rvSA0gAXjrZQqgETzsDxElV2A65Moe7vJiS4n7Yk+/flKj26d?=
 =?iso-8859-1?Q?6QesrDAqa++GkRx1n423WzswGPj+bJr7FmYszik8JEjgfohvUwTlOxlNgC?=
 =?iso-8859-1?Q?ZBcP3cMrzLPnqW0i1rcHOFTrmCnLuzss7hIYNEmR+8ssUB3xQlrRslI5lH?=
 =?iso-8859-1?Q?OvX61Gb2TPYFIvI3LOxSov7V1xnIPt2pLjBm1Joz+3dB4BHJxT+5gmZ9r6?=
 =?iso-8859-1?Q?ZssKp/TimL81fcr6wMOQNsgocHC1WLfTEblyAQdpgXbdf+zBL3/TGF/AiQ?=
 =?iso-8859-1?Q?kMcpMO4ku96E4kUVWiTFiRXMsIrKjOceX4WegXL7njo56rXIQcEgdhTkiX?=
 =?iso-8859-1?Q?SZNYJpblgUZEownYUER5aBUIA2rSb5vpxn8AejTwdoM2MQM+O6RQgbRvxZ?=
 =?iso-8859-1?Q?Wpgs2IfsBLbKCH2iAMis6DyN2dgLTNYC6eCjIq9XBNWYq0jhuRrp06zBmZ?=
 =?iso-8859-1?Q?9qT8f6MDe0j4oI74xvZm/gk69Wl8/meOR4AcxDCOpfZOnkL4ZGWh8cSUYu?=
 =?iso-8859-1?Q?9jq1QA4ECPLTYAzqLH55TYkMEkbHSLeb3UT3/KhzTNSrgB39I7KPZ3vF9a?=
 =?iso-8859-1?Q?ac5W0XflvUZMC2B+cF1AuPCYZb4H7QuSicR5siKWWRKm7rBo0XPmZhX9KN?=
 =?iso-8859-1?Q?F5lx2qIYh8Bate+SOnM06CBL2itPAiTmfqg7z2lm/ReHGDX3MaZtUo5ifW?=
 =?iso-8859-1?Q?4ZVaW6d+D3Ut1j4OpwCOvEv5M9HuWGGihrgNLlhA1ZBFiM31PBfDFFtI2A?=
 =?iso-8859-1?Q?4qgKLy7vS6txN09DUQpTV5hV7Q2vyjQ8NMGkDnJYRUfQLBlAq7qBi96lMm?=
 =?iso-8859-1?Q?PTix4k/egZuU426J81b4g4d8zD0r9OgyAugB8jAhIXsTSenTE2kwU1zvzr?=
 =?iso-8859-1?Q?XBktnOcilnt5u456BLPXX4kvyo59SRh2j/4QUzBCaWpZdujA54OVtMoRvQ?=
 =?iso-8859-1?Q?rdzbUsBQ0YweKU5wJtdC78KyuYXyH6J6q0GEnxtAAnVXka/48n/xeQ+toR?=
 =?iso-8859-1?Q?VdWkGbVSZ6lPYeHMqD4FvCbaUKO/8HCshUSyB5HMIgSkJ4oQTGPUAH2w8H?=
 =?iso-8859-1?Q?7gc9y1I9FopB2KCIQYch4/cjrYj228Hla2bj+lDTCqBZjKz+8iZ8FZ5goq?=
 =?iso-8859-1?Q?LWgz1TAsAQ/H6mjHds3K8mh7ZX5vWfR3h2I0lO2mUGhQUgPu/otBbeuGOw?=
 =?iso-8859-1?Q?+n2Skj0drFWIwRYvuITLUL9bSRtivY2Dr9KeU7AcQRnEcCaRLLlIwUuoHL?=
 =?iso-8859-1?Q?ZQS2uJ0YNzgdJWVloliI0NsUrEyWolF1Qh8flraRND80Z3KfzOWacbKMR0?=
 =?iso-8859-1?Q?e8fFv/xtMkfociBCs9ismtY2tKbyyH+xaW6RNFVOZI/3sSE6eyKNU/T0Ur?=
 =?iso-8859-1?Q?v+jTksXPi0lB+/hMMqdT8Dmv/WZNtig6phLKfDpTKZK8gKmUyWoQ/47/H7?=
 =?iso-8859-1?Q?wEa/8rszhfSTmsGybs0mlBxVE8BrvvZLR12Ddyzl5DaPCGxmtCIMvQk/63?=
 =?iso-8859-1?Q?+oam2d4qMcYUc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB69978FF0504C5B108E409656A0212MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c5cf7-2f97-4a54-c07d-08dc3da361c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:05:10.8977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwCAXdakFI/aHVT4IRpy7z25dC/XuEbVDXg8ViDMGfWkY7t5DMM82b9ZgeYU82t6L/fhsBVYQSTkNJkyn7YVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
Received-SPF: softfail client-ip=40.107.236.41; envelope-from=poffer@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--_000_MW4PR12MB69978FF0504C5B108E409656A0212MW4PR12MB6997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

...after some testing...
[Trying to add 'libdl' to be linked with QEMU]

I did try to use 'g_module_open/close/symbol', but what I noticed is that '=
g_module_close' did not really unload my library.
So if I would do:

  1.  g_module_open(my-lib)
  2.  Load symbols, use my library...
  3.  g_module_close(my-lib)
  4.  Make modifications to my library and reload it:
  5.  g_module_open(my-lib)

Then the library was not really reloaded, and the old instance would still =
be used.

This did not happen when I used dlopen/dlclose.
Do we have a way to force 'g_module_close' to unload the library?

Thanks, Paz


________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Thursday, February 29, 2024 7:34 PM
To: Paz Offer <poffer@nvidia.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: What is the correct way to add linker dependency to QEMU build=
 system?

External email: Use caution opening links or attachments


On Thu, 29 Feb 2024 at 16:10, Paz Offer <poffer@nvidia.com> wrote:
> I want to add library 'libdl' to be linked with QEMU build for a particul=
ar target (e.g. - qemu-system-arm).
> Using meson I would typically do 'compiler.find_library(...)', and later =
add the returned dependency to the binary dependencies list.
> However, in QEMU I understand that these configurations are done in the '=
./configure' file?
>
> What would be the correct way to do this?

If you can do the job using the glib g_module_open()/
g_module_symbol() functions (which is how QEMU itself does
loading of plugin and module DLLs, and which on Unix hosts
are pretty much wrappers around dlopen/dlsym) then you
don't need to link against libdl at all.

If this is for something you're planning to upstream
then it might be worth talking at a higher level about
what you're aiming to do. (If it's for something downstream
that you don't plan to ever upstream then you can do
whatever's easiest for you, of course.)

-- PMM

--_000_MW4PR12MB69978FF0504C5B108E409656A0212MW4PR12MB6997namp_
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
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><i>...after some testing...</i></span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
6px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"><i>[Trying=
 to add 'libdl' to be linked with QEMU]</i></span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I did try to use '<span style=3D"font-family: &quot;Courier New&quot;, mono=
space;">g_module_open/close/symbol</span>', but what I noticed is that
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">'g_module_=
close'</span>&nbsp;did not really unload my library.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So if I would do:</div>
<ol start=3D"1" data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;=
unorderedStyleType&quot;:1}" data-listchain=3D"__List_Chain_113" style=3D"m=
argin-top: 0px; margin-bottom: 0px; list-style-type: decimal;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: =
12pt; color: rgb(0, 0, 0);">g_module_open</span><span style=3D"font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">(my-lib)</span></li><li style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Loa=
d symbols, use my library...</span></li><li style=3D"font-family: Aptos, Ap=
tos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: =
12pt; color: rgb(0, 0, 0);">g_module_close</span><span style=3D"font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">(my-lib)</span></li><li style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Mak=
e modifications to my library and reload it:</span></li><li style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: =
12pt; color: rgb(0, 0, 0);">g_module_open</span><span style=3D"font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">(my-lib)</span></li></ol>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Then the library was not really reloaded, and th=
e old instance would still be used.</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">This did not happen when I used
</span><span style=3D"font-family: &quot;Courier New&quot;, monospace; font=
-size: 12pt; color: rgb(0, 0, 0);">dlopen</span><span style=3D"font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">/</span><span style=3D"font-fa=
mily: &quot;Courier New&quot;, monospace; font-size: 12pt; color: rgb(0, 0,=
 0);">dlclose</span><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, =
Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color=
: rgb(0, 0, 0);">.</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Do we have a way to force
</span><span style=3D"font-family: &quot;Courier New&quot;, monospace; font=
-size: 12pt; color: rgb(0, 0, 0);">'g_module_close'</span><span style=3D"fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;to
 unload the library?</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Thanks, Paz</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Peter =
Maydell &lt;peter.maydell@linaro.org&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 29, 2024 7:34 PM<br>
<b>To:</b>&nbsp;Paz Offer &lt;poffer@nvidia.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b>&nbsp;Re: What is the correct way to add linker dependency t=
o QEMU build system?</span>
<div>&nbsp;</div>
</div>
<div><span style=3D"font-size: 11pt;">External email: Use caution opening l=
inks or attachments<br>
<br>
<br>
On Thu, 29 Feb 2024 at 16:10, Paz Offer &lt;poffer@nvidia.com&gt; wrote:<br=
>
&gt; I want to add library 'libdl' to be linked with QEMU build for a parti=
cular target (e.g. - qemu-system-arm).<br>
&gt; Using meson I would typically do 'compiler.find_library(...)', and lat=
er add the returned dependency to the binary dependencies list.<br>
&gt; However, in QEMU I understand that these configurations are done in th=
e './configure' file?<br>
&gt;<br>
&gt; What would be the correct way to do this?<br>
<br>
If you can do the job using the glib g_module_open()/<br>
g_module_symbol() functions (which is how QEMU itself does<br>
loading of plugin and module DLLs, and which on Unix hosts<br>
are pretty much wrappers around dlopen/dlsym) then you<br>
don't need to link against libdl at all.<br>
<br>
If this is for something you're planning to upstream<br>
then it might be worth talking at a higher level about<br>
what you're aiming to do. (If it's for something downstream<br>
that you don't plan to ever upstream then you can do<br>
whatever's easiest for you, of course.)<br>
<br>
-- PMM</span></div>
</body>
</html>

--_000_MW4PR12MB69978FF0504C5B108E409656A0212MW4PR12MB6997namp_--

