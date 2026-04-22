Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E22F9EDD9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYAR-0005aH-Fu; Wed, 22 Apr 2026 10:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wFYAO-0005a0-SO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:03:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wFYAK-0000cD-7K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:03:00 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M7XnuF619507; Wed, 22 Apr 2026 07:02:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=M1XIolPqkh3/n
 4MsXzxHzIJOkrMh5Puw+j5B+pz08l8=; b=gnrHODxjAXddgGY+Tt/OwMevG7rhU
 N14oNh/pARA+9OtPd1F1c+hs42ExAecqRA7p/xaUflb6NQmZ/hhzyXSweoa4Rr/z
 mIaOR89HKmcl67zWpssfgbgbRgQ0cHn+fnvcb5JaGGLWXe68fBerRi8WTo5yoW9i
 +kxo2TXlmZV0UMYfwE3VMMAwjHqmjPPGdg0bNC3Goh2USb4DRIeyOlmGEyFWwa44
 AJ5GyQyaHr4J7HBvPggZ/Bc8i4FQA40/9Hxd6Zc1VryRj7ce9pJZksu3IwJUNUhB
 wiWYZVSSY3mMqMfwEMJBt1yg9gJoZzaXB/Vo0Io/63YxFK6yDgM3SW6gg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020127.outbound.protection.outlook.com [52.101.56.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dpep8j4u7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 07:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pquBDn714jnu0GAQvyixGo0yP4zpK64HMR7ka9yC0KcJHdyGQNcB1QV3v08fY75xdBxUbQh3STiNfqsXuAepcF9QqximIzRQpQ5gKB4L3rV7kfns5zUfy2Ex2VbOkIYrGDxhee/T5VbnK4nrchejP3LC5qvnNSGCMIXUi+IkKtgzarJC2UA3uR1Z92vRN91VfVIBnJMnM1/McZJ3JiZCbFRoz4bJO0P8bcB0YMtCv+s4mcaMffQFB8CO3hI5ZB4BWtQMGlemMx6T9tlREFfaHyc0Ti0hqaQizf1SGMXP/ef+5BQN438WGZuXgMvEuCH4+7BlRZG7EnaWEgpbFl+uLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1XIolPqkh3/n4MsXzxHzIJOkrMh5Puw+j5B+pz08l8=;
 b=sPcyAQwbhbSbzKp5iz5JQD7R5pTuXhGa2vBoutX9/BZNCvKI1kyQ1kUgeXXverO5nczA/AfsTgFPL5k3M86heQ6KmD+9zaNm09gPogp19TqL2gvw4OLL40dK+wRuET9vUJiV6KsF6wm4bs29f5Ae3hQx+19nBEYs09uXy2VXBvTF9egPUDy7FFe4CLup9WjYuUy8gUfcEJyMEHsRFPTd9eQcVnjh2stxuhKWgOqWudrr3dpErvdRu0j3RmLNOLTae64QS2eMg8u8wHJugw9eI3EkOz9F41i4g0iKWjwTanVHcKQcTZN0GPs64h93J0ZgeiM3szoLpnU1AF4GWDHYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1XIolPqkh3/n4MsXzxHzIJOkrMh5Puw+j5B+pz08l8=;
 b=hx0WD4hshR7/Xwf9hqKG4Cgn0NohwCg5EGAhQz5CRzEoODS9WDGZxjYW8EhO1CFnB9t+f1QO7YMsAHwf068AHsELWBBWWM1c3HBfuYtLIi5MKdlNyERc2PsQsjsp30O25y9OZ6XEjc/ZxeqHwKTRQbGps1qhxYqR2qhYK3aKzx/gRd4XJF78eh5wxbyyStvf4aT3G9g9jkofFIU37C4uYQdeg3iXH0BVcE54s6mo7Knw75ea+yUvub1NphA+YijIZcry8geRURkA9xuNvsBpCNskViCXNvCNZpuB/88wQWYUlrQ47q74caX7QfUkO/EGDg3MSh/ZGEfWsoPSZDuJrg==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by DS7PR02MB9526.namprd02.prod.outlook.com (2603:10b6:8:ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 14:02:49 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 14:02:49 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH] hw/remote: update libvfio-user subproject
Date: Wed, 22 Apr 2026 15:02:44 +0100
Message-ID: <20260422140244.2147400-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::15) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|DS7PR02MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 68efb155-48a1-4caf-d845-08dea077d650
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: J8452z8GyH86keryngxYrDHx7QIZhAdA+pgi+oV/wY8OgIbwBMnW7C8ial5OFQpjEt3Lv96Fmniz2El/DYBYx9NN3PFr/AS9HfRdDdWmE2mvYyKRNquB+Ex08ZF21NqYLvnjigGmkwkry7e3Rq7UMO7n8Gav64XQJSC2HhgfLWINVWZFgYTi2yLNFbzl5L/lL7qM33WQD9utTrtgDwlbOQJvf/vlyk/2OfAIJe22MH1ajOuM9X2NZLhVTUYMDa9gAcxBl4cCAUUkdlCGy6eIQgEtJvpiPIMRe2TJJKj3jN2J+vvFRheHKocsYYgXNlbluZWQW5DEXGFujuyaBqlUPf8uddAsI+qprIt+gMO41j+UTp1clVdp9EKCcmj8UsWXKquI5SSzauc0UO0Tm+MZB+yqkvxBa4cls3F+/te8XL8UFHlOiiuyJBaRWQ0eqOdKrw61Y1PfaOl2RELe3bxOd5yT8PZuuz0IsVJydiz3ypCSU4B8hoD+qR/o1F3SOHCEgCDflm685zvPw9iOYjnWpR3ZS1T/KzQq2TYrmbX++PzlZcV9nUQCE+Wl/0Q25c+kO+mz/ZflYdLaGZTNPVpTWbgglq5Zi455TLs6UU3Ufdqj9HLYiEO+buQ7I4h1tkxoj15vQP0MJvn/hucoUoq/bxe0i+zFuE90/26F/ttFcuQ1UJm8IJlPcI3edwB+EalsCTbmgRp94qNnR+Kjfo0guR+SfNLDYR9VgJXacpaYr/uCLHwXlW2eyPcn/QYGsrWE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtMFFgzTS86cBk0WgGzsIRWxiijVI8fb/F5Rs+srRh+Lzv/w7fQCjeQuPu9/?=
 =?us-ascii?Q?6gFBpkPOpE/Tp1GVLG1jFkhZ6VgSHu+fv4VYZ5SCW2+WNJQhthOmu2Nc+3em?=
 =?us-ascii?Q?XQeiH8AXTCf2JTmwf+vXij31EGlsxfUSW7LWXc4acgCAeOmCb4RO701u//Ct?=
 =?us-ascii?Q?KRi8tGuxLXidZ7htAs/fc5BwPy08b1Jg+XxVI10W/SJKdxGfYMaHsSaStUeP?=
 =?us-ascii?Q?KqE+tGXkMW0SgqW0TmGTIMaTfIFnbTG0mtbr8PJn8hMA+sj9KEPPIvu0kqsR?=
 =?us-ascii?Q?u5FJegpklycBpyhCkrpd5otAHdMnZQskG6e/J7UsJfXxm6Uf/aHu+9EYvnx9?=
 =?us-ascii?Q?g3RWqZLNSvhoeGXCq4p7v4/zqxU5eq2zgE6gOcPoNz2ws8rhzqu3+mXOFR0Q?=
 =?us-ascii?Q?6B/ZO22VuOEVNDMcfPIx1cebDdc7eZIKYe2uLTVFC+0JwSDzx6JO32Iv10Va?=
 =?us-ascii?Q?ds1ndJYMNkQ0hc9mJ9ekUfjdpDbEAH7UPFAvMtkz12iU0u4SRhcGjaXtobI3?=
 =?us-ascii?Q?dLu6ajHuvAgRQ2DvZZuHjOtbqaPAJVR4N5NxOteys/dist4Uwn5mZUtVY0sR?=
 =?us-ascii?Q?HNGrYcyLoBm3Xmb1DD6z4hn8w84HvuFCHuJLR//iI+3AEMNge1qeGLK6qmrp?=
 =?us-ascii?Q?cOIl4GGftbQMHniKtfRNZIJMQMowN1JFCwECfIA9Jp8ENwyREgKe8QAUfD1+?=
 =?us-ascii?Q?MiBcjmdaHu6HTm42Pt/xHLHcLnmDicI19/hzh9IBnZFKGRj9JMK35yAdGrQp?=
 =?us-ascii?Q?ksZ0Mn+hMqwGZ4XG2U3KARrmPBhfGEfcDpK5j8uiYCpIlwxpzwxDJAPd28Rc?=
 =?us-ascii?Q?56wDheHko4J5re2IR3e+3Pg1pKxwofjHKY4mhaN2clXaS7WQlJCK93SgZ+Dj?=
 =?us-ascii?Q?9jVTfESPCnGYugCDQSuNY0NksW8rts7Ss4XXy+SoCWUK/1/InzxvVCGMSyGt?=
 =?us-ascii?Q?URyi2DiiK9g0082+Aarhq2EA+FLNuIsBS+CoawSbNyTbkUoxXB3+AIhWap/K?=
 =?us-ascii?Q?QZ+8DNeIq0B6GRPRsWmZZNwCVLUo9ui1wj21WLP2jexth0I5JKTJr0w2vWoR?=
 =?us-ascii?Q?9QohInM5tib0G+YcWMjGDQ0NtY5+3+X379lnVHkiZrbWk2pe9DbQ9pcJAjgr?=
 =?us-ascii?Q?KI4xcQ6WKfsJlNqEbZZ4H/7CLQ92AvPfukXRKV6WTRrYqODqKA8dlvgKYsD9?=
 =?us-ascii?Q?7xk3aula5ybAGq0hWuwpS4etiLzkBI0qNPpHUTlZ5R6RzCeE771LrwY+wXk2?=
 =?us-ascii?Q?ZbzLc/Pb9EqdrkEBD7Lz9SVZ4i0jGQ7LC1pEoZ34vCiMGv1OBuabCbu/rrLn?=
 =?us-ascii?Q?/tiHg3eVWjb5jJn5d4jY8xZcJtSCsy2PWHG2DkWF3u/pShLPCWAm6mrNMtGB?=
 =?us-ascii?Q?poS2GQwrAZpjSJlXga4sPyf3vAB5/CzckvGGyWfzKZ9MfAG4wpZkO5ReFK2q?=
 =?us-ascii?Q?71p9SIwYz0Sb+cd3GkjkcUjV6wHyUAO/N4LuH3QFOZDUbCXHUZu5nM2J4/+/?=
 =?us-ascii?Q?eTpPoicGbT6cUCb2hgYVlxBNk5qgCR2UMscIQo4AGpBhXXNVbZ+6P4B5114w?=
 =?us-ascii?Q?CPz8bDwn8WPpqooIdTdS0eL/BJGliLwcTqDs4EU/XGTWEcXGWlwUZ4ScF0Sw?=
 =?us-ascii?Q?mWfjm9RfVX4r7iaDTcxBrJJ0zKmv33NmQydl+QNpl2FggOstSWwgiqQBWVPJ?=
 =?us-ascii?Q?UIcPHRbKHi4uIj79J2vBcw47WFevLumJ4llpw2mOeOEYTzDhv7tSqkh68pQ1?=
 =?us-ascii?Q?Y8PN6ug0uQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: fXJQTJxm76ucsp7Yjwdd6iT+gNzvPmdX7NirzUGhzJOcstz7X77hdqqfY+CkjIy/L+I0h1EwH26GspllwsKFvFgl0M7dbfnstmoBWG4zyzDq6e3+Es9YF6w+WXMNOLa9dnlfM20noLjWw6481jPK7ZkYM4rR0bF5aryi/hGNN0/2ynU/ezqk8PS8KfMpX/+0uC0B2l61ECBrlSwm6NalPRW508MK+0+QZVSiy3esdynv4UuZUBUHMoYhGaiPTVeDm4Q19Jjz6Z1niiAboXc+DHGfNq5KMqdHrdZZg08sFR1tLGG9bQc/LgpmKcfK78GcwB+4tH26MWwHyHzkGIg+3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68efb155-48a1-4caf-d845-08dea077d650
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:02:49.4335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtTCElK98zYkCZYUrwgEBu2ZjckNIKndi7LJBw8/qtXySsElaqP/nWZcF6lm46N8rWRRUWWGZEZ6Fgndxml1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9526
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzNiBTYWx0ZWRfX1BFBrv7Y3njT
 NzcgFTQDxxnenFoQmjAWcGhawmtEksBoFCa0iTjTduS8MV/D3zSBGl8yMdJ94ijMtJKFsd/vqmf
 LX0EC4s7xgylIb7mAOKe7xFev9bz+wQuoUqre2pvcr0E5inYDI09dRqAHVYBHbuB55HI3V1GTxc
 7qt0h9HVxkhUd6KDZG3AnMGs/BBALXf4t/XAoxdrR+DqXW3SBe7Jbc09ujmWSMvBlbOk5YJdVrp
 O7vsmS1Zvovitblx9AiWlN3wRk9TSLfT6AHoBgecleYcx3d9AeJAf5DuXrdDTthQV/58+MW+FJl
 XzSO3DPQVLMYht0Sqq5+WOQUfsnnfHw5eFpsKBnET/S0efaHLowj3BwWe0J2L/V3EJecQNRdt7a
 FthIA1VHCMidd1XoT4+uYVHvvyVyL35hO4VRm9FHDU/TUsGHbgmlgF+W9lqlsBbX86dhiKJd/dO
 /xm3SVAlk2HoP7PF4bA==
