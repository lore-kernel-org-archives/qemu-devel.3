Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6D2EC143B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPUt-0007NE-V7; Tue, 03 Mar 2026 08:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUf-0007HW-QD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:58 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUd-0000JX-VH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIp2lDZJAGVrpc6KI4aazJWJiT6zupLeQ0Duz7Wt/btwWTCjSXI3yZ02MKtRZNIPud23CSW70bfvMxiWwaDeUay5g/HN/+HGj7kh210Lixq1KhMECiMDwZ1nx54K7sLGObcwqjdeD6QzCPMSr7UVVY112plnKY2OvsZ5y1yokeYUaKiMPdWXkPYJdIC71fTHD+SLmnHjDZ/QKKdU7nozTDwo5OHiluwlP+DeRjL397vweU8gsCmUVWRYI9jZyVWbyUtlNv6ZPZavWKLiWkVhvyWS8v9qFwEVQneoX9GSw+BgRWA01hqI/vxIXuuChR9E7kabrVh3iNJ+LHuw6CUESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BNk8PyaB79Blk1ypOTqSAgE08K5OzzHMj2WKatisJ4=;
 b=fHpwEwKNzjIHfT8o44PJpF/574y1a26jLwRNm53SXijlSghWvtikHARhRci4qJFJx30NtxzCgyMPFu0W5NBYKyFA7SahqoRv0Kaz83yNjl0dFhN6ISNtZDlqSZKsNF9diZ91n2WDYSeEU0Is8Llm2cgsLAZCeMaHPj//Frbqptkh7NGQtpCWpjXk0NFkRhuzlgJ2tHJDwQWhz1mKVUjHvOowqFJLEEwB6N6Te3Zhd5p94zCpcybYYqIgKlbuX2QdOmcG8zJn1C/wYFaeZG+PAIn32vIsOza8tVQ2rwJIA9gKKslNQlaL6xrnwqOT4I1wFaMWHjqHOuR9M7ESW4Mw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BNk8PyaB79Blk1ypOTqSAgE08K5OzzHMj2WKatisJ4=;
 b=GznWFnyO6h7SKix6IKa8fSP+ceJSi3WPTwUa8rjAKIRtX3j4Mo1BLt+YcbCRehU3jXtPSDiXArV0IWfG7XVlT/toXrN4uMXzm9HeeGGf9h/mE35mSFjpMLQECnhUBZJKfOx9NBChPZIwevkZPcJF01gnRla/1e4XZiS2ZVlJLT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB1207.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:48 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:48 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 7/7] tests/tcg/plugins: test register accesses
Date: Tue,  3 Mar 2026 14:07:33 +0100
Message-ID: <20260303-setpc-v5-v6-7-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3879;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=s0G2uvDq0xOwRq6URS+Oxjy2nqIvkslwbcc7SlvprKk=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1oHmmof74z7TOKe0uQs8im8EBxWTRKimSKZ
 BShcxa8AgiJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9aAAKCRCW6ye6MV/H
 fAz+EAC/sO6adEHXqKQN99DJ8sxV6y68P2C8GSnUGG2Hkgrw1ga9xZ91pIGAiOULDsr9uATeho9
 H+FUc5RgRItSWKBnIcpJfYxpEklo6B6U8fpmFUK4uQov8lYOWOCiqGr2zpKydSe7xGESXh91xNB
 YRYTSsBRIWXLK3UwTlzTaQCFWBqdZeY5r1g235H42ASaUKQUJBVGbJNejF4vuAflnVZeXKRMghp
 erzRx0oVZVmCT08+nQzbpEw85DgPoiXvkzErNQUVxWD3Z/fnaR/LQ+9DivW8/Lv67zEUx62p2jd
 dfU6xU8xw6p8NdX3MOD/nN3w18yqjlfxcp9X0DxYFNQc8yeoWLAqr3jhm45cN8VHOqh1iOyr74Z
 x8CKO0eikPRME4ho0SfpP888UICuAa/NpKzkVgSrZ60Q0J4q+0jPBqIw9lqN/0OUI9vmDbaN0QV
 xMHRTeUYwWHc6Uq6WtP/lB0UHhZpDZkfGoMG0xxj1ockFCLuBn5LFVNt1Mi12NTf6BPNg3ahsSs
 XfBVeOimNCsHWrLjLxxEbC35J0lY+QeoGTfW6uPag/T0GCPwC+aPjdk3WRYIz/irl5bbU/79r71
 ma3m4U01W8ulpWdmAWbx92dw6UMoooUP+LKKU/338hYyHR1nKDI5lrYneIPNOBNahiTN4IJuyNQ
 4CicZ0BZeK7hEVw==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB1207:EE_
