Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3094C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yig-0003FC-QN; Tue, 08 Sep 2026 12:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3yif-0003Ev-UW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:30:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3yid-0006u2-H8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:30:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so58278405e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788885045; x=1789489845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uKzMu/w+W5SBxdXqEuP/+VCuQVtzy93cR1Y42Tzffdk=;
 b=U43ANh85KRFKjB4dLlb4suj8EdPQNlLaPfolz4e+joL+Y1+rzy0Qpi7KFRIrIkiomS
 xjobOs5cvmGVl/bpHw6giXRypNWfn4RnR4x9OqGQuM6yWuW6UiEludnMPrxjP/D7Qnj1
 yAzqvqK2gyK1m9drBoFKdxYHeZTCSsgle4LRWBEzR4UlIRPT24+L3GenwHGcrx1n2R4J
 iq68M9AvRk2kBKawKkWTd7MQ3E6b918DP/W/m2MixWE9oNM5QjeW4CRKEah9d8XPRiYc
 vey8XMgm+X5RcR3ZsBaqsL5c6iXvdjY86vfW9534JL6E5MGQTTvqNbsw0wzfDtVQLvgX
 35fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885045; x=1789489845;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uKzMu/w+W5SBxdXqEuP/+VCuQVtzy93cR1Y42Tzffdk=;
 b=UMwfYGutosBUguJTvojstXJO7vtIUPc3tfSb5x2SBJmWVH/0ZMMh7qRVWz27DnPDtY
 lpMhJxK+ieEL4IVacbUeulLK3imUCm987vS0ocfrgJCzsiihl1DDj1eq/KN7Jj5NamFR
 LPybUDkUNnvnWFUsmT6p409dvQBnPNZtO/wYL6NJc5jJ+aV2vijDHDbAqYEbLK7i/X3Q
 4HFnvBgY3qMKUOHHr3nrHVkCONf/F3BoriZiRmPkONzM5T8bR43zwvi9s3vSlRupTMao
 GZGMAXUFHzYeWu8UGfdFKOXMRQsI2w7Uo8eCKSM3cMHL06ejbgykQKqBA2eMl4CX3YZl
 RfAA==
X-Gm-Message-State: AFuF++lVBcOD2esKpqge0A5jTYxBcEcUdTjef+Wme0/jzG4fIqXIBKI7
 +6/KjcrP/UYI8pfLzN6xzsxZLIcZTnwBpdaTgT29QBFDvnkoxWcIJ9FJvPaWyVp3WUA=
X-Gm-Gg: AYBFou2AwvI3CKk48qP66J+NKxRyUPSpVkUtnv0irjJqJhsE4KHl4T1+TASm09ilR/t
 Fyu1T89i5ifrApxGPcwQ/Mb+U57tJQt+g4RXBCszh90DniPIrN6Wcu6f5Q8WY8ZcFV9EoEAF72e
 77GPtlW4Kl9BCUVg3zuxEaON1U6m6ZcvPlk6u8fGwIERw916dQzoh+NBWpl0Hl5XLb4BiLFqtMF
 wLSlSaZNAIWWxrrO3444dNFip2fDl3IzF7v1WTfOdnz+RSwhwBQrfSnBaV0AihEVKpMSzZCfSR2
 naFLUNx+1SPRCGUJm5O0PUaJPIT1h7YYPiYPSjH+gW4An0wDb0K8cOuBmseUMsDWUbtE2C8TUlR
 laznVv+GeHcGXHQ27uEtb6N1HQ1vsofLCjUcS2S5eynJY/xNDDvigz4Nrhdu/xJ6Cz/tvATsa5U
 Hb1z22nj/K9+UV0zvuSjjw2cz2r/nwYPCyP28V1EgCzHtTpYafdy/HZDwupD7P
X-Received: by 2002:a05:600c:81c5:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49d0443096amr204987225e9.27.1788885045448; 
 Tue, 08 Sep 2026 09:30:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm476245385e9.10.2026.09.08.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:30:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96EFC5F845;
 Tue, 08 Sep 2026 17:30:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Samuel Tardieu <sam@rfc1149.net>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "open list:STM32L4x5 SoC Family"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart: Accept character input upon
 RDR read
In-Reply-To: <CAFEAcA_hbEUYO+0vSDZDGtyp8uo+The9q_Bkry2WwJY40EVvTQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 8 Sep 2026 16:51:11 +0100")
References: <20260902165956.582901-1-alex.bennee@linaro.org>
 <CAFEAcA_hbEUYO+0vSDZDGtyp8uo+The9q_Bkry2WwJY40EVvTQ@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Tue, 08 Sep 2026 17:30:42 +0100
Message-ID: <87y0dbaeod.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> On Wed, 2 Sept 2026 at 18:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Looking through existing serial devices this seems to be a common
>> pattern so it makes sense to me this is the right fix and matches the
>> API description.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
>> Reported-by: Jan Brittenson (@bson)
>> Suggested-by: Jan Brittenson (@bson)
>> AI-used-for: fetch issue, apply proposed patch, verify build and qtests
>
> I think the fix is fine, but given this tag I'm not sure what
> you want me to do with this.

well in this case the AI never wrote any code, it just applied the fix
from the issue and tested it which I think is within the current policy.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

