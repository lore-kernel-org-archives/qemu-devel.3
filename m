Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1478CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Fq7-000596-Qp; Thu, 03 Apr 2025 04:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u0Fq4-00058p-OS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 04:22:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u0Fpy-0003au-KL
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 04:22:16 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532NdaP8003844;
 Thu, 3 Apr 2025 01:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=hT+985PdwnGEm
 C2V+OGIaZ8/wV1F3vQAdAvVu6W3MTs=; b=MPQ+A852ZoQx/ANWfOVoKcNt1c5rp
 RBKME2LmNU4D/ZIB0knDpCxc+Gss2B4JRx1OAOmtltRsBfWdBf4zbUPUaGEcFakC
 PxCFPzCqeFiL10uNjRFhRUAyD2djF8lf4e+ptFK7XC1iQtAGFF5rlzab/v0v7XNy
 UkmPYpDJuG/zeJIq6YxnPPYn/+TsIphjvqwfyYhO0/CJKvqyIExGXZTvbTqMkWr1
 OTKHVhebgnymUd/1OTmi9Nqq/jfo1wPy/r+h6qL7/5BPzTuE2Pfq6V/YbGPJhfwI
 OUp6I1sLg7iWgqcteyIjuxnhBJT+gaIv/yW45Butn19rk/1K88tK4Zuqg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011028.outbound.protection.outlook.com
 [40.93.14.28])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45pcs92knc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 01:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZY00B0zIV2fmH3MPQRMIYhQqiuZZUi49U3MH4sLe/yS/2G692Ylw5mgM0H3CU2Q/1u05NviOodqn4aToB7vJlB14LElqM8Nd6RBhIkxxQJnHxeYV3s/DR3WcwYRuk+SqGwGcJMb5ebD/lMBb6LKyIM1JaKc/wfqgpn8K5ZCvPW6OaynJb4mTzJERWRYMhjoZ8Jenr6bEY9dBGYyaFNLciHJwpv/pw8WUQhc5S5Tz5UnK41xUuwuSbXlzENlMMShY1WSmRyFyV+gzEtLmxhdXNaVeySsafNv1+scJ0663+lOexM41qG0T03L5VXMyFebePQslvrPd6oqgagicYD9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT+985PdwnGEmC2V+OGIaZ8/wV1F3vQAdAvVu6W3MTs=;
 b=d4Z/D26b3TNUitgXX4peHaH6VkW0Zuj8Zj5Vri8xaMWbEJCGzu/74JjmMCEXFBNFr5IeTgFT0V/7kg5i8iccrNAob6kCPe+JEBWT4x/N4hW7p/FpZj54kAH1iAQkTu0cRwVDN5RPgeHsdk8n6/enC9nWab7trf6tHNwK1+0mS3F6HhP8TXXVkW1r6gyj5Jl48WXUJlamC825t8qk80CRVe/I8L16zbhOfJMW+FcA+ffF7QVdCB0OJQIaeyktpFLxPCLEEg2DhaJdxvgkhDnhxlfYz/ewPAGnOGH7Ik3905x21TbpTORZnoEQYvV2MexOkRIn3DjRWjThtnPR48l+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT+985PdwnGEmC2V+OGIaZ8/wV1F3vQAdAvVu6W3MTs=;
 b=I6U0ciJpVC/1tBD7D5rCQ5kNWNPaHL3PvpQkp2ziBSlvhNlf7dF3jLU5aTdwww7mlzZZruT2q9LguxeVR1RJ54AbFCnyMHuL2RFoRt/j7VkZWLMTeaUQ5fTyZm7NYVrYvfEL2v2gnNWu/UDFY/59FWzwgTfkDyuXfEPYe2ZzKNHKWlrKbqLWccfPfcQRuwDDOWnKz2nCeXUc7E8Zgx2xMGfOLya4IvqP9Rd3cxpcgz8LATBnOnUs7U7AQw/QNAPQd9bmqkVZva1/2rIScuBWDLdFHWbF+oInTzNC3x9VIaCboVF3lO0Vbs4dPQLGA3wY6KukiMurwuR8IxrQSbqCLQ==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB6955.namprd02.prod.outlook.com (2603:10b6:5:259::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 08:22:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%7]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 08:22:03 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, Manish Mishra <manish.mishra@nutanix.com>
