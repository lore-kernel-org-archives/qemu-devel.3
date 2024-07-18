Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5556C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUN23-00036H-2M; Thu, 18 Jul 2024 05:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUN1z-00030W-Lv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:02:31 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUN1w-0003yP-PZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721293350; x=1752829350;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zNS9MCYhGK3Sq9JTaVY2H+qBtrYaykS3gy1u0+E4tGE=;
 b=oLJsUDWTl3j8hllcmTKGslPyDumDC4tRbuxIEiJozszqWA5Qog+wO0AP
 MlibeOJ4WMRlNe9mbnaj2CGZhp2D+R1/4qD3ebtM//2jRv0d7CntrDreg
 vmAidY59hl/Ji1XaP0pxqgHcYeoG+43V9HDwIapc9Q0IrG+BKp1pxa5ru
 6seONBNTZY0f24NcHblfbJfseKLIYdKDBoiAY9CGeN3I+IPMnryezk5XA
 cEyebQ+jN0f8a439YyrHzOjtvFspbIUbnml6sMtAMu9qAjaXYcDRx6g+E
 acvzhTqGHPoTBi7wgDovQXIsBYHpuIVoTp7kLk3zd82KQG2vEHFy1qtFt w==;
X-IronPort-AV: E=Sophos;i="6.09,217,1716242400"; d="scan'208";a="16723042"
X-MGA-submission: =?us-ascii?q?MDEQ14iBW/4db2mtSWCeN1bggDMhxcgx8+F97C?=
 =?us-ascii?q?GpIJweO8WLSt87ix4KNHxRq1pmGJNiizkA+n+NJ6SOCRZZQrvwEMBpQp?=
 =?us-ascii?q?KkP8zi6nRh01PHB8qNV7i0rpvKN3e9oeGHQTUObeZhAZIzyimHceG4cb?=
 =?us-ascii?q?EFgec2sPMwgEfP8fLnSXx7BQ=3D=3D?=
