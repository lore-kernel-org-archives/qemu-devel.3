Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E8AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKD-00040H-98; Fri, 08 Mar 2024 16:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK5-0003zj-Mx
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:09 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK2-0001C6-BF
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:08 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4289MM8e024123; Fri, 8 Mar 2024 13:00:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6Mkc
 AY=; b=fSpgKQlL/6FvZmmstmCQIMDbuXiHcrFofzxrNJOTZYsUdYhSqvyNSP77w
 kodlPHEgzB1NjR0YmQyrrjPGQM9CpoUQi/9hg5km/279Kzq1OTAnzqlLXExeUjA8
 nnVZCr4+TiGlbB4cDWTkUGqOBKwbxg9Y9II8kaJd/6rNA5AayktN/mDAT4+Zrt2+
 axi8JerX5a2Xz1I9j6Pxufj01eZFpBzCLjx5vym1dnELBpbi4GK3rCdM8fGYk7bu
 qdoEHeDDsu/4xubmuRonD/acoshREkYEf4s4Vthev76OBgLx1siCGx7b0hbv+oP1
 LQUL3ymwiqwJ9SahQrTmuig/Hhm5g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012018.outbound.protection.outlook.com [40.93.11.18])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm33q6vv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8gRrDzyyYJhkUoYP6AoMaJy94T3IwyDRsGAWoOR+A9WUUwQqczb3pXo2x2F2/ZdAPhmpwFPemNU8hsUTayc1IbOOtjxPNpl6LS+/ZFnN7/2zxIQoILHMCNokwsnIJxi5ELKRql+T3SC1NAkeOPfrAN4ye63dzLyjD5XopObyLwUky3T9p70gTcxXJAokIKdo5foH20kb8JvXrv+y6gwuYnnaHlHFw88unPt190mUpibG5sGZqe8LrANB7TT6VhwPbdqdYywleyyfEfhDXVHhpYqIvlXF+2lcODt403bs38GdvMb00KKe/KNyvWfKn1tT0YCKtDQWr9cBNjdLPFDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=H3SJJuQT9HJpy7OywJOFo9FVOpXcd2rLRsG1SooTPnDIWnkg4p/uXSAEBP0SHCemwyd+Z+Gxf+j5UlJEZHbLKuT9hTYy8Ikbhg59XRlkqmFu8RYek7pVZBQ9/h6ser5p93mqGr+h1YIeB4e+xaDOPNgfIh9ZE1qo8TIvc4LQ6pCnquUi0SBpfY8CAOhhmGciMyyHwSTx7dO5PkYPPcwYwBDX5a5aJ814nOBs1c1HGwCka33y/L0zGEJ+ko56HDPfreVvr9yOyeg+k3vZf70S0eS5tLeJuFWi30EKtTkPS3ce3FFUVaT5JE8gdWeacVBQzOpvKN4WaDPH7x09fQrPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=kgE/XeV5Dli6f/4k2Y69cirrnhsFZ18P0TaMGhXQYX4eSWqfiG8vIbq2B73Fjw1BrqIDteBp6CP9b9i635rvSDLCwMIbVpAjXQ2j2ii77DZ4EBM0Soy4/L0DJKstsdyxL0EOCQcyRKoklU+5zHuJU7ykeVF29qZrhS5B83NAysaOK1K9rEhiAKSkXbXfablugeLvuCIyC2xUwpK/q+IeAw3C7Up2NyEPze8sS3Se7ETf6c9Q+XAcL2DKJ0aKMe7420lehWduS6nS0DxOixTAhqMQyxPUDVwWEBN+faL8W17Zes6BTl+EIxBispwGnJEVILFH/sJfLXTzCY8AejNXWg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6702.namprd02.prod.outlook.com (2603:10b6:208:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:00 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:00 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 1/8] Add 'to' object into migrate_qmp()
