Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60973CD8C80
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYqP-0007qr-9E; Thu, 13 Nov 2025 10:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJYpg-00077E-1P
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:01:59 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJYpV-0007QI-P3
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:01:55 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63f996d4e1aso788839d50.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763046103; x=1763650903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQpCjXMzltzkBAk1cWSLy/WZzoIwfDzQGuuOWhLwCNE=;
 b=iI5QvLHgq6PXBc0/Vfn8aTEExuZleVZ0KZSC1Ox1BSG4rYyFJVgLCs4h0+Ejoy1/0A
 cd0wlLT9u5T8CnMnXFZnkuEXt9TuRKh6GbD72VPJrUZyVCTETgEfFohaRqWWAK/oIV6b
 cLtZ+kYdEg2zrpYpBxXcmsMR02aKSSGs3jCCiRzlVlXmgCjyG73z39axqRy8f8rr/Vea
 UltCVSgb+oDxmTYBkK4NhbQKm++WQ9bNPUb32EizNR0QartjwEh/zVh+gdNr9tscoUo1
 ePsXY2NhssiJCJwMTKYv6moskfLiu9x0V/aE+2UlOwbmYyf+iY3NKxLrwyOrFY9kdJW6
 Ruqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763046103; x=1763650903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQpCjXMzltzkBAk1cWSLy/WZzoIwfDzQGuuOWhLwCNE=;
 b=iNk6DzO3ntvs+ZaZAoUJ3Ip0pmoFHxrvfAIIKP/fG+kOCiJ+VFYJ50XhFr8Tcypi2G
 jHfHH+TGaFebXcEmc5Gya6rHgToyXmBr9kjgfONT1XQv9CN7lwYRLOE9hUYHpcj4AnkT
 9nXzSy01phoHs3zWAUIEhsAhSFluNFvU2N9dsYjEPR0Ld1zfD/OdvtvtiZuqzN1I3fPN
 1w1OhHrubEnUTF1zJJg+8+etAaB5M/swLmtfUldK9zhMZkmLNuq2h7vgBcj6jizxJeOa
 HldJllHri4TImy65V1uSmx0zOVIFhIdUiZyBZYJRFRDINRlEoog+pNpu0OmM6bawQt2A
 OYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUFn5E0n4xhDeAYB8x8NRywuRbtezlv5thR4XRb5ybbvhllSLjaE6Py8MLngzihZbwXi4kYSiMnwx@nongnu.org
X-Gm-Message-State: AOJu0YxVB2eT+n/Pfxp16pIkxeA425S5MV+W0MSBMXmECbmD2bvjHied
 nLbi7JgiGiCyOXmQaigiLcHGFJJzTmq2ZtWsT/qdWcs3pzf2qD2OSAWz9BZ8NS+oS5Vr+LCmpD7
 5SMTmJgNbtAwvflLGlryz/MfP1OCgouzHDRehLsiFrw==
X-Gm-Gg: ASbGncvGk6i9m+xbhHzvdJNsSjTTqyiSR+YcugW4zQbFjoqg4GKexn3r+98+BL4ZOqC
 kT2Z2NyeSGsLMkLvxy7atkYZlWseMrowR+Nx+Ui3joz9BbQ5po/o6ye+VcspUx1RUwKsuynOvZR
 KB7SqHP44NH3Mii/Rp/V2Yz/w2tVuNlTEIXBtaLJNX54RD5O8+CC0xuTU1//JTCJ1L7Z4e1j09X
 mou/9NJ8UFh5XP7N2tKa/JlMWMC6sYBacpweFNBvqm3gdG7IzHg0OdWFiacaw==
X-Google-Smtp-Source: AGHT+IGcJpPS1WsYzqNoG9Dnm25rLKNVdipiNLeP2dqcu/KF+K5YZRKRsEaVb6OfY1WRgHiBAFPhS2NNVlDS20AQ2kc=
X-Received: by 2002:a05:690e:4186:b0:63e:b62:5826 with SMTP id
 956f58d0204a3-64101bb51c3mr6052682d50.67.1763046103202; Thu, 13 Nov 2025
 07:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-2-eric.auger@redhat.com> <877bwtvaj7.fsf@redhat.com>
 <791e0383-c4c7-49bf-863c-d45428f3e48d@redhat.com> <874iqyrnt3.fsf@redhat.com>
In-Reply-To: <874iqyrnt3.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Nov 2025 15:01:31 +0000
X-Gm-Features: AWmQ_bk_FOYBCGthsQvsC4iCOFYns5evbDOjO7gyouMYynzLNQLMY5LXztggWFY
Message-ID: <CAFEAcA8F2JFR-X9oWH9cX+qESWDUbxfU+ZiPmFg2h05dgb4gRQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/7] target/arm/machine: Improve traces on register
 mismatch during migration
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 13 Nov 2025 at 14:48, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Nov 13 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
> >>> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
> >>> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
> >>> +    int32_t cpreg_vmstate_missing_indexes_array_len;
> >>> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
> >>> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
> >> "indices"?
> >
> > Originally we had
> >    uint64_t *cpreg_vmstate_indexes;
> > so I reused the same terminology
> >
> > As a non native english speaker I don't know if the usage is wrong. I
> > thought some references on the net though
>
> Not a native English speaker, either; wiktionary says both are valid, so
> probably a matter of taste.

Mmm. I tend to go with "indexes" as being clearer (especially
for non-native speakers) than "indices". Within QEMU sources
there are twice as many "indexes" as "indices".

thanks
-- PMM

