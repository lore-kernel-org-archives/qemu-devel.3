Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42D8F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bn-00047b-B2; Thu, 05 Mar 2026 05:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bl-000473-QF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:05 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bk-0007Sn-7T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHdY15oztaf8nQVkr9Ydg5aAK4RGFB8SUvrObWNGCilBs4mPzVITkALPk6G4p1fblA91w29mq64qJX14AY0vg7/AXCcpIWC7TebSyFzkhoOLUF81hc184Os4w8jfUJbGX+W1M03RdLPXfEDBw71ptxDalwAgC/e6NiqtBsDREYQxjdOB+a//rhyazXIxXA11kr+ncz+IuYjCQ3oTLcHfI6h/R+971WuTRP+98PwfZJSL6c5fLwKlX1a3Eq7vL3Wx98GRdIDpQNjGM/3CB2XK/+PIPUIw+wdPnLx/b5gg0Vd4mp6WTdYspVmO7Q5u6PgrIAd8Oqg+vs+Ka8NgutsW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPc1PG8nvtwucTJfPZ+JcVu5QG/IEeSqlVzgN3AskeY=;
 b=d9u9Ix5x5Za081xdUP05oWgNDFvonrJrMncWzYLGhQmnD4u1fRd/W4y9ncubRlFlfMhObAgYzefJwfz4QncWgr1fEMAVfaJSXOpoy6J4U9ytCjOQ5WP7KX+xFF07GrDrZ52cCjgEgOAj0OvzKGvyKaPgdWRAj6Yf4BGm+9rDf96YqTQ2RNZgbQDJf/pWfPX+aVBW9YPGsO/G0nMK48fz5r5r4PXIyyPUUmBE3GZnABs/KPYJyulD43W5qJ1KrnubQ/r+V2+eJLyBsMjxOz/HIt5ON7jRsDo+bm30tj5bcQ+zne8z35v3qTiVMtARafsx2RogtLWYYiN9nwusNe6wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPc1PG8nvtwucTJfPZ+JcVu5QG/IEeSqlVzgN3AskeY=;
 b=SvtT9RP4jcEAUflQ4LOgHYu0HOhhCG3cqHN8YFe9DhSC8/DmuaJC8C0QV+L9k30SOch3NFpdBBMN3UEm2kiQGHBDBCNk28puXOnIFQO1bFZ3Qrt9eX2Xg1jEEHLWlMAcFrNpeZbhkbpvOwkC+zcyBSqS9jP0thnwgzow2g6l0Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0807.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:46 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:46 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 7/8] plugins: prohibit writing to read-only registers
Date: Thu,  5 Mar 2026 11:06:05 +0100
Message-ID: <20260305-setpc-v5-v7-7-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=kb+aqe8OeuQXJQsSuzJ9lhwP83ysgONNf+G2tBbMxc8=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTKDv34jxHb4oLwkoHG37jZ9utXUpLuJzo4E
 Wa+AgOxrGWJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUygAKCRCW6ye6MV/H
 fCz8EACrfooxoNCcGY4eCp3ExblX/VCmMQb7PWI/BHczn3yjrjdFOrNV0jcvSOuaUVBt4zN+IeR
 FXjqxy8IDwV8ibijSiachGPP5TeQMKs0znVqwRI7+cLtJl0w+n9rKuPlRSjicb2MkhYYR53eps6
 4b6Qq58uWeaAxfMSE9EGVwBLCviJ1iiJNkUrdglDCn3PIOa1ost6HKoUhyCLGXFv0WRCoTbB6YY
 /EUQcHXLoAVgvJHxCxB/tL3/mOnX0xxyExSlG78p+PNnYseZ1qxf4SuI0rof+Fk6WOKb7uiJ+NK
 WJWwdzomrcHC+BtrrC1E+DXxX15p3D4fsv4kllHz+Pfh566M0UyWuxoz8S3odgvz6rA48Nu0Fzo
 /W6Q0HySmphB6Fc4tPSN3Uh/p+UAmi+4YhOupA6qtq/QztlG2HOgI8Vc+MtZdLhEI45dN6E3jYR
 TfixgAlOIXdYASkJkX/oQ4VRG1+yjPb8tYal3Lqrqa+Pt08KG9FIWS1xgJXgO+GgrP6gI1YxnDO
 AfyhQKJ58wGf3btx7fzfwOVxLUX6nnjmfCfyEBLx+umfMGws1DRd3kIhbp1L0AbNNNHhe2Icznh
 emGIgfuxJ7PkKS+zut/5jhyHPPTdN3MFa9C4u4nFXRBlQn5GpluKJ2IXtP/TMWhXGSExKSx1y1z
 4MuC6uTpbKtEBrA==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0807:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3a89a2-9bad-40ab-1614-08de7a9ee847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|786006|19092799006; 
