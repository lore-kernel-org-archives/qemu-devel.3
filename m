Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D3CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeqE-0006uJ-I0; Tue, 13 Oct 2026 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeqD-0006u8-KV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:55:01 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeqC-0006fF-1z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:55:01 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-836c8bde2dcso20083477b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906899; cv=none;
 d=google.com; s=arc-20260327;
 b=cHVuFYLBwc8zuZUtJiwNaeYAEFPlCioSbyEoJD6C++bPQtUfBxgrmv7dJs06zkivVQ
 FwEX7bT+ceg5ASLHUvpY1bXjAZ8bfweJiKcXg7ozH3yNoBozahOEFoI7RWwZ1U4Vc2/P
 oQ2QRE3zA6T0Z4y1wTnT4OiVzlnBS2xQXPjU+AwCnPpyOrJBIKTSSZ4vAVK5oYGuzhfX
 p9lrIA7uhCuJFLZ3DXZrxvlxmp5acZhs+EdiRDAAZSP5LBPoandJzx6YGGXupcigRW5q
 VSYD6d3OCVGmPJAgwXYTEqV4pnVmWqf+KPCPcgUkgkQl7wpRz0d5FcIUMxASgOPixPpZ
 tquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xUX7O0hyhnzIaBL4GI7Fs2xl6p868YhCKfTy7miSTVE=;
 fh=RmoKsKX77arZ+yzJIVagKGTqLsiR0EujXd77rKqWDhg=;
 b=cGS+WSGn0H+vX/tIsXTUDRDJ+CY9xPyqsVoh4QFpWbaNOLNS93t9doQ1IW4TXcRMYF
 dEGWjMhqbQPCpu75xeKtcjb8Mlt8DLkUHkPFSjR7y3ZeEJTZRlXFGjgFFNtPVJBV9cOf
 auTtVtBDHzvuCEOyA+quPqkBRauIR6w/U/Js836dzgUsXUKaH1K9hjC4iQ0nOTgZZA31
 d1hW605t5AeOLzX93rZj7TwYBBZk9vXxF+MV9we12WptPE8QVFu9B2ceqY1qMt5v/7LO
 XT1X+T5qiNqB/IOqqrF87s1CdyHT7I8rNXgypEzYdUIaTXtEvPyk/+Id8JJNo78tNj3v
 e9UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906899; x=1792511699; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xUX7O0hyhnzIaBL4GI7Fs2xl6p868YhCKfTy7miSTVE=;
 b=m15ZVRGIOXYpqLKcb4r9okN7WNrRrNxpgJaL9QaUdVH6PPEfbvrgUxpNFG4uoNOAwh
 tHzae9YwZVWjqkOEn2bJuIDKi/6hUHxjfPyiIahvwcPghov8gyMBve/lySqqZOEP9+Hu
 HlbKnZvSbgD8KQVrukClXsqZ/VYe7Ldq4vmzyzO1aO1zstlT0qgQjl4zH6U7be3E6t55
 APpbOVAATUuRldiHVZkUfbblc32ttUPrUIdZHOg6xNLS5C8DAzFhs5F1Zqft0wVmYHhO
 DCyqbz4yRi8saKHD3qBTMOcBmbMSklNT07lFN6pliYECbcN1/H8TMYqf+qxAybodLFiR
 OjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906899; x=1792511699;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xUX7O0hyhnzIaBL4GI7Fs2xl6p868YhCKfTy7miSTVE=;
 b=gGjfpK4Dl4CnwZhi4pOD4GJj1+doBxYd+OwmugrC8CuJ3qANsrhL7kV5cjNZNI7alN
 RotXkW2YWfcQhL6uWOhMwh0ztcuN7nh5AfbzMKEhaiuvaCXhjF4uKkO9X8UYcnGUGCiw
 i3X5kJeOCT106k6y70x1buG5PVsvyMf+T+xcW4/q88qwmfVMU2QIPb1fcjIRYFbl9YPJ
 1Yo+EaAfmJhnOMppBGPnS6Q5Ks7unTi5uiDS9S7Tlk2VWWDURBp8IQWK6sH/CKUVPHdT
 k5IJfK5zm8IHoyXN7Zjw0OYUrQvUC/ACCsatg7OQE0WoV87noxM33GmswI1fSpIZA7mt
 wa8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqM5qgZj+4Rr2P6/SNEWrINf06PHXy11zdXIbhH6/8Zi7/axjpYhYhK90IQOz54/rcI9gSKp0/9DFA@nongnu.org
X-Gm-Message-State: AFq9FYJhCPOBa2ZxgAQpXIiMP6jM6LbNxjUi8/ljz035MfS0sMKTrUfc
 bi7HxOq3+9cFc3AGOIQF8E5lEGnyJWkvuu3s6isFGyZ28rPH9ToQ0oCDlkuj0/5S5Ux7YPfpk2C
 9A5aHrr5T1XPDvDv6veXrnEyXWL/3nd9S6hSoIi0iww==
X-Gm-Gg: AYBFou281UlxpWvsGG2r+k0EF2xHpQMVDVfGs3xQVDGcnXLOp83/LbOj1NirZqhfdSU
 Gyp1JP1DXfN2za3q9S1SFWBzMSvoJGVNGDU/lW8NsDxQRkTKZxJTr8mv8oU5iwuHWeYnS3KLGJV
 krCNN8pxovNUkjdm+YPvWY75y/s0nd7PX+6OfAf/BjA59TSOSH4piBsWrToXZdWDpp/ZxX/K8FQ
 rAVGib1UyPc75YFKGpOKjp8i/DliJGDR3SyTc+OxDyKBhYh6o/+ksQmwZiKU6lsrrVBheQIAhic
 pTMVntBLGJHaXRrBp9sGxQVAkY1GAjf37DGTC2+2Ip3WnN+2VXeqkbJpjCFB508yi8KBV6DL1mp
 7nsfa7geXc1PgYuXDem1HvuPYKrFIsskxK4voudQ=
X-Received: by 2002:a05:690c:c510:b0:8b0:b0d1:fc47 with SMTP id
 00721157ae682-8b0b0d20337mr16623687b3.60.1791906898640; Tue, 13 Oct 2026
 08:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-6-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-6-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:54:46 +0100
X-Gm-Features: AclHuK8tx9cc1Chrkd1VlgBGe_Zyl8Wqsg8OPvfvGLJ1IUyuXdLtJM5RjrH8d_0
Message-ID: <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
Subject: Re: [PATCH 05/22] i8259.c: move parent_realize from PICClass to
 I8259CommonClass
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Both the emulated and KVM i8259 implementations store a reference to the
> parent_realize function in their respective classes. Start by moving
> parent_realize from PICClass to I8259CommonClass and removing PICClass since
> it is no longer required.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This is one of those things where I think we're not 100% consistent
about whether we think the parent_realize field should go in the
child class struct or the parent class struct. The name "parent_realize"
implies it ought to be in the child struct, though, and I think we
do that more often than we put it in the parent class. This also
makes some kind of separation-of-concerns sense too: it's the child
that knows (a) that it exists at all and that (b) it wants to have a
realize method that will mean it needs to chain back to the parent.

The docs for device_class_set_parent_realize() claim the parent
realize ptr is stored "usually in the instance structure" which
I think is just completely wrong.

I could be persuaded otherwise. As usual with QOM/qdev, I'm
mostly interested in (a) consistency and (b) documenting what the
"right thing" is. Realize, reset and unrealize are the three
methods where QOM's lack of convenient support for "child
implementation of method will need to chain to parent impl"
is most awkward.

thanks
-- PMM

