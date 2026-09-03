Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B166C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CuG-0001ot-0D; Thu, 03 Sep 2026 15:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2CuE-0001oV-Ni
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:15:26 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2Cu7-0007EO-7c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:15:21 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-857ff9fef54so2730917b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788462917; cv=none;
 d=google.com; s=arc-20260327;
 b=YTozrROTu+iMYqATpI+ilWC1VnXWaGWI5d2pHLqloa8WnN8RIp3XSNdnF5oJ5yWkh5
 jjF6Vp1gghrGjfRfi8V4OI5q/gWB5cO26AQ+LidvWS23PC/8WRLuCr4cio928T3OP1pz
 eEzontfnCmCzzZb4AGeL/eb9IBzM9WA8sK73aW3tgB6Elu1+CWj4ywRcRW8kjrPmq/Zw
 FGxs2uyxaezqXzx/pLzm2dsPwYh8Wj7svMp+2atxMEH8hEr8kVNjQ45VCOSaKMVv65RY
 YXLGwUMTFFRsanGP8GivcVjthv65GUiyr6VPyA0a4Eit7n/yrGIdHP8Dia7ToUqDD3b1
 oPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aUXNQ/rDTtho8KPoIAV6uKjCHDLVq/QWh80noIFev2E=;
 fh=3XcdnKPPujWCgsoSlfyTIC7mLtr3DNVpLRjg7tPS1Nk=;
 b=dNHQhAwfTzFEZnMBBptwvnapdUvYVPsELTkeiC3PObkUmyE+CGMXTe5tffa9xnsuU5
 nQpiBhVILUclsAxTnVtAtXmOy1MKpb2IUXbneEMlM0Z8tsZHtgxYw7HkL64IALeLcvco
 ksQcCqOl1rHIGJLH/mG5XVXIicsyJqWSncguwthfit0RwPVSSOLCy2lgRSXl0yPAx92r
 hoedSR8xdU1EZIP/2ut06dloWgDHAOgT9PUApNB9SOeuSJkorxGCQbXW+bj867NMASzU
 0Lu952mHbR5x0RVM/aMdUgUQri5f/dzpukMhBcwLWlrDKBtZVEE23s01YouwckCNMIB4
 Q+LQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788462917; x=1789067717; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aUXNQ/rDTtho8KPoIAV6uKjCHDLVq/QWh80noIFev2E=;
 b=kEBts32Ib02mPLiIK8Rwb9zvu6tJzYZHbYk0gAy2paVyh28RNKIoWM/J2w7K8Xmzq3
 7LfypWOF9OvI8GbvSPi38d5hWaCyjy5xj8JHfYDhP9lPUi0LkIlC42Fur3TH794uWyWq
 2ENnJmdivdVJsXUTa3Lch60RARBQoLuilq3HQ9pVZ/ftT42SnWfGfv4MA77YVmCovWr9
 QtvVXxd6A/erJZO5J2NrQuT+8ad+IbMQfDb8jlQ6CRPg3L0Zsv8UEON2LcsvJtKN4q02
 zUOjcxSLCtW9ytD6ekYARiIlmZp2WBbUnbkvjfMRqngeeNOWPFp9cFtfCupLit4JGH/5
 btwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788462917; x=1789067717;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUXNQ/rDTtho8KPoIAV6uKjCHDLVq/QWh80noIFev2E=;
 b=IclZts5hCZ5WRPGO+awTrsL7Ow7vbp5EnpFYlFWqpXzlaZf8BdEg9z5YsEK4VYuv+j
 MaVTvIMwdc2UZyPvQvRgceWs0x+ipEryuRK25wptYzf4F9+rCaXvJ82Rskrsf64f9X8L
 eDMYoMmgN4mAfd7iihf+h8Y1nBix5F/Agbadz3RFfvhgQPfLTLdwkpp5fq+8SmFq55vW
 HtkxmtI4iuE1M5U4Ni35GfRBB8JLOyiKBiSLuXReJljVhJ9HwripHQl43jVe15UeKpxw
 QIQ3IfPwJ0w/bMbocrVtXUHd/WEdVsG3LKF1cPzrRsVETHDuZ68Woc1ixzPWEcWeMdSu
 z/ZA==
X-Gm-Message-State: AFuF++kfiGVMFjzJDT+BpqUEMViWmY2t3yfjd4rhNYt1FOkGnH+Ktjqz
 9XjlsF2ybr/1go2/nYfaT7BiWHFKJRe1Ca3wJg+OqHs7ZIrh4nwQNgXR8My4m1pRKRA4jsNpf91
 zvoen/p44KXOv+eT8MrYpgpF8Lgtb72DMFtZ4YTi2qw==
X-Gm-Gg: AYBFou3cbzp+vQ7Oc9Ik7N9MIi6IlWyFy5+nCsOjmCqXpwOtLH38EsvpidrJbJ/YIKN
 Z+hjfQ8maILPKzGLEWCYsecHFsXcmLfnQCCicSdohTOl6wCx+OU2L46pARh7hs47tIueR8+5Kdm
 zDIRZubSv1veL436LAJaP7YOBs5jeKc2Fj42pxlh4abVMuqysUERuvOL8dy+4HGQq4K0RORAP77
 KuQbmtzslVe9YfzP+6so7pbkbYVdZWSxjxyzvHltf5+6zRCYZJGJoB1X1feHU8GEHjv03CfnQ0V
 SMR5H7+NQLD7GlKFMIXKXvQgK4mpNBc5ap8rgMT2+lEVy6mn5KiEcE4+3kPHEGUMWjEqcHLACFN
 /qXSNA/e/xSwRnT4jL12ypTpsHax5hUZrUM/StlU=
X-Received: by 2002:a05:690c:a1cd:b0:862:65f4:c8bb with SMTP id
 00721157ae682-8712259914amr5163317b3.3.1788462917095; Thu, 03 Sep 2026
 12:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 20:15:05 +0100
X-Gm-Features: AcwNN1W9-cv6RYcmVzY78C8gA1oi6upj7elJHcSdbK4Dic1UZE3E2BnoxnqQd-Q
Message-ID: <CAFEAcA_nzQoyg_V5OkiuwwY6vEDZVXx+GVVeTXF+JyBdhHuhmw@mail.gmail.com>
Subject: Re: [PULL 00/51] Misc HW/accel patches for 2026-09-03
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 3 Sept 2026 at 11:40, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> The following changes since commit c513597761d6fc06690b5b7cf10dfb7ab05815=
d0:
>
>   Merge tag 'pull-hex-20260901' of https://github.com/qualcomm/qemu into =
staging (2026-09-02 17:59:30 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260903
>
> for you to fetch changes up to 94651820173214b3e012cd7e0a69ccff0ab196db:
>
>   MAINTAINERS: Update PhilMD's email address (2026-09-03 12:22:32 +0200)
>
> ----------------------------------------------------------------
> Misc HW and accel patch queue
>
> - MAINTAINERS updates
> - Add const qualifiers to CPU state accessors on various targets
> - Improve KVM/ARM error handling
> - Restrict TCG HALTED handling to system emulation
> - Introduce TypeInfo::is_available callback, remove arm/riscv machines fi=
ltering
> - Parallel NOR flash: Fix ROMD mode on Intel, add migrations support on A=
MD
> - SD/SDHCI Controller Fixes



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

