Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D368D6C288
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 18:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTMl-000872-11; Tue, 19 Nov 2024 13:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDTMj-00086Y-Dy
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 13:54:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDTMh-0008SR-CM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 13:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732042457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgipdxjAZ7chzaI9zQ6kPFiLXEWcywxyyZvA9x0BLZc=;
 b=AZZpGertd6oMhrEh1OElhfpSpYNPeN6JL94c44f+bnVTQeE3kA5UwJK1FqGAg+f4QWNOt6
 Fw3Uc2QYbX6csdZGwKphOusMI/p9e26FE5Rq5FRdjbAMAmoqII32M/IGpsr6FJ8aGf5I5a
 pU80kKZOEzin2UzBVsxx1yOwII69IE8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-cj4BUcckNcWcgrFoHLw15Q-1; Tue,
 19 Nov 2024 13:54:14 -0500
X-MC-Unique: cj4BUcckNcWcgrFoHLw15Q-1
X-Mimecast-MFC-AGG-ID: cj4BUcckNcWcgrFoHLw15Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 117B61955F43; Tue, 19 Nov 2024 18:54:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4C5A19560A3; Tue, 19 Nov 2024 18:54:08 +0000 (UTC)
Date: Tue, 19 Nov 2024 18:54:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 13/15] tests/functional: rewrite console handling to be
 bytewise
Message-ID: <ZzzezVVCYEJV4uVg@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-14-berrange@redhat.com>
 <beb4abeb-299a-4d4a-a253-3e65a41edcc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beb4abeb-299a-4d4a-a253-3e65a41edcc9@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 19, 2024 at 06:11:10PM +0100, Paolo Bonzini wrote:
> On 11/19/24 16:05, Daniel P. Berrangé wrote:
> > The console interaction that waits for predicted strings uses
> > readline(), and thus is only capable of waiting for strings
> > that are followed by a newline.
> > 
> > This is inconvenient when needing to match on some things,
> > particularly login prompts, or shell prompts, causing tests
> > to use time.sleep(...) instead, which is unreliable.
> > 
> > Switch to reading the console 1 byte at a time, comparing
> > against the success/failure messages until we see a match,
> > regardless of whether a newline is encountered.
> > 
> > The success/failure comparisons are done with the python bytes
> > type, rather than strings, to avoid the problem of needing to
> > decode partially received multibyte utf8 characters.
> > 
> > Heavily inspired by a patch proposed by Cédric, but written
> > again to work in bytes, rather than strings.
> > 
> > Co-developed-by: Cédric Le Goater <clg@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/cmd.py | 63 +++++++++++++++++++++++--------
> >   1 file changed, 48 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> > index 76a48064cd..91267a087f 100644
> > --- a/tests/functional/qemu_test/cmd.py
> > +++ b/tests/functional/qemu_test/cmd.py
> > @@ -78,15 +78,58 @@ def run_cmd(args):
> >   def is_readable_executable_file(path):
> >       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> > +def _console_readline(test, vm, success, failure):
> > +    msg = bytes([])
> > +    done = False
> > +    while True:
> > +        c = vm.console_socket.recv(1)
> > +        if c is None:
> > +            done = True
> > +            test.fail(
> > +                f"EOF in console, expected '{success}'")
> > +            break
> > +        msg += c
> > +
> > +        if success is None or success in msg:
> 
> As an optimization, you could use msg.endswith(success) and
> msg.endswith(failure), which would avoid the most blatant cases of O(n^2)
> behavior.
> 
> More important, I think "if success is None" should not be here, because it
> will exit after one char.  Instead...
> 
> > +            done = True
> > +            break
> > +        if failure and failure in msg:
> > +            done = True
> > +            vm.console_socket.close()
> > +            test.fail(
> > +                f"'{failure}' found in console, expected '{success}'")
> > +
> > +        if c == b'\n':
> 
> Here you can put
> 
>                done = success is None

Hmmm, this can only be a problem if "success" is None, and
"failure" is not None, and although the old code would
technically work in that case, I think it is actually an
unknown/invalid usage scenario.

If BOTH "success" and "failure" are None, this method won't
be called at all. It is valid for "failure" to be none, but
I don't think it makes semantic sense for "success" to also
be None, while have "failure" be non-None.

So I'm inclined to say we declare 'success' to be mandatory
and validate that in the caller. eg

 assert send_string is not None or success_message is not None


and then remove this "success is None" check from
_console_readline.

> 
> Paolo
> 
> > +            break
> > +
> > +    console_logger = logging.getLogger('console')
> > +    try:
> > +        console_logger.debug(msg.decode().strip())
> > +    except:
> > +        console_logger.debug(msg)
> > +
> > +    return done
> > +
> >   def _console_interaction(test, success_message, failure_message,
> >                            send_string, keep_sending=False, vm=None):
> >       assert not keep_sending or send_string
> >       if vm is None:
> >           vm = test.vm
> > -    console = vm.console_file
> > -    console_logger = logging.getLogger('console')
> > +
> >       test.log.debug(f"Console interaction success:'{success_message}' " +
> >                      f"failure:'{failure_message}' send:'{send_string}'")
> > +
> > +    # We'll process console in bytes, to avoid having to
> > +    # deal with unicode decode errors from receiving
> > +    # partial utf8 byte sequences
> > +    success_message_b = None
> > +    if success_message is not None:
> > +        success_message_b = success_message.encode()
> > +
> > +    failure_message_b = None
> > +    if failure_message is not None:
> > +        failure_message_b = failure_message.encode()
> > +
> >       while True:
> >           if send_string:
> >               vm.console_socket.sendall(send_string.encode())
> > @@ -99,20 +142,10 @@ def _console_interaction(test, success_message, failure_message,
> >                   break
> >               continue
> > -        try:
> > -            msg = console.readline().decode().strip()
> > -        except UnicodeDecodeError:
> > -            msg = None
> > -        if not msg:
> > -            continue
> > -        console_logger.debug(msg)
> > -        if success_message is None or success_message in msg:
> > +        if _console_readline(test, vm,
> > +                             success_message_b,
> > +                             failure_message_b):
> >               break
> > -        if failure_message and failure_message in msg:
> > -            console.close()
> > -            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
> > -                    (failure_message, success_message)
> > -            test.fail(fail)
> >   def interrupt_interactive_console_until_pattern(test, success_message,
> >                                                   failure_message=None,
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


