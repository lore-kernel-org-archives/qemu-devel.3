Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A047C4452F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Ys-00087S-Hc; Tue, 21 Jul 2026 08:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yo-00086C-TQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Ym-0004lT-Se
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARrlA3214231; Tue, 21 Jul 2026 05:26:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=A10H2/g52r6c30Xu7lLfyHmHLc11YD0fRAPYpUi+Q
 /Q=; b=IzPFQCxBO4q7sFNg58KVGmAuwLY0o3mXdnpa1b0pjpQIsrZ902J2w5dAa
 JHYtRS3wAqOCvMaxferxOwbdQoZ8Y7ewtiRx/XGH/nN5/nRQ75Lm0HDzLp492y7y
 bkozWE9TAlnlDiPl52NIA+P6SpABkTw6vNYWOQcZvcr9rBNKVae1oioZ3EY/BZG+
 4oxiPPFXGcriLb65UyZeIX/tbBEujDDsAxGoeuGqy0guwFrqW+dePUn/GKaihynD
 fx4QgGULb6wyi2VHD/KbWiSCvNKaJJ8waDRmGPk46L3g8pwBQlpR4xp6NFRK4r7M
 r5TxwOJMuUCUgWawMTbLLnCLFgzQQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023093.outbound.protection.outlook.com
 [40.93.196.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xean5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1BtyVQaF2xJCamypY7aZgsLBSHL4a2n61LLPnVFQEMQ4h69MaDvgWNGjcCXZRhe/OQdQ9KVg7jg9Fg8Vz4hyPCMpxzRWNlJB0RW4LHSv1ZEHZZtT1wNJBkKsr6RmTGFDrA5NuyYgsyRJ6KP3g4+VpZum7kfXV/nE1figpjAkl+lb4bIZ/ObBQo2D4qwPhJu7gU+TsDBx+QJOM90QP8wJssBQbUXOt7FiP+OSCvbdTXVXp9vgbKiasU8j9hrk9BGq6VIcrWMzqdCNTTnI0B4vMmgfYZgHb7PdNVNHGgOXOWlTgo+8QF6d0EsyqTI6tiguyUE+b/OYYxF96NGdemlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A10H2/g52r6c30Xu7lLfyHmHLc11YD0fRAPYpUi+Q/Q=;
 b=Mh6UC/bOCndHn668BbCkjmfTKnJP6BFMQM3iTsx2eZFDkBXUKmbLGtDZmUb855dreRCwyBmx697krIzEVM0/G9bvo2AUu/iY9t2yamKfoc5BRhNXO7/IJViBq1rViBHRnh5gb048SNKAX/CYlWLs8unXz0OB4TanrXo+6q97OJLVziWT/45E312wnlqvcVr4nrWO07gXMfDuQUc7PpzG7oDEdtiK+dpbELO6kYer/cCO3QTVsLew7t5bMhOWxF9waMRdhtsix0kzQkcfDlsLbccvLrPDluHbrLdM09Ph56DJtPkJGu7KiQN+KBqC1AKcKkQ9JvMIg2RpKdwHtSiN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A10H2/g52r6c30Xu7lLfyHmHLc11YD0fRAPYpUi+Q/Q=;
 b=tuGJX065TZxToY+9yP45kBhAfLn+qB1g0r83p5Ohx/g5Zy0GrnDv7z1D0nz9o1WtzPRH0X275tA6MCiqRzqfmhAE9F1VBKRPtWS4xBA6+3a529+Ihi5TzR7iZpxlUJlyeecIZtGbCvUh0mE/Z+pdQ9V2tp34rSofShemJdKW1EcVO82ijQUkRDvBWUg2ZyXhtRIAPKugXIcPpiLJ6PsL6m5QBV4J/dpA4O3MB2eiBgV7HLDmK1TqtsRthkKsn4N8v9tV0RvZjwCznDd6TvGFHqeZ2+uVNkzlM15NZi1A62/VpmDoJipOVBy3Cmqc49RsNQgeLpsVegUrRhxRlsZhCw==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:52 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:52 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 2/9] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Topic: [PATCH v3 2/9] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Index: AQHdGQw1GOZY1dJu+Eye/qKtJW2g5g==
