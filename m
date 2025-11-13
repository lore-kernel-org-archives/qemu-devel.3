Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6BFCD6E6C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXxe-0004vN-Cx; Thu, 13 Nov 2025 09:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJXut-00021Z-DW
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:03:18 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJXur-0006T9-L6
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:03:14 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78665368a5cso8087857b3.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763042592; x=1763647392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PfqxdFAvZhZH9UEYm8fJWBMv9WRyFzoi5eQnCHpltNs=;
 b=xC237IiEaBmYA3WEvI94SoKkMnvcZjo25kd4/30lHKhm89p079NPyqz9VXuT4XUqlt
 wkDiiXo7xJCeIdI/YTQLyt19ryVBILT9kyLy18XNIOhjEQPLZ9Mzt9hXsiBem0hDuFTa
 osZjcRA5go2ddGOMbQY4x9eIdt2Ikpc6LDYU4sKknbYF2R09lA5aqe8hIlj6DUsyMGuA
 ik6WlUOas4javNwDF/cQVIkVA/NSsDbmxroJyxLpA19VBeVO4+Vrfu6QSjtVWBvRrKEQ
 p2RmrR5rw6SaCTgIEmGLg+Z2L07MrYO5ZjAL2bylw86qWoBHlkqzihGe+ngCL248h/9n
 otdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763042592; x=1763647392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfqxdFAvZhZH9UEYm8fJWBMv9WRyFzoi5eQnCHpltNs=;
 b=OUUggLVrChZySzjPUaAqK9oXcZ47kW5Tc+nKIcf6KhV4GK7L5Duwi1XrEE02lwqpmI
 0rHw9ilcOLZBX3tcNtYBlTGw4gPQnEknVR8fFwQcXb1C0hrO1osSoUuxqXSgapYtnvjN
 3vcYaowL+QtVDEYONd+1B/DnKgXraNY12zvmMxOa1rUC3O8TE/ERZEmLR192QQlwFllp
 X1D3OhkQVKLVPDjt/OqDJEjbjo19Clcu+7Vp0SO407bf1dryM64ZfrCmyF5QtdjjRt4s
 6f+qoS+UkvroKQbb4VlYxFPzTohxhIdBCeI89s+xohJAIfRtIQPv1zR+Nxutvy6Qs11e
 ukag==
X-Gm-Message-State: AOJu0YxaYSVYR9v7QWfF3Czy2tmxuPiEQabQ6V4R1OJrJw9hSkan6RoG
 rC2/r968oYo7qaxGGWI+7wmVDiKzY2LFSlHhvEjJJ4q4BD9t5U2j8jQm+muJOHzDRu5mVJb1KY9
 jS8XEoNnh9g3ooWmByz1+MN80XB7etFV3te2aWJJ/Pw==
X-Gm-Gg: ASbGnctQkqmgFxjLwmguthsGYNKgsQnWLPqzgcW9AvXbFp7ZqxfNm0Edcyh9rrvJ9Ub
 Q6PEZyLMi2SGTZRUqVRUo2d0TkzttnEJWAA5uRCvTd65to9DuGXzfbsoLwlQkrVpb5PfIGkWmQq
 hiWAP/HJXNpp3OPGNuoiyArsYfa4aiOrArZKt6fSbcEXfKncJg/W0cRAq+jR39X8TA468P5+84l
 +iBYoj3dtuj3K/pYNBzVeyeSHL8zkr67uQYoWr7uKa3eyxqhuSX1BqiQ6ylSZ7OOwKOMAI0
X-Google-Smtp-Source: AGHT+IFwCapEsKdwHEkXNm5Sd5JGymvRD3Z3PRamW0JsdBOPcnD3LGnBK4Pj+d64EZvx0gOutWn0kskWUVXQJOV5C9w=
X-Received: by 2002:a05:690e:c4f:b0:640:d4fd:47fc with SMTP id
 956f58d0204a3-64101b64d7cmr5463410d50.63.1763042591694; Thu, 13 Nov 2025
 06:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
In-Reply-To: <20251008191936.3069950-1-navidem@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Nov 2025 14:02:59 +0000
X-Gm-Features: AWmQ_bmYjniOUn6MDZImDjaDh32u1SP3ZAkUaDACz8LaaWHOecWY6T4-46c3878
Message-ID: <CAFEAcA_kaB5OeRw53Z1u_K4+oB_a6Mi4q-aaNeuOLXpTp-+0jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, zsm@google.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 8 Oct 2025 at 20:21, Navid Emamdoost <navidem@google.com> wrote:
>
> The qpci_iomap() function fails with a fatal g_assert(addr) if it
> probes a PCI BAR that has a size of zero. This is expected behavior
> for certain devices, like the Q35 PCI Host Bridge, which have valid but
> unimplemented BARs.
> This assertion blocks the creation of fuzz targets for complex machine
> types that include these devices.
> Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
> zero-sized BAR is now handled gracefully by returning an empty BAR
> struct, allowing fuzzing to proceed. The original assertion is kept for
> all other builds to maintain strict checking for qtest and production
> environments.
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/libqos/pci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index a59197b992..df9e2a3993 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>          addr &= PCI_BASE_ADDRESS_MEM_MASK;
>      }
>
> +#ifdef CONFIG_FUZZ
> +    /*
> +     * During fuzzing runs, an unimplemented BAR (addr=0) is not a fatal
> +     * error. This occurs when probing devices like the Q35 host bridge. We
> +     * return gracefully to allow fuzzing to continue. In non-fuzzing builds,
> +     * we retain the original g_assert() to catch unexpected behavior.
> +     */
> +    if (!addr) {
> +        if (sizeptr) {
> +            *sizeptr = 0;
> +        }
> +        memset(&bar, 0, sizeof(bar));
> +        return bar;
> +    }
> +#endif

Personally I think I'd prefer it if we didn't make this
dependent on CONFIG_FUZZ. If BARs with no size are
a valid thing then the libqos API should handle them
(e.g. in theory one should be able to write a test that the
Q35 host bridge provides the addr=0 BARs it is supposed to).

I think if we added the size to the QPCIBar struct then we
could assert in the accessors like qpci_io_readb() and
friends that the offset provided was in range. That would
catch both the unlikely "we implemented the BAR with no
size" case and the rather more likely "we got the size too
small" case (and also the "bug in the test and it got the
offset too big" case), and would mean that we don't lose
anything by not asserting that we have a non-zero-size BAR here.

What do you think?

thanks
-- PMM

