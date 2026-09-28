Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A6AC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAHb-0007hc-0E; Mon, 28 Sep 2026 08:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAHV-0007hG-Qa
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:16:29 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAHU-0007Bk-9d
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:16:29 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-67109935888so2550222d50.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597787; cv=none;
 d=google.com; s=arc-20260327;
 b=a+9XIvqetkK4sTriWNhzyYylalNXxk+lX9AJW3Yq3i1X1eqPNkwgf9GQaJ4wMY3BQe
 uYcYR6AAKVJdWbtQfNmWapDQiqtPIVyzNgQ8UgpBeDyoQ/P/WDzhZqTbC1toJbh0siRQ
 FFIIkyDm6MsT4EV64YprkfSWxtTZxCSJqAaXW5/a+RDRTgLDV3xjXFzSp9AHbvwOT9pw
 YgtadWdEx4zZYuuWv21snZ5YBZm9rwM8mOs1zeM+AbxAxNo1FadVhAnbNKAiCpLImskZ
 vpayGIdQL2yE9/f5U8AqnHnRsXR6K5IQA5LdEYrv9FeyYzRaBa1Z5aQhdBBjIZ7GbjMc
 jJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kNAr3nXN656vcUu+O2UeZX8j8adB5wy8ChCv+YwWyEY=;
 fh=bwuqCypVRq7gFRBxTAQec2boGW6EM0mD1d7jpgBMewo=;
 b=QxFxEk5k2MeTwaXygTeidHMqmOdVJaVmhJ7B2e2BZaZxBBE0+2X86uBf/GZbXw5YBC
 4m7c4vhqo5nTDMrQ8uSZRaFZVQ3bwjXHdPufJ65ffBpgR1/RZDUqODvA9X0nwuLLK8D3
 WIANe8RigAi/hlIdX+toBx/NZLaKoZZmTGCP5sc92A3b3diQr7l1GHivZUel7+gMFD3W
 Q5GOw8LjTL504rv9SsBnnvWI6vHkX7yD3wq1PFoWBn+PnapP/xEAasdPa5GE4VcQlBhd
 Q1okiR9PN6aQQ9+xc0mIQYvL1UtrhAEMQRXGNNMiW9SHvoyJZWjIgr3b1geKGRzmFriR
 bGvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790597787; x=1791202587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kNAr3nXN656vcUu+O2UeZX8j8adB5wy8ChCv+YwWyEY=;
 b=l756n9tHXaDl6Akx4P3aMGsoeLZdLa/jqRtPyyuMuBsbtBzIz4GGxYzxGNPEOLAkZq
 UEhb8lS0e3Zsg+TW5H5Pvo1TbLwqs+F6q+vDgt3KZlcwDpUllhalLTdNjTrAa1BtsM9R
 XV4ALWZukca0I85GVCKftR+U3xE9wStgrHTmJfKJZyrL/x+wOjAUktkX5CBbOea6kG0J
 8giyWHY9I5rVElOjKZaW4wQgEJrPq88NB6eg0ds2VJl6lf8CZyMvSrpCNB6hVizRmXYi
 ncSSJD5Uk8DAvLDE9QXOvQU7d2zgTgkAcyVgm10LTU9Hc7ZHn0SBsCuamzGRqmOiCAFO
 mHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597787; x=1791202587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kNAr3nXN656vcUu+O2UeZX8j8adB5wy8ChCv+YwWyEY=;
 b=iFs+xkSlcFfg8ITrWAR0f2Ha8hKbZ1b074Cjr4DqNH0Mo53QPMUxgoQEhBN1MDtXQ4
 EM3xni1Wi0lkxu3gWUYCr1UilyP2xQqZfs0htrLPTxqXVeCmECO34SS/pAOD+KyLDsMM
 3CqF0nwC9cQIg/5WuB4ejle8asqNVDU6VDqxfmJcJTKOeDBJKNfALirzHIvFrcIeARk6
 ZAFWjzdxFyN6O1SgEK8Z7tLLC3/zVwfbwIFNRrLG5WjjKuFOvu5VxZ5Z7t39lzv9sxvf
 0Nk9oTuDeYYUjWnszdfDAzbJMBEKim8eargqJcLCtPu5oo+EVqXN9o3DuqnJCul8/5VB
 IG2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByIuDzTe+o6hdRQhW+a9o4n/CDbI+xrM0byTw9lC2bPJdaMNn16LiD4zPXyc32wr4JjTUq29g7VTtaE@nongnu.org
