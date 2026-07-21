Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF1BC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yw-0008AE-Oc; Tue, 21 Jul 2026 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yq-00086r-Ro
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Ym-0004lb-Sg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:59 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARrlC3214231; Tue, 21 Jul 2026 05:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UJa92i5BiHKdWyaLCcknMhJr1mn5dFoF/lrh2WBaz
 6s=; b=L/QgDacc8nf7TcIRqswseMX4gR5I9PRy/Bs8Tyjz13V51VJacrO99rNUu
 e+Oy+GO/S7vJ+E3uSmjd8DfcYqbfsmP39IBN8HWm/8fGU9w7mV1A2Y0YmtPz1tqr
 hzpviWRQqDX2sd/RmrpvUPrq6MRSBzhJ1WMfTbPHMfOjzfPKJHghsTQFNbI43Qdh
 lUDczRGteiJcVHJns2dG8Z27gPFBX6D1CtOlBM2yBflQTx5H5CtmqmX2zzO4JcdS
 Ezxiuzp2QOQxr6I/1116ticcveJRvA71VtpO7Eid4hCy9miPn7pcWeB/QpMPWaNf
 +UvpMjKnesYdn4g/cfknfhEJmXqBw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023093.outbound.protection.outlook.com
 [40.93.196.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xean5-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2rmT6myEamlp8o9FDstnlJSwIIHn8H+Azjf3emyc/7rQVBBo5ofIrxv4DkBU//Dn0xTrcExjSu4iJyZmR53+WI2j6HLVUKCg7E/qQO0vg4Qtv2tX5lPmUjUnpNYkwYSHjzery5esNU2xjKJ6GYZoPpdnA1k9AX7aEV0bqo/EAtRq60MxNQH5LjQIcF22FuvN90RQ4ScQIo0js9c9aCMOWD2m9/7hGeufmfF9YdGPWO4h9S97uAHZl+4LAHPpL5Tn2UsgpfsWRF0W5r/Skq81cZP7rPzC4DznWe0rjMvAxzFgFWTofOR6h+Og7g24xWxkUzqhCd2XHg3grf+EcF0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJa92i5BiHKdWyaLCcknMhJr1mn5dFoF/lrh2WBaz6s=;
 b=pLui1v4HCfHq6iSRejPqTr2ZeU7ucj57F18lLzEeZTIe3dD3XgyAoNmwWu7MjJ3qs7wqzHnGTzj74SN5DiWxHA2H6Mg4PVEs/pff2KoE/rYneFl9kC2LLu8iYphFkpkYJ+CvZYLxlmtH29wodrFjArfCU0CG+n9QtbZSfmrh4T7nvF6GGPcYuwx2Fvc2B7Jd28s/h+rP+fJ48kupPkvaANENgzOEl2nNOhzMmfKfDhCk+QfnOMN9V8M33dPZPoP+XYXGuqJ3DvsVyZRQle0Z9piw22qX299G7mNVHPQZRVoKPVmiszru80liEu0O5cCAWCoqOuXJ5VBQApf9OL1WvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJa92i5BiHKdWyaLCcknMhJr1mn5dFoF/lrh2WBaz6s=;
 b=VzL72sj7/DPhTiMFA5L0qXyeOLQVLsfVKh1RShAnTIPrKw8tlN5oV5PheOFoRZeFma5Lkq3xfwl+kLEP8fUzbGLuL6U0kN9nLw5Bx2D21sRLYq3C6uy4ijfd89PguOGyLJWJDfe2up05Qjok/QXRCKIdDFgDuWm8wDgB169loFguFOOpD1m4yy/OuNh9YWXjq8hJZlG+yjbjWxbGUy6c66JdCYhrWy/TpS7i0tslqkcoZJPUtFB7jbX0JGalJ/AvvOPShNNGukYHpSqhgfAIrQI9YUYRFx6BrvuISoNkr/RYzjAhWIuwRZ9LidWed7YAn+Xd4YFmgigf3cpsGxBKCQ==
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
Subject: [PATCH v3 1/9] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Topic: [PATCH v3 1/9] vfio-user: vfio_user_get_region_info: prevent
 buffer overflow
Thread-Index: AQHdGQw0LPZfbQUTR0OULgk3x75/Gg==
Date: Tue, 21 Jul 2026 12:26:51 +0000
Message-ID: <20260721122643.30985-2-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 41ab97f6-26cf-4c9e-ce90-08dee723580d
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: ODR8SwCLr6Hmg6C0liYGAciN9cPfa+HH4j2zWFyg3iEDGg74qYuoln+LWSvMNMqozFjBTbMjxAzWCq06EZ6QAPD+XGE1XOzK552ZEGENOgS/szAeNjk9v0fp9pJ/0oHDjjjhYA0xE7iEXkOwron0ENqLELbWJsWk4IzWZzI+XG4hMYkLkdJ8BKzcfkyHYdFpfafNra2pi4Xo0eS8J4lSs3BnlLzwv6uzd/7SrAlzZIwWd+WDFb/WTIUmFtecc8/AhfN90dqHUmeLuHimYaCn0PPETpbnhRd2sSovrMFyeLiMR+YQDg9VahW80e7IrdxOZZpy6BAnImNBx1eXetvsoOHmd9oci5KUzU9Fe0yNeUVPL2nOwnrPi1/Am7Y28AZCC8P7KMDh4n3zk9Wf4k8XYKxfM74cHYxwpecClT6NYsAtw/l6ouPCQW/QR4rmV6Ju4VbtqXyUxe676jCiIxeolVoPCmUhs2x1PkXoJylUoZxPYlC6gyOzdczAxHrbI/zXWVq7j6masVwQVgBKRiGZWcB9lm41lZDLE0mSxYQfXwXZQa7+V3cTmet2YfpQJUhc002l2NKXls5K6vP+XbIvArOalq5KZv+xb2qwqdTCndjqZcNnuzKduV3RjRcNko9kyApDEH0ugb55TzkArdvbmwG/55ISmb9IpMCddcQ5dqJV7hOknijngECvu3afoFCbkeTbBO3Ayx1to7UOmfVoCaMLEfe7L9tVVsdtf+Jj3Bc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cXOM9dxtrM62I8BzO/cSewGtlcb9t4DQppxLy+Nalidc0HlIanN8TTIyvK?=
 =?iso-8859-1?Q?bLHKtwc3pg4h/MQo0z3AECdKSVok5dFuNHpp2tG+cZnAAiix5VwhE2utI2?=
 =?iso-8859-1?Q?mdRuVb5H/pTKSdSqb/OE+Qd1rgD/G+TKWz1hcGdlQdupyel6gxR3KI8N5p?=
 =?iso-8859-1?Q?IFhZLRBU6Ao5H3rcvghnEQjywO6GTQJGyR0PIqhKLvjsJvuRtGW3HH+jQ3?=
 =?iso-8859-1?Q?/U/eWodYizK2spSCGw+7CSK5+kuvw/YvLUEQG1LTzp3QK5OL0n8n2+Qo7a?=
 =?iso-8859-1?Q?3EooI031aVqhXs52i3MO5cnMYEdYUv+ZWJi/yx9xyL07RuRR+vwKQcbMIR?=
 =?iso-8859-1?Q?7Ej38B3rO2UjkMxaEBaon1Ynmj3M3QkXiNZ7BWT/l5pkhwM16BCHMVE+x5?=
 =?iso-8859-1?Q?3/CpQqXy+5xqGDSwF1gb+VvunUTHlX2Y6eye6owfDe2fo2pa7pdUnF3PUT?=
 =?iso-8859-1?Q?dthYbkXJa6AXYnLNBqkyl0hurOqy4ox0/6DTeiwCAuJiFnwFQcj4gXgLQT?=
 =?iso-8859-1?Q?v9uqOFfJS/Hr8WlSGtIDCNMH+HjcuZeg7LO2y6/eFobuY1kBTKgQLbIwqA?=
 =?iso-8859-1?Q?wBz4OMx/JcuFOulJ0WzNnTkiKat5ByGH5EL8FDtzydE+3vl52gGztAZh5Q?=
 =?iso-8859-1?Q?qA2cg0wWTra2EPosJgg4/rvS3mMudS8RJadsjrWUpp9ZfpuEQU0SECweYM?=
 =?iso-8859-1?Q?NQoorzo7p1WogiAJkJVFgeQlOtP7v6tEfXQNMAeA85UFNVdBPR0zgib+0n?=
 =?iso-8859-1?Q?5nyOMH5KM4xPomXBJKNn7snzEXBtgftXXtyHe0jDb233I/22G4JXU/jc4g?=
 =?iso-8859-1?Q?DauJrKEpyULzL7HDEYX8KU9iQNUgSQZpVKGmIcTYn5Rd88o/OY1KM/U6H5?=
 =?iso-8859-1?Q?Vc6eCYFzeYoRhMcS0geNJfv6xKFzzLYpw5rs9I/JcRictIgbPByO1Usg9j?=
 =?iso-8859-1?Q?BitQsOlW7CE10U/fhs32aHnwHEDCRQawzOb3Ky/Bv4ZRbBEW9dVPZmEFjw?=
 =?iso-8859-1?Q?0SBIkf/WPYoIEP4T8DMChRmdCi8n81o3KFkthOz+Ut2p7SXZ54JFE/Jai7?=
 =?iso-8859-1?Q?Umr44d8yVT6O+tiF3fJ4AbiWJfMYzzg+alCCHx9bZ4lK3WhaZXGSCktI7u?=
 =?iso-8859-1?Q?E2OUpmtSHZ/Z0bSgyGdcHcf3I2yLJeL+U4ZC2lMduylew49wPUyXLropPI?=
 =?iso-8859-1?Q?UPDYo8H3Cg0wVnNFOckitJaE1Ns1Dl42El6yQ/Ur63XziCm9p9iGpb1uMl?=
 =?iso-8859-1?Q?PbdR9JFI5WEDqxN/222rnQ+dL6W7ZT5OOBnPkajklOJtB8JgON5J6cET04?=
 =?iso-8859-1?Q?ZTQPc56CUvsTbG1Sx6pfrQyg/tCgo0lj8P+Qd06bgc7+gGNplzpWh4AXJ2?=
 =?iso-8859-1?Q?PHmDTcaPMh+qlGTbNh6FtiARG59QWPkwynVCCMVHrgnT/S7kuJ9ojEBXgv?=
 =?iso-8859-1?Q?1tLh8xtzqYDoFeKcMq91rY1S6RXPGX85n43AJ791mhETfwoAPPAyIGZsxs?=
 =?iso-8859-1?Q?H89lZu2t4UUn+pAqkBdpUTVFCQY+YEFLVzMRTYRT9t4WMqTinyjOkAn+oT?=
 =?iso-8859-1?Q?BusD2F7c8sbNhfVhmkGNwnC/u32EQrxcOSDnTKd7VVjblZSXRGrWHLyIMH?=
 =?iso-8859-1?Q?wzxf0faT4FgEr1j46KgyeO9/mA5JEzgoHP8AOfRC1h+enpZeyt2LHkupZ0?=
 =?iso-8859-1?Q?KPr+yc1n2g9HSCk6+gH4pycpo9tO80qZ7sNRNVAULLvUmNUoy304baag6r?=
 =?iso-8859-1?Q?3EQuWpUskM6R4ydFMrHuCXa9UnwwiQErnG30iq59BgYEH/8fMQI7C47SNR?=
 =?iso-8859-1?Q?M7/qVG1KLHZghL0YPzxwonIvSkSiu9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z3AyYqxfcAHmdOExVWERvfCRhe4TbbqTJWgTnCbEApfHQePshJGRE/+uQB4x2i+klKZXsgmLqiKzIilWIornFuwivfvtsasTcyyuC1ojII72pNKyo8jBe6fZ+YOVv+NprpM8vD6IdftfwR74xVaVtoXfOQE18JCrOl6+youcPOSiG19lbUW/+vpSjXJjQmTzVDwT17fXp/ulB9baoU1xosILH+dpJxVEgMn1i4gd1fR0VHrTyQ6hUgvnij+xqLM/wYFpwzO9Wgq9RSxkt9ayupQzhMqoGmpBpvpOqpKK0y5SUYQFI0Qy1An3dltoaGPX1OBbKmcoIXQ0DBAx2BNbIg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab97f6-26cf-4c9e-ce90-08dee723580d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:51.0647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kufe1WzTeuuIkRzuxlV+O+yz3sTuIt8wAWgtLd9QU2486D0lWv2DU7477kV1t90Klr5Zp/I9ehtqX8Sny19HD3tKX+Agz4LnEXQTXywIIl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX4uD6ckon9ljF
 lgBJ0/+fuzltPYmZDLBhP2l3VSHG40KqCzJ1GPPaLZWhOL/qRt16hIg1gCTDPn6W8wH+8qsH3iS
 b+6kR0mNFtnYC4xGfGPY1M3zjlI7r4M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX8ewrYY1KXaSa
 McpHV0TBgPdcIiK3aOux6+2b8l87P47sTGcf4SUYq/WKbzmFiu3uY5omXDkUvFc82jg/k72xn9l
 XKreL7RHOqEZlIfa5/pvK2MjfElv4ERz8QZr7p6c0MdOxuFiu9sPe3id3jEOLQEICIVXzIHaBDY
 Dkv9c81Ant6S1cH0qKybdGvtgVdM2kniw+KXWa8b8e6ZfZ4fbSn/dWL5DKdNYlDUQKKfimP8ZpP
 y/4f/YvEG8e/rGZO+eIK+VSbVwEz+gDzjHEtXLkDrhg9hdaiFROnRPpHdYQi/JXTHuuTMUxokvL
 +mctyGsyBIWXQPU2er0HCMdGI1PXTh3lIDY0/l3KNeBm4wIi9egeZfywddj9gL57xnZxuvH36SW
 Y0WrAzr5AzTXO0q5J8GKpjqXnWTRh28QK3vGNEIbNJAg2S0q/bzCu8iu69yhTTucCrb+myvy6if
 xekYNKA+s+/sXiUHKJQ==
X-Proofpoint-ORIG-GUID: uSj3Vov1uK083kviAqMvaOVCsYZOlOId
X-Proofpoint-GUID: uSj3Vov1uK083kviAqMvaOVCsYZOlOId
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5f658f cx=c_pps
 a=0mOrEJ06uaCo+Tyi64Ng2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=lJFH3X02AGBvrhoyKgEA:9 a=wPNLvfGTeEIA:10
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

If the vfio-user responds with a value large enough such that adding=0A=
the header size to it overflows, a smaller buffer would be=0A=
inadvertently allocated, leading to buffer overflow.=0A=
=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3867=0A=
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO=
")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 11 ++++++++++-=0A=
 1 file changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index b8d2b7c1a8..e58167a818 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -128,12 +128,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *p=
roxy,=0A=
         error_printf("vfio_user_get_region_info argsz too small\n");=0A=
         return -E2BIG;=0A=
     }=0A=
+=0A=
+    /*=0A=
+     * Ensure that size doesn't overflow, otherwise we'll allocate a much=
=0A=
+     * smaller buffer than we need.=0A=
+     */=0A=
+    if (__builtin_add_overflow(info->argsz, sizeof(VFIOUserHdr), &size)) {=
=0A=
+        error_printf("vfio_user_get_region_info argsz too large\n");=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
     if (fds !=3D NULL && fds->send_fds !=3D 0) {=0A=
         error_printf("vfio_user_get_region_info can't send FDs\n");=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    size =3D info->argsz + sizeof(VFIOUserHdr);=0A=
     msgp =3D g_malloc0(size);=0A=
 =0A=
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,=0A=
-- =0A=
2.34.1=0A=
=0A=

