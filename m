Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100A4C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamA-0007aZ-I6; Thu, 15 May 2025 11:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalP-0006BM-Ve
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalK-0006CT-GO
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:51 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8GHea021276;
 Thu, 15 May 2025 08:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6efGDQ5E+PyV2LofmeWE2ZwHjNBUgMcIRbU2OZQdq
 SY=; b=K9g/teqGuOpZgBm7KX/JsWs7DTVXcwD94/4f2uuDUM3VxbpyshC4w/5GP
 yReZERcU+V3gjB4XabDpU++IOmyrCQfCMjwHagdYmC1PtD/rnVLsuSV8gxxH8wCQ
 42k+ikfoyzuTEGKAnCnLiXXAW1eflLlCrpBLsTGr10u58M6KibS887A/Q45DF+F6
 wc248NpFdRbTYqWWSVl5PqjExPgDPliCraDxRLwCSEDv86idHUC80B6wmO/K+wzn
 okoCxAdHdzBq9WSPMy3fSwWkWTmDE2rXcL6DPww3ZKw6KfBnmuc6QYOm/Uc2/esg
 wz63Ryh8ZhP34hIbV3FKowyKJ0NCQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbctngvk-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hkv7fT4QuJVsvA1YjbhBRf8BV2uE/iT+av/WAAj4xEjAhNCOSpzXfuL7I6gQm5AsSbbixtdfvs6mhjoZP482DaYrPIwDQmUQG53UGWyu/khlzgl72WXlN0e8Cye5BVjvbnHCAB7LQX97PuQLs095/xRlSysY97Q9ndLUw4pKxDxhpcfNa6kRvdDTJPe9OhZ5Vqq2h6LMTOoWTdU5qe0X3uZEq5aUVmNegUnDnqicq6GVfGQJfMuyulXk2AV24w1YwbEv1hzkL0h6irbJXwsyntCkU7mRbk9YX6axZAAjmS5twsgDPJJjdTK8aUm8t9AOLcVaweqMEGbgFSQAYmWnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6efGDQ5E+PyV2LofmeWE2ZwHjNBUgMcIRbU2OZQdqSY=;
 b=yT7F8Cs2sMrsjFPbuW+BVumYunC0dfJ8WSrdcH+hbYaoctfO/OnMA6ukyfKZ/JBhSV+YdgGq7sU1c8uJ4mtev9DNmqUl3KYiT3woUZYbxH2lap1OK+fdzlAAVWkbd/XfGHEyo5+VNR/ExnpsE3cZYPOZZ9i7BmhFwj3on73ktH6uaobRI5vFoO6mKVWrhjXP3ZeJnHPf0nvXTAYZuvr/PESWr9z0TPhUUEqwaVPdIXmfJRZRBTKCvTN3LdgcWrjel7j0ADAQOKnJmAKxZPnLF+qk/6kRJf+Isv3W0CmsNn0xU9aAMRDjRkGumF5lypuwWlDopbAprUr5qNa8N/KZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6efGDQ5E+PyV2LofmeWE2ZwHjNBUgMcIRbU2OZQdqSY=;
 b=wf7iaVMrDD+cMwt//WWL5fORHfRtVpVK2378Juv/AG4yb5NlUlZod+RnwYTHV+Mg5BLJfBT8+wDtZXdhrYbkcCnqktMMdmM6/dcMh0QXyN53Kr32hxOHIklf+BBvStIWD47yk7MSjZ081nNlEBY0Jxk5hBjUFPzUrZaN6lKbZ9dswHxqCx+FR0KB1PqeKykmw9uug1v/e/Zu4SGiAzkVqTMJRZVkw7DL88szW4oILZxlr8ADbQiL57Tx2MePIty4frq0AvgbDCNQQku5cjo20F1JW8jnE9Qw5itURACACL1N+hJv6us172rmW34/d625dHKzzP4YwnDbEjr8QGvMBw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:34 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 06/27] vfio: enable per-IRQ MSI-X masking
