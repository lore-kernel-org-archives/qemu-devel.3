Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B768C3ABC5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 01:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDCDU-0001s6-5W; Thu, 08 May 2025 21:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uDCDO-0001rL-KE; Thu, 08 May 2025 21:07:50 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uDCDM-0003Fh-A1; Thu, 08 May 2025 21:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNK6zVRqk44905ae33u/M8PWQna4hQwOlwUArEauxuG44ujmyB5Bu34FDF+x1L4jfynD7G+Aj6s+MbUuV0MXRf3cvNJL8eBPQbKP4mw4IJCM40YNCwal42IWRe/PLDTnvZ2/hCTzuIj/hL+S0sxf0WfQ+RdpT/+cYYdX3jriDB8K1oQoaT2/5oD64Sccr9yL1/2gTVX4NjHg1/8TrmYM+VKEhULJFt3QA3hfXEyeEnSbkItj0uJyOBbdoaW0JGRDTs8GDBXdfWk8G+mQDGjssVWCSQg0unRivb6uaCfavXkqakVmO+Fpu0IPWVNYuWuHkIhONRfs0yx5ya2/DjICwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGNe1tOjU1MkpdrGEfM/CsPZU4C6RElvUMLww3wmWBk=;
 b=chpmfGBTrGRQeO3lQLPnrsG3oya7qfKDmFKmAHN/katITDj9iCwQ+Hiayz4BPG7A5WhpGnSZWRYrePu7cZWdP7PSVNxDmGP/eSI/OFRz2bVb9tC0dnfgX5lmhfF0JsMkZmoFSZ5bCqUvxY2wpqPd73ja9kNuriJSHkFlODupyiZNNgMpqYn2yqKfNjMe/uZqkqhh2GISLRlW7H34358cGD4iqKPAotWoI5G1Eht13U6p2sOvEVpoqnUfcqbQpEuJeD6yKUJfeIcwyz9g9+75C2e61bI+9jzxdocJCBozGBCb5feeBwBXgdxO1rbHqbFqDdykDr9PQDawhiGlS1+uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGNe1tOjU1MkpdrGEfM/CsPZU4C6RElvUMLww3wmWBk=;
 b=aUSHH9YtxACf8MxDSTl8VX46hfYbR4t4ygeI2EjmuUrzvhfAv3TRAOjggwZOF6CM11BxYjFbVn4IjnYXMga6k0DzYQ6DKJd29SNNcli/QIDzAplwp4T80Bp/UFrE4SFHlG9GG4iS3BT7PspTJFCwvwDBj3X1/N6j9TO6LlZUPzo=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8190.apcprd03.prod.outlook.com (2603:1096:405:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 9 May
 2025 01:07:40 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Fri, 9 May 2025
 01:07:39 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Tim Lee <timlee660101@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device
 part number
Thread-Topic: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device
 part number
Thread-Index: AQHbv78SS00M65miW0SL9hgmvHv+lrPJfcbQ
Date: Fri, 9 May 2025 01:07:39 +0000
Message-ID: <TYZPR03MB6896AFFE1901AC461C4939AFDB8AA@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250508021510.2959328-1-timlee660101@gmail.com>
In-Reply-To: <20250508021510.2959328-1-timlee660101@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|TYZPR03MB8190:EE_
x-ms-office365-filtering-correlation-id: a2e4d568-40f6-486d-95f4-08dd8e95e4c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WQQHeH1ExcbNqC9VHlYOQ9P2RBag9hQCp15f5eH++LsfL+q3rr6KENIqmZXT?=
 =?us-ascii?Q?Cn6J+oOtW2RhjwlgWl2zOvAW3AkAXXcrzD7K1dtXPA1CuOKXcsP69YVYgGnf?=
 =?us-ascii?Q?KAYUsAdhgkDOxEnvPx/jF3IoAadJG6ywDBVHR9VMPB+QwYDl3ycEjTi5nhQh?=
 =?us-ascii?Q?2w87qGhh8xPfZiYcrTTuW9Wv2MOOYe0r60DTwSdFrYPZpBA4VRmB1ThQhCPe?=
 =?us-ascii?Q?2hSW7WaTIuHs/U+Ba3LuZxGyIfn0xuh7robmZeichjYEfTBzQxV4o2BTK3eC?=
 =?us-ascii?Q?Htcg/aaYC8FdsuZcn+XcHLf/oxbhkoW7hVT1UrJ3dQBQriyEcgAeRUjVNrwG?=
 =?us-ascii?Q?kyR/5VHUpQ4+uE+zwtXvdtGE1wg1CThYbXM3BoJqeQvngqIG0Svw3Aeq+RUt?=
 =?us-ascii?Q?uDaKHH8k3ijvIQnkIzvrrxVhdNKQh/cOqsWOOA+7D4M+NAbWuP+AjVNGSrWL?=
 =?us-ascii?Q?wdjMVC/pjwuqVSg3ZOk0e75hdiSONlymH8HE9yL5cOUU+HmbhTEf0aCVivJZ?=
 =?us-ascii?Q?iBIDbVmjf5iWCoqm8bz7Jjs+Cpot0S0ObuHYs6qPugLOcVDNC0Zqz4icuNCG?=
 =?us-ascii?Q?xTQRkGZGbbI1eZOENMPlA8JGKQcU/MtS+KHLomgUVWzWXsAmpC2NhN4x+Jf6?=
 =?us-ascii?Q?XiFjmCEZ5rK3+ugFmqXDlSDRgZJgRUzALdsJkQ6cAlsWkpFI6QU3DCUbAY6Z?=
 =?us-ascii?Q?j1Vps8uhWufkZpzm29h1yRwwsilMLflWFva7iFklUbizQz0jRKrFnPofTbbs?=
 =?us-ascii?Q?HL8o971lrW6hGFkbFy/u+gJMNichQCh0Q0lBGOKMORa0skIX6mOJMr/fIAKe?=
 =?us-ascii?Q?yATtQeLt8EnkuHwkb0fzZ2I73OEq0ZVkRpVnQ+5WMw6KNj83H9po4aaJAtwH?=
 =?us-ascii?Q?mbKybvYrMfzlt5qEGIfboe1Z6efEbqcmEswS3+LHl5GmAhaQ5bXTGymobggt?=
 =?us-ascii?Q?2JluUJCD4D++ESuXg5xW2126BzSJ78qsAu4VbfvfVoRUkG0wSePmP+3dA4GD?=
 =?us-ascii?Q?kC2fHwUxYYnvkbZLxLIPJsYbvcSE63t3dAReHLezlBUgrbLzSoV1eoRwLZVw?=
 =?us-ascii?Q?+LkZrzt6jyTZngVs8+KHWcqGKAtps84YnZ4/vkYbE2JaMDh4kj2kd5UxrrC9?=
 =?us-ascii?Q?plYCqap+Qz+k20cdtregtp2iHTLWAYE8iTEcfuAqoCDCTV7fXMB1kUmaRBck?=
 =?us-ascii?Q?kk3FnPo57XydkCYef4rVaqGlJeWd1lvaXSzZCS9bGK2iTpuBwzDzJo87C3rM?=
 =?us-ascii?Q?qqKgxoy2jLT8XgtBXwHhjYjneRrOuutt7tOL/ZYjn2B1YZgLyVvdoKFr0jlg?=
 =?us-ascii?Q?i/7M6WlPawIpUIUyzosZvdMZIAfIPDZN+Z8ZDDXk8nosGNptQVDithB7iy5X?=
 =?us-ascii?Q?MZYSvTowr18aQVNOLRMYnx9tkxMBkLpEN+aM87CcAP2WjUC08HMpnKeMoau0?=
 =?us-ascii?Q?sqams5RwI1Vgs8zd+Zqcc/loDqCWmb03SRCQIUF16hhVQ3uzTXRlhw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XAV2R1PsbLJ/EVxSD7mGf5QeDRphsDnMu3Raj4eFStNkwihju3jQkKuqIhpU?=
 =?us-ascii?Q?afMPSpaJmSLfWkNyTHn8WJkAIPQNCahUvJwOYivWF/53jtXJFV2WEJtrzE8g?=
 =?us-ascii?Q?XNuWTK8nTvCuXHz+Wox3t70mVM8wX9PLPkN9YMEx8HwXSx4ospedG0p/1GYU?=
 =?us-ascii?Q?cCM99rRNII/c+3DRTYUB4L69CouUbRxussqMOvgNw49glsAdRbgTU6eAqovi?=
 =?us-ascii?Q?KccmO3T2AawHzF/KqDY5W6/y+waFPvtYAetOQmBZcVzqJHPdo8XyeE0wzpqC?=
 =?us-ascii?Q?Qes2JtRQudSSR2pdrlR6Q6Ip7XVe9odvsF3pzzmdMndZgPLoHgdXN/otZ05N?=
 =?us-ascii?Q?rozyFQSMtlzcOGIpbo+dfpxsRWqRKXGwVCVaBiLKS1XwgRE3zMG+oZhbEyVN?=
 =?us-ascii?Q?0aiXvoTcvmC69bgZuukUCaejSRvVRNlhB+a4UFZ7xx186Z8n4ssvjVGM101p?=
 =?us-ascii?Q?OXaga+3u/iuV2yOkh0wzUbe6gf8BxFl2VOB8pQHiNC7BwSbb4hQoVaw57fVz?=
 =?us-ascii?Q?5jMfNtxV85W4/59ya6J1YY6zI0cUD3UxSPIupXk2vDvf9ENiPdjVIGI4x/A7?=
 =?us-ascii?Q?m7YIoRSNMhrtQM0t28Asr+wVwmN6nvMqmUs1NxARJanQjfXGa3yITyyBIz0J?=
 =?us-ascii?Q?oJYzQsMcL71j5Af7SStLkgTeybBgtgGH2cdzOjgXwi4WoNXCz0QzIQRPRBfN?=
 =?us-ascii?Q?oTR4Wg86ehs8YM5+wuKgys+3B268iMqpGi9ySPaV8HaDR9/hBcqEEkWlluDt?=
 =?us-ascii?Q?WmeEBET6TTPYN6YwMxQcefpc5JC+gEK/vI3D8peU2jAt1FFNmfwgaEUzKMaq?=
 =?us-ascii?Q?DYi22Ev2bZFyYSXdZG9wCkRa+X8syXBsArk5W2L6NsZcKDas2PD+JgnRa/0y?=
 =?us-ascii?Q?TdS/mXERXF+5/oxGKTObLu0Zqlse5mlggd0s/PJTliI2iyqbGb4cDKtNzJbJ?=
 =?us-ascii?Q?bEefq/SkbQKOPqyIF8bX9Iq9eDDq9aNNDsq/TwBsDEAxBSxFLPr6GYyj9Ctx?=
 =?us-ascii?Q?c63pI6SOQmNRnqNx6uw3Y8hE+1zluQFJOAnUDyulYsMsP23ZuKIMYtBUFIkl?=
 =?us-ascii?Q?OQVuanZ2tWdAx+o7Vmv6gspJ8E0vN4LNtZzAVmgBA8hpEtkmo9HPkiFjLNv9?=
 =?us-ascii?Q?9q1eb4WC0LyG4ng/hwKowMBWhxmxsieg347czbJWT5aAObp8x6t/x0CfoQwy?=
 =?us-ascii?Q?EKgSEpsmPULoI09XWWKJZ4NQ5OJXV9lJuL7iNBl7zOFkIRMHBeG6TCZ68mhk?=
 =?us-ascii?Q?J0TqQtIvb2R0FRnFIygiJUZ/W0g2C5v7KcYwqYjZh/vh5yhM2DEnSF9NjXwd?=
 =?us-ascii?Q?ZkJ259pO/hjOAVqceWQep/uCbj5mdzzlh6p4LsxP15dE2mI0n0ee6Ve1JRMq?=
 =?us-ascii?Q?eigMAdy/rKPLbv1fn9UxzR2wpmX2qYZg7ddjdcOTyXC3QH+UlQyGa24dBW7Y?=
 =?us-ascii?Q?J6Bm45zjMkf2lycPCjR+2hYnkFEKFkzcsfL6ksE+B00GhPY3lVpH6XrRLs7S?=
 =?us-ascii?Q?1BdN9a2nnZT5dyVcrNDmBU03fIUZKYktxXMQIN0WzO5X5ANak8+HghfduP2r?=
 =?us-ascii?Q?enQeLKNqQ0dt5v86pX5YATaMqi7sr2eHc0uAXASc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e4d568-40f6-486d-95f4-08dd8e95e4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 01:07:39.5343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuzsaxoEOU8qg5yAsmI3oxZs1ZUk0LqV6Sa33MhfYA243/tP9ELYKtnw/g4omJt4GuvaL0GgfJcsYQ+GXlAgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8190
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=KFTING@nuvoton.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tim Lee <timlee660101@gmail.com>
Sent: Thursday, May 8, 2025 10:15 AM
To: peter.maydell@linaro.org; wuhaotsh@google.com; CS20 KFTing <KFTING@nuvo=
ton.com>; CS20 CHLi30 <CHLI30@nuvoton.com>
Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Tim Lee <timlee660101@gmail=
.com>
Subject: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device p=
art number


Fix flash device part number to `mx66l1g45g` according image-bmc run on npc=
m8xx evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)

