Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DCC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traQa-00037y-Sg; Mon, 10 Mar 2025 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traQY-00037J-Rb
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:32:06 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traQW-0001nq-Mv
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:32:06 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e63a159525bso484783276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741602723; x=1742207523; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJpDhnofloE+E6zKZqdvAEr5CqPfN+KyQtHOX1ArmcY=;
 b=U1UwWrRUxorA6IZU11jnMLHe/3BLTGU00ou5Pzth5hbqbp/1+QRJNVgasMLCz+joYy
 TtgVS4x1mGcR3NVIcD3x6qS+e6JGZ1tgeSFuhN+IympUlrSu8FABKW7iXjmpjqvkLmcP
 aOe1eolsjlXkyKbD2VutTZkvJA5HiOoHcxiRy2JlL2N4H4TENk1VpZ4wQRqwyoMVYJNo
 DFIlXuqq6BcWVI7OVCsQe+J14gi68ZO9xx1kFHHF3tctwKoAQURwmxL/Z51ZxPX78z9Q
 YasDMxHo/8v34uU6y/RYKV8NN6EM8yHq+86PY3KFcGiHdKSMOa9hYgOpsgbWaUuNBhOT
 vz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741602723; x=1742207523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJpDhnofloE+E6zKZqdvAEr5CqPfN+KyQtHOX1ArmcY=;
 b=w+rFEG9v0kCFA3XathUB8gmKDbtFEP041E6eMCfKpkJ3Taa/rONEKfugH1RQL2Gl2I
 oS4wRu6J+1XbrAqURQge20W1m0Acbptyby45y+S0Izw7bHCu+J/TPcX+Z7CGq/h4aWW5
 hkDSLFF7B/411rC7tXrfTdf592AzvN8bhQBtbpnpQyaVwJjXKYGBI5/UzxVUVoCDxHea
 ItTe9DJ3EjLTYuFL5uMYDugRkPV3mzN5e4YtrEqW7V4AImHE9JvPl0V8BlWAFCUe7yx/
 FEqU1vpjPiec4a4XivGwJtj0KEcPgAbGy9K1oTTm0X8M+9elqzFDt9OHt4Aic1xEUZTj
 fAMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhkpIt0l6stsAGTcy+/AEkE64c/kF/ApI9zw0ZKU1mtn3tJCR9/YVXQJ/28nPM67c9T2fR3HDvtRha@nongnu.org
X-Gm-Message-State: AOJu0YxQ1HmMO8G9++FifRRp4Am/+ZHtmBl9ylEDBBXs/LrQ7ICTMcb0
 8qAPQ2CIPldsXzPlJhvzujVMb03QbOeQRPcPE4bdZUFcLIWsXY9JVs6DVDCp8Z7tJA/NDbErPee
 822clLCUrfZPyElPR4sMhPfCIVFU5XTFvVee5DQ==
X-Gm-Gg: ASbGncsMdM/nVYJbdmmJ/3FEE2pflL9wo8n6xyQ3JpWoTDmRn724MG9Rq2uRVtntxls
 U4CxbqKJaCHP/BP8Ge19LiU0n5u8RX/nZj7dalnEYUucvLYnOvgxfzXpIjMufYXhDFT28WVMvDL
 BIvxGgGrAs+vIKXVkjI/M4+5402KmNWMpZb08+1A==
X-Google-Smtp-Source: AGHT+IG8Z01w8vvI9FPMsCApAm4JEKCHpiezl2fzFiQsmW+3q6kYJJJ9YEvi0W1cxDtV2hkW2Pg3CnRP7WfOslouavY=
X-Received: by 2002:a05:6902:1684:b0:e5e:23c5:a8c8 with SMTP id
 3f1490d57ef6-e635c177acemr15907161276.22.1741602722863; Mon, 10 Mar 2025
 03:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250129082045.1319203-1-pbonzini@redhat.com>
 <CAFEAcA9=G4sdXrxWcmq9wMqu1-ZRNxObQD3hmnFauYwiQr_8YQ@mail.gmail.com>
 <Z86v8Y70sGThWb_V@redhat.com>
 <CABgObfbuj3SbqpDkUnKux1EWCudiksQxbWr_4Sck5tTLr5QqeA@mail.gmail.com>
In-Reply-To: <CABgObfbuj3SbqpDkUnKux1EWCudiksQxbWr_4Sck5tTLr5QqeA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 10:31:51 +0000
X-Gm-Features: AQ5f1JqC_9ULke36BduxV2H9hr_OqCBGORRYJSzaaDZpkNZTulhZhV_rXlQ5UpA
Message-ID: <CAFEAcA8bbXBYy774AMFo=yiRSN4qZnOyaC+sOV0zP11d49mUvg@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Mon, 10 Mar 2025 at 09:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Mon, Mar 10, 2025 at 10:25=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > > This will only add the rust backtraces when the tests
> > > are run from the CI logs, not when you locally run
> > > "make check" or similar. There's probably a better place
> > > to put this...
> >
> > Meson's  'test()' command accepts env variables, but it'll be somewhat
> > tedious to add the same env to all case where we use test. Might want
> > to define a common 'testenv' set at the top level meson.build and then
> > reference it from every 'test()', unless meson has built-in support
> > for globally applied env vars that I'm missing.
>
> It can be added to add_test_setup().

Thanks -- I just sent a patch to do it that way:

https://patchew.org/QEMU/20250310102950.3752908-1-peter.maydell@linaro.org/

-- PMM

