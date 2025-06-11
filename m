Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17807C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHIF-0007nb-JB; Wed, 11 Jun 2025 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPHIC-0007nL-O3
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:58:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPHI8-00067E-Nr
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:58:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AMATBR030387;
 Wed, 11 Jun 2025 01:58:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l9j4ZYtIfczaPxgpOPMDVhWFOL8wB+IickB7TCmL/
 jE=; b=TQJGNj5fM64I0An5YdS4Z9cAGTqBRFlc47WiHwPGlRVQYGkfBTEAbYKk1
 MCKi1LIOnbThomz2IYPYM6egN5/65J8PnNfrGRdUrFteQf/G7Z2d61wFLJGpVM1k
 lLrfHFdCmgR5K5//H3LBwjHxMWfkQS+YUDQc84T2Se5xebRtBho+8hSBuXSV0N6L
 VbaeRU0jcf9DcwWGhyalCY55+nx7u8Elyxxonc64+EUK66wriGVhAYWjirwULwKf
 v+hKxCP0hd9FiK464AX/62cXWHhsTQ1glHRu6o2YWdgpoivgkWPQQiEIyRoIMFVI
 cRX07IyUAY9VjYZlbzOxpIe3FM70g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020112.outbound.protection.outlook.com [52.101.61.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 476mpx2rw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 01:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhUkOYDyJ6DbsF7yEc2m+vMjx0rmCIaI3CJIaPYUSztq5jiLlwhcQ0e2reZ4EqnKIEcTRZopb1tL9lQUYlDA7Bfqv12qCuHHmJFN7IOVYLZhH78bmkFJv54k4cpas4ZhRR+KTs0vf8fazMUnXL+VDd4Pz6rzg97F2RtQABw7LaXkSt5kWjN69ky4ctDdx+AKXjsV+RMI0B6pJNJvnKiX3kWg9pASOY52N54zHcgjvCnHJXanYf8H5kvbfFR3KmMy6mre8vLj0kNsDfXjvQ3LQxegVIjOSYklPrmlixs+PgGEbbbRFe+86QKyZkB7uorSILcagUePN4uT+o28bG6IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/0A/AKgRUm7kg8ciylFH0XHqFJF5wwK4mgasgmV/+4=;
 b=ZP2nYZOl3Ouqj7HeY1PtvWfPe/9kYG1+w9Wd4/gtubF1+uLcYO5MFB7h/Xi1fpEWp0F4fjvCBlWTaKp10mgJvKZB8otCj1tEfvakdGwwVwgHpzmO1T4TRQgY4hMqeHde39CbBRFWAGSF+L6ETBDNnjWuOrFtb/TewQmS+4Zbxh25xak7iqTZX+GgYnVWdLkPhiypJHwxu/PAIzX2jvDKj1ysl1C9Y2UItkf1g3EReh7EA1qwQGZf/tT2p0xfPX1sQmT3HglT18t6bPJc8kDwMkiH9/XEfdZlNBbhICF/ipEaIkNVgMa3hpFWJjPo17N3BeiAVNFfFWvObtqEqpTBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/0A/AKgRUm7kg8ciylFH0XHqFJF5wwK4mgasgmV/+4=;
 b=R6d+cKfiCbJlUHuf0PrFlLFYCQ2RVyZvYdhfIXUQVyEzFdbOm6IjNka4ZZZfbqAwodfu97TfbbBHsrKOic2E7AJZXu88yOQrpP+HJpT+iq2mmYsIqtQMumApc5LalP9wICSVcpOyHu1DEnN8CS0CfDuSqovzU+BggKpiBs7J5aSHMgHB0PN9iQHySnw36+SmgNJCOKYZv0Stbj1rWAkUGbO5C0qGGG975R7X+oAhS0upV82GzZEWyEUw/e5EJWe2wd8O4pOW9x3Og4U9ep/cDOSwyQnT9JkeQR3TFDQCg+zIMV5H7Xus74O/XpGrrSmNDPuqnOwL7MI+XkU1/oNqXA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7488.namprd02.prod.outlook.com (2603:10b6:a03:29e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 08:58:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 08:58:34 +0000
Date: Wed, 11 Jun 2025 01:58:29 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
Message-ID: <aElFNTG0jxH6ZckC@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
 <c0fd6bf3-cf0b-4843-a7ea-6ac49480e7ca@redhat.com>
 <aEhi5cVljVfjTvJA@lent>
 <ab28f674-918f-46dc-8ca9-c61f84711ed2@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab28f674-918f-46dc-8ca9-c61f84711ed2@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fa794f-97f2-481f-30a2-08dda8c62549
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?a7qkkcO3pgQoZXLZk6lSl8bvy+wORNywUjJ0txaecd0mtYykSHXnIucDRx?=
 =?iso-8859-1?Q?t1g/H9Sk3ayD1MECtgp8fIuxy4rxFq8oUoL1uo2KsnC8bzeZE2vHWHOhq1?=
 =?iso-8859-1?Q?jmJaHYlNHxHRyHN+o1Hr0MGEXUV+FDpUMhppbHP3I2JtbsRuEpgBEJCIWn?=
 =?iso-8859-1?Q?CfeUsm9xL0HPJn2cWkeOkYAD+RNS4KaiHiDWaB72fLAwxVKzpVFjhcxnKU?=
 =?iso-8859-1?Q?2uzLkkYCofvhpf7eE73JZ+hseDnPeY3EUSES28ZTdZ+dmmojg7qVJKa9cD?=
 =?iso-8859-1?Q?3yleb4EFmlmmMzUUCLD5bxWA1X0Kz0gMxpwo31HZN0r5bs6UZuEwzePEHh?=
 =?iso-8859-1?Q?OSlDrue0W1qBpocC9loolTsxKGw3mf5yWHVoSc9H6mx7CosTLRHWU/W32u?=
 =?iso-8859-1?Q?XauYpoHTsZcqP+2YSx4TmA6FYtnoiS6AbHBBbTZaWVop0zLj36Za46bjKs?=
 =?iso-8859-1?Q?/U1mODh/aNuHeQzjefNhH21lOxEujnjPY7DUwAvfncxPZug0Id5qVJy2mK?=
 =?iso-8859-1?Q?G/KvBR2652hAmLAT2Ej8e8MDSB6TGHHcSPkMgBmHk9eGEWhuXgHRYJt+A1?=
 =?iso-8859-1?Q?qbf6VZXFC1h4Atqy/+jwFScqbwXcKY+aoSEmFIUHRGanr+h0knOtSzG38M?=
 =?iso-8859-1?Q?WqTOLhykskjoJAYtnIRdCOvcX0gO2o4SxC3AVjHtfW6O/58Dn+5GxrPOVB?=
 =?iso-8859-1?Q?wENHuSf4ws/KIbn6YN3B9E4PIp18FQOBoU7vibQj32K6in6ePZuaEdRvbg?=
 =?iso-8859-1?Q?wb9u/nyyvVM6LV7PFwzb6GFqpMxn+/7qvgpo1BQ7QCizhcT0dTtuUBjFdw?=
 =?iso-8859-1?Q?3Ag1V9Fn398DwOf6ySUJOgok71sOs/KEV5WWaOc1TuWnwYfHy34noxFBe5?=
 =?iso-8859-1?Q?VFhsSClgeS1vyTorNXy9WJf2bf3Y3fVOiwkVH7uMAlfhCQPSHBZKALlW3G?=
 =?iso-8859-1?Q?xzARaKN2jgjMSUdmqTaeZ5PJwOjZSyqelu2xlwJNMz9zPUAq+0XfFHlj5r?=
 =?iso-8859-1?Q?pdG/PYF2rlHK4ZVypXnjeagiur8Ltd2E+pOsgcpMMxV2HTLZTkeFp6cj9Z?=
 =?iso-8859-1?Q?PCh7RxrBS7eJKw7HXUMalNhRYyCdONZUCQA+ijWWUoGyX7AdjD51qyjiT4?=
 =?iso-8859-1?Q?IxANu34VlQF88L9D/cRbbuZ3HbO1tm2M/KrWpsYK7dK0uRnH69BGntzro1?=
 =?iso-8859-1?Q?iHmApN/KYla+U6k4VdvaMV5Ui3n631N79aiDu5Rc1ocqDzAimtkQUCYvlA?=
 =?iso-8859-1?Q?Ue2u40VhFkfBp6HPgcwAajYmtOsU20SVUe8sGOPV+rXvjePcW77DINPeHL?=
 =?iso-8859-1?Q?ZOZu47zGj41REPUdUVZva1LOlr834QdgamVLFI6T781VQUusibqU10PQIf?=
 =?iso-8859-1?Q?cWIQIuOG8tRwf9GOHg34VTp6nQbI9Z1Ukt18ABdN9306gdNdKyYDRcZ5Nm?=
 =?iso-8859-1?Q?RN1wNCa/VZZP4GxMW4OIMt508aO28z+MQBwfPyYIXHlb6H28CijNXBsN3U?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Hhdx9g4hA9zFD2+swtHeIiIUEls/QiyPAkCJMWlx6BLGN7ezmSq4ueJtF3?=
 =?iso-8859-1?Q?yfcD1BXVr+eWPrbo8LzsiqhAqiUMAbV4oS/TKG1G8ZDEWA3Zsj/VHfM1N+?=
 =?iso-8859-1?Q?A9kZ4vBZgHjDviJW8goMKfuwc4wCR5pWL6JF8SnhzxZHDEwuyOfZJSLnv9?=
 =?iso-8859-1?Q?rJZhDmD86xNHYM1N3hKE+1JD5+bnOy6Bo324tZI3goiH/5rlX1GuSUWe6J?=
 =?iso-8859-1?Q?4Z6Rf/NK3/eHKNohmWVF8NO/b2ZJfcZXUlv/aQ+hje7CpWmprXHc3qL7oa?=
 =?iso-8859-1?Q?pTYEuIOpupondXVs9FuQ5HBcfElftcdYdVZikKbNfDkAhn0OPNn87wCslD?=
 =?iso-8859-1?Q?XK4l3dNTTNTVT0HufKFl3druRnEzNQDJZJOHHqyxT/D8NakDExuw6n3CeB?=
 =?iso-8859-1?Q?djF1bgcAbKc1SAYEryJgtwS0GEHIQVvtUj6hhD18hXw0zknFYZtOnDoNb7?=
 =?iso-8859-1?Q?rdArSdbnD8PkRAAO+NWT0KdZPvLzuqBTNuuolSRijAQ6p9KG0mmNjf7QkZ?=
 =?iso-8859-1?Q?29f1b01n65kHXwXVbC0YCkFSRPHi7/4n+tV31OyNnPxRaA5J7a6CXeY0AO?=
 =?iso-8859-1?Q?r148csjauX/SCWu2Mw02PmjJGrVzC2EkVxFTJEnfpuJigRXgUCVIo3yPoM?=
 =?iso-8859-1?Q?6cE4fuoAMD1RXdwuZmfothE2+AhmvbpCh1ieiqNQ7hLIz9mAtTymxBehLK?=
 =?iso-8859-1?Q?WWaOVlqPinKz7F+ZodTeOQsb+5qstRY9nFf28uEKd7Kbjn/2vJYrW65Ftk?=
 =?iso-8859-1?Q?ugmxbHXTxLMPZOhRLUkQlCXJwQT5UMfA2hkWqtysrg4z3KmCjBLO5pl6kr?=
 =?iso-8859-1?Q?QhwRpDGuDp0dJDXE8Yval8Q+gvl7rvGYYuOYWE4E572arkypOKG10OiKgU?=
 =?iso-8859-1?Q?QzkkQF0a+D6g4C748Fytsr4eE/qT1H5sY4aygI4DMAzddWgNLZTVAX9b2b?=
 =?iso-8859-1?Q?zaP95qfJXwASo5R/903LXUtvNdc0EvMP5u9GfdfZbsDwtZ0wjyMSCHuJtw?=
 =?iso-8859-1?Q?GjXtLx02VSaapdB/VuTBH0uTKoKBYBU8mdXKiuaycBYAiMJPCe1G7dvZHP?=
 =?iso-8859-1?Q?vgdH2TIbA5VrjZDkboUCR/NcbIF+g8NwZFmUNx3/4235pK2SzN5DFAOSaW?=
 =?iso-8859-1?Q?PbaVNyLlSn9eL8nqZ6HCvvcxta5OVKmWGlGDLay4rWZXoUm5yux2iwvV6p?=
 =?iso-8859-1?Q?ZOyEMiFH8XozJsNpO14XFwfp3s2tCcqcNigzcu/9b5inW7rRzUQcnCo3K/?=
 =?iso-8859-1?Q?eebuMu2k3uTFDR/zv8t66pm0m6Mb4Q/W5MxSuGGKSoaBRfahvvZeD+qYQA?=
 =?iso-8859-1?Q?9/5vCYDf1xpNX1BM3hhzmos/c6VSTtbywcqncw0DbNEP20cTAybbc8QGnK?=
 =?iso-8859-1?Q?A4TTdxht7vFn2rx3icZAttdCaOkZhifvw8gTPaZx+dNqdxQ4HRJVAiZy7A?=
 =?iso-8859-1?Q?AHuqRezd/3zohdJHB0//PppmFJZG+c+VlP3ik4BCXGMymJhx0CJdbAQSoP?=
 =?iso-8859-1?Q?t1Dfo0MfAZ8HwOVONWWOnC7Awy4MEXhGNoBmu6dskTbebjQAZwE1x9+r0D?=
 =?iso-8859-1?Q?48kuQdogiD64kJRaYLqPRwLJgXFpDlvI0VDyonvPVYcWbif/bZafzGimPj?=
 =?iso-8859-1?Q?jkNn4B1VrgUzxC0WgNP9bZ3Tcp9QqeaTa7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fa794f-97f2-481f-30a2-08dda8c62549
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 08:58:34.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb9zcE+Lc+6jtK8ctYo8WyHZ2aidX9I3pHlF60l4JItqvNwTzfXSHNoh1jANC4Gx2huoh4BUme5eTE8fKkXAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7488
X-Proofpoint-GUID: Crl1mbHA5m1-snlz5jDfNG0MyVzVKnKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3NyBTYWx0ZWRfXxy+wl1ZZgzJg
 C1W/IU2hDpzbcaNUt2fTFAZYby/IgD0dOmkUfGx3kt8ymbUguCPLHTkwKhu+N2bg9hF9pgOgzk+
 Qzb8FyBepnk1NI8AJzHTSuLDL4QCSb3lGTt/w4uXRbus0l1t4i7ICBAJ7fbRL2XD3koDAe3nZLq
 aluKFCejmqe35XiAKeoFmFqjukGOAxJZB9PkWZ7LkL7/cPAfu9DKUN7tDJbRf+sSnGv7gj2gSjN
 oKvrm+41NQpPL/AvrfKuO+hIr2WEc/sa81uadE03QXf+MiqTbnM0DrkDGDoXxiAMyNlkOzhJgCv
 Ci0vnms1m0BfztOLUc7OiHCIn8UpH0dAFYjcXp9MqsE5XlIWATZlO6bFpARvh2IK1TXM6vBkUIQ
 rgLHWdA7MkyBauSfLXtA/GVVKiajLbgSupBTDTpKRLtAnyzvzE2VRw1ePQ1ZwTGQTiOkmNEy
X-Proofpoint-ORIG-GUID: Crl1mbHA5m1-snlz5jDfNG0MyVzVKnKo
X-Authority-Analysis: v=2.4 cv=ENgG00ZC c=1 sm=1 tr=0 ts=6849453d cx=c_pps
 a=xiYOG/ZI8GhAbW/PPonVsg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=B8GEKrrfjxLEi4Wj_PQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 11, 2025 at 09:46:15AM +0200, Cédric Le Goater wrote:

> > > can't we simply have a CONFIG option and select the device on platforms
> > > supporting it ?
> > 
> > You mean always build vfio-user client rather than optionally? Why would it be
> > different from other optional components?
> 
> why would it be optional ? I don't see any dependency for vfio-user-client.
> vfio-user-server depends on libvfio-user [1]. Not vfio-user-client.
> Should it ?

libvfio-user is for the server side, you are correct that the client does not
depend on it at all. (It's still actively in use.)

> > AFAIK all platforms (at least in theory) would support it.
> 
> So what would be the reason for not compiling it ? It is not different
> from VFIO AFAICT.

OK, thanks. I simply didn't know qemu policy on building things in by default.
Of course I would be very happy to see it built into every qemu :)

regards
john

