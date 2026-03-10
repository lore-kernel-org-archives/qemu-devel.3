Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E971EB1050
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvQQ-0001M5-QD; Tue, 10 Mar 2026 07:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzvQM-0001L8-J2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:38:54 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzvQJ-0005sE-DA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:38:52 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso12232646d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 04:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773142730; cv=none;
 d=google.com; s=arc-20240605;
 b=ZjUg0ssBu6t+8UJDB33eJjsqL4tKFgiv1s0o/XKOkdn1ngpZ86dOq4WsGIDz9scx/H
 QS6t5YHM3LqtAmu97xN9o+RSCiHXqDDYGZU6lQC9TYo+eJJFRSkFci3JirynDVbCHhTx
 s4pOb7geVvrWw6qUWtlHFlV662cgDTFFJDWWTd+eHnA6yewBABxmFoxbfnCvQtGogs9m
 9nCYrrv0V2waSWeT+VBLbNdhHBFH1+ZNp0mRxze5jqfdjKj7KgA9NHevw3uyFN2Nf66T
 XEZ6ZczzvVgrGDHLSVgBh1b7jZQdvKT4CyhdcT1ZPOvx5IG7s6bLGUiArAv6jZKVr3p3
 YhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N9uW0+VSJgpYNyEWmSVrvxsJAu5yXG5HOtYTyPuKj0U=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=d5G4OtJTaidS6G+jb2qTUlzSwo+FkD1r5nBkgNyFMqt4NoWqEWv1zH1e8BuAYGku/R
 Hu77nH+GMynWl3/03lMMw0ai7vrd8ZGjht/X8OE84E8rCBXjJS7+jUxfXvppNwtjciAS
 rmOw/C/ucWFq7kIcBSQxSdYtCdEUrKxd6WYc8xzdwnXU0tMUPy0bR5Hf7NYOAbET3AUO
 LVMFwUXbL0rrBapsEiUmWuA/eaHt6YZGE7nQEua4Ycv0YUVWKVax52Gfc8fjJoAOXubv
 X2CUyFxWLpoG1sf6hmyPkO1cDlHJHBj2ZCg5Y8Rp8G1+uUDcZuZhCd7fx8Ib4d0oecos
 DreQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773142730; x=1773747530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N9uW0+VSJgpYNyEWmSVrvxsJAu5yXG5HOtYTyPuKj0U=;
 b=eFwJKPM8tZWXhy3Gn1WWhb0QpYWGNdNhrjOW4lOFPPWJrgVgO7JDsctBjd6dOAerp1
 Sbw49C+SOdA14uVaB5wamjTjCARnkymILhEJ8mLTvCdAvTJAe0hgc4vSPbJJQpflV8Dy
 GmGbgx3ptfoQf72wyofk3DnKLbx95modqapHPhd5rSko0uroPEi2MHmmajpLoBQmokje
 G+EaIp+oV02lrcTQrIMWdP2LPvCsPlcQ0cxSWqnEoDjMhcjNKxS4gAa8zvfyPvHdBY3P
 3lsrP0WQj5gwO+jh7Q52diNN+tV4fQCPmu9bHlNeN4DimiVde0ks6IwQKCdb9cwk+v+2
 ERbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773142730; x=1773747530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9uW0+VSJgpYNyEWmSVrvxsJAu5yXG5HOtYTyPuKj0U=;
 b=T5Bn6hzX9/jP1sZEV2yDVS+7fCD1A7J+8tpELTAeD9djukbXl6Rv1HLS/gNjcnuVCm
 3bM9EU4rtJXE3S8tJN+EX+6WK9C1Ml/Q/8JAANncmr4hH+nJe6WlDxL/pXczs+CLzz1X
 z1zCjzA+y+iy/6rND2I/BxXUvf6vb4qvSxFekCQ4vTxtSKOziqsMJIRwc++99wBVKkog
 cfEwfIMdZWSNfcgaB2bgrQP+d1YCV5YrSlyyZOL5hH13uORBTEJM1GJzd7udEBz/8WB0
 lKvKE4orxY1O1C/4wQuJV22Tu2ImmfY5c6XptXSnUM5gN7eSCW7n1/GZ7zIAyfWDmBxE
 2/tQ==
X-Gm-Message-State: AOJu0YyHMS+XeMVORI6qmXZk0hgk9sMyiCdSGy5BdX0qtglrWucaEyv4
 AwFqooN5HIkFQRfRcw0d6cGQweFmI/KfgUQ26EGu72e2lOCDfijgY4LhUK7Esxfb6uHAm5CXhQC
 SSvq4wRJYyMfmNsAw2U8u/XTy2H+dglBlQEQ3B1chp9ZKKhBoyA8k
X-Gm-Gg: ATEYQzzKUHFmJMufecmMeoEx2Vm8p+gGMxit4ZGSSMIaX/sruTp/uYFkuetVLGR914a
 oadKotsS26GENzPp7nRgyEQ9l6gOqEZYGoN3owkp65HfmS7Amc8jU7bd4nVTsxrwlRC57Xak6Zr
 V41WAPmWQlRJugJjb6yO+iiX9qtJtxwyV4/b8Z8WMq3A5P/ikN75ABRTGT20BrFYW9EjiINaJ/M
 HggNCPtCfiRDVV7YnK+b/7BdcFifrcP2lPU84aet94dwzpQ5pwZJ7IDtuUpulm+FgQegcjieLxM
 TXHEui7AqSgSKC9GRb5WLZqJ1QIVfRD2V8JUSNEI0muEVICrSLhUlmw4hlp1pcu+/Svz/tT/y+C
 xeA==
X-Received: by 2002:a05:690e:4194:b0:64c:b44e:dfd6 with SMTP id
 956f58d0204a3-64d1406d4dcmr12058096d50.6.1773142730195; Tue, 10 Mar 2026
 04:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260309185752.76865-1-pbonzini@redhat.com>
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 11:38:39 +0000
X-Gm-Features: AaiRm522QiFZMg7dUNRa7Y-6T4X2ZqRUCpdt8CEc_1N7ScQ7v3SCJkFYoBjhqW0
Message-ID: <CAFEAcA8ezm9Tpt=+dEnQg4yqiS4sdwtvZE_zCxQK1=Vi-6MPng@mail.gmail.com>
Subject: Re: [PULL 00/10] i386 and NULL pointer dereference fixes for QEMU
 11.0 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 9 Mar 2026 at 18:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:
>
>   Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6ef6a0f04e5ea10e5c9aa31de939e5dcdfe4a58f:
>
>   whpx: i386: remove SIPI trapping (2026-03-09 09:11:38 +0100)
>
> ----------------------------------------------------------------
> * hvf/x86: compilation fixes
> * whpx: fixes
> * xen-block: fix possible NULL pointer dereference
> * coroutine-lock: fix thinko
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

