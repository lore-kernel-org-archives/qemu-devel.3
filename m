Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E2D31765
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Mk7-0007pq-Ge; Tue, 05 Nov 2024 11:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Mjx-0007p3-Nw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:49:15 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Mjw-0004LT-3S
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:49:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cb15b84544so6783655a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730825350; x=1731430150; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYdODIt3Zp5/WQQbEqr/10zY5mw0gGMdA+UgRZIn2EI=;
 b=DbQ+Kjito/92T+lMPl3YF5iZ2yPC7Forl5GU4S/IQF7E5V3NVwT0jdE3R8DaAPQauR
 oKGAHlSvB6tcwlz9ndFpyFi+24MNkxg3rZRM0L20pAO2mDOEMJ71AqPZ4TUijBCZYhUb
 uSCwE6jFBk961lCm5XgamILL/y+sPvdFPoWpW6K7pU4PSRNHZW/OfZvDGDQ6lF7QGYyg
 yK5eYvYDXru/EauLpui9T5meYMafvxalWx4p1/7SnabYxyHc7IyZ8u7r5MsuMIz6FDci
 2amk1lKu+COSevJ1hW7/LdmWQjoS2jifySNfgBfxUTXwWsV7ZOzwrUmLjIHtgXBVsjna
 q6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730825350; x=1731430150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYdODIt3Zp5/WQQbEqr/10zY5mw0gGMdA+UgRZIn2EI=;
 b=MtPOs9gjFn7zXDOgUaACD7eCJBNaboRUIrmTSXq4u+Rsnhm+2i+HJYQsdJCwjC2clk
 Z/gq/PC6UKRCmaCIMJGX5njrHvVUKVV0VqmdtYP3ys/twFnGCjSJD2irFVxEDROuuusd
 aT/w0kxSw+VMkfQY5R+d8WSvbF/cErsaaqcVUunh4ffwgH85oSmu9ohWA8EEKBiVHx6m
 HstEopnfPtjRSZ55Y1bXh5lVMs1QXFw2z0HruAWvW3EhhkQkK9OZFeK80quiFT1nntfA
 BL5f0DuJt91HpX7dcoKEI+1FGrs8qWX/u3LtyjQUsKssQXTZHy/KuIUHTAGWfFj4M+QP
 mYAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpCDHfa37fHsKwYJ5krbS4ngE9Ay/AwfrTf55GekJhdgvAjK4TYpCzU+QP2b1PTmQQkUYz3Ma2uLtP@nongnu.org
X-Gm-Message-State: AOJu0YwRtn9va6emd4S7OCl8xHXDudwNDT6ez1XxziRdxJalm93fH48v
 Rlxbn0wXumUiMzSMmK4EWVclw8+vJutb/M4UzO/pDgQNuHoFarudY1qBJBMzrCBPKi0SOcrht56
 o8Rp9C2/biQqCYwqPjmxlXFhcS23Uf3lrTDOqDw==
X-Google-Smtp-Source: AGHT+IHLj3fuqBBFhJR4ULPl5kHpw8rGHfChF1TYouWgum3vyHHmgcjDfRjNqdZHcq1sBna1QDEomo92lBF4cUH6yXw=
X-Received: by 2002:a05:6402:f8d:b0:5ce:c8fe:ca75 with SMTP id
 4fb4d7f45d1cf-5cec8fecf1dmr7387102a12.6.1730825349996; Tue, 05 Nov 2024
 08:49:09 -0800 (PST)
MIME-Version: 1.0
References: <d9aaedd4-80a7-40d1-b5ab-c75afda794e3@eviden.com>
 <Zyjdm6TC7jfa-wlR@redhat.com>
In-Reply-To: <Zyjdm6TC7jfa-wlR@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 16:48:58 +0000
Message-ID: <CAFEAcA9BzpXdBpWcRbe42TSpUyg8KP+--mvTdqfM8t6Y+t5Knw@mail.gmail.com>
Subject: Re: [QUESTION/ISSUE] edk2 missing dependency
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 4 Nov 2024 at 14:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Nov 04, 2024 at 02:32:53PM +0000, CLEMENT MATHIEU--DRIF wrote:
> > Hi everyone,
> >
> > It seems that https://github.com/Zeex/subhook (EDK2 submodule) is not
> > longer available on github (which makes recursive pull of submodules
> > fail for a lot of people).
> > Do you think we should do something on our side?
>
> Once EDK2 fix the problem, then QEMU can update its EDK2 submodule to
> get the fix.

Looks like the "EDK2 fix the problem" part has now happened:

https://github.com/tianocore/edk2/commit/95d8a1c255cfb8e063d679930d08ca6426=
eb5701

thanks
-- PMM

