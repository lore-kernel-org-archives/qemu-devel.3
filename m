Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97010CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfl8-0001O7-8B; Tue, 01 Oct 2024 12:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svfl4-0001N1-EO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svfkw-0004qY-M4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727800184;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3cDFy7QTrtWlLWJleuZ867XUu6ujNwWXzfEcAvy9Tf8=;
 b=ZA6JGximWQUlJW0Go63rDSReAVvK8OfhDoYmfRK59P4q/gw+KWmzJytIZMkbBLfx6CSRyP
 hH36Gf6Rn+nxw7yDqfzBbIO1XSJZWpT89p85n9aY4HBK2eggWFkixRBF5SdbT6edv/AKCM
 mlzZdQT/Ib6oc99zdR+j+1+NR4iAdnk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-4_-jFcvpPKK38C9SB4tr4A-1; Tue,
 01 Oct 2024 12:29:43 -0400
X-MC-Unique: 4_-jFcvpPKK38C9SB4tr4A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EEFB1933E98; Tue,  1 Oct 2024 16:29:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A96621944CF6; Tue,  1 Oct 2024 16:29:39 +0000 (UTC)
Date: Tue, 1 Oct 2024 17:29:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: what is the right way for an avocado test to do "wait for text
 that doesn't end in newline" ?
Message-ID: <ZvwjcOJaX7ax3SEk@redhat.com>
References: <CAFEAcA8N8NoaPMKQN=_Ph1mmgE1DEn=7kDOuOVMUX4zBEaBmug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8N8NoaPMKQN=_Ph1mmgE1DEn=7kDOuOVMUX4zBEaBmug@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 01, 2024 at 01:43:47PM +0100, Peter Maydell wrote:
> One common thing to want to do in an avocado test is log into
> the guest. The obvious way to do that would seem to be:
> 
>          self.wait_for_console_pattern('login:')
>          exec_command(self, 'root')
>          self.wait_for_console_pattern('Password:')
>          exec_command(self, "passw0rd")
> 
> This doesn't work; Thomas tells me that's because the
> wait_for_console_pattern function requires that the guest outputs
> a newline, but the 'login:' and 'Password:' prompt lines don't
> have a newline after them.

I presume the problem is ultimately this lne of code
which calls 'readline()'

         try:
            msg = console.readline().decode().strip()
        except UnicodeDecodeError:
            msg = None
        if not msg:
            continue

I would think we should change this to read a byte at
a time, trying the pattern  match after each line until
it succeeeds.

It would have to gracefully handle unicode decode errors,
trying to get more bytes, instead of discarding the data,
because reading byte a time we might only have a partial
utf8 sequence. Or we could ensure that "console" is opened
with utf8 decoding by default instead of raw bytes.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


