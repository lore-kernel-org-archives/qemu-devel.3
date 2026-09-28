Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C77CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDDi-000147-SJ; Mon, 28 Sep 2026 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDh-000135-8r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDe-0002kF-75
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEhU4v1856331; Mon, 28 Sep 2026 08:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vZmYj72iHJ8V7z9AcIHn6DbbP+fcNBu+7PWRVwxtw
 Tw=; b=FWVOC8n4M2RoaiKpS1pCJ3K4Ca5foTU4KgjusEK9X8NMAhDlSWCeLVKQb
 bkU5bsSTKeeWeK9wrV0akLRbyhCJ2V/qxjxZ8qxSAXR+CPeMMPGvaia536Z5L4sa
 QQJLuHgQNFRasXe3c4u3glvS17WVhzEhS4L2GuIZg410BeFfJBZIbvlsqAJy5x+5
 Melh2JNXC5Zl1u809BcyXBB/90kUim9//GHAd/6Px7eiErhMBSwib7fWN0443+bY
 rsszU524o6V0K4JkknPoJMp/hfhpJcLVcQ9+cDsR+kMOV1Y1lwFrc/drvgz7/20N
 1AhxbYTloH/OV/l2irKckLSl/9n5w==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023119.outbound.protection.outlook.com
 [40.93.196.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxd4em6ux-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJuit9eLT3SYoYVEL/idYOYQE892OPcdeD82CXMe5+B/dtZMsdFNO8CFw6iDI5aOybLF9WDmONKIf69ylrAoeGHCgu8R+ggfXOib/KL+u51AzcdcFUOTNFaS3ZGdk5T3w4jfhEd/eOxZlailr44LyiTLYRaimvShwrgJyFaKYpltnsqLLD9NV4BbdeY+byd5KkkrPQCgT6iPXQAwbcmFpS+afM6b0W8DXmcRAdo8Ay0oYuWN6QLAZEI8dpYAjnHK06K/rd20etWELQFcHqdJX9eN6MpMJ0dtZahfukQ+GMjGU7hd1aM6EpgcRw+qIKBnGHLHZaODDS8C0HZRoxM12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZmYj72iHJ8V7z9AcIHn6DbbP+fcNBu+7PWRVwxtwTw=;
 b=P67Tx8uBfNO4MVanlAu7svucshk6U9Yl1TZI7P7hXq4jx5X9w+tiDP0WSOCl0EC8HUn9Pr43dW8dClnGyTwyI/32NN1mLupAQlKKTeX0cW+7F2A2udlpozeByUCts9tJq9CHx2FZjnc4Ptg7nIzLbNfTrkAz9xFUaNJ05gP5D4GWETcm62OWOUPExanLMmEd0cDKrmml7AjsjZAw9yDa6yGwjzos/elsT80qWOQKTeKyqMnZtzRqtWE6hr8yaElUFkrBFlDP6egS1rd2YYIPmKgZZg1NFzGyLBSS4+JU5/bnPzlTkFWtIyynkmWxolQYrXsJWB1JkwQdU75muKSBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZmYj72iHJ8V7z9AcIHn6DbbP+fcNBu+7PWRVwxtwTw=;
 b=a0QawDjnZl1KM3rcjYs1x4LvjNomd++Y33floZJTPPCAbMEiRU1X2FYQGLHH3sAZ81bS1t1IE6TaiEXpXwGFZMQNXlpxHREUqCnyI9y8SOc7naxUoQ3d/1KYFSSj48F0SV514IGCk/SqAjZBSn/a0f8x5R7ezwcRC2v4g9VXCowp/Qua0g7fbcXhSI7OXlOAFverwIPWMNBjbdhFErTj3t7keZ3x4hp8ZCiZjN8EhG8yS1LU5nV5Qltj3Nq6zTfEIuL98rfL0ll7uBeFIvWsobeGo8pGnW0Nfdrn+4AQFYzkkOt614nH8Y10YI6hNjeFqZS/B5A9lgpY9h2YqNTvAA==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by PH7PR02MB8884.namprd02.prod.outlook.com (2603:10b6:510:1fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:24:36 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:24:35 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 3/4] hw/pci-bridge: Default the generic PCIe root port as
 Gen6 capable
Thread-Topic: [PATCH v3 3/4] hw/pci-bridge: Default the generic PCIe root port
 as Gen6 capable
Thread-Index: AQHdT1137xFeNrVPfEeOwK1dP9HzBw==
Date: Mon, 28 Sep 2026 15:24:34 +0000
Message-ID: <20260928152431.310363-4-david.vrabel@nutanix.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
In-Reply-To: <20260928152431.310363-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|PH7PR02MB8884:EE_
x-ms-office365-filtering-correlation-id: 5be54be5-00bd-4100-e25a-08df1d749aad
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: TS5wmNyZVje5XiHu2nIPqE9BJL12jVBVj4hqZrh5Wj2xefqvPyBOeKUIoVf3ql9lwhD+Sna+r9jSQfbMVi0tBhKLqQvCr18etyW5yu2IudD4ZwiplFs7XpRlWo5blF/ZyduS7GqG1i0EX4fEqBt0r7focX1AO1u7pLsv9/xIxlG2NXUAkDCROSu8NpW2oryYq06GWD3EfTASOdEYOn/01Bx7hK/f5tD+gxbaR6D75AOf7OjN3fnethE6djr+4ueXR753fGuhlsEpjg7qBu/KlWSLF7/QNVFySLdJnph/N7JawNwjBciv6pVe2q/FDZMcLuwZpV05WKRzkPEccCl8brY/UnG0pL5etga4jNQ+bXklStQxLNC0odQrlBM8jKin3YgnI/12VJIoCX999Kli3vZaF/Vux1HVenug3DBFwkd2rtX5PqdCrZlYnXmfqE7nz3cXQIvEFHUOWGTaquz3/4BFODbHXyjrwt5GKsyd/ldunwkHyutbWvUZnjidvTje03dA3R4TF9hfbz1WXA3TYphNKBT2XmwkC+xtUA/MteekrdfEAqZ4ugM65b2uSkjBey3FZntMMR1ulhzJ9EfF5ypMjoLXYqzKzx2Vi6ESZzu11LsRO1uQLOuR0tWOUNYB9Bp2q2yz3T4qtEWy9rI4arYALqjnAl8C0SQx7dhT+tt8oklLJL/rk1xaiDd/cVg4mWviSjpcrQMmtlhKA215mjeQcnEDQ361DgbPBxcwitA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tepalKYmSJxlbocb1ylHwZTGDtWYpCEKwQXQjReCKYAIIWOJP8NvD0Zbw7?=
 =?iso-8859-1?Q?uamJGqca/UszECGl2L571ifo2jeN1rlT0I8AzY8IRSbfoPbhviQ6g0K5kf?=
 =?iso-8859-1?Q?qWCKG8XxQzzqhf0P7KbQ9g02zGuABIBAuMO7zVhfcZLCP6Bx5migPRUEKP?=
 =?iso-8859-1?Q?kwQj5ht4LOQneCDi3JxCsTQQ3QR+C+QC/SQbl7GGFM3zo+PrvH9rCNsrE8?=
 =?iso-8859-1?Q?bDGVXbl+tptt20vEeTK9o8Qp21LJW0WbIHkLAfdwUP/12BCIPhIH+ng3xZ?=
 =?iso-8859-1?Q?GguUQ3n+1LdDUW+Hgn/DYRqpSVhj3gMbDjs65hyocISG1vjrmbsPuoquOu?=
 =?iso-8859-1?Q?kRvs0NOHnE0OcnpGvtpBiRnU11vD+wEP5PXkIv0Nn23sCCBSHxnQak0UXO?=
 =?iso-8859-1?Q?q77oASrFVivXeNh2m9qNRskn3d+bc1qvBwQiu0ybQgPPGZgZEFNzyQk8ao?=
 =?iso-8859-1?Q?lJlgcahtzOZzFr2eNnxwXdYfwPWEIITe/SBFFB/x80LR66Xdyi6YWfZNSR?=
 =?iso-8859-1?Q?UM5+9APoySgO8EzgENtnKRfh7yYl8TDH83Z7N3orMXFrj5H7lIKbJ37jcB?=
 =?iso-8859-1?Q?pZwcKRA6Rxah5g7Voqri5dSDWy1FSw2yMrDBxrd1GPad/dPmCmJFReTyTw?=
 =?iso-8859-1?Q?OCVqxSCkoqbxTXYYo+nF0YzqwF+PsySqc9Zj52Ko0Ts1IX1jKCG1GskZ15?=
 =?iso-8859-1?Q?ljW2YS5Vrk1IZYYcK4yKagksGvZK+NBD/2n9Q0MqgpFyxWVi+jupPV8j8x?=
 =?iso-8859-1?Q?a35+1A0BAEHqZzyc6x02lN9PtHUGnw8Z6QRlnz20BP9AK3D8RztLyiO+R5?=
 =?iso-8859-1?Q?e4pUDN+hRmgHgmX9JASlIA5TFUi/0fciqyP9lRLAUKffO/4InJ2mOEAXqp?=
 =?iso-8859-1?Q?MbMX70WbdEgeNu53zlLU1iY8euCVzjQ96iX/fgEVwgOy8tDsgztJ1GmJRp?=
 =?iso-8859-1?Q?JpfjE4zbXwjRCcGT3IiwN4K7gMksoJxPomsx+5mXlFEv3KPjkfuUWsAruu?=
 =?iso-8859-1?Q?UfZMouW+hJJUuZrheRxk31uLhfiZ2kYXw4bz5GkzSUbwTS7yKwxxX2dAWG?=
 =?iso-8859-1?Q?t5VwDFj77GbcprjGlc55E3AiNfuZG+N2JuJvCH1qzxEatvGoifoNbwFs95?=
 =?iso-8859-1?Q?B6+VoqbgKFMsabq+A4I2ZP1AfGDqwzyJWyZqXKWMAGGlwGEYBNqwTqQU7g?=
 =?iso-8859-1?Q?TjZo/GkEJSNHlU+VisY+7Ie/W2/QxTBWf8VdT5+e/LyJO/4VQhaHJESHgC?=
 =?iso-8859-1?Q?65wp/awPO/bGBkuTL4VQC47MMQH2TBD+cn5GadDshPJXbtGw2jtCR2a6be?=
 =?iso-8859-1?Q?CGgFoOXprwB6o9kA+uY7Z4muZrpibwNM7zIK0mFLWaNL1HLX5pa+JV0wVH?=
 =?iso-8859-1?Q?H+sH5h/cl1RbsAyrUSsB/EWo8jUsGgJrpE4L3E/195AyMMQH5LMfa8fPOO?=
 =?iso-8859-1?Q?W9LLHixBiR/pTQ5gGPdaVdrsp/A8zZ32MQwj/uJOF9Fea7yjsCj1KNFR5P?=
 =?iso-8859-1?Q?TNJqxhhq7fFWAk/eLJY+KPRoRGi2APvm/8KH54xtisLCXLeMt4lkTxr3+3?=
 =?iso-8859-1?Q?NcX1ZiwNxSk8neQ4geAeryh8kz0/UDCE9hSi3+bjwfPBspumhtb5E+NmF3?=
 =?iso-8859-1?Q?qP0srmrXbSJxmzcb8FAZyryShaIzTMaV1Z53urhMI9YJsUS4ZfN71hwrvi?=
 =?iso-8859-1?Q?cXulpYVEHn0bsy109W0QuRGPP6xTSGpbbdhOC+puABFz5P46SwmkQjJVL5?=
 =?iso-8859-1?Q?0hDm3PSbibhNMgiXWjwHgX8n8cdF1guI3Tp9NSWqM3Uku8JOKFuBxkS/Q9?=
 =?iso-8859-1?Q?vEWGIXwbOrjZfII7RJ4gZTtQdCO0n20=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2/1E+Bfl37U9hutm/u2nainW6i/BNzfBwOFF57gaxjHFdr2oKhlN0+4XUCbWOhxwzPDOYq31nqqKeF2P6eNXPdP9Zf6ZsAlAkKBNGvSTcLgQWyr5jNlWNEj6L31PAJ3xaNQX76wqSh6AVAVT0PAmeikXta7MhIBFTTahVL9ZiL3R7PKonReYCr2TOAMH4kZ1H/Od4DGQMILGWGpHtIDamz7vDO9/QZ8WyuaNq5ZKDJV4aLKwxl1XEDJ+oh2erTbgVeriYwogdh+S9Ki8Yz+SS1tyGzkmF7X4HgO9nYkfd1+zhxfLSRC408or7cJKF7o1TBWdCXzeWuxh0yp1Roozmg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be54be5-00bd-4100-e25a-08df1d749aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:24:34.9695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGEhmWTAb1Huoxo9EsfjtRn6hnYdSYHva+QfcyMEaMtxxrQUjo+E0t/wWs/vj04h0ubZHAGJlUOZPCeCULmiRHv0ynosKP+4oHD3IKlhJsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8884
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfXw3MXn0wAo7YT
 GGqbeG76vBVI8Z2+/c9kBLRo4VvoUga8f2fBQTGbT5nZGfRZwj6WlxFvE8q7qOFUI63Rh8BlPfP
 bwq2u/Z1Dfz2GdbCyMueiZ1I7S/IWvc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfXxEj4/oo32vyz
 dJwdviJgJqRyoC4wZ0UHB2xDYiME8ObaaKlRBVu1BKBFUSNIJyceszCs31/B/VFq3x3e/cmYgvu
 8afIMBEpdoC9lTZ+YzUfG7mFIt30DwVC8O7yjkK9OeJOKKXV4jimoQCtD/IGonl1N1t/pancPu9
 J8/lrtzGqqPATq3xg6ShXEXA1flT8Q6zfD3HDx60/T27mfGDx0eMBE41KK7a4OWTcyd5F6/qDuo
 mbGmJN/8gtR0Fc6GXkFr7YcehwdDFNKJdyPcCXAIr0Vd7j+aFWUKIIp1qyU7QuzUcrUJuf5yxVN
 SiUmU7q/rLr/IChe8wp2a3PQ3FrGHbSNxcM9pjLAugsjUbF3nPREGvJPHUNKUU0lA2ST53WxLmC
 mQOr/RWnQrTOz/KgCw3HTcAgsw+4IcQyfqWp5jbBhEmvSqooVxDSprM2HwD8iOP9P3NMCpa3Ee4
 XjxfAxe8wAWeZlEiSQQ==
X-Authority-Analysis: v=2.4 cv=SqMFe/O0 c=1 sm=1 tr=0 ts=6aba86b7 cx=c_pps
 a=SNRzDqNuYCMO/bT9QdJRMw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=BlouRpKd5MmS78s8ARwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: rh8GOOa3NNMk8YUSScT7vb1llAuibs-8
X-Proofpoint-GUID: rh8GOOa3NNMk8YUSScT7vb1llAuibs-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=david.vrabel@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

As part of making virtual PCIe topology having the same apparent=0A=
bandwidth as a the underlying hardware, make the generic PCIe root=0A=
port support maximum speed so by default it doesn't appear to be a=0A=
bottleneck.=0A=
=0A=
This also makes the three generic PCIe ports (root, upstream, and=0A=
downstream) have the same link speed/width capabilities.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/core/machine.c                  | 1 +=0A=
 hw/pci-bridge/gen_pcie_root_port.c | 2 +-=0A=
 2 files changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 8939ae1666..c4ced7a8c1 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -43,6 +43,7 @@=0A=
 GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "pcie-root-port", "speed", "16" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_ro=
ot_port.c=0A=
index d3ace7f0db..8cabeadac8 100644=0A=
--- a/hw/pci-bridge/gen_pcie_root_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_root_port.c=0A=
@@ -130,7 +130,7 @@ static const Property gen_rp_props[] =3D {=0A=
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,=0A=
                      res_reserve.mem_pref_64, -1),=0A=
     DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
-                                speed, PCIE_LINK_SPEED_16),=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
     DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
-- =0A=
2.43.0=0A=
=0A=

