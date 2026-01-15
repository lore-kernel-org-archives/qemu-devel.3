Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B14D44C6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPfu-0001jh-C4; Thu, 15 Jan 2026 10:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgPfp-0001iN-KP
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:54:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgPfn-0006RG-4B
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:54:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso3436825e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768492449; x=1769097249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fndLlosvQnl1BWQl0z72nD1M8vMdnIudDdlcH+pBB+U=;
 b=LmJavGAPbgY+x4gnukwgpB4e/J4Yjvzud9Ho+hFjyKbNW5gl3gJ6TzpHA56timj6vz
 oxB6B95WbRmo+9TEZ7NUdjlK2z7CkloR6MZElc9YAKdzr5/F+kuiuaruG0j5zJoZ922I
 7u99qcVwx1xjlSpI/mo19gNvBn48OAyAsRSzLKPhhCMWuSYfBfdMuUoPGbdqorm7STdB
 /B+M79678YcA3J8ZD22moD/z5Dela26fXy9p6/vw1LP7YWWIh7QGoYo32ikbHWJkd9Dl
 njZPTmBsfd/1fFpu4uksWjKUh5Lei2JCKHPJXqGrO8R3cDHUMN6zDa+LgsJ03TiDX7Oo
 WKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768492449; x=1769097249;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fndLlosvQnl1BWQl0z72nD1M8vMdnIudDdlcH+pBB+U=;
 b=lb8wwRF3cLJXRVu0SBupqclIBAsyjqpRSIStiy4fRK/r+ElKjQERrwNQo/el1YNCT+
 PgS3UHSknikI3zGkMTKmLhNd7ENFMiKg9u45NWv/ql/S1sxKt9Upo+vXMzXpZIw5UHxu
 RIZQi7QpblO3Py7nsPgLnxD4mjyP3DhsoQIUg1HBj8SmZKXCjMnamYPBj4YG0hmhD3Lr
 23BUxU1ZimTkQ+CqLhDZVNSFyBPJUR2rFWw7Bd0RO8QlJ5rq6zSKF6gEJwdAhNpifxH8
 C+oBFyrUgYTz+hAYanJ8t82AwZjHD3nE3c30mI6NzEysHDykFLnmebW+kWuxuzI8Rq7+
 fGoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrSi7iC3RMCzJMjWuQABRAV/tZe5wrjY60BHii6d0roIUXacybNPdQLwRvq7jjEM9lIH+neZc7heTL@nongnu.org
X-Gm-Message-State: AOJu0Yz6ohrJTxSwax3YUADjwsvxL6oQssCunatwWuHIqZI6dvhVltyH
 xUDSHfCzSFLCfHrbZiq05/BciK7dOWHuLwPrlh/JNhRdX2/09JyN2H8X4UwegpyzlhQ=
X-Gm-Gg: AY/fxX5jXeY6cPJhZW53vi7IaFadaddAXdJrw0v+KjVPa38XrbnYBWa9A+951pItdPP
 0o481VpyaVj4n9qKjhTfrfP5oHkYV8u3f3FIG09uo+9QS9zOfmAQSOpOyoj7l80LEdVn3KZlb2g
 1AgByQ++Gqv5wcA4fXD0rkjLNTb2f/Xc7oc/RcodvvAEn0WS4LclwRXiOqTYae3GwDyM+sTf6UI
 EnMMisgbFc4stgQ0lqYIfF3H/n2AVMukqtLivXvqQnYb3P5WaldgOHLdL6r4qvRbbsL120GYFXi
 yOn/YbAC+w4Kkxp+sdyXfLZ/SWkYau/HmN412Hmpk1mm0ckxVHncEGxqziZLzksP45ylWteu8rt
 JcDuxCu+mR13F6vCrGel9lXr95CfOEy6uX9g3s+b7XKNgm86SRV8LaQwPm4hA7KcZOUjBauLLr0
 lw5N1J4VxLVhU=
X-Received: by 2002:a05:600c:4e50:b0:47e:e952:86cf with SMTP id
 5b1f17b1804b1-4801e3502bamr2215885e9.34.1768492449323; 
 Thu, 15 Jan 2026 07:54:09 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee11ab892sm47478665e9.6.2026.01.15.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 07:54:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC9CF5F88E;
 Thu, 15 Jan 2026 15:54:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
In-Reply-To: <CAFEAcA8bF6p0RhT3X5RUNo-BjNy1mVzUwc_gKv0L45oxZiEi3A@mail.gmail.com>
 (Peter Maydell's message of "Thu, 15 Jan 2026 15:35:19 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
 <87zf6ww9fg.fsf@draig.linaro.org>
 <CAFEAcA-YDPYQ7mny_zFjgjWc4W8K18kUVuBgFbQ25sNpsM4Vvw@mail.gmail.com>
 <87a4yej41k.fsf@draig.linaro.org>
 <CAFEAcA8bF6p0RhT3X5RUNo-BjNy1mVzUwc_gKv0L45oxZiEi3A@mail.gmail.com>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 15:54:07 +0000
Message-ID: <874iomj2hs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 15 Jan 2026 at 15:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > If you have suggested names that you think make more sense,
>> > I'm open to them -- since I started by knowing the behaviour
>> > to me the names I ended up with seem more "obvious" to me than
>> > they would to somebody else, and it's the "somebody else" that
>> > I'm trying to help with the naming...
>>
>> I think I follow now. My only real suggestion would be to make the name
>> _v7a to be distinct from the v7m profile. Although HCR.TID3 seems to
>> exist for v7r as well.
>>
>> Anyway:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks; I'll make that change and apply these to
> target-arm.next.
>
> FWIW, v7R can't have the virtualization extension, so
> it doesn't have HCR.TID3. Virtualization for R-profile
> only came in with v8R.

Ahh found it described as "OPTIONAL set of extensions to VMSAv7" - so as
a subset of the memory model architecture. I guess because v7r is
PMSAv7. So many acronyms ;-)=20

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

