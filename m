Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BB1EA4E07
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3ti-0006Pp-Fc; Mon, 02 Mar 2026 09:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sO-00051g-OE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:18 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sK-0003rA-6s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz8DeaHh4Ev8auGEoPWbxHtkY6j5/2Kq9gmxZo1N9YZO3kjtXyQ3TRam1ogDvlnnzEHMmn7/u0NZ5hN4zGxWFyExdfcFJ+8Xqbb1GaF7i9tGWA02Z3GfXheg/3Yl3UK1OnAVQygIAZ8j8GCb46p4pC2fEKN/TFlNkEGMWAHGcfDzaYwlcj0Koi66nz5LlHmTVZtV6aOneRaB9d8AbjIpCS/b91BSRGK2f57sWX22/WGcS+D8WKmCfTfdMJmZdPNsJ6O+h+La1uAY8iTO71YjoYKbwp7oUdG2db/WegP/tSiVM2zLfya5WrJgUTx2BYGEkeKV/e2/N/N5oVoYCzV4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCJ03eJCtzKA7i7nFaamh63L28PXDRWaTY7BSoAJaWY=;
 b=pktBRiqCzd8j6mHhukhreNmcUrZlu7SuBKeZnnkO5ubwsLXlEjR5FsJXz9aCf3lKrvVXtJ/Z4l04jWh7pz47JgrNHQxJ+bwEKnK3pd7yelnc09eb1Ee3cVVZNg7bvZ4rGoFscD0Ozm3bCcGfmZ+RYjJq1o0pv5rdQM3z2AiOgiRtH0LCRsyGqrSzLyzztWx5y6CoxbxvIlou+av2QXpb7XW3QiQPg6q4ECOXrpQmTlbw60vQ/21HDm8vQhtvcBk1FoVN5qtcpKpZckvdUuIAWmyoRCxxzGZI7mysS5wKUaW5zL/Ayld0lgP7joFZ7AAsEYFY0T2G2FwVibIpIx6R+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCJ03eJCtzKA7i7nFaamh63L28PXDRWaTY7BSoAJaWY=;
 b=B3efb5quLOp2d3H6KdRhuVjo8FpW4GvPhnOk0JTQGVrpWUWCGHXJRaIHMwOZG6f0uZLFCCTL8nLO8ExNGmfAQ+4touP4QZcno08KUeka/kvxE98LOiEeYxWIB/m6L8B+8a3HqYujpXaJNHNH+R1uXBaqR3ioddmodq/oWsineZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:45 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:45 +0000
