Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA983C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk10x-00068t-2g; Wed, 15 Jul 2026 10:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk10s-00068a-NW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:55:06 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk10q-0004oQ-03
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:55:05 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
 by m0050102.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 66FE34a01340333; Wed, 15 Jul 2026 15:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 apr2026.eng; bh=8UVzoiQanrKw4wlsSkWdDO1tgMMjC445ynggmkPtaCI=; b=
 jzaM2aSmE4COSMq9b00S8rbzOXcUp7/ahChr75GnOyZzp7P+aS0lpove8Vw/6fu6
 9M0fE9OIhU+A2CA8CUIwVu3+kgeMLJIB0uHaTK54XKJoxCgjgkxsR87t1ZEIAltb
 GRA8JYhN33WdnIR8b3TAzYfaTabzhkmOq1Z/WhErIwrzOLnwuKHsdoScuZZKxrpP
 q90/TvHOAVL1K/XmT26uLTxBEjr3Xu44mXHTjursJOszSaIwEV4n/ep6bEyQ2QLp
 w/+drb66X5IlDE3ZHTxV0omWGkaJGNIpuY899BWUf7eoa8yuE19H8EH7C0H5Z9bX
 8ZhribBwhaKho6L5cBoo4A==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 4fbegj4hgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:54:59 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 66FEg1Of004385; Wed, 15 Jul 2026 10:54:58 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4fbh5v1x56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 10:54:58 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:54:58 -0700
Received: from BYAPR08CU003.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Jul 2026 07:54:58 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by CY5PR17MB6120.namprd17.prod.outlook.com (2603:10b6:930:33::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 14:54:53 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%6]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 14:54:53 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>, Jason Wang
 <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v19 13/15] net/tap: support local migration with virtio-net
Thread-Topic: [PATCH v19 13/15] net/tap: support local migration with
 virtio-net
