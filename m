Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A160F557FE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wElXo-0001mt-Iz; Mon, 20 Apr 2026 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wElWy-0001g3-22; Mon, 20 Apr 2026 06:07:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wElWu-0000j3-PC; Mon, 20 Apr 2026 06:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=pMGvy2zFiin+ZU8TdoW+2tV7tQOPHIfRfBdsSlKwizc=; b=Vl3ZIExUIWWF
 ojptat4EdQ89RS38irwoKsJ+1PgjER/9pbsQgF4TlFM+3jJsOhZmQOolClymYQ4WLbuCKv0jAFdci
 mfKvdxbgnFmHBqimnuhLoXtxRhrXlzpwpkILj5jBro15g5QeaQz79nZSsFuEtcJeL1tLjdGNFXc/l
 OO/WCiJiW896GYKzkEKbgpKwJb6755pQIamaSAKtL/PA4clYlBY/aLAklEHw+61WnvmIo2apVYFzg
 DOWiplQ1ykoJF1TDSsCpriVj+vpHlAZSKoT1lWmoRRNyEPoaGQWpW7RRl2M/JbEABmc+/11d3RXl8
 RhjYpFaK1JQZ+h3sxkX5zg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wElUE-007lFH-0R;
 Mon, 20 Apr 2026 12:06:47 +0200
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH hci-8.0 0/1] block/linux-aio: fix reproducible SIGSEGV from
 unbounded ioq_submit() recursion
Date: Mon, 20 Apr 2026 12:06:53 +0200
Message-ID: <20260420100655.3318452-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Observed in production where a cached-I/O backup path was driven
through aio=native, making io_submit(2) complete synchronously and
closing the recursion cycle.  On the supported aio=native + cache=none
+ qcow2 configuration the cycle stays bounded by accident rather than
by construction; this patch bounds it explicitly.

Bisect:

  v8.1.0 (forward edge only)      no crash / 20
  84d61e5f36^                     no crash / 20
  84d61e5f36 (backward edge in)   crash at attempt 17
  v8.2.0                          crash at attempt  4
  master + this patch             no crash / 80

The closing commit is 84d61e5f36 ("virtio: use defer_call() in
virtio_irqfd_notify()").

No iotest: crash rate is 6..17 per 20 on unpatched master; a formal
test would be flaky.  The vmdk + aio=native + cache=none shape is
not otherwise exercised by the suite.

--- gen-workload.py -----------------------------------------------
#!/usr/bin/env python3
import random, sys
REGION  = 32 * 1024 * 1024
CLUSTER = 64 * 1024
SEED    = 0xC0FFEE
def main(out):
    r = random.Random(SEED); ops = []
    for _ in range(10000):
        off = r.randrange(0, REGION - 4096) & ~4095
        ops.append("aio_write -q %d 4k" % off)
    for i in range(10000):
        size, n = ("64k", 65536) if i < 5000 else ("128k", 131072)
        off = r.randrange(0, REGION - n) & ~(CLUSTER - 1)
        ops.append("aio_write -q -z -u %d %s" % (off, size))
    r.shuffle(ops); ops.append("aio_flush")
    open(out, "w").write("\n".join(ops) + "\n")
if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "t.cmds")
-------------------------------------------------------------------

--- repro.sh ------------------------------------------------------
#!/bin/bash
set -u
qimg=$1; qio=$2; label=$3; attempts=${4:-20}
cmds=${5:-$(dirname "$0")/t.cmds}
vmdk=/tmp/t.$label.vmdk; log=/tmp/repro_$label.log
: > "$log"
for i in $(seq 1 "$attempts"); do
    rm -f "$vmdk"
    "$qimg" create -f vmdk "$vmdk" 256M >/dev/null 2>&1
    "$qio" -f vmdk -n --cache=none --aio=native "$vmdk" < "$cmds" \
        >>"$log" 2>&1
    rc=$?
    [ $rc -ge 128 ] && { echo "CRASH attempt $i rc=$rc" >>"$log"; break; }
done
echo "DONE $label rc=$rc attempt=$i" >> "$log"
-------------------------------------------------------------------

  python3 gen-workload.py t.cmds
  ./repro.sh /path/to/qemu-img /path/to/qemu-io test 20

Notes:

 * IOQ_SUBMIT_MAX_DEPTH = 8.  Round headroom over the bounded depth
   of the supported async-completion path.
 * Per-thread __thread counter, matching util/defer-call.c's storage.
   A per-LinuxAioState field would let multiple devices on one
   thread recurse independently.

Denis V. Lunev (1):
  block/linux-aio: bound ioq_submit() recursion depth

 block/linux-aio.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
--
2.51.0


