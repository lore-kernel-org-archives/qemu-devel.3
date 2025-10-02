Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD26CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EVN-00063g-1h; Thu, 02 Oct 2025 04:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4EVF-00062m-5X; Thu, 02 Oct 2025 04:17:30 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4EUh-0006r1-2S; Thu, 02 Oct 2025 04:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KINaFMTPVpAWBI0WUEnWelqazf6ulTV03VU9/Zbd6wi2Eifes7IACPs/yJsq+qaMCA7V+Wlt1nian2oU0BkvsH8uNqsE/aYOj1MV74eXZLxKi6J2kkMxHvuWUC8TOlqWhwWg4CJOcloTfs4Tc3EBcpSm7NgyabvBiKmJCy7jGsXnzJaX8PGkiBE2LleQnjztcmacKusrimYcvLoK2wCVTV0xirk7a5N63taLrblkX6TdJgTtpYUHuUeNZhhMW3typfSJulsNdYyDyVEqRuB+t0uSRpgVE8Dq14eLaTW/b1Dc891K9tBCEkMVizn+KdY9FKHsZMOu9Lgkuh8EJa8Q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSfb1b3NZSS4cAEo5WeVRamuwb7P/Zqjozrt4tM5ZoU=;
 b=WMvaBp78rw6asnhRJhIHbZj/4VG4pmTRlNL+2ImTOQni2SRE962EeaSInAchWMfQS98+KXwXHIm/bdS6vZlbGzk5YZIRVYk8sm5+UvLtFExssO27oO9F4iV5czNO6Y68N4NCcxZUedX87CWEygu3pc8vZIgwzGyoOj41seHFqqCAEpiuPd3wl9UW7Of8DjBJ3pm/oU0AckkbgYz7HrevEXEdU/sENAZ5YukR5y6d02DgekqU+zNb3ZHpi5AhEwRtmXOzpzVGxTktroCLrzSUXtRNayJkVUH1MFzDcH3nm66Q0l99p7uEbgsXyUHim8SWblnniPoYYayyOiUHbII05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSfb1b3NZSS4cAEo5WeVRamuwb7P/Zqjozrt4tM5ZoU=;
 b=fCTLKomRs8eh8dS3h/VA8WL9kbqQpggby15EpBkbSEu/ogvAPyO2w78PHuOr4Pe4mhniFlkE14RScKFDI/zg9MVrIVf0tHUBwHt7GlcMQlWuZPiV/Y7GGpKHSDmse9EaeN7DdY4LuKrx9aWW/8oR42+vIJy7GfnqnK/V/Z2W5U6dzIonWspI/OEtJsJzIUSHqF35BGxZYtgvIpX/pAAJAxQzOq+fAdTx5DPcIz0xc2Q5Oc0fk0ssA7/L2ODMqH+brGMvWaB/rpik3aLpVgsy+bNuAEDNRUR1cEtX2Z9gvanO0X3WMLsIcE+hgx3WFxqSXD84GziE1JZRVOr71GqASQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:16:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:16:34 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcMVtWHNFvMFbT2kCFLixXDfUlObSrW3YQgAIldgCAAQKEAA==
Date: Thu, 2 Oct 2025 08:16:34 +0000
Message-ID: <CH3PR12MB7548AD9EEF16141DAACFDE3BABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <20250929170839.00002db9@huawei.com>
 <CH3PR12MB7548CD6223A90CD41D216353AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <41e361a0-5b61-4731-b12f-9a42b34b50e2@redhat.com>
