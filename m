Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C32ACD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4VK-0007Fc-8T; Thu, 21 May 2026 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wQ4Uc-000761-GL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wQ4UZ-0007Hq-4u
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779374116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWKO7nQJriRqgh6mSKN2+Ldd52WYTN8ARXi75m5APaU=;
 b=Q7U4FKJ4VddWO+l0b7/CX2prfIqWiRkq6RD9GwO0OHvNYEFoJ4Y74kSOKKq9FfhyVmOheq
 Awyui3Y3jNhT1VHql71hlNihl+MP5hN+VBbhGDcxwAeTnFGBMifocqFGFSEL80+06EqMhz
 GFM29QeP7rcT410Mh8pxiinmHPJsQdg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-0-MkrrX8PoiN4yWrWLrKxg-1; Thu,
 21 May 2026 10:35:14 -0400
X-MC-Unique: 0-MkrrX8PoiN4yWrWLrKxg-1
X-Mimecast-MFC-AGG-ID: 0-MkrrX8PoiN4yWrWLrKxg_1779374113
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BB5D1956060; Thu, 21 May 2026 14:35:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 725C719560A6; Thu, 21 May 2026 14:35:08 +0000 (UTC)
Date: Thu, 21 May 2026 16:35:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
Message-ID: <ag8YGeNoYB-sanMh@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
 <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
 <ag8MzS2ULm8UTFlb@redhat.com>
 <2fa73e56-f4b5-436e-ab25-5654e0837bce@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa73e56-f4b5-436e-ab25-5654e0837bce@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 21.05.2026 um 16:18 hat Fiona Ebner geschrieben:
> Am 21.05.26 um 3:46 PM schrieb Kevin Wolf:
> > Am 21.05.2026 um 14:12 hat Fiona Ebner geschrieben:
> >> Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
> >> I'm still trying to figure things out and come up with a better
> >> reproducer, but wanted to let you know early, also because of the
> >> upcoming stable releases. Of course, I'd also be happy for hints/hunches
> >> and am happy to test suggestions!
> > 
> > Do you have any information about the options used with the image file?
> > In particular, is it using subclusters? Maybe just the 'qemu-img info'
> > output would already give a bit more context.
> 
> No subclusters if I'm not missing anything. When I created the image the
> output was:
> 
> Formatting '/mnt/pve/dir/images/300/vm-300-disk-0.qcow2', fmt=qcow2
> cluster_size=65536 extended_l2=off preallocation=metadata
> compression_type=zlib size=4510973952 lazy_refcounts=off refcount_bits=16
> 
> Our management layer doesn't log the command itself, but doing the same
> operation with logging added (and 301 instead of 300):
> 
> /usr/bin/qemu-img create -o preallocation=metadata -f qcow2
> /mnt/pve/dir/images/301/vm-301-disk-0.qcow2 4405248K
> 
> qemu-img info gives:
> [...]

Ok, looks like all default options.

