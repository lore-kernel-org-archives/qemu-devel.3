Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F0C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHepp-0005K0-5F; Wed, 21 May 2025 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHepl-0005I8-Qa
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:29:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHepg-0001e4-7s
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:29:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L57Iak015403;
 Wed, 21 May 2025 01:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kciHwmRQnsr9aCwhz3wx5He9zFmn8FO1d47l3FvF1
 7U=; b=mDxZ8fmJChIcvM8n7tR8WKlzOBXo8lVUaWy6Ecwa1yp57W9t4kLnZ8wwj
 dSy0q91spl12E/kFEetUKJ+okyre5W/JswZXdmbZGgFBN8T2sujpGJ12zX1VbUDV
 VlNiY899vwSXj5cMFwsEu9v+49v9xUXasVX95uG4zl3LFMLeoiPfm2GkJCDWvwHd
 VsifCjEJOVG0kA9EJs1Mc68ORUiQjsiS4f9odkWq0NXIUNZGWFJPQKNKgkCTe1AM
 IJA7aS4yn5DuNsTG2jbySsODM7fy7KewwS+yir53EF32NlmlDKKLksNJQ5X+dyzt
 Zqf+TwWhrjBId8Mn3cHhyaQBDXYwg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwgrhwsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 01:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5pV2X0gO3hRZ3452I5eAWUAW+CIJfQGUSzkVjxA8OOHq4j+uxCD+o+yfyNBuPYUu7P645j7hAtd/GDKywQMN7DMDXePDT14smgNzCs6/rvgAjCp480zdL0PBL442XwMk4e4biyRTxWWpxGwCByRYmLuupcLPe1w1StjHcbnT9xUHPCvDFqvGJsBycFqhw3Wdq09yhonnaL8Ao7Il95Oc6xiDqOndbpHs+CKoTpIMzfZ7slHJx99Gq7IR+5+bimhDaH+nF6vOYGlyHFiHYtMxTs1EEYGdX6aDc5dFBA8EptkexYjwZiJRVZ4zQGvsGpfnFyuYQGRHoF9zISDTp5OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WvEjllUSLgYQAYmm+C9cs5dAW1gmM2yDvkUH2N/aLk=;
 b=Tle9Tno9rGXzPC2VyIBnuKrcyQnE2saAcuyTHcnMojf9F6W9yoiPBBot3zrGyHxmJTUDs/+qLSyphOCd2yiI0h5amiJqC9IunNAQnlw3r+2MttJ5a3eYbtEFEuI3ptE4kvLWZL6AOBMFPBPBJyKG01mmyyl3sw0NapFWSzcA4u4JXQWnxf6ja6JyCQmaTZpN7ROAjN1oNBfh3CL8RX2JEMYE5jzwN8hc/vS2Ijj8CJSjqGXHxb4q9M6wjnvOvRNDRE8QxlXiccpvJnYCyFEjVKzq7fyHcTj2fDseUnokc19F+RjnVNkMprHKK942rTQQa+u5xBniE4E//kGE1E+xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WvEjllUSLgYQAYmm+C9cs5dAW1gmM2yDvkUH2N/aLk=;
 b=WNQYlaBrPxPHBtdSFB6iX7nJ1AYkq642rHxqaHR4i9azRhlu4zbDcZvV1j4Tdti+wd2bGckEVMJ/66ynM+4AG30zhlcGGVC9iSjyYTNsI3/YTJWilSOEsEqwwXkJtlJjaYCgnXg8AkvGBew7LTdqxhiaAANWcz1B3VvGRoSiHkQDtNCLtGYldS5fBmf6Nq4gPo/wVUAGiQhZRg4VjghovAaVl/LoYcp96lJ3Z8KMAkBaLWMV19iMFoVifG8bC5CgKkUNQJjFPT8rS7sFUNUY1DeoVihbf0WOEmvrbSFkZtiAqJ6jVU5LAJLI5OZEDbHoJnU/F52/7+A94R+bC6H4nA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM4PR02MB9053.namprd02.prod.outlook.com (2603:10b6:8:bc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18; Wed, 21 May 2025 08:29:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 08:29:42 +0000
Date: Wed, 21 May 2025 09:29:37 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2 10/29] vfio/container: pass MemoryRegion to DMA
 operations