And add auto zero flash image size to resolve error below after executing
`./qemu-system-aarch64 -machine npcm845-evb -drive file=3Dimage-bmc`

Error message:
qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
requires 134217728 bytes, mtd0 block backend provides 67108864 bytes

Tested:
Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
Changes since v1:
- Add a statement that checks whether the storage is writable

 hw/arm/npcm8xx_boards.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c index 3fb847=
8e72..79295a586c 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "system/block-backend.h"

 #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff

@@ -59,10 +60,26 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu,=
 int cs_no,  {
     DeviceState *flash;
     qemu_irq flash_cs;
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    uint64_t blk_size, perm, shared_perm;

     flash =3D qdev_new(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+        blk =3D blk_by_legacy_dinfo(dinfo);
+        bs =3D blk_bs(blk);
+        blk_size =3D blk_getlength(blk);
+
+        if (!bdrv_is_read_only(bs)) {
+            if (blk_size < fiu->flash_size) {
+                blk_get_perm(blk, &perm, &shared_perm);
+                blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort=
);
+                blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF=
,
+                             BDRV_REQ_ZERO_WRITE, &error_abort);
+                blk_set_perm(blk, perm, shared_perm, &error_abort);
+            }
+        }
     }
     qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);

@@ -194,7 +211,8 @@ static void npcm845_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);

     npcm8xx_load_bootrom(machine, soc);
-    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0,=
 0));
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
+                          drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
     npcm8xx_load_kernel(machine, soc);
--
2.34.1

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

