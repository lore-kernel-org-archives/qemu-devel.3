Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88566C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKT-00045R-Ks; Fri, 08 Mar 2024 16:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKS-00044p-2v
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKQ-0001P7-9R
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:31 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4287HBih005265; Fri, 8 Mar 2024 13:00:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=2QdUqQMAWOAfW9VAyIeEpknQUCxkpFdzRGAo/NsRd
 PQ=; b=pw/ddSMu0x4kNr4WzRT9TDHzZDHW0vOWgkfmSEBKrRrPWPBSeP1QFNttF
 1FXIDJEXt1D1ZoeVAPCYCDVsZ3DgQ74u0JtKJqki0ucmJpEw/XpI6wpcpWQW1JmT
 4ZGTbxQ2eiWhyEU6CPMLaAJsN8+umhzS3p48PPoh1f7z0Sj9kqW7o+f2G7Fv3Eps
 6omB3fNbAad6k40snzp8gK4Oey4C1wmHxUx8QmTL29N6zj8J+Y8wWZbP99FNlFfv
 73k0HH0kp7ES+ekyokQPAHbJN8A/559TGhBcVRKCoafco1fRrKpdzxrMIdcVudqG
 SzECiZhvyFzqfc1a1Y2GNj7JOFdvA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012018.outbound.protection.outlook.com [40.93.11.18])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm0w9e9xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRDlGX6Mtm9HdnLk+rPYKqxv2JFXFoxcf2Y46SsGhDWUTYe18SqQfOK+5c3e1hpO56w/QbCnHy4LzMKsXy3mPjkhFwjLTLIB8QEFSuirw33HPVfCyWD/VLIM7cRJU89oslztobxj3gZCZ+PPBA1t84siv5ZtJJxYaVk0zwC/oHJN682K5N279MMOFIj8GsSzAiIzD8xR5hQXFWhIv1pOlFrTyUrsThe3/IHznH9yXzzT8l2yoaJuyL/o07HiKmV/lVnDY3JzV6XDpdlU96UOLMUzgmMPKoKBh+xa5n6NKrcCvYw8q/ghkYZIMMEYqXiiiGPL3M3QvhzZjBP7D9KBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QdUqQMAWOAfW9VAyIeEpknQUCxkpFdzRGAo/NsRdPQ=;
 b=eZhaa5PixGYSSflpxCCxsYYg++Pq7HVGJYdaxZRh+Fo/LOEX6V0ZuJgvx8jggkcnKsm05M1+fCoJgE3twZL2VQ0ThTlyLsM5E8+FuKZF0+DG57FWphUfzXzsfNTRevp/D0TX7s62c+f8vNw7X5xzUOA9lzxdRWbQMc72YKZpvUKDu29RHjdcSVe68fWpTqDU66+uJVhCHl7gW0E8cdLR8s60z317HDmXGiUp/XOjyJcyTeIpMYDF4l7InUW5rzIVRt9lwePFeRM3QAN4WMLRI/OkZPxjecNdCWD0ZMe3QH7dUfR44wdJ9qZLI+SPp2McNU0/iSMqMp+c/BbPTUz/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QdUqQMAWOAfW9VAyIeEpknQUCxkpFdzRGAo/NsRdPQ=;
 b=pG80fIyiJihMiAFZA8taMh3wdoGR4MlSqP5Dh9SIVvJ64GBU7vwMCZZysvaufDj5EP/A8ds5XECabkB0N5G+Y4zijT6RIStOgGW6FDHXUwILJiCt+ZbibYQS29oqGiIWOYI9zqoqavl8U5ohiC2QFc7ythbDvg2gsI0Kou1Skxf2ZCX6vk1jlK3xT0kQuJqoiW2WQmYnYl6+0JfXOSJcHRxVd1/91PQ75tbH3NchgjuA/wqbl6G/96iCgUS82VXvEn6mA1w4nazikusE/C4Rvu0a0RzN/0fksVANkGiSqaa7bF1DX0INpIqPTGX/kxW7uehra0JwkbDROxdEXeDMWQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:24 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 8/8] Add negative tests to validate migration QAPIs
