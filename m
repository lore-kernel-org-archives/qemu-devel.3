Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF37D1A443
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Im1-00011O-MO; Mon, 14 Oct 2024 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Ilz-00010l-EL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Ilv-0007LC-Vh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728903475;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4qWsTD79TR/i5SNqtvLvVactFmcM4jA0Ryh1cKi4T+8=;
 b=ctJ969lCUP0O6tfFJY1EzyPnZL4Rwr6ucvQlLRI23BvAa7cTJl19/XjgJy6gPT6McmPcyO
 XFCR79mH2cyeDtdO0tx/MZnUAjNQvsOckZpjW+Nn3VS/deZ2F/lCk+CqwZm/qDIUiPZJlu
 Ycx0uo4kse745iRp+l7i9OePpgpVeBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-38Cf5aQKNTWHHiNNugl4Zw-1; Mon,
 14 Oct 2024 06:57:51 -0400
X-MC-Unique: 38Cf5aQKNTWHHiNNugl4Zw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A986319560B2; Mon, 14 Oct 2024 10:57:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B891A1956088; Mon, 14 Oct 2024 10:57:47 +0000 (UTC)
Date: Mon, 14 Oct 2024 11:57:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
Message-ID: <Zwz5KG9j3bsBk8Lx@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
 <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 14, 2024 at 11:40:11AM +0100, Peter Maydell wrote:
> On Mon, 14 Oct 2024 at 11:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > v2->v3: new patches
> > > - scripts/archive-source: find directory name for subprojects
> > > - docs: fix invalid footnote syntax
> > > - docs: avoid footnotes consisting of just URLs
> > > - docs: use consistent markup for footnotes
> > >
> > > ----------------------------------------------------------------
> > > * first commit for Rust support
> > > * add CI job using Fedora + Rust nightly
> > > * fix detection of ATOMIC128 on x86_64
> > > * fix compilation with Sphinx 8.1.0
> 
> > Applied, thanks.
> 
> With this applied, I find that on one of my personal
> local dev branches an incremental rebuild fails, because
> meson complains about not finding a new enough bindgen,
> even though I did not --enable-rust. Meson also complains
> about a bogus coredata.dat and we end up running meson
> three times before it eventually decides the error is fatal.
> 
> It looks like meson is incorrectly defaulting to "rust
> enabled" rather than "rust disabled" here ?

I've just hit a similar problem, except in my case I'm on Fedora 40
and have new enough rust + bindgen present. It downloaded a bunch of
rust stuff and then failed complaining about the target triple being
unknown:

