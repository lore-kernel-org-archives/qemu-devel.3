Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F8FD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSvG3-0001XH-Cn; Tue, 09 Dec 2025 05:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vSvG1-0001Wr-Ds
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:47:49 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vSvG0-00081b-0h
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:47:49 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B99N6T42992282
 for <qemu-devel@nongnu.org>; Tue, 9 Dec 2025 10:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=YA29wGyXztWS0DWzJ4QDLXpHhAy0JvyDX/rv63eviS4=; b=cs
 Yjd5MZprDxBrx3I5jQsutMNTMS3XdUXy2oimInL2O9pmx55h/nOcA4xu1ImS80yI
 qPTV8KMoaOsaNR2adfPajO+GQmFwot4XW+rTUj8OirAxElFPlntqYViLI4tYtOo9
 wQTgKrJe41jl3RzpVyCA4uXSF18NfhVNMmOQwbJxTL6y3lIh8nnWmyajSSs9pS/8
 cwUu66H71y9wK0EtXWSqa0gxEeSNP8je+AiAhqf9CMKRVy0ZjxaYkwHuh+w/1blo
 XabZhEe1mfgBFq5+3rGqa8pzUNHkftbdsr9HQ5HKQqaRw5vamwvx0J620YEomOB0
 JstbwBFcHke9bfDgZeUg==
