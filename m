Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9651DC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOR-0003Jl-R6; Wed, 19 Feb 2025 09:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOQ-0003JI-2q; Wed, 19 Feb 2025 09:49:42 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOO-0007D1-1a; Wed, 19 Feb 2025 09:49:41 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9Lbhp026947;
 Wed, 19 Feb 2025 06:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Pd+nhoCV4Dxd9tMdn0X+FSv/i/j1nvi4kOe9UsWGf
 A8=; b=YiQMOJjTArZVAL+9rBO/7zvyxd4n8JXnD0i0qIHOBWBT5jy4hw+sKyBcE
 udxRLqfOz6f9Fkt2jd3BZGzJTPeAdaYs1Qu42++IE13cOz5usLybRcfyFpnjIDlA
 seYMdoYxB6GTu1HEZZrRM4tu51DBr0trMKeUxooWxi9IkXPiGgbREY36PV6FHlcB
 5DL+D73QDu+RYRqtsGlJRbhANqldWuTnaXmurUeKrk6l6UVtYmmOWVfb+22n8Xfo
 jJOn9b7PnOUQ0XwBDW3qoiKzoc7bD9Ta1ZAF3w2aFPOM1aZzg3p4+mbL9s+Q5is9
 PGyuGCrnDuu69VQYK50ZgeBhoSbJw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013058.outbound.protection.outlook.com
 [40.93.20.58])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHX30EZTB/ONnmfuz3vKMelYdIdyDatc4+3aXL6rSqps+NtJCpvvRW39LOKrbV04rMLmGRwk0gdme8tyaNaROdMqxIYt2bpCXpKDPiV0O7r9qL4unYitLYyp9wzP8WZcvH5JhgMZ5Ek2KJM98xbzVYtS/0lcpQDeGgzXu0AwqAziz3rdoD2nyFGGV+nkNyX/+eoCDQiQweCEBdfrYCHnEcAI5EpcFi985Kz7esadeghgEVLJ5BshWcvalUPval5As17jactJnLdaKBewwPxM8zRwQQiL6mi7rc4rJMb9F6PMo+0gagYJf+pK2DoOfAJnWt3oU4bb1ZrnQlXn+m+Zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd+nhoCV4Dxd9tMdn0X+FSv/i/j1nvi4kOe9UsWGfA8=;
 b=Uw6uk5rA28eG0cPel5dFrj2M7Pe9sWiwUsHCddGLO9APCYBFvQCA54tEY17e3Dux50wrLhsiiroh4bj/96LCVNtr4knRB+3bHIs/yj+PTPiny8MrM/k1adXbylROpPQ9/AE0pZKpdi0ZfCdRwiyi471k2isbCTjOyuXgNiXVLF8t6po2YHk45sLvrdDYvo2XR+8vyNaTI/m2+n1QUmyJOhrVRu/mtpmTf5EwumsqTPLupB18mOENiVvoo+wHptDgsRoKFJSJNFUwpX8xqXthJ/ONrGR6At7hHEvO6ORKbw9vaeIamyKHuW2AiJWuZ/4x8I9QA0aaoqpdqaCRawCoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd+nhoCV4Dxd9tMdn0X+FSv/i/j1nvi4kOe9UsWGfA8=;
 b=j1k9ZKb02OrenmD02OxFeXeKX2oacz5D10EmdupBb7Jzh0fJbIq3ONJowhtWC8n7001It2u9vzaQkrhXEVvuZ50ijRelmHDxROUdS5qaLITdXTIJF8MoVdpdl6gLr4oV949RmRLAUgV7+iqQCyVycw2HdYDtz9thP6Cro5ba6D2/exW6v7EW8h0hUk9VQHvsq8OeakBJwH/jEjN7cuJOuZQsh1R/nZBF9lhTZoJDRRyG53fEjsHlHVYB38wGvOKo3kvQZHHqHVZBGZvIYR12SGg3OuGVQPWmozPsniXPKYZ4SziajeFJHGT4fz4Qo4j/z1SeHAclL7cpZbG6ihFRlw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:34 +0000
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
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 07/28] vfio: refactor out vfio_pci_config_setup()
Date: Wed, 19 Feb 2025 15:48:37 +0100
Message-Id: <20250219144858.266455-8-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0583152-8f81-4db9-6c92-08dd50f49fad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9GKgCVtWMlbf2lPemHQ3qNbLOiDF95NkTHW4TX2Y3g+JqGoWq/WMHzL8XZtl?=
 =?us-ascii?Q?GSsyOiK2BinGgtJYj9iVN+4nmoiDDFegtIKeVFkdJY5bYx7dgKNekfSrvuK3?=
 =?us-ascii?Q?LS1VTsBUnBDCua4frdjfth9mjRsVAIlQsij9SxKk1zP+1xH3dWQPpZkF4U2T?=
 =?us-ascii?Q?x+3IBlYRHKjmfQo2SZeoJfpYMl6s7eQvCzKx2oj/zA1Qg5YusZZr6AjBO3nJ?=
 =?us-ascii?Q?aDRmhutA91CMjjfzwKyZF3dEn1BMJMf6jixM+A0bTtp845QozNm0US2R7Z8e?=
 =?us-ascii?Q?EJWzix7SnvF9UVXkoc7I8M6nFWUSmtwB4+KciIE2xVo9+usOpSjQuMufZrQH?=
 =?us-ascii?Q?ow/JPovhVxbuJ1jtyRgRSQdJm2SJNbz3QWL5wfdztEgwpBibKr0LufuUllZj?=
 =?us-ascii?Q?aL+BbP9z0aWk+gdttdEKiXlbhDPjb2OgDe0Kjk7Ur8G5S0I/+l9fJinra7Qn?=
 =?us-ascii?Q?IfwyHbrKuHfVbUtoo63xwfCZqQEx8g04Lxn0PdRTbwi3Kw9cAOYrSvfGvMKx?=
 =?us-ascii?Q?oy7ElszU3lTfqD6wydtprlKGcdIpz/KBccjx6UCZeUaq5DMkSpLZFFCu1D5C?=
 =?us-ascii?Q?gahlB1OJyjW36meXMxpnOOZGn4QGs1gPbmbjPt9D8wed8HQjmXNYUIAW96HP?=
 =?us-ascii?Q?kgirCHhgbraFCiTSMyemNsiKxRyjKt2SuaqfrIVZSBl08mPyT3DEqGJ5cHQY?=
 =?us-ascii?Q?0GnjCZXWtZbxJo7iby1zWvioPEC9sOAE9uEsHSnDL+/kFRx/fDE0Y0qqHCKM?=
 =?us-ascii?Q?9DqIgQREphO+PXtKTJ836ZwQKfOfN7da1M2V5Fbc7liEd8rPr0ADhl64pki0?=
 =?us-ascii?Q?e770mEvwNe+YeRHhZSpup/OoTiOm9InkVKJaEyh77FDZ4PcU1OjMEpZk7xfY?=
 =?us-ascii?Q?vCD3butELQ0Vvd8J1jlKgF5nDIVYaSeo2nIcvObY0Yc/QOaLZQr5k5LA4ybS?=
 =?us-ascii?Q?H3uYVSShBnZPJJIZPG76V1RcRP6DXi0RmwbZeDwPbk1n3oLdLv1UuHnDFEW9?=
 =?us-ascii?Q?k0bvLORQ5TsDEgjy8UB2Y/ztxQwxOvz4LdOJ+WzG74UFH1cdH6N8zNTK6Rj1?=
 =?us-ascii?Q?0uplqqygdIr6cIBJ5LiRLROrGGIB6pF07GTn5PhfJotAW/JzkyDFlz6ZCwUE?=
 =?us-ascii?Q?tSA1ghplUSkiMMvyGQN77WKloU6DxFAvZFnU48P6bR3Wm+sAHhX8MglD2uFe?=
 =?us-ascii?Q?rSEUno0IzXCD6hvGdjXs2ZgwufxAdFRJiTRF8dZCasDOBUNPB8MSASZGHRJP?=
 =?us-ascii?Q?bWtVryE2S0x/suS+loP3pG3Sb0i5yy5qBWM6cwq1c7OSyu55uM5ZTnzmMo1w?=
 =?us-ascii?Q?yWyscWv+IUEj9bjeqbQ4zcEpoEzaQj9QJzOEwuaD/gspoT/wR3ZeFiK4u/qP?=
 =?us-ascii?Q?EcDdOaCMSyn+VkkPNeAF7bwHft46?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2cwEM+6cgF7kRXtkrBhp6xQ+qgLXPg6EUao1anC17UlOSWsVnsO4K4ZL+A+X?=
 =?us-ascii?Q?DsRm/2MhKh1I61/fZHzRKbRDiu/BXL1IJdVa9BfVEPKd198c4NAJEs8pu2+d?=
 =?us-ascii?Q?iMmz+Du8mhPiCHdbSDP0RRINzZg3iEkbgwxVMaqNs/eDO/45GhLS5DByITry?=
 =?us-ascii?Q?ZM60fzfdiLiJEUM9DU2NBdHO+MRYIQpwxtyghx/WflSM3yBqmuaT8A03h3IF?=
 =?us-ascii?Q?P8sUm+6AwMPWN+ccid0Nag4NSULlA0/nW3W8wEwCrgdnlGEAKQxFlXJQ0aWt?=
 =?us-ascii?Q?KoFaXbZHQWH4MssCfWg4TeoXZRUQcHyduRiesG0e2Qs2zSyavaRHqeK0c0Wq?=
 =?us-ascii?Q?glm/AgapTM/X00U1Zu1OSbYF/2ebWT2kaA/CpsD/OXeROfDO49VmHihLbaPD?=
 =?us-ascii?Q?omnTZxpVks1Nejc810oeMZApDOicCeJ2iC9JDBrnhtbMqPosQPAoKnuTD446?=
 =?us-ascii?Q?sxaDig93Cpsp8qGN1Zfb7W10gZqobWDUjTD22y0TBWqXTSnlo/bf2y+YeE/p?=
 =?us-ascii?Q?zLJT7TjjqlcQfHXalcdWzAdj6jPmIX6xBydtLu+j6FKaQZ5ICH889G2fcWVu?=
 =?us-ascii?Q?CRRe8rbDHW2fEbD9KLSlRvWDfxH+wlYMxnfQE9W5yyyqjpTxYMdTTmWaek/C?=
 =?us-ascii?Q?auWQQdoRvdJ5/M0q6r0rur4h4SZmBpZ2MI8uKRFlg9IqThu6NdH+MHuNnWef?=
 =?us-ascii?Q?Jhgu5cj657qorEhQqIKd7loX69yWFY+mACUrgESHQKT4U53k41RGxolBS87u?=
 =?us-ascii?Q?irIpOS8fMpZM4B4zdQgiPzZdefnnxV41mZ2JS2u6UGEWSGMPJt/OoaZfxCEo?=
 =?us-ascii?Q?zK0F7n426RfDeD36zmDndBTIgWGee1K+F/+s89ICzDPbeNnR6q+b4vmkgegC?=
 =?us-ascii?Q?DcJp1JPzoeWSI6+mivNQ0TvK8E0IA24f7drJpwBAvDG96BU71z2az0ibiNrm?=
 =?us-ascii?Q?jhlYk1CaBhZ1GTOVx1/pCs6fTqW/31WJKK3lgriogUZ50/xCN2lvEDkdnkMw?=
 =?us-ascii?Q?XKphMQVohnd0+6kx2mZBOAgNA2mHfV8tOsGw6k4wBHUjyY0Ov1CxY6JWPVhw?=
 =?us-ascii?Q?Zi+5k9ID9Ymb2UFktj6BSasq4GiHnHrAx7a7Q1k/HGPvSbbsxLSna1krIu5C?=
 =?us-ascii?Q?x0BsX9fbH50h8OrlpZKwGQEKZbWFZrzT9D5uqjs+/pPArsWqbVOgTNaRXi2c?=
 =?us-ascii?Q?hTpY+AwMXjlrwZv0XY+w+1KM5D+0BQG7BvyW5m+UNfZXPbQt5Sfklj35LePD?=
 =?us-ascii?Q?kYKCJKxXMTVV+iwQfKQBUKNSC+L0uxTSdVgyb2cSwuRmoUuWvdEuxAqknYkz?=
 =?us-ascii?Q?8Vvr2UsvjnhrnTJAdNaPMjWYBYDGEWRDXJlBkQkuuzULPljk31R4hG8dc2Y+?=
 =?us-ascii?Q?VT657xh1b0LHnS3FolE8+BX7Mv1wcAgPPfFbwC8Ctb+5+AmscCChCzMzzlJt?=
 =?us-ascii?Q?Ae6T9l7cFe8ovMIEzRuJOYNpf+D7cCpMqBwUnBP83HDUq5jV7eH2D3eGcE7N?=
 =?us-ascii?Q?QEVf62v9GDg7xv9ufVSbj6M0UmIh/ECgnm0ymQcFJ64b+usg7nfjzxtwWUwA?=
 =?us-ascii?Q?Vm9wCgtEhtZKiGlwyTI1mh4zb0UTnQMTd4+5Y+0l?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0583152-8f81-4db9-6c92-08dd50f49fad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:33.9019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0GTklGKP5ferYMIz5A8XS7u34jJF58Um4PAI5NnHJ8WZ10eMqxGyodL1q+tjhkwHmF/8Mn/4Dg6/LXustMeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: RZ72BaqKvKDheUqYdy9hD6RBcM1tOEOF
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef80 cx=c_pps
 a=UiiUhvOI59TtQsb/yF5oqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=q3r9P8AP8Ax0Fte6b8AA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: RZ72BaqKvKDheUqYdy9hD6RBcM1tOEOF
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