$ make
make[1]: Entering directory '/var/home/berrange/src/virt/qemu/build'
config-host.mak is out-of-date, running configure
python determined to be '/usr/bin/python3'
python version: Python 3.12.5
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.5.0
mkvenv: checking for pycotap>=1.1.0
mkvenv: installing meson==1.5.0
mkvenv: checking for sphinx>=3.4.3
mkvenv: checking for sphinx_rtd_theme>=0.5
[0/1] Regenerating build files.
WARNING: Regenerating configuration from scratch.
Reason: Coredata file '/var/home/berrange/src/virt/qemu/build/meson-private/coredata.dat' references functions or classes that don't exist. This probably means that it was generated with an old version of meson.
The Meson build system
Version: 1.5.0
Source dir: /var/home/berrange/src/virt/qemu
Build dir: /var/home/berrange/src/virt/qemu/build
Build type: native build
Project name: qemu
Project version: 9.1.50
C compiler for the host machine: cc -m64 (gcc 14.2.1 "cc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)")
C linker for the host machine: cc -m64 ld.bfd 2.41-37
Host machine cpu family: x86_64
Host machine cpu: x86_64
Program scripts/symlink-install-tree.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/symlink-install-tree.py)
Program sh found: YES (/usr/bin/sh)
Program python3 found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3)
Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
Program iasl found: NO
Program bzip2 found: YES (/usr/bin/bzip2)
Compiler for C supports link arguments -Wl,-z,relro: YES 
Compiler for C supports link arguments -Wl,-z,now: YES 
Checking if "-fzero-call-used-regs=used-gpr" compiles: YES 
Compiler for C supports arguments -ftrivial-auto-var-init=zero: YES 
Compiler for C supports arguments -fzero-call-used-regs=used-gpr: YES 
Compiler for C supports arguments -Wempty-body: YES 
Compiler for C supports arguments -Wendif-labels: YES 
Compiler for C supports arguments -Wexpansion-to-defined: YES 
Compiler for C supports arguments -Wformat-security: YES 
Compiler for C supports arguments -Wformat-y2k: YES 
Compiler for C supports arguments -Wignored-qualifiers: YES 
Compiler for C supports arguments -Wimplicit-fallthrough=2: YES 
Compiler for C supports arguments -Winit-self: YES 
Compiler for C supports arguments -Wmissing-format-attribute: YES 
Compiler for C supports arguments -Wmissing-prototypes: YES 
Compiler for C supports arguments -Wnested-externs: YES 
Compiler for C supports arguments -Wold-style-declaration: YES 
Compiler for C supports arguments -Wold-style-definition: YES 
Compiler for C supports arguments -Wredundant-decls: YES 
Compiler for C supports arguments -Wshadow=local: YES 
Compiler for C supports arguments -Wstrict-prototypes: YES 
Compiler for C supports arguments -Wtype-limits: YES 
Compiler for C supports arguments -Wundef: YES 
Compiler for C supports arguments -Wvla: YES 
Compiler for C supports arguments -Wwrite-strings: YES 
Compiler for C supports arguments -Wno-gnu-variable-sized-type-not-at-end: NO 
Compiler for C supports arguments -Wno-initializer-overrides: NO 
Compiler for C supports arguments -Wno-missing-include-dirs: YES 
Compiler for C supports arguments -Wno-psabi: YES 
Compiler for C supports arguments -Wno-shift-negative-value: YES 
Compiler for C supports arguments -Wno-string-plus-int: NO 
Compiler for C supports arguments -Wno-tautological-type-limit-compare: NO 
Compiler for C supports arguments -Wno-typedef-redefinition: NO 
Program cgcc found: YES (/usr/bin/cgcc)
Program scripts/check_sparse.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/check_sparse.py)
Library m found: YES
Run-time dependency threads found: YES
Library util found: YES
Run-time dependency appleframeworks found: NO (tried framework)
Found pkg-config: YES (/usr/bin/pkg-config) 2.1.1
Run-time dependency xencontrol found: YES 4.18.0
Run-time dependency xenstore found: YES 4.0
Run-time dependency xenforeignmemory found: YES 1.4
Run-time dependency xengnttab found: YES 1.2
Run-time dependency xenevtchn found: YES 1.2
Run-time dependency xendevicemodel found: YES 1.4
Run-time dependency xentoolcore found: YES 1.0
Run-time dependency glib-2.0 found: YES 2.80.3
Run-time dependency gmodule-no-export-2.0 found: YES 2.80.3
Run-time dependency gio-2.0 found: YES 2.80.3
Program /usr/bin/gdbus-codegen found: YES (/usr/bin/gdbus-codegen)
Run-time dependency gio-unix-2.0 found: YES 2.80.3
Program scripts/xml-preprocess.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/xml-preprocess.py)
Run-time dependency pixman-1 found: YES 0.43.4
Run-time dependency zlib found: YES 1.3.1.zlib-ng
Has header "libaio.h" : YES 
Library aio found: YES
Run-time dependency liburing found: YES 2.5
Run-time dependency libnfs found: YES 5.0.3
Run-time dependency appleframeworks found: NO (tried framework)
Run-time dependency appleframeworks found: NO (tried framework)
Run-time dependency libseccomp found: YES 2.5.5
Header "seccomp.h" has symbol "SCMP_FLTATR_API_SYSRAWRC" with dependency libseccomp: YES 
Has header "cap-ng.h" : YES 
Library cap-ng found: YES
Run-time dependency xkbcommon found: YES 1.6.0
Run-time dependency slirp found: YES 4.7.0
Has header "libvdeplug.h" : NO 
Run-time dependency libpulse found: YES 16.1
Run-time dependency alsa found: YES 1.2.12
Run-time dependency jack found: YES 1.9.17
Run-time dependency libpipewire-0.3 found: YES 1.0.7
Run-time dependency sndio found: NO (tried pkgconfig)
Run-time dependency spice-protocol found: YES 0.14.4
Run-time dependency spice-server found: YES 0.15.1
Library rt found: YES
Run-time dependency libiscsi found: YES 1.19.0
Run-time dependency libzstd found: YES 1.5.6
Run-time dependency qpl found: NO (tried pkgconfig)
Run-time dependency libwd found: NO (tried pkgconfig)
Run-time dependency libwd_comp found: NO (tried pkgconfig)
Run-time dependency qatzip found: NO (tried pkgconfig)
Run-time dependency virglrenderer found: YES 1.0.1
Run-time dependency rutabaga_gfx_ffi found: NO (tried pkgconfig)
Run-time dependency blkio found: YES 1.5.0
Run-time dependency libcurl found: YES 8.6.0
Run-time dependency libudev found: YES 255
Library mpathpersist found: YES
Library multipath found: YES
Run-time dependency ncursesw found: YES 6.4.20240127
Has header "brlapi.h" : YES 
Library brlapi found: YES
Run-time dependency sdl2 found: YES 2.30.3
Run-time dependency sdl2_image found: YES 2.8.2
Library rados found: YES
Has header "rbd/librbd.h" : YES 
Library rbd found: YES
Run-time dependency glusterfs-api found: YES 7.11.1
Run-time dependency libssh found: YES 0.10.6
Has header "bzlib.h" : YES 
Library bz2 found: YES
Has header "lzfse.h" : NO 
Has header "sys/soundcard.h" : YES 
Run-time dependency epoxy found: YES 1.5.10
Has header "epoxy/egl.h" with dependency epoxy: YES 
Run-time dependency gbm found: YES 24.1.7
Run-time dependency gnutls found: YES 3.8.6
Run-time dependency capstone found: YES 5.0.1
Run-time dependency gmp found: YES 6.2.1
Run-time dependency gtk+-3.0 found: YES 3.24.43
Run-time dependency gtk+-x11-3.0 found: YES 3.24.43
Run-time dependency vte-2.91 found: YES 0.76.3
Run-time dependency x11 found: YES 1.8.10
Run-time dependency libpng found: YES 1.6.40
Run-time dependency libjpeg found: YES 3.0.2
Has header "sasl/sasl.h" : YES 
Library sasl2 found: YES
Has header "security/pam_appl.h" : YES 
Library pam found: YES
Has header "snappy-c.h" : YES 
Library snappy found: YES
Has header "lzo/lzo1x.h" : YES 
Library lzo2 found: YES
Has header "numa.h" : YES 
Library numa found: YES
Library fdt found: YES
Has header "rdma/rdma_cma.h" : YES 
Library rdmacm found: YES
Library ibverbs found: YES
Run-time dependency libcacard found: YES 2.8.1
Run-time dependency u2f-emu found: NO (tried pkgconfig)
Run-time dependency canokey-qemu found: NO (tried pkgconfig)
Run-time dependency libusbredirparser-0.5 found: YES 0.13.0
Run-time dependency libusb-1.0 found: YES 1.0.27
Run-time dependency libpmem found: YES 2.0.1
Run-time dependency libdaxctl found: YES 79
Run-time dependency libtasn1 found: YES 4.19.0
Run-time dependency libkeyutils found: YES 1.6.3
Checking for function "gettid" : YES 
Run-time dependency libselinux found: YES 3.6
Checking for function "malloc_trim" : YES 
Header "sys/stat.h" has symbol "STATX_BASIC_STATS" : YES 
Header "sys/stat.h" has symbol "STATX_MNT_ID" : YES 
Run-time dependency fuse3 found: YES 3.16.2
Run-time dependency libbpf found: YES 1.2.3
Run-time dependency libxdp found: YES 1.4.2
Run-time dependency libdw found: YES 0.191
Header "linux/fs.h" has symbol "FIFREEZE" : YES 
Header "linux/fs.h" has symbol "FITRIM" : YES 
Checking for function "numa_has_preferred_many" with dependency -lnuma: YES 
Checking whether type "struct virgl_renderer_resource_info_ext" has member "d3d_tex2d" with dependency virglrenderer: YES 
Has header "sys/epoll.h" : YES 
Has header "linux/magic.h" : YES 
Has header "valgrind/valgrind.h" : NO 
Has header "linux/btrfs.h" : YES 
Has header "libdrm/drm.h" : YES 
Has header "linux/openat2.h" : YES 
Has header "pty.h" : YES 
Has header "sys/disk.h" : NO 
Has header "sys/ioccom.h" : NO 
Has header "sys/kcov.h" : NO 
Checking for function "close_range" : YES 
Checking for function "accept4" : YES 
Checking for function "clock_adjtime" : YES 
Checking for function "dup3" : YES 
Checking for function "fallocate" : YES 
Checking for function "posix_fallocate" : YES 
Checking for function "getcpu" : YES 
Checking for function "sched_getcpu" : NO 
Checking for function "posix_memalign" : YES 
Checking for function "_aligned_malloc" : NO 
Checking for function "valloc" : YES 
Checking for function "memalign" : YES 
Checking for function "ppoll" : YES 
Checking for function "preadv" : YES 
Checking for function "pthread_fchdir_np" : NO 
Checking for function "sendfile" : YES 
Checking for function "setns" : YES 
Checking for function "unshare" : YES 
Checking for function "syncfs" : YES 
Checking for function "sync_file_range" : YES 
Checking for function "timerfd_create" : YES 
Checking for function "copy_file_range" : YES 
Checking for function "getifaddrs" : YES 
Checking for function "openpty" with dependency -lutil: YES 
Checking for function "strchrnul" : YES 
Checking for function "system" : YES 
Checking for function "rbd_namespace_exists" with dependencies -lrbd, -lrados: YES 
Checking for function "ibv_advise_mr" with dependencies -lrdmacm, -libverbs: YES 
Header "sys/inotify.h" has symbol "inotify_init" : YES 
Header "sys/inotify.h" has symbol "inotify_init1" : YES 
Header "linux/blkzoned.h" has symbol "BLKOPENZONE" : YES 
Header "sys/epoll.h" has symbol "epoll_create1" : YES 
Header "linux/falloc.h" has symbol "FALLOC_FL_PUNCH_HOLE" : YES 
Header "linux/falloc.h" has symbol "FALLOC_FL_KEEP_SIZE" : YES 
Header "linux/falloc.h" has symbol "FALLOC_FL_ZERO_RANGE" : YES 
Has header "linux/fiemap.h" : YES 
Header "linux/fs.h" has symbol "FS_IOC_FIEMAP" : YES 
Checking for function "getrandom" : YES 
Header "sys/random.h" has symbol "GRND_NONBLOCK" : YES 
Header "sys/prctl.h" has symbol "PR_SET_TIMERSLACK" : YES 
Header "linux/rtnetlink.h" has symbol "IFLA_PROTO_DOWN" : YES 
Header "sys/sysmacros.h" has symbol "makedev" : YES 
Header "getopt.h" has symbol "optreset" : NO 
Header "netinet/in.h" has symbol "IPPROTO_MPTCP" : YES 
Checking whether type "struct sigevent" has member "sigev_notify_thread_id" : NO 
Checking whether type "struct stat" has member "st_atim" : YES 
Checking whether type "struct blk_zone" has member "capacity" : YES 
Checking for type "struct iovec" : YES 
Checking for type "struct utmpx" : YES 
Checking for type "struct mmsghdr" : YES 
Header "asm/hwprobe.h" has symbol "RISCV_HWPROBE_EXT_ZBA" : NO 
Header "linux/vm_sockets.h" has symbol "AF_VSOCK" : YES 
Program scripts/minikconf.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/minikconf.py)
Configuring x86_64-softmmu-config-target.h using configuration
Configuring x86_64-softmmu-config-devices.mak with command
Reading depfile: /var/home/berrange/src/virt/qemu/build/meson-private/x86_64-softmmu-config-devices.mak.d
Configuring x86_64-softmmu-config-devices.h using configuration
Program scripts/make-config-poison.sh found: YES (/var/home/berrange/src/virt/qemu/scripts/make-config-poison.sh)