Date: Thu, 15 May 2025 16:43:51 +0100
Message-ID: <20250515154413.210315-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 757d183d-e433-491a-38c6-08dd93c763d2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gPQv+Q/e5G6baCvrUlMOaHgTh4m38wJJPukPfnj46h+HSc1Ccv8MGyvh8btN?=
 =?us-ascii?Q?E4N2HWZ0S9S/rJcbQKYHaDBh76j7gmJWUrepKpdjdRV1lviyto5NDzCGmA/I?=
 =?us-ascii?Q?Sq3WkXMD80tKyeB41BeU1n7m6g6pNY6TF/jgbKMNDWkBgN16kPD/yFUp7btY?=
 =?us-ascii?Q?oFyRjXMZMDi3WeKtYuTcPirmdtvRV0ZSZkb+oN5tNBbMqXf2ZXtMqnJ6up0A?=
 =?us-ascii?Q?U/tK/Wj7lNoKJLPd9eTjExlxveba7damHUOgVhjVYOHY20XBTLUHWP4FDQCJ?=
 =?us-ascii?Q?GhhwEEruWhgWPzPQu5WW/INokLZnPdNjZ5KMj4xcjMI9c59E1msZUKdpry+L?=
 =?us-ascii?Q?XAnmZX7MroK4dnsl6vl/wy2nSYMhwP83zCLiBPKbhtVNTob+zIUHKIl0fhXf?=
 =?us-ascii?Q?h/ojUEm7DE0dyEMu6bUW9vDE5ocdX8nlhQp9dtmQUacdAsOYM9ogEKk0mAXB?=
 =?us-ascii?Q?/kUqjMw4fQZEjmJ24ovno3Wy45NOfWzwpyHOtPqhwAEcuaeACrKzU6DWewLy?=
 =?us-ascii?Q?AGi952gmrUC3V3IMnm/ERNZuopknX2GporC1ozb8miVfHCAp5S0aiW8qutS2?=
 =?us-ascii?Q?xDh4jJivaNvItKHZ0qIMI51Yc4vo2LgvRBkkSEkni+XgwkbqdIcphxpgdIp/?=
 =?us-ascii?Q?Fvc3ZtucMrGWs6+3Gh3ltmGvJlrjqq/TgRrzCla4WrxZfEZWVFJYzA0gzb7c?=
 =?us-ascii?Q?vY1qijmhQjDE7TECiAMyHei1SpllqprMbb1ti5QzO9l6+PxSdVHonXjzPB8G?=
 =?us-ascii?Q?KBlxrKlzI2zIFgFTPHsp2tH2+/1gpMzCxkLnWH9B3ztJKyyKHR7h98ybyX5f?=
 =?us-ascii?Q?niWhtcviefueniCeqkp7pKxNKZhVO3Z0IBi9vNE0hgz61K+/t+sK/CmvUh/2?=
 =?us-ascii?Q?gf5RLASXEpKUb7LIQZT18P2tQHf8u3FvcH+ua3YaUDFOcVVCQIt4+/cr14aO?=
 =?us-ascii?Q?ESnGv7jcDiwFiel8ciyBRhvKMlF2C+WuGjRJrhF3R+67MqwJZNmG7oV7Awyq?=
 =?us-ascii?Q?MJQ0zmDD0RgN0PwfGcPDJLIYEYymf1tU15VJ3/3WSjRe/YyzPGxAzLGmLceQ?=
 =?us-ascii?Q?IMowM5kg1dWvPfyv9ITAV4a0PmIIRPECcg8drXdlOqrmFc5GxokAfoHqtGeh?=
 =?us-ascii?Q?9n0As5ou8ZhCKs7ANZo8LFMYQuDxfjGMxsLsPN4szloqmisz4CHM6q7+UZII?=
 =?us-ascii?Q?3IejGgFiex5c4DeJcRrtLKnM816DcvLI19vKKJgT0Xt/0RQsk/SGNP7UYoSm?=
 =?us-ascii?Q?hAs48HXJuyitiMbK4qI8xGAJas8EgXGCa8dy5+8L40AIKlkVc5KSuEuIRgzW?=
 =?us-ascii?Q?DXhL3TSqio6nOGsumZhD02fvuJmRqvJBDiu6FTZRHGk91bsbtoT1UHS8uCdT?=
 =?us-ascii?Q?/9t8PjPztnI6lBm/RM8GeXSuHhxnAKXMOaShU/9bZJ0mOL6bpBq0FoBT3MC/?=
 =?us-ascii?Q?dxu8o+q7N9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffCW6gdlGWNTTqaVwvQ1us6aa4BkqmeBg+QZJyIJsdu0HP5/ncaD6RbHnIKB?=
 =?us-ascii?Q?8q6VmIYRU3Z5bw/C6HHdWRxfGORpMHdcWgbVZJ6S75FbDpwmlm/eBWS8rIT8?=
 =?us-ascii?Q?O5WCKfBbAVsGXlhwciUeOXJQ3DytU5eF1qiuLAD8BSkdr7tNou6RXenSPHKl?=
 =?us-ascii?Q?Mqr61P7xiDZ9HVpFoqdSp21OEp0eMVq0AqXizH00p0rHCN3EXC8ZL1yL5esN?=
 =?us-ascii?Q?xN9DasFCMY7efLlmhanzXJn+Z6FYgG8U37swLEgVFxeGeRjEDPyOiw91YsAi?=
 =?us-ascii?Q?RqC2KfRgMenFuC48Zy9duP8etIdV/xD16RQ44RjkonvDhRWBgKC2iYlj1DRQ?=
 =?us-ascii?Q?BsO3yq86rthCdgquoKWd9HmAUaOti90i/WoLJLyvpdeY6Ot4lW7GbVzoaQgF?=
 =?us-ascii?Q?fe+ApKtvqaNYLtKBxqOdcJHoiOjdukjgv8cbQgrBB0dMZRs5A9WMQjzSmXaz?=
 =?us-ascii?Q?Y//gWYZermeao8DIfhH48faDEeRfDRccQ1QS3VUbWzpDymuR1CMHMt6BawuL?=
 =?us-ascii?Q?IWCeyj3rfCfWfxPjdHT2lI+6DgMf1ipBPPI3mWYj1z4S7Ju3086nHcIQdmma?=
 =?us-ascii?Q?NPsbUBwawpL/tj23+i6emuniwdV4M9S6nSBQwUPBXgSQpD46g5G7Hi7iRsYF?=
 =?us-ascii?Q?bYRoz8DMobRYXWQTcIWVBvsigbXLkg3V3nE5hbhnQDYnhrUbLz3+GIhotJEq?=
 =?us-ascii?Q?5437/u7fN6NgWao7fgbeCKamGBLwM72mmD28drqSRa5tR0mKorb5cPQZNRHy?=
 =?us-ascii?Q?oYOST3UJh4G66UVPq33CpMWWP0IkGogODKIoaS5E/6TVGi+/QYWSKHI6w1XQ?=
 =?us-ascii?Q?3iDoEcrXRmpKvjdOmIMaXq5/B7+0k/SFYUEoCp9DtePoptk121s7ELzufc1x?=
 =?us-ascii?Q?raDKYTtGZf38KVBizfgWmBTFzrwGiEe3+dR82+WrmncJ1HtefDTqDJI/ytEk?=
 =?us-ascii?Q?iqmUhBlp/AjaqQeAdPgj/aE5axo6JxL9GSh4S7Rs/aQ9dmfdqqdrvmLHsu2k?=
 =?us-ascii?Q?VORD+KVEFQrY7vT2Pe8EYYlwy4ZPyIArHXS2xMUJpZJVGubxdsUZvYcHuyWn?=
 =?us-ascii?Q?VUZn7kDDThdApCpLZvpHmVuLVtJsMqBEVV7ZOqzDWWLmATSJ9aWZxGnOMm1g?=
 =?us-ascii?Q?zOGAJJ5l6AHMY7G/4vL+3TvKk/fveqlCrayq10FJM0vmTHrVtp0UcAEP3FbB?=
 =?us-ascii?Q?qgh241nyXRdDcsKj/VQA1m9aUbwTfBh6Kn3IIeQBCakJJjtjEMVzL1qFrOtw?=
 =?us-ascii?Q?uDLEw3tOwuXp7ZGFNSGI7fckZn5Uj4GLsp3oDPX/RSXkF9V8Whf8owHcwhVN?=
 =?us-ascii?Q?7hT6eRSB86QhdD2UN8095YAcY1aNvJg/Q9Dl/t0DU+4ZF3MJgNPf2PQloPRi?=
 =?us-ascii?Q?F5eOcSe3B+hCPbibeIeGE/LaA3ypw9LzjQ4VU+/bhbDilNPJfmsD9Dwb0e5E?=
 =?us-ascii?Q?Nzv0gZmhDzMKAGWFU/ZksNBcyJ0+dqWlkpFGESQN2lx3tkgoyMgTLZpB1Pj/?=
 =?us-ascii?Q?6RVT5h69TOuZhshPWPXlnuOCpBbG+fJkn1kqvM8UEdwehVyqCXjlKAdFUds/?=
 =?us-ascii?Q?FvfSgBvQRg5aW8tDkF/UDx9sP0EuhuI8Nb3PPivc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757d183d-e433-491a-38c6-08dd93c763d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:34.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyD932tonpt+tBtxqEha2DqK4OCpch6ArDzyP/4kL0xTVW8XSy9qwIvtDeRutNgQBYWZcW6V1BKteUcttBBWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=euLfzppX c=1 sm=1 tr=0 ts=68260be9 cx=c_pps
 a=OVSnam+0waiSP26xbJD4Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=_brLm_9mC3lTafiPIV8A:9
