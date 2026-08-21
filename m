Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491ECC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxT3X-0002Xc-RS; Fri, 21 Aug 2026 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wxT3V-0002XD-Oc; Fri, 21 Aug 2026 13:29:25 -0400
Received: from mail-francecentralazon11023120.outbound.protection.outlook.com
 ([40.107.162.120] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wxT3S-0003Vz-3r; Fri, 21 Aug 2026 13:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjhwV/NrH+eMvuLyIKI+4Nr8d4QIH4BulXrlEVjZEMP06dfWjsCKiQ9nY8P29/dXiVlpA5ssQYQNpnjsZ2wE+R+fbuHtRX5pQ9YrvWazs1DSzquWwBlboSAWyI6ZJONnrf6lJWtIgflOFrLSaDpbEkkfLkKd2liH1wpcMGfE9R17DmlRJXSZqh2J3V82gQLMMa/7239BfA/4MuURRgBz1YNyJEysuuhuZ18L0D/m09vM0ECoFoj+Ea4gtNcd/jJ552kOjt70W3DFqJJVwhBryXdhpIGJHEvLZ2Ij4LSC4pckzqU+k+cTgtklq1QtQPsImBOu5kc5R1sX7Qpqp99BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oPGRuBFo9wWuzyoR6aoQ1ixMjZwJteV56VDXkea4rI=;
 b=BbI5B41gZkc+11ckmbrXrgW3Ozml66qkMPgqODqW7roIiotFoQEIF3sQeU4/F2aFRwz90o38ftvLEL6d1IhvmKxLxaUVijD/mi2MbCHy0fQrcCuKdYVL4fVa5129NHgNxQuyXdtXn5X4wsqcfVM6aDcMmHbIjYqR8nJETI/l45pYDApWdXjQ4JFGsBeYi45+ywu+yENAVnUQAPkHgOLKCzJy0ZiKJSZvmwGXm8j3dceNqY5ppToxFTmllBGnjd/p2T2YkjmMrCsyJXcUu1E3FJ9J4sdXLvFlVe9Tl1Cp0wakYl/NER8fuxonSULPRaasTVR/Xr+YiOH5VbP11v6V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oPGRuBFo9wWuzyoR6aoQ1ixMjZwJteV56VDXkea4rI=;
 b=isGW5r3/qgLjEZDDxDsaRXBSXHMC3n7v1hh9qI1nhUoCRcRUeFDzQwrAUI/UNJq86pPGr56eClDjozkx6Z2rwI8WY+nHssmQqTokLC2H3GOwLAooZmKy0gTQLyFkUWcIYcCrGpAeAOH7nD3D6MD8iCyeqLK5Q1PaS3sxdpX7PAYWbz5Yqjb+LgLhZ42qE6bME0sxH+I1j6UBaakrY3TRfrNICNNH5KXr7joScVEuResGL+I2tYWyPl0Hqlyujj58r/h+xcguBnOSj72C+jegibicntYvuDMFhrKLZIt9KcGJGm3m1J1EUX6srNN+9R0tKc0U18su1xOf1YUo8ZIEFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB10132.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 17:24:14 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 17:24:14 +0000
Message-ID: <fc6a1e7f-8dc5-43a8-9f58-9e9a8b1da485@virtuozzo.com>
Date: Fri, 21 Aug 2026 20:24:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] qcow2: repair a dirty image when it becomes
 writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260819120558.3870413-1-den@openvz.org>
 <20260819120558.3870413-6-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260819120558.3870413-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB10132:EE_
