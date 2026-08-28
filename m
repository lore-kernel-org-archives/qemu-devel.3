Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E22C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzveK-0005m7-8o; Fri, 28 Aug 2026 08:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzveJ-0005ln-2f
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:25:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzveG-000111-Fe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:25:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so6986975e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919931; x=1788524731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x7IIqzfYo/k3tIZHIH7OgEy31u3T94zwC6jkiM6qVzY=;
 b=norPcUkwjk4vZgDmVsFAU2rEC+vqGXuu0i5Z84GL4XpvK/31unC2dNfyN/gPddtkS+
 SWEdfLg4rMQDUskfFRaxCxmhnmGIFTK+VxJDGeHS0gydxaw/SROzCCk+Lw3O/WeJ41TF
 CjdA4maqUSW7LIr8/jK6A6Yt01OEs1fzLtIqY4R8rqO73hAGjYdQAwy8SSJ77taKPv98
 q1ejXFMGCgx/oanpePGhmhujDYmha2Obqt7zm5nTI4L6MMaAd2nJ+wYJ9LZ/cAqutQqg
 r2N7aIoREwgfAXIDX67VW4txEBaoVL9FNBt9ZxZGIg+NJxjFks0erJY8sA/SVoYMftIf
 dmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919931; x=1788524731;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x7IIqzfYo/k3tIZHIH7OgEy31u3T94zwC6jkiM6qVzY=;
 b=eKh/KmWeTMQ6Kxo/7O+juiJSF/i5ICNeL9zeGm8F1bdFdTvFenVrlhd22fc829h2v6
 +9/fPJXqgs44mBP3y8tYK9SLiBQmBJ886DGhk+3OjFDIJnpqJfT84hzmer4U6UZiU1nl
 jUK/72anVuEWbOl1e7kn1NFSrzPc2jp111fl4lUbcY9y8T2QkpdfOAItg+2/mLhiPCVz
 ZpNM0PdgilpqVPNoWFj9ZEiO2N8CkAudZ+bVT7GYjD4wOAXvJD/fik6y1BJpRDvPUmub
 7JvSRs2IBQtwefjgo4K2ltKtHkAwbyrfmEiG77HaS5QtIZxSzl/usdmv5ocQHTfbz6jG
 zCWg==
X-Gm-Message-State: AFuF++mhQ/3e2y0p2yJqRwDMZNmepj+fl28DbPP4Uc9y+d2pvqNTx9P+
 ExUNJ3WwmlK+fE8xoOLYzUdR/IWRU+bzjWpABCGYuO2/bEOTViVchT+z2vw/Wa0ro/0=
X-Gm-Gg: AR+sD12zqpJGjc6T4bUdridhFKfHbii5kfu3af6vhxh35qcAbv+QettwHOZ67D9mx37
 y8wo7SHZp+xe42tAh+TT4VlTKT7dpbLDGjhVGmXd0mmkyIflxUSpVOuM7KXvz2drQ5LGwD9I1Nv
 HdCjj0SJ3jhXj0ZrkujALMe0OWggKDY5vaoALGk+jO5Z9AZZ7gIAc5QACUBfEMAynr7oOgl6992
 Pw1f2C4hDw1jUdaW5ixQtvbLCTGWaqlWYxog2la6W8JKJmVLxDhUuv7Dh1C3oGaRPz1fXE+tRfl
 6i74RoHCWIVWBmq0NrNaIwHs9UOsHDgN3bcrAFfwsUTJQXrpIJejbQ/my33hJlit5xrZuiRvwX8
 AkbtkTSsr6BYGU2tYX5g3gnZEzM2xQ92ahBNXVuYauR7+/WiTkqf22wcx8w43rajOhu/IxlGGI3
 brAAznt+Sq2pM8f99+QgzwausM3U6ft/6ri9aTjQOQtUmSKDNQS4PJGaFawqBHdvOyXI9CfOk=
X-Received: by 2002:a05:600c:4e41:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49b91c63a47mr98153735e9.12.1787919930532; 
 Fri, 28 Aug 2026 05:25:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b90f78244sm83609445e9.10.2026.08.28.05.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:25:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95F775F7E6;
 Fri, 28 Aug 2026 13:25:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  pbonzini@redhat.com,  stefanha@redhat.com
Subject: Re: [PULL 1/1] tests/docker: ensure container command is probed at
 most once
