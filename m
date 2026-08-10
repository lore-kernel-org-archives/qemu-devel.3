Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F4C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtKJh-0006yh-C4; Mon, 10 Aug 2026 03:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wtKJd-0006yR-Df
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 03:20:58 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wtKJb-0003B6-Pg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 03:20:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso1153107a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 00:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786346453; cv=none;
 d=google.com; s=arc-20260327;
 b=nb8jvs2r5SS3UdPU9PlMpJcQNi+InQ7CDrfiXEtNNmT3TMmDTJFx1uzxnkAGr5sLSX
 8aIhBOHRc3Jr5IXI+vT1wXHYLldjIEiQfbBLtPPId77XPokdnZhvsD7VQ7NvlmBLpwTa
 etJubwOOoT5gYHSnaQi8OvgieaqLTuqIh9B6zqsIUTHGf267zIJA+h7rZVLcqvQZ9g9t
 qWLmKUH7MoJDSLSK1W93nmpnXe/JwnznrZfqso/yl1VZzS6myEGicjDE7UZ998MVZIi7
 1VXxqoiBuI+1z7Az1qJ0qq/bN6M8gOgoXsHQ+pETzD2Ez6Ljw8BwBK9RIJxEpiPFdA9q
 QJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EnwuB1ca1PfPlmFTu/pTvg5KEPe08K1HKwMTGwwRhd0=;
 fh=wNIBB09whFX4aqH2z8BcDR9CesbTcDsK1XevePNeRLw=;
 b=AxWR77EHGXwJVCGKBUAOoJUnqrWsHvkhtxn5CQqseSxo0gWOkUIJ+MUfya9HEXZmPQ
 buoICRvHXTBdIP9mqi5Y+hOECbUGfcmFtvpxzEFY+4VzJC2S7ufFOp+ZyygTbEawXTHh
 v9B7cXxz2yofLfyQj12p5ctXntjhC1H0o3f4v6/cxqYvFHIj+YWtDsZSFCEQ1Pz5nxaz
 MlMUU+3Pokx0n3mT4p7ytJAjLwZLNbKFlsoRc0FXB8K47uBIZHlXT9Lj0MOPPwzJonkF
 Oa+HEQ2mQ1N5qMlW+ie6pyuOVSbatFAncxl2i3oTq3JCOSh55NPmEwL6ZIOp9qhYrPhs
 LiIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786346453; x=1786951253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EnwuB1ca1PfPlmFTu/pTvg5KEPe08K1HKwMTGwwRhd0=;
 b=tuam6Zffz37+A+efVZGq7+4s7fd0kgeEjfPYWSbNoF6SuwIiQl8OJWp/WrKtbvRtgj
 bxJDMHDuDPHRVGkxYnvOieSHwCGQMErg7e5ACJkh9FkQiPdemNtYPROPpHjNzVUjbT8o
 kZeVerbfk7fuY2t7tJU1dvoj2ut9asGwIwtmcRosefSqtNojrawC9IytyU8rwhYz/3jj
 cMQSnuMicdGCRH3LIVOkcFuw1D8IYxzY1nQ5gZyiXpRjMrspmDAij5kbTL76YkLObzWQ
 jJn9lPy4C2s+MtS6bsNAlgJBS/jI4WGrOlhDf52mgahivnFbQdvmjDYMz4Fm+n+baZr7
 G/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786346453; x=1786951253;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EnwuB1ca1PfPlmFTu/pTvg5KEPe08K1HKwMTGwwRhd0=;
 b=b1K+esILh6BRi9isy2VFt+y2WZ3kbUFVtFSQsANy3OtWWlXvb5mvyrHy8OYKu61W4V
 OJub7Yl6CekrTtk24KX1tYy0vKUHm5QpZ/2Tx237fJzRqeukUPRXBU/5Mb0tfGc3Fd6I
 7qiDcbC+Oi6qEEWHIxxUaia+jjKllcp8XOqIpySYbEnl9G/Pr8quwkcNzRIk2ogoCiGr
 zegxy0XLpwa1gKak9U2MP4JC61cRAf/xYFpXTsHIbnvrdr+bYqITC5oPoR2cUHFsq2MF
 ggGeDfd9yuHWAs0R53A4/Hl5J62cObD9aiNYIlSWdA4MSAxKj9zUdiJJ9lIif2u+rNiK
 yPJQ==
