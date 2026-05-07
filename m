Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BCCD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKzhm-0002pb-Jg; Thu, 07 May 2026 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKzhB-0002cV-On
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:27:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKzhA-0006Na-61
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:27:21 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c21049dafso938843d50.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 07:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778164039; cv=none;
 d=google.com; s=arc-20240605;
 b=I2Fnhqo+AQEDTrlhJ2qH9czQXAqsCCd5zpw8UFIHnU7ALUqEguXJhjcJ70e9vnsP5i
 6bmfUzXPM1F9URmUpOqDff5/Q+vEosRBk1XgEZ747uTvF3//56HHPrjWQ/evPbcbqMyD
 nacisWAOF8205Eo3ief0CTt3d98q7ceiOezg1PWHsVrMhhmNuLoCZK9zLQq5GAlRy3so
 NcC95mQQXPHKtLYgiV+WdGmPR/JmF91OIjUFKQwHGmsDTtjhDF2weYMyzcYnpOUAEJ2c
 CoxVZuQwVWBZNHUITlSevwgJVOZB6qmRpL79KAQoLcj4mJcN6HkLeYRGE1AcuBFTafcS
 fjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dmZ6GUQKvqAeG5IXwmPlXOKQEUTJ4wFUcQOUkeb6w+I=;
 fh=Bs3JNzFZMZglXqTd9uCSUuwP2gXmqRGByTnAPwB3/a8=;
 b=IkiQVbIrinY26v986MAA1sXNJSQb4b5XU5B+bAJebAdI47A2wJHyJ7ZzmAQ3jlJINw
 8wIFAtcE/5V/CZOpyt+N0nE6yFEvFiENwSgjwslyExziwExMR9v/t6ncqwu/ieGaty0A
 +RYGyb/QU9EzorrCeS3u6O0UtbiHoTd9wttOKl5yOTthw5CL/CNFb2ZW7aJYDPMP3ofC
 IbhKjJ3Pghd1CDTp9BSpJ4ccpwYre5c6BJfZf2ZFApSkrVFVWkh4bJdPlGkag842b+jX
 TNrqxKQxZq3CpqcRGP5whDqMCVSoCS45/Djp0XIFqbVqu2/slwLXlJX5WL3azuAxsH7u
 f4XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778164039; x=1778768839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dmZ6GUQKvqAeG5IXwmPlXOKQEUTJ4wFUcQOUkeb6w+I=;
 b=Yi4t49VQphXN6J1iKoktQv+6LJA8k3OvwL4tg64Lv0TERLxdoTReKqYd+xsASxy7+g
 xoqNINLb8uQ7ju+EzlfT4HEQU9s95BuG3+hFP5MY3At88Ssb5PIIeQfqtnz3qM7dLeTI
 YlwG7W9sm5MiFvo6KkMQx66G51pi/STHt7YT2vh7m08dkGVUb69IxSy5MvN7l/eYpaG6
 a6XMdr7/drfiln2tPTFa+A5S2OpKwLxztSzr1geoOx19p6750C/me3LB3FEXwhpuw/TH
 yJwJBgUtQkbFrmg8Rq+a2gVTUTWs2MfE5tRnlvoazt/77U+p5ywjct5aksP3tjMP7TVD
 E1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778164039; x=1778768839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmZ6GUQKvqAeG5IXwmPlXOKQEUTJ4wFUcQOUkeb6w+I=;
 b=blubp8K+LA4z2B2T6+JyTT5bxahXIq/f5JYq6FucXtHqIyaAiLrTAqD1FkrhMF/yP5
 NbCDVHWJVnN+qMAUwLTK7SyzEoQ5acsG/PS1OgOyfhOY9EDFGZzOpu+oxk35EMH2zzwa
 OABCtrt3iGJ9RjaTxgDdIvVGi6puditr2Y2hHMS8q/VaxoHn9JEeOuHhhNcJwZNBQB72
 4ZOGG0fS2jZcmQweC982mIrRntOIorH0HUZwpExoX1Jf+amhMD/jXyBaFuHLg5+AScfd
 lvY8CSTXHY7wmPDhCXWm+ILBqU5YKcj2/0T73Z0Q4WpdaqvBcvCP7mT6DLtyOvM4aAGF
 f08Q==
