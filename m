Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FE9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 04:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv89a-0002BP-GR; Fri, 12 Apr 2024 00:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rv89Y-0002BC-Jw
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 00:04:40 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com
 ([40.107.244.86] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rv89K-0005ZW-TZ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 00:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Eugu5zqKyBMsvMnhMHvCOKa1B5cNxeRDauc2L0dqWUH4dqYnZLvDpCe994ndDLcoLN6e8H0p6qc0L6dKVqh2piMKAsuHbjaK1gbF2j7+YJvCm8Q4cM9xS9rGNZlxvBe+/KhJ9Zccd1hzf78ygdAY75zKQBaQgv1UHsi6f1Up9APwHVMqosVPGsoNlzb/91rt55yj+I68rmWNdpzF6zw7wQ61p8eFsj6nZWvTmO76lnxNOpFgSRtAhKMALcJOVDK/1pWtUPv1l9tKc8AeF6xSUnuOawwenj+HZkZu/Lkjcz3cYxELjNtJUU/n0ojSdrnvCbJOTheTjhnAFCIi7prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfiGfEicZbPxJsquJibkVM3EnJWzxevfqqofDgKS5FQ=;
 b=SalI9n2OWKrmIyOfVdxaEO7PpIZTsMx8vGDnf6c433MqMFsAv5m2G2cHFFhMle8MbmOel/jmwV3zgd+wfdA2BhnHYNOXE1X4cXGtzcBv61wpydvZH5SP0LYUSx5W+8A1TzXgERZrKBCDCI/ldaWH9FIg/fAkWjAVQI8stLgaNP25H3teNWQkrWwviMD/6SQsjmNdm71hKyz87+eLD6RiyCZ2sT+50KZoIpY59zKoWgthUSxk8N4djRMkag3N5wLoPJgq3+Xh3X7qrgzKnsxIJ2J9k+hWloxgNOka1KyVlphNHQQSDYhx2sOfRzB9o76bvjMF4WgUWMRIZmXK4zG+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfiGfEicZbPxJsquJibkVM3EnJWzxevfqqofDgKS5FQ=;
 b=oR/DAF/QaNzfN07NLoP9ZlgKv0f+T6pxYJjuGzFjRmlvSOjoXjwUNigo6BJXkE5kACB+fwjn58QVDThb0MVHk2K5uz6AoQKpXfP3mNLnm0Ry0YjOELdcyObE9tAFQhh0MKZjcieIzKE/WoeQPPS5CvMCaFAaKmWBYSm4F3oClTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 03:59:18 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 03:59:18 +0000
Date: Fri, 12 Apr 2024 11:58:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v7 00/10] Support blob memory and venus on qemu
Message-ID: <ZhixfZ93e3htVMGs@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bb4c26-252b-45b6-972c-08dc5aa4ed3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOe2kp84r43nC2EAyzq4h92venkZCbuiRz5rtLYtGyog73HmTWzDJzvqFvCIZy5Gfn09QCxUqKE01VagsoqrhRpq0hdh5RyVfsWvyYEHW4nze0FaPgpsB5rw/TJDZVosaXi1gti2NWUSAFPlYSFPfxTao9Qp6LkYUTF2Ia7K25ylYMe0DEcFIbKmWnWG35uM1OoKvwADEK2i+vVigw0eC0CV9BYxhNWnYmp0KXMYKRoPMtyC7HzjZV5k1/KU7jx1Jk1/sS3vXUlbm+Whrf/fgdeLMLhK1OpKgyljs6xyndXPr7YE9vlpQLYJYDNdDRbHOGtL11Jb29CKPzSIj6UYSYkeSYfdB1C7V/06LSFwXkLT6go4WYnFrWxi1Eyqr6nT+rp54WnWXZEtix916kd2fmQnFn5vKpRdvgwF7uVAEJlRwiWp+YtaET61ImzXw8wZPk7PMRIYcp6kxJRJ1/ai949+SJAx8XPwwnXkgy4w5hM2HgXwJ7Gn8vDdRuKlD2MPO2LBFPAxzzUBVm5tX11CKOnvOsZnbd5UXgMdh8HI7a9hlsnLUZWU/cM97HtyaJVnLmxb6zVXvqP6wJl6yGMulybfUPbYy7PVShQhsnaiGSoUL8SiHTpPt56qnFmhBdDS+Xd76DJdBD/fEirrFM9sBd6ghdUXfJBpgy2HzTJ/lyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHYv9Um3POafB5WQj+y/eGXIISL2wLkFF7KQ5iRNw7UBoqOsyzhcyY5p/9sS?=
 =?us-ascii?Q?fKMj7GnhGViviWmxTucYriEHpUVZJGubajf+jw3h1RbOuYlze0epd9Sc0y3v?=
 =?us-ascii?Q?7Fu2Fpy5Hci62DurYUV9g/EpksHZtUpTZFnEUJ+nhmP3vLPgZz9iA7/uCFyl?=
 =?us-ascii?Q?xhJ0UaQMBJU/ecTuuvH94aR6g5QhWMcI6ryDKjG80ldfFPeQBeZsvjS/Oc7E?=
 =?us-ascii?Q?3pbVmcFcKaFUfnnL2mcUM/u/6+UE1sAvzEjmkor+/U63M0ZSO/TSLpghRpZU?=
 =?us-ascii?Q?7/uF4j1ocmzUgtm2LAJPT4X8qvonQLtMBCd5bqrGEdeIy5BBiq67zkx0b2b7?=
 =?us-ascii?Q?VVp3sHcELvmqHyJZGI3f2GMj9eyty1KxaZDa5KOle6LqnRs+z78I5okuuSqh?=
 =?us-ascii?Q?IcxCUNxfC+EadDPIAh0SpoJwcK0okUlFtfe4BekCO8u5ZOTj54EUDLavicQY?=
 =?us-ascii?Q?9ySs8tAYRyP2yXjNUWOHJ3gvoTuJ+6pFhGh+ul0txKYOhzigph5thvh1i5kE?=
 =?us-ascii?Q?3NWi2odZhZRz4aEy7+Mms1QqiBqk2l86W7a7mjIVOFZcBhfUhnDi5bb1AcPS?=
 =?us-ascii?Q?vffSBeg5fKGetP+VwokuvmSUk1PF5tqsRDwAxBTmGCXCSBGbtaTNBGRO0Dko?=
 =?us-ascii?Q?rR92BbQM+hvQdUtOvZy3crKnxmsVMjEmlMmpmwdP6RTOoKtsyLBUhAIZXptm?=
 =?us-ascii?Q?fghmS1Zrnihw02a0yd7uYgwhFQj4MxvxrrSYH54JW+OuvT0U9Dyuw9cGpsRq?=
 =?us-ascii?Q?N5strsJNmPhndNpV4eBobsl1+nHOHG/C5Xw4FRMUpN28pQx1aIZJFEVAmv65?=
 =?us-ascii?Q?XxONDm0cCdwUfXeY6/M9eZjG7AtduhY48PVIjCd/sc6t3XNE6blcI5lOTLHk?=
 =?us-ascii?Q?7t74tvxzaQCTvng/J8hAIoU2xS/5DmTIsOJ6BY+nbR9lSWj2TsGk/uqHImav?=
 =?us-ascii?Q?AAj1mbv9WR/WfwSIZgLAHZMv9LuVQxPwXSkky0ykTRdW0ibG6L721dzvxfVu?=
 =?us-ascii?Q?fPFhLBorj0jiJxRsbcbGzS05Dwqwlf4MMgDP1vG2FqNt6Jf55KVj3J5Hj2RJ?=
 =?us-ascii?Q?55aJLk6QV3H8Iz9l3iwlrS1wwzZV2UzxZGnhsbAcKdqdQqu/vDEAYMY+HslT?=
 =?us-ascii?Q?fg3YulBrlgEKwVNdauJDIQZHboTboxcSYsed/76qPOEIw8ft8mVKEUnxNyjY?=
 =?us-ascii?Q?OqfM27KOxOIxXCg/5DP4bQStr9ReP7wu6MMgd5STt4qShRzDD2QdngdWz+5R?=
 =?us-ascii?Q?Whqxh9AQiPzw0e/lKkt6HFovZvwF25Ikhd2rxEsFI0FiyAZ4Tn8ZcWePqvRW?=
 =?us-ascii?Q?e4gDsSRv1S0pGXRJNI6xOts2/HI1QKU/6dEjuShKFc5a9yoSD/myNBRnkpix?=
 =?us-ascii?Q?9aYsbvhL3EnQwLAABrQdpLVbr3ME1bijOUFAlCnvAUKFRI2kY3EEKBTBjxO5?=
 =?us-ascii?Q?0DhzpPUQitPeJSgUk45Z7dJYy+LcCxQCqKtXu6Rj8V+Ez/zsl56eaDO/cMx7?=
 =?us-ascii?Q?zgyc2m63ssfVTNl5KVdnKqVH6Ko14uNjxytAKg7h5IK2PSOON+LrVK54ejrE?=
 =?us-ascii?Q?O5Hrc6ZHIOIEeE7rwFSEBx4Jlf5mEyslvcMvB/F7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb4c26-252b-45b6-972c-08dc5aa4ed3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:59:18.3046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMMIIFRFR744XouDZZsGjBJehpaWgkJqfm+28+WPrBrpsB9ByeJAEm1OQdyXuvb2e5XKj/wbdvZsLG6HNUG2Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
Received-SPF: permerror client-ip=40.107.244.86;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 11, 2024 at 06:19:52PM +0800, Dmitry Osipenko wrote:
> Hello,
> 
> This series enables Vulkan Venus context support on virtio-gpu.
> Upstreaming of Venus to Qemu was originally started by Antonio Caggiano,
> later Huang Rui continued the effort. I'm now taking it over because
> Rui will be busy for awhile and he asked me to do so.
> 

Thanks Dmitry! :-)
Please go ahead and it's important implementation which is not only on
venus but also on virtio native context.

Best Regards,
Ray

