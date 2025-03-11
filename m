Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48935C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trp1B-00076L-7v; Mon, 10 Mar 2025 22:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trp1A-000767-2v
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:06:52 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trp17-0004Ti-3h
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1741658809; x=1773194809;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7vLyxgGeTB1c7wz8vC1m2FpBTV9psmbpWJ1VSz7da8U=;
 b=WcMLm7+Vpa01eTe7mx2xw/BvPMQBbT+ELsc9cs4WbRlFOvRbzHivJz2Y
 eGRDkRSsAO29l3JlUPi9i6iyfUSu5u+EY0m21ADNP+vsKQXEpKpkM47Yb
 n3+JNMwGPhN+XqKm1n0MF4kDEE4m1jksXPzoihCKyfI0VBs3RCLeytz5P
 2p+9/qjxkL7Gg4KDlHVCmlpuOivYcwzZ705sI96gHvXd6l73GKbwrEua/
 1V1+lFPEqgI1sNDTsxWtFJP3qBn6jPKVRbW8AzVfTCE1mOrc/vVtrkntt
 Weeb/gVztOj1ntPJVPY8dLKQ6wtIkYjVtABLoiHDDqjMZw0yIek5NXA/A w==;
X-CSE-ConnectionGUID: tkmnjWDfSRWQlIQKA+2Mwg==
X-CSE-MsgGUID: hSFxsEHORD+mOzhAZrsg6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="149156065"
X-IronPort-AV: E=Sophos;i="6.14,237,1736780400"; d="scan'208";a="149156065"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 11:06:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXNyCpHR7g3nL2bPbYWSdrWJtJ1LI/0FGNlXzB1WSw4U/TaG4qJ+GWS/cUefIVqPlNnsUZkuMKqcKNoPVf7GIsGYqWNU+RJS7fdpI8w+oOEHTCErrDD7lQwTLzQG22IkPfhyXWP4Z8FjsLL+PVVwHE4Ql0R+s7VcB3rdZYH70QDhlJqh6KGOBopK2TzqIUBPUlD6DZ+vh8fIT62kVd88W3GDBv6iAENOOWBJtSEs7+b1Bfj4s1/NrbribMm/njjWTXPyNbDwqSBmfLBAcVIazrrGLO6aBm+7c4KBac/NzLRkEKcs1yHNT6XBv8DFQFqW6zn0tOU4WQI1wDseOxbiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vLyxgGeTB1c7wz8vC1m2FpBTV9psmbpWJ1VSz7da8U=;
 b=KXbWVVjjryawZVrP5p+MOMh6ewnCWMKbO+Ie2X4/wTIXxsBrpIO7Wj/51kj6MXjwFEBI+QSTyQ0YUn9uEp/w10AASe7+Q0OzxLxai+2xSkpB+VefQfiDSeq5xjexLR9RpoFY8hj2YVDFqNKvgp/xflwTvWtAdORj4XjGb3W5POcMDQsjx9HpxiUQZFK6BpZNcuJk23b53m1ocqRfBJnHOvidfhFyxOgEq92N3XXvA03+WK4KfGiuOK7o4j/mhXX7IgF06Kcms++8FXetscR4atvQU7uaxsHyjgqR5ZDWr10B0bJH5e78+mXx+PAfsTtaH/KMwF/XH5v9mfYuaHgSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB14754.jpnprd01.prod.outlook.com (2603:1096:405:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 02:06:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:06:38 +0000
To: Peter Xu <peterx@redhat.com>
CC: Stefan Hajnoczi <stefanha@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PULL 8/8] migration: Add qtest for migration over RDMA
Thread-Topic: [PULL 8/8] migration: Add qtest for migration over RDMA
Thread-Index: AQHbj40J6+D/wVEPyUaWdSGhjXNvMbNov6aAgAAtZ4CAAyH4gIAAZXIAgADA3gA=
Date: Tue, 11 Mar 2025 02:06:38 +0000
Message-ID: <eb7dd07e-0370-47d1-b093-79be792450b3@fujitsu.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-9-farosas@suse.de>
 <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
 <CAJSP0QVYqkPhWPYRQUbD0VbiKYsV_AGJnYU+3yaD-4AhKT5p_A@mail.gmail.com>
 <76a26937-f257-47c2-9f67-66488206bbb5@fujitsu.com>
 <Z8744mFfVRP6Dq1q@x1.local>
