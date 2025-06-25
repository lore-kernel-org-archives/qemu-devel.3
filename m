Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97739C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpm-00085C-LD; Wed, 25 Jun 2025 15:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpb-000827-Gz
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpX-0003nS-DF
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEo27c001328;
 Wed, 25 Jun 2025 12:30:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T9B3Y3U/nH5NPvxifW0ZsA8iX403dZXpoBuCN9ptO
 bk=; b=Rm9MAbpdeMR6qc2sdzYg4J9hWk+t7+9Kn08jTbK7HU0+XlIqNXY+DfGTm
 9NoZ1hyUS+5Tc+dr01K2nI/LwtHnUvw5u4AABIxaXm5qgsuDEX1LXWW4x3pTCqOm
 JqekS9s3sajhF84bs//9C2jFMTBbyxNfV+MpGjtMSU2Uwex71ye7ZTTmhMQoMqZf
 mO95HZbaODQ8TKvwj7EN/q89vy0K1gXC5D/HP5PJ/YtjglalH2Ts11GRj4b0vkbt
 CbAsRrCo/Bs33hd9/lW7sbI5hKwqkrQfoY/+dn43pgYdhJbJUVHxt6lydo6OqRwK
 E9bptVFbqtcb/JT/Ih+CSdV+FIjSA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2117.outbound.protection.outlook.com [40.107.100.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47duth1k7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3IHtTPo/jr8D86WsJsaEBzmaGqhtbe/9LM9hY4d329Ri1T4bCMudsWcI9o9ru1Mu7vyLik8CMu88iq+5oMDEaskqVY+H8kfwObwgf9mnLPhssxP97ZQc9zlbgpbKZaMGB//EDThmqCmMFU24N+pxZ0ZJWLjR1Ismab1FNL450EZmnoYtoYVN8HrCHz+BFmrTgA6rvR++gX0jZYLD1c8TO5kEuJlVv6UoMPAsUhplEoL6TB810Bl4Z2Fv/KNGvbulj81sUTt771bk79QufftGeOm45mZp50qg4yyY7VCgAusPlNXf5LaxhsiJVqsp+j7mKiMiAdR1U8Lr6vufdZObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9B3Y3U/nH5NPvxifW0ZsA8iX403dZXpoBuCN9ptObk=;
 b=Uhbnh1UnxwoH9Tqe/paHty17uCNTafzUHuKpze/EUILb34ofFVfMfngPko+F/9iQcpXja1TrjD9g6LrApMUiFp0qESDQ3Lg+8EVmlrMz+3J4HIqFdgr6n0YhRAugBizgfk/7pr/8EeTaPrFrmSOrp/Et7Mgz5+AkRPyiGt1DwGfSawaLNrSUlwc2LWvN7s61AU9BA75Npj1Br0zIM1FuXv2Rbh210NHCkGL4v2Qt3lgRSngytW4p+vE2lVl5zi8kERFV8OwSJZKyA//DhdWL1LqN/leoNFyyG6XVV957uooyrdnnS6iZiXiI549o9bOKmbH05HGBj6l8AB04WuRjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9B3Y3U/nH5NPvxifW0ZsA8iX403dZXpoBuCN9ptObk=;
 b=da2gN5QYgiEQxMgYIu2aR/ieWEdgXgBPrS0jtCJ3bWGbitWvNithOPijTiVSAm7zejSiYrjjkt/5E+O+vFGMqGmv7AhsfKOdgeVdSxPls6+8rkYdCecxpGvFWjSrHECoUXcc7+N+0CUpbQoJoHwqA9tjVTOOgmhdtzOnsC4/IKelfsi+7jf5CaKxB7nzfOV0vhJ0UbUhyn//wYWeThfFIiK6Bk6yIAYP+IiK6s7BQcpeb6zITYTjq8mGXQCO27SXuhJYMxW5O6KwK3o7a4V/O66rxU1xwWqcoBFN6kWbgB/sXc41ULEdvLdyWDzrz2uS6Mdh/zHzTzns6au1qq1Yzg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:42 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 09/19] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Wed, 25 Jun 2025 20:30:01 +0100
Message-ID: <20250625193012.2316242-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: c75e182e-98c1-4100-abc0-08ddb41ec5c8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CbS3bF4UCQLnD1o6rfaZT2B9ARhigTgMxSEUj2WyFu9ZU43K/W2LLqy97Inj?=
 =?us-ascii?Q?8uQ+FxW/pYjWGtmdDIaCR/qWT30Fa9h6V/oVPaZ0kIMSf7idTSdj3zjDhKMG?=
 =?us-ascii?Q?e9aQiCkTxgQfxkIiLQIGi7Eu0m/TK2IooD4LJTB71JpQ8NWt+2CLQYEtAUXg?=
 =?us-ascii?Q?ex76SKPewWmZ6AFteDEZF2Jgm5hN5jCABZtFdZdBcg5Gt5trKYjuD01rAgdy?=
 =?us-ascii?Q?R9OoPuUYn4YPB67Gfl3M7F2qJda3LGcXwz18dKMiBguSm0zokL7cZSvu13Gq?=
 =?us-ascii?Q?j0cAg5N9FWO7K9pJMtRFPRtjdnx9TTNZPXKgFaZ9lfQjWyladfvDj9aJhW4z?=
 =?us-ascii?Q?tIhTxspmbI2l+9nEpf0yExzqHyXxXbPeEwRC1/Ho6oMurt8wmLS5sL7C5QZj?=
 =?us-ascii?Q?abKEydVYFR76Q9+zwPOyBgCgHG2Yt/NUFpOvym4M0jKiffwtIx/6yhxRRdys?=
 =?us-ascii?Q?wJTnyTu98Di5J4P5CvYDHG3G3p7MqeqYAyWffgRfUTR+1i/gOX0xv1Qc3MaP?=
 =?us-ascii?Q?btZZwFlzFXBq6cP7Gu2qiAiq4N63fkbDX5j8j+vCPnwhjV+udA1SgPPuUAPu?=
 =?us-ascii?Q?N8Y+uCOrpsY/UKSIWphXjGyWcQ/pg0Hc4bK3RVCRco+rjGiroj5wjp7ZHdkI?=
 =?us-ascii?Q?agQ7yuTvmT7nM/KZZGRSV+zAhBoue4V5U8m49khjOO/fVX9ZLn4px7qjKLbi?=
 =?us-ascii?Q?xQkseAYEXUakQAuCg54VoGuEd7u0K6flLsQaZBAtMrdaOrwdfRpSNe+tAoEV?=
 =?us-ascii?Q?ZWVrh3QrJqs7SVjxnUSm//8FUbIseQvS7wbTnxcVF3LkK7O4Sob/Yvv6U/DA?=
 =?us-ascii?Q?t23/EAYqZkqdRR/4qqHOIONuKmwiwXyyJnjLK/zGOj7HUlJqdhIsZX6zo11d?=
 =?us-ascii?Q?1AYp3xNJpyIJflEo8oDF59X2I6Hl6fvmVaq3W7Oyfe2UbC8rkdB3OSlLGWAa?=
 =?us-ascii?Q?IaOjQ88fHFgsw3Wo4h2adkZZKcu+9jjsLV4YfhCW5JvwJkV90NeQnm/SO3c8?=
 =?us-ascii?Q?pT0H2mAxtPLaU3P+CjuW9ue1YALh48Pe/1aCY53YakaD4rqCiRHAywp9+G3B?=
 =?us-ascii?Q?kGxHsBhB/j/dSifI3Ofj7WIuTPtVyLlINXL3zJEJPm0FE+ML9HGTVdeUSxgd?=
 =?us-ascii?Q?1javc7KjXq3EHlTQm9rQT7EaFANFYFeVDlUDZ9syeu/FskWpWNcUx2Pycasv?=
 =?us-ascii?Q?KvI7kqW/1qogKKtE0D3HFnhPjX9Y2dYRzauGqwG5NoYUPsMpVK1DkhV+37ME?=
 =?us-ascii?Q?6hS9+IQawTwJqKhCJeT2IBJ7rMPlod0U2/WT0Oyl1QA9U3cdy8QGRomNwC25?=
 =?us-ascii?Q?MaPmc6R5fWeAv1cvXTbjYFU0WRxsGJXfc5dZYIZwH9Ez9+VxockwL7gi3057?=
 =?us-ascii?Q?INkk0u/O07/nRYvkIuwgRHaRPPLzY8XqDcO7Fmas74W8978dlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dBAAJxoMTT48jnbwTJgAewBPVEuyT3stFDMzsjQKJCdmA1cutOdIB4tajVTR?=
 =?us-ascii?Q?pIA74agVUBj+5OoPlYzsp6fcmEIgCe+Cae6cGc4/Uy5me9x22uZm/rKX6KVs?=
 =?us-ascii?Q?iIMB1faBwBXfPlLp6+u/LxWzhcLz3E32mSEr4AA5Tl0CHxPtPEu7zOawmUL/?=
 =?us-ascii?Q?G1fquC7gQqbYtv5ELisR9lfXpc9vYp9n6Sy4VYDkMvFxTgYefRfWOolR0liZ?=
 =?us-ascii?Q?9Baxdd87u9HOC4sTAeWU0Z+6YzamE4xh6D3RR/rnmbyDLALmx+hn2WNcj0Lb?=
 =?us-ascii?Q?AFpzrtmMnHa18pCxx0BSXCa5/uHF7LCNe4p1eFrz8LF5N6CZvck91Q6Fi4mT?=
 =?us-ascii?Q?vfTDbDQMJxtZ5bg5C/5PMbG1OnkaFQyXyf6QD8E5b5lskr6enRLJLOSbbatk?=
 =?us-ascii?Q?LEBGvpcMLkzmUaXnoHPm/qKh9dlyndWF+NvIwnKoo8+QM/2pEaCMDVhloObc?=
 =?us-ascii?Q?ZiIC2TSlXXq7fati+s7z/iKoHELE7HN7B8EpdO+kU5kSmySqP8x+KDrY7f69?=
 =?us-ascii?Q?wx0pAX0eCG3ogN2ixRZnkeBqQnXS3+RmOHsNd0elqjONNTFdXxOguO8t8oPZ?=
 =?us-ascii?Q?XDlXWi+IdJLfhAnDEKoDTlpMqCApTKtLpLB9nCJ0XnsrgqPEx4Jk/HP30xe8?=
 =?us-ascii?Q?khLknm85pOrOt87N0AF0CfVTsh4skeU+abdEQSC78l/du1ddHahpNWCgyKq1?=
 =?us-ascii?Q?LxrWacYaEK5xl913qsu6O61meN2jVq/BiMGv4hPIgi1mauOnflmfzUt8S7Dm?=
 =?us-ascii?Q?M5+KeL3rXLXoxS/0ESnsmdnkUfOt3Ge3uCD6QIdPYv1sC71huHTwtmTJewQ5?=
 =?us-ascii?Q?8fhm94fHnDTFYf4vbrdXs8lfJFbAhUi4HKbXoOoNJFuwBOWdvCgfSxUkO3ln?=
 =?us-ascii?Q?QNNuPgGd/5JQy1nF3bVoRkEE1sXfswQBoyva8ixUPSAv7KddDe9ApfS8FKXW?=
 =?us-ascii?Q?KKkJVIbbGbdYRokIj3eCegcTzijlFMmt05ucQVFqkYeZBvnjBQBR1moy0hwf?=
 =?us-ascii?Q?an2v16EQZgNdGHECmrRo0gAVnSc3hTYU0/5aiC6b/8gnzF3B7v7klgl5g0Qr?=
 =?us-ascii?Q?4jgcbKQGnbyTiZ7g+NhYgwYqumzzxdfuWnVJ1iXqSN3F8s4KVN3BeO1gOAaH?=
 =?us-ascii?Q?2/J4iGiFXxMVlKlngOs6ZXHQeM9bg+n+coFeB442guePETsBNzcQUMMqKDSo?=
 =?us-ascii?Q?sb9gfVSSoK2j34JjgqkrJuoWcAnoH6U+7NKLYHQ6bCexAHsKUV+XsfB6An/M?=
 =?us-ascii?Q?95dMrPN+CMCD2s6obfErfj7H1jF6FehrEVcVP6I87SfaWyM4Z578KSF8ft2Y?=
 =?us-ascii?Q?TmOXQUb/K5JXP47r6t5+I7DivqP/5oW+PuZ9+oWtMJmTzVOMdHe6SukuTA+x?=
 =?us-ascii?Q?HFRWZ8q63ZhK/GgElrF1zk8zw9uyklEToZ2wpmBMfCsJxs5o4FaBNKvT6dMt?=
 =?us-ascii?Q?bi40bs5pu5LureLO0QcVkEs8rZUQPKRAX+nkyqy60KsTp02xZUpHNzDP+Dlf?=
 =?us-ascii?Q?Y3k9OsqKBo4DNbEFiscwC2/7O1MJ9cTFokLtHBq/UDMicheZt5JPpuymySUB?=
 =?us-ascii?Q?NdfjvXSGkpVVRVjOsDLOoaB6LF/iuQQVaSWGdWEx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e182e-98c1-4100-abc0-08ddb41ec5c8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:41.9753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaAPFPc908xWnrVerEpxpZ4tV7Cmr6Wk5ga5JumkTGUgAe2//ly3qd61jcipF/0KK56fS7b0gfnoY5mC48pFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX0nZ1saCyLXQW
 dshlLzqx0moHB0p4FKpz3VMumEhfCayCYbe8DVUpuIrrX8NolmhDMFktEnJGw/LgtT84Tpsb679
 0qJiedEgLjtD2fU4jWTG5B44hN8bVXuTWGoObo7gVmavtOEAvsbl1vhx6M4lIdGYDfBL669RdUs
 2zGPJA5+OXZujP2UygOn9lnVGNQLiNRgakVpktriSc9ufIWkCqoS18scmlqf8XRgWU70TgKLzZO
 OLkkJLBfYjwjrwC5al+YgQQqlfP1rNrSOyydnCsTgCwLmYslahvk8FjEH+qU0QnEQRetW415odX
 4dDr+A89nrDQACt7+b9CZ5rOzfBdGXLGrcJrye39YOKIuLo1nExuZxJEGXQJ8St6q7sVNqm9WtK
 /wH44zPNOwoCaLIZGQ/J9ww/PJaQ2LNz3zEScOuE+IzKigK7WddkNLwaa7qnTWH+hUKn0pBM
X-Authority-Analysis: v=2.4 cv=WNp/XmsR c=1 sm=1 tr=0 ts=685c4e64 cx=c_pps
 a=35YEAAF7hVpMx76/Bwrsrg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=mEHtUxI8w2dYJqbWasEA:9
X-Proofpoint-ORIG-GUID: BbrtnHlPZh0-0TTYMp_d9KXB1cP8mqb9
X-Proofpoint-GUID: BbrtnHlPZh0-0TTYMp_d9KXB1cP8mqb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  25 +++++++
 hw/vfio-user/device.c     | 138 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 165 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 0cd32ad71a..48144b2c33 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -138,6 +138,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 4ef6a2d850..f01b3925c5 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -121,6 +121,142 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
+                                            struct vfio_irq_info *info)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    Error *local_err = NULL;
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    if (!vfio_user_send_wait(proxy, &msg.hdr, NULL, 0, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_device_io_set_irqs(VFIODevice *vbasedev,
+                                        struct vfio_irq_set *irq)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+    Error *local_err = NULL;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0, &local_err)) {
+            error_prepend(&local_err, "%s: ", __func__);
+            error_report_err(local_err);
+            return -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        if (!vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0, &local_err)) {
+            error_prepend(&local_err, "%s: ", __func__);
+            error_report_err(local_err);
+            return -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                            off_t off, uint32_t count,
                                            void *data)
@@ -202,6 +338,8 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .get_irq_info = vfio_user_device_io_get_irq_info,
+    .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 733313cd1f..aa8f3c3d4d 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.43.0


