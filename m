Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CADCD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0gw-0005F8-R8; Thu, 28 Mar 2024 21:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0gv-0005Ar-Hh
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0gt-0003wv-Kb
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T09169009498; Fri, 29 Mar 2024 01:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=u06My2vKct0UQUpVMdlOfuRoXcLZmetuvLveKEy/zys=; b=lu
 ekcTEmbKLu9weSbTiskcdT6HIpR771daUcVgShp7jG/J5gA8n3NkTLZArQhu8pu7
 5Ev40mcwxs1gTNKR0r+0vDuTukAdpWpr2y12RExX3zH7qHU3WIJEoQB4PM4zCqeZ
 slzEJ5yALqtqOIOBOiUMCjEPYs0EJ6DH6QTcyWuh7Zh0kfDYQLmN17mDx46E72l6
 H0sM16Z/WNBCyWKSfI0ChiC5ov11hBrX3MqhERbDQRBgtoglAh8P+ye3BIbz82GF
 rRAcTcyIA0st9ycgtXSXh87t7lZFUOVBZaLuq7vixozfVhRd89IYWPJ+qmgzgCLV
 oXe2tW6C/nQvUs2k36tg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5h2gg8ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:05:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN0MbTtWbtR/hcJS7cVUp3jbeQz5I6a4Hjhy5nqHoaZE60HI41j1TkRIuiaoIpVREhlTkxwaZYojg8AWNBytPzq6JxYJeP8Ef7T2dK4hR9sD25ZLHfhdUY5rRS5yQb1TskPNcm+kNfRaz9vt7KpMv9weliqy3Vb6rc6g7DNSbdnQR3fLPfYw1q1z8AsJzmGGAbTOs7DMXNaiG3AkX4Ma4DffYeNJyV+V9RBMayiRWiWRnTnHLZRl3x204MURErYhuR7JdSK5mnbWnR+ZqdQFzK4ZXs6wHiS73qOlJgA6cxP20PKCZeTXcqGTk83YsWFQiBQuroaKU40FbYMG+dEJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u06My2vKct0UQUpVMdlOfuRoXcLZmetuvLveKEy/zys=;
 b=KOnetpJHhsDau6gXwv485awS/a2guwwSWFD3ry5Xwr/ApIn/llHVwEgRret8yd9Kzb5kYQGTYVA8Fp2sjtfquDzGw70HU0DQnQI7Xovxx1G8YD4iyfCaKD/KDHV4NpkClCKOtGI/Lvq7cak8JTvVpgSTKrwVcjwV4MrsD+tKO6YQrv885qzo1kwOlPWu+8e5mXBrzZdl9bFdw6vgqaKzP6B3mqr9su8XAFV8H0pjYK3P1TvZJRxiZk0tKQi1fF8jeDOhKtKKDijOdmBZaI+OkDpU1cvJ4kxtZwg7zlyB+TVo6muX7ohobYxtMp8wk6Mp8o6/edp/0mL0Pq1V1kogTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO1PR02MB8490.namprd02.prod.outlook.com
 (2603:10b6:303:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:05:48 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:05:47 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 2/9] Hexagon (target/hexagon) Mark new_read_idx in
 trans functions
Thread-Topic: [PATCH v2 2/9] Hexagon (target/hexagon) Mark new_read_idx in
 trans functions
