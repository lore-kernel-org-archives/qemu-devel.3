Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC82C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqSs-0004Ci-GX; Thu, 11 Jul 2024 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sRqSo-0004BX-O8; Thu, 11 Jul 2024 05:51:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sRqSl-0006Rx-3i; Thu, 11 Jul 2024 05:51:46 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AN9Emw020078;
 Thu, 11 Jul 2024 02:51:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=d3EDSDWfj/PCe
 38yPw8As3Q2MJScxtFclBn82o3xhz8=; b=on3NCFAgYoO61uz3bnkcNH+7Wwa+7
 fvtl1g3+P4dLFAjEQyvTrAddg0rMzKiGPuB3bqUF3fb1V2wGxI/wL0YgYt8z6kj9
 tPo+XcWkQ/Bdf1B216s3Ug6HZXPZ0AgRBUbMZAaPCLd7odYnZc9di3S4tiS8FFIE
 YgoLt73wCDvdVU2vdD8DPIJZiDkGqwU2PTm6TFaeX+++aH838kGo+sCUuSgg6+4C
 DIpQtVaxVGLFqo64p2eS71JSgDXQH1R/DcVLKMS2Ny4o8gpAoBa/XZuyRQfR93gP
 x0NqOF9eENlFBkEUlfAOdPoD0qcQuIPs+iKb6mJ2efj8Q01TPCRYTayIQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40728tua1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 02:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzyKdfEStuBwUkAyuowXw1OYwhsnNphxhivFn4T25LCFDXCl3WYtvfEikXbSTY0LQLtJualNbKLC9jYEOTBZsWq9gyTOYgM6X0MBVSzf6H64gZmFOAUU4PIAjLdpqdXNGMoCQstcBytQCpeubJ6HmUooTzAilSuI5Tq26MnXVZg75e9hfZ2lqSSNaFbxO4aSgFSCyWE9X+4yMrVSw8VGFxwd6Aii2eZV6uq6mT7+bJ8ZASqBkFWGxkbLluXe4UVbA6CtjMtvUSYGGvg7Rpv8kGZ8BKQ6MZ9QG+AYCkEgSxde02uk/jZtW0Xo6hLXESbrvu8Hv3VUrYyTmIEFs1kwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3EDSDWfj/PCe38yPw8As3Q2MJScxtFclBn82o3xhz8=;
 b=nA/6wILuPZ/w9YivPoSuZHdSycRTYssXLtwSPcFP+3wG/GSdYyJEwgnSbwIOeS8PU0BAyr9hxLRkcKbdcOS89zED6fJINKdvii2ppCr8HXBifQH7ApNwGRXB/dmHDsdLS+VLNj34t0PVFgBRhKPvQcoh/9uZqFxP7BVtk/hBbT+TFuQAWq5Ylk5ek23OXNe3DFNkOyUHfHxs0tabYNolv7iqabiSnady2GF439ajzeQQcwmRvOavPjAyydCct3SCE3/aSUHbd8kkAewoRvBd+STLS2XCuOKI0MmlQv50FibXIMjIPfLmiKSwZiTdmqbtFQhw5PBjQ+UBofi1PuRhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3EDSDWfj/PCe38yPw8As3Q2MJScxtFclBn82o3xhz8=;
 b=xR2Cv+lnosPkxhxURFBF7hVoBItNehKFo9wXfACwVyWQXq5xlK1BIztD1NJKF4PW5rSRr3AuH9P+nEdieugMkHu+s2274xeRRVGaPSd2XoBPz1AtTNB2MxEHfFsE7dFsz1rAe6MBKLBHApZeSRniRoD5gg43FfS/oF4L5Z6fZ7jF/Ekk6snPmLXF6WqjIqrPVJaotdgWL7LMn/JksZibDSSXtuB2z8ACvlvr1/euUwMdy7T5pdjb6cMTA9ifPjE9LbS58VqvN8TfdVZKV9P8LZbXTLPx3oqaoDlXiz5yvINdq5lVMsp0cfrphWX4K91htlw/CMTo7H1ulyskMS8Ydw==
