Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE3DC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FC-0004GM-EM; Mon, 14 Sep 2026 04:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F7-0004G3-QJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:51 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F3-0005Pw-Pu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SegtJFep6YJ+lpPfXMGS19P2GgaQJeU+LdZqR7GK8samkEWQT6PXUnm4HHqrP6pV2qXrO2abaUErU4XW2QclUZ6VerL9tFHJBnrpnkDm4wtFPFr8802Fxmuy1w6n77XK6JEvNK4imj0wjEfrX16iWyaj29CBrx4RAsmHzVlJNkQoFFaGJe8XkMRegV0xwPoeBR7LES/8eX8lS+Db+YMpxI6y0/yD0YnjslATdDFFDq+xZ1+BUaCber3lJW0PbR332s88g1BZtGFDZDjtc4FyUs+E2dwu53lqI8vdlB5Pk8qqg9npXHxukDxSpcgLdVhwsKYt60Kne4DK58ho+Wg5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THowUMNoBVC1QYYFnQYYycsuK+2HYGeLLHDFJBBq7iw=;
 b=j4Bezg873bEcYG8bO8kyKGmbXdetuntK1Ila6kr0WFp3jrsZ+4qlpmE2RkTKfPf9i5igAQHF2QrZssX1/P27UXU1vIKjDz473IYsMLe5B+yF7q1oikTWrtHMcybWGjZh7OGl7VWawenhxWkTvAaGSQqXx5u/SpzeVnxcvXb74a0ubb0kVAzVmxwK0aV+z+gpuCDB8PG3i6N1VOXm9PD+u1GsN8N2VttD0DSNVSebhO+kMXit2Fl5io1t/a9fQy56X3jhllKf55UEMScqkOKjVSmWUh+M5zN9B+m/D/s3XeTejmDNy9rg0fdGELQY+WMhZMfB5xzHD4nMrydDitOm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THowUMNoBVC1QYYFnQYYycsuK+2HYGeLLHDFJBBq7iw=;
 b=PfsOvmt0o5xqFBIWFFmOKWXll5fiY8buQ40HQV9FKymUHVsVND9wp4G0u+4ZXKBkjdXtQUMHNXxLphByxt4G5DHy5reXO/laJEaFsJaKT1afIBsRo/gqs2TU/RSUJjr+QhQ8DUG2W2OO21D5LvOXwIYz9D8idJdSp85M/B2N+coPpMoVmYEdF+RiDfJoi0qesDVWQTzcPWTp1SLuTeiKKX0U5Ay9yc9g5dh3oQee9Cix8T/EY/t5TYZPuTlUmv3VC4agkOI7oN7e6nrxzXks6P5QWY2k2vJlQXiGHg/cCf8zN+y6JCCG6ClqoYZ6KJXAc/Bd87kDnNxfX2cCYzbHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:34 +0300