Executing subproject libvhost-user 

libvhost-user| Project name: libvhost-user
libvhost-user| Project version: undefined
libvhost-user| C compiler for the host machine: cc -m64 (gcc 14.2.1 "cc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)")
libvhost-user| C linker for the host machine: cc -m64 ld.bfd 2.41-37
libvhost-user| Compiler for C supports arguments -Wsign-compare: YES
libvhost-user| Compiler for C supports arguments -Wdeclaration-after-statement: YES
libvhost-user| Compiler for C supports arguments -Wstrict-aliasing: YES
libvhost-user| Dependency threads found: YES unknown (cached)
libvhost-user| Dependency glib-2.0 found: YES 2.80.3 (overridden)
libvhost-user| Build targets in project: 5
libvhost-user| Subproject libvhost-user finished.


Executing subproject libvduse 

libvduse| Project name: libvduse
libvduse| Project version: undefined
libvduse| C compiler for the host machine: cc -m64 (gcc 14.2.1 "cc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)")
libvduse| C linker for the host machine: cc -m64 ld.bfd 2.41-37
libvduse| Compiler for C supports arguments -Wsign-compare: YES (cached)
libvduse| Compiler for C supports arguments -Wdeclaration-after-statement: YES (cached)
libvduse| Compiler for C supports arguments -Wstrict-aliasing: YES (cached)
libvduse| Build targets in project: 6
libvduse| Subproject libvduse finished.

