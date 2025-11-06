Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9787BCCFA0D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 01:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGoVx-0005mq-Ll; Wed, 05 Nov 2025 20:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vGoVv-0005m5-M3
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:10:11 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vGoVs-0002pW-RY
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1762391409; x=1793927409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RWmPEV9DOG2OEAndCYTuSDTUX+c8cBMeEdzM0m1j4LQ=;
 b=BtwflgqJHWo8r4aWigZycg4jPae0XRMxV2Ni5T3IDcGTe3y9jQqFVfqo
 LKjHHS1iMQtj0dvwSuYXabmpPxEQf4rRwnafgFzeggIyU184QpTlqlp7d
 ouCt13H0k7FvI8p0f7G/eUX5veWrvOwbLufxagJ1IzlsaXLXzw/8Zl+/V
 UVZyRG3dIRD1V6MkZSiDvptdg98dqTBewLrG3xwwb6U3Gx8/WSlmZZDz7
 KJklk5T/bY0kQwwe86aUIwdo7F2H0xpdLefcMxzQUy72ezrJSiHgaphp8
 P3RbwCN3ohiYyZSdOrB+Ubmq2azTMhqnmMbwpXuhA69UKVbp/3lGvOJ7J A==;
X-CSE-ConnectionGUID: dstyOvQTSD+GaUHlYbh7Dw==
X-CSE-MsgGUID: AY/qYp9IThCaZ1rzeRdeHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="173038986"
X-IronPort-AV: E=Sophos;i="6.19,283,1754924400"; d="scan'208";a="173038986"
Received: from mail-japanwestazon11010061.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.61])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 10:10:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWMFv1uEpygfmf21i5n5incQiOJ98ma7PV5fx7mX5dTzHPjIdNVuCWeE4Wri/YsZClYNMaqZ1sAewlRctsz9SBMHzpCOOrdXLuHjrx6WwkjkCbSXQ9pLHDKJu5EY8KBYEMGM9eobdzC0F0zqRuBBRe7iWLDRAkRkMSdzFyPNIvMZCGTHisekKGk55rPTLJuNuu58TtklRlCAt77G+oed3shOmFFu0PT4WT6auJj4YCc+LQ8kVzFiuFk7I1AcJGaNI88a7Y4th8VCaJVP19kRyV+jIr56MLQhys9y9/cFbuojHKkZXojm99mMsK8MULruLNufUQFL3c8Aa3pyHvJmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWmPEV9DOG2OEAndCYTuSDTUX+c8cBMeEdzM0m1j4LQ=;
 b=SJTCVdhxgyIPu52BRSfXT4bvBY/PRqRtN0AuOYCHMIIKqEE6lyKWZsD71byKtW6fLMYtcqvjSJs8uo6CpUnphmiaOtfzoVGrnG2WuRYCQNel7C/UPlnfiJdAALghqdneGoA9/QHRe3MHONAOSCG8vunBqN+gvkesxWWJ8QaKcBrX6gYwByGACjhK7WrFQ0ShY+lRd389V2yqRlsh9E5jFgUdRiYLwxtUsm9ZvzCH5W3+Uxf4yEUhmLpgC/oVDf2LMO5BOfxWL/s1BRrR7fwxlgSbgE/CfS3ZA0qVF7Uk0jerjq5S/sat5FTsVA+lnssmajBr8aQZu/ryfG/1mIsjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWmPEV9DOG2OEAndCYTuSDTUX+c8cBMeEdzM0m1j4LQ=;
 b=MVxSmMalixV79pLTScLgwtLZ2vf3tbkH9MmB7lOQNzbzIJCGtuwk5Aun0DUs4OVAq2O+Vb7w680R2C2aNx/dX5+Bp15Htp8yXLKpv7yfHd9EYcs3uPQUkO9KsDolYeZN3l9KTEmDbntTc93Zxd2C5p4sM3Bk4/MXe1ydNjDH6rzSA83Zxg4PVUzD16v+6olsiyRAe/zqSsuM3PKbOh0he5rTunEqtcFPASCsOtZl/YTHkIqRRDBI25OILjwdVbb39BcJ4KYz2+Jot7b4iELpSv09ukDPTeE/aVkc9HkPDS2dIXgZE447tzN93m6jBUAi7TtCIxwOATZSZFoPwJuHQQ==
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com (2603:1096:604:1ee::6)
 by TYWPR01MB11780.jpnprd01.prod.outlook.com (2603:1096:400:3fa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 01:09:58 +0000
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3]) by OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 01:09:58 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "zhangckid@gmail.com" <zhangckid@gmail.com>, 
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
Thread-Topic: [PATCH] migration: Fix transition to COLO state from precopy
Thread-Index: AQHcTSsla/c+RsLsE0mwSz30N5zPnbTkk34AgABF1IA=
Date: Thu, 6 Nov 2025 01:09:57 +0000
Message-ID: <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local>
In-Reply-To: <aQu6bDAA7hnIPg-y@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9851:EE_|TYWPR01MB11780:EE_
x-ms-office365-filtering-correlation-id: 58eabc1a-8d19-459d-b19c-08de1cd13416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bFpsa2JqWHkrVnhlM3ByTDFwZjBSUWMxNkdpTENhUEY0c3o5KzRyNzlLMTU5?=
 =?utf-8?B?ZEhqMjJLajUxQ1NkakVzaXdQYnZ0U096S1ZnNUJhRFJrb3FtdWJKbVZoQ0hD?=
 =?utf-8?B?RUROWm5wNk0vQm9tNiszeGJtSHZFZkpnTFNVblpVRnR6SGxsdEkxenZyaVJR?=
 =?utf-8?B?UHRlWWk4NjkvNFovWXlOUTVVKzdicWNYYzhaYTZmcThxVlhYZ0NSVHB3b2VJ?=
 =?utf-8?B?WHJ1THdsbkhqeDhhVzE2RnhENE4yTFBuSFJMcUhTa3hISjJnOVZ2NThoNXQr?=
 =?utf-8?B?N3huQzhHTUNQV1c0WFhmUm84d3E5UUsxbUVjUEMyM2JPQXhPK2RWb0w2d1lV?=
 =?utf-8?B?UkhlRUFXM20rekNxTFdoOHdVcDlNditNR0FsZ1VNTkZzdC9hcEQ4U2FoeUdt?=
 =?utf-8?B?M2JoaC83M1pWdUFNMGhEMjRSS0kycktvZVRkWW9TY1NXOG1nbiszdkxtVWNh?=
 =?utf-8?B?azhpbUtvZHFMTkpnamFKVnN2SWRUVXVrcG1PVzNTamdteFVBV0krOHlhckJE?=
 =?utf-8?B?a0l1Mzk2RGxvc0lTdUtLMVl6bmI3Ui9iNVFpcTJUbHNONHVPbmRGZWJyYmtK?=
 =?utf-8?B?bEFmUXY1ZUJ6MmFrdkg0aVJuZW40b3NKVEhmMkE0aTBUYzg1QkQyd0ErWlB1?=
 =?utf-8?B?YW1uYmhsbVJPbXBWU2U1R2NIQ0syekxTbmJWNjROeFMweFU0Um5YTVhtanFT?=
 =?utf-8?B?Q0dQOHltenNSbWw0enlwRGlSVHpGRG1IV3FZSjdOajlEemVxbjNwbHFyZ282?=
 =?utf-8?B?SUY1TTMvNWZ2d0MvYXRXSWU4V3lPWnV6TkFiTVQ1ZHY1S0Z3US8yQW9DS3p3?=
 =?utf-8?B?Q3NCZVFWQUs2c2JpdUwxQWF2K1A1S2kxWmIya1JwekNiVFFQbThVMUV0Qngy?=
 =?utf-8?B?aE5XWU9tWGN5NWlBcGlocm5GZEVkWXYza0cwSUwwK3ZhcTh5ZDBZTUhJdDZp?=
 =?utf-8?B?RzFhSjc2K2hoQ09LaU13YnFnb1JyN0pTTU9zS21pWldJcG1Gd2pYUSt3ck01?=
 =?utf-8?B?SHRXVS9qYXFFWHNGSjFYQjlGcE1wdWFRNzl5T1VXQ1FCclE5dnVVbHBkSzh1?=
 =?utf-8?B?YTU3VGNLTThBeG5nK2ZkZkN0RUs1Tkw1NVFGNWp6VzB5YjlFeXJUUytxdzJY?=
 =?utf-8?B?RXFhN0pkaFV2YWU2YVU1YlhKSkdvOVpKN1BCOU11dVNRQW84NFNBT2F3QWZa?=
 =?utf-8?B?bk92NWRsVHcvelc1RjZZQzlvU2drQTlyNG1mZEFoNkYrRllxMURhM20wNzg3?=
 =?utf-8?B?SlNqTUJCd2hOdlhvVDJwYXFJTVhHTHZ2ZmswL2wvNWZOdUVuVWtwdnNyZ3lL?=
 =?utf-8?B?THBDZ3dpcGcrSWUyVkdyN203WTJsdERZY1pOMm12cFdkSk1XZGl1S1kzVE90?=
 =?utf-8?B?alZuNktJNnNkRm44TW4rbzZkeHIvalJxcmtCWkV2MlAwWGJ3bElOYkUxQ3Z3?=
 =?utf-8?B?TTczUDBoL0lVQlJwWmVTcmNUSzhPNHM3VFpVVSs1YjhZVzBkSUtqSWlNOTl1?=
 =?utf-8?B?VkwxUzIweWcwUHZtUW5EeXFZOUY3aFVIblRGZmdRRFpiTnV3WG40ZW52dWQy?=
 =?utf-8?B?WWF4LzNablZOVmdqcWt1MTBTRTREZGR1M2tSVExZbUxhSVV3VlFSeWdrY3gx?=
 =?utf-8?B?MHFidjEvY3JvK3FybEJGVmZBb28zN29FUElaRkJRSEhDczMrNklobVpsUjFN?=
 =?utf-8?B?MjdsYi92OU5sV2YwcUtKeC8ySjcyMzFlYjZ6NngyVXFydmFQRGNRaWFNNVZP?=
 =?utf-8?B?L2V3dExPQWdNeTVzbVRjTWJmMnZVMkNzT1AzeGZ5dVRGR01XelZpOXA5WHhp?=
 =?utf-8?B?WGlvTEY2V2prTXE0akpiNldEWlVFRGw2SldBcGU1S2Q0YkwwaEN4eW5pTlBp?=
 =?utf-8?B?RDhUbTZYTlBaU1NSbFl3SHZ5T21pWHZRNkpvV3daZ0J1ZzhwY3FNYzZFSDVu?=
 =?utf-8?B?NE9IRStwYitkSlFyTVRwQTJqWHNWQjZDZDRQR0dHVEtYTlgxbWxRNlp6MG9r?=
 =?utf-8?B?Q2U1VnZxYXo1Ty9KY2FzU2ZEZkE1WFhhNHJ3Z1cvTW5FZmR0eTZrNTRQcDQ5?=
 =?utf-8?B?dDBFWmlGa1dreWNERSs1UjVWRUVrcW1yc1N4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9851.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWt4cHNhTW11eVhreUlEWDBXeEE3QzlGbzAyTW1YNFlmSUVSWEpDdGVERi94?=
 =?utf-8?B?Y3FOTXhlSWtmSEZXQ0tWb3hoYUJ3RGZjWGtOVmVQd2F0ZTZOUFVLTVpHdS96?=
 =?utf-8?B?UmJIRExxeGJKeXQ1c0M5aDZSYmZGV3RHOFE0d1JGdGsydjZpZ3dlMFZETHVR?=
 =?utf-8?B?U2FPRUQvZzIxQ0VrWUFtQ1JQRzdKaktmRUVBV2xPTDY5L2hRWHhCQjh5ci9i?=
 =?utf-8?B?Z2lRL2IyTzREVmtFbGVsYXd4akdSZWZIeFBPdEhnang1elZyYWdVUVhpUXA3?=
 =?utf-8?B?M0xKWWpwVWdlMjl2NThNbXZzd3ppc2srWW5lTEJvQ1d3NzFLdWJ3cnFiaGxT?=
 =?utf-8?B?Q2w3WEhoUjhEYVpFcDVrTEx4U2R0cDBtRUxTb0h2ZmFNWkdBN2xteExaU3B2?=
 =?utf-8?B?L1pVMDJNYVVsQjN5NUg5MHNZTTVSUE1GRVhNcXpIM2xnRmFDTGtFOW9kWE1E?=
 =?utf-8?B?TVpKaS92ZEt6Vnk5Ym9QNWpCVlZXWkpYeUIrMkVMOEdXcFNnNDVvdGh2QmZC?=
 =?utf-8?B?ZG9HMDZpYWl4cWk3ckMvQ3hYUGZQTVJkaGZzMlpsY2ZsMVQrYTUyay9odE5a?=
 =?utf-8?B?ZnhhUWFXYXRzUFdHTUcvT09vTVZvYlBEZjJWV214TFU3UGVJVG82U0lzaWlC?=
 =?utf-8?B?ek05U3E0a2dDait1Q2k4RnBnNWdGTGRGbFpGemhwdE1TeGNkZGJQMXJjclgv?=
 =?utf-8?B?ZkRCVDluT2JSeEZJVnJXNlRueUtYbVQ4QytMUzZIM0VERXdROHY2TTNSMjVM?=
 =?utf-8?B?bDJDelpqcVlnQ1IzcjZTNmNpSXYzMGJYT05uY1dwaVFVelRIQjVPcGNWblQ2?=
 =?utf-8?B?a2FxZ2Z0ZmZZcW9wRFRORnlyaEdsd0Z5b056cnRpcDlCSEJmWERhSkd3RTRN?=
 =?utf-8?B?d2VhOUtyQVM2WmZoN2hYdVBWalZ6UkxjQU1rSXFXY1NiSlIvRWtsak52UkJC?=
 =?utf-8?B?RFVPWVJHYnNubzBXYkEwaTNrMTNpcjV0d3RhQ29ZcXVGL0hLZjU1VnIrWUp3?=
 =?utf-8?B?V3RGM0xQcldnZEwxUnhjQUhMLzV2QXp6alIxMW9jdmZrY0Y5SVEyNERzQ3hm?=
 =?utf-8?B?TXB0dXIyVCtkNk0rZUpMSGE2UGZTZ08zMFFXS2ZiV0NFS2tCNUxHWHUwU2Z4?=
 =?utf-8?B?V1dTT2w3Z09iN2x3RG85SEJQVVpSZ3NMZ2p3R2o1WFFhOWdtTEZYKytJVVV2?=
 =?utf-8?B?blZtTkE2Szc0eStvRUhpTThTTWdlMGpKZmZFZ0tvQzFGNHFPVkxTd0hiNTlT?=
 =?utf-8?B?a1lOa2NKc0p1cVVJVmVHaDY1QTdKbm82SXVmaGRSdjlaejNnTzZsanJMVmt1?=
 =?utf-8?B?aE9HSXA0Z1ZFbGJud1c1b1VjdW9JVlNOa2lZTzl2MVJGZnQ5ZzZwUFRwSnN6?=
 =?utf-8?B?bjZNZHlpZk1sdGs1eGVMalZaYkNuTTQrbEVEWWdyeWk4M29FUjZHbWpMSUk5?=
 =?utf-8?B?YktRQkhMejBIMVdBZjFjN2Q2Y1B2cjd1M3ZJRW8zNGNLcGNwbHVKV0JGMllS?=
 =?utf-8?B?L00weDJLZkZXK3pzajlyZXUvVzlNQWNrS2o4a0ZNb2pUeUVINWwzd3lsdVBp?=
 =?utf-8?B?NlBRN1c5UW92MXVCUGcwbzZ1ZEZhWkxUT3FkcWsxSGRuUmFnSVZsNUFlc3JO?=
 =?utf-8?B?UGhtamVXODE3amFveGpMM0R0MXpDdnhhOTF1aXhYdERFNlRZUEdvY1UxOXBE?=
 =?utf-8?B?UDBJS1dJY3hFQ2VZUWJsV1NodHFpVC8yV3JWcU5WY2c3WW1JUTZYY1lscXBX?=
 =?utf-8?B?Tk0rblFnL0RsZXBvYmNIWDRUVzlBV1dhUDE4eGE0TDBaMVZMN3hKb1BROXBT?=
 =?utf-8?B?bXlCNjBpa0pNWE9wNUo4MUhyMlJnREJqakRoMDFQTVlQYzNvNEpDU0xESUJh?=
 =?utf-8?B?OWFxbzFNcExPU1RZMjFYNlFIN3NsRmc0QkNKRXJhSGpubWxBQUE4cU9LdEJL?=
 =?utf-8?B?bXI1RkVQTk9aQ3Y3RHRQcEF0RlpLazdlWWRKV3daMmN5UEE4NVcrV1VrUnhM?=
 =?utf-8?B?SE5ORmw4WGFxclJxaGIweTB3TkpDY0NiRzhpWGRBZkJMTDRma3JTZHNySXNj?=
 =?utf-8?B?SG9ncEo4WS9iSm9NRXdqNGNIcUM2alpTcEdUd1A0WWNKcFV0Q1Y4Qld4TWcv?=
 =?utf-8?B?ZWtLNWh5MEJ2dVdGRGZBU1ptSzREZ1FIcG41T1RUaFphNHBPWGM1TmZJd2dl?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5050157F1DD3A4C9DEB4787A6432D26@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gv/WYyPToF4vDSL5NO+QF6T9hvtGpWOO1A4fqhRvth9ZMmemYQ4cuwT3Vlq5LyXngXJHIGx6A4cJkenXWePKQUWFosgfc7WhB/Dtq/9yup+9gU4/yQGVEtF/Lw5TjOXsHlXu5IQUavv0BLxQcc96B4RZXWHXSoF4PgFZyFdRZDjFWHi46d5vym5MMe6aCDsy6dIcVAI8clVTG3TrYqsEDnQWUeDiWrNwYiPU0zhp3AQEE33d4c4XfT8Y6UxFZ9z6THqiiMtdQSk6fU/IO0VfijdS1wZtNZBhq51A/I50bMpEVUeXCsefup3kmVHH3W6e0QC9DW/fR+p2PIZA2aW1LXGB1zanrJ7jqMbQsN6bDV7GIKDOe9GEsEeojZcSJUQaVC/JfK0pZMhtQV9HbZYwkb9fX1INFOvV7TxDQ5hmkjBEQ4rqVvlFFGV+9bE5J6khdS377zGmZYU/UmaoiSZI9gXRy84letwjPwrlSG6T2X0rc9aGTSGgRD+h6xte8qyB33hQwSYVRa2scWQLtpYWHLwk1QEzhFe5LOCLzcvVu15nYbi7ToVDRyqBC9Aege+9gVK9bqWR9JjCj6Aa4y4PX6mXINJwudlh+qU5c0di3D8f/1t5U552QnM0ETaa6v/I
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9851.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eabc1a-8d19-459d-b19c-08de1cd13416
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 01:09:57.9726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j90k38Ib4KYxWlmLvt2MyyiIIwgfO+P2oglCzCoYjcvwx5wx4ZblA42ckrBkyx66jVP3lWGygtLs/9bCpzqdNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11780
Received-SPF: pass client-ip=216.71.158.34; envelope-from=lizhijian@fujitsu.com;
 helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA2LzExLzIwMjUgMDQ6NTgsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAw
