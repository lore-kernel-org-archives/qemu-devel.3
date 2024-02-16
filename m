Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940BBC48BEC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauBB-00026V-D9; Fri, 16 Feb 2024 04:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB9-00025T-0B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:43 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB6-0003sk-VN
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:42 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41FNHCVg031610; Fri, 16 Feb 2024 01:06:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=8wR87dIDhi4kjZ5//Fd6BW6JjdVFRyo5dwvrvPb8F
 EA=; b=FWa68d4wabAnzxRXwCfdk+P9JNs6Sjz2/gEnOoqk/3ALedSP7QsDPw2h4
 gwlvBs+NkCARQu86BzFEnQ4k7P9Eyl24ZUIegOh9CvG+UqD2z7pqujO8P7umOfBr
 9S0eXwukIUqHFkh707lYI4gLOBkwrGV8Q90l3412H8Y/LE8URvPAbBCKVKS3sKQT
 7Qc7TwNqQ/OmqDoTwmFP3lbUuq/emdSG+RSVYBGD4Wcs1G7l/4lhQVogezz8klFP
 rvXnvTrOnptdh0NKNY+VCACl4eRh/zLqUOTi9JAidHJD+FSjar9NPCAWdogEbEME
 AhWNO4E1ieqhqtQkDreJedavOp/+A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3w67jacvmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 01:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjE1Q9k64Wn6L+xLsVGfgo8E1CFoKxLvHWDRn7tdDagwqCko+rn5ekxKBxC2LwHgXbUeeuQ6QDI/KazH3hddaZtS16d9fah9EiAmn3i3wc2tfmYAME1u4h/nF15JaX7CYU1MSRy3UCkIQ960FTGM6zFb7/axgGKF/qfzQM6POl+TcKDsonNf2UBqMSycfqTt4QqpRvYkIrNUq6KjJJHfdEYmC4RKFFQblSL8/9dKKBuz/2v5pkAajucfZqrL38Qq78Ka5lBEJnroYAmVIsJ+9nm0GdBc4wO/pfWQYb7c3l+l2qLbHwTu7EVNtjzuVDPzTgSgmkLjhRUEJukSC5I4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wR87dIDhi4kjZ5//Fd6BW6JjdVFRyo5dwvrvPb8FEA=;
 b=exo24+LAJ4LPKcap8xKkZSr2vjrddM4b+V6BptmH50+wA87i141LV3MnP421YPy/S0l+lk7IfkFRAH4IvoNcrCjcqG5xrPrXOmv2ltem51f1W22PfJgSknH0q216KQqnIh2jU97uquqQtfE1uSYtsTGDkwbZFXu+h+GQRVeX/479E5j52zWw8MIzDte/rtR9eqWcx9ipUhI5vCgumxbqzzJufrTls3ueV2PLres137jV1rRnUkHcsNh7T9X3T6+R5nunSudYTjD5i5AvF5C8VkKMGOeoaAPOImew1fzL+qk72KiXAAVsLLZ7geFduwclCKYhyTjkwOtZ51La6kl7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wR87dIDhi4kjZ5//Fd6BW6JjdVFRyo5dwvrvPb8FEA=;
 b=rw8e5SeLfYOHiTqQy4Xo4tgTRdAPVETFfisxXmE5xiJggzKLVwQJEv3PsSWKZlxmaqYB1UD4LYSWrsiDHJAYCurO8M8fqsnnqCTHxc35g6n4HTW37aURLfG7aOZFR14iZyhrA+ewdQDwTNaTp/CVCNOOSqY+rkcjNohXqHchZoQXynAAb2rUhP/BniryXwSorYiTvTDAIoXyyQiAdHR3oTARlI96Ai6Ni5RxZAI18DisU7/PYEGFi7QBBa0UHknYiKPjwKUcBKgd4A5UITQF5zBHPFvSmMD6KBO7hRv1a5oeN3w00DOciD22h8AU3hO2jUWzvIRoKRGVLLO2SXPTBg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 09:06:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 09:06:38 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 3/3] qtest: migration: Add negative validation test for 'uri'
 and 'channels' both set
