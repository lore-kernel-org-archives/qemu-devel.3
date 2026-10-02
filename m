Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D4CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeX6-00088h-B8; Fri, 02 Oct 2026 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCeWz-00086n-LK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:46:40 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCeWw-0003sX-UE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:46:36 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672c2880f58so7785734d50.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790952392; cv=none;
 d=google.com; s=arc-20260327;
 b=A5n+pxEsaG9zBZYg3Q0U6g7ZB8kklYl+ZXNYZArRllfpBMKhVbml6Zp46+LxUa4jmx
 Egr+BrnziZ1I9qgVWNuNOqetXRaX+dSEA0Phb3F8z8J6hgWZ8gX7+gti9A3K87MX9D2M
 hLb1GEhSD3Bh/nV1Vo6cAeqpDNq4r0ztVwXD/56Y87APQayb+9nMHRmPnnDQspOXJ0U1
 1BfXaLSBPippCKRqMC2HyN2eUR6HF6E2jswlU0v2r+onSJtvjYDHX8vtkQhH9YdL691/
 Q2hEhhOFwtL4xKScQOZC4PlKAxEeTDQWxVeMdiiB1mJXMxGIVcVcjlXNVYMOyHptMUge
 NN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lAMwcizW1zvjHgl1QSKNa8I7V2eg1prWhDiB8byQ7nA=;
 fh=CKGv7PpI7GuseLo3IyfferWYLuL7PC/ovF0PN+PD6ds=;
 b=KOOG5OvARlgYvNMDy+9fu5jyBeygY6w7wMvrDTSdTFMAfTFdSOfjCslqqSp+9Ws84c
 HIQeDwXtrjgsBMpUqdauN+tfbqUGAokZ4FeuZei1yC4XkSYulEjaa9GztIxBAm9xvIyV
 jv+R+f6vnGo8O1GHD8MQeBfNbX3svk+XkrmthhRcC5nZEuyoo4aI/SZ6+B9V3tNtFzEX
 Xv437sjmYEt6UhnYx9IPopamXsczyB94YOQJBN6vrBFqsOJDbWuHg51MSqBs3XJvXTLl
 ttATj0LOF1MMmO0dRrTYGMEuVb3wHxrvTS/f83FWZtNd0rF2KXIJRLMt7vFrpsFQhbTt
 a4fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790952392; x=1791557192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lAMwcizW1zvjHgl1QSKNa8I7V2eg1prWhDiB8byQ7nA=;
 b=UM+bImMp1EcYgPmlJII+aPMkd8AZz3ROX1E7dt49XrYwF9vQFqbW6IvRa5MYXyTApt
 /77FRImcKboz/UmC2sP7XMdiDUfF+DPngptI8jGLWbXl63R+JaNX+5ZujLRcddncuvuo
 jEQNEfThHHLze60NpJlc7UVAG3BEZLYtkyFeSPMv9vjkmbxFPhxO/nNGRHvaZC7fwALv
 +dQS9n/kd9NUX8xLcca8oVwpGjcQOrOplAC/n4HZs+pnFdhSNisHkSx1MXhprFff+Zob
 xlDHOD1EPuts+mOyDHC+cw3lo07bL/k77B8B/dOnRD+98NU8afJwcG4VF3YPniF/gzph
 g6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952392; x=1791557192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lAMwcizW1zvjHgl1QSKNa8I7V2eg1prWhDiB8byQ7nA=;
 b=SAh0L4+yEnzXNntMvlW8YCQFtGVBNx0H8DL9Owl5fQX+6rs6nuT0AlCWfVp+gWlvX5
 o34E4I19Nny2b8pjrP63kaon222MSUJkcCIVN1x1hloTgsB1g0DVczyqXf6b1ibImkuG
 xQIPdncOyAM02jMoHtvYbfJq0vhWvFF1hHuTdAd6oJ6bXaURCn5l+Zl5ghzKcFixlAXh
 2J2gCOCojJDcjknQ0UdUpsc0tf8FN1ClMRKqoiKxedaH6wOl+Vmbsfx2PpwY8NKaYz53
 gAuj1QhQkhWnYFVbTctG+ZLkBSik/V6c3efr9TbtGIvtMhq4SZ1lzD5pbeUWMIuHx3VW
 JtRQ==