Configuring config-host.h using configuration
Program scripts/hxtool found: YES (/var/home/berrange/src/virt/qemu/scripts/hxtool)
Program scripts/shaderinclude.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/shaderinclude.py)
Program scripts/qapi-gen.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/qapi-gen.py)
Program scripts/qemu-version.sh found: YES (/var/home/berrange/src/virt/qemu/scripts/qemu-version.sh)

Executing subproject keycodemapdb 

keycodemapdb| Project name: keycodemapdb
keycodemapdb| Project version: undefined
keycodemapdb| Program tools/keymap-gen found: YES (/var/home/berrange/src/virt/qemu/subprojects/keycodemapdb/tools/keymap-gen)
keycodemapdb| Build targets in project: 269
keycodemapdb| Subproject keycodemapdb finished.

Program scripts/decodetree.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/decodetree.py)
Program ../scripts/modules/module_block.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/block/../scripts/modules/module_block.py)
Program ../scripts/block-coroutine-wrapper.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/block/../scripts/block-coroutine-wrapper.py)
Program scripts/modinfo-collect.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/modinfo-collect.py)
Program scripts/modinfo-generate.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/modinfo-generate.py)
Program nm found: YES
Program scripts/undefsym.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/undefsym.py)
Program scripts/rust/rustc_args.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/rust/rustc_args.py)
Program bindgen found: YES 0.69.4 0.69.4 (/usr/bin/bindgen)
Found CMake: /usr/bin/cmake (3.28.2)
WARNING: CMake Toolchain: Failed to determine CMake compilers state
Build-time dependency quote-1-rs found: NO (tried pkgconfig and cmake)
Looking for a fallback subproject for the dependency quote-1-rs
Downloading quote-1-rs source from https://crates.io/api/v1/crates/quote/1.0.36/download
Download size: 28507
Downloading: ..........

