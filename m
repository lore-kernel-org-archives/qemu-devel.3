Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDD7C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHXo-00067E-1Y; Tue, 06 May 2025 08:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCHXm-000661-KV; Tue, 06 May 2025 08:37:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCHXf-0001f0-LD; Tue, 06 May 2025 08:37:06 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469CFHc017632;
 Tue, 6 May 2025 05:35:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=y3ZlUaktR1gR3ItSTH1QTTkwgdl4v2hDxTCYkEeZB
 3U=; b=X+XCdJUrmQP9OpweNtdtSXnazHZvoQFDIgraKAmvx3w+YhpAtjwUIG4EV
 iBH3VwisE6AgqFVNbr3XdM1Ab9/tgxYtLeH0y9Bw0xtjG0pSs65c+CJ61IwL/3cv
 fgPDmE5VH1ZAdYxlMto9a4PeXFTXmkzcCRYrd448ujiNpXX33/MbVbpxsdXbjmAm
 9GIAfoB+PuzS6odAclCWwPa9M23ZH6nRDDLysFxocfU03AywIDi8Of1N2ADTJbae
 QSEBy/oe9nGoc4RuhV3N6gmr6IAvW6il7KQvZJqI/0cJVhFI+vkD9Oq1sYRWhkIk
 iIhczW+uk+lhL0qXIcW2dDzoUyLcg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dj7kwr1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 05:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZd01HqxKzqYPh4GLmD8wueQ+/bN2PqrI70kdGPnzxzn7pLuxZWQw1oDwpwuCpEknj0zaMN6X7h0Pp/vaW1yIWYB5DeHXqvqozxW2tsDGP8OtujX2Nou54Azb+xNn2elqojmAHp9t9bx+/ivUcVz+0ZVkB4I36fiEEWAa28+k7mET2FwJvtYxpK+YrohrA8tDxQ76F9Xge9WERKBrHQjGr9USj6sptmNyPe9xN//yojwbH+Olcg0flZRJRW+0hQN6tTw4iRRsjnOsJFcCemDwUn9xgU6joGIg1TRd/2kJcK1N51UjEfuOtfazGw9PTuaQqc+TW6/iwQ5s7O5CsZmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC4F9h1WhAv6FCZ8V1AVKojKTEYfZI19eLbb+c7YV0A=;
 b=V9oz12K13AzdiFi5Tl0hmzNIQzb6jNB1n7i9cT5i/4X5VI9kIRniPktH/fvdMti21KkrOur/AhUaWnpIqGNvDSjY5vSbMDS8AA23DGshrU7VIS/ibOAV+iww/G/F9unaX/sTDHsn6NBoZv++hNC8WTgupZjuDUEUGQZzXGVAOqpfjPo5q41t1JN8uxk/eEDNI9RakvBTquyQtcmRlnNu0fPv781jNkrFMduVB7LGQtHWSPmU9vRZEvNMPQWEz6Gr27azpZQ2wpCMhs1rEQ1sGrcv6/Kl+stgptCwGw9YJIdsmyNHurOcm9l+SGH2YU5IMn4O4YulwgSGIbpQdfXpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC4F9h1WhAv6FCZ8V1AVKojKTEYfZI19eLbb+c7YV0A=;
 b=PPzCi7UjQoSzVD9XrUqK+MXQ1KvhCyb4bO7EwxbJlNc3w4i9EeW3tLMLM+VU9+kB9YC/UcpY5uf8xCdgOv7YpZXsOoN+hv0IEBBdcAyBekP0HcWnWmQLwAjm62MMVIrubngwXMXhnF5JZWyF9YFbmZO9CoJD9mlQG7RZbzRbqib9UydzTjcOsTuzTpojV2sWCFsZ9JAcF/ECFZujSRjbluuplUwjW4tgKlAKDPLhz8X41IZ8BcMUI6l/hI9aT/IgT1nETtzQiKGr82XVRzPb7p4UqDh6t8L35nIPQ9ke+zScHWd4MpLbERMHtV0PZ1dqkDIGtDM/7kXBQ5Q15SVKdg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB8610.namprd02.prod.outlook.com (2603:10b6:a03:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Tue, 6 May
 2025 12:35:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Tue, 6 May 2025
 12:35:50 +0000
Date: Tue, 6 May 2025 13:35:45 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 04/15] vfio: add vfio_device_get_irq_info() helper
Message-ID: <aBoCIWEIBOlihTmv@lent>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-5-john.levon@nutanix.com>
 <21e7accb-f5e3-4f8c-aa76-e9e2f2094fb6@redhat.com>
 <aBn0rtBxPyFDOaF2@lent>
 <922bb67f-8f6c-469d-a911-bafbc8a23853@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <922bb67f-8f6c-469d-a911-bafbc8a23853@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a30a455-31b0-4a28-7b12-08dd8c9a8867
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZyQIg/raGEwJ3JXHL9ucbFiKu3ycIlDVme5keNz8L/UOglU6Os8CeT08Hg?=
 =?iso-8859-1?Q?8ICQ3vYs1SFsHdbsLIGNDhY0ldOo+dZO6zQKCVrR6lA+ef5rqv7GOHUMtj?=
 =?iso-8859-1?Q?LViXJtv6a5JozeyGY56lP9q4ZHlkKAsD9DneJFo2ySlnwrP+mZXZmiu0wJ?=
 =?iso-8859-1?Q?mW7vI46t8NTPwdGe3t0vH9PuooYGNfM8RxHcoMquW3yQC4OQlsI1ZlWiKm?=
 =?iso-8859-1?Q?YVruIf6LgtZ9uMJxDv/FnpmmxcvQDWqWW4nvwFMn3MG3zIF4Etd7hx72sN?=
 =?iso-8859-1?Q?j8R2lLWZVxWrj2q0wrm2w+U3Epwbt/yHzeuF2IEQR7X8JOQHESj18O043y?=
 =?iso-8859-1?Q?t39Jeu8jkq/opWQTvjpfno6iPFBxcObZQmt4GyTkVRY/I+b0zDobeCGqD/?=
 =?iso-8859-1?Q?UyoWXlBP7bZuXQX45uY39e9ImB160GhCfXSKfFaEG+aojroPq6EnAeRRPm?=
 =?iso-8859-1?Q?97VnY1GPVve8XR+1Gk6UiZ6ZMYSFrT0wskdNka7qY+g28i8nYJVAdHGAtX?=
 =?iso-8859-1?Q?iHZ0B0edSlVIb9VYRGNsLedmUJg/prRAorEFx/xgq8jEWNhsbqS3IIlh/G?=
 =?iso-8859-1?Q?JDX4d8q6wJTJ+c5Gg2ox0XqxuO5ucBiO8Ct8M8q98Op2zIHTHegxaIABA5?=
 =?iso-8859-1?Q?E/hqtY0mEk3HHi+1MHsD2Nb24hSMwwM0qYZjBP5N0+Zix1K3YgqBSN5wMl?=
 =?iso-8859-1?Q?8de+rorYUmhNbjO1H4BIfP3pyBM8xZ/kOJvXJFQ3MJI1ERUxadudAUiXYU?=
 =?iso-8859-1?Q?Yjo12hj84YnUnBx/4BLewZUxXfoY3xKpjrFk6pNGKYHWsqcljAmJFcdtR0?=
 =?iso-8859-1?Q?u9kPWUtW7OYClFVqRPvKlwsAKCcHh9uSSOno2Sa0vhV2GZQ4dYaqo/7stD?=
 =?iso-8859-1?Q?O5Ph20aHn4utBan0BSgTGXV59zBw1JTE+yTO/9O3JzL9fRqd4ytOIwiNPX?=
 =?iso-8859-1?Q?WnmJ5TIV4dAlg4oiTd64pwLdNtYc26bbxhun1O3n3CtUKKWqY2LxGBAvxN?=
 =?iso-8859-1?Q?1nzUy/ZsJ90jmlGADGuXgsA6tUOSauqFG8/63F+o3M47tgcCpX9kxDEXr0?=
 =?iso-8859-1?Q?LuDwH6ICwDxYM6A24hGMfF3wv44xUVrccAi2C2tbb67O+KGkHS6zo0Y4Y3?=
 =?iso-8859-1?Q?p22HMhXLrnVz3noghy3ZNxMiw6kW0q39Vvur9whIZ04nHLWnoNyA9kSRJq?=
 =?iso-8859-1?Q?UFQIaSS3XRgAWLhnef4kCc292AyaUcsvjONYDmmRNYUNeZJ8kPiDE1R9G5?=
 =?iso-8859-1?Q?jGZ0IOS31ma9HS7LCxsXyMQ6ppapamtB4I/UZ5kNOWuh6oGmt9R1UhYeXf?=
 =?iso-8859-1?Q?Z1CN4zcqz1SIISKTZxCJN+Dl+O6bGh+8tP4g9EJglmnQoB8mwCUBxtLUzZ?=
 =?iso-8859-1?Q?HkBWbtHZ24I+4zqPxbQuoQ0M4QfjjBwop4FoV4Sv3+raOFg/vbAU9jwpJF?=
 =?iso-8859-1?Q?FT+LEnoZDU/Ax48KpvlezLjnu7aNx8JuK7BkYg2pW2kdjEUtMzjttw0xun?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VZYf+ppJGF+BHlzGmK3HlnqL6kEvLzmqqsbuDXRq0LKHCLhr9q/CH9Bx2A?=
 =?iso-8859-1?Q?ZC2DfnH3rR3xDwiQYxBBqvRuh+zz0C5+D8vteO+qwUaND38kHkdWKNfeln?=
 =?iso-8859-1?Q?s5AnXJHTazZeO7g11n6YEmQESOqZEl56eUDjJwbL3ZrxxnETgBUgfDaYSu?=
 =?iso-8859-1?Q?iaP2xWvJ8VYlYVXr8X67AErsoSY54N4p9lOlhERVdFFn6V/VMKlPzrSALC?=
 =?iso-8859-1?Q?lqCfkYoJx5FaY8kPh+C+noT/6i+19zhjGvkENGh+jwLzcjnHA8COujb7X3?=
 =?iso-8859-1?Q?Ga4b0Z3Nw80naqdPFUGJ7Q+ULH0UZNtm/bvBLzCsEXthsT+Qy07hMUt4TK?=
 =?iso-8859-1?Q?rF23g/+TsNMz54hhOd+UlyTiXqvD1Quf4775VpdVjVl10iP5t1L415g4xR?=
 =?iso-8859-1?Q?CSqx51dDLc3eG55HDRDGll5c2v9fYYSD/6HPTudT4k5yugfIF/y6IMQfgo?=
 =?iso-8859-1?Q?FdOX0J1KjnxPItefkguZjGvcvVtFxvRFZ3I+Jl5t93yEr8Tr1bU1ZbxXAd?=
 =?iso-8859-1?Q?tog/IPx7WOgCKHRyj7AOoT1Koe57q5ye7t9MLAyiwN84QiWhmwMncCMK7w?=
 =?iso-8859-1?Q?O0zQOoz3lMxcW2L6lbj8X4A02QdpQ0NtQwoaLKktUONnYSGIHlzuWfn7iJ?=
 =?iso-8859-1?Q?KqXGIACqW30B0kOqCA7hGe6GyGbNq0u/5iDZlILQ0fPIKdGzYKUa/J7WQH?=
 =?iso-8859-1?Q?PxsARu3KFX9igOol/qhyyEti8zSxSyk6HB7E50OLvA05GqJQzPQhJ3yo4D?=
 =?iso-8859-1?Q?6FgTsR5ESnub4zVZEl6eQcWGpWvX0NlQ+YhLWFeWVqberRr+PhvrkUxGjS?=
 =?iso-8859-1?Q?S72FmtdedMTiSn0QwO3jHfSeneSsjHWAVYsGNEA49Gug7S0AenQBOP1TCR?=
 =?iso-8859-1?Q?S24q1v4E7cUZhW+pd/bS35iOHukQPSYuYS82/eGY0g41E/c9WBX0bi3bXP?=
 =?iso-8859-1?Q?M61JEcy7dmRSOx4rto6JEuO/3urADl/lHqk7WTidvAJsX8PNIQIF7L+As3?=
 =?iso-8859-1?Q?hIb2d+QoYa7StkjsfYF66FJ2H2Eve7G5vkXhbjMhGArikVeKdrQv1d/VdP?=
 =?iso-8859-1?Q?bCPl5cStqi0fY9W5gzT4iJ0eZk0lC3kgewsSzQLWtSTZ0TBjTAKEs0Rvym?=
 =?iso-8859-1?Q?CjwxuewFSBrGbb1gapvSG2o7vwF+CTQFURKAphVjqxR1BPtYv22CYVeH5l?=
 =?iso-8859-1?Q?LSsZxrL7pX5zFhHZd7orp8LCbPRuc9oyLTVqZ6TMKGPtLNjTIf60ZWr+cV?=
 =?iso-8859-1?Q?q4bmdDnsoUK3PWVmyM87fBS2C4wTj4EP1YJ8+fYiVxxUtfSJ6BTTmcfMeZ?=
 =?iso-8859-1?Q?5gqBO/QVpJo0dHQA3ZA8hSr8/ZarXNluxperWV0cAUUvaWhiXWtNVasZ7c?=
 =?iso-8859-1?Q?LTInPVjRjpuQvblKqgr6Gt+omS15oV6pA5XQ1N4kOBAhKlV1/S5UmJkwk5?=
 =?iso-8859-1?Q?FOjumSz/z4QenvLTq8NnCWOlRTrNzd8V08PmKqJunyI6Ju6p6+VihyFcAb?=
 =?iso-8859-1?Q?QYvXCwAvczErHWa7dWRdF61iV3SjKrO9BaRi9fRk8vHwKDMvGopNEiR3n2?=
 =?iso-8859-1?Q?UN/dsnf8rYtPG28m1tCBCeB/YKiFz72ghYOZWvp9X7AJPE+GSmSYfvLtXT?=
 =?iso-8859-1?Q?92Zl1L9mrY3Tyy6q0btxv4exs6FDcnAOMq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a30a455-31b0-4a28-7b12-08dd8c9a8867
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:35:49.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg/Kg5MevbTrruMAY20hwYwO+w3/iBTYsnl6JW6T/x6/F05WxB9V4t9wSfDUDUD+WHH1VqCKZdSYX2U8nEgQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8610
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEyMSBTYWx0ZWRfXwEMkccOhzeBb
 mhXhOyZZZdYp/FblvZyr9PZMVcs7zPMpJvT4byjZ04eMprapEVaWHaVj8ZyTOc9zAeWOgnxCNaR
 6TcLO1qUSxb3PY6uIbU32JIYCYHPvx3FrH7/4vbv+wZ21IDpQufjmtndRtJgNEX3n8RJLmHbnVw
 2XVkbaMFTlOd/Eh2nbEc4EpHGbG30TW8nj4B5jU/3h5VlsXAlxBJdCRk2I9q9qSj5xqEO6u0NBq
 4SyP4ikYEHbDMi3ZjluJ9VtQfisnnv/rsTi3cv2M0f59Zg5c0p8dKaooJWdZGgQhLPSKKqvOnTi
 OB+s5mw+kvclYOUx1RbIQsrVzeX6eWZFvSB4pwgaVUHAobH5ExtrHdkjpOO5W1Ehpwjh6gVaVtz
 pYsoEQYLHn7FR8Mx6mfatG0Ukay75x54VOmXnV3VNw8MfPFJMDoICLRWXLox0kxxBxjrrfdv
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=681a022d cx=c_pps
 a=uYdjBAypVXkA+ZVpDPXefQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=xLqD-6BmUm-ViM-tgOEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: iyIb5NbSVqaJ7S5TChVxi3-Y2HHyxyGI
X-Proofpoint-GUID: iyIb5NbSVqaJ7S5TChVxi3-Y2HHyxyGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, May 06, 2025 at 02:27:21PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 5/6/25 13:38, John Levon wrote:
> > On Mon, May 05, 2025 at 11:19:30AM +0200, Cédric Le Goater wrote:
> > 
> > > > +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> > > > +                                struct vfio_irq_info *info);
> > > 
> > > This is breaking the windows build.
> > 
> > Sorry, I forgot to set up cross-compile. I've done so now, and it was actually
> > vfio_device_prepare() that was broken, I think, as it was outside of the linux
> > ifdef.
> 
> All references to 'struct vfio_irq_info *info' should be under
> the Linux ifdef.

Yes, I think it already was (this is just before the CONFIG_LINUX #endif). The
other patch was definitely broken.

regards
john

