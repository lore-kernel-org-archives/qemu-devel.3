Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DF9C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78ql-0004dl-HB; Wed, 15 May 2024 03:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qd-0004cF-67
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:47 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0000oW-UP
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757271; x=1747293271;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wfT87Hm9vtsWcq1mrFUqY+kwxQjnIxyJ2Nm4l9OdZrY=;
 b=PSBl5WzT2fBTFmuivdXtkHGhW8FHbQiRTFCVQDbCMb7l5euOsZBFvywH
 lInAqblsoxlIGlCUzFaG2RkS67IQtvPocvvhT6GhPikuTWfTn/x5k7YfZ
 0p0aTFhYCyWiYDqXo67VEEqSIdeAIMZTWphZ3lQ4wwTEna+PnE5fSB+db
 4baqViHeDx5bE6Xa2zTkjIzJrr23Nc7aPXEoBWejSJMkr+M0GPqWtIuk8
 fpuTMjDYKe8Teo7vXXg+VkGe/rnQJgcAaVB1jFFbNKnL66xBKE8ynC5iz
 odyh/uYf1ciN0TQubtA1ufI05VD4LtY8na1Ooe5AnbpvigHK8ZYx2E5wh A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581806"
X-MGA-submission: =?us-ascii?q?MDFxmMsDuGfN1DEXDP745mYfXRJTnO+YtbpkBI?=
 =?us-ascii?q?5Dc/tCVXC6OTp6kJZ7qpsqHaDNFhCC2wAttAYlerD3J0gnijTR31/r0c?=
 =?us-ascii?q?OKJvWrlwKB9BmYlzTT7xUkxbAXU8HsmLsBgCEqqsS/OtHo8kk/QbxwwS?=
 =?us-ascii?q?s7PCRWphhwykXKQSMgUylj/w=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1WEdYKSYd4k7HkV5iFjyCkF5mh9OdkEExYpp6LAF33YoRi0ayvLnp5cUKTSZTQ4TYc/AloA2dN3QWxFciLhFzBKyi9tJkadO8CnOO7FRw0WkYUzFVbZs6ccou+RSXYLpdJrzMW2VKsWM4M1CywrIgD0fX5VL99AjpKBmuIBv65RjY9qA62nwN5RyYp4XG4S0GmDQxyT09lrLpxy7z6WCWKg6vs4Unea2WUH9nWTJ+Ldbx7wUPwti3gArSDdVgQzZdpXY5IKOKV5Fo863lrpdtTic/XdkyFDuYozWMLMTjkZL+yYVE3Vz0a9v0a2Ow3MihkpSEUnwXlmMsSczYQ/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfT87Hm9vtsWcq1mrFUqY+kwxQjnIxyJ2Nm4l9OdZrY=;
 b=QnnC4fkckX7DzbvHSfZGyjn1EPD3VBO1Hsm/VrjohE6S2NUTAzV3uLSyIclOayCBB3zziNLpcdx6KxnjpGHUVUiqW/E3Caixtqt9m0vhzL/Ic9VNw++k2yhds6GjwnyvyVFdEvYusVmbXHGsmXF3aPVYudisvaQNydGWXxOFWjTJywUIXtG8zbdV949XuwamnnjrCCHjcceo1LTbMeO5LtjTgc1Xwe62UhnCYhiBqhBQiJcK39gOe83a0VvwsagqDyWKZZXl5gH27iPpB+OSkCEy/5cK3yucWjTQxeyp6NtXgbUm41tdfxfsLTS+i1GEM6IH0J0fxH05FC3nUeRPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 18/25] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v2 18/25] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHappeA+wCa4WX+yUqp2IC7H1FoVg==
