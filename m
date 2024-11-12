Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1FDD42B85
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArTa-0000jd-Bg; Tue, 12 Nov 2024 09:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tArTL-0000a7-Gl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:02:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tArTJ-0004Tt-Cs
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731420139;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVzasLd+A+R3P5ZcjQG4HoGJW5KIpkeALxqdeI22gG0=;
 b=dAjHjnsS36rvPBME/+wQmqTF3JLnNMqHLYuHklc+N7/ahWy+K6X0Z0xEBc0P7Ey2Lg1F9f
 bPcHatzxmJDZrL0+UdBUmgNBsZUEx0C41kYJGuJ3VKpIZ8iG9lcGb7qjgPr2KQOmmdoEH/
 mpT5CcVfrLFpLQ8MyeG0foKX6NR7O6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-FXedrQ0-MAOiQ6rWPxDsDA-1; Tue,
 12 Nov 2024 09:02:15 -0500
X-MC-Unique: FXedrQ0-MAOiQ6rWPxDsDA-1
X-Mimecast-MFC-AGG-ID: FXedrQ0-MAOiQ6rWPxDsDA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47CBF1954AFD; Tue, 12 Nov 2024 14:02:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF671956054; Tue, 12 Nov 2024 14:02:05 +0000 (UTC)
Date: Tue, 12 Nov 2024 14:02:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/4] tests/functional: Introduce _console_read()
Message-ID: <ZzNf2imfxQ3QF4qc@redhat.com>
References: <20241112130246.970281-1-clg@redhat.com>
 <20241112130246.970281-2-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112130246.970281-2-clg@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 12, 2024 at 02:02:43PM +0100, Cédric Le Goater wrote:
> Interaction with the console has been a problem in our avocado
> tests. In some cases, the expected string does not match in the
> output, causing the test to fail with a timeout. These were worked
> around by sleeping before reading the console and even with SSH
> connections in some places.
> 
> To fix, process the console output char by char and not with
> readline. This routine was largely inspired by console_wait() in
> tests/vm/basevm.py.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  tests/functional/qemu_test/cmd.py | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index cbabb1ceed3c..5bca29d1d721 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -12,6 +12,7 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  import logging
> +import re
>  import os
>  import os.path
>  import subprocess
> @@ -78,6 +79,23 @@ def run_cmd(args):
>  def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>  
> +def _console_read(vm, expect):
> +    console_logger = logging.getLogger('console')
> +    output = ""
> +    while True:
> +        data = vm.console_socket.recv(1)
> +        if not data:
> +            break
> +        output += data.decode("latin1")

Decoding this as 'latin1' is going to mangle any output
that is not represented by a single-byte UTF-8 codepoint.

You can't simply switch this to 'utf8' though, as in the
socket.recv(1) call you're only reading a single byte,
and you can't guarantee that can be decoded if its part
of a multi-byte sequence.

I think you need to read into a bytearray, instead of
reading into a string. Then convert 'expect' into a
bytearray too, and compare bytes for a match, thus
avoiding problem of partial utf8 sequence decoding
errors.

> +        if expect in output:
> +            break
> +        if "\r" in output or "\n" in output:
> +            lines = re.split("[\r\n]", output)
> +            if lines[0]:
> +                console_logger.debug(lines[0])
> +            output = lines.pop()
> +    return output

In the commit message you talk about a problem with non-matched
text, and timeouts causing failure.

IIUC, the key difference between this code and the use of readline()
is that this code is checking for a match in the partial line. ie we
don't need to wait for a newline to arrive anymore.

That's an interesting difference, but its not obviously correlated
with the commit message description.

> +
>  def _console_interaction(test, success_message, failure_message,
>                           send_string, keep_sending=False, vm=None):
>      assert not keep_sending or send_string
> @@ -98,12 +116,12 @@ def _console_interaction(test, success_message, failure_message,
>              continue
>  
>          try:
> -            msg = console.readline().decode().strip()
> +            msg = _console_read(vm, success_message)
>          except UnicodeDecodeError:
>              msg = None
>          if not msg:
>              continue
> -        console_logger.debug(msg)
> +        console_logger.debug('found "%s"', msg)
>          if success_message is None or success_message in msg:
>              break
>          if failure_message and failure_message in msg:
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


