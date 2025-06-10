Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB09C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Ga-0007jD-0Q; Tue, 10 Jun 2025 12:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2GV-0007LI-5w
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:55:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2GT-0001rH-9u
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:55:58 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACPgO7030320;
 Tue, 10 Jun 2025 09:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1s7fF7vgd624aKKNgkjbEfBT/MCUeqzU0F0FttuAj
 gQ=; b=q2MygnuQY2vEGsz+heQRJHLdx4lU8G3KiF9kTYjYx1ROfIPKlJKrW4jTO
 FsSWYFSeCRAcDEi8mz3Cu7xOgm/hq75UVkI7BubPf/ZDdRUESjLqkNhXLb39q7sN
 KTFA9DGO1U4IrGtlcLlWr7TEnfRd1Efb8yNJnLQvPd3raqkoMyOah1vc7cPd9TDP
 dC+XiOPpe4YhQWqH4OR+tonGEeVWoK8COjyAt0vp8vWlFxz1H396QAPnSuR+dNWS
 8s7Q4fo7Kn1doBjQVjlkA+AUINyg7MX726kxE3oJ8q5ZZxbvRKLtB9U0GBY0sfBi
 aSUknDAhg/oo2HEGJOURb/9NNwH8w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 476mpx0r0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 09:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBmNWeVKcDCKItDDwTKtg+oZ25lqHyq+czGIsjGZgk9GrcFWEXRwfZrEUGBcaJ51K40ClUyAlPhgGWpPVO8pRo2OXzWNxTTVRs68Krnf8ezYDOvYgD0L8+p0+XIACaHFJgDTcS5BBRxI070lb6I2TAILlvp5sQ81lvPDBRMNG0mrbxobyISv3tG6PDBBnv6GBOwbGrwsfgeMaXQx3i+cZqlnFrRQXb1wgSec1wPSnwi651M1aaw+ZZ44NV+JqAfoVvJqZSj+FZJ46cXsfMTrBVg8JJT2CvcXeY9dlZFYYsxSZxnlUSAZ8BJVepiqQ3JZG8FOFxJWZgu8jb7hxPoVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cegyLoxmSvfQD9iLXgTbn8JbcrEAQDy8WtzC5+WEXMU=;
 b=pEmFy+pQZlI9LoT7fo9AyYW6D01Y6VDIUxQlY/cN8m02dGdJs3LpCcI+IgR7loBfqv/91WejkwR8YqxcPiIQ97dSKullu+hHj6JU85Mo5QFDA2y+Cpfyv6CpabOcx0D/p1kci5GsGFNa60/oplsAWDtYBgDAQWaKYZ4MFNegmOvUWiqg25MHJk2qOiL2EA0H/vfSCv6Q3cLXuYEiNN4Qrq8+jK5xamQR8qyGcqlm2FOsuq7RtnWTV2ocB9DplzokFwP2fkgonSxc0x6p7cCSI9g1WwukluDOU/E+FwOHsgMiScXZ0E1IXE8mVehFkIvhXHkXN01srzVyX8XH+s6oAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cegyLoxmSvfQD9iLXgTbn8JbcrEAQDy8WtzC5+WEXMU=;
 b=I3/iEhZCyh5iT9XviAtA3b/czwr0iveUy8Lc6Gl8BP4R1mS/LfuF6Pq5MQE+7fONwsrpR3Ybeoxp/ohf4zKUoS/dNyXt4gvMwoBCvTkv1YndUvhPvuGIj/qWrh/pyyqwW+RdoXf5lS7EEhYH8EOpZ2PgPjDmaZIECOvyY4Bm9fNLHNrpM/v7VHA6o7PbKHW2Pgy/lTwoXLJ5wEiajEgnPGoLwcYEmmdXEKLH6nEg61YH0r/4SIngwv9jaApMnLYdDs4eDxHOhYLGX1jin2TIOsGw1oT6UszXd8yLFX6yKqGSS3FJd/qToCVxEmkoLGQOStnEfasoUQI7lQCugaAsdA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB9756.namprd02.prod.outlook.com (2603:10b6:a03:548::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Tue, 10 Jun
 2025 16:55:45 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 16:55:45 +0000
Date: Tue, 10 Jun 2025 09:55:41 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 05/23] vfio-user: introduce vfio-user protocol
 specification
