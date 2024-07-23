Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA1BC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWATZ-0007cq-Vc; Tue, 23 Jul 2024 04:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sWATC-0006lb-Bt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:02:02 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sWAT4-0004NQ-A9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721721714; x=1753257714;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qx8ahQg/L9psaTEyZqrO13vDw6W7LKeXXbtNalJOtDc=;
 b=bjwNqCuWmtzlN8iQg1h8onPa2TmxJpsKYb5BpQTeXxzl52wKIOEKBn11
 W1gaY/4GjOWMuicWgRwAW4ZzsYxqGSco29RAso5ZJdtIGDTd26oUuuOLD
 pUcUUyxU5ijg5Wwpt3YNuXCej/++wKiBnrNwGhO1TzmDUxbHo08FkEX0Q
 KJmDUSQieX1UvHroWfzp3rIPEY6f9Q7BqM11saKyazLjVL9s9SXGNGgkD
 fCgEBKmC4cACNUbTRmVQTPhsOsk/z518WFwZs2ondyX5N6yA3pTx4Z78i
 JTZMjWNrz1l4MBKnEoZJtOqNMdpZqI5+c9KCjKj98lqoTusu2V+L0ex/l g==;
X-CSE-ConnectionGUID: Mt/9ASfDSGSF0cRzVI/LzA==
X-CSE-MsgGUID: 0wLDPkusQBuMYg+giZ1cuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="22229604"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="22229604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 01:01:00 -0700
X-CSE-ConnectionGUID: IGw+GJBJQNWozy/pSR4IOg==
X-CSE-MsgGUID: Ki3WapC2SH+yjWRtzS0dVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="57271531"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 01:00:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:00:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:00:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:00:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8PXyCi9veed5sUyRY9wrtk6fJKQ4nP+hmYpnSef0xmxe+TXEIELnnpHB47IqQr5qqFto+ntUJ7c4JvqwyTyBhgDGeutVs5ZvztKsoYBWwAIGDMtuQp6uimB7J9wFMoXPQUv7Yx35a2SXhPlLW6rINae7IaDgJ7nE5zIxg6lhhTwX2RISNqpOokNLvHjl5oVgUwVJXdWpv9b3ZAraUzmVqu1SaWzXlKYvllcdnTTIUZBOlL0dzHXl8ZIgnFRawSSquvX14DtBNuLOmlNyjoHVaeozTT3+FPO/XTdEISiYkc847Cll91y9Pf3ZkVOqfiJPBXbFeSEPyrfouDoBY1Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFAS+sqn9G6oejAXlpHC0vd8BISLgOpXmavqHon7Udg=;
 b=zNXjR2/G08EIp4nYxRxf+oQdSLBIOWlOsZO/Zu0PwbsUPqKd5BCxb57frFGKLEJmImAfd0axVD/Aes7VfHWMLbWNfAQD5BSWoN9GOjl5i/rS1NRUEqleUyEIEmS4zed+9Ae+18ODEkwH7GQMZOaXGdNAlhjEVvJFzJNeJOJbI0/Fh66cJHWuUWcBlwkfjf8xy0dpMBkcPjwBDILxDELTKahCdTmpZfx0TodbQKmyWbUq50kXHrRxfBFQcBbZbi+g2p+U1RgXFP4bWpG/oOHK8oBvCzw0RD8QDwiMlllMDhys60OTGpSe2v8QqcqGHWfZK/OS5no+Qd0qM7gqS6/qsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 08:00:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 08:00:55 +0000