Executing subproject quote-1-rs 

quote-1-rs| Project name: quote-1-rs
quote-1-rs| Project version: 1.12.0
quote-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
quote-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
quote-1-rs| Downloading proc-macro2-1-rs source from https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
Download size: 48922
Downloading: ..........

Executing subproject quote-1-rs:proc-macro2-1-rs

proc-macro2-1-rs| Project name: proc-macro2-1-rs
proc-macro2-1-rs| Project version: 1.0.84
proc-macro2-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
proc-macro2-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
proc-macro2-1-rs| Downloading unicode-ident-1-rs source from https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
Download size: 42168
Downloading: ..........

Executing subproject quote-1-rs:proc-macro2-1-rs:unicode-ident-1-rs

unicode-ident-1-rs| Project name: unicode-ident-1-rs
unicode-ident-1-rs| Project version: 1.0.12
unicode-ident-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
unicode-ident-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
unicode-ident-1-rs| Build targets in project: 342
unicode-ident-1-rs| Subproject unicode-ident-1-rs finished.

proc-macro2-1-rs| Dependency unicode-ident-1-rs found: YES 1.0.12 (overridden)
proc-macro2-1-rs| Build targets in project: 343
proc-macro2-1-rs| Subproject proc-macro2-1-rs finished.

quote-1-rs| Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
quote-1-rs| Build targets in project: 344
quote-1-rs| Subproject quote-1-rs finished.

