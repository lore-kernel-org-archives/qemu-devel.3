Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2035C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU01J-0000fw-Fp; Tue, 24 Jun 2025 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uU01F-0000fj-Sq
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:32:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uU01B-0001Bq-9m
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:32:44 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O02H6e005999;
 Tue, 24 Jun 2025 02:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9rH1wxspkOH257RVD+YNUZGJXiv1wJZe4B/IvVvzA
 4c=; b=uPleDpAizSZd+tJP+hxfPQi5kYm7PR7hA/F0ky6p2roEzDpQvHQ0s9Di3
 jaVuRJieUcHtDE54vKSslfvLqE/prxXuNi9Eq6WWKJ49LqtUltVcc+lnRFzOv+a7
 mQOHC8pYnqu9oL7VzaQAhbdWR9G6NnyJIj66pqkVR7jZjvALjNYoR9Z3CxX+SLLa
 +Ry7cn35JFNBAte2KC/tHTZJOCMH98fK/w65Ku9q/yn9KgNEYatbdunB/kAzMj5x
 qICYtJiEdpGAUPEd9WTaGlU0EHka+NLEOThD0SnbOQvxsurcxsFotPHwQfaAzvvs
 8vccoQvIXnClwXaGCuYvRjmswqRQA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020139.outbound.protection.outlook.com [52.101.56.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0ddp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 02:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXcGfkbZjkHisLaltUDs7jiKfFJ7yTzQPI8BWmCqwJzVnUhKE7cdT7kkIrpqVAbFDbJgN3qloMjGDVDhLOILYp7DJ5qnbeBrqoCzzuqfRAD2GAruz80C30AcvzuYuHFiNwA7EGwRavRoGXz9xkYprUAQq1+1ouGXKHd4gZFLHsruC1K0UdRsIMNwzMbo+cTm03kgyLObvFxwwT1HHWRn/R0X4RNsFaV0SoOefyBw55GxVg1Tl3vPaZP3XKkTvG3SJSYrsu18HvLEStAfgoGMWo1xQN9K+7zT/9R5rLE/T8eWgBGE2Hbtm7Zi/SF7/oYVUzL6BA+WgmtI91RXYmTsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ86NUWSa+HLFRRLn7V+8J4W+JEKLYmJuXNjvYWEHiQ=;
 b=hALLuj0E8WhDMd7EF3L3wocIXzS29fEyLrbE+VzcKgEHROzDw5Z6YwGE86+oUziISlJc8MopSjxRT8eMIMaWGI3+XNdaUlbozI+c6OrQdNPo1nRlQ+vdE+6C74lQ8sgP5zuFRS/HM5TtAM26xVqgGiM48fhp05A4alWzTLZ0S5EQF4blZP8g/g4yQyGy2Jm4cK4qbrkb+ynS1fnim6CksEAElzeKzUL8qZQ7dfJI6rsQQJioluAx7OTc/ovRd8Xt1OCezkfyxSkrAZebFwHMNgA4UBgBXwAxf2o5x8ucQGVpXNJz8gBJaDRcGFd383Vub/Gpp7oOr3NlrJdgobyVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ86NUWSa+HLFRRLn7V+8J4W+JEKLYmJuXNjvYWEHiQ=;
 b=JMT9RU91sYuDe/vAK7aRWWhYf0KIQs74kVPxzVg+Y5NZid20U5gjlx8NtuB5hQjDV7xTX9jMa2K6w/pYWbg3i4DDtxG/2PKfQMLenn7M5SAsgjS5jQx4QJNQEb/qHnUQVCAJN1bnukZD0J+cBDgWChtcbwb5Vzs86qzUoaHkaSIPv/+BOSUfpxjLMSF93JD1tesqm+/Mf35cLxdQe6ytmBrfd4f1sUm7S0grmytLeNnf27Qp9RAAZz2uvkbDTYh9sjJSs2NpuMexKYzUFCJfh6zvefuI5Y4HQrekCU4iJw3OB+tmNEVwCRP707Ht3QdGCsPUseHtjnmPD7PdwQCjig==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10659.namprd02.prod.outlook.com (2603:10b6:610:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 09:32:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 09:32:34 +0000
Date: Tue, 24 Jun 2025 10:32:30 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: add license tag to some files
Message-ID: <aFpwrqX0idMrL34I@lent>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com> <aFptjwzxKjvwYUgP@lent>
 <00590277-eb13-48b2-afeb-f99134fb3265@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00590277-eb13-48b2-afeb-f99134fb3265@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc5b5c1-e65c-4a0e-64c7-08ddb3020c9e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?o2Q+wy//9IC60JiWC33xsLH6/dNqzXhJSgsI8prXSii5iBjOz5dU57cw4H?=
 =?iso-8859-1?Q?wZkI+9ihGwKm10wd/rOWVuwZ0phw30KWuMI3JVqyr0G/vSMWEo07ivkpKX?=
 =?iso-8859-1?Q?1VspuAJD9ucZDcB1bD/usC4svf/NtKVOIRWuxcogWm82LVNFjUQYucWwMC?=
 =?iso-8859-1?Q?FHzF6Z0QLhZtin5ZqVdlNbYovEqn4lc8Hl0LnknJhVRLMAMJxDDkXwrTvf?=
 =?iso-8859-1?Q?MPgjJuGb6XCEbEmIbTXbYge88lhTnwervwwM3wMD0esqQspL1dkxPKzS4E?=
 =?iso-8859-1?Q?DAqzFyoTh7bIH5GDU7gXPjjqH2slaJYde+8tsvXeLIbe8msIKuWG4njS4W?=
 =?iso-8859-1?Q?slHpxIewS8r62f/sJdndGDP1OCL9w0qBkop9NXVtI9OZ+UtK4CJjMT9AaB?=
 =?iso-8859-1?Q?8n8LldVCkDmapCyjpXHQ7vZ7yDzYnr2irmZxi+okjVHrOTkClKhtx3PBao?=
 =?iso-8859-1?Q?eakyHNtdShT3v17zeMp9Ko2MjXWtJ8ymn++EGZIaR6kH0p3mxYfB0DvJ+4?=
 =?iso-8859-1?Q?kkmA864SbVgMs+6z8rfoEIQRGmEoz8wtTLWtZB28XCNZ8fYmS3z4BZ0eQ0?=
 =?iso-8859-1?Q?Hyb2qYHtXt+gx2ut6P6QwOJqhBmJgi4cgbegthgZQ+in5zizBibt5rtPD3?=
 =?iso-8859-1?Q?ZMSHb0wFYctDwbhrDWhcIgzDPk/zueqacym73qQTHba8ReNdeyjvnU64K3?=
 =?iso-8859-1?Q?VDldoI5KgIFJV0BcyUwTo80vN4yiLXh78tRZQ56w3TndLuaDy4WBJo+ndD?=
 =?iso-8859-1?Q?v4i8rCs1pOgl70RQTI/iMTC3hgkxRQ5d/lJPg4hMJVLSOHbI/DJ3HRAfmo?=
 =?iso-8859-1?Q?Y4FlJapOJ4zxgEun4UwceiYH/bQfvI+OaMXUmOMdwwI62ssLApcxtRSlOp?=
 =?iso-8859-1?Q?qDKV3h86PTbKiV+uuFUHv0L1ZGyaGxB5RGt1Y71Ubb+dA4KfuNiDU2H1uM?=
 =?iso-8859-1?Q?YR1Kx2qnQoHYYwDvm/rdtDUExExXEcdBpWrLTscPDM52oLdkuQBgWRCg9X?=
 =?iso-8859-1?Q?9r1K7VKiFYfP1dg+pYVglwjEyymXpUtZttDMdn31sJnixwwigNz/G2QEbw?=
 =?iso-8859-1?Q?5eY7D3PdXfdqigztwfw50XlxRUYfUv5f64dqfOxO8qe9KJt6eaGk9socTD?=
 =?iso-8859-1?Q?BCcoufqgugw1OjCW+VxZGNIkbaubl1puyMzxriZ1LPpjX3KkeBAR/Ty8QP?=
 =?iso-8859-1?Q?nPATZErXRXOMPomIyMZiLXzUC/is5RxgVf9+fNHjc2DwTsDrFfHtjXcMs/?=
 =?iso-8859-1?Q?D+1PY0bInpudblp88mPGQLNCP2wV4DNYoPGOkozNDyNcGegyDdvKz6pnXZ?=
 =?iso-8859-1?Q?WFe3v0hMVoKk2Rogl/GAy/fLYmkJTg1Wsx6CXiqSZ92nBFZQRfjwXPJX06?=
 =?iso-8859-1?Q?/5Vsty+lebrX7kA7VhAveJ4w5W/t46qvgivntMd8njtZh6T1kuVX3lKmf1?=
 =?iso-8859-1?Q?qBW+6cHEoZbdUcchxflUWFkShYeSVG+sb6m+lKVMSQjE9I09/IoI+j+U0n?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F6b/dPD0oBHGtTU+mi+RJl+yWCM7MIFXqei7Jnz04TK9cUqXB07KBrL79Q?=
 =?iso-8859-1?Q?qkZ0tLq+TZO2H+H780/2IaEkvyrbnhDttcOEbF1Z4e8xOYi+1fiKRNwqEG?=
 =?iso-8859-1?Q?eHw0m8enEQ3lZoKnnwkCVQE0qJOWnZYPWKGiFHxr+T0HHrYtBhLi0i61ed?=
 =?iso-8859-1?Q?8u2tV5nfnote5m+2TWWlEdlM2ai95LK0mupsDYL9iMFAwu0T2cyvKImXCn?=
 =?iso-8859-1?Q?BAlpqGoUGuT+VsWGQnqIX3SkkhmzIjm/AHEurmfsSykgUrP8pxLGTjb8Qm?=
 =?iso-8859-1?Q?K6GiJa330Qyb5kQpYiGPJh6FjKr9KB9fwuO9RrDNUiGF5C5w3C/WdkqQ/r?=
 =?iso-8859-1?Q?kji6XQ0ZAAfok2kmhQ6F/FtEM2VWnJ04q22ZMAyotwVHTsp4LDE1TgWz1G?=
 =?iso-8859-1?Q?kJARhIgXicA6E5x5eoNiNUaFOL+AqNkDQIOyXkPafGQRvMLkWOA3/UUu27?=
 =?iso-8859-1?Q?oAW5YUNPYsUztzRqgs5wLKR4j0o71HazgshM/o1BdTisLC7Hy4QhNLQPvG?=
 =?iso-8859-1?Q?ykeYTZHb242fEjybPYeD2yafn2+bAM73qMc9fN/1r0pmBRzx1Wfx01cLmB?=
 =?iso-8859-1?Q?iLPND/fu7GCgXcjfY8MDAOezj/E/y/TczCz9XlYhoUfX7aZyN6gMW26MFW?=
 =?iso-8859-1?Q?Ow11ltFX6M2VYJKr+zIa6UbxzMejU5fNEuRLOhQPBSNaSUmc25TC94cnqv?=
 =?iso-8859-1?Q?3KO1iZiuNLa8RBAnDsm2o1pv9FRGdxBSJA6ugGSUr6eYYEi3F6TAHuIc82?=
 =?iso-8859-1?Q?BeBhZZ3JRhjXLBCT6EOPltjDH2cl4xFLd+CBnRu/zamh+DaA9+ft/j006l?=
 =?iso-8859-1?Q?Nv1MVehJFD/6HiBz01/3uInjsaq9XT/vMeRLwoiCi0Z0zoOrcEC9T51yw7?=
 =?iso-8859-1?Q?d1pS0KO9hX0yxn9SSa0+Jtu+l06X17DpJSbrLKxKUqvHFujJ3+kpx0uGzU?=
 =?iso-8859-1?Q?lX6vNHTUU69mEUGZr5rmHD5iKylBQoqq9uly8z1varHSddTdFNxIg7CW0O?=
 =?iso-8859-1?Q?n3j6TomcrykKiLlCVAQsed+Ii/Lc9vVfKjsH2HVEtCEY5MOtbx3ws8PWbj?=
 =?iso-8859-1?Q?E2DacXX9Cw+kiPSbZkTQ8I+qsGIAA1EGWhPVjtzWTEGCSKsfu6P5zUg/j2?=
 =?iso-8859-1?Q?fjb+gaiwi0IFkTgsujAmCTWTIdIZcEg5XhVCwZj+fma/acS6oGwoVakx8a?=
 =?iso-8859-1?Q?P3WyAiDKz8ff6caa6uci6nsM6QvkR4p9ielaQBa3VWrKsnIGQm/CCYlZLG?=
 =?iso-8859-1?Q?1+GwRl1xrkQoCWWEq95RSuuJFplIh2HNv90eF3eYNnTWzcjRwQLQMK3mah?=
 =?iso-8859-1?Q?pHYEHywwWLKOljobOH3lPGnWmsf7aNpdjfygjv90lQNDa4gXay4f4mT1jF?=
 =?iso-8859-1?Q?pOw4XUoZKlbMS/yhmRClXx2yJtxX5LdZ16woqS2E/6OmCCzRfBWnu/H9pZ?=
 =?iso-8859-1?Q?Ik5oRqkQJmgQa+XG/4Bjn4l3r0lwvPiRYFWD8WGwlOUImniLp8LRbcp99C?=
 =?iso-8859-1?Q?IZsCXUWC9MIS2Chl5M2mkm7pOkiqN2x3/YrLtMU32WMI1hsXO9uAcruoQz?=
 =?iso-8859-1?Q?QvTs8oxOaOYL5TjlvC7j3Gr5pAY7nEYPpx7k0mFg03WVTURKkzic046X7A?=
 =?iso-8859-1?Q?Gy/HpMAtzCAzsd0N2N0xTVNujPGZJMYFh6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc5b5c1-e65c-4a0e-64c7-08ddb3020c9e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:32:34.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgGdbXUn48TbcZfVRsCGpAtV8w7MC8dhJNu5dTUYZ2tn2FGTBgzXMsMDPgHSmEKTpNrVE2XSkAHvdeIw2Nq/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10659
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4MSBTYWx0ZWRfX/ZEGjbxm6LM5
 W5Fn2dQLrFngN3hermOrjXTXZg9JCk9x1nl6oNkFr1Z/HRtwteitOE6HgEcKQbvi7Fse+sIgzLy
 HTDELbugorwboXgS0DtMfS9+3Ln/bfOJ8QxIIswoLRqNlNVlzDiXTz0OJ/95nj2RZmOXEHh4SWt
 dE/ewoL/Bl0lSIeimtmN8GwDH9TQ9J2ZaVMwEVPlXQtxCdxxu0Zp7yZYCX3Tk5MilH7hLM1UdgP
 IQfkn/Y2mmDWjsO48JAWPxOoULfKUxu4Dcz07ZZC+KF8nLMspG/IP0XvyKGgj6e/nQR6bWqzenz
 ZFdiwXF7M3KQMMZGoITwBW29aKCC0jXJ/Hvu7nieO8FCho7MnCF4F2MxXY609Z/Y7q40em0M4o7
 pEsnfIaKYGpkKk4MGQ5VZHi4T0Mw2HyU1+bApMX0coL7cqz0AsO4CUJp+vEqr6ziGuVzM4wz
X-Proofpoint-GUID: nEQjNHmyDxgrT3zaMtJyrWIxSoDkyYtq
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685a70b4 cx=c_pps
 a=HngsKjkEkW2FdqPxnP33Yg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=Q00gT4M_Fn_fhTCQMwQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: nEQjNHmyDxgrT3zaMtJyrWIxSoDkyYtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
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

On Tue, Jun 24, 2025 at 11:27:57AM +0200, Cédric Le Goater wrote:

> On 6/24/25 11:19, John Levon wrote:
> > On Tue, Jun 24, 2025 at 10:05:44AM +0100, Daniel P. Berrangé wrote:
> > 
> > > On Tue, Jun 24, 2025 at 10:34:40AM +0200, Cédric Le Goater wrote:
> > > > + Daniel
> > > > 
> > > > On 6/23/25 11:30, John Levon wrote:
> > > > > Add SPDX-License-Identifier to some files missing it in hw/vfio/.
> > > > > 
> > > > > Signed-off-by: John Levon <john.levon@nutanix.com>
> > > > > ---
> > > > >    hw/vfio/trace.h      | 3 +++
> > > > >    hw/vfio/Kconfig      | 2 ++
> > > > >    hw/vfio/meson.build  | 2 ++
> > > > >    hw/vfio/trace-events | 2 ++
> > > > >    4 files changed, 9 insertions(+)
> > > > 
> > > > Daniel, What would be our position on such files ?
> > 
> > > TL;DR: this patch looks reasonable, and we might as well take it, but
> > > there is no expectation that people need to extend this work across the
> > > code tree unless they love doing historical code tracing :-)
> > 
> > I was required to send this patch,
> 
> ?
> 
> > as Cédric wanted the same files in
> > hw/vfio-user/ to have the identifier.
> 
> SPDX tags are required for newly created files, the ones introduced
> under hw/vfio-user/.
> 
> Old files don't have to be changed. It would require a legal due
> diligence which is a complex process.

These files came from hw/vfio/ and were then modified so would carry the same
license. Please let me know what you'd like me to do.

regards
john

