Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2093EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9mp-00053e-KV; Fri, 26 Jun 2026 12:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9mk-00053C-0e
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:52:11 -0400
Received: from mail-francesouthazon11021084.outbound.protection.outlook.com
 ([40.107.130.84] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9mh-0000XZ-Ni
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epv1GoLTQ6ehb/2rsacHZ+u5yx7KsZTym6wPQe9Jqn33Izyt8FnSOZEEi4dGWBU1UM9qy7uU/R1qltcBM7YQbhOu2pWEhoywFp0jdRz680UQubDWpJ+B5/VDd8slGZ1Y0OkP0jt8F3Fzmkc6PcCX0DFGwEy6Yfwsz83vq5RYVTlCMB0eT3wJqw8u+r6ILXr3JMRZgn79zWi4NRu6kFHi0MhJFiDbaxlP/5JKo2kLo/p4SMcufxtxLTspJb5M8sLsHsxhsRRWyDnxBDeECBBa8sttkcUatOKR1rC8ftxaycogDCVxa3jCrDfL6Pqwyra/tnGantgIbAIv7XoofeD0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68+a8HDLKKMa0Pi9XFtlGx+7enOOX2j9Fc5VAyYn4v4=;
 b=MT5IItziLTEKfBDLWoNGhwWlwA29VMtXwSU2+uq9opgLOH6cB+RsJb8PlkOxhJTbt/anaW6LeFoEvBpsw5MGa0QKEo9nZyibOr3Qp99vkTf4Qyrd8zx/yoMoYnRCso5gOcbyD9+9+TFlpzyNpQnRYMtzlLDWTXi7uMx+XhLvcgjp9dQXKRCYbw2ZmmpkZi+1crJADJoa5jQXo80aO+GMT9YP8ciBgUTmpoSO+vkwrhaFlI3WfLSdNCDPsZmvUAT5U3R2VhXIdQBfHZ0vQh66zUxYL1ThDL6EsvFtN/Q0DKe5oJQZxa8z6YaW2dEjX/V/fMpLrLxljv/hYGM0t1w9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68+a8HDLKKMa0Pi9XFtlGx+7enOOX2j9Fc5VAyYn4v4=;
 b=tp4NLlAfuRBNjy/h9ZwL32MOFQnphs+SfRUqFp2Hv1WZgkT0Vu1r424EzZVsVm5BNAhv06EYDJAYde3HcuQGdO2woLZTOYvDs72i5giPO56dBuf7c+t61vOsM1OqWUEfekHtpwQRY3jbU59vfwfQiMluLMS+cSKGxbdC9G8j4kMMcFJYetBnrq2tRap0nEghVyBVh2trHlx4O2qJU/IEq1MMx5vle+411egiOTwHlwOlu/xIiIs77qCkGBX2l+jl+uk++gomJd5P7Dly2e33fT4geDBBp/lSTSduWa4YCJ0Bpo+SPQBvo6oFs7shX/hrGgmoZdZx7pRjuMl/kNzhKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:01 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
Date: Fri, 26 Jun 2026 19:46:36 +0300
Message-ID: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f8c647-29a6-4b6b-7a25-08ded3a28b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: jJ8fAdmWoDlLOaRPCFlXFTYRiQPmPxf9/oobasxbJzhOi4zsU20Wp4ngOyb8Fq7LDuuB1HvEN8bOLMPtS5PnWYewI1mP8ZSqzKx1wiKiYL0uXryUlg0jj/1l+VJwoU2rMoT/ANL7nUPOKDXxiXaVh3x33PhaT4PziD0ZtDRUxDkfwQA5I4/jH7L6wXmCbXHE/vKyp15q/XgOU9owfEoJQ/7h14mTNo5OTkObf6j9sSfxnb6/hbgS3+D8WW6mOtrmJWaduVuppTXtG7OZxGfBVMoCHU/my7qYwUh1dYfng9Wd6UKzApbIuCV1RqMvnBtT7y/VZKb5rbsejko2lrBAwT/lNJy2NlAsvS4nzCevHGxmcYhUNLtvwz6On6yO554gaEXxeNRB9oBe0dIhFwFXF6SWalNW6pbJnlFDkX2HHB56sPC+JE08HFe2+a/BLy5ARD4dN3m1ihArZGop3Bv7nO3TyyxNemwc2ZJ2CS9Q/5SKatrvIXPL3/wUoocZ858vsHVmnEoPjgPDP6raoBtnPC1YWeqbGH7+0Tut0PEiV57/6A0JVKIiH0Bc+510ytSdUXbeWRM+ruY00SBTDqY7ID8uJ4DJt/xqlacyea8d90lUHsNfcMGvG0MPLXnwqW2WLilv63SRHyGxtcAIupOLT/NlVP+1dMkraeqjju1mvLTPhsqncWZaIVm53CEGOri6+FAsG4T9mP1ymMxphUK5qycZKgmajehI30sRX3HOfv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E/YyobwqICuBqcADdhr0GHUtQh9QQnqSJvCnyQenUqFDBB3HI4bzILxtkN13?=
 =?us-ascii?Q?7ScFS9kw9UMruLMQEBoaQAxvW08PD6tWbIc5mdYvc0dPe7wkwiNs5jFOodYD?=
 =?us-ascii?Q?wIwkMZbFyfWuVK3BlhNeYTs0XLDhhT90NmaOwf8bqK3VPJBdv+iywTIwIwP9?=
 =?us-ascii?Q?Th7kv8hhdH3AcvQLFBuKZDsJz5PqAK2wfCALezHEEYNwIa2ptNDTFgy4QuV7?=
 =?us-ascii?Q?lMeVA/JTIzdSqagRwViPFx+xv77lNgit0aYWuBREwfspXNZlob1aK8N4OgXP?=
 =?us-ascii?Q?bJ2pU52S2yNQ4SxAzy3k3huiCIsP5+ZwL+S6UW+XBvLFkBU0M3zfSIxvGEmc?=
 =?us-ascii?Q?+I/5QhD9UV1riM0v+6Opw0n9ddJDmanLRNJmkfLw3zZmMn69FHie2VDi/FG7?=
 =?us-ascii?Q?7PTqOZqwxXtDtb7KCrjUkk5AN6wGXXfoT17vE3ghKu66lOQdrXQDAXpivZMP?=
 =?us-ascii?Q?gzHvKqvWmtXIhFSKl1Mrv7Neq5tveniU4he/dlpIAg7+iXfxZwIzmXFwDA9o?=
 =?us-ascii?Q?rI2s3CrtuQEHhOwoEzCkd/9EbPoTHjoXid7hQYMbRgGqoFHUsgSXMQp8rGuB?=
 =?us-ascii?Q?qxClciuJb0JGt0aXE7ASIfUV3YszUaFa5l8+mloM9X77UcC3z0wu0yRXxOis?=
 =?us-ascii?Q?jeBO6WxdFQDI714CUxzHSufHOPOYHYxDgkFHisf6ElM8KyZhRVnoX1xty3CY?=
 =?us-ascii?Q?ejC5uEKmVdem3m0gBtYff2BlxS7J1nPQx+nIrA+kO4ySdWE7aB0Tb2rNKxb2?=
 =?us-ascii?Q?O3oViKQN+S8OSuX74Dkx9OKb3/lp72cu2a6AHrAyk6v+quwyjuxFRm0Fu3Zh?=
 =?us-ascii?Q?sMrhfA68cKDF4KVbKpRPruvx97+houojljENqTT7if3hndZugeGitVehkLTV?=
 =?us-ascii?Q?I17F59Ww26tksFVVeLzKqicZVWXg4x1FqiyhXVIs8SxpWq4/Pu+qOHz3nqnM?=
 =?us-ascii?Q?whAsjzdfZ8wD57kE2/A2yNR1tXuIiXMuJDTKK7YEVtcodtBfJ0Fc6P7Eijnb?=
 =?us-ascii?Q?GcN21rvNGs3Yt7+vlb6VaoNoBBqXPGwXOt6RnWLUyXswAhYfHUmmtoumm269?=
 =?us-ascii?Q?EimyQRt/+Nf16RgvqdG4GTE3Vwgs3ivE80WQN/a2abq0carhCmMl/d/0y+vv?=
 =?us-ascii?Q?AMEuI6/7+ztS5wDWlQbPAHWgcumNnHEd5Pq6zIG/jIcBk/XygGA3/QtNyOp3?=
 =?us-ascii?Q?ga/iVfWx7aWqHunUTucphFqGzrlkJaQ7ETIMTZ8KyxZoXG57YmeaI7HucyY9?=
 =?us-ascii?Q?Bi6b/v+glVNmzDl0i4WO/bmhgJxuk5iUnqnataG5Dxm3PiANSHoq9Eu7sx7N?=
 =?us-ascii?Q?+r+XN1hHje527aOb4TQuUvW2YG0wuYAoV4En8NlmILCfh7+sUulrKfHdYq1/?=
 =?us-ascii?Q?v+CvrvB3EKVcm9mODUYEzq0IIduKmw92UCaqzT6nvrz13yy3A0+RdK1nwvSq?=
 =?us-ascii?Q?1Y75a+Ww/DyspQZq0+ySJTK/dtoATnqZWCAqpKs5VHK9d2QscVnCnEnLpyOP?=
 =?us-ascii?Q?YB8IudDMQ7JeAlhmNX9z5ZDWnMgtCoBkXb57xDeKKGxolQM15u1wO0N8f1zo?=
 =?us-ascii?Q?nNxR317e4paYvrK3ESu1Dl7Up9kg5oCMW0kaAuM3+L/OVSuyLoNQSiHfbVXJ?=
 =?us-ascii?Q?lmmMI+ykVnbtxYaOKh/zyVXiXnYsCojmVdNjRGedvzzQ6sR1NzLvrHR/ddFZ?=
 =?us-ascii?Q?b17OTsUKZnajmnRR1nuN+PPdFy3pniUgUrdwuSIKQMIt69pISSmXVwmikqoR?=
 =?us-ascii?Q?cRnHdpT4O1y9IWWxKt/ngcAUyMNu3SY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f8c647-29a6-4b6b-7a25-08ded3a28b77
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:01.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +msO5jv4pW5CHD0LyuHhwjIkFiCwP5oUhAp676QvrkS4lY1ObnypO54aGbmp5xKDfZCM8MWWvLSZsQ/GIwXYXD0s8Jzg4o36yGt4F0UW5A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
Received-SPF: pass client-ip=40.107.130.84;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

v2 -> v3:

Re-design device ownership hand-off (suggested by Dongli).  Do not rely
on SETUP migration notifiers, as this approach forces us to reorder
generic migration code (see v2 discussion).  Instead:

  * .pre_save() releases ownership on the source (RESET_OWNER) once VM
    is stopped;
  * .realize() is adjusted to defer device ownership acquisition for an
    incoming CPR;
  * .post_load() actually claims the device (VHOST_SET_OWNER);
  * FAILED migration event callback re-aquires the ownership on the
    source after re_save released it.

v2: https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com

Andrey Drobyshev (7):
  vhost: add vhost_reset_owner op
  vhost-vsock: don't reset connections during CPR
  vhost-vsock: fix FD leak in realize()
  vhost-vsock: preserve vhost FD during CPR
  vhost: factor out vhost_dev_init_backend()
  vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
  vhost-vsock: hand off device ownership across CPR

 hw/virtio/vhost-kernel.c          |   6 +
 hw/virtio/vhost-vsock.c           | 208 +++++++++++++++++++++++++++---
 hw/virtio/vhost.c                 |  55 ++++++--
 include/hw/virtio/vhost-backend.h |   1 +
 include/hw/virtio/vhost-vsock.h   |   4 +
 include/hw/virtio/vhost.h         |  32 +++++
 6 files changed, 275 insertions(+), 31 deletions(-)

-- 
2.47.1


