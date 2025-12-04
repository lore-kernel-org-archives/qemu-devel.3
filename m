Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F78D1F9B4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6vq-0002qg-6e; Thu, 04 Dec 2025 05:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vg-0002Xd-3h
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:20 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vd-0002Jp-UO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNH9ZusaXudsE3WtenxcemMKKOXlvCVhofuzAwkqqq4MHWfuW8K1w/ji3EUHlR817I2ynwv9vPsucIuvLQ/CsnnvnqlviV1Tm79Vvrh9ZiwDWTEuECDDUBYrjNZh8oDJZdYJNNa3HH5yC26rtptNIyetybqtSvMU9Gn8QwHuwdihQxP60ji8LI/TWJT81wpDVHoY9/EPWHcubSxS+Bn181boKM/Stddy2+IPtjd9s/9T5mkjt9zVYiizdtYeGQtMqMnEu4iDtUeL0Lyoed/BMVqOhlhhImtVAuJLN7wzknlfG13Q8TGxngu50e+vEA0FK7OH+l9fBQeO0CFbw6ONHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbknO5ts8yZZ4Q56PLuC2FPxt3MwNizC9foykmeXwdU=;
 b=Fy6ilRQ0IdQ80ReQE0ziVynzN18Q5bJpe9Q9FMdTVk9RMjdgKxtwaID3snBLVEisxmhPcwlIYNPHIINCAgl+Kz7G0Rtlfjb9LqRNFVXRENPvRwczfJkYp87EgBskDg5G1MFFTw3tu97482DS7ol8+9Hq6r1RulJAYt1EyFKQ8PNyrGKiWLl6M3RQ5xLRa6LQRVQh5qPoT3ZrdeenOJ8p3SJYR0QH4uOTXRny5OYwKRaqKAfMf+U38y2Zev4hYyNDuelqLn7g4ToczvJSqFaOiz3d++R2ZTBkIa8WD9JVS0W8RCeIAeHpAcUmjBeRzc9jXOXU4Xkiw4RT7/bcrkz+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbknO5ts8yZZ4Q56PLuC2FPxt3MwNizC9foykmeXwdU=;
 b=YbkxpJpy1xInp2iDcazyBVHPpyccjYG/Mgbn9OoT57NIvKOymg/QheagKdpJu2vJ4YyHzlssRbhasKJvmSbdrM81rpKFQjEGpUsTaqFbZpmUt3vFnIIIT561pTMFwG0nDI7loiK83U8Rw8g9XOSL8OvI+0lhpqWCYutbNkXH8L68Gv3Ua0NfV+ieudXsQ6oQGmU4rK2oSfxpgZf30aSxBaQIATBhYg8HsDsVZWuczDA89ugtegswpYWIUeS3+Bdqmb/G5sxaMleOH2+AFPeJg5ssbYDMXu0vI2W6GhtC6/twFissdhWVc5CYQgvSl+mHWWIEpSxKNc0TmyX/IDNvTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7718.eurprd08.prod.outlook.com
 (2603:10a6:20b:50a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:50:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:50:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Date: Thu,  4 Dec 2025 12:50:19 +0200
Message-ID: <20251204105019.455060-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 329061d7-1a5d-4fb5-0769-08de3322f37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+NftptH0OH92Sfsq8ZG7Fa1g3yH/DQw57r7608iFC5Qb/Tiv42czUHSTb9m?=
 =?us-ascii?Q?z51gR27KEDnYQdTrzEOKQrLQ+qhz1rAapq3D/w4OBMfJtNzRGYCcilXx0GRZ?=
 =?us-ascii?Q?K34MbWMQisF2NQDbudQIbv/YTPH9RJ5QXHin3K38OwdWEgWAuI5anZl+pB79?=
 =?us-ascii?Q?ki5EJMXYisRmtEB7eqOIV4SumXytTGY2uGXWTbd8ooNRQ45yvXNX3BgIAapc?=
 =?us-ascii?Q?OE17071sTUKzfIeaGmDaNSk3f20eQQb+WyyskCy1klExCmnp8pm/UEbsn/9N?=
 =?us-ascii?Q?abe2MdR2uau4UowJ2DerXOCD7TOPCaTA+JD7fC/OfdLZ+CONtpSwInaAEms9?=
 =?us-ascii?Q?scj1xiYaanSu4Fx2gFTcNc0YqlTu3H18GGqeoRCIeRapL6cozxsIh4Mn8ayw?=
 =?us-ascii?Q?aFdfcCj41RRazXWhBtG91mgdE+jBtUPSR/81z78vIKbn6jhBi7/YlRkwfsxr?=
 =?us-ascii?Q?wC7P7+giNPt4SJw/NtNMi1Ds4kQfZFfGVpFauwETQCWueLhuCG4DKUJKqihV?=
 =?us-ascii?Q?kYz3GMEkLzK0QTT6e+NkGIcNTz79SUydzM3/dFvZAZa5tDBxSwLnFtMiWzmV?=
 =?us-ascii?Q?Lvq6g6LbYdiz8vkhCg3/XpnAgCUMPdFpA4BgDkd5+BDATCDzfp/Dm/xEpUZe?=
 =?us-ascii?Q?RfEUVK4OsVDM2lEuqdEzjGKYE4GYOiN7oz+1Pn1kdhv9mUfJLjhL4ivLMRjr?=
 =?us-ascii?Q?MTDRbuPmyEHSNkw/eFKwwfPnQooQxlrQgCa0CfZpBciMPqIT4qHnFr5Xlq8f?=
 =?us-ascii?Q?hmHHaBTZd44kIlwXBlCS/mxk8NyGuzjBlEnhBFzEPl9abP+Mirrxs/Ao4jwD?=
 =?us-ascii?Q?KYaRrmGWJdXWublsN1i1dKeufMEg5XR7L4qKs4Hk8Pu4NLAzOD73k8bbW7Ol?=
 =?us-ascii?Q?5RkowoI3V1yaGSDA/StnWTSMGgyAV/3yJuxUI15oeImN17VM5Ay3vueBi2wm?=
 =?us-ascii?Q?8CNEwdzINUmTbGesWZfa1FrW+pXrDQm16WvsJpdginrt99uMYfjR+RwHe3NP?=
 =?us-ascii?Q?nhT7Znwsfb2b2tf1k3dRV36TNVRUhwehpVJepwe6GkwTw6P9xC2q640ua+5T?=
 =?us-ascii?Q?ByFwKefBWMbubV/6wDpLQ1pdw9niqO/2KwwDqFUj9RXHRfOTG8HAt0ySfaCW?=
 =?us-ascii?Q?6Ov7aBce5dDiBVHceYeE4StyNJS45U5QZb4N4OFN4BvPV7kpS/DGKHkUscoS?=
 =?us-ascii?Q?eDvZWTRnd9tVeefKWqG0+IEa6bGAEFnu+yFGG35Oo63kShoZA2s0Xy6aNcrZ?=
 =?us-ascii?Q?Y84rqgtEbb6jpu09QS/8YIMJWIGVeS3uZENDVIgl0dayihZbiEnnW+nKHtrD?=
 =?us-ascii?Q?UrY70xHDWuWomqDt+nKQVRwdfVzCEwODSYmpo/1+9AozFadj+FTrPuIcrMt7?=
 =?us-ascii?Q?F177wxfsfeDx2FLsVnVTg+R79cVu5zm5Tvw7EJlgFwNKR6Sl0a9Vgzz6+oE/?=
 =?us-ascii?Q?KbA4cA7HQNI/yAY9s84XrQtZ58U0udeCl/ZdkvVTX/x+06axZC6D7IuLi+kp?=
 =?us-ascii?Q?ZjkRb/ZOP6kWfktea89geK2rgxqZDDUcjkEY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FbB47Ox5R+4OBigjI2SN+/jcu3WyQf0toKSIdtOs8A8X2lLOn9Yg1xgX46DA?=
 =?us-ascii?Q?TEGBCrhNnCuyVnj3tIqgW9V7ilL3mIs2frkRS8wLS0+Qg1e+eW1y3uAA1AEj?=
 =?us-ascii?Q?2diM+4GLoo6uU4nuWsgFCD3kugqzdxqKVf0mb9r8+pHqSNHSX38rkrXCUK/g?=
 =?us-ascii?Q?3hvzUQOWD7Cchjmlt43IECDHjOHCJL4g2Q4KSJ/rjUmszp5A6TZH4LZKxyvS?=
 =?us-ascii?Q?LMtboLlbmUk5OyIVX/l57NKKr0lprJCD+MRdVqqyAUA4hnixniBcLKFeaQJ5?=
 =?us-ascii?Q?AJdhnWKOyV88p10vB5H0CjnlnFADlMjAlMEkvcVXLtOFMS2ZCMsHmHtE4RYb?=
 =?us-ascii?Q?dm6qWNFVRx2vomqIDrEO2TutllbdKXTwmRgMSIjfbEvx0u6nNlZV9MUFjrGL?=
 =?us-ascii?Q?TDzG2RmTyDP1A89nja8khw+V3Cu0EDEWuaHhRMW/6odjaQKRR4UXxZ2Zlb+6?=
 =?us-ascii?Q?sP52vdJHzbWp5Egfx7rk9ZZRvh5hdt9yFA7KiglNL+QDE3R5WmD2klheilEk?=
 =?us-ascii?Q?8lxG1NTn/W11JIHunExlZ1F0ILuOgoCfGTOuttNCisu56rm5DjQLFiuFhu0m?=
 =?us-ascii?Q?OodmxHh+pu60FisFVTc7xP+3RvTPPRZoxiBAOeRTGG+qM9uMUjivVw9Vbih7?=
 =?us-ascii?Q?j8TKG4x/E5sCpWgmi3VI7nWKh5mutvsR7UNuETba9nRz9XbGMtHc0486DZGv?=
 =?us-ascii?Q?t4HZhNHEhNIvI9ZOLA7ejjNpsWOJZuzUPJ3UUEVy/5gBm0hCb9RDb/oHoqCa?=
 =?us-ascii?Q?jdaG+8g4OrZTMPQmmtdgqRAtJC8q8pPaCTrShlqMYTT+8PoPpq/2TqQCEsI1?=
 =?us-ascii?Q?q69LtrojpVTaaOc/3rmKpr5tzBO0otbdpD8+D67SrFMyy8j5j9x8LntHuxt5?=
 =?us-ascii?Q?1jHo+XNVL1xCptP1wH49Aie+cpTOU0Ecum+MOIn4kJgJZgq+nhjp3Ql52fVj?=
 =?us-ascii?Q?dm0dZaeHDAJ/6JmGj1Lbz0/dklKQ7MY9WFJsIguN3afzVUdWSDJLPsMG/DFO?=
 =?us-ascii?Q?0ukZIVUpAYrGcLA96Olzjcf2h27bn4sb+rdGJLKxD7wujAnNvM1LhiWQt9QX?=
 =?us-ascii?Q?LUb20FvKPRlDAdlGNYujbV0g8y6F4L5Vn+gaqDOcQeAqNcOr/FPV+my1h6Gg?=
 =?us-ascii?Q?CjYfszhFHAseGW/ohM/lWR7/ogzgB+Nv4JA9JZB5Hz8Iu61A4kJ6YyPMmmVT?=
 =?us-ascii?Q?yV5yAo4oIc03yz29LX/vaDAAxVDk7hw5uqZyFQqfIAJgF2urEbavtKg9nYKg?=
 =?us-ascii?Q?FGB6EHefOb8KK/z3xP1L+mMdcmXW+MppOakuA9nMYg2a3gImSouG3FR07qoM?=
 =?us-ascii?Q?fVJjjbmYBLr7sQamxSg4/0tuyE8/OxmCyW780tbYb0h6t4Baqjnm7miuLino?=
 =?us-ascii?Q?X7PYnssnLe76XOiVWCAAeJU70zQAW+/oWFtBUojOrMEd2+AYJmcDrClgfBjv?=
 =?us-ascii?Q?rQ42PYO7r5QIm6WaCGjT1o79VPps6oZunzbdJUKCc8PUjszPuL4rOXt8UQQ9?=
 =?us-ascii?Q?LPPn5X+xdj4URK4F/RhFURGMj0wOq3EnvXYBM49eVHU/PaTM6sTF2IYw2Whi?=
 =?us-ascii?Q?rBoHidsNxilmqU/0uxsufjZk9+nmTn9hovxiFrKl86xscOWrr7jb/CpUcuho?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329061d7-1a5d-4fb5-0769-08de3322f37f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:50:34.1961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3dEgUntaHbOh3Ak26QSKlUQVOGX41ZJJUkJ5opCRphG950UeTibK/jl9W401nbVG2H7Hefkv0qAQjKCglB7urWdL14qVgWA1i7RDwzndVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
coredumps") introduced coroutine traces in coredumps using raw stack
unwinding.  While this works, this approach does not allow to view the
function arguments in the corresponding stack frames.

As an alternative, we can obtain saved registers from the coroutine's
jmpbuf, patch them into the coredump's struct elf_prstatus in place, and
execute another gdb subprocess to get backtrace from the patched temporary
coredump.

While providing more detailed info, this alternative approach, however, is
more invasive as it might potentially corrupt the coredump file. We do take
precautions by saving the original registers values into a separate binary
blob /path/to/coredump.ptregs, so that it can be restores in the next
GDB session.  Still, instead of making it a new deault, let's keep raw unwind
the default behaviour, but add the '--detailed' option for 'qemu bt' and
'qemu coroutine' command which would enforce the new behaviour.

That's how this looks:

  (gdb) qemu coroutine 0x7fda9335a508
  #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
  #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
  #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
  #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
  #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
  #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
  #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
  #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393

  (gdb) qemu coroutine 0x7fda9335a508 --detailed
  patching core file /tmp/tmpq4hmk2qc
  found "CORE" at 0x10c48
  assume pt_regs at 0x10cbc
  write r15 at 0x10cbc
  write r14 at 0x10cc4
  write r13 at 0x10ccc
  write r12 at 0x10cd4
  write rbp at 0x10cdc
  write rbx at 0x10ce4
  write rip at 0x10d3c
  write rsp at 0x10d54

  #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
  #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
  #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
  #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
  #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
  #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
  #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
  #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
  #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
  #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Peter Xu <peterx@redhat.com>
Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/coroutine.py | 257 +++++++++++++++++++++++++++++++++--
 1 file changed, 242 insertions(+), 15 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index e98fc48a4b..29f57ae84e 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -9,10 +9,119 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
 
+import atexit
 import gdb
+import os
+import pty
+import re
+import struct
+import textwrap
+
+from collections import OrderedDict
+from copy import deepcopy
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
+# Registers in the same order they're present in ELF coredump file.
+# See asm/ptrace.h
+PT_REGS = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10', 'r9',
+           'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax', 'rip', 'cs',
+           'eflags', 'rsp', 'ss']
+
+coredump = None
+
+
+class Coredump:
+    _ptregs_suff = '.ptregs'
+
+    def __init__(self, coredump, executable):
+        atexit.register(self._cleanup)
+
+        self.coredump = coredump
+        self.executable = executable
+        self._ptregs_blob = coredump + self._ptregs_suff
+        self._dirty = False
+
+        with open(coredump, 'rb') as f:
+            while f.read(4) != b'CORE':
+                pass
+            gdb.write(f'core file {coredump}: found "CORE" at 0x{f.tell():x}\n')
+
+            # Looking for struct elf_prstatus and pr_reg field in it (an array
+            # of general purpose registers).  See sys/procfs.h.
+
+            # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
+            f.seek(4, 1)
+
+            # lseek(f.fileno(), 112, SEEK_CUR):
+            # offsetof(struct elf_prstatus, pr_reg)
+            f.seek(112, 1)
+
+            self._ptregs_offset = f.tell()
+
+            # If binary blob with the name /path/to/coredump + '.ptregs'
+            # exists, that means proper cleanup didn't happen during previous
+            # GDB session with the same coredump, and registers in the dump
+            # itself might've remained patched.  Thus we restore original
+            # registers values from this blob
+            if os.path.exists(self._ptregs_blob):
+                with open(self._ptregs_blob, 'rb') as b:
+                    orig_ptregs_bytes = b.read()
+                self._dirty = True
+            else:
+                orig_ptregs_bytes = f.read(len(PT_REGS) * 8)
+
+            values = struct.unpack(f"={len(PT_REGS)}q", orig_ptregs_bytes)
+            self._orig_ptregs = OrderedDict(zip(PT_REGS, values))
+
+            if not os.path.exists(self._ptregs_blob):
+                gdb.write(f'saving original pt_regs in {self._ptregs_blob}\n')
+                with open(self._ptregs_blob, 'wb') as b:
+                    b.write(orig_ptregs_bytes)
+
+        gdb.write('\n')
+
+    def patch_regs(self, regs):
+        # Set dirty flag early on to make sure regs are restored upon cleanup
+        self._dirty = True
+
+        gdb.write(f'patching core file {self.coredump}\n')
+        patched_ptregs = deepcopy(self._orig_ptregs)
+        int_regs = {k: int(v) for k, v in regs.items()}
+        patched_ptregs.update(int_regs)
+
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            gdb.write('writing regs:\n')
+            for reg in self._orig_ptregs.keys():
+                if reg in int_regs:
+                    gdb.write(f"  {reg}: {int_regs[reg]:#16x}\n")
+            f.write(struct.pack(f"={len(PT_REGS)}q", *patched_ptregs.values()))
+
+        gdb.write('\n')
+
+    def restore_regs(self):
+        if not self._dirty:
+            return
+
+        gdb.write(f'\nrestoring original regs in core file {self.coredump}\n')
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            f.write(struct.pack(f"={len(PT_REGS)}q",
+                                *self._orig_ptregs.values()))
+
+        self._dirty = False
+        gdb.write('\n')
+
+    def _cleanup(self):
+        if os.path.exists(self._ptregs_blob):
+            self.restore_regs()
+            gdb.write(f'\nremoving saved pt_regs file {self._ptregs_blob}\n')
+            os.unlink(self._ptregs_blob)
+
+
 def pthread_self():
     '''Fetch the base address of TLS.'''
     return gdb.parse_and_eval("$fs_base")
