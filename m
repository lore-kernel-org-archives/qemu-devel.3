Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12739C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8Z-0001B0-J1; Fri, 04 Jul 2025 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8G-0000vu-Om
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8E-0004pT-It
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564AfNXO010658;
 Fri, 4 Jul 2025 07:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=18vanALuMVLigKxx01ISdiOkUhjNHnr8DZe/lZxFq
 3Q=; b=0SQxqaEXNbdqmKNTbbiFXpegG2fZI+sbcwhIt/XUuR7Vgcy24SRbA2/7e
 arK1QR1geLZlLMGRlgkDqW3W5lzcBZNe6AGNTJX79/0akHbHmgvtXGDUuBvcV2aQ
 wOKHQTYTnF9cbfcNdLXKjk81Ba8iEHLkdPinRLb6y4fU4+XVdi5ZI93nGIKprxPp
 PDQL1hBakCLcP4rEtrWPI5xXw4ZyLz35wN/ZlAZ/qjm4zV1hZodFgetItShjSCcf
 42iRDDqfS9lwcIc2wsbTlJ3NTtU5m6EnL3Ls/NzQaHV4bcEBsVqm1NBFokwkFhzM
 3xUblOsK3ACtHnwQfpnZis0Xlt2Bw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020073.outbound.protection.outlook.com [52.101.85.73])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47nqmnuess-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m219v3YflHudM8UGX7nIGFWnJ8r7R40c8l9wVSJz1XCd0ffAYZaJ5i/+6ZJVVNrmi5YgEEn0tqZONg6jZJuNJ9mJFH2nq5SpU85PdcZ3inN7jsAgMFG3UqbBREzNDsTXT/u4rg2xn2u6ft1+Z3pFlB9/OBbxOF/dhZGA0nmQjU/B4pXxAS/6z+22IGsisLej95lD94t4xv1BkrRlK+9iBUlLvJsn6K4c3HO2Cebz07Db4Ot0PeZLH7w7s4avKBqE0gNsbusyh2vY0gr9a+F62lKqTEDHeFo9PiV06ZVxrqaRChz+IblAMyxk9fm/fe6JMHT9u9bMo/k2pdlnZRd7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18vanALuMVLigKxx01ISdiOkUhjNHnr8DZe/lZxFq3Q=;
 b=TVjISbxpnrQ6ZtWRfWtGSB1KsGq6PGcENxoqpqWosOoRFPhyWWrXj3pvQbLAiIFYDjXCfW+1hkWnU4k63cuNwk18T7belMnH5izwpxwBi/UBEfpZUC06qQvHEx48NfKPihshSNYbpCF/glAh8mKV5o5WRDmftKfJ+MX/iURGsHhLEzNG9EjZW2Aj13KFahdN/Ku4sEDTcOY4wUh88sDNHW6Kz2FEV1FKhaJQCKCcyYv8rBEJxq8R/+ydRmjJlkxsXH9rQ8cycxmfxuj7XUd0xurJ3gc2bNADULAxF9mdAfr1zxdz4z5P9KRy5ZwNLQsErMYKdZNFKKqCnkILMR2u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18vanALuMVLigKxx01ISdiOkUhjNHnr8DZe/lZxFq3Q=;
 b=dQEIh0eaMp5b+Xd44sb1zZCBp+2h3rA+OSl3JmLc0S+aOTzx7x2Kj14P5OS2XcfUokDtv2CdCLM7wJ1AC/C5McXKzaLJi4fp3lhdCL1zVZolxmXFLUXcjgXlPaL5FrXYnye957OOXgxffWl2HjgSg2uR2vTmGcFHgAnmhfl9P9n4ytVwUnmXHu1oPN0jLY6VTmqlGsREYjrIf350vCbyMpwKNUUWgvBGulv9tHA5FHzLc4VmY05EvqCVgeBS/KoZ1wF11s9tLllBhIZluJcDquephnrxPlxnMvu8pFqJKYDfs5ySYpA39272+tqQrYFzwqBN3aPFqwWZS7+4la1p/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:11:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:11:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 13/14] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
