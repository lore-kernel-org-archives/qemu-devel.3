Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4DCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9DY-0006bJ-3D; Tue, 09 Apr 2024 07:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DU-0006UZ-BQ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DF-0003rQ-6v
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:39 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4393VrWM009211;
 Tue, 9 Apr 2024 04:00:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=QzqwTn/+L+yNm84Hiyzh1WO1mnYlXQRbjZVq31oJ/
 fU=; b=KUVMNojEB3y/hJq6d/45OivjzTbKiozlT5R4999OUuEmvK6PFERCxixwC
 wcsD9Wi+Z4t/T7OfO8V1/QGt4TLW0miqpe92DJhEQPb9xzQgYEzftcuCrVziefI6
 7iksFHX8D3adx8vv/6jHyddiPfNRvOhYXkVq4FpxPZBFkGn0sPBj5ZpJfVnqgg0o
 rt9N7sAIVGKqdnUj2M7Ah6ayOGb04OOW0JEb8qeXaNfHiLkH6zGz8F4dmypvaKCb
 l1nHk/GwyI+VRILzZLAt8t5KYfbzHwDO69aHmjJ7MsCCSdrB8S84vmG3oqBrL7qO
 SrFMTUue9kHp73ORAg12jmS4wz6vA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcwua0mm6-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 04:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLjxux7FifUKa2imD4dL5+QRNGgEoVXF7f2on/sZp0SHl8/0jsMOP14f4a2nM3PUrFErb4b/nhhA2Ai6Gq6/LRNDK99/XUT7ui2JwDz+XNSzewhBBTPj48aNvWxn7eZ7Kk89mdnLl1Li3Aao54aDab7d9gILYtE0NOQ97QsvQXSoQtN7e8R0c+g2QBhI1YSB1ipSdMZzuWsOaE/CHVC76PHI2G1wQG6Ufe0M63JnpvbmC0V2Zz7UITXsDAiE5hjdlL2a7tmYyYyco8hirFBP/1dGCGbUVOf6cCsmG4/tw6+QqeoJ+QY01C9eM7wk1At/2muBQWIMrWRADbZkfIOPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzqwTn/+L+yNm84Hiyzh1WO1mnYlXQRbjZVq31oJ/fU=;
 b=F/PP9kIP6SeEaHrGe25AQda2+mpnh/JVgvaHY+0kClXFRX91EWUZ9jWezWbPn8KBYFe+q/utTHN+S1TxrnpVeNisQ9d8/KYM0Vqc0DFr+l/QewmAtWTELSmSDS+R4Q+kjnC4U7OzKRjvPFgDWjSG8i8GZwgqgUi7x8sUx/msX1e9oi691/d9+7M9ehwdT8XS4DlRCjd3mrws/BOePgKEKs9LFUu3m8INjbPxOZn/xnYFzfmTqoBap2m8qVtD69yP7fOGHyXirQpX1xq8E058lkU6vHfVCG77B6wzKwBF/DlP8gv4HxhTlZgfkewvvbqjtCHQe6TG5bH397GKX9VPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzqwTn/+L+yNm84Hiyzh1WO1mnYlXQRbjZVq31oJ/fU=;
 b=S/OY1aUiloMq/c7cGLhSObQAPq0T7tzEC0TOg6ry2l86tZRw0APivMFHmqGb3jpLe+AIzsstwY51tGwV9+RjFxcfKfyHHSFSSdd3HmUkQtNzj9jeZe1+YDy6eXOhfYEkPVarnWFNm5s8JfjdokAUEt9BNod9Io2567dSoY36PyR/bhevN7Dl9j1sm8aMFEzDsdcVH0AVJv69J6wCkqUgnyewkYTy8bjyAkTm2vSDbMuUSFLXHNWqi9tfrOWCsU94IUu39/OS2SUh1ZgsKTbAwSaY6Y5aTpmtfNcePC8nQ9RNloQBZK+O6YuX0NK7Q2amCK6xGBkFOtJlevEjwJxMnw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYYPR02MB9826.namprd02.prod.outlook.com (2603:10b6:930:c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:00:21 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 11:00:21 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 2/3] fixup! tests/qtest/migration: Add migrate_set_ports
 into migrate_qmp to update migration port value
