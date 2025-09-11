Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEBDCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiZH-0000N0-G5; Thu, 11 Sep 2025 10:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwiZ6-0000LQ-O4
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:46:26 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwiZ5-0003xb-2u
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:46:24 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-72ce9790aceso5883897b3.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757601981; x=1758206781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcTsT/2FVI7V/KcYWRv9dX9PSVwqf/a/qxlTK88yXXY=;
 b=ye5M4tvp6GUKOCbvLrO1mX+YRwqHOX0eKO1mMDF/SN4q8510LOy582hZ75qMe5rQfg
 luh2sh+mok9j0Mpe+Y0q/+3/1/4iQRI8sQUSPwqYQ3WoWNJGbACHcA3+qarBdR7jOFqH
 2v86h+xyFFbEpfh3eXr6v94Pq2igupmeWDKx+jvoXHcdbEaU4Ccd41ACQSv2JN/DGJWy
 IoFHhdbpR2QhJyicpLgg/c2sBDd5egK/WiqGzAbXIlRxITy9tzDZadRIQGD8+EsQhLtS
 1bMVkiEZ/btrrwWD9YIaPSqUTtC4mjaxWEEweGHs5cZsrw67RUdggBsCiWlIqTPv9i29
 zzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757601981; x=1758206781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcTsT/2FVI7V/KcYWRv9dX9PSVwqf/a/qxlTK88yXXY=;
 b=QLXuPcmrAaRGn3OwqAHYHeTrJRyFw7DBWRZUW7Bf8gUvcfUQcsgvHZLEbNdJ8XQyOw
 iUDr9fm6nFdPwxw//RC2gyTT//X6SS/lqO6pusMV7qWsJFAu4eqpzacWHJPJaPoaBtjZ
 M/UlDlypHA3TAm4HaUX4BKJBcADjCH9JeHEOJXe1sJXa/ZqxWcTLEBslYVt5lW5UhJs6
 5v45okh+jNIy56/5cYcWIC9U9EqAHgFG7mhiDynef8I9BXO5Gy/lXkMnkURe1fMEF7CQ
 XrfEtV+b1dqpOPZb7exdP3AhlMkMqOjnjHmV8KpObTlyT5xEvqTHNBNTtJB+0uVZtr3e
 8cBA==
X-Gm-Message-State: AOJu0Yw8sXWajFWEsPgn2qRYCJEEWlavxMF08tmyKbIf7HJaoBK/5Y3x
 hnI+LcqdorS5syiRKPHM/cVIbCKu/YxyTDS9GcC6pcHCQNjSgLI8eq4L44iY3M8BrV9YZ3LGO68
 pACcNhlFrnUVDjk/q4BeB3QWyq9g0Jit9SVTKRzCGjQ==
X-Gm-Gg: ASbGncsdkJXXe3xrAoguZZwtYZKSKtKserIxucFQBBmqZ2gGfyD8SnFSPQqqsBBQXMe
 pdDZOSFIAj8opXKwxmRwQRwYY4XxkjWEVASbnuWbyNcaz6CCbZRG3xyTwPRlLZFGvBvHx2b9VSh
 L7JNosHu0QJa8iji5rxOJb+uEEpgfU3s2fIdL+fA61iD94HWFxzAso1CKBWzy7msb2iRqHMxEez
 Q+2BddayRYuhaTSTDMg5f7WjeRROA==
X-Google-Smtp-Source: AGHT+IFyDu42MC95CranUfROhX4o6o38lUqWwTiV5HMA7Ensn9+sjwdyk24ICRGEN/HcoP4ptGH92y6EvT+TKTCCxg8=
X-Received: by 2002:a05:690c:a010:b0:729:f78b:420c with SMTP id
 00721157ae682-729f78b9be5mr122562777b3.24.1757601981232; Thu, 11 Sep 2025
 07:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-24-philmd@linaro.org>
In-Reply-To: <20250903100702.16726-24-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 15:46:09 +0100
X-Gm-Features: Ac12FXwzErRf24MAYGbl-qZ8jiJRTUumVQFc9x037jHRbDc1gkrkzef5d4PTXms
Message-ID: <CAFEAcA8Bf90DJ44gdDWaBzc+FdbSY1Nn7Z0VJeWVpt3HMG__8A@mail.gmail.com>
Subject: Re: [PATCH 23/24] target/arm: Rename init_cpreg_list() ->
 arm_init_cpreg_list()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 3 Sept 2025 at 11:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Prefix init_cpreg_list() with 'arm_'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

