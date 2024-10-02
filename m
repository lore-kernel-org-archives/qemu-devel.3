Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2847CCF31B8
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svywz-0003pb-5y; Wed, 02 Oct 2024 08:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1svyww-0003pP-QT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:59:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1svywu-0004EV-PC
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:59:26 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491MgcHJ026257;
 Wed, 2 Oct 2024 05:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=jxTjelH/rCsM4kF
 F2/cOJAw08gCne0hZoD6qgMJGULw=; b=g7Mch1/vxX3JLOPDxO52tczNDcbhQkm
 TZYrhKcTImx3wkqdAGAe06CXfCm06vVz7fehVdhoIpwAnfuu3v0VdBaw5dQTg1/K
 P1BKqvp34l4bOILqYyMgv+7eCihudJX8sNEm7xzivb6buCs4qY8Nn+FubXpSl17b
 WdSbuFPsThupcmZIdPew89u829SKqANVPE/y+8/1MZeLPAgm0/PefLXuxNEdKRnA
 YGIrikLj4Fbtln4Q8jIChQU+LnlGPW+tlAGE3APLvyL5G08ZNskR238nquK+hfDa
 MFpSm77EQ34W8sO4NB7ws1RhS6/Hkkx65pYsB1p1iQAyMNX76A59X5Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010007.outbound.protection.outlook.com [40.93.12.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 420gaqjv2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 05:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhxq3cU/ECq3qlYNCmIHFT5Nw2J2K03vdEw97wgfgTWEx+fHXxK5tLVrVHxHpdGyoHrSlJrP8GjU/ReaC5ePqWkEH01/W/PVsWzwsdfj/zqAiluTR51BezgcSGVyqOrPkPTc/K4J47IjIDdaJpPvocV+8CmHJjoPjaknJHr8uvh5xfoNAH6qtSTcslPuqpHPkLXUjePSkrV5+4JOYV8RPtgvtTE3G6QRK4c5n/8lbS/T3fKMIbw5y0kmai+Bx05wEgcNngSqDtvIxK3ZXgeYd85t/Y8MEu0/mP1gFu164deP/Di1QS5bmXqD91bFnnA+1KuDfWp+Pzi9xIxTA8FIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxTjelH/rCsM4kFF2/cOJAw08gCne0hZoD6qgMJGULw=;
 b=pmiRvPt/KGVq9gx75r/VUlX8w4cK/HXFxeg0YT8eqYoLrY4W5i9rIEEgm0ecAe7EiDw33SefORgZ8eDIphqsgYk9HQGutjf0e1riaxQS+lsLyk1v2i98ddqFV8wY+hl/yCkRKHebPM9oSnTvK4oUo7WUqoV1Ot9ZW8+tjpmcPl3kcWZpGUwL6z38VI25r6UXnwLnJij6t7dFQ5gOt2BdBfrKfGb5QyEGYwlv8OArh+UKBquvcyYqpcooe45hBDJUk71cx+i2GECu1s0hdZrj+w6m2dMjkSIi5p4daJ40AF9lEaprWX1pgLOS8bkxW0EXiVXDYxsYUA4YWCDOks17HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxTjelH/rCsM4kFF2/cOJAw08gCne0hZoD6qgMJGULw=;
 b=W+3FfaGX/6omUWB3q7nkGhhe9TOmQxOH9A90xwhdlYBNt0jBZQeCwIk/kl2HrVRchznshf25YehyQsFC+mElu7pamKhGjQyMcSOauuW8En4U4BN8JNGrFMhU5vNinKsnXLBozNQdjetXlSrc6MBZBJ1+gpmVAviPastn1YbUGJ4fQVcIaHdQtLsiCQCkb/r0saFuqgoxcFboPtPbxn/pNVBHYpvRYYoNxxiSDewhKYXcCbFLYBG8YvBRVXudIuyCzSX+zOQ6mZCihuQvt6FwvKwsGVmykQ3t9zk3OJUKbaqbT09q5L0nj++zsAo05kpl3W1LEbLpdLcG67vNLZ+0Zg==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 PH7PR02MB10133.namprd02.prod.outlook.com (2603:10b6:510:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 12:59:16 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 12:59:15 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, "freddy77@gmail.com"
 <freddy77@gmail.com>
Subject: Re: Corrupt VNC display for 1366x768
Thread-Topic: Corrupt VNC display for 1366x768
Thread-Index: AQHbFLkdixseYmY/b0qksh89icazUbJzXCMAgAAOauc=
Date: Wed, 2 Oct 2024 12:59:15 +0000
Message-ID: <DM8PR02MB81211BB23F192988ECCF4BE193702@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <Zv02EDIKgmq2L0fg@redhat.com>
In-Reply-To: <Zv02EDIKgmq2L0fg@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|PH7PR02MB10133:EE_
x-ms-office365-filtering-correlation-id: ef5bdfe0-da1b-4629-9f6f-08dce2e20520
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PniJ0HnQM2FdsFRHFJj4KgKE0HGVM+c9cuPDixxEfq/XiqvfeDOM58uyx4?=
 =?iso-8859-1?Q?FlVIs0g//I6cg+9J2h1JhpL7GOZnIKrUXoLYgoYWu2zS3iLwSVkqWDziN6?=
 =?iso-8859-1?Q?TQ1lMQxGd4mE3h0zUqn3nO+DfdyGWhR5XfdCQedqYe7diNpmph5XAG5VHw?=
 =?iso-8859-1?Q?gpP+ujwT4kFlERnW0Z0NqXEIh9SV4M8Cw5QmLiDEk3KIwj36C99iZ3wCdU?=
 =?iso-8859-1?Q?CWoZu0QzyLATLwBHGM6FSmoLpuj030bXjzWTmPBlj4OawPzaZnGqaVRMIi?=
 =?iso-8859-1?Q?RxHCqp6Uo2kj4QrvPQGecYKUQgJ6g+iFDDTC7ixdE6Cvoy0hc/ZdVXfW98?=
 =?iso-8859-1?Q?Ilw5/2ViT/A2ZDX9+5omSTi4ovsjSPr4rG3nt7pxZVeUg4csxgMjBQTWpx?=
 =?iso-8859-1?Q?PRQaN6O7Rz88Lpd+GgZucm4Tnptq0zP9ZMi6JwK9izQ47BJlY5Yia5/f02?=
 =?iso-8859-1?Q?N8KVun5Gt1Ajq9lDVNvzzhtYriUmEGc3ULNKdzDX5SMbTciH4Oqnd5fVqj?=
 =?iso-8859-1?Q?4JxPPcds+M0tSUHRPiq8CIe0fL3gbLWmD8eqo5XAk9q4yu9MzGO7t6qH4Q?=
 =?iso-8859-1?Q?0rQ1iJpD2oZob0ZTtLHtmqU2J1GdsCcenBXHNsf2AakQBxJCyvOO7JhmvJ?=
 =?iso-8859-1?Q?BbKtOWBwkQOdnyPwrYwE/zoDWxebbOD6fp/rIdMrMAPIpK5gAsK0zafBA5?=
 =?iso-8859-1?Q?NZV35ODMnrt1znUZ1YDzAOCZWfGEzp1YU3KHQToSarxd4JiQ88LwvRWKFH?=
 =?iso-8859-1?Q?7sjBITg3YQdtzXz6o0ktB52f7QmVMnpIJnq5eWAp3KRSgPptiwcHtnhHGg?=
 =?iso-8859-1?Q?jMQbSzyrChucq/WsT7HsJD8QtBLUSzGrriVXJBO+u/iMmFOcf1VSrmqfe6?=
 =?iso-8859-1?Q?2RukdMDtKGXP6UBNqqj3lZGrRu5smX3tDv8mGKFoGSRXHU76RaIP5qq2oP?=
 =?iso-8859-1?Q?2XQrc5yWJ5IqN65Yr26jH3u/WJSLhXvfZ+9VDkAPQ6Spnl4SGafoF9/729?=
 =?iso-8859-1?Q?A6xbuSj0niMWWWcW6VXX/jzxktdZkckzxiGjkIV3+DbyZcOGAQ2pC2S2Hw?=
 =?iso-8859-1?Q?uKc4hVg07YpZbJbaSrGYeOVcTEg68IyEw8DIAqwKp7eP5pZyJfESVNB4mv?=
 =?iso-8859-1?Q?/4iDsmcaaY8JRAhhOR+F+GQfcB9dcX7PNkbadMqpaT4jxeDTCu/YP7VMmi?=
 =?iso-8859-1?Q?2IGb2aXJEtEpDVUb35kYK09DREFrMLfabJ7ggEn8rzpmEQw5S/+x5egPJ7?=
 =?iso-8859-1?Q?PSpuQOoJUJdJa7mLCBz5CVGxCRSPxFCPoMOQtr85MOlPAsradr1F7K0f2F?=
 =?iso-8859-1?Q?hYFvmpdWzYFBZQYzst4wsL6kfvkVEpC35D8iV9DWxjZKNAR1wwcCVkUC9f?=
 =?iso-8859-1?Q?MQ4GEV8qd0znCI9Np0sLJ8+Y0RzUN1RQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1bl3VrNNYHJlMYeCrtdGp5MSkRLJsHNOxEYHDbdcyvlKtK3R0wcfr5hM+I?=
 =?iso-8859-1?Q?3n0SPtOONBVFH+PNgAv6syyZBgI4uftVAoKmtCWa422EGlV9NQ3EN73ouQ?=
 =?iso-8859-1?Q?vMA3/M7qGEEMj78Grwf/l2Gna8cChapRNegodzJ7vNz84oAwBg6XDcmc+B?=
 =?iso-8859-1?Q?gj8NtIIA4kkQ+nDWRdJL/OHeGLHgEUvUfFla3vZUObhe9wz+kcAr7ftm5I?=
 =?iso-8859-1?Q?ajYW52JMxbc8n1wNgPuBVLxUo3O64nesfKg9QCSgxdSwrCZRuyA6JEGyR1?=
 =?iso-8859-1?Q?6DIiw9487AN2+g9kdLwQwOBsbWsnm/w8597TvQlWJUVUT59B/iRyQFHePA?=
 =?iso-8859-1?Q?VCxmqOQNi5EZgCwEBVdTiKdba7Wh3ceFPs/CYQP6aHCdFW/MxoRynyBuK8?=
 =?iso-8859-1?Q?bAYjU80vFaA38UoDTAzOImiJdN3dbC9MkeGCyIuPPGtA2LzLNdeQ7Q7KVq?=
 =?iso-8859-1?Q?vz5gu55hrVXFHkE+OegjFMRQJNN1BlvFNQHKaNqcgt4H4DoEkzV1TBjcTf?=
 =?iso-8859-1?Q?7zZTh9IoIQME8Ox1E2rsXsn5HGbMCmCaFc+BGwqSdwpv0CoES3QutaBjKY?=
 =?iso-8859-1?Q?OQ1XumQHph7KCccDHC9p8vFoDXE8gm+j3wWm9qT0biTtZ7YTUFFUK+rOck?=
 =?iso-8859-1?Q?72wnYv5/DuH6S7rJkyWck66pmp6fe/h5/OG1uVFSOLdKY/SJ7jE/1oVTjV?=
 =?iso-8859-1?Q?3ksNHx9jHvpbgTrC8iPoZBe+t8pt/qTv2iX1CwsD+tQXNFgg8Ak0Ax7hsF?=
 =?iso-8859-1?Q?p5wsNvod1/2denVUnKbzzNbtAoRC/TJ5oxKTZO19VIMRfs5TkZJu276fn8?=
 =?iso-8859-1?Q?UViefovuryJ5B2EBo3X5aJ+37GMWx0dor+CUVNMnHEn8j9qyoa7PQK+jsX?=
 =?iso-8859-1?Q?gMH8oGUPXf585CgzgNrTDityu3vNb6WXMHgfkhR9SODaILrZjgKWvQUaOJ?=
 =?iso-8859-1?Q?P+RNo/YOGDAlgiEc3JFvdWvIMmnLRe2mQviE4lviGmx/AK8IvDuhaWdUhY?=
 =?iso-8859-1?Q?nNbVEQpF0WVQdKzyzZqz4/GF7pGmswjZAJumef+gwkqs8GdxMUxcdCXuwX?=
 =?iso-8859-1?Q?XKvbliOj6QP77J3Ub78nItVenQmsox6QO339QMXlssaN4vD7+fgJ73RHBO?=
 =?iso-8859-1?Q?rPMT+IeJbuFeuBQrAxoSGKBuF1D1dKetVTHdbCc288rPMGikGoYYWXAu25?=
 =?iso-8859-1?Q?x4uZLpfjsEo667G1aTkSupZqQx3zsVrPL9mlOiwRacLkdMObbUwpQbcfi9?=
 =?iso-8859-1?Q?KuUpQtnIEfDLpw+3ka0Yf6rWl/GtVu6p3NtRO6fkiagSV6plecLqw60SXk?=
 =?iso-8859-1?Q?l/dtyXzvO6yOiFLzhaiE3sGs0JvN6eEs4LljqKBwywxo6btvr6jaNO4KZ0?=
 =?iso-8859-1?Q?/XC+KqtJN8+HNj8V7xWmNoZ+Zl6M/v3DoUqbFRiyDUdX34NJu8x8dd2dmu?=
 =?iso-8859-1?Q?1WLrwy1VcCTHstBKBKipRulMMbh4XkS4kS0ez6jiyIO31Mjm4aoinVmDGL?=
 =?iso-8859-1?Q?z/H0DcNUNiqw8fn8JGmeccbhY3ZjdRcesRzQicYT1YyOFI79yJ2qt9xQRb?=
 =?iso-8859-1?Q?T8kl8iJvrjmUmHyeH4rsPziQgJEIiDg4rGJPoBtB7Ughc7jabp7GrNI7RS?=
 =?iso-8859-1?Q?hPD4nH6j7io82oxRlkP+8ROD0+GWN+GfVQCoz9gz7j/kBqdnchNXafFw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81211BB23F192988ECCF4BE193702DM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5bdfe0-da1b-4629-9f6f-08dce2e20520
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 12:59:15.5693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QPxyREilqC06Rz6Ju7OmPmyk8n41tQR07OOi6i2XSgqQgWRCaoLpzMnWvUtLOfkaO4eHNeIKpRLezIT1CaPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10133
X-Proofpoint-GUID: 3xJQXAQu_75YifBgz2YSUTQvDtcbxUAT
X-Authority-Analysis: v=2.4 cv=XNtiShhE c=1 sm=1 tr=0 ts=66fd43a8 cx=c_pps
 a=EaDl3aPh6j9cByxWTcQcVQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8
 a=KIyurSro2ob729z0rlgA:9 a=wPNLvfGTeEIA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=woxs2jPCXrnu9KMq76wA:9 a=Mc5hIQe3pmepHPEO:21 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: 3xJQXAQu_75YifBgz2YSUTQvDtcbxUAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=simon.rowe@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_DM8PR02MB81211BB23F192988ECCF4BE193702DM8PR02MB8121namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/10/2024, 13:01, "Daniel P. Berrang=E9" <berrange@redhat.com> wrote:

> There's a newer bug report here, but not real progress:
>
> https://gitlab.com/qemu-project/qemu/-/issues/90
>
> 1366 is particularly problematic as it apparently can't be represented
> exactly in EDID which needs a x8 multiple.

Thanks for the pointers. My failing VM is UEFI so I'm not sure all the ment=
ions of legacy display emulation are significant. I was hoping it was just =
a processing problem in the VNC client update code (the display looks OK (s=
orta) apart from the tearing).
Regards
Simon

--_000_DM8PR02MB81211BB23F192988ECCF4BE193702DM8PR02MB8121namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal">On 02/10/2024, 13:01, &quot;Daniel P. Berrang=E9&quo=
t; &lt;berrange@redhat.com&gt; wrote:<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; There's a newe=
r bug report here, but not real progress:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;<o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <a href=3D"htt=
ps://gitlab.com/qemu-project/qemu/-/issues/90">
https://gitlab.com/qemu-project/qemu/-/issues/90</a><br>
&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; 1366 is partic=
ularly problematic as it apparently can't be represented<br>
&gt; exactly in EDID which needs a x8 multiple.<br>
<br>
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Thanks for the pointers. My failing VM is UEFI so I'm not sure =
all the mentions of legacy display emulation are significant. I was hoping =
it was just a processing problem in the
 VNC client update code (the display looks OK (sorta) apart from the tearin=
g).<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Simon</span><span style=3D"font-size:11.0pt"><o:p></o:p></span>=
</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB81211BB23F192988ECCF4BE193702DM8PR02MB8121namp_--

