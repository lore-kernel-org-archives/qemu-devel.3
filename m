Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5AACA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENA0-0001er-KX; Wed, 07 Oct 2026 04:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI8Q-0001pA-IW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:16:10 -0400
Received: from mail-francecentralazon11023117.outbound.protection.outlook.com
 ([40.107.162.117] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI8E-0001z2-VW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:15:57 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5QUpkmYAqHXOS8ZO9qD7Qt2LeYzethmnL5iWdOQYLM2kIJ5oWJ+tnNV/EA1tyO0YXiKxPL/BXYOEXWg5j2hhMMRe6NTchqQnCK1zbh5EbIy7ZeVoy0BFMDwRgxxK6vaQsO9HSoqBjTodsvPZOiQfL4C3ejVeQ5yiDwuhPnifYaMynmCDNzrwfIaogejCDQg7NA2bvIIW+pZNjCqyRp2lVFjmUcFqgKmTa14kkwNH7JapcJ2dVbm3mWb4i6DR4NnEgbNoFdU07ATL+6qLcy5FZpyDQNyVX/enCDC75Jx+9LjQfJpMvSOOyCEJ4+OjO1XlbLNDoMOWZwNQ+o6KogLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=LWXVeIxmq5Om2qqjUeK0q6pG30btBZfRuE9OO3iY4BOsGqHJStuJUCT3gsZo62tYQoTvjSf/4CE4eJ1uKiRS1h3k190Rg5VefzfAmBiCMKGXkMFTdNeDjJ/63GJbR4Z/SK6iKeDDp+03lacBY7BBlu3U5pbrw4CCUL8kH08whWrMtc37f49mNO+cDBL8JQZ4HZtuCs4b6nyuhSGWEIUFBY+Aek28pTE7XYgyA6uyhvjAOm5BJyfk/89HnjUKT1Vo/AKRksebLOMgNEk3fE6xas9x/tL/KMLlDPiQhAY2CmuX5avu4Rwo8qccIkyLH/ePaYJn8vCdzLSye6TIp0djzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=MZBwQsooAGeXrFERlVMU4Bc0Ku5onaKBgMqP+5Gu+SCjJ8Q6hbdwqmVtfF+hcGyPBQx45PNw4oudaNmdr9DrR37E57WWvQMGkkg2SxM+p5iHhNDJtjRYy9LEH72FcPoF2gVtWbumTnaH0Sc1vV44hj7DYI3WtwI798nYxBLA/zOpfBQY97HKi4iEILnDAVwCn7dTM3xmrHjrY8dCOtACAsVTQnLZopobZKJGyU5gmUj52YS2xsKI2fa1uATj3RxLWH+PVLSxC1CnWDfecpjg/31Rh5b//hsSDFBhWYoh0dsjLqk19kYgnbtTKlvo8hVRFVIOd75aV/n+dp/QGjwweg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:26 +0300
Subject: [PATCH v13 03/22] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-3-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6685c499-e607-4dd7-76ca-08df23b1f306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|5023799004|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: /uZq/GaCAVPVkYOpOsRlSV465qauuRSr5dcfTkceSx2XZq6lUQ3cw6HeV/aaNYcFWwmtdg1beIDlChi71RC01Q4BRlGlNi2nxRVU3PZC/VtqNMLU4gDSR1MY7Ad0vIKs7EqRPvScpeYetHVEdIMgDBnTpoalgs8ZQTBT9Qlee/Pgqd85ALKbIDr2jCol1bHrZlbGFK8CdPBtU6+kolHqi7265uBicgyjDA3buisP5+L+3cvcg7h33R7G/TzQIzZgHFgFyfcQQbY13RlBu4Fa3kjQqq2CcGxBVBUpSbcTvsT9WzLTLwLbh/NlY0ErZm4GhAjkmQ7dArIGlYfVEgkNVMJ2rERJkunhuzBRolca8ccBNBtHulyDH+42caD1TdCwc20fjJrXGJQamJ6qhiKA4q27oXJjU6G9vZfhZnDKuPgWoIfn32eFJIYr+tV7iAUvic5ENbMFdl6N+8aZZohH0tJfFuAvmg44jLY1++lqPlf2fj52OBmpkXtzIosBLWbXuhLqteo23/j1ogur5VzHC0HCIeLhyNbFWoOD+G5hESlnRudCQxzrVeIcxtQMd3W9+rvSQsPBX4uKXBwGNTiB28PIXfLHnrH5zudJEAum1BoKkzdbx98FmjbQ8vIAuMXGnv7owjmScvAza/b8Y+a2Y6CySgNMSsLqgIP7Unyl00PfzrD8pXYBuQe4AUzJ0ibn5nOd15PY9c2RA1EaNGGsF17cNPxC5MTFcaR5IJ95OV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW95UUE4dDM4YzlZbGd0c0tsYVNyTnl1ZCtveUw0SWNoQThQNWY5VStobE9t?=
 =?utf-8?B?OEFJWXFnUnNpNFg2SWI4aVJJcllqYXFXN0VJbWpVYTBnQlkzcktxSkthZWVl?=
 =?utf-8?B?UE54OEl0Zzl6Qm8vaGNHdUN5QUh3S1Bad0JtTGp4K3BnTG1wbXl4VFlCVlFU?=
 =?utf-8?B?YkFnMWxTdS9UN0puTlQzRVdZa1dkbUVRSWQwKzdpSzNKeUp6UmVYZmNWNVNo?=
 =?utf-8?B?d0NrNExOdmJwbStrUHk5enp6VkFXdk5sbmcrRU1iUk1WeHo2cHVSbjhQMzVQ?=
 =?utf-8?B?eFNnbGlmUDRSSFZoeHNWRTdXS2VuZlF3YldZcGIzWFRlM1AvOFQwWTVCK3dn?=
 =?utf-8?B?MXRpQm1kbXBCRVpwYWtRTW15eTcvdVZsWmRkWFJiMkJqanhrNzVsVEZSY3ZN?=
 =?utf-8?B?enEvTW5SOXZtcHIxQmd0K2E3SU5oRnBHM1BWL0NJbVpSZEczZ05RakhCTTh6?=
 =?utf-8?B?dGRzMENxN0JNK2tGRzlYTHlKM2pNM3RWK09YNFhiR05iRTB0ck51aThpQjUy?=
 =?utf-8?B?MDJzWGFuRVMzRk52L0NOMno2RlFSQlBjSERqQkdJNEZhSGN3czlDMXp4OWlQ?=
 =?utf-8?B?djA1aTVUdHJZTEZqTDk4b05GaFdBa205ZmdvaWFyWHlRbzRheC9jQWNRUnpK?=
 =?utf-8?B?VURWRzN5Z1g0a1JCWmNFK1ZjZXVDR3hkVXdwS3B0QzNUL1RvcGl4cE5ubGhE?=
 =?utf-8?B?dXN2VHR6bnRjZjBIMUpuQ2RkSDFya20xMEdiQUVXS0p2eWFhNDd5WEV3cFhO?=
 =?utf-8?B?eHRrRFNqVE83L01IYnd4VDVhWW9Cekh0UUN2a2tkTW1Xakx4RHlHbVZrdUUz?=
 =?utf-8?B?M2VYUDJuSmlMRHNJVVhZd0JhWWdTZGcxT3RlbGlEZmtZUWZ3ajV0SnE0LzJJ?=
 =?utf-8?B?YVBKZEIwaVZoQU9COGZiODdteVArQTFCZnNmRnM2WHE4d2R2ZkEvUkRQZ25m?=
 =?utf-8?B?aFU0TzRkRjBiQVBXZDFHSjVLWjVVLzZwcTdIazFibjRyemxQZzhrazBGdnpz?=
 =?utf-8?B?dldRSjgycVpJSGpQbzlzLzU1RkxqZUlPTEo2Q2xmUXRTQ0gwNnNSVEc0MmNi?=
 =?utf-8?B?RVRERUI5WC9SK3oyQU4wUHNsTmhzT2RGbG9yb1lLUEJ1ZmNqRG10RkhzVHQv?=
 =?utf-8?B?QVVCSE5QbGhVTmliZEpldnI1dFdjR2hiZUdoc3ljTVVESHBqOEVPbHRvZ1pp?=
 =?utf-8?B?NUdqV1JsdXA0VlVieC9PZktVVTdQZE13czRFb1FXMDFFV1FkempiUXVLaFZa?=
 =?utf-8?B?eGloWEFmeXlSUlc4cXF3REczbHlnOEJtRkNWbnVQUXJIMXJUTTRDaG02SHVF?=
 =?utf-8?B?QWV2ZENRT0ZkMldXMXpIcG9vL2wyRlRwRjFqT3JXUWVSUHdrdXhrczZFdXo5?=
 =?utf-8?B?T0VldnRORllvellWdk5aTVRuZERvbldrTUZLdUZFeDJwZEx1SkJlMWM5anlX?=
 =?utf-8?B?YnBVNU42cEdkUFVnOUZzY1o0Wk5DaHloazR6U3NnSWtwYzEzb2U4dDlVdDlJ?=
 =?utf-8?B?WUdhM0xiRDJGRHY5cEVDSkRqbmdWL0lVUTJaMUswelRpRFJmajNaT25hcHV6?=
 =?utf-8?B?RS9RMGZXOVlBV29pU0ZBUVJwTjJDQ09lOVV4T3dYRndRRGN1Y1F6Z0hBMzUy?=
 =?utf-8?B?VG92RlhiN0dIQTlScDViV1B1RWVVWmVJakYxZjZTanlNNWV6MVRFSHZlaVpw?=
 =?utf-8?B?MUhOMzZnbkVWNXlvRThsWkw3bkRrR0QxVWdTVFlubWhTK3pzQ1lFcEhhdDA2?=
 =?utf-8?B?Zkl5MUp3Vi9yem5IaU5iZXcwQnBvVWRsaDdzeitoNEt4OFkySTAyVmVmUzM5?=
 =?utf-8?B?aEdwRWYxTEFkZVJ0OS9HelNsZjZLQWlZUlVaclp0VjB6RTJUUUJvUG5KNGor?=
 =?utf-8?B?YnQyWHdaNzdnVkNJMkZSZ1NVTVVsL1ZYc1JWbUdjeEtPZUl3YzhNeDNMZXcw?=
 =?utf-8?B?blpGNlRoTXE3L3QvbnpyanBMaHVCc1M0bDJ5ZldiQ203YjlNZEp0emhBYjh6?=
 =?utf-8?B?cGNHalU4amxDL0h0N0RIQ1FyOU1MRU9WV2gzZVVuT3FNSzNkNkNVbytmWll1?=
 =?utf-8?B?OGpHMlFoRUNUYWtHMzJ5WUtSSmwzOC9laTUxUnc4N0NSdlh0Ykx1UU1vN2dP?=
 =?utf-8?B?WDZQREU3NkNPcUJNL3dSdmNZY3F2Ui85bk0xa1FsL3pCemFHSnF6MHdsQ0Jq?=
 =?utf-8?B?UUg1Z2Nkb1h3aDRvQ1RLalVXZTJqUHhpeFhDMkNPMFByN1I2VUJOVGwxODFh?=
 =?utf-8?B?Y2RYMmpSQ0g0UTZIMWg0Q1gyV1kxZDd5R1NvdnRuRUh5UVJVZ1JLa1R6VnhL?=
 =?utf-8?B?L0dNd3cxdDM1Si9xamQzeVF2S25lblpWVjNweFZxTlVBSW9QQ0g2SElHajVv?=
 =?utf-8?Q?iMWxcZrD94vAAoVc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6685c499-e607-4dd7-76ca-08df23b1f306
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:50.4260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az0cpgzD2zCkxLed66TysneZKQNNV8ZRdeOq4boHE2gel6cStw+rNytVJcony3vSkjOJe14MJB2oEk4oP8dS0tC0K3fdUXxtQNRaehC+Tmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=40.107.162.117;
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