X-Gm-Message-State: AFq9FYJROjFcfm2BCDHS+3RGcb3gpH03VWESbhw5xM48MtAtzmsf3252
 VEqJDeSf8xpk4T0EK6eJG1TJ2n8yaWJt3Svk8EpM4h2hWo4N2Qv6jFIqi28bn9PyXWaF/vlvwnH
 xwm63JnKTEIYexannaL1iVyS8nxks3If7yQyQiphPaQ==
X-Gm-Gg: AYBFou3Np27be6I42EpbGKsUst00tQI91WPdF94eKbQ3KjHSLgfUJtjSWYFW38B5KDC
 8BW7CzIm8sAfZyZ54bdQKg0c8gcsSKQK+71sJ3SDsKbuPmMZ++PguDFafvY3zm1Hzaf5AjrPgiV
 63+4cfAq3j0PqF3IZnrBKyCT3WDKAqlIOmnE4qc1eS7ezoRz7I1XbLCiZ712KFtRr23eiJngyKQ
 J7uZSF36mV2NUo+rDDVYF5KQywS/c/6TYAUD68a/52swpGK3jv3wxUgaYuI2EECDp3Ewi8VTUs5
 2KGH/sPZCgME2zYIJZOOofAgGMF7CvQqyHyGSPyjVHZnvuRlydgwWjxFWEe12dI8wcdGRAquDDu
 XtBuP/3Cqb1lAgmZb9V/pusyBlAstZK89hAGvs7E=
X-Received: by 2002:a05:690e:16a1:b0:675:2fda:6336 with SMTP id
 956f58d0204a3-6752fda69ecmr2458796d50.91.1790597786829; Mon, 28 Sep 2026
 05:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260926175634.2034094-1-satur9nine@gmail.com>
 <cdac79f2-13c3-4964-96a9-9def889c8eb6@oss.qualcomm.com>
In-Reply-To: <cdac79f2-13c3-4964-96a9-9def889c8eb6@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:16:12 +0100
X-Gm-Features: AclHuK86Icw2J8ca62bk7z-0PgqR8KUCqDPgSR5KoyQWy5idIMLkUFVjbo0l5Ns
Message-ID: <CAFEAcA8rpvvEfGx43Nj+usXib_HNHt=u+_xTF-Migb2vQ+xPKw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/stm32l4x5_usart.c: Support 16-bit writes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Jacob Whitaker Abrams <jwhitakera@gmail.com>, qemu-devel@nongnu.org, 
 Jacob Whitaker Abrams <satur9nine@gmail.com>, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 "open list:STM32L4x5 SoC Family" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
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

On Mon, 28 Sept 2026 at 10:31, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 26/9/26 19:56, Jacob Whitaker Abrams wrote:
> > Official STM32CubeL4 drivers use and require support for 16-bit writes =
to
> > UART registers for proper function despite datasheet claims.
> >
> > Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
> > ---
> > v3:
> >   - Add suggested comment and set only valid.min_access_size to 4
> > v2:
> >   - Remove all changes other than supporting 16-bit writes UART regs
> >
> >   hw/char/stm32l4x5_usart.c          |  7 ++++++-
> >   tests/qtest/stm32l4x5_usart-test.c | 22 +++++++++++++++++++++-
> >   2 files changed, 27 insertions(+), 2 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Applied to target-arm.next, thanks. I expanded the commit message
slightly, to add:

"As the only 16 bit accesses we need to handle are ones to a
register's base address for registers that have no defined fields in
their top 16 bits, the emulation of 16-bit accesses provided by the
memory system core is good enough, and we can implement this by
updating .valid.min_access_size."

-- PMM

