Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91172C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qV-0004b5-T4; Wed, 15 May 2024 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0004Yo-Hs
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qJ-0000oJ-6w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757267; x=1747293267;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CNQP7R4fixHdItVjQquYDz2UpGFCRNezXgcRL4ypHQA=;
 b=L1Qid/DhN/JFh1XuRrnJdWH218XZfDl7VMsKRpFzc2MJDxLfHY2BQe/e
 p9BpDIR075x+2p3Ov3bWlviiz00qT4YXEBVy27Ao43b2ncRrLzNjL+RzF
 wdMe6gAPrhFq49GE2uI9GEZiW44GdJuoDV3CXudmv4qIybDoc6QXFW/uj
 7aIjZwRFZZuOyLy9hfp/sVmr5vhQlva9SjuCmm6K3Ab5gYwXokPmAkkCH
 XDXjXdwClg4bSqG/xGucEYiyRn5pY2OKVFP171hPz60FfDip7B45Ls/i9
 WEPOkBLXBDyUcrtuvrWVLFXNVHkYbslBRnyB7iOZpW8g59j3OSWnWKTXM g==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581801"
X-MGA-submission: =?us-ascii?q?MDGzWYzx+ZBs74ExwzoC2n0zvOm2dr6+wwi4Zw?=
 =?us-ascii?q?yB14zx2XCUDi3ZSwGMkL+064+cVTawLn2Seip//zzeUpQHZX+fFhgH7T?=
 =?us-ascii?q?6O5QElNFacNPfaYCYCJyxigoDz6uCgmzKiLg0pmNtDGD08loQtiwLM86?=
 =?us-ascii?q?g+hWbkp7KxI9+2ns9sZm7sEQ=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8tTUx2vB93cSsxOuL+LLswWgEMrXnilxw3ghFKw6awKTRmv5Zp9ou2r8BWR+njgwgYkn2ozgtywj11iAHumrV2eGW+o2mSwbpgiU8m/XyLn0UI+AXLGP9i8Ysxlknb/Q04FaEPJG6nCxnJOBTq1PE/hpXMtdNJpTVotM0oEJqvCSdSkKA9uNg1RX4KnUoMlkVYVjC8JBnnZB03VSOqt3EnZtQRXZzmrlPXzml1YLTAegRk+lH96KK+bVgqHsxcdHK9IM7whq0YYe4Q5lLYBxtNddFZQ3tRdA/K1EjyPOqMld1dQvODG4WIB+oFMRf6b05MiSuYcG5V0VB3trvB/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNQP7R4fixHdItVjQquYDz2UpGFCRNezXgcRL4ypHQA=;
 b=I/34zxpPf4g2YEDvNxS2ZsOXsAAY2a9QeLarvPHfEClt3Rc7/JlyOdA9SDtjs4ZaAKCzKer9xw9LHBapKdcXwb4naaT2XIg1wdbgce7h9FVw7s/opzUa7eQBGz9sFFATvkS5Oi3O6q5oFJN/WfNH0aW69NyBR41dwSJ9XMJFj2TP/XnIvbEnNDzMIHNJMgl9xJdy1W3t6xeGb6irCFTAXiWV1kbgqwbLH4racdEwE7yAjC/eV56Z0lERZ9Zo4wMggAvAQYVAs2/hKBdkBmm6dT70aMEGP+mPoTEtU0B5IY1zknVZzMvn+itPSUxIiL9pWcLz6//IQ0Z4XJSc9tnPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 15/25] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Topic: [PATCH ats_vtd v2 15/25] pci: add IOMMU operations to get
 address spaces and memory regions with PASID
