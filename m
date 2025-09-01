Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C06CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut84x-0001Pq-H2; Mon, 01 Sep 2025 13:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut81j-0004nE-Si
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:09:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut81i-0007iP-43
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:09:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61cf429f4c2so7691193a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746544; x=1757351344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfERClM86amj5ag83y3ekxEJqLT8FUk/93QmCFIEpog=;
 b=FzqZaL7rhVUufT3PM4USfGRRhdW0tmQygiwrdOMYC+YspyEI/t3xGZLzGh1uFe9JFI
 qDGDj5ZwWbzQ7ZYKZV3Vkg1IF5Lvh850SLl3ByXQJmBK12WplGLCbXisPqlvcGQkUztS
 yFxLdxT0xDxx1DMAGEm9wuiLGK+4SdPqxBdY8IN0ihaLikzQxbOz9wBCco/3Qo5uOTl5
 ZCw4vgfYaaBRsZSBMv+RigxTcQznaev6odLcFD1N7RmQKmSf/5g8iAxz+FouiUr8bXz5
 mGXDJZSHZLLHLnsYXSpIVs6pWvzhVUvwsVNDl/63QDBvn3vIgCEr3UTmt4i9HWsXePH7
 xWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746544; x=1757351344;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tfERClM86amj5ag83y3ekxEJqLT8FUk/93QmCFIEpog=;
 b=kY1tv5Zb2cc3iP2kF+MeVahCuN67EWxbpqJfYqoyYGM/Jt11Hs0HEfPKdHEx7lyjjh
 7Hqe7gzypARVjPelOEBKB5D5sujRfCHc1sGEsovvwCRW2Zkh8JZKv084rF3L5BI5GFS3
 wEcTdAZmwQmU1Q5TGEFdjfc1SKqfD6Ar9WmVQHiJbznMym0FuEUyr/gYUb9SLlpYjSfD
 rIM/DYqPha+ieFmPuWxhJz5ikh+VDz/hpCoSNIBsmkQrYpo9GAWYXXU8hv5MZ+27cHZT
 E23x2fuvFql1O30d2kyiq+Va1YgNQziZApaWp+vMDh2UaUaSTLgCuoMH1cxEIbq0Kf9W
 9pLA==
X-Gm-Message-State: AOJu0Yz4AA8uOSONm6Ci2un7YL4QtXH1oN04hUMLsBE/sifZgradAJCY
 y6rSFajArRb0ldi472Zc+cTplMUBCMuyekNal7KqEG1vBiS0k2nHEyms4bccM/Xxbtg=
X-Gm-Gg: ASbGncvDXGLyx9UjXwO+5EQV1bwmU3sEvbxegbHbuwuiP/UZDR2N4E6RJUFaMVicvJB
 oLNJ/ewuD4kjhJkZ5TQ9sdHCsLY9A+VxPo0lofRuY8Z92aGiNwR2vczETN+RthTzJaAWIIfOajo
 0dKS+dT92Uku6EgiFtJjNCYPFdse/yiBzUvva7R2sAvsV32q6Cn0CL+WH/sOEoCurUHJyvuf7Mr
 dtxsWuXNdClc51eLvpXYRcfA/xMYBs4a+Tmpxw4GO9qLkGZX+dYDizxscrfUDh5GqmBagyKVPVS
 HJxrA19lV5qBez7Bq3Ijpr0DdhAQW3m9EkfggfBoGqu4r+MSs1LA+FdSSraxi29+PQLaWEQ9Fwu
 ooUmXJZEHEiC6xMv2izKzg7IIhXW3XgNNOvA4/Cd/jZ1B
X-Google-Smtp-Source: AGHT+IF09cachTbbgjtWwom8g+GntcewSd/+X4zbcU5/WoxymHXjzelJIS6Iz5/rUCSfSZft/CLF3w==
X-Received: by 2002:a05:6402:210b:b0:61e:a5c2:6358 with SMTP id
 4fb4d7f45d1cf-61ea5c26477mr2476228a12.34.1756746544167; 
 Mon, 01 Sep 2025 10:09:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbca5sm7544293a12.31.2025.09.01.10.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:09:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF9685F81C;
 Mon, 01 Sep 2025 18:09:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
In-Reply-To: <20250710144543.1187715-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 10 Jul 2025 15:45:43 +0100")
References: <20250710144543.1187715-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 18:09:02 +0100
Message-ID: <87seh614nl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In insn_check_regs() we don't explicitly check whether
> qemu_plugin_read_register() failed, which confuses Coverity into
> thinking that sz can be -1 in the memcmp().  In fact the assertion
> that sz =3D=3D reg->last->len means this can't happen, but it's clearer
> to both humans and Coverity if we explicitly assert that sz > 0, as
> we already do in init_vcpu_register().
>
> Coverity: CID 1611901, 1611902
> Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register c=
hanges")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

