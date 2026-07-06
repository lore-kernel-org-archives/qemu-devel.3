Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE591C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgm5o-0004gf-Fm; Mon, 06 Jul 2026 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wgm5n-0004gV-7O
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:22:47 -0400
Received: from mail-japaneastazon11022100.outbound.protection.outlook.com
 ([52.101.126.100] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wgm5k-0000ZV-Gh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYq0St9ZG2BB0KWXG9WGqz5Iiwp3ZLqp0GgJFgpHBY6vWFBVh/cAdP+3lwWBIqVzvYEkkhkjbqHguvPmH8eDA/mHJ4l62nfUYDuXAdWwOE2euEKP8aHSyi3PtrleWSjkdnHm/ikGGzMaAavxGhzJhlFhkM6barapQF8ICHW7UkHJGp7MsJWXL/Xyqnji51A53CMiDJ5QnEwI40/1nKtCWG9NSfo2QjASCsBleewcM4ZtJIzYwikV6ql8jFiynSaaWnLIvjtgt8YJ3kQdvRXlnyVAIV3M0XTvwf9oIvbTqUgNQEbVnXKO0iOLnk+G9m/2beBZMUSlBwfJP+p8lwhVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8k2T+oxZlUbB/TYHiMMnGHnrAbb0xGyzoxJUsIq4pw=;
 b=VQ576YpqaN9a/dlYeunakwqooctTxNT5bkQygnyOc63OMLMjxVYtc6cH0K0Fz/af6LC8DYI+cEBDYMORP8g6Gl5oukPoVYN7gn3D0EGIpGUTZfiSAyLBfmwzOGUtOtGDQU2C0rUzE2ifmc5pTDW9sQEu3BJmtkPOY9qggRqi+rLjD9G0O2P+Id9+ag+EfJUGk86FuyJBHI+6Z5W5TnSwJByevU79KDOG8vExYNMUVjQr+kIbFVNDrejs/sZ0Dq8wbkusx5SYAlD2cUzlKg8jxyEDmlt96cWRFKoJPn9CjxbGgPux2XOM9DhRSKasxZZuQKUj8pF9nUk+ImWFZ69jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8k2T+oxZlUbB/TYHiMMnGHnrAbb0xGyzoxJUsIq4pw=;
 b=fCtXP4VUYbyCBQycCYsoj+PHhFM3Ja7Ip2lSs4A2DvuOA1a2pSYG98hFvGbrMVMvxHGDtSR88PUEGGawu+JDJjHXQB+r1tfTZskpVfmEhj9hMkpBqEoPud+0kJJ1jHyTVpz2usbQqa3WtPNDZ4Rl5GMgnuPu6qwyy0hoE8FbfMtmohYTXW+rdHOV8+ZetqmkqyTDmdIeeoIpnRlOFNT6UpcvjUNOjyJ+pvq0l3ojrFemORki4fdrMabRgQeL/feZPhYcJEKh6OHInkGi1mgcJDiNLIMUxdjJlDESRJi4ElTXYUR/GnVFtZIywDHijIZ9edJTy/2l1U2ts5zd2y8j4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB6586.apcprd02.prod.outlook.com (2603:1096:400:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:17:33 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 16:17:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
Date: Tue,  7 Jul 2026 00:17:16 +0800
Message-Id: <20260706161716.29488-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:295::12) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 81848719-fb0e-4289-5ea1-08dedb7a1492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34096008|366016|23010399003|1800799024|10070799003|20046099003|18002099003|3023799007|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: HkLEsXQj9YUyxN32RAR/CuvsKOLDkCVnBTCb8gW7at/1QiNaDfR30PQha85OwBzQIonLCSmwPNizud1c6f9ygrefWWeMNf69hiq51y5iShePBvYwECjkM1PxTsmnSA9ju9eU7gE1SxQ+L09RgJGKoI8Pn/XPvByqXXTRqXGiWTfN2h7t877idF+rBUDqG5jziuCgXfoQxUhwMgs95vfroyzmD4j8kZfHeOeKtuj9iIAjeiln4f60zyyYt2y2bwEF5e9RyFW2QWRh+ANuluzokCFvrr84NTcIyHkNTZBVcj0DYwpW1wyZJA7YW0RjIy693L1S1D0FdUW/hXnJUn4oVULt0Ogy2aBodrS/2hjUNFSgv4d4/dB7XAQ99xQlfr94ZecYLrFSG5mqhs3GBzMwHFCtqHtGAO3C7WhEfrsAjrhEN8pOBoE3w61b5Yq6gZV7pc6jH2HI/zi4qs6Ryiw5tjE+pAtFQSfE0R4Zqb2A5NcyGZeTJpl8osD4y3JsP+4DTmbe6wKYxqfWTPXysCFvP7GQ6qKhWspu6T2egsG0J/bu/N9cVTjJBWBfH7ybq/NdXx5dOnk+tKfX/JzaNbQSdioVoLJ9KtxzEyIOceYk4gW9bWHj0K6FExv6/2PcRraFHmdjsdhjcTMYNB1csIiH02ZxCCfy5sWipa8pa2MW+zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(34096008)(366016)(23010399003)(1800799024)(10070799003)(20046099003)(18002099003)(3023799007)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNZK3hlQWRjUmlUWFUwZitFYVNjOXpyZXg1d294dHgrUnlXazVuM1pmNFhv?=
 =?utf-8?B?OUIwZ2tPMGFSV2tMODMzNFcxTGtEYU9pV09XcEhXai9wMlJoVzUxczVUcFlt?=
 =?utf-8?B?ZEtMN3JLQ2k2S3hlUiswQWZxTnRxbWhFcG1mM2F4MERqZUJmZS9tQWNiTVRS?=
 =?utf-8?B?MUY2TkxLYVluN2kvYzlOR3NHdVFPampZQmFKaGVLTHVKYzc0WXhtYmcyL2xJ?=
 =?utf-8?B?cTR0N29odVZ4cmhKczNoVXk4dUlWTXlFeUZ6c2pxNlo4Yy9OK09MR0NVWlZk?=
 =?utf-8?B?c0FaM3gyL1F0WGJ1Tlh3aTJUQVUybU5uU3ZqeTM5VHZ4YzUxRTk2NEJvVWtW?=
 =?utf-8?B?SXFUR3d3cGZjUDBzV3ZQOWF3Nll4dWQ2TXZEZnQrWkRnMG5rbVZKcWZTN0ZW?=
 =?utf-8?B?dmN4cThIRllOa1NxY3h1dFg2SjhOVDBpeVBoMGUrUlZkOHYvcVhxTlVqdllC?=
 =?utf-8?B?ZXFKNTVCQkpwLzV1anhxQWRlQnJxRXhJQ3VjNDBYM01VeGk0U1MxekVLTnVv?=
 =?utf-8?B?cWlNSzRoTGVhNkdNaDdNaVQrbE05dDJJYUNHaXdDU2FhZ3ZxbkZTYnhKQ3I1?=
 =?utf-8?B?QnZEYnlualBHK2ZXMFVXY2k2SGNSSzhLcjEyR1RjUnl5aUY5ajE1MUh2dWpm?=
 =?utf-8?B?Vnd0Z05yNXZ0V2hiaFNEa0NLNXZMYzRvL2JtMmoxUnh1ZmZVTmw5TERDTUxV?=
 =?utf-8?B?Zm5lWm9CODBWQVRzeDZMRllwSWJLQjhXRzBqUlVacTJQb1kxVDczTnJnTC9U?=
 =?utf-8?B?SzhMY2VBcXdmRDhLQnhuNDlVcXpUcmhzT0NmTnBDN3pDaStycTM3V214ZlVh?=
 =?utf-8?B?c3hqWHJmSVcyc2dFZlBTdnJUdEJ5Z2Y4OTVDNUZJejBlNlhMNjc4OEZBZ01X?=
 =?utf-8?B?RGZSSHByTlpxZGdPYlZ1T0FlbWV0S0duUERqSmk5SVBqZ1BLUTlRSjhOTytD?=
 =?utf-8?B?UDMyQU50MWhtbFM4MTdyM1QrbTF3eGt6ZVUzVjhCZXIveUticmk1ZEQwQkxL?=
 =?utf-8?B?K0MzbGdONDJBSExrUE9iVmNmQ3hjR3lBVmpWUyswK0YyZk1adVpLRjd1Y0x2?=
 =?utf-8?B?Zi9Hd0EzYkRqVUlId05TOGRveXlTcXVKREtvdGZWSm9HM2xRUXNLejkyRU5M?=
 =?utf-8?B?aWpjbmhrTW53SVNYUmkzM1UzYXEyd1dRNEUvUlFrZXpDdjdZVnV4L3dRd0ts?=
 =?utf-8?B?bHlIdkJCZmdxRGMzZUZUSWx2QWRxM0NJcHk3WFFyejZsNlNheXJRYWY0cGNn?=
 =?utf-8?B?YzBJWEVrcVpuUlN5aDI0VjVyRW0xMk5yWGNqMzJwWVJOQTF3SGlmNFVyUExi?=
 =?utf-8?B?VjRvQjhVSGJNWlJ4cFpDaU05czl6dm5xcDNTWmg0VFNjV29zNTF0YUx1S284?=
 =?utf-8?B?ZjREQlZtNFdKN3NWUkVUK3RLZTRBSUtKMTFyQlRCTUtuTUl2QUVGbzQ1bzkw?=
 =?utf-8?B?RUdEYlp1b05LWnVHLzk3RUhUUDVRVmNqYVFxcmpOQXlHUG9nbnJNcTA4emk2?=
 =?utf-8?B?bXdVd29ySmF6OG5sTkRKUFBaVmNmcHZ5RmVBeklTRS9KOXhEUnZ4cnBrYktC?=
 =?utf-8?B?eTl3cjRaYldjTDNEUGlKUVlZM0hadmtaVExYcDFhMWZURnZGa1JNWFgwdVZv?=
 =?utf-8?B?amNDVUJ2bmtnVjU5QWhNTG5ROHhjbG5KT0MrVzIzbEFPekVyMjllTSs1YTVq?=
 =?utf-8?B?VWE5eld2ZzdJSDZ5ZHJsRGI0WGFiS0NueGJBWmpMUDV4UUZpV1lGZzBYa3Ey?=
 =?utf-8?B?Ni81K2R6N3ZYQkFLb2E5ZlFRNmFJVFFZa01GMDJBS1BuVkMrbFlTVkUwWi9w?=
 =?utf-8?B?L29aUEhvYVM2SGkwOEdwUjlmL0pmQi94R1poSjg2SldRYTdOM01XQllWWU9S?=
 =?utf-8?B?TmhTL0F3T1dlL3QvWkl2ZTlSRko3cWtqL0JzVzdjdDZxUHlsR3Zlb0U4bUVF?=
 =?utf-8?B?eDF5OFVxcXNmY1Q5cnlUZnpjQjVTaGh1M2lndHFLUWc3QlkzdTNqczZhSFR2?=
 =?utf-8?B?WFlOb2lDS053YkdmNEl2NXpseXdKUnV5QmpvZEtaNERQSkhVWHVuK0lhN2tM?=
 =?utf-8?B?SlBzaWh1T1hQRm8vdk5oNXByVHZVYVpVU2J6MkhpeW5rbGlkbUU5TVRrUnNh?=
 =?utf-8?B?TlZWN1NuOFlEc3h0Qk1IemVKT3NFcFFXR3N1UDRMRkVDcFhDY1BzNStxOWxr?=
 =?utf-8?B?YTc1dSt6b0VVdUt1Z2JEaDk1dTRDYlhWN1JRbGRjbDg4d1lxc05vQU5QSUtU?=
 =?utf-8?B?VXhJREtMTmhHWFJRSldVbE14QUR1dDJYZDVxWWZPVkIrUUhnRkZHSi95R3BO?=
 =?utf-8?B?UDJabjZuek1pT0dERUNiUWM0MHlDeUFteHY0TkdFcjBOb3VrYmlacXJkQXZh?=
 =?utf-8?Q?JKaPKwgtcnrh9cX0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81848719-fb0e-4289-5ea1-08dedb7a1492
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:17:31.4212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMmq1AZquDvt1IQ8VL2WMT6dcQOfD2KNC+NpWAHuOjvQVEjhdDGDe/f+LU1zvTMhvcLHgJiOZh2kF701tuy0abfjkUF3T0Dqsi6MGMSbeFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB6586
Received-SPF: pass client-ip=52.101.126.100;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The OpenSBI firmware build job follows the same pattern as the EDK2 job
[1] that was removed earlier [2]: it exists to produce firmware binaries
from CI artifacts, but those outputs are not consumed by the tree.

Remove the job definition and its project include to avoid maintaining
bitrotting container and firmware build logic.

[1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
[2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 MAINTAINERS                     |  2 -
 .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
 .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
 .gitlab-ci.d/qemu-project.yml   |  1 -
 4 files changed, 125 deletions(-)
 delete mode 100644 .gitlab-ci.d/opensbi.yml
 delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..59707bf2a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4117,8 +4117,6 @@ R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
-F: .gitlab-ci.d/opensbi.yml
-F: .gitlab-ci.d/opensbi/
 
 Clock framework
 M: Luc Michel <luc@lmichel.fr>
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
deleted file mode 100644
index 42f137d624..0000000000
--- a/.gitlab-ci.d/opensbi.yml
+++ /dev/null
@@ -1,88 +0,0 @@
-# All jobs needing docker-opensbi must use the same rules it uses.
-.opensbi_job_rules:
-  rules:
-    # Forks don't get pipelines unless QEMU_CI=1 or QEMU_CI=2 is set
-    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      when: never
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if any files affecting the build output are touched
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project"'
-      changes:
-        - .gitlab-ci.d/opensbi.yml
-        - .gitlab-ci.d/opensbi/Dockerfile
-        - roms/opensbi/*
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if the branch/tag starts with 'opensbi'
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_REF_NAME =~ /^opensbi/'
-      when: manual
-
-    # In forks, if QEMU_CI=1 is set, then create manual job
-    # if the last commit msg contains 'OpenSBI' (case insensitive)
-    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_MESSAGE =~ /opensbi/i'
-      when: manual
-
-    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
-    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
-      when: never
-
-    # Run if any files affecting the build output are touched
-    - changes:
-        - .gitlab-ci.d/opensbi.yml
-        - .gitlab-ci.d/opensbi/Dockerfile
-        - roms/opensbi/*
-      when: on_success
-
-    # Run if the branch/tag starts with 'opensbi'
-    - if: '$CI_COMMIT_REF_NAME =~ /^opensbi/'
-      when: on_success
-
-    # Run if the last commit msg contains 'OpenSBI' (case insensitive)
-    - if: '$CI_COMMIT_MESSAGE =~ /opensbi/i'
-      when: on_success
-
-docker-opensbi:
-  extends: .opensbi_job_rules
-  stage: containers
-  image: docker:latest
-  services:
-    - docker:dind
-  variables:
-    GIT_DEPTH: 3
-    IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
-  before_script:
-    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
-    - until docker info; do sleep 1; done
-  script:
-    - docker pull $IMAGE_TAG || true
-    - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-                                           --tag $IMAGE_TAG .gitlab-ci.d/opensbi
-    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-    - docker push $IMAGE_TAG
-
-build-opensbi:
-  extends: .opensbi_job_rules
-  stage: build
-  needs: ['docker-opensbi']
-  artifacts:
-    when: on_success
-    paths: # 'artifacts.zip' will contains the following files:
-      - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
-      - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
-      - opensbi32-generic-stdout.log
-      - opensbi32-generic-stderr.log
-      - opensbi64-generic-stdout.log
-      - opensbi64-generic-stderr.log
-  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
-  variables:
-    GIT_DEPTH: 3
-  script: # Clone the required submodules and build OpenSBI
-    - git submodule update --init roms/opensbi
-    - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
-    - echo "=== Using ${JOBS} simultaneous jobs ==="
-    - make -j${JOBS} -C roms/opensbi clean
-    - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
-    - make -j${JOBS} -C roms/opensbi clean
-    - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Dockerfile
deleted file mode 100644
index 5ccf4151f4..0000000000
--- a/.gitlab-ci.d/opensbi/Dockerfile
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Docker image to cross-compile OpenSBI firmware binaries
-#
-FROM ubuntu:18.04
-
-MAINTAINER Bin Meng <bmeng.cn@gmail.com>
-
-# Install packages required to build OpenSBI
-RUN apt update \
-    && \
-    \
-    DEBIAN_FRONTEND=noninteractive \
-    apt install --assume-yes --no-install-recommends \
-        build-essential \
-        ca-certificates \
-        git \
-        make \
-	python3 \
-        wget \
-    && \
-    \
-    rm -rf /var/lib/apt/lists/*
-
-# Manually install the kernel.org "Crosstool" based toolchains for gcc-8.3
-RUN wget -O - \
-    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz \
-    | tar -C /opt -xJ
-RUN wget -O - \
-    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv64-linux.tar.xz \
-    | tar -C /opt -xJ
-
-# Export the toolchains to the system path
-ENV PATH="/opt/gcc-8.3.0-nolibc/riscv32-linux/bin:${PATH}"
-ENV PATH="/opt/gcc-8.3.0-nolibc/riscv64-linux/bin:${PATH}"
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 104a147b2d..72d02bc65b 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -11,7 +11,6 @@ default:
 include:
   - local: '/.gitlab-ci.d/base.yml'
   - local: '/.gitlab-ci.d/stages.yml'
-  - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
   - local: '/.gitlab-ci.d/buildtest.yml'
-- 
2.34.1


