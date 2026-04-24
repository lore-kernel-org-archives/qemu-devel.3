Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CA0FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGB7u-0007tb-6m; Fri, 24 Apr 2026 03:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGB7j-0007rW-Nb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:38:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGB7h-0001DG-P8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:38:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so4047967f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777016328; cv=none;
 d=google.com; s=arc-20240605;
 b=Hpqlno0OD8XHJTbIu48ei/KInLq660FpskWJuJBQGejD0Z/HS+OmZOqh4d4jdNDRvH
 AHVr0iSlq23uHYbcSqxGJqiU5swQOGMYjm76MVdY6j5QNhRIilcV47o3235ebNtXQVrf
 NMt3jw8n6AL5DrUB1eGj3cU6a/PgxzBpvS4oURze54bCm8/CP76bjFzK/3nfZs3+5EsE
 L5fA79kR8Ca1fabKbCgL4OjV12nbNUhVivpIPl4Svdc4JSyEE5Y0NJmTYoFpIhuiRWe/
 CqVO+yhXO/NyWPQFy9LsOGuHPA/6RACN4p8PwpFzC792q0bBE7HF68IQ/6sK4a/xtXtE
 8Fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iebPuHhRXL5sCcfhAsGqYCy/XZgrJIHTP+kOuVyYBzc=;
 fh=RXB1a1b5v5GeFvC4qgOmFEzv/tvqVbHDwvdyn65OEUw=;
 b=O6/Ei5WYZhy4QgUeEn1VW/ldp8cIW19pjOh5CflihrTRAseJEJ3p62bS2CFePqIEzV
 EFtYJU9fOzUeX0ZT6muw1m1gnCENKEdObiXyTeAE7uvQv93Hf2dW2RghXICgm+gYIWAS
 vWWwolUHf7wweN7QIdQF89TA4ZQXaU3VxCu+0UbcqMs5qvvw+IN9kY4FokyOt+VQ4RBn
 qtLct5VyUO3Wk2NTMbjvp3Y5EFAYI8OSyr57PZHX9CSmJHaGJAv3UeZ6BoOh8t1QBHvu
 5Xr8mIhtyanRIOO08Zc0u84gH0tGvopTgpXUlxI924LlrLpN4kI4hlOoA/uAwWw3J1at
 4XSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777016328; x=1777621128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iebPuHhRXL5sCcfhAsGqYCy/XZgrJIHTP+kOuVyYBzc=;
 b=DG/Jsp46GUN4EsPu3RpXZhDsfkLqGp5VLW9lKJwCy7LQoMrBVv08zI3MAWWzVbFUt1
 X9QKcUl6In3Htgy7ZM4b19kWMjymDPv93KqvRvVQ8Yaorf69vnmPxccLG9olWkbxR+yS
 72xA+kJ8+cICiGk/zBnfyRY8WpEjCjQMOdFKWv+8tmW7v/EQBh1+EFFljG/HKTeJAMwT
 sEzKD0EpUOEJYC/suxlJg2DEruEXCqcuJ/IxNS8pU7cmVaTghLM1CEZfdBssu0TGLJ5C
 soTCj+NdSm9qkyAHn408thOGgNvX4FNqJIb6Eq5Sq0nbwPydH2ABPmDka3m8/fpa5pVW
 xvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016328; x=1777621128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iebPuHhRXL5sCcfhAsGqYCy/XZgrJIHTP+kOuVyYBzc=;
 b=pdcyTAZA0+OSJGEg88pqLxL0GbZ8iSIe3qtipE0kc3nIckSHzAixTZyIzOMjuCRKZQ
 0Va7/y4XpaoYrVK8eGMcQPMw19aCVdemik70EUGteRbHxtO4Xv2r831rqPLcNt4B4dEb
 bSIUsbKArL1+wQuoD/3/RebQ1ROVbzPOnJh5Z2/LYZSjxoVnK9ZpDgqw7kth/4nT/unm
 efJFGfY/umep415kroTUo+CYiIsL0IMovUrU01kU8cOj97nI/Ilg026ys9a/Tb8Fk9iw
 KDY6FTD47aDbsAyhPNv0Jic533IpF+bI/4eO1OO2YCvE+1bdujV0GAEdXLHNIkt7juYz
 wpCA==
X-Gm-Message-State: AOJu0YyF1h8Qxi/z9ilLjzri8krYK4sY6+/HHC7YTNwUcVL751Jtf96/
 ekMzmSHnctJ8iRABIbE0Iqw+EtTncWzAiL16LIMc+yNyuxLtB0Lvb72GvxvbLuQm+KK4qGIub+W
 kvyGBVeqU0aAM8G0ihuQ+PFRxE+7SjGYkNwJQ/wdYtw==