Subject: [PATCH v4] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Date: Thu,  3 Apr 2025 04:21:21 -0400
Message-ID: <20250403082121.366851-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:510:23c::6) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|DM6PR02MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ffea25-8135-4b9c-037e-08dd72889d1d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DN6yeKCRHu7KGhKVZpZHLUtOJHmnPO4d3O67/c/EnRM8YnmStcAWtTMdr3Se?=
 =?us-ascii?Q?lg3RRePpKIyXsP3o5AoYtzy/2u1wvH5ubBtmH9aO5EC0SAZeM0RwFFjg3S6f?=
 =?us-ascii?Q?vxaGWNr7MgtpDS60mIw5qsUdfVy0eUEjwyQ/aGk2ERLwiRvnke8nWuHgGWDv?=
 =?us-ascii?Q?v/VrHJkdJx2/irPxhf6V0W2a59rAErELZyFFNC7zWfXmzHQi21oXY1SXU0iP?=
 =?us-ascii?Q?E7CSDvVCXrEWcXzH0+IyAP4RYUq3/zWnHv0KvOWYNGTE8RtKSqSWvbBhT9A0?=
 =?us-ascii?Q?k9PjUYOfsXrgwwRZSUQ2gtLqT+sTYFt06dsOUWr/biGJgDmSE8gk6h4kFyn3?=
 =?us-ascii?Q?0scy4wmxlT3gUa93B/oDz46FrwdhxV5hr1igIuTlvajgCgWwFtskEilF6Hwt?=
 =?us-ascii?Q?OaPK6lbQJ7XF1yftQAlgP9Mv639diJbfEpvZEa7WebDTEnMvyA3DZcpuwD7E?=
 =?us-ascii?Q?HzZ4UpNKMzGzsXPgtyQbuup79t3Uj64Q9YGLMdmnkSdfq4a1DFQsNp7MmiDo?=
 =?us-ascii?Q?bv+uaQ/XdyAG/M7v3D/j5T2SroyzJ295B9lytNxzuirO/6KtiUkdPucPuL66?=
 =?us-ascii?Q?U3k5wdIsM95mgYOsdiPenJlfh/vrpucovbkHsVhkGfzk8BbiWU5JPDB8XcsR?=
 =?us-ascii?Q?Pe7vw3feDya0v2wBANMEK10owtGbT5qNWbP5DWsJK8j6A6MCv2QY3L2AlUR+?=
 =?us-ascii?Q?sY2ShifOxou8bVKK/zFqztJgIXVHY9hhzDT6wElN8BJ/3fhbYfiLvscE7gnl?=
 =?us-ascii?Q?jk9Ebq31RIi3EhxAbrPHXyCVqqhraM2J8huK5sJWAfALsd5ubC0GpoJwPODv?=
 =?us-ascii?Q?D/RD4BMdWV700so2PHlNAUi7TyB5Fcts5J9K1aKWj1BLA9xRq4vxH9wlscui?=
 =?us-ascii?Q?JHqYMT4yO+931ljos2f/dWT4bixB9v1ffT01YWTwCu5+utz2qzgRE1lCFVoS?=
 =?us-ascii?Q?OR/2KXtfPCDWp9cEqC0PtbHyAz8ZGb2muBEIUFo8gxUOqmDff652wbdqGxHq?=
 =?us-ascii?Q?oNVPSVDaoaPA93o06yW26ffr4SSvyVVQD9MNQPyjcd8kSWzxSqZwmyNTyhna?=
 =?us-ascii?Q?sw7VWt2Hlg5qm9pDySIkfs+XAaSGkDgb0A8TjISspXeC+1Mbt1OrvBJ2FoLT?=
 =?us-ascii?Q?6KTFxLWUY6sXAK4yP5DjdVEpVKnyCdkQdiDeVrvn2Zo9i8nkp6YjZVNYmAqd?=
 =?us-ascii?Q?LIsfpV14ajpXvJYXJLj2uOK+qtwVSFKckSuH9ZOjHbFy210G3URih3aLjWlU?=
 =?us-ascii?Q?DtnyHTPze9ONJ93sn7PZ+1aKyv+2i0ZzpEYE95WYwtssCnCQWpvC6iyy8Vbw?=
 =?us-ascii?Q?6oyzkPrxuVCV0EE6jglGcBvklgNGywsoJXAi+jezIe0rI17teyGU+LRmsL/9?=
 =?us-ascii?Q?jpQc51dbzER3LaFjX45J0wE+Li0cXaC0905MjJXkFev0QElsbuDRpdRoDLT8?=
 =?us-ascii?Q?CvON22tD/wBvDqnrOevYNkKAKXLXDDuf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKOetMY28TucJNEVa+alPwGIC7qfjtHVc+v9l8llERhESPo4km2dcOlc5RLb?=
 =?us-ascii?Q?DR04MaBgXM026baxYTRmO8iZXyxeFXk/vGPaayTkVzatPTIf7xSopUlFmKST?=
 =?us-ascii?Q?IU1qaGNx91f4YCZIcJQjI81s1WRD+GGekVH1XCmZf0ls+GjpFJDhVuzcIZsA?=
 =?us-ascii?Q?7wn/cuVXlBhce3u5hI4ELN14NFntHMskCBnfPCXItbG0i0Kz0ABriV9DoxeL?=
 =?us-ascii?Q?SA2j+7+HmR7gc/Z/eW/WYTFsTBLGNSuyTK0T5O9VfHc1AcXZRVBNlqs4Aeoe?=
 =?us-ascii?Q?tV8z9Fxx7QN1XE/glm2wTAdSyAfNpwhhx9vMBhgH7WOzC/IHFn9CQACMJlSW?=
 =?us-ascii?Q?hG0EMquaVh9Xzb3Xk9RM/xNzlORGXcxPWHwzefXHoM5CmV+xTojR31kA5LPZ?=
 =?us-ascii?Q?zIOWXoSgipz/7WU2G03qTO/EKUFcEhoEoPxGsdjYFL4nlBmPstRSg09z+yYh?=
 =?us-ascii?Q?pJSexUk3IWr9/9CX4uggGIj1E2msrMiEqbzIn7sAIIbWHCr6QFtKZACziCUW?=
 =?us-ascii?Q?4J51oBlZ5LSTrtNtoxo1zY9Yq2R65F2OzS3g8PppJe6vyq799r7q30C4ec8s?=
 =?us-ascii?Q?nKXzlM8pOcDfQFZbR7u8bE0J0y+ivaLfkX3FbovY4kAMj5BZcKceP1q+ladK?=
 =?us-ascii?Q?nycLeHhJZiub+nktrJOvP5/GXy9irvGAZSz0O9mM1X3UPwF8rbxWQhNl5F7G?=
 =?us-ascii?Q?0BsfXEdvq5Dmji4p0pPRpna+d7CiHpq4fo6QsOELDZ0wrJ/kuCv5Uv9/oEzu?=
 =?us-ascii?Q?M5VnIlKULBdjn9yIE5CUoi/5J+2tAJXdxvG9U31dFA7jE+O83LaUfrzSEXtK?=
 =?us-ascii?Q?rYba9W2GIp46E5P0/EsbsyKShP2mscF9PuDgxieWS925z7YL9aS2PvztlLVB?=
 =?us-ascii?Q?QVo7kbLa035HiITU5HWacJT66BHDlLBoezLSyYOD8adYCWGsyLSeB7J0kjyG?=
 =?us-ascii?Q?SMEMHUq+W2UjXMQg16jrN000LZBDGSDZOW6PohIhBM+t9jDmutqJ/a2/VM8D?=
 =?us-ascii?Q?1674u20vdsKx1/1uO+a0CNtJs9Tani/4RHtpLwnkoOPe+D1chc+BAtRrz3VP?=
 =?us-ascii?Q?xCq7ucp/KZk1yRMwOKwtbQ6ED8AtaDDUSFyTu07yul6hXIjvslsJMqY8EBkG?=
 =?us-ascii?Q?WJblMp7kAYW4LBoGjvf95d20h3msxxVfZPGiBZArc+U23523SXPFEES2FFY4?=
 =?us-ascii?Q?zBRO04liROC+6i8DXmsiOEgmaZpaCH4SSw3Jr62i90zCcY3doM5BJ3BP0jAQ?=
 =?us-ascii?Q?cj3rvd4BeMm7d1+HdLqV2CvKy1xQNXv4uT8zfmFZRNBUxK1lQY6gJ7C07EFH?=
 =?us-ascii?Q?6y50k/6+B36oO3dE/cbBSMWOEQ9p7BV2S24Q+PQfnNk2TWGHAj6mQ2hUNp85?=
 =?us-ascii?Q?mBjiu07YxBUACQEo8CLjRvsFvbCAVvdCUJwpTDvS0oH5h0h+L00WsbnQu4Dk?=
 =?us-ascii?Q?wOnXJmVvpNllujk09HegGXL2q5EkHb11dUd0jIPszC+/0k/aPWwlcMLCor4o?=
 =?us-ascii?Q?FX35MAyVl9OZq13sabHwRRqqRSbegpjI4F5tsxXDvLXozDovQdyJNo8gxFl+?=
 =?us-ascii?Q?ktQVQJLfTbEmxAQqR3jdbcFaV2v4aaBHY6dMBrz9iSlkmBxc6j1MT/5hwybr?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ffea25-8135-4b9c-037e-08dd72889d1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 08:22:03.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwWB4fzi0738w3gWdAjkGGoJ4vTEXYjdfOxrcPsUmip9/RYePpcMGhsXw1hpmyfCCROjnOrJEla20TJ8NoCBPH4UgXKUu/GrwayN0DXT0Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6955
