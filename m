Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF5C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpm-00085B-L1; Wed, 25 Jun 2025 15:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpf-000838-7v
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpd-0003uo-36
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:54 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEr5Z9008669;
 Wed, 25 Jun 2025 12:30:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kczgc2ZtSuPIBJchr98XRymjdmJ6lrkKDvrR3yOtV
 PY=; b=T1YSGNN/vFKvQRNllSJPquZb87zsnoJEa+FkaUlK+zuMnw0dep6XPIGZS
 ZYAAMxmk5zFv7MFDDpjJowN5GWGkRnP09Mq8mWEe1Kf6eTaObrPWcn66UJs1jeNp
 8oj94pouLlnt26gXW5CbpV9QVU/yZOZgSMClLWFUWcS23ydnab1R3RD9SptTXKOo
 m2bRhgw2eR3y5nqo4yb2eLC2NxxEKkLZuN4sGLsdL1+Pb9BGIC6LYI+rImv9BJeg
 RvTydhCkDrwPiHxTI1k/BCyFxprBu2cmgfc+DCvaQ/LOcJJbfo0OesydHe5gMO9k
 Pjuj6buwD53vb6rERfduKIPWW3FtQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2105.outbound.protection.outlook.com [40.107.100.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47g7uuj2e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk4Z2op4G1UGZqAExoPXME2YDiLAf8fdluX/77M1arosF4Czxja4/iBe6YV1txWmdzjUsMwKdrPLJOUbnayofx6UXLiu8acX8eCO5Ua2yFeNcGlzp3eghxuiTeN83yfdEFkg6a4BTeDqi50oMBSt+MdMvZl8/X9HHnq80zRQ1LH73Kgdr8TdP79cIQ64qXgxzjLMaru/zMhHpb5yPGiIp9o1Z5TMGC8RctPRfQ6d8l6cnnKu4i1ZMMeXLfPknhhMfO/e/ejmdA6fU06scGQIFmVcNyvyjzF9dzAoodRWYD/+TQQRG5ZC8x8jAFzcTEqhBousY+Lr0ZTx7zQdufS2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kczgc2ZtSuPIBJchr98XRymjdmJ6lrkKDvrR3yOtVPY=;
 b=GwTFjht+A4fuT/av1fVRENxUvPz6mtxS6lGV9Op8SbFsILJB0cDO3Md7SP+KugO7pmYDZ6om2aGymzW9E+guH73PDnoOR/ZDxgnPT9w+sZaKYhZas99f4FSM81Vdc9Z6mGeEokCQ929QOzFNDeLzEY0pW+0xJEfzysf0Ntdx6pQ15XapEOBBWEJCH3vZrVBULUZxKhFyOTViaNCY6YhehONba2O1sjpfv8M64j8JFH6ikxcKZgR0ahPJxWgE3oexkE3204KrgOorRaM1u6FbWI5ioO8JR8/hupVx3is3/xhhGI75sBbzEa9XFkAJ+OqFwV4E70Xzf+pSoTb436BgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kczgc2ZtSuPIBJchr98XRymjdmJ6lrkKDvrR3yOtVPY=;
 b=CgTrPI04K8i6HcKim/7HcOl9jne7krWXuJZ+AsgxlSk8mh4q/5riPRfAQEZTpbMEaxt4zPKuhiHdWT3nZvNc/z6WW3bbI9N/5+tYtehyRm0QInu+nSFUz4YTyRlG7sqkC+FnqV4gKfFvHYbg0ydsPeOMwVgpnlbSqkT530p9d4Fd0Byfns/DkmuCZV+5ksC7T7bddP8l9xuxr6cbAUbKNHE04TjZj8h0IRUgzWC1W0QEWvj+vDTbFqBWKnZjwlZHPKs/peS3+I6pqeR5jaK72pQ2Liz90dna2IzI7WFPKJSHYO/e32J0FYE5EfZmkaX9Jaq0N/1NRP/o1BimowwYYA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:47 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:47 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 11/19] vfio-user: set up container access to the proxy