Dependency quote-1-rs found: YES 1.12.0 (overridden)
Build-time dependency syn-2-rs found: NO (tried pkgconfig and cmake)
Looking for a fallback subproject for the dependency syn-2-rs
Downloading syn-2-rs source from https://crates.io/api/v1/crates/syn/2.0.66/download
Download size: 264855
Downloading: ..........

Executing subproject syn-2-rs 

syn-2-rs| Project name: syn-2-rs
syn-2-rs| Project version: 2.0.66
syn-2-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
syn-2-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
syn-2-rs| Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
syn-2-rs| Dependency quote-1-rs found: YES 1.12.0 (overridden)
syn-2-rs| Dependency unicode-ident-1-rs found: YES 1.0.12 (overridden)
syn-2-rs| Build targets in project: 345
syn-2-rs| Subproject syn-2-rs finished.

Dependency syn-2-rs found: YES 2.0.66 (overridden)
Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
Downloading bilge-0.2-rs source from https://crates.io/api/v1/crates/bilge/0.2.0/download
Download size: 14126
Downloading: ..........

Executing subproject bilge-0.2-rs 

bilge-0.2-rs| Project name: bilge-0.2-rs
bilge-0.2-rs| Project version: 0.2.0
bilge-0.2-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
bilge-0.2-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
bilge-0.2-rs| Downloading arbitrary-int-1-rs source from https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
Download size: 20829
Downloading: ..........

Executing subproject bilge-0.2-rs:arbitrary-int-1-rs

arbitrary-int-1-rs| Project name: arbitrary-int-1-rs
arbitrary-int-1-rs| Project version: 1.2.7
arbitrary-int-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
arbitrary-int-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
arbitrary-int-1-rs| Build targets in project: 348
arbitrary-int-1-rs| Subproject arbitrary-int-1-rs finished.

bilge-0.2-rs| Downloading bilge-impl-0.2-rs source from https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
Download size: 24524
Downloading: ..........

Executing subproject bilge-0.2-rs:bilge-impl-0.2-rs

bilge-impl-0.2-rs| Project name: bilge-impl-0.2-rs
bilge-impl-0.2-rs| Project version: 0.2.0
bilge-impl-0.2-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
bilge-impl-0.2-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
bilge-impl-0.2-rs| Downloading itertools-0.11-rs source from https://crates.io/api/v1/crates/itertools/0.11.0/download
Download size: 125074
Downloading: ..........

Executing subproject bilge-0.2-rs:bilge-impl-0.2-rs:itertools-0.11-rs

