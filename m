Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F045EC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuzhB-0006WT-Hs; Wed, 19 Mar 2025 16:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuzh4-0006Vm-KE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:07:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuzgz-00046s-Sf
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:07:13 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso14194866b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742414827; x=1743019627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDevdKr9Yx/Yuivjge1rkn0WhzKM9eeqxk5hvEDPNcU=;
 b=qhCyFWTh6YcJmd0ialn8kPjvCyMMkgTD+zKTKhayrwxkjv2ERyw57O9+LWQzIzwwTT
 xgJXugMExeAdHgVB9d2hxw0VT7vSkYutRI4dHF3YpDiBEAj/P1QMaqz/I2D006BsAb4X
 /z1MOGEhoaQ/S11drkqLXRRUdjAJtiGs6y3et7owrvlyQdvlfgATRvPg6J7nMDi2swey
 ysQm1BGJBFMERg+uTYtK6lHlWLq+M3zzdRIxHJOXRka+vnH0jDuX3RqxvykPWmBIKrKZ
 LF7ftwB6LzzFoyf8SLgGs6bCrGIKbP+AF1HUvtgR80CIbrJ47b+Qj0ze0aq8pq3aHCa3
 Ic4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742414827; x=1743019627;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDevdKr9Yx/Yuivjge1rkn0WhzKM9eeqxk5hvEDPNcU=;
 b=riKaNqTM//HSMNdr0yWWsC4Ry8LPO/yDbBMmqapeMOFQMzqvoZt5suV8yTFKzHDlZL
 5RV5NUgUrrEdqJmZAySQDCo0gNlCyozB7k26Z057ldvD9zbRSL4aXhVhXU1qQ2cCrIdU
 +fFecdSljFyC72ncch5skeeZedeUwBtoU7VnpBeNMtQqes060fw3tHKSW/HNj8unB0tL
 hxM4HedPkJiruYhbmMc3fbFSwP2af9jB5Q3koB53+3klLcEvzop4qFopZbBboWGp9aVn
 fTw1IYA0hyQQa+FbeZjYrOqKQlQKHzKBpJsjQ6SbsJ+AeVc+gPWlFtOyivqOW6DRIgYW
 USIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtt5nHKVbF6lIDjXz6N8g6AgpKDGyNG81fGvjH88qCoGgZqpQTAOtvdFm0CtmtnU6d9gzGRZJtO+VP@nongnu.org
X-Gm-Message-State: AOJu0YyF8Jsm557sprKbKGAcXg0x0cjEwokB2LnlzkrBcspy85hvXrjg
 xiSpoBHbvHmQ4Fab43VW1Bc9v/psfMlMpeXUTPyRafRFXmKzeYYyoltLls0LU3w=
X-Gm-Gg: ASbGnculo0yTblztby0KqmJaWfYbYgto13No2QaynCT1wSuCsLOc5yQdcXZB+DZgR95
 77GuESoFd4230L+fc0ee1bbPWaKsmi3ALea+zxd8WWw3qPTGudmkUcrFy/E4LybXjWRJ3on1w4U
 2eDmaTISd06L1L9nnQkSz5WgqataJroJJkk1WloacrugQDFpQgBym/di1dZCCLLD3MIHO/4mv2r
 CSK+V5cKK7ewg0UacmgpVj1kM+GKyxMFvkeIXbF3K5HOpg02SoRFBRlJe0vHoiXu+1XRsNW77jX
 NjZ2bAwhSNTmwszcLqfb1UJ6ErNDHOg89HyCpmQmkv7ZmdmFymFvMh6KWA==
X-Google-Smtp-Source: AGHT+IFmRtP5N9Gx4CeETUKINV6ILXqKPzkkvp0nKbk7M8RsKq7/vUK+nRNRNdtC1oHkKOpmbo+VuQ==
X-Received: by 2002:a17:907:805:b0:ac3:d27:3403 with SMTP id
 a640c23a62f3a-ac3cdf90229mr83651066b.6.1742414827457; 
 Wed, 19 Mar 2025 13:07:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47f0bsm1042759266b.157.2025.03.19.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:07:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 261325F93F;
 Wed, 19 Mar 2025 20:07:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Corey Minyard <corey@minyard.net>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
In-Reply-To: <87o6xwkerz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 19 Mar 2025 20:21:20 +0100")
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 19 Mar 2025 20:07:06 +0000
Message-ID: <8734f8n5sl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> Corey Minyard <corey@minyard.net> writes:
>
>> Is this official coding style?  I'm not a big fan of having return
>> statements in the middle of functions, I generally only put them at
>> the beginning or the end.
>
> There's nothing in docs/devel/style.rst.
>
> I count more than 42,000 return statements with indentation > 4.  These
> are either within some block, or incorrectly indented.  I'd bet my own
> money that it's the former for pretty much all of them.
>
> I count less than 130 labels right before a return statement at end of a
> function.
>
> Based on that, I'd say return in the middle of function is
> overwhelmingly common in our code.

And with autofree variables it saves on clumsy goto and cleanup handlers.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

