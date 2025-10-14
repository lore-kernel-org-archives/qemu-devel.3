Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F8FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gxQ-0001IB-Sb; Tue, 14 Oct 2025 11:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gxO-0001Cg-2w
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:28:58 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gxH-0007tQ-FO
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:28:57 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-633be3be1e6so8152615d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760455725; x=1761060525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ezXMhwOTWnWjGUT/Us2VhLOmjzCZ6KCYiyUvleOD5bo=;
 b=jYEHThs/35uhgNGNwVXPSb2iQHxb/XKPJ+nEjhr+T7WAW2as89lRrNimovfBqJWvBP
 QhEaYXc9ABx6SF6UdQNVS/Sy/nkK9BDc98o6YgYE3w+IlclDPborU+fYfN145zikdJhi
 Sx9+LUST/B/KqEmvJt5xzxybY5nRTS8MXvbzFLUfKrZZMWdwlsZG6/S76AbnLJ5JEynv
 voMagMIgZy3DayDa/xNE5EZ1kN2fXxt8SvxVVb9bTQHllrzAPR/MuFECeZ7sNSgwgoOw
 cEN9rlRkasnUl8kOcXsrCv+l8YBqIeVMsZ+xFxj5aPosHA9x5AZeqyuYA6XEI4nnL1sr
 EmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760455725; x=1761060525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ezXMhwOTWnWjGUT/Us2VhLOmjzCZ6KCYiyUvleOD5bo=;
 b=K6NqMugAJ6QztaOV9uVIWZo2G6xpbNQG23Glx7LHArNzT/OopWjZ4B8P/AOx5CbNo6
 wHptqEUZYnUuoNrGjstn6gvdn9TQVdmoF91WAgoDJBOuY3CBZfVKy7/6NDXugjVtCWvR
 qgy0gjUNlpgItNbx6sWXXRWwdLOjNlGAHb3aPwxEVVTpJNexzQsXlrz2eh1Aa7oNgJlP
 sOXgsHMrx/kTPAvwlN3lE1T7Mz5PZjHBsVytP+F83gOMGNZdM/S7D94CqByRbkta2UlF
 iHA+PLPAE7ufnHPA5ygklNbTcjWy5bi9UhVEXKRb21MLDRtpq+AlHbkPOZ74jQzUaxgR
 Zq3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp6RsO0wo5MGTabmHZ0OeRpBeo4RJ+gLGhesN22hAManc7ArXpD5KkskxBEMd6++58h63h8tbQc7JC@nongnu.org
X-Gm-Message-State: AOJu0Yy7qRTLUB5pbpjik7QvKztm+OJzbQyiqcDPi6NBij3HMMWB1OJb
 n2V7H54phHaDNNZ6WDYDOgtNTEu3bEN/ik5kjGTSflczbkdgPFleDWcx+e+ThoQ7C2GjX9KvhFW
 +9S/aFuS+9Ibiw4M5SRX9OR9tugZ4naruX/zDzW0Y9Q==
X-Gm-Gg: ASbGncv2RG0RzUi4fLgTP/8SooClTCL9ILK0rB/5qfD+d10LvOAwhEB9hqjiD6WAwWU
 E4DI4jy70z9FVzofeX2Xcz5NsHTBCbK+sMmmZeMJH2wqXahK4yMP2WExEIhKx+WsJtpYr3czvuw
 La045nBhw+tgOWYnnd4rAGeKTZiJnSu5z0bxJP7rZIzw/7W8jKsDERuUgE1TyKFdpFVtArSCOo+
 3rc6ZTxEOs7BtLkicQUC8kGXyA9f5w=
X-Google-Smtp-Source: AGHT+IEh6Mot9BTMvMsfgq6NUbgeBX+aVTaoLEcrK+vh8xzQaE9ndPoOkvrd2fIlM2hYpoJm26RobA2JUKaWR7+G8Pw=
X-Received: by 2002:a05:690e:2d2:b0:636:cc3:af35 with SMTP id
 956f58d0204a3-63cbe13ede2mr18321953d50.22.1760455725212; Tue, 14 Oct 2025
 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
 <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
 <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
 <ca74ac20-f510-4c78-8f3b-85a551841041@linaro.org>
In-Reply-To: <ca74ac20-f510-4c78-8f3b-85a551841041@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 16:28:32 +0100
X-Gm-Features: AS18NWDl9NzxpQT9ga_Dw5sLxgEdYJvX7oby4Kcs8jHD5N6I78aTO2uVNSTfnkM
Message-ID: <CAFEAcA9MjN3q06COn=_==v+zFt06Qtp9WEy7+yx2JO_L17StCQ@mail.gmail.com>
Subject: Re: [PULL 00/76] target-arm queue
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
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

On Tue, 14 Oct 2025 at 16:24, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi Peter,
>
> On 10/12/25 16:58, Peter Maydell wrote:
> > On Fri, 10 Oct 2025 at 20:59, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 10/10/25 16:03, Richard Henderson wrote:
> >>> On 10/10/25 06:04, Peter Maydell wrote:
> >>>> ----------------------------------------------------------------
> >>>> target-arm queue:
> >>>>    * Implement FEAT_GCS
> >>>>    * Implement FEAT_MEC
> >>>
> >>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.
> >>
> >> Could somebody give me access to https://wiki.qemu.org/ChangeLog/10.2, please?
> >
> > It should be accessible to anybody with a wiki account, I think.
> >
> > (I have already updated it per this pullreq's changes; let me
> > know if I missed anything.)
>
> It's missing FEAT_MEC in the list.

...and also FEAT_GCS : looks like I didn't update the changelog
at all for this pullreq. Either I was confusing it with
some other pullreq, or else I failed to actually save my
changes or something.

> But let me add it so I can test my access to the Wiki pages.

Sure -- please add both FEAT_MEC and FEAT_GCS.

-- PMM

