Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1519C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qs8-0005hr-Bq; Tue, 30 Apr 2024 13:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1qs4-0005hG-VF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:02:26 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1qs3-0008Is-7z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:02:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5872b74c44so671692166b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714496541; x=1715101341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=osCiuEVNYG+PPaHcPlypRGOqacuwydIi76ZnIDE9sQk=;
 b=t3Xc4xAAZRvQWK8RWy9TrFnJrSXMkDNaTDhQ/OnRAjkVX65ckYGHcJ1QZqfg646OgH
 N2E9WS5Jc9ziit4UAqpt8j54eBV6KvfIRYBtlzmx84WaKMwogPJZPlFg9ZXaEAU0o0DS
 a+tXgJ8/W1Hk8eIBXHr40cQ4XG7D1Hq61M7CTo3liXXeOKD8Az+4tiTuJbL/+pSysFXY
 tZzZgGNswJgNVdaMa5JPh/H3Rywvo3f2wqmdJPWPVhIePd5iMTSz9iBFox0VUWDvpfcI
 B4SXR22Wae1eaqR74zLsk6D+4uCcCJPjU5UeR/feR+s6AhqwaoGNHvzLFl0KtWyQd5a9
 wkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714496541; x=1715101341;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osCiuEVNYG+PPaHcPlypRGOqacuwydIi76ZnIDE9sQk=;
 b=jb73hWg4shulF5uLODR4d7+gmGLV7dHuVycxZdriElhO2OlLbH+AtHP5K/XzEg5TWX
 zKmA9KwWS/ruZiVPoFo/NYIYJac4/X1Ju+hGKDZZE4iQKlNjbX+mZYaMBA9Iw4ORKz2r
 vuCwCpwSJTxm8hZ4D+PA8bI9dlbVnq+av8vPT6enYW6ThK+VRFbu4ia1oraDOzML/WLQ
 tBocEi5qmQL57M25/MZ9W5agr2HzM8YDkJKEnznacSJ1hZmECA+zR9gY3D1yxH6UrbEF
 Py0hgpyS3Nak+sAXEEIBM3gu9HNkURIQlmIdRqT/C7hWn1IBs1TklKApS6gX+ZlI9Btw
 ZaxA==
X-Gm-Message-State: AOJu0YzKc0SKq0sIcQRo+5Rt73e6/yV7q5YqUy1O5D3VJpkU62xWBqm2
 9XE+Cs2ZUEMs3RW8bHRh4CtUpbopmPKZo8+11XW9hOjqWPT/5wTrlH/gYG0FrdQ=
X-Google-Smtp-Source: AGHT+IFrBfBWTFKRNWOVO2CvuVavEqBbTYGJ/y31lKpHYez8i0PUVt0BA4a+Xb+YVdUR51C9RMHGxQ==
X-Received: by 2002:a17:906:2542:b0:a52:1770:965 with SMTP id
 j2-20020a170906254200b00a5217700965mr171541ejb.42.1714496540975; 
 Tue, 30 Apr 2024 10:02:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a14-20020a1709065f8e00b00a559bbe8a00sm12536400eju.100.2024.04.30.10.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 10:02:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 174E05F7A7;
 Tue, 30 Apr 2024 18:02:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 michael@amarulasolutions.com,  linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
In-Reply-To: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 (Dario Binacchi's message of "Tue, 30 Apr 2024 18:47:52 +0200")
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
Date: Tue, 30 Apr 2024 18:02:20 +0100
Message-ID: <8734r24wdf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Dario Binacchi <dario.binacchi@amarulasolutions.com> writes:

> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
> always provided by the libc (uClibc). The patch disables its compilation
> in case the header is not available.
>
> The patch is based on a suggestion from Paolo Bonzini, which you can
> find at the following link.
>
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2021-03/msg00492.h=
tml
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

