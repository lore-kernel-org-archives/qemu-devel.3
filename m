Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DB4C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSIr-0000ca-4V; Thu, 13 Aug 2026 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuSIq-0000c4-7R
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:04:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuSIo-0008R9-3S
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:04:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8114a4542b2so9033917b3.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615484; cv=none;
 d=google.com; s=arc-20260327;
 b=Ve3T9JQLJn7So0MGG4v77BJjwyRdQlDzoVYYtDAXOv3QdAkgAgksS6R6lTPPQrgv4E
 hn5cxKoE4j2N9dcSeXosuCanG75f533HQjyu9QvBlLpLzS8emffqyd2J985Td4kIwmsq
 zFuLq3o22lDAwLwfCPMTGWlnXz+yXiSKRSOL1dMOgk0gawIqtj4uYnwvJWQEnFOYfqUS
 yho8T0PCbPNy0XGp03TlYFHhW58BywT336CXDOD++VyGfaMxldG+lcw/njDe31mc+/Wc
 bVDIVKH8vZ4BV73oQLVsiL1nJcbU+BXJnGa1jKT9t6F0ipjTbEkH1ECWcsJ4ZUYpbch/
 7UYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=onW2dnaF2GCB9RsEW/cJS52ANjiN85srWkj3FUbQj2o=;
 fh=7cW1dwdjdaAB3R6mHOtMEB+YqIHRauAuoGGZN0AodcY=;
 b=JeUfvuul77NixiWRcZY/OcElltIS6DBffREWTLUqdHHi8rcB1XtZSxFFZbjDWkkI5G
 +7Hg+MzSC8TtyUl7alFkevwI0TDDXJ1Tn/3oeBGHEY32tMWhKoMFKQudobFDAfohXIrk
 APzkWJ0u6jPLRXnbqnKhUeklAksxJIjQQ1iJ5cmQBtXMxG7poQwTRzYlOWWq394oDolW
 mWdcruuqmQVLlFQSDd6t414mt4rlO340VDHiDIYecC176CX1wzap95oimbXW3f7rQzoi
 OJXv2tv2Csp2dMOQWHZn4CIodG6TRG4hKAaXxEf0pNWGN56A+ZMwx44EeqsTpOHm9r/z
 AicA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786615484; x=1787220284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=onW2dnaF2GCB9RsEW/cJS52ANjiN85srWkj3FUbQj2o=;
 b=CGBbL8d1IZelqF9MQdiQD/OVdDiNqPgR5sJQknBTou++lhJ6+8c9occjC6vVmjUEWl
 8kfdCyd9ub8xBmlWg3qTAs7w2gtHkz3ZociNwlzz5NWL8Qfga0nM1h47r1sfX42pJlTR
 vMzKb02epWUpqSD77S+oUMwOtCZyxOsymchvCSNwM+iakjj96AckQ8W+oDjRr0cx9b7N
 VPhF9k0Dak4AzSOmICR2ZWR0veEP/QmDdm8PF6dfxI1j8b0RnWFoD3CoDEMEIbkggIij
 cCOJw4mRHCYdLSTjGj4Uy8CA//6X8O/9klyJ/lcZ6FUJIJuhgVDM31SVdRoRDCxv5zPH
 UMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786615484; x=1787220284;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=onW2dnaF2GCB9RsEW/cJS52ANjiN85srWkj3FUbQj2o=;
 b=czyrqOU/OB/AKOfrnLKgzqr2cLrVT7lUzQSlWVbAlpM8Rg/GW8YKA8Z9rNDVMLknEY
 pntR6uIeDpRDauEIL6qpjw1NNsphTN463lLeFow9XS04f2R3jWiFQGevwpsX89xu9qT8
 rFptvkkjCN1ro/BzOMxSIc0bcVdcYgW3fzicBTeYpgNvQ3PzZj6fEXy6NCgT6CY3Hviv
 nPMwUhKM0TcIf2GsSPbR2vb76F9HHZDzZsHry4EChV+Ot2c6Ad6ePRKCVUFGPD4LXlnV
 FVxBLAca9oaIN+lQBQ26Nsk81beWdrqg6leAs4hwRifY8W62pCQ1AEwJX0Jlcy1mlMXV
 az6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyxW8HaPQ0OOyh4imPwTYEsk1Dd3cSJLMnRlXQHTIcoO0ZChV/vn8jL10MYqUIET54FfUCaWIPS7mN@nongnu.org
X-Gm-Message-State: AOJu0Yzrk317Z3aj3EFvrCoEc/sKTrPlDhEp4FMUonfyQCns4e7XsMrE
 tiiuez2dsZO80UskeuzrjlEwQstBRZ4kczxRpHz/va/UHgrHci3vGNJu3Q58nXpE+1t/ltj5UMA
 MkpXZInjKh48gcn1rXdLi78bMFl7X+N8=
X-Gm-Gg: AR+sD13YBTZEq9L8VrGLeKncIKjK46nMDj64297q1s6Df4Lut3NfAWwzLFrNMMqM/Pc
 jPnr+OZipsuSoLUx8D0QlJB4U5vDZhpIxXKf9D4DgBigdHrMNwTt+ve0WWpNSc6d2Glo+zcmW1+
 OSkjB85OqNxnT8q8ImHzXRAnHDbfDxOHO6hYLTtx9aDW4Dznz2oAd4Np0Uo4eLhqvH7nLoFS+MP
 Zu3zNY/KTvGEvDNXRH60JsFIqD7NF2le1nfLYHhzutqMOKdrczClCjPip3omhXqgca3Pa0TUJf2
 2KlVqFfGArZQDrOjzyrlwiKpwEpU6zCO+BajenZ1B5rVO030
X-Received: by 2002:a05:690c:397:b0:81e:a3a0:701b with SMTP id
 00721157ae682-8347181ef65mr21737977b3.9.1786615484002; Thu, 13 Aug 2026
 03:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260813054329.35425-1-chao.liu@processmission.com>
In-Reply-To: <20260813054329.35425-1-chao.liu@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 13 Aug 2026 18:04:32 +0800
X-Gm-Features: AUfX_myMmBKgRtscE2ficTPYlRhCK-lMKXUnysIcc8zt8Bxxh_vnsjbLeTtfE3k
Message-ID: <CAEUhbmUqMbnqWXuxn-FAV5YXofMuc6+L=aGuc=YmF7e=BBMUDw@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: remove trace output from k230 watchdog test
To: Chao Liu <chao.liu@processmission.com>
Cc: alistair.francis@wdc.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, bin.meng@processmission.com, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Aug 13, 2026 at 1:44=E2=80=AFPM Chao Liu <chao.liu@processmission.c=
om> wrote:
>
> The interrupt mode test does not depend on trace output, but passes a
> trace file to QEMU. This makes startup fail when QEMU is built without
> the log or simple trace backend, so qtest cannot connect.
>
> Drop the unnecessary trace option.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4126
>
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
>  tests/qtest/k230-wdt-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

