Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A2C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq3H-0004iY-QS; Tue, 27 May 2025 04:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uJq3C-0004iD-CE
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:52:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uJq36-0001wc-0u
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:52:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R1ZRfl022900;
 Tue, 27 May 2025 01:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5pjaUvj52C71NALbyBVlzxgLgg9vaECXtUIqRqt4b
 Y8=; b=sitYCM68zvpEbHPJeneKj03df1elAJQ7Ft372SllYx3olF7Q8m70d2uKj
 r3ACaRfxBPQJ7cDqQOY1vvGwO6rx2U19chGok0Lottbc9Yqfv0vTtsN/ZpN2LmVO
 gTcBXb6CogQ/ZTTA691+RZai1JuJ3rsW4QFCUJJVmu2oGkl3Bh/FgNOLMV4HOBwf
 aY/TeLNJqnyLsI7qY2J5N0TdlAPmmB+gOIUWgPS77n7DCXor7rWEkut1y608v8PK
 wWSDoM7cNPGrvuurEd//vsGRN20xcjvr6W4/lGkFadg1aCMQ2fRf/N5UraDsz16G
 wIwYX2SgJhErz7C3Z0eYK8sm5Rwmw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46ubnbw974-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 01:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IipXb34tWiUpg88Z/v3j4E+wZnXUKFhMbn8ZMiXcdgen76ldX3Eopm33IKQkSiihL2o9ZhN4+XZTgbRyi8pU0lrYdlAmlgJWvlCT8cepC6VG+vyra1gwhsWv5gcePqdprwA4hnTAV22Bn8umAubPg6gdZnOvHq4pyHCWFz++myR5XIleUHBo6AIkpTFWWvKLw/+AQA9xSwRqOAd8+obG0bHjltGuVMDvxxFzKPZ4ykVpVZf5RY+eTX9/BpBqqHntszNobTykAi2KijnRsw7K4uAa1lV/pjYqixEBY2sHXNKqylDNvQSXNRTPuuPQlAs2DluZvdazHmo4Xi2L4DqX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1QLkb5FLyoCVeQaNvhIWZPZRdqRoYxqsXd3vmr0I/0=;
 b=ywT9gJ4MSi8aKpaSRA3It8ariJVsBwsPZhJ3lBbQyM55zIeR5nMvtH1tf2W7t0itte0CayCQMf7y5JMdRh+Z8JXTbBMEqhMtqH0DVJzgLiz67Y2OKji+FufScJKiw54aDAr/TEKvsKlqTUU27huvPwIQk5/akjVbFsWrt0zSI+yIgx/ODOIFSMK9Il2U7lhV4JbVQ26e4vADPztGquE0yaERL/mxLum+C/2YPgeI+DKfxdJ0oVixEsT0WGAAs23vvMVD78XCG1mpxFwfe1uDSCxFPEk6u8d0eHvMGNPnT05iiEOeZX5sWE8gjG+xu0zWiJflrG8C8j3PdcUvVfX17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1QLkb5FLyoCVeQaNvhIWZPZRdqRoYxqsXd3vmr0I/0=;
 b=mF2Bh3gSrFxF5j0a+pWwDc2j+k46QbojL1jhsXtX9uUR/h+PSgu0AOheYf2kfngmbjJwgA8XKhvVi84s/16eN0MXidplEzTo02s4HHqQtYR9ZhRyDEGbTH/mSqaJB5reHaYfGaDzJU2MoPcALEcpuTJ/5i2nuRgDcKWnRjUUBU4EK6Q8YMANJPALRUnE3upQpyAK/Pp4L0Qhn3eHXqgx9mZM58orxP1Jyf8RRza0VB68ylPVKBdSYRD19bgKJIxhLXdi+zCLUwQpuG1o25dMn/tJb+E1P3KApEzL41h+uN9A9ECJTgpjlIvxhS62ouqSpiqWEdNQKHrSypZUSSwRJQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8827.namprd02.prod.outlook.com (2603:10b6:510:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 08:52:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.019; Tue, 27 May 2025
 08:52:31 +0000
Date: Tue, 27 May 2025 09:52:27 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 07/29] vfio: add per-region fd support
Message-ID: <aDV9S4RKHD0XI07D@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-8-john.levon@nutanix.com>
 <340d64a0-b85c-422a-ac81-4de6b10c8228@redhat.com>
 <aC2OEkS9IjFNiH1g@lent>
 <28e57f32-a7f7-4bb8-af6e-483e72750c0d@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e57f32-a7f7-4bb8-af6e-483e72750c0d@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0213.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a849a59-46f8-4676-1c37-08dd9cfbd107
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Qnxwv81/EaTe+LcgBnnrWC6xm3ybaXeA6j9D8GGFW4mPrVOmePd1d81mJd?=
 =?iso-8859-1?Q?Sx4a4NdhX/VAbHkDp6HzssYix2Tv8rIu5TqgdwrB0Fu6YKEXE1ylO/0zLQ?=
 =?iso-8859-1?Q?Mgzs+FQrgWVeBpY41OASnJ68EZO+tLTeHcEJwWkotglIeWl0nd6b1hXXPk?=
 =?iso-8859-1?Q?Y+Cdo/r8LOW5OXTNfbO3OVDRT7WVImOGi/b08l1PJK2XiTUzdc+W87YTia?=
 =?iso-8859-1?Q?/ZZ6EX+/fJRPkg1kU3UKcVxS5w2Ajxnn3apkR5ZdADkThzgCop7TloWE3O?=
 =?iso-8859-1?Q?3LXW9LKDa8QzD4/I71RgS3fXk4tI71CKxArV7iU3FLGNot7hj9y3IUqF/p?=
 =?iso-8859-1?Q?bzxfZuZcceXl+x3hQFeQORb2i1z0/Hb48c6BiuiEHfKWoyRb2lJqjjyAGL?=
 =?iso-8859-1?Q?PU+TYN9sGim/qPkCrTzitNvnBlZoEFqd1Oye1YJAfUKNhV3PSahpMv5hX+?=
 =?iso-8859-1?Q?p05CJG8vANyEWlL2VmmyjrsnJPzn/tApNXPNa8MrilO/grl281AcF0U3vT?=
 =?iso-8859-1?Q?hT04IO080gDjgbxV7uuTsmqU+mUAdI743ZvKZhDb2xKxi4V8vKlTZnTR7P?=
 =?iso-8859-1?Q?RYy+Ii1mqI+v6rS58KFFNz5B1FFzMjjQKYGdaTBOcjBqndlQzbyuq9XliV?=
 =?iso-8859-1?Q?EUmracJ5PckDu9JOr3RxYWMJnjpY3HrXplaZSggmV0o8ydT8PkDr1F5pCK?=
 =?iso-8859-1?Q?5ybUytuGFTlTTJ3xedDUER5w1pCJbCvIyoIXrBrZs5ZXBfmq3fUMUqx1Dp?=
 =?iso-8859-1?Q?wkox3f/+ozH6aYPSuodvQQTs3MGzSS9inVf2rj11tcQwz/g/3J5NCpVHwv?=
 =?iso-8859-1?Q?s2dQaivQC7HXWVsh6iAbF6fVUEzD0Ry5tr5r6Gpuy6wIsf/4B2RD/JkMUL?=
 =?iso-8859-1?Q?tW9Rd6U64psBB7X3QT3c7QfWWxQtS9zLDFV2Qk9KhcbQCFNvlOgK7CvGiC?=
 =?iso-8859-1?Q?0mJDrp1iz+ws6fPWlgiV68vdcFV+82FO+jfStNI74g/lqmK5zxve/Hv7dY?=
 =?iso-8859-1?Q?qZuj5frj3gpje3rVz1Rt0D7H2Zll1L+Sm7wmkHAa0731btih3i8RLU2ACR?=
 =?iso-8859-1?Q?j004CLLX+36i7hrgSFst+VMDv16+W1MdnOUEY4VnYawzLHXrxCFWox0bTK?=
 =?iso-8859-1?Q?GoB1RO/D8lENVqJKcVxUNtU1CCw2lzm9eJOHSY3UB39enKjJQkab8SMegb?=
 =?iso-8859-1?Q?txwfDaVgoo+P6bR72GKeJjbU2SloSFu56DZGIZRVqW1QPsKeTmGF0DJRT0?=
 =?iso-8859-1?Q?pGpQgNRwfNLUUDAX2VRTmpW76o3o21RGOBJ5lQ/u/CWgq7kf3E7tMqaghb?=
 =?iso-8859-1?Q?iOW//cmGVgC7f3Eg21xsXgjLxHjIOWTSOCoDlz2QTGSZCPkoe8p94V0AZd?=
 =?iso-8859-1?Q?yFCJ31QUJR7cGB56aY2phYYJzxJ2Z+XSW+SGhb2TqFThIhO2ZYZHF0mApv?=
 =?iso-8859-1?Q?hsH+eaX8I/KMEj49A5xc5PGCwmic70d/ie2UqhmG5vsDarQwQoVeIBP0Jo?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?E6GiQe9mQi+eh4ykcPNzRnhFv+CDWN06dedJ1RgrHGoc8TCsU73kO/7+/U?=
 =?iso-8859-1?Q?4m6I9ObleDgIOaaMx1YY3tJelSgfOmt+UT7EHUcBx9Y7CIEl6SjBQZekIF?=
 =?iso-8859-1?Q?6SzKN813x6WOQGpb3qVC//0+FtHjM9YgYM/hs9MPnoibXNX6GdqmI5JZr8?=
 =?iso-8859-1?Q?eF2gj59nHbDBpcPT1w10PnmO4jfHKkJhgs+BCbtNdSODorqeFeOW3OAody?=
 =?iso-8859-1?Q?kekQfMG+t2C40JbqHChK96XpAGPFosuHX9s20PCXQInjkWoJcAY/nwJN4f?=
 =?iso-8859-1?Q?uaMy+vNyn6zV4aoIuY5WfYDH7DclsLTO4thztITFq0IzP9QryflP6KphZx?=
 =?iso-8859-1?Q?kjDiAumGhbLceegOeW0QbVz80rteRE9vJbkJ22fbsbKr2ouZAqzJPLZ1Ae?=
 =?iso-8859-1?Q?fG5mJsh9E+X5vxFNbV+xs2n4i3XV5tR0qN196ffJma07jcFQb/dp5CsaoR?=
 =?iso-8859-1?Q?m3fRuouGY9Nl/SDgaCK76FrL46kUXYkpu8p1Wj6rm7bn1776SQEpgYnIhU?=
 =?iso-8859-1?Q?5ZnAyzMMPG5nFOh9pkSgb1RiSqd95f63FaWNU1L0CDr9/mC7x1w+fPJPOn?=
 =?iso-8859-1?Q?Iyy9xrisjtXGyrfKLZWEXKGKEED8NJaso7Fp7WMj79ozsMdUoiUWPi5/qA?=
 =?iso-8859-1?Q?xQIS1e18pK2mLHmrTwyN01f9b5tSRk2fk3oDjyAu9ZBuuYCPv0Lea0P/9f?=
 =?iso-8859-1?Q?hTEiljZqBAMHWGuftqfm2wj8e7P+KvHXLqqlNi6gNY8RXM/JjoK0uh9Qoi?=
 =?iso-8859-1?Q?/IxjdkrKdM6kX4g/kMSeaj7aLfyg/F7LIOOpYf+S3/zlDUQ+Gi+8vdwHtr?=
 =?iso-8859-1?Q?TQ5vx9LMXQf7DG/OxxXLHomQpgAPNmuhdVQbIXe9BtudAqzORkYWLpPpfZ?=
 =?iso-8859-1?Q?20RyzYMNvvB5eyGEGxU8QUzr3AlyVDMLoXeszEkPqw4LjJ8JoIeeLVhULS?=
 =?iso-8859-1?Q?CtuC0UUO/8ltM9LBzvlBy+9PTC1VwYlsxCYbQp4NsSN75EfvkbH7sGwjZP?=
 =?iso-8859-1?Q?D0giCl9+OMbcvwgq9PFvRyLrzoUCI+FMsbqW5v5mQCxcTvQWvft7Ly1RFz?=
 =?iso-8859-1?Q?/YMqqudWleGR2gWCKfgWVdNkWq/poSGC9Q7UXauh6KFOGw7+7eB44/OvZ/?=
 =?iso-8859-1?Q?M5BKIH/h6Uah5hikkd/qQuH4UKp931NXZq8TdO4rIUK/7SqElnCQRLLfgB?=
 =?iso-8859-1?Q?z/YpHrDVsPqamFvyQeIQSJarCnjZuadaYSTkWyjn8s4u2y3kvdIFU5mLWi?=
 =?iso-8859-1?Q?2a+X9IYFyp86XFFiik/qgiHlns93Xx4GHeNLh1fUx3AjMQZ4T6ue/gk0Bj?=
 =?iso-8859-1?Q?pyMNqX90J197pQyKOT90TVc3sv4gL9gdYGPmZgM/RcojyAeYx3gWBqYdQ6?=
 =?iso-8859-1?Q?cGapc/ezxeWen34GpDDa66PHqxw32NLQZb3chaW61xPCNc1NX9MOtyHEtD?=
 =?iso-8859-1?Q?+pLJK7yNfrH0iTVi/C7EitjZEzns47NBQ2kKXW7qVg5tpApnVerwBud1g0?=
 =?iso-8859-1?Q?paVvVW5KQIv3644JSMPeM/rPc04Gkqfb3s29H+4z/ygHW4iawLeEtfA7Ny?=
 =?iso-8859-1?Q?Hh3ucndodv16Y4OTDrBYunqWAgERsxWho9gnnmpNi8DI6Xi+vfkH+9J9ng?=
 =?iso-8859-1?Q?UFpv0yvABwwbKsX9079MgaFs8XZTp+6n9a?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a849a59-46f8-4676-1c37-08dd9cfbd107
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 08:52:31.5600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7EilJF6dnt6ztwDZCI7Z1e4BrLx3P3BX2ndqi4GdNuWPh7UPil2bl8nHgJ2dxF0v3FXoDMXA8xaAMwzPemQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8827
X-Proofpoint-ORIG-GUID: rVUkn4G-xDOK1mI8g--xwkXnFlYzfCRi
X-Authority-Analysis: v=2.4 cv=B/650PtM c=1 sm=1 tr=0 ts=68357d52 cx=c_pps
 a=wMNeujlvNozESTkKEiiyVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10
 a=ZRn6Y-st3XXYGLKH7QoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: rVUkn4G-xDOK1mI8g--xwkXnFlYzfCRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MSBTYWx0ZWRfX3PQjQj9mAEFU
 7dCXHfJcEVQMBYDSPB5rBWFRCp/hA3fkTmLZl+bJWwtXxbSNlUeBtFkgG5J6yZwUCR3kS6SrdtM
 eLDOMgidU5CyqBF6gOTsHBY16gKlLHe5/NjnRzalfekTUkrNgyKI5YqE9Yh8RHNotTqq1SmTsoK
 s27fa3j0XxQAWFqELy5Pw7nN/enwSKtf5bSCIND0AMv/v/P6bVX4DnjjE4PyHLIcKC75Zk9ZyhN
 OLeB5ueat5RzSpVhmYI5rwoFFclBggamREUz+OqQmza8tD3fz+gJTQscW+hCNsgTkoQpoBV2LKf
 PQAIRoTcag/PH0Dgr4qXiY/7lUV1IQ0IjWAMcYU3Z3kDwvRe/0NFLeaK6XzGbcCyOWb+t0EtL7C
 jkZNDUFFRjpxPj7lpj8W/CL2gJXXwC65NjNeQdX1mi143o5HvCXLCMGSXX5QiiF1t78MqaWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

On Mon, May 26, 2025 at 02:08:41PM +0200, Cédric Le Goater wrote:

> > > Would this work ?
> > > 
> > > 		vbasedev->region_fds ? vbasedev->region_fds[region->nr] : vbasedev->fd,
> > 
> > That is, region->fd is *always* correct, and there is less chance of a bug where
> > somebody incorrectly uses vbasedev fd instead. IMO "region->fd" is much
> > cleaner/clearer.
> 
> maybe. It's only used in one place : vfio_region_mmap(). I think caching the
> fd value under VFIORegion is overkill.

OK, will do.

thanks
john

