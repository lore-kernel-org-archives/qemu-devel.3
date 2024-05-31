Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F7C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1sa-00060V-Vz; Fri, 31 May 2024 09:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1sG-0005wf-Cs
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:00:54 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1sE-0005Sj-LK
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:00:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so2455340a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717160444; x=1717765244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HwbPR/tRGD8gL5h/ZFbNIKc9eUoUQkWDmtW3brmsn8=;
 b=LJ1ZnaQTMBYVKHDav44vtCD4kKO5Dz9h+HUqXHJQuQDalxGe7U+6GuXuLh64CGdWli
 UojEjHH4fO6q7APHkjclE2zXyxNZqjj65i1gM8qvwlffzexMBCBGLJp6tobjkRcttGEY
 kOnufYz+QHPfl0B4pKt+7ThiHJGHGUDY8p1pGVTpL8dF3MmiQrUGzTH7kylry5nQPXtl
 oHF482eJNzfCVjeehuttsU+lpV4qnNDUz9NLxVd0+E7ji4gV/RZBKfZom0RNqadTfHYD
 kWprKFgUSbaloKLLmCV2dj/dQtGzNNOxgtyJu+eHabsaOhaxVBxf0A7KohKdZK6lvaaC
 21GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717160444; x=1717765244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HwbPR/tRGD8gL5h/ZFbNIKc9eUoUQkWDmtW3brmsn8=;
 b=YyAtPIkrycY8U4pUKraUsftFCYw6ssSwupisJ80p0ChrDhJhrsV+imeE13uFtYRflE
 YVaUMybNfJW05VvaSaI/OrvFTnCsFA5HNiWZJ0x8JZk3fM8GDjhRlKfCKZO4nrwJAtE7
 kh5NyRJ+cszyXzfiabH2zsWMJRvBxWoTSq6pRy8T/BkdEnZwItxcASAGxuiU291XALTi
 6c/0T15WAOF0VBRuvpXjIaz+Y/ps7zDauntR2qEl2T6Aq/iNDFULhUNFjTKxJhLUuMFd
 zixB89DwUwCGgnj1i94SqQr1q/9X9ISu5M+yEp+Qd9zw/TFeL/lkUClAVr5zymbWfnF3
 ZuVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIhumuzZ449JnS8g9oNVNC8K5DjVPChYKbtNVsGA5FPJw8nxTyt+B7zAdytVln4kwKKUp021/wlp/I/gOp4+WlXstY4Fc=
X-Gm-Message-State: AOJu0Yw8HRu7kYj8IA2ACOddpU53kKJbvFXlZJWBsvt+o5ZVh9z6Vj+o
 RLs5WtEYDv/l4+Vttylc/9E/ehOB3DUvACVgsUuJViufwI08nEHsmud5lRuGocRKwx77A8RKqAL
 2hPXaVg5I/bYApKISHkjixk3UjDsTJwlqmFH18Q1JNre7I3tM
X-Google-Smtp-Source: AGHT+IGryU9BSyAyF8TKsaUC8cxtPwsYYMwEOm+8r6DKuIVuKvGio3H3jOGI0Oc8s6GGHT96yyU2mv11opKUACo5N9s=
X-Received: by 2002:a50:9f4b:0:b0:57a:1aa8:b4ad with SMTP id
 4fb4d7f45d1cf-57a363eb091mr1471217a12.6.1717160444547; Fri, 31 May 2024
 06:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240513233305.2975295-1-perry@mosi.io>
 <42e47d17-1d49-43e8-abd6-76abdcb159dc@linaro.org>
 <CAFEAcA9t9t7R9FR9mwEssT8+7XVcaBdThetZawB+VmL+0OcxDg@mail.gmail.com>
 <8e1b7975-85f8-48f6-8c4a-063f465a7f91@mosi.io>
In-Reply-To: <8e1b7975-85f8-48f6-8c4a-063f465a7f91@mosi.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 14:00:32 +0100
Message-ID: <CAFEAcA_VWAumJ_0MEe8cd43ej9_jqnyo8mjPYuAfuALgEoge8g@mail.gmail.com>
Subject: Re: [PATCH] physmem: allow debug writes to MMIO regions
To: Perry Hung <perry@mosi.io>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, Andreas Rasmusson <andreas.rasmusson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 20 May 2024 at 19:48, Perry Hung <perry@mosi.io> wrote:
>
> Philippe, Peter,
>
> Thank you for the comments. I am not even sure what the semantics of
> putting a breakpoint or watchpoint
> on device regions are supposed to be. I would imagine it is
> architecture-specific as to whether this is even allowed.
>
> It appears for example, that armv8-a allows watchpoints to be set on any
> type of memory. armv7-a prohibits
> watchpoints on Device or Strongly-ordered memory that might be accessed
> by instructions multiple times
> (e.g LDM and LDC instructions).
>
> What is the current behavior for QEMU and what should
> breakpoints/watchpoints do when placed on IO memory?

Personally I don't think it matters very much, because the
user shouldn't really be doing something silly like that
in the first place. If they do, they get to deal with
whatever problems result.

My feeling is that the neater place to put the handling of
memory regions that aren't RAM/ROM is probably in
address_space_write_rom_internal(). But doing that makes me
nervous, because that's in the file-loading path and I
bet there are dubious guest images out there that put
data in some area covered by a device and currently rely
on it being ignored when the image is loaded...

thanks
-- PMM

