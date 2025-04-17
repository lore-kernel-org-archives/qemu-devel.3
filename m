Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885BCC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LiT-0005DD-Jk; Thu, 17 Apr 2025 05:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LiS-0005CX-5O; Thu, 17 Apr 2025 05:39:28 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LiQ-00079u-9t; Thu, 17 Apr 2025 05:39:27 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3035858c687so379485a91.2; 
 Thu, 17 Apr 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882763; x=1745487563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4IUwotaB6QpXvayv7s4yBerKtK+FrKs7EK6XfCGHghE=;
 b=krjVbh2ICYkE6O2fgV9styXXXaNGpmWNd1SnAqPSnUzwQeQc3c3ZT7ofIjilo/0ig6
 ysDwiQf+79nUFPcWlhMzJ3la2forHUYtVg4C2BauMbmbbks0mGsQsDlePJMh+DYxZ52T
 1tqZUKEyMCQGbkck1Qw1RFQ0tq0wad+tudC0Wf3zbaXm1RUJ+s5FgDvPIYA5e9RvIdNz
 7pqnXDkUXdvpSTvC/xetZCcQkF67gFwxE9y7I4SN7rTMWIJR1BkwzQDaVG4sqI2jGVuL
 c3iaigjO84neI0caQwJWHNXw6P9Q7vxJzDxBecPkY30cbu0T7eG3iq8fUUPsG6/zLIrx
 1swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882763; x=1745487563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4IUwotaB6QpXvayv7s4yBerKtK+FrKs7EK6XfCGHghE=;
 b=J1H+dHVDj9qG65ZxHVRzJVHGyEBKJuieSEO9pemqvVqUmAoz9U7FkWj2wgvAgSBSuT
 3boLiINupVDDzLgXWQASWBeF9411VU1fUO6ACg3tHf1llwwK8aY2oOnmpEz4jfLBnTcV
 +fU9lqlPo7CKNMxxoNr1XHTD1pMvuko0D1ahG0EqJ09EGpM4SBULxybOpG6BtFkOQQf4
 J4NO+9NC/g8fQ2/1mq/IoTkAAalbiTBX9Rz6WmjsB78HWttvwMtdKic9coZD1/M+hOTr
 +IWzXuraZIJVOY9I6zUVBYhWIK6ZMxQH5ba8KYcNo9PQ6XJWBSES+sRY6QYaTLlgWCSL
 GkhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE/1+BqRJQy2ijJkwCl3qvUsxp1t6SwZXzC4HpUFxH4HRJNFJubcTzUHZolJ1TThRWpqiJWIFPDB3IHw==@nongnu.org,
 AJvYcCVOx4GT2QA6c5Phq7A6d86wOZdB9TMoIZl2EPeX4FINIyfqRg25ZNLBpmaKgVygaSwQR61cWer/Hv20UA==@nongnu.org,
 AJvYcCWUk7I0FfjRHzs2gCtKtUO3uBaiyPxQ3Ysr24BHEP4AtENJYc/yUlbLq4Pvi7qK6Fb95eirQKfhOg==@nongnu.org,
 AJvYcCXBAxldp8r06gti8ue4Vj+FmqOMEhigHxO8Slo14rzDDIIfyiJD5c4VOvoHPInp8wp7w2+fQcRYY+x+5A==@nongnu.org,
 AJvYcCXD/mIIAVgTM6vIGpOiQMA18VqnG+htNneeHIVeBdCZ/ur69Bz+4VEOLQmNJLe4IzHK6EBqMtiS5OQ=@nongnu.org
X-Gm-Message-State: AOJu0Ywqu9/n28h/1gPdhOEhAg05j+VMIwmBscBSQgBTLHd+//90VYrk
 18mYSB1ryK64JE+C90C3A4NqtKN1GlzzSOG9pcFvJ7C87YLi36lGjgJVXLVo4hJZljdVJZ7CPc4
 LGn9cW5UNcy28k9OfpUDue/gBvF4=
X-Gm-Gg: ASbGnctUEZH9xtqkBNDu1iwsPOyJc7REsThilPldrfXB8eUVHIV7N9yP88LfVjUSUEZ
 UjkV4Ug+BfLh8vCHAiYtGch5lE+xj5NwSwiwnpIV9XnYVPkWhXaIcBaYy6FS4bHfNFLyb3OwnPl
 y6htu2Kkh1PwJCWjyuV92WpMhpJBAnMWbcJ1MuoP25DkyrI/jUkygE
X-Google-Smtp-Source: AGHT+IFGO09VYMrl10ZjGYqmmRzbxNWDwxetel7yMJnEh4wV5kv3PfNYs8qKTOf1V1Q+IQsx1zdNjYz79TSWIB1rIfI=
X-Received: by 2002:a17:90b:57e6:b0:308:5273:4dee with SMTP id
 98e67ed59e1d1-30863f2c4fcmr8208361a91.15.1744882762526; Thu, 17 Apr 2025
 02:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <16055d17cadcb5f4c23203218cb8fc3fa81d1754.1744787186.git.ktokunaga.mail@gmail.com>
 <91dc0def-2e17-40c0-a66a-c5992f10eb3e@linaro.org>
In-Reply-To: <91dc0def-2e17-40c0-a66a-c5992f10eb3e@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:39:10 +0900
X-Gm-Features: ATxdqUFMJQjUjwv7_rm5KRUGYLctreEWeKcrZ-VtCgLHnxVjiLH26TVqskdecX0
Message-ID: <CAEDrbUZHJ0_hfmXB6Zfn2UKCu53eeqNGwzdtr7Lsuee2rGdKKQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] gitlab: Enable CI for wasm build
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003c35f70632f62d58"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003c35f70632f62d58
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> Probably nitpicking, I'd add the Dockerfile first, then the GitLab job
> in another patch.

Thank you for the suggestion. I'll split the patch in the next version.

--0000000000003c35f70632f62d58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>&gt; Probably nitpick=
ing, I&#39;d add the Dockerfile first, then the GitLab job<br>&gt; in anoth=
er patch.<br><br>Thank you for the suggestion. I&#39;ll split the patch in =
the next version.<br><br></div></div>

--0000000000003c35f70632f62d58--