X-MS-Office365-Filtering-Correlation-Id: c3713539-9af2-4fa8-9bde-08de79260108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: cj5X9Nt/q2AFoFHp+K4lE0GA18A3xFSdrtkF9LKyo7RlHZODZAn9tusbhc8H1xoXpFCol99izWy2Yjvgl46a/bua2ZTClhi3dgPxt0wJ0TyXPnWncDUVQgA9DD9UqbHNS3ojHbSRksZxnoavglFOZYrF2z+vUoXL/kWoACEbF6Wge8lA2LFQH7s4UFc1fVYVUpp0gMW2bPkL5f3hynCaf+3E5A7sJeLLO5EnYGnQDtSAGb2LqZ9FlZukXkGSJdbZjC2p+R7VP53INPjJ87pLF3WXspNOL0qexilbU0tAyT+bUQjKReH1wCfiG3HrZD4cQYf5iOV7kHaEOqVMrRE/ASNyRZMyyvt2X6KwKqD0VqnFIGgh+652yv86goYLTxeF1vKW8kOoeFr9BtZiBtav9iT5x2jTnv+WuXM0jS/xUD8KzxZC0Dw+ah+33YCuR4Iw8UmsUPm6agSAfDNX+dTCGboSIe80CBl05Ts1zWZmseWQFO6WUmbtB0/bCCFRqSeXedYIj6SRhQGMQmBp7pj3KvcCVZytcjwp4gs46jlIy0J9uAwqPvfcgiGhYdB6DmqSIexnbgjph7KprDw4urr9vH1oozdBBp2EwxTM0jyBz3ckWtKsIsNV+eF5lnPEvNJodnQZUfqZ6JLQ9SguXfPxP/V7tEk7t2e9u7Y+dxe8blebI2nIdt4C3KA1yauR/uPSZj9uMQWarjXdnDcYz72ZLnelxi8z9mqPfJmzLdLvJ34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZac1VXeWl3OHBuMlBYeE5JTFE1bWQyRHUxWVI1bnEyWkdka3NjbDZuWjMx?=
 =?utf-8?B?R0cwalVlazZCOTU5N081TzdjSEVzVERnZnRObUFoV3IyZFlaenJTM2JDaTla?=
 =?utf-8?B?UUIrZE9XYTJXYUFacXhNZjhFMitJWGpRenZ0QVVpYUQ2T2hCVkJwM3MxZStm?=
 =?utf-8?B?ZWhQR1dGRkRmMHhRUGZxYWlvWUVkV0FhaitxaDhsUUJ4ZXZTTmJKUU5IUy9i?=
 =?utf-8?B?R05xRU1ZNXBTTUNLbzlHR3FqVGN4ZU9oOVRtYWYvSndiQXE0S1k1WEpONG9F?=
 =?utf-8?B?K3pBSW8zZHdFaTFieEJ4UEU5L05IQ21wZ2c5MlkxbWJPTytBdmpkQ1EzdzV5?=
 =?utf-8?B?d2E1WGcwTWN2RHIrMFRoRThyTFRxTVM4WFZnd3VuNWtXRFZvNDFSRHpjemtE?=
 =?utf-8?B?QTZxQUN5dnFkaE02V0dFc1VwSnhEbFY5SWFuYndxVXg4SVFPeThQOHQ1aC9i?=
 =?utf-8?B?ZlFmTkcrTVl3d0dwdThzVnFubWNGZkZ1Q1F5TVlVWFNTWmpHcGNrKzc0Vklp?=
 =?utf-8?B?T2ZtdmYrNGNFdlZxUXZWSFFVc25uM1Jha092dVF5S09Pc2JaTVZTZXBxOG8y?=
 =?utf-8?B?Vmx3YWxiQlBRVUxUQ3E0SHR1clBmcWpaZDRZeTAzRytsRkdMbVQwVlN0TWNy?=
 =?utf-8?B?NXc3NUpkZ1lBY09sU29YN3JZbk1HY0hsQzR5V3EzTmZXTWk0aE5BTUtiV294?=
 =?utf-8?B?YXh4OStuaFlkWGx5NjFTdDdqY3FHb1FlMW9CV2xMd1VzNDhHYVh2RDJKYTBD?=
 =?utf-8?B?aXkxZ3VER25sWlpzQWFUdThqRmp1L2tiL3FBdUxqdzJPYzBURDN1VGdUYWVE?=
 =?utf-8?B?NGNXOXBMQ3NmN2FpNFJUa0xxN1A5cW1nTGlpaFJSMGIvcnlIQUUrRW1DK2Rw?=
 =?utf-8?B?RDZiVW9Nby9xTThLUXMxZnhmWnlvUDJlVUxUQ0tsL25RWEczdW8wZFN1Y2lD?=
 =?utf-8?B?czYwZTdPVm9vUGpPYjVtWGFXRzlZMW5jb3lQdFQ3NGpQZmdPZGdKbDZGMVZp?=
 =?utf-8?B?TWtzQ2hKcW01R1gyNmdyOERFbTlQV2s1Y3hvQ2JYY3pHYllhWGV0WXBLWEhE?=
 =?utf-8?B?SFdha2tnK0VvUk9XK2VtQXZmL01mcHJBVzNJbW13SEtieGViOU9WUHlyck9T?=
 =?utf-8?B?akZhelRZbHpuZk9UNG9Ga3o0dG5MNGxNak04U0RMenJ5RnRJTUl4Wi9SelM3?=
 =?utf-8?B?NS80RUFTd2kzaEs2UkF4aVhPazBkMEdIbWZzWk52R0RURUc3Q3FCVEE4MW0w?=
 =?utf-8?B?R3FCdmlXNDBkRUk5c21JTktoTnFEN1cvcFFtdk5rZmxFVHJHa0dDMG5LR3E5?=
 =?utf-8?B?S0pzYU5LbUsyMHZpMThncHg1U0o1YmdNaHQ3WGhmVko2T0liemd5bjBmeENU?=
 =?utf-8?B?TTNWVmZhMjJWMTUzS09iUW5aUllCbDdrZU1nT3NyV2EzUjN0NzljVEdxdWVi?=
 =?utf-8?B?Slp4MkFRTVJndGRsQllHVnByVG5qVXovNjg2R1hpSnRlYWFRQjh1d2FzOXFK?=
 =?utf-8?B?emxwdUdrQzZTaW9UVlYyNFAvb0tJVDRaeVB1S01uT3g2NXFZbjFWeXlhQ1Zk?=
 =?utf-8?B?MTdhR2I3UWZNTDJhYzJMalBBbnM1akFqenRjalJQMENDWVhpSlBBWi80SlNU?=
 =?utf-8?B?SDVLcWx4Z0dFZ1F5TmxBdHp2UiszS3FPdUplbU1maHFmTXBoYUdQOEJ3WDdj?=
 =?utf-8?B?Lzg4T0pMS0E3WlVwN0x6cWZZNGpFQmc1czhRQktqUVdXVXFhTlJRYjR4ckVx?=
 =?utf-8?B?OE9xd3dmNHZyRkVaZkdQaXY2MDNYTVVFYkFxTFRqditabi9WZ1luVnNyTk5L?=
 =?utf-8?B?QVp4OUQyQXNWTU5FMm5lc0drTXpzbUlZbjZ0eGgyeTZ2VmJ5bjAzTXdGb0ly?=
 =?utf-8?B?dEhTZ1N5NUw3aWtCRm5jMHlhbjNubGtSK1dIcjJkVHJKR2pyTllkbjQxNWlq?=
 =?utf-8?B?REJzMjVtbWNPSDB6SkJmdG00aExlOHkwbDdJaFpVNHo3R0NCang4Nk0wd1I1?=
 =?utf-8?B?MzBkSTBOTTk1M25aMFJaREt5ZldtdUpFbUJJdTl1a2tGVHYzZHA5cS9CZ01R?=
 =?utf-8?B?aURjRW1RTTZjbU9rR1Q3T1hPRlVJbUpicDI0allxTWhYSEphODhqRE1YZ1gw?=
 =?utf-8?B?M1UvNFRoaXZ6SVk0VlozU1VVZ1JTSGlHZDdJWG1XZVlBV1ZQYVFZdGZ2WjEz?=
 =?utf-8?B?ZFJ4Wk53WjkweHVvZER2M29ONHJsYThLbnZxNEJQcXhiSFRDTUtkSkprTXJi?=
 =?utf-8?B?ZGtHQUZjZWwvNFY3MC9HbzZQVkQxam93Y09vbnFTbGI3YVEyaU1TMEwzb2dk?=
 =?utf-8?B?N2dZN1FFbnQySmJHQWVOVzJXa1lxVjNBYVovZTlUdXJVaXpOeFFMQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: c3713539-9af2-4fa8-9bde-08de79260108
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:46.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWuxswZu1WGDJePBYuwt6WYmeiror2Xk9zQL3TAyQy4yNCxbxEhP5No6VSnO2PfUvN3ww/XyNiamSsKhk1LyhlRtZpzHyJD04K5Z3xaklT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1207
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The additional plugin tests register accesses, specifically both for
read-only and read-write registers. Writing to a read-only register is
currently not tested, as this would trigger an assertion and fail the
test.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/plugins/meson.build |  1 +
 tests/tcg/plugins/registers.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index b3e3a9a6d0..d7f8f0ae0a 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -6,6 +6,7 @@ test_plugins = [
 'insn.c',
 'mem.c',
 'patch.c',
+'registers.c',
 'reset.c',
 'setpc.c',
 'syscall.c',
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 0000000000..6d627c7037
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,79 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This plugin tests whether we can read and write registers via the plugin
+ * API. We try to just read/write a single register, as some architectures have
+ * registers that cannot be written to, which would fail the test.
+ * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_assert(regs != NULL);
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    qemu_plugin_reg_descriptor *reg_desc = NULL;
+    bool success = false;
+
+    /* Make sure we can read and write a register not marked as readonly */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            success = qemu_plugin_write_register(reg_desc->handle, buf);
+            g_assert(success);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+
+    /*
+     * Check whether we can still read a read-only register. On each
+     * architecture, at least the PC should be read-only because it's only
+     * supposed to be modified via the qemu_plugin_set_pc() function.
+     */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+    /*
+     * Note: we currently do not test whether the read-only register can be
+     * written to, because doing so would throw an assert in the plugin API.
+     */
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}

-- 
2.53.0


