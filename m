Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528E4C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgOO-0005HP-Qf; Tue, 19 Mar 2024 16:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgOJ-0005Gp-0v
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:48:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgOG-0003da-OG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:48:58 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JKP67l011510; Tue, 19 Mar 2024 13:48:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=bJgzF2wG+ij
 VWJ0pqf7pGtwLR8LleXQ6MsP6duleBDU=; b=gXVbLsuTFsFb62/mE7aPMokAqZB
 o2+tLtVNFTlN6ZcEs7So5v+JUg5fjBSU91XflJbEggvM7c2u9zOFsTtyoaVROjc6
 qj/pUL33093h7R+DrKSbHE7dtZLzvSOIrbbDbPxxXmkBZ59PJaJg/Jgo4NhwdY9H
 DEyvo3dccJCa7+rWFGQEIU3uOhRNMUTzbLQM0SD0wwn6RGY63gAhTrf7wbcBEXmG
 0qD8+kKWKtZCiIpIlMBIXwmZvseGi0l5fIqrvTOfdFlMbVie42M2O/BecWLbDjiV
 K7xKhSCdlJ3WUhptAgZAo7LQY2Br/F7PJI6KTosqkFNhWHJVCb8dv73kCyA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqmr1f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 13:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRrjiqbtXlZPpwNMp2FVaRBifUL+Eea5DIuSmut5NqV9kc/b4OUjn21khHOXe1gOXwfgiJa6XTz3vf5Y+UaIKo9GaYvTxf12pnwd/gXMEXsiWwpw/+ivlWsu1tOJh9wC5UcH5XrKWoDtlaYOhvARzg0qRMnjIiygvFOshDKJlmaZHRS3E0FsRlT9EiSHxo/ECWWZFd3AdqoAiYjjDw+xCglQ/6ktelLGnFEJTZxjT5/8nORb6FusyCZKS5Yn1+bSnyl2tzPrHaC8Qv0cFqSKvB3hJtPFIpjuciVkQ7t+mOIFJmPuuVKLSpunODlBpa87WdXbmTcFV4CHlJZOCL010w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJgzF2wG+ijVWJ0pqf7pGtwLR8LleXQ6MsP6duleBDU=;
 b=Orb4H7lF8Edxjjirkk8BHJ4MQch+F1eU4ZXazAdtQo7VFT3E3SdzZA6vKb257uB3aQbw5Y/I9XlmVcNVYhD1fF1/fdBKrL7eaqXtfIMamM5XylCcUqjO7pJfZ1JNb16poqLUiTy96tu7QMU8qQv9YIHpOhor6dJ5J2iNrVJEp1W62StpQmtjdKNM1AiIKjhzlzD1nv/tBgrY/Xq/ZrmVqZz4YZfA3PEUyUsL+9sHcWvSqc8h4opNfY5RMKSmLzR4MukK4s8GFjXbgdGxbrUrQ1gHcY3mH9sYz5Q3519DY4usSzRA7r0oLx8STCCLhapaIBdQ5sKCnwThvQCl8/qaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJgzF2wG+ijVWJ0pqf7pGtwLR8LleXQ6MsP6duleBDU=;
 b=jFl3K0G0z04H/4CPP7rtZrXug7IE+LHLBvnsUBQEq4ocwlDyYrk+w7k+UzMGPvZVTIugRyu3rUuN73myJptyN3aikv0GUNN/V8zKF0aKXHsADvG9sH8L89VMtYEXJ0G/ER8BAWsyFzvfM36mWxI769og+sLFHuf4HmJ5yO2IylaN0nZSr2Tan2H8DeBfE6ss6bedHDFn9MiDsjnNrYdkZKxjhoF6TKir/ENLxqGY3mux9fGUpaLA69WftexddDJ261p4tc9cFtHXgBv4UyXxWbY6Ew55ufYoQHP7tD1kXkQzpm1vqt3WSUWfm4ASkLDRhc3kTW1c2u9cpcL6hlpHdQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6732.namprd02.prod.outlook.com (2603:10b6:5:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 20:48:51 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:48:51 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Date: Tue, 19 Mar 2024 20:48:39 +0000
Message-Id: <20240319204840.211632-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaefe7c-dc9f-4aaa-371c-08dc4855fba7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rpb0Dkku5wTalCAThCbszEzWuQPX2gDtq4hkOTPuWRTZYnCO6eGkSUoSqbbZwbFufLwXA+V1b7Q5PvwNFWktdhDh3YAm1Dz16EVJXh8lTlx6GWc38EVOmX+fT76Qe6U52bnsTkKSmIx4NdKuU9o7BR6XlpMJQibx/I3/kBcod1MCmcb15pcVLLsvEBKbq850ZgcHXzNAIwkNuFTv7y+wztN5tGXRshWKC53fQnu6drPguC4LN3Sqcby1pnak9Um6uTy4c8KIgl1AmHyK4gBVO+BSPRhZV6YEpZC9kMc9kn4LO8fESSETjAoGJgZilnKGTbc08h8qfOgW/Qye8eyra+VLD1SnaznR3cnHS+SrGXtLDbWQON1a4P8W4pn7AK0Ny9LQuCltaml7Wv7apl8U3JrIHxrld7hIVEkULWGdJFj9ea8HMmX46DrwB8OCz1PiQ9l2nJLDl/cclBGDUiQ4EoWZBPOuqLApr4OMenEE2CUgCkB5j7fUlFjyWxGLSFYnd9OQ4Eie5/oIO2Zg3Hf+00w5A71n0ELl7shtOmub1OLLZck7ah3JVHMpVPy0/96ly7LLnVRi7qdbN9uK2EiJ9eH6LmYEBeIp1LKsJbuVOXNiQ6DQh6SHWHJ0tC4SOLIwElrNAQxlA1dRqJXsNyIejQXt6pS8GIQVVrclRtHuJOsII4cSLCLJsl4A0/vbOqIhKhk57uYJXALsPZx4bcb1NSoylbDdmU8SrMGA4eFv/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeJ6hSvhrECCOvq5IFJRML8iqKpAzypniEg4xyLJn78vIdHk8mF9zE+0jaeh?=
 =?us-ascii?Q?o8BQI+S/82ly3iEtfXn77wm0kSshDF47n+EypzYTFg9ycLq3VZkXABd+Bm6C?=
 =?us-ascii?Q?eWiHShmTb1sMkHOVL7yjzA9oVk6bCV+G61QDUyctIqdGTVOIYC3xzJbLM/bJ?=
 =?us-ascii?Q?TL9lJC9Srv7HkSIynduAYkMUbM8/8mXklS/NOztTpk8l671DPBavAEmIBsTL?=
 =?us-ascii?Q?dTuCe1hr0qNQGcieYTM7nIyqn48GZurqq5gu83vlQvVXxxWVBBXKYwb68bDW?=
 =?us-ascii?Q?Y/+NQf7iM4z+PxTSoVsZkW8l1YuMq8L244UntYqCLdYPCzsRaVky4i8/G2Uc?=
 =?us-ascii?Q?uHrcB8hXmnDj41FWTpoVwtn1/rrIX4knWoOfwBU8J9sEO5BVqlHPSPg4hm7g?=
 =?us-ascii?Q?vvatWdSHRcqPamEs73FA/xHg5dlGHrvgk6M/kis/05O6/aZlUmSvARgJbgHB?=
 =?us-ascii?Q?w0qNiB/+dTCmmY0SzJGjFdg6Y2dkefZyDIlldHZ3pcRbC3rzLOn7Kc/XyHrQ?=
 =?us-ascii?Q?BtinkEXMzSw2m4MxNNm/8DUZfheIXk0qEdLXd4jO52VrX1voJxawdnKZ8kmX?=
 =?us-ascii?Q?lcR1Z/hCaiYcAFBzvkB5SdA71tcbFZC1Vu69wUjQhqIa155COiUaTnf2on3z?=
 =?us-ascii?Q?LhOpg/xMSH0XaCsH4os4zO+YLnDxfCGPg9opGiIaNbtqYR7fkNfSYILISFRn?=
 =?us-ascii?Q?wyyFomlonF5ie6eL8GSd1Z0YSEp3KA9fvqGGpKDmMam3dIWu31woTyJEXwxo?=
 =?us-ascii?Q?zSEunSpEA49hYKk3Mc4GX3uhHLRw0uiLChuNNcYwKLRspuZ0pjcTIKSVqu2a?=
 =?us-ascii?Q?bD7pLY/D67P0ro/NlrHX88msCdqeufYfJcSw0U1nDiesyZvUYVbrS23LvpqK?=
 =?us-ascii?Q?EToGjEttuQxS5W11cKV9d1+z/aeBNfBR2FCRI5iERuIMlJf7cZ+omz1AJf2W?=
 =?us-ascii?Q?xB1naXRBtYZKCj/K+RZ4c64q8NUrP0Z0PVvzH/d2gryYisdFGogr+YK367ou?=
 =?us-ascii?Q?6eBDqnU0Eva6NVj4D5bmZy52rN6V/R7ItlqVCG9x8SPz2ZFynMw/iEQINIvu?=
 =?us-ascii?Q?CT1lSDeAB2QcdvDay9RUCM9LmjtejYF7Lr7iXfAV/v3B+JJ0jIbSPLrxjh6Q?=
 =?us-ascii?Q?tLH8N9H3ok60aXvz0xhtYeBCcA13cGCCH0CFW9mu/0HvdLMu+oot/GPF+ecK?=
 =?us-ascii?Q?XqLP0QZo/87qia0eMsQBw2xDVEsCHhKwkZcqGKgn5oi2a7V4YJR1dWrw3RWv?=
 =?us-ascii?Q?qfZtgMQxz/sXdQA0xwEzKrmLg7S7a8aIBslKSg5UCEsfuHqUn4yH1ZuWlmA8?=
 =?us-ascii?Q?Z1vNxf9R/xONtuouP1p4EIvES7dI/EJj9eAX4HEKECghRmWo0HeKttSzgrH/?=
 =?us-ascii?Q?4wwVTxh6lDVh4inLfbC97v3lBaHXWRfNxYoTTJy1TOS01I8A2y7RbOzcmEme?=
 =?us-ascii?Q?Za4VjPSErfWBcpB+s9Yj/60++uydfBtGmVeddcUZglIhz+aDG9Ls2TjjRDkG?=
 =?us-ascii?Q?IsTkKyZNFgBV3wro4nVpTqxPsaoirFXJQOfzXbOXpO1DJfokLe5ALiWKYxTy?=
 =?us-ascii?Q?QAxIiZwN5bAX9nzKBb4JBmfxUvVipdxs6mJ3RUsb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaefe7c-dc9f-4aaa-371c-08dc4855fba7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:48:51.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb8AbbQ5vuwTW9jlVJkwKQuj4buwnRUM9pfM6vStzGJEtRkxV8wjr8zxMUdGkFdpheK+QJqH8AnR7J0fqvX52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6732
X-Proofpoint-ORIG-GUID: LLItKhdepcg-BrPL7rVSjffO0j_LTa-D
X-Proofpoint-GUID: LLItKhdepcg-BrPL7rVSjffO0j_LTa-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'object' can return NULL if there is no socket-address, such as with a
file migration. Then the visitor code below fails and the test crashes.

Ignore and return NULL when socket-address is missing in the reply so
we don't break future tests that use a non-socket type.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b2a90469fb..fb7156f09a 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
     QObject *object;
 
     rsp = migrate_query(who);
+
+    if (!qdict_haskey(rsp, "socket-address")) {
+        return NULL;
+    }
     object = qdict_get(rsp, "socket-address");
 
     iv = qobject_input_visitor_new(object);
-- 
2.22.3


