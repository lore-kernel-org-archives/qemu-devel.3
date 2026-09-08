Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F7DC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xHe-00025K-3Z; Tue, 08 Sep 2026 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xHb-00023J-NN; Tue, 08 Sep 2026 10:58:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xHZ-0006Ae-DD; Tue, 08 Sep 2026 10:58:47 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Eh24D3506550; Tue, 8 Sep 2026 07:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=YKhKfIok8BDTaZ6
 CmWcYGbL677/ZuOAQ9n4MDuHzRVA=; b=dbaTWrzMARW5H1tf1+QD3FTHgw45GI2
 nxuaiRWk8jc5A1iCEcmyFuBhT79oWFkITsVyH5pNg4GuYHUIIZGcu2uzuC/jiqJT
 aL8Xsm61ZT0QBx6FetbiyPGryIrDK32wa09Ded4R2pp8fV/JLzMl3gGDgcpvrvPk
 sWhYM0RvXie8ywwUiK4lL+zfOb/4NCGvTuKF5V6pbmR6mj9VBYVs5On4mN8OL6Dw
 pRKlXAzfInG06+Vk8IDLP40odQ+axjuutf1V/IImKHwk3ATtf8kFt6hzJFeYDPL3
 sQK9oHxzqiHCGbmE5Hcy4qypl+d3wa1cWcJlsR6iQqPzsZsriF+WuJQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggjmwwrgr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK+7rnFtOPZbTfPGxEfdmy0sws84a8BxMB+hXdmpgYEImK1SHUfB/oYwlUGZ2C8NfP5jkY2nl4Q1030NFl2TPttgo9VI9ND4Co2Bc17w/5AlB2OJPrFFm8G0K/IgpiMUGDMgoRRFNjE95HZWy1TTH73AwKn5LI2g34M7vpYPhcHa9ekKcCyPbOh1tSSNECAQteavOPejMgRDT+k9Lsm6XEcYTeotFK2sPpDlpW9brcGpcbXKmw7CJWatJ3GQCNT0ypPa/ZToK8QnZ9nWJjMw6g6bY7yQhPQ19IdJd6vUzKx5+O+6k57rqkM73k+FmzBsASt2md7VX/Hn+844HQ/6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKhKfIok8BDTaZ6CmWcYGbL677/ZuOAQ9n4MDuHzRVA=;
 b=xcrLphzPvipYNquvvdt1/E6AhOK+1NRuHDPD8kQ4RKtq8Safv8pMQSz8aHq15VUBHmi9yD+3Peg9ResRvZj6f04WUV8vwdJyxc7YZGQf4mC5r8ALFyPGDK6838kpob54YauxsK7Xs4pqpAlkPWBWV0jtIj19Wq7rOihTpM2yu92aY+fItWo+3EEF2Ppn9IkQB6H54TP7zXzQKrN0jNoUX4zdk132WkVy4vXiUXe1I2Yor3/mRFFaY1CKb964HWKC8+FFX2BPEjDRm8RDZMOEt1eig2I3b+Qp5T4f3vEmm9OmRz4v90NI07fgT7dTwYq/qBKlp0bTQGx7l/PnqTdsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKhKfIok8BDTaZ6CmWcYGbL677/ZuOAQ9n4MDuHzRVA=;
 b=ZSecgk3mAKBxxegKK4sK60XMyUCexRd4q+aptKdstu9g+F8cPPLxnvm6yZ6LTC3VhRhefOU6e2oQcPWgYyO/Us2TB/7o6TTHNve/rJ4+yhpDSYn8T45Q1c+xyj9KG3/1ZfZ9yQmA8zN2d0hlDS3zdZ+xUQoA+Ch+IEwPtGDupF9po/Dsp4H7srNpirbddW7gdny7EKFkGgRYDUnN4ABH2zHwwxY5Fzj2TUZ8BzRbZ2+eOGbf7aN0HpKsBWj1jSiY7uOuqeJEU6FN9HUbHV55RQ4idyhPikYbTx9R4G6HYE6GQQR9iRbDPFgb597toCIerbmIuUhIpwNVtzJed3BTLA==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 IA3PR02MB11200.namprd02.prod.outlook.com (2603:10b6:208:545::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 14:58:32 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:58:32 +0000
Date: Tue, 8 Sep 2026 15:58:27 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 8/8] vfio-user: enable live migration for pci devices
Message-ID: <aqAik23wo2HTX5Q7@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-9-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130833.1437632-9-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::18) To DM4SPRMB0047.namprd02.prod.outlook.com
 (2603:10b6:8:6f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|IA3PR02MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cd5cdc-8c81-47f9-30de-08df0db9a631
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: KI6+9MK0aAYhPbYP2eFIusVLvRXeLffb6gpORO6zMB7dnnzrLaQ/e5qjKMrq7wHqE+g5kQMIylhS0B/Bbyuo5t8h6Tpod976sFlKZdS3ivmr1ouX5MSxGizMFFkII20TJN29xlrNgjbN9iUOm6z3bzQxmvxpdoYJUxpQAS7LvMozhwQ8deMn1y/ET+5oIUi+NE16vNyPDnlYMVXI96hLEx+1iWH/N7Hwe0yzAYJlJ7cSZL06q+4rhyM1EWWZczwbZRGZusG51ioW/njlGoCjSFw5CxgGHITd+/ag8X/WUgeF2C1qSJgTgFylP98USI2NU3tlQsiE3HIr34wHcenu9SFBEjRYpdQHDcWz4tklQiZKpQVYkgfcwCxYUt/R0BWuC5lXtnMWLP7pBraFTQHgSp8+9JbQBqQBrJyNr7JE4gVSKb9g6l9fxPG1j6Isxp29vq2Iguxh4WEAh8sd6y/3otUA9g8L7CDA1bpBuLSHffsfeNaRcn7pFogcYw9srPnB+bdIxOS8lcaD2LkldC1K9IombuIB28H33ykeRS22lYSvvIXnLwtyJyXEzY0oHec+w0LqD2FHsCW2rkBx39l2Y24gXp7j8Sg1yosUaQos9Ik2qlrS8qaAUsXkhmBsFTsX8V/XqBcL3xCxZ/Y2HPQ8/t3c7+6oNlwFnKRPfrqS9t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmnsVnXn+ew7KnmuDJkzOIoEbpFOwUYyDqakc4stqu33sOVNc8KTpiUM7rLQ?=
 =?us-ascii?Q?KIPOEofVDk5SuGbQxOgrhgs8WfVMdNr5/xV1s5W6uokL2//+ZWoYlgi+KhGE?=
 =?us-ascii?Q?k55ADX4e7Sfa4ViMToCyw4YPOY0OMP7pyO4p1e7sqcEL2y2395ThHw9jtgki?=
 =?us-ascii?Q?+FZ0KXh12Y8sILyde/TKaR05NeZciw+MD3DUrr50G7noF65wm101CSN+zti8?=
 =?us-ascii?Q?ftLfrUX6CtdTXmzZv9j6Qpcycn1xA8NqioOj3Bbx/qmL7BMICCxZSvSD9z1e?=
 =?us-ascii?Q?BUq5aNe+HBL+aZ/+If8PsFBkxjMcnxuhZqdH4AMESlskbo1/FR/borD7TJ9A?=
 =?us-ascii?Q?HZmJBPmylH/c48E2G8TXZwOejyp0NITtK0IFUO3JOzLq2ukB+m8d698+c3wU?=
 =?us-ascii?Q?pPFYxKutbgsNlCL4cEfFFVlO+Iqx0o93HF5krTjZJ6DCXiFmYol2WxasMKQd?=
 =?us-ascii?Q?eXDR9m7oU2hMNEJ3YzGP1p2o8fCkJypXc3m1ud8+pB0rQ1TgYVLhjALA7j3e?=
 =?us-ascii?Q?Pqmjk8jeikwuA0rJ/rlKHvO9T0gIeIEQch7KZzC+1fcqZ+EraudCciGpxVMy?=
 =?us-ascii?Q?EuaQDz8w1xxILGI55YN1f8nr5+Ofrl78CqWVfFyjpV2xALEvNIPHSNxIZggC?=
 =?us-ascii?Q?KDotwIpeBSwvycmAf5Xm2gjyFZOiyFUkigMqL2aKtgCfrDFCDdc5hNua/xaJ?=
 =?us-ascii?Q?5Vlxx58Gy3TI9l93ZG8uG2/CBm+ZDCGp0zP1P5iu+TANt+XISwFu2rmQY5N8?=
 =?us-ascii?Q?xo8SkwAtABJSVnfsxfYrTLM6Szfl+Or8xUKRJ3FtJ5cT5Hov/KvVuGkyZdf0?=
 =?us-ascii?Q?o542zvox7GMzXYuBCsLsTAGpjSu3VOl+ZZYSyFYRdLf3lynwAvu4sJUkOtcI?=
 =?us-ascii?Q?jg9lC9B5J7ROJGUjp1GL/7pLq3YaFwY7oqVcuol/HJwbdzu7uTFE29KdG05M?=
 =?us-ascii?Q?JmAHGBC83sNtRXWcrGaUgMDiMOJEH5KNOaDmr0ttunyy+RUm8x8wFGOsj/9M?=
 =?us-ascii?Q?cHJtIWXnSzwWMLWuO+/iqMyRnhoIO00w+v9/YBEgROzozZ/X2AInkuWCxHHe?=
 =?us-ascii?Q?+pGmwIAe4YYHU3dnMgl9U8Jw3bMLh8e0LazDf1HYP89xbhna52GZXn2PbfzM?=
 =?us-ascii?Q?wWV+ue36h1vuotyTBcwVcP87nCzspoUAE+ZVx3LEh8k1ZP8NIAjzdqbF42P1?=
 =?us-ascii?Q?Vd9bmuQJJE6lzTV+HBahOnZ7xLNbafUOkZ8uUyya3IdWk3kKMWMt/E/vldmu?=
 =?us-ascii?Q?tXAMdn+XLyIOOhpVzCSDFf9e4t+L4cutyyX1s6RaUrbQnxFwj3xWtkPc7eP0?=
 =?us-ascii?Q?ng3Ol9+iijhTMI2bNRaqkPdiTFVuvU7WpjMCf934jhGTu1wd5gpV8kNmVpGw?=
 =?us-ascii?Q?669pOBJi1wFLPTShdLkU3z6yju0dHCaWYqph910V+6rf7I4ViKCLUgFWNw/X?=
 =?us-ascii?Q?ygkFQWUApIhoKWbIiME0pcFPh8P1BBF4wVnShUTCVNJ0gWq1F8tDCqUw612g?=
 =?us-ascii?Q?MTIO1l8XVHuqcYBnYbt7W5g7Uoews9rkKlSPCQ5URC7s2Ail361U7djEOjZx?=
 =?us-ascii?Q?ve6WES+kHF8dcr2Zfe+3Ttk8Iwu1JiFmlIUPJaQZNRzuaThoR7042HXpg9gb?=
 =?us-ascii?Q?3fUN8KoKhPDSa6DQMeMXbw0iPrDzRq5JkbccINtOpwAuPJb9hO4iHBUcieED?=
 =?us-ascii?Q?D367lMNk/wviXcQLqYAOkU7fUo0iHf9/2c+zt11U7eN5Yv6N3GH4yxrcbMDK?=
 =?us-ascii?Q?nhoi4Vf6kQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 5DCQI+NWlxN7ddBurn3plRkbtrXgLiEiIPjMSaM3VETz0QxYkMimONCLidhcA1i9yYEvOdRMDpMNo9mog2PD/tx0a/2XNuom62t5eD00Y6ICoNIMAqocHT8w03dBqJrRxWR/zMdaraxu9+tl0ePMxry3dB5Wc1tHdrlcwpErAzN/N5l5yIeY09JA7gqTszBw+ZR3CbS0Qssbou11AA70a9WRAIGjVFpI2BqrUaeEf63vN9bDucRkMPSYjsPzGQKS7kv1bhW2zJntrLmqd6Ohk2K8hPwwXis4wr9+19snD+kAogO2uWwXH9EGIemMyvnHO0kO69slN7Rg5L2pO/mRow==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cd5cdc-8c81-47f9-30de-08df0db9a631
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0047.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:58:31.9492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mcY1H4ooaWfkPA3XqfD+PVcpB39PRKtJPmEM6wcH3q1PpQvCbOIGMW3Qg66ve9LWmieUCrbZFOxvBvjeNNBvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11200
X-Authority-Analysis: v=2.4 cv=R4sz39RX c=1 sm=1 tr=0 ts=6aa022a0 cx=c_pps
 a=BYyRvCY9Lsi29fIAjJxbIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=_duCPBY1ZgVaLfPHm_0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfX661yRV1VWdNv
 7ZuBOunXb70A+u9DU89EJKjEOdP0qW6fonVYTbJfEluHLQ7glDaIMRKanANlG2m5L1fHPe3HvCM
 Xm8OUK6NQdiQMkcq0iuict6b+zBJwQZN7p2/9qnJGq3XWbGysu/tnQilIOYNlvSQgo96yYX0urp
 7zcfEGKc4xe3QbjClVpj15pHH0sgvo71u8juMRadz3ezcHBpfXi+R8r4bQ9TciltrK2rmn38JO0
 WH2HrM4uTpJzYLJ3hT1NHRHFBmPv1f95LmwIFjkhmcnOYBcQELUfbNXcDmqS6lLtN7qhKpyu6VC
 2MEYfhX3ALr3o1a9ZV6f4t4Kq1ToXBUY8TbYfExPJE2viKivs2EolQYCDItfve9BQAhDK9ahrNM
 p3EDBsJ59ZA+LEizI2lpWtTTcgvBq2q51CaEhv62Ez8joX/bDTGeU/2A5caYhDXrWQrsDiUOBf+
 xm8bB+AXTr7YxRcoFkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfX7EzaP3EhQDkA
 hatFaK+xdqVJJkRR35CgiYIXqxlGU/5+e8P04Z6y0/FsCxQ/2JpVkLkO2OK0Can683gVkB4wrTJ
 helCdRGdVQ+a85UR5tI7o7odMoyTy8w=
X-Proofpoint-ORIG-GUID: tV5OR8W4X_WeuEmNEvvCD0roHlqEwX1Q
X-Proofpoint-GUID: tV5OR8W4X_WeuEmNEvvCD0roHlqEwX1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 02:08:52PM +0100, Hugo Komatsu wrote:

> Enroll vfio-user PCI devices in QEMU's migration machinery. Export the
> kernel vfio-pci config save/load helpers (vfio_pci_save_config and
> vfio_pci_load_config) and reuse them for vfio-user instead of
> duplicating the logic. Call vfio_migration_realize() from
> vfio_user_pci_realize() so the device registers its save/load handlers.
> 
> Expose the enable-migration on/off/auto property, mirroring kernel
> vfio-pci, so migration can be explicitly opted into. Peer-to-Peer (P2P)
> migration states are not supported by the libvfio-user server, so P2P
> migration support is not included.
> 
> Device state pre-copy is not supported over vfio-user yet. Strip the
> PRE_COPY bit from the advertised migration flags so the generic
> migration code never enters the pre-copy path, forcing a plain
> stop-and-copy migration.
> 
> Co-authored-by: Rafael Castillo <rafael@trfs.me>
> Change-Id: I110499935b883d9436f6335e53bc3783cf530379

Please drop the Change-Id that snuck in.
Otherwise

Reviewed-by: John Levon <john.levon@nutanix.com>

