Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1346AC10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4VYe-0002cK-9V; Tue, 07 May 2024 20:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s4VYb-0002ZK-MP
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:53:18 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s4VYZ-0003GD-28
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1715129595; x=1746665595;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=INUsY3zhX9tTr9/QhXzGWEAL/MP002yVzFM4mUclRYc=;
 b=EysrkHTRZZ96C1i5GtK2GrBReCDaAwrJkEQbRtSR4TlC5LZGk/VF11u+
 GEPRjfG/4va2pF/3x/hLNCI181fSiWJrEMFbsu7xmMNiim140CIFJ3gbu
 oAEdcuzkrLSXpVK4DDeAkGoLorGO8obmFL10A3c2Klmat0gCzdbeTVw9L
 0kauIzDI5UbbrK8kunfyJs8Casd73WHYuE7RU/PVVoroHp0g47vtLfa1l
 RnEvndcUXBLVe6Fwp5TPzeP+3PWVLXAJOZre7+GUju6CQsqy+5EUOBfGj
 r5BI6ssxthKNfF8lLi8sF6h6MJaKmREUjIp6oHFzqmIjRF4yY29vxPf09 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="118740430"
X-IronPort-AV: E=Sophos;i="6.08,143,1712588400"; d="scan'208";a="118740430"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 09:53:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEfVp/3/ImcCdwO8gspsVzzuYS/iKdmxgHfXyaIB3XXMXV60wjzdYPQs5aZz/82ZZxPt+NnRUf+XqRmijIxD/++GYF76xk2DUwhKa2Q4wwfcsRvhZHYqIN4XhxD6gaIP2te1uVJ3aKZoSltNii37r3EsFDY9+qK5uVt/OnKN2RAbt8WPtdj/xvo+jopE02lqA9EBbZ63xMmBpuTBwCQ5LJydW4qczR4mh0Hjma3RUTgArygGkULs75LEwVJ0+gniADIObJ3RVboLwOc70+s92cWF31bkSS11ZsNb9/yyAu0Cw2dzC7svaYQNXuQVKGtIW+YRw8gcAOrq9I1eOoREIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OA4r0Xi4fxNs5MKR0D5/B5ye4eBeD2oQVYdCYUIiD1c=;
 b=eZF1VQ/VKxfichzEQLPUz4yP8YvawXTdU//V3Dc9ffAD9b+4uTDooh8eoriXMOAGQXhCejz3dirHHEpiy1VrSgY3DT+4H/hEbbQXL46hJsbQeHw4VSU7ampzYeCtUj5rz+KrHPdmLxauVFYX9DmoxAcVDSwhhJE3zfkcRIf0AZsM/uwtcbxCf8yBQuO4FAhna39SlXtShdGWiG2Yl/a74nVlX28ZQFqgIL3qOSUa/LcKpAXZkttSqddmcbK64BaM5fVg4LB2KJX9uJWbLgw3BXOHZAwpQ+JIMjWmcE7W2RtUplHCCTLw8UVbGHsV3uOb0eDob1Hh4jwqYDAUbvqrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYAPR01MB5515.jpnprd01.prod.outlook.com (2603:1096:404:8031::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 00:53:02 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:52:56 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaiJjASti3D6SWj0SM7FILST9OMrF2vnZAgApJxoCACgzPsIABEYmAgACMOKA=
Date: Wed, 8 May 2024 00:52:56 +0000
Message-ID: <OSZPR01MB645366B7F74243B270E204A48DE52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453EAAAA6C5CDCF87422A588D102@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <20240430154307.00002879@huawei.com>
 <OSZPR01MB64537247C2BEC1980937EC198DE42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <20240507173035.00000039@Huawei.com>
