Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FB2CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4pF-0005N8-V5; Wed, 14 Oct 2026 15:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xH4pB-0005Lh-7T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xH4p8-0001Cb-Ul
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792006775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwkiY6WMEbShWO1TnK4W8ILc2Jk/Cj0j9CNwlzGBgfI=;
 b=iKdU0qw3ZXqgtg+IZ9aKJvLswaejZwSRrCVYKwQY+28Bc1E4U0hJx7U6AD/LLMrYAjqRwx
 m6jdYPRUsAE1YzH7W4cS1TaAQDSiyUSr0LpMcdhLeeZEbpXDphAKhMjL4PmSaCeWWIltGR
 1LvsSODaYjb1GVQFdlQtFtXvUJxDO4A=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-xaP46k2tP2qKEtnYU0rzPw-1; Wed, 14 Oct 2026 19:39:33 +0000
X-MC-Unique: xaP46k2tP2qKEtnYU0rzPw-1
X-Mimecast-MFC-AGG-ID: xaP46k2tP2qKEtnYU0rzPw_1792006773
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6768c955661so778230d50.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792006773; cv=none;
 d=google.com; s=arc-20260327;
 b=d2puAOqcZ+UBKzTlSQ9fG29nMl2rZS4+j4KyshAwuteqUWdu3xQNiiI0Y+CcPERZ0H
 ufQG4rmmc0umy4XF+Gp+QOIeJU63JRzLjp0X0XIilKrd7PCJJhSppLfPTxoorAgpl24V
 AlgiEDXVsnJ9qJXer+2ObtGiJjHXoVaKUSAJEVDLTtf69qx34bWt0fXTWXkB0c9xdun7
 a6M1gtWYeqC9d8qzp3ltMt+vuihVgnFNaPCJd80O8HxsGku+AIskpumzQld957qPjTfZ
 3nuUXjoc6pvAUqI0ZqF1d0gfLe9XsjtiKDBh26HlZSvW9v3I9x0vyB0eKGtc4nHvXF7+
 3Cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cwkiY6WMEbShWO1TnK4W8ILc2Jk/Cj0j9CNwlzGBgfI=;
 fh=M78RKnuLsToPHEp38OzcbpAzEg2tTR935dYQQKMo1aM=;
 b=dghTucxTQnxXf6xlxkkVgdCGbnvKfds6dmFRVONEcld4pYUWB75mZN5apyY5r9SIOf
 xmvit/ogXPVBXLOiJ6AENHdbliSmRdfgs5W/qyA7GT4+UtOFbICHxQ0KB7qpqJvlw/iO
 83JG2bDJSJxllvZRijJP4ePHPb5h++Z123GGVJTDlpuuVUB84G9gnwsMgeij0VkQc6K7
 D/9W6zibNwXqMZ0g/HvjK+WCc7RWKJJGS0ilQrNR4+sPVzjLcU6VDLYmB9Bz0+ytbBcS
 5snNePVkyayFzFsRNCCPWu+0OOMG35fhXI+iWuULU7/60CGGhtmmaivfwYugRPtubDd/
 zyOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792006773; x=1792611573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cwkiY6WMEbShWO1TnK4W8ILc2Jk/Cj0j9CNwlzGBgfI=;
 b=MN36Wk3KTB+ZdHz/N2zdFhlAJDVgQ0to4WKavwW9N5bTAMFr0BV5yyjgqxUrqSS9nA
 bReZJXFLwOil8iEtJQIgVKg0+njDwLeYgmB/3gjLFiQAptC10FZt6IxUH+l133MxhIKC
 OvZ1zkPNDZWz/72+qpiy35tFuzYIcRFdqeP726tPhjVzInSFEVil6YwpUyX2jARPu1ij
 K+PdgzX28BjXcnPL86ONcEc+TQd+HNT1Waji2O6Xm27jhTY2marNXFMXl0iSDxiz8UPT
 YswUSlmk+U/CHhf1j3rD1OytSu7vI9IqXdQL8b5QflI6NyZ3/GyzrI7g6pdgVinUoHqn
 51RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006773; x=1792611573;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwkiY6WMEbShWO1TnK4W8ILc2Jk/Cj0j9CNwlzGBgfI=;
 b=gpKBzyPuOvSwQKT/NAKLzmIoa0+heGNVKp9QGEehZDPk/2i5cMsmt4S5ejsQpwejjn
 69K5S39FTf5vp+dSbzwzAiXuAVgxPnmswCMqdYkjf52s3ISiCzKGM+d9/zI47qPF72J6
 vTmfHwMj4mReDkkH8jLgUwUun+FMBf9nTsr0PpCnea6IwmK5ihnGPUYzVQgIFrgbE+h2
 8DuOrBFiYM1b+GM3VsWGs16oR0/WyzaPSQjW2TFpLhbxN2V/goJLpMg9AqJMkmXUoq4G
 57cxPwFa+GCLsNJMA0lQ36TjoBgXr1RvGLg8NBGeNIsBfGaC+7dlhY+y2Czhi0x9n1uK
 9uOw==
