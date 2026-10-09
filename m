Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCDBCA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF4WR-0005l0-62; Fri, 09 Oct 2026 02:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xF4WI-0005kZ-3w
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 02:55:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xF4WE-0005Zi-0q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 02:55:53 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993I58I1222469; Thu, 8 Oct 2026 23:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Gft+dV6ECcKP3ED3CPfvYA76MkhRM4DyhLm7ywn+a
 rI=; b=TqErNlifaKRArXbvScZfW8GdtQYKol55QV+bNK10V6y4WVnxOsd/1M39A
 c4CejvIfAB9bDAe9HjhNW7ri2Q5KrilJS7Dyvep0wcqJllerBEcfm2295S/etPYZ
 6WcKsDXm+S4yA4zl/v4PFeV/yp7rEAKceTZqHX9XvreVpcDKV/7ATkMSWFYVFJbp
 xEhcujKsjQSfr7PydDCNDGx6tO7Ya6FLb8SAKl5QI2UBPUXfnN0PAV/44UahDuvd
 wKn/Knt4Pu1WwYxz0XFQXA2H/gWg4NQ+RAgisxH+G+C2VvS4jIz2uzT42kYyMgN4
 YdTfHKW9sQmWf4ZEvi3lwwayANlnw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023136.outbound.protection.outlook.com
 [40.93.196.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h5xe33x0b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 23:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leeA4hetKSykng/pHOcWJS7lpSq2o+Ciu9j9k6ARdm11DhNLoxNi1sF7CyFcN/8KIuyDbJtUEtv13Nc6iXJAZfPwA3x614GJWtP91me5iF7oFMjuaTpD8t5vVcx9oMbSo6i0WHgfdgORSxjeAt+zbwf6+IyyI4/o4EsEsaFWBhGOmZKX4Wg6/nZh37+WEiYWKg9oB1bkvjAVNoXzzh+09xpwM5nLzZ/iJeGrcwZMjak1WLHliXOw6xhWL9fdPEb+8pyEC5NEP4uSZsZPliIXaUdniHLPcuU0n6K0rrUR6Qf26ARrKm5ueNdah59aC8KGeL2c55+9FMe46bm3HXaxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gft+dV6ECcKP3ED3CPfvYA76MkhRM4DyhLm7ywn+arI=;
 b=ByQyWIWbcVTf7F3X+YgY8DxGcU3LZ3mcsPFLj754tGt9id0FfG5njxUPAG19/IpgJPTsZQQzXGl6KGVgU/YCLMBLXRsAXdZOyz6/9JDY+bzONTYO6KfGWOnHHkedcU+8HnhsVaql3+8E/rWlBxwfXBza+3nfzI0Em5ysW8i2Q3qrQ+NFKb83M66A2zcCV76/lEG+AwsGM8EbZKxxYq8XeLT9lnz7uWi9t3Fo2ACZ/WPo8NqW7/poSDoQIbLbocrvI6fJi1rX+3WCXCQNIJWQ85lzLO9lev9TpRhhdIsmlrWfVMqpa7/RhhaBpKLqCDroi1o0aLs/Z+im6BDlnzrRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gft+dV6ECcKP3ED3CPfvYA76MkhRM4DyhLm7ywn+arI=;
 b=iEW3ZnEqKqXiNRWGz3OgDwp9Hq6hmv0mspD/LVizTrLxJh5GzNtZAmQMOAY6gJr1j57KCuMvvprn7ovD9LfKJQJTcgVILScjFMbn7rpDmADSFis2vDpNEBA78lHL+nZimLDcHt2IJwW1sWM67zowmBsQS09bdO77LiYJXxHVfer4sxlnZ5OfxBgroTOaIBEf7rcGhl+iaACb94cDbSy3ZtBIY0r+5kUJ228l66sONXDkZK9O+8JbxI+n+ZlXJRxWyquvj7ksG9H8oK85gbOEdDX3+kbjJn+RHTDxiLmvU3XNiN5ffBupphRUYXZgcWhnN/Q8XNzaVyain1uPyv5Y9w==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CH2PR02MB6888.namprd02.prod.outlook.com (2603:10b6:610:86::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:55:40 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:55:40 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Naman Gulati <namangulati@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Alex Williamson <alex@shazbot.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Matt Evans <matt@ozlabs.org>
Subject: RE: [PATCH v3 RESEND 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
Thread-Topic: [PATCH v3 RESEND 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
Thread-Index: AQHdVfAClTmzh5vfTUu6Fec0T4VpaLb0ymcQ
Date: Fri, 9 Oct 2026 06:55:39 +0000
Message-ID: <IA0PR02MB94626DC2AC22FC1EF1212B4E8B922@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20261007000833.2445641-1-namangulati@google.com>
 <20261007000833.2445641-3-namangulati@google.com>
In-Reply-To: <20261007000833.2445641-3-namangulati@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CH2PR02MB6888:EE_
x-ms-office365-filtering-correlation-id: e2937295-a560-45d2-5acf-08df25d25476
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|4143699003|56012099006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: Cn8i9MylbIKmN4+xIuIAHBxIzmcKWfNZj2Ld5MDg4ah1OXiBsaZ8/jw18Bkjyot3pJNk6jYJTtEDmce3QYlURdt91BUhVqtNoJh732ulgpa5vNpTrK60ioYUmffBG0unsPMusqlaLOZrEz2TaafuOYI8iabLTQN6gTYJHJsczNepsKDzqZAIx9v2ae/d0fiKASLelppEL6UmEzfiehQllIDAQhv7oTRAedFTY0NaJ+ev22c2kKLODcIQNUqDqGO3DFp62xjQKSdC3FcK3PJBmL9GGBFyz+Y4olbsfC510SBidZ4pW5HXyo4BgzBTqVaHSCxDaTbtfry1UmxKfMpn21b7w4Bsxrskdnflb2UmDghJhbPq4TRjt1dEmErACDxvbZXKSFiGTu5KZQc45Fk/uqk7FQBNnMc36g8qvJV5SUX4Ck1k6DNydy6JVWvGB6M56Hxi5QDgjDTlkDM5PwXcI4qDjUmfaSLu7EZOWWEou8bcNr/w5AtO5NsYklWHhLZUyTEOMS/MEnnXBy2xA7YdE49zWx3oi43srEIuKt61JqdNbjvV1xi9yEhx0YWUFpiOMvODV/rnDuUzm0lfeMbMkIEapq6QMCvyznvhQJyboRfl59Tua3l/QlQ06/oCyOCN3U44H8PaOKQGXvccuYJ3Z3c+aadJbd5J567oN5vXVfy71nldhdONFUkizXjEguwn2NGeZ7M91jw8Z3kmKOo4bSVYF094fKArVHZQnZ58IC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGZSS2VoQ2I1ZStmdWU3NmtQc0pSVllYUlRYUTdpVzFnUmltYkRBYklrMU1a?=
 =?utf-8?B?Y1kyaDg0Mzh4M1dmRGxKcTVsNktxM3NWdGZKOS9tL1NOazBQakNhelhkMHZF?=
 =?utf-8?B?VmxIUE1nVEhpSmNyT3U1K0ZkZVpRQ3ova3luZjRDNjBnbDBjMjl5cEE3R3Zs?=
 =?utf-8?B?cHQyUmR0eTljcng5bFd2cVNlUlRZOWd0UFg2Sy9kdzEyTlZNNzI4dkpXN0RZ?=
 =?utf-8?B?bXg3Nm0xc3RISUU1b3VtOGhOWC85dnJaZ1NNa0ExQ01hNVAzcmtQSk9OTlht?=
 =?utf-8?B?dk1sRzlMRzJkOEhLSVFGZURPeGg0TnVRNXdCOTI0UmFUZ3krNGMrUkFpSUUr?=
 =?utf-8?B?RkJjQVNQNVdKMUtHK3plVE1LVkF2bUs0d1dyOG94L0ZXd05saTVmWkNIOXl1?=
 =?utf-8?B?L1lDcUFYVGNnaGU0eEZnOWNKQzN5NXNBZXpLRmwyVnhmQXMzK1RWT3hPWUxB?=
 =?utf-8?B?TWZ2ZjVCR29GNnhxZ0h4RmhObWxyVllBaUhyOFhUSHF3UGxzMWgyWjAxakoy?=
 =?utf-8?B?ZU9WT1VlYXpTaFQvc0JjTVM0elNmL0IzbjZJaDNtcVdZaTg3UjlJbjN2TVh0?=
 =?utf-8?B?dSswL2xsVWtBaUNMemdzQ3RTV1N1cXg2V2FEaG55Tm8vbGZVM3UyK2F2N1Aw?=
 =?utf-8?B?aGRmZjh2bmp0bURjSkxCeVhOTFBFTzRHaURjNkVkR2ZVMk96M20vOW9FdUtu?=
 =?utf-8?B?a200SytLbExkZXpqSkJZYysyR3hjVDZtUWVHL284VUFGK0t4bGF6cFBsVkRo?=
 =?utf-8?B?ZVEzMVE5L1lRQk5TZzNvV3hjOHBPbHBnd2xsMkFJRVdrdjRheDRRUFBvck41?=
 =?utf-8?B?ZTlkMDZzQnNMQlJ2NVgwWEtpR3M4Z3d2bzhzSVlwR2pYN1pRb3FXQXphSW1t?=
 =?utf-8?B?dnU5ZVFVMElsV1gvUEZXZlQ4aTVqNVhsdVlsSUZ6L1owS21rUFNZc3dLWlhj?=
 =?utf-8?B?OS9uczVLOUJlYStKaEZOVnZia3JpQ3g0NkZJYUxmSEpYYXlKZ213NjRscTdR?=
 =?utf-8?B?Y0ZtZCtoT04yVUN5Uy9pcktSckNoZVBlUm1Cb25jUjA0N0F6bzFGbWd2cW4w?=
 =?utf-8?B?L1FMOEZ6ZVMyUk96OFdxWWNvaHhuWkhRWlplRWN1Z2RLK3B2WFRxeDJIV29q?=
 =?utf-8?B?YmM0ZjZnMU1uM0lydEFFR1R4NTZZWHVRT1J0VFdoWFNyOExiUkhzdjRZL1Rq?=
 =?utf-8?B?WFNRcnZ2R3Q0RUxzTzVDRUFPZ1lITXA3VzFBaXJkM3FaQ0JCMHNaWm1pWEpK?=
 =?utf-8?B?cGRidEt4NjgwQWVJNHNhVWF3NTZaRjVHeVkxQUNCZHErSGVuendVcEJJODBU?=
 =?utf-8?B?WWp2dWQxSVp2OXEwa1l5emo5KzlPTmlTUE4zU2hLSERZWXZqTzBMSkREbExz?=
 =?utf-8?B?VzdtcThyRVJocFNLQ1V2R3c5SXQrVGpHbEdXZGFjNUpGVDFDYThhUXRhRnVs?=
 =?utf-8?B?aHBJMWxNWk1ZNXpKUTJrQWFteTlKc2wrYVNBVVhVc3RKbGtiUVhrTWxjc3Zj?=
 =?utf-8?B?RGRKNHlkWXZDc3BKQldPbVNlZWs3c0p2R1d2c0Z0a0ZXblNVanpzV083QlNB?=
 =?utf-8?B?YVM0UVJUQW9CS08rQVoxc0JaampBbWZOQVY3aElaZGdXK25RcUo1TUJ3V1ox?=
 =?utf-8?B?SUNTTlpOVHZIZ3VxUkdJSjBHaERKYU9velU4VEN2b0tKLy90dXc1Z0ZtWXJh?=
 =?utf-8?B?dDg3Z3k1NEM3cUdRakUwVjZIak1BUWFlMVowU1NmcGRQbEtzeTFqd3FsTERN?=
 =?utf-8?B?aFJkV0R2Q3hBWXpDdWkwdEh3ekpJVS96WmxKSWttdkxyb1dDVE9KZXJlOVlj?=
 =?utf-8?B?R1pFVWpaM1pnTkswYmg2a0dkZzQ3MUlSZUxxSGR3dVJTN3Z3c0xPVlpmWnNk?=
 =?utf-8?B?d04raG84QXRES1U4dU1oYWJmbHo1UDVJVDBzK1ZYSVpYR1hPZExpNTFGNVVL?=
 =?utf-8?B?dmhSVU1nVVE1WVczTmFwZmQ4RVVxMndrNXk1TzhWMW5OUGgyWEtwZERaQmFN?=
 =?utf-8?B?MHdNajhGTEN1SmNYR05LdU1aWG96ek1lbFA5bFVXd0NyaDM5amZzelZNTTV0?=
 =?utf-8?B?WS9oYndsRWxoQ0V2RU9pVVhuRTE5dGI5UXJ6TVEyd0Y5RGNXd1JoVjBxZ214?=
 =?utf-8?B?NnNPS0E5eHBTQW1xczhYc1BCVmRCcWFvVy8rdURtWUM4VlhTQUoySHBickJr?=
 =?utf-8?B?UWN6YkRtMTRDeWpqZzk0YkJGelZYc0k2a1h4MlcvT1Y3UHJuTDNVZXQvNkdU?=
 =?utf-8?B?NDZFNkEyQzNxWUVLSnpadEdUV1RxZWZjM3A4Q3JIWlRYODN4b0NvVG5sUUdh?=
 =?utf-8?B?d0ZKV0tkcEtyRDRnM0c4NVpDUlBNb1E5ajFxb0U1cUxkL2pMTkdZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Quckp69hHXWKNpFH3GNu20AXvraMDShGSd7zaK//xWBVUZqujArKxAbTlLOXPJxnMhWTACcm9ZJH+he1G9Bon5ZWTJEqk4CZinoP7Pic1tbfUSlpYeLBaix9jMhISMCInQmUYsXmMhh2n5zhz3uiQH6V46BwaSMQjKg0LNVLHa7ZniorkjWPCEuCSrn+yJ+1jAO1pApOGsq+FSXoQ4qbkQjDcY85/Bbn3FAp2gNKMzcDqYRr9je3JErcQI3LLZaeLHpQ19mcycD0sLRuPSZnARVwtAWBcYOCEaOI8oCptqRA1ftY2Q9PPpK2z3JNfNjiRi59Zhql9NjmuOZh/76q5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2937295-a560-45d2-5acf-08df25d25476
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:55:40.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBJxBF+dt/HHLfgE6BroPAWYJQw8rRgog1BhuVyZu60qvWf3Rk8oOKX3/YfN2SLjyHPMjCZ48tjlid+voAcGbNpeXL5RlWqcL+t7TTPADSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6888
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX8/5VAKG2fqgZ
 z0cVdr+uW+Ixoyy4fipvo6716xGgz/2YXmdb3MdaC9yBOQADefpUSe2rKucBNVq26esLSvXuiB8
 NJ9NLL9vLH3MrSQ7AnIbDEwniCOhB6OS+s2ZPGMVz4cr8N7I3LkhQJMDAZuKFdC3scpFhcVLdVx
 SC8pWeFroMNj9bCgaWqnTZBQWJe6rkUTqj+OnTCMHRS31os9UN6cbykIekFfwBFwZHoQJzzwhSS
 uUXKcFIo2OUFRbwcSTPmlghvE+fqsNNWFDGQtgpeGrrRrMtI/T0ECm0uEXe8NUG8EMDwsRkS2VI
 5iug8pJ4ND4t5bPe3uptD6z6uobDGOW0Tq3mz4dFFa2ECzsGmEwkhALUlSbCOxZbQpVlOOk1zCC
 GwAdLfUhTDka9YN7jLN6DHp/qcns7X2wKjzuac9IUmPyk42xu6DimZh4JUmeojNYTUkIyg/fYyv
 sIg3orKy/Y8XsETsEvw==
X-Proofpoint-ORIG-GUID: EIYWufHBwSMuvBxwdVp2fLi55IPb3exV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX8Lmv7Tua8ncL
 9t8tp8Hpy0k2tySUiUviRtseo9N9xGzTo2HT7JBQu/OX3AmoTxp420yYJXByUtoK+Lp/N/B5qMs
 y/e9iCAzu/7DyCRQ27kJdeANNeKVxA0=
X-Proofpoint-GUID: EIYWufHBwSMuvBxwdVp2fLi55IPb3exV
X-Authority-Analysis: v=2.4 cv=SP7Xx+vH c=1 sm=1 tr=0 ts=6ac88fee cx=c_pps
 a=MadOk45lBhyGsbwhHlC0NA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=1XWaLZrsAAAA:8
 a=69wJf7TsAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=r1p2_3pzAAAA:8
 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=fi6AjuKaoytQNTeYLHQA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=r_pkcD-q9-ctt7trBg_g:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1hbiBHdWxhdGkgPG5hbWFu
Z3VsYXRpQGdvb2dsZS5jb20+DQo+IFNlbnQ6IDA3IE9jdG9iZXIgMjAyNiAwMTowOQ0KPiBUbzog
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBKb2huIExldm9uIDxqb2huLmxldm9uQG51dGFu
aXguY29tPjsgVGhhbm9zIE1ha2F0b3MNCj4gPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsg
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgQWxleA0KPiBXaWxsaWFtc29uIDxh
bGV4QHNoYXpib3Qub3JnPjsgUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPjsgTWF0dCBFdmFucyA8bWF0dEBvemxhYnMub3JnPjsNCj4gTmFtYW4g
R3VsYXRpIDxuYW1hbmd1bGF0aUBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgUkVT
RU5EIDIvNF0gdmZpbzogYWRkICdmZCcgYW5kICdmZF9vZmZzZXQnIHRvDQo+IFZGSU9NbWFwDQo+
IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXwNCj4gICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0hDQo+IA0KPiBBbGxvdyBlYWNoIHNwYXJzZSBtbWFwIHN1YnJlZ2lvbiB0byBzcGVj
aWZ5IGl0cyBvd24gZmlsZSBkZXNjcmlwdG9yDQo+IGFuZA0KPiBmaWxlIG9mZnNldCBmb3IgdGhl
IG1tYXAgY2FsbC4NCj4gDQo+IEFkZCAnZmQnIChzZXQgdG8gLTEgd2hlbiB0aGUgcmVnaW9uIGZk
IHNob3VsZCBiZSB1c2VkKSBhbmQgJ2ZkX29mZnNldCcNCj4gdG8gVkZJT01tYXAsIGFuZCB1cGRh
dGUgdmZpb19yZWdpb25fbW1hcCgpIHRvIHVzZSB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TmFtYW4gR3VsYXRpIDxuYW1hbmd1bGF0aUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGh3L3ZmaW8v
dmZpby1yZWdpb24uaCB8ICA0ICsrKy0NCj4gIGh3L3ZmaW8vcGNpLmMgICAgICAgICB8ICAyICsr
DQo+ICBody92ZmlvL3JlZ2lvbi5jICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrLS0tLS0t
LQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vdmZpby1yZWdpb24uaCBiL2h3L3ZmaW8vdmZpby1y
ZWdpb24uaA0KPiBpbmRleCA1OGIyMzZmMTEzLi45ZjZhNWNmN2Q1IDEwMDY0NA0KPiAtLS0gYS9o
dy92ZmlvL3ZmaW8tcmVnaW9uLmgNCj4gKysrIGIvaHcvdmZpby92ZmlvLXJlZ2lvbi5oDQo+IEBA
IC0xNCw4ICsxNCwxMCBAQA0KPiAgdHlwZWRlZiBzdHJ1Y3QgVkZJT01tYXAgew0KPiAgICAgIE1l
bW9yeVJlZ2lvbiBtZW07DQo+ICAgICAgdm9pZCAqbW1hcDsNCj4gLSAgICBvZmZfdCBvZmZzZXQ7
DQo+ICsgICAgb2ZmX3Qgb2Zmc2V0OyAgICAgICAvKiBvZmZzZXQgd2l0aGluIHRoZSByZWdpb24g
Ki8NCj4gICAgICBzaXplX3Qgc2l6ZTsNCj4gKyAgICBpbnQgZmQ7ICAgICAgICAgICAgIC8qIHBl
ci1tbWFwIGZkLCBvciAtMSB0byB1c2UgdGhlIHJlZ2lvbiBmZCAqLw0KPiArICAgIHVpbnQ2NF90
IGZkX29mZnNldDsgLyogb2Zmc2V0IHdpdGhpbiBmZCBmb3IgdGhlIG1tYXAgY2FsbCAqLw0KPiAg
fSBWRklPTW1hcDsNCj4gDQo+ICB0eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNlIFZGSU9EZXZpY2U7
DQo+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPiBpbmRleCA0
MjhhYjJmMDY5Li5mODUxMDgyMTE0IDEwMDY0NA0KPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ICsr
KyBiL2h3L3ZmaW8vcGNpLmMNCj4gQEAgLTE2MjMsNiArMTYyMyw3IEBAIHN0YXRpYyB2b2lkDQo+
IHZmaW9fcGNpX2ZpeHVwX21zaXhfcmVnaW9uKFZGSU9QQ0lEZXZpY2UgKnZkZXYpDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRldi0+bXNpeC0+dGFibGVfYmFyLCAwLCAw
KTsNCj4gICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbMF0u
b2Zmc2V0ID0gZW5kOw0KPiArICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1swXS5mZF9vZmZzZXQg
Kz0gZW5kOw0KPiAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1swXS5zaXplID0gcmVnaW9uLT5z
aXplIC0gZW5kOw0KPiAgICAgICAgICAgICAgdHJhY2VfdmZpb19tc2l4X2ZpeHVwKHZkZXYtPnZi
YXNlZGV2Lm5hbWUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZGV2LT5tc2l4
LT50YWJsZV9iYXIsIHJlZ2lvbi0NCj4gPm1tYXBzWzBdLm9mZnNldCwNCj4gQEAgLTE2NDksNiAr
MTY1MCw3IEBAIHN0YXRpYyB2b2lkDQo+IHZmaW9fcGNpX2ZpeHVwX21zaXhfcmVnaW9uKFZGSU9Q
Q0lEZXZpY2UgKnZkZXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24t
Pm1tYXBzWzBdLm9mZnNldCArIHJlZ2lvbi0NCj4gPm1tYXBzWzBdLnNpemUpOw0KPiANCj4gICAg
ICAgICAgcmVnaW9uLT5tbWFwc1sxXS5vZmZzZXQgPSBlbmQ7DQo+ICsgICAgICAgIHJlZ2lvbi0+
bW1hcHNbMV0uZmRfb2Zmc2V0ICs9IGVuZDsNCj4gICAgICAgICAgcmVnaW9uLT5tbWFwc1sxXS5z
aXplID0gcmVnaW9uLT5zaXplIC0gZW5kOw0KPiAgICAgICAgICB0cmFjZV92ZmlvX21zaXhfZml4
dXAodmRldi0+dmJhc2VkZXYubmFtZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZkZXYtPm1zaXgtPnRhYmxlX2JhciwgcmVnaW9uLQ0KPiA+bW1hcHNbMV0ub2Zmc2V0LA0KPiBk
aWZmIC0tZ2l0IGEvaHcvdmZpby9yZWdpb24uYyBiL2h3L3ZmaW8vcmVnaW9uLmMNCj4gaW5kZXgg
NTRhZDExYTZjOC4uMTZlZmVkMmZjZSAxMDA2NDQNCj4gLS0tIGEvaHcvdmZpby9yZWdpb24uYw0K
PiArKysgYi9ody92ZmlvL3JlZ2lvbi5jDQo+IEBAIC0xODksNiArMTg5LDkgQEAgc3RhdGljIGlu
dA0KPiB2ZmlvX3NldHVwX3JlZ2lvbl9zcGFyc2VfbW1hcHMoVkZJT1JlZ2lvbiAqcmVnaW9uLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGFyc2UtPmFy
ZWFzW2ldLnNpemUgLQ0KPiAxKTsNCj4gICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbal0ub2Zm
c2V0ID0gc3BhcnNlLT5hcmVhc1tpXS5vZmZzZXQ7DQo+ICAgICAgICAgICAgICByZWdpb24tPm1t
YXBzW2pdLnNpemUgPSBzcGFyc2UtPmFyZWFzW2ldLnNpemU7DQo+ICsgICAgICAgICAgICByZWdp
b24tPm1tYXBzW2pdLmZkID0gLTE7DQo+ICsgICAgICAgICAgICByZWdpb24tPm1tYXBzW2pdLmZk
X29mZnNldCA9IHJlZ2lvbi0+ZmRfb2Zmc2V0ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3BhcnNlLT5hcmVhc1tpXS5vZmZzZXQ7DQo+ICAgICAgICAgICAg
ICBqKys7DQo+ICAgICAgICAgIH0NCj4gICAgICB9DQo+IEBAIC0yNjIsNiArMjY1LDggQEAgaW50
IHZmaW9fcmVnaW9uX3NldHVwKE9iamVjdCAqb2JqLCBWRklPRGV2aWNlDQo+ICp2YmFzZWRldiwg
VkZJT1JlZ2lvbiAqcmVnaW9uLA0KPiAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHMgPSBn
X25ldzAoVkZJT01tYXAsIHJlZ2lvbi0+bnJfbW1hcHMpOw0KPiAgICAgICAgICAgICAgICAgIHJl
Z2lvbi0+bW1hcHNbMF0ub2Zmc2V0ID0gMDsNCj4gICAgICAgICAgICAgICAgICByZWdpb24tPm1t
YXBzWzBdLnNpemUgPSByZWdpb24tPnNpemU7DQo+ICsgICAgICAgICAgICAgICAgcmVnaW9uLT5t
bWFwc1swXS5mZCA9IC0xOw0KPiArICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbMF0uZmRf
b2Zmc2V0ID0gcmVnaW9uLT5mZF9vZmZzZXQ7DQo+ICAgICAgICAgICAgICB9IGVsc2UgaWYgKHJl
dCkgew0KPiAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICB9DQo+
IEBAIC0zNTQsNyArMzU5LDYgQEAgaW50IHZmaW9fcmVnaW9uX21tYXAoVkZJT1JlZ2lvbiAqcmVn
aW9uKQ0KPiAgICAgIG9mZl90IG1hcF9vZmZzZXQgPSAwOw0KPiAgICAgIHNpemVfdCBhbGlnbjsN
Cj4gICAgICBjaGFyICpuYW1lOw0KPiAtICAgIGludCBmZDsNCj4gDQo+ICAgICAgaWYgKCFyZWdp
b24tPm1lbSB8fCAhcmVnaW9uLT5ucl9tbWFwcykgew0KPiAgICAgICAgICByZXR1cm4gMDsNCj4g
QEAgLTM5MSw4ICszOTUsNiBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdp
b24pDQo+ICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgfQ0KPiANCj4gLSAgICBmZCA9IHZm
aW9fZGV2aWNlX2dldF9yZWdpb25fZmQocmVnaW9uLT52YmFzZWRldiwgcmVnaW9uLT5ucik7DQo+
IC0NCj4gICAgICBtYXBfYWxpZ24gPSAodm9pZCAqKVJPVU5EX1VQKCh1aW50cHRyX3QpbWFwX2Jh
c2UsDQo+ICh1aW50cHRyX3QpYWxpZ24pOw0KPiAgICAgIG11bm1hcChtYXBfYmFzZSwgbWFwX2Fs
aWduIC0gbWFwX2Jhc2UpOw0KPiAgICAgIG11bm1hcChtYXBfYWxpZ24gKyByZWdpb24tPnNpemUs
DQo+IEBAIC00MDQsMTIgKzQwNiwyMiBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9u
ICpyZWdpb24pDQo+ICAgICAgICogb2Zmc2V0cyBiZWluZyBpbiBhc2NlbmRpbmcgb3JkZXIuDQo+
ICAgICAgICovDQo+ICAgICAgZm9yIChpID0gMDsgaSA8IHJlZ2lvbi0+bnJfbW1hcHM7IGkrKykg
ew0KPiArICAgICAgICBpbnQgZmQgPSByZWdpb24tPm1tYXBzW2ldLmZkOw0KPiArDQo+ICsgICAg
ICAgIGlmIChmZCA8IDApIHsNCj4gKyAgICAgICAgICAgIGZkID0gdmZpb19kZXZpY2VfZ2V0X3Jl
Z2lvbl9mZChyZWdpb24tPnZiYXNlZGV2LCByZWdpb24tDQo+ID5ucik7DQo+ICsgICAgICAgIH0N
Cj4gKyAgICAgICAgaWYgKGZkIDwgMCkgew0KPiArICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsN
Cj4gKyAgICAgICAgICAgIG11bm1hcChtYXBfYWxpZ24gKyBtYXBfb2Zmc2V0LCByZWdpb24tPnNp
emUgLQ0KPiBtYXBfb2Zmc2V0KTsNCj4gKyAgICAgICAgICAgIGdvdG8gbm9fbW1hcDsNCj4gKyAg
ICAgICAgfQ0KPiArDQo+ICAgICAgICAgIG11bm1hcChtYXBfYWxpZ24gKyBtYXBfb2Zmc2V0LCBy
ZWdpb24tPm1tYXBzW2ldLm9mZnNldCAtDQo+IG1hcF9vZmZzZXQpOw0KPiAgICAgICAgICByZWdp
b24tPm1tYXBzW2ldLm1tYXAgPSBtbWFwKG1hcF9hbGlnbiArIHJlZ2lvbi0NCj4gPm1tYXBzW2ld
Lm9mZnNldCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24t
Pm1tYXBzW2ldLnNpemUsIHByb3QsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTUFQX1NIQVJFRCB8IE1BUF9GSVhFRCwgZmQsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnaW9uLT5mZF9vZmZzZXQgKw0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbaV0ub2Zmc2V0KTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1tYXBzW2ldLmZkX29mZnNl
dCk7DQo+ICAgICAgICAgIGlmIChyZWdpb24tPm1tYXBzW2ldLm1tYXAgPT0gTUFQX0ZBSUxFRCkg
ew0KPiAgICAgICAgICAgICAgcmV0ID0gLWVycm5vOw0KPiAgICAgICAgICAgICAgLyoNCj4gQEAg
LTQ1NCw4ICs0NjYsOCBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdpb24p
DQo+IA0KPiAgbm9fbW1hcDoNCj4gICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9tbWFwX2ZhdWx0KG1l
bW9yeV9yZWdpb25fbmFtZShyZWdpb24tPm1lbSksIGksDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWdpb24tPmZkX29mZnNldCArIHJlZ2lvbi0NCj4gPm1tYXBzW2ldLm9m
ZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+ZmRfb2Zm
c2V0ICsgcmVnaW9uLQ0KPiA+bW1hcHNbaV0ub2Zmc2V0ICsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbaV0uZmRfb2Zmc2V0LA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5mZF9vZmZzZXQgKw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplIC0g
MSwgcmV0KTsNCj4gDQo+ICAgICAgcmVnaW9uLT5tbWFwc1tpXS5tbWFwID0gTlVMTDsNCj4gLS0N
Cj4gMi41Ni4wLnJjMS4zMTUuZ2M2ZWQ5OTM0YjctZ29vZw0KDQpSZXZpZXdlZC1ieTogVGhhbm9z
IE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPg0KDQo=

