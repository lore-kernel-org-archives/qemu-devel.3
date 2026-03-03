Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF5EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVL-0007XJ-NU; Tue, 03 Mar 2026 08:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUd-0007H5-K6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:56 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUa-0000JJ-9K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzOmA+ZdUwKMWYKvmuptbqSpe5fZcWagZ4bEiovjbuVuVIiF2iassYIarUpVXAnWofc/3ghmHyCGvP7tG2OUCdRheH8pRHuz7hV0xOTMbvj/vQVC24h1/oIgeZNLRK1Q692AWiJ7hAuUIPHWGyQthzQRHmMl3Ks1kEmONo+YHTd6Gg3ZjPqWoNeMxK/BGPjkOIwLfT04cMDXprwDtxavnvNGYQfyT3dsrhC13OM+k3RnmWBOm/+Ld5k0iJvlKBmZWgrFrCoAANhkhra44/O1v1Qxdwh63vAlb2tEQMCAq+V+H2tnqhOEK5H7Z1GfOCYhA3OZl3SpawXQoDSMdqhCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0xfrZfM2WFGw8pe3Mm/p0V+KJz4nKuXFMldsD99vIE=;
 b=odCT947wXIZcZzBS5oFeciB2hJTFqNubYTCk58EI+Ird0PWB+/ECVbY4w3WxdvW0+wD5Xnww0dth46ZG5gxBh0VxVtWHezaGo70JWazG5vjHcUTNh7jMk84WwHcTmVgPXrjyP7VgnyT2nj/I5tYhPjWGWnezMW+8LcmPhJiGlVvlz4MUZRJl48pnfjR4uWPZiHskVZztZRMmOKnYN8KRr+PV74k1PmslyP5719V6S590E2Ew7MeJ++exwer0s1+9A8Lm+q5mvtVpKCv6+msu65clr9cTIgGv7t+T8d/Lv6ar/H6RiPxyFmh4PYFbSSHv5m2aDL1AhcSnPwzmA0x7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0xfrZfM2WFGw8pe3Mm/p0V+KJz4nKuXFMldsD99vIE=;
 b=rXzYeL/JOjCzeLBlFXpac51FwpfoLAHbv5+tXPr7upDBdCFW9KppFdlGWBUUUEnr9IY12kR4SLYEtV+JX5MBT03TMOQpL32j7jGz4uMbIXGUyy12nVC3YdR45ZK2EchIw8xFXzX3JAFbm0Xh3hnLnwkcRloeM7l0FkhbaA/guw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by ZRZP278MB1808.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:47 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:47 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 5/7] plugins: add read-only property for registers
Date: Tue,  3 Mar 2026 14:07:31 +0100
Message-ID: <20260303-setpc-v5-v6-5-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=Q9uEmDHxcY0R4KqWAXtElZSsthn+umT9ya7XG+4eC9g=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1kCpn7QgLlnC8xNJojVoakl2UAuKHjxV/kd
 0p/6SyVjDaJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9ZAAKCRCW6ye6MV/H
 fDrxEAC4/PrJ1YKqrCuOIZCKJMGB7TUP9sEKxBORzyomgvxuzCnZ4AZ3+gtIJllnnY+Ll4oPhQk
 l0GnFPJHApAZP7xgUuAkiO3VescsBD1SLIKj4mjv7bLyCf8c7UI/r92o5nB14qZkhKbzlRC9gm1
 cbolN5NQeaaxX9gB0JESd1Fznvc5KiY68wQXjuWChIeeheMlJZos5iQV9WkPPcHTGsgZ1+4b8hk
 74VSfli47bxCTfjHUqv8R+L6H3zzZ5LLktPRMZCcZOw273aVOqKEIZ+WOtksWNvUbxPcemYub63
 BiH/o22m1iPkJodEYDiYLuFEmLc7XcH2RppCMwYtTB0VoCGa00W/9fkNVK99v1Lc2hMy0Xw64a1
 P53xoyoV7jiUuSA67CW7lqVzCfw+9TWJMYXOnncL4gh4N6AS4uzIbZ8NIduD0mxdoIoNBr3YH2A
 1DqbMPU+s8joCvysZjR3excIE2KqGCnjjP0GYDWyYK1pD3rzRab6YF1bh3hjcXaLktMcLSKyirR
 sc8xwYwpmswnPyt0MR1lbrr6jks3NhMnXbs8m/aW/YtgmkMp9iY6YClHCwjBuWTyACaa9rMXmnh
 TnwwI1Mr9ftp/kPLZXaa0YYIZ5CMfdwSUpOmhXF/0ESL77V7BUGyCjgu2oGKOp9B/7UGXcYPuBq
 3X2JIDAsaXOpNYQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|ZRZP278MB1808:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f0ef23-f847-4d1d-492a-08de79260083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|786006|1800799024|376014|366016; 
