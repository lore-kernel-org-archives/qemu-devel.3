Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44541C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc26-0002PP-Mq; Tue, 15 Jul 2025 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0z-0000ae-Hk; Tue, 15 Jul 2025 05:31:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0w-0005lN-Vh; Tue, 15 Jul 2025 05:31:56 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F6dBWc031489;
 Tue, 15 Jul 2025 02:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=80H1W3iYPqBpb4YH7QeZ6i60SV2SxoS/yAC70lCFi
 oE=; b=X/kOu3cILy9Y7KpPEtNcmA+9F52zL4qRbSKziu8oHGiMyacazH53fsQLs
 EasOE1JWravNk8MbW+4aVXNkEnibCqf7EHbewQLYs38lFpPwuGLRjZ91p4bu+OHz
 k2adjjCYVtE9oA8/uav5avpH501Eu5o2g2zi3CNkAGsEwvy1mt8tGIRMRiOobXf/
 r17ZBMG+S9N5f8VJzufNj6/8x1ToyhLIvPuD+X89HcbMOTQRhpQrt/F44Jusy/HY
 DgVyld2WuAdIfIpfcOtRWpjnovPQ56OsCCQ4Bs4IIuqCEKYbKQb/gcZJgRKyooL2
 wIXoRHoI4500jQ0We5NVAKJzoVCVw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2133.outbound.protection.outlook.com [40.107.237.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1ddw7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ2TJV9qqyrH2XOVdNsWLich4tG9Q1qOfKby2kY8eBcXsbAwuQkF3ZHIiMAFSROpFxQI5IG0LLhti5Hojp519xMfHgCeY7npxR7M3d2pdw9RIfm/p8gr3z1IVc0r0va90nQdkPNEoz+kc9ywrEigylDhgTZLSjAwE+KBDa15jkZOIUXMU99zYyjmm6R0UwVOdRG/PsXG8zKiXPe02tyfNNZjgbS5XUddnhlUzKDCxFASyPJatxNiC/fVNFUI/+i+4fgHqDDJwEA218rS9RhXfetE8j/keToq6+JaZE1GBESQ/NMFdKmH07nxD94zMZelfv2NqW30Uo3j2PYZLC8PVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80H1W3iYPqBpb4YH7QeZ6i60SV2SxoS/yAC70lCFioE=;
 b=wJWC18shG3MmDxVl9p6hjiDzZEAJFqX/xYoJZUuJ3bXW3ieb9QoBzCt97+vXHHSyysVJGD3ly0OsQ2gjsZXj/j3NVqadEUjUb/IsAo7yyejUoQuMgo3RKQaKDJheIiC+VTbTaWvBWqIyV5RiJAR7XsOAdN7c2dIVGWNNcnOWulQ9GJfxCnWp4mZmd7SbUcMixlpCSiBD5L3Kw1FIHGgTFeid0sQkVywpiqtBlCNgXBMm3Jo5V3ujEfUGz9aTfwOWtBhVsCdxYSDG7jVS0X18pdP8Rtr8HgE67gNYuDKFoZAAlq1KH+rvrsskA/7xEqSjqyWEjAGSMH/LD3k9qQ2n8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80H1W3iYPqBpb4YH7QeZ6i60SV2SxoS/yAC70lCFioE=;
 b=rNW2FmGSEaAwYdLy74MHxjxuSpFcBSVaAMXcOPxFw2GvOv9XlEP189MjjwTTfoq7AhY9k/9MRqjbHQ+Bb7x/msqBhcxveYIKhACe8O47fghVx0NyYs8KhXS8dndcW24+rJW8wBhhvmLrdGn4oAXAZ/iGQNlFr9qArph4W70JMLqKaAAq0NFc+9IMcWIlGJ9SQFqm0J2X8GVZs1VyL+OFlRcLLLCdcYP74+1Xg8gqKALSg/Vk8uyNHUqzCH15EGwVK1Kqx1sHwzbcvU1DxuvL09BTFS2cEPS2d1u4KBSCgjCbkpsDuuSWnHyLkLrteVMzWgH9g74oUuhS1bFycI3HrA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 08/22] vfio-user/container.h: update VFIOUserContainer
 declaration