Thread-Index: AQHdE6ew16dw8DCyHUKMaGG+2gFAGLZuaWuA
Date: Wed, 15 Jul 2026 14:54:53 +0000
Message-ID: <C3749950-EF67-430C-B894-A740C97124B6@akamai.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-14-vsementsov@yandex-team.ru>
In-Reply-To: <20260714154246.1242856-14-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.110.26062818
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|CY5PR17MB6120:EE_
x-ms-office365-filtering-correlation-id: bc3ea717-37f1-4de7-db34-08dee2810771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|10070799003|366016|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kbd+7PW90jwp2EUYrLlc1nU9bwMN6HYnUiHqOgG0y1iSfaLMReQlhZVNdHLQPiqTW4Jkrf3MGoCgK0fau+b3lQnSWNyoV/JCY2tSTs1iNZQg1NLgvOwSoJQxWtFgn+QT/LZKwI+cU0BUEc6wfyNxQqw1Wt9zvvslgerHtYriyj8PN/ibMJrQlZyU0NotR4F1aFZkGgmQTlgHVhBQpB1DRmSFoWy2U6gRA3Ob0PwDe0WJmxZ3irML3xHmp4xllcsCGFgAbfXfso3t5UtKdFJp5XcxPiqwLqJqwp0HoTi38epaERscdxscelWSJ2pax02ybTnww6j2X4pzjHQ70lnbkZv1+LChW/rKU10uerpOruGL5d+1QGGqFXuXpmYS+1ZU2bQpWFq5o1q/jUmDzygZSWa96PbZtkb4juxdwIXGn+0gouPV9zYjkb/c+DWQt4M0J5S0hG6DqYh0qqMWyZFR5WcEQm7y/zS4huC4DcFUwHdGUEz92kSsGCuHlGbuxq1NNf2a6xbexS2zYx8qf5erg/vkJ7GCAAevt6kugwc4AfcmtJzphyKaYLmtDn3fz9ma4MocDt7zDFuKZaLWczMw/+gLwRqxMCw1eg+ChwejMxQQzf+a0fZumumxC6lpBju+I/1yik37QCYnKwmBnxa3Mwv+20yDH7yWUmtJHM01S1YMn0Ma30hTbyd1ZNAcJWB0d1UfidkAJZJEJ0xhlAAXKgV9xQISTc25fRb2bVdwlbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(10070799003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BHQ2k2TmlzdEFuT1AzK3JWT2hybU5OTkhmVldMR1dBSUFWbzgzMStIaExm?=
 =?utf-8?B?YUdnT3JGTlBScllPSWxqSm5vVEpIY1dYTXlUa0VDYUVBWTFIMitrd1IvTU14?=
 =?utf-8?B?TCtOWDVrWXVzQWtiS0xrNDJhZjhjdnI2WjRGc0JnNC9VQysvMTFkbS9JcTZZ?=
 =?utf-8?B?VVlOc1cxSzhWOVYrVTVtalkzODF0MWZtTVAvbHJvUkpPY3gwc2lSOTd0bmZC?=
 =?utf-8?B?ZzVIRStnVzZ6NFNFUjhzOTVDVXRabENqZ01hRlhWNUcyUWZ4ZHc3MEFjSEJr?=
 =?utf-8?B?Ry9MS3pvL2JBSU9hZWZhSnQvZG1ueStYYlV0c0NzRDJEaXVrczE1dlljR2dS?=
 =?utf-8?B?Tk90Skt1TjdBTTM5OFhiU1daZmhyTWZIZHg4YnVLUE5iTkkzV2hYU3FSSXdD?=
 =?utf-8?B?cXZLd1A0cHVlclVVWXJ1SXlkLzV0Y015UTdUSCtUeWJEcDd3UXZraXN0R1Fp?=
 =?utf-8?B?VzI5K3NoR0lCQWpHQVVXOG1tQnM3dzZxZUdQZDBURk5mTG1ER1dTVWxNVDM4?=
 =?utf-8?B?Ym54SEp3YXVUMDA4WCtjckJ6L2pOSnJFc05pU3ZwZitMWnV1dC94ZHF2QTFq?=
 =?utf-8?B?bDJ5RS9YbElFK1J2d2hpdkV6cnphdFZEV2t2UFNHYTE2eVpWWjF2TXFHUDdp?=
 =?utf-8?B?NFZxRDAwSzBIbDZGV29Vem9WTmpTbFFtcVhyZHVxRGc3bjVjS1ZlUHhoTFpZ?=
 =?utf-8?B?QncrZDlmL1IvREo0N01UQ2NxK1pqL0lBYzN1RGxWdmsxZ1RHYVBMbUFFVjMz?=
 =?utf-8?B?bzBMRDcwWU85eHRJa1BhM3haamRQWEU2TjI5VXMzdEk4QlNtV0lmOWtmK2Y4?=
 =?utf-8?B?dU1xTERqK0FkMENOdzNNQUhPbVFLZzRNRmdWNGZCckRYU2RnVXE2OTduUzlY?=
 =?utf-8?B?Q29qRWhyVWltK2crU0ZxY01SekpxckZrYnlvR2RyRDFhbXU5SjhoN3A4b1dR?=
 =?utf-8?B?Yk45OUVnMkQ0UlBoeC8raTBSN0tWdTlRejZOZkhKa3lWbEJPODg2c0hvWkZy?=
 =?utf-8?B?QUNKdVNPQVowb2FCbThmdTNpaVN4Zm9WN2hwVWc1V1BBQWhOVHNpOWR0My91?=
 =?utf-8?B?ajRiT010a3Z3dGtSalExV3AxNyt5V1BaUHpjaUQzZzREZ2RDNXpvL2NzcjBn?=
 =?utf-8?B?aUIzWWk5Z3lqUVJnU1hFQWF2NE9oTFBpeE5xTklwNGVxbmxYM0tMUnZ2ang1?=
 =?utf-8?B?YTdOMlRHYVA3T2ZNbndnQzE0VjM5ZmlTV3RNdGRZRVBaTTdiQi9BMElzdDM2?=
 =?utf-8?B?QU5WNFZPYzhRdTRFLzJ3SlZvb0JhVlhDMnNGZHpabGxESFVISS9VL04wdXRJ?=
 =?utf-8?B?c2ZUQ2NTVlN6QjdxaHBLVnZabXNtTnpMUlhGc0lyWTRBMWNCbTNqZlBrbGVG?=
 =?utf-8?B?cGE1ejIvQ0hiQXBuVFcxYkZoQ21YRE1MNXNqRHJZWSsrazlVYlp5MVBVMmZw?=
 =?utf-8?B?bXRSRmE4OVpXMWJtcGxLVXNUcVhWelhUaCtxWWlnR1hmL09FZnlCOGxNSDhx?=
 =?utf-8?B?a3ZwRjBpaUtnRVZ5OUZIVlJ4MG9LbjkrUVMvdHZqbG1pbnUvTEpoSmRjeFJH?=
 =?utf-8?B?eW5XdGVzUHAxNnhhUVdaazZ1dWRCT3lMNXBTT0pseVEyL3g1N2FvMWprc2xK?=
 =?utf-8?B?OVlKcDZDTE5JRnhUdzRuazMzdDlrYmFnOE1SNzIzWjZFSXVMcS81SlMvUTRD?=
 =?utf-8?B?UWYyMnduZzgrUXJPVDJSd0ZieFVRSGdpenFzT3I0bzB5SC9FMi9BTEJwcktS?=
 =?utf-8?B?MFl3bmEzN2IxUXlnbTRKL0Rqc3JPc0tsdUlvTXRYNm1DcEFkQXlwd3QxODM5?=
 =?utf-8?B?M3JQY25IZVhuV3pLMUZ6b0FBRWxGUGlLbVRzbmlzYUlLVnJoQjRKbk1JVDR1?=
 =?utf-8?B?MEp5ZUZDWDY4a0xTOVpyYXRsQkxyaXZFa05hMFlyV0FnK1BMTHVoRGtabUY1?=
 =?utf-8?B?SzB3bVhxY2lCTnlUQStML3FmTElHa2pLcHVua0R5YzhQbEdUS0RHNk9ZQVZr?=
 =?utf-8?B?MkhtTmxlZW1IYXUrVVVQcUQ2RkhDNGZncVZ1N2Q0RzJHbnU5S01LeHlqUkV6?=
 =?utf-8?B?alRqaTJsYlFZUUE0YmNhMXlRNjRGYURGY2dLODZvOEZVQkZZTG1mNVUxcXUx?=
 =?utf-8?B?T0hFVTExcHB3Z1VXU3k5R29EWFNrZDV0T3lhSnpVMkZWdVl4U2ZScVJmYkgz?=
 =?utf-8?B?RTcxWEVoN091cGZNcWNzL1R5N3plMFk5MEcvY2VGOVpyVFFWbTdjQjFhTXFX?=
 =?utf-8?B?bTZWQVFORG1BS0VlaU4zWkw2S3pUQW5oSDlxL1VvQ1h3NllHWlVpcEo0ODVJ?=
 =?utf-8?B?UVhmNFpYWEllUXJMK2FPMFpoZ1hKUjhUYmJOTkJkMUhXUmlrNG9UbytwdVhn?=
 =?utf-8?Q?ZN20b+Oe+CMkd5jA+JET0ggs7p5VR/LkSRUr3eAib2oCs?=
x-ms-exchange-antispam-messagedata-1: W2Iv2QRlXl24VQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqP1zSChFLRF7UFpUFJxUerESAb/2ZwkcIXw7rCF7M2BP0TOQtZ4NhIf42ejSmnGeQ5RA8XrVNYGTeopRwXmtHIjXGd7s3icOLZkm9wnhR+QRYq8KnL1T77p4WGTQZ1qY0EoNT1ydzXgepQKgjN6T1gQBDRL3x2kR+O7xmGI54D5AjFZEgFqG04b5ucMJHRN1gPBLZn3AQGxKKnXck6Gzs4hAQiJ/fOAq//uh5f4kU1rma0o36yxsszOUEEEIYSDB+moNrj4J3+bbJMks0K1AJqUKOB2M07X9pd6D8mB/hyI7jBavzzj8z1powNawXtMaJeM3UcpZJHyifVliw4Alw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytG9U+txABFUKb8oLsff5dR3vCjulKjTX5PhF0+hb98=;
 b=aTh0C+nowZSQNXy+cPK99SyTsM6VdGmFNKjfqnJ51r4QnHnG5/tQSye8APVaPw0i4Gez7YHHc9YMEhJmIUSrpQGSxu4LFCA8r4C7IqA+z7foML318fhCUS1l6Z6QLpI9LOuJ9vAmgSTf0WtYYBZZ6aSViERNQaICU90rd68KokDp31/NZEj30kRHCauRGcWrShztlQVVz5541z1mIcD8Tp5O0fqTSBz+RYzsciszTrForWmJ8nXWPx1T4WOaFZ3F0seSwYdF/QhNlxDhJV4/E3H4z/tmZBuRPzk11NxJjEzT2J6TyOk8Ri0djcC8JRumwXSNS8AEhOp4W+RfYk4hYQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: Iy0GOESA0XFdVDbpJ9xxOpB/K+uF9rI8TazYsjiYP8KndvCCrSBRgyqebn5sgQzux6myVdLomk4QoTdiY2yaQ3Q96GpwZduj+1H2dTxeho8eF7SbZLrA1OhfATNPjc4g6iM6+r/WsCgpi/dLT7umh66OcVUvPieSP1glEG/JtdN9+NruDRcKGdj03lwztNU657Oc/64+tbStQbWSgXQbjQjfgYK5Rwq8zVQO9MjtTsARrduZYW0ScZJnJgnVvfdFPVe7JYIyTu30Lt56xDWJw03/d9uDayX/SqFcs7RtyeP3heh5Cahho0CmOI8gi0L1llbXJzv3hVke98bI4O4bQg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: bc3ea717-37f1-4de7-db34-08dee2810771
x-ms-exchange-crosstenant-originalarrivaltime: 15 Jul 2026 14:54:53.6288 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: emEZnrpZvrOzPtdAV63b2sPnmxh9y1ZvQEP2JqKJFVZtnkqX5KUl5rOJOO3QDMn4Q0VgNL6Ii0vT4lft64cSMw==
x-ms-exchange-transport-crosstenantheadersstamped: CY5PR17MB6120
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <71492DE9A2AEAF44B577AAC1A3CC5E71@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607150146
X-Proofpoint-GUID: 1XzJxpWEBsr-Oo8y6IDqebaMriQWVxwr
X-Proofpoint-ORIG-GUID: 1XzJxpWEBsr-Oo8y6IDqebaMriQWVxwr
X-Authority-Analysis: v=2.4 cv=XJkAjwhE c=1 sm=1 tr=0 ts=6a579f43 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=Pq72nHwyFlvh3xMh7ENp:22 a=6R7veym_AAAA:8 a=27Bv8fk0uu5NPRc7wWsA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0OCBTYWx0ZWRfX3fQg9p7BWXmv
 o3OrHePFrDODXm5V5lMdsk7yjzf57PN9n0QEQ/4bIl82bZFm3Exo7TuZlSPGW9pDM2m7/YhnZ1m
 It2XdrXsf/SqkiTZ01NNBmVWb/gm4Co=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0OCBTYWx0ZWRfXxtYhusJyMDca
 C13AzIkIrDy14pxGNQ2DcIIZ2iQkY3IowBPPcY+xtvJcqDVLNnncqiZZD0QiOPp7ig4PuGtKqnt
 UMCxtgrWgaQ1ecUZZTANn46nOi8JwjyJg4zFioOdZjsPO3DOZPXMGBSEeZYiTjWfqz+WFLaUHQ/
 YdiaNJm0KPwh1MxH9MEvDow4zyf2bpXiYBHEBAduYdY8Wn3GjmHZu24omISodbiOUNiBQTV2XnY
 KMep3XMtgFeaBqJry9q4VSNjlt3+lcqhol7/9R43aRyfX/3Gj/pKjvSX+JBQrU+QpKawu7dpb7k
 gyFLwsWSvBfHCzRr2Q0ns/unsmzt/kDBAhM5JNLidemQQDPhXR4qYbQw99nPYxV8/va005NBzH+
 fhNo/XG9zk+8qZ3E5T8i6sqgZrNPjCNQtMyplYERguQ6fzJMaENw+0UwZ8kedJbUfv7S10L73Bz
 nfQGmyRwcLDqhKUBTag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2607150148
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQrvu79PbiA3LzE0LzI2LCAxMTo0NCBBTSwgIlZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXki
IDx2c2VtZW50c292QHlhbmRleC10ZWFtLnJ1IDxtYWlsdG86dnNlbWVudHNvdkB5YW5kZXgtdGVh
bS5ydT4+IHdyb3RlOg0KDQoNCj4gKyBpZiAoaGFzX2xvY2FsX21pZ3JhdGlvbl9zdXBwb3J0ZWQp
IHsNCj4gKyBzLT5sb2NhbF9taWdyYXRpb25fc3VwcG9ydGVkID0gbG9jYWxfbWlncmF0aW9uX3N1
cHBvcnRlZDsNCj4gKyB9DQo+ICsNCj4gKyB2bXN0YXRlX3JlZ2lzdGVyKFZNU1RBVEVfSUYocyks
IFZNU1RBVEVfSU5TVEFOQ0VfSURfQU5ZLCAmdm1zdGF0ZV90YXAsIHMpOw0KPiArDQo+IHJldHVy
biBzOw0KPiB9DQoNCkEgY29tbWVudCBvbiB2bXN0YXRlX3JlZ2lzdGVyIHNheXM6DQoNCj4gKiBO
ZXcgY29kZSBzaG91bGRuJ3QgYmUgdXNpbmcgdGhpcyBmdW5jdGlvbiBhcyBRT00taWZpZWQgZGV2
aWNlcyBoYXZlDQo+ICogZGMtPnZtc2QgdG8gc3RvcmUgdGhlIHNlcmlhbGlzYXRpb24gZGVzY3Jp
cHRpb24uDQoNCklzIGl0IHBvc3NpYmxlIHRvIHVzZSB0aGF0IGludGVyZmFjZSBoZXJlPw0KDQoN
Cg==