Thread-Index: AQHappd/2MOZbvh5B0+7dA4EtQBnhA==
Date: Wed, 15 May 2024 07:14:17 +0000
Message-ID: <20240515071057.33990-16-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 45e37737-7c4f-4599-5353-08dc74aea287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aVRDcVhrdUdzaEw1UUNEa0tXQkszdHhGMlBNVVl5SGwzazNRVCt3VWI0cE5S?=
 =?utf-8?B?V1pGVWx1Rmkyc3p3RURGL0xWUFVKandobm5Fa3k1V1lQZXZkT2tWUWIzVzcw?=
 =?utf-8?B?Y1IzcDFGK1JsMUFtMkQvbFB6YjJ4cVZ4THBvSUVIVnRZVWUrSjR1amd1UEN4?=
 =?utf-8?B?a2FXNlppaGNPWGtMTlo5Y2VkMmU2RDMxendteGFMUFd0aEVZbC9hekM3NERI?=
 =?utf-8?B?ejBNaVZSa2U1Y3BvZkpiVnpaNUZ1Rm5KdmVHeVQ1R3o5NnU3Sk4yZ2VDdEhN?=
 =?utf-8?B?d2wyYzE5N1hYRUtwZld2UXMvbzRKWCt3MlNIZFB0eVQ0UlM2T3c3WFZWZUxG?=
 =?utf-8?B?ZE1xN3ZhNzlVQ01MMW5SZ1p5OXNqNllFa3hSVFVpTFpTbUVmL3lqK1R2OFgx?=
 =?utf-8?B?bFJkeEFhdE5ZMlY5ZHpmMHQ0TzBaRHYrbExJYjFTYXNTeGVwdUNveEllRVBU?=
 =?utf-8?B?ZXM2K0dSZDVadk5TUmdXWk8yZ1VwcjVGRUlPWlFJZ1JCRkZoZnAyWjNIRkFz?=
 =?utf-8?B?cnhjV0Z6QWFZaHp2aWlycEdUVXE0M3UyT1oyK2QwOFdtUXZzRXJETDM3c3Fv?=
 =?utf-8?B?VHVOME9udEdGcFI5ak8vVTFiVVIybWtJWlpNRmUwL1lnT3YvQitBTTZTdFlU?=
 =?utf-8?B?eFF1MXBRTEY0U1BUYWFnbGFJck91T2YvRitMNlNGNy9CclR2eUxnaFZjQ0Zt?=
 =?utf-8?B?VVVNMG5uR09FWlJJWmkvdDNFajZQaEQwSnMrMHlmbUJ3T1dWSXM4c3JVOVJ0?=
 =?utf-8?B?YjZna3JBVjd4TlJhN2JielZYMkQxWVFxQ3NOb1NUZzd6WXIwRllJSDk0V3Z2?=
 =?utf-8?B?Y1B0MzFuWUZyM1Z1U3JLcmUyNGJTNDd0ZGhQeXZzMWJMR3hHQThxbDF5ZUVn?=
 =?utf-8?B?MXFMMHpJR01rUE95azJkZW1BdVdMblJxWnJpR0RBcFh4ZCtsQTRuS0xVckZt?=
 =?utf-8?B?R2ZCRXdYNDBIaFJaOGVqUmE3a1g1OXdUVnhaTGpSS0ZVQldUQ1dNY1VXVWg2?=
 =?utf-8?B?aExhR3ZtbVZrT1UrVVpTUk02MTRxSEo2czBJYlhoY2YvR1U4bDMrSGdHU0pE?=
 =?utf-8?B?Uk1SUmwwbEU4VlYxQkNJc1ZQVGlLL3dUeHluNWMweENsWjRYYXByRFhBVU95?=
 =?utf-8?B?OFdPSlZOSnhDRDB5V3lvQjJoOUN1MVFjRkxiYklMYXEvSFZ6RkwrQTRKY2JR?=
 =?utf-8?B?akN4OE9TQktvSE1NbmszeHhnNEFIakRzdm11Umx5bW5zMGgzWE1uZ3NYMWFs?=
 =?utf-8?B?aXZrQ0Vsait4N0ljaGJFRXFtTG5yaWNlYk4wZGFhWHNscVRPRm45Z3NsdEZU?=
 =?utf-8?B?NVhsbmZuMVgrNGpmbE5VbFJKdi8xRUowZkl0NEJTQUFxcXdYKzB6cjNLQzc5?=
 =?utf-8?B?MkhFbEViTWVQeWdMT1I3OTlDNk50cHVST2VjQlVmTWU4UGxVSHpUMVVETWtx?=
 =?utf-8?B?YWFaM2RiVjZKOUwzVHZkb3h3RGRjU2o3ak1paVk1MzU0YkdjUXcxQ1M5aGdl?=
 =?utf-8?B?SmFGYU92aGJzSWRzYlhudnlZVDdQa2ZUZCtvMWRvUEtwWFk3RkFYYzc5OHR2?=
 =?utf-8?B?dmNtUmpvWnFGZjdiSmxLdDgxMysyU3BwRGRuZUJOSEZzZ2xlSC9XeTZZajN4?=
 =?utf-8?B?K0Zpbjh6QmxrMTk1SzRBUDJCTXhMM202Wm1QTDhBSFRvQ3dxNTd2SWs4M21m?=
 =?utf-8?B?TUlveEJ5NkZRQ2xnVmxVQ2hnR3JWTml5RDNpbkhhZjhGN1hlZWdGdDdnSTNI?=
 =?utf-8?B?MGIveGIzQnA5QnNOVG9UTG02ZkRVZ2R4SUYvQytseCt1VkhJUi9pcCtrMVJQ?=
 =?utf-8?B?Y2NrSk5RbFBvL1dHdFE5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHdxODlqM2FyUktLK3ZSN2x1dHFpRzVXNVluUE41MkE1dy9oaFNaNXlEUUd6?=
 =?utf-8?B?bi9rQ1ZXc3RNN2ZKMEZNcHBjazVJclJ1RFY4U2pxOGF1VnIxS1YwVG9GZzZu?=
 =?utf-8?B?NDlCRmlFOERBUGNXSVorcXRhZVVHRWhiVG5XWFFrNzJxUUxzekZsTkY5Vnlv?=
 =?utf-8?B?WWdpQWx5R05HWFJWeEFqU3RmUmhDVmlXa3I5UEJIemdKTGZKRjloN2ttSjJU?=
 =?utf-8?B?aVdHQU5oMG5RZGpxaTFJMDQyTCtRWG1FV3BkSE9UUkdzV1pQQlZ2c1BUKzNu?=
 =?utf-8?B?UGpJZm1sem5UaFFaWS90b0Q4WDhIQVkwclRLd3JtMjgxd3dWVHNXejhNM2RF?=
 =?utf-8?B?bFVOcitvb1d0aU1ScG14MVd6NDV6ZzN2VGlQeXBDMmVPbkFQd2JWeUt0UXp6?=
 =?utf-8?B?TFg2YWpxRkFHdHhIMkNhcWxtYzUwSElYTE1vSUZNNEVJSktqT0NiZjFwUC9x?=
 =?utf-8?B?Q3hrYzVMTm9WQWRScVN6dzNGU3UySXNEYnQzOE9XMmVCUWpnUWF2ZWRCWEt3?=
 =?utf-8?B?OUlqUXlxMFZLYitzaTJGOE9ReFRpb01rdnhLRUp2WitPa0U2S3VWMENRTGh6?=
 =?utf-8?B?S0pGV25IMEV3YnhWYjFqUG5GUlB1WTNhNStuSCtUQW1RTFZ6c1l6bHA3U3RH?=
 =?utf-8?B?SkdabWIrTDFtUmQyZ003UlY0U3N1RkZiVGJmRWZqcVExNTRnYlV1dnZhVFk4?=
 =?utf-8?B?NXJaTHdCS0lXaGhXQ2FJaWUvK1psOS9kdTd3NFVGODlGM1AveEQ5enl6U3ow?=
 =?utf-8?B?VkVsL0ppQW9DMDQrMGRNWW8vaHhRSmExV1Eyd3BJbGw5R1d1YVBqbGl6a1do?=
 =?utf-8?B?VGtNMDNBbTIzU0ViVGNSZllQNUFHdENPczVYUHZDR2ZQZDNkR2VmUC9vT0Y0?=
 =?utf-8?B?WmFuNHduNlo1NERFQWRYSy9NMGdXd20xbGEzM3dpUTQvam5DdmcvQ0FFd1hY?=
 =?utf-8?B?ZkgxR1pxVDVxZ0pPSkxVR3VLNE1EUXVTYUhJbkEzUThUYnJ3Tk1IbWxhUktV?=
 =?utf-8?B?VHNVZDd0eXlkTWU0TkFqd2ZnOVdaVUpvUEo2Q3ZSaHp2cmFhbUtqazBLa09h?=
 =?utf-8?B?NmpETlNDUGJIY3BqTGFzblR4bjNNdU1hSU01bG51bDh1Q3dhek15MWlBKzF4?=
 =?utf-8?B?akZOS3VPclpISjBBQzJKM3RRM3BLL3ZIR0hMVFdTK2VqT0lpM1JsNWU5NFha?=
 =?utf-8?B?b3U4c1JLS2M0dHpPNkRJcGsyT3BrYzA1VnRadUxkU2pnVGttOXFGMWw2WUNa?=
 =?utf-8?B?Q1R0RmJwRmdSdmErcmVkejBaaEtpZll5QUNjN1JaUFExUkx5TTNvbU5rTkgw?=
 =?utf-8?B?MDZXZmR4NG9HbEtpdWtZYVVsMUhwSzdxdTM2a0RXK05lYUNzeGZraW5UWUha?=
 =?utf-8?B?ZWxONlhKMzIzQTNTQW8yV09EdEdyd1VPVlFEMFBZbHcwMTNHdFVQZCtydDly?=
 =?utf-8?B?U250YnRYQVoyWEF2MTB6OGxsaUE0R2gyWWlBVDFvNEtZMjc0RnNKaEc5UE1r?=
 =?utf-8?B?QTc5b1NjQVNMNlRXeWM1amxzTzEvVFF5Zms5RHZTdzFpUEh3UXNpS0tQWVZ1?=
 =?utf-8?B?RVBKSnNGck8rbzZKb2JHNGZtcnlQT0hZOG44NVcvdHZUeUh0WktTS2dtaUFY?=
 =?utf-8?B?TDRLRnJNTTFIVjJpTkpCY3dtZHhIa3kwV1Npcm5JOGlabUJsaGtneXZoV2F4?=
 =?utf-8?B?dmFQMUxQK0xjUExLY1MvYytnV1AzaW9KU2E0aW51YVhodkIySkxpc29RL2hR?=
 =?utf-8?B?WHovcjQ2VE9HUHhDODZpK0YwcUpNOGQwTzZieXhpbmI4czgrTDU1MTIzSVlI?=
 =?utf-8?B?VjRuYmx5Sm9mR2hrYzR5TE16SzVLR0h0UFp5N3QxUzRtUXV5Q2QrdUxLSWUr?=
 =?utf-8?B?Rkx2OFg2M0Y4VS9GN1pqejRpdW1mVC82azE2NjFFWHRjMjdGNjJRam5RM0dx?=
 =?utf-8?B?b012Tms1UlI0M3FTemh2UEtmNXJOazR5U003MFdLT2duRGljcUpST1BUblox?=
 =?utf-8?B?UDlOMHJFZGJWN3JwNHg0RXVCS3NRWVRPeVpVWTY5WDk2TzJKTWdWZk5uNkF4?=
 =?utf-8?B?ZlgwK2VKOE1abENXdmk1OWNoWFdPZWJuNEY5SjhpNEdzeHpLT0pzK09RdTYx?=
 =?utf-8?B?bHdUUlJsNFRsTFg5S25laXl4cTVyb1hyU3RMbU9LdTNWL29QK3ljYTdsQmZU?=
 =?utf-8?Q?A94l1xGGJfm4xId6pTaFsMI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <511425C4B0282F47B65070D935457777@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e37737-7c4f-4599-5353-08dc74aea287
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:17.6735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //EFfkeCsfCSDi2iWHQw8feH6Fj2N3O7bnuwmfFQB2BvNZhQseyw8XJnlvwjrCUOj5seyy9gj9u6l4RWZbLVt2LR/o2jhwEd1T+hKFAiiqLZ8sMdrPlo/buqLD+izuwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICB8IDE5ICsrKysrKysr
KysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDM0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggZTVmNzJmOWYx
ZC4uMmI0MmI0ZTRjYyAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3Bj
aS5jDQpAQCAtMjc0Nyw2ICsyNzQ3LDI1IEBAIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21t
dV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KICAgICByZXR1cm4gJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5Ow0KIH0NCiANCitBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVz
c19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkNCit7DQorICAgIFBDSUJ1
cyAqYnVzOw0KKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCisgICAgaW50IGRldmZuOw0KKw0KKyAg
ICBpZiAoIWRldi0+aXNfbWFzdGVyIHx8ICFwY2llX3Bhc2lkX2VuYWJsZWQoZGV2KSB8fCBwYXNp
ZCA9PSBQQ0lfTk9fUEFTSUQpIHsNCisgICAgICAgIHJldHVybiBOVUxMOw0KKyAgICB9DQorDQor
ICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21tdV9idXMs
ICZkZXZmbik7DQorICAgIGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdl
dF9hZGRyZXNzX3NwYWNlX3Bhc2lkKSB7DQorICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21t
dV9vcHMtPmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkKGJ1cywNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsN
CisgICAgfQ0KKyAgICByZXR1cm4gTlVMTDsNCit9DQorDQogaW50IHBjaV9kZXZpY2Vfc2V0X2lv
bW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KIHsNCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQppbmRleCA4NDll
MzkxODEzLi4wYzUzMmM1NjNjIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCisr
KyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQpAQCAtMzg1LDYgKzM4NSwzOCBAQCB0eXBlZGVmIHN0
cnVjdCBQQ0lJT01NVU9wcyB7DQogICAgICAqIEBkZXZmbjogZGV2aWNlIGFuZCBmdW5jdGlvbiBu
dW1iZXINCiAgICAgICovDQogICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2Up
KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbik7DQorICAgIC8qKg0KKyAgICAg
KiBAZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQ6IHNhbWUgYXMgZ2V0X2FkZHJlc3Nfc3BhY2UgYnV0
IHJldHVybnMgYW4NCisgICAgICogYWRkcmVzcyBzcGFjZSB3aXRoIHRoZSByZXF1ZXN0ZWQgUEFT
SUQNCisgICAgICoNCisgICAgICogVGhpcyBjYWxsYmFjayBpcyByZXF1aXJlZCBmb3IgUEFTSUQt
YmFzZWQgb3BlcmF0aW9ucw0KKyAgICAgKg0KKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBiZWlu
ZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1ZTogdGhlIGRhdGEgcGFzc2VkIHRv
IHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAgKiBAZGV2Zm46IGRldmljZSBhbmQg
ZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBwYXNpZDogdGhlIHBhc2lkIGFzc29j
aWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdpb24NCisgICAgICovDQorICAgIEFk
ZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQpKFBDSUJ1cyAqYnVzLCB2b2lk
ICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBkZXZmbiwgdWludDMyX3QgcGFzaWQpOw0KKyAgICAvKioNCisgICAgICogQGdldF9tZW1v
cnlfcmVnaW9uX3Bhc2lkOiBnZXQgdGhlIGlvbW11IG1lbW9yeSByZWdpb24gZm9yIGEgZ2l2ZW4N
CisgICAgICogZGV2aWNlIGFuZCBwYXNpZA0KKyAgICAgKg0KKyAgICAgKiBAYnVzOiB0aGUgI1BD
SUJ1cyBiZWluZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1ZTogdGhlIGRhdGEg
cGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAgKiBAZGV2Zm46IGRl
dmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBwYXNpZDogdGhlIHBh
c2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdpb24NCisgICAgICov
DQorICAgIElPTU1VTWVtb3J5UmVnaW9uICogKCpnZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCkoUENJ
QnVzICpidXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBkZXZmbiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCk7DQogICAgIC8qKg0KICAgICAg
KiBAc2V0X2lvbW11X2RldmljZTogYXR0YWNoIGEgSG9zdElPTU1VRGV2aWNlIHRvIGEgdklPTU1V
DQogICAgICAqDQpAQCAtNDIwLDYgKzQ1Miw4IEBAIHR5cGVkZWYgc3RydWN0IFBDSUlPTU1VT3Bz
IHsNCiB9IFBDSUlPTU1VT3BzOw0KIA0KIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9h
ZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KTsNCitBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2Vf
aW9tbXVfYWRkcmVzc19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCk7DQog
aW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSG9zdElPTU1V
RGV2aWNlICpoaW9kLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKTsNCiB2b2lkIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2
KTsNCi0tIA0KMi40NC4wDQo=

