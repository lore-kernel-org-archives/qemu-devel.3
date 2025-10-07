Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2658CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67lw-00014B-Ou; Tue, 07 Oct 2025 09:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v67lv-00013g-HA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:30:31 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v67lb-0005EX-HP
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:30:31 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-633b87e7b9fso5898643d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759843803; x=1760448603; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XokmjZ8oq3/2bYw0UiN9n0JoW7H7ON4ZIN3u/IZivwg=;
 b=raxOwnbs9QqTm9z+So5CEYk8a9VlRTDDUTpUENn9FH3F3AdibvJ3bnL5gnYWKJFenL
 NZfeg5YLnr94Ba5e06PDvBwFBsRWJNq91nb38azXHZzuGl9mEJpTug8keGwxHxLX2Fkl
 1+Z5G7UOPefDHJkq0jco1ZtpByToGwIy0KU7tL6cvLcNEMNCxSsxeTCpyPJx6w3Uzeqc
 rRBIAMz+kvqc81mWsZF0xezaQCnvwiQbb8eI+q7clA60KehgLndiiymNZcGZh5usjiUx
 O2s7nrQRalACK/RnXR0Ct5YnqA9OzNEDUn7doXc0ZsSe1uQh3FvF4Z024UpWz6yVk2cl
 eaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759843803; x=1760448603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XokmjZ8oq3/2bYw0UiN9n0JoW7H7ON4ZIN3u/IZivwg=;
 b=JQO+VSJ00KKpz6XLxQfefgM09MQ/7xQo8cyDHl78uhMgPRP47zD81/xg5ekr+DBXwO
 0/AQR7+4cSROAspZ+0QsOW8DVeUM/kErN9wvrl17UM7kYZi7W7NCxqi2KmabtAGmkYy5
 xtlLewt9npC2RPQRqtINPfflnjbjFQp0M0I1I2Zt34bB/oGiK7zKUaGiD/A0C2dyOmfC
 JiJyg/YXMYTVZyyKnO/c/gjyvlvphePXoQeMXcP7oJ9Ky5qLmCHASf8XmrlzsHA9is12
 YBRwimZcFDX7cChTkSWktZTL1VInyk6YAuknBkgH3Xr8uHflH2ihBYjiznT2ceZixQ2m
 osLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV1Pdgqpqm648U8v6fE8HiVjaurXs2DzdqPqIYqvBI6SgDVHKD0Q3p2+oP5bTO1DNduzNiXZkZh5nH@nongnu.org
X-Gm-Message-State: AOJu0Yx7m7JipO6gNj85fcl8BnLHXdJKoTsz85MMN1o/rANb/M3bLtUl
 Wgaph8XclBs733/cUpazqRLmDA9CSq6iH8EVAyAJI1iSGIZojnYCrkR6ZKGbfWHiehCx73FEuf/
 /tq7Fr6bCfxPO4mU9YsiDeh9+1pMPJ/EOEJD92UwyvQ==
X-Gm-Gg: ASbGncv8Cnl/nj6Id15Mlm5SXQjkKuqU6dmU05xBZyDkF5Bwpci4/ymUa79lXA9BdmX
 LgQiq6GPJgUI0XdD3z1UZoBi5Mh8FjnPhj6CgSSraOZW83l4gY7yU79ezZmP8cRa965DDB2WTAg
 DhQk5srjuPJh9+lXDlJSX/G/wOFdw0VR7INNiEr7KsPduniq11xMqMoSInpM6qKv5rnnlWF6xpx
 zy8jlCUXDs2B+aDq7jgB9J2xZM/8LMxe+xc
X-Google-Smtp-Source: AGHT+IHl+UEk2A/FZ7Ita8OHzj2+cnVVknULL2V9W1feEuLDIRsHNeZn22pel31OgdVHlWQzEVX3y4bFVmJKiQ1qjpU=
X-Received: by 2002:a53:c80b:0:b0:62b:7d25:1914 with SMTP id
 956f58d0204a3-63b9a072d13mr10896073d50.3.1759843803526; Tue, 07 Oct 2025
 06:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
In-Reply-To: <20251007091214.403430-2-vishalc@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 14:29:52 +0100
X-Gm-Features: AS18NWAGHCbgiHbWC5yI15QHOWycXZ-O7mfiz1KJbOAasKj0mBZi9Jqf-BA65UU
Message-ID: <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>
> When QEMU fails to load the kernel or initrd image, it previously emitted
> a generic error message such as:
>
>   qemu-system-ppc64: Could not load kernel 'vmlinux'
>
> This provides little context on why the failure occurred, which can make
> debugging difficult, especially for new users or when dealing with large
> images.
>
> The new messages also include the configured size limits (in MiB) to help
> users verify that their image files are within acceptable bounds.

>          if (kernel_size < 0) {
>              error_report("Could not load kernel '%s'",
>                           machine->kernel_filename);
> +            error_report(
> +                "Possible reasons: file not found, permission denied, or size "
> +                "exceeds the maximum supported limit (%ld MiB).",
> +                KERNEL_MAX_SIZE / 1024 / 1024);
>              exit(1);
>          }

Rather than printing a list of reasons why the load might
have failed, I think it would be better if we enhanced
the error handling in load_image_targphys() and friends
(i.e. use Error), so that these functions can report back
to the caller exactly why they failed and then the caller
can give that error message to the user. That way we can
improve the error reporting for every board that uses
these load functions.

thanks
-- PMM