Message-ID: <aEhjjdtTVZUFCFeS@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-6-john.levon@nutanix.com>
 <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 791d0682-3f18-48be-6da0-08dda83fa47a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tBRYmvEcVvqDNrbji78gRBvEyuL+1EvQPEQWRt7zXnNxTzhN/uysW1SKbk?=
 =?iso-8859-1?Q?JcavMLTuCiTZo0OXPsGWuOEVm1laSHNtCZr7O2bkqHsCNdLjMvdfG7Jnu8?=
 =?iso-8859-1?Q?/f6X65tKjZJZ9h03f5sk/j1REeDkv8cktUH9rFn4pJR0Ii+59Oa9kuqUYk?=
 =?iso-8859-1?Q?lF3UaSMx/eA6k4C/WF5jROOnKKVsqVmoTYsJCuUmidzUJPmMYM0QFxQf2K?=
 =?iso-8859-1?Q?NGJTWTsfnemUU7gQQayEupkynmfqRDw2UXZ3pxvzbAnXhKA0WSc9hyKAfL?=
 =?iso-8859-1?Q?HqHLreGTke7alC0g8OwJP1ij9i2PFyRvgF2jIo+Y+OBZIQTyZHnOlL/ImD?=
 =?iso-8859-1?Q?L0b4zB/Zc4OwTelEujWTukokTggRGA9YuMJQQV6w/R9Hn1Rxoo7bk6ryCl?=
 =?iso-8859-1?Q?YWzgkUKGkrAxIbniTMUD4yWJ/w9YjAsqIea4THSDu9ZPz0yH/JbrQP6lps?=
 =?iso-8859-1?Q?NDbO7AiGVE+1gpvAiok0EJn9KpokHH5r2DN0QlZMfosBMmbbaf6hPb+S2D?=
 =?iso-8859-1?Q?d8IMq+8tQGvLGCw0Y8pg86rNuzXtKbXWnprhPX5PWvDZ3gCoh9CXoMsEJj?=
 =?iso-8859-1?Q?zn4Baow/q3ABlUDsI3fF4C0gu+iUZ8JsX8V+0yTD60XB8QHCJY+WPddQ7y?=
 =?iso-8859-1?Q?kq4cQGYlSTdm2jcmOH3Ri9z3SnYiJZkJeTJpfa082jE/boXmT5gZiFtKoS?=
 =?iso-8859-1?Q?0CJR3FaR4Ft4TYuLXXKyylqmUises+fbc/JvI9qu6OkvN3KEsTwFdsLOEk?=
 =?iso-8859-1?Q?p+gOVO4uVM5A0kXKeWPF/p5ySBhWNF+wfmpf9FRZtF9HBJUlDUEW6N+SpY?=
 =?iso-8859-1?Q?7ds3JkHxymTuviDlEQtYyUk9rU+KKbUkNhKdgaUVULmHRaJDFMyVIx9edx?=
 =?iso-8859-1?Q?DB8NEKIUi1S5zGxJ1yKyIgECvLtycYODJrmmwWTAgT5sEtmcjFte3TdYhK?=
 =?iso-8859-1?Q?WuM+DjToVE8Fw2gX75fLbCj7JasztpPCvC1Nl4PtonExUtRXe0o4ErDDr0?=
 =?iso-8859-1?Q?STwbuc51Q1L0NYOtRhubsP5057s+QyJ7TnUF3Sk463+9Pm9RfFTlC26fxR?=
 =?iso-8859-1?Q?62nLY6R3Wq5oo30gWUcKYAaYu4zRbzT16BbQ/G6ywxMd6fYXYNxXJ5sur/?=
 =?iso-8859-1?Q?vLRwahRvW4mT/HTQr2eeysKawg/VE+ZJ4YfLatrLziBqjY08jFYNg0s/AR?=
 =?iso-8859-1?Q?ZwPYfY/A1Mejz1YeLEnch2uGK7YlxJpupe24PwXxou3rOakMuJItDVpXut?=
 =?iso-8859-1?Q?ivIkh0du9pKdC1uyO9eDWhX1AVSXQGxM5X4VEY4Y6eazTApZjBwniiNIlg?=
 =?iso-8859-1?Q?LbRE/0F04xc4X/NpkOUQbmrzAYg+sHiSW8uKlaN3hc5bqrt8mCn3F1baEa?=
 =?iso-8859-1?Q?2DmlxjkBxfLDT6gwD5eT4izPDKqOz6Go+PGYkyn+UIXrrLixUkUIBeU4sy?=
 =?iso-8859-1?Q?sTzu5Zr+lPNO/O+ppR6szwIBKnINJHS04WNW9n/VVu0/w4BjcU8rITY8mz?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?V4rDD5ugkxaFzOgo2Z44d3xvkmd9CKZP0uBwXijLxRRaOC3R3wqY3d1RE7?=
 =?iso-8859-1?Q?TO3OQi+ZS/oMH0aK2DLTI/xN5F9RGPE+Xu/p9EPF5Dn9sD0X7ZlIUUuZnu?=
 =?iso-8859-1?Q?fEAHWYVBu9NiYRNuXWwCOK5wyzsU1cgiZbetVn/EZ/U0N3hMp1RwtjHYs6?=
 =?iso-8859-1?Q?h056mtGH/tFPlsamr7DYGSIVhuJAv9apPpesO0AcTx7ql2bih/lkTs+iDE?=
 =?iso-8859-1?Q?BYX0C8JXetFX8PDOsRpjilLJtsVh/AZ63hUJDFYxkPnywJPA/IxdIHgzJl?=
 =?iso-8859-1?Q?AxrpkSOX4da2gMoxhW/27QyxM636OzNdzLjjmNLttrNDJtN+Ai5L+6JbIg?=
 =?iso-8859-1?Q?To9GtKNp8czJd1ULWyq4rvD24N4fbIcTlon9j/IAVoajZfWs0CZ8F/4Dh5?=
 =?iso-8859-1?Q?B+ebRCCKCtBRcMMzMcjd9Y3DqqAW8ZrQJLb1Lj85SCddgrwkJCO06viVM3?=
 =?iso-8859-1?Q?wJ+xXO69jxzQLhsU216yHmZpgGCQEiaROJm9DkpAHC6AYXZIOvk9IEXni8?=
 =?iso-8859-1?Q?LN0oPOQ9mchdN2UBdy6zpP7W/Odsr87vb+V0Lco2vSoxIsIphbqi6AxMfF?=
 =?iso-8859-1?Q?wcUwK1QC+XDbpxDYGaKWtUloGDMfLfSftvTOoRYhZ204JHtw3JHm+AkuHs?=
 =?iso-8859-1?Q?mGL3H/JQJr0G7OV2Hy7tGLLLsNQMwQbz5ORBU7dFBw5TRUePtsRmCvPU8j?=
 =?iso-8859-1?Q?6/ulVc/Mge+U53YkGcPV1pvM9FFfIVJfOxx1EP00edaa/mKd/X3Ukz1kOL?=
 =?iso-8859-1?Q?eA8Wz8r934hj7s4XkHqCAAHnn687yvldXhNZd1YOHwBADPJ2/2DiTR0jMZ?=
 =?iso-8859-1?Q?rf8Ua+3Ynw+PGm6WdR1k1RJYUAQHZBAVyGQIOe4RdIENA8c4M7xmRc0iq/?=
 =?iso-8859-1?Q?HrTU/1EQGXhZbnHemgVTX6nxxhgc+w9xmJYp/VHUlHtaOzTMaiWwBELBUu?=
 =?iso-8859-1?Q?M2YMDwkITIoXazHap5+GPb/CXhIMmIoY2gNG7AwicwLYf4Y0B7ec3thvsY?=
 =?iso-8859-1?Q?sdMmUsnx0Zdst7QlapYexntRWyMbSnSmO3F7DKruyXQgtPeVNuRhSlyQJ9?=
 =?iso-8859-1?Q?F5gM2decBS2rkDvijAaHFo+WrFOnTNG5s4Un9wghsILBkYjSJbFnxhtWTp?=
 =?iso-8859-1?Q?Y8SeKndDdMdpPHm8zn+kO4w/R6UxzhnebLUGdr1CdnaLLkuP441D2wHErM?=
 =?iso-8859-1?Q?pgGH4QKtz2Mc31SylhBljaRPHiOqTL6vf3hiWTV8P7Sj0waBcOhTacnpQ/?=
 =?iso-8859-1?Q?0fD9wJXwfaZIuFtiZUVwxvHarVi2w8Qmiz7a9hSbXhd5GVNB0ci4ybUYBY?=
 =?iso-8859-1?Q?R2SV28B/QozI3QydlbS7yStx3T4RTdpBUQ9LBp9CxeUy/r53BOyL9yQj4E?=
 =?iso-8859-1?Q?g9iKGQL1OyLtn8cJGZGsmKYwDZIPdZj8tqlyNUMNh0f3MLIedvP9McI7E1?=
 =?iso-8859-1?Q?yEYH8xcILRp9ih/HJf6sCEX3rn3qS52LeVhw0yEtSQf4A+dM5fwQXapyyl?=
 =?iso-8859-1?Q?nlBnUVpeROUd+f5pwAW0JjBfn8uGxgtN0xSrOLx1H2yrph/5ZB2Zmr7bHd?=
 =?iso-8859-1?Q?wR4mpgdr6Mm+f9j78CvmOQVcowQ+UmUoHh6Mi/eY1gGMGMOjJOP2otq7pm?=
 =?iso-8859-1?Q?2/lB2Bi5mu3LJLkjVo+NzLbmAq0CQh7iE1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791d0682-3f18-48be-6da0-08dda83fa47a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:55:45.3752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny81JUsPBCKLSj94HVn3ZluhY+dqT1Tof+8s8+jluyPm9WdCADBztqaWFv6nf/a4QSfMmzBBSz7NkCszY6CYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9756
