Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F9AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOXS-0004XA-Jx; Tue, 20 May 2025 11:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXO-0004Ns-Rn
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOXL-0002n0-Oa
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7UjtW019012;
 Tue, 20 May 2025 08:05:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qQNvbELn+CJURy6I7NZxDvnMXKaa5p+lqDaQN9JIF
 eY=; b=VecJQbiEx1cDy458bi/ZJHDfcJUuIYjGmSeL7P8LK202Qj3K5Ar7tqYFI
 dm/aUWmhgBbpqjIyxMutGozDX68MPzGvSVt9HByZx8Q3WYqKEMTRBU/18SWAaXpx
 ZJzG5n+nWFitVj3cub8kdUslZVcmjCWpOfRdLXxbnN++8fN4VxskSpiaX6ZO9WW0
 rBe4B8VkJPAFR5CDsSvPbsWNqlYK0PJ096lvRwdyUyVbf0UqXXiL3vOcpttRjvn3
 BdTO924zAgEDs4MYKRM7Ff0jhYdx1j7so94ToGk+KZ2Buz265uUq2Bp5atvT9ZRg
 uYQztMNPdT3YiJncqNSdrDExP7s3w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46pshhec0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpiH2Fo82aTUT3CBYy7ulxpkDf8JESQsUpuFZKlAUJQcDbTPxEL7oJvgk9ttPJZ5zHZ8dV+BzTRomBXVjSWQs0Hg+hluzG5EM95RfBXf8vnXjgeYJrVIM4srkEz1/MdDZWI62c24i3ULwd5ONr57//Yig3fjX6L8/xJqxHbPmIN7SScSTxyBOt3dClIne6CTiJVJiOAUYpgdnoiFcQaiYN+bAzNSmlWo4FmZtzZPLvJgx1gsAKYlYIPly1p9cGJKyWYKacX46Ffm5Bv1ireaCkW7cgmCUmWITDMPSkxS6KNkcWPI3ELIETuMuCBtr5L9DI1knCFEQCnkJS4VFzYJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQNvbELn+CJURy6I7NZxDvnMXKaa5p+lqDaQN9JIFeY=;
 b=y9krikUHtKyIdlAneZObZXfYbBFOvR+Vm2h5SvEoeri66TLEOJyxO5wf9N0wNh41jFZpXnLHAsSA3tb7cqhydLuhOvkUnfvULibuxoXaERWofVfkw2Czglw0l1153QJpOkpJBhqtT1poEYnca8vCp7jRMKr1kZRd5Y15wF5OedGiw5dAsZNu684Pz+VdL51pBDZlabMZJZ2bdG6Rgr2notQibWqQ2ufRv5V7KhP06XFe4rHJppiWO2oMFEGOcHQP70fV+eRgAUA4Cxrgrp/Iju5LmbBZcjlfm0G5cnAfjSJSdIsqP1/eh4UfPObGoVm9d5H/GectjhtlvHSmUvLR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQNvbELn+CJURy6I7NZxDvnMXKaa5p+lqDaQN9JIFeY=;
 b=RKGnPYa4DaiI2AHtgeMbOqUVxitJRsRNrM066o/+gh+cPBTdecI1mnqH55ZLBZUM4zvL6wMy3lx5VnDPx6BatLtzQ508SMjOMuS0ZZgvio7DrJqKC4lvxqZJuB8oM6ClWq5XNMKNDoBVxKu1o7hIxN9OiuyARhxHLqCQ7ilWUCERA5P+bQTWVbCiE1VT1Q49M+rGVYlV0lLI6mB28dURkNqrnmZc0G7/qbspnIzX2Whm6FmzyKS5UidDJwdj8bu5ukbUMm3czrblVyyUaVnyGRf7a/KmVPMge3KZryK/FlV1Li5STsnYQVG6iYGP7iGGctmppJGABVhxyG8EnYzSiA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 27/29] vfio-user: support posted writes
