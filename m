Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D94F3092A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bj-00046U-PZ; Thu, 05 Mar 2026 05:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bg-00045T-CY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:00 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5be-0007ST-B5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAqxaXNDFG2ZJTOH6U4JZ8iwh6/1vpF64c150gQIJ/3tjU9R7orQX4UTy4HKeuhE8IacE4jmWEpuirdKTZRT1taQ/OtE4zLWGNleciMMhN+hwOxCI6ovqmTCC35SsdSQDmqLZvogdd3BuIr1uQ8lmJ5cW/e242O8r7ReSlcYkcNgJ3zi/ko9aJ1hgj1QjZ/eVTvqnKu4gn/KSQIJ6vphVbpVG0gTfunDCQGu2rNIczXILXAYkVisODqYEzyHr03F0r86c2hxL9JZJvzPcXQnvBV2A9AkJ1xyj1ZzdNZaVBdnqBRs33CToKyPQu0IQ62+chUks14VEQERDZidyVGyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rgF02aPcOgFgWyEtNUEf+OGAwc25BqNpTWy5ZMPlc4=;
 b=hFe6CLRZCPWg7eBVZhAkOL8pYF2BSUIA2m1xeH+IH9Odeb9jT02QjH/JEX6suDA+WFalFnKWgVLK67fwF9WnifAXJ9T+MHx5pTouwkjNmPC9rOGig97k1F8DXQ/RBueG4VMbR2MFy2VzQJHA/Eh//a+2FZ9l6HrmSLn/MgogPI+/mruiNTeWx04xvWzFtQEKtt5A9KrsE/6W59THsl2+af02Y7nfmtHiXKXuDtB2qHUfPW1JuQHTkL+Vh6Vq7gS83NkPtQqJt5MtFzzBQvGe33BH2koHq1titQ885vkXAZs8616P71BpZDAAe2Djwsx0VdRkZHA5rAXhab3dHaV0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rgF02aPcOgFgWyEtNUEf+OGAwc25BqNpTWy5ZMPlc4=;
 b=AetyohnNXgct1WI9Bi1RF91Qv4hUBY7AwDyweY7dxH4dkYhgyaMOKfal9gY+oxFmFZTI9O23vVXLml0tEQqZK0s2z17B6bnh82u4S936tJrv5AMsfM2jfB6S9tN8Ma8VmjeT54aS2o+v05EvOuKDMCLmKuBpXHAjvEpLatQefPw=
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
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 2/8] plugins: add flag to specify whether PC is rw
Date: Thu,  5 Mar 2026 11:06:00 +0100
Message-ID: <20260305-setpc-v5-v7-2-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7845;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=gR1nD4fZa4Q1U6q61h6IyFuviAbSW5Sj0Xj6vOf4uJg=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTC6tGDooxBSlLohabe/8n9Nw3pd7QjyvVEn
 eoQxHvU3OOJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUwgAKCRCW6ye6MV/H
 fIhkD/9TfcyIxb4cdI4KICDvcDx2J07Z5l7mtsxRg8YNxKOx4lYfCZ/VVUThUut6AMtHL1NuDCp
 U5iHB3A4eojtt8+2eJCUTVwnLnYXrqVfWLLa08VUiyMNdulhWArThTd01GJU9DR3j6sZIQc5Lvb
 QMpGQW4NL5dpj2R1JA6gbDryCzvjxSfzwBfrvXxKBH/UCbt7OdbOnNoSbDgoUMv1fIEYzBHSBXn
 EmFJ2S1hJT/qQiofvq57LBLJjZbLyxs17q0eeNfwMOCFLw6GPisLGGH8NomaQh/+7XLA6oZjqR9
 gQnA304Iw+x/SwMjlZvc9LJEYW5tz3wHYlw6UZIm1XSdsoCYxYXNR2wrWUNMwErnmZAtUU399ok
 uv9PNKK/IXlfaICHPo47QmMLGrPsxsdxcgHHOK0czrnxavu0LN8HiAhNiKvT62hcYmR/p0HLrfV
 Dcx0dlnKt4AkQGpCiRk8c42oZI6+pqdnmPx7EUdaSzeQQUWNw6RJrQ/0tgADsVli3bll6cE2ysM
 FPtRitofaQrKRhuVc/rkdoHNSXSOH7VUaT56xe7ed0jHBliLHDNsWMJmlAGYmrl7+zSrG52h/7P
 BaAxtmhE2tUsvettzSyRMzg4zQVlWgihwYvfrZpEOIz2pMCZM88qXMYY7zQ5GT6dTyLXUwARUJN
 hQ5DniI7ZlRd79A==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f35548f-9d90-4f3f-a02b-08de7a9ee733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: H5mKHhwMoi7x2a2NmDin8UEJWI6ly8A68hzPgyz8ht4lCSXRcbanL0edcwc0QnJKnP7yuShnWtk0eBgnPM3fmRIg4qV7KYjdGDw0H0YFKCBZKGIxv1AAuQdbmq5npbU7J8TkwDtiu1D6eTARr0Kz4CwarLBq1WPYQHBS/vRInDUTqE9eKj8g+m3T3NLhCJ11RMSKE9N6Ro/Cw6XymqxNKPBXMQSfx0y9sZjodQXkC5QVxIHX0fdFt7Gb5Kn5GqhffshPLT6TjsFn6JhCPG3vysfLD8EePwAoUh0QEc6e+RU+fGTGo23PT5Yw+fP3hJufZ+1BqqhXMQ7PUEWfEFUHkjrlruju1eNiSKPfqbCXgKEY51S53eZJNe/Dy0k2eDLdukM9E9LQIQacmofZ2cP0DRrtJ2WGpMUvnGexMj+wSslV8pBPmDpJMnBBz61hyaWobleUSEY1DOmNPpg8om0UKbImSytcjdTSVqw9z7IMvqmTBVrD1Zk5fcjCcA2vToRmcRfv0TIEht/oOngvWK4EKIU/+T+SMzSTEC5inQge2wkV7vCk1w+HWU1Vv9osuZYOPEXnncpn0b8TgmsNbq2gSvr1nKXmtXTgCJhQsaP/raLtzm9AAknZnu1eElquxu7AtVtopyrNLXWm6w7QE2lzlStAv5LKk+/vttYmnVr1DpvEM6b06p6U9kXXmzmSkcWuflp1BEl8kdPgB+G+ZTSNNlhKh9rtZW2ZPq0aghsNw44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZHVEptY0hGVzJITDdMc1dZVEF1N1RuWVpaMCt5MWhXU1I2Q3h5UDlIWkpG?=
 =?utf-8?B?a084N0ZhNHhZczJ6ckluTWtFTVlDTURORXhWRkQvRlVBMzlQa1NraEJqTnlC?=
 =?utf-8?B?bmI1NVZoT0dwM1E1QVNRRzhSdWtrd2F2VGdsdzg3bEJnR1dxTXNGSG8zMHZS?=
 =?utf-8?B?eHcwNERCRjM0aElQTU9BbzBjS0ZzejZxRXRvOWNxTDRyYmF5Q2ZwdTRISjlG?=
 =?utf-8?B?enltZ3Z0ZmFxbXZobGV2VnVCM3o4MkR2UWlRWlEwZmNkU0NFYlFBMTg4UkM0?=
 =?utf-8?B?d0cwZ2tEdjRGdjhWOC9VR2tWREg0cExmY1YxOVplOGhoN1JnaDlLcDVhWEdS?=
 =?utf-8?B?U1ArRDFjZ3Q4R3I0K0tSUTRCS1JSdXQwMVRHUXhlRTJWTjFjNWhVRkY2Wk9t?=
 =?utf-8?B?UFdZUC9IOGxQU3l1OXR3eER0bmlQTGxHbmM3OVFSVEdCTmxNOEpoN25tWTRq?=
 =?utf-8?B?V0JOTUcyRXRvTnZrU1F0WStBeEVZcUxJVUsxRWcwMytGUGFZS1lqQmNxd0tx?=
 =?utf-8?B?MmhXanFTbEt3Qi9oTzdvSU9yZmtPSW1iSWd5WUNrTzN1Tm5QWlJDZzNHVFhp?=
 =?utf-8?B?K3dyQ1EyaUR1WmlaVUFzeWswSmlQakhpQklveTdWUVpWWUx6RjRTR25IaVBs?=
 =?utf-8?B?ZUdPQjNEUnl5THplK0ZSWGIwdWlmSnhIdFRnb3RSM0U0NG9CbGxSQVZjN0NO?=
 =?utf-8?B?Y05lN1FsdXJvTTFyakxIa2ZOZE93OXE2amxhSXZyNkhQUjYwYmdKTEgzUXpV?=
 =?utf-8?B?cTl4VTRKb1dvSm1Ma2o1cTJ0Y3ZsdFdmZG5pRC92QkFYby93NVc0OUNaWWZ5?=
 =?utf-8?B?U21HN1VKL2pmR2treklaL1N2Slh6YkVNU3c1THZaV1VMY2VCZHZLK1JYM3Bv?=
 =?utf-8?B?cjh4NDhjaXAzc2txSVlzZUZ0ajFJTGpTUGpDejFmQVVVaUJDdVZmUXMxZUZC?=
 =?utf-8?B?V3Y0ZXZGTUI3UHl3TnZpOStMNCsyQm5sWmZpdFFRdUZ0bHJNSDJ3M3FMSWtp?=
 =?utf-8?B?NXdRZkczWFl4S0xqMjVZeHM2RmVVTEdoMHg2TE8xUTA2dmVvcmdPa1dGRnUx?=
 =?utf-8?B?ajJPNHk4MUxiTjVBNnYrSnVRYnN6TlhWY0tTUWF1bXduVCtpN0IvcHJtcXpT?=
 =?utf-8?B?TFNHQVFDN1liN3NyN2hJNjZCMlBPMHF1Tmw1eVFkeEFwUDFYUnNucW1zY2gx?=
 =?utf-8?B?bXZ4aVl2U3VhYTI2cDFXVmU3QUVISzlSRFJGZTBaS3Y4QlF3ek85TXkvbm92?=
 =?utf-8?B?T1VCcmNlQTlGK2NEaUdMbkVic3VBbit0bFNoWDA5N0d6cGNTQk9OdGNsTm8x?=
 =?utf-8?B?T0lzSmk5S2dWMWNFWTIwK2lXTHA5UngxVitRWEtXR2ZpZStOZ3F4SnFkTjBu?=
 =?utf-8?B?OUpmVmRBQ1V1MzJXS0V2ZFh4STNwZXRJQjYwajBKQnRZZGxRRnlSMG9VbTB6?=
 =?utf-8?B?YVZxbFFIRU1JNE12MTcwOUVLT3NrT3lXenRLR2lVZ2s3TWRSUWEvT2RKK0g4?=
 =?utf-8?B?R0N1bW5MclZKQThuNVVkWU5CVTgzRDArSytBUXphRERFeFNzbWczbkI0RGdP?=
 =?utf-8?B?SzVjcHM0QURlWndPM1BHTTlqSVhyZkJPVDBwL1hmakxSZ0ZoYS80bnVYaFoy?=
 =?utf-8?B?cjNKbFU2eEg3aWpSRHZpNnRnWkM2aFF1VE9tLzRwWFp3SGd4MzhXUk1MZmRO?=
 =?utf-8?B?ZjJ2WTRZMFlIUlZGR1lwQlZZTjE1UDhwYUZveDJQUHFCK1ZzYTVjNG8rUE5w?=
 =?utf-8?B?bjhXN1JYYWY3L212MC9vcUUxRGhrTTN2K1JGU0dGaDdsQmFhTWw2OXhQZVhZ?=
 =?utf-8?B?TGZWTUNEL292UFErZDViQUpOZE16NE5YcGd5NHFEbEk0RW54VWhDVnU3Q25B?=
 =?utf-8?B?dkxER0E4ZkM3YytuODdqNzFJL3FFWGlvUklCQ0RYQ2hwR1VVbk54ZytBV1Y3?=
 =?utf-8?B?WWFWTmh4eWtPcFp3d2YySzhIWW56bm4wYnR0ZlRJb0hteHlYcnZiaXpIZVZQ?=
 =?utf-8?B?QnF0Q2FiK2RoOFlLQWVOUUVPWTFSTzNxcVpNOFdiQlEwYUtUZnpMbU9MSzZJ?=
 =?utf-8?B?V2t1ZU5MYzR5SjRDb2RESTFRSmlvNHdwL09BY3Iya29FYWE1QTE3eStKM1Bh?=
 =?utf-8?B?UGtsTVJBTzZTcWdxNDRMeVlwY3p2RU8ySllGdnhXUFY3N0xQVWJyNVV0NkZt?=
 =?utf-8?B?RStMUEZEcENrbldlbU1PazFPMFQ5R2RrNXlwSkFEV0JEMHZnM3plTjJPNmR6?=
 =?utf-8?B?L3Q4cmdma2FGWCsreDhTQ2NxSzVndHpuMVEwREt5UE85MnUrcmpCTWRKTm9s?=
 =?utf-8?B?NHFpWFVrdDRxUE9qb0hJd2RLMmxWcnBWY0cwb3ZMSEZWbC9TT0UxcEJqQ0w4?=
 =?utf-8?Q?N/WYxAtxW6OvqpEc=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f35548f-9d90-4f3f-a02b-08de7a9ee733
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:43.6824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrVneQpJH9+qdjOG5jVF9ajATV7wJwCKelzDRHFQqy6MMarZGUcIBnhcHW+2y86FqiwT+OVHTIdRuaG8szY8vA37KwwvPcu7vH20Q2JXZ40=
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

In addition to the flags specifying whether general-purpose registers
are read-write (rw) during a plugin callback, we add an additional flag
explicitly stating whether the PC is writable. This is in preparation of
a patch that allows to explicitly set the PC to divert control flow from
within a plugin callback, which is currently not possible.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  4 +++-
 plugins/core.c                | 29 ++++++++++++++++-------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca9..a6ec8e275d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -325,11 +325,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
 enum qemu_plugin_mem_rw {
diff --git a/plugins/api.c b/plugins/api.c
index 04ca7da7f1..32eb086300 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -458,7 +458,9 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
-    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+    if (buf->len == 0 ||
+        (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
+         qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
diff --git a/plugins/core.c b/plugins/core.c
index d6173422e9..2324bbffa3 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,7 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -553,7 +556,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -577,7 +580,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -605,7 +608,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
 
     clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
@@ -626,7 +629,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -635,7 +638,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -906,6 +909,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }

-- 
2.53.0