Message-ID: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Date: Mon, 2 Mar 2026 14:53:28 +0100
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH v5 0/7] Enable PC diversion via the plugin API
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms080107000708000508030003"
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1029:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf1d9f1-9822-4b63-d477-08de786484d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|19092799006; 
X-Microsoft-Antispam-Message-Info: WcltHYJuguGFiSKkzH9C/8RBZknAFigh4SP2Za768aKHsM0B0zWseUTu5C7xKb+ixaO5PR3rxRXd8Cqr/XAXn23WWpRJrFo228aV4KPzsibLpTD7TbAWLjHL9w7lr3sPHmu6gPpboGm4ZktNEI/eOtcFgUTXPl+3Nl0lZPiai8GZh3LnKK6XB3csfgI/YLKate+O+X9eJb++T/ciZcRV36NF4/S1pXALynBNgpsqBstMzcPt4DYvwdX2x8sdFpnW6xp0XOBsTx925lkqr4geOqJgKGCkkTZeXFRSC/e8F+DAXOh77Rs6mQufm4GlBAT0oXGvLBshHvCAMfVOFWYAFwBwg8nKbKVG+Y0VVLrC+kXI/EBw0M7M44fBxySrn3lYAewqvKs1WMFu8ikovNvEmtIBiD4dBO+++r1nuUxsKzIZdN+t2INVmW858C+X99v5fQSdZ+aifsGOZPY764sYuICt02ZwepNaP09T/plZxUBM4xaiS+cdqxlFsInaE0PHDHvwVIlImKz9bTre4Ss6l/XXR5DcrfcHKKL2OOj71pjEWCGl7mvdrVVHTydC0NywkLHoR+bocN9zBjEWpuXShV/hWGeFDQhN+sldHrV/Fwph9HhpphfZISXvgwdwD1DwtYce6b/b3vC8ygae2mtOvYwS3DPp8Bpz7vvfB2bmoHxY7X7wcOkyl8MY4j5e9PcLnn6tc5USXcl+H0Y5X1twfj44JCJg0Sfekg7GNRX6mrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJ6d1VUeEFPZzRJNXdnSFpWRGNGN0ZKT3pGTk00Mk82QnpwUk9NK3plOTAx?=
 =?utf-8?B?M2IrYm55VlhpVTF0NjlvQjNlcE1pMWxBNURiWWNKc1VUSW9sQytOUVZUZEdw?=
 =?utf-8?B?c0tPcGhodFRKUlVRbmxrT0c4OXl4WC9wS3IvRTU1amZOZnFvS1RlTUd0L3J0?=
 =?utf-8?B?NGZyMDN6eXYzVVZyODZzN0FmUGtNWEVHSmhvWnRhdUdIUWwvSHRvdkJoaE13?=
 =?utf-8?B?N2duWEF1bVFWN2NBNHFUR2I1NHgrakdybUpjNHc0Vy9TZkpFTjJiMU52Umlq?=
 =?utf-8?B?TDBVamlTZ2hqRlhRMEROWjR2VzlOejNPZ1pLSkVvUEhWY2g4T092SU43NTl0?=
 =?utf-8?B?M2lGN2dWK3g2UkRDY1VqY2xHVE1CNm15RC8zWEJjNTcrUEI3aDBvS0JiT3hK?=
 =?utf-8?B?TW42ME9KaW1HOHNuQnErWkRCRDNpRE5DYllPUHM1U1dHdHNrQWlsU20wSDJC?=
 =?utf-8?B?YTY3R1huSUxjcGtMek5IVnNxTllqRWlsVGxHRWdqd1BvWFVBWDI5V0dPMXRh?=
 =?utf-8?B?aEhqNjJ2V2t0eWFEWmlUZzgrd2lmd3EyVGhkRk9TWlQzMXRqTk9idE1BMEsv?=
 =?utf-8?B?VkZEdEpTMmZRK0Nmemk0b0FLQU5UUU1xb2FVUll4NXRqUFVJcE9nSVVYZmxu?=
 =?utf-8?B?RzQybVpaWjZRbklpbm5CRWRlSFAybkFLMVREdlJpcFRmdStOVHBZV2dmeHdr?=
 =?utf-8?B?YVhQR0tVQndaQ25oazYramt5aFcxNnZwcXBiTk5ka1E4Z1RmK1h3a3YzZUtj?=
 =?utf-8?B?Zzl2VlhqQitDNEZzSDZpVWFQdlk5S2JTT2RpVmdwZFZKQnRmUXRJZEVwd08y?=
 =?utf-8?B?d3RsMXU0a2N1WU5yRnl0cE1ndkJYdk5wMkU1QlN4OWZEUkRaZEZ5bHU0RFRL?=
 =?utf-8?B?b0N0ZXlZeERIZEdaOWpkOW04cGM0Zml1Sy9GWGRubkhVMDRhWDY4djRhcHJj?=
 =?utf-8?B?THJIK25EelhBMEpoYTQxOWdmR0I5WnB1RGdWQyt5RTQ3cWxubTR0S3BsMlJp?=
 =?utf-8?B?ejdyWWQ0RHVEZkVERnpxL3pLNnByVTJka3JadWNvcTV2N0pxd0NoZDhCNUts?=
 =?utf-8?B?b0lINkhnaStkYk9ZQ2dJbTJuN3NFdEh1T3hXaDh1ZklNTVNpUGhYbUwyMmps?=
 =?utf-8?B?bFU1QmZIZVBudlBiTGNIa0NRUjFBSGpobTJSaVF4d2VTVm9IOXIwZGZWUnlT?=
 =?utf-8?B?bXk3Y25WbnJZdHlmeWdQQzhzZHYxb2lJTFZDZzE1aE5TbnNoRW1ZcWFURG9C?=
 =?utf-8?B?NWJ2OVhkRFpVVjR6UGF6M2RuZG03RkczMHJNRjJmV3JwalJUV29UWHhMSEV2?=
 =?utf-8?B?Szg5UHlUYmdQV0xoVmMrWEhpai81b2dOakQ4aHJGbnhOOG5hUHZvNFowaTBy?=
 =?utf-8?B?Y3BPeEV3Uzg0SXhhNmpObENvekplaWM5WWQ3YTEwcm5xOGw1VmdBSm16SE1K?=
 =?utf-8?B?NDR2N2lEMjJlVDQ4QmQ0K3lhMDZrMFo1eG51OU5iSWhDb09DWDA1VEtWbVda?=
 =?utf-8?B?UlN3L1JPWGpGU3Y5WnhKV08rK3VCRDRrN0pUN3FKUFgzRzNmOUgzd3Z1ZlFr?=
 =?utf-8?B?TnFXd2l3aVlEREdIR2wxVmpVZzNXWThtOVVBdEp4OHNKSFhYd21vUFRjQjYy?=
 =?utf-8?B?MWkzTVVpRWpqRU10MGJ6ZkNRTkRKWDNST2o4NHExaFJpdERFUE12VzhiTTFI?=
 =?utf-8?B?VG9qVzNmWVd1TEVoRk5ZREMyV21ZSTlhT2xrSzA5elJkcUNueXUwemYzUlFy?=
 =?utf-8?B?amJ5WkZwdkxGZTd4MjYwcFEyZ2RDRk8vN0tKeW9oQldma0d5OUpsMmxiNlIy?=
 =?utf-8?B?VjRrc3pQNTJodGxWT3JCaG5KQU5YTThMNWZZVHErVVRSZi81TE1iTjdpdTFT?=
 =?utf-8?B?dVBaN1lwUitHamdnYlBISVJMUHBuOUEzN2QrK2xyZDBXbkx2RmpON3A1MU9v?=
 =?utf-8?B?QWNwRjh6S0pGdXBVbDIwaU9sTC9Lcll6MUNvVmJ0MG1KWURFWjlXTk5VeWZR?=
 =?utf-8?B?N3QyQzJDSkk0VjU1eXh1RlM0QjFFSmp6T1pvaytKNko1MDhjNWJ3YjkyOElZ?=
 =?utf-8?B?ZGVaUkNqR01BNGZTMDFoMGJBZnBBUWFCeWNMQk0wQWxIL2lsaytuaU9MMFRF?=
 =?utf-8?B?STVEb25TelI1bkFPblc4UFhEVDVmU0RkQTBJWE5FWkFrNytFaDdkbkZ4aytC?=
 =?utf-8?B?eUJHUXFCUjlWeEltaE9SRW9UYWI2S1FuVUhXVDFzd3c1cUM4VnhKZDZjUVk0?=
 =?utf-8?B?Ump5am5rcDYyMzEra2lZNlhQOTUwR3RHbXhwZWxOdkxhMHNHYm05dVdnVU03?=
 =?utf-8?B?eFFZUFROd1YwMmJwU1EvZVpubG9wSlFhbm54c1lWQXJRWS9LV3FrUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf1d9f1-9822-4b63-d477-08de786484d1
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:45.5429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPK38XShCbDFEm/lVSNF9WKSaBAg8YafKrrdSy4D3y9e1qGMxIL836CIKqKFMI7l/Qum6zSEId6wsn4vcEIubeP3Cx8I5FLc8xAgf4Mswi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1029
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

