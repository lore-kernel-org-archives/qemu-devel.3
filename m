Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB067EB1062
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyO0-0005d0-EQ; Tue, 10 Mar 2026 10:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyNy-0005cs-W6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:48:39 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyNx-000752-Cd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:48:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so4926143a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154115; cv=none;
 d=google.com; s=arc-20240605;
 b=OMx75pX6rucGZ/xCfZsrk8Vyt51Y7sv5mp5t4nTDBJE5Eqk+sAuAXslwq/DATMwpvz
 t+uRUX9+BdO3l/swBX/V4h7QBh7OcgVFTGajz2kZGecCuks+UOgjfegZl+iFv7lX//sL
 OeRMhf9Nz+CQAt8ZgQcrrHTUKz2GtP/FoWmscWdBzzP31j78yUCvNdqO4G+vf2z1I00Q
 JJjjjj+NwXGD3I8AvfFb+BhhAG60/Bh1QnzhRYx7P6/KMskeerHpxjWy2usuWA+LFaRe
 5opB02V6HK2MnWWM7g6I5D83ABB89OR88EyLvqw3kRpWKRR1lwmOM3CAXS2G+yQbgPfY
 gUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MAi4mJc3yHHvEbMGx/K9ZTKbMrdDs7vCcn8+ghC07MM=;
 fh=eb/6RYiJlpBUWog4+dSsqWDeqHDGWYSH6Yu5iX4aLSw=;
 b=IvUQ9j40tyXz9h0Ug/IlzoRhSutUbppJTqc5IoMRLQY/J3psPS/tUnOXsBq7FocxMk
 gpjPZoah67uzFYmzY90ru5WUk3kECP6aKumYGoCQixKQEOQIr+RWf3jtJEr3FQTo1QG6
 UmsaB9uaWLVo1hocUstYt8nQe5AlesOucMVWmuQaVYsooWUqkDY6jGowT+CzdvcW7Nxo
 iOvuKxV/n+b9s4NTzf3wnqfV0OKOf+RCGpOjA/lrSVRsq67cjU7cSGWIjA80xzh+6TAA
 3SMLoC/ZijKICG+pHXG2OrYRInMBUfsYMrFgSCH9p8FnI01xfrw0z7afz3TkUeK/OF4i
 fwLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154115; x=1773758915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAi4mJc3yHHvEbMGx/K9ZTKbMrdDs7vCcn8+ghC07MM=;
 b=pDfH8B/0C91wNVJKw4Yaj9MPqCfeP4kbeWsNZw0jNksYotB0rOJGt8hYLQ0eddz2wl
 V4WLch2EUhYhoK2g2UHZt0oZnhjJbzT580YAROl0lPlNY1Jy4MSE2ENaI7WUkRo82oi6
 IVSnpxY4QhTS+6hHXFVgc+mUIgKy4+t7GJGkx+y4lEbOgAfKWbtECLj+55ehPUMK3WWt
 e0cfq54X1tyfBLY3pdcomJHdu97tzpeiJoNWO7JIHADOV6OAiCrsilyRrpuJDij16fWE
 Fga14yEbkyeYXreZHsm17FV8VH9aTvXeGsg0M5X73/HCx6buogiqemFNnClgRoFaQWQg
 8uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154115; x=1773758915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAi4mJc3yHHvEbMGx/K9ZTKbMrdDs7vCcn8+ghC07MM=;
 b=VMqE+D16OLTF9/fKpqx1lPu927EyegIw4H4HpOGFTudY0FWRZKkyNBVUxv0jgtW9Nr
 pYjCgx7b6/udkolPr/esTRCiFl1M6gQlC9DA5nyDTwFcWMOOaeEkrnprb+xZqhP6jaEV
 4sWqhEmUh5jQkBW4p2psMEQ/JrzjSFT+d/CGjTBu1HTaePvB4cRrVpompXF2gQYcxkQY
 EBcVmLAMU5DAZi7rQdKPMCqNMw2no8S54C7886zKQGYatd2hyeNeSC8qETU+wHXuvYHK
 49wj9QAP3WIvAFt0Z9YUb4K1p8hrbnipGtsWoJzn4yF7VDL7TTLimVELwAC3qkZHVYLY
 ZqDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG/iH3FzYfoVY3s90rheMLHw9H30eqUI48VY1K0zLmGHOM5EmjvVXsXFjnRvm1d/O/1Xd+j0SZpwTV@nongnu.org
