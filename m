Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E3C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhor3-0006MX-Ho; Wed, 06 Mar 2024 05:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhor2-0006Fb-1D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:32 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqw-0000Ec-KP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:31 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4269sGS0024911; Wed, 6 Mar 2024 02:50:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=yoMfkDu+yUA0eslx10FViYndLCEpyXAFXAyMzf/zO
 3s=; b=zYElUYQBbHZg/uigjnkco2/ufFLTWLSoSPZnfVf5U/MX0y86sw4Km+TJt
 GOkkclXxcEyPH55ae3M3VAysHq4Of5JX5io94wc2W3il7Cum3GcuCMP6J93rxrOv
 vKcwRaTDLHKdgCa5nXOBEc+McKzeOvbi4r6dVEJ3jVJ6A//FSJmuZjcHOdVNH/Ov
 mWCciC63qb0Dxyf/ubqsKS6aBesu0Gvfw2i2eYaWb79QSIJIdf5S96RoKxteie8a
 7ipsZ/LohavqBDm9jHUDOxMwwg+pHCO5jg6RBUf7RZ8SqUSGw0Ju1uQwP6f7GhPK
 OuGNL99a2GQU712o/7IGYFdQbcxVg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4h28hsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOuaXKX4OTHm+ZVtGwxeYPL8XsZ0qvMPKsbrmhFu8rInVpgSDXXQvEqGh82/XcCRs2gl0QqD8LaBXdH0NUICc+52qHfRMwZB8393E2piIIEOZVAdsqGt8rxKkDiXx1oRku4oT6rgjxgPwfInE/rATTftudMpmNHiTHCG73Z86sX13PHnlLiK3IsERmSkyzkoqZqe/RO5BLsNoPKWBMV9HJkpKNRvELNOE0SKXjdWOmdK3c7FJZKJjMKH7nr+qWgrcE2mt4nAksNqtx2gHk8C/pu1ZcMCzB8qM9Po1MoXqWbXUgo4GnaZzBgDSC49Q6cXvAqs0YSpznLokH2tWpd/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoMfkDu+yUA0eslx10FViYndLCEpyXAFXAyMzf/zO3s=;
 b=KWY7Zuo5sU6vS4EkW21U172HKqiRDmOo/6N1sVoHoRf9SbCPBnchXG4o39f49NrWb83JnGdVzfCRpM9NqoKxkKiY+E7h4tbC33rUkpLsotYukp/7V+NMLoKPOIJwQgQG2ztB+62uOHlv9F7i2HnGAWbXUkN8DduwpuhEL4zznIpoqbwvz7zjLF838Rtaqhp2c4/jW5ZX8K/2URisY4GTiccQMe1dQClZCJ5uuuuPUJKzCDnCdRAefINOfMh6imUcTJuhdIQ3nnEGMpNwXo/Cxx0BIXaQ8jdJ/nZWmsMJlvAAV/veDqhrgflRWYjp8TIrZufVQGCmc+88jmtxh712nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoMfkDu+yUA0eslx10FViYndLCEpyXAFXAyMzf/zO3s=;
 b=vbCNxJURjSKdmAi/5dgUFLjxQBj7ejH7k4Bk8FfnXaIOHp2JSknD8wNtRNULaiJUlc6pOZGtcYPZkulG3SVWJ5u+cATqKRUoPpAeGe1YOJvnr1iUPhwtnUVlRTxmQOgpUdqy3fxuwzTc/Qd/i7z/g8kzPJz3zW2CSU78owSbfHFqDVxTd+4AWP+dU7HawqB7G+Nl1B8MPVcEdqGijfwH72jBvBnSepAeg+BqnvOg+R9c0WYIcS77Fve+IFvv1K82Qz/2Lai+6yr9ALUQHOneirTG6QGDOWAFBz5gAqipWq6fAe9zhnBZBfXU5nRkSwkzr2HdFYgzxe2Dc71fEj9LHQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9594.namprd02.prod.outlook.com (2603:10b6:930:79::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 10:50:21 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:21 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 3/7] Add channels parameter in migrate_qmp_fail
