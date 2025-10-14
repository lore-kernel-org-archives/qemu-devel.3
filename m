Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C867CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8e1G-0005wD-VY; Tue, 14 Oct 2025 08:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8e11-0005tv-QD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:20:35 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8e0s-0000L2-NV
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:20:31 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7815092cd05so5463797b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760444419; x=1761049219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZsE6mKPim6UnovYIKbCYW0pRXIEajVhHZ+GGrxaGTI=;
 b=tMyDhZRFebz+/jNJFTaYCkpPqCq6/NNOZC5L8Z65Yts8BHSkp6JO4blAFJYBChXtTw
 nIsogwws4uUaZwldxlVJ4/M70Mgxx61wiARpFTfMGuzx+0pcs4thnGpF1rhyGxwxb+u5
 yjV4c1ierrTMpg8VjavYJg6T8KaKLZKpYo1OJKMSRRc6AMxbLSkVAwh+GNbFbdol1EMY
 Kyjwe+Y7TvGR3tAkzphBJeNJiGo5oH/rbug6lRUaDwh+b2s5GypfaH9SBYZPtTgu6G7W
 UH787UGp9Y9C2k6mzUwXF0dE3qYwhHxKSqrC9Sm79zuDn+sxX5HDucUeF7/ZLMONYvkf
 T6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760444419; x=1761049219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZsE6mKPim6UnovYIKbCYW0pRXIEajVhHZ+GGrxaGTI=;
 b=OsL4Xx6rqLwEfweNdHgPa+U/iKXml7Z17NC0vPd5DlDnEIkn1vPM952LFnn34i65UI
 nSR9rRmGgCqjP+0bpUIY4yfXYXgKxqIXtU0PvQH60wepXo2X3vc+Rjd4xXWyn3Mxa+aM
 I9BahwPOW3XMPTdGziN6fNigafue/9OnccoFEBItefpFwq9ctN3Lbqu2aAIa5CEdAUwB
 KiEQQh3YpenxCfPs3icOcw1X+zy52uqGsjHlR24mMDPOCd93d4fJosXEoOGvVD1HAPYl
 dwglN6Gxk4/5fF9l60Gcdg18zTiA4sY7srzvDxJNGJaiIK6+Pbe5AwsdW/3ZJFyUinj1
 12Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqiiaFRLjLjMUeRbtZaf108N+XBNRT6HvFWp+Qy+uoCvN5DAmbA5F68FDeFbBJ7SFiug16O8uh4Dgm@nongnu.org
X-Gm-Message-State: AOJu0YyHpcnFktgBzHyUucdo3wYOx21Hi7Kc/dOgNUyE1HUH1n829FDx
 SipWcUPeJl0wJtX2DvZOWaDbhCzGr73kbfZv+SZX2tlejhiF+iBwi40WRBM+CBnmdBhXTZJz3TP
 84+JpF6h7Jydcy7kc+TJeRGekBnGfQ8P9riNuvwThsg==
X-Gm-Gg: ASbGncvhhHKiFH68NNZ34TgONo2mwb1uAZt7zAioK7sHeiEUn7GAg+hsa5kYYN3vt6T
 95056dRHFbk6ehDSwIFjS5B1qTH+xLONeusbmybJ0mP/JAE2B7pV9HSzzwFq3tLjmdYxM0kevAV
 1HPDVuzNzZDT/gItzbCKsRM+KzHfcWIjVjESDtoFKbeiul69wdThq0y5q/DXs8uPP20YuQUKxvS
 1SaIO/eGs9nh+7c5zTTSKVMeyhGxshivuhrhFYNKw==
X-Google-Smtp-Source: AGHT+IHAgIYVH/8y9RA7HtL0Duj/kpj10lYiKT08z6nnI9/wFwls96d7c9ybZx7aSQSEpwXIDBWbrTXM+GdcbQP4tfs=
X-Received: by 2002:a05:690e:441:b0:636:10a7:bf74 with SMTP id
 956f58d0204a3-63ccb8deddbmr16270808d50.34.1760444419197; Tue, 14 Oct 2025
 05:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org> <aOzm2ukHfkPF-zhT@redhat.com>
In-Reply-To: <aOzm2ukHfkPF-zhT@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 13:20:07 +0100
X-Gm-Features: AS18NWCpyBDDxbsI5paL4W7KzafmVC7Dll7-H4ZusaYlEEs4Qz90PWhoWWnAe-0
Message-ID: <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>, qemu-s390x@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 13 Oct 2025 at 12:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> With a very minimal wording tweak our current defined policy could
> avoid being a blocker for enabling KVM in imx8mp-evk. In
>
>   https://www.qemu.org/docs/master/system/security.html
>
> where it describes the "virtualization use case", we could simply
> tweak it to always require a versioned machine type
>
> Change
>
>   "These use cases rely on hardware virtualization extensions
>    to execute guest code safely on the physical CPU at close-
>    to-native speed."
>
> To say
>
>   "These use cases apply to versioned machine types when used
>    in combination with hardware virtualization extensions
>    to execute guest code safely on the physical CPU at close-
>    to-native speed"

With the suggested changes listed elsewhere in this
thread, my current manually curated list of machines is:

aarch64
  ``virt``
i386, x86_64
  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
s390x
  ``s390-ccw-virtio``
loongarch64:
  ``virt``
ppc64:
  ``pseries``
riscv32, riscv64:
  ``virt``

If we say "versioned machine type", that puts these machines
outside the "supported" boundary:

i386, x86_64
  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``
loongarch64:
  ``virt``
riscv32, riscv64:
  ``virt``

I can certainly see the argument for loongarch64
and maybe even riscv[*] still being "not supported for
production security-boundary stuff", but do we really
want to say that the Xen machine types and microvm
aren't suitable for VM use ?

[*] Could somebody from riscv or loongarch maintainers
say whether they think these machines should be on the
"security supported" list or not yet ?

thanks
-- PMM

