Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B79C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsF2-0001CS-9K; Fri, 02 Aug 2024 09:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <euan.turner@nutanix.com>)
 id 1sZnWO-0000aw-Rn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:20:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <euan.turner@nutanix.com>)
 id 1sZnWL-0000uZ-CZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:20:20 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JVpnN008894;
 Fri, 2 Aug 2024 01:20:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1rRhzjN64OvFs7u2iX6XTivv2mpXMoQo9V7LXaybA
 34=; b=uKpsV/L0ExnEYCeRsaW9/yaZ5prM8LKaYtfsWXjf8A2bYWV1H7fgDYVKR
 B4D4XJQtvBUOm0O4KkqFNjyp2sBG0qr6+ddB7VndyHg4nDpMl1wEluVqzfeB5h2f
 hDfni+7FxOTc/aUOyQUATRNQiZ29jm+buB7sGHTzg+XXFLJqarSdJItZ1hExAPZF
 oKQC9crgOH+aN1w4jMgsRhOD1G996zeMBEl5fJQIh6BW0zdWeHyjQc7G7In9nrq0
 v2JQAc4x0Iw9FR706q4Sc2scnwFSbXmVgVzTZjaSHbXA8Qle95PW+4Ti3JrdzO4K
 HTflUnbFio0HqquvHWVuPKC7pQ7qA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40q9chpkpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 01:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMBNYWbkyj9mv4Voq93i2znt1s+bzvJKEUCbF2Tm/8p3FihL5r267cOdo0CGeOKOw3OipYdYf+g/E+097ox5Df5mLNQj8Pqf8IitAsEyauTbgt3+f2J308nLIrx9tIHRAYXS9jdD9Wk28LsMRKnoyr9miVv1In1aU5GSoqQslumR/q6q1Zkgw9ck+mFmyQfcBq8ArN1j3cjjsMFznc1m1aZ60nKwsDOGcU8RmErLdqASznDv36kBQdnHlXpONQtJ83LIdFXzeXCZtpWhvKNoWWnsk0tfvTSR/rDVbnHBMnEJl15VZyjKHfMUed4xtFolTEoYCVULQfZJHwlb20kL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rRhzjN64OvFs7u2iX6XTivv2mpXMoQo9V7LXaybA34=;
 b=xSAp4z8BDODr82KjCBq+mYSnMCrfBA1YXQSn/O0+5dUhkz6Vys2b+NP7iQWLdFcs94HdWBsziDuUjBjarAzXB5B4Ufe1/FwlLtJKxMUI+e5S0DCuRxI5/sx+w/gVAyn6mTjjLRx28lRwihN4s4mCPPYeCdtzEtNNkFtG09RPnKih0HLvQjpmv7rxySOrhOqZ+TTh3bnRcDvDzySBRS14EYC6YTgelfnIISExMIl8jGXHgvrJtr7zGNyWYK2dBVq4Okb7hZ9gspDT+uEQyxSaneoY6bv7ZyDwhQtEhTLQ5XCwmkFJsfFSOfNDKK8kX65bTfq+bRtlET5fgl/jgoRpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rRhzjN64OvFs7u2iX6XTivv2mpXMoQo9V7LXaybA34=;
 b=ESfKlqrCxC1uwlU3qhRhZZiPkxBK9uY5QT9HxRgA0bCuC8K3AYgmgOFs1ttlQm08CzViEQYvG6XpxOiobSt90ljAGyeJLkHw2EQIAncVngLZzdayrpBGpn8xpwLlRZApqhefqW1rtGSXStITiEObpMJqj5JBMnOo77tTMKwbN4+76z9eJ8yRPXLjL3egkpnFnUltqSLSuY/aecRc7tyuwpP1MWmoe1F35MAgT8Xs7GdFQleZhmErOSwqJFtYa+BEQ+3uDHo3T/yby89H/UNeZ/q/lT5umxZGQVAyQjkYDVrDqs2W2XRKOnI3DYywzKxf2/PSR1CFAXwObXWRTcFtog==
