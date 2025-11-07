Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7CFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMIP-0000iV-PR; Fri, 07 Nov 2025 08:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHMIN-0000iF-QG
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:14:27 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHMIL-00085H-OM
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:14:27 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7864cef1976so9419617b3.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762521264; x=1763126064; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8cCP9j8RmKeSksMVUylmKm46fT7iGQ8eyC9k0DASbkU=;
 b=mPNPYdnxriWeX5CoynRG0+wOZm4JYYk6SXkx+O5XfzVa3HHzon9OKWjCaZJ5pY4Pya
 qqL4ToHnUa59J+tyrRUMcN8DIVvZfU8hV3aehXc3zUrfw2NiXcKCJI9S/5csx7SzO8Cf
 qZxMYpeQs0W68KJ2kYXoOlaBmr3jFCIWDivg08UGfFI14fbYwHaBrNYd8fhzRPtutn8M
 Z8M4yrDmAnBHK4tEJ4fJfuprMOmQfVaiUtjNblGKtgKH+egHLSsS5zR02IvT9+YbrTGG
 rBPrIcZsMufkGv8x/sdQtYUSN/OC+5P909mxYie5b6RkR94f6aIIRxDwRE/JVwJNh/Bw
 Nnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762521264; x=1763126064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cCP9j8RmKeSksMVUylmKm46fT7iGQ8eyC9k0DASbkU=;
 b=JYGIAZxix3Zt8Wt3EZqfVuJfkhag2rSA/yIVb8zhn7kwpsZKDZU6ozzbEPXu/DnwkD
 pPyUQJNAEoD+oVtxdDAHSuI1Gll4EnNQ2amPCG6RfZ4QNigp+W8d28USrfT5XjTC2ch/
 /LGuegSwLtxS8mLhfCy/K8cYvUf0sPU/shBvNQ6cSmvmgi6crkgNpgWybnqtSRHnRBsw
 4CeUzvIhMK7HkWVev5o/XyjcHECEABfUPYFYAMqDF6BwiCJ7VHg4id3xlrPtWpSz+pAL
 KcOM87HQobeW9B5lmI/+EimHBxWzSjs7nAajpotRmyxqhfQaHx4z8zUISb1UyPk7lOjn
 jamw==
X-Gm-Message-State: AOJu0YyPEZUK2qGkGjfRXoQhsIXktHN4sAY6G5M2cXEk9CImD2qPx7u2
 uVQfvUG/jbpV39nf/p2bGCOAXgzvnymFu7PEjIUPZt8LeHdpjM05SubYwEtCuXzqddZZbaViD7n
 hyzQa6ECXjVRUwpXH1exBkTf4GxJemmk0ICvLyUYnXg==
X-Gm-Gg: ASbGncs2vdh1d89ULZ16X4chjldaGueBJqQ2qosdGZY1yIaOH1IiDeFBMisdpVY1iEL
 7yPMRpyF5TKHrRkl9zI+d1Le0TCTjTjF0kx2QLEzDITbnPs2JnyqWH6dlA3IGIJbf6JbTwS89hk
 knnHOdAMEygUF4L8EKUIhEwknM069h2jxOCKiy91aay/VFfIaKgQdY5yljjvhNDrEpy1gZy05n7
 dPFMy5Dp4Hsd+0LN7UrHCKACqQK1Vz/j00EygE0FwqeFmXjx4N3ULJiM9eQKyoJ892YoET5
X-Google-Smtp-Source: AGHT+IGM/os1hq1cHdZHYoYJ7vry5P7cxvkinnO/SQq6j4Lvgrb22HjEdI4hn/+SD9yzMlTG4zT62pgl/lQmUNf+trQ=
X-Received: by 2002:a05:690e:159a:10b0:63e:29af:bd23 with SMTP id
 956f58d0204a3-640c9c76e91mr972551d50.4.1762521264415; Fri, 07 Nov 2025
 05:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-6-peter.maydell@linaro.org>
 <87zf8yaw06.fsf@pond.sub.org>
In-Reply-To: <87zf8yaw06.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Nov 2025 13:14:12 +0000
X-Gm-Features: AWmQ_bkCWn-f68YVOTISnW-4PzdqtQfqrSQcSb-HOk8cdWbKVtb5h9xO4UF-6ck
Message-ID: <CAFEAcA96NhaKQGWeMC0Gx9pM36cZfCD4g=xVW58_mWgKg1Qc8Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] scripts/clean-includes: Give the args in git commit
 messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 7 Nov 2025 at 12:05, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > If clean-includes is creating a git commit for its changes,
> > currently it says only "created with scripts/clean-includes".
> > Add the command line arguments the user passed us, as useful
> > extra information.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  scripts/clean-includes | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/clean-includes b/scripts/clean-includes
> > index a45421d2ff7..694e12f062c 100755
> > --- a/scripts/clean-includes
> > +++ b/scripts/clean-includes
> > @@ -42,6 +42,9 @@
> >  GIT=no
> >  DUPHEAD=no
> >
> > +# Save the original arguments in case we want to put them in
> > +# a git commit message
> > +ORIGARGS="$*"
> >
> >  while true
> >  do
> > @@ -198,7 +201,8 @@ if [ "$GIT" = "yes" ]; then
> >      git commit --signoff -F - <<EOF
> >  $GITSUBJ: Clean up includes
> >
> > -This commit was created with scripts/clean-includes.
> > +This commit was created with scripts/clean-includes:
> > + ./scripts/clean-includes $ORIGARGS
>
> Consider
>
>     $ ./scripts/clean-includes --git 'a b c' a b c

Yes. Do you have a way to deal with that that isn't
more complex than justified by what we're doing here?

thanks
-- PMM

