Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF46CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWsn-0007kr-4s; Fri, 19 Jun 2026 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsl-0007kQ-JC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:31 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsk-0003Ts-65
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa+2Zrv7tOzLP691j6RTSGvuRJ5icK8np6d+r0Hr917ROdmpExHGEqynNI/iQ0hD3FSKNdtl9f5qD5w0WEahyXDbRWZ/eHxpO3/ii2Jb0dWwj+2jvj8snkzWFP5L8NUuYMJekMTnkyCDn/KcskaMhlP8MFa0QRyUYd1mKOo3AThhr2ns41UOOrQV98wXdt3Hv2EiFQ2bhk9IoyQmJuEPSKfAmNqqieKQN6AKYMJKeZBZXQOFNSUeXHpXFuCg1hc7SaXiOlrze1VvD83D+/qVgiWr+QRV+Kk0ciECaI+2CjSK7HmL+s8BJP/ciQ5yHR2h6cyo+GmacwNjHziwLRIrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMvy8izzx4joIK4zN8wYJJAuCwU8xeCyaabECwClFNw=;
 b=YKCYElND6gu/iMcLECg89x3Jh3/40E2unX2ROD6vaqNWfn4lHy3xVDbLGdRoG1N5zL6pek3tpZX5Uz8S48oKyAGWQwWcMyu5ZCqMfBBZdS09vW48k0xtJLvoGgVCOACL9S/kHBH0L+cMP8UFHcySrhBMFpxFKjnznb37C2wp1BFWt7Mtl6XjmQ74TXeKnx34470g5jwQEUbFpApGd8tyb5G6Vr0oZR1Nvtd5Wz7DMftlLZKvFZJLtg/YSuMVwX11Fud746zOo4Lx9X/5/nYlgl+l0Na9AO3h9vWmcKQdh3fKP0amCwSKHTvmxxTmQxcSVmFYNsdG32oXbmRIS3H6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMvy8izzx4joIK4zN8wYJJAuCwU8xeCyaabECwClFNw=;
 b=EbOqU3CkVPtWt4aS6IFvuMLlkbg1Bc/KSfbwS5b2dW+aABzeURW5vfMKsNb0107Ygut2QTFlLUsL93pCprwA60WOupqtyBn5fIwobgikAIPZ1L+Ninc4yeN6jIi232ncc01i1sL18XEwfXYbjzoC8w/gBWjMKIb4aGrpn5v+jYwmYsodGSy0ZaAs2WxivfSwTOP5v7UtEHcgveinQva8SG15HYODA9+5CjSd45N6145u719pkAKoYSmISbUFoSuJUi8/g7jxeWeB4wL1HfpxLKu2heFX8452dmd5gHwq3Tlmxj/85aoGu9JL60LXVw4ruScPJUh8aKpdR2S+qyHhrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6576.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 10:55:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:22 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 0/5] migration/cpr: support vhost-vsock devices