X-MS-Office365-Filtering-Correlation-Id: bab6cef2-69e7-4a12-c83e-08deffa90592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|4143699003|56012099006|5023799004|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GpQ005UPUVbLtDqUDFbhubVoDDKwfwX6bgU3XVF8J5hc3xnrO+mqUluZJBEe+YZ5K87Fuoua+qsB9pXnnAjlqkpTsu8DmRat8sbyDH+movE/T8gYpcFd9GFsO5uTBbagP+LpIu13TKyxEbRNBrqi/uBJS20h76iIKX5qx+Ve0ZnFu6XDkvmpA8j3/c22pTvatCPi0PebLHl6H8OmGKbOrPzQPk0pyudc2/DXmyFOsI1OyHVPoLWDOtwzCDc1pHDW3FvjRGX4glzAa0/09KVGHYxBHQAf7nkjZvzkQOgVhrTnFKHgqMpPUTo8r2w09iFuivklWARuwXl4CJjXtr+8BFf7txrJewKuqnU8eJb991ojxpv2xQhiQjrcyg1CWL3to/jYmapsn7/hrrP+2FnmY+ab40dTyZtXewqK1E1xjC7UBbihlLgbklpy0Cn+Qn9fr6jtw2sglnem7jMML8P+pWYJhtNiUeGbK4srR7JBIAByyvdjfAe5G65MH5gpK9NANbOB1i3MDpUjZ3gy6nU98uQkIjuz+bs9r5avkI+Msf1kvtmm/ECPJxu2z/Aw699rR8FFcgn+8LzDgibnA7PYVAZGch31wOZ8auVYjCc3/PX6hTlIhU25kv/Qgix2wXbLPznnUw1qXVrJEcey4rSxDocB1uDs7lMS9JDthNoR/Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(5023799004)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9mWE5SNUxpTTh3dzRvaWFtdUNadjlqa0d5RUVaVC9sVHJ2bmFnKzJidzlQ?=
 =?utf-8?B?ekNpSU94VGFnYTUrQ2pMODFCTy81K2tRZ25kWG0xOXdPQkZiQU1lbGFFbkJQ?=
 =?utf-8?B?ano5NlJOZjJYN3d2NkIyZXYrUVhYYzRKOFIwUjV4Zmx5cUFoWncrb3lxeU95?=
 =?utf-8?B?bUxOaStxdzFFNklBblFqUUxSaE92S3dKeWZ5Zzd4VUhPVDMrb1lWcVZDVW5w?=
 =?utf-8?B?eW9PTXNEUWlaVXVZREhPL0Q0czdZZGhmZHlRbkN5bzlaeE1xa09EYVlTSVBB?=
 =?utf-8?B?NjNhM3ZNV0VYSytrS2ZXNWJLUUJBZG9iS2dyZDdDY3hMTEpjYVdrQ2FuZW5N?=
 =?utf-8?B?elBKV1NuQndoNzNRUlJ1WmVicmJUUiszbERxalhrWFBXUSt6eXFOWkNuWmh6?=
 =?utf-8?B?ZStlOEFwbkFDZnlkZ3NwL2V4Nk9YaTdWbzBvemtIc0NhOEt0aSswVUhyM010?=
 =?utf-8?B?YlZtZW5ZREd2aTRneFczYWJKbzNseEVLWGYwZ2tnelNqQndtUGI0Q2llMnZp?=
 =?utf-8?B?Y1JRMHhjWnJMMk9BL2NmLzBaVHhVZ1hTbWtJbXhkOVloRjlqc2hvckxiK2Zj?=
 =?utf-8?B?cGthcmhnNUZrdlF0N0FIbVZBdnlGVVRkUi90Vkc3N3BEK3V4c0FDOXM0b24y?=
 =?utf-8?B?WUF2TjJ4ei8vcitHemVucjRCY2ovaTJxVUU1QjNCRTJkTlFzNUsvUXVvYlNS?=
 =?utf-8?B?TUVOSjU1eDE3ZVdIdW0yaGxBMFdpK3dHNkJWZXVNc2NLQ3VsQXcwY2FROGpu?=
 =?utf-8?B?UlVtWkhoYmNrcVBHSUJQS2ExMG53YWdlWTQvMjFpLzkwVTdnM1Q0MUl5SDBG?=
 =?utf-8?B?Ykg0SXV3OUZsNStMcVV0dVVIMkFoZEdTcE5XZ1lUZmx5U2FOYll2a2g4a2pI?=
 =?utf-8?B?V3FQU01WQnEzYStNYjU0M1lXNnM0Z2JsTnJMaklDTDVKb25KcXd0TkZxcytH?=
 =?utf-8?B?czh0bGV2cjRVNSsxVHdHZXFONnF1bloyNzExS0U4M1hoZ3J6a2tWcERBUUhJ?=
 =?utf-8?B?RHRkUk9uWDRGVWlyanBQSGhCdjE1R0dKYXE0RVpUdUFEWm9XRFNMWkhXbER2?=
 =?utf-8?B?a3B4V01BTmh5WWx2TW9WdFkwYXFuYW8xT3NMREsvTTdBdmVVUGJmd0VVY1BQ?=
 =?utf-8?B?V1NvaUZYUzVkSXhtdVRBdWJUekt1R2ZCOWF3bUxGMXgxNC9ucVBYWHFlei93?=
 =?utf-8?B?OURCWlRrRnNGMEdwTVVSS0RTOFoxcFpXY3BpdWxidTVXemkxMnRlOHVWOW9P?=
 =?utf-8?B?MXM2Ukk0OWJLajBoUUl5NEhBVjg0SHlMS3IyeG40TGM1ell5R2xoQ1lIUlB4?=
 =?utf-8?B?YlU4S3I2T2VQUHg4RDRxbnJxMW1rYXNyTWdrTGVqUGxtVVdtNW5zeG9EbjU4?=
 =?utf-8?B?dHhjK1lCbGxCVWVLOFJRenoyN29NajN4aUVuNnpRbVRIZ1ZQempKNGVOUTBL?=
 =?utf-8?B?NnhydFFmKzIxWWxSeWxkemxzMCtoKzhJUis1MUk0MUR3WGJLSHcvYTlKM0VM?=
 =?utf-8?B?aHd6TlhTblZaMUJocUcwZ29xQytMM1lZNk1jT1BsMzROcm5GMXd1OXhKTVZW?=
 =?utf-8?B?SVQzWW5tRXhqSXBoRUhlaTlNU3BXbXZHdHdzeG8wa3JkVnNTQ2pIRFN1Ry9n?=
 =?utf-8?B?eDhvWTl6aTRxZ0NObTJIN2x3Z2FMV3VXVzY0ODZZOEpHb1hoZWE4OXFscTkx?=
 =?utf-8?B?NWRVcXNSZTNGQ0JhY1BZOFZEMkplSUdHMWlKWi9GSFlrS01QSWhYUTg3UU1C?=
 =?utf-8?B?UjgyekRTVEhUV0I5Tk9qNlI5UVhHTG9IZTRiVXBhNFl0Y1ZZRSsyRXZUOE1p?=
 =?utf-8?B?bU5rUzQrTnpXUTNLTXdTRllnbVROYmVHNVpScUpuejNOY2pJSDBubVpDdEpW?=
 =?utf-8?B?UjYzdTJGSytsMmxaTUdVa0taU01JREJPOS9NL3d0ZkZOVWxGb2QxWVlRTWxC?=
 =?utf-8?B?MXN4MlNYT2wxM2Rzbk82UlltbmkydWh1NlJ5UnVtNGdsQjJocTYra2tvaEdG?=
 =?utf-8?B?Y3BkcmlWelRzODRySkZZUjdWSW9TdDljZi9pTVY4NnUyMHhzcmM3eUhPanJl?=
 =?utf-8?B?dDNxZzgzNitXUW9aTjk2TTNHM2orMTQ3dkJSaXNxall3MDNlOHJFZkg5OEMz?=
 =?utf-8?B?VnA0S0FLWEw5cDY5bzNWRXVEUGljcWlLMHZQT2RZZ3E1V1RIU2JoMFVBOGgy?=
 =?utf-8?B?Yml0UFFXTGxQdUJ2aGNRamJyMTdtU1pnaXY4czBybDlsYXVRYkNHMzVKeFJF?=
 =?utf-8?B?anlWNWlzUm5rQjNJdUpKdjlBNWowajZmMzhOQlVvSzlIV2o2MDRWWEtpSmpX?=
 =?utf-8?B?V2VRdUFyMTlUbTNlYUNMbHdwdDBnZ0FDUTFpMG5IeG9VQi8zdVpZUnFqYmxy?=
 =?utf-8?Q?Zuzkt7obPMVI7QYg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6cef2-69e7-4a12-c83e-08deffa90592
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:24:14.2433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBkC3EhDIisdl6Qo4Rq2Iz161mSzcWFsC1+ccdFG8+4fhQDLxy+pWCiN04DvzYlFOMV2qRxNkdsIcAH2+q4LYW988aa+/xmRUwQseVXiIOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10132
Received-SPF: pass client-ip=40.107.162.120;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 8/19/26 3:05 PM, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A dirty image must be repaired before anything allocates a cluster in
> it. qcow2_do_open() does that, but only for a node that is writable
> from the start. A node opened read-only skips it, and nothing revisits
> the question once that node becomes writable, which block-commit does
> routinely: commit_active_start() and commit_start() reopen the base
> read-write for the duration of the job.
> 
> With lazy refcounts the on-disk refcount block then still accounts for
> the metadata clusters only, so the allocator restarts at the front of
> the image and hands out clusters that L2 entries point at. Two guest
> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
> stays clear, and a clean close clears the dirty bit, so no later open
> repairs the image either. The bit also stays set for the whole writable
> session, so a node which is merely writable says nothing.
> 
> Refusing the reopen instead is simpler and keeps it atomic, but it
> leaves nowhere to go: the base belongs to a chain the VM has open, so
> the qemu-img check -r such an error would ask for cannot take the write
> lock it needs. The repair does the trick in most cases anyway.
> 
> Do the repair in qcow2_reopen_commit_post(), the earliest point where
> the node is writable. An inactive node is skipped: bdrv_activate() calls
> qcow2_do_open() again through qcow2_co_invalidate_cache().
> 
> commit_post cannot reject the reopen, so a failed repair leaves only
> what qcow2_signal_corruption() does, take the driver away from the node,
> rather than let writes alias live clusters. Return the error and skip
> the bitmaps.
>

