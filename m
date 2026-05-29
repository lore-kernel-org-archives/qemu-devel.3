Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B50CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 09:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wStK5-0007aE-Hm; Fri, 29 May 2026 05:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStK2-0007Zt-1g
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:16:06 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStK0-0002L1-Gt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:16:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd8d0e4e341so1972054066b.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 02:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780046163; cv=none;
 d=google.com; s=arc-20240605;
 b=RfchcF39KZBgUhWeVy1ShfQQvjj1LbRYGIkWRkkrpTR2J2WcyykYXy6k91/GImLUfw
 9YSmtbEv/3A3xwfpKdmyn0x3bL0kyyEYyAWU/oGCBM+WQTSw6VklGjI4NXQHyXzYFEHE
 dEwFZxaeYPFGsGsipegqVRD12kKdEqKo9HfT0PZv4J8Bvp0HKcT95EsGRhGE+lZYhdw5
 GHFWrUzlXjixUK8CA2Fd5BqqCroljU0ogphgqlJSXElgFz9F6ngvGS/0xGwJCUD+M7ba
 /fCegSNuaYt1scRC3jZbcIRzoLEYkzKG7j6P8JbJmgUrMEf2vcZ7jvYMJRPie4S6VOE0
 qsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=54F9QYUuejtz736fptjfaoI6erWLGJPXgsBAbg7eexM=;
 fh=JcRhxFyFrmTN6Obc6GQAPgoT9DxjCHw1HTt2ZdOw5iU=;
 b=B58Y2UTRgY/Qf9yhAZdjO28TUhHyj+yo5F5ZOnE+2FHwwMcqP+dWjx9ZCDnkqqJ6w0
 m26S7i0BFf/Bqg6LNI41fCnVXRX3U1/bz0/YAObtcJNf7jhp7ht6fcprAvhXTNVRlAJU
 NCMWJF4TM0cBSrDThDNCIrkOUk/Wh/Z4BJo4C4jfVby0IZWWndGu9dU5E7XP9u7uMWjR
 2Ad8iDXZktTOmHkcT179RYwNLlQq8SzH75lqqxPjJa3k2Y+eLe5TuqfRjUkwtfbbsk4G
 DgIoGcnLYZIsCHb4Gt7qNCMOZwMaWEaG+JtRtdTPNqYvWpQZ9d86QS9jWZPJYYc6pkFD
 mesw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780046163; x=1780650963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=54F9QYUuejtz736fptjfaoI6erWLGJPXgsBAbg7eexM=;
 b=FGe6Ora0NEBbvYTCvi0W7bsyGLFY5CqbugHMZupsgWgRq8X0ayIJHSzgMlWjwEo5oR
 yhPZbwJpYuIDvftsazlSx95e8uRuWiif//Z/uxhM8Hl/ymWeDPbroNuAIxprvF1ZVymT
 GDUASSMdNJyXsxPfJbIijC/SJQtAw7l3KPVPZ63YGlWUvv+SuoH4G3atqdUVMAGRPpyA
 CBvfMUuK4uFc2aPbfZhm5e4Qb+A1D/CsjzoqPO8mXE1zp1eIhljBRDsCXU6sk/JdPeeY
 500iNo9X/pwtL+ileYcAuGIWgIPOI3HMR+C5uKrBcAeeI8OUmAcGQnR4wHAnkaJVNHeP
 pBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780046163; x=1780650963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54F9QYUuejtz736fptjfaoI6erWLGJPXgsBAbg7eexM=;
 b=Esz+8A+ptXYkCa1HwdcXyjxF2vzd8L+U4jryFZ7X8Bk5yyFnXk+x3/ADXs9qLweXi4
 eaYolrShwtHFhWfutbz1T3LT0ulYmQfz3+NePrc1VgoZWj684S8mepzJj27PslaDK7FU
 PUsuk+Yde+tT+FNM9Gff9DrPVVmeT7ArSrJufMtHsBr0B7nyaaa13kyHpH4RixIWH+Ll
 0G4RTVFMlBxMlXOkUQCF3EBLN6PRRdPI7+ttT9jh0iyI2KIqVxxiQLz3hzW3/gxxG/EO
 svWXPKkX17cai/kuel00y4YcQkmDAGb8GYb+l0Ca5cIVyEPbvVBT2UvcE8gwUf2VxUFF
 vpeA==
