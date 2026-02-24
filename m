Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8642DF3C9A3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuukK-0004fR-9U; Tue, 24 Feb 2026 10:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuuk7-0004Ib-0w
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:54:37 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuuk3-0000LQ-Ld
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:54:34 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79860421382so3981517b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771948470; cv=none;
 d=google.com; s=arc-20240605;
 b=AwfPucs/lzJZsXkgktxvrn4V/QqoDmm06d14cbkek3NBxnSXQv44SnLkBmhY+n/l/H
 2GSJtfdvjIeBdLESq9NjhHBg/Bj0lneIa/EOM518TDzjRyXDLDwxwf2aBjezavc7z1Rh
 r3RbDs3anB6bq4cX+dE5uqNwv1G5NPfHtMz/3lGyAQrSKj5TNmWeeDRu2gY+a86NRdDS
 rgzQ/b/Hgk4ibBXOxGUuIdSngzyZFqr3m1be3S1Vu1w2t09idckThjNg2K7Lyf6Y6JQA
 AifPNykinfcAeM2rpGHkM7Weanriil+PKGn1QAcxSYlOb6H76dMv/CiRwnVSKBOB9mh0
 K0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0/vzXuzvT0P0734Wh6U9qWt+r3Wwam94C15lFCAmbGU=;
 fh=qPX+D53ycrccGPIV5X2HYd0DvzZi+ohdE2d3+Y8przs=;
 b=fiPrVHNy42eldW612GzyybXtVkELGXiZ+UC0Ylz7N+0+nXhEJ4nfw9WTktS7d9l5h+
 +lHr2msgeCrlJnb1NeartKNUlVmhHWEyFbTUSPJeZ6s4u49CuPhJsYIbnR/IV9iQ27RW
 ncs32HOu3O/kQXrgTy9Ip7842/uZ8KAvYRwVQqkd86GKFo6hJRc6SGAv/cVIW9h6zQvn
 exeUFgEeiAOQ0gAFlpU3SDkPtjqi3xa1Admg8scvXB1dfIZEUH31UZukZtTFVU0iYjNx
 /YZ+LwpAYwNjAwfFUW1siqb/ZxGRvHlIFEdNy/RsAwm8+kKCz5jxLJtH6JMEIweLyOSL
 /jsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771948470; x=1772553270; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0/vzXuzvT0P0734Wh6U9qWt+r3Wwam94C15lFCAmbGU=;
 b=vO8S3Ofw4xL+Ek+sy7TjMrD6HrZlp0DFeDwXgjlzAxW+apHRnAvh/Hk3tr7g6RM88n
 Khb0imUFyECeeLC0kXGqK6PwOe9qe/y1NUgmCVbxTN0Ws+AnoPq9wmRnmvBWIIY5PUTJ
 xWfVgoHPgWU+pnK1O3odFYhTM2zs6EGxVXaqVCOfNe0G/R46iaOht2wrzmNmckiqrhAa
 dERenSekoPyz1k2mFPMktns8wyausuzxx+6ZzcV5i7vN6kvXouhF7iAVlyEqUWkCEzgB
 FpgFMfpN+C+RroB0BT6kJHFmKqjT9nTD+8GVRwG0Um7c3PaL/wqZTiwXd2V/qGhG+Sdc
 UjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948470; x=1772553270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/vzXuzvT0P0734Wh6U9qWt+r3Wwam94C15lFCAmbGU=;
 b=jRRA/CXw31LXUgJrbQ1Fj26nefiwXrZRWcQBjjHPwLwLOqZLA2DShQI4bpbzedale+
 dej0mXewXXaXhXC9KkE2ucVWazE1BqiY19MdhTJ2cWiQc7Q12HXeURv4JmVUp/GGudBo
 5wVMk1WanJ1ilnMnQ97bp+1S4QGwM6VXhF8Wvt9BdcCPNV09DiYrv0bFUBsd5zSDaKiA
 vzKNprCDyL6gZ4eSd9hbhoDa6yi8A89SwEdDaP98QoiI673YThHnI8QryR1j6gOcdGGa
 NpJRn8JKRSguOItKbGkBk6lQ63uSs0W43UQ0+hDOJiHE2aTqpKku7257IyT2KWmv8k39
 okAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD+mZ2z7vbWSBN3MDEnhKgl9P0LfdFSVqCqwkhztA1nuigYyLHJgtWKdmX2OKcmlGZKM1bqP9XV9H5@nongnu.org
X-Gm-Message-State: AOJu0YwRdxfvMbWNDYAO1WfWiG3ShP69qRk06WTSlHw81qiNN8LEo4TV
 1xCwX+zEmxq6XdjTzTSpu9rH/hL6MIvNu2tG9sc8I3BP85JMx4KUcAQ4VaP3A7YpSUt54mGavnt
 kDJAMJgno078V+y6V7LXf+xA6UtxppIsKCQUv2UzURg==
