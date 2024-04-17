Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvRF-0003j5-QZ; Tue, 16 Apr 2024 22:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwvRC-0003iV-G9
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:54:18 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwvR8-0001lV-E7
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1713322454; x=1744858454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+8vSh2GESgxzhm78qgizxRjZwqdx0/6pDEv2vBVD+aY=;
 b=wbekwlDVktnCY6JD2px+gSw+Yx6qchn/Lq8hfEBaU4QoqpwcjoGu6NA9
 1r7ifO6Wczl5EYznzHqdjbfzLxwTL+Vz2fByuGdufDw8tFz7sGDT1J82C
 T5LD43HgD4q+W3BvYomPpMIZFt79ksbxsCgvdPwOgWMAh5ZwilkpLbff/
 GC2oqysjhml8QI/fRAu69mnFENVO3IkCavfslc0eiIKshb81l219NSJyQ
 drUN6BWat4lsdxTB6xsWJ/oIcJU4APC67mX4WTzN+n7XoFBCF5sqz6cHq
 GCBqhtor7pPV9P1My4tlPTPqxX8X/O/J3+D3qfjLwQDuCAKzPx/hZyetI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="117391254"
X-IronPort-AV: E=Sophos;i="6.07,207,1708354800"; d="scan'208";a="117391254"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 11:54:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avlC5tuwTyYPA0+pBZTFwO/NZA+zIqdcFW1sVjQ8/jxXiU68eafCtFvsl/7HQXrCyQuyUjiFbFdOprkIM0nheUoed9UyAZqPZdmsKGHywD0EiY4NyY2DAAy2rsrVp/KfcCf6gP2uM5nzNEroJxNEa2TnBrR7J92zjiMA7+fC2bPci6izcZRVXi1oFeGvh3xBhUpowjkrmLOlRpbJxeDaeEyl3+ddz4rbwQ42kW0hGabkm0gtqKMStuI8OROyOsMke0aqpE+ibhTCMWjq6GcMSIFZbfVsdg8nSrO5A9UY2S29SwN7XlP8xn9+Ss9SQmZamYNQ64CPE6Tvtf8qXb01oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8vSh2GESgxzhm78qgizxRjZwqdx0/6pDEv2vBVD+aY=;
 b=hpYBJXibdN0PMnJB9Z4OKMY2POY1/ITG+0f0RVaBNKDOSdsBZ9beUgS4uhfPnhb5L86QEuRcB1ViMSChhy1VQQWMxsYGfvIO/NGUcXzwjk9ws9JhsLhPO+NnLTZK1unidOnmws8RoCyJ6DpZKR3nMpXdnxCDfPwtOXRs+ShfSw0wQlP9QRWMqxKqXNnhR99xGA1lDlBirV9BFpzmvJ7TxKeQjpnjcUK10vfBmkfDqN7m6tzqJBWb2atOXffF04kePeE3pWJz15vzUbPQUhfXwqhk90fWG/m9t04vhJH4EIW9q+gwb2NoWypn3gvqrQ1Gc0jRBq61CvionHJNAQUKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 02:54:06 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33%6]) with mapi id 15.20.7452.046; Wed, 17 Apr 2024
 02:54:06 +0000
To: "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "chen.zhang@intel.com"
 <chen.zhang@intel.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong
 <xiechanglong.d@gmail.com>