Thread-Index: AQHacD7Yli3o257tG0WEmllhHgPeY7FOCe4g
Date: Fri, 29 Mar 2024 01:05:47 +0000
Message-ID: <CH3PR02MB10247C2B1C6D0F0B0DFCC7194B83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-3-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-3-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CO1PR02MB8490:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5opSFkjigTqvo70v5QhTMoC9+WfO8IjfIsSzGjH66yWEcSLN6Dsdwcw/IAZ434IrWCc/LGPpbb0TGneVAgbbyHLbYOrmYkLvs1s9GA6F28rlPO6OiKjXZJaDSYvwoD+lTmX9bXniuTTatrVZ09r5kbJ5Ikp2Uksoz9PKYLOADHxVc36Kp9ctHv4iE4gfDlAeNYJ1rj2Hp+qH7pSV1i4hGaDaBtmKevDsIrDNYIJTssNMDC3eI0eqyKpyehne5yAwfjFdDYHrxc/S881JkYDzKp/i5KgDCsjGY6Ue2OlGiwva7idGCjWPkByYpWGZljhH2zQHyKN+tR/yyGHVPg73TIs/g69yl8OYFabkJTiIdfdchhOT87uPYvCgVPcjLeoKvrlN/pNSNao47ZFCmApxCOnm7vguZN4eWuept9jWVEBOWRsNUrjzCaiYecELUKkm+Cgqzr1oQV+KpKfbwhOWhIG6ObqNNtTHpTkXK9/+njv6U7QFX6Zpn2U0V5kzeerpdPiR8MnH8O9EcWpr+dZbjtqv1D7cwHwHHwIEXd93M/5WmL/EEt2500znFuqHxGAv6lVUUnHYD3vu7aNCdrfiYWXyjipaqKMKdIBB69P55U93KKISazAyW5jjojIKlfEWE1I1h9kc9JZRoj0uCPypwZ1PirEZvllrG8zKfZWPZoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NIRkVTenlUTkNLYVdUZnFmQ0hodEVUZHBOVEQ3SWJpVHVhNHNEekt0a0lH?=
 =?utf-8?B?WDRydDRyZU1Xc1R4bCthaXA3UVl3aDJ3eDArY05zUG5ZWWJ3VkpGeDNPTEZN?=
 =?utf-8?B?SnhCV2d5cUkvZnhmYzBMZElCQ2Rvbzhoek0zM2dwQ1UwQkszQ2FLTzVuVUpz?=
 =?utf-8?B?YWZNZzVxMG5BUGxvQ2RGczliZ1FrdWROOWhqUHRNMDdzREpreHZFcmw5ZWpt?=
 =?utf-8?B?OG5aYVJTZjZnM0xwclN4UlY0TjZydENUVXg4WXNPd2gvYTZOaTJYemhLdDQz?=
 =?utf-8?B?a1Y0N3RqWHJ6YkYxWVdhYnNtd1BQc2o2YlBuKzhidU44dEpCU2JSUE9hK1JR?=
 =?utf-8?B?YzB4dlZzNlpTSVFrbVBQZmlUZ1ZoU3FLQXMrZkVPU1N4cDkzMCtiUFZldmI1?=
 =?utf-8?B?aGpVRTBhLy8vVUR0N0lDVlJ6eVVVNkE4T21FVjAyWkZvaXJFRWhzOTJlYnRs?=
 =?utf-8?B?SU4weXFCcVpLTjRueTRpRUEzZTU2b1YvR0VJU3graDNSR2E2WVhuclpOSDBX?=
 =?utf-8?B?OVFUWGtZTGhEdCtybzZtYjRBeE93d2t4OCsrSVJFamFGeUZrenVBWVRmQXcr?=
 =?utf-8?B?cFpPcHdPN2p4Z0NqSDE3VHRFQzk0L21UZDJXTUppaGxXd1krUGhRZ0xpaDVv?=
 =?utf-8?B?ODl2enNFeEJyT0pRblVxaEdyOWQxRXZjdUoxOUk2UkZYbDBkWHE4M0lhUWhz?=
 =?utf-8?B?QmRGYUtWOFFPV050N2xZOUZVOUJJUDRmVVBOVXBPeHlzbi9JUDl0L25FUVJs?=
 =?utf-8?B?c3RDanhCVE9CTi9qUkNMakdmN3NzaUZLa1Vncmd3cWU1eTVSdjczTGdoanhM?=
 =?utf-8?B?NWpLT1ArUkx6MFhRTGM3aytVNGlFL2l1NnU4RmVxcDZQbkVub0tIYTdZTzcw?=
 =?utf-8?B?VG5sckZMR0pmMHJ2cHFjS1RWN3BOTkkwMVVzbHNGcnJkY0ZOSjJ5cWJWaW0y?=
 =?utf-8?B?c0EwbEVDZ1lwclphSG9ScDl5Z1pteldURFVsVlRycjRlVy9JbDRWWHRGR1lE?=
 =?utf-8?B?T3lmU1VZOFAwb05qUmxRS1pFamtucmphekhPRTdEdFQ2bTJmbWhuWTVuSWhp?=
 =?utf-8?B?Q1F6enJqTjVNWXF0bEdIbyt3TVVhQWhodmpHckZJZnRrcWloUmpvYXRZODk5?=
 =?utf-8?B?WmR4NmRyaWxFYVhua01aeW1iamt0R0Z6L2NmOUZLb3c2VWNHZjBUUlRvTXZo?=
 =?utf-8?B?MnVlcWlkWDI5MW1pQXNTeHVoZzdJY1FIWHhLbE1IQy8xTWkyTGxFQkFQZ3Rp?=
 =?utf-8?B?N09Sd3NJbXovcjVlSkF5RHRGWkppZnNhY1E3dXphdFFuV3J3SFFabWVxcGFn?=
 =?utf-8?B?UHZydTh3SXhTZkcwbUFQekFSMGxwOTJNNWQrYnpWUEFVMnA2cVJKWktGaUpV?=
 =?utf-8?B?Vnp2VG42dHRxM2ZrTXBEVmZHOG4reHpjclIra1hxazlCZU5UMCtBSVN0Tzdh?=
 =?utf-8?B?U2RaZHo1NG1GMUJDaGZjdW13Y2tnelQrdUFSUUVlSUlHNHV5OXhEbm1vbU9u?=
 =?utf-8?B?Z2NKZUhud0Nzak0zY1IwTStpMmVWR3A0dXk0NXpoM1EzNDY1MmFuYlJKazVW?=
 =?utf-8?B?QWlKbW9QeHU2SmFSSno0a2xjczlkcWNwTEczTlhrVFNUdEhGTmk1WFU1Wk1Q?=
 =?utf-8?B?VGswckpBRnpuaXRta2dhTDRmN2FYVWM3MWlMR2hMZWVwWlE5cFJuRDIvd3Bs?=
 =?utf-8?B?SDU2TDdRSU1oT0xTK0RRU2dBcjhoeVlTTGtZQXlGMzZxSzNtNVNMdDhWUVEw?=
 =?utf-8?B?MkhVdTVxWkI3TWMrdk1aR0ZyanFGODI5enZuNkhmOFFDNUsxd0RsQnlWSWN1?=
 =?utf-8?B?V3gybnFuZEVuMlRZMDg0OFo1TzhWOHhvNE9NT3NTQm1ZZzdpVnlxQWc4V2FF?=
 =?utf-8?B?KzJZSUh4T3UyU21kN3ZWYkJaMXNPQXFrZ1llRzFLbUtnZFl1UVo4QlN2NlNN?=
 =?utf-8?B?cWtqMVVaYkxzYXFiNlh1dnFXYkNTWGNKdXQwenJpQnhkNU8yZTlkbC9qN2xz?=
 =?utf-8?B?MmNiRVN2aU9KSXZ0Uk1zczBtVkhPV0RoWkZWQWhLTGpSQ3dWejFrZ24ybDV5?=
 =?utf-8?B?RG10UmtiRC9iLzJydE9HQTltNHRjblMwc29yR3hGbllNVkZrYU1UQW1xRmhT?=
 =?utf-8?B?ckZ0anR6NmZUSjk0N0t0TlNaTkVTTXlyUXBzTG1XbG9vd01MUktJNG5vbTg3?=
 =?utf-8?Q?1viaIx6DQFEO0TcN8SVynQr7vRMTwH9eCfacReiXpJ1F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PsZSI7vCAQfMEz3z/D66BpNkV0dh9c68D9iuYTMHf3M4S0rSaZPRSz4maX6YbJEMSVixzo6QLHWV6Sa5sfqMBtihAoVH1cj4Axom+1fjCwWbiZJaz27HA7OunPpzO2ovGjX0kVrT0fXYCSakSUU9FjWdr/kKarm46II7/7yEzP6WDtqJrLC3YgQNvPGfY/sk5hT+lNym1Op3jI/XESsUsI+szMDt/RkhtivcJL3SqpNvFPfjR7MfULE3IS8wpBxYVXOOJGBAspBjCtCbd6d3Ye1PpyKrDmvKmXW1sKenzwydEwgI6gQ1DCWyT5v19DIL9QNylCv9zE8lrf6L9Y8PuQI6czPRdEaSM673El956Rd/jAT5gC+VpdyYCOmQ2hBRfnM8/3FKzMz+pNszrjbUHfXrX/pbbIv8rpW0Yipd8AzZmL/qhImn9VnipyRC++6ADOv/7YjtN5Fd8Pz7216CKhLnVutuo0mvYAGiocxqlHk/5CgMjosOTrzSFjZC5UHBWovjobRQONXShO77iwLHsh+CiPVWhtchfCGdOM0kuX5eiJ1WODNUcCDkUYCXUvNmr39ykh2KlacqFNsH12vfljH40EA9zE1yVCeazIWAaYteK/Dr1KboT+nGpGEGJvzQ
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f72605-9496-4166-323f-08dc4f8c5e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:05:47.9193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NkQ/tImDL1238x+1CK97nqNShtenVEMbXbixGPIo2R7VHIVF/90g8HuHMEk0wxZx2qPUaem4ZEfP1C1pXi3GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490
X-Proofpoint-ORIG-GUID: SucGdw17gosJ8VRbHnGZ1vpWCAqT0wB5
X-Proofpoint-GUID: SucGdw17gosJ8VRbHnGZ1vpWCAqT0wB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=672 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290007
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA2LCAy
MDI0IDk6MjMgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
Ow0KPiBNYXJjbyBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+Ow0KPiBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7DQo+IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjIgMi85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgTWFyayBuZXdfcmVhZF9pZHgg
aW4NCj4gdHJhbnMgZnVuY3Rpb25zDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlu
a3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IENoZWNr
IHRoYXQgdGhlIHZhbHVlIG1hdGNoZXMgb3Bjb2RlX3JlZ2luZm8NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IC0tLQ0KDQpS
ZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCg0KPiAgdGFyZ2V0
L2hleGFnb24vaW5zbi5oICAgICAgICAgICAgICAgICAgIHwgIDMgKystDQo+ICB0YXJnZXQvaGV4
YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgICAgfCAgMiArKw0KPiAgdGFyZ2V0L2hleGFnb24v
bW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jIHwgIDIgKysNCj4gIHRhcmdldC9oZXhhZ29uL2dlbl90
cmFuc19mdW5jcy5weSAgICAgICB8IDE1ICsrKysrKysrKystLS0tLQ0KPiAgNCBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2luc24uaCBiL3RhcmdldC9oZXhhZ29uL2luc24uaA0KPiBpbmRleCAz
ZTdhMjJjOTFlLi4zNjUwMmJmMDU2IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9pbnNu
LmgNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vaW5zbi5oDQo+IEBAIC0xLDUgKzEsNSBAQA0KPiAg
LyoNCj4gLSAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDIyIFF1YWxjb21tIElubm92YXRpb24gQ2Vu
dGVyLCBJbmMuIEFsbCBSaWdodHMNCj4gUmVzZXJ2ZWQuDQo+ICsgKiAgQ29weXJpZ2h0KGMpIDIw
MTktMjAyNCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzDQo+IFJl
c2VydmVkLg0KPiAgICoNCj4gICAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPiAgICogIGl0IHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQo+
IEBAIC0zOSw2ICszOSw3IEBAIHN0cnVjdCBJbnN0cnVjdGlvbiB7DQo+ICAgICAgdWludDMyX3Qg
c2xvdDozOw0KPiAgICAgIHVpbnQzMl90IHdoaWNoX2V4dGVuZGVkOjE7ICAgIC8qIElmIGhhcyBh
biBleHRlbmRlciwgd2hpY2ggaW1tZWRpYXRlICovDQo+ICAgICAgdWludDMyX3QgbmV3X3ZhbHVl
X3Byb2R1Y2VyX3Nsb3Q6NDsNCj4gKyAgICBpbnQzMl90IG5ld19yZWFkX2lkeDsNCj4gDQo+ICAg
ICAgYm9vbCBwYXJ0MTsgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIGNtcC1qdW1wcyBhcmUgc3BsaXQgaW50byB0d28gaW5zbnMuDQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jDQo+
IGluZGV4IGE0MDIxMGNhMWUuLjQ1OTVlMzAzODQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhh
Z29uL2RlY29kZS5jDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jDQo+IEBAIC0xMzEs
NiArMTMxLDggQEAgZGVjb2RlX2ZpbGxfbmV3dmFsdWVfcmVnbm8oUGFja2V0ICpwYWNrZXQpDQo+
ICAgICAgICAgICAgICAgICAgdXNlX3JlZ2lkeCA9IHN0cmNocihvcGNvZGVfcmVnaW5mb1t1c2Vf
b3Bjb2RlXSwgJ3MnKSAtDQo+ICAgICAgICAgICAgICAgICAgICAgIG9wY29kZV9yZWdpbmZvW3Vz
ZV9vcGNvZGVdOw0KPiAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgZ19hc3NlcnQocGFj
a2V0LT5pbnNuW2ldLm5ld19yZWFkX2lkeCAhPSAtMSAmJg0KPiArICAgICAgICAgICAgICAgICAg
ICAgcGFja2V0LT5pbnNuW2ldLm5ld19yZWFkX2lkeCA9PSB1c2VfcmVnaWR4KTsNCj4gDQo+ICAg
ICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICogV2hhdCdzIGVuY29kZWQgYXQgdGhlIE4t
ZmllbGQgaXMgdGhlIG9mZnNldCB0byB3aG8ncyBwcm9kdWNpbmcNCj4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYw0KPiBiL3RhcmdldC9oZXhhZ29u
L21tdmVjL2RlY29kZV9leHRfbW12ZWMuYw0KPiBpbmRleCAyMDJkODRjN2MwLi5lOTAwN2Y1ZDcx
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMN
Cj4gKysrIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jDQo+IEBAIC00
MSw2ICs0MSw4IEBAIGNoZWNrX25ld192YWx1ZShQYWNrZXQgKnBrdCkNCj4gICAgICAgICAgICAg
IEdFVF9BVFRSSUIodXNlX29wY29kZSwgQV9TVE9SRSkpIHsNCj4gICAgICAgICAgICAgIGludCB1
c2VfcmVnaWR4ID0gc3RyY2hyKG9wY29kZV9yZWdpbmZvW3VzZV9vcGNvZGVdLCAncycpIC0NCj4g
ICAgICAgICAgICAgICAgICBvcGNvZGVfcmVnaW5mb1t1c2Vfb3Bjb2RlXTsNCj4gKyAgICAgICAg
ICAgIGdfYXNzZXJ0KHBrdC0+aW5zbltpXS5uZXdfcmVhZF9pZHggIT0gLTEgJiYNCj4gKyAgICAg
ICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5uZXdfcmVhZF9pZHggPT0gdXNlX3JlZ2lkeCk7
DQo+ICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICogV2hhdCdzIGVuY29kZWQgYXQg
dGhlIE4tZmllbGQgaXMgdGhlIG9mZnNldCB0byB3aG8ncyBwcm9kdWNpbmcNCj4gICAgICAgICAg
ICAgICAqIHRoZSB2YWx1ZS4NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90cmFu
c19mdW5jcy5weQ0KPiBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQ0KPiBpbmRl
eCA1M2U4NDRhNDRiLi44YWNlY2RiOTkzIDEwMDc1NQ0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9n
ZW5fdHJhbnNfZnVuY3MucHkNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNz
LnB5DQo+IEBAIC02OCw2ICs2OCw3IEBAIGRlZiBtYXJrX3doaWNoX2ltbV9leHRlbmRlZChmLCB0
YWcpOg0KPiAgIyMgICAgICAgICBpbnNuLT5yZWdub1swXSA9IGFyZ3MtPlJkOw0KPiAgIyMgICAg
ICAgICBpbnNuLT5yZWdub1sxXSA9IGFyZ3MtPlJzOw0KPiAgIyMgICAgICAgICBpbnNuLT5yZWdu
b1syXSA9IGFyZ3MtPlJ0Ow0KPiArIyMgICAgICAgICBpbnNuLT5uZXdfcmVhZF9pZHggPSAtMTsN
Cj4gICMjICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAjIyAgICAgfQ0KPiAgIyMNCj4gQEAgLTg0
LDE0ICs4NSwxNCBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYpOg0KPiAgICAgICAgICAgICAgICAg
IGluc24tPm9wY29kZSA9IHt0YWd9Ow0KPiAgICAgICAgICAiIiIpKQ0KPiANCj4gLSAgICAgICAg
cmVnbm8gPSAwDQo+IC0gICAgICAgIGZvciByZWcgaW4gcmVnczoNCj4gLSAgICAgICAgICAgIHJl
Z190eXBlID0gcmVnWzBdDQo+IC0gICAgICAgICAgICByZWdfaWQgPSByZWdbMV0NCj4gKyAgICAg
ICAgbmV3X3JlYWRfaWR4ID0gLTENCj4gKyAgICAgICAgZm9yIHJlZ25vLCAocmVnX3R5cGUsIHJl
Z19pZCwgKl8pIGluIGVudW1lcmF0ZShyZWdzKToNCj4gKyAgICAgICAgICAgIHJlZyA9IGhleF9j
b21tb24uZ2V0X3JlZ2lzdGVyKHRhZywgcmVnX3R5cGUsIHJlZ19pZCkNCj4gICAgICAgICAgICAg
IGYud3JpdGUoY29kZV9mbXQoZiIiIlwNCj4gICAgICAgICAgICAgICAgICBpbnNuLT5yZWdub1t7
cmVnbm99XSA9IGFyZ3MtPntyZWdfdHlwZX17cmVnX2lkfTsNCj4gICAgICAgICAgICAgICIiIikp
DQo+IC0gICAgICAgICAgICByZWdubyArPSAxDQo+ICsgICAgICAgICAgICBpZiByZWcuaXNfcmVh
ZCgpIGFuZCByZWcuaXNfbmV3KCk6DQo+ICsgICAgICAgICAgICAgICAgbmV3X3JlYWRfaWR4ID0g
cmVnbm8NCj4gDQo+ICAgICAgICAgIGlmIGxlbihpbW1zKSAhPSAwOg0KPiAgICAgICAgICAgICAg
bWFya193aGljaF9pbW1fZXh0ZW5kZWQoZiwgdGFnKQ0KPiBAQCAtMTEyLDYgKzExMyw5IEBAIGRl
ZiBnZW5fdHJhbnNfZnVuY3MoZik6DQo+ICAgICAgICAgICAgICAgICAgICAgIGluc24tPmltbWVk
W3tpbW1ub31dID0gYXJncy0+e2ltbV90eXBlfXtpbW1fbGV0dGVyfTsNCj4gICAgICAgICAgICAg
ICAgICAiIiIpKQ0KPiANCj4gKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXA0KPiArICAg
ICAgICAgICAgaW5zbi0+bmV3X3JlYWRfaWR4ID0ge25ld19yZWFkX2lkeH07DQo+ICsgICAgICAg
ICIiIikpDQo+ICAgICAgICAgIGYud3JpdGUodGV4dHdyYXAuZGVkZW50KGYiIiJcDQo+ICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAgICAgICAgICAgICB7Y2xvc2VfY3VybHl9DQo+
IEBAIC0xMjAsNSArMTI0LDYgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToNCj4gDQo+ICBpZiBf
X25hbWVfXyA9PSAiX19tYWluX18iOg0KPiAgICAgIGhleF9jb21tb24ucmVhZF9zZW1hbnRpY3Nf
ZmlsZShzeXMuYXJndlsxXSkNCj4gKyAgICBoZXhfY29tbW9uLmluaXRfcmVnaXN0ZXJzKCkNCj4g
ICAgICB3aXRoIG9wZW4oc3lzLmFyZ3ZbMl0sICJ3IikgYXMgZjoNCj4gICAgICAgICAgZ2VuX3Ry
YW5zX2Z1bmNzKGYpDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

