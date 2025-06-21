Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1219C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSzYB-0002rB-O6; Sat, 21 Jun 2025 10:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSzY8-0002qz-Kx
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 10:50:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSzY6-0000fJ-Pv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 10:50:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LCtnQ1007284;
 Sat, 21 Jun 2025 07:50:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mJ+XKw2vFuicD72F8gqoTlpcBmgSClgoCjkXOKgkE
 O8=; b=l3ZlXxLFqAzti3tAdyYEVD/kGOKaML9yVQL2OmYUxwifwqeO2jres8rdu
 bp92uZaj1JHzY9kwfIaKIDMQipuGCebrlq2TVBaK3rzQW3ORDCrKI+mP2ATCI9Z5
 GEQFRBJhoc1+FfkHCaAsyglaUccikE52QMlI4teAnQPzxdc+f8icomEzrMn+ClUg
 7qrTCj4AViYoU4zp4cbNpxNYXGkJyUYObF80CNSgPupPHoWv44NHXgJaunFPE38O
 +72CMWHx1rLjsjm6lmcNiIrrTqEseM0H+j49ImvgnOSMo4gwoOQGpqrLr2B3FRi4
 aIpKq6VSrDhZVBY+GAWIFvCiLL4lg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dv90r5b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Jun 2025 07:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffcgq95Vb3Za/9Qu/7SASC2HVpvUBSeaIhcy9WGoO4aUTrcpzYYJ0P6uED7/39Jexv8bfx9RK27U6WiHykR+1PAldM/wNBZSVjiRQUPPoCh+NmyJpVajDda/2e8M0sRySCrQhgDefNGmDobYx+u0XKZGiLdSuNWTJpBQ9GLTH0JVVvJ7kIMKmn05WYiqG5JM1JH6gZgp7V8F5nWwprAh2hCpPTt/lRt1f7VCoExlQcIRZxsgEVgC36geDISZvdZwK9LZ2GHp4DLq74ylgJ1gAm9QbILIdhu1pf+9oiRQuHR3M6tW90J8GaeYZ+hKk1e9eIZyPuKx5UIGZznJQwkIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOM66GaHMF5vyvgC8gtm7pllNEXAGL2NtpBwIyd9E4o=;
 b=A02ZfPo6tytqTAJFXFX9XsNcezbbJTMf2oXbSou9itVLZ3qrXTnL0MdARTwo2HADEertn33VejwSLN34q+Bk2VLPCtnzAzq+whsg/BUT/eMCgLKNd9rWbld5EAYeknenKq5ftaRQOhmuB6XQ99u6v0Hn7mOL4o13Fu/D0nV37beEtKDYlSIfaE5wdMuQum0saZUvv/MgLrBD7JZBJpOC1QijzVA5c64t305/5uXp/+B3T/EKJLYDzGgznHCqMTgfHoODLsHpYzEtD9NB7hWD3vmabjKMTaf5wzZbTPp+8nYfj37TsyKFShDGmUiietH9VZ6kCH1cRmtgCPVgllTxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOM66GaHMF5vyvgC8gtm7pllNEXAGL2NtpBwIyd9E4o=;
 b=rrM6p6szm1B5jEX6EEv3I+PCOZ4d+7gtMzD5bcei1LwjLKFtkx/K7hna4KM3LVgWe1XNz+9BK3iKCFUf3D1u/WgcxtnYkySQbwa0WXn+bFHt09oOWuYcmQq4NaRj5SuciRYnLkxm5OJxrWEpQnplN6F4skO96p8wD2htGXNB8Dw50oh/rj8M7HEVACTjLpmGNZJLpJTW5SCR8nEtrF5ShtHq0pkQ3RdlatQn+/uNVeH50NrS8qAj07MP7X4eVXNScyIgxE7px5MgOOgW57EyUeoPA41a/ZExYRIFeVskTibQ71gjKqiGwfRZArjrYTY3nvyd9NbYO9HW+3XtIuJG7w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH2PR02MB6521.namprd02.prod.outlook.com (2603:10b6:610:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Sat, 21 Jun
 2025 14:50:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Sat, 21 Jun 2025
 14:50:23 +0000
Date: Sat, 21 Jun 2025 07:50:18 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 00/19] vfio-user client
Message-ID: <aFbGqm7n-xCFQdV8@lent>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com>
 <aFabYdacLpv3RHu8@lent>
 <84170782-ba25-4f9f-b0fd-3b77c3a98edc@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84170782-ba25-4f9f-b0fd-3b77c3a98edc@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH2PR02MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: ded07028-af7a-4f0c-0afd-08ddb0d2f332
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZmSqEtHP74y67koCMMCqsoL7iKfvGhkqubZ28NluIagysqf/qOHpGysXlK?=
 =?iso-8859-1?Q?iesQgf5ftCP/yOa5R0xZSx69uMN/j7NNRZ8r8KrdsC4sJWNRSi6SfTnkDH?=
 =?iso-8859-1?Q?+iv0BRscOJ5oZVtbULjx/PvyFP+0M/tfRkrizJWNsLzKgRaXHYn1EXEk1p?=
 =?iso-8859-1?Q?dIA3rZT7PMTIpdVdVrJfaI4fWMPcVPVq0RdwRN4SzqxISNLgYIxLUpOHF9?=
 =?iso-8859-1?Q?SjS7VttYSvsLJAvmSJyEADWdKVZSLmxRL3WVsK0GP9DhbD1e944cxrw9fS?=
 =?iso-8859-1?Q?km/ShjvVfwAu86gsxiHkIofBI7BiqXgo/8pPgHq+z9aRDs3QYjpxtbuEFY?=
 =?iso-8859-1?Q?P1onFhf/9MKyP9zm8sTIhbDk+kI2tvdoxw2jQVNIfurf7e+hcBj3t+RsyK?=
 =?iso-8859-1?Q?Co0eUsx33FArZfYJbY3XbCFeNyMBu0ZTb1dn/SvY1zCLPrVbR6AOsk15+Z?=
 =?iso-8859-1?Q?nM8Cq89MmasmGFclqgtyUMZlqoOw5qgJe5nh6TsxNB/tWQA12M/Gh2sq7s?=
 =?iso-8859-1?Q?WhEI1Zjl7HF9FiZQfb6ntXmNz7SiahPizk/HxvuQ9sO5p/dcW+cIe6A2BA?=
 =?iso-8859-1?Q?wCbCCyf3FjvSb438bfQODaEIiLK1q2bYZl5Kx2m0GBz7rvlEXSYVEqN0x7?=
 =?iso-8859-1?Q?Rl2HObKVV06naqSV7Ek8emBUpIZG287Wa181ocsDkJWX0LHXr8RIXFckAd?=
 =?iso-8859-1?Q?TSopt8CDn0sXQOlCfDyNP7AeKxcb6HF3odsPLsUiEy56vA75jFD49qgAsl?=
 =?iso-8859-1?Q?amxfweZ9F+ed2Y8ofxuCSFC4crFVGuEc+lrf9XCI7cN0YXPVZsJf1dyYd6?=
 =?iso-8859-1?Q?T5JYh1EvRVtH4ECz4jjCjmZOwh4iLRnFM8ouTR7jZeAJJ7Dq9a9nH23SnE?=
 =?iso-8859-1?Q?dtpsAf7f0EEZKVS5qfUXAZAb4Eu96KFQ2X9dwWHcJwBHBtbzOZuj9653a/?=
 =?iso-8859-1?Q?CmTs/mqEJS2ZCo/gn5WA4Tpa5vHKyOHXsL7/eOhhfFox7uqZee7kL9nbcA?=
 =?iso-8859-1?Q?OBEeZ9RaA+z80cxGeufN8DEPaJe6Bps+jG+twTAJxe95w5uO8Ht8LuCCIf?=
 =?iso-8859-1?Q?5nL0oxnIAKTZKIUplmw6Vobh2cYAwC2wffwuEixQt9EHP75Kd6qV118ezf?=
 =?iso-8859-1?Q?sXNZw8GwakimQFrZyMtD64U8VvctZHDS9SJKG+YjLRkk08CpeqmxblHvdM?=
 =?iso-8859-1?Q?XRpW4ByH7/uCLEugd8ZSQ+r2BtsmLh3u/5P6JV5p27Iheke7WFJ3WpY+CN?=
 =?iso-8859-1?Q?e2//fEtfAJJAxdJssNb8uvmc4dv+/lRYQ+b1ia5s6MZRZkTtlJocOASgz4?=
 =?iso-8859-1?Q?ZvS8GLKeM5cbWgkL56BjNBbhIZc8G2a/iJUIpSnD4X0VCKokuAGZ1whuF2?=
 =?iso-8859-1?Q?IvC9MhiKjDWr2ztk9cvRFo7I4lzbD1PqxG68bM2i3DzFA/fHzs/MaM/g8Q?=
 =?iso-8859-1?Q?IPQ3aLzSlUjfUcyGvNNAvmukR4AU/Z8IgnAROzeQBnK9aAJH2i2bo1EWzw?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XwilA2TPCLI5SxvCw9iEbxqvO3vCdmvVVnVozFTUGvrurxyLVFtwP2jCWw?=
 =?iso-8859-1?Q?ipLIHPEvh1NXfYJsHDmmpi0h/tIfDa+5rGVYaLlvT9XSNsONoMPmwVM+8C?=
 =?iso-8859-1?Q?X89x48h5IuSazTnaQzuvIibZYP7JiagpgGFnpyIPJeJ/SpVwA5qStDjk4N?=
 =?iso-8859-1?Q?rmy0iTV7NdiPTCub40/1amPWQDOJiBJWdVSeqgoGREM2o0wdiI5eB8WDWz?=
 =?iso-8859-1?Q?w2djyB0t2P4/gBx/X0LmEtScReKGSuEqg5K5aTurtxU4ssQHIiYZxCB0lh?=
 =?iso-8859-1?Q?85YWoXuW2gQPzGefxxvThczIQ8qus6eNQwVIsyE2BQzUYzGR2HB6RUNexP?=
 =?iso-8859-1?Q?pTxmqIHBBgirzKFw07Tc9mm+uaELknFtDzHNrQS/Js1X2F/0vPQmZYoNDM?=
 =?iso-8859-1?Q?seRR+/VxPp0mDHC1aBTCFWDol/rDmRAvY3WYbLAwr9YedGjrv6EPE/zBGJ?=
 =?iso-8859-1?Q?mYv1uPEXcr5xh5p72K85/y365iKl/ukI5u9UwHq9uTtsfZ5y9ieofUUkAK?=
 =?iso-8859-1?Q?JamRFX9/cxMYvWc8kP+2Fr+IlfF9HKiWNpQEKOA/rSLOkWdthzLvwj1rRS?=
 =?iso-8859-1?Q?ipYxh+1ZguSFl9C5CpUN4yi20KTnIcvi5Bh5O27vSkVu3L3nEPFbzgT4Ib?=
 =?iso-8859-1?Q?TBlFHdf/Vq2WCb94UzcldU2RzE6cdwu1P34vwB4y4F5DVMM+nmq0wZjh+d?=
 =?iso-8859-1?Q?M/nQIYgYsHVztOQU6JCCRpAWJMnoPdAydbsFUavzHF/cdiK707PbGmESAe?=
 =?iso-8859-1?Q?42rA0wGJG6sOCIN7buISZH2xpVy0+OUHxaRl1hO5cu8xPGeqeyyRu09WBO?=
 =?iso-8859-1?Q?BL/EwVyQRLFf2g86LWYumW4FdHauR/X65xDdnMoRRwVl/sRZhhJHN/fFY4?=
 =?iso-8859-1?Q?8ar5vDdUHBmH2eqd/jp8nFl9Pjhp26VJuBqUzjcCUfs0FBimQ1892c74Sq?=
 =?iso-8859-1?Q?PFEPlvlQ2nkQYn2ICs5F0jxmJ9cXQxYXIN55t0HgJkvgtn93wa8s2LJ2z8?=
 =?iso-8859-1?Q?7UwfmWIDAl07JB5Zqe6vJ5dDaqJbMttNMAGhmifXvzHqu17EvCzWgT6qV8?=
 =?iso-8859-1?Q?rFbwVamqhFY2rRFPvP+pTRJLoi8YjpIuzao4rfZwR7lmIAv8UqtMu8436O?=
 =?iso-8859-1?Q?IROEIS/phHzT3XRn3q3lFXKefJYof8jibbF25jM6lvQe4XT3vK5jacs2Md?=
 =?iso-8859-1?Q?RCq8+VJ03KQ0RbS48/WUWnjZwcNRI26mdLyrWYUm0VOqQGbkrCWPvRLFGB?=
 =?iso-8859-1?Q?VSySzsSWTc81mW7SlaVvrQR2ejetx8OYD/qeq9OdeYzK6P11z5sRcDeOAn?=
 =?iso-8859-1?Q?F0yGx0+oPHroe8k7vs7jg9rzjh44n2edjMVi0mS/oOXEY4yyawWRoF/5h7?=
 =?iso-8859-1?Q?6YjS9mf7/THYVmc80onITBpYl8CpIbvKjXcLdbY4SzuVjtmDX/iK0fASIt?=
 =?iso-8859-1?Q?cAuNah7Pgdy0PBB7DnPaJXVFSXLCOJrFM9T2I3qik46KxktaK3K4Tt2tUd?=
 =?iso-8859-1?Q?eAMdFfexMEIGBhCsEC8AbfZRxUNqnV0y+coy/p1idqoI+XeZhDoFG0VXgm?=
 =?iso-8859-1?Q?uuNW6RPYrtn9tT/IBh4bBIPi2aSfXxxbNA7GfmjLA8ziZ1BzpEhe00t0Ag?=
 =?iso-8859-1?Q?QCUooREH2iT1liGdI9YpO8rQs2xYLEoTpC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded07028-af7a-4f0c-0afd-08ddb0d2f332
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 14:50:23.0984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2W8koKipsurzIr0GNTCo9u9eeomVA2ohDNUt1uJXddC58FKUEgykgs2jER+x7XwJ6kYOdt+Ea8HzAZZROshAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6521
X-Proofpoint-GUID: bdxQz8AdBNjPGEhnnEl1lzCDmWEi0bpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA5MSBTYWx0ZWRfX5Ev/MMkZLd+L
 GedYxuwyM7bddzq1+STadqQOJ1A+EWLoLnHtUtzFkTOWPn87C+dWp7qOlng6VBaSI/5+ta6+14l
 nee7vjxdmSyRpQOPzDLER4VJZbp5DwJDwRDgH0Ma2e0NhNncjEh9KX30ocajRZQqXSIDKws0BbC
 6FfTpS2snMML0TA6NdWN2wD3IrhM6BStpMNxoO+MW9dJ2zEffBmdpOqPKa0a40YEavUWnoha5hD
 4pGMMKe7qvfSBw6ygqQPYxGsUvKELQ05ewtLtO7ZtWUrh5orEbclab6EIXk/a7v5Mw8+fdbpDWU
 PNs3BIQ8zNii1d6uyFFI2ECSyG0aoulNnnjdrz41lsb3/HXDfeD4mX+GJNKc6fs/c9i8XaYHbmn
 jImf05Lsm1goJq5VB/0N4Z7RV4Mzdo+f8oLy7hy+wkkrP/HXWdjL7xLw95Q+H6EWzTqnuZAZ
X-Authority-Analysis: v=2.4 cv=EaPIQOmC c=1 sm=1 tr=0 ts=6856c6b3 cx=c_pps
 a=wyQZsu7YS+H2q1uHh87QeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=8Qn6SDV9UXVFK4hd7IUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: bdxQz8AdBNjPGEhnnEl1lzCDmWEi0bpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_04,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

On Sat, Jun 21, 2025 at 04:25:24PM +0200, Cédric Le Goater wrote:

> > So please let me know what if anything needs to be fixed (and if I should make
> > the same retrospective fix to hw/vfio/ equivalent).
> 
> Did you update the QEMU tree ?
> 
>   $ git describe
>   v10.0.0-1657-g6e1571533fd9

My series is against vfio-next, but regardless, none of

hw/vfio/{Kconfig,meson.build,trace.h,trace-events}

have SPDX identifiers there. I will add it to all of them in a prepatory patch.

regards
john

