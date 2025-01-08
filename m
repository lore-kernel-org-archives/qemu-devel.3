Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F4BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUe4-00071y-Sj; Wed, 08 Jan 2025 06:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUde-0006Va-HN
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:20 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdc-0002Hr-NK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:18 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50881hhn004556;
 Wed, 8 Jan 2025 03:54:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=o/i7DsWvIAYEtFgLbrLXLc3imCcky+m4+aj3c+whM
 Y4=; b=2jW9fIVfqCQ8LAs37Nx0Xf7qNAtp8wdHKon/FkeoynrluGsphpnRmXQYt
 b2pMvEHPnTGFJSqshtXtaKnx25qxC7d5faKvLcZCgWazfgU6cc3IF+T9fmeFrU/n
 mn/J0f24eJf4OgJFNFyt9eDzY0H+zKsaUUMVjN+bdWoV2uA5Q5SwV6AJ8MhVm3rr
 BKhH4l13CkeKwyJGZkNVCgdpXb4qqqsLR95V+eahx02aDF6H2m0yVayKOkCc8rVc
 iFO24nMF5ylT4+FH6ttvK3eHoY7WxkDafMHUh6AYi6wkM/3CeRO3rqpQKRQzjzNc
 vlcBQqNJEZmTHw7N8d9NKtpx2+2kg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y3ynrwf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dm/VxXGAgr9sj6iNr/IwSy+XAxEek8kUPR81sgZSTnW1KDLhszZPGchgxgphyIZigkaIycE+t7ymZhD9T/8r8yMsArIS7kk2HHL8jfuAo+/rhloIq6rGkzkka44ogsUGhlZgFZ5//OueS91+zdsf6U3uEA/h41zMCz++EKbwVn7WZkSqD74gei9H5I2we4TM3cCpX3PrQpDKBUQxwX+BOUnOJOR+dcgIBM5oFe2oTEWeU7sUMQJmHPGAJ8bVxl1WoOyAHyasRglRGa2wHuQyRDC0gF/yvVzpzLcjJm/GJvVUiocqqy202gJTaOgtXKinnozELcW6HARhtcLhYe750w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/i7DsWvIAYEtFgLbrLXLc3imCcky+m4+aj3c+whMY4=;
 b=Ya374fn0IiDsDulsE5BtL5E7ZVuJzZ2h1pYNBr27pbROa4QsHl5TdyLC3mCBvpCwAZJadLChl0wvWynHoj8ZJOF4x8VXuJ8CBeV4KuxOaR7LjTIuSN0LWqtCgAbrX5HyQdXF9VGg+zPvP3+hc+E6yElSlMAdzthTTJ/6RODHHz+OCysKvspSU+wCY5bVxqeLnFLGdi0FY8xPMEJiVw8qJnyRbzpY9cU+p99//5IvjTcwcnVg6LxTIxUzP5cpxtLQVzYAQcihnJTSa/hTUj42Yf/L/XlEVUuX5KMiDre65LUoVwyBSnNqd3kd/Z7Gw/sf/QQquX5ZcsekTs2Iv5SYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/i7DsWvIAYEtFgLbrLXLc3imCcky+m4+aj3c+whMY4=;
 b=pX7+KeQPootKXJ87RFUZkKTg4CD02JKpjlZr8P6Q49Y0bBwUeh/q2Tw1HS8xgvQ/lUN27JFJJ+XaHJaS9V398Nuq/IcdlhkOvuxyU1d4qvuf5QGcwUC7S5yThj+3/MfpZXmJ2lMaaqUE7DUhegC3NLlA6q4wNrAtUclgNeVOOTfld6a6ZaHWFR8+1jQRsp7dS7LUifzSYiJoPWde+NdlWvQ6NaoH13CIOBoQisXEsqt9Gs1jsiw0X3wY2x6+cIe1qUABMBwhJbiaucZ+5Twofo8lU7LOlVSUWPjblI6fWVv9N2bteqqq+fHjAb/xGqnS6l+CTcRK6wxKx1YgXEErMQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:54:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:54:02 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 25/26] vfio-user: add 'x-msg-timeout' option that specifies
 msg wait times
