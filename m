Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86365C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRMM-0004Ui-N8; Tue, 05 Mar 2024 04:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRMD-0004S0-KN
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:45:13 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRMB-0003ZD-IW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:45:09 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso7832161a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709631906; x=1710236706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAIl01WGOF0F2UYKMcUryilupG38mJbdkfGRs5fn+nU=;
 b=d5/gS/ZZgOzf/2cip6Blz9UIafJv6OctpkWQsONEIsymmT+pWRzTiBhwgqfkb6M4q9
 xZ4gK2n8qt7/4bQfY9QbR3jL9JSiv/BCx5NFbdT3NTdWtnQzKU4KZGOhQnlBO/TnGTFz
 mjrDE/GKjLJTOlEdQJ9kiiiX7hYsBAQRwNEZilMWSwx8glNB8SspUTK6qyt5EZQ03VFM
 KukLrnHv7qkoajwetlwEhN6sKvAh6Yr6wvtcDSbUE/S6ePCzBBtG/u7Qyy7jnfoefa52
 /pV1jHFbIi5pO/Ms64qbrOg9Uka+bsb93j2JXXb1KcS9BSzQhHNuR6Verfstgxec6jaV
 lYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709631906; x=1710236706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAIl01WGOF0F2UYKMcUryilupG38mJbdkfGRs5fn+nU=;
 b=EfVMJs1eQBHyDvYnVqbmpYGK7MGXMjrE5nzxVfCjWH2GkM/WxO+O9/r56IHlq22AfV
 +k8tnA8dXfjWfvzScN1JUJvZblhGwSrJFs0btvhcazr/5ZXk1VEQaEIGz6N7uqJdASih
 UPCxiRq0GsR86+U18aFf8GvM1TxrFJmBH4himjFeF0ueX9okNYe+9fxdzX7U+Cpxh3ed
 Q7Xr4uZ5gFi1p8DOFI4uXHhaDaviAu7kUFz6yyljq7bJF77ruseagv+iqvXwyXcg0KaU
 OSlepuIdGyMcyJlCKlJoYkd3fL/eIR3WIhp13yAdFQiLrMv0ik4dnCz0fqlkPBzG4Af5
 bdpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW69zeXZvVmneJ75TLIWflTb2psumPnYFrF6FR8GWkb8//EbxRWq4A/KNsmiYNDnjkVYUckNbN4gEWYNqHYsfAOFOum3Z8=
X-Gm-Message-State: AOJu0YyHFMKNbI6xTid8PtiM0zeqFZnClpH4Sb/4zhYn15hfuPh2PUhb
 Oy6ct038oLDYlY5Cl60wDakCg0CW88ynMzYZwVYctDnWqBB6wuqDpvdEcsyGhWC+qSWthOazsHs
 UPGYaO1RgXvq5DPDi05gtU7pYRiDwI74nhcJY0Q==
X-Google-Smtp-Source: AGHT+IHsFJDedywn9K4f+VU8ZHaH0suVVF2cJDYMD2PtV1UcMl6cSuLfi04EEhC8WQDsqL7qcEYrQoHoD0jmon0Uu0E=
X-Received: by 2002:a05:6402:31ae:b0:566:1725:1c86 with SMTP id
 dj14-20020a05640231ae00b0056617251c86mr6941013edb.12.1709631905813; Tue, 05
 Mar 2024 01:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20240304130403.129543-1-thuth@redhat.com>
 <87plw9wvep.fsf@draig.linaro.org>
In-Reply-To: <87plw9wvep.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 09:44:54 +0000
Message-ID: <CAFEAcA8bq=rpANwtJWkEEQQYKWk1iM=_WoOWP0HB-8ajgq_46A@mail.gmail.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Mar 2024 at 21:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > The macOS jobs in our CI recently started failing, complaining that
> > the distutils module is not available anymore. And indeed, according to
> > https://peps.python.org/pep-0632/ it's been deprecated since a while
> > and now likely got removed in recent Python versions.
> >
> > Fortunately, we only use it for a version check via LooseVersion here
> > which we don't really need anymore - according to Repology.org, these
> > are the versions of sphinx-rtd-theme that are currently used by the
> > various distros:
> >
> >  centos_stream_8: 0.3.1
> >  centos_stream_9: 0.5.1
> >  fedora_38: 1.1.1
> >  fedora_39: 1.2.2
> >  freebsd: 1.0.0
> >  haikuports_master: 1.2.1
> >  openbsd: 1.2.2
> >  opensuse_leap_15_5: 0.5.1
> >  pkgsrc_current: 2.0.0
> >  debian_11: 0.5.1
> >  debian_12: 1.2.0
> >  ubuntu_20_04: 0.4.3
> >  ubuntu_22_04: 1.0.0
> >  ubuntu_24_04: 2.0.0
> >
> > So except for CentOS 8, all distros are using a newer version of
> > sphinx-rtd-theme, and for CentOS 8 we don't support compiling with
> > the Sphinx of the distro anymore anyway, since it's based on the
> > Python 3.6 interpreter there. For compiling on CentOS 8, you have
> > to use the alternative Python 3.8 interpreter which comes without
> > Sphinx, so that needs the Sphinx installed via pip in the venv
> > instead, and that is using a newer version, too, according to our
> > pythondeps.toml file.
> >
> > Thus we can simply drop the version check now to get rid of the
> > distutils dependency here.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Queued to testing/next, thanks.

I've applied this directly upstream to fix CI (give or take
the homebrew side of it).

thanks
-- PMM

