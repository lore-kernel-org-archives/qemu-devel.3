Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46547E68152
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHQe-0005q2-1G; Tue, 17 Feb 2026 04:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHQc-0005pf-Vq
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:31:35 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHQb-0001fL-DR
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:31:34 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-649db2b6cdcso3648246d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320692; cv=none;
 d=google.com; s=arc-20240605;
 b=U0uuGmBM1BhJcEGaZawVjgZkW2ng8poNeKG26a7+54xcNp8JMg6OspNR3vdK2RzqtG
 YSrEiF3+S0r65oLjmW0DCsC2SI47XBfXLu380ColJBrx/1W1t/9baHeA5B3dnGiUyYaV
 vjda9L+8Rn/0bcjYKXqnSOnpbnZg4qwDPNPjHkCVz4dMkSKGr9a5vqKSXQbGwoZ+gxuT
 JNThSwM0GsQn6gdAWDJ/0KW0xACJGxnWvpI5ZrIuTmFnO8FdFplxym5zdUuGSeu+7t2J
 Iy6C+f5Y82TGYxuWHoFJ5XWIXvodmnP/Y1UrOAzuHAWBkpCUWFRaXQkFBoviQZM7/950
 wvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ol8KpwUM/iOxev0Q9/H75k8GopWcDKMCFpLO2dCIx/w=;
 fh=Eb0G1adMy2IYs0MumElH7PXQ17PLOQdR4IeF/o/cX0s=;
 b=WpcB7Hq/IGIer1egt/HVrp35Wt/eZKzoXzd7z6fWQo6LwqiYTa5n2VJGZU3quOhRM6
 jptpcd+lEv6w9CTSNOvm8XCZSG4o8e91m9ufp8yIo6g4TgBZNkp4TEfdWYH4wiK6Srbf
 EJPQfeqfg2miESvE0PlaQQ4TVD4WOz76h1qPIT7zOnhKSZdPuFax1SbVrqhC5mwl966w
 3CHKqRIyjEo9fq83I6l9dzMv+jASWgB0Ukvn6Kjhs1/KygbgZJaOs9eoF4LDrA8yLBIJ
 kbfSZg07h3/YbP8lXXkr9sP3eRqXoi/V5dGQMtejjD9kX+N/T946oU6xEZ6OkZVZuwhW
 FqpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771320692; x=1771925492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ol8KpwUM/iOxev0Q9/H75k8GopWcDKMCFpLO2dCIx/w=;
 b=rqCT9LxJwdp4zDxIa0HJmMmj6QGrNRTWHyZOYMBPlTmyycFbOk7KtMJWGfmILc6Dt4
 b2xa+31qveMVVQdRStbGiw38payJA+cfP01IzEUiwaz8DXN5IYesR/FnMmAeD+Gc4AHi
 5fo/k7VDl3LpOJtNi4N+NpMJAIOl1iUQgnGQbVYEpEGG0k4CSsi+Eqen4LEQUyYmFC76
 OnX1epfVi1QwYfcZwzfaqk5yQ21PjfIKplA+2NdLesE9cJu1aZ0m3fE51cWi5C17kq9W
 XdUcTbKmd7Skkx/X9sRAxVPgQaN1B6GVjMpbaBz71q0/QzTFJyHAZ8crF2l2Pq9t/FsC
 bEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771320692; x=1771925492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol8KpwUM/iOxev0Q9/H75k8GopWcDKMCFpLO2dCIx/w=;
 b=SZQ+OsaMyLPQlN31Ve8FLhtglbsfqDxKepUAiqKRto7w9ayC3Jdfve3ZRzOvW4kQHz
 Y2vSICcP8ZjgHgopiJVYZlQh5jPCFpBQdORU77lii44gqAJfUXGzgToS98NZc5OJD4Z9
 qwdMM1ZxYS1k2VwksSpryRhWakgehm4BXHgLd2Ssf9gMa/Hkj+7W5sjV0QfE0JiR6pJJ
 aOoSeM1eC49Gfx5W+dR9AXUq0DAPEiH3eUcoi8dqFMbxV4y8yIcWD+5PMkGqpPqsxL+g
 AHgdFhEURsHNCwAYpA09zOYgwQtrZXt1aQIdAm+bWInxzD5lgV8x+BD+HxV4nVi9EMlO
 ZaJw==
X-Gm-Message-State: AOJu0YzqbyI6WODHjc6hp6yG4joN21lE2r6oyssXjRel0K83loovIfJc
 yiBuDvjFskgyJ5KY89/RVUKV3vmJkaxiJgmBRekJTO1nXwRTzsbJs9LTOTQyIXm2dWt090kzz1w
 Lz6QlFO4FiBQvZD5Rl3O5MVB3Ejhhsr8pQsZibbIptg==
X-Gm-Gg: AZuq6aJXvtQp3usqRdQY8qz6cMNBZk6fSeHlku9r4WZMZ80nDxoP9BpRMG1z6dZYsYF
 CuUK1QrWYfoGZra1o2B/0KNeX5zptuIpCz8P/0gKCc7oLzfNPR2PazKXHLm4Puju/lBM9W2NJUp
 8ySqfAbRZbdy/DSe7EiCHTbuNFfw1HEF7i+4fz/VTjUcMYKZTLJMB1YU4hjwLPlsuxB+dfDf3oO
 xPfOCx1PZIbaWX4ZI4969664PAXGnssKVPStHisGysngBlJJ4RW9OaBDWjHTS0NCLAwA8bmLolp
 AT/1KppjaLAwKBn7G/sylzJlB6PMjeKT6Y/z9oWfrnEQ9zxxdTM9B0r/Yf9YveJUH44=
X-Received: by 2002:a05:690e:d56:b0:648:f57b:d059 with SMTP id
 956f58d0204a3-64c21b81de3mr8049663d50.86.1771320692049; Tue, 17 Feb 2026
 01:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
In-Reply-To: <20260217052740.114117-2-heifetz@yandex-team.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 09:31:20 +0000
X-Gm-Features: AZwV_QjC66UbeTzrKf1JuvoPQG56mcgcJZuTQIqkU97M4FS6-K_BhQsquT4hW94
Message-ID: <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 17 Feb 2026 at 05:29, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>
> This patch adds the `audio` option to meson_options.txt. It is
> propagated into Kconfig as AUDIO. It is enabled by default.
> The corresponding `--disable-audio` and `--enable-audio` options
> for `configure` are also added.
>
> For now, this option does nothing. In subsequent patches, it will
> gradually disable audio in different places. The final goal is to stop
> building sources from `audio/` and `hw/audio/` and other audio-related
> files (except for some stubs). Note that this intent is different from
> `-audio none`, which mutes audio but still compiles the audio subsystem.

Not building audio/ code makes sense, but do we really want to
stop building hw/audio code ? That's the guest facing audio
devices, and if for instance a machine type has an embedded
sound device that would require us to stop compiling that
machine. I think it would be very confusing for users if
--disable-audio meant "we will silently not build half the
Arm boards that have a pl041 in them".

Maybe it would be better if "--disable-audio" meant "don't build
the audio backends, and everything behaves as if the user
passed -audio none" ?

thanks
-- PMM

