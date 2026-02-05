Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28035E83F1F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0it-0002fU-Jp; Thu, 05 Feb 2026 09:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vo0iq-0002fK-FU
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:52:44 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vo0io-0004cm-11
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:52:44 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6159MlfD1225411; Thu, 5 Feb 2026 14:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=nxcXrI93+8Qtov56goHT//Y4WxiyKHoEu0cIz0VPg4Q=; b=
 VeJKUR1fr+Y1kGu1fBkjmTB7bQZRqLRJk/lX2NfBHw8RIrCSsTJrbzhlsaad0dCx
 SBFtOQK3payvzr4Ul6hYOZP8Z5oBEfsVtV+X/WvWU/m/mDhMJK++Z2SboaoPb91/
 eUIahmmCbhstXdalwyRnF9x8QNFCFWoC89fNuR3yn6z9bvTT4HU65G8lAWIvOHar
 iqe18y9VsoiDaMGxFo7mU2gOTWRaJwLNH3NGwbZLgYPH3x0mJW0p47AfZjt1TuAi
 def6rRO30EQGqmsv08bM3O3YphMfn8daiDmNa/8EbXOm/gTWfvKE9PaKm3VE3PDm
 Qpii5nDNP8+sNquQjJ7aaw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4c3yeavn17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 14:52:29 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 615BI7cf006572; Thu, 5 Feb 2026 09:52:27 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4c1dy3c68k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 09:52:24 -0500
