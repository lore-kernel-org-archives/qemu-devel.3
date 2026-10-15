Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E23CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHTHl-0006Pb-6O; Thu, 15 Oct 2026 17:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHTHd-0006PC-VV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHTHb-0003un-Fq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792100796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kky4QJ2ixAIldIMPhfEdocHQnnu7FbbUmR8q3WZmCNM=;
 b=Yw4hfWO5vHyvrX/t5SCluuKPGeM1X/B5aLMOrwHKpxWQahbWefI7+tLRlmUFEPOABaPKLq
 zAkzRjSf7uUeiPTljw5U0mYrR5ACyHe9bQjfGU+Ad6apsLg9X7ZekIKaLXQSE3xABDaGsY
 3Qat9HRxcR2mZhKxvfPte11ONod98q8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-lUGWtd31PBWruoxlledyrA-1; Thu,
 15 Oct 2026 21:46:33 +0000
X-MC-Unique: lUGWtd31PBWruoxlledyrA-1
X-Mimecast-MFC-AGG-ID: lUGWtd31PBWruoxlledyrA_1792100792
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A007718002C0; Thu, 15 Oct 2026 21:46:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9B67D9; Thu, 15 Oct 2026 21:46:29 +0000 (UTC)
Date: Thu, 15 Oct 2026 16:46:26 -0500
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Add coverage for NBD connect thread start
 delay
Message-ID: <atFJWVulA_nF13Ht@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 25, 2026 at 05:53:46PM +0200, Guillaume Vincke wrote:
> Test the connect thread starting condition with reconnect-delay=0 when
> the server disconnects after a successful handshake but before running
> operations. Prior to the change to nbd_co_establish_connection(), this
> test would demonstrate two I/O errors. The tests 264 and 277 covering
> reconnection do not use reconnect-delay=0 so this case is not exercised.
> 
> Add a test that provokes multiple errors in order to put an NBD client
> in the above-mentioned situation and shows that the first operation
> starts the connect thread and leads to successful subsequent I/O.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>

Guillaume, this is passing for me locally but failing under CI:

https://gitlab.com/qemu-project/qemu/-/jobs/17192659287

> ▶ 137/150 qcow2 nbd-stale-connection                                                  FAIL          
> 137/150 block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-stale-connection          FAIL             2.39s   exit status 1
> >>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3.12 MALLOC_PERTURB_=65 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 LD_LIBRARY_PATH=/builds/qemu-project/qemu/build/subprojects/libvfio-user/lib RUST_BACKTRACE=1 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /builds/qemu-project/qemu/build/pyvenv/bin/python3.12 /builds/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 nbd-stale-connection --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds/qemu-project/qemu/build/tests/qemu-iotests
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> WARNING: iotests is being run from outside of the configure-time python virtual environment
> current python: /builds/qemu-project/qemu/build/pyvenv/bin/python3.12
> pyvenv python:  /builds/qemu-project/qemu/build/pyvenv/bin/python3
> Individual python tests will be executed inside the pyvenv,
> but the test runner will continue to run outside.
> Please use the meson run script:
> 	/builds/qemu-project/qemu/build/run /builds/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 nbd-stale-connection --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds/qemu-project/qemu/build/tests/qemu-iotests
> --- /builds/qemu-project/qemu/tests/qemu-iotests/tests/nbd-stale-connection.out
> +++ /builds/qemu-project/qemu/build/scratch/qcow2-file-nbd-stale-connection/nbd-stale-connection.out.bad
> @@ -13,5 +13,5 @@
>  === NBD server up. Restart the connect thread ===
>  {"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>  === Wait for the connect thread to park the new channel. Subsequent operations are successful ===
> -{"return": {}}
> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>  Kill NBD server
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

Can you take a look? I'm also playing with it, but I may revert your
series from my current pull request if it takes too long to get to
root cause.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


