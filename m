Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B4C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 01:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUFf0-0003Cb-1H; Wed, 17 Jul 2024 21:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUFev-0003Bm-W7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 21:10:14 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUFeo-0008K9-43
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 21:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721265007; x=1752801007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aYkpe/YHuC2F2xK62pLxQTCOWrB10FvSsDgsyIzYqGg=;
 b=TTsZpKi9Os7lJNN4Pnf34b4AEZgvASXgwajaS7+XEyfYtvuou+FEKucQ
 gu1Ca9Xqn2NYAm7BsG0+nN6pQALfKoQUn2sb39TG90Y27SeUpfOQ3cjHc
 z88ILaKVgj5IBRQ8KXukhn5ek1jc1yqfw6vfdtSkwsoeiuhvWXeYnEZKf
 QA6xNhOYS9EEb2OMbDKSiSDoILRWo26YKGEUjUOf9UzHfSjvWIvdx/p6m
 UMlzfwQcs2XZNFWd5h3Ijp9dRY5NBKH4vBczSrocZF62U2HCNXQJI4Cpd
 ej+jrfzGEkaBol5KgjOxuiSvfLeO/EHgeAPJIVHWnEoSNfO4R7KXcslS8 A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="36546668"
X-IronPort-AV: E=Sophos;i="6.09,216,1716217200"; d="scan'208";a="36546668"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 10:10:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9j9SMgKPJFWRGDOf7kIuAAVFlhfyLPw9D1D5ykWiXOU8uD1ixkERhpicAe9A2q7YouTZpQP4cMkddbnDgKWUjtUxkOZR0UcuggFAiYmo376jVy7NhxuOgPYx1ePFazGZCmKCtCl7xoLNm77HEQv6kC8f6eXN6l+3AbAUVgWa3ZybRZl/bPh24OK8WYVv27+TQdbH/EUOXmKaFR1DG7DeXYkm4tjFRuGUcqgwaQipSMKopguN/osbRHKBt+XWn/MUWrXQ2ujDh7M/ajNLn3KvaJq/qFJYuzG4zCPkwdfZC8EiBVjy02AFukFs/Ap4RBe/5nqYRXzD8Z25jEMgx/p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYkpe/YHuC2F2xK62pLxQTCOWrB10FvSsDgsyIzYqGg=;
 b=gludHa44TMME3clQWAZ9/K6OS/mEIFYL7M00b5vcAD1SIMyVW6oVFTFej7/P2FGlOkZgYSjYjZMU1p8EHmqa2lq/FMUdmB7IM4Wjqc950ZEJ4MGoaTaNbdtF/wPDAccTHPG4tR82cFp1sAMDXglGp6/QEh/bhD7XrqG6K+uKNXFN+diETY+nC7ekUKFM9DbSPvoDXZ+7QEV5P6V4QaStDoIn8vSzhzLwLR8+EJhq53a0manS8fnlATMYgGk93xmkTdYf/iDlXCJMPL3R10SVMXurQHQJRQ/Qzqe4aQiyD11KpxoqqA9OyJhDxuD984Fge1VoOGijb8GH8VdoUkJAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by OS3PR01MB8490.jpnprd01.prod.outlook.com (2603:1096:604:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 01:09:57 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 01:09:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Topic: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Index: AQHa2Cc2VreJNBdJJkewrW1WQKBmJrH60pUAgADbCxA=
Date: Thu, 18 Jul 2024 01:09:57 +0000
Message-ID: <TYCPR01MB6464B84B63945D21F98A6A5A8DAC2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
 <20240717080308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717080308-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ec161656-dd4a-44fe-952b-71c6f6e0e05c;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-18T01:08:23Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|OS3PR01MB8490:EE_
x-ms-office365-filtering-correlation-id: d6607035-de32-4d93-649d-08dca6c656f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?ZnBRdDIxZHlmMHV1MWlSVVFwdUZXdmRDN0dCTE5Ia29yL3NiQ0NabUYv?=
 =?iso-2022-jp?B?YnMrOG50dmo1OVNNZFowRW5XamxDcXZ3RXRnMXFNWkdxZytZd3VmR2pr?=
 =?iso-2022-jp?B?YkliUVpvcnhVOS9LRGh5bmlUMnh1YlRQUmFod0JtVGtJb3B1dlZMQjAz?=
 =?iso-2022-jp?B?NEl0KzVvNHBsRWdQT01LaUVFWTJVS0NBbFB6SWcrZ3UyR0o4Y0c5SUI3?=
 =?iso-2022-jp?B?NEdvbGJmSUpMQ3lQT25MZ3JRLys3TG5JaTVBcFAwaUZPaVpadTVxZU12?=
 =?iso-2022-jp?B?QzRlK1NTQzB3d3ZLK3E3TmlkaktTNStoakIyVVVWcW94YmFXZjc0NDdH?=
 =?iso-2022-jp?B?ZUR0Z1Y5ZlNHR3lkUElobElCd1A0azJxeVNPMGlyMUNHZy9hblRFWHJZ?=
 =?iso-2022-jp?B?ZFUzZGpFeVIxcWo0dkpOZ0ZqVjlFSHg3Q3lLUWVFUHZYaGVnbG1ydUJC?=
 =?iso-2022-jp?B?cVkzYkVrenViQ2hHSjJ1VGd2aG9Yam9yVWZEQ2s5SisyU210bFJlSVdO?=
 =?iso-2022-jp?B?Y2JIbys2YzN2bkhsWE8vbWw0OStyelJCalRFNUJXMVNFZEJhZG5tc25r?=
 =?iso-2022-jp?B?V0N0ZjJ0clJpMVByQ2Fsc2xKUHhVV1BTaHpnN3gwY3dBRnRna1RIcDhQ?=
 =?iso-2022-jp?B?aUN3ZHpJTzRSbFkrS2dEZjRyZ0dMTTFzbnBDQmY1bTdnSzIxSE1aMUk3?=
 =?iso-2022-jp?B?Q1N4ekJvY0R4d015S2VkbytPNEE0S1A0K0NHUUwvZG9VT1FGK2EzckNs?=
 =?iso-2022-jp?B?ejFQZ24rUU1VWk5UN3lBNTZ4cUZTMW1OaTVRRkE1UXhMTjZTQkdjWnlS?=
 =?iso-2022-jp?B?SFRleUh6Y0xoVHJWWjFPb1FscHg2WFozcnJQZStLemJCblRBUjFyK1Yr?=
 =?iso-2022-jp?B?Uk5OWmdNcVJXL1Bpa2xHQjkyNVJKeXBIVFdYMHJqVndNQVBxZGJ5YWVP?=
 =?iso-2022-jp?B?bkpBaVFKV2JmTit3aGw1YytHMXZQdjJVeFF5QnlSTDBmMTAxckpyWFB3?=
 =?iso-2022-jp?B?T3NDNUZscFhIWFB3ZGVISzY3Tk9rVExyOFI0c044bEw1TmFPUGZ5OVlG?=
 =?iso-2022-jp?B?SmgzYjM5cFExVURRd1hQbURHNVhmMVdaUERBeG9vZndNQTVvbnNML3hm?=
 =?iso-2022-jp?B?c05NNEFQT2dVUS9QVWR3Zyt3YmdHSUVBQ09WSmIwVUdSaGNTajVxck1Q?=
 =?iso-2022-jp?B?aEoyM0NaMk43cmFNM3FOTzEyby9BQnJ3aDJpV2VpSWJaV0tDdTlucDVt?=
 =?iso-2022-jp?B?RU01T3lkU29HdnEyN3l0MTNJV1pBZFBwb0g3by9nU1I0N3FKc0R3c0ZM?=
 =?iso-2022-jp?B?S1FFSDFHYWJRVnJLSGFld2lDNnMrbFloTEtHdkQyVkdjZzQ5TjdmWGsr?=
 =?iso-2022-jp?B?dkljcUZ5Sm1SUmpqTUJQblJ2b29mbTZrR1VzWVpLK3VheHVlaDhEaHNo?=
 =?iso-2022-jp?B?Mng4NStYMTluUEdsYnpzbmhDc0RORFBpZURDcTdsK3NjZ0d0VHB4b2xm?=
 =?iso-2022-jp?B?VmFSWHZvdG1nOE1ROFZ4RmUyYm5SZnkrWEJsZnBTQjNSRE5iRDJuMGhv?=
 =?iso-2022-jp?B?Mmd0MzE1cmpXdTFVRmxpRG1tTzYwMGR1cnp4RFYrTm9FYzhVWStja01F?=
 =?iso-2022-jp?B?dUkrZkRCTlhtdXlwSDI1SHJFQTdMSHhrMi96YzNEK2lpSU04c0YzRlpy?=
 =?iso-2022-jp?B?QTFia1gvUmhLL3JPQ0ZZNS9qSUt4dDV2N09iTHFMRy9OSldMY3dPY2lG?=
 =?iso-2022-jp?B?dXBJV2NQb0dkeEM1YUJzVjVxS09jQlJXZEUwa1A0NGVpcVBRTW0xa2FJ?=
 =?iso-2022-jp?B?dFdNL3ZlVm8xdVBYVHNuR2JpYlZMNmNRNzF2QnZJT2QvRVJVWW5pSFN0?=
 =?iso-2022-jp?B?UWRDQjZqek0wUG1EclVuWGZuRE1Sb3ZVeWc4N3dlelVPV0Q3Umh2a2hl?=
 =?iso-2022-jp?B?MkhyYVNXRnlzc2FZbEV5OVpSQmJaSTNXTmlkSlFkWkJJcm5hbjRmbjRz?=
 =?iso-2022-jp?B?dTkvdkc5WEJ5SitWVFpVNnVSMEhnMQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYCPR01MB6464.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NEtIUEdFWWVWSVIwc1NDK3pQQ2tXd2FEUTBydXFlaVhKZkMxd1hBUWxo?=
 =?iso-2022-jp?B?c2ZBUXlmZXBYdUZDeDFkK1B5eHZHWDVWclJqanJ1blJlSFk1cmZVQzQ4?=
 =?iso-2022-jp?B?ZzIwUVc0ZEQ1WlVCQUgvMHpzbVp4K2dzS1VNVXp1S1V1RXZMVTlTU0pI?=
 =?iso-2022-jp?B?VTVNbVVYMmNYYmVOd3FmeitNdkdFbnJ1b2luM0JlYlpPRTFKN2tWY2F4?=
 =?iso-2022-jp?B?dFE0YjhpVnNGcTFBQU5OM0d3cytYTVRuSjMwRUEwNUtUdWZQdklWaUgz?=
 =?iso-2022-jp?B?WTR3bTUvZTNkM3NHZHQ0ZFlrK2U2aHBRbE5RMmxSTW9GQTlDUXZZMWRH?=
 =?iso-2022-jp?B?U0JsclZjZXFJTDdHNTduZmY1ZWg3UXRDSW1XWVoxUVhPZ285S3J5YS9Q?=
 =?iso-2022-jp?B?UU95L0YrNGFUdkZZMGxQdkVlS0FjZmlhRTdSaGUvNUNJczNoSHVIUXBn?=
 =?iso-2022-jp?B?d1ZtWE9aUnE1cWN3YXJNT3c3YWtPeHJhUG9EdVJBWWVSYW92eDZVSlU2?=
 =?iso-2022-jp?B?cXRmMmxNWC9ERXB6NE5VOU1HWmlrWmQxM0xJeDdZMG5sd2d1eWJtMjZU?=
 =?iso-2022-jp?B?UUFkVVMycWxnVlpFUmZ4MnJlSnFFWDNVbmRTVXFES1dWRnpWS3F5Z1Yr?=
 =?iso-2022-jp?B?eWY5U1hsemZtWTNZSWZrajR6SDYzN0NWbFZVZ2pRaS91bjNaNE9OT1RR?=
 =?iso-2022-jp?B?UWpvSXcvb25wYUVXbkltUzVRdGQ4WmxoTjl1NzJpMzIxVVBlWkRYcERv?=
 =?iso-2022-jp?B?cVJPa1N6SXRSQU16UFVsVXlKeXVxZm9SWXlINk5PRU05YTN5c3NERGg1?=
 =?iso-2022-jp?B?RzEvalEzbjhqeURVcEJva0RCK2tzQjYvUUo2aVYvbnVNY0NxZUx3UVh3?=
 =?iso-2022-jp?B?aDFRTWk4TzZKbDllYVNzMG9rdzRsdmR4TlFubGkzZzcvdlp1ZVcyeE9x?=
 =?iso-2022-jp?B?a2NSQ0lpZjlLbGtmc3V6S2xIUjU2WUJSS3BNcWZGNmkzQU13Y2IrTEs1?=
 =?iso-2022-jp?B?RGVNWEcvcjUvUE10L0JBNmlON01IcHlYbFhlbzN3NFJnZmZ4V2Frd2ZQ?=
 =?iso-2022-jp?B?d3BJNnF6MVhBYWJVUFl0b215ZTJYNS92OGMvZ1hzcmJabWJKa0R1U0ds?=
 =?iso-2022-jp?B?cXZUMzdMV1FKNHdBMWdSQ0NlVXVwaWVaNFBaRnZNWVVtVlNrc2EzQ1ZJ?=
 =?iso-2022-jp?B?V3prNVR4UmllY2Vxby9iTlBVRCtqZitST0RZZGZRN1lLblNIUmtiU1lS?=
 =?iso-2022-jp?B?OWRpT09Zdk42aXpnM0dka0tJWjNZNVhra2VQUUlWTUVUU2JldUs4NTAv?=
 =?iso-2022-jp?B?SmpUU0lrUzFnUW5BdWVkY0dsSUJ1V0hva1BrZFdRZ3JXS1dPQ0xvbkRS?=
 =?iso-2022-jp?B?Y21JdDVGRDBIRlNoMHBJc1Y0czFJQVFlS2JnWklHMkIreTVBQW9ZMDBT?=
 =?iso-2022-jp?B?RkVHVlhXTWM2d3ptMUFlbmxSN2d6WWhuMkF2bUJMZEw0ajA2Z0gzYUtT?=
 =?iso-2022-jp?B?bXRjV1RHeE45VXhGZHJUTjBLTzZ5RGMzVFlDQmlIalo5b1lhaDFtb3RY?=
 =?iso-2022-jp?B?MjdCSktnVFNpU2tjVmpkeXRWejFkRzFTdEllRkhodXZjSisySTJLSU52?=
 =?iso-2022-jp?B?cXZuNDRRelFhOGxySk9XTGZTeHZ5MkcyZDhuNUZiUDRrKzFSTkhUdklN?=
 =?iso-2022-jp?B?bG1QYjJCTER3c2lvQ25JL05IU2IxVGFJODhwRHFpcnB1a1NRdlFtZi9J?=
 =?iso-2022-jp?B?dTJMTTZWMW0wZGFrZzJEelNBMHc2TDhOci9HdkoycUtTMlVvZXFvNDM5?=
 =?iso-2022-jp?B?SWRtMFJ0aE51Q1hxU0NZNUtyVm96M1dTdG5CR05DTG0zVnlZcWJqWXgv?=
 =?iso-2022-jp?B?cHlpWGk0S3V1eHpOSSt4ZE5RYTNyYktVait4YUFVZGhOck43SUNIMEp4?=
 =?iso-2022-jp?B?Q1c2T0dWR2tqR1FqLzB0SVRjVGhoeXlPWXpqQ0FveDFYU0d4M0hIT084?=
 =?iso-2022-jp?B?ajFwVEhtMTQ3N1F0UTZnb0d4Ums4VTVBa0JvU2xxWnJreWpETm5MRHNx?=
 =?iso-2022-jp?B?MytWVDVDQnJTNW43OGExdEVFTWlJUmxNQkt4VVVvUXp0WFY4VGh4eVRF?=
 =?iso-2022-jp?B?eHozRGNsZ0pEUmUwZUdlK1BhSnZ6TCtPZGl1c2RMN2ZFQllqUlFzMm4z?=
 =?iso-2022-jp?B?anZ2ejlCcDR0Z0ZEUjdTYVA5SkQ2ZDFmQjd5MUY2VDBZMExpYnNzSm8y?=
 =?iso-2022-jp?B?SXBzbEh6MWEwQnRJUFJPTjJVOFhWbnZIREg5b0UzdDczWDJTZElDYWQ5?=
 =?iso-2022-jp?B?QkpkZg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9CnerEu08JyXCc0hp6O1xSzrKJZD6V/z4AJZzyXsxyPrdGBlk0yxMgxsXJcdKM6QtkyiMe442y/v3h92yglpvzvW9Bh0UmsJ1yPFytit2t3Fhe0QMSDU5QCDo4gg2vAmymHsS1G3FvSgrHF+vIA5tSuHNiRNB0itNX1FS2MdjFoB1bun69iclVVbVo/jmAz8bYgwdoc2QvvGekDIeXWet8RZ3xD3WQO/iZfgS7DmVrcFCHuoUh1Ti8WECrfMRfDqXFHiFFY3x5QJr5x4FKQF5dPoBRV1/heKrI7bxhdjJ7OKk88x/59kEr3Cw233VGMzAFAADHuiFpvUO+GIQW8aGOR4wyzH13D585dVrTeQaUJcykMxRktRep9vivTwAo3mctugSZ3xqdASxELbxtU6Pa6CA3fkrFnxdDuqEvyaH0rwvnpod0Kr5Qnt8FifULYyEVf1USnWW/q8q7bxmyRrLdKUUzl/QY5xnlJuls4BSlkZaSjFWhESOUyvh+KqfoGhl9dKu0DkNwTj+UxMWin0tq3c14oK2hOcHHuplbig6SsPSPHe/z6dbHInox8IEYishY2rLT5D51n9kta8vF6I7CdQpcJ6U+qar3AeYrUvNvyJ5cyJsOKBrJL64+EqkN99
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6607035-de32-4d93-649d-08dca6c656f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:09:57.2049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0qPMFaRkGr9I6a1ncDoGS4fy2+uQWvH3XPCP0/s8GayYT40RCRaPy1KSowcTPrVNJUNQ+c82Xrxk1x3wBll2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8490
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, July 17, 2024 8:04 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org;
> jonathan.cameron@huawei.com
> Subject: Re: [PATCH v2] pci-bridge: avoid linking a single downstream por=
t more
> than once
>=20
> On Wed, Jul 17, 2024 at 04:56:21AM -0400, Yao Xingtao wrote:
> > Since the downstream port is not checked, two slots can be linked to
> > a single port. However, this can prevent the driver from detecting the
> > device properly.
> >
> > It is necessary to ensure that a downstream port is not linked more tha=
n
> > once.
> >
> > Links:
> https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8D
> DC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>=20
> You also need to take ARI into account.
> That can look like slot !=3D 0.
Sorry, I'm not familiar with the PCIe protocol, could you explain it in det=
ail?

