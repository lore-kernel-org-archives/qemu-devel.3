Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD792C021B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOJ-0003HE-Cq; Wed, 19 Feb 2025 09:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOH-0003Gf-TI; Wed, 19 Feb 2025 09:49:34 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOF-0007As-A9; Wed, 19 Feb 2025 09:49:33 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBVcSZ008853;
 Wed, 19 Feb 2025 06:49:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gG4HXVmj9QlbGmx1vIMAGEk4uIlpHTF+8RGLijexj
 14=; b=1O21s7HGsylnQAF/4SwtVoelEXW7u7uy/E1oHo07tf9ClZheIh1zuXDm9
 Pp/2Qe5Kqzlt/Fww7Z5O3FlFx7CwdjLPHPncp8h2dFFkE+x0pxq2wlG3whe5D52p
 AmDuTGKkovWue+LLjQTyVQbNJ0xXszGLyeGAVdeici6wpc8ICOHooiApE5k66mKT
 fQrUrqGHKvHuJo5eZK6PqSW8SDVWgxMdw3Y/gR4by6qxddC0/Bo0hMwsswX+pRaa
 r1gAJKbi6Pid/0sjhLYyf1tohZuNcCBERDcSXeSvkS66uQv7k0OJPXwRWLQrpAR7
 Jqkp4FEEkJC7ohIp/eoPW8OjvRO8Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013060.outbound.protection.outlook.com
 [40.93.20.60])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basy8w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtgYip2ajbjWMJq1UBVRozncKl+u1zgjDTrwBANUybl9iMTfeJaMAVXggQiy0PsKkexFVQfAfjn+cR+pPRf9I+6rWahuRGRPGT76ktzzqs5JRjree53BAZnGJtUK82DyvURNLLJrDJ2rFymeBXXJ2Fbq3/HA4n0MJf72YrYZomlC8HUMKbGaAF2Wsx5y7XufY91ewlOwYfP+09O/3qa+oEpUjRLxEmJDwcylAWpRrqXL52tz/zzfUHj2dgDm7EMj06iQLyvmxXnnKMZeWsglBI2VBxKxKWnjGDg5damUhvmVWyaKvFMh3grrboaiYKjKzyhUDPq37+IpqALoYhq+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG4HXVmj9QlbGmx1vIMAGEk4uIlpHTF+8RGLijexj14=;
 b=hLWROKlpzZntDtiR0h7Ifh6oHusU+70wA0lbv7Lv3KWq2nVF/KekWd8nA1rLu1HZLkloK1EDrstslFDlKvpFZv35WML6Y7EoODeHtNh67I7/Pcru/VJpHQAZig9/GeIGFL0AVejU8ewTw/aguor55+5cbl/vuHtzctEa7PwXyRegYqQPlYff4chOHZjIaOSAdfPqrrrFGB0RhY/bzvHigQFOjjUpuKhUWu9a/pSjX4m5uxaxRM/tjtYxlr99cagTwLZwPSj2qGV8QE0TMEmWqd4StJ2G2w7mX5bWHrHIACv7s8ji58+R0yJ7wBNBdA+4WjKQVoCpms0ts16X0wC2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG4HXVmj9QlbGmx1vIMAGEk4uIlpHTF+8RGLijexj14=;
 b=onupNvRXv8aw7C/kiusTO7Fjg91l7WQt5Q1io9PD6DNyMMuvcj3Mh4OKh8y0aY3/JUzSwJ0dfroQnj2zyZYHRshQxTixGu84Ks277dTK3hKqoAcNz0HS7yD+4sThkNZabvqkdbsIV/zDjyoNnAe6mA2SNzmN7apegZZsByHbroObA01OhdK9HxJWZFjYTpupkIOePT1ROL2/0mDMH1PP8I6IXdZurtCOJELTNzNcpaYcgdzXvjlB3gj3IoI69gxsDa/RAqegUiOdr0CRcOtDd+cqi+YgtZbSADEmf34YLalTpQrYiNO98DFjOCtmelI23j3BegNK6wvy2MTQILuraw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v8 03/28] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