Date: Wed,  6 Mar 2024 10:49:54 +0000
Message-Id: <20240306104958.39857-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: cbce42fc-1c79-4e2e-6d87-08dc3dcb387f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TR2gTUJfh3Um55q5ROHcbCX+PUI0RUj7xPicdnW3rhXx4uwq5lQid+JR4ZBryTslYqM0NlixPDv3o8yTQw3gnkz+Ct0ojOiXJykKofWBPIUI40MjzIKk82QOGnuSePQ93+kbgL3dzlL84ZVmCAmScT//LkI8q2hOrHmX6iQJ8U5xYGl6FXx7qcwE6GPvVuPUS15Q2d0ZR+RuKKgBJTJmoL1FdTeMSYxm4WA9+p/Tcr4uDN4ICr6aHK2JEKMtA5B4b+oP4xExFOZNvupdjtr3JHgclZARxeIc2wQlhUXIBKIubZe2MLAOtqys8MExUyl9ZjJ64MvG6jg9cLhEUFqh1HAXhlK95Vpd5in01QwH2Q4DjnQABfgGpHgMJ8GOmeK552CMpa3bu7nS3MR5YYfkykK7qL52hAOEeGr0aqqcCufUZO3z/HtTnNBjb7B/wLsHQkjNCIwHPaV98txz6ZlUhWXHJ1yPqdScurckVRANQBupE68qcXTdDXk8eTVGn+5bZAjzPiCvqAPX5luKL0PECE565+1fmFo1oLcr/Av6R14YWVGUONhcAb5E9UahXwzzmdAAnTz0ODXd4X6j+zxCwo3lzRK4TDGgtTtHwRpbooKRcCMfSjksy1vyoKFi0EdnNGiY6q5tOc35N2cvxPNU5miJ8+MlGNCc/C3JkCSK1IkLCMakrQFhlFmhX/PcEdpE8XPhp7E4U2Qo2Kx1Ml0IEbnXYQL2QSvqQ47VcOsOI4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvmOiGqejqaIgJkL3Q/EdyMElWWo/pMFPEGxQwLlANta70jNsPvvvJWgNCWs?=
 =?us-ascii?Q?iAogMz8xBpal4+dfXRJXIPVEuKovL4t8Ta0ZKkvKpPaPcCtOg6z4YsFLunZ2?=
 =?us-ascii?Q?Vd/Ci9RxPwibQsNbOxXAwOC6L6PF2dWpA2ys5hLh9yuJAT/OmFV6RuImbhzc?=
 =?us-ascii?Q?yUTRL7nYwkg39XsoouqsgJyCrzLOOLiiDF9ZL7aWrCspVBVcNNaWboVh/I9h?=
 =?us-ascii?Q?bRA31R1k0NhdWcUPMA70yzpR86kpDWl4OZZx3wo96P27JXnsyDdTlHvEjjdA?=
 =?us-ascii?Q?XB5hgDcLSUT4AzQDMbLicyJxvQIPmTYJnimUkboHSb4ZAkeZ1Lte6HOCZ/Ui?=
 =?us-ascii?Q?7l9uBfdH2U6Nd6CCRIqdph8xby1gMnK13pjyXpH0sH2MLZC7ocHZADirPn0Q?=
 =?us-ascii?Q?SyeLgaMf0i6Kqhg9Rw9eqpJBQHooKw89PgNAq6y3GAaYK89ipocah88hVFBb?=
 =?us-ascii?Q?IAeud8akcEATezzDfzqsXAPURwLAT6XCX9afNZVT05H/aQXb5wcgqgNn9lgT?=
 =?us-ascii?Q?AHfP9qb9ZrvEUJ4Ck4y2avbZw/+8xvsDUcRxWb/sEIw47WRj7Xnm0womWGgu?=
 =?us-ascii?Q?el/7ovDeCayKbAfg4dBB0Q+hbTgJD/Ivqnqk5nEA0osg1uARk0OWTsxwWKtg?=
 =?us-ascii?Q?exsAcUEJuS+1i2u6lJNuq7FHDFRXIBfQCqZlzThzxbcHkL/Perp7ULqKzNeq?=
 =?us-ascii?Q?M9LEvssMJB68elWWxzEEMC6UHNQ/IhtfyJdpNJNG7bINdgZET999eAD5v1Sq?=
 =?us-ascii?Q?3dFIAyd0VAOK19tu0cDVwl7NTNV1DjjzYL5hcQLVOx4EQVhDicrSWowdRVpz?=
 =?us-ascii?Q?77zRi/CgSQVwPIgg3+jKcrT87NW3RradvMnOkxmWLREd5oCYDgwM7SN+2LNG?=
 =?us-ascii?Q?4GtCzTbAgxLGpuYEvPy5q03NerHMrYuuWPeB4FyI5sBF9D/GmKtFlzokbPTv?=
 =?us-ascii?Q?qyLZjI742Urnkn0WF2FFjtfN+Pjg/O0zNxl9TsFjYoEle2sQCT+VhQB0aUSp?=
 =?us-ascii?Q?XfvH5qfC/Y7rpM22B+jp5prRIAAfkjdsjZjP67o5J16ZJnSV6O1odqVaFhG4?=
 =?us-ascii?Q?ZRTuhcp8KLooOi+h/y10Yu9dTzLfsr9IxHt/1WfSdCFcM/b5QTRON/72wOLQ?=
 =?us-ascii?Q?tYFKISpR2EJ338OfntQKnd875pKIpdvpXxzdUik6Jp6L/1YSYL0iJ18lyS8P?=
 =?us-ascii?Q?2PgAIPj+SKvk34Oy9M9sNTUCk1Z061M5e+nEPdKCo1itsk9aOYBOD+q/Zrao?=
 =?us-ascii?Q?vI341MLjil4+zB+S5yl5Zpmbj+1gQV9WtVQYFO4TzTnbmUZWo2ZKBZUrjSaT?=
 =?us-ascii?Q?FfGfD0pzF9Kbmy8Fl1edQTfJH+o6IEUeA/FLQJPO7FJzQNtlTcFc8dK4Qpjm?=
 =?us-ascii?Q?UefCSklvjXZKnNjMua+LzNRbQZba2jNYxz2ilmCnvMnPiXCwI/gNurDKA++V?=
 =?us-ascii?Q?2+EAweqklfJpM0bR9AChHVnyj4Rs620x6siLa98H5zIH1ml2yHQBw131GrWh?=
 =?us-ascii?Q?0VgO61tsC340+ZVilNzLlCLmrgPkipqc8rMXz5F5atXlgPy3kB4NPjW2uNc9?=
 =?us-ascii?Q?O+F+9VueovP2wxVhc3XBCcJHlJs5H+/l+fTMYmuA?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce42fc-1c79-4e2e-6d87-08dc3dcb387f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:21.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+cw4SQMniqeF7X+dzOcOUfc4Ze5IuWrFphvU51azGIR3grqGV07AYuGHneTCLS+Nh/zm3rURgRBwP31TrZz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9594
X-Proofpoint-ORIG-GUID: R1MZwq-s_ScPsNSrlmNFs4uOmq0trC4A
X-Proofpoint-GUID: R1MZwq-s_ScPsNSrlmNFs4uOmq0trC4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 15 +++++++++++++--
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 9af3c7d4d5..478c1f259b 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -92,17 +92,28 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
+    Error *error_abort = NULL;
+    QObject *channels_obj = NULL;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        channels_obj = qobject_from_json(channels, &error_abort);
+        qdict_put_obj(args, "channels", channels_obj);
+    }
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e16a34c796..4e664148a5 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -33,8 +33,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 20b1dd031a..19bb93cb7d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
-- 
2.22.3


