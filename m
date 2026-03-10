Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F5FCC9D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrqY-0001ua-C6; Tue, 10 Mar 2026 03:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzrqV-0001u5-5N; Tue, 10 Mar 2026 03:49:39 -0400
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzrqR-0001jb-C0; Tue, 10 Mar 2026 03:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzY/xbWOhFGbypL+nQmDSVxqgsO7h69b6ggDUsw5fpHI+/32HwFcSusddsxV63a2rdmVAVK68UyrCn7T15n98Ylhes42wqpU5pQZG6k5qn0QdbGVZfO/ac5/yluxVtEa4pH+T9I0jgI3ITF3DyTLNF0ZYmbik+WMZdboHhrmUMHBx8IZoBE+wP1x1EXw/NaIREJqbZcr0WejvtnDHabTm1M62BZW03bLEvqd/0+/xp5d9Luk5vJFFceDQArfo4RYYPvP4W2gCJ46Zz5FubhJwHbqJZ+4TIjJshiQQy0qVJu6EJcj3rxPxjaYjhoio6gciv5aTFrID9GjDrn0UFghLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTtCI7qUtjNToGaYr9T997Muyn8ENXZmG0pKhLfRqwA=;
 b=SxAvF1blggfxqNSLRgFsaXfilJmJNrQbhlna2sDsbluNzHUD1hb1yn54lALmQMnkmUauMDN9QC0EqhKd151MrS+OSL1iZN8ot9wjvn6YpUr3HEfV44WpI+vgZFY0UC5w4b9s/YAgAisnmXZA2vycM1VHnJnfjo4pjQ06kArDoLkwoY3F6IpWl35FWa4BMfuc6uI49yugP1olTK82S6Z74VIeYDGw1owO8Ln3Rbjq6qy9SLSgifmEC3jm+nIvdlXSaqTa2zwDa6MunvvqQdlaGEYRkoMS8tarmcbSkRXmGFVVE+AL5Gxkheqtubi4IcEuQvQvhzU2Q9yCDrrQUUirCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTtCI7qUtjNToGaYr9T997Muyn8ENXZmG0pKhLfRqwA=;
 b=Ud3mYlUoDWJmPQCCbSw5kSPUjdHaQTyVfMo5YDRN77PMG2IuZcrdmPQ/Auj1ssm9oOCaBEqtPT7CxdqWaLQPj8nHIEMhFGy/j6SRUOJysbQrQYXpI2orhLw4N38MjYU5B3DkTAGt4KxfWccfyX20DSHQJy/jqB48KBl3ThOio2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1497.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:49:27 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%8]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:49:27 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-trivial@nongnu.org,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH trivial v2] plugins: add missing docstrings to qemu-plugin.h
Date: Tue, 10 Mar 2026 08:49:05 +0100
Message-ID: <20260310-add-missing-plugin-docs-v2-1-e9a91cb6974a@epfl.ch>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260309-add-missing-plugin-docs-159d7ff315f9
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7844;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=cM2BxQJmPs8fBOTg9GQlZSCU0wISTnTLuNuI8bpgG8E=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpr8zLbMD8ze/W6EBp2sy/4CWvTwF/6GRTtcxUm
 4XD+kKOhNGJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaa/MywAKCRCW6ye6MV/H
 fKnEEADF9Tghc2DrAmwCCld5q7QNmrd9uzaYJhYIFFpr9dMTYOp0ZhrCIzi00sikAvDTBICGxqp
 7uKYLe95mcKQXsUgB16A7ULj23eS7881q1UGst6thnMFzGMhuWC2jZvVOEEbE7zmA2r7QEJT40e
 cWF2x1Wf4rW+8fobgjBOn2x/hmdudUbUhrRTGl22pbU6h3KTcoHyMiaI+DsvX35btuH3y1y4Gl/
 4aSmjaK1YmmuOldG2A9TTFW2Fp+01YWpd6wQYCPJohVZKYDnOf+KKGXF/rSQIyq1Xspx0RiDIvX
 nZjDIutft6zuFS0TkN36xQa5JGDpF+fsCHFfKVil7GBlE2T0FUNNQPV/8ETs2bLIPumcVxk3joW
 dVXeyifygpyle3KCi7Il6ZifJHelAVic01c5ZVK5mym8iSPyUY3+PJVs4g/+X5qWOeXr6U/EEH7
 9HxVcZXPTXvp5S6vxmKMBP25G301HgXcVp1b2Yk3ItASm5EzQ85gHYfMaUER3+cQZkLcWwDV/l7
 BGmKXgEdqpiEdRRDeiv9a9QnW1iZwuwPF8iAYPm1UZbcKNODx+cnNHEourqPQzM/WTB4eNMHPQ+
 qUgmAYB+Y10pKSIETezBHCmvkfF+mZi7E4ZbRYttjpCvm8nJ5bFL5ef0m+gPvnThWqmvXbqkLfg
 TIJKPMFdCePt12g==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::17) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e16191b-0935-4e79-d68f-08de7e798e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|786006|376014; 
