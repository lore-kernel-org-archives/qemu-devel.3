Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86900C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmnW-0002jS-0X; Thu, 09 Jul 2026 07:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmnU-0002ha-4c
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:20:04 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmnS-0001Gw-Jw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:20:03 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1720047d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783596001; cv=none;
 d=google.com; s=arc-20260327;
 b=IXYycu4zaXLvVYL7ft0JLwu7UjqefqVsJ+t28PAoR4/w9fMF59sfoX3VH5SXGAwoi/
 9M7zE8wJBiIKwrTeUeGWoR0pNNZmqgEHin+kULIznyz2pzAfHX4FbQxMT2mSrc7M2ziP
 IRuelfNnua+sw67Gcnl+3M7+WPua9ahEmyf+dcwFcG6bOPy6U7/h99kM5Zrji7WYBjuY
 5AvlJbHN0u4xebdeOQU/c/0b3SLtYSm3ALqvOPCK0oIW4mBC+bdK4KYlft/+srA8XgVt
 LkIqhLaL9Z//vydUzrv2o1b5cBJMxDwA4nlifvgPi7ID6xD/oyMnHQI31TSj/3LJp09m
 XvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CCHk/EOcONFKt0oKJke0FsCC0xT1JGWrNSNs0RwyT9Y=;
 fh=tiNDaFvoog2kFPO+nj9EkYzDgF/523u1Vj0qu9MWNDQ=;
 b=iB+qux3zbr8wNoVTC/aMh6PA5fJLNuh2eAA86QJG+DBxzXcb7ZBPo+A3x+Uha8LDJ8
 FTdNXtFWic45SH6MSHmwAL4JH4QKNF10TNASMefvtO0VhhGFBMECjrNNC8KF4q4XnEyN
 FlvY8A4I/uSPCDjDUylQJ+U8XqXMVvmL1JZhkajvpRU67vyVAvRoyBRVoSQkNBvSduDO
 6G5m6iWoBnjb+Nax0Yl477cyK2F9kTaOaRnWwrzUUWVu0qFdXlE5JmdYqF7ExLa+P7F2
 Z/NINB1N5v4NHL3ERYEV+4cKgG6GGGdsTwjavS6OuaLXOwiaFRobnaqCASYnoe0qyNIG
 Zr3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783596001; x=1784200801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CCHk/EOcONFKt0oKJke0FsCC0xT1JGWrNSNs0RwyT9Y=;
 b=QzgfuVeyP1heUu2uwCtsv/5sv+WJft9UmSdRHDu5a/oi1kYw+zSOddXJeI7ylvdv+n
 TVOGiyb9gEH/n1ZVnLGDG0nCWcghhn1l0P9yLCi3raI5agmTAz0zbZs1PeeQf5efz/Lk
 0YgNJ1WA5jguPQG/Bw0SSMZykpCzEXKv00dbM77IcicQqSsPInsKVO0Y3VQBmNgg71o8
 /WnrNQjj/sjAUyuihOmMSdAe800HiU6tHW+BZ7LyL5xooME0ZoIOMaKyA3vW8edM327T
 NI7SUdxXYP5v1JtCw94FtVefqE4e5e6OUyyRZtgFQ1zvfCWtFwwcNYW52kySxZ1KELsF
 C6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783596001; x=1784200801;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCHk/EOcONFKt0oKJke0FsCC0xT1JGWrNSNs0RwyT9Y=;
 b=a83jw713tG8b61IMoIvPYO+jpFHLyb2cNqdNyirnI+z9nfLKA3jTwhgvcNBQEoPoPT
 avY+rxgnPiyAGr8/mVL6oh+GgrGDhN0eEGNdzuEidAjv+9dd9CLSDAyXkSBQRDZGftmr
 tjU+J4JQuc5K+aSVyGCQwn6OzucExAhEGg5T9IhhzNICx64/riA4JOpcPWLCA8LY3M+D
 GYVJoA/5wWCcbA+EX9YqsSqKV6G2qvcAJwSbIRcqnUTszNeKAPEqqvDF+x8yvoBVS17K
 02HrfA6dxUaAVTGCNJ9G6Z9ODbIs/8DCtJrxdqKXWHPFs9r5OYpAQ9OwXK2GUT9M2nof
 OCPg==
X-Gm-Message-State: AOJu0YyokHuz6R5VxQE9GThg5ve1w6b/UdfyOHLW+gqJNSk6FPswUBF7
 hXDD0cAyBasFBKpSqnXwolLF19d9tGf7EdF1T+fUSjjVzaaZXVSiX7fgkiIXLIeog5IrhgC68HO
 IsHdv8psZQWATo6kbKKsLlR3Y7gQs5z9axJDMfyUK7Q==
X-Gm-Gg: AfdE7cksjk1BgpBx2pVSlafy11LhzvbryrpJWQDF9+Y6ugAaGHMlOUzkqVCwMe6l++I
 s1kXXgNZ8hXw67JOdsEeFDBH6lc/d/QiGQtHC10sQt8SuW03aAWEMwwvMyxh6BylXfTYRvnfddU
 ldInhgKy6Q+yZ6ho+7fwalJ8YadxW7rYplRK02pYm0NLEezz1VUhOFRaRrFRkrrAl5By+VlukkM
 hNzU+cWASqYhqqn6xopSWV1PJDxOh0SJON0yPHq2iCU/XnllNGArgHmj2P+UoFHjo227HiaPLgx
 XrTi/4Z1caFpGxOY/06vP9zQtS5HI0ysvQdJgfErUqVRHtOxslfS1Crv
X-Received: by 2002:a05:690e:128a:b0:667:ad6a:deb1 with SMTP id
 956f58d0204a3-667ad6ae4b1mr4072168d50.49.1783596000557; Thu, 09 Jul 2026
 04:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:19:48 +0100
X-Gm-Features: AVVi8CdT6tlX4Mr3pvenaEVYKZeSkpjpS5QX-JFXNy7s0f19P-9hi8iFDU13VME
Message-ID: <CAFEAcA9HhtE8NPQ1ZTAk5qr=GHxf4SyDZpe7s+g=A7mVuL52Yw@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine: fix fdt memory leak
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Jul 2026 at 12:13, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The MachineState fdt field is allocated by various machine types via
> create_device_tree(), load_device_tree(), or similar, but was never
> freed in machine_finalize(). Add the missing g_free() call.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine.c | 1 +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

