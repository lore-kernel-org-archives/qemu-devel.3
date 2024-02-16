Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A10C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb4Kf-0000nz-8J; Fri, 16 Feb 2024 14:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rb4Kd-0000nb-MP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:57:11 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rb4Kb-00012w-89
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:57:11 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41GDlaKS022671; Fri, 16 Feb 2024 11:57:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=bT7+Y56GZRK
 8W73HqeSF5/AZ3gSGSslWrbxQiR0VxRs=; b=AGWDeoAUQzkyliKvNi++3yGWkG/
 /Ax+k0Hpq/F8UD1UvaxgDqaThX/EtGls/q0hK1xAT3YiOhaj6++NEGp5cD6u8OqN
 fcHMQTbP0p0TXRlAHqwZXGS9Iq2w++NgBUkRY9zC6Gm7GNU1LgR9L7EEFJZ/1znj
 RGFDITBR7osPnSj91iUMVWOUzajWcJ41Gqnj8eBDKzV3xXkcaXBku51WjxEno1FN
 QGpW4WXDonHNEMHdsgXaxqkZU2pY1gI92lGs2F/gtOpUHAem7cYJRBHAUJXuR22v
 rvfE4UNHaJjCD+pOlzxChUp4mu9fX/sJtiQxSOJNcTFfU3hl8yl9GnodzYg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3w693hny1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 11:57:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va2z5tTVmpJuSmBEibecJlPCsJkkxbwWQB7jhT0Z3kfP2S2eQf1Mph92G0snJrwGvWrg5UxYOPHGPTTptaGu7VLqLLmr45qq8+G2HzLEjSL+9ENYo7FNIbdtwcRE3n6MOPlOUee45JQcX50kgY4QtUNmtl/8regEEL/fQCwU+fi487VEH7+K4+gTagh5K4WFTjIk8n3up+dqekSIYnKG6AEHZvmSiBYJEwUXQF2Jo3YYtjCDXDpFD1IjRWJeA7H4zBr9i0rpLfZ2jrjs3p3rO16JCFtnoAabue5VL4PDfxrVMoXwB/Ot9rDTY1j2QpXyR51q3bAvkt1O37GFHetPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT7+Y56GZRK8W73HqeSF5/AZ3gSGSslWrbxQiR0VxRs=;
 b=MkneuODdOM/E+XzP/USP9PLXb2fC4OkPjUFUxO1+/URU0dg34PT8XkJ9ZO+w8zybH9pwTUamLk7PVaQjuwe6K1cbTRoycd1QzeyWVk6szcny9J/RLcKzNhOL+TVVthR0nwBMRAyVrRxjLuX3kdqRPyYoxwhV4nHmKIDN+GJA97LFoag+AubY8qiIXv4cjruMc1ew5dT3shn1nwgBSDbTk1z2A8NsclHJuOYMRjzTELRpd4gcQXOUF8OVs9bfzC6gayEGyxXRx3/EwKYLYQSkux5j+UqQ66MIHoLH2tx236UIt79Q+QDKRpcGZu14Ls8Pg250UA5ZU16CgOkEAGQPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7+Y56GZRK8W73HqeSF5/AZ3gSGSslWrbxQiR0VxRs=;
 b=rzxC0QPHq+SSHbSPpH8ARRIqMKcEIty54KkGbe9JrovutlX3nnbWhOnQteB2Hsg7V1iIzRh845WM2FehGNJNAmNj69Qo63PhROR6aVNAztEyp0O65sn1g98Pz1Xrl51JeZBLcxlDNd52E3IQ8TGjd6lvjSb4cEePRGDWDo11kJCGMa1/643/4cKB2oVB9slJl5yyy21VYP/49aDcGOkGI9g5lGIb9uKMZGuFIYjmopT75+ErPwD49vaBHTCVX5H0EwmEKZf0cWyYeu3mys7ziIsurMATmFLC66LWK7IV8oQoC0hygKrYJPZiQCOKxjLlOSDc3HeJke7jK3oddIF26g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6643.namprd02.prod.outlook.com (2603:10b6:a03:213::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Fri, 16 Feb
 2024 19:57:03 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 19:57:02 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH] qapi: Misc cleanups to migrate QAPIs
