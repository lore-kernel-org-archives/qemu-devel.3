Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E2CA6CB8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfNQ-0001h6-CJ; Tue, 27 Jan 2026 04:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkfNF-0001ZV-2f
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:28:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkfND-000438-Hr
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:28:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso31494705e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769506113; x=1770110913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUbuZFfL/MnqHFKlqXZB/ivTGI0IaYHmhP5WLKZzOac=;
 b=nqo2yLGPfCViQMtgSSVncTkwsAfIzgJYeKv3cgzQjs8Nl+S2yfI/iemFnF/GJPfF5y
 UDPIymHesGp2k9PW6kGdYHFRd4wtOvE4d1/IcAVoz1c7Jrcwo9mc9lX4FlVmcc2i07fg
 OI/hqv6SUiA5QRAin0Qd6ksOe9xoWskmm+Jl/M7c2ZMM3/Sn6555qbArk10LW6thp6vW
 6i4dzxlo62BvpTp/ri5a6y0+klKaH49zTy5BKvcjXGOL/fquW5GcguKUpnzTYfxz/fOA
 bu5infp6z+0fbU/HYR1Ne1PdsGvMZiivyigiT85caSeYmGqcCxaYsuec3i0ApnDBD/Pn
 t6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506113; x=1770110913;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUbuZFfL/MnqHFKlqXZB/ivTGI0IaYHmhP5WLKZzOac=;
 b=Yyn803EqAV/LF6I7MDwNe9z9Amy+/MAX62essi/b7JnA2oQSF/d2HGrPWQGqwpBWL+
 44qKF+6g0g0/DXzDau4tPcAJrFwliRK3JHsIDxH3hCjGlhbJdDnQfb+E5y9aXrcU8dzL
 1iinz/erEliXX/KE1PeFYCz0ZdSiXEjXsinbUOgGe69dflfQWdf5Hx8oaNs2RUFu3VVd
 UV5VGJvkKsy0GnFXsovTi/sWnGV4dkRbfhwia+iwV31Dlmvd8pOWAS90ta0nkiERVDcI
 bJrDMCsDvU16pmuQeEY9+6YItWpWTVHjh0c07mER/ZeEyx3Ey6u/5dPGVOdYaZwQbROc
 BAcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpwM/+MTotC8S7e4Iq2MyI845DBip4nzdNu3uD7v6CikEOaheilrf0pmEStOMXU7DrUFIKN0VrkChw@nongnu.org
X-Gm-Message-State: AOJu0YwtrY/odcP1dADtxqbISmI4vHibMAJhc4NYFrHVTFS7SbOdiPmF
 hXYtUfMXceHz5L37O+NUxLOfZls4uhkSuMQEx3UKviVTvL0t9mc3SpVRj5y0aCidKjU=
X-Gm-Gg: AZuq6aJKoi36VCW0zYppgUuf+Ol/ttF6j8liXvFrwOtRte8mriDLWlRe0emT45zj2tm
 c5YkEWzEYzn4zDbvyf/lVeWAsMs58Rn4/1S0EsWXk934kixRzSsISNod7+JUoxeFavUKpgq0Z7N
 0TITSQ6qZZYh9XabTuul6UOf5Rym+SHHcGc4n6xYhPd9KCxLEC3ZyXrbxQRA30OX69TLGDNj6wZ
 CQEI3QTm8yCcDW2W6lhytAhJRomfhyFvV5oMqkZSbm8hJdejuK4p6oddysnLUZorWPAFSzm+qRj
 6UVXo0MJfsOEgJirBnou1BfDCYfN68L3hdKTX91C2p/1J5FAH4z+/4kQbCRwe3pgcz9p8WyA78Z
 qd7A0M5xYUv9uxV5iq9icYoDTYen5Sj6qLTRdWRGBSpdXeFYMdD+gJ68y/AzdGvoicvBjh1biuL
 uqko5UxyimRYY=
X-Received: by 2002:a05:600c:1992:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-48069c745cbmr12416655e9.34.1769506113500; 
 Tue, 27 Jan 2026 01:28:33 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbaa3ecsm122074585e9.10.2026.01.27.01.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:28:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24B0F5F811;
 Tue, 27 Jan 2026 09:28:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Stefan Hajnoczi
 <stefanha@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab docker registries
In-Reply-To: <90520ad2-8256-4bc7-94e3-010455659394@linaro.org> (Richard
 Henderson's message of "Tue, 27 Jan 2026 13:15:48 +1100")
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
 <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 27 Jan 2026 09:28:32 +0000
Message-ID: <878qdjcslb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/27/26 10:50, Alex Benn=C3=A9e wrote:
>> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
>> wasm64) because we base the tests of the existence of dockerfiles and it
>> now generates multiple targets.
>> Do we actually use the wasm32 stuff anymore? Maybe we can just
>> rename it?
>
> All of the wasm32 stuff is supposed to be gone.

I think 20260127092745.2978371-1-alex.bennee@linaro.org should fix it,
but I need to re-read how to trigger the weekly build on my test branch
to test it.

>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

