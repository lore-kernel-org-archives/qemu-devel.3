Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD37C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 01:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjm5-0007sU-Ry; Tue, 18 Jun 2024 21:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sJjm4-0007rh-2F
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 21:06:08 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sJjlz-0006dy-Mj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 21:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1718759164; x=1750295164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=COhG/rtIYO90sFxNNVtPvhXGcFTtowwVo+ysWZETJxc=;
 b=bZjFDz3C5Aoy82bQsiMTjqt/nRhwCZTxO35SD8DxzaQss60iAyP3MxPr
 +LE/94QdREWdy9qKt46WIU2m4mlp0FdoBplyv6KSaULoNWQsjA9KBWHf+
 dvwwXj4mTbR87TvML3c1yQuMn5OYkszExj/QU7jk5lEXOfMEDeMPIJ8BQ
 /+I1pqltXqt2qJ0SmHZnI6bzJ30fns8IYhsNyMZ0qPp1NHq5sXpDRxa9E
 J3cJue21mFro4BcieCwrj1m1Atf0MuV2Rxa2GbnB80tNA6VOr/F0AndC9
 suGcsorH2QQrniWkDobtzpplDz1KMCQE7NHQckLkqTUGGMxBKQTp5XQyZ g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="122679747"
X-IronPort-AV: E=Sophos;i="6.08,247,1712588400"; d="scan'208";a="122679747"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 10:05:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at7bPE5niIYYz4/caQAZzIHhlYensxFFFl4uWbXyUZKEo4xCGW/EnDMmsy82eGYrjcoZX4fLhXoqr7oxXvNXkmX0spGicBfaxQZ0m3rwpEAbhd78B46EBbQh5tLOuvlu7AB9/s216fXyR+JC7ItJrVvWgSbEqvAGwGSkiDGlU122Wc9JQ7KWCQa1rqYvYv8XM1H2VR6ppV9JV1IuaG00/2UmQUs2DtlJ5qJ7EUtriqNphN5oPrKfXTfMitiBnxCDHYQO0PeEIHAyS3XrWYB/wsLWevjgShKx7iHTS+ZJN5+DaLQi+2Q8HE1A0qy/jPtVnKjlaQdSIa0sRljcV9+hWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COhG/rtIYO90sFxNNVtPvhXGcFTtowwVo+ysWZETJxc=;
 b=drmaVITjIoBL40oDXDgmaIxf+kcnb9oT7WgtRptjx43MMsmheqUqBkItYujKwhHN1QqSRdnXm2CAX4Rcz6T5CgXMRHs+yB+Pd4zmjpCGxP+wfnGA51bXYICSKs+cEKJYiRTcPCHzbWn7gmtmUJm7UlNsdlWXpWzWe61m7/wZqqGDeVtNDckTJnKBx4BKBTRYCR3dd1Lb0UBiwI9y22DLWOzzcuMOJXho9FVvE3/7BABfpqgYZefv0MSbfo1G3vvTn3UoE60tRdqpy4PV1BUOplZdwbnfdOwJcHIffXhb0tAlMnUq6EDdhf+66fZMj6m0z1qWa5+GcFrV1yKKTH2DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYAPR01MB5404.jpnprd01.prod.outlook.com (2603:1096:404:8030::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 01:05:48 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 01:05:48 +0000
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, Eric
 Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 02/10] migration: Rename thread debug names
