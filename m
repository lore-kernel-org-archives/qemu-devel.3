Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A19A10F92E3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cP2-0002qz-0o; Tue, 31 Mar 2026 12:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cOy-0002p1-IZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:16 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cOw-000229-1c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:15 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6501e465a8eso223698d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976232; cv=none;
 d=google.com; s=arc-20240605;
 b=GoVOP5ngfSd2OJPj+MAvEAwVRAmCSPymEKkfcZZI8uHBoUl+38TRuJzwlbMcC4TH3l
 mQSdf1a4Q88KEohI/iN8QpGiubZG24g+Z40+OZuEwxCWGuv36haz+USX42WYciVdsNBL
 snqLcmfn6i9eX+lWxY9v9rd9uaf3bxurEpyLhWewCNZQP4SWfV9qXWZ/d0TfxVC1tgYv
 ZWULlKMuDGRRqJ1PsklY0vd1aSYe5nQfWuerhfFnOk+8gQamqkJX00ydrLvKCEvS/+Tw
 8cfZx5hLKZ+HY1rImDb5Fcjce27FZMyq1+Mq2HGzTGXbLfJKCkfXTm5Y4k3dkNBym4qb
 Dsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hbzlaHUP+n9IJbngkTY3e6s19eYTVKdHkQlbfdmho+0=;
 fh=BNPn5plGW4iapFgomzvvXDa0mZylAFxlcZuJupMSfiQ=;
 b=GAN/PXU+drxTat5sgU0k+CN2RJycrrbCATCGjIrzxaEwwv681rV0DO48MkJ94Zep0u
 1CTpwCiERpmVnTxZObQE3hlyw5Zs9uPaQGZG7YtPCdrmN5VIy7hKPQXZDJfZhCpl7ph3
 0d15TompGz4G4TdtQpyY2NbYSo1m5dayRTPTmiEf07uyZa5r3PWX2+zl1QX2tTkMLJm1
 YI3f6FUoUzoJJNkAWcZRVpzAwLWZp1fRyeYzH8raNWrXp1aTys4sn6PilpM8VWJftm+K
 n7GH13N6YlT0F1J7kJ6LxQVNUk7TSDEDIx3qykiHrZteHg8nZehROb9LOPxvhDThfWOZ
 B3+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774976232; x=1775581032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbzlaHUP+n9IJbngkTY3e6s19eYTVKdHkQlbfdmho+0=;
 b=j3Qmvznda1xECWzcOTaaZX2f2AMI+GjMUUvZyD1YcFOTkiP1Zz1uP+u3pdwtncMph7
 urRdCLIoMcNA+1DvYWaUiH3iq2rebIWRrPQJbur6bcZoNDQ2vH8fbuqDjp0hH1MId29/
 +OV0yH+8KMgT1y0NjbhfNe3bc1k7/g/QifFxacBkUj6/30QCwYS2DiXGis9kOiEkgPIX
 v1sr6EIgjQpwuTi+UU6oWMISgll7X+Q8+ZYPtokJxVyb4gluIPCwDgN55wDYc3sMileI
 xwNqF8NKIX3e+9Ol8MGYgGLHi/qgFB+byBWWnygreI5zcnwoAbJGsJ5iGCoEZQH+NSWg
 +Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976232; x=1775581032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbzlaHUP+n9IJbngkTY3e6s19eYTVKdHkQlbfdmho+0=;
 b=h2vE5csp6NoEgPol4ZE74C8rrgyn9cR6b9Wy7D0I44sMOaPoz2D2748jURycEa2R7V
 Me7cd1puf5wiY+TQvIHSnn5xqRU89RXe7Oes0rrJT+k0CLm90uUkV+26kzEktEcXsj9V
 07wWlzBNW4HM8tuX4O8m7mHMSZGDDYGMZY/Uglma3dwlhWxN63IYbT1b1tiqeez9Dc9J
 mWJsJzMmLBszmC2/29xI1cz+G1hqKX9tfW93GWpcsgwfyTdV8q/vwF8GlBfwHGkuTLw+
 Z2hBqKB5IBZ7bMZU5AUGblaoRSjzpQnbc/7TWrjBetTdwkyekK7vSBSLwWYlDesP6hk3
 PYhQ==
X-Gm-Message-State: AOJu0YxOznM5d7S2FNaJYKZc4ybxRb/EaCA7LwsLwgSG9JnybCGX1KFc
 p24sFnr5/5F5rc5UReRRStHDKeahsdOP3UeWn+FdE60zv+gCTsIf4abbRCpe8mDn+3UFJRvwuIp
 fLBPGLlbHxcknJp67o8MbWj3Io1pOOjovKkvTqLkdnw==
X-Gm-Gg: ATEYQzyl0LQtNvP04RcyWndFbtF0o93m7IcAjwie1lb7+pIODuKVunvUkshYCY7p/al
 bDnyRVet3NQEhKxykjbjkmamec5RQIlaW04ZjVr94JVk3GocYRQEkvsImaX2uN0kYgfGGt21E2a
 4J9OxRRdm6qAY3fZKvdssZUIE0Tj6HL2XN7HkLEncjuZS81mob6aWnDXHKLsmq/yEzZks8SG8U4
 NqfP3vvxYNBhzAnjrcHAZOkNzM2DbLhTqpbOJy1NSHe7joYqwfPQShMtH0M42lDuE5R5MIncJ4q
 J9ZnP48CFYbYU9mkxqilAAYuK4oUjzqgOI4hcVS2axOrWKBHk0E9HtL6m3tFy7NtrLs=
X-Received: by 2002:a05:690e:1591:10b0:650:20cb:cfc8 with SMTP id
 956f58d0204a3-650265fda60mr3231209d50.16.1774976231597; Tue, 31 Mar 2026
 09:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260320111647.138984-1-shyliuli@aosc.io>
 <CAFEAcA8EgLD48QASJCvLUGjmHDdVSFX8=cdiyHpuxaqmWCnNig@mail.gmail.com>
In-Reply-To: <CAFEAcA8EgLD48QASJCvLUGjmHDdVSFX8=cdiyHpuxaqmWCnNig@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:56:58 +0100
X-Gm-Features: AQROBzCUnuaByB_9rZxWR1C-gYWMYGmPQdyxEuvD-G9GwsVe1RgkO6dDDy8TmPM
Message-ID: <CAFEAcA81fkSSoEiXKFAtdBi9v1CoxoAHoLt2oE3Nmb7QuUkKkQ@mail.gmail.com>
Subject: Re: [PATCH v3] linux-user: update select timeout writeback
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 20 Mar 2026 at 11:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 20 Mar 2026 at 11:17, Sun Haoyu <shyliuli@aosc.io> wrote:
> >
> > The Linux kernel writes back the remaining timeout for select-family
> > syscalls in poll_select_finish(). If that writeback fails, it keeps
> > the original return value.
> >
> > However, QEMU only writes back the timeout on success. If the writeback
> > fails, QEMU returns -TARGET_EFAULT. This can lose the remaining
> > timeout and change the return value.
> >
> > Update do_select(), do_pselect6(), and do_ppoll() to always write back
> > the timeout to match the Linux kernel's behavior. If the timeout
> > writeback fails, keep the original return value.
> >
> > Tested with the issue reproducer.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343
> >
> > Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
> > ---
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll put this into a pullreq I'm doing for linux-user patches for rc2.

thanks
-- PMM

