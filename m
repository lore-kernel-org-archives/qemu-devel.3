Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CE6F30922
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bm-00047C-7z; Thu, 05 Mar 2026 05:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bj-00046V-NS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:03 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bi-0007Sn-6Z
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY4NxYRvBGFwaiY78coeZ1b7nUuhQoEKc4j3gwxJFFzDIJi+PEOhIEECMdAvASjen5E5HWUf5VFzZs4pQ7ZK112AfskaEWYfj5pKHxKsQrQwVx+aMf2qj23/R0XRdf1tho3Gqg4ZzWdkKG5CCxCPW3C2la6sDpashd0jh5D2D9K+CiQ2otSo+tM545VDIlQG//6ur+VRXl3GV4oI7UQonAXenmSVcGvJ5SBm4jceL4BkNaFznvgS2y3Dl0eKzRC6tCMB77hpKGBM7U3utjaPVvmi8Q1/FOkR7hp+0/cxEBsZ4Vhe4kNOrYgblQAyigf/i3A9GGJf5sChQqMI59LZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSIaB9ZoraDUaNGsdLVl6Nc9clm8nzVzgacjmHcZEdQ=;
 b=S0CJMOVTDVvl9TzuKaHkZPPRqOIZe8/GYJd1x0Z0aMgz1U0K+MVCThDrIEUAxnklXbSsNOiQc98dF+Ofzik4+NhP6QJ0oir+yz/r4WSFFC+VENd6vuiDbgHc3xnF3tGWgy0sj+06Dkvjf4Z0nwIo7GZl7yiAiRi/VXPgELiJHck/MqmGkCbSV1iD8hPVcJBRLzxD5pzg0is14rV9XIVNx76svGBBBwODKxyKUqBelur0OrBWjfGut5ioWdJ/EuHUmwS5tIkbf4Fmx23eSBFJZACR66O5HAoLXK89koTqrILKs2mJQciB0zMEVhdpfBRmkKR/cDJjliMjoL6a8gSbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSIaB9ZoraDUaNGsdLVl6Nc9clm8nzVzgacjmHcZEdQ=;
 b=YbC2W5ufpPXjODkWyCMSvLEA7IjSrGiL+yyy7+FdFNVuLrQ/oUoEJo0zdxMHcJRJUNX/NZ1RS/c/jk0YYTnEC+xFRyk7FQo05W0rI8HlVgX0lhxYFXY9Yt5qRPdqtdI7algbnIgz0dl4amoBxlQZZSjgIkqO5aExNQcbZ1JZtRU=
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
Subject: [PATCH v7 6/8] plugins: add read-only property for registers
Date: Thu,  5 Mar 2026 11:06:04 +0100
Message-ID: <20260305-setpc-v5-v7-6-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=APUsCVP8/DfH/jhU0oaiJ9Yv7iw6vdesPLxp4XQ1Mxk=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTJvlFcSeM4luuI2twPw3GsLScy1dDsO8EWo
 E8O3h6Me46JAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUyQAKCRCW6ye6MV/H
 fMOJEADZrInR4ArqIiQkHj2fJNJ/th7zNQndg3CK8uimcyixArsQyMU60AYFU1X++z2sGyGQZi4
 L7KIdVI0v1cPraFek2DLGkawO4WK8CXf6SUhzUeAOp8EueUWU1jZE98pOloOEejApjCE7anDwaB
 ZC1GlS9wf+pIuh6v+y7fl1KRWvnUiffG0KyzgjpdBLX+7THw/FxB3qJv0OPJK69XOdy44lQXiKu
 +lyEi1/OsBL9KjJzr81YBdnPzlIhJ2smNRWkyDvZ8OhpSeXL5gUm0R74xW3BVssmsyhKVbqykXq
 aEhtYJsGI9gsJhKqQ0NaNzeI4jHR9cYUOQvOSa03YQwZ0blCvHJrGOHgMYoFG6mGE9A2aDxnoNB
 BWTS9xFXPLqQ5wqX45a1bSWpBREd9YQI49kRyXvrqnnzixqjb55uMOojpED1C8NWHg8h/d7IozB
 6VMaJzKcBUh4cWB1MBWMuxl+AaOVfGamudgzZdDk6NGA/6ZkgdznYV5qAIWmx+y/ihM5JKdfX9N
 mQpLQSmCsfh7se3h6ZGIbbZB2TfjAVcpbIT6jJA0qRN9lE66yD35noFj20VDkZQvxGFqurDlNnC
 XIwv8IvBOjlKrFY9Fh8Xym5EyrVwJekptGRxEdx2oW8rMpBn0JcnsZZtkXuqnWTecXvQFranNo9
 qS2a1n1+s1vxTFQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0198614e-22b5-4109-28a9-08de7a9ee80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|786006|19092799006; 
