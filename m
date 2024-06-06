Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0936C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF89u-0006Nb-Ch; Thu, 06 Jun 2024 04:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sF89s-0006NK-0I
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:07:40 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sF89p-0006rP-KJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1717661258; x=1749197258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8hauvSATTL1MbTxHoU4bRMNii3TJLSMBEw0HM8tuLuo=;
 b=SNgjrvvt1DzefSmw39gvPKyuO7Fi2v7RdyoZBPOGL2XZ7DE5lhzx8MwJ
 QxmPZ+aNKtlwH7Xy8VD4PehCv89pZmtkBFP67HJtdRx2BNg8VBbKe7QU0
 1s5Ix+xGeu+lY4cJ/Kk5NQ0BuUfFsXZtKfwvvTzuWN5iHHe95QaJ/cDUj
 JC+ymATt8q7R94ooDXPs4y0SUs9dwGN9ssCVOX9VZkxY2NUwRdOQXzU31
 Pl0cKyWItJRH1OL7fRSiWr0/Wb7HHPY1jImzNxzrYL1/ccmynnDjmdm1w
 h6lKxIFX5zjaDtr/E6WNp/dl2PYLQVhEhLl5xtAeMUJOKGQ99b6khWguh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="121517663"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; d="scan'208";a="121517663"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 17:07:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSF0195K0yQCe6hgByg1UZLq3jv1xxnIPUui5P4NFlt6iIVWhFz8udAF8oEa+gIgZRullo5MLVe5A7la3pUSX6t1iPewyU8hOIjazuIMlxuzwZicux5rG/Trk0RUs/hhgsuzY3Pawac8mDlZBA+B8ui3XyAT24fsSU6TkVqXzskATovQ5OmOY0h2mW/OUYnJaFxdzjUVxvwRyZA+FNg83/EE0BIDR7RRflr20jEFUizQvHQJY/+5svrudtfdMy7wvpiqvRvBhwdZbIlWYIAonbCMdUCVgRlElIKehvwgzJpuNtLiK2X+fXdcXPaY94Z8nhiOjqJrsiKaYhYtLBOqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9Z9Y3GpU3GgGoNs63FTEhm3sieo7a8UtXufLWV8KXw=;
 b=LYstUjSzzaOfBE0Va1zxm4moF5Xh1cRTZzhhiJhCRm2tZ/Xos9TVykgq1D81LgzlyJr13wI86dpqJaywtzQpZJdS2/H8xZGIbppm0dVkuImcClHeJot/66WFQWlYVsb0F0e0bzMmJxl+93INwagwtXKk8VO2k4oXxDUelXH2jpYGvExY08xVlEgC8QAGXo4jI50hHcdBNr2K/WEtUASzJK7NM4EZu5AHAs6hgUDupF80tM7PTtYaVmMVew/JEeuIgJSuMWe37sWCyYDb9ZVdScvMVZMWfGR/X6tlAqXL7iUXeqk6W7Pqz43e/shHxECjMGayh/4u0Bo6g31THv4Hjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB5950.jpnprd01.prod.outlook.com (2603:1096:400:41::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:07:27 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:07:27 +0000
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaoOInstysbz+9jUG5HE3z+Vg/FrGmOFTwgBRW0sA=
Date: Thu, 6 Jun 2024 08:07:27 +0000
Message-ID: <OSZPR01MB6453195EADF10E5D7EB35B4B8DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453BEE69D709FAD5F5431228DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB6453BEE69D709FAD5F5431228DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=06a68195-6701-4b1d-933f-31f528628acb;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-06T08:06:49Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB5950:EE_
x-ms-office365-filtering-correlation-id: fc9bbca5-c82c-47f0-24d5-08dc85ffb4a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|366007|1580799018|38070700009; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?ZmVYdmdlM3RaajZuc2VGcm9tYUxJVFRHeitjM0x4WUN5TnB4OEZzNjBW?=
 =?iso-2022-jp?B?OXhlY2xnOWFtZUpiTi9hTFQ0Q0lQTHljazVxSVN2WXFYL2NMcU8vbjFq?=
 =?iso-2022-jp?B?TEFtZnhMS1R5b1NNL2xJbEVCbzRLSng1ZU96Rm1FMDdBa0FPdzJrYytS?=
 =?iso-2022-jp?B?dGFkOTl0R2FDRGlpZTRiVmFFdVE2TW1sK2ZPZU12ejdiaG42UW1JcGpK?=
 =?iso-2022-jp?B?cndrVWIwM0dqSlBqYVpsMXhKOHFuQlI4NndabkVXaDJDMWZOT0JiRDVq?=
 =?iso-2022-jp?B?bGw0U1dqKzhJY0I4TXBZVkNmb1g4VXZVSXZBQU9WUEQ5SDlESi9ROVRX?=
 =?iso-2022-jp?B?Q3VIOUZ0S290VWNvQXlseFBCVkpGMEl1VDBGVDNzTUZBbWFXL3JkdkxS?=
 =?iso-2022-jp?B?OXJ4L0t4a0xTQnNMUHc5TW03a1U2cHBaend2RnB1Vm95dzNoakRHeHBr?=
 =?iso-2022-jp?B?dk9xVWY2a0Y0ZjJjdTJYK1ZuSm8zUFc0dlVMU05sT0o5STlvdnArM1Rq?=
 =?iso-2022-jp?B?SGRRRkRtaHVnRW50ZVJrdXNYRzJJK2lreWtSc2RWblhnVmlQaDlTa2h6?=
 =?iso-2022-jp?B?amRrWTV2ZkJ0a0NmOURvdTM5R3RWT0NlSXdJbGRBeTBGNFljZ3Rha3hD?=
 =?iso-2022-jp?B?Vi9VVm0zRUFseks3STNvd25GY2pLOENkbE1tRC92bmI1b0o5cTRHTG1V?=
 =?iso-2022-jp?B?Z25POWNETkgyQ3krN0lHdDF2bWJ1RTQvMGdyRXhxbklVL01SS0dBeGd3?=
 =?iso-2022-jp?B?MTA5c1pnUEk1eC9sR29PdDhXVUg3NkhSU3JSamYwR3VuaW0rSHhzWXdu?=
 =?iso-2022-jp?B?cGRSb3g0ejRDVzJmcThBSkwwWmFaU3lucEkzaUtYVVJxS2J2MlhocUNF?=
 =?iso-2022-jp?B?MTJzbGtyaUdNOTF2clYyd3pFRVN0eHUzNDV0NnU2WGZLVjk2QU1MTUFD?=
 =?iso-2022-jp?B?Z3cyWXBINUF0aDZyQ1NXRGlSSkZsYlBKdlU5akQ4YlVUVHcwa29FUHdw?=
 =?iso-2022-jp?B?OW9lOUFZTVNzWkR3RWo5L3F6MHJXanJoR1VGcWp3bHpZUkMvbTJMNC9l?=
 =?iso-2022-jp?B?cENXekJ5dGVpdkVKNXI4WjNPVDNiajFjMlJWY2ZIdTRpeFBPVUF6ODlX?=
 =?iso-2022-jp?B?ZXNlVHRsY0p1aFE5d3kweHkwYSs3UkpzZ2J2UWkzRFNmVkpZbmp6T3JX?=
 =?iso-2022-jp?B?K3I2NTN0K3RLWXc5b2dTWXFCSktBTVI2dXBiQUU0OXk5TmFOY2cvNElG?=
 =?iso-2022-jp?B?ZHMrMDJmdGNxRFBqNGpyWnUyY1F3bzI1cWtvdlMyR2JhT21YajlhaVAw?=
 =?iso-2022-jp?B?bzZDbkF3ZzBxaXBnYUV1ZUFMNWxseHJuclRzUllZTmR2MzJkNjZUWGlO?=
 =?iso-2022-jp?B?WC9xSkFpVEd0dzFEY3BtMVIwaS9rUitIV284YVRaRkR0S0ZoaHV4SDFr?=
 =?iso-2022-jp?B?U2hHd1FGalkxNlJvd3Q5MVFWUTg2Y24reENVZ04xa21PWlIrNlVYcDBv?=
 =?iso-2022-jp?B?N1R6RkphMmtTSzVXVmtwck05aFdjdmRCWmFJUFdpSkFmUGJFRXdVVUQ3?=
 =?iso-2022-jp?B?QzFRMFBvTUEzL1ZZcHZUVmdVZ3pjNEhJVFhtWktsWHJBNGFHRHljNnpD?=
 =?iso-2022-jp?B?Z0xKUlVvVWIzcDlJeGlmcmtqWllmbHgwMEI3Z0Y5WDJyT1FrTjQ0Ulo3?=
 =?iso-2022-jp?B?YXc2emFJRXowZ1JQOUFmVkx2cTN3NEc4N2VJMnFYUTZmUHZ3RjNITXdV?=
 =?iso-2022-jp?B?MzNNRjJvVy85SHNPV0QvMWMyc2tsSUJKSXdEUXZqYVlteHF0MnpkQ0Rq?=
 =?iso-2022-jp?B?eU9nRm5LRlAwU1BoWmhQY0pYSERoRjJOTmhoelFGTk05OWZsdnF2QzFn?=
 =?iso-2022-jp?B?SWtZcWR5STVXb2lhV1ZSeXlKMk95Qi9rY2liUGZ4NXc4djU3UXlza20w?=
 =?iso-2022-jp?B?SFVmQi9NclN1S2ZoUCt6d3VlSEJBY0tVR0dpSDUxRldIMXIyMkZEUzhx?=
 =?iso-2022-jp?B?aHhXRVVQOHZla1ZzZVJyMjFiSzBPc2FjNnJIMVRjU3RKajh3eE9UMWxU?=
 =?iso-2022-jp?B?cnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TmVpbTZUUVhKYlVzZzJwc2c0cWlXUnBxM3R4UkpoYnVDK0FIa1lMK0E0?=
 =?iso-2022-jp?B?R0d1Z1hoRXR6dVBMbE42eTNIZVdZV1ErQmI5SmNnN3g5bUI2cDZNK0lS?=
 =?iso-2022-jp?B?eUtFbHFWUEhrRmNrMGJybkNoc1JFOWxVOTNUTmxMUmpmcVJXaW51cjlk?=
 =?iso-2022-jp?B?THpjMWRWTE9KZFZiTkExSnF6Q2JDNlNYN0dkOTVGWEJ6cUx3UmRJbnRW?=
 =?iso-2022-jp?B?eElIWUw3ZkpXZlN5L2lWcEEyM2dhclNwQWlBb0hXNUp3NGNadjFkeTlx?=
 =?iso-2022-jp?B?SkZQQTAyMjVFbXQ2bGRadStEYWhydC9ZZ2IxQVBURi8xNUF1MG9BNUJN?=
 =?iso-2022-jp?B?L1E4NEdoNThDcGtJdUZWOW9Wb3pvOXF3cmhKbUxzZlpzcGd0Q2wyZGg1?=
 =?iso-2022-jp?B?ekR5eFNsdW54WTZIWnNUUUVmbzYzdmxlTDhKS0F6Wld4cGdGUUpmc1o4?=
 =?iso-2022-jp?B?OUpWbE1ITFZXM3hyNmpPQXBmbjdzMkx2UUVnQ0xVL3UvZkZ1UnZjcm1J?=
 =?iso-2022-jp?B?U05GYkNlMHo5OVVuTEhGNHRjYUhLOTZwL1NKSjIyR0ZrcEZFbnJqVnRE?=
 =?iso-2022-jp?B?RFRrSDNiMzVPdHh6SkxKVDFQS0NTaXRwRFpoRVIzeFRqOFlBNDBXUHNl?=
 =?iso-2022-jp?B?UEFCWmk0U29XV3J5eUczTkg4RkQ1MC9oZG5pNWpGK2FHYnd5L0dGcUNM?=
 =?iso-2022-jp?B?UWdPQ3hrV3VPaFU0MlVUYXlEWHhrMnZDSG1YWHJ5M0w4M1h1SEh4TURi?=
 =?iso-2022-jp?B?Ny9zK0J2cWs4WEMwMTZVTjlDZFJFU05hYkRTY1VFRzgvZVlRTU83ZmJx?=
 =?iso-2022-jp?B?MTd6T21CbXlXMTk5Q1FkdXZYaktNRTNaS1BGWlJ3eXFaRVRNemFrTFhG?=
 =?iso-2022-jp?B?Q1pta1pBeCtjTVh1c1NuN2pjMlNjK3M1YlQxanFINGhjY2wvajUzcFdz?=
 =?iso-2022-jp?B?Z3V2TmQ3VUt1K3BMWnVWU1NvOXo5ZUlpdURXeWFvbm9KOWRnNmdsR3U0?=
 =?iso-2022-jp?B?OEhOSzZCRWd3QThMK1l3WFNOSENubG1Vek96VnJhNDNhajdBOFAya0wx?=
 =?iso-2022-jp?B?bDBnM0t1K1B6UUhsUytuRTUvWVpySHVDSUI5anlqaWthQ251dUMvOXZO?=
 =?iso-2022-jp?B?dDVqMlh3VVUzZTYxT1BvNWlDeHZjUjNFMlR5NDMvYkZFbmFmMi9VdXlo?=
 =?iso-2022-jp?B?MlJwbi9MQkRoZ25UWFBpV3U1VU94ZzNaa0EzbTF4OVYxcFdwOVRqcEpG?=
 =?iso-2022-jp?B?RzJlc3FLV3BqRStaVittMERKN0FSTkhWS0o1U3ZBTzdGek1yZmFZVGF1?=
 =?iso-2022-jp?B?UHc5elhHWDUvTWpDZWI4TWdQbGZEdTBJNnR3SkwvOENKejlCVWU2RWVx?=
 =?iso-2022-jp?B?NTVHd1hYc2pIc0lnV1htZ0NpNnU3bjdaQzVndlUrbFVPWit0dk1GbVhX?=
 =?iso-2022-jp?B?WGZ4Tk5ZVmNaUXJ4TlRoWHppUlJnalZhZ2ljdlYzRkJJaW5KTVdrVEM1?=
 =?iso-2022-jp?B?TVlLWkE4Q1RCRytFU282MXM4UGlZaFMwS1dDRFBwMUVJMnZBMzhiVisy?=
 =?iso-2022-jp?B?ZTlzK0E3TGQrcTk1cnc0TFovZE4zQ010QmpobXlsbyszbzJlSUFhNGVp?=
 =?iso-2022-jp?B?dXlIN3NpL3F1L0pzY3VqMy9rcG9SMDFtMTBjcHdRVEZaMEI4MlZ2UzJX?=
 =?iso-2022-jp?B?b2llMDZXV3Jsam9TcGN2SEJiTmFLTjFiRlNWNmVqSkc3OHJOZCtoc3Vy?=
 =?iso-2022-jp?B?L1pHZzFzaFVtV2QrbEc4QkVsMDR2Um1JRHRMRjZuQ3JXOFlCWFg0RWNI?=
 =?iso-2022-jp?B?ZTRNODg1aGhMQnZMUFVLRzZaVDVYVzdNNnRwNmRMNDkxb3JITWU3azRU?=
 =?iso-2022-jp?B?aElEYWtpMTcxTTdNWmtldkMxUGczSzlEdnU0ZVNheGMyalNWNmVSR3Nk?=
 =?iso-2022-jp?B?Z1FZMDFOTnB1eCtIakZJam84ZkFCNEpyY21jWUNiOCtjMTVjT2tTMFpa?=
 =?iso-2022-jp?B?ZlU0Y1JPS2lkbDR4NEpickIzcE9ObGRvMzRDdXZuT3FpYmtyQW9pVXVz?=
 =?iso-2022-jp?B?ZWg0NHp4aVRvZ3o0bE9yOXJKeU9BZS9ZdHdhTUtQNFNUOHBad2VHQmxQ?=
 =?iso-2022-jp?B?K2JlMG4xcnQyMDRvbjh2dDdpOVRBRVk3OEp2MlZqNW5ENWpRNWViZUc5?=
 =?iso-2022-jp?B?YStiaFZ5VkFnTUo5eTMyL2kzcFZPYmoxVkE2bUR0VkNWZGQzeVlVbHZ1?=
 =?iso-2022-jp?B?eWtBT3dZR1lQVGs0eTVHOTlKOGd1NDBOeWU0UWFuOWJmd2h1MDArMlVk?=
 =?iso-2022-jp?B?MndnNQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sF7zNp9N05QIp3elP1OQL8Q73Zq4OhtQvZv3dB68ACXeiCzaSNKbhyM8UJkiC6bsZP/wAAILHbpKk9gkxsnWeDaW5dCSvylpD5PikvbdKd3bsiJe6bHBpS/UMtDIiUSFcfFuoD3Lnd2gDWwi2wKdUO5uO2mktK/BR0MG1BSijx3fg/iszdCZBEvqljs1Jd+zj+PYysq/usXlvmJLcg+A5i7yoP4674Rg7Z+LOxnnNgU9Mc2aTiat4javClt5jfmYnJg+XZG6hR74W7Bvli8mAdxZxYLF6COel1ieM6/4BH7jmY/Xhc54PQUFK2YuIUziSzbT3vSKOqnCPUBjHzn+qLUASPiWUH2eSxTUEVp+Kac73P2E5zxqxr85P4fukmBmYsE1d1RYEnplwAJa6LpQYiicIu5RwjLtmboIGoSc0v1Iy7v37UqQ86cufoVTeF4gIicZ6EWgFUFAo8gAAJNYKAu1MHN/feQJnWt6nfWIbRrUULrbzFMSgNqSXZ45sH9ck9L+Vc6ppi1do87xhwwS/OQlsfke9K2Q/ti3WrL/Y1RQSA0wL+ke5ZdMkyQtIW4fo7NIqY34OxlwyH4EGzRwYoo/osb6NVRlAbgP3tYMRJkG88EiLoum4C2XkdOCXKh5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9bbca5-c82c-47f0-24d5-08dc85ffb4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:07:27.3657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmXBkyJmvZYaOYKEEvny3sB5ZioSmNsvzR/wsKnE6q7wG6USEsRIx8/EkeS57m0TS6RdTcRojEQhrPVy2iw8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5950
Received-SPF: pass client-ip=216.71.158.33;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping again.

> -----Original Message-----
> From: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Sent: Friday, May 24, 2024 5:31 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>;
> jonathan.cameron@huawei.com; fan.ni@samsung.com
> Cc: qemu-devel@nongnu.org
> Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave=
 ways
>=20
> ping.
>=20
> > -----Original Message-----
> > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > Sent: Wednesday, May 8, 2024 8:53 AM
> > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <ya=
oxt.fnst@fujitsu.com>
> > Subject: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave w=
ays
> >
> > Since the kernel does not check the interleave capability, a
> > 3-way, 6-way, 12-way or 16-way region can be create normally.
> >
> > Applications can access the memory of 16-way region normally because
> > qemu can convert hpa to dpa correctly for the power of 2 interleave
> > ways, after kernel implementing the check, this kind of region will
> > not be created any more.
> >
> > For non power of 2 interleave ways, applications could not access the
> > memory normally and may occur some unexpected behaviors, such as
> > segmentation fault.
> >
> > So implements this feature is needed.
> >
> > Link:
> >
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> > u.com/
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  hw/cxl/cxl-component-utils.c |  9 +++++++--
> >  hw/mem/cxl_type3.c           | 15 +++++++++++----
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.=
c
> > index cd116c0401..473895948b 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state,
> > uint32_t *write_msk,
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > INTERLEAVE_4K, 1);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> >                       POISON_ON_ERR_CAP, 0);
> > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 3_6_12_WAY, 0);
> > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 16_WAY,
> > 0);
> > +    if (type =3D=3D CXL2_TYPE3_DEVICE) {
> > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 3_6_12_WAY, 1);
> > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 16_WAY, 1);
> > +    } else {
> > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 3_6_12_WAY, 0);
> > +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > 16_WAY, 0);
> > +    }
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
> 0);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> >                       UIO_DECODER_COUNT, 0);
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 3e42490b6c..b755318838 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -804,10 +804,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwad=
dr
> > host_addr, uint64_t *dpa)
> >              continue;
> >          }
> >
> > -        *dpa =3D dpa_base +
> > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_of=
fset)
> > -              >> iw));
> > +        if (iw < 8) {
> > +            *dpa =3D dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > +                  >> iw));
> > +        } else {
> > +            *dpa =3D dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offs=
et)
> > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > +        }
> >
> >          return true;
> >      }
> > --
> > 2.37.3