itertools-0.11-rs| Project name: itertools-0.11-rs
itertools-0.11-rs| Project version: 0.11.0
itertools-0.11-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
itertools-0.11-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
itertools-0.11-rs| Downloading either-1-rs source from https://crates.io/api/v1/crates/either/1.12.0/download
Download size: 18974
Downloading: ..........

Executing subproject bilge-0.2-rs:bilge-impl-0.2-rs:itertools-0.11-rs:either-1-rs

either-1-rs| Project name: either-1-rs
either-1-rs| Project version: 1.12.0
either-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
either-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
either-1-rs| Build targets in project: 349
either-1-rs| Subproject either-1-rs finished.

itertools-0.11-rs| Dependency either-1-rs found: YES 1.12.0 (overridden)
itertools-0.11-rs| Build targets in project: 350
itertools-0.11-rs| Subproject itertools-0.11-rs finished.

bilge-impl-0.2-rs| Downloading proc-macro-error-attr-1-rs source from https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
^[[6~Download size: 7971
Downloading: ..........

Executing subproject bilge-0.2-rs:bilge-impl-0.2-rs:proc-macro-error-attr-1-rs

proc-macro-error-attr-1-rs| Project name: proc-macro-error-attr-1-rs
proc-macro-error-attr-1-rs| Project version: 1.12.0
proc-macro-error-attr-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
proc-macro-error-attr-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
proc-macro-error-attr-1-rs| Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
proc-macro-error-attr-1-rs| Dependency quote-1-rs found: YES 1.12.0 (overridden)
proc-macro-error-attr-1-rs| Build targets in project: 351
proc-macro-error-attr-1-rs| Subproject proc-macro-error-attr-1-rs finished.

bilge-impl-0.2-rs| Downloading proc-macro-error-1-rs source from https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
Download size: 25293
Downloading: ..........

Executing subproject bilge-0.2-rs:bilge-impl-0.2-rs:proc-macro-error-1-rs

proc-macro-error-1-rs| Project name: proc-macro-error-1-rs
proc-macro-error-1-rs| Project version: 1.0.4
proc-macro-error-1-rs| Rust compiler for the host machine: rustc -C linker=cc -C link-arg=-m64 (rustc 1.81.0)
proc-macro-error-1-rs| Rust linker for the host machine: rustc -C linker=cc -C link-arg=-m64 ld.bfd 2.41-37
proc-macro-error-1-rs| Dependency proc-macro-error-attr-1-rs found: YES 1.12.0 (overridden)
proc-macro-error-1-rs| Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
proc-macro-error-1-rs| Dependency quote-1-rs found: YES 1.12.0 (overridden)
proc-macro-error-1-rs| Dependency syn-2-rs found: YES 2.0.66 (overridden)
proc-macro-error-1-rs| Build targets in project: 352
proc-macro-error-1-rs| Subproject proc-macro-error-1-rs finished.

bilge-impl-0.2-rs| Dependency itertools-0.11-rs found: YES 0.11.0 (overridden)
bilge-impl-0.2-rs| Dependency proc-macro-error-attr-1-rs found: YES 1.12.0 (overridden)
bilge-impl-0.2-rs| Dependency proc-macro-error-1-rs found: YES 1.0.4 (overridden)
bilge-impl-0.2-rs| Dependency quote-1-rs found: YES 1.12.0 (overridden)
bilge-impl-0.2-rs| Dependency syn-2-rs found: YES 2.0.66 (overridden)
bilge-impl-0.2-rs| Dependency proc-macro2-1-rs found: YES 1.0.84 (overridden)
bilge-impl-0.2-rs| Build targets in project: 353
bilge-impl-0.2-rs| Subproject bilge-impl-0.2-rs finished.

bilge-0.2-rs| Dependency arbitrary-int-1-rs found: YES 1.2.7 (overridden)
bilge-0.2-rs| Dependency bilge-impl-0.2-rs found: YES 0.2.0 (overridden)
bilge-0.2-rs| Build targets in project: 354
bilge-0.2-rs| Subproject bilge-0.2-rs finished.

Dependency bilge-0.2-rs found: YES 0.2.0 (overridden)
Dependency bilge-impl-0.2-rs found: YES 0.2.0 (overridden)
Program scripts/feature_to_c.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/feature_to_c.py)
Program scripts/rust/rust_root_crate.sh found: YES (/var/home/berrange/src/virt/qemu/scripts/rust/rust_root_crate.sh)
Configuring 50-qemu-gpu.json using configuration
Program dtc found: NO
Configuring 50-edk2-i386-secure.json using configuration
Configuring 50-edk2-x86_64-secure.json using configuration
Configuring 60-edk2-aarch64.json using configuration
Configuring 60-edk2-arm.json using configuration
Configuring 60-edk2-i386.json using configuration
Configuring 60-edk2-x86_64.json using configuration
Configuring 60-edk2-loongarch64.json using configuration
Program /var/home/berrange/src/virt/qemu/build/pyvenv/bin/sphinx-build found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/sphinx-build)
Program bash found: YES 5.2.26 5.2.26 (/usr/bin/bash)
Program /var/home/berrange/src/virt/qemu/scripts/decodetree.py found: YES (/var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/scripts/decodetree.py)
WARNING: Subproject berkeley-softfloat-3's revision may be out of date; its wrap file has changed since it was first configured

