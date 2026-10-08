Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236C5CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJv-0003FP-9q; Thu, 08 Oct 2026 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJs-0003ES-2l
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:48 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJq-0000xp-Bv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klJB7KP0mI9FiUh/WSL4kOaLvgQkFw/x7DUk4DWpGM5rkr4imzQ+4iIbxBaxf7iEWaHuBuW2M9g9k6igni8tM2vbl83K0Iqu/G0mbBJ/R8S4NBoLoS1AHwaQ/NK9AYxGi/ARZlrBsXQyHNb9wfBO3dlT8OJHv1O6a+Dsyx06WgbViU46KxzKqJtE3vtB60BcFs+kSLNEynVFNlvb8IPw6Ch6hs8+3HKkhcdx+830diBgTMY3XoAfHxHJgW9xJT73KVjtUi4tlAkVa9JCv/7DaJaVfQhzinkSJ8YsVqAmXgnUB/J1NH6dFQ2udHZ2e4a++PyyKa/WcEx5LLbS+4AhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=u7aPYiAYc5FT2ScAfwAZmCzHHnK+rB+CzTqlKfXA76cqdpSAXw2clfp/1Lz5L++2q2pJxPvCQ6wV3t8fYVS5v4KWAWvxt+oU7rHHZuoFelAww0CrDX9tP6eECiB9GcIrHMZnVr/48dDjjI8bvjOA601AZjywCtrv+6AioJf9gkl7u+D+NTo3NGezi6DNqnR6VOvqAzTMbEZ9pP2glyW//Z25nFZfJAf+CQy+Ip4GJXSgmvhwFwSGpy3ELveB/M9AVQDGdhIz+cxagqDixa35NKsOfTRAphBxHgr5wg3rWG5sasX+rfrL6lL7jSMPrkSXCp9/Wgkog1sAQyB7aXL14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=0DMJTyIrRfOgWz00RF0P9w0TB7lDTA7iD2QLwCfvEMWSShDShv5yFeZRckKeLFhyILXXl5rNLrgevBtX0z+OGqaQoSUaKVVFp6ElZIfNa1CStfMx2bzDkcNIx9SCE0xDxM/LxuHuPxOI4ovzb4JgVIRVqVYz+zCp18kgipDcos5he5wcxUj6S0ejjz5AejpGnVXeGUwLa0NRepvM2RoFOtIgkh0b0zUkzxljajiRcNxUkuCZ0kPC0xwpQgyJeX/A0ChEx91lZjdQ/jYp3rRvqPG/udgBU79V9lsco8bVfQSa+t0a9MvcVjX6XFjYy6QSvvpXeC89MtO9naD/vshpNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:27 +0300
Subject: [PATCH v15 03/22] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-3-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 180fc3f1-c3bb-4564-ee5d-08df25267c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|5023799004|10067099003|56012099006|38350700014|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: M0J5+vDFYwJo4iwiVJ3xnwOuZVE9f4Zdgj+C8ZgauxJ87x+o6ZaZarCamz3r6ZGoBL87/7Jfo7EQrVdeLEq7AkC9pXLlSxEassgS3Se5p7sY9NY0hcQ3FRDL4gH+aP5pZjFa4dJpYcFIdSLXeAvM4M2/7vxkdyBQNmr3WD2rCTouNIMrZcgKFife29Zw7f+1zWaqHCyy0tMC/jeJ01j4UwMVAA8PdtsJ96Rhr/4Su84M6O4w2P8p9BEoS6PWaIbbAnCPLZ4+KvAv1sJ+/mGe4NGS6jhKRSTnDwLRSjUgE89lNWQ9J2y2EhqRSxhakvxfnpam0/kopnOgBvqKVx90368gnjSIbysSIRL78cPWMIAqrRxvkpYbYcSkSGQ3udVO8Bhxje0D17GB4wmz6srIu0oRSTxM9nxAh/D4u2Bc5XmOnt5tOwqh1GCocqzUZeX0EP5Hu3OO4AawDHbzJc/35cR0733G0N3rgvIDXwyjidfN6L4eJcsSldf9Q9Wr1OAwzPOEpGRFTiWD+FLr4ZcUly23xxFZpcd6UJSW6w0LDiR1vHsPixE/GyVkou6yGAgnF8HLpjoIUF447PsX3wdCL0vxjSfCLtVL+tAL6c01oYb8tDt47vbZqOH5NTSIwPmtH+BHpMaOUYj6GB1u7+CGZNICaQ0UkJC1Fzxb8N+rrJei20gGP7KvRlo4cO2PQPf1VxD4cdhKGrdC1uvVxsyAXDfBz08rEmuwCbGcHh4XG6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(5023799004)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFwTHIxQ0pXR2dvNDRUd2lSenh0ckRPWU4zbUNWbzRvTm0yOW9EU0g2OU1D?=
 =?utf-8?B?OEsvUlRJVkRQbG9QVmtoNXdxQm5RR0l2dURveDRUMGwyNTdSa1VWNlBVOGlH?=
 =?utf-8?B?dS92Wms0aE1VVkttVmJKWmNwdXhhMWVGMEtFMmdVRU15aTc2ZkZZK3Y0S0hW?=
 =?utf-8?B?UFNEK3ovSk9jUXVMK0N6djhUWFRSOHdMc0J4MU56TWVIdGpyTW9JcGNvSmlt?=
 =?utf-8?B?VDQvN1hkRDcwaDJRdjFXUVpkMVU5RXhMaDRKV1g0V1F1NjRCTk9YT0pYZ2E3?=
 =?utf-8?B?RnByemZ3V3A1SHVWMVpUK2g3UzhBU3NyOEp4Wm5rVFZzNDZwanJ5b1pWTU9l?=
 =?utf-8?B?enFPeExxNUNablpTL0lxdXhvZE1WaFdOMFFESnYvMks4dTNpSWVlTnVBNXZY?=
 =?utf-8?B?TGMxNTFaUTZCYXJQZVJ4djU4UmdPVUNSRlJ6THlKYnhpQnBhaDJrSkdZR09X?=
 =?utf-8?B?MDhUSnBIT3oxR0djR0JHdWIxVXJ1VWRGK0llMXlJQUR2VHoxbXFWZjQ2cmdJ?=
 =?utf-8?B?WWxVbG9NUlAwaGVXZmprN1MxSXcvY0x0dE9xa211WUc5ME56UFVyeDg3aEdm?=
 =?utf-8?B?VU8weTF2Sm1YSWFrZXhkcFZKRWNNWVBJcXhRUUJzRWVheVRBbDRRaENDWVA5?=
 =?utf-8?B?UkRYOGFPMGlvTG9jZVRZdStGTWFSbWN3VjJWNmZtV2FBR2FMckZaem1jQitk?=
 =?utf-8?B?Q1liMVNvbDNSS0ZnT3A3NzdNb3p0T3N2cVhOL3ZhRjQyZVR6R2R5NFFoVWVY?=
 =?utf-8?B?d1BIdzcxZkF2RGtkZU5BODcwNDlNNkhIc3Q1UTQ2aFI4VGUvL1pRcERWbGgx?=
 =?utf-8?B?N1lFdU1Hc1A1RlpkU3diT3JvQXZNN1M5Q000RjEyL1BJZ0NGOFhvN1g1WDB3?=
 =?utf-8?B?WDAzOExBdk1IZE1nNGMxNHRHMUNmQjh6d25jMEoyeE1aSXd2N0kwejRLVlRI?=
 =?utf-8?B?dFlyWWNCMG5QaEIzWWZrT1ZXZTg5Q3EwVjBwcm5JeWFqNElLRFR0cFpQd0Vi?=
 =?utf-8?B?UitncTRZb1IxdDc3bzNhZ0xpRTJXMVZhaXh4SytGVHRKUStPUTc3MVB1VWll?=
 =?utf-8?B?bXgxU2g0dnhHQnc1MC8yMnBwY1NRRFBsVUpOMzZmdGQ3a1lYdGI2OEJ2ODZk?=
 =?utf-8?B?ZlZRVGdHMkZYaDJtZGhkRlU1V1VoV2htVUFzdnNxSXBPT3R6MERXYzdGbFlZ?=
 =?utf-8?B?TVI1U01QbUhWM2lIWDZSdGJyMVREb01WdnREdkMvbU1xa3lzTW93QkdMdTZY?=
 =?utf-8?B?ZW9OUmVGa3FNRGk0OEI1WjNIYnhCeVBRdGZrTWVLTWdxc1VYbS9qUmhZR0t1?=
 =?utf-8?B?RWlVNG9xa2Rxa3BhbUltRjd5bGVWM2dKN1BYcTkySGtBWDhWRHVUaXhGYkN0?=
 =?utf-8?B?Y24wQ1dCYUdPMXowc1ZYalJoaFBodmdZdEtxS243VmN1Tlp5RnBZRXhGMVpB?=
 =?utf-8?B?bHJSV2NIc3BRdVpBcHBWRVgxWmtqZVJJbDFjMlIvVDZRbTkyanU3MW9rV3hP?=
 =?utf-8?B?a05pU1YzVEZFa25qOGg0RUUrQktCNXJmZFBoZ3dMM3BIeXpOV21MZm9WRHBC?=
 =?utf-8?B?QVZMU3JCTzZMOXJLZXgxQkszOHIwa2FYUUxWM2pYdWwremZ1Y05QK1UvaHFT?=
 =?utf-8?B?dStCc0JsMWNtNmFoMExoNmNGKzZRRk9IdE1PUnRXNnJNYkZBamFOMFhESS9N?=
 =?utf-8?B?QTRtcmRJUmN0Vm1sVFJNdzJYT0pSaFMzY1Rtblg2c2syZDQvbERzMllmZ2VQ?=
 =?utf-8?B?N2RiSEI2c3RmSEhUMG82aER2UnkxMWYvTkN1YTBtSHpNOHdJbXBuR1lueENS?=
 =?utf-8?B?SFVNU0xNaXgwUXJkdGVLSWdjQVA4bzdZQ2x3ZlI4WmdYRG1tdS9VcG02RjRj?=
 =?utf-8?B?ZUZkZ09yVjJBOXpSdDN0di9RLzJ5aUhab0k3MlFweFU2K05LYk1iUXFrL2dJ?=
 =?utf-8?B?Z3hPVUY0QUJBZFF3UC9jTDhJL0lVekoybFQ1RzdsUnpnUEpOTGpMUjgzRVZy?=
 =?utf-8?B?bGtQcGVySnRmSERJSTdwcnBzeTArd2ZOemVRVHhObkhyT0RlaFFlSmNsMSto?=
 =?utf-8?B?MXdoTVBVUkhjaXJzd0owdjR4SWpjUWNwTVFwdmgzaWg5MGU5UE82MWdneXpP?=
 =?utf-8?B?dTNrS2JGNGlnWWFxdzIxbG5TTXZLWWJydUNwVHdGb3FwL1lIWUJ6WXdCaDJT?=
 =?utf-8?B?ejZ1bHM1THh0YUV4Qm8wUS93Mlo2Nk1SWVVsaXVNMW1yRWJkUnJXenZHMmZI?=
 =?utf-8?B?N0JPamNOVnpkVFZBSE53b3JORERRdjE5LzZMM0d3a05TUElRZEQ5UXV2OWtq?=
 =?utf-8?B?M0VJU3MxdlRGZ09oOEloMUJ4V0MzSThFbytqS05nUzZXcXVxRC9Ndm5QbWhG?=
 =?utf-8?Q?miWWUBa31Xq8PFcM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180fc3f1-c3bb-4564-ee5d-08df25267c18
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:33.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8lla+tbqLQ8cuS3p0UJka/Wf16ZFXK6/CsZRbWLaaeWPJTLlpxU0G6nbUqDX8phRmhwbUfmm5FvPl5BGMh40AARYr4eyJKQf8m5NMf/XtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

The savevm/loadvm operation doesn't make any sense in any of the CPR
modes.  Saving VM state implies saving its RAM entirely, while the whole
point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
preserved in place and never put into the migration stream (see
migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
taken with such a mode set has no RAM in it, and loading a snapshot with
such a mode set fails in the RAM loader.

Currently nothing stops these operations from firing with a CPR mode
still set, e.g. after an earlier CPR attempt.  Reject them early in
migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
well as 'snapshot-save'/'snapshot-load' QMP commands.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f2..92eda90114e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -560,8 +560,15 @@ static bool migrate_incoming_started(void)
 bool migrate_can_snapshot(Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = migrate_mode();
     int i;
 
+    if (mode != MIG_MODE_NORMAL) {
+        error_setg(errp, "Snapshots are not compatible with migration mode %s",
+                   MigMode_str(mode));
+        return false;
+    }
+
     for (i = 0; i < check_caps_savevm.size; i++) {
         int incomp_cap = check_caps_savevm.caps[i];
 

-- 
2.47.1


