Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF59CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUTju-0002Z3-RR; Tue, 02 Jun 2026 14:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wUTjq-0002XL-IQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:21:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wUTjn-0002OK-Qe
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:21:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso570467b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 11:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424474; cv=none;
 d=google.com; s=arc-20240605;
 b=KLs0crxAX1a+LJmB1hB2xihgvsA/1Z+7u5K3CCf3D7C/IDA3z8O2aVVj4zN8JNJxOa
 7sBSOMIt+fhIFV4Cy88A/mrZGfgngqE8NMxu4oiUbRqbthbQMZCTiNcmotwl+CH84ZlW
 JUazLgGl8RqkzK8+aaKyn77yH7nLkiLjA8FgevL1XrVPuD9WLbGpyz5eVZSZrKVKBtCf
 imzh3p/DOcwI4kKx2ZqVYrI+G6UF0JG/KyfjCp0V0h3uUIzGRFr4Dt1E3WAw/VYdnWWm
 et9Bepw90fhBTdFnYPw11Rtx/CdxCs52yxyO38o4yYScpjCrBHepzxYZYjOi5g/+uRks
 lHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=382uSj38z8GQqNk9OpYuTEDIXjXQTVJ6IwNFuZO08VI=;
 fh=UJHGz5Bqv9TXg4CfWcRzGmrP6GGdI6iJit9KQITBKh8=;
 b=Nd4yok0bENj3GsqjglkpV459t0splzY4wGI9KdZGJ8zS5kv/nfgHUPUERORqOnV+Od
 yDxkVU0oHoNioeReSm0b/o/Bv388DiSGA2XVkvq/zUHKK6oijalZT6D2DBUmqRQ1aAdD
 xeH/3lAca9LRR3Xll0ss1unbuCpaiSP4I7kOvO7huu9FhxQtkKgtPDk9iAGRB9xHmzj8
 CgkYY7awcYlMeVG+HUbouLpxQSI6Lc/INtM5KEuHu8tuE7t5eqWjjSUeyEuztBV7OPW9
 SEFKDYqY9eXjuyjUcYl/Uex0EeCY/yhXICwpXYM1950EkgHrr8FIeuSMx83ez0zQ6MLu
 02xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780424474; x=1781029274;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=382uSj38z8GQqNk9OpYuTEDIXjXQTVJ6IwNFuZO08VI=;
 b=zt5Qp0EloHjf0cciPib2nrvMid2i0Ma/mohdjQQhmwUjZAcrzan2bvHEZ4ShP91KAA
 iz/+3sIRK1srv7Gnwq+GlGLimaG9OrJau1syiXih/zjGxEYU7SarQSC2ZFF+v1iikw+U
 YLDE8EIaQUVUMQ8jmKO+qAdhlhsqp8febizxNQ1kQ/LfQ8q0ARgFkSaaM39hFtDHBzbm
 VgxOMAx+VEAvA4XaEuO7GlGOgvlhaAWlGwcjGYC2mHZ8VJa5GlHd9jezIlISQR9u7JlL
 DJO5RdgvS4LQl33mRIBskVY8x+I+751yGFffaITqK9ahzCHBjlOVlOndErtgwzsKyzM5
 KNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424474; x=1781029274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=382uSj38z8GQqNk9OpYuTEDIXjXQTVJ6IwNFuZO08VI=;
 b=fI/BiW4UhwQHzbBPbf/fOhm0IMBpemjSIh/4o7ueaW93ruqVJlN2zGTdGTfnPsO6fx
 kzfpeFQ6cfOiLJ5TcUZyM3FXyDGSKRn14GiX6qfG/m1WSjP4V5LmuNnfONAPzbTSz/DC
 2HMpoGBWMOI92/9Q4w91D6PDeWKvyj2x/b1WnpnYGjxqC8R5jSWJuvUTPaHxQuS18IbA
 lBK/2v7JJTBoCF2ZudiZE9C7+K6JzDh9FpXgKCC46rFqZy2/M+tlWNsAJCg56+jBcgSZ
 55EcbqcgIkYHTLNayOpO8I1GHeztAspPrfSMAWPxWKfnQeoKIZuXnVDFSnvg4XVN3MVw
 1mKw==
