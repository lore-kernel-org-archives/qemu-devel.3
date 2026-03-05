Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96530F30922
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bh-000462-Qf; Thu, 05 Mar 2026 05:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bd-00044S-Rx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:58 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bZ-0007Sn-6r
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5FgsdxjZIOZiBwmm9jd7JIUE/v7FZ/KoPZj9d//7jcvk8n/xCM3mDHTtbckqp0YOwjLsgxN0dsHeIVS234cxa+7vF29aXK90mFhCPa6/hVX4NEiHRo/qzgpQuwQEFTbS6E0TtUKhnxcXjlgto8h/0PI7yR5R1rb0I9JBsGiaGPqA61T7YHaI1cUzvcarHgHqeZyfiHvYnLt6JLjCthS+1X1amdYQMr2VlbGWHo29aecEYzEJBK/VhliD1ICPMzkIeR8unF0Lj27jiIVPX/ytXD9pGzYxBtxdEzkY3jm2QI/e6L3IPZz8Vr+76ZneGsbZu0jWYTDJkBKvPoJlkZUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W487FoGgYqEbS+GNPutsS25vOvNzGckMdguewFXSo0M=;
 b=QF8yFzDVijHOQStoqG3sw7Uf4VTjblJmEep+/+MiBykG4XftnMU1hthr0uKP8VyQtYME/f+yjs5jj2aE8tU5EXYhkUcnOLl47zJK+BFcnWYUASCBTVXWnJou/IGu1HwDufGc1nhq3RgNm/z78d03CV06lPfuv0SQTfzvvIHiXBYLryKsZe4Ioam4GCCAmLRXYszBH4WRo1o/IXlKUBUAVdzJG31+MwlxlyOOS5Y7kDXztudCRxreCquqKgMnOW+c/Jvz4lw6eC2ceB/HDJZgirb0LwlL2ctVqTLfuBq5I9oBRnPvaHjXic9y/7JmHwFv03jVrVzxFbAaXIhBL09dPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W487FoGgYqEbS+GNPutsS25vOvNzGckMdguewFXSo0M=;
 b=fgsEKSLelffX3vUonoz9pe7a7T7hrJfsdnqm5DoYc5J2mbzRc/2SlbQU2E/ZFNY9Vhx9Di09keZzFX8zKyuCJsfxtOYyr/TwOjajALC27xyK+NZz/sSH6jox5S/RpFNp+dZDrsBer5et2gtivzMt30wneYIRCoHM5ULW+DofHQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0807.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:45 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:45 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 5/8] tests/tcg: add tests for qemu_plugin_set_pc API
Date: Thu,  5 Mar 2026 11:06:03 +0100
Message-ID: <20260305-setpc-v5-v7-5-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14451;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=77OW7QQCKB8AFY1vrSaAaJ7v6kpLO/GnmrzijtgOVpk=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTHrWCudPa5gS/ThmuZOjrbbfTgcFC1potK1
 smhCtixXCCJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUxwAKCRCW6ye6MV/H
 fPvTD/91ZsVsNo8E/XgvPzetV+H1O0R/tEmIpKzjbHE0KquPVOQlgGwZohAlSE3BemPWUml4+KS
 JBV1ww1Hx44FxaTEa9UbW1/Z5PnwBFlM5dhIb/7FrTnnlMwuHycgoa4+qrI8V/2wZC1xwNGDuUB
 OXZ/oq2EqM5xlYGszZeP8Kc0x8JzpZixkD+NxuHWUWdN2V2iiDq64Ej66BD/Yi5k83ibzdJmYUe
 wAjyI781HJxpOCrEdaUz4+HNppl9pbJ5xAyqhkbrBHpjTAMmQEaUmxZktmSEcoqTWeCtBU45EZS
 NMMW7nyMj9s1m9v1C4K36/l0+FD1az4NoBPbTlFCwfg0vrSDOkImkp1GKuUxqgzKrf2tUTpHHFh
 79Uhgn15CIBW9atRFO3eLW8sKsifZY04l00x5nv9k/691bUfgGNCv0I7rfAikqlozMDTA8PExu/
 ThAvVuau6vDLPL4RH6lWhZEsjReBE6Txz2SR+xQcBKyDIx1L3zD+dXGiXQB4re9Lqtk5UMp/31r
 TeAY8c5rRkZprBjFRWmmyW68rHiDybPL3y8Y1fOJbyde8Wh6R40DAT5XxgtdMree5F490XIuZ5F
 mtTpZIMb6bmhofUd71Od0ktTlw4yLCNBEkKRSXjblY19j5HD695gimvDUvbP+sm88jf8aq85vaS
 moaCkyexqwFWjPA==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0807:EE_
