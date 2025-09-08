Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8125CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaNS-0008AJ-PL; Mon, 08 Sep 2025 07:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvaNO-00085X-J2
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvaN9-0006jc-Ag
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757332156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nIuwVhyBgkhfjvCR/HFoiHpIeUiKsxFDqHS+CG9u8nc=;
 b=FehJ+9NaJxw2iWmpIXumG1bXETg+d/+NDCU7OFt8sE3RDlsv/kyCZGvVSZvx1xQ9jGpjkZ
 4/mPGfO32C6fR7R253p0+3LtXwWcO0l5ZBlL2M/2Pu/m2tU7En1FJyblnB3kLjq+I2BE0+
 ryQpq+3LxzoMVyr+BGSMAREEgvHol0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-f8Uva2UTOqOp_rC7_AAJzw-1; Mon,
 08 Sep 2025 07:49:13 -0400
X-MC-Unique: f8Uva2UTOqOp_rC7_AAJzw-1
X-Mimecast-MFC-AGG-ID: f8Uva2UTOqOp_rC7_AAJzw_1757332152
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15ACF1800371; Mon,  8 Sep 2025 11:49:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C7DD19540EB; Mon,  8 Sep 2025 11:49:09 +0000 (UTC)
Date: Mon, 8 Sep 2025 12:49:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, 1844144@gmail.com
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aL7CsSppNc-WZFY-@redhat.com>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904154640.52687-1-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
> In this series, we leveraged the run-test.py script used in the
> check-tcg tests, making it a GDB runner capable of calling a test script
> without spawning any VMs. In this configuration, the test scripts can
> manage the VM and also import gdb, making the GDB Python API inside the
> functional test scripts.
> 
> A --quiet option has been added to run-test.py so it doesn't print the
> command line used to execute GDB to the stdout. This ensures that users
> don't get confused about how to re-run the tests. One can re-run the
> test simply by copying and pasting the command line shown by Meson when
> V=1 is passed:
> 
> $ make -j check-functional V=1
> 
> or, alternatively, once the test run completes, the exact command found
> in the 'command:' field of the build/meson-logs/testlog-thorough.txt
> file generated by Meson. Both methods provide the correct environment
> variables required to run the test, such as the proper $PYTHONPATH.

While I like the conceptual idea of just sending human GDB commands,
instead of working with GDB protocol packets, I really dislike the
effect this has on the execution / startup of the functional tests
via use of the custom runner for a number of reasons

 * The command line for launching the test outside of meson is very
   complicated, so not memorable
 * It makes the meson.build rules much more complicated
 * Running standalone there is no TAP output available making the
   test hard to debug on failure or timeout

I understand the need to spawn the test via gdb, in order to be able
to import the 'gdb' python module. Looking at what reverse_debugging.py
does, however, makes me question whether we actually need to directly
use the 'gdb' python module.

The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.

The latter is only used once as

  gdb.parse_and_eval("$pc")

and I believe that can be changed to

  gdb.execute("printf \"0x%x\", $pc", to_string=True)

IOW, all we need is 'gdb.execute("....", to_string=True)' 

With a little extra helper proxy script, we can achieve this without
changing the way scripts are launched.

The script needs to listen on a UNIX socket path. When a client
connects, it should read lines of data from the client and pass
them to 'gdb.execute(..., to_string=True)' and whatever data
gdb returns should be written back to the client.

A very very crude example with no error handling would be:

  #!/usr/bin/python3

  import gdb
  import os
  import socket

  sock = os.environ.get("QEMU_PROXY", "/tmp/qemu.gdb.proxy")

  try:
    os.unlink(sock)
  except:
    pass

  with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
    s.bind(sock)
    s.listen()
    conn, addr = s.accept()
    fh = conn.makefile('rw')
    with conn:
        while True:
            line = fh.readline()
            if not line:
                break
            data = gdb.execute(line, to_string=True)
            fh.write(data)
            fh.flush()


In the functional test suite, we should have a helper file
tests/functional/qemu_test/gdb.py that provides an API for
launching GDB to execute this proxy script, and an API to
execute commands by talking over this UNIX socket path.

With this, we will need no changes in the way we execute the
reverse debugging script from a test runner POV, thus avoiding
all the downsides of use of the run-test.py script. IOW, the
first 4 patches in this series go away completely. Instead we
need a patch to create the proxy script and a patch to create
the helper APIs in tests/functional/qemu_test/gdb.py, whereupon
the last patch can replace

try:
    import gdb
except ModuleNotFoundError:
    from sys import exit
    exit("This script must be launched via tests/guest-debug/run-test.py!")

with

  from qemu_test import gdb

and the earlier mentioned replacement of parse_and_eval()

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


