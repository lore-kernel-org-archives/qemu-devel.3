Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF4FCA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEpM-0000Pp-6T; Thu, 01 Oct 2026 07:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpK-0000PG-Tl
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpJ-0006QY-4I
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUPmP7Na4FbaMzLCr5pz8L89miYoVo1D2uPyMpAPHp0=;
 b=b4TeQlUcoOjVQ7Iy4iWjoZJs6F1TKOnXVmzmZjMf2tcB9HieyL+HI2bbCeQlyDSNEFSxkg
 XuY9W4BYjzs3dYzlyIjp0MJB/NkSUmjk1BCvVxhZn7dOhYJ/HeOiQ46aR8xJu9aoFtaNzW
 F6cC7xBWdXWJWzcJpCQTlT3mA3xRfhE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-mkki5D9HMMCzfGl0po50_Q-1; Thu,
 01 Oct 2026 07:19:45 -0400
X-MC-Unique: mkki5D9HMMCzfGl0po50_Q-1
X-Mimecast-MFC-AGG-ID: mkki5D9HMMCzfGl0po50_Q_1790853582
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D30B1954B2B; Thu,  1 Oct 2026 11:19:42 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93BE91956042; Thu,  1 Oct 2026 11:19:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 12/13] tests/functional: teach tuxrun about launching
 gdb tests
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
In-Reply-To: <20260930164649.433573-13-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-13-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:52 +0400
Message-Id: <179085353209.2170790.16323796605490036670.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6688;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QsNAXu6GCq2Lef2PBu7UodVyYy65UbUSFM58pH1I9EA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGeW7IKjSnnVpm9cb70YynQwe782axvX4MtA
 sUzbjXKd1+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5RhLD/sETQB2FfLoZNygbBgsJLJPvTWtj13PyFpbJd9ikpymABMxADuHyZEC02D5czToRrZ9U7Q
 GDcQl82BVJN2WG41QhiEZiRtuwFiGjqQ+4HfLXHTVHvb4I0tg22zRCqOFftt8HUcf2IccMCJdpu
 5EwzwH4uKIhQJ5DzXwajbbvmkDOamouVDNAMbnWJpsftb5TtMiQbqNxYc/UphITSMAF8/2APxUm
 /eY46X752dnIKz3Rrsk+Kt6UwtEJV0o8jjzbzIFBFj2fKZhYxTOwpqSu2qbqPMz3p7K298x8zG0
 ZU7v7AefqdOHhAt2LnqYIEwta85kjjIKFhaN2J7Ul/EEl7Ghqh6tHoM2hStTMVmVfLRVuGOXc3K
 JqCSrEZC/uRVQZCs6aSE/b0Gwts8jeHwtKyahI7gtjNOdx6tbym1aMf0bkVtcqlGMQqwgSiDFcO
 l85CGsd1/CQGnqGZswIbE0DnqKvQdQr3FUOH4yuv5ESvYbX6TOOzMpdULJCueY92hWE5CTxCVQE
 lP/zhTZ2sbYVpeAgPZ5BeTPIvEuxLemsykI2tGALQ0N/k0yTz7IoayvApT2i7O/WoJZ5Zc3Jqv4
 UtcYPSLo5paRKrHurF24rs0KlqpVCuydgUzwvYS2p34008oUjgQq29aPIWXcV0S9bCgoETllZ/p
 6sO692EWpzmcCJA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
>   - passes kargs directly
>   - runs with the gdb run-test script
>   - log the run-test output to the console log
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
> new file mode 100644
> index 000000000000..5ca9aa43de3c
> --- /dev/null
> +++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
> @@ -0,0 +1,157 @@
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
> +def check_break(sym_name):
> +    "Setup breakpoint, continue and check we stopped."
> +    sym, ok = gdb.lookup_symbol(sym_name)
> +    bp = gdb.Breakpoint(sym_name)
> +
> +    gdb.execute("c")
> +
> +    # hopefully we came back
> +    end_pc = gdb.parse_and_eval('$pc')
> +    print ("%s == %s %d" % (end_pc, sym.value(), bp.hit_count))
> +    bp.delete()
> +
> +    # can we test we hit bp?
> +    return end_pc == sym.value()
> +
> +
> +# We need to do hbreak manually as the python interface doesn't export it
> +def check_hbreak(sym_name):
> +    "Setup hardware breakpoint, continue and check we stopped."
> +    sym, ok = gdb.lookup_symbol(sym_name)
> +    gdb.execute("hbreak %s" % (sym_name))
> +    gdb.execute("c")
> +
> +    # hopefully we came back
> +    end_pc = gdb.parse_and_eval('$pc')
> +    print ("%s == %s" % (end_pc, sym.value()))
> +
> +    if end_pc == sym.value():
> +        gdb.execute("d 1")

It may be worth to use gdb.Breakpoint() which gives a proper object with
.delete() instead.

> +        return True
> +    else:
> +        return False
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
> +        print ("HIT WP @ %s" % (end_pc))
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
> +        super(CatchBreakpoint, self).__init__(sym_name)
> +        self.sym, ok = gdb.lookup_symbol(sym_name)
> +
> +    def stop(self):
> +        end_pc = gdb.parse_and_eval('$pc')
> +        print ("CB: %s == %s" % (end_pc, self.sym.value()))
> +        if end_pc == self.sym.value():
> +            report(False, "Hit final catchpoint")
> +
> +
> +def run_test():
> +    "Run through the tests one by one"
> +
> +    print ("Checking we can step the first few instructions")
> +    step_ok = 0
> +    for i in range(3):
> +        if check_step():
> +            step_ok += 1
> +
> +    report(step_ok == 3, "single step in boot code")
> +
> +    print ("Checking HW breakpoint works")
> +    break_ok = check_hbreak("kernel_init")
> +    report(break_ok, "hbreak @ kernel_init")
> +
> +    # Can't set this up until we are in the kernel proper
> +    # if we make it to run_init_process we've over-run and
> +    # one of the tests failed
> +    print ("Setup catch-all for run_init_process")
> +    cbp = CatchBreakpoint("run_init_process")
> +    cpb2 = CatchBreakpoint("try_to_run_init_process")


cbp2 ?

> +
> +    print ("Checking Normal breakpoint works")
> +    break_ok = check_break("wait_for_completion")
> +    report(break_ok, "break @ wait_for_completion")
> +
> +    print ("Checking watchpoint works")
> +    check_watches("system_state")
> +
> +
> +main(run_test)
> diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> index ca1589fea37d..e6b32fbcab26 100644
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

This affects every tuxrun test, worth to mention in commit message.
Or adjust the test to limit the scope

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


