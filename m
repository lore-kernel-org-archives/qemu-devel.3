Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0Zb-00010n-5d; Mon, 19 May 2025 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uH0ZN-0000yz-3F
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:30:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uH0ZH-0006PI-Vx
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:30:16 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JC1dDU022744;
 Mon, 19 May 2025 06:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IAOkPIqchhumduB+GmgN5eCmbizCiwbif+bJV72rH
 3Y=; b=AcjYN60xa4o09+azuLjpAU1HPGEo2mx2T64kLMH6o63j9B6nNzI9RRNQD
 w23oU2PlZmbN292jF/e4/Xp/Jm3mVXhIHKKPoM1816yUlMvwp7nLUZFEDbrYUTu/
 zAS9dknJRdUsC8YbNa0KmSU+itFGGuO8g0Hi1EOffk1/YkPz2Z6Ki883OF8BT9A8
 fdvFZdFOY4x+6HSthKaYB+pTKJzmMfwJ0SW5d11dk8QYqIC1fRzcoHjgVUNPdCNI
 D0VmLwai1bZ5uZoI7G0u60yLeQx7H6jK0yJrlTm/yDsax2jr+bJYlsqN7K/I9vSb
 RL5OBtmu5OUx1Hs+dNuBTueWtjn1g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhbbw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 06:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOLd6nL6gOK/bckjFw1mGIXj5EZT0NrRxt9wwRVEFukAa42mrmnaNKDbsvdhMUvl47idkMwKZXjcI81NzzkhkCvmeEzQWpDi8QFFYdakX6gkY96z0Sv7E9+fMAI+sbisyN1cRR+rRbxByzJkYl5esWjO7xxHuKBee1NK2367B7F3E73envZOyBa800sdP2Wg8jUOqN+lec5ZEuq9bPJ7c0aZl0RltY2CTXNdotwhuNgvjrdtnuZvaxi/qHzxmveNMeCz6qH/2xNAk0ytkZPwXDDLaeqZrYR8Q3KCWh0H1HTz4ufRTwwiC+xICBTR76MTj5DRCG1wyHlKagpkpvAEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAOkPIqchhumduB+GmgN5eCmbizCiwbif+bJV72rH3Y=;
 b=AYhUk/x359c7Ztbi1gKqQLnSPMefJI8w6+dVcto5th/+uFY8lagXpvsZmFMFqt7A0X9BugS4rnWxOvjFZLeRSsparATbr6u4ZTZuR3zJOJ4RJxoWoiURYB/sav4wwg4Wjl++DkXn0SkmxjtqA9M9LjLe+5XnvjwfWElvGGLisSQ3OIjsQdXgtgi03nf7Y0ALBCcnBh1pcu9F6fW3creWGBnlU6ACUEw1aRKexiG1SyWt6pzPa5uqCfZikloc2rPqQ5UOF8pFYPyrqiuzeXLL4hQcs1l+CPrFnhTxGlDevhjb+0JFNaVMvTcQ2FVc4SeDf56a69tRXVS7Z/XQ9v9EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAOkPIqchhumduB+GmgN5eCmbizCiwbif+bJV72rH3Y=;
 b=l1gpFc7CeTZtVhPXV+yYEBb12vY27b552N1dX5poYKvxAGEp3hrFSa7k6XhdUrCiKE9c4JIooZo8y0Ret8F5YXcWv2uOKsNJOPyU7A+0qxIDsrT4fbYjFLRi4VPAgc0hZLnHqmRs1GqrBHnDUVArY0VngtJrYZ4zynDXM6alz6qzptRWBD/H6bih9RZULPWk8R9k1/p1ofzjswCk7Lstp/qCcXCfISoDvM1RHN4onRvyQ6AGxXxCgwqwa5xuPujROsl0MbwwjPGMSXcBeOMYiwzvCHQ19G4y/3t0iwg1LCsozCxHTLZmj/RsqDNbzCnac5nlzJMovlHi3r7vJJQrjA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10383.namprd02.prod.outlook.com (2603:10b6:610:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Mon, 19 May
 2025 13:29:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.015; Mon, 19 May 2025
 13:29:58 +0000
Date: Mon, 19 May 2025 14:29:54 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 00/27] vfio-user client
Message-ID: <aCsyUnQj33YEtAjb@lent>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <6cc53fff-9583-48cc-a5e3-3dadf1dd215c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cc53fff-9583-48cc-a5e3-3dadf1dd215c@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM8P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4806d9ee-ee92-4296-5c77-08dd96d9401d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFl6ZHI4cCtiU09LK1lRREpzSll2WlZoaUFQNDdwelQ4aHNkT3JWN2VEZDN3?=
 =?utf-8?B?dmxVb053b2dyUDhLaTlYdTZ2SEIrdHJMcWR2SlpjY3dHK2tPWG1tSnVleHlX?=
 =?utf-8?B?YUdmbzlubEptc2tMRVhDY1NJWHBFdWFnSWgxNXUwYzhROUxXcGJIcHZjeGhx?=
 =?utf-8?B?TU42REIxRmlLbHhzNXhvWHNUK0xPSjlIWldYbnpiWVpwVkxCY2lBSzJnNDRu?=
 =?utf-8?B?Zk80L1IwZW1QSHFWeUNjMlM0b3FtcXc3MTlRNkVoK0tUSFhaVnJ5aXA3eTZP?=
 =?utf-8?B?bW9TdGd0YVpXSEhOZzBFa3FqVUV4cExncW9jS25RVjdRRitqOE4vMFE3dWtr?=
 =?utf-8?B?Y3dMcHhUSFlzaytzZ2lJQmlPVEhoWHU4TE4xNWxhTUNubExXWkpkeml1NHhB?=
 =?utf-8?B?eDh3UWMzQUJPSGNvN1ZPVUpaQW9WYU0wUytjMTN1QWJyNHpiZEZ2LzQxWk1a?=
 =?utf-8?B?TkRGYlNna2szUTNGS2FYVVVJajJSQ1NZY2p6d0EvbWJRZ3A0eU1jUXhISmYw?=
 =?utf-8?B?SmVtK2kzY3NySXloQXlGeklEYUg1N3ZKZjdmZ0NYdGdtY0Z3OEFxYVppcUFa?=
 =?utf-8?B?aXpYOXZMRTZVbWF4cjlPUUhNSzM3UEdSUGFCUlhMNEQxYjVSY2pYNDJNTWI1?=
 =?utf-8?B?eVNiZCs4WnJzdE9hVUJLd2pkaHA2K2pqSy92ZXhIVTVkMHplYTN2OTdVdDdF?=
 =?utf-8?B?M2hRYzM5bTEwY3EzQm0vQW1lVUU3SEd0VFQxNzdaY1RZNzlocVdRSWtpY241?=
 =?utf-8?B?cG5mckdVaGtFM1JEWGZEaWtVVVNrdytLcWdqYUtoQUtOM0NNSm91WWpFSWtp?=
 =?utf-8?B?dVNnYU9ySzZyMDE4R3I1T1hsdDVHNzRwZklVNVdHc240TkkrQnl1MW1jbXVm?=
 =?utf-8?B?K3FOME1ER05mM09ReFRWZ1pxVnpESDF3WkdmeGdOZDdyTGFBSDBRM3AreHBi?=
 =?utf-8?B?US9wakZxcnJ6KzdZVEJ4RzQ5WlpLRjllZlJ6SnJxaTAvUWFsY1ZDVkd5cXEw?=
 =?utf-8?B?ZXBvbUk1NjZmeXlYVHVDQmRyMDlDN3VPVEhYMDAyVzJEZzYyeTdvOFlBbnZQ?=
 =?utf-8?B?RnNiQnFvZVZsd3Byc1ZXandNclV2KzBTSFAzWURINFgvdjltOFhzR05xSmlE?=
 =?utf-8?B?cVFKRDQ5aWZuZERHbmtzQ0VGMUF4aTIvaldJZjlVWkJ5LzNjaEplRUVESWxt?=
 =?utf-8?B?YWtkUVhpY3IvNFU0aEJPWXh6aEQ2ejJLeFNDZjFJM2hkNTYrNTV6NmlQL1NC?=
 =?utf-8?B?eFczQ20zQUFNUHNrV0EwQ0RkbUxXdjJ3TG1FbnRDRG9vd00vZENTSWRaOG1L?=
 =?utf-8?B?cGVJUE53dG0xSGFKenhqY3oraVdpRkJmZ3IzMkdLdEk0M1RzeGYzZmh1OUV1?=
 =?utf-8?B?aWYyZmlBVHlyNUJYeGRlSDVSQXhlV01sYXZEQk5qK1Z4ajUybWdXUVJ3NkR1?=
 =?utf-8?B?REs5UVhtQlJjdXJBaDBuZmNYZDE0dlNxUEthNFNxdHhqajI2cUZ5Ym4ybnNt?=
 =?utf-8?B?WWs5YTZ1WklleWFGN09INm5XbVZkcGlDbGh3eXgzaHA2Sm5MWGU5eGJ1cStr?=
 =?utf-8?B?Tk0vSkxQTHNUeSsyYmo1a3U2aERkOCs4ZGF4RDJpQmgwS0tXRFNJKzdMOWF4?=
 =?utf-8?B?OGZpbG9jQUV4WDd0TXFvT3Qwa0tibWlEbUhYSUk3Y0gvU0V3eGg3VU9zV1p4?=
 =?utf-8?B?WTFTNEViUjNtbTNpU0FuRjdDUWp6SzNnbW1RNmYxSGFFMDFETlVWaFdhdUJO?=
 =?utf-8?B?eHE0Z3JrRzRWVXRkZHAwOURHWUc4SU12Zml3YTdSR0tnSFg5WXV5RFBiTmll?=
 =?utf-8?B?V1l3K3NEb3h6YXFqZlYyenVyU2pleTVYL3VhaXQwaHZ0bWR4UHZ6eXBkc05F?=
 =?utf-8?B?WVBialQ3UStkQWRwUUJUa1ZqOUNPV0FTa3RFMGdVUlZUZHh5Rkc2K3Z0M3I4?=
 =?utf-8?Q?VX2aa9b5t3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJYWk95UzJpd0pBdklIdktod3hPS3NuSHgvZE9DYzh1cnRzcE1uaUNNWVJo?=
 =?utf-8?B?QlRrcXcvTHpvNmtZUlFIdXBhN0FJSGdBTldTdlFQMUwxMTRkSzZGZGNPazh2?=
 =?utf-8?B?YXBmdW9oMlZZMmY4ODlBdzQwV0ppSW5zcnFpc1dsZWlXMjN6WXhXL0xCbHRy?=
 =?utf-8?B?YlBmVENzTUJabEFHMVUyb0NvSm03ZmlQRDRZWDVwT0VMZ1VHUmJuQUFBVVg5?=
 =?utf-8?B?N0wyeHBIYUIxN05acGtuMGx4blJkT3o4c01tSVhkUHJOTnE4ekZlTk9VazFJ?=
 =?utf-8?B?RGF6ZVAwZDE0bkVweXdvV0hFVDFtbjZDcGJ2cFBEb3FvU1FZbkdXSVZTMFh5?=
 =?utf-8?B?NWJvMVdVZFpPRTNzYm43eEhVampMY0ltS1dqZm5xekEvS1VUUmEwVXE2Q1dk?=
 =?utf-8?B?YUp5OHNjR1hBa2UxOGdvQ0tKekdPQk14bnE0TDhpc3B6RFBPTGpDQWpSczFp?=
 =?utf-8?B?bmlGdDhuNVRNTFVScFhkeEl4bXFYUHNKWDFGZXlXSGlhK3ozeW5QaFhoc0xT?=
 =?utf-8?B?Y09MWk9udC9HSUhheTUzWXlKbG9NbGpHcHNrUmNRQjdFQzZtSEI0SENuMENp?=
 =?utf-8?B?cTVXVVBBUWFNSklhNjZQQ1BZZzZpeFJ5VEY2L0hzWVlLK0l3ZUpmRzU3QWk3?=
 =?utf-8?B?bmFmUlk5UFZnaWFHbDlOZ21CRW9SZUpJeHZ0M25WclF1Y2c4UjhNWTUxSmtR?=
 =?utf-8?B?ZG1EV3J3SmxzWkl1ZUNqLzBRNnRibzBtL3lvR2xlVFkzOVlCUzBKUWpVLzc4?=
 =?utf-8?B?SzJHZit1UlVxR0xpeStmZHpoSTUzbFBkNDJocDgzMGpyM3NhYlhsViswekJu?=
 =?utf-8?B?V2xnN3RxdHhvN0RveFZYYSttKy9vUXJVb3JaVm1KRFI3d25zNGNxK0JqZm9S?=
 =?utf-8?B?QVRTZnZXaURDalViYUF5N3BscXMzSkhYR3VtVWU1dUtWUjRuYlVyRlhaMGFI?=
 =?utf-8?B?ckxmeXZGS2tJd0FRMGxyM2FUWE5wZUR3bWViSXZmU3RaV2dLdGVDaGZ1M25G?=
 =?utf-8?B?b09SQUxTczNtaWpuc1hBajNWTUhtdGJVSFY3U1lqR3QzR21NM01jdnBOdXdo?=
 =?utf-8?B?QXJiVGlpL1A4aGc0R1Z4ZlNWTmZmc3l3M0ZvTC9JVWREZm9TeW9IS3A4bHR3?=
 =?utf-8?B?RmtXeVF0Q0dPSkN2elJTMkV6aHh5ZmZxUytvWWo0T0VDSm1yczBYdmpzRFp3?=
 =?utf-8?B?d3dsVzNUcmRNais0WW5JZUtEMzhtTk16VDEvSFJ1UGdoQXJ4RUw0SmFPMTlW?=
 =?utf-8?B?bGJmdkdaUWJpSWtRZjZVdmRaemlLL1dSNjlJaGZtTm1ocGxSRU1GNlNqbmth?=
 =?utf-8?B?aThHSUtuNTJBRHNueWZVZ0lJcFpGbWhiN1V5K3I4Z2I4K21uZnhiOVY5UVc0?=
 =?utf-8?B?NGgzUlViWnB0OWxxeGdhMXVtZlY0V1NPcjRFaGFxTk9pclZsVWc3eXdGb2RY?=
 =?utf-8?B?b0NUN1U4MUlIQTVpOFVpQjBoVGNESlg3Z0lhNklQNzhHdFpJeC9BTmN1ODNq?=
 =?utf-8?B?WDZPWDhrNDRHaHE0Mm5qQWVIQVdLSWdTa1lIL2lsaXo4bXRTSDhQWGwreXZD?=
 =?utf-8?B?WTFpbFBFUEk3RzN0NTY4aWZidVFETDRmaDh1T2JFTWkvaURmZVo2MnFMaG13?=
 =?utf-8?B?bTZ3SVM1TXhCZENOeXpqOXR3akozRzZGWHJQaVVlanVPV0Q2ZzQvYm4vUE9t?=
 =?utf-8?B?UXBWU3NzYllhR1hzanJHSUdiUVZPTmlIbnpVc3ptdjJNR3BmcTFlcHIwRGJS?=
 =?utf-8?B?WlJjWkdlVGJkVHJYaG96MDc5REZIT1lPWms4S2RTWTNtNkV3K1JOQWNOcTZ1?=
 =?utf-8?B?Qkh5ZlBsbzdTZldpamRhZHBLYWRYdTRYUHZlalpiV1E5VUVXZDRRSHphaFpu?=
 =?utf-8?B?ek43OG41YkpnejVGM2h2UFJ0cWdBSVFwSTJtT3lxZktRTjNwK0prNnBtL1FD?=
 =?utf-8?B?UlJ0cWtERUwzUUd1UDFZU1lBZ3M1MlNsSFRYaStueVF1UWw3M1JzSmtjNHJ5?=
 =?utf-8?B?UnBtZGFBcmNKMDFXYllYUWYyeHc0TGovcDNLSUw1SnNFNnlwVFZydVlWdW9O?=
 =?utf-8?B?MEp4N0VIT3lRQjRCU25QeDB5V2ZsVnozSUMremhUU2NMdmxBSGlXYVY0MU8x?=
 =?utf-8?Q?fyTUnBrGeUJBA2zSFpjNF49we?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4806d9ee-ee92-4296-5c77-08dd96d9401d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:29:58.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftIMU4kGqS3jFTzToicYIn6EnAaU8Hpwh5hjH6+Uvcf8KKGqdX2Fb4KeuXZuo6Jwco2iCyQ2E6F4dgQfZqgcBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10383