X-Gm-Message-State: AOJu0Yw2j0z781cqjtiHeF3b/ETdnssX6ImaLBBpLT++ZpUp2DmxiCyI
 INBFwDCmL8NK2+HrWkxmHJXRzKitPay1eeqkHRM0xpUp1szikFpPXipGZU79mI3XHgzdEiYK8bb
 DPXSE48+IhXL/R4x7fX73EsKFzTzxuvQKhNfWzWn2zA==
X-Gm-Gg: Acq92OEqrlV/iw5/ctglejUCz03TRLK357K2v42hFBHQB/CJzuAmdWsJrZg9DZECPOx
 7/I2dCu/QNSG6378zd1iXDEaXiV34767+D2dazKUXjf5K3ELyJzWdO0CPMMyFf+3fJ+fykyo67n
 pXO9rpS2jY3WOBFp9L4kQ87hIVOSYS6dg/t541rPZDzy+WfTfLOJBs0CisR+fq/VFmY3hKGicUt
 dqGXbGL08s/OD5PBnidl2o0CWQ3CO4iQiInO06YbTEVpFwd1KXJmdQwfnTpgnjxVeF85L9JWOtt
 D+xi2E7CbeylOEmEmEpPtIAcXQ7yLw==
X-Received: by 2002:a05:6a21:9146:b0:38e:92f6:9ab1 with SMTP id
 adf61e73a8af0-3b4958711d2mr311524637.22.1780424473701; Tue, 02 Jun 2026
 11:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-2-stefanha@redhat.com>
In-Reply-To: <20260602162457.828969-2-stefanha@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Jun 2026 11:21:02 -0700
X-Gm-Features: AVHnY4JKa0lhq_cCMg4a2OiPreBiq4sixxPt9nqFslFYl3Xhl2HhEGKNU5hYQnc
Message-ID: <CANCZdfpZRAe8-GTVYacgYJNKPE_Tpy+ZaME68XeX-4LQeAaAxQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gitlab: remove x64-freebsd-14-build Cirrus job
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000004e01810653496037"
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004e01810653496037
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:25=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> Cirrus has shut down and the x64-freebsd-14-build is failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/14656732122
>
> Remove the x64-freebsd-14-build job to get the CI pipeline passing
> again. The next commit will be to remove Cirrus integration from the
> GitLab YAML and lcitool since it is no longer used.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS                         |  2 --
>  .gitlab-ci.d/cirrus.yml             | 14 --------------
>  .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------
>  tests/lcitool/refresh               |  5 -----
>  4 files changed, 37 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars
>