X-Microsoft-Antispam-Message-Info: w4ik+TXgkQjmLKfF3vd7FuJZSCMyDD4tQFquPRX2QgUAydGnkrQme2ugTTYkk5LAClPdxue34+4UG71Vff6t5bAN4bHNXUz7HiDoTQt8gOBeiCbhKdqinsPETidfqn+UsCKzs2cfX8iC2bIitmEt/oRAId8JTbJxhLfbopE5jeA/S4+EHS/mVWoDtE4ANarNKA8knqOuBokAct4MbQPksA/vQcuBQRZ2lkrWWE8QD774htxIBvgWzfG6hNwshKbhTheF1xpHTGuVAA/GALuH8VTXv4YqOp++Z0AlbETUSp4Dsw12uGaKG1rBi3E4R95C7x70KXf1l/bi5Wt7JIQctWAaqT3htmLiBxtP7IYN5L8+rO88JCw47rqW3gSnX/I97vRTyz3xjm8NiEy9kkozMfUkijUe3zfzV9F74+nw85UVOk3RV+cz6pjcr7b3CjJBl+YdYslNsz3CrZmu8+mYftpyfQ3TkhO1V0cUXqyyiyEUVOI6MpfCmZrLijHjd0ohKbocasWv9VtKFU6HdVCvGubZRjrXIOLSmYdk2Tvvp4dFyOeASFjdxnTcNtMNRohFTVNSoeLMiRzURJ3T5AG1LH132DXYhNrYPWtV4ND/6YrKnxCf+N1W99t866MijuLBjxKO3KVpg6NM7i0knayYjx/8hBV06hrkUTBC1HmKXdA7+0sQLnZgmXAPFJqFRqaEYVUYfJ1ll0Qq2RDYN2DV1Ld/V/cTBnZrp2j71qr4efE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(786006)(1800799024)(376014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDl5THk4ZExkWkJiMUdPOGlFY0ZmY0VaeFYra1lSSlZGckoyTEpFYkVVTWxO?=
 =?utf-8?B?RTBVNk8rWFFteDJFWEhEYTluUkJUa0I3Z1VQSXlFUmxucDdMRm5XTHZORGhW?=
 =?utf-8?B?NHdmQTZieklvS1hUN1JpQm50VlhHQWxTMUJSSjM5amJzc25ROHVlVFBXWGlH?=
 =?utf-8?B?ZkIrR3hNY3dLenB1c3I2K2R1RlJlVVd0RnowSUVQR3NCMk9KQWVVd3dQa0Q2?=
 =?utf-8?B?Q011RU9ueHI3MUdzd1RDZXZhZHVpaEIzSlNUTllXMCtwUE9FVnFPT094bC9D?=
 =?utf-8?B?SHVZYWFBOWZYanFnZmMwb1d5RlM4SFQ2Snhpc0tadXBiTWdSMjdyT0ZDNjNt?=
 =?utf-8?B?azBWRWdJbHBmejZCZGE3S0VBZzFCQ2hzTGtwUkYreW1ZdG9vYnJhMzhBczY4?=
 =?utf-8?B?bUlYbk9LdHFXYXRSejh4NlJkUnZJa2FOby9CdHdtNU8vVU1SajZJYWRTSnpB?=
 =?utf-8?B?dHFVTXYrNUdLOXJ0NFBtNzQvaG9JMEU0WlRvZG1uVHd4RjhiVUVoWFZJbXVN?=
 =?utf-8?B?UTJkUlJTaXlMN25KRFBwWDk2NEVwZWJZaDhpWVl1K3FGcENpZElMWE4yR0xX?=
 =?utf-8?B?eDFxMGxrUHFURzNORTJKQVk4MjZKWlkrTDdNRHZYRTRmSzFpaFpKc1lqbTQ0?=
 =?utf-8?B?bSsyRURzcldPZERaY3pHdUR4OHAzZEF6N3dTcG9GT083bWs5YllQL2xTWUlr?=
 =?utf-8?B?MnRDMXVodkhRTXJVTmZCZCs2T2FQenJsQkdHeFFXYmpDODF6RTlkQng5SnBE?=
 =?utf-8?B?TnhHR3d2WnNodkZ2YzJuNnY4eEc2OC9hVk1mNU93d1lsbk5CTTdhaVpYMGdU?=
 =?utf-8?B?QUFza1ZxZGJvUVNVZ0ZPYk5qeXY1eXY4aFFta0NqR2tWNXd6K0p1TUJqUG5D?=
 =?utf-8?B?OWh3Y3d3S2tIWExXWnNyU253V0pTN2xETTBDUDNFa250Zy8zcmFZSWFhazZT?=
 =?utf-8?B?T3BhU2RNdHdGQ3NMenlhRmxETXZzR2lwTGpyWlB0bnhkdUFYbVBLSnNXaHZn?=
 =?utf-8?B?WG8xZEdlUEtidll3VFdyZzFLS2JNZDRUMG5pb1RvN0hQWCtUcURTSzZrUC8x?=
 =?utf-8?B?SmVlWXFMYlJYM2VwQ2I1cHBTRVF6dHVpNTI0ODgwaGQxbnRNZ05Samg1QXRk?=
 =?utf-8?B?L2ZiUHA1MFJtQ2lPenNMUHd2bXBGRGZ5dkhGOUFXT1dUYUlMUjNwTE9PdkZK?=
 =?utf-8?B?aTZpL2JhdFZwWVdmekJERFJxK1JDZ2tPc1lmZUsrdEl1SkJCbFYwa1lrSEgy?=
 =?utf-8?B?RkV3TkVMSHc4MW5aeTFJdUJNNng5OFdZOGVZZHM5TDNxMldSYmhvbm1jaUdo?=
 =?utf-8?B?Rnl2TUtlR0xwZnFWcG1zRXljR2lGTTdwd095T1NTSzYyUm0zcytPWXY3a3Bv?=
 =?utf-8?B?a2xhckp6N2ZzMkZOS0JlcVloakpPZ20yWWlOUjFIdVBhbTdFUDFCSkxaM00z?=
 =?utf-8?B?ek9Hd3ZBVTUwM1ovcEMzYllFTE0wSWRja0cyY0VDejdHdExJRm0rMjdiaUh5?=
 =?utf-8?B?bFE1bGhlbFdETW5BN2NsNW54RUIvdTdxVisyZkUvWTZadkdWS2ZDWDRiYTRz?=
 =?utf-8?B?RWdFdTBOc2hQR2VuTjJhaFFsWkNwVk50aDkzN0h6TmhwWXVDUEJxWkEwbnpD?=
 =?utf-8?B?L1BMcVFWdmxiZjEreTNFTU1xYmFWd01YTnhqSWZFaVU5Qkd1eUFFVXpCT1J3?=
 =?utf-8?B?TW9SeTBFZGkvZWpKdG95djIwTldWb3k3ZkJhSjV1MVV6MkhrQjdEYmVZNUl5?=
 =?utf-8?B?V2gzQXR1U01VeU1uZnBBcDJEY2c3S2crcHlwdWViVGEzYW41MHFlbTJNQmpa?=
 =?utf-8?B?bStBTFlnNzBYU3VKWTdwZjVrMzRUOXV5WmJpMUFZRDBTNFZkTGR6cmpiRjg5?=
 =?utf-8?B?U2I1MW9CZERKN1ZRTHhFb3BBVzR0SjcrQWl1V1pzU2tjM0N0NFZNRitqZU1K?=
 =?utf-8?B?VlFNRGVFZ1AwWE51QTVybXBtZ01wTFJsNStXRi96ZEJqdUsrWDhjSXErcUtV?=
 =?utf-8?B?OTlSS3dXNkxwaU9PUHBTNkkrdURmU1hzem5LNlFkZElkZFloa242cm56NExy?=
 =?utf-8?B?NUEyRWkvSHR4c3gwT2E0ZlRCRGJtbnUyN1NLMWxyZ1cya21HMW5iMVNoazND?=
 =?utf-8?B?cTF2ODJzQlVGWkNSajBxc0V4blNDMHJtM01wdEVwUkVlWFRnSGFrVkU2Z3h0?=
 =?utf-8?B?Y3NlcGJBbTFwdDRSU2VHNTBkUWNRUUpIU2xPbHVUQVVvRWhUd1FLUlJycVAw?=
 =?utf-8?B?QW5IWU1DWlowSm1lZzBXWkhkZWFaSE9pRmlzVlNmcWMyUDFYZGhNVWc4R1U5?=
 =?utf-8?B?VDlsL2RsK09aemd1MGdTVHdoY2wySzZSWUVQMXpwRFU3VUxMR0lHUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f0ef23-f847-4d1d-492a-08de79260083
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:45.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArzVZBTHurps5QbZy6pGbf4pkrV75G24PyXmbZXeDokv9rPiCT0Gwdkl6nOkf1pmktuQChFssddJR1uJjNCQyLYel9Lv/BWzKaeYlFwGl4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB1808
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index f083c30fd3..791d223df4 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -979,11 +979,14 @@ struct qemu_plugin_register;
  *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
+ * @is_readonly: true if the register cannot be written via
+ *               qemu_plugin_write_register
  */
 typedef struct {
     struct qemu_plugin_register *handle;
     const char *name;
     const char *feature;
+    bool is_readonly;
 } qemu_plugin_reg_descriptor;
 
 /**
diff --git a/plugins/api.c b/plugins/api.c
index 23c291f644..85b34949cb 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
  * ancillary data the plugin might find useful.
  */
 
+static const char pc_str[] = "pc"; /* generic name for program counter */
+static const char eip_str[] = "eip"; /* x86-specific name for PC */
+static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
+static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
+static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
+static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
+        desc.is_readonly = false;
+        if (g_strcmp0(desc.name, pc_str) == 0
+            || g_strcmp0(desc.name, eip_str) == 0
+            || g_strcmp0(desc.name, rip_str) == 0
+            || g_strcmp0(desc.name, pswa_str) == 0
+            || g_strcmp0(desc.name, iaoq_str) == 0
+            || g_strcmp0(desc.name, rpc_str) == 0
+           ) {
+            desc.is_readonly = true;
+        }
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }

-- 
2.53.0


