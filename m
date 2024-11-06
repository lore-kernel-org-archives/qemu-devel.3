Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8790D44D58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8frz-0004RJ-0g; Wed, 06 Nov 2024 08:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8fro-0004Od-KT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8frm-0002yy-UR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730898871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJcgLcC8epk+kqVVRp8yVllIHQMhNmVq2Pwyc1nOvm0=;
 b=jN92Vcp54uyRAYvZnUGPBE/CcW3wOplN8ZDASFx7/zHqLXco0Ak94Pfk+nrJXexU9fZjZv
 WwdLqJrsM6L4oUATOJctWq/cqQN6GoZgUu6M5+L//HjvkUnCBHE0PdPy4ukN8lIwgEbX10
 CFwrEepGuU/++Jug7h7t4nZsBZ/iaik=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-kHpNQDjUP46CKbb_8bg0Vg-1; Wed, 06 Nov 2024 08:14:30 -0500
X-MC-Unique: kHpNQDjUP46CKbb_8bg0Vg-1
X-Mimecast-MFC-AGG-ID: kHpNQDjUP46CKbb_8bg0Vg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso4625780f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898869; x=1731503669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJcgLcC8epk+kqVVRp8yVllIHQMhNmVq2Pwyc1nOvm0=;
 b=elmTIpzms7jV2nxjlewsS7s0Edio6clWGN3Zr7SEo1bG/hWNlUYWI9g+2xl18srEPQ
 FFjBd9Vt1EZJKnAMQlxN/g8Ly463zodRJZkYAEBfjJtQiZG1H5xUbS5o5u3+Jc/7a0ep
 zZLbWtsVFrlEurSm6DruXRWE+5cCEm86RUiNvJVlWeiL2JnywOURNG6dYK+PY3deeDyM
 V63PdZOIMFtFzoNrZQ30ELrCdoo0LqypO6iF7K1mk3DgXSqUv76aVa0GcWC95VUib+mx
 YufZA71mJB2oagxAgsZUJQE+7847euQQz0rUVXvTLlmzcAXczAOMPGdzrtIn91oqkJlh
 bGGw==
X-Gm-Message-State: AOJu0Yz/pc2F0z3ewW36xJnIoFhn4jLq6nboisCFlsl42xGnAvbQHCXu
 wVpv/tF3MAUDNSJ6CU3lZcReEHbWshHm1A3V1fefp/OT/lDpYoLQ0GI5x3xYJ9OQPTpAbXWOKtr
 f2x4UoIjMFjH+aXEjTBg3Np77bQvlhZx3Yy7bOtCiyycFL0aX/Ef1F4QlVu7EwS/Hm6uZhqrQEC
 ZKR0qjaI1vH6pQfJ+Tw2yWEylUqX8=
X-Received: by 2002:a05:6000:1aca:b0:37d:511b:aec1 with SMTP id
 ffacd0b85a97d-381c7ac4208mr18619793f8f.45.1730898869131; 
 Wed, 06 Nov 2024 05:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf3om8iC6Jc4KGMwS5CzjDApJgrM3eGMwWq3cV7uztcTRvr+jTwCz4/GK5mO4IcKY87HQXjiGazwa3RR3NJW4=
X-Received: by 2002:a05:6000:1aca:b0:37d:511b:aec1 with SMTP id
 ffacd0b85a97d-381c7ac4208mr18619778f8f.45.1730898868786; Wed, 06 Nov 2024
 05:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <CAFEAcA8JoYxokZxcf66ivkCAMXuVFvDdrC7tCguNvQ43aAr_kg@mail.gmail.com>
In-Reply-To: <CAFEAcA8JoYxokZxcf66ivkCAMXuVFvDdrC7tCguNvQ43aAr_kg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Nov 2024 14:14:16 +0100
Message-ID: <CABgObfbzpioAQ7czF1TfPnEApykth1gJm67WZveVY9bo_FYs-A@mail.gmail.com>
Subject: Re: [PULL 00/40] Rust changes for QEMU 9.2 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 6, 2024 at 2:10=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Mon, 4 Nov 2024 at 17:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit 15195de6a93438be99fdf9a90992c4228527=
130d:
> >
> >   ci: enable rust in the Fedora system build job (2024-10-30 16:30:56 +=
0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust
> >
> > for you to fetch changes up to d20feaa9a5af597bd20630d041e5dc7808612be1=
:
> >
> >   ci: enable rust in the Debian and Ubuntu system build job (2024-10-31=
 18:39:52 +0100)
> >
> > ----------------------------------------------------------------
> > * rust: cleanups
> > * rust: integration tests
> > * rust/pl011: add support for migration
> > * rust/pl011: add TYPE_PL011_LUMINARY device
> > * rust: add support for older compilers and bindgen
> > * rust: enable rust in the Debian, Fedora and Ubuntu system build job
> >
> > ----------------------------------------------------------------
>
> This probably isn't something worth not merging this for, but I
> noticed while testing (via vm-build-openbsd) that Meson complains:
>
> Compiler for language rust for the host machine not found.
> Program bindgen skipped: feature rust disabled
> ../meson.build:111: WARNING: bindgen not found, disabling Rust compilatio=
n.
> Message: To use Rust you can install a new version with "cargo install
> bindgen-cli"
>
> Rust is still disabled-by-default, so why is meson probing for bindgen?

It's not probing it ("Program bindgen skipped"), but I was a bit too
happy about printing warnings. This line:

   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')

should simply have had an "if not have_rust", or something like that.

If you want I can resend. I know that Linaro people are in Dublin, so
whatever is easiest for you.

Paolo