Message-ID: <aC2O8eGcRERFj4dL@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-11-john.levon@nutanix.com>
 <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM4PR02MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 99be2d76-fff7-421d-5c63-08dd9841a25a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ujOCvULRJVPSx8qyDqv7ooRncNezO191SPmrKcTePlCbJf1Izdm4l33cKU?=
 =?iso-8859-1?Q?tEW3pUw+nV17u7CZjqEMXpkFvl8ziODL/Y+R6KnB7pJQsqp6GOLIp5iALA?=
 =?iso-8859-1?Q?+BvOZJg5iG3k5zphA7RrMEBC/1RCXAHTyoaryCfzlXd7/JMN2EbYo1AggC?=
 =?iso-8859-1?Q?6KMm+R2RAqdMLJjNAmikg1zzkrcSandzq9sHsKKXXRdUOzNAaevxtV70Xm?=
 =?iso-8859-1?Q?4V2VHx1kKVnp1f5j0TqIpgTUPPWqeh5570NQGHX6TTlctZ/T86vKRaLx45?=
 =?iso-8859-1?Q?RGIna0OXQfYUww74ScVN7FZGEkQY/gndkvZKSlGCkdIAwO4sb/Gl0WPq5o?=
 =?iso-8859-1?Q?B4JY8XVYnpj1rT0dJeUUSM2lnQF/SeJ66JxdwUg0kEYW4L2aXtc27dVb9l?=
 =?iso-8859-1?Q?Zqu/v78liE9lZx2ryjqA+hqVEqBj8yw9QiGeEmdsfLsJbMpTkdpCnkLeUJ?=
 =?iso-8859-1?Q?/U4BXxbm5rgaPVY93fplTCa233f6nc+r1Fiii74GXSDcRhr2BcSFYh3yFk?=
 =?iso-8859-1?Q?tJaOMiiKDwsg571KLaMSPtHau0e2ofz/FO+qUF0NPgC16EalCQDjdZPm1w?=
 =?iso-8859-1?Q?75lK5Ay95im/EoByxrxn4EYHQvgj7GKD3jQlPbRL15hTNctGrD75oB0/j4?=
 =?iso-8859-1?Q?gjgYKypVraGU3MJ99M5KMklLIzEktAObO/uf4RPEGEZKahY5ySeYz+q/8e?=
 =?iso-8859-1?Q?OlNHkevqheaNEnQk/rHwqp94/YyvfwJacwP+AxcMQCEcOPx39F8jAXIDb4?=
 =?iso-8859-1?Q?+KJ6T11ABfg4hgbg1uzjdJ8d3nSLAfC4Aurxbg6eLTgIa+q2IYYClOzDM8?=
 =?iso-8859-1?Q?J9A+w8klzStK3LLIAGU308F39ZvrPoSbVydFSJDpicHecp911pAtfS3sTD?=
 =?iso-8859-1?Q?50tqnGgrqjy1Eu0kwTq49yqMiwtd1zPhkaWrVHoDc9BxUQKjBiBncVJ0I5?=
 =?iso-8859-1?Q?RM7mexE2ZpU7rDLou+tEPG90Ra8Vb27W7DbNkW24DsGfJqTb62Oi/wmAWZ?=
 =?iso-8859-1?Q?PIuFPlqVxfk+xvfAvzz9M5xA/l5aKS0NkasawoQhAhccoHP9N7I50BUy6f?=
 =?iso-8859-1?Q?TqxeOXvlAvQKynY0KGhf3BV1iw23nyA5JWYJSRPWAVIAqMdI+PUKANOF9r?=
 =?iso-8859-1?Q?Ko/6IvSQjP5nN3m+Wy8AE8a3Hw5pv01C3s8bBgLMRcuvjAHTB4rt/ZinBy?=
 =?iso-8859-1?Q?CoVi2Pfl0NzzSz2aOwgH6hOidp0qczxqdu8gBjXl5rHXiOe8oTHFMmJPqL?=
 =?iso-8859-1?Q?qD9jhWZJB8i9UHN2+1g7sAUhGxr0dUdzxM/p+lRPLBzdNkD53uvi8RtBC9?=
 =?iso-8859-1?Q?pZWgg74Xv6YI0129PPGOPeQDPkGag0h6iiadBt4z22vdEs56RIY9D+fU74?=
 =?iso-8859-1?Q?I6nRBN/JIn6nX9kilW39VHmdHu73hqM3dsgE/f0lnJA1x3zGak5hzeOLyS?=
 =?iso-8859-1?Q?INjT5F9wOTRzc02xxcvvfMbEbqqctTTI3AqSn4+lJZ7rseIG1oNhxiJrjb?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1ORIYAyimjabxB3O6JzMBjmJRNbRJHQX9eZKXkdONQGrBBHp8njIjuHWh4?=
 =?iso-8859-1?Q?3ZTz9EJgR8pkYYbPD7PgPcdWknpyqklKJ3Y1fny9hNDqf+Qg/aLVll2cFy?=
 =?iso-8859-1?Q?GZ63mGgCc7HWAP5FITdVbCx8BbIDdgK/i/nLVodVu2g0c1W1Gc5MaaLfCb?=
 =?iso-8859-1?Q?1uquMHTAbYequZ06kXExMrUfHT3YdpFnY9WwVs2HcHOGjRVGxqbzBp94uC?=
 =?iso-8859-1?Q?FZ5CeKJTu1Ut0y0as/gVIMV/2nt3GlJF0ADQKvjWKdn/QQyANI0bBqajyP?=
 =?iso-8859-1?Q?4rPk39vOodvKHBL5x2PWrXtCwVmzvAuvtHjTG7RzaE67Vm5XwVmIG/rE6e?=
 =?iso-8859-1?Q?89PV6wJL4z0sA35Pn53Bkfnt1bqJbyZx8mPTaQPFJzNz3/7n4u3sXa32Sh?=
 =?iso-8859-1?Q?cuT9iRj7T4zMiiLfaT25r/rzBXRyNnpeqi4gu48I/C+UA59KAgg3mdUVC7?=
 =?iso-8859-1?Q?fGWyqQA5bwDU9fcHBAqkoRgV25FU1DYsW0ppRoET5uEk9mNnRfurl5z6mL?=
 =?iso-8859-1?Q?rkwUbMsmDsasKMR42cYYwn3rhaO4IA/9M1VrhzKdwFekcwH5wOLt9r8rOO?=
 =?iso-8859-1?Q?a9ZpKyyOs92NniPVMTMaD73V2+3BZ4GvhfjLSz+m1mEcN8zM0qQkFuNRf+?=
 =?iso-8859-1?Q?dnP7NL5exX5ovrfkWX+8u/HlNFRjkfsffufW0OKERo4SmBLvdNPQV0LoQa?=
 =?iso-8859-1?Q?hu3nKgjZaxaAdOH+UaJSSmrDgwt6hYCbLLtLAr0dLHGFbCUfw0X8gmhM6W?=
 =?iso-8859-1?Q?RvAv/b7o+sr99A4FUnvAVcIsxgaocVFBXYs5OSYQ/htjL2X3doSjDzaz5e?=
 =?iso-8859-1?Q?Ly8bPmJLgjB4FghimQUnj6Yqo8dirmwFA2dUMyntN5PvKpevNFmIxwBJ+8?=
 =?iso-8859-1?Q?SWm9NHoxv9ckv5C8PUmC/tCaIH1lHyA1uAcoB8bS3+kc3h4kT00UQ3EjtS?=
 =?iso-8859-1?Q?5eEOJkPVpA/z8H7Oujo18uy9KhB986J9TnFTCvVvr78zqnVV5Cgh082xBT?=
 =?iso-8859-1?Q?H0ehSL2JklTRwwNnhCUKOpwDX8ex3MhYB9KCDClY99fNYdzH2ZZ2q3SXq9?=
 =?iso-8859-1?Q?ek+ACcbiiowUz7ZTi1d4MflbXVd0lMU5L0KJel1SI2yrEb+PARMfW/mxvD?=
 =?iso-8859-1?Q?2E69sxRzYPynRUwSppCkbbwLrGcgQ+iaKrj8F1xHO/zSbKs5mF0/dNBkzU?=
 =?iso-8859-1?Q?0FwSiCKmgDNfvhkK5K8bs26pNgR3oRcw8c9ZY7GWmX2qh3T5Kn4krp1BAH?=
 =?iso-8859-1?Q?l7F09S18G4ZhpdwCpMvwIPMPlM2rHdwsxmgiBcHPt26JRItu9QpKHR4W9+?=
 =?iso-8859-1?Q?aFaGZnFiKC9yq2Ww6LAKkE+8Yel2pnHBZuXPeNE+DW92uPfuNnC1ZUNEOs?=
 =?iso-8859-1?Q?Gk90KBE6IJNkD+eugKon9f/hFy8Mg/2rLw23XDsBrRVWJsbaNpmKr3nS4Z?=
 =?iso-8859-1?Q?7BqatjDuKzdUZla04S1GpVrwwnR1hEgEG4FFJ7mF9jaVQXA8EqKbRDwQSP?=
 =?iso-8859-1?Q?qxrvvpLFd2Rv3RzjPFtc1QWWCM86tGDrmzH76iZ3uSQuBvLMdaI3fqdiBU?=
 =?iso-8859-1?Q?kVw6nJo1HPgLBnvd2watCxWHPhLbjOKpTvRZO7PkYJ5SAGs/VAUHBZW9kt?=
 =?iso-8859-1?Q?RgL0KzxLBxYV34ekM3vO+hyyLMtoFR3BXl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99be2d76-fff7-421d-5c63-08dd9841a25a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:29:42.2002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6omBisimYgYpg4b8LAyV8WSg4go0zKufn8mIzY34x4G0qX6RNUXJtcp2TnsgBxhUqP8e/N51q5WkB8jVB0KFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9053
