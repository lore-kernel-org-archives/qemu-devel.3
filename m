Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EAFEA3C23
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmGk-00035j-Hp; Thu, 09 Apr 2026 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmGh-00033R-7r
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:05:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmGe-0007Yi-GQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:05:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6398BqaY1447029; Thu, 9 Apr 2026 03:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gtkIPCPCYpsSZxjeHKM0chLdymJyhsO60jGwal7pk
 ws=; b=iM8vsr+XXQoer4LfIHNnJheCqzJt3vXx/lQYF4EK8qQOdtwj6+H8pMMHh
 PfeRuUEe1sZQ89gnmwdsLPq9PnuQ3fgrwv8ig27gatnDabc8RRDoRG3ipkcnMdp6
 hw/OwqyGOarfPrM3cPjAzsEIZUZLBoWlqRwwksQKkN1sKgwTLhYOUCBtkDBGxmOi
 YnY8wgmEDtwisN7GfLFzXvNiCyofg52StzGJgKyrs9drjYgX9Nw+86aZJ6zqvHiv
 gVww7mMORVx3cJo9xSs/XY9OyHZxIVoIb8q+GsxMzMYl5lvZ5i9y+An1VZjWsiOI
 6ZIKnhOf1/8xhbFleTJmgCHWgUV+w==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020121.outbound.protection.outlook.com [52.101.61.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms5xy21-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aABZUAfg5D4duS5p2JUladdXBYKpraLqkjU50qudKIbF52PoxCFAfq/ZBx3s+Kgy2sTxuSqaN/bE7tUKf+nsOcCPh+wH9MyHxSBCKtS8XeMcikJYTBB7pg2fPEH4zoKK4rrtaRjAYIhw31fZmV21rLpPaFPx9K38Z/+ztTX021f3hbgovJn0/13ROWyccDi4NbEguKoQtHhokHiDV4G2IIClOu+MPTULQiSDB+SDpJ2a5s21GgqFpXrQRFRJvWJqOhhbpZA/EKXiBhhzydYsXdObw9mrknv74tDXQUjWrXUl0iclgJt5CA2szUE0uxXMpVjBmmYqz197KuMnWm2C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOHME51O0CDfGCxSYU8VJTN7QrD1KJrG0KSt0g1DtSo=;
 b=NtNZktueSP0E0HabutIO1sCclt+G43EVIgVzoQs5xSdkm/EoYoTTa44O1TrCgRR7RxxLP3Ae4wi9D7ZXhueyEeMrhhwgEiOa8q8uHD7k0D9mtQe5SQNClw0VHr3NkL7nT3mTZECkObcaDQJ80Y/5l/pyqOMx6nl20GgQMHRwAt7A0Z7rGoU09iGA3hWk861aOsd88QPyHyNTHbTumrxT3ZNAifrT69OxWZ+u9LqCftArLPUkOoDkBqxe+87+s4uO9K7pHLwiC8xR3osYsCADW4cT8LX9xl4J0Hjdq5llFdEJusSuvcHVBje/w+jkJR2IaLygCKexnGQXDYsyNpBpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOHME51O0CDfGCxSYU8VJTN7QrD1KJrG0KSt0g1DtSo=;
 b=aRrGiIdSopOr8AlGD2lJSYMLESZcXInuW9U8aa9wCEA5eIU/jEnT8R9/sU+kEf/5blMZ52Aqo3beUNj9WX9KwKMnAKGiXzdyGJX98yF0y14/NGiXzvxLvPhhY2wZfSnNtR+lM5ty7ibi+QA7rJj7EW1sqOf2cNl2i17ozw2iL4Yxn1gYyuoSQ6nOdqXIdL5V76xZ8jMWdR81LJB1MqM1sDzAFyuPMqStVf7II/EUe2l6sPXsTfsAs85c0a6OLv5pWv+NmGBeVSyUYPIKtvXZsDGwZHsaTjDzLNIWBgQfIzLz3P/6qe0J2u6RBiSzHOUydoDy+Cya6gjiZ2rGjmATFg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7389.namprd02.prod.outlook.com (2603:10b6:a03:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 10:05:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:05:38 +0000
Date: Thu, 9 Apr 2026 11:05:35 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 2/2] vfio: quieten dma-buf warning
Message-ID: <add571i7pPUyZ4I8@lent>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-3-john.levon@nutanix.com>
 <2bbd13e7-5d14-48c8-90a7-231a38537180@redhat.com>
 <adYYg-OgUUavR31j@lent>
 <ed00dc34-858e-4d5f-9b43-28c39ef561d7@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed00dc34-858e-4d5f-9b43-28c39ef561d7@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: ce74f27e-e37c-4244-c7cd-08de961f8c9b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: SAQMm+dhQ4fjoIt9v7rUQnB12EuzamBkLRfxygICjOPZIu194C5peVM3DBmXBrWVSilWNb89DFsGfpmQN3HtXYWHRaSnTI13ibrQSb/hBbyN9BKoEb4jow4KAW6UBCInxp/PYAMvDuDGDAI3FDNnzy2yoaqqPxe7HuEtLC/8MwX0o9pxd+mXoaCY2p1k94E2zeV6VpBIkqJ4LBdvrq91VQFOz/nUv6kBjrczqzJuEry3INdT09xf6Vaq2iUFLnxqOzw+iesG/+NZwgUiEn4B3phKBzdCbPySFmny04OruRWJtOYXcMwACIv6FETb/1ed7DH81awiLzv+IXisOPhxxtEUl2lRhYYWw0gql+uZXlPamfd1CcL7+dBAoODDb3CWZypz96MMwW2oQtevd1n8WRxwtvgFAFe+Nh3hD0GAv90M0PtRJ8tm0nU0WP7/gbtneDOjBEdbNjFThdi3LXlLaGJDqiADApbljHWTw8ul7Kr+Q8pg9nesXzoJJnf6B+NyLRI0vUauVpSiGn4RhY1fEsNs5a4FXpJscC/6HeDBjx1WpJIih5VmhYr2Fs3hj+ghiN5gmCd57s/80siEcH9etJFyFZFsijggwTsdHw9qsrBPB2AqQ8MQ9CzLeP6PpKNjqsVx9EOf+AJG2b0NKxja07kbOsCnxLIAzLnN7KhtPsb/wfOIcTmMyTb8G0fTaWzGgtiIhv2Ph9hChAOBsQjjMZAQOFkx3LtRUQHvPQIo5Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5+h3+YK30SPFfNXtk/9GFvvR1a/E1RbZ4ksTQhnARDKBABB789WHjG8VeA?=
 =?iso-8859-1?Q?hrWMwGf3vJ6xJlgATBxnTv1byqdLgJa/bYd+ujzckARGZ1zEU8xCkkFUEJ?=
 =?iso-8859-1?Q?lK2+ShHr5Mp19tDcRXW03vb1CYQZD3prXntl+/jf+XSqRoRrjbrM6bG1bI?=
 =?iso-8859-1?Q?nMyfnM8dvNi6oyBmKOFXKQZ41MI8Itk7CeCsNv9XV4NwZTAtjta/8KoPyh?=
 =?iso-8859-1?Q?Bg4AiKXEzdxmpZc0F96vKp4OZJSgO48si5CN41BWLdGYTJKoCt5baojBfj?=
 =?iso-8859-1?Q?01m66Iu2AGJCD3J3ddAnEFm76LbLK7GqFGHnHkXSonastN4ElvH/yfqNDG?=
 =?iso-8859-1?Q?E+Mh/2LGdabkMLAdUlGI3CAn4e4G+0Ebe+FcI8n5EEL+2SaBe8cMbeHPkN?=
 =?iso-8859-1?Q?TxdQkW8Of+y3l/krgBMDKEoHyFDfEQvhblCFqDWD3G1NeboYplbZkW1wxQ?=
 =?iso-8859-1?Q?+r31ivCaXwAz+mhyutsOJtY4yjLRw7GBBZYOuIJGyFMqyicg2gPqpEMbnH?=
 =?iso-8859-1?Q?Q88coaALEZVEDm3on0hXU9KWfK2eVG838JPNsczb66b8XXM2HLqfXHMZgK?=
 =?iso-8859-1?Q?oPPqawkYUC45UBunN/UEbZ1GIKj/2pnKg89DpGY2+/tnDUKPGrsgwTIeRa?=
 =?iso-8859-1?Q?oUJ2DpZ3yzU24emGo/tkwy+XE0pyUlU2q9W5ZoXpfXDDtgYoROmATIfOSj?=
 =?iso-8859-1?Q?l8AG11lNoNHvDUNwH3DHLI0UNtF1gqAg3dUed/qqATbrkDSjeAm99V7TLl?=
 =?iso-8859-1?Q?hkEpZ+tjQHwnPNp8AIUPWg143xCducn+9bu1n4Z25RnxeGU/RkPWU6jIa6?=
 =?iso-8859-1?Q?T4qesTZWeJSSs3YAhNmCivVZgG0W5bIohDTJW8oE04ZDb6Eenx4UcgEqPC?=
 =?iso-8859-1?Q?sneCd/2yUndfhn7yB/rgrKWDdFNbxhmNt1eQiDMm9YyUOY39oGaEJOW1Yz?=
 =?iso-8859-1?Q?syxCruJEbvNiyF1nbzW1YTxKjX4p/HlaTeo2VBpjGb7pX2wg0nlTLLJuSv?=
 =?iso-8859-1?Q?iPiuhyJeIIzAORMBU0GBymHgKONi48wYEoRTNmRNezME96OVNoUfU/31ph?=
 =?iso-8859-1?Q?pxLqLGDnlnIkdejKR21Q53QHvXUVkYTfo+MSy8jGw4NvHcsG8JldBaKeBx?=
 =?iso-8859-1?Q?GrVSrGa97zhHs+RszNfcvd1uTbusfjppELtEErVKi2IV8NgZVwGwv+zfNa?=
 =?iso-8859-1?Q?tAwlxJkrSPQmEzVrCpJvt+y8MLna4/PJ5uO1hpwA0jau1QQuiCxM+CZFBM?=
 =?iso-8859-1?Q?ijvaImR+IDZGB6hTNH1Z/ahnza7Ih5/nqYUHne6ffnFNKorPhXkC1c6XiG?=
 =?iso-8859-1?Q?TfAlq0qD4fskRBPQ8DZHa+FXAGFd6t4XOC0XGux+90neqdHjJeZFnUw09j?=
 =?iso-8859-1?Q?tXQQ73JpG5sJL4ULpqOeTU6Br2FXTPTC996JkSRO2iZbpM7Q49G4Rf5P6E?=
 =?iso-8859-1?Q?SxqAGVwtWU5mHsEoyb5kV2nscyKjovxN17W0s8JsGnuLCfXKCoitxi+dr2?=
 =?iso-8859-1?Q?W/Kf7pGglG7mH+aKFAXbHNvaOX35c76Q2YRR3Whl3Bn+/ruudrWtyxbZ6+?=
 =?iso-8859-1?Q?cZBj4lWDj0xeQtZO6lJX1OVph4l2dEbk9rzg3wiqRjFeTpTa50WxXBrJOQ?=
 =?iso-8859-1?Q?ZqYyGGPbrY3ADQ80b+8fOkcG5Uow8atmkc98RE0AjNvBgGZI0u0Nl+qsEU?=
 =?iso-8859-1?Q?aFGxg1oF8IPNz2JPgqVyUNaDtq5OeWWYyXboQIsyqBNSif8DYclP9ZUyzA?=
 =?iso-8859-1?Q?ZQzWPWZFX5NiRxz63ZxpZt266u9nxUzcOK2fpnHI921043PgVLvjDn0tSG?=
 =?iso-8859-1?Q?SciQRPi7ng=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ckb58YFGX82qRVXoYjlWPEdvXMsqlk2wijFnpJigC2elT/+5Md4dpIk/zObeO+d8CiGjyc9BZ9WHMgjQdjv/tXzSABQcGG+FlLUlvvTQ0Zq57zJBwk2jcLxn9ybKOdgRrnZW3KeVwgfqM3x3YGC9tvUqpBSMvCE+cN573veIeb2anLTcRbNYEdC19Rka+gbuUs1X5dwuE+aJFXbOfb9YBcHpFkn9SSrAwRKpxVtPHEcItTFDwyFYX30kiMVAGW+s2QCbot9w04mrjGRDMV/gYlbhbtdj3jRglyag1pki1mpFqU36F50EXxYrzuXicaC3+Z/0lLCi+RCwNTNFfBbfHQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce74f27e-e37c-4244-c7cd-08de961f8c9b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:05:38.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpoxrpGR919z2+JioTQY47BvIidICHSbP66Q9nQQ0kE3fX3XmowyrvGtMnDIOTnr/dnXUsmbQR0wEu1AskoXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7389
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5MCBTYWx0ZWRfX93cFb4sLtwsJ
 13alfBhYP1HsyOfovkyBvxhJuaRKixdmS0jL6MGw6Vbh3g4D8Af0RyYbxAJ0pox2eoyxwlLM8y0
 Hzkvtj/9q1nd5217tolfmEXBi1awnyML+rd+LjPImamee1fIPCo6+32KF6o0tWBiy1LSEKVI8P6
 FQETOQOkKq2Jy7sYU6b+BEmTSrRETwBaIFGmFhenn/8uxQ02OL5SP4+fm/RFf9jma65l3TgkNhQ
 MqBDCSFo4RGpTOLCFmFvXwERxLTduXZfkipvIJekdU/ZH1IXiHw4njj4zyJxuTh32mrz0fdZCAc
 QqiRn1Uv9uA/2o4oxYBInd4PJ96RVBRG2Njf/Oc+VqXa2IJkYMAUL90/ix+e+RdC1fEaXQ9kET0
 ZQbhW6myCT99vIRlyB9PSE9M/xUk0zt0z3i64+935ist0DEmhhGDNLnakXfoPBMg+qoAgHw9lNz
 4RnILQlfJuaKBNhxazg==
X-Proofpoint-GUID: T8--iGtFj5Ac06oSkVmI_rtvGy1iNDeO
X-Authority-Analysis: v=2.4 cv=VrMTxe2n c=1 sm=1 tr=0 ts=69d779f5 cx=c_pps
 a=gVSWREVB2+MMVoEXIx77hw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=z2Z0RSKEEQ59HD3jwhUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: T8--iGtFj5Ac06oSkVmI_rtvGy1iNDeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 09, 2026 at 11:53:58AM +0200, Cédric Le Goater wrote:

> > The existence of an incorrect and meaningless warning is my complaint.
> 
> I sense your irritation from across the Channel :)

:)

> 1. quick one:
> 
>   Return -ENOTSUP and test the value in vfio_region_create_dma_buf().
>   It's cleaner than masking EINVAL IMO.

Let me do this one now, and we can look at the capability one later perhaps? You
mention migration but I want to get that working, so might be a bit silly just
for one error message.

regards
john

