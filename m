Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C435C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauB8-00025J-Fh; Fri, 16 Feb 2024 04:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB7-000251-Ct
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:41 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB5-0003sZ-PQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:41 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41FNH0YS003311; Fri, 16 Feb 2024 01:06:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=hwWa4ydQACrkEjLzxBeHe31jylI99pgtZP9E/Lsev
 GI=; b=ZfBAeJrgSOrpOKx9ZV9vK7EW5SrcqtkhGgVZebq67tNYtlvYPLTAxNpQk
 04P4O4A63U91y45zj7sADohQZTlax0EfeqXWyAm7PruBUHCG1plRLGj8lKrr2IDa
 X+AnsRc3DVcHmRBgnStbAfxbw4HBztL7B+JGiQeFdmVRnD97tCyxtvTeNe2IcLy9
 9swH8mTKKvNr/MntzODEvnZ5wFkyDFCI9WZHtew6kUKsKtjOhSgF7qSGoaPbrWVA
 Vk4+b52vR5MvxOk422jA/mYRlY+DuCtxqlpyHYkNOFRtz1mTHc3rTzFdm87ke/LP
 oPDcIR+sxim7Jn48djigmEjgqiM1w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3w69bg4q5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 01:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P57V1hY7OPNclvwGenmWaUROU+eqdL1sz/y3hCQABUzzR0IiwGIOwL4ezKAgrfoOCSYZxcuVNcFkWqKEqOqsfTyVkbtiqjGRduu/O28h8rbMjWFbmt2u+w4x9IlCXaNnR0xhtknhMeGFqXyTnfZfGfIu3nZQTXcV9L4oQBhvvdOHn6LLDNsBSfpGe+SygN2QF8MZbogtkSmE452BE+NfXoib0JVE6pGib2cOqDxe33JcJ4/RU9KQsTiE2UOtMWurZYjn41l78l6ry0uNlVQO9l8GdkLAqxy/HaUXSIdywXnEz+rx1Ix6r0WeNetq97pRhAzPEmsNwqjVQuqaipDR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwWa4ydQACrkEjLzxBeHe31jylI99pgtZP9E/LsevGI=;
 b=jKXmMpaNPlnxdBZHQU8CzWufPU/uGrZXDiykh+ToUpLa6cYNETq65vXIPuJipsT06sm+RFtmY/uOwMcazT1KdLN6nXOY894AIO5nA9o01jrp3PDFDQ6bMT1OIfIR3O4MYyhRCgDMlGG5fS9XCTzbtzJQVsSzJs6PR/dXn5LSer4pXBAUR+p5ZzDh7PM6fNbGlrduusDdSUrWOvGDBE5yUSdLyKTAcfUU6fTvkiQTp7cq13pmVcaa02b317xABOUQjHwhDtGcknQYUvPJRNkPTvk8zP1ua/5nR+TUUnEfG3kSU40z3EIQzeEHBxqtko5umy//qcamC2ZQJ2UJpjcmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwWa4ydQACrkEjLzxBeHe31jylI99pgtZP9E/LsevGI=;
 b=BaNeP6j9KhwR9n+AKthOI/9DE1UVdb97rB5mEvHk9VLOo7lNYx06mIxbKfBal2YkcXUYEbMVB6NGvLFhxbx++tD3cPplKvSYB1IuXF/dY0qwWB2ru5wXFgd68ppaFw8em1ZNDqrRXInJAfVL05lOKXEPozYJXZ+7lVubLc59H03cl5dUOPcaFRxDeuPQLvqQLCqcJ8j0OiMjeC9I4r0v0UnUkrSzc4AJl+Y7m4M2EVXl/oiiiffHNCQg1AN0ToaR/FyQYujr53n1aiQ6y1NTxQmKX9VGFJIPZxx4J0gWAGpX4G/QMhXHskbUitXkfPawX7/ImoXMy2QlV+gsfZaT6A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 09:06:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 09:06:36 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 2/3] qtest: migration: Introduce 'connect_channels' in
 MigrateCommon struct
