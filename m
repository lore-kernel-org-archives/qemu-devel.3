Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F688C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwMU-0008TL-Du; Mon, 22 Jul 2024 12:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwMS-0008Sj-Nb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:58:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwMQ-0000bt-I8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:58:08 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso3338106a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721667483; x=1722272283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8JBNfyDx6RiYz8GFyg5nZBmzmrFRobqHW3GhxMarJY=;
 b=O8pQKq5ImHlyz/GeABWzF8FoJU1P7WisvLr7KlCjfF8Ke4wGqzV/pT6Nk85hgWNObC
 IyhRAik5X/vCBxTsZJ5FRVhAYxsHbQo3agWY1NbIlQger26msGIbJUKq2/TmEXFQRfaV
 cZ8tBOmenX6eZVOn+mgss3MIZiV39tLGy7xcC6YDSBZ79rQ4SJy03i8x0fi5caBwbon+
 0nhCMGFvVyNcPPQWn14+KKFuzPJjs2ffEyQ/34hpmmTszSwLcWkN5gdO6UBZcJGRDgaO
 v4BTmmAloTr1cLkjLFdli5zfkzRl+FRKdaGE3PAA+v09AXSiUiw+IWJUw2j6ymlv93A/
 yjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721667483; x=1722272283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8JBNfyDx6RiYz8GFyg5nZBmzmrFRobqHW3GhxMarJY=;
 b=jnrhx7WuF3V/oiqiRbGu0bVFww3UTSjMcfuCCPoK7YX6xXDzLouY5GTkMRJnWMsWpS
 +TIag+mXfiINHVk4r0k2hN+bn86hp8LM6jCpS9vTKe/ayM9pmLAUaiEVzEk7bPagyqXf
 t/KZJDdduVB8fL5VjccrzB13X4DR9wm93+7wbY1lOlqt+haAd9jBRseeURhMcz5N7Hgi
 llFCo0voVSwIuFVbxcdY053MkArkz3LDzVNtn18DcdK7FB8ijhq8HZIDymN1wT+sGlWp
 ETb29Frko/7UbZZgHOn4xWXqRctj/5AYER9iCqqfI/9c9APPszrUHQDgNuoQBhAGi5Kq
 Z4jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3noGM2hi4WPotEEIdMJZl6m9G9hYUwLguuHEXRtiTbB2U38TvdsoBX2kOyp57OU2lCnJ8lny2c8Gyc7gSWEeNuW8MFx4=
X-Gm-Message-State: AOJu0YzMpXvkj+jHOGqiKpvB5GSH3Hi1RucYRMGc6lvfX6OwisqU0gCV
 9/DssJ/fiQDeT+eQCeBf+Tl1TMRGLbGsG4QFUc7RL8MzLRVCUcn4JPdKNIQjnixU3HXTTtvlQxu
 JlwtBrH9GUpiatKz09AUoolLGfpvPXAgjYTpxzDat79nLO5kf
X-Google-Smtp-Source: AGHT+IH9HKzL5FY19StczYLrMOMU1MiApVgqcLoRTHAbQ/6PFmazz8Lm7m+sm+jn+gdWzXDH2gaN7KiseCxeOf/Eg3E=
X-Received: by 2002:a50:d615:0:b0:5a2:2fa5:f146 with SMTP id
 4fb4d7f45d1cf-5a94363b6e0mr334694a12.28.1721667482895; Mon, 22 Jul 2024
 09:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
 <CABgObfbdXXXbygNn3DbN9Q7xB=kTFTFs5yxFQapSn6SAXdpQZw@mail.gmail.com>
 <21bed558-49d2-408d-baaf-97451780c53a@linaro.org>
 <CABgObfbeJEv49mfOte-4ysSDmWkBV5tUSJOh+Ye1hu19bFUZmQ@mail.gmail.com>
In-Reply-To: <CABgObfbeJEv49mfOte-4ysSDmWkBV5tUSJOh+Ye1hu19bFUZmQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 17:57:50 +0100
Message-ID: <CAFEAcA9kEwjX5vDcf6wk-T_v5eYZfPJtnYrCobc5Z=33xJDisQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] system/memory: Fix max access size
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 TaiseiIto <taisei1212@outlook.jp>, qemu-devel@nongnu.org, peterx@redhat.com, 
 david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 22 Jul 2024 at 17:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 4:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> > It seems this model could be simplified using .min_access_size =3D 8,
> > letting the core memory layer handle the % 4 byte accesses (the
> > read path is obvious, the write one a bit less). Nothing urgent,
> > possibly a BitSizedTask.
>
> The memory access core is not able to do a read-modify-write
> operation. You can get a smaller read from a bigger one or split a
> large read/write into many small ones, but it cannot convert a small
> write into a large one. Even splitting a large read/write into many
> small ones is only possible if they don't have side effects.

IIRC it will convert a small write into a large one, but
it does so by zero-extending the value and doing a single
large write. (This is the behaviour you want for some
devices.)

thanks
-- PMM

