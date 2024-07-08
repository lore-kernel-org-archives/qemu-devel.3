Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532BEC3DA44
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 10:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQm2N-0003HZ-GG; Mon, 08 Jul 2024 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm2L-0003Gz-EY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:56:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm2J-0006z5-Lu
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:56:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso4847763a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720436158; x=1721040958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0My78Xeto9vzJsCnhbF0WJcsczF7+z3mvTX4EowZ+4Q=;
 b=KXRBP5xRYzXiPmAPkiI3CqszOPnp9e+rvBSei4x2cfSdSF/FxbWiUUnALpFl2aCqa3
 QEIvmpuEZSQ8xYEdjU/nyMKpi8JimK0kFekv5rza92brBamAkuZFiWVSvlSz6upvZnXK
 OseAPuFXnStTszULGyF3UqFVU2KM3uUeocLoUdX9nniLPN5OadbluKVydPcr/UjAMj8j
 aNaCsmbnA2nDIUCcb1gXr0zDXPgMrhOO5XBTMt39TDd5ADVTGXTC8kPMmqMVPloI31Os
 etlaDq4rJpXn+a7My5F6ktVegoDBEh0/uzR/tVyMODIWTOkOqizoB3qoEjrfHIR+sWGH
 Ktrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720436158; x=1721040958;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0My78Xeto9vzJsCnhbF0WJcsczF7+z3mvTX4EowZ+4Q=;
 b=tZvtMkh4QuYPat68o8Q7wNm7rORmkfAR13IcVUX4omHCe9ose69gu7pczsFDQXR+fA
 PJxzCe8EUUz3QWN2iF8U20ERyrcbSR9R8dbkTR3nED4+IKMmCrkplSsSvqUexrHGwVxg
 ZntiwGP/NzdD+RI+xVpMI/towMt4nHacpcDTo1HxkRWT0kfh44iXPx31PZDgG7t/iAqV
 sRQ8WpK9514TmyXcb2amvnoQwD/x9vxIBL+j7renxLYnKdIwqAEgxzVFTeOOgJywkeR7
 tM7b44H6i0v+oCCgvXS9qLW0tCItbXhUb6t1hRUvabAYDZ715dzlhsQoocaJSNMy0Bjp
 4F1Q==
X-Gm-Message-State: AOJu0YwJrHjyMgCkwCRY+Vkk3HUgkYFdum5ToCt4rM15gMQFDOZMAFiP
 j8JQKFVdzlZYZRhCO9IrpmQYnNyy70I6DEKFD6+jZX3Ud6NGsutfYcqS2/8XgUw=
X-Google-Smtp-Source: AGHT+IG+Box9gOLKB4FPMJMWHQGgW9ocBZXU2snmbVbhNquoz+6cmces37I6RS3U9MCWLHpMrPcXYQ==
X-Received: by 2002:a05:6402:2106:b0:58c:ccc1:17ec with SMTP id
 4fb4d7f45d1cf-58e5984c940mr8543492a12.13.1720436157851; 
 Mon, 08 Jul 2024 03:55:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58614f3d74dsm12608034a12.90.2024.07.08.03.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 03:55:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66E1F5F7A1;
 Mon,  8 Jul 2024 11:55:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v6 2/7] plugins: save value during memory accesses
In-Reply-To: <20240706191335.878142-3-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:30 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-3-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 11:55:56 +0100
Message-ID: <87r0c4tao3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Different code paths handle memory accesses:
> - tcg generated code
> - load/store helpers
> - atomic helpers
>
> This value is saved in cpu->neg.plugin_mem_value_{high,low}. Values are
> written only for accessed word size (upper bits are not set).
>
> Atomic operations are doing read/write at the same time, so we generate
> two memory callbacks instead of one, to allow plugins to access distinct
> values.
>
> For now, we can have access only up to 128 bits, thus split this in two
> 64 bits words. When QEMU will support wider operations, we'll be able to
> reconsider this.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

