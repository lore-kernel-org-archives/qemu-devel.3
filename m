Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C29C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyC9-0000Mc-35; Tue, 10 Jun 2025 08:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOyC5-0000K4-NK
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:35:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOyC3-0008TP-9f
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:35:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8Ga2l009745;
 Tue, 10 Jun 2025 05:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FAWB4DFNsDPW4VvbfRQdA+zShbvsYaolaGq6aVO6N
 xI=; b=HkpCXDCoiSQ9LSsqN5NKBhJRSoWs8GJH3wmgpvJipW32nARvqM46gQGH3
 ZpKm6K4bMA8g8mFGJk1UcAswIhno3DbjD6ntzWIGSKsq4f5AfEwSLUEKUsw9e72P
 HHaZFR5uHMiKesetakIzsUnJEkCLJWjH4lhnSGNNLn5OwluzzJ9GrtVATd3wBVnq
 sdB3xsydOX2AdJpbaoUsI6T9AqiKOwqP4EcTatHRpsnTB+X4SJqWI4JKsnH02UmT
 xEfaeyCawzxRl0X1dazFSf5v1pw5omNudixttFqTtEYVEL/anyot9vFG2lj+HKU4
 phXSzptj0mvZDzz0ofqZMREX7zvXQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021077.outbound.protection.outlook.com [52.101.57.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 474myywq8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 05:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxjABZYfvBW32gcTbZn6GzCaFw9qRlEaaYLitBwEETuvP+fon5J+QHbtUT3f/ExEDb4sipSlvDKftBdvgRZNMEmQZi5mgtthMi8P+IqVpwfakZhMJO4QPJeOR+oVTZd0updF/schfvylqZPERvLAeb+/aH374yAdwy9efI/XVse1SZ7EIjm6AYQlC/EeUNaGI33eSbM6mHDlhWUbJ3iMfNITGniIIc92RJMUMAzTipA1IeGlWqYN3ufqy5n4WZUY1TUdLS2Xd3/JrKbxUAhQhxSEuhxspGGDkjxpFW3UWsJs6qLYZr2EBRhv2lN+xBO1dWRt4GiINnr9opnj70VIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9nQk2GBsbNbWXUojQHoEuG/TDr7TB5qquAp4N2pWFk=;
 b=FJGQ4no6xfeJdDNkAeOCL1ad9LYBf2jZcPibp3cJFfEbwqKpQyTyOjo7Dh9c2UnVOiFuL7Fwx/rsHBxOsECHEoUq2yGNOGjx5yvbP+TuG+oBPyJ65GxSmn1b+eVt6wFLEtDo4/eSCkwhLNYHcyuyRBP8jriarYijuSbtwGW4hZeOIRUntGIPRQoK2jouN8KW6kOedc7Do1Kj0G4i2NNsKFJZZItnjOQOxb3Am8Yu5B4TK5ovS3gJQgnypz7oZo7blOFcrbHZ6LH5op6gET2I0WvYSOrsKqjDo26wp/khCinH95WCOc5h/7lAqq0k/PqY6O3Gm4i8LqsInr3BdXIhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9nQk2GBsbNbWXUojQHoEuG/TDr7TB5qquAp4N2pWFk=;
 b=lYqs3Nq2JN8ml02YwdSPTLpxm2meSSgWi7WneK9IH4ygN/qPjVYmlM+GV0Caxr+OxPs0KCT3KhdrFkKjWrSgs+5HbMt5lIPkc7n2Zdt9jP0vLtFuKk+l6s6YBnwjdFvk4kyx2ufFfCmz0hoyb/AqNMDJetz1MRmXqHFTLuM5Y/cAm3/UGli0CKejDzp524aL57mYi7lWo6ulJdo/piVWNJv7s0yYhKQ1THW401oVzIvaCh9HNtI9RMSNrL83rbIsk5rLxy7boRdQvhzdp9uq5o9YZFe9LlOVSPwGi5+CEN+7UPqJXTf4ycweUWDT9VR8sdS0M200M318Me44VhkExg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB9399.namprd02.prod.outlook.com (2603:10b6:8:145::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 12:34:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 12:34:56 +0000
Date: Tue, 10 Jun 2025 05:34:52 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
Message-ID: <aEgmbDKrjG_-luXP@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: da264846-b2b7-4552-d17c-08dda81b34b6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RtezBfG+2UTqolbqGmPlkMmq818cDS5g5BZd8/YLZyf6UQWUxxVEy/+mSc?=
 =?iso-8859-1?Q?h1mg/i3vRA6IsNbjOLWWkkb5DE+MbyWVfH5ke+8SzsesjSOTp2Y2OXufzV?=
 =?iso-8859-1?Q?hcm/dN9BsGkiM2yVMZrW6HkauwBhIYPi7mK/VT//CT310YhAsvxgMsHf23?=
 =?iso-8859-1?Q?eusLKqnMUGSMAajWjuUW1veGwFzS6nYGA2XOCFwsPHE9YAmER1SmyelxjZ?=
 =?iso-8859-1?Q?6+wqiVVNH7iP+lsDtEx+fp0yOjF6Tjp/E+Zs0l24y8GN9VKyxXCHaHDzCX?=
 =?iso-8859-1?Q?8vT3t3m5aOcMB9rUMcyqpM20EJuQsFiqrts4rfntgeRW+onJuxIAoCOl7w?=
 =?iso-8859-1?Q?Ne8Y7SFLOAy1/2g9pC5yqgn8aSvzUOrs4Hk16WRI8O67YRZcg6AfA7whAp?=
 =?iso-8859-1?Q?7vfMSclVaj2cr22e8543pc8A2TC34HgAS+TIUZUbJnnCUoQNDiL0ZCPJhm?=
 =?iso-8859-1?Q?ugBxv4+KiGqfcoWnRbc8LQt5l1lFfBVXL7sS3X5pvtxnjZ2nImgvljUQjZ?=
 =?iso-8859-1?Q?gaEgoWMUNCaZic8XbiUTTHE5HeOE/hxqvZZw/bfdJJ5kkxKI09445bemb+?=
 =?iso-8859-1?Q?CMPs7f0KYJJ261axpQmhGSF1+Tce7rNnzPujApEe4hxYi2Un2YGXpSvusA?=
 =?iso-8859-1?Q?4qzM71mwFb371gN5C+DvCHRW2tBn5clknO1/DGsIiC9uyRnnaUIxzRwmgQ?=
 =?iso-8859-1?Q?5zPpaW3hyuinNghQcly4HnfZ2vs9f5a1v/giwCSwlhr11cxprz/1p09n+V?=
 =?iso-8859-1?Q?3s+2qR3Rh0M9/yikWGCWSlsqMiTtnNmVjKVs3nFyIfrodVqOHgjsrALdHs?=
 =?iso-8859-1?Q?UycozzWAydFFx+I9U3TQ6KXAHGGDYmIJZMQNctkoRa/er9iVgnv1xb/bIW?=
 =?iso-8859-1?Q?/fz9Q6MbhqkmO+BYvChMVNnGOymR0T2VChxSQsD5b4aRMeQZj2fse6jAH1?=
 =?iso-8859-1?Q?976omcrkXNY8y4cbaZjlPLWXQ/yCr2q12e5fYbtVGgYqn3TRmvD79w/k19?=
 =?iso-8859-1?Q?J676YP8h9L/sbIR8MmlWyEUx9Pr2X7W/rjDrMu5VIjuuMMhUI+s+e45V4J?=
 =?iso-8859-1?Q?phIqngVTonAWiwWtiP5+25SW4qRYB6cH1hwlM3yJYADjkCMaIKsPjxfDcx?=
 =?iso-8859-1?Q?D3FIaxewiSt+JqvMP/x+jby3J8EHrujIl0gT1p/k03wHY7L6KoWYoASeWn?=
 =?iso-8859-1?Q?ZVqJ9YQPpHTWyzYcgS8Wms4Vv+cFyk1rF0aaefk0b6MPyidUcAO557Bab9?=
 =?iso-8859-1?Q?CMYKMqb1v34JNtUn/zAhVTrIElj0eReaiUxfeEq500QDf+5r47IwAOwFhs?=
 =?iso-8859-1?Q?ZpTT2aAbvUzZLjJ26gSXC6wHdMpl3vgLqCiNr3WRNfIqflFp+3ROWseSrP?=
 =?iso-8859-1?Q?uGO+hsco3KQ3CZSBvIdP7sJS5OtfbYgiNyj+5edtkcz+eAWpLtDD7f51v4?=
 =?iso-8859-1?Q?ibZ5hewMnPdcGRFXkfi2Dkhm8iFkHJSfWCb3gI8h2ERi1u/OnLIx9Q3cMW?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hDNAbD4VJH+eBnM+5r27LERpjFOO2VCdS/9lUhs0ZFU1TVAuLizpqGjLcS?=
 =?iso-8859-1?Q?B1k/i6DT4NdD4OU1DYgbMUq9m8idKhwir00v+NNSlogjU9mzkXPKicjWsH?=
 =?iso-8859-1?Q?YhLcFPO2XWTT+mXktlRkcRCEZ1bhSHBnxh1ee8kYjTopG6uEDEUzES3UB4?=
 =?iso-8859-1?Q?vKA9TMfS7eBxY+/jbXR2dvJNaIbXW6gOL0x/aLmEyfGI1t8YR8D5j4/Xlg?=
 =?iso-8859-1?Q?hLUjXhIMpC9MeHLibF4O8moHF1DHw6wiR/7t5tzkIF58lzviE5q1WUp3i4?=
 =?iso-8859-1?Q?i8nGLbZinHkknAgXnsPIiTKny3ykpNoFhUMNBqR8hBRBppvwq0No/7lAlh?=
 =?iso-8859-1?Q?SfhZ4wdGvCayv0YpJDfqxNM1XErasvjeZeymHT2N0MBwsMpi/3g/suI4fj?=
 =?iso-8859-1?Q?D+q2CKOWuUbg4ChrMMyXCKJSP63Re7yQ9+3O45vpvqzq8u9xwoN/yiU0Qr?=
 =?iso-8859-1?Q?MnoXYD/bhuTof6iWYSAFe1GOGk3W1U53EG61zK/a6ZjU6/0t5h54yEUmp/?=
 =?iso-8859-1?Q?aSKVd7WUZg8hJaIwHpFOt1t4R64CaMduUe7t4ELRuDmyKxG52fvKjYFNzQ?=
 =?iso-8859-1?Q?oXT8N6YMkM7s07dhvvzCbc3lSHYiueKzaMfp8d89BdKT/yvRK1PshzTvKg?=
 =?iso-8859-1?Q?hdeWXymq1VQz9TiFzj6ibE/MC36r55nHchRXkpoJJfOILltOdra2+p1cwW?=
 =?iso-8859-1?Q?FBMvoMJwttUf2QpZR7zKfsVAblIWUnz11KhZzpht70NpKxGSHcqa+x8wLJ?=
 =?iso-8859-1?Q?3Lzyp5JmGUCUbGngzcylEMU3Xx7qRP+YT/UReHfpwWKenNKZBtmNHt3t29?=
 =?iso-8859-1?Q?YOyvR06DO/+ZowmOZJQ5VWxLvYiHXJLIBEQaudqhHYQRHRxBxZLL+Tqf1c?=
 =?iso-8859-1?Q?ZeNs0oZ7IUuJplPjYla387xBpFvnAh8bK9zblHXZKKlaTx8XkWHuFnoRGY?=
 =?iso-8859-1?Q?re7G6sx3Cd648+7CFFWDINRYFoHi6n8WhfxtsGp+uUwHPsva09dCCFAudu?=
 =?iso-8859-1?Q?H6k0rPG3BxPSDqLmoxRujEqklt1mZqWvsWAG5waJKptEXFHU7UvSxJ4mil?=
 =?iso-8859-1?Q?LnY+90IOrxnMZICpmu439hogTExLnFdrnSoAV8FmP7OSLP080Ixv8/MXQp?=
 =?iso-8859-1?Q?8cJHjI4N7RzwOoriyOnDwYDIXZii6qo5H6JC1I60/MwdFnwkcouPEvVIMy?=
 =?iso-8859-1?Q?Xe0XbQOiOL5zEJemm9nJxrSCj0IkVMo8M3rMNeLqVL5cz/SPLlV6Dwec7A?=
 =?iso-8859-1?Q?cj/MJceok4qWn27PAYacZ44DP11xwEr10UPUnsB3Cp8o/U/UvLho3Y6R6G?=
 =?iso-8859-1?Q?0n5kPVKzbdZDEkxKxnyPiZgKAX4Rq1iU+vW63auaf4tDy/7YO8WwFZCljJ?=
 =?iso-8859-1?Q?NgW1B3HeGGJCPHPa2cV8FfS+IU/GdZePo+bLaqG/DIH6U5GICp44Egk0Jr?=
 =?iso-8859-1?Q?u84dkh+DvAKCfiXgsg36WOwlp+UbNqoOmCKBHueeADxIVnKrGf1AiV4Eap?=
 =?iso-8859-1?Q?6BN50AsPWvb5qt14jUfYE+5aPXAkfKOPkWpgT/2FiDcYimwtaGo0xD+a0r?=
 =?iso-8859-1?Q?jzV98R/pZnMvQN+lI4LA99DcmJy2TOSYKNL7yzFm2RfQ/SUOp+Xsq5A2UB?=
 =?iso-8859-1?Q?168Ypoo2xYbQOlQy7MbVUJpyNfwDZg9Kzl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da264846-b2b7-4552-d17c-08dda81b34b6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:34:56.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4y62P+ZEbWnDFrQ1AWV9pIqImkQi+r7Sd/EvRARypxKSqKp7nNjzX9H4aZp9vpjN3auZ0II9OCIG/dqRa3+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9399
X-Proofpoint-ORIG-GUID: xN0lOGd_5PRKRPiKb8gGgH2KH2A_fhqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5OCBTYWx0ZWRfX9Q2uXeD5YSEA
 xDcEpu2K4HBH4SWexzXNRvTEi6Tp5grD6+Pz1LDuBwAsMX5hGVImGz6m6VHQcgPufcZH8LwQLL1
 mFP36cYA38IpMKntY8zjoXN4ytNGtiEp/GBfQTy9Kvgh5T6nEd81du81l+HgLId/vrPjYNR7iFX
 HpvBXRH707VG/97SvIF6j6nwgDavE/ya1NKBlXtLQfQrLgFJ1XBxjNSUDutvZjFRHL13bCV1OM4
 GN9/DddiD1QZB3fkOOeR+ue1XO0h6t2mMmtprrupay2uH0qNqlOchNhQXSmtKjnmq72bjyhKwTV
 woZwlpGK5GKWGFZVu0rZMZeEV27X5nGrAVj7qu4eJFKYjNKb3oKCp8EBpkqd9U42BwMEQC6+D9G
 DQmPQ1MWfcAyhGPYDWId8HREs2qgbwdMbYTSaXECRy1EB5qeLq1hohejl2GqXSNlejBimyJJ
X-Proofpoint-GUID: xN0lOGd_5PRKRPiKb8gGgH2KH2A_fhqs
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=68482675 cx=c_pps
 a=BLvYkjn5u0YClySNKAgoiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=YsqgzTaS5If-XB0RaMkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 09:42:41AM +0200, Cédric Le Goater wrote:

> On 6/7/25 02:10, John Levon wrote:
> > For vfio-user, each region has its own fd rather than sharing
> > vbasedev's. Add the necessary plumbing to support this, and use the
> > correct fd in vfio_region_mmap().
> > 
> > @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
> >       /**
> >        * @get_region_info
> >        *
> > -     * Fill in @info with information on the region given by @info->index.
> > +     * Fill in @info (and optionally @fd) with information on the region given
> > +     * by @info->index.
> >        */
> 
> Could you please update the whole documentation of the VFIODeviceIOOps
> struct and document each parameter ?

Sorry, not sure what you're asking for. This struct was fully documented in
38bf025d ("vfio: add device IO ops vector")
and its subsequent patches.

> > @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> >       vbasedev->io_ops = &vfio_device_io_ops_ioctl;
> >       vbasedev->dev = dev;
> >       vbasedev->fd = -1;
> > +    vbasedev->use_region_fds = false;
> 
> why not extend vfio_device_init() with a 'region_fd_cache' bool
> parameter instead ?

I could do, but you previously asked me not to add an "io_ops" parameter to this
function and instead directly change it here - why is this parameter different?

> and avoid the extra VFIODevice attribute.

I don't get this - we still need to record the boolean in the vbasedev.

regards
john