X-Gm-Gg: ATEYQzzuL0KvbYHOhm+ZB/wJZ4n5GeU4VSNANi4HkPCyuQqShXt8fOasbObRHQCMGXL
 mGnuEqYMgIxljn7+gG5MNWTCZmoaYlFaIih5M/lIYWjtReOS5+LgsJw2gMY/8j0RmIsLwuXGWyc
 R4VmNr7UKpgxfS44S27FP5wN4DklPtvCT/5G6zoQTA5wN7nCMD9RQ85Lc3zWpa3KOZfwWFmlX6C
 UdM0p2uno2f740ARQWDWq9FIgiIwVOwHI7eYm6zclRIcvRCMrAkLblfMb7JXEMbFSjdU0hM0/g0
 zUkD+qnFUn7NdJ6s7USywcNRwLlxhY7oEsPl7H8a2LAzniEbbzMP7+d2PCidSBooJL8=
X-Received: by 2002:a53:edc4:0:b0:649:d604:fb70 with SMTP id
 956f58d0204a3-64c78d3b33amr7877233d50.54.1771948470191; Tue, 24 Feb 2026
 07:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-2-tangtao1634@phytium.com.cn>
In-Reply-To: <20260222082529.491384-2-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 15:54:18 +0000
X-Gm-Features: AaiRm52ma_DkBuwNOIeoqbre3EWuxZ0lhNKERGxFpzA11xUwQTAlI448KUrCUW8
Message-ID: <CAFEAcA-L2oQ2p3nQVDcqpZSjhtU123Sep+ou8xOH-0jFug9LNA@mail.gmail.com>
Subject: Re: [RFC 1/2] tests/qtest: Support for memory access with
 secure/space attr
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 22 Feb 2026 at 08:26, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Introduce `*_secure` and `*_space` commands to the qtest protocol and
> libqtest API. This allows testing devices that behave differently based
> on security state (e.g., ARM TrustZone/CCA or x86 SMM).
>
> - `*_secure` commands specify the SECURE parameter (0 or 1) and are
>   compatible with x86 and ARM.
> - `*_space` commands specify the ARM security space (0-3) and are
>   ARM-specific.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>



> + * Memory access with MemTxAttrs:
> + * """"""""""""""""""""""""""""""
> + *
> + * The following commands allow specifying memory transaction attributes,
> + * which is useful for testing devices that behave differently based on
> + * security state (e.g., ARM TrustZone/CCA or System Management Mode in x86).
> + *
> + * Two variants are available:
> + *
> + * 1. ``*_secure`` commands: Available on x86 and ARM.
> + * Only specifies the SECURE parameter (0 or 1).
> + * When SECURE=1, uses the secure AddressSpace. The asidx argument to
> + * cpu_get_address_space() can only be 1 on x86 (SMM mode, X86ASIdx_SMM) and
> + * ARM (Secure state, ARMASIdx_S); all other targets always use 0 for the asidx
> + * parameter. When issuing ``*_secure`` commands, we assert that the secure
> + * AddressSpace must exist.
> + *
> + * 2. ``*_space`` commands: ARM-specific.
> + * Only specifies the SPACE parameter (0-3).
> + * SECURE is auto-derived: secure=1 for Secure(0)/Root(2), secure=0 for
> + * NonSecure(1)/Realm(3), following ARM's arm_space_is_secure() semantics.
> + *
> + * Secure variants with .secure attribute (x86/ARM):
> + * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> + *
> + * .. code-block:: none
> + *
> + *  > writeb_secure ADDR VALUE SECURE
> + *  < OK
> + *  > readb_secure ADDR SECURE
> + *  < OK VALUE
> + *  > read_secure ADDR SIZE SECURE
> + *  < OK DATA
> + *  > write_secure ADDR SIZE DATA SECURE
> + *  < OK
> + *  > memset_secure ADDR SIZE VALUE SECURE
> + *  < OK

Rather than creating two new separate families of commands
for this, we could instead have an extra optional parameter
to the existing read/write/etc commands, so for example:

  readb ADDR              # read, with MEMTXATTRS_UNSPECIFIED
  readb ADDR secure       # ditto, but set the attrs for secure
  readb ADDR space=realm  # ditto but for a security space

This patch has a lot of duplication of the existing code,
and I think that doing it this way round will help reduce that.


> +        if (attrs.secure) {
> +            as = cpu_get_address_space(first_cpu, 1);
> +            /* Secure AddressSpace must be available when issuing secure commands */
> +            g_assert(as);
> +        } else {
> +            as = first_cpu->as;
> +        }

You can't assume that the first address space is the secure one.
To get the right address space for a given MemTxAttrs you do
what cpu_memory_rw_debug() does:

        asidx = cpu_asidx_from_attrs(cpu, attrs);
        res = address_space_rw(cpu->cpu_ases[asidx].as, ....);


> +    } else if (strcmp(words[0], "writeb_space") == 0 ||
> +               strcmp(words[0], "writew_space") == 0 ||
> +               strcmp(words[0], "writel_space") == 0 ||
> +               strcmp(words[0], "writeq_space") == 0) {
> +        /* *_space commands: ARM-specific. */
> +        uint64_t addr, value, space;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
> +        int ret;
> +
> +        if (!target_arm() && !target_aarch64()) {
> +            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
> +            return;

> +        attrs.space = space & 3;
> +        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;

I think that because include/hw/arm/arm-security.h is a completely
standalone header that is safe to include in compiled-once-for-all-targets
code, we can include it in this file. Then we can use
arm_space_is_secure(), and also the ARMSS_* constants for
the space names rather than hardcoded numbers.

thanks
-- PMM