--------------ms080107000708000508030003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series builds on top of the discussion from the thread at
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@e=
pfl.ch/
and adds a plugin API function to set the program counter of the guest,
as just writing to it via qemu_plugin_write_register() has no direct
effect.

This version v5 of the patch series addresses the requested changes from
the previous v4 submission (details below).
Note: checkpatch.pl still reports a warning about line length violations
in patch nr. 6/7 but I did not fix this, as the line was already > 80
characters long previously, the change added only a single character,
and I think the readability of the code is better as it is now. Please
let me know if you disagree and would like me to fix this!

Best regards,
Florian=20

Changes:
v5:
- make QEMU abort via asserts instead of just returning an error from
  the plugin API if preconditions are violated
- extend tests for qemu_plugin_set_pc() to different contexts
- fix issues highlighted by checkpatch.pl
v4:
- switch strcmp out in favor of g_strcmp0=20
- split the patch introducing the qemu_plugin_set_pc() API into three
  patches, two for preparing the plugin infrastructure and the syscall
  handling code and a third introducing the actual plugin API
v3:
- make PC registers read-only across architectures
- add tests for read-only registers
- adjust test structure for qemu_plugin_set_pc() by moving
   architecture-specific tests into corresponding directories
v2:
- add setjmp() in syscall handling path to allow PC redirection from
   syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
   exiting a TB would not be live anymore in syscall handlers)