X-Proofpoint-ORIG-GUID: 7HofQFzB9WVQYOzzkk9cE8eBShydGHQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX7ash+sGs7mV/
 B06PNt5ItiE9ncIpTWbJS3tQwRC9u6iXgCpPBgtDoPrQ0sj2Xheqpk3oq1viOebznqABt/+HZeH
 kuX2BhrW51OPIKTC0paZBVLA0agtZaaYCA0DzVW50GUCEaHEJ2bQLY2V63IcRCFyqUCqYv//7mV
 07BP5JR3UhXxKEsgZnAOR8Gskk7Ihc7pDO7yKNFCZGf1tYnxURM4uCZlw2tEcvh7VtMhgV9Z6uN
 rKbmk7cf5k7uen6c8CclR1og8dSONCoy7xv/8irt/XWje+OY2ga+f6cdsQ929y1NUU5eFRK4j2h
 eFIMakhPqchpGFOcOA2X8zv43awpMABsvKna3lOWIOuoTl8X/XKL7OU5yLix6CGX1neqtkFOlKF
 IrncL5aRNX5T4eFLTu86BDhcgw26KcUhT4I4UB0BNK7+pEG6GtNOxSMkGvkA9ge37DheYmJo
X-Proofpoint-GUID: 7HofQFzB9WVQYOzzkk9cE8eBShydGHQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
this in ->can_mask_msix, and use it to individually mask MSI-X
interrupts as needed.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h                 |  1 +
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 26 +++++++++++++++++++
 hw/vfio/pci.c                 | 47 ++++++++++++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb916f..7a03d24805 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -191,6 +191,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8bcb3c19f6..923f9cd116 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -133,7 +133,9 @@ struct VFIODeviceOps {
     (ret < 0 ? strerror(-ret) : "short write")
 
 void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq);
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
 bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
                                    int action, int fd, Error **errp);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7272..d0068086ae 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -85,6 +85,19 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
@@ -98,6 +111,19 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
     vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
+}
+
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
 {
     struct vfio_irq_set irq_set = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9dd0bd4068..3f5b296523 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -535,6 +535,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -549,6 +550,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             error_report("vfio: Error: event_notifier_init failed");
         }
         vector->use = true;
+        new_vec = true;
         msix_vector_use(pdev, nr);
     }
 
@@ -575,6 +577,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -584,6 +587,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
@@ -594,13 +600,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %s",
-                             strerror(-ret));
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_device_irq_disable(&vdev->vbasedev,
+                                        VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
+            } else {
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_device_irq_unmask_single(&vdev->vbasedev,
+                                          VFIO_PCI_MSIX_IRQ_INDEX, nr);
         } else {
             set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
@@ -630,6 +643,13 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_device_irq_mask_single(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                    nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -702,6 +722,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
             error_report("vfio: failed to enable vectors, %s",
                          strerror(-ret));
         }
+    } else if (vdev->can_mask_msix) {
+        /*
+         * If we can use single irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     } else {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
@@ -2842,6 +2869,14 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
+
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-- 
2.43.0


