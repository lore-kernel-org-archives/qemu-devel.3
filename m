Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3247C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtud-0007wa-Gm; Fri, 17 Jan 2025 16:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtuc-0007wL-8I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:29:54 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtua-0001vM-EW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:29:53 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaec111762bso493437866b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737149391; x=1737754191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAQLqsNt7wOxA3wfsTjr0kXMPRA5xI5DF5rDhTYtvF8=;
 b=CyCgJfYkhzHj0MNHfC9Xdc4YZ9o3u+EftSNpUM+WTPY/iHp08uIp2Gf4rV11oAs6UB
 d1qA5kkdqWIoYz0O93Y0VzzbHeSr54qRC88uCSYt9q8bjddwdyarWBVO5CXDWqQK6ZPh
 ahKFQzG4BvkmdUTZoezhJJx0xtsWSMQlVLhRtCJBhBdjLmsRQBQCLH2tLYWXdjvRH7yB
 x4jWfvPyIAsQd2/h/9QlaQwUfpdwfyOdSOUe9xR30PBfg/yiOg2XjgW4rg3I5mi7mAw2
 nXt4W0vsU0uElgYwAszfsIF48/GYnwM6m0KK3xiBL9pLe2XgC+UO1TvkwKf3JKX91OtO
 lpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737149391; x=1737754191;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sAQLqsNt7wOxA3wfsTjr0kXMPRA5xI5DF5rDhTYtvF8=;
 b=nTwvSr3jSr9X93NbixkfjMcFIeNcSx0nmed6v5au8NqYbIL9z6mbDW/nQjbBjaxk7k
 5uQzCRJtgQ+VtgAtPOeQmAz2Nh83sN175EvmcBgwyE5k/lFQYHgVmMIwxHQ9JF+iZijc
 Lu5ocxPObe0MMTpeWm8KUOKePipT8GzOSAekBFjjZl3f/F4rr0WvHvWVgEe5FgCwv7ZY
 VIIvgal4DHb/KIk6ZLtQ0Dlw/zcEKK3F01DisTz/MOwEUi5pb5K5p1DtfeAEvdYMFTaG
 Lf5qBMUDAMXkNZmGEfql7rtBKgGn91adZnRvcYU4putLOWCSl4k199RxMOAW2WX0IS4f
 NN2w==
X-Gm-Message-State: AOJu0YxRPSEK5JLSxefOZERmR3jixJ8UcdLODoQC4+uxSJ6PagpWLbyJ
 YO6mfwjI0MPWbE6xKHbSAGeHvgP5ZQ9Aeq0Azxb/VDQE9BQyFw3DfV9MBlhkFpY=
X-Gm-Gg: ASbGnct+fpfYtUOMuA7A4tTeel8xfMUXtPAOx1PIcf+ge9DOVQZbbXWkOIkUUkQNF2D
 lir0IR7M+hJ0WlBnw8pnEQEzDOObYQVUYp0hY4VI81XJaarKVwThk+2r903ruuHDkfetwCcdm61
 nf5Oy/6Y+a4A0lRYMDJ0njLoUTB8QWmY0xPxrZ1vT4ulTS1zeDEEB4OGHWqSa9Q/Sj7eenTTIhQ
 stFhrvuEpAaBfzSNOV5+6+4w+8/+c6+WXyG5RAcbCGQyIbxRvDUCE4=
X-Google-Smtp-Source: AGHT+IGy4eW8Q4Y8pkMJBMfS5zYGR5LIVxGXqyQtabvY5UiMcqpU0JTEsjgo5kpeaKTLj3apgiJLzA==
X-Received: by 2002:a17:907:9694:b0:aab:f014:fc9a with SMTP id
 a640c23a62f3a-ab38b10f4c6mr388418166b.22.1737149390676; 
 Fri, 17 Jan 2025 13:29:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5c491sm231396966b.35.2025.01.17.13.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:29:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9F536083E;
 Fri, 17 Jan 2025 21:29:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 03/81] tcg: Move tcg_op_insert_{after, before} decls
 to tcg-internal.h
In-Reply-To: <20250107080112.1175095-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 6 Jan 2025 23:59:54 -0800")
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-4-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 21:29:48 +0000
Message-ID: <87ed11m8mr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> These are not particularly useful outside of optimization passes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

