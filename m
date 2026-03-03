Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC9EC143B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPZ6-00041X-DK; Tue, 03 Mar 2026 08:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPZ4-0003yd-G3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:13:30 -0500
Received: from
 mail-switzerlandnorthazon11021122.outbound.protection.outlook.com
 ([40.107.167.122] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPZ2-0001Ga-SA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYhqYu4YxlKVdOmD1z1uWXxc9gLV54jWwB7aOmQHE+huIjnHM11iruYjY7JKz3IhcYYlFgHWVkluAHtvdqQKCepXsScrDNNuhNGgwU8TvwNBREXUc2y08vpYgnma6tU2egQ11fz6slMMpQSolNpV9g/NB9+EDSLKxj9iici0QQx4fZyxletLaT6Im6IwlbDOk6YdtUQpI4ugFN2iA/39+iIFRFumWu+VhFjAIgFp9Rc9t6SbY+0IkN5k4VYomcq47ZKZcIM+4TW7O2Kr+qPX1F/fkArwWhcwPk339LgylZKAQ2q4fd3hqEjKA4cyIqrxFysA64Zm7aEIrEH1Pr0Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tln7FObLC6Khe4z8e/wBWZGn3sbeacx1bT498SN62OA=;
 b=UPMoRte1LxzR1pEJCK0uv+cY9d05dcI+/T17HOGFLNed7jHbc3tQvOJr7wfBwCENbvkjTQawCWE6aykY2c4k7TlaA9dyQyCRxAWrPWWX8WbOq6y6jMkt7/8Iqj/N0/Zb8MlQ1rY3H2zFx8Zu8Q4q2iUjZxmsmswKZJwgoTzczpzGRYvYLh6gmTB8XGc+kHeTWNMwEVfe14CAB42f5Pr5iSkAD9kd+WWmCObUhvUjq/0aA86qBIqozrVol8aAxfPU0ffTpR64HtSPS8PmUYMg6zcR1P7XC0MLM6yEIfVix1uDJGJUcXC6cseUGR7+rhzvPa9V3r3Hl6soxqwQ1FMkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tln7FObLC6Khe4z8e/wBWZGn3sbeacx1bT498SN62OA=;
 b=PwvQO9nCFqPBBg0jdURjhfV5LrcRjJlda8pTIQVcqmgVda0Lvniq85jaCoQyeNEvInIdF8rcRMMNfKH6oFFjYFBa1ycz3uCMzxuWbAr549w8d1QtIFenK8aDnB/MthDEmlYpFDrLmM0Q67mp0RygRiSPhwfHdH53tEcg3KnmF64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB0984.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:22 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:21 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 0/7] Enable PC diversion via the plugin API