Received: from BY5PR02MB6471.namprd02.prod.outlook.com (2603:10b6:a03:1c5::9)
 by PH0PR02MB7814.namprd02.prod.outlook.com (2603:10b6:510:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 08:20:08 +0000
Received: from BY5PR02MB6471.namprd02.prod.outlook.com
 ([fe80::946:8127:2e60:518]) by BY5PR02MB6471.namprd02.prod.outlook.com
 ([fe80::946:8127:2e60:518%3]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 08:20:07 +0000
Message-ID: <bdd13555-29ec-4d72-8abd-b6b634033df6@nutanix.com>
Date: Fri, 2 Aug 2024 09:20:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/6] migration: SCM_RIGHTS for QEMUFile
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Euan Turner <euan.turner@nutanix.com>
In-Reply-To: <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0136.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::33) To BY5PR02MB6471.namprd02.prod.outlook.com
 (2603:10b6:a03:1c5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6471:EE_|PH0PR02MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd02103-7195-4313-8b4a-08dcb2cbeb50
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3g2cVlTcEJuRzVJVHNNUVdNTjRqeCs4ZXFLMU53SC8wS24ycEN1TVBKUEJI?=
 =?utf-8?B?dS96ckNJQWk5alRYRFVtSEZ3WVJDYXF0RHRnRkdiZmpjOFNwYVNoRzZhMzBI?=
 =?utf-8?B?aXMxSm4zOUVuS3ExNzBoSnRkUTlNYlovci9iSlk5ZzF2bEVzeXNFdHIvdFpz?=
 =?utf-8?B?WTYwaGlNbU53NHlRaGpENXJnR1dIVTFlWTFMYUJpdU00Q29hQWlMeElQQVdY?=
 =?utf-8?B?NXVlQTRYM21DZnVxcmFrSUNWN0RVK2lTS0ZlOTNBQlU0eUM5emlkQ2JFNFRi?=
 =?utf-8?B?TEFNaCtFMzlLdGRUNERnSE1LS1dlNm5ZakNZQXRpRW8xQVZlb3I2UGRRSjRB?=
 =?utf-8?B?bUo2N0xvVTlnRUppYk9sZ082MGJ2bnE3NzZmTFprN2JvS0ZmQXlNdWFoNFB4?=
 =?utf-8?B?dkI0WHFFVGxYV055Q1FGeFNEb0VLMUhOaTBoVkw0WHBRZGU0WDVlVyttbU1R?=
 =?utf-8?B?Z3dtWkR6NEJRY2dpU0hoU1ZxZTFtVVYvQTFCQmNmTG4xcGVLdFp2MGdudk5U?=
 =?utf-8?B?NnphNkRVYzZxQWhrY1FyZG9uYW9EV2xxdWQzMkZhOGMxZXN4TkVqbTlFRXRj?=
 =?utf-8?B?cVFNbDlCWnFoSEZZa1ltN1lISGZ2L25IYjVralkxb0E5VkJKMXRycTdRZStp?=
 =?utf-8?B?dFV4cmlXUTVJQm0zMzEvcUtEb2ZZMWxrK1lUa2tIMGtIQUtIaE9RY3VHRFZs?=
 =?utf-8?B?MGxibmsyT05tOFBXc01JWXpjdk5SNytLMUVWdHYxVHhyVjdzblEzaFFWM3pB?=
 =?utf-8?B?T0t1Vy84aGozekdRY3Y5cTV3YWYrbHRWdlZHWTluNVh0UWh5ZnNWZ2Exa3Y4?=
 =?utf-8?B?SUJBMUQ2blQxUDFibUtBTjEyVFgrOGNtcmFpNjBpb2ZVNHJlL3RLUTd2SGZK?=
 =?utf-8?B?RFVOemNiMkZjRjk1emdDam5nK1Fud1hMSEFGNWpqR2ZIVzdQL0VTK1gvbjdX?=
 =?utf-8?B?a1U0ejBIeDJWbjJibzROWFpORVhHMzNxdFBhTDhxTE95NUlXMFJDSDRHM0ow?=
 =?utf-8?B?SWt0c29qTXh1Q0dlSlM1T09TOVkzVkVtUXBIREpCdjVmK3BlMjRjN0gwejk0?=
 =?utf-8?B?cjFkd3VIUXZERHRRelhJa3RydmhQNU91Z3NnUGZ6Ynd1SE1NNTZKazh4Yjd6?=
 =?utf-8?B?UUVqOVdiNUUyMDV4WGhCWncyVkdHbTQyUEhEQ0JxUHZPcm85Q1dpUEEyMFla?=
 =?utf-8?B?MHBhZXhvRU1rOG1xQ2RMOWRreFk0ZVFtNjBIVENmdGNVaXl1ZEwydkorck9i?=
 =?utf-8?B?dC9aejZVOXAveTltZGFOMlhBZVgxRTZYdzRzbjViRDdIT0E4QTVLdlduamxj?=
 =?utf-8?B?L2ltcTNTNGVRMVFnUlFQSmkzeDZHVVFzMk1PUEw4RlNUcHJoRFJ4b0V1c1ZV?=
 =?utf-8?B?Y1NQZk0ybEhKSUtzVlZ5Z3RhYzVFaEJSTzFLcUFYQ2NsOEx6MWt5SkR1a2wz?=
 =?utf-8?B?bDF0NUNMUXFiNFYzVzJ0VzNRT084Q3g5MHZuVjFWVHQrd2FlZEtVVCswam8v?=
 =?utf-8?B?ZWFZUUs2THM0cnVNdk5GQ3ExSDlqdVQ5NldlYmdGOW1rQW4wbFBORjhLVy9Z?=
 =?utf-8?B?Z1JiL0hTR3R6cGN0NzBoMjRDcUZ6eWpWZjBIZXQyeUtxaVhVNG5pZTZKckJv?=
 =?utf-8?B?Q1JaOHhhdVd1dGE3akVGTjFtdmpDMUk1SUJsbTJ2dmRwQW9lUC9RWjBSMkxu?=
 =?utf-8?B?b1pGQUFUUXF2cElnVmVnaWdaTFZ2ZjY1Nk1maElsQ0tYYWgyM2kxbFpKajdU?=
 =?utf-8?B?MC9YZkJXSENrRFRVNllhd0pXcDAveXZ3dXpTTVg0YlJ3UFFhWlU0YkZPTmt3?=
 =?utf-8?B?R1AxNkp3WThMUUlkdTZXUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6471.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzljZ0FCMjN5T3U2TWhXTVFLT3FiakFHckdRYmpKdFgwUkMzNEF3N3l6UnA4?=
 =?utf-8?B?Y2s2ZjM3a0VsUWVHaHlRT0dlYk93WWRmTUFzcTBlS3BVMDZLT3I2VWd3UW5h?=
 =?utf-8?B?MFJxaGhWWmQyamJ3V0hyd3VlMjFXeTdNZTUrbUZGeVRkc1ZjUWFmR0o0QVVh?=
 =?utf-8?B?THZQMWVUdUNFQlZLRE14RTR6czBLZEJBdHNKUmNiZFIzTll3TlB0KzdNaEVJ?=
 =?utf-8?B?Rm9QTXFtK2xhdmJud3hmYlRUK2JVazZla2Z0bDFMR25IcE9xSUI4NXQ4VkNo?=
 =?utf-8?B?QjlpM3FydUNlTW1LalBPSXZycnVCbG5zRXR3U1Y5S3p6Ulc0dVdSdTRRYXMx?=
 =?utf-8?B?S2xBbE5UMGJ1U2FTcVBuLy9mY0w0NXdmcXlHU1NiSERHQVl2S2ZkMEpkKzho?=
 =?utf-8?B?MzczQnpxNDV4ekZWMFFBdmRGSklkVElaMTJNVWJBQkRWT2srZlBIaXdmV1g1?=
 =?utf-8?B?bTR4bGZTQWQvZE8wUHpEK3pxbnlIc0M4MXhGTmk0ZFZWNmQ1ekF5bThhOFRv?=
 =?utf-8?B?MkhtZDZ5VVFsdENmWFYzREs0dksxR1RDbStwcGhoamlseStFUDI5OGtZeWJL?=
 =?utf-8?B?ZUwyenhwcHl1WSthV0FOZVVyQ1dnM1pBNHgycTFmRXh5aGR3UzVMaU5GdTJL?=
 =?utf-8?B?Z0Z1ZGxzZlpnWTlhNFFvSkZWcThKOGRwZEJhOXVKOUIyNzBBYzA4UWJxU1R4?=
 =?utf-8?B?YnJaRElJeUNFRHZwY3NsSlo5a1RnNFF4RkpwZjRpV0UveGpCWFVURWtFc1B5?=
 =?utf-8?B?RDBkMHN6QXV3NStKeWw3ZUI4TUlNS1pxdzJhSXZISmt6bDgvQyt4dll6dENX?=
 =?utf-8?B?YnE5ZzJXTDRCVUdsYmZxSm8yLy9iaHhjZXVaL3NQcStiR2VaZnBEWnB2OHBq?=
 =?utf-8?B?cXh3bkNyangvNXhYNVpad2ZLUXB3N09LTUQvd3FvcHVmOXAyTHg5dlRMY041?=
 =?utf-8?B?SkZjVnhGNGN1MTZxYm1TTE01UWgxeDVuU2NlbXA2cy9oSUE5SndEMUlrWG16?=
 =?utf-8?B?RWsxLzJKbklsTEVZaEtmZnVIVTRNQ3dDU3lTZzdqNW10OUJuWnNFd1ZEV3RW?=
 =?utf-8?B?MllsT3RiKy94bjB5ek8rOVpCdHRocGF6T0dFa1QwcXJIUDZUTjhaUDl3Lys5?=
 =?utf-8?B?enBnYnZEejJhQ2w1Q0ZTRjZkemRFWU9tRXBGTzRWMHl6NlhrTUFTR1YyL2V2?=
 =?utf-8?B?L2NzVS9YTGI1VnpKZlg5d3pMNlo3WEZlRXgxek5URUlkSDN4ZkgrUUgvQ1ph?=
 =?utf-8?B?dnV3cDNxRUEwWUhxQkFOc3lqSXNOZVpYSXpRMVh1UHEvdHlrY3VsRDBFazRW?=
 =?utf-8?B?NTlOc3RoaEcvVWxmK0JHeHVETmJtUUp1TkxKdTRIK0FtcHVHKzcwclBiWjRj?=
 =?utf-8?B?U0dmUGRzVU1paG03NFpBUGRMeWpidVQzTzZpZHBKS1M4eGJiT1N0dEJ5VU9L?=
 =?utf-8?B?ckxMUVZQT0tpN2UxdktxL2RBM1NWamtjUXpCMlJucEZBSEhZQW5RZUYrQzFv?=
 =?utf-8?B?b1BjNU1pWGVEdUk4TlRiZGY1Q0pZcHZqWmN4dk50NERUZEJTbDN6dkRidDJO?=
 =?utf-8?B?THoycHBWRUhudGxyUGJwSkFMbi85TGQzMzRqK0w2MUlpYUsxOXE3VTAvRWRF?=
 =?utf-8?B?cXhsVEJTWEtkQ2s1WG1mSjhrL2FNS1RwSVRQay9XREhHSS9pT2ZzL0hXaWp5?=
 =?utf-8?B?dFpWM2NLRTRqWEg2MC9BMW02S1BvTUtoN2R0OXNSQzNSVTVxaWRadVFiTDRZ?=
 =?utf-8?B?SkVsckQ0VVVSbzAzTXpkQVFkT21RVFpkWmNMU0FEbGFGUWc5cytpU2M4d2Vv?=
 =?utf-8?B?STY4WFdpUE5lcUhQVVQyZVE2VDV0aEFnbnlLemd5VC9CYXd1cjduMjhmWWRC?=
 =?utf-8?B?QXdzaWFTZXBpazZWSWhrSkk3S3pFZ2FtSUxiMnpHK2xNSmdkQkZWdTBxcFlM?=
 =?utf-8?B?U21YVDY4YmxCV0E5cGxibWxlRW1JRjM4UVZsT2xPajdHdTFnWlR5Zk5qU2lr?=
 =?utf-8?B?anNMVmcvNlRkNnJ3b3htVDNJendUbkZJQ2c3YmIwRVM0YUtac0NDN3BtczdH?=
 =?utf-8?B?UndFc0RIellhM3V0U2VHcE5JbU02cTNSNkpFVHQvSWRsUTJPbDU5TnlBaVJx?=
 =?utf-8?B?UWRZTDlxWkpvUWRmZWVxa3hXTmJRVWt4aEZhRUFCMTc1blc1cWJJcXRCK1VT?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd02103-7195-4313-8b4a-08dcb2cbeb50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6471.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 08:20:07.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twRj/gqfVlaA2hIPhVbZEuGgi/rb3sjDdQGNl5la1D2op2t2pgSmsno48yELcA3XSWqXWfne+1t/UgB3bM00Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7814
X-Proofpoint-GUID: 4tXnSMmrjvqhB9kjQzb0X-JPmCy3ZmXK
X-Proofpoint-ORIG-GUID: 4tXnSMmrjvqhB9kjQzb0X-JPmCy3ZmXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_04,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=euan.turner@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Aug 2024 09:22:40 -0400
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

On 30/06/2024 20:44, Steve Sistare wrote:
> Define functions to put/get file descriptors to/from a QEMUFile, for qio
> channels that support SCM_RIGHTS.  Maintain ordering such that
>    put(A), put(fd), put(B)
> followed by
>    get(A), get(fd), get(B)
> always succeeds.  Other get orderings may succeed but are not guaranteed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>   migration/qemu-file.h  |  2 ++
>   migration/trace-events |  2 ++
>   3 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index b6d2f58..424c27d 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -37,6 +37,11 @@
>   #define IO_BUF_SIZE 32768
>   #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>   
> +typedef struct FdEntry {
> +    QTAILQ_ENTRY(FdEntry) entry;
> +    int fd;
> +} FdEntry;
> +
>   struct QEMUFile {
>       QIOChannel *ioc;
>       bool is_writable;
> @@ -51,6 +56,9 @@ struct QEMUFile {
>   
>       int last_error;
>       Error *last_error_obj;
> +
> +    bool fd_pass;
> +    QTAILQ_HEAD(, FdEntry) fds;
>   };
>   
>   /*
> @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
>       object_ref(ioc);
>       f->ioc = ioc;
>       f->is_writable = is_writable;
> +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
> +    QTAILQ_INIT(&f->fds);
>   
>       return f;
>   }
> @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>       int len;
>       int pending;
>       Error *local_error = NULL;
> +    g_autofree int *fds = NULL;
> +    size_t nfd = 0;
> +    int **pfds = f->fd_pass ? &fds : NULL;
> +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
>   
>       assert(!qemu_file_is_writable(f));
>   
> @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>       }
>   
>       do {
> -        len = qio_channel_read(f->ioc,
> -                               (char *)f->buf + pending,
> -                               IO_BUF_SIZE - pending,
> -                               &local_error);
> +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> +                                     &local_error);
>           if (len == QIO_CHANNEL_ERR_BLOCK) {
>               if (qemu_in_coroutine()) {
>                   qio_channel_yield(f->ioc, G_IO_IN);
> @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>           qemu_file_set_error_obj(f, len, local_error);
>       }
>   
> +    for (int i = 0; i < nfd; i++) {
> +        FdEntry *fde = g_new0(FdEntry, 1);
> +        fde->fd = fds[i];
> +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
> +    }
> +
>       return len;
>   }
>   
> +int qemu_file_put_fd(QEMUFile *f, int fd)
> +{
> +    int ret = 0;
> +    QIOChannel *ioc = qemu_file_get_ioc(f);
> +    Error *err = NULL;
> +    struct iovec iov = { (void *)" ", 1 };
> +
> +    /*
> +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
> +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
> +     * data.
> +     */
> +
> +    qemu_fflush(f);
> +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        ret = -1;
> +    }
> +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
> +    return 0;
I think you intended return ret?
> +}
> +
> +int qemu_file_get_fd(QEMUFile *f)
> +{
> +    int fd = -1;
> +    FdEntry *fde;
> +
> +    if (!f->fd_pass) {
> +        Error *err = NULL;
> +        error_setg(&err, "%s does not support fd passing", f->ioc->name);
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        goto out;
> +    }
> +
> +    /* Force the dummy byte and its fd passenger to appear. */
> +    qemu_peek_byte(f, 0);
> +
> +    fde = QTAILQ_FIRST(&f->fds);
> +    if (fde) {
> +        qemu_get_byte(f);       /* Drop the dummy byte */
> +        fd = fde->fd;
> +        QTAILQ_REMOVE(&f->fds, fde, entry);
> +    }
> +out:
> +    trace_qemu_file_get_fd(f->ioc->name, fd);
> +    return fd;
> +}
> +
>   /** Closes the file
>    *
>    * Returns negative error value if any error happened on previous operations or
> @@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>    */
>   int qemu_fclose(QEMUFile *f)
>   {
> +    FdEntry *fde, *next;
>       int ret = qemu_fflush(f);
>       int ret2 = qio_channel_close(f->ioc, NULL);
>       if (ret >= 0) {
>           ret = ret2;
>       }
> +    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
> +        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
> +        close(fde->fd);
> +        g_free(fde);
> +    }
>       g_clear_pointer(&f->ioc, object_unref);
>       error_free(f->last_error_obj);
>       g_free(f);
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 11c2120..3e47a20 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>                             off_t pos);
>   
>   QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> +int qemu_file_put_fd(QEMUFile *f, int fd);
> +int qemu_file_get_fd(QEMUFile *f);
>   
>   #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 173f2c0..064b22d 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>   
>   # qemu-file.c
>   qemu_file_fclose(void) ""
> +qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
> +qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
>   
>   # ram.c
>   get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"


