Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A657CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8w-0006KP-E0; Wed, 07 Oct 2026 04:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI5U-0001Ng-93
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:28 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI5P-0000LX-0v
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:58 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdMnq2a6icrIn2gYqOHqiRZsFf9Ll1l2lx8QnxInTFllczLAVVG7fmt1ey0uDvTUF5bZ0V55vPKoFLUtzuQstrOgBlH6V0xdXn8SEcrGybYw9NcUU97xtlgJeT29rqqKaNuzDuxV8IHf76O8T4uCWbOup/sEb4CdqFw8DCQNpR8gUcTU2SUaxh1VdLBmcmBjaITKje1m8Y+9eU6/XJU1T7ghJgsXCjUBnNaoGZcNgm8005sKyOGtsvw9Jgk/KYTjnsQWUTaNNu6GnjbfzaCn5rIvz3wbCvmOp/egGZpkV7Tl+g/71sIpFKJAZAygGBn86l5N90mPde12+LnYrncV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAJdER0j0Cvfmn/nbJjKW2YcvP4fLpWALVNcV1L89m4=;
 b=ZkEbrqdTV0e05APVNg2EhnHfuhuYFuvGP7HtmcB7KHnv6jARW4DdSyOpPu/wIxbYTX+ew51n8Zh4EuxnCAE4NS+3Cvjy7Qf+Tq6Hncs8GvePjzOtSvONCm7q2v/98s9JZTj0gWqo4vBpQzsDfUCJqRWN/ffWKS7ToTFTYOllrcNLayIeLO/ByG7ciiaehq1WCSmc2TzhO06jGDDEchNAJmbr72/CcXeFuVAK19JkUBKCk7C4EXFZF4f3cWeolLcoyKBXbVWTnMqdcdZx1yT8Rs8/A8oaorDds7WC0MnuRgcuhwcLfXLAPDBVGqO+vvA1McwGvq+Vh9BE5VGM//nBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAJdER0j0Cvfmn/nbJjKW2YcvP4fLpWALVNcV1L89m4=;
 b=iAqtoJq5Xu60WKUDJgqLGc8zm9QqWy1eduBK9Ee5FYFmy8jDlsC6td0wzewpHg3od1i/sMTkyQg6UmOSzA/AJYxYTA9c8BSjWeaUURPWM5fqlRRb2kKjW9AR91X6kurkOzzDFUbiLZmxdtepn1Tid2XWxCh+bqqCSFCN9/TEoNijTPpRnvC/Ezs9lxLx5AKLP2nWA6rb7g68wxflKPUsznIkGNopI0LalboEN+Nte02cDulcaBeIo3WlaKSD3yg1jRPWAwGeruvd2Y8SROawDYhTIqMlrdXgxY+vytFT8+84hjBHpsb0XlmJDdy+T+pfZf45W7PxWI/5DXSulN8Pog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:59 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:39 +0300