Message-ID: <6996e344-d0af-469f-98e2-180336bcfb55@intel.com>
Date: Tue, 23 Jul 2024 16:05:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
To: Yee Li <seven.yi.lee@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: <jasowang@redhat.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <qemu-devel@nongnu.org>
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
 <20240720142902-mutt-send-email-mst@kernel.org>
 <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ae423f-f302-4425-668a-08dcaaed9442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjh0QUwyL0lSNDNPU1hwWjAzVS92SGQ4MjNYN1lQVE1yWTVBK1J3Q0sxSzFW?=
 =?utf-8?B?ckF3Z0FwQ3YraUNySFdJUFdieW1ibGdNOXpDYXBOSFluZmV3ZkhYZk5NeDZo?=
 =?utf-8?B?cXFRMmxUYktnU3NCdGF1YlZRcFJtY1dySHBndytudnlRTWRMcWYzWXpNeU04?=
 =?utf-8?B?YVlDZzZTQVArT0xJOEZGQXo4S0JMMFMrQXJmTmFJNmZMSHpSd1BqcE1lbGNh?=
 =?utf-8?B?cTJhMlRucG1HbThyeWlnT2Zuak1GQkVDWU40NHhHazVNb1I2dG9reDVoa2tI?=
 =?utf-8?B?Z1lEdnhvT0traUl0ZXIrMUp6SnEyTnErTXIxNnFINmFTdmd3ZUhHLzVoVXJ5?=
 =?utf-8?B?Tnd1ZnhGQ0R2aDBkZVBwZ0lLOE8vR1VQelg5VVg5dmgvVDZFaWlzWjhscGxK?=
 =?utf-8?B?bTdOWTRvTWtLTjZaMHVmaHNpZTh6aDBDbmF4bDFrUUsrQVBEcEdXM2V3c05N?=
 =?utf-8?B?YXp4MkpMWkZNejVDM1l5cUdEUW42WDA2cTg2aE5tRXdpUnVQdko5Q21tOWpF?=
 =?utf-8?B?V1dQM0dzOG9WVXpLTExIajBUQmREdFlHVFllV0pRTkY0UDcwN05MdFBrL2l5?=
 =?utf-8?B?Y3NwSDViMENvUDVDcHg5Q1R5T25VdDdiM0lLNStsSTY5NDJVSW1vK0hQaW80?=
 =?utf-8?B?d2h3RHZ6d3V4RmlJbGIybEd1dGVxN1Q1M2l4V3ZTZUJPK2pnVkZDOXlLdWRP?=
 =?utf-8?B?SXFlRlNoQWp4OTlsQ0FNTFY4VWJ2N3BFK2NBM3VCZnlJMEhTK0I0SjF0aWtF?=
 =?utf-8?B?bk1NcXJ1blA2c0VLR3BGbmNvb0hTYlNMcWxHWnB0RmhUZEtIK3d0blgzWGhB?=
 =?utf-8?B?TnpGWmZNZ2F0dWd3OTNpeXdiZTNmRGI1LzZoYmZ0SVpSRnFCbDVTUW16SW1E?=
 =?utf-8?B?TWNDZENSS0tkajY3MTZINmNBdFluaCs1NlV0UVNRcEl1NW16SVdRV095YXg5?=
 =?utf-8?B?bG1OWFZFeHBMbC9kNTAzN01YYW14M2FaL3pSaGI0RW5NOTRvYUZlZ3c0Y0FJ?=
 =?utf-8?B?SHh2Z0htWjZZdEh6NERYY2lnUmpZTGZiSUh2bGVWVlVvT3UzaVBuZWZtWXZZ?=
 =?utf-8?B?OWNFK0Y0YkwxM2xiaGQ3MXdFdE5JTTl5Y0lzOUNYSzZ3T1NKbitrZXFTdGFi?=
 =?utf-8?B?ZnkycUJES0pwMVlXcEI1YnRBR0JCQVNzVzZqczZ1YmNZbVZjblZYNUs2T0lD?=
 =?utf-8?B?bE41Y3BXS0NZNWo4bUJDRW8xeWVDUUFtM0pkUWlHR1dCWmlvelFiKzRsNWQ0?=
 =?utf-8?B?dEFMeEliVVpQYnVmeWM1WCtiWnpNczVOdnJmcFM0TlFCdnp3NjQ5VnhSMDQ0?=
 =?utf-8?B?ejRub2JyNGRxc1J0TWRpKzk1aTJBc2NwZ2hudG5jL25rVDd1bnNQRTlTbTcv?=
 =?utf-8?B?VVN6YVBlMTRjOStFQldYbS9sUU5weUIzbDF2TjBkZDFiRVp5Mk1zNW4zU2lO?=
 =?utf-8?B?am4wUktlNHRQNUd3VWdhNnEvbjNsV0kxcjA5NlFuZDJqWXZLZ1dpU2I4UGJC?=
 =?utf-8?B?ZGE0L1Q1c09jdy9TK0NCTXdJam9uM0JFcnQ2ODVyWGZUeHZiUUJCUzhnWHQv?=
 =?utf-8?B?WjdycjNwN1ZnaXBGVW5nRGxEekNVai9iWDJjZUdLQ3V4blBrVEdINDlGMjZj?=
 =?utf-8?B?T05BN3NwSmtIMERqMVI0eUdIYktHejJsQkp6SEhLS3l4R0M0ZXh3dFhIRk1t?=
 =?utf-8?B?ZDRjZ0tWaEE1SkZ2ampSWFkzaEhQcWo3TkRxRjBiNmQycThrRWM0V3VHZTVR?=
 =?utf-8?B?QXJPSys3WVVMaGg3a05POFRNaGJtZXErK1U3Nm9XOU5sU3pyT2czY2pNMExB?=
 =?utf-8?B?amVEdWl6bHFMVGtpWmN3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVtUDh6a3RzdWFsMHhJRjR2QnZJZGJOY2wwaDkxT3Q3Y2JPWGRCNWJyOG0w?=
 =?utf-8?B?Y1hkZ0szTzNyazErK3U5cnRwdWgzUEdhMzlEaDdsQVFUV3lZZ05oOVlPbnNX?=
 =?utf-8?B?NTNqNUtPdGJTMWRqeFFYOFp3d1RtWG5jK0FPTERHRXhLTVN2SWw3VUFCOW56?=
 =?utf-8?B?U25BN2tnRVIxUDR1QVNmQnI3ellLVTl6T3RFSndSRHVoK1dsZmNBL2lqMHVK?=
 =?utf-8?B?UjNtQ0NZMk5zVEQxSS9vVGhwWnpKM2RDZmFXcDlZWDdITTJWQXJXRzdQYnk4?=
 =?utf-8?B?bGlKYWczdEgzU1Zka2R2cWh0MmxGeVZYLzh6UWovQTc4UlBKSXRqYytQMUhF?=
 =?utf-8?B?OHVmTTY3a0VHZkJERGlsNmdsL2FXdFNLMTZTS1dwZitvUHM0dWkwcVJ1dTZ6?=
 =?utf-8?B?YjcwWjBwazROMnJQazlyQ3FoWTBrc0RiSjI4Q3I3MU5ZTXVKclpUMmxVbTJ3?=
 =?utf-8?B?dlZVbFJaQUZIbVEzY2RWV2w4b090dnREM1Q1MTZhSk1UZ3BOZHRRYTVORzZj?=
 =?utf-8?B?Nk02MVlmN3Q3STQ1dzBtZHpTUlBUUVQ2aGw0a01VYTBmbHZWMlRtT1dhTHlt?=
 =?utf-8?B?MVNxTjBZZkw4Nm5UcmRJcEFtK2RGOCtFQy91czQ1YTQzd1crVVhraEJ6Q1Vl?=
 =?utf-8?B?Y25QbE9tNkE5b0FTdVpPSlROTXR4aUFFcUVqRHdDT1daMEFhQnhwMVZhL0Zm?=
 =?utf-8?B?TXg4UCtvS2hKck8yVS82V3RIQjFxV2VIa3R2NXVWaGI1L2l2d3ZGS2ljODQ4?=
 =?utf-8?B?emUveWxPSmpLWXZLVmhYUUNhUFJDODY2QklUUW8xWjVxMUhqejRWUTE3TUdl?=
 =?utf-8?B?NCtjaDRFWUxpN1gyMWpVRkJHNU1RTzRJTVFaSmY5ZW5JeDVFbUtJNENUMXNL?=
 =?utf-8?B?Z3N5YndYdWpiOUhoS1NlSVhGTzVJMzV0NFc4SXRWT3F2ZmlMOUxUS092K2VS?=
 =?utf-8?B?dHBqSm5qTjdoNFBXcmpTb1FHNVBSb3J6bnk4cWpZSkVtTk15NjYyaVFGVms2?=
 =?utf-8?B?Zzh6NXlxMHdPRm9wVW14Smh4N2NIUHprKzltbHcvS1haZm1qYzZqRUc1cC8x?=
 =?utf-8?B?eUJsRFBQWTNUeXpvQ1NQNnNjNHozY2N6c0dHc2l0dm9RNG8zVlF2UkNCa0JQ?=
 =?utf-8?B?aFlaRHkwbG85ekFxK0hzN09Bc3Y2RXBoanhHd2V6ZERwaXN3bGVTSUxGZ2Zk?=
 =?utf-8?B?YkZQT3dKaUFkMjc1dTcrcVBocC93THJFYjVWTmFHdzN2Y1hJTXNiTEhtL2x0?=
 =?utf-8?B?VXVlQ3dJZ1d5b0ViV0ptS3BNamNXb2xqYlVsOTRMTktqZzd3SnZmdUNTU1Zr?=
 =?utf-8?B?bEZPQ0tzZkZQMFViaGNzWG5EVzR6SXRCTmdzeGlXaElNOE9wRmJZSERpZ0FD?=
 =?utf-8?B?UzNVczdkSktyTHF6VVYvN2U2WjBnWmdMQXNqRkRLUGRXTGNNRytoajJ6SGY2?=
 =?utf-8?B?WXhuMVowMTMzcVZWeVplSTREc3MwNDBKbDR2RlVsa1ZvK0tqYVArSnNSVG5U?=
 =?utf-8?B?MGtuaHVPZ3RacG4xMW15RTMrUFc4dThuTGsvbXMwUWgxc2UydzQ0VHM5ekJQ?=
 =?utf-8?B?anAxbVErK29SUE1jTGkvd3lhUWpxYU1CalNDMXFTYWxCQkNSeE9ldzdvV1VK?=
 =?utf-8?B?YTZBVUR5MDN6ckhkd2hNN093QlFBdlZGWmFWeDh4OHQzeVNITWhPOUxUWElB?=
 =?utf-8?B?RnpjSVg5OFNHdS96SElBdEl0R2ZxMjRvdnY2MlVvMTFnam12Z2dNcUdIM21M?=
 =?utf-8?B?ck1mT25hZFc1V3VvOVBGbnFtZDBPcDNaSDA1TlhBeFlqUlRtdlh2b3YxMHdF?=
 =?utf-8?B?K3d3ZC9NU2pEbENWUDNoaDB5VGJBanNoTHRYMVB5aTErc2RNSjNabVAvMXFC?=
 =?utf-8?B?ZzQ1Q1Y0eUpSaVVxQ2JBQjc0TWIvVXZLRVdTSks3ZUtjbEhMVWxEZzUxLzAy?=
 =?utf-8?B?TEE3U0QzbzZzcEViVWh6dFRBTU13Y1hiWXhmNTFzbTJsYlZNMFJ2SVpGcHA3?=
 =?utf-8?B?Y1BibkJEL3BHNkNzckJnYU10b296TVRoaWVFYzc0MUdmZHd1MWc3YjcrSWMy?=
 =?utf-8?B?Vklpci94cWVTN1BHdmpkVzVyZjRDUG9DdTRYSWJVNEY2dXRGc2N3LzdVL3p5?=
 =?utf-8?Q?PLi1eHU+ZzoNS0yvEwyAcQGXT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ae423f-f302-4425-668a-08dcaaed9442
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:00:55.4177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8o2eygX0eJaFbu0JLZJDNZA0jpC8opCQMGd5fgO2ksHculoj0bdfId7VRZQpoJh4weVtqCiNhKWjJYMuOn6Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/23 10:40, Yee Li wrote:
>>> When dmar_readq or devmem2 read the DW of IQA always 0UL because
>>> "& VTD_IQA_QS". So, try to fix it.
>>>
>>> case:
>>> after vtd_mem_write
>>> IQA val: 0x100206801
>>>
>>> after vtd_mem_read
>>> IQA val: 0x100206001
>>>
>>> Signed-off-by: yeeli <seven.yi.lee@gmail.com>

