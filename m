Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60010C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfnpg-0004eC-Ab; Thu, 29 Feb 2024 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gedwards@ddn.com>) id 1rfl6O-00089G-9A
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:52 -0500
Received: from outbound-ip168a.ess.barracuda.com ([209.222.82.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gedwards@ddn.com>) id 1rfl6M-0004Zp-58
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:51 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40]) by
 mx-outbound11-93.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 Feb 2024 18:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxByWOGXdHXiDeFxqD1dlARtHZ8jr+Ha1ixJEG63rlVftsNZMBHIcfFjgZ1mN+c99tWwG6pNRUX5hC+RSfpO5umZWLPgFC73hqD/T5jwqPwSr9uidqXp9S7xs2/R7ak3pM4YmihEuSszqs8lb7Y2K9DPMMKMq6nKh2LNnP26dgnynXAsW6tfRBhGAHimBySAr0MyFRcs71xkKzjB5nwvjTxojy4qnQ4/A+2z7UZkszRrAfyYWvuCDYyz9JosXO8a8eONtkuMdQ/CN8N/nlXT4Fv5vHGjylHJIpstgc6ysT9Bml5Lneo59hjPoa6LuJQBbHbm4gIwUvprzVxa1jdOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJtk16Ss2FjHQvDW/owtHzqLtvOODoLKKdQgXaMar3Q=;
 b=BKqBiTa8c3Gz8M+zjiEBTYKK4frjfnQ5mbFIAAo5bHHXtEKiwhrTNipc18x91Vx8ZMm/wzIrnKYhjywsJzvoLmVkHHXpNmfgiDpAA4h2EcPcDjE3aeHWIamN+Wn/Ch7PpveQCRZREK0an+j4p2SyAaluA43YTtVyC6t5ttV9LIQ5GHeR/8jjEKYU0b/5TT8wJdONJMUK/3YwkRUtOnDkja04xHn6m4oc7Q0kRTOs2mxsOxMnZzPnQgtm1GMkjVPn38rBATmFM9eKeuzRupb77y3myZ9kehp8c5gxRVrr+RN9cYw2vnakrMBxSzifYPbbTT2TjEwK87rXa7hSIzhpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJtk16Ss2FjHQvDW/owtHzqLtvOODoLKKdQgXaMar3Q=;
 b=tPje1TisUl+tFykqAqZal8HyK5v/8v3d8SqVvDfGCNOIrN5ljs2rpiBzabGbNOBsS/BwQO09Rkb4liRpJYw+pWD6X9RfjTA1mLFJuNi5qxHJ0EWPEqYL8SEOZWFM6bSjQGwx/7+6GkGHsfMh68OqT5qui8MkN67Btt9wY9iCtaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA3PR19MB8193.namprd19.prod.outlook.com (2603:10b6:806:37e::18)
 by SA3PR19MB7588.namprd19.prod.outlook.com (2603:10b6:806:31f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 18:25:17 +0000
Received: from SA3PR19MB8193.namprd19.prod.outlook.com
 ([fe80::6eed:df87:b510:6c5]) by SA3PR19MB8193.namprd19.prod.outlook.com
 ([fe80::6eed:df87:b510:6c5%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 18:25:17 +0000
Date: Thu, 29 Feb 2024 11:25:13 -0700
From: Greg Edwards <gedwards@ddn.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <20240229182513.GA17355@bobdog.home.arpa>
References: <20230814144100.596749-1-willy@infradead.org>
 <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
X-ClientProxiedBy: CYZPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:930:a3::10) To SA3PR19MB8193.namprd19.prod.outlook.com
 (2603:10b6:806:37e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR19MB8193:EE_|SA3PR19MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 32333872-1f7a-4e56-6390-08dc3953c754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEXMgb6yWbEGepKpQOZ9mTC9RhMyIvyLV5b/hm3Mrl2Lvnvp1PeZd226MPu7DbmCZFGQdvSwIZSWCo9pzkPIPl7lJJPP/jSq5AX7sMbsdji3+/m4o8QuLDPw3RAWmVQJN9j9VCz6GEVY2Pn4Cz6x1nbb7syfDAvLNa96BQnVLl6KACRY3XYXvkrekD/0NLVcvBPU+aGlDtiW0iJW9Jr8q52dcCuCy7Wpt+tO9zYWxzV2kJVDDhZvSzu9Nnc2bzZ8tKzcqZaeD0QmPyLmRPvJ5oIIsnv0ns9heMMxVStry4NLVxUyktRAfbCAGwYKORf02vUexvYV8e0QnTNizfZpmNG9hPInoNUmRxdbi5+jAW3JM4pe/SVfth/AuN6DVlArszfCtqLNzdmQmhFMrexJmFEnJ6jZyeFUs33n13c93Pbab+GAHHz0VExIg7jpM8zPhs8OkXHfguxCuWrOcAJ0DdT2AEiS+FgCajDlgm4zpS8hOoExiTCsFIfDmfc8qBYJAH0/GLgIyjW8rx/YIewnSemEbnsfFBsZGF6yMcYadcXLFt6V+N/12LgwuChmo4/0wov0TGiQQZj3gSXHjZxl1/QIHJUtWAe+D0MiFpHqXCSKwRIGNiWSAPPhwexTBeTudcvIKvXrdYpl/LN4hFg0mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR19MB8193.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGV8uThtdu2XszHnQzzbq2mRCkKBX/alYZ4UUrleCeWrp5wI1s2/kaJ7zOT5?=
 =?us-ascii?Q?0YUcoGPLLqp9rOisa3vUA5S+MX5+2ke2Fq0kZh6pZMiPkG5i8c+FSS11OsK2?=
 =?us-ascii?Q?LngIbj52XEZm68blg8BL08FvvUW2aQU6AvDKgHmdIDeFfZKBQszBIxRatCHL?=
 =?us-ascii?Q?BIJogVdkHmWWAIyBcK9D4BhRqXQr/C+bs9j09lpCiQlWmJL1r7PDBkWuaDvs?=
 =?us-ascii?Q?oyvcgGLbZhllmZ3z/6/Q8OYKQLkKR5xlEmRbV+VgWqgU0EPwpDTjKIkBtG9z?=
 =?us-ascii?Q?MrvW8+9B/VsQ6Eq24ZMKaZmJtKcKhLH8npGNiPII4blf3r7xXvW+ZKi38WDJ?=
 =?us-ascii?Q?s5NDVtvCLbWuon5bRrAzLZaC2y42uIdO2AEv+6AhcvB2D+kVMkA+lOndTLa7?=
 =?us-ascii?Q?ybH7EN4eBaD1xBZi/zdja2PjW3HxHEAKhA0wu6KpgX1gr1HiyZXY4rXzgPv8?=
 =?us-ascii?Q?wwWTth0e3qCRBHg+Qs/jJqEtC/QkgU0Twt82dobiB1HwOroNW3+T3rrwir2J?=
 =?us-ascii?Q?DEU3LaP1HhoWFYkKKZIr9ZDq9hXtzxRk5wUi5F4xaSoRdOaPAWN1ESMVeIXq?=
 =?us-ascii?Q?hXHYbZrLjTspjR0Go2ehKZwXa0zJUJSr1LRcfF1lsJJs1K+zkBW8zf9pCtT0?=
 =?us-ascii?Q?QdpdKIlZcbjEYta4upqs57/jwHU9bGVV6QhyQQrUDPbwm8X2gEJOrqHICZUC?=
 =?us-ascii?Q?8K4eJ5L/OOPPioTvGtuzRsD6Q1/bKSAsyJ00eeEV5YZT40aw0bhn0yWVbouu?=
 =?us-ascii?Q?LQmE5IWH9BsgWDt7TktDh1W2FfH7c4AbiCQmjkFJJ/Wc3jfQTdUMWx14ui5x?=
 =?us-ascii?Q?Cjhi7wcWl5irmB4vO1nqRGcaNsfpoXbc5S8IjQV7CsTV+LZ01n8kpacr52XO?=
 =?us-ascii?Q?TtYdwRIidvQo8ydaAGrw4y0oW/g8xMQqKa/EztWOXNPhv/18hd+KhPL1zSt0?=
 =?us-ascii?Q?tJdrHM/SuQpv8Tce++noFTE1Gw/+DI1oNX/rAuI4MKr7nC9YNpZmJLaxsPtQ?=
 =?us-ascii?Q?6KBtcssz2XfvgUZsbbAN4xsZgQLXEkQD35/ZlTIRVcki3MfLikSK/XlzDg9L?=
 =?us-ascii?Q?sbWhEYAHOHDfb/Ul/dTlIt6R46Q+tUAzdYBn4Og4neySXqVMqqMX2WRbr7U5?=
 =?us-ascii?Q?4LnOeiwDJxdiFriuMLsoYgweTgveXISBuOUDAPQhyV/zwXJ75Y9l0qjX4ZbO?=
 =?us-ascii?Q?NYYkDc3YxZysr+AmcclsYtgP7fI4Rh58HUxZ70DN/cesbhZuwCwiMf9SewPk?=
 =?us-ascii?Q?e0jlxVu0R8LsVdcAA4g/uC1mgQpn3ppizTILOyzra8GAiha5p+13Wj/2WtHT?=
 =?us-ascii?Q?eaP5p+Vrsryys3lNxjZ2bc0yEUOpIVNEIo7EbHUAeTy6ZjbyJ3ocoXYAhgL5?=
 =?us-ascii?Q?mNVTCtz/10BbwPycqlxJDUyDETbal9LHO9BwOfU1zES+vTRRCEJLCNX7ifPW?=
 =?us-ascii?Q?m/RKXuPMk4pGYPII6SBq6OAxXx73J8VyREuEAbKjyQbOCdCOIlKrTy0Y5K8l?=
 =?us-ascii?Q?OIYbQmhdUQy+9y0S4VZxPh6Ji6YqQS8FQ7N+yoREahUSVe5qRSU5y4N39Lre?=
 =?us-ascii?Q?sKyzKYVveYSKiYvhbBkto+xh5PNbTiCvIvvivl+juj3NKR6375xzJRX3kMSO?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TBjph9xbz8bLxv8DN88bwPsJxVkhz/6U736V3pKAI/c6poe0mXtB1tH6QBMu9AAPV9RgHomz2lA9T3enB4Zrtz00ImmH35xHC1MX07aRwfMWqhEemx5nz+1nXTOkoZYsQFRsGhOkBNv9mrtbPm6yhCN/5zvvRQlH704jYh4kUZttPv3vhNvDbcGArFvUwXt9noSTqp9UaSjkGs4Dkb06L5GYIGrcLDDtO/R9z3gHhl0OiLIhzgcth9QQzDUlb2nKEBsCWhTOuRVae2fa5+3ADAedlmW8nkWH+K1Ih3LaPzSuB5DJe1nWl/TKYtNPr6eu9M3/oE+5kM3uQTC2eKOf5txz4fprVGPh1SHGNe9mr9XM/rXzgEKOcw6z7IzZM/n05AItd1c25HZCHS1YYdYllHZpVNH4jbZoxwK900ADdKhJ+Vw5y9cBBj81JhVZN2m3GuIIe5jbhxQs/8oS7o56h3ua1hnixcUNPjkjXjvMaM2yVH1bPgFXok9QYCCNUSTXJw83eaE+Y5pDROctXgUmwavqffxv+21CpVSYErrs6MByXwMdaiN9ckNI2xXiBUapzLxCDrfan6FrlWZnFr1gvHV/e3JGt23XvmUv9jgT7qYjdi4kI0hX+iPBnBWe4a5scVRBaDb0UoRmIfZ/imdwTg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32333872-1f7a-4e56-6390-08dc3953c754
X-MS-Exchange-CrossTenant-AuthSource: SA3PR19MB8193.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:25:17.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma4BOxL1qcPkrHr69mNgY3HK3mpKn1sbTlmjy5FVkkha7b6KXWpMlsTx4I1diRDxdT8LKrSAUEPmpAgtKTaKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7588
X-BESS-ID: 1709231120-102909-12414-11066-1
X-BESS-VER: 2019.1_20240227.2356
X-BESS-Apparent-Source-IP: 104.47.74.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGRhZAVgZQ0NQ41TAl1dQ42c
 TEIDXN1CItzcQsNTXZPMki0cIk0cxCqTYWAO3T0Y1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.254555 [from 
 cloudscan19-30.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.36; envelope-from=gedwards@ddn.com;
 helo=outbound-ip168a.ess.barracuda.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Feb 2024 16:20:32 -0500
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

On Thu, Dec 07, 2023 at 02:04:26PM -0700, Jens Axboe wrote:
> On Mon, 14 Aug 2023 15:41:00 +0100, Matthew Wilcox (Oracle) wrote:
>> The special casing was originally added in pre-git history; reproducing
>> the commit log here:
>>
>>> commit a318a92567d77
>>> Author: Andrew Morton <akpm@osdl.org>
>>> Date:   Sun Sep 21 01:42:22 2003 -0700
>>>
>>>     [PATCH] Speed up direct-io hugetlbpage handling
>>>
>>>     This patch short-circuits all the direct-io page dirtying logic for
>>>     higher-order pages.  Without this, we pointlessly bounce BIOs up to
>>>     keventd all the time.
>>
>> [...]
>
> Applied, thanks!
>
> [1/1] block: Remove special-casing of compound pages
>       commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55

This commit results in a change of behavior for QEMU VMs backed by hugepages
that open their VM disk image file with O_DIRECT (QEMU cache=none or
cache.direct=on options).  When the VM shuts down and the QEMU process exits,
one or two hugepages may fail to free correctly.  It appears to be a race, as
it doesn't happen every time.

From debugging on 6.8-rc6, when it occurs, the hugepage that fails to free has
a non-zero refcount when it hits the folio_put_testzero(folio) test in
release_pages().  On a failure test iteration with 1 GiB hugepages, the failing
folio had a mapcount of 0, refcount of 35, and folio_maybe_dma_pinned was true.

The problem only occurs when the VM disk image file is opened with O_DIRECT.
When using QEMU cache=writeback or cache.direct=off options, it does not occur.
We first noticed it on the 6.1.y stable kernel when this commit landed there
(6.1.75).

A very simple reproducer without KVM (just boot VM up, then shut it down):

echo 512 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
qemu-system-x86_64 \
	-cpu qemu64 \
	-m 1024 \
	-nographic \
	-mem-path /dev/hugepages/vm00 \
	-mem-prealloc \
	-drive file=test.qcow2,if=none,cache=none,id=drive0 \
	-device virtio-blk-pci,drive=drive0,id=disk0,bootindex=1
rm -f /dev/hugepages/vm00

Some testing notes:

  * occurs with 6.1.75, 6.6.14, 6.8-rc6, and linux-next-20240229
  * occurs with 1 GiB and 2 MiB huge pages, with both hugetlbfs and memfd
  * occurs with QEMU 8.0.y, 8.1.y, 8.2.y, and master
  * occurs with (-enable-kvm -cpu host) or without (-cpu qemu64) KVM

Thanks for your time!

Greg

