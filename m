Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1721C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk80-0002su-N7; Mon, 20 Jul 2026 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7w-0002re-3n
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7u-0007NH-Fs
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6Sfo33829350; Mon, 20 Jul 2026 02:17:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=eCSXKz96tYKo/
 jkhaV9KMGzKCabm2dkNkMzMgEKCoWw=; b=nhwj/BeZ81yy/BmiAWfu4/dLvSJqP
 KlgILnu8kTH+XW+c+LDqgqZUpkbiVA1n2EbXsu9EOlzrefU+Zojf/CsO88pJOAZ+
 8PQWTnLWl6uJk+wftxOoXMh0dt4zaa14R+OCWUsKZ3o/yClh6ySVQHPNQM0DOwYn
 G3MFHVkla65o2e12Gok6Wo85CIBSTtYq4PkMsKw0bpnFSLjfSfzsSd3R3Wgx/IgG
 TEp1n5Jj0KAxoaPi929kNmoAFZX2Ab+42wNZB+NJTwemdWJ9PgtKia3W0iDYUtgV
 uZ7oVX4AxH6EgzGbBjgoQDSXcydT2m1DRKLZ2AEZAzNmuHlcH8KJxJ0yw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022131.outbound.protection.outlook.com
 [40.93.195.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8bdtsw5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW2Tik2J1SlIfxn1kKVDoLHzr3pQirtgwPCPsFpqIJ7kt8sQM93PHdgrMCQEdexuXfBO865Ilp3gQ6wGR+g2imlz/EZvcIHzXdApHNlmS0uciR4eoFBQLVjWKx+8J8Zz8UGcYi9XTZ78QLfOmSN9XTIrkPANrbJwuZ+sh3LZdV1C8kBOYIH6QO6wWO5v9uSVR2skM8K4wBsNFITOmzYhmAqgasQYYmU34iYHvxWUgbY3+UeU+qMvAjySrRuYneNeLHt0o3NXrcVXIzdJH5joh2vuUJIeV+m7YzK/KdEix139BCngqXt0VS076jqhMYcGxHccQRQDyzv032GV9axevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCSXKz96tYKo/jkhaV9KMGzKCabm2dkNkMzMgEKCoWw=;
 b=DPLK7jNotyrdWeY2MUfpTXmVr/MpuZiFMzQ0BVBjgQz+2iDjEeSuTZg1M9uhx+ASyCbQUst645CnbHGHyvpEUeQ+PrNqr++Lsi/53QgJ5BhZszXcXJVE9LIr94TWfxiHPsEyhtcMSUqmYAnhPmp3eD07iiGYA9I8J4pDz9vmq3DoHVr0XjRKWpWpLJk8AoG1b0YpLb5T7fQEDIdbf0iVUJo0mYzB29h5mtqlVdwCMVxxBqWvoagsEQSZvrxrODKufEH8Qdwqm9G1HECsg/BQt63P9zv+hQusQW0AYuU99ZxHnCGXa2rqk7dSqr+5vn0XW/PtSdcbN1F8piixhROJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCSXKz96tYKo/jkhaV9KMGzKCabm2dkNkMzMgEKCoWw=;
 b=R9JjcvnU/uZqJExO4/SQh9SkezhH2D1ICNsZwBT5xwQ8TFmMtEYDNx0wGVMm2JJ+itgHLgyVrtshzBGt1HBdbzvNuNIeZxiMPORFs+Gigee71tO5VXNcDQiD8PAOTjKFNmC/XX17HWLUJNbkjvLacQtMvLTHuQQdHsbhsqUsDFupS2dbGX+Z6BJV8uVhIXtM+xKOct9Wo0dbWw53F9OtPm3ha9uGfXb0lhrGjlHjklV0AiQKFMYCKrjoyfNPFX+dv6VKdY0uBT9KeLqDV/XbpH8e5iWM0s4DVzUkHxYENjOjUE68HCnq0YpOPcihufJwOQEHoV8sc/hIwZlFKESNgA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CH3PR02MB9860.namprd02.prod.outlook.com (2603:10b6:610:17a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 09:17:24 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:24 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 0/5] vfio-user: validate server responses
Thread-Topic: [PATCH 0/5] vfio-user: validate server responses
Thread-Index: AQHdGCiTgVtvqHoW9UeW14Hkps5xzA==
Date: Mon, 20 Jul 2026 09:17:24 +0000
Message-ID: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CH3PR02MB9860:EE_
x-ms-office365-filtering-correlation-id: b4e3f589-a029-402b-79e9-08dee63fb5ea
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: x4afZA8aP8e4euggv6aQDjapJG+9V7PZHvKfBHM1mi/7LsyzHi/pB3r6jWKzy3B0kS2anHsfGCAwyDcRnTe3HSfHVy9D9qJOcnMFsVc5uIihq1PlY0US1X3k8Ci12o/LRpN6CxCr2OAU0Shc+ws+sve1BO0TQ9kG7/qCqk5qYRaQduSiivKL+HJcIuFPFbGsU43yjwTp1h3/HnEadQGx2QrOtCDQyphhMGE7wetEH3hXaephWZyFWQdv9VqlTh3IGitskVko1wvSinlRT6x9DUbuprxnX1/bFH7nPbJZDW6FvPG3DPtMzzjneE19eRxlHpJKLLyk3Kv0OksvCqzOPP0Ai+Nb2nmlL2uW2KX8LhOhz3q+DLMk3kp7D4aF9GacSiuyJ4mESkUrnOPQAQOK9i5EVb/NYSrlZmrGlcv8kX9BYNwV5Md1KjZ1loIPqSIpTGK9YKTQ8mnmMk+zf04W+pdAQqASqAEBi0Oxm2ysGti1yeT6cHQRInpDrJlS7vNOyJ8teYaOqrrDptfUyNltLmN4qS+ZDUXo6lJJGNug8zz+wgIj+/Ycw3+sn8GGFrb3HaHo+Yja3rFpZIz2tzuNAKur1XifW1T51mPCCh1jIRNN+nUzpr4Ibisu3nLl0hp3QSkFMtGxuD1UuthKQNZftS4pUVkBSxKFdbfciJ9KOLQUanW7wCjRNgH++Cl1O7c2Bghb+XXT1fDVhpPVme7TAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1xIN2AqZN3C3GCMoSPr8XHLUHMXzkH3XUCe3fp7eE/cnkHR14V/9vdtdzU?=
 =?iso-8859-1?Q?DKKEloLSXCscLpcKMAxpKkSG426896QFUehQRIxpaWaxK3j1HEVaNaSu2f?=
 =?iso-8859-1?Q?4w3v8E5IpkXwP1FP5B/GDImwlMqyWgHjYcPmNzI7C7PxhDKOG/XaIMEIh1?=
 =?iso-8859-1?Q?KuqhbNWGlx0SjJisxrFEgEzAHoRh4ApwADtgkNwaOfoKZK8WA8XOHLxiJB?=
 =?iso-8859-1?Q?K+ntUCz2uEIyWJqTOnxRvUkebcfOozEBolNaxJdiSiEXkMvxPBBDocRbbB?=
 =?iso-8859-1?Q?wtbX6vtdgyhaSH03v1HkAWuucLtMZvJkZi4g2wJm/3sGwH4+XHRyh9bjVE?=
 =?iso-8859-1?Q?vWFpxY6AmZzJSUMavETceH4x4Z2p6fzyQOV0oUjRBJvP97Cp+Zegw6UKwf?=
 =?iso-8859-1?Q?ahB24x6f9dB0+M1d6nG3MTmrk8Ue/9JFSOMd26nkyeL8YuniJSTBXAONCi?=
 =?iso-8859-1?Q?wtoEGAIbF8Tvx2BE1HM32z2WN7Kd8ZcwPRDa+IlziGVQwDEp8fvgzaW6O6?=
 =?iso-8859-1?Q?vLJrgEhEUJmMoQvLJ7A6YHvzUkg5rKf5HbqVb/CwXe+TW0F0+uAHwONj4Z?=
 =?iso-8859-1?Q?KB6bptIeSErItNJ02pBaqymuVQrxS8yQ08M9Fv5TH2Wbo0NcV9msMJt2sE?=
 =?iso-8859-1?Q?3bAcpDCWYuQZa8HHNIRvvsrEfI5msCb2uiY1jWikeIkxx5kkiBQ1h6zxD2?=
 =?iso-8859-1?Q?vTwirYWAQ+Aq1NoDkffeOfvrBPR5fu2D13RWROlVw1oWJvevU3BnnAvgZb?=
 =?iso-8859-1?Q?UDhCFm9x+HrjcAqLawyftE6bCiXZkc1sHiObUhf3lx53kjO6tXVywwhCVu?=
 =?iso-8859-1?Q?5Y0VQcXhCb36fFTaEgTdOEWortifbRGGi90JS8htG0walg3APd300MHJlD?=
 =?iso-8859-1?Q?nSRouhhMwKXcqAz0WUE5Acf0nZwVzQ9ZnwFAvsnV6zIbRHuG7ex6rJPizp?=
 =?iso-8859-1?Q?c/bnSLCcJxlS7N5spBOTV0Rr7cR7mhA0PzjSnBisFfpsBbbjQLmkOY8S0t?=
 =?iso-8859-1?Q?gWClZh62ZhjOYx5uLp9SOaACr1ynoUfVzCyEOjxRnfcDtE/SFpuAhk/3lq?=
 =?iso-8859-1?Q?x28Tvy1hlU4VuUjUp0lcrMW7glXhJwp7vm+CeVm++cfPdL/aM7MWoaxPbD?=
 =?iso-8859-1?Q?mPF9qi0Jn+jdpc9AJphhHreilQdifEiQ9ikD/AthzlCE8ocGSTcjBE9rWZ?=
 =?iso-8859-1?Q?xvMwj3uscbgCqCJ9e1JWBaTwI9i2pRESdWcQgCpCDFt8mby+trfXTreRem?=
 =?iso-8859-1?Q?ApKwEnXHusaqA0EyfZ3ZPHdA9fU+DhyNmSlXj7eOp7w2rVGOj1DXY/wkyh?=
 =?iso-8859-1?Q?ELyf14MpxeQ97Yh8MOXRhGJC7FVS34DDLauPjFdkbd9EXusSthYVdYLIq8?=
 =?iso-8859-1?Q?vpNZoxTZy6amt5It9M3My5pbnp5LhdFYc7KZKdtIPF/QyR0UxNL9MqL+Bk?=
 =?iso-8859-1?Q?S0aFBtnC8EADMy/EyP96Dn3vXSv6hl4LZUHKsuoct1pf5K6BlaVL1MFJlA?=
 =?iso-8859-1?Q?L9mpVaAigcKtvBmzmzWE4fe69Hndup2VZZEIWuk6dUkSxzgReSAbJakteT?=
 =?iso-8859-1?Q?b6H3aL5DSgrOxAW77Co9QoF3dmPernSdsQsI9fHI/VcvbDmMYrfNnA5M+l?=
 =?iso-8859-1?Q?A1Guhz3U4x6MQAwoI6ePaxmWg9xIUL1Sk/5vaGRxNkLjNrBynSM0R3o+uV?=
 =?iso-8859-1?Q?GSLk8jrUWHstZZ+fF66+wYvGKf6FQOvTcJcModfnUVfjICS9nqtsXUvUdr?=
 =?iso-8859-1?Q?Mod5gsQXEzKwedEYqiZuTBoeYP4HPWVVMUjIQyr30Xe0vPyr404yyiuzfX?=
 =?iso-8859-1?Q?twVcc3M868wf5y0uKzDNz7R3hNJF4Ac=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hUfomm683hk3r9V0sEfhQy1kABVASD0DzdS4ykVxTFXL2oiw6xley9f09MLKDK53SCjRpZj9zZ2GLKAFBJtV/TgfVt1yKur/6Q2AKIx5SAMc69U8GX58Ik8Dc2HLfEpeWXHiCdbYjtfiFPFvRZ8f5Kw26nvY3DUmkuiisGth4YhuoNlCzKTrl74KLC09OG3TfOV4hmIQohXvSalIeNrbF/emakGRNiDizvQIWDABinQoQxpDtfa2Zd1jKBLIQ3J9lqKJiJHZ74xctP/aFlFJWcphaTK1dDVXJ7U3xbsoDQRt1FpZ34Ow9fvXCIib3LlVSD3fmDG0cKp+A5ISS+d2Og==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e3f589-a029-402b-79e9-08dee63fb5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:24.1656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvby3FCTeUQQqwMjcY1bqOskc8pILf/r+oa+kh4vZbnJPVaqFSlAmL4ujUzDVSmkBPzFbCSezzu21s2wZmF8hLtUzFaT5a+zfSgFIHBKyQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9860
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX9+UrJeKD/ErR
 txP6cEd3YAOaNOpfrcLtZJ6HfxddLOfegKNNITmIXCV0KXXeLzzxTAAp+tb9ruxNRWYdTLnfFju
 qADyNCerRpz5evi6a1ffSz+RR5/Tx8mux9N6miHj6QaLzGUagMQkfvuVbz7ho8wec85Qo1/xWte
 D0IZp4rkYD3QzPcTR9Zha/WrfauKN3aL+SmbAA8DyeQDKhAoPOk68GRXU8pMWf6qFQ1wxC5D7oE
 g3meNgGqGIuFRvMlVkln6QsS3WbwnEXFp+PGP0FS+D7GX8ygfqQQIKubm6nyE8h7BOit3NsR7Us
 10I0uFJ3oye3htApg1HaRwBL+t+7TSN5kFFLxztvZ5IE6lhWEUKIXGvn7djfF0M6FRhoGw1Vehc
 kUH4WnUsFLm6CxP0+HO2W/dQtXCmc2Aontp24EALrZ20f6xDGW3CVy/AkgtiZnzjGfB26U+/RaI
 XJCO+kSHLvF6DIptt2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXx5hOC18WsOpK
 Ri53P7lSvK8rXnBPdTXwZGJhP1uwV/EVjFjcstoniw/WBkpvBOOtg+c1PJg4L3TsjphfjHTNTyE
 WeMj3eIz84afo+xCZODRhUQRlBmC3XU=
X-Authority-Analysis: v=2.4 cv=TdamcxQh c=1 sm=1 tr=0 ts=6a5de7a6 cx=c_pps
 a=WkVbEPlz7sSPDy0d+2zJ8Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=2sZVQdwPqDbLieFrDCcA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: IxWfoRX_vtulEun88QJ0Xqj0qcezCAQu
X-Proofpoint-GUID: IxWfoRX_vtulEun88QJ0Xqj0qcezCAQu
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

This patch series fixes somes bugs where the vfio-user client doesn't=0A=
properly validate information returned by the vfio-user server.=0A=
=0A=
Thanos Makatos (5):=0A=
  vfio-user: vfio_user_get_region_info: prevent buffer overflow=0A=
  vfio-user: vfio_user_get_region_info: respect max_xfer_size=0A=
  vfio-user: vfio_user_get_region_info: reject unreasonably short struct=0A=
  vfio-user: vfio_user_get_region_info: prevent excessive malloc=0A=
  vfio-user: vfio_user_device_io_get_region_info: fix capability check=0A=
=0A=
 hw/vfio-user/device.c | 31 ++++++++++++++++++++++++++++++-=0A=
 1 file changed, 30 insertions(+), 1 deletion(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