Date: Fri, 16 Feb 2024 09:06:24 +0000
Message-Id: <20240216090624.75445-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240216090624.75445-1-het.gala@nutanix.com>
References: <20240216090624.75445-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:510:23c::10) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO1PR02MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: e36cf57a-0ec4-4d75-475d-08dc2ece9530
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/z8TX7FE67gLiFTeY3mIt3UE74rBc9XdT0mqKdH7ZWcDtC2JoJgUsYBVhvoBt4J44HPwU7HZB4PHmha6bPr2ilNgvI/aMzQGBppuZCY11U4HHuMbK+sbhUvFNx6ps2BVBI3Qsrlm+QcpAs1SRQQL+v1uKykGQVV9x9A1RKJX5LbgrsMVDGf8rqfmOjJQB2Zhxfv3F0l+Jxzh4AMqMeVlgtLk7a1J+ymNQmAIVEC3Iav/zOxO8PLYeA+WO+960ZJj7gv7KO3ABYqnmkDsk28BIANmXfO5afkjc5mamaM05yaiXtU+snoBpf20DKdKNH4C07Co8Xfv7L0gdts/MFVRi59ERPT9csxC9aysolbtOfpmKatG8Jl5cpsuG9Bm8WKiEGmHbN1RZnTQaVZaQ+RiRafU0n9ydxl3SHXPuLgTGJyxAcBsA4x5W2MVoGK97T7WSc/o7r+km6j0WZK6kdqlzqJyU3bhT1k/d6EK3hVMXAvHL31SXAt0fFdIe1kQ3hIJ33KKjvgzVnPc1eG+d+TJtWLQt9ZeJ2QZfOUYMHMfRlvAd1WwJv514pXLAwXXmU3tvO1iuU08iw0cCfnr7pjr3XUK3JUkz9aDZ/2z133ode5fiZ6nJonj7+DX+arkqYX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(44832011)(66476007)(2906002)(8676002)(5660300002)(4326008)(8936002)(6916009)(66556008)(6666004)(26005)(83380400001)(38100700002)(107886003)(1076003)(36756003)(41300700001)(38350700005)(66899024)(86362001)(316002)(2616005)(52116002)(6486002)(6512007)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRcwstRWLtouyfVf16Rm+Uuh8AR1vF5FZZ+I+Pot0vNqIrJvmW4uBo2/P0mW?=
 =?us-ascii?Q?+b4OtZ+7JqypIQVevwJMxTsvcFKyJI92rM1XQSXfaEP8w3y59lY0BIn7RJbi?=
 =?us-ascii?Q?sQLKTbyp0znNqJ3YjnYwGZ+n1l5nZx1fPJ0McJXwup6FFfOx0WqdZsLlk966?=
 =?us-ascii?Q?J1d0HZ+raqzstLLTPvZ44sa+Ca5cKjxg/mSAz2Or0kZKn5r8yrvZCO2MH373?=
 =?us-ascii?Q?nngvc/+0TnUAOtBAW+PiV+/pmsGaD24JAMD73M74MyhoIcRWYooTZtTuXMp6?=
 =?us-ascii?Q?dObkWlPi06nHbr6e8OUQjbnt7d5+hixY4UrM8lMY7dIMYu4z5mtnHLsbhIcV?=
 =?us-ascii?Q?W5N5JlW59JLcnDQBY641rGqGnZjCwZvG40YgXYsOg7duekJ+U3KXHPIDGY/o?=
 =?us-ascii?Q?/S+uZWRuSJzL1W8W1V4flAXFO4m5XupJIcyCsovdbV+W0yFXU2IvNsIn7/Dc?=
 =?us-ascii?Q?USq9z/iaEtq+arZl11GZ28ttgRi/NkaGdVbfO3Lu4vEuho6rob5F+FYZD9zy?=
 =?us-ascii?Q?UF4qj201JTYH7hEhISo4N9q7YxhqS5r4d36xAqjW8JvnkpLe9F1LWepnLpjy?=
 =?us-ascii?Q?kd3kr1b8rKN+IQzdo3B0Gr2WvI+Ljd3PkmO74xyaSIgIHZRjRRpSSahN651o?=
 =?us-ascii?Q?KqxmFa7CTzBDjx7tIFwq4tAkekEOXUCZrTcDSv24fx/xxEhOpywL2ajFoxpH?=
 =?us-ascii?Q?WJorFFjqqurE3IVm0fxv2rx8xE8oBRyb/jOPCvHMdOxysQVntW5j+NdR/5WY?=
 =?us-ascii?Q?ylch4u9PwhNfwDNMg4PJpYtk02ZPDXBTuMVPXpLCL3+ZgJxoFlHRpv4Qc52B?=
 =?us-ascii?Q?1uDHOaealmElbmEh5C0/KbT0OPDlaY0tnhPFptC2Qe0NSAf1PmaKE+kEB+bb?=
 =?us-ascii?Q?WYU40tftm5Q4GmV1aM/Mc+9mOcG2xHAj+oJrwS4pxCOUOdwP21uXTTcvN1Do?=
 =?us-ascii?Q?32S+IcdkG2SYwdhU4ku/wtkisG1DM4vB4vTY4fub/gzJIzn4wczUHEzn0+Wz?=
 =?us-ascii?Q?XQwvmir+KUyDzYMtWvR4GvuxNEavKYVGkjMqdifO1bH4NF6A2JqaUtkHfZvJ?=
 =?us-ascii?Q?zW4aBp3vyVgjGpRUH6m/1+d0X+TiFElCINoRV4H9QpN5hNdni72rlZDl3ozG?=
 =?us-ascii?Q?B0kakE8/WZJ3GUMsfaUM8hOpev1lp4RHnd94iaB8OW+tcx7y2SVW1pc4Edus?=
 =?us-ascii?Q?MSzhDo3BdFVtwm+y0OiJFlij8xLBeRMczkkFE6KrDeIpOo3QFLIDm5iqdxs9?=
 =?us-ascii?Q?JGiCAzTT4Gz/tu3O6QvnofRb3edz3QiLKCGm4fr/jAH2Obo7iBuSXyO5gNkR?=
 =?us-ascii?Q?DU9OeC1Cv/n/uSjccw1lYqm/8m4yLppgnqmi8+6OJIbSxzLI45njks1VLgLW?=
 =?us-ascii?Q?uuFm84i1nCYbo5x/C8vatJwifi+Oi10v+BU3qyWPxG2e2kov4vT/6d3vDZqs?=
 =?us-ascii?Q?DM5PimcqNogQ8FP38xaNSHQgSJIKEI/WH3WdLeJpN/R9azBhTH+x2CUx3u5g?=
 =?us-ascii?Q?ErY+tLBqwg865CL/334EpKPf7BO7sPH8AyCJKAgv9E+6f148SRSC6nAm3VIo?=
 =?us-ascii?Q?4QrbwlRV8qT1TgkQUStYA9CkaV1k30BmZygvyzblR2JBUFOMDhrDS3zaNG3U?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36cf57a-0ec4-4d75-475d-08dc2ece9530
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:06:38.1969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ui8d3FAQI0DOkxwGxv9aPFf8EFWDUm0pt+aJbwQMOG5fiFcdqpJ72XM7H3b9BmIxxFrD5dh2MjbDdIgad9Mfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Proofpoint-ORIG-GUID: zKtWPXX6-wwfjN0dgtcLuiLCRdwV5F_K
X-Proofpoint-GUID: zKtWPXX6-wwfjN0dgtcLuiLCRdwV5F_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_07,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ideally QAPI 'migrate' and 'migrate-incoming' does not allow 'uri' and
'channels' both arguments to be present in the arguments list as they
are mutually exhaustive.

