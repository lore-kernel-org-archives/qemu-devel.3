Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9A2EA8556
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSz7-00056Z-KS; Mon, 09 Mar 2026 01:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzSz3-00056H-Ps
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:16:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzSz1-0008PD-3V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:16:49 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6294egQc1895714; Sun, 8 Mar 2026 22:16:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BRHT3CxthrIVnF4MdRq1yrZi2FHD1rbltCiEpQNln
 Os=; b=hEIP1a6kW22VZSGDHAvWHpwBkgvdrlvwswxWRUApt7I0l2IYtFzbtNtL5
 fgIDj30W+drqcR5W/YelTm80eN9yDdHSQy6emwZqkr9N/4WbjCmfygDQQdKY78V7
 h9HNU3brUePfM//A7UGVB6I0w4+rWcJiENa3GGSKtnVvfH4CBv6xGv8u9x85NUiW
 OtUJ3zdq8l6g++dMe2oWZ2ra95FS9STpF7MTkz09m+7jasq/zHVYUC9j1cQIljeP
 eg/A5z0rKAQabWjdQmu0t8eZZziAq8JEPbrLAMOsUjhNxITbJS+qeikfCV/a8nwO
 2KM4NHYBbcQd+VF7G23cWqmznHkVw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022101.outbound.protection.outlook.com
 [40.93.195.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4crjecjm6w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 08 Mar 2026 22:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6WtJsqP0wPOppXhuIb9fgyUV9/B2zcLacCsVnVdtLy/pUs2bMAljx0bx77rHCjg5AoAim3NYRcnRFw24VTEdg+P3nsszF+VLxzCuTNrDGlBe27+g7QMiZfxa2KRQjFcbmqNftVwSE/2cNfb1RwDbwjGvPXwBZ+Djl4qGrqW7klPe/m+OoUe8crkuGYVWohPl7mahrEwA6Nz6+i9jBDDozk6fx4iwPspgUBWilnqMjvgVoOQppBAwz1vcxbCRgAYi6ZnWCX2CTkluKZYbQxIP2t60EYUCLK1FL5CgXpUXqaPm2UXwgWxePYJQnNIOfMi1cV8bv+3CmMm16PnJnhlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRHT3CxthrIVnF4MdRq1yrZi2FHD1rbltCiEpQNlnOs=;
 b=QcMe4H/DGpfu0a4ifHsa3xRmPqpt8TNAF92aJ72gv/AaHU8+pw3ephO0FlfL5RnGRdqeeNF5fZC4SGqtYzIj8YSapdVqFCjtu17AZv43yrMN7US+UFBryBd4SRIZQPf8VldNM8LuNVQaSyi6w7iS4BEduKMaQw6QEL0hVIP0hJdpVYGnMNAQ8EBsTfLCAJEAb3neS0JEAV6zpySD+Ae7AQ8qbQlWXWaad1Q1AJ+f5SAk4HncBnr6MogVWcBHsZEbZ++vMgohzVjOBLHNRmWMyK/zV4WtHNTwcnO3PbXrN8dSelRyl5RyGGKhyCnchbJDjnMBs2mzut9ZRFZgDZY+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRHT3CxthrIVnF4MdRq1yrZi2FHD1rbltCiEpQNlnOs=;
 b=el+2T4DzPUPz2KD4u17Hq0ByyqKwwP2P6ItHCNPLIJBe0VPMoDKnS5G4gzaB2hMP/A2bPlByZ7m+LKUK5kPwvQh3xjy3FzjOyD+SNCo45AnqejO1KfBCrKaHjYwchhVmgTVShOFe4LR25NWPfX5pdiYiLNzkBAQvDF37FOkcX02SCtIToNN+Z2dfUwCLRoKDQWxA8cRVyO3MkYqWt/j1hA9/X0Inb7yqPk+TgZYzGMZXjWRBBQjIfooP0qLt7jAv0i+uTJt0/aqciKvcNcM87rQ30RRmsoZK0aZpYUK0hq0x7WXkRIE+VwjivVQxNOTRT56q+x4f29x/0lb8xFaYUg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by SJ0PR02MB7197.namprd02.prod.outlook.com (2603:10b6:a03:293::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 05:16:40 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9678.020; Mon, 9 Mar 2026
 05:16:40 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH v1 1/1] io: avoid false zerocopy missed accounting on
 empty flushes
Thread-Topic: [PATCH v1 1/1] io: avoid false zerocopy missed accounting on
 empty flushes
Thread-Index: AQHcrS1OVXu1Qpo290ul+1fn2E0lorWhxKEAgAPoyYA=
Date: Mon, 9 Mar 2026 05:16:40 +0000
Message-ID: <EC9CB56A-506E-4E83-8091-7A4E345AA26D@nutanix.com>
References: <20260306055121.3277731-1-tejus.gk@nutanix.com>
 <aasQKAlYOmnbqzIF@x1.local>
In-Reply-To: <aasQKAlYOmnbqzIF@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|SJ0PR02MB7197:EE_
x-ms-office365-filtering-correlation-id: 6963b877-0e18-4b02-db1d-08de7d9b0bb1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: J7itlRRsedwjEF5aLtUrJ9cGcI/845mhLEUOHxuQ5YsxCx/xFQJm5uC18oEoFPRifgpqt/kekBiL4biZ9fAXLromGhH1QfUIhNxP31btS7/NO5DHThosc3+9AoCs/Xr4l6qim1E2+W8JZID5u+i+aPK0y2mmS1HTJ3AhHw2kw/TAKwy5uLdyt8geW+ToIRqKh778k086P1ZO7Iyput+I3XVhQK3B3gEpL5dIYJjkissHK4YGeFPSFZUSwawZ6FXJuWlWhJwtEhm94HN1WzDijcs4VTPE3vKKF+VCtpFYSVjA+YltoFptFj9pF8PNJtXA03DgO3TJdcJ77BVIL33g39wxlFO0oSPheBSI1/E6tp5/1BUHaTg3xIZWdaIax6Q1ifufzh5u5fx/jcYpIySEh4x1V4f+8AzojZtqX/PNxzuBMTeLuBSMt1RbizS6INmtpB2zwuKIgpW6PBldZDzry4z2KnAEzzdLC4ZVEGenYfVNY0KRMLvro2PdaQIE8FBuovkLDx2taxZPoSNaoUtJIzXvD5q/aQsefZSJhRTRBracmjsEUhn+IsXuw6SNq0GxtV+4J+r4H79q8y3E26Gb8r48nqSN3oQ4qPlLWbYNC1dZp5v+SAwCTvr+0pWWQsHVd6gb9Avrvr0y+yhTKET+HCzorIGXbEf0aQdTL3JE3QNLkLQWxI3NVt7ofNJm1Da6l6+vnpeugf/VlGghhj5PExRU/EO2eM6N4U/uDK8YnDj0HAq2Qmw+haJI/NGSzqSLGsYkcrlDTmeNDlSxiYOXXxGKzUeF22dsHDu6fAqv51k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJieGIray9OWDBBWXJiMXFoTUpMam0rQ3JmbFdSRVpEKzZZZXRIemNFNWRO?=
 =?utf-8?B?OXY4SkE0UjYwOTRIMk1LTFh4Wm5VRzExQVQydnZ3dWpzdDFrSG9LK0hOY3hP?=
 =?utf-8?B?Um9lNi9nY2hMWGZ1RURObGVSUDZZbk5XNlk2cm5HS2tNdnpSRzRKaW9OSWs3?=
 =?utf-8?B?VXcvUkhEMGpsOXR6KzVmam85cUkxK0d2ZWE4dlZMQUtjREdVZEJrTVRXNnM2?=
 =?utf-8?B?emtHMitRRElEb2N2Q1dybXRvVUhodml3SG41am9NZlpmbllFM2VtVzZVTzlX?=
 =?utf-8?B?Wk1jSnV0Vmc1SVpTTUtiM0t3aE5CV3dQWW91eFBBRUhoTnVGZ1B0cUkwTzlV?=
 =?utf-8?B?T3c2ZFZmV1cxak1Genh5c0VvVkhRYnlhZDRrZyt6MVlQTkVtMVJiV21Ua2xO?=
 =?utf-8?B?NHpkaVk3NHI0OUQ1WmpBL0ZWVHBERC8rNkF5WTBobHBNdDFZM0lZRy9OS1JM?=
 =?utf-8?B?NVplckFMM1d1RzFNTGo5UXNYOWsrTjdJbGl6QllzU3BBN25lUmxnZVNJenlO?=
 =?utf-8?B?dkFxdFYrZ1N2THpYNzVWS1V5NmozZ3pDa3g1NWVadTF4Tng2cDZXWXhGV0ts?=
 =?utf-8?B?ajJDMXN1NXVpOWNQR01VSVZ6OU5rdklqMmk5UlpFbitDd2ZGdXoxSnFqSmpp?=
 =?utf-8?B?TW56ZUFNNzFTRGNSUDJ2TE12QlMzN0xQRmd4WDdwY2xwemlEMzdTSlc2dEp0?=
 =?utf-8?B?QXVDaHcvelJaU2dKT2pBQlVCeTN0cFZxL3MxelZKSGpFc0tyL21idlNQbS9M?=
 =?utf-8?B?Zy84ZThFQ3Rpb0RFNHJOQk1RN3RSbzFsYlRIVzB5aEJjMTQzdEVldXdwalJ6?=
 =?utf-8?B?eHUvSlBKR1ptcCt4WE5mMGo1YU5od2tYejM5alVMMlhYQkJ1bTUrKzB0djVw?=
 =?utf-8?B?R21qbnZBT1RkeDJMWDZmV1N6eHVLdGlBdWJtaEJVbzlsZzlkRDBBRGlka0hU?=
 =?utf-8?B?eWpnc2RoUHpQWUQ1U2V3Z0ZGaDBLZ3R6Q3c4OTdvUGM2V0RVK2RIZDZiT1pi?=
 =?utf-8?B?NktaYmVHbVpaN1d5b05kWnAvZlpkMTdBZ0pNcDZDNmZOL0w5OTFLN1JxTXFC?=
 =?utf-8?B?ZUNUbHZIU3R6ejhwbFlKQVVPVzhaaElkVTBOc0NlNEVQUVpvY0RlOWpaTDFJ?=
 =?utf-8?B?S0xPb1M4ZTlmaW1vTGV2bjdWSEFaZ2NSQlZFV1Vtd0N4OEFIelMxYjgvc0RT?=
 =?utf-8?B?R1ZxbVdKMDJ5SS8vRExYUTJIbzBNNzdiN2hmTHc0bG9xWG80U0pjdEtRQjZM?=
 =?utf-8?B?MUQ3SFhhVnlDNFNmSFArczZZWlZtVHdBc0g4alh2Q2ZCZkZNemwwOUtpSDBK?=
 =?utf-8?B?KzU5ZlljaXByaWVIOGdxU2dvMDM3QStpaktjRXF2QXdMcytYeGNodWVjZVc2?=
 =?utf-8?B?azM0a3VaOHIvVG1hZW9nV3dYRGwydzBhUmUyNlAvblJkWmpxd3ZMZ0dWUDY5?=
 =?utf-8?B?bVJLUUluT0Y2NnZ3ZVZwbitwekVaSGs5Nk16cVRzMzBpeUJQTGloN0xCMHBp?=
 =?utf-8?B?YTVXOVZnYjJaQzBINHUyV01nTUM4MHZBMTFBODIvTEpRdjIvTDMrVG9CbDJw?=
 =?utf-8?B?blVKWDFVNG1lS0xPMjFMWE9remRsWjA3VjRtcTduRnUxaVd1WlRXcGVSRk9t?=
 =?utf-8?B?b0x3OWdLanBTL1BmZFZ0dFFCM2VYdWthaXJWZnZGb2VBQmtlTUkwWXpSK3Ns?=
 =?utf-8?B?UDFVQjlCdXdycE43d2pndWMzYWZMWHdITzNRVjR0OXZQc3lqUzNVcVBJTTVR?=
 =?utf-8?B?bGlLbUtLdEw3UkJQZVBaL0cvQjAwTElwdVdlbUpoYjUrL3VyWk9RZUFXTWVw?=
 =?utf-8?B?UUJFS09QTG50Y3N2SGYwVXRYeXh2ZldZcGNncTVkVjlRcHRqcTBGMitlYklK?=
 =?utf-8?B?VXdMaWdibFVIOEJuUkgwMU5aZjduQzdLeU11LzFkL25KdFJRcnVzWnJpUmxa?=
 =?utf-8?B?ek01Y20rc3JBdFhCaDF2aTA5OVN2dENuMHU2aWhmUmc2MnlFZFkvSkszd2J3?=
 =?utf-8?B?YmlkSmJCcER6ZEJrK2dJYnQ0ZVFoUFpwNDlqOHpERWZtVWRKR3JLQnkrSHRv?=
 =?utf-8?B?ZU5ZUFVnMEF6QVFYNkFEdGZVV2pwYTd3RUhCRXpMdUtYQVdiVW00K2g5UTUx?=
 =?utf-8?B?RGVjRE14UTBhNjVrZ0lWUmdaM0ZTTEdCT1BlQnU4TFk3cG1PTjF3Q1dMaWdB?=
 =?utf-8?B?aU1hTFh2SlpBNWEybjNjb3dMWkpzRCtJdXRFU0RHT20zdm9qc0U4ZWVlMGNH?=
 =?utf-8?B?SGtNYUhpNXloc2FIY3UrTWZrWnM5d2dHYmNscXE3WmhycEdjbW1Pc0d0amxa?=
 =?utf-8?B?Zkp0MEdzdnJFZ2NkNW9Rclh0aXc3c082eExtVHdSdTFKU0lGcENOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBE6EB56351BD04984CABC41B98F6AA5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vfTDsrbpGD7BB/JbGCvIJuza10tMyrYq7KS99pVGn3kxIu7S6ZJST8w/nvKNWdeFAInwiAp6aTnzrVBmpHa4YUpE462Os5/y68rqwzIDhVZjqTN9+aANxBJsrj0lge3W4lCYdm9I0YCFST7dPDOIKHF1h1TJHpSEf0Sw3pYVLi8C0U76GzMqWSMDr7owEx0WztruRJaojF0Txpuc6R3b1i2DxBe0bEG/5a8F7CCgh8dj8Rqf3I+YjlWJnTh82sUaUYy80HBnkuHDVDE29OAGb0NYFbm45qMnUXS9zupnFZRs+4E6z228TK1wBfel+7yzMJW1VXnjUcEwMOS7Uicckg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6963b877-0e18-4b02-db1d-08de7d9b0bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 05:16:40.2329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 470+pjqI12869wLDneRmH3IAYAej5mFVRWannv1isRQzNTi4N/71vYtP1LCyOhhbffL8/j3Y8+VVadLyzsHOUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA0NiBTYWx0ZWRfX+42tHlWzW06s
 oucCcgcvXQy5ix2MZ2N91VLxkdFd7v8Qo4Qf3PmcufZXVzISLw+HGI6NtxnNRF0JM55AKl3cNjc
 PNsf2i82Dl3i9o9JpjoNqUEc2q5NCFwCPnGJGGjv4mWcJIBQ9AKSIbo1Amrkgtsdrx8s2w/QCRP
 L8oaCFXDzcz/QvgLooxv1U5il0FDcCZACNcx929NHpbTX6wumHl/eXICInE64MYqYcnZBT05hrI
 SC4KSZhamaUCqdCdyw06XzW6AvGjf1C3UFl/YGirer21qvnp4cY0XDpLstbvs364C+ChcYoxP6c
 8OzyGAPe5TPHBQHNsMwYSZn0FJQdg5sR7ITF5Bq9r2kOYFGc+u8hy/Yw/mygJUMvzC63xTmyWJd
 Na6TYZHEQzfP07LC0tRgtHWyjExOJUY8pEe5jN0DnXpaoGJBPgOMrI+KcnaD2tz9wuvkEKCvoPB
 EYO8PcnaSbdxv7QFmWg==
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=69ae57ba cx=c_pps
 a=qdGNMY5putnn3dTEtBI8ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=3p-5X_zRG9rhsZUc1DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WuMLtCw0ybTBONDSzeSZCBtCHvtP60Z-
X-Proofpoint-ORIG-GUID: WuMLtCw0ybTBONDSzeSZCBtCHvtP60Z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gT24gNiBNYXIgMjAyNiwgYXQgMTE6MDTigK9QTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjogRXh0ZXJuYWwg
RW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gRnJpLCBNYXIgMDYsIDIwMjYgYXQg
MDU6NTE6MTdBTSArMDAwMCwgVGVqdXMgR0sgd3JvdGU6DQo+PiBxaW9fY2hhbm5lbF9zb2NrZXRf
Zmx1c2ggY291bGQgcmV0dXJuIDEgd2hlbiBubyBuZXcgemVyby1jb3B5IHNlbmQNCj4+IGNvbXBs
ZXRpb25zIHdlcmUgcXVldWVkLCB3aGljaCBpbmNvcnJlY3RseSBpbmZsYXRlZCB0aGUNCj4+IGRp
cnR5LXN5bmMtbWlzc2VkLXplcm8tY29weSBzdGF0LiBGaXggdGhpcyBieSByZXR1cm5pbmcgMCwg
d2hlbiB0aGVyZSdzDQo+PiBub3RoaW5nIHRvIGZsdXNoLCBzaW1pbGFyIHRvIHdoYXQgcWlvX2No
YW5uZWxfc29ja2V0X2ZsdXNoX2ludGVybmFsDQo+PiBkb2VzLg0KPj4gDQo+PiBTaWduZWQtb2Zm
LWJ5OiBUZWp1cyBHSyA8dGVqdXMuZ2tAbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IGlvL2NoYW5u
ZWwtc29ja2V0LmMgfCA0ICsrKysNCj4+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykN
Cj4+IA0KPj4gZGlmZiAtLWdpdCBhL2lvL2NoYW5uZWwtc29ja2V0LmMgYi9pby9jaGFubmVsLXNv
Y2tldC5jDQo+PiBpbmRleCAzMDUzYjM1YWQ4Li42ZjY0N2U0NzFiIDEwMDY0NA0KPj4gLS0tIGEv
aW8vY2hhbm5lbC1zb2NrZXQuYw0KPj4gKysrIGIvaW8vY2hhbm5lbC1zb2NrZXQuYw0KPj4gQEAg
LTg5NSw2ICs4OTUsMTAgQEAgc3RhdGljIGludCBxaW9fY2hhbm5lbF9zb2NrZXRfZmx1c2goUUlP
Q2hhbm5lbCAqaW9jLA0KPj4gICAgIFFJT0NoYW5uZWxTb2NrZXQgKnNpb2MgPSBRSU9fQ0hBTk5F
TF9TT0NLRVQoaW9jKTsNCj4+ICAgICBpbnQgcmV0Ow0KPj4gDQo+PiArICAgIGlmIChzaW9jLT56
ZXJvX2NvcHlfcXVldWVkID09IHNpb2MtPnplcm9fY29weV9zZW50KSB7DQo+PiArICAgICAgICBy
ZXR1cm4gMDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgIHJldCA9IHFpb19jaGFubmVsX3NvY2tl
dF9mbHVzaF9pbnRlcm5hbChpb2MsIHRydWUsIGVycnApOw0KPj4gICAgIGlmIChyZXQgPCAwKSB7
DQo+PiAgICAgICAgIHJldHVybiByZXQ7DQo+PiAtLSANCj4+IDIuNDMuNw0KPj4gDQo+IA0KPiBU
aGlzIGxvb2tzIGZpbmUgKHdlaXJkIHRvIGV4cGxpY2l0bHkgY2hlY2sgdGhpcyB3aGlsZSB0aGUg
X2ludGVybmFsIGNoZWNrDQo+IGl0IGFnYWluKSwgSSBoYXZlIGEgbWFqb3IgY29uZnVzaW9uIG9u
IHRoaXMgemVyb2NvcHkgc3RhdGlzdGljIGNvdW50ZXIuDQo+IA0KPiBSaWdodCBub3csIGFzIGxv
bmcgYXMgdGhlcmUncyBvbmUgc3VjY2Vzc2Z1bCB6ZXJvY29weSBoYXBwZW5lZCwgdGhlIHdob2xl
DQo+IGJhdGNoIChiZWZvcmUgYSBpb19mbHVzaCgpIGNvbGxlY3RpbmcgdGhlIHJlc3VsdCkgd2ls
bCBiZSBtYXJrZWQgImFsbCBJT3MNCj4gYXJlIHN1Y2Nlc3NmdWxseSB6ZXJvLWNvcGllZCIuDQo+
IA0KPiBBRkFJVSwgdGhhdCBtYXkgbm90IGFsd2F5cyByZWZsZWN0IHRoZSByZWFsaXR5IGV2ZW4g
aWYgbm8gZmFsbGJhY2sNCj4gcmVwb3J0ZWQsIGluc3RlYWQgd2UgZG8gaGF2ZSBmaW5lciBncmFu
dWxlIHJlc3VsdHMgcmVhZHkgd2hlbiBmbHVzaGluZy4NCj4gDQo+IEluc3RlYWQgb2YgZml4aW5n
IHRoaXMgcmVwb3J0IGJhc2VkIG9uIGFuIGFscmVhZHkgaW5hY2N1cmF0ZSBzdGF0cywgc2hhbGwN
Cj4gd2UgbWFrZSB0aGlzIHN0YXRzIG1vcmUgdXNlZnVsPyAgU2F5LCByZXBvcnQgYWxsIGZhbGxi
YWNrIElPcyBoYXBwZW5lZD8NCj4gVGhlbiBpZiBpdCByZXR1cm4gMCwgaXQgc29saWRseSBzYXlz
IFpFUk9DT1BZIGZhbGxiYWNrIG5ldmVyIGhhcHBlbmVkLg0KPiANCg0KSGkgUGV0ZXIsIHRoYW5r
IHlvdSBmb3IgdGhpcyBzdWdnZXN0aW9uISANCkkgd2lsbCBpbmNsdWRlIGl0IGluIHRoZSBWMiBw
YXRjaC1zZXQgYW5kIHNlbmQgaXQgb24gdGhlIGxpc3Qgc2hvcnRseS4gDQoNClJlZ2FyZHMsDQpU
ZWp1cw0K

