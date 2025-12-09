Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1132D3B996
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT4St-0002bz-6S; Tue, 09 Dec 2025 15:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vT2zD-0003Xx-Ea
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:03:01 -0500
Received: from mail-westus3azon11011031.outbound.protection.outlook.com
 ([40.107.208.31] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vT2zB-0004b4-1Y
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:02:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogoirp9WzqWi0qIR/ScluT48lAtlJql3YsDydgBkV31Beo3l4MSlg5VJNysGE94juWUXKToGdrcy/jY+Ky2d6TGceh2OQa0rKgrsue8J9yGTGRqQOfOaRR8vvJCFTALgwTgMiakLsAjLyntpdy4bGOXcvINwIRbRBGH58DC4evEag9HxuTfs8HqMUjyrnmWPgOnNtr4rf+9knF28dEyKMe+1KsdlnThFQdyCb9KdtkqrEOKq1cFcj6cx8NmL1mhXv3hMI9DhXhTzGYlHZQUVCZkpd7Dydpr60YjV/F2BDi4oL9hEPSl/TyfDJABTzJn/gY2pdylniB2uem580O+eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsOfbXM1I0Zr1Bl3YqYCxpIUlUcM7fn9HAfLO5devwA=;
 b=Wn4kVlZZe7DasM2ly9MdYDCD5v3CiITjsN5aAOOYxcJqfIGGOFiIvdG80RzdRr3lXaWh1/CeDVXp3NZJCAHbLQr9Awh9xBBF/mIiT2fK7qDx7Keh0sbJXLcm+AbDTqtd70IBcHeYvMJuHBMt5tsBHKws/wqBzq8g3cX0n/nizrcvF+2T+zmha2hCdHlovUWQ5MUmD1NaCgfBypv7QPVCnPUmqe+W015W0U/DrSqobNsBX/yC2IgPWly7WGgJSFRm9Yw9pvCyvDL4GkmZivHpc6UbBsAY/dGcyPNbQDtwBRyYlw39A+U3xPHKfbr2dvr1n0sR3nlB3PhzcdOSpBJnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsOfbXM1I0Zr1Bl3YqYCxpIUlUcM7fn9HAfLO5devwA=;
 b=N2ecvCs8hPETH8y1MYnjMXeMmm8NaNJ6RqMdffneNd2Nz3faqtXr3em3VEg4PYfDG5CaJ7arCkiraFiOpD96JTxJd5THH3NhADk4ERVqlpUaZCC6i7/iRHHY32p6VqdwHtK2UG+4wIg1xwfpZPY4pGa5tuJvfijaTmSB9Sq0QUI=
Received: from SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:57:48 +0000
Received: from SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::29ca:5c2a:6cf8:bca1]) by SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::29ca:5c2a:6cf8:bca1%4]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 18:57:48 +0000
From: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "odaki@rsg.ci.i.u-tokyo.ac.jp"
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "luckmaan21@gmail.com"
 <luckmaan21@gmail.com>
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
Thread-Topic: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
Thread-Index: AQHcZhfofsc+PaQVgkmybu/4b1LjnLUW7PiAgAEa+yg=
Date: Tue, 9 Dec 2025 18:57:48 +0000
Message-ID: <SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2A@SA1PR12MB9492.namprd12.prod.outlook.com>
References: <20251205184906.110927-1-luirshad@amd.com>
 <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