X-Microsoft-Antispam-Message-Info: Xe0oDprhRthN59H0idVs8S6Ofw2LPNy6pdWIZvrNMVajyFoIHhNrho6q0Y98tSvPqTWaSl3kzOcYytWxRSkg6936UCxV5/JZzODIoCgzAp1DgR0Z83ZnRbY7Lg1WR9VPp5TXxDJYrDgg/70TXYNE/3KpFOLtkOXI7iDO764R66bbwwizjBRnS314G9t6GzxfSmvlIx84dG3v+TzGF+dILkEu0jVpieILZFPBDy3sIc9e3MNlMnBOs0BIZnttt48U4Z19pOUbnuyUmjIc3uQEa9t0zL7fG3Ipp2kU6QSedR9V9vsQm7CQF78OQsrU7Z7LK/+AEEQooamCJUW+KjWXIxDYfZWcWbzYb2AO+tASpkgP7+nFVsWMb9WNrgup8FpW2LzNVx74ma36jd0MvrQX2/YSCSdeb7LljLNG3tr+d7RuHIap8/7FWEHfoFZKzKnTsroe9GpJXKTKEUcZ8DdW0EMVYEB4vIMOqTYz/CBnqdu8ksvZFKj/gxZh0u+d80sL6iQwVv3dhWNX3WvWqDQRn3ka/jEVzGY4ZcwlfV2Z3PSoKPC95NfEKJJgdOxLr9tv0alx2Kn9UdGsMoWvtKhFygsnsHjtxV2nDf7sY4V+K8GVobjiy2sUVjbGT2AddqRM0XnBnET8dfhRtjmhUwdlgEhg0KzLBxp/EGCPRxEGXJMZ796Fpo6mEMQRE5j+tl5j1Zc7vISHIKjAnlMD63HCKDb60R/g2sXvi11GF6CuMLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(786006)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2p1YlY3dWRqN01SRFhmdDJQZVdiTS9MT0FPbGRJQ3FmTkhFYk1XTWoyTmUw?=
 =?utf-8?B?MEs0UGpWWW00Z2xFcENkUjJOYXI2d29uajN0RTE2VVBsZHR2Mk1aVUIwakxu?=
 =?utf-8?B?NUc0RWsrdmplQ0pYOUdueis1MjlzczduZ3lwaTJMTDc4VHhBZ2tJdys0WHdz?=
 =?utf-8?B?bFdJTnZ5UDlmNjhLSE1SOGNMSzV0V2lrTnJlc2FZMFFFTFc4OU03R3FoN3A3?=
 =?utf-8?B?d1Z2NGNQUmJtZ3J4cUg3RzBxRnF5RGpMYi9tUnpkWXprdExDRXRRc05rWGx1?=
 =?utf-8?B?elhXM1l1SW1oZXl0Vzl5cEdHemV3K0ZPKzNXVmxYVXNhei9PeDkvTUtNNlpU?=
 =?utf-8?B?dStKRm9ZZExVRnhFd2t6em44TlR2VVgvQ1lhZXJFbDQ3T0pPQzNDNlNqTkl3?=
 =?utf-8?B?VGh1Wk1Gajk4UGhDOTlFOTYrOHBraCtCN0E5R0NrejROYnlneWI1WXJLejZE?=
 =?utf-8?B?Uk5mLzZKWDQ3UkFSOVFsZXdUNjVuOVZtS1ZRbEFHV01BMFVHQ3ZwbHhjNE41?=
 =?utf-8?B?WTBNSGRRdndZcjByQ2RqMVoxZXlJcy9Lc3J6YVBRMmhoaXBaR2VHRms2TXQz?=
 =?utf-8?B?WVdxZ0p0M0JIM04yTWdrMTNaZE0rVThkeGNId2lhTlNOS2JGT0Q0bDQyTUVj?=
 =?utf-8?B?NHk1ak9UTFZqWkRWS242L2piSk44OXo0cENpeXB5TU92QzJDQXh6WTRSVWVu?=
 =?utf-8?B?UkVEc0N6WmVUZ0c2WE1ZNnM4bjlmU1J4OGVvMmZsUVI5dktiVmpIVVVwQkxu?=
 =?utf-8?B?Z2V2TThncFBsUllxeXRQeXZoak9qK1RIRzBJODl5NGF0ZWdwNml4L2x0RXlo?=
 =?utf-8?B?NEJoakRmd3lDQjhRcWhobU02U244YUVWNWdXU3VORHFVc0VnbzdsL0hRR1Fs?=
 =?utf-8?B?YXZTS2ZqVi9SUWhWN3huRHBSL0JMQkRKTFIrWENWRUhWVElhbHJDUFIyeDRF?=
 =?utf-8?B?RitCbDVjWWN3aG01cjk4SVZJdWJLQ3VKZ3BxYzhDUmp6MkdjczZzOFBwdVpy?=
 =?utf-8?B?KzFWblMvR0Ruc3ZROHUrRFhQamJOc1NQemw5cmhMMC9EUHNwcldEaUJsM3hG?=
 =?utf-8?B?d3pOVDlRWVZkOXdQN24yYnN2ckh0T042Tm51em9EQUVtcmp2MHV5YU1CTGUx?=
 =?utf-8?B?WEVtcGI2SEVkQklmcGlSQldEZUV2MGl4OTVsck9ZQnNVUktFUEdadGVXUk9k?=
 =?utf-8?B?eHpRUUZZRk9kbmVrcmpOdkYzQ1Z3SFl5eXM1ckRTeldQdGx1REwzeG01aU04?=
 =?utf-8?B?bWh6U1hrUS9KUnlHV2xUSlJ6TEh6NVJFS29ncXlKUzE1MWQ0MlNEalBmNXpx?=
 =?utf-8?B?S3FPQ0FwZi8xUEFobVNzdkFEZHA3dzV5S2tIQWFndXNGMU5xM25Oa1ZhUTg3?=
 =?utf-8?B?RG1kTWtucDgwOVFlU0taVW5nem80OUlHRExWS2p3RjI0RklTSXlLT3FYcll3?=
 =?utf-8?B?YlZITmJudVVzWDhCU3ZsMGdRZUZ2YlYrL21JS2xES3dBVmdKckZxaEF2R0s2?=
 =?utf-8?B?SnNRL1JQd3RDZXhucXNYL0pQSlAzb3hURFZnTFVwdXA4WElOUjZxV3VMdW5w?=
 =?utf-8?B?QVVHSnFUMTJwMVZwQmxQQUZYQnFSRUh6TU1ZQ252M25vVWtjOHZBVS84TDNt?=
 =?utf-8?B?OFNxZ2VtMFFQMnRCdWduRmM4QU9pM1Q4RGlXd05OMEsycGp4N2Vtd1FmcVFG?=
 =?utf-8?B?MjZBaHB5dWsrTVZIcWxlU0dBUnUvKzJKQk9RRFFVYWRUaFhaWVpmdER1Z3BF?=
 =?utf-8?B?TmhIbkJRU1ZlVlZVT2R4eUxjSnBGbkd4T1E4Ui9jTUUveHZiNCtzeGlPVFYv?=
 =?utf-8?B?bmE2eDdlYUZNQTNXbFROMXBqMHFlUkIwSVovcVdEMTZIQ2VNaW95UXY3ZWN6?=
 =?utf-8?B?WkRYQ3Urd1V4MnI0RUx5WDUrMjhGM0lIZ0VlMXJIWXpuRkl6bDVNd3ZKMVJY?=
 =?utf-8?B?dXBlRnJuWGNZWW5TR0pham5uNUhpajM2Njk3WTVyaTM3MnVqRGJrSUQ5eXpl?=
 =?utf-8?B?bFpaM0FtWkNKWFVHVTMzUVRlN2kyMk5VWXlJN0R5TkllNDRySmI3YTBZUjFF?=
 =?utf-8?B?RUJqVmN4cXF6VnpEK09DM2RiN2VPOFowczJqVmhMazluQ24wQU1Md1BQK1JQ?=
 =?utf-8?B?K1pzZnE1Y3NlM08rcDVPTjM5eU5GTWJJKzBZMEtITVF5TVhKaG8rdnlhZ0RZ?=
 =?utf-8?B?d1UxQUhuU3lXWGpaMDgyTG1FS21pajBBcFZqbldLTzFYSzdsamc5UzJqY1Ba?=
 =?utf-8?B?clFRY084SkdpNzFUZkUyYzZVYXBoeGVPQzJNVmNjYmh3cm8vbGNGODJCVzEr?=
 =?utf-8?B?RHVnMk9Rc3FvMlFRYmJ4T3F1V0hzaHA4UllUZTkvZC9oKzN0ZlRSc28xaXpN?=
 =?utf-8?Q?hsNH8VuWdTUI5OP4=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a89a2-9bad-40ab-1614-08de7a9ee847
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:45.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FfH/Oh42/zsNqmnMFVmvfrrX5t0TjpRJs5mYoMOEx/L0GwgJtK6eFcRcZbDpgj6WJEagf/GZu+dCg/N/VJBQiqDryKMz25GLAmUF8FBC5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0807
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

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 plugins/api.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 85b34949cb..0c348a789b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
     for (int i = 0; i < gdbstub_regs->len; i++) {
         GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
         qemu_plugin_reg_descriptor desc;
+        gint plugin_ro_bit = 0;
 
         /* skip "un-named" regs */
         if (!grd->name) {
@@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.is_readonly = false;
         if (g_strcmp0(desc.name, pc_str) == 0
@@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, rpc_str) == 0
            ) {
             desc.is_readonly = true;
+            plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -475,13 +477,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    /* Read-only property is encoded in least significant bit */
+    g_assert((GPOINTER_TO_INT(reg) & 1) == 0);
+
     if (buf->len == 0 ||
         (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)

-- 
2.53.0


