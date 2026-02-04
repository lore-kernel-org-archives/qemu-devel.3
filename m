Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8862E9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1z-0007xI-4x; Wed, 04 Feb 2026 11:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vng1x-0007q8-BY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:47:05 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vng1t-0004gp-Pc
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:47:05 -0500
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 614FUmtW1929252; Wed, 4 Feb 2026 16:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=jVwDLOLPhACg9u2iiPZnVbJC4FN6IzulWXAXpMUFOU4=; b=
 RSo6rPgkfRzSdql12zTIOBiEe62bfnweb9P+DJEgcQmRQeTQINKM1BUDU4pXpWfW
 U7XcxT7A1Mw4IFc9oNqscSs8x5J70tHKOhwC3TwlJJr8uBQ02b4NmFYVo7Fr390r
 ts+ifDQHUMwKZoef8yO8WQX4v+BfDcOAseyT3wKFeRSEbmVuhPBU9izWDE4INl3q
 QzHSRmAI9AFZvW+gcNHhu+u/Ivn37JlEqghJ8u3/vrRpLSmAqyDy1RNJC2L6WEs9
 25VXq7qiEB0E5luqKvToH68dplCeY4lVLu/UvGQVvGvsBURCDze0JlVM/4q9mfe9
 55Ql47A4eadXoqvP6mNkyw==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4c3wtf8cea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 16:46:46 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 614G5gwS001008; Wed, 4 Feb 2026 11:46:45 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4c1dy3eetv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 11:46:45 -0500
