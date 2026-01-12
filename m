Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF83ED25056
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDlX-0003VL-AR; Mon, 12 Jan 2026 03:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vfDlR-0003TY-Q8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:59:05 -0500
Received: from mail-westusazon11012009.outbound.protection.outlook.com
 ([52.101.43.9] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vfDlQ-000430-0r
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:59:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEoT74fibBSAKjJR7LdnUtHjpPaLM69apn0U7B1ewbHBsNEuEHL4NJuRHtPIyEmlWUJE9Z2BGlF9Wh9iZ2kpEjpqZ+KZEeNL0oausAZQfSzvsyEq8peAUZODe/usY7Ubrp+0nBn1T7Jh6GN7CFPaW609q/b7Eg96UvAOQ5ijINQ2JmAF8Nq/2hYYiEtf/JuHZNFnxOGPT1lfTdQZWZqE7izstRzBwX+QORfKx4fH1T91bOH9IZkp3cAJiHtvGGYJ4sGV/hu3dagOtx6NMro/CLBf+TFEpacbm/bSOY/mXR4eD1zb83WwZZWUZmWmkaM2eQhG9oQK3lOEoWo4DWnd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9SS0hc9fL7t+VEl7jj6rHO/rgpIVgspDL27n5cW0O8=;
 b=Jl3xjSC8hIQsZzOfu4wVn9Pt6zE6TU+kI7RkpQvPZ9W0NvmWx5fAgb+b+EropTqBaKsATmKiUnHQcNtv1cILEcjy5il6pXKRMoi1qEcNjd82c0zMrcoRpeBK/feKtX422rtwvgijshEnb5sQd4wJTSMW07gSNJVNaJdNJcO31CQ0rGoiAV/0lJ1DI4eTO6kapziUUsKWhsVJ/3NuJV1Z5YN3+lpBlo95RgAxFiN1c5pk7YlcAs815aPeMVK9WtAvJL5AzZUXItCSJi7yqOcG+EuiUMf+XwkzmAinp4TwcywZwQuBWl7pD1syxJ7RL7wr9j7EwBh8W/Knsr71iaLFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9SS0hc9fL7t+VEl7jj6rHO/rgpIVgspDL27n5cW0O8=;
 b=D0ob8tTaMXO6Mm8qnOrnLkIgGlZG9MaRO0HC+Us4RREsUCWlbWnJNqEXiLaDc/pwIG89qFqXh7IllXuUAIlciwAQSaeZMf51HAwtf44g8twg8lJ4SPwEhI4aMG0fPOcUZp5RypJqsZ37VVBHTkfk9Ks3URAL+6WB0KRYZMpvwhg=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:53:57 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:53:57 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Prica, Nikola"
 <Nikola.Prica@amd.com>, "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Topic: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Index: AQHcaRi2j570A1RdCkK75QZWVlfQIbU0EcKwgAHQAYCADdlTEA==
Date: Mon, 12 Jan 2026 08:53:57 +0000
Message-ID: <CH0PR12MB5283C36ABAF18717DE9091BBFA81A@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <CH0PR12MB5283E6E62B87088662E8C71AFAB0A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <6dd0e357-d6ce-43e0-8144-6a8b77fd9fd3@redhat.com>
In-Reply-To: <6dd0e357-d6ce-43e0-8144-6a8b77fd9fd3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-05T13:24:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: 23b6bf8f-487d-49a2-bd57-08de51b81f33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nTaHLSPKsW4fRHI4slU4bWNMqhi9RvkNqYaGPQEa5eZSeaKkeLnDow5ElY?=
 =?iso-8859-1?Q?hjiDB1fkcNtGC/R6kKDuVu2VATTb0HCq4Z39ypAkGAn3vkHOWxcLzFWKJR?=
 =?iso-8859-1?Q?AZekuSAmst4476MVz99jt+9bts57eiFCCS4W4zikfdKaFz34GDLVYXc3ap?=
 =?iso-8859-1?Q?Nhy94wKsj263QAXukQp/NvZ5JhsQX8R0m1tsbjT/9cn6HZRe2yMSE1HdyD?=
 =?iso-8859-1?Q?t0EujJLz3bbjKoyAC05sUqYEPiULx+tFfyEwS7VGeKc3hCi+DqrXZgkzBB?=
 =?iso-8859-1?Q?dykB9TCaqshpCj8Kr6QIFjynZLgtEb2oBUV5QduG1BAFBk+z9ZMTo+HqGx?=
 =?iso-8859-1?Q?/qX310BOxw4i36tsmDb20hlNCu5YKg4axKmY3uHMZFUoi/z8N57wXM3MAr?=
 =?iso-8859-1?Q?qv+i5z5a2cvoLp8a5V3KVGtnz4ziRejW//buDj3qEc2nX8vA0ZZPW9fds4?=
 =?iso-8859-1?Q?KAXQEPQY9nEr9/y6gWTZwBg3CgLKaBbtbUxgqCktv0eecaUDb3K1nN8/QH?=
 =?iso-8859-1?Q?u+sBPt3Atrtxh5oYUuK8Cq6hEX3tzcjZ3bpZUwZumYcCN+p+ICmkss1GHt?=
 =?iso-8859-1?Q?pUDN/vpKW0Hsn0dxrcuFwTHK2+K0SdvDoakny7YJpHrm9nfbZgyZvkxBdQ?=
 =?iso-8859-1?Q?gZ6Sum1ZZ4PXWKsJlW5OVQl86ksd2XfIWn3HwvM+EQIVCMeHdPNrLe4o+Z?=
 =?iso-8859-1?Q?HaQ2rCwogk3VsZR8vC3A7C20ZfccYWLP9COMvwPwrX+SiWEoXI6dTiW2XB?=
 =?iso-8859-1?Q?rZPBTjSzwS7OPgQ22ej8+yWjhkcNWJi3j+yenlJcP4BJop6NUG99r368Ja?=
 =?iso-8859-1?Q?YPwzHWll0hGk7zbjykjSUrWoTcg+0unVFuzUZLVJZ+jN57qgaKHZ/Rmzfb?=
 =?iso-8859-1?Q?vrrjo7I4C6ZhieKkrL5aDMnuY36EMi4RQlTLO/wKj6Zxm6A1lUHf91EjrY?=
 =?iso-8859-1?Q?BJlw03mFqYYbHsPTFQCVLTYAsDBhjihrbqLVSzrLLdk2gtqmOu0kPKS26I?=
 =?iso-8859-1?Q?dn3VfTq65ezytr7fCZVwxCXPZiwvEpFO6UmfVVvFdinM1+VC/6TIVM5VY0?=
 =?iso-8859-1?Q?SQYdryl+tBb9uZTttFypWavuLC3gxNUDhn2UXoUXn02MB3fB8JFPrugEHR?=
 =?iso-8859-1?Q?pFCAzTFIwVz4tSocmxPV610ARiMN3kTH+12pY5cEvPI85azYA8J9j8lstO?=
 =?iso-8859-1?Q?mb8mRiUXueYACGcC8PzhqVrHFjcdB06xAoBGqPQOyI9V5r2PkNCqyuJT3x?=
 =?iso-8859-1?Q?+Rq8lPXhX4+p2bxjgRWCpsTaFlAiPfDIkjTCiAb5oa5PeUhkVztqcc2+Qr?=
 =?iso-8859-1?Q?iogb7kQd4Lp6J611V6cK62XFWGdqpz0cjn8gzmbnw6OhH/wZlUeDwmEndE?=
 =?iso-8859-1?Q?o79Dt97+Kko6Lcx5vyMXW53Ln6G1n76VZhWooQxMPm1ES6CJwc+rmG8pgC?=
 =?iso-8859-1?Q?GwZY85WFOGb3UDWGoAV54DUi02nuztxoU9hup+c2hfGo6fCv8RLpFx9vry?=
 =?iso-8859-1?Q?ewQhr8rz0AlZYiTsefrb0njG60y0MnVNB2dRaKq2hkj/jjoRfQ4jPXKj6V?=
 =?iso-8859-1?Q?ifzq/GLdh2ioUqnYnoITS0YcdWQ/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b0ykCn4musPTKVhFa0zZd7vcSZZfBGH1A8Pe/lTK8mBEPGDsrtSkoDIO2L?=
 =?iso-8859-1?Q?2MgcGG72wgAWe5J213nzn9q/ruqjNFFotD3Yh+9pOFvGkZpB3lW9Lu/DoL?=
 =?iso-8859-1?Q?Up5WuzkW9n86kkC1QCbSC9qkp7G5eCQRLp+lP/GcTKXcYHia1gb7hefG2y?=
 =?iso-8859-1?Q?f+VAirgrxYarhjk3ohCaOIMHYTJg7ZxlyuL79CxdSZNGi++rwHF+SvYr6o?=
 =?iso-8859-1?Q?TpHtPE2GeMlparY4oakNrgFlWtXaAGrz1vQhmkE0eZAs+ur5w8i/sVzPvL?=
 =?iso-8859-1?Q?JXIe/VvfAaxPFL3ISuQIg5EWVuluU17xBDnaxx65UZ+F1zUiBRgJy8axQW?=
 =?iso-8859-1?Q?xnp+xDQp5Prjrv5TxzcTXT4z9lC4U7lTU17xE29lW4PIVTZ+HdBq332OpB?=
 =?iso-8859-1?Q?pA2Qy6aKbKfArNKwrwfBruTbV0W4KenGHus58bNO30f1Xa9DgfeuOR8kUZ?=
 =?iso-8859-1?Q?Oh9zNKI7odSBiUsTh1wv02/nxpbYPqLRXPnf2WwaqnsGohRNjKyAsXjg7x?=
 =?iso-8859-1?Q?TnS7hoTEufp9Vo0pUcary+eoJTgbwyUPxKmWSOc0Mir/+fkvBJxiVQ7lJ3?=
 =?iso-8859-1?Q?CSAb9SGsQnFjo4CyVpOBTItThhqEZsGwVb9rL1/lL4p0qAXdQ1don0sVnE?=
 =?iso-8859-1?Q?eOQkBLw5aRLby7sZ22yaDOhssCHkC39IpnKCC2pHou+RY10wnZkTL2Y2zS?=
 =?iso-8859-1?Q?9g6fPvQzLvTaFf2nkVlmFEbfmJs7uQmevU7EwmFzK8V01/u6GXvkKmkEAv?=
 =?iso-8859-1?Q?JL/xvrekV5+Q57pMtxO+7OuGhAfcOfDBhmFfEHHbYqSHOv2CBX2WgweQN3?=
 =?iso-8859-1?Q?ndDsYYJvyItZFasYw1UTuPPK72DRgfMjzA/Nn+KAJ6qsFEWt7ak7b0CPZe?=
 =?iso-8859-1?Q?HjXXLXChaj2/uNMpyWDu9ufdQJ0D6ekUDri6VlIMyPiYid3Sm78nn8SBfG?=
 =?iso-8859-1?Q?wpdXWGdRfDGUuxcXnS0WR+66p3kTdMQTsO77/cddefqIiZ6Gs2SOZrgc8H?=
 =?iso-8859-1?Q?gvpuQS8HNKhtotT4o+hqkY1Sz3MYGEidnKVv/EzU51ziCxUHNP+b20cRl3?=
 =?iso-8859-1?Q?rePQl0MicpDMiJvmDGAm4S5vDHyPskRFpmUPjdmILYQdV/4yriTrNCXZCQ?=
 =?iso-8859-1?Q?9nGHuY9jm2NxeJyn9B5LFq8U0cUmdYsoKEh1y791gUtb0vSeT0TJk9VvcT?=
 =?iso-8859-1?Q?fgFCYDld3kk0Hb2PISgAXk8QPL8n7oZji9zan6xxlo3yO4CvepJ2Xf6pqF?=
 =?iso-8859-1?Q?rA78188B/TvJT8DhM3NTiAlCgVc5zAOB2Dm9+aQD7rMk/gEq8YKHBEms3N?=
 =?iso-8859-1?Q?789giw1Q+wk3toaDmtBul0pK28zdxNsBJ0ppux8jQHENw7z9sAr2ZTgP1h?=
 =?iso-8859-1?Q?cJS4LQm+WOUD09gRPWktdt0eFK3Ok2a2JtOtiMXMit9mhPnsYsyfriaU1B?=
 =?iso-8859-1?Q?+pJM6EeaYmBt7m6wqr3KTx5Mbv2Voz9lS25nRQ2kjN3xedV3KKiJKtqcK2?=
 =?iso-8859-1?Q?v6o3EEmVkpqgPR9DoY3TXZKcJiR/XY9HQ/gO33XdEvIs89oC2SCbTm7WpK?=
 =?iso-8859-1?Q?ANQlVBcFEM3W0UsdQ8Tsfd4KMr42Zt8TDHEo3zuhjW7NkytxqCpm1oGX36?=
 =?iso-8859-1?Q?QXFi3mZJo+TWWl8TufoWtmrn3jKJ6kgbzwIZyPpSP6QfWM3ySrYDzBjdHB?=
 =?iso-8859-1?Q?TJBVLyJzOZ4nSUHG0qlHoaxGQEJ+COs1I6N2M8lhoF/3BMmT0IwPmf38NY?=
 =?iso-8859-1?Q?W20Mn7mPduWpllSgs+GSMoWdJ28+ut4GK3J72TXClAql2f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b6bf8f-487d-49a2-bd57-08de51b81f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 08:53:57.1889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CL1axTUwEwAjcJCXpSu/xvBaT7YmwD8+dg0SUlpoqb7JRZpeZQgGkbc+2sJ9IG0/fn5etYqFwIzRQrwz1zUYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
Received-SPF: permerror client-ip=52.101.43.9;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Cedric,

Good to hear from you. Hope you had a great New Years break.
If you need any more assistance from my side, please reach out.

BR,
Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: C=E9dric Le Goater <clg@redhat.com>
Sent: Saturday, December 27, 2025 6:55 PM
To: Pekovic, Manojlo <Manojlo.Pekovic@amd.com>; qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com; Prica, Nikola <Nikola.Prica@amd.com>; Andje=
lkovic, Dejan <Dejan.Andjelkovic@amd.com>
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

Hi Manojlo,

On 12/26/25 15:15, Pekovic, Manojlo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi,
>
> Do you have any updates on this topic?

There's nothing wrong with it at first glance. It seems like a good candida=
te for the QEMU 11.0 cycle. We just need to take the time to examine it mor=
e closely. After the break !

Cheers,

C.