In-Reply-To: <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T18:57:47.216Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9492:EE_|SJ2PR12MB7992:EE_
x-ms-office365-filtering-correlation-id: 52f95dd7-66ae-40b8-6777-08de3754d8b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?b2FlaHQzTVUzOENtL3gzSlVwdnc3dmtLWGg2Sk5JcDUzNXVEdWczc0ZRSnNH?=
 =?utf-8?B?dnp1MWZOZjZIR0o5ckR1cGJxbnlDcnFBSnkyOXpzNlBPL0JTNWNxSDVBUGxK?=
 =?utf-8?B?NkgxbWxrakdIUHp0L0oyMGgrQzNiOWg2NUtLNnNmeDNIUGtVUGRycndoU2hU?=
 =?utf-8?B?S2UvUy9mWFVsTmdWSmFjSzRWbTl2TWp4WFQxdTQxSXlmRHphSTFYWVoxZ2FY?=
 =?utf-8?B?ck8zcmJTQ0JVUmNMN2RCOHh0RzZxaWczTnlENWU1cEdJaDFRYVRqWjdXUFd6?=
 =?utf-8?B?MldVQ3NndzUrZ2o4aGVoa1hZSDg1b0ZkbzV4bWExQWRteTRVTTBPSURlODRu?=
 =?utf-8?B?ZFNFb01XWkp5TlpianIyMG1tNnczUXNCNVU4dVgzd3haMk03NEtuRk1QWjI2?=
 =?utf-8?B?Z0c3TTgvVTlmTExxZ0FvdXc5WTJodE1ROVJwQUJreEQyckMxSXIybk1EdURH?=
 =?utf-8?B?aFpGenhoMjExQ3FuSldpV05xY3FUdGdXeHJPeUNRc1ZMQTBvMXZ5L0FmQnFk?=
 =?utf-8?B?eW9tOHRhbyttN01RdHZXVm9tRmZOa2hDbXpJblpuUW9YcnhiTmthOG5oMVF3?=
 =?utf-8?B?aE4yUENoMmQwMDRETmJFbm0yMkFpMXVwQ0ZOSEdoMXJDL1c4ZEYrTm5DSUwv?=
 =?utf-8?B?ZUxiMEtxMXBmZVFRdndrb2RFZmtaY1VvdU5vZDBiY3dGVkUyR1Y1dWVwWFBY?=
 =?utf-8?B?S0lBVEhyNlI5c0xocGRZVkxLczhmTS9tQ1I0OFFYVEx0b3Q0eVlWVWJJL0Zu?=
 =?utf-8?B?aUhPd2gxRHplN2E3aEwwRWd1MmJnQng1QzA3M0RwdWtQVzNBUGhtZU90K3dE?=
 =?utf-8?B?eUU3WnkyeFBldng0TkZSN0wyMDU0Z1hCbVVyL0ZpZFJjUHZzWURPWHA2Y00v?=
 =?utf-8?B?TG9yZ1BKZk5uaWpsbEllQ1kzcDI4RDloc1M2Z203WGk1S1p0VW52Zkc0MFo1?=
 =?utf-8?B?eURoSnowcVIrOGxhZGNlM1c1UytZTFNFWXVZemhWd0JTcmNrSGdwNFNmemVN?=
 =?utf-8?B?c3huT3Q4QnRMK0NqZkNKRkNDTHRoQU9ybjZKZkV6NCtWMVpJOThsNWQ2OE43?=
 =?utf-8?B?MDZBTjUvd01rcmdlSWY4dVliV2pCMFRHRWZQT3VyQm1TaGk2QVpXM0E3RWxB?=
 =?utf-8?B?RGxsWmFTV0liQm9YTUVXb05POTdaeURwNkFWOW1KRjVLaHBUNW50cGp0YnRK?=
 =?utf-8?B?V2wyazRubmdnaHNlcVBOQ0cyd0tKS2d3ejl3WElrbVl2UmNJTm5DWGF6R3o4?=
 =?utf-8?B?eWpJdlFkRHVSU1h3NTJSUCtQT0NNcVdJc1BmckN1RlF5STdrSjFVOVR0Vmpm?=
 =?utf-8?B?RUNucW5pNXQ2SmpnQmtTa0lNM3ZTeEZGK09Pb0lReHZ5cHZwQjBURDdlSEtI?=
 =?utf-8?B?SitQbnpFdkk2em40ZmZOR1VuUWt5TElrRSt6NHAraTJCaVZiQkl6djBlclow?=
 =?utf-8?B?b255ejRoN3FKZHFnSlk5RDl3THY0K000TWlqYi94MTB4MTRkakFiNE4xUTFI?=
 =?utf-8?B?anhpOTVGS3llSUJzSHBZOU50SDltamkzcXJ1NFNpT3Q0Z3RTc2xScmRMZklG?=
 =?utf-8?B?anR5djBaalFNcnRwZG55UnF4eVM3ODZSRGF2N0dLdEQrbTFvYkEvMDVzOVVG?=
 =?utf-8?B?d0NvVjk5UVdSZVJ6QWRnOGtRZ1VnRzdsNGlMRUp1UE9BallXUldUS3BMNTRQ?=
 =?utf-8?B?TVcydjdvdy9Db0xoOEtmZGpURDBHbHhpcG9vMGVyR0pVVUhNdnR6SjhiQ1lE?=
 =?utf-8?B?TEJxS2MxQ2dtQVh4eDdua0FZclNHYWFkV2dvRGhHWGMvZzZqcU55c29YeHhy?=
 =?utf-8?B?OHN0RGFuMjRuZXFpaitTcU9PU1g2cnE1QXZRK28rVjFZUmFDZlhXeEoyT3hK?=
 =?utf-8?B?NDhCU2srbTFSRjRoUTJwRFp6bkJLOENINlZZUVJpL1o3NnJOZytlbjVqaFZm?=
 =?utf-8?B?dVYvaDBGUW5xYWE2Y2p5blIwNUJTVWl5ek9wQThLR2Q5Q2h0cStqNDZvL3Vt?=
 =?utf-8?B?MXYyNW9UZ2xzSHZsN1RaalEvNFdhNElSeW9LYTdWSndOUlhuZ1oyTHFjSk5s?=
 =?utf-8?Q?VfHOUX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9492.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXVNc3l1NTlQSGhuOTYvYUd5REgwM1g0M2xhQ3o1RlRCUjNVOUZWUVc4SVBp?=
 =?utf-8?B?ZVM5RFpZVUJkQVk4TXU3bWtWTytRSVpYVzN2dlhWU1BMVWRNWGtBdE8rNGRQ?=
 =?utf-8?B?L1dNTk1LSG5IS1BYMzJyZ2RUK0J6SVM2OXdndmh6RmpPdjRIbFNMdmdRVDVx?=
 =?utf-8?B?eTQ5THB0RjBZR1VsTW5GTTlZTzh5MUdGaGEyS0l1c3dRZkF0ckp1QWpiOFdI?=
 =?utf-8?B?RzEyUkh5b3ZpV0k0enRWMEtPYmhhd0FNdkVWa3RkNitYYVZSMWtDUTVjdUpL?=
 =?utf-8?B?R1I3K2tEb1hZMlRDMWxpMUVjSk9UVFhvYWQzN0pVSVVJTE52WXpNdmJ3dnFk?=
 =?utf-8?B?T252UDZ6Vmllc09sSWhPeVFsMWRySGg3aERUTjA5dTRFWVlNRTFDUzkzSEk1?=
 =?utf-8?B?QnRadVZ1VGFLd0RlSnpyc2lHWVIwdWxEck9XUHV2RUQ0c0dLVEx4bFFlY3Er?=
 =?utf-8?B?THBYSHNHSm45ZjZpdnZESTJBTWgrRURaak5RL3g4V3NWM0NvK2hJSUc5U2R5?=
 =?utf-8?B?bHcxKy84dy84V3FFMitueWE4R0pmcG43UkJDZ3hXM2FWNkVqZjNCTnVleTB5?=
 =?utf-8?B?cmVMOUJ6RG85cUlwZCtST085dnpXSS9IMzd5WnExZndROXpWZWpaNDdtUkgx?=
 =?utf-8?B?ekxWRXVLcE5zNFh2dytmajloc0FPNFBhR3o1b1F0cytSMFI2cUl0bmpOQkh0?=
 =?utf-8?B?Q3Y1M1k5QlBtbXBjekhISTkzVzIzK1FDYzF2cStRZVBJV1U2aldldVFDTlV0?=
 =?utf-8?B?WTdzWndjNWhvR0hUSHBZdXdLUXBJV3BJUWgzMkVScmZZQjZDMnhiM2xoVzV4?=
 =?utf-8?B?ZjR4L3B6eUlNMXliQ2JoQWRpbVkwMkdCSUZibmttYzlaUHBKZjNDemQyYnBv?=
 =?utf-8?B?OEl6VjJFNDVtZW96TVlHTENFalIvWTZveDA0R1g3L2FJZ1A3REdNSXNjSVdo?=
 =?utf-8?B?ZHpkMDA0TzB5cUxnQlRRakFZOE1FZEc5NTBRTThUQ2EzeDNraEdkNDFpTEFt?=
 =?utf-8?B?OC9mOGpVT0kxNU52MkFaV3ZUczdIYkFVRGVMR2lwSjF6QzNNcE92eHlEY01h?=
 =?utf-8?B?bnp5cy9LSGwrTjBHUk5HTXJkMWozeXBwdHZPb3VlbUxjOUlZNld5cjhHbmdQ?=
 =?utf-8?B?eld5QngwU2oyMUhSRGtTcWRrWVhuNllvMjJWYVdzalVJelMvWWI4RzdCaGla?=
 =?utf-8?B?eGh6bWY3YW1NZVRxdXB4UEhKd2huckFxWmE0aVpkd013Nkk4SmhiTTA4amFT?=
 =?utf-8?B?V1h6bDhsbkZjUzVSOWwyMlJiNXVXWHh0R0pES2pISEk3OCtZNlFJbVIrak5P?=
 =?utf-8?B?VWpnd1lOUnBJdC9qQ3k2eFdGSUFmRlhvbUt5TitNQllsTHY4SGUyeGczdTBY?=
 =?utf-8?B?STJWRDhGb2RuTlBidXQvTzVGQVVvVVpQRXBBVkJVTzZsWmRnOCtKK29jemk5?=
 =?utf-8?B?azZOWFpKVjI5K2N2UTVpZnhqeklCZFVqMHVLRmFuL1loeURZYnowNHpSaFpx?=
 =?utf-8?B?TWozc0U3TENiSzJrRUFINWJxUkl4TGJwZ1pwTHlSUlJwcStVYlBOMXkwazk0?=
 =?utf-8?B?WUFtRk5peVpMWS9rTmd1T2lRdmhrMFJIN2gxVHpRblhhbXVxREtqcXlVVXhQ?=
 =?utf-8?B?cmRmTXluYUkxcHhRQm9ZR3JyUW9ZNytFWWxkSkU2THNkUGcrcDhVTEpheHNI?=
 =?utf-8?B?Sm1tR0dVbyttYnlGUVU0alVVaWtUZG1BM3FmNG54T2xmMmE0SHdQNFZOdGVN?=
 =?utf-8?B?QmpkV0lhUWxtdFdFSTFGRHQ5ZXFkWVF4VWcvSXBENWtrcGZqcWJYTW0rdFZ3?=
 =?utf-8?B?UGlqK29GL3JtajVZdXRYS3JYU3ZYK3RlYTVLWVhzSFJSWUx6R2RXWTViSHF3?=
 =?utf-8?B?c2ZEdXRwd2lBK1U3R1UwQXI2Y3piWEkycGNBOVQzWDZQQXhQV1NhTkZYUlpE?=
 =?utf-8?B?U2V2Si9xZjZSczQ0aEFzRStHZHFPZXUwNHZtMVd3cGF6TGFFbHBzVk5Qb01y?=
 =?utf-8?B?Y2NOcFpsSHB5ZUJJdEpYdHVTUXl6am5EUjVKK1BqU1NQVlUzWWhWRW1FZ2Y2?=
 =?utf-8?B?cGptaVhYUTlSMWZDRmMzajU2eDFSaStXZE5CcVZ4SHh1QWk1RFJla2hFM3l0?=
 =?utf-8?Q?1yfE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2ASA1PR12MB9492namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9492.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f95dd7-66ae-40b8-6777-08de3754d8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 18:57:48.5167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 387VFbMjh+FG/5RSRRYu5o5qhwCYNZGsCnjYTclZsLyTCYkoc20ibBr2z3l3vmflTvhunsdJZE2oSF2xVMdbBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