Reviewed-by: Warner Losh <imp@bsdimp.com>



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7752917d8c..4ff33eb630 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4511,9 +4511,7 @@ W: https://travis-ci.org/qemu/qemu
>  FreeBSD Hosted Continuous Integration
>  M: Li-Wen Hsu <lwhsu@freebsd.org>
>  S: Maintained
> -F: .gitlab-ci.d/cirrus/freebsd*
>  F: tests/vm/freebsd
> -W: https://cirrus-ci.com/github/qemu/qemu
>
>  Functional testing framework
>  M: Thomas Huth <th.huth+qemu@posteo.eu>
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index b71ab090b6..4769d00c67 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -30,17 +30,3 @@
>      - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.ym=
l
>    variables:
>      QEMU_JOB_CIRRUS: 1
> -
> -x64-freebsd-14-build:
> -  extends: .cirrus_build_job
> -  variables:
> -    NAME: freebsd-14
> -    CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
> -    CIRRUS_VM_IMAGE_SELECTOR: image_family
> -    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
> -    CIRRUS_VM_CPUS: 8
> -    CIRRUS_VM_RAM: 8G
> -    UPDATE_COMMAND: pkg update; pkg upgrade -y
> -    INSTALL_COMMAND: pkg install -y
> -    CONFIGURE_ARGS:
> --target-list-exclude=3Darm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-=
softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
> --enable-rust
> -    TEST_TARGETS: check
> diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars
> b/.gitlab-ci.d/cirrus/freebsd-14.vars
> deleted file mode 100644
> index 98fbde6cc6..0000000000
> --- a/.gitlab-ci.d/cirrus/freebsd-14.vars
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -# THIS FILE WAS AUTO-GENERATED
> -#
> -#  $ lcitool variables freebsd-14 qemu
> -#
> -# https://gitlab.com/libvirt/libvirt-ci
> -
> -CCACHE=3D'/usr/local/bin/ccache'
> -CPAN_PKGS=3D''
> -CROSS_PKGS=3D''
> -MAKE=3D'/usr/local/bin/gmake'
> -NINJA=3D'/usr/local/bin/ninja'
> -PACKAGING_COMMAND=3D'pkg'
> -PIP3=3D'/usr/local/bin/pip'
> -PKGS=3D'alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka
> coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3
> gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi
> libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1
> llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png
> py311-numpy py311-pillow py311-pip py311-pyyaml py311-setuptools
> py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-wheel python3
> rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat
> spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso
> zstd'
> -PYPI_PKGS=3D''
> -PYTHON=3D'/usr/local/bin/python3'
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 96ee861cbf..e903a33f7a 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -303,11 +303,6 @@ try:
>                          enable_rust=3DFalse,
>                          trailer=3D"".join(debian_all_test_cross_compiler=
s))
>
> -    #
> -    # Cirrus packages lists for GitLab
> -    #
> -    generate_cirrus("freebsd-14")
> -
>      #
>      # GitLab packages lists
>      #
> --
> 2.54.0
>
>