Received: from ustx2ex-dag4mb5.msg.corp.akamai.com (172.27.50.204) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Feb 2026 08:46:45 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb5.msg.corp.akamai.com (172.27.50.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Feb 2026 08:46:44 -0800
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 4 Feb 2026 08:46:44 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by BY5PR17MB3924.namprd17.prod.outlook.com (2603:10b6:a03:235::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 16:46:43 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 16:46:43 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "leiyang@redhat.com" <leiyang@redhat.com>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v10 6/8] net/tap: support backend-transfer migration
Thread-Topic: [PATCH v10 6/8] net/tap: support backend-transfer migration
Thread-Index: AQHck5bFSBiTRdE6BEuf/w2SsDM0T7VycK4A
Date: Wed, 4 Feb 2026 16:46:43 +0000
Message-ID: <080D4BAD-554D-4B47-A1FE-92F0AAE141B8@akamai.com>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-7-vsementsov@yandex-team.ru>
In-Reply-To: <20260201162001.296328-7-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|BY5PR17MB3924:EE_
x-ms-office365-filtering-correlation-id: 3df3e17a-38d5-4c1d-206c-08de640cfa3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cnFFWVlpZTJiUmQ4dDEycksxTmNVZGVZZTNUZXJ0OXFhQUE3eFR5RFVjOEJO?=
 =?utf-8?B?TmFaZGRScEt2cVp2STJKd2JqbFZvMVBESDFleFZjRS95anRuY0hnSHRJS0RV?=
 =?utf-8?B?djJQQ1NrRitUZThmRmRIRjdNY0o2cDdrVGRQRWpsSS9qcUdNaGU3TDNzdnY1?=
 =?utf-8?B?c1JZbEQybGF5MnhtVEJ3QlF2bUJKUHNXZEhVN0R5ckZ2aS95cndlN0RNZTl5?=
 =?utf-8?B?Tjk0ZWsvWDk5dHFNeHAycWVRU3RMNEg3S1gzT3pXWGJJR3U0N0lGV2RzS29J?=
 =?utf-8?B?MTJEazNHeVFxWG10di8yMEV1cWZOQ0JlSHR2N3FjQ1FvcWwvcWRjTjhtQVkz?=
 =?utf-8?B?VHU3T0Ezd215OEc4bUg1WkVjb0VVQzBBQ3JzUDJETlQwa3B2QktUNllQWjZK?=
 =?utf-8?B?MDZSWVQ2TjRlM1VIQXNlckJCeXpRTXRWQWQ1Njg3S2doSFZDcElBUlVRNnlo?=
 =?utf-8?B?MFVrV1RNbG5JdTBBTm1wZVd6SnhNTHNyc2FVSDlYNmphWEd6ZE5JOWxrOXJo?=
 =?utf-8?B?dHZRRUNRNE5EUVNsekJPWlI5aU83c3RlL2dLVjBUVFljQ3BKS3VqT2VPY0h3?=
 =?utf-8?B?UHRhUmVscFFRMzMrcDNWbzN6QkZSZmpDMUVxaytNUXhUNGZsVGNScTFiTmJE?=
 =?utf-8?B?SGtFM2ZyT05RSFpxN2ZRV2pBWlFnZlFVUHJTQzl5YklSUTY1MjYxempKa1p6?=
 =?utf-8?B?TkRxWHoxMGhhMVhJdGhDZVd4bW9mUUhyaWZsRGdLclNYbXR1N3ViaVBidGxV?=
 =?utf-8?B?ZnZ3RGs2TUlrdHBCV3dvZlZCYnkwV1NveEdKa1REQ0xra0JOT0V2MkE0c1R6?=
 =?utf-8?B?dUNyY3dGRjhQeFV4LytNenBnR0xKSWEyTi9UWnJnQzRLT2NVTll5WUFyRmZO?=
 =?utf-8?B?dy9nTXQ4elZJWUpScGI2Tm4rdTBvUk0xYWlMWGE2TmxEQmV1Vlo0bXNvVmhi?=
 =?utf-8?B?Nm9WRjVLaUFUU0g5MUVNc3hNOUttNFlNUlBaYmJUcjNsd3V3MkF0TjZDdUQ2?=
 =?utf-8?B?cW5PakF1M1VOZmY2V003T0JUcFFBdFRWajZjeTlmaUNLTWxGZGpsd2ZkaDhF?=
 =?utf-8?B?UHB5a3VyVERZckVoaFVTMWtpRE1qUzg5MFBZRWRmV2JEN3NJL3BCbEJLUWJX?=
 =?utf-8?B?dkl0eDFtTnl4RGc3MjZWYjJoZGVMSnBxYTVLN1AzaVBibVRPN3gySi9iZjA0?=
 =?utf-8?B?MmV4TFBzTnRiQ1Bqb2tzZGFjMnJ4OGd6WEtRMEM0NnZiZ2V4U1dRdUJIYlJN?=
 =?utf-8?B?VjhRZTRsNXgrUWFqU2l4Q3RBWDlscUU4QkhSNWxESW9ESmFkUVBlODJMNk5Y?=
 =?utf-8?B?dStDalpjK3dRcVF5M2JsTVJuU29nTUhoejFFeVg1amRnSFFZRysyeGFVeXd3?=
 =?utf-8?B?akUwOThwSkhjNG9Jeld2YnJEejRvaHlRYXVFK2U3V1lkYjB5QS9wZTFPRUxW?=
 =?utf-8?B?U3ZVNlBGckhIMXh5dkFEV2g4WGVZSEFEVVVrcTM5RTlhTDNOOURualpOYTQy?=
 =?utf-8?B?U0srR3Ewd2dKM0ljb0R4RUpvMy9mMlkwSUhzaGxTRTcyUjN6ODRFYTFoT0NY?=
 =?utf-8?B?UkJxWndQNGhSYWt1bnIvTitDZWFWa0RMaVk1YUdRQWNjN3lMdEtNUU9lTW51?=
 =?utf-8?B?Z3B4TDNmZWNoNU1vaXAva3hRVGxoRlQ5VExKemNZaFpwQ1ppUW16bWpWenRs?=
 =?utf-8?B?dFF4VkZTVXpBb3FJL0UrRjRIa2ZYWTc0OUlnRkpGUUN2Sk9WODFsRFNZUllp?=
 =?utf-8?B?KzQ2RnVnQUMwVWJoWVk0cUhYVFFyN0taVXg0UG1GUGxVdkx0QnQ5K0pkZHQ2?=
 =?utf-8?B?VU5Wc0g1R0swZnNzM0R2Zm5uZ1VqSFIrbFNrbk1SY2RyLzZPY3RNNG1IUnlB?=
 =?utf-8?B?SXBHWW0vMklxV2xGd3gzNEFTYkp6MUp1aW5iYnNnV3JVWDRGVHJjQkJSeWdZ?=
 =?utf-8?B?VUNxUFJDck5nb2pnOWJ0NGhLNktGTmdmL1VvSy84cGJFN0ljY3QyVmpreFpF?=
 =?utf-8?B?RDRrM25LSTBKeHlCaTdSNGdhOE84TFgxMFRObUw1UnVqRU5JS0NqMXkzVjhq?=
 =?utf-8?B?eW10UkV2Q0NVM011eitxZnpsL0s2UjZDZzBrMDhkNGhZSGZQVlJZN3dKMy95?=
 =?utf-8?B?amJob0tQalhGRjRvckNzVkl3OUp1V3k3Nm1VeXgvVHptbkZMdStnMFZMTXZv?=
 =?utf-8?Q?IxWevv8sosGfJbhwYzt5Rzs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2VQWmNycVBYcXlnNzkzRUVZc0h2SEFyL2o1YXlhdUMzNjBkRDNiaGRSaVlS?=
 =?utf-8?B?VWtuUzduNmlFY1F6NFZrUHQrSC9lWmFJcFJQVUZXTXl3eS9tbHZ5MzBSTkZT?=
 =?utf-8?B?amw2QWY3dUJLN1h2OG1oK2hqdm5TREZjMk5CZ1I1d0NUY2lLRnBrUkxoR3hz?=
 =?utf-8?B?MkxYM3JVUnY1NnJwYyt0SzNMbUVVaTI5eDNGMmRJQzMzZm5iUXNjTnBkaWJq?=
 =?utf-8?B?bkZZb2V2MktqQmxWQi8xckZrUWN4QkE0Nlh4TC9TQ2hMUjg4YkptVHMzSW0w?=
 =?utf-8?B?d0dtcHVqNGYvb0NhampCR3Avb01OYWI1bWk0WGZtYWdtbk5OM0pjZnArYkFa?=
 =?utf-8?B?YlM0eThTcVc4R3hRSkJLajhxTXVDM3R2VllGajVDUUF6QVlWTzNhN010MFdu?=
 =?utf-8?B?WERGL0JkSDBhZ3dwa1pOOCttZXpWTFpvK0xHQzRUUXJJVDFrTjhobXVXb0o0?=
 =?utf-8?B?NXJtSVB5TFAyeXBFQUlDTGdway8vMEYwRTV3OTNSRW1rVHBIM1VzVGlrRG54?=
 =?utf-8?B?VW4rdUdUcnFwY1VjNlV3LzZJeHdUQnFIdUhkcXFuZ084bDBzb2g0VWpDanFh?=
 =?utf-8?B?RFRsd29LdlR6MU4xZzF0ZTVuZzZNTmFVckRpcVJaSzY1WmFCNVBxUE93K1VV?=
 =?utf-8?B?YVMyQkhKQmROaEk3Zmw1VFAvNkZGZmdhN2xmK0VZTTBCL0I0ZWIxelRxNC9n?=
 =?utf-8?B?TEZpSUpwL1F4cGRHUTlBNk1FR0pzL1huY1JHd2hsM0ZoYVpHSTEzUEh6RjNw?=
 =?utf-8?B?eURRb0RUQndsUFVSczFMekNzNXREZU9rQXhCZnhyaDRMeVZIMWRibzZuZVAz?=
 =?utf-8?B?cjBDYjRzbTdhdDdzSFJUbWxWRlc4b2dPT0twTXBzMFhBTldScnFFRUVQdUR0?=
 =?utf-8?B?NkJKRlpvYllKMklOaitrTTVpUkhsRnIrSmNvdDNnUGFqcTQ2S2l1Y3Q1UG5m?=
 =?utf-8?B?V3d1VHU0a3dIQUtVYWpwNjMrTUFWdmFLZ0Qyak1vaURLcHc4Tms0b09VbGt4?=
 =?utf-8?B?OTVkWDNUcVJiNVBWdXFoYlJVUURUT1ZKeVVCc2RrYy9nSDFXZFh5cWNYbnh6?=
 =?utf-8?B?S2NGL1U3WnFKK2E2ZU1iaWQwWlF6YnBtek1mVkhrWjFNRVgyUXI1aDhhMk1q?=
 =?utf-8?B?NlZ1VThaVHNkUnNsTkJzcG1KQW11RXVFWU9BS0t5eUdueWluRjJaQ2pBeFRa?=
 =?utf-8?B?ZjBYMmVubFc2Ui9ldUxJcm9heVQwenpiKzhsb01VTC81MGlLQ1BtczczSXY5?=
 =?utf-8?B?MkthcVgvemNwYURrN1loSTZ2WnZEYVppcWI1Yk0wQ05tNmw1S3ZOZFcxUVAr?=
 =?utf-8?B?N01JeVp0SzN4MjQ3UlVrWk5xZG9hRk8yamJpTWI5aCtPWXB0U1FHZnVidnpo?=
 =?utf-8?B?bG8zdE5xc0Fsb0tSdC9xVlVEbFBMR3NJQlZXdzZFY3d4ZHA5SnU4U3l1ZzVE?=
 =?utf-8?B?MjA5ZXJzTndaNitlaEJyUE12SFpNRm1GK3VCSk5wT1JqNy9pQlp1V2dSaFlq?=
 =?utf-8?B?Zk8zS28zR3BWS1NOdFFrb2o5b1FuWDB3YmJCbGY1NG14VUQ0a2p5UjJKd2Z2?=
 =?utf-8?B?SFhka0ZTUUo5MjVsY3g4OGJvSTAxaEx5L05nM2UvdG1VM0lKb2RtVVVVanVn?=
 =?utf-8?B?VEprVGt2V1pzSnoyaDdGbnhGQ0ZvUkIyOXdxb05LbGUrNWdyc0l1ZUhFYm16?=
 =?utf-8?B?bG95TURiVXJqVXFPYVVvZUhjRXpUaWdUUnNMS0xMTmlTRngwUFZhVFdDVEwr?=
 =?utf-8?B?VHdjZGpPMjVVb0F1ZHRkcWJlamx5SW9CanZHdHUzVkU5U1VRczhLRXdSeTRa?=
 =?utf-8?B?WjFVNnRkdmNxMWRDU3pRYjh4aXppU01vNHhwbWZwT3loUk1CNlFWSUNER0Jn?=
 =?utf-8?B?S1o4QmN5YUJVeTFjalEyZUpYbUZWZzc4MkozcDJjV1oyNUJWWVJMcm1FYkZT?=
 =?utf-8?B?RHRxVXVSbDREMXpObHdkTXkzQ2VsUm5OVXArR2xjZTJ3WkpNMFprcVVUdjhk?=
 =?utf-8?B?RmhmRzVac01PV2daM1hFRHdYS1kxZXM0M01FNWdtQWxFTXZwMTFVUEpORmVW?=
 =?utf-8?B?a3E2MHRKTnJGdWtvZFBENXAwVDdydHhmMFY3UTBxT1FnL3c1U1llTUU5YzhF?=
 =?utf-8?B?MFUrYlJSWmxlZ01YMDBWRXhEWEJVMy9oa3JRbjVTTGlQR05TMDlwNW1BYWtw?=
 =?utf-8?B?RGxpM2w0cE1USXlrYk4wL3lGeHBXeVBhYldMYm91cFdieU1KdEZBdERMMk1Y?=
 =?utf-8?B?STJxbEpHb09qTFV2bTVsNWhUeHhjOUZhaldNQUt6a3k4UmZ3cTBTL2I0QXJB?=
 =?utf-8?B?VVcrNGNlVE4xRE5NTm9TQ1oxZ0RRZFRBUzNLKzBJYUp3ZTZ6Z1dlTVFsQ0Q3?=
 =?utf-8?Q?x2jaIA7pME189JY1dI8WMFLpv4+/3g0G7U5TPg4TPLCBV?=
x-ms-exchange-antispam-messagedata-1: Y3hdde5v2Wa8lg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4Ct9JejhaJEEjh/bzY0546qeFQUyLppKnE2rU4FGgduWVzj0sbnNhOd1PJbyl7WxIhy346BNOzFWEXJL4+iuXyuRNziDW1hr97Dkaapkzrypxii/kmcukWQ2ZJ4Tot9RJnJVMsNOTRIs79p0ailAfl+kpvScHfHmHXCcHTiL7mmMTQ7OeQW67asqNvQ47W+D5EJgA0dOl5CBhdt03Cq3nECYnN0qmlwMOgJTz+fk6GkumSZdtGKfiXp4vBcCN5X8jVR+fX0YZL/EbiOMe1R36bs9DG+vWeuC1ZJZjCB/IcLbCVucMHrMNlvt3nZk2aZqkiRnKPzp5TZ9n0UWVN3CA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/n2+DczXMtP3XVc0af8TQ7bFxYxBnAO/Y9PMLI5BQY=;
 b=EaRJqWggOtq298nuWpUF3s6gRboAfZjTT8b3vkr1aqfMWtegGTxHqVqZugMA1cNPm1d5+RTIROxmg9HYXgK84hLH6GOwgZwTvhr01KjVCCyXL9TEKWDmHgrjX51YXLyzFGLQ2iDsjKHdhEFFMeD1nurhK/1WjDNFEeyl5zRH77a62L6hg/5H1//OuJPfO2m5CFi78B8hp0CbEWTU5He81Pyy/yPkTCMDsSR6VHolRiGme/H1OugBC71p1dSvjdWOLrnLi8LVFzBUKaIz5IuHoPTMUKQRs19FNrviZ5MoFDRyl4jbu2ZrcW3gCxCQNVe3YD7p0vhJdMCnfWvDfIr25A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/n2+DczXMtP3XVc0af8TQ7bFxYxBnAO/Y9PMLI5BQY=;
 b=dl0/FEeDK2gjZ+nmhc+of8pyMi516G9x0p+ETFA90U5abSpUpeiJzHRGVERevTdYoDrlibdIR3cGJC9n6Avlmmqb1woXGNmvzlHUrDxF/cTtfAFYFUSPVOe4ZnIe26ksPI6vZdbjjemXueKyEiXheblcQn+DcKGZ6EvndMSpSNc=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3df3e17a-38d5-4c1d-206c-08de640cfa3c
x-ms-exchange-crosstenant-originalarrivaltime: 04 Feb 2026 16:46:43.3279 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 695HTk7ceJrYPZDWl8zJzet8nzLiQjnWmFH+XKtBB2uQhO3UrnJnMvDMm7PYKB8c+DWhLnN3ZaMteGyBUq0qCg==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB3924
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD690B80F2EE14CAA3B14C55D43903B@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=740 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfX77d1WTsd3H8r
 AABfHNPNMbBdiNMb432hDwLNrkjVepf8b/Iu5sUzHO+fbzfJLIWtFlDhNvhfdeBidftVndpC0xw
 7VsSAWIN/13J/x4XBoFCMFZc/Z5jLhSLmuUfSbArScyFjZIJfmYPJMJhlmbR6Q+8jqOlXZQx8xs
 4eC+mUkaI7dTBmmFqhFP0rvxirdKY/qWxgeL4aOj5AvIf7YMgcbRXx1Na9PsdpJ7vm0F0Q3L6Sr
 3uX4F2ppm9kab5WBC3pt+UkUpvQixZPBZuTOF4CTj1lKIQ1rREE8OQk7o+PGt25S6vC1EYQiK+e
 Lrjo+8VPL1pHjW9jZUl+uTcKtEPeln3qMaBZ1/n8yg7/cELzFGSXjaOJ9gU9sWDCGsf6DhwsUjO
 tGX6RzkUFsILz3JI7Cmhxo6RwAvud9o+g1lUNzdtjowGsActHjFPmMJlbHHgzJOcJgnS7qGqYMJ
 Xl5XZv3pc02/lb3UQgw==
X-Proofpoint-GUID: a8MiRamAv_IEcbuid9_FLGOm3O7DtGyB
X-Proofpoint-ORIG-GUID: a8MiRamAv_IEcbuid9_FLGOm3O7DtGyB
X-Authority-Analysis: v=2.4 cv=PoqergM3 c=1 sm=1 tr=0 ts=698377f6 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=sBb-JWfYDgHTVpADqkcA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040126
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

DQrvu79PbiAyLzEvMjYsIDExOjIxIEFNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSIg
PHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10ZWFt
LnJ1Pj4gd3JvdGU6DQoNCj4gKyBpZiAodGFwLT5pbmNvbWluZ19mZHMgJiYNCj4gKyAodGFwLT5m
ZCB8fCB0YXAtPmZkcyB8fCB0YXAtPmhlbHBlciB8fCB0YXAtPnNjcmlwdCB8fA0KPiArIHRhcC0+
ZG93bnNjcmlwdCkpIHsNCj4gKyBlcnJvcl9zZXRnKGVycnAsICJpbmNvbWluZy1mZHMgaXMgaW5j
b21wYXRpYmxlIHdpdGggIg0KPiArICJmZD0sIGZkcz0sIGhlbHBlcj0sIHNjcmlwdD0sIGRvd25z
Y3JpcHQ9Iik7DQo+ICsgcmV0dXJuIC0xOw0KPiArIH0NCg0KSXMgaXQgcG9zc2libGUgdG8gcmVs
YXggdGhpcyBjb25zdHJhaW50IGF0IGFsbD8gSWYgc28sIEkNCndvdWxkIHByZWZlciB0byBhbGxv
dyBzY3JpcHQ9IGFuZCBkb3duc2NyaXB0PSBwYXJhbWV0ZXJzDQp0byByZW1haW4gaW4gcGxhY2Uu
DQoNClRoYW5rcywNCiAgICAgICAgQmVuDQoNCg0K