- add flags to ensure the qemu_plugin_set_pc() API is only called from
   contexts where the CPU is live
- add test for qemu_plugin_set_pc() API
v1:
- initial version=20


Florian Hofhammer (7):
  plugins: add flag to specify whether PC is rw
  linux-user: make syscall emulation interruptible
  plugins: add PC diversion API function
  tests/tcg: add test for qemu_plugin_set_pc API
  plugins: add read-only property for registers
  plugins: prohibit writing to read-only registers
  tests/tcg/plugins: test register accesses

 MAINTAINERS                                   |   1 +
 include/plugins/qemu-plugin.h                 |  19 +++
 linux-user/aarch64/cpu_loop.c                 |   2 +-
 linux-user/alpha/cpu_loop.c                   |   2 +-
 linux-user/arm/cpu_loop.c                     |   2 +-
 linux-user/hexagon/cpu_loop.c                 |   2 +-
 linux-user/hppa/cpu_loop.c                    |   1 +
 linux-user/i386/cpu_loop.c                    |   8 +-
 linux-user/include/special-errno.h            |   8 +
 linux-user/loongarch64/cpu_loop.c             |   5 +-
 linux-user/m68k/cpu_loop.c                    |   2 +-
 linux-user/microblaze/cpu_loop.c              |   2 +-
 linux-user/mips/cpu_loop.c                    |   9 +-
 linux-user/or1k/cpu_loop.c                    |   2 +-
 linux-user/ppc/cpu_loop.c                     |  10 +-
 linux-user/riscv/cpu_loop.c                   |   2 +-
 linux-user/s390x/cpu_loop.c                   |   2 +-
 linux-user/sh4/cpu_loop.c                     |   2 +-
 linux-user/sparc/cpu_loop.c                   |   4 +-
 linux-user/syscall.c                          |  16 ++
 linux-user/xtensa/cpu_loop.c                  |   1 +
 plugins/api.c                                 |  42 +++++-
 plugins/core.c                                |  29 ++--
 tests/tcg/arm/Makefile.target                 |   6 +
 tests/tcg/multiarch/Makefile.target           |  17 ++-
 .../{ =3D> plugin}/check-plugin-output.sh       |   0
 .../{ =3D> plugin}/test-plugin-mem-access.c     |   0
 .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   2 +
 tests/tcg/plugins/registers.c                 |  79 ++++++++++
 tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++
 31 files changed, 495 insertions(+), 42 deletions(-)
 rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (100%=
)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
 create mode 100644 tests/tcg/plugins/registers.c
 create mode 100644 tests/tcg/plugins/setpc.c


base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
--=20
2.53.0

--------------ms080107000708000508030003
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMjEzNTMyOFowLwYJKoZI
hvcNAQkEMSIEIFN3IMF/xmg7diX3arVrqk46/p1FHyIhHsXqhpme6ZAKMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBABBdIMK6mPTApN0BvjubMgK/6ZJP
vO5nzlQkhvdvstjHcrZynOlcXEWXc7pwajYuGJvPPc8YRErPAZD1QeOIuf8aDZ4TXKCtUyb4
OcisZFJ+wIm0hzKSZrTpUSPwFD8k/B6lR952Yc4y/cOhM86byQ7JMWLWiDBQv9AYYiJbgJgK
Pt1dISBb9Z8Oq9+04W4vA2+0F3vB3h+2hwQMc2cVTeLkJ5fC1kh0l+ZJytZq/7RXrmkyVaB5
9dsCoHZjo90BferKKUe6vpOxWsfhm/J8bKPrE+Wo4212hPNcdOEwT7N9MWLRj+tUug9dwVB6
tk9tzqomi0ztVxqIYf9RreLYmSUAAAAAAAA=

--------------ms080107000708000508030003--

