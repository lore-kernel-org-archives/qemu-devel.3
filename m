Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA685C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCdFj-0003p3-Pr; Wed, 07 May 2025 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCdFg-0003o8-V8; Wed, 07 May 2025 07:47:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCdFd-0007Ke-Lx; Wed, 07 May 2025 07:47:52 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ALmYD025335;
 Wed, 7 May 2025 04:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=A97SN3SttbBMCIAOEJAMNsBN3sbfsZItpmIJnM0S0
 a4=; b=t/w1oU2JzTseQfRUPVZ43q4NHdTT0IwjqLLTMP6I+9enjkJLzflO8uRev
 Ul4ggfxaoqIDTZQtvpBS0YIs4iKsTMGbVMfjEFcmlA2HcZBer0EeFILZ+RYrlSab
 mJvLUwYq/kAmfjeTmtdzIwXy5Ih/ZYDn2Fc21YiPGywUuuDCDar3ilBbD440ISJ2
 ctiFleZvCGjM/x+j/tEMDE5pbMJGFWO6xYFrGFCPYpxdTI4GQcnXfZZ+WcvNF3l0
 UjqhIznyqFgbfv0P05p7VjFFQCZB+qNV1j7q77wJPahVSCnFfljIhWeDnbJBjrou
 XMxgN7L/O9YuN3R3UtJUYlfp2ymVA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013062.outbound.protection.outlook.com
 [40.93.20.62])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp90wyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 04:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD0z/OETNf5ISLDt0tlgILWdXWOjopaHprqsPaBVqAA5zc0xgeXJ320A7xDmPkieNo06jpohmCrn8KOU3DWGCkm0SoAui+llZcrEPBHkQLuhSAZC5iWHMhRnQxV7s9PLEvQLxFUtb3suWMP+KGKzPmt1NJmLhtIdLDfdkDhDXCl/Tv6MbqPdIJOca9OmtYsJjp6qM/cYUCqJuK54Hhj/eg4i9z7s5/Hg/NA2evDbq7ys3WTovsx2opfj571WbM4Iv3BmLj6wdRoeRpULErKqXBmn23mBYWqGMtoi2qCdtD54zopASoLfXKr7I59/EQzPKbbfb7ZoqTtcppA0csAiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0+Eg0ZXvgDpu8y4bCwvGFWy4tOYCeWWWFiTOgeFbS4=;
 b=Vh6036bar+JTR97pT5I15JUFIImRpjUdj7efyuSgzlO+KF3XaeW4e9N1G26z1hS/htLf+l/7ihi98Kk7u3OpVE7A6JwO7OEJ+NpgBB4uydNRDjVvNU0M85P2EtEfPPipcnkOvXCqqmgSyDF0PtUs2bB+JkARk1liRJaZwJ3up9l2Bp5LEd9h4kU7ByjEB7oqyfuLzhM2ikPUSycRnY1wAtRkd7xKLdNiVNidAVob0FyZ1qWP8GSGpC1+udMu7z4KUwU9gDJ5FhM/ncWDsC4N/Lsag5kiT6BsxldH+Sr/+kr1g9iwAOPm7PY/3eBYWnHKtMGCEQuuD/K0yK5qE/uXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0+Eg0ZXvgDpu8y4bCwvGFWy4tOYCeWWWFiTOgeFbS4=;
 b=FqnFwDawE5Yu0rv1hxwo4CrTyE5rqzuNk6KXOy5oEcvGotL7oM4LSLMVKlNrebk9Vc3IM/Bi4TRNsxwBJEZnKbcKDy++5q42lu1NGX/Ap4ahyLRUA/aDvqyNG1lARLzK3PMU4ZbHV0nnq4cJpMjVpeqbVeH4230C7kdc8v4uJbx8v8do4b7jLLIWklBUGRpl947bWDP4+FMWVQeRcGgEZ7VGW/dzzB+NmIJT5QEjTrwSwP+XgHrKCfzlRZftiu/bKj7/WUvS6eYYM0EsnhKr7Ayqg6zGbxqpD3ebHLiinkkA5d/Qo0Ue4axCmeQmnqpGsM5onHKAz7sF/9XvDbpWNg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA6PR02MB10671.namprd02.prod.outlook.com (2603:10b6:806:43b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 11:47:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 11:47:32 +0000
Date: Wed, 7 May 2025 12:47:27 +0100
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
Subject: Re: [PATCH v2 09/15] vfio: implement unmap all for DMA unmap callbacks
Message-ID: <aBtIT-G3ftu7xr0a@lent>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-10-john.levon@nutanix.com>
 <3d5e7ab7-bd1b-4dca-aba7-3b82a8ee8763@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5e7ab7-bd1b-4dca-aba7-3b82a8ee8763@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA6PR02MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e102d-fa88-4268-42bd-08dd8d5cf3bc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dI1+zfEN9/oOlO6gT2kNS6giCq2jUU1GZz2uiK0Jreme6nXBMoU0zKY0mN?=
 =?iso-8859-1?Q?U3C3vO8Xvjm9Dtmnl68IerTRa/E94VYG7IJFccAEBill6oYIHJFczeLFtt?=
 =?iso-8859-1?Q?ZBVBRfNuauE5bEg4xQCModrJ5RHz7hiSIkKt4tTv64ifpJ1tFl4TZaqRM3?=
 =?iso-8859-1?Q?r/NK/IKkD0Drj4UCStBkR/+/Yecazez+brceOF/oOkHcOnpDGo7NbYjtJx?=
 =?iso-8859-1?Q?2PL+ceTnTfFG+m5F9S3GWfiYLjm4Y7VXIlRCuppRRO8ah2YSQMroxuDGUo?=
 =?iso-8859-1?Q?gUs9jHaeQjP0sr8O4cvyv1IekJWdyYJRWopeXHaMwRNR+/xh9TOzzFSZWu?=
 =?iso-8859-1?Q?DnMi6UzQB7+3SkUYGTQ6Jjjr914t/wAoYqek1g4UUaD1T63owvRVYdFkHT?=
 =?iso-8859-1?Q?bRR7vGAnmO9/WgVdaQlRY/xqGPVavuSyNjI5yFIQvkKAe6vvrcxvJkIuOn?=
 =?iso-8859-1?Q?Rec2ugVOek9wSPk7YWaROaNqgDRkP5FvBpziV8UyMjZInXdfzwhG7hdAeP?=
 =?iso-8859-1?Q?6SGAHskr94JCrHjkoWnmFQ7sqJgqRU99i5qNyHMMhQ8tQTW7DKToJ08mzU?=
 =?iso-8859-1?Q?xPn41cKGIvr5VmQU4T2RrTiH+YfWC0523tfosb/dD2WR1Io4dxzAkMl600?=
 =?iso-8859-1?Q?aKRXbZzYVJDPEbrcLZe0F9zMA5iF449RD0VPFSD44T+UbfjcijSu06aIDT?=
 =?iso-8859-1?Q?/XG9WVj1y4S8II5gNeOtgIUC6g72yQjjt1OZQ+EFYtfzsM4TsphV1YIOtz?=
 =?iso-8859-1?Q?1gkUYMz6daeMi6d1gVvpZS0pofmswzBs9gHu7iOwM6lu45tR7+HNRy8ISY?=
 =?iso-8859-1?Q?lrOtXVRf48pZKgvzPpT7NSdnHF+cxK+LzUCEmuDHycK5/YrYAXmrAPTtZ8?=
 =?iso-8859-1?Q?9BQ/46wq2ivEifYpFMP9x9KNjiJKwYihM/G7BWVo+fltI/VL4HQ6XidTfB?=
 =?iso-8859-1?Q?jIYCN6Lhzl3AApVX0Y0gfF8dO/CZ6YFpC/soLJVwqIzWkFjS8/vpwL3HKF?=
 =?iso-8859-1?Q?TT1Jemz6x2hV+RjGzMwv3yjiXsaSxi9MeHcF+IqmhmY2wmcmNSDr8d2elw?=
 =?iso-8859-1?Q?wZ+CjHWl0j/4WX8y5V+x3Kcy/JVP4RvLiMw6ZDhc5nYArSkcnLZuEHymfN?=
 =?iso-8859-1?Q?wHn3CtIZqPF96njl9tVB2/dUzV6M61CU5LTkfzfBIiErNk75iAAd6EuwnV?=
 =?iso-8859-1?Q?ye5LlVHdtE20RTjjVi8DA4CsRlrZjhmypfUxNRibaceIXIWX4tXw2Ot7rY?=
 =?iso-8859-1?Q?dMyFK8dNsDqDt9FYHH/u7BW6QvYFRiP6XFM8ciPc2mJLV2peHpaex0UxIV?=
 =?iso-8859-1?Q?g6zPduYVnRJycz1LeP5Thx4/ZteYsI+nxBdHyuJaJ8sHnWdBx8ZJsg1kd9?=
 =?iso-8859-1?Q?y3wYnx5XdimIHo70yz/s9aqdo/76ciKTkq4HmuTb8U73Zqbi8bR7fVV41Z?=
 =?iso-8859-1?Q?P0pdpzFrl7oYeIlEXijDmTifD3qsvGp16cuCOPIbdDNcm6CksGfUzunl8O?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4qG7D+Tw+rrKT2W3PXRV6TCYXf0/nz+8geTjtjuIMYrIZYs62VSawfR987?=
 =?iso-8859-1?Q?T3bvpoYtXCmv0MRpc5h8HEuaBK4qK80M9eQMasxklmeedG6dV8vJTjWMZe?=
 =?iso-8859-1?Q?/tST2eOuQPi9RRY2Kpi4QzTWHg7phvrvCg0CTO0WhCUIvDZCgPwUmUwOOB?=
 =?iso-8859-1?Q?eJswSMlQhVJkhNhGdpq48p6wnqN3UN3+r3qFTRPJvs3dWjyJTGgPP93jEN?=
 =?iso-8859-1?Q?pVJJO47+AQGeqHfPl8VNdllrzQNvqDR0LjVBlQn2lFbbyfaMUMRnBL9QMc?=
 =?iso-8859-1?Q?s1N577pzmo93qDun8GsDZgYAcsHv9k8yfc8J+9mxxeibbWeIyW1Qk8QF1+?=
 =?iso-8859-1?Q?u4UCi4sqjvmBa9hmigCzUc/gofNzbm24ZhaLDWeur6eDGbiWsc2IEvIirV?=
 =?iso-8859-1?Q?pu9JmCKOzP8C1rGAAeW9y21YmA56ziZjFkJ4eIqvYaE5DD1TH+13bJ8Xbv?=
 =?iso-8859-1?Q?3QNvjmsquT19fWA2i2BFUy37RFurUfuei1z+HH7W2gpccxaejayrv505yG?=
 =?iso-8859-1?Q?LJE8qL3Fq+W1sH/E2Bx/BCreQCvjsjuObvzjM2MJ7oKiLzU4oBe0cbryd1?=
 =?iso-8859-1?Q?uGOWJ5ob85fxsN5kVFepgLqUxxogQz+b3FwoDvSgy/eyOqDc7NT3QozuD8?=
 =?iso-8859-1?Q?xu9PaLK+nbLR3grnyVD53T2siZPjTVSPkPkIKspP5JtR0FQcLEs5aQH21e?=
 =?iso-8859-1?Q?jxll6XD8S0ISTzoUsfylMF+c8v/MCJ8qyMS4jnUIbtc1McldJMFZOYwNky?=
 =?iso-8859-1?Q?rob2/smyppr8Q7Fpd1bUNJcegl4BAMOCqJdtRnE/B/z+svMeyIGuiTDfNT?=
 =?iso-8859-1?Q?jqLeM6+2hW/P4fGfkTk/TPhpCSDK5rLMli16XOHH2WG7aiX/OtKDZJsBCz?=
 =?iso-8859-1?Q?q0UdtNe+NPJ+LsxFUyQM11NwwSVWRw9Et/ifnIAU17ZRaRxPvZTT45fSoK?=
 =?iso-8859-1?Q?2EmZqRT0634cqv6S4KrzEveYSAw3HnMuog3Q4h3oWhWdRpUfGohJLQxsjP?=
 =?iso-8859-1?Q?mjg80VAfgW4KlM0efAvqhDG3f5pUL5Cim+MKv8aHkSxHIzJ+9mUmZs/l7u?=
 =?iso-8859-1?Q?vHkKAO/mF7PB4w+cRRs04Cf3/hA5BLJzw7cuAFnXHe5KGeUZsHpqOJsUXo?=
 =?iso-8859-1?Q?JEzcBdJnX8uHSCvvHN5CocKmyZJzvC/i0FlN6jLOKzH2MLXBjWqK64MfOj?=
 =?iso-8859-1?Q?d3adWwZitonrlrCJSvusua6D784KpT1Q7HAn16oOOduwIkLJLmdts6c9mV?=
 =?iso-8859-1?Q?mb8OzgT6irysnMxdsrBuGOpZYcLIRNpAjHNqx5xz6K8BJJgbSHocPZVfT2?=
 =?iso-8859-1?Q?/zZHHZtryCnFksyBvmglA4ZoklkxhV47JDjw9dscQIGOjS9U6txYJnpaaq?=
 =?iso-8859-1?Q?bkVvPSXBhKiQxr9el3Ob0EchKCkFm4szMZ2OOkym8o9ShpmubebP9yjbY5?=
 =?iso-8859-1?Q?bNByNSS9nwhR1WbXnkS9YE/N+6B6/lnKeD1uMAzouhFtTn0fDiTR698QfK?=
 =?iso-8859-1?Q?WS1g8cAviG5xIC3zuNcuRzpk6+Sb3B+PGXbHi6Hreu7eJrxwK2BQKUI3l1?=
 =?iso-8859-1?Q?GZUVePaP6u7C8OJfCgOgYPQfrMhscwDPULyTYt8+q7xI7MNvPbV1TJx9PZ?=
 =?iso-8859-1?Q?T02kdH0jQMr9YIw2kxbMAXZyr0B5Jmk/v8?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e102d-fa88-4268-42bd-08dd8d5cf3bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:47:32.3813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nKJv5BywBhp2eBrYL90M4S13Z6HSBoRN11vIDycCtt2SFd83WEuOIkyktOtO/0S0nygRNAvp6xrf2G9H7qhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10671
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681b485d cx=c_pps
 a=/rOuTbX+ZjzKyBIGvUmkrA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=08kxMZfGODAiY6nN8ucA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDExMSBTYWx0ZWRfX2wmWEdDnNhoM
 GygSeuaXRaJzQMJar+Hm+/KJA6hxovityyMdJaeVUBytrRLNmk6nBvtPsNzEcZ6oEvpFulytEub
 fzyY56lWvDMqQIkKu4TsmOsfDMyXlEo7WaaGlQuRobsUqLbEOEkshYceMHbtt4aQLFAtSfAI7a6
 KUUN6959m6Pp6ip5IhB+otQq27evNeETyasegE5AjXobsyhMyatNomZE7+fhS1+FSAS38s3y8vI
 o3StqEZmtcgBRZ5+EnjGpBDC/kTyNBH3TCmhuSUWc+YGstMtrWLrGNwSYhU0APk7bdp7NHdkYvz
 uKvea7JL1+71mIaRlhz0f405Na/YSVN363GC0WAVnDyk2P4gcusyA5MW5sZqrrmAQRsHmzsm9LB
 B5Lx/bcOvJHRs8zFX+qTfX0oOot/dt3Q53igGqWSLpfFsH0QozhxOCmtlKMUWYE6KygDcnqG
X-Proofpoint-ORIG-GUID: YbFcx1Rw1TBUznr7AH97-5FCG3WTBgek
X-Proofpoint-GUID: YbFcx1Rw1TBUznr7AH97-5FCG3WTBgek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 01:28:02PM +0200, Cédric Le Goater wrote:

> > +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> > +                                 hwaddr iova, ram_addr_t size,
> > +                                 IOMMUTLBEntry *iotlb, bool unmap_all)
> > +{
> > +    int ret;
> > +
> > +    if (unmap_all) {
> > +        /* The unmap ioctl doesn't accept a full 64-bit span. */
> > +        Int128 llsize = int128_rshift(int128_2_64(), 1);
> > +
> > +        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
> > +                                        iotlb);
> > +
> > +        if (ret == 0) {
> > +            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
> > +                                            int128_get64(llsize), iotlb);
> > +        }
> > +
> > +    } else {
> > +        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
> > +    }
> > +
> > +    if (ret != 0) {
> > +        return -errno;
> > +    }
> 
> the ret value should already be an errno. Shouldn't it ?

Yes, this can just be "return ret", thanks.

regards
john