Subject: [PATCH v5 03/14] migration: forbid snapshots in CPR migration
 modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-3-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: b250ebfe-af84-4f14-7d3b-08df123bd05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|3023799007|22082099003|18002099003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: eYKk/ZiJHkll5tsHvqId1XfvplLiWH8GRB3B7zF0Z948hcymZmr+CNbagGS/CdpOMiFBKJpJB2taQSJT6pqfChMWoNpdC0I57+JTGG+w87R6xADdlSIw9OGj6X6uqDhvdb7L1QWf/7A6bMW5K8MoW29+VuusmxEYdNxNG7IA1HleUPU2dZ7QT5UExcsSmsN08PHDmjqXdIJUtGd4u8waoaaM0wBSL0eqANq+Viv1F2O1XG+/ERHodjOS+vV9v+DUKGcoqpqo/gg1hiR+LFxx7XAbzDj5ZT+bSvjA9j6MGCZkPTvHPGL+Phpb5MMdoybU1xRVjnbWxqbktLCpAt9JIF0voI5b2HkPWg+gEOzQH42wobm8qEBwCs99a699Lmd3QDxIyHoXLIRZBf4n/LmWAobv97NFdOu5RrdhZtwhz8tnvQvczD7lqz/zEc+sMUloMYlAXTEAV1t47Hnr4wo+u5UUbZ+Yw25fEzCVZT9w6rPNWvtaUjs+BHt8TYjhD14ocvT7v2mWATAvdETkYj3oaMqx2Q/wHxInqVno6orf/YxBto0S5BWE6+uTEwmDeOleH3/zOEsYIFOdiUqlmv0mZ7KGOtlCYoraxNCT2xAs1swSn8Ejg+cXJjnC2sSpXJ42bpLjyGC/9jp5iaDmVXW5bVkXbgr4VKru6zSoJpYsbfhf+e8Y9DGRCYLFl2xOHWUumVdOD3wamXWTnXexkr+6oF6nhTVkeD6K0mp6ASZBfRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJoeG5DZzVOSnREV1dQVzNyeXIxbnRmanQ4cXVFS3lkRW42L2laZXFveDFr?=
 =?utf-8?B?UXcyc3dFbU1GN1cvTnV1bTJJRFVCSlVUcW9selI2MGNOSks1UVVld1BTKy8x?=
 =?utf-8?B?WTJOSWdPRmlHZnZYQmNpR1RBcUFQTFppRVdJL1hXVWtzMWxzZzZFcWVUVXBO?=
 =?utf-8?B?QStzYnJ3MzhKQ0xqYTRCODl4YzNoUk54MVFIUHRURG41bllIcStZSkYvMlFj?=
 =?utf-8?B?OWxCSnhpVUk0WDZOSHE5VmVoSmV1SjN0ekNNeFQ4UkpQV1UrbFVJeXowUURS?=
 =?utf-8?B?NitUQkhZNjV6cFE2MEFsRmxpbEtoWUpwQk0vWFBOMXJweUJDTExXdE9ORGpP?=
 =?utf-8?B?NGx4cWN3OUd1dXBXb05rellleEtJVmZGR2UrN0NCVXU2dDloMXgyeUJaZ0ZC?=
 =?utf-8?B?SFhPWFlJU3FZQThKWjVoUE1iYjFHU2tOTFdIWWh3RlJ3a2ZKTGFpWFQ1N1g5?=
 =?utf-8?B?UGREdU1ub0p0bDVxUktrbXNocEtLencvMGRnOFBSdENveUhpZWZBbDM5MVll?=
 =?utf-8?B?UDhZMzRqTm1ST1Q3TklOSjZkM3gxemxhTmZYSnlrR080VUdvRFdkR0RUaEVG?=
 =?utf-8?B?VTluSDMzRmJ2ZWdyenF6MUdVTWgvb1Rqem5GQWRZK2Y4S1N6eFpvMzNVNm9x?=
 =?utf-8?B?bnR4MlkrSWNqUldJZGExSjBlNUxzWXpLcUxraG4yclBseXpJSzNmZWlvbU04?=
 =?utf-8?B?bDRkbGdqK2w0V1NGVFFFZVJWQ1RBK3NUVURkRm1hWFVLdk9ZdGJNWnZiK3BO?=
 =?utf-8?B?MERqRlMzRW4zWnRwZ0tEZjF6OFZXR3VzMjFCT3BpQk0zVytsNlVrcG90WlNa?=
 =?utf-8?B?R3B6Qm5IcEJwVG0yQm1uV2NCaGx2WTg3ekdWL1pRZE5zR1IzSEd4dCtTWU5a?=
 =?utf-8?B?OFlaSUNETkVubE9YWkRha0JhcWdKV3Z0UDdXeGF4b3Bobmh4eVVXNGJVOXNB?=
 =?utf-8?B?dmdWUEZQNEYra3hSN1AwQ2NsV1pXcUZ6VXNzYW4zbHZOK0JRdHJWVWc0bStP?=
 =?utf-8?B?UDA5NXU1YVJpV1A3Rks0VDhDTG43dytuT1k2Nk5kcERnY0R4WjJqMXlONmwy?=
 =?utf-8?B?TFpLZytHWWk1MjlQNXZ1VDcwOUtWeTNtS20zS21rZ1hTRU9meVVWazF3QnBM?=
 =?utf-8?B?QXhRTXl4alNBc1ZPNUVHcnpHOER5ZTl6UWxiVWVWTkVCTTJ0V0lDMTFsWGh5?=
 =?utf-8?B?ZFN6LzNwWHd1YitOaFkyU0hONlhjNTdCdEtkZS94ODBLR1IxQlgxMldJTmZv?=
 =?utf-8?B?ZlNGUEExcEM2Zlg4R3NRZFdRdjkrTi83ZkVBeit6b3VyUTR1dmsya09JTTVF?=
 =?utf-8?B?amc5QnlLUGNxdHh4V1d5S0hoQ0VtQXBpTnhiL2JlNEt3TmhMZHkxcFVIUFNQ?=
 =?utf-8?B?ellhNm5oeUUwcUc5Z0lPaHdjd1NjdmdmT2ozSmVhTURZN1dudHY4aGpjWmNW?=
 =?utf-8?B?eHZMdkpIU2F5T2lZWkMydWl1SzdCMDNxTE5xbDBUUStsMSszbiswWTdSUnV6?=
 =?utf-8?B?dmJoRnFicjFRNS9MbW5JYmRiRmNJL0V2ZDhDZDNraDZtSFlzYTh1Z0daWUdE?=
 =?utf-8?B?eGFkcGdwMk9RVjRBM3daeEl1cFNaY0dGU2YydkV3eHFpa2dRVklwR2ppVDNJ?=
 =?utf-8?B?M3ZuVHdLbytTTFJGSDRhU1BmTFRpMmExdWRJcEZLalB0REtNMnNFRG8wUXlF?=
 =?utf-8?B?dDJCQStnSERHdGtJTmpYbFVxcGxhcHRlVTVVdHBsT3VEbWxoQnpJZHI4MTU3?=
 =?utf-8?B?azR2SjU4STRGK3BOVXBkYlAyeG1BWG5sYjRMbTJsdWRRZXZIeE9DeGFEMlB0?=
 =?utf-8?B?UHpDK0pRRXFoOGpsSWVTdEhDTGhLSmd1TWJlUVhEamZPN0ZQVytGNHZDc2Jm?=
 =?utf-8?B?alcrNldiV1hmejEwcndjM05paHdselRLZng1MldnM3lPVGk5TDNvcHJUSVRU?=
 =?utf-8?B?d25hQnVqRkFMaG5sN3lLWFd4NWtZZk11dFFGWUMrNldKQW5pS0htNUJTQUZ0?=
 =?utf-8?B?dEZaL2w3ZGR2VUZJU2ZIT3RQQ1dEVTdMK3ZYZWxDR1E0dHBhUnY2azljZFBH?=
 =?utf-8?B?bFZLbnVkMjgwd0dyVkp3SE1PVUpzRTh1dWc3emkwTXgwUnpoMTdaVXBobk9P?=
 =?utf-8?B?Y3g0NWI3V3YxN0hxTVNGemlHWFJyOFBwZEhkZHNYUk1ESTROc1JqNjMyWUdH?=
 =?utf-8?B?WEtaMXJoWnMzclBYQWV2NlNVRUVMUjhUZWpkS2hGTUprc2h0YzNSb25OOGlL?=
 =?utf-8?B?YkQ1dUNWWVFYckNWZk9aOGZZU3cxSTJ3WVZxaXhPemRBMU4wNHZ4MFVQZmNQ?=
 =?utf-8?B?bEwvOTRPY2hqc0Jjdm5Xb3dKck9Bc3pUcEhXdVBjWXdBS3BrQy9LNkwwKzhS?=
 =?utf-8?Q?FAziISn+pfN4vosw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b250ebfe-af84-4f14-7d3b-08df123bd05f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:21.9272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL39+KpLDEOFwLH9qVdm2IcYxmcefGJHdiVedt5FmPpQ9cW4hSXkY1jX/r+K3BnUkxsBmw6TqBZaaropK3uwq2hKjYNvPA/u8gaAmLhXjDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index d2575edb6cb..a8e3eb73b3b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -547,8 +547,15 @@ static bool migrate_incoming_started(void)
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


