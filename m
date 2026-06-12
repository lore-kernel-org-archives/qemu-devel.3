Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C0CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY56Z-0001di-L5; Fri, 12 Jun 2026 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56Q-0001cD-9S
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:37 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY56O-0000Xb-Er
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beWAtvWZUkfp0OLGCOcZfuu3lUAFo2YNu2umDrazGvb4SouxNQGNhXcSlzTGcAMRbh35N2Qd/Oe57t+k4SmmVmc5RHdb5d8JPchLlSeBFqTltEvcXzk3ySI3Jwtt3i2WBDluYAs/fy4dk04b9+Eq/P+cgMyjI5vlsV90o6vBscZPzbupGFAgfPJKwbnqIkLQihH6o8wcU88q94aYf5DAKbXx/OGBdDaDdg03/30crpf+dLUEjiEEoQ3xaOkTG9kedBX2hXASxaq8BhTAR3zrJSppZ+782Vz7PNd8Svd/7Bz06DpNo1QpUJs3ex46V9scImfcb2zvFVQPC9avjQG4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8PDz39MUwantAnR7Oyv98GLfJIA/BgwOtM1Ii3/JoM=;
 b=UssudpP4Ph4BlXDjXrOChnUPKMaDjsRdA7FHMPqPqUF5g6RCZigVABo7MiaPjKqM06kGfKqTap6L4v4h5KAwHUlplc8uS/c8UYdBROqHSwr1kAIDZaOMTuhesIa5ow8SE8J58tssT/9ZA9AuLAZD0+VfLd7C8BjbBW198zEkjJYSCqWLGCRz7TePgmUVtpLCXc4EojF78CVOM85Hn+P/unFeqOYElZSmAhbpxcWq6S/eUbwOT9V/j1Ci13/f7EmYyJQuGkzqr0hLq4GrxHmqWppalAUl5tfGdjAv8zzdijFdJaPU7BesuXbZrLHvxdhrEbitRMZfuj08U+T+Teke2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8PDz39MUwantAnR7Oyv98GLfJIA/BgwOtM1Ii3/JoM=;
 b=vh2zysI7NcmGC0bCXOQu9H9BkXWnXoUXlK9P/z1tJATsFICRijqw9MWPNiUM22n2GegWWjH3sMEmQ31yTq+lixmci5TPxBAStbnM6Eti51RctsSxOi/TUaZE68eCJUnAI6ztiTCdX2JBBbITBy7yS9a4hvZvqjnTTRk0Us0PTgnMWvOqSbuGb1dw74lOYAargqciupeDKT01mX3jaGzZA4Z1+Knc9zhlo8+76YkhqBWPuCtx/ZDGGQQXHMxFlMiWr+le0nn5jt+oSI9h35FB7p1xdVN00BM/a54/Cf7LiHlCZQXgBURIWHY6gXP0B05rtuVkHSAChzuMmxFA7Dnc3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 16:51:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:51:21 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH 0/5] migration/cpr: support vhost-vsock devices