X-Authority-Analysis: v=2.4 cv=C5/pyRP+ c=1 sm=1 tr=0 ts=682d8ef9 cx=c_pps
 a=Ku5Q1SXtyGRHaGBacwLxwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=zdPkfvw6A7Tea-IaKAwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4MiBTYWx0ZWRfX1xIrNApyVTWD
 eLE3JGBGbmK6kRWuVxnS8dj3nf3YNIZdhohXOhOKvxeTkwJkQhFeZB+/VdopJBUbz7ZYhGDgMd3
 gCeUXuGfqEn+zefuiSEUkFNAQV9aLN+030Hmh/yNl/HCuEswD9HspZlNovan8KPOgYB8wV3fvXk
 eFnd5Vjr9sXHM9JhGxv+urxih7NcaywwWvEXuHcTm1KOnK9FyG2vY2gcetHX7oIw93D3Ll9C1Js
 czl7vUH5n9uK8O8/7Qiw8FxCv7ehwzRyZ28DVOpQ/FulYY0Oj+biiPSXDM8AcdmnWjgj8PZykN/
 wg6jjS/n23TKuiU1fMwpoHSL5LI8Y69jFlHZ2KMSKEbA38kxgUfNOwYVWz/yeKStlaJq1RLKHoO
 msun6YDpFjIvDZN/5HrLj5lXlho3GleCE/CemYoavJ62Nac4PtOThegVaT5HQJ1rudZqV29Q
