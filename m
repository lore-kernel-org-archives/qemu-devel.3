Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F64C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfRu-0005ah-0M; Tue, 02 Jul 2024 11:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfRr-0005ZQ-AU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:29:39 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfRp-0003Pf-Gv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719934177; x=1751470177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tJuNzOLmJZx1CU4YlhNdQHhL5ASx45curzOvn/1Sa9w=;
 b=dJwSOvukbQ0jfwQwh+LL0ICd9cQTFgWv8hGM2zVi12eG/mA/NAKVYGKE
 +ZClnHPBam5WBunzK34FyDvLsCKdP+LrPgkxJHqYwI96tJelGbZLGOKD2
 KQ9Ev3z7xpa/7CFPOpGAtcx6ZCthBwLKqP2pWfwB8BueBleEJIgrcHW8p
 eDvG6j6llgOLxo4EYzhjE7stXgCmceHJIOPD2UiERYKz5Q+38g7XH+2TG
 3CBRxIm1UZb+w109aaxh5ZnDGNbo8YftO3i3nltwR1oXh8n4NmBQu6tM4
 CrJbj3x/hY28XmcUGULwBUnEX2iTF2SR4It1NrcxbfbxMrdoz0w76jE6i Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15769942"
X-MGA-submission: =?us-ascii?q?MDFWLQprIDmezu+zxTU8bIes5cs7mLGDE+1MFO?=
 =?us-ascii?q?rsYhmVUflzw9xwdaNMz30gMfK+2qlSKN3eu8PC+Mu0DVGM8UkHBkDmnY?=
 =?us-ascii?q?t0AKoxd4rXbZi7aq9cXJM3qJjPGjfQjDnH19D2QXhAAUCHujR5lEGQd9?=
 =?us-ascii?q?BZQ+2mQVSCj5uHZxoHLi6cog=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 17:29:35 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0QmRzIu8jDGbPAFByGyAw4xzIglnk3Gyle3/InIa4JFB03OU+bawqDUWCwMAM3zWIV+IQKHffZ/d8040bSN87AUr+bvckr+yY89++vzETnnemDUd9rdoelbyiLXIsLZs1rYYW1uvgYpDZdqTuW2QUboWbZ5z/PkXizfbWRd4vItXAT9r/OHRfBk5P7RL2O8VEHn2NFPcz0rgBur8amaN7hUKx5OjjxLj/TSHNJMMbPVcKyZ9hWCJR/a3HpEmY1qi0b2ZXJlMUoc/pQ4cc8NvC4DhOeddS6RtwP49KQT5VXZateV6XHr3f0G5FlH9M0ti8TxKhgALjNdArxchkg0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJuNzOLmJZx1CU4YlhNdQHhL5ASx45curzOvn/1Sa9w=;
 b=lBLelJfzrRdldiCorVDP7Kd6XWwdaaLqhbr+q/R0DTNQgbItlTjPQEluhOnKoivVXN0XTcw0Ne8kTDfT2knsszKtExXVZ5YRpW1xOTY0TSI50oFlyezEGyZP7qB5w6BzY2h/gcdMmAZNOzFnd7stEM5QF7lwKeXjVlKYY/2GYJzwh5a3Yc5AmmnxEHdMH3GnhDycXuFM8Hgje+cneFuImJaanWVGnBcmlFJrFTyW6PYs8jRQIV8fahjjQL8+cVOJD2j+pYN+Ar0aNuNpfaXk+PJ/VRwJd6Nflb74i2VlJNyDNMxitaG9AMtJB066imO+9sfHnNTM0kNSyREI6u2sLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJuNzOLmJZx1CU4YlhNdQHhL5ASx45curzOvn/1Sa9w=;
 b=MgyMQzcvtDQ/0UcMxJxSvn6sxMXb0Izu2Gg3v0NL7d7+pVtIZWfr7MtJUw28bWRH6X1wi5HkfolNUNuXmnJH6sxIZOPERFJCtUqXBPu0ZnbJo51k2SYutaK3X2tMS6Lm709PTjPh4umyg2V+SEKyoPJ53u5cwSzMAx27BQUxbgW7GJW6Paaq6bsBRpEzLkImQ37mnr2hHK0Zd7bJC/O7dTD8kqJMQ3As/oGq76pDioVWUiC619LsrUY8gcXjAjD6XaOBbSKmOpQB4ztBY4j+RSbixudBLGJUpje7qKm1dkz3lo8jhDlTZ2YQlmIMTrjUyjUbeNBzsD6asMxfd9FLVw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6412.eurprd07.prod.outlook.com (2603:10a6:10:138::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.22; Tue, 2 Jul
 2024 15:29:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:29:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Topic: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHazEQIBXXzL7bpek6rQxeDAgf6e7HjcFQAgAAgaoA=
Date: Tue, 2 Jul 2024 15:29:33 +0000
Message-ID: <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
 <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
In-Reply-To: <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6412:EE_
x-ms-office365-filtering-correlation-id: 4234e4a1-b610-4f05-b774-08dc9aabc659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWNYTHlnOGVMMkl0SFpQR0VzWDhrWkU5dFlOVFVvMXpzL0Y1UklnMVFoUEFo?=
 =?utf-8?B?SGtLaVFOMCtSc1A4MjdjNVZ5akpKSEV0YjZ1c01GSXRZVVRUUm11L3g1YkxC?=
 =?utf-8?B?eHNHYWF6RFNoRkc4aWZkdTVLU0dneUtSLzhrYmpjMllYbTE2K2lEVm1hNm1o?=
 =?utf-8?B?TE44VEQrSjN5MlhEUU4yTE5wVU41YmdTSzdUNDBrZ3ZnMjNzUnVWZGd6bHZu?=
 =?utf-8?B?R1ZPYUErbU9kRnZzdHQ5N0YvUWQvRGdWazBQTER3Rm1GRUJiM3h4QjdpWFd1?=
 =?utf-8?B?MTZFb2hUdEM4ZmNwejBYUHR3MGRuQTAxZW9DMTNaZVVSak5FMFhCWjNpV3pp?=
 =?utf-8?B?T3VWaTExTlhPcW5SdWVCSmFIalA3Wk1mNzNvdnVHRXpFQ21LL2g0Ui96TXVh?=
 =?utf-8?B?M3kySld3ODJqR2o0cWJoUUFxV0lxZVorblRiTVNZV0VPNVdZQnJCaG1OMFdu?=
 =?utf-8?B?V0xxZHl3MVdnTFFwTGJwQ2kyQ2xyUjFqaE1WRDM4b1QzNUdQeVIvaDlmUFl3?=
 =?utf-8?B?RGEyMjh2WDRPZkxtaldhRW41VjFYVGRxTjhrcE0wTlVRU0V1LzNkVlRHUDRK?=
 =?utf-8?B?U1lLdGlwd2JLRG11MGx5UHFyUnhUZ2J5ell3SXc2QjJyMFhBamhDZlFCNkpW?=
 =?utf-8?B?ZlZGSEhsMjNtNnJWQVhzRm5BOXFlbHIxUzRFRHY0MTRURTFtN2JmdWN2QTBs?=
 =?utf-8?B?TWh6Z2VGUlovckpjY05uejUvb3h3MnZwNGs3R1dDYVhNdXM5SFZtdlJFbW9D?=
 =?utf-8?B?WkpNSVZ4cTkzQ0p2aUFMaTVLeCtVa1dnOHVaL3Q0YnlzY1NqenJkSTVvdERk?=
 =?utf-8?B?OUlibWdrMmw5aFhjaGVQK2NqZXR0UFlPeFVmazRQS01yYzVZVStURmVuNm1a?=
 =?utf-8?B?N04vQVRIUTRJdmJ1NkFqbjJ5VXpHRldyWFg1QTM0QzkybDhqaWowWU1IWXFj?=
 =?utf-8?B?WXlENjN2NGhDbkdLeHpSQVQ2YXpyaTRPZ1ZJVnkrRGhHWno2am41RDZCZXpQ?=
 =?utf-8?B?M2NVL2NZSUtNb0RoWGI3bFk1Qm15VnhNZ1FyakI4VmRrb2M0aFhFdWsrOCtG?=
 =?utf-8?B?MWs1czFaeHlGUlFYSXhsV204akVpSkw2ZDNRRnQ4ekoyeSsxbHZlOXovRUtI?=
 =?utf-8?B?S3R6MUl5aGZCSlRGcy9UdEkwMXpTMVVSR1VXLzhoellDaG5Nd0Z2T1h1TVly?=
 =?utf-8?B?eDZkWlpMYkxmYmg3YWlueDQvbVdjN0l6dWswUHhQbm1PNU1iVDc4b1ZKZ1VC?=
 =?utf-8?B?U2dZSXk5TU5CeXZFdHFBamo0djhnOTE1M3Y1eFR6Y1FLUkxlbXRyeWowOUVY?=
 =?utf-8?B?dXZyMjRKY0hFcTNEa0dueUJSNXI0ZlRSWXRJWW5hMSsrU2Jzb0p6ZkxzdU1B?=
 =?utf-8?B?T1ZLUURGaVgvbnJRcnhMak0yK3FobXN6WklLRXBGSFh3VWhoTkVLTVJ1S0VD?=
 =?utf-8?B?c1VXSDZiM1BUN0hwZkZBZVlSbjI5eFdhNXBMVDdPV0lxVWpqb0E1bW9ZNnZi?=
 =?utf-8?B?VHE1Y3pmQUNSZllDL1NPVXprazNBd3BUeDRobUd3aUlxc0dRR0VHY0c1UWJF?=
 =?utf-8?B?TFQ1bzNnb2xuWDNnY2oxSnVyN0gxZnJsNTlueXN3d01CZDQ4L2lKQ2NzcHdL?=
 =?utf-8?B?aUFidGgvQ2t5NEtHRmhJNkc1UnVoVjhFbjMxOUQ2d3VIaFIyOFdJVlBvWjFt?=
 =?utf-8?B?SUUzVGw0QS9hZE16cDBkQ2t0cUMrL3hialY4QllWaE5LQ21FYjZmWVdnS3kx?=
 =?utf-8?B?YjZQY1pmYWRXUmlTUWVVYW9Wd3VwbitNeHhudWxWdmZmaG1oWDBTTm5lNzdX?=
 =?utf-8?B?VFc3VUlnUlUwVCtQalVGNDkzdy8xVjhUWnplQ3BKY3VBblNQcVdjdmsxRisv?=
 =?utf-8?B?eEkrdEJKbnhROFZHbWJ3b2RhZjUzaDZNRGFBTUd4VjFyaGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDJVSEpvQlk0THhhYjE5VXppRUlXeFBaT1lzNE43QldNWi9FVWlGTVFuejZH?=
 =?utf-8?B?NE05Q3o5OGF0akg5SUdIa0x2d1o3eGFXZ2pjZW5xSDFCT1RLUS9RQWFvOGNt?=
 =?utf-8?B?MGZEWlVNYUE4VlBNZUx0V3lYNUhJeGpDY05IRXRhdm1IWTF2d0JTYUJOdGxr?=
 =?utf-8?B?WFNyOG9LbnFlL1NlZysrNzljYUlnejNHMXJ2ODNwUk1XTk9KQXJpUHFFdysx?=
 =?utf-8?B?N045VW5DbmFlckJ1VlZhRS9XbE9sUURHN00wandXTkh0ZXRpUHAzWnFYNkNz?=
 =?utf-8?B?VDRLR2FTT2dnVWE1U2VkbGxXWENjUldaOCt2bVZwSXpuMk9pTGhvSmwyRjB0?=
 =?utf-8?B?bUhIZEtQR1daK2lmZnBUQk5icjV0NDNJTU1yQ1R5bjFMVmJaeVd0VU4yV1VG?=
 =?utf-8?B?RXBHZ01BUHI5b0FsczV3d05ZS2oxaWs4bWpuU2RsR01GN0RhbUlZdTBwbW1t?=
 =?utf-8?B?djErMEpkaFIvcGR6cnE1MFkvMDJKS1htbDUraVFmamptalBlVEFVTENVa3ZO?=
 =?utf-8?B?akpuN2VyMkJHaHdmN28wQzJZYU56ZGNQeWo5RDczcENvYi91QTIwOVlMQTZu?=
 =?utf-8?B?RDdMV2FtREFtaUdrcTQyRlJtSXNQT1YvNkUrVlFTRzlqTnZlNmhaTkVSRnBC?=
 =?utf-8?B?RmlsVjFqZ3F1aVFkYjRIS1NOeXcxUTlySVN5eGZEL3M2YytyaDJVaVppMVFP?=
 =?utf-8?B?c2lOakJqQzh5VHpsTnNFcXZwZkJKdzlhajl4SXA1dTRDM0JNQkV6WWZFR2Ux?=
 =?utf-8?B?cjZ3eUFxbDRrTnMyVDh6MGY4S2FNZjNnWkRUOFkrZktGU3p6bmx1SldEeUVv?=
 =?utf-8?B?WHhCQUdMNWZpZWZNSWNvaEZ2SUg4aDZqelhFaERUNVl6Qm1yOWY4N1NnUytO?=
 =?utf-8?B?U3BnY01LRkVhS0dsbmtHZmFRRUV4OUFoTE9lSW9qdU9wbGNIUTZxbHZBUkVn?=
 =?utf-8?B?RHhtT0JkS0ZlZlJ6NzJVTGJNUzJJVU5ha3dkeS9BZHd6TVQ2NEdMSEFUNDhv?=
 =?utf-8?B?bHZySEg5N1d6NStSY3NranVIbWtCWnJzazRqU3krTUpHOTJrUDZKaGxaYmIx?=
 =?utf-8?B?TGQ2MkduTno4aU9KNVlua1NsdWhBWENTT1FuV2xiSmZXTE91Tkp3VlNRK3Vv?=
 =?utf-8?B?VHpFNTExamdQVWFud3pDSjhvd2xsaVRxLzhNN2VReW9sejVOeWkybHFubjlD?=
 =?utf-8?B?ZmxBSDJYZ0pXOUNtTXdjcDltckZNdnZKZ2RJejNsZmhIT2xCczJNQVFNaUdL?=
 =?utf-8?B?MG1kRjZCQU42TmhhbWZ5enkvbVN0aEtJSkliZjJFSlNCeWFpdkk5REVqd0w1?=
 =?utf-8?B?L216d0I1aTZGcU9lZ2RNUXZaQVRUWmRnSllsYmRGTVNBT3lCRE16OTlOZEZq?=
 =?utf-8?B?ekkwOGlvNnhnd3BvclNoNHp3M282WjRiUXVjNE5FUWtEL3VGMC9jODBPTWlz?=
 =?utf-8?B?c0dnZVh0MERVUzZtcDk1YlFwZTJDWHU1dFpPbGFINGZlb1c0UTRYdWM1NklJ?=
 =?utf-8?B?ekdxOENndThWUSt4OE1yVEdWYzlPWmFONmQwV25OQ1lYdC96TGZhQlJNdTVD?=
 =?utf-8?B?TDBjOXBkdndWaTdRRlU3dXNSR3A5bW8zTHNmalllQmRGbjRoZlRHSGZMb2dN?=
 =?utf-8?B?dWQ2cWZqWVA2TXhlWXU3T25zSWJMZTJobDlZKytRRkZmcG54VnF3eHczalpS?=
 =?utf-8?B?WnZhNFQ2UzlZY21USE1xUldHTFJqcldIbVF2bTAyaEdSMEtQSUYwTGk4eGVv?=
 =?utf-8?B?c1Z5R0U0dGdxVU9ZNHowdzNzUnZLdDlHT2lrV2VSWG5JVFlScE1HaHd3a3Bi?=
 =?utf-8?B?U3pyemNWbGluS0QyZmpMSThWNGFmb2Z4RTZyYVB3R0l4RUdIT2hFa2V1RVNX?=
 =?utf-8?B?VUFjVERhWUU0NmxpL3JWVVZXT2NRR1Ezc1R5Vm52MHl3ZHBZejVRMDVRSG9w?=
 =?utf-8?B?a3NEblJQQWk5bTJpMzZ1MFVLY3FVallLYURxQWp6Mng5RUNmMHBHRmR6TFA4?=
 =?utf-8?B?bmxFTjZUYll1SkZ6Tjl1d2pOaUtxZWV3TjVIR2M4d2pxN3hRcDlnSWQxZkxI?=
 =?utf-8?B?c2psZEdsTHJtdUl6NkR1eHlmNTY2cmZYbU9nZlZGTVYrREtDaDdLbEVlWkJW?=
 =?utf-8?B?Ly9tYXdoODlxaDZmalpLRGNoRnlRVDV3N1pNcFgzRWhzdXFPUTNmRFFac0R0?=
 =?utf-8?Q?H9AOvxmlae/zMCdzjyYd868=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CA1D32187CE0E4D80F8AEA238410C27@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4234e4a1-b610-4f05-b774-08dc9aabc659
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:29:33.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUowupegnlDYiJ0qxa+dss+/61ao4gBX52hd1J4c4WUPm3ZFnRmMfF+ihvhDnlpp9YRkuBBAgLvy0QSy01dCOWZQWW/ZjFl3S14L80VPno/iUBl2Zhc5JgMPIZBsETzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6412
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

DQpPbiAwMi8wNy8yMDI0IDE1OjMzLCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zD
qW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+
PiBSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNSArKysrKw0KPj4gwqAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDk4OTk2ZWRl
ZGMuLjcxY2ViZTJmZDMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM1MDAsNiArMzUwMCwxMSBAQCBz
dGF0aWMgYm9vbCANCj4+IHZ0ZF9wcm9jZXNzX3dhaXRfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMs
IFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4gwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGludl9kZXNj
LT5sbyAmIFZURF9JTlZfREVTQ19XQUlUX0lGKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
SW50ZXJydXB0IGZsYWcgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfZ2VuZXJhdGVfY29t
cGxldGlvbl9ldmVudChzKTsNCj4+ICvCoMKgwqAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBW
VERfSU5WX0RFU0NfV0FJVF9GTikgew0KPj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+PiArwqDCoMKg
wqDCoMKgwqDCoCAqIFNXID0gMCwgSUYgPSAwLCBGTiA9IDENCj4+ICvCoMKgwqDCoMKgwqDCoMKg
ICogTm90aGluZyB0byBkbyBhcyB3ZSBwcm9jZXNzIHRoZSBldmVudHMgc2VxdWVudGlhbGx5DQo+
PiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPg0KPiBUaGlzIGNvZGUgbG9va3MgYSBiaXQgd2VpcmQu
IFNXIGZpZWxkIGRvZXMgbm90IGNvLWV4aXN0IHdpdGggSUYuIEJ1dCANCj4gZWl0aGVyDQo+IFNX
IG9yIElGIGNhbiBjby1leGlzdCB3aXRoIEZOIGZsYWcuIElzIGl0PyBIYXZlIHlvdSBhbHJlYWR5
IHNlZW4gYSB3YWl0DQo+IGRlc2NyaXB0b3IgdGhhdCBvbmx5IGhhcyBGTiBmbGFnIHNldCBidXQg
bm8gU1cgbm9yIElGIGZsYWc/DQpZZXMsIG15IHRlc3Qgc3VpdGUgdHJpZ2dlcnMgdGhhdCBjb25k
aXRpb24NCj4NCj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBl
cnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0lIlBSSXg2NCIsIA0K
Pj4gbG89JSJQUkl4NjQNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAiICh1bmtub3duIHR5cGUpIiwgX19mdW5jX18sIGludl9kZXNjLT5o
aSwNCj4NCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IFlpIExpdQ==