Subject: [PATCH v13 16/22] migration: add incoming migration failure notifiers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 790f4495-4c1a-4d6a-ca76-08df23b1f851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rfbOVr4UeTifQ8QuLAqM6GBMvP+8w/va4spfo4ijb15leNxV/FTk1dvGFuD60/e8WxQta/GCZhD8Bu4VFFhRttJ8JQTblBMaj7p5F8zLApXNVXNitEeP9+QwhjWOhiR4ZkiHd0oX0E4S+7VTheJmSy1mglTSL7T30YK+hisEPzkX63aK2Ugm01msADD/CCB92+b7hzDvXbxB6U1KzmbDv+k/UsSiO5BNdM8aPmBFrk5lNZOZZ9yxxAC9WcR92IN/adtwZ/VgZoZ0SYUSRzFRmX0Y09E8xzciGRFhXQ3xyt3KPFVeEsiAT1/QI9IYqLJ17dA5wGetIPZCzwIn8SvwxqtSDwKObCRzgBBnmGh+rjM8pKhzf7Cul+kAKaXEGLX6yjTOntxKT4B0ISMxJGW7PbARPqkFIKzpZaxuV8J4o4YURCfiF3wDn9rCG0FUTWU1wqLqGrCW0cFR4DG6ysV7huSG9l+kgfBYlwwBN9koJR54ggbDOBS7LZvVvURGKfOonS1w+HQvMAfytOTijPSUDFBXfJQg3cfhnZtUjAWwXM1auUlP1DJExlSwFsUThHMEvCJVuUxglKWWCwF9DnY+pQ/uRCmVFSwC6AWAevBpMGnxTFtRogL/ssKjfCuiB8wc162y9fgQ+Nr1Cal8eiA9ZG++JW3MCQn+JrWhhrlzp2vLFVwcuZIepiKmk9r2J56uhErD3yms9RcW4KBDaqjh75W3TczI9Bgkrut9x0TEMLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0U2eDBnREdnb1h3ZmNGTlBBOU1qaW9WV1B3ckRCRnhpYlY4dzZHK2djaXlD?=
 =?utf-8?B?QWdWMFlFaFA3MWUzRDErRCtvWEZCQk5zeGU2dkhGeGNWcjIxcVRTYlFWRkJL?=
 =?utf-8?B?OGNuNG5ZdEJvNWpuZXJtWWREZUVoV3ZGM2ZOa2dYdzIxblBiTXc1T244SFht?=
 =?utf-8?B?aTJvWDhHY29CM1BwdVlDeHpTUExlR3Evek0ydnhzeG8rS202UWhDbzIyVmhJ?=
 =?utf-8?B?NUp6K0dQcDZ3UWxmckplYkxDcXVwZ3FpVXYwY3pkczcreXRmdkszQTN5RVY2?=
 =?utf-8?B?VmI2dFI3Y3N0SEFrblp3SWtHL2NkeGUycHdOTFR2QkdUZ0NuTkJ5RUtDSTht?=
 =?utf-8?B?akdtQVBRYlE0SUpnZWloMkZLSmdGRVZGNkl5Zk4zMWdndHFPdXdLZzg2VUli?=
 =?utf-8?B?NW5LMDhkT3MwdnMweW9DQ3ZVVFptVVN2MjRtaEJtVlRZUVU2UEptY1FGcHdB?=
 =?utf-8?B?SjhNeEF2cUhhQVJ0ZEpKQVNkMWhWYTJsSTJ5clFBYzBhUVdLRENpcDRONnlJ?=
 =?utf-8?B?U3ZHd3RPRHFvRExmV01qU2NZeHhzKzh4NWdJTWtjODVWMXZwSjFxbFpmQ3ky?=
 =?utf-8?B?QUNJWnRpYitueGkrZVBzOU1OS2FQdklnVEFSNFZoc0JxNS91L05vN3dzaENk?=
 =?utf-8?B?Z2oybWkyMzNIUW4wc1J4RW1HZjJhV2JwWlY4allXejZwdytyTWhMekR1aWFB?=
 =?utf-8?B?VnN1blBtUnAySElDY2xGdkI3ZnhnWlg3c1FQUTZuS3pIWkxtQTZWT05MQ0lY?=
 =?utf-8?B?dGQ3Ri9GeEhOVXFJMm5lZDJ3YkEyTE8wT1dUbmVOR2ltQUxnWlYyS2xOMHUw?=
 =?utf-8?B?dHdaN2J5am05elpibXNrS3BxZmVBNDhmTFpieDhSQXVwTHg3OU9LZzE1UkNM?=
 =?utf-8?B?eExwaFpHcURVVUw4S3JJUk54ZWlJWnJvZXpack5QalJKbHNMV2xkVVM2aGpQ?=
 =?utf-8?B?WnNSc1V1UVZmeFRQQ2o2Rk5yL0ppb0FCVVloZ3RtUjl5d2NmVHJzN0pYeXJx?=
 =?utf-8?B?cXZQZ2ZjQlVmM1FzWmszcmhvcGQ2a3FlR243N3JQN0RoVjd4clZVTDdMM01O?=
 =?utf-8?B?U1BESS9vZ2MvWmxOdDZsb09ZOE9JL3RjTFJSWlFlejk5YzZ4bTJxMGpiWDJZ?=
 =?utf-8?B?a0FlWkNRYWhDejdlRFZOMVNuZ0VlYkxZRjMrMXB4MXJGTVpYMEZ2MVMraFRu?=
 =?utf-8?B?bGpVVjhDaWVNdFNvRFdPcGVJb3ZHT0tydFUzdStCazk2TExLMlJ3Nkw2aGpN?=
 =?utf-8?B?dEpncmY5NEl4R3JaenNmUFR1NEE2WmQ0RGwwV0tZa2Uwc0JKSExKbytaY1Vq?=
 =?utf-8?B?YUw2TWJ1aFowUlpqR0JOcmk3NEV5RGp0bG5SNnlGaXNnNWkzZmt4Ny90NU82?=
 =?utf-8?B?aFZzQ3o5cmdqeGtIYkZNN0phVUFOd2F3YXRwcldBL2p1bEhQdmZkZHFCS1Q3?=
 =?utf-8?B?SFE1Ynl3dk9abC91RWE2NmQ0by8rRDl3QnpQM1NqY1BlbXo5MC9yamw2UEFE?=
 =?utf-8?B?M0NHUTJTWTZWQnJ2SzhPeEFjb1lYTkVjQWxQMGZZQnlqUXRZL1RSWVdaem9D?=
 =?utf-8?B?NE9SY3BMRVlGQlZhaEIrdXYzVDJrNm8xVjNDZkRLaHNjTm9iWjNlMkdUcUFR?=
 =?utf-8?B?U2NuaFI0eGNJYkJhTHNYdXRxSmR1Nk1HUHVUd2c4Q0FkQlV6a0NYa0xoUE14?=
 =?utf-8?B?a2JGWkZIc3hNS2pkUmN2Z3VQaVNvdG9VaVdBMjV1aytXTzJQbFVuQit4RmhY?=
 =?utf-8?B?WHpXekppSjUwZkkybGNFWU4rUkNud2ltTlQxcWJjMmdJdm82WlZXdmh6bkdR?=
 =?utf-8?B?UnpLMVVzaFhCeWY3a1pxNDRBeHd5bXNSZmpLby80YmpZYkl0MHlVT3o5ZGRo?=
 =?utf-8?B?eStYKzhCNWNobUZ1cDVTKzZ0dy9Ud0YydTFUTkhkbldPcCs4dzZnL2YxUURy?=
 =?utf-8?B?ZXMrWnBacWJmc1ozbHJxeWEvbnRCOUNNLzk1N0hjNmQ3T3hPMmZmK0EvRS9p?=
 =?utf-8?B?K2xSREllYWdCTWViTXZ2bmxCazIxYU5aSjdUU3Q4L240WHRGTFllaWpMYWpj?=
 =?utf-8?B?MWliU1hHT2hCd3Rwc2hGL0FlL3B4dXZQWmVoNVE3Y2xIUFNneDc2MHpPdVhh?=
 =?utf-8?B?YTFXRXAzaFJJRllmV0N6VXV6ZkxOTVdKdkUvOG1MRHVJY3BESWQ0YXluN25H?=
 =?utf-8?B?Vk1JYUlVWWJpVkxqSUlJMUszU21mZ1VEeXdraXpEV050Q3hxbzkwc3dNSHZ2?=
 =?utf-8?B?Vlp1S2RjWWxWclp4MXg3Y2RDZDJJVVBiL1dIWCtwbnZkd2h2eCtNb2xIV3BX?=
 =?utf-8?B?SXNJM3dvZnZKcWpPbXUvWkZZWXJBMkV0NEFrd0EzTmNvV1JlZ3Npc3RPR3Bn?=
 =?utf-8?Q?S+6ga4ndrih1jFZ8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f4495-4c1a-4d6a-ca76-08df23b1f851
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:59.3090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUvbEY+chTeOTuTwAyrbFmTSHBtV7m2+bWtP2G9p9HW244ua1K4S90peaITzBhXfPDis57IlAQxOTIBYRDxOVOrQDxLuCOMKysq9V0+T55Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

