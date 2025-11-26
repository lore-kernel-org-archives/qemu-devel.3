Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A77FD10381
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOERb-0001t2-R1; Wed, 26 Nov 2025 07:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOERZ-0001sP-Qs
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:16:21 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOERY-0002rE-Aa
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:16:21 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so7605998b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764159378; x=1764764178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mXwh6k8D36rufnyTsKDqMOSgiNt1U4BnQQj0OVFT4X4=;
 b=etN47frdM0GxHsnhWCwfHKXStQh5xH5YremdjPI5DgT8fLLa+RR+1oUU/Q8w711fx0
 3IMsxVGHJarTBQO2H2E0ESdDfvplx1pKk/GxYO41500PD0UYPeZ5n4N3N+W0PUV5ehzt
 fd23G6OwH+fRqWMSzr9LbviLmu/XHzoiilDJsL0XD52IWcIglAkHefHyS9d3Bo9UhD3g
 i9360LmMYD1hlEDSXVGLXwCkU9vQrlIdYhvS0BkcwyEsbXkmOCbK77sA5bweQcjWTCiX
 DlGXlvNLu4YPISqd5jCDZs9/RVvlkqKNDhWvmfkBWfgUl1oCLCRpUZjN9XbMcOSrxXRG
 zzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764159378; x=1764764178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXwh6k8D36rufnyTsKDqMOSgiNt1U4BnQQj0OVFT4X4=;
 b=d1uH1ZEbPtrEWebKMz0ArNy5PYphzgw8OKLpwVnJ2AsSVMFonQbKIDsXoIrhoemXzL
 J8PqskQI44MKmKSWu65fpRrbO0xi3YPBmikGapXpRmOBl42EvvC6CsKditcSHDzUsCbK
 Y1Es1CluoqA4aPuycUj6uVyW9srbICoOltB/pG1/ph7tBdF+mi3kVhNTuG5hjdu0D5k2
 6ltCMm8yyG6WVU03HixxWTOSAmsweivJudc6ih1Ig86qh0a/hIxLsKSTh5ovNZJtBoyH
 0KaPecjF2gF0gKGCLfG4djoGFmKalETuAlOo6wYfmmJtrw7RH3Sy21LPaGj2OAD7iZxh
 pCaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTv9SKDfphJGhZFRNIrI4XNbC/3H7KinLPwg5Gzwm5IPlfuezehrRQSrcpDTz0ot/K7pf8QzleqdDq@nongnu.org
X-Gm-Message-State: AOJu0Yx2uSukp/WkOu11VDDbpro3U+twC36t2dA4FxSAs4NiBpPcN9+/
 ukUcALoAhyWT6ekjg4QG/I/lUJu995QFqKFyQH/RjKPhz9PraLsKuubgSEK+qFmq9yurafcAp18
 acXpqaD9DDHZOygCip/u9pSK6wACr8gs=
X-Gm-Gg: ASbGnctens0pavLHLcVikMXW/p072IYZwTE/XW6iv27hIn36xH49XR7/WNIi8W1Bwbh
 8zMm5tbAiWfAyeV3HXbA5XXBZaL4fhKg7ZGFUDwctT1rutMBlkc87aaMhy30qV10uiNCI/ggTMZ
 XRpfUJ7Qk96FLryYN8nlVdjb39Wy5CYM6O6onlXdFiGcK8b9LMucM9npALL1JEIroK0JYLnvY/M
 igqBiCKfcDYq+7l/ZlT6FKG7tqKqkIq3eyHO5Qh5Tdz1/lUGZhYqc5GhPn4SGWGJGmYVC4=
X-Google-Smtp-Source: AGHT+IHlm2Qk/sb5Ft1BIRpKlbb0kXUT8YIx1jt3wccnbxN5BSjUf/A5HwBZZ8EhQjzwKXzIFcMth4DmydbcC2WBs/4=
X-Received: by 2002:a05:7022:458e:b0:119:e56b:9589 with SMTP id
 a92af1059eb24-11c9d714dc3mr12431426c88.14.1764159378497; Wed, 26 Nov 2025
 04:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20251125194003.833842-1-peterx@redhat.com>
 <87qztleqot.fsf@suse.de>
In-Reply-To: <87qztleqot.fsf@suse.de>
From: =?UTF-8?B?UGF3ZcWCIFptYXJ6xYJ5?= <pzmarzly0@gmail.com>
Date: Wed, 26 Nov 2025 12:16:06 +0000
X-Gm-Features: AWmQ_bleJedMrAg7o5U7e1Fbk71u5xKas_s8ovaZUL9FiKN15Mb7OXLc0-MHvR8
Message-ID: <CAEZNvsvAPoNz5MrOiw43Fgb8mxK-9LGsbuQMVgg-DEW1eRW6BQ@mail.gmail.com>
Subject: Re: [PATCH RFC] tests/migration-test: Add mapped-ram + ignore-shared
 test
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pzmarzly0@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> Peter Xu <peterx@redhat.com> writes:
>
> > Pawel, feel free to take this with your fix when repost, or I'll manage.

Copied into V2 of my patch.