Date: Tue, 20 May 2025 16:04:16 +0100
Message-ID: <20250520150419.2172078-28-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f855b4-bd67-48e4-c9e4-08dd97afc4a3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DVI4TS0XNf5W+1pjvJjyNvlrMs2RIo0dwDlyv5ed4UnrOr6sT3V+gYYW4XPC?=
 =?us-ascii?Q?VGMXBrnUGkhliJPdPz+ElpAQGLA/TB9f4vxIoojE6lplgliEWa1CNU4Xb42l?=
 =?us-ascii?Q?0GJSNg+Adgj4rfR2+G/9OPtIYu1vHbuVBoY2GguVVwarwk1MtTBBywobjyfx?=
 =?us-ascii?Q?QvqXKH+oj4sRg5vDUwoxHYTWsK5sJ7t3O8LWkUvS9gWdpf8n5FVCGZKHyiCC?=
 =?us-ascii?Q?DUT6QHrqSh0NqDVWN7rAHuQY9E9QWnBpIOatlym+YUd6g7t9MAcw1w2ZpuJp?=
 =?us-ascii?Q?A7ijqw1fOScL84ZTdJhlVwtwqv2BP+H8We1Ni8fbpB0cwx4IMZshzBKbyUwz?=
 =?us-ascii?Q?gQ+W1UYJjoZeB+m0/v55PdargN/tA6MAI3yzu+rXRNsngy7r1DR6SKdmO2nX?=
 =?us-ascii?Q?Wa9fhhyRO+wb9JH/kSSABE7Vv8WYh1id+LIhVQRoxlPUacncU0bTaDXlz/kU?=
 =?us-ascii?Q?/OUAiTtaRVS1WaOccYFqbUmRsUBf0LpwB1aIv1tcwycjw5Nk2FcJ8aj1Sprk?=
 =?us-ascii?Q?NEz4HffM9vCAamoWgDardeEtLheTd/L+2OG+dxgHUamLRgn3DS5rHmT0hkpO?=
 =?us-ascii?Q?IZSn1ETa8iAfkcBI0r+Blo55AG1Wos/Bjmt+U2a5S1vH+tkzpHLU854OSV3z?=
 =?us-ascii?Q?xmxEPY0EcWRds7VU3S7y4P3A0VkODYRmiZ80beu4fLN7ph+lkatOo8nD8RYZ?=
 =?us-ascii?Q?OgYZPKbkyLpHGyOkGw8u9eDAuTCnDVYa81VbXMaYmTCcfFsmEbG429dtILlE?=
 =?us-ascii?Q?aOgIcu86qIXHNKHlXiOaEtGTN+sV/9igUmW+/k7wVjMalEGdkAfeh32f9lxl?=
 =?us-ascii?Q?c5dZBmhLnzHKHdHU6QIxWEIxi8ruGiisTTQovyNixvlM5oJUT9GeDQriNN4G?=
 =?us-ascii?Q?oZQ75tTmK1At8SnWZ/e+5yCBcWLUI3c5lWSiSBACotGH6mdylH7Lb2zeIHck?=
 =?us-ascii?Q?yItFoyS/9jv5Hqc8OmJwZ9VuJa8QCbxsx5Q1SjDc42naprnjS3CjNp1p+yHl?=
 =?us-ascii?Q?fX6r/db0ATRe0CUv1AwsqHYmKtO72xqOJ4vqcGLUZMTQcudiqhwvDxZiWRkK?=
 =?us-ascii?Q?grKhv4Y4MXOQdbHJINaWWq/ay78gCfE34GijJAPUoHM4NovuJAAEs/4k4bj1?=
 =?us-ascii?Q?rrqBCgMBGkJ1yqyH0ZL/LD8mqP2cj5rZlNWIz6Pd6JBIinge+Oh7aF/3pPFh?=
 =?us-ascii?Q?wOPhTnmRw/vllcsQIWsEt8x1h9ERB6cTnqgk7xubsp4z5j+xbopQ/Fn/2ght?=
 =?us-ascii?Q?Py45Byvs37MVrgZXBZF9rOpH3hFA8dZspZ0j+HQfVC+S7jJgQbOSgjg7Reh+?=
 =?us-ascii?Q?phvZCYlEoHnrUROsBqepwmDsn08rBf1Wqk/8dd7y/76cAiDbI6rLKEz6qkk1?=
 =?us-ascii?Q?uxuhKzjpDggTl+YCHa+9oXSVDhQV6AwQ8zlBHJNq6cXHLDfeawtsZgOLhZAW?=
 =?us-ascii?Q?0vKM2Bqt4cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LsHNkJriTRLLfqL3JGWwHk7p5bMbDgOVUuRCetEd6nC3VOa0eiFuQUncr7Vj?=
 =?us-ascii?Q?K7Zj6IS9Kjrqp0qGQaU/sKv+PIzUqnbhKFi1cLlzaltnFkvLfj6Tr8BGA4AI?=
 =?us-ascii?Q?S3JCdDyaqEwzI2RxRe9FSw2XQq00de4ZPymdS/sPYRYLOfHDgCBjSU+nyJuP?=
 =?us-ascii?Q?mx+hOX4ijPh92PfFyS4OxvYyge8qkuzJ/+AdnLRSkqacndN/wqIDv3hkpM2m?=
 =?us-ascii?Q?DcR7Z6v57wil0LA3Ab1biDfjzG4OIH+3M+q6TJ1cTBBbP0vcdHmmqw40gHR5?=
 =?us-ascii?Q?0Akk8nBr51JgtwkOcmvn3HjRUUpV5HZR5v1gKqOmB2IuRVbNN4QrvZfAbKzF?=
 =?us-ascii?Q?HlPwoQc0kyDIsqouge7Io3U70oXZnW0U4IyPJO0cdOqSUMhOqUfF33A+XRVR?=
 =?us-ascii?Q?VWq4TmFeXakMNH8Z1Hmjm/RclIfKa3K2dlbenhYuCE4WT+f0XjdsMBn4JQZn?=
 =?us-ascii?Q?HUMAiZUkr5dz7Zjnwu/nn/KmSzrEdMeBfEd0So1vOomz8z5rhluxLELUsjOe?=
 =?us-ascii?Q?S9URw8b5tivaHQPg/dDOz17CV7BF50t/F8XK5ZS0/P60omONC0XpgTfB8Ueq?=
 =?us-ascii?Q?h/sqS9AQpyDUmitTSUNyUIhPZ1Sqz/M+qEWKMFIRrex+L3M4hAsDkFQVD+E+?=
 =?us-ascii?Q?IxukRxwNcY4JPD9Rg6VRVfqI9oHqc+53n1IoitHP1g6/HPmFNli24xhCQYgO?=
 =?us-ascii?Q?jf5O+AIvgsIAFtHpJbWMX17lWZRkj4Ck3D3Uei13Bt82Yf+zxQ9UdpoNu4NY?=
 =?us-ascii?Q?bjSxx9qH6DhO4PkAMjCR5UQA0iwpRrwZPLsPYFL4cTP7eUdGmOEhwXixyNi0?=
 =?us-ascii?Q?0A/Wjx3UNtjcPFZk7Akep/gL94SiOwSBNK+wH7B5G3l8ubQePezsnq2mfqY+?=
 =?us-ascii?Q?fh0n+aaGzRsdSw8zmQGwwX6xDJEojmTHrEMWaeLwsSiMv5ZBomxQjPp2RLL3?=
 =?us-ascii?Q?RdSMkhOWOTF8qAYnIznaeLTePsJMGDTSY5cUtrO9iT+GtFKrrAGJxeyPAUs7?=
 =?us-ascii?Q?r/ysVMQOPG/dPsjWaMdc0uuW/lONbgoCDUGvEejIPZSe4g6+0n2VN97l3e2f?=
 =?us-ascii?Q?Yh5waWWSXKsrnIf4J6AkSsxrAJ3x2wXmgGxCYx0n17qKnMNjljlfei9WdBdO?=
 =?us-ascii?Q?JXQxVqGiPMpMMP8f9wODrZ68dgy/Im7BE9Ygs3ANAhxqkVsg4sGmcl9r96Mf?=
 =?us-ascii?Q?ME05vUWir4Hf/bE9WJx2QEpPvBU8h4SU3hdNcB9r2EsjsZsSmnjc2VQaeVir?=
 =?us-ascii?Q?55wEa8MCzqoumN015Ev5dLtHR8gIBCobDV3N0q0NPAeBr0fmW5CqO5k9Rp9c?=
 =?us-ascii?Q?i3PwJiniJHs3Txoc/bbWyyQ+Cgxlx42+zYdOaXPPxHb7sbo2Z87NuJPVUpW7?=
 =?us-ascii?Q?fbsOuZTmwEnJgN7NQdQPpqjIt55yuPOUxVknEr4bWzFvJ14aUxSpjIHwSZk8?=
 =?us-ascii?Q?PhHFL+TqGwF2NZd+179gnsdJmSai/Dne/lS8d3sigWhmhfaUQE6kQI/EKC/2?=
 =?us-ascii?Q?GMsM3+0ehbMhNZEeVrIJbKMYWsTdlRKfc5WrVHorjdBrGuBw7O49qPPcnbRE?=
 =?us-ascii?Q?YE17UxQbPpROrr/Ik4gBdN7Uwc498Cz5x+FQ1dep?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f855b4-bd67-48e4-c9e4-08dd97afc4a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:33.2115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODDvHuGm0MXejgU9JDHQWqX2YWZSqsXbPyl+Y8tIPUP+BYSkvX39JlHWxQmeUB0JDzA8E3YqWOpdK51nqCmKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-GUID: qPbMGcG4-G-aReh04KIuTELHi_Ui8iYV