Date: Wed, 25 Jun 2025 20:30:03 +0100
Message-ID: <20250625193012.2316242-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cebe217-4a01-4087-9dbb-08ddb41ec8e6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zmz3/YNW2Kd2HntTmt/6PEzph7MCgDB861tLqnW4LkhKZ16pMLdwIHz7KYOX?=
 =?us-ascii?Q?39mTtEqH3sQxU39QhPQpBGpyuDc4d3zVIu64helLpISP9l3SRr2FP3CP9cL9?=
 =?us-ascii?Q?FKYurz596pKLRnvW3OE84doSeknRNnb0NpvGfRwvFvPI+eI3+PfQQQTQQtMo?=
 =?us-ascii?Q?RhpfNzzZUEGVL6+Z0f1M5ObkBX9fEYiFE/KQkLcRPGJvAJT8C2PsdfAZKvlT?=
 =?us-ascii?Q?O7xDncMiqyf0ymvGaxk7EkO0LDCBZ7MlukC/tRyF1W80MicFfXebVdW/spv7?=
 =?us-ascii?Q?nsyzNLio4zMeX8yppz7ZCI+8bTRNXvD4QsMmryzrIP10zbUUfuycMDvWt5oS?=
 =?us-ascii?Q?Vy19OaZ9psU/LBshY8A/GlrTg76OiIONDf2Yu6ZhzxWv4gbP551p0sBTdEyZ?=
 =?us-ascii?Q?lwR4iLMhrR3grr4faAAnYSxccNC/W+PKliVeZhhG9dRMhuEQQsaZqYSyytsg?=
 =?us-ascii?Q?QAgocLCeT7qZ2cONlFTSLqNiHOlPV/sIrfhLvIrVL9bmyixpxBXS0tVI+t1O?=
 =?us-ascii?Q?P52MEYmMaJcdGdZGronqsmXuqcp1p7JzF4EKaTjDA3knFLR2kVa6sPNCvUhP?=
 =?us-ascii?Q?+hLksAnCdYv+CGLyXobdBwgpD9fWdtYjKjivZ8A4VNvS19a6xu2k+vHRKS9L?=
 =?us-ascii?Q?Glh/BVFazChhNibYWhdFdYK0CLzajZEZFvzH9CjfbyGPQD5B+MIm3JLYXRHI?=
 =?us-ascii?Q?a6KnJyPVCbsmEbt7abYMXhQSS5Q3rWcjWv8/SXwCzqzLGYP/aiuXJuO81Xkz?=
 =?us-ascii?Q?BSg+mocP0vKw5icQGPmI5IgHPZLGghgK1ix8n/Z08JRhJU6kXXDRWEKOdrTw?=
 =?us-ascii?Q?ExtwWRAxcmhTlUTbtC0p5waeYaA55+8lzOdbxR72vVljKW5WBqBxJz+qT0rE?=
 =?us-ascii?Q?b2gxyGfDrP7XycTWAvYj40Pq79kWtbLN2dV04TBlZqZMm9t++1nIOCRff7+O?=
 =?us-ascii?Q?PCJdev/qDjI7e8QYxNmYxHcJuAQqiOnI0Pw7UNJCZrQVGzI2jwNN2Qiy6ivq?=
 =?us-ascii?Q?fDSph8x/My8nf2d71JSo4YYPccspe9sIv7qytoeBjX/RFNpNwjRm8waKEp99?=
 =?us-ascii?Q?2owG+ggRFtqoJ+oEnfRE8/59fQC4PJiHLkKSidF3e2t4UoqICn+g0Y2S91Hf?=
 =?us-ascii?Q?vPU8yWz6q/bixd7AW060yg/3ghoP+peKaY9qMrbTnTaUZjqTCSqiJRB5t5kL?=
 =?us-ascii?Q?rxNV+vH5xFmo5Q9YOmU28vZ83ZbHSOPB9EnEhIlX18Eog8bfj/GtjFwkTMvh?=
 =?us-ascii?Q?maR7L+ahlCsw/862WaX1Oo2PO8pTWCr6wV0hLSXqaX+IE3k7hel7KUnbRQo4?=
 =?us-ascii?Q?QQ5VvMcMhXSrt7XWpRRSx/1CvrOQca1udYEH/qj1rwZ8n0UNDb1iR0cXP7YE?=
 =?us-ascii?Q?ydABDnY5AitKJmcVds9HStIIPTRLsMxeuVWj5Wht92tuZXYFOO+jZeJ8473O?=
 =?us-ascii?Q?j1cV6RJKTko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tIGZs33ibtG6BLdkAWOq86kthAqLD2+X5wJCu0BFfHQecW56cXmFtgFKjHm?=
 =?us-ascii?Q?zO8T9QKHDHspcni62vVpcb8lWpc0fToVv/Ct/JF3kP2DSHrdZpne0mJXoJTP?=
 =?us-ascii?Q?7SiygCEIfMcQ0IUYAQcYzFYdi/yBlJrlxawpOqOlmh76mPTknifdMlsb7FAo?=
 =?us-ascii?Q?AJVEklPsUc3eI+b6KDtriLwkhhLEQf+LRZCE3dHNUhKn/mn9gC/SGEXz7+BE?=
 =?us-ascii?Q?nkY2Hz9bZPaERSW2UCGAPR4q8xHnFYtHi0K9MBBzwlg1N9oYoctun3Zo8RGr?=
 =?us-ascii?Q?06qxiKlmHqhqfoCriiophajPgWjxPW5btXTP3aBfPj4POwtfA/QfmjyhgSeT?=
 =?us-ascii?Q?ZqVszDWexGwtuLtYsIchrjnuiiDkb8x6VIcvlBoNli/89mRvteVDUMzDe3Pv?=
 =?us-ascii?Q?l69+b+aaYzKSwXpo0nGO8LQEvl4gUlqhnupfwrTEFA3kbm3Vfnu3c2rKRxqM?=
 =?us-ascii?Q?ORl2uD+2JTeFkZ2dWk8iZTD0lGgmQ3z1Kxy8dyvh9FjHM0BPYW4Uk3jDm2DB?=
 =?us-ascii?Q?0HFli+r5SoMVer9BhRHA1eE3cSChT83d6J4v9WQOJHh7qzpkANJuIPkW56oM?=
 =?us-ascii?Q?CCAl2gilzNZjVzwNA0SC3OLXZK+c3+Z7iYPRku0VxAKYc1efo0WkdU6xdx+I?=
 =?us-ascii?Q?aIL78dCe/CTQb/BBzr2pkwP+hLxqZWHaAG5Q9tobe4IV2RE3xH94zWjU+xhE?=
 =?us-ascii?Q?M63BYq9OXlgd7hSMAaGRc1VnjHYN+045aQjjj7nO56iWZrWx3ffzSy/4OgiM?=
 =?us-ascii?Q?PNo4M/a2XqWeJfYIV0FE4b+uytfiMmXteQRg0+p1zQP7Xc6SkFEKU9ZfOi3L?=
 =?us-ascii?Q?22HzQfXLH0tSiWriXbjD7ANAEW3VU3SWvnhNy+j1jU+mKcCaLwuAyDipK4AL?=
 =?us-ascii?Q?Rf6TSU50KGcoHQcm7tfS4TAFj5HATrzkCAkMDHnMm7c6yV8xa8X0eeohknxl?=
 =?us-ascii?Q?8IXTn62wCslA3qqpoDO1cbVggKhaTk/jM1jhGQ5DTfF17I1oCXjzTTYpMHjO?=
 =?us-ascii?Q?Qn0/rXClDvj3SOCJbpFZMEH5LclrfVpvW2AyKZYnuK/d8U9DJ5i+xhqxyUKM?=
 =?us-ascii?Q?wqZ2QQj5/iyTFcAGrxDGPOLAqT0j9V9UoIdx6YjWimYiL6yMlyV8+aywk5tN?=
 =?us-ascii?Q?5Iy4TIpCpCEYAsED3qfFcmniJSJ3qAAty6FDNy8n1SZDDBzHFl4cuFt7fgEk?=
 =?us-ascii?Q?9mVYfpLsmSsRBV4IbezwzvLz2HKHr/q/7UYR9x76g6MySd9lRmuBtytBUogT?=
 =?us-ascii?Q?7cd5ZeEuNP9dfeKAYKZtSau/bNoNb6JRmivosgea8f4KM85asz4gZEh7NK3t?=
 =?us-ascii?Q?kUQ6pVPKsTOHdnU3T1HRWrdIOiX1RFYBpgygWWqqAExe0hjauczyLcx+HTSQ?=
 =?us-ascii?Q?iaGFnNnh70Xb6KGvndjaEdGquARMRb7i2wUEWQBV1bcKMaI7nHGyQvDpUS/1?=
 =?us-ascii?Q?k6e9lfAn5POCb8OVxzGAl6AMfZra1jT73ktvOzWbeSKD6G4sJUJixXfVERyZ?=
 =?us-ascii?Q?AQeBq1vaflWQIjRfV38TuO0XY+BigBg5Fw33eYx7txrOTFQibgyWJOLzlYDq?=
 =?us-ascii?Q?rIC1cIgIgix8i9ZXbdLCep9NRNu8edL5resJ69fB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cebe217-4a01-4087-9dbb-08ddb41ec8e6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:47.2764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ulSmE0Uc6IdrtNZLEu/0VXL53VMriphvPQFTI/UW7WFpm0Lfrefi+LGrKWdPL9VRT3+Xawf3sTUzWlSu+gvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=Xt36OUF9 c=1 sm=1 tr=0 ts=685c4e69 cx=c_pps
 a=HdAMwazFWLWhmZ51wATH9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=7VGmajfop4gqLxerqI0A:9
