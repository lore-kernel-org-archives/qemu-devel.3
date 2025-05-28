Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF840C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFaj-0007k1-K6; Wed, 28 May 2025 08:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFZo-0007In-Rt; Wed, 28 May 2025 08:08:14 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uKFZi-0002pA-Sf; Wed, 28 May 2025 08:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoyAjVKBvRhZsR8hMDcRCX1MKFwTLa+0BY5DfIRl4TQVFnaOMLlAT0anwLwmtfdYhfghrbbToIJx5zBsfWr1X8mol/zIlYxaN7bwooebYCax5pIDCsuiqeKHW6r7qXimQIw7AGiKwgGzmC9Qo/LXotMrXzd7zDkD8VAQk4hNPbn8pLSBqog47k8lDOfdobO1hkQ2TEN938ZookkBVNHpGHziAnzjnvYnWwoCx+1ccK95RgN0khGpeZTRgsJY41PSY4191DPzIHl4kY/sSaE6DA5X1rE0oBF6mlB/PR+FjpcjUd3Iwfn0euIhyzAKIqxzqBTVYZ+D2bZVf5Bnosqk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js0YLZ3HXoUUrkw10iena8B0SXj+m+OP5HqgpgEV3hs=;
 b=U8TjsPFL3xHHv96BrmAcJCFyDf6nIl6+M+imMD31MSx/izkUFxlbPGPpG/mYd8bD0lGYlOerdvrupZoJrJmU1ik5b6MRsHdCTXEdIv5JUSc49xs5r7+mgL7QXkOgonZyuirgfrTuqShZ1SozTsj8tiVxXDIP36s5fPq0j9mgFMKnzul0ry4OK62YDUmFFUbs5qR7k3+oVHuPpjLojrp9QlNogYoIy+oe1FMk9zqAKbI7fLuIGE2lL5Ek3JS+xorzosG8hUEHGF6iHRC7Ccy1THuKj601/h/kepwAf9JfwnzYxi8jBRpcG1H8nwORCxqWyYgFtFJ7AAXk53cWOnDqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js0YLZ3HXoUUrkw10iena8B0SXj+m+OP5HqgpgEV3hs=;
 b=RbYf/3WyH3szpRizGT4DthODOdPX0g9D47f5Zynt7YDSuX+240MC+E0LEytNVobTqse1GS9wMe3BK3D+g8MFvqqekl6PTRMFX3II/BWCfL2g9+uBwpk2tVgt8FJNhw1YDweyw83L6iJz1lg7VS98F+4vycAESff6VAhVZZYS4rY5hlmmDvh0Fu2ShgM/SAzJMcRdzdFEPMDkmZBSCVkhhvGEv41VkIb1JElnTODClROB0+rLNiiwPncA/LyHrOTYiRzrjcGQp75OPVUEUfhMcL+p/54pXDH2J248Mv5WaOWOTpm10cp37S0RC3V6+8k3YY77qhQn3H0Ln7FzK4xhkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 12:07:50 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 12:07:50 +0000
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH v2 0/4] improve block_status() for cbw + snapshot setup
Date: Wed, 28 May 2025 14:07:27 +0200
Message-ID: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|GV2PR08MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7f29c2-47ff-46a5-3eec-08dd9de044a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iFabNdwrlb5EiEQks1h7dUI9o0itFUZPauBTxByp2SNgvxdsvtsg3mVXbzgE?=
 =?us-ascii?Q?r3lmsxJIUOE9hwkjvxySCU2dmZ1bGXDMLrYtOHuj99uTTh8MLT6mSaYdv29a?=
 =?us-ascii?Q?1/znShQZAIWvjRcX2TX360TSNTY9u+tmT9NIbDYf1Pkwm1zTqe9vUp2txbpA?=
 =?us-ascii?Q?dv4niZJB3PDKYOxQhyHrCBtdq9m5SnzDjdDOjGbVq+PdOxh3FYOIQMg4UMae?=
 =?us-ascii?Q?07/uXheWPyuXS3IHRfZWyGma5/CH4GAK1zy3c4NvZAiaBeIBui8YBHoPUFLS?=
 =?us-ascii?Q?V45ufxtFSUQW2kxOC7g4fWTWe+AVyKQuRXb4K2XNjZKyFXAfIcZXUzn4+iuL?=
 =?us-ascii?Q?ZLav8yU745DymALRL/pSmcwTD6AlmxHgyqT5EpArzyuJffxKMIx5nFF1SV8k?=
 =?us-ascii?Q?363eFgqt6L7v0XM337k4tfI052apG1EguRh788Qet5NyiuS52FyL6rDzQ3FT?=
 =?us-ascii?Q?pe4bTZXJuPV8ZjDauIsF6vPvbckU7g5X1hHOQTAJBKd2CFcqfsxWnW25YYiy?=
 =?us-ascii?Q?8+0citajo44mClBhIWRG7Xv085zBF9ytHZvgnz96Kc2k2mbG5SAaaP9yl92P?=
 =?us-ascii?Q?SNQxC3c2RwBypr7Y/VCjid7CvTmtaJn0Z75YhiHWwZKOkZTQixa9SWo4yQvb?=
 =?us-ascii?Q?YEXWNGsDzcvErZqen4eJPc2HZOCUEPq7ki9kwTMZgfqNjKFx/LbtghRt37Zu?=
 =?us-ascii?Q?NedruB0+oaf4EbeZY+6XOF6+PekXGVHiCkxv4+MSXRYooVEcUKzPL7J/nfgz?=
 =?us-ascii?Q?cF6Bt7pDoL7W2/MkVpVGBadB0beuaqdComvZE2ghBHrCr4EdKAfLR8mRYaS+?=
 =?us-ascii?Q?XebWc9BK+O4aM2p2ct36jN1Hra6df3wF3+7wXAKENC9vRw4lchYqPOnvkBP/?=
 =?us-ascii?Q?wQ9T6njE4SbEoqiWunDRQDP+HWd2xx+M8BwG6UGBTDxQ2r6qjx0JcXFW19v/?=
 =?us-ascii?Q?X21+ANYcop+FfwucZvOr0sF3Kcei6JbZzYP5wYnmpcc3l1EPS9+FHtiN/3yp?=
 =?us-ascii?Q?j/7dWmqM+9E8HAfn3JVUUIfVFag+z0AuHvmUHzoxf5MHTOJnf2qsrnJDkB8N?=
 =?us-ascii?Q?femauDLdrJLTjqo2L816OXgntW/mw0yz4Z5uDF0oOFQw/IONM98FBTiEkuhp?=
 =?us-ascii?Q?pJ9iSYaiIv3cNMll6FFxmF/QB6XUpaL+vd+KD6F9NcMdBTSEzK4AVaQaP+s3?=
 =?us-ascii?Q?a1TcwgPWpGsPFW1zS9gPC8VAG24xg8C0fqOfCR09IW7Dv99K8+7nPWCRU4SX?=
 =?us-ascii?Q?upWmTejBAAV5Rc9wKOunSTkvNUvTaCzmNo3/7vV8UPiIdf1du+5tWjgDo9kf?=
 =?us-ascii?Q?p3VdxsPWWIQEchsGz+sejZQqMWpsXESEcMYVgVx/rkbDNTIpJ9szA0hrBoDh?=
 =?us-ascii?Q?AZqSKfHIBd8/RPTVzf/kq+C0dYKFzg2pj68sI5jrlJTIrrP0LTbkgAIeHhIS?=
 =?us-ascii?Q?l7rqZXaiZ0YtBcD4xMKOw1pYanP4xF71InLq/r2ioTa1F+VOxGbFhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mt7AmmW2PiRLBBnDnwrzt0jgfqT4R4gsodqcNplAa9u/YARVwfoYaFQo65Lv?=
 =?us-ascii?Q?RwsaKdwK40PZE97XiXAy3Xin+mfL99nsIw4e24koGiEQMieY5VVa5o0Afr5E?=
 =?us-ascii?Q?2WK2vPIzsE980CuG0NUhh/fYZaLAly7DsTFV6aHgBPUDGqh2Vi8DNBtCXB/0?=
 =?us-ascii?Q?DUjDCM2oxYojv7MOH3zcfzh7tjH84ikyTSIKfJowRCuDHvG0Xm2kihqWmyD1?=
 =?us-ascii?Q?k62MQIHD+Ntb8/atfNoXnd4m1Qgq6ci96Yg50+lr8zeLPKCHsBpN6pXrUAGX?=
 =?us-ascii?Q?slESCLyPmns1YzeqMTtkzoRRvgqUHvCt8Of3HjClWxxF1ytDq1D7FiSsreNE?=
 =?us-ascii?Q?i2Vzij3mTe2hsIfTqOhN4d8H6PlD/dX4R7txtXN3k3HjHI/mjntoE+bhQHy8?=
 =?us-ascii?Q?zZEwuLua/EELYQWcbPHf/nZrIMYpFxTjA069LdpprBa/dEmf8Tw6K0wgl2rQ?=
 =?us-ascii?Q?OB1nARQjOuZmAwqQQxd6KV1Yxi1Wkk7Zo+ENY0Vv4kS+/KJyJmzOgZxcc+Oy?=
 =?us-ascii?Q?Qk2nR00SSVWnZ/WDICd99POgB/kSOt8HkqReqLr288vi3QGp5JXIEkKtISzm?=
 =?us-ascii?Q?bxzBE4S+OUOgzogRSJhyvkSOO+uo0Funuq8CGc5iN8VQc6X8GJxlclE/Fp2r?=
 =?us-ascii?Q?aRLKRgZaD0ppk6s7iJIrW5oNwawW44tqRDxs+2gcrxJkcrChFxOrGPZVSHzV?=
 =?us-ascii?Q?wSMKRXzpk7qf3LhsYTO7IwK3Gclkjxr2Cta0cnpjWWd/MGIASAI1oqw/VmZO?=
 =?us-ascii?Q?j3mwQgh6S+wRqh+6DeoLfES7zdzbYXCQ1lIk6Myf/bINbK4UPXKfPkj3vy/U?=
 =?us-ascii?Q?cnKF8tw/4kQ464KurmdLzmNLs9pic7XHum4WVvi3q1rxBkQe+Vz6YHs/N8YM?=
 =?us-ascii?Q?Re35UZFMaJzEFOsSViDHMbNVF8iJ95h0CKD4aKdYUeitWs2LrLLwTqhls1p/?=
 =?us-ascii?Q?W+rmNAD9oiM1JpIAz3Co2NvvlXsPqBV0Y7rw4Aco8XHEwEoe1VTPQrK8H1tF?=
 =?us-ascii?Q?5fLuoP4cQXDHybQVanNMfJSGsxyZ0O7Pckfxu3+u4t4kcueVpiZE86ejHnPS?=
 =?us-ascii?Q?rZ4BpfH3lPZZDVWuQCNJK4MTwrko5HaK8U5YBiem5XwAbXZE1Bj5o7XRgjST?=
 =?us-ascii?Q?jisYLeI8wEvxqxy5k7pz/Lx07r0/cH7e9fXZGEChGBl4voPGuy8OWZmpUCez?=
 =?us-ascii?Q?mdw2jz2e6vLI34WxGTj9fFfeVL38GhpoiWmZRvaBfiv2L9fdh6ILc2fCgmsU?=
 =?us-ascii?Q?+PGPVPvvE7IaeIdERry6G+KtaAJ1zN9XkYVM8QexO1B2aOYqzWJD60gCrZ1s?=
 =?us-ascii?Q?MotKm2sDVl+7GmqWOtgFzVmmN/MhQTOTyZltqlRWrmtYXXNbtJpw2ZOm6i7A?=
 =?us-ascii?Q?PvLp0LmX7yA6L2VYvPEoD62r4o1iYcBQuBK4tHnRFFN93syedIMnDTnyNjmq?=
 =?us-ascii?Q?PZG0A7e3x8l1p1EM+WY5Nk8fpB74JyAzVF55N50TmjpmRAN7OFq+XE9USuz/?=
 =?us-ascii?Q?CrpCR/0b0VAXnNvbz5YZwu+LCPHgIiBX8HaLov13Mu27CKHZSaDM1KpsZog2?=
 =?us-ascii?Q?SA5zQeETgmt86iQQrFxMYcLsW8lmWzGZ6gGCmA8+zZESU3Xl55LU+gMPV9V9?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7f29c2-47ff-46a5-3eec-08dd9de044a4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:07:50.7792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSkjQn87erssZvodv6ShFMASX9v5HL7Iyz9//XPqUukAUpR5C4shMZyU6gtX1il5/QUfMSolEgPrgIsvLx9Ga6IG8Eu8XWufIsSSg9QferQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9277
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Recently we had some reports about stuck full backups: running backup
job had 0 progress for more than an hour. This reproduced only on big
images, at least 30TB of allocated space.
We are using snapshot filter + cbw filter + blockdev-backup. The
discovered problem lies in access bitmap in cbw filter.
To build bcs bitmap for backup, the job repeatedly asks for block
status with a range (X, virtual_size). As we are accessing the disk
via snapshot filter, we end up in cbw_co_snapshot_block_status()->
cbw_snapshot_read_lock(). Here we check that access bitmap does not
have any zeroes in this range. After that, we ask the disk.
Firstly, we always look for zero in access bitmap for the whole
range. This is rather slow, because it is full and we need to scan
every bit in a lower level. Secondly, the following block status call
to the disk may return not-very-high amount of continious clusters,
for example 512 (empirical value, guessing for the 'full' image it is
4K/clu_addr_size for qcow2 driver).
This way we are doomed to re-scan access bitmap on the next block
status request (X + 512, virtual_size).

