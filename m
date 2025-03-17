Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F1C28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 01:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttzfQ-0005bY-BI; Sun, 16 Mar 2025 21:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1ttzfO-0005bM-9N
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 21:53:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1ttzfL-00087z-GC
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 21:53:22 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GI5u0a022866;
 Sun, 16 Mar 2025 18:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=zUNsqEhHhm84M
 Vq4/Ntc4l8AD+6AYeTy74c3ZvbgP/Q=; b=lcND+mvw3fOSbvr1FGGYL9wy6OC5s
 RdT34wMCiebrF4/cHHayynk+PDpa02KF977aZKJXGKj9oGZame7LkquQonHHpKr7
 Cmek9iBHhFV1yNDGzPAFOUC7sahoHS4pfTOWJOoE6UDwQMDEFBp6YORL1u65VxN+
 szuYwvkb6aKK2ZlNSvvPPebNTt20Kub3HLLVwqTEDvq8u+IDfgOGkdCmHT3vbHib
 HJLg6KUpyBdtX3eF4Go/tZJTxLvWCXNxM81ygUhR+RccSlwwfum62MSM4DjAKMrU
 tlX1IQyuju0sGT1UDFnIJ6+Tfd6HhmfK9lirrr2hJRLQf2v50zVa/1DtQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45d737a20a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Mar 2025 18:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC1z5cSRo8+pxrc1bJDeN6bO/RqSonXsOsSpaGwLegxaoQYTniULppnvytLyJkAlgmiSoq9wq0ZVzPcSjAI1Bx49c6Plksq7BkcyueLJTb55q+Th0R4MFazIcuCOMZza9F9YWLXjrmJySOJIesso3pGOAkKzmzWN7odkGdhF5qgsJZgxRtJTxpD7DaXPl3kglVw91BkTai8Q1Tekc3cUiYyllgNRn6LAMB/rETd6VHzQrN74pNanbx0ZrDZ8c4NsPzdPYF33EfXtYOxDAg90V39FS0Mpxx3LrNWjjcAgY7tNodMrt8hCjPvO7OaQj4UIu3VXw5a2rQ+VidZsEEDPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUNsqEhHhm84MVq4/Ntc4l8AD+6AYeTy74c3ZvbgP/Q=;
 b=O25+k4yaNDhMElyyN1xsz68OKnfc0zNtEI/gOlXmGbitHTVwMEs/IrohvHwjIq6EhZ0np9mRvN6q/D68iHO+5jC0rBpOc0pLTZf9kRz5crEIqRwe0mS8XrNpFB2q2x74wKBuWr3O2f8sKTbhMDboqQkExcxzhpK1i0KxxdEu6khdJ6ARZRbXdSLrjkTUbf8/vfceI18DfHiOxs3QBWwFQdtDcF11OUPlD0ljjNgyOgEmm4tlFHXbRv8uJFwbntU1ukhr3B7QV24cUKPg7LKOfK287YK4N6fErdfRTJlMpBfJA0wIspkf5A0/slJ2sonVwV3hXky0epok15wDN5ul/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUNsqEhHhm84MVq4/Ntc4l8AD+6AYeTy74c3ZvbgP/Q=;
 b=YoGHagbVy6LJRusvBgzb7ph6KPzPBh40CM350qd5i619lT3YoU9278fy3CH6QYbTGHyvRJ4RNcFcIruyPxCRvuRCN3RaDahKxQKvJIqrnkG5U4cqD1MQmQNqUNPtN56d34gU/Am0LQZ8GKy0YhtxVC+vR/pTD4Dov9BpSuPy/F7jnIpC4hvvOp05y3/yittimnrKpJIMepDuPrBhJRWfrbQItE2YXgKfWJUrSrsJdLFNZg2oTASn4iRdvJq9Eq5d9DLAtGF7KP3nUiUlw6P3jUYWQatu1I1z/RWGVGVe1MUqizkny1/wK8GlXyqn0bsvHJsT+CZ0P76Se87rfiWQoQ==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BL3PR02MB7889.namprd02.prod.outlook.com (2603:10b6:208:350::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 01:53:11 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 01:53:10 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, leobras@redhat.com,
 farosas@suse.de, Manish Mishra <manish.mishra@nutanix.com>
Subject: [PATCH v3] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Date: Sun, 16 Mar 2025 21:52:31 -0400
Message-ID: <20250317015231.241141-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|BL3PR02MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a83f27-48a1-4114-0ebb-08dd64f6788a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SB7GE57I47HBFBo0davBSoZezOZ0M666jst+As9vTOjYHQLKa0FoMqm7p8bA?=
 =?us-ascii?Q?J2sR5J/tfIJhGA+IU/8IGyyl/eYIQH4JzBLNb0ObzN8SmUFcCOVQKjuTVN3H?=
 =?us-ascii?Q?2/45SeX4j/E9+N4b5P1MHW9EOXfwDH413ZWfFVyqHjlBQyQPKdnfpBRT/MXg?=
 =?us-ascii?Q?mfx261XNFtFeuOjD3T0qgjMNd8Pd/OTurZ3ex1iSUUaRu5eSHdpCvxRZxOxd?=
 =?us-ascii?Q?DhyyIfrwpFaH07OIfZRL0dlaYr76RXPnF/s3qCqQWwS7C7/8JONBaYy1O3eT?=
 =?us-ascii?Q?23KhoOr7FnOtZk3+lBNFb1F7sQl9kmv9KolRPSbOySEcou08qJ/c1iR+j5Gu?=
 =?us-ascii?Q?oJaTaEoM84/tFqcUrPUb1JNjHSqtv71QdzlOiqdkgBJ7ddWtZbosWRtRDK1s?=
 =?us-ascii?Q?K6pvt11U9oT3XQ77Ujgg458EhlkzodEkHvcT+wh+fMy/Ug+9Hoyk6Kzb4a5S?=
 =?us-ascii?Q?s7RfFuwN1WjunovZP7oL4MR6zwUQ0kOzBMo8fu/3mat+tH441wCiA2J8+d1G?=
 =?us-ascii?Q?MyKfyJdt6MNd2allF5Irpe8TWGBYw/DiG7zTRTkYH6Ww1WT5jTj4yov932Ig?=
 =?us-ascii?Q?i2XdsxLsrd6PxAyB925+vZjnq2uu/xw0xHpozFSEd+EraKOxP2MuBycLP/mC?=
 =?us-ascii?Q?Qm8pJVrQvJtH+olxkbOa4MDpx/cBAYxrYhG66L9JZIdzGJ+XIG5fgt80rZPX?=
 =?us-ascii?Q?8yCCFfl/EuQuJXCwq3C3vKxDT+TtbtaloGwURgR9Z7L0MYfHJAJkeZbNmsfW?=
 =?us-ascii?Q?ZzOgkdMJD76edpr0CD5oKwxMkkVghJbJv9Jj51+PjopOzRcIDaLSZsrQ3xor?=
 =?us-ascii?Q?RptyNSNaBBj8g8sQkYSPtlAaf+UgArzNV8hcwD9sqt00xphylwQ/vMkzJyIc?=
 =?us-ascii?Q?DLP8VLA5x7zuXyRi1WNNXUaDli3EyQhizGzM96gi1+tnZm+C+4pLVWM9c4e2?=
 =?us-ascii?Q?0gXlf7Hrg6s257yZruWNuSCYlOUieBiIbCRmcH3Ng28JqC9JicPb2JRaeYqm?=
 =?us-ascii?Q?gquS+goJERvNveIjY1z1APuN4ewipYIxBtRoid5d4ZAXTP9JiOQYTHjt7EcR?=
 =?us-ascii?Q?cD3kR/qchR0F6Pq+TPO/ugEBPNsegbSygYxwSNFcXBl6o55wLiiGVf//LMY3?=
 =?us-ascii?Q?NFwrAw1T22UXZArUZfubU2UkeJK3ZgKCGm22Awf0nwqZj5bkMc0wDUybI+aO?=
 =?us-ascii?Q?gQeq7KTsJPHRbp2wjSSmkzAktHqeWsvZKNiVWb9MoKCOENEe1WaAy6XUYDFD?=
 =?us-ascii?Q?KU9zZ04QEWfU/w5KqQwT73XyEDyNhY21F1c1pgvsNLEAupYfVsZAajz5hTyw?=
 =?us-ascii?Q?25CP5srhTLIG1Z1Q67yNwfWB1kkwqqt4HSUSfljcP5wL8CYFFBj0hTa9u18M?=
 =?us-ascii?Q?s4gfQm+Hi0WkBIjFgHwEfKPUsCw0fGCeFmgS+E67QhvwZTUc7NLWmGDqGVAE?=
 =?us-ascii?Q?VAybYrqQFVjR6XCjk3JU4qOyAp1fSKed?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/Nqq5tvZJy6vCM27sgtohASIRdVfy3mAlwZiU/4ETzrYST6kj0F+d6sece/?=
 =?us-ascii?Q?dAp77t4ccGKNBhjo2sWurC1cN9IoYzsMYFsntjotVIa8Z4Girm6sQlDrhGth?=
 =?us-ascii?Q?Yp6CzvVZt6+67emHcHacI6DMAUIxAFxrziKaU/T1mKLoIccktPLrNoKeqwW4?=
 =?us-ascii?Q?I12KGZelab+isasiH0mjjfNy5CF0SzQQugFAV4eUtpDTCF2c29CuIX4ds2mb?=
 =?us-ascii?Q?jgYBSsk+hf21ZDnW3s8mp4dmkZiXUguHcKiGO+i2vWgf5efv7IIsjOmOecx6?=
 =?us-ascii?Q?u9rUrbW060DfuAqqxH4v2nSjSsj0pDDrwHy0HKdac1wDVF59ejDE8FNpy31p?=
 =?us-ascii?Q?EnMDrn3RaCx2Mx6iC3sw34Di6+TGtLJ/S2gi7trSC/zTUF+yGYil2T4kBKq0?=
 =?us-ascii?Q?6GztASzh96dEVSneQtbTXdYPbCwc2KIuBo5nhibdHxaoSiwLFWn+0qC0lQ28?=
 =?us-ascii?Q?5aJRwMOzrDahb8CB8jm7QfbQlnSqkXwyKMwRyWuDwc2mBOjId6u2HHnHZhg9?=
 =?us-ascii?Q?3eZKMd2DUtvb0hy1gjFcTFlMWw5lZujA2lWRBEUjHHwxcUQ6sezJxdkFWovh?=
 =?us-ascii?Q?xL3JuRA3tNQXzWiJbKjiRvdvh9Dn5vfd9X9ILl2DDix8HIe79fruG4JmrwFP?=
 =?us-ascii?Q?J8LVVoxCdKAHpT6hT4nYbwB5v4sQpcUTzqpFW2OcWzSY2HT5ionqj2qjh2hM?=
 =?us-ascii?Q?cUrlkVxPzd9p0ZXiNmEDqOGDiPsx2fxWH74QQq5weyM7DAYgvIz/BWbFO9Pv?=
 =?us-ascii?Q?jWmTcHMns4UxpPfvB6wFRWfEpxhtYh//9O/ICyHA62jKnKXFOugbzmpoG4xj?=
 =?us-ascii?Q?pLQVVt5XUdWU3MfF/fyzpMKs1/vYzpq3iZW8YpcQgTWNkl+ZLDKGeDlCJMjK?=
 =?us-ascii?Q?p5iU21JScHNSqaYJl9NGj3Av84pUFiMS5lSN1+oYq470Y4phjcViOsB7sZ/i?=
 =?us-ascii?Q?04deHFeU588r9+DJcbIw78JcsL1yHWgwDyiLz+97szsIv58DmJVAxrRLWDJR?=
 =?us-ascii?Q?mbp4ZmGSfbtJvnU7H7bUeAwU9ZXltdeXAa7NSIHMh4sw6Yj7rVMu0fHTA+X3?=
 =?us-ascii?Q?JSrC07xzTyN0gAiyySsuFKQ4/4WmvkhCfhm9/B2M7VQqQFGfaj1mRW1uEdSc?=
 =?us-ascii?Q?lu1Nq6xZXlSZh9puz8j2Wbg4pnY3HlSN53YeWuD/Voox5n28tUNT8u3OPTG1?=
 =?us-ascii?Q?1PkTQdn/9PIO69MoA792A8IuyUG1Ml+3j68HYWUKvc2GaEUQCIXo6SwJvwX/?=
 =?us-ascii?Q?rISwQ2tZg4IbzI0gJjMsMWfuJRaJrBtc3dsKMfj6yINdAM0kRdb7hM5lF3iI?=
 =?us-ascii?Q?wVB+A9U9QKkZmyI9SHoUzigDe6RtSpPzrYtH17PVkUqqBmQ8RJf6vtcB8LoW?=
 =?us-ascii?Q?DQ8dSZNjIx6hzeQEiWQgzbp1qVeLkGOjV60UzMmewz931tPCIt70R8VrfVYr?=
 =?us-ascii?Q?J+geQwuxQavsC+F5QQBwSuczLdGSqyF5daGGXukOqQjlEl65+swe/ih2f/Tw?=
 =?us-ascii?Q?PXhd+M14xqvIFMpD1bnEQeOX4aP56/Dse+3U5NqeZ7EJ3DUK8cdhuRASQJSP?=
 =?us-ascii?Q?ptksfYOusDmhDOa7lpykWoqyZndUBfXwfm41UYlrxL4IKw83/h4hxOkTlZDx?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a83f27-48a1-4114-0ebb-08dd64f6788a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 01:53:10.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zec/KX50R8Z3Up7dStPbzgSuMnHsYJYWXke7HXci4jhRFs+CXhRnHqGu0CFGtOZSPoXwyiX5d8iQS5am4zmgjz8Dr1inDKCYlC2TsdtzoI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7889
X-Authority-Analysis: v=2.4 cv=CLsqXQrD c=1 sm=1 tr=0 ts=67d78089 cx=c_pps
 a=lNr+GoA8Iy63YGCceF2HJQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=TAqZmyZUDpkzjPXLcQcA:9
X-Proofpoint-ORIG-GUID: vYhcU8LFpbtSoYnjQGySoBpOXXZ2OHcu
X-Proofpoint-GUID: vYhcU8LFpbtSoYnjQGySoBpOXXZ2OHcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
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

V2:
  1. Removed the dirty_sync_missed_zero_copy migration stat.
  2. Made the call to qio_channel_socket_flush_internal() from
     qio_channel_socket_writev() non-blocking.

V3:
  1. Add the dirty_sync_missed_zero_copy migration stat again.

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
---
 include/io/channel-socket.h |  5 +++
 io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 14 deletions(-)

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
index 608bcf066e..604ca9890d 100644
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
+    bool zero_copy_flush_pending = TRUE;
 
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
+                if (zero_copy_flush_pending) {
+                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
+                    if (ret < 0) {
+                        error_setg_errno(errp, errno,
+                                         "Zerocopy flush failed");
+                        return -1;
+                    }
+                    zero_copy_flush_pending = FALSE;
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