NCwgMjAyNSBhdCAwOTozNjowNkFNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gQ29tbWl0
IDQ4ODE0MTExMzYgKCJtaWdyYXRpb246IEFsd2F5cyBzZXQgREVWSUNFIHN0YXRlIikgc2V0IGEg
bmV3IERFVklDRQ0KPj4gc3RhdGUgYmVmb3JlIGNvbXBsZXRlZCBkdXJpbmcgbWlncmF0aW9uLCB3
aGljaCBicm9rZSB0aGUgb3JpZ2luYWwgdHJhbnNpdGlvbg0KPj4gdG8gQ09MTy4gVGhlIG1pZ3Jh
dGlvbiBmbG93IGZvciBwcmVjb3B5IGhhcyBjaGFuZ2VkIHRvOg0KPj4gYWN0aXZlIC0+IHByZS1z
d2l0Y2hvdmVyIC0+IGRldmljZSAtPiBjb21wbGV0ZWQuDQo+Pg0KPj4gVGhpcyBwYXRjaCB1cGRh
dGVzIHRoZSB0cmFuc2l0aW9uIHN0YXRlIHRvIGVuc3VyZSB0aGF0IHRoZSBQcmUtQ09MTw0KPj4g
c3RhdGUgY29ycmVzcG9uZHMgdG8gREVWSUNFIHN0YXRlIGNvcnJlY3RseS4NCj4+DQo+PiBGaXhl
czogNDg4MTQxMTEzNiAoIm1pZ3JhdGlvbjogQWx3YXlzIHNldCBERVZJQ0Ugc3RhdGUiKQ0KPj4g
U2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+PiAgIG1pZ3JhdGlvbi9taWdyYXRpb24uYyB8IDQgKystLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9t
aWdyYXRpb24vbWlncmF0aW9uLmMgYi9taWdyYXRpb24vbWlncmF0aW9uLmMNCj4+IGluZGV4IGE2
M2I0NmJiZWYuLjZlYzdmM2NlYzggMTAwNjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vbWlncmF0aW9u
LmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KPj4gQEAgLTMwOTUsOSArMzA5NSw5
IEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGlvbl9jb21wbGV0aW9uKE1pZ3JhdGlvblN0YXRlICpzKQ0K
Pj4gICAgICAgICAgIGdvdG8gZmFpbDsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAtICAgIGlmICht
aWdyYXRlX2NvbG8oKSAmJiBzLT5zdGF0ZSA9PSBNSUdSQVRJT05fU1RBVFVTX0FDVElWRSkgew0K
Pj4gKyAgICBpZiAobWlncmF0ZV9jb2xvKCkgJiYgcy0+c3RhdGUgPT0gTUlHUkFUSU9OX1NUQVRV
U19ERVZJQ0UpIHsNCj4+ICAgICAgICAgICAvKiBDT0xPIGRvZXMgbm90IHN1cHBvcnQgcG9zdGNv
cHkgKi8NCj4+IC0gICAgICAgIG1pZ3JhdGVfc2V0X3N0YXRlKCZzLT5zdGF0ZSwgTUlHUkFUSU9O
X1NUQVRVU19BQ1RJVkUsDQo+PiArICAgICAgICBtaWdyYXRlX3NldF9zdGF0ZSgmcy0+c3RhdGUs
IE1JR1JBVElPTl9TVEFUVVNfREVWSUNFLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE1JR1JBVElPTl9TVEFUVVNfQ09MTyk7DQo+PiAgICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAg
IG1pZ3JhdGlvbl9jb21wbGV0aW9uX2VuZChzKTsNCj4gDQo+IFRoYW5rcyBhIGxvdCBmb3IgZml4
aW5nIGl0LCBaaGlqaWFuLiAgSXQgbWVhbnMgSSBicm9rZSBDT0xPIGFscmVhZHkgZm9yDQo+IDEw
LjAvMTAuMS4uDQo+IA0KPiBIYWlsaWFuZy9DaGVuLCBkbyB5b3Ugc3RpbGwga25vdyBhbnlvbmUg
d2hvIGlzIHVzaW5nIENPTE8sIGVzcGVjaWFsbHkgaW4NCj4gZW50ZXJwcmlzZT8gIEkgZG9uJ3Qg
ZXhwZWN0IGFueSBpbmRpdmlkdWFsIHVzaW5nIGl0Li4gSXQgZGVmaW5pdGVseQ0KPiBjb21wbGlj
YXRlcyBtaWdyYXRpb24gbG9naWNzIGFsbCBvdmVyIHRoZSBwbGFjZXMuICBGYWJpYW5vIGFuZCBJ
IGRpc2N1c3NlZA0KPiBhIGZldyB0aW1lcyBvbiByZW1vdmluZyBsZWdhY3kgY29kZSBhbmQgQ09M
TyB3YXMgYWx3YXlzIGluIHRoZSBsaXN0Lg0KPiANCj4gV2UgdXNlZCB0byBkaXNjdXNzIFJETUEg
b2Jzb2xldGlvbiB0b28sIHRoYXQncyB3aGVuIEh1YXdlaSBkZXZlbG9wZXJzIGF0DQo+IGxlYXN0
IHRyaWVkIHRvIHJlLWltcGxlbWVudCB0aGUgd2hvbGUgUkRNQSB1c2luZyByc29ja2V0LCB0aGF0
IGRpZG4ndCBsYW5kDQo+IG9ubHkgYmVjYXVzZSBvZiBhIHBlcmYgcmVncmVzc2lvbi4gIE1lYW53
aGlsZSwgWmhpamlhbiBhbHNvIHByb3ZpZGVkIGFuDQo+IHVuaXQgdGVzdCwgd2hpY2ggd2UgcmVs
eSBvbiByZWNlbnRseSB0byBub3QgYnJlYWsgUkRNQSBhdCB0aGUgbWluaW11bS4NCj4gDQo+IElm
IHdlIGRvIG5vdCBoYXZlIGtub3duIHVzZXJzLCBJIHNpbmNlcmVseSB3YW50IHRvIGRpc2N1c3Mg
d2l0aCB5b3Ugb24NCj4gb2Jzb2xldGlvbiBhbmQgcmVtb3ZhbCBvZiBDT0xPIGZyb20gcWVtdSBj
b2RlYmFzZS4gIERvIHlvdSBzZWUgZmVhc2libGU/DQo+IA0KPiBaaGlqaWFuLCBkbyB5b3UgaGF2
ZSBhbnkgaW5wdXQgaGVyZT8NCg0KDQpJZiB3ZSBkb24ndCBoYXZlIGFueSBrbm93biB1c2Vycywg
SSBwZXJzb25hbGx5IGhhdmUgbm8gb2JqZWN0aW9uIHRvIHJlbW92aW5nIENPTE8uDQoNCiBGcm9t
IG15IHByZXZpb3VzIHVuZGVyc3RhbmRpbmcsIGl0cyB1c2UgY2FzZXMgYXJlIHJhdGhlciBsaW1p
dGVkLCBhbmQgdGhlIGNoZWNrcG9pbnRpbmcgb3ZlcmhlYWQgaXMgc2lnbmlmaWNhbnQuDQpNb3Jl
b3Zlciwgd2l0aCB0aGUgY29udGludW91cyBkZXZlbG9wbWVudCBvZiBDbG91ZCBOYXRpdmUgb3Zl
ciB0aGUgcGFzdCBkZWNhZGUsIHNlcnZpY2UtYmFzZWQNCkZUL0hBIHNvbHV0aW9ucyBoYXZlIGJl
Y29tZSB2ZXJ5IG1hdHVyZSwgd2hpY2ggc2hyaW5rcyB0aGUgdXNlIGNhc2VzIGZvciBWTS1iYXNl
ZCBGVCBzb2x1dGlvbnMgZXZlbiBmdXJ0aGVyLg0KDQpJIHRoaW5rIGl0J3Mgd29ydGgga2VlcGlu
ZyBpZiB3ZSBoYXZlOg0KDQotIEFjdGl2ZSB1c2VycyB3aG8gZGVwZW5kIG9uIGl0Lg0KLSBBIHVu
aXQgdGVzdCBmb3IgdGhlIENPTE8gZnJhbWV3b3JrLg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoN
Cj4gDQo+IFRoYW5rcywNCj4gDQo=