@@ -77,6 +186,55 @@ def symbol_lookup(addr):
 
     return f"{func_str} at {path}:{line}"
 
+def run_with_pty(cmd):
+    # Create a PTY pair
+    master_fd, slave_fd = pty.openpty()
+
+    pid = os.fork()
+    if pid == 0:  # Child
+        os.close(master_fd)
+        # Attach stdin/stdout/stderr to the PTY slave side
+        os.dup2(slave_fd, 0)
+        os.dup2(slave_fd, 1)
+        os.dup2(slave_fd, 2)
+        os.close(slave_fd)
+        os.execvp("gdb", cmd) # Runs gdb and doesn't return
+
+    # Parent
+    os.close(slave_fd)
+
+    output = bytearray()
+    try:
+        while True:
+            data = os.read(master_fd, 65536)
+            if not data:
+                break
+            output.extend(data)
+    except OSError: # in case subprocess exits and we get EBADF on read()
+        pass
+    finally:
+        try:
+            os.close(master_fd)
+        except OSError: # in case we get EBADF on close()
+            pass
+
+    # Wait for child to finish (reap zombie)
+    os.waitpid(pid, 0)
+
+    return output.decode('utf-8')
+
+def dump_backtrace_patched(regs):
+    cmd = ['gdb', '-batch',
+           '-ex', 'set debuginfod enabled off',
+           '-ex', 'set complaints 0',
+           '-ex', 'set style enabled on',
+           '-ex', 'python print("----split----")',
+           '-ex', 'bt', coredump.executable, coredump.coredump]
+
+    coredump.patch_regs(regs)
+    out = run_with_pty(cmd).split('----split----')[1]
+    gdb.write(out)
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
@@ -120,7 +278,7 @@ def dump_backtrace_live(regs):
 
     selected_frame.select()
 