X-Microsoft-Antispam-Message-Info: 44WxXNAexfE9XGaZPOwmaaF4O46n27A/bwB5NsaiNbFiJjSsO1AFsJxwpbmaRkaY5kbhZ78zPUBVqMPTEqNYK7Au3TaPy5cA9mAnq7Anz/7KyFHfmG3LKprMYzs6bGkjwXKwDa3UCJparozqkl+HDbaP+AujrePQB5d1W0zAXGbMsl36mtjmfJA164WwkeER/aLzt5NbzFdbKiOGqZRZjx3/fmDMIKYrxZkm+BIDHJ3DMxACZDcmwJje+i3xHzLb4zULGyJCzlWidggVFTNC+01alWy1MH1zvrbRBRg1F9zEizJKZPUwiPCIoZPE3beYc+oofmZ9Cg5T2BK4P7T3k+DAal+Ul8sFrGVIBWm56+bEHvCtNkqwdiRYWtPRicvfwMI84jooOzD+Cqc+T5tVEbjvAG2IPvWPo7tTpJ6m7XJsYC130pUZaPPcNzB8SAqq5+XKDgyxIiWB91W+68xTci9GTKTNUI1OyjoCS/SnXp4QarL9UfNutNKjqBPuIAkwJW3p29Xd7al/ECjuaCgJ+uHjos5hCgReuRhhzNiPeItkFlNtgerUyjpjrxV0SPLUkYwm9Y2BgiAmw7BbaKMfHZQZ7O1BBHmTCXdu245Ol/Jw5eduXm5NPyTlUtpH5PCNzTpDI23fANyDduNKFwvd1Z3PTBNc3xyRmkzBc5WMnjqP9NcJblYZOxauYeEfGlpSuP4GgmwjmpTMsPQwVPOqYQBhweHtLiii+gnT6Za5EOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(786006)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBJdi9ZZExHaXJZaVN0UE9aejlmdXM5OTRmcnlZaUpuVlZUaHNObmlIVyt6?=
 =?utf-8?B?cWVmUDFyeGZvMllJU0dTejRJWkxJU016R0NsTWJXUkhYRFdYbWRjRng3YWd4?=
 =?utf-8?B?Wng0YnNjZFI3T3VZeSs4a1NhTG5NdGhpRHQ0VnQxdXVpcDF2TWUrZE1Hb0sv?=
 =?utf-8?B?TzZ4YXhqc09JL01YU0x0TlQ3SUdHRm1NWmhpcjQvZVRSZEV1d0lnL0UybFFp?=
 =?utf-8?B?eWpqQkxaLzd5V1B6Y1FVV2NTZGVyNmVBVGsyVmdvZ1ZxZVJob1lYbEdMMEpa?=
 =?utf-8?B?NWVvUFpEQnEwN0gwUjRzeXF6dmFlWnVBZ082R0s0aUVkRlB2eWxIaDgrcExX?=
 =?utf-8?B?OHFoNmQraFEvOEdkL3ZJTndHNHJkZWRlcWdqRGJOVTBsMXhLT3BBSmQ4RmV5?=
 =?utf-8?B?YUZUbm1Bdjg0VzZNYXJQbEwrTjJvUEc5ZnF4emtRTDc3SU10clpHMlpCOWMw?=
 =?utf-8?B?OCtFdXNjN1BjTElsVmVWaDlXdC9XYmdjdjhqYnp2VVZuRjRSajJYVXVaaUty?=
 =?utf-8?B?OFdwNThydjhGdEYxVDR0UmpLdlB3VGtpMnZUbFJoajdJMnZsU2lwTXE1MlBK?=
 =?utf-8?B?QlNKZ1pSRHpnS3F1bGRMY0JGeE8wNlRCMnV5YUtsTkptWCt1S1dvZkI2UkNx?=
 =?utf-8?B?VmhFNkdISCtIL1JJeUxmM0lqbTloVUI3cms1VEcvZXI2Q3M3bVk2VHpoUGZL?=
 =?utf-8?B?cTFCOXZnaWJpakloVDV1d1hGSTVxS0t2aGgveVFJNSs5TzNBblh0QnM5c1N1?=
 =?utf-8?B?TWtJMDJCNlNXRHNWMW9SK21pait5UFI4cit1L0w2WXBrcUU2bldpRE4xa25R?=
 =?utf-8?B?L3M3MEFQOFkrQmlZTW93ZzN3enI2blhtSWF4TkUzVEVMMy84aGU5TXlhclh3?=
 =?utf-8?B?K0JEQUFxOTF0SWVXSE1yaWtML2J0anhoTG4yNWV6ZVJVYXhTRXE4bVdHNVJ6?=
 =?utf-8?B?OVgrZlliaEc0ald1dDZ0S3hvQmM3L216STVlbVhnY3g5Wkk5T2Q5aHZVVFdp?=
 =?utf-8?B?S0szalhidVVqbnZXN2YzdzRXVlJuQk9IQjZqaFozK09ZRmoxQ1pVWkFKeEV0?=
 =?utf-8?B?b0dsb0U1VUQzN3I5a2FreWVhQVFZdVpDNzh4R3AzL005aTE2VldFVCtEbnli?=
 =?utf-8?B?cGZablRYRjdGTDk3NnovSWtyeUF0ckY0RHVsaEVuaHdxVUptYjlqUWtXMFpx?=
 =?utf-8?B?NmhZL1NUdjBMM0JNRWFFdnhXL255UnhXWUVFOTFENGJtTzAvcnQrR1Rmc1c0?=
 =?utf-8?B?eW03TWJZVkh2OXpIMXVNRUcvdTVSNDdHdFBCdy9MYjFKN2VjeHhtMDJHejNQ?=
 =?utf-8?B?TkpicFZkM3lZUDFSZGZnTUp3RjBQVFE3QzE2TytYMnllNldGTHJtSlZOSk14?=
 =?utf-8?B?UW1wRjE4ZDgwTkhNM2ttSkNVYzZTVXhySnd6WUFxOGRsVlo2cFljOUZnTE5L?=
 =?utf-8?B?RDNaZEZrb2ZqMmVZbVNWUm9SUEhYbzZuTmwzZWIzOWNMWFYyaWZoQVE0RkQ4?=
 =?utf-8?B?UUJjNkV1YU9nRE9TZzgzcE5RcDBvSHlvbFM4WGxjZXNBZ2h6ZzZwdXplMkFw?=
 =?utf-8?B?M2NjNlh2Z01xNCs0UEYvRkZMK1Ixd3pxKzhLR0FVTUtTKzJSSTRKL2tBRndm?=
 =?utf-8?B?OG5odmZPZzluRHBjQXhTOUJ0SnRxWjIzU0dnQ1lSa2dzdTY2T0cwRDJyUGhh?=
 =?utf-8?B?d3IzaU9zK09mZnFWYjB1bzZkQytIQzdhdWhMM0lwS1Bpc1lhQk5yTi8rcnB3?=
 =?utf-8?B?V1hjUTVnRlVYMVFBTWs2YUpPS0U2cEFtYmVqR2VNZ1ErVkF2bEg1N0tsbWRT?=
 =?utf-8?B?K2Q5YVFYSDZrT3hvZmZhTlhLZEVQQWwvOVZJOW05Z29OMjQ1ejl1U0lmdWNq?=
 =?utf-8?B?MDg5eHh2bHJpNXJ6djg1OHdOK0xtR0dodzJxL2p6L0F2RzY0Z0JBOFR3WWFk?=
 =?utf-8?B?anNrclBNdXlqWnFjTlRnSGhJeHduU3pNVHpWU2NXRElneklzSytPMDFDdmNB?=
 =?utf-8?B?d0lNUmZQdmhzd0dWODkvay9CMHl3WHBuOTdqYUdRc21WMUtaZHYxRjZObkNC?=
 =?utf-8?B?KzdYajh6dUtFVFJCMVFvcjFwL0dMeG03bWFOcnlscjFKbHEwbTliTGhRYnpp?=
 =?utf-8?B?UEZ6dVpBNmlhczNrblJKM1R6RWRaRSs0RlpwWDZZSnU3SVlNUENtZWlNRWhn?=
 =?utf-8?B?SHdZUlUyb0ZybS9Md2hLNUpocVFKM1JHR0huVWhHQUlaR05XVjl3QWRQeHFH?=
 =?utf-8?B?MHIyYlJiTkljTVhiNDlxMGE3SVNjV1ZpNWQ1NFE0U2JjcWQzeHJ2MXg4bHVC?=
 =?utf-8?B?MW5qWmRzamd1TksyeWNSTjJQZFZpQU5OZk54RWdNbXoveXZCMHJ4VENlWWZI?=
 =?utf-8?Q?MJyuwYpqBCMHW5aQ=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 0198614e-22b5-4109-28a9-08de7a9ee80b
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:45.1411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yltQ1CW0cmPRhp88g9UPr850ZgTmiFBShtFxJ63No88jzdIO/UAJWLxdDkeD9HH4e9NmHterr9VkhdJK+O+GmhTXhKeURlLaUlrcBZhwdk=
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

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 7b9cd6a971..fceb8194eb 100644
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


