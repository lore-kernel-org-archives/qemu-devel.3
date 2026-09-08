Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB88C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7h-0000j3-4q; Tue, 08 Sep 2026 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7f-0000iC-7H
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7c-0008Ek-Ny
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Eh6is3514602; Tue, 8 Sep 2026 08:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=proofpoint20171006; bh=pf
 7LAbLqQe4AdAZzHV8kiRQO6pKKZhaf46AW2HLRt3I=; b=wAJM6slZMuxC7HuMbB
 r7o5RnIMO/HL/VTd2F4fj+bXzUN27yTYrO6ZxVy3PytszUoo2Jup/40/x/ssOtg9
 i/e/wWpN4sP8I9nOEe2H/LU3/oKRfvxgByWZJVfoDG5u2HozmJb9fmFGdZ97HlWw
 r51FpAPm30PG4ZEApHnA1HuL2uYE9Iw2KNVId8xRjxKvUipvNfX9vkJE7Hi4oNCu
 LpL4OqvhucziAz/iYAoQj0Qlt6rfC2JSF7xsZej3VDq8UlbMWV32EApnwgCP01MI
 mOFMePrdHi0H0Fg1P80dVqTR+WUHI/ekOHEhRLcsoIp1c8jbQ38wBER9NYd7wop1
 25nw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021081.outbound.protection.outlook.com [52.101.62.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ex0sq-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke4DM3JgkhbW0fYquJHyz77A/gxBFWK+xjyisE5PJvredVont77oUA9gIBbF7HUhRawlt25sRHWRRjC+HyjuZ4Kg02lyIznqwvMJg1+cEHD8EupKNb8D6Evk5ARgpnZYb1jHOcHE/NOV0G6A7+SaG+g27hjoMgVo4c8n/cCdOgpPgLRQPbf+dv+sfKImpBUHqD1DmM+GK8uKRVfef1Tmpi2Ud3N/QW/hFvWhwM3OxeNacTG+q2ZyFwoZJVti2inqu9PkBK7rfVG6M5kVwsFoktpRQpFV4rStZs9LdHZ+MiwvQmebYZHILXBldqIkeaUFe7T2q5HcY5g0Ph5YBD6OLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf7LAbLqQe4AdAZzHV8kiRQO6pKKZhaf46AW2HLRt3I=;
 b=B/uHpUWN5+96npmTMfYSJZw3ocwfUF4Oii3u4rNdSrNTnT7y9Y2tejVvKgzUaoCck5+n54y8EeceWdSf7OsLs/5xMl1dXoFB6n5GdWZNfTVUnVINr7qf6aN/2jiC3TdMnFwvZTP/m+DBPmZsipTf7yzG/c+F7fSJjpGlCT0y/NzPd1UIXdTF3vkMjKORHKRPRPVLlvAN9tLHtBtT97lEY3EiOyACzILzLKmUmG75Ih0H4tp5K7kOYwu20TuIAGbFFCmHmHvFI9Zd8YRvzg5jWfiYnV/YdhW4XZqgEL+7yTJfvS4pvUo8r7bIsqW4t7tTuYshPyIviaYcjVC+PCcGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf7LAbLqQe4AdAZzHV8kiRQO6pKKZhaf46AW2HLRt3I=;
 b=JatBIYVcJ0NjgPYDeA0FA4eqkqY21kSVdcjkjtIYv6n8VGMNi/Ih6/eDryAm6TQu25elA9KDBhsNZ4BfH9UGLOxU4Ljyqm1IH8W/gpxTK0E7vxEP2M4VvDfTyD7J70JdTe+fm96vGemIDas1/UiVXiv+xAN5wrZFhzKpyNQlCYBF/icvMATTeVuIgv0RShH3gV0g7SgmyJ7Tx3LXaBo1Ae3cjzLW8l6brBzCpaxmrccQAGmUZbKmTsCET/XLPOQ8X0tVj6u9Ak4V62cdy63zDvLIHZtM/0z2+kW1QFhW0sRgz7DUegN3XgJEQqmquc1C551E79tPzwDP4c2f7PmtCA==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by BN0PR02MB8064.namprd02.prod.outlook.com (2603:10b6:408:149::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:52:25 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:52:24 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH v2 0/4] hw/pci-bridge: Configurable apparent bandwidth for the
 PCIe topology
Thread-Topic: [PATCH v2 0/4] hw/pci-bridge: Configurable apparent bandwidth
 for the PCIe topology
Thread-Index: AQHdP6oKapOLgcSvfk2aImC9xmod6A==
Date: Tue, 8 Sep 2026 15:52:24 +0000
Message-ID: <20260908155223.164787-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|BN0PR02MB8064:EE_
x-ms-office365-filtering-correlation-id: 6f562a96-cfbd-4b66-7d2f-08df0dc12ce2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|38070700021|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: Ze/5ak/uwTxhXeD1A/8AishNAsKLQPQoXcpuFum4c9UfcydNUPIgDKdzSGPL3Ptz6PcPSPgtKRKdBqwG1rAqa/BwajXInOdwjzfdlRdH41a06UQ0fsuq95WrzlmzFyOC608Fo8qO7NoFSWv6VFiU21O16EYdc6bSkS8bHiwWQtzUqGuX+piESoQmDIb48USiWEBgIl0uR3/BXwD8H0TmtL1i0S6k69r3M6o19fbMvTAQsM9UCocNU0ZNPB9NWmQzGtXB2u4H/ASVlI1SRPgkS9NfXqp/qEQDiCCatTqJB7Q1pR5p+41ashmWTYOfqS6VUyNWcfEriwBTNu2L/pfR1Tt+fcpt0ObNyatupn8zILt1pdj0TQ2sZo2g1kHDs3kc5Lo82e16vXjXFRnYRmyibMgVeoIiin/TeVwWVB34Jj4hg4udOSEX+5XKBQWUVR/fDiBmiy8+X9nA87/84UVMzG4A3fJ7dzBG2Lani0n76XK3aANIOBqoNYE60wfD77ePaoFkqP4rLSmFUy7+bw0QT04WHLP8ud1tIWWMFy33BU+BmBQuc6iaqR2KVnnbqY7lx3o7nUjRoTckkKhBBub05N6WyfcbcbOWv162u3klS1aGXE/V+p98RotNHq2fwoqwdF3KcZhHcPp8Aw02Rqcxa6FRbmK6pdmcjcF8+SKsbdrf7M48+rsxq+Zx5DqnHDJ31dhXkt5IH3wKc4E3Ktw4yAIsNpOEToe/CwwSpZXYNi4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(38070700021)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hhUFo3RE1SekJBYWd1WEFZQVlqc0wyaTlNOVNpdFlaOGs1aC9tOGxKSXA4?=
 =?utf-8?B?WlVLSUdmMExXQWFVNnkzWnJ0ZXpMc2cyQjJjUlU1b3AyQTBBLzcya3doK3Zv?=
 =?utf-8?B?bUNjQXcrVTUreEhVWk9PMFhKQTVKaVV2dVIzYm1sRGNMOE5kdjUxN3N2MDB4?=
 =?utf-8?B?S0dZdGJzaW1PQ1p4OFZLaDJJM2pacUdPTUs0bkxuNGhEek9NVDhUYjZzYlNv?=
 =?utf-8?B?cDJEbTZIOU5VaGhMUG1SNzdIRVNvTC9XbUNHWU5NVGNuZXNvRFk0a3dUY1h0?=
 =?utf-8?B?WUlTV3BhUG0rbmVJSXQyU21ldjlDSmZ2UVVSUVRwT21wNSszdkVVSGwrSEpn?=
 =?utf-8?B?bVR6RGhWLzZZcGNvdHZtT3gxcmhpSTM3MzBOVXczRDBoYUdVVndEbDkxY0ZH?=
 =?utf-8?B?MVkzR3FKWEIxb2E0Z2J3TlVvSmgrTzllNGdSdEgxVnd6anBtNjk1a3ZFM2VZ?=
 =?utf-8?B?N2p1SGM4ZGNVdU1sQUxnb1RLT1U0bENEVXcxRzlZNmtUdlR0UE9WejRmQk1P?=
 =?utf-8?B?WW1Ebk0vRUhFSXd4ZnZDWGl2V3pnMmFWWWpIaEVpeHJ0QkhuS3dGdTBJb1Vs?=
 =?utf-8?B?cnZXUC8rUjcrSnJ3Y2lYNkkzaUJCQnVpeUhTdnM4YnRSZXEwVUtQV2tYMzBz?=
 =?utf-8?B?ZjZJSTN4UWVONVpuUzBCSmtPSm5TclVXNk1kYUY3WkxuSGZGYjFUS093cEhu?=
 =?utf-8?B?S002aS9rbEhkNElFTDhSMXdZK21uNmxOT3MyWS9LNnRTN0JrMTFkVkJINVha?=
 =?utf-8?B?Z1ZHa1g0YzVPcUxocFVVQitKekhqdENtazM2NGJPZlVwU0xNWWF0NlpqSms1?=
 =?utf-8?B?MmtET0QwR1F1U1ZVTDBuNlY2SVMwcjd1cmF3T0FLODczdWJBTHRDRHl3UGsr?=
 =?utf-8?B?QjcwcHBVRWNJdmM5cXU1bU45NXg1V2NpOXVMd05CMzNEWUFyVmZNSHNZTy9m?=
 =?utf-8?B?Z2UxZDRPT1JzRzBtV0hEZ3ZMRmlscnVvNXVRQlJMS1k1U1pudFZ2cms5Q2Va?=
 =?utf-8?B?dUdUVEtEVC9UaDVNRVVldTBDMXJKZ3RFbzBsazVzVWxoL0JtRHhERzZoSTRo?=
 =?utf-8?B?VXZpMmtLK1dNSDJQZWpxMU9RRUw1MVJiNVlLUHVld2hUaHc0ajZLdWE1ODF4?=
 =?utf-8?B?bFcvOE1ZbFZ2dzU1cVcycFd2Q3N5bzFZcndsY0pJTkdoQXBIN1BaTitVdlRp?=
 =?utf-8?B?TExMcFF3L3U2OUVNT3RCVWYxYUxKa1VoOW9CWVE4SUI3UWJXZEZlVWZNaEd2?=
 =?utf-8?B?VnNqWGIxOUFOSGJZUFJnWkFaSy90aWdiVFAwU2lRcFFHVHQrSHNRUDBwTW5L?=
 =?utf-8?B?QUgydG4xNmErSE9pdERJT0V0S1J4clRRUnVrQUc4clBMbW9LMktTSCtpM0dH?=
 =?utf-8?B?cHZPK3ZDdkdMKzRhK1pOVE9NaXg2eWZ2MmViN3dja0dDbjRqYlgwcUVZNFVu?=
 =?utf-8?B?WnhHZDByRUxsa0lndlRDMjRjRmsyOHF4N24xKzF4bmZ4bldjMXlXK0FPY2Np?=
 =?utf-8?B?cExwRVJBWnZUNGNoUU5EVngzSEtaOE1KN2pZNHJuWEVhcGVmTWxJZ25IcHBj?=
 =?utf-8?B?NUNSZXY4VVpBbUZ5SDhDak5lNXI3NkFUMm9IYTZBTlQ4UVpPTFg3TTBKZGxU?=
 =?utf-8?B?b1JRd2F0ekVYUndGWHkwcmZWUHdzWWRiV3d3WjVoQ1hEYTAvUWZOQTVIMHdm?=
 =?utf-8?B?RkdCTDlNMW1QYlZRVHhiNVdxeWQrNTJkNy91aXpUamdjS3p5bGtrRlE3eGU3?=
 =?utf-8?B?Rk14UFExc3BFNjNOWkhoa1F1MXZJM0UvRnZxcjZWOTAwQ0ducnpqcEZnVG9k?=
 =?utf-8?B?V3QzYWFRcXpVWlA5YXp5TnZtQXFhUnpLb1BEeXROb2pRNFBIZHhFYVJRYWdy?=
 =?utf-8?B?TVRrUWk0WUMwb2k0cktoMnNDQzAvMmh6MHNuYVU5THVmdDVFUmlPTjAwb1Q0?=
 =?utf-8?B?Vk9pblFuQ29JSUJMOU1HSXg3K3BtbThISnEwNEVzWGNHSkVFVU5zMmMzaTZw?=
 =?utf-8?B?WmhQdnFwUlJ2S2MxOHQydkdzOUViT0JMa3kvVmxNRG5HL3FlT3U3d1J6Y2xH?=
 =?utf-8?B?YjR3R1RMMU0rLzBFUlRDeXN3WEh5T3MxMVJNZ3hiYnMzYTRkbjVYa0tPZW5x?=
 =?utf-8?B?S3VZanEvY2VHMEhueDV2OU5iZkFReDR2NnJiS01ydXk0OThZTWFTN0xVTTFL?=
 =?utf-8?B?ZXlVNzF6R3d6a0VqdUdvUUNOMVB5eEcxbWEwQzlTeHFtS3lnTE5Xd2hIeUdi?=
 =?utf-8?B?M2FSR1NidGVmS0czZHJvTnZLOVBvUWs1OFZQSWZ0c3ZsMVlJWkh3cWtldXdM?=
 =?utf-8?B?WlZLUDF0YXZ0K1MrRVJEd21DYXB0dUtGM2QrRHQ0NUNSOEFzS0svTlUwcjVy?=
 =?utf-8?Q?kJWCq7qLicCa12Q8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65401BE5F07A014D9AA50AD07C1CA666@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z/+LXYdKCqeE/SOL3Rl4VpTK2BFP4ySaEELFy/S1kKXe9UcheGekbfmzGZpiFOtUaDwybn/bkiSKImK3JA/XGHfVbEzzS79O9gamlUejmIMGraukVRFlFeoR96t6IF5nkuU0Q5r1sRi9ZosSdPBYTvH+j6nIkqB64vCcMpx5kILDbxbmC53ojwBeRWKxtZ+1Gr56fJEL9yQ/tgnhh52Ei4A+h9j9mocNvjmQ50rwKRExaq4PgPGrkr/ke217lpEIbj7EHSPf/a89HDIutzs4CtBMeF3AfeQs942g1PkhsGfeNHUpJrlITt32g7OyHRZ1wbbwhtaUAWPJnjUQNARU8Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f562a96-cfbd-4b66-7d2f-08df0dc12ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 15:52:24.2232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5zUPbcwVUkK8AwL3kuPMTu/JBl70SanBJLAB+xj3sispPzVFYbMSoJAHmih+DXOooEDwwH7REYTGNdPvMeFwHCVoGKtd0RbvvwCHSWXooI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfX/sTlM4p6eBBi
 GsVHed7qxBYIayftK6XqIQT1pIwk/1wiEB4eXKkzCxDn8ajGn6dGMee6NsGuoAoJmQCUq1VWQ9l
 U2nW1jUopsUJJW63cfrd6JniiyqRHdNLkuiO8RLIPQIz0kdRGqmP2we1Sdm7GM4rK1Zn5tWlUwb
 0cx9kyllBFfy38KMia2beRnmsjc/TsiXFiM/Jhv4ZDcxzy9D95ecyfAORZ6vLI0G+uhRNn8YbTc
 8BRJU91AfvW7WMUincKRoHn64ZxNVDQH8NfPKkCZo49inXa6R5uf6Fa+PGtSERXOQAJZoayUd/e
 V0i8fGpFhKcwl5evqTt+dS9LPvgEmlZD/lzVHxzpzenEtCmYDbswGAUDU4YfZOWl7BTQfy6dqlS
 C7GBk1z3D3ZXGjpjK579KMznTlJgp6hQoNUIclZzxu6DAwi63PLXgsdPO6qun7OU0el9zBHW4i4
 RVqADAGxotiyrgieTqA==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa02f3c cx=c_pps
 a=7ywGlyDdJUFJDTdbuALIzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=Ikd4Dj_1AAAA:8
 a=pZpcXEuzcdaDib_rDisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -5_Gwg2P0B0gme9VRqSSK1XHwQYl8Rwj
X-Proofpoint-GUID: -5_Gwg2P0B0gme9VRqSSK1XHwQYl8Rwj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfX9Vt2+t7CYT/R
 XniierEttvMcZMIG3LzqU+VadIefTrfJEo4tf1W+aaLsdmX5ShO//ze//B3qBSyR9HnveVY5Ju0
 /QAAAy6CDP8kWZBScfcjdQsE1IcVpDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

V2hlbiBhIFZNIGhhcyBiZWVuIGFzc2lnbmVkIGEgbnVtYmVyIG9mIFBDSWUgZGV2aWNlcyBiZWhp
bmQgYSBjb21tb24KUENJZSBzd2l0Y2ggYW5kIHRoZSBWTSBpbnRlbmRzIHRvIHVzZSBwZWVyLXRv
LXBlZXIgKFAyUCkgdHJhbnNmZXJzCmJldHdlZW4gdGhlIGRldmljZXMsIGl0IGlzIHVzZWZ1bCB0
byBiZSBhYmxlIHRvIG1vcmUgcmVwb3J0IHRoZQphcHBhcmVudCBQQ0llIGJhbmR3aWR0aCBzbyBp
dCByZWZsZWN0cyB0aGUgcmVhbCBoYW5kd2lkdGggb2YgdGhlCnVuZGVybHlpbmcgaGFyZHdhcmUu
IFRoaXMgYWxsb3dzIHNvZnR3YXJlIGluIHRoZSBWTSAoc3VjaCBhcyBOQ0NMWzFdKQp0byBtYWtl
IGJldHRlciBkZWNpc2lvbnMgYWJvdXQgd2hldGhlciB0byB1c2UgUDJQIG9yIG5vdC4KClRoZSBl
eGlzdGluZyBlbXVsYXRlZCBQQ0llIHN3aXRjaCBpcyBhIHZpbnRhZ2UgVEkgWElPMzEzMCBhbmQg
b25seQpzdXBwb3J0IDIuNSBHVC9zIGFuZCB4MSwgc28gd2UgaW50cm9kdWNlcyBuZXcgZ2VuZXJp
YyB1cHN0cmVhbSBhbmQKZG93bnN0cmVhbSBwb3J0IGRldmljZXMgKHBjaWUtdXBzdHJlYW0tcG9y
dCBhbmQgcGNpZS1kb3duc3RyZWFtLXBvcnQpLAppbnNwaXJlZCBieSB0aGUgZXhpc3RpbmcgZ2Vu
ZXJpYyBwY2llLXJvb3QtcG9ydCBkZXZpY2UuCgpUaGUgZXhpc3RpbmcgZXhwZXJpbWVudGFsICJ4
LXNwZWVkIiBhbmQgIngtd2lkdGgiIG9wdGlvbnMgYXJlIG1hZGUKbm9uLWV4cGVyaW1lbnRhbCwg
YWxsb3dpbmcgdGhlIHBjaWUtcm9vdC1wb3J0IGFuZCBwY2llLWRvd25zdHJlYW0tcG9ydApjYXBh
YmlsaXRpZXMgdG8gYmUgY29uZmlndXJlZCB0byBtYXRjaCB0aGUgaGFyZHdhcmUuCgpUaGUgcGNp
ZS1yb290LXBvcnQgZGV2aWNlIGlzIHVwZGF0ZWQgdG8gZGVmYXVsdCB0byBhIEdlbjYgY2FwYWJs
ZQpkZXZpY2UuCgpGaW5hbGx5LCB3aGVyZSBhIHJvb3Qgb3IgdXBzdHJlYW0gcG9ydCdzIGJhbmR3
aWR0aCBoYXMgYmVlbiBsaW1pdGVkLAp3ZSBhbHNvIGVuc3VyZSB0aGUgb3RoZXIgZW5kIG9mIHRo
ZSBsaW5rIHJlcG9ydHMgdGhlIHNhbWUgbGluayBzdGF0dXMuCgpOb3RlIHRoYXQgdGhlIGRldmlj
ZSBJRHMgZm9yIHRoZSBuZXcgcG9ydCBkZXZpY2VzIGFyZSBjdXJyZW50bHkKcGxhY2Vob2xkZXJz
IGFuZCB3aWxsIG5lZWQgdG8gYmUgYWxsb2NhdGVkLgoKU29tZSBvcGVuIHF1ZXN0aW9uczoKCi0g
VGhlIGVyZ29ub21pY3Mgb2YgdGhlIHNwZWVkL3dpZHRoIG9wdGlvbnMgZG9lc24ndCBzZWVtIGdy
ZWF0IGFzCiAgdGhleSdyZSBlbnVtIHByb3BlcnRpZXMuIEluIHBhcnRpY3VsYXIsIDIuNSBHVC9z
IGlzIHJlcXVlc3RlZCB3aXRoCiAgdGhlIHN0cmluZyAiMl81Ii4gU2hvdWxkIHdlIGludHJvZHVj
ZSB0aGUgYWJpbGl0eSB0byBoYXZlCiAgZmxvYXRpbmctcG9pbnQgcHJvcGVydGllcz8gT3Igc2hv
dWxkIHRoZSB1bml0cyBmb3IgInNwZWVkIiBiZSBNVC9zCiAgKHJlbmFtaW5nIHRoZSBvcHRpb24g
dG8gInNwZWVkX210cyIpIGluc3RlYWQgYW5kIGJvdGggcHJvcGVydGllcwogIHNob3VsZCBiZSBp
bnRlZ2Vycz8KCi0gUENJZSA2LjAgcmVtb3ZlZCBzdXBwb3J0IGZvciB0aGUgeDMyIGxpbmsgd2lk
dGguIFNob3VsZCB0aGUgZ2VuZXJpYwogIHJvb3QgYW5kIGRvd25zdHJlYW0gcG9ydHMgZGVmYXVs
dCB0byA2NCBHVC9zIGFuZCB4MTYgaW5zdGVhZD8KCkRhdmlkCgpbMV0gaHR0cHM6Ly9kZXZlbG9w
ZXIubnZpZGlhLmNvbS9uY2NsCgpEYXZpZCBWcmFiZWwgKDQpOgogIGh3L3BjaS1icmlkZ2U6IEFk
ZCBnZW5lcmljIFBDSWUgc3dpdGNoIHVwc3RyZWFtIGFuZCBkb3duc3RyZWFtIHBvcnRzCiAgaHcv
cGNpLWJyaWRnZTogTWFrZSBzcGVlZCBhbmQgd2lkdGggZm9yIFBDSWUgcG9ydHMgbm9uLWV4cGVy
aW1lbnRhbAogIGh3L3BjaS1icmlkZ2U6IERlZmF1bHQgdGhlIGdlbmVyaWMgUENJZSByb290IHBv
cnQgYXMgR2VuNiBjYXBhYmxlCiAgaHcvcGNpOiBFbnN1cmUgUENJZSBsaW5rIHNwZWVkL3dpZHRo
IGlzIGNvbnNpc3RlbnQgYmV0d2VlbiBib3RoIGVuZHMKCiBkb2NzL3BjaWUudHh0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCiBody9wY2ktYnJpZGdlL2dlbl9wY2llX2Rv
d25zdHJlYW1fcG9ydC5jICAgIHwgMjA2ICsrKysrKysrKysrKysrKysrKysrCiBody9wY2ktYnJp
ZGdlL2dlbl9wY2llX3Jvb3RfcG9ydC5jICAgICAgICAgIHwgICA2ICstCiBody9wY2ktYnJpZGdl
L2dlbl9wY2llX3Vwc3RyZWFtX3BvcnQuYyAgICAgIHwgMTgyICsrKysrKysrKysrKysrKysrCiBo
dy9wY2ktYnJpZGdlL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgICAzICstCiBody9w
Y2kvcGNpZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI2ICsrLQogdGVzdHMv
ZnVuY3Rpb25hbC94ODZfNjQvbWVzb24uYnVpbGQgICAgICAgICB8ICAgMSArCiB0ZXN0cy9mdW5j
dGlvbmFsL3g4Nl82NC90ZXN0X3BjaWVfc3dpdGNoLnB5IHwgIDk4ICsrKysrKysrKysKIDggZmls
ZXMgY2hhbmdlZCwgNTE3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGh3L3BjaS1icmlkZ2UvZ2VuX3BjaWVfZG93bnN0cmVhbV9wb3J0LmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9wY2ktYnJpZGdlL2dlbl9wY2llX3Vwc3RyZWFtX3BvcnQuYwogY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwveDg2XzY0L3Rlc3RfcGNpZV9zd2l0Y2gu
cHkKCi0tIAoyLjQzLjAKCg==

