Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA756C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKH-00040m-KX; Fri, 08 Mar 2024 16:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK7-000400-Pn
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK5-0001Mw-QI
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:11 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428KTdwq014608; Fri, 8 Mar 2024 13:00:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=D6pwOOA8PZmMCPSgheOx4+TbsL1bCZHQyVY0ngB6k
 X0=; b=oNYtgX1DWUvRHRZTUmLMe4pNc9ZGQPLOyA+u+usmz7Ywb+QKCblJrsye5
 gbf2jLZbOpqXuaieY97nYiWRr3LKHamxszVaNhPX0eKs1qvJcLmC2QT4Hpd1fRDZ
 stSBdq6pwZUI1kNDR2puw2G+swwlI5AvWck4G+1xSjdb8mLM0mfM95nEP7Q9/bwW
 Nj9corqa3/zzRMcBqY32us3kaQcyFZ96lmcuq58qk9trQaSsJtCHCk8xyxnJbt0N
 0UrfgNtJaNBCj+Y8OvHw6qtlJu0PYNWCI3UtRqqmibGecARUjYVDQJgC98c+UpaM
 qYz4hUWZYp155tb+9iOeLnJwYmRuQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012018.outbound.protection.outlook.com [40.93.11.18])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avx7wh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8w+SywRdO+4Qp/xTCGuCgN5zGMUThkyCydNafRZ9xM1gubtJSZONrcsLGvy0nf5UO1o1blgSbayooCaBwAqF227ilfwvgL9O/x73EKb0NPO3OV2r2IlSVRUGZDoTesl6ftGcE8Ak975NwyJZUgGPb+q9sw1E3xZYlrHaFb7/KTqcMHaymEQDiie/Mcd2g9OdnJyKpn02lffOEc4UM8guc7FTYl81VSO/GpcKUAKlhXF1a8BLIsO6YVB7tlHBlE09PnMbNnI+xjaIGYk6qSvJIWjJTTII8TuboV2MJqUrABi2w4sKO/HJCL/8hLjuCc+/FqWSvgJ/CMgCH1Sb0t6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6pwOOA8PZmMCPSgheOx4+TbsL1bCZHQyVY0ngB6kX0=;
 b=Wc1W5/KKw5JRdh6EL3aV8DmLI/yKlOCIaV9mZ0CkujhMekcOb2FAC7hrwWbF6WKcpTlBYUJ8SssJ5ihwKmkFcW1T+PmqowaueSyJ1Es9xq7syFpIf42RXGrCikwmoRsOFn/BkUuaVldic7tGeER5b/baC8S2eUTdyEQXUf5NWOI1lQnuwheLIDgjmj9Tb7IUwqYDF30t/FyPisOfaz3Nr8lY6/0k7DBRkMEoTz2qPpyWEr8fVknJ+jCNiyHl9CN8hWKsP8CWulOvyG/cG92RzNTnZ09x4bE8UNlD+Zbe6+8T/Fv2n+ShAZfoD2su9V3+4t48qZmRBC68PmmMX9Nmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6pwOOA8PZmMCPSgheOx4+TbsL1bCZHQyVY0ngB6kX0=;
 b=ahs3ApxkCVBH82kTuOutIRspagDh6GR83Q8XcfNpUQO7c5LU5DUQouTzvd3TFSOZx5hOIJ/fStu/rsnLLNG7bS9l5zox+Lw+2zumwLQc/qnjkXk8IC2fzM2YUEiSwLMOyiqt6DOFjZE6XEZff093E+iAFUb89YcDsljenP7JC2+A4qC5DKrKvz3Wpeb28VABsfg2dojJ7ASYMakSLOxJ1OGSExbWZqmrF1zDdbbISOZyxw2Uq/5FtawCu+2cniXzSx7FV7niocnQ5Yvrxl1UHq72SHeIN3T6lX/hY9wWhzmJy3SFkzzNdcmXlVlH4FI5xCBh9e5vmHkWsKa5NIV+Sg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:06 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:06 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
