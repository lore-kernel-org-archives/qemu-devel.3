Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C535C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIq-0008Ht-7D; Wed, 30 Apr 2025 15:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIl-00087t-Fq; Wed, 30 Apr 2025 15:41:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIj-0006Fj-N1; Wed, 30 Apr 2025 15:41:03 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHdkq3028201;
 Wed, 30 Apr 2025 12:40:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BZaip8jGsBe6i0ux/RSNpfcACFNTQyyB8RRCT4PSl
 M8=; b=yTKI82knzRZYQu9MoJ0Bf6j6ZpEnFnnIygJcoS2Z1ErEm1t6P7FC/sTPn
 TIZT229A6OihWjl8iUgxVoLgGH8gU33rTPJMEb2YgukLNRTGoD3/m/R8MJM+s6en
 NRRm0IkYUZADPUQ2wWsFjlZZyDDM5YHjrF52mZaHjdK9VPk0MwA6iDWD6m97tPlo
 /6Uw4qtWChPAkl4v3024yhqvXSKMdwj+CC3+CCIchIUMW4iFPipfKCU1RQWiTxh9
 p92yMCMlZBLxb62bsFdSXi7JThcq/UMHoEMKdeG9IjpSIO15SOVu4cbR+Nyyol6G
 9wvOgFBPHXiwtCRhmq7o9MYL9j0tQ==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utu9tr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdlhCTHA9gP2i37vasUH6ujEi+Wr8ZrQc74uQS6sxYXpTQHtpAGUwcOm5ygERijM6nyVEe/YsnBU6oEqP7s6VKRrsHoCRbDGee+c2firaBtcRu/YGW3d6643O3tdy0IXvJDUyw2p/IuDRAjjRskL3wkpgGBF0x3g32iAUQqsOZcQ5SuZzmjxuX1H0gsMYiTYtqbgMxKRsnNM3jfXo7kg8NL1zYPhPpvvzsZeBKnFTMHqa+GdqigLXE1PLboKiR1guF4vyoTQnEkRreOT3qKvdRH6txw9bEpaX4gpPTrHRXYemVdZqtgVjx+OiFlse5TOpGSMN612BznPAHtamXJGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZaip8jGsBe6i0ux/RSNpfcACFNTQyyB8RRCT4PSlM8=;
 b=Z4HjyAw3dOMVlKaep/Bm9r/LUIk/mDDcZznVJ8zv/3RKi0gfrX/xaqGoaYVHi4wLpAS3DhVtUYtY2A64hyLvajYRPQGmmaYvBQnx0D0cJ/6d70SfIuqOFXOdVaX7AV8uMWO5S0TT5KVEh3ZMa4g0c6CJYm40qZ+hXeLLkL9i3B76kaL1Zl4l/ndrFx2cb3c7kQHQ1C/umziHkBWm6MjadCJ2mQ9zRWan3fleRoOwBdUbfR9ARMBmsj2HGPsy2/ww8pWlys1xvUAk766K6TcDklujxXwRvxNNIPMm/cXIzKZQKcnI4VWsFzIHwEn5QONpPXB8ReeV2fcM9dfMywVMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZaip8jGsBe6i0ux/RSNpfcACFNTQyyB8RRCT4PSlM8=;
 b=Ro5DF42uyOA85CXeLYp6Yn585fxRyFjw/wefrzgLlkW9osHx4H0uN/VeHDr6mxhrF5uaBAkeAGg/INZtU0I7FOmGdJSjw5qE7JKA3WJdk12plSf2mRYuB++9f/ZL8Q6eEG5R+AfopM9JU6a4NC1J6VqRFHkitmoRG5OD9OaFGV3uJf/GGRyhoSS8C1TZ7uB07yadplqO3UPFxeYMtpUNYyfQLh+eh+a+y8f4BMsoUa6v0vH7BhuOYRIaZvGXbV6iOWgygcXrTczxlAnm94ukvfKNW9DcB2Yfo2U0/dkXc2lboFnQ/Aw9HyPrsJ/gaT0VUyGPQ/T/pWRMaSUzsYyCUg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:54 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 14/15] vfio/container: pass listener_begin/commit callbacks
