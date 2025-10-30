Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F80CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWw3-0006CF-S9; Thu, 30 Oct 2025 13:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEWw0-0006Bk-B7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:59:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEWvq-0006KG-Ux
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:59:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so1534886f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761847161; x=1762451961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YJiafowLr1nciQHG7oZHuGbx0cNEUbbZ5g/s5gWKCE=;
 b=egRUeSoO2aoVF0D5NX/W3mPDGpJPX2uk5T4TjGYrcQdMK95n+fLk37lejmK4pFiDJp
 IPQkmpwUfJG0NQynYw3jY/QeJcztNELesR3xCE0p5cU/Z0VZkiiLuuTz1r8L04rXCpEr
 oGU5NOARuxc0FU4/6ar8ASY4d3Z+KycH26zsVZaavyBbFqeOLwG7f33EFg4XalhwmXR8
 rn6ScJEBWv7OhaHFqbg3jJ/wF4Mq4esIcowAfxDSoxBedGWvdTM4P3Ng4lSLhLza5d3h
 GbNN4RwtZYpnQvIkVdV3yo3zr4FJQzJRJCy1yAe8NNne6jjL8KDeQmHDHiN2MEkGrSZk
 EOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761847161; x=1762451961;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4YJiafowLr1nciQHG7oZHuGbx0cNEUbbZ5g/s5gWKCE=;
 b=JdjdOqM8uPKM2zVKi+mjQM83bIspsfqPLxR6+vCxF5SpbjTuWg6Pkcp4cJkncVseoo
 TNwPH7GV/mBf2Xk+73E5KMdNgzDPWb8QL25V/9JJpyFEKQt0k4QD+u6Pp46Fz6rGdxIN
 5lu7CpHuBVrmA0YR51PQ6i0qQXNv2T/DurzPqG0A3zLp3/wGaNfwIKdfst9uDVw3CVhs
 ZYNsKXgxfMNyeNbc7kAeX/G+Yzd9/lCMv58cwgwbYVYYA/RED9QsFdy/yibC3ehEgU/+
 WZH2NrHyfY+/hNgX95MHs6leVB69fhiJ0Y1D4WIpZinf03lm7IzYR9HxNYoqrv/y0y17
 d65w==
X-Gm-Message-State: AOJu0YwUnEuYQ7mj+mVtFOo09EDmQFYKSdNB6mdpfPxkmKtDX004GJ0W
 AclyNatXYiViYbDYY6+FYR4pUzzxluEc8ggy3uMIA81LH96kFZkKfgHJe5diMpTOzxM=
X-Gm-Gg: ASbGnct4papaDcZga+fMpkLR2JNR9EjD3uJUW4NWKjtW3IP+EgzRc/y14rddKr9TXLB
 k0pr6fjvIYzdxQ3QU5tQW+lgQmh/OoPR4VqbBWHYcWOKLtEszWYUzm9BuD7uTJMdDuEjrbUb5R3
 QqwtmoVkOrezZTbAqK6hghy+8DRN8yHQ6ALLsh9JgY+RWDgwDuJ4q4sfDqP0rpjYrn92ayIP0+q
 dsJNyJE0iQkoDMk+d0ZdCsyKrNnta8Q+pyQmlc7Ewk1I+nbi0Ky8NtqjVH54BqW5t2C0yglPSpr
 Psra4csTgHX56h3Zf3uxSdwrjSGgDu8N0Le/GGDSws+mMYVaGAzrbXmHlIXx7r0BV45EAXb5uQj
 z8QYI9dx/bB4rb5bXX77OIcr/QKICJPtNosRXfG30M/8eC6iWfGjtpWo/x8hkVMKuHHsBPktoDg
 1Z
X-Google-Smtp-Source: AGHT+IE5nPMHbWAccXMdJaaPXpPbJ2WasQHuCXHZEJW1POFMjCW9AXagIMPWdzmNYeidbIIeqJb0dw==
X-Received: by 2002:a5d:5885:0:b0:429:bac1:c7f4 with SMTP id
 ffacd0b85a97d-429bcd04fa9mr583885f8f.9.1761847161542; 
 Thu, 30 Oct 2025 10:59:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df682sm33055700f8f.43.2025.10.30.10.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:59:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EDF65F80C;
 Thu, 30 Oct 2025 17:59:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] virtio-gpu: Force RCU when unmapping blob
In-Reply-To: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Wed, 29 Oct 2025 15:12:44 +0900")
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Thu, 30 Oct 2025 17:59:20 +0000
Message-ID: <87jz0ctgnb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> Based-on: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] rcu: Unify force quiescent state")
>
> Unmapping a blob changes the memory map, which is protected with RCU.
> RCU is designed to minimize the read-side overhead at the cost of
> reclamation delay. While this design usually makes sense, it is
> problematic when unmapping a blob because the operation blocks all
> virtio-gpu commands and causes perceivable disruption.
>
> Minimize such the disruption with force_rcu(), which minimizes the
> reclamation delay at the cost of a read-side overhead.
>
> Dmitry, can you see if this change makes difference?

Also works with the blob test:

  =E2=9E=9C  ./pyvenv/bin/meson test --setup thorough func-aarch64-gpu_blob
  ninja: Entering directory `/home/alex/lsrc/qemu.git/builds/all'
  [1/6] Generating qemu-version.h with a custom command (wrapped by meson t=
o capture output)
  1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-gpu_=
blob        OK              0.37s   1 subtests passed

  Ok:                 1=20=20=20
  Expected Fail:      0=20=20=20
  Fail:               0=20=20=20
  Unexpected Pass:    0=20=20=20
  Skipped:            0=20=20=20
  Timeout:            0=20=20=20

  Full log written to /home/alex/lsrc/qemu.git/builds/all/meson-logs/testlo=
g-thorough.txt
  =F0=9F=95=9917:57:38 alex@draig:qemu.git/builds/all  on =EE=82=A0 virtio-=
gpu/next [$!?]=20

so a Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org> from me.


>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Akihiko Odaki (5):
>       futex: Add qemu_futex_timedwait()
>       qemu-thread: Add qemu_event_timedwait()
>       rcu: Use call_rcu() in synchronize_rcu()
>       rcu: Wake the RCU thread when draining
>       virtio-gpu: Force RCU when unmapping blob
>
>  include/qemu/futex.h          |  29 ++++++--
>  include/qemu/rcu.h            |   1 +
>  include/qemu/thread-posix.h   |  11 +++
>  include/qemu/thread.h         |   8 ++-
>  hw/display/virtio-gpu-virgl.c |   1 +
>  util/event.c                  |  34 ++++++++--
>  util/qemu-thread-posix.c      |  11 +--
>  util/rcu.c                    | 153 ++++++++++++++++++++++++------------=
------
>  8 files changed, 163 insertions(+), 85 deletions(-)
> ---
> base-commit: ee7fbe81705732785aef2cb568bbc5d8f7d2fce1
> change-id: 20251027-force_rcu-616c743373f7
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