Executing subproject berkeley-softfloat-3 

berkeley-softfloat-3| Project name: berkeley-softfloat-3
berkeley-softfloat-3| Project version: undefined
berkeley-softfloat-3| C compiler for the host machine: cc -m64 (gcc 14.2.1 "cc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)")
berkeley-softfloat-3| C linker for the host machine: cc -m64 ld.bfd 2.41-37
berkeley-softfloat-3| Configuring platform.h using configuration
berkeley-softfloat-3| Build targets in project: 445
berkeley-softfloat-3| Subproject berkeley-softfloat-3 finished.

WARNING: Subproject berkeley-testfloat-3's revision may be out of date; its wrap file has changed since it was first configured

Executing subproject berkeley-testfloat-3 

berkeley-testfloat-3| Project name: berkeley-testfloat-3
berkeley-testfloat-3| Project version: undefined
berkeley-testfloat-3| C compiler for the host machine: cc -m64 (gcc 14.2.1 "cc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)")
berkeley-testfloat-3| C linker for the host machine: cc -m64 ld.bfd 2.41-37
berkeley-testfloat-3| Configuring platform.h using configuration
berkeley-testfloat-3| Compiler for C supports arguments -Wno-ignored-pragmas: NO
berkeley-testfloat-3| Build targets in project: 447
berkeley-testfloat-3| Subproject berkeley-testfloat-3 finished.

Program diff found: YES (/usr/bin/diff)
Program dbus-daemon found: YES (/usr/bin/dbus-daemon)
Run-time dependency gvnc-1.0 found: YES 1.3.1
Run-time dependency sysprof-capture-4 found: YES 46.0
Run-time dependency glib-2.0 found: YES 2.80.3
Program initrd-stress.sh found: YES (/var/home/berrange/src/virt/qemu/tests/migration/initrd-stress.sh)
Program xgettext found: YES (/usr/bin/xgettext)
Program msgfmt found: YES (/usr/bin/msgfmt)
Program msginit found: YES (/usr/bin/msginit)
Program msgmerge found: YES (/usr/bin/msgmerge)
Program xgettext found: YES (/usr/bin/xgettext)

../meson.build:4435:50: ERROR: Key RUST_TARGET_TRIPLE is not in the dictionary.

A full log can be found at /var/home/berrange/src/virt/qemu/build/meson-logs/meson-log.txt
FAILED: build.ninja 
/var/home/berrange/src/virt/qemu/build/pyvenv/bin/meson --internal regenerate /var/home/berrange/src/virt/qemu .
ninja: error: rebuilding 'build.ninja': subcommand failed
[0/1] Regenerating build files.
...gets itself into a fail + re-run loop here, so I ctrl-c now...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


