Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E9CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVvw-0007X8-2o; Wed, 10 Apr 2024 07:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvr-0007TE-6N
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvo-00019J-5R
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:15:58 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A84cHU006475;
 Wed, 10 Apr 2024 04:15:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=BBveIMQzMN9VGFFWv+Q5S69+yVwy83mk/iUU64mV9
 i0=; b=RdzxV34KH2EaHVgBQRYEHlXOWOwJoDtEItV1FAHwJU6eNsmRKLM1bp7a4
 wmWzcIlRlf5a8UolQldmbQgIIM0SQ62B4+xBCQl7T8p3WbQW0xYK0O3lsbhVI6pC
 RnhtlpHatyXk7FoZ8bv10+rjwOpbPQc6WuRIZ/kf/PVorWx0GiRmPApMpy5kEMDS
 TOJUjSIUPfOfRgKXktpo6aNWv66qLkbH3xjDEmruKd70p6ZTrNTHoab7fvoIJBvs
 Pq3CeWTad21967FXh9uG82J89FUat+Li40UGrMefYMjRu5EDbRRmAYZaSFccBm6u
 Nda8ng8lHe5YGlfU/pOFRKYoFftmw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xdpxe89hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 04:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0HybIi6Uq3+EUZV/qCXnyKaA23bO3mKS4WQNr7XFExvZPv6WCG0Eu7CfI4K2WnEjMCLUjK0T3dIht3zuLL7w+X89qT7F1r8dMKnZGEuJji/puYGySA0G+7JHayXKp1Bwq7ShaBLuXSJOUwALmFy5TnL0aRTIH7wJeEDoq1Lj0zm9Hd94Akxip3QzZhzmNFo0Ot9dVgSsW3xFt693RdbLYJDXY1vlo7/fguwyp98i6o++P6cCuZ52iJQV2jonBCmm/qRaH3/KelZu3JfiDuwcW+Ebt2KgN2G8U2aOxUssWetF7kUujU/8Zn60lieJTJwb24sKdphD1kjnJa543MVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBveIMQzMN9VGFFWv+Q5S69+yVwy83mk/iUU64mV9i0=;
 b=DoTGvHpXeSNVcjB5yCFYjVEBlt9PQ6ceAj5Ka6ClsZYRnFXKy0uQkl32Mkgo2mRY58biTV7RXvuax4lwh8/d0wprCqd0q9f38tx+ePos+Dird7SJTAGAxYorfieoDz+QGciufsf4kvCPFEQQHoPKXsmVvis0bsQ9+EH5m1zQfgYmmS1xCgZRXjGUKndfd6N8nRNs2NAomFAcLULP5vxckNNSHXWBECmmEvxoslDLzEPTsEmUid9rDSGg47E2MnHNBWomfb1RjzScXq0GSB7xldoCpDZc5RVuXPBdjBSGr4iMwNC0b/nF6aYDmeHuN2MftqtWi1WaUCXnQ2PQYzzXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBveIMQzMN9VGFFWv+Q5S69+yVwy83mk/iUU64mV9i0=;
 b=kHxx0rt3FiX3N5dc2wzyrqNaFzubAnkE1yJOWyOhjk78kb6luy4ZJ193UeT9JLoc1ms9nsG24RYI0o1xPbA2f85oDjj6qaGA4EQI1lnq1KnSXewRLGcf3Xcvz6MQh/nlZxPI6BHlpeest7v61VkreDypq5O2o+0mQYz1+qubgKq2Xpk3IX2FmXH9fKPUcu1XrjPKnBs9GuXKTu3mG3D/mcIeKaVYnBIhCrsTRJZiRhnnrHmx6QqCYUKl0GJptf7KyGlexYllAX3Gd21vZJJ2jFmdNotV3Og4Hi42sGnGhzqWnQTv6Ctk8ZGVGnknHKFa05nh5lQr4xmydpWY9tWMQQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:15:51 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:15:51 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to use
 new QAPI syntax"