Received-SPF: permerror client-ip=40.107.208.31;
 envelope-from=Luqmaan.Irshad@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Dec 2025 15:37:41 -0500
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

--_000_SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2ASA1PR12MB9492namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGVsbG8gRG1pdHJ5LA0KDQpUaGF0cyBhbiBpbnRlcmVzdGluZyBpZGVhISAgSSB3b3VsZCBi
ZSBjdXJpb3VzIHRvIGxvb2sgaW50byB0aGF0IGZ1cnRoZXIsIGhvd2V2ZXIgbXkgYWJpbGl0eSB0
byBkbyBzbyBtYXkgYmUgbGltaXRlZCBzaW5jZSBteSBjb250cmFjdCBlbmRzIGF0IHRoZSBlbmQg
b2YgdGhpcyB3ZWVrLg0KDQpBZnRlciBteSBjb250cmFjdCBlbmRzLCBJIHdvbid0IGhhdmUgYWNj
ZXNzIHRvIGEgbXVsdGktR1BVIHN5c3RlbSBJIGNhbiB0ZXN0IHRoaXMgb24uICBJIG1heSBiZSBh
YmxlIHRvIHdvcmsgb3V0IHNvbWUgd2F5IHRvIGJvcnJvdyB0aGUgc3lzdGVtLCBidXQgYXQgdGhl
IG1vbWVudCB0aGlzIGlzIHVuY2VydGFpbi4NCg0KSWYgdGhpcyBwYXRjaCBsb29rcyBnb29kLCBt
eSBzdWdnZXN0aW9uIHdvdWxkIGJlIHRvIG1lcmdlIHRoaXMgY2hhbmdlLCBhbmQgd2UgY2FuIGxv
b2sgaW50byBhZGRpbmcgdGhpcyBhcyBhIHNlcGFyYXRlIHBhdGNoIG9uIHRvcCBvZiB0aGlzIGlm
IEkgY2FuIGdldCBhY2Nlc3MgdG8gYSBzeXN0ZW0uICBMZXQgbWUga25vdyBob3cgdGhpcyBzb3Vu
ZHMg8J+Zgg0KDQpTaW5jZXJlbHksDQoNCkx1cQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCkZyb206IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5j
b20+DQpTZW50OiBTdW5kYXksIERlY2VtYmVyIDcsIDIwMjUgNzo0OSBQTQ0KVG86IElyc2hhZCwg
THVxbWFhbiA8THVxbWFhbi5JcnNoYWRAYW1kLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8
cWVtdS1kZXZlbEBub25nbnUub3JnPg0KQ2M6IG1zdEByZWRoYXQuY29tIDxtc3RAcmVkaGF0LmNv
bT47IGFsZXguYmVubmVlQGxpbmFyby5vcmcgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBvZGFr
aUByc2cuY2kuaS51LXRva3lvLmFjLmpwIDxvZGFraUByc2cuY2kuaS51LXRva3lvLmFjLmpwPjsg
UGVsbG91eC1QcmF5ZXIsIFBpZXJyZS1FcmljIDxQaWVycmUtZXJpYy5QZWxsb3V4LXByYXllckBh
bWQuY29tPjsgbHVja21hYW4yMUBnbWFpbC5jb20gPGx1Y2ttYWFuMjFAZ21haWwuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gdmlydGlvLWdwdTogY3JlYXRlIGRybSBmZCBiYXNlZCBvbiBzcGVj
aWZpZWQgcmVuZGVyIG5vZGUgcGF0aA0KDQpIaSwNCg0KT24gMTIvNS8yNSAyMTo0OSwgTHVxbWFh
biBJcnNoYWQgd3JvdGU6DQo+IEFkZGVkIGEgc3BlY2lhbCBjYWxsYmFjayBmdW5jdGlvbiBjYWxs
ZWQgdmlydGlvX2dldF9kcm1fZmQgdG8gY3JlYXRlDQo+IGEgcmVuZGVyIG5vZGUgYmFzZWQgb24g
dGhlIHBhdGggc3BlY2lmaWVkIGJ5IHRoZSB1c2VyIHZpYSBRRU1VIGNvbW1hbmQNCj4gbGluZS4g
IFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGR1cmluZyB0aGUgdmlyZ2xyZW5kZXJlciBjYWxsYmFj
ayBzZXF1ZW5jZQ0KPiB3aGVyZSB3ZSBzcGVjaWZ5IHRoZSBnZXRfZHJtX2ZkIGZ1bmN0aW9uIHBv
aW50ZXIgdG8gY2FsbCBiYWNrIG91cg0KPiBuZXcgZnVuY3Rpb24sIGFsbG93aW5nIHVzIHRvIHBh
c3MgdGhlIGZkIG9mIG91ciBjcmVhdGVkIHJlbmRlciBub2RlLg0KPg0KPiBCYXNlZC1vbjogMjAy
NTExMTYxMjU2NDEuMjI1NTc5NC0xLWRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEx1cW1hYW4gSXJzaGFkIDxsdWlyc2hhZEBhbWQuY29tPg0KPiAtLS0N
Cj4gIGh3L2Rpc3BsYXkvdmlydGlvLWdwdS1nbC5jICAgICB8ICA0ICsrKysNCj4gIGh3L2Rpc3Bs
YXkvdmlydGlvLWdwdS12aXJnbC5jICB8IDE3ICsrKysrKysrKysrKysrKystDQo+ICBpbmNsdWRl
L2h3L3ZpcnRpby92aXJ0aW8tZ3B1LmggfCAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KRG8geW91IHRoaW5rIGl0IGNvdWxkIGJlIHBv
c3NpYmxlIGFuZCB3b3J0aHdoaWxlIHRvIG1ha2UgUUVNVSdzIEVHTA0KZGlzcGxheSB0byB1c2Ug
c2FtZSBHUFUgYXMgdmlyZ2wgYXV0b21hdGljYWxseT8gSS5lLiB3ZSB0ZWxsIFFFTVUvRUdMDQp3
aGljaCBHUFUgdG8gdXNlIGFuZCB0aGVuIHZpcmdsIHdpbGwgdXNlIHNhbWUgRFJNIGRldmljZSB0
aGF0IGJhY2tzIEVHTC4NCg0KLS0NCkJlc3QgcmVnYXJkcywNCkRtaXRyeQ0K