Date: Tue,  9 Apr 2024 11:00:10 +0000
Message-Id: <20240409110011.174426-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240409110011.174426-1-het.gala@nutanix.com>
References: <20240409110011.174426-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYYPR02MB9826:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7eAZkxipuUFo2Myqb/3I9IaTe1HCZXsRI1mDOrxxumJNpMkvnDeKLJLXNtwX2APiTOuOdYIj1PuJtP0l0StL2n8ANNuWppnxzM1z/szqrRRgJPKklKzeGr1q2QcvbFDZ3JE6dJsNZqWUAdeES7xeCWRTFlR2oXg/nyYYYT2pdtXNWuWCvpKgkTzPT91PKjsPClM3oAJnzclgV5BxNsF8pktYDhpXCL5QlZzDc/RPbtgluj0rtoIPmvsS5rKPP36MfjtYW1VNYU8LMRk73RjrhdwYQUrjcxQ+glDffWoZ0j8+XJ+p+1Faf2rwicd067ckP2X+NplZi6nFpeUmP/Ubf0VeHLyy+tCjfveD3HUhsGNlZSn/3GykY3tJwg+GUwGtGnPReRT7syTFGWyA194xdM8SzSzrR2CuQOeehL73u2edXdpavc3BKD+xcgTzV16QySBNTkPY2l20S9KBQ3beakrmxCZFMKjao53lV87lfXVEOc9r7zkIR/1Fu5tHWhQQRYaamZW2SxpZE91rA6yxQaCbuvmGZwqLwvJV9APZFoLLmrTnA9iGwctCOX0IdeAEBv/eAi6nR8/O6S5NqJSRWzmXp9k+DcfEPY5PgY9eyZLgO7VRE+k6ccEI9Bz62npa/N8Bp41QS6yuQvqPrDyFsKd+W/X3zC0NuwcLCchOFjLaB3styJhBPWs2tBCaDHcerxY9UzxjKRj1zb+HYV7BU8xZ4ECTZiA0qBB1uECVwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+36Hxg8ULq6EUOOHwpPYWrJON+8E/ZFBi4jVumqb32Xfv/RzGCOWjHvC46Q?=
 =?us-ascii?Q?zJijWQzZZb2uPOmMp3q0lxcfSSpG2jRjym9rp0IllX8r04gT0v3oZgUcm2Rl?=
 =?us-ascii?Q?LoB3E5dvkJuQAbGOCfgWnEzDl+c8qddHuOgg8/UtQXoqx+CeEbtIOf5+m9m3?=
 =?us-ascii?Q?RAA/hRkD+yiAf3USwNlriuJPXEa6UcfhRes8wFZOCam3Det8gX9wAkqjag3x?=
 =?us-ascii?Q?wHS4AnD7YeKoFNPsFzjYjKz0MFquPA+vkyLk+VUaT6pf1jHs8acLePKDvgjC?=
 =?us-ascii?Q?4OhaeYL7J9/8gSU7jA6EOe1MuGg6F0vxgezXMUvKQrdJz8BPuz37hgQEdB6E?=
 =?us-ascii?Q?c2WluqI/t14vhXcVU3T2QlQHDX6MUWbL53BkFi3NnEoe6lVg48ZLK2NLNtJt?=
 =?us-ascii?Q?hWOjGhUYED0yTPw+qUalVnEvQtYnaKBFmu9onU26C5fwtxhKo0LOBtYn/ugJ?=
 =?us-ascii?Q?46hD6Ji8C1zz/U8fNf/+DbE+t+/7GfZdPs9V9MP5zfPKvZDTULCIWCiLzl2v?=
 =?us-ascii?Q?gyTZfh+dpy0Dw48aFy+Xx59k+jUJsLNVcYh1MRT4u1QzHqi5FdZqaAFQ8ZMX?=
 =?us-ascii?Q?z74X21RwUZUWs9akeNW4/LG8egfD2Es1gbyZC20/qL64dtIwe6WR5wZy3IWP?=
 =?us-ascii?Q?dfm4zhxAhYU8b+mIjUaNzDS/bTz8jfuA1x2DTr5gWLDadd8ogJ4up/Pt4qpu?=
 =?us-ascii?Q?ZrbVgNu7KiI6vJPK6IwYar4nIs84RLW461IQANswYNcIayLju2vkxfFTMK5Z?=
 =?us-ascii?Q?FGDVh6bkmxhaz3wntMtDUtkDDR0G1MdgjZmqc0NDWWGRJ/ggupgjf6fKXsAY?=
 =?us-ascii?Q?QIKYVqg61HH63qUbX6Oo1EGUSIWR77Lx8ukshhelyDBagoHu8WyuYepgx2Ar?=
 =?us-ascii?Q?T9EKSieaSgRjQYD5MuMhIcISnRaZYNOnXVS1vbqHe7dOie/lkqSR0udOx4u8?=
 =?us-ascii?Q?O7uyoPEh8++YZUtFApCX8giBcop1Ej3cZVraO2CVZUD3o/vMvLJpA0AVaL/2?=
 =?us-ascii?Q?qW7KmNQomCzDwTeRBwFeBDIqAXECDPoBAJViaPr60pGlXro+3732bkNoDM/n?=
 =?us-ascii?Q?r6IIvsgJ66iaSnzR8joafUVCOhXBHFDc7SZlwqvcmWkkTjzRmup51JgdNPHN?=
 =?us-ascii?Q?5rAWp+6tbI5KvuG+EP0r/lkYOagSrrREZpYjlXgmbrozsHU4p7wfPIigQ1Gd?=
 =?us-ascii?Q?MbFihMYpSoRGEIVREIurFNcKno/BZc9IPXiZfS6SgHmJlEm1PNBgFNj+nIc+?=
 =?us-ascii?Q?nF+w9R8yBn4RFYNVMu/PVbWkkb3fgY2QW8CcaQ5dGWQ31PNwwj9GIuJNczgV?=
 =?us-ascii?Q?TMaPMREHk5EX0GMv4SP57YaukPhTtsGeMHjgVxUA8KZ6Eo5/12LXTeON1Vu0?=
 =?us-ascii?Q?StX0wLNL003jhOllJZK1aGKeWBpkdDBhCuGblP483ciJA0K1uKnrgXAZ0z/W?=
 =?us-ascii?Q?Bo3MXUQsJGcxQk8ucMGqfVGYD3hSqOXBW28YGJ0/fJxeIk3PuMhNl/1eN5QM?=
 =?us-ascii?Q?5fmlksvdjqoDjceSc7LYJCgwsHA/Vmsl/PBZiRekrsyetJnzMGVYhKv5mNGU?=
 =?us-ascii?Q?wnoGCoOQcgpTHegZwIRUo0wzBkICgPosEoKUCKQB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fc91de-6b25-41a4-0d30-08dc58844030
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:00:21.6699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCxQw5aPpxTz4VgCH/Q9rCLDyP5kS2V35VKoFuDP+U+P05buhLdSpFiMCBZ4CL9AaHpuTtr9iegJyO8ASV9cYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9826
X-Proofpoint-ORIG-GUID: rDm2Vsxyd9hWdKhMKU9NZddWEunl6mo3
X-Proofpoint-GUID: rDm2Vsxyd9hWdKhMKU9NZddWEunl6mo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tests/qtest/migration-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b2a90469fb..3b72cad6c1 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -131,7 +131,7 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
 {
     QDict *addr;
     QListEntry *entry;
-    g_autofree const char *addr_port = NULL;
+    const char *addr_port = NULL;
 
     addr = migrate_get_connect_qdict(to);
 
@@ -143,7 +143,7 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
             qdict_haskey(addr, "port") &&
             (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
                 addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", addr_port);
+                qdict_put_str(addrdict, "port", g_strdup(addr_port));
         }
     }
 
-- 
2.22.3


