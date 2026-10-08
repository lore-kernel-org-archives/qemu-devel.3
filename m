Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93105CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 23:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xExkY-0004uI-JI; Thu, 08 Oct 2026 19:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xExj9-0004or-2J
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xExj3-0005qL-7A
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791502831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfD/DDaKlZe++ucTklHXuyA+Bii1X1o6I/kOwNlsK3k=;
 b=HpHMk644+HpfAGuC6J9fKl/J1CA2dsQ5OwEr9QzMzJdY5i/cB8ysCb4zphwB+om8m8X81W
 3Ci6jvaRoJFobn/8Dbd5DDzYAsv3Pak6NIQ6oMC8WxzIYXKCBOaV8c9IkQOnmMhcA5pWAa
 znHxIRG9evo5FlCR0Uqn6Z7dDvp2fdA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-VI-dodunMMa9bhgE8jzu1w-1; Thu, 08 Oct 2026 19:40:30 -0400
X-MC-Unique: VI-dodunMMa9bhgE8jzu1w-1
X-Mimecast-MFC-AGG-ID: VI-dodunMMa9bhgE8jzu1w_1791502830
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a082c014aso396031985a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791502830; x=1792107630; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CfD/DDaKlZe++ucTklHXuyA+Bii1X1o6I/kOwNlsK3k=;
 b=Yvnnlg5l2rMi0lNbmpNwaGQa2+Hz3RMOpfdUOKUPCCOBPdwcOjW/Cvb5UzpubzG51M
 ApK9/Z6ryzzbdEHsEO7GXFtYzQTgq+1yodWYdxsHruaPNLmSb8jDOaJ0XAeWQKRKhle1
 zlqLPwotsZGcjgfO6MGsEYJy+eboIam/6RZb7AvUI37jjIx21blFn+f+C6RC6emHH5/S
 kdSPohE+nSBN7J4tromLhuJhBK/1S3QehMbhAW/gQqSUF7D/tSCqtqco0eOHsq6fjgAY
 1CTw9l0inrov4MzcSr+LOnMSUlch7Lg+Hliww88NdHZDfYfEr7hKC0BoDGdHvuzZ+rGV
 teuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502830; x=1792107630;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CfD/DDaKlZe++ucTklHXuyA+Bii1X1o6I/kOwNlsK3k=;
 b=T8HYA8aw8g2qVimlptrahl+LnuJhFtVY/OlsMrl9TCZ9DL6RH0OAw37xF++pz9d4fe
 EZ30kcHY9AKFfmd3bxZknB9K41RKskxToAA0xnyAQEfPhYZGOErpBGcKIyZgv9LAzDq2
 iT4XhFdSZs3gZ4gIyDySVMFA4T18ArciyD97DyV4iHFGdTxwQQEc1jeviW2KIoSz3dkY
 cuQ12CWTK2TURL7e5v1LbMBC3GdpnhpS+MdSXSc9j+gEY041p8LQS5SO5R2g85WxNsR+
 cQaUfq5+YEo6S4c7SziqY1tfQqp9vI0k9V1YWYpca4ovXoPLWgxqpGF3tka/i2oES7TD
 3fyA==
X-Gm-Message-State: AFq9FYIWgxryldjjh8Wy9lrLnUTm4Tu1fpX/0SPdUawdwC0IPxZVlBoo
 S0tJompfmt6KBBD30wBJs1PGMp4/mtk40FnqrC8V/G5J9pgFGD38uOut/tOgNjYi6uPu+MCJ5BE
 G43sGMSTvJtHWhbQH2bY1Fg8nzj8JSaChxjkdK6AMdlBHQL05P+nWWvJNOUrI1+lU
X-Gm-Gg: AYBFou1CdaADo1WflkFG0qf7gb1uL9IUuTetIStbR56w63u5N0FCvsO5094i/k64P6N
 etbKR0NnBVf4nixScl4YbD+1SMpVe0l9h5Sx+86LnJlQAa9oFG+Rv+6hBnb1lGa5oEs9LLF8wEC
 Jg+JMaZjQMDf6foiUcDnSV86YYQ69D8ySZDQ2CDcd/77i5guLnMjSOY6/9Y3A4F1Ylrl0MUjpfn
 kaDArNlGLFetDK0EfPf6YOs8WGvSDipPBKLm6/s6TS7MZtm492FJsQ8+HsBHxBdXKqYTryTYECw
 txFIsHzvKDUP7qYZm3ShjIvOgMdQiIjqzm5oCHBoSjFagwhkuFMyjyP5E+z1eXYIo3pG7Yw=
X-Received: by 2002:a05:620a:45a5:b0:93e:6db1:8a9f with SMTP id
 af79cd13be357-93eb95e2a80mr114241885a.11.1791502829544; 
 Thu, 08 Oct 2026 16:40:29 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:93e:6db1:8a9f with SMTP id
 af79cd13be357-93eb95e2a80mr114239785a.11.1791502828941; 
 Thu, 08 Oct 2026 16:40:28 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb984889fsm52708385a.13.2026.10.08.16.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:40:27 -0700 (PDT)