X-Authority-Analysis: v=2.4 cv=SoaQ6OO0 c=1 sm=1 tr=0 ts=682c9a3f cx=c_pps
 a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=hLZCMK2IaNhFlHKNMJgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfXxjyy2sQOvhxM
 INRYaCDpJJSSyzJrlhxdSwVjg6r8of658RG64MSo5lSfc8hKMcPU1uXqJPEqIwHKflOlSAgo5Z1
 ZsH8KzuohxfQOsfrZtJM8Q1YB5zggLAQq/0nWair7L18DUGKsx2Ur640t413VCATKjXU++JPTu3
 lryo/T7G5VIESUsaAk0LWbODxP/XdfeiPh9UQ7lLZnf0AJNE+QGsh62o4K9l3deBnWg7cSjjAM9
 QKHQtulj0UBk6bHvBTFc3AGgz/LJGI1KewE/0u1G62RXw8aCdZvC+RHkqEAO2XKMjrU4eaucK1M
 RsL1kxeYPdmO851CsZPbFoP8TkXzF6NUJCN76fJZpQfm6dhuPO+WpCe9EYdzxHJsaigPuGELn1C
 5Yq4KtLkgOQMMffWkz9Y2umx/3e0WZyqYucQZ97OhyuBUPhj0hR9OHn6EeMIiOo0dSGe+5Vw