X-Proofpoint-GUID: Rdrsi12vBhFUIReYTiF9nSECmPgfbLxm
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682b325f cx=c_pps
 a=R19XVbJ/69TrMGWtO/A4Aw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=zcQXEM-aj3k-TiX0V6UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyNSBTYWx0ZWRfX7PKMEv9V2AnS
 I5va3FbcdGs5TtOwu8atGYxUdjYZhO8+1zct96RJVi/EK8+2iqHmrpe5a0g6PhA5UlaMCCtCIWO
 dMUS55JlIiAcbvYNitcTsXyPH+MMFTqxJU3dpv5mkAW0Z2pfJIpcKhA8Adbx9wpkoZVpynklzfU
 +DyBRqxNiUqNaxs6L3EE3wbBzJkJpPxez72nrtYWCri19viK/kVRv9gR7UKujWtq/84VOSDprdB
 h+s8Da4ht0jZqDhOqGloiPfL4msiMcAHU6x7aRw6SZt7x/QJAktOVDwIobE6YWyw2pgQeOXW+9S
 88zu7DAmdc52REQ2NAo170yrt7akoE+uHfP2PuPepO96fly72XsZ/vcBj4Dspj+aE9X3YHXlrON
 C+wWKdoCu4Lj33GQ7IaVq1rvCRhh8lmBCnBusWkWUASLBSUmsDH/fXMw8vOGORMwoD7fGr+/
