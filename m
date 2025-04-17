Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C92C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Lk0-0006VZ-Ad; Thu, 17 Apr 2025 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Ljx-0006UY-UX; Thu, 17 Apr 2025 05:41:01 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Ljw-0007ln-B8; Thu, 17 Apr 2025 05:41:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso373758a91.2; 
 Thu, 17 Apr 2025 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882857; x=1745487657; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QFj33q5/KeeGLRSrHE8hMSPyr/POvveEwsqwvFuHU1Q=;
 b=mGODnYKgO/BZj1ykhO76H+e+1d4CpNmweeTq5dqAQK/kgCgnvC9gQivm57LswtZHgh
 eWsSLuAQlQprkKg5A/kYIcsIRlptZtLXkY1g75f+TFgoPK2FRLMvwppbactXBC5Uy5S0
 kAICFrvSLIpTHyw+exry1xRsimcs0h96TF9ZwrxhqHzeATyQF3luNQKVcWW7NVTQAJdm
 K2GLroCrvLug4Xvj1ad9bz7hsMq1H1uBGZ9bbecfqYSMHmT4YMATWAEZPuv9P9tXUUDH
 IJ22pORPCKWWELLz0bmdtOugmVhjsO0k7c9yll8W1XzKY30xPRNZHIPLE+Hs0+RE8Gu+
 xThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882857; x=1745487657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFj33q5/KeeGLRSrHE8hMSPyr/POvveEwsqwvFuHU1Q=;
 b=YqkTYTyCqE5yKy+EhjfDcy7uRKO2ah5xCtvHpjOtOsunPMBpCwxL1HtV1+HAmhb3zi
 8I5KXbTaZt776Tdbi41wjagSotbF2PDixnzwBA4qSuvHh4p0qaaEYkzkv5rpfSC0+BiK
 GvmI8i3x4KO8Oohkie/n3SVXvx5TfoLtLZQI6UOFhpby6XJPBklM/Idd6oEsPk2F5saI
 IKk8t9OfPqYq073Vk16iZp2bQYucoltNkbxFOYKi7I6dryr/TvPY5N+5dnMyiJfsq91V
 TI0Vi0T5oZX9iQyokOB3KJ0BqZIBdAjobLNlUD8Kyks5p0GtbiJeHMvT0EKSovun31dJ
 DRvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6v6ws925NRcOcZ88lPMxY7BKQGgL7Gik9Df/CQBfaSN6Rg4gYio07pvUlUubAAJdAbcTwh5R4ob/zIw==@nongnu.org,
 AJvYcCUwRFO0CCl7z8sVDGPOoS9huCxSM5lWZ+7xe7EIByHM9GQNP4Qhrv1g+YBGjH7Z/XMBFFjpoth4L/w=@nongnu.org,
 AJvYcCUymgCb0VPBvJbEx7QxTg8p/LcmW+cJmH4m8eVMn1yIh3hnJt4YRiIV5Tl6GugSf7FlMvRRd7rw/OYPAQ==@nongnu.org,
 AJvYcCVqbDMEewTmMsuvU1uPhY5Nsc/31BWPBVvT110RGXgjucWsnrrUliFXdl2X20UJvsYR8xUokmGbXQ==@nongnu.org,
 AJvYcCXJ5C/r6PcCaIjDkFkh6wekx0ntRNCIycJlRHWLsZ/D1lSaFNUcD3ewMCytMTfri07mWQmPFHP9kE6Qyg==@nongnu.org
X-Gm-Message-State: AOJu0YyUR5Wr1+F2eSmdQp1HroX5M0laA1lYmxpQOu0AR0sEPqYdPUSu
 g7tKZu4lL9scn9Rz4QjH+2cDv7eSquNSJUXYTBJsCDOEzjYsGl+P3XAWZCmQEAvwpFgocZaqBHV
 Z/JoApCue7G7fxf2nQ2hQPhwUIVLH9h5wfRg=
X-Gm-Gg: ASbGncspmiz0mgB5IiThsDF8yPpScsXYVlU65WgsL3z3ZDiWx7hSMOm6IeUa71ZTeZe
 vYLv3NLL8PUZZJxwPUnW/U1pkrGPkkG+nPnD9zoXPG2iUFpztB2UVBDH22yGZlP2XYqS3Xg4emH
 Zzz2/y2D8xqcIOgNIkFkmX28T/CvoUd9NqBXergc3ccarXKFEBr2L2
X-Google-Smtp-Source: AGHT+IGKwwOAuBmQI+wOClsZaLQqiMd4YBE6pAZkKS9df9Jtvkx3A3NVX5PnAcsCgGCvP6Qr3G2oyYFnnMwDpbf4ZD0=
X-Received: by 2002:a17:90a:d64c:b0:2fe:955d:cdb1 with SMTP id
 98e67ed59e1d1-3086415ce8dmr5382416a91.23.1744882856771; Thu, 17 Apr 2025
 02:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <185cfff812b952abb24e25dfcc8bab7c65da6214.1744787186.git.ktokunaga.mail@gmail.com>
 <4962b53d-c507-49df-91b4-cf51d724e8ea@linaro.org>
In-Reply-To: <4962b53d-c507-49df-91b4-cf51d724e8ea@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:40:44 +0900
X-Gm-Features: ATxdqUGA5J1i1cY3gaT0zt7hUBvEXbJ-92uPofOuCttG0cZ-o8_-C-TylCAxRMU
Message-ID: <CAEDrbUZZ5E228PgRiykPdkdOSS4qU5V_wh37x-gvKxZr2Q_-xw@mail.gmail.com>
Subject: Re: [PATCH 19/19] MAINTAINERS: Update MAINTAINERS file for
 wasm-related files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000da4b8d0632f63285"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1031.google.com
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

--000000000000da4b8d0632f63285
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> Just "WebAssembly target"? (I'd add the future
> tcg/wasm/ files in another MAINTAINERS section).
>
> Maybe better to squash with patch 17? Or start adding
> the section when you add a new file, then update for
> each new file added?

Sure, I'll update the patch to follow this approach.

--000000000000da4b8d0632f63285
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>&gt; Just &quot;WebAs=
sembly target&quot;? (I&#39;d add the future<br>&gt; tcg/wasm/ files in ano=
ther MAINTAINERS section).<br>&gt; <br>&gt; Maybe better to squash with pat=
ch 17? Or start adding<br>&gt; the section when you add a new file, then up=
date for<br>&gt; each new file added?<br><br>Sure, I&#39;ll update the patc=
h to follow this approach.<br><br></div></div>

--000000000000da4b8d0632f63285--

