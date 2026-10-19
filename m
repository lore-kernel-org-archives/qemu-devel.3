Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859CECCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm89-0000Qe-Ff; Mon, 19 Oct 2026 08:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7z-0000ET-HH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7r-00044a-Ue
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:04 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBnPVf3621740; Mon, 19 Oct 2026 05:05:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ScSUOPYT2VXd+Q6cH3/bep7d5eWaNHxgYFZkUb/8Z
 EU=; b=GTxpoa23rY2QKqWJW+wFFla1fUWhEa16jgEWLB0t5rxhydS+t2c22Ehef
 A4aMM+0vRZ7SrXFPshGtDPi67bSQ3YcEC1tu0senvfLVWmpUoMKIUch7d23wPBlE
 qYbYXuuLNZ62YMw+Z8DSHKuZzoSug1wh7bKAM/3qh49CPuEHfHJYhbSGnLYbfThT
 +l5MfvphorjUcVFGvt78VGLwYCFZGNH/9DhjiLn5kNsIi6M69xGALX/RWpumTEZC
 bY9+3x1M5Lah6t1iUpv/2Ep8o5Zm7zXsvc3xnyn5bq42oObW7qbjsMr6VU5SYXvd
 TVt28BOGQ/yoe4vDb4CcjpF/XDIvQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021097.outbound.protection.outlook.com
 [40.93.194.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdjnwr1es-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlpz/UFe+RdS0FR6oJmhnRPpDF16mf8F3dwCcMJ6jL0VMY+HrW9zfKDJsDQiKn3zSDCCP5QLEsClQ/t1wgh5gu2EANi0RMjvhkdp6wFdRBNsPA647n3ySki23jHnYEbY0kaTNXiZsN+bSl9iOy8F1Fn/YxUiut0PCq/sGKbpJWjPeBoc6nh1Q7skH5Dn+UnuEOHVcCAF32wTe80FJ0u5tIzzA3EOsLfk12kPsldDSI+H606XIZxWcGokNevOhoSBQSlmNS21X22rybn5Faw2IkkE2gFgGW7puSQnmlh0Ye2hod/0h+rhYFZ8haXk1tInAIIr89p0+6iHZsx0nQ/M7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScSUOPYT2VXd+Q6cH3/bep7d5eWaNHxgYFZkUb/8ZEU=;
 b=hoya9K247r3pUTkN+x0wOwgBRPQA6qRlOzxpA7SB/4TnO2MouETRvv7Shm5XaHaIKTWZ+8z1bRLnfvfAmf8gYUONEHemGP+fiDYfkMufiYcWoQIpNez3C2BGaCqXy3Yhh4U7wjjTBeO3EbZSqs9praGW07CJJC55niyUBro4LUqRkZM983wVwLOa5xx9ep0Wtyeg2WnQVMPhxvojEmV00BquAbBj6Jk7giYfknn6ux1rsGYta6XHmnBvdCesGSYoWQywTmk6Bcwz+G+7VNAUfT9Pr1JxospL30vrHVM0XrM734N0fHOJNLy8Sullj3LSg8u5VCeUbU4MwePc/1WpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScSUOPYT2VXd+Q6cH3/bep7d5eWaNHxgYFZkUb/8ZEU=;
 b=MTP0mSZOPLbKHG+gps3/QtpDpuJMRpAODV+tdkqBX28/2NYmejaCuVh3gOBHhIzik0lRvpClNfm+BODg/MR5GASoK5zwvsHPz6pp9zTUXZNDRZZVru16Sx0B+oHNxpSM8TfpKZAvZndcTG849wsvzMaouqa8GNbJ55jo1ySYUqiIgALpAuBtBI3OsDpOLSfhf+WoEvzUnA3hL4tzjBiHxjf3ctMByvuq+TAy00cZC4Rq0fEhbtQid6iDMTKmtElHgHYVKDApbQDul+u66g/4+kXKDskGqb7wb8ke97TLqDFrKJiqzBqThDtGTcQYcSP7x9kqckLqCNdlR6+hlTBN0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 09/28] kvm/i8259.c: introduce TYPE_KVM_I8259 device
