Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553EACFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObtG-0006RY-EB; Thu, 27 Nov 2025 08:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vObsG-0003vG-SW
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:17:34 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vObsE-0001UA-QN
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:17:28 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-640d43060d2so667457d50.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764249444; x=1764854244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3pakz32wSZhdKVg8R5W/3vpSw7KoPYwSAUdcN+pi7w=;
 b=w7ICucs6jSjyPhRpehfmWthDKlzvdfBqV49cYGxOYJMyEsIMkLRU2XhXSKjxXucUyv
 Kjbe4Ufm5lFAC558EazxDi/BjnhqdzXihIsAcX0mBfMCu2hA3DYULrpo5lVIHnIJ1r9V
 f4LGBeJjD0aqnJTUJo0Xtd3cuqJPcNUq+OCMG4f3MIauZDqehn5z9FwGOV+aczpVSdLF
 MukoEOdWLKmme5z1d9p9nEStLjM3bJIbVRKKGhH+izFGu3heyeZ5+hGUOnfgCc/qVx+Q
 OWbBhaWBQbkMq6duawNoHLeQ9xMc4+4AAdRq6AnTvIhPW930r5sO5BhtlZrKoTqA9eD9
 bzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249444; x=1764854244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3pakz32wSZhdKVg8R5W/3vpSw7KoPYwSAUdcN+pi7w=;
 b=rQl5M+CiPgr0KcXeajumqzsrrYqmef4urQf2sou28Rjq+ls3FSxW6pf9YY912mdqHQ
 zZgXObOsTgRvgAFmq/Z1Vliudgf6Z0PMfYfyTIbfYTBGga/lGMnPIYUAUt2lB1pOQtat
 TsNR1gbVJPs2BStnN5iI8ujZocooNJ2iv2UsWP7w9JmWahjKYEbKok7b7SEQIt8+kRGh
 GZO6aT7pp4kbmA2OTHg7YEpYXM6000ENqtadPr7OSp5OQ2qUhnEjWP4OfpcbTFu85fhv
 L8ilkczB0xJDe22Ig4G2Zdei3Xxa2RgvB2nH/TiBAP95Hs7yF7p2P5L4E4yNEWGVqLi6
 wrNA==
X-Gm-Message-State: AOJu0YycwcoWHYT2y08npZwKFz6gsZvErRdJfgn6XzufaNUYMBdYgQf2
 zl79lOnuE3R1ZTyYVIYtKoB/U9AJVILc1rnIjLQz9r5V9GtonWMnxpu+T+amBydJwHL6ryyzKSI
 ZMLuiCHR16nMLB+4wiZ4WzPjzMsMN32EhcYAT82lMDw==
X-Gm-Gg: ASbGncvdjSJg+zXNaDo2roVUbUTHKHvwahRl7sU4MQhm+v18qfrSNYOuNuOzCzkYjmy
 URhAF4A6l1leX0/berTQkgJMHXKV0xyUSZdVsz2+qT9fgKlm7Wi5/tABv9RUpw/t6qKw7fjO6Cn
 SG1oPWAkvisp07JotzT/VB8wJPMuf2wYiimbMzkX3KS7F4edHEZiO1G6+gHb5CuWtW+aFHv4Hda
 9wnqPRc34tVJshIqOsmnNRNWEODopfBTczYYME03LueoczOHjAaRih5B+KvPE1y/ZzU6M34
X-Google-Smtp-Source: AGHT+IFyyo3TgHamVGTgvTmPuSu3DD0tYD5juVPmDD7qVfJaYS/W2QnLdpcFJ71tIWLvqaEBhn3ODRDZL0c9clnwY8k=
X-Received: by 2002:a05:690e:128e:b0:641:f5bc:6972 with SMTP id
 956f58d0204a3-64302afe798mr16108733d50.78.1764249444027; Thu, 27 Nov 2025
 05:17:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
 <20251127001247.1672873-2-navidem@google.com>
In-Reply-To: <20251127001247.1672873-2-navidem@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 13:17:11 +0000
X-Gm-Features: AWmQ_bkedzjeP08VzoKxLQnkFf-s_chi38dGoAR8VCgGR0R9yHsww8UIJB4HmaI
Message-ID: <CAFEAcA97NhUDzVx8fePmW2HSKn5DhhaQEkc=FkmPzGf+vKFKzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libqos: pci: Handle zero-sized BARs gracefully
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, zsm@google.com, alxndr@bu.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 27 Nov 2025 at 00:12, Navid Emamdoost <navidem@google.com> wrote:
>
> The qpci_iomap() function would previously fail with a fatal assertion
> if it probed a PCI BAR that had a size of zero. This is, however,
> expected behavior for some devices like the Q35 host bridge, and the
> assertion blocked the creation of new fuzzing targets.
>
> Instead of asserting at map time, modify the QPCIBar struct to store
> the BAR's size. Defer the safety check to the accessor functions
> (qpci_io_readb, qpci_memread, etc.), which now assert that any
> access is within the BAR's bounds.
>
> Signed-off-by: Navid Emamdoost navidem@google.com
> ---
>  tests/qtest/libqos/pci.c | 25 ++++++++++++++++++++++++-
>  tests/qtest/libqos/pci.h |  1 +
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index a59197b992..70caf382cc 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -396,6 +396,7 @@ void qpci_config_writel(QPCIDevice *dev, uint8_t offset, uint32_t value)
>
>  uint8_t qpci_io_readb(QPCIDevice *dev, QPCIBar token, uint64_t off)
>  {
> +       g_assert(off + 1 <= token.size);
>      QPCIBus *bus = dev->bus;

The indent seems to be wrong for all your changes to these functions?

Also, we need "make check" to pass for every commit in the
patchset, not just after it has all been applied. So we need
to make the fixes that you have in patches 2-4 before we
can start enforcing the size limits with assertions.

> @@ -541,6 +550,19 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>          addr &= PCI_BASE_ADDRESS_MEM_MASK;
>      }
>
> +    if (!addr){

Missing space before "{". (scripts/checkpatch.pl will
probably catch this kind of style error.)

> +        /*
> +         * This is an unimplemented BAR. It is not a fatal error.
> +         * We model it as a BAR with a size of zero. Any attempt to
> +         * access it will be caught by assertions in the accessors.
> +         */
> +        if (sizeptr) {
> +            *sizeptr = 0;
> +        }
> +        memset(&bar, 0, sizeof(bar));
> +        return bar;
> +    }
> +
>      g_assert(addr); /* Must have *some* size bits */

We can drop this assert now, because we just dealt with
the addr == 0 case.

>      size = 1U << ctz32(addr);
> @@ -572,6 +594,7 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>      }
>
>      bar.addr = loc;
> +    bar.size = size;
>      return bar;
>  }

thanks
-- PMM

