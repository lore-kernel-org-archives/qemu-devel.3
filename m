Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8326C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAZ-0007ky-Fl; Wed, 02 Sep 2026 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAX-0007kN-B8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAV-0002Aa-FO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CX8DI1584329; Wed, 2 Sep 2026 07:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mdrTOtc84lnOnlhS6IQSiWQzEPetwysQIDqh5YhKc
 +k=; b=XnrxVUuaTiKiTS6JLWLzBa3tuFweMbelanz176BClUjyMlhLcLjslvgV+
 DNHpITlTjof76ca6tse7YNL7SU0xsKKr7R6wZSvr3gO4Dw0FvPPFDVyWo8Ul7kxC
 slcRk/Q4ZPhjBjCfLnGb0dUnpEYFsQyA7hh2hhO61CFU+KbRrBB4AaNEvZodyKFe
 NPxjWOCkUy/6lTjwRyknHSN3ESI3I8CiLAzeqw5n5Fxr5kTkFRPcp165ZfZQ7Emq
 RLO7IJu3qmTclzY13iu39ujs45XpGA6TZaivxOLXVVGL/dVSqn9U72rYPpY5VKzs
 Kz+0L934nOJhkriBA/GjLTOOhZhFQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020121.outbound.protection.outlook.com
 [40.93.198.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gdw58bs0k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzrH/1rEiCey/dgtqP0h9LpZ0+86ZPnESc2cD9yMrM3j3SuaOdadCUHwFglKxAhlFfepKF8JzN/mXBFIm3J0M5cUwPEKBeVZogv5Vmt+YX0Y/8+iOaqy78d+QyprJhVFpfmn8zmLHw9SGMSgTy7M5xqgoftNq1G/M5gVki6tFFyUywOknxoRV7pfhOmT9/tZ93DZ7iNBIGVs1dC4YSfUdzSmR3cCjRk2IThTOiW8WZRyQxE4zG2OFAzEcRHRAuCqpcbit2QlEWvgNgDKLDTCydY0t47gMOyqoUPQpNdTIP2ukpSy80XbglbK2DAWdcDFzBq2FjKJdpUNBX52CuW4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdrTOtc84lnOnlhS6IQSiWQzEPetwysQIDqh5YhKc+k=;
 b=Zd/QJbCHIUwfsDB9cybr2Br0QC1vGhtOCCNo/Sk2W71w7yojS+KNOLa/Y8ztDaK4idJ+jJpcIhszIjRMzKrQa2/hMChJMEA3B3QaIlqS2BRF7lpk7NYsRWmZv0162v00FjtCDlEkPm5zhSV2O6n+A5hNSMKKaK6+qukJxYlQVWTRQtR0/rowZNSDU8lavG5AsSGcVllWGkzQSVMNhS4yzrjvo9FtDOO/bXbEanW12QKD/8l1oRqHxMLZ/K1cK6iZKg049/FGHwK9qhQ1IU1ca5l2zE18opuoJqSAgICux24kocJ3nxVT1FVPxP2/FtKuLTVVVa1FdTInjUE+IsfKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdrTOtc84lnOnlhS6IQSiWQzEPetwysQIDqh5YhKc+k=;
 b=k5Zu25MDLDyGX9fw2DKufxihqS1skRsEF41ACj10xLS4yxb6VWpJTr3+MNB+FCJoFbpG0K64Gna+urxujJsVJTaS2LZQ6yy/gOgcs7QRu5BJgdgcA/3WxSGf7dXOa1hJ0dgnMAIFddzx/wTooEZRflGS8KA9O3zRRYUv/dQAYcUMIoG/uNyLHct+bhF6Pv3tL7tGYLlZngboWErygIhIZ/hcqshmSTs3ZgQKZiqcpaPZDgRRpO5UVfFXx6b7wazKxYR9Amt7LEgCMihECMHXgHH9LIyy05FpjBf15B20eerdtSUbTvBjQ2Qq1vN7ex5Nq0moRLBVVIeji/L/QPZvkA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CHXPR02MB11331.namprd02.prod.outlook.com (2603:10b6:610:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] qom/object.c: introduce object_property_set_alias()
 function
Date: Wed,  2 Sep 2026 15:40:50 +0100
Message-ID: <20260902144207.2553037-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CHXPR02MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 76026b22-e8bb-441b-7476-08df09006649
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZkN1K/pKS06/BRrOdheQgYOuIVTtXphDOLGdkujkLaFlR4qGH0/5TeaDqU+Kg3gi0lvAiajJkw6tiKkTlpsv0jkW1cB/y9NKajrkQ/gyaKJV9clUiCHzH75kb2kWvrkDV/2jXO4O+16UoKeLeuja9Jk2zIwm5/5ids8pCEu5zvd5sWI4OtQrh3WMf1vkYIWRA3GoitCILvqgUfjv9RkP9xPkrqOOtLk6vfjCDuSwc3642ZVSksP6zM8XNJP7bziyXMhrDqN4Biv/kPkdIspXwGcC5ZG6MEMCcoqTDZQ74HjwHNyTTUybUrrk2a3uW+cz2yifruWZ+uuFeB6d+Jqfwvkwc+fJ8mw4esypzgoN2f8QYbG/i1Z31T7v4x/TP+hzZGAvAzGmuXaj+dPqTSRfap44+0f5+rftA+tfrzH0Z3D9KXkFqAmD79pZeV4wNNqy7LhvRcMsz27NcoBaX4mGoa5tQcGoYSoKfinAb8EmypxJMJmz93+xalyNd4usHJK3umeZcd4c9Al4BqeVtazUdUILSgUA+B2SrSX41l+CnRCI//2xrrvFrknxM+5fYnCqWSIB/ObY2kITdhK99GBGMYdjEMDhAtCP0KMMPgRC1WHopmtO40CbBBW5EgbbiS5wZ7haiXYROFeuju3g5VPGDauj9xmGhT6LqNnlewbwGyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ooisRH9ziQAE48F60NGS+CBmbcWfPHPztiEq45lF28TYnCXriQyGZunGOkCI?=
 =?us-ascii?Q?LL1n4mff0H1rW16k5MDrWFIgII6f/55a5p2DzueluZVa5CDWnG94Z0bobIyJ?=
 =?us-ascii?Q?ccIil8lTc+9g1Ko9tOBG+vcgCehNHdZMHnG16nUUrR15Qr66n5eOl6K8giQl?=
 =?us-ascii?Q?HrZI3oAfmwSnrqK8fpoEM0wgCe6kJYkvc5RtShWQ+V/nQphNHRE23Z+/yGJi?=
 =?us-ascii?Q?bE4ASj0B83Xz80Zzmv1kg/WEimb1azWAK2Mn3ZWGcSBU5Ps1uZc8EHMpSvOk?=
 =?us-ascii?Q?VumwOE882wQtzFjPrAHX09hT3BFx79llTyop+6h6kMuWETzB2i8G/nVMXuLi?=
 =?us-ascii?Q?7N0C81v2t3FUyDLOgllHN1jSQsakXH711zhbn420CH/gsoPIH40QHmk7CVfC?=
 =?us-ascii?Q?flslV7+vKsWWnDg5doJ4zoNv+rtbmjZ5SBOWFYgqaaeCSU9F7o5ed/m196av?=
 =?us-ascii?Q?uMuoNYtbxD+ZtMBjuPeYtW5lYy2wGzsN5dR103T93TzDoMe3KTBYk00qrItW?=
 =?us-ascii?Q?CXbR9Sf7ldbHJzubYS64uiLKOGGBhYkX16Z6OlXysESJmP+nTHD+1kqxrB68?=
 =?us-ascii?Q?PKpfCHM847sGgiQMxZCblJ2XIRJ3urMPC6GPiSoH0tQkQUyP6Sww7vKjUTp4?=
 =?us-ascii?Q?OWcECcyya5DXmSt+4OK/FP84HSKH7DYjw0GMMysLEmYMFvAz9YHg6jKYHTqg?=
 =?us-ascii?Q?i25ZOYRR22Pgg62jKd9YsQlzDu2+C2spXb2njyvut8hVPyBAZ0iNvJMJxdn2?=
 =?us-ascii?Q?9BL7CBgHIqBCpOAmKj73BlP1gfuae1hoTKQALsz+QX9ZsIx8qX8t/BvORYlv?=
 =?us-ascii?Q?GrdShcdd1HFfDlVgCoQriTqcVA9WvmnBqNpZEmUVDN8Bk7vcM7Da2Laxl+o7?=
 =?us-ascii?Q?8+N0MHxGgraSxgXIxs2fULuRcrn1scbb2zdGXfTGEIuIfLsFz3gthPlcZASb?=
 =?us-ascii?Q?oGtfNrosNP9JpXBTAS7Cct1rfoiSnJK9XXtDhxjeyNJG+pwGDrjpCF9WPAQy?=
 =?us-ascii?Q?FHDL4iorDr3SCSnEgXC2Ia6UxN0qbljZs74ZfBeedjX9rtpfoP/3fdcvka9P?=
 =?us-ascii?Q?L3zJxhEn8ShS79p/E6Q5cKuD8l0HbLuKBkq08fDnR2m7fkUEtDIErtQm+dXa?=
 =?us-ascii?Q?OpCgmwnJiX7qAhJETgwBgdRCKJ9iCvYR0lvhEM7inVc0sGoys3ILfdQo1h9s?=
 =?us-ascii?Q?32ZODgiwMd4E/++qxBJlaLZmA7lNKrElevtS42U1LO9yTSMT9W3Glqz+oxSI?=
 =?us-ascii?Q?wLHUj8zjNPMxxwd1rV/4opz7Pj2GCGOwpioLnKrkUCV1LS9S0XNRtQQozbiy?=
 =?us-ascii?Q?UL7jSd4EMfnKGD1TMaqTsAwa55qZA71PQLtKVclLrIoug+kaxfPWscL4P6tZ?=
 =?us-ascii?Q?glLPi/NUtQw7ALfbx3Qe4sQ/6gF4LkNKhWNV3L1iI7LUN7HtuiWeAbDjYkmb?=
 =?us-ascii?Q?tsJf9RoKi13YB9sqtZOj9efoNeAwkToptwtAq5S5rNKRKxzslK6zh2YSBaWT?=
 =?us-ascii?Q?PClbQrfTjCeGJhwVkwS6os/uKR8zhj3wNdiWuH6qaMpw53bNNgwihOE8y0SX?=
 =?us-ascii?Q?SoBqf/vtD1QxkjDVlzpi70bifkPMGT86Y+N7tQWp3lAVjNWW+BU/JePZ1EAV?=
 =?us-ascii?Q?orBTs/iVfvypXmDXeKfgGdjvpVhzXurWlDUgBtZ8xCXP6GEH4kL/WjcW/rl6?=
 =?us-ascii?Q?IGUXr8z8GZKWIX7Se5MTiVbG234aQT4sOzUXSeGm9JbSpOo2X68+zYyh80t1?=
 =?us-ascii?Q?5SUxXgehx9wnckzX6NYC4nD0ocU2yuw=3D?=
X-Exchange-RoutingPolicyChecked: CxdNdHEqweRIz/zvLoqZ7lSDjp1MSsibqFdFRfvldaq1ozE3wBZdv2wmp2gzvM8hCc13B0GIDD/t8i7VDQ68KtT8dXi4WVN3wSN/1/2s9z4tSWofiauFnX6f59axaBZ5cTXMUqc72Q1LHt/I0ayWHwJ6p8TfT7hpMJunGU/HOvP7dX8PZ+4tFHozLvhA5RNX1b5T7ioPJVTjD+AamsAOH7+0ajzeulQcFQx0TeII+FmafcwY+awlMjEHzAg613Fved5XnnPvI/RlIchun4y7TU2sP2WYgBIVUxGy18MnMlvexiXw56XUaJE5QoiKjNCpdRiQpra9ldsf3LTRT3lVSQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76026b22-e8bb-441b-7476-08df09006649
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:23.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljKMXdiEVSpvQ3WYvvhfXFxf/6xb27+kJnYc3uwe8D3RtTiFMUzLaHfD/wmSUKIfg6L0gvRn30c1bwp2Mw4kUess/xGKV1e7uPmQH7Fl7Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11331
X-Proofpoint-ORIG-GUID: qdBghC6s1mo6dUuC4ddtSTx3lhJrp2IZ
X-Proofpoint-GUID: qdBghC6s1mo6dUuC4ddtSTx3lhJrp2IZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX1+89g4XERwFs
 2JCnPkegISlLl708SlkxWYRoU6RcKzWs+rWaS+4e3uKIR9Am2wehYHEedXRllBDHvfJVspHABco
 zZSB89dd/8m1KRdovRAH5/7ODGMMDidZ54be6f+DHO2qRlq3/Ma1qpicCqA/Si9bkmC8yVY+/L3
 ffBw/f4c3SQbNwM4m3wy8UrL9/qhw0/agZLITAQJOmmNj6AYfC687/MOsD3F89KVkwxtDvpC70C
 YEUaquNhoshr5B2xfkT/B3eopYFcadfKKLBZJTw2uedxjDSMyaYsUUsQGTMhxhSgs3P2bW1Abcz
 tBRaVJfqo4khGc1/UYydPVe14l2dJnb54IyW6LxBxF3z1rQT6gr2kMrs97RQZDcnMQU7FNTBq3Q
 f7tDoLbJbWRCB8uNakVTk92B1hJH7qtgrNlXxjmjtdqxo50yhaDNCyRckDOGvbHTI5ks8poioE2
 uLPz1kKDVUkZlOZNVrw==
X-Authority-Analysis: v=2.4 cv=fZqdDUQF c=1 sm=1 tr=0 ts=6a9835d0 cx=c_pps
 a=cKBc+2/Vqua3nEp0WttuKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=cNtrz4puXHHLzHPMHtoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXybouXLI8bZ5f
 Yl/SixlicjiVmgSixr7XGH5Y0WIXy13+mEg4N+ZI7Fy+COaPjYmbbwJMo1OeYmG4+AdX1zkVhLA
 u/PXIYgn24mFvOWgLQBgPNubdFo3dc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This will be used to set the class alias property for a specific object. Note
that this function is only required for class properties, and will assert at
runtime if an attempt is made to use it on an object alias property.

Update the existing property_release_alias() function to reflect the documented
refcount behaviour.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 96c76975ef..bb65218aa3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2308,6 +2308,23 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                 const char *target_type,
                                 const char *target_name);
 