Add a negative test case to validate the same. Even before the migration
connection is established, qmp command will error out with
MIG_TEST_QMP_ERROR.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0bc69b1943..9b9395307f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -26,6 +26,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "crypto/tlscredspsk.h"
 #include "qapi/qmp/qlist.h"
+#include "qemu/cutils.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
@@ -2516,6 +2517,86 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static MigrationChannelList *uri_to_channels(const char *uri)
+{
+    MigrationChannelList *channels = g_new0(MigrationChannelList, 1);
+    MigrationChannel *val = g_new0(MigrationChannel, 1);
+    MigrationAddress *addr = g_new0(MigrationAddress, 1);
+    char **saddr;
+
+    addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+
+    saddr = g_strsplit((char *)uri, ":", 3);
+    if (!saddr[0] || saddr[0] != g_strdup("tcp")) {
+        fprintf(stderr, "%s: Invalid URI: %s\n", __func__, uri);
+    }
+    addr->u.socket.type = SOCKET_ADDRESS_TYPE_INET;
+    addr->u.socket.u.inet.host = g_strdup(saddr[1]);
+    addr->u.socket.u.inet.port = g_strdup(saddr[2]);
+    g_strfreev(saddr);
+
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    channels->value = val;
+
+    return channels;
+}
+
+static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, 
+                args->connect_uri ? args->connect_uri : NULL,
+                args->connect_channels ? args->connect_channels : NULL, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from,
+                args->connect_uri ? args->connect_uri : NULL,
+                args->connect_channels ? args->connect_channels : NULL, "{}");
+
+    if (should_fail) {
+        qtest_set_expected_status(to, EXIT_FAILURE);
+        wait_for_migration_fail(from, false);
+    } else {
+        wait_for_migration_complete(from);
+    }
+
+finish:
+    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
+static void
+test_validate_uri_channels_both_set(void)
+{
+    g_autofree char *uri = g_strdup("tcp:127.0.0.1:0");
+
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .connect_uri = uri,
+        .connect_channels = uri_to_channels(uri),
+        .listen_uri = "defer",
+        .result = MIG_TEST_QMP_ERROR,
+    };
+
+    do_test_validate_uri_channel(&args, true);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3544,6 +3625,8 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3


