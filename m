Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25504C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanU-0001j7-CT; Thu, 15 May 2025 11:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalI-00062f-TP
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal6-0006BZ-46
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:43 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F9OJCL000592;
 Thu, 15 May 2025 08:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=c1lsMtou6XkKjYLhnCP9yJZ1pYByE0B4NV+OfajMG
 Og=; b=UBbhAQ7kTLiB3JjVjYmntYFWB1JYD6B3xLNdXZbBhUpppdc3/Y2rierEh
 B9WLAePiZW/TXlc/dVE/z6GphJLpAaD/WVNEKbLVVkeH6TVly5nbe9BI4GRYfxr9
 wGXxkGzI52y5niZW4fqGuI0EIzDtdxb6hAzmrQ7wOblOyC3qE5XXKRkCeQrXGp33
 N0q9XFn+xrTFegRTlCF35nSp/nFYHEI8Gjr7I22ewbu7tpqIXchv6cBECTDwsG/a
 BVqOPMBxM9ZL+lo9nD+C/2tktalo66Z1FQBIubguLIK915XF/6OzLZZOfMj0YKYR
 pfNLmE2Oz5MwnJon2mXUz7/vCQnVQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcsdhs5-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQf/ZAer388EoNHllgBNClMnzJpx7zi+WdDLE/HQPt7+WaZP/8f2Q7C9adQHilKRI6wvMUCYRNxBkQvM2Y98cC6E/6Fne2r/gn6iDGpzh6eiww/VqQ51OXZ5hy3fD3cyxuoMWBppZHTkzAplQ1njJrE/cfE9yokS44mfcubmErLNp9dpTeisxN+ORZ9KZ7CiY/jNaFYo+A9MHqJVhEGVJ+keO7N2BueWLHcN/hs0krgXzmDvUn8ieKHXw2vgS0rd3NXpN+kUZXBzWrnAow1ZOzfPM0pRrf7tW1sRkEcpdOMl+cLF91HLiQ3I5lcJHLIkG67AmgqBkQ5nP8tC7DP/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1lsMtou6XkKjYLhnCP9yJZ1pYByE0B4NV+OfajMGOg=;
 b=yLz/ZesJiAtCELC2ZihrzntvJ65HH6oD53cuVYDiI0evmyF+7u+A2TYbDuPcActSQxtq2voK8RGN65GrOW2XZNPeHMSAenas2A7IKr/mU+908S4faUVpvxoMY5THSQXQx6qWmgEScdUFBhfKhym6US3aXrLy4Fb+chmX2/DahPw1NQBaWynmw8p5SYGEn+C8SO8Dj1SoDVJeoxPkdge3Dxcquhmd38D2oVloEg20k/TfKLl2fEOG9yeMs2pVLVtKDVkC+LmflUqWqrmiNcoBCN2ZFr562PvNt9Tl9eLHLF3nzzGPxicv8O0fqy7GB5Sn67J6vIYfTy8DQg75Y4+BVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1lsMtou6XkKjYLhnCP9yJZ1pYByE0B4NV+OfajMGOg=;
 b=Aza9g/4PLQfVuXombQzSj1egfxu0oK8gNxtmH6uQR2V7qf4T+Et27jHVnJfOjlat0wZ7v5piXiPx+HVGculmZYs/0cU5cGs9dlUfA5wY3IIF2h/SnF1ea4UyyS54Wwz0B+Y1ul4ho2GGvIoLJlTv52fxqm2yTc2vZFrmB21bZp55Wy+seC04ceHlP6zMJeurt4ebWTx1yf+Ucve3BpT5A04iS1WrGSWczBGh7lhgau9DjbrjM5Z9hqZvWVnjHDQmDcOfUVurjzFen6Hjah9J7PGVPQv5zP72FCBjVbOQDvlkQpHYy3bOzi9I5evTOnOALKeug2KzWECiS3zIQ13zOg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:27 +0000
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
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 03/27] vfio: move more cleanup into vfio_pci_put_device()
Date: Thu, 15 May 2025 16:43:48 +0100
Message-ID: <20250515154413.210315-4-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87eeb2b1-ee1b-4f2b-ca13-08dd93c75fb4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XxTO3NClNUt7FKfSLjVVOesYrOh7eB1AHMZuhYyGDyW1nRoDnx/ilkIX8Cq2?=
 =?us-ascii?Q?kqIthp6IEQZGj2oFSf6Imy6a45OT+O5ez8AcsUsU7L66hitESnvAxRbImIPb?=
 =?us-ascii?Q?XenlxXY7J7oxw5KC94IImLB6i/j1mWip31sjJlhWgjw/44o3L7JtoDfUA4NT?=
 =?us-ascii?Q?5NpNrSV0+5zRXZFuHhiMB/PUuSAXPn40TRlSQOTSl/GQndjibI0fbn3OMbYG?=
 =?us-ascii?Q?SivNsxCl0SozGD4MkK1h40wzTAPJPQgV2sSqhZGJG7Pa/uFJlDmNPg2f5+96?=
 =?us-ascii?Q?7OClu//dhxjbzC52zWe6zBryhiKWJvG0TAMkjWekH00IukMjd1oMYw0jUYlt?=
 =?us-ascii?Q?nuCBz4dDY47i3e9QAW8VUL/MEG639RdMFtzbdF/9mOUUgyuI+TDTstxssYPx?=
 =?us-ascii?Q?fiBn4zhqeZVnDNk+sM3cKBzwd4DCKb1uwQoGBs+Cc05abOSjqru6ZHBbSD+D?=
 =?us-ascii?Q?QohV1DslMfXXgbMhjk3VnMNGtHkNx9sV/WOSG4F92oO+VxI+XYfLXfm8H6HE?=
 =?us-ascii?Q?xoda1P1AFCDYE7GmYjttKrnMOIVePCuDN7P76/E1GKL/AjigGZo3MrPVJho8?=
 =?us-ascii?Q?VdR5zt60B9UEfYi42pLlsUaa94pxWxNvK36HfPdUp9FNDtbimOgA3Cf3axnp?=
 =?us-ascii?Q?jk7013ONJlMtii1z/jJUJ6WxFkc373Xjl01x1XJtU9b6Ol2OkeLxwRaT7zUq?=
 =?us-ascii?Q?LtnNF9Jdmk9Dp4MjIf/N2MII7cSycmHNYfnGtfMqNw97KhCNIrCUG5Ah7/ea?=
 =?us-ascii?Q?peTHz1mvBdh3jTTmXCjLkASKmgl/qpVSx6e0p/95d59Nt6FCqzFQUzVAvdHI?=
 =?us-ascii?Q?iPQIKzgd9KWR5kJzt1TiEEcx3QgfWlJoKL984cdEr3WU4eZ74BEdmqlOb9sx?=
 =?us-ascii?Q?kYVU8HKuzFDJWdcaY1rowKiriBx4Dzfh3tR1tq/b9taCzwHMK/T3g+WIeY4E?=
 =?us-ascii?Q?uLc+Fm180ajf8jdBUCpa+V2Hw04cVcNjrSvqv+N/Uww1DkguolNq9BaOuw7G?=
 =?us-ascii?Q?atM4MDcOj/Sqyyd7OAOq9qxg9F78w8rQD1rRgx6lrad+eDFaLuVn3hvsgC9z?=
 =?us-ascii?Q?9RHPUE5Da0AZf7SRJeq5NeaWqS6mmjCd6ngNZuDmOILzs181lFRLNpP9ooY3?=
 =?us-ascii?Q?Db+peqjtNIOTklTDcNa/SdyY5R1E7ukZVGuzRJoWpnbdJzKXdkN0TersdMko?=
 =?us-ascii?Q?8sJENZ5fb1uAYjiYXSQNZ43ypMRk7798vgHuQCvv/IohhkXzxSW4HbO8pUQd?=
 =?us-ascii?Q?oolLRbN5d1fet1Z6iuvKlIgHNracRUwGuIB0QVZJK3cj+rrUfKRLNL/uute2?=
 =?us-ascii?Q?kCXSA52C8f+DG3f+oaVOgW/prowI6K8q3/FZZmYtLo0QuMw2OYByIBUZ5OVU?=
 =?us-ascii?Q?oaUfXLje0C71TIQa0ojNN64GJDtj30sPQ+JCg3Uk58llIqpEb3Vmph3n2oVZ?=
 =?us-ascii?Q?lQY8NJE7Shk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5W/6hCe6qO6Bj74z9AfQa9rBwWkWZj0zrmp8ErvNOsMdd1AT6zvWSRPeFe8S?=
 =?us-ascii?Q?cLvMDmyIDBvDJXjR3w9RpQMs2gb1nq1EN5uf5quTmXGSmxp/WcPH0rFd6ZEG?=
 =?us-ascii?Q?XptGhE6ayaZ/cnzwgi1T2EDJmg/fbt+L0k17nHfytikxuJCU2Kie6tXNzpMF?=
 =?us-ascii?Q?0wYK5rrsLxph6w0AzGhbmwhdJgH+sWovIt7MBSaArjd5pUVo4lI2I0GTPv9T?=
 =?us-ascii?Q?K/1Gb3y4ZjAKErS612cmppi+rtWBOkpyawfXcfhI7NWDOMjGZ+kW9fWALI2p?=
 =?us-ascii?Q?uY3rUd911PvaykGb+Z8sK170EStaRLAvAJE6DBpS8mWb9JMSt9dcMbXX/YTM?=
 =?us-ascii?Q?dZf4M7knahYmgyuNfw5lSYsO34uAT2hyuibOYbP+oMwHgURV2elYeq/Ue0zb?=
 =?us-ascii?Q?XPwYpgvPzJolKDi0QdQss096jpNjID5HFazn2Q7Eiaxp3rIo+l+QG3S/1Va2?=
 =?us-ascii?Q?7Y6kkQ57FVU5xk8CkTTKaHf7oz3jqmE/iKebEONWQDKy4EGQRlrJJbNusMck?=
 =?us-ascii?Q?uke6VygRT3kFdrkd/wOMkjuTCo3bZmUZNhlGNKZ2OZrK66HWKyWMMwXVJ+1s?=
 =?us-ascii?Q?rHX5vXYvmHioHIu4YSke3Ibxed+nin/bpFGWKl6ZMLpdhvoqsogexyVPzMBd?=
 =?us-ascii?Q?r+cFxFBeJcnmaEXgVdWCRdWO09nCp6qiizpf3++IG10y9jlhNsUVr/fopIPb?=
 =?us-ascii?Q?ZfjfrThltFQeoZbnYwb/qKlZhRW6v2HMIJY3F4/USa8dlmH67HEXkCqj4i1w?=
 =?us-ascii?Q?NW6MacoxeVKt4eE97qWl1E5UYac66W/kV3g3C6WnUlqEYY+vfm6tJJR8y3TQ?=
 =?us-ascii?Q?zyF/AHi8F8XtTyWkUjqiXKd7Z3OulVj53o8iXjRj0GET5IT3iYnuiSxFRzEJ?=
 =?us-ascii?Q?7pGZYa9b89CJFbUZ/nAF17iSL+kX1FcWNrXzT5ZG6VxLgYZO4BeSM/whBxjO?=
 =?us-ascii?Q?CyHwzQ2Yd98ixAAn+h2YIiABB/giNNHfeKlIpgrDHt2lJFhlqwCPNP7yHL2y?=
 =?us-ascii?Q?Ncj4d+Y2rM+6NVU0wzMGBVn1iJsFfiAX4Wo7QOd1NUy4otxsH6b0ZIwGM2Hc?=
 =?us-ascii?Q?M2oH0iJ8eRQnNivihXVa/74SmkVTfEoqD3bHHgAHAqrlMgxZdxxG5gb3xsBV?=
 =?us-ascii?Q?XPrFhIjWAsOunBv2AObiGi4w4pZsQVQ5FwsdlB+XRKyV4Z550vBRo69t52B8?=
 =?us-ascii?Q?jzeTM+2RXxT2x+aHV/M5L9wgiIsLO9a6YFCKaVhqRNbz0fIgxSeM12urvk3Q?=
 =?us-ascii?Q?E2BC0yS5skpmN2rms+kqW3n6gjWqj03zpTyqJYUHpfPq7WLAwBlP7HSwjVuL?=
 =?us-ascii?Q?+wqPwdgNFJwizmekLh8ERMWwqaFwr2dt/QZFjmONi1Wp6zyLqHAKk+RBrTke?=
 =?us-ascii?Q?4auuI65tohOfkoJU4Nr+zXJ8HyVAvoO/0se3+om1zEEPSuSnq0zQnyezl6xE?=
 =?us-ascii?Q?vvU8JWic7il8AQqzgY90cVCxnZcxTEXzO5cffpBTRA+JOooXUgF6Mmma/F3G?=
 =?us-ascii?Q?/MZA564xYx4tZQQyrVRSqr9fGjuNnw19p1fv3lf9IzQttqPZi246SXHnjkVM?=
 =?us-ascii?Q?LIokCKin0OdIm5UxJaD5Thgaoi/oWdTi4UC6++Q9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eeb2b1-ee1b-4f2b-ca13-08dd93c75fb4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:27.1408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVgHmOJOJcJw8Wy4d1Y/zykuMKmb64+z8POYtJS8ED3Jgqjv0FKheVfnL7Xapfh58dW67diYunA1CJTJI+WTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-GUID: homVQ4_LdYZKjoo1jI59e8cz3XbgfmHA
