Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA56EC1E89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnw64-0006SG-N3; Thu, 05 Feb 2026 04:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnw62-0006S7-Vq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:56:22 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnw61-0004TO-CV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:56:22 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79427f739b0so7474727b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 01:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770285379; cv=none;
 d=google.com; s=arc-20240605;
 b=lNL2wEUna6ibpQ3gJEXNsCPkdYbXoX8GMWzZdtfTPzUT4l/UKeXDUGdG0UjbVgYn50
 jFbRUAhEJOd3obm8QqbMUiIdHutQUzgii1e1E67zb5w8jkoSblXILqzDlVwiS6m2dPAt
 1nD6fDyONcsbeJZWzbdEF3imslYqExaNUuyoiLs0OMe4S58ioEsxq5fnIBgggRsnUQL/
 Yhw0ZUgA7IlsxtnC7b+hcsAtaFYuAJQnJlfX/iWLfhamEPxlnzIxHeSq22JuDkAUG8GU
 YgTGq3D6kr9vVff4M3l5NbB+tVgnVeX5cmEzETkh02v8JPR/ww8MRMqNJkBzDzCQCh28
 7lZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ctmW4lNLh/ktnztDCKETn3W/k3n1UIhBOTtar1aNBqQ=;
 fh=gMjfbdOkdsdyugoyuRb6DYWE7E1DjTHLX9jbWQ8ybu8=;
 b=TIymXKox8/ldoXILhpYdyOm9iowvRuOm2UsjoIq4lF+7AjdIbe3qxuOb15xUzbfsyS
 78cFPpcrS8nRvDatNeMvyFKFCNvz1nNFYXCafREV8lkONIKtnkWIz0m2QIrF6KirNz1S
 aSP3yD7mhXjwTgpHBKU288eABPzQZDLrkPWsRwXUrKlkMTtsiB/7D+SolJSHYfEfMJzz
 het4GIRNaX3yrx+gHLynN69FMVITRGjDYNh0/qfX4TsZxfqKZUXcNPDD9HNXUI8gy3WK
 fHYVPXA0WsLWzMdWPLboRJxNTGpTNxgHkEDIAU2EGqXEaBz+gL6Kzf3TQKgHqel7xdG3
 dejA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770285379; x=1770890179; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ctmW4lNLh/ktnztDCKETn3W/k3n1UIhBOTtar1aNBqQ=;
 b=TdN/JExJdp6Sbfhq/W6YReg+Le7JBGJu08s5+8VRca5OqZtQxb/glfwOnjQA52Nd3D
 O3Ho1kMzOB5/J03uhdMzTnE2ya2aC+4ud87MYs1NkTY7PPUXW2jcaiyCr/AdXSX22GI3
 6tRE+0dZ8GihWjpSNGoMRoyqzXhG/4ljGJRTpatzRUs84POZApZyRhCsjtwR9IRMnB0O
 faHbaF6qUvJN8QDdalkOyc32N9y2xaopu+GOjFzzaWmOnv+EnJb3qDgerE5WLvNaDojL
 pG7MSUz0bMLhJSdZvh0h5QaywI8G2Ocy8Fn71WGkLpHin2t11uSTBdLL299bRXotV4Ey
 9QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770285379; x=1770890179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctmW4lNLh/ktnztDCKETn3W/k3n1UIhBOTtar1aNBqQ=;
 b=QPdMtSFITlgnrfpQSWNUUYjDlhG/7VAB+vM9I9SaPEF9mR5OU6aC9QdQ1hlvi1kBqX
 nqW3WR9ee3wPniLJD5H/dgs6glcfGT/mUT5Z6btcq/vBGE/CqDUNNUacASbGENKLN8Ts
 cOYyPXn2tZPpdZ2YLrkTuyiudH44wyQl6hRVZY65V41mpHO2lhMugul7AXfapXOjI+Kr
 wwDB2x0RDx22Dxx7kW2XpjVSIbFcZuUwgAzMX4NvtdQ6zsaq757+REa+em1259iTD0j9
 V7aBLfnfh2GfZQhIeU9Zio5I4X0vLaiDCxbZjVwKhFhr3KmrohjshYKxhEB6hzxp9k4O
 eMgw==
X-Gm-Message-State: AOJu0YwcnrC1uOCI84/PN/S6gLWhteDeLqESii42U+wcrCs7c1FF01xu
 PB2Z+R7HTyVp6+ix+DZDIF0ZImBWs1HxyTxmm5LBcDRFfSp8uql6ar07BgD1lAkg6RiXkxE1cHk
 dl+A0gqnWLYnOMJkuzEF9i99xCEbakK9RvNJ1uVJUFw==
X-Gm-Gg: AZuq6aIAEhD+fb/Q/r2tSnQeCUzVQ2MDoGj89NDCP8AI+ZZB5D2TbgEG2Qj/qcy7ymj
 73UuhepGoxItVZADFcBGyg/4orUj1CslTFmkvSQPBw8yFR4j1hEmom8g5NtIAKVNvKaimMfEJfN
 EYZ9zOFy8ZAFYXVFsux9Upu9Ycxiso/lVrxmmLe/4ZSpPu9+1mvb4i+d5/eMgiJZZhOKbcnXV3g
 rf+kt6B0XA/GUhMmolu7BgS9xO+7EqPbfDLwDUy7NfA+lQq98wNrsqGwAWKyB2oZxEQ3g==
X-Received: by 2002:a05:690c:968f:b0:794:c5b8:7d1f with SMTP id
 00721157ae682-794fe6a7098mr49550897b3.23.1770285379568; Thu, 05 Feb 2026
 01:56:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770231744.git.mst@redhat.com>
 <20260205015022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260205015022-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 09:56:08 +0000
X-Gm-Features: AZwV_QgGRTNoWc_kwy1DljWG6r73zGI2X4SLU-zb_OBRrFUYjl-QJWKA1bsNBhI
Message-ID: <CAFEAcA_x3jc=UHm_D8jDVW-6DwV3hcabX3wU+jkfNyvg_Tehrg@mail.gmail.com>
Subject: Re: [PULL 00/51] virtio,pci,pc: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 5 Feb 2026 at 06:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 04, 2026 at 02:16:23PM -0500, Michael S. Tsirkin wrote:
> > The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
> >
> >   Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 1ef708ee4b765b9eac097192d54b69a603589f9b:
> >
> >   hw/cxl: Take into account how many media operations are requested for param check (2026-02-04 07:42:50 -0500)
>
> updated to 591fb214b96be2fab1dcf41282e567d6b64e613d now.
>
> It is the same patchset with 5 patches dropped (and tag message
> updated accordingly). So I am guessing it is better not
> to resend the whole pull, but pls let me know.


If you make minor changes to a pullreq, you don't need to
send the whole thing again, but please do re-send the
cover letter with "[PULL v2 00/51]" or whatever in the
subject message. That way it's clear that there's a
new version.

thanks
-- PMM

