Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD41EF30922
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bl-000470-7q; Thu, 05 Mar 2026 05:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bj-00046K-C5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:03 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bh-0007ST-9N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2R3/03ZlJS+j9Sn7pP4d17egEEToMJlBxJ3o1YsQO6zmQku3wZpZZHzDYXOKG11GgiIDAYuFsjpmg34KVxtCUf3FFxoggYMjCx3V4xotWEcVZjBLxiI8tyrvwgAZOmiTJ3jA3KPSE8Ri5pHHxKE8id0l2j7Hv/FHVRY7ha2HcWL/UbnNJFyiJXk7Jd5XW5mg4z5q8Ok+vwMrcZSs1mnmDXu/W7LpsC5nU2Xwohz3W90JRWCJ5t0OvjnaLb9yJHzWgkb/wFw0PJUXbawn6f3zGRjgiMh9GB6GF7NcHk4eLTwDIHyLkqW/W6O0X9f2HZbjpBFHgcZaAxK75y7aHoHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1vwXZ9hFVcJT0K9OL3rLvJFqkjHRaZcLn/tcHEc7oo=;
 b=BORDbVwZAEiN21u3gkkt+dXp+XMgTyKub6WMtHanNLNk7K96un9KsdUfCCbAZ0IRZJeyTylIXAaB1griuS3UCVTkhpif7kDAO8TgZIWEbjYMd0RtApj4I2mDOYx3W75i1oHNt4Jj/qNoILRma/8BT/sNHb7K5Uu+CSXpq8JyYGENQuCIF0ikFda2NC6iXtxCmg6ZWY9t1JpZEB8I6cgGEFx3f4JFx/72ycAvX/jg7poz1wQ6L4sa/OlagOA1jX2PPu4SgOkbzhh2jxMQ6gqsyR7EqXkrjfUdT5gy1DDoygD9M7+YuRO04nliXGPHPeM6dRB40HAPDZVq/QLp03IdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1vwXZ9hFVcJT0K9OL3rLvJFqkjHRaZcLn/tcHEc7oo=;
 b=nuyeBGh29ZQYqKaxGO1U9TOjw20vAAVLmOJcRgUfgha4AVYlv/ltTmrNqR24HIjdMbCDmqUxZRjEd7GfwAB5U0pkHtzimxjuesRDdxxyWweDq6xplM/wGcwjrmYCPInfCMVREYCJNuT4kn/Dp1+lqAbToWSlqSZOCTiKFcmaDV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB2042.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:44 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:44 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v7 3/8] linux-user: make syscall emulation interruptible
