Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B2C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 12:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGP5-0005eG-9I; Tue, 05 Aug 2025 08:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujGOt-0005PH-K7
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:04:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujGOr-00056m-VH
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:04:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so3428393a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754395452; x=1755000252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MBX8HQK6l7OwoRJSn3MNmum4aEw9kFqJi8JEN7LdE2k=;
 b=eeWBLkdufDK0XuPXDof+OcQDMaY/KOgSAoQ1F/CGXQzwtG/dlpaRUKDFC3yNRztAQd
 9rc2nrsq5shwi6CC8+ScMY3RAdhaKWp2HfYObafyZS2sGMY6V7Tf/fKHy7cnkSKzUlEy
 S7aymEYL5WeEKWoWrddg8f64rUb6sQczGLzWZpzgwIelGdv31MG0+SEqNMY+MYlIj4uh
 YSzyaAeEfer7S73a6Yx1yMPEKOT66mSCe8YPbm/wX9NNcjYE1TmpmhJ0J8TJQjs4OSD5
 jHiiNz2Zo50R8IFxYChBrtHY2yXvGpcM5ZAXSKooQy1sOvFta5nOkHKDVcWAMct/CTXp
 TN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754395452; x=1755000252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBX8HQK6l7OwoRJSn3MNmum4aEw9kFqJi8JEN7LdE2k=;
 b=WzelM6WNx1bOe0rjDZt7lOe7t+X5KE90v9rG4VWxVDqQo52deg2pwD7sVgj51qZkUm
 D/J13gMDcRIY7OI5kA17aLCp7OlfiJd6Be8zTiJXUTh17CajikI/Y9oYnnsRMaJ4wNEp
 sRdQdOo+6jbOjXINxoI/tW6HPFX7aXyVgPGk0zzO3oJlfdmf0ByAxeWeczymOYW4KN9g
 MvupUxwdpuA8k3GHC1YQAMSOCcR+s4R4uuFQ3KQXmCbPJgmiKiwjIQtN9hiwTcFxlPdr
 XgkJANysGF9gmQ9Gf5PijTedAGI1Fn1cMKeXiuDh2Cjg6U8truTm/kc+O58v898XBU7a
 8jWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbdYlad/lr4GH+/kZjRNz9IKVPsiBXo0wGJUJWjKX/wLLx4+w/5AQxzqq8WyBxJCWu5ahInqfmikGX@nongnu.org
X-Gm-Message-State: AOJu0Yxhu/AcVPT5nmrKE2F7/yb07GusIQ4NCjfMRnGLPlGSDkYH63IR
 rjkXHE2oEZTmp+k09ujARRJ+cdWWHITWKKDO5gm2i+T1f84mUuOaLz/AW3mEoWOU4dydSus23BI
 S8/gzOj/7cN0ftK3aX9kGqD9sQO72hgs=
X-Gm-Gg: ASbGncu+OgFYcFPn80rpFvhzS+Pru9otpf6ry2qBz/K56c2kqIFT9gXE/tOmBZlkvAE
 tNZnUUxhunSK7yAs9K0m7YHYvveBN7xIZaBh0WLdYNY+FmtEYFm7neR10CldyIZ208wciCN/sUp
 df9/0kXbjjTB2Lbuc3HTagHAvBK7zCGBkwADVy2f3n0PCGDam6XlYCBWutyN6CCloU5XgbQ98eX
 QuJDta2G13EuYkNTd2cvpAkcUZEX+MPalESHw==
X-Google-Smtp-Source: AGHT+IGxRjVcIHzgAFUqOvGXc8KNw2uQZxL3rstZfmfdrx4Ovn9fdKz4z9vAbB8avJ2prug1dJVDW+LnvEmsQH3nNg4=
X-Received: by 2002:a17:90b:384e:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-3211611ac7amr20755310a91.0.1754395452242; Tue, 05 Aug 2025
 05:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <f870c073-61f3-4693-90cf-e75372047c84@linaro.org>
In-Reply-To: <f870c073-61f3-4693-90cf-e75372047c84@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 5 Aug 2025 21:04:00 +0900
X-Gm-Features: Ac12FXyiHn5rajkrl2ZmQHny6-Tcv-aIW2WnDkvKiiPDW7HJdQEEB8SJjQlZeFc
Message-ID: <CAEDrbUbq2z9wj0ynmL+C0qCm47239MXB6+jCwjpyN-M7Tpbi+A@mail.gmail.com>
Subject: Re: [PATCH 0/4] wasm: Enable 64bit guests on TCI using wasm64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9ff86063b9d0549"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000b9ff86063b9d0549
Content-Type: text/plain; charset="UTF-8"

Hi Pierrick, thanks for your review.

> Excellent, thanks for adding this.
>
> Out of curiosity, and out of the scope of this PR, would that be
> possible to make a "universal" build, which can selectively select the
> appropriate wasm64 support at runtime, so a single build works on all
> browsers out of the box?

I haven't found an Emscripten feature for the universal build but a possible
approach would be to compile both variants (-sMEMORY64=1 and 2) and provide
a wrapper JS script that selects one at runtime depending on the engine's
pointer size. If the user can accept the 4GB memory size limit, -sMEMORY64=2
can be used as a universal binary as it runs on wasm32 engines.

> As well, what are the limitations of -sMEMORY64 regarding limited
> address space? Is it just the maximum size of memory a guest can have,
> or does it limit the VA that can be accessed also?

-sMEMORY64=2 limits the maximum memory size a guest can use but still
enables 64bit pointers so TCI is compiled with TCG_TARGET_REG_BITS=64
without restricting the guest's virtual address space.

Regards,
Kohei

--000000000000b9ff86063b9d0549
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Pierrick, thanks for your review.<br><=
br>&gt; Excellent, thanks for adding this.<br>&gt; <br>&gt; Out of curiosit=
y, and out of the scope of this PR, would that be<br>&gt; possible to make =
a &quot;universal&quot; build, which can selectively select the<br>&gt; app=
ropriate wasm64 support at runtime, so a single build works on all<br>&gt; =
browsers out of the box?<br><br>I haven&#39;t found an Emscripten feature f=
or the universal build but a possible<br>approach would be to compile both =
variants (-sMEMORY64=3D1 and 2) and provide<br>a wrapper JS script that sel=
ects one at runtime depending on the engine&#39;s<br>pointer size. If the u=
ser can accept the 4GB memory size limit, -sMEMORY64=3D2<br>can be used as =
a universal binary as it runs on wasm32 engines.<br><br>&gt; As well, what =
are the limitations of -sMEMORY64 regarding limited<br>&gt; address space? =
Is it just the maximum size of memory a guest can have,<br>&gt; or does it =
limit the VA that can be accessed also?<br><br>-sMEMORY64=3D2 limits the ma=
ximum memory size a guest can use but still<br>enables 64bit pointers so TC=
I is compiled with TCG_TARGET_REG_BITS=3D64<br>without restricting the gues=
t&#39;s virtual address space.<br><br>Regards,<br>Kohei</div><div class=3D"=
gmail_quote gmail_quote_container"><br></div></div>

--000000000000b9ff86063b9d0549--

