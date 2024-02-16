Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB8BC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayW2-0001xk-LS; Fri, 16 Feb 2024 08:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rayVy-0001wM-Rf
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:44:31 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rayVw-0000fQ-QY
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:44:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-561587ce966so4037507a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708091067; x=1708695867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+Zl3vqJANsD9DOyRY06p8VIQhTm2yVMUTc1AEOdVGM=;
 b=ql9L/caKFJdN76LZ0zDIhXkXfUkq01/Gh4B3JFH7I4IyDprL5x7QRM5JgNvex9ioZN
 7PeIYb+pCJHaDXq82iXpgUyCK9tfJDxnAIG62iTtToOnpsFIUXOgpgbYsvzW34foN4Q2
 JYdC0pmUR0uAjn7FSUhX3HSOLIGDa0ihGrmjwyRu7AMcjdrbCfOTo/6BQ0EM+ertphsR
 2ZFpnrbMqKIzVzkZ1oisnaGEwxnUXnkLqHxoa8AS71dFmdwLpaQepXxZRcIcX7dyVSch
 Q7sguQHZqTHzmwabjdXpA+pJbV45Pc+P7js4wVuiyYZ1FxrM5utYWKKRkTTMcTk7N8C9
 PfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091067; x=1708695867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+Zl3vqJANsD9DOyRY06p8VIQhTm2yVMUTc1AEOdVGM=;
 b=Jch62e3lgrmwQPKyvkTF4XT/h5A3fo5SKAjkloU0EhLdzAbdG6J3YoTYjzkAkkNrlb
 Ls8/2U3bbNtqwjo10QxQy/ugxsHs5WbuSc9uBhnT+mnXTuY534Wqo0NDPsx6TPla2LMs
 FRMDxEZsXW/nl9sWC2TRNduFlIqdBXYpsBH0b9JKoe/ai5fA9VJ0WPj7g2bGk1EggCeF
 EigkQ9D4H3WrcW9Su+jRSGEiZ8J7g/Mb0lyKu3PuNJIGXejK7c/jG0/tfi7f+8a0oMcV
 +Bt0uDC0lWToIlHBe29Ca4fEaASL3ufS5/WFB77qqu97g9Y4EP16eViHuMVyPQaWe5cO
 X2NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvz6S9Xq4piQTX1fOe+IQeTb/34kcty+4wFpjPlHSrr3ahAeCjzsJ2QKxZ8t7a39THt6MmpckoUkPDYuijYgY9kezO4LQ=
X-Gm-Message-State: AOJu0YwwryDLt8li8HTlq8DVmic3M+y3Adg7PsBdhwzAdgodK/edXJcl
 VF9KZjdalL0vm+mLZlKOC0G8mCBrEg0goh+93n1WWFPx71tuNoIzTpKotDLNQhRTgj6ttDJseBb
 ifC/SyMh9SjeGJlXgrXXkjt5FC8rzd2NqG9Z0VWArl3sAbxe0kQY=
X-Google-Smtp-Source: AGHT+IEEuqvHGYXJ80mHqDSfLfNRZi6KIYSbK8sKRTQ/+LGiS6Cp5T8zuike/pOHphQ6Ltbl6zXC81MnPpOVbz0Vtgk=
X-Received: by 2002:a05:6402:38c:b0:561:f4bc:606 with SMTP id
 o12-20020a056402038c00b00561f4bc0606mr4538154edv.0.1708091067149; Fri, 16 Feb
 2024 05:44:27 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR01MB7795E154CD5AE6ADA60C0D53A87C2@BL1PR01MB7795.prod.exchangelabs.com>
 <87mss04oyi.fsf@draig.linaro.org>
In-Reply-To: <87mss04oyi.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 13:44:15 +0000
Message-ID: <CAFEAcA9nMPs7WdXzmwM-m0VSte9nmvtJFVWAUKmqZr4YYZPVtw@mail.gmail.com>
Subject: Re: QEMU 8.2.0 aarch64 sve ldff1b returning 1 byte when 16 are
 expected
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Mark Charney OS <mark.charney@os.amperecomputing.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Aaron Lindsay OS <aaron@os.amperecomputing.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 16 Feb 2024 at 11:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Mark Charney OS <mark.charney@os.amperecomputing.com> writes:
> > Talking to Alex Bennee, he pointed out:
> >
> >> I'm wondering if this is a result of the fix in 6d03226b422
> >> (plugins: force slow path when plugins instrument memory ops). This
> >> will always force the slow path which is where we instrument the
> >> operation.

Yes, this sounds like it. The implementation of the SVE first-fault
instructions is that we probe the TLB to see if the address for bytes
beyond the first load is backed by host memory. If it's actually backed
by MMIO then we will not load from that. A comment in sve_ldnfff1_r()
explains why:

     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead=
.
     *
     * Unfortuately we do not have access to the memory attributes from the
     * PTE to tell Device memory from Normal memory.  So we make a mostly
     * correct check, and indicate (UNKNOWN, FAULT) for any MMIO.
     * This gives the right answer for the common cases of "Normal memory,
     * backed by host RAM" and "Device memory, backed by MMIO".
     * The architecture allows us to suppress an NF load and return
     * (UNKNOWN, FAULT) for any reason, so our behaviour for the corner
     * case of "Normal memory, backed by MMIO" is permitted.  The case we
     * get wrong is "Device memory, backed by host RAM", for which we
     * should return (UNKNOWN, FAULT) for but do not.

Unfortunately because the plugin memory-access handling forces the
slow-path it is TLB_MMIO here, and so it ends up in the "normal memory,
backed by MMIO" corner case, where we do the architecturally-permitted
but perhaps unexpected thing of only loading one byte.

thanks
-- PMM

