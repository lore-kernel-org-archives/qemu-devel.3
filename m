Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E0C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GZD-0002SB-Nj; Mon, 14 Sep 2026 19:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GZC-0002Rz-C1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:58:30 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GZA-0004Oy-Aa
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:58:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEF1B21DA2;
 Mon, 14 Sep 2026 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=33uSsAhfoVdokLUOv+9SvWqNI1Ttl/c+0tvk+yQmRhM=;
 b=vduG/roq1lKvyb95zFrclsMouFWAnPwF4C3Xty4F+XWKk3HFpcm1JnoIvOjq5Gm3T7A5sk
 OUDjXWxJ8oOYZxad5e9p+qSodmlG3tHNwjJrh0Ow7A42aTLZSLSPHkFGdjzof9AzTOQcBe
 k6c2lb/3W1HASe57z39yQZOaHfZwWqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=33uSsAhfoVdokLUOv+9SvWqNI1Ttl/c+0tvk+yQmRhM=;
 b=PhIa+HcRX7LBM3/Ed5TXUC5EaWU7Se9CCjlBWYsQ9GS6GM/5OCXQ35fRSK6SqS2+f54225
 /9eo2pSuylHg58AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YgY9lwtI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+oTxAKPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=33uSsAhfoVdokLUOv+9SvWqNI1Ttl/c+0tvk+yQmRhM=;
 b=YgY9lwtI4j6G//X7SxEkWw3qXryIKWNeTuoMTAzKR5R0Ve8OX7WzzBm1hxH+L/NglGtrTH
 4311rkbJxdCqVokKKfTgxIH2qLz8aA90l21tYZFoh4vSuUAIp0dp8ZDI+a1cFOzsipTiPe
 kTsrQnWM5oNk3R1o6evDC+npf36uim4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=33uSsAhfoVdokLUOv+9SvWqNI1Ttl/c+0tvk+yQmRhM=;
 b=+oTxAKPiwHsEjWvh606gsjSpfVi6kB4JyiFELjhIXTtO3Fr28WibwddbxLcmThMJ9sPfql
 Ac5CNyngBOH3uxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5144D13515;
 Mon, 14 Sep 2026 23:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xA8mCRiKqGrueAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Sep 2026 23:58:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
Subject: [RFC] container images for migration-test
Date: Mon, 14 Sep 2026 20:58:09 -0300
Message-ID: <8733vbtmge.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CEF1B21DA2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,build.base:url,rootfs.base:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi, I just wanted to share and ask for feedback on some container images
I've been building as part of my testing of migration pull-requests.

From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
following:

$ docker images
qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
qemu:11.0.0                                   018a3f0f4dcc          2GB

This last image is stripped (for size) of everything but a few libs and
binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:

 CMD ["qemu-system-x86_64"]

The point is that I can wrap it in a script called qemu-system-x86_64
and run it interchangeably with any other qemu binary during
migration-test:

 QTEST_QEMU_BINARY_SRC=./build-11.0.0/qemu-system-x86_64 \
 QTEST_QEMU_BINARY=./build-master/qemu-system-x86_64 \
 ./tests/qtest/migration-test

(note that migration-test spawns the qemu binaries itself)

I run tests against the previous 3 QEMU releases. At every release I
build the container for the new release and at every PR I build the
container for that git hash using the latest tag as a base.

The reasons that lead me to this solution are:

1) Migration compat testing is special, the two migration peers can run
in different OS versions, so their QEMU builds can be quite different. I
cannot test using *just* my dev machine, neither using *just* a
container. I need two hosts. Or two containers running different OSes
that can both be reachable by the migration-test binary running in
either of the OSes.

2) Neither the QEMU build nor the distro repos are reliable enough to
allow me to just "go back in time" and rebuild at any moment, I need to
keep the artifacts cached to avoid rebuilding. Otherwise it comes time
to send a PR and I discover that some python piece has changed or the
distro messed up the older repository.

Any thoughts on this? Could it be useful to anyone? Maybe the stable
branch has some similar issues?

I have a messy script that builds everything, but here are the important
pieces:

- Dockerfile.rootfs.base ==> qemu-rootfs-base-11.1.0
This is just ./tests/docker/dockerfiles/opensuse-leap.docker with a sed
to remove ncurses-devel (suse repo issue)


- Dockerfile.build.base ==> qemu-build-base:11.1.0
FROM qemu-rootfs-base:11.1.0

# actual source, mounted RO
RUN mkdir /src

# not the actual build dir, only the artifacts that are needed
RUN mkdir /build

WORKDIR /build-tmp-11.1.0

RUN --mount=type=cache,target=/build-tmp-11.1.0,rw \
    --mount=type=bind,from=qemu-src-11.1.0,target=/src,ro \
    /src/configure \
    --target-list=x86_64-softmmu,aarch64-softmmu,ppc64-softmmu,s390x-softmmu \
    --disable-plugins --disable-modules --enable-werror --enable-debug \
    --disable-docs --disable-tools && \
    make -j14 && { echo 'build ok'; } || { echo 'build failed'; exit 1; }; \
    cp -rL qemu-bundle /build && \
    cp -rL scripts /build && \
    find . -maxdepth 1 -name "qemu-system-*" -type f -exec cp {} /build \; && \
    find . -maxdepth 1 -name "tests" -type d -exec cp -r {} /build/tests \; ;