A device may take over a resource from the source in post_load(), e.g.
vhost-vsock acquires the device ownership on a CPR target.  If the
incoming migration fails afterwards, there's currently no way for the
device to give that resource back before the source is told about the
failure, over the return path or via the MIGRATION event, and resumes,
or before the target exits.

Add a notifier list for that, called from the failure path of
process_incoming_migration_co() before the failure is published.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 include/migration/misc.h |  7 +++++++
 migration/migration.c    | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 019717f4cda..08d110750fc 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
  */
 void migration_remove_notifier(NotifierWithReturn *notify);
 
+/*
+ * Incoming side: @notify is called when an incoming migration fails,
+ * before the target dies or before the source is told about the failure.
+ */
+void migration_incoming_add_failure_notifier(Notifier *notify);
+void migration_incoming_remove_failure_notifier(Notifier *notify);
+
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe11..01e11f91fd9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -71,6 +71,8 @@
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
 static GSList *migration_state_notifiers[MIG_MODE__MAX];
+static NotifierList incoming_failure_notifiers =
+    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -815,6 +817,16 @@ process_incoming_migration_co(void *opaque)
     goto out;
 
 fail:
+    /*
+     * Allow the devices which have registered their callbacks for
+     * migration target failure to undo the changes they may have
+     * done in post_load().
+     *
+     * Do that before the failure is published in any way: the MIGRATION
+     * event emitted by migrate_set_state() below, the return path (if
+     * present) in migration_incoming_state_destroy(), or the exit().
+     */
+    notifier_list_notify(&incoming_failure_notifiers, NULL);
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_error_propagate(s, local_err);
@@ -1590,6 +1602,16 @@ void migration_add_notifier(NotifierWithReturn *notify,
     migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
+void migration_incoming_add_failure_notifier(Notifier *notify)
+{
+    notifier_list_add(&incoming_failure_notifiers, notify);
+}
+
+void migration_incoming_remove_failure_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
 void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {

-- 
2.47.1