Date: Fri, 16 Feb 2024 19:56:59 +0000
Message-Id: <20240216195659.189091-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: fc93d5ae-2623-4927-c5a0-08dc2f29719e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pF5S8LnOtTyKj+X3oyvclhcy1eA2UZrgBSo0F9+a9O9XKs4rptZP9xtVeiEO+qJBhaVB1JCtReKvCaYaz7f7lM5t4ch+InUtVKdWqQCyT/1zvhyHnd2VzeflHM5McJy5Xi4w8O+7aE9ygGZr2tjrY/B67mlBx4HXE1CcjQLLNugk/BOCWK/4P3OppBz4KAhU0I0ZnK6LDmEn7rbwAtlEq234gBbJp2kG9PH3z1SdKC1ZDFeT9sDUSGs9hvSd4Pbz9Ra5nBVB+rfWOZMwCkE8txO2jKzJ8EvPYMUqEPpMImvo4CvXy5JtRwa/CUpRW12y3ZWtiyfC4/1YILM6zVk69MGrFTDZdh/dtP+2vrPkNQWWOW3KMrOt6C9hNIATUKcbv0C5eC73cGN2Z7lDWSVpMFRz/hUJG0aFeQeBFwbyBvzHbQVp6ULQUDKlbe1a/SoXUXOGQhb6l1JpV/kGp47IQgC+NyUAf8mkV+nvI6Zml13Kf8bbixVaOHKQpzZwsv39xMGycNAPfrvzqv5TZY55BiyZYk66LJe0eNC8qGErGGpKlz7O/aWXSAuMtBH0+PYgfjdlfM252gPfTEmVSIaBNFZxMqOscOqbN+aJVOqlLEHVd0n7nH6uyelW2yNB5BC2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39850400004)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6486002)(36756003)(44832011)(86362001)(38350700005)(2906002)(6512007)(52116002)(6506007)(26005)(107886003)(6666004)(316002)(83380400001)(41300700001)(1076003)(66476007)(4326008)(8936002)(2616005)(5660300002)(38100700002)(66946007)(478600001)(8676002)(6916009)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ozhm2Cn0hwxNNwQihraI0wj6e26nbSTNduPqp09Oppt7P2yDH5M34EQ3rver?=
 =?us-ascii?Q?YUk89uObt9iWkVD1H8eL4xYiVa5Y5crXrCCIwyJR+0/Gd3JajYi8w+f4kdbP?=
 =?us-ascii?Q?xYpZ0WfhovSrgf2L64fJ/GDwXiLbr4uP3F3/0RPUwP3rDH495EObZZx8ChvN?=
 =?us-ascii?Q?LMBIowELEHC0uCZRil7AVK9jkgpApU7LxFb+eCxLhHDNrcAZY6kqKtIcbNA8?=
 =?us-ascii?Q?fDlgzptqP100H04QewwG9DP1XLiBzD/RI2gnbiYwUW7dygBXZGoPqZy7pqrH?=
 =?us-ascii?Q?7wJYtjrW3nToCZ/NulcMLe4zmsu79z4RAb5HJUdCRRfYKQZa2xNVrYP2khuZ?=
 =?us-ascii?Q?GRwzz12iJbpOeEKCqMgz/O2lM4m4yZ3X/LtZ0QPbdbbcciXbVmRVxq8KKZAD?=
 =?us-ascii?Q?+45FE6OSHIeLMEx8+FZusMwR0dpfIxSXc+De49Qluol7gDR14OjXem+FG863?=
 =?us-ascii?Q?POmezai1pjGFI66VjHnfSDLR2XvSMfzERtd4EUsvL5aiJNZodml6CgC9Ytz2?=
 =?us-ascii?Q?jelazp2Y4lz5SWfsAzmEhghDravdl84oKHyDZJPJEiONRYiGBBNsoNEqC6QY?=
 =?us-ascii?Q?xXjfnYWcpfE7jt5W5+7N38I7icLVvFHmHRiPGDVhnuV/MfEQQ93MKP/rFXQ0?=
 =?us-ascii?Q?uMipo+bDF6fxfrMdmsgclYZ7EceJJOjdz9v1mtvsQdq85Eu7CFNfQK/QvrmQ?=
 =?us-ascii?Q?nUSJCYYOZyC9YoRXD3aKzYRQxCbEacpHvRWxJy8j/NZaKi1oMKFcbuBfW5sR?=
 =?us-ascii?Q?G/Ifi2P7+O/bUWVMCGoY4PCgcycmJUZZX2/lBZ7vZ7GEHe+1TVnAPnS69/0B?=
 =?us-ascii?Q?ryrcW0tS23HeYQhJyBhGJqkQmt0+FHo41hzqRw7+uzhkvmeZPcgApEz5Ky0t?=
 =?us-ascii?Q?rvfUeJ+601naUlc5T/SX6wBZYnOcq34ThAj1Aa4rqnVSagpvQNuctDBLFHcd?=
 =?us-ascii?Q?Hf+exPK5sSuTdkgeITX3ECTe8UzThCZL8wp8HjDHZy8yG/4+5whS/cTeJ3d+?=
 =?us-ascii?Q?RXBcOeoKcxW8DkwgVAkcQeeAvmihz4hsGRzgostJFNR2wjuwqeOZE8AXfX0W?=
 =?us-ascii?Q?9jIL98QhJSEV0PUiu6w8BGxFbrSBtM/P9RXpLTB/lpjpyROS1EDXwVDGjZ7g?=
 =?us-ascii?Q?eqYVCg1vj24ccr03kv5I26cYk9YOQ3w0NXnJMNM/qgItZsUb7dymSJPMo7Dt?=
 =?us-ascii?Q?GoFodeP9SQZmwRDKO20KivkiUucRzTCHvM00vrwegLdsupRstpHLBlyAws/l?=
 =?us-ascii?Q?AATaVB2ss+4QOLNbZ2wIj1UiPhVCzBUGTUBgYd5WaEWi6R8eT27XXoB0nxBy?=
 =?us-ascii?Q?yJuUosqJADJ8WwrZ6kabpGK6Xe52UOeXLY6/b4/7aLC4pqxivOSj3e0F4YXu?=
 =?us-ascii?Q?0Qvkfcs4X2ELUK8+fvd4NSUuhhB6VETnWOMrPb+o5ArqE2ZZba/ik5P3Ywq1?=
 =?us-ascii?Q?V4hGwIBPD/ap3RWvB3J55NzjFOUQLwbaqH952taCiGh09gjCx79FQqiKzLyq?=
 =?us-ascii?Q?hOnEMfQ/bEz+IOMVv/0OG7iLHknO++A++WoC8HA55BCQh/6JaDVPVpPaI0Y1?=
 =?us-ascii?Q?hweSknefxze5HBO+lv1qgMxdCz6jvqRskC8XJtin?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93d5ae-2623-4927-c5a0-08dc2f29719e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:57:02.7586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kx2Bm1bb6jF5o38QDDNv72j08wmp093uwOQj/IlVbWkuCBH1qC2jApfG0A87uosmiPaqOxmVl/pY6g03QDYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6643
X-Proofpoint-GUID: deiyPaJY_7Ezso3HBJ9CnsC_vjzQkg2L
X-Proofpoint-ORIG-GUID: deiyPaJY_7Ezso3HBJ9CnsC_vjzQkg2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_19,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
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

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 qapi/migration.json | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..5756e650b0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1728,6 +1728,7 @@
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+#
 # -> { "execute": "migrate",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
@@ -1796,19 +1797,19 @@
 #
 #     3. The uri format is the same as for -incoming
 #
-#     5. For now, number of migration streams is restricted to one,
+#     4. For now, number of migration streams is restricted to one,
 #        i.e number of items in 'channels' list is just 1.
 #
-#     4. The 'uri' and 'channels' arguments are mutually exclusive;
+#     5. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
 # Example:
 #
 # -> { "execute": "migrate-incoming",
-#      "arguments": { "uri": "tcp::4446" } }
+#      "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "socket",
@@ -1817,7 +1818,7 @@
 #                                    "port": "1050" } } ] } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "exec",
@@ -1825,7 +1826,7 @@
 #                                              "/some/sock" ] } } ] } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "rdma",
-- 
2.22.3


