Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513C61090247
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Fj5-0007Zr-DD; Thu, 19 Mar 2026 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w3Fiu-0007GF-76; Thu, 19 Mar 2026 11:55:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w3Fir-0008Rl-Q0; Thu, 19 Mar 2026 11:55:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JEWFmY2981638; Thu, 19 Mar 2026 15:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4G2Lmj5RNSkZyZhsf3D2oGA7
 g542pcHgkDtBiT+Tuv0=; b=cXRqmwQphoyYL6UqJ+kyzZ0vO+6XeGNqMgz4SdAf
 zaT9tau6Wv4C8muKt1ighTQIJyMO6ZsF4Nfry+6fS/tEhjRhWb5AtOLk0drd3Jf8
 M2lh0US/AErRC+cbWQqhMKz557XJE/Uv4k40baceoNqVz3itM24LtJFBDZhPF4A7
 EsYZ2eL/5BfA9lgc1X+eSbYqnnNgW1aiwx4x+nDW2CFy4VOzMZ5DuGQum71lTAZr
 9wmDWoQJPh09P3axps1kgkI0RDlBPph6mXJ6OXvQbkwOQDZK1U0bVoN9IN+SR36L
 Vms5uNu1hV/ag2id9l6hGCcN19FdJjyL1dZjgo6lUxDxbw==
Received: from cy3pr08cu001.outbound.protection.outlook.com
 (mail-cy3pr08cu00106.outbound.protection.outlook.com [40.93.6.110])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0809bn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 15:55:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAKtcCwW03mClq4julRKoDJDNoG+txYy++5oksgMVLSCs/YTjkXFkVZcJCNScHthp2WltIa8o0krHbfBRdz4dTQmDW6C37Gp8eGWYsptX0sKUqkNV6hCSuQN2I3W9h4mcQKw90hV1RyJ+EcSDEbhNNfL+K0i52YtXGvTjvpx+fH53qCi2lHCteh2F4KJIBCuj9lHixwkIFdfX25+kt95dSl2GIHw+ODPqMJ+5XkVZHSiGTc982LdgR5px2lx/UnS9d/MRuP2r+aC/Txg31UJ9p9mUy21dUSbkRxt8DdxftO90yg0GeapBw6cSVQioDeci6PfU6IZdjx81Zj53rWEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G2Lmj5RNSkZyZhsf3D2oGA7g542pcHgkDtBiT+Tuv0=;
 b=lf9bPQS+FHwccIkTuy6a4yWrOosDf1VcqX+rhibpAG5CmeDDvLcDaxtzB4wd4PD4O+8YXE35gNjhuo/ZrIeqi8pgXZAOlL0tLtOOLn2PXAHDh24KwoDetU5FVvi12dHbV+LOJM7vEzMWAD9shutbUZPOdF9jpsIMCRLMs/VSvDIh6O57G4unTf5zbrtemeOioSwDWKVLb5WgcCGw0VuQ5Hc4pNO1Nn1ukafMAyppV/1t3ZGTlkLbndrLIYluozjRw+1sba8eyKjKf/bx3CcNaigHnvIJMfYFfY3ppBHuDH8Fu85zPE2OdfQtRxg2e4ur2hrRVdBf8ln4BlKVOQEXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from MN2PR02MB6622.namprd02.prod.outlook.com (2603:10b6:208:1df::21)
 by MWHPR02MB10425.namprd02.prod.outlook.com (2603:10b6:303:28a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:55:40 +0000
Received: from MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239]) by MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:55:40 +0000
From: Steve Aarnio <saarnio@qti.qualcomm.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] meson.build: Add --enable-use-pdb option
Thread-Topic: [PATCH] meson.build: Add --enable-use-pdb option
Thread-Index: AQHctwlOUrDdM9odpUWgzwqG2/agnrW1EB2AgADx4v4=
Date: Thu, 19 Mar 2026 15:55:40 +0000
Message-ID: <MN2PR02MB66227C12455D077C5230D8879B4FA@MN2PR02MB6622.namprd02.prod.outlook.com>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
 <13DF1B88-DE82-4948-9749-A83D4163ACDE@unpredictable.fr>
