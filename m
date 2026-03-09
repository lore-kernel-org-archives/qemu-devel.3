Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93574F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdZv-0007GJ-2F; Mon, 09 Mar 2026 12:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzdZt-0007FZ-F9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:35:33 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzdZr-0007XF-IG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:35:33 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso11600989d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074130; cv=none;
 d=google.com; s=arc-20240605;
 b=FPMVmBn9k3Ye4FLxDwb2SyXBNSnuk1Z3wROKQflpDqCDbxZ/D2nbSwZwf8OzOVlrne
 JfDyNEMefakw0jzyGCsqmDxsqqasgkHmOctoCQ3fHTEPjZiHePmMKHxo0MEBX5DhwAjU
 PhJWW7zEBpS8pyDkHPeFuIk1AXD8QctNexpTrp9eyQKidZbaGdII+X56CbEZiLIYIwLJ
 o/HD1jnKUccEO5ki6fZDV2AAL//1Q/aUgK/FeH0nH7bbNWpNVT0cl0DJO5puWD4Luv6Y
 blx3cgo2TmUVAVl7jcrZpL/QmXBO4dAjXEZiTcjWRLoXVpQYz+jgE4rHwatrtf9BfmwN
 M+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZSPm0Ofg0Eb4oVi8NOscKCN6Vf00mZ9r+zi+X/F4Qmo=;
 fh=QQmp9SZyJTmZ15k6LdEtWo32FSIQO8LxTBx0/Ev/MOA=;
 b=kTbfaDOwYueAABFiJL9i5bPvyjUibmsiKrycHG5D8zWXAHpgdydzoMtH1rju8++0i0
 h3Kj4uQZJwDlm2MQQdQ3QZr7tSA5hCwc4SFahYHxOiMnN2os+tNZ62gWnFbnuhFYoTL4
 nJ0Pkv3Lr8iehm3/zMJBeKJ1TEWspQA3RaDwvl344o3O/LOi9FMj/JlWLQKLHDd0gFg2
 TKr7Fv8eiyxt7VzqyhbVU/5OAr2OH0sDiUp8MRLx3sivt9qU9KRY4d0hKpxyio2okwby
 hDl400S9LWQ9m01qZt5C+7f8RoL1/O82YxRzZQ2Vkw2Tsh2uu7qWlTc73vAYc/zdk0qc
 k2Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773074130; x=1773678930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSPm0Ofg0Eb4oVi8NOscKCN6Vf00mZ9r+zi+X/F4Qmo=;
 b=vnhNDphAWYtNfUIm/3MdV18mLqG9T4d9iAnp9czuS7xEUtyEigaYd69ljcvMpHbjni
 o7/Xo55VP6pgvKHU2flf2drd6LpXK4/gByQKWIeNSygaBIAB/U8vMT+M2lNfbBje2KH5
 OX1FEbhuvfPVu/Ehqg6Z8Dhq+f8OMGKBnuyv9xv4m3eya5zrVFQ3FM55C/6DtwZXWtht
 BtNuLiAAd1g+TCTliy7QKwm0MFN0zXdLThP3CjGDf0x868q03ApaXyeC48iy3k9ultx8
 tCDlDVAfPgnfDttqUmvYW08/T/D4qL5Al7uNEcHCmEP86wDAcHHQyGFkaEvUku4VCIAT
 tCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773074130; x=1773678930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSPm0Ofg0Eb4oVi8NOscKCN6Vf00mZ9r+zi+X/F4Qmo=;
 b=QLhLLpNmfEuCpLt6CO7Of8EPv47KCCSuK5O6VL+auUz2F9C6onqDYY6NtHJX9PZufD
 PxYj5HAqV60H21QlSnwIFr+KMmKbhci1Pl0aNFeyAn4YTf9OVBavKC5pMlLOHAIuWmrx
 Epigbmm4Eg+mQihs3wFmmQe4hkDg25A3fItG/uGEFBqtkQUHkA/w0gbcDCWQey58PCAS
 88gsUTKxRfm6E/rqP0Xqo97yTzQMhzo5IclJ1LB6+wpHfE4pdIQlSZAAIEDUdsNa5VOd
 WcT6y1rEx4cAZhzSFGxJggAmjmAhz5vKSwFUAPo8kh8XHKaliTVT8i432jSnPvHpnJwS
 Xcbg==
