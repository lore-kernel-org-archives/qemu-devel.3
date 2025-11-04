Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB03CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFMw-00072R-L0; Tue, 04 Nov 2025 06:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGFMt-00071y-0W; Tue, 04 Nov 2025 06:38:31 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGFMq-0002T7-3z; Tue, 04 Nov 2025 06:38:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5E07BC00E2;
 Tue, 04 Nov 2025 14:38:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MciJRe1Gla60-RJskT6CV; Tue, 04 Nov 2025 14:38:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762256302;
 bh=gJSkxN8AX3W+0LpEwWa3sDFEhnu28OD3IfQng9SK5j0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dvCHmP7t/gfOtu/IJZtZUeTEHUOULmbe0CYZezNjD3I8q1p1/LW78rgY9NfNy2wDW
 33JR3ymqZeZ4VbIxVJOCiOsCaHLA1RncwyCGzrE3/fFt30r9E0QBV8szClpHQ+U47g
 eUFW8Rc2U442TkkX9hCj43jw+9oUgfJ8IOtdsYRM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <98abcae5-9768-4a7b-af5a-1cdaa84020af@yandex-team.ru>
Date: Tue, 4 Nov 2025 14:38:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iotests: Add coverage of recent NBD qio deadlock fix
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-18-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251103202849.3687643-18-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.11.25 23:10, Eric Blake wrote:
> Test that all images in a qcow2 chain using an NBD backing file can be
> served by the same process.  Prior to the recent QIONetListener fixes,
> this test would demonstrate deadlock.
> 
> The test borrows heavily from the original formula by "John Doe" in
> the gitlab bug, but uses a Unix socket rather than TCP to avoid port
> contention, and uses a full-blown QEMU rather than qemu-storage-daemon
> since both programs were impacted.
> 
> [While preparing this patch by making the new test executable, I
> noticed vvfat.out does not need execute permissions]
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/tests/nbd-in-qcow2-chain   | 84 +++++++++++++++++++
>   .../qemu-iotests/tests/nbd-in-qcow2-chain.out | 56 +++++++++++++
>   tests/qemu-iotests/tests/vvfat.out            |  0
>   3 files changed, 140 insertions(+)
>   create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
>   create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
>   mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out
> 
> diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> new file mode 100755
> index 00000000000..b89f74d4552
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> @@ -0,0 +1,84 @@
> +#!/usr/bin/env bash
> +# group: rw quick
> +#
> +# Test of opening both server and client NBD in a qcow2 backing chain
> +#
> +# Copyright (C) Red Hat, Inc.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# creator
> +owner=eblake@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +status=1    # failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _cleanup_test_img
> +    rm -f "$SOCK_DIR/nbd"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +cd ..
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +. ./common.nbd
> +
> +_supported_fmt qcow2  # Hardcoded to qcow2 command line and QMP below
> +_supported_proto file
> +
> +size=100M
> +
> +echo
> +echo "=== Preparing base image ==="
> +
> +TEST_IMG="$TEST_IMG.base" _make_test_img $size
> +
> +echo
> +echo "=== Starting QEMU and exposing base image ==="
> +
> +_launch_qemu -machine q35
> +h1=$QEMU_HANDLE
> +_send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
> +_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
> +  "arguments": {"node-name":"base", "driver":"qcow2",
> +     "file":{"driver":"file", "filename":"'"$TEST_IMG.base"'"}}}' 'return'
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
> +  "arguments": {"addr":{"type":"unix",
> +    "data":{"path":"'"$SOCK_DIR/nbd"'"}}}}' 'return'
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
> +  "arguments": {"device":"base","name":"base"}}' 'return'
> +
> +echo
> +echo "=== Creating wrapper image ==="
> +
> +_make_test_img -F raw -b "nbd+unix:///base?socket=$SOCK_DIR/nbd" $size
> +
> +echo
> +echo "=== Adding wrapper image ==="
> +
> +_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
> +  "arguments": {"node-name":"wrap", "driver":"qcow2",
> +     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' 'return'

Hmm. Why don't you specify "backing": "base" here?

> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
> +  "arguments": {"device":"wrap","name":"wrap"}}' 'return'
> +
> +echo
> +echo "=== Checking NBD server ==="
> +
> +$QEMU_NBD --list -k $SOCK_DIR/nbd
> +
> +echo
> +echo "=== Cleaning up ==="
> +
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' ''
> +
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out b/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
> new file mode 100644
> index 00000000000..5f1d31ae2e0
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
> @@ -0,0 +1,56 @@
> +QA output created by nbd-in-qcow2-chain
> +
> +=== Preparing base image ===
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=104857600
> +
> +=== Starting QEMU and exposing base image ===
> +{"execute": "qmp_capabilities"}
> +{"return": {}}
> +{"execute": "blockdev-add",
> +  "arguments": {"node-name":"base", "driver":"IMGFMT",
> +     "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT.base"}}}
> +{"return": {}}
> +{"execute":"nbd-server-start",
> +  "arguments": {"addr":{"type":"unix",
> +    "data":{"path":"SOCK_DIR/nbd"}}}}
> +{"return": {}}
> +{"execute":"nbd-server-add",
> +  "arguments": {"device":"base","name":"base"}}
> +{"return": {}}
> +
> +=== Creating wrapper image ===
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=104857600 backing_file=nbd+unix:///base?socket=SOCK_DIR/nbd backing_fmt=raw
> +
> +=== Adding wrapper image ===
> +{"execute": "blockdev-add",
> +  "arguments": {"node-name":"wrap", "driver":"IMGFMT",
> +     "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT"}}}
> +{"return": {}}
> +{"execute":"nbd-server-add",
> +  "arguments": {"device":"wrap","name":"wrap"}}
> +{"return": {}}
> +
> +=== Checking NBD server ===
> +exports available: 2
> + export: 'base'
> +  size:  104857600
> +  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
> +  min block: 1
> +  opt block: 4096
> +  max block: 33554432
> +  transaction size: 64-bit
> +  available meta contexts: 1
> +   base:allocation
> + export: 'wrap'
> +  size:  104857600
> +  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
> +  min block: 1
> +  opt block: 4096
> +  max block: 33554432
> +  transaction size: 64-bit
> +  available meta contexts: 1
> +   base:allocation
> +
> +=== Cleaning up ===
> +{"execute":"quit"}
> +*** done
> diff --git a/tests/qemu-iotests/tests/vvfat.out b/tests/qemu-iotests/tests/vvfat.out
> old mode 100755
> new mode 100644


-- 
Best regards,
Vladimir