Date: Thu, 8 Oct 2026 19:40:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
Message-ID: <asgp6ld6Loz1xmJg@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <8733vbtmge.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8733vbtmge.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
> Hi, I just wanted to share and ask for feedback on some container images
> I've been building as part of my testing of migration pull-requests.
> 
> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
> following:
> 
> $ docker images
> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
> qemu:11.0.0                                   018a3f0f4dcc          2GB
> 
> This last image is stripped (for size) of everything but a few libs and
> binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:
> 
>  CMD ["qemu-system-x86_64"]
> 
> The point is that I can wrap it in a script called qemu-system-x86_64
> and run it interchangeably with any other qemu binary during
> migration-test:
> 
>  QTEST_QEMU_BINARY_SRC=./build-11.0.0/qemu-system-x86_64 \
>  QTEST_QEMU_BINARY=./build-master/qemu-system-x86_64 \
>  ./tests/qtest/migration-test
> 
> (note that migration-test spawns the qemu binaries itself)
> 
> I run tests against the previous 3 QEMU releases. At every release I
> build the container for the new release and at every PR I build the
> container for that git hash using the latest tag as a base.

I'm not a container person, e.g. I did test my recent channel fix on
qemu-7.2 by simply building it with build-7.2/.. but after learning it the
idea using a link to kickoff the container is very interesting on its own
already.

> 
> The reasons that lead me to this solution are:
> 
> 1) Migration compat testing is special, the two migration peers can run
> in different OS versions, so their QEMU builds can be quite different. I
> cannot test using *just* my dev machine, neither using *just* a
> container. I need two hosts. Or two containers running different OSes
> that can both be reachable by the migration-test binary running in
> either of the OSes.

True..  One thing I want to make us on the same page is, this is about
distro, not OS?  Say, the kernel is still the same.

So we have three things (1) QEMU (2) distro (3) kernel/OS.  Here the extra
coverage is (2) only.

My gut feeling is distro specific thing causing migration failure is
extremely rare; I can't even think of any in my work history.  Meanwhile,
it's still not the "real migration", because kernel is shared.  Anything
real will need to happen on two real and different hosts, ultimately, to
make it cover all things.  It's more likely to me that the kernel
difference may fail a migration than distro difference.

So I still agree having such variance is better, though the hope is what we
currently do e.g. with compat migration test is good enough.

Said that, if part of this RFC is to see if we want to introduce that too
for the compat test, no objections either.  Really, it's a matter of if it
will help us find more bugs.

> 
> 2) Neither the QEMU build nor the distro repos are reliable enough to
> allow me to just "go back in time" and rebuild at any moment, I need to
> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
> to send a PR and I discover that some python piece has changed or the
> distro messed up the older repository.

This is definitely true.  While studying your test approach, I also noticed
that there's a "toolbox" tool that should have done many of what your
script did: "enter" the toolbox will transparently map many things (files
under /dev/, or $HOME) automatically.  At least when thinking this as
something I use personally, toolbox seems working.  But again I'm not
container person, maybe there's some difference, just FYI.

> 
> Any thoughts on this? Could it be useful to anyone? Maybe the stable
> branch has some similar issues?

I'd be surprised if Michael would need to test stable branch migrations!
That's IMHO too much work for him.. if it needs to be more than what CI
covers.  After all, migration is only a submodule in stable maint pov.

So, I'm not sure whether some of those should be in upstream repo, let me
know your thoughts.  Besides, I'll definitely play more with toolbox and
your scripts some day.

Thanks for sharing!