Date: Thu,  5 Mar 2026 11:06:01 +0100
Message-ID: <20260305-setpc-v5-v7-3-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14808;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=0zN94RKNMfqTrsNhvTmcSTkaX36dEL1iEvxYUsSMkRg=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTESNU1ZzzjGYE/NB3daILXVma9/nDSvs/dT
 IzihnphD8uJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUxAAKCRCW6ye6MV/H
 fCYaD/sHrkbA+fTCVKhDLEs/SMgL5BNiGWGSi+0BxsL820MFHc3plnPnShlzXVIdkYesksb8wkz
 bVmtJH9kwopdgoycFJYjo47ynyO2/ozL0XLGXwXAWYvoevf3HHuVzeL8QD0pvi3+jp2P4dNHrmB
 sCdo4+Y755K1C97iK+8KJDpHFdr8S8j3EgQaa4mwaHizWWz/QYGzuQHYXMmw1p0bKlfm5eiE0vM
 VB0gZZYemWxBo3nQEGXS92Z7NVlieepkC8ZdgOlhXvqcTiFzFa3hHo/scZVWDBzORoNfbh46uEd
 bmTBljHd40LtcvT+VIbY1ZDa+W9V8TtuCwbf3PJNPTqTv6qcZuWI0m7ZGgzNOdVQXvJhP6BeOhQ
 xJY4NZOhca8r8LkrqieAi1MNYq1fZmkvrynauxk6XGpCyePEQEQ+TIPg+DNFifbJLGPA6xLMsEx
 3QQMQWL3e/ifAqZ0WZO3xmZmwkYEEHtl1otZ2vMMMHyh2pHFbsJEt3UxYKLu375pcfZu6ehLmdP
 lggyuGz7rQ+thyqQYy9LvOOFRr8dBKBY4AfIhFbJLNdHY3OVDolgQEw3zUusc61ml5DOwQoqxB6
 8brr+afRCBI8fXEclil8Cfl6yoolUpmSBP63+qoq1SLXmiCXHmZDus6ljdrElU0V8srz0um2Rw1
 2Ohq21R+ickG56A==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aadbf98-1847-4557-3b31-08de7a9ee763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: MiX7nzx2pNXoLBsS6FHvJmpuqU8wQwoSgtjNXRPNXhk5U7UOrpje6fcBbGONQYoOwtk3jAljgHYzPp01/JqzHZN37ablKI4fNyTOrEL/dcIMgIJltvwiUQF4P1rw7L6jbf8wnfnv1DdD7DrXwQ313Wus1MO3xiVhbj/2uDRu905UMgFyhlZLpnNAizIt4mT9LR95QI4P0z8KM1FdDq1uQknCXD11Hxm7aowj0KyF/3zPf/DT20770LK1cOrXun/eUW6W122NTdQAbBOCeh1Ys9AIDAnmAAckKTRDR8QjQeHzABQBiYnhzdf4ZGACsfzxpH6D+DnHrT4h36geuhFCoXV0TgWKf0mxNdJazPabPPNf1wHZ7r7FzT5Q3nE53U8Mq5uNuqicvjrdESYPmgcUJYVf5ftsmTOFgc8z7MoCVICLTtqdXzBVtLjIKEzEU7BpaZ6Xnarlt4jYl9RhVKE3sEwglZhm2rmMd3ch0T6AP6kUr4zbf6Apw+6BxqZtwi5geYq87BZZC3c1kbx6SJOKcxrmMGzyZfmXWvd1EGcm7ByCYLsHQdHEneyLZduODLx3XNiJSIb+qagp5Oo+l0o3OHAom+ZxVu7FCes6HiQLN0FEjSdJ33IPyP1ylO9iaBEsuS0SFVP9pd1E9Tt0fxBhiPXG6+1EC0W58Hmq5DzhqZF7sFnjNBbwwRSnuzUFIaO6+CxnHxDvR89xBw483iCTnkmHGD8ErCwbHWPovQvlXPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFUzY2haK0o2SVdyTlF2Zm1MZlIzbkYxNHl0aFRhMHRuQ0J1SHdLYmljaU9r?=
 =?utf-8?B?Vko5dElBOHMvU2JXSTZMS2cyT1VxS0RBZ0dZU1lacE9TcWRhdUFOdms4UCtB?=
 =?utf-8?B?ZVVOWHhyOVdGMk9McS9neVFJRzVQaWJ1ckxJTllNYkg5cW84eGsvem9UWWdz?=
 =?utf-8?B?bHBGckh2OVprcm01T0M5ZTVBQ0pRZy9ma3RrQ1lBL0ZqK0tWVTltZDVvc0RT?=
 =?utf-8?B?bkVEbGZ3d2V3cXJiZTUvaGQrQjZoNm1VVHF1L28xbGRYeTdRck9nK2cwMHBp?=
 =?utf-8?B?bmhDZXhydFgwOFVMdGtNMHY3Ym94cVppSXk1emxCUGFKK0xnNlZHTEJmSUtC?=
 =?utf-8?B?NUdSdlhKR2t2RkdJYzB6N1laSG1mOG1uUVlWU052bDlvRk94TE9lMDQxLzRB?=
 =?utf-8?B?QzlWSmtxZ1lCdGFrN242Q2RONVp4WDZPU3dJUFQ0cnFHQjEyRitkYnUvVjV2?=
 =?utf-8?B?VHBlNmpTYUhQRjJjMlRpNGpKSTgzc3JaNTFZZ0ljbWMwZlFkSzFaNmNtU2dM?=
 =?utf-8?B?Y1VwWjBNOGpFOGhnbWhDRU5uLzFhMjFIUmMyV0h6RDd1Q0lBYWdrTFBuV2pj?=
 =?utf-8?B?aStPdHRjVE9TRC9IbDhiMDJPVERzTnJkMnU3TURjYitzekhhdGZZbEpSQWdS?=
 =?utf-8?B?SE9YNWdXdUhJTWZudURzdUk1S0VudmNIYjZseUx0SVBlY0dZY3owcjI2aisz?=
 =?utf-8?B?TUZqRXBTbE1HTmRNNUhnZ3h5Uk9QWGwwMnlGK3dVaUNEYlJnc1h3UkU3SEVY?=
 =?utf-8?B?b2FvVzNhTUFrTEVWV1FNSkNsVHJYYU9ucjUzQXN5dzhMd3JTcG9MeXM1eG5M?=
 =?utf-8?B?bHJpTTBCY2FBeTNLaERvZC9TdFZlcit1U0pTMFI1YUZZa09laUc3TFpLOTF5?=
 =?utf-8?B?enJ6SkdqaHNTUVhWTWN6dTFEbDNSQ2xKakllcXpYODU5WFBVaHB5RnR2c3Bi?=
 =?utf-8?B?U2dTd21GdXBheUFoTEFYWHhzOFJCMmQ2TTlXSjhvRTR6Zy96bDQzM0YwVisv?=
 =?utf-8?B?dGh2ZHl3YXVLbXFoNjVVVEplckJsaDFFMitkTjMxZFlFVjVNdTV0RXpCQnMw?=
 =?utf-8?B?dFJ4eVFEV2lmc1NCWW9aeTc3T25QZkNmUVRjRXRYVE5qYlZkVnZnNFJkS0tT?=
 =?utf-8?B?dXM3WHZYOVlkckR3dFFUMEJibWhKNkQ2bUx5LzByRFRUQUEvYXllQm5ST3pG?=
 =?utf-8?B?Q0hQWUpPNHNHZHI1VzlRazdmSjlBbWxDUWxmeFkxQy8rSWdTTWZkSGxZTWV1?=
 =?utf-8?B?UEdtSlRzZFo1NHZCRkIxVXpZM2hBb3p2OFJCTDcyS3h5ZzMrT2l0RHIyK0dO?=
 =?utf-8?B?aGE2VHB3UitWT3B0Nk82TGpkRjhZM3QyejRsR2loVEU3MkYwbGtLbDRHNzBr?=
 =?utf-8?B?QzBGcFY2aGkxL1FmbUpnYmJ5NDV2L0QwQTV4Z0NrTi9GcUxLQUFlY1pCU05T?=
 =?utf-8?B?N2Mwb25XQmZaTmhFM0lBdmN4cnVXZEVCVmVCQ0ZhaU9oa3g4a0wzZUYrYzNC?=
 =?utf-8?B?bzVCZDh5WW5WNUpGbHRNZ3htQ29yK09mYjRReERSbjhqU3U5ZndHdFBIcTZF?=
 =?utf-8?B?Z2c3SUZ2Q1ZnMlVKOFlXRUthK0NzemRjNjlkTDIvSjdlOVgyK1FzdmUyZklE?=
 =?utf-8?B?cGM2a2JyUWE1MEFLNG9sSERUakJad09sS1FJaFI2OS9xd2hubktITWMyMVNC?=
 =?utf-8?B?Wkk4Nm0yVDMxNk9lODlmdnArM1dxemlqSWpqcVo3aHgwejdRZmo1OUZlNURM?=
 =?utf-8?B?ekZMeVlDNzViRU5VTUhPeXJLTU1kTjBWN3NmNHgvcXBuOUpjUGt2Z2k4Zjhs?=
 =?utf-8?B?eFR1MHd3a2tKd1RVdXQ1b1g5Y3UrcnUwSTRaeHRNanlIUFJRZVNCV2ZIWGF0?=
 =?utf-8?B?Um1MM0x0UXJZRUcwZ1gzMkdGa09sYXBoTEZJZmxmbW9GeVdkSlA0NW51Z0lP?=
 =?utf-8?B?cEJldnl5VXBSL09uaXQzYnR0KzFGYlhYbXdMcEpTVk81YkRxTkdPQkt4bWpX?=
 =?utf-8?B?Q0lGM2RQUnZ0OWFpTlhzTGtRazZKTSswMUtnTThIMmhWdTBialpmbEpMU05X?=
 =?utf-8?B?blZHTnR2NmN5bHVWb0thTDVWM0lKNGxmRjVkTWRNb0poaFI1SlZtTkZUemxl?=
 =?utf-8?B?MkhNbTRWT1pySlBRT0NCWVVjZlZrcjdyaGZJMmxObWtJMko0NzJsNkllUndi?=
 =?utf-8?B?OUtLZ2ZjTGN2ZzF2WE1GR2NTRnFKdUNETnRPNWZJazhjcnVOMG5GbWN0ejRR?=
 =?utf-8?B?elNQQ09PVDZEQ0NMQ2JlOXlOYmFZOTM3ZnJDdUhmQ1VQTmtvVWt6TGZ4clFU?=
 =?utf-8?B?UDRmR0xOQm92UDVGQ1VkN1B2aWwzbnhyMTJFWDhPNXh6Q2gxMjhQMXl3QldJ?=
 =?utf-8?Q?AHoLT0xfaiNDNUsM=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aadbf98-1847-4557-3b31-08de7a9ee763
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:44.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVV19k1vLwY2NKUdhmwcceKjqdIIF6ZEkqfRuYoKu0HuRESDLrdxI8Baot7h104mbE6gkRFh37hN42JAK7HsT5ka6BUvSHR2LKFv8Ku/ujA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2042
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