Date: Wed, 15 May 2024 07:14:18 +0000
Message-ID: <20240515071057.33990-19-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 00ef1aac-0b2a-41d2-8d82-08dc74aea2ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?alZKM3ZJdzlLbVZJMStjL1FFdWJMRUgwczNDd2J4ODZrT2JscXRhRlJDREJq?=
 =?utf-8?B?YnN6a0pDZ3R5LzRWbHZVSmpjTmNZQ1NmOFI1ZWo3cXJ3Mnp4N1kvc3lWZ3V5?=
 =?utf-8?B?N1paaTZzWlZoR0RWdVR3dGNDVTY4NXJRQlpkUkxvWnZJWG54WHN4ZzJ2N3ln?=
 =?utf-8?B?YUowWXZGcThXSTJxa1c2M09BeWZQQ2ZWN0NHendJaGNoWWZvbGF4L1dic1ZZ?=
 =?utf-8?B?aTgxcHJYRkJyUWEwSU1UaUVWZy9kenYrWmlhTkkvWmVMaU9sZldjOUV6K3VY?=
 =?utf-8?B?S09mRjJuUHZ3Zmg5NFJjZ29vSVlNVEY1T0h1bmlYbm94N2g3VTltNHJPM2RG?=
 =?utf-8?B?V1VpRFUvOWJYT3prYWxYODN5NUxENys1bWJmY3dXdmNIajBaSjI1bkI3UDh6?=
 =?utf-8?B?L25yNVQxM2FtUk4rUVNwVXFWcEJFaFFQL2FZMG8yZHlzcFFKeTBRWDlKdHhL?=
 =?utf-8?B?S3FTQlk3Y2QzVnNBcnIrdWlFNTRlY3RmM3JtZXltcTBxQzdmblZ0bFExQVMw?=
 =?utf-8?B?dFdyWDNoRlovTFBZbEFOaUZKVHlzK1JRTEM0YzNMOEt2VVRQdEhvV3lWZTVz?=
 =?utf-8?B?a1lLM1FVMWNiMWZCTldyOFNMRWZSZFBGVXhoMCtMZzdicnM0ZHRENkkvSjZh?=
 =?utf-8?B?ZnIrSElsdis5empaYW9BY3d6ZTFRem5nOHdyRkFWY1dicVphU2ZSQk9ZK2py?=
 =?utf-8?B?bmZrOXI3SU5OaGgrT3d6eW1NRDd2WmZmSjJwbnFRZjUwbkVyNWtXZUIvaHVO?=
 =?utf-8?B?THYybzNVNW4vSTVqUWJhYXo1OVJlb3pDU0dyT004VVdmVFZCK3c3MnpySFo5?=
 =?utf-8?B?WnZUbWh6b29meDlCSUIxNTYvRVdkRHlqdnByRmZiME5ReWd3RmNYbzFTRDQz?=
 =?utf-8?B?ZGozS3djOFkyZkxMa3lTT3ZtYW1QcUlqckgzcnlIeFRUbndheW94RFAvcHlw?=
 =?utf-8?B?RG5rS2sybjRuQTJpUmtseGJ3a3NMS2xERUNBN3doU29LOHkrQVUrUXdzMk1X?=
 =?utf-8?B?b0ZGVmdjNm10SUlSMWwreTdFWDlySEhBbjdGMmxsSUFFcTE5WCtHdTlMWUQ2?=
 =?utf-8?B?TTR6NTdEZThsckltRUdnS2dzeENSYTRETDZZZVdwbll6QWNRZmRGWmtxVUpZ?=
 =?utf-8?B?SlRSb2xhUk1POHQ5MWRzQ0tnMnR0RDY2WE5JZWxwSGhkeGkyYWxlNWNBKzJz?=
 =?utf-8?B?Ti9lV2N2UjRnTFdWWXRTVDFYNXB5M1hNODltK0FIb2toYmlRZ096eHR5WkU1?=
 =?utf-8?B?M3VhdU9xanJqaVVPKzVsSTBDSFE1ZEN5aHNxbkora0g5c2FQMUREclV6ZC9I?=
 =?utf-8?B?N280R0twa1FWUTRQTGwyZ0lKWW9tUzFDaDlkODRQOVFiWmhrTnI1TktCVWt5?=
 =?utf-8?B?cnc4cTNCay9xcDdQcW13VWJxU2QyYjRWd01QSmpLekFLbjZzNjlqTU51QWxo?=
 =?utf-8?B?NHhmekZQcXNjblBNQnpSZVQ1YmhhcDhzRktrWEhhZ3F6eWdxUHA3Wm9Bbm03?=
 =?utf-8?B?Nktucy9EelNMRFNTcmJVajNMb2cvZmtJWENHY3NxMzZJZVFVb1FVK2VDRDhq?=
 =?utf-8?B?eUlJMHBBWVgvZjRsODRJNXhtaVR5ZDhzSjVRSnFwZHdncCtvWDBINk45VHp1?=
 =?utf-8?B?OFhNRW0xdGpWVkZZMnJsNks5SWp1U25DYVYycjNJTVRxM2dUelozZWQ0TzVn?=
 =?utf-8?B?c0M2YjVxbWhiZkVaY2RpcWFnTFN3bUZueTE1VW00bjk4ZkMyOU9BSjVOM3o4?=
 =?utf-8?B?Mkl4a2V0UVRVS3g4SHRXQXhWdmVNdWNuejNXemVuZVlXQkdJbkt1U1p0TVdr?=
 =?utf-8?B?dk1USVR3VDBzY2ZjT0dadz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0RoSUdIek5EdGk5K1FuUGFBK2ExMHNYNVBGSHBoWUhSbzRsclVtL1YwT0NE?=
 =?utf-8?B?TEtpalNnbm11UW5aU1ZlQ1RPSkxuMDk1ZWFETHVlTmhBSm5lVzdQVW1LaXB6?=
 =?utf-8?B?WkpHQ1d5QkhRK2ZKVFZmaklhampXejdHbXl5bWpBQXRreDE1L3RoRENJR1Ft?=
 =?utf-8?B?SXNzdG5RSjBQOEtPUVEyWm4vN01YL0hzanhzYzVCbnZSYm9zMFpHM0pmSUFz?=
 =?utf-8?B?UXZKYWlIN0tLN0Fpc2FMTldLOWlsMFhzTEsxTzk1ajJkVDZLUnRFVWdpZksw?=
 =?utf-8?B?djdPMG1KYldkYmgvZVEwKysrL1NybDVhSWIreFc0Nk5HcnlZOXBINkVsaXB4?=
 =?utf-8?B?SzlqSmRsZ2JQYzlOU3lUaGRkWnJHQVZMU2Qrb0lxOUxrZ1JoNnBQNFVncEZJ?=
 =?utf-8?B?dmFoMkZUblBkdmFOSlhadERPSXBTV2paWVNPMGphUnUyRE9kdkF6WVJVMldG?=
 =?utf-8?B?RmFqMnJueURwcGFXNnk5SzJKTjdBWTR3aE9OM2FuZmpBODgrRWpSY1RlMk5z?=
 =?utf-8?B?dHZTTEk3OWlmZEY0NmJhUFZMSlZPUmZGcTFoWHplQkROaHovQWxvLzl1MHJT?=
 =?utf-8?B?dElFVys5RVBwczBZTFFVVkFWTEo4V3dVdCt0L3I5VmdHenRGVU5qYjJNWW5y?=
 =?utf-8?B?UCtLVmlrL1lEQ3dGL3REZmhna1p3WjAzdERQSkRORzBmamlyODZBS3gzcU91?=
 =?utf-8?B?U3VGMWVuaXJ1dkRKZzBrMDNXYW9OZ2R3ekM0Y1F2MzNqYjM5Z0Y1dzczZzE1?=
 =?utf-8?B?cCtTaWZBL3lIM2VqOVBpVFhSSTkySGxTaml0bXdLamNlTHlrUkEzZjZqa3Jk?=
 =?utf-8?B?RXZhTERuay9CL1NEaXpkb2d0MmpuZXl0WjVQQlowMzhIWVBJN1ZObnRERkJN?=
 =?utf-8?B?aVppcHFlQXBjMkJDbWJrc1pzcWw0cnBlRkwwQ1hPNTNyWkxaUDJvVS94YVhp?=
 =?utf-8?B?TUFycEFkaVVOUFFUWW1YK1FuaGpobEJYMkJnZG9mOXdYbHZmUXlvOHlBREkx?=
 =?utf-8?B?dGNQdUZuS1RZbXVKTEhleU9xMlV1WnMvRTM0NG1nTzU5NEMwcG8rcXIxb1Rk?=
 =?utf-8?B?TmcrajB3amI2USszc0Nqa0s4cjMwdGhRck5ZQnV4ZTZjOXQrN1NielQ3M1RX?=
 =?utf-8?B?RVpuVlAzSGJKMXhEclpmRDJFS0NvcXJrVFBZbTd6dE1FK2hnU1VTcmVWNjQx?=
 =?utf-8?B?c3E0TVdxWG1uVTh4VXpOTHBsQTUwbkhqMGhpOGYzWTJvK1NxWFd4Rmcvb2RV?=
 =?utf-8?B?Z0REUWtJeHFlTEwyVlZJaVRMVXpvajJobWhjdmhuaUp5RTB3aldCclBodFJT?=
 =?utf-8?B?Z2Q3aWhhTmpGenZ5Y1ZGL2w2ai92aXJHZ3pDNWV3Q1dZa01YaTE4OUp3VkVq?=
 =?utf-8?B?Rm5KL21ZYUpRN0Rkd0JnV3pHem1zK3h1OUFCOTV6cXRNdE84QkZTbWQzN0lI?=
 =?utf-8?B?ZFlQTXIxRmZIeXBCMUVvMlMvclJuQ09QYTA0ZytGUDh2QXBuYm1waThCR0o0?=
 =?utf-8?B?cGxQU0creW51WFNraC8xbDhIY3BuRm1NRVY2MDQ3RDN4eXdlbnBrZUV3Z3dx?=
 =?utf-8?B?VnluMzE5bWNiUlBZOHJ0QndVZUFIenFTdXlWYjhPYjJ0WU9ZQy84K0N6eE51?=
 =?utf-8?B?alF0d2FFNXk3dmhvSjRVYjd2U3pTN0pKc256dmc5RTNRVlIvSFlVVkw0Q3d2?=
 =?utf-8?B?d29MTnFCdG5zK01JWEVCblVFWHk0VitWRUxHQnhJSFVLQkRKZWJnaE1GQUMy?=
 =?utf-8?B?RTFxK2ZWelRtZU0vczF1aE9kdFRxYzBCNDYxQlI0R0s2dEpLWW1sOWZPcEhl?=
 =?utf-8?B?YTdJUEthZDBERzZyVGxJS1VWUVMwd29wNFJJN1h0T0hGNCtQQlVIeHhvcjNY?=
 =?utf-8?B?bmNjcStTVjk2RDBLa0IrYVBmNkxrT3hJTzhaV204bkVFS0dVUExoRjFWQUxZ?=
 =?utf-8?B?SExVMGdoTU9FTnNKTjRXMnMxczhBbVcvMmcwU205anR5NjVaZUtOT2hZbTlU?=
 =?utf-8?B?VHVjYXpVL05XcmpNZ3BFc1V0aHh6WXpjQ044WXJBMzVmZVVSbVdCZk1xNm9Q?=
 =?utf-8?B?UzlQbldoTGlrZWd1MzcxcFh4NDBOcy9VdzEyWEw5Qi9LNEZaZG5rL1ZMUDl4?=
 =?utf-8?B?cGZCeldWbE4vSm05dW5kTzNqdWRQL0JNYWxxSHdiSVBCTUpNMGpYbUo4NDVz?=
 =?utf-8?Q?u6KedojG2HIaoGwfnwVGAh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <875B6603ACF6DF4FA2517CB43EC0ACC8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ef1aac-0b2a-41d2-8d82-08dc74aea2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:18.3760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pmXlBrbswZ6tnuK56rOm57AXC2qBhpUCSU66R8snQ0+ntGxih6gSU/8IhvTaH1cYMAcwFweiS8ya7ZDWOxT1Zh/xM1MpdY0YY75x2OGaDOOROb3crZ6iTULUY5b/Itw
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
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxNSArKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCBl
NDhiMTY5Y2RhLi41M2YxN2Q2NmMwIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC01OTk3LDkgKzU5OTcsMjQgQEAgc3Rh
dGljIEFkZHJlc3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludCBkZXZmbikNCiAgICAgcmV0dXJuIHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZChi
dXMsIG9wYXF1ZSwgZGV2Zm4sIFBDSV9OT19QQVNJRCk7DQogfQ0KIA0KK3N0YXRpYyBJT01NVU1l
bW9yeVJlZ2lvbiAqdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
Km9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgZGV2Zm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0KKyAgICBJbnRlbElPTU1VU3Rh
dGUgKnMgPSBvcGFxdWU7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KKw0KKyAgICBh
c3NlcnQoMCA8PSBkZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KKw0KKyAgICB2dGRf
YXMgPSB2dGRfZmluZF9hZGRfYXMocywgYnVzLCBkZXZmbiwgcGFzaWQpOw0KKyAgICByZXR1cm4g
JnZ0ZF9hcy0+aW9tbXU7DQorfQ0KKw0KIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVfb3Bz
ID0gew0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2dGRfaG9zdF9kbWFfaW9tbXUsDQogICAg
IC5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZCA9IHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZCwNCisg
ICAgLmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkID0gdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lk
LA0KICAgICAuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZSwNCiAg
ICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlLA0KIH07
DQotLSANCjIuNDQuMA0K