Date: Tue,  3 Mar 2026 14:07:26 +0100
Message-ID: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260303-setpc-v5-c1df30bad07f
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=NCy3opkNA26PInn2rAwQ49fryJrfkEwbjAtz5nc8NnY=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1Ykm2sRnpyQBnatteyZOnk2Gf3wxiAZBq6N
 IKG78sBTa2JAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9WAAKCRCW6ye6MV/H
 fDYBD/9oXX4J+tqI+0KaV+V0gc1H235LAqJhm5ho4K7QMkD/de9h7yLFfJ8jjkURKyPkdQ/pyWZ
 RxiO4gV2mFiPuSDkK3S7aognpALzRuoMc4WXknCnBhJRAr8xdj26Qsib2hB0SokKg21MV849hq7
 4B6sj2ULaFtbsrKHBA7yxmGibv60gukT1Y1Id0jLnTLMF3SFfV4wp/j/dg2/J2RsmOmKnREMy99
 lBs+DMRAPu0Yk3UW7li2Wm069QSlEq7mq9r/gsZyCAfR2sig4g3e5AQsuzZ44CuFYb0QdXGM6rv
 /Tog+vodvXEx11pSa84XkP3O8rmLgwC6thAQIekOJWgGVDrNtVlFJgtaG2qmAIg9z2q5QfoCQ3J
 PmDRbXEF90884i2NxjrrBkG6jxTjn39Digf5j8eqWNLTEOHWmEJ7quRnTmFvX0zcM/iXirWbkFA
 SFSFCQw+VqKCu2AAbKoCCWAnT1FD8Lh8vtH8JNvnv6fI0J329qBkf0F0JzHZx7FKhiStFvrA7ir
 mv9dDqYLgJ+rbswFheeoIJMp1tXYuSXJeUf2Wp56T3/ejaEUIb1nfb3DiO8T5icN0H1Pww5nJqc
 Dj530bFfyif+YRV/dMbUqL9QtNhlPRcojELDRZ4l3r64F7+lLxyH+v5c7LpKpGb64R5pCEmIa/4
 mUeGAQiVf4mDPzg==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: 118e91e7-ea0b-4a34-e4e3-08de7925f220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: FtHc/OCN+StezRbaXD2Oz5eQ5QZeZjuRQHcrLIlWa/TMcQX9XojK0XwUXolgSXmHtZj20YtlHD1b5KcQBgetEgjdf3glFn++g4ZDHk+3LPRBUItCGiy1Eq8tIXkI6aYkeVLyugOqDAn9SduDyda71kzleuxHVjQ0uLSPFRe5ZD4OkiG82evt8Bf9GE3FZ8i/v48TuEypTVHVdSyHNxmmnQPFeVsq/lSAWuvXQ6tHCDDOMo7IqyUC2GiUlpOUfWmcA5Q4N+MN6R+s3ueC5TmNlfUx1pcOjoKpEed2i8jUrUiqBRl/MbY7tgNmNc0vsBBo6xPpv/gMQKsQlxZCSwPlLu7vQ+bN/JcyoPwnkEu4XlJd07TLw3BQvteKPRAxrIIl9Cx4UzPoc+t/CNWmWgpon6g7J91sUBasvVpMuIL3OB0oKV1pyxqsmPqo3xcJG3N3oJ14kKTNK/PNT5RWZIVMO9Ayhd28yrFfIU7wASDjFfDhvg4oQ67tXcE8sMvl8N/263cD9dkGD90PCO5M4cc1PI9VNeiaWrFG5wSNWU3keQEZtpwV8n9c7CrL6eyjlq7bCHaEAI2q9ubxPCmvX+lWUTGuVaY+SAYh7Of5X9EtW7VLMpsVH4q5iIP6hZeABxIxQAz7FQpE1r4J0yckNeWolJ4vUsLvwdYPGY/icPa4qw16dIIIi620Yw/pWkI34J/Qgit727rvbOoEiVpM4BblCsMtP/RaNl/NMT98mlG1yTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(19092799006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDM3VnVNYWxSQmhMQ3U1SWhjcVkwVnE1bFFkUGxGTlNHZE9YQ3FsZG93RFBJ?=
 =?utf-8?B?c2wxOEhzb3dEcWtvckZaTDFRamJ1bEo1eEQ1TDZKaUhOVkd4b1kxdmI5VVpE?=
 =?utf-8?B?MWRhbjVtaWJGbGNwU05kd29oOGF0SHpIeUhPOFB6MzJUT25QbzFieGdFdnpI?=
 =?utf-8?B?V0hBdHZMbERQNnVOT00rN3ZHT1IvbXlmb256QUlJOFk1RlBMWncwNzB1a0kw?=
 =?utf-8?B?LzVZQW13M0ZGemt5ZU1SbE85dkNpVElVcSs5Q0FkbWUwaU40bWRoVUEzNUI0?=
 =?utf-8?B?ZE53ZVhzdUdYR3JZbmhGc0VsYlJjTnBvUFBIR2M0OFVLbFFrTWx0dGdabmo3?=
 =?utf-8?B?MzN0WERJZHBONlhvYXUzRndpK2IxVnM1Y01tTS9uVGR3dEZlcnd3V00yOUp5?=
 =?utf-8?B?R01ueGFpRStXczBOUE9nWDlOeUtsSVVVVmRVdkxBWmRGdzJTcnNlVkpqZXdz?=
 =?utf-8?B?aVlwQnlTVDJuMkVZb0NBYmdzcVdNbktnRTVLQzZKVFF4RmU3eUJHR05teUh6?=
 =?utf-8?B?WWZKa0UxdGVXeXNBZGtRMHVZb0wwbEt3ck80eW5JZkZkWG5LbWNEbHVFdlFE?=
 =?utf-8?B?REp4ZXFoWVhod0YvVUNsZ3BnK3pFa2xLRlRTUVBiaWF0d0c4a2p2aDF0aVRH?=
 =?utf-8?B?eEsxWTV6OVp4ZGpyMWI1U0JkNHZPaUYwZjA0cWZVT0daUU52TDBPVk81d1NG?=
 =?utf-8?B?c3RtNEw3aVhyeHdOcWZSVk5aaDEwUFNDMm9nSnZHY2VmV0NhWDlUbDZrbndP?=
 =?utf-8?B?bHIvSWFDTFBMZHVQbXdoZTVzOEJaSlJMbDFZQ09mKzFTMnVKWEtCWjhqSTZD?=
 =?utf-8?B?SHV6WjEyZllINFFTVXM4MXk0dXRXOGl3WFlKb1c5M0FVSlV3dUNwbHQ1UU5H?=
 =?utf-8?B?U2VkVEFFTGY0WStuWStnclpvMm1ncS9RcG5uS2ZNcnNiZ2VwSUJjd2JsREha?=
 =?utf-8?B?c0wzb0s0UjNmQ0syUTRMZkJNV2pVSURNSk9yOVIvTDE5WDd3bkNFNHpsWS9m?=
 =?utf-8?B?dEh3V3g3ZXBKYi9KdjF0ekFiUi9LSkxWQXRCc1NWaG1EUGZJb2d3VitzUkx5?=
 =?utf-8?B?WnE4UzZVdUJVOE4wK2lSby8wK3FpbURIWjJ5c0lSei9TYXd5UjB4anNETmFs?=
 =?utf-8?B?L0ZjREhlcjYzQjZpcDBoemJMaU1LMDNvakFjMFQxUkV5MDkvWGtjclgyanlJ?=
 =?utf-8?B?R2RoRVdOSWx0TVd4YXZVWERheXhnb3A3MjhVQ0c0UUgxdGhTK25XcUt2NUx5?=
 =?utf-8?B?ZmkwcnZnVjQ2QWxYY3cxYkZEU0ZrMHJyZmtWckVuM1JGZFY4a2ExQnc3Z1NZ?=
 =?utf-8?B?amM0cmh1VzJuZDBPanhOOEV1QVRTUElyc2RsRlVVZmpZRnR0V3BEbEZ0MUFl?=
 =?utf-8?B?bXpzU3haWkNsb0xsUThLaXBjeUdxM3pDdzBEWmdnWmUrOHJ5Zml3M2dEWnBm?=
 =?utf-8?B?aFNvNGQwSjlUUStnNStCSE1lbFhWeDZZc1lSWHBKNzFoV2huRDJYbHJtNTZB?=
 =?utf-8?B?Q0JzUnFYWUNFZXNDVnpsUHV1Z1VQa0Z2L2JrNkY5SExDR2xSOTZqcnBzN1Yr?=
 =?utf-8?B?RWNHOG1pVDI0a0M0dktZc3VNU2Eydld6Y080YmhBMVFIRkhVY081bjR3WWFk?=
 =?utf-8?B?UzF4dzJZcXMxMk9IaitJSVFsVUhRclhLTGE2clpvR1BOSTVONkR1MjZxWnVY?=
 =?utf-8?B?Tk1DVUk3bXJyVUtFbXBIU09KcGdPQ25SREphaW10ZU12b0NDWFU4V2VVazNL?=
 =?utf-8?B?Sk0vdytYcUlJcFpvNVhrRzNraEpvUnRaaUx5ZFFPWFJuKzNHZFo0aTkwS0dO?=
 =?utf-8?B?M2M1NEUxQzM5TkcrRjB2enVtMWdnUXQ4OEZVRmpqTkh2YzdhZEovdXdpVC81?=
 =?utf-8?B?UkFacVJwRXRmQ2ovZ25pUHEzdWNKaE9kSnRFdDFUSWVCV1hUa1prK0kwRkV3?=
 =?utf-8?B?VmpLWTV5NDdYMk9MTnN0ZjZ0ZXloS2FsZS9mc0lSZHgrZnpYVnN3VUhYUEo4?=
 =?utf-8?B?Q2t0NFc4ZDBtS2dQRXJGcFVLcHNvVmJ4UHhPTUt0bUxDRWprR0N4Uk9COGdk?=
 =?utf-8?B?blpHdTFKU3ZZVG5OQUhrRG1HeGhsUkZsOHplMGhnUFNEenByRnlzNUhhVmxi?=
 =?utf-8?B?VnEvYmdGVmwrSFJOUlhpNnpBRG5pcWs0bjZ4SGZDVFRuK2xGeDJaU3JPWTBp?=
 =?utf-8?B?UXVQVng2T00rRE5JSnlCZXh5TWxWRi94R1NFU2IxL2s0Sk1NQllOdVo3WU9P?=
 =?utf-8?B?RlJ4LzBRdmJEZWpuWWI2M0NNRUxDamRWKzEvSm56WUoyQ0tsTkRNdU42WXl6?=
 =?utf-8?B?R1Mvd1pZOWlvbEdSUmE4QlQ1VnlIeVFCRGZTT0Vma3k2b0JNcVhQUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 118e91e7-ea0b-4a34-e4e3-08de7925f220
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:21.8618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCiQyqO7UKoPb/baDVJgoYiAeWl5vP+4UzgjhvKl9U2iRzL1P1KJIWV2BscPnn537BABkfNXqfmnP0Ppo/hG9g1K53zEQQA7BGyPe6qRFUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0984
Received-SPF: pass client-ip=40.107.167.122;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,=0D
=0D
This patch series builds on top of the discussion from the thread at=0D
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epf=
l.ch/=0D
and adds a plugin API function to set the program counter of the guest,=0D
as just writing to it via qemu_plugin_write_register() has no direct=0D
effect.=0D
=0D
This version v6 of the patch series addresses the requested changes from=0D
the previous v4 submission and an incorrect commit message from v5=0D
(details below).=0D
Note: checkpatch.pl still reports a warning about line length violations=0D
in patch nr. 6/7 but I did not fix this, as the line was already > 80=0D
characters long previously, the change added only a single character,=0D
and I think the readability of the code is better as it is now. Please=0D
let me know if you disagree and would like me to fix this!=0D
=0D
Best regards,=0D
Florian =0D
=0D
Changes:=0D
v6:=0D
- update commit message for patch 4/7=0D
v5:=0D
- make QEMU abort via asserts instead of just returning an error from=0D
  the plugin API if preconditions are violated=0D
- extend tests for qemu_plugin_set_pc() to different contexts=0D
- fix issues highlighted by checkpatch.pl=0D
v4:=0D
- switch strcmp out in favor of g_strcmp0 =0D
- split the patch introducing the qemu_plugin_set_pc() API into three=0D
  patches, two for preparing the plugin infrastructure and the syscall=0D
  handling code and a third introducing the actual plugin API=0D
v3:=0D
- make PC registers read-only across architectures=0D
- add tests for read-only registers=0D
- adjust test structure for qemu_plugin_set_pc() by moving=0D
   architecture-specific tests into corresponding directories=0D
v2:=0D
- add setjmp() in syscall handling path to allow PC redirection from=0D
   syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for=0D
   exiting a TB would not be live anymore in syscall handlers)=0D
