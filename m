Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF9CEF148
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy724-0007L4-04; Tue, 08 Oct 2024 06:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sy71u-0007Kg-JW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:01:29 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sy71p-0002yt-AH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:01:21 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fad8337aa4so59471771fa.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728381673; x=1728986473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEeUx94ADVvAw15jGYPmrrwLgrS7dmSBKBPJLH1ctGw=;
 b=GtQHlj3frzM2c8fZOLvaokioaxlzdFIfZnMiACmjdfVwJ+/bxj8z+AY1BUBw43QXIO
 Bvu7S0Scih/CjF3WkKk+SK2dM+ldyJ9s1EMPMFpP37czS+32v7X6nhgLYkVq0hE44Aa4
 MiHmtm30vEVgFbM0r7NkHwwhzWf7Q/M4o8g/ZEwEkoNVbwdMoGREilV6dLXlCrt1Nh/Z
 B8s4pwA9U31j9mYJbPhdRRoB633R1WZ6Ufu56y/3gX9opOyvw3Li9D3xSGOJrsqTpKWy
 s8UHMepk3EwYmUsOJHnvNvNCJ3a6nXvpZs4nKSjrdjKzZA3WJzVin03IaRX+G013/V9s
 J+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728381673; x=1728986473;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEeUx94ADVvAw15jGYPmrrwLgrS7dmSBKBPJLH1ctGw=;
 b=cuarJSPCLObt4FlAJOgd82hqcK5VhrR674ov47bBemHE5ZmWeDLpt8I1agQFbOXLjl
 MZW7zZwPI6Upoay2UWWP6la/OibecJFZcCVpsE7XCzwbm6qI+801TVDEUl/lmDc02K9M
 3hxdi+Zq9VCSya+mfbPrEAnGVKUtaU8ETE/jGQtnzWCkfAMeeNp4LmN6GvWo/d5hryPX
 gJPdxMLZqiRJ9uCXerom4DfbC3kgOmSlc7034W1ndYsd2KXw0k9+KjFzzhIGhf+zEbBo
 vhHBYec4AMd5wNBO9vowvsSQJwkoe5qwDgRZ6Uv5b3D/YP5K+o64I40Lnrd+AgCTG+Up
 kmYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhg7LCNkC8n3aEPzXLbubgLmLSMgRnDd+52N7YpvX++z+QSejpu9AntDr3dSaOP9hNYY13MEO50fSr@nongnu.org
X-Gm-Message-State: AOJu0Yz6H+d6BGRhz79qlZ7OPIH5Om55bH/jgOJIIGtAT05w+hPJmBFb
 JOZBLPE3VMlBBu2LruhwMo/mboC6TI/GTbS0zTHkUacLLy1RKROnVBJKd2E/eWQ=
X-Google-Smtp-Source: AGHT+IEXJ48K9Pyrjraftty58/h+OE1Fq5qeYycrcwXheXUvxWMT0GrfI9iM2qfE4fNHF80s368k1g==
X-Received: by 2002:a2e:96cd:0:b0:2f6:61d7:ab63 with SMTP id
 38308e7fff4ca-2faf3c1c6c2mr51243721fa.23.1728381673355; 
 Tue, 08 Oct 2024 03:01:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05bd92asm4098067a12.50.2024.10.08.03.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 03:01:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABEC35F75D;
 Tue,  8 Oct 2024 11:01:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,
 <junjie.mao@intel.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
In-Reply-To: <ae024a03-17df-4636-87bb-3d0313f03596@quicinc.com> (Brian Cain's
 message of "Mon, 7 Oct 2024 22:27:39 -0500")
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
 <CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com>
 <ae024a03-17df-4636-87bb-3d0313f03596@quicinc.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 08 Oct 2024 11:01:11 +0100
Message-ID: <87r08qvrq0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

Brian Cain <quic_bcain@quicinc.com> writes:

> On 10/7/2024 2:15 PM, Paolo Bonzini wrote:
>
>  Il lun 7 ott 2024, 19:56 Brian Cain <quic_bcain@quicinc.com> ha scritto:
>
>  On 10/7/2024 6:03 AM, Paolo Bonzini wrote:
>  > The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab4=
2775a:
>  >
>  >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into st=
aging (2024-10-04 19:28:37 +0100)
>  >
>  > are available in the Git repository at:
>  >
>  >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>  >
>  > for you to fetch changes up to dec4b629fc17fedcd2172066071f99ec8dcc8d8=
d:
>  >
>  >    meson: ensure -mcx16 is passed when detecting ATOMIC128 (2024-10-07=
 13:01:06 +0200)
>  >
>  > ----------------------------------------------------------------
>  > * first commit for Rust support
>
>  Aside: Paolo, thanks for your work here!
>
>  Thanks to Manos, I am just the shepherd. :)
>
>  So far I think the focus for Rust support has been on device models.  Bu=
t is there any interest in=20
>  being able to write TCG plugins in Rust
>
>  Is there a good degree of ABI compatibility across QEMU versions? If so,=
 plugins are external shared libraries and
>  therefore they could be built (with Cargo) independent of any QEMU code.
>
>  I am not involved in plugins work, so I am not the best person to answer!
>
> After watching the recording of Alex's KVM Forum presentation on the plug=
ins, he's answered my question -- he described the
> rust bindings specifically as "...might require us to be a little bit mor=
e formal about specifying a proper API..." -- so maybe
> not a top priority for now.

Just to expand a little. We do have:

  #define QEMU_PLUGIN_VERSION 4

and

  #define QEMU_PLUGIN_MIN_VERSION 2
=20=20
which in theory should stop you getting mixed up trying to load older
plugins when the APIs change. However we have only sporadically
incremented the MIN_VERSION counter so you can still run into linking
issues.

Adding new APIs is fairly simple but we have also deprecated or changed
the API signature for existing helpers. I think once that stabilises
we'll be in a better position going forward.

I'm certainly very interested in Rust as plugin implementation language.
Although we limit their tentacles into QEMU itself they are still very
performance sensitive and in C it's easy to take shortcuts that will
blow up. However the current C interface makes heavy use of GLib types
and that seems something that would be clumsy to pass across a Rust API.

Would be implement Rust for plugins as a wrapper around the C API or
implement a purer Rust API that dealt in idiomatic rust types? Would we
even consider in the long run deprecating the C API in favour or rust?

>
>  Paolo=20
>
>  This project https://github.com/novafacing/qemu-rs seems to explore this=
=20
>  space - maybe it would be good to incorporate something like this inside=
=20
>  of QEMU?
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