X-Microsoft-Antispam-Message-Info: IWmqunWF2K2CreBxL0VY6y3Qj5fq/0D1Tz0HGYPnllAWRayOsLOJF5xDm++woLC0/dD2aGjxUISK8UO3Zi00UDtt+01HK20ZyWdruuGhE4rQx8Whm5+hJFmDenKazpldDgE7QjYeFplgzWo9RLUB5tXYba1RYZE5t8LdfFdMe59r7lCz1fBGXvW7IulDkXRF/Fx8iHBngYuP/uhgNFhZIhiHwOcay3SK2uFUCfvxfBJPCF+aI+45gBa17QCuCUSLqSS6ax+1fTmSY9b4qAdIRgHNedAzIdhAo44zAR9qYsjvmnFRQFjIo1H+t5Mc51XOc4YHS9AZLmlQTOynMxkJeYr0I2tNQHimHvpmaDeyKc3cchyUtPq6ds2OKGH/K2n0g1h4BGAI2QLFzHQWK5Wuiq0xifRZ0z8u+L0g9WpjPKiXpPUdfz/2BGN8uJhXM0H8oQAo7YuAzP0XGhvSfqMuappn4CxaqDEY66HGU7MVuli+XZFuC+WOU/6fxPPUqaKkVX3lfn6hzYYJ1a8YT1S+ACrchH+YRs8sgZa3h7VHpenmajnFgSIB+Vit/OMT26DvZK1p30uG4zMYj4CAQvqb8aB+9mjtQnsXagUJHTuHgyTXAoSunlhVcLxiwgMqd6u3oVLr49ZU7yq1QkuwsFfoU9Z01qiv8MaoD2op4ZyzXZGlmBQiV/NxFFOTHh9u+bOzCpU7nSUjbRKITv4AFGwNnf+XO/VdQCw985QbBvpvn1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(786006)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejUydGRzbFdHZHIyNHdDUFpRRDBvSTgrQWwwQTljakl4ZjgwRFJSQTA0MGt4?=
 =?utf-8?B?N21pRU5SZ0xyN0Z5bEFDS3Nwek5iT2lTWVZIYzFUTDNYNDFUak56clVFUXlu?=
 =?utf-8?B?M1JFS3l1eFhpSkZqL0l5TGMzQnkyY1ROUGZjWVJrcFV4TzErUXpleG1CYXJQ?=
 =?utf-8?B?NkdLVUdUeFJ5bzBCQXBiQXMvZkduWGVVak5hS0QvRzkybGR4V3lncE8wWTFh?=
 =?utf-8?B?VE5WZ1EvcmxxN1JXdm5TZm9nZVZyZ1RBVy9pTmd1TmtWOWk5RlRqSHB3UWRq?=
 =?utf-8?B?Rkt6SlpUSUNmazlGcjh6SXBQQUw4WWZiSEFTVDJtcW9GdEtYOHNGNGFWb1Vt?=
 =?utf-8?B?ZjJjNVpRN1Jhc1VybGt4TWZZMlc4SG1PeE1jNlIzeFZBK0h5UmllK25PNEpa?=
 =?utf-8?B?Rk15eVBieDhnMUV4Sm5rREhsSkZBR09aaER4Rkc1UjZpalpoU0VvRXFSTFhU?=
 =?utf-8?B?ejdUZld0WG1NSFhvSzVobkpWb042dVcvYi80Y2FYY0MybEpuODdkZ3o1VGhM?=
 =?utf-8?B?dkRxQUlYT0VLWG1FVFdwWTVNcHNVZFRLZ2NRdkVJRkh3ZnFqclp1aERVMDRn?=
 =?utf-8?B?aWxrOTA1MVd0MVdqa2RrdlRoTXp2anVMTE5JcXhIUFNPMnp3Tm5NVlNJZjVT?=
 =?utf-8?B?SDBTMTM2MU9PVmQzTmVOdEJpNU5NY2g3NkxpWTRPK0VkdE9RTUxaUDIrUndw?=
 =?utf-8?B?b1I5NWNjb1NMSk50Q2NyUnZvOVVoTzdYTnNmY3liZEk2bW9Cd0hNVlYyS0x0?=
 =?utf-8?B?NDZlOFlQSEJXQklzeVJHMHJXWk5NM0ZueEp0K1VxR0xwVVkxMlVZakcvTTJU?=
 =?utf-8?B?RlFjQndncW1PMXdLZEYxd2x4NkVhbTBqZ0ErL3loRTh5VUZGdWNaWXhkK09D?=
 =?utf-8?B?dUpkd3FXV2dwNEZNMFVZM01mNEhVbVBXckFKS1Qyd083RHdnWGpndjE3TFoz?=
 =?utf-8?B?NjRUdmVFVEg1RG1VdmFEcEI3M1ZuMVlLZWE0bkpEYlJ0TWhyR2FncnpJVEJ3?=
 =?utf-8?B?eFkycjl4U21RUFR0U3VqWGN6dXlDck5GdklSQ2U4djFpNENLZHE3eENGOFhn?=
 =?utf-8?B?akpXNUZKMWw3Z2NlVG5HVHJJTmxSdVJCb3J5UFlNdXdNdnluZGdMbzNYb0Ur?=
 =?utf-8?B?ZFBJcGo0Z0tHQVhIY3BpK2NUSVQ1d3Q3Z3ZLd0F3RllEU1NLZ2h6cXdrVWc5?=
 =?utf-8?B?MEdKVG9oUzNoSWM5K1RVSlBjcmwvb3NxRnpjT0xnRGJzYk1xMGIremtUSTA0?=
 =?utf-8?B?WWJxZ1YwOWZkbTdIK01wbzI3VzdpNzVlWEk4ZVJkN0ZPT1dRbUJuNEFBMXox?=
 =?utf-8?B?czN1aWNhcjdNSDNLa2lKdEJPZkJmdWhITVdEWk1waERFbGpGSlRnamNDWVFC?=
 =?utf-8?B?N3NMcEVJMlV0NXdIWWJjRkFuZTVPY0lHcUdaSUJrZ1JwSHQ0a1pGalBmSUND?=
 =?utf-8?B?bS9DOWZQdDBtMjdvUzFmSEY0TnV5dFdidE50WDNEamdwRTdENEEwZFRwRkFu?=
 =?utf-8?B?OElEaW0xMEpvQzJRdjBNS0ZoeHBCUGJJd29FWTdKS2JnZzRUWUxuNUhrZ0dD?=
 =?utf-8?B?SlFJUzBUTEVDczAxVGVvN3dTNmFZZDlPcHdxT2tsRGtaUEd4bEVzcWdjMjdY?=
 =?utf-8?B?N205eDZlNXZqL1B0NTkwQVUvWHRleVN4M2F2aGtNUzhVbUZDM2dHdEdVMlk0?=
 =?utf-8?B?MEt3TFY1OU9xU3NjdlhEVm8zN3hUOCtsbHdxUGtaQnZRV0g1OUZXQkxGOXZr?=
 =?utf-8?B?ZWdLK0QyNTZET0VpVzc5bDgvamw2U2Npd1drWTZtUDBIYWRreGVTdEpJVEx5?=
 =?utf-8?B?TFBCZUNiQ3ZBcHRnc1NSVnRlSGRaLzFMWiszTFd1RW5WZUdKbkozOVNCdWJY?=
 =?utf-8?B?MFhlbWF0K0N0SHlMb1NTM2JCTW5OQkxCMWFUZ0JVYXArQ3ZNTHpTREJ6ei9B?=
 =?utf-8?B?S0NlcFpPdUtMWkFVL2dlMTV3QWFkQnEydkY1TWZoMzY3UzYxNFFyYU9Ed0Na?=
 =?utf-8?B?SlRscTNvSUhCM2dtellJVk9JbnY0eld0WHFmbnYrSHhOVzZaZXRjOWQ2TTRU?=
 =?utf-8?B?NmVhRmV2R2o0ekpyM0pYV05vd2tWVmNva3ZDZ0o3bjIxV1lmVk5Za1lyRU50?=
 =?utf-8?B?Mzl0YUFqd1lEZXlHRVNJUkgza3M4V0NlOURoMUNFOEhlYTV2cDJ6WUllQWV2?=
 =?utf-8?B?aTJ2dmt3bVovTmRJWkF3WW9nZmgyYWZRNlBhNEtHRm5Fck5laVM3TTJwTzVW?=
 =?utf-8?B?ZmY3aG1TT2Q1S3VnMkZJZXR0ZGFYVEZXR0xPcmp6V3ptWFJvZ1Q1c2tGNUl0?=
 =?utf-8?B?SW5wdHdZUEhibUUxdHgvcWI4UzllRllVazRNVVFNNkY0QXo4cDIvWmF2ODl6?=
 =?utf-8?Q?rSY/GYJ2VHkWEIic=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e16191b-0935-4e79-d68f-08de7e798e1f
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:49:27.6694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs4Sz8BtS9JVSkRVTZKbH3Vouw0sEnCshqjIb3HgQtA8Rr0u5uyRV7B1Ha5lX1BqXWrwnha97d+fMcVfqtQH/ngiGVZPQy5n0vwvzFy/i6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1497
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch adds docstrings for typedefs and function declarations in=0D
include/plugins/qemu-plugin.h that were previously missing. This=0D
resolves inconsistencies in the docs, e.g., the description for=0D
qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()=0D
but code cache flush callbacks not being documented themselves.=0D
=0D
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>=0D
---=0D
Hi,=0D
=0D
While working on a QEMU plugin and browsing the online docs at=0D
https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that=0D
some of the API functions were not actually documented.=0D
=0D
I went through the include/plugins/qemu-plugin.h header file and added=0D
docstrings where they were missing, hoping of course that I documented=0D
the correct functionality based on my understanding of the plugin=0D
internals.=0D
=0D
I hope that's useful and I didn't miss anything!=0D
=0D
Best regards,=0D
Florian=0D
=0D
Changes in v2:=0D
- Added semantics clarification to the qemu_plugin_register_flush_cb()=0D
  docstring (suggested by Pierrick)=0D
