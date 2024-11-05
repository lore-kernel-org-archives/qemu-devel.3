Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0887ED36119
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 19:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8PdP-00025h-8w; Tue, 05 Nov 2024 14:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8PdN-00021p-OH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:54:37 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8PdL-00072O-Rr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:54:37 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cb615671acso3491161a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730836473; x=1731441273; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OmO/yvZbnYpkNp7dAyYz09oOK6ndjH8HBKv4zKmb+SI=;
 b=ofY0Wz3OaiyID6vZ3LRv+q2wAKkhJ1cLEpWlc7bx8elkMDE1UlTyUIQTaO1BXVLCso
 GFLVNzDAbDjjghPzLdaF1c8eJgxPJiTopWL3Bpc5tq4P0w10rZJA4dMK/6kCLL1IWJs2
 YrUL8fpba8whguj8cuGZGn4Wryls92aY4ZYHNvo3E44IZR10N9SeRmEV7xhLvWCIxyIB
 0qjiP95OO7FGpEMZKvd4DfZ+bFRZWleTn8SVpVjbIIXUSOSu8Oho3BudqJfxQz1yVmUU
 VRihGWcxoub8WOiUVwuPNdYLGrmCzjHcrvpBIiTwBwvcfaQaC7kHRlZkFTOvlLOm3mnA
 OeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730836473; x=1731441273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OmO/yvZbnYpkNp7dAyYz09oOK6ndjH8HBKv4zKmb+SI=;
 b=vVCSnFMTobjQwYykf8YAkoZnB3ebUr2duE0mX8YADREgjf11y8s1UhKswlpnHDvc1+
 iYkMnWiv8n9xtqKXVQoNhSSlEmo6T7pAYEZ+phiiwJmnNPLF9/Qq/7lrKW8BV1eTTnty
 hlANYP/LHkEV6IrzVta1pATAMrQ7LmoQO7l4O7bsFzVXRJ3PqoxodDBoRsnCnxdZyQBY
 WJLL0q0uMQYmGmsUT0dA+oM8Wkf0Mr0AO8VeEXzJbEMwERAkzVn/2tHTdIbBxp71E7RF
 y1GaK+hfpZWFLlPuQzwpHkv5kZRgYxH/AyBimKpcLP3gUTMGXY++vsg6O3Tv89QIBgwU
 w7Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxtbx+xKIkBAkNiUoZ1n8bfPmhwhFKBagadXaVgcVlqbUzkgfJ2D7UlX5uCinSlHjmEv+MwxQy3Gza@nongnu.org
X-Gm-Message-State: AOJu0YzCh2XBLAelphhJuiVJ6Vf+YGUHUR+rXzSo3hobT8vP/YQ16OrS
 e/ID+1Jp7+Jfs0+wzu+2aOm+ReLU2TekdxHMQecStytWlgPuLw6rIv2wk2PTn0iwnlu/XPD6KYL
 YvJHaUr9oYX1M69u3o/lce3Vwj/bjCPU3V50LGQ==
X-Google-Smtp-Source: AGHT+IFJ64XovFqQq0GfGf7gpeLLk4j9lkpJ777LaFGZhWv4YPuuyP+V2OWHGZQEkYuGMdrZq4c9Hei2QLO8PxUCn68=
X-Received: by 2002:a05:6402:35c9:b0:5cb:6696:4e31 with SMTP id
 4fb4d7f45d1cf-5ceb935a7e6mr19088835a12.22.1730836472680; Tue, 05 Nov 2024
 11:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
 <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
 <CAFEAcA84hhWu2ouirfDPbCpq_=QLQxAf3k47h0Pij8iEnOVj+A@mail.gmail.com>
 <2491bc60-9a0b-486a-8f6d-2c4c94332756@linux.ibm.com>
 <CAFEAcA85g2nX3MU5RzmBvAHT8Kis1JHhiEaBvnFFbEQkG+0OxQ@mail.gmail.com>
 <e6c33df3-49e9-4b8a-b7cb-d38c2ebee3be@linux.ibm.com>
In-Reply-To: <e6c33df3-49e9-4b8a-b7cb-d38c2ebee3be@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 19:54:21 +0000
Message-ID: <CAFEAcA9La7y1Z2-nMnJDyC_p+z-3c0EnDzEE=w5LTYtRnXPT1g@mail.gmail.com>
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, lena.voytek@canonical.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 5 Nov 2024 at 18:36, Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 11/5/24 1:12 PM, Peter Maydell wrote:
> > On Tue, 5 Nov 2024 at 18:02, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> On 11/5/24 12:13 PM, Peter Maydell wrote:
> > Is there no way to just have apparmor not apply at all
> > here? I can see why you might want it to apply for the
>
> If you are root you can change things. I have shown the options using
> aa-complain and aa-disable that you can revert once the test has
> finished: sudo aa-enforce /usr/bin/swtpm
>
> You could also copy swtpm into a user-owned directory but you will have
> to adapt the user's PATH. That's an easy option.
>
> The most compatible option is the 3rd option since I would expect that
> we will have this rule in a future version of the usr.bin.swtpm Ubuntu
> profile provided by the swtpm package:
>
> echo "include <abstractions/user-tmp>" >>
> /etc/apparmor.d/local/usr.bin.swtpm
> apparmor_parser -r /etc/apparmor.d/usr.bin.swtpm
>
> > case of "I'm using it as part of a sandboxed VM setup",
> > but in this scenario I am a local user running this binary
> > which is not setuid root and it is accessing a file in a
> > directory which my user owns and has permissions for.
> > This should not be being rejected: there is no security
> > boundary involved and swtpm is not doing anything
> > that I could not directly do myself anyway (as you
> > can tell from the fact that copying the swtpm binary
> > to a different location and running it works).
>
> I am not aware of how user/non-root-started programs can be generally
> made exempt from AppArmor.
>
> There may still be a security boundary if a user runs QEMU and swtpm was
> able to manipulate (with malicious input) the user's files in some
> undesirable way or copy the user's data elsewhere. In this case it may
> be desirable for the user that the profile be applied and the PATH he is
> using points to the standard swtpm.

But our test makefiles could equally well just run "cp" !
swtpm has no privilege here that we do not already have.

Anyway, the thing here is that we run swtpm like this:

 swtpm socket -d  --tpm2 --tpmstate dir=/path/to/somewhere --ctrl
type=unixio,path=/path/to/socket

where we use command line arguments to tell it where to
put the tpmstate and the socket.

Either:
 (1) there are places where it's not valid for us to tell swtpm to
put the tpmstate or to put the control socket
 (2) it's valid to put those anywhere we like

If (1), then swtpm should give a clear error message that we've
given it an invalid argument (and its manpage should say what
the restrictions are)
If (2), then apparmor should not be rejecting this usage

One of swtpm or apparmor must be wrong here and I think it should
be fixed. In particular, having the failure mode be "something
goes wrong after swtpm has successfully started and only once
it gets sent the TPM_INIT command, and the information about it
only winds up in the syslog" is pretty awkward -- it would
be much nicer if it failed fast, as soon as you ran it, and
printed the error to stderr.

In the interim, since we'd like to be able to run the test suite
on Ubuntu, it sounds like we can work around this by putting
the tpmstate and socket in either /tmp/ or somewhere under
the user's home directory.

thanks
-- PMM

