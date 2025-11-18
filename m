Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB77CEDDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN7t-0007Da-Va; Tue, 18 Nov 2025 09:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7R-0007B3-Pw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:55:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7Q-0002h9-3s
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:55:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so3931258f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763477742; x=1764082542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2YSSyFFgS95NJWgbULMYK6H1nDDxjbMozcjqkKeIoA=;
 b=DiuuFU9WvqvU8ou6kwtxVtU6BvN+97q+gtJ7V+M0qOTES9WXlD2FNAcXfAJEoDtKKX
 g+eJMeodRmWr4wwD3tXjryz4/sZEGEByQS2aWXZCkd0At9y1f0GrDBJPtDT14191pGUo
 3on+qgsqy+3kEteIl+tfg+LETnUIlUTzK2e4KWPRKACPqFX81ahE+90m0Vl/AjI9J3C7
 v2FgDLXlo0JHkROIt6Djgrb1x4S6DUdBTUxMGA8sHcNh59ydWnMKdfqH7Ilhvu7S5Swf
 Iv/JnE8u4MKi8AN5xfcYk/J+LM6tzuKGMz3gharLpX9WMraGbOmWgregJ2aygiodIut/
 8Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477742; x=1764082542;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2YSSyFFgS95NJWgbULMYK6H1nDDxjbMozcjqkKeIoA=;
 b=elFnyBYgfA4vfn/rwPUxPjJ35oR5kSbWVFTdLTLUfdvvXPwaLJ2ry2SAhley7/bfET
 Rj/4eDs7k3blob/OJOwnOftPjCG5tH3PJwBGXF1OdkoZiecjWLblS9ssIBfcmUosgLv1
 41EnXuZRW0TGsvL3fEgSHEh//lWwqBUG6uNGt5hY+vxqMm4QqD8Gy6ZiwuONky/UezYV
 1BbogkBuN1DRwTX81Gt6Ljrn1UPXqM+YU0W++I+814OEa24MHL9jzFRYnvHpUPjKhpd+
 YIlu2lnCKlVTaLU+slcJ92RagA1ABZ2N10aiAGpFgNAWtmUOE4kMt8pfF43B5x0R3yzw
 pcZA==
X-Gm-Message-State: AOJu0YyHwovUnZpuVN6dMQ1P0u0y+WXa6LcIESFDkDsOIjM3DLHlj8Dg
 FauYEQ6R5vlHvGBvYzDZsSITI7YzskmemC3zIHAfijcdfoneif0YgJR56yrkWn3mwl0D2oxZA6h
 Zk6vX
X-Gm-Gg: ASbGnctUUKPkiJiEi7+poB0DReHmE2JzEXJ6vGXEQAGNrnaJvk0b0EBWOz2IWMTR6Yu
 SB9l6hjluZwwEpgpL+7Uf6a8sU9TMHYPZWX2wdhR6IXFUr4d+BPLbyIhT9WbUwlW+3MOaL8t/BT
 2cHXmTPd69ssBWv+TEvWIpYlmT/stbaGV4jfMQhH8tRGrLz9dUfEFLbb8QjLkZ3JLYIJCmMI8GM
 zftbgfCEQJSyXTRc62VvZua3kH0FUirWUFPiTXPDKpdy2JWYfC/BAESkdVXf3wrA9klrf/uF/2R
 cSlfNllFpWnCI4SJ73KCoED1P4D5ztu5tpXemb4uSEbDt2QC92xPBugKeH1B3xYycH9Ules0NGA
 1epkYoKj4yS8Z3F+eGSgdiFtS45grAeW4xWQkeUIZLrLIp+COnxGOH6ygEOmpRCOK4vOUWJ8V9E
 e/dN/1+Q8t+68=
X-Google-Smtp-Source: AGHT+IHZuuxNwGo3lPN40LPYEHs8qD+iMLbQaGaAzXPNthsJemwXm1jWhjqTdt4obFY1wrvp2iDX9Q==
X-Received: by 2002:a05:6000:2582:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-42ca85a5046mr3698677f8f.0.1763477741918; 
 Tue, 18 Nov 2025 06:55:41 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b8d6sm33674581f8f.28.2025.11.18.06.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:55:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80D255F8B9;
 Tue, 18 Nov 2025 14:55:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH v2 1/3] mtest2make: cleanup mtest-suites variables
In-Reply-To: <20251118102942.551194-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 18 Nov 2025 11:29:40 +0100")
References: <20251118102942.551194-1-pbonzini@redhat.com>
 <20251118102942.551194-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 18 Nov 2025 14:55:40 +0000
Message-ID: <87o6ozjspf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Remove the "--suite" argument from the .*.mtest-suites variables, and
> add it only when actually computing the arguments to "meson test".
> This makes it possible to set ninja-cmd-goals from the set of suites,
> instead of doing it via many different .ninja-goals.* variables.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