X-Gm-Message-State: AOJu0YySQ0RHei9cWF+PUjQD9SUkK4RP36Xu+MdTPSgGdPf2XasCMBwO
 iqikZW2P88Qj/57tccVYXk2aiFE/AwUVFUmL/PawY99G0KSIeotBsoVj9RCOfEue1Jkitc1/x2D
 zaQifEeeZ/7fcDN5BZ139jcNKe0FGOoN+iDPTDyXi2w==
X-Gm-Gg: ATEYQzzpd+COvt8zldE9rbC1sBwn5W+0Lv9g5VG16TPYl0/h4WRoGlw/AeTYe6D45R8
 2/5R2Q+zL+9HZOzGO1GgtxEjTCXjQLZRsI1Awa2AWnA5LaqTWXMIDwuzHesqhvrkAeNmExFBNo0
 odFmS8qHSMc7C75xGgrTbvDC+K1VZ1RVWerr8BYKZylRjkYTfuSyibOzYEbf8/YBFMd4D4D82Bn
 JCkjAvRsjQC+z6seMDUJBTa+HRkQt/s8Un+bpaWGwoIltBI9PvKk+NkKoQwiTyDTsqm/zPWhqui
 eF44Agowh1sPEjfRMcW0U93PGCzyQbWB/It01ZbFsM2DAifrekbjgI78lU2Mw22VXUw=
X-Received: by 2002:a17:907:26cc:b0:b93:81e7:845a with SMTP id
 a640c23a62f3a-b942df46b34mr786612366b.9.1773154114991; Tue, 10 Mar 2026
 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
 <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
 <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
 <9233d54a-1a95-0cc9-c118-9c557b8bae4b@eik.bme.hu>
 <4425f6c4-7003-4d6d-9842-3b9c320be0f6@linaro.org>
 <c551ef96-ca0e-01fb-02c0-435851d5cdc5@eik.bme.hu>
In-Reply-To: <c551ef96-ca0e-01fb-02c0-435851d5cdc5@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:48:20 +0000
X-Gm-Features: AaiRm51b79TWkdNZxGe1zHDLQZK3WDdALJGTbrsd3gpUBQEEfTLVm6ABRLIc8ZE
Message-ID: <CAFEAcA9nAup6PLQRBLb92kyAQOJhnx5ahe-u7nwaZq7kFZuSfw@mail.gmail.com>
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 10 Mar 2026 at 14:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> I did not know I can get access to Coverity. Then I can take a look there.
> I still think there's nothing to fix here because even if uint16_t
> default_sc_bottom is promoted to int for the calculation we don't support
> 32 bit hosts any more so this can't get sign extension issue even in that
> case. So I think Converity is just confused here and we should not make
> code more complex for it.

None of the types here depend on whether the host is 32 bit or 64 bit:
 * default_sc_bottom is "uint16_t", which is always 16 bits unsigned
 * (default_sc_bottom << 16) is "int", which is 32-bit and signed
   on any platform we have ever cared about
 * val is "uint64_t", which is always 64 bits unsigned

So if default_sc_bottom bit 15 is set (0x8000) then we will end up
with an "int" value 0x8000_0000 (shift by 16 into the sign bit),
which then gets sign-extended to give a uint64_t
0xffff_ffff_8000_0000 when it is assigned to val.

Coverity warns about this because "I took an unsigned type
and shifted it right and assigned it to a larger unsigned type,
and in the middle of that it got handled as signed" is one
of C's unintuitive corners.

The thing that makes this specific case not a bug is that the value
of default_sc_bottom is always masked so that bit 15 is zero
(which is not something Coverity's analysis is capable of
spotting, because it's too far removed from the site of the
sign-extension).

We are about 50:50 on whether we prefer to mark these as
false-positives or else to insert a cast or other thing
to enforce that the intermediate type in the shift is
unsigned.

-- PMM