- Link to v1: https://lore.kernel.org/qemu-devel/20260309-add-missing-plugi=
n-docs-v1-1-41dddcd177c8@epfl.ch=0D
---=0D
 include/plugins/qemu-plugin.h | 101 +++++++++++++++++++++++++++++++++++++-=
----=0D
 1 file changed, 91 insertions(+), 10 deletions(-)=0D
=0D
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h=
=0D
index 827e8e1787..0089e72850 100644=0D
--- a/include/plugins/qemu-plugin.h=0D
+++ b/include/plugins/qemu-plugin.h=0D
@@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {=0D
     QEMU_PLUGIN_CB_RW_REGS_PC,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_rw - type of memory access=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_R: memory read access only=0D
+ * @QEMU_PLUGIN_MEM_W: memory write access only=0D
+ * @QEMU_PLUGIN_MEM_RW: memory read and write access=0D
+ */=0D
 enum qemu_plugin_mem_rw {=0D
     QEMU_PLUGIN_MEM_R =3D 1,=0D
     QEMU_PLUGIN_MEM_W,=0D
     QEMU_PLUGIN_MEM_RW,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_value_type - size of memory value=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value=0D
+ */=0D
 enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U8,=0D
     QEMU_PLUGIN_MEM_VALUE_U16,=0D
@@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U128,=0D
 };=0D
 =0D
-/* typedef qemu_plugin_mem_value - value accessed during a load/store */=
=0D
+/**=0D
+ * typedef qemu_plugin_mem_value - value accessed during a load/store=0D
+ *=0D
+ * @type: the memory access size=0D
+ * @data: the value accessed during the memory operation (value after=0D
+ *        read/write)=0D
+ */=0D
 typedef struct {=0D
     enum qemu_plugin_mem_value_type type;=0D
     union {=0D
@@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct q=
emu_plugin_tb *tb,=0D
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t=0D
  * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t=0D
  */=0D
-=0D
 enum qemu_plugin_op {=0D
     QEMU_PLUGIN_INLINE_ADD_U64,=0D
     QEMU_PLUGIN_INLINE_STORE_U64,=0D
@@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_update_ns(const void *handle, int64_t time);=0D
 =0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function =
type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @a1: the 1st syscall argument=0D
+ * @a2: the 2nd syscall argument=0D
+ * @a3: the 3rd syscall argument=0D
+ * @a4: the 4th syscall argument=0D
+ * @a5: the 5th syscall argument=0D
+ * @a6: the 6th syscall argument=0D
+ * @a7: the 7th syscall argument=0D
+ * @a8: the 8th syscall argument=0D
+ */=0D
 typedef void=0D
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_in=
dex,=0D
                                  int64_t num, uint64_t a1, uint64_t a2,=0D
@@ -836,24 +871,61 @@ typedef bool=0D
                                         uint64_t a6, uint64_t a7, uint64_t=
 a8,=0D
                                         uint64_t *sysret);=0D
 =0D
-QEMU_PLUGIN_API=0D
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,=0D
-                                          qemu_plugin_vcpu_syscall_cb_t cb=
);=0D
-=0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callbac=
k=0D
+ * function type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @ret: the syscall return value=0D
+ */=0D
 typedef void=0D
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcp=
u_idx,=0D
                                      int64_t num, int64_t ret);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callb=
ack=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
-void=0D
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
-                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,=0D
+                                          qemu_plugin_vcpu_syscall_cb_t cb=
);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filt=
er=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host. If the=0D
+ * callback returns true, the syscall is filtered and will not be executed=
 by=0D