X-Proofpoint-ORIG-GUID: homVQ4_LdYZKjoo1jI59e8cz3XbgfmHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX7VlqS2MyPUU5
 y9R8nBg8TzG4oyo5GdADoRjXB0nJJ163qIUNiJHd3HrqLUd3yTXfpbKQQAa6GpDjekQCa5kxxyt
 Q9+5ohPXHAWBRJbQXf7hXSHuFdGaeakI8QQvbl6IAmcff22bPKVvUUJbSIQ7CGDUkVNgYSaYpjA
 l4/u6D7ewcUFpycDhPv3dqQoGkh0eJr6hjaNd+W27x2uuHCEZLKnN54EVWzWGyS/nyZoOp6zHtj
 FRfucccdRG6/d3XD/KPEjTISzI2nRhHwst7kO3yk2jNElG0CQ1z30kYgEuacKBnKqcTEfTJfIpp
 8MOAobl/WWGcmHbwTk8dUYhAhb5t+Tv61gh0KTB+wqeLSY338Og1gzzxrhJFnBhhZ92z2YrEH7P
 XpaVwAW8hmyhqqCjV+X62OCbrMoiDHATIm4qSHrkZAl4CyZZwrT3kXmDfPPXFTWP4nbxx6CG
X-Authority-Analysis: v=2.4 cv=EKMG00ZC c=1 sm=1 tr=0 ts=68260bdc cx=c_pps
 a=CQ+uznrK75NoT8CVPM1Etw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=_mo5Ov_VicZQ5TNRUswA:9
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

All of the cleanup can be done in the same place, and vfio-user will
want to do the same.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe375..d96b55f80c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2854,6 +2854,18 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_display_finalize(vdev);
+    vfio_bars_finalize(vdev);
+    g_free(vdev->emulated_config_bits);
+    g_free(vdev->rom);
+    /*
+     * XXX Leaking igd_opregion is not an oversight, we can't remove the
+     * fw_cfg entry therefore leaking this allocation seems like the safest
+     * option.
+     *
+     * g_free(vdev->igd_opregion);
+     */
+
     vfio_device_detach(&vdev->vbasedev);
 
     g_free(vdev->vbasedev.name);
@@ -3302,17 +3314,6 @@ static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
-    vfio_display_finalize(vdev);
-    vfio_bars_finalize(vdev);
-    g_free(vdev->emulated_config_bits);
-    g_free(vdev->rom);
-    /*
-     * XXX Leaking igd_opregion is not an oversight, we can't remove the
-     * fw_cfg entry therefore leaking this allocation seems like the safest
-     * option.
-     *
-     * g_free(vdev->igd_opregion);
-     */
     vfio_pci_put_device(vdev);
 }
 
-- 
2.43.0