Date: Fri,  8 Mar 2024 20:59:46 +0000
Message-Id: <20240308205951.111747-4-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb27f264-7153-4ead-28aa-08dc3fb2bb9f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iO1eP/VTNXR4m9FgFgEeYqLX+RLrzTV/WPDusvfTZwi3E6gvfZywXbsa1OQVbdrRc7PMg8uIU6yO4sIldzqN4SIXn7fiEVzNpTV6y/TcHwtfZomiuxJY9YOxDZU4/SQF5bjH5ytSQGZ636reXzqYfAbDlZtqorZTxI5KIc+4Iv5qzidSRKOKS+uSFTltD/PDNhnRK8cQMWVtHAdJxX7E75qP+GbcydH1sV6dAfM4JfgV07Mq9Sn1FK/ly6asolXD5gKfg9LfpSeoBBbD+2LK3fsPwAVpv+BjP0ct++eXyzfrzHsIeb7VOo5r1iGfFDOkKGoN+43u7F7bGxqi7n8R9MP7Nb7pEzUh0pgOB5GXIHO8f1QCSJd8FsTU2KkyKt+lb7jIYpV3wviCLWAWlu3B9R968nXLG45sD7adbjJXfE1FEz72r9Wyvvy5UNwYAVgpadTdodKWunH7egXApd84VrVKiCmhYyRQLt8mVchPxP+9ArsUGjGhOsHCtxG0OHsQ3JSnj6ycEg1Ji2tl9HWaUuF8vIkf3yCPAShR6ckKbPj4yy2OfAAxfOaM9trml5HXoR+EQceWHb2WGpvpz4hRS284FtGrC6Wu88LB7qwngVds6e1D02mfPhfMF0l2rdUFi1typEIBFD2YZfwvKPF3ngLmN/7DV9C8GZQMMWAf2Xemia+qy8swFtBBIh3eoGaVDF0b0wYsGZOh33gxjg2XfleMCRGbPEsAa8+sRfWsZuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTg4HlFs4rIQZfIlWMu+AnjmjCmRMMH/ryZn9rzR97lXz7CQQEGQn1Qjdp6k?=
 =?us-ascii?Q?GUzeVzehIvJYv9FnKVty3QbRwqluZITSs8gUnqT+EDz4dU2rUp8lqmacp6Pr?=
 =?us-ascii?Q?nIrMKCryRj5TNUcAnnkz0Ijb8AaUzh8YlzGW3EzC7BrYJhVS2MZbbtZPrlJH?=
 =?us-ascii?Q?SV7UKh2D51i3YPG9HobCh+eDfmuJkoGCzgSO3QrlRAqLz1aJ57CB7eI7X79v?=
 =?us-ascii?Q?D2g8qeUDhtGTk7j7awdZBVPnkkB//MTrKIlpdjo92jvTiv+4aaG6UtH2soT1?=
 =?us-ascii?Q?BpluYm443lwXmjeHf76Zl+WnzFt3cOE60z2L+GSkKHoRzf0wvmSgb1YUOksk?=
 =?us-ascii?Q?QPx3dwxzpRcvIf9JXwNB3dpglJxjm3MWmNDJvx4Odps8ahEXSbk/Z9W/MRZ0?=
 =?us-ascii?Q?hnQIMT0wx7NOtTU1ziuVemVxb0Y4rJTeMX+3DA2NDYMJl72/2dvadpeRuMNw?=
 =?us-ascii?Q?gNBYH5SCXS44Gd7XuT7+BU02Z0QQzNKgJKBtI8ei8mr9QnHbjeaJC+/mMITY?=
 =?us-ascii?Q?sWL3g24gMT1f/8PX//7jonZdw+UeOa1YIon7gPr21geANsB/IxE4cifv8ThI?=
 =?us-ascii?Q?GfKnrqTphUPvGrhvOPieH417KS2NIGxiJk5ZhfzOPBLYU9hAsWBBPFqeUUbC?=
 =?us-ascii?Q?wCwIQnswbeIC9apSU+P98Xv0fiMBqniughR2nsKB2i1MB7ewfFvxtJ3QrCCp?=
 =?us-ascii?Q?hTV2Don8mnqAIlfsVEo4LFGFBFCZpPsNH5EZ10MAJKlHn1LUkKEX2xcrUuwi?=
 =?us-ascii?Q?qkkGYufzp8sqvszG/TkQeTKmLJqzYrNAqMpoGufnAMkxU2XsWA0o1PWfbJ6J?=
 =?us-ascii?Q?xIxH+aeqnFwi+J0Y3tTm0D9Ce0q9IYeoq4UOADJdmQZAjTy5X983eMULWPdP?=
 =?us-ascii?Q?bWM73RoOlM2EvTMWgAXv60wQ2RaFcPh7CZnvFnWQuyJMvUbNE8TCsEKBdkhy?=
 =?us-ascii?Q?JMiz5N7qM+Csf+aYbN2YU164aURcUd5P05NKXjyWV0hMyKXlZu2BNy4Zm+R/?=
 =?us-ascii?Q?yArsvnYE+v2Lpkj0AU5bH6GPvtkpJb94WiP4tGdK2XjkelAi/xPmMR1HjNXu?=
 =?us-ascii?Q?WjNC0ojJhqDi72Fb3c4Gp5A7kyz9SXZKx0ntUrrKEOywpSYORXwIfAF/62+w?=
 =?us-ascii?Q?AETeEOFr4QVZCSKA4c17FPjRvLY6jnZ0Hsgt2gfUFr0JYHQuoabvdwOTq2WR?=
 =?us-ascii?Q?DsEkJmxdLc09DsdyDWhzIlzc/0A4q6A6xdB35yFw8XG80BeJ9YcfWAVK0iPK?=
 =?us-ascii?Q?ry9aejPwVU//DPYjBQMMcPZPa6x+zY5gVQ74qyY001TRQ+o1KTwtpE+D3XdV?=
 =?us-ascii?Q?9IzDMDHU/4mGVIa5RLlWBzDm5YwHZfpDGuoGBo+I6BEK9rpWhFOq5uN5tqo5?=
 =?us-ascii?Q?DXHW1M875lewOA9yv1zG90LSxQpSF8SsVN1r3orxxHqe2KpC91kg9ikljJHX?=
 =?us-ascii?Q?+7xdBI+QTEVL64+wGfClKivNU1/vGKklI/WdO0C3dsXdQIAiIWU9ryvBtAnb?=
 =?us-ascii?Q?fBoVwnpkNPJ1MkT/EBZVetDl9YbCX/YWOGaBYOlg7ysXLtWQlRFb7Sklueh5?=
 =?us-ascii?Q?0Y6pcwgt2eQy0wGq5kIvW2KCReI+0wghoE40AXJC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb27f264-7153-4ead-28aa-08dc3fb2bb9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:06.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMZgNODb/W8S5Se27X5ABR90kwGR1mvS4kZRGElipihwWFuEUP8MD2aUB/5A1hMnMLXE+ZadFLpaZE3m7SU9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-GUID: Z83M07EUo8F5OtW8y5gWbHSgHn75SnGp
X-Proofpoint-ORIG-GUID: Z83M07EUo8F5OtW8y5gWbHSgHn75SnGp
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

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 9af3c7d4d5..3c3fe9d8aa 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -49,12 +49,12 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
-static char *
+static SocketAddress *
 migrate_get_socket_address(QTestState *who, const char *parameter)
 {
     QDict *rsp;
-    char *result;
     SocketAddressList *addrs;
+    SocketAddress *addr;
     Visitor *iv = NULL;
     QObject *object;
 
@@ -63,14 +63,24 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
 
     iv = qobject_input_visitor_new(object);
     visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
+    addr = addrs->value;
     visit_free(iv);
 
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
     qobject_unref(rsp);
-    return result;
+    return addr;
+}
+
+static char *
+migrate_get_connect_uri(QTestState *who, const char *parameter)
+{
+    SocketAddress *addrs;
+    char *connect_uri;
+
+    addrs = migrate_get_socket_address(who, parameter);
+    connect_uri = SocketAddress_to_str(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_uri;
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, "uri"));
     if (!uri) {
-        connect_uri = migrate_get_socket_address(to, "socket-address");
+        connect_uri = migrate_get_connect_uri(to, "socket-address");
     }
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
-- 
2.22.3