I think you may need to capitalize the first character of your first and
last name.

>>
>> how was this tested?
> 
> If VT-D hardware supports scalable mode, Linux will set the IQA DW (bit 11).
> In qemu, the vtd_mem_write and vtd_update_iq_dw set DW well, however,
> vtd_mem_read the DW wrong because "& VTD_IQA_QS" dropped the value
> of DW (bit 11).
> 
> So testing the patch is easy,
> 
> config the "x-scalable-mode" option as below:
> 
> "-device intel-iommu,caching-mode=on,x-scalable-mode=on,aw-bits=48"
> 
> after Linux OS boot, check the IQA_REG DW (bit 11) as below:
> 
> IOMMU_DEBUGFS:
> 
> "cat /sys/kernel/debug/iommu/intel |grep IQA"
> "IQA        0x90        0x00000001001da801"
> 
> or devmem2 read the reg:
> 
> "devmem2 0xfed90090"
> "/dev/mem opened."
> "Memory mapped at address 0x7f983014f000."
> "Value at address 0xFED90090 (0x7f983014f000): 0x0"
> 

So you found it by checking the debugfs output, and it looks to miss
the DW bit. is it? Put a clearer commit message would be helpful.

Please address Michael's comment, add a "Fixes: xxx" tag and resend.

-- 
Regards,
Yi Liu