X-Gm-Message-State: AOJu0YxXocOManCutrheW19FuqCPRmU2rtLGlwmgLNWtOFPQdMZAZXCu
 RDdMu8xCIogyqKOdAzspKRQJEzC/1yk8LdidJWZvIdpCdf8A0+fFlHhAZILcq/fD73wOjjdI8gW
 aOD5g+PvG68oxd4KiJgnkg2zJRzYEAQc=
X-Gm-Gg: AR+sD10nAVMy9cGJ67/iKtnduGvboiSYPMPT5qTW1RGvGP31BY5MLs6HbReLt4ngi5L
 ko+hi3gSeCoJLEExyUDbuXrWDMlGuQr/yVKgpPUtO82fQ1fIedXDU2yaXvKLyoPg9QMQDZJ2YcQ
 UhG5O/IbQGqXoot0saS+noV8PiRhbHEYiEu5tmcWgwF2U/mbWWKjF76CpolUwYjnuwmuskvai2c
 u/U41TMZM+l6MChpE7UBflLm87b5FlwVdPbjDKVmXMG/JHHEYqZEVkbcn1N3MA8H6V6oWLTskwe
 RbFSLi1YrC3gbg24/iED9JPAyqzuOooBJE/n/3WLsuKWE/EkXzEDPkNjIFc1E5sxWM8BUEQEsl9
 TBTDkYVsO5z4=
X-Received: by 2002:a05:6a20:a11a:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3cbce8dd448mr18124478637.18.1786346453446; Mon, 10 Aug 2026
 00:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260807084050.526109-1-colazcyg@gmail.com>
In-Reply-To: <20260807084050.526109-1-colazcyg@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 10 Aug 2026 11:20:41 +0400
X-Gm-Features: AUfX_mxy9GgDZvWcIWxgxELZpYTOWyOzNXzW9cI6ywj97asFsj1yg3g43rM-nTE
Message-ID: <CAJ+F1CKxMw6FB1EsjfX8LT1GNm-a-PBHcproqyXrgvB0RbDwZA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] an extensible SetUIInfo2 design
To: Chengyang Zhu <colazcyg@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Chengyang

On Fri, Aug 7, 2026 at 4:12=E2=80=AFPM Chengyang Zhu <colazcyg@gmail.com> w=
rote:
>
> Currently, the `SetUIInfo` method cannot set a refresh rate.
> Simply adding a refresh_rate argument would break the method signature.
>
> This RFC adds the `SetUIInfo2` method and `QemuUIInfoTypes` property.
>   * `SetUIInfo2` takes a dictionary,
>     allowing partial updates and adding more keys in the future.
>   * `QemuUIInfoTypes` exposes the schema of `SetUIInfo2`'s argument.
>
> This patch is a proof-of-concept and it needs further discussion on:
>   * public API design (the name and the signature)
>   * partial update behavior (only updating the recognized fields)
>   * error handling (ignore the wrong keys or return an error?)
>

It's an interesting design to use an extensible dict for arguments,
but it's not very idiomatic or discoverable by existing tools.

Instead, can we introduce an extra interface org.qemu.Display1.UIInfo
with the properties and an Apply() method that applies the staged
values?

> Test results:
>   * qemu:qtest-x86_64/dbus-display-test passed
>   * qemu:qtest-x86_64/dbus-vmstate-test passed
>   * qemu:qtest-x86_64/dbus-vnc-test SKIP
>   * manually created a virtual machine
>     and successfully set its refresh rate and resolution via `SetUIInfo2`
>
> Chengyang Zhu (1):
>   ui/dbus: add extensible SetUIInfo2 method
>
>  ui/dbus-console.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/dbus-display1.xml | 17 ++++++++++++++
>  2 files changed, 73 insertions(+)
>
> --
> 2.55.0
>
>

