Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638C8C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXckr-0006vI-BN; Fri, 04 Jul 2025 05:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXckp-0006uf-Ft
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:30:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXckn-0002xY-B1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:30:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so427422f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751621443; x=1752226243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s09g/jNIInfQCqvHaZGhSzuYaQFNe1nfOpeTQix52wU=;
 b=ZrNONKxutyl4hsKcAoxv7vtOpPmARwRuY6+JamkSOZS8ZimB96J0+DtljQFQD53h4M
 RsdZ3kMQ/uJ8Kd/C4U0F3Y3YvDRwlCq7sl7+XzYGigIVx0eRJj+p8tDpvGTBRiTxQJIt
 t/G/9YmXBL15Gj/o/nmeFKDqrd7mpdeJlNytLmA/KbauXB7LjO3kR9l7xG0uBubEcgj2
 tI6ajB3m+ilw2kiB1mcwkpqIXq3S4iFW0zwsFfcUEbx0wcv9OdRLdhz/02ECpxJYQCZa
 yj7jfextdCB8AaLuZlpg3h+zAJRdITWBC11xtZ/M0KRAMCnrpnUhGSmrpFk/T5sPrBX8
 My8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751621443; x=1752226243;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s09g/jNIInfQCqvHaZGhSzuYaQFNe1nfOpeTQix52wU=;
 b=gp43PJU2zL2A63gyFWV5znA6iV7riJJ65Qu1fLGKWVt5hGTKHdo2DkRhpWefbGVep4
 rKGzB5Vuyq/ZXRtSBYjdfSA8AGiviFZoQSMb1x1yX2B4SEJCmaDbY3u+xS5Gy2yi7Hnl
 pXadTJnCITN90AgK5AKaG2sud++EL404GKRQRzQfBNrDb/QymRFCkaa1RiaCYgdM7JeE
 icLAOwIBI2WZklPZjkorUBkUzY8qZEadBR3wLEoSq+lhdR85Dp1aAkAdPLxjoF4Tt0Rc
 CS6neKwOJZBBbtwxSplEhoC9xFYCrB+ggj3pFMpYm25yMqhjPLNo/SwlPYIpqAbMe2hB
 P1sw==
X-Gm-Message-State: AOJu0Yz7dFliVVCqLAEH9VqKa48eXp3KBhMbyxnFiI30dEJ1FzSMaYLH
 NpFQO9Mb9zqnZDvEunWGJ6xVBYo+TeW2Jr9mR1uo8p/BT4MAWzZSsDzA6VCOaDk6NGQ=
X-Gm-Gg: ASbGncuWnlcjnMKOJSmJ2Ivrp0gdQuTJxodNEvNJZ2iBDViTkLGDieyl+Yk4YIFrVXJ
 rG8yoLrPTZTxHZmo0XNdClvh83B3D3tFuKNDuE65ofidKHGVmV3+xWQEq8QQFNjw0HxBiL5nbuC
 4oPsSg8bT3tEe+a4RJ5bMCY6zuVNKaj0f6TdZTz5fxCjVr1HZ5vlAr2vo4DYshx7R3MuLZuPRAs
 D1ipTWeccvuhoFbrwTJM60DdZVX8imX1fneeVOERJvq79CMJmo89Am22duqgS8WOrCIXxR3Qt3A
 Jylriw+JACVRH8KQcIB8+cgzyzWmZB34FHTZJILqfgEirvSKUMeZO5EMXzN2E1c=
X-Google-Smtp-Source: AGHT+IGvNNtwjqVtFovcu2p8xtGgMaIUS5PwrYJcU4FmK5boZrXeoCIlNwnPuMBTgBYV+K6VwquTjA==
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3b4964c0a9fmr1711601f8f.17.1751621442605; 
 Fri, 04 Jul 2025 02:30:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1628d6csm21691235e9.10.2025.07.04.02.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 02:30:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D87BB5F8AE;
 Fri, 04 Jul 2025 10:30:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 95/97] target/arm: Enable FEAT_SME2p1 on -cpu max
In-Reply-To: <65fc2bca-eba1-4736-96c6-59009d298476@linaro.org> (Richard
 Henderson's message of "Thu, 3 Jul 2025 21:12:10 -0600")
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-96-richard.henderson@linaro.org>
 <87plehb3d6.fsf@draig.linaro.org>
 <65fc2bca-eba1-4736-96c6-59009d298476@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 04 Jul 2025 10:30:40 +0100
Message-ID: <87jz4ob8vz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> On 7/3/25 11:17, Alex Benn=C3=A9e wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/tcg/cpu64.c        | 10 ++++++++--
>>>   docs/system/arm/emulation.rst |  6 ++++++
>>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>>> index 5d8ed2794d..f73729926b 100644
>>> --- a/target/arm/tcg/cpu64.c
>>> +++ b/target/arm/tcg/cpu64.c
>>> @@ -1194,7 +1194,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>>        */
>>>       t =3D FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
>>>       t =3D FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 +=
 FEAT_DoubleFault */
>>> -    t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
>>> +    t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
>> With -cpu max moving to SME2 is there any way to test just plain SME
>> now?
>
> No.  What we'd want, I guess, is a real cpu model with just sme1.

I've had a bit of a look around and I think the only thing shipping SME
at the moment is the Apple M4 and I can't tell if that's 1 & 2 or just
1. Even then we'd need a full set of idregs for it from someone with
actual HW.

IOW I think we'll be fine for now.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

