Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E5AC369D3
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 06:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ZBp-0007HV-Kq; Sat, 26 Apr 2025 02:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u8ZBn-0007Ft-8a; Sat, 26 Apr 2025 02:39:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u8ZBl-0008Dh-Jk; Sat, 26 Apr 2025 02:39:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so2623848b3a.0; 
 Fri, 25 Apr 2025 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745649538; x=1746254338; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/T1LZKwySduyRo2h0IOtfFdSgYkIBmpQV9h3xYV3Y5s=;
 b=Uy+DFBUC4ZFiBKmjMxba0PB/7EgLeKm/O1lCXGD2RHNx8RSqhGkLeF0tmZv1uQTGxG
 6UKIaVjMuEPVZaDrFWWG/DnVzPHxTAqpWzYtM9HqetMtWBwM3tngB5zPCsEARp/kDDxr
 eVfmRuo4rdFE75f3scB2DXhxRICUrmbWtfJLdUr5BFuyZEc0HohjBFPh53F159PmAQ1x
 Hdx6sm2ea82v2TlmsGXcXMuKeJoIIFCvLFsRaDpFr4ekdTQYoy45deiP4x/J+AeYAoil
 K6DM7kk4eB216pMzMpicdi8WVeoSpa3yeyVzUFqC25CibaBO/t6c/GLhP7f/hJtAylB7
 O+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745649538; x=1746254338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/T1LZKwySduyRo2h0IOtfFdSgYkIBmpQV9h3xYV3Y5s=;
 b=fK3EM9UyeBmIgar54nZjUTPRAOJ5rp0xxTr768YX4dgH0hdiXC0Rs8/W8vC4xqJL2G
 6B+brgDnzilTu9rJlqzUDVqPvodfzKBoZdmqHmpIgkr195bbBlUd5kuGnk78oRYvoIS0
 Sy8JGOtau021lNTO+WBH+i9hGOTtfZN9fYTg7XVhkF6rALaFkP/jp1gD/Okb9FZYCwuH
 MC5yaTxXMrs/O9D0+L+hw/qZ5P5JjvKqlrZC6LCZDmIcRA4jFVeysf9/swY6nCRaz0qf
 X9BddjeCy7rfZBtfM9gTqLwcCGkv06zu17oYhe5REjrtMgKKwhhG+Lc9p+ztvUYU/kIc
 B/7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1lPlo8u58ubQ/nLj8qI8DXmBfUc6lONFSxbHsiuJixSctZ5i9F6tojpB5Yz/tiY5ckPRC5Le0J42ZuA==@nongnu.org,
 AJvYcCUzydWbhmJmu57iLAMY1x9bX1J8byeDJw2QI5ai+u1OpAfUXE8vrmJiTkNNzhWYo3dXH/NxWdeD3Q==@nongnu.org,
 AJvYcCVHWMv4wn+3EJMcYS1B0E3U5gAwmCg9fQy//Rbq9wUxzV/USXtfBNpJWfjqiMJh0ZQDNhrAH9Yb0Bp3uQ==@nongnu.org,
 AJvYcCW+4aY2ALYwO7e7GJ8ng8T5x2YrTueh4u3hu3oXzPAgh+qIyumAipMM0z5biryveTJJsRnmIxutj4g=@nongnu.org,
 AJvYcCXLmWAot+jtuAlL7fmnpkezN5Ru+mQUDSlq3mtUCjPJxL5qrLu4gt4lJkPxIYTdeEAKjBq4E12igiEGhg==@nongnu.org
X-Gm-Message-State: AOJu0YywFLsKtZ3CL4nuGFDtXaM8HFqZylYq02p5A/IzY+iwNBHGDs/1
 +79EneH6jWAjmZX7pu+YVAuxq3g0f+AZVTLseKs6/bTmpwijuujUcmaYFgGWxj1asH7dBJYNyN/
 yzXhiKiC/fLreQ9BXeh5YLicAkj4=
X-Gm-Gg: ASbGnct47M86xsUiLO8kldLWeOnISMUzhis8B7H2ILRVNPjGb043yclon3P+6v/KZMg
 RGoVIMaNuE4OxCCQ9zl4oYwLZjX+EwQe1nky0QFQNttHoyf1yiA+v6xUZsmLhv7iIYV8qqrgklc
 9cbj/RNyP7uPaxluEi+ANcNnEb2/IWe8FBm/UrByAbTVwgzfVy/tbR
X-Google-Smtp-Source: AGHT+IHPfSQkkpkcBFSfcIVQOJdr8vuupIRlsf58kYnTZTu9jfM8osjgQAZcyGwfjotTwU7n4se3juPAMjXfY/btnLg=
X-Received: by 2002:a17:90b:3504:b0:2ee:f22a:61dd with SMTP id
 98e67ed59e1d1-30a013bac35mr2692858a91.32.1745649538523; Fri, 25 Apr 2025
 23:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <01b21c849b459660453eb905d12ff0da4c65f53c.1745295397.git.ktokunaga.mail@gmail.com>
 <5b7afc3e-d5d3-4485-96ab-a1b212644607@linaro.org>
In-Reply-To: <5b7afc3e-d5d3-4485-96ab-a1b212644607@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sat, 26 Apr 2025 15:38:47 +0900
X-Gm-Features: ATxdqUEudJEQciex8VkQsUG2VLwhDymMM4jg3D4EAR_WFlPPRlIFWXCgzUkbd-w
Message-ID: <CAEDrbUZrPSBezgUpVfJC8-R0ED9yLMB5YYu5e_zd9jdnd+5CKQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] target/arm/helper.c: Fix type conflict of GLib
 function pointers
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
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a567c50633a8b425"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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

--000000000000a567c50633a8b425
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> Why not use a gpointer for @d like in other patches?

Thank you for the feedback. I'll fix this to use a gpointer in the next
version of the series.

--000000000000a567c50633a8b425
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Hi Philippe,<br><br>&gt; Why not use a gpointer for @d like in other patches?<br><br>Thank you for the feedback. I&#39;ll fix this to use a gpointer in the next<br>version of the series.<br><br><br></div></div>

--000000000000a567c50633a8b425--

