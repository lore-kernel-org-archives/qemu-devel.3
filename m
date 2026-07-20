Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6EDC44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk80-0002sf-Js; Mon, 20 Jul 2026 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7x-0002rz-6x
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7u-0007Na-Ft
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:32 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6T08N3733944; Mon, 20 Jul 2026 02:17:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PMDwH407eb81MXFVZaE3HknjQMU0lotl8I14J41Ow
 GI=; b=hZU1K1aiRa/2wUBlL7OijarNOGEp4+GyDl6NPkhZ80pWHWfMRbR3hOfwr
 LUBUCsfNGa6cLyl20LrcfxU4M4VwrcmSH4zH08jTqzsqLOGLEueLVlmG2honXNTU
 6GPszq+MFqTZiSerp36TYzphRMx/k1NzUbW6sMWFvhUmj5OGeLltfxHJBT5Lr+L/
 NIZEYrZL7lUm1HSzBlstCr8okWgNSrflNEVyrQq8S/vhcbHUg17MoF2ddPjzV70+
 hvr9RUjl6BvWWJz9QmTpvcATXsZLIzsAm5LSKw6ZELF8vJWSZH9tZB9QJqAm996p
 LoEekpXgCCVhF/l8wlAIpl3uLkEAA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022106.outbound.protection.outlook.com
 [40.93.195.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8jctsh3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxwFRKygW2e3fHqfs1noIc3WImAKteSQLHUZsFYJvixAi0LqR1LOBFtSwrEZPUcYafnz/E4Mze2Weo9CFx6T6ut3FuyJmATeplIfYArFXAXI6GyZf2X6immlu/yL9jI+kPkbIYIqp/6dqBHAZk6z6Cv+OLEPOKzu8TlHmG7iOsFjcLHhWuhuKvA1tt8Dsg/c/8TNioxOoQO5VJwfW6l5aOZ9AHA9naW0W3/+gXORUh3HLnoqvxZGtoxcPcuoc48DK0mY3KiLu1PY6rwHncK1uiqPS3D31Vhxdr3Ogb4xzTmyL6mV/7Suy822uO3Xqswt11NLI88B7dVoA0jf/GcZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMDwH407eb81MXFVZaE3HknjQMU0lotl8I14J41OwGI=;
 b=aDlP354PM4QfrokfW81CuRNX8JovKlu0EkgG+U8OfnF9SqO+637xvQNN/FHxFeILWF7IMOLJn/jKPxhuGFK4WBbsWiMjPaI39Arda61OfJXLrYT65uOmGH8Rlyr9F3M80uaSZ1WozdJUWQuclKd6cdjlzmAukihbEvvIenMeMF1KpFwOZIx8kGQUbvBgbXxwf8JxINb4mbvPbFGGvs/4N5Ab6TiRcg9gCv/oVcSDjcTm1aS9wlDQtQqi6ieOmqMaNqKI3pu6H2yEcCfsfDqwL28DPRjCuL1u6tQUhF/Rndl30S7blrxpNlE5ah1/WQheblBkDm3uZVzBF5SndD8KGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMDwH407eb81MXFVZaE3HknjQMU0lotl8I14J41OwGI=;
 b=nl7ihes7oIqxaFzyOI6v1E/rGlTNce6AbQoMYJIKd9+O4CkajFElH5YIMZa5AB96rvZaFn0H8WucdnxIpzN+HJ0Q3e7VwHTZhLRReI9Hp3tAz+lblAW3Hf/izuEe3K1pk7P8fyZ/hU39Tf8IU9fgqbc9cBGQDeVmjetr/2K5cP1VhtpAcrCOXbm5kN+eIxns1jokqCeTxacBHRPRRbnpgGr3pGN5n2+bfKU/4n1V6OO/4+c/JiAhnr62jd7zIpCpa+0i5dvoosmq/9IIJ3wx5b2J+ZCQKy+hWaN5/1KgCFtOGPu3wTU+ED3z43OpGduA52Ne1L1/nceEO6zuvm3i2w==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CH3PR02MB9860.namprd02.prod.outlook.com (2603:10b6:610:17a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 09:17:27 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:27 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 2/5] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Topic: [PATCH 2/5] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Index: AQHdGCiVa5g27BcKgESg+BylswLh7A==
Date: Mon, 20 Jul 2026 09:17:27 +0000
Message-ID: <20260720091718.2642-3-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CH3PR02MB9860:EE_
x-ms-office365-filtering-correlation-id: 7a610e1c-a86b-47dc-b13a-08dee63fb7d5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OXa880BscHY/ugPYLOJcgnC4LxQyhZLrUaJDOmO3y1OaY3iZfYLn8Wfhs7T0R1BFkeeBWCOmBGJbXhVWJ5cu54EK9uFl2heYiIi34SnZ5ajG7CrvLhIlaUdifyHn7hRLZE48rb65t8msw2qDCIDtFa+aGexWgxAo8S06dv6i9q45FKJCZKi5FCM3EcpBAF/BF9T/wTKiG+wqOHT7C1HcFg4LHcw0iFks4oS5U86FQzIAt3iIXabHmTp1HaaitQTwTgnYSjUeDOqXfzPiwvcsWuo4IpnoyIHxyCCxMIbFyreKBdAOT6XrY3pzNZ3+YDyYvGw+QBUam9V3g8HXnAhk8uSjAUUvwfeZsp2uPT8SSpNRos+XwtQgcFiVo00e381y9cqadzrj5Bi63S6W0yztzvA478Ze9dxQFcikTDRuicdN41nL2n6eNkftUZ1FrJu3NZuj/TS/MElkPNkeKW6VslJfuMCyYhLN+few2KmyR6HY8fXfPq3oc1zYUpjoYg+XnBlgCpos9XmvNz8fEd8bl9JOalzbEPveMlY155p3PRbNFz69qqTPn7zXnITKdJOaGPLHldvdjP2hWRTKdiVAS3zAn664zlC89ibgqt6HMB9b7eHTkWSQtYqdKOCm/ST4ZiKVmom34/O6jYu1HyeE8nD/ZzdCKdvsG4/4S0winC9qzu1Gx8XZQSpCTlwWF7i/92CN3IBqry9j9A3peeOQYsDUo3HY34MK62NwXRGvuZg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eInw8Xs1Ypg3dK66pxffBlKna6tZJoWDhB9Jdto8JJl3FM5pdzfT9GveRq?=
 =?iso-8859-1?Q?WmwawguMQRSqOTxwtcrUFEexasL7LRCBbQ0BHS7Gw3apTEt6RoQusdQ6OD?=
 =?iso-8859-1?Q?eN7Ln/8YvlghwmwAPKLxBEAsEtx3PvcRGX3lXWMFQsyXoXENX+bU4WwOaR?=
 =?iso-8859-1?Q?WLqWEBy22ebGQP5U/RXXn77eiw+C8DpQMiK99V/R8a8XqPjOJf69cXVPcs?=
 =?iso-8859-1?Q?efZxWWxXhZgQooNYoTdUCgcJ1scm/7vdvwaGRyGyLKoHZDji9rXS7zyxW5?=
 =?iso-8859-1?Q?afPuOBdrKj/vT8Zhg6fUMss5Hp9qRC3wv1tJ1drhvVUoqqU5z5Gcj7r7sB?=
 =?iso-8859-1?Q?q0VcoMTEnGsoO5aVAbUsLh4Zb3DSAKZ3C6+hprMEcloPCJBL56lhezCr2b?=
 =?iso-8859-1?Q?Yl0GVYaND4vqprLWs+FHQlqei4U/f6/txh7oJDExzlXeLMyOLUvplNQboA?=
 =?iso-8859-1?Q?odIEO7mQM3WKit7sFhfuvlbA0hLU0pUod1IWC/Wzm2hhVfQaak1NOyJYCH?=
 =?iso-8859-1?Q?8QQc0GQ1JV2ia4BFQIjUqiRGxkGwiPv+GJYApvc72utVAe/nF1wrPUJVxp?=
 =?iso-8859-1?Q?+8bf1SwfSBySO3eM5FpXnT0wUXSOb/8zYIOwZkzAlcQUNaUzl8uteSfCA/?=
 =?iso-8859-1?Q?yREJZtmuuZDK5qqWoPjuJpiOp9WiCydvb/4Z+1edQ9aaGpSajOwLuJsBZB?=
 =?iso-8859-1?Q?F8aE6mBpedUlmmrmq2cr1gU6BfjNz11ZYDH/HNd2AZbXpN4KxBYHaFLW7a?=
 =?iso-8859-1?Q?QsxgyYWQ4bFxuIgm+OV/EgKfTi8kH+tDp0WB4SUm7isUEzvr/Djzo4uDQk?=
 =?iso-8859-1?Q?xD5+wf/CSE+2zGD6M9iWPjN9t9KJgOocZOsIunwgfjhe0eAmU42S8EXG/e?=
 =?iso-8859-1?Q?RPthKvrjY0RUsjW6nW+Fsy+DVdvbRhsqjuTau0IJ0GznkOeAlRGtkCQ8D7?=
 =?iso-8859-1?Q?yw4ufrFsIXbDuI5NlTA4WNJhjnIeTww7QgXIbFBlAQWMZlpYfENz+RLgUe?=
 =?iso-8859-1?Q?OBEG3rQmnbxvXKSuSl6TzHqY+38OdC9wyK2mKJHuqU+S8lALCnf0MyRblr?=
 =?iso-8859-1?Q?lPgzA2bz9Rwtr8e5jnZ7/rI5qfvAzLHWpdWcbvyP5RSH//3LgvuyU3BKlN?=
 =?iso-8859-1?Q?8pw00EeKEeVL9UI+dOXc101TYDd5utdiYCQ4Zxq0dBC+mCSNN3iSdnIEiM?=
 =?iso-8859-1?Q?x+9qB/FLx59N0BVdlj3X09yprwrwz1SbEZU/BcX8fKI+mG6RuKtT0lSztX?=
 =?iso-8859-1?Q?K29sCWeGnIDuT/KTwf5DMPWBzcqAxWRh/sK23aD17O1t2Oxp+zP5iOfVFa?=
 =?iso-8859-1?Q?xSA3k9qptwWa8KOGf2NRA/mSkGY/IN4ywUdQes/tdY0sNnBXUjTh+tn0ok?=
 =?iso-8859-1?Q?qim19FdaX3ec06BbV78SCIFQnYhB1dj2hS5WfEiKyWMSOj2OlCC6nGj8zT?=
 =?iso-8859-1?Q?ffO124JpNMlvcp4P2utzuZFzwBULM4VIrh3vVUdThJaE5Vvkyjxl3aCA7w?=
 =?iso-8859-1?Q?LTvdbBGbeZbywmZ3INvi+NwGulKIakbcbLcfStP9xhzoSS/LbSYKItEMHO?=
 =?iso-8859-1?Q?mjWRRtOIOIfXgLc9OzZjl8+29+13NLboS57Hini1h+izE8OqS69Lk236Q6?=
 =?iso-8859-1?Q?Y7UsM5ZfDXqLApHJ0R5FjYpL/xSVpbBTIqZXczOaByIGZ20C7FvOkWHhG1?=
 =?iso-8859-1?Q?gSkFIF8aGlW54GB74UFSx75xvQqPOtfGAcf+XoK3JChCrGcKh6Peo2cL3x?=
 =?iso-8859-1?Q?t/P2PZNBWksl59dm4fF5TE1zUbo28grZ4/piwHTtfij5i21VCFjuR5CR9a?=
 =?iso-8859-1?Q?gbEOig/uVhtSPsP2ZtzZkUFimsooKvY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qNFkFsriSpDBCEDjMHTO4y449IIdkguUakLlJSaOIexuBjPN8KBzoSdGourIg1HcUVd+dGapkL8msWwc+zoMJ2HgpX9cXlrm5dRC77jVdmAPS4xgad0dpXlZqwy6zSV8uJRBUdXeiwkLrR4hSaWyZVC9hzNiokL2cqZlY3vkSmoN9joJTXVNyXAiZKw6AOUbIpgHAyV+4PbL2T5GeykeVZ39xmn3BY2mWnYWDJNpN1kHWa3EpIv9MlVKpxThXpks122SL90r+CKTIXfCeqP8xlwfT5BemxdQdZeHTwJj1USDSnFG4KpdpaU2QechqK+QObIZp3qp1mBGIVlJzW7n0g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a610e1c-a86b-47dc-b13a-08dee63fb7d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:27.4148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wejxCeeDWP+MBClhxB+Jn5rE/7GuujsEvnynu3nWsdrCyRsazX6WayWMo0djnYKtYvGUMlSKf9RNvHvtPhd87RN7voD/6IRPbPXv8VryHlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9860
X-Proofpoint-ORIG-GUID: KlNL2k4Ss4Szq2SQGQ7BUxPgiIPCNAZm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXwJLDCKvaDeL5
 81gJaYW5gPaZfjpyr/3DOFOMgeELwppHq2hQSqSVKzZpEETlGeO5DxeGBwnKCoirWuUb0wd8K3z
 9yZoAHMkdwySuTG+fcXcTriynkQwTnQ=
X-Authority-Analysis: v=2.4 cv=R6Yz39RX c=1 sm=1 tr=0 ts=6a5de7a8 cx=c_pps
 a=njBiJbAQTUgP4Zm4Bb3rbQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=H0gwBzo8t0bp_Z0icpIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: KlNL2k4Ss4Szq2SQGQ7BUxPgiIPCNAZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX1vvqtONIVN8J
 4fv057NfDYlxmefGvZNUL5Dj+DEHGx2hWNy7thtH5Izb23gIdRQmYAWKHlJTnhVofi5sRk/l0OH
 tAK3JLNFvClwNZDUovGq9aJG4y0L+QaFBjaC7/qUXR2RFmXTwr880StFK7rohZOuPg0dxBc5+pt
 0mQjW88SbB/FgJV2rewHxFtrlKJYBdmbOuVfiovozFJ0jdHwZP5vxr/EKWNURyPbtLs6VEEBG+3
 BLPYuBY/pd0xj/EU4Hg61jNc+/t0nehXL1Ma7D4FMoi1tiJ9NDXYraR8Q+I8dRGcDnLLyaAKNuS
 T/iP7LDSMEUsVvrCX0QqPaVR0zYKgkCW4K0v8c2KGqn0j9CERPvbMRQFebjvGO3Mnpg4XNKxOBQ
 MLR73LKmSkcNMAzmwub2IWbmz0xSODHX/M0jklmXgn/vraScJFA+yGTzO0ww0yZCSzOLk+Idv89
 gJq5MCKgSblhGObDS3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 19a42c2a25..201bf34c8b 100644=0A=
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

