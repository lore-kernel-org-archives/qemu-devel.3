Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD2C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIH-0002Iv-Kn; Tue, 15 Sep 2026 17:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGh-0001MM-Cs
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:45 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGf-00010Z-RB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9hg3drfWixv5x1nheJPb/+hQYnfzZIkE5QMdXnNReYanEkwayy1qQyCrIv144dyUYYtxF8IL18/XHN42RCBztHCTWhpYnjI7V0wIAdyfTAFgZLF02s7rmX1eSelP7EzZpPVVChy5NGCEZjV/sidf4loa5VgIAAnpSmxCskM8aRqtxu2iF5m+/YBLnHFSYhudWN/HMrAT6DzQhDMYY0WL/2CMb0+eVIXCAsUu0X4zaP945WoO2Nt+q8GhFRP9uIQFj1eActqE4Tp0PaAkpI+oJdmN2Dp/+goy1Hzk4Gc1618Q+UkUVfMaB2feTDxiTD/SVP0DtU0zqL0DPiYKZFqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WebTp+tcOwBl/cWDYNPVeINW0qQudSX1ByQo0NMoTmk=;
 b=CMYDiT8FnlVCVt6y387y1Qrc0EzkOXGtE3ZTfYmXcas1IulYEHThktpcSyeLYARf8NTzB4Ni/N0TkQLe3FCp71zVeAZ6y7zbx4ZPtZNqPgKUBTRww97OeFJHKIm8hjf128PGhcmd+0WTnC4opHb+HrtPD8DlcAHu3Y2nT2+tnR/Buveq39QOWd1VQ+BBOoeIDlnp2oUsSP1LPuFz1JUzb8fApHkBKJkYPDhMg1vzGm0jftK/4oOR7eTAuavHOohs57yk+/7OUQQmU8+tpSTsV+G7aYGxI8b639NKEizB1dxpEiErWVCxePh9us40K4qHusSk6Y0xFq9aneySOCzKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WebTp+tcOwBl/cWDYNPVeINW0qQudSX1ByQo0NMoTmk=;
 b=YxQgRv8Z9z27T2tkLpnh2oszjbDfVkowgaOIK5pdak/ntNT/zRcv+I5I5aYqTAyYUoZdlp2yUBdfUMN33aCppzAnqGvB3ONVmAphK9WhMbsH46kdpQMMxGUkdha2uTS2FSeCPsU176Q+iop3oOfaRAHU5D3ho8nMGGp+eTDxMxwVnvKhvpMM6IOWkkiszA12gw5HGfjlEhMIKSQHOCb1oXCeFh6JKTa4rZc1r3HpI27Z2MZzXZZy76Wpl8HyqG9Oi/86eJWZmVxrm/YW1tBs4IVdtzIUQe+maBOiPFRBZ1C3uJ47OwPjGIS2CnQgR+AgVnxjOnp94A6wgeOQjdSH0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:39 +0300