X-Proofpoint-GUID: _Vv7-694869fRkEcY19sr14lWYF00uHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNiBTYWx0ZWRfXygZDMSKLLRwM
 Ae7iS43aHSGaEtIKQjo1E+jGw/PVfY93Z1rf2Ce2dfzw4I/LCIphiuThhQKngUgBqJto8lw1aiA
 aqgD4u2pIvX++L69vWyLv9I4IroH6LTH6Cmb7NScg13bGCYIctBSm9GCrUuWig7rpdVjyKwI5SB
 IIGtEFN8SZwgKW+h+iQ1IKST6qMnLiGFNXtlWKqcKLnAstIoOKkCl57lpY7IAR1pcsdFHLLrX3R
 /ILxXHAYn+INGbdbSxFOFhb9XNdhE1OVlV4Rbfo3UEfVLA5wZCnCwoCCIJGUy4RN18zmGYBvwMi
 OJhdilHc1z/1WcN8Tj6lSuF09UZbhpQd9kEVpuTpPlNrB82Y/j6tJfv2o9wqNpB37uydepfKxfi
 pl1rYgNnfLWRHPAzLJl2LZMQF2Lvfm3/8a4qqLbJ1SoqoBET402IwUCKG7ki4557hYdydtHh
X-Proofpoint-ORIG-GUID: _Vv7-694869fRkEcY19sr14lWYF00uHE
X-Authority-Analysis: v=2.4 cv=ENgG00ZC c=1 sm=1 tr=0 ts=68486398 cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=x_M2XpB6T_037TNxxaIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 11:38:29AM +0200, Cédric Le Goater wrote:

> > +
> > +--------------
> > +Version_ 0.9.1
> > +--------------
> 
> Are you planning to have a subsection per version ?
> 
I've removed this, as it's not useful/meaningful at this point in time.

regards
john