Nit: qcow2_signal_corruption() also sends qapi event and writes corrupt
bit to the header, and we don't do it here.  AFAICT the code is right,
but this claim is a bit misleading.  Maybe clarify why no event should
be emitted.

Another nit: block-stream and change-backing file also seem to be doing
RO->RW reopen, but they aren't mentioned.  Should their docs also be
updated?

Andrey
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/qcow2.c              |  21 +++++++
>  qapi/block-core.json       |  16 +++++
>  tests/qemu-iotests/039     |  60 ++++++++++++++++++
>  tests/qemu-iotests/039.out |  36 +++++++++++
>  tests/qemu-iotests/040     | 122 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/040.out |   4 +-
>  6 files changed, 257 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 553a94d003..e91523699f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2147,8 +2147,29 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
>  
>  static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
>  {
> +    ERRP_GUARD();
> +    BDRVQcow2State *s = state->bs->opaque;
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> +    if (!bdrv_reopen_was_writable(state) && bdrv_is_writable(state->bs) &&
> +        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
> +        BdrvCheckResult result = {0};
> +        int ret;
> +
> +        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0 || result.check_errors || !state->bs->drv) {
> +            ret = ret < 0 ? ret : -EIO;
> +            /* No write may reach an image whose refcounts are unaccounted */
> +            state->bs->drv = NULL;

Your commit says: "... failed repair leaves only what
qcow2_signal_corruption() does".

> +            error_setg_errno(errp, -ret, "Could not repair dirty image '%s'",
> +                             bdrv_get_device_or_node_name(state->bs));
> +            error_append_hint(errp, "The image is left dirty and this node "
> +                              "holds it open until the node is removed\n");
> +            return ret;
> +        }
> +    }
> +
>      if (state->flags & BDRV_O_RDWR) {
>          Error *local_err = NULL;
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 199efc1e00..9aec081f7b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1891,6 +1891,11 @@
>  # size to match the size of the smaller top, you can safely truncate
>  # it yourself once the commit operation successfully completes.
>  #
> +# The base is opened read-write for the duration of the job.  A dirty
> +# qcow2 base is repaired first, which reads all of its metadata and
> +# holds up every other request while it runs.  The command fails if
> +# that repair does not succeed.
> +#
>  # @job-id: identifier for the newly-created block job.  If omitted,
>  #     the device name will be used.  (Since 2.7)
>  #
> @@ -4989,6 +4994,17 @@
>  # transaction, so if one of them fails then the whole transaction is
>  # cancelled.
>  #
> +# An error is also returned when a device cannot be used once it has
> +# been reopened.  Such a reopen is not undone, so an error does not
> +# always mean that nothing has changed.  A node the driver gave up on
> +# serves nothing at all: it keeps its image open, makes
> +# `query-named-block-nodes` fail for as long as it is in the graph,
> +# and `blockdev-del` removes it only once nothing refers to it.
> +#
> +# Reopening a dirty qcow2 image read-write repairs it first, which
> +# reads all of its metadata and holds up every other request while it
> +# runs.
> +#
>  # The command receives a list of block devices to reopen.  For each
>  # one of them, the top-level @node-name option (from
>  # `BlockdevOptions`) must be specified and is used to select the block
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index 3d0c073d65..3f37c36ca8 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -33,6 +33,7 @@ status=1	# failure is the default!
>  _cleanup()
>  {
>  	_cleanup_test_img
> +	rm -f "$TEST_DIR/blkdebug.conf"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> @@ -176,6 +177,65 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
>  # The dirty bit must not be set
>  _qcow2_dump_header | grep incompatible_features
>  
> +echo
> +echo "== Reopening a dirty image read/write should repair it =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +# The dirty bit must be set
> +_qcow2_dump_header | grep incompatible_features
> +
> +# Without the repair this write would alias the cluster at offset 0
> +$QEMU_IO -r -c "reopen -w" \
> +            -c "write -P 0xb1 1M 512" \
> +            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
> +
> +_check_test_img
> +
> +echo
> +echo "== A read/write reopen must not check the image =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "reopen -o l2-cache-size=1M" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +# The dirty bit must still be set, it belongs to the running session
> +_qcow2_dump_header | grep incompatible_features
> +
> +echo
> +echo "== A failed repair must fail the reopen =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +cat > "$TEST_DIR/blkdebug.conf" <<EOF
> +[inject-error]
> +event = "none"
> +iotype = "write"
> +errno = "5"
> +EOF
> +
> +# The repair cannot write, so the reopen itself must report the failure
> +$QEMU_IO -r -c "reopen -w" -c "read -P 0x5a 0 512" \
> +    "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG" 2>&1 \
> +    | _filter_testdir | _filter_qemu_io | _filter_generated_node_ids
> +
> +# The corrupt bit needs a write of its own, so the image is only left dirty
> +_qcow2_dump_header | grep incompatible_features
> +
>  echo
>  echo "== Creating an image file with lazy_refcounts=off =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index ce8ee57721..cc6ca3ab95 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -79,6 +79,42 @@ wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  incompatible_features     []
>  
> +== Reopening a dirty image read/write should repair it ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +incompatible_features     [0]
> +ERROR cluster 5 refcount=0 reference=1
> +Rebuilding refcount structure
> +Repairing cluster 1 refcount=1 reference=0
> +Repairing cluster 2 refcount=1 reference=0
> +wrote 512/512 bytes at offset 1048576
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +No errors were found on the image.
> +
> +== A read/write reopen must not check the image ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +incompatible_features     [0]
> +
> +== A failed repair must fail the reopen ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +ERROR cluster 5 refcount=0 reference=1
> +Rebuilding refcount structure
> +qemu-io: ERROR writing refblock: Input/output error
> +qemu-io: Could not repair dirty image 'NODE_NAME': Input/output error
> +The image is left dirty and this node holds it open until the node is removed
> +read failed: No medium found
> +incompatible_features     [0]
> +
>  == Creating an image file with lazy_refcounts=off ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 5c18e413ec..452c87f9cd 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -951,6 +951,128 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
>          self.vm.qmp('block-job-complete', device='commit')
>          self.vm.event_wait('BLOCK_JOB_COMPLETED')
>  
> +QCOW2_INCOMPAT_FEATURES_OFFSET = 72
> +QCOW2_INCOMPAT_DIRTY = 1 << 0
> +
> +image_size = 4 * 1024 * 1024
> +dirty_base = os.path.join(iotests.test_dir, 'dirty-base.img')
> +mid = os.path.join(iotests.test_dir, 'dirty-mid.img')
> +top = os.path.join(iotests.test_dir, 'dirty-top.img')
> +
> +
> +class TestCommitDirtyBase(iotests.QMPTestCase):
> +    def setUp(self) -> None:
> +        if iotests.imgfmt != 'qcow2':
> +            self.case_skip('the dirty bit is a qcow2 feature')
> +        iotests.qemu_img_create('-f', iotests.imgfmt, '-o',
> +                                'compat=1.1,lazy_refcounts=on', dirty_base,
> +                                str(image_size))
> +        # Killing the process leaves the refcounts of the written cluster stale
> +        iotests.qemu_io_popen('-t', 'writethrough',
> +                              '-c', 'write -P 0x5a 0 512',
> +                              '-c', 'sigraise 9', dirty_base).communicate()
> +        iotests.qemu_img_create('-f', iotests.imgfmt, '-b', dirty_base,
> +                                '-F', iotests.imgfmt, mid)
> +        iotests.qemu_img_create('-f', iotests.imgfmt, '-b', mid,
> +                                '-F', iotests.imgfmt, top)
> +        # The commit has to allocate for this, which is where the stale
> +        # refcounts hand out the cluster holding the data written above
> +        qemu_io('-c', 'write -P 0xb1 1M 512', mid)
> +
> +        self.vm = iotests.VM()
> +        self.vm.launch()
> +        self.vm.cmd('blockdev-add', driver='file', filename=dirty_base,
> +                    node_name='base-file')
> +
> +        self.assertEqual(self.incompatible_features(), QCOW2_INCOMPAT_DIRTY)
> +
> +    def tearDown(self) -> None:
> +        if self.vm.is_running():
> +            self.vm.shutdown()
> +        for image in (dirty_base, mid, top):
> +            os.remove(image)
> +
> +    def add_chain(self, base_file: str) -> None:
> +        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file=base_file,
> +                    node_name='base', read_only=True)
> +        self.vm.cmd('blockdev-add', driver='file', filename=mid,
> +                    node_name='mid-file')
> +        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file='mid-file',
> +                    node_name='mid', backing='base')
> +        self.vm.cmd('blockdev-add', driver='file', filename=top,
> +                    node_name='top-file')
> +        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file='top-file',
> +                    node_name='top', backing='mid')
> +
> +    def check_base(self) -> None:
> +        result = iotests.qemu_img_check(dirty_base)
> +        self.assertEqual(result['check-errors'], 0)
> +        self.assertEqual(result.get('corruptions', 0), 0)
> +        # Without the repair the commit would have aliased this cluster
> +        qemu_io('-c', 'read -P 0x5a 0 512', '-c', 'read -P 0xb1 1M 512',
> +                dirty_base)
> +
> +    def incompatible_features(self) -> int:
> +        with open(dirty_base, 'rb') as img:
> +            img.seek(QCOW2_INCOMPAT_FEATURES_OFFSET)
> +            return struct.unpack('>Q', img.read(8))[0]
> +
> +    def test_commit_repairs_base(self) -> None:
> +        self.add_chain('base-file')
> +
> +        self.vm.cmd('block-commit', job_id='job0', device='top',
> +                    top_node='mid', base_node='base')
> +        self.wait_until_completed(drive='job0')
> +
> +        self.vm.shutdown()
> +        self.assertEqual(self.incompatible_features(), 0)
> +        self.check_base()
> +
> +    def test_active_commit_repairs_base(self) -> None:
> +        self.add_chain('base-file')
> +
> +        # Without top-node the whole chain commits, through
> +        # commit_active_start() rather than commit_start()
> +        self.vm.cmd('block-commit', job_id='job0', device='top',
> +                    base_node='base')
> +        self.complete_and_wait(drive='job0')
> +
> +        self.vm.shutdown()
> +        self.assertEqual(self.incompatible_features(), 0)
> +        self.check_base()
> +
> +    def test_failed_repair_fails_the_commit(self) -> None:
> +        self.vm.cmd('blockdev-add', driver='blkdebug', image='base-file',
> +                    node_name='base-blkdebug',
> +                    inject_error=[{'event': 'none', 'iotype': 'write',
> +                                   'errno': 5}])
> +        self.add_chain('base-blkdebug')
> +
> +        result = self.vm.qmp('block-commit', job_id='job0', device='top',
> +                             top_node='mid', base_node='base')
> +        self.assert_qmp(result, 'error/class', 'GenericError')
> +        self.assertIn("Could not repair dirty image 'base'",
> +                      result['error']['desc'])
> +
> +        # The base is left in the graph, and nothing can be queried while
> +        # it is there
> +        result = self.vm.qmp('query-named-block-nodes', flat=True)
> +        self.assert_qmp(result, 'error/desc', 'Block device base is ejected')
> +
> +        # It only goes away once nothing refers to it
> +        result = self.vm.qmp('blockdev-del', node_name='base')
> +        self.assert_qmp(result, 'error/desc',
> +                        "Node 'base' is busy: node is used as backing hd of "
> +                        "'mid'")
> +
> +        # Marking the image corrupt needs a write of its own, which fails too
> +        self.assertEqual(self.incompatible_features(), QCOW2_INCOMPAT_DIRTY)
> +
> +        # Nothing can use the base any more, and that is what is reported
> +        result = self.vm.qmp('block-commit', job_id='job1', device='top',
> +                             top_node='mid', base_node='base')
> +        self.assert_qmp(result, 'error/desc', 'Device has no medium')
> +
>  if __name__ == '__main__':
>      iotests.main(supported_fmts=['qcow2', 'qed'],
>                   supported_protocols=['file'])
> diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
> index 1bb1dc5f0e..f3cbf73a01 100644
> --- a/tests/qemu-iotests/040.out
> +++ b/tests/qemu-iotests/040.out
> @@ -1,5 +1,5 @@
> -.................................................................
> +....................................................................
>  ----------------------------------------------------------------------
> -Ran 65 tests
> +Ran 68 tests
>  
>  OK


