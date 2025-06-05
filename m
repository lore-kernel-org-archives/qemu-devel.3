Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0329C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNB9B-0002Mi-Ef; Thu, 05 Jun 2025 10:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Nina.Schoetterl-Glausch@ibm.com>)
 id 1uNASE-0004UF-HZ; Thu, 05 Jun 2025 09:16:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Nina.Schoetterl-Glausch@ibm.com>)
 id 1uNASC-0001Op-0x; Thu, 05 Jun 2025 09:16:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Bc4iG018970;
 Thu, 5 Jun 2025 13:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pp1; bh=HYNofresf+0Qxj2k9KkAggCODrnusptNQo00edJPlek=; b=YGFWCls3
 3AicEGk4UuhTBvq1TqpE2a0hwr1vCH3SZTnmcVlzEnF0RaW0R353hwjFbF1s7TC7
 6v0uHK7cVUEpMKr2+HuockKCZ4doou0ACSKHJjlQ0ijVT+BSHiR9dr2CtXJlfl3d
 e/nu/t2U6u56XOdwwxgGIGaCtEYwCMrTW6bsTf1NC3bIBSWzDbJDaLtIrWCPybvi
 eiTd8PId03lm8n3fqxcUeKkqmVx10cafCg8c/rLy5Ptcl9iZrvTwz2QoVA4INpBG
 ERlGv7ZshdZIweei1vbQgZ9ZHRME3EhxEeuvDoVyD2oVfnYUM25LlBkeDk1+fyJX
 UGjOOSF9grWNQA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwur9d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 13:16:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3XjYOYEZQvQM3hNOWlIS6CxtCAC9/dv4T4bbCD5jdRM1xX1bTmYsJSmwvVw07VFbyWHhuYeSmzGUpFzEJNNqIgZ0YX9jnj6w8/vZD8GPX6De6Dz0QiTxYQBHB5o9Sz7hfwN4ihuc5EfylTtzQQVARw0X4mNMkC0vHRwRa3yd7bQYvedCRtJZGNY5D/a6ErS5yltM5qAFwfag4uUSCDhrZ1NmdJh5gLtNbhtv+RNn1/Lsiwl37sXaBNDR9Tlmp+je0dlW4C2y8k0aUSzgTyaRdULLz1DLJ9TavF0XlnUTsXvP21+WdNuAwFGYk7YlOcERqbwmNCAliAouNonav8m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYNofresf+0Qxj2k9KkAggCODrnusptNQo00edJPlek=;
 b=hFA76DuBeASWiZlOqX4/+plmCSI5KhVvknhMXUi59TahwKxUPJUrBFPdti+9yiBZzt9mpfan7qb+h+BIGonNub+ixfKDeNwcvo3/tFU/hq7yD4QFfWrKgwnwdKRF6rYMfFvPjrDXXWyLgNexs4p69wyMlDfHk9zHvOcsDj92fW3k0Qf6RhX//kquVhHKy+bDNfQfRRmmvOrEhMTltSCWROuZNRyxO/vHkdxlG5v2ikGo0/I78mdXmSNOdhQi0WjX0O3gsT/unzM2eCo3lAvxCVuLkjV5XZvliZmAS6ancgmQQE7R8oCv5eLzyZr2yPan/wjumnraefOt2tXq9NzVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5967.namprd15.prod.outlook.com (2603:10b6:8:155::22)
 by PH7PR15MB5305.namprd15.prod.outlook.com (2603:10b6:510:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Thu, 5 Jun
 2025 13:16:12 +0000
Received: from DS0PR15MB5967.namprd15.prod.outlook.com
 ([fe80::96c5:6a41:4f25:2909]) by DS0PR15MB5967.namprd15.prod.outlook.com
 ([fe80::96c5:6a41:4f25:2909%7]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 13:16:12 +0000
From: Nina Schotterl-Glausch <Nina.Schoetterl-Glausch@ibm.com>
To: "shalini@linux.ibm.com" <shalini@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
CC: "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
 =?utf-8?B?RGFuaWVsIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
Thread-Topic: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to
 QOM
Thread-Index: AQHb1hwCM7VUIbC97EOmwn2+IHGADw==
Date: Thu, 5 Jun 2025 13:16:12 +0000
Message-ID: <3b95b9ad476e7ea1dd2afb95813f78a7680e7688.camel@ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
In-Reply-To: <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5967:EE_|PH7PR15MB5305:EE_
x-ms-office365-filtering-correlation-id: 9bd605be-ed0d-43b6-81b6-08dda43324e6
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVV5Q0RxdU1lTmkzRmFMOE1KejZSU1p5dTdqUFFYbHdxOHRqL0hZWHpOc0tT?=
 =?utf-8?B?QytMdVM0TlBBWWxRazNxOFdIMnV6VkVaQmsxeG80Y3o1VHJMZjh0NnpTWUVj?=
 =?utf-8?B?V0NXTk5yVk5wTWxpL21Lai9xRGRTVXg0UjBBaWt0MU9IMHJOOG0yc3I1a3A0?=
 =?utf-8?B?RTVUUzQzWUdhcDZVd0xxVHZwREpqekNzZmVkVVFWS1VacFViZzB0bW9zend1?=
 =?utf-8?B?T2VFdVl1cmNHcUF0N3h3K2Y5MWdoKys1a1dVdm9pRFlMUXcrNTIyZEx0MTVE?=
 =?utf-8?B?VUhrelMzV2ZmNnE1ZVdlS3lzd2tROFJ5RnVpSlVXemZTY0t2Ky81aWxMYXpQ?=
 =?utf-8?B?d1pkVWtZekNERkF2RlpkRlJpcUdFcnhWcGRrL3dRckNKSW1OSnhsYWM1ZC9M?=
 =?utf-8?B?dUdXK3ZaTUJ6U1dpdEY3eWZRVmlMMjFoQjM4UXUxYWtUc2diazdKcTdaZjhs?=
 =?utf-8?B?eGFBVG4vL3JZMHY4MlJGb2crS2xsTW1aN3FiMFdtYm1naW1VU1ZGM2tXcytR?=
 =?utf-8?B?RGtOQlQ4RGRYZ2EvWjR4bmd4Tk43Y01oYUdVczFDZkVRTi9CODVUQWpWNUVp?=
 =?utf-8?B?T1FOVTFoL29qZ2NCR05yS2xtREpSaDdFNjVoRjYzakFzTzJ6QTI5RkIycU9W?=
 =?utf-8?B?SytTbWtNM09qMUJKYlBjOUpJT1JMcjNvNXhZOFExSEdXY0FLdm1JK2dJbjJO?=
 =?utf-8?B?WHJZL2VEVzhMZURJS3NZNi9lUjg2Q1k2N0J3VkdMUU9QWmh6a0lseVlmeVFR?=
 =?utf-8?B?ZGw1UWZTUXZWZ09YdW5NbGlMREJJYTlyZUMvbTdndVVrWFY5aXlTVmYxUzIr?=
 =?utf-8?B?ekdmVnpvZWRlYk9nNk0vblh2cm1EUEovOEdyM2VBYnBGQjZ5V2RRMzlET3lC?=
 =?utf-8?B?NWVkblViR2c0NlFtclBEcDJXbzZRcjlKY09qd1ZBTkdaZWVEZm1hRno2SGVK?=
 =?utf-8?B?NEpTQVUzdGlQcUlJN2FFRmlWczlwU2dCaTNFU2JTajM2dU92UmtmWUtPNjRt?=
 =?utf-8?B?RWs4Rkl3cVl3cjcyZEFQbGkxb096cDhHaFM5Wi9vekxFNmVaMllKWUdKazNU?=
 =?utf-8?B?V0dZMkQ0WXpRZmpzaEJheEIwSmdVTGlWMlFiM3grZG5DbW43M29qV0tySkdY?=
 =?utf-8?B?aFdJWFdOSUp5aVk1K2VnNnc0V01wSnZZTkU3M1VYZGp1N3ZDZmJ5cWsyRmtY?=
 =?utf-8?B?eTRqUXRQbEtkUmRsZVJyRXZLZWtHckVzbnZNNm9oaGRua3FUM1BXS2FuVzhK?=
 =?utf-8?B?cGNYcVhzM2w5c1phRkJsRU1aZlh2MDZxbzNnY1hKLzJkZ0ZGZGZxbEdwb3BF?=
 =?utf-8?B?QVl4T3cvNmRmMFhQL2thT3RXNWpSR1dzeFpIQXpGczJaOEtzZmJYQXNtSENz?=
 =?utf-8?B?TVlyTysybVFnSWdNajIzVCtaYUViUWtkT1dhMGdtRjBhMkZFNHV2d09SS1NW?=
 =?utf-8?B?a3VIV2Y5RWY1SWRkTkkraFFLTVh4Z0tQQ1c5M2VteXJOZzZ0d01KTFNPdjR0?=
 =?utf-8?B?L0ZOOWNsbUVJcjM2N0d2M2FkejVEbVU0dm9ncHV4Sjc5SFFpTlVIRmhZWnJr?=
 =?utf-8?B?OEtMc0N2NXBJNzg0V0RvN2VTc2NBdTFZWitoYnVMcnZBWUtOdXIzQTMvQTVF?=
 =?utf-8?B?SnVFRXpCN1pLcE9JbkpNWGZGUUpqdFg1U3pNQkNjYnRzNjV2cElXV3djZGpM?=
 =?utf-8?B?dHlWbENlejZ6T1JycXhjOUhiNENXdTh2dGlsc2JtbTQ0M1FUN2lFWGlQOTFp?=
 =?utf-8?B?aTVpZG9KR3hTeVNBU2o4U0tVUjJXa3lGUE1TclZXb3BGSDJEMHptelMyZE85?=
 =?utf-8?B?dXJnZWxrUHpZdDRmSHlVZzd0R2NOZTR2NDB5V2tQenhVdlljdCs1U1ovTHZo?=
 =?utf-8?B?UXVTUVZVT21hN28vUFZqWmd3bC9PQzBvd1ZBNVVCaUE3bXcxUXk0eFdPK1pr?=
 =?utf-8?B?NTVhYXhLQ3FqaTUyZDAwd2VQYTBicjNRZkJUUk45OXlGakNONmhMd1E2Tzcr?=
 =?utf-8?Q?0CEyZG6Vwyeel7Y/b15+KoTUj0I+ik=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR15MB5967.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTQxai9FT3pPRlFDdkhibnV2RjU4Y3ZvNVVDREcvK0F6K0ZpajJOYmV2SlFz?=
 =?utf-8?B?NFZ6Z2VWb0p1UGI4ZGw1QzN4WTJsSzFLc1UyUk1KK0lKb0VVdlZvZW1PTGZZ?=
 =?utf-8?B?bWdZdHBkM1pSRk9XeEFRaXZoTllaVW9aR2JwSjB2eHU5K2trK3d0M0QrL1Nw?=
 =?utf-8?B?OFpDL0s4bHZ5Tno0am4yWGVZeS9mWEwzV3FlelhmaUcxVUxnYUJqTkJCYzdH?=
 =?utf-8?B?T3B6bEFWanNxTUs4UDh0blZiSU5FUTB1N3lhdDNOcElwSTFiZHNQb0pGRTgr?=
 =?utf-8?B?OUxFQnRzNVJnQjJRNGRhZjdwZ0h4b1JiOTVZaC8vcnpkK3ZBS050d2NUNSt4?=
 =?utf-8?B?L1FoSmcyVHdzbWpEQjQxTnNWS3o0Y29nb2plL3VXakI2bk51Q1dXM0l4aGpa?=
 =?utf-8?B?azJaZkZOWEJ6eGpPK0ROQlJsMGxObUJNZmJ2bU0yRGxRV3ZZVWhNSysxdWZW?=
 =?utf-8?B?cmVMY0p5V095d3IxczAwL3M2RnN0Z1ZNb3MwbW5PTGh2TmpRRHZlRUhlWW4y?=
 =?utf-8?B?cHhweU5Bd3RHNHJpYnh3T29ybUJWc1Z3TGdqRmszNlFKQk9ISWJERVF0NFoz?=
 =?utf-8?B?TVBjcHVwNVBBTWdodjV3SXVUSWxvM0Z0NjlIcVNSMWZ6YWV0Y1NKSmdlR2I4?=
 =?utf-8?B?Q05qNEhJbFRPTzVsU2pVMG0rb29aRW1CZ0d1M2NMdG1JMDhEU2VkUnF4cDdM?=
 =?utf-8?B?UzJSLzVQbG1mSlM3d0U5V0Z4SmFMckNvQnhrMVJXWFdJQ1QzMWJWbnJvTUJi?=
 =?utf-8?B?M1ZNS09FMktpemNLalRtOFJSMVdjR2tqWjllempqMGlMUzlTcWEvZERCTlpQ?=
 =?utf-8?B?Qk9VbzZTbXJDV2FldHpMMHpzVGNJeWtCSlNqRzJHVWlTaHNzcnRwWCtTM29V?=
 =?utf-8?B?Q2FyLzJzVVl3aFRPemhyOGhXVEJGU1RkdllpUENaZldXckVhdTYzUVhYZmVa?=
 =?utf-8?B?TUhvUEcvaktpZVYyUUNQMzhKMERPeU4xRkt4di9mYldrd3gvMWhhYTIvQ29V?=
 =?utf-8?B?S2JLMWVSczc4L0ZXRDlZTldtMHAxR1JUM1B1L3BKcDdtQ3l4Yitmc2Zvby8w?=
 =?utf-8?B?S1JIUVIyNHJWM0d0bGkrMW1kTUFnTWJsM0JJSktqbzZYOE9WS2FaUUNYWk9P?=
 =?utf-8?B?SzFkRGJIRU1BTS9uM3cvMVZGaTB4V3dkalJSMUhYSVNQR0xGZVF6ZENXS1N0?=
 =?utf-8?B?cU9wRG13RXlRU0krOGtIaDl4aDB4SFI5NXFKYVN3NXZZSUpvMlk1MStRVkhk?=
 =?utf-8?B?eUplL2ZBU1Y0NWpLTWUzeWpaVjBLc3BLOHM2QXV1NnFuN1FRSldQYVBSWXNw?=
 =?utf-8?B?dTFXZUVBTDdUR3BLNWVyMjFKdUpLWi95bFNEZjZiYWh3ckt3MXdEWmFraVh4?=
 =?utf-8?B?VFZmQ0lKdUdPV2o5cEUyY0R2eW8yM3QxaEl2enJ6QUJqVGUxV01nNnVmU1NM?=
 =?utf-8?B?eSt4QlF4Y0NmcUwxQWJpTDlZWmZoZVNNRFk4MnZUUTdBdGRqSDQ2ZnEzQk1Y?=
 =?utf-8?B?d0l5VXJUeEluSkxtcDJKNDdJQ0doNjE5UFM1alpMdG9wKy9EeUVVMHhzb0Z1?=
 =?utf-8?B?RVhzTmhGU3ErbnNBSUFaNVpOQVJMUytCcW9aUXRPRHRhekMweVoxRjZIek1N?=
 =?utf-8?B?ZmR5VXNUa29DUllIck13WnlRQW1QaHRmT3NKVkFDZFNWazdqbHlkMlJlclZM?=
 =?utf-8?B?WXFwVHl3RUdJN3UwdkI2Nm80RzVYOTdmZFZISjlteU1CaWl5QVI2SU8ySVJK?=
 =?utf-8?B?dXhaZ0NYVkgySnM3aUFpV1R3My81RzFxMlhSN0lHQVZCdHhMazUwNmdQSThv?=
 =?utf-8?B?V1RoTmlJUnZQeWFkbEVJanNVWGhBVElRdWJaaXJGS25FNkFkSThLeUU5VENy?=
 =?utf-8?B?VXB1QVRoZHJjcVpqVE0wODgzK242K2hkUUg2cjc4eW44amNyNm1Yb1ZUajNt?=
 =?utf-8?B?ZldzVk9jOUkrSURJNFVORlhCL0ZNVXBkanJtcGtUeHF4TjQvL2krdFlmaTBG?=
 =?utf-8?B?M2tRSmx3UjlSL0ZMK1VKOStaOGs3NG1oWkFPNWxJOEQvRTlMUDJ6R2RCYzZl?=
 =?utf-8?B?eThabXZET0ltSW9rbTVCM01KUFZFUEoveGtVZ3NvMzNEenA4KytnZDBTZ3JC?=
 =?utf-8?B?cmtFOTBEeGdra0xvS2I4YytDWTBmSDBocGRTSllvcWw0QXNPRys2eWlTWXZ2?=
 =?utf-8?Q?bVN5EeGWmX3a8YWiEcE0g4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E67F1D4B88F9C45ABEB05CDC3F9D26C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5967.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd605be-ed0d-43b6-81b6-08dda43324e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 13:16:12.5740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD4ne6lwDjOnF7t8ZuGHXm2mdE9HGSlLMc7LW+x7EWN9EfzrgaXTgF51jDLYoi1/NO4Pzv3M6bM2pSVPE4KsXPOPWHxc87to0qBed5oAXkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5305
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExMSBTYWx0ZWRfX+mMyuMTMDYYd
 tTSHfcPsLz+DD7HnRfxXHcMcUvVI5ITfQQnPXYMo9LKZuybmOK/fSG4JM9En56igerEL3nxXjil
 8jhsi4x/qH8KRCh4QZ9SxdW6tbGe+0csO6PVpFJzBCWthyyL1bZZYUetV1SMOTDJjHBYByt7mtR
 mq7KTPU2+mFwLTMHrdYCvZg7/FzcbhRb9L/XHjbBX2LqRRDM9IpGTDDXy2Nv+Phzvd3+MefJGMJ
 21p79ZLV4q+IZhhLFS/Z1o58h/ij+GZyu4DuleeTuXWjz1t+Pive+W45N6zCe4AVqwgy0mUdLOy
 LIIQ+WTDW38wiIillYoRAfs6ul1Ka+aVMrRdpq1WV93HE8whMtlprLbUBmWhhKdBgsexNxx4p6i
 OTpvdUzWmlJg2VwGUoURu77/igmdcVmUrK06fFmHVzZVhdwGA2F1/AjtldizdX94JKyjYV8d
X-Proofpoint-GUID: p08Y2baBOaDvXl8cddRw2ANEFkQTo0jK
X-Proofpoint-ORIG-GUID: p08Y2baBOaDvXl8cddRw2ANEFkQTo0jK
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=684198a0 cx=c_pps
 a=rMLDMX+eYuRtYGmsGWaDEw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Lh2iM_emvY-ES8JQXb4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050111
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=Nina.Schoetterl-Glausch@ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Jun 2025 10:00:40 -0400
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

T24gVGh1LCAyMDI1LTA2LTA1IGF0IDEzOjU2ICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4g
T24gMDUvMDYvMjAyNSAxMC4zNCwgTmluYSBTY2hvZXR0ZXJsLUdsYXVzY2ggd3JvdGU6DQo+ID4g
T24gVHVlLCAyMDI1LTA2LTAzIGF0IDE1OjU2ICswMjAwLCBTaGFsaW5pIENoZWxsYXRodXJhaSBT
YXJvamEgd3JvdGU6DQo+ID4gPiBBZGQgQ29udHJvbC1Qcm9ncmFtIElkZW50aWZpY2F0aW9uIChD
UEkpIGRhdGEgdG8gdGhlIFFFTVUgT2JqZWN0DQo+ID4gPiBNb2RlbCAoUU9NKSwgYWxvbmcgd2l0
aCB0aGUgdGltZXN0YW1wIGluIHdoaWNoIHRoZSBkYXRhIHdhcyByZWNlaXZlZA0KPiA+ID4gYXMg
c2hvd24gYmVsb3cuDQo+ID4gDQo+ID4gWy4uLl0NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogU2hhbGluaSBDaGVsbGF0aHVyYWkgU2Fyb2phIDxzaGFsaW5pQGxpbnV4LmlibS5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICAgaHcvczM5MHgvc2NscGNwaS5jICAgICAgICAgICAgICAgIHwgNDcg
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gICBpbmNsdWRlL2h3L3MzOTB4L2V2ZW50
LWZhY2lsaXR5LmggfCAgNSArKysNCj4gPiA+ICAgcWFwaS9tYWNoaW5lLmpzb24gICAgICAgICAg
ICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gICAzIGZp
bGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9ody9zMzkweC9zY2xwY3BpLmMgYi9ody9zMzkweC9zY2xwY3BpLmMNCj4gPiA+IGluZGV4IDkz
NWZhODdhY2QuLmVjNzExZTIyOTEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ody9zMzkweC9zY2xwY3Bp
LmMNCj4gPiA+ICsrKyBiL2h3L3MzOTB4L3NjbHBjcGkuYw0KPiA+ID4gQEAgLTE1LDcgKzE1LDkg
QEANCj4gPiA+ICAgICAqLw0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gPiAgIA0KPiA+ID4gK3N0YXRp
YyB2b2lkIGNwaV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgU0NMUEV2
ZW50Q1BJICplID0gU0NMUF9FVkVOVF9DUEkob2JqKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgb2Jq
ZWN0X3Byb3BlcnR5X2FkZF9zdHIob2JqLCAic3lzdGVtX3R5cGUiLCBnZXRfc3lzdGVtX3R5cGUs
IE5VTEwpOw0KPiA+ID4gKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX3N0cihvYmosICJzeXN0ZW1f
bmFtZSIsIGdldF9zeXN0ZW1fbmFtZSwgTlVMTCk7DQo+ID4gPiArICAgIG9iamVjdF9wcm9wZXJ0
eV9hZGRfc3RyKG9iaiwgInN5c3BsZXhfbmFtZSIsIGdldF9zeXNwbGV4X25hbWUsIE5VTEwpOw0K
PiA+ID4gKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ2NF9wdHIob2JqLCAic3lzdGVtX2xl
dmVsIiwgJihlLT5zeXN0ZW1fbGV2ZWwpLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgT0JKX1BST1BfRkxBR19SRUFEKTsNCj4gPiA+ICsgICAgb2JqZWN0X3Byb3Bl
cnR5X2FkZF91aW50NjRfcHRyKG9iaiwgInRpbWVzdGFtcCIsICYoZS0+dGltZXN0YW1wKSwNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSl9QUk9QX0ZMQUdfUkVB
RCk7DQo+ID4gPiArfQ0KPiA+IA0KPiA+IEkgdGhpbmsgaXQgd291bGQgYmUgY2xlYW5lciBpZiB0
aG9zZSB3ZXJlIGNsYXNzIHByb3BlcnRpZXMuDQo+ID4gWW91IGNvdWxkIHVzZSBvYmplY3RfY2xh
c3NfcHJvcGVydHlfYWRkX3N0ciBpbiBjcGlfY2xhc3NfaW5pdCwNCj4gPiBidXQgSSB0aGluayBp
dCdkIGJlIG5pY2UgdG8gdXNlIERFRklORV9QUk9QXyhTVFJ8VUlOVDY0KSBhbmQNCj4gPiBkZXZp
Y2VfY2xhc3Nfc2V0X3Byb3BzLg0KPiANCj4gRm9yICJub3JtYWwiIHByb3BlcnRpZXMgSSdkIHNh
eSAieWVzIiAuLi4gYnV0IGluIHRoaXMgY2FzZSwgdGhpcyB3b3VsZCBhbHNvIA0KPiBhbGxvdyB0
aGUgdXNlciB0byBzZXQgdGhlIHByb3BlcnRpZXMgZnJvbSB0aGUgaG9zdCBzaWRlIC0gd2hpY2gg
d291bGQgYmUgYSANCj4gbGl0dGxlIGJpdCB3ZWlyZD8gU28gSSB0aGluayBpdCBtaWdodCBiZSBj
bGVhbmVyIHRvIGtlZXAgaXQgdGhpcyB3YXkgaGVyZSANCj4gd2l0aG91dCB0aGUgInNldHRlciIg
ZnVuY3Rpb25zPyBXRFlUPw0KDQpPaCwgeWVhaCBJIGRpZG4ndCBjb25zaWRlciB0aGlzLg0KU3Rp
bGwsIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfc3RyIHdvdWxkIGJlIGJldHRlciBJIHRoaW5r
LCBhbGwgaW5zdGFuY2VzDQpvZiB0aGUgY2xhc3Mgc2hvdWxkIGhhdmUgdGhlc2UgcHJvcGVydGll
cy4NCg0KDQpbLi4uXQ0KDQotLSANCklCTSBEZXV0c2NobGFuZCBSZXNlYXJjaCAmIERldmVsb3Bt
ZW50IEdtYkgNClZvcnNpdHplbmRlciBkZXMgQXVmc2ljaHRzcmF0czogV29sZmdhbmcgV2VuZHQN
Ckdlc2Now6RmdHNmw7xocnVuZzogRGF2aWQgRmFsbGVyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6
IELDtmJsaW5nZW4gLyBSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IFN0dXR0Z2FydCwgSFJC
IDI0MzI5NA0K

