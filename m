Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8BE7E0C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 11:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpOzf-0007P1-56; Mon, 09 Feb 2026 05:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpOzZ-0007NU-NC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:59:46 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpOzV-000608-PC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:59:45 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7963a209b97so12810987b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 02:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770634778; cv=none;
 d=google.com; s=arc-20240605;
 b=POpGG6FPHxz7Beb6k1YJVBZQKG1w5oV7RL1dNpwBB+fAL5UrDWTe0XO6VeYc/JgRC9
 7JAlgTCYe9G2yDZiUuAfDL3RBFULBAYoat3HLWyZmbNebLO4negavjeMS7v7e8lEkQpg
 kRVvdHv35s4J/0hB9PjGf6rompuTt0fQ6TiKzGJCSrrqLVJMlMmlBP5rMiTrr2zERPlV
 XVtmdXMLZacbdetYb6UmMBoURnjkZ+1Ck+G9hC/9CwfL3JfjoXpKjlze2kJLxp485eYi
 VJxiQUN1a8hJyQhBqVl6XqJ5Esw9cgeknz4ULbyVmWHkUIwUsRN8W3H5mrDnNpb90Qqq
 ztew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zRwbGCoSIRXF3d2zm+DOGxog0hvRXBqqVkpI8hMuPh4=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=UbtkEOhov1+9bC4ekWgajEeuzIj00EFiJYp5FJEOuPp7CAyr3mCpZ+1vO7zNPwmHuP
 /cCPWJgjefOmtL0yITrU5nedOQwVQJZ1h0cr/QvNPMwgzGKIzH/3TDsPmL6IpkALdMyP
 ppRpypqywBZrYQigfdsxy51wv00OZmEIoJuThZ9v2Wp6tCeBnWkhlRXPvEQjb/0sediR
 VRvGfWL3HtCgU3FfgsOp48YYYHjq5bmYMJ9AV5qDOxpCQxt0fzRjYHV0JC5DqzwLhAAu
 w43srEiSqvnVgi1AQb1qCA+F3V4f0iHzJnICx7KmvCslPBjn8q2HktjkQxbqMD2aCBuV
 7G5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770634778; x=1771239578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRwbGCoSIRXF3d2zm+DOGxog0hvRXBqqVkpI8hMuPh4=;
 b=j8QfgOZ2Mk6gMMxfMiVextsunqAtcB5VetYNWC6XV7RFlZGJV+h90NlH1fMk4bqABn
 Y36wj9DRoBYj6XzGJQr883A5epMMu245W+M9vktQJl1POMLC71m8ehKEMIsozM9nt4zY
 WsYWwvupjnmNeqyElEx7vIYlKwrY4O/Z/kRNylC2KHO6Q2Ky52lr6IianI7hiXz1ueOL
 q0b5JGuwZfAfQMfuFQ3jfOlGE2cHSYYrxltrmOTawmv+uQ2GD6BXrspP64HFIzj+K8nZ
 Jfgm831fAAcFPkr5CDtD7l/xwU36mrWtwpBKmAINeGmx9zkoygpUfSRzkFOgFzLoVPWa
 ZjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770634778; x=1771239578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zRwbGCoSIRXF3d2zm+DOGxog0hvRXBqqVkpI8hMuPh4=;
 b=QT55O8dBQZuseVKvQbvKt+Mtz6u6z7g4nabyj3AdaMI/kcFEUfrRlezmoKF5LAz+UY
 LvTXbRvDDl6NvNHANytbVxI15U21axVzfcxZ4JybP9H99f2+qynoVTeEr75jJPPC7PAK
 VqPffZ/t8ZO90Q6GOZ1IETwETYMY3E5Pgwlkt//cwPaJBwKc0jR8nem4BoGe8/FAHcg7
 Zj7yTjSYOYlAq+BEt+s7BdtNCD/vAOCWkibM4LqH7gsaarzIsOwZxheQuHG5L/I6usfG
 Bme0JV6oL4C//Of6xxCr7i5rzvF01j3nNxJIVcRoWdkvdTjvXxKk6m/vY2xY0Vp1+1io
 1Zbg==
X-Gm-Message-State: AOJu0YyWNAOwFsAdO0plgADNT49WpaU6uGfC+g8mBvbdeNvQ0KNm4PiB
 aIFmqDO6fF5CaqfipqS4OyVFwNS/fWLOphblqg3fosOwXqwVNDm+EMtkuiiqYQ5gaX9puwwACJj
 P7XakmTJ1f1kPyUYOyD63RsCFScX2x2S54wHKZjHJOQ==
X-Gm-Gg: AZuq6aIsBUG7YieBmrqGhdV0AzZbb4M6Bwvy1vYsWo32+AzzmRbAJAqmLtyKWC8bJ8p
 En+MYJAH6OSU8E0/DRtaV3lLWN3dJiXkhCBLzf9xLdQRpXpZPTZ2s5erQ2SsPwSrJdQnhipXTTJ
 JBrITYDiw8XXxOSsGBieXyig4mDoH/UfJwxy0wCJDJnTkTmpbjWtb6hBGErlRd/9gb9Yjxqu6u4
 kQu8w/SgQ+iDN8nAO7S5zqr9enQt1zk4q8e8wGgLhu3lnEwD/5aa9PQzmGOPivDhSak0yvtnAF0
 ApirtBFvYAW9lBOlu48YB3MjBjsjZebKL/cV4prXDx/j3nhYhV6Ardg=
X-Received: by 2002:a05:690c:e0d:b0:794:f14c:462c with SMTP id
 00721157ae682-7952aa9383fmr203751497b3.28.1770634777588; Mon, 09 Feb 2026
 02:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Feb 2026 10:59:26 +0000
X-Gm-Features: AZwV_QjhNfL06ujPr3Sp6nzUll51upBUFmiEfQnbNMw6M01abE6IvD87T3FYmRU
Message-ID: <CAFEAcA-rhd-rx1ZCmcnxO6bxDQgfQDmF8NLhyFn5MjTH_imvGw@mail.gmail.com>
Subject: Re: [PULL 00/10] gdbstub updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 6 Feb 2026 at 18:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac=
8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst=
/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.0-gdbstub-updates-0602=
26-1
>
> for you to fetch changes up to db13b4e262bfcd7b5f66a303bcb4b81d71029cfc:
>
>   gdbstub/user: rename and use bool for running_state (2026-02-06 12:43:0=
7 +0000)
>
> ----------------------------------------------------------------
> gdbstub updates:
>
>   - don't duplicate gdb help text in configure
>   - re-build meson-buildoptions.sh if the python updated
>   - re-factor stop packet handling
>   - add EIO and ENOSYS errno defines
>   - move host_to_gdb_errno into common gdbstub code
>   - return GDB errno values for F packets
>   - bool-ify user's running_state state
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

