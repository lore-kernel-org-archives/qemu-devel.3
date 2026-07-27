Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5C3C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woI5B-0007Aw-0e; Mon, 27 Jul 2026 05:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woI55-0007Ac-Fb
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:57:07 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woI4y-0005e3-BM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:57:04 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6682259cb3dso3832880d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785146218; cv=none;
 d=google.com; s=arc-20260327;
 b=rk19Sn32NNcPsKkIIuA32nmprLAXwkwBeBJt3xBEHqnE7QGnvSaaXYbSiLrBt2WGe6
 g+cc8u+PETuJpiRM4Y4BhmESVRCNq617K/Jjgfs/qRIOBaB4m9VInUbTD/3f6jzTy5lU
 e9CzrzJErGWQy8++upa/EvTAledbhgDyyqgipQqOzCs9tyJ1kheEiNZhgkzddDvyTjAR
 Gm2DebiJifxGx4f8ijpictUG6TqadIWrtD1Zcbl8T92ojutzv1cTvYPPnSJaKPuQn1Ey
 +Iogx7/XBOS33OfeKKj7A/6oGErT1NTaA8IlhWhcZzuOZMBgSDS4zuoR08aZ0xaHXg9z
 lhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6DZggg8Z++kZsiW9bFSUYxgoJflfU1TRkOMiNDsIkXw=;
 fh=nDTD0jckoa/dG2RhAiSu0cD5PekvlhTbGpKqj/M4jwE=;
 b=VD0vX/37ZzA1ho+7lC1h8E+jABmyKQnvgK2TfDpgX6SNMaKQc7UAw3EB0hG+xbx8KR
 qHI7huuYYlMXhsxn5OdI9rymLNoxHYvrtRnUtLWHxUrsH/MdNIkKhJqMEaBJpHHfUBeI
 MxdCiFM1jAhPuf2E5cYRKFhbT6FD716f/GIcgF51MrsamtogprRgXsj7gPslldt0DxG1
 N7H4R05lxZtppgD6W8D3WFdYIC/InP2tR5s5QcCo7ZzZUc+ErNNKTqIVJ0kzSOwwOT+H
 8R+wsPO5sXUJ41Wy6TNw9IsfiUmqtKn5rMmatmr4gybbRAaUvc2FwfmkrWy7NZ2WJQIt
 UUmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785146218; x=1785751018; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DZggg8Z++kZsiW9bFSUYxgoJflfU1TRkOMiNDsIkXw=;
 b=fvZ9ITkbq6e7lE/NakqgBeGIsZQtGLJuU+xrr+hRFZAetI+FDa6twC0JXfRjV400EF
 AEfcDtxME+3irPrKd0ThFoKWOiqq30WjMk9rTKdA4QO13gfP21XT+AcWmAk8wlh+au40
 fEGCoAaLySy2f/wTDWV0pMsD3bBj+qc3Kqs/jAc9vXoknJjVUF505/dYZP1GI75QIF+s
 DkdoA92Dbe7TocvO7LquYbLAX/uO0tjnzrh9Ocw9MP+odWuLHCM0l9TH9q8CFKfztyYh
 H+wC6XzNYNejiaw52wf+l/8p5sgHhjrs/1W3rrMtY8Whd+d+SW1skCDgEJyRlOEPJnCs
 BXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146218; x=1785751018;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6DZggg8Z++kZsiW9bFSUYxgoJflfU1TRkOMiNDsIkXw=;
 b=MxGIWAP/CCcPYsm/Pr4RXvjljNnVlL0f9ABT9pWGGIGu4aO5ep9UnJPYe0IxUIhqvD
 weX3vCaEMhE8O6EitjNoWRLqBurn+KU5AS/qOVrI/0YGWFkM1YtDQ3RS9pB3GcgD1GuP
 XYZH/l1K1O5oJPtAe5nsvGA/GguiduOHTEQQa0EeQg8pU+w5nUQkjdEW8bBoQO+46tvd
 DWls/Rg/3QOswziaujUcxgSH4OUHssc3KDTPKrEVasCThamIlgYLtFt2FHAZjUdBK0dt
 wA2o3ZbuG98vAd3nMQsHmCNmRSNOGXuWfx4ZQHwP+HTK/p0mWoPE1psiAbTBBUDDqlJX
 6JMQ==
X-Gm-Message-State: AOJu0Yxvnlr9WdjGgLlhyY/ETCflI9Al0PvQt6hbNS3k10idWdFBtKWG
 /jVOb2efm1QJzycQQDHcf/ttsTu77Kh2hLkhCud2oBRtRYJLJpDSnut106vw7dQZBebOGGXyBv9
 +AMGm0WdSQ23ItYNVNmjGIljENGphYNMb1q4xlKeyDw==
X-Gm-Gg: AR+sD12YkmfMYh6nDaSkgrSzJvDwEwmttAXfrbHSsIMvWEGwDASMeiZ1NqdSUcUuUvT
 WTT336g9QWLNFabPcqldrrDdMizN9mJyTdGWQPUYR0E8dQ4H2Sqz+tZGwenLSypvpv+cLWkP49G
 Vq2IhT9lYFTEa2pxCxXJiWnr5mafLJywGvfgStO1500ik5sXSvuPQuvRyR9SBPtJRcuYJtt5R/r
 XRGKi9XTynURw3+fyf2DDtcBnt0lokCockj3IUzjvVFXluSmO7xKsdqfZu60YGHBP6Oe0g/yyH6
 7OwUOyEk1o3MHiK7KM4r363QWyZV7WMgI5iB+wjEYync0Q==
X-Received: by 2002:a05:690e:c4d:b0:668:432f:f785 with SMTP id
 956f58d0204a3-668bfde0394mr3100893d50.22.1785146218419; Mon, 27 Jul 2026
 02:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260724110933.629791-1-thuth@redhat.com>
In-Reply-To: <20260724110933.629791-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:56:46 +0100
X-Gm-Features: AUfX_mx4at_lCYWCbKIb-vgnUZU1qSbQtXDVL1gpQjsaZvjMFL2NDjbc3AXD0Mw
Message-ID: <CAFEAcA8C6vBF_d5VeH23cqU0OjmQNtn9YqALLD_sD+t0YvgG+g@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-xhci: Check return value of
 xhci_xfer_create_sgl() for errors
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Feifan Qian <bea1e@proton.me>, kraxel@redhat.com, 
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 24 Jul 2026 at 12:10, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> xhci_xfer_create_sgl() can fail if a guest programmed the XHCI in
> a weird way. The current code ignores this error, and this triggers
> an assert() shortly afterwards:
>
>  hw/usb/core.c:612: usb_packet_copy:
>   Assertion `p->actual_length + bytes <= iov->size' failed.
>
> Fix it by handling the error correctly (i.e. return with an error to
> the caller).
>
> While we're at it, change the DPRINTF statements in xhci_xfer_create_sgl()
> into proper qemu_log_mask() statements, so we have a better way to detect
> this situation.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3786
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

