Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8510BCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNx1-0000PA-1I; Mon, 12 Oct 2026 17:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNwz-0000Nt-52
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNwx-0006Mn-15
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTKAxGqrfA65D44T1hX49bWPq0KOmVNjhwVxnoVNgX4=;
 b=epoiOU9Yb/DU1pE+1IXLT0mc/qE2UCkg/OqQL7kYb/ixVZRQsH6H8T/QIF+C4i9f5Gdkqo
 ZBsDZxi5FNGITwG2i87yyydBDvvoaI9Ahb7RIJP6oUVcSv4YdQByNTz6I4Q6SwsjczvDbF
 kdI9DDnUxQNHA9fABCOYUAC84Le05xA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-iUBORaBiOESwAa8i-Ezc_w-1; Mon,
 12 Oct 2026 21:52:46 +0000
X-MC-Unique: iUBORaBiOESwAa8i-Ezc_w-1
X-Mimecast-MFC-AGG-ID: iUBORaBiOESwAa8i-Ezc_w_1791841963
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60421955DD6; Mon, 12 Oct 2026 21:52:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 870D61956040; Mon, 12 Oct 2026 21:52:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 09/16] tests/functional: teach tuxrun about
 launching gdb tests
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-10-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-10-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194928.2190936.2071852462997624684.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7547;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wwh3j++VxEnh3sUvifLJbTsQhi4H4o2zf/oVtur1aLo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVafpyaCgiXVRYLTH2wngLtjQs72Kk6oYzAsH
 vlYv8DfMlGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WnwAKCRDa6OEJdZac
 5SBTD/4u9GC0/Ha/He526Dt9DXISFlUYwNgE9B1FeqvYq8QC7yLYxCIvL2nnP42AwP9qy2eukjw
 pTiLXvTjS3pXkxhOBMZADFDjkNlZ7N5ylWe8DE2cGoG/XGcitXhtZ72HyZ5Z1BC8YQtcDpe5YhK
 7V6x7kDX3nHMNlUvYpgjoM3aA1S648ySyE0rod6Lp4tbrv+67tIAPJ3UWjoFqB/7jV6sIQxmpZF
 oLXtE9nMvP1ZSCKF0Pm/OEvuUMip1rlMYfmXe+dYBsuZwHdGxQ3U/CMDf2krGnx7rSqtcUoehW+
 w4HTTn7qZ+rQR7yXcD8jc/NgRfEck2zmxSpywXe7Mt6GohSMKBRR5d21xp8+cRmJxnO1tvgUMBa
 j90vSDrEm+4u2D83iiJflvhpI/S+Kqmq0ph8cJCElWZ4h2Da7obWPE0nXGBAqzDEFOb/ijf3wIV
 AQOFKkg2frpIomWCA29bOML4gbDGTtE87+wplU7lsCPnu4pb9WASfBAVh8Kskj8WJDIc1t4VZ+v
 mzN1Rd9lQCB5UjqhisagLVQJCQ1jz9y1iprSFjLuhznPR9cCq8mk/u9Q7z26b8yHuRknAJCi4xM
 aUjzeyRDA3nnM4sh26r4Vhwcp18rXvjwKdorSMBlWvXmT5vJxGHVsPL+F2EBMUeMA08jzxhiNVC
 ZKRmk385L12J9pA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> This resurrects the hand run test script from d84842be6c5 (tests:
> remove test-gdbstub.py) and modernises it to use the shared test
> infrastructure for run-test.
> 
> We then tweak the common tuxrun code to over an alternative "launch
> via gdbstub" helper which reuses the existing code but:
> 
>   - needs a vmlinux with symbols
>   - extend qargs with stuff normally added by vm.launch
>   - passes kargs directly
>   - runs with the gdb run-test script
>   - log the run-test output to the console log
> 
> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Message-ID: <20261012170330.1144446-10-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
> new file mode 100644
> index 000000000000..2d62fe01f10c
> --- /dev/null
> +++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Generic Kernel GDB script to verify functionality:
> +#  - Single-stepping
> +#  - Hardware breakpoints
> +#  - Software breakpoints
> +#  - Watchpoints
> +#
> +# It relies on fairly common kernel points to break at and symbols for
> +# the kernel. Address space randomisation (kaslr) needs to be disabled.
> +#
> +# Copyright (c) 2026 Linaro Limited
> +#
> +# Author:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# This is launched by the tuxrun functional tests via tests/guest-debug/run-test.py
> +
> +import gdb
> +from test_gdbstub import main, report
> +
> +failcount = 0

unused variable

> +
> +def parse_registers():
> +    """Parse 'info registers' into a name -> value dictionary."""
> +    regs = {}
> +    for line in gdb.execute("info registers", to_string=True).splitlines():
> +        parts = line.split()
> +        if len(parts) >= 2:
> +            regs[parts[0]] = parts[1]
> +    return regs
> +
> +
> +def check_step():
> +    "Step an instruction, check it moved."
> +    start_pc = gdb.parse_and_eval('$pc')
> +    gdb.execute("si")
> +    end_pc = gdb.parse_and_eval('$pc')
> +
> +    return not (start_pc == end_pc)
> +
> +
> +def check_reg_updates(regs_start):
> +    regs_end = parse_registers()
> +
> +    changed = [k for k in regs_start
> +               if k in regs_end and regs_start[k] != regs_end[k]]
> +
> +    report(len(changed) > 0, f"{len(changed)} registers changed.")
> +
> +
> +def check_break(sym_name):
> +    "Setup breakpoint, continue and check we stopped."
> +    bp = gdb.Breakpoint(sym_name)
> +    gdb.execute("c")
> +    res = bp.hit_count == 1
> +    bp.delete()
> +
> +    return res
> +
> +
> +# We need to do hbreak manually as the python interface doesn't export it

