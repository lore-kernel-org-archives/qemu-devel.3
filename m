Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A6BCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIk1m-0005hn-GU; Mon, 19 Oct 2026 05:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIk1i-0005fM-GD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:51:30 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIk1h-0005Xy-06
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:51:30 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab38a051aaso14545767b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403487; cv=none;
 d=google.com; s=arc-20260327;
 b=AEbgQLwGMMsK/OWfEJ8oQ+zP7XSQvpKTprqv9lJrwkkrZ+66B8IZLPl7c0SNIUKGw7
 h/QOX0IAwlxXkNWX/dehxyHe8E87Bt2y2ox4fRdulrW39dWhg6f29TOXPbN9YQLokpF3
 xbxEU6IKlOpFTxjSd5fikjv/1zP8ccyLKwBZAa/Ar5u3w1yfJ2CDsY85ekhu292gJ060
 wxyYPfaLsEvuBNswdKFFEoY8LlM0tqDPjswEwtNw/cNsbS8QUdGv0j0f6UFiU0jqk5sU
 9/gH1Y3vEEll53K5oequSuvMhU+FAvs2T5mOJat5UNh1cqdriGjP3e6HJ+MmKOruGwhc
 EDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P7E806DjxfRbv/n2wjlrZkfI3e4fXFSCMPVfe1YVOCc=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=WqWo3dvL6p8eZC3TW0sBGoYlnnmPjk35GrpIkZd7ZF3jf6effcbaEcD7QDFreY6Ahn
 Ztkaj8+XTp13mDHGIA9awwjINE7aOiA5EanlGq/fXnY3fZWq+BG6l7IIjnLdHP1d/7I5
 YwR3F6CECmf/z3ZcwRgHOU9RV9tsRrfHs5RO+Pn3JR/pRENBEFEWoUG2LQ2ZE/BGV5f6
 HVFoKdVNOc8hoTEJKApyte65a0w4aHoAT8bKnrgwJA7+jUfbTdfFi35l5YoChD5J7baZ
 eOcKlkvOwDAIQx5+0ZT5fkSdPyOGaCsAWvQPK2S2hBDkfyc9nIi/2OnFPTQbTRdLpjDC
 pnAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792403487; x=1793008287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P7E806DjxfRbv/n2wjlrZkfI3e4fXFSCMPVfe1YVOCc=;
 b=N69PBJlIEcwiZBDh0Lq0M9aCP8MUES+Kq5KJfGylV/efN8qRnYDIHriwCUquIaRoQW
 bUPTmAGlRh9bB614gbDrXJV9O4ij2s5sYKqd9REDVZYyxA+bblPaTNMAwGxAHDlAbz/y
 yA+K8G6fFyBmYOH42dlZ2lHw1J0/eWjrwDIFyuMW6FU3pxVQ4hCkRQ7hb96Yg4yfkxU0
 O18U/I/7xxGhV6cvmpBt2YXNRfSOnUMVjVFV5Yy2Op+1eMtKm39loZ6K5cKOdj5dl61W
 cNgyAgGVeB3MjUpvRXJ0itG2KCYXzgIx65A6wRI2to8/W2FgZdUrCOC+eT839YTD3juT
 c3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403487; x=1793008287;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P7E806DjxfRbv/n2wjlrZkfI3e4fXFSCMPVfe1YVOCc=;
 b=NjEMB+VjgefB25oJ5BMAKwg7SJHtXY1WM2RUQk0nMU8HjiOk7SB1xdR3hcFAIBYrWu
 1jBJ8QdvOYQ9EQVOi6cbH2QYArNFrUI6ZKxV6CHibXMr4wimkjLYJfnh3wVDAQxvAnBG
 lCn5rYw3C4z2VAYJtrQOmiS3v/ZOgk5U2JfzRkbCGd/Ir4wY99xg5NA9t5j5UWspjhcX
 LnLkZBklJUCW4TVZhxgmivR1/i9EGS75S6SqH2lOEiNxcgTGSv8iReNN5lOo37jwozQj
 VXoR5HA4HnIJgus3QZYS2sXua10c7hDL2QGLrn4jvkJBwmPMQJyhW3bIRWaLcXI3uvD2
 Zzwg==
X-Gm-Message-State: AFq9FYLczi87Oo3PqV4V4FEUQxWp3GyTnVrKniALc4vgh+1rmkYjcMfP
 4HGkPUMiA1jFZAOLCEIHIH7jy31T6b3Xuo+HD8A0qv5vTO00yPFuVuUB9DrQtPg9p4e6ixvD9OI
 ZADJqRZJDNfgXUxq8rgpuEx0FzXX3YzKObNOVx3Owgg==
X-Gm-Gg: AYBFou0Yqik5R/Q97K3n3ZC3fQQSxTzoHffruVr9VFmIjSwClD6YCqqr7vwwHGC7lgE
 cBeqv3as75qAoISH2PTCxddFFJiojIyN9526VUUTwVbMhs/y5Kpt+8YfvrvaaWWe0t8NNGwisDH
 gE0dnaz8dqT6MQKpbUpDZsXKVvt0EnUjAV5VFQqq34m67UMWv4oux6cS4r1d2BVKna3H0WIvaux
 p0CjkrbmZIy7X7i9LcTDvOero7kTBWJWZJvSJlDLLKANstvhZr9p7GoFT2V7+1GmSgl+AL+A92T
 2mVdxX5aMYuXLY+T7P2mjqCjVpUqcNpg9njRK9opjAxjjp1KXRwVi4X5/1M+dCiBhuVBmo+bdPk
 HaczoEFXr8vDFip+pWaKJwYcW5KEFLQ7XI8Yy+liAbnTHI9RNVQ==
X-Received: by 2002:a05:690c:2601:b0:87e:2404:6b45 with SMTP id
 00721157ae682-8b0f2212c76mr22544707b3.53.1792403487278; Mon, 19 Oct 2026
 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261019092351.2435194-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261019092351.2435194-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:51:16 +0100
X-Gm-Features: AclHuK9IxGDtAWkL0EaO4sM-VoH9V72P3dfM3RUORWBtSZ9jwNMX_44O7KpP_jo
Message-ID: <CAFEAcA_pL3mmfsDap9imp_+uAM6XmPQBp1jwSTPJ4KYoLWb7Tg@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: validate clipboard selection in Release handler
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 19 Oct 2026 at 10:48, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The clipboard "Release" D-Bus method handler passes the caller provided
> selection to qemu_clipboard_peer_release() without any bounds check,
> unlike the "Grab" and "Request" handlers.
>
> An out-of-range selection reaches qemu_clipboard_info(), which asserts
> selection < QEMU_CLIPBOARD_SELECTION__COUNT and aborts QEMU (with
> asserts compiled out, it would index the cbinfo[] array out of bounds).

Note that it is not possible to build QEMU with assertions compiled
out, unless you nobble the QEMU source code to disable the checks
osdep.h has that prevent you from disabling assertions. So we don't
need to care about what behaviour is in that hypothetical situation.
(LLM-generated bug reports frequently fail to understand this.)

>
> Reject invalid selections with an error, following the same pattern as
> the other clipboard handlers.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4717
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks
-- PMM