--0000000000004e01810653496037
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 2, =
2026 at 9:25=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redh=
at.com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Cirrus has shut down and the x64-freebsd-14-buil=
d is failing:<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/14656732122" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/jobs/1=
4656732122</a><br>
<br>
Remove the x64-freebsd-14-build job to get the CI pipeline passing<br>
again. The next commit will be to remove Cirrus integration from the<br>
GitLab YAML and lcitool since it is no longer used.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 --<br>
=C2=A0.gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 14 --------------<br>
=C2=A0.gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------<br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 5 -----<br>
=C2=A04 files changed, 37 deletions(-)<br>
=C2=A0delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars<br></blockquot=
e><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bs=
dimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 7752917d8c..4ff33eb630 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -4511,9 +4511,7 @@ W: <a href=3D"https://travis-ci.org/qemu/qemu" rel=3D=
"noreferrer" target=3D"_blank">https://travis-ci.org/qemu/qemu</a><br>
=C2=A0FreeBSD Hosted Continuous Integration<br>
=C2=A0M: Li-Wen Hsu &lt;<a href=3D"mailto:lwhsu@freebsd.org" target=3D"_bla=
nk">lwhsu@freebsd.org</a>&gt;<br>
=C2=A0S: Maintained<br>
-F: .gitlab-ci.d/cirrus/freebsd*<br>
=C2=A0F: tests/vm/freebsd<br>
-W: <a href=3D"https://cirrus-ci.com/github/qemu/qemu" rel=3D"noreferrer" t=
arget=3D"_blank">https://cirrus-ci.com/github/qemu/qemu</a><br>
<br>
=C2=A0Functional testing framework<br>
=C2=A0M: Thomas Huth &lt;<a href=3D"mailto:th.huth%2Bqemu@posteo.eu" target=
=3D"_blank">th.huth+qemu@posteo.eu</a>&gt;<br>
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml<br>
index b71ab090b6..4769d00c67 100644<br>
--- a/.gitlab-ci.d/cirrus.yml<br>
+++ b/.gitlab-ci.d/cirrus.yml<br>
@@ -30,17 +30,3 @@<br>
=C2=A0 =C2=A0 =C2=A0- cirrus-run -v --show-build-log always .gitlab-ci.d/ci=
rrus/$NAME.yml<br>
=C2=A0 =C2=A0variables:<br>
=C2=A0 =C2=A0 =C2=A0QEMU_JOB_CIRRUS: 1<br>
-<br>
-x64-freebsd-14-build:<br>
-=C2=A0 extends: .cirrus_build_job<br>
-=C2=A0 variables:<br>
-=C2=A0 =C2=A0 NAME: freebsd-14<br>
-=C2=A0 =C2=A0 CIRRUS_VM_INSTANCE_TYPE: freebsd_instance<br>
-=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_SELECTOR: image_family<br>
-=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_NAME: freebsd-14-3<br>
-=C2=A0 =C2=A0 CIRRUS_VM_CPUS: 8<br>
-=C2=A0 =C2=A0 CIRRUS_VM_RAM: 8G<br>
-=C2=A0 =C2=A0 UPDATE_COMMAND: pkg update; pkg upgrade -y<br>
-=C2=A0 =C2=A0 INSTALL_COMMAND: pkg install -y<br>
-=C2=A0 =C2=A0 CONFIGURE_ARGS: --target-list-exclude=3Darm-softmmu,i386-sof=
tmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu=
,xtensa-softmmu --enable-rust<br>
-=C2=A0 =C2=A0 TEST_TARGETS: check<br>
diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/free=
bsd-14.vars<br>
deleted file mode 100644<br>
index 98fbde6cc6..0000000000<br>
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars<br>
+++ /dev/null<br>
@@ -1,16 +0,0 @@<br>
-# THIS FILE WAS AUTO-GENERATED<br>
-#<br>
-#=C2=A0 $ lcitool variables freebsd-14 qemu<br>
-#<br>
-# <a href=3D"https://gitlab.com/libvirt/libvirt-ci" rel=3D"noreferrer" tar=
get=3D"_blank">https://gitlab.com/libvirt/libvirt-ci</a><br>
-<br>
-CCACHE=3D&#39;/usr/local/bin/ccache&#39;<br>
-CPAN_PKGS=3D&#39;&#39;<br>
-CROSS_PKGS=3D&#39;&#39;<br>
-MAKE=3D&#39;/usr/local/bin/gmake&#39;<br>
-NINJA=3D&#39;/usr/local/bin/ninja&#39;<br>
-PACKAGING_COMMAND=3D&#39;pkg&#39;<br>
-PIP3=3D&#39;/usr/local/bin/pip&#39;<br>
-PKGS=3D&#39;alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka=
 coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gette=
xt git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt=
 libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 me=
son mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311=
-pillow py311-pip py311-pyyaml py311-setuptools py311-sphinx py311-sphinx_r=
td_theme py311-tomli py311-wheel python3 rpm2cpio rust rust-bindgen-cli sdl=
2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrend=
erer vte3 vulkan-tools xorriso zstd&#39;<br>
-PYPI_PKGS=3D&#39;&#39;<br>
-PYTHON=3D&#39;/usr/local/bin/python3&#39;<br>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
index 96ee861cbf..e903a33f7a 100755<br>
--- a/tests/lcitool/refresh<br>
+++ b/tests/lcitool/refresh<br>
@@ -303,11 +303,6 @@ try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0enable_rust=3DFalse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0trailer=3D&quot;&quot;.join(debian_all_test_cross_compiler=
s))<br>
<br>
-=C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 # Cirrus packages lists for GitLab<br>
-=C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 generate_cirrus(&quot;freebsd-14&quot;)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# GitLab packages lists<br>
=C2=A0 =C2=A0 =C2=A0#<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div></div>

--0000000000004e01810653496037--