Date: Fri,  8 Mar 2024 20:59:44 +0000
Message-Id: <20240308205951.111747-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: a51eff5d-767c-4224-1a64-08dc3fb2b7d2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TCATpkS3kk4DZ+KRxkxPSvoGSBGcLvopzykAO4P7VL9b/gnoM4+06JW7qGg43sE9RduMY7udnjHB/6SGh8Z6oBz9xTApUsNNHnDxSHCnvq2ugnKis/WmNrvUn00cjufo07DcIOZtof7/JsivfyKntDu3kfyU9pQJftGZaGFenYIvtAmvH+Ng5Pn+cOS/9J+5XdDXp8NM9jCvz9No57oK+3Ub9rTd+yyfuTMfH/X4Ky4jk1DLoRb+7pLRFsJFBMHpITBWe8ao7MsWp1YWcHsXK5bzTdM6sqjPtJ2wjcFt0NAdOdEoyTkH1Z1jHTPWGzQ25CoZYRGoNbT3/6h4FkefNFtEANgSzOr+uk8l0LnsUp3nhVhRsQsw6yyTYa/BhAFtBk18o4Htf9j57Nlsv3ubiNfpHhtR9FYz6vZeBAA+IwCs4VYpZtsZTUW36sctWC2wVR/zKUFmZEKHacMKiLgWj5j0aio+OulnX8HhzrOJC6r2XhsOzNlvR19Xy8y0DKAHmOmzLYfoALpwYugDBzeFsbJScd1kBGZxaXy5wOCkTOmcajTx1ytWC3/EW+tEXbndx2f8xclUIFPzRd2kX7Y0yeyw90b4y4Qr593uGxfIl8BIAhwN9ngXZ+rvswuITGC8UXawdDij7AUczJMg3RaQYOvoDX2eVPS2ERyuNfbo3uce8IHzBlhlZjJnzwlLvFRsa6HUIGiVENN5jSfIMUpS+ozOGrWpJ0obLqIf7d/quA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIvHD4Wyqscvm/rQYSvErnn2BxOgyCSXSuv50J0F9GiXmPT0ElwPAS3188y6?=
 =?us-ascii?Q?HIqjth4Zdff6Rj/lVQY6YvrgydC/XjNUJ+6B6rbjMkvwKsvEVG3h142U/Ikg?=
 =?us-ascii?Q?UadiFTLMwIjMuDoiHygiYVo7k/yJfk70dCLtu1JULYeltU1cbMgswh8dBcq4?=
 =?us-ascii?Q?APFqTSz1cVZ7zoI7tT7+dRQPSx6vkvMRJpsoVd1NKmCghI9tVqZq7UxnkL7r?=
 =?us-ascii?Q?D6opFlBmRxBpn8JxDhd6Ea/SeeU/ExTkR1dW2mBU+2getjs3V1VHJXG7KZTj?=
 =?us-ascii?Q?6LWxyDzqguEyQ6akCWIFJbYgJSFL3utROcbSEHO7N+yxqp9VBGg4LdiGrKSV?=
 =?us-ascii?Q?aEV0Kob+E8CthEyXsgNrfubuHuxqqAKK/2FCcwt85jSG4Bnfit9OKeXSYWOu?=
 =?us-ascii?Q?cfl2lkvkGTgF3G7Es7+78AbLSCE/UtVxA6b+OI/PLtBaCagJu+sz+w2370aj?=
 =?us-ascii?Q?TyuoxaKAvNg4mZGguUk7MzvqNccj8ECo7R+oRZKbOipbBUkVgFrMBRtWQF5h?=
 =?us-ascii?Q?Fo66jGnR0KsdrH9HeIDIP+odLrY6KcKThpB30j2rX183L0OeVsgaQUneHxc2?=
 =?us-ascii?Q?6g8ImATqjpyFYwxIbIbXrl3zC8yU3wnKWN7BTPoMDA3ByYzKPh62k9xZdPU7?=
 =?us-ascii?Q?NOBJ/SGSK1vr41e2Z/ALMiUY/iQTUaNQ9sPGK+Q6IskCN9tT4g2C1c83CvTD?=
 =?us-ascii?Q?3xnAhEYhQ7FYcAUPV+S8xWsDmxcUis+9xWJ4Ew3BlI6P0fPzSJhdIoQkY5OR?=
 =?us-ascii?Q?j+vHkJPMLKxCj6kI1ofMKWvtUsVL+hVYTanqdUu3QqWyt2jnHjJLBao44W50?=
 =?us-ascii?Q?WRKgdqEgYq+gVhB7IKQLFF+bNzRvaJ9FC9n+qGD4bel+vls3kXmSuAQHHQna?=
 =?us-ascii?Q?0ei89LQvDk9IYDGzwsIukQ4COvzRHRgQFJVAriQ/fJkhDbOu+pIkNojFTKpQ?=
 =?us-ascii?Q?RzhoOPIkP/lyIduqLhJwAQf032sS2gm/XRzAr1eIm/ZtcQ8oM8CSxWcf66TW?=
 =?us-ascii?Q?9G5Fa1WWtDule8+6D6H0ky5d9/RQf11tbbY54v9l7Q5RQ4zlgaYj8GyxGp6i?=
 =?us-ascii?Q?VTG6Frp9eNdOA+UnwgdV1HOoZEas4OhV/H8ZGsbJSNNM2LtY4uvYhogAHjKX?=
 =?us-ascii?Q?bbX3+G59PMWRb/S7gR7OlrMuR9mu3sqOPm/lN+Esa+DeYqrbRqaVf5V9keUa?=
 =?us-ascii?Q?fhcMvGrwbZdtgu8Xr6RmEvEOXpyv2zrUHKQ4z+Cs5i0fQrkjOUnP56r4Cjox?=
 =?us-ascii?Q?nhdfQpziY/kU2zn5NaNNKq3w7TXg0zd7/RusjUsq1IGBztzhEKLU5Q4oRDOi?=
 =?us-ascii?Q?MXHobbbP6puwJmuigEUurq8ruwwqpQo2JOBiCFzGUVoXGiRpHIdIrVH97t+E?=
 =?us-ascii?Q?xe0e1pfrKXRNc87hbtVSOVLCWGVPNNIpTFQntduRoq7ha9A5LR6za1si6OOD?=
 =?us-ascii?Q?OeXK9CoWztO0X3kdvk2axevMdzmfg4YV98axP0204fvlZnk50ull9kz7L3Yf?=
 =?us-ascii?Q?ZwEBjxUpHgGSrozZ1/fIo+ACgy9/01S0TV8Omt82Itz71B8P4M02JVWDKRGX?=
 =?us-ascii?Q?AY8+F+k3Uyg8IWG7MCL04w5tpbUuGl19ZSvKhUzW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51eff5d-767c-4224-1a64-08dc3fb2b7d2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:00.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvNU3asPhec7O5IWaNfUsUIZ/gcO4vofKwSlfVWZXDPxAZf25te88Y0dOvoXwbEEEuP0W3TG2LCTYMzDkv+CAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6702
X-Proofpoint-GUID: oga0sPNkbA2x10cvlYwn7_XuNVqlhuxb
X-Proofpoint-ORIG-GUID: oga0sPNkbA2x10cvlYwn7_XuNVqlhuxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

Add the 'to' object into migrate_qmp(), so we can use
migrate_get_socket_address() inside migrate_qmp() to get
the port value. This is not applied to other migrate_qmp*
because they don't need the port.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  3 ++-
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..b6206a04fb 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -68,7 +68,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..e16a34c796 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,8 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4023d808f9..d9b4e28c12 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1350,7 +1350,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1500,7 +1500,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1588,7 +1588,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1669,7 +1669,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1708,7 +1708,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1777,7 +1777,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1873,7 +1873,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -2029,7 +2029,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2605,7 +2605,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2708,7 +2708,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -3029,7 +3029,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3061,7 +3061,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to2, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3394,7 +3394,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3435,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


