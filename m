Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF40C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvnyC-0008I8-9Z; Sun, 16 Aug 2026 23:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1wvny9-0008HA-Rq
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:25:01 -0400
Received: from mail-northcentralusazon11013054.outbound.protection.outlook.com
 ([40.107.201.54] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1wvny7-0003l2-OP
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:25:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymtGwdar0egUiw0gN5eU+gQs5RkoO1Znh978z30Htw+FNrAm2Koddmr+T9gKvQBVNYaFqrfVcUCqr6AOesVaPI1DFPfp5a660HQw/1vZmbEAib2LYOoMKknPbNs97Mcw+BLAzAKAlk16cz7JsKuWGhHBtD19Ci+V6kWwbSISOK4NoYQM+JSEsL/w7g2OnSzZq0c8tS23zlDOJza9/LBYj7sphDORtUUX6/VuPDI3zR3ArrsPsE553W2plCGSOEeT8uLt1f17ZvBEI59droyiQmtv8zh1DOf1e9XuNUDC0GDbPbLSEqsB1AR3oWRnXOwa8p0HcNoYekdWhxacj4NMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECuQ5EbxfrTfvi4azIJpb3E4SlIYnRRm0WZNmNa61J4=;
 b=XUxevspsaQEGDsy3I0Dv/8SAXTxbWY4cjXNFIuVscC6avx6NAg0OhBJBRU0JyG3ptr1SvYJGQfWdgdUzU8GeM6dJimn7J8LTCt0j6zIAotKGO7wpntv4sBlpn7e4xk83YnPOGVJIJzZxF0HiLGbxiQjkwG5DU9XFLVP4x3ICOr0tgqKL0kDrkA9wY5v6JtCCApm+/1+nWlzVz22NkskjkcM5MCii/BHUaSJ8qmbOXxF9BXjA2NCIdkBGtHRUFS0g9fz+pAUYX3IpKR/DLqOJSeDBvgLl59qg4p6KLj5hYJITDeX/ushD6olsS+QzF6OCfShbJrbPV5LZjJCEjzefRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECuQ5EbxfrTfvi4azIJpb3E4SlIYnRRm0WZNmNa61J4=;
 b=MZ/Na02b9BtcUPXkzhjTkjSjGS7MdSB3bbJDS3U6CmEn016AX8bjsdbjxKXTgJEiFPJ5tCBgKLm+6b9WnU5Luo9nC84tqwR7b9A7bCRW8q+M184zw6KGhTooxPw//RThY5mHySD8Y7Bz0EdBckwKNsGedfoXhn8VjWpgLbf2dco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:19:52 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 03:19:51 +0000
Message-ID: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Date: Mon, 17 Aug 2026 11:19:44 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
From: "Huang, Honglei" <honghuan@amd.com>
Subject: About new backend for GPU compute ROCm in qemu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b9299a-f382-4203-2406-08defc0e66b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: qrtkCuuwrFKjoEisXqy0tViiOgwlX9/6h6Yr4DDZ4BF+DwYOYtbZCFCxs9UllFPfikeQOQJ1aaTyumFt2OXyG2kHL6wuskuTbc7/Fu5WUSZCOSVSsDEVK0zu86EgvBh/WNj3YbZj+knvJvgZBNmJYz5U0R2Rb2+DrI5PMIZI8BSHNch2z19Y2TQp/5PBm9vouUo1RroOB6UffYJW2qlfC5XxcGraDsXUVGVfsvYQQyewsBh70LhmOWYCiM9YTjolgSM8byc4xtLYtIu5urPo8aKji/O6Q2oXq+1b6erm6/mxuGQcGRRS7Ghn82/8qFwTSwQAaeIHRs9Tp5lDj6g/YuE7X3q0LX94XyiNtP5Oycnc1mbOUY+kU0XcfqXvHS8yMhzGpuUMuXpKF8p0DkIO/+IAIcC3e0kjnbqe9DnX8vUMiSHqGr4KfhXcfLjghGAySXUdKQkszM5CLfzBuydLSwPQJlEujSbN+eE0QKJUxYqkL+nnD7xCeji1oG4/2fpfqp4W8nMjARZfYAIg8wk5y0I9+ApNUmFAUWiRq2bXRae4dJD2dl8fw8NZ3/PCL9l26OKF/qDYaBU8pZPF0an9H+BY2r/vx9IDt9FRmUy4OL26ZQw7j4XC0rj/ApUDnU4Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZhL1drSlFwLzR2MFZ1bnhDZmhuLzBaVVNJSG5VSHVEcE8wQThZNzVWeEk5?=
 =?utf-8?B?WEk2OHgvZHEwZGF1T2Nnb1puVWdPYXhoY1lYU2F0UWdOb3pKRUNPRkJXZHJU?=
 =?utf-8?B?OXM3dDdFSm42U3FiUkRJOVBSdXRSY2J4TzkyUmc5U3YyaERPd0VrUEtOMkta?=
 =?utf-8?B?Rlh3VDFCN05jZ2taSVpWN1cvRUpFZTVBVThFbHJBODBTYTNCNHYwZzR3Smd4?=
 =?utf-8?B?ZStFNTYrdDk4UExWb3Rpbk1sbjlMUy9iaGdlanBoTW0yZjlnQXhWQnNQek9o?=
 =?utf-8?B?WWZYcWhtZDFtM2wrQjB5WFBnd0Y4cXhMd2JBd1REY0Z2eXlCdTBVVmVQUlNR?=
 =?utf-8?B?SkpRV2huQ0REaDBvTzFKa1BKZXY0S2l3aE1HdlhGTi9vZVZwTXMzeTA3SU5s?=
 =?utf-8?B?MEpURjB4aTRjelJRdXZhdlBLSUY2THBFT2dMVC9VcUtzSXIyNEd1SCtFT3V1?=
 =?utf-8?B?SUhSYWxBQUNRR2kzQXlpUnB1NzdRbGQyQzFCR2tCYndvdG5FMTI4OUtaVjVn?=
 =?utf-8?B?S3FXYVl1cTYrZzd5dkczMFlmYjF3RzZhNXlhdjVSUnlsM29icHNrRXhPRmIx?=
 =?utf-8?B?WkJZcC9ncnhjUjdLNlBPdGhlNzYwaGtEVDVlbjVSdFVud1Y5KzBxempKOG4z?=
 =?utf-8?B?MXZqSVpTeDBjZFVuTE91TnFlTDJDMzM1YjVYTFZ2eUtYUmc2bDdpOFRDdlNi?=
 =?utf-8?B?MC9peTRpakhTYzZIK3JYQ0tUZGUzV2w3UXFaU0JlV1FEWlgyb3FIQUxkNlpN?=
 =?utf-8?B?OGpIeEJnWTVCZ1Y5SEhFTkVpaEt5bTZvV3Z5a2VqcjBBeCtwNmJHZUpuQW5G?=
 =?utf-8?B?QmV1cDR1aVdsUW85VE1TMmkzblNLemlRNTUrU2tBbE5HSkl1dU0wZStMMWMw?=
 =?utf-8?B?emZ0ZEcvLysyN05jTjVRVVNGZnFTU0xEelhISDIvNFBiaWJxV2I3N1psL0Fp?=
 =?utf-8?B?UEZBbXJqZHE5b3JHb3pHK2JJd2t4b2N5Z3hUcVEyVjVuSkRKZXNpUHRBNExq?=
 =?utf-8?B?eUl4a0VBdTNBQmRXMU9EaVdlaVNBN05pS3oyempCMXNtR1lMUThuMHlTeXls?=
 =?utf-8?B?cm13R00zQzh5bWJUdnNHOFdrMUxWck5rMGgyVTNWaUFvK00zNi9XOXVScm9w?=
 =?utf-8?B?QmttTUM5Tmt2V1VvUUtONEQxcVVFVGt0RlhuMjhLU2h2akdwQmpzSmwvTENR?=
 =?utf-8?B?UVJJcGc3aUNNZlltWk95S2N6QVM2Z2w2WkxTT1NKY2doV3JmYm9Fay9ZUXkw?=
 =?utf-8?B?ZDArRWQrcWtET0JsNEt3RFp1a2lQRENsTHY2ejBCb1d1amRqWmxUK0FuQW03?=
 =?utf-8?B?RXBZd3VmQ2d4Mm9BOTY2ZjhVYmgza1dPakgyY3FMQmZsN2ZHdEhhWFVlRTZn?=
 =?utf-8?B?R3JPdVVWam4wTCtEMnNCc211VHh5b0tUUnJMdFlzRElUaVlxanlpemxmVzVQ?=
 =?utf-8?B?MXJHcEQ2UEgrL3BYOUpZOGhGSWxZM21PaFpxUkJqTy9DWkVHM0ZENEN1WitM?=
 =?utf-8?B?Ny8yeWlWUXBRenUxMFZsVVd1Yk9BTWpLcW9EeGgyNk5YbVUvRkM1UkN1Y2lh?=
 =?utf-8?B?NWttZzF4TTZXTFBFWGRYNXoybDJUYUR1NXNZWkFoQ3RzWXRVRDU0QWo4bkZT?=
 =?utf-8?B?SGRzY0pJRUVXSmFsTHB4eFp2dTkzK3VlUUtXY2p3cDdlZklvR1ZwWUtFdXAz?=
 =?utf-8?B?MUt6U0lJM1dTejU0Y2IwczJ2blNsb0RZNGc0bVBzSlZQcTg2WkVFMVU4UU03?=
 =?utf-8?B?Y09QQklWWW1pWG4wY3dDVG1ZekxEekpSbnF4MXVGVlUwQWNsM0hRY2U5MURH?=
 =?utf-8?B?TEVaS051dllLWC9ORlhXV3h4Vlp4bmxrMmJBUG9rM1M1d20xWnBQRGwrTlFr?=
 =?utf-8?B?enVRVmVGU1lHcjNiSENNTFJPc2lJNGdqSy9kRi9uSytsR2g0YVZUeFNDWXB6?=
 =?utf-8?B?U1VPYTMwRUtjYVI5TG1ZRVkxdVM2TTRpRHFDY05SNHJBVUF3c1FocFNYRWF3?=
 =?utf-8?B?T1F2dU43ZXQ4bmI4VnE5a0ZJTUc0Z1NlVEZ0UEdzWnlVOWFtbUNHaFZtc1FY?=
 =?utf-8?B?R3UrSnNIRnFoYmlzQUZwSnFieU5aM25zVXE4UXhZcG1TMzN0SGFwK1lyNW5S?=
 =?utf-8?B?TVp3dU5Sd0NpeTFTTVFLcTVQMkd5K1RkOXFGMEwrOGNOUmdSd1FOeldqY255?=
 =?utf-8?B?WWJUL0FEZUNsaEZiakM5c0ZkUmNQRHRlcmpSOVF4QkNvSllSYzlCTXlkZnVP?=
 =?utf-8?B?N2pjeUdaQ2VTb0c2bjU2K0tlNEhXem4wcnpDVzl6NVAyRU1uU1hlbll0L3pv?=
 =?utf-8?B?YjBxWkVZVTYwaDlLWnpzU1dTT3RGZjZobHZ6SW9QdVhKMGtSMHE2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b9299a-f382-4203-2406-08defc0e66b7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:19:51.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKk/zMzNY/eK2KlUToB3JtP1O292bc0sE5Ca0uSaOBZga1LGlrvDpjq2Lmt8MonYgWgJeW9iGY7aslFk0KVWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632
Received-SPF: permerror client-ip=40.107.201.54;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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


Hi Michael, Alex, Dmitry, Akihiko,

I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over 
virtio
implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm 
side has
been supportted by ROCm offical.

Current implementation is a virtio gpu context type capset handled inside
virglrenderer, sharing the display path. That's an awkward fit, many
compute GPUs have no display engine at all.

Beyond that, sharing the display path is increasingly painful:

   - Compute hammers the queues more than graphics, so sharing
     virtio gpu's single control queue with display/virgl causes contention
     and display stutter.
   - Compute contexts need far more blob / shared memory than a display one.
   - Maybe needs a wider ROCm / compute stack, cause the render model 
fits poorly:
     rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
     and ROCgdb (wave control, address watch, async exceptions an
     out of band channel that must not block display).
   - Events, faults and GPU reset/SMI are async and don't map onto fences.
   - All of this is hard to extend cleanly inside a display capset.

On the QEMU/host side, would something like this be OK? One step, two parts:

   - a dedicated headless virtio gpu instance for compute.
   - that instance served by a separate ROCm backend library loaded
     in-process by QEMU.

That reuses the existing pluggable backend model, a second virtio gpu + a
backend library. It doesn't add dedicated queues for debug/profiling 
currently.

Waiting for reply and  happy to share more detail. Thanks!

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568

Regards,
Honglei