X-Proofpoint-ORIG-GUID: Rdrsi12vBhFUIReYTiF9nSECmPgfbLxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, May 19, 2025 at 02:40:12PM +0200, Cédric Le Goater wrote:

> patches 3-5 seem be ok to merge. They are first on my vfio-next
> candidates.
> 
> patches 1-2 should be reworked on top of the memory_get_xlat_addr()
> changes [1] proposed by Steven.

Now v5 is out I will rebase on top of it.

> The rest (9-27) is vfio-user territory only (I hope). Still, it
> should be merged through the VFIO tree.

It isn't entirely contained within hw/vfio-user/ (there are e.g. some exports of
util functions), but yes essentially. See diff below for illustration.

> Would it be complex to propose a functional test for it ?

We have a libvfio-user we can use, but this would be a problem:

 487   │ 2025-05-19 14:19:20,304: modprobe gpio-pci-idio-16
 488   │ 2025-05-19 14:19:20,306: modprobe: FATAL: Module gpio-pci-idio-16 not found in directory /lib/modules/5.3.7-301.fc31.x86_64

If somebody can help with how to get a suitable test initrd with this module
available, we could at least do basic testing (although no DMA).

regards
john


diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7a03d24805..80599454d4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
@@ -215,6 +216,20 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
 
+void vfio_intx_eoi(VFIODevice *vbasedev);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_teardown_msi(VFIOPCIDevice *vdev);
+void vfio_bars_exit(VFIOPCIDevice *vdev);
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_register_req_notifier(VFIOPCIDevice *vdev);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
+
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c18986a621..c854f902ed 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a23ef4ea13..09f1a21bf8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -46,6 +46,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -86,6 +87,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
     int *region_fds;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 57ef65dcc9..a92e38f822 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -1770,7 +1770,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1869,7 +1869,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2460,7 +2460,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     g_free(config);
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2629,7 +2629,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2685,7 +2685,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2693,7 +2693,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2807,7 +2807,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2895,7 +2895,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -2943,7 +2943,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -3002,7 +3002,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info;
     Error *err = NULL;
@@ -3056,7 +3056,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3162,7 +3162,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 