The syscall emulation code previously wasn't interruptible via
cpu_loop_exit(), as this construct relies on a longjmp target that is not
live anymore in the syscall handling code. Consequently, longjmp() would
operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
setjmp and the necessary handling around it to make longjmp() (and by
proxy cpu_loop_exit() safe to call even within a syscall context.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  1 +
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  9 ++++++---
 linux-user/or1k/cpu_loop.c         |  2 +-
 linux-user/ppc/cpu_loop.c          | 10 +++++++---
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               | 16 ++++++++++++++++
 linux-user/xtensa/cpu_loop.c       |  1 +
 19 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea..e7f643d69d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d..19874f4c72 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff..9464246e9e 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487..4b4b663052 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)
                 break;
             case -QEMU_ERESTARTSYS:
             case -QEMU_ESIGRETURN:
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..fa264b27ec 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,9 +140,12 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid clobbering register state.  */
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid clobbering register state.
+                 */
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)-1133) {
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/or1k/cpu_loop.c
+++ b/linux-user/or1k/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f9ee20bd0 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid corrupting register state.  */
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN) ||
+                ret == (target_ulong)(-QEMU_ESETPC)) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid corrupting register state.
+                 */
                 break;
             }
             if (ret > (target_ulong)(-515)) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..ab633eeae3 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS ||
+                ret == -QEMU_ESIGRETURN ||
+                ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d466d0e32f..99e1ed97d9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    /*
+     * Set up a longjmp target here so that we can call cpu_loop_exit to
+     * redirect control flow back to the main loop even from within
+     * syscall-related plugin callbacks.
+     * For other types of callbacks or longjmp call sites, the longjmp target
+     * is set up in the cpu loop itself but in syscalls the target is not live
+     * anymore.
+     */
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..d2b4ccdfad 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)
                     break;
 
                 case -QEMU_ESIGRETURN:
+                case -QEMU_ESETPC:
                     break;
                 }
                 break;

-- 
2.53.0