- add flags to ensure the qemu_plugin_set_pc() API is only called from=0D
   contexts where the CPU is live=0D
- add test for qemu_plugin_set_pc() API=0D
v1:=0D
- initial version=0D
=0D
---=0D
Florian Hofhammer (7):=0D
      plugins: add flag to specify whether PC is rw=0D
      linux-user: make syscall emulation interruptible=0D
      plugins: add PC diversion API function=0D
      tests/tcg: add tests for qemu_plugin_set_pc API=0D
      plugins: add read-only property for registers=0D
      plugins: prohibit writing to read-only registers=0D
      tests/tcg/plugins: test register accesses=0D
=0D
 MAINTAINERS                                        |   1 +=0D
 include/plugins/qemu-plugin.h                      |  19 +++=0D
 linux-user/aarch64/cpu_loop.c                      |   2 +-=0D
 linux-user/alpha/cpu_loop.c                        |   2 +-=0D
 linux-user/arm/cpu_loop.c                          |   2 +-=0D
 linux-user/hexagon/cpu_loop.c                      |   2 +-=0D
 linux-user/hppa/cpu_loop.c                         |   1 +=0D
 linux-user/i386/cpu_loop.c                         |   8 +-=0D
 linux-user/include/special-errno.h                 |   8 ++=0D
 linux-user/loongarch64/cpu_loop.c                  |   5 +-=0D
 linux-user/m68k/cpu_loop.c                         |   2 +-=0D
 linux-user/microblaze/cpu_loop.c                   |   2 +-=0D
 linux-user/mips/cpu_loop.c                         |   9 +-=0D
 linux-user/or1k/cpu_loop.c                         |   2 +-=0D
 linux-user/ppc/cpu_loop.c                          |  10 +-=0D
 linux-user/riscv/cpu_loop.c                        |   2 +-=0D
 linux-user/s390x/cpu_loop.c                        |   2 +-=0D
 linux-user/sh4/cpu_loop.c                          |   2 +-=0D
 linux-user/sparc/cpu_loop.c                        |   4 +-=0D
 linux-user/syscall.c                               |  16 +++=0D
 linux-user/xtensa/cpu_loop.c                       |   1 +=0D
 plugins/api.c                                      |  42 ++++++-=0D
 plugins/core.c                                     |  29 +++--=0D
 tests/tcg/arm/Makefile.target                      |   6 +=0D
 tests/tcg/multiarch/Makefile.target                |  17 ++-=0D
 .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0=0D
 .../{ =3D> plugin}/test-plugin-mem-access.c          |   0=0D
 tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++=
++++=0D
 tests/tcg/plugins/meson.build                      |   2 +=0D
 tests/tcg/plugins/registers.c                      |  79 ++++++++++++=0D
 tests/tcg/plugins/setpc.c                          | 120 +++++++++++++++++=
+=0D
 31 files changed, 495 insertions(+), 42 deletions(-)=0D
---=0D
base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9=0D
change-id: 20260303-setpc-v5-c1df30bad07f=0D