X-Gm-Message-State: AFq9FYLTRvoCaZwv2cO/ij4bmc28xrUPyfU98O0Ofh2ZLhM9m22i586u
 IAHqSZyhgzb9qkBxdjyVuhpXUIbKN5Mr6mct3eki9r8l8y9q63XQgv+DZQoO1Xsaf8Utx+od51p
 MW7xS9ijX/jMETMGQvrXyiUAU/jeT7pJAepjDQQVV9g==
X-Gm-Gg: AYBFou1Fp/DMfMaN4+N9GTwyX/1LBU8rxvsh9Nu4pBKjkh60m+VE1vDWg6rnynQQjQR
 V3A5sHYQvrsi2YWcHlVMGqhczQr+XpeKxiesHizj25fgcNInonxCT2WSDGlcg79PXQOjmjl9kFa
 eUt6Jw59XBlLdKlEMbuFJiLQFBTS7tiEWvWIcfA1uYVJiCvA2jB3/u4JbQZwcMF7AlsrpMi0IBu
 k0o+b6Z7PlwBxb31hWrqYk7CIl73J4fJf7F9ZGGu1Sv9dDFSdxFZIoU+MYnh5qywwMffSL2D99j
 j3yUJg0ZwhgG0fZ2Mx7HWysyb3UXoKqxb324bZLts6VM9qW1jWK7Ppxzh1dLLAJKTA50RVB1WoO
 Inc40UjC6+bNNrvlVbI/nu442tQoFD7NO+0y4u2A=
X-Received: by 2002:a05:690c:dd5:b0:8ae:8d28:77b6 with SMTP id
 00721157ae682-8ae8d28827dmr2796367b3.41.1790952392226; Fri, 02 Oct 2026
 07:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-5-philmd@oss.qualcomm.com>
 <CAFEAcA-9R6ov530pA5FV6=ECr9qj5HP7yz=O4YtyCDJDP3qc6Q@mail.gmail.com>
 <19c91bbd-894b-4d23-86eb-00d68482aa8c@oss.qualcomm.com>
In-Reply-To: <19c91bbd-894b-4d23-86eb-00d68482aa8c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 15:46:21 +0100
X-Gm-Features: AclHuK-N7jZnW5v3yjx5u5hYWXxHIx7oDI_Nuia5TNL-57X1H-xPAy_-gw54sV4
Message-ID: <CAFEAcA-7DDa1u4OsH05EuD6xt0rCVwTVeQE+ppRX3tdCqg9kxQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] accel/tcg: Document cpu_exec_interrupt()
 callback contract
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
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

On Fri, 2 Oct 2026 at 15:37, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> Does that update sound good to you?
>
> * Called from cpu_handle_interrupt() with the BQL held. Identify which,
> * if any, of the possibly multiple pending interrupts specified by
> * @interrupt_request should be taken, using the target architecture's
> * prioritization and masking rules. If an interrupt can be taken, update
> * the emulated CPU state for interrupt entry.

Looks good to me.

> With the update desc I wonder if we should rename the
> helper as cpu_take_interrupt()...

Mmm. the "exec" in the current method name is "because it's
called by cpu_exec", I think (compare cpu_exec_reset,
cpu_exec_halt), which is not necessarily a very useful thing
to encode in the method name.

I guess my opinions are:
 * don't bother renaming unless we think we have a clearly
   better name/set of names
 * if we rename one of the cpu_exec_foo then we should probably
   rename all of them in some consistent way
 * a new set of names would ideally make it clearer what the
   difference is between do_interrupt and cpu_exec_interrupt
   (I can't remember myself why we need both or what the difference
   is offhand...)

thanks
-- PMM