In-Reply-To: <20240507173035.00000039@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d27c9299-ddd5-4aeb-aada-6f33ad350b1c;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-08T00:52:31Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYAPR01MB5515:EE_
x-ms-office365-filtering-correlation-id: 4f369b6a-ce6f-4e3f-1669-08dc6ef93309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|1580799018|38070700009; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?MjczMHZELzFPK1UvOEtOaHZQZFIwdWt4aUNzcWFmV1hiVTRCR3gyMTZu?=
 =?iso-2022-jp?B?RVVhcUV1bDVnWEcwWHNhckJDbldLZysyamNoVTBBTnRJQnhGNUU5bm12?=
 =?iso-2022-jp?B?bmZtRmFwQzlmRFZsTk5qMFhGd0dycEI2UlMzUXJDTTFXOXBXUXpwZGE1?=
 =?iso-2022-jp?B?ZmE0U1JieGs4RWIzNm14dkQxTkc4WUh6cE0vckRTSlJGTXYyU1doQ2tO?=
 =?iso-2022-jp?B?bGVoZWJXZUhtWnF0dGw1UGxRUGgzZ0cyeEZOc2JFVHlUNmdtaENqNDZS?=
 =?iso-2022-jp?B?L0M3ODJTMzdEcXBBaWc4VG0vbmlWZnNxbW9DNjNLSVpEN0tuNGtRVFVL?=
 =?iso-2022-jp?B?b1cwMzhVNU9rbnVOTmNmeGkzTkFkcGRiWjQwaU4wbmIveTd4cmZhUnRR?=
 =?iso-2022-jp?B?cS9ER3FhQTZzc21yTmxnRS84VWZWN3ZJYVZpQTRUZHZkUktqWEpxbjhE?=
 =?iso-2022-jp?B?KzJDY1hISmk3TFNieEdqcm1iejZHUVg2SlVqMGliWmlkcmU3MHRIenhH?=
 =?iso-2022-jp?B?QjFtRGp4WjdxcmJtQ3NaSlNuck1pSk9xZFZXb1JIeFEzWDFoMlE4K0VS?=
 =?iso-2022-jp?B?MkhOTW5xSXRnbTA2cWViUisyeWptdEUzMGJTZldBc2RiOS82SE0xOExp?=
 =?iso-2022-jp?B?b0NKbFFWZzA4SW5ud292K0h2NEw4elJRK3F2TVUzbXM5RHFsVjFIVTFr?=
 =?iso-2022-jp?B?RHd0ZmJNWDlBbkU2MHNpV3RCOGpQSVhGQ2lIK01iSS82VVFXT2FST3lB?=
 =?iso-2022-jp?B?Z0Qyck9hb2cxczZ4Y2hkbjVKZ2xzeS9GQ2dvR3UvV1BhVUI4K0RtVUVT?=
 =?iso-2022-jp?B?elRzdHF1U0FDMTNUMWZoam9CZldwSC9pRGdaYzFseGhjU2owaEJndFV5?=
 =?iso-2022-jp?B?azN0cTlQc2wvbmJPQlZtekx5R1QzK1JKZWlMMWV5NE9aT0NUVFZLRnYz?=
 =?iso-2022-jp?B?NFZIUFZOYTN0YVU0ODlKYXAwdi9DNDU2MHBoWjlVQVpHeUNUN0lkZWtu?=
 =?iso-2022-jp?B?TTBIcXhGT2NCNlYvaEZPNE80bmdPZ1N2TGkxZ3BwL2ZaRVFLS3VKd2hI?=
 =?iso-2022-jp?B?TXBlcFptVkk3bnNsV2JnTmV5VzZaM0lYRkxycmJiaGEzbzRVaDVwT1VT?=
 =?iso-2022-jp?B?WWprNmZkRzdyOG8xNlFWL1hSQnVodlExZFhYVm1FMC9VRVZJOHNqeXRQ?=
 =?iso-2022-jp?B?dVAxZFVoRFRCS1pacC8ydzZYZXNuRWJxM3JTR1NxT09lbmRPaGdzZ2px?=
 =?iso-2022-jp?B?UVRMQlFJOStUYkw0ZXVzL3ZvVjMzM1ZCT1dIUzZqSWxVb0hNOFVRM3pQ?=
 =?iso-2022-jp?B?aXQ4MjFiaWdXWHJxN3V2ZGxSWndtVkxyczBERy8wb0Z4U2hpeDAzUTdG?=
 =?iso-2022-jp?B?NXdxOFNuS09qSWF2ZkFwSjRna0VwQXF1M014QVV3dytYMDl1VTdubUs0?=
 =?iso-2022-jp?B?Wlc3UTNJK3Y1V3Z0UFFuYTFhcS9jUTh1Ukk4ai80d3VxRGJ4cTJHOVNO?=
 =?iso-2022-jp?B?SnFDRXFVZDlUY09RZjRyUVZjc0NyZnNOQkdaQWhOc1NFbUFRWVJjSUNu?=
 =?iso-2022-jp?B?a2ZjdktrSGpGd2ZMdSs1QVZlVytxYktadnRQZkxMTmdubklaZGJ1YmRI?=
 =?iso-2022-jp?B?MGc3aG1RTXppUkZRSDZ2b1EveWhDWDQ4Sk9HZVFReDFEUmNQN1llYUJw?=
 =?iso-2022-jp?B?SFRrekM5NHZISVI1SDBIcXV2aVJobVN6MWIxRUZxaGVFSnhtWHk5b1Vo?=
 =?iso-2022-jp?B?OU4vRWUwdmRuYmFEd0Q1VjNMRTYzcmpUclFLVC9EZDM5SjVvdEJldjBm?=
 =?iso-2022-jp?B?dWxEZ2dlT2pZQk1SUWUxRElKMHhmTnlEZ3djandReU9paEhDbHZ3WUhG?=
 =?iso-2022-jp?B?SE50NGc4ZTRkMDdhLzdDVmFFN2k4WFZjT01vbVRMczNoRnY1a1IxMlhV?=
 =?iso-2022-jp?B?b0pON3JEaEg2WFd5aXlFZy93Y0lnV1Btdm5QREZtMFNwMk95dUQyRmo4?=
 =?iso-2022-jp?B?OD0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(376005)(1800799015)(1580799018)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OEFUby9kWlNwYmRRdys2dkxSL081SHZWQnJJOWpDOGNXVS91K2ExQmlR?=
 =?iso-2022-jp?B?TkFobXdnN0pyc2NFQ0cwZnpNRzBaSHJrRHoyaW5JTEF5K2c4MEk2dU1Z?=
 =?iso-2022-jp?B?b0lyanNtTWcremlFTDMrdlArVGZmeGwxWDlDZmdRRDJMNU9ZRXdiZys1?=
 =?iso-2022-jp?B?UEkzVVI4RjBOT0hFeTJWRk9JbGZJYk9NMFoyc2JGMzZXdm8yYTlUNSs4?=
 =?iso-2022-jp?B?WkF3a2pwVWJaMWdJVjRDZHNsdGlySVN3YzZkZFFIT2pqeEFia0tHcWY3?=
 =?iso-2022-jp?B?UjB4UE5RMDlXZi9tYWVROW9kWTExQnVNbXJpUllxSkQ3Tk5HZ3RYZnVD?=
 =?iso-2022-jp?B?TUJ2VnNUeUlKUEx3SFNaWmljMDNTOXk2aFU4eXowL0U1SUNVTTVaQUFj?=
 =?iso-2022-jp?B?ODdpeVlzMXBaQnMxS21sVnB3Sk80V3N1bWZtWjA4ejRud1JtVzh6cnBP?=
 =?iso-2022-jp?B?cjFGWE1WbDJqYXV1Ym5YcUVFRTFyZUc3WHZBSEJxV3hkOXIwODVHQTd0?=
 =?iso-2022-jp?B?bmdmKy9mbm4vcTJXZHZGSkpnNlJaUHI0NGwwdkxlVm1jcldnL2VRcWtz?=
 =?iso-2022-jp?B?bm1wQ2VINjdEZzFSdklLSnBwZzdWUFQvSGJDMHRhRTE1KzVjb1VRWGUz?=
 =?iso-2022-jp?B?bjRvNGtwcFBSZDNBRitQL2ZsM24yYkFBcVhzMWFlTnhnRHlKd3pkWXo3?=
 =?iso-2022-jp?B?cVJEUUp3NlcveXB4bzNhR2ZyMGYrNEtMTDNzWjhEY0RDUlJBSmZZY0VY?=
 =?iso-2022-jp?B?dHM0NXFKT2RZR0NrYVlNekRTQjJXODZHWllvZWFKck1EdjlmdTVjeFlI?=
 =?iso-2022-jp?B?RUZqay9nMG9oeHF2TzF4ZUFwUWZGdC9VVVZkd0FIMU04Tmd6bHFkT3Ja?=
 =?iso-2022-jp?B?SFB6TmlNa0ZJKzhuQm9YOHcxUDVwc01oVXl1Q2NuRklnS2xHUTUzY21w?=
 =?iso-2022-jp?B?dmFlU1A3RE5FeENQRzVvcHZVY0EwTWx1MmN2MzhFUVFKaVFUTXh3NFdI?=
 =?iso-2022-jp?B?QVdOTW95TW5KeEFtN1lKZ3VCNElxYkhWVlJYUWt2ZE43dFNqSTdnSFdK?=
 =?iso-2022-jp?B?NVNHRG5UZ0srVHVFSFRvNitYVEhJOU9IWlJ1TlJpT3VKemRoM1BSS3d0?=
 =?iso-2022-jp?B?dzNBMENiUzRMTDg5OXdKSGRyNXRWaGkyVjdlODhFdnRMTjVRc21PSEZE?=
 =?iso-2022-jp?B?YUd2SjR5U3dmaFhFYll2YlU2dEloalBhWC8rbDhBZE5BV3BkK0ZFdjhJ?=
 =?iso-2022-jp?B?V1VqZXNGNFQreHVLYjlIL0hJb3dMRURzNmtLRzlTNy9uV2VKaGN3Zkcr?=
 =?iso-2022-jp?B?YmdnRVlBWDlvOUV4WnQ1a1o2MDE4M0J0bkYxTkxzdTJ6U3JJalVXZ081?=
 =?iso-2022-jp?B?ckNja2JXQzhpaXhtaGFQUVFGSlg0amg1cktjUWlLalROa3ZIUlluSnVO?=
 =?iso-2022-jp?B?dDVIWGpVZUNoUnpHcHNoUWRUdlBBaEkyaXlaYWJtRDQvQTUwYXlzejdH?=
 =?iso-2022-jp?B?YkJiNTB5SjBnSVNnMHY3WmY3cVJEQTAyMVBaSS91SDJhcTlNV0tVV2pJ?=
 =?iso-2022-jp?B?U2dTTmVNdVo3eExDeVI3ZjhhczRzNEcxMk92N3ZCU2ZwNi9oZEtWbG1L?=
 =?iso-2022-jp?B?YnRhU0s0NktxSjNMRi8yeEhjU2hxY2R2YmZGRCtZbnkyaHNMd0wwckxy?=
 =?iso-2022-jp?B?ZVF4ODNseHRSNzZGb0E5UTBBeXNJdmxwWk9BNFFsWm82dnBOTVd1M1hr?=
 =?iso-2022-jp?B?ZERKUHpDOFhDMGZ1aEU1TW1xeHZKOTNNY29WYkFEWEF0VEpxU0pmdy9D?=
 =?iso-2022-jp?B?SHZRbnVPUUc3L0RMK0pFMERyQXNhUFFHd1ZjQVdQMDZJSHpQNE9sZ3dK?=
 =?iso-2022-jp?B?Q1pzS0ZiZ1VpSzUwQm9OaTdqdFlsVlRhTlc2VE9uZUhiclBCTitMVzNS?=
 =?iso-2022-jp?B?UFp1WDdMeXFDcE9pb1ppOFA5UEVKTUFpdVBWdjlZVFNYYjF2c2pzUFAz?=
 =?iso-2022-jp?B?TytnS2oxK2dhZlVsZVZSNHVKczhGdVdXQXZWT2FxQ2xEZUlXQldHeURo?=
 =?iso-2022-jp?B?N3IxV015aFY4NnVBUUQ4ZkFrTVdEcHZHSFlxa0w2UXpxalNCWitKWXNn?=
 =?iso-2022-jp?B?eVdiandpUUtSOFFiUmhXTEpFN2IrVkZjSy94R3c2MVhEQldEZDNZWTNM?=
 =?iso-2022-jp?B?SFhLK0VLOUJzT1U3blZ4VkxhTDVRQmEwaHFETFloMFpDZXBwb2p0VVdD?=
 =?iso-2022-jp?B?UXQ4bEFtT3ZsR2Vibi94OE9yVlRRUVlyMkVPYjQ2dFpzbUsrak4wcnEy?=
 =?iso-2022-jp?B?SitYdQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: urZSPE602muDS7lBfDV62XLC4JGwf7S+UIdEPXCVmn4VgzmxkNQJYlXm0QpuSnajnFHQJIzDTSKhs7A/XPFQdV/wx0Xa6oeekSWca8LBjdaq9e8mCIkSM1Y/Zf2Sxc553bjykbPJknh2q/HKZxg10zfNsZkt/rsjKxfc+XDMosQ0JsJQd3E4YIcdfji3zXFNnwFB4yXO5FiUIp/U1+LPY6OlYr/132dPIFJnBilvjTOwQgjnLIQ1+GU1A27QU73Z7twzkLl1BLbVFl9SSPEmAIkitO/wXOrE69o0ZZm5d73ylGtKNNyit3E08dVAEru5u5OXz58+FHa2buuO3pbN2dP0ZdW6ZvAEzmns6GhxQxubjEl6wv2EWzh7whlpLL7pTWXK7KtM5L63RbPIkRpl3xThjggBl6LPi2WRrS8VGbag7B8xBLNp11+QUVJ3UeTFYHSmXXhM93PYPFzxeK4Yxyac6IVweV0iO8/a9dw9S49ckKW/MLQgK0qzahalPBXNB/NcHFvne7axNV1WECxiSYzhbdNZGTlLrYDPuJ5nhObr5I8tds8t9g71he05lEHQVoe8UcT+5GqEFdwVo/beJd0VdrBlnoeBzXpQh9akwlw2gZSeUcDfZbSxotE5MZeO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f369b6a-ce6f-4e3f-1669-08dc6ef93309
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 00:52:56.1714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJt5V9wUGFcAa9BJNaJ5ft6Ss1uH/MxJBjv/3Q1QLo2jxFx1D/7fg51DK5qCa2fDBdMsSClSISu+NBILrL+BoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5515
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
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



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, May 8, 2024 12:31 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: fan.ni@samsung.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave=
 ways