X-Gm-Message-State: AFq9FYKZtpuNlir1EUaN9xdkOekLBt4aA3BTY+6jUFXjToFxfhOegX8M
 +aypv3P468vxmN7jK7Ogl+5UEDSdquI8pzb/AlcNdceHYVg7oM1UlmCbfn9Z8Dtu/7Hv5lzwgYS
 4eZXOrT/Jq5uETRYUoAenl1ArUTts9PkJEhH+SX6PAEholJ0+RnHWniWmdt5KktM8Rtp/lWALz3
 QsB74f5BFSjAv6Ks3Uf22YaqAqJGEG3PQ=
X-Gm-Gg: AYBFou3jXBSGA9N5rJk0qBHQJzEdX7z5/Mv+tKCaORiO8vi4C14pH/r/4z5SVp5BfS1
 ppjxpJ5/DDl6vUqnMbbfmkvqgQB1G2WNyEVGH7XRkgNo/orotjIzA5WOTmYkyTdirl3/qzFPTFy
 2/fMC77OolZtZsfWjxmeAbfFPpOCW4xN7qZ6B+yvJo3LNVCQDhg5H4tGmK3/FguGIQ0xEfKk+VR
 tVoCJ/o9y0ShgOv
X-Received: by 2002:a05:690e:169c:b0:66f:c1be:a662 with SMTP id
 956f58d0204a3-67936306108mr8273287d50.84.1792006772813; 
 Wed, 14 Oct 2026 12:39:32 -0700 (PDT)
X-Received: by 2002:a05:690e:169c:b0:66f:c1be:a662 with SMTP id
 956f58d0204a3-67936306108mr8273265d50.84.1792006772019; Wed, 14 Oct 2026
 12:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-typos-in-docs-v1-1-75f2e1cd888e@gmail.com>
In-Reply-To: <20261012-typos-in-docs-v1-1-75f2e1cd888e@gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 14 Oct 2026 15:39:20 -0400
X-Gm-Features: AclHuK_gCY0P5ZIgvhVwAWfrkzLxLRMQ2TAFRnFsArcYb3yx-12wgsFXjMHYE3A
Message-ID: <CAFn=p-bG9u1YJTQ7whAC0NohZXv=7Rx+gQwV-qWOz44VkrTZGA@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] docs: fix a few typos
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 12, 2026 at 12:34=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.c=
om> wrote:
>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

LGTM

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