--_000_SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2ASA1PR12MB9492namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZh
bWlseTogQ2FsaWJyaTsgdGV4dC1hbGlnbjogbGVmdDsgY29sb3I6IHJnYigwLCAwLCAyNTUpOyBt
YXJnaW4tbGVmdDogNXB0OyBmb250LXNpemU6IDEwcHQ7Ij4NCltBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldPC9kaXY+DQo8YnI+DQo8L2Rpdj4N
CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRv
c19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiIGNsYXNzPSJlbGVtZW50VG9Qcm9vZiI+DQpI
ZWxsbyBEbWl0cnksPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9z
X0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBz
YW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IiBjbGFzcz0i
ZWxlbWVudFRvUHJvb2YiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTog
QXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwg
SGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwg
MCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KVGhhdHMgYW4gaW50ZXJlc3RpbmcgaWRlYSEm
bmJzcDsgSSB3b3VsZCBiZSBjdXJpb3VzIHRvIGxvb2sgaW50byB0aGF0IGZ1cnRoZXIsIGhvd2V2
ZXIgbXkgYWJpbGl0eSB0byBkbyBzbyBtYXkgYmUgbGltaXRlZCBzaW5jZSBteSBjb250cmFjdCBl
bmRzIGF0IHRoZSBlbmQgb2YgdGhpcyB3ZWVrLjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGli
cmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAs
IDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4NCjxicj4NCjwvZGl2Pg0KPGRpdiBzdHls
ZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNl
cnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBj
b2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4NCkFmdGVyIG15IGNv
bnRyYWN0IGVuZHMsIEkgd29uJ3QgaGF2ZSBhY2Nlc3MgdG8gYSBtdWx0aS1HUFUgc3lzdGVtIEkg
Y2FuIHRlc3QgdGhpcyBvbi4mbmJzcDsgSSBtYXkgYmUgYWJsZSB0byB3b3JrIG91dCBzb21lIHdh
eSB0byBib3Jyb3cgdGhlIHN5c3RlbSwgYnV0IGF0IHRoZSBtb21lbnQgdGhpcyBpcyB1bmNlcnRh
aW4uPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVk
Rm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IiBjbGFzcz0iZWxlbWVudFRv
UHJvb2YiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFw
dG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNh
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IiBjbGFz
cz0iZWxlbWVudFRvUHJvb2YiPg0KSWYgdGhpcyBwYXRjaCBsb29rcyBnb29kLCBteSBzdWdnZXN0
aW9uIHdvdWxkIGJlIHRvIG1lcmdlIHRoaXMgY2hhbmdlLCBhbmQgd2UgY2FuIGxvb2sgaW50byBh
ZGRpbmcgdGhpcyBhcyBhIHNlcGFyYXRlIHBhdGNoIG9uIHRvcCBvZiB0aGlzIGlmIEkgY2FuIGdl
dCBhY2Nlc3MgdG8gYSBzeXN0ZW0uJm5ic3A7IExldCBtZSBrbm93IGhvdyB0aGlzIHNvdW5kcw0K
PHNwYW4gaWQ9IvCfmYIiPvCfmYI8L3NwYW4+PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWls
eTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJy
aSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwg
MCwgMCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KPHNwYW4+PGJyPg0KPC9zcGFuPjwvZGl2
Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFw
dG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4N
CjxzcGFuPlNpbmNlcmVseSw8L3NwYW4+PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTog
QXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwg
SGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwg
MCk7IiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPg0KPHNwYW4+PGJyPg0KPC9zcGFuPjwvZGl2Pg0K
PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9z
X01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj4NCjxz
cGFuPkx1cTwvc3Bhbj48L2Rpdj4NCjxkaXYgaWQ9ImFwcGVuZG9uc2VuZCI+PC9kaXY+DQo8aHIg
c3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgd2lkdGg6IDk4JTsiPg0KPGRpdiBpZD0iZGl2
UnBseUZ3ZE1zZyI+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsgZm9udC1mYW1pbHk6IENh
bGlicmksIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsi
Pg0KPGI+RnJvbTo8L2I+Jm5ic3A7RG1pdHJ5IE9zaXBlbmtvICZsdDtkbWl0cnkub3NpcGVua29A
Y29sbGFib3JhLmNvbSZndDs8YnI+DQo8Yj5TZW50OjwvYj4mbmJzcDtTdW5kYXksIERlY2VtYmVy
IDcsIDIwMjUgNzo0OSBQTTxicj4NCjxiPlRvOjwvYj4mbmJzcDtJcnNoYWQsIEx1cW1hYW4gJmx0
O0x1cW1hYW4uSXJzaGFkQGFtZC5jb20mZ3Q7OyBxZW11LWRldmVsQG5vbmdudS5vcmcgJmx0O3Fl
bXUtZGV2ZWxAbm9uZ251Lm9yZyZndDs8YnI+DQo8Yj5DYzo8L2I+Jm5ic3A7bXN0QHJlZGhhdC5j
b20gJmx0O21zdEByZWRoYXQuY29tJmd0OzsgYWxleC5iZW5uZWVAbGluYXJvLm9yZyAmbHQ7YWxl
eC5iZW5uZWVAbGluYXJvLm9yZyZndDs7IG9kYWtpQHJzZy5jaS5pLnUtdG9reW8uYWMuanAgJmx0
O29kYWtpQHJzZy5jaS5pLnUtdG9reW8uYWMuanAmZ3Q7OyBQZWxsb3V4LVByYXllciwgUGllcnJl
LUVyaWMgJmx0O1BpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20mZ3Q7OyBsdWNrbWFh
bjIxQGdtYWlsLmNvbSAmbHQ7bHVja21hYW4yMUBnbWFpbC5jb20mZ3Q7PGJyPg0KPGI+U3ViamVj
dDo8L2I+Jm5ic3A7UmU6IFtQQVRDSF0gdmlydGlvLWdwdTogY3JlYXRlIGRybSBmZCBiYXNlZCBv
biBzcGVjaWZpZWQgcmVuZGVyIG5vZGUgcGF0aDwvZGl2Pg0KPGRpdiBzdHlsZT0iZGlyZWN0aW9u
OiBsdHI7Ij4mbmJzcDs8L2Rpdj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1zaXplOiAxMXB0
OyI+SGksPGJyPg0KPGJyPg0KT24gMTIvNS8yNSAyMTo0OSwgTHVxbWFhbiBJcnNoYWQgd3JvdGU6
PGJyPg0KJmd0OyBBZGRlZCBhIHNwZWNpYWwgY2FsbGJhY2sgZnVuY3Rpb24gY2FsbGVkIHZpcnRp
b19nZXRfZHJtX2ZkIHRvIGNyZWF0ZTxicj4NCiZndDsgYSByZW5kZXIgbm9kZSBiYXNlZCBvbiB0
aGUgcGF0aCBzcGVjaWZpZWQgYnkgdGhlIHVzZXIgdmlhIFFFTVUgY29tbWFuZDxicj4NCiZndDsg
bGluZS4mbmJzcDsgVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZHVyaW5nIHRoZSB2aXJnbHJlbmRl
cmVyIGNhbGxiYWNrIHNlcXVlbmNlPGJyPg0KJmd0OyB3aGVyZSB3ZSBzcGVjaWZ5IHRoZSBnZXRf
ZHJtX2ZkIGZ1bmN0aW9uIHBvaW50ZXIgdG8gY2FsbCBiYWNrIG91cjxicj4NCiZndDsgbmV3IGZ1
bmN0aW9uLCBhbGxvd2luZyB1cyB0byBwYXNzIHRoZSBmZCBvZiBvdXIgY3JlYXRlZCByZW5kZXIg
bm9kZS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBCYXNlZC1vbjogMjAyNTExMTYxMjU2NDEuMjI1NTc5
NC0xLWRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPGJyPg0KJmd0Ozxicj4NCiZndDsgU2ln
bmVkLW9mZi1ieTogTHVxbWFhbiBJcnNoYWQgJmx0O2x1aXJzaGFkQGFtZC5jb20mZ3Q7PGJyPg0K
Jmd0OyAtLS08YnI+DQomZ3Q7Jm5ic3A7IGh3L2Rpc3BsYXkvdmlydGlvLWdwdS1nbC5jJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsgNCArKysrPGJyPg0KJmd0OyZuYnNwOyBody9kaXNw
bGF5L3ZpcnRpby1ncHUtdmlyZ2wuYyZuYnNwOyB8IDE3ICsrKysrKysrKysrKysrKystPGJyPg0K
Jmd0OyZuYnNwOyBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tZ3B1LmggfCZuYnNwOyAxICs8YnI+
DQomZ3Q7Jm5ic3A7IDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKTxicj4NCjxicj4NCkRvIHlvdSB0aGluayBpdCBjb3VsZCBiZSBwb3NzaWJsZSBhbmQgd29y
dGh3aGlsZSB0byBtYWtlIFFFTVUncyBFR0w8YnI+DQpkaXNwbGF5IHRvIHVzZSBzYW1lIEdQVSBh
cyB2aXJnbCBhdXRvbWF0aWNhbGx5PyBJLmUuIHdlIHRlbGwgUUVNVS9FR0w8YnI+DQp3aGljaCBH
UFUgdG8gdXNlIGFuZCB0aGVuIHZpcmdsIHdpbGwgdXNlIHNhbWUgRFJNIGRldmljZSB0aGF0IGJh
Y2tzIEVHTC48YnI+DQo8YnI+DQotLTxicj4NCkJlc3QgcmVnYXJkcyw8YnI+DQpEbWl0cnk8L2Rp
dj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2ASA1PR12MB9492namp_--