>=20
> On Tue, 7 May 2024 00:22:00 +0000
> "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Sent: Tuesday, April 30, 2024 10:43 PM
> > > To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> > > Cc: fan.ni@samsung.com; qemu-devel@nongnu.org
> > > Subject: Re: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interl=
eave
> ways
> > >
> > > On Wed, 24 Apr 2024 01:36:56 +0000
> > > "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:
> > >
> > > > ping.
> > > >
> > > > > -----Original Message-----
> > > > > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > > > Sent: Sunday, April 7, 2024 11:07 AM
> > > > > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > > > > Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B=
(B
> > > <yaoxt.fnst@fujitsu.com>
> > > > > Subject: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interl=
eave
> ways
> > > > >
> > > > > Since the kernel does not check the interleave capability, a
> > > > > 3-way, 6-way, 12-way or 16-way region can be create normally.
> > > > >
> > > > > Applications can access the memory of 16-way region normally beca=
use
> > > > > qemu can convert hpa to dpa correctly for the power of 2 interlea=
ve
> > > > > ways, after kernel implementing the check, this kind of region wi=
ll
> > > > > not be created any more.
> > > > >
> > > > > For non power of 2 interleave ways, applications could not access=
 the
> > > > > memory normally and may occur some unexpected behaviors, such as
> > > > > segmentation fault.
> > > > >
> > > > > So implements this feature is needed.
> > > > >
> > > > > Link:
> > > > >
> > >
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> > > > > u.com/
> > > > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > > > ---
> > > > >  hw/mem/cxl_type3.c | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > > index b0a7e9f11b..d6ef784e96 100644
> > > > > --- a/hw/mem/cxl_type3.c
> > > > > +++ b/hw/mem/cxl_type3.c
> > > > > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d=
,
> > > hwaddr
> > > > > host_addr, uint64_t *dpa)
> > > > >              continue;
> > > > >          }
> > > > >
> > > > > -        *dpa =3D dpa_base +
> > > > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > > > > -              >> iw));
> > > > > +        if (iw < 8) {
> > > > > +            *dpa =3D dpa_base +
> > > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw=
) &
> > > hpa_offset)
> > > > > +                  >> iw));
> > > > > +        } else {
> > > > > +            *dpa =3D dpa_base +
> > > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) &
> hpa_offset)
> > > > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > > > +        }
> > > > >
> > > > >          return true;
> > > > >      }
> > > > > @@ -906,6 +913,9 @@ static void ct3d_reset(DeviceState *dev)
> > > > >      uint32_t *write_msk =3D
> > > ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
> > > > >
> > > > >      cxl_component_register_init_common(reg_state, write_msk,
> > > > > CXL2_TYPE3_DEVICE);
> > > > > +    ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > > 3_6_12_WAY, 1);
> > > > > +    ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > > 16_WAY, 1);
> > > > > +
> > >
> > > Why here rather than in hdm_reg_init_common()?
> > > It's constant data and is currently being set to 0 in there.
> >
> > according to the CXL specifications (8.2.4.20.1 CXL HDM Decoder Capabil=
ity
> Register (Offset 00h)),
> > this feature is only applicable to cxl.mem, upstream switch port and CX=
L host
> bridges shall hardwrite
> > these bits to 0.
> >
> > so I think it would be more appropriate to set these bits here.
> I don't follow. hdm_init_common() (sorry wrong function name above)
> has some type specific stuff already to show how this can be done.
> I'd prefer to minimize what we set directly in the ct3d_reset() call
> because it loses the connection to the rest of the register setup.
thanks, got it.
>=20
> Jonathan
>=20
>=20
>=20
> Jonathan
>=20
>=20
> >
> > >
> > > > >      cxl_device_register_init_t3(ct3d);
> > > > >
> > > > >      /*
> > > > > --
> > > > > 2.37.3
> > > >
> >