X-Gm-Gg: AeBDietuipghL8aGuyJg732XksejKrA1cX7dMgtqjU39eFlElnkzg8SPElY8mPZh0AN
 T6rgU3Gqqgk8++aCEBouVPyavvcrSlGRu/AD1IEhjollIpkXE8z3USKvXc7eVwsUnyP2Am9vVip
 x9ti2yZ2g4bOsTCnWfJviNTtlm0Vy/5u6idnpgLva/yCFo0z0aiVxbD0t+PfeVUl33X009KuDZB
 wVhEOkP/Glwo/Gu4w137fXO+0nlwvvpNJlpwNpHV8dcsaeH8Rt9eSvYcH/Eo/gf/cIC97dCQrup
 ssLMImJH3jj3sax4HPUXQi9gSGLFzm0cunLBPOvtnwxqqzoNLAOE4lByd+U1
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id
 ffacd0b85a97d-43fe3e236c2mr46481284f8f.43.1777016327594; Fri, 24 Apr 2026
 00:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260317174845.31768-1-lucaaamaral@gmail.com>
In-Reply-To: <20260317174845.31768-1-lucaaamaral@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 24 Apr 2026 10:38:21 +0300
X-Gm-Features: AQROBzDKzobipnk_P47dSYupdE1fi9miSCt-6llUWbdYTtPgrSLQVyM_Yh0U9bA
Message-ID: <CAAjaMXa4yye0PQVGXN7SMgHeYC2kuYChJ_ZCnfepExMFGqfH1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 peter.maydell@linaro.org, mohamed@unpredictable.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 17, 2026 at 7:50=E2=80=AFPM Lucas Amaral <lucaaamaral@gmail.com=
> wrote:
>
> Fix a bug in the MAP_FIXED blob mapping path (introduced by 4eb0aace)
> where non-host-page-aligned offsets cause mmap(MAP_FIXED) to fail with
> EINVAL.  This affects any host where the page size exceeds the guest's
> (ARM64 with 16KB/64KB pages, macOS ARM64).

FYI VIRTIO 1.4 has a VIRTIO_GPU_F_BLOB_ALIGNMENT feature that allows
the device to expose the necessary host alignment in a configuration
space.

>
> This series introduces:
>
> 1. MAP_FIXED alignment validation in virtio-gpu: check that both
>    offset and blob size are aligned to the host page size before
>    calling virgl_renderer_resource_map_fixed().  When not aligned,
>    fall through to the subregion method (which works at any
>    alignment).
>
> 2. A map granule abstraction (hvf_set/get_map_granule) replacing
>    hardcoded qemu_real_host_page_size() calls in HVF memory mapping.
>    Non-aligned regions return early instead of proceeding with
>    add=3Dfalse (which attempted an unnecessary unmap).
>    An 'ipa-granule' property (auto, 4k, 16k) on the HVF accelerator
>    object allows opt-in configuration:
>
>      -accel hvf,ipa-granule=3D4k
>
>    The property follows the kvm_arch_accel_class_init() pattern:
>    ARM registers the property in hvf_arch_accel_class_init(), x86
>    provides an empty stub.
>
> 3. macOS 26 IPA granule support via hv_vm_config_set_ipa_granule(),
>    reading the ipa-granule property to select HV_IPA_GRANULE_4KB or
>    HV_IPA_GRANULE_16KB.  Falls back with a warning on macOS < 26.
>
> Dependencies: none.
>
> Changes v3 -> v4:
>   - Rebased onto current master (no code changes)
>   - Resent as new top-level thread per Alex Benn=C3=A9e's feedback
>
> Changes v2 -> v3:
>   - Rebased on current master
>   - Add MAP_FIXED alignment validation (new patch 1)
>   - Move #ifdef __aarch64__ property code into hvf_arch_accel_class_init
>     following kvm_arch_accel_class_init() pattern (x86 empty stub)
>   - Use MAC_OS_VERSION_26_0 named constant
>   - Remove Venus blob mapping warning
>
> Changes v1 -> v2 (Mohamed Mosaad review):
>   - Replace hardcoded 4KB with configurable ipa-granule property
>     (auto, 4k, 16k) on the HVF accelerator object.
>   - 'auto' defaults to host page size; explicit values opt in.
>   - Add fallback warning when macOS < 26 can't honor the request.
>   - Add Venus blob mapping safety warning.
>   - Use KiB constants instead of magic numbers.
>
> Lucas Amaral (3):
>   virtio-gpu: validate host page alignment for MAP_FIXED blobs
>   accel/hvf: introduce map granule abstraction and IPA property
>   target/arm/hvf: configure IPA granule on macOS 26
>
>  accel/hvf/hvf-all.c           | 30 +++++++++++++--
>  hw/display/virtio-gpu-virgl.c | 45 +++++++++++++---------
>  include/system/hvf.h          | 15 ++++++++
>  include/system/hvf_int.h      |  2 +
>  target/arm/hvf/hvf.c          | 72 +++++++++++++++++++++++++++++++++++
>  target/i386/hvf/hvf.c         |  4 ++
>  6 files changed, 147 insertions(+), 21 deletions(-)
>
> --
> 2.52.0
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