X-Proofpoint-ORIG-GUID: qPbMGcG4-G-aReh04KIuTELHi_Ui8iYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Support an asynchronous send of a vfio-user socket message (no wait for
a reply) when the write is posted. This is only safe when no regions are
mappable by the VM. Add an option to explicitly disable this as well.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h  |  5 +++++
 hw/vfio-user/device.c | 37 ++++++++++++++++++++++++++++++++++---
 hw/vfio-user/pci.c    |  6 ++++++
 hw/vfio-user/proxy.c  | 12 ++++++++++--
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index da29674fdc..22ed66c54f 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -94,6 +94,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
@@ -107,6 +108,8 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
 
+void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
 void vfio_user_wait_reqs(VFIOUserProxy *proxy);
@@ -114,6 +117,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds);
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index b37f7329a1..eb2194c0eb 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -93,10 +93,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /*
+     * If at least one region is directly mapped into the VM, then we can no
+     * longer rely on the sequential nature of vfio-user request handling to
+     * ensure that posted writes are completed before a subsequent read. In this
+     * case, disable posted write support. This is a per-device property, not
+     * per-region.
+     */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        vfio_user_disable_posted_writes(proxy);
+    }
+
     return 0;
 }
 
-
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
@@ -272,6 +283,12 @@ static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
     return msgp->count;
 }
 
+/*
+ * If this is a posted write, and VFIO_PROXY_NO_POST is not set, then we are OK
+ * to send the write to the socket without waiting for the server's reply:
+ * a subsequent read (of any region) will not pass the posted write, as all
+ * messages are handled sequentially.
+ */
 static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
                                             off_t off, unsigned count,
                                             void *data, bool post)
@@ -279,21 +296,35 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    int flags = 0;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    if (post) {
+        flags |= VFIO_USER_NO_REPLY;
+    }
+
     msgp = g_malloc0(size);
-    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
     msgp->region = index;
     msgp->count = count;
     memcpy(&msgp->data, data, count);
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
-    /* Ignore post: all writes are synchronous/non-posted. */
+    /* async send will free msg after it's sent */
+    if (post) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
     vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
     if (msgp->hdr.flags & VFIO_USER_ERROR) {
         ret = -msgp->hdr.error_reply;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e89400ba03..07fa340c17 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,7 @@ struct VFIOUserPCIDevice {
     char *sock_name;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
+    bool no_post;       /* all region writes are sync */
 };
 
 /*
@@ -255,6 +256,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+
     /* user specified or 5 sec default */
     proxy->wait_time = udev->wait_time;
 
@@ -392,6 +397,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 74cfaff6fa..13f2407845 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -683,8 +683,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 /*
  * async send - msg can be queued, but will be freed when sent
  */
-static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                 VFIOUserFDs *fds)
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -805,6 +805,14 @@ void vfio_user_putfds(VFIOUserMsg *msg)
     msg->fds = NULL;
 }
 
+void
+vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
+{
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+         proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


