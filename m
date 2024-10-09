Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A0DCEE342
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 19:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syc6T-0007dU-Cz; Wed, 09 Oct 2024 15:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc6R-0007ci-HL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:12:07 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc6P-0005fQ-RB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:12:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c91d0eadbfso84810a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728501124; x=1729105924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqjqRL/yO8OlXDQsNrgrIM5mfnKsOR1zr3SGkrLhtEA=;
 b=jvJKq5i0g/d8MUisxmP9oYxkFwB/jE/CPLOHBsfAVaCTokGoih9Kb9T22VNQ3k0hYY
 QaLzr9I8y3oJR24tYpiHUlzK0ftQs6FbsaZgKh9oOcZ4xs8jNyODDWMKrqkKx7BNblQ6
 PKtG3dGOvo1/pooY0MSSYmf0fCmNtQ22bnt4erHYjf6D9R57tkWhNiBndvVPRKPmKwsD
 yyZt7PnBlXJEs/F3dP43e7yyJyLxwWopU7F/nVnuday3T7jBvOTAAjcC3rodgUJTynkk
 ecOrTCaiJ2AglPpgfkxWnPp/ESv+RsjNT9Jybck9XQmVUxCKrJeVOPgKqm2PsFEvNyvL
 4S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728501124; x=1729105924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqjqRL/yO8OlXDQsNrgrIM5mfnKsOR1zr3SGkrLhtEA=;
 b=CLXMw1FVFHrVR6nNw5Ye04573OK8Sy/YYeGGSeU2GtrnScPqhLQ8tE0fp4Q1agvk4N
 lmS+WSjKjz8zqo65xFSwfKODwqpFniBHSw+aYvQJE8maO5wTW5+lPXb8/DiPPzSf8alh
 tNZuvVjuCjQMDFjHNlq78tHEEmhkQGnbjA3d2XIBc3+q/tERX0h4naFaBfnPY9Wi7zfk
 wAuvoa+ncS+FljWtnh/0g2h37PQKrv0ldIx9jGi1AngV3/JPb0XXKZLtf5rIBdAXreVY
 jv1Rr6DmFmYNZh6rxknAIpJRb4V40K3/lqRm/kwccrTtB4hLGhcIeMco7dzjxiy20S1o
 EOvw==
X-Gm-Message-State: AOJu0YxADNK3E3PkHgTdU+MJEby6QnuAUEmmlaAZ5gVZB2vDwEjklcIn
 lfMvy05sCf8Vb5EDv+oHjM3surAhhlYiC4ZY2trNtb3lMgG0mkS/G7EuRitk8NcgCIyctKqFGGH
 qcDyqJ1E191HAVhXrZakZhF7kZ6ERElEQQ5PEjw==
X-Google-Smtp-Source: AGHT+IHGtSu0agwiJXGjuBPoYGS6qreosDnWZNQst5RjcpVUgp0ax8xJHL1p/ERYmR783Te7fPA13RV8joEAxoLGDAw=
X-Received: by 2002:a05:6402:3513:b0:5c8:79fa:2e3e with SMTP id
 4fb4d7f45d1cf-5c91d6fc258mr3096410a12.28.1728501124122; Wed, 09 Oct 2024
 12:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2024 20:11:53 +0100
Message-ID: <CAFEAcA8OxFM41MMnZyDL5Vz5hdaFJvnUn2++ZnchrCJFCetfpA@mail.gmail.com>
Subject: Re: [PULL 0/2] chardev patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 9 Oct 2024 at 09:39, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 2af37e791906cfda42cb9604a16d218e56994b=
b1:
>
>   Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu in=
to staging (2024-10-07 12:55:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request
>
> for you to fetch changes up to b74cb8761c68275240af0826086590a03a1f419d:
>
>   chardev: add path option for pty backend (2024-10-09 12:13:05 +0400)
>
> ----------------------------------------------------------------
> chardev: introduce 'reconnect-ms' and deprecate 'reconnect'
> chardev: add path option for pty backend
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