Received: from ustx2ex-dag4mb5.msg.corp.akamai.com (172.27.50.204) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Feb 2026 06:51:36 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb5.msg.corp.akamai.com (172.27.50.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Feb 2026 06:51:35 -0800
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 5 Feb 2026 06:51:35 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DS7PR17MB6710.namprd17.prod.outlook.com (2603:10b6:8:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 14:51:31 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:51:31 +0000
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
Thread-Index: AQHck5bFSBiTRdE6BEuf/w2SsDM0T7VycK4AgAFWbgCAABu3AA==
Date: Thu, 5 Feb 2026 14:51:30 +0000
Message-ID: <A101AC1F-8F53-4F7D-AC53-2B9E893413B4@akamai.com>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-7-vsementsov@yandex-team.ru>
 <080D4BAD-554D-4B47-A1FE-92F0AAE141B8@akamai.com>
 <f9fdd3d2-97c3-42a2-b34d-8a22951091d1@yandex-team.ru>
In-Reply-To: <f9fdd3d2-97c3-42a2-b34d-8a22951091d1@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DS7PR17MB6710:EE_
x-ms-office365-filtering-correlation-id: 3c723e94-388f-4e93-6a45-08de64c60c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TWppckFCanpFWE84eEloSHVKV0xQYnUyeU9BSG9LUUZUaFYyMHFzSUEySlZa?=
 =?utf-8?B?SldpU0Z2Wks1b1NrYXdFazJIMFpWQUZCUDVzbmR5c3pHWmhrVzlmZFIrQWJZ?=
 =?utf-8?B?Vjh3YzZrSVAyOERsZnpMWmFWYUQ0SFVISW5LK01rdG9CRmk4UUNTcitrVTU0?=
 =?utf-8?B?ckp1YVRuMU5SUDFkS3lLQUxFNkFOSkhoQ0NJdXc2V3d1VUZCNFpGR1MydFJQ?=
 =?utf-8?B?ekkxWGdtbnh5UHlCWWp2VXRCTVpiZUM4WnRsQks0ZzBKQVRQSDZtR21QdVJr?=
 =?utf-8?B?NEpsVnZRNmJpcmJ3ZE9qbDh2WHdSTWswamI0NTVieTZZREFCTWs4empvWnhs?=
 =?utf-8?B?ZWt3ckVKNHlNcE1EZHltc2dvL3h0NndQclpIeXRSUE5QbHd2RzRoWG5oaDI1?=
 =?utf-8?B?TysyUU5PdTBxYnpjeUdsNWdzUE1yUURid2V4Sm1jbmtNU0N2RU5GblRwNVl5?=
 =?utf-8?B?VjQvSXdZVmRjSFo0cXRETE5YTW1TWWV6TnpvSU85Rko0a05KbmNDKzNycVdY?=
 =?utf-8?B?UnpicFdHT3cxZUpnSFJpbXljV0FtclduajlQSFdTSjdMNXU2cVNKZWdSUTds?=
 =?utf-8?B?ODFEa1d2UXFOY3dYdUFhZkRaRExLY3dBSy9RbDdPVFVGbmRxbm5LVDVsc2Nj?=
 =?utf-8?B?K0N1R0J0eHZ6cGhKNE16WVdENlNLRDZES09NckxicmhUeDRydENjTXhRRzky?=
 =?utf-8?B?TlZLRlFhWlR6SUY1U0FJeEtzMU5GUWFZWE05ZDViQ3BubUhTaEpMWXgyYUs2?=
 =?utf-8?B?bi92S1Z2MmZ5bUQ5YVZwaTI4ODhqdDl2cnIzUUU2ZjZ2QVdMWENiUFNydnVq?=
 =?utf-8?B?a0dRZ3lWRklhaVZMU1pwdldUVzRnTlQyTmJyL29oeDNnQ1pWQW12bDNINW5j?=
 =?utf-8?B?RDVWVjR1dGE3NWd6cXNuYi83SVhxSVE2em9YWVZ1amZXa2hGOHVObGF0d0Uy?=
 =?utf-8?B?Ym1EbHlQOC9VOVhtajN3MDJMSzcwK1NsaFp1aXBZMVFsYkRJcEdKTGVrZmFI?=
 =?utf-8?B?bmZGZCtpNS9ZcXhMY1dzaFMxMmVKTThhUUJOREVodzV6d0o5ZmduNVcvQVRN?=
 =?utf-8?B?UzBaV0MyOXc4UjhPeDdVN002YnltUk9VS1UycUxLbVZteVl4cWx5TnZMYnNo?=
 =?utf-8?B?U1E1aExPRXJhSWlTc3JhSThjUUhZTnpRdVBTSmVDUkhSaXozR0xzbmsvd3Ur?=
 =?utf-8?B?SFlWb05VK1J1YlZZVmErUXJtanlDWnBQMkdIdytubDJpR1BndDgzWk96TjJr?=
 =?utf-8?B?ZG01Ky83Yzh4UkYzUGRTdDlvU1dCT1JyNGF1RmZUdW1tb0RRV1N3MUVnaDZh?=
 =?utf-8?B?UWxoa0RiMFFqTGV6emhETXRSald1U1hLZkNIOHpIVkF6MmpKc2dmbmZRbW16?=
 =?utf-8?B?MXh3UFhJb0x5WnRjK2pabzJlV09HaXVjd01BNlhnQVo1eFgwSTdlV0lwMWgr?=
 =?utf-8?B?elFzSjFKeE9EV2ZiRmZvbzNmTUFHRW9oWHZGazNEcFVxTVprd2FkOXRkSmhU?=
 =?utf-8?B?NjRuOEhiVXc0UnN5cUp2eXU3Tm9weEprNEhWQ3VsVkpCSE5OSzJhUlJIR00y?=
 =?utf-8?B?WGU2aUNyU0tRTDl4Ukk0bmtTZkFVWTF3ZkxMeUp1UXp2REx1RnF2VGEzaW1a?=
 =?utf-8?B?cGh5S3RYQnZXVjd1MUZPblZlYmViQUY0N1BFK3JDSjZHQW4ray90L2ZCOGxa?=
 =?utf-8?B?aXhhSG1Dc2VmaFQ4ZGhyTkZEelpyNS90ME94TzRsYTByU1dDUWxDRzdFQUly?=
 =?utf-8?B?eGFkWWxpYWJLOStNRmNOcXIwUlF3TTRXVGsvSStFTTVBWDhyK3pmMjFra1VS?=
 =?utf-8?B?UVRPUktjMXp2R3oxL3Q0ejE0Nm1WMTBtdndSZkV6Z2gyRE43SEo1VmhvZjlY?=
 =?utf-8?B?c0MwYXlkdStXb3ZmY3FQR0JkUDR2MWFVTG9VRHBQZmJJOUQ3QzFpQkgyd1Nq?=
 =?utf-8?B?aWtBc0kzeVJVYWJTc3BCWVY1TUQrb2orYmxkL1hDdm9FcjVoZ3gyOXh1MU5p?=
 =?utf-8?B?ek1BM3JreDNaNlQrYUJpS25hbGlSeFpUTDdSYkhubEVzbFVFSkpiWnQ5MG5P?=
 =?utf-8?B?NVZTbDhZTmNhNm0wMHRNRTlZOU5uNDNqQm1jMWplVDJ0TGdaSEVGam82MHRn?=
 =?utf-8?B?aXJyUHlNYWU1V05EZWZJcmEvbWQvbUVTd3U1OWF2UHFKQ2NHTkF4cmVJQXox?=
 =?utf-8?Q?B5r52L7nxrEznVvC4eGjIHY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEgyUFd4ekVPVTIvRXBGUDcxT3Q0ZWprRU5ScDdHTUZjd0Erc1A5UDcwMDRw?=
 =?utf-8?B?TlJieU13bGI0SmN1Q0dvRlJYeXFTMng2cE9aWUFUTWo5WlJpZm9rU0FIOVlI?=
 =?utf-8?B?cVUveUt4RWhXcHRmSmtjTGhOSVYyMndqV0NqUnpESU5WRVBjNW9MSWMyTU9R?=
 =?utf-8?B?ZGJYdzlZanNESGxIRE5ZbFhrU2xvSnVDcmpRU2xleWsvUld5SXRRMlJIY3Rx?=
 =?utf-8?B?d1ZnbTk3c1o1Tk44cFJYdldCZmZSckZTbGVZcldoaG5ZWEZicUc5bW84a0pn?=
 =?utf-8?B?TTJwY2FiY05mSERMYWpCMkVySjJ5NFllbDVhS1dNU2UvajNaNlZzSVBhR0Jq?=
 =?utf-8?B?RjFUdWthZldlSmNxYjF6endsVEZjaW5NcERlTUhoUHFmaW56NEpVZ2tjeTZF?=
 =?utf-8?B?WnRHOTZnTlVWa2NFNmIvczJ4UmZKeVpyTHVmd1paMDhsV2lvYUQ4S1VOaXBy?=
 =?utf-8?B?NVd2QWljZDRuQ2NDdnFNM1hYcVZqUFN6MU1iSE1DUVg4OWpzeVBZVGFyTFpL?=
 =?utf-8?B?OFFVZDB6Wlh5TjVvcEh3eHRPVkoxVEt4THNBU1lpZi8wbFFReUM4MzltRUFM?=
 =?utf-8?B?YmhrSVZKcW4vbzlHMmtST1lyVXRNNFMzZlRKVDk4ZG9JNm1STjJ3NVdkREJm?=
 =?utf-8?B?NGJiWEdJck5UdFFaWUFuNWpTZDRxUFlhaDQ5ZmxZR091elp6RXBGZld2b3RB?=
 =?utf-8?B?L0dyWEtpUGJ1SkNhRjVhdW9XMGx0ckJTRGFQczQzbTg2Q0UwTk9aK0lzUlNo?=
 =?utf-8?B?T1JqNitFOWpSeGtCU2Mwdk85ZjA1Y1N6U1FiNC85YkY0cVErUkY5WEQwVER5?=
 =?utf-8?B?WEJDR2dwdG8yMGNwMGRRU090a2ZuQWpXVU44VTgxQ2M2R2JZS0YxYTVRMlRX?=
 =?utf-8?B?eVZmcTNPVUUvNUlpdFFJS0ovaWg2UStNb2RTRVpibnU2VTFUS1RRTGdxakJ4?=
 =?utf-8?B?NS9UVk42Y0hqNng1VzBBMWFNd3ZPWllTc3pyV0VYRmk0dmpERDlqV1VZaC9i?=
 =?utf-8?B?dWp4cVRPVEhDSU4wZ0p3TG5INnZYbXNPZXJGN1h0dUVHRVBwRVZzQXlDLyt3?=
 =?utf-8?B?Q0FKRUp0cXhMZU55UDhXTzRzSTUrM0VlVGQyUVNaVDJJMVNKZWZmSDR3clF6?=
 =?utf-8?B?ZDV4TGhsbnJOSDlYQ3RMbkRDcHprZEx6OVFmdTJoMUtzeGNDV09CY0NlSFZ4?=
 =?utf-8?B?cERHc0FoZHFHMTRJUlJ6aTQ4dXRwZ1ZwQkFSOG9tTXFCTG1uaGNWV2IwMHIz?=
 =?utf-8?B?dS9NRDlXMnZYeTlZV0F4amtsc0JMTzcrN1RuYVpTSVl1ZXJMTmYzNmFoWE5B?=
 =?utf-8?B?YmdQU2VNSHhFcU1RQnNRSjlneXJNQjZrSFdoQWVSRTNNUGtjclE3L2RwekFp?=
 =?utf-8?B?c2tiY2pmeDVEWGl6L0xiczI2SlhibEplM1NrWEVjV0gyalhDQ3BIS0ZNV1Z5?=
 =?utf-8?B?L254dEdkeHhxaEVXSlhjWTNhTEo3Y3NBZ3hhaGQvZHFBUXRlSEJjdDRDazVr?=
 =?utf-8?B?WjZlNGRKcTRoWExBSmZYdFFkYjlZWjBleDhWZHY3c01GR0xJN1hEOU9iWXBI?=
 =?utf-8?B?d1ZKUTltdmxpWURkZUFqUnZ0anlVL3BiMGg1bHcxUWJabDlCbHgyTU5wRUNW?=
 =?utf-8?B?azBPcFFsMVpRWENNMmlYTnlXcEMwaVRKWENzZWN2ZW5SclErcFVFVWtLSE1z?=
 =?utf-8?B?TnNiYzhNNlk5V01FV3ZNMGl6VEtkS3NKd2l5MzRTMEN4dTlSRnZsN1F4TGE5?=
 =?utf-8?B?NFFUeCtVN2l4Q3lFSTRybjROVmpnNmxDSHRlZkpURXdFZmtBV2lJK2ZoSENo?=
 =?utf-8?B?UEpQSGpSSVZEUHhMdWNNUjdOdWhoQjJzcFZuOWpOMVNHM2RyandZRjBvQkp0?=
 =?utf-8?B?WVBNS0U4UDJzZXZXY0tzK1VzdnJtaE11ZE5LUE90Z0lyajRLTFZFOENLc2Nr?=
 =?utf-8?B?OTNCZDUxNWJnTHd5bUpob3d2TWZBU2FaZDVjT2JIem5NbkthdmZFVXI3aU1h?=
 =?utf-8?B?RFowMzZSSnBIMUVOMk1ia2haOUJQMCtNb0RZTUNKTW1hdkhTNjlxc0RUZW5h?=
 =?utf-8?B?a1pwNVVZcFo3UnlISDNudEJFeFlhT0RTY0FBelpNVjhQU2JYWDZ3bHFSN1FG?=
 =?utf-8?B?T3hUcWFmcGFWbEIyK3crUi9KUTErWTAzODVmMDhkem9NYUJoRzJXZTB4NUlY?=
 =?utf-8?B?S3VaSEFqaklrSFFFVmRBK0xpY2poWEFMVTRKbXdtbXVLMElXbkw1R0lLNnZo?=
 =?utf-8?B?UUxTa2pWb0FmenZZUGRJenFPUVNNazhVVk5Uc0lDQ1JQLzUreVhiWEFGbllO?=
 =?utf-8?B?eUFEQmdvKzEzdkZxZklXWEdaaDFuOFBlTjdBY0tMbDFkWGJuRXFnWnFybzNX?=
 =?utf-8?Q?dmJqegmzGJPaHvZB8YMAyapkduwBMZT+7wfK3bbpTu3uw?=
x-ms-exchange-antispam-messagedata-1: juL9hrsj4j1RUw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwG1FRfv9cAj59as2hHmcVvl1Ju6vrJ2XHW8HfeYv4nFyg3vZnaLVdCdwxt8aUNOJgmoCh+FZbQ4uWm5LYpHHWgWvGg2QrkehTY8GwozGIte6ux08yQQLtO+D+OcT8obJNfEbfLJK8KvGwUg8Lpzm+nzYnw61Tv70/2DGNEKAG3NZRaPjdX8SPHO/D5Evak8Tmt4vS/XAfXnQJwq1z3Ty3s5gkXCXFFYsT3BnaCrURZ/Mi+5Zo5z17g+1pzg0dkUCiD3YpIhux1BO/Kjy+0WQXFtWqP7CTng6Zusni0r4SmSnAKlru+XI7g4g3IjPY/E7nuEScbiCvMXXztO5jHfdA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVF1212g+2sCF80Hf9Vh6Vc/eoyCOf1Ma/cFqCJSr7w=;
 b=vX1L033rXX9y+1BXblEhAv/SALXZ5xtbpAO5oDVchXbL3xI4WdCf+j6CZHQ0AIW1xm53lAYxj3ffynVMKsksHdc15Zk+fJQ+yn+mRbvwH2Qg6mzRIRyotVot4lPA25KzA62LIw0wcUPKLUtzz0NnJpdNosHA+rxlC359TciGEFaMaWDg8n2cvo8N6MBK/LsoEhm7E7t1dMbLMAyPqQ+v5AwyzlLISSmpqOVq3IyVZ9yBe5IN9xDaaniZdC/H0dzXUuwx6d5xYDtUBCzEpYYy5GzPQtWLQ0bRhAjV4HipxCjkwr0h5togahCsbhKW8MgRqTzsypOuJH2jtGZp5h2ffg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVF1212g+2sCF80Hf9Vh6Vc/eoyCOf1Ma/cFqCJSr7w=;
 b=Lb783pTzF9jhH36UYH6owDgqvKek7XNpT0A/ZuWf1TvpITUKBXkbsQM6BLN3uRpYo2Y9q7wab/o6qsL8KPAzZGj/ypqDEQK9MWYzzSl+7aIpLa/7w6rpqO2Dj3dFHsBIB+buPY+FsLeElNbwE+U+InYxOItLa7XgjJV+RtNcIwY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3c723e94-388f-4e93-6a45-08de64c60c86
x-ms-exchange-crosstenant-originalarrivaltime: 05 Feb 2026 14:51:30.9373 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: z2JpPZX+VOt1qShPE76xzEtbuKmjXWbfzg/O66XSpe43w7WN0GOS9MmucKIQDclfmA4BZAr5c1oO6k4Hy9lXOw==
x-ms-exchange-transport-crosstenantheadersstamped: DS7PR17MB6710
Content-Type: text/plain; charset="utf-8"
Content-ID: <555D3C69AAE04B4BABFC60F6B171B5CF@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExMiBTYWx0ZWRfX+qlu4SdXMv/x
 KLrCb9jFOh+BVntntuHdSe6bV2qbTNcrAt6m+33PK7/uN+Rw6fEjD66vlDKowBgAKimkS+QvWCc
 BoZEJdLrgNoAO8W9vIP2zIlGfKud3G2HuFK4ZW10YmoEN3kDiBk8M0Ljb9vUon04slzQcLJgchz
 Mcx3Pzrz3JeeMLljXSZ/xBgfgpmfOWp1FTKfZuDVWbrHvsLQNMD0YMhBk1HRcwvoN0gkGxIZ49J
 0TYj+/WZHFQk6YqaPUvquKprmaIx6Ac0tZDfzOgG0soog6gFw4PFQw1TubhmPJD5S8EKXbN60le
 ED0wiJw+Ww4sivwyduWeo2TLmhez8+HmKfcjSm5/RAs5Z+yyt83UbgfTD2UNyqjN9GxP1QaqPlg
 G0tk27IRtOqw6HPNRAHHNkMPBp4CPHSYhgac719zaR6Z0q3cCnWHRVZX8BCegC9PLcVJKLopgOQ
 e0vaNNQ4LIhj/GCoPyw==
X-Proofpoint-GUID: x9pXirOF3eBrZIJxmMNTu0YNX40GX44n
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6984aead cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=0f1Q82wdpnYgcF2vGlMA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: x9pXirOF3eBrZIJxmMNTu0YNX40GX44n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050112
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQrvu79PbiAyLzUvMjYsIDM6MTIgQU0sICJWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IiA8
dnNlbWVudHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0u
cnU+PiB3cm90ZToNCg0KT24gMDQuMDIuMjYgMTk6NDYsIENoYW5leSwgQmVuIHdyb3RlOg0KPg0K
Pg0KPiBJcyBpdCBwb3NzaWJsZSB0byByZWxheCB0aGlzIGNvbnN0cmFpbnQgYXQgYWxsPyBJZiBz
bywgSQ0KPiB3b3VsZCBwcmVmZXIgdG8gYWxsb3cgc2NyaXB0PSBhbmQgZG93bnNjcmlwdD0gcGFy
YW1ldGVycw0KPiB0byByZW1haW4gaW4gcGxhY2UuDQo+DQo+DQo+IFRoYXQgcG9zc2libGUsIGJ1
dCB0aGlzIHJlcXVpcmVzIHNvbWUgYWRkaXRpb25hbCBsb2dpYyBJIHRoaW5rLg0KPg0KPg0KPiBX
aGF0IGlmIG1pZ3JhdGlvbiBmYWlscz8gV2hvIHNob3VsZCBjYWxsIGRvd25zY3JpcHQ/IE1pZ3Jh
dGlvbg0KPiBtYXkgYmUgc3VjY2Vzc2Z1bCBvbiBzb3VyY2UsIGFuZCBmYWlsIG9uIHRhcmdldC4u
IEluIHRoaXMgY2FzZSwNCj4gbWFuYWdlbWVudCB0b29sIHVzdWFsbHkgcmVzdW1lIHN0b3BwZWQg
c291cmNlLiBBbmQgaW4gdGhpcyBjYXNlDQo+IHNvdXJjZSBzaG91bGQgZ2V0IGFnYWluIGEgcmVz
cG9uc2liaWxpdHkgdG8gY2FsbCBkb3duc2NyaXB0Lg0KDQpIbW0uLi4gSWYgc2NyaXB0IGFuZCBk
b3duc2NyaXB0IGFyZSBub3Qgc2V0LCB0aGV5IGRlZmF1bHQgdG8NCi9ldGMvcWVtdS1pZnVwIGFu
ZCAvZXRjL3FlbXUtaWZkb3duLiBUbyBkaXNhYmxlIHRoZW0NCmFsdG9nZXRoZXIgeW91IG11c3Qg
cGFzcyBzY3JpcHQ9bm8sZG93bnNjcmlwdD1ubywgd2hpY2gNCmlzIG5vdCBjdXJyZW50bHkgcG9z
c2libGUgd2l0aCB0aGlzIHBhdGNoLg0KDQo+IFNvLCBJIHRoaW5rIGl0IHNob3VsZCBiZSBhZGRp
dGlvbmFsIHBhdGNoIG9uIHRvcCwgd2hpY2ggaW50cm9kdWNlDQo+IHN1cHBvcnQgZm9yIHNjcmlw
dC9kb3duc2NyaXB0IHRvZ2V0aGVyIHdpdGggYmFja2VuZC10cmFuc2Zlci4NCg0KV291bGQgaXQg
YmUgcG9zc2libGUgdG8gYXQgbGVhc3Qgc3VwcG9ydCBzY3JpcHQ9bm8sZG93bnNjcmlwdD1ubyBh
cw0KcGFydCBvZiB0aGlzIHBhdGNoPyBXZSBtYXkgd2FudCB0byByZXF1aXJlIGl0IGJlY2F1c2Ug
aXQgc291bmRzIGxpa2UNCndlIGRvbid0IGhhdmUgdGhlIGxvZ2ljIHRvIGNhbGwgcWVtdS1pZnVw
IGFuZCBxZW11LWlmZG93biBjb3JyZWN0bHkNCmluIHRoZSBldmVudCBvZiBhIGZhaWx1cmUuDQoN
ClRoYW5rcywNCiAgICAgICAgQmVuDQoNCg==