Date: Fri, 16 Feb 2024 09:06:23 +0000
Message-Id: <20240216090624.75445-3-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45897fdc-c83a-4b59-61c0-08dc2ece9415
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfih5rKEk6uQJx8xe9oNaZcSp/FsHN2KDYvt2+nKqI2pRWqox2cqTzvgmXyEEn2XvA+7CJ5QLccUZkGa0lEifP1faA5iWXihFMSTVSRUf2q2WcIeWcBwaltz3y3mJvwlxMT/C1WebI2xoSapc7jc8UMoG1NbACEtiD41sVXa0uFLZLUUTTBDJKJ4lcYzRdAaAATRWCFIQS/XbK+Z68XnMEyirP5X8Q8Z6wkLB2yi7yxC5wZ7swntEusa5TNlTT3u6Yb9EwBJH+G1WKX51s+OY5nnoOHD958tt70TsMHuxoZpAonnyRvjY/tmyNPW+ju/m9aIa4aFzfII+6tqyLGjyZkKdI8g7KoDMVECih9uksc/WhCFBww895r6t6cZrF6RRNsKiQR861/YiC7apdQu/zv8Fh3Xo7LedMfqFt7R9MZIv4hisWQh+uHYSFjxiS0YzfEz3FJM+uqo4pSGiL6tJdIPwZe3T523K/s2oNXTpeCXVn4A3TODsNeV8FR5re/f0183Wgwft+Vve+O1gRh2eppfUvlfEO3OQ5NqOaqBRqoiUibK1SmHaTn4UfOHl2dhcAh2FrQ3aSYJMTzhJEC+yhbE3MGBqlLuI+AbT9WYpq1o3Xx5lizvKvZ8LHRaM7F4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(44832011)(66476007)(4744005)(2906002)(8676002)(5660300002)(4326008)(8936002)(6916009)(66556008)(6666004)(26005)(38100700002)(107886003)(1076003)(36756003)(41300700001)(38350700005)(86362001)(316002)(2616005)(52116002)(6486002)(6512007)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+yJYg+hbU6fZTynmYmv0BGA7yOZ5m4GRFVY7Ch6FjunMnysJI6tETQ/2eCNF?=
 =?us-ascii?Q?nuo7wQCog7Nvx1imE3WawFVszt/Wvac1VtS3W+pGJiS49JzLDYGKwQgKen+L?=
 =?us-ascii?Q?lZxRS7LSVRs4B+ACs0on7f4F6QtFsXWBMDIDt98nWNfXxegPrAonBAB7Un7C?=
 =?us-ascii?Q?oS7jJA2WJDKlaOeC8wU6TN771fy6fdqiDB6Ad/n/x66I1kNOflODNww8AgR9?=
 =?us-ascii?Q?kWWzfUTajYfKh5CHZknMNJURdZ0PxpjV+GGldTZ+FpViQAOR6GndxN2B6UIg?=
 =?us-ascii?Q?v4hN6UveJQB/vLEOXmXocfjUUkfjDQkxymJ9in9LeQYGox1jdviQunTzno0V?=
 =?us-ascii?Q?7Jom0YEeDe0NQBde+VOrePYrh/eUHmG4P+lZjtpJuhLmAxNFTQXCmcKBmrcg?=
 =?us-ascii?Q?5lG1rJBM6/EJdwdCY0ZtXRzYGMKkQ74/HQMBJMcVXCD6F9F96lrvigYwY9TJ?=
 =?us-ascii?Q?GdtAk07CSJrEYOI9AC/EoTe7y/e7t62BQiTTqrbeFKo1CgOh5+2W0t/VdpJl?=
 =?us-ascii?Q?zgAZ8F9qS3mPtsBUCjsJd1YcS30i6cuyOkYBhTPRvOYeC98qJJB7E0agDvx2?=
 =?us-ascii?Q?xGxk/IdNm6hRgX+RwI528xgIsikjwwKBIt1eTd+l5Mbx+RGHMqhgn5wutzpe?=
 =?us-ascii?Q?xa80CYI/5nr1fClZpWYZOsnuC4eww/8TtUcfnQg2jPY+8D8CAHIyASf+B+4n?=
 =?us-ascii?Q?2VfYf7jgZinc6SMgJ7HIXtnPc1BqEKl4cJp7fcBf5/DZoxo7VHJTCe2ThnXM?=
 =?us-ascii?Q?5q6EFj/6IVYny7QS/mE/j7lBrvEPipoKiIio42PPz9Z8KlxjTW6JwM3flASL?=
 =?us-ascii?Q?2mcYrl5DDyVJSrOel5RUrbi7sBswcdR/0avTfxnXwKiJDtbb3HU+RmuPmreo?=
 =?us-ascii?Q?mxR3MM4eK5paH5jzfXBYspLGwIzFkKEVB/Vabj/hNvlDJAJ6AOCd0e47EOsq?=
 =?us-ascii?Q?emFL8oXIu5KbNsqiW0zYav8dr8HsQN1mlbZhkkryYvFsrH+C8M7uzcUwEFA7?=
 =?us-ascii?Q?Kn5TyYvxtnkYHtC/48NwzIkZZKcdCxLkZpQFyWVZh2GrcM5tbLX6MXgoaV1E?=
 =?us-ascii?Q?3nVXjxnXmWpl523+kIBBGiTLFmY4cuO+IEVvDesDKZqIB8fb5PipBvkYdNZM?=
 =?us-ascii?Q?ancthA3rLOWYceIT1WUhODcU1TT8a+8LN2iDvczR7Xys00K7fI3uruCYVqxl?=
 =?us-ascii?Q?fSMrNNE6+gHgdsDs8WiXX7Z5BMuk/qX9LvdZ4Pa7wvFFXYD9jDTnCHabD/4F?=
 =?us-ascii?Q?4hFoj3YKI9ltNriKYzCS3ZXgCWtgkKUhETMnNPxnTUaZq+46MEuuPUky3ihP?=
 =?us-ascii?Q?LFZndFnSgT9B3evF3+Ie6NoQLMm0I/lHLvG/8lFyqvsTteXNbh7vM3A0RdXJ?=
 =?us-ascii?Q?IO/WJmpNh521M7iAuo961KQ8a/3B7RIRpEkK2yLaa0h7W63uiSPoMQxIGRgt?=
 =?us-ascii?Q?xfO0nIDGw4lmggOQpmdvY5ocKAGr1utWqX+F/Jmgkrmir7W3k9fuTetqKYTl?=
 =?us-ascii?Q?37yfX2v56ZxGIyZOEfc9CcAzfdUcyr0SufuElFuGTZLnlNh4J9OelCkdtEj5?=
 =?us-ascii?Q?SgDCVY/jGTDiBCjm4TXHahzshvkyoSwuuzc3YAYr0xpFbXQspmmZKcXwwO3O?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45897fdc-c83a-4b59-61c0-08dc2ece9415
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:06:36.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVqWDCK/NNXAr3VfROtKY91/tUslPh8O1Fq9UuMfw5NLeTklI1D1Ep83VeML1WcCOeHmH0b+iQPib5mgs7YcIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Proofpoint-GUID: hF06Yhx4o4Wqq2vJI3pqEXVmMX_AvNeC
X-Proofpoint-ORIG-GUID: hF06Yhx4o4Wqq2vJI3pqEXVmMX_AvNeC
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

migration QAPIs can now work with either 'channels' or 'uri' as their
argument.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e7f2719dcf..0bc69b1943 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -704,6 +704,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: list of migration stream channels, each connected
+     * to a dst QEMU. It can be used instead of URI to carry out
+     * the same task as listen_uri or connect_uri.
+     */
+    MigrationChannelList *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-- 
2.22.3