-def bt_jmpbuf(jmpbuf):
+def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
     try:
@@ -128,8 +286,12 @@ def bt_jmpbuf(jmpbuf):
         # but only works with live sessions.
         dump_backtrace_live(regs)
     except:
-        # If above doesn't work, fallback to poor man's unwind
-        dump_backtrace(regs)
+        if detailed:
+            # Obtain detailed trace by patching regs in copied coredump
+            dump_backtrace_patched(regs)
+        else:
+            # If above doesn't work, fallback to poor man's unwind
+            dump_backtrace(regs)
 
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
@@ -138,28 +300,90 @@ def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
     return coroutine_pointer['env']['__jmpbuf']
 
+def init_coredump():
+    global coredump
+
+    files = gdb.execute('info files', False, True).split('\n')
+
+    if not 'core dump' in files[1]:
+        return False
+
+    core_path = re.search("`(.*)'", files[2]).group(1)
+    exec_path = re.match('^Symbols from "(.*)".$', files[0]).group(1)
+
+    if coredump is None:
+        coredump = Coredump(core_path, exec_path)
+
+    return True
 
 class CoroutineCommand(gdb.Command):
-    '''Display coroutine backtrace'''
+    __doc__ = textwrap.dedent("""\
+        Display coroutine backtrace
+
+        Usage: qemu coroutine COROPTR [--detailed]
+        Show backtrace for a coroutine specified by COROPTR
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu coroutine', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu coroutine <coroutine-pointer> [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
         argv = gdb.string_to_argv(arg)
-        if len(argv) != 1:
-            gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
+        argc = len(argv)
+        if argc == 0 or argc > 2 or (argc == 2 and argv[1] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 2 else False
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        try:
+            bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
+                      detailed=detailed)
+        finally:
+            coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
-    '''Display backtrace including coroutine switches'''
+    __doc__ = textwrap.dedent("""\
+        Display backtrace including coroutine switches
+
+        Usage: qemu bt [--detailed]
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu bt', gdb.COMMAND_STACK,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu bt [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        argc = len(argv)
+        if argc > 1 or (argc == 1 and argv[0] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 1 else False
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
+            return
 
         gdb.execute("bt")
 
@@ -173,13 +397,16 @@ def invoke(self, arg, from_tty):
         if co_ptr == False:
             return
 
-        while True:
-            co = co_cast(co_ptr)
-            co_ptr = co["base"]["caller"]
-            if co_ptr == 0:
-                break
-            gdb.write("Coroutine at " + str(co_ptr) + ":\n")
-            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr))
+        try:
+            while True:
+                co = co_cast(co_ptr)
+                co_ptr = co["base"]["caller"]
+                if co_ptr == 0:
+                    break
+                gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
+                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
+        finally:
+            coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.43.5