Date: Tue, 21 Jul 2026 12:26:52 +0000
Message-ID: <20260721122643.30985-3-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: a5f259fb-0dad-4b02-b69a-08dee7235859
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: V1RFsckgo9StZvfLdH5HYs4kADrMP7aKBwSo1KJLjyfpF8c9BMOYyc5xkhYa7h8Mfotu4HFf04BR24JMCjnFimKdQj5MxelbT6F6ldxRPNyjk4sJ87H6e9CiSg6suqv93uwrp8o4mjZz65DmHpVUwCTCP/AALGOfErvktG754NIHEMOPGCvTFaWQAwVWU2vqNCKEUBqDaanz/6H8/q0I7YAOsoz7goO3hhXwXEIbLXgy38oY4ZjnfzQS2OELKRKg7UbflLnpkPpEQHGq0pWA/3mDcrm4aeAGtMaSayPaXRRVGzsOILiauy/BucC3J8o25dDxHGYt6Ap35eAjD5DWZTfRHMrWcSYnuEZyXWFaRbjmnU30VBb5WOMMhZcaHNfvDKVd+1OKXm3Gdhc2CrDdSIWiNQJyFqa7WWsoEsrpOlNfwr9G61YgK5di13dCIN5Gcx4eF1FKWeZJe/f1LvlQV1JfSQDZd+fshggIcka5dRRAVt24DKKNVZlaLHvHPIb286UQDVZrSEZksF0mflpfbiH+j/KjfKnowah/cexF+JESQUCxLD4wLezzzVkls6tRFT1TKkht/vkkS854fjyyQ43qIGdnUsqTcWWwMvqN0pUE49h7so9Hs0ufe9M/Q9Nyp4pr0GQP3/B3UEOdpmFN6kOwcoJ9So+P2tZtMy+SpEEivQjS6bgoCEl+1gRFYWyX/dzBDiEjfo+VRe5g2YMdKVQlRiY1UmsRqmgKH0gSJxo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AcyAqFW/7akJhQXF0tpDhjFLLtT5tn5A2vPIEbL/1u2LcxdZvPtdnKH9jW?=
 =?iso-8859-1?Q?4d/4hDrLDsQu25+tRpvd/MtMVUHTM1FyHzMZMgXlSONaQYDK5nka8vekSj?=
 =?iso-8859-1?Q?kDfnvEe2NHd6NBfPTskKnrkLhr/NyxI8VUaT8lBt6Z8aqqV9vJs4w+GzKS?=
 =?iso-8859-1?Q?i6mwF73HiUQwjBUayymGEanbJLIXxTvPJrrxGXeYIocfFEJSYI9wiCNnaR?=
 =?iso-8859-1?Q?jxlh5Lt9G4YuAy9W3EdBnBi4E0NTBz/ZcSyRn8UKDhGVNuMtrV6mPAYICi?=
 =?iso-8859-1?Q?TZRRDqXmkKABd2yB1YMOZkvGiXAITIEt8geYV6aqAN4FrHXN1uMpt8EL5P?=
 =?iso-8859-1?Q?pa/0eIPNjGkprVxFtZaFvHSO1TkWCtpCbhKKXFFg4RUfduP4oBX433wQ5V?=
 =?iso-8859-1?Q?N91VuWMOF3kfniY+28824QN8OMPV1g9bM7tri6SqCBHtpGzi2LjaTjdUqi?=
 =?iso-8859-1?Q?vxtOv2D+2SrcqazeyFgsHdoT+5S7MZUFg6PobW4/LgWbQnFmH6HRWvrcw6?=
 =?iso-8859-1?Q?Lhj0jPTk1E7r+ecRf4K0YguuRbzY1DRtU1ofV2y0ZWAvqGsV6FMedbSGDO?=
 =?iso-8859-1?Q?jBLG8frJbFW0Y3pnHtQm/+jLaBuab4RtmiVD7QctlHvhF4t65aAvEbeeJf?=
 =?iso-8859-1?Q?OBuoUFS7xDTbQhMqz9Krjy3oNPQSnlRwKbIJSckX2Pmqh7ssHy+HlGkIV1?=
 =?iso-8859-1?Q?XX76FPzq+TUOIpswpJJlFhWqWkKAW6o0+KYCV9MLTIWjNOelGU4K8GH9oZ?=
 =?iso-8859-1?Q?yUBN2H3vG9fDXtibyDjndoc6881fB+KzWGjeD/4BoBE3SQbCAMBuGrtAo1?=
 =?iso-8859-1?Q?066A1TAH5xxwux+JZmOb0bHinQpvDlRqkpFhlfII44fI2if8lEcGjz4jyy?=
 =?iso-8859-1?Q?TbKIaBzU9SxeSDvMEo70d0WPWF6n73P9Qe/f2B86wNxbJbCW8zo9gefzBs?=
 =?iso-8859-1?Q?934h423TTBdV9bLEXz0qHDAirLndaa/HqmeYqBSbZXfu4nXpMXNwjiSxtp?=
 =?iso-8859-1?Q?mSpqvYuwHOYCdH8TewjusCkXbrGhRvLMq4uaaqygyIPZfaaj7ipPPneJuB?=
 =?iso-8859-1?Q?CS6XfLoziGb1+zz6uvePXY0KZaDrkJrTskZNVIR2TB8biohTnFjTTQm8gF?=
 =?iso-8859-1?Q?pAlAw8Dma9MhLx7PFjtqBp6tUD8IspNHVsf1pSrB+OPHLbhARS3UbwEElE?=
 =?iso-8859-1?Q?3HRBYF5w8XQY3FEJnnAEExtkTFgzK2AVe62H1gg12qPEFvZfIi6i1m40ME?=
 =?iso-8859-1?Q?nREMk37SBS92bOwGe4fDswVy+B7wjh8GtPRZfvAMg2WwuWJLAi9CE+MZAr?=
 =?iso-8859-1?Q?vqRQwZq4UlfWKB7Vh8L2VVTXbV9i5QZNPvurovV+SrN9rj4MFBbMT9gkQg?=
 =?iso-8859-1?Q?K6SyAChK73/q3WuId9PrNtwdn4eaOe1eT/BTvROHTrVRlceHLuxL8DVnzD?=
 =?iso-8859-1?Q?lTHjRkMIrOocBRCyoQspiMlKw3IDBtaP/bpqfKWMEXr7v5tMJTT6tADuYq?=
 =?iso-8859-1?Q?agaF+7aB8TR/5OVfSQFqEujtpGii1A+zEms8O5AzXv5l+o5RYlo31TaxPl?=
 =?iso-8859-1?Q?X495uyNj8cKmzEdfHQkHrprT3dQ159I00U52zh2Gc2gXsp04eDzsVesSSU?=
 =?iso-8859-1?Q?+ylVv7YGXa2gMk/g0cIEE+PJLoHD8vlLyu/6g16jPyRqhrVO/xZiDCs/sj?=
 =?iso-8859-1?Q?D1+NVMrsxHK1rrqhHhFjV5sAPjuB6vGLwFSJoh7mxeXnZlp3LL35DDPBt2?=
 =?iso-8859-1?Q?68CcUrSfH8zbYxgl6mvcIQER7miUT6UTaBh+JTAN2db5PQZTlSMTAcpqZN?=
 =?iso-8859-1?Q?e/GZDMek5fgQAfWCZ0ozlGtGShdB0w0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: na3wKP9EgYiV/KLeO2iZmAm4jBoTiYLQofr/30UjZoGcyUYQkem+uKl7xzq3cxOyfEcwN4uk9mmagxtSUXoHfmAkKfjVuIDkciJmSxcBWFQtuj/9Wv6jxtcNvc8IfWzLzmfKn0TppyFSF9J1PfZOIYb2hFAcrFjZBBiCSbj7rKzSM6EzFFLZfPMZQhuh59W+jjhjQiy0i65ZUnm/BdE3Sgls0nfdlWkr128+GY9Kf9MSIrq8cgXCbKR/84e7pIPWaGeVMk7WerStcGdGb0v6loW6wDb2sH2mX+jWhIGE9bSf0OrQ8xwWRKDKJHV61g3aRsRxMCbmkQrZkDt0R3Ud8g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f259fb-0dad-4b02-b69a-08dee7235859
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:52.5184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRG+s7eseh+IGhlL3ltxcjC+bhhqa82sktZJRZ8lQTbr5PRjgKSeG4fTZ5A53f1NuFBEhZedy140O+Qb0iva7P/jGD7fqHxWkRQ6jFOHa0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX6OYKuzsI0NiI
 qz596bjRRHjQpbjYVRosGeCXSN9Axk1nqQns0ZswXF9ewmjSU61AXIGlXc4qr9GYvLTmbydamWl
 kDDJmecDXhwIiFyMGA8HB1vuzoojqI0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfXwn7V2vYfno3C
 ftLxaJRMLUx4OLJwaBYKc2v1ZlwZfyH76jyI0CpYTiIzojopQidgNYoJ2vFIiKoCeB3t2974ptl
 ngztIbytEbH58E5wgdPTNtTKc3pgcCctV3fOclT+NQL5rVhJPaoBA4oeoCN1fpNQV/HEvbCnzBG
 90EiW1RllPindfdQCZBw0E9TOrxRkCo5Prox5mGFvCGBCbcL418d13x2PAhR7X2Rd2sOIgK4g3o
 EL+7zmpmInhCL22o9EIIO+dqiS0ad/CM1Eg4DxBkePNB/WlOCGEQbCATYunOoh8i2RrP5UHmoBX
 3tpBceiDmql3AqHCEvDhKXiX2xT1ZxXtkEU+ddzz3f+9wWjOs61jiP9rFz+/iAHu3xr3q539f32
 oVoK39+8OJjsXZlgIIfjwaWmMLn2ex/ZkXKYrJXi/tArhaHxGc4sDli8eyAxIGgfCQ4d0SwXsNV
 WCJpEnos9lKlRa+i26A==
X-Proofpoint-ORIG-GUID: CAXN83KDQrXtRIdo3gh6rTPLqa7-4z8x
X-Proofpoint-GUID: CAXN83KDQrXtRIdo3gh6rTPLqa7-4z8x
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5f658e cx=c_pps
 a=0mOrEJ06uaCo+Tyi64Ng2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=kwlPqA7JoD2zeNbm8cgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO=
")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index e58167a818..8350bb2c01 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -137,6 +137,10 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         error_printf("vfio_user_get_region_info argsz too large\n");=0A=
         return -E2BIG;=0A=
     }=0A=
+    if (size > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_get_region_info argsz too large\n");=0A=
+        return -E2BIG;=0A=
+    }=0A=
 =0A=
     if (fds !=3D NULL && fds->send_fds !=3D 0) {=0A=
         error_printf("vfio_user_get_region_info can't send FDs\n");=0A=
-- =0A=
2.34.1=0A=
=0A=