In-Reply-To: <Z8744mFfVRP6Dq1q@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB14754:EE_
x-ms-office365-filtering-correlation-id: 94a4219a-34bd-4b24-f608-08dd60415bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?ODJ2ZGtyR25wMjFEU3dodXFJL3o1VSs0dmord25XTHFxa2lzYjNudHdqR0NN?=
 =?utf-8?B?Z3JoWDY0Vnh1cnRKRTJxbm10SFhHeGtKdjFlekpEOS9CQXlud1FZallDQ2hj?=
 =?utf-8?B?c291OU9PZnRYaWV0NjlRaExWWFN2SWFna3JMUXdOYmZPMEYxcjh4RzViQVNI?=
 =?utf-8?B?NlYvcUNaeXFYT0tDUkVpazY1bzRDM3kwMk83eXlmREVJZmljQXhxQ0FJWUgw?=
 =?utf-8?B?RVFHN1NsNXZpY1pDOGs5ZEkzQzZORCtuT2VHQzY5OVlZWG9ERDJWQk81TXRy?=
 =?utf-8?B?bXBNZkhoMm0wRWdTanV4Uk41Nk9oQnpQWmM2bnZ3TlRXN25iWG9lRWJUNUp3?=
 =?utf-8?B?MytHMXVueStCV1RyTVF2K1djOWNoOW1tNFZ6WndsSXQ0WGFIdm9aTWNFRjNE?=
 =?utf-8?B?dThvMEVhUWEyWjArMUt0N2pzYTVWWXQ0RzZHcXhCTnZ6N0JYOXJST1MzVjcz?=
 =?utf-8?B?aVRtSEZPK015a2hCU3B4N0tyS3N0WHREWmpORmNHNERoR2hwSHFhSUsvdFVE?=
 =?utf-8?B?azYzMXBKOWgza0lmK09BemFzMGM2WkFpcVo3b2MwRXh1dTRYRlpUQXd2bC9Q?=
 =?utf-8?B?OFJkTzNMazd5THNIM2JCbmk4MU1SYnBEN2M1SVRhWXc0WTRYdWJQL2t6YVhn?=
 =?utf-8?B?TjVOU0ZMM3VMTEEvcjBYbUdzdzROM3RqbFJ2bEl4Y2dibjNtWVZKaEZOU3E3?=
 =?utf-8?B?OU5aaXY5ckxBZFNvVFJLZjFVRVp1MnJ2b1FRdjBnY1pmcmRXalV5cjNuTkox?=
 =?utf-8?B?TnJpdFhheWhESkxBOXB2NWJ5dlY2Nm9QUDhKYzFXT2VmUFNjTnpDaHhrUEVG?=
 =?utf-8?B?N0ZSSWZmeXlWd0Q0bURlQy9QS3RNWEhjRS8rTGpXL0dpcXRFbXFhd3BsVGoy?=
 =?utf-8?B?U3oxeFhBeHhKeUhFUUp5T3dvN2g0ZHFsazJDQ2pYenNNa0JKWCt2b3JrcERO?=
 =?utf-8?B?bDJ1ZDFnQXl5UVNsUDdVWUp3VTRnUk4rb0tJcXhZSWIya0oreW5rcFRtK2F0?=
 =?utf-8?B?U3pEU3RjMmFPVDA4U0R0UDBXZE5MeGw4UmtoOTZleG5GVEF0OGtRZEZOT21J?=
 =?utf-8?B?ZExjZCt5OHI3bWF3bVR4eFNtOXVzN0h2YnNBb09uaGsxNHBuQ05ObHd6ZC81?=
 =?utf-8?B?QkdVOVAxWDdIQWJ2YjBFOC9aRVJFeCtTQ0xTeHlEMG02RU1aVE5yblg5bm8v?=
 =?utf-8?B?MS9nSWlvT0JVd05jZStpWGlTekdpc1NWVHlDcFh1WWlsTDZDaHVoTFJmQ29H?=
 =?utf-8?B?Yks5T1hHelRUeXhpc1pCZHpCQ3RzQ0xyMHdiMDhndUF1RTRna0l0dmhSa1Z2?=
 =?utf-8?B?M1lzZCtJREU2N0FBdXFzVnMzVkpFZWZ1TFVDMW5rS0ord2d0MFlFdkc5S0JH?=
 =?utf-8?B?V0JZdkdWcUxuWGpYR3hScysxVkRsdGFQdHFoRitrTmpXdC8vZS85eFpJOHNt?=
 =?utf-8?B?RXMrMkd4bCt4bUpUeXJYNThPckRHVkhtMTRHZ2JIRzlBaTBqd1BqcnlhYWIw?=
 =?utf-8?B?SUpLWVpKajB1bExhSmc5ZzFQcjh2L1hta0pmZkw3LzdwUDJUVW5BVVdTWnlj?=
 =?utf-8?B?SEZkWWJ6NUxXSTVIaU92bStyZWw5S2JiK01SSDRsRkJpUGVqY055eE9rZkRS?=
 =?utf-8?B?L2w1b3dxMEpveTN2VFRubWlsYlc2NE1mUmYrUFJsam44SHV0SXpwUE4yeDR6?=
 =?utf-8?B?d24yQ2p4Uy9QcEFibFhtQklPMXUyYXIwRCtieEhKZUNjT3NyM1VHY3RMZFl0?=
 =?utf-8?B?YlZpajRmUjlHbkVucDlzTEU5NEVOMlFldUlUSnlDVUpWSWFoNXdoS0tvNHVp?=
 =?utf-8?B?cUl1d2xUeVJyQmN1dlZRbHYza3AwbktGZXVpUTJOZWNhWldxN3hKVFlEUXdR?=
 =?utf-8?B?b0hGYnp5N2QvLzIwTXpad0ZseHR4TUtkTnZiYS80ZzM0NUF5b1d5M1MrcHB3?=
 =?utf-8?Q?0a9Nfw9DUlk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUFSQ3JyZTJOOTYraUtzeFpETldZSzB1cEkyRTFwc0UvaXBEc0h0R3R1RXd4?=
 =?utf-8?B?WEhHNGpCWFVPU21rN3I3UWt2ajFjeEI2YmIzSHBvMGFGZEl3bjFiT0M0NjI5?=
 =?utf-8?B?RlJtenRHaE1FR3VLczBPeE5rRzU5VkZRZTh5MUJwUVZsOTBhc0F4M1pkTGQr?=
 =?utf-8?B?NUpIbVNXSWVXbE8yK05uaWlycHk3NVJTYjBUSXAzVmdBenk5MGpEd0trSWVp?=
 =?utf-8?B?V1l2YTgxTXFSRzJyNWtPR1dldnFpaks3Sk1hRXIxamwzZmNIVUlTQVBIOVFW?=
 =?utf-8?B?Vk9ZK0h0SzVPSVZBWmpOakRKNnhuWmM1QTRSbVZLQWxDTWliWHpwVWlSNlYw?=
 =?utf-8?B?T3JBUFVYS211cW1jOGFxK2hpUmtWQ0FJUzhPeWRPQ0JzME4rNVRJR3ExYmNM?=
 =?utf-8?B?YTVIcWpDeGFPMVM3dFB5QmtnOUdtM1h0aE1jU0N0YWVNWU1uQTBFMDR2OUw1?=
 =?utf-8?B?N2d5bU92M1ErRjRuTmJPZncvZVZFelpHckdzNWdlVkFGYjdlWVZLOGZuVGhw?=
 =?utf-8?B?R3dNYzVUNlFpZTdJMUsrK1dJYlFBdkQ3SnZEczZnY2crdDRmRzBBRlN3dkVu?=
 =?utf-8?B?aFhreHhmb0dQZVBia2M3TzBWckNVaWpvUG9QTWd6ckF1MzhHQVN0QkIrN0pa?=
 =?utf-8?B?SFhNV1laZ2pNTVFNUnV0YjhYbFQyTDdNditnRThMSFYydUNmZ29adWRza1h2?=
 =?utf-8?B?cDJZWDdiVFhsVDhmN0pCYkR4OEk5cVBKMnE3a21CcWNldC9xWDRvd2dJV3hr?=
 =?utf-8?B?MzJMZFlwNksvTXNrM3U4L0FLZ3lFdmxQNDFFWitzRmEzeC9aODJ0WGtaQzV6?=
 =?utf-8?B?ZzBicW5SdklPanlqdW1DYUlzTW1ZaUhYK09BbnoxUTNhVDdpUGg3MXhhQ3FE?=
 =?utf-8?B?T1BEdFI4OTlneXVRYlhUUnp5cUZSaldVWTRUWTZGRWFYZ09pWndRaGJUaWlq?=
 =?utf-8?B?MEhYdXVDLzczWkpvbzd0SHorT3JWcnEzUm1UMTltZnNIR2JiUm9iNWJIenkw?=
 =?utf-8?B?K2RRRko2Q1VtMG9lVG5VQ2JzN1VKL1lETC9RdjBkYllObGdkZmlwT3NaQUhF?=
 =?utf-8?B?aDZZZXVDTUVvN2RvT0tsM2Q4WTBkQWRZaUd5RjhiMDZmNmpzR3k2RFN6dTRS?=
 =?utf-8?B?KzdwN3VqSnA3R2tvSUtGb3JMdWRsbGhyelFnZUs5Y2lhSHNPOVpqZE51OTFX?=
 =?utf-8?B?T0hTZU0xejkzOGVOUzc4ZW5yV0Q5QnpISVdrWENtbkNLUnZRL3p5VW5SUzQv?=
 =?utf-8?B?U0JtNGtvZzJOb0tuQVJ0a1h3TmU2TnoyUnZ6dllsRHd5RDZDZW5vMGo5K0NI?=
 =?utf-8?B?a3B6dEZoeS9TdFc0RDJiUWhrWUNkelp1ZXo1ZlN2SGpWQ0N4eExxYnlCOGxR?=
 =?utf-8?B?d3pYcStVdWJGRm81cmdGd0JkMlBJdzF6d1FhVXEra3lvdVQ2OHAxV2xYVi84?=
 =?utf-8?B?WDhaTEtWaTNlNW1CeHdOMnNvTk4yN3RLdXdWQ2xNNnczWUtKUGdPTUN4ckcv?=
 =?utf-8?B?Q2sxQU1yUjVTc3R6bzRHcHNKNmRDdTVEeVFkamxLTXBubmN2V3BweFhBM0J4?=
 =?utf-8?B?NHpwaU9wemZ3VjIwTlN4dy9NTnRGTTZyT1J3ZmlVZFpkbFVRWTc1TENYZExr?=
 =?utf-8?B?eEpsRSsxMWNPeVV4cjBhOTg2UnVDNmdUNjlCRGVjTkdRVEhhcFpESTdkS0pI?=
 =?utf-8?B?V053UzhrZGxBVzNTMzRnRTRTL3JYbjB2VGVMYlIrYzh2R0FvUTg3M2JoQ21u?=
 =?utf-8?B?cUJaVE53SVJHRklRbG1KSnhFOHdNb2MreTFJWXFvSHBQamwwcU95TFlnOVFk?=
 =?utf-8?B?RE5LTFZPYmw3REQ5Q0l4UDhKcG1DZUQvSHhkb1pWdCthTDUydDZMYUhiZm1j?=
 =?utf-8?B?YUZyZUZsckRqZk5MbGpGcEN1L0Y1VlZHVmsyNjBLR3hITVlPMFdmQ3hGWjZt?=
 =?utf-8?B?T1BnWUl1cFR0bU0yekdJZFE5SUJtcUFISm1seVpYb0ZhankrZFJld3VJOTJU?=
 =?utf-8?B?NTd1LzFON1l2T1FVM2ZNS0NtU3RDZVhNN1NqU2NyaDRXLy9iZEVYOW5KcFQy?=
 =?utf-8?B?NlJxVG8wczJldUE2aEpBb1Jsekl5V00zOEY0S2xNVldsZktmMUFBWHJGYUtT?=
 =?utf-8?B?dnJWSnZWbE5QTnNyNUJYU2ZKN3ByWG1waDNMWVpXL09GN3ZSVG5LdUdHcEQw?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA3644765BD5734FB6382060AE751B56@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: suwrOaXlo2z2b46HAUX2KOBD1uK3VCD7bgm8P3sAmTwDclywfBv8Jq8kZrgvvuzQ7l2tMPXSqhdWRtLF/CpZngjuPKBctj2f66vslkRvcy49aH6kVH5HFeCthV5yHio5XFNTiX47zMDxf1QPEZ9tCED/QhhRjoYeVbd7vgtHdJBDesafs0Z3agNTyyOeYI+KVdZotT9N+EDsKUSVfxaZ6znOJFZ7gdC/Q6p3hQmoOyl7uxFZWayICFrW8U7zU7wliEx31tkKiJOfQzKnpyrfHgn27Cd8LYgv5q5r3imj6S13bmXl6QTr2rCv7pk/IZw0tRpaeSe/wdtI0MBP27hgtsYef9gloFVnr3xOVp9FGJDxUooULOVAIzoeMFtI91M9uS5GUX2nwhs3lh+A0LtfzXD3u+fKLo6UJP/tRKf1oyyWLHM0PnBTPGMxtY1csS7HJRtRvUU7y5bHRZVz7821u5AGqfVkKd2Yu3vfNgurwxSafqT4EuoQT9pJ/xdC5ms1/cCk5o3/LxsIWn/qhMkkb1VQ0J7MhNuODJjAnCl7rLT647D7wcNaz6WsrNJwhEP5TCitVAEverny7RQi0OwSJW383dPfcAxk0nML6j14qvZUrYdhn/jz+5Z3P8jMdDVp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a4219a-34bd-4b24-f608-08dd60415bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 02:06:38.4320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2Gtw5cjUvnhsTObC7uZoKR4jLWrEndiT8VAQCh3YHUmrtXGdXts1/ZmQZ1mQLs0muVNM4Erd4LORbKdeP+hHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14754
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDEwLzAzLzIwMjUgMjI6MzYsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBNb24sIE1hciAx
MCwgMjAyNSBhdCAwODozMzoxNEFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToN
Cj4+IEhpIFN0ZWZhbiwNCj4+DQo+PiBDb3BpZWQgdG8gZ2l0bGFiIENJLA0KPj4NCj4+IE9uIDA4
LzAzLzIwMjUgMTY6NDIsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+PiBPbiBTYXQsIE1hciA4
LCAyMDI1IGF0IDI6MDHigK9QTSBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+IHdyb3RlOg0KPj4+Pg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gT24gNy8zLzI1IDE5OjE1
LCBGYWJpYW5vIFJvc2FzIHdyb3RlOg0KPj4+Pj4gRnJvbTogTGkgWmhpamlhbiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPg0KPj4+Pj4NCj4+Pj4+IFRoaXMgcXRlc3QgcmVxdWlyZXMgdGhlcmUgaXMg
YSBSRE1BKFJvQ0UpIGxpbmsgaW4gdGhlIGhvc3QuDQo+Pj4+PiBJbiBvcmRlciB0byBtYWtlIHRo
ZSB0ZXN0IHdvcmsgc21vb3RobHksIGludHJvZHVjZSBhDQo+Pj4+PiBzY3JpcHRzL3JkbWEtbWln
cmF0aW9uLWhlbHBlci5zaCB0bw0KPj4+Pj4gLSBzZXR1cCBhIG5ldyBTb2Z0LVJvQ0UoYWthIFJY
RSkgaWYgaXQncyByb290DQo+Pj4+PiAtIGRldGVjdCBleGlzdGluZyBSb0NFIGxpbmsNCj4+Pj4+
DQo+Pj4+PiBUZXN0IHdpbGwgYmUgc2tpcHBlZCBpZiB0aGVyZSBpcyBubyBhdmFpbGFibGUgUm9D
RSBsaW5rLg0KPj4+Pg0KPj4+PiBJcyBpdD8gUnVuaW5nIGFzIHVzZXIgSSdtIGdldHRpbmc6DQo+
Pj4+DQo+Pj4+ICAgICAgUkRNQSBFUlJPUjogUkRNQSBob3N0IGlzIG5vdCBzZXQhDQo+Pj4NCj4+
PiBUaGUgQ0kgaXMgZmFpbGluZyB0b286DQo+Pj4gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJv
amVjdC9xZW11Ly0vam9icy85MzUwMDA0NTk5I0w1NTkwDQo+Pg0KPj4gVGhhbmtzIGZvciB0aGlz
IGluZm8sIHVuZm9ydHVuYXRlbHksIHRoZXJlIGlzIG5vICd0ZXN0bG9nLnR4dCcgaW4gdGhpcyBn
aXRsYWItY2kuDQo+IA0KPiBJdCBoYXMgaXQuICBUcnkgbG9vayBmb3IgIkpvYiBhcnRpZmFjdHMi
LCB0aGVuIHRoZXJlJ3JlICJEb3dubG9hZCIgb3INCj4gIkJyb3dzZSIgZm9yIHRlc3Rsb2cudHh0
LiAgQnV0IHRoZXJlIGlzbid0IG11Y2ggaW5mby4NCg0KVGhhbmtzIGZvciB0aGlzIGluZm9ybWF0
aW9uLg0KDQoNCj4gDQo+ICMgU3RhcnQgb2YgcmRtYSB0ZXN0cw0KPiAjIFJ1bm5pbmcgL2FhcmNo
NjQvbWlncmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFpbg0KPiAjIFVzaW5nIG1hY2hpbmUgdHlwZTog
dmlydC0xMC4wDQo+ICMgc3RhcnRpbmcgUUVNVTogZXhlYyAuL3FlbXUtc3lzdGVtLWFhcmNoNjQg
LXF0ZXN0IHVuaXg6L3RtcC9xdGVzdC0xMTI3MDMwLnNvY2sgLXF0ZXN0LWxvZyAvZGV2L251bGwg
LWNoYXJkZXYgc29ja2V0LHBhdGg9L3RtcC9xdGVzdC0xMTI3MDMwLnFtcCxpZD1jaGFyMCAtbW9u
IGNoYXJkZXY9Y2hhcjAsbW9kZT1jb250cm9sIC1kaXNwbGF5IG5vbmUgLWF1ZGlvIG5vbmUgLWFj
Y2VsIGt2bSAtYWNjZWwgdGNnIC1tYWNoaW5lIHZpcnQtMTAuMCxnaWMtdmVyc2lvbj0zIC1uYW1l
IHNvdXJjZSxkZWJ1Zy10aHJlYWRzPW9uIC1tIDE1ME0gIC1zZXJpYWwgZmlsZTovdG1wL21pZ3Jh
dGlvbi10ZXN0LVIxT1gyMi9zcmNfc2VyaWFsIC1jcHUgbWF4IC1rZXJuZWwgL3RtcC9taWdyYXRp
b24tdGVzdC1SMU9YMjIvYm9vdHNlY3QgICAgLWFjY2VsIHF0ZXN0DQo+ICMgc3RhcnRpbmcgUUVN
VTogZXhlYyAuL3FlbXUtc3lzdGVtLWFhcmNoNjQgLXF0ZXN0IHVuaXg6L3RtcC9xdGVzdC0xMTI3
MDMwLnNvY2sgLXF0ZXN0LWxvZyAvZGV2L251bGwgLWNoYXJkZXYgc29ja2V0LHBhdGg9L3RtcC9x
dGVzdC0xMTI3MDMwLnFtcCxpZD1jaGFyMCAtbW9uIGNoYXJkZXY9Y2hhcjAsbW9kZT1jb250cm9s
IC1kaXNwbGF5IG5vbmUgLWF1ZGlvIG5vbmUgLWFjY2VsIGt2bSAtYWNjZWwgdGNnIC1tYWNoaW5l
IHZpcnQtMTAuMCxnaWMtdmVyc2lvbj0zIC1uYW1lIHRhcmdldCxkZWJ1Zy10aHJlYWRzPW9uIC1t
IDE1ME0gIC1zZXJpYWwgZmlsZTovdG1wL21pZ3JhdGlvbi10ZXN0LVIxT1gyMi9kZXN0X3Nlcmlh
bCAtaW5jb21pbmcgcmRtYTo6MjkyMDAgIC1jcHUgbWF4IC1rZXJuZWwgL3RtcC9taWdyYXRpb24t
dGVzdC1SMU9YMjIvYm9vdHNlY3QgICAgLWFjY2VsIHF0ZXN0DQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tIHN0ZGVyciAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiAtaW5jb21pbmcgcmRtYTo6MjkyMDA6IFJETUEg
RVJST1I6IFJETUEgaG9zdCBpcyBub3Qgc2V0IQ0KPiBCcm9rZW4gcGlwZQ0KPiAuLi90ZXN0cy9x
dGVzdC9saWJxdGVzdC5jOjE5OToga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFFTVUg
cHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkNCj4gDQo+
Pg0KPj4gSSBsZWFybmVkIHRoYXQgeDg2IHJ1bm5lciB3b3JrZWQgd2VsbA0KPj4gaHR0cHM6Ly9n
aXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vam9icy85MzUwMDA0NjMzDQo+Pg0KPj4gU28g
SSBkb3VidCB0aGlzIGlzIGFhcmNoNjQgc3BlY2lmaWMsIGJ1dCBJIGRvbid0IGhhdmUgYW4gYWFy
Y2g2NCBpbiBoYW5kLg0KPiANCj4gSSB0aGluayBpdCBtZWFucyBpdCdsbCBleGl0IDAgZXZlbiB3
aXRob3V0IGlwdjQgYWRkcmVzcyBpbiB0aGUgc2NyaXB0LiAgSQ0KPiBkb3VidCB3aGV0aGVyIHdl
IHVzZWQgdG8gcmVseSBvbjoNCj4gDQo+ICAgIGNvbW1hbmQgLXYgcmRtYQ0KPiANCj4gQnV0IG1h
eWJlIHRoYXQncyBhdmFpbGFibGUgb24gdGhlIHJlcHJvZHVjZWQgaG9zdHMsIHNvIGl0J2xsIHBh
c3MgdGhlcmUuDQo+IE9UT0gsIHRoZSBzY3JpcHQgc2hvdWxkIGZhaWwgdGhlIHNjcmlwdCBpZiBu
byBhdmFpbCBpcHY0IGFkZHIgZm91bmQuDQoNCg0KWWVzLCBJIGJlbGlldmUgdGhpcyBpcyB0aGUg
Y2F1c2UuIEkgaGF2ZSByZXByb2R1Y2VkIGl0IHdpdGggYSByZG1hIGxpbmsgd2l0aG91dCBhIGlw
djQgYWRkcmVzcy4NCg0KDQoNCj4gDQo+IFRvIGJlIGV4cGxpY2l0LCB0aGUgc2NyaXB0IGRvZXMg
dGhpczoNCj4gDQo+ICAgIGhhc19zb2Z0X3JkbWEgIiRpIiB8fCByZXR1cm4NCj4gDQo+IFNvIGV2
ZW4gaWYgaXQgZmFpbGVkIHRvIHNlZSB0aGUgc29mdCByZG1hIGFuZCByZXR1cm5lZCwgSUlVQw0K
PiByZG1hX3J4ZV9zZXR1cF9kZXRlY3QoKSB3aWxsIHN0aWxsIHN1Y2Nlc3MuDQo+IA0KPiBNYXli
ZSBpdCBzaG91bGQgYmUgdGhpcyBpbnN0ZWFkPw0KPiANCj4gICAgaGFzX3NvZnRfcmRtYSAiJGki
IHx8IGV4aXQgLTENCj4gDQo+IFdlIGNvdWxkIGFsc28gc2FuaXR5IGNoZWNrIHRoZSBpcHY0IGFk
ZHJlc3MsIGUuZy46DQo+IA0KPiAgICByZG1hX3J4ZV9zZXR1cF9kZXRlY3QgfCBncmVwIC1FbyAn
XlswLTldezEsM30oXC5bMC05XXsxLDN9KXszfSQnDQo+IA0KDQpZZWFoLCB0aGlzIGNhbiBtYWtl
IHRoZSBzY3JpcHQgbW9yZSByb2J1c3QuDQoNCg0KDQo=

