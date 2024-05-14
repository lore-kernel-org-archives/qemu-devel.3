Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A9EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6kJS-0002kp-HB; Tue, 14 May 2024 01:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s6kJN-0002jx-LD
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:02:50 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s6kJH-00051C-4H
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715662963; x=1747198963;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lM0DgWo9txUQeJdVJvEaMXDT89zh/7G/2cqSf/4imL0=;
 b=VtUgDBibKL2sLB78AznOFrxLkXyaf4YbsqvByf3HwklWGaCLZO7A1HEV
 9c2UObDComTlHdz3x3yt21NI4ZLAkyNiJ/PGnWt226sHGdvcge6EUIH/H
 d+jEbjU4HTI271z22gete2feaLqIHTsYGfOTpbRZZDrHGg3q7P03Dofy4
 cfTi3FLMEq+G5sgTxDO/Sa1G/clkbaoxNF6xJ6HBpjZRTmyioSCiyNHMQ
 TzJIwSpim1RKLg2lBBCS2W/aOyPCKjN1R73AlVEfUAYYHYD+1Dx9Hnz/h
 aVb9FZVepd4RbdV73Cyg1WYQr/aXTF81QH2wA0t3pwfI1Tb5Aj82cUdXJ w==;
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; d="scan'208";a="12484435"
X-MGA-submission: =?us-ascii?q?MDFxAnP33HgSDRyWOguhgMWvWpWo/dr+jyFgPB?=
 =?us-ascii?q?jkOH+ptAFFtVSkO2AxIgSiqajmdPKVwUbcyu9jp4FB2ZoAZ8GbwfuzPq?=
 =?us-ascii?q?iQpDStBnRWlr8mZAmwKVSacesX35/CSc3+4bLY2A8xFHTKD67bEEzvCu?=
 =?us-ascii?q?Vzs6/zv2LX2Ng401fSGvRMcg=3D=3D?=
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 07:02:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHxLoZObyeO5+ArHtwviVaIES0Q/QKY1eo9pmWkoCJJEhv4lBHrVWH4qhbhGj2wpUYgjmg82zUdyeQrgLYr+SFAsXZxam0iGOfCoDUNAsjbEh2G61o82hHBHy148ZQtQH76emLeT0JlCNQcjq3zrxCNVoS0jGHuOzeNW/1xC/WJDyUWuGvYXSriAfUFowpNQMtLnGcFE/JVGdm3fxc8kTHNRQngOiNvw7lEUwGDnGRZREzUhi0kRR2eRwRxvDWHaKBzivnRvaNO2q2XS00mdw6Nc9EOPQszxsDDrBprlfdYUIXWpk3QrZIB8c1Sar/AuxkMiwwhgYq+UKbs+HRELrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM0DgWo9txUQeJdVJvEaMXDT89zh/7G/2cqSf/4imL0=;
 b=Herz3KFTKdLvY5axQ2Pubw60NOEuFRoX1LxpN3IVuEm3RzbzoB5QfbuHbfQ+GwnbZzO1eEI4bYYovKghWWT4Tyq9aEfYl2aT/D2XoE/bkICjJKFSNRzgc6buhhEPu83Gt1eMxmXKnuz2Vw8qm1dlyZrLqimlebwbjygvPf38eicSlu2uEElwLT02Yg44ABztI+vemai5LS1LvYdb5iAzPGi28UjwkV7J219AKykPAPVXYSkEnqNHjDEN1yDyzuIbg12vsMsBkz4U7MdY1NJ66zGrwC0P7EucarCSPcnB8ej6rq/5tEzXDlsgf3njmkUqDIA30NWTpSrJRxHUJgAyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8596.eurprd07.prod.outlook.com (2603:10a6:10:31d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 05:02:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 05:02:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHalM0ix1VtZwm0bkmmtp6S6avLxLGA52yAgAF4ZgCAARK/gIAGD/KAgAzLsoA=
Date: Tue, 14 May 2024 05:02:33 +0000
Message-ID: <d150cb99-4575-40f2-a3bd-f4143afaa14b@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
 <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
 <SJ0PR11MB67443F458DB55397FA4BF58C921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67443F458DB55397FA4BF58C921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8596:EE_
x-ms-office365-filtering-correlation-id: fb819afe-69fb-415a-ebdc-08dc73d310ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?aVhveUdRaklOcEFPV25LR3VTalFGRGFvYXFBblVuNG1KajRHSERGd1RNU003?=
 =?utf-8?B?d2JSSm4wdDdnZU5PcHAvWG9jbkN6TVIxeVNycnc3YkpKekVLc0tQNHRMUVg5?=
 =?utf-8?B?LzJUN21US0g4SW9vYUFBQ2ErVUhHUWFDdkZTQWowNk8rL1htY1I4Qng3cFkx?=
 =?utf-8?B?MGIvV0hXZ3RkMGUrMFI1dmdxd3JEN2cyeEl6UVMvUGtWOTRsSmlvMmxYV2hw?=
 =?utf-8?B?S25sUXVQTGpkeC9tdEU5RnNuTHZFWUZEUXRKMTdNTldwdUR4NW4wYUF4VFB5?=
 =?utf-8?B?NzR4dk52bytwYldIOGdYZzc2VE5DUHdoNncydENsOEZpWkp0Nkp5Q3JsRFVZ?=
 =?utf-8?B?OFVKZm1IRElJZU1ydEE1blRjYW16bTBlVllBcXk0R3lJY3NMTk5ZMGxEM0x1?=
 =?utf-8?B?OU12cENobHFEOGk5czN0YWxqNEhJYlo0VEVGN0p6RlNTU2JkSTNuRFdMRnNV?=
 =?utf-8?B?VUdaM1QyY1JFeU81YnRLaFFSRlluTjR4WWU4Q0NOcktZemRyK00vbmpZVis3?=
 =?utf-8?B?WCtKbEpUMUdHdUNKVkF3dnNqZVpTajdvQlRqQUQ4QytCRkpEZjVFWExXb0wx?=
 =?utf-8?B?UWhmMDNma0xVVXAyb3p2cU9uRUNtR2d2eWpXSVNobnJRWGVTUHk0dUo0VTIw?=
 =?utf-8?B?UkxiSzFVTzdnY1lnWXpUWmJ2V3p2RWFkSExxRy9ta3RSSGlGeVpCTnJyajZW?=
 =?utf-8?B?THozODNXdlZWdWlqVHJSZHJqQlRET0laSlZZN0s1cnp5UUd0MFZBbERMY2Nh?=
 =?utf-8?B?akVrRGtnOTdmWmRocUpqMzZyTjZ3UFJRT0dYd0wrbWI3Y1F6TG9hdFUxZS9E?=
 =?utf-8?B?TTJDajhBQmN3T05XWmhyRTUwUUlWZnZIekVYZnpLdk5hRmtKYjhOMUh2WFZQ?=
 =?utf-8?B?Q1Rxa3hRVFhZenJ5ekE3Vzc3cG00Yk14d2dFYXkrN2RUV3NYT1ViSXhWVXBE?=
 =?utf-8?B?SFc3MTliYnpSMFluT0NZMWlhRTJSN092emdTWTN4UU5sSm9UeWxSLzd5R1R4?=
 =?utf-8?B?WHQ0M3QrV012L21xUkNpWWNManl3Qitwb1V0bTFRU25hVWw3TEd3bzAzcVNO?=
 =?utf-8?B?cVlQbExNaVpiUmk5aUlsQWVSS0JzZEszdHJ6d3Y2WmhrSk9IWjdaa3pnTnVD?=
 =?utf-8?B?YkQ1cks5bGFDem9SVG9INFQzdmw0ckFiUlh3MlRyVTJtRHFWNjhlTG83dm9h?=
 =?utf-8?B?cFFEaXhGOHA3VnpIVzUveFBVMHZvYnhHM0Fpb0wvQmo1cXBid2JQRkRYcWUr?=
 =?utf-8?B?V3EveE1ueEJoMmp4eVcxcG9FSVFEYU83eUlBWUt1WncrTTNsWTFGU1Q2V0Fo?=
 =?utf-8?B?QUNCbDBFUW55REtjTzBLOWdkakhTSWlzTTBma3RzcFVrWkNaa2QxcS9waGJD?=
 =?utf-8?B?UGdWK2lOMU83bWZjcDNjdG1KRmltVmwwaTZVSXNkVDJhdGtLcnZCaVk2NUll?=
 =?utf-8?B?d3dYMnMvMjVGWndtU1VybUJzNHphQU4xSlJWMXhQWThIeDM0U0o5MERSclRi?=
 =?utf-8?B?cXc1SnlRL09KV0E5Slk5aUgyM1FRVFJqcnphYTQ1ZFk2N2RaNHQySlc1eHdl?=
 =?utf-8?B?Vk9ZTDNOdUZVZjZKZG5SaDZqSWc5QWx1ejFDMzZjeFRsSHo3QXJZS2s0QUtB?=
 =?utf-8?B?MjBia1BTTVNhU1JyWld0ZHpycU8zc2M3SmVqL29ySTlkL2N1TWF4VXM4VGta?=
 =?utf-8?B?aWNWem0wTEJGZU9leWJ6SXFWYnk5djVRTWRka0plUitGUS9rb2Z1cktJeGdk?=
 =?utf-8?Q?eFtTKwlEk+vLJcT6QI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WndFbi95OUhBMkt3amllNHRyYjZYMkJDT05odHZVQWVNZ1VqWEFZaXV3Yy9H?=
 =?utf-8?B?YjV1bXpDQU9EY0RKUGMxeC9OVWpRNGZ2OXR1QzMzd3p6L0hiZmowTVRGMWtY?=
 =?utf-8?B?MVgrNTQ5Q3lKQWhlejJjU00yekd2NkJLSm53aGcvVGhjUmpsdGtscUxEd0o5?=
 =?utf-8?B?VitaQ2VYUHZSeVo1L2lnVU1LdTZ0MUFPTkdRc2NRaU5COXBLelFNM2J4M1FD?=
 =?utf-8?B?ZGoxN0tpb0NXN0VxNXVaUXEzRjFRbWVkTTdxbDRjRk9xK2FIOTd6UGw4ZDFI?=
 =?utf-8?B?T3ltK0FGdEpFcVJpaE5oeVZOUVl3azRPZlpTd1N4NlRuMDIwcmF0b0tXdjZE?=
 =?utf-8?B?Mk1tTTBsMXVUSGoyTUx0QXBUclAzdVBkUVVRZmduQjdVdlhlbFhlSlNrUUFh?=
 =?utf-8?B?VC9pRTJMSmRVcWV1V1A0RmRCNHRkN08rMUxPTE84YU5keVdLZ2ZSWUROYXNu?=
 =?utf-8?B?WlFRV29SVTVsc25aMVhSSFdZNFRoR2RCMUF0MzEyam9iL0FyQ2NWWW0vZitr?=
 =?utf-8?B?VjYycXhsRFl4TXZLWG1WaFREZTEvMmY0Y3pYN0hYaGI1Nm1uZmF1NWt4Vnp0?=
 =?utf-8?B?VGJnZ1JPa1MzQXdQQmhFbG85U20xY01adFIrRjVpb0VjV04rK2hyTFZHaXRD?=
 =?utf-8?B?THQ5U1FFYnppMnFRcCtraVZwUFdGRTBYNkluSldhWGxkOFRvWEluNVl3SlI1?=
 =?utf-8?B?UkIzNmttQU9lVXVqS1dreURQcE40VEk2ZzZ4aGNsYW9MSDNmd1J2TGVLMm9h?=
 =?utf-8?B?ZWhsbEVPQUloMllzZjFtd1dhekV2QmJ3dFdWNkNJYmIxWFpkQ1k2YzFGNHlm?=
 =?utf-8?B?MHNmTzNBWU51ZnhoT1ZmMjdFT1BTTmREcTZrRmNSQmxXamdublZTQ20yR1Rs?=
 =?utf-8?B?cE9tczJGNkFwbzFhOWFrVjQvc2k3V0F3K0p6aW4vODdLWVM4aG1Ic3VyWDc3?=
 =?utf-8?B?eFZjYlBqamNjdVVCMUlXbVcyU3hMbGRtelM2SDhIT3pUTVhRd2xPaHNYclhw?=
 =?utf-8?B?MlQ3QTNFNjM0VTNMRlV6VzNXMXh0MDNFeUNTVGhlSTE2YkVPS1RpTzVxQ0hC?=
 =?utf-8?B?Y1R3TkJnTXd6c3FodXoySEJ3T1ZrVUN0c1hXbUdGVTJjK0doOTh3Z0U1NGpz?=
 =?utf-8?B?a0dmUERCNEsrNHBCQkZ2MUFxc3NiMHYxQ2QyUDJwQlhkRktyTGpwSGVoWXVE?=
 =?utf-8?B?c3RaazA4YllFWjVCalZVbG9yVVhsWldBVDhnQmR6VTVqQUpuNW9EQy9CNlNq?=
 =?utf-8?B?UExySEwxWDcwV0huN2IxR08yYmVaUWcyZUk1aUgyK1VWQkVXdTA3dFdhRDJV?=
 =?utf-8?B?eFNxM3Z1MWZ5clh6N2xPUGM4WFMwYk5oYlpOblN1YnFhYmxiNGVhRGJhZ0RY?=
 =?utf-8?B?QlpURjg3bXBNaDVUQzRsNUZZRURQOTYzUldvc3VvYzZHSFVpTWJPRGQrSFdo?=
 =?utf-8?B?eVdvUUgxcGpOUkk2VFc4NW1pZHRuSUhEYU5OTGtiREJKRGtFeTlUcy9nYThU?=
 =?utf-8?B?YnNTY3JvT1JEUC93aEtBcWhmUHBIYWZvWkNDMWxMN2ZmY09iYkR3cTBrS0NL?=
 =?utf-8?B?bWlmanZHa2MwSnQrY0pQdjRkZ3ltR3ZZSC8vZk9UeFlPOE9VclNRZklwdVpH?=
 =?utf-8?B?Y2RFOEFaVy9sdElBY3dZSk5mUURuOU9PWGpvSEh2YitPdnpoQnJlaVNUZkhp?=
 =?utf-8?B?Z2xUeGVMYkNxdWNrSnBxcHN3K2xSSGc3Y3o3Vkh1T1ExbTFGS3kyUTF5WWVH?=
 =?utf-8?B?VXlvUWU1ZjFxSWFVcWdESmRwSzZlSUNxY3V6eGYxbXBQaGtZcWY0Qm9lZWVP?=
 =?utf-8?B?QlhYWEFicDJjb3FsUWM0ZUZaVDNUV0tBamxFQzdVeU92MEhlZUx6UVNNZlZE?=
 =?utf-8?B?N3Bna25rdE51NEIzMGUxd0NDWG85TkQ2OVlsQ0lQTmpvNGY5dmI3TzBkeEsz?=
 =?utf-8?B?WGEzTHNiekN0ZFNBWVRJd1RiWHZEOGZxd1pudTNwRFd6eGtvZ2M2TkU5WmNo?=
 =?utf-8?B?SWZpaTdsbERZUU9NOEMxaXM2M1FlVWhweUtndklxM1ZrblpCSlpyK01HV2Rs?=
 =?utf-8?B?QVVNWnVhYkhmYVA0UVBVYzJkd3VrUjJoNnhjV3BEeDZ6TG56dzlEMlVybkRU?=
 =?utf-8?B?LzcxREdZbkJsZDFDOWx5a2pWQkdEeTZNa3BzRklzdGgrMVNIbW1VcUswNno3?=
 =?utf-8?Q?JcRFZ/FXKtrkvq1hGNuN7PQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <707BFA63A61D4E4D86F861A840694C7D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb819afe-69fb-415a-ebdc-08dc73d310ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 05:02:33.4558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nm9tqrp6vIVqZLoSs1iYjToqSmmScIMaWpfQUumD1peeLyeW38AAQZQnbEM+xVokg/nPzfgH/A0IGV6gP1hwi/VuniqqsCQzoT44b95MK1RSpsoDO9fYtzKs2Y/e2k/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8596
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgWmhlbnpob25nDQoNCkhhdmUgeW91IGhhZCB0aW1lIHRvIHJldmlldyB0aGUgQVRTIHNlcmll
cyByZWJhc2VkIG9uIHlvdSBGTFRTIHBhdGNoZXM/DQoNClRoYW5rcw0KID5jbWQNCg0KDQpPbiAw
Ni8wNS8yMDI0IDAzOjM4LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+IENhdXRpb246IEV4dGVy
bmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNz
IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gSGkgQ2xlbWVudCwNCj4NCj4gU29ycnkgZm9yIGxhdGUg
cmVzcG9uc2UsIGp1c3QgYmFjayBmcm9tIHZhY2F0aW9uLg0KPiBJIHNhdyB5b3VyIHJlYmFzZWQg
dmVyc2lvbiBhbmQgdGhhbmtzIGZvciB5b3VyIHdvcmsuDQo+IEknbGwgc2NoZWR1bGUgYSB0aW1l
c2xvdCB0byByZXZpZXcgdGhlbS4NCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0KPg0KPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8
Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENI
IGludGVsX2lvbW11IDAvN10gRkxUUyBmb3IgVlQtZA0KPj4NCj4+IEhpIFpoZW56aG9uZywNCj4+
DQo+PiBJIHdpbGwgcmViYXNlLA0KPj4NCj4+IHRoYW5rcw0KPj4NCj4+IE9uIDAxLzA1LzIwMjQg
MTQ6NDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFp
bC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+
PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlLg0KPj4+DQo+Pj4gQWgsIHRoaXMgaXMgYSBkdXBsaWNhdGUgZWZmb3J0IG9uIHN0
YWdlLTEgdHJhbnNsYXRpb24uDQo+Pj4NCj4+PiBIaSBDbGVtZW50LA0KPj4+DQo+Pj4gV2UgaGFk
IGV2ZXIgc2VudCBhIHJmY3YxIHNlcmllcyAiaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRy
YW5zbGF0aW9uIg0KPj4+IGZvciBib3RoIGVtdWxhdGVkIGFuZCBwYXNzdGhyb3VnaCBkZXZpY2Us
IGxpbms6DQo+Pj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVs
LzIwMjQtMDEvbXNnMDI3NDAuaHRtbA0KPj4+IHdoaWNoIG5vdyBldm9sdmVzIHRvIHJmY3YyLCBs
aW5rOg0KPj4+DQo+PiBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0cy96
aGVuemhvbmcvaW9tbXVmZF9uZXN0aW5nDQo+PiBfcmZjdjIvDQo+Pj4gSXQgaGFkIGFkZHJlc3Nl
ZCByZWNlbnQgY29tbXVuaXR5IGNvbW1lbnRzLCBhbHNvIHRoZSBjb21tZW50cyBpbiBvbGQNCj4+
IGhpc3Rvcnkgc2VyaWVzOg0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2t2bS9jb3Zlci8yMDIxMDMwMjIwMzgyNy40Mzc2NDUNCj4+IC0xLXlpLmwubGl1QGludGVsLmNv
bS8NCj4+PiBXb3VsZCB5b3UgbWluZCByZWJhc2luZyB5b3VyIHJlbWFpbmluZyBwYXJ0LCBpLmUu
LCBBVFMsIFBSSSBlbXVsYXRpb24sIGV0Yw0KPj4gb24gdG8gb3VyIHJmY3YyPw0KPj4+IFRoYW5r
cw0KPj4+IFpoZW56aG9uZw0KPj4+DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
Pj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+Pj4gU3ViamVj
dDogUmU6IFtQQVRDSCBpbnRlbF9pb21tdSAwLzddIEZMVFMgZm9yIFZULWQNCj4+Pj4NCj4+Pj4g
SGVsbG8sDQo+Pj4+DQo+Pj4+IEFkZGluZyBhIGZldyBwZW9wbGUgaW4gQ2M6IHdobyBhcmUgZmFt
aWxpYXIgd2l0aCB0aGUgSW50ZWwgSU9NTVUuDQo+Pj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4NCj4+
Pj4gQy4NCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4gT24gNC8yMi8yNCAxNzo1MiwgQ0xF
TUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4+Pj4gVGhpcyBzZXJpZXMgaXMgdGhlIGZpcnN0
IG9mIGEgbGlzdCB0aGF0IGFkZCBzdXBwb3J0IGZvciBTVk0gaW4gdGhlIEludGVsDQo+PiBJT01N
VS4NCj4+Pj4+IEhlcmUsIHdlIGltcGxlbWVudCBzdXBwb3J0IGZvciBmaXJzdC1zdGFnZSB0cmFu
c2xhdGlvbiBpbiBWVC1kLg0KPj4+Pj4gVGhlIFBBU0lELWJhc2VkIElPVExCIGludmFsaWRhdGlv
biBpcyBhbHNvIGFkZGVkIGluIHRoaXMgc2VyaWVzIGFzIGl0IGlzIGENCj4+Pj4+IHJlcXVpcmVt
ZW50IG9mIEZMVFMuDQo+Pj4+Pg0KPj4+Pj4gVGhlIGxhc3QgcGF0Y2ggaW50cm9kdWNlcyB0aGUg
J2ZsdHMnIG9wdGlvbiB0byBlbmFibGUgdGhlIGZlYXR1cmUgZnJvbQ0KPj4+Pj4gdGhlIGNvbW1h
bmQgbGluZS4NCj4+Pj4+IE9uY2UgZW5hYmxlZCwgc2V2ZXJhbCBkcml2ZXJzIG9mIHRoZSBMaW51
eCBrZXJuZWwgdXNlIHRoaXMgZmVhdHVyZS4NCj4+Pj4+DQo+Pj4+PiBUaGlzIHdvcmsgaXMgYmFz
ZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQuMSAoTWFyY2ggMjAyMykNCj4+
Pj4+DQo+Pj4+PiBIZXJlIGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlv
dSBjYW4gZmluZCB0aGUgZm9sbG93aW5nDQo+Pj4+IGVsZW1lbnRzIDoNCj4+Pj4+ICAgICAgICAt
IFFlbXUgd2l0aCBhbGwgdGhlIHBhdGNoZXMgZm9yIFNWTQ0KPj4+Pj4gICAgICAgICAgICAtIEFU
Uw0KPj4+Pj4gICAgICAgICAgICAtIFBSSQ0KPj4+Pj4gICAgICAgICAgICAtIFBBU0lEIGJhc2Vk
IElPVExCIGludmFsaWRhdGlvbg0KPj4+Pj4gICAgICAgICAgICAtIERldmljZSBJT1RMQiBpbnZh
bGlkYXRpb25zDQo+Pj4+PiAgICAgICAgICAgIC0gRmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb25zDQo+
Pj4+PiAgICAgICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5IHRyYW5zbGF0ZWQgYWRkcmVz
c2VzDQo+Pj4+PiAgICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+Pj4+PiAgICAgICAgLSBBIHNpbXBs
ZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KPj4+Pj4gICAgICAgIC0gQSB1c2Vyc3BhY2Ug
cHJvZ3JhbSAoZm9yIHRlc3RpbmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQo+Pj4+Pg0K
Pj4+Pj4gaHR0cHM6Ly9naXRodWIuY29tL0J1bGxTZXF1YW5hL1FlbXUtaW4tZ3Vlc3QtU1ZNLWRl
bW8NCj4+Pj4+DQo+Pj4+PiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToNCj4+Pj4+ICAgICAg
aW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNyby4NCj4+Pj4+ICAgICAgaW50
ZWxfaW9tbXU6IHJlbmFtZSBzbHB0ZSB0byBwdGUgYmVmb3JlIGFkZGluZyBGTFRTDQo+Pj4+PiAg
ICAgIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoDQo+Pj4+PiAgICAgIGludGVsX2lvbW11
OiBhZGQgc3VwcG9ydCBmb3IgZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24NCj4+Pj4+ICAgICAgaW50
ZWxfaW9tbXU6IGV4dHJhY3QgZGV2aWNlIElPVExCIGludmFsaWRhdGlvbiBsb2dpYw0KPj4+Pj4g
ICAgICBpbnRlbF9pb21tdTogYWRkIFBBU0lELWJhc2VkIElPVExCIGludmFsaWRhdGlvbg0KPj4+
Pj4gICAgICBpbnRlbF9pb21tdTogYWRkIGEgQ0xJIG9wdGlvbiB0byBlbmFibGUgRkxUUw0KPj4+
Pj4NCj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA2NTUgKysrKysr
KysrKysrKysrKysrKysrKysrKystDQo+PiAtLS0tLQ0KPj4+PiAtDQo+Pj4+PiAgICAgaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTE0ICsrKystLQ0KPj4+Pj4gICAgIGluY2x1ZGUv
aHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAgMyArLQ0KPj4+Pj4gICAgIDMgZmlsZXMgY2hhbmdl
ZCwgNjA5IGluc2VydGlvbnMoKyksIDE2MyBkZWxldGlvbnMoLSkNCj4+Pj4+DQo=