Refactor the PCI config setup code out of vfio_realize(), as we will
later need this for vfio-user too.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 176 +++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 82 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5fb6c4c4c6..83fe329474 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2957,6 +2957,99 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    /* vfio emulates a lot for us, but some bits need extra love */
+    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
+
+    /* QEMU can choose to expose the ROM or not */
+    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
+    /* QEMU can also add or extend BARs */
+    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
+
+    /*
+     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
+     * device ID is managed by the vendor and need only be a 16-bit value.
+     * Allow any 16-bit value for subsystem so they can be hidden or changed.
+     */
+    if (vdev->vendor_id != PCI_ANY_ID) {
+        if (vdev->vendor_id >= 0xffff) {
+            error_setg(errp, "invalid PCI vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
+        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
+    } else {
+        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+    }
+
+    if (vdev->device_id != PCI_ANY_ID) {
+        if (vdev->device_id > 0xffff) {
+            error_setg(errp, "invalid PCI device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
+        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
+    } else {
+        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+    }
+
+    if (vdev->sub_vendor_id != PCI_ANY_ID) {
+        if (vdev->sub_vendor_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
+                               vdev->sub_vendor_id, ~0);
+        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
+                                              vdev->sub_vendor_id);
+    }
+
+    if (vdev->sub_device_id != PCI_ANY_ID) {
+        if (vdev->sub_device_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
+        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
+                                              vdev->sub_device_id);
+    }
+
+    /* QEMU can change multi-function devices to single function, or reverse */
+    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
+                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
+
+    /* Restore or clear multifunction, this is always controlled by QEMU */
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    } else {
+        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+    }
+
+    /*
+     * Clear host resource mapping info.  If we choose not to register a
+     * BAR, such as might be the case with the option ROM, we can get
+     * confusing, unwritable, residual addresses from the host here.
+     */
+    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
+    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
+
+    vfio_pci_size_rom(vdev);
+
+    vfio_bars_prepare(vdev);
+
+    if (!vfio_msix_early_setup(vdev, errp)) {
+        return false;
+    }
+
+    vfio_bars_register(vdev);
+
+    return true;
+}
+
 static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -3060,91 +3153,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    /* vfio emulates a lot for us, but some bits need extra love */
-    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
-
-    /* QEMU can choose to expose the ROM or not */
-    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
-    /* QEMU can also add or extend BARs */
-    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
-
-    /*
-     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
-     * device ID is managed by the vendor and need only be a 16-bit value.
-     * Allow any 16-bit value for subsystem so they can be hidden or changed.
-     */
-    if (vdev->vendor_id != PCI_ANY_ID) {
-        if (vdev->vendor_id >= 0xffff) {
-            error_setg(errp, "invalid PCI vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
-        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
-    } else {
-        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
-    }
-
-    if (vdev->device_id != PCI_ANY_ID) {
-        if (vdev->device_id > 0xffff) {
-            error_setg(errp, "invalid PCI device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
-        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
-    } else {
-        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
-    }
-
-    if (vdev->sub_vendor_id != PCI_ANY_ID) {
-        if (vdev->sub_vendor_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
-                               vdev->sub_vendor_id, ~0);
-        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
-                                              vdev->sub_vendor_id);
-    }
-
-    if (vdev->sub_device_id != PCI_ANY_ID) {
-        if (vdev->sub_device_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
-        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
-                                              vdev->sub_device_id);
-    }
-
-    /* QEMU can change multi-function devices to single function, or reverse */
-    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
-                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
-
-    /* Restore or clear multifunction, this is always controlled by QEMU */
-    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
-    } else {
-        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
-    }
-
-    /*
-     * Clear host resource mapping info.  If we choose not to register a
-     * BAR, such as might be the case with the option ROM, we can get
-     * confusing, unwritable, residual addresses from the host here.
-     */
-    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
-    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
-
-    vfio_pci_size_rom(vdev);
-
-    vfio_bars_prepare(vdev);
-
-    if (!vfio_msix_early_setup(vdev, errp)) {
+    if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
 
-    vfio_bars_register(vdev);
-
     if (!vbasedev->mdev &&
         !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set vIOMMU: ");
-- 
2.34.1


