Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C366EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVW-00080T-IC; Tue, 03 Mar 2026 08:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPVK-0007Vt-3d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:38 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPVF-0000OD-03
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azQmfeaOfq2omF4EMhmJVlr9hd4iUW4Y7F834VaUc/euRC6qT2nV2lLFDpJvqePNexKotVAsKMfUe4Y/z0sjVzqpD6ab8YCsqaE5ApBiaSZgznDCryHkC8955kpwQwAB8a2YDrxlwxW47jgvOnab8O+pq4gwIhzNqOxfBQTPGIeYUlIsnTjym1jO1ShyJL1It7PV7zQi23PwRgVGTTxMcEgxDS5uRVjHkSaNZHwx1WWejrWHLohlaJ34hKa0q9xVPAvgyMqB5iBaYBA3VMpOBKU9M4AwV1xOwPl8t8EK5KgilUke2vDspwxfLXnfssV8kTm2mId+d1TuTDlY7L4EUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBrS7xkMX1n+psOQBGfxkii6J2QBN6t7Zytp3wmugQE=;
 b=HXOpw5zN5Y2j2eA6YwLtN8QuDTVuIWeR+SKUduLifWZ4pu4kFa5W2VwmDqwbr7ARTerobi9Y5aE81JwCSbflPBv9Jk+Da4dO+Jmq2c5Ks0rQcJBSUKX9waO6KY6Nq7IEX+wX6zAMqaHfN6UdPcy0nyU9gutueCu0BiqVIBUdhldWxQfrc0834SyvALXXLrycyg0iMIHq0qJbR/4zXJ4fzsvSlgV3mCQdKxJOLO8KWTwdEiTkGhPNh6bULWepQG9f0hlsNBJ9huRgZl6IIuUwociaHEpt+VPCu4esDpp+1WuXICIVvsDAIVaY8Pv4hUJ+GgPsMJF/m2Fl5GiGTMsdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBrS7xkMX1n+psOQBGfxkii6J2QBN6t7Zytp3wmugQE=;
 b=pBH+Bpd0VkDdwbwKSkUC4Pt+2q/ZM0JRX4jQ5ffNq/XjaX7xWtSfxr6PrZifWerWV1Bo9l351TbIAvvfVkQM3YnhtVVobGls/GB59iCMtQAcBpxYifGrPfQpJ8MBnAIhIn0Al54mRj76sgzEjRnL36xohL3t/DVCJ8P/M25Wmoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB0984.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:44 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:44 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 3/7] plugins: add PC diversion API function