In-Reply-To: <13DF1B88-DE82-4948-9749-A83D4163ACDE@unpredictable.fr>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mohamed@unpredictable.fr
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6622:EE_|MWHPR02MB10425:EE_
x-ms-office365-filtering-correlation-id: 78adf8dc-f5a4-4978-ef96-08de85cff81d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|22082099003|18002099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: F3St2XtaxvZgTg+cbxZv/Xfs0RoXKubHyaywXdoMnJkRTMf1bOnJZbYF48zqLnPuHB4jQVClOTx87lmiSc+xZpDSm+AxeyZQYULdcsTVY8TcWNn3VPF+iU7a6mgs6S7iTi+tm/tWZJE9RDFSN4loIYcW862WFQuwrD4ipJT7UG9Bjw1m+Vufpz3md5RfPZhPSt6Ys0A0c1Ior8EmJCplo7WOtj5pgAUawc5C6zVJafzMlJVZ1RQ0bKeTQjuspxnsvDKCsKFBX4jidgDVBnC5pIh/ytPkLjSY5e05778HDY5QYNVMnaCS5iVzVkprjf+BGMNvDfn2QRDqPxfIcpW3GNxcnVIA8V3xhFIyx3K0/HTh2sfzyIFLKA+BnrJsaME0w53h2sAvepF1xTk9b2ZIdVoRw7eXXalnM74V+RkOE5bRuOXswQvjbPGq6ZmtKJFV+V7FbXT1CoAdPrvGtQx3HxjnVueRz2R3ehM15iwC23CKo4+W/14zTqDuiNRQinCtntZWddaenf9s8SAStW5ttQ48Br7ts6EgvKOR7ZGfjgSQ3GddcJaoSVn56SY0rRWkvW2oTTrUeL8ME/yPIg0kT8OUHNKr301rOxkbeHwUCtOl3w6/cljy51ZpizNl1e0ut3pFJot3svuxrwj2KclvXFus9Y1gpgcafSgv12Fx43iRFxykEaEurV3pYQVpyTY3i/lXiSx9D9aiTu9r/9lmkWnPEjPbLKjqO9YmnVdvlGmtHVDIXC/0M9H/2aEnsC1/H9b6xNYmbUveKyR/8N4pmVIutua/RRcjtBQqoInwlek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6622.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(22082099003)(18002099003)(56012099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z0GvC/5bInTwXmpcAIrvLJ5gZSNFzCQw/zcRT0jOn+wnyE5/DB+MbZviOw?=
 =?iso-8859-1?Q?/Qi1wKrURBBp6GTlGjFBaFXsG6+AsOlyAPqAjte4Lca7qc9sFxQpwqWmXz?=
 =?iso-8859-1?Q?caS0FBpD4/4iI56JpxDzoVidvPhQCqFLAPIAU4Y2FfsGsCzzWSy/1WKRIO?=
 =?iso-8859-1?Q?BijSG0Ef3WsFHjCith0btDf1ed9EDwyvlaWUXPh/bRhGc8aGYA4kEW7g0l?=
 =?iso-8859-1?Q?imAuDApggTV/lEFYLcq/ZzvbIqjHonDN8ze3TOO8Mm52YUA2oYxK91SeFN?=
 =?iso-8859-1?Q?XaJ83AycYXcrq5ULMzqM0t+FA3lD60Tfvr91HsCLFB+QliSN4KC8/cE0dE?=
 =?iso-8859-1?Q?hJcNCN7MYbkCExQzwPEZQpiS+YUnubc3j01q72zTNPx/haAL6ELrOWPq6T?=
 =?iso-8859-1?Q?mqpaDqVgyzkBxNGlxISZf9DS78clpjNJtcbWNmIcEeNc2TUuiiqIrFeNqk?=
 =?iso-8859-1?Q?tzje9mRvpdbu6pV2tRBKutxIipk8ZfUDafGkFJRNBSoM/MReI/NY5Y70c/?=
 =?iso-8859-1?Q?Mzc53J8Sff6D2kyNIuASqe4F94T/cjsUatjsVAdCt5bos+yUH3b6VT441L?=
 =?iso-8859-1?Q?arJ7bwLh1Vm7OXyQUw6TnI2/xD3Je7QPSlK+40YK4tpxWVcGltNacrz3v6?=
 =?iso-8859-1?Q?Q/XRbbMA5lWVmzO+4ivTVNSXJJtICjQsevfHZe07RdGpWGm/nZ6uMFkPPa?=
 =?iso-8859-1?Q?0bCSUeQDEn62+coIQyhAIY8vgt4N0mVsyxEhSOtkzjq2WBPK8RELI9Sddz?=
 =?iso-8859-1?Q?fxjxZ/MXb2CPM512Kb32v29MIyYciVBhou5ITwxPuGw6DthqqQHbmvUjZz?=
 =?iso-8859-1?Q?wz2ItCi5vED2NkDSA/Vgp0iiEaO5UgmpK8zKXFODON7XtUFbLD1wykSk/2?=
 =?iso-8859-1?Q?1S/A2Br6EjaH4P5kywbVphpefZrLkKtZFPwY5V+HfUOdrW033LvN1VR6D/?=
 =?iso-8859-1?Q?wlhde8YDtJqvyLhyYgBbqDtE2wugReGj4v4x6M4eSE/niMHFbTxnXiKU0Y?=
 =?iso-8859-1?Q?5LsHWMbPLBO35jxngp8NBbeouCcP4sW/6WvRiDDMQTrvh1UbunLR8U/tOB?=
 =?iso-8859-1?Q?H95Y8mpEdkSqJ++XEkS8sPvUHQk1Wnhk7c3BHX79z/3/VAXbBEYhSXkSZo?=
 =?iso-8859-1?Q?mVLYEThZhhTrsSR9huljkQp2OY00NAw4Z1qt1k8VK3uIWnQbL4/MTFY0He?=
 =?iso-8859-1?Q?msy65kcrj49Mmu7pxp4JBlchslob0CEwUcwNHr+jTvH+9mRyKPPg255QFF?=
 =?iso-8859-1?Q?0r90obdsOEU09HOH9l8LVlbfGP/GXEsrSMLKuJ3o9BB8Thz30ME7FCJfts?=
 =?iso-8859-1?Q?PfatmQrmS/6x9OhlAmgh0CEqxZi/0uCPO4MPk698tAD/HE2Vt/gSiHX7bS?=
 =?iso-8859-1?Q?oO7Uktfw+sz1z1LundQKAsVTS5cg2GUzWQG4e7jbUdBN0SEjZfKUX8EGNk?=
 =?iso-8859-1?Q?0Q8OI2kd2Sz/vOm2M8NYZ2gkkD9UoH9RvkJhXgQpMhtUTHiA0A9nIr9r3V?=
 =?iso-8859-1?Q?cQi6pH/7hC0KN4QudYQhMC4OdOLR2jGIRWnbeHOB1xutAJ2MyRL8bQsAGH?=
 =?iso-8859-1?Q?xyZ38oaJwi+MFwvOQ3fbgJ/sSYdx4h6PtZEA4eGq1gL8VAuV4QhevBmmLK?=
 =?iso-8859-1?Q?tXf1/YXtPShR8e9BH4GhH9YvfoD8+TooofAXaZdeZJwM0C7GF7Kd5wP8UZ?=
 =?iso-8859-1?Q?Pe3pU7gAvYyTfsHAaejuND/0O7OCeswKdGz37ptxw1PE7sy8srBTtIb7io?=
 =?iso-8859-1?Q?RKm9zh9YkGJtpGD0QMX3g/kaZoN4I3J2bnDa6D+aYAqrRnyS6GS2p2OLqA?=
 =?iso-8859-1?Q?Dj70Nv3yUQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR02MB66227C12455D077C5230D8879B4FAMN2PR02MB6622namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mErOchk2q5ddnRXe+fRVoeb6I8aJPBl+1lJzuQaQ+mjjJsKQHODdV8k6V4Z1BIIqPZnBTu07DFEuZ11Hb+pOSPVNVLJhIbbEbdvi0CLcp9mHnuTbuKOvJo4aIX0wxNTQZl7UpOTM3SojoWx8n1cmeU1qOuDXufuU4a/0Tw5AorLhgXQPE1ZFmWXYY0EMizUHDn30rO/M7t8felnRypsQBzeBDndbbCMUNeRHcJe8BR1hSJqY0yPUQl4pVLQMtARL76vSncAjD09PCZ/OIUMhg+DIquajbakXy2pf0G55HtaHd3LNYFtF/jwD7XrlGYAIxY7IKr02S+YEncVZC4E89Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sVmlayVfL94sZxm/xUKG8eN016O/oWssxMw7Bu9jN8BgHaKRZa+peFeunLFMjBuUniL9+VRM4qJqykN2U4pa0l7Q8hboInB880T8folxA0P+BTcmK9q6Wii/Pgskol7W6WLNySoKz3TgjVXaaBQeuRuqwgAe+Kds9HWN0nwf9kpRas4fHpSe+RS8Jwo5ge2rwFyqleBrPUQLIWlMB3/7h36WkrhbomkcjhIY9/icuMjEyfkwQTTo7ZIDppAPZXMJMbh2D4ZdDlsTYfZOf+kZOkoaAkjgZv6GWhcB3ZvriOdNh3ObRvFSv4yQq6IPqaQlVJmW/KykVx1oaUN7R/isUGZ0Pz0bZzenaYowoyop+Ie6hLtvdeoKBddGqPR11kdbgIQq1x0rmjT408AMKk3H8+X78cy8md6Cm2Ow8hbVzhSpSjPLeYD9stMPCwbWTnOufLI9X6cp4u523ZZnpiYuV3jSqhZPXGhOe0UrwFxRWzgycdJ6vCWZpdAC+enhrKzAPGJjfR+baYMqXRGMyu2UKuT1kCla3YJDggSTkV5/47FObhEc03xSRQstCNl0f9WIcbwSyZ+mYpvFbUdtX+AA6gO+WLOa2WihfVOdniBOaUH7wTAC6gjc9AaciEjeAWXN
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78adf8dc-f5a4-4978-ef96-08de85cff81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 15:55:40.0361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Icy1fFpRmJBVS/P8mlwL08vVuYo2Pz3MOBxD9BpkO6NJ2+XTrTEGxXpri06jlZbH5iPEglT7r/eQeClpQtMOS4zLWGPyfLSeilXbdCKZBKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10425
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bc1c7f cx=c_pps
 a=06rDlZIv6fgO+JiV9OBTRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CJT5CMB8Z0xqpqPZ4SYA:9 a=lqcHg5cX4UMA:10 a=wPNLvfGTeEIA:10
 a=5sXUJ-gTCnI4zO2SYKcA:9 a=LI1SHMGvZk5kyGCz:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: zt0It7I4o4iuOm2fdnM4Ajr5XoZzO71u
X-Proofpoint-GUID: zt0It7I4o4iuOm2fdnM4Ajr5XoZzO71u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNiBTYWx0ZWRfX4OOO0dpaPiAV
 eqrLKL/T2o0+9AtHNWV0Iv6GJWqMKlFwvDPOE/VyUS+RSmE6SfiDv9kZkHY5RQ/XkMmUxfAwruN
 TLTPLPozlzycgVnV042P6OG27pSw/Qk7nUAn/BpAzbCU5oywReARCsznq9tm89Px9lJygq3AuAe
 Z/5Rp7yXOn1jp9YcxIjja8pkvL3K8ChTf1zYJ/TXJrLZpJRHklSmVxGTZLuQyOTXz95LSUmfxId
 ayn8+WIlfgrv4E9rLD29lAk/1LWbnR5isc4aFNIqG2/wXQp8mwhp83g2CletqdS5TjqekJ075No
 KH458YB9YXSihQH9YkuMapSHoRjJEwh/6QFpQK2jqFzNwg/1Weqq42spw1kkGbwzEhc+JfTLaol
 rnwRldyHeuhqYLkvxmLNVy4HvTnygyr2NaYKOsD3Tz0j/XhYOF/AmPsdTVzng+lAN4H/aswXnx1
 gfD/UKPtnA7pPElU1Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190126
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=saarnio@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_MN2PR02MB66227C12455D077C5230D8879B4FAMN2PR02MB6622namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> On 18. Mar 2026, at 20:18, Steve Aarnio <saarnio@qti.qualcomm.com> wrote=
:
>>
>> This option will (attempt to) modify the QEMU compile and link flags to
>> emit PDB symbol files rather than the standard (DWARF?) symbol output
>> from gcc/clang.
>>
>> This enables using native Windows debug tools (Windbg/Visual Studio) for
>> debugging QEMU.
>>
>> Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>
>
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Already used something like this, it makes Windows debugging substantiall=
y easier.

@Mohamed Mediouni<mailto:mohamed@unpredictable.fr>, thank you for the quick=
 review. First, thank you for your WHPX on AARCH64 Windows - no more waitin=
g 20 minutes for the guest to boot, which is amazing. Second, regarding thi=
s patch, are there other flags that you used for your work that I have miss=
ed here? I've had reasonable success with these, just wondering if there's =
something that I may have missed.

>> ---
>>  meson.build       | 5 +++++
>> meson_options.txt | 2 ++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index d7c4095b39..d27581e0c2 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -692,6 +692,11 @@ endif
>>   qemu_common_flags +=3D hardening_flags
>>  +if get_option('debug') and get_option('use_pdb')
>> +  qemu_common_flags +=3D cc.get_supported_arguments('-g','-gcodeview','=
-gcolumn-info','-fno-omit-frame-pointer')
>> +  qemu_ldflags +=3D cc.get_supported_link_arguments('-g','-Wl,--pdb=3D'=
)
>> +endif
>> +
>>  # Collect warning flags we want to set, sorted alphabetically
>>  warn_flags =3D [
>>    # First enable interesting warnings
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 31d5916cfc..b1f3250d5c 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', value: =
false,
>>         description: 'measure coroutine stack usage')
>>  option('qom_cast_debug', type: 'boolean', value: true,
>>         description: 'cast debugging support')
>> +option('use_pdb', type: 'boolean', value: false,
>> +       description: 'use pdb symbol format on debug windows builds')
>>  option('slirp_smbd', type : 'feature', value : 'auto',
>>         description: 'use smbd (at path --smbd=3D*) in slirp networking'=
)
>>  --
>> 2.53.0



--_000_MN2PR02MB66227C12455D077C5230D8879B4FAMN2PR02MB6622namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-size: 11pt;">&gt;&gt; On 18. Mar 2026, at 20:18, Steve =
Aarnio &lt;saarnio@qti.qualcomm.com&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; This option will (attempt to) modify the QEMU compile and link fla=
gs to<br>
&gt;&gt; emit PDB symbol files rather than the standard (DWARF?) symbol out=
put<br>
&gt;&gt; from gcc/clang.<br>
&gt;&gt;<br>
&gt;&gt; This enables using native Windows debug tools (Windbg/Visual Studi=
o) for<br>
&gt;&gt; debugging QEMU.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Steve Aarnio &lt;saarnio@qti.qualcomm.com&gt;<br>
&gt;<br>
&gt;<br>
&gt; Reviewed-by: Mohamed Mediouni &lt;mohamed@unpredictable.fr&gt;<br>
&gt;<br>
&gt; Already used something like this, it makes Windows debugging substanti=
ally easier.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<a class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" id=3D"OWAAM558902" href=3D"m=
ailto:mohamed@unpredictable.fr">@Mohamed Mediouni</a>, thank you for the qu=
ick review. First, thank you for your WHPX on AARCH64 Windows - no more wai=
ting 20 minutes for the guest to boot,
 which is amazing. Second, regarding this patch, are there other flags that=
 you used for your work that I have missed here? I've had reasonable succes=
s with these, just wondering if there's something that I may have missed.</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;&gt; ---<br>
&gt;&gt;&nbsp; meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++<br=
>
&gt;&gt; meson_options.txt | 2 ++<br>
&gt;&gt;&nbsp; 2 files changed, 7 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/meson.build b/meson.build<br>
&gt;&gt; index d7c4095b39..d27581e0c2 100644<br>
&gt;&gt; --- a/meson.build<br>
&gt;&gt; +++ b/meson.build<br>
&gt;&gt; @@ -692,6 +692,11 @@ endif<br>
&gt;&gt;&nbsp; &nbsp;qemu_common_flags +=3D hardening_flags<br>
&gt;&gt;&nbsp; +if get_option('debug') and get_option('use_pdb')<br>
&gt;&gt; +&nbsp; qemu_common_flags +=3D cc.get_supported_arguments('-g','-g=
codeview','-gcolumn-info','-fno-omit-frame-pointer')<br>
&gt;&gt; +&nbsp; qemu_ldflags +=3D cc.get_supported_link_arguments('-g','-W=
l,--pdb=3D')<br>
&gt;&gt; +endif<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp; # Collect warning flags we want to set, sorted alphabeticall=
y<br>
&gt;&gt;&nbsp; warn_flags =3D [<br>
&gt;&gt;&nbsp; &nbsp; # First enable interesting warnings<br>
&gt;&gt; diff --git a/meson_options.txt b/meson_options.txt<br>
&gt;&gt; index 31d5916cfc..b1f3250d5c 100644<br>
&gt;&gt; --- a/meson_options.txt<br>
&gt;&gt; +++ b/meson_options.txt<br>
&gt;&gt; @@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', v=
alue: false,<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;description: 'measure coroutine s=
tack usage')<br>
&gt;&gt;&nbsp; option('qom_cast_debug', type: 'boolean', value: true,<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;description: 'cast debugging supp=
ort')<br>
&gt;&gt; +option('use_pdb', type: 'boolean', value: false,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; description: 'use pdb symbol=
 format on debug windows builds')<br>
&gt;&gt;&nbsp; option('slirp_smbd', type : 'feature', value : 'auto',<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;description: 'use smbd (at path -=
-smbd=3D*) in slirp networking')<br>
&gt;&gt;&nbsp; --<br>
&gt;&gt; 2.53.0<br>
<br>
<br>
</div>
</body>
</html>

--_000_MN2PR02MB66227C12455D077C5230D8879B4FAMN2PR02MB6622namp_--

