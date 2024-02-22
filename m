Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3E8C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5eU-0007De-8h; Thu, 22 Feb 2024 04:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd5eR-0007Cr-Iu
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:45:59 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd5eP-0005bd-Cl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:45:59 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-564e4df00f3so3053110a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708595156; x=1709199956; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fUWkeQ+YBnTKPBrOP/Pql0PiGKTLeAJIB21hDTT2gPE=;
 b=ErWxJDs0S0SvIBb4d8WyOEqKwgTCiun7KHZO2mrXNL8XoE+07LgB5e3Bxx7tx0xhmV
 TITOgvnAb8hm6sYRyT5G0ZFOjI2P4QVAuf8fW8wTIDAlEgzfaFqfEQ0sDeVpjdAM1/np
 GWCw8jPxz9kcB6hFowH7bcr+Q3b7hBbM2wkV45d2DGN5w+/SO56hrfQBPEhD98LTkxFJ
 RHgmetfBWxhqCXvCjGeSY9fyBbk/uFvwNRlWo5bt4pRq+NJEnozSkSsbqtLyuMgHRb9W
 JiFyD4U+e+DEky6thJnhUJzuhjVV//ywVee6OLJ5TCrUCibaF44x7do8xv/pxlinDBuF
 OejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708595156; x=1709199956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUWkeQ+YBnTKPBrOP/Pql0PiGKTLeAJIB21hDTT2gPE=;
 b=fE85XSUoCHY8xcp/EVxM6umFgoKftPQjh2yr6C/a04BDIYkpK61SJ+LOsg41V7QsaQ
 7o30f7GEnll3sJNiMo0MZvmalAuKWkwQPHYcemAomeAZ5Y9eQYzuIdeUC0uSoT48qNFl
 TOZWnDU+7a6mAlC+zgpcqZBSjGWlrU9PaP6l9m1pgIOHAK1D0nXzxtQTVzCl0cjTT9rl
 d6OdGU6BCAYsME0dw6SrzdFNDt3GeLxWETQ5KgZsN0fa9yZ0951b31Ny1qUZpLSREqGW
 u5h3sLyBdls9P/+xkK94ArLEmbTfqzbVPYDmmRoJM7bW6DcYK4mNV0gZc3KTSLcjD8UF
 TfJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Mg3o9dRXoh5GtklooBCUm+Fm4zON0ducWrI19jTggCy/d3PcJs3gGF4xoC488Bs1W5Tz1fUZvT53li4QBIeHZ5wTGQI=
X-Gm-Message-State: AOJu0YyivW4M1i/1DIO+RCK9/FVbvkdyQuc6TJk8oqwSDTWyxvv5zw25
 YoHtedb9XWSHsThsnjmvAQHVsQztCN9FOba87NPp0Cjmqqu8vHY1myC8j3KuL2GfqELLejVarhD
 UT3sgUl97/NVlQivBGnLmbXPq1w8fFj1UCTP3YA==
X-Google-Smtp-Source: AGHT+IH0/Cs1VEb2Fpm7rVaSMSzHZXDJMSOY1bN32zPRduFm72ldUZ7DXjEtOo/ugrVm6Ds8+GX8YTOwHq74W3f0EyE=
X-Received: by 2002:a05:6402:3459:b0:564:f45d:1ae with SMTP id
 l25-20020a056402345900b00564f45d01aemr2984393edc.19.1708595155686; Thu, 22
 Feb 2024 01:45:55 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
 <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
In-Reply-To: <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 09:45:44 +0000
Message-ID: <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 21 Feb 2024 at 18:20, Faiq Ali Sayed <faiqueali.109@gmail.com> wrote:
>
>
>>
>> This is also useful information. I would suggest you look
>> at what the difference is between the image that boots and
>> the one that doesn't: is it the same format (and what format
>> is that)? is the way it is loaded on the real hardware the
>> same, or different?
>
>
> I am not able to distinguish between the images as they are in binary form,
> I noticed that the smaller size image can boot in Qemu.
> I normally put the image into an SD card of the real hardware to boot.
> so it is quite difficult for me now to distinguish.
>
>
>> From the debug info from gdb you provided, the file clearly
>> is not a raw binary file -- the initial bytes seem to be
>> largely ASCII text. So it might be that this image is in
>> a file format that whatever the real-hardware loader
>> recognizes, but QEMU doesn't, whereas the images you have
>> that work are really raw binaries. In that case you'd want
>> to convert the image somehow to a format QEMU can understand
>> (eg ELF, or raw-binary).
>
>
> ahh, that also makes sense, ok now let me try to convert the images, and let's see.
> Does Qemu provide such a tool or do you know any?

We don't know what format these images are in, so hard
to say, but I would expect not (mostly QEMU's image
conversion handling is for filesystems, not guest
binaries). You'll probably do best to look on the QNX
and/or Xilinx side -- Xilinx should document what
file formats it is that their boot process accepts.
Your third-party vendor presumably also knows what
format it is that they're generating the image in.

-- PMM

