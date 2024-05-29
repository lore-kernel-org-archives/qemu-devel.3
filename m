Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E2C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJbz-0002Sh-8g; Wed, 29 May 2024 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJbx-0002SP-UD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:45:01 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJbw-0001as-4n
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:45:01 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b59f77670so602808e87.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716990298; x=1717595098; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UwG7MrTHvayFaCQINPSmuZ6VRrD0k7+4qg80bKYhAjo=;
 b=uHVAVsFWRkcuWtHYmt0GH0QMfA0w467UA7AS+J2E+9t/pzFOG74wrzmN93QnmGtmdt
 4DTFZkGqJL/w/4shg2xFxyGGRibdSQYHtxnPYW/1gHH6oVTVpqYlhbMyx6DHxLt4jcoJ
 eLAZ3yggq2cB418HOvpwepQTGJqXoFR1/znPGmEwDUzCZBD07akZvZto/UykfPzP3Fae
 ujp97lFqVoFDsKXwEUwr/giN/MDer3Oy7Vdr6BgBS5KtninNDIRgXT72J8Ej1YSmL7pD
 x4gDlXk58E6dZWmAMZsQGYgi5xxoxISMwOfVs1z/Dc341FInFEQZZw1ad4ROdqXfqgC9
 4tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990298; x=1717595098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwG7MrTHvayFaCQINPSmuZ6VRrD0k7+4qg80bKYhAjo=;
 b=vZ7qJ3jcSabLrHp5kUq5Q4oniA25g5GnN/qCUIk7LPqYRE6YLEFoeZigzCLpT7jMfw
 OdRs9FcTLHEAXumOSwg6aPVZgmsYYUh3AIBzQQ3nGASFVaco8pcKuC0g51Uc7xd8r9V7
 XksLKaffg77MD66YKEV2dROCFZHja2OE8jgGhD93a6Mxr0B+XTmDnn5BIJJ4qQ3PHJ3X
 oxwj+03i8NiafUqgCXGlnP1cr9+seRuAHzePZESoVyIifMla+BT2b/jBWhb15XbMut42
 Jt4N33yP8P0Rf1V3HIEX6lAejXiyMTuwndGrG3tBqBOIoYFRJlvwQDOwwgeFaN0eRO+R
 Bp7w==
X-Gm-Message-State: AOJu0YwPhzpIMgLQuIAvHhhxQX/Ht3q5dJC6iGmMORrYPVgKa6+QJFiN
 8vP5nPfiVrNvb7SpVkj2XaHk+ewb1+hqT1JnXR332N+pRmmSGtjfyz0TVU9Y2raZf2CVobf4ECb
 h7Uuv/FiecS17aTzP5nZoPvucMcZ76LJRCJ79kGOGTDMsAlGc
X-Google-Smtp-Source: AGHT+IFyreLDEOwyhNFu2VUJPb06+Bk+fEPWbqYbVPdIwzKY2JMeLM6RgwRWYd++snZbKe8g/IllTNuscHa67ZoH2vU=
X-Received: by 2002:a05:6512:304d:b0:529:adb9:b8fc with SMTP id
 2adb3069b0e04-529adb9ba3emr11471930e87.41.1716990298036; Wed, 29 May 2024
 06:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240529045909.1796787-1-tong.ho@amd.com>
In-Reply-To: <20240529045909.1796787-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 May 2024 14:44:44 +0100
Message-ID: <CAFEAcA9YB+=V5Vv=UKK_DRbLMc0kv1T9xqiu5J2Z2yVLk459Rg@mail.gmail.com>
Subject: Re: [PATCH] qemu/bitops.h: Locate changed bits
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Wed, 29 May 2024 at 06:05, Tong Ho <tong.ho@amd.com> wrote:
>
> Add inlined functions to obtain a mask of changed bits.  3 flavors
> are added: toggled, changed to 1, changed to 0.
>
> These newly added utilities aid common device behaviors where
> actions are taken only when a register's bit(s) are changed.

Generally we would expect this kind of "add new utility functions"
patch to appear in a series together with some patches which
actually use the new functions. Otherwise this is all dead code.

More generally:
 * the other bit operations in this file work on bit arrays
   which are arbitrary-length arrays of unsigned long, so
   these new functions don't fit the pattern
 * we have the bitops functions partly because they're inherited
   from the Linux kernel. The use of unsigned long works quite
   badly in QEMU, because for us 'long' is a type that is almost
   always wrong. QEMU devices usually want a type of a known
   length, which is either 'uint32_t' or 'uint64_t'. So I'm
   dubious about adding more functions that work on unsigned long.

thanks
-- PMM