> 
> I have a messy script that builds everything, but here are the important
> pieces:
> 
> - Dockerfile.rootfs.base ==> qemu-rootfs-base-11.1.0
> This is just ./tests/docker/dockerfiles/opensuse-leap.docker with a sed
> to remove ncurses-devel (suse repo issue)
> 
> 
> - Dockerfile.build.base ==> qemu-build-base:11.1.0
> FROM qemu-rootfs-base:11.1.0
> 
> # actual source, mounted RO
> RUN mkdir /src
> 
> # not the actual build dir, only the artifacts that are needed
> RUN mkdir /build
> 
> WORKDIR /build-tmp-11.1.0
> 
> RUN --mount=type=cache,target=/build-tmp-11.1.0,rw \
>     --mount=type=bind,from=qemu-src-11.1.0,target=/src,ro \
>     /src/configure \
>     --target-list=x86_64-softmmu,aarch64-softmmu,ppc64-softmmu,s390x-softmmu \
>     --disable-plugins --disable-modules --enable-werror --enable-debug \
>     --disable-docs --disable-tools && \
>     make -j14 && { echo 'build ok'; } || { echo 'build failed'; exit 1; }; \
>     cp -rL qemu-bundle /build && \
>     cp -rL scripts /build && \
>     find . -maxdepth 1 -name "qemu-system-*" -type f -exec cp {} /build \; && \
>     find . -maxdepth 1 -name "tests" -type d -exec cp -r {} /build/tests \; ;
> 
> RUN --mount=type=cache,target=/build-tmp-11.1.0,rw \
>     find /build -maxdepth 1 -name "qemu-system-*" -type f -exec cp -s {} /bin \; && \
>     find /build/tests/qtest -maxdepth 1 -name "migration-test" -type f -exec ln -sfT {} /bin/migration-test \; ;
> ---
> 
> 
> - Dockerfile ==> qemu:11.1.0
> FROM qemu-build-base:11.1.0 AS runtime
> 
> WORKDIR /build
> 
> # isolate the library dependencies of qemu, python and gdb
> RUN mkdir /libs64 && \
>     cp -L $(ldd qemu-system-x86_64 | awk '{print $3}' | xargs) /libs64 && \
>     cp -L $(ldd /usr/bin/gdb | awk '{print $3}' | xargs) /libs64 && \
>     cp -L $(ldd /usr/bin/python3 | awk '{print $3}' | xargs) /libs64 && \
>     cp -L $(ldd /bin/sh | awk '{print $3}' | xargs) /libs64 && \
>     cp -L $(ldd /bin/sh | grep ld-linux | awk '{print $1}' | xargs) /libs64 && \
>     cp -L $(ldd /usr/lib64/$(readlink $(which python3))/site-packages/rpm/_rpm*.so | awk '{print $3}' | xargs) /libs64
> # rpm stuff above is because gdb has its own python runtime
> 
> RUN mkdir -p /slash/usr/share && \
>     cp -r /usr/lib64/python* /libs64 && \
>     ln -sfT /lib64 /slash/usr/lib64
> 
> RUN mkdir /libs && \
>     cp -r /usr/lib/rpm* /libs
> 
> # only these binaries in the image to keep it small
> RUN mkdir /bins && \
>     cp -L /bin/sh /bins/ && \
>     cp -L /bin/ls /bins/ && \
>     cp -L /bin/echo /bins/ && \
>     cp -L /usr/bin/cat /bins/ && \
>     cp -L /usr/bin/gdb /bins/ && \
>     cp -L /usr/bin/python3 /bins/ && \
>     cp -L /usr/bin/docker /bins/ && \
>     cp -L /usr/bin/env /bins/ && \
>     cp -rL /usr/share/gdb /slash/usr/share
> 
> # symlinks
> RUN cp -d /bin/migration-test /bins/ && \
>     cp -d /bin/qemu-system-* /bins/
> 
> FROM scratch
> COPY --from=runtime /slash /
> COPY --from=runtime /libs64 /lib64
> COPY --from=runtime /libs /usr/lib
> COPY --from=runtime /bins /bin
> COPY --from=runtime /build /build
> ENV PYTHONPATH="/lib64/python3.13"
> ENV TMPDIR="/tmp/migtmp"
> WORKDIR /build
> 
> # -version helps debugging, this is overriden when calling qemu with
> # proper args
> CMD ["qemu-system-x86_64", "-version"]
> ---
> 
> 
> - The wrappers. One for each of qemu-system-x86_64, sh, migration-test,
>   these live in a build-<version> directory.
> ---
> #!/bin/sh
> 
> # pass the environment into the container 
> echo > "/tmp/migtmp/envfile"
> env | while IFS= read -r line; do
>     case "$line" in
>     QTEST*|QEMU*|PYTHON*)
>         echo "$line" >> "/tmp/migtmp/envfile"
>         ;;
>     esac
> done
> 
> bin=qemu-system-x86_64
> exec docker run --rm -w /build \
>                 -v /tmp/migtmp:/tmp/migtmp \
>                 -v /home/farosas/archive:/archive \
>                 -v /var/run/docker.sock:/var/run/docker.sock \
>                 --network host \
>                 --env-file /tmp/migtmp/envfile \
>                 --cap-add=SYS_PTRACE \
>                 --security-opt seccomp=unconfined \
>                 --device /dev/kvm \
>                 --device /dev/userfaultfd:/dev/userfaultfd \
>                 -it qemu:11.1.0 $bin $(printf "%s\n" "$@")
> ---
> 
> - The snippet of the test script that uses all of this:
> 
> cd ./archive/build-11.0.0
> 
> # container-relative
> CURRENT_QEMU=/archive/build-latest
> 
> if [ $1 = "src" ]; then
>      info "forward..."
>      run_qtest PYTHON=/bin/python3 TMPDIR=/tmp/migtmp \
>      QTEST_QEMU_BINARY=${CURRENT_QEMU}/qemu-system-${ARCH} \
>      QTEST_QEMU_BINARY_SRC=./qemu-system-${ARCH} ./tests/qtest/${TEST}
> else
>      info "backward..."
>      run_qtest PYTHON=/bin/python3 TMPDIR=/tmp/migtmp \
>      QTEST_QEMU_BINARY=${CURRENT_QEMU}/qemu-system-${ARCH} \
>      QTEST_QEMU_BINARY_DST=./qemu-system-${ARCH} ./tests/qtest/${TEST}
> fi
> ---
> 

-- 
Peter Xu