Received: from DS0PR02MB9101.namprd02.prod.outlook.com (2603:10b6:8:137::22)
 by DS0PR02MB9269.namprd02.prod.outlook.com (2603:10b6:8:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 09:51:33 +0000
Received: from DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3]) by DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 09:51:32 +0000
From: Sergey Dyasli <sergey.dyasli@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Sergey Dyasli <sergey.dyasli@nutanix.com>
Subject: [PATCH] chardev: add a mutex to protect IOWatchPoll::src
Date: Thu, 11 Jul 2024 09:51:06 +0000
Message-Id: <20240711095106.185377-1-sergey.dyasli@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To DS0PR02MB9101.namprd02.prod.outlook.com
 (2603:10b6:8:137::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR02MB9101:EE_|DS0PR02MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bec416-9015-4ba6-de55-08dca18f0baf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pAvfWvJL/Q0HPnRAH2EpHseHg/6buHJ6xjE1P8LffSD75Fs29CTyb04ClCau?=
 =?us-ascii?Q?v/kvjmmqJu4zBuix1TFv9dx1XuEw1/DiSbt5E6yYg2xKtsnGAsa3UwG0Rwrw?=
 =?us-ascii?Q?7fwdbxRmQXJ/flJfFRV7dSaEmTmYL3Qc/B2uYvBogIQnovX77NZjx6hF1ugd?=
 =?us-ascii?Q?dOX7WBmnx8u7LT4R6/WGFBCrUnz7Oe5oxmsPQqcggbrWLlRL+NYIUkf8CYPC?=
 =?us-ascii?Q?LN/GMANMA7S00pC9fk2y+xjN+i6ufTFeQLyeV935oWvfCCnStmyWOWJ04cKW?=
 =?us-ascii?Q?CvSXj9Z6oqhS9rLFNzoMe6w/V3BzHDUTLn+CLmnHB09hT1E2Y6HeDYNWP4OS?=
 =?us-ascii?Q?b4OaZ35Jbb4m2C6uEO23woIbmdNsrZHIxpN4hXry2lRv3cySasX3csN2XdSt?=
 =?us-ascii?Q?JFTKe47a8uYIJB34esNK04nZ7XOcXSwr2pbKnZIMhW3gShFDNXKV7hit0+Br?=
 =?us-ascii?Q?LFGOEYMUuXCSPIbr6OSgggqHl+RO8btoRyTOHOJbCtQpPdO1gT5YCW3SGYTR?=
 =?us-ascii?Q?KtOv/s3fzsF1XeBq2YljbrMwZb5YzqcA809CLtxVf0gEQEuKLd/KK4glJLDM?=
 =?us-ascii?Q?yogSHxpgLHIf85O0FZRiNTjrxY1otFPCu7Ycb3LZEXIHp9AVkWnfkWmm5mwb?=
 =?us-ascii?Q?0yGMPWyb/0rijUF0Ih5ds1gQAvLaHtU10c/czuCKf/+QaOdrzyXLQrZ8Z2BS?=
 =?us-ascii?Q?WIbInq9ES6nf32aBSe2WMK2Es60IlB4gn+UCNrlhDYoZ3CDxKKSMRZT6KYv3?=
 =?us-ascii?Q?Rhzw8lRf5kbcAw1rsTEY1Gpa3q1r+yf1PpjlX21UzGTYY5wqTdYkQS50J2vz?=
 =?us-ascii?Q?KLGta8uxKMFDt793hDmS40yqPYnefGzY+84e/x0uNVgcQ49UnXahf01fDxgQ?=
 =?us-ascii?Q?oI6MtfWjs3vXK4jbZqrMkNNY2LJlz+ZMviAXm93HB/CeLmADV7YVPLe38GoE?=
 =?us-ascii?Q?o5AEre2qD5bQJSMecre9Zect2/GDDdadngzJ+UdCTGiiQz5WBdoN2LeByfRO?=
 =?us-ascii?Q?p9DpN1fg2+m0rQrlhv40plkTG7X3zELGuc34cHYPMxX4Epo3JutKFT8hD9LG?=
 =?us-ascii?Q?R9TDHVJaSK9oZF8WYQHoQ2PGZEt+qQzzrQma5elyqb0fupHPYL4D/50ZygaX?=
 =?us-ascii?Q?6hU8mNiWcw9oSEyaema/YqoHWKxJnVPpRTYkn26OgkEBGEmcqPEzQJxNBFWB?=
 =?us-ascii?Q?hrBIDVCivOor+jtNmlfQqPGym1fuPADFv7RMfIOyEFAipJxDHHfnaTlBudLu?=
 =?us-ascii?Q?p3c2XS2rSuUUojmKD6sAv05uBgCFrsFq/59jZWjCFdPoIFE6T49Cw3+xW74x?=
 =?us-ascii?Q?xY7OJIgbHFJbMT/goE1bZGtj70EiAcbiejfDBkB2iyF89dQMjrN+7wgbEhn8?=
 =?us-ascii?Q?XKS5yk3u7UrhtxAVgl/S4h+ub1FlWH9RdTTbfUP7CajNk9fQlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9101.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOkhAzbZOBO9E1S8RQ84Y9H3HfqPqWC2z1kRCkauHjM4wIDXrbLD8CWuuCks?=
 =?us-ascii?Q?lLiyBgNSHWvhn7OpKGwEKRj8GOSA2pA/PDqoguGwzh8ptQVpdgsOEjLCiIKs?=
 =?us-ascii?Q?7cN1F0t+q9hwWwS/9vLPnOQ5J1LK7n4UIuelVyByiUiA1ZiS2Uf/84dGhliU?=
 =?us-ascii?Q?/QTWTPdUnR0qx33nlWVfcz9bcNO6T8emmP48asZwqRUq1olDsLD2xeaLwSiW?=
 =?us-ascii?Q?eCqX3wd8Q+hlm82B+Bs917jvdA6Y4u4XqUZLDR5Bf7h3kEOfEwukYqqv47MY?=
 =?us-ascii?Q?j3C/54SYJae+1Hoy03LCsHnQqCw8zTtORXPkyRM0wpD69jy3gJheknVWFyXP?=
 =?us-ascii?Q?tQaLxRu574jpJBiggIa0QuWqobvl8tKILu/l5i77GtOv5zAmBLbfjeVSXCMx?=
 =?us-ascii?Q?J/rNiM9VaUYBGsJpoJcLXhFe+VcYjkSuhbqhwyBFlwgtpBKpihKwe4EAhKqB?=
 =?us-ascii?Q?TkjiCSJgCQ7MRDNzAhRnhWYP39bptXhqLHAr0lQvUS3W2wydUf8NhoAZCoxG?=
 =?us-ascii?Q?dyM4yOtG3IXqdMmD6sHJJEOdBAzM3uIBhPxsDi5bIrc3Fs1u6DS7xiZO/+yH?=
 =?us-ascii?Q?ll4oAchswMnS6CtWprWeRX+nMfVAbrznmE9IHjVEoYV87yELOSp+0XIKEyu9?=
 =?us-ascii?Q?klbGAUaLDcJK978XYpBxZVBixqiBiBMOEJ7nzgJqT590E/zK3Wk+Ia5wTGKY?=
 =?us-ascii?Q?rJz4GroMPyOzkiI7q6iEzVt0k1gBnXB7j5jgpllKzj42b1tc3g11zXKhE3mR?=
 =?us-ascii?Q?qsw1pEZtDxQn2BMMXzoMhFOKWllQHjOePl730g662nO+lK+ASbrDHmvthuaN?=
 =?us-ascii?Q?pP9nVpb1UInUlGGZYautzQ53dxfafr7Y19fwTNLZXnK2fmvYDADNZNVmHkG/?=
 =?us-ascii?Q?F+08I3DIlT4+/VLEGl9iT7I43iLI+PBKM1nFsIaWCC9UvcLHOTm9j2un/3t2?=
 =?us-ascii?Q?O0hQ10uZLIxRVdkXatCsxpsLWutUVHsBe9W2sijk7kp7CF9rmh1L3v140Y8V?=
 =?us-ascii?Q?8leBhyfUTradGr17sYOGnU1NRH6YVkMimd1w3IqSnvmMev2KtuRgvg4Ud6N2?=
 =?us-ascii?Q?1hSjK5LQmMoSpOH0MY6tltyaDJrikwW+TLX4MH4EOPXcwhRs/k2pJldLgQZL?=
 =?us-ascii?Q?Eal9s5hS1wl+muFCxVxMi5Ia3tPQ01uyLPCRugOQ3dZV+7K/P2XO7XatOvDL?=
 =?us-ascii?Q?aRYz3TZFipOzxOiJZfWkYnBuHMIpVndYARVMhGrQPdkVEqLCr0BKrUuNJkv0?=
 =?us-ascii?Q?ku3+/6lDdVMChhG6o0u69LIpbwtt9L1E9LlSa2aEodrpp90P+ocKSL1jGJ/L?=
 =?us-ascii?Q?4Euwq6EFPzbJof+FOJUeO5aREwaVwFevY9SZBpl02qSkMfdwnizz5ibwpwjv?=
 =?us-ascii?Q?7/xay6c2x9t6PSsN7m/7PhlF0N6wOL19k4tTAjCQadysLMjvUvL5F8FwMbbs?=
 =?us-ascii?Q?iav4z3QW1MSLB5WGB+op1hW609K1BYVDE7huEI8glJn/fWoaBtEgOgn4ys4o?=
 =?us-ascii?Q?20hwsh0Es0pJWHaS3H3fAabiU/OWx6a8QLBQOGmxMZJxBSS4keEfRimNp+4p?=
 =?us-ascii?Q?G1DZgcn+Yil9zf1QfUm6gOIBaLOvV/Rs8KE0zgIO6ZiA5zh28xwXARgl2Im0?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bec416-9015-4ba6-de55-08dca18f0baf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9101.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:51:32.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9LhrtXQ5bA19IdXc85gSZadPxOoKvbdvWYcWWHZImTz9XtmoCBdS1bh0byPGZd89g3Dfqp/cpqE8iupomq5H6jkcsFrIpY9sXhBVdtaoDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9269
X-Proofpoint-ORIG-GUID: 2JHEgJ6XarSPLge7p-ItcVBB4ui3Q2U9
X-Proofpoint-GUID: 2JHEgJ6XarSPLge7p-ItcVBB4ui3Q2U9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=sergey.dyasli@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After 038b4217884c ("Revert "chardev: use a child source for qio input
source"") we've been observing the "iwp->src == NULL" assertion
triggering periodically during the initial capabilities querying by
libvirtd. One of possible backtraces:

Thread 1 (Thread 0x7f16cd4f0700 (LWP 43858)):
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
1  0x00007f16c6c21e65 in __GI_abort () at abort.c:79
2  0x00007f16c6c21d39 in __assert_fail_base  at assert.c:92
3  0x00007f16c6c46e86 in __GI___assert_fail (assertion=assertion@entry=0x562e9bcdaadd "iwp->src == NULL", file=file@entry=0x562e9bcdaac8 "../chardev/char-io.c", line=line@entry=99, function=function@entry=0x562e9bcdab10 <__PRETTY_FUNCTION__.20549> "io_watch_poll_finalize") at assert.c:101
4  0x0000562e9ba20c2c in io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:99
5  io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:88
6  0x00007f16c904aae0 in g_source_unref_internal () from /lib64/libglib-2.0.so.0
7  0x00007f16c904baf9 in g_source_destroy_internal () from /lib64/libglib-2.0.so.0
8  0x0000562e9ba20db0 in io_remove_watch_poll (source=0x562e9d6720b0) at ../chardev/char-io.c:147
9  remove_fd_in_watch (chr=chr@entry=0x562e9d5f3800) at ../chardev/char-io.c:153
10 0x0000562e9ba23ffb in update_ioc_handlers (s=0x562e9d5f3800) at ../chardev/char-socket.c:592
11 0x0000562e9ba2072f in qemu_chr_fe_set_handlers_full at ../chardev/char-fe.c:279
12 0x0000562e9ba207a9 in qemu_chr_fe_set_handlers at ../chardev/char-fe.c:304
13 0x0000562e9ba2ca75 in monitor_qmp_setup_handlers_bh (opaque=0x562e9d4c2c60) at ../monitor/qmp.c:509
14 0x0000562e9bb6222e in aio_bh_poll (ctx=ctx@entry=0x562e9d4c2f20) at ../util/async.c:216
15 0x0000562e9bb4de0a in aio_poll (ctx=0x562e9d4c2f20, blocking=blocking@entry=true) at ../util/aio-posix.c:722
16 0x0000562e9b99dfaa in iothread_run (opaque=0x562e9d4c26f0) at ../iothread.c:63
17 0x0000562e9bb505a4 in qemu_thread_start (args=0x562e9d4c7ea0) at ../util/qemu-thread-posix.c:543
18 0x00007f16c70081ca in start_thread (arg=<optimized out>) at pthread_create.c:479
19 0x00007f16c6c398d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

io_remove_watch_poll(), which makes sure that iwp->src is NULL, calls
g_source_destroy() which finds that iwp->src is not NULL in the finalize
callback. This can only happen if another thread has managed to trigger
io_watch_poll_prepare() callback in the meantime.

Introduce a mutex and a boolean variable to prevent other threads
creating a watch in io_watch_poll_prepare() in case that the IOWatchPoll
itself is about to get destroyed.

Signed-off-by: Sergey Dyasli <sergey.dyasli@nutanix.com>
---
 chardev/char-io.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index dab77b112e35..b1edccf0cc85 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -34,6 +34,9 @@ typedef struct IOWatchPoll {
     GSourceFunc fd_read;
     void *opaque;
     GMainContext *context;
+
+    QemuMutex mut;
+    bool dead;
 } IOWatchPoll;
 
 static IOWatchPoll *io_watch_poll_from_source(GSource *source)
@@ -62,10 +65,20 @@ static gboolean io_watch_poll_prepare(GSource *source,
      * more data.
      */
     if (now_active) {
+        qemu_mutex_lock(&iwp->mut);
+
+        /* Don't create a watch if we are about to be destroyed. */
+        if (iwp->dead) {
+            qemu_mutex_unlock(&iwp->mut);
+            return FALSE;
+        }
+
         iwp->src = qio_channel_create_watch(
             iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
         g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL);
         g_source_attach(iwp->src, iwp->context);
+
+        qemu_mutex_unlock(&iwp->mut);
     } else {
         g_source_destroy(iwp->src);
         g_source_unref(iwp->src);
@@ -97,6 +110,7 @@ static void io_watch_poll_finalize(GSource *source)
      */
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
     assert(iwp->src == NULL);
+    qemu_mutex_destroy(&iwp->mut);
 }
 
 static GSourceFuncs io_watch_poll_funcs = {
@@ -124,6 +138,8 @@ GSource *io_add_watch_poll(Chardev *chr,
     iwp->fd_read = (GSourceFunc) fd_read;
     iwp->src = NULL;
     iwp->context = context;
+    qemu_mutex_init(&iwp->mut);
+    iwp->dead = false;
 
     name = g_strdup_printf("chardev-iowatch-%s", chr->label);
     g_source_set_name((GSource *)iwp, name);
@@ -139,11 +155,16 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
 
     iwp = io_watch_poll_from_source(source);
+
+    qemu_mutex_lock(&iwp->mut);
+    iwp->dead = true;
     if (iwp->src) {
         g_source_destroy(iwp->src);
         g_source_unref(iwp->src);
         iwp->src = NULL;
     }
+    qemu_mutex_unlock(&iwp->mut);
+
     g_source_destroy(&iwp->parent);
 }
 
-- 
2.22.3


