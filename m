Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB7EE369E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZRf-00066D-5U; Thu, 12 Feb 2026 11:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRc-00065u-L2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:32 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRY-0006Sf-LR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:31 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79430ef54c3so452057b3.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770913287; cv=none;
 d=google.com; s=arc-20240605;
 b=Iya6pQTtNcaDludZJxTUp1cXYsu5ha24mgYQucg/MP+hCZzo7KTg0vJHjCiFYxypIb
 v/17fUsV/dfwFZJiVPr7GuC7deU6dUH91/Txde+zk0rvciD8iDEh/Fbru6aZ5PsGZe1f
 BvK1qmy5xvCnwX7tL/kPa0L/ECHP8smJ8gdHnqZVBY2Zz/eXUf214YZQcr7hLiAx7JyJ
 /95A0gR7SND0dI9vg3DMe5EMxJkPlSTkD6MshPeHZ5hIfV8hrcxykNVmSe3rXGzEdlRr
 66lNZpSfJ5Jkn1Re+v2IFxgaU2gRy5QpWKY8VyrJyg3H+leTvA3xHzvub9u0ve7IKc7P
 XEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zTmufmmD9TyoNXaaRCN1RWO/D2gRiaCMRisJ1EexEzM=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=V4+SDLzF31Sv8RgnMfsX78FoXM2ipORG4nBZzSY2P6iSp1Upd8ZJ83QsK/y5CcgFdB
 XOAvqoDzFzxROOsG3UffXD35Hr03ljIBhdJnwlzXFOXZLLkZ95m4RrRUJF2q6iSI1G+k
 e1QW3z3PedCdIolTW6/eGckVs2R0+JOfzu7pOKK152OkKE2/Vq5vdYaTZ/ZIjKvyptOn
 ttghLYYxnH7Y1yW9QomlDzsq2WyTotaFbN7XrJyoZm6XQ9hz3v0He6WBy/imgZsLvuvS
 ESz3SKpTaIUtLzZEycdI1+fr96/sh+gd3I44dytNzUluebwjyv7L4lrdBTm7w+GN9oNL
 fBKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913287; x=1771518087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTmufmmD9TyoNXaaRCN1RWO/D2gRiaCMRisJ1EexEzM=;
 b=IQAjTzgwu7ci7miA2az2o+fAqBnWTgeyZ51I9SNz48ZkUhmKzX0Y6ptu2tlbQngrfQ
 zPgUiqVArEC4lH79UWi72IdF/otjHUwpHvENEVbXkTHt9eg4ZAagLKMYNZEAQqLtPVvI
 yt7QyEdOKJqbSbzYknAJX9EvJ0u037nKWSUcJoeldpqLBiV4q5hnug3vm1GJGqfvWp2i
 Gc/I/tIs/1um4V2BVhvHy2ToUfDKvjz67gFbOk4q1oqTl1jAYoahNE0xjB0UGF/oQbO4
 7ayjj4stFSKmW4yMtNJW0nWjUG1GwvSU6M4XwV2Qa7Ivy6JBVD1Tuk79NMVe+V0MBpbd
 +4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913287; x=1771518087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTmufmmD9TyoNXaaRCN1RWO/D2gRiaCMRisJ1EexEzM=;
 b=akmdI1CqzmAHMxqvp78HJlXnP0pKJNiVg3up1n2s8dgIVnXu58JDi06KJLW+W2YVpG
 yqmwMbR95yI4QLJ102k03CU9yvk702E1v4XLtnSgve10J8Ra0GWMqE65D1E80Zypeo4w
 WAQaNd261rC2oGuKsArT5OrrzK1+6xXD3ILyGi7T4MsBuSLpIvYM/ARtetRF7LXDBi87
 1DSRweP0oPHhP9fN9mAl+/TCVjMPA9E2NKLA5jd0BnyGumvgZhNWhhoMcOOW4YYn3NGd
 t8DUno6hmgaa/bZNr8hq3d+vaXFrI2z1p9F4p35mbof9iSLZF2e3G1QCFoz2P3/xsQi5
 PY6A==
X-Gm-Message-State: AOJu0Ywj44jzFj2w+v+aV3k9Je8fcG9Ql6sPDmGSht+tQ0Xhe77ZOa8+
 Yf566lOYSGhnUPbUPdiNDEyHtmQt/DakIrdJX9rzXDEc1NYQ6Ze0pKj3OWALOMYUWJPwTkPUPMp
 RdpXSO1CtNz8Bmx6SrM8rJEJp7x2ggdDfQHoytdFMhg==
X-Gm-Gg: AZuq6aI6QiWya0KE3JLxF1r5yeO8kXd1OfwVzs39vl+i8qFoOYO3D3aZKY1/kgpZwMH
 zIze2JLVNSXivpXF9/TERVpj1z4XzOetPMilkOlGfUiTLfbMKQJ8cO0Qn4MhMVHDoE5b0Rtqd/N
 p5D2JFDzpk0euRyCGhjHdGp4D1s1J3/CuaratmU2U5op8fbmJRfjL1X1o+4dedqSu7Jbj7XA/Ej
 bisTJdMZE7+w82qrHIb3qYScBjKmcMlIR+hyLC1b9S+lBs22LvFjN8Hc5JYygs02usTXOF6z1aC
 tVzOSpYWWfeZGSk3UfniJpJyzagzu6WHsEcFhOfjsasRvOSFEgGJguN9xLjfUO3yObEmKpyWmYB
 qzA==
X-Received: by 2002:a05:690c:e34d:b0:794:fcf8:f824 with SMTP id
 00721157ae682-797376df999mr32303527b3.28.1770913286946; Thu, 12 Feb 2026
 08:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:21:15 +0000
X-Gm-Features: AZwV_QiZg498SM1zvi73bYvjo8u7JE4nXtjacoDUkPaPU43zo1Rs9D38Zk18rlw
Message-ID: <CAFEAcA_xW4Ko14m_HwPXu3Xy+q-gww_w1VLiucV5o8EauV5Bog@mail.gmail.com>
Subject: Re: [PULL 0/2] Docs update for 2026-02-11
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 11 Feb 2026 at 17:18, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6=
b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qe=
mu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-docs-20260211
>
> for you to fetch changes up to db61fb7a57c79b7450725fa13000c1f6d72ab9ef:
>
>   docs/devel: fix bash-ism warning for configure (2026-02-11 09:15:35 -08=
00)
>
> ----------------------------------------------------------------
> Changes:
> - docs/devel: s/most/most recent/ ``probe_target_compiler`` call (Alex Be=
nn=C3=A9e <alex.bennee@linaro.org>)
> - docs/devel: fix bash-ism warning for configure (Alex Benn=C3=A9e <alex.=
bennee@linaro.org>)
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (2):
>       docs/devel: s/most/most recent/ ``probe_target_compiler`` call
>       docs/devel: fix bash-ism warning for configure
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

