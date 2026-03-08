Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89512F5513F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 13:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzE5y-0003qd-18; Sun, 08 Mar 2026 09:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE5v-0003qE-Ta
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:22:55 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE5u-0006Ld-Fn
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:22:55 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79495b1aaa7so93619227b3.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 06:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772976173; cv=none;
 d=google.com; s=arc-20240605;
 b=PPYeZU2gljAaTdPuHH8maPMBzqjG8omow4m/6sySszgshOq3GFipFatx0UTzWAsbOP
 8WLtnEdhJNSFhWzoctcpw13J+6IRJsG1wtVm5YnVsmMvmAJJU1vJYMjdH4uKzPwD4nY8
 pIduQjHaSzH44QOC1s8Lq2hi8Xe9DpFHQcJD0DAl4aizHgn/RcwRX2X3mtwbibDbEWS6
 cu0jYqgmFbP2/u4JqKp7k7PZrwV+NXWCW27M1qg83dp52/wYCgAEUB7SNV/+NQZitbX8
 RJg8PcSWaUs52oe/aHWBCNhvUW8DNKjY5JlRwugWz/Tq2CafFvqEl+ka8HHCdkIyxERf
 HvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VogvfXjIsNNJ05/YtFtqAaBEw2PF/2qocca8wrzZZwA=;
 fh=bOjPkmr4ek6Om+3EEoGyd2p+LFwujOt9ZQcr6jTi7HM=;
 b=VA7wYgWfvMA+XWcIyfkse6uq0ECPlfcBWmqUda6+Id9A4nFTG5nM10Q4D8y0wQxZ05
 ggJ1FDfV/CV4DEx0edIIofS5GEzAkW4cJeY9QmV03W/0FN2v/3cQSJd3vHFNojfThiz7
 ci3Nnb30vB9WIBD5Nkj9PP/hredc751Kg6URQVwKOXRLsrZsZyTDmJJBOXZzebC2X7NA
 q4Gwoap/SjVxZzCxlYouV0MNW5+ijTx6bZCOevZN53lgVvENAHnE+N76I8IWIx8sIt93
 G4Nx4q2gHLPVMsVmWVe1sZkfaB0fVNiRzko+ZBXZezl63P5h9acfoaUB8Ge73ptSe5Xc
 wd7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772976173; x=1773580973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VogvfXjIsNNJ05/YtFtqAaBEw2PF/2qocca8wrzZZwA=;
 b=s8L9xnosX5EZufZV/zEkkR/TJwO3YxJxeDf6uBsgRm+DxnG4bAOGJLRQFbLiDWlini
 pjDfww8W3v5MgAqN7tQGK5Cis8kuW916xgWCdEs2Vhea94E0+BB9FrjGXrveTgyK2Nt8
 V7XHa6lmq9c+54aWoMumLeuPYfwUqxHNmsf7CsRqLpdD6uMCQn3WbDKk57L+pkYO9Vl5
 m/0bYre/H3iOWYE7YwOzmSyJZn1/FAPtiPYZl+/KM3tabOjdPmSqJmFpliBVVuP6OsPk
 cd+8YDkkXnW5OlCvA0eLO6w0cIksYdnK0375oifX99/ueG+ow1kJWDaqlf+DgdlmmhiU
 awsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772976173; x=1773580973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VogvfXjIsNNJ05/YtFtqAaBEw2PF/2qocca8wrzZZwA=;
 b=VzJFl0MQ4ELo386oV7FqJv6BwaneJIzBZXGMEifom5x9zKq5OpV0rwPxM2gRkQc6BT
 p4sAXEmLD0kw7iWe1bHxwwyi60Zxshogxx7Xjp/R8iRD0NhBTVPTtLnx0Qb0NanlsEt7
 AiukpqdY7SryJcng+oIUkPS111j6ryzMDLuLseKNfA08jQ7Hbu8InT3d1hqE05T0PwwX
 NQh7D8fSQsszcgKyq/YcFt9miVb98/jSYIFk8XKrxTrcGP9Z2/Uk7RFQ+qVv98bHd33x
 SHkHqcWSKkHDVp5ebTPK8DFCWQtBXgQiNqB0NTs+A4X9U48QXccBOKKVc9fCYJDCYSTS
 bukg==
X-Gm-Message-State: AOJu0Yzamb3PZgdyMztH+PS1mO43pm0aELXE3N98wDCHV6ye5Prlfm/W
 Kgld2gAUEc5JPsMBsTXqjk+/hU+TdCNl6OpU8TiSY9GJJksImyynea1tx7XPkHL4mrL64bPKetm
 mU9f4H8ggwVc74zRptTFR2ZsuSW5MxJgZHF26bsbknQ==
X-Gm-Gg: ATEYQzzq4nT4wS1etD35vEbG6UhN0/Hg/hyc4gKW0jHf+Mqas51g01ntTlT19CZHL8C
 2nw7XdEBXT0mMOg/PCmqtZ/UfhneOwadJ8/wSCAuCH/UhGSWaChHfEmuhn7V11klwRO1CpipjZj
 sqe4vSV4BEq1fAs9BQUiZ1MLveRANFL7Pz/zl917jh+J/oWg7V9yzpZOWdLmVcgXUmVpVuVIm2F
 3m33bZJ4BjdP7zDgTtxjm9iTJditYN4BBDrYjglfzCA51QJZT6SnzC/7FJkOKCnmSrQ8dVMYOVV
 uufGit1sIespT/mbrQV9GQePV7idJKwNveBG7RBJOOd902ps61FRffb/8NkNG1p9ajVtYTVv/8U
 PaA==
X-Received: by 2002:a05:690e:130c:b0:649:e871:3eb7 with SMTP id
 956f58d0204a3-64d14274376mr7840062d50.57.1772976172979; Sun, 08 Mar 2026
 06:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <20260122113144.2046899-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-4-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2026 13:22:41 +0000
X-Gm-Features: AaiRm52tD3aq9HmHqYSbZINab9Jgj5rbMlxebswviAvf5SrWRS2UKYOWO7LrI5s
Message-ID: <CAFEAcA8oB0ZcL_6EFX2HPqUYetH2ie291gh_W2g_=UErzqGNsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ui/dbus: fix Unix.Map proxy leak
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 22 Jan 2026 at 11:33, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes: commit 48b7ef0f0 ("ui/dbus: implement Unix.Map")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/dbus-listener.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