comment is now stale

> +def check_hbreak(sym_name):
> +    "Setup hardware breakpoint, continue and check we stopped."
> +    bp = gdb.Breakpoint(sym_name, type = gdb.BP_HARDWARE_BREAKPOINT)
> +    gdb.execute("c")
> +    res = bp.hit_count == 1
> +    bp.delete()
> +
> +    return res
> +
> +
> +class WatchPoint(gdb.Breakpoint):
> +
> +    def get_wpstr(self, sym_name):
> +        "Setup sym and wp_str for given symbol."
> +        self.sym, ok = gdb.lookup_symbol(sym_name)
> +        wp_addr = gdb.parse_and_eval(sym_name).address
> +        self.wp_str = '*(%(type)s)(&%(address)s)' % dict(
> +            type = wp_addr.type, address = sym_name)
> +
> +        return(self.wp_str)
> +
> +    def __init__(self, sym_name, type):
> +        wp_str = self.get_wpstr(sym_name)
> +        super(WatchPoint, self).__init__(wp_str, gdb.BP_WATCHPOINT, type)
> +
> +    def stop(self):
> +        end_pc = gdb.parse_and_eval('$pc')
> +        print("HIT WP @ %s" % (end_pc))
> +        return True
> +
> +
> +def do_one_watch(sym, wtype, text):
> +
> +    wp = WatchPoint(sym, wtype)
> +    gdb.execute("c")
> +    report_str = "%s for %s (%s)" % (text, sym, wp.sym.value())
> +
> +    if wp.hit_count > 0:
> +        report(True, report_str)
> +        wp.delete()
> +    else:
> +        report(False, report_str)

Add wp.delete() in the else branch too?

> +
> +
> +def check_watches(sym_name):
> +    "Watch a symbol for any access."
> +
> +    # Should hit for any read
> +    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
> +
> +    # Again should hit for reads
> +    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
> +
> +    # Finally when it is written
> +    do_one_watch(sym_name, gdb.WP_WRITE, "watch")
> +
> +
> +class CatchBreakpoint(gdb.Breakpoint):
> +    def __init__(self, sym_name):
> +        super(CatchBreakpoint, self).__init__(sym_name, type = gdb.BP_BREAKPOINT)
> +        self.sym, ok = gdb.lookup_symbol(sym_name)
> +
> +    def stop(self):
> +        end_pc = gdb.parse_and_eval('$pc')
> +        print("CB: %s == %s" % (end_pc, self.sym.value()))
> +        if end_pc == self.sym.value():
> +            report(False, "Hit final catchpoint")
> +
> +
> +def run_test():
> +    "Run through the tests one by one"
> +
> +    # get the initial register state
> +    regs_start = parse_registers()
> +
> +    print("Checking we can step the first few instructions")
> +    step_ok = 0
> +    for i in range(3):
> +        if check_step():
> +            step_ok += 1
> +
> +    report(step_ok == 3, "single step in boot code")
> +
> +    # check some registers changed
> +    print("Checking register access works")
> +    check_reg_updates(regs_start)
> +
> +    print("Checking HW breakpoint works")
> +    break_ok = check_hbreak("kernel_init")
> +    report(break_ok, "hbreak @ kernel_init")
> +
> +    # Can't set this up until we are in the kernel proper
> +    # if we make it to run_init_process we've over-run and
> +    # one of the tests failed
> +
> +    print("Setup catch-all for run_init_process")
> +    cbp = CatchBreakpoint("run_init_process")
> +
> +    # We should see wait_for_completion called right at the start of
> +    # kernel_init
> +    print("Checking Normal breakpoint works")
> +    break_ok = check_break("wait_for_completion")
> +    report(break_ok, "break @ wait_for_completion")
> +
> +    print("Checking watchpoint works")
> +    check_watches("system_state")
> +
> +    # check we didn't hit the end
> +    report(cbp.hit_count == 0, "CatchBreakpoint not hit")
> +
> +
> +main(run_test)
> diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> index ca1589fea37d..8e940fd77383 100644
> --- a/tests/functional/qemu_test/tuxruntest.py
> +++ b/tests/functional/qemu_test/tuxruntest.py
> @@ -9,7 +9,9 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> +import logging
>  import os
> +import subprocess
>  
>  from qemu_test import QemuSystemTest
>  from qemu_test import exec_command_and_wait_for_pattern
> @@ -18,7 +20,7 @@
>  
>  class TuxRunBaselineTest(QemuSystemTest):
>  
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 nokaslr'

This was flagged in the v1 review: nokaslr is only needed for the gdb tests (the
kernel_gdb_test.py header says "Address space randomisation (kaslr) needs to be
disabled") but it is added globally here, affecting all tuxrun tests. Mention it
in the commit message or scope it to gdb tests only?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