+ * the host. The callback must then set the syscall return value via the=
=0D
+ * corresponding pointer passed to it.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void=0D
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,=0D
                                             qemu_plugin_vcpu_syscall_filte=
r_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry=
=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed upon return from the host syscall before execution=
 is=0D
+ * handed back to the guest.=0D
+ */=0D
+QEMU_PLUGIN_API=0D
+void=0D
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
+                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
 =0D
 /**=0D
  * qemu_plugin_insn_disas() - return disassembly string for instruction=0D
@@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin=
_id_t id,=0D
  *=0D
  * Returns an allocated string containing the disassembly=0D
  */=0D
-=0D
 QEMU_PLUGIN_API=0D
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);=0D
 =0D
@@ -888,6 +959,16 @@ QEMU_PLUGIN_API=0D
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,=0D
                                qemu_plugin_vcpu_simple_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_flush_cb() - register code cache flush callback=0D
+ * @id: plugin ID=0D
+ * @cb: callback=0D
+ *=0D
+ * The @cb function is called every time the code cache is flushed.=0D
+ * The callback can be used to free resources associated with existing=0D
+ * translated blocks in a plugin. @cb is guaranteed to run with all cpus b=
eing=0D
+ * stopped, thus no lock is required within it.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,=0D
                                    qemu_plugin_simple_cb_t cb);=0D
=0D
---=0D
base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648=0D
change-id: 20260309-add-missing-plugin-docs-159d7ff315f9=0D