Received: from bl0pr07cu001.outbound.protection.outlook.com
 (mail-bl0pr07cu00101.outbound.protection.outlook.com [40.93.4.1])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axgqr8ahb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 10:47:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIYUN0L/S8VpoJtWrYOe3hl0xCoWHZIqpnZDJupQj7axsMtroBopEJlVqeRhPLdpoY3VFMmfSLx/BXkdHyOMZ6qBhq1do8u+F7Br29cmb3tb5KImERmw7oydL18QuFWHAVMqcJKNK5byJaTcWmddZPAZUVjodAuBZLr83H3G/6RsVOxWkDL/bAHLD8XSCMipg/MPmMOEAvPpzUWpaEtQo5tZWioVM3lBVhDz2gk4ySId/DuqN9X/7DXHSQio2NB1ygWYyYEd8nQuRsX+7skyovDKZNvAkDSR/XSEjBZoH0amH4cSeJt0yMHsa8EA9ZC7f6Pep5eJk0COW9zCr99IlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA29wGyXztWS0DWzJ4QDLXpHhAy0JvyDX/rv63eviS4=;
 b=L6NzoVrGLGFwt4G4GnLfJX/o4A973lny2bYdwMr9DhDZr8kWMDcEKp6sw7lrln2sl80UaEnBC6AD3RmGfqGqQ2MlzEgUf5KkteJcFSEZnzzqUUfF+r1Kl4h3Vs+1YwmSQ8tZXqN3zqxS/y4D0S5b+rWQTQCeLobOR8jlEHM5EUPlpHRz/g+OG13m97/xPVh8uP+R1xDikct3ZPYDuIuFWFPiUvI+Op9bOJ6pD3dwggg4PW5an3GKEtNDIEZYSY6EweAbcxEZoSiEo2K/2Tcy2WKHH3ruAA+GEYykdYKIQFShXFw30WO1mAELaUuKpDT32NlQlZw5q0PnvMvRQWF6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SA1PR02MB8623.namprd02.prod.outlook.com (2603:10b6:806:1fe::24)
 by BY1PR02MB10435.namprd02.prod.outlook.com (2603:10b6:a03:5a6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 10:47:41 +0000
Received: from SA1PR02MB8623.namprd02.prod.outlook.com
 ([fe80::b0f5:7528:a652:4729]) by SA1PR02MB8623.namprd02.prod.outlook.com
 ([fe80::b0f5:7528:a652:4729%3]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 10:47:41 +0000
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>
CC: QEMU Developers <qemu-devel@nongnu.org>
Subject: Record AS in full tlb
Thread-Topic: Record AS in full tlb
Thread-Index: AQHcaPk9a1ehpTIlp0SZwThihBgF4A==
Date: Tue, 9 Dec 2025 10:47:40 +0000
Message-ID: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8623:EE_|BY1PR02MB10435:EE_
x-ms-office365-filtering-correlation-id: 1d4e87fe-6152-41e4-874c-08de37106072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|4053099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I9cSAL8oK9NSXe6cMcjeDecW02u10GIaVwE7bY052uWXne4wfHHt1B1hU9?=
 =?iso-8859-1?Q?0Mm+utoVEuzt/uaV7t3hIHMMXXWduuDNLwAKKumcXqH+ez3CMW+BJ9PGyD?=
 =?iso-8859-1?Q?+E3OkA/Xlx97E+LQJ87+rnISIZabdJ+iHtra514itYGT8zdxDhJzWPr1tA?=
 =?iso-8859-1?Q?p8wp8sbcXWOBDSN8Z9Jy7W3x3Y2bPHVbOiHMjr0FWlktFbooJgnXF2UECq?=
 =?iso-8859-1?Q?p/cJilOC+CKIaTVYN5xrpceLfRAeAxC+sMvOlKMy+htEi2HxLhNXt/vYPB?=
 =?iso-8859-1?Q?aY9mDE697Bi0e1yKUs9nL6pfnQZE9vwOs9yTmenJLYVM+S8Yjift3YIbcW?=
 =?iso-8859-1?Q?RR9P/56DZz1EWq+rOcnciMRd1s2EkXJUDfglm9jL2+2mt+cyfipqv7ymvs?=
 =?iso-8859-1?Q?fd/aAYgDxRl/oCWHeybPgK2MYCp7DUnE2WLqdRnkihQJc5XmJ8COkwu2MU?=
 =?iso-8859-1?Q?7/fMRzcAfJf8wIYCQYeW22fsHWh23Wy7IQGogshtB3LD9wqnDECxeUv6QU?=
 =?iso-8859-1?Q?4ykgyPwRwvYWhcICBysAnKeFeXkq7o/9XIxy4TSRkZsJGJbfY8g7Ae0kM3?=
 =?iso-8859-1?Q?V8GH19sUAseTULaDryFWB7A3HdwzeAkpd+koTb8J+Exao8G4nvyV0wdE74?=
 =?iso-8859-1?Q?nqQJbpUQ78qzFVXfbdq6XIjwBYsr0uJ9A1rFH3l6r6NovWMotemuejJ4o7?=
 =?iso-8859-1?Q?HuXrD6RlSKCk/1gANsEQguEs7Ve7TuTRKq055XQsFzk5wu/1QdS68t2899?=
 =?iso-8859-1?Q?UlwXa7anu43zV+RC1bEU1N8QOLUBz3VO1ySHilkj9bco0wL1tM/cMv7LVu?=
 =?iso-8859-1?Q?CsGPnbYUZTMpr6eOVywXgnTDB/8AaJxfV2NZAx9xEIkbfgJ3pq0x+tnBiV?=
 =?iso-8859-1?Q?QIg47ENNLAiWgWxQze7Q4G3/qWbo9IF2tbgfOrbObf+M/Iqk2K8ZYVw2CX?=
 =?iso-8859-1?Q?uDjTZBiiKD3+CKoAYmDLYc01c0EburrS3im5R6ibpR6y3NXucgH0Gsav2I?=
 =?iso-8859-1?Q?XcQ/XXopvNKITHB4ed/K1uLsKnWiR1g/YvKKAK79Ive4wbhkLIaGxcXrmK?=
 =?iso-8859-1?Q?47Vk7T388Yzh2Vl1fYDGpgjTaR0gn74QZjIPcWmigeUkFSP5NuviiOJzoJ?=
 =?iso-8859-1?Q?j+xqbrU12V2Yjhqdx7IRu/P5GCTmRmGgf6ewUvM45i6Y/JEQ1l/Qu77rZS?=
 =?iso-8859-1?Q?MyqSNHmWKR5UQNftwRBHFuFRAmya6kC3utSi3t0Vwm3ZL1V+GCi66irORD?=
 =?iso-8859-1?Q?DljxYtkJ0pz5Czq05HU04bH+PYJbPY0sjLoFNxdT1UfYJEshzZMoriAvOv?=
 =?iso-8859-1?Q?q/gw4xB3Y7YBjV2JL0vWQpFlrxvRinlrVPVqiZ42OsVpYcZc6Ipw2BnxhR?=
 =?iso-8859-1?Q?L5W7HXDNtScA91bx/jrS0fjYMZkkUtIbrdPvnB8a6yu5dvXkNP/EznlET8?=
 =?iso-8859-1?Q?0R09Fi3kEfmpsr3U3oNz364byo6RrS+i7Vd3v8UmYLbd7UXAWRdbciv2bH?=
 =?iso-8859-1?Q?zPtbJnnQ/g8CAVLKe4U2IKW7QnY+lBGwm8so+53YSc7hhN18Sl+w0K2c4q?=
 =?iso-8859-1?Q?eppkHuiHYRejRhdlu3QqL5S0UenT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8623.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4053099003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AdaNnHKjwQVZrBRh8dsMFS3KN/t+cpC5+m/KiKDiTw0eziWAJhE2iaUI1J?=
 =?iso-8859-1?Q?4Wi2OUBNoxSSwdN4Pd7DOM8DGnzfDgeauiyv5tK3/LkuaPac77E5qLSl3Y?=
 =?iso-8859-1?Q?ywuw7hgTr6yvfmQCviUy2domgX7dnTr8O2/WnlksUQv5nMNQumZwFK5C4J?=
 =?iso-8859-1?Q?FKHKislGqBwrWdqTQs6AsExSvTSBWnKfoaZQhByqQEJjz+Pkgf3Da2/Xsm?=
 =?iso-8859-1?Q?rxVdxwJ4AukbXTzt89Mw1W1i6R7K2RFZQuJyWXnYUPuafNBfvCSuYRKRws?=
 =?iso-8859-1?Q?6vt2iLN303idoUio7T1qc/qeM7CR4G5+CdoO+/KS+pNLjzd1d3ZnZGc28f?=
 =?iso-8859-1?Q?DlLoQwzdLH+ZV0AyuRtQMeqWsf/voLu1ilXav8zoTVIkZrDw02rUoimeQL?=
 =?iso-8859-1?Q?ZGR4A9Y0iDbhpY+zcrKkQRNGH7sqW+gWTFYLQK0Nm1y47JxlAx80qcmLEa?=
 =?iso-8859-1?Q?chHsOSY6fBWZdnxkL+hS0lqi5+p5kB1zzbsYcJmiczHCvdfFN4yP2BQh5v?=
 =?iso-8859-1?Q?88yW85Yp/OPi0JWCKQvpmIiPtTp3Kv5AwGberzLeblWh4XWtTme8ffaGg+?=
 =?iso-8859-1?Q?ygOYDaPjDyOx99YpPyJxJ+HfdRwYVs6EuaKQhZaS03jW/+I9bQO0T2NoFR?=
 =?iso-8859-1?Q?q6fbSCV30LJ3W+v22ZdEvJRlPZ/X/TlgHOk6LnA/9WzgoqG5uR58nPwPQ0?=
 =?iso-8859-1?Q?g0mnUuQmo1pJUamg8mUiNESv/pMTNO6YEtaqod/x5yjATUa0HIWflYFN6G?=
 =?iso-8859-1?Q?Db+EwT1osFjoSyA+cD5oqgkVnUoX486BAX0q9c5gT8jSma7Ubeb6Fc8Sa/?=
 =?iso-8859-1?Q?ufZQCbtB6broAdMb2a552wE/gtSzgsgZ4BoAO36+c8BzEjj+aPeRd+cUHD?=
 =?iso-8859-1?Q?vqoTXWm+juDMgqnIJ7MxIXVKu9Cve6a4G+E4k+/lpb+TpUAlWcRXCDRAy0?=
 =?iso-8859-1?Q?gDOKMGI2nq2e8uVQVeATiRKy2ylGZufjwPulqfXR+bSDMiP73UzmUbcixP?=
 =?iso-8859-1?Q?wOTG8kU3YyDe4GabFfRi/o9N2yyj5pk+C65JCLmWySaqNgApd1XMvncmJB?=
 =?iso-8859-1?Q?Tz4pJ9urGVjjqeDKT+QBasz7xbAfuvOjVm1nq9CgDLeuZcelpyQUi6sC9s?=
 =?iso-8859-1?Q?L2pbwQtOt8KhzixrqMf4ZC/0KkCQUtFRbVqZzSqu1o0g/0d0YIg+9aNJ4S?=
 =?iso-8859-1?Q?Z8DaB/OJR7tuubioavLTVSZjhrwWB078YFuJDsBmxn2gocQ2eR2lQMwlKc?=
 =?iso-8859-1?Q?zeHfeGqOiiWJ8VANIrp7MOyU6wLisCoEc3hmMKcb9czOJyEBPVLDRop29J?=
 =?iso-8859-1?Q?kqTqIqM0MpBXYXrSr3MNskQExCywwXDvyqzDxelPsTzZ1xWqjIzXwSZ+En?=
 =?iso-8859-1?Q?npK1wsrnrMjpIJsYUxpLxkikw2NXonQKCoc5am6imB16L+BmbfHcC+D15m?=
 =?iso-8859-1?Q?cZLdWsK5irMVtG3gxqfgTlLKPBC/jXz3bSXpi/pkr1ba1/OYl46QK1g5KK?=
 =?iso-8859-1?Q?hUToMjpMpgDdoLTjA2qoFWXfwpk1rddomP/R/W5geJvRPfyhUqjLhEMumz?=
 =?iso-8859-1?Q?r0gMUA6domPx4GPu0OAhywsrCTRSZY6/i5oaO7id0b+H4wEvlX75SFjBKL?=
 =?iso-8859-1?Q?5/9NpE2vYbO5eNMEDUhlF3rQbaATtfaDsbf9D/n+i5fE2VnAmOF4/EOw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_002_A5D46F859B92477CB9641DCE2A1CCF19qtiqualcommcom_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yuSst47ZSI2pVO83dnKO3fYWJTLN7T0yX2Xr1aF3WSvvxE1/i3K+K/LdcbSmn0dvWAE5ZLoSbGLQ95Aldzl04M8eQ/Uv0t30H4mG2sPcMLXuJ4HsUHFQJnKl1yytWl1fE9O1cXszLsz8tai24GokcdD09nQEaWt9SnNHDjgKwD8TCb6h6XxALDodQCjH1vfmWyjUKw/bmxFSEc6lf43hlQOpwbG4QkMaYPYE/u1MYbsI/Jh2qVnbYKsgxu0HlSIbYkV621ErQS2D8xkfIXtDbt0Z6JRfNL7E4leM5uNb9ll+ppJbVBWOl4M6IsME+xRLWK3jLI96jzDWu/YHl4fEDalLPEBREyQC6nzcyPhcA3IZbYUOVdk9tx8SF/sj93+h02eU/v6P314EucoCW+/jScBfGkyCsWdrrBaQcoiqtFhbdDPkEmo4J+PzYAtKv9TrXqjltUHXqjAAtaNeuuyW4uDKiYXM8w9vU3TTGH+ZqxM3WAUH2+meMESKHx1xgkOmHLRyyz4wftLe/taIGxcfUyIh7Sh9tVtWEWuvEpp7zMTY+RDXEjBWSzteEpZmzM7kxWndQTzFxFFJS/wChE9+ME3A9yl8odJkFj0QdnmEv5C8l36pRuXq38zB2zLW6HBV
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4e87fe-6152-41e4-874c-08de37106072
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 10:47:40.9875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INM8S7XL8R9GCeW7UMfaF3belvly2iCGyvHuMPUbAZbyQoMrU/8dNhor6m5RqI86PKwIiMH5RxvK396giMSFnwiBipY75UM7+fnJ1ytgRvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10435
X-Proofpoint-GUID: ctsIunnIXCRANBlfsfpQMVNJbjpDNLSY
X-Authority-Analysis: v=2.4 cv=UrBu9uwB c=1 sm=1 tr=0 ts=6937fe50 cx=c_pps
 a=bIbXKPR1jM9XdZLceGeTKg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jee7iG3MYDlYqp8HM4EA:9 a=wPNLvfGTeEIA:10
 a=kPeUqPJO1yK13j0fyZ4A:9 a=B2y7HmGcmWMA:10
X-Proofpoint-ORIG-GUID: ctsIunnIXCRANBlfsfpQMVNJbjpDNLSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA3NSBTYWx0ZWRfX+YeT1omu7mtt
 9KcxoxU03hh8YHBb+BJ0W+Qug8+5SaR1RjYbuje3lLMx2jXpsbf+b6R9/Ts74LmEz5G6vBf3Zm1
 FfLqTIaAFzpO4Off12oPdNz9YU3OJxk/vtzU96Ywa4WZCUAkZYFKegO03vmbPnnXfqXW2+I6y3V
 Uwb84RGl++Wh8TFHAKQkkuNqO3SjX2WDORvUJ9s4f3D/rhgQb6sLZMr6CWA7YTPLPbDP3bGIODT
 1d8cRmJIHuCB1YNtLlFUYTB0/uEkqwtDoribhIX9ULfxfAPW4Q/7qcbv1UYeCTcUUx8igSTgs3m
 Y4BQ010U38R8n915wuW6GjV49jerm7yqx4ceYTn5Iz+nqsrSJibCqsvagOYH7W7JSlXfFALOBMf
 yhdinCgnf+I5TGLlYpUP03c3C63jPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512090075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Mark Burton <mburton@qti.qualcomm.com>
From:  Mark Burton via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_002_A5D46F859B92477CB9641DCE2A1CCF19qtiqualcommcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A3E3F0434C77B941A08E55D9B99EADB8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Just posting this here for the discussion this afternoon.

Cheers
Mark.



--_002_A5D46F859B92477CB9641DCE2A1CCF19qtiqualcommcom_
Content-Type: application/octet-stream;
	name="0001-Record-AddressSpace-in-full-tlb-so-access-to-MMIO-vi.patch"
Content-Description:  0001-Record-AddressSpace-in-full-tlb-so-access-to-MMIO-vi.patch
Content-Disposition: attachment;
	filename="0001-Record-AddressSpace-in-full-tlb-so-access-to-MMIO-vi.patch";
	size=9039; creation-date="Tue, 09 Dec 2025 10:47:40 GMT";
	modification-date="Tue, 09 Dec 2025 10:47:40 GMT"
Content-ID: <7536163366169B41ADE9C6EE4D81B9DF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBhZmJjNmIyYTBmNDU1ZWE0YjJlZTM5YTNjZWUzNjhiZTVmZmYyYzdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJrIEJ1cnRvbiA8bWJ1cnRvbkBxdWljaW5jLmNvbT4KRGF0
ZTogRnJpLCAxMCBPY3QgMjAyNSAxMDo0OTozNCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIFJlY29y
ZCBBZGRyZXNzU3BhY2UgaW4gZnVsbCB0bGIgc28gYWNjZXNzIHRvIE1NSU8gdmlhIElPTU1VCiB3
b3JrcwoKU2lnbmVkLW9mZi1ieTogTWFyayBCdXJ0b24gPG1idXJ0b25AcXVpY2luYy5jb20+Ci0t
LQogYWNjZWwvdGNnL2NwdXRsYi5jICAgICAgICB8IDIxICsrKysrKysrKysrKystLS0tLS0tLQog
aW5jbHVkZS9hY2NlbC90Y2cvaW9tbXUuaCB8ICA5ICsrKysrLS0tLQogaW5jbHVkZS9ody9jb3Jl
L2NwdS5oICAgICB8ICAyICsrCiBzeXN0ZW0vcGh5c21lbS5jICAgICAgICAgIHwgMjQgKysrKysr
KysrKysrKysrLS0tLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDIx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHV0bGIuYyBiL2FjY2VsL3Rj
Zy9jcHV0bGIuYwppbmRleCBiMDkyMjlkYWU4Li40YjFhYTlkZjcxIDEwMDY0NAotLS0gYS9hY2Nl
bC90Y2cvY3B1dGxiLmMKKysrIGIvYWNjZWwvdGNnL2NwdXRsYi5jCkBAIC0xMDczLDcgKzEwNzMs
OCBAQCB2b2lkIHRsYl9zZXRfcGFnZV9mdWxsKENQVVN0YXRlICpjcHUsIGludCBtbXVfaWR4LAog
ICAgIHByb3QgPSBmdWxsLT5wcm90OwogICAgIGFzaWR4ID0gY3B1X2FzaWR4X2Zyb21fYXR0cnMo
Y3B1LCBmdWxsLT5hdHRycyk7CiAgICAgc2VjdGlvbiA9IGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRl
X2Zvcl9pb3RsYihjcHUsIGFzaWR4LCBwYWRkcl9wYWdlLAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnhsYXQsICZzeiwgZnVsbC0+YXR0cnMsICZwcm90
KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ4bGF0
LCAmc3osICZmdWxsLT5hdHRycywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZmdWxsLT5hcywgJnByb3QpOwogICAgIGFzc2VydChzeiA+PSBUQVJHRVRf
UEFHRV9TSVpFKTsKIAogICAgIHRsYl9kZWJ1ZygidmFkZHI9JTAxNiIgVkFERFJfUFJJeCAiIHBh
ZGRyPTB4IiBIV0FERFJfRk1UX3BseApAQCAtMTI5NCwxMyArMTI5NSwxMyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgY3B1X3VuYWxpZ25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNwdSwgdmFkZHIgYWRkciwK
IH0KIAogc3RhdGljIE1lbW9yeVJlZ2lvblNlY3Rpb24gKgotaW9fcHJlcGFyZShod2FkZHIgKm91
dF9vZmZzZXQsIENQVVN0YXRlICpjcHUsIGh3YWRkciB4bGF0LAoraW9fcHJlcGFyZShod2FkZHIg
Km91dF9vZmZzZXQsIENQVVN0YXRlICpjcHUsIEFkZHJlc3NTcGFjZSAqYXMsIGh3YWRkciB4bGF0
LAogICAgICAgICAgICBNZW1UeEF0dHJzIGF0dHJzLCB2YWRkciBhZGRyLCB1aW50cHRyX3QgcmV0
YWRkcikKIHsKICAgICBNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uOwogICAgIGh3YWRkciBt
cl9vZmZzZXQ7CiAKLSAgICBzZWN0aW9uID0gaW90bGJfdG9fc2VjdGlvbihjcHUsIHhsYXQsIGF0
dHJzKTsKKyAgICBzZWN0aW9uID0gaW90bGJfdG9fc2VjdGlvbihhcywgeGxhdCwgYXR0cnMpOwog
ICAgIG1yX29mZnNldCA9ICh4bGF0ICYgVEFSR0VUX1BBR0VfTUFTSykgKyBhZGRyOwogICAgIGNw
dS0+bWVtX2lvX3BjID0gcmV0YWRkcjsKICAgICBpZiAoIWNwdS0+bmVnLmNhbl9kb19pbykgewpA
QCAtMTYxOCw3ICsxNjE5LDcgQEAgYm9vbCB0bGJfcGx1Z2luX2xvb2t1cChDUFVTdGF0ZSAqY3B1
LCB2YWRkciBhZGRyLCBpbnQgbW11X2lkeCwKICAgICAvKiBXZSBtdXN0IGhhdmUgYW4gaW90bGIg
ZW50cnkgZm9yIE1NSU8gKi8KICAgICBpZiAodGxiX2FkZHIgJiBUTEJfTU1JTykgewogICAgICAg
ICBNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uID0KLSAgICAgICAgICAgIGlvdGxiX3RvX3Nl
Y3Rpb24oY3B1LCBmdWxsLT54bGF0X3NlY3Rpb24gJiB+VEFSR0VUX1BBR0VfTUFTSywKKyAgICAg
ICAgICAgIGlvdGxiX3RvX3NlY3Rpb24oZnVsbC0+YXMsIGZ1bGwtPnhsYXRfc2VjdGlvbiAmIH5U
QVJHRVRfUEFHRV9NQVNLLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmdWxsLT5hdHRy
cyk7CiAgICAgICAgIGRhdGEtPmlzX2lvID0gdHJ1ZTsKICAgICAgICAgZGF0YS0+bXIgPSBzZWN0
aW9uLT5tcjsKQEAgLTIwMjgsNyArMjAyOSw4IEBAIHN0YXRpYyB1aW50NjRfdCBkb19sZF9tbWlv
X2JlTihDUFVTdGF0ZSAqY3B1LCBDUFVUTEJFbnRyeUZ1bGwgKmZ1bGwsCiAgICAgdGNnX2RlYnVn
X2Fzc2VydChzaXplID4gMCAmJiBzaXplIDw9IDgpOwogCiAgICAgYXR0cnMgPSBmdWxsLT5hdHRy
czsKLSAgICBzZWN0aW9uID0gaW9fcHJlcGFyZSgmbXJfb2Zmc2V0LCBjcHUsIGZ1bGwtPnhsYXRf
c2VjdGlvbiwgYXR0cnMsIGFkZHIsIHJhKTsKKyAgICBzZWN0aW9uID0gaW9fcHJlcGFyZSgmbXJf
b2Zmc2V0LCBjcHUsIGZ1bGwtPmFzLAorICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bGwtPnhs
YXRfc2VjdGlvbiwgYXR0cnMsIGFkZHIsIHJhKTsKICAgICBtciA9IHNlY3Rpb24tPm1yOwogCiAg
ICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTIwNDksNyArMjA1MSw4IEBAIHN0YXRpYyBJbnQxMjgg
ZG9fbGQxNl9tbWlvX2JlTihDUFVTdGF0ZSAqY3B1LCBDUFVUTEJFbnRyeUZ1bGwgKmZ1bGwsCiAg
ICAgdGNnX2RlYnVnX2Fzc2VydChzaXplID4gOCAmJiBzaXplIDw9IDE2KTsKIAogICAgIGF0dHJz
ID0gZnVsbC0+YXR0cnM7Ci0gICAgc2VjdGlvbiA9IGlvX3ByZXBhcmUoJm1yX29mZnNldCwgY3B1
LCBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJzLCBhZGRyLCByYSk7CisgICAgc2VjdGlvbiA9IGlv
X3ByZXBhcmUoJm1yX29mZnNldCwgY3B1LCBmdWxsLT5hcywKKyAgICAgICAgICAgICAgICAgICAg
ICAgICBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJzLCBhZGRyLCByYSk7CiAgICAgbXIgPSBzZWN0
aW9uLT5tcjsKIAogICAgIEJRTF9MT0NLX0dVQVJEKCk7CkBAIC0yNTkzLDcgKzI1OTYsOCBAQCBz
dGF0aWMgdWludDY0X3QgZG9fc3RfbW1pb19sZU4oQ1BVU3RhdGUgKmNwdSwgQ1BVVExCRW50cnlG
dWxsICpmdWxsLAogICAgIHRjZ19kZWJ1Z19hc3NlcnQoc2l6ZSA+IDAgJiYgc2l6ZSA8PSA4KTsK
IAogICAgIGF0dHJzID0gZnVsbC0+YXR0cnM7Ci0gICAgc2VjdGlvbiA9IGlvX3ByZXBhcmUoJm1y
X29mZnNldCwgY3B1LCBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJzLCBhZGRyLCByYSk7CisgICAg
c2VjdGlvbiA9IGlvX3ByZXBhcmUoJm1yX29mZnNldCwgY3B1LCBmdWxsLT5hcywKKyAgICAgICAg
ICAgICAgICAgICAgICAgICBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJzLCBhZGRyLCByYSk7CiAg
ICAgbXIgPSBzZWN0aW9uLT5tcjsKIAogICAgIEJRTF9MT0NLX0dVQVJEKCk7CkBAIC0yNjEzLDcg
KzI2MTcsOCBAQCBzdGF0aWMgdWludDY0X3QgZG9fc3QxNl9tbWlvX2xlTihDUFVTdGF0ZSAqY3B1
LCBDUFVUTEJFbnRyeUZ1bGwgKmZ1bGwsCiAgICAgdGNnX2RlYnVnX2Fzc2VydChzaXplID4gOCAm
JiBzaXplIDw9IDE2KTsKIAogICAgIGF0dHJzID0gZnVsbC0+YXR0cnM7Ci0gICAgc2VjdGlvbiA9
IGlvX3ByZXBhcmUoJm1yX29mZnNldCwgY3B1LCBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJzLCBh
ZGRyLCByYSk7CisgICAgc2VjdGlvbiA9IGlvX3ByZXBhcmUoJm1yX29mZnNldCwgY3B1LCBmdWxs
LT5hcywKKyAgICAgICAgICAgICAgICAgICAgICAgICBmdWxsLT54bGF0X3NlY3Rpb24sIGF0dHJz
LCBhZGRyLCByYSk7CiAgICAgbXIgPSBzZWN0aW9uLT5tcjsKIAogICAgIEJRTF9MT0NLX0dVQVJE
KCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2FjY2VsL3RjZy9pb21tdS5oIGIvaW5jbHVkZS9hY2Nl
bC90Y2cvaW9tbXUuaAppbmRleCA5MGNmZDZjMGVkLi5hYzUwZTUwNjAxIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2FjY2VsL3RjZy9pb21tdS5oCisrKyBiL2luY2x1ZGUvYWNjZWwvdGNnL2lvbW11LmgK
QEAgLTE2LDIyICsxNiwyMyBAQAogCiAvKioKICAqIGlvdGxiX3RvX3NlY3Rpb246Ci0gKiBAY3B1
OiBDUFUgcGVyZm9ybWluZyB0aGUgYWNjZXNzCisgKiBAYXM6IEFkZHJlc3Mgc3BhY2UgdG8gYWNj
ZXNzCiAgKiBAaW5kZXg6IFRDRyBDUFUgSU9UTEIgZW50cnkKICAqCiAgKiBHaXZlbiBhIFRDRyBD
UFUgSU9UTEIgZW50cnksIHJldHVybiB0aGUgTWVtb3J5UmVnaW9uU2VjdGlvbiB0aGF0CiAgKiBp
dCByZWZlcnMgdG8uIEBpbmRleCB3aWxsIGhhdmUgYmVlbiBpbml0aWFsbHkgY3JlYXRlZCBhbmQg
cmV0dXJuZWQKICAqIGJ5IG1lbW9yeV9yZWdpb25fc2VjdGlvbl9nZXRfaW90bGIoKS4KICAqLwot
TWVtb3J5UmVnaW9uU2VjdGlvbiAqaW90bGJfdG9fc2VjdGlvbihDUFVTdGF0ZSAqY3B1LAotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgaW5kZXgsIE1lbVR4QXR0
cnMgYXR0cnMpOworc3RydWN0IE1lbW9yeVJlZ2lvblNlY3Rpb24gKmlvdGxiX3RvX3NlY3Rpb24o
QWRkcmVzc1NwYWNlICphcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBpbmRleCwgTWVtVHhBdHRycyBhdHRycyk7CiAKIE1lbW9yeVJlZ2lvblNl
Y3Rpb24gKmFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlX2Zvcl9pb3RsYihDUFVTdGF0ZSAqY3B1LAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dCBhc2lkeCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBod2FkZHIgYWRkciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBod2FkZHIgKnhsYXQsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyICpwbGVuLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1lbVR4QXR0cnMg
YXR0cnMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTWVtVHhBdHRycyAqYXR0cnMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICoqYXMsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICpwcm90KTsKIAog
aHdhZGRyIG1lbW9yeV9yZWdpb25fc2VjdGlvbl9nZXRfaW90bGIoQ1BVU3RhdGUgKmNwdSwKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvY29yZS9jcHUuaCBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaApp
bmRleCBjMGNhNGI2OTA1Li5hMjdkOGZlZWZjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2NvcmUv
Y3B1LmgKKysrIGIvaW5jbHVkZS9ody9jb3JlL2NwdS5oCkBAIC0yNjksNiArMjY5LDggQEAgc3Ry
dWN0IENQVVRMQkVudHJ5RnVsbCB7CiAgICAgICAgICAgICBib29sIGd1YXJkZWQ7CiAgICAgICAg
IH0gYXJtOwogICAgIH0gZXh0cmE7CisKKyAgICBBZGRyZXNzU3BhY2UgKmFzOwogfTsKIAogLyoK
ZGlmZiAtLWdpdCBhL3N5c3RlbS9waHlzbWVtLmMgYi9zeXN0ZW0vcGh5c21lbS5jCmluZGV4IGNm
NzE0NmIyMjQuLjUyMTU2MzI1ZDkgMTAwNjQ0Ci0tLSBhL3N5c3RlbS9waHlzbWVtLmMKKysrIGIv
c3lzdGVtL3BoeXNtZW0uYwpAQCAtNjg4LDcgKzY4OCw4IEBAIHZvaWQgdGNnX2lvbW11X2luaXRf
bm90aWZpZXJfbGlzdChDUFVTdGF0ZSAqY3B1KQogTWVtb3J5UmVnaW9uU2VjdGlvbiAqCiBhZGRy
ZXNzX3NwYWNlX3RyYW5zbGF0ZV9mb3JfaW90bGIoQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4LCBo
d2FkZHIgb3JpZ19hZGRyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRk
ciAqeGxhdCwgaHdhZGRyICpwbGVuLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE1lbVR4QXR0cnMgYXR0cnMsIGludCAqcHJvdCkKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNZW1UeEF0dHJzICphdHRycywgQWRkcmVzc1NwYWNlICoqYXMsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW50ICpwcm90KQogewogICAgIE1lbW9yeVJlZ2lvblNl
Y3Rpb24gKnNlY3Rpb247CiAgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yOwpAQCAtNjk2
LDcgKzY5Nyw4IEBAIGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlX2Zvcl9pb3RsYihDUFVTdGF0ZSAq
Y3B1LCBpbnQgYXNpZHgsIGh3YWRkciBvcmlnX2FkZHIsCiAgICAgSU9NTVVUTEJFbnRyeSBpb3Rs
YjsKICAgICBpbnQgaW9tbXVfaWR4OwogICAgIGh3YWRkciBhZGRyID0gb3JpZ19hZGRyOwotICAg
IEFkZHJlc3NTcGFjZURpc3BhdGNoICpkID0gYWRkcmVzc19zcGFjZV90b19kaXNwYXRjaChjcHUt
PmNwdV9hc2VzW2FzaWR4XS5hcyk7CisgICAgKmFzID0gY3B1LT5jcHVfYXNlc1thc2lkeF0uYXM7
CisgICAgQWRkcmVzc1NwYWNlRGlzcGF0Y2ggKmQgPSBhZGRyZXNzX3NwYWNlX3RvX2Rpc3BhdGNo
KCphcyk7CiAKICAgICBmb3IgKDs7KSB7CiAgICAgICAgIHNlY3Rpb24gPSBhZGRyZXNzX3NwYWNl
X3RyYW5zbGF0ZV9pbnRlcm5hbChkLCBhZGRyLCAmYWRkciwgcGxlbiwgZmFsc2UpOwpAQCAtNzA4
LDEzICs3MTAsMTMgQEAgYWRkcmVzc19zcGFjZV90cmFuc2xhdGVfZm9yX2lvdGxiKENQVVN0YXRl
ICpjcHUsIGludCBhc2lkeCwgaHdhZGRyIG9yaWdfYWRkciwKIAogICAgICAgICBpbXJjID0gbWVt
b3J5X3JlZ2lvbl9nZXRfaW9tbXVfY2xhc3Nfbm9jaGVjayhpb21tdV9tcik7CiAKLSAgICAgICAg
aW9tbXVfaWR4ID0gaW1yYy0+YXR0cnNfdG9faW5kZXgoaW9tbXVfbXIsIGF0dHJzKTsKKyAgICAg
ICAgaW9tbXVfaWR4ID0gaW1yYy0+YXR0cnNfdG9faW5kZXgoaW9tbXVfbXIsICphdHRycyk7CiAg
ICAgICAgIHRjZ19yZWdpc3Rlcl9pb21tdV9ub3RpZmllcihjcHUsIGlvbW11X21yLCBpb21tdV9p
ZHgpOwogICAgICAgICAvKiBXZSBuZWVkIGFsbCB0aGUgcGVybWlzc2lvbnMsIHNvIHBhc3MgSU9N
TVVfTk9ORSBzbyB0aGUgSU9NTVUKICAgICAgICAgICogZG9lc24ndCBzaG9ydC1jdXQgaXRzIHRy
YW5zbGF0aW9uIHRhYmxlIHdhbGsuCiAgICAgICAgICAqLwogICAgICAgICBpZiAoaW1yYy0+dHJh
bnNsYXRlX2F0dHIpIHsKLSAgICAgICAgICAgIGlvdGxiID0gaW1yYy0+dHJhbnNsYXRlX2F0dHIo
aW9tbXVfbXIsIGFkZHIsIElPTU1VX05PTkUsICZhdHRycyk7CisgICAgICAgICAgICBpb3RsYiA9
IGltcmMtPnRyYW5zbGF0ZV9hdHRyKGlvbW11X21yLCBhZGRyLCBJT01NVV9OT05FLCBhdHRycyk7
CiAgICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgICBpb3RsYiA9IGltcmMtPnRyYW5zbGF0ZShp
b21tdV9tciwgYWRkciwgSU9NTVVfTk9ORSwgaW9tbXVfaWR4KTsKICAgICAgICAgfQpAQCAtNzM1
LDcgKzczNyw4IEBAIGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlX2Zvcl9pb3RsYihDUFVTdGF0ZSAq
Y3B1LCBpbnQgYXNpZHgsIGh3YWRkciBvcmlnX2FkZHIsCiAgICAgICAgICAgICBnb3RvIHRyYW5z
bGF0ZV9mYWlsOwogICAgICAgICB9CiAKLSAgICAgICAgZCA9IGZsYXR2aWV3X3RvX2Rpc3BhdGNo
KGFkZHJlc3Nfc3BhY2VfdG9fZmxhdHZpZXcoaW90bGIudGFyZ2V0X2FzKSk7CisgICAgICAgICph
cyA9IGlvdGxiLnRhcmdldF9hczsKKyAgICAgICAgZCA9IGZsYXR2aWV3X3RvX2Rpc3BhdGNoKGFk
ZHJlc3Nfc3BhY2VfdG9fZmxhdHZpZXcoKmFzKSk7CiAgICAgfQogCiAgICAgYXNzZXJ0KCFtZW1v
cnlfcmVnaW9uX2lzX2lvbW11KHNlY3Rpb24tPm1yKSk7CkBAIC03NTYsMTIgKzc1OSwxMiBAQCB0
cmFuc2xhdGVfZmFpbDoKICAgICByZXR1cm4gJmQtPm1hcC5zZWN0aW9uc1tQSFlTX1NFQ1RJT05f
VU5BU1NJR05FRF07CiB9CiAKLU1lbW9yeVJlZ2lvblNlY3Rpb24gKmlvdGxiX3RvX3NlY3Rpb24o
Q1BVU3RhdGUgKmNwdSwKKworTWVtb3J5UmVnaW9uU2VjdGlvbiAqaW90bGJfdG9fc2VjdGlvbihB
ZGRyZXNzU3BhY2UgKmFzLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgaW5kZXgsIE1lbVR4QXR0cnMgYXR0cnMpCiB7Ci0gICAgaW50IGFzaWR4ID0gY3B1X2Fz
aWR4X2Zyb21fYXR0cnMoY3B1LCBhdHRycyk7Ci0gICAgQ1BVQWRkcmVzc1NwYWNlICpjcHVhcyA9
ICZjcHUtPmNwdV9hc2VzW2FzaWR4XTsKLSAgICBBZGRyZXNzU3BhY2VEaXNwYXRjaCAqZCA9IGFk
ZHJlc3Nfc3BhY2VfdG9fZGlzcGF0Y2goY3B1YXMtPmFzKTsKKyAgICBhc3NlcnQoYXMpOworICAg
IEFkZHJlc3NTcGFjZURpc3BhdGNoICpkID0gYWRkcmVzc19zcGFjZV90b19kaXNwYXRjaChhcyk7
CiAgICAgaW50IHNlY3Rpb25faW5kZXggPSBpbmRleCAmIH5UQVJHRVRfUEFHRV9NQVNLOwogICAg
IE1lbW9yeVJlZ2lvblNlY3Rpb24gKnJldDsKIApAQCAtMzEwMiw2ICszMTA1LDkgQEAgc3RhdGlj
IHZvaWQgdGNnX2NvbW1pdChNZW1vcnlMaXN0ZW5lciAqbGlzdGVuZXIpCiAgICAgICogVGhhdCBz
YWlkLCB0aGUgbGlzdGVuZXIgaXMgYWxzbyBjYWxsZWQgZHVyaW5nIHJlYWxpemUsIGJlZm9yZQog
ICAgICAqIGFsbCBvZiB0aGUgdGNnIG1hY2hpbmVyeSBmb3IgcnVuLW9uIGlzIGluaXRpYWxpemVk
OiB0aHVzIGhhbHRfY29uZC4KICAgICAgKi8KKy8vIFdoeSBhcmUgdGhlc2UgcmVtb3ZlZCAgID8g
ICAgICAgIAorLy8gICAgIGNwdV9yZWxvYWRpbmdfbWVtb3J5X21hcCgpOworLy8gICAgIHRsYl9m
bHVzaChjcHVhcy0+Y3B1KTsKICAgICBpZiAoY3B1LT5oYWx0X2NvbmQpIHsKICAgICAgICAgYXN5
bmNfcnVuX29uX2NwdShjcHUsIHRjZ19jb21taXRfY3B1LCBSVU5fT05fQ1BVX0hPU1RfUFRSKGNw
dWFzKSk7CiAgICAgfSBlbHNlIHsKLS0gCjIuNTEuMQoK

--_002_A5D46F859B92477CB9641DCE2A1CCF19qtiqualcommcom_--