Subject: Re: [PATCH] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Topic: [PATCH] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Index: AQHakHC3PurSEP73EkKKQc2BPPVxnrFrxCIA
Date: Wed, 17 Apr 2024 02:54:06 +0000
Message-ID: <097605df-6c5e-43e6-967e-82145b550a39@fujitsu.com>
References: <20240417024422.1014358-1-lizhijian@fujitsu.com>
In-Reply-To: <20240417024422.1014358-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB8389:EE_
x-ms-office365-filtering-correlation-id: d2e321c5-4d8e-4503-1a4d-08dc5e89a597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?R2JCcGVOSnJ6UGdKUDJiN1d5NjBjc1NhVmJCUGx6bGxLTUM5cC92emY0cHEy?=
 =?utf-8?B?N3RQTUpUMkdyK2JSQno1eG9GbTRTYTdqUVN2VWNJTUlIUUVVWlFxdGpvQ3VZ?=
 =?utf-8?B?cG5WbGdQVmNyYlJGWnJUSTdBWUY2eFJIcjhDWnRUL1ZIRFJzK2Vxc29QQ1d5?=
 =?utf-8?B?UzIwUFBqTng5VmYxZE1EQzVuMlBxMHBlL0c2TGRYOE1GSGpZMC9pWno2c2lZ?=
 =?utf-8?B?bkdmcVJXb1pZT2JkWGZJUDB4SGN1MGVtdlBDZEd6Q1hmVmVaNjF0RVVkd0Nu?=
 =?utf-8?B?SU5scTZ2SExLQnowY2xJQ1IxcDlyaGh2Y2hob2FFcUFSUlRIWnZKQ0NwaVh1?=
 =?utf-8?B?QStxZHhaNVNFOUI4S3NHWG80ZUJRcWdiUTdTczlYdEw3eURLZnhHUkdnRjZR?=
 =?utf-8?B?Y01TaUdQYmRVbEtVQ0Ztdlh5VEpSOGN0K3AyZWd2Qmgvdy9uNTczbTRSdGd1?=
 =?utf-8?B?S3BzdHQxRjQ1cG1rajU4UmdSdE0xZjhHZ0JjRHdUSXRKZ3c2THFxcGNpT3ZR?=
 =?utf-8?B?V0RKMVhiVmZna21CNkFIS0c3c0toSTdCVTBYbXFVOGo1S3BZdGJRSVZ4djVD?=
 =?utf-8?B?MnFxSDlaa2FGWlNEZ2dnRkl1dDBZSlhYeGNBcEFObDFzc3NqUzlSV1RsM3g2?=
 =?utf-8?B?VTBjMzRadU9vN2RXQTBGYk5NMEV6K3A1dUMzdjk1V24rcERLMnBScnhLNVdk?=
 =?utf-8?B?NHJrMEt3TW5yam5ZUHJBQ1VsSGUrOThqZG1LSWZwSG9KSzBGQmwzUlcrT0Vs?=
 =?utf-8?B?Z3huNlg0eGpnUEJ0Z0tHRFBzWndSSm5ZWEdHU2FqYXlnemlnMG5PK1JQNU5L?=
 =?utf-8?B?cnJ6TlJZUHZaUys3Rmx0bnV2R1hpOUsvVWl0cDFqd0VmMXhlNUFYNlpIRVRK?=
 =?utf-8?B?Q1lLaDMxdG00Sk9zMlpxNUViZkR1OXcwZUNRSmR0c0VDblZ6NkFhQmZMWVVJ?=
 =?utf-8?B?L0JRK1ZmOWRReE1CU2NxaCtsbTFPak51YWRpZjNkZk5CemtVUEQwL0ZHdUww?=
 =?utf-8?B?QURqaTBDbjg0R28zZ2t3dWFsTElGcU9FcGNQc0ZjcEF1ZDNxc2I5SWtFQ3hZ?=
 =?utf-8?B?NENxbStzekJ2T1FETmRBb0V1SUxGUlR6MG5iaEtUYmozVm1YWDlQdTI2SHFR?=
 =?utf-8?B?bDJhNUlaZld6Tmh4dFJqNGQ0a0Fkbm1WRW93NmNPLzBUUzJ4Z1Y3Z3JMaTlr?=
 =?utf-8?B?M0ZJVVNMZzl6cyt1NWhldUphTFhNVUZGbXhKK05UcUFuT1RCWWUram1vQ2wv?=
 =?utf-8?B?VXRYUXR1ZVFZQjhqcXFxUHVORERNUEpxL3p4QVQ5VHVORmJEcFErUnF1Umsr?=
 =?utf-8?B?NlRoUUNtSzd4anZscC9WSTNjSEZqTU1xckw2OXBlekYzeVNQL2VxQmRieDhT?=
 =?utf-8?B?ZDUzb2lvV01Iby9zZjBudDdjc0kvVlNNOVdIWWhwRXo4OEtvYisyTWdkT29N?=
 =?utf-8?B?cXpURjlyZEh2Uk1PUHVERjZuNXA0WFdzTWJEaXBjYjRRU24yZjh2WEhwc05X?=
 =?utf-8?B?SHdpRXlwbzh5OFJ0L1Fzb1FBeVJxTFlBMHJVZXlXVXRqcE50RjdyeXpzdVJ4?=
 =?utf-8?B?UDVyTThrUm9YQTd5c1Rtd283SUl3bHZPVmpnejdOVHRNVS9yTG1MSHU2VkdT?=
 =?utf-8?B?eHlZYURnSC9CbzNHZFJIREpGc214NVNFa3l0UUtBcnZuWFp3T1BZY1liWXFv?=
 =?utf-8?B?TUVUSTh2VjJJbTlTOTAzazlOdFdYQXRHUW5LbmE3b2svQ0pXMlRNcW9WSTJG?=
 =?utf-8?B?UG5jVmZjQ2swK042OXNFdUdWZUl5dTZidjByNWVtNm05YnNLR3M3UVE4dE9J?=
 =?utf-8?Q?T2gIFmxnbQMjlKoptZvpxbRCtSns3JrPBCmpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(1580799018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRoR0dFUDdmQmR6blZCYndteXpmdk02ZlBNM1F6NU5vZXV3U0lCMnlXZ1lS?=
 =?utf-8?B?MEdud0JyMTV6Ujk3THV2YWEwV1pWL09ublFFL3JHa0ZXYzVndUxGZllHejk4?=
 =?utf-8?B?VEk0bFFTMklsWGVWRnNXcVdIMmIydnNXNFUwVm1OTEZUeFkyWk5aOEIyTHFB?=
 =?utf-8?B?K1FHeG9jK29SeDAweDJiU2RtR0FQS0xZNjRPYi9lcDJScHpEVEZIRTlvZmFY?=
 =?utf-8?B?OWJ2SjNmc01rVnFqN1VRcDVCQ1htOGV3aW13NytCSUF3QkhOVWV5WWN4OVo1?=
 =?utf-8?B?M09OclZMV2Rkb3VPbHdNcEk4czVtMGZOTS83Z2w3SUhCWTdWalNwV0Y2TVBF?=
 =?utf-8?B?NDhyR3FlSVFHeTg4ci9jd0Rvdm0yRStGS0xkNWpCbFpMRm9GcFV0NTN2cDI5?=
 =?utf-8?B?YXZjMnR3K2U3NU11ZUJoV1AxRVhjemZ0WTN1djdGeU0yQzByWUxZNjdvKy9J?=
 =?utf-8?B?Nm5jcERCeFlFamw2cFdCZHVzc3JxWlZCNGZNbmgxUWczR0lMWTdTK2dvKzhM?=
 =?utf-8?B?N0dreHlQdGlwYjRZMjdGRTFXTGxrZHEvVnZ0SmoyZ3p4OEJwVkpIeDBCMEtE?=
 =?utf-8?B?NlVjakRpS3YrSkFQakZ3YTArSk5sU1ZyOVBEWVI3Tm5vcnZtSm9OTlRMNWxy?=
 =?utf-8?B?K1dPUXY1ODdHTmtaNTJtR01PM09DakJMbGxTZUNkc0xjeGQydnZaY0I3NmQ3?=
 =?utf-8?B?VzIvOEsyZ1g4bmlCeGVKWDI4UWk0VzErR2p2L3N0U1YyOGExd2hkaW0yamEx?=
 =?utf-8?B?OWJ2V21ZT3ZpSHpIR1FwNkdkVmJkNmVXTlVIZjlrendWUURIeWJVbXlZQlRT?=
 =?utf-8?B?QmtjUzdWNlNDNUJDSTI3VmtQZ3ZtS3ZqTWllMTdUNzZkbWdQV3N0TmJJMTNU?=
 =?utf-8?B?UURTckMzQkVPUHkycUVQK0dHTFlZZDlZdTdtVlBOZGtQMlo4QXBUU0NSQW8v?=
 =?utf-8?B?eVpjWDlPOHVFYUZvZmFMVTQ0aTRmMnBnMjhxRmgwY3paemJBaDdTcDVzUXhH?=
 =?utf-8?B?QnhtMEdRWTZMa25iMEprK0lJTmY5VjFiUDRteTRGR3BCd3IrQk9pS2xNajhE?=
 =?utf-8?B?OXE2UkQ2ekJhcE1FRGVxNHdqWnNrN0dKZ2hWSGpsaGVXZnRWOGFJcTJhRjUx?=
 =?utf-8?B?enpzVFVFNUxuYmZDN0FuNGE5YWRzNEdwVjZHWlJSUCtKcmNiWGoxRWZGSWZu?=
 =?utf-8?B?VkVpQ0dPVFBsbEo1ZkQ4OEFtQ1ArMHUxZTFkNCs5eVVMOUxDamJOK2tHcVFm?=
 =?utf-8?B?TnFVNGpVbE51WkZZVzJidXZxRDFUN01uQ2hMU01GUXh5cG1uak1MN2JqdDAy?=
 =?utf-8?B?c2kyVDRNVmtSQitZMUhCT2ZKYldzTHJuNGRFaEVadHhLak9TU0duY2cwa3pt?=
 =?utf-8?B?RkZZK2hWYTMxUm96dzArRlBtL010SlNIZnYzZWpCdFBrYjBzc3A1QmdPSExM?=
 =?utf-8?B?Q2NvZGZRU0tDeVZnclVEMEh0R040dWtBeGRCMUpSWU9XNHdqQm0wMzIySEV3?=
 =?utf-8?B?aTE2bFlaTkpzWERteS9YM1JOU3UzU3JLUEpOWDJ0ajVzeExLWVJEUG5iWmFq?=
 =?utf-8?B?UkR0eGxtME5HbndBWWYrdDRrUHhHdDdIdDB5VERNaTM5RFl0di8ydEJ3c09j?=
 =?utf-8?B?dlhhdVROM2NPMXRoODJMNkFRQ3ZYbHoxRDRuNEtIbDJGTzN0enE4cHRVZTk1?=
 =?utf-8?B?WTE4cFp3b3hHZHhXVjBjTk8yQngzTXlqeXY1Z3RTU3dBY0pva1oyWUxheTA0?=
 =?utf-8?B?Y29pU08wOWFodFhvdjlLekQ2Ymx0ZVloVlV4anhraFpZZE1HbUNTTnlHSlQ0?=
 =?utf-8?B?NlRucHV2YmUvUjNQbkVJK1RCOEppY2dSR1FhQ0c5dUFVNEdmNEpHM2MvWExa?=
 =?utf-8?B?eDlUWVRaRyt1aytzclE5OUNsNkJqTmNsK3ZZU2QrZ0xnTlBqdXcxMEdEQzQ3?=
 =?utf-8?B?Y2dac0FxL1NqSDVHSjk4SEtlTUEwUXpCY056QVI5dnE3emoxTlp1VDhNbDgy?=
 =?utf-8?B?VXhrbFpxa1MxbUpzMCszcDVNeGlmYzM4bzFKek1zN2xmZTBRclUyNWI1aHlI?=
 =?utf-8?B?eERxaU5zbFdhYzdJQmt2cjFibnpJV2RjYjZyN20yQWFMWFBUcnZUUVFxem1V?=
 =?utf-8?B?TmJ2WTRUR2ViMU4zZUcxWHM2d3FUUGhZbTl3WmI4TzJTNlBqeTJzTnJqUllJ?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC358605C297C140A341F3D97593C454@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UQdzIefVbIIeJlBzBpFhFMhgfXwESUWXe8wDA5jfKqaCFbvTDrBL46RaekpHWFZ4Xp0Q5KwXnu/F3tVyPOXfatYqbbeK1D5FYcmiy+wcO6fKX5TCTr/hLdiBXHAonRglcQEJCKHhrdd5u3lKYop3gCm794v54sE/2wYkpvTkNjwMt6g/QkYK3Phzsi4+3maS1siTLw/PhPodYgFrxfEla/0vVPykr7rYkx7y4gFi0pXUVAPX9dUVF8JJh2WmnyqE/Ynr5wS+F4XZEHKMi/bT0WhCoRyUZpeJtDO2BK6/tDQmY9TfNu37osxtPvqczlYCkdPDqHl2i5jddht5wwLchmG0aUOotNUUmDiG2yYrJD4v6AE6luLLEhjfo+4pbbpBsTMESYn73fbLd0+/SZu/z5ykhlvvJszgs9A4y6aau6Orixba2sIhYiRoEULrTTVvPaypP3Li5PkRA96r/ago5JUVy2vpQdIuYtatW0mXjIZoJh4DxRFVY6BnalVHJY44eisDt3lbhHJXlo1Tp539J8OtXT1nuJWVywyOxXYXw2IgpJ4rT7vRSbF09yUzV8KPxIImqcSBVpKISAlaoGEzC/Uzrj5oPgbqjtNTnH6wU/3dEpO5d1JNZY9g+oRh2Atq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e321c5-4d8e-4503-1a4d-08dc5e89a597
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 02:54:06.1372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAty+1xhZmdT/7n0xwXb4ORAFmuImc/bgwjK5S4Faj3XnpMxYElcJnTliXcnBQZZ0nEL/e5NHDLJzSYPOQugkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8389
Received-SPF: pass client-ip=68.232.159.76; envelope-from=lizhijian@fujitsu.com;
 helo=esa5.fujitsucc.c3s2.iphmx.com
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDE3LzA0LzIwMjQgMTA6NDQsIExpIFpoaWppYW4gd3JvdGU6DQo+IGJkcnZfYWN0aXZh
dGVfYWxsKCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJvbSB0aGUgY29yb3V0aW5lIGNvbnRleHQs
IG1vdmUNCj4gaXQgdG8gdGhlIFFFTVUgdGhyZWFkIGNvbG9fcHJvY2Vzc19pbmNvbWluZ190aHJl
YWQoKSB3aXRoIHRoZSBicWxfbG9jaw0KPiBwcm90ZWN0ZWQuDQo+IA0KPiBUaGUgYmFja3RyYWNl
IGlzIGFzIGZvbGxvd3M6DQo+ICAgIzQgIDB4MDAwMDU2MWFmNzk0ODM2MiBpbiBiZHJ2X2dyYXBo
X3JkbG9ja19tYWluX2xvb3AgKCkgYXQgLi4vYmxvY2svZ3JhcGgtbG9jay5jOjI2MA0KPiAgICM1
ICAweDAwMDA1NjFhZjc5MDdhNjggaW4gZ3JhcGhfbG9ja2FibGVfYXV0b19sb2NrX21haW5sb29w
ICh4PTB4N2ZkMjk4MTBiZTdiKSBhdCAvcGF0Y2gvdG8vcWVtdS9pbmNsdWRlL2Jsb2NrL2dyYXBo
LWxvY2suaDoyNTkNCj4gICAjNiAgMHgwMDAwNTYxYWY3OTE2N2QxIGluIGJkcnZfYWN0aXZhdGVf
YWxsIChlcnJwPTB4N2ZkMjk4MTBiZWQwKSBhdCAuLi9ibG9jay5jOjY5MDYNCj4gICAjNyAgMHgw
MDAwNTYxYWY3NjJiNGFmIGluIGNvbG9faW5jb21pbmdfY28gKCkgYXQgLi4vbWlncmF0aW9uL2Nv
bG8uYzo5MzUNCj4gICAjOCAgMHgwMDAwNTYxYWY3NjA3ZTU3IGluIHByb2Nlc3NfaW5jb21pbmdf
bWlncmF0aW9uX2NvIChvcGFxdWU9MHgwKSBhdCAuLi9taWdyYXRpb24vbWlncmF0aW9uLmM6Nzkz
DQo+ICAgIzkgIDB4MDAwMDU2MWFmN2FkYmVlYiBpbiBjb3JvdXRpbmVfdHJhbXBvbGluZSAoaTA9
LTEwNjg3NjE0NCwgaTE9MjIwNDIpIGF0IC4uL3V0aWwvY29yb3V0aW5lLXVjb250ZXh0LmM6MTc1
DQo+ICAgIzEwIDB4MDAwMDdmZDJhNWNmMjFjMCBpbiAgKCkgYXQgL2xpYjY0L2xpYmMuc28uNg0K
PiANCj4gQ0M6IEZhYmlhbm8gUm9zYXM8ZmFyb3Nhc0BzdXNlLmRlPg0KPiBDbG9zZXM6aHR0cHM6
Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzIyNzcNCj4gRml4ZXM6IDJi
MzkxMmYxMzUgKCJibG9jazogTWFyayBiZHJ2X2ZpcnN0X2JsaygpIGFuZCBiZHJ2X2lzX3Jvb3Rf
bm9kZSgpIEdSQVBIX1JETE9DSyIpDQo+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW48bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICBtaWdyYXRpb24vY29sby5jIHwgMTcgKysrKysr
KysrLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9jb2xvLmMgYi9taWdyYXRpb24v
Y29sby5jDQo+IGluZGV4IDg0NjMyYTYwM2UuLjk0OTQyZmJhMzIgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9jb2xvLmMNCj4gKysrIGIvbWlncmF0aW9uL2NvbG8uYw0KPiBAQCAtODM1LDYgKzgz
NSwxNSBAQCBzdGF0aWMgdm9pZCAqY29sb19wcm9jZXNzX2luY29taW5nX3RocmVhZCh2b2lkICpv
cGFxdWUpDQo+ICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAg
IC8qIE1ha2Ugc3VyZSBhbGwgZmlsZSBmb3JtYXRzIHRocm93IGF3YXkgdGhlaXIgbXV0YWJsZSBt
ZXRhZGF0YSAqLw0KPiArICAgIGJxbF9sb2NrKCk7DQo+ICsgICAgYmRydl9hY3RpdmF0ZV9hbGwo
JmxvY2FsX2Vycik7DQo+ICsgICAgaWYgKGxvY2FsX2Vycikgew0KDQpIZXJlIGJxbF91bmxvY2so
KSBpcyBtaXNzaW5nLCBwb3N0ZWQgVjIgdG8gZml4IGl0Lg0KDQpUaGFua3MNClpoaWppYW4NCg0K
DQoNCj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X2Vycihsb2NhbF9lcnIpOw0KPiArICAgICAgICBy
ZXR1cm4gTlVMTDsNCj4gKyAgICB9DQo+ICsgICAgYnFsX3VubG9jaygpOw0KPiAr