X-Gm-Message-State: AOJu0YxZSgpUvuPiDJbq3Uo90onouH9ddNTuMrCoTkFuFeyflqfaHXHK
 I7iSFrUBuJqmu1mwIcFiDhTPuIWO1/ggkCsagybG81JT9bwCUboJEu8XiAz1o3zIiOvPCU3I6oN
 KlQlSmXOaW3Tro76jlkaaSRA2IHDd1M+lqZ8u4qhm7g==
X-Gm-Gg: ATEYQzyidAeizsKq7YeUKVsnizOE2TJUSMeinJA0wF3fjKIGe+/K3Nd+f9Zgi3YD8uF
 dVwe61/wbaWfUawEK5FXvPSebfd/GGiXkViV+B6JP7oeOIb9mpsJCSSzIhI+XXekqU9687e2Gi2
 xFhY5393lCVYg7HsmW0mC/XLJumYIug56MKaulhMFL63GemYoG3GYAEf5TOESklug7grsrQjQdE
 znuGlvWj0RJ9BDZHizE3X4TfdfIjoopuHHlh3BfDvHjOxFeSyXZ4vkG66s1wByAjUVU0ed9N9iS
 lNp1+uk4XJah2rhCkanETeryuSoac+pEBEv4cnuewxLDc5TuEiZSwNN/QQsk+rbp/xFWA7JC7BS
 A3g==
X-Received: by 2002:a53:e1a2:0:b0:64a:d18a:66bd with SMTP id
 956f58d0204a3-64d1407dabamr8206612d50.16.1773074130054; Mon, 09 Mar 2026
 09:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
In-Reply-To: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 16:35:17 +0000
X-Gm-Features: AaiRm51UH6YFQBYjBsqw0-TrMlPJDHOw8I5micKgw-T8g7-lbJz_4kwsXy2X3NI
Message-ID: <CAFEAcA_WAnfxtCgfhX4oGa7eJhvs9aWgsU46CGGzgqNfBX28Dg@mail.gmail.com>
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
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

On Mon, 9 Mar 2026 at 16:22, Florian Hofhammer
<florian.hofhammer@epfl.ch> wrote:
>
> This patch adds docstrings for typedefs and function declarations in
> include/plugins/qemu-plugin.h that were previously missing. This
> resolves inconsistencies in the docs, e.g., the description for
> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
> but code cache flush callbacks not being documented themselves.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>

I don't know this API either, so a couple of questions below
for those who do:

> +/**
> + * enum qemu_plugin_mem_rw - type of memory access
> + *
> + * @QEMU_PLUGIN_MEM_R: memory read access only
> + * @QEMU_PLUGIN_MEM_W: memory write access only
> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
> + */
>  enum qemu_plugin_mem_rw {
>      QEMU_PLUGIN_MEM_R = 1,
>      QEMU_PLUGIN_MEM_W,
>      QEMU_PLUGIN_MEM_RW,
>  };

This define sets up the values such that you can use
the _R and _W values as bit checks (i.e. _RW == _R | _W).
Is that intentional and can code using the API rely on it,
or must it strictly check against _R and _RW separately?

> +/**
> + * enum qemu_plugin_mem_value_type - size of memory value
> + *
> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
> + */
>  enum qemu_plugin_mem_value_type {
>      QEMU_PLUGIN_MEM_VALUE_U8,
>      QEMU_PLUGIN_MEM_VALUE_U16,
> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>      QEMU_PLUGIN_MEM_VALUE_U128,
>  };

In this enum, the values are set up such that if you have
a qemu_plugin_mem_value_type vt, then the size of the data
is (1 << vt) (i.e., a byte is 0, a short is 1, 32 bits are 2,
and so on up). Is that intentional and can code using the
API rely on it, or must it strictly use the enum only as
something to switch() on to select a length.

I actually ran into that last one in tests/tcg/plugins/mem.c:
update_region_info() has a switch() on this enum which (among
other things) sets val_size in each case, because I didn't
know if it was guaranteed to work to set val_size = 1 << value.type.

thanks
-- PMM