In-Reply-To: <20260716195807.3219466-2-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 16 Jul 2026 12:58:07 -0700")
References: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
 <20260716195807.3219466-2-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 28 Aug 2026 13:25:28 +0100
Message-ID: <87v78u3007.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The '--engine' arg accepts either 'podman' or 'docker', which is
> not sufficiently granular to map directly to a command. This
> means that  docker.py still has to then probe the exact command
> to use.
>
> Meanwhile the 'probe' command prints out the full command to use
> but this cannot be passed back to docker.py to avoid probing
> again, so the caching is only useful in the few case where we
> run a container directly bypassing docker.py.
>
> Address this by replacing --engine with --command for docker.py.
>
> This in turn requires the --container-engine configure arg to be
> replaced with --container-command.
>
> With these changes the container command is probed at most once
> during configure and never again, while running in an unconfigured
> tree will still probe on demand.
>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20260716102515.1503404-1-berrang=
e@redhat.com
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I've bisected to this as breaking --disable-containers:

  ../../configure --target-list=3Daarch64-linux-user,loongarch64-linux-user=
 --disable-containers
  ...
    Cross compilers=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
      aarch64                         : aarch64-linux-gnu-gcc
      loongarch64                     : cc --cc loongarch64-unknown-linux-g=
nu-gcc -i qemu/debian-loongarch-cross -s /home/alex.bennee/lsrc/qemu.git --

So some mangling with the container command line has happened.