Date: Wed, 19 Feb 2025 15:48:33 +0100
Message-Id: <20250219144858.266455-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: c64daffc-2347-47bf-4ce0-08dd50f49870
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LQC4GRsgVHJLA5bu/Dor/glDfg2dx4KJtb2vq23KjPruCh6kBstLYuB6J49I?=
 =?us-ascii?Q?u3dP32EliJFsLpAGxthHcZ/k23qpKAHXBwi7pqtB/tV7xFURwc5f6DMvRyOQ?=
 =?us-ascii?Q?qkwjJCWnaUuYkWjAxrTSYyguHOnv4SZ3x43Bmrl9fgcFRYGyRMz9875Alkhh?=
 =?us-ascii?Q?ffV2R6smy1M0aJIJJ0Uc4PdgFV1kHOROOsVgbRxEX8O0InaA7G0Op8wgUQ5M?=
 =?us-ascii?Q?PeFaGG5xxrsdzUTrukRGHwN/nDa5mqjPw+cv3PlRsPbgW3O2k4jJ0/AdX3eU?=
 =?us-ascii?Q?ZoAK15DYGT2cy1VTTUbLwvi/ExHznr8yayQOou0SIATNdl7e78odQNZxX2bp?=
 =?us-ascii?Q?qDSHFY+kdrB6mFcGr4Oetdaojgng98RA7VWDaQ3Lb7v/nMZEoPaDfSrhgjIt?=
 =?us-ascii?Q?8ulO2L5pf66K84A1GXg+3JjqBTBJD0x6pakdWxtr0+0UcrUt8U4g4ON1ASCl?=
 =?us-ascii?Q?bG6OPtwWgVIgrOqNTIGNfj/mkue+fjZ65wyOhSrIKpO1ngQ0J9zO90MhwnRC?=
 =?us-ascii?Q?nfv1KfrToTTRrYf4fXsQwAsvOyU/nYWqtlFUm8wZYOexPTGPG5ilJWmMaHeG?=
 =?us-ascii?Q?wA44CcPmf1tk4kqtOax+H5XXgUAvqc+E9W4eTDeroubwFKQDOKNHPQkw5cw+?=
 =?us-ascii?Q?zMtdNAONNqYhE8sbwd8aTEW0WnX+19cgraTNgrVTfdo1MvBJpMpX/SFRFSoj?=
 =?us-ascii?Q?8ewNWdWXlwb3T2zRWhS1ygRzA0vc3iST9RxsIWD8jq7vXJg7+lch3MSpEndp?=
 =?us-ascii?Q?dtXOZi4qr0ANns4re0IYXE8xBVh4lj0c28IIrlGBn5XTrfMI7Uhxz1u7OJ/r?=
 =?us-ascii?Q?58uC9YNyzjeM9jI2VuA0HCWWWDGYBPDGo8pV0NG29WcudMumcFD+pDara8yg?=
 =?us-ascii?Q?8aRbExSXmBEG+B8nstpX8I35cXwWGkbIz+F5xjqK4sK8YtvKS2ZcxSjbX6Ur?=
 =?us-ascii?Q?CSrQUnn6gF/7NPQqej/RgejcnQuEMcByFCEnXlLS8/AMb/vfKjRll5DGk577?=
 =?us-ascii?Q?mcYEcQ4q/08iCziG1jlIhNaN8ABInV94Mybb+2+BD3hPpl54wpsL4seUDAb8?=
 =?us-ascii?Q?QRlW76kXQi5LaF/lTyOjem+3nsuAe5DWeuhWRzvRUbGWjkf/0Tn0SYGU+OIQ?=
 =?us-ascii?Q?2GmOGopyCIvcUSeiHupYsAbCCHr7FfG9d35vyc+C3OMvjcUSVgxjqXbcmLj5?=
 =?us-ascii?Q?RjpPCdE3sbbaP6OBwiytBQVsC9ACGeQCRMN/5TNffM3Bd27d2FecEzEwM6zG?=
 =?us-ascii?Q?PfRfb3H+yG0KmUnNF9j2y4tg2qV3hzmE0oA11fgHJRyCgCGeGy2kWKEp6ppT?=
 =?us-ascii?Q?NLZp/A3uVnMDbfDlyK517nU3E6wP/G5Isv8oOMhapzxV7jrewqwoRJh4+SWs?=
 =?us-ascii?Q?//UJwMM6rUFd0ZQAAee/K0XVSw8a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DejeyOB5aVvqvXqnFYhIBVB+jB/5WLTTzaCgLR0RVe8Qkz+KT2Ky0zVSUmZ?=
 =?us-ascii?Q?1Hptc08EgdGk4Q4zjvK6qAg87WOClxDN3LHD60a/W3SZLVKi1UGpgH19kAM6?=
 =?us-ascii?Q?4rihPYMS85BRO3F2OA0cZFZXHLAZsKxLoYY7BXI4He+IHCZnr6Ax5Aev+tz1?=
 =?us-ascii?Q?cvwX7Vl0R1/tD0bCmPlMgGheJ6CAL9MDl9ptjt3rXpEKEQhA6SnzNnVASDLs?=
 =?us-ascii?Q?7XJh8KY/p+OLGzY3tLRbKXbuGM66m+3E0AQcFZ6IKGqiifODFUrdcdYjfxCJ?=
 =?us-ascii?Q?ZaH28gpuC+pbBQkbXlbVX9of+jazLCg2BuA8N7i+K3cs+3mirj6dvOs4GCYx?=
 =?us-ascii?Q?KPIae3+BlRh22ayxlu30Ne5311wIrQ1Gm2KRgcR8GNagcAnY9PNucYsPKO4N?=
 =?us-ascii?Q?Mlzo4w42awKxWdN8AbuDbYqUzUPAjKZb4j4RbkuNhWTCO90AuZ/+hB+6IJl4?=
 =?us-ascii?Q?JkPgfuJrwtzOnrub5ILxFRooXqDZQywBaWynRUW4LaawUM/tl+NALMsZruW/?=
 =?us-ascii?Q?uvRVw7Mkc3Adz68ZMw5gET0sMDDMQiusqS0VenNiUY4WrRgi+BANMSfz5/ej?=
 =?us-ascii?Q?+xWFrMiwTMicMsAYJks2PXMrJU8PpKVMF6GN/MIZfOe6iJSLc7VsR/Tc3hwN?=
 =?us-ascii?Q?7PzU/pMGQLoqdQuVWClL90wB1n27FzBbYFHCqY8YQaURKHBdzyd6lwncY2OT?=
 =?us-ascii?Q?8SbS3mTO+KlQWtWExd/ppfKScyz6eDyl2cDvaLKs4DSTwEQk1FtUQMXnjtoK?=
 =?us-ascii?Q?d9tAH2Bc5Gjf6iETvFtJI105svopGsxVKGn0l6ENo7rwWMdLvQ5JbD9yzv/9?=
 =?us-ascii?Q?bLrixN1eB0tzkn8XPukBtmBX31QbBdUwwEbBXF1Uch48fmbulB/Y0l8+g9J2?=
 =?us-ascii?Q?1uiEP3YCOVNpGw8PxLLpBx5b+QNM7bLVpsULiQcAiSSYZTLMaDrUy+OeOVW3?=
 =?us-ascii?Q?w82tat1sOfMaRsAmKaevXyuhBNNsXnejwx4C9eCisXT6O61YtlX9os481o1l?=
 =?us-ascii?Q?Wpi/qRfeGCxamzfCuEgiwB6yJiXWXMZ2bDUpWfjbCG9hRAU3TrmYGIwb6pOe?=
 =?us-ascii?Q?a1Z1RvCcWuf9I7g1wFUvs/0BWHzJWCumEhpXnVLs5EcjyX9/VB9v/v0ECQqt?=
 =?us-ascii?Q?WNH8M5RLaKcv7xMjqMYcDUKmtiaolGD4LEntg0aqWEEonmdWdaFpfPi8SmiA?=
 =?us-ascii?Q?7bjb2I0/ZFkDgpkZi4uyNjYduZJoJdH9nzhm0JYS/RM1qv51slTAvAOrC4i2?=
 =?us-ascii?Q?WEfPutA3L1AGzfQsjNOufzlyB3O3AlZj/KW2D2ontHpTy3Z3jlePm6qFN5RK?=
 =?us-ascii?Q?d7OaEzawHhrcpF0A20NdVHYn7NooZCLBXTpCAsKNUjI2IwgQhqs69VhlmGOO?=
 =?us-ascii?Q?Emv4IQlDdd8VWAuATXI9FnzXbMvHhyNs38E5EYGE6HWUV8hMVS69RPnEjkON?=
 =?us-ascii?Q?TZtUG51UbcaL2pu+/hd6OKQgv9FurAzgY7M3axDKdxprGbbCs+vSgYO+9n9y?=
 =?us-ascii?Q?Q4b4uhMETvmyMo+T/7I2x1JTgW3sTY2Rt6teMro7qQEcBvaO/qCsvrJFStGu?=
 =?us-ascii?Q?G4i1WyonO/WVnQHymT/kLKFVANk6Md4S/HhKvYy9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64daffc-2347-47bf-4ce0-08dd50f49870
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:21.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7BvmueD3C5pRcqbpJPKz4Iwm+aRgvvNVOv6/hnYvF93h2AgSOtRmGJgza1e1draazS9eFF4sqxIzUKHY+3FsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: ozHuOVhwLTlOqkUO9imbgvx7maZ_Yncl
X-Proofpoint-ORIG-GUID: ozHuOVhwLTlOqkUO9imbgvx7maZ_Yncl
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b5ef77 cx=c_pps
 a=4HTA/yvmbQxnAJvhdENERA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=rAkVWd3RjT2K1M8sKjoA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