X-Gm-Message-State: AOJu0YwrhvXmiT3dcIPmXmDCf47VE6WHeic7Fce7/jgvOUqusENfQORk
 qM20GCLrRVUXqjAuPL2JI5Za0EVGmD83Rb3tpfZ10a5zBGIF1QOfGCjE0NAGgVbZhodc4REht80
 7bTKvCUAR8MhOyqCrm+iq8HNl0sPI42CurMJ84kgIIQ==
X-Gm-Gg: Acq92OHU/imTu55oGuFY4i3XakvNE0AZNWWQErcIWpvfKJzGk3joBQJmRGavxvPL08j
 +dtDhN6uOEVBmVijrjeWymCUm3ZdEDV0uVjpLaRVibx1YoeYiTjcKTPey44Qqv0X9YNG2M1Nalb
 AyP01J0md4LJCxXtJQSUWbqktFJ0D2sI+wvVVzHo8fYqHb2K6WzTx3J3q61P2iCg0Z7xXAgHjkb
 QgUV92bU8rfpbbLU4mX7dpqUZPMCQ8HG8rtc6Aq8XH/I8EfS1X295iTpgOLk8BcW7EvTwB2tWZO
 PFudlMi/CHHi0gsNd1w4KAMJtzE9oB4TqaSJd5m0LhI9gXgE6KdvmRcsqUFQSyckOpkC4ZC23zW
 4ww==
X-Received: by 2002:a17:907:a07:b0:bd5:2e64:aef0 with SMTP id
 a640c23a62f3a-be9cbdc6f6fmr94853866b.24.1780046162875; Fri, 29 May 2026
 02:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260528093123.55403-1-mbawa@redhat.com>
In-Reply-To: <20260528093123.55403-1-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 10:15:48 +0100
X-Gm-Features: AVHnY4I6aPZ30g0OzQFo0WAdPWe1cMu90OpDQjc_eoZRkbCpmD5mGiZxJaWzadQ
Message-ID: <CAFEAcA8fEYODmPhbh1W=oPGvju-P=qWvN_dyWrPqAr-E9FK7UA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis_sysbus: defer resource allocation to realizefn
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, philmd@linaro.org, 
 pbonzini@redhat.com, peterx@redhat.com, richard.henderson@linaro.org, 
 pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Thu, 28 May 2026 at 10:31, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> Calling memory_region_init_ram_device_ptr() and
> memory_region_init_io() from tpm_tis_sysbus_initfn() crashes
> when the device is introspected without being realized, because
> the memory subsystem has not been initialized at that point.
>
> So running:
>   $ qemu-system-aarch64 -device tpm-tis-device,help
>
> triggers qdev_device_help() which creates the device object
> to list its properties, calling instance_init, but never
> realizefn. The memory region calls in instance_init then hit
> uninitialized subsystems:
>
> With CONFIG_DEBUG_TCG:
>   Assertion 'target_page.decided' failed. (physmem.c:2524)
>
> Without CONFIG_DEBUG_TCG:
>   Assertion 'mutex->initialized' failed. (qemu-thread-posix.c:107)
>
> Since realizefn is only called when the device is actually
> used in a running VM, moving resource allocation there avoids
> the crash without breaking introspection.
>
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>

This also fixes a memory leak that is reported by the address
sanitizer during 'make check', because we currently allocate
ppi.buf during instance_init and never free it. "Allocate in
realize and never free" is less bad, because we don't currently
support "unrealize and destroy a sysbus device".

Fixes: 46cd2c1050f ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")

thanks
-- PMM

