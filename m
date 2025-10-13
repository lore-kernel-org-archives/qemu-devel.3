Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7514DCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8E1n-0000e3-QH; Mon, 13 Oct 2025 04:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8E1l-0000bI-Aw
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:35:33 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8E1f-0007AU-9S
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:35:31 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d60501806so39789927b3.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760344524; x=1760949324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWh+gheWqOAODEyZYewi9iX7yVjbHhH2k4OAEfmw7Os=;
 b=Lu06LpeYetlRYgTSTtZOjW+ZQMHtB28Safq1rtYBL2zsFEIVOkJETa1HOWToeaoqFH
 Azdv//JXBk2pWaZNCBU47mR5YeEq+6p6YVkMawED6DV8WaVYtThbUCT2QOM5TMY2WTte
 PuDalyvzAcoG4FnS0ANCX+l4dcKSFGhgfllqBwC7LjYPL71Jn/jCKi8viI7qnUNiuZht
 w6Jqx9c6BwQSen5VxJ01QyqBviU2ZS6eP1ntTJxleF1JxGHqO/JbrMpKyT/+sCKKguOO
 XWHB3UmLRq6abmT/5ALUH7Ia8B76D1arXBlF3aTDABcAd4rXWQah9Rn29oLU1GEqFMWL
 Z/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760344524; x=1760949324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWh+gheWqOAODEyZYewi9iX7yVjbHhH2k4OAEfmw7Os=;
 b=IDC7xOhANVHKjW0ZqGTfe5hk57pFycIdgxE1OxrW6rhSdPll/+Eh6Dgc7STFzxLYCM
 di7Q9HPgNYsyhVStmTPykeMkAIpHT2UAWtOV4lCp6vphhYGEWJr/dIoVx4GrDS/MuAOs
 7gOoAirXY0WIVQlqRx1ery9iWjdSacsK/wBGunYhd9zjd+yZHyRaNda47lJv+aL3Yo2Q
 Oi3Nxks+IPePDs0yeU8ZhwrzE53kTgymOrTP7n6TRvrAW9VgDRg3ZNtgG3edx4nRE5Z7
 FYTVqJzHlj0xlYMXqX397H46NNr9clKoQXFkbFnAkmlnaAPwIWz0DKi6+hnXWFRAmZI5
 3YMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEQFGw7AogU+dPUpfAlzfBijuK8la6GRN4Em1OI9nZLTDn0JR1IaEdnDKaz4sJ78pToKtj0X0d67vj@nongnu.org
X-Gm-Message-State: AOJu0YyK+KQUeknJ48Pw1eTxA90DRjIyU+f4454iq06BZH7UVAlCfTEU
 iBrB9mm1uyRPAdQ1LA0yGoEk/b4rigIcK6Hci5b20K7dSU6n7ezFhC9ZdYyL99Oct9R6QJHSM+I
 2xPx2jGeuuGO6xY148T/VBlzqOUhXPW/9t99Kl7Ll7g==
X-Gm-Gg: ASbGncsiuTBI546z28+fcZQlDpkCLeveXpG4wS6qSGNbuL8RhoMkcltbd4C+o4vYwdn
 jA+DjaAkRiaR3gHB6sr+YqT8YgVwfZynEGuYWI82O6i1bBN9PzYvZz/6F1YFsQVNp8fMseExk+Q
 dp4wawjW2k8ccftGIHQrsuuDuOIPuxS087/WnfCLIvm/MjBYE3voarRcb9UBXjWh1OJwFkTtmdb
 zJtdt0h8xStheyv65ufIRcd4bI7yeUfW5RWw8aF7w==
X-Google-Smtp-Source: AGHT+IGH/jII7VIE/XBDZzhk+5l1AJAvfbCwzHs1m6Xss8vGfLtaV8I83h+gh8vwgs22vE9LvdDXG0F0iGiOZgGFm78=
X-Received: by 2002:a05:690e:214e:b0:63b:b23b:ad98 with SMTP id
 956f58d0204a3-63ccb8ee4e5mr14306108d50.38.1760344523892; Mon, 13 Oct 2025
 01:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
 <aOyj5p2xzoxCyYZC@linux.ibm.com>
In-Reply-To: <aOyj5p2xzoxCyYZC@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 09:35:12 +0100
X-Gm-Features: AS18NWAa1_UPp5xHV-HpbhV3bn3_J32Dz3FKQrncDEeSvQ2-pvuzkLd0BcVIhvo
Message-ID: <CAFEAcA8zGH1sHL45WU=E2p4p0EizuOs3QRaniHW7ES-CQDPajg@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 13 Oct 2025 at 08:02, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>
> On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
> > On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > >
> > > When QEMU fails to load the kernel or initrd image, it previously emitted
> > > a generic error message such as:
> > >
> > >   qemu-system-ppc64: Could not load kernel 'vmlinux'
> > >
> > > This provides little context on why the failure occurred, which can make
> > > debugging difficult, especially for new users or when dealing with large
> > > images.
> > >
> > > The new messages also include the configured size limits (in MiB) to help
> > > users verify that their image files are within acceptable bounds.
> >
> > >          if (kernel_size < 0) {
> > >              error_report("Could not load kernel '%s'",
> > >                           machine->kernel_filename);
> > > +            error_report(
> > > +                "Possible reasons: file not found, permission denied, or size "
> > > +                "exceeds the maximum supported limit (%ld MiB).",
> > > +                KERNEL_MAX_SIZE / 1024 / 1024);
> > >              exit(1);
> > >          }
> >
> > Rather than printing a list of reasons why the load might
> > have failed, I think it would be better if we enhanced
> > the error handling in load_image_targphys() and friends
> > (i.e. use Error), so that these functions can report back
> > to the caller exactly why they failed and then the caller
> > can give that error message to the user. That way we can
> > improve the error reporting for every board that uses
> > these load functions.
> Hello Peter,
>
> Wouldn't it be better to print the error inside the function itself.

No, because some users of this family of load functions
use a sequence of calls to handle different possible
formats. We don't want the function to load file format A
to print any errors if we're then going to continue and
successfully load the file as format B.

More generally, our usual coding practice for functions
is that they use Error to tell the caller what went wrong,
and it's the caller that then gets to decide whether they
want to print an error and exit, tell the monitor about
an error, or just continue to try something else instead.

-- PMM