Some containers can directly implement unmapping all regions;
add a new flag to support this.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 24 +++++++----------
 hw/vfio/container-base.c              |  4 +--
 hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
 hw/vfio/iommufd.c                     | 19 +++++++++++++-
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  4 +--
 6 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6f106167fd..b49aafc40c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -324,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, 0);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
@@ -348,7 +348,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size, NULL, 0);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -806,21 +806,15 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        int flags = 0;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, flags);
+
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 5e0c9700d9..db27e9c31d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -27,12 +27,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, int flags)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, flags);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0db0055f39..82987063e5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -117,7 +117,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -140,6 +140,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         need_dirty_sync = true;
     }
 
+    /* use unmap all if supported */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        unmap.iova = 0;
+        unmap.size = 0;
+        if (container->unmap_all_supported) {
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+        } else {
+            /* unmap in halves */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+            unmap.size = int128_get64(llsize);
+
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+
+            if (ret == 0) {
+                unmap.iova += int128_get64(llsize);
+
+                ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+            }
+        }
+
+        if (ret != 0) {
+            return -errno;
+        }
+
+        goto out;
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -162,6 +190,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         return -errno;
     }
 
+out:
     if (need_dirty_sync) {
         ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr, &local_err);
@@ -199,7 +228,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, 0) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
+
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+
+    container->unmap_all_supported = (ret != 0);
+
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 583b063707..e295f251c0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -41,11 +41,28 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        iova, int128_get64(llsize));
+        iova += int128_get64(llsize);
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            iova, int128_get64(llsize));
+        }
+
+        return ret;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ac35136a11..f4f08eb8a6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -84,6 +84,7 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    bool unmap_all_supported;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 0a863df0dc..24e48e3a07 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -76,7 +76,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, int flags);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -118,7 +118,7 @@ struct VFIOIOMMUClass {
                    void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, int flags);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
-- 
2.34.1