Date: Mon, 19 Oct 2026 13:04:41 +0100
Message-ID: <20261019120517.1448687-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cd589f-830a-4862-a263-08df2dd9509d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: e1RDOhTkXSoqcDiqVrXCY+ss8VN/bfmXdsVYkCxMeAd4xb4ZeoCS4TPKUhzb/E83Kle784vTyoxngGs4DwOu3/O1Qm5haWhReNACqgn7T/uxjt1+JbmiLrMK+26/ddrUqgzNKttPGNPs5vApLUZ3Wxxb47EDJ9/Ka2A9SUpcOyG/ihmQxM2E7RBPzGxQrcX5qrLNYHfpCNB/TR2I4pfuHBntdZv61t/1yRkxov1nVIjKG9Xn9V6WkMRV8VpDNxIs8R9iWyx/BmsTve8+m7vwGAx2ERzRNlU7+aYyiOUUYNblQoREBLWAUSTyPkjwOfftSR+QTQrjCxIyj95N0w13cwcLvxc+kCr4a+0ge95nCMB+NZWXeBM4tw3oPhp1MdJuO88ZM3V2V5boOXVd8N6Ly5mOQOQP8RoESV3aXV3Jhbc6IOSjvnaLs/mNmg0Qi6NZ5+QOtqSjgc83zHO7ckT4ZnSokEo8f66YS100OXbtii58Jk32XO9Bpix35s1EB+PfaDyITz45yR9Kn/Ghdb0DcbQCd+gJnNXSEebcVt4MZAJtrQ5TrdqTMedjdaAW71X+TptwYXEQQoEAEyYow5ezYXZE4fm2+Kylng6GLXZ0WKX/HEK/AOBrA4zneyr+4H0vEY8JZPGxlSUO6f/uYHqCyypYS+A3Oghe4OIQspRuvEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KdVg2Ci7PmXXzDj/ijXcY4a54es9kmOVrI+lYdFcI0naY4/0Ns4O5Gk1h6Q1?=
 =?us-ascii?Q?ObO/FdPaEtm7eW2svKqYnz3VEjdv1j5Y77XlD+ckCR/ofJVcpMFkAmYYdy0T?=
 =?us-ascii?Q?3fuYME3Nho6rV+AHedjeBlQ8z6J7/TmXaPsPe2qTJoseOptyVQWCNue+ZEIm?=
 =?us-ascii?Q?Pbs5ryybaKBg3bbORlH5KZyM9yFn+zLq5Vlib+KBhC/lIYXoFWR16aj9k/z0?=
 =?us-ascii?Q?isMhPTTRjsl3hKGbLUlVUp5Z2F/lvMBniANEGYEhXbVkKuQgPSO5rJxn+pUy?=
 =?us-ascii?Q?9y9/I0u8F7CgVO+3oZiS2lHzEKhX/ZUn35OiA03CrOVuC+7MeSKcM5qaGcDJ?=
 =?us-ascii?Q?TINVgkT5bmeAHxuQgUC4o38+QH+Q2LGoiP8qPaKUgGaLLSEwBXneRY/N/fwo?=
 =?us-ascii?Q?aXqlJZM+e0m+h96+hbpYhAz5fhbulPKl1za7wBW8zcjWoqLD9FNpxwkrLGtE?=
 =?us-ascii?Q?/tAbsVtLeETiUsvBa1tJfixqqpXAFn4Ag4htHWWico3pWvdwA5NHpR1tCXPd?=
 =?us-ascii?Q?MM/hTCE4J5/wK/K0nHC5oGWSJfkzLVx0XVC6RzXQ9EljVMBQrLjUAyKXjCtK?=
 =?us-ascii?Q?+banBYbGSbvug+OSLcQNktW//o8A/svhhWZigtbJ/XQalVopPuuGO6uJsrIA?=
 =?us-ascii?Q?BTQZvKeG8qhfzEZsKge0T4XW3P+XZ/wrTLp8aHLeZIwePbhK1xzoMi6dJCMS?=
 =?us-ascii?Q?Gpa/rtH6Pff5bhNXfhwx4mW6xl9E4LNNCwjY6ennmrJwBYXij2oMSYOjHz9B?=
 =?us-ascii?Q?B3UF3B3fmAC+9R1pByOCKyY19Z6eYDng00liLd576qiQucSusII30dD/m6No?=
 =?us-ascii?Q?sN55oMrMOmeTfZB5ZI04daxboketVmPOpMzEgFU5QKLGAlmEUUIRfAZLgnx0?=
 =?us-ascii?Q?JmG0QPaolERwc+Cv3c6957quc+aBV6sgwu9aMzMKNeMj/uschEy1mjLdgNOH?=
 =?us-ascii?Q?0gexlR7q9kgB1MKSGdXhQtwkAfDtAMZkoAwDmLqEOywpODr1SYJ/WG/Z9FJR?=
 =?us-ascii?Q?n5228KrbeMTAtZVgKExBbm+8n16lSOV4mFqM3MLU9bY3ERCGRo6RAW0onWBk?=
 =?us-ascii?Q?exd04Fhjer+p5qUDvAtCkmZusygk0WDe6gytzhm3buQ5JBBykeqytFI0ZHx/?=
 =?us-ascii?Q?oKFgUczhRSu4SbaFUjAZw5faqOCMoMIsWzsWtXILYmFtW7uqljcuBTdY7upq?=
 =?us-ascii?Q?zJMog06gKcd5TrcxPDanwpfA0Xi6NOC3B0J8ZSjhtI56pQgi/wia31l4JG8/?=
 =?us-ascii?Q?nUhyHEGAak4fx4Cv2oRqtyVTVVZiQV2hhS3WtK3lKdhy6zRPaGF/QzmDpzOo?=
 =?us-ascii?Q?sVQITYnecYe8iIbnjSR9OnP5QKs2aCYnRfm9W3+zuMNs47v3pQtTCwRGKB38?=
 =?us-ascii?Q?jJJxb8TKwZP0QXfPMMirolyI7Iav9rd8anhyDFBilbHHrnB3w86k57DImMA/?=
 =?us-ascii?Q?Z4qqokATEhW0kzspj0xXL9Kst8mFHFXtLRc4L96Srs0kWNm60vj8BangjSdY?=
 =?us-ascii?Q?NZsoQDQuDV1hm9sOT85JLBwqW3tzz6MTcBkveky9uSH23ObtN/y5x3+ADf2B?=
 =?us-ascii?Q?IUN9cO7qnOZYlerWYUfjT5lMiOLnOhZJGaqf2xtriFOfLxW82GZNl3f5lV3v?=
 =?us-ascii?Q?s9Iut1wgrZxCEBJ7uUZQQBPcdnrUDNlOn5uk3p8JtmN3WBSMJ0VSn7W3Rg2Q?=
 =?us-ascii?Q?WlRF5H2X9uHfR9wulm7bL7DV32C1XIWDL38mVHShXnjGzh8jOTYi6PODswu4?=
 =?us-ascii?Q?UA6U+qQjRSaKYeePDdo7r4yoFRy+sFo=3D?=
