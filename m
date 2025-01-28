Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE1CC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchUs-0003Iw-VE; Tue, 28 Jan 2025 04:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchUk-0003GU-UN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:02:55 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchUh-0006xd-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:02:54 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso1035414366b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738054970; x=1738659770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjjqAXex8o3R+VWVCq3+VLzEEhpnDBIE+N34LWU+rt8=;
 b=FK3HQ2obzKlWKUO39QNT7mdZA+v5cQykL3w6n1XzCejpbDIdZAG+4l2ZH1gSJkEdAO
 whOWWb0XrLnAmXxUcGbCOz0996xIkJLys4GIVy3Go8I3+TlzPNetiuSgycgBy1FtcPU9
 J4iiOCIFnErxeb12tqnQD0L9Ekq/KazK1safNpuicXkJogVFKbXjDaP61i7bOTREVQ3o
 McKOZG3pb2jClVaqkeC7TuYZgCFW5D8kwxt4Jq0PSaLOTb5ZUNJC8smtEN75jTVO2WGt
 KULwjpjIneqZnLJdxi87nIt/mz44HsRQjbeZOBOpzEpgyN5JXVMggZBwHcCYcox8S/J8
 fFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738054970; x=1738659770;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gjjqAXex8o3R+VWVCq3+VLzEEhpnDBIE+N34LWU+rt8=;
 b=YRtxE4ujWXk8vXNwVytIu/gkKC1Nmu7Iw6xQmrOOweG2s0EMEIafREvighC65fh89u
 iwWlhbNCo+c7LmN+6etD+aKcz0cqbumuaduLYvaM9S6ovJCYO2QABOPBhkd/41xJ3UTr
 9ROXAqnND4NwumkZpX03JkgGToHJDq0fgTPTwOpqagJ6Nzw/7W3toMVl+PxIRaRJggWU
 lnowJbZV3aydGmgbdR4dWHbsXZds4ILuBtfrEzqbLXHZptWfmLNgZy9zxj8/qrphUtr5
 ST1R4arI1S3/PY+Usmc5IBhUdlSdxgMTPXEDWj29sCK5cSweZhzPsJ7pn3cwN5pQLWj/
 McfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8M9Wf6zB71U5x9M9En9H6gDQWef+F0hIeXAbppWCoPbRCpCRu4lmuXy8CqOUD64nhwBROLI5oJDgE@nongnu.org
X-Gm-Message-State: AOJu0YzeaFV2Jjt/gwPHhskKvYnw8JA5she7V4E5gXSiMGNIK62kqUy9
 PPaD1Y7ZhhkNuqvT66Tty4LH33HNxt9J9S4lTwAW6VtoJy5mugaks9VRTpKlcHY=
X-Gm-Gg: ASbGncuWhyBDKf1NMUe+NLqaQppEE3VRj1tOukGtYrI+7Cv9AyPdZ56tcw0Tu0BfwgO
 jGevjol/EaRGqaBv1Sf2b5nl8dNssGyEXfTCBl6mZXJwbmDoeQDxTYBzgZnIURWLz3n9Yh59pMC
 GrZroc9I+Q+DbKZp4Mo6kycQBLT52Vi7AFP3TXW9Vr/zHC8hOtRg4qWEWTpgIh9MoPttS+bPdIi
 XZUaMr0t42ZJ2pjXHD1pTkRnxHpSdQmRlV8tSfpWRB/jd6dVHrcc2rNbbhwJZ+oFp8lOe1K+exQ
 /LCm2qLSEqDg2A==
X-Google-Smtp-Source: AGHT+IG4wX6NltI+yIxIDiCtUSKLTDWzO8bditeLUvc+kUqIh0iId5trPSv/U9FBYNunumDR1/9wJQ==
X-Received: by 2002:a17:906:6a24:b0:ab3:8f33:408a with SMTP id
 a640c23a62f3a-ab6bbbcd33emr247900266b.19.1738054969952; 
 Tue, 28 Jan 2025 01:02:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760fbf38sm742420666b.143.2025.01.28.01.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:02:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 719AF5F8D1;
 Tue, 28 Jan 2025 09:02:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  peter.maydell@linaro.org,  stefanha@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk,  Liviu Ionescu <ilg@livius.net>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
In-Reply-To: <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com> (Thomas Huth's
 message of "Tue, 28 Jan 2025 05:00:35 +0100")
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 28 Jan 2025 09:02:48 +0000
Message-ID: <87plk72tvr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 28/01/2025 01.42, Richard Henderson wrote:
>> Time for our biennial attempt to kill ancient hosts.
>> I've been re-working the tcg code generator a bit over the holidays.
>> One place that screams for a bit of cleanup is with 64-bit guest
>> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
>> have to handle such silliness at all.
>> Two years after Thomas' last attempt,
>>    https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@red=
hat.com/
>> which resulted only in deprecation of i686 host for system
>> emulation.
>> By itself, this just isn't enough for large-scale cleanups.
>> I'll note that we've separately deprecated mips32, set to expire
>> with the end of Debian bookworm, set to enter LTS in June 2026.
>> I'll note that there is *already* no Debian support for ppc32,
>> and that I am currently unable to cross-compile that host at all.
>
> IIRC the biggest pushback that I got two years ago was with regards to
> 32-bit arm: The recommended version of Raspberry Pi OS is still
> 32-bit:
>
>  https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@=
livius.net/
>
> And looking at https://www.raspberrypi.com/software/operating-systems/
> this still seems to be the case...
>
> So I guess the main question is now: Would it be ok to kill support
> for 32-bit Raspberry Pi OS nowadays?

I would argue yes for a few reasons.

  - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can work
    with a 64 bit OS.

  - It's not like the versions shipping in bullseye and bookworm will
    stop working.

  - Even if we deprecate now there will likely be one more Debian
    release cycle that gets 32 bit host support.

>> Showing my hand a bit, I am willing to limit deprecation to
>> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
>> unconditional support for TCG_TYPE_I64 would remove a *lot* of
>> 32-bit fallback code.

I support going the whole hog. I would be curious what use cases still
exist for an up to date 32-on-32 QEMU based emulation?=20

>
> Sound like a good alternative to me!
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

