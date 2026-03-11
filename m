Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5F3FD88FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0COo-0006J4-Fw; Wed, 11 Mar 2026 01:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0COl-0006Im-WF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:46:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0COi-0002i4-Ro
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:46:23 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62B5jMVn060186
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Mar 2026 14:45:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sgSufjNdyrYOjfkEJCqP5UAA3nQX23EJn1tJibpNfa8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773207958; v=1;
 b=uLYGaLQPrIJwAf1nRoXevoMNLY4U6f3tliGmhed1QuL1h0zyNjVSEmjJvfDonuZ6
 5EUDgc6scVC67jlJFV1bwExTJ62AvC0Fo7xbqr1Y21C5lVg6e6OWUtPLoIVqgSvT
 armnvthuQ5lcHAo9WX5oJYsWlJ9Ys1HLMkTKjYR7nhJHckeO0To4qUZVINcAvGli
 e1mko7MWv5scS8CxRhHL328tgBi/t2KUymn1eeRv++9A7Sok6xfdC8Eu2iPNLh9T
 Be6NXjrdAYKyjjbnm/crm0Wwm6Z4ihwrV9/+1bJyfqf3bQozYwKVMjz8SNfHmbc5
 5PNDmkfwViZbdcByxS2QaA==
Message-ID: <6b36e795-b95d-4e97-82b9-bcad699647bc@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Mar 2026 14:45:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] gdbstub: Always infer base register index from
 GDB XML
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/11 8:20, Philippe Mathieu-Daudé wrote:
> Generic fix for a latent bug reported by Florian:
> https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Use the 'regnum' XML tag for feature base register index
> (after fixing the incorrect m68k FPU ones).
> 
> Include patches from "gdbstub: Generate a single gdbstub-xml.c /
> gdb_static_features[]".
> 
> v3:
> - Correctly update @base_reg in gdb_register_coprocessor()
> v4:
> - Disable prot-note tests
> - Add gdb-multiarch to run gdbstub tests on CI
> 
> Alex Bennée (1):
>    tests/docker: add gdb-multiarch to all-test-cross
> 
> Philippe Mathieu-Daudé (15):
>    tests/tcg: Temporary disable multiarch tests for PPC targets
>    tests/tcg: Disable prot-none test on GitLab
>    target/i386/gdbstub: Remove stale comment
>    meson: Restrict gdbstub to user/system builds
>    gdbstub: Simplify gdb_init_cpu() logic
>    gdbstub: Add trace events for around XML parsing / generation
>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>    gdbstub: Make base register explicit in m68k GDB XML files
>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>    gdbstub: Emit base_register index in GDBFeature entries
>    gdbstub: Consider GDBFeature::base_reg in gdb_register_coprocessor()
>    tests/tcg: Re-enable disabled multiarch tests for PPC targets
>    gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>    gdbstub: Move gdb-xml/ within gdbstub/
>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

For the whole series:
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