X-Gm-Message-State: AOJu0YzbJ2mgIgPVd/QBF1rh72ZFin0A24U7AI34VyI52gIBNhA5PJoZ
 b3DEJHgmPUd7D5wa0QjRR9Ho19GiM9j9/tpcJZazhpqd39+yKbaTHgRcNCz+az0xfsNp5HpTi2f
 V8l1yiyIEIjs9ukqFEio+x5awijZvXZPLDvzXYOKxYRoCsNv81rOe
X-Gm-Gg: Acq92OH1U91jjvCBhZgODdGTiwl0h9mR971fObvZpf5ZZ74hdYClfL2KkzjTV2Xia02
 Ny+SAiK0CmcHPFPzo/IdNixKRRbcvGDmCCoUkDm9WA3+8hGby7E1Rjb2LCtvDg0zCiqEq3s+SnG
 UHcLiaoVC8yq5od23uOhGmkUuA/MvHErBJ+EljE0BKarVcqxyTOlg7/SdVzBcEW/9q6+mRNG8sc
 cEQ0yvJ46rEKkxi8QkDFP0Jx9QWeih4hLmzhiiORrbfwzAYJi6tN2xm862ADyon5qYunJ0ShXOu
 tW8ffk41h4dkc0zRbDNF+H8hTsV5r+JH2zvY0vNM4ZpClLJvTUePhDGxJ68tug9nw0tI1oeSgF0
 IHO6L75zHACUa
X-Received: by 2002:a53:accd:0:20b0:65c:6164:f290 with SMTP id
 956f58d0204a3-65c7988807dmr6834502d50.1.1778164038455; Thu, 07 May 2026
 07:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260507040153.14565-1-matthew@pq.io>
 <20260507040153.14565-3-matthew@pq.io>
In-Reply-To: <20260507040153.14565-3-matthew@pq.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 15:27:06 +0100
X-Gm-Features: AVHnY4IxbasY6Jrw9NRUTFpF0-l1X_9Vie3L2IpMsgjgl9XiPj2slHu6BV6lYa4
Message-ID: <CAFEAcA8+7JSq58HrAtyQ2sEJuDfD10nT8jQKrpcTU7SumTXi-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/misc/applesmc: populate Apple SMC key table
To: Matthew Jackson <matthew@pq.io>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 7 May 2026 at 15:14, Matthew Jackson <matthew@pq.io> wrote:
>
> With APPLESMC_GET_KEY_BY_INDEX_CMD now functional (previous
> patch), the modern macOS AppleSMC kext walks the device's key
> table at boot to discover what's available. The current key
> set (REV/OSK0/OSK1/NATJ/MSSP/MSSD) is sparse enough that
> several macOS subsystems retry-poll keys they expect to find,
> contributing to the same kSMCSpuriousData traffic the previous
> patch addresses.

> +    /*
> +     * #KEY - Apple SMC convention for "total key count". macOS reads it
> +     * at boot and iterates 0..count-1 via APPLESMC_GET_KEY_BY_INDEX_CMD.
> +     * Without this key, macOS iterates unbounded and every out-of-range
> +     * request floods the kernel log with kSMCSpuriousData errors
> +     * (measured ~1800/sec on macOS 15). Count is computed by walking the
> +     * list. The buffer is function-static so the pointer stays valid
> +     * for the device's lifetime.
> +     */

The applesmc_add_key() API's "pointer passed in must remain
valid forever" is a bit awkward, but I suppose for a single
key that's not "fixed data" it's fine.

Does the guest query this stuff often enough that the "loop
through all keys" in applesmc_find_key() is at all noticeable
in a profile? I'm guessing not, but if we did find we wanted
to replace that with a glib hashtable then we could take the
opportunity to make the memory lifetime requirement here a bit
less bug-prone.

> +    {
> +        int count = 1;  /* include #KEY itself */
> +        struct AppleSMCData *def;
> +        QLIST_FOREACH(def, &s->data_def, node) count++;

Loops always need {}, even single line bodies.

> +        static char numkey_buf[4];
> +        numkey_buf[0] = (count >> 24) & 0xff;
> +        numkey_buf[1] = (count >> 16) & 0xff;
> +        numkey_buf[2] = (count >>  8) & 0xff;
> +        numkey_buf[3] =  count        & 0xff;

This is
   stl_be_p(numkey_buf, count);

> +        applesmc_add_key(s, "#KEY", 4, numkey_buf);
> +    }
>  }


thanks
-- PMM