> > Could you already locate the actual corruption and check what the
> > pattern looks like? Something like zeros where we would expect data or
> > the other way around? Or something less clear? (If you don't know,
> > that's a good answer too. I know well that this kind of things is hard
> > to debug.)
> 
> Unfortunately not. I can only see the symptom of memory swapped back in
> being corrupt (at least that's what happens AFAIU), leading to segfaults
> in various processes as well as issues with heap allocations, e.g.:
> corrupted double-linked list
> free(): invalid pointer
> 
> I'll write a small program which allocates memory with a fixed pattern
> and regularly dumps it, maybe that works to get an idea about the
> corruption.

AI suggests a scenario that looks like a real bug to me, though I'm not
sure if it's yours. See the reproducer below.

Basically it boils down to a non-allocating write being in flight to a
cluster that is concurrently discarded, turning the write essentially
into a host-cluster use-after-free. If you then allocate a new cluster
at the same time, the host cluster will be reused and the write that was
for a different guest cluster still writes to it.

I'm not completely sure yet what the right synchronisation mechanism
would be for this.

Anyway, as it depends on a specific pattern of discard and cluster
allocation happening while a write request is in flight, it should be
possible to use tracing to find out if anything like that is happening
in your case.

Kevin


blkdebug.conf:

[set-state]
state = "1"
event = "write_aio"
new_state = "2"

[set-state]
state = "2"
event = "cluster_alloc"
new_state = "3"


race_test.sh:

#!/bin/bash
#
# Reproducer for the wait_for_dependencies / skip_cow race in
# qcow2_subcluster_zeroize — demonstrating data corruption at an
# UNRELATED guest offset through host cluster reuse.
#
# The scenario:
#   1. Write A to a ZERO_ALLOC cluster creates l2meta. Data I/O suspended.
#   2. Write B to same cluster waits for A. Zero-write also waits for A.
#   3. A completes (cluster → NORMAL). B wakes first (FIFO), gets
#      skip_cow=true (no l2meta), starts data I/O — suspended by blkdebug.
#      Zero-write wakes, finds no deps (B invisible), frees cluster.
#   4. Write D to a DIFFERENT guest offset allocates the freed cluster.
#      D writes its data. D completes.
#   5. B resumes and writes to the same physical cluster, overwriting D.
#   6. Reading D's guest offset returns B's data. CORRUPTION.

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
QEMU_IO="${DIR}/../build/qemu-io"
QEMU_IMG="${DIR}/../build/qemu-img"
TEST_IMG="/tmp/race_test_$$.qcow2"
BLKDEBUG_CONF="${DIR}/blkdebug.conf"
LOG="/home/cursor/qemu/debug-8a8071.log"

cleanup() {
    rm -f "$TEST_IMG"
}
trap cleanup EXIT

echo "=== Creating test image ==="
"$QEMU_IMG" create -f qcow2 "$TEST_IMG" 1M

echo ""
echo "=== Preparing ZERO_ALLOC cluster at guest offset 0 ==="
"$QEMU_IO" -c "write -P 0x11 0 64k" \
            -c "write -z 0 64k" \
            "$TEST_IMG"

echo ""
echo "=== Running race reproducer ==="
#
# blkdebug.conf state machine:
#   State 1 --(write_aio)--> State 2 --(cluster_alloc)--> State 3
#
# - State 1: tagA breakpoint catches write A
# - State 2: tagB breakpoint catches write B (skip_cow write)
# - State 2→3 transition on cluster_alloc: D's allocation transitions
#   state to 3 BEFORE D fires write_aio, so D is NOT caught by tagB
#
# Sequence:
#   break write_aio tagA          -- breakpoint for state 1
#   aio_write A 0xAA 0 64k       -- suspended at tagA (state 1→2)
#   wait_break tagA
#   break write_aio tagB          -- breakpoint for state 2
#   aio_write B 0xBB 0 64k       -- waits for A (handle_dependencies)
#   aio_write -z -u 0 64k        -- waits for A (wait_for_dependencies)
#   resume tagA                   -- A completes. B wakes (skip_cow),
#                                    caught by tagB. Zero-write frees
#                                    cluster.
#   wait_break tagB               -- B suspended, cluster freed
#   write D 0xDD 64k 64k         -- D allocates the freed cluster
#                                    (cluster_alloc transitions to
#                                    state 3). D's write_aio fires at
#                                    state 3 — no breakpoint. D writes
#                                    its data and completes.
#   resume tagB                   -- B writes to the SAME physical
#                                    cluster, overwriting D's data
#   aio_flush
#
#   read -P 0xDD 64k 64k         -- EXPECTS D's data (0xDD)
#                                    GETS B's data (0xBB) → CORRUPTION

QEMU_IO_OUTPUT=$("$QEMU_IO" \
    -c "break write_aio tagA" \
    -c "aio_write -P 0xAA 0 64k" \
    -c "wait_break tagA" \
    -c "break write_aio tagB" \
    -c "aio_write -P 0xBB 0 64k" \
    -c "aio_write -z -u 0 64k" \
    -c "resume tagA" \
    -c "wait_break tagB" \
    -c "write -P 0xDD 64k 64k" \
    -c "resume tagB" \
    -c "aio_flush" \
    -c "read -vP 0xDD 64k 512" \
    -c "read -vP 0 0 512" \
    "blkdebug:${BLKDEBUG_CONF}:${TEST_IMG}" 2>&1) || true

echo "$QEMU_IO_OUTPUT"

PATTERN_FAIL=$(echo "$QEMU_IO_OUTPUT" | grep -c "Pattern verification failed" || true)
if [ "$PATTERN_FAIL" -gt 0 ]; then
    echo ""
    echo "*** DATA CORRUPTION DETECTED at guest offset 64K ***"
    echo "*** D wrote 0xDD, but reading returns B's data (0xBB)."
    echo "*** B's write to the freed+reallocated cluster corrupted"
    echo "*** an UNRELATED guest address."
fi

echo ""
echo "=== Checking image integrity (metadata) ==="
"$QEMU_IMG" check "$TEST_IMG" || true

echo ""
echo "=== Allocation map ==="
"$QEMU_IMG" map --output=json "$TEST_IMG"

echo ""
echo "=== Checking log for race evidence ==="
if [ -f "$LOG" ]; then
    echo "--- Log entries (chronological) ---"
    cat "$LOG"
    echo ""
    echo "--- Race analysis ---"
    # Extract host offsets for the skip_cow write (B) and D's write
    B_HOST=$(grep '"has_l2meta":0' "$LOG" | grep -o '"host_offset":[0-9]*' | head -1 | grep -o '[0-9]*')
    D_HOST=$(grep '"offset":65536' "$LOG" | grep -o '"host_offset":[0-9]*' | head -1 | grep -o '[0-9]*')

    echo "Write B (skip_cow, no l2meta) host_offset: $B_HOST"
    echo "Write D (different guest offset)  host_offset: $D_HOST"

    if [ -n "$B_HOST" ] && [ -n "$D_HOST" ] && [ "$B_HOST" = "$D_HOST" ]; then
        echo ""
        echo "*** CLUSTER REUSE CONFIRMED: B and D write to the same"
        echo "*** physical cluster ($B_HOST) for different guest offsets."
        echo "*** B (guest offset 0) overwrites D (guest offset 64K)."
        echo "*** Reading guest offset 64K returns B's data → CORRUPTION"
        echo "*** at an unrelated guest address."
    fi
else
    echo "No log file found at $LOG"
fi


