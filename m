Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655FC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHSd-0001H6-1P; Wed, 14 Feb 2024 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raHSL-0001Dv-If
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:45:58 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raHSG-00074q-5Y
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:45:49 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5638ae09ec1so851139a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707925546; x=1708530346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErGjmX5admdrZyz2qloe8sRuyWKounBP1oNNxbmjPf0=;
 b=WHNm/fAqlgecl2OmuwgTV27u3fQYhGsJVZ9cdwC6oXssXOtQKWiuSSL5rfbwSiiJ6x
 wSJxbgijrKH0lxuLwiggN5OzQNaxx23uuHP6u2qsc2N/TBkJRcRpirIbfLnoDg3+4u7e
 7Lx5DMeuyUGvor5vCbmWDk2HQHRrEKm3H7hPy7QpuSwEfouEBFdqqyiJegE4YwPFvLDl
 8lRMcXc5ZsTJPRf5k1r7GJIGrpAAHJlgH6L5OGB9h4ln7AsuD3J7i5ouLZnxbSDq24qa
 bGy3YvvH7vz8bAvuounatyQdLCrvVZ2rp+OdrmiJWoloRenqZ82ppsstMoImvIBSGrrA
 hb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707925546; x=1708530346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErGjmX5admdrZyz2qloe8sRuyWKounBP1oNNxbmjPf0=;
 b=oA/XDPwEA9IkOcmW+i+EkbpouWKOX9ds75RmlSCiLS7YAiASnhGJyrPRGQN22wUdco
 dr+E2+Yc7cH5nlKdj8Zc5AszpQp54KaZxDbaBptiYcEwN4bp91IT+l4H48u9dCu9Mglk
 u6Nis8NS6z8kzkBKHh5jiz8eBvqu0ysuQ2++CMhCYsmJFZag67+lOsiE4+7ejwf5i01a
 kHboPLWmtV1e8ihnbJ0DPm6xJftGJR/aU9uo7jKkWmFjoQFOdQLBTHxAbQ420ymP6d69
 G3FTFKlhPSX7pBAs41XMfenVOx5SQJL0ubKBmHoDdiC7EMaGZIImEsvWHK0BChhuqON+
 qr8g==
X-Gm-Message-State: AOJu0YyzvZhnIjYjWNTevyM6fj0TnteqQJAH1Fnmijg0Ysri56T2M6qv
 x7svDNgqyM5OdIPl8fxo4qIs0VXj/Ur2OG5+FRmxVM9MpKQpcHVZBmpMlKoj95uVomTVGJa2FMK
 vzs8v9qR0plnwS5c2PeawAP+KOkWJvtLK4+tcuA==
X-Google-Smtp-Source: AGHT+IGSwC4FkagzpiDQCuEfu5b/1rjVn/BFZgey5CU6H5W5XNOlBjYTOsoLRKkigov7GEi4M4+p0LqVhZuVQ2LN728=
X-Received: by 2002:a05:6402:5286:b0:563:8718:afa7 with SMTP id
 en6-20020a056402528600b005638718afa7mr1680848edb.12.1707925546529; Wed, 14
 Feb 2024 07:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20240214064749.1060107-1-armbru@redhat.com>
In-Reply-To: <20240214064749.1060107-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Feb 2024 15:45:35 +0000
Message-ID: <CAFEAcA85SVYMZ2T=QN1rdJwsD8s4nRJhg6xZb9dJS-bLpLZWXQ@mail.gmail.com>
Subject: Re: [PULL v2 0/4] Character device backend patches for 2024-02-12
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 14 Feb 2024 at 06:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> I offered Marc-Andr=C3=A9 to do this pull request, and he accepted.
>
> The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa029=
6c:
>
>   Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx=
/qemu into staging (2024-02-09 11:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-char-2024-02-12-v2
>
> for you to fetch changes up to b04c12282b33e81ba29b54dd001667f5c4002252:
>
>   qapi/char: Deprecate backend type "memory" (2024-02-14 07:45:08 +0100)
>
> ----------------------------------------------------------------
> Character device backend patches for 2024-02-12
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

