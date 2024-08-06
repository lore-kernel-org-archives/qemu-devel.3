Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C29C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKO1-00016l-Dj; Tue, 06 Aug 2024 09:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKNy-0000vO-A8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:37:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKNw-0006tk-62
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:37:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428243f928cso4621255e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722951474; x=1723556274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YE8yTeyPqFC5byBHVK4aIwCUqnqjwdXQAVSnebz3dhk=;
 b=SFTPO53e/sfXKse4ry0u8PROW5i1/xh03TN6iEXUWOP/nTybGV68yg+R5nNZecHn7E
 7js4tOFwj5Cyh93hdxiItXfktRDbUKRwMe+V7KpPZ8RAUhvd7gJJuF+kMJ6YalBNio4H
 haVjWBasDwnJKPKf1Co4vUgc1TwvfiRf07bsOZ/rsomjRQFNnk6NT+sY0VJ76n8JQTJk
 QlqQbkcBODzUO2zVxzU0hf6KUHwqYWF+bv9bKQoRQWtZeHnHTggtWC/0oiZgwRDbqbLs
 UPjg1/+lZASPLtR32effmxSUb4fOTLAoOkmdiTjGMVBwxXQk/6bbVXOy+SZrvIZh3azP
 IvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722951474; x=1723556274;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YE8yTeyPqFC5byBHVK4aIwCUqnqjwdXQAVSnebz3dhk=;
 b=LnjvzCGXFXdYdG9s87b7B+2NKnijIDzPyAiZGio2ykkfWJvAUFTwrDTz6e36a0E2Uz
 0Oj9GxYwvtGQPH5gkyUf11mm9hDiSrffcbIYrw5hPTHuMcdAafyb6tKGSqWUBP8fgl1e
 tu3Tr81zmjcg2gpiwHp/+McUauANVu7XnfhyfvC4W6y1NUGTRdw5EiKzRXVLz/PkD5jG
 q3tLsMol9dKxVjh6otk2yVD3U7BJ0acOOpqw7qt/9UgjdbqL44WHZ1cOnhc6rxN2xuVS
 WkarUi9T+9588EhSPtZg1ZBj/+88pEK6SeO8meBLLLYKfX6X2/sC63GBOeO401BtgLox
 C9RQ==
X-Gm-Message-State: AOJu0YyoZlT+JCfgD37eGUVVnxUU8kLtsMALfByykeOIQeB7GZK031eh
 akJmar6ajdMaaheZ6GdlerDihXzodiT7KOWfaB5EEsk0fKS6OGz9MnC65ACbmos=
X-Google-Smtp-Source: AGHT+IEYYFAvJcV/3y3QlpV1cv5pZ+ucTs0ELOxE5qT5nLlwGzFRfonx5qEN7JHeOPZvIvR5v1iINg==
X-Received: by 2002:a5d:4e91:0:b0:367:958e:9821 with SMTP id
 ffacd0b85a97d-36bbc12d79emr10173718f8f.29.1722951473601; 
 Tue, 06 Aug 2024 06:37:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd074583sm13041389f8f.108.2024.08.06.06.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:37:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EFA65F77B;
 Tue,  6 Aug 2024 14:37:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/3] hw/display/virtio-gpu: Improve "opengl is not
 available" error message
In-Reply-To: <20240731154136.3494621-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Jul 2024 16:41:34 +0100")
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-2-peter.maydell@linaro.org>
Date: Tue, 06 Aug 2024 14:37:51 +0100
Message-ID: <875xsdsrf4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> If the user tries to use the virtio-gpu-gl device but the display
> backend doesn't have OpenGL support enabled, we currently print a
> rather uninformative error message:
>
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl
> qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available
>
> Since OpenGL is not enabled on display frontends by default, users
> are quite likely to run into this. Improve the error message to
> be more specific and to suggest to the user a path forward.
>
> Note that the case of "user tried to enable OpenGL but the display
> backend doesn't handle it" is caught elsewhere first, so we can
> assume that isn't the problem:
>
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=3D=
on
> qemu-system-aarch64: OpenGL is not supported by the display
>
> (Use of error_append_hint() requires us to add an ERRP_GUARD() to
> the function, as noted in include/qapi/error.h.)
>
> With this commit we now produce the hopefully more helpful error:
> $ ./build/x86/qemu-system-aarch64 -M virt -device virtio-gpu-gl
> qemu-system-aarch64: -device virtio-gpu-gl: The display backend does not =
have OpenGL support enabled
> It can be enabled with '-display BACKEND,gl=3Don' where BACKEND is the na=
me of the display backend to use.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2443
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