Date: Tue,  3 Mar 2026 14:07:29 +0100
Message-ID: <20260303-setpc-v5-v6-3-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=Cn1jLD9UmX0euaybTKaylQPlplFF+Eg1gh0I1CCp4hI=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1i46GdbJeC2twr1LV9lzn0tf0pr9ghyGwpu
 64EFKNykYCJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9YgAKCRCW6ye6MV/H
 fCSbD/4ziwTtqCcfBJFDa6CsDWbAeqGnqW46XJpbF6dOAvgZF819LSKFMrREr+jaLaRZMRb+QGG
 RAV8EZn83+BPXoo6hRXHjRdD3KtReq9usjGXpBJKfmCLTvdFBnX6IWg5eA/6d85txhdswuPsE6B
 Op6GslOqztiFxTdYp6VH7g2sFYbEN+ACGL5lm5jBd34YV0HDCwJ8A17uk7iRpJSNb6f4qtMTi7N
 rCBtXDbyFjls9dECm6084yTAy+OpIeUMZyx7gELPZySR3yld3BkK6sMbkZtFm1k2CCb2J9ktzie
 gSXVw0LND7KvPAvC2z4UUibXe4dNhCixSp2Hcn9wI/2kOPFB3zU5dt2n2+TfgVA6m4x/YT5yZSX
 IkrIZ+laoWwVIe5FVsi4xpUENgKpPcrxnmhge4KA9E6oxhFc+VPFBi1qGYA+sSgaUsQyD1H+4ci
 nOUwFBQBa1Kh5unIBTbgamTSVCX2XwWOplnYR/0nP1/EThx5jTn7mfq4iLNjdToBNb3RuxgiV0J
 jdRx2UWyoExfjrtfDVZdI7qy5/E9Z1+Ys8MEJAm7+4zPEJY2vux55pye4yCJr9wMlsXy9Yt1IPC
 VcCpbnTCQSKqTgc1PNfCSSsescIA2lxkkVrw2DDVm91WEuNFXhhbMio6aVzwPx9jxDACZSu5Snm
 UO6h+213a4x2A0Q==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1fabc6-2bcc-40ec-9a79-08de7925ffde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: 1mUodNvrXsRrUgm3ldX+y5D6tj4ptmSCFbmrTb6qNHlyeg2+Inefgo5jmhjUWBbaXenWBkUNRoSdAESlRALDL38jauEbUpVridqdCqjiz/hA3kaR1iE+bKzyz5PSoYT6r3q1CGdL18S5ZSpT7VYsvnGuCF69VYzrye2huZncVmMH3FjhyRm5CsHHl8ehTZrztxRl+GkjuMYuHNGejSr0/wWnc/cpCS7/H5gUbgJgENl473rUlKw717DvEkowFfJS2GGDq9Jtn4EF5RikkHhve1sQ1Xa7mPv0GoOarSWhfkeQc+IoYTIcUzFvvN45AzI3+t+PVUo4skEqzLFSInEPhCFDApA82CgLBWAZvR1vsm9QBHidVfQ8x0DHNPeL1x5AYLU5/z3rTKS3TrdOs8BjG2JL3kcVgr0dRZBm4MfPf1pRxxlZry9EmLKBdM8Qa0dZ33kgLeVqudb88QX6iBpMlMPTKNPGrbEPKKUvEeee4/lGnPkQ8CyAnwY3mWX1LVNSgFvCN0rbKsk/zusEfdpDSSw9WI/HezWWUK/Tr2sBdeln0DBKkdYhryAd7K7zQQOjIUaIzaYRYY1/OgKW/okqjMDMY5Jg5D7RaB/JIJItDFiUULl0wWvRU0yzizrDmLZCkLV/h/HneSBW2EuHKToUsmz1hB/HW5N4mnrJUqhR3xjr0eWSHl6biVZu0ecC8uMAQmMKUA3N98uJFZPWx2+AcqQOSwPoIxamOy2/2Ei2+ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(19092799006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXEzcURkWm1BcXU1VEtuVWUrK0JYblJ6VlZhd1ZJMUJuMDNuOWQxeWtDeFVl?=
 =?utf-8?B?SGROUVVNclo4M2RLczZ1WXRiZ2VCMUtrVERjYW9kZTRzMG1INFpQbkx3UjA2?=
 =?utf-8?B?NzNTWFdoUXZoakRldUFCcDJ4NzJ1RU4zZTRzb25CTmkvY2FtQ3d6YmVYN1Jz?=
 =?utf-8?B?SE9jNzRIeE9PRjZUbjUzWUlKdm1VRzNNVW52a090VkxJblQ0M0hoRFI3VFYz?=
 =?utf-8?B?V21MR25sdzlWaC9JVDhQdjBCcDUrY3BjMjY4L1dGWTVKVzBGb3dxdnhZUUxq?=
 =?utf-8?B?WlN2eEhwZ3JSZU44em5DdnNhNFE2RjFFQ3N6bXRqc295aEhZdU9XYTcvSng4?=
 =?utf-8?B?YzNydkQrdUJyUjlvYThVNXZIYTRVWEhLeit1ZkU5MDB6QTRRcVg0WmpCalc2?=
 =?utf-8?B?YmgxcTA3cWM2OW9sUkYzLzZVclhtL20xR0hsc3RPZFZ0UFc1YTBwM01jZW1a?=
 =?utf-8?B?Z2hpdjZMY3Vnb29yNDYrL1JVYm5MRUZXL1BBTGxlQ0RsaXdxbmsvVXo2U09U?=
 =?utf-8?B?TWFFQktoamk3MVNYSlBqcVZ5SW0xM1ZkNmhxbERqMW0xa05xZkpCaTRtcmNn?=
 =?utf-8?B?WUhCVVFJQUhYait5aXIvRjk1TTJSaUxhS0ZhMGthcG43VXRvRmNOd0tkcUdm?=
 =?utf-8?B?cnh2ckk4TGdHNFdZbEN2OC9Jb2Q2ejJINnB6VjVVdHRYMDh4OExQdStIcDRU?=
 =?utf-8?B?NWg2N0NpQzVvMjd4RUJpM3JUUFBjdEVFTG1NTk9pVTBFOUp4NmxROWk0cjZk?=
 =?utf-8?B?YVpCUDJ4eDNwS3l4Vm1rdzZPZFJYa1k2bDdFNE9GSkl4U0ZkTGRiQ0RyTml4?=
 =?utf-8?B?S09LM0dWQmdjN21vUjRtcHlHcmREdjRKSkpRWTZ1amVjdVBmUEh3aU1BU1VV?=
 =?utf-8?B?S1BrNEdHbnhld05BVFF6L1NPOCtWanNhL3Nnc1VXYVQyczRrRnEvdmR4QWlD?=
 =?utf-8?B?QjM3QlovdmRUK1pnYUQ0d3NCSjVXVUF3c29nWTUvUXdURUlMV09xdWZPQU9z?=
 =?utf-8?B?NFZwdE4zMzJpNGRDVWdOVGFNTjBJa05ROHZtTkdjYnYyUThoOWNLb1BGNndB?=
 =?utf-8?B?NnB4WTk3dTNiZmtzOFBmTStTcnJJSERLZHFpMUw1K1VPdStlUkRHZkhqWDk2?=
 =?utf-8?B?SHZxUTdwaWJ5Q2w5dURTeVdWT2tvd2VrQ3NhdVQrc3lHbVBCb1hQQzdlRjJV?=
 =?utf-8?B?M0k3V0ZVeW1pQXZrRk1zT0o2YUhPTENVZy9XVWsrTE5DdEpJbHJ3Vmx6NTJU?=
 =?utf-8?B?TkR2OGRtZC9UMW9iM2Z3T0ZxS0IvTkNJbVVvb0QvekxzVjN3aXRIb3ptNGIy?=
 =?utf-8?B?bnMrTnl6dktVWVpvdStwRStvNDhaUm9SOWU1di9TbXVYR0F2TUJoZGxlMGZi?=
 =?utf-8?B?RUJXNCtzalhZS2ZmZmNOMERKM3BIOXFtTlYwSnVvc3VNUkhnQUE4Vk0xY2Fr?=
 =?utf-8?B?aXRUTlYyUUNiWmJucE4wTXdVSkFlZXp1ZS93QXlnQnVzSUF2ZE5SbkVwSnJu?=
 =?utf-8?B?TWxreEpWalg1UmZrek9jNTh3VVZhWmQ1eGNOVlFGTk9pTUQ2SmlFRjVqVFVN?=
 =?utf-8?B?anptMWpVTUxKdzk4WTU5UzB3aGdkM2VGeFZGUUQ0MVNJcFJqNDlVSVR3ZW4y?=
 =?utf-8?B?NGF1bHpaN3pOYUhYZWxJZHcxbUc2WkZ4d3psajdhMFBmd2luV0ZyTVRRT3px?=
 =?utf-8?B?dkJlQ3VMcUEwZ3FvUUlZeWlEUGdpTjhKblVhNXBjV3lnVy90NUw1QTlhT2Ny?=
 =?utf-8?B?OWVuTG5JSU9kNXc5WndvQjhXMEtpeU1CajE5alNtVk5IV3h0VksvNUZiQS9x?=
 =?utf-8?B?S1FFMUxQYWJjckFVK2NXWkdyR0ZzQllDcjlsUkFvYW9ic2xnL1NzdzlBUTRM?=
 =?utf-8?B?MWY1NUYvWG1KYjNwa0VFZkI0RlNtUTJQNkpBYUljZ2tUQzVOQnRrcXl2Q2NE?=
 =?utf-8?B?aUM5MEJxMjg3RlAzUk1PbjJkZzFmVjdFNHZBNTM0ZFRiR0t6V0kzOHh2UFR1?=
 =?utf-8?B?bDNFdzJFSElzd0hYa1BhRGpBbTZ1N1JnNDhvTUszZkJBWWpTdTJJaFRJYWRC?=
 =?utf-8?B?dE96YWt2WlBFcUdCL2NseGU4TDRkYzFuc0J5WGV1MThGMTBwNWdJUUtzNXA2?=
 =?utf-8?B?TXBLNDBnL2ZrbUl0WFJFUzB6UDdIYVBSdWI4bTAvTmkzN3ZTbnMvTnJsK3dX?=
 =?utf-8?B?Q2g5RUlxUTBTZHBNL25MQVBqOGZKYTlLWnpBcVBjSXdMdURwTHdUR01VY1gz?=
 =?utf-8?B?OFpyUW8rTmgwRjFGYnFrbm1WcGh0YnRRcWF5VjhmR2RLWWhndzNSOW53VU1m?=
 =?utf-8?B?dlVyOE10bWNvYnNNc2pDV0FkV3NrL0VhcHpKY2RWb3haK3R6NUp5UT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1fabc6-2bcc-40ec-9a79-08de7925ffde
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:44.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV0qrct/Wh+RjvIsbU7JjAPTyBD9z8Tk1f1+uHR9JwCNjuLttSll3QyVnwxTOQjXrblTIagzQwaTWinfIHL8hcrfjxXfN+0UeRMzabmt2PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0984
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h | 13 +++++++++++++
 plugins/api.c                 | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index a6ec8e275d..f083c30fd3 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added qemu_plugin_set_pc
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function does not return.
+ */
+QEMU_PLUGIN_API
+G_NORETURN
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index 32eb086300..23c291f644 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -467,6 +468,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    g_assert(qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_RW_REGS_PC);
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);

-- 
2.53.0


