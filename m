Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F4CC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6tZ-0003xR-2G; Tue, 10 Jun 2025 17:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP6tW-0003xE-Im
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:52:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP6tU-00033n-NA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:52:34 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKLgl2013223;
 Tue, 10 Jun 2025 14:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=QDinCehPb1yZuQy
 bapIShX+N8lqFf1y9o9PGHDe6wx0=; b=kQZyiXQpSzKlddI1DKtxdGWvOs+tjhP
 uuV/yAsmH18y+r/VmnfImBHel062cuD+Hm6vM+o+C7MF+aoVvPkdy3wbY3avPt+b
 g0Hfm+IjVWyxA95Gp92FBqWyA/pHk0qF5an80PeDn6zTDDncz4Er+oo5Qb5JhMm/
 0uSRFttQfO8T/ZfWGNLeK63SOuIuvjjhNOJA0mnuinjtW1O67UG/lw7x6yu5RHFB
 CCJCxnKqQ0IOa5RuvSrWAqsad3u92DgPBsuEt2La6DGk5ztQn3E7ErUvCUhEB8CJ
 e0o9UDRqgoXkLm7zaprvl/WmkdEvVfi5cpY9ujHN7kv0zNxSaRQgetQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2115.outbound.protection.outlook.com [40.107.244.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 474myyxvh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 14:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1C0cCLO3PSe0IPgekyaGqGdJC+meIMPHB6m2cKpaXrqe2WVVEqPmm31yVhPAzkdC8wT57GlPmC5HTgJ3Z06Nt5LbBlFisqyf9gNijLR0lg6aYvIJOhaMtHA69woP+dLALIX2h6wBQtI8FyuX/o0f5fAvI26i0RP3rWGzfw+RbUcaECo0Ud3NSyDcNWBt8MjfcrFvssz96YC5qsv0XKUWBhN5m0fmvu3uNdl6GEC3DljYZKj3xqdyihXSYOsljnZGWtkkts2/HL0EjikUzhaqoPwZeryvgd4jUobvMqeDDrtgQ544sHDl74ZtV31VVW9/RC6w+J/cpz1A3ceF2oXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDinCehPb1yZuQybapIShX+N8lqFf1y9o9PGHDe6wx0=;
 b=FA1OEhnFCdYLFclAAiUJ98J87AsTis5vONwjwyqG32uHUjzKdp+tnYcPOOIuPhogZWaYEyDWcKWc227Yyu5KTY7XV1+nQZ3MHEFyWB/WP+EGz1doFtfBSmUphG0d4zzSIl0rJwKotHsoYPkIzkyjNuT0pDmi9QjUy9iygiKvvAljiIXt8vFQvarufC+OcsSwyCJ33hkSVK1c/S38NHpJqk/m5ovvaP7NcxT3HmTP3Zz+w2HOsHs9KfAD++I+W7yL0twYryL9QPsEgEcUHTDrnYtoMZarj7USKxPZRli+lAwEZrTG0gW7k2wJClmHahe9Lx95gxf8rmbu3uK1bTvVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDinCehPb1yZuQybapIShX+N8lqFf1y9o9PGHDe6wx0=;
 b=i5fJLocOHdpHhCRg4lt9b5vYxK2nZZ8UDdPK1zLlRjg5cf9OIGYsPrOSBl2YTRvuHbjH7oYnUhMToptJSx7owuRX6wz6akBOj/dyYTlh5A/JfDyE7337GgdXD6Fd8J9a1FlddmeZ7TwqAAEchvU0VlNFf0fp80e+GQ2z7xzsMI9yBfNC/jOKa9U0UYvWwZqR4xCKkdPopw38TdYc6PlL0G4dVAfvIn+9xR+elA4MRucAAoEf7GuIIAdJ9K2GprQU/qSwwooZBZfXl+Ybdd37EhhYf5ePxH0tgmA3T03PGFJGVKSDbLu/cse2TG0uePhnjqO3n5JXscLT6WB44gBlMQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB9852.namprd02.prod.outlook.com (2603:10b6:a03:547::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 21:52:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:52:25 +0000
Date: Tue, 10 Jun 2025 14:52:21 -0700
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 02/23] vfio: enable per-IRQ MSI-X masking
Message-ID: <aEipFWB1BOmKyXBQ@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607001056.335310-3-john.levon@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB9852:EE_
X-MS-Office365-Filtering-Correlation-Id: a91b79d3-0054-40ff-fdc4-08dda8691656
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5PC6Rxp1hKgMrkZ/n4aLPHAcI7bwPmR9DNizpYg7Zms1SqBdDJrHp03DMgmb?=
 =?us-ascii?Q?S43/tLyRzFbGHyMTwSwJqpBkho/4T+7eR2Vqea3D8/1K18YsJ9EJCn2hB0ig?=
 =?us-ascii?Q?8KIMC6m1aHmQG3rAH7nwLIu7Kc2t98x3BFmT/vD9P/eyD3gwYcVK4uTbrIKI?=
 =?us-ascii?Q?VwtiLYjsIAy3PlHfGRyVqYGWFjQh8V+w7IJsttcPLkOmr409FRqpPF9a4Ckq?=
 =?us-ascii?Q?9jrD8090ZsK93S+TINZY+NXmTg8tmjGproC8SvcfcVe7MhLDo5pSscUlIsGf?=
 =?us-ascii?Q?0axzxOTNMQdQlw2uIUGatgWC5+PPP+uCWn9/UNeyqYbzL3CB+KOuInvQqVuf?=
 =?us-ascii?Q?fvU+MEAMvMhyOhitW8m0/dZf0jJTnZJmnl4kzdMTI7tyQKvMbYshH0Khckzb?=
 =?us-ascii?Q?p30c/LmCz8LXu4iS0Oo6sBIQ9jXgrgak1J3U1XPPTBANHmCszRH2sHpLnTom?=
 =?us-ascii?Q?r/Dvxz6/0eGa0Dvfee7SGPIEEo9W4OhaQc9SfmKkzpxhlB8v6pa7PihSa0on?=
 =?us-ascii?Q?judzQkxa2S/vk0hCVq/w7YEyKrYXFOgtYVP8WNcIwPUddOmIysEYWngXf3nF?=
 =?us-ascii?Q?SoA/efFhLxmpxYWp5JCP3mnUDQhKXkNz8TXfwHn48S36zrJ3+jzXn5v3OptO?=
 =?us-ascii?Q?U3szUjZrj8+dNrPsOrTQP+0VqRa6JyCnU9jX3rUuxu55QIhIiVfjdvAjMXWo?=
 =?us-ascii?Q?GJauwVDR34bLn2Pgyj9csK1E7MhRU/GQ9jeVNbiIDyrTvhBWtEzaRTpf8TpM?=
 =?us-ascii?Q?kuhu6hpsvMyhHlQD+n3Uw0UgmvoNEDZJPJ/FiO+aDZGkQ2WZ9HlpHGvSbUmw?=
 =?us-ascii?Q?cgtNjO8jfQkkfwfwPN+d8zkHcWCcowU7vKIiqeVsR9hrxCZ5HtZZC+Nf+oHK?=
 =?us-ascii?Q?ZeYJBTlrwDtTy2SiNEQnF93OCVuYRDMcew3Qkva8UrsqVvC0xIGU9meQf6UF?=
 =?us-ascii?Q?yqjYiU7sAjQ0wSmRk6CT8GYzm4BgezwvJX7LxrN2xctRx1+o0BwgLMNRvti6?=
 =?us-ascii?Q?fSSJcHPGpCoCLXw2ixghazILTjMWV7TcRYACVrJaki/e8K/xbFXqbXs6+nPE?=
 =?us-ascii?Q?TGFdFssg6Xtfb4kk+ctI+h11BW+t6eaA5wIV+jNeEWgkVL7tKl10ElHiOMfV?=
 =?us-ascii?Q?VW02nuH1mqgsDqzMhdOq/gbp1I1ADetWxabU63lbjDxmU5B2LpPPVBYdc6dn?=
 =?us-ascii?Q?r8QrM73nz6pa8TojxBWiLJpZfTqQGASBx1/dF8Ahi4YUUmY9amlDlknX91Gi?=
 =?us-ascii?Q?QgB+wvCEOMIDCR7MENnGUGb5zuat7yieLeQyAhZZkbrOSruGZPbPSJFIwLwM?=
 =?us-ascii?Q?IUqMZsNmLB3JYqjvUWmLFTfT7+9LOUi+jtNJrlJ214y9AZ6zQMVKeLNDjPrw?=
 =?us-ascii?Q?E5yuB0wo+0LKDfKPaoCTgr+o6q7BTyRN1HjOI7UBhli3r/qjuWas1YEB2sus?=
 =?us-ascii?Q?BnCZ0YclymU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7bFX9hYhZtUQC7M/TRnn2dXXxSRXRDozvwPhZeUfZ4kCYKu4dLzI1oUlJoDh?=
 =?us-ascii?Q?dacxcOGYTO5w60fws1KHj+VX7MFTNi4KzjhTNo/YuMFaQwj+mJyb5PXGYwMM?=
 =?us-ascii?Q?Otx4hqVZj8GTdzsdS+7ftQJLpJXtXOyjOu/dNHhLjJcxSdKE/pQmZVCTb7m2?=
 =?us-ascii?Q?WidhKhZe9VFv9cod93sKnNvGvhEw2qNlWvZ2cc07jBWn/Pj0DEC/oEY30QrR?=
 =?us-ascii?Q?JqhP9xTwp3DU1hEJCjz9USJfAhpD6l3G7rly5zqWdyDfdaiLIXI4KD3aPYn0?=
 =?us-ascii?Q?PfUnpO0FZJBwCXdxxwYi82iCOHufM+cy/ySdrdlyVpBIDfUmh1y6qViyYyBv?=
 =?us-ascii?Q?MuMscetTl61j7DGP47BHeo+69WF3GKMiWOvXa0oTJrVaOc03i6Gl/D4iq5Z0?=
 =?us-ascii?Q?ZwMEdXB0zk0fRQ+Bd8SgMgyECBlTDr8xM8qDaYL+0G8Bu7oe8rWBpHlzCNrW?=
 =?us-ascii?Q?GxIJ4W9kCbQtIZtI5FVHNNoO9wqllVH3iYbjCJAI7QpQbvq28mg96SjBF3e5?=
 =?us-ascii?Q?v3ATYzA894oSA4Fu4RYRGfl4428oLE10xPYTmFArH+fHIIpGZ91nMi46Qr4K?=
 =?us-ascii?Q?AKlTeGsbjrhmM328NZXOAUpe27Efsuk6dG4nRwaNVHTOIRUcOaMZ9JdQ2H7a?=
 =?us-ascii?Q?YDEGKpZn0OsPfneSi/FsP0hZBz5ZUFppr81EoZJrM1MVXm4nAyHb+NrchXO4?=
 =?us-ascii?Q?+XLT1gnRIHLNXGYw8RR1OIiOUbBf1ADPewRQ3qzzlXQmCfbbeoVJ7wywes5p?=
 =?us-ascii?Q?2skneSUyttJXpFrQX5taCBaHuwSZPai+/x0ybK3kGI6fW6UFeizSszCwJg/G?=
 =?us-ascii?Q?SQQnptMx+yi9/XSrEMZ0BpO4Jvm6BE7WS6Hpbb/zQuAYb/TnFR46SSDJPD99?=
 =?us-ascii?Q?R+l0s5n2jXLJj7eNc1X2nYO1bJ61AKeAFwB5qQMwzda5+GX2Hw6Cud+EM/jM?=
 =?us-ascii?Q?amPhhHN1oADptt7FpbxpZ+1aL+9ZrUQN2P5KS538qE/KDArpbAcwXEZueztX?=
 =?us-ascii?Q?vMtxpDin3XmAh1tnETA2nhuwKr+n5pH6g9SV8TWoTxSvYkzzJfdwJfDT8ieM?=
 =?us-ascii?Q?0eZYyL8//QVXudFb6naSB01mMVV00cS7mcvxmqOaB6jjn1eBfvDcdYaTMcZ5?=
 =?us-ascii?Q?GjzGzq/NH3Iwrrc5Gl7kSc8TWpM+yvXmEXmGCdVqEp+qMNNFsatkJC43f70E?=
 =?us-ascii?Q?jsbMGMcvF59ZnY2sXtT7Z+57iO7I0ImMLhdKf/1xdzcKe1WAFPCnqxLPR6u5?=
 =?us-ascii?Q?2N/5TwvE/l4v7t6BCjk4QxAwQfoRtc98n/3vDEBTvTn4ZGJcwhWkSOY/G6rt?=
 =?us-ascii?Q?7xwU1CgBiyB7qFQQ78/iQDwF/ycKRGI6NHedDCuqC3R2Nf1Bl7BK88vmh9XN?=
 =?us-ascii?Q?qUks1YGsAycvXRHN4y2hxI16jWumLgfyUmj8UsraobQIP1jZ/VBGxISEnRPP?=
 =?us-ascii?Q?6VA1TanvXgIxMEOvdbstJMhRXcOSC8zZVs0CQNcHKZtTFGJ4AdHbwtOQKHc9?=
 =?us-ascii?Q?aWD9ced4oXWJdUXe+8p1LGs9yG6Sc09nK2aBVXOMPlsQCEaIWrtt4/j4w5qI?=
 =?us-ascii?Q?6I2cyohfanTi+UdYW4Imq2Py2xy2kP3MMHap7j3d?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b79d3-0054-40ff-fdc4-08dda8691656
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:52:25.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FyTSaYQvD7nMRoBgmo7q+avbAMu2VSrcmy5T2FSNqjCooSerMfK9vynSI5a03zsFgR7DFNGLU85zS6IuDMsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9852
X-Proofpoint-ORIG-GUID: HltRhNFHBQUh_3ucSHPAIW3OsWPVpyby
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE4MCBTYWx0ZWRfXxijCRv8Tu4Qp
 Pfzo9xyrW0+8riX0GJv6Ax5foiEVRf5okZGc2E0f33DHkCB9PGJHBhEXgU9Rrpz/MIynyBa6moG
 wYO8eiOwe4aerch/N3P9W4ur3+SjEgfBb1mFuq405NJs3tKoMKIr37JE1DloxfOgbUKTmacwyE9
 tlC4RJjvUJ9PuZiSLo5HdNspBiX2h7WLSjgHRRLdhO5A1se1j2BBxN/MwQvnxCJRPtRHZvw5Sn5
 7lVmeEOsV66QqZYi4Ff+VzcMImuxH0LnhsRiUEwy/LZynbOKuuAMeumpW2kzfK576m5WeA1pBlt
 VRigfvW+UyERY+Rw8Q8nLyHN3Hqlrjk7k86nnSjYL0V9lKnVFvWJ81mtFb3Q0iVkUAJx+jsFGar
 HThWl9pcNYkXAUcw0eU8WDfPRnYDYXvEeQ70TYIeJtIE9u5/g6Y/0EdQW1NxQIqSTBN1yDIB
X-Proofpoint-GUID: HltRhNFHBQUh_3ucSHPAIW3OsWPVpyby
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=6848a91c cx=c_pps
 a=CPDyn8ho2KF1l7cSkvawzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=-mCqi4Jjfi0hbvc3MmUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
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

On Fri, Jun 06, 2025 at 05:10:34PM -0700, John Levon wrote:

> If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
> this in ->can_mask_msix, and use it to individually mask MSI-X
> interrupts as needed.

I'm just going to drop this patch. Neither vfio nor libvfio-user (including
qemu-as-server) report MASKABLE for MSI-X anyway, so it doesn't seem relevant.

I'm not sure if Oracle had some other use case in mind or had previously tested
it somehow.

Furthermore, this:

> @@ -702,6 +721,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>              error_report("vfio: failed to enable vectors, %s",
>                           strerror(-ret));
>          }
> +    } else if (vdev->can_mask_msix) {
> +        /*
> +         * If we can use single irq masking, send an invalid fd on vector 0
> +         * to enable MSI-X without any vectors enabled.
> +         */
> +        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
>      } else {
>          /*
>           * Some communication channels between VF & PF or PF & fw rely on the

Seems odd as it doesn't pass DATA_EVENTFD, unlike the vfio_enable_msix_no_vec()
below it; I have no idea why the difference or if it makes sense, but it doesn't
seem so.

regards
john

