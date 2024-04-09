Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DDDC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCJz-0002EH-Ic; Tue, 09 Apr 2024 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCJv-0002Ab-JV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:19:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCJt-0007ea-Q0
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:19:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso3748538a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712672367; x=1713277167; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FMlYqooOBiiFixxE19d2XSPMCDxEG8DhYpkwHQIgM0E=;
 b=ncHG8GrCpRbgvyhOM7P8qLOFvDYeAolHXy6zNyQEzvfAhNQBJRlr1a2xwmVV3mu9Xu
 DX62JZNxrtcHD18TTeujvOpJxjMmcP+zOH2uQRmXNhLvIR3d7IAysNHkX6AmI0fYtxAZ
 OKqR16GXSTYvRdyeMR9r+4oEg63eIZ4BApJe04vsB+DfAOLvuT/TNb3ezqeXPqJgQQng
 8faz/uZFe5/jxlPUdUvgq2DAMKbF15l2Mn0HFiNc17LgFAmJjkuSrIzDmkozerEdBoU1
 TnkcJSY8kfh6BqaATU+kCcjwcg/BCAYQnhx5whpgtsr+hSuY+xsPQAhxD6l1f+Loa7i3
 Lydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712672367; x=1713277167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMlYqooOBiiFixxE19d2XSPMCDxEG8DhYpkwHQIgM0E=;
 b=vGORODAkQaoGalolcbHdQxf1xku3dTxdJina/1ScidtKOiO3gm6Fw9jRjAnT74EZO0
 tgL0NbkDeF199vOrh7BGbFm8ZmqeK0iYei0p3YXMCLjVgSpRtWZFxYzUbMHy+b1SNgtO
 +WgZCH2z5MKrOkqriTicegT84hcbHH4Dx2Z2C9O8v3zi+Evc09r2Kqjn4IzG1tkdI66O
 k8p9s+7NB3Iqw/+3o5IYhCsks90T2gZmS4bMhNKq5wpEV61dug8vW2ax8CSwlDqBl/MV
 SeBc+6/MkfqqwN7xkze2JjUryYDDZDvzVp0izCqCdFZv/omOC4RskxafGNFysdidlSpF
 yu6g==
X-Gm-Message-State: AOJu0YzQO8e11TjgDHh/bSvYgj+nPWFKfFjQNS+1AdkiHPPmqIRfaqT0
 cy3YIv3hzW07RUcql2HszwLcDfKqjapmqpRuOVxVt72+WnbdWo3jU3sECoZdh2AsSbhPC5mtM2d
 3anABxaUTa1z58dXYIUXHP8NY4eOiGu03lk7nAg==
X-Google-Smtp-Source: AGHT+IHuLatGcPtaWqwfgcfqmJTtd1iDQRW13h5vtIDGv6XiyHQfFb2gRhX4ClAzIU3b84l1v8rh6CqG7Fmko3P8qYM=
X-Received: by 2002:a50:d59c:0:b0:56e:297b:ad61 with SMTP id
 v28-20020a50d59c000000b0056e297bad61mr8877378edi.35.1712672366887; Tue, 09
 Apr 2024 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144440.1069662-1-kraxel@redhat.com>
 <CAFEAcA8eX=-6yXCZ2+X6niJPcgzkzXfHT9F6LpbfqV4b9VRW6w@mail.gmail.com>
 <sevlzxonvgps5m7r263bkzouabg62tbe6vknvv4rbvjfnnhkqg@jnqkst5xetwn>
In-Reply-To: <sevlzxonvgps5m7r263bkzouabg62tbe6vknvv4rbvjfnnhkqg@jnqkst5xetwn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 15:19:16 +0100
Message-ID: <CAFEAcA-xEK6_eT-TUP+adMsgoTU6kRQoz+9vfXO2Tz_PBLdmyA@mail.gmail.com>
Subject: Re: [PATCH] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 9 Apr 2024 at 15:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > +               --version-override "$(EDK2_STABLE)-for-qemu" \
> > > +               --release-date "$(EDK2_DATE)" \
> >
> > Hi -- I've just noticed that we never made this change to
> > automate the date/version for EDK2 ROMs, but we also never
> > updated the version by hand. So at the moment we ship an
> > EDK2 blob that wrongly claims to be an older version.
> > See this bug report by a user:
> >
> > https://gitlab.com/qemu-project/qemu/-/issues/2233
> >
> > Is it possible to fix this for 9.0?
>
> I've posted v2 (series) a while back, no feedback so far.
>
> https://lore.kernel.org/qemu-devel/20240327102448.61877-1-kraxel@redhat.com/
>
> If there are no objections I can do a PR for these three patches plus an
> edk2 binary rebuild (which shouldn't change anything but the version
> string).

I guess that's safe enough, though the very-conservative
choice would be to take just the EDK2 rebuild for 9.0.

thanks
-- PMM