Date: Wed,  8 Jan 2025 11:50:31 +0000
Message-Id: <20250108115032.1677686-26-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 46df385e-4b4c-4267-932d-08dd2fdb2539
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sc+aYP0D+Lm/vR0wkVunLXi7iOrLH9AlQgVSnuCpYLSOnA8lOzHspMZuUWPj?=
 =?us-ascii?Q?FZyeu5m7LB46UK0z4QcOK+ZCz33qbQvI8kCk6hwEzdqel27eIpiuwJBroSDE?=
 =?us-ascii?Q?OCDcZpxhLnLSW/bbmpNIiFDOAm6h+NrK3u2orUh50YjPv5XLQeDLDV6qVCys?=
 =?us-ascii?Q?5grJ6PoMPXdgJrnWs3y1YGyAhkhQ32D6P3nFXClf4STpvCt2sQKmIFAdbzXB?=
 =?us-ascii?Q?x87Ir6QBd+xkVQURaLXzamuExoexJuesA3NLA+EGjojHB64LnjD17quGqjCG?=
 =?us-ascii?Q?ufNf26yK1wxtLqGj1oj95DepMbOKVZMLDTmO/kYjqAV0hWGxxY4hzTYLRrav?=
 =?us-ascii?Q?kSALntpmGWBhFgmdejppJGPaWUYm/6qoCvSBd7t54vF34EQSV4pPllr4vOwJ?=
 =?us-ascii?Q?wFVicuuBSUZ20qZ2VZeds0r/L0VSaY851G21OoXSCncDRwwGkh8Ml15cSQp0?=
 =?us-ascii?Q?5r1nmJhYGT7l1JvipB8mxBSdq9Q5YyT+3BbrS42bfdZolvdSXObRSZc5Hkf9?=
 =?us-ascii?Q?hXRKMjizSbnkwE4STNJrTBCMCSpBB+niVK0OdpBUISmQ10BxKiJl7eEC/WJd?=
 =?us-ascii?Q?Wve7Sb7BtJJ8pUxrz3Qo/DeggsWTRgKUY8dzw4Q+6rOHUNWyuU5QH+3++fjE?=
 =?us-ascii?Q?gslXie0bbVFpKH0XsvhYFnDZ5PGfD/IkVyTBAOJ3/9hn4JdCzp/PWGMo4lz8?=
 =?us-ascii?Q?soDy1GQio4E1Oe1XCdkDtSiOhOzSmwEWVASLiiN5oLz/uS+QZDVMiSa1bePg?=
 =?us-ascii?Q?cjgy3ETRjAyl9rZpqLFST5T8Z321i2OPMXUZdWASKxPzR6d4KQ9GegTc8ycl?=
 =?us-ascii?Q?+x2KMiTBOC1KokCF7U0txE/1Vu046fDwBHFBkUFOACQd4o2/xCJZhPoCZ9TI?=
 =?us-ascii?Q?rc9n0FtVVGQYOEo7sqtIsMk9TpKjd8cSTHT45LqnK/1SyOdz75mP09//ypgA?=
 =?us-ascii?Q?2VbbQ3BU0PZKgoyCSPynCN3s6gnN806wE6FzxQLDCjaYxXkWIaE0+tE+NYUn?=
 =?us-ascii?Q?pNFEj568k4nh3MQHVgk2yvxG2Lq6kyg00n5mPSNodbu1hN4ccnosEXzHpf32?=
 =?us-ascii?Q?kUVrcYs8nClvk+z4g0C21bHtU6NR+OHBtagLf+ruRGK3kGnv/5bDTQ6amvlF?=
 =?us-ascii?Q?dk0ogeM+Yiw0Ah29fxk9yG2gd5as3XYsO9qVNER7XiU8GJDvGGDeLWs/qWCp?=
 =?us-ascii?Q?wHSvvA6IDvLww+o1c9ZM7WB/eZIR/MVeTXC5dw4mLbP8PSAiO1Ws4D/LU+wR?=
 =?us-ascii?Q?612P5XECjxZ9c7HpHJNCXGF2PqN4V0Z9pyCgSmWgVoipDhl7YbzTF3LDrayM?=
 =?us-ascii?Q?2kh2RtMQQ0mcy0mwn1d2kSa2exQVKJVs/CR0LYXF7lDY4V/GeB6jBPkcEJZA?=
 =?us-ascii?Q?tDBds+A8Zk+8+KeHx6ImXjNwaJxB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rt2oXdBneo3mX2yDhULjqXAS1J67xmMRgHYLu8n36laRLsrDabzwCKquAQgK?=
 =?us-ascii?Q?2/95JoMWbiiaLDAw9t/axVzDZ71LpTGMYmuhNpYifTS5a9SpDedNFGT18lWu?=
 =?us-ascii?Q?6Dj0emIwRDk8NoG5u3jNmNb5sAamzIKyQODKz13K3MMj3JcKYGfOx0sTPyNj?=
 =?us-ascii?Q?g4iWDqI9RC0bg2WZvek3CTmDiaxrPNkW1i3nPpUlLzsmz3Ml5WKKO141mV02?=
 =?us-ascii?Q?4UUPogevQD7uxCN9Rg7hVWanzc32LIJSjTniBhygWGGAQAuZL0ZLbP9NbGVA?=
 =?us-ascii?Q?HhkgQ7BmHzk0JMHePQiLo1j8EM99Rqzn7Yw4D/bYGYCn8800l8wxMGFqHHFp?=
 =?us-ascii?Q?SrHva26cGmt5PuOJGYAzEtOy6F90zN5Uxiohuq75EZVuOjOjjVZYcHTsYa4P?=
 =?us-ascii?Q?FOoVbI8nRgJ6DD1dXke9aG1Ljoa6r5eN/5RLmhZALCQDclAYC6pGrMNQE7/y?=
 =?us-ascii?Q?Mw/bo6L56VGTQWGMjl382Q2AisHiwOR1+OBMgZ4tj688qL5nTHafEZxM23YU?=
 =?us-ascii?Q?cuRi3Q9NPlSDFccPvLwC9ybdSZbHKb59BfzGVieD0qtKcp9pZYcoaciD/vMI?=
 =?us-ascii?Q?OJsKKDKfT/bxP50f3ibP7lDMx/LdEqLjrIxeBc+BzXVUlURKfoDqFM9TwkS1?=
 =?us-ascii?Q?778eXtjZz34M7gkr0TZd6kTLKa8zQU1ausdJM4pcxB0b9qLrtR+LdxmauYet?=
 =?us-ascii?Q?4hpVrST8dqm67dq3ZtG8l9hbOzQ+40NSQR7m6RS6oz9JcBvwuO+s2uwa8v8Z?=
 =?us-ascii?Q?mK9Md7eXB13i0GpiHktwhkMK9g3MVFa+0miwH1y3kImZG2zY7I0X47uv9Xgd?=
 =?us-ascii?Q?+sy6PcA3UtYpidemp/ye7DxW9gcKMmW5TIFSR2GPt7zcwmAbyepHmryj5nmk?=
 =?us-ascii?Q?n66TkYOzoGs26btseKhB6rfnNslizNR9PvfmbMqhGVZR003Os+FJH1oD/Nm/?=
 =?us-ascii?Q?+iCvd7XgoaI7wEDSKZC+76n/N2yK4+kM0n18EkZwEihSd/joVyIFRDB03DWS?=
 =?us-ascii?Q?0xCjXMkYVQ37N/vmVAzxOvenT5YCQLvpU5pRJvnUx8GgExxL3+bIEYncJdQF?=
 =?us-ascii?Q?YjbxO6WLy7RoIkcZJhDod6bIgjb8zNxogZFbbidife8o+VZu7qlzXAuHG+99?=
 =?us-ascii?Q?l164Kr0ESNxp3ALX/BOOqLoCl0f7gcjMEnQVw3jPkUWKH110gni8ZLTOkR2/?=
 =?us-ascii?Q?mVv7rlpFDln0SqalwiXObtqkQ9zB1TsTCIRfYHkJ3nfmM36TmQcg8BIDpW/s?=
 =?us-ascii?Q?T/T5NmGsGqlBiG03kb1LZIb2NFaadLT/1DDFbYWvww7j9GlkBEPpE//dkOR8?=
 =?us-ascii?Q?qFiIcGoMEe+1YEZ49OBEY5OatiK8wNJW2gXuae/mQRTnX60OOb5yLKRhV45b?=
 =?us-ascii?Q?Plhn8WpZUNMJmPhEgVZriHR/bA9rb+c8/F48BkCiis05jfBUMw1LzpKF/Gbt?=
 =?us-ascii?Q?gfgLFnm8JnRaCLp6voJ9F5cjK0U11aojFiD83XoTCleKGPuTiK6kai+QyOFs?=
 =?us-ascii?Q?t7wNTALRKPrrEDBjNkSAJvomOeqr0i/bDvARXCwqNWAR4N3i6vm6S6TSBBYG?=
 =?us-ascii?Q?a1pdoDFhGwYPs3RKn2ax1KwlJueEz8DfJ1WSiDCn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df385e-4b4c-4267-932d-08dd2fdb2539
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:54:02.6712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL/+mqs9zmUBUGCCSGKFPCRkDtIjD+HrsydVyV5TXJIZD4vjEHrR5r6IyB52j2bTKUD/6qQHTQZBLRU8uIE8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Proofpoint-GUID: Xk8F7NEkD0jgc9o8kwz6tuIBi9II7muX
X-Authority-Analysis: v=2.4 cv=CrlFcm4D c=1 sm=1 tr=0 ts=677e675d cx=c_pps
 a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=efhkqSP4pV1qFdCZ4JsA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: Xk8F7NEkD0jgc9o8kwz6tuIBi9II7muX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-pci.c | 4 ++++
 hw/vfio/user.c     | 7 ++++---
 hw/vfio/user.h     | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 84802556e9..148e451dbf 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -42,6 +42,7 @@ struct VFIOUserPCIDevice {
     bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -277,6 +278,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (udev->no_post) {
         proxy->flags |= VFIO_PROXY_NO_POST;
     }
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
 
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
@@ -412,6 +415,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 9fba36e196..217d0e9ea4 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -40,7 +40,6 @@
 #define VFIO_USER_MAX_REGIONS   100
 #define VFIO_USER_MAX_IRQS      50
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -710,7 +709,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -743,7 +743,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index d9aa1759df..ff2aa005eb 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
-- 
2.34.1