X-MS-Office365-Filtering-Correlation-Id: b1850aa5-a1b6-4b7c-6d20-08de7a9ee7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|786006|19092799006; 
X-Microsoft-Antispam-Message-Info: fL806ha5/G0jvgAP9ZNDBqvqPbqTutmh8rJG2B7ELFU16zlZ3SupfmZmTmbibuEYuU9QDEqoi+WcFugzEUPcmryXrrpvU6KG122X5QCvCWRgeyDvsP7SuoGjmC1ZUlKg9WQkfrtGJpRNpsRN28E55lZ7K3LTu2ZM31TVoA82fnjhe9tDgHBCoKgeGPcigZLAf84uudCoYfwOmuUFjYX+5SYs7E37YN2/Kr8Swh6j2wAFEKa8rA+BJUH63wuU8CL0CJa8mQd5Ins0RwGKqqMl1YLcK2w/pOJ8RXOYrw4tJE1LjQXRpExNtgSDGuPwpeH2O3lxbOBclkZKUxe8YXPNmpFOLPdWXmYHQ5iSyeFDe3kLnQeTq4TUW1wnfoEqnTlyEDiZRmB8Tf/JndKDfXc0YUUSMPI3yyiKCS4/VYE2ZvPAG0eBQDPwi6JLQ4BuHUHJ4RetkyaOzOQicF64XPtfAT6gRERyhaDruWzQ2G8Ozx/arPHjuXRXcZotm2RKAoEa521dznKotwq5xS6DVkN8EQu94IZhpMPxIf/Z2eSv6rl9u3qMoKQnY+xgS5mjR06YBs9OGwwgnPmxtDa2fltqDbRif6EdFAsuCXVMdcb/3vTkXtFvZzmvoUdF+6m01+nCAx6qFZJQqzljgpdUnmMso94dhChT4fPOeEsNSK622e5MjLcTamH2T4SapxTRLEzS6E2+V+zZSFrn52sW14jUL6baI0Xzzxkn+k7P16qKE+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(786006)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW50M3ZtakVnbmpaZ2w3em5Ud20wbFVuMHJRQlNsVkNmMUFvbTNRbjFFTCtx?=
 =?utf-8?B?cS9FTzkzQ2tVSGhraEIyVXd5RlN0bUo2MDd2eEhTWlZHTW5uR3dHajcvbmkr?=
 =?utf-8?B?VVBSOWRpdU05T0JZbENvYzZYZ3NWVlpBcnVZV0ZzMi9pS01zR0MvTTZCNDdO?=
 =?utf-8?B?WUJZemhqeTJ6RGhLSjl6WjFjT0NFd2Z5amtzQWF5SklaVCtUMzZlR3o4bkUw?=
 =?utf-8?B?YlpZZDdkczAwRUUrNUIyQ21nNndqK2xobXJocnNuZmVNTktrRDhVakJKZUtl?=
 =?utf-8?B?L3RDMFhoQUNiSWkva3BDa2NDRWlHdm9kcjVocm92OXlLTkh2bWl3QkdVQ1lB?=
 =?utf-8?B?SEUvQUVmT3ZsNlg1dkZ2b0o1K1VKZm14NXVCT1NLbWhhcXF1ajNvUExpdUMz?=
 =?utf-8?B?UHVoSDhHN1k5TUlXaXRrQlFUYWN0RGJFRmNMNHFZc0dyWDIzY1dDYjBLNzBW?=
 =?utf-8?B?TmNOR0JIYytnQnBNTDlFUnoxZzNQazZwd0sraGJNNzVSUGdBZ0RZcEtRT0Nk?=
 =?utf-8?B?WlNwcjYwR1UrUGpTcnR0RXY4Y2owbFNsRUx5cEp0MDVSUzNwd2ZHcUlORTVw?=
 =?utf-8?B?RGVsdUk2dVNjT3dvWVlHUGVnZWVxdTE3UFF5Z2p5Z0lZRmt0dWlnVU1jNGNY?=
 =?utf-8?B?Q2RMcVNHOC9qb29POSt5RXkxSjVaN2N1VHJmQ1lRVlFXdkhONk5lUHM4VlEv?=
 =?utf-8?B?WHNzekRXd2QybjNSWGNEN3p2Tk1tQW5KKzJoN25lY1NSbGJZNGdQeko5aW95?=
 =?utf-8?B?eTVLYml2RHVJakMxOFJYV3ExMk1ic3pNOFdyd2VKWGhjbHdrbW1IV2c3WUd4?=
 =?utf-8?B?WEJZVUdBamFKRkpVcGVjUXlXMVdGU29xZGRqWWNCc01sVnJCMkgyQ3Zsck9w?=
 =?utf-8?B?c3Y4VyszYS9zNC85WDRaNVVLeGdSeEhSVjU5VE5rbXo1OC9vMmdBZlNZQ0VM?=
 =?utf-8?B?M1h1aTdKZExJZk83MnlyRER3WVdkTHNUNjRVc1pkMTBlbS9GTkU1c0ExZjR5?=
 =?utf-8?B?V1ZMT01GQy9JTUNtNnpldzM4dGZScWdLblVOTm5aZ1pnOTZWTEFodHlqKzdE?=
 =?utf-8?B?RWdodzkyY1dtZnU5VUo5UWNhOWkzWkFjLzc1MWZHbGN4VHF1dktMa21uTDZJ?=
 =?utf-8?B?a2dHTE5ldmpaR0pZS01wbGlvRGpDQVI5ZmNVRmY4N1FWOVhiN3FJNWVOYldH?=
 =?utf-8?B?OW1wczdHWktzcGhFbXRUU2hqSmRLMVltaEFndTR4MHFHNC84TXhHU2djSUJh?=
 =?utf-8?B?OWQ4TENlWHk1MFlmdW9lVE12V0ZxU2NFL1d2aDhWajRTZXpJK054aEhidnFh?=
 =?utf-8?B?bUEvWjZDOGtFRUlxd0pwMEg4QmZubFp6a1ozclE3TGdLNDJrSlhINWNTb292?=
 =?utf-8?B?VWhET0NoTXNZOTkwZVlQTERLYWdsQlNFZXJYK0RxYllOSFhHamZueER4K1FK?=
 =?utf-8?B?bHVLZUFjd0RqSVNGTmdhcnJ1SW9RTlhURzN4ZUYyMjFCWkt6S3I5dEhpWkIz?=
 =?utf-8?B?RHIxV3FIWERvaUJVSG9zSkJtbGdrcGVheXpDVlAycUlIcHNNWWhpQXNibjRu?=
 =?utf-8?B?d2lVUlJXU3Y0Q3U0cXkydERsYUJZdTVERURKUy9NRldYdGd3aU9KQ0I4NUwz?=
 =?utf-8?B?S3ZIREhUa0pNTzBldzVIOUY4ZDhEUTlUaytGNFd3aVA2d3REaWtZUXd3L0FD?=
 =?utf-8?B?YjBZQXdDMzQvZVBLUzU2cng4cGF6Y2s5NGtOMzhONUVvb3lFcHB4aDlqRFMv?=
 =?utf-8?B?SGoreGFjNnJzUlBlL205RklVQkNiU0NuSks4dk5raHJZRTZJc2c3aHZ5eDZO?=
 =?utf-8?B?Z2hyYkkrS0dqSVY3ZDNwNE8yZzBlcnZ4dmJPd2F4eTR4ektrNFp6N0lXTGNJ?=
 =?utf-8?B?bXZJZm8zWFpLWDFUcFlWclMzbHJ6bmtzOWlJbk1GUDcxZVhMUDVBdTNWTXZR?=
 =?utf-8?B?QnBXaHFtbldzcTR0ZFEvVktENmtxNFFTSkFyMUtwN2lPYk9rY3VuTGx4K3Bz?=
 =?utf-8?B?ZkpQWnJLVTlWZk1iRkd1Y1VSL0FtWGxCUCswV1VHS0dPSWhmckJmczJITE5L?=
 =?utf-8?B?dWlCT2xOYkhJSzZPUUloUVREUVF6YnpwZVppSEFVWlNnTTA1OU5DczUySkVp?=
 =?utf-8?B?M25lUGxYM0RFa2doYkZlbzlXNm8vR3ByWWFkR2IxckNSTGVoOTdHR0l1akJF?=
 =?utf-8?B?Rjg3dENlV2FMQ3Y5b0hDOUV5MFIxbHduRk9YYXlPQmdqZFQvRWorb1VjajFu?=
 =?utf-8?B?UlpEMEN5b1NsWkNiYUkwWmRzeXZmQlRINXVuMGR2WE8zYzByWnozeVlUSHdt?=
 =?utf-8?B?ejZLK21Vbkc3M3dQUlJCK0xyYldUclB5ZkxRNHViZHpvdXc2VHFvWm91MGZx?=
 =?utf-8?Q?2Tz7YZUA7FdqVgbQ=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b1850aa5-a1b6-4b7c-6d20-08de7a9ee7d5
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:44.7787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtCqgnL4Jhv00b59nPqLcnYd2klJa6aWBJIJar8YSwnfMrg+apD8c1kWCdcCwMrv0gxPevePKzPltxYLnq6j5njWLAq/SQ71psXsXOf5YL4=
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

