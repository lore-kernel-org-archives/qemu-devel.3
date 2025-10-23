Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BDCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsiL-0007Ss-23; Thu, 23 Oct 2025 06:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBsiJ-0007Sj-OK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:38:35 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBsiH-0007Ug-WD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:38:35 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so666865d50.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761215913; x=1761820713; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9kmLl3P36/yEEM09lnpiD4uIE10oSCPcTYAukiM3g70=;
 b=MJzzDvi/3c+Gam1wpRoRA9+svonGQ27bbF5JRZDc2f0gWdeSvvEghKyJpIG4Co77HU
 kcgXLa/i5+//dVrqMDLp62wO239Wj0wdYlc2Fj+rymFgIQQneR8rJZFDdFRfAgPGMFch
 vSASbHD5unQ4uLgPhMo0BCpyPsxx8698ntl8OH1kD0AS4snjwtq3yqcQLGPFjE8yFUE0
 CRfCTAnH+G7FFFwWrC5TqFtevvV3Xo/HSEDVmv6NKFrpGtjaFI4YhC7XzukNLvdNsqNR
 mKlCqVqPBWATpQWzVv4RMKxHdPYmNzdKf0vs5ZQx9CPfewvl4JPVpY6UH7KrcCk9dQwH
 BsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761215913; x=1761820713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9kmLl3P36/yEEM09lnpiD4uIE10oSCPcTYAukiM3g70=;
 b=fgCJ9NvG0yUHlu/4+5SBlm4/WLGBEwwqPj+4/VGsU8ghs5WtPTnu+9FQbr4XlwaOEX
 C8PYsi8Z3tgUaUhQg+YFMUJw3JPxIge6ZhrrqNYjpRRdZPv9eWy3GBj0BFuspt7/ui0n
 ZO89d3E3kHL837kBs6XciviNxvkbttaXqnY6zmnKjLokECUkKltE6vT3/rvkgg/yQEbS
 3R179V9vYmohZ7KsW4JRJ8ebecGR2fkLqnwH917RLzIDGvno3oK7E9YQfleJJVDy9M3B
 NSIRQY7Zwq1NmoF124d9ZyWSxKnds0QpBeEiGuX2xetQnw9O+YZI/zJisdBNhwZ90Vhn
 NyeQ==
X-Gm-Message-State: AOJu0Yxh6FIomknZQHh6n8jJxQtmd+U2J9mmG5FHhKPLL/t9HCD321iK
 ZeWh8PVOPXm3Oi+UiACFpRdtwlQY43syoTX7K3ofeTaImNYJuSL4xdixVOUt1wY7OzZa/a7D/Nb
 ETxb1KxKEbKoPR2XKzzCRMHh/H4V11vs0y5M1QKkd9Q==
X-Gm-Gg: ASbGncshb8Dzt4ByqzxGXgmz64whfOzRCt2/FnTbAICJL52M/Zf+K1YUox3TgGuFJ+6
 QKBxCBh1e6KJAonTZ2I5Yrm14scsoG0tSsllC7I4x2njUVKmHxCD98t6aHrW/vqIgzFNj99POg0
 pO6CndvvuHtYN2R68SwVm3LRO7otRQ6/DnD3V3nw+fSd1U/xdtRkEU18WRkQxYaQePrPXoCYU/8
 uoTG6l74R4yt8BWZvRkQ+KnBiHej7f8M/nA02OT1oZoty2RECjbyj0WTYK1Imye0j/VfY1D
X-Google-Smtp-Source: AGHT+IF5IUYbtDN0anuUq3PbAGGCww7O8sYanRiThAA7P6njZVKEBzM+rboIjtqUxFv2mb7bmhA4eQ8zhy+lGSfUwzE=
X-Received: by 2002:a05:690e:4106:b0:63e:22b1:21a5 with SMTP id
 956f58d0204a3-63e22b1439emr15308547d50.17.1761215912533; Thu, 23 Oct 2025
 03:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
 <20251005194734.4084726-2-samuel.thibault@ens-lyon.org>
 <CAFEAcA_P2=kv_WZZP7k_5TRvTmzo1NMUq8r+sMFCRBApORXkKA@mail.gmail.com>
 <aPn_Jtkj9PWHkaQ7@begin>
In-Reply-To: <aPn_Jtkj9PWHkaQ7@begin>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 11:38:20 +0100
X-Gm-Features: AS18NWCbiRMtPdUQNXcDtcy1u5xgl5dopivz-QPRCVA8DZHdYteic2PV7Ez3aYA
Message-ID: <CAFEAcA9z4psGV90FtruCKjcGVpU=g9ZO=r7eFh8FpKg4=GaEzw@mail.gmail.com>
Subject: Re: [PULL 1/1] Add a feature for mapping a host unix socket to a
 guest tcp socket
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, Viktor Kurilko <murlockkinght@gmail.com>,
 stefanha@redhat.com, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 23 Oct 2025 at 11:12, Samuel Thibault <samuel.thibault@gnu.org> wrote:
>
> Hello,
>
> Peter Maydell, le jeu. 23 oct. 2025 10:58:10 +0100, a ecrit:
> > Coverity worries here about a possible time-of-check-time-of-use
> > bug (CID 1641394). This is a heuristic that tends to fire even
> > when there's no interesting attack possible, but I don't
> > know what this code is doing so I raise it here:
> >
> > > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > > +        struct stat st;
> > > +        if (stat(buf, &st) == 0) {
> >
> > Coverity notes that we do a check on the filename here
> > with stat()...
> >
> > > +            if (!S_ISSOCK(st.st_mode)) {
> > > +                fail_reason = "file exists and it's not unix socket";
> > > +                goto fail_syntax;
> > > +            }
> > > +
> > > +            if (unlink(buf) < 0) {
> >
> > ...and then later we do an unlink() if it's a unix socket.
> > But Coverity points out that an attacker could change what
> > the filename points to between the stat and the unlink,
> > causing us to unlink some non-socket file.
> >
> > Do we care ?
>
> It is true that an "attacker" could be pointing qemu to a symlink to
> a socket, and stat() will follow it, and they can change the symlink
> into something else (a symlink to something else, or another type of
> file), and we'll unlink() that (which will not follow any symlink, so
> just unlink the given path).
>
> I don't see which harmful scenario we could have here. Either the
> attacker has control over the given path, and we'll just unlink it, too
> bad for them, or they don't have control over the given path, and they
> won't be able to change it to their liking between stat() and unlink().

Yes, I agree. The "only unlink if it was a unix socket"
check is essentially a molly-guard against a user passing
a wrong filename. If an attacker bypasses the molly-guard
this doesn't gain them anything. Similarly, an attacker
reinstating something at the file-path after the unlink()
but before slirp binds the unix socket is pretty futile
as it will just cause the bind to fail.

I'll mark the coverity issue as a false-positive.

-- PMM

