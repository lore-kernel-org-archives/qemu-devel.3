Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335F9C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVc2-0007hD-Om; Wed, 27 Mar 2024 11:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpVbu-0007fG-Qq
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:54:44 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpVbr-0004lI-4q
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:54:41 -0400
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42RCfta6027149; Wed, 27 Mar 2024 08:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=sel1;
 bh=o0SQ+Ozuje4J+0zaKai2X3ZEyqCTey6Z24Pz8FCi930=; b=jA/xAYmI/0Fq
 8rT5hsX26KnQ7Vu6tiEOwVv5WW5B32Qa1ytlsbDZgUKOVrWvmeSoBftqEgj6Cei9
 2YpRFuAmpQpFsmrjYYbPmS+6KDP1/4QlefK5vzIM+3tnMK0iof8c96yNxglhtyvI
 g46vG2iNf2b4fY6jPf9yWL69AVpmanAptvo4f3s/BTq2656wdrUh2TFKeEd302N+
 q8Qa2kiUtx/kqXIw1FcXVuROhZJ4OpJthWw1QBuJZxg+z7gMq8O1m4eb99J19Ql4
 wsTm0pSUu+4QkmpZuw5aKwAOx/AcuZlj52qgkDjGmMR5COZHLkr5qn17JrBguHYl
 SMnA9/FSkw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x41928rmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 08:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUhZaf6k40zZlhvE6+Kme5vAmI7/JR0xKISPlz5A7tM+fRy84LVw7+T2Wnk8NVHWmAhhcR+YFTDpIC4QB7ZDK3IadNyOGvy/gwccae85fQBlxSFdfyOVSW+sAJSoPjDxf05g4L3bGmAU6KlntzJUPylfvPTIg90fxA/8AzNqNfQeTD3aXh4H8OFoGNsudpP6oEbHNg6LkrtWYfG4R6edoFgkiT2A4G7n0WMCh2BCjMZuNx5wbwTfs6IWLXI0QiRMXGRJqzX3YT+eH0vdg+OtI1BzgMdz8qui2tgWnCyiam2i5kRT4cblfwLoXn/JMnRCxMJ+lh9zBsL4yLi6WEc8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0SQ+Ozuje4J+0zaKai2X3ZEyqCTey6Z24Pz8FCi930=;
 b=TNNBqwBpts/GzmhKh/gzoj8QYMwUvVxmxczxt/8uxiU4VmB4qVexs2r0FRa67ZI8t3PZz6ZImidMp00a7SN/Q4b7aHjIEvKZl/AxS2LWEowJJ/wyQ/myVIWEny3UlPTMwO8gv3l7nAj/T8Q8wzREme/XoYf6YmhrYBS3lZR9s80TVMnRIoM3yWsRjjp4BaX4ANtQN7Tc1rVAcbekUCWhqga86p7sUFDMBfFqZWBf9zYO85xSnW0xzjAmreJyPZ/t4eOHjGgD0Kv7SbmCLjMc9ZAuQ7nwh/A3VVtz92lYa2t5bwMI38gRIZfWs4lDNDs3aSi9ot6bp9h1fhPwmlAIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0SQ+Ozuje4J+0zaKai2X3ZEyqCTey6Z24Pz8FCi930=;
 b=D4VoRJeXPnY5SxoJ21lV1kJC4jWn58hfZZml91kWAupSDTCithEwimpI/eU4C51aXsAXEs30JFKINhP+LHNC0ypfzG8A3VnsxKsZB7V2tBh/qtZKKvcjuQ+e/3OYGUhOG4tuoFNLW3nWPpDZZATNkJcbvEx20V9MBrLucV0L4mITMxpoRMysswtKaMuAicZ0n8ub+2X/VbxxcINEH9xD2fql6s5g23DGoj/gh5QI+lRAIwzGdFFH1kO1uDAIiRpuCrNRbV0rCnVLUQ1c+9JOtWr4LJUixUZGjybc0v/56TgGMe31252hWD/Um02Gqa2Wx82Hwga1HLPsTuY6FrTc3A==