> ---
>  docs/devel/clocks.rst                 | 2 +-
>  docs/devel/control-flow-integrity.rst | 2 +-
>  docs/devel/docs.rst                   | 2 +-
>  docs/devel/ebpf_rss.rst               | 2 +-
>  docs/devel/multi-process.rst          | 6 +++---
>  docs/devel/submitting-a-patch.rst     | 2 +-
>  docs/interop/vfio-user.rst            | 2 +-
>  docs/specs/ppc-spapr-hcalls.rst       | 2 +-
>  docs/specs/ppc-spapr-xive.rst         | 2 +-
>  docs/system/security.rst              | 2 +-
>  docs/user/main.rst                    | 2 +-
>  11 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> index 16de32147b..997b09c6a4 100644
> --- a/docs/devel/clocks.rst
> +++ b/docs/devel/clocks.rst
> @@ -280,7 +280,7 @@ so you can use this to model clock controller devices=
 which
>  have guest-programmable frequency multipliers or dividers.
>
>  Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` i=
f
> -the clock state was modified; that is, if the multiplier or the diviser
> +the clock state was modified; that is, if the multiplier or the divisor
>  or both were changed by the call.
>
>  Note that ``clock_set_mul_div()`` does not automatically call
> diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-f=
low-integrity.rst
> index 3d5702fa4c..466888bdf1 100644
> --- a/docs/devel/control-flow-integrity.rst
> +++ b/docs/devel/control-flow-integrity.rst
> @@ -39,7 +39,7 @@ are planning to also enable fuzzing, then Clang 11+ is =
needed (more on this
>  later).
>
>  Given the use of LTO, a version of AR that supports LLVM IR is required.
> -The easies way of doing this is by selecting the AR provided by LLVM::
> +The easiest way of doing this is by selecting the AR provided by LLVM::
>
>   AR=3Dllvm-ar-9 CC=3Dclang-9 CXX=3Dclang++-9 /path/to/configure --enable=
-cfi
>
> diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
> index a7768b5311..7fe7e44429 100644
> --- a/docs/devel/docs.rst
> +++ b/docs/devel/docs.rst
> @@ -5,7 +5,7 @@ QEMU Documentation
>
>  QEMU's documentation is written in reStructuredText format and
>  built using the Sphinx documentation generator. We generate both
> -the HTML manual and the manpages from the some documentation sources.
> +the HTML manual and the manpages from the same documentation sources.
>
>  hxtool and .hx files
>  --------------------
> diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
> index ed5d33767b..85ef547623 100644
> --- a/docs/devel/ebpf_rss.rst
> +++ b/docs/devel/ebpf_rss.rst
> @@ -31,7 +31,7 @@ Not for all packets, the hash can/should be calculated.
>
>  Note: currently, eBPF RSS does not support hash reporting.
>
> -eBPF RSS turned on by different combinations of vhost-net, vitrio-net an=
d tap configurations:
> +eBPF RSS turned on by different combinations of vhost-net, virtio-net an=
d tap configurations:
>
>  - eBPF is used:
>
> diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
> index 4ef539c0b0..cafe2aaba7 100644
> --- a/docs/devel/multi-process.rst
> +++ b/docs/devel/multi-process.rst
> @@ -158,7 +158,7 @@ IOMMUs introduce another level of complexity, since t=
he address given to
>  the guest virtio device to DMA to or from is not a guest physical
>  address. This case is handled by having vhost code within QEMU register
>  as a listener for IOMMU mapping changes. The vhost application maintains
> -a cache of IOMMMU translations: sending translation requests back to
> +a cache of IOMMU translations: sending translation requests back to
>  QEMU on cache misses, and in turn receiving flush requests from QEMU
>  when mappings are purged.
>
> @@ -573,7 +573,7 @@ live migration
>  When a remote process receives a live migration indication from QEMU, it
>  will set up a channel using the received file descriptor with
>  ``qio_channel_socket_new_fd()``. This channel will be used to create a
> -*QEMUfile* that can be passed to ``qemu_save_device_state()`` to send
> +*QEMUFile* that can be passed to ``qemu_save_device_state()`` to send
>  the process's device state back to QEMU. This method will be reversed on
>  restore - the channel will be passed to ``qemu_loadvm_state()`` to
>  restore the device state.
> @@ -853,7 +853,7 @@ intx irq descriptor
>
>  The irq descriptors are created by the proxy object
>  ``using event_notifier_init()`` to create the irq and re-sampling
> -*eventds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt.
> +*eventfds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt=
.
>  The interrupt route can be found with
>  ``pci_device_route_intx_to_irq()``.
>
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-=
patch.rst
> index 5ccd09a397..cd08881dfb 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -241,7 +241,7 @@ Use B4
>  ~~~~~~
>
>  The `b4`_ tool, used for Linux kernel development, can also be used for =
QEMU
> -development. It is packaged in most distros and PyPi. The QEMU source tr=
ee
> +development. It is packaged in most distros and PyPI. The QEMU source tr=
ee
>  includes a ``b4`` project configuration file at the root: ``.b4-config``=
.
>
>  Example workflow to prepare a patch series:
> diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
> index 1c92f442d2..3428241dae 100644
> --- a/docs/interop/vfio-user.rst
> +++ b/docs/interop/vfio-user.rst
> @@ -1505,7 +1505,7 @@ Neither the request or reply have a payload.
>  --------------------------------
>
>  This message can be used to coalesce multiple device write operations
> -into a single messgage.  It is only used as an optimization when the
> +into a single message.  It is only used as an optimization when the
>  outgoing message queue is relatively full.
>
>  Request
> diff --git a/docs/specs/ppc-spapr-hcalls.rst b/docs/specs/ppc-spapr-hcall=
s.rst
> index 6cdcef2026..550026ea55 100644
> --- a/docs/specs/ppc-spapr-hcalls.rst
> +++ b/docs/specs/ppc-spapr-hcalls.rst
> @@ -20,7 +20,7 @@ to an implementation specific range in PAPR.
>  ``H_RTAS (0xf000)``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -RTAS stands for Run-Time Abstraction Sercies and is a set of runtime ser=
vices
> +RTAS stands for Run-Time Abstraction Services and is a set of runtime se=
rvices
>  generally provided by the firmware inside the guest to the operating sys=
tem. It
>  predates the existence of hypervisors (it was originally an extension to=
 Open
>  Firmware) and is still used by PAPR and LoPAR to provide various service=
s that
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rs=
t
> index f47f739e01..8b83942a29 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -171,7 +171,7 @@ native exploitation mode* is selected should contain:
>  - ``reg``
>
>    contains the base address and size of the thread interrupt
> -  managnement areas (TIMA), for the User level and for the Guest OS
> +  management areas (TIMA), for the User level and for the Guest OS
>    level. Only the Guest OS level is taken into account today.
>
>  - ``ibm,xive-eq-sizes``
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 75e39caede..1bd8423866 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -107,7 +107,7 @@ an issue as a normal bug.
>    possibility of large memory peaks and apply countermeasures to
>    provide continuity of host operations. It is typical for the Linux
>    OOM killer to reap the process triggering host memory overcommit
> -  in the case of exccessive usage, offering a degree of protection.
> +  in the case of excessive usage, offering a degree of protection.
>    As such, bugs which can lead to excessive/unbounded memory allocations
>    will usually not be classified as security flaws, but should be
>    fixed as hardening bugs.
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index a8ddf91424..aef33bfd9a 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -23,7 +23,7 @@ System call translation
>  System calls are the principle interface between user-space and the
>  kernel. Generally the same system calls exist on all versions of the
>  kernel so QEMU includes a generic system call translator. The
> -translator takes care of adjusting endianess, 32/64 bit parameter size
> +translator takes care of adjusting endianness, 32/64 bit parameter size
>  and then calling the equivalent host system call.
>
>  QEMU can also adjust device specific ``ioctl()`` calls in a similar
>
> ---
> base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b
> change-id: 20261006-typos-in-docs-36cfdbbe52d3
>
> Best regards,
> --
> Filip Hejsek <filip.hejsek@gmail.com>
>