RUN --mount=type=cache,target=/build-tmp-11.1.0,rw \
    find /build -maxdepth 1 -name "qemu-system-*" -type f -exec cp -s {} /bin \; && \
    find /build/tests/qtest -maxdepth 1 -name "migration-test" -type f -exec ln -sfT {} /bin/migration-test \; ;
---


- Dockerfile ==> qemu:11.1.0
FROM qemu-build-base:11.1.0 AS runtime

WORKDIR /build

# isolate the library dependencies of qemu, python and gdb
RUN mkdir /libs64 && \
    cp -L $(ldd qemu-system-x86_64 | awk '{print $3}' | xargs) /libs64 && \
    cp -L $(ldd /usr/bin/gdb | awk '{print $3}' | xargs) /libs64 && \
    cp -L $(ldd /usr/bin/python3 | awk '{print $3}' | xargs) /libs64 && \
    cp -L $(ldd /bin/sh | awk '{print $3}' | xargs) /libs64 && \
    cp -L $(ldd /bin/sh | grep ld-linux | awk '{print $1}' | xargs) /libs64 && \
    cp -L $(ldd /usr/lib64/$(readlink $(which python3))/site-packages/rpm/_rpm*.so | awk '{print $3}' | xargs) /libs64
# rpm stuff above is because gdb has its own python runtime

RUN mkdir -p /slash/usr/share && \
    cp -r /usr/lib64/python* /libs64 && \
    ln -sfT /lib64 /slash/usr/lib64

RUN mkdir /libs && \
    cp -r /usr/lib/rpm* /libs

# only these binaries in the image to keep it small
RUN mkdir /bins && \
    cp -L /bin/sh /bins/ && \
    cp -L /bin/ls /bins/ && \
    cp -L /bin/echo /bins/ && \
    cp -L /usr/bin/cat /bins/ && \
    cp -L /usr/bin/gdb /bins/ && \
    cp -L /usr/bin/python3 /bins/ && \
    cp -L /usr/bin/docker /bins/ && \
    cp -L /usr/bin/env /bins/ && \
    cp -rL /usr/share/gdb /slash/usr/share

# symlinks
RUN cp -d /bin/migration-test /bins/ && \
    cp -d /bin/qemu-system-* /bins/

FROM scratch
COPY --from=runtime /slash /
COPY --from=runtime /libs64 /lib64
COPY --from=runtime /libs /usr/lib
COPY --from=runtime /bins /bin
COPY --from=runtime /build /build
ENV PYTHONPATH="/lib64/python3.13"
ENV TMPDIR="/tmp/migtmp"
WORKDIR /build

# -version helps debugging, this is overriden when calling qemu with
# proper args
CMD ["qemu-system-x86_64", "-version"]
---


- The wrappers. One for each of qemu-system-x86_64, sh, migration-test,
  these live in a build-<version> directory.
---
#!/bin/sh

# pass the environment into the container 
echo > "/tmp/migtmp/envfile"
env | while IFS= read -r line; do
    case "$line" in
    QTEST*|QEMU*|PYTHON*)
        echo "$line" >> "/tmp/migtmp/envfile"
        ;;
    esac
done

bin=qemu-system-x86_64
exec docker run --rm -w /build \
                -v /tmp/migtmp:/tmp/migtmp \
                -v /home/farosas/archive:/archive \
                -v /var/run/docker.sock:/var/run/docker.sock \
                --network host \
                --env-file /tmp/migtmp/envfile \
                --cap-add=SYS_PTRACE \
                --security-opt seccomp=unconfined \
                --device /dev/kvm \
                --device /dev/userfaultfd:/dev/userfaultfd \
                -it qemu:11.1.0 $bin $(printf "%s\n" "$@")
---

- The snippet of the test script that uses all of this:

cd ./archive/build-11.0.0

# container-relative
CURRENT_QEMU=/archive/build-latest

if [ $1 = "src" ]; then
     info "forward..."
     run_qtest PYTHON=/bin/python3 TMPDIR=/tmp/migtmp \
     QTEST_QEMU_BINARY=${CURRENT_QEMU}/qemu-system-${ARCH} \
     QTEST_QEMU_BINARY_SRC=./qemu-system-${ARCH} ./tests/qtest/${TEST}
else
     info "backward..."
     run_qtest PYTHON=/bin/python3 TMPDIR=/tmp/migtmp \
     QTEST_QEMU_BINARY=${CURRENT_QEMU}/qemu-system-${ARCH} \
     QTEST_QEMU_BINARY_DST=./qemu-system-${ARCH} ./tests/qtest/${TEST}
fi
---