Thread-Topic: [PATCH v2 02/10] migration: Rename thread debug names
Thread-Index: AQHawOKlnbYGNPwi8k+Z1RoTogUfZbHOR9wA
Date: Wed, 19 Jun 2024 01:05:48 +0000
Message-ID: <854be059-6d1d-47c8-b503-05271f890ffe@fujitsu.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-3-peterx@redhat.com>
In-Reply-To: <20240617181534.1425179-3-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYAPR01MB5404:EE_
x-ms-office365-filtering-correlation-id: 843031ae-3a08-42b7-d707-08dc8ffbf4c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|7416011|376011|366013|1800799021|1580799024|38070700015; 
x-microsoft-antispam-message-info: =?utf-8?B?WUVwK21iTHlKak91MVVwMVFld1F3ZXF5U0pkdkZkQ1Ayb0tQZGpYVDZNeFVG?=
 =?utf-8?B?eWhKbXAvZ0FWTWZhVUUzNGxrKzlydmNoa0d2M0laYlFISklPNTMvelNJS3VU?=
 =?utf-8?B?MXFQOU8za0hSeXRySG1CU0dsWEpseld3cm1SQmhBMU9oZ3FQa25IKzh0eTB2?=
 =?utf-8?B?Z0ZTVW1xNFl2RkhpbktBY0hsbnh1TUVmRW9uVGIvREZmNDZ0VU1YcjlMSTFh?=
 =?utf-8?B?YXE1SmhGdWxVdzVRNGVvUTF3MStGdS9yQWlBM3laSWdpYmc5VFVkQURxL0Zl?=
 =?utf-8?B?M3RsN2k3c3lJeWplUTVqazRtNFpKbWxyUlF1ZXZFbFZ6ZHRXRDJuVE5pazhF?=
 =?utf-8?B?ZkZYbnBhU3FXb1BSNGxjK0xKQ2xqdTFVMnVNQjduc21GdjJMR1dabExQb1Z1?=
 =?utf-8?B?akVHdUE2eWpsTVRTb2NlOTd5M3RkTXQvUngxbVkrK0tLbHovQnZSbmdLNFc0?=
 =?utf-8?B?dkVJZWEyTTU2Tkx0a0p5bnZud3dER2JoN3M2TzZBMHZWRjlKUXJuNmxiNFhN?=
 =?utf-8?B?WkpBbHJiYU8xTXVRdklPYTZwaE5tZUlnNWVrVzBhcDljcVBFRGRsY1FDWTRz?=
 =?utf-8?B?enVIODVLQi8vVUo2TU5PQkNETzZ0ZWlpaTk1QzRWV2orRW5QWU1sdVdEcTYw?=
 =?utf-8?B?Q2ZLS0RpL3BwU2JaYk9zd1lUWWhJbUhzY2FkQmxQOWdHWjVoTlNZc0hKNm5F?=
 =?utf-8?B?Y2ljRFFqNEJWZ1pUMC9YZTNjMm5hQlMzbVJUaGVIWjkxZmQzMVQxUytlaEYy?=
 =?utf-8?B?MHIzZjFGYzVtay9VanoxMGJ6NUhHa3FzSmlBdFBCdzhYelV0WDJtRXpXNFZn?=
 =?utf-8?B?R2F2amE3ZHQyL3FvUkdrRG85cnlVQnhIZDR3a1kyWlN2QWM3dVBiR3IxOXlO?=
 =?utf-8?B?RDdiMTZnL1JFaW9OYUFISmFJdExkWWowUVk1cWpvQUZnc0t0Q2pReW5ZTFpV?=
 =?utf-8?B?Wk9CL050b0Q3dTFLZWxpby9iZjFOdU0veXBONGFoeFQwUEtkU3lqRjZJMHRU?=
 =?utf-8?B?aDhVNmFGYlNoNTlzZi9UYlhiN1R6T0VzelNHZlBpQVNuYUFUVG5jTlgzL0FW?=
 =?utf-8?B?NWlsbUFBNVgyTzhGYkRpVEEvQ0FYTGorcmg0NzZORFd1Z2VzV2krOVlWdkxZ?=
 =?utf-8?B?QWhzcEpaeXFUdXhZZ2k2c2RXS0VVckIrZzh1WG1uTDlwbUtLMmpUOUd4RU9n?=
 =?utf-8?B?akZzMjlQZ21sZTh0MUxsVWlhT1JBcEhBc04zbjY3dnpyVzg5ZUpBMnZLL2NS?=
 =?utf-8?B?WHhma1VxUDNlOStrc0o0SlpNcnM2cXdyTG1uVXhLK2JiWnVsTW9aT3RlODNM?=
 =?utf-8?B?UytFL005ZVVqUll6RzBnMmNTM1I3SXRRNVBzRktLT2NTa0swU1FYVEhTb2RB?=
 =?utf-8?B?U0VlOXBzYkp0cHhjVXU5NnVOemdnUVVBLzQwRWxwTVlGTE8yUUo1K2NnbUpH?=
 =?utf-8?B?eE5RK1EvV2JIa0tSRlNKSUt0Z2w2WnBZZmVaaEQzY3hWQjdUU3BnVXRuNEor?=
 =?utf-8?B?VEhOUTRhWE95Nk9OVi9MUHd0VklmK0F0RGFpeDlOWVF4ZjJWM0NXYis5ZklT?=
 =?utf-8?B?aVg3TWRJUk1uRzlZdkVDaWg3TnV4SW4wYjF6Y3U2TjFKTkM5WnphaHNjejJU?=
 =?utf-8?B?ZmlmdlUycnZ1NkpjVjdObDFuaSs0dkc5RlNScUJvRlBRbUVsUS9qVi9WeHpq?=
 =?utf-8?B?alNVTTJpb2JQdXJPN3pJRDZkYVd4Sy9mUHlSdjYzSUhwbUpNdGlqMGxJSFgz?=
 =?utf-8?B?WnJkd3k1TWNqZUc1c0dZb21kbmhuellZV1Nyb1JzcFdtRThYVHlKRW5FcTMy?=
 =?utf-8?B?ZHhSbEc1R3FCbFJFd2N3VjM3a2tlOWtyZUJqVDYzb0xvQnpacko4ZDVFSnEv?=
 =?utf-8?B?eHlRZDNVSWR1amFHNTNObXgwWVNsbXQ0WVdlc3BTelVtR0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(7416011)(376011)(366013)(1800799021)(1580799024)(38070700015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c05VbDVaT2lVczBLYUh4WXFGQTIrT2ZCUlNTbWtEZnFkWTltZ1hQc2pkR2NE?=
 =?utf-8?B?dzZxNkFsNUpuM1NZc3dDTGozaTIvdDlhZHBQejVabHFrMWVQSjVZeVVUeFVm?=
 =?utf-8?B?OUpKanBVNVVlRlhPaWpVT2ZzY1loZ1BTWDUyRFhXMkhQYVVoVi9NTmJzenVQ?=
 =?utf-8?B?OWtTWXhtZGdVU2kvblpFWStrWmEwa1c3U3VVOU54N0hsVzZRVVpJTDJGYzlK?=
 =?utf-8?B?NzhkTmZJSjFwaE5HY281THBuQXh1NWdKZnRURmd6OTlXZXNtcUpxRXVQNjZZ?=
 =?utf-8?B?VHJCM0R2RHpLQ1F3L2lZbC9ac0xMNzdkN2lwM1pxUFJpMURTb012R2lhT1N6?=
 =?utf-8?B?eXdYeXF1Qmlabi9rc0R4MkNkZU9BVDNyWmlYWUlBYmNucHFMUkg3S3hVbVh1?=
 =?utf-8?B?MTgrOFZnaS9HTzBrRWx2WndVVEFnVmV3ZU5jZ2VmMTFiZStMRmllZHd6YTV2?=
 =?utf-8?B?Q3JBdVU3M2E0dlBVSXhobHJzRU1qUWY5OW50T0xOUlIwTkx6Q1RCckl1Z1Z6?=
 =?utf-8?B?dkxzT0dZVjRwdGpwcGRCMGtFQWxxL0g1ajRYZk14YTdNSGNBVUpVWG1mY0Qv?=
 =?utf-8?B?Z2pqelY1YWRvSTQ4Sk10YTZwbVkzNFM2anVqTW54Q2RtOVRJVGdROHdZTTVt?=
 =?utf-8?B?VVVSb0o0MVZveSthM1g3RlpNakVmSnYzUmtxTnRRM0tRcUxOb1lScUNYaTNs?=
 =?utf-8?B?aUE4Rm5URWNQQnNWMkxpTU8xczI5SjZwb1dRZGJYZ3NPOFBLR0RCRHg1Ymwz?=
 =?utf-8?B?Nkhpc3ZyYnI3MS9vczZpOFRKUTFRdloxTkNnL0xxTXJxYUtFT0tRZ3lhd0ZO?=
 =?utf-8?B?bld1dFp5d05qdmsyZEpBV3BINXB2SkcrYWRITk4rR2N0S0R5UElRWi9oUWxh?=
 =?utf-8?B?MlBzWjFJL2ZYS2FycG85b0RSWUhPK2NuTWsvMjFJaXdSWUxCVEFIWFR3OTVP?=
 =?utf-8?B?VTllNG5WM1JBTGNveEc1c2tLMkVYeDRnanU4Z2JBci9pTzEvMUlaTlhHMFQ2?=
 =?utf-8?B?UCtBOCtCdDc1bXJndU11NVRPWXFwZzFFN2dJMjQzOTZKRkJrenZDWlhVazNm?=
 =?utf-8?B?UGYwQS9OdGZYWDZtY3ZEVDdjVmZaRmhocmdlay9GTkc3VVZrSHJYSk5DNmpW?=
 =?utf-8?B?dUFBZGRRT0xCOWM3bnBXVmtwamY0VTdDZ2sxVTRHT0ltN3lMbThiQzBHc1Uy?=
 =?utf-8?B?ZjIvUE1LRHA1cEhiWVhPTkUxYW4wSXljSExPRU53ZVdWWXlYWkEyK1FtVmZE?=
 =?utf-8?B?VUZQSFlvOGlKR0lXTk9PbzZOSVVvY2p2SnV3RlAxajlDMXE5SHdKN3N2bnZQ?=
 =?utf-8?B?VVF1UXBIeVBoWTh6Z0R3SFpCSjFwZHB2bklXOWxxQU5rYkF3UVFjeWdEMzRs?=
 =?utf-8?B?dGszT0tXRTRNZ3ZQWUdtWUdxbkx3STZPOEFibjRhOEV4RStHdUZLNkJWWlVY?=
 =?utf-8?B?TkUyK1IrKzJyWHlleDJ4TW9Ub083bEtTN0l3V3l4TzZwZDBLcGI4WkFoVGx1?=
 =?utf-8?B?clU5bHJSQmRkRGM0QWdodEJxa0tYeHhNclloUWkwdXhSbXRjMVBGVUVjU0JD?=
 =?utf-8?B?OFdlVXlNMGY3Y3k1ZkM2N0VIemZZZlk3L0s2ZW5KMHpvK2JKTEpYWHNydFQ4?=
 =?utf-8?B?SnkwNFdzYVZPSm85eEpncVNvVzJ4SXN3UFVTWWF1VjFWZ1k4SURNenJTZ0xp?=
 =?utf-8?B?c0xib1ZkL2t6WUEvWW9lbnZVQVYyMTgwY2hwRDZTa1RJY2l3UkJ4MnNjVlFt?=
 =?utf-8?B?QmJ2ZE5aUlpVSzhhMFlHRDNKdnM0enBvY09KNlgvUEZxOUF0YndrYVVpaGpt?=
 =?utf-8?B?V3c5ZTVGdGZNemNGcWhEem1jLzBVSWw4ekRvcUNYZkg3M0c5Wk1EZmdXRlVx?=
 =?utf-8?B?cE1IQ2R4S0JUamlRTXFNcDZVdHkyRUtMQXp2TkNlSmhKR3hudTRrQUs0ckQ1?=
 =?utf-8?B?ekZVWXRMbnp2VlBsa3hMQkg0RFBLZ2N2T09uZW90Wjd5OFNhNUFQMnFkRkdI?=
 =?utf-8?B?NTJxRlVEOW9vS3VEdUxDMk5SZmdJN3hqbjF0MXVjTEgxaVJFbkZ0VkYzdmx0?=
 =?utf-8?B?eUZGTHlMZHdLbXdlMzRxak1PU1ZjVGxmOFBtUUliTWV0M0laUXordGNkejV0?=
 =?utf-8?B?T0RqdnVtd011dDVnRTlrL25HN0tBL29qLy90SUozSXlSaCtMbkhxNGF6dlFh?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A3FDA4C7B3091409D70AA4FBD83C2AA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OTCYHWJg9LFjE2xoVaqnnlvDgjkUPmTnXVvXmMcrvx+AMB6uPaM60peaecXfkIPaAV+a7SzJrkclGdSVxsBkeHTC243cRTEM27EPT/rCSF2zIq2T06q+UmE0iXK4sAybl7N1omEjE2Pwc/cgFeYAx7bdMb9KmnOF5ccDJ8EmDqj8zxl85IzxAr6jRyEOLd8I3KOgp0bGJps8wGc/9dopj9ukRDq1gVn/dgUJiMDrlNGHM8JXMcQ6Wl9jDtgULBrq3v5eCsJ5tnleeKn+vRZYuaFRlvtVPRpGK7G8Rob3RehnTcq6LAmmHeXO2fNbXtLM5yTLq4wzwy/4/uAFvQHSXkzs9dSUHXfr0vN2+eVYaWCdvztgb+3tcPoERKxiUKrM9/9MPO+aKX+ksCQql0b9BFxZgn+7ViC7bDrwDT3QPWgrsxs8inpxN4YHowUhAhUJA6kmbjEOc0YUSFsqayq4oZO0+eKFrs9z6gsiQ2XUjDNzixVZWiVay9hiNKmoDIRDrZ+0Q67ZBatrOjTVLLO9t0NzjjwnQ2g3HBQz05LN9EBIlayNeGkWViWLzzJ3rkythmqNUppVM0xZP786Pu6yDN3l+nRk3y0nuW+JwTtm/y4Wey00lnRjSrnK+hwjyJF2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843031ae-3a08-42b7-d707-08dc8ffbf4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 01:05:48.5543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VaKkmRN3r/5iiLHXYFK8VJ61KC+0bI7r5+GKtucsS+cu12BtlTB0iHr2mBPkQYYIIhwQ//5q5BGFTn/Z/5esA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5404
Received-SPF: pass client-ip=68.232.159.87; envelope-from=lizhijian@fujitsu.com;
 helo=esa7.fujitsucc.c3s2.iphmx.com
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDE4LzA2LzIwMjQgMDI6MTUsIFBldGVyIFh1IHdyb3RlOg0KPiBUaGUgcG9zdGNvcHkg
dGhyZWFkIG5hbWVzIG9uIGRlc3QgUUVNVSBhcmUgc2xpZ2h0bHkgY29uZnVzaW5nLCBwYXJ0bHkg
SSdsbA0KPiBuZWVkIHRvIGJsYW1lIG15c2VsZiBvbiAzNmY2MmYxMWU0ICgibWlncmF0aW9uOiBQ
b3N0Y29weSBwcmVlbXB0aW9uDQo+IHByZXBhcmF0aW9uIG9uIGNoYW5uZWwgY3JlYXRpb24iKS4g
IEUuZy4sICJmYXVsdC1mYXN0IiByZWFkcyBsaWtlIGEgZmFzdA0KPiB2ZXJzaW9uIG9mICJmYXVs
dC1kZWZhdWx0IiwgYnV0IGl0J3MgYWN0dWFsbHkgdGhlIGZhc3QgdmVyc2lvbiBvZg0KPiAicG9z
dGNvcHkvbGlzdGVuIi4NCj4gDQo+IFRha2luZyB0aGlzIGNoYW5jZSwgcmVuYW1lIGFsbCB0aGUg
bWlncmF0aW9uIHRocmVhZHMgd2l0aCBwcm9wZXIgcnVsZXMuDQo+IENvbnNpZGVyaW5nIHdlIG9u
bHkgaGF2ZSAxNSBjaGFycyB1c2FibGUsIHByZWZpeCBhbGwgdGhyZWFkcyB3aXRoICJtaWcvIiwN
Cj4gbWVhbndoaWxlIGlkZW50aWZ5IHNyYy9kc3QgdGhyZWFkcyBwcm9wZXJseSB0aGlzIHRpbWUu
ICBTbyBub3cgbW9zdCB0aHJlYWQNCj4gbmFtZXMgd2lsbCBsb29rIGxpa2UgIm1pZy9ESVIveHh4
Iiwgd2hlcmUgRElSIHdpbGwgYmUgInNyYyIvImRzdCIsIGV4Y2VwdA0KPiB0aGUgYmctc25hcHNo
b3QgdGhyZWFkIHdoaWNoIGRvZXNuJ3QgaGF2ZSBhIGRpcmVjdGlvbi4NCj4gDQo+IEZvciBtdWx0
aWZkIHRocmVhZHMsIG1ha2luZyB0aGVtICJtaWcve3NyY3xkc3R9L3tzZW5kfHJlY3Z9XyVkIi4N
Cj4gDQo+IFdlIHVzZWQgdG8gaGF2ZSAibGl2ZV9taWdyYXRpb24iIHRocmVhZCBmb3IgYSB2ZXJ5
IGxvbmcgdGltZSwgbm93IGl0J3MNCj4gY2FsbGVkICJtaWcvc3JjL21haW4iLiAgV2UgbWF5IGhv
cGUgdG8gaGF2ZSAibWlnL2RzdC9tYWluIiBzb29uIGJ1dCBub3QNCj4geWV0Lg0KPiANCj4gUmV2
aWV3ZWQtYnk6IEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1i
eTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlh
biA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAgbWlncmF0aW9uL2NvbG8u
YyAgICAgICAgIHwgMiArLQ0KPiAgIG1pZ3JhdGlvbi9taWdyYXRpb24uYyAgICB8IDYgKysrLS0t
DQo+ICAgbWlncmF0aW9uL211bHRpZmQuYyAgICAgIHwgNiArKystLS0NCj4gICBtaWdyYXRpb24v
cG9zdGNvcHktcmFtLmMgfCA0ICsrLS0NCj4gICBtaWdyYXRpb24vc2F2ZXZtLmMgICAgICAgfCAy
ICstDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vY29sby5jIGIvbWlncmF0aW9uL2NvbG8u
Yw0KPiBpbmRleCBmOTZjMmVlMDY5Li42NDQ5NDkwMjIxIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRp
b24vY29sby5jDQo+ICsrKyBiL21pZ3JhdGlvbi9jb2xvLmMNCj4gQEAgLTkzNSw3ICs5MzUsNyBA
QCB2b2lkIGNvcm91dGluZV9mbiBjb2xvX2luY29taW5nX2NvKHZvaWQpDQo+ICAgICAgIGFzc2Vy
dChicWxfbG9ja2VkKCkpOw0KPiAgICAgICBhc3NlcnQobWlncmF0aW9uX2luY29taW5nX2NvbG9f
ZW5hYmxlZCgpKTsNCj4gICANCj4gLSAgICBxZW11X3RocmVhZF9jcmVhdGUoJnRoLCAiQ09MTyBp
bmNvbWluZyIsIGNvbG9fcHJvY2Vzc19pbmNvbWluZ190aHJlYWQsDQo+ICsgICAgcWVtdV90aHJl
YWRfY3JlYXRlKCZ0aCwgIm1pZy9kc3QvY29sbyIsIGNvbG9fcHJvY2Vzc19pbmNvbWluZ190aHJl
YWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBtaXMsIFFFTVVfVEhSRUFEX0pPSU5BQkxF
KTsNCj4gICANCj4gICAgICAgbWlzLT5jb2xvX2luY29taW5nX2NvID0gcWVtdV9jb3JvdXRpbmVf
c2VsZigpOw0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jIGIvbWlncmF0aW9u
L21pZ3JhdGlvbi5jDQo+IGluZGV4IGUxYjI2OTYyNGMuLmQ0MWUwMGVkNGMgMTAwNjQ0DQo+IC0t
LSBhL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KPiArKysgYi9taWdyYXRpb24vbWlncmF0aW9uLmMN
Cj4gQEAgLTI0MDgsNyArMjQwOCw3IEBAIHN0YXRpYyBpbnQgb3Blbl9yZXR1cm5fcGF0aF9vbl9z
b3VyY2UoTWlncmF0aW9uU3RhdGUgKm1zKQ0KPiAgIA0KPiAgICAgICB0cmFjZV9vcGVuX3JldHVy
bl9wYXRoX29uX3NvdXJjZSgpOw0KPiAgIA0KPiAtICAgIHFlbXVfdGhyZWFkX2NyZWF0ZSgmbXMt
PnJwX3N0YXRlLnJwX3RocmVhZCwgInJldHVybiBwYXRoIiwNCj4gKyAgICBxZW11X3RocmVhZF9j
cmVhdGUoJm1zLT5ycF9zdGF0ZS5ycF90aHJlYWQsICJtaWcvc3JjL3JwLXRociIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBzb3VyY2VfcmV0dXJuX3BhdGhfdGhyZWFkLCBtcywgUUVNVV9U
SFJFQURfSk9JTkFCTEUpOw0KPiAgICAgICBtcy0+cnBfc3RhdGUucnBfdGhyZWFkX2NyZWF0ZWQg
PSB0cnVlOw0KPiAgIA0KPiBAQCAtMzc0NywxMCArMzc0NywxMCBAQCB2b2lkIG1pZ3JhdGVfZmRf
Y29ubmVjdChNaWdyYXRpb25TdGF0ZSAqcywgRXJyb3IgKmVycm9yX2luKQ0KPiAgICAgICB9DQo+
ICAgDQo+ICAgICAgIGlmIChtaWdyYXRlX2JhY2tncm91bmRfc25hcHNob3QoKSkgew0KPiAtICAg
ICAgICBxZW11X3RocmVhZF9jcmVhdGUoJnMtPnRocmVhZCwgImJnX3NuYXBzaG90IiwNCj4gKyAg
ICAgICAgcWVtdV90aHJlYWRfY3JlYXRlKCZzLT50aHJlYWQsICJtaWcvc25hcHNob3QiLA0KPiAg
ICAgICAgICAgICAgICAgICBiZ19taWdyYXRpb25fdGhyZWFkLCBzLCBRRU1VX1RIUkVBRF9KT0lO
QUJMRSk7DQo+ICAgICAgIH0gZWxzZSB7DQo+IC0gICAgICAgIHFlbXVfdGhyZWFkX2NyZWF0ZSgm
cy0+dGhyZWFkLCAibGl2ZV9taWdyYXRpb24iLA0KPiArICAgICAgICBxZW11X3RocmVhZF9jcmVh
dGUoJnMtPnRocmVhZCwgIm1pZy9zcmMvbWFpbiIsDQo+ICAgICAgICAgICAgICAgICAgIG1pZ3Jh
dGlvbl90aHJlYWQsIHMsIFFFTVVfVEhSRUFEX0pPSU5BQkxFKTsNCj4gICAgICAgfQ0KPiAgICAg
ICBzLT5taWdyYXRpb25fdGhyZWFkX3J1bm5pbmcgPSB0cnVlOw0KPiBkaWZmIC0tZ2l0IGEvbWln
cmF0aW9uL211bHRpZmQuYyBiL21pZ3JhdGlvbi9tdWx0aWZkLmMNCj4gaW5kZXggZjMxN2JmZjA3
Ny4uN2FmYzA5NjVmNiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL211bHRpZmQuYw0KPiArKysg
Yi9taWdyYXRpb24vbXVsdGlmZC5jDQo+IEBAIC0xMDU5LDcgKzEwNTksNyBAQCBzdGF0aWMgYm9v
bCBtdWx0aWZkX3Rsc19jaGFubmVsX2Nvbm5lY3QoTXVsdGlGRFNlbmRQYXJhbXMgKnAsDQo+ICAg
ICAgIGFyZ3MtPnAgPSBwOw0KPiAgIA0KPiAgICAgICBwLT50bHNfdGhyZWFkX2NyZWF0ZWQgPSB0
cnVlOw0KPiAtICAgIHFlbXVfdGhyZWFkX2NyZWF0ZSgmcC0+dGxzX3RocmVhZCwgIm11bHRpZmQt
dGxzLWhhbmRzaGFrZS13b3JrZXIiLA0KPiArICAgIHFlbXVfdGhyZWFkX2NyZWF0ZSgmcC0+dGxz
X3RocmVhZCwgIm1pZy9zcmMvdGxzIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIG11bHRp
ZmRfdGxzX2hhbmRzaGFrZV90aHJlYWQsIGFyZ3MsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBRRU1VX1RIUkVBRF9KT0lOQUJMRSk7DQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiBAQCAtMTE4
NSw3ICsxMTg1LDcgQEAgYm9vbCBtdWx0aWZkX3NlbmRfc2V0dXAodm9pZCkNCj4gICAgICAgICAg
IH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgcC0+aW92ID0gZ19uZXcwKHN0cnVjdCBpb3ZlYywg
cGFnZV9jb3VudCk7DQo+ICAgICAgICAgICB9DQo+IC0gICAgICAgIHAtPm5hbWUgPSBnX3N0cmR1
cF9wcmludGYoIm11bHRpZmRzZW5kXyVkIiwgaSk7DQo+ICsgICAgICAgIHAtPm5hbWUgPSBnX3N0
cmR1cF9wcmludGYoIm1pZy9zcmMvc2VuZF8lZCIsIGkpOw0KPiAgICAgICAgICAgcC0+cGFnZV9z
aXplID0gcWVtdV90YXJnZXRfcGFnZV9zaXplKCk7DQo+ICAgICAgICAgICBwLT5wYWdlX2NvdW50
ID0gcGFnZV9jb3VudDsNCj4gICAgICAgICAgIHAtPndyaXRlX2ZsYWdzID0gMDsNCj4gQEAgLTE2
MDEsNyArMTYwMSw3IEBAIGludCBtdWx0aWZkX3JlY3Zfc2V0dXAoRXJyb3IgKiplcnJwKQ0KPiAg
ICAgICAgICAgICAgICAgICArIHNpemVvZih1aW50NjRfdCkgKiBwYWdlX2NvdW50Ow0KPiAgICAg
ICAgICAgICAgIHAtPnBhY2tldCA9IGdfbWFsbG9jMChwLT5wYWNrZXRfbGVuKTsNCj4gICAgICAg
ICAgIH0NCj4gLSAgICAgICAgcC0+bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigibXVsdGlmZHJlY3Zf
JWQiLCBpKTsNCj4gKyAgICAgICAgcC0+bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigibWlnL2RzdC9y
ZWN2XyVkIiwgaSk7DQo+ICAgICAgICAgICBwLT5pb3YgPSBnX25ldzAoc3RydWN0IGlvdmVjLCBw
YWdlX2NvdW50KTsNCj4gICAgICAgICAgIHAtPm5vcm1hbCA9IGdfbmV3MChyYW1fYWRkcl90LCBw
YWdlX2NvdW50KTsNCj4gICAgICAgICAgIHAtPnplcm8gPSBnX25ldzAocmFtX2FkZHJfdCwgcGFn
ZV9jb3VudCk7DQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcG9zdGNvcHktcmFtLmMgYi9taWdy
YXRpb24vcG9zdGNvcHktcmFtLmMNCj4gaW5kZXggMzQxOTc3OTU0OC4uOTc3MDFlNmJiMiAxMDA2
NDQNCj4gLS0tIGEvbWlncmF0aW9uL3Bvc3Rjb3B5LXJhbS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9w
b3N0Y29weS1yYW0uYw0KPiBAQCAtMTIzOCw3ICsxMjM4LDcgQEAgaW50IHBvc3Rjb3B5X3JhbV9p
bmNvbWluZ19zZXR1cChNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMpDQo+ICAgICAgICAgICBy
ZXR1cm4gLTE7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBwb3N0Y29weV90aHJlYWRfY3JlYXRl
KG1pcywgJm1pcy0+ZmF1bHRfdGhyZWFkLCAiZmF1bHQtZGVmYXVsdCIsDQo+ICsgICAgcG9zdGNv
cHlfdGhyZWFkX2NyZWF0ZShtaXMsICZtaXMtPmZhdWx0X3RocmVhZCwgIm1pZy9kc3QvZmF1bHQi
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvc3Rjb3B5X3JhbV9mYXVsdF90aHJl
YWQsIFFFTVVfVEhSRUFEX0pPSU5BQkxFKTsNCj4gICAgICAgbWlzLT5oYXZlX2ZhdWx0X3RocmVh
ZCA9IHRydWU7DQo+ICAgDQo+IEBAIC0xMjU4LDcgKzEyNTgsNyBAQCBpbnQgcG9zdGNvcHlfcmFt
X2luY29taW5nX3NldHVwKE1pZ3JhdGlvbkluY29taW5nU3RhdGUgKm1pcykNCj4gICAgICAgICAg
ICAqIFRoaXMgdGhyZWFkIG5lZWRzIHRvIGJlIGNyZWF0ZWQgYWZ0ZXIgdGhlIHRlbXAgcGFnZXMg
YmVjYXVzZQ0KPiAgICAgICAgICAgICogaXQnbGwgZmV0Y2ggUkFNX0NIQU5ORUxfUE9TVENPUFkg
UG9zdGNvcHlUbXBQYWdlIGltbWVkaWF0ZWx5Lg0KPiAgICAgICAgICAgICovDQo+IC0gICAgICAg
IHBvc3Rjb3B5X3RocmVhZF9jcmVhdGUobWlzLCAmbWlzLT5wb3N0Y29weV9wcmlvX3RocmVhZCwg
ImZhdWx0LWZhc3QiLA0KPiArICAgICAgICBwb3N0Y29weV90aHJlYWRfY3JlYXRlKG1pcywgJm1p
cy0+cG9zdGNvcHlfcHJpb190aHJlYWQsICJtaWcvZHN0L3ByZWVtcHQiLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwb3N0Y29weV9wcmVlbXB0X3RocmVhZCwgUUVNVV9USFJF
QURfSk9JTkFCTEUpOw0KPiAgICAgICAgICAgbWlzLT5wcmVlbXB0X3RocmVhZF9zdGF0dXMgPSBQ
UkVFTVBUX1RIUkVBRF9DUkVBVEVEOw0KPiAgICAgICB9DQo+IGRpZmYgLS1naXQgYS9taWdyYXRp
b24vc2F2ZXZtLmMgYi9taWdyYXRpb24vc2F2ZXZtLmMNCj4gaW5kZXggYzYyMWYyMzU5Yi4uZTcx
NDEwZDhjMSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3NhdmV2bS5jDQo+ICsrKyBiL21pZ3Jh
dGlvbi9zYXZldm0uYw0KPiBAQCAtMjEyOSw3ICsyMTI5LDcgQEAgc3RhdGljIGludCBsb2Fkdm1f
cG9zdGNvcHlfaGFuZGxlX2xpc3RlbihNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMpDQo+ICAg
ICAgIH0NCj4gICANCj4gICAgICAgbWlzLT5oYXZlX2xpc3Rlbl90aHJlYWQgPSB0cnVlOw0KPiAt
ICAgIHBvc3Rjb3B5X3RocmVhZF9jcmVhdGUobWlzLCAmbWlzLT5saXN0ZW5fdGhyZWFkLCAicG9z
dGNvcHkvbGlzdGVuIiwNCj4gKyAgICBwb3N0Y29weV90aHJlYWRfY3JlYXRlKG1pcywgJm1pcy0+
bGlzdGVuX3RocmVhZCwgIm1pZy9kc3QvbGlzdGVuIiwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwb3N0Y29weV9yYW1fbGlzdGVuX3RocmVhZCwgUUVNVV9USFJFQURfREVUQUNIRUQp
Ow0KPiAgICAgICB0cmFjZV9sb2Fkdm1fcG9zdGNvcHlfaGFuZGxlX2xpc3RlbigicmV0dXJuIik7
DQo+ICAg