Received: from mail-am6eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.107])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 11:02:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPTAKQKYD9+58YQUVwkc3KmHBgbV/FtqSY3ffW4VRyRUsOkk4ElbKkrzetYsXU9NJDuGk5YpdM8HNwn+FmqHvJYdd7GpDVR0T4AgtNWFjl2Vr2S+EynDwUoNZQhH+SNEor6wuLJJb/Il6zxYgS45+0KUNhh/lLHn0ICTd2CHAZ+oaxI8P+N7j5z9NB6Hx5PEg6XP8uo3rqKeGmjdkew6RqHmFkB+fXbYM2GZIaGV9WjtCT/6mUQCsZm24GGSsAuqv8S7A+dQrc9rgfJ5OmxXB1kBkuXIzr/7EXz+639uVRRxz5Iwi5dkM3YGDodFfTl4ROmtFD4yfDmiILJDA2cPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNS9MCYhGK3Sq9JTaVY2H+qBtrYaykS3gy1u0+E4tGE=;
 b=ClM5BW8qYEpc3/pLP1Scc5lIj+14rkJ5WKrdGatypGeEZkLysNWUXJRQIJPV/CLS6+GOArc7m/v5tnFSRqKNUa36XwqRsIuEtFSiftOAfqBHqCX90n+54cs07mOmj2n4hjSs/0y8Pl2w/JJq177rWwjn/TVv/a57MOAHaR2/lrY+e6C/D+DfX2YMT1C0G7+Skqzm53MTBKXoTDaoZ+vIKFNIg6LbzyGfYpVhdgOL+T5KErPa9jQwVVgm3DG1pJSsjSEplGENZX/IhGIdsAqsarBR2llWlejeeibGOVKm7/JK3jxJjC6PfEAEr6yuCej2rtjuSUkIQngum89O1dn35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNS9MCYhGK3Sq9JTaVY2H+qBtrYaykS3gy1u0+E4tGE=;
 b=CqMRDIfKBFABTAGmO/HgNCMV4ZLOT8KF/MB1EZZY54ZuEkYnouWwJFWv4u+wGeNYGFaHR6mQAxzwkJ2pgbIiv89IBr8aW7sWBfc+8HC7JQlQu0DflDGtDSxamqdorr3mpLyfV+hiaPdziV6ZfPDQQ5NQiUtmLvWodNTI4W1nnh3frsqq1Vk6qLWi6YcYoWs+2HXmpucH1mok3Nb8IDia/4gzXRC9ujiTbkUAicMWaPdOvM1eOZfn1HVM4XsN18+5J7aqyUW5C+o0Pi7m2g3xBwphORlXew76F9ywLFHlRLaDn8aIffnLvSUHMFXQmkIEA4nLn/c0AeWAkmXz0pgPqA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS1PR07MB8502.eurprd07.prod.outlook.com (2603:10a6:20b:4dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Thu, 18 Jul
 2024 09:02:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 09:02:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2Os6jI53vxLunUO9e0sZTiatjrH8MI6A
Date: Thu, 18 Jul 2024 09:02:22 +0000
Message-ID: <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS1PR07MB8502:EE_
x-ms-office365-filtering-correlation-id: ca772ccf-9ee8-4ad8-9d78-08dca70855c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UHNMb003OHU5VUdKWXBiZTY4NGRnRHRlSG8xeTVGOVo4REt3Q0FLMFJMUmt2?=
 =?utf-8?B?OVRJS1g1NjRqd0dneXhyQ25NSEFyb3Q4ZkZraWVZbnU3NVpFWFNSR3gvVVFV?=
 =?utf-8?B?cDQ2ZlhrbDZVbVBjSis2amtoNVd4WVo5QU1BVVovazFpMXFCSGZjQ1YyakFZ?=
 =?utf-8?B?UWNEaVhlcW9RMHdUd2s5T3AwbVVvcWdhV1p3SCtOZUkycXBibVFvNUJBK2JE?=
 =?utf-8?B?b09Nb2xCMnBXTjdRMGZyODhCYm1RTndueFpjcTF4Qnp2T2diSHpoZ09oSjgx?=
 =?utf-8?B?eE9TQzJJUXZnTlFaOGwyK044ZVV6Ym1YYUpYNk5uUG84UnUzTnVrU1ZYcWND?=
 =?utf-8?B?bUdiNHZzR3dpcVV0ZUZ0eHIraHF5cTlzQlJ5Zi9lVGQxNzQzb1JnTnRsdU1O?=
 =?utf-8?B?T0RIVENJZHpRMTI1bDhpMnNSQjY1MTNBd2tUaS9LQi94MEFReXI3VFVnWUdM?=
 =?utf-8?B?a09Xc1kwVWhJVnczcUxsS2ZleUdXKzRUaFVmRWU1cDQwNFFUZHRva2xSaldm?=
 =?utf-8?B?ZjJRbXpLbC9kKzQ3YjkxNkRTWVpvWGw2YlJHY1NFSDIzaG01VVdpNlFGV2Nw?=
 =?utf-8?B?UXZXcy9ybzNmRmNraDNWaC9MclBnZC9GSXFHd0taLysvQ1NjelZzWkhuZk44?=
 =?utf-8?B?eGtxQ3c2VW5HOEtxZkZkVk8vOXlzVlltR0FDNUQwTzNqOEpIVStMcTZwUklN?=
 =?utf-8?B?YlA3VXRQWGhROXJCNVR5cWJucndJUDRxaS9INWV0QVdwOGpFRTB4ODN5ZHov?=
 =?utf-8?B?cERrZE9VV1pnZXpjNVlBcUpXN3RsWFlpVjdST1lFQzBacXc0empYY1owTXY0?=
 =?utf-8?B?RHNjc2Qvb0llMzBpUGRqL3ZTd0k0dFBTVFJQMXFyWDR3ZzJvTy9nelFTVUZx?=
 =?utf-8?B?L1VKTGpLTld4WEVGeHZObWNvUzhuaTZUY0JJYitUalZQMnZPUnIwbVZRNDhr?=
 =?utf-8?B?eU90QktSalFFVXF1UCt3ejFBRmtyUC9PSU5GMklyZFlmMDRMMjViV2lMNktW?=
 =?utf-8?B?aHV4ZVd5a2ZzYi81aWhnWFF3TUhvcTkxQWdzOWxtZU1GYjQ3Q0VjR0JNei9v?=
 =?utf-8?B?aG9RVTFwZ3ExU25vamlUTi9mbXNxSGNDUEtwM0VyTjNBU2hyZlpyS2h5Vnht?=
 =?utf-8?B?UUVoUzRLTHM4UUtTL2gzaWx5emJpTGxndUQzQ0RXMEloVGRWMjc3U0pEN1l1?=
 =?utf-8?B?b0thS05QRURJcnBlMWFaN3RPVGZqOW1hbjVIU2NVQ05yQUVFTmZEOXNzN2pJ?=
 =?utf-8?B?ZlQ1Z2h0RUd3Zmk3djY2WWNNS3h6eVNSbW9rWTNFZmFab3lmclB4VEZSdjFB?=
 =?utf-8?B?dmlEajVHWXU2UEQwd1BHd1g4YjV0RGptRFp0UWpkZWwwT0p4TmdzT2hHMDli?=
 =?utf-8?B?WUdrOFlYMmMyZXpWSGNaQ0VnZ0JVRE1DMjhCQUtsb09BbUJ3Y0w4L0RrdW5J?=
 =?utf-8?B?ZStEbE9OVWt1L0s1aHYvaUJhUlRibEVKSThqQjl3NFQwbUtWbFhZaVVwRVZk?=
 =?utf-8?B?bzJsRlJ4NHhvYkt5NjRVZWE0S216NzhJVStqOW5XMGZQYTVWNmNjV3A5aGdj?=
 =?utf-8?B?eWlzVFlyMndTclMraU5oS080c3lHTHE3MjBDbXhxMWRjTmV0djJoOEFsd3FY?=
 =?utf-8?B?VkVVdVVxWnNtWHpEZGZMdi85bXFRWjQzamZtRWFOdDBoUlJsUjdaeGZuRzZv?=
 =?utf-8?B?NVh2L1dGMnpkRUZRRHBDNkM2MDB0L0lZaVNDWDZ5bjhtRUUxZTJKYS8yN1Jy?=
 =?utf-8?B?ZFJZVXlodDhSK1RpK0hSeHc1Vkk4YmJuayswdmt1eEhjMk44eGFtVGZjZTZr?=
 =?utf-8?B?cXhsSlFjNENjSVQ2dHhnTDZFNEk2MWluRDhvaDU4MjU3eGdlZXpaVnNvYW1T?=
 =?utf-8?B?QzVkNkxjZEhYaklDS1Y1MXQwc00vM2xyMEx2RnZoL2xCRnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmQzWloxN21XajJvczJVWjh3SW5vazlJVFRYZTV6MFRvWHlwbzU5R3hsMjEw?=
 =?utf-8?B?WFpJYXltc2xJS2NGUXduLytpREtNVVZkNWNMaENpbEZCMDBXMVhaMko1aXUr?=
 =?utf-8?B?RjZ3TmJHS1ZtYXVrQTVwTXFMMkFQR0pLZjBXTWFmZXZ5NDVXUkZTS1lTakRB?=
 =?utf-8?B?R3hMYXYycFJtblN6SWRZR3c3cWUvaTFCMG1ZcUFBM1QyemRCUU9uWC8zMys4?=
 =?utf-8?B?NzVPZHZxSHpmT1l1Umd2b1dDSjJtUW9MODkvQWxjN2o5and3SmlEbElmeUtF?=
 =?utf-8?B?MWhJMW5ueHdMMmU2MmpseHhxWnZRQnhpTCt6KzQyT1cydXY3V3VrQnYrNGli?=
 =?utf-8?B?VzRpMUI2RklXU2xJWUV1MmoxMDRrdE43TWJwOTVDK0hFU2k4LzZ1MVNoTlpV?=
 =?utf-8?B?Ny9DeVRXZUtxek11dWVqTFUyb0VFVUZMVVdCYmJwemVTY0ZIbEZqMHZVZms5?=
 =?utf-8?B?YnpnZDRWTmE2Vnd0WitBOTdGRGxmN1h0TDQweXQ3dnFDOFVqNEFxK1FXVjJJ?=
 =?utf-8?B?K3NGYmo0MXBqQTZLb1I5KzQzcEVpYlFQZFZudUk3clFnRWhocG5lTWcrTEpt?=
 =?utf-8?B?ZEd6cDVMd0NOWE9BZVozalF5U1dnRnBSTk9WZWU3SklvWkFxN3BlWmdsM1JH?=
 =?utf-8?B?WUNEV0pGNHpYbTN1NEdDRnRPek1CYndMZVZPaXdxZTdJcnhLQzJZRFRMOFZJ?=
 =?utf-8?B?S3R2MDFFQllxVzZySE51YU5HRlZqTXEzSTExUnFhYzI1ZElLbHhGWHk5Z0kx?=
 =?utf-8?B?T1hjb0Q1T0o0OGhiZmdZNEdMcmlxdkc0bDdJVGlEZlM5akEvdGYxanFmcDhu?=
 =?utf-8?B?eE45ckVieW5oZ090RWIzL2hQNEhURnJaQTljNzFXc0pBdjd3N2xLak9ETlpN?=
 =?utf-8?B?NlZBNFRFa2Ryczl5WUZBbHBSZjRORWM1NWhUdkRGNzFUYnRjZ2JKUGJSWk9T?=
 =?utf-8?B?b3JaeUl4UUROWkZ6d3pjVTlSZFA3VXJrUlR3MEVJOHZpdStDcHZuTHU3bzNV?=
 =?utf-8?B?VWtUMFZ3QTVGenZic3Fld0RVa01NRmNWc0tvWC9iM1hrdWV4ZzZ6TStPQXNi?=
 =?utf-8?B?OXFYOEJML3RBcW1CTi8zWnpvV3NKYmVtMkUxQU1UbWg3RjU5dVIyQnJLQXJw?=
 =?utf-8?B?L3ZPRmZVZFN1QzY4dWpkSU9RcXJLRmo4N05SbEFiSVkxcElZZERZWXNoNjZU?=
 =?utf-8?B?MEpBMmdQYVJTU1p1MGJWd0htRGZCTFVKSE0xeDVIckVBUnhSVWd6M2NIMFlo?=
 =?utf-8?B?Vjd6T0xkWi9vU2dzV3kvbEpSTzM1YnJTOGtWcmhja1lRZy9NdUgyN1F4VGtX?=
 =?utf-8?B?c3YwY3dmQ0d6QUN5NldzeGxLZ2F4dmUwcnlnWXFNZGdBN2tJam0rNjF5RFN5?=
 =?utf-8?B?ZFJTYzB5WW1KOUtsV21PMzR4Zk04MU4rb0lYV3Rrb2pldTZqYVVrWjJYZ3M5?=
 =?utf-8?B?cmk5VkhIek11enEyRDAwWUxtaG9CTkprOEx2aFpQSm5RMHpsY1NJakk4ZVVR?=
 =?utf-8?B?c2ZqMWhLMzNUR2xZWE04V1RoUTdoUCtqOXNaQXA5ZVlBUU9SMXZlWk9IY2JK?=
 =?utf-8?B?eTBLd2lZUjRDOEZMQ2IwdGloU3hoNXo1TmpRb2lzK3VKOUV0TUVidjRLb3Js?=
 =?utf-8?B?dTNmR09oUERMd1FRN1NLcWNsbHlnTHZ4a2FtYVRZNGlnd2RhSExZWTFRdWhP?=
 =?utf-8?B?Q2VqK2xlVHpab0wvcU1GVEdYakd6bzdJekZzTFA3K1MybmZxUWlDYmoyVjF1?=
 =?utf-8?B?UXVzMWNrV0F3bDNGMzk2L3MyOVdtUWdzZjBWUVROMTVHWHBGc1NNUmxSYmNx?=
 =?utf-8?B?OWRydERXZStwYjdqQThoY0pMTXdQbHBJdE5Xb2dudGs5Y0h2Z25sRGhMV1lr?=
 =?utf-8?B?eHBYYjFRbzk4Snp5ODdjaWtPYlplUGxjNHk4ZnVJb3JPUmloQ3MrN1UyMmsr?=
 =?utf-8?B?VWFCM2FIak94WFNmc3h2MzlRaURiNkExc1NXd09peGppRWprMWo2eWNIZFQx?=
 =?utf-8?B?dkFMOFYzVm5WR0FyMzRiRUFlU2VrWXduL3c2L3lpQyt0L2RqNVRNRkxvTVVw?=
 =?utf-8?B?NFFISURNY29lRDBTcTYzSmxqby82WG1pUzdpVHgrVGJFTGFUNGFVZjB4MUli?=
 =?utf-8?B?T0FlUkZieXltWU5Scm9wZWxTYTFXSmlVbUVKc3VmWGFvVkhaT0dtd25tSWZZ?=
 =?utf-8?Q?d+539KS7zlzmVXf4LXOVhUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0C9BC707510DB428CE00F32E5D3FBC7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca772ccf-9ee8-4ad8-9d78-08dca70855c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:02:22.0143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4M36RBHhCKY5ISPIPf2E8RKyXMdm8AaiTJH7wqG8cJn8SAXM2uOt5als0dOHxPeXbzqB1WEE5WRjXq+2k5PiAgA7cXbzA/GUwyLby9fQs9lUcCw1GZSVCR6hXu3NOItl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8502
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

DQoNCk9uIDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFkZCBhbiBuZXcgZWxlbWVudCBzY2FsYWJs
ZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrIHNjYWxhYmxlDQo+IG1vZGVybiBtb2Rl
LCB0aGlzIGVsZW1lbnQgd2lsbCBiZSBleHBvc2VkIGFzIGFuIGludGVsX2lvbW11IHByb3BlcnR5
DQo+IGZpbmFsbHkuDQo+DQo+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQg
dXNlZCBmb3IgY2FwL2VjYXAgaW5pdGlhbGl6YXRpb24sDQo+IGNvbXBhdGliaWxpdHkgY2hlY2sg
YW5kIGJsb2NrIGhvc3QgZGV2aWNlIHBhc3N0aHJvdWdoIHVudGlsIG5lc3RpbmcNCj4gaXMgc3Vw
cG9ydGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4gLS0tDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysNCj4g
ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMSArDQo+ICAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gaW5kZXggYzBjYTdiMzcyZi4uNGUwMzMxY2Fi
YSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBAQCAtMTk1LDYgKzE5NSw3IEBADQo+
ICAgI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQo+ICAg
I2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQo+ICAgI2Rl
ZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDYpDQo+ICsjZGVmaW5l
IFZURF9FQ0FQX0ZMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4NCj4gICAvKiBDQVBf
UkVHICovDQo+ICAgLyogKG9mZnNldCA+PiA0KSA8PCAyNCAqLw0KPiBAQCAtMjExLDYgKzIxMiw3
IEBADQo+ICAgI2RlZmluZSBWVERfQ0FQX1NMTFBTICAgICAgICAgICAgICAgKCgxVUxMIDw8IDM0
KSB8ICgxVUxMIDw8IDM1KSkNCj4gICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fV1JJVEUgICAgICAg
ICAoMVVMTCA8PCA1NCkNCj4gICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVBRCAgICAgICAgICAo
MVVMTCA8PCA1NSkNCj4gKyNkZWZpbmUgVlREX0NBUF9GUzFHUCAgICAgICAgICAgICAgICgxVUxM
IDw8IDU2KQ0KPiAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAgICAgICAgICAgIChWVERfQ0FQ
X0RSQUlOX1JFQUQgfCBWVERfQ0FQX0RSQUlOX1dSSVRFKQ0KPiAgICNkZWZpbmUgVlREX0NBUF9D
TSAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQo+ICAgI2RlZmluZSBWVERfUEFTSURfSURf
U0hJRlQgICAgICAgICAgMjANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gaW5kZXggMWViMDVjMjlm
Yy4uNzg4ZWQ0MjQ3NyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gQEAgLTI2Miw2ICsy
NjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4NCj4gICAgICAgYm9vbCBjYWNoaW5n
X21vZGU7ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPiAgICAg
ICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9k
ZSBzdXBwb3J0ZWQ/ICovDQo+ICsgICAgYm9vbCBzY2FsYWJsZV9tb2Rlcm47ICAgICAgICAgICAv
KiBSTyAtIGlzIG1vZGVybiBTTSBzdXBwb3J0ZWQ/ICovDQo+ICAgICAgIGJvb2wgc25vb3BfY29u
dHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBTTlAgZmlsZWQgc3VwcG9ydGVkPyAqLw0KPg0K
PiAgICAgICBkbWFfYWRkcl90IHJvb3Q7ICAgICAgICAgICAgICAgIC8qIEN1cnJlbnQgcm9vdCB0
YWJsZSBwb2ludGVyICovDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggMWNmZjhiMDBhZS4uNDBjYmQ0YTBmNCAxMDA2
NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiBAQCAtNzU1LDE2ICs3NTUsMjAgQEAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9p
c19sZXZlbF9zdXBwb3J0ZWQoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MzJfdCBsZXZlbCkNCj4g
ICB9DQo+DQo+ICAgLyogUmV0dXJuIHRydWUgaWYgY2hlY2sgcGFzc2VkLCBvdGhlcndpc2UgZmFs
c2UgKi8NCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0
YXRlICp4ODZfaW9tbXUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VlREUEFTSURFbnRyeSAqcGUpDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BlX3R5cGVfY2hl
Y2soSW50ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJREVudHJ5ICpwZSkNCj4gICB7DQpXaGF0IGFi
b3V0IHVzaW5nIHRoZSBjYXAvZWNhcCByZWdpc3RlcnMgdG8ga25vdyBpZiB0aGUgdHJhbnNsYXRp
b24gdHlwZXMgDQphcmUgc3VwcG9ydGVkIG9yIG5vdC4NCk90aGVyd2lzZSwgd2UgY291bGQgYWRk
IGEgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBleHBlY3QgDQpzLT5zY2FsYWJsZV9tb2Rlcm4g
dG8gZ2l2ZSB1cyBlbm91Z2ggaW5mb3JtYXRpb24uDQo+ICsgICAgWDg2SU9NTVVTdGF0ZSAqeDg2
X2lvbW11ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4gKw0KPiAgICAgICBzd2l0Y2ggKFZURF9Q
RV9HRVRfVFlQRShwZSkpIHsNCj4gKyAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9GTFQ6DQo+
ICsgICAgICAgIHJldHVybiBzLT5zY2FsYWJsZV9tb2Rlcm47DQo+ICAgICAgIGNhc2UgVlREX1NN
X1BBU0lEX0VOVFJZX1NMVDoNCj4gLSAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgICAgIHJl
dHVybiAhcy0+c2NhbGFibGVfbW9kZXJuOw0KPiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X05FU1RFRDoNCj4gKyAgICAgICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFibGUgdHlw
ZSB5ZXQgKi8NCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICBjYXNlIFZURF9TTV9Q
QVNJRF9FTlRSWV9QVDoNCj4gICAgICAgICAgIHJldHVybiB4ODZfaW9tbXUtPnB0X3N1cHBvcnRl
ZDsNCj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9GTFQ6DQo+IC0gICAgY2FzZSBWVERf
U01fUEFTSURfRU5UUllfTkVTVEVEOg0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgLyog
VW5rbm93biB0eXBlICovDQo+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IEBAIC04MTMsNyAr
ODE3LDYgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJ
T01NVVN0YXRlICpzLA0KPiAgICAgICB1aW50OF90IHBndHQ7DQo+ICAgICAgIHVpbnQzMl90IGlu
ZGV4Ow0KPiAgICAgICBkbWFfYWRkcl90IGVudHJ5X3NpemU7DQo+IC0gICAgWDg2SU9NTVVTdGF0
ZSAqeDg2X2lvbW11ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4NCj4gICAgICAgaW5kZXggPSBW
VERfUEFTSURfVEFCTEVfSU5ERVgocGFzaWQpOw0KPiAgICAgICBlbnRyeV9zaXplID0gVlREX1BB
U0lEX0VOVFJZX1NJWkU7DQo+IEBAIC04MjcsNyArODMwLDcgQEAgc3RhdGljIGludCB2dGRfZ2V0
X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICB9DQo+
DQo+ICAgICAgIC8qIERvIHRyYW5zbGF0aW9uIHR5cGUgY2hlY2sgKi8NCj4gLSAgICBpZiAoIXZ0
ZF9wZV90eXBlX2NoZWNrKHg4Nl9pb21tdSwgcGUpKSB7DQo+ICsgICAgaWYgKCF2dGRfcGVfdHlw
ZV9jaGVjayhzLCBwZSkpIHsNCj4gICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxF
X0VOVFJZX0lOVjsNCj4gICAgICAgfQ0KPg0KPiBAQCAtMzg2MSw3ICszODY0LDEzIEBAIHN0YXRp
YyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywgSG9zdElPTU1VRGV2aWNl
ICpoaW9kLA0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQo+DQo+IC0gICAg
cmV0dXJuIHRydWU7DQo+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAg
ICAgLyogQWxsIGNoZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4gbW9kZSBwYXNzICov
DQo+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGVycm9yX3Nl
dGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVuc3VwcG9ydGVkIGluIHNjYWxhYmxlIG1vZGVybiBt
b2RlIHlldCIpOw0KPiArICAgIHJldHVybiBmYWxzZTsNCj4gICB9DQo+DQo+ICAgc3RhdGljIGJv
b2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dCBkZXZmbiwNCj4gQEAgLTQwODQsNyArNDA5MywxMCBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2lu
aXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiAgICAgICB9DQo+DQo+ICAgICAgIC8qIFRPRE86IHJl
YWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3aGljaCBjYXAgdG8gYmUgZXhwb3NlZC4g
Ki8NCj4gLSAgICBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPiArICAgIGlmIChzLT5zY2FsYWJs
ZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VD
QVBfRkxUUzsNCj4gKyAgICAgICAgcy0+Y2FwIHw9IFZURF9DQVBfRlMxR1A7DQo+ICsgICAgfSBl
bHNlIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+ICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9F
Q0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPiAgICAgICB9DQo+DQo+
IEBAIC00MjUxLDkgKzQyNjMsOSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRl
bElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0K
Pg0KPiAtICAgIC8qIEN1cnJlbnRseSBvbmx5IGFkZHJlc3Mgd2lkdGhzIHN1cHBvcnRlZCBhcmUg
MzkgYW5kIDQ4IGJpdHMgKi8NCj4gICAgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FX
XzM5QklUKSAmJg0KPiAtICAgICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkp
IHsNCj4gKyAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpICYmDQo+ICsg
ICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gICAgICAgICAgIGVycm9yX3NldGcoZXJy
cCwgIlN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0KPiAgICAgICAg
ICAgICAgICAgICAgICBWVERfSE9TVF9BV18zOUJJVCwgVlREX0hPU1RfQVdfNDhCSVQpOw0KPiAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAtLQ0KPiAyLjM0LjENCj4NCg==

