Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623F4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArVL-0003Av-PW; Mon, 20 Oct 2025 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArVJ-0003Ag-0p
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:08:57 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArVC-0007IH-LL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:08:56 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-781421f5be6so55278547b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972928; x=1761577728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zkWe8tVUSX8+dRg2RhxjKQN6I4yEPZ0U/wr7UIMGhS8=;
 b=pF5S8Sm4Zb8+NUreok0ThchYXddpsyYIDz5qX1s+4WfAUxxDa0QWfcAt0fcYmN9Kl7
 MDknJZhWKEeOv19v/o0ADJH3IYXV4Q0IUZsRA1bBBWhufdZP8otTX7SRcRWEaUdnc1ey
 Urw/ValAp4IxuTa6/RgH/08mHJjo9N3PyVlNxfHCZWdG0MXtUnX14fKaUc1CvuCDMBC3
 P2/bA8exOX3yxsJP5u3CCGLSMvjQSKEXa2TBBY7yAzAzh+5m2Y9NozgEWeoXY5RGC3oy
 RlJ+Qcc8FCBCnywEIqDGm13Q/wxQ75Ikupz1VmvUZ74+U7PMdo5QHx3ftcly+n7Z+n+B
 ks3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972928; x=1761577728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkWe8tVUSX8+dRg2RhxjKQN6I4yEPZ0U/wr7UIMGhS8=;
 b=jTaTQ4+7dqHOZoMMP9S3THBTaJckZXxKdg2PR88xh6EwPGOLJjqS3wNjNTs3s/UYpZ
 DLUWjdXKfY3Enl9oYDCFZtCMNi2wL0UeB7XKBYzJSP6Xk0I64k1Uv5YNrZBZhpDEDc9R
 JkHACfNCKYyPW9s9e/Nqad+EL7+uqvxM8SzU7AFdzCneWOxXXnjLIPJ/BJlruyWh5glm
 syKsdCX7BwFF/FZfPHD+XJPi/DEoD1lEpJAVMfwE32wAhFsLFnyvtfeL4QSdOqAsQ/Uz
 9g0H7ac+9dn3lH4375dOivfSDl8cSiW2JG1/69LQ66aIIqBmpahNl6HHhNX83yqfEw9i
 jJ4w==
X-Gm-Message-State: AOJu0Yy6rdizYREoxk28KQFA+Np4PPSEYCFdOKsU1xfz2lLILTn3HuWW
 RSNroAdrNHoa+5hItlLXWVrvKYNO87oO6aqOtwkioD09C0dmk+He7joEbu8ZnGlg2emhPQm3Na+
 L2cXxuNBLPRgeZb2Gx056CKHRKjS+QhgFHbdqNZaj4A==
X-Gm-Gg: ASbGncs3UEwg4I2TXkGUKXeU93mC0l/2Xogy1x+gM7M1NJlf8r3ym30uvQVwCPPc3C9
 V2BHEF2VRr7nuS6N4sd6NbQ62wE9Bx4yuHVK9mhPaFmy1jJ9L2eEBjqmh5cxLJaOeMdmkzwqcza
 LPrejH5Weg2211CNmntW6TkNR9Y+GrIzgSkgcK9OcUua/8Rgxb/sGyrynLWUQxOpZ9A2fzhR6Ws
 z6Saqe/1qVhxVfoK8y63AzN5wpuJhE6vbe3JOcdmpRwiKNmwvYKidUwmLU9lw==
X-Google-Smtp-Source: AGHT+IENa8+lOiAi2ZmezKK3JuawQb4+5ZJrD6bX2uO4B/qA/Ox3dmM0xB1FVnsx9oTKKiLOUBq7w4ZSVuJq8xMQq0I=
X-Received: by 2002:a05:690e:408b:b0:63e:2284:83c6 with SMTP id
 956f58d0204a3-63e22848539mr8547532d50.49.1760972923444; Mon, 20 Oct 2025
 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-2-mlugg@mlugg.co.uk>
In-Reply-To: <20251011200337.30258-2-mlugg@mlugg.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 16:08:31 +0100
X-Gm-Features: AS18NWAbGZG_Q933dYn_a7r-u3vJmOET6H1STkN7QHRhPxxa_WLXbK6zXioy4P8
Message-ID: <CAFEAcA_dkQEmOHg1ixd_OV-ctXg3BCOWjLtS4Aa8Cc-QeLpzOg@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-user: fix mremap unmapping adjacent region
To: Matthew Lugg <mlugg@mlugg.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sat, 11 Oct 2025 at 21:20, Matthew Lugg <mlugg@mlugg.co.uk> wrote:
>
> This typo meant that calls to `mremap` which shrink a mapping by some N
> bytes would, when the virtual address space was pre-reserved (e.g.
> 32-bit guest on 64-bit host), unmap the N bytes following the *original*
> mapping.
>
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---
>  linux-user/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 847092a28a..ec8392b35b 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1164,7 +1164,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>                      errno = ENOMEM;
>                      host_addr = MAP_FAILED;
>                  } else if (reserved_va && old_size > new_size) {
> -                    mmap_reserve_or_unmap(old_addr + old_size,
> +                    /* Re-reserve pages we just shrunk out of the mapping */
> +                    mmap_reserve_or_unmap(old_addr + new_size,
>                                            old_size - new_size);
>                  }
>              }
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I agree with your cover letter:

Cc: qemu-stable@nongnu.org

I think this has been broken for a long time, right back to
the introduction of pre-allocated guest address space in
commit 68a1c8168, where the code was clearly confused between
old_size and new_size:

+            if (host_addr != MAP_FAILED && reserved_va && old_size >
new_size) {
+                mmap_reserve(old_addr + old_size, new_size - old_size);
+            }

In 2020 commit 257a7e212d5e5 fixed half of this problem
(swapping the two sizes in the second argument to
mmap_reserve()) but we didn't notice that the first
argument was also wrong.

thanks
-- PMM

