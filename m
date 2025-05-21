Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F437C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlSw-0006a3-Fn; Wed, 21 May 2025 11:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHlSt-0006YX-Rx
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:34:44 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHlSp-0005GY-9I
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:34:42 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7086dcab64bso64997217b3.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747841677; x=1748446477; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+gdPfSv/iUEZ0iV22CDF8Ccyp/t9XL8qu/hu9upFM3c=;
 b=ABRNvDZDVlKXsIIre65d5wDd71lHLjyEji9g+QIfothitvr1p1c8h0oO+j0HfNQpHP
 6WU9gYp3PuOzPF3KeNuRi8X1h0G+tRp8UeZgAPmXNFE4QgkwURSD1zhRmM8E96spHKj7
 M5uhylLkiD0TsCQCJ+Hs2Ly+1D7NzW8ag2ryngIKygLka+aLMINNPnedIUf8yCGUp2Qq
 vRWaiCaCRhEK42khM9WqUwIbuUcDOldqewobYJLzIOwepehQE+rvXuv5Zyqc/WbW8q2Y
 4sfqGc3OCk8II90INAy2wSAbbwrD71aE1UlFtT3LMlS89exQ62twNjlw7H2AX6zrLZ3l
 Qs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747841677; x=1748446477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gdPfSv/iUEZ0iV22CDF8Ccyp/t9XL8qu/hu9upFM3c=;
 b=d5x3GQOlysYl1CzyLUUgi9Ez3nyuo6Pr+9K54WiEVE9ZbBE1v03FmSbWEx+Nl6Nj7X
 ABVOy4AYpEpbmHi5GBn+HtmmE66clSAjrx4dti2Lq9sJqKRW7T2MX2wK76DCqIescP6/
 w0DQtwHm/ibn9YLG4sDMH3QqpfPyHLuAUWnc6HusEOTCgr8fmfjqqK1j5x8PGEzNqku4
 XhQsssj4+9SkrzlIb2/ZLKaJN/A+XKqrbAVn3N4EjBN54uHPoj7uV6DoBZAOhIv3iewB
 T7h6ijQ2lsBkD9CjVNfpi8tPzYmXboFX1PQpSK1WnjyC7EVMFQB+d0C0nuWtHFHUD+bV
 jx/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQS8hOemoCOrYeNwhWMIzkpzKH/EKjWqatY6NvU5Dx+pRjEEt0SApaiOJQ1p4ZLgS67WtMZOMQkijk@nongnu.org
X-Gm-Message-State: AOJu0Yz+CROvkcSx8tdoZAON6Q/lWWXDro5zEPNNGSka3ASUIKI071TI
 IBAjg7eH+OaKDElwiRs7/9FfL7ipyF82txwjASpeFY0BaPP8j+XonawcIpLBNByXdmq/RS9omqh
 EcnoCF44iQW6ATvtfwM7gMTu+PePUFgjlMRStYwGyeg==
X-Gm-Gg: ASbGncsstYwWuWAW30WK4jIgdLS7tF/SUI/ILdS2uYtMwoABMvrLoB7bwTSmfcVbP/4
 00be7ZT7tq4Q/qdJFSIdeS2OQQINHDzvuwT9ah15fIblOBcx53DOl4L9Q2+YWs8bAgXmCtcegl5
 NHbkyUwrWFn/lJVuPjLxttXkZavng3fR82wQiueQrhxOwY
X-Google-Smtp-Source: AGHT+IEqiXL6sJmJknJBdAC1ULYcGaNnm5HYbGP1pXy1iaNzcNYUc1xLSSbp7Nqah/VoVnRRgBYH7kqq4fF1v6YW5uo=
X-Received: by 2002:a05:690c:3686:b0:708:39f9:ae49 with SMTP id
 00721157ae682-70ca7b8b963mr288387497b3.29.1747841676875; Wed, 21 May 2025
 08:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-12-alex.bennee@linaro.org>
 <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
 <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com>
In-Reply-To: <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 May 2025 16:34:24 +0100
X-Gm-Features: AX0GCFtQTqAUvcQ2co9hZjymHoBFnNlqTY5AGz0B7rNw7UAqe6lSJQfx9Cc154E
Message-ID: <CAFEAcA8Mzo-Ne48=uFBTcy+CXNcnxGOaW941p=CRkD6gmC=JfA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before
 binding
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, 
 Kyle Evans <kevans@freebsd.org>, Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Alexandre Iooss <erdnaxe@crans.org>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Warner Losh <imp@bsdimp.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 20 May 2025 at 23:22, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> However, wasn't it already broken in this regard?
> With fccb744f41c69fec6fd92225fe907c6e69de5d44^ I get:
>
> [2/2] Linking target qemu-s390x
> /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function
> `g_get_user_database_entry':
> (.text+0xeb): warning: Using 'getpwnam_r' in statically linked
> applications requires at runtime the shared libraries from the glibc
> version used for linking
> /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically
> linked applications requires at runtime the shared libraries from the
> glibc version used for linking
> /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically
> linked applications requires at runtime the shared libraries from the
> glibc version used for linking
>
> This comes from glib, but the ultimate result is still the same.

Those are in upstream glib, as you note. We can't fix those (unless we
have the enthusiasm to write patches for upstream glib: last time
we asked, they were not against the idea, but nobody on either side
had the time available to try to write the necessary patches).
But we can and should fix the cases in our own code.

> Also, what are the symptoms of the breakage? IIUC as long as execution
> does not reach getaddrinfo(), which it in this case should not, because
> it is used only on inet paths, there should not be any issues, right?

Correct -- if we don't call the function it's fine. But the easiest
way to be sure we don't call the function is to not link it in :-)
Otherwise future code changes could result in a call without our
realizing it.

Also, mjt's packaging for Debian puts in some stubs for the
offending getwpuid etc functions, which suppress the glib warnings
(this is why he noticed this whereas none of the rest of us did):

https://sources.debian.org/patches/qemu/1:10.0.0%2Bds-2/static-linux-user-stubs.diff/

thanks
-- PMM

