Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D0D64078
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNf-0000i4-Ff; Fri, 08 Nov 2024 14:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t9UNc-0000hl-HD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:49 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t9UNa-0002Sf-QQ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:48 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed49edd41so447727266b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731093044; x=1731697844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y28Gf/YpD42AlEjMGjgP8OA0CoYWr1vvY5+m1N00XM=;
 b=PLlWOuXj+THUXpqEp8XbB9WGdHTxcmPBINnKuYpsgY6OVpN5KygDTSHjH79BgvKDnz
 cfmM3sX51A9T/FdOFyxq3zhVr0DrVQz963gA73LP7ZUYW+UC7hQyXnEfrzK3onggCX26
 5aQYR2td8JqFt+RlRKDDdfiVpvtjlezh0yKQ7m5E8Xzl4yblRnACeACL/2F1AWS8b0x7
 /7TTu+yOqdyItCyaSYvQlg56WgxjIPcJ1YQF8eprlRDw9vEGUnnYMLMXazfAH41O90Te
 AqwQ1R34o5go9iZ7rVmOcbVWQs94MAT53X41edSLEFTHLUKEBkroDYt8bOpAvUb8a8RV
 5tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093044; x=1731697844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Y28Gf/YpD42AlEjMGjgP8OA0CoYWr1vvY5+m1N00XM=;
 b=E+k49D6bKxN0nj0+HgbnNbQyF4mRl0Lq3ESLD5uKWomo9dbH7gny/mdCI4DaBona9X
 83+I8ZidoTZ+UDzD9BcELR1wtsKyU8gY0Nqgea+F9LCKzW8XPpUsydVG9kaK5qJr/mgf
 W9amDg/s9edpPY19uFGTem2MWognu6zTDJX9lJu+ZFDjnBB6TjddDY0BW0bLSjOTaMou
 0RJRhpd5rZ+JdyFFgzoGqx2aGvhUwwjYKsZCdlDj1Uvn1pfL7ESMraUIqIvmo9ojz1Tx
 vP4xAqDuIUjsc0MgJqaIO6N4GPFMB1puJC80UvNcJDk9OP8Nla4woQQenEkLFgsXeHhb
 o4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVET3CSAli3SGxD4/8MKp7yNFfkYsuH1Fu97KONr2Lffx0dJq/sJU4EbbmV9kXxIy9fiuG9t3ifTwjw@nongnu.org
X-Gm-Message-State: AOJu0Yz6+w4hD/qu4sUMfGUem1Ckgy5I9w+HSSW3SmZMzF04pCLUaZxj
 fcNstPRPWzYMIbf75rqMFnYNjyvuneD2WLLftHX8fg2YzUwsI7j8GcDWRaMbH+SMdJdQmpp95Mv
 NEr+rf6BD+xDSoTdi0PotY2ZbOWxzSiXbItGKsQ==
X-Google-Smtp-Source: AGHT+IEsKFouMC8tB0nZ3lsuep3lpfm1JksZpkpo0FqpgQO4z5KRLMBpYStMHFcg06P1RCbVMid0Ijf+C0LDBmVgWAk=
X-Received: by 2002:a17:907:94c4:b0:a9e:8522:1bd8 with SMTP id
 a640c23a62f3a-a9eefebd13bmr411170366b.6.1731093043646; Fri, 08 Nov 2024
 11:10:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com>
 <Zy4zXtZK_9OnXSJU@redhat.com>
In-Reply-To: <Zy4zXtZK_9OnXSJU@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Nov 2024 19:10:17 +0000
Message-ID: <CAAjaMXZ_VXE+2Wk-5EhdLARx2qS2qMuF7k6xRs21LdJ0vxPxXQ@mail.gmail.com>
Subject: Re: qemu-rust@nongnu.org mailing list created
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, Nov 8, 2024 at 4:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Nov 08, 2024 at 03:13:58PM +0000, Peter Maydell wrote:
> > One of the things suggested at the KVM Forum Rust BoF was creating
> > a qemu-rust mailing list. This is going to be one of our usual
> > qemu-foo lists along the lines of what we have already for
> > qemu-block, qemu-arm, etc, and the standard policy applies: emails
> > to qemu-rust should also cc qemu-devel so people subscribed to
> > qemu-devel only can see traffic. The separate list will hopefully
> > assist people who want to follow Rust-related discussion and patches
> > in identifying those emails.
> >
> > You can subscribe here if you like:
> >  https://lists.nongnu.org/mailman/listinfo/qemu-rust
> >
> > The list should be set up with basically the same config as qemu-devel;
> > in particular it accepts posts from non-members (though there might be
> > a slight delay on first posting from a non-member).
> >
> > Please cc qemu-rust on future Rust related discussions and any
> > patches that touch or add Rust code.
>
> Can we get qemu-rust@nongnu.org added to the MAINTAINERS file
> for every entry which touches the rust/ subtree.


I will send a patch.

