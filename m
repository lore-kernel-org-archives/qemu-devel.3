Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06874EC143C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVS-0007mp-5b; Tue, 03 Mar 2026 08:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPVN-0007Y1-Eo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:41 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPVK-0000OD-Qm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGbameknhdH1965+xNjrfyZSRcJmlruyq7+ft2Gc/XukctvDMVA6jz7MIMq/JGnl3bQcoHZEj3V4DB9x5DywKa/oLWJFCE+R5hBc1Mg+MX7RJdfti2NlES+K8TihyJ2+3VLLk+RBfyOP1QDnUeEnMu7Zjjg5EWgPPSoal/AI5tGWhcomSFiQ6K1O7OXWAkAM9tgTeG2TLBfNkruvg1PBQdkG7Bk6+and73U94zW1CX3DZfSepvseHhdfi9pzSlNiTVoZos21S/MZQ/tg+tV9d+L9BMXTjZsYtkt8KRqaE03oJnYO5apZH3CRo1ft/erQ/2tRlB454YnShY5t2xfEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIUTjvmupTW4oUu393QgwqOUndkfozLBBtMj+Et5e1c=;
 b=B7fB+svPFhlYDpKz5nhcyfTeTnOo2eiDyOD3y1R5Ze7JN6F3T4YIBgSuWVZQWBMFRzwregVrbKwL4yjv2VYU5KKYk8dVUca6HfngliXZsMajG+ON7WSB6HPqOHmn//rbi9noJlrnN0FIbyQkPzeCq9LTR8XmomOKixsm6SCz56LSicC/IDW4Y/f7LWOwxnsepphsb+fBOIUGC0w1GGEXxCFEyG7SJ/liGeeIhdWIMQYpG7YslIbnnqQGI5FOxZyOL49U4PoRzrFk0Fqq/NEwWhMYC7dgz1A5nDg7k49rsXgkTT7lFgvDFZRSGD8oGHocKbBleZdrE3iPORwwx+8v+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUTjvmupTW4oUu393QgwqOUndkfozLBBtMj+Et5e1c=;
 b=beH3H3q8OVuRIorJ+wJ7G1J+yfdkfdBk+7abwNl4nHIiZNr7xJtefcd1vWnkvhEF8N5AatroALT/A41FEgSmGeDKFKN03w67E5U33xcS2OTdtB+vFhhmYt8oKGr8ZBfHmW6M2gTBWuyblNmYS0gX8W82RnB4iORtBsRUBPGlNBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB0984.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:45 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:45 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