+/**
+ * object_property_set_alias:
+ * @obj: the object upon which to set the alias property
+ * @name: the name of the alias property
+ * @target_obj: the object to forward property access to
+ *
+ * Set an alias property on an object to point to @target_obj.  This is only
+ * required for class properties, and will assert at runtime if used on an
+ * object property.
+ *
+ * This function ensures that @target_obj stays alive as long as @obj exists
+ * by taking a reference if @target_obj is not a child object or an alias on
+ * the same object.
+ */
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 9a05e189ea..51d21cf1d0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3116,6 +3116,18 @@ static void property_release_alias(Object *obj, const char *name, void *opaque)
     if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
         g_free(prop->target_name);
         g_free(prop);
+    } else {
+        Object **target_obj = object_alias_get_targetp(obj, prop);
+
+        if (*target_obj) {
+            ObjectProperty *target_prop = object_property_find_err(*target_obj,
+                                                           prop->target_name,
+                                                           &error_abort);
+            if (*target_obj != obj &&
+                !object_property_is_child(target_prop)) {
+                    object_unref(*target_obj);
+            }
+        }
     }
 }
 
@@ -3202,6 +3214,35 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     return op;
 }
 
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj)
+{
+    AliasProperty *prop;
+    ObjectProperty *op, *target_prop;
+    Object **target_objp;
+
+    op = object_property_find_err(obj, name, &error_abort);
+    prop = op->opaque;
+    assert(prop->flags & OBJ_PROP_ALIAS_CLASS);
+
+    target_objp = object_alias_get_targetp(obj, prop);
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_unref(*target_objp);
+        }
+    }
+    *target_objp = target_obj;
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_ref(*target_objp);
+        }
+    }
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


