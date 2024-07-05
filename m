Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A24CC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPb6c-0005Rn-IX; Fri, 05 Jul 2024 01:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6a-0005OT-Rt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:32 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6Z-0003g3-2n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720155812; x=1751691812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8hp9YS8jEEsaaQtV+h2ko9fpqQi3pY6lFFsOK57EHS4=;
 b=p3RdIs1Crs+bj1U4bS0Pl7nhk7PqaLSgTyGyg6fli07HkGo0j8HXL6jU
 eXPa4uFHUdDdpaSUWXDD2lAlxapfQOE6HvCo7t2IfpGQ1HQmrsa5NRAHx
 V3t5k3XyVGCE8oKP6ik3K6fZxHySqG3SBiqiVKlEwqbsiiKvuQyYGeowU
 hCIAW8SidmpSL+yE0kpAPje0OhaD1QSDvMg8X127UcQOjNIhJUQQbQpTb
 ZZE5NKpQENIHYYUw88oCIGBI5y1e8tWUasKCdMnpfXMRHV8DVXA40Vug/
 AHobaRgosiTcs/oa8eF0i9xwsW2wER0CXJM6ahg2uhOHqNZzyEMUVkpUx Q==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="15924033"
X-MGA-submission: =?us-ascii?q?MDFK+l94PiF81q8arAJRzBfErXYhlrAHhReiw2?=
 =?us-ascii?q?QoMg0LaEHyJoPxOLx5lBU0uJe7IPcE6P1+IAoHFJEZ8wviF9GxgzpvKd?=
 =?us-ascii?q?2uwBqUZZP25MrI+xFo23P2yJDZu60x7LlLBBV7t8gQlsuEq8yKWy83FC?=
 =?us-ascii?q?Q1sQ+wScoNAb42zPZ7jqKapw=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 07:03:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7/B4GHyd6Ae2kfdXDsc6KAHwgCV5v05g+FUMDvPYhcpfOJn94OJOZa9xgTicI1D01Lk150XSbbo+wRbX7fhttJEEwqNS+JVEL5xfJjWDQxXYuoPAF/nFeL1LB8oTMIfKxT01dyM7kwm8u57zCYRXoUpZnvemfQ2KvKRe9mg+WTn54Vb77ZqfsnuVhs5reshE2Ae+nKNaPcy79G+hadLxlW5yA1qwdDLihtR8qxd8kUf/YWA+tY1OkitJxSqD+W1Co5NWnn7bKDeEKapf/+O+UZ8TzM0nnv0E2HjVbXL1BsMHqVb36O5vgjI1V1U4QXiRGh539qIuHFdKXemiSaZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hp9YS8jEEsaaQtV+h2ko9fpqQi3pY6lFFsOK57EHS4=;
 b=DcLcxl8X78bvtlmv3wDi2OOJ0iM56tZ0Wq8vjrO1CUPSW5FGigPv5e0BUjex1jdZNs2HGZusdYjwnZkVOCgLsS7Ej8v0cv9YNZVBpEs3k8PiDfMatZJKPu932n+utFKzlcPa/q6ppfq63oIVgNL0cLWPdxbZeAzszh/c90hYnOqwdm/CXhWSE+t90DvFuduGLPFIyeEKV+vQDvkE5pfJaF9CGnXIpPdIVySiNWhyjPipk3c6Leum7QhEMyDriu8dvxFqqYI48wgnzwqh4GoWcRBSR+AxPsuLqRTGYFGFvxHEMyYbhf6qcdEIwOg8NCbSBG5WwUGQcqpeSj8bK4nYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hp9YS8jEEsaaQtV+h2ko9fpqQi3pY6lFFsOK57EHS4=;
 b=gx0BvnlcQP6rBSzbCCfXMu1DAJHIUojgPL9BEsy4zV1CtXSxVU6pmPOX1jA2nXpCkr9qg+miDlm6aiy3/+LUHP1K/cBu6AnxWJUSl56HjpP9KlApsi3PxMZjoLjzndWYoV82zJtPZtuqhX0Qx0NFqnK20zqQTC29z0zsxZKyBDAGLA0kVISLnt4jzUJhNQO4ZEIlLYElmd1R4f26khlCK2jCOOBvL871Nxj6Des8fIQsjH2r3Rzav4vRHHztpppQbUI4YXBJj57+pFhnQPcLsbjAS0S3HEnwWsnEoxp5Fxan0fAE1ay9ob4ZAfkjGedsIqL2BPCLK/NajLVzj5ClMw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6542.eurprd07.prod.outlook.com (2603:10a6:800:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 05:03:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 05:03:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH  v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHazpil+0mQLG18N0+TygrrlyLdGQ==
Date: Fri, 5 Jul 2024 05:03:17 +0000
Message-ID: <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6542:EE_
x-ms-office365-filtering-correlation-id: 731a34f8-adbe-4e59-0ad9-08dc9cafc853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTJSOU82bUI4UXJ2clpzTTB3bkxWaDZGaUlPZzJsdG0xNVN3SzFXYSsvQUdN?=
 =?utf-8?B?NDYvZDA2TGYyRHpvYTlaWG5oai9nKzMwTnZIR25adXRUeC9QRTNjU2txSk90?=
 =?utf-8?B?dDB2RFgwWW8vY0lKNDJiZ240LytqelhDeDNmdGhxdFdTQmZJTko4Q1ZlbDhH?=
 =?utf-8?B?L3VQME90Rk55Y1RHVlRkdVZUN1FuR29ScUI4b3hzTjNFQ1hvSWoyRzRQcTBm?=
 =?utf-8?B?L0JTUWwwK1Y5SEZaZmF1c3A2SnF5MHBuTldETzQ1R3pvNWdZT3g3Um00NSti?=
 =?utf-8?B?M09hQ0JIOGhYaVhMb3ZLY1REdDlyTWhkdmRJZlBTcWVndCtDb2xvNEVvWlNP?=
 =?utf-8?B?Q1V5dG9qU3Fya3NkWmRNL0dOSm9ZbGVHUEhHdnRFZjFuLzJZYXVLenV0YmJh?=
 =?utf-8?B?R0Y2VlUvV3VhMTJvaFRBYlZIb3l6cXJ5S1A1dFV2Qys0K2tpelBpUExmV2hB?=
 =?utf-8?B?L0tzZVBpbCtsRThxS0hsQ0xXNjdVOEdBcnMxTk5WNXhIYUw2V3d2RWh3MlJO?=
 =?utf-8?B?bWFrdlpKaFBGTjQ4SDNSVXBSdFZtY2ROY1BuTjMvUzNYMWlFc2ErSlNRWnZV?=
 =?utf-8?B?VUdhYm1PQWJJSDB3VzI5S25ybnVvcXhDRWc5NzFJcXN0cFBUVEdLSXUxNTBJ?=
 =?utf-8?B?UmFHSFdLYUtlUlFpcGZhdXhSR040VjdyR0tsT2V6c3J3RGdWOHVob1A2cDVo?=
 =?utf-8?B?S3JEbS9yTmJtQXhtZVlrbTZSVVF3OHVCK0EzL01HbVY4MVZwSGo5RXBGUXky?=
 =?utf-8?B?L2xYRmhhUlVwY2dmWkpNRFNvcmJ2eEMydHFPWmJiME0vSEdMc1dzNjhnL0x1?=
 =?utf-8?B?VFJuN3NSMThHeWo4Sm9qOTZDRFpoZSszU2pSSDV2dzNIQ28yaDZ5alkxTHR3?=
 =?utf-8?B?M01QcFBPOUtYaGVMaWhLVEpNMnZqaG9Pcm1QNzJ2dytraUNjT2hncUVxMUlh?=
 =?utf-8?B?U2xwK0NZYUFQUTZaYkJSWk5XTlFKN29CZVNNTWdLbFRTckoxL0FONGFxbXkx?=
 =?utf-8?B?YU9VMTVXcE9xdUJjSHVOYys2YTRmS0VMNVIyRkU5Uk0vWUVrZkVlbG9sZjk3?=
 =?utf-8?B?WGVvSTBhYStrWmhrRGNzNExmTXNwdmRpazNIb2doWm52a0V0bzl3Z3ZvYzJD?=
 =?utf-8?B?VTk5WUV1QXJyTnJZdHlEQURwSXFBdUFuOVBGaGVOZHZYcHM4cGtXckNHNU41?=
 =?utf-8?B?SktXbllaU2tSUGNISk5TQ2V1MmVLM0NxV1lUdDIremxVZm5uVkxUaW1Sdnhn?=
 =?utf-8?B?YjY2MUphK3EwZkdOenhYQys0NUxXRFdwNXYxaVEvY0cwVnJ4T3BlbVc0dHFE?=
 =?utf-8?B?OTBrcEdTMitNSnZvdDBSQ3U1V0RkNTFtdzF6Z3g5UFIxT29MODRMRzZ3YUlw?=
 =?utf-8?B?VnlaTVcwU1FXVHpyVWhwVmJDSUYwcG9BaHpNSEZUNWFneE0rb2N6WkdLNU5n?=
 =?utf-8?B?ZTFDRUlOa2w5QS9zcUZqaldiWXZ1Q0VOWlE5N3A0UUc1RVM2SDFTT2V4bHo5?=
 =?utf-8?B?T2tUeUJvczZSM1pnOW1SQ0JRNnY4Q1BGUGhqLytISEM1cmNQR1YrQ05ma0U5?=
 =?utf-8?B?NzBMNTVwczZ3TlhOSngxdHBKOU80UGd5MHcwUXhZeUJJZkwrNHRqcmxQeVQw?=
 =?utf-8?B?SjBXZE0vTnhTWjZOQjE2TWRFNjV2YnJqZFU0SXlIQ3QxMkVKUVQzNXdPWXpF?=
 =?utf-8?B?L0crV1dHdll4ZlFKdDcxTlBwYXhlLzZFRGxwc01PRFVLZzJ3Q1FwMTBvb24x?=
 =?utf-8?B?QVMyRTNGRmlRaDR6eXBUQ3dhWFlxMTNQTU5iUzJ5b0NrNWlNMXFnT3pTOC9W?=
 =?utf-8?B?R2d4QUh4UWQ0YmZETk1MWlh2dGRvRXcvUG5Ydy95MmlyZE9CeUh5RkRBNVE2?=
 =?utf-8?B?bStic1UvQjl2Wkd1czRHSXVtZ3dZb1Z1R1ptNHZ3bVVablE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2x2cVdxK1dwUWxKS1FTTkg2S0xaYWZZOGZlSE1kdEVqYnpFblliTWZaODRl?=
 =?utf-8?B?eEUrWTcyWUt1NzZhSEhuSDdtSkVIMTBDRFNiUVFxMkFFeFBKTTJ3aDVMdDZE?=
 =?utf-8?B?UmZNM0NmNFpxWmNKaG9oVHRNNjM3UGRxZzFwSysrTW1ySkV4Qzc5WUE5bGRH?=
 =?utf-8?B?QzVhTzc2OElpTnd0bHY3dXdWQTd3c3RuSlQ5aVBIeWFKMkRKQmFhTVFKK2dS?=
 =?utf-8?B?TlVqVDhyOW5LZ1pTUUg3THl2aUxIVDUwQXoyWjVCWHovR3NqWFJlYnNjWTNC?=
 =?utf-8?B?TXZCcHE1R3B1c1hGZTg4anJxc0U5ZWYzbE9XMHk3ejNpd25SUzMyUkZXcTVS?=
 =?utf-8?B?WEVNZjErTUdpMGFySHJhZU8vS3Z4SHp5d3UybWJlYWlhS1orM0ZKbTBpRkJ6?=
 =?utf-8?B?RzZBaFpEMFFINS8rbUVOeFVoSUpiK1pIWGpjdzdUSTIxT3NLZWRGQzl3UmhF?=
 =?utf-8?B?TU1xY0lrWFY5N1Nkd09kUWJIOU1NMnVINWE1cE50K010WVJJdmlEQ1ZhUzdW?=
 =?utf-8?B?Mmx0cGFVNXdLVDJhUmZ1QkVPYXlGVEtkclZkN3NMTndWYVdvbmVZWnpKenBU?=
 =?utf-8?B?VWF3dFQ4ci83c1UxZXpsME9kejhlT3QweHdlRVVMSlRHTXVEOGpRSkhGRjRD?=
 =?utf-8?B?ZWJFcXg5MWJqdXdjU0hjQ0ZLSlhIdjVuS3dUVjVoK3poRlF3RW93d0pZUnA2?=
 =?utf-8?B?dUFqR2JOc040WVROMUFtK1BpZVpJMnhIRVpyREMvbkc5djI1UWs0a2FqMEZz?=
 =?utf-8?B?elY2enRoSVEzeFFnbmovb08xejlvcUJ6N2gzN3plYmtVMXBwWjFZdEY0U1Qw?=
 =?utf-8?B?Ry9BQ1hPNWdlQnkzSGh0RVJVRDBIeG9MUFZjU0Q2NCtsazlXdDUraUs2Zjhv?=
 =?utf-8?B?UmhjOHFjZkN4eCtFcWUzWGFrajcvdkJwcGR1MitaMWRtcDhRVFQ2c1lyN3cr?=
 =?utf-8?B?NmNGenphS1VwQy9pdGM0VllzcW4vLzhsUERDcnVrWlR0OWYvNXFaK21iYXFk?=
 =?utf-8?B?R1htSE9aaVA3dkxKalRWU3g5OUlmMmJIVTU1QXk4eGNQZmZlSGc2OUxxL201?=
 =?utf-8?B?dWE3ZHV4TW5oaEdKSzA5aTNTL3VObkNlSGduVnJxNEFNOHladmo4K2tpeXJp?=
 =?utf-8?B?UzlOVDllSXJsd1dtNi9nM0ZMbW9HODJMeWl2bnFiVWNWbHdKT1V2aHU2ZStx?=
 =?utf-8?B?M01EN1p0RWxEbTRBMU1nc3k4RmVNcDdwL0xtZlNJZ2Rnczh2UmVlRDMvZnFQ?=
 =?utf-8?B?MjZKVVhxYWZFNTFRYnE3dWk0THc2THMvT2FWMUxHV1JqM29xZmVNUGVHV3Zz?=
 =?utf-8?B?ejQzM0xPSmUwMTlnNk9EWHZVYUJGUkhyY2tMMlpObkxtVHJIQ3FYTEVIV1Fu?=
 =?utf-8?B?WVIycG1MYzlERDg4R3B0TGpTVDN6NW9mSEhrVXpYdE9MY1NYM1FnYjFxdkpH?=
 =?utf-8?B?ZWk2VlJsS2VNQXRhMU9pMjJXQVc5OEl5NEhZWEl2NmxzY3RnbUhGalBEUVVK?=
 =?utf-8?B?NUxJQTVETGxvazIyZW92VVIvWEFrc1JIWmE0VnhQVGpTL2V2TlBnVHBuQUxT?=
 =?utf-8?B?eGtMczZsc2RPOGNnM0prTUVPaTZHRGVLVzdXZjdwdWUvaDB2aS9GeEhGRFJM?=
 =?utf-8?B?V3k4S2lkb3pNTTFiYUtUdWR3Q1RhWEFDK1FuRktKZTNrczFJd2duQU5tbzVG?=
 =?utf-8?B?ZUl1eHRiRi9oOXdQdDNIWk1iNGQrd1IrZy9ZMWthdjR3UTd0ckU4VDZyaVNm?=
 =?utf-8?B?UjB1cXg5QlZKSWxqVStTODhLWURwTEc4VStvTVQ3eWJ2dzJvdkVKMEg3MDk4?=
 =?utf-8?B?LzFpTS9ncEYwTk55V09qVlZyVmdCZFhCeGM3Y2oyeGx4ejlnZkQrZ0tYcjBE?=
 =?utf-8?B?cU5zb2R4WUxsbjl2cnIyMUM0VTg0Sms0S3dTMk83UmViR3V2VGRxMFRwS0s4?=
 =?utf-8?B?TktCU1BrMXZQVlhCY0Q5U2FFWUJ4dUJZU081R0M3ckdkTEcydFZzNTFkaUNI?=
 =?utf-8?B?TGFldzd5R2JsTFU2eHA5RmluZjR6KzFaY29PeStKUGRNekpmMHNCM0JNa2RO?=
 =?utf-8?B?SDhwUzlFRmRoSFk5UjNKOU5QaE01dW92K2FMbENNMUNEdHRJN2NqeUpxdTlj?=
 =?utf-8?B?bEhndFBMU2d4ZFBYZWdkanI3ZHM4TGJ5RFJwV0I0R0M2RHJML2RoSFBodVRq?=
 =?utf-8?Q?O27GE5FZrpSXRIqMazR4Ack=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9C547FE506694A97C604DD9C6748C0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731a34f8-adbe-4e59-0ad9-08dc9cafc853
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:03:17.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nb0D3kvg5GUxACaqOhKUEkN5EJIFXoND8P8mqC41JpiHb7fzyFw7HCndUKb8zJoWFgo8FMRTmn/iyAR52gTURNzZ0aM86QaqLUMvx9w/+MMCxxlDMPgAHJSEj9oEvUju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6542
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZURElPVExCUGFnZUludkluZm8ubWFzayBtaWdodCBub3QgZml0IGluIGFuIHVp
bnQ4X3QuDQpNb3Jlb3ZlciwgdGhpcyBmaWVsZCBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25z
IHdpdGggNjQtYml0IGFkZHJlc3Nlcy4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGNiYzQw
MzAwMzEuLjVmY2JlMjc0NGYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTQzNiw3ICs0
MzYsNyBAQCBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQogICAgIHVpbnQxNl90IGRvbWFp
bl9pZDsNCiAgICAgdWludDMyX3QgcGFzaWQ7DQogICAgIHVpbnQ2NF90IGFkZHI7DQotICAgIHVp
bnQ4X3QgbWFzazsNCisgICAgdWludDY0X3QgbWFzazsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IFZU
RElPVExCUGFnZUludkluZm8gVlRESU9UTEJQYWdlSW52SW5mbzsNCiANCi0tIA0KMi40NS4yDQo=

