Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB02C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 09:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sARGo-0004fA-Tq; Fri, 24 May 2024 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sARGk-0004dw-F6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:31:24 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sARGg-0008QT-M4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1716543078; x=1748079078;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PFBIn3N+B6kIXqcP2anYd5jsVXo6aCrPwCBu1Z98MYY=;
 b=BHQZp40XOABhGv6AqxrzW/GNj1elG391CSLTiLcLAYiyuScnOvcRGPWw
 OkYN6+zXWCxATLCR2WoL1oC2OA9A01bkMR0I8bkQ31LN+Xa/3LPfBOEmg
 WJ0PFytDIJJjKFV3agiSBTH2wqQD4cPthEsLCOCzfJAVTi6A5eQ5yCFZ3
 jOJTn2lnvALo9mBbSFVQpylZyj0L3Xp83BSP1c5mlehj+PI/F46OLZNPr
 o16T72+qPXV7pb5UkIO04mHNQ55JTeWaNh07xr/Q9FZhMp5eN6Wn5mLWT
 yP5OOzh4SJvL1yga/HmJqyli8dZuOdSlugeRUxKkbo5pVJoeFKlxq+wb6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="121176967"
X-IronPort-AV: E=Sophos;i="6.08,185,1712588400"; d="scan'208";a="121176967"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 18:31:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp9nA4LRm1CxlWNqIx7b0OZs4XscJl30x/hM57RAI0ggkaDxsNF2rrwIJL8O9sNu2XrySErHW4BeSUh+RM/6tiSSuCsfh41VXCfn3Q3uv3qk7/bD6UOQ8qMlYPLHJ7Hh9/d1pRSN+gvKAF+Bezm/YbZfYfpM3Mc51sC5g+TWO4iAbwUaUeOTqxRNnFINAKxfTB/qzjGrKa7O8qChRRGWD6AIDTtwaOIqnnQimPM1CGC/HYMrGrZ45VZDWe70fVORrOEE3k6FcOOe6zvy/taAmVCgiNMEPmOjj1O+KfLY/0wUjL9INUDr8nwC5y9a/NjMuUTZ5nO0B8IhyBZL+4zHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef4xIhsxSap8d2k9YA/vgA7kgVwYOuoEts62i5z+B8c=;
 b=H2GZAuZ4A6X1oT8cfM10NH2YiAeMgjGtItrGiu9xCkw84t7IiSMHF3rC4hHWDpk6UGAQgEVbAWg8PrTryFftF7UOG81r6V8iWtuaSYIjw4oKQVDadwRygxZdB4tgeGyLYVIa5pQ9Y1TdFhLzonKa8dhniqp/VlabZ5zQ2xaVkxt8tPRpjYV9xBaLYVxM6NhUVVgQpB0natBK85F3pz7QNmYUzkxOiRjPIAIkzs9L7JyLt2g+LXqyeflKrkUONYdh4jW59CAnFH3TikMqD9IGTCcD/0OQBA4fWdjawDEbGGgvv2pkq5fLy0LLZUjm+7i/SSZ1tnpQRAr3f6+c1ytLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSAPR01MB7445.jpnprd01.prod.outlook.com (2603:1096:604:143::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 09:31:09 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:31:09 +0000
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaoOInstysbz+9jUG5HE3z+Vg/FrGmOFTw
Date: Fri, 24 May 2024 09:31:09 +0000
Message-ID: <OSZPR01MB6453BEE69D709FAD5F5431228DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=9a27af2a-43f9-4df9-a8cc-b2b79f5df466;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-24T09:30:49Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSAPR01MB7445:EE_
x-ms-office365-filtering-correlation-id: 51978ed7-bc06-4303-66dd-08dc7bd43e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|1580799018|38070700009; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?Z0lEZDRCN05YR01nU1lPWW55K1dESlZXaXlvaVd3TkZiNnRRVFR6S1hl?=
 =?iso-2022-jp?B?Q09JZVhHZHlKcFV5d3ZxM1J2UDlUQUhrMDdvL1YxaVRQcVlsRHU2ZUxs?=
 =?iso-2022-jp?B?U2pSUkJmT0VMMHRXRHQxaloxUmhiUVQxM2dQUDhxM1NnMU5oRVFGS21a?=
 =?iso-2022-jp?B?WjU0dFhUSjA5MHB2NmFDU1FjK2pIT3VxcHVBWHZHcyt4RUNLb3lhOGNz?=
 =?iso-2022-jp?B?U3loYUhkbEhkdk92ZXBueGVYbGI4Q1RQMFI3a24rYjYxOWllQjYvMzJ2?=
 =?iso-2022-jp?B?aStFZkxocnFJNWFTL2N5RkljenVTTHlnSXJ6aVRSRVd3MkpldUM4d2lU?=
 =?iso-2022-jp?B?ajZ4Vk5PKzNuZW1HaXV0dE1kRko0c0drNWpXbjAwTXVOa2liWDc5a21D?=
 =?iso-2022-jp?B?bzcrSGZ1RzVlUWlMbS8xRXN4M0I2WWxIYldNcTByaHlkWTJnTjI3SlBH?=
 =?iso-2022-jp?B?OFpxOXhvVW5aL0g0eFR2RVZNOXdxTlY4TzJzWE01T2QvemlyQy9vRHpj?=
 =?iso-2022-jp?B?TDJXUkNCRS9lTDkzSWxMYTh6a0JRSklOalpIVTk3NDQ5Y0o0aHdYNUg0?=
 =?iso-2022-jp?B?VUJmQkI0MzJOMmcvWEZwY0dsbjkwTE51NVFTNC85c0dSekFwZ2hWd0J2?=
 =?iso-2022-jp?B?VXJFV201akNEL0VCMC9EdCtsTHNpbTBmcG9lVjl4bW12Z0lhK2Z3YytM?=
 =?iso-2022-jp?B?bC9aS04wVmF6OHdpOXZvWEpMSTZKYkR4Ullnd1VNYXYwNXZEZzdrbGlD?=
 =?iso-2022-jp?B?cSs2Q3RhMzdsUC9nMW9vREhuaUdGMVpPZ2dVeCtZVTBoeFBRbzFCYis3?=
 =?iso-2022-jp?B?VExXcUxDL1QxaGljTVFuZWJpTksxYlVzY1pHakdqVVY0VTlNcmhqWisx?=
 =?iso-2022-jp?B?VXlBdFYwUkRJVHZFN05tSWhWaFVaQW5tUjh0TThSakttUVNnOTBmd1BZ?=
 =?iso-2022-jp?B?Y09MM25oV3hERlFGakVodEdNSFAvT096NU5kbXZNZ2FtYlVyeElydFda?=
 =?iso-2022-jp?B?ZzllZWVBWmZsVmYzRjlQYWZQMHRuTitPZVFYUkhqYjFtRkZhWTFneFc5?=
 =?iso-2022-jp?B?T3k4STE5SmQxSGs1bkZRY2VnQTdaalhoT2ZxenlZQnNXTy9XeitxSUJp?=
 =?iso-2022-jp?B?T1FsRmJlTWFGZFJmNjdadkovU0IxQmQ1RVBjWmRwLzUxNmxLclhOL1M3?=
 =?iso-2022-jp?B?Z2RZOG1kMklJT1ZkVWpocEFJWXJId24zbHlzL0JPdTdCZTZCblREOEJw?=
 =?iso-2022-jp?B?d3JleThMR0lFUVU0WG56NEZtaFVaNXdIanZ4YnhDSXVHYzNMSUhxVE5U?=
 =?iso-2022-jp?B?TGVQNFd1YnF5ZGdSR3NYT3FoUHNKZ2NmbzFNNFJsNlZrNllZbUdnN1JR?=
 =?iso-2022-jp?B?NVpjVHorck1QREVIRENoT0w4d296UUk1d3ZTcXB2Z05VWmh0UFB4c1Ns?=
 =?iso-2022-jp?B?Z2IwNDcwVTRKOXY4eWlXRTdkanJMdldiWkpZbHphMHAzRGZVUlBTTGtM?=
 =?iso-2022-jp?B?aUtmZW5CRFhpK0I0VmpaS09nZElpaHB1UjN1bTFvQmQxZ0Qzb2lwaUpl?=
 =?iso-2022-jp?B?RnRyc05LcTRGRkVUU3liWjhwSmRQVE1hMFhnd0oxU0NyMnhhS2ZRNE1x?=
 =?iso-2022-jp?B?OGNMZFMySGI3aUtsc1F4M0hrTTNLRG0xenMreVAzTXF1QzFHSjBUVXhh?=
 =?iso-2022-jp?B?aU9Yb2FFbzYrVkRyTEhHVlV1YStXZ2dLMHNKcFZwR3NxMmZNT1pKbEpl?=
 =?iso-2022-jp?B?cmFjeEJUQkljcjZDNXdoNDV5cGRIV1UyY1FDYnVpaEY2Y3BhZGMza0My?=
 =?iso-2022-jp?B?c3pSRUVxWEoxQkpZUllLT3FjUnI5UmJaN0RvR3IvSXIyM2VOcDFmZzdF?=
 =?iso-2022-jp?B?VjVUaytqUW50MU1iRFBTWTU1b1VZPQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZllQRTdsTUU1LytlaHdqRkRuVlRJUWwzTFV3OUlBRFN4UnhEZFBONnB5?=
 =?iso-2022-jp?B?MEFzeXNJdUdMZHBxQS9MaVlaZDJYdFI1enBRWTlSOUVlSzFMYlNRQWdO?=
 =?iso-2022-jp?B?MFkzbVZWbXV6MjNHaUlIK0ovQjNCTWdoc1phcFpKTWRWRVBlNW0xZHRT?=
 =?iso-2022-jp?B?WEhyWGFPQlFIMnZEMzhZTC95STNjNHRReUQzVzNuWnl3ZW5DM0R1R1lq?=
 =?iso-2022-jp?B?UXpLc3d0alVubUVDVVFSbFZRVGwwMHVvcWVHZmdGRVRsVTQwVVFGT0pI?=
 =?iso-2022-jp?B?YVErbTg1K0ZHWkpIVDBFR29FQ2NYaFFBTXV2Vnlsa1pFVHJZVjRkeHZh?=
 =?iso-2022-jp?B?SVNicmk5S0tkZGVoMCswbVpZVjF3NzJCakQrM1prMUdrMXBVZzkyYkQ4?=
 =?iso-2022-jp?B?Z1hqYndYQll4RENOd214K2p0aEwyZ0pCdnFXRC9qYjk4cGZYcVBrNnpW?=
 =?iso-2022-jp?B?bThiSGJrS1JBVEFGZlZwbkNETElJckxUOGFvTWhJSWF2RVp0UkRNdmg3?=
 =?iso-2022-jp?B?bzU5dmE4UDlBdHphYXdBaUtPQ2tjWk1uVEVjWWxQQWxKQ2xuR1ljSmZW?=
 =?iso-2022-jp?B?OHF0c1JaeFV0SVJoTmN5cVg3MHM4QmJSWllHTSs2UlhYMDJkYWhhN1ps?=
 =?iso-2022-jp?B?eU9TRHQxSkRUc01HWFR0VVhIM2NrZy9yNVlrNTVlZnY4bWFFcXYvcllM?=
 =?iso-2022-jp?B?OVJsMkFCWGQ2T2NwN1N3eXU5cFJlc0I5aytuZHhYWnZ2RFlvWHZoclp1?=
 =?iso-2022-jp?B?Sk1aMGRFMWphRlZQdWplRktpY2ExZU1QU3dIRzROWG1zRmVmV0t4dkI1?=
 =?iso-2022-jp?B?MnlPRHNYdFlKU2RYR0FzOTA4aTRnV0VyeURzR3VmU2c0TFZzZ1ZOV3Y0?=
 =?iso-2022-jp?B?Y3NsY2tPRmxVbnY1RUJQakJYaUQzdDFSV3p3eWtrUTM4UjkrdW9iWHpy?=
 =?iso-2022-jp?B?WEFxVUN0NmNsYnZIaWFLRnNaYXJvU3hCS0R4WmRrajJCckpJUys3M01p?=
 =?iso-2022-jp?B?K1ZTdzFWVGJQWFVPVlZ4cGdjWk0rZk05SStnL1Nzb3BaNDhOUmpyMW1P?=
 =?iso-2022-jp?B?cFQ3UUhDNjdlNkFMQndmb0JlNnR0ZVJHK0lLSXVMZVFvbktIaU84MGp2?=
 =?iso-2022-jp?B?L3VZUU1CS2xrMC9uSlBSQldDR0RPRFFEcEhUT0oxUHc3VWJaaklJVnJy?=
 =?iso-2022-jp?B?RHpWNjRWeGNTZFJ4UEE0am10cjBnMElUK2hpZWhicXRKZDlkbHJJOGZ1?=
 =?iso-2022-jp?B?SUMwQWlWZXhZVHFTaVhIZU1oUHViRTliVzlDRmErbE1SWlVJb3ZRb3VC?=
 =?iso-2022-jp?B?QVJOa1BzSTZONjdKaUUwcGFPSm1vVkpIditRSUlJbU0zZ3pCQy9BREVi?=
 =?iso-2022-jp?B?WEJHekRId2pFQmpMbUVDY0JsTUN4TE95VzJhMERROExJU2VNdFJvRWdT?=
 =?iso-2022-jp?B?cFVaUjBxM29MeTJFYVVwWEJzd1BidUR3dHV5NmJsZzN0ai9XREIrRVVq?=
 =?iso-2022-jp?B?YnYvcjBRcW5JcUd2RkJZOU1YMHFKcVA3aGR1Q3ZqMTRrSW9GOUgxS2RV?=
 =?iso-2022-jp?B?SkRiSkhjRlZOU01FdENKRVdCRGlRTURxME1XNTZ5RU9mdVcwbWlyMTBy?=
 =?iso-2022-jp?B?U042dEFScDlNcU04V0ZyUE9neWl1V1A1NXN4QmdsQkxEeHk5ckhaS2lh?=
 =?iso-2022-jp?B?SkV4a21mZ3htYmRaeXdrVHVsdWV3bk9BREFUcmZkWDdwZ082ajZHSWV4?=
 =?iso-2022-jp?B?STFKeGVpL3RJSExpV1RmaE5nVWJCRUFjY1RJSmhKaUtEazA2UEhGZm55?=
 =?iso-2022-jp?B?bEMybkRIVGcrUlpXenhadGx6RG9XbTNxUFRMWFUrcFpHL1hGbFRObXhq?=
 =?iso-2022-jp?B?ZElQUWRRR0lZMzlPQlNWczE2UVNLYjBiNlVySk9lNHQ3NW5Qa0x4ZlI1?=
 =?iso-2022-jp?B?L0sxcm9PdDVEQmw3MGUyT2EwYmxiaGIxU0xDUnNBOWlDYmdLV1Z1YlVu?=
 =?iso-2022-jp?B?RnJLNy9WRUg0alVCYkxXRW9rRWFDazdSdXBZbHdiMGsvdCtBMTRvSDFE?=
 =?iso-2022-jp?B?aURIOWNJc0k5SG1aRGhpQzNoU05Jamh0ZWg4bythNGVUR0U0c3h1OHR6?=
 =?iso-2022-jp?B?bmVWRGNaaDF5eURqM1I2ZldtVUVwVDFQMEhTWllJeGtwYm5vZ2ZueDZi?=
 =?iso-2022-jp?B?MEF6SXM3Z2RiVDNXQ3VnOVQrNFFMckRpRGVBOUFhWTNvZ3Z2Wm9NZXRD?=
 =?iso-2022-jp?B?YTYvaFJnVGFRZXhtRnQ5d3c5NmkvdHFvUUFPR3R6UUFQbnN2b1BROGJp?=
 =?iso-2022-jp?B?L1BQRg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2LIm7/Zl6q+oYG9H4/lAyuvWzrszPvoJ6nQV/isFp7rxCoTi0X+oC2z7hcqC+KhyWMjsHbYcIsekz0MsilJV40sxFf79DUfTYkMAbwEwuZS04czOjshWZ4HDUVpoYYyDovK88+1jeUqEVa+KdRSontbmgz2R5FYlySqutGTxaHmfCqmqWIP3KG55hruxNjQvIASY0EWURY1skbDFXMzayUQNKGGM7K4amDGsfERRNpSie5hyTQmeAGU3RKUNIhLke8iEApBcDgPPH8ADkQYDCio3Hf41FwXxnGcAM8E8IXPW1s9Tq3+IgQwlIZmqIN32QDJrQFjcPh4ClxpKnlrniDCAdNsnjMBVtaMe32odE5XoN/v+3pDnZbK50esNfDoBnCFfapgF66dpnPQV8OArvYzS0RpESoRbxxcyVrQTC3ZkHQpcWbrvchSvI3xVoGsNE2uKBVj8lfovLMsBoycCVEFOZfoSEzNKapmpVeTWxIajhQ5o1XkZ5VdjnhLbFlxTLLsPi+hqgEy4xvBQeZlqLOrAD7zbP5mJ5DSrD17X1HwYwOuIpxfBTb1AxYvjA/0+0q+xBNCuc2dDmz+B3aL+Ab9a41keTRgNdt4LiJaLNXueU4y425bZIywqilPid8hS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51978ed7-bc06-4303-66dd-08dc7bd43e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 09:31:09.1227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qt2sNzACEGDghi6PFY76m30A42Co3vZm1Lc3ruppK6GkP3D2OHvb9pTAv66EK8zcGHtwgCM5gvTdYdgsf8SB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7445
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping.

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Wednesday, May 8, 2024 8:53 AM
> To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaox=
t.fnst@fujitsu.com>
> Subject: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave way=
s
>=20
> Since the kernel does not check the interleave capability, a
> 3-way, 6-way, 12-way or 16-way region can be create normally.
>=20
> Applications can access the memory of 16-way region normally because
> qemu can convert hpa to dpa correctly for the power of 2 interleave
> ways, after kernel implementing the check, this kind of region will
> not be created any more.
>=20
> For non power of 2 interleave ways, applications could not access the
> memory normally and may occur some unexpected behaviors, such as
> segmentation fault.
>=20
> So implements this feature is needed.
>=20
> Link:
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> u.com/
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  hw/cxl/cxl-component-utils.c |  9 +++++++--
>  hw/mem/cxl_type3.c           | 15 +++++++++++----
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index cd116c0401..473895948b 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state,
> uint32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> INTERLEAVE_4K, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       POISON_ON_ERR_CAP, 0);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 3_6_12_WAY, 0);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY,
> 0);
> +    if (type =3D=3D CXL2_TYPE3_DEVICE) {
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 3_6_12_WAY, 1);
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 16_WAY, 1);
> +    } else {
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 3_6_12_WAY, 0);
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> 16_WAY, 0);
> +    }
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       UIO_DECODER_COUNT, 0);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e42490b6c..b755318838 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -804,10 +804,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr
> host_addr, uint64_t *dpa)
>              continue;
>          }
>=20
> -        *dpa =3D dpa_base +
> -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offs=
et)
> -              >> iw));
> +        if (iw < 8) {
> +            *dpa =3D dpa_base +
> +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_=
offset)
> +                  >> iw));
> +        } else {
> +            *dpa =3D dpa_base +
> +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset=
)
> +                   >> (ig + iw)) / 3) << (ig + 8)));
> +        }
>=20
>          return true;
>      }
> --
> 2.37.3


