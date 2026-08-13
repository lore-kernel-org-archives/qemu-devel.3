Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D602EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXlp-0007vP-Ae; Thu, 13 Aug 2026 11:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mikail.Sadic@ibm.com>)
 id 1wuXll-0007po-MR; Thu, 13 Aug 2026 11:55:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mikail.Sadic@ibm.com>)
 id 1wuXli-0003C0-1E; Thu, 13 Aug 2026 11:54:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWjSI2768702; Thu, 13 Aug 2026 15:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fj6Bzb
 2lgyr4qtaIlJwgkQTdNMH1Djg7dKrFH4RRUME=; b=nQJnW27SpvRhI0qy0vh1j2
 zg81xIRJ3/keOo8BK5lKlHyvi0TzrKp7mnYrnJKKkD6j8CLhxza9WfN2q9Fdk8Ug
 bnnLAy98ymYDNaQ082Cy53981JrxfS6UVZ3Kovuv5D+K3thgqbQdG4RCpcQIwm7F
 XBAa7D9BwD2evgjfndHjP61vkYnPspGrPcOmJ6SzvohRrPowXUvGcyX5eCVask/A
 EgnMPTYRj4aBB2gReagJnlO/3xaQ6ferPIEEr+R/5/I77ja+XTa2Oh4fvyqJzzs7
 rNHRMZILIAztBNovzWX9Pnwjk92HqW66GOdE+2d8RypU76FVuYfJR/h19WnMlIww
 ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwfnsa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 15:54:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5uWDJ7DVQTQsHu6JN66dBMO7wQXYsEoXHkc6MsI+Nwqvg4Uu+dX4NW31KQez0z/A/07ImWnYmWXiVucbeR7j/2TS0yaZT47UA1ichBbLN8ZhSGGB33iNJMNzk9FUi07Q0rV6r2XWUtNAWAHCmthWjeFOpBk8ig14NLxtcJk7urJi4ENW03gswmuxxCfTXAqzzMEdsK0AfPT3w0uoGYNBlCO590eMGTWshD+8BGsErccJqQYAaGjIqzXAPNQqhjrtm6UdqDrV6y/DwC0gxcKiPgWH4V/kEu+8l8vjlxAcFYqriiHowpxnJnR6akI2jBWCuQjYwWhCxfMeFhzmW3NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj6Bzb2lgyr4qtaIlJwgkQTdNMH1Djg7dKrFH4RRUME=;
 b=MfGJPWobo5Eoqmq1gptoFC3DVeAkLZFq1y4CEDvNTHmiqb3vggp0SXxniHf22eTvbJtQrOpTkIdxjJBimrXHEcHB1K0tROSVUtJn6+OsuHU98ZcGJfv6SKK5xVu4XZXmRYXkw7aygURZH9rd6V+Dd1gnveCGOX5xREn7tPvN9NcMg8xpBSPfV6APITGVora/znudACvUWdPh0OHOMaEQprAjkbH6a4bc3tWwq/bCPhfiPf7hDwa+4aMujVa+JOEQZF82kpMvs/Cm4twuFka5Vxk1nMQNcE9qsLZmKieNmyWWWwpWZ5V88zkBhhNPLy5o/X1CQSkCi1nSwUa2LwvTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SN7PR15MB6138.namprd15.prod.outlook.com (2603:10b6:806:2ee::19)
 by CH6PR15MB253446.namprd15.prod.outlook.com (2603:10b6:610:305::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:54:21 +0000
Received: from SN7PR15MB6138.namprd15.prod.outlook.com
 ([fe80::9ad4:d1d3:3b3b:e4c4]) by SN7PR15MB6138.namprd15.prod.outlook.com
 ([fe80::9ad4:d1d3:3b3b:e4c4%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:54:21 +0000
From: Mikail Sadic <Mikail.Sadic@ibm.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBus
 block reads
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
 SMBus block reads
Thread-Index: AQHdKwJqkWkcyoBADkCDJjjo6H+Egbabrw9ggABuHAA=
Date: Thu, 13 Aug 2026 15:54:21 +0000
Message-ID: <SN7PR15MB6138B5314F2E7D110245815E8ADB2@SN7PR15MB6138.namprd15.prod.outlook.com>
References: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
 <TYZPR06MB49802BFC78FDFB21489FEE83FCDB2@TYZPR06MB4980.apcprd06.prod.outlook.com>
In-Reply-To: <TYZPR06MB49802BFC78FDFB21489FEE83FCDB2@TYZPR06MB4980.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6138:EE_|CH6PR15MB253446:EE_
x-ms-office365-filtering-correlation-id: ee9725ff-023c-4e8a-b2af-08def95323c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: QL4Oaytuza7N3uaYM9xDYr8mvnJOOxpL48RXyzuG7ACar826ORxSrLZm9KP00CIB06nj2G116mYm+C/+vqMsN4SIzyBVkPR3lAIH4W/vkxRzMwiGCnG5nutT57rSowvvNNu/y5By3hrmhgkcPf/FY+mBuoyzc+yWndolkvcrmPC0twOkA+/cKjKZv3EniPR24hAwqJbV/uX7DvrZFPNUl7SD/feSwI/M9PGVZH6X1LOgl4C2bxnEXZzgmA1faNdM1/22NUumvVhkNSbNOwbB2RVi6QhJ4z7roSXY0ENeyEqQj398TAqRLIOVnDzg1FxbIJ5ylocgVuSoMcv0VbUvYUNaEku+D/nBZvDcSd8wurmOCs/Xf3F9Q92s0oppf0sfYvF+XaHnxSETsID058xxk4j6YM5E5nlEqT0DcmtLvIAXfCNMFsthUNiNyYp2p0CvY9ZCIic7Ahg5Nvt86kxQ9kx4K9h6GSDkgxkghnd4I/mV3ylJjUMuz5aIB+TugsacQdfIPXMBx3sJKXwukcZFo7FIOoGK9R6Qx6UGRzr2DU6Ky5FpiweMlHFt3fYiqP6EpO51jHD4UAv2LSJ4iPwHUtfNo5a5zVsAMmlNMB69MvrVX9JrikA61tzI1wWaT4ltOL5nFs/GDzdFKNCCggSy7bVDBbp4XFQ2dyquU6aH9BvhJ2TqHe8dpDghtxOWD0s4dMudcP3lTFY5Q8h32TBXZR81w6Aa3KNtFFkf0lDlId8ZAVpdtqRhY2/8AjyIqNtK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6138.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J1o2qbt6FDPjs1Nb49F5KKz32+Hs5pt+pP926phmDPlJIk5Kr2UT2Mxl1W?=
 =?iso-8859-1?Q?MkFvD98cewZEQRJUMFiRr2cr5otfYSSZbGumO4q7xTPbfYJIJI8yZClbf3?=
 =?iso-8859-1?Q?j/tiZloSCWjeRJ7S98tUJUdb1bqCRYIcRyccuTrJ9/wQTOXE211fpiiS7D?=
 =?iso-8859-1?Q?fVEiR41UoC008L5iPABP5smxDki76IkNALReBtHNtN7YYolwtzVLmbLvSq?=
 =?iso-8859-1?Q?E1mxV77dxv2s63p0o7R+1bOG6/2kD82IElhD+rF4RHUdAcg50ZgsFrU6BO?=
 =?iso-8859-1?Q?pjb/Mgb/rV4qFmp05twJDpIVl2/iyNi+7/6ygH9x4OZG8R2TlokcRoQol2?=
 =?iso-8859-1?Q?Iu1kUEASRocZRmkUyiVWXqNA6LVZZvxpgX1nmu/w820mg5WhBWdhkoOxfF?=
 =?iso-8859-1?Q?jDEW5UcDbwq21BWuNrrZy2XK/i46MY/rTW9k/ruqvx4M5t55qqyLcDUGqT?=
 =?iso-8859-1?Q?KYPS51ngE5EPib00injJIfQRebL5YatNJTYd41kqf6LI52dPNbsWa0UkzQ?=
 =?iso-8859-1?Q?ygHC/51NjB2PDsNJlLt4Y2CzQTERJw0oikOOwa3r4bJJTApfs7N8RKwDNL?=
 =?iso-8859-1?Q?xFrhL/O3RAFcnhA38Tx/Zyn/SIR8sG7sk0g//s+F/edBHHrH2L5HYnCEHR?=
 =?iso-8859-1?Q?XPQBvsox/2NvAntuuSQyaJmrjRmhMue9Spvg5eL4Al94XeUCqjw5bVvhH7?=
 =?iso-8859-1?Q?9c/zaFDYp2l/IK5GAFbBgtoJoTmIcgG3eGdd8HxmYsjdqivNZpq4dEQfTV?=
 =?iso-8859-1?Q?2AwBbllgpBtgeHn2osJ7XhH5mow9PxVWHBLkKo5niEF4TbT6ePM6QOygTw?=
 =?iso-8859-1?Q?hraX9IEvwx/3qF0TFA364RbKu56YSzXnOyaUutY+rEzJ30lhq5QQqkM6OG?=
 =?iso-8859-1?Q?Dtz31X0vGSpLEOGdxstaYD/awfwZNv/9v1DtW3XMNKJZMr0lpIvl1zzFmP?=
 =?iso-8859-1?Q?ZW4KoS0tOOspNhOSJzeuG8SRvZm+otAkqI3QkptB2pupdKk+uQ0TGLrPuz?=
 =?iso-8859-1?Q?zcqDRA7uh8KUixbjU6LlgMbjAcQqPNqIE0E5UrZUWEAKxestGV5zkHq94y?=
 =?iso-8859-1?Q?K6lA+XKjvAhz/mFw56N2pLiNsN5qMGc97GpnFgmmHe/lpYyr33b2PidH8c?=
 =?iso-8859-1?Q?JLtZO+jRyCiMO+X+VL7BwhxWn1U5BSewZwyPcbC/yilDI+gQg/pg9MR99D?=
 =?iso-8859-1?Q?By7B7MRjjkEIDSlmAugxToqlqF1VhIaGz2o8NDi6KJDmoA/GkFFNaaJRWn?=
 =?iso-8859-1?Q?nU15770uxF5O+1EOEdk9BQMMdZ3BbONy1jh+CxeYGntkKusf3J+DSMeUWk?=
 =?iso-8859-1?Q?k+x31wW6q+ruhuYH7EDP/LN+GiEdVUB1UQ27wbFvnP6YbllId4ZOVO+80Q?=
 =?iso-8859-1?Q?H97i52rZmODzZrzc1e1Ui0ZFVCJO7zX0e8lgyA8jSUeExEVhded55XgIvN?=
 =?iso-8859-1?Q?KiiIHMquZSqrGwfDtl1PLZnVK4ds+7poKLCD9zEqDjC73/rRgKTsknacmq?=
 =?iso-8859-1?Q?NwRs9afjxe6O5pwGrQbXXMTePhX4215jakl7IJMnBCs3MBDdjTa968KHbt?=
 =?iso-8859-1?Q?7ZNx9+gRaDgW07h9Z/rWvlJnDO4CuL53HOrExyfcbv7+M3zitrLkmtYkhN?=
 =?iso-8859-1?Q?reygqpsJByY67QcMuhA6dJ9BhpKz+VGdQLp+b5xWRikXfIET8uKNvBoeBk?=
 =?iso-8859-1?Q?0DE+XASCumf3rpHNDikxQEJefT9aBHbVxQ6bmTq9vWh3yBJGZRB9MbcGDC?=
 =?iso-8859-1?Q?9wAmjpAM70h2hnrYfr1V9NCBeHDYqh1kjKathzttp4Ju5o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: osBbu162x1khdc30nh3IHf8LXqPgOVtC561z0Qnfhii+gHyfoL0DL/WkWvDdk2nhH15lCu6hH3wOD1whA8cDya6rZsfDWnEaL+EUigWIHoUVHUIvMiHM4MoOp58qJcxx9OU2o/JHe6dnKuGaiLABDz6VUGoCBPq1YfatQ3+IwwOExy8paIVys/9bgN2iN+cqHM9dzJ8/qFLcrX5gpuD+Fsx1DVVD4knIdtiGSaNyTMUvXy/cUSVBYqkHndEKSL6YirGUVstnFjJRevZBPEt7gzYheMWfDdXJF/zRGZdLXg3qFI8Y69FotXLMqn5ILPLmRUSeMjDKI6b70Chta6UhCw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6138.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9725ff-023c-4e8a-b2af-08def95323c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 15:54:21.1024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yr7uFuvmj2fbKskHNa1t1eZDOlhw3iLJ7mBDiwJvz6/Rg2ht8dudHkXOMXoSOKoopQgY2Y5O/b7HYmHstj+dnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH6PR15MB253446
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7de8af cx=c_pps
 a=GQEFHjoEDIuuLG6+yye4Mw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=V2NxCb60AAAA:8 a=aow-egSQAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=7KBfExy5AAAA:8 a=69wJf7TsAAAA:8
 a=pJGLcQOVIlwz5cADT4gA:9 a=wPNLvfGTeEIA:10 a=3L6qF29SlnrayQqPM2jZ:22
 a=gFNbaldVC-z-bsjSTzMo:22 a=cvBusfyB2V15izCimMoJ:22 a=eL7OMsOqQ-6kYQPn45L1:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: f8m-FWXDLUGld_YMIS0WS53KajwTrnPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfX3MEJapLLHZyy
 8EuJcXqIfJ0dgtuGAp5jIwqgw562kb2kQx2tl7beNhlqwatGkzyCsU7jgoAAo7r/GEYdA1WD8I1
 C82HZF9VM7V3Vl+FRHfk3osD8Da3dxbcqgv/nYPnlXDzcrjeBhH356Kc0tXmJeYxqWGieBgZ9y3
 wbXbObs0RoZLbl+bettaaCllYhmVISL1cXVDY2v4yjDApPwYMBZNJHp4YXzoBPdlnBMgFXDUicZ
 crTOf8WqXJXWbQBSa4zynHVUBQ5imAOSuD90ZS9AUGs6cKJHjLy9z0W9XGIg2Y0pcNzlXF46uDc
 Pavm0thNT+HBx8949TRqxOQF8q9zASZB99Rq8DRT8p1ly5Yyrw0cSjFwtpUzHg18Ebd5GYiE3Lh
 N2REDhjifjDqeBuhtV1KmYy+QdmiFKOWzC/mzV8cM1CiLagVut+fwOlmgHrlCPIidLG2IMPYUTW
 38diILV6q+UHCOFJjug==
X-Proofpoint-ORIG-GUID: Ufgv9k5W0xzJgWjQyjGx1jLFBgslJfbl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfXwTCGsm+laxwD
 gFbsXLXFhC8O1XKELhd9c1R/doEERvuwpbXMQGni3wv/2nZ07bDD0aqzcYhp609CfnflWua+7dI
 VxbRokQ0Efho2zZLDyGkDTZrm13tYhs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=Mikail.Sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jamin,

Tested-by: Mikail Sadic <mikail.sadic@ibm.com>

I verified that this (along with the AST2700 buffer mode patch and the kern=
el fix you referenced) works with the UCD9000 driver, thank you for the hel=
p!
I am dropping my patch and depending on yours.


I just have two things I'd like to ask about (not blocking for my purposes,=
 may be worth to check):

1. Byte mode is not latched. I think the else branch of aspeed_i2c_bus_recv=
() still only writes the receive byte buffer, so 0x84 goes stale there. Thi=
s may cause problems down the line, specifically for AST1040?

2. I believe dma_buf_en reads like the FUNC_CFG_DMA_EN bit, but the DMA-to-=
pool call passes true while that bit is clear, clearing it is what selects =
the pool. Getting it from RX_DMA_EN inside the helper may stop someone from=
 accidentally "fixing" it to match the name and breaking the AST2600 case.


Thanks again for picking this up and catching the original problem.

- Mikail Sadic


-----Original Message-----
From: Jamin Lin <jamin_lin@aspeedtech.com>=20
Sent: Thursday, August 13, 2026 4:08 AM
To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.=
org>; Steven Lee <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>;=
 Kane Chen <kane_chen@aspeedtech.com>; Andrew Jeffery <andrew@codeconstruct=
.com.au>; Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@no=
ngnu.org>; open list:All patches CC here <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>; Mikail Sadic <Mikail.Sadic@ibm.com>
Subject: [EXTERNAL] RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received =
byte for SMBus block reads

Hi Mikail,

Could you please review this patch and verify that it works with the UCD900=
0 driver?

Thanks,
Jamin

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, August 13, 2026 5:02 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell=20
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>;=20
> Troy Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;=20
> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley=20
> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open=20
> list:All patches CC here <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee=20
> <troy_lee@aspeedtech.com>; Mikail.Sadic@ibm.com
> Subject: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for=20
> SMBus block reads
>=20
> An SMBus block read takes the block length from the first byte of the=20
> transfer, and firmware reads that byte back from a register rather=20
> than from the transfer buffer. The receive paths never updated those=20
> registers, so block reads reported a bogus length.
>=20
> On AST2600 the driver reads the length from the receive byte buffer,=20
> I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as=20
> valid while the DMA buffer is not enabled. The byte mode receive path=20
> already updated it, but the pool buffer path did not, and the driver=20
> selects buffer mode by default.
>=20
> On AST2700 the driver reads the length from offset 0x84 instead.
>=20
> Add I2CC_BYTE_DATA_LOG at 0x84. Latch the first received byte from the=20
> three receive paths: the pool buffer path, the DMA-to-pool path and=20
> the DMA-to-DRAM path. Each latch updates the byte data log, and=20
> updates the receive byte buffer as well while the DMA buffer is not=20
> enabled. The byte data log is outside the register window of the=20
> earlier SoCs, so it is only visible on AST2700/AST1040.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i2c/aspeed_i2c.c         | 31 ++++++++++++++++++++++++++++++-
>  include/hw/i2c/aspeed_i2c.h |  2 ++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
> 68bdcd0e25..e6d0eee816 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -159,6 +159,7 @@ static uint64_t
> aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>      case A_I2CS_INTR_CTRL:
>      case A_I2CS_DMA_LEN_STS:
>      case A_I2CS_INTR_STS:
> +    case A_I2CC_BYTE_DATA_LOG:
>      case A_I2CC_VERSION_CTRL:
>          value =3D bus->regs[offset / sizeof(*bus->regs)];
>          break;
> @@ -334,6 +335,24 @@ static int
> aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
>      return ret;
>  }
>=20
> +/*
> + * Latch the first received byte, which firmware reads back as the=20
> +SMBus block
> + * length. AST2600 reads it from the receive byte buffer, only valid=20
> +while the
> + * DMA buffer is disabled; AST2700 reads it from the byte data log, a=20
> +register
> + * the earlier SoCs do not expose.
> + */
> +static void aspeed_i2c_bus_latch_rx_len(AspeedI2CBus *bus, bool
> dma_buf_en,
> +                                        uint8_t data) {
> +    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);
> +
> +    ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);
> +
> +    if (!dma_buf_en) {
> +        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF,
> data);
> +    }
> +}
> +
>  static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)  {
>      AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
> @@ -349,6 +368,9 @@ static void
> aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
>          pool_base[offset + i] =3D i2c_recv(bus->bus);
>          trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],
>                                    pool_base[offset + i]);
> +        if (i =3D=3D 0) {
> +            aspeed_i2c_bus_latch_rx_len(bus, true, pool_base[offset]);
> +        }
>          bus->regs[reg_dma_len]--;
>          ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);
>      }
> @@ -443,6 +465,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>              pool_base[i] =3D i2c_recv(bus->bus);
>              trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,
>                                        pool_base[i]);
> +            if (i =3D=3D 0) {
> +                aspeed_i2c_bus_latch_rx_len(bus, false, pool_base[0]);
> +            }
>          }
>=20
>          /* Update RX count */
> @@ -460,7 +485,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>          }
>=20
>          aspeed_i2c_set_rx_dma_dram_offset(bus);
> -        while (bus->regs[reg_dma_len]) {
> +        for (i =3D 0; bus->regs[reg_dma_len]; i++) {
>              MemTxResult result;
>=20
>              data =3D i2c_recv(bus->bus); @@ -476,6 +501,10 @@ static=20
> void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>                  return;
>              }
>=20
> +            if (i =3D=3D 0) {
> +                aspeed_i2c_bus_latch_rx_len(bus, true, data);
> +            }
> +
>              bus->dma_dram_offset++;
>              bus->regs[reg_dma_len]--;
>              /* In new mode, keep track of how many bytes we RXed */=20
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=20
> index 05937a7a0b..c8e6ea54ad 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
>      FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)=20
> REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
>      FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
> +REG32(I2CC_BYTE_DATA_LOG, 0x84)
> +    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)
>  REG32(I2CC_VERSION_CTRL, 0x94)
>      FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
>=20
> --
> 2.53.0