Date: Fri,  8 Mar 2024 20:59:51 +0000
Message-Id: <20240308205951.111747-9-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc0e5a9-9034-4b8c-9c04-08dc3fb2c61f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttGLJR/MfxGFoJLl+BOsxMAKLc6+LTBxQlyga0JAd+P2G0c7i4Mmm5um+pvyqLuTbQD3yrTvQrpHsVbzqPR7vnXRm8FeSAoD2VuNolmto3YXE0flsr1KfU9Eek0zR4nUhmbumWgJa9YtKeWF8MskGQu80hTjn27daeHKx68+74pwGYVUDVWskOt74JCg0wl657XLV/D270ulxwWdzwbIBcwJ9al6iqu8VjwkmuicsobToEEbxT+kNm+z3EjoI+Fj4QGPm7fzTdb5D72pUnAPQvPBekthGI4oDS9V2P0jPsG0WWnm1LV1Y4weQuZiM+PZukahppOWhTTJK7spMk8CjqblrHTf3SmhMg05cVhdv/m1i9TpYQ6Ab8XaCUReqwbQuYP4Kv8tYeaI7AJucirDtfC98lyY/a79KYuYfdEmOTTuMNdeq8PsTjXKsKqKHCEX3PRqaHjDKFzf7oZFnlMP3xVpyZVJYE48wcOwrNBlS0MJFkc5dhYdKfpp41nHedAoyJoVeRMUXWEuHFu8bFdaQPPfXLs4Xr+NbUvVUg4ExP9oCroDxFyz5GB77uEpCTrj7AICRcKrGgR8M/EXaN5fyhvXbmC6nHel33PNfertUozN9Li5uMylgEhxJM9oia6VSHo9Gn8EYpxZdheLgyRFHQvDKaEjnRlTXAj8IZVUbnnigbIV7bIbiQgKP0bWpHct0NX729j5ZN00csF2p73HQDXu6hzyxVGDIxZJ2+4jPjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uq7/Q90Xjszk71znRXJbOobdInlnPJ1nF58RkpuEjda3RNXN8Q6MfpzjD0sd?=
 =?us-ascii?Q?k+OdvgjK3/Zl9mfTWYVNc5TnARiTaTeudBM/rZ+7IS+hWR7/CZgEjNPHKn33?=
 =?us-ascii?Q?CygnQ5xVfGEzLAWXEsQ1zbTLrIo1M5Vsr/w2COjp77ph1ElUebIpbAJyib1m?=
 =?us-ascii?Q?Sw75GlX+pY0V9pqV1EqaIAeHv6Fhg7wX6jos+8+YLuvBo5Mr6ODgTdGH+flz?=
 =?us-ascii?Q?0SZi9Gg4oALoIMcFi64cgWJttlPgwWu6MWUF9PjApG/ezHhmDqfS2+mp141Y?=
 =?us-ascii?Q?FfinLt4a0UKFC8aP0wXtAVhwj9nfH/C9joCM4G3xy+S90/NxxBi3hYg9gYru?=
 =?us-ascii?Q?9bg/tw35csnTJ/djH+QwYFtjq7gb1yxEJL42fMdyO/g0hLO//LZ3n7JuuBRd?=
 =?us-ascii?Q?zYk9zs+t/KWSGF8behVbD280P34D2mbXE39gzufEAuAgOPA8MG2Y4I4isaLa?=
 =?us-ascii?Q?zWbmONrrSwXJxw02s7iLZkMmCqEy25W9NneRWB94U9v8kh6YQCs5lfhZwZrb?=
 =?us-ascii?Q?YPWIQ28rJzIpGefMNjOHE82knqsyvr2406vM5X3A1db4CCFiudEDwztv5jNk?=
 =?us-ascii?Q?P1pXeuDSbbcrpStStx8hvsKHq8pxQb4se8BRS6Sn1DyqjFOQJRhRHWDSzSHa?=
 =?us-ascii?Q?Mdx5iMD381gZEIzSN+7rjLVwxFImO4RhAogl1Xy7J0j0JGduq+ZAvuMZZ2Si?=
 =?us-ascii?Q?ZCjeOQCxdLLpiBC9OOsmcmzdUntmlAfEJeZqx2bBlmhuvrmRpqoaHb6RZyAZ?=
 =?us-ascii?Q?RZE+fHrSCRxifZ8/DXZU+nK1hmYa+wJ+SBMa+pqn+cTh1gvsQrYe3ptKb8wu?=
 =?us-ascii?Q?Aps5K5+Mf8mIjRvpgyf+0D/eNc10RWhiqkwY3Yo6RAV0hvvzK/Cjx+QejzU3?=
 =?us-ascii?Q?vxnETtdXo3uWHjMEIHApVMuu7uuTWCu0wtqaKNdjcoZcHYwqL/4EVsbhwa69?=
 =?us-ascii?Q?mzjWOEytdkkflYcoDp6foZBIOn8mn3ql3dfHe4YXcVEHJofO6C8cvHy8KNXC?=
 =?us-ascii?Q?7LOeXWXs+X+KI/hwCGxjnUICA0EyAYfgNTftfk81bz6DLTcSsV/YmKmHYcfd?=
 =?us-ascii?Q?yKMY/MqzRddrBY4UjBeFKDp806eW+YYn/c5OCkMa1zbZK3TlZd79dfiXlxRZ?=
 =?us-ascii?Q?W9/Ztkh0PE4rdcfdHUe/+2pSCk84+WBqHeLXme24sI+9zap8xWVCktTj0Gl/?=
 =?us-ascii?Q?wwxIMP+mQbTsAX/WXzK+0BEOnxgV+McvLB9p6YQomxuwTSVZZHVPbHW3iYxe?=
 =?us-ascii?Q?yWMkJD+bFMGbkcIzR7HLMYoqz/wGtNWpszJwMasTTIlAclojn+Nc9tTrJnC0?=
 =?us-ascii?Q?ageWLgh4r+FLRQrvLr9NFbAXtecduCx5khOMxeFLwwy8MDa0NZy0BGIdR7F9?=
 =?us-ascii?Q?t49it39NkfjOVokwdb77zvSb8vxWZbLqF+sVgztufQrtnSBTSHy44l2Kaou3?=
 =?us-ascii?Q?5g/hFfe+ByEo+wcQHr2LA0fewtjhP+JwJDXP2TQm+t3gj87oOua0po2QvxN1?=
 =?us-ascii?Q?53UqPHMsqDIDTIgvhPVOJfaqUuYSOct2gy4u6zPUkW0TnafxzB45gDNw6+I6?=
 =?us-ascii?Q?vUHPquH86cEJPHVYcs49pw49FsJKAHu8iYZwT4J/S2oDEoQLePJXvzVVQ0Ox?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc0e5a9-9034-4b8c-9c04-08dc3fb2c61f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:24.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M0hWOp3IRjYb3zK2jrwdCsoEQhE3v2IEgolVSwMslAfLNmwpHmQbhCQmtiaNrmMUxMir8bfpv7oKZRCRbgBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-GUID: N4m04fChId8DVjTgC-qv5VseF_giNG16
X-Proofpoint-ORIG-GUID: N4m04fChId8DVjTgC-qv5VseF_giNG16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Migration QAPI arguments - uri and channels are mutually exhaustive.
Add negative validation tests, one with both arguments present and
one with none present.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6ba3cfd1e4..385f696a3d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2612,6 +2612,56 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    g_autofree char *connect_uri = NULL;
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
+    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    test_migrate_end(from, to, false);
+}
+
+static void test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .connect_uri = "tcp:127.0.0.1:0",
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3678,6 +3728,10 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
+    migration_test_add("/migration/validate_uri/channels/none_set",
+                       test_validate_uri_channels_none_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3


