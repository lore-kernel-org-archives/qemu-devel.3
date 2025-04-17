Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B4C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Lh2-0004Jy-Gs; Thu, 17 Apr 2025 05:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lh1-0004Ix-1A; Thu, 17 Apr 2025 05:37:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lgz-0006wU-C9; Thu, 17 Apr 2025 05:37:58 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so363734a91.3; 
 Thu, 17 Apr 2025 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882674; x=1745487474; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VIHHhOHU9thrZULwqN7ovEV2VNYQ+ztuVgkUr/Z3nlI=;
 b=mM4z0Ihzuhzj/8Na+VaiRkCtZBT2sL1Ln3X/lTwp4KjayjWmphW3BqEtJCYGYyjePG
 zy48HYrnnlOc5v9sjIGnES2a4EOHv6rFhNU+FPnO5TQh01XWPiBRYQBiOA+gLaDkPk5f
 JkJPD+c7LQMwv3np9CblxUT4vqhDpWaxpoXPtb5alzoC3wlumKQ9F1FB85SgvfviDsKj
 rq5F/aGbw7my+RaeDg6Y5xBjM6se9jEf/G0zTPHRYvlfj861nKDhaSZstkX5unI3VmiR
 BzTXgJkjHQ+UUm6u7lZ2Jw3G8ODlRsa4xogldmipfX8EM2go3G2MqA5SWkevqNX9eyxK
 J5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882674; x=1745487474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VIHHhOHU9thrZULwqN7ovEV2VNYQ+ztuVgkUr/Z3nlI=;
 b=DMqB0Rv5WFQDGgOruR84qHdTWhI13NILrctA/aLrDavpPjGD3ybRoQWZWyih+ByYz1
 v6CmWryRjUpbTeJns81Vy/ThtDvlfcuFW+yAmi0/da1iggZiS9/RyJxcYbJNH/Bii4JG
 glSOAd+qIO15Loo3KWNuzdQfUNKH/L1ZrJvAjq+V7NkNm8sUdXkgPIUKJ1OrqWHUbx18
 DVOpujhhefc42FLea83E/cXAeFyhfTZNSru1OiJQcQgbOjzbtvXz1KtRBIePFF7zfAIK
 6b85wQoOitK8R4C13cnoxzzqwWQhZ0cuZHjfyZFFovd7gDFGRoABYVttiZDCVSi1MLHc
 09WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMjlF8kJQRPOQOGWsPq0Y5fDc33OSlPqGG1xulDB8FonxuXEUQJokHuBXhl5+4NYS5PFvGJ+k6XIw=@nongnu.org,
 AJvYcCUyN4Rat8COnRi/ERUCUptShpl5XPsJGOjeg2ekfsF432gHro25B0THbn2HaNz8QrM5Cbs/WO0IFuEnpw==@nongnu.org,
 AJvYcCUzZw+2I3AtjZNCOE55ZJcX9CUZ8wXN6BtvLmCDhvHpG0881wvyNSevl4tjel9+rYDQsc6xbhX6cN6Bpg==@nongnu.org,
 AJvYcCVHhW0PQZs7aR6A9IM4u+so7su0ss1Gd6y+6T97p3DC0p1gkJI15QPm9rn0pOhcD/pjG1J4QMsVDSo1Vg==@nongnu.org,
 AJvYcCXWAv5jbdgG6KucTLyDicwEfJidDQBu2mmSdfrCuNTAx6gm3bmqqZSbqp0wQwZ+ZhVtG/4cg7ObjA==@nongnu.org
X-Gm-Message-State: AOJu0YxF4SD+onM0Wsg9ORryNYExjq5KCtDBHMgO1YPKSIliQ/Qppyzg
 9Tbg7z9yXjPuOaJJB4tIyDjweAPys+6w5gZC7HcAl2alh5sLUwShdmmEuy0vbJMsdbaN+7qy3H3
 NOBz/5p+jHkhrC9JqIhcLJjR2UHE=
X-Gm-Gg: ASbGncvfBVaQ9kiQ4RIIDzlCkDBQIv16OzW012x2fJqCgMl45UeejNw+uQA1/a/W3Wt
 07qL+otTqtW+8sLBTGdFTLhWmxpDla7ll8S4NQbC1rooRmMM95zZJUyUW0HpAFCKJwy01HwoKW/
 oxBfGxkew3KEbC2T04vDAUZT3X8sJfKK/DGtJoF8HbSrwXo94XTuNB
X-Google-Smtp-Source: AGHT+IGEw9Ig9rsAuDcS+U8mEvnZBN113C69jDEuhXVah5myDghRCQFAujKFPMx05ApxSnY+XT049yJaBKqjFnQ6qK0=
X-Received: by 2002:a17:90b:2810:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-30863f2f79fmr8276090a91.17.1744882674626; Thu, 17 Apr 2025
 02:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <835dfef61307a941cdb58331607c308238d37e00.1744787186.git.ktokunaga.mail@gmail.com>
 <c00e2bc8-3248-44a7-bf4a-87441f6f9c19@linaro.org>
In-Reply-To: <c00e2bc8-3248-44a7-bf4a-87441f6f9c19@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:37:43 +0900
X-Gm-Features: ATxdqUGrkd5pDO3oglO636PGnfGtSmhldiHWBdiYlXRlIjzH63vRphXYkdkBSJU
Message-ID: <CAEDrbUZxBDUsK4WzbjkxZfyRzM-ALup9YfLVBeh1rD8XuhGDMQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] meson: Add wasm build in build scripts
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
Content-Type: multipart/alternative; boundary="000000000000fef8cf0632f6271b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1030.google.com
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

--000000000000fef8cf0632f6271b
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> Does wasm depend on TCI at this point (no TCG backend)? If so, should
> we check TCI is enabled? (I wonder if configuring with the
> --disable-tcg-interpreter option succeed).

Yes, it depends on TCI at this point. Configuring with the
--disable-tcg-interpreter succeeds but leads to a build error. I'll update
the patch to include a check to ensure TCI is enabled.

--000000000000fef8cf0632f6271b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><div dir=3D"ltr"><br></=
div>&gt; Does wasm depend on TCI at this point (no TCG backend)? If so, sho=
uld<br>&gt; we check TCI is enabled? (I wonder if configuring with the<br>&=
gt; --disable-tcg-interpreter option succeed).<br><br>Yes, it depends on TC=
I at this point. Configuring with the<br>--disable-tcg-interpreter succeeds=
 but leads to a build error. I&#39;ll update<br>the patch to include a chec=
k to ensure TCI is enabled.<br><br><br><br></div>

--000000000000fef8cf0632f6271b--

