Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4918CD1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUiT-0003qb-Rw; Mon, 26 Jan 2026 17:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkUiS-0003q0-Ir
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:05:48 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkUiP-000122-80
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:05:48 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6581af9c94aso9694287a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:05:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465142; cv=none;
 d=google.com; s=arc-20240605;
 b=duCAwFXORskG5CfRvHy751nxDDxDyPnzK6Y4CB9Z3Q1rNnh1ep6Mj+Njo22DCbq2Ac
 PbWbaAmwVqYk/RD7b3poKk18JfVx4yrdzsP0gAi9Rh/2JS0W//qaThQUWSzoYKlLL1Xo
 ZHIcTN4Y6L2Tn9Uyd+/c7PuwCWnFSvDwZ7LnIeTrrNnkkFA2RtET9mHF/nSPDqsqvHDE
 tF+IZ+JYuiVmJdNCRNKA8X0Pu+iO4aMNwTgbMN6ZLmtcj+q8jmItN34Io7WMDatCbrsN
 wy9R1fAELsE7pv6jtpq7l5mSavwKlxlLDez9UjOZuibgI4zNjC1QnVoHFRBxeYBvS90K
 XnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Y+FrkBvmNn/ELUA/VoawsieQIbX7yrLPzbGGVSZQPY=;
 fh=0gU/3UlcT5OeOWSrdaWTPTnjXKp1LuoCGrwZfgkaphU=;
 b=amln6TkWujQmb3gpljvC/K0cG36yH3VennA4eFw99wgkfHDipE8v8SfO2PJZsMar46
 CKyMu4FRwjoEDbT0u0Cqq8JWGpxC02Dk0nz6r02m5AGBQFHf65gztHhafKFFlyKfgP37
 VEB1wZ3wL8RuYbn0/tp6zbduU63OacsZjv1LqNbw9EM5UZVPvSHzfcVnQV/gF2yEpnLo
 KRxxUkLzNADSZUwZGGHzG92ZVFvswFinp4fHmf6dDuJJGKzaf5xPruPiDSi4ochvukXh
 kcsijhalVweE8lXWtM6ZvXIkw1NybUDYTW2IwakJZv/4FpMbhm7hGXcWUp2D5Ajhs5+5
 eGCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769465142; x=1770069942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Y+FrkBvmNn/ELUA/VoawsieQIbX7yrLPzbGGVSZQPY=;
 b=l3Lr0hIRBYVQbkOLHgZqG5A2Yn1kRvK0982hlG6+6wMeNM4fZ+jyTbpTlzvcGVu+wl
 olTv4Dxpq6J5qDsMEO5OdQR/VDHwby9Lo4Rw8yJRXmJTRmwoz/AG5GXhNI9PqBNhlVZD
 i7HBAmbBAJ+GWjEvlTC5tFZALciK7rsme1z1bixf4v5S/x0XPcdJWNHK7R9RMyAbJbQ+
 oX4mM+aP0fwlgEVKeLfXydATQ9JlcTxV+D3NDhYD8OBqiuVBzIS9yZ7AuCashLNuQyQc
 Z3L2E7G6nbIWwesUAcs3kickbTa4CXAX0sxAcR9ribn8jfrtJxD3/u6RCYpe8eLTA2Va
 W5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769465142; x=1770069942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Y+FrkBvmNn/ELUA/VoawsieQIbX7yrLPzbGGVSZQPY=;
 b=KQkJ3HBkATe1yFGtAJLgvxsG0hMh9BRgza5VwCkkhZH3bhSh9gDWwEs+qxr+RTb9+Y
 DYt9CtCSLuh0UQYZ9/cs6ChELTWT6WRnsbxb6+vXZqrKPcCQpdbDfmX02fgT8ie5lXMG
 u4EYdwOHYo8eoCCr5T08VJWIRJBpZ0lp8t+Kdq5hKog7jPNTI31nGPLUJrk62VgTkVEq
 6iVm6Pwu4zDOGMnwpqo3A3OKpp9+lQbJn3VPVq7+DevC8SGsHeBKC6izgIW1Yhv5U41j
 WU/93bfM7G70SXQ3fpM2j2lA/b7EMRkhdb/gOi9FkaGYh+ZW3kfIR8qb/KUsLCADCgO2
 ms/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDBKCdrP85xnqEqsxj0BymqfuyHs7/9NCIgpFTfm5hnHSFBREd8il/0+/5ScSBP726aUN+NAbXYsB2@nongnu.org
X-Gm-Message-State: AOJu0YxiitlQoJCHx7oWSxKgB1xgHpNQVZqH4Cl2jXFNQx8qvX62J3A0
 ImYZvL/xExAk9MWqFLt++EmJSzZHpCsy0xNRAvBgLgaj64bzXoLeMoshC3WB/mlCMA4FYp17oaB
 gEu8r1j3bpGQq1cxIeWHgb2ZLwK7B4Bm0ywIo
X-Gm-Gg: AZuq6aJrb8Fwicqs70oSGKBjwoQUOMQTp0GWpnvBfvHFFr26kBa42BqSwpD1HSX6fKK
 +O6D2C2yYhM09zWtBOd7hIeE2tKtx5F+PMnRSM3y9S+kqTBbv5Nl3Ecu7wnmWeyQ1bwjSwoCd8U
 ZdfmDzhWtWOy8R9ZxoJVwx14OVLaMlVUY6PquHdUHH2qxdgj0ODqJzDsg1oFPCZGoKVC98EYvHu
 f9JDVibqnV/dmLpQPpKhGWXo4bfXUrl5ZlS1rxZAn3UKNmZhAoQOyPCa+QrULcrmPcKlA==
X-Received: by 2002:a05:6402:5052:b0:653:ae75:8d71 with SMTP id
 4fb4d7f45d1cf-6587068c741mr3748514a12.8.1769465142502; Mon, 26 Jan 2026
 14:05:42 -0800 (PST)
MIME-Version: 1.0
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
In-Reply-To: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 Jan 2026 17:05:30 -0500
X-Gm-Features: AZwV_QiQNtC-LwoZzInDz22WrqXa5zB-xojyEop_mQpe40zW1oPChWy0JIOEdDc
Message-ID: <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
Subject: Re: gitlab docker registries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jan 26, 2026 at 4:55=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hiya,
>
> I noticed this today, wondering why the daily scheduled builds are failin=
g:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/12868286187
>
> time=3D"2026-01-26T17:34:06Z" level=3Dfatal msg=3D"Error parsing image na=
me
> \"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\":=
 reading manifest
> latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: ma=
nifest unknown"
> make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-cro=
ss] Error 2
>
> I'm not really sure what the error message means. Do we need to push a bu=
ilt version of
> emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn't =
make much sense,
> since the job is all about a weekly rebuild of the containers.

I don't see that container image in the registry:
https://gitlab.com/qemu-project/qemu/container_registry?orderBy=3DUPDATED&s=
ort=3Ddesc&search[]=3Dwasm

Only the emsdk-wasm32-cross and emsdk-wasm64-cross images are there.

Stefan