X-Authority-Analysis: v=2.4 cv=BpitB4X5 c=1 sm=1 tr=0 ts=69e8d50b cx=c_pps
 a=I+QdrI45u/umTjhn/cS8vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=64Cc0HZtAAAA:8 a=sNKAJx1fRCGMq-V-Fa0A:9
X-Proofpoint-GUID: cbgZYfopE1qEPUGslEzLPaGoZnxX1Znz
X-Proofpoint-ORIG-GUID: cbgZYfopE1qEPUGslEzLPaGoZnxX1Znz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The currently wrapped version of libvfio-user has compilation issues on
newer compilers; bump the library version.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/remote/vfio-user-obj.c     | 3 ++-
 subprojects/libvfio-user.wrap | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 12ecdab6de..3c89e7a741 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -798,7 +798,8 @@ static void vfu_object_init_ctx(VfuObject *o, Error **errp)
         goto fail;
     }
 
-    ret = vfu_setup_device_dma(o->vfu_ctx, &dma_register, &dma_unregister);
+    ret = vfu_setup_device_dma(o->vfu_ctx, LIBVFIO_USER_MAX_DMA_REGIONS,
+                               &dma_register, &dma_unregister);
     if (ret < 0) {
         error_setg(errp, "vfu: Failed to setup DMA handlers for %s",
                    o->device);
diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..11db795f8a 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = 4d9f663450fa80ff375612dbbafe073700e3d3d8
 depth = 1
-- 
2.43.0