X-Exchange-RoutingPolicyChecked: I2bJ9Ay16oOvbxnLC+/WVJtk6NK9VyV6gLSvcK9ga+4xOyN05PV1/bDmMzTwMdlqwmEdC6MhXoD5ikDVezse5zpY99B9+eCr3hYKrOA16zlrAdxiyOk8k3uuXYyEjG2dz+Fv1WkRdaVqfeecPS4Pl56o2u+ePaogt2/K4apmVSIh06jysIkVdUDSGtrtWKpqZv4o1EcaPOMscPzLb5SeW/jPR8GyCVdbirE/82rA7EXq/rkdsQMZthO8oR0rCgeoz/1SWAyWKTZK6EllRHhrOfpE53WyCvhsK/Y6hsY/j2s+Ks3q6CN4xWeAHQz7RJvClEfSNl44QIpAnfNd/s7Jmg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cd589f-830a-4862-a263-08df2dd9509d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:49.4515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZV83K/vTSF3iJzJcJGGmWSIkgm+EznVDzt4HSBNSMExwdeCflqJS/eqr9oWgiQXfw3dlcxcAxLkMoWMSPtfBpZ4LrDGYx1C55rxdjBET10U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6ad6079e cx=c_pps
 a=9OPjPng9tO6d8HsITUYRUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=lKrOaJ4ZLGcPJhkerdAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iRUqzQHItJ1qDvR5G3MT4hV9Pw78pJhf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX7oO6HjnoAiz3
 opHmYR6ScrbajuVTfrdFJx+tbAX/z+8l3Nh0pVp8xmZMpFNKExp0N7nctPp/Oli+oReXwiqngT4
 +1E54BFkOf281CtGgXnFi0y/tah7MC8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXx/AMR5cWogcj
 wYnY1ypxVQ0LgxHYhNqeUPcn/IknShRF+bPAgwsqPvfcY8zfomTXvh7RcOTPy+vYsOhmBDvUTz9
 BDP9/ty6jgWD6EXdpP1MHy73Hvg2b1e8SMwbbXh1YSt3lx3rUxDUKoMnu0dqS0sABRclMolzg0Z
 lJcRbTBrXjb25RWSi/a+aO/QkWQm2Z4lwFb+gkhKrDPGUZI6LZsIzPVb//eV+9mj921ErdeizI3
 kRfSuND1CR0BzG0DLufX56CSaJInuVG9F/yZZp48RuJHX0xDk0XP247ZKT8nGypgALnrjYQiOKk
 p6o1KsZIxpx5kdKh4SDa+rgd0GYstm+WarGTHJl4LE5r8ILsi/MsorCipi6au74eZJf3P0zGYKp
 pIHJImWw/bnh9Ywenyze4E934/iBJV+GSuHkBxWExQyqNyndbkpXCpO2LIi+eJV+gQgrzdeZR7+
 LTnMYR1pG4UrwLxytxA==
X-Proofpoint-GUID: iRUqzQHItJ1qDvR5G3MT4hV9Pw78pJhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This device represents a single KVM 8259 PIC and its associated class and
ensures that we can safely embed the device within a container device.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 85176dcf80..8ae5dd39b5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,9 +20,11 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMI8259Class KVMI8259Class;
-DECLARE_CLASS_CHECKERS(KVMI8259Class, KVM_I8259,
-                       TYPE_KVM_I8259)
+OBJECT_DECLARE_TYPE(KVMI8259State, KVMI8259Class, KVM_I8259)
+
+struct KVMI8259State {
+    I8259CommonState parent_obj;
+};
 
 /**
  * KVMI8259Class:
@@ -154,7 +156,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(I8259CommonState),
+    .instance_size = sizeof(KVMI8259State),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMI8259Class),
 };
-- 
2.43.0


