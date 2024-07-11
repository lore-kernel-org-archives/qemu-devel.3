Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC92DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwxw-0006aJ-Fs; Thu, 11 Jul 2024 12:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRwxs-0006Nx-97
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:48:16 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRwxq-0006w0-Or
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:48:16 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d9c4887533so614960b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720716493; x=1721321293; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWkqVfHh3zq67hOlTFxTvfMTxq2saTCDbMKvtgiqG/Q=;
 b=bwXFW2ZHRomffV3n4xWhQirhC3if2TzOdhNmkucV+nVlQHPCZC0JWmDWr5JUojBwiZ
 iK75O2/xlZ828XY6vOzovAjLWKz05LWNK2EF9qgOBS1BFyrx8l/5qg7pEcZY+gGujukl
 b8rFL4klzcUwx6RdY6aWgjqzAYkNQQAScT2WUfKLSa4fNe+P/mBKZdl3rtESCrbbHOe5
 nG9MDO5cFVU5/gfkvC/HOPbNkM1jY7XR1Bwmb7eZsBFlOVOXymBB0SSwHlbmWUkhXMrH
 +droVypXM5dlNcf/S2FqCCzl2EgJRyhx1RxAnSVjE/FbV6jkR4SAqHtfPhUTzyRz+lmP
 E+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716493; x=1721321293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWkqVfHh3zq67hOlTFxTvfMTxq2saTCDbMKvtgiqG/Q=;
 b=KYPyKiCp0HnDNlsh9syrGnXNjaJXiZd5rYktVIS4cVMmb8B6B4rYvp5VNNzyacbRrI
 UuSKYJVW2GF/1r6fne5lcmXfVbb15QynY9UKFzCPJB8wtvWflg4T9oMZySi+FpgvJVqd
 +q71lSs79xmviWw7d/xs8BRWd8lNFWoR52Za4HTckjH/jKN43N1EH4wQ1dt7XNqSrOVe
 xK3JIzPUVzyi+HmficS4mGLhQp+qqDp0C7rutqYEaIcHfG8aNV6yqlDkRyMNZ6tcZGYZ
 orLLYT9rsJhAPFoq16ME5M3wLSzjh2iVFqhMJeS3Mc89yn78Bn4gl7j4WAYDKkmHE9MU
 6u8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvzPMlOE2v/+J1BvUjWKvRuFje8kM8n7XzLbN3iDCNJ0elU6gqO7NIZinaCvp+kXEz2u/bd0tdgBftSIZABh8N79b9eO4=
X-Gm-Message-State: AOJu0Ywob7i+tOwPdqo8+oE3ksb942H323Xtx0ueYqKbelu7YV3n3mMu
 eCpbz8ReHS9ftdzlJz7XjkZgCKrvvWA1YE7iGA0F9XXgLq8Bakgxzp+xo/EJU86dLyWlFX/Bizx
 im0+c+k+RMD4lDvUOceBA4ABUBwwHaJVp9m0P/Q==
X-Google-Smtp-Source: AGHT+IFdMDmUEpG7ov5g9YJhrBVTH4JIVvC41gUmf1K/U48g4yYws1LpM+9c4k+epeBoZ4kC1wUK0ostWg8J+E/DK2k=
X-Received: by 2002:a05:6808:18f:b0:3da:3207:edc3 with SMTP id
 5614622812f47-3da3207f50amr3869883b6e.2.1720716493540; Thu, 11 Jul 2024
 09:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <Zo_98z3zmbDM1H40@x1n>
In-Reply-To: <Zo_98z3zmbDM1H40@x1n>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Thu, 11 Jul 2024 09:48:02 -0700
Message-ID: <CAHObMVYkwyNHSsQuN_bQKSrM4SvwPW1NU_G0Xvs3GD_LTy=7=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/5] Implement QATzip compression method
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x234.google.com
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

On Thu, Jul 11, 2024 at 8:45=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 10, 2024 at 07:52:24PM -0700, Yichen Wang wrote:
> > v5:
> > - Rebase changes on top of 59084feb256c617063e0dbe7e64821ae8852d7cf
> > - Add documentations about migration with qatzip accerlation
> > - Remove multifd-qatzip-sw-fallback option
>
> I think Yuan provided quite a few meaningful comments, did you address al=
l
> of them?
Yes. I do.
>
> You didn't reply in the previous version, and you didn't add anything in
> the changelog.  I suggest you at least do one of them in the future so th=
at
> reviewers can understand what happen.
They are all very good comments, and instead of replying I just fix
them all and include it in my next patch. In my changelog I do include
all the changes and comments we discussed in v4. Sorry I am new to the
community, so I will reply "fixed" in the previous email before
pushing the next version. Thanks a lot, and sorry for that.
>
> Thanks,
>
> --
> Peter Xu
>