X-Proofpoint-GUID: Ke0XENe1G_s8p-7ATgCBRfq-B9F_Wwd7
X-Proofpoint-ORIG-GUID: Ke0XENe1G_s8p-7ATgCBRfq-B9F_Wwd7
X-Authority-Analysis: v=2.4 cv=PMMP+eqC c=1 sm=1 tr=0 ts=67ee452e cx=c_pps
 a=66DTVSBgrty8H6TIf8Oo3Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=TAqZmyZUDpkzjPXLcQcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

We allocate extra metadata SKBs in case of a zerocopy send. This metadata
memory is accounted for in the OPTMEM limit. If there is any error while
sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
queued in the socket error queue. This error queue is freed when userspace
reads it.

Usually, if there are continuous failures, we merge the metadata into a single
SKB and free another one. As a result, it never exceeds the OPTMEM limit.
However, if there is any out-of-order processing or intermittent zerocopy
failures, this error chain can grow significantly, exhausting the OPTMEM limit.
As a result, all new sendmsg requests fail to allocate any new SKB, leading to
an ENOBUF error. Depending on the amount of data queued before the flush
(i.e., large live migration iterations), even large OPTMEM limits are prone to
failure.

To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
we flush the error queue and retry once more.

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
---
 include/io/channel-socket.h |  5 +++
 io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 14 deletions(-)