Date: Tue, 15 Jul 2025 10:25:48 +0100
Message-ID: <20250715093110.107317-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3f72a1-f2d3-4ae8-10f0-08ddc38268aa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ub5cjQcPXfnmqeXYyaJ6ns2yGfxFSdJ+hI6SZlrwi/WFDgxHjhcsFJCt6nEY?=
 =?us-ascii?Q?0gGpro8IkGfP8Q1UyYaVckvH42DzAAoZ6KPmAXergMQXyalJe9NvGxgq5Fnp?=
 =?us-ascii?Q?bnNOYOL/QLojmbliB27kzjM4ImpQ4sM164W0MGW2I6RxXOEfjrgTvzQg99Nw?=
 =?us-ascii?Q?gzPOe4mH1t8WFONpdonjcBhc01gmMiyNTK4tBc5DmeDXfNkEFf9kc6ZF2bQo?=
 =?us-ascii?Q?JrJKQsvqn25HSUqe2SweJivOB2NcVhFXbFIw4mP+DADbIsqGmN0JJDQZ3qWS?=
 =?us-ascii?Q?OyhPueWUPQOgs+zVzIVtj9Y6jaWIAuVMs/quiuGcr2bxtsQ6vu5qk+tYm6Py?=
 =?us-ascii?Q?kvdWkC41cc/wjqRqCy+TovqXvDS/yjUybqkoDBki2St71m1OWzigA5w4KkFY?=
 =?us-ascii?Q?dovT/5WFDJu6TBsPNQ7x/XjFVHGOYId/FnVA37rCW6QGMXRdRxbDXzP5RzdN?=
 =?us-ascii?Q?ckGlXnChe9YemoeIAYbxwki8IEDlO/+v8E4vKrOKvNi2aTd54gBuPBm4Xc6s?=
 =?us-ascii?Q?hXxs5BdhDBw2wG05aKWeCwzCJLFB3DAZhD3rWFbE64f9LNz05AU+SAmKIt+H?=
 =?us-ascii?Q?eZyYUE3S707K9fG36+IMcr4KaUtRIM3D8JpOdKDtIhOi92oPPV61YAAdSsfJ?=
 =?us-ascii?Q?OfolU3qWVNbtcGOStHXijdWXjaaCbUlHHMiDtvUpL5mz6KdPrLq6s1LuGGfh?=
 =?us-ascii?Q?GqKJOH83qrvjZusDgW+0BfYnAsq6rqCenyL98ws2/T6pbrs8hOOdZJ6CaH2X?=
 =?us-ascii?Q?S53GoeMG4UcRmrnBjTaenuH8nGoVYydMX1iO9W4LNk3PYvSDJeQlkkYRS0P5?=
 =?us-ascii?Q?M8b37DBDUo2eF6kmWnJnkAJzQIv5rawTH77L/clEbGObUK9ASPuGpT7sOEJ6?=
 =?us-ascii?Q?wS6yd11MmB7lY0RGJ2IRWqyplWA9wPtQ78RE1/l/uMsZuguWlO2OIKEIsXxq?=
 =?us-ascii?Q?O2Aos081yZTKRDE3nQRaAogz7XWYphG8ojJdGj9DbS1/yCNg33mYEMXdWgzk?=
 =?us-ascii?Q?L+2ICdflVU+r/f0Q+aR3EogA5+uZfD5jskV2rOkLNsae78lmPaYecwLxdQ9h?=
 =?us-ascii?Q?eho1XdQvD/feuK26GDhRosQuvESWt8ICwFzegZAS5sMUEN8JvQjmPGgHcn5s?=
 =?us-ascii?Q?ivbexFWU8G5ZNbKM2QkvnOvxEUCU0pJonZptS3h1Tj3Bel4H90620lBHc5jZ?=
 =?us-ascii?Q?NWMmVV+NZiNt2UdeObm5R4y6vplnoNvzIEnITjxozEkFjQsKZiJMSh4c2avL?=
 =?us-ascii?Q?xOnGIoF5d5x4T3K0pm621jLEcnGnIq9jLgIBFess2xd33PUsBG1Ev2HtsI6O?=
 =?us-ascii?Q?5lZDlOFYtM0Uj9TvDVGqvdsj7ojDrSbcgAf/y5d2DwZAJQDCrHLMEss3ilLP?=
 =?us-ascii?Q?lRvLqub0SdPKQbrKcbXtJszXybzG9KynRXZ5asrzFUsWxpLuz8nVYdYRAPgh?=
 =?us-ascii?Q?i0jHar+YEwLD3Yfqs/lGD9UT5cvKxhgkbmgSQSvdt8sIWwD/YOEdWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTd1EO9m2pLEdcVhiYIeUTKISFtu4VJPUTOVeYW/Pasb96WoGl7I6d0iGgFs?=
 =?us-ascii?Q?+yJ6BJ/Nm1iudqVIOPFzlPbX09Bec/8VMcde+uS7+9bj08WnprOC3CZy6zfg?=
 =?us-ascii?Q?JrWrOUWu24OG+Jl5oDQzcT8omm4bEszIJn7qO6YpD1lsgiYGr5flXL57f43D?=
 =?us-ascii?Q?SbnzKrdzM4OpWp6ReqgiRd/xRJkrFOZiWel9t9FNitCLBTpKP+xiXFHrFy8R?=
 =?us-ascii?Q?tFaBocRHjsPd2IGKAqL+n8zeN78QdF+WepG7ucgu/J+R98RfPn3yjA2qfsVD?=
 =?us-ascii?Q?AqNgVwXBTyAUCsj6wu8Q+JYuFGKR8Tf8pBvGN26Wn2QPEtVBo3ykq6Yt1XAW?=
 =?us-ascii?Q?jtr1BddsFZsN6ZOrk9Lxes4Ih0bcuygOsATdxVWoW3sPyFmlYG/EA7mlGpeC?=
 =?us-ascii?Q?R8UVfg5FSfJOUTQhClj4rA/sbIezYuSKigUnmYoS8ireVNuWxLcsU7if4Gcz?=
 =?us-ascii?Q?Lcxh4HUx7MT4gZS6hFCovjE0Pi/8QqIS0gf9OcecoSrWZIqkcfwJ80BZPcWm?=
 =?us-ascii?Q?PfdznouLVnufMLrJmqiC5KDFUEWwxMOFEDpeLMHtNmF8glPdtLjGgUBRvoPi?=
 =?us-ascii?Q?jTfufo1Cgk+Swe8iWx+GVSOqZrMmowhUdFLz8gGLjsHHVX4sStucSOEeG6ah?=
 =?us-ascii?Q?ksONodOSTCZEo/x4+K19k5TKMBjfMF1w7S4MfkyHf5ejZIaCmReUkdETRo15?=
 =?us-ascii?Q?GACwbbvJUvdnsO4AERz6Ap9tG0WmAoQ330qZ91id1wP5AeT7BC8LN0YpZzM7?=
 =?us-ascii?Q?/c6l2jRJcPkBziPPgJbzWvpcXY9eWhAdOjvpVbwpr/HlpBvDGCLXaiZYmg8t?=
 =?us-ascii?Q?esllTD9LEaUdvBhJbFqaBKKDYcdE/YY6058z4m/+KCnNtyO420DSejOYpmvb?=
 =?us-ascii?Q?UYny4vaQKIDYX6EgMVkjRNRhkYRada066wArgQ2rNw91LaaEKDuMcI3S/RVI?=
 =?us-ascii?Q?sueOZqwpi/W7Zmi9vn6CfQ59vIpYAXKcTzwaTpGUHiRNiEJhzsOEbnyDcbiQ?=
 =?us-ascii?Q?jxpe78lD4PvamPdhnJMtY7Nw8txpMWofUqHD46sUq/GY64n17/7i7nMrscRX?=
 =?us-ascii?Q?zbqPGNYXcVUbXdisy5dudbA1yBzoCBm7YU+OebnQi0SdssufkJ8BdSyeWNRa?=
 =?us-ascii?Q?DgQBvUfyzY3benXyQZpEZ7dkUX8dZ8E+XblJyOnAM6EqbgiBl1bInhTwxFQu?=
 =?us-ascii?Q?NNLoFeQmNmSLMHYUse6pWRlRRCVyzbD+DnSimN2VCc7gFn4Wo0RZ+OS8iqXG?=
 =?us-ascii?Q?qap8KtvzgxExi5d2i6FjFshcAlXltq7juopFJu7w5JTazVDFgn63lfSTIX/a?=
 =?us-ascii?Q?MPylQcDADizog6YS37ieNMvqoIIo7XKwpkc8pPKg8P2yiOJdquRADx/AL9p3?=
 =?us-ascii?Q?BjzivMNjohhg2qtY4XkpL5+RTb3BFKvwqMSkyRJhVLZTPXXsvLx9pS3FQ2+f?=
 =?us-ascii?Q?y9Syd7ErW3WcLTHwg0v2gBE+ZcuyjekO5hTTYtMpSosmfeJ0TlyEi0b2vK9X?=
 =?us-ascii?Q?ba0VKXzuxe5x43MtwKh2eSyZPkSSAHDOmFTbru6cFs3lkNUSlf1dC/oReG/J?=
 =?us-ascii?Q?9mxUo0XwIjQCIvoMtAZLTvAjjlrug1bivPfvYRtTDQecLj67+ZtL4mjXjoiq?=
 =?us-ascii?Q?Aa0D96fp7AiEEKJ/y2xpNZhheoQ1/PG7JhCQaJ/1AA6+g+FRugTzPa0xA8Ll?=
 =?us-ascii?Q?1kIc4Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f72a1-f2d3-4ae8-10f0-08ddc38268aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:42.6403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9cr3Pihh9ZWbVv9hQj9qCkSphbNTipMfZ6ba4VZ26U8yevBCxpL0uWe7JlYfPduCqQt5dJHGEYk4e3SNhW6ZmamkK4BNOZzjWsgSgdCk7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: COYsUk9kdszOAxyaOSZX4inN6Al9a_Ra
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=68762000 cx=c_pps
 a=011DB7unr0b2WNMDL9iVZA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mik6JdhO6k0lx57Fba4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX6Awxjemt9wnF
 El4idyH5jOBnlT5hLuyInaIxrY9WzC6cHIX7sw0UoeAgSo6rUq2tW7UzIFD0GsohmnX691qOcXR
 XJ9pbZCxxoAYZgsWXVAPzsaELjErp2X0IeAa6cmQcL3IFd/kPcTlatYneJswIZiEaNzIi7ylV8S
 g2WEbmKiaqbNqUWTAxROkr5lcYvyX7bVci2aZJRJwPqJHPo/BJleEJe19p03cPEf9TvU1n6ire2
 pRsOJRYJww1G6wbJdPmxL5iHWdO0ZEarUAc+NdPX9K/1Z+TFu0QcrKDiZxU6dlFYg5hMNLamphY
 073uGaVTHHMvYVHPHgB3HDKWJBYy/CNg0shDCgL2hEA6oO/3xA20ypmIvCmp+RufvmODoEOMKhu
 G5oY6JLf5ddeHDFPvEpX3NA9b9rWkwLdA0ygMAoxQ7wmI40DR2L8CVksw4tePwQgSFKgl0rh
X-Proofpoint-ORIG-GUID: COYsUk9kdszOAxyaOSZX4inN6Al9a_Ra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Update the VFIOUserContainer declaration so that it is closer to our coding
guidelines: remove the explicit typedef (this is already handled by the
OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/container.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 2bb1fa1343..d5d2275af7 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -13,10 +13,11 @@
 #include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
-typedef struct VFIOUserContainer {
+struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+
     VFIOUserProxy *proxy;
-} VFIOUserContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
 
-- 
2.43.0