> ---
>  configure                     | 25 +++++++------
>  tests/docker/Makefile.include | 13 ++++---
>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>  3 files changed, 40 insertions(+), 65 deletions(-)
>
> diff --git a/configure b/configure
> index d8bc10060e1..6ddfe4b5342 100755
> --- a/configure
> +++ b/configure
> @@ -172,7 +172,7 @@ fi
>  # some defaults, based on the host environment
>=20=20
>  # default parameters
> -container_engine=3D"auto"
> +container_command=3D""
>  cpu=3D""
>  cross_compile=3D"no"
>  cross_prefix=3D""
> @@ -734,7 +734,7 @@ for opt do
>    ;;
>    --disable-containers) use_containers=3D"no"
>    ;;
> -  --container-engine=3D*) container_engine=3D"$optarg"
> +  --container-command=3D*) container_command=3D"$optarg"
>    ;;
>    --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
>    ;;
> @@ -869,7 +869,7 @@ Advanced options (experts only):
>    --enable-debug           enable common debug build options
>    --cpu=3DCPU                Build for host CPU [$cpu]
>    --disable-containers     don't use containers for cross-building
> -  --container-engine=3DTYPE  which container engine to use [$container_e=
ngine]
> +  --container-command=3DCMD  which container command to use [autodetect]
>    --gdb=3DGDB-path           gdb to use for gdbstub tests [$gdb_bin]
>    --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (=
default
>                                 is to use the whole 64-bit range).
> @@ -1291,12 +1291,12 @@ fi
>  ##########################################
>  # functions to probe cross compilers
>=20=20
> -runc=3D"no"
> -if test $use_containers =3D "yes" && (has "docker" || has "podman"); then
> -    runc=3D$($python "$source_path"/tests/docker/docker.py --engine "$co=
ntainer_engine" probe)
> -    if test "$runc" !=3D "no"; then
> -        docker_py=3D"$python $source_path/tests/docker/docker.py --engin=
e $container_engine"
> -    fi
> +if test "$container_command" =3D ""; then
> +    container_command=3D$($python "$source_path"/tests/docker/docker.py =
probe)
> +    test "$container_command" =3D "no" && container_command=3D""
> +fi
> +if test $use_containers =3D "yes" && test "$container_command" !=3D ""; =
then
> +    docker_py=3D"$python $source_path/tests/docker/docker.py --command $=
container_command"

else
  container_command=3D""
fi

?

>=20=20
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> @@ -1415,7 +1415,7 @@ probe_target_compiler() {
>    esac
>=20=20
>    for host in $container_hosts; do
> -    test "$runc" !=3D no || continue
> +    test "$container_command" !=3D "" || continue
>      test "$host" =3D "$cpu" || continue
>      case $target_arch in
>        # debian-all-test-cross architectures
> @@ -1736,9 +1736,8 @@ echo all: >> $config_host_mak
>  echo "SRC_PATH=3D$source_path" >> $config_host_mak
>  echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
>  echo "GDB=3D$gdb_bin" >> $config_host_mak
> -if test "$runc" !=3D no; then
> -    echo "RUNC=3D$runc" >> $config_host_mak
> -    echo "CONTAINER_ENGINE=3D$container_engine" >> $config_host_mak
> +if test "$container_command" !=3D ""; then
> +    echo "CONTAINER_COMMAND=3D$container_command" >> $config_host_mak
>  fi
>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
>  if test "$rust" !=3D disabled; then
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 4725c39807b..0adddb6a5c6 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY :=3D registry.gitlab.com/qemu-p=
roject/qemu
>  endif
>  DOCKER_REGISTRY :=3D $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGIS=
TRY))
>=20=20
> -CONTAINER_ENGINE =3D auto
> -DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --engine $(CONTAINER_=
ENGINE)
> -RUNC ?=3D $(shell $(DOCKER_SCRIPT) probe)
> +CONTAINER_COMMAND ?=3D $(shell $(SRC_PATH)/tests/docker/docker.py probe)
> +DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --command "$(CONTAINE=
R_COMMAND)"
>=20=20
>  CUR_TIME :=3D $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
>  DOCKER_SRC_COPY :=3D $(BUILD_DIR)/docker-src.$(CUR_TIME)
> @@ -41,7 +40,7 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
>  # General rule for building docker images.
>  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  	  $(call quiet-command,			\
> -		DOCKER_BUILDKIT=3D1 $(RUNC) build		\
> +		DOCKER_BUILDKIT=3D1 $(CONTAINER_COMMAND) build \
>  		$(if $(DOCKER_V),,--quiet)		\
>  		$(if $(NOCACHE),--no-cache,		\
>  			$(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
> @@ -152,7 +151,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(D=
OCKER_IMAGES)), \
>  )
>=20=20
>  docker:
> -	@echo 'Build QEMU and run tests inside $(RUNC) containers'
> +	@echo 'Build QEMU and run tests inside $(CONTAINER_COMMAND) containers'
>  	@echo
>  	@echo 'Available targets:'
>  	@echo
> @@ -219,10 +218,10 @@ docker-run: docker-qemu-src
>  			$(IMAGE) --executable $(EXECUTABLE),		\
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
> -		$(RUNC) run 						\
> +		$(CONTAINER_COMMAND) run 				\
>  			--rm						\
>  			$(if $(NOUSER),,				\
> -				$(if $(filter docker,$(RUNC)),		\
> +				$(if $(filter docker,$(CONTAINER_COMMAND)), \
>  					-u $(UID),			\
>  					--userns keep-id		\
>  				)					\
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9e18b984f45..d2f39b5645b 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -35,27 +35,6 @@
>=20=20
>  DEVNULL =3D open(os.devnull, 'wb')
>=20=20
> -class EngineEnum(enum.IntEnum):
> -    AUTO =3D 1
> -    DOCKER =3D 2
> -    PODMAN =3D 3
> -
> -    def __str__(self):
> -        return self.name.lower()
> -
> -    def __repr__(self):
> -        return str(self)
> -
> -    @staticmethod
> -    def argparse(s):
> -        try:
> -            return EngineEnum[s.upper()]
> -        except KeyError:
> -            return s
> -
> -
> -USE_ENGINE =3D EngineEnum.AUTO
> -
>  def _bytes_checksum(bytes):
>      """Calculate a digest string unique to the text content"""
>      return hashlib.sha1(bytes).hexdigest()
> @@ -73,12 +52,11 @@ def _file_checksum(filename):
>=20=20
>  def _guess_engine_command():
>      """ Guess a working engine command or raise exception if not found"""
> -    commands =3D []
> -
> -    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> -        commands +=3D [["podman"], ["podman-remote"], ["podman", "--remo=
te"]]
> -    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
> -        commands +=3D [["docker"], ["sudo", "-n", "docker"]]
> +    commands =3D [["podman"],
> +                ["podman-remote"],
> +                ["podman", "--remote"],
> +                ["docker"],
> +                ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
>              # 'version' is not sufficient to prove a working binary
> @@ -222,8 +200,11 @@ def _dockerfile_verify_flat(df):
>=20=20
>  class Docker(object):
>      """ Running Docker commands """
> -    def __init__(self):
> -        self._command =3D _guess_engine_command()
> +    def __init__(self, commandstr=3DNone):
> +        if commandstr is None:
> +            self._command =3D _guess_engine_command()
> +        else:
> +            self._command =3D commandstr.split(" ")
>=20=20
>          if ("docker" in self._command and
>              "TRAVIS" not in os.environ and
> @@ -411,8 +392,8 @@ def args(self, parser):
>                              help=3D"Run container using the current user=
's uid")
>=20=20
>      def run(self, args, argv):
> -        return Docker().run(argv, args.keep, quiet=3Dargs.quiet,
> -                            as_user=3Dargs.run_as_current_user)
> +        return Docker(args.command).run(argv, args.keep, quiet=3Dargs.qu=
iet,
> +                                        as_user=3Dargs.run_as_current_us=
er)
>=20=20
>=20=20
>  class BuildCommand(SubCommand):
> @@ -445,7 +426,7 @@ def run(self, args, argv):
>          dockerfile =3D _read_dockerfile(args.dockerfile)
>          tag =3D args.tag
>=20=20
> -        dkr =3D Docker()
> +        dkr =3D Docker(args.command)
>          if "--no-cache" not in argv and \
>             dkr.image_matches_dockerfile(tag, dockerfile):
>              if not args.quiet:
> @@ -512,7 +493,7 @@ def args(self, parser):
>                              help=3D"Docker registry")
>=20=20
>      def run(self, args, argv):
> -        dkr =3D Docker()
> +        dkr =3D Docker(args.command)
>          dkr.command(cmd=3D"pull", quiet=3Dargs.quiet,
>                      argv=3D["%s/%s" % (args.registry, args.tag)])
>          dkr.command(cmd=3D"tag", quiet=3Dargs.quiet,
> @@ -590,7 +571,7 @@ def run(self, args, argv):
>          tmp.seek(0)
>=20=20
>          # Run the build with our tarball context
> -        dkr =3D Docker()
> +        dkr =3D Docker(args.command)
>          dkr.update_image(args.tag, tmp, quiet=3Dargs.quiet)
>=20=20
>          return 0
> @@ -601,7 +582,7 @@ class CleanCommand(SubCommand):
>      name =3D "clean"
>=20=20
>      def run(self, args, argv):
> -        Docker().clean()
> +        Docker(args.command).clean()
>          return 0
>=20=20
>=20=20
> @@ -610,7 +591,7 @@ class ImagesCommand(SubCommand):
>      name =3D "images"
>=20=20
>      def run(self, args, argv):
> -        return Docker().command("images", argv, args.quiet)
> +        return Docker(args.command).command("images", argv, args.quiet)
>=20=20
>=20=20
>  class ProbeCommand(SubCommand):
> @@ -619,7 +600,7 @@ class ProbeCommand(SubCommand):
>=20=20
>      def run(self, args, argv):
>          try:
> -            docker =3D Docker()
> +            docker =3D Docker(args.command)
>              print(" ".join(docker._command))
>          except Exception:
>              print("no")
> @@ -651,18 +632,16 @@ def run(self, args, argv):
>                  cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]
>          cmd +=3D [args.image, args.cc]
>          cmd +=3D argv
> -        return Docker().run(cmd, False, quiet=3Dargs.quiet,
> -                            as_user=3DTrue)
> +        return Docker(args.command).run(cmd, False, quiet=3Dargs.quiet,
> +                                        as_user=3DTrue)
>=20=20
>=20=20
>  def main():
> -    global USE_ENGINE
> -
>      parser =3D argparse.ArgumentParser(description=3D"A Docker helper",
>                                       usage=3D"%s <subcommand> ..." %
>                                       os.path.basename(sys.argv[0]))
> -    parser.add_argument("--engine", type=3DEngineEnum.argparse, choices=
=3Dlist(EngineEnum),
> -                        help=3D"specify which container engine to use")
> +    parser.add_argument("--command",
> +                        help=3D"specify which container engine command t=
o use")
>      subparsers =3D parser.add_subparsers(title=3D"subcommands", help=3DN=
one)
>      for cls in SubCommand.__subclasses__():
>          cmd =3D cls()
> @@ -671,8 +650,6 @@ def main():
>          cmd.args(subp)
>          subp.set_defaults(cmdobj=3Dcmd)
>      args, argv =3D parser.parse_known_args()
> -    if args.engine:
> -        USE_ENGINE =3D args.engine
>      return args.cmdobj.run(args, argv)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