X-Proofpoint-ORIG-GUID: HO-bE-bsZIxwnCXHeUzXEzT0gmg5Q_f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX8PvEOpjMw5lk
 CvB1afz1vGUiwPs/KmdNkEfGK4JRS5ah7RXwduqK9QpzgqQZcrfaLpfEgAdy1BRrMRiFUV9qfpN
 v2pYB40wrpvLOQAnMM0r1z6NRVxBRfoTO3AYwa9oZPpOIPHjk3AIu1IElBw1VVfgyschBTg2ky2
 XOIvYcYCQdbnEgA7MV6ECDDO3HD3EzEMJdHgPjhq6QuoFhOVpWWqUxP47p21jxhQ/NawllRTXFZ
 Z5991yO1w/6kxPf/3uWE28dmRiS9LG4N9M3ZUevaAp7viA+v6Cw1tvsA4bA5M1RyU/+BSWyJ08A
 G1IuOHIeoX1uaeP9vQOngMgIgT+NQINqX/oaFnIbI17RpgFP8OwnOxI2X0cSKdfmbL+FufyD4Gh
 DkiQTJmobgb1jbx73y5+SF/W/mg5SgpPqSraEiT2hMHG799wxI7TBhHPuIdQGsXxphmsgE7P
X-Proofpoint-GUID: HO-bE-bsZIxwnCXHeUzXEzT0gmg5Q_f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.h |  2 ++
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index e4a46d2c1b..2bb1fa1343 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -10,10 +10,12 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index f5bfd54316..b4a5a840b0 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -49,15 +49,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_user_create_container(Error **errp)
+static VFIOUserContainer *vfio_user_create_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -65,16 +78,18 @@ static VFIOUserContainer *vfio_user_create_container(Error **errp)
  * Try to mirror vfio_container_connect() as much as possible.
  */
 static VFIOUserContainer *
-vfio_user_container_connect(AddressSpace *as, Error **errp)
+vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_address_space_get(as);
 
-    container = vfio_user_create_container(errp);
+    container = vfio_user_create_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -85,11 +100,17 @@ vfio_user_container_connect(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -108,6 +129,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -124,14 +148,15 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -163,7 +188,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_user_container_connect(as, errp);
+    container = vfio_user_container_connect(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
-- 
2.43.0