Date: Wed, 10 Apr 2024 11:15:38 +0000
Message-Id: <20240410111541.188504-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240410111541.188504-1-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6791:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwjnGvc4R8w+rUUiWt6JibJJd5bVfWdjXnJLKFbBT1d2Qaje/E8vXg46LQsQAHkALOiBG/fTqnlvLS/gaOMCyin3tlyb/10sdjzRRycKzaxBaLywvScuWjHcE48o10Gj07d4gPvOFHBtVpd74fQnkxFKmaejaz6gD8N7U6wmFW+L5bsPrqn5TMNgdMLUaiT3GdNF0tHRmCQAWM8HTiODkbUqB0rhBxOIPf7wdy73TKoKVRhxEytdKRvkQdogptSC1vvydJiwvJAHBSEQ/d4Xh30212e3WoFef2OdMdcbJncVcTz3leYdOJYpYNFHwmcRsoxY2l+9PPyadyxOIbCKIl9zaKY4gVgvL6grJuHX1btiHhXYtiA50aS8qIpKWGmm+WdBTjAF+n3pNwpRMHkHAv+srYl/Gaj3Qb0lxQNnNypZwsuAn+HnxQSPPEawVhgDPE1ThQzJeyqc77921+LXT+CPcZwFVwJomQnTjlb0DWtkD5+6J7CMxLcCyv2rb1GWY1cB/QOiW4RcdM4Ir6CRzoJO5tX5zKMro12Ikj1gCTErGs35Ie9qQdHUP2+HetdFRfne/tIpuSDuuhQztHWfgY4hL6BHRmeH+F1Z1kruXXxNbfyUYzbLvbCHMsHNBDuDGt6CwEwSTgSCtGCZ+MC9hS3LOEcobBElZHS7dxl4Kt9dye7QDPTeAo3TE+VS57YdiL92n9ZYJ5hfC7TRCiIhbtjlLQ55ySw6zK5Pzo8lCcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rD/cBlG4gDBtq7zUtTeAihP4kWhfpNEEzj6CQyxLJv+mG7nMSsnwl6TIvca?=
 =?us-ascii?Q?PFB9lnLP2aNWmX155ot29R/M8+zbI8euMi4q+/zwBILVUUg2MVUqko8BaomJ?=
 =?us-ascii?Q?cwOQ3H3CNkKFZaX7QYsJ8NL4/N84mQJibJHMovbI7FJ0ixNKNNWNhSURTbCd?=
 =?us-ascii?Q?Rcom+EqeK6MKst8ITCRng79wXdh1sjfgQX8WBChRRkPfyk3fivUlwXdhnORL?=
 =?us-ascii?Q?WWkY1+BSFtfax5i1u+IZqtcau0fuNrdCaQFIgw3/toNtXWrmctXGY4gWQLEn?=
 =?us-ascii?Q?WU1JHoQxAOV52LDKTnyxFOvJKexPSyCwgsbYBUpBEflX5dlaEe0BmrOxxQkl?=
 =?us-ascii?Q?DyiVOzOvAl/lFHoOKJfZSdQFwc2xoskjq7ohpuCK4LueuAT0PrwFVf11SVhR?=
 =?us-ascii?Q?t4ukijesmNZCC9GWxbLdpKipqx3rxazbWqN+Yk8af9G03z8HtlhHRa6WBMC8?=
 =?us-ascii?Q?LyVn9a2rfAFW/FeRScC32zXxacRXaaauOeYGmqLmgz+yDk3yFGAmqp+O3zvx?=
 =?us-ascii?Q?onKDo7++DxGRsFydRKUjVnpZ56LUMVtDBuJlzf57qzu79YoDzKs9M6trQH0X?=
 =?us-ascii?Q?9Lg55r9gxmOyaHZ4+oQu889pqnaGTOop/YOLN8puKuLPMnq+ykO8JrhWSSxN?=
 =?us-ascii?Q?dzs+oe+wmCS/rICPbrM49zk4/Iojk6ogshdpQP2qbinm6pBVYJTv/hJf5Lf3?=
 =?us-ascii?Q?+Mo1OA/7qN6sHXqlKnM3Nu0eqrkpWMrYuR1Tkd4eY0hpwXh9UPRWFuIKzNpT?=
 =?us-ascii?Q?ie2jClzghsI+QU4P24HVA9qyeO7E1b1zEJmBP0IjZCCbv+aDVj8l/5+qiDO+?=
 =?us-ascii?Q?jTAepq0V7pG9HHIzdDDkNlJ+qMNfpSI+V5ciVjow9InDzuL7tsQNiYPRYgn8?=
 =?us-ascii?Q?rAPHvYtwMxpuiZhoHn6MT1MXcXEg/BZMAdGg8rDGWBiU/umDNQAA7NhhByA7?=
 =?us-ascii?Q?Gn95iXXPkHIij+R3cTCujhbBC/t/mYHIXolLGEIaxugNhm2jfeBzsDkUqvfN?=
 =?us-ascii?Q?hxUh3gsGFstAja5U1Kn1egB9iDGv/AZTrcxvNlS3FjVvX3etJYiUYyWJqKi4?=
 =?us-ascii?Q?WAu5LybY1XggFOU95kQVJp67xApCvoY/ei0ieeBQld2bGTZlKcSfEc+5YWBo?=
 =?us-ascii?Q?NfdiNFLFe2mmGkWHTcCUgU7uJY6sWDTi+tQ1/pb5ctFfBMxgGw9J3lQuPUMP?=
 =?us-ascii?Q?9ehA90CatH1MCFf2y6FLZWJ4YzK3pjnML7xb4NUae1ceyDIAfu/i++tOsimh?=
 =?us-ascii?Q?IKS8xggb49ZPihfNkixhoBpCdB0D3+7AC3FFLlY1cm/KImJ/WXKXhYskXA3a?=
 =?us-ascii?Q?aBtb8FCElmbY3uSmTitapLGUEo2fk10DZLkkt8HEng19jWH8WxLbefwVbAD+?=
 =?us-ascii?Q?7tJB0aYapctfL/3+z7oiTIChH9dfLUz0chJRAzhq1zY7iU2lvxHN34i+dMZ2?=
 =?us-ascii?Q?GRN9o0VCFIB1OMQFSIvBv0rK7hEHGEzu4XnCpj8Z3Oj8cDXrKXkqFgDx5ARF?=
 =?us-ascii?Q?kOaKqw7GeYIhQnLKGmolDVguCGeNu1M0jhzb9HGwmcipmoMsq5Sy60ZVmclM?=
 =?us-ascii?Q?JLM/K0rH/XzntJQEJVysFbKPSScuHGeq3MXSoP32?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd8c313-0845-44cb-2059-08dc594f948a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:15:51.0142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N+J5LCD3x781RuatYzaJhgQEtInTwauqDlIckfylryOiSu47B0xBB8aBnBaWZQj1ntlGhMJgeTnQjCUlXfMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Proofpoint-ORIG-GUID: eXMkZQhB1G6tM0Sta88acIQA4A77-hwa
X-Proofpoint-GUID: eXMkZQhB1G6tM0Sta88acIQA4A77-hwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb

After addition of 'channels' as the starting argument of new QAPI
syntax inside postcopy test, even if the user entered the old QAPI
syntax, test used the new syntax.
It was a temporary patch added to have some presence of the new syntax
since the migration qtest framework lacked any logic for introducing
'channels' argument.

Now that the qtest framework has logic to introduce uri and channel
argument separately, we can remove this temporary change.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5d6d8cd634..27a1066ae4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1297,12 +1297,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { "
-                             "      'channels': [ { 'channel-type': 'main',"
-                             "      'addr': { 'transport': 'socket',"
-                             "                'type': 'inet',"
-                             "                'host': '127.0.0.1',"
-                             "                'port': '0' } } ] } }");
+                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.22.3