In-Reply-To: <41e361a0-5b61-4731-b12f-9a42b34b50e2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH8PR12MB7027:EE_
x-ms-office365-filtering-correlation-id: bb8f0b9b-b886-492c-bb1b-08de018c0021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RUo3OU5EbXdWN01ISHM0WUtkbWRtMjluN3RJbXU2eVM0NDZMdDdjZDh1azh3?=
 =?utf-8?B?K0VVNkpUbis3TVBSeHhOOWUyeitNVFg5d0RYUHYwbC9zVnRpckdwZ216NG1o?=
 =?utf-8?B?eC9KbWlORjZEdSttaU85YzhDTGw0anZhTDRmL2hvbUJrQWR5RW82UFdYZGJy?=
 =?utf-8?B?L2IvWjBhTjFCOXBpMnk1Mzl4NGROcEZ1SnE0YlZNVVp6SllSc3UzenRqNThX?=
 =?utf-8?B?c2VYQkJJdXU0Slo1VExFQWNweDlBeVp0MTNvNFNtOWRzM3p5Q2dpajNsN3hC?=
 =?utf-8?B?a2hXajRhLzF4cHYxWFZjSy9Sdk1STmh4OU5GL2gvRHNLZDA5bGhiQklHZ0d3?=
 =?utf-8?B?Y2Z3bG1zWmY3d3gySXFUTTJubVN2TDFBU2wrL25kVGZFcFBFLzZ3STQ3OEdh?=
 =?utf-8?B?dDNzekQ4SjlrTktNNFllYUV5aTN4Z1FnZ3V0UTNmaTR4L1dRK1pEYlRiZW1M?=
 =?utf-8?B?ZDlqbTlDUThLbE5zM2Njb2N0VWFLRWU2UW16Rkh4RFBlNlVPOGorQVdZVGxi?=
 =?utf-8?B?VEZ0aXZkQ3N1ZTZtNVlVVHM1WHVBVTZkTHN4Nk5OUXRlakcwYUhYTE5LMU11?=
 =?utf-8?B?a2ttZmZLYU9naGVBMU05Sm16YmZSalRlTE5sWFFMdTBJdjJCQ1MxTXJPaGdF?=
 =?utf-8?B?L0VJUHNwQnlLd0tMZlhKV2lZTkFFRldyUzJRby9KN3oxV1JCOGsvcks0NUJj?=
 =?utf-8?B?djQvVkM3WFpDNERxckpPdElVeHlnYnk1RnVHbTJ4TE1CS1BkYU5odHZwUkNu?=
 =?utf-8?B?Skttc3hRVXA1bFJ5Y3JTTjRLN3E2OFQveDJDZU1zR2xzQjk2RmE2cFdlTitl?=
 =?utf-8?B?MTlUMDMxaDFtQXBLeUJ0cUFYMTlndmsvV2xXMW9RcXpCVnYrTTlHSmF5cE1N?=
 =?utf-8?B?OVAzVDRSajhtRFpYcE4veWFKWVYxa2xoVWo4dmJPSElaOWp5ZFN1amhyOGxZ?=
 =?utf-8?B?RGpoMlI3aExwTXZNaVBpbHBMc2trQTdhVFpFTzYxaXRqWHBZRGJqV2pRU093?=
 =?utf-8?B?OERRSnlIajV6UVo1OENXczBsem9WdHpqNXdXWGU3eVhOTnZmcUg2M0tIQTd0?=
 =?utf-8?B?N1JUYU1QcmlZcXp6MW02WDJBeGlqS2REQ2hmNkg3bitmNTF0RFBPaWE5Szhk?=
 =?utf-8?B?UDFhV2M4ZkNTdzNydmdLUXp5aEFQMkF3c1d5OE1XZFBMSS9XY3J1SXl6dDVn?=
 =?utf-8?B?LzVmRllKbDdFK3J5RmFHcWVwRzkwTlMwbEJNMWNYQ2dYNENZaFU1ZGpreHhW?=
 =?utf-8?B?S3NmT21MNXdkWmtGNnRUbTFEOXc4UEVMbXMwUmIzWktTTlNrazBqMnkzVzdq?=
 =?utf-8?B?L1paU2F2MG85Y2Fob0s4VjRpRzlJYlN2NEc0R0xFZ3B1eXUzRldya2RuU2hn?=
 =?utf-8?B?cmQvaWhyU08vUkFNOHVVOW5vWm1LSTEzMEZrTE1ORWtCcUVJanJFWEtrMjZK?=
 =?utf-8?B?UEVwamt4VDZGV2JhL0xVblMxSzR4RlFJVGpFWkg1c285NzRCWVFKRStrQUJC?=
 =?utf-8?B?YlVObU1KVFhOOGxObmJsRkpRWUVPQzZNRmZRSVIycXhVTm9KRTQ5RXBCTTNs?=
 =?utf-8?B?RXdPQ2FvenF1R2twRXlkQTRwY0Z5eE5wREVjeXpEdi9aMllVRUJwZFdJQ0N4?=
 =?utf-8?B?eUxYcG1nSXlETmpzby84RmZnOTBNQ1FCK0U4cmhVM0VaMk55VlZabGtldjky?=
 =?utf-8?B?Vm1TR2JBTnB5QVlXNE1NaXFkcWFuNXh5Q09uakJnMXpENzY1ZjFnZ1JCS2g3?=
 =?utf-8?B?YXkyOFJUWU5wdEUzK3Z2R0p5UEM4YWNjMHVvK21qQ1BXUjhlc1JKWmRiOWxa?=
 =?utf-8?B?a0ZzMXFpWWttVFE1UmJZdHZlSkNBV3h6dEJFNndqYUs5ckhrSE9pVTlrNjNn?=
 =?utf-8?B?Ulo1WmppSkREUWlpcll5elZ6ZEJXNGtNUWlVampueGlZamN4NDZOb3R1ZnZK?=
 =?utf-8?B?NUFKZXp2dnZOQWpDekNsMHFES1hlQnRKQ0ZJWmVsd01jQWRNM1hNc2VnUGph?=
 =?utf-8?B?NXkrWEJGeU16alQra3dzb0VISjkrcEVIL3VsN29zcXczR080WjB0b1pidllG?=
 =?utf-8?Q?tLCpCF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHdvVlBxTnM2MmNUNTc4cnVVQklKeDZCTVRJT3kydm9XQ1BxSmlwL3Jqd3JR?=
 =?utf-8?B?SFZGeGg1d2lCaEo2dGlJc3FYaGU3Mk5TOEhQS2FVcUNJWHJkTll6dnl1SW9s?=
 =?utf-8?B?UHV2Mk43SVJnNUlROWhRUS9LN2lYYWFJdjR1TFRjVmZld1pndGFoZmVDWjZ6?=
 =?utf-8?B?QUFwVVFXWkZsZE5PUjcxa0prbXBYSDVXYWxVWGpPaUl0aXFXY29XcmtPanVj?=
 =?utf-8?B?djFKa0FFbGlVdmZ4T09zUnl4QlB5ZkF1TCtkdWIyNWNOM2dtKzd0TXNja2Y2?=
 =?utf-8?B?bC8rZVQ3cmJyT0tCbkorNWo4L0dQVnI1TldhRlhCUWxUVmpNUWxLK2w2Qndt?=
 =?utf-8?B?Rkw0TWQwTFUvMXhhVUQrYktVNm8rMnhaVzFqUy9FcUlNTlBkR09RUTAvNXIv?=
 =?utf-8?B?QWI4bWN2amJwUStkdGNVc0FlQ2RkcDBqbGlYbDRiU2FqWlU0NGhLNTY1Z0ly?=
 =?utf-8?B?VWw1NXVrZ0hxVHBtN2RmNjB3Z050TklQeHYrbzh6Yk1tVDFpYUZZZFlRSDAr?=
 =?utf-8?B?WGlYV2h1ZXR6VmlsalVYMXBKRVhQb2Z4VERIY1dSR08xUjYvVkdIbGcraWZV?=
 =?utf-8?B?RGpBaHUxdnBzNHNRTjdBWnIxRDdxRElmL0E1NnBLdGJyaEk0Sk9FTHN2Y0FO?=
 =?utf-8?B?ZHpYam5NR0NzTGJsVnJ6Ulh0T0ZoVzRyaTVaWDhUaWVZMHdleE1LSWJ1ZE5F?=
 =?utf-8?B?V0pKNVBjSG5DWWZTczF0S2pabzNzQWQ5RFlUU2VxOGd6Qm9rNHRDUjRjT3c5?=
 =?utf-8?B?UTIzWUpESmU1R2tQU0tna1I0eGZjYkd5dnJUdEIyV0VVMzFVaU9acU51L1Np?=
 =?utf-8?B?c1V2c2NYdVBJMDZSdGNmWExpVVZBU053Y1RPSklXc0JraU1RM2t6K0tQaFR6?=
 =?utf-8?B?TmdNUnRtT20xQmRTdmV1RzR5cjlEbXVFMkZ4dXVoVjhobUZxMXo3cjJ1RXhC?=
 =?utf-8?B?a1FNWmdsQ09sQWZIZFFmWW1CVURyMHFHUnlSWDJqdnFXZmp2d3Z6ZDhBY1Fl?=
 =?utf-8?B?UVJNRkltVmRYemd3S1lxdkhyYkFqMHNsdng1eWdHVnp2S1BodUxjOEhBVFdG?=
 =?utf-8?B?WHQwZEI0QnQyTWV3bUZhakpubTdSeWc5eStLYXBYYVAwUUZBZDBkamYxV3VR?=
 =?utf-8?B?RjRsWkhTOVFUczJQZ0hRTWxyU2xIdG9mTXhzZFlSQXM4aURYMFc2c01DQWVz?=
 =?utf-8?B?M2pmQUxlVnhrbkhJMEVJc0wxMGdKZXVHNW16UlhCQXNkaDhiYlMvZ0wzWmxs?=
 =?utf-8?B?elJvQmJ4dHlrT29tMUZmSE15K3lIdExZWnd0ZVFsNnVYTS9paFpoWUtiTnBj?=
 =?utf-8?B?aldncnRsUVBPeXRlb3JoWUhOK1NxZWc3dFdFTVJPZDFPNmV2TmxTTUJONVRH?=
 =?utf-8?B?N2hIYXVMWUxmenlFSjFOMGk2WG1FQTg1c2tyWUQwYVlmbmlrb3RraXRkY0VO?=
 =?utf-8?B?KzNJdnkrMjZOaXFYOGI0ZStMNTBKeVRRc0VZRFh0UFRGeDdUQk90VWN0MUFR?=
 =?utf-8?B?QlF4RHNsM0t6VytwOVozQWpsRWR2eVA0WWNwTVRDd1FYd0pqUXRkSlQvc2RB?=
 =?utf-8?B?cTF1ekZiU1ZTQmx1TTdmWFhtVk5QbWVqQ0pmYjlLalVXVm8wbm9YMTdHVEtO?=
 =?utf-8?B?bThhN3RMOFpLc0plaW1FcHJkV1NHQitEL3Q0SktDeVdMbkdleCtaVytUTzVU?=
 =?utf-8?B?ZUVqdjhtZ1hXWE05cXB0WU1tNXNmaG43OGlraURSL1NpREZSSVBHeTBzM3p5?=
 =?utf-8?B?REhWRzhTTmVMbGNoTUFiaS9iaERwQThOMnMwNksvWlI2Qlk4S1JYdjFDQzdn?=
 =?utf-8?B?ZWpNd0JETmt0eTBHYVZsZ21tZ0lOSHdocytnQ3dVd1RhVlBDM1JwQjlPd1Bn?=
 =?utf-8?B?N2M3Z0NMWGtUOFVGWmJueTM1UVYxQTVUTi9URS82SktyZHFlNTZmY2llUG0z?=
 =?utf-8?B?YlB0Q3VQWTNZR1JwSnpSZUg4bmsxekFFL0VFSENVbTFTSUxNcW1kdjNaeEht?=
 =?utf-8?B?UlpDWUxGQ3hVM1RRNFBpQkY2QnljRFV1SU9IOFYvMlhhbTd2MDVzeFd6aFlB?=
 =?utf-8?B?aGFGei9MK0U5clIvTXVXa2pQWVZYK0lxMGtPQWl4VFFsQk15dGJmUFpkdnNk?=
 =?utf-8?Q?TvzrN8pIj/ov9eZcWY3/TN9Qe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8f0b9b-b886-492c-bb1b-08de018c0021
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 08:16:34.2013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjTdqXYZiGa7dBWQPZ91PcNFa6UAzLiFqMFVg8M2TJKr16m4p2bkqhv+qwaS6cmR6COXhniLYxxuTe3prlLrRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMSBPY3RvYmVyIDIwMjUgMTc6MzkNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9u
Z251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4NCj4gPG5p
Y29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5j
b207IE5hdGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hz
QG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29u
LmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7
DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFt
ZWVya29sb3RodW1AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMjddIGh3
L2FybS9zbW11djMtYWNjZWw6IFJlc3RyaWN0IGFjY2VsZXJhdGVkDQo+IFNNTVV2MyB0byB2Zmlv
LXBjaSBlbmRwb2ludHMgd2l0aCBpb21tdWZkDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDkvMzAvMjUg
MTA6MDMgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2Ft
ZXJvbkBodWF3ZWkuY29tPg0KPiA+PiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAyNSAxNzowOQ0KPiA+
PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4+IENj
OiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4+IGVyaWMu
YXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9y
cGUNCj4gPj4gPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOw0KPiA+PiBiZXJyYW5nZUByZWRoYXQuY29tOyBO
YXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+ID4+IDxtb2Noc0Bu
dmlkaWEuY29tPjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207
DQo+ID4+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0K
PiA+PiB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gPj4g
c2hhbWVlcmtvbG90aHVtQGdtYWlsLmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2
LzI3XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZXN0cmljdCBhY2NlbGVyYXRlZA0KPiA+PiBTTU1V
djMgdG8gdmZpby1wY2kgZW5kcG9pbnRzIHdpdGggaW9tbXVmZA0KPiA+Pg0KPiA+PiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+Pg0K
PiA+Pg0KPiA+PiBPbiBNb24sIDI5IFNlcCAyMDI1IDE0OjM2OjIyICswMTAwDQo+ID4+IFNoYW1l
ZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+
IEFjY2VsZXJhdGVkIFNNTVV2MyBpcyBvbmx5IHVzZWZ1bCB3aGVuIHRoZSBkZXZpY2UgY2FuIHRh
a2UgYWR2YW50YWdlDQo+IG9mDQo+ID4+PiB0aGUgaG9zdCdzIFNNTVV2MyBpbiBuZXN0ZWQgbW9k
ZS4gVG8ga2VlcCB0aGluZ3Mgc2ltcGxlIGFuZCBjb3JyZWN0LCB3ZQ0KPiA+Pj4gb25seSBhbGxv
dyB0aGlzIGZlYXR1cmUgZm9yIHZmaW8tcGNpIGVuZHBvaW50IGRldmljZXMgdGhhdCB1c2UgdGhl
IGlvbW11ZmQNCj4gPj4+IGJhY2tlbmQuIFdlIGFsc28gYWxsb3cgbm9uLWVuZHBvaW50IGVtdWxh
dGVkIGRldmljZXMgbGlrZSBQQ0kgYnJpZGdlcw0KPiBhbmQNCj4gPj4+IHJvb3QgcG9ydHMsIHNv
IHRoYXQgdXNlcnMgY2FuIHBsdWcgaW4gdGhlc2UgdmZpby1wY2kgZGV2aWNlcy4gV2UgY2FuIG9u
bHkNCj4gPj4+IGVuZm9yY2UgdGhpcyBpZiBkZXZpY2VzIGFyZSBjb2xkIHBsdWdnZWQuIEZvciBo
b3RwbHVnIGNhc2VzLCBnaXZlIGFwcHJvcHJpYXRlDQo+ID4+PiB3YXJuaW5ncy4NCj4gPj4+DQo+
ID4+PiBBbm90aGVyIHJlYXNvbiBmb3IgdGhpcyBsaW1pdCBpcyB0byBhdm9pZCBwcm9ibGVtcyB3
aXRoIElPVExCDQo+ID4+PiBpbnZhbGlkYXRpb25zLiBTb21lIGNvbW1hbmRzIChlLmcuLCBDTURf
VExCSV9OSF9BU0lEKSBsYWNrIGFuDQo+ID4+IGFzc29jaWF0ZWQNCj4gPj4+IFNJRCwgbWFraW5n
IGl0IGRpZmZpY3VsdCB0byB0cmFjZSB0aGUgb3JpZ2luYXRpbmcgZGV2aWNlLiBJZiB3ZSBhbGxv
d2VkDQo+ID4+PiBlbXVsYXRlZCBlbmRwb2ludCBkZXZpY2VzLCBRRU1VIHdvdWxkIGhhdmUgdG8g
aW52YWxpZGF0ZSBib3RoIGl0cyBvd24NCj4gPj4+IHNvZnR3YXJlIElPVExCIGFuZCB0aGUgaG9z
dCdzIGhhcmR3YXJlIElPVExCLCB3aGljaCBjb3VsZCBzbG93IHRoaW5ncw0KPiA+Pj4gZG93bi4N
Cj4gPj4+DQo+ID4+PiBTaW5jZSB2ZmlvLXBjaSBkZXZpY2VzIGluIG5lc3RlZCBtb2RlIHJlbHkg
b24gdGhlIGhvc3QgU01NVXYzJ3MgbmVzdGVkDQo+ID4+PiB0cmFuc2xhdGlvbiAoUzErUzIpLCB0
aGVpciBnZXRfYWRkcmVzc19zcGFjZSgpIGNhbGxiYWNrIG11c3QgcmV0dXJuIHRoZQ0KPiA+Pj4g
c3lzdGVtIGFkZHJlc3Mgc3BhY2Ugc28gdGhhdCBWRklPIGNvcmUgY2FuIHNldHVwIGNvcnJlY3Qg
UzIgbWFwcGluZ3MNCj4gPj4+IGZvciBndWVzdCBSQU0uDQo+ID4+Pg0KPiA+Pj4gU28gaW4gc2hv
cnQ6DQo+ID4+PiAgLSB2ZmlvLXBjaSBkZXZpY2VzKHdpdGggaW9tbXVmZCBhcyBiYWNrZW5kKSBy
ZXR1cm4gdGhlIHN5c3RlbSBhZGRyZXNzDQo+ID4+PiAgICBzcGFjZS4NCj4gPj4+ICAtIGJyaWRn
ZXMgYW5kIHJvb3QgcG9ydHMgcmV0dXJuIHRoZSBJT01NVSBhZGRyZXNzIHNwYWNlLg0KPiA+Pj4N
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0Budmlk
aWEuY29tPg0KPiA+PiBPbmUgcXVlc3Rpb24gdGhhdCByZWFsbHkgYXBwbGllcyB0byBlYXJsaWVy
IHBhdGNoIGFuZCBhbiBldmVuIG1vcmUgdHJpdmlhbA0KPiA+PiBjb21tZW50IG9uIGEgY29tbWVu
dCB0aGFuIHRoZSBlYXJsaWVyIG9uZXMgOykNCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IEpvbmF0
aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPj4NCj4gPj4+IC0t
LQ0KPiA+Pj4gIGh3L2FybS9zbW11djMtYWNjZWwuYyAgICAgICAgICAgICAgIHwgNjgNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPj4+ICBody9wY2ktYnJpZGdlL3BjaV9leHBh
bmRlcl9icmlkZ2UuYyB8ICAxIC0NCj4gPj4+ICBpbmNsdWRlL2h3L3BjaS9wY2lfYnJpZGdlLmgg
ICAgICAgICB8ICAxICsNCj4gPj4+ICAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMt
YWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+Pj4gaW5kZXggNzlmMTcxM2JlNi4u
NDQ0MTBjZmIyYSAxMDA2NDQNCj4gPj4+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+
Pj4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4+PiAgc3RhdGljIEFkZHJlc3NTcGFj
ZSAqc21tdXYzX2FjY2VsX2ZpbmRfYWRkX2FzKFBDSUJ1cyAqYnVzLCB2b2lkDQo+ID4+ICpvcGFx
dWUsDQo+ID4+DQo+ID4+IEkgc2hvdWxkIGhhdmUgbm90aWNlZCB0aGlzIGluIHByZXZpb3VzIHBh
dGNoLi4uDQo+ID4+IFdoYXQgZG9lcyBhZGQgc3RhbmQgZm9yIGhlcmU/ICBUaGlzIG5hbWUgaXMg
bm90IHBhcnRpY3VsYXJseSBjbGVhciB0byBtZS4NCj4gPiBHb29kIHF1ZXN0aW9uIPCfmIouDQo+
ID4NCj4gPiBJIGJlbGlldmUgdGhlIG5hbWUgY29tZXMgZnJvbSB0aGUgc21tdS1jb21tb24uYyBp
bXBsZW1lbnRhdGlvbiBvZg0KPiA+IGdldF9hZGRyZXNzX3NwYWNlOg0KPiA+DQo+ID4gc3RhdGlj
IGNvbnN0IFBDSUlPTU1VT3BzIHNtbXVfb3BzID0gew0KPiA+ICAgICAuZ2V0X2FkZHJlc3Nfc3Bh
Y2UgPSBzbW11X2ZpbmRfYWRkX2FzLA0KPiA+IH07DQo+ID4gTG9va2luZyBhdCBpdCBhZ2Fpbiwg
dGhhdCB2ZXJzaW9uIGFsbG9jYXRlcyBhIG5ldyBNUiBhbmQgY3JlYXRlcyBhDQo+ID4gbmV3IGFk
ZHJlc3Mgc3BhY2UgcGVyIHNkZXYsIHNvIHBlcmhhcHMgImFkZCIgcmVmZXJyZWQgdG8gdGhlIGFk
ZHJlc3MNCj4gPiBzcGFjZSBjcmVhdGlvbi4NCj4gdGhpcyBzdGVtcyBmcm9tIHRoZSBvcmlnaW5h
bCB0ZXJtaW5vbG9neSB1c2VkIGluIGludGVsLWlvbW11LmMNCj4gKHZ0ZF9maW5kX2FkZF9hcykN
Cj4gDQo+IHRoZSBzbW11LWNvbW1vbiBjb2RlIGxvb2tzIGZvciBhIHJlZ2lzdGVyZWQgZGV2aWNl
IGNvcnJlc3BvbmRpbmcgdG8gQGJ1cw0KPiBhbmQgQGRldmZuICh0aGlzIGlzIHRoZSAnZmluZCcp
LiBJZiBpdCBleGlzdHMgaXQgcmV0dXJucyBpdCwgb3RoZXJ3aXNlDQo+IGl0IGFsbG9jYXRlcyBh
IGJ1cyBhbmQgU01NVURldmljZSBvYmplY3QgYWNjb3JkaW5nIHRvIHdoYXQgZXhpc3RzIGFuZA0K
PiBpbml0aWFsaXplcyB0aGUgQWRkcmVzc1NwYWNlICh0aGlzIGlzIHRoZSAnYWRkJykuDQoNCkFn
cmVlLg0KDQo+IA0KPiA+DQo+ID4gVGhpcyBjYWxsYmFjayBoZXJlIG9yaWdpbmFsbHkgZGlkIHNv
bWV0aGluZyBzaW1pbGFyIGJ1dCBubyBsb25nZXIgZG9lcy4NCj4gSSBkb24ndCBnZXQgd2h5IGl0
IGRvZXMgbm90IGRvIHNvbWV0aGluZyBzaW1pbGFyIGFueW1vcmU/DQoNCk9rLiBJdCBkb2VzIGFs
bCB0aGUgYWJvdmUgcmVsYXRlZCB0byB0aGUgImZpbmQiIGFuZCAiYWRkIiBkZXNjcmliZWQgYWJv
dmUuDQpCdXQgZm9yIHZmaW8tcGNpIGRldiB3aXRoIElPTU1VRkQgYmFja2VuZCwgaXQgbm93IHJl
dHVybnMgdGhlIGdsb2JhbA0KJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LiBQcmV2aW91c2x5IHdlIHdl
cmUgY3JlYXRpbmcgYSBzZXBhcmF0ZSBhZGRyZXNzDQpzcGFjZSBwb2ludGluZyB0byBzeXN0ZW0g
bWVtb3J5IGZvciBlYWNoIHN1Y2ggZGV2aWNlcy4gDQoNCldlIGNvdWxkIGFyZ3VlIHRoYXQgaW4g
Z2VuZXJhbCB3aGF0IHRoZSBmdW5jdGlvbiBkb2VzIGlzICJnZXQiIHRoZSBhcHByb3ByaWF0ZQ0K
YWRkcmVzcyBzcGFjZSBmb3IgdGhlIGRldmljZSBhbmQgY2FuIGp1c3QgY2FsbCBpdCBzaW1wbHks
DQpnZXRfZGV2X2FkZHJlc3Nfc3BhY2UoKSAuDQoNCj4gPiBTbywgSSB0aGluayBpdOKAmXMgYmV0
dGVyIHRvIGp1c3QgcmVuYW1lIGl0IHRvIHNtbXV2M19hY2NlbF9nZXRfYXMoKQ0KPiBXZWxsIEkg
d291bGQgcHJlZmVyIHdlIGtlZXAgdGhlIG9yaWdpbmFsIHRlcm1pbm9sb2d5IHRvIG1hdGNoIG90
aGVyDQo+IHZpb21tdSBjb2RlLiBFeGNlcHQgb2YgY291cnNlIGlmIEkgbWlzdW5kZXJzdG9vZCB0
aGUgZXhpc3RpbmcgY29kZS4NCg0KT2suIEkgd2lsbCBrZWVwIHRoZSBzYW1lIHRoZW4gd2l0aCBz
b21lIGNvbW1lbnQgdG8gZXhwbGFpbiB0aGF0ICJmaW5kIg0KYW5kICJhZGQiIHBhcnQuDQoNClRo
YW5rcywNClNoYW1lZXINCiANCg==