The test plugin intercepts execution in different contexts. Without the
plugin, any of the implemented test functions would trigger an assert
and fail. With the plugin, control flow is redirected to skip the assert
and return cleanly via the qemu_plugin_set_pc() API.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 MAINTAINERS                                        |   1 +
 tests/tcg/arm/Makefile.target                      |   6 +
 tests/tcg/hexagon/Makefile.target                  |   8 ++
 tests/tcg/multiarch/Makefile.target                |  17 ++-
 .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
 .../{ => plugin}/test-plugin-mem-access.c          |   0
 tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 134 +++++++++++++++++++++
 tests/tcg/plugins/meson.build                      |   1 +
 tests/tcg/plugins/setpc.c                          | 109 +++++++++++++++++
 9 files changed, 273 insertions(+), 3 deletions(-)

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
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31..a70ef2f660 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -126,3 +126,11 @@ v73_scalar: CFLAGS += -Wno-unused-function
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# LLVM is way too aggressive with inlining and dead code elimination even at
+# -O0, which interferes with the test. What looks like dead code in this test
+# to the compiler isn't actually dead code, so we need to disable all potential
+# LLVM optimization passes.
+test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
+endif
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
index 0000000000..f8343dfba8
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
@@ -0,0 +1,134 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * This test set exercises the qemu_plugin_set_pc() function in four different
+ * contexts:
+ * 1. in an instruction callback during normal execution,
+ * 2. in an instruction callback during signal handling,
+ * 3. in a memory access callback.
+ * 4. in a syscall callback,
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/* If we issue this magic syscall, ... */
+#define MAGIC_SYSCALL 4096
+/* ... the plugin either jumps directly to the target address ... */
+#define SETPC 0
+/* ... or just updates the target address for future use in callbacks. */
+#define SETTARGET 1
+
+static int signal_handled;
+
+void panic(const char *msg)
+{
+    fprintf(stderr, "Panic: %s\n", msg);
+    abort();
+}
+
+/*
+ * This test executes a magic syscall which communicates two addresses to the
+ * plugin via the syscall arguments. Whenever we reach the "bad" instruction
+ * during normal execution, the plugin should redirect control flow to the
+ * "good" instruction instead.
+ */
+void test_insn(void)
+{
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, &&bad_insn, &&good_insn,
+                       NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+bad_insn:
+    panic("PC redirection in instruction callback failed");
+good_insn:
+    puts("PC redirection in instruction callback succeeded");
+}
+
+/*
+ * This signal handler communicates a "bad" and a "good" address to the plugin
+ * similar to the previous test, and skips to the "good" address when the "bad"
+ * one is reached. This serves to test whether PC redirection via
+ * qemu_plugin_set_pc() also works properly in a signal handler context.
+ */
+void usr1_handler(int signum)
+{
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, &&bad_signal, &&good_signal,
+                       NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+bad_signal:
+    panic("PC redirection in instruction callback failed");
+good_signal:
+    signal_handled = 1;
+    puts("PC redirection in instruction callback succeeded");
+}
+
+/*
+ * This test sends a signal to the process, which should trigger the above
+ * signal handler. The signal handler should then exercise the PC redirection
+ * functionality in the context of a signal handler, which behaves a bit
+ * differently from normal execution.
+ */
+void test_sighandler(void)
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
+void test_mem(void)
+{
+    static uint32_t test = 1;
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, NULL, &&good_mem, &test);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    /* Ensure read access to the variable to trigger the plugin callback */
+    assert(test == 1);
+    panic("PC redirection in memory access callback failed");
+good_mem:
+    puts("PC redirection in memory access callback succeeded");
+}
+
+/*
+ * This test executes a magic syscall which is intercepted and its actual
+ * execution skipped via the qemu_plugin_set_pc() API. In a proper plugin,
+ * syscall skipping would rather be implemented via the syscall filtering
+ * callback, but we want to make sure qemu_plugin_set_pc() works in different
+ * contexts.
+ */
+__attribute__((noreturn))
+void test_syscall(void)
+{
+    syscall(MAGIC_SYSCALL, SETPC, &&good_syscall);
+    panic("PC redirection in syscall callback failed");
+good_syscall:
+    /*
+     * Note: we execute this test last and exit straight from here because when
+     * the plugin redirects control flow upon syscall, the stack frame for the
+     * syscall function (and potential other functions in the call chain in
+     * libc) is still live and the stack is not unwound properly. Thus,
+     * returning from here is risky and breaks on some architectures, so we
+     * just exit directly from this test.
+     */
+    _exit(EXIT_SUCCESS);
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
index 0000000000..8e66026d2c
--- /dev/null
+++ b/tests/tcg/plugins/setpc.c
@@ -0,0 +1,109 @@
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
+/* If we detect this magic syscall, ... */
+#define MAGIC_SYSCALL 4096
+/* ... the plugin either jumps directly to the target address ... */
+#define SETPC 0
+/* ... or just updates the target address for future use in callbacks. */
+#define SETTARGET 1
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static uint64_t source_pc;
+static uint64_t target_pc;
+static uint64_t target_vaddr;
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (num == MAGIC_SYSCALL) {
+        if (a1 == SETPC) {
+            qemu_plugin_outs("Magic syscall detected, jump to clean exit\n");
+            qemu_plugin_set_pc(a2);
+        } else if (a1 == SETTARGET) {
+            qemu_plugin_outs("Magic syscall detected, set target_pc / "
+                             "target_vaddr\n");
+            source_pc = a2;
+            target_pc = a3;
+            target_vaddr = a4;
+            *sysret = 0;
+            return true;
+        } else {
+            qemu_plugin_outs("Unknown magic syscall argument, ignoring\n");
+        }
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
+        qemu_plugin_outs("Marker insn detected, jump to clean return\n");
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
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}

-- 
2.53.0