Date: Fri, 12 Jun 2026 19:51:05 +0300
Message-ID: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 751dc225-b6d0-45fd-1a04-08dec8a2d4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|56012099006|6133799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: GAObdp+ZydeQKjz022vNNW+XUfvC7I356d/E+g1FKrw1wagnoUOZ/zrYzdpTABO5LN24h8yzAcF+d6BD2v+7ANxiaU429kv/8l30Fu+w6tQtJjV4Tk6dW2aVLnD0+bXaK9itQsNKApygpplZGTBJIlxTPIVovkANoywCDfH8Pyr7Lt+3DI9qAqByU600coijwHwRzOIfDRYyuc7WVOIqSIF1irIgTZpvanVcLroSHS2GKrxi20IHDPd+paAXwiW9H7MSsTb5GR29/u1GYhk4tjI7bmeUwoUtcdYrZCfr1vsBS457hThh1sbSzTOW334NElIfQZ+jBNtROPFxdWRrhO32WFrePP2d6FeHeGI8N2CuRNKjVjLePFf7zvkWx2Qrr5PUSb59E/nau78xDgXJj0T2mFvWtW68eiBPjiVsK4fmf7yZS94m16j1ELrOwn2mzKzjj81PyDMdbB4dv9ryCSaIklClOCRx/my2o/+S6rpe0Ewcw7nML8wqXcPpWxc/vMOx1KXqw+57noYs31z6/Efd6Uzd7UYsRiyU8COOPIWt7yE9ELTWg7Ko6Mt1w6m+e8RnxSNbcM8LNSQxvKHaLhVSDUmBux57x1fPdofc7cG8kunIcpsaQhyx8C1SwInP900OOtmAyekFLrlrKrUh4RPxiPjKHutBIPZvwV+F91idXaCXYXwnzYsa/+QzUzFx3U4XelE1xZNIXxw9QLcfsP1NK43DIeP6wTa14gOAD0oZIqdapmB3bKp+Hzp9ZqIw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(56012099006)(6133799003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bJfeqibGPAHS2vO5A5QHsmvvdPjgk/Cx2SbP34j7tRcYZ2TyY9+vOGt6f5P?=
 =?us-ascii?Q?wqZCPG72c30Ib9087es2yGHkBoTY0xWdZSZIVnNF8yEbH3D1sUozFd4rZ04h?=
 =?us-ascii?Q?6OZK3fhAH6s4C5fAtVSD2JED96NsX0yWSRG8VI/qE59GokEuaL1oUq+dYOye?=
 =?us-ascii?Q?teR4XPYQE7dic+6fbirz6eutDscFPnw5Wc0dxg8k/fz+nQA+0aAjoKkqfIRe?=
 =?us-ascii?Q?Uk9omBeUOAmqUT2GD6FSV0V+bCcaMZp6zzuxpRH+XmE7w1uwHrfDDEcXClFO?=
 =?us-ascii?Q?/CxMNVbcmjVoHJ/FO9prjGODSekXCzEgUqyfPmh8K9JF+iuVF36C9W738bpc?=
 =?us-ascii?Q?yuwWo9LrPgCAbswtL1Xw31XnagUnXZqvwKuEHqQ9CZa+NvbjZNB56KlQEps/?=
 =?us-ascii?Q?UE6zu1qJ0UIC5zuW7gNzv4VJ86SiNL2vdny07RymsGKOVk+XzK62iOhkOEOr?=
 =?us-ascii?Q?KdMhmoeLF4uqdPtu28DPkv73ixcVb7dGbvs0LGMUOKRzYewFTFiFqFIT4OFf?=
 =?us-ascii?Q?yxF/4OCVnFhSs3vKxs9fC4VZPmZWT7R192l2svi/LYCITJ6Tgu25h5kwahDr?=
 =?us-ascii?Q?BB3MNarUckTdXpcKjcVWW8w167DcY5XNBDAazY36G8I23RARgVgOpyTczO+F?=
 =?us-ascii?Q?ZKlU1GGbE7Ubn2Z/bntN3wp37KyIPMO3iFyEeIMUKGsQULIEAqwjaXHCaz5u?=
 =?us-ascii?Q?PYLMR3Q/sY/GrlOrJ89OhJXDWb+IP3tvpM4jDGyvQkRpXQJO1u4ge5eyJYVY?=
 =?us-ascii?Q?tIVrOQIMKYdRsIXPn86EmmHcgpULwXOoUJlWpa9coEnMzVV3PeK7eCGwXM7Y?=
 =?us-ascii?Q?ha41SJ66I+KhwddppMQIaMQSFYxTNuhgoB5Xn1YBfmKkMkrUHt0CYFNwUCug?=
 =?us-ascii?Q?wVdmHp9DzjsGsnpKbrWNOi2Yvk7wp8QL6Ka/PdpN2NQfLvqxclSxc4BDEyhv?=
 =?us-ascii?Q?Z6D912e+t1EzFitz4q4qw0fnHBaLX6egyrJM0F7YJQd1CsAPTFIKaAJh6EoW?=
 =?us-ascii?Q?+HCcdyrlML5TPe/mElkKBfw0DMz/6B7IvStUzwUwzIyyqjtpceqxj6Z/PgNb?=
 =?us-ascii?Q?LfojgtVRM8dyXhrtXgZbhu01m2q7CW2r4cL7zjs/qdU0grpNoEQkEM9jaYym?=
 =?us-ascii?Q?gRdS10tvE1DG7n1dKWfKHjw4kMKOZ5C8ekHgp5aPjWljMHTD23dyFq51fxqn?=
 =?us-ascii?Q?PkFGp+V0tY3RSbxgbp18LaPtwJ0LJxph1sL4AJ3VdmsoL5H0r3rcA57g9dz7?=
 =?us-ascii?Q?w7EoDM77j7A5GIfOg/uJQj+GZjrimfJcbfEQOPJsJH7lUCR+iZVlQWGHhYV5?=
 =?us-ascii?Q?rp6uJXuwvbS+N0ipZWiDLrubpP/e7kVSasDD3UP5uysJlgxMZ2NlnnujQdCf?=
 =?us-ascii?Q?SnmO+YQr82Gvh6cfM/9DysYRuspxwrQxS0TLROaGcenWkb+WS6Jm2WWXNnn4?=
 =?us-ascii?Q?u2PjLIymMzNqS6OduxTnz4qVMxE0YMHiMad18dnfJz4lFV6w49F9haAoY3wI?=
 =?us-ascii?Q?xSt4vJEEDr494mobPjH9JyzihpyDW6nw+93O93fzXhZQnOLY8hXATGSASZ83?=
 =?us-ascii?Q?h4N7+R4Sg46wM7+5RBgrFzKCUy0MSRbYSPkfBM8zyD7MyqcxyG8ymC2qpa9x?=
 =?us-ascii?Q?ST2tJlsCgb80Tw7duI6f3wBaUFhDYDXvwnphU9TAW9/GhRvMeo8bgJNIO0Et?=
 =?us-ascii?Q?Hi+SYy1OTcLqliDiY5fP8mtG7gQuqQ+nmHG57k3AiDinPPTLIE9l1mxlPY3o?=
 =?us-ascii?Q?mZ/AObl48FP7oNwvyLpVbohqckeKc0E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751dc225-b6d0-45fd-1a04-08dec8a2d4b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:51:21.4878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z9O2w/8ebCS+GKGQWGlozyxCAbhWmnKmPMVBn/M3LO2ZxwvZMaqaEyMDLtUXQ/yEmiValtomu8vEZgYYyn3UVRlVXruezwD7TpJav2a7xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Host<-->guest connections via vsock sockets aren't yet supported for
live update / CPR-style migration.  This series adds such support.

It's based on the vhost-related basis submitted earlier by Steve, Ben
and Mark at [0].  Patches 1-3 are rework of this submission, adjusted to
the latest master branch and with respect to Fabiano's review comments.

Essentially we want the host<-->guest connection to survive the CPR
migration.  For that to happen, we preserve the vhost FD and issue
VHOST_RESET_OWNER ioctl on the source side before the VHOST_SET_OWNER is
issued on the target.

VHOST_RESET_OWNER is currently not supported by the Linux vsock driver.
We've implemented this support and there's a kernel series complementary
to this one.

I've tested this (patched QEMU + patched kernel) approximately as follows:

  * Run listener in the guest:
  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin

  * Run data transfer from host to guest:
  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999

  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
  * Check that file hash sum matches

[0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com

Andrey Drobyshev (5):
  migration: emit SETUP notification before CPR
  migration: stop VM earlier for CPR
  vhost: reset vhost devices for CPR
  vhost-vsock: preserve vhost FD during CPR
  vhost-vsock: don't reset connections during CPR

 hw/virtio/vhost-backend.c         |  6 ++
 hw/virtio/vhost-vsock-pci.c       |  5 --
 hw/virtio/vhost-vsock.c           | 42 ++++++++++++--
 hw/virtio/vhost.c                 | 33 +++++++++++
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost-vsock.h   |  6 ++
 include/hw/virtio/vhost.h         |  1 +
 migration/migration.c             | 96 ++++++++++++++++++++++++-------
 8 files changed, 157 insertions(+), 33 deletions(-)

-- 
2.47.1