Received: from LV8PR22MB4551.namprd22.prod.outlook.com (2603:10b6:408:191::9)
 by LV8PR22MB5550.namprd22.prod.outlook.com (2603:10b6:408:221::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 15:54:31 +0000
Received: from LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0]) by LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 15:54:31 +0000
From: Aidan Leuck <aidan_leuck@selinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>
CC: "kkostiuk@redhat.com" <kkostiuk@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: RE: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
Thread-Topic: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
Thread-Index: AQHafID/9gwWMd1Nv0WEOcKrxrIAc7FIwNoAgALuMeCAABGBgIAAAhHg
Date: Wed, 27 Mar 2024 15:54:31 +0000
Message-ID: <LV8PR22MB4551451CC99AA21DE5562241E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
 <20240322174637.499113-3-aidan_leuck@selinc.com>
 <330d90fc-e5ff-4b7d-a01f-5587274a5f2a@linaro.org>
 <LV8PR22MB455124393BD875586CBDBEE7E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
 <ba07096c-029c-4405-85df-005e89826242@linaro.org>
In-Reply-To: <ba07096c-029c-4405-85df-005e89826242@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR22MB4551:EE_|LV8PR22MB5550:EE_
x-ms-office365-filtering-correlation-id: 6982384f-9007-43f9-2934-08dc4e76311c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIb2p0oFhF3chnQ5TiXzdmWl1j8eU4G/OE+U3oOjwiYQDbVFYRa3Mg3mquvCMhWtWBDsU9TDzrbWha0aCLnwQPUUR5QUrXkJ9kHKK5twiXpdNclaf+5wHSjL4lL0Mivs2FrX2XsscS75diNlJocTxoN3SiAmW7TFL3TzmJm42XB7BymoMlGp7JBAzubMoSWNeGuwLVm3Wo9Q6h5F9dr1Y6sYxv34QcICskCUl+0J9va/QsFUAAjXB01UvTPeMJv9aUZephxGB5qlcxe3zVY/W+Lw6/W4mRfa8qJEK2NxExYE+OjCOkbxUXjGNduCx7VpMggOZFfRd9/TrCQLeFfj+M5pGGUElmGsG62gqOCcNNgip4qoSWW34pqRips3mbymh8f/GCNsE2fdpBypADRykU2mdXXj/pQ+1iCLZAd85lSK9/Wz0ewUzE6MPzQqe6mtpzOg8GRHCo9mJr+vsg/ROvhtDfEHoIbHabvJkyubNDJWvxjgds7Y+2uJpplCsveZ7G3W9p+5eT6jFQP2wOHQpG+UieYFDv2OjtQ1/KjThqsKlbdyImLo2SHiUIZ1fXzlH/93kFSw3idhzWJUYCbpsH33xDCEWSdHW6cxmQmJWqXTFTtTT74U92Dxl3tywu5Lq3ihlQerBjzX5xJl5nUWAaIhxqDH+dRow5dIwIrS+Esb9s99AFqDHXSLl9QqoMfZXAQ88CsR04gRDPvEv/SIvRSN04CU8be6aySglH3RMq4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR22MB4551.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2YvcHBLaWxCOWxrMmhSZXVTZUoyYnczUGoxclVOT1gzWmZRbDQvVGwrbHJr?=
 =?utf-8?B?Y1JHZUJEenJ3R2gzQS9iZ3crTzNndG5Cc2NNcFM3bHdtSDZzZ2V4K0FOSHQx?=
 =?utf-8?B?QVl1MnpBZ1I2Q0FrVEx1NkkwNHBtbTZRUUc2a0xEWFdsZUZCazRLQnBGbnpI?=
 =?utf-8?B?dit6VklBaUJYUW1EcmRNQ2U3QXRFS0dWUTBPcWtseDl4ZGZoZGF5WWt2M1hV?=
 =?utf-8?B?YXdjbzIyQmZqZmEvSGg4dG80V2ZHY0JJWkhrVmh3WUNyeFdhUEx4aVJ1SmZK?=
 =?utf-8?B?dGZ6UkxHYm9uYXozeXNidTJPZW41Q1I4VlV2UkRRbjBMVFpRWmdqZ2dBRisv?=
 =?utf-8?B?OVpQYkVxU2EzQjl5SG1EVTZQT1ZibDcvYjQ3NmhRR2FrQ3NQUE1YbVNqQjBF?=
 =?utf-8?B?Q1FQTkZPc0x4S2hqK0l2eTJZL0xzNjJCNG1SSDc4SE0vR3R3Z2lvcTU3ZWhP?=
 =?utf-8?B?alNLbFBicnBsOHBEanpSZS80YWdzblY2eGxQMk5DQUlDRFpFVmp4ckRRREV3?=
 =?utf-8?B?QXpUTlBNRWtvLzZZcjlYb3kyWEZXM2g0TXkvSXg0ZmQ0QmRob0R6MmtRNUI5?=
 =?utf-8?B?UlpEaXpyYW9DelZ0VkFTYm5LWkZjcUtxN2xvMkh1UnBJQVpBUmJHOFJpZDE3?=
 =?utf-8?B?eFErUjd1bEN1bGo3d0FRbXJFbUc1aVJxNUxoeW9mWFdOYlBVK1hEY01YT3Aw?=
 =?utf-8?B?M1lLV2xENU9TK1VkWFpJeFpOeUk4MGVtZk9RNmkwcm0vdVNxWlpZcjM5S29K?=
 =?utf-8?B?MDZkelZncXRvNHVZcEtOaHZ4RXNKNjgrSnYySC9DY3dmaytuVG5pR2FZcmYy?=
 =?utf-8?B?VXRvdERaNjB1MDBjVFI1c3ZSLzF1OVBLZXJxc0toQ1FIcHh1aldZbXJUeHdL?=
 =?utf-8?B?WFYxdGg1RjcxMU5Idk5ETUJBNmh2ME9ZeTJ0aGx6cmJuYjF2TldUb3MycVJx?=
 =?utf-8?B?cWFxeHBodTlQQzhrcVNFLzB3OFZNOFRjdWtBQ2dRdnpWQkMzaEk1TFRoN2JH?=
 =?utf-8?B?RTh6NzFVY3Y1bENuY3ZjS09BdFNlblpNQ2NiRTJsd0NRNDI2SGhIQ0hORlBT?=
 =?utf-8?B?OWlWZHlDWWFaYnNJVlRmdmZvYkNFT25kUEQxek1EMEVoU3YzVE45cE9hNVo5?=
 =?utf-8?B?VDVQb0lhaGcwVExTK2xGeFRIQi9mNDF3cGNkYmJTbFovNm5rU0t6aTBqWDg4?=
 =?utf-8?B?L1dpNE9PR0tscFpKQlNBOXBvK3hxbmxFRW9NWkdBRzliTnRmdktzUHBOZ3Jr?=
 =?utf-8?B?dVQzL285RVVGb2Zld0VCeVhua1VSRTlKSlRSYkg0ZXpmQWJkWUphK2Y5Uyt4?=
 =?utf-8?B?S25QTHhVbnJndkJQWDl1VUh4bjF1VWJwbEhhZ3VveEUxclRLWkNTQWZBY09y?=
 =?utf-8?B?WndFZitpQy9GcDRMMnNhcHpqcXo0R3FRd1JUTUczTU1xaUJicmZaeXNQMWdw?=
 =?utf-8?B?eEViT0Q3UjU2YTYwdTMvY245YUc0SWFHRHJYQ1NYZkFMN3AwbVVCTkp5cTBJ?=
 =?utf-8?B?bnhzQTg3bmREWktuWHJ0N2JCZnBWbCtLUHdMN3ZIYzdobXl3bGV1dnMvdk52?=
 =?utf-8?B?TmNwa2IxTmtPMFZ3RVJTQmhpRTJoU3k5NHU1Q1VabVBZZWtZZ2Juak9XV2hD?=
 =?utf-8?B?TmtlNE45dlJPQWo0emVpOUZwVkIrQitpeFdTZW15bm5NOHhXUDJMR0xZcHNU?=
 =?utf-8?B?bFozYkNiNVZMSHhtT25MUWpuTWN4VHpqVmlNUUQ3RkR6Tm9rTTV5QjMzOXlK?=
 =?utf-8?B?S0pUMzZBUmt6RWowWFVPTUFibkk2UVZPYlZiKzQ0azBGNnYyVkFObmRZSzAz?=
 =?utf-8?B?ZUlvSlZRN1EzQW1jYWFRVHl5eUcxNUljdzRFQ0xLc08xZTMxVExaWCtwc25E?=
 =?utf-8?B?Tkx5RWNHMWh5eFR1NWNCQ0tJVWdLL3lLN1FBZDFVa2kzbmhNY1JjRElmYzRE?=
 =?utf-8?B?eTVieUZSOW00cHhLVFZnL2ZtUk9jUTIxZjVjejVROWNaQ0ZtQm5UaDZOcnBN?=
 =?utf-8?B?cnVITjF2S0NmZzFJNnNrTGM0aFpNM0dFM29Wd1dKUFdoSDhnbDBzaC9vUEw0?=
 =?utf-8?B?YlpUZmhwRENqYk1qWng2bEZaNkxwMGt6dStvRmJkaU5CMS94dmtJQnJsaUMr?=
 =?utf-8?Q?rBpmNErb8kx5bCNzazJ2Bknfv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR22MB4551.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6982384f-9007-43f9-2934-08dc4e76311c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 15:54:31.6395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YayyGM7psSLqAKmrK6Rt827+zWFSDYzfTFBzrqDsPYYRbGLkmAfr83EDAcEULnbW5shZ2vw66kc9xJuLJE9j1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5550