Subject: [PATCH v6 03/14] migration: forbid snapshots in CPR migration
 modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-3-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8884f8-7aa3-4b2e-f24b-08df136c6123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|5023799004|56012099006|3023799007|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: nnYkbZcUoKYILc7V1yvEJzdz5SGNDn2HZncxaO5amBQUkZnUZi2qqvv0lwGlAZv85N0ohyIZ3Pjd1CS271khUJ3OeuiWkjmUXB1d1wSbehQCr3kcca1aV7v72uOfXze/Oah7oYLhizU8pRMgN47V3E0ijTuTNjy0anEB83eWHk2kKYKxNOB5Dk2fie5IeQMghXjxnqMrpN3qpT4+Qn+k39jG6Wlj7hmFVAyvOxjJDGBz14Ol/xMIMzH/wWnWhHyz8BybHIKG7UoDx74PMMU5tGGTxAz9ESzO88NUEOZiQDd8DHauIRdJEZZ0z9BzYjCKjWZqNYn0KG+yljaFTxWzOwZXhiJ1I2JKVYWThKtoIj5eIiFdd1JOTXySlfHw2/gDyZtBxEiihL1luLii1A5EpGluTj5MxaDn5On2RR2sudxm8aCUDY6ErYo3j7NCRe5ZHQnX8p6qBM99mvEAb/O2gmb59pEgsmqCCr+eHvNW15Z3Nurnn5A2SF/92m9jY+9tm+5XYn5dGe1RPrg42n8LUtmsxc1GwKxdomGYIya+4jbYp61NogWIRd8JYNyhyWfm+BWxvHMppHvuSBU3GbjsAhjnrasM2shZQICfCqkT+rZhuPjMXNa7qvA8ISlDkwq2PfCGOc/WrNfqZOykFXvxCw3WNh28JN2tjnD1X6f3BdYSzJQgAsu6ZIQiEld5b/VJD2QGVUoxrg2diqBUHRXrt8z5yS7gjsj9p5tO4LDCG3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(5023799004)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5uSmx2MVpqY2k5dXFoM2V0dGZmUXI5cFY4M2RkM0VvT3gyR1lZbFIydzBl?=
 =?utf-8?B?TVNoa096STNmek5iRlQzd2djTjRMb3ZIVEVLU04zZlZ3QlE4QWJPSzlJNlJh?=
 =?utf-8?B?MkJEbk4xVXFuUE1vbXJsT0FOdEVoRVV1WHVnTWZXR2g1b3Y4VzVlUllZM3Vz?=
 =?utf-8?B?RjN3TVkyOXJMb0JSdWUzeS9Wa2hnNFRCRFVOLzlOOXcyOXk1VnU1a1htcFJD?=
 =?utf-8?B?ZC83L25ha1ZIN1MvZHFrTVB1QVJoeS9FWnpacGR1RDVjbzNhVnU5WnpZU0Rj?=
 =?utf-8?B?WHE3dUxNWDYzQnVvS0RuU0FrdXNCNmx6Y1VyOXZlOWNNU0NEckdYdk4wbkQ4?=
 =?utf-8?B?SmVpNzhFUGVDUHpDWHRSQm15TkZvLzFLZ1BGbkk1dzdKc2tPZkNBeTZEUzlL?=
 =?utf-8?B?WFJJVXptaXJtYkZhbUJOSDA1dFlJODYyZW40OThPRDhIK1dLTHEzMy82VnB4?=
 =?utf-8?B?dFQrRFN4N2JlS2pyM2JTT2xBQU1WSSszL2tEdWJ5NTk4dlNWTTh2T2ZRVVJC?=
 =?utf-8?B?WGJLdkJHT2Q1ekJMVitJNWsxclQ0LzVlNTZzNmlBemFjM3dJaXYzQ1Zka1NC?=
 =?utf-8?B?VGdwd3BnbHlKTHlmNDh0dTAyZVhmSHZqUkphQit5RnVVVzdCTmp6dFRvakgx?=
 =?utf-8?B?Y2FNT1JpbGZPN2t4Z21mT1VRSFI2d1pjSUpCdTZGd0xaS1p1ZUV0Y0Nrd1Uy?=
 =?utf-8?B?MW5JVWx3QUMrVFBvMTRDc3Bld2dJcWtPamFTQndlWXh2aUU5dXJGWFM1Qk1a?=
 =?utf-8?B?SjU0RFVWNEVidjBuM1NUd3pPM0lHWGlkV0d5eXl3ZkZNcHM3TzFValZNTUpB?=
 =?utf-8?B?N3FkdmgrZ1NxZlowN1k0b3ljTHlPanR1dXJVZkVMWXJuRUdLSWk1eVVBd2Vy?=
 =?utf-8?B?cWVPbG9sd1FqdWgrWFZWZlJwU3Z0VmpvdEo4eWp4NXYwY2lldWhxeFUzUkdW?=
 =?utf-8?B?MmlNczdlM0gxaHRhNlRHVHpLL2pIZGZJOFFmeEw5UCtxYjZqRVJXeUMzY0VH?=
 =?utf-8?B?OVBqckloQjNONWVBS3d3NStEZjFQbEdUWnh6Sjh4ZGsxQXRIQUdCM1NWZ0NO?=
 =?utf-8?B?V2ZvQ2h1K01ORTg4bm5zeFRUclJGMEtrSUVIak03S1JHOUVuc2haTGN0K1I2?=
 =?utf-8?B?RTk5cmR1TC9ZemFDVjNOVzJ4b1ZLSzYrdGFBWmR1cE1wamVCb0NGWnAwOS9h?=
 =?utf-8?B?UmNpaEVtZmVIVTJ6RWdFc0ZVdTBjY1RYZ25LMWpsQ3BIYnNndHFXZzFqRitN?=
 =?utf-8?B?WTFTeG1vVzZWdUJnSFpvZmQxaHF5Q1RhR05KekxaWHllT05yZEd0UHJ0T0pG?=
 =?utf-8?B?bjNaK0IvRkhFMEhpU0E1OUY3ZUNpRy8zS0NDSkcvT0lSK0QwOE5obkUvS2lo?=
 =?utf-8?B?Mlk2NkwwSmZKR2FrM3A4YXpaMTY5YlB5NXc3emkvOEprYTJLVEpQT3BrNmhW?=
 =?utf-8?B?aElUYkpqT0pTTUthSGRTaE9GckRvM2h5Z0dPNlR2L0tTZ2ErcGRMTlNBaUhH?=
 =?utf-8?B?N2lsVzNGZVBONjg0dTRzQTFqY2hmOWlpaDR5WHJrWVB4OU9DSjBnZXNBeHN0?=
 =?utf-8?B?ZDB3bURBTkNTQk5IM2JIRHVpdk9XSzg2VkhRR0hsTzh2dFFCOW1URnBpNkEw?=
 =?utf-8?B?cmJiNXRuN05HajdHYzIrcnc1SDdUeWVIdk1NN2g2V3B4cm4vN3ZzYlNLUTdE?=
 =?utf-8?B?cGZpcVVUL3dyUkExeDloaXhmVll2ZmlOd0l2NWFJUUlQUWV5dy84WDZvZWlX?=
 =?utf-8?B?YzB1V3NHRFNiL3QzQW5wNDlpVDIreCtVODY5cG9WbGEvK3B4UkpON2JXT0My?=
 =?utf-8?B?M2s4RFpaZ3lFVTR2eGdMVGlIVzlaN3Z2QjQ5bFY0WnVTTFVqc2s2UXlXY2lX?=
 =?utf-8?B?ck9QS1RZRFRUWEY0K05QZm8rWGE2RDBRdURvNEYvck1HaUJQaWFDOVpNWDEv?=
 =?utf-8?B?bjdNeExMbFh0K1ZkZnR1RXZOeTk3SXRWM0hmSnB4WjhYbnBGbHoyK3FWQ2Ew?=
 =?utf-8?B?Ni9IK21HL0xlcW1zUURabHdYaEdSdm9MUW1RN20wUTEyTWFrbHcwQmtNMFBQ?=
 =?utf-8?B?ZjViMUVyelpoREVWTnhVYlJqWXRZeWFQWUQ1TExWUTRyUFNqYWg2Mm9kcG0z?=
 =?utf-8?B?NzVSblJzcFlIUTVzTmt6VEhabktkTzVKcE05SkhCeHhWb1ExcnR0eE5na1pZ?=
 =?utf-8?B?WnBONmp5cTlSMGcvQk45aWpQeEc3bUMzbTJKNUc4SVFLZ0lSZ21jRU84Vk5m?=
 =?utf-8?B?bWpvWHpPRTd4MTdGZnNMNXduaTBNa0ZNK0xKUndBYVhOM3UwcEFLZjlkRGdk?=
 =?utf-8?B?YnNLMmxnejRPK2EyOGZsOU91ZFdUcFdCTUNWdkhScTBucVFRMk1IazBtR2sx?=
 =?utf-8?Q?y4G1zjdOhJSubBew=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8884f8-7aa3-4b2e-f24b-08df136c6123
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:31.7934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3YJjdSsQ3qd79m7e5pruJMgt/4z1meFfE6WcjdsXlAwYrzJmHV6Q9AZPmkF4DtFIAaUD4R2+9gNm2+jvecB0C/MWenIe+bUyssrPrj/Pao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 05b026f4bf2..f648be1302b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -555,8 +555,15 @@ static bool migrate_incoming_started(void)
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


