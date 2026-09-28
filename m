Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFF0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDDk-00014b-TC; Mon, 28 Sep 2026 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDj-000149-34
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDe-0002k7-78
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEflM01869208; Mon, 28 Sep 2026 08:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O6b14v4vHop7466fz+QxStpogsHwqTDpaKbLqBVVO
 xM=; b=dkS+ee6VIYkeyoLjx5XZ8FYjAGOh8WdHBhfKFXM9Wv7wUcDlnSklZ2ZhL
 bAM5N9LbWLCZ8/H5gW+/ruD+7ZB3/nk3Tls9OimP2xbmcfdlejxeKoWhqWImnHb+
 83nnzmesAEAebrRsz5aPv5FiRmFQ7Zhhq4bWcZYyqgwSYcOvTnj0lfdJqe8gbT6a
 9C3snJhOmDuskwMRI6G+t/nlbY/Nk46+OpzH64wugiQ4LHPX7aHPmXeD5HHvFwUP
 FfCOUfZoIFrkBKmZtvuAGTltX0KzCYotQEjtmm9k9G77/lo1YKPkx+4Fuj7LH8V4
 Ie2Ko7pBsubz1tXfxXk737aXUm/Dg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020126.outbound.protection.outlook.com [52.101.85.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxbk5kr4c-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha1uKATvvFY070IpGS5ptMGWbg4kb+l8rQRBYxoBDTQFVpeu5lS3qe8kYAq5aK1JYIXeDKrOD7ozgPY0gMVsGA1+UDP/tTe+8UEGso6nHmyWjOlTiGLkiX1cVv0GZgva4ynHgXITfJVS0laM/2cp70np1QkLpasWcOONparekl4X+cuzOILuhCBqebNbSevLOoCUfpzHFAmmhjITckg4cm2Q6F3ABbyRirVbEZ7eV0hfUxEkwnryHALOtwYjfrK0Rgb+mTsxHZaSKZlZJPsiy34370mFSKETSh2Bzhw38JSB0URv2/MPsjChxJiBr6LuKweAsBrNZrQKdJBu8lXR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6b14v4vHop7466fz+QxStpogsHwqTDpaKbLqBVVOxM=;
 b=R3Q6zKy2vCFP9SD1UlJUccXcDE5BaMxaAUNY0PxuCW1s9mWf10WpTD/BxBjdSqQI5VC9f3W3BjCJKYyrjWmTmzZIwqGsTCbs5jkhrYXOzxhIFeTxfVUKLizWaP81Py/9JadtZr00EN0n0Yx9zNOFwDWkeGpwLTFJSYMuhA90ZXmTAFFovViUFEfQaG/Mk/RowXiONLvv+t52PAufMQUX5Nww51XkL9tabDvx/3RorTT7GsXYWc1+ZcgkLluI+p5UU53WOmHVe4c7NVtbSLHxi9Lv8B0vGArhxaUQv+CjQGA7wdQW9Dmv2dcDv4g+Va2lj+u469eDZRDh9bZRtcoz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6b14v4vHop7466fz+QxStpogsHwqTDpaKbLqBVVOxM=;
 b=go8nQGIdo0i3xn81m5BeaHL0icctJ2DAFA+enRI10bb/fMGor1sc+QzTvpOR6m9q5b2wxhLdvP11meGgNbHA3AGrTFpuYSrKbLni/eRFGJAv8GPMs/lCVD+Ze/mTuiw/dJh3qCmKIgpiEQI8DQG0I+FgyZb0XgutpAkkcVNkj/gXT1q+hi6nlI6BAvapyHHbwMGjxI2jfyGL6FisqrEby5t2OKZ8N6bMPKmyJw4/m8YOtKha+dZIXweAq8FUR2741zdITBwzpFPI62FIX1RUYWIXb89aEKzoLfyomXlGrRl3V6xWRtcJIdbWWGNHrbQhcfUgpo6G8nWtwaEArX2A7Q==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by PH0PR02MB7301.namprd02.prod.outlook.com (2603:10b6:510:1b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:24:34 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:24:34 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 1/4] hw/pci-bridge: Add generic PCIe switch upstream and
 downstream ports
Thread-Topic: [PATCH v3 1/4] hw/pci-bridge: Add generic PCIe switch upstream
 and downstream ports
Thread-Index: AQHdT112ZaIgEnSEtkyeUVlOP5Qh1g==
Date: Mon, 28 Sep 2026 15:24:33 +0000
Message-ID: <20260928152431.310363-2-david.vrabel@nutanix.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
In-Reply-To: <20260928152431.310363-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|PH0PR02MB7301:EE_
x-ms-office365-filtering-correlation-id: 1fde72b9-9adf-4443-70ab-08df1d749994
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|3023799007|260925021311599003|260925022911599003|260925021911599003|56012099006|10067099003|5023799004|38070700021|18002099003|22082099003|13003099007;
x-microsoft-antispam-message-info: BvOewUiRIfkD9UDNQeL78VZqA+XtOfClCPeuh5tRE231lw+bXwynSgZmlpdYvDDbNM4hSnLeER9/Dz0X8w8le7bEhJD2m/t/3OmJebZX48HE2b7KbjTqWUGP9O7fSS/PhHyuGcSgNBMj6YesMBUgq93TjIe6jg4XLFeoxAIEutmVWGc4wiTCCQlZG7q4yFFBTq6h+3shs+AkA2oaoJQ3PnhKX6JZatwmcGJ2hX1HyuD7LFdZB5OkrNMKeVmvZmPoH5I9P8aPuxZ9rmn5wgXeRk6WZmTxK9277bNUTAFTmdDn3+MKfDBxAOp7BcJQkUCn1rzdU+e/zOqUhbIx9AFA1n5FSqFnKH/+6MaST7W84UOHn3rmu0KoH58iKgDaVZbv5Z53OBK2qR++5yG3mSpy1E8S6IEOXOc/jJn/kl4WIP8RAOORBvhN9QwZXFrf/LZp+YQgSYlZpFZmFCAKziWwKtGiFtcBZ9Kv07xHfNIVgXCL9VfGb480X5LDMebDRuDXrbgcRRwxWFYQUWzEYqkVDO8pOPv1FXjHALEMBH6yH3PdKqxMAANkW14fal7EKzpSywJG6CVzfVvfE06Hp0onjvS5GsZag8xYGgAlRTdj2TodElP8yAn/bvy57hsyyaDg8ecSamnMySLBTiRmv33r1hrK1pdPPSW0XoOPkcyAV2oKZ0cbSbYLDqX/P02Ta25B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(10067099003)(5023799004)(38070700021)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xqWbXVHeXdgc4AcijUFjsgquDnRPVII8C7LiWXX2TRPuRBKJfSdEIvb+/L?=
 =?iso-8859-1?Q?xrVHJr+6hNurmBHc5WWxCa+fngHtQNKX0dTuFiFT5CgzlLwGn+inN8zmn3?=
 =?iso-8859-1?Q?wwpLNoJYUwERwBwu45XKVL1ypBw8p19KI5ltBnGamzY0k/hoCnnV98chyb?=
 =?iso-8859-1?Q?eZsOSFUYrr0dZ+NtNTHQGLUrTVjwyfh0qLeh1qAn+Xz6FUPSlGhKqBbU18?=
 =?iso-8859-1?Q?ya7TgrfNfbG9R5whumFiCX6ZwY6t7bpi2tj/fBgm3OpWioWOByd2drRbj9?=
 =?iso-8859-1?Q?XwMQsjMpMs3SgtegZSL4EdBbT3fHy2A1zQpJr4NJsyJg8KBMIXpyWl39ui?=
 =?iso-8859-1?Q?em2aM0O95EJmZ6SK3nvI7yKq0EU+1jePF9D78/1UenLVaQEAZMfVTl9XGz?=
 =?iso-8859-1?Q?51vo3kE3+xD758wz8AiC8xDCylLETneVdsqtCc+Qn/wh0VVw4ogWirvY1L?=
 =?iso-8859-1?Q?z7v0So9rQr00h3uqrxhjpt/HkCPdsO7v3DRfAGyAfOBHFFZdJTaBCYqLW5?=
 =?iso-8859-1?Q?XFRfVpUVov/5OkOlbTeDCZkPGfhpUU30hNSQ2gZ3L+6XrgYXxO8c3hpW82?=
 =?iso-8859-1?Q?SQqKmO7SCcfaJ19tCer85iVGNjmp9KhE0wZZuv/2yWmzbJlsnl9a9Gjm3d?=
 =?iso-8859-1?Q?ahzHYtrH91wb8MDCpJhAE6rhO6JaqW2k+fpccwEGywUwexqNgMZ4HzZ1J8?=
 =?iso-8859-1?Q?cmho6owHpbTAPKVEbvgA0UJYWhgKNjxoHVpnpDXPuaPd/in53e5qOp47dZ?=
 =?iso-8859-1?Q?OSKGSBcstDq5gh6WNwnqS4myfeDyYvQ5gnwQnwqiC+n0ZWHY+qHR1acyII?=
 =?iso-8859-1?Q?+DgTxE9hNHHrwIZwTiZnJMTTbucbD8seBwzsfbPcDnYKQ3EDLxpjHnJoJp?=
 =?iso-8859-1?Q?AGBKYDzXT0zpHJrOjNIv2K8l5cPTWBeKks+xqogAr47kHwaZN7rhnprBp7?=
 =?iso-8859-1?Q?5aTit0IMR6VbHqs3xUCnBJL5iHbovKPpOg1fT+YpwdutLFqeXD7axRzuif?=
 =?iso-8859-1?Q?95Xb3GHFQLfzY93SlU/juHgiCr9FfDcUOTsyIu1DpwJvgJt0Ji7VuKFNEO?=
 =?iso-8859-1?Q?qGjojU0vCv6a9diurSJqfhFaYAtn7Vp/NcQj8vIlbUp8p9rcFuDVN233Fl?=
 =?iso-8859-1?Q?+KqD13mbbzouVE/yZKHaM5eD3CrfuEK3Xy2q1PZ9ZF1hZg3w8TrioFKEjB?=
 =?iso-8859-1?Q?y7/AJrpdvVSiYfp9lGVA4dQVkLp5tV8Ds0lMpg/MqB7ww9HJGroyy7WCiF?=
 =?iso-8859-1?Q?2+y/RcrlvMVV/Ucuf8udJPhc3Iic7NdzMnzCtAjqTKkxcXvxGqww5pNuff?=
 =?iso-8859-1?Q?lKhNssH6Ftqi7r9gBhLqsZGq36r7xB2VAizFkfJr0gRszYB30rH1iXjz4p?=
 =?iso-8859-1?Q?5rRxHjls/h6ZvGAqbjlR3TKSZMJAy97eIBXbhDTYmmqoXuUE7oi+Zczp1+?=
 =?iso-8859-1?Q?xkx+2pxwtYC0oiw7pnQxhuyfVhoY/rYvpwZCclK9PIyH+b57InYRWmgoAV?=
 =?iso-8859-1?Q?C7W5mldUQBXbstEB+g/ElN788WLRhSLFjnt2HAbmkaxaZy6JUF/tLLrN+Z?=
 =?iso-8859-1?Q?xvd+b3/LjwhWYq5RTya8lUwlbCPjvoWSlI85SqS3uei2BziDtrb7WsrJO+?=
 =?iso-8859-1?Q?mZW5DSvEZZCYB/BgUEh16UrM2TsGsi8LRnBLyTTXbnZwJPLWL3We5Z/jV8?=
 =?iso-8859-1?Q?ppFftbfpFpZKskM29kuJhSkiKbqyVKXKQnKe6ayB5ndPPrZ7APj8t41mZD?=
 =?iso-8859-1?Q?n/7jLsTHpuRfNkB21bHJmhYfYmgE1VBSsD0wOn0toxMCQ1nCCnP7oJcYEe?=
 =?iso-8859-1?Q?NZREmWfPpOo8sTqqzR44G874Si0RoIE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DrvLQDVvfY42sdJ2LDyJm7F3WLzlZM80cjjs+VLoFndx8Hcr/sStPaUY/l6CyY0A635F3dCZND7Rlv1m3Zs4eBxlNykq5FWoJT4T/sNHt3lBU4y4Tq6UevT768LNeNl2EcYT5zNR8Jm5W6GBdtUlHN+TEDYMfuNpe9cK37joDuXPx+KTL1k2hxH/VRHhGvWcX7eas1M/RE2yHOw2Ktq6TN9I7HuRHFwy4V2NerYdRnqEXIpDi+c3wIskNYRjgqBDYocT0LZt4OUpJkicU4nsMFMxBn4FclVSojY+gTPMD5Hbb+XRajsi6vioMMXKD/jp6RrmE89mJ/LDJhBY0tOvPA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fde72b9-9adf-4443-70ab-08df1d749994
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:24:33.2675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gN8bGkZDrLUHDW+GWOhOKcPkF/ncx/kWY9lJrbLCv190xpU5hp2Oqe+1579KK/X3yaQHG18Vd1qd48CS453Mbzcq5OOYjTQxhyXKHt7Quf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7301
X-Authority-Analysis: v=2.4 cv=T6EZ3PKQ c=1 sm=1 tr=0 ts=6aba86b6 cx=c_pps
 a=w1Ugl8llyohtshnQLMHy5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=vTr9H3xdAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=59scvrWWz1I71DQtTbwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: oE-R4Els6vni5W5_2VLUBtTJWraFVA49
X-Proofpoint-ORIG-GUID: oE-R4Els6vni5W5_2VLUBtTJWraFVA49
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX9sbfxIimcuey
 Ln0O9bdVwIZIMkHEOkFlfoJ22xHkIo/IW8z2y93LTYg5HE3tJDhQwbvHNsuRW350U/WBFaJehmL
 rKgpox4tngnqyROjIryhq9Ehk3bMChM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX8HA126aVOcWT
 HQLCugrR0tlCAQbPqHTqhbPUTj122KPPiqhwtlDuuxoF8mN4DAC1/CMT496WJIhkaF4BHTkjRH2
 Lu6quuB1SQJRk62FL8YctbD8Ooa7bHi78txVSJwq9sNQX0AuZd4pyblUbqUb9ZqHcT1aHsKL3hF
 HCbjPA7YJdkGh7Yx3W/yPQ/wVbT/FgIAu/8mkcxgvNcgOQ2uSCrFOkWosHyodOlcMoQgWBuXs+5
 dA5Xjzzbtf8e9pjRB5wezGEzLHsK39BVZJZA9mlms1GruN4QkEMWmYyk4864hXebZWxYskELLdE
 oD4uK97We4RtcPA/hiMhKqtEwza5mUwIEQQ4wwEM6dCdarxXPjWlu62lzq6Sk3fPaeAVJ9G8vPU
 x3r/XoEexK/Y/24o6/pd1kQ3lKZ3RyrcAX3EKqbeWCP0zkvtXyuBUDVleaBy05ko1NjscdWx/4K
 Kn9GDm0uHJ2xH6V7fzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

The TI XIO3130 PCIe switch is a vintage Gen1 device, so we add generic=0A=
PCIe upstream and downstream port devices that are Gen6.=0A=
=0A=
In guests with pairs of passthrough PCIe devices (e.g, a GPU+NIC pair)=0A=
often need to place the devices behind a common (emulated) PCIe switch=0A=
so in-guest software (such as NCCL) can correctly determine that P2P=0A=
transactions between the devices is possible.=0A=
=0A=
NCCL also needs to be able to determine the available PCIe=0A=
bandwidth. If such a guest sees the TI XIO3130 PCIe switch, then it=0A=
incorrectly calculates only 2.5 GT/s and x1 is available, but the real=0A=
hardware might be 32 GT/s and x16.=0A=
=0A=
Instead of enhancing the existing switch and claiming it is more=0A=
capable than the real hardware we add additional generic PCIe upstream=0A=
and downstream port devices, which matches the existing generic PCIe=0A=
root port device.=0A=
=0A=
The speed and width of the ports are configurable.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
Cc: Gerd Hoffmann <kraxel@redhat.com>=0A=
---=0A=
 docs/pcie.txt                               |   6 +-=0A=
 docs/specs/pci-ids.rst                      |   4 +=0A=
 hw/pci-bridge/gen_pcie_downstream_port.c    | 202 ++++++++++++++++++++=0A=
 hw/pci-bridge/gen_pcie_upstream_port.c      | 177 +++++++++++++++++=0A=
 hw/pci-bridge/meson.build                   |   3 +-=0A=
 include/hw/pci/pci.h                        |   2 +=0A=
 tests/functional/x86_64/meson.build         |   1 +=0A=
 tests/functional/x86_64/test_pcie_switch.py |  98 ++++++++++=0A=
 8 files changed, 489 insertions(+), 4 deletions(-)=0A=
 create mode 100644 hw/pci-bridge/gen_pcie_downstream_port.c=0A=
 create mode 100644 hw/pci-bridge/gen_pcie_upstream_port.c=0A=
 create mode 100755 tests/functional/x86_64/test_pcie_switch.py=0A=
=0A=
diff --git a/docs/pcie.txt b/docs/pcie.txt=0A=
index df49178311..f12a9daaad 100644=0A=
--- a/docs/pcie.txt=0A=
+++ b/docs/pcie.txt=0A=
@@ -85,7 +85,7 @@ number of PCI Express Root Ports per PCI Express Root Bus=
 is 256.=0A=
 =0A=
 Prefer grouping PCI Express Root Ports into multi-function devices=0A=
 to keep a simple flat hierarchy that is enough for most scenarios.=0A=
-Only use PCI Express Switches (x3130-upstream, xio3130-downstream)=0A=
+Only use PCI Express Switches (pcie-upstream-port, pcie-downstream-port)=
=0A=
 if there is no more room for PCI Express Root Ports.=0A=
 Please see section 4. for further justifications.=0A=
 =0A=
@@ -120,8 +120,8 @@ Plug only PCI Express devices into PCI Express Ports.=
=0A=
       -device pcie-root-port,id=3Droot_port3,chassis=3Dx2,addr=3Dz.2[,slot=
=3Dy2][,bus=3Dpcie.0] \=0A=
 2.2.3 Plugging a PCI Express device into a Switch:=0A=
       -device pcie-root-port,id=3Droot_port1,chassis=3Dx,slot=3Dy[,bus=3Dp=
cie.0][,addr=3Dz]  \=0A=
-      -device x3130-upstream,id=3Dupstream_port1,bus=3Droot_port1[,addr=3D=
x]          \=0A=
-      -device xio3130-downstream,id=3Ddownstream_port1,bus=3Dupstream_port=
1,chassis=3Dx1,slot=3Dy1[,addr=3Dz1]] \=0A=
+      -device pcie-upstream-port,id=3Dupstream_port1,bus=3Droot_port1[,add=
r=3Dx]          \=0A=
+      -device pcie-downstream-port,id=3Ddownstream_port1,bus=3Dupstream_po=
rt1,chassis=3Dx1,slot=3Dy1[,addr=3Dz1]] \=0A=
       -device <dev>,bus=3Ddownstream_port1=0A=
 =0A=
 Notes:=0A=
diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst=0A=
index 261b0f359f..60cb0f7db6 100644=0A=
--- a/docs/specs/pci-ids.rst=0A=
+++ b/docs/specs/pci-ids.rst=0A=
@@ -100,6 +100,10 @@ PCI devices (other than virtio):=0A=
   PCI UFS device (``-device ufs``)=0A=
 1b36:0014=0A=
   PCI RISC-V IOMMU device=0A=
+1b36:0015=0A=
+  PCIe Upstream Switch Port (``-device pcie-upstream-port``)=0A=
+1b36:0016=0A=
+  PCIe Downstream Switch Port (``-device pcie-downstream-port``)=0A=
 =0A=
 All these devices are documented in :doc:`index`.=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_p=
cie_downstream_port.c=0A=
new file mode 100644=0A=
index 0000000000..d9c182e881=0A=
--- /dev/null=0A=
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
@@ -0,0 +1,202 @@=0A=
+/*=0A=
+ * Generic PCI Express Downstream Port emulation=0A=
+ *=0A=
+ * Copyright (C) 2026 Nutanix, Inc.=0A=
+ *=0A=
+ * Derived from gen_pcie_root_port.c:=0A=
+ *   Copyright (C) 2017 Red Hat Inc=0A=
+ *=0A=
+ * Derived from xio3130_downstream.c:=0A=
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>=0A=
+ *                       VA Linux Systems Japan K.K.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "hw/pci/msix.h"=0A=
+#include "hw/pci/pcie.h"=0A=
+#include "hw/pci/pcie_port.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_GEN_PCIE_DOWNSTREAM_PORT            "pcie-downstream-port"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEDownstreamPort, GEN_PCIE_DOWNSTREAM_PORT=
)=0A=
+=0A=
+struct GenPCIEDownstreamPort {=0A=
+    PCIESlot parent_obj;=0A=
+};=0A=
+=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET      0x100=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET \=0A=
+    (GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VECTOR  1=0A=
+=0A=
+=0A=
+static int gen_downstream_interrupts_init(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    int rc;=0A=
+=0A=
+    rc =3D msix_init_exclusive_bar(d, GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VEC=
TOR,=0A=
+                                 0, errp);=0A=
+    if (rc < 0) {=0A=
+        assert(rc =3D=3D -ENOTSUP);=0A=
+    } else {=0A=
+        msix_vector_use(d, 0);=0A=
+    }=0A=
+=0A=
+    return rc;=0A=
+}=0A=
+=0A=
+static void gen_downstream_interrupts_uninit(PCIDevice *d)=0A=
+{=0A=
+    msix_uninit_exclusive_bar(d);=0A=
+}=0A=
+=0A=
+static void gen_downstream_write_config(PCIDevice *d, uint32_t address,=0A=
+                                        uint32_t val, int len)=0A=
+{=0A=
+    uint16_t slt_ctl, slt_sta;=0A=
+=0A=
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);=0A=
+    pci_bridge_write_config(d, address, val, len);=0A=
+    pcie_cap_flr_write_config(d, address, val, len);=0A=
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);=0A=
+    pcie_aer_write_config(d, address, val, len);=0A=
+}=0A=
+=0A=
+static void gen_downstream_reset(DeviceState *qdev)=0A=
+{=0A=
+    PCIDevice *d =3D PCI_DEVICE(qdev);=0A=
+=0A=
+    pcie_cap_deverr_reset(d);=0A=
+    pcie_cap_slot_reset(d);=0A=
+    pcie_cap_arifwd_reset(d);=0A=
+    pci_bridge_reset(qdev);=0A=
+}=0A=
+=0A=
+static void gen_downstream_realize(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    PCIEPort *p =3D PCIE_PORT(d);=0A=
+    PCIESlot *s =3D PCIE_SLOT(d);=0A=
+    int rc;=0A=
+=0A=
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);=0A=
+    pcie_port_init_reg(d);=0A=
+=0A=
+    rc =3D gen_downstream_interrupts_init(d, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_bridge;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_cap_init(d, 0x90, PCI_EXP_TYPE_DOWNSTREAM, p->port, errp);=
=0A=
+    if (rc < 0) {=0A=
+        goto err_int;=0A=
+    }=0A=
+    pcie_cap_flr_init(d);=0A=
+    pcie_cap_deverr_init(d);=0A=
+    pcie_cap_slot_init(d, s);=0A=
+    pcie_cap_arifwd_init(d);=0A=
+=0A=
+    pcie_chassis_create(s->chassis);=0A=
+    rc =3D pcie_chassis_add_slot(s);=0A=
+    if (rc < 0) {=0A=
+        error_setg(errp, "Can't add chassis slot, error %d", rc);=0A=
+        goto err_cap;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_DOWNSTREAM_PORT_AER_OFFS=
ET,=0A=
+                       PCI_ERR_SIZEOF, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_chassis;=0A=
+    }=0A=
+=0A=
+    pcie_acs_init(d, GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET);=0A=
+=0A=
+    return;=0A=
+=0A=
+err_chassis:=0A=
+    pcie_chassis_del_slot(s);=0A=
+err_cap:=0A=
+    pcie_cap_exit(d);=0A=
+err_int:=0A=
+    gen_downstream_interrupts_uninit(d);=0A=
+err_bridge:=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static void gen_downstream_exitfn(PCIDevice *d)=0A=
+{=0A=
+    PCIESlot *s =3D PCIE_SLOT(d);=0A=
+=0A=
+    pcie_aer_exit(d);=0A=
+    pcie_chassis_del_slot(s);=0A=
+    pcie_cap_exit(d);=0A=
+    gen_downstream_interrupts_uninit(d);=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_gen_pcie_downstream_port =3D {=0A=
+    .name =3D "pcie-downstream-port",=0A=
+    .priority =3D MIG_PRI_PCI_BUS,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .post_load =3D pcie_cap_slot_post_load,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),=0A=
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,=0A=
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),=0A=
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,=0A=
+                     GenPCIEDownstreamPort),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static const Property gen_pcie_downstream_port_props[] =3D {=0A=
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,=0A=
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+                                width, PCIE_LINK_WIDTH_32),=0A=
+};=0A=
+=0A=
+static void gen_pcie_downstream_port_class_init(ObjectClass *klass,=0A=
+                                                const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+=0A=
+    k->config_write =3D gen_downstream_write_config;=0A=
+    k->realize =3D gen_downstream_realize;=0A=
+    k->exit =3D gen_downstream_exitfn;=0A=
+    k->vendor_id =3D PCI_VENDOR_ID_REDHAT;=0A=
+    k->device_id =3D PCI_DEVICE_ID_REDHAT_PCIE_DSP;=0A=
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);=0A=
+    dc->desc =3D "PCI Express Downstream Port";=0A=
+    device_class_set_legacy_reset(dc, gen_downstream_reset);=0A=
+    dc->vmsd =3D &vmstate_gen_pcie_downstream_port;=0A=
+    device_class_set_props(dc, gen_pcie_downstream_port_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo gen_pcie_downstream_port_info =3D {=0A=
+    .name          =3D TYPE_GEN_PCIE_DOWNSTREAM_PORT,=0A=
+    .parent        =3D TYPE_PCIE_SLOT,=0A=
+    .instance_size =3D sizeof(GenPCIEDownstreamPort),=0A=
+    .class_init    =3D gen_pcie_downstream_port_class_init,=0A=
+    .interfaces =3D (const InterfaceInfo[]) {=0A=
+        { INTERFACE_PCIE_DEVICE },=0A=
+        { }=0A=
+    },=0A=
+};=0A=
+=0A=
+static void gen_pcie_downstream_port_register_types(void)=0A=
+{=0A=
+    type_register_static(&gen_pcie_downstream_port_info);=0A=
+}=0A=
+=0A=
+type_init(gen_pcie_downstream_port_register_types)=0A=
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pci=
e_upstream_port.c=0A=
new file mode 100644=0A=
index 0000000000..e86eff099f=0A=
--- /dev/null=0A=
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
@@ -0,0 +1,177 @@=0A=
+/*=0A=
+ * Generic PCI Express Upstream Port emulation=0A=
+ *=0A=
+ * Copyright (C) 2026 Nutanix, Inc.=0A=
+ *=0A=
+ * Derived from gen_pcie_root_port.c:=0A=
+ *   Copyright (C) 2017 Red Hat Inc=0A=
+ *=0A=
+ * Derived from xio3130_upstream.c:=0A=
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>=0A=
+ *                       VA Linux Systems Japan K.K.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "hw/pci/msix.h"=0A=
+#include "hw/pci/pcie.h"=0A=
+#include "hw/pci/pcie_port.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_GEN_PCIE_UPSTREAM_PORT              "pcie-upstream-port"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEUpstreamPort, GEN_PCIE_UPSTREAM_PORT)=0A=
+=0A=
+struct GenPCIEUpstreamPort {=0A=
+    PCIEPort parent_obj;=0A=
+=0A=
+    PCIExpLinkSpeed speed;=0A=
+    PCIExpLinkWidth width;=0A=
+};=0A=
+=0A=
+#define GEN_PCIE_UPSTREAM_PORT_AER_OFFSET        0x100=0A=
+#define GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTOR    1=0A=
+=0A=
+static int gen_upstream_interrupts_init(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    int rc;=0A=
+=0A=
+    rc =3D msix_init_exclusive_bar(d, GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTO=
R,=0A=
+                                 0, errp);=0A=
+    if (rc < 0) {=0A=
+        assert(rc =3D=3D -ENOTSUP);=0A=
+    } else {=0A=
+        msix_vector_use(d, 0);=0A=
+    }=0A=
+=0A=
+    return rc;=0A=
+}=0A=
+=0A=
+static void gen_upstream_interrupts_uninit(PCIDevice *d)=0A=
+{=0A=
+    msix_uninit_exclusive_bar(d);=0A=
+}=0A=
+=0A=
+static void gen_upstream_write_config(PCIDevice *d, uint32_t address,=0A=
+                                      uint32_t val, int len)=0A=
+{=0A=
+    pci_bridge_write_config(d, address, val, len);=0A=
+    pcie_cap_flr_write_config(d, address, val, len);=0A=
+    pcie_aer_write_config(d, address, val, len);=0A=
+}=0A=
+=0A=
+static void gen_upstream_reset(DeviceState *qdev)=0A=
+{=0A=
+    PCIDevice *d =3D PCI_DEVICE(qdev);=0A=
+    GenPCIEUpstreamPort *usp =3D GEN_PCIE_UPSTREAM_PORT(d);=0A=
+=0A=
+    pci_bridge_reset(qdev);=0A=
+    pcie_cap_deverr_reset(d);=0A=
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, false);=0A=
+}=0A=
+=0A=
+static void gen_upstream_realize(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    PCIEPort *p =3D PCIE_PORT(d);=0A=
+    int rc;=0A=
+=0A=
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);=0A=
+    pcie_port_init_reg(d);=0A=
+=0A=
+    rc =3D gen_upstream_interrupts_init(d, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_bridge;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_cap_init(d, 0x90, PCI_EXP_TYPE_UPSTREAM, p->port, errp);=
=0A=
+    if (rc < 0) {=0A=
+        goto err_int;=0A=
+    }=0A=
+    pcie_cap_flr_init(d);=0A=
+    pcie_cap_deverr_init(d);=0A=
+=0A=
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_UPSTREAM_PORT_AER_OFFSET=
,=0A=
+                       PCI_ERR_SIZEOF, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_cap;=0A=
+    }=0A=
+=0A=
+    return;=0A=
+=0A=
+err_cap:=0A=
+    pcie_cap_exit(d);=0A=
+err_int:=0A=
+    gen_upstream_interrupts_uninit(d);=0A=
+err_bridge:=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static void gen_upstream_exitfn(PCIDevice *d)=0A=
+{=0A=
+    pcie_aer_exit(d);=0A=
+    pcie_cap_exit(d);=0A=
+    gen_upstream_interrupts_uninit(d);=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_gen_pcie_upstream_port =3D {=0A=
+    .name =3D "pcie-upstream-port",=0A=
+    .priority =3D MIG_PRI_PCI_BUS,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),=0A=
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,=0A=
+                       vmstate_pcie_aer_log, PCIEAERLog),=0A=
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj, GenPCIEUpstreamPort=
),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static const Property gen_pcie_upstream_port_props[] =3D {=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,=0A=
+                                width, PCIE_LINK_WIDTH_32),=0A=
+};=0A=
+=0A=
+static void gen_pcie_upstream_port_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+=0A=
+    k->config_write =3D gen_upstream_write_config;=0A=
+    k->realize =3D gen_upstream_realize;=0A=
+    k->exit =3D gen_upstream_exitfn;=0A=
+    k->vendor_id =3D PCI_VENDOR_ID_REDHAT;=0A=
+    k->device_id =3D PCI_DEVICE_ID_REDHAT_PCIE_USP;=0A=
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);=0A=
+    dc->desc =3D "PCI Express Upstream Port";=0A=
+    device_class_set_legacy_reset(dc, gen_upstream_reset);=0A=
+    dc->vmsd =3D &vmstate_gen_pcie_upstream_port;=0A=
+    device_class_set_props(dc, gen_pcie_upstream_port_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo gen_pcie_upstream_port_info =3D {=0A=
+    .name          =3D TYPE_GEN_PCIE_UPSTREAM_PORT,=0A=
+    .parent        =3D TYPE_PCIE_PORT,=0A=
+    .instance_size =3D sizeof(GenPCIEUpstreamPort),=0A=
+    .class_init    =3D gen_pcie_upstream_port_class_init,=0A=
+    .interfaces =3D (const InterfaceInfo[]) {=0A=
+        { INTERFACE_PCIE_DEVICE },=0A=
+        { }=0A=
+    },=0A=
+};=0A=
+=0A=
+static void gen_pcie_upstream_port_register_types(void)=0A=
+{=0A=
+    type_register_static(&gen_pcie_upstream_port_info);=0A=
+}=0A=
+=0A=
+type_init(gen_pcie_upstream_port_register_types)=0A=
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build=0A=
index 2e0eb0d233..fd0ad188bc 100644=0A=
--- a/hw/pci-bridge/meson.build=0A=
+++ b/hw/pci-bridge/meson.build=0A=
@@ -2,7 +2,8 @@ pci_ss =3D ss.source_set()=0A=
 pci_ss.add(when: 'CONFIG_PCI_BRIDGE', if_true: files('pci_bridge_dev.c'))=
=0A=
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))=0A=
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))=0A=
-pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'g=
en_pcie_root_port.c'))=0A=
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'g=
en_pcie_root_port.c',=0A=
+                                                    'gen_pcie_upstream_por=
t.c', 'gen_pcie_downstream_port.c'))=0A=
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge=
.c'))=0A=
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),=0A=
                                if_false: files('pci_expander_bridge_stubs.=
c'))=0A=
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h=0A=
index f2448e941a..6520886855 100644=0A=
--- a/include/hw/pci/pci.h=0A=
+++ b/include/hw/pci/pci.h=0A=
@@ -121,6 +121,8 @@ extern bool pci_available;=0A=
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012=0A=
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013=0A=
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014=0A=
+#define PCI_DEVICE_ID_REDHAT_PCIE_USP    0x0015=0A=
+#define PCI_DEVICE_ID_REDHAT_PCIE_DSP    0x0016=0A=
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100=0A=
 =0A=
 #define FMT_PCIBUS                      PRIx64=0A=
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/=
meson.build=0A=
index 0353b2af8e..0ce49764a2 100644=0A=
--- a/tests/functional/x86_64/meson.build=0A=
+++ b/tests/functional/x86_64/meson.build=0A=
@@ -43,6 +43,7 @@ tests_x86_64_system_thorough =3D [=0A=
   'multiprocess',=0A=
   'netdev_ethtool',=0A=
   'nvme_migration',=0A=
+  'pcie_switch',=0A=
   'replay',=0A=
   'reverse_debug',=0A=
   'tuxrun',=0A=
diff --git a/tests/functional/x86_64/test_pcie_switch.py b/tests/functional=
/x86_64/test_pcie_switch.py=0A=
new file mode 100755=0A=
index 0000000000..7088b85059=0A=
--- /dev/null=0A=
+++ b/tests/functional/x86_64/test_pcie_switch.py=0A=
@@ -0,0 +1,98 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test for generic PCIe switch upstream and downstream ports=0A=
+#=0A=
+# Copyright (C) 2026 Nutanix, Inc.=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pa=
ttern=0A=
+=0A=
+=0A=
+class PCIeSwitchPort(LinuxKernelTest):=0A=
+=0A=
+    timeout =3D 120=0A=
+=0A=
+    ASSET_KERNEL =3D Asset(=0A=
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/rele=
ases'=0A=
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),=0A=
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129'=
)=0A=
+=0A=
+    ASSET_INITRD =3D Asset(=0A=
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/rele=
ases'=0A=
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),=0A=
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b'=
)=0A=
+=0A=
+    USP_VENDOR_ID =3D '0x1b36'=0A=
+    USP_DEVICE_ID =3D '0x0015'=0A=
+    DSP_VENDOR_ID =3D '0x1b36'=0A=
+    DSP_DEVICE_ID =3D '0x0016'=0A=
+    CLASS_BRIDGE_PCI_PCI =3D '0x060400'=0A=
+=0A=
+    def command(self, command: str, expected_result: int =3D 0):=0A=
+        command =3D f'echo __begin ; {command} ; D=3D"done" ; echo "$?/__$=
D"'=0A=
+        output =3D exec_command_and_wait_for_pattern(self, command, '__don=
e')=0A=
+        lines =3D output.decode().splitlines()=0A=
+        for s, line in enumerate(lines):=0A=
+            if line =3D=3D '__begin':=0A=
+                break=0A=
+        result =3D int(lines[-1].split("/")[0])=0A=
+        assert result =3D=3D expected_result=0A=
+        return "\n".join(lines[s+1:-1])=0A=
+=0A=
+    def test_pcie_switch_ports(self):=0A=
+        """Boot a q35 VM with a PCIe switch (USP + DSP) and verify topolog=
y."""=0A=
+        self.require_accelerator('kvm')=0A=
+        self.set_machine('q35')=0A=
+=0A=
+        self.vm.add_args('-accel', 'kvm')=0A=
+        self.vm.add_args('-m', '1G')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-root-port,id=3Drp0,slot=3D0,chassis=3D0,bus=
=3Dpcie.0')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-upstream-port,id=3Dsw-usp,bus=3Drp0')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-downstream-port,id=3Dsw-dsp,bus=3Dsw-usp,'=
=0A=
+                         'chassis=3D1')=0A=
+        self.vm.add_args('-append', 'console=3DttyS0 rd.rescue')=0A=
+=0A=
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),=0A=
+                           self.ASSET_INITRD.fetch(),=0A=
+                           wait_for=3D'Entering emergency mode.')=0A=
+        self.wait_for_console_pattern('# ')=0A=
+=0A=
+        # Capture lspci output, to diagnose failures.=0A=
+        #=0A=
+        # [0000:00]-+-00.0  8086:29c0=0A=
+        #           +-01.0  8086:10d3=0A=
+        #           +-02.0-[01-03]----00.0-[02-03]----00.0-[03]--=0A=
+        #           +-1f.0  8086:2918=0A=
+        #           +-1f.2  8086:2922=0A=
+        #           \-1f.3  8086:2930=0A=
+        self.command("lspci -vtn")=0A=
+        self.command("lspci -vvv")=0A=
+        self.command("ls -R /sys/devices/")=0A=
+=0A=
+        usp_path =3D "/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0"=
=0A=
+        dsp_path =3D usp_path + "/0000:02:00.0"=0A=
+=0A=
+        # Upstream port is expected model.=0A=
+        vendor_id =3D self.command(f'cat {usp_path}/vendor')=0A=
+        assert vendor_id =3D=3D self.USP_VENDOR_ID=0A=
+=0A=
+        device_id =3D self.command(f'cat {usp_path}/device')=0A=
+        assert device_id =3D=3D self.USP_DEVICE_ID=0A=
+=0A=
+        class_code =3D self.command(f'cat {usp_path}/class')=0A=
+        assert class_code =3D=3D self.CLASS_BRIDGE_PCI_PCI=0A=
+=0A=
+        # Downstream port is expected model.=0A=
+        vendor_id =3D self.command(f'cat {dsp_path}/vendor')=0A=
+        assert vendor_id =3D=3D self.DSP_VENDOR_ID=0A=
+=0A=
+        device_id =3D self.command(f'cat {dsp_path}/device')=0A=
+        assert device_id =3D=3D self.DSP_DEVICE_ID=0A=
+=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    LinuxKernelTest.main()=0A=
-- =0A=
2.43.0=0A=
=0A=