X-Proofpoint-ORIG-GUID: rdwIVY8mvOvUvXNukI0F9vyPBvx0aUjK
X-Proofpoint-GUID: rdwIVY8mvOvUvXNukI0F9vyPBvx0aUjK
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270110
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78160ec3c5=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyNywgMjAy
NCA5OjM4IEFNDQpUbzogQWlkYW4gTGV1Y2sgPGFpZGFuX2xldWNrQHNlbGluYy5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmc7IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4N
CkNjOiBra29zdGl1a0ByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tDQpTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDIvMl0gSW1wbGVtZW50IFNTSCBjb21tYW5kcyBpbiBRRU1VIEdBIGZvciBX
aW5kb3dzDQoNCltDYXV0aW9uIC0gRXh0ZXJuYWxdDQoNCk9uIDI3LzMvMjQgMTU6MzgsIEFpZGFu
IExldWNrIHdyb3RlOg0KPiBIaSBQaGlsaXBwZSwNCj4gVGhhbmsgeW91IGZvciB5b3VyIGZlZWRi
YWNrIEkgd2lsbCBnZXQgdGhlc2UgaXNzdWVzIGFkZHJlc3NlZC4gSSBsZWZ0IG9uZSBzbWFsbCBj
b21tZW50IG9uIHRoZSBRQVBJIHNjaGVtYSBKU09OLg0KPg0KPiBBaWRhbiBMZXVjaw0KPg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjUsIDIwMjQgMTE6
NTEgQU0NCj4gVG86IEFpZGFuIExldWNrIDxhaWRhbl9sZXVja0BzZWxpbmMuY29tPjsgcWVtdS1k
ZXZlbEBub25nbnUub3JnDQo+IENjOiBra29zdGl1a0ByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRo
YXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBJbXBsZW1lbnQgU1NIIGNvbW1h
bmRzIGluIFFFTVUgR0EgZm9yIA0KPiBXaW5kb3dzDQo+DQo+IFtDYXV0aW9uIC0gRXh0ZXJuYWxd
DQo+DQo+IE9uIDIyLzMvMjQgMTg6NDYsIGFpZGFuX2xldWNrQHNlbGluYy5jb20gd3JvdGU6DQo+
PiBGcm9tOiBBaWRhbiBMZXVjayA8YWlkYW5fbGV1Y2tAc2VsaW5jLmNvbT4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBaWRhbiBMZXVjayA8YWlkYW5fbGV1Y2tAc2VsaW5jLmNvbT4NCj4+IC0tLQ0K
Pj4gICAgcWdhL2NvbW1hbmRzLXdpbmRvd3Mtc3NoLmMgfCA3OTENCj4+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4NCj4gSHVnZSBmaWxlLCBJJ20gc2tpcHBpbmcgaXQu
DQo+DQo+PiAgICBxZ2EvY29tbWFuZHMtd2luZG93cy1zc2guaCB8ICAyNiArKw0KPj4gICAgcWdh
L21lc29uLmJ1aWxkICAgICAgICAgICAgfCAgIDUgKy0NCj4+ICAgIHFnYS9xYXBpLXNjaGVtYS5q
c29uICAgICAgIHwgIDE3ICstDQo+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDgyOCBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBxZ2EvY29tbWFu
ZHMtd2luZG93cy1zc2guYw0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHFnYS9jb21tYW5kcy13
aW5kb3dzLXNzaC5oDQo+DQo+DQo+PiBkaWZmIC0tZ2l0IGEvcWdhL3FhcGktc2NoZW1hLmpzb24g
Yi9xZ2EvcWFwaS1zY2hlbWEuanNvbiBpbmRleCANCj4+IDk1NTRiNTY2YTcuLmE2NGE2ZDkxY2Yg
MTAwNjQ0DQo+PiAtLS0gYS9xZ2EvcWFwaS1zY2hlbWEuanNvbg0KPj4gKysrIGIvcWdhL3FhcGkt
c2NoZW1hLmpzb24NCj4+IEBAIC0xNTYyLDkgKzE1NjIsOCBAQA0KPj4gICAgeyAnc3RydWN0Jzog
J0d1ZXN0QXV0aG9yaXplZEtleXMnLA0KPj4gICAgICAnZGF0YSc6IHsNCj4+ICAgICAgICAgICdr
ZXlzJzogWydzdHInXQ0KPj4gLSAgfSwNCj4+IC0gICdpZic6ICdDT05GSUdfUE9TSVgnIH0NCj4+
IC0NCj4NCj4gRm9yIFdpbmRvd3MgeW91IGhhdmUgdG8gY2hlY2sgdGhlIENPTkZJR19XSU4zMiBk
ZWZpbml0aW9uLCBzbyB5b3Ugd2FudDoNCj4NCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIG5lY2Vz
c2FyeSwgdGhlIFFFTVUgZ3Vlc3QgYWdlbnQgaXMgY29tcGlsZWQgZm9yIG9ubHkgUE9TSVggYW5k
IFdpbmRvd3MuIEkgZG9uJ3Qgc2VlIHRoaXMgcGF0dGVybiBiZWluZyB1c2VkIGVsc2V3aGVyZSBp
biB0aGUgcWFwaSBzY2hlbWEgZmlsZS4gSSB3b3VsZCBiZSBpbnRlcmVzdGVkIGluIHdoYXQgdGhl
IG1haW50YWluZXJzIHRoaW5rPw0KDQokIGdpdCBncmVwIC13IENPTkZJR19XSU4zMiBxYXBpLw0K
cWFwaS9jaGFyLmpzb246NDkwOiAgICAgICAgICAgIHsgJ25hbWUnOiAnY29uc29sZScsICdpZic6
ICdDT05GSUdfV0lOMzInIH0sDQpxYXBpL2NoYXIuanNvbjo2NjM6ICAgICAgICAgICAgICAgICAg
ICAgICAgICdpZic6ICdDT05GSUdfV0lOMzInIH0sDQpxYXBpL21pc2MuanNvbjoyOTM6eyAnY29t
bWFuZCc6ICdnZXQtd2luMzItc29ja2V0JywgJ2RhdGEnOiB7J2luZm8nOg0KJ3N0cicsICdmZG5h
bWUnOiAnc3RyJ30sICdpZic6ICdDT05GSUdfV0lOMzInIH0NCg0KPg0KPiAgICAgJ2lmJzogeyAn
YW55JzogWyAnQ09ORklHX1BPU0lYJywNCj4gICAgICAgICAgICAgICAgICAgICAgJ0NPTkZJR19X
SU4zMicgXSB9LA0KPg0KPj4gKyAgfQ0KPj4gK30NCj4+DQo+PiAgICAjIw0KPj4gICAgIyBAZ3Vl
c3Qtc3NoLWdldC1hdXRob3JpemVkLWtleXM6DQo+PiBAQCAtMTU4MCw4ICsxNTc5LDggQEANCj4+
ICAgICMjDQo+PiAgICB7ICdjb21tYW5kJzogJ2d1ZXN0LXNzaC1nZXQtYXV0aG9yaXplZC1rZXlz
JywNCj4+ICAgICAgJ2RhdGEnOiB7ICd1c2VybmFtZSc6ICdzdHInIH0sDQo+PiAtICAncmV0dXJu
cyc6ICdHdWVzdEF1dGhvcml6ZWRLZXlzJywNCj4+IC0gICdpZic6ICdDT05GSUdfUE9TSVgnIH0N
Cj4+ICsgICdyZXR1cm5zJzogJ0d1ZXN0QXV0aG9yaXplZEtleXMnDQo+PiArfQ0KPj4NCj4+ICAg
ICMjDQo+PiAgICAjIEBndWVzdC1zc2gtYWRkLWF1dGhvcml6ZWQta2V5czoNCj4+IEBAIC0xNTk5
LDggKzE1OTgsOCBAQA0KPj4gICAgIyBTaW5jZTogNS4yDQo+PiAgICAjIw0KPj4gICAgeyAnY29t
bWFuZCc6ICdndWVzdC1zc2gtYWRkLWF1dGhvcml6ZWQta2V5cycsDQo+PiAtICAnZGF0YSc6IHsg
J3VzZXJuYW1lJzogJ3N0cicsICdrZXlzJzogWydzdHInXSwgJypyZXNldCc6ICdib29sJyB9LA0K
Pj4gLSAgJ2lmJzogJ0NPTkZJR19QT1NJWCcgfQ0KPj4gKyAgJ2RhdGEnOiB7ICd1c2VybmFtZSc6
ICdzdHInLCAna2V5cyc6IFsnc3RyJ10sICcqcmVzZXQnOiAnYm9vbCcgfSB9DQo+Pg0KPj4gICAg
IyMNCj4+ICAgICMgQGd1ZXN0LXNzaC1yZW1vdmUtYXV0aG9yaXplZC1rZXlzOg0KPj4gQEAgLTE2
MTcsOCArMTYxNiw4IEBADQo+PiAgICAjIFNpbmNlOiA1LjINCj4+ICAgICMjDQo+PiAgICB7ICdj
b21tYW5kJzogJ2d1ZXN0LXNzaC1yZW1vdmUtYXV0aG9yaXplZC1rZXlzJywNCj4+IC0gICdkYXRh
JzogeyAndXNlcm5hbWUnOiAnc3RyJywgJ2tleXMnOiBbJ3N0ciddIH0sDQo+PiAtICAnaWYnOiAn
Q09ORklHX1BPU0lYJyB9DQo+PiArICAnZGF0YSc6IHsgJ3VzZXJuYW1lJzogJ3N0cicsICdrZXlz
JzogWydzdHInXSB9IH0NCj4+DQo+PiAgICAjIw0KPj4gICAgIyBAR3Vlc3REaXNrU3RhdHM6DQo+
DQpIaSBQaGlsaXBwZSwgdGhhbmsgeW91IGZvciBnZXR0aW5nIGJhY2sgdG8gbWUgc28gcXVpY2ts
eS4gTG9va2luZyBhdCB0aGUgZ3JlcCB5b3UgZ2F2ZSBtZSBzZWVtcyB0byBjb25maXJtIHdoYXQg
SSB3YXMgc2F5aW5nIGlmIEkgYW0gbm90IG1pc3Rha2VuPyBJdCBsb29rcyBsaWtlIENPTkZJR19X
SU4zMiBhbmQgQ09ORklHX1BPU0lYIGlmIGNvbmRpdGlvbmFscyBhcmUgb25seSB1c2VkIHdoZW4g
eW91IG5lZWQgdG8gZW5hYmxlIGEgY29tbWFuZCBvbiBvbmUgb3BlcmF0aW5nIHN5c3RlbSBhbmQg
bm90IHRoZSBvdGhlci4gSSBkbyBiZWxpZXZlIHRoYXQgeW91ciBjb2RlIHNuaXBwZXQgaXMgY29y
cmVjdCBpdCBpcyBqdXN0IG92ZXJseSB2ZXJib3NlLiBUaGUgUUdBIGhhcyBib3RoIHdpbmRvd3Mg
YW5kIFNTSCBpbXBsZW1lbnRhdGlvbnMgYW5kIGxvb2tpbmcgYXQgdGhlIGd1ZXN0IGFnZW50IFFB
UEkgZmlsZSB3aGVuIGEgY29tbWFuZCBzdXBwb3J0cyBib3RoIFBPU0lYIGFuZCBXaW5kb3dzIHRo
ZSBpZiBnYXRlIGlzIHJlbW92ZWQuIEkgYW0gaGFwcHkgdG8gZGlzY3VzcyB0aGlzIGZ1cnRoZXIg
aWYgeW91IGhhdmUgbW9yZSBjb25jZXJucy4NCg==