Date: Tue,  3 Mar 2026 14:07:30 +0100
Message-ID: <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14186;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=+ujrLZ3RxHwYE8erbsTXTHFnJ/wJgv7f2bVn5MtG8rU=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1jY8eFjbQhgvyA1Cfa7TXhH30D41+RP6Bvs
 0MbKOi1YHiJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9YwAKCRCW6ye6MV/H
 fNWND/9zA7Mfk0xaFuiU7dUeNoNInXsbB3ncxpOIuZ/vK2GqnEIw60RW+Do30U31bKLX/GPInR7
 AiBZdlnXvVKWXJ/zqWonnESfFnGXge3uYhM11i5fltI3rI4niKP5Q2SNIwHl62jv6U4OTvsFIJd
 f8gOJnybnuLGgh7pTTorwmPJ2c0NZLu0vP1Qc5X73boZFgthLbB1rwt9shx6EjbUmQMYJKpECnY
 OZSIeLVi5l1ELDEeX6Unw2ZqPQu15r5FVoRo/is9kZO4DG7WCBOeWL7rpIZrOzBB4gL02My02xt
 aSRZ7he1odtyONrIsLqzQLKM8eNFI4qSG65ORmsm00yGTqWExNBlrUcPzObNvZB0qQLRn5WPbPm
 4FPGxTxz2UBBoDGugNeuqU1B6NfSYpK0EOYSWgXSsnNbzCG5knRtM7Zzwq4eF9UxOtBJL4Cv7+6
 69YyNm/hH589Fr9MzX+/Wcgy1W9WB4BK1sw39LS2+oraPiCimjDHRNq+n1JmAIAsBC6dNmYdk8Z
 Sh5plkIStrcKVdGZ7877fKhkSJKtY/8i6jU7Wg+syk+H/wlyK3pV5An4O1MFr9h/8pczK3zpwyy
 drWEv3aoQbQxwDw5H5yzZyvyuURkcghGgBV7lHLsPcA6wCOh3DuvTId8CqZuM9hJfs5BWkNhyFM
 YZQBuJZyhC5LfVQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: a83ed145-1eba-4ade-d448-08de79260027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: lSDQ5qDTXq3Vjao0QrRdkfDe7atP/j1VCFuY4A89Mp6q4Rpu+QkWNp4PX3mc5e7AsYPiNCmOFessBekGOfxvSrmtpbcLthodECIQAfoE4EfwvqMr/52wYs2DggcfvErF+nRzFsD8otJwqMtG6blVFu7b4QPhtWcNJipM8lOQTOBBAWwXY54FqI609DeCgfxeFY5h9dxCS0CCxbRlBqjFh2hMEo88Z9klheJf9aNvE3O0FCgoLh9KGIGOFwAgdd37F67VM06RP2iQ2Bfqq35Jsh0t+S+NJIe2qYqhgVYJQOlQYi1ytqzGwf16njS8Gvj98xZJEYLG7jMja7rvUFkrhbxKCKSSz6WKu/Rmm3e2AowZvmrKea4Bi+wo/LgKLddtC0Zhx86cbbimNh6oM6TMrloCZrX8ljhoaHZwpQgXm65yLD1DXAJrz3s9uymgiqBkJlbC4IF2tCkHj8AAgCRVq5RGql77/WB427mUTKnkFaimzUtJOGoSc70munI70ph3eJrZJB8Yz6cUrhGyPtu0cgojIaOuL2jLIRmVzO8LXzxezN+mxm4RdceYd1BeSrVZo49+gRpx9FJCeSo0hCyD+7fkLFq1aAs9AuLhhRKO7kJD5/REqO0XEZftvDDQ1xk+undAkQ4vkEcRc8bS7wOeWez6P3q7iMuDHTapq6EfbLywcT4qdYg2yKbEen53DVo65lAifiLmFcdDQ1rIGA/lDL2QWpnN6RsEnKqDH4jrlFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(19092799006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtwb1BrWmNScUhTYUpiTWVTd3RWS0ZqZDJvSUxRUTZaU281K3d2d0p1MmNr?=
 =?utf-8?B?am9yakkwOVN2T3pnYlJwNG84M1RIUnlBajdxdGE5VG01OGk1UmdTUldLU0Rn?=
 =?utf-8?B?UHFqdXZObkI4N0dkUllueTBuVFpJcXhETTB5dmlWb2Z0VVF6bE1uR2dQNkth?=
 =?utf-8?B?YlpFU0ltWWZ6ajRudDBBdUVienA4UVJEOW5COEs3NXdYMlVrYmRrMmQ1UG90?=
 =?utf-8?B?dDMxTTZCdjhtMC9SMVpvVm9sc0w5bTZkOGhYUjFZV3ZFZWdVSnlGRUxxUEF1?=
 =?utf-8?B?cUJDWWlDZGxkL0Iwc1ZNczZPY1pSZWloZkliRUlMWFl6ZlhGZ05QdEtzS1Vi?=
 =?utf-8?B?NXIxNU1HN1gybnhtdFhuRlh2T2kzZkgwVWNmd3FLc1pScnl4QW5CaExxV2Y0?=
 =?utf-8?B?ekhRM2lOMzRsNkRLMXIrcGt6bTRQSkJPcStkYVFnUzBZWllmSTVaMG85NU42?=
 =?utf-8?B?MHBUUGIycTh5WFltcm5HZi85MVNJVkMrT0R3VWQwNTQ3WDRDTjhIVENBT3Bp?=
 =?utf-8?B?N2xkLzAzMEd1aGtZdjRiaFFxaHdmdFRxQXV2T3lkNXJYQkR2WUVjNWZIQ2sw?=
 =?utf-8?B?YmkwcE5PUHJJYjNWWUVHNlc5cDJ5d0pUQVpveEJsdXIzOU9XN0xlc1UzU2pK?=
 =?utf-8?B?azIrbXhaSVJQNVRlUnZkOXdJL1lVbEZMSnQyUTJGcTNCaGlpSk9lcDl1TVg2?=
 =?utf-8?B?YUFUSUlKQ3VHRm82QjA1QzNOcjl6TS9tR0xVbzM3Y3hFQzFmK0IycFNIVkdR?=
 =?utf-8?B?VHdmQVJVbWx5Wlkyb0M4M1hOTFdIK0JsazBFL1BiU3lyYk1oc29vVWhUVFdT?=
 =?utf-8?B?ajF5b3MxZnYxY3ZlOW9lc2RyTVF3ZHNLUHFYS3JQYkRVSkUrVkVVTHpZRnV6?=
 =?utf-8?B?bGt0L1J6V3RKVlZJS0NhdFZnN3ZDdHVDTmhXYzVtZEdZYlFxSGhRZ3NVNG1p?=
 =?utf-8?B?R1pkNS9NbVpKVlZVVE1laU80bVdtN1prWE41ZWNacWxGNFpEbGFCWk8yZnpB?=
 =?utf-8?B?bnJ2U2x4RFR4MTRoUVB0c0R1SldvOTh0NTdONXdWL2pmR2VvVTVoRGRGbWU2?=
 =?utf-8?B?MU8xK3BwYWRIMXppOUtwcFBVb2g3bWlWSzZha3d1a0tJMjhOd3o0L2w4L0JG?=
 =?utf-8?B?ak9BTzJ5STFlMnRLc24wajF2TVVsamp5eDRvdmU5bDJVNTN1Njl6bXlZaHNM?=
 =?utf-8?B?ZWpnWUEyQ0pvMWJoVDNtVDQ2OEErbnd4cGExclpVN24zR3Zlb2lieFJwVGEy?=
 =?utf-8?B?VkZ6Mjd5RUpzYTBaMVRLSFRMcXdoNXBSSm56REQwbjRVcjE5dmJkcVRtVll0?=
 =?utf-8?B?TW9Sa0U0Nk9sOG0vUFQxaUx2Qi9qS2dERjJUbEpkT1RrTjVHanNFUWM0eVlw?=
 =?utf-8?B?TnBvN0MxS1BncWZsa2ZZa1dhUms5bkFzK3M3N1NTLzMzdTVaY2RoaGxHb3cv?=
 =?utf-8?B?djY3VEoxUk4rTGk3TzNtL2dtcTZ6NjJpWE0zcCsyY24wRjJXWGdNSXM4SFFM?=
 =?utf-8?B?SXZnRGZoclNCUkJGdU96STdYSklaODB5YlNFZUw3Zkw1bVNtYXJZR3JXS2Vu?=
 =?utf-8?B?NGZCL1Jhd1g5dW5UeFViVjEwZ0RSSytxZmVlMUtibngwNkpWQmltQ21ad1l5?=
 =?utf-8?B?QndlRjcrcVF1azFCNUVqQ08yejU0SFBVOGkrK0VRdWxMYnI5eW4rUTNEcVd4?=
 =?utf-8?B?YUxNdVJGUi9acU1NQ0R6c3MvaVhNNDAwREFraDZpbXBMV05kNUFCZm5ZVjdE?=
 =?utf-8?B?MUp4MUxUeTE2V2MrRGZDekZpU25jVGZ6VHRIaW41dzNqVURoN2p0NVBNQ0F4?=
 =?utf-8?B?ZFFSeEpzWmhNd3dYVTJmRmRYK2I1Nkc2eFh4czhxWUN0Yjd6Z0tpdmhpeU5l?=
 =?utf-8?B?cU80NlVVZ3FhTUFyUlJRV2lkMkRDOFBNV3FhSnFSVDNIbWR0SjBqbW5ZK2U0?=
 =?utf-8?B?LzBmUG9kT2xPcFdlSElQZ29veVpFbUJLUTd5YzB6alZ4RkVxZU5FODdGcGp0?=
 =?utf-8?B?cm5JNDZmUTB1T2JBcjd0aTBYKzJ4UGdCK04rWFE5TStGcGIva0R0dkx6Q0w1?=
 =?utf-8?B?SHVyODRIMW9xQ0VEZDlON2ZWMjBCeGV4TzJTVnBCRCtKYTU2dU9IRGJxNmJ1?=
 =?utf-8?B?TTRmUlFPSjRETVlMU0tObjdFSjFXTGpLNElrYldLTTVmWTlaNmhJajVTV2E3?=
 =?utf-8?B?dFY5YUlkazZaOHVGZUk1LzY4Y2dWM2ozbEFXYm9jY0Q1OFRaSHROcVRkb2Ey?=
 =?utf-8?B?bDJjYmduM2U1ajRlR3ZjYXhPa2YzTEVhZE1LNk0vUG1aZS9meURnZEtTOFQ3?=
 =?utf-8?B?d200MFRJTUxVK3FyNE16dTlaN2ZpdGFJTFpKdksyWGROdjFNYk00UT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: a83ed145-1eba-4ade-d448-08de79260027
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:45.3687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6B3Rj9wTXSemoJzCVCZKErffg49sIsJ4mofKZZKIAHm4TsrKVsPXWewC2a6CDOg6UbJEGUJgn0eIe3ObBWOcJRhBGipGV7ASzcQSmL1pm8=
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

The test plugin intercepts execution in different contexts. Without the
plugin, any of the implemented test functions would trigger an assert
and fail. With the plugin, control flow is redirected to skip the assert
and return cleanly via the qemu_plugin_set_pc() API.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 MAINTAINERS                                        |   1 +
 tests/tcg/arm/Makefile.target                      |   6 +
 tests/tcg/multiarch/Makefile.target                |  17 ++-
 .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
 .../{ => plugin}/test-plugin-mem-access.c          |   0
 tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
 tests/tcg/plugins/meson.build                      |   1 +
 tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
 8 files changed, 282 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6698e5ff69..63c0af4d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4104,6 +4104,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/tcg/plugins/
+F: tests/tcg/multiarch/plugin/
 F: tests/functional/aarch64/test_tcg_plugins.py
 F: contrib/plugins/
 F: scripts/qemu-plugin-symbols.py
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 6189d7a0e2..613bbf0939 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -78,4 +78,10 @@ sha512-vector: sha512.c
 
 ARM_TESTS += sha512-vector
 
+ifeq ($(CONFIG_PLUGIN),y)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-set-pc: CFLAGS+=-marm
+endif
+
 TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 07d0b27bdd..a347efbadf 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
 endif
+ifeq ($(CONFIG_PLUGIN),y)
+VPATH 	       += $(MULTIARCH_SRC)/plugin
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
+endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
 #
@@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
 	$(QEMU) $<
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
+run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
-			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
-else
+			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
+			  run-plugin-test-plugin-set-pc-with-libsetpc.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with the setpc
+# plugin because it will simply fail the test.
+MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
+
 # test-plugin-syscall-filter needs syscall plugin to succeed
 test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
similarity index 100%
rename from tests/tcg/multiarch/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
similarity index 100%
rename from tests/tcg/multiarch/test-plugin-mem-access.c
rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
new file mode 100644
index 0000000000..40d9a9e8f0
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
@@ -0,0 +1,140 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * This test set exercises the qemu_plugin_set_pc() function in four different
+ * contexts:
+ * 1. in a syscall callback,
+ * 2. in an instruction callback during normal execution,
+ * 3. in an instruction callback during signal handling,
+ * 4. in a memory access callback.
+ * Note: using the volatile guards is necessary to prevent the compiler from
+ * doing dead code elimination even on -O0, which would cause everything after
+ * the asserts and thus also the target labels to be optimized away.
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <setjmp.h>
+
+#define NOINLINE __attribute__((noinline))
+#define NORETURN __attribute__((noreturn))
+
+static int signal_handled;
+/*
+ * The volatile variable is used as a guard to prevent the compiler from
+ * optimizing away "unreachable" labels.
+ */
+static volatile uint32_t guard = 1;
+
+/*
+ * This test executes a magic syscall which communicates two addresses to the
+ * plugin via the syscall arguments. Whenever we reach the "bad" instruction
+ * during normal execution, the plugin should redirect control flow to the
+ * "good" instruction instead.
+ */
+NOINLINE void test_insn(void)
+{
+    long ret = syscall(4095, &&bad_insn, &&good_insn, NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+bad_insn:
+        assert(0 && "PC redirection in instruction callback failed");
+    } else {
+good_insn:
+        return;
+    }
+}
+
+/*
+ * This signal handler communicates a "bad" and a "good" address to the plugin
+ * similar to the previous test, and skips to the "good" address when the "bad"
+ * one is reached. This serves to test whether PC redirection via
+ * qemu_plugin_set_pc() also works properly in a signal handler context.
+ */
+NOINLINE void usr1_handler(int signum)
+{
+    long ret = syscall(4095, &&bad_signal, &&good_signal, NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+bad_signal:
+        assert(0 && "PC redirection in instruction callback failed");
+    } else {
+good_signal:
+        signal_handled = 1;
+        return;
+    }
+}
+
+/*
+ * This test sends a signal to the process, which should trigger the above
+ * signal handler. The signal handler should then exercise the PC redirection
+ * functionality in the context of a signal handler, which behaves a bit
+ * differently from normal execution.
+ */
+NOINLINE void test_sighandler(void)
+{
+    struct sigaction sa = {0};
+    sa.sa_handler = usr1_handler;
+    sigaction(SIGUSR1, &sa, NULL);
+    pid_t pid = getpid();
+    kill(pid, SIGUSR1);
+    assert(signal_handled == 1 && "Signal handler was not executed properly");
+}
+
+/*
+ * This test communicates a "good" address and the address of a local variable
+ * to the plugin. Upon accessing the local variable, the plugin should then
+ * redirect control flow to the "good" address via qemu_plugin_set_pc().
+ */
+NOINLINE void test_mem(void)
+{
+    long ret = syscall(4095, NULL, &&good_mem, &guard);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+        assert(0 && "PC redirection in memory access callback failed");
+    } else {
+good_mem:
+        return;
+    }
+}
+
+/*
+ * This test executes a magic syscall which is intercepted and its actual
+ * execution skipped via the qemu_plugin_set_pc() API. In a proper plugin,
+ * syscall skipping would rather be implemented via the syscall filtering
+ * callback, but we want to make sure qemu_plugin_set_pc() works in different
+ * contexts.
+ */
+NOINLINE NORETURN
+void test_syscall(void)
+{
+    syscall(4096, &&good_syscall);
+    if (guard) {
+        assert(0 && "PC redirection in syscall callback failed");
+    } else {
+good_syscall:
+        /*
+         * Note: we execute this test last and exit straight from here because
+         * when the plugin redirects control flow upon syscall, the stack frame
+         * for the syscall function (and potential other functions in the call
+         * chain in libc) is still live and the stack is not unwound properly.
+         * Thus, returning from here is risky and breaks on some architectures,
+         * so we just exit directly from this test.
+         */
+        _exit(EXIT_SUCCESS);
+    }
+}
+
+
+int main(int argc, char *argv[])
+{
+    test_insn();
+    test_sighandler();
+    test_mem();
+    test_syscall();
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c5e49753fd..b3e3a9a6d0 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -7,6 +7,7 @@ test_plugins = [
 'mem.c',
 'patch.c',
 'reset.c',
+'setpc.c',
 'syscall.c',
 ]
 
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
new file mode 100644
index 0000000000..72ae31a0ef
--- /dev/null
+++ b/tests/tcg/plugins/setpc.c
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include <assert.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static uint64_t source_pc;
+static uint64_t target_pc;
+static uint64_t target_vaddr;
+
+static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+                         int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8)
+{
+    if (num == 4096) {
+        qemu_plugin_outs("Marker syscall detected, jump to clean return\n");
+        qemu_plugin_set_pc(a1);
+    }
+}
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (num == 4095) {
+        qemu_plugin_outs("Communication syscall detected, set target_pc / "
+                         "target_vaddr\n");
+        source_pc = a1;
+        target_pc = a2;
+        target_vaddr = a3;
+        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) {
+            /*
+             * Some architectures (e.g., m68k) use 32-bit addresses with the
+             * top bit set, which causes them to get sign-extended somewhere in
+             * the chain to this callback. We mask the top bits off here to get
+             * the actual addresses.
+             */
+            qemu_plugin_outs("High bit in addresses detected: possible sign "
+                             "extension in syscall, masking off top bits\n");
+            source_pc &= UINT32_MAX;
+            target_pc &= UINT32_MAX;
+            target_vaddr &= UINT32_MAX;
+        }
+        *sysret = 0;
+        return true;
+    }
+    return false;
+}
+
+static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t vaddr = (uint64_t)userdata;
+    if (vaddr == source_pc) {
+        g_assert(target_pc != 0);
+        g_assert(target_vaddr == 0);
+
+        qemu_plugin_outs("Marker instruction detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_mem_access(unsigned int vcpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr, void *userdata)
+{
+    if (vaddr != 0 && vaddr == target_vaddr) {
+        g_assert(source_pc == 0);
+        g_assert(target_pc != 0);
+        qemu_plugin_mem_value val = qemu_plugin_mem_get_value(info);
+        /* target_vaddr points to our volatile guard ==> should always be 1 */
+        g_assert(val.type == QEMU_PLUGIN_MEM_VALUE_U32);
+        g_assert(val.data.u32 == 1);
+
+        qemu_plugin_outs("Marker mem access detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
+        /*
+         * Note: we cannot only register the callbacks if the instruction is
+         * in one of the functions of interest, because symbol lookup for
+         * filtering does not work for all architectures (e.g., ppc64).
+         */
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_RW_REGS_PC,
+                                               (void *)insn_vaddr);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_RW_REGS_PC,
+                                         QEMU_PLUGIN_MEM_R, NULL);
+    }
+}
+
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}

-- 
2.53.0


