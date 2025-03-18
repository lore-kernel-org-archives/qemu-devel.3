Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F8CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuann-000132-2r; Tue, 18 Mar 2025 13:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuanZ-0000yP-QR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuanX-00050E-Oc
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742319134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VsVntBeLvFKODBhRdIYaO1Xa/Rxi7AD+LNvOzstzu4=;
 b=aa6GHlmgcSxwcKzapMNmnppkI2sP6DVWstqOAmhBUtxsMRqlQkQnIZ8O0t1RfiBa5iv7wN
 SWL/jqqaIgmC/h+SZgWFRrcnHYHEDyW4pcghgGU7gjiAvAhxulkGbe9dbmCLyHHGFtfFvm
 K8eBoU4eChRdEuZvrk1snUepQpk9kFM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-W0xwLTS2M2Kh4snkfi7rAw-1; Tue,
 18 Mar 2025 13:32:10 -0400
X-MC-Unique: W0xwLTS2M2Kh4snkfi7rAw-1
X-Mimecast-MFC-AGG-ID: W0xwLTS2M2Kh4snkfi7rAw_1742319129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0E81956048; Tue, 18 Mar 2025 17:32:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B34B1800268; Tue, 18 Mar 2025 17:32:05 +0000 (UTC)
Date: Tue, 18 Mar 2025 17:32:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
Message-ID: <Z9muEkBv5Q8Ej6eY@redhat.com>
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com> <mvmh63qh18i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmh63qh18i.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 18, 2025 at 03:17:33PM +0100, Andreas Schwab wrote:
> On Mär 18 2025, Daniel P. Berrangé wrote:
> 
> > That would get the synchronization behaviour of Linux vfork,
> > but I'm not sure it'd get the performance benefits (of avoiding
> > page table copying) which is what  Andreas mentioned as the
> > desired thing ?
> 
> For an emulation performance isn't a thing, what we need is accuracy.
> The current issue I have right now is that the MozillaFirefox package
> fails to build because posix_spawn behaves unexpectedly.
> 
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/MozillaFirefox/standard/riscv64
> 
> [  666s]  4:55.15 Traceback (most recent call last):
> [  666s]  4:55.16   File "/home/abuild/rpmbuild/BUILD/MozillaFirefox-136.0.1-build/firefox-136.0.1/security/nss/./coreconf/werror.py", line 80, in <module>
> [  666s]  4:55.16     main()
> [  666s]  4:55.16     ~~~~^^
> [  666s]  4:55.16   File "/home/abuild/rpmbuild/BUILD/MozillaFirefox-136.0.1-build/firefox-136.0.1/security/nss/./coreconf/werror.py", line 10, in main
> [  666s]  4:55.16     cc_is_clang = 'clang' in subprocess.check_output(
> [  666s]  4:55.16                              ~~~~~~~~~~~~~~~~~~~~~~~^
> [  666s]  4:55.16       [cc, '--version'], universal_newlines=True, stderr=sink)
> [  666s]  4:55.16       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  666s]  4:55.16   File "/usr/lib64/python3.13/subprocess.py", line 474, in check_output
> [  666s]  4:55.16     return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
> [  666s]  4:55.16            ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  666s]  4:55.17                **kwargs).stdout
> [  666s]  4:55.17                ^^^^^^^^^
> [  666s]  4:55.17   File "/usr/lib64/python3.13/subprocess.py", line 579, in run
> [  666s]  4:55.17     raise CalledProcessError(retcode, process.args,
> [  666s]  4:55.17                              output=stdout, stderr=stderr)
> [  666s]  4:55.17 subprocess.CalledProcessError: Command '['/usr/bin/ccache /usr/bin/gcc', '--version']' returned non-zero exit status 127.
> 
> A real posix_spawn would have set errno to ENOENT.

I look at how the errno is propagated.

In glibc, they have a struct on the stack of the parent into which the
child will write the errno. This relies on the the vfork() semantics of
sharing of pages, and thus breaks when we use fork() that makes the
pages copy-on-write - the child writes the errno, but the parent will
never see it.

In musl, they create a pipe and the child writes the errno in the pipe
which the parent then reads, so they're seemingly not relying on the
sharing of pages and appears to work under QEMU's impl. 

I don't see an attractive workaround to make glibc's impl compatible
with QEMU, without making QEMU fully use VFORK, with the risk that
entails.  Wonder if its worth enquiring if glibc would be interested
in following musl's approach to make it more emulation friendly for
QEMU ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


