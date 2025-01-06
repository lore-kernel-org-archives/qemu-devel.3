Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD04E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 13:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUnDo-00033Z-2s; Mon, 06 Jan 2025 08:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUnDm-0002yz-Ne
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 08:32:42 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUnDl-0000QR-5H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 08:32:42 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3983f8ff40so16419830276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 05:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736170359; x=1736775159; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nE+pjx8kG+LDRHRQJvg2JhnCp2z5c6FEVTyJmVxJUyA=;
 b=wgUR/5sQnPYrzFtvQ2jyuCM2LCGWRyw5Y3B1+ZYkkKf8+LH5v1RRljxrBXMsSgQfJy
 2S9lw5Dspq1ADwfNBngYiveej+vBiZ58DO9G4kGVW76mWPANlUeJp82RlMxBmjrUgnid
 LoW8XGI4uV1VCrhN+dud7aLz1xWlF5AcoiPIuLZ4vOmLw1XU8YtwBgKrP2AE6ov5MMbe
 Y3HNfw84L9LBmzF+C4JRdQcz0Dbx17KSR/5/P6VpWPLoAARmPJs++xvgrqG/611g8nci
 jU5SMqhcyFB4U9dSNFDUKxvTtP9k1OLeRhimyDTbwtUV88s0hDW2JtAqhL/vinIaH4IE
 z22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736170359; x=1736775159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nE+pjx8kG+LDRHRQJvg2JhnCp2z5c6FEVTyJmVxJUyA=;
 b=HpQjEajbnjMbA1tPE2H+4q155NUvDsRyG6F26dygJ+Fp1Os6n3QP/gJb2Q+qpZyVoV
 i+v3ExiDLs+i9riKeCTyGBbu+FeP0ke18HT8s2qeMczYY0/smDcpxy0TQ4k2tTUl2G0b
 UTyyzdYqsIloTDtaKHiu6zbJCcUViLzeXp+lOpCZeNB5i5Cy39za9Na+cyclVe0TGNie
 +wzTCaXzvrMHzAcId7L+U1rh+OSukzhOKX+xTOU786HLMsYsu2XsfW2JRIowOiuLSsP1
 AV4XxeF4gXEETAJUQlBoCRA1ZI8X8fBrIuFWVEfZyMOusVeTODl9wPZU2lkwu89yFSBn
 3ptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1TGpbfOwT5ZG8r/gkhCXETxGNZgXZqHBBgvUW4Re/4W3IsAF9EP32UMudFKRM+pW5S340/8sdZej8@nongnu.org
X-Gm-Message-State: AOJu0Yz1BDMDbxMg2xKReOVbQTSFO+x6MYqwV2D6clTlDbJW9HSSXGYW
 /BN2ocOWU21G4MU9KZ9Lfn1rfNrj4+A2WCymPi+nuKTYqRcjKMkGLvUy6BgF+fcaPYvArRwOMof
 KdlinXe+p5KQwY6+wTPuXTqXiTXMvKTykVcUCEg==
X-Gm-Gg: ASbGncsgpmIbg/kY5ZSFXW0YqUpMm/OUx7PeeQSq/U+DrBGLuetwPeh6Mg9fOfZjy39
 QU6ka3hkgIo6/LS/lm1Cm1UyCu53tymmP0WtPlYM=
X-Google-Smtp-Source: AGHT+IFFv6/gf4rI1Z2RaoSo2HGm977RjEznfsbs/MjJlP9sLARu/Qfc3W6Hl27Lso6rxng5iXM+6V2d25vRWy1lW04=
X-Received: by 2002:a25:c706:0:b0:e54:9fae:d63e with SMTP id
 3f1490d57ef6-e549faed901mr4230922276.24.1736170359330; Mon, 06 Jan 2025
 05:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
In-Reply-To: <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 13:32:28 +0000
Message-ID: <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 6 Jan 2025 at 11:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il gio 2 gen 2025, 18:04 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> =
ha scritto:
>> Pre-existing, but since it appears on this patch, Rust device models
>> should not implement this legacy interface. If a non-Rust parent
>> implements it, I think we should convert the non-Rust parent before
>> adding a Rust child. No clue how to check a parent don't implement
>> this interface in Rust.
>>
>> Generally, we shouldn't access legacy API from Rust IMHO.
>
>
> I disagree that device_class_set_legacy_reset() should not be used. Three=
-phase reset is only needed for buses, and requires more code in order to i=
mplement the Resettable interface. Devices gain nothing compared to using d=
evice_class_set_legacy_reset().

Devices using device_class_set_legacy_reset() *are* using
three-phase reset, just with a different function signature:
-- all that device_class_set_legacy_reset() does is register the
provided reset function as the 'hold' phase reset via a
trivial passthrough function that adjusts for the function
signature being slightly different. (This is different from
the situation prior to commit 5fdb6cd27211eff, where we still
had more of the "legacy reset" machinery around with various
transitional handling to make it interwork with three-phase.)

I think here I agree with Philippe that we might as well
provide only the new API to Rust devices.

-- PMM