perf tracing example:
  96.67%          9581  qemu-kvm         qemu-kvm                    [.] hbitmap_next_zero
   0.33%            32  qemu-kvm         qemu-kvm                    [.] qcow2_cache_do_get.lto_priv.0
   0.10%            10  qemu-kvm         [kernel.vmlinux]            [k] perf_adjust_freq_unthr_context
   0.08%             8  qemu-kvm         qemu-kvm                    [.] qcow2_get_host_offset

This can be clearly observed on the image with small clu_size=65536
and preallocated metadata.
size                   10T   11T
blockdev-backup        52s   57s
cbw + snap             325s  413s
cbw + snap + patches   55s   61s

The growth is also non-linear in this case, +10% size results in
+20% time.

This patchset changes access-bitmap into 'deny' bitmap by reversing
the bits within and making the code look for set bits. It is much
faster due to hbitmap levels.

Also
 - update iotest 257: now access bitmap on the cbw filter is empty,
so count is 0 instead of 67108864 (which is the image size)
 - remove meta betmap leftovers
 - report block_status() until the end of accessible section to
snapshot filter, instead of returning EINVAL on big requests

v2:
 - use 'inverse' instead of reverse, add an example 

Andrey Zhadchenko (4):
  hbitmap: drop meta bitmap leftovers
  hbitmap: introduce hbitmap_inverse()
  block/copy-before-write: inverse access bitmap
  block/copy-before-write: report partial block status to snapshot

 block/copy-before-write.c    | 33 +++++++++++++++++++++------------
 block/dirty-bitmap.c         |  9 +++++++++
 include/block/block_int-io.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 tests/qemu-iotests/257.out   | 28 ++++++++++++++--------------
 util/hbitmap.c               | 32 +++++++++++++++++---------------
 6 files changed, 70 insertions(+), 41 deletions(-)

-- 
2.43.0