Date: Wed, 30 Apr 2025 20:40:02 +0100
Message-ID: <20250430194003.2793823-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b889e8-fdf2-47f5-c6de-08dd881eebce
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LuA5N4DziaytLIISn/882Lg2GGH48kTwRvWsNUj0xnEZqlosTdMsNEgZFCm7?=
 =?us-ascii?Q?kPmLVW68vtLS2uj04DNyx8+P6PdwdRCq+DkwvPbM2pNGyLixHGQqdkXmNBh6?=
 =?us-ascii?Q?xGs1e8LQzlERiiG4/j+Gio97b09UK0kBByxeqSLASndxhRsY5easWVABKFg2?=
 =?us-ascii?Q?gdxwTJUfiWwWkwXX0RUr+CkpEi0F5OJTzTdrm1q4CiLGmbYLfmFrHa42t/pJ?=
 =?us-ascii?Q?F2vSvIaHd/1YXC8/dKqKngrbNSmz/9BORyMLiyb2tMXgBxFy+6VU0gA96Dq6?=
 =?us-ascii?Q?OXbMRhb7sYNKjEN5c8jf/oLyKGDxzXkMJmYqgFn2vOfycEmNDWPUktI7CgKc?=
 =?us-ascii?Q?8uWG1Wm48H0WvN0Iu+BAOS7y5SPp4sLwFFk8VHDlFlOwDHyEoH74GO3vO2Qf?=
 =?us-ascii?Q?7uLDZqIyj9bJ78z2YcZs6YtaJ9sryCXo0oI3MKxDi8pDPKEUtzjl2kNv6H9M?=
 =?us-ascii?Q?OYiWq6829RWAaLs13Nz3Km3HmBGiZ+8x8gxqbQ/aiq0p45CX2AzWvqjoNi/M?=
 =?us-ascii?Q?Tnn63cP3+s6S13Oj1e6q5lvYJmEF5PH6rALS9bq9nPvX9S3lxqKO665PoqZL?=
 =?us-ascii?Q?MULJJHTji3KbBOPTvf5ufTl/bvqrIJQ7xshNmo40y5Ik/peflgidYaJDTolh?=
 =?us-ascii?Q?w/bFfRnfowtrIqoQITbsbJTkS0P95DsKPV3xqxPpk4CpSfSmVfwgbncVsT7w?=
 =?us-ascii?Q?vVSGgusryG2uny798BLbaLsClv8j7Ol/Avy7htWwIniqBSvv8qoWPzU+ZhkZ?=
 =?us-ascii?Q?jJ9Z5qMl7N7VHJXJUpLAzXl743OCW56RYjpnCrMQ1xNa3cbZGeT5aUNMMWLi?=
 =?us-ascii?Q?MbaCR6sWUfRGHtaG8Hr6RrgK8c3ZoE6zv+U9mOuz/tUJHG7j2FFroHGppicx?=
 =?us-ascii?Q?v0hI95tJ3WnXG/UjlVIjWQpwRLFQIWO6IrVli/qZop0tQwaBe3BRnNvvtwnH?=
 =?us-ascii?Q?qV/p1gbR3qemQytjmKt6Dk5O8lAdUBFd/OEgi7z5nonerVrk+xanjhW0x7Xm?=
 =?us-ascii?Q?HVFlCRuk43et+IYehfeMZQAVX5OAI2SK4n9S3nBUIhEZmp/e6xqR87WvW/6R?=
 =?us-ascii?Q?rjJD9vAymPds0BL9xN5gD452bPEgM/IM5Q7yNomHgA/U9fnjKZWdbr7LAKjG?=
 =?us-ascii?Q?zu/QY2aoHSz4DBq3/Lqa9r44Ec1U3AKXtBP9EwedSpLXdCtdzTTzB3KXvYJu?=
 =?us-ascii?Q?118sGrj7h51aPz2JholO1h7HOdthr2H94G5gYE/4e06NAYxuW3BrL66z7FSD?=
 =?us-ascii?Q?S+H1Fnieqpf/YGg4dYiuQ2Rx3aWj3x3KtPAZVmlPSWnwB/QW8AtxjBV4Guxo?=
 =?us-ascii?Q?y+Db/WGMzoHp4Do2kYzbXYXiwDXtjdx2xn1Mfn8YxVmYBVeJrwgoXT/GnSW2?=
 =?us-ascii?Q?FQh2Ri7EMOvlDk2l2wsWnT/mUpmHuh24FS9okVpmiN3U7qW/uMl3/ynYIrmv?=
 =?us-ascii?Q?2I9xHOa3Qsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sC/4kRivywDwnARRkrCb9g0NwrVoAqVg3cr+coMcd/zC2ZvxK0SrNV/pkWQD?=
 =?us-ascii?Q?9I4I27YVhYFXoXLD4mdx5dXfRGhDEohnixFSoaVt/muUeLPFjin+i+rakNt9?=
 =?us-ascii?Q?UiTygYySbx614nQwwtsij5trszer0LwBYXYP7svHMia4a8GzXPaLg8fpLC+3?=
 =?us-ascii?Q?GESqGtsUbAwS3Ez0QLiAieCmdqpdWQTyRLK/CEhaRAkJnpB/yGr4JPErJ/5d?=
 =?us-ascii?Q?UhzrEtgypTnogGt61jc2TVLkayjR+rlpXvkOl3gOBgl95AQp1MecyV1PhUIo?=
 =?us-ascii?Q?rRvx9/7BIj416lLYx7E6bptBuE+eDYMuTzIEPJ1JyxdKsKLn1dZhHuDzonIG?=
 =?us-ascii?Q?0L/Eu+wucUni0GpcMqf4Mkw+b3BUjf/9QCpQUbLcFdkbOhiBns99jh33TqgJ?=
 =?us-ascii?Q?6VzXoqYAyQCIdDzObbmxdmS6jHy7Spk0mNZQ0T7W372PZaR2ABWDSjRRdyN6?=
 =?us-ascii?Q?rbWX6CKCE7D4H2PyluH6bew5gVoWwhOCIEF1jeRHrJEXVLkD+8Aqjp2MLUhr?=
 =?us-ascii?Q?1NDjFiQBw7TQQb1msImrXfcqZ8q9i57PZmXou/4sfGVVYS/LGE40XUqT7S+V?=
 =?us-ascii?Q?kbinNSzlH3DaQEni33/H8unM945Am+2cUSkk2U4dzdWabjyb3/TelvVfjvA/?=
 =?us-ascii?Q?yCZne36+DBjGcgWfSO/g63+J75OjCKOfu02HYesk0tTgjo65IQwUuOBl98ux?=
 =?us-ascii?Q?QYfQUMwdXby28NSvCTVRXgdRXWqBEsdNadlKH5jDV8eNtOKaabki8bYxL1O4?=
 =?us-ascii?Q?ihCmGU+/nS4tHfT3JCtbFTh6IujkJHPT4DgqTXuUb6rn/8iW3YzsbYA3hy0I?=
 =?us-ascii?Q?mdSX83UCp6PHyPEiNMK+Dbg7FRlLV1yCKIzGNTD8by+oJYwq9OWuELmtADSa?=
 =?us-ascii?Q?VWGbmDem4sIqAaypHeW/PvTnz9YD65M/nOnFBV0k5EIFAeiWjyR9efI34Vb5?=
 =?us-ascii?Q?YKjVdcb5O1F6HsIF1hRdjGo5BsE06JgsDwPWpfHrrQ9UrJpuYCqBkbVAdmCf?=
 =?us-ascii?Q?J9jH3iPTYZgWQo7ZFptujms/fa2wX1LijmqmVcbwSoJoDqECXGiHuA8BBs7v?=
 =?us-ascii?Q?ocVJTk85lI7jw4DJzC8fzghsWf/X/zTMqKDBOXuPrONnOzZ5D7QogYRuf4tL?=
 =?us-ascii?Q?pvFi0v3jbKWLcwjwWEDUO9GaQj4s2xmEYDIzmIQtKhEEGZUmOhMi7wy1ukEt?=
 =?us-ascii?Q?u444tG+SrUUbQPy4o1lBH9kbifosfsSEc5gyAO0jBZ0fp471qWRVJtb9APMf?=
 =?us-ascii?Q?RGhWDF7pGtwR8OyzEbZ2WS8D9RM/C13gyhNHUEINtbUqABRBP9OxaAPC37fp?=
 =?us-ascii?Q?mM1kF0wJoCG/wtoULx2hdjwc2b1uFHlzfYDNAGR+wCE6toUz1PC5x42vexzf?=
 =?us-ascii?Q?5PgK+1YGJqfSjE95rsoLOE2HwTchli7o/zgtfQ6ui88Kc1qDgVx39pN+ZW/x?=
 =?us-ascii?Q?opRZuH6wN4tVXAzj0vWDA9qBdcIq/xIZznBF63JcPfmUxSMrSYAC3B6x7Y0y?=
 =?us-ascii?Q?DbppJz277y38RTM5flGLEqZnC2c1+Uxf+Hh5YqCato87CjnxZo0I+HNtqEZQ?=
 =?us-ascii?Q?Oc1CX+aPjOust4mQe14S5z9IWjiNNts2gHaJgou3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b889e8-fdf2-47f5-c6de-08dd881eebce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:54.4913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRUXoLYgZbf699HpViAUh/93WNCwpgCMp0KcqVxGYtCtZraOm6PDiDM6B6uwxjDiAL/ilNNztk/uaeF1yWOiKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-GUID: iqUxfRkEysO9qUplcmyMCA5xMkUbmLnL
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68127cc9 cx=c_pps
 a=tJhdH1fDB3NOBSro6qvwmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=vU0vC_IIgwTtBsNJuTcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX3LsCTdLMvZTR
 ZZw72Vr4cLt/qGXx4idwqRbdidwjVUwHa5k0MNJHfEd2ZeCLTxo60bKeQDRZwdw/oclo84XieBS
 QsYpfVso5mbHheD0Jnfpst/PI0Qbe3Wki9toWU8X26JCpOfZbHtmlfXsf30ycFDJOR5NmShfL9V
 8eF0uVXcvosypRr2DojcUMijjUiKdVQnHr6pUTIgKWAN04B9mLFt0iy5RxE6ab69ERxjen8Zqm8
 AbTnQ2bFehiWDdzW/nA7u0yHrUTLtNh5tlmAepP/iqgE4BL4g4cVTt5d7UOpxhzBjrY8iRWjXMz
 TUIroilbUTlTnKEaGgld3WA5SF4OblhehBBGyX9P8NM7wFw+fp2IK0MAPj/MZQXqPt6F/W7g5OA
 YLk5ODzBUn1WkzEIwoUdBGOF1ZVcmndJ1rGDdl5e+vzuSEVA7UP2CnXmp0VYTw3yPnuicLnh
X-Proofpoint-ORIG-GUID: iqUxfRkEysO9qUplcmyMCA5xMkUbmLnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
 include/hw/vfio/vfio-container-base.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2b93ca55b6..bfacb3d8d9 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -411,6 +411,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 {
     /*
@@ -1161,6 +1187,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 92cee54d11..e29f7126c5 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -117,6 +117,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
-- 
2.43.0