Date: Fri, 19 Jun 2026 13:55:09 +0300
Message-ID: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0089.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc311ac-fed1-4f20-27c0-08decdf142f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|52116014|376014|7416014|56012099006|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: t1+rg+k53VxYpoDK3W9qD9aiD9ZBRMtE/l7/Nk93ZHARElFEZPBy3aLzYlCWsuy9+oOKA32nzaIzkMI7rkr0I8D+NNdDKsKGBoKz1FAzPY5ZPD9plz0mNERvdzI01xELGfEtYud7LFM8zF0gk8cUxWGKpEvyZjNe1p2XGX7xHRs96xGzZg5KN4HIeIHX+omX/PjDaNyEjYDWs2WkiPYLvjSvqLOwR4tGgfsjheDqarrq3Xz5UVA3SvZu38WazchRr1a2Z/JoYATUxRH9c6soiKQy6BLiYEWtuq+A+WI08ohboW2EyW1nR8YuKxwX/YuafBoXbG85MlkWWTBPgVsTE1Sxfu2508GgGKW5CRBv0A3e9ujGaNTp5xIIrNX941gh3/I5UOfGQAod9T0ieeua8gOI6EvttkaPr1EM0/bCMEa7ks5+mnz5djrvr+54k7rzruK0/gnYglyUJEIkB0ZlM1NArFnqGfUuDcflcuIif0L0kVIr6DeMN1gmgAmB/Aw5urHkbviwfUAgGeDLo67pPH7BdvcvvbKGfyr8vUrGTumeUyRtGziOcupaatXXvDjmOhtaGrXjyKTrl2KHNTyPbVIvWmVtkiT94/zqNeCvVfp7d9nIUON4Ic+9A9CSfMDe8TYLdEIzuBHshrsdAm4E4uDbGdAky3BB6NilXVWW+oGwqU4Ox3dmGUKaEqc2Rlkg72GkA14w7J0NP13SP5KuV8+zH6ciuEIIixcxf3SYT2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(7416014)(56012099006)(18002099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOZXeq6JvevfDDtO1XmfWItV45m7FlHZkVR7w7y84/inMiY/WrRrkEj02iu0?=
 =?us-ascii?Q?THvPNqmflhNmqL3LcuhC2pE5nmgnhu3pLdXyKPNAt2P/qYRX6UqWzXHvNE4m?=
 =?us-ascii?Q?DsUKFY6WLxqa5IpTU3HgJlUVPHU+F4SfqSdkSUZcY4+1ztcqATHGM8Vvb4g7?=
 =?us-ascii?Q?ra2SkExaoD77U4XNOcRzbqnJOp8phkJg60hoOsI2CbtMOgg8X/Gl2zY8zHbS?=
 =?us-ascii?Q?ULXb+wFQ5lGahcVP4psMu/lhfIonIYpz5SO6jZNs6ysrMUQewI8K/3fMWAMc?=
 =?us-ascii?Q?j9sxvkzpQeTKi3uCIOGXJb4Ue5ImcCZoioVOUai8sne+p8EXa1pA8bHe+HAK?=
 =?us-ascii?Q?Xtze64tDlLnI+wCoxvSMSvgBzlXZSKv7GtbE2XtRItvvCZFwc1TXFMkUzx1s?=
 =?us-ascii?Q?edW2TQEGzSpDS4+OJwSEapCYGUcIPohboy1GTkJGK4IZWmdt2TlFTweyV0rg?=
 =?us-ascii?Q?9sB9BoCBmc4X/Lv98MthRwSfTjl7DwUPuWq0ulX6AD/2YlsTKERyFPpZYOHL?=
 =?us-ascii?Q?JDilQMFC+MM2JUPLy/I+QPKbbLQsSYT944tHpgodIgNMLucvuwMmEBYoQJnc?=
 =?us-ascii?Q?Q8F66CXzvAed68qdDEEz8LPN5ED5x/bj2wswJwAYDOT2hvaPf9TgH6a9X6qR?=
 =?us-ascii?Q?RFmUd11JjDTkl4ICOp/4IsBb7FMJwLrtIxm87ye2yN5+iGez445Plcu8IB4Z?=
 =?us-ascii?Q?km/uHAFQA9hRSlETjvvecQnMjpPRhhEGERH1I6ArcxyOiFZqUJ7lr1vQTSfH?=
 =?us-ascii?Q?SoqDi8QS375lSvFLoxtTRwtaMXVHFS4o67LWkTCHoSs6RYTS/IOS/jfQGQ4q?=
 =?us-ascii?Q?pSp9GqpWKEFQs9Pt75zeyUrEClHyUVks6Jjh1tYJgxC4iwk3XQ/7vmDVDKWN?=
 =?us-ascii?Q?pbHo66wuoUuHSVB9yJwD0EuHfHAnXx1KBypeB7JymDAgT4F7/x9hhjmRCUBx?=
 =?us-ascii?Q?zdtHZvMJbYuxGKGldyQ4xOaozJztZ1aR0pjCnHHtAztMCDklkzyEiATx0G0P?=
 =?us-ascii?Q?q1NTl3HTXQt+XZ7TLjpI0B0gpnX3C1FxGSXz34Dki0BA79FD0BcFmHj6L22p?=
 =?us-ascii?Q?s4ZMQAe8EW6XWWdeQF++iWjuOZXzibjD3ojDKIX/ZYKxwafmcLILJij2+JFb?=
 =?us-ascii?Q?EwbtRLPq46DnGf4GDV9DzMuNjezOvg+0VaixYjl9HdwVpNOABPcivqaJIjbe?=
 =?us-ascii?Q?8h/zsrnqSXsDCPxZSnDjZl3SW03C6dHrs0XW0ltg5KGqNXneT0S5y+ZnFqKr?=
 =?us-ascii?Q?zbJTKJpCOJOMnk5mnePhSVnQ0I2aQQptkPBg7YJhp0MYI99NnVTPXyQj23Tu?=
 =?us-ascii?Q?d8pjyV4sKbo62Q2+Y4yFx/AjJ+RF+tEL66eJpFDKXJ1eDnLYhlirS7R1xWJP?=
 =?us-ascii?Q?LTsOSsP3Izo2NfTaKDbUeS7KiZFa8RR1HTUADos+EayIr7Dd6zZJgPnXOJGq?=
 =?us-ascii?Q?D7ZgkDcRT9YP0TpE6wm5eLMC+QIJl65jYaHYwGfQ6YrDMEdIt+vL+oWSL3Al?=
 =?us-ascii?Q?+6kDxAVrKSkt4/nxcaIpYLeElcth0G27DAN+e609up7NkZsEpY9kBs7fAvBb?=
 =?us-ascii?Q?8b/GwyUXwNZ5wJPjq6whUNmqYFlEW1dMZeBbi1reqT5Z15MPWaXzl/W35+G0?=
 =?us-ascii?Q?jJh1qPVR9HiCqxaLr1RBgJ8VC3pwgosU+6KQGvsDjZuJKnOo7sa/6w6VtW9o?=
 =?us-ascii?Q?QElNPO+nDkvbcJhBveTUywllb1cDyu+Lil0spwEyo2+oVpq5DcdKD/HyXSXw?=
 =?us-ascii?Q?Y0HfKkfusBh9Nzb8iNDu0bswefwtUFg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc311ac-fed1-4f20-27c0-08decdf142f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:22.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: higx1iLHXHvBUF2LFn2KwdaiSVV+GaRyUplyqXx2DFqwIC78VIlNXdbDY48EwOuleNt+q8Gycs8ERPyny6r+j2vT93ho+7u/1Cupdg3QSIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6576
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

v1 -> v2:

Adjustments on the issues pointed out by Dongli:

  * Patch 1: avoid emitting SETUP event in resume (postcopy recovery) case;
  * Patch 2:
    - gate vm_resume() op by checking that block graph is activated already;
    - reword commit message;
    - adjust the comment.

Also:

  * Patch 4: use more generic proxy object qdev_get_parent_bus()->parent
    instead of container_of(struct VHostVSockPCI)

v1: https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com/

Andrey Drobyshev (5):
  migration: emit SETUP notification before CPR
  migration: stop VM earlier for CPR
  vhost: reset vhost devices for CPR
  vhost-vsock: preserve vhost FD during CPR
  vhost-vsock: don't reset connections during CPR

 hw/virtio/vhost-kernel.c          |  6 ++
 hw/virtio/vhost-vsock.c           | 40 +++++++++++--
 hw/virtio/vhost.c                 | 33 +++++++++++
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost.h         |  1 +
 migration/migration.c             | 98 ++++++++++++++++++++++++-------
 6 files changed, 152 insertions(+), 27 deletions(-)

--
2.47.1


