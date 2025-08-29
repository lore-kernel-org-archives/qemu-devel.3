Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36D2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNYr-0006RV-32; Sat, 30 Aug 2025 11:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zdi-disclosures@trendmicro.com>)
 id 1us37J-0001v6-Fm; Fri, 29 Aug 2025 13:42:25 -0400
Received: from muc1mailout5.trendmicro.com ([150.70.233.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zdi-disclosures@trendmicro.com>)
 id 1us37D-0007JN-4c; Fri, 29 Aug 2025 13:42:24 -0400
Received: from muc1mailout5.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id 0C2AD942EFD;
 Fri, 29 Aug 2025 17:41:35 +0000 (UTC)
Received: from muc1mailout5.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id E72139428DC;
 Fri, 29 Aug 2025 17:41:34 +0000 (UTC)
X-TM-AS-ERS: 10.36.230.32-127.9.0.1
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from MUC1-EXCH01.eu.trendnet.org (unknown [10.36.230.32])
 by muc1mailout5.trendmicro.com (Postfix) with ESMTPS;
 Fri, 29 Aug 2025 17:41:34 +0000 (UTC)
Received: from MUC1-EXCH01.eu.trendnet.org (10.36.230.32) by
 MUC1-EXCH01.eu.trendnet.org (10.36.230.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Fri, 29 Aug 2025 10:41:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by exhybrid.trendmicro.com (10.36.230.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58 via Frontend Transport; Fri, 29 Aug 2025 10:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUjI/I5WnQFuZBymM9zrsMvA+s8CdQos6iqkkVHICWqLb/ty3OP9OveX65L/a/RAvCj3Pgl536OggIrBiQ93S//b3JMKtfjKaScqo6crkGM1hrH573JoMHPnWXrRaNFsz4JrT5QDcktldBcSDBHXs4zwIyB6/bXGPWqSkit0S3OrKRkAfqWa0Hkgfk/hvAKIB1SbLWLW3ZIZ+bg3vkcBkRqG5PfsCIMhiFKGXjG7OmgUwNwf3gczq+Xrmv8b06al2Uv5vZXQW2vaVpln+zwosK1tZ5hCUAHJVraroq4kgONwrf6+JOFrC3KBWo49N9Dh17cI/YkyZoOqa4RJvKf8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J82tqNIX/PcA0wPMv88mC9fHABziqB6hQK1D/ZZGe3Y=;
 b=FSJj1pK6wtBj2A9oHS/uMNFoCYFQOXacKIYKcq7nPZeXnUgMANJezWwX6TromiFlhaN8IKvovPEwnCz3gZ4aBFdrTKkC+gerQXC0s1zVYIdonLcnc9zP5b7eeLW7if5xIqS2UGvSL8AyOMjGgg7ylpCPKD61jlfqFya4LXExlbKJKHxA6Rs4rnMY8bK0IFJiyaR+wmmwppXoTR9NXnkXF61Y4vEF9/XsSipp83mV392l8ORnrrwzpT+GV4hgo2s7L1+cMveMzcvPLds7SZradGQwh+FZz9+w0SaJtGKXYmNrqk0sfNq9fKHTE5R3OvdJ2WHePkNkfrbH0GC/KOe0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BN7PR01MB3828.prod.exchangelabs.com (2603:10b6:406:84::12) by
 SJ2PR01MB8459.prod.exchangelabs.com (2603:10b6:a03:557::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.17; Fri, 29 Aug 2025 17:41:24 +0000
Received: from BN7PR01MB3828.prod.exchangelabs.com
 ([fe80::a644:7313:8301:d1f9]) by BN7PR01MB3828.prod.exchangelabs.com
 ([fe80::a644:7313:8301:d1f9%3]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 17:41:24 +0000
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Mauro Matteo Cascella
 <mcascell@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in
 uefi_vars_write callback
Thread-Topic: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in
 uefi_vars_write callback
Thread-Index: AQHcF2PHnGcyBSsdNUqy04JKj5fs6rR56WOQ
Content-Class: 
Date: Fri, 29 Aug 2025 17:41:23 +0000
Message-ID: <BN7PR01MB38281A0E41A6B3A681B2A2F8803AA@BN7PR01MB3828.prod.exchangelabs.com>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
 <20250827150323.2694101-56-mjt@tls.msk.ru>
In-Reply-To: <20250827150323.2694101-56-mjt@tls.msk.ru>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=aadc1253-aab4-4448-9e54-833f277c6722;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no protection;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2025-08-29T17:41:20Z;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10, 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR01MB3828:EE_|SJ2PR01MB8459:EE_
x-ms-office365-filtering-correlation-id: f92d7aea-cc84-4bf2-82fe-08dde7234600
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YCXV5fzjUpEfewqjVJGccsU/XkM58HyYw6NCmwcJe8G1vi2/PbazI9IKLz1X?=
 =?us-ascii?Q?PyKnMfh3aRufpA4WpK8/ANLK0TQMVk/ZpDX2OEBAQmdvwxcSS+A1sMLxMbJC?=
 =?us-ascii?Q?/uQ5gPJcCRGk1IXjfZgtRvvI8mVZhBeonyLPyRWycQjD99tPgJeDUv4AelLb?=
 =?us-ascii?Q?kvzJ9IJOX9w+K1QAkwEXB4i4z6M+a21AsjV8WMn12Y5AMXr9m/0puMwhXGTu?=
 =?us-ascii?Q?grT9wJxQ777z59dtnCwODcRy195y4mgrMitLlouf+izOfI5JNwRiuc0s5Nd0?=
 =?us-ascii?Q?PTUh8DepwuxH6fRY8u4ssmhrvH7Azcq1pgNq64b5zyHIpgBNj5EUMbCOJdJE?=
 =?us-ascii?Q?2CNSJZMttnwx2enLbTHw8pra6nVrTwIob7zrssVek14STyxXcpoXYF5b8h/7?=
 =?us-ascii?Q?LhZzEDCsQh0di5GbPc8L8lmxDNv5xlly8+pdgcssFcWHK/qNfonmdjGsobCq?=
 =?us-ascii?Q?17hyk2Y6zUV3FX9Q1EJxpRwJMRBqVLW0JIEe8eRqrPxnd7IjZj5Jm8MU2+6k?=
 =?us-ascii?Q?iMqsaaV5fhicLbf9Y/K3fNEnooL09BheGFoHV3gEUmX2I8vCDQN4M8I2oMTo?=
 =?us-ascii?Q?BuOGGVI1XfHz720ZcM70n02+PpfLGpnENfHOpu0koFqN4aHTWZKByYtqwea9?=
 =?us-ascii?Q?ooxMR1LzdnWw8H9qnh5OnBhFv0BdKt9YeHJbxjhMELIc0A0epdudO/hZXMSa?=
 =?us-ascii?Q?S16Q7LVniiXM1enMhwWIjL46PDCcHMSkDokC1yKgZTXF4Lk1SkUHKi+13efx?=
 =?us-ascii?Q?wB7ZLLDzNT9R8ZlDxCQqvPypk/mqOWoLAxvunDn9netj/R63Km//I1xtbZ9p?=
 =?us-ascii?Q?MhZeN78Ip0G+fuOwSqFB2+oGFHFiiDhW0JaRJg81L5m1WCS0uehS5sOYp1Aq?=
 =?us-ascii?Q?WJjQ8HVel5Bt/2gKWfEqecFKt/3uih4eAXkxVZwkNf/KgUPbmOq/8+VcsfNB?=
 =?us-ascii?Q?vWJiKaSVnYj075Yt/Rpm4rzTKy7JJ72y5W+ZxcEeDaO1THR4GT8V7w4IIQQW?=
 =?us-ascii?Q?PE+3f7jgrYWmL4M//HBGfkb4U3cXPScDNvwmOjKcQ25Qrz8efLwIVmc1iE1l?=
 =?us-ascii?Q?bXV04G8/pWPdF8fJPBREEs+ExTz3JWub5hvtNsF/jLFdzK3eMYI5u8VZPpuB?=
 =?us-ascii?Q?8d6QNkF0qLHNbvXDcRgXkv3bjxagX2UkddiXw58Sh7aFXo4vjSWRATM+O23V?=
 =?us-ascii?Q?SClg7V04yUxp5m75hmBJRjML64bu7A4MlahElI9VefKhjiZQGv1z9dfaSV6Q?=
 =?us-ascii?Q?DT5G1XYZJNELm1ZiE42p/XnmgIJSw/GZGiA0Sdb1xn/60X6pLS9ilvSgu96D?=
 =?us-ascii?Q?mjDx4fzNBNc1rb1nRRSYbfAK+vrIVReq+QrLFjZLI5X8NZCGyujdvYDOqvhd?=
 =?us-ascii?Q?6ICSo+c/jDPlDolHpTJ5VQvPOXEpjf3vtQo+2pOzRfJ+f15QaJPaU6//u0HH?=
 =?us-ascii?Q?aokB09vouAnooDU5NO1sV+ieGUnimZ91mx9h9zzizGwEVtRv1d+2jQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR01MB3828.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gEePSe5PmflbhTxhNaQ2/eDhH5XgT/rELhgrZhmFjdQeRDu8EN+JdpmOVxQp?=
 =?us-ascii?Q?O68MT5QxOLFgF5fIiCfSjwhVv3Z4ag+s57uZbTqB3vuWe9f5PAPCBc7IEAHU?=
 =?us-ascii?Q?m+L1kSrR3ZrMwP80j9b2e7FoMIPue45+qACBrD2zYFJWNv2nhoVLPuSdTalY?=
 =?us-ascii?Q?KTKkJRVoltc8NnrFra3m47rUhKpH1gALYuHDXeh6ZmW3rEf5QKBUrM6d47w9?=
 =?us-ascii?Q?ZVLXMBqix9JYcLM4EFnOF0ycuDxyQHxVZWKEismeHPOrJvq1hTt1UsQqvkYL?=
 =?us-ascii?Q?GRlCmkEeDL97XBsxKSCLXG/IQn52rY8Nwmf0NDHgQ7y82ihH53sN86vkwF08?=
 =?us-ascii?Q?lEmhKHss4p6tmfCROtO3ylVC6+j/BwIAJtS6EBo0Z7hKXGr6cyCmez55HEJE?=
 =?us-ascii?Q?U3Bvg8kdmeW3US9+V+6OxJSxZvzgnSe023vTO+d63TCyRM3ZkwY+sXychj1I?=
 =?us-ascii?Q?OyYOBg5tZq4G4Zoc6PAO+uehhszfiZq1x2zxoF329o3j4OkNNMKD7IIVn09h?=
 =?us-ascii?Q?uQrR3116i3T8hPqG3FHyKNXWe3zECETEf6+bf+tc7Vj9h2o+la1bKvXWGESD?=
 =?us-ascii?Q?+rhyee9l3+GLKhAArayBlOa9hu69zo9lWTie4eZ9HnAWIuA6TNJw+1PIUzk1?=
 =?us-ascii?Q?gY8KCCDFRDgBO9dkB9rYQipzK+r5comZ3f9KtqTlcxbUzjqdvglDr6vrGTgY?=
 =?us-ascii?Q?IWI2J88rhd4+fQC6OlQw+90vrGCAEbv6z87uBcDCYDhUFc0+2t/xYn/vzdhg?=
 =?us-ascii?Q?EGD4fZ+eHnUyAG7fw7t9vTmAL/lRRHuAz16QUQ5Q+8/x5eMJk6xSWmRdFak2?=
 =?us-ascii?Q?J0BhaXVGLYJDcIqUleisBniODH8VT5y17VZrPsvtEyQln9e1H5jsc/ALyh3r?=
 =?us-ascii?Q?JJhBL9s6TehmGeEfgoljsQy9ZsiKHpwGcf0MLAsNSLEHUdiuTvc2CCVaPAvA?=
 =?us-ascii?Q?mUGOolS3btR+tecFaFLmmFQlgylqGk46hqsg21w1ZTCk9nQn/BBN9I4TRDpg?=
 =?us-ascii?Q?bA0URNPkOantSdS+6OBEdiGs6rntuF8JlYM1qoYqRjs7DDQDS6nICWMT5dS2?=
 =?us-ascii?Q?/9CJzXxZ0CPIQibmZq1GI/WCgsQBTSEf7r0Ts4/X65mzWW7B1hhAt3Rfsa9l?=
 =?us-ascii?Q?PjpdDb4zAKKZyk16PBW0wyhccUlZKMwaTZAmQBcQwu6k4VdwsCl2FCa9WH+h?=
 =?us-ascii?Q?wUBO87RMwHIs14e6fLrNDf0U4RHsxAOBfJqZnN+YiFq0yvfeQ5+i6BB+rClw?=
 =?us-ascii?Q?yo+eVGQpCEzMJdytqQ3pjxymRFuvh2Jk0KeW5j2eqcAK3l8Ol7kqc2tmwVEY?=
 =?us-ascii?Q?xRlfCZs2vdway7nf6WIJht8SEopw4x+MqGbCgKGtC+iYp1c3MHTZbj+qtf+E?=
 =?us-ascii?Q?0K3GCRyxMjnird3qWCNT3ERYxkLTs0GueOuyPGz0VLQUMqyvBFMYus1XPas6?=
 =?us-ascii?Q?fSGA0HvB+uvnIVXOxV23i2TU0eQpkDormN/CgWaq95i+9JABvX8LG3GoUjH5?=
 =?us-ascii?Q?wbskgjqr1DbMjUJ0TEfAmz1BbnJMw7k3lpVU7bEiJ09UKSGCWImT7dk4hL20?=
 =?us-ascii?Q?X/vgb+GEGoxxs33FmTXBdXmC+AGeDC5fXT4vQSjL4+5213IlvPp/8IALPVgU?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR01MB3828.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92d7aea-cc84-4bf2-82fe-08dde7234600
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 17:41:24.0645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /l0jm0eknNyKDzYaZYcMuyhj3mR/SFDJAjlyRo7xu2O3MKc+wOYninkTNWO28dWneahNxmQ7BZE31RzxE9jHuKdh4hMtkw0nvPjGyQkMnV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8459
X-OriginatorOrg: trendmicro.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3197-9.1.2019-29414.001
X-TM-AS-Result: No-10--7.303800-5.000000
X-TMASE-MatchedRID: lTs3FaoAhFA9AUcVR4lIKSyIz3xZbkbDu0Vc3uzvEj6GofH7gGFXU3w+
 CZpzsMCaIAzxAoAh/olrJxw5yixzPM6NWEzfFbas3ArdopcuUsDPaW4rD8GWjE8Amukj7bVmw5n
 Zy2X+Nx54HeL9ZphsiMpkM9wXd8FvKRerQFpH33PlySm49SpDhlAqbze9rAuEKz7J6ouUh1VBdc
 wCZOPOLwXesDxcxaSYxGtU6llEG/dg0/lm98YAq2VH1BwNi2os1S6yX8lVpE0Eriiju0mdkYvPi
 Bq/iW91MpPx8OFzfY3mxR64mlRzv6DC4fK71SwsDOAJ4SaRAXoLgXaeIFHdZfxcvA3b4B4wZ6yq
 OckdnS0ibGdC+CRqLYNKqakm3PKXJtNQgJlRY+pzu/QdJvrtwA7uoW6o8f/I7Nz043uRSg1+GSh
 PSjtA9A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.303800-5.000000
X-TMASE-Version: SMEX-14.0.0.3197-9.1.2019-29414.001
X-TM-SNTS-SMTP: 057DA6141C8394AE13A307E866745D03B63AF04AE6C33E1270E782822D8399762000:7
X-TM-AS-ERS: 10.36.230.32-127.9.0.1
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
 s=tm-outbound; t=1756489295;
 bh=F0gDqP74UNXZvIeSpCYg0AuPRi33uk2MpQtjuKofVuU=; l=2858;
 h=From:To:Date;
 b=b+Zbi38cN+FHELFZB6WeVp2USKAJ1ZzWra0ic/g+B0RNmR0nHrDqHmb/Thkah1679
 HVqN81WKcGEy/LcgP4OpS1G2sIXKaRmW0Rtfl/v6ebZKug7BfIXpM58HSzaJEPgplI
 glPYtniP9MZ932Lr2ELIUNhLqoi/ZmOfX0LUq8fXBy6P32PBbEMaJWbh0GFQZRVm2P
 B0Q8//EF3pDDJ+qJkXR/9iNqXqtQYDxh00X2PDeoezUtwjwqW0di7zfacBxSbZYbNf
 KOpJW2NXwiF3/VDsxgITR5n+dTntCoh/2FORXBkeW/t2MFXr+OeIsHG10P1G6EvyuQ
 oOXJu0Cbiq5tg==
Received-SPF: pass client-ip=150.70.233.80;
 envelope-from=zdi-disclosures@trendmicro.com; helo=muc1mailout5.trendmicro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 17:25:05 -0400
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
Reply-to:  "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
From:  "zdi-disclosures@trendmicro.com" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Team,

May we know the ZDI-CAN mapped to CVE-2025-8860?

Regards,
The ZDI

-----Original Message-----
From: Michael Tokarev <mjt@tls.msk.ru>
Sent: Wednesday, August 27, 2025 8:03 AM
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org; Mauro Matteo Cascella <mcascell@redhat.com>; ZD=
I Disclosures Mailbox <zdi-disclosures@trendmicro.com>; Gerd Hoffmann <krax=
el@redhat.com>; Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in uefi_vars=
_write callback

From: Mauro Matteo Cascella <mcascell@redhat.com>

When the guest writes to register UEFI_VARS_REG_BUFFER_SIZE, the .write
callback `uefi_vars_write` is invoked. The function allocates a
heap buffer without zeroing the memory, leaving the buffer filled with
residual data from prior allocations. When the guest later reads from
register UEFI_VARS_REG_PIO_BUFFER_TRANSFER, the .read callback
`uefi_vars_read` returns leftover metadata or other sensitive process
memory from the previously allocated buffer, leading to an information
disclosure vulnerability.

Fixes: CVE-2025-8860
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Reported-by: ZDI <zdi-disclosures@trendmicro.com>
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Message-ID: <20250811101128.17661-1-mcascell@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit f757d9d90d19b914d4023663bfc4da73bbbf007e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 4836a0cb81..92fc121fe7 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -259,8 +259,8 @@ static void uefi_vars_write(void *opaque, hwaddr addr, =
uint64_t val, unsigned si
         uv->buf_size =3D val;
         g_free(uv->buffer);
         g_free(uv->pio_xfer_buffer);
-        uv->buffer =3D g_malloc(uv->buf_size);
-        uv->pio_xfer_buffer =3D g_malloc(uv->buf_size);
+        uv->buffer =3D g_malloc0(uv->buf_size);
+        uv->pio_xfer_buffer =3D g_malloc0(uv->buf_size);
         break;
     case UEFI_VARS_REG_DMA_BUFFER_ADDR_LO:
         uv->buf_addr_lo =3D val;
--
2.47.2

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>

