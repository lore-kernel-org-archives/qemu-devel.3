Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711CFCA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCA-0008IO-81; Mon, 05 Oct 2026 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC2-0008FB-27
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:30 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBx-00056Z-2S
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goSKHCO3pHOt83SF4KvC4IgqGHNR9g6lGrMJeLiNks56sxUBWzLE9dIeolm7kE+5tNIGIZ6SXSI4/Np1Lqn2+PDXM02lmbCVPoAfGOYcO+PSNcnr3UTHABtx/QDOD4h/LV6ikI2fobe/96nO/c5WD80iUXvy9pWwCQcRMPfHQrnOOf4BC75/uPbMfri80JNYTeurm+U6rdpyPKAfHHT3hqu7li9khNr2QH5vPTnH79IaezSdMGplsmPav2Qy1EAPPSWNHtvLsFfvKWeGp19hw1vdkjQmtlzQ5sa5pS5N3zuSmKBbSBubFmNg/f3sqLidED0Lh+oqXB5fyAMdl6GKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=UcBaMwZMW2KfoL7hNVKigcIAdajfLISFl+MGiGA2fk6Mc839vJT6MdsKPymd/cBRxUtVztSL3fCm29DB1EcZcyIictUQNaraxb4gdAgxr/d/06/akAbVaWL30GaCoBILtSnc7KdyeON3gLPHJKHrMmTsU7AQ1dsgL1pAaJvms5gUaOcLbw/Ft50psA3JsAf4bEilGYDEFJXMQa4iGADzmHGQMk+aQwlf2qB83uY3az1R0P1klF8EFOs24XjTlym1Uz5oKXBHctSbllx/SnLiGnksCUkGzOL/qI9rPWQxhSLwUoAqfdgk5enMxgbPm2pSOKFYQOL1kS1GQqr9eQ/SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=mTdpo9Hjxuyth8OwsnUW3SHuMsXe9K1OdgMVVqgGe3LS2DPqO3prtlx7Gpa1YNoJz9EzKCfZeierC1WK5OshUn15Inn9fopS4+c56vdiVSFAnvk/5q/a3xnbhC4QFxpdEIIZXfP0dkz3Hi1NwKj5dbi1xdtRCCW5khvPCDwSng2RfXAqj+IKghxjU1nTKv1iXkEFtu3OvM10UfKHwG9SuIJASbE5jwBo4xy8P9maaALOGLrCmR5Gl4iQEPtx4rjWz80dTVkzX6Z5kBBbP9uYnCD99GJBMmi/kd+Oa21QBlgev1eO76FLlPJ5QnPZf1LK5wSspcHl1/mBU07+2ndOAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:11 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:42 +0300
Subject: [PATCH v12 03/21] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-3-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3fc39b-b95d-44c4-e058-08df22f17e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|22082099003|3023799007|38350700014|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: vUqjLAX4qF/vcA3Fwbs0cMY6qkqqHRW2f96JqvS3ezLGypgDBX6wjiZsaSsa5ivkl4MIlnpahds/NPFrRmYmRFSfYIQ45KXTjYo04jtj7XigtI2BTkeOehvUDT+JMapyFLysl2NxCJBiVM2VVEEb+QIrVy18/Kiz6sE+dtS3mToe2Ssh6Qb3/86iehuIQcPLU+obzuc53R/ZTZbibptoENSJSG5jHPB0yUTKjeueI4pDpSEc9pCZR26tZwmDTSC7ErYPQhKPC/oIvg81l65Ixs6i3qvCS0Xg6kZ4X6VrFoHNPiZDh5aoNguLZCIozYZnLKbXQ6aXXtJifrgye/56RPYotFiDuqUJ/gFAuFhR+3FQ8VedHifs5LNXQGAXEncXsV494DptvlbigvGX+z7TaySFDxuJA0t4FXekXFHe3sGtKtVqQUrssAUITSz4MVzgiKvB1v4cSpz5ylWH9TzAAw2qRVPO+WL8Jkx2VgY2I2tTZ6TIBMIcucdHYca1PnfkIso/PEenNYft99hihsVGi4oXqhy+2gAc+ewI3SqvcXVutXBBg94tKJqU144qvTeKVm+LfM6+nA151CdFiFgV7tmNZYQY0HexH+/3QuZHTGqhED5C31wkL+JtyyRNBoLDSnAyzrHcTuXXLykdi5zpyrqPzVuHPS5ReRK5ipcBiLC70aXWIqJxIb2OuC307bV2rC6kLHjmL5y10F1gevdkDdCA42WQBw/yM9qdJYKCpfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(22082099003)(3023799007)(38350700014)(56012099006)(10067099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHorYmdUNGlwa2luK0h2VitRUmdqUXFXSVZabWZwTVJaT25KZk1rZTB5c082?=
 =?utf-8?B?N2RuMThPSFhFdlY3K1IzYnUzUXFEc2xlS1JFU0NxMC9hZkNOSDY0ek9vQ2JO?=
 =?utf-8?B?ZW1XQVNxNkRhOTh3Q1VBQkFrTEQwU2JkbXFHV09sejZOYXgwZGtvVFF6bFVR?=
 =?utf-8?B?ZklML2RSNm1PK0kwUVJqVWh1aFBnQVJaVGN3b1ZPTnYxMW1NR1B6RTNGNjVN?=
 =?utf-8?B?djhSd0FTbTB4blFlbEQ3WTQzaTVzYzBPMGJvemxrRStaVjdORTQ3V3dNSHF4?=
 =?utf-8?B?ZXkzK1lJeTk2KzgyY2FGOXFsczhQcG9EdWZPVy84d3kvck1UK2NJN1BuZjM0?=
 =?utf-8?B?WEdCdmpLS3p2Ykp4KzdGWDg0RjdxTU1ON0Y2cFdoMk0yN3ZzdVppQnc2L09k?=
 =?utf-8?B?QUwzWTlkYjVxN21KeDBYN052cW44SlVld21LYXExSndZNURJUkVMZWUvMktT?=
 =?utf-8?B?ZG1jQnFIUkVRREdPTVdjUjJHZUVzd05nR050enE1QThMcXdkQzEvblA1QUEr?=
 =?utf-8?B?SUNZOCtBc3gzSW9hWDB0QUV6dDUzYlp3eTA4OHJKZ1dPc2puNnJQbTFEU0Fh?=
 =?utf-8?B?bjh1WHYyMklObDNRTGg0QXF3aTgxbjRHeVJTL2JtenIrZ1lreUp3T2JEa0Jm?=
 =?utf-8?B?M0hpSzREa1dqS3Q4dzhCV1dNT0FKaFlqbG55SHY0TDFQd3ZZN254ZUdCQU4v?=
 =?utf-8?B?b0tKR2FzSHZ6bWJBay84NEppSHVISnpiUmcvWUJhSFZPQ3FxRHdkOVZqUEhV?=
 =?utf-8?B?NHRXUzV2dUNKV0VHSmlLOXp1WVYwUnRMZUFIR2w2KzVIcTB3Y0IwTXgwbWx6?=
 =?utf-8?B?cjhKdWVzYnVSRmNtdTMwZmlXb0ppa3I1TWNsZkFZK1lYTmN1a3NFNXE1bDZj?=
 =?utf-8?B?UnRqbE1RSWoybE5DUm1XTm9vTDhqenp4Z2VYcGJwMkFLUEhNZWxpWXNXeHRr?=
 =?utf-8?B?Q3pWU2NKK2x1QTh0dm1YNWx2NHQxVTZsZEpyOFBQdTgwR28vakxEZVA3MmV2?=
 =?utf-8?B?WlJDQTBDbis1KzVmT3U2ZTBPWVc3OEdyY3NtTmF0eTBRb3ZBdG9UeVBuQzZl?=
 =?utf-8?B?cElNbXJlOVEyQUdwbWFiVnVJeWdSQzU2akRIQW5qcG1tUzROVVFBZjB2R0xD?=
 =?utf-8?B?ZE5lSmNScFZDd1pEOHJCbmIzQXQvVDhHSEVFK1IzVjFnNkFnL04vRnZ0Zzhw?=
 =?utf-8?B?WXRXTUV1L2RKblY3TFZTMGZpa3BNUHdreERSNG9temVTQ0NBbGozZlpuMEV4?=
 =?utf-8?B?WmhkUjhOUjFGNDg3SWV0cE1zMElacmJrRm1uVmd6VnZ2WmkvNEFqL05tam1h?=
 =?utf-8?B?ekZ2UGVvd05jeHJPOVlNbkprbVRLeXBITkMzcWFGdGhWSW1DRllack5HaC9H?=
 =?utf-8?B?eTRZYW9GTFh3VzY4dU1vQ2ZyMGlBLzFOck54cVNQLzYvc3R5NzhwN3VsOVZu?=
 =?utf-8?B?S0VSNHRta3RCQ0VnQlpYWmdFWEdBcWdFaWpQdER1bzBmOG5vOFEzV3E5aUV2?=
 =?utf-8?B?Y0c0NHhIMXROZ080U2xMSFBRY2Y2c2tEeFBkSnlYN1ROV3pEa3VpaW9SVW1S?=
 =?utf-8?B?dkRKNVY5TTZCSldpTklBY3Z6bENDa3UzNFViU3hRUkNFeGtiTGZJL0oyTGNF?=
 =?utf-8?B?QlJIMHJzNi9jVzBCdEhkTXM3dmxGUUptU1BCRFpicFZMZ29VaEp4bFVYSU9W?=
 =?utf-8?B?V0RzN29pVmh3RnJIYmZIUmgrOFptQXFMMlBIKzA0RGRLWkpmT1k5VWFEK285?=
 =?utf-8?B?OGdJa1VHM1dwODE2RjlaR1NBc21HRDkzVEJjTnNQUkYvYjN0dXZIcDlmUXFq?=
 =?utf-8?B?NkdKWnVVM00xak9UY3ozQlNNT3Rjdk9DZm8wMFYrckNlQTNxYkZXRnpiLzdP?=
 =?utf-8?B?Rmo0VlhIR29mL2hqRU1IUlo0N2FWQXQwZ3dvRm9nSmJ2SzQxWWZRcWkzSW5v?=
 =?utf-8?B?ZTRrYk1acWJKQTlaMCt6U0RRRGd2cXhlWjNCbUFZc0o2bW9uUGxPdTduZHd4?=
 =?utf-8?B?ZmcrdlVFT3JnOFRhdTN2TjJ1Mm0rT2cxRHVobGFvcVgvYm5uVU04L0tkVjU3?=
 =?utf-8?B?K2hlQlZPM3ZwUyt3WVdpeGRsYTA1Sk9iZkNaUkduZmEyNWUyTmNMbEd2MG9X?=
 =?utf-8?B?QVo2MUdtK3hjZjl2eWg2MUdrTXRsQUVDN0pUcExidFQrL0gxaEtFMWFYM0VM?=
 =?utf-8?B?TmdaQkpsWE8wVkdJOStwZzRsaldBQVJMWlE0QVBLeVhlQ29SMVorL2ZLUVFX?=
 =?utf-8?B?Z095eTRsT3JiTkJVMlZkZjdmN0k2MDhUcW5yR1U0MDJqbTdCMURwRnJDSmN0?=
 =?utf-8?B?SFdiQUtndGVaYWFBbHV4SWF4NVVUWVMyb0ZiM3lRZUtsbVV3THlodG5oc3dZ?=
 =?utf-8?Q?8sOkxRS9rhTJnXIc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3fc39b-b95d-44c4-e058-08df22f17e14
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:10.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohy88b0HPRTP/tAyg1gAcTJMu53HSiYa4uuHJzwajCjAzQAOvs/DCSQhi1+Qu7E8rqIbiR+9jfCW5kku/9htAGJoYzZMqFdHZaDyk6W8R5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