Date: Fri,  4 Jul 2025 15:09:40 +0100
Message-ID: <20250704141018.674268-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0057.eurprd03.prod.outlook.com (2603:10a6:208::34)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 55910f74-2aa7-4349-4529-08ddbb049fb9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vCSxiNrQdDNDS1NLq8OaYD9atfoks9a7ydWSwlBztGTuvM7EDQAnFpTK5RVT?=
 =?us-ascii?Q?MUoXB/weeXDV5ZerAfUokKjinGDYYKJ0LrOArR9d09sOXXDcVxcecvzl5D0t?=
 =?us-ascii?Q?sT89LClE5zIxLHI4GehHCTiCpqFaR4NVrtI1w92b4yAG2tF9/8P7UXw62g4G?=
 =?us-ascii?Q?Gd3v1jR/5TnrqqXQUp6xV62dzI12+DipWUMw/hdDyo7Lfl79PNDJdkbeydy3?=
 =?us-ascii?Q?Lo0Q2fZSlMUD0/6IMFtSlK0F9QWjxycPy0HbSgdkOscxzbH6Q3iS7SW6wVZY?=
 =?us-ascii?Q?ca3xZkxSC8DhNPzJT5FHXgQcs5G3UdMpyrCltBrdptY9sr51vPAT9mdBiewY?=
 =?us-ascii?Q?Bkphfh7/xRwRqhJneuA4gIikmeysMCluwks/VGTVXyNbJFLoklDSrHlw4s7H?=
 =?us-ascii?Q?knLAYcuwAlWvxw+33UjQTrfCb++zmzSwl46u/3fJdvIBydZ13IGb4VaFn18d?=
 =?us-ascii?Q?IbwsPlFNDujOHVtZ2DYRP+UgulZB6jcPosDyFAGHceBihvd/Qpzz9cj4jYSb?=
 =?us-ascii?Q?3SSqNQ728wTR2A+KiVzAFg8wgHbaT/Pog9PgO5noRjc2t7McRJ2+jX1c/xBB?=
 =?us-ascii?Q?1w3Q3q0/Kbq8eNUyE76wd9rZYVscK2+660h0szAbqtqrHJFEI2unsZQI5wTS?=
 =?us-ascii?Q?V372Jyunr4aV+SHdfVWWV8P7b9Ykw2ltnHwm4+8UKK/5r5jIqPUDKcmPkSsE?=
 =?us-ascii?Q?Oa1WmAlihGmMJGohvFIrKBkWm1y5p62We/+fWMHRrKM6edkb648LVKWndz7j?=
 =?us-ascii?Q?E4OBC4I80tocZShEMrpjHcBw46/vkTXZzOu00PC8ZYrAjds/D4B7uxjKLW86?=
 =?us-ascii?Q?k/CsNdeFe8DYuc43c+I4qmi7Hlijx+yl9RiWX2jPmmCR3J9UW8ACYlwFB2dp?=
 =?us-ascii?Q?ibIMXKaCXOvn9onyx0WC98l+KURv/G6ceAS4E6hEibiFi8WkTCoo5ikwAxft?=
 =?us-ascii?Q?cMcRPysx54do9jvt5SGkMTOeIxi335OeqAtU6TYcb1gdw7EYZTAG1wFkUPfR?=
 =?us-ascii?Q?BLgC8at1ju//2Op7geYuQsAtwPvM7irPNVTSiet9o7+wvlkGjhQCwhPTO3q6?=
 =?us-ascii?Q?BFpMla9iHNdLmw1O4RDbWNl9SxK9gXZalk0NC0JVRbvrW1acpGLcjT7SWICV?=
 =?us-ascii?Q?D+8sxW2r9Daac6WGJOm7Y3T8AUYm9wp2ZkXKJbr/kxv8oEB3kxwdY5alTYJf?=
 =?us-ascii?Q?DuX9vyE4xbd4qgAACFEZbPf0UMmxoFcJpK3vsQP9J+GEfDaoWYUpqZBf6es4?=
 =?us-ascii?Q?jBFMmvs07J9sFYYq1zarvGHHPrC+gB8f+1bRVBTQyLkAm2cJfGRi/cN+6ily?=
 =?us-ascii?Q?1FxDaX4WtrFxxEjfrV/ID7PrifNiipK+asG7zZ3vuLPcqMGwx2hTzKfeY+e7?=
 =?us-ascii?Q?O/AMFLzoA6heFSOpCkkm6T2oSyxVyACZKTHN66KbB+EzeLEWX0fODPSVArk8?=
 =?us-ascii?Q?j3v5t+w/9ak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jH03L1Ml5YLQ1Hk5VMnJktSYaQqRdFLQ4GN0uKLiwe49zyBaXkI9gzTkQuG8?=
 =?us-ascii?Q?EURb43qMC/kd9xxD1yPvA3Ryd/DfP+wSzAPpNYGH3+tHXTYaqe7PZlDlB2AL?=
 =?us-ascii?Q?iOe7sT1hQvbjLXKiX0bEbhD9mthPj3EGhlz76S97S9+0X91I5sXlEqSYKr8g?=
 =?us-ascii?Q?56S78EUt0ZbfZL2BZgQTfho7Qa8yjLao71Qj5WiSVoy4tkgWz8JeB5wOXeJR?=
 =?us-ascii?Q?+xMaibEixDCyX3ohMrPCxjb4TgknqAm19kEDjXfbZAul4kijbaTH9+8fBGk8?=
 =?us-ascii?Q?oE11ez519nFRd6fD6tX12SF+GSM3x0GKKtPiNRxWlZQx8Xx+SkSyBHjAYbMJ?=
 =?us-ascii?Q?B7K6Id2SWtaXZVfPcVTTR97WPHQ3pS7aj/a4PUSBl+QDfw3uZ9csEv4LVK7k?=
 =?us-ascii?Q?ouHjuMIqonne2NblaF59Nr+JjI4epyQgZZHulYmP5UALpQxuzP/FcjMywgP1?=
 =?us-ascii?Q?MDP00TyVon1busA9nfr9ezjE8sSvs5EZbvhW7bEleIi3wLXTZoRxtCfMq4At?=
 =?us-ascii?Q?6NTRPhUek7rWuEWDcTk3pGtbyljoSPT8D5mYcpwvHqTZ+1kRP3Fqlzp0u0+N?=
 =?us-ascii?Q?ay9BDipNCzUvowOl36i4TBUZjjXMLxwaCub5TluTpCHG8unMpL7p7q0hjj61?=
 =?us-ascii?Q?Rcjk5dZChNVYAkzitgbwm0cklgCiHdUfxD03BTOmu6V1N+9P/WCy0FvqkxeW?=
 =?us-ascii?Q?40qoep4ehKIL6/8WNYXvLttjt1HXA2xdg29iFsZFhvFJdZwxy4a7KRd10XMT?=
 =?us-ascii?Q?v70rvi2YXgPkk9+tpRDXLEuOC/AKpw8deYYqvNrxlC9cIrhrKHCX55m476X+?=
 =?us-ascii?Q?0mdUnvqs8unf0GOyFt+DM0zAAErmOGQY9ss56kQ83PL2huwBBdhWvKHwSq2u?=
 =?us-ascii?Q?sSDJhxMobNrlnYSEW3h57y5beZB8QoWdWuaO1CcQVPHLh2j+RZxrOyXr8RAb?=
 =?us-ascii?Q?0dy2Ior3gQcaNFGGHzG7zrfWFo1t920msPS0DYC/60PJ/EreCYQxYADMVtUP?=
 =?us-ascii?Q?FqycXam1nVhctROj5/NPuzN4YRKvfpZS5bN5k/yBt2ucUjUQ70HADH5FbgeD?=
 =?us-ascii?Q?oj55vfyFlnY6Ya3764G8ZUIsT8QODNUjNnUV2yxb5ywltWQUww+90+aBoo0i?=
 =?us-ascii?Q?/4zzkuNdL+jHTpRCgMkD0wrskRSfTuyTLDRPAvw+2oFjU7o3mGfqJBjSQXlk?=
 =?us-ascii?Q?9Cf23JCURfBjW3UrcOgF+2/oAJ95yjb/QSMvGn28QGbJatHsJUnjC4nRrirT?=
 =?us-ascii?Q?c5sKwysv4VTddttgYMEc59cC1saedph6mw/NCTcPh9PvTyhbFao4t/yCYMzM?=
 =?us-ascii?Q?ayQTHF+YEk35efmhPWOg/P7a7eTfJgrjbRviRszgHXV4G0U7Ywk4Au6GmO5H?=
 =?us-ascii?Q?MCXbP0poDMlavwaglkqOwuFVvVZyQE+KXwgY1vrMqSWgO38PFXM2JjvzxIGW?=
 =?us-ascii?Q?j4NJNU18/2Q7uU0j/ZQVQijR21/sTPCir39l/2uLKNpiH3FnOMixjHGNr+RK?=
 =?us-ascii?Q?+MtqmxqJEZM6CbI17clmQ+mfAMFZiWzfq7p4QhzcW9NXne2Af6hUTMqX6Ppr?=
 =?us-ascii?Q?1x5NVIr/NHxqGdRxT16FCaez/XLneqxKQ2ykW5Qi7zVnm52FdfGPyyd/8eq5?=
 =?us-ascii?Q?xd9N2ksuW639Ly4TrqS2nWMynsEwE3DfkHJFA2WYFzRaXvb4+OMcakJ5EuE7?=
 =?us-ascii?Q?wLY5+Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55910f74-2aa7-4349-4529-08ddbb049fb9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:11:09.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJVyEugfC9UXW1RaonFNjhdeF2RGjfsLM9NIZr1+U0lQMjk8nEtvVy7D7Ks8aZXUtN2guC9EgaGGXvksEPdwo8xkaq0KRWSORkLB6bKBvVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-ORIG-GUID: 9ChSWsawEjYhqp1RYJuzHjvGtrPHjxFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX7bwydgJ4B/yo
 3GYumXlwNEOoabjJrNj8C/Rw/qtdKs+PUC0V4zzgKpbt334DyoktQwj+/+gNcn/DG5dIQyzrTmm
 0Uo/uU8+BwaDTIVn/EJXL4b/kHlcM1PO+zPQUyPugfJxoEYny1ZEgKerOGj4FBFWxQAgSP3ANzS
 pOI6JKbH0fIq0WQpdc1WV3mzcra7e2bn5VjUgSmux8w++RpZ4d9pnzFRKSPk8oHjq52EUKP/QdH
 NDp7Qu9GEMELX4KzqSaItsAd/SERw2mCvfhKBOBmyNvWIFs61jpQf+LhYKviBahhnBOyf8fqXmF
 UPAdKSjDwL2rtknNT+LgWzP5I3K0FkTiuZ2L3oyzuVlPBKO0e2uoPcNEITUm7DX2sO7HBZJamv7
 pRKYiMDeMywl1gbnxeOSfpfiHSEU1cZhyt2IYWKCMT91d0/cWN7gDYwVITjSQCLq873wx0py
X-Proofpoint-GUID: 9ChSWsawEjYhqp1RYJuzHjvGtrPHjxFM
X-Authority-Analysis: v=2.4 cv=aomyCTZV c=1 sm=1 tr=0 ts=6867e0ff cx=c_pps
 a=n24abkD4YvNTwWi8vj4pqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=vpq99WT75Wyq1KrgB2QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 118 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 76b8543bfe..c9d8a1cdf7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,7 +71,7 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
+#ifdef CONFIG_ISAPC
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
@@ -118,6 +118,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -188,38 +191,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
+
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                        xen_enabled() ? xen_pci_slot_get_pirq
+                                    : pc_pci_slot_get_pirq);
+
+    hole64_size = object_property_get_uint(phb,
+                                            PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                            &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -235,72 +236,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                x86_machine_is_acpi_enabled(x86ms),
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                x86_machine_is_smm_enabled(x86ms),
+                                &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+    }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                        XEN_IOAPIC_NUM_PIRQS);
+    }
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                            "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -314,7 +294,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -322,28 +302,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


