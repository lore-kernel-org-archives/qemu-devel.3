Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58136C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1red5r-0003PY-B5; Mon, 26 Feb 2024 10:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1red5n-0003Oo-Dn
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 10:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1red5l-0001YZ-1B
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 10:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708962030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7sANzpOKMUdm/hUnGoCcXTJ/dW4aA8xUIbcpLqiUuPQ=;
 b=TEIKKvGodinL5vZAvQkcew/+sZc9+xD8sX5DQNPIH/jgdDxmlC1x8NCgYKysGTh4rknh2m
 F3jMASM5mE7q7eGfGl9TZfeUEmpvbyMNVa/CgIq9tfqcGOz2/BfyKwo9VUplT7ZuPJdpwU
 C2powcO84NtIzcrnbSuXTRIb3+ZLwsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-jYgZNZNcM6msOloaKErZQQ-1; Mon, 26 Feb 2024 10:40:29 -0500
X-MC-Unique: jYgZNZNcM6msOloaKErZQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C401D881C80;
 Mon, 26 Feb 2024 15:40:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF66C2166B5D;
 Mon, 26 Feb 2024 15:40:27 +0000 (UTC)
Date: Mon, 26 Feb 2024 15:40:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 04/28] qemu-img: global option processing and error
 printing
Message-ID: <Zdyw6Z1a8r8atJqi@redhat.com>
References: <cover.1708544927.git.mjt@tls.msk.ru>
 <20240221211622.2335170-4-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221211622.2335170-4-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 12:15:45AM +0300, Michael Tokarev wrote:
> In order to correctly print executable name in various
> error messages, pass argv[0] to error_exit() function.
> This way, error messages will refer to actual executable
> name, which may be different from 'qemu-img'.
> 
> For subcommands, pass whole argv[] array, so argv[0] is
> the executable name, not subcommand name.  In order to
> do that, avoid resetting optind but continue with the
> next option.  Also don't require at least 3 options on
> the command line: it makes no sense with options before
> subcommand.
> 
> Before invoking a subcommand, replace argv[0] to include
> the subcommand name.
> 
> Introduce tryhelp() function which just prints
> 
>  try 'command-name --help' for more info
> 
> and exits.  When tryhelp() is called from within a subcommand
> handler, the message will look like:
> 
>  try 'command-name subcommand --help' for more info
> 
> qemu-img uses getopt_long() with ':' as the first char in
> optstring parameter, which means it doesn't print error
> messages but return ':' or '?' instead, and qemu-img uses
> unrecognized_option() or missing_argument() function to
> print error messages.  But it doesn't quite work:
> 
>  $ ./qemu-img -xx
>  qemu-img: unrecognized option './qemu-img'
> 
> so the aim is to let getopt_long() to print regular error
> messages instead (removing ':' prefix from optstring) and
> remove handling of '?' and ':' "options" entirely.  With
> concatenated argv[0] and the subcommand, it all finally
> does the right thing in all cases.  This will be done in
> subsequent changes command by command, with main() done
> last.
> 
> unrecognized_option() and missing_argument() functions
> prototypes aren't changed by this patch, since they're
> called from many places and will be removed a few patches
> later.  Only artifical "qemu-img" argv0 is provided in
> there for now.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 75 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)

I'm not sure how, but this change seems to have broken the iotests.
Just one example:

$ (cd  tests/qemu-iotests/ && ./check -qcow2 249)
QEMU          -- "/var/home/berrange/src/virt/qemu/build/qemu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/var/home/berrange/src/virt/qemu/build/qemu-img" 
QEMU_IO       -- "/var/home/berrange/src/virt/qemu/build/qemu-io" --cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/var/home/berrange/src/virt/qemu/build/qemu-nbd" 
IMGFMT        -- qcow2
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 toolbox 6.6.12-200.fc39.x86_64
TEST_DIR      -- /var/home/berrange/src/virt/qemu/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/qemu-iotests-0t8h94bu
GDB_OPTIONS   -- 
VALGRIND_QEMU -- 
PRINT_QEMU_OUTPUT -- 

249   fail       [15:39:25] [15:39:25]   0.2s   (last: 0.4s)  failed, exit status 1
--- /var/home/berrange/src/virt/qemu/tests/qemu-iotests/249.out
+++ /var/home/berrange/src/virt/qemu/build/tests/qemu-iotests/scratch/qcow2-file-249/249.out.bad
@@ -1,47 +1,7 @@
 QA output created by 249
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
-{ 'execute': 'qmp_capabilities' }
-{"return": {}}

...snip....

-*** done
+qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
+qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
+qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+Timeout waiting for capabilities on handle 0
Failures: 249
Failed 1 of 1 iotests



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