X-Proofpoint-GUID: B9tfAy5Pwboy9aZrfpjEkL2j7UdwSFzd
X-Proofpoint-ORIG-GUID: B9tfAy5Pwboy9aZrfpjEkL2j7UdwSFzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 21, 2025 at 09:43:11AM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> +Steven,
> 
> On 5/20/25 17:03, John Levon wrote:
> > Pass through the MemoryRegion to DMA operation handlers of vfio
> > containers. The vfio-user container will need this later, to translate
> > the vaddr into an offset for the dma map vfio-user message.
> > 
> > Originally-by: John Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> 
> This change conflicts with :
> 
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_1747063973-2D124548-2D28-2Dgit-2Dsend-2Demail-2Dsteven.sistare-40oracle.com&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=v7SNLJqx7b9Vfc7ZO82Wg4nnZ8O5XkACFQ30bVKxotI&m=ZGgaPL84zJdxC-NJiZdGWRzh1WIXiIKzDUt8YcytF-NfxOT9I_gSOxNCph5DfyVM&s=V-_fptKbd0WpQ_JDJWze9TxsbOrvVfEm2EIPPH6HJ2k&e=
> 
> Steven,
> 
> Could we use this version instead for the "live update" series ?

I could use the ram block for the offset but the mrp is also used here:

  86     int fd = memory_region_get_fd(mrp);

which is

  2406 int memory_region_get_fd(MemoryRegion *mr)
  2407 {
  2408     RCU_READ_LOCK_GUARD();
  2409     while (mr->alias) {
  2410         mr = mr->alias;
  2411     }
  2412     return mr->ram_block->fd;
  2413 }

In the tests I've done, mr->alias is always NULL, but I don't know enough about
MR handling to be sure this will always be the case? Perhaps others can, in
which case I only need the ram block too.

regards
john

