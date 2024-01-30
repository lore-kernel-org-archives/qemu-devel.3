Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F746C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUsKU-0004Xq-UP; Tue, 30 Jan 2024 12:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsKT-0004Xa-Ev
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:55:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsKQ-0003EC-OI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:55:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso5127303a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706637319; x=1707242119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p7LoOCNtE0wfDg8BdtRJPFTG97kvrvzHEFWGa7ZFPSE=;
 b=w2eO/Rz6dxGfKN95IJ4i70684WEA6q3xQHhdjcKJ6+Ki06DmdDDB41nT0w7uD99PRn
 42bA5dPsoJfJPiHaBVx58TE2aEjpb1yieUbSFtYZz+JhTf59/QqIImC6luB/pwPqpL5Q
 yekiVpb78R8sTyaM11V2jZZBt8kysnDL73Q/1Vsr0iL5kTNBS40A5II1R9hop0nd04nz
 QHJvCS4op9FXHLm2tV26cTh3DCMQxSy0S0xy3sjMVPO8PFZ9vHjGA+6fbP48WqiYKaod
 aXz9b5ho9YTy2vUCqOXck3hNzVyue63IKh09ALGk83hbDfu7pgk8pXK7EeKJchM+uF/D
 WqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706637319; x=1707242119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p7LoOCNtE0wfDg8BdtRJPFTG97kvrvzHEFWGa7ZFPSE=;
 b=dXJk8zudbvkvkAkg8xhzx7Yn6tQ3ovjuV78Z6JiHJdOiBmO9WYlBHRKLeRgvQEHR6N
 QtCrcn4DyM7iSLmiUTiNJrtwvnCgdCDZhnRfkf4Zpyioimv6SuYOBXbZJ0tpqvRZeHhs
 9egI2W0DLaDEoBNOGVJCW8E8CZNA8CPa9fW9a3O4f1tARghcH+GOaF7ygY1WMY7IMRSX
 9U+msbDvxKrCy5lPvQf4Oym8cmj/T8bYmjmJlK4iTgTWMDHt09D5kHf1RdYGzAxMoa8d
 golqzmUwloCjhj8p4PnIlDJm8RxdowqDE6bC5fTZVCJDmBL3UH9X+P6mmIN0YWbnBgFE
 qE+A==
X-Gm-Message-State: AOJu0YzVfIgMijw7saxzHd2GCjC+EhtbbwQjvBjiZ3gp+4zCcNZlztlC
 gdFeSuM5p8/RSU7mGyNTCcrKgcLh1QNckOWbJhZBLnuG+MqoaGWGc0wk7uU4jFLpqQVUBl9Vpzc
 NB2EH6P9QyCdg7GHEpnQ8+nFwqRun0I/mKd0aOQ==
X-Google-Smtp-Source: AGHT+IFctFFFH0xsyAz3Nu0+KOVIYu5YQ30E4XIDkPVF3hdKaK8K/laFbdPyDDmPd8o/dVQ51o/nSUOQwz1gmIRRNTY=
X-Received: by 2002:a05:6402:22c9:b0:55e:f36f:16d7 with SMTP id
 dm9-20020a05640222c900b0055ef36f16d7mr4338396edb.25.1706637318956; Tue, 30
 Jan 2024 09:55:18 -0800 (PST)
MIME-Version: 1.0
References: <4114f7204e892316d66be8f810eb5b8de4c0f75f.camel@infradead.org>
In-Reply-To: <4114f7204e892316d66be8f810eb5b8de4c0f75f.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 17:55:08 +0000
Message-ID: <CAFEAcA8YYEufaT9mU=YaiUKNMP7-ARSs_QwRHsP5Y7S5KC3O7g@mail.gmail.com>
Subject: Re: [PATCH v3] doc/sphinx/hxtool.py: add optional label argument to
 SRST directive
To: David Woodhouse <dwmw2@infradead.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 27 Jan 2024 at 23:18, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> We can't just embed labels directly into files like qemu-options.hx which
> are included from multiple top-level rST files, because Sphinx sees the
> labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707
>
> So add an optional argument to the SRST directive which causes a label
> of the form '.. _DOCNAME-HXFILE-LABEL:' to be emitted, where 'DOCNAME'
> is the name of the top level rST file, 'HXFILE' is the filename of the
> .hx file, and 'LABEL' is the text provided within the 'SRST()' directive.
> Using the DOCNAME of the top-level rST document means that it is unique
> even when the .hx file is included from two different documents, as is
> the case for qemu-options.hx
>
> Now where the Xen PV documentation refers to the documentation for the
> -initrd command line option, it can emit a link directly to it as
> '<system/invocation-qemu-options-initrd>'.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---

This looks good so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but something has got mangled somewhere: patchew can't apply it:
https://patchew.org/QEMU/4114f7204e892316d66be8f810eb5b8de4c0f75f.camel@infradead.org/
and patches doesn't like it either. In both cases git am barfs with

error: corrupt patch at line 23

I'm guessing it doesn't like the quoted-printable encoding.

thanks
-- PMM