V2:
  1. Removed the dirty_sync_missed_zero_copy migration stat.
  2. Made the call to qio_channel_socket_flush_internal() from
     qio_channel_socket_writev() non-blocking.

V3:
  1. Add the dirty_sync_missed_zero_copy migration stat again.

V4:
  1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d38..2c48b972e8 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,11 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    /**
+     * This flag indicates whether any new data was successfully sent with
+     * zerocopy since the last qio_channel_socket_flush() call.
+     */
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..d5882c16fe 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,12 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -65,6 +71,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool zerocopy_flushed_once = FALSE;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+                /**
+                 * Socket error queueing may exhaust the OPTMEM limit. Try
+                 * flushing the error queue once.
+                 */
+                if (!zerocopy_flushed_once) {
+                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
+                    if (ret < 0) {
+                        error_setg_errno(errp, errno,
+                                         "Zerocopy flush failed");
+                        return -1;
+                    }
+                    zerocopy_flushed_once = TRUE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     "Process can't lock enough memory for "
+                                     "using MSG_ZEROCOPY");
+                    return -1;
+                }
             }
             break;
         }
@@ -725,8 +749,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -734,7 +759,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     struct cmsghdr *cm;
     char control[CMSG_SPACE(sizeof(*serr))];
     int received;
-    int ret;
 
     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
         return 0;
@@ -744,16 +768,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     msg.msg_controllen = sizeof(control);
     memset(control, 0, sizeof(control));
 
-    ret = 1;
-
     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
         if (received < 0) {
             switch (errno) {
             case EAGAIN:
-                /* Nothing on errqueue, wait until something is available */
-                qio_channel_wait(ioc, G_IO_ERR);
-                continue;
+                if (block) {
+                    /* Nothing on errqueue, wait until something is
+                     * available.
+                     */
+                    qio_channel_wait(ioc, G_IO_ERR);
+                    continue;
+                }
+                return 0;
             case EINTR:
                 continue;
             default:
@@ -791,13 +818,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc->new_zero_copy_sent_success = TRUE;
         }
     }
 
-    return ret;
+    return 0;
+}
+
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sioc->new_zero_copy_sent_success) {
+        sioc->new_zero_copy_sent_success = FALSE;
+        return 0;
+    }
+
+    return 1;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
-- 
2.43.0


