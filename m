Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F02C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LQp-0005yO-JC; Thu, 17 Apr 2025 05:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LQn-0005xB-1X; Thu, 17 Apr 2025 05:21:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LQk-0004Aq-UP; Thu, 17 Apr 2025 05:21:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso8993125ad.1; 
 Thu, 17 Apr 2025 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744881668; x=1745486468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OG5KtvSbp7DuW3mb0sIa++3mxR7J3c6MDCmq573m0z8=;
 b=S9Zs0MW9ba50Gv3krrzOnFLh1mRZLcaBuW5AkZLfDEcByxLt530M9LESElhUOiZGmD
 f6pZdyNQP/Tycb5EgycSD9QXXPiZS5oISLcrjDRBTgZgtLYOSJfv+qBr9tKjNkCHeRoG
 42L9j2bFc817Ra84eaSPRgk1Rz0F3kQbDX99vNctsYs0yPz+Bd9u9ARyviDnGu0OqUey
 K9Ws2WTqU7QuJ3sr8aRNmaaQsVMj2hpbwv9y+MxDUpbUN7gTH0mApwC/Wpx/QKwEkFaS
 wTrsbPBG//BvMmF0OSAgMAQR1Edm7fPlTROejoiuxCo+a2L4GQ2Xv3JEQtyDwIsLr1L3
 FCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881668; x=1745486468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OG5KtvSbp7DuW3mb0sIa++3mxR7J3c6MDCmq573m0z8=;
 b=gLVru6zMJGPy1zmIkAZa3SxwO4GMoRclvcOH+YNZwZQdA4zXe3bC0uBWFM2MF2TIkh
 7+bWg9/xNikftWhnkm/uzyu2Lt13xdx0liQbOr/jLZZ8/28v+gv2u429GmTzI2mR9LPF
 wxZPiY9PwIAbSkPgKlQSN7ssvbjv/I3cWF/gJoWb12dUQlpUdhJB5Yibb9zxRDENJy0+
 AgElBDrRp40HoNq6+i8SUdbwsIAMNM8wFS/98f+h84ZY+ZC9R6YCRaTN9aAP4VL+MEOX
 gNo36LlGZ04S7fhsqg/c8IR1VA90NwQgRVHe8X6AIQdcpRMej891eHpwwfUXyZXzyZ4x
 T88w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU88f1xrh7v7VFUJW3qMjyhMeTk6x0N/sUf+PbAXx3VdJCDPKk3GgoX8/yoVmUPiK5EStEVVdZj7gYUfQ==@nongnu.org,
 AJvYcCW+riQbBMhTfW91osYA0HBvrs8JlpLW5QIG+s3vW1bKTXTIqk9CACt54Euj7WDrA/0T1XnlV8k4S+vcjA==@nongnu.org,
 AJvYcCWYNYpEgJZeAajm/2jckTCvZa0p4/G/sYidLv9VuFj1WpOxAwqqA+x6Ixj/UfkzB66Dl/rGljpYfHMUrg==@nongnu.org,
 AJvYcCXXVhYZTCdYLUZen6KNqnMtEww+cI2QQHTRl+B84+fowZVTTzy8dt6I8TxiZnSCtZg0PCmK+UbwRDk=@nongnu.org,
 AJvYcCXYejNOhp6mwOjFnwwOMOY9AeS13ttdVSYr6vDTYc8vl3jk5Nqhz3oXCvIU+aKg2oCFQDKiu3xCsw==@nongnu.org
X-Gm-Message-State: AOJu0YyQE8j1riyi9zYPampwSZ2UGPZdpLGUi21vGSJUGMkEWs6STR89
 SNQTl4/mRbYv+O6cESL1Gylqq4x8dgIQKGZeT1AKwUPWB34IoFM54YjDjdx9xgN06mZ+L3HpUe9
 rlNucfkZFplRNyzeRvUvPavX74AE=
X-Gm-Gg: ASbGnctAFFn1v+9r2qMAmM7esZHe7Z73u1nmGDM7cWtNWmNmFMYjr6vLt3L1OzzZW7n
 yOwwSTMN9EEoouCJljWqWPChxmcrN/HcYpdv8c4rUWjNWT8fygyfcwHHrki+a0flWofkzhqnmXA
 XyvFzqwV9w9fH35eheT2pYdJW+jkuRGz1A6WNXCW2yAwUDOi/6nd2C
X-Google-Smtp-Source: AGHT+IFtpuAcuk2tOeXMOs0Bgazy/F4BdxyEAnP7gxX2qYDbDgpkI0WSTiErJIKXrWLlH7zkiuSEdQglorWfNjkU7l8=
X-Received: by 2002:a17:902:ec8b:b0:21f:35fd:1b7b with SMTP id
 d9443c01a7336-22c35985749mr63251815ad.50.1744881667907; Thu, 17 Apr 2025
 02:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <f6e0e42ae3491564478929e412991c2a16ee3539.1744787186.git.ktokunaga.mail@gmail.com>
 <263e4803-65d0-5a41-4031-99766b067915@eik.bme.hu>
In-Reply-To: <263e4803-65d0-5a41-4031-99766b067915@eik.bme.hu>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:20:55 +0900
X-Gm-Features: ATxdqUFAWifqrroQkKwXjdJ39LiEwm386rnDj1tdoJGH6O7N8ll_3L_Kh732Fy8
Message-ID: <CAEDrbUbUzgb7Bp=3iU88_0BB0bdPKMHEFM6KNy602Ux9vqrc=A@mail.gmail.com>
Subject: Re: [PATCH 10/19] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
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
Content-Type: multipart/alternative; boundary="000000000000fdb3490632f5eb74"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

--000000000000fdb3490632f5eb74
Content-Type: text/plain; charset="UTF-8"

Hi Balaton,

> Typo: instead

Thank you for the feedback. I'll fix this in the next version of the series.

--000000000000fdb3490632f5eb74
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Hi Balaton,<br><br>&gt; Typo: instead<br><br>Thank you for the feedback. I&#39;ll fix this in the next version of the series.</div></div>

--000000000000fdb3490632f5eb74--

