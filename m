Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBAACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtdA-0004yX-60; Tue, 26 May 2026 11:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtd5-0004y8-Bj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:23:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtd4-0001pb-08
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:23:39 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651d6347a69so10763434d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779809017; cv=none;
 d=google.com; s=arc-20240605;
 b=d61l7JDwM2A/0PmZ+uwIOKz9nDZwikdLqTJHqvwEmGP1qIuBSNUMb09eP+ZPS1w+OQ
 NzlY3qa+SV7utL//IyS9JJt3AkNbNUtre5w2VKUwOhjN2YBXg7vlJTuMVxL9fy0UkyJU
 CC+lpa+ERzKNvyYzWXY7uIoBBPNwaZcvSHvHcAnTVbgnpKO6TmrlwxfVTEn89dYgd9ca
 UwxCYIohdA/Kkyz/v9XTHoBhsbGYICFDh23B7+600xGvIqEMeslo6ISDJ5kt53Fph/3Y
 ID1I43bLHTW3JDSnJUzwl6Ucxb06s/6dbluXVfoF+qU7KRHlW+fmA8oxA+5clLq6KYtC
 P5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mnYVDNx+sPpdyV4xqd/LyeeAqqAWg1y9p/vJXDQpRbE=;
 fh=hhwVdxs6YRPS0UYFsYaAouFZtY+KN6AoBmTWK44Dxy8=;
 b=YQ4gUzu7m7nTSEd8KpwMjrYCg4Q6HEl44GxZ/jdJq7irvKVVl3OJmW3mTuJIZvC+Ql
 sTUfWUWmLY6sUiP4L3NeDLWKFLH6yB6Qq33s8iMMofGMTchqO/bHDwxllZahVuSDOvw7
 OUfRw/OHmU9QKQeJeMO/lvbl0Ca6SGupGJNiO0sPY6IBMmv6ASiCqxIA0dPXqsEi1AnG
 sLWOGYPcRQd+D7LJq1dwYnLh1ISGwlwb9Qx0hzKq+Mnm5n7380fqBBixwvX6u7UPpCNP
 HWV9z2g4D/hfv1FKXzHpDYLbbmSWpO3xb0FRqdKvUyzQq6kskIheker1+9uiDKlG7Qkc
 JTUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779809017; x=1780413817; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mnYVDNx+sPpdyV4xqd/LyeeAqqAWg1y9p/vJXDQpRbE=;
 b=M9Fj2q78s/XO2FA+Y0tStUntKiYY/EMqydB2Ujl4OilNKxepnDYDLEIi/goU4TK1gK
 5R5fMiy6MG0hD0iFdBrINVNpT2J28cPEf1kqD/4sEP0iUitYbb6CfPCL00yjcVryeZ8X
 /ncuUOcIYv8ea6ni1N7xXmKrquSzG59P1acigfs2iQzZqi3+WeyZib4WKoFsZmxEn60Q
 UNpWFhSVyxV0sIEIkudRd5ORU7UOZajPleWdTpkK5lzw7vZtGGu2SNc06ho5tcBr0PD4
 baZmoRt3KHqEx0nFcH1CE/6Ll5Ittcb6G7BwebtUlkxvSEJsRbUAc4V20gTJpVc285b5
 lwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809017; x=1780413817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnYVDNx+sPpdyV4xqd/LyeeAqqAWg1y9p/vJXDQpRbE=;
 b=Xme++4WnO9/H0tuEwgjIQGXzOYw0jekVrPqvx3Ej4DcdSQZ9QYDfDAj8lZhh3siF3z
 5hB7UGuA5oR4HRnA4LXHoRw8vGxSfhzZR/+5EkwzIKqfM/AxL0H4oOi+vgaUfmhWr8Od
 RsdPhg3TqtmgYnLLUADYrvM1MTRcZ/SToqd8QRCySYXb2TFFCPT7uLWQM2zTRV2UBkQ7
 7PtvVsy4XU0QiZn0UPYzoTACVkNXy6zAPpa3oi0B9BUwc1Pi/PpSFp4cOr0pSygxgZKH
 rT/iYcoI/TsWBzzOtbnque4SMwejrIyAnSh8X7d7oRNy5zqZ/M/8I0a1S5OxHAo5iGvo
 hEyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WZRy9OZLYdNw2lCWnwdAcj8zddrseYnhOGwVsE1FLGFBy6nyH//GRJv8vZvTdmgGx0nqsTswmuGgT@nongnu.org
X-Gm-Message-State: AOJu0YzaYQTIKoW7vfPCQm2tLxLoZXyysDtYq4RTxICZG6qoJ858I4+d
 4KS9JakSH61birFpmJNYaaiUPJUGabuMZqhA8nDXVfQIdNINGFl6ahFv//1/dzE4Ajk88crslzr
 9CD8JclaUj10SVV6byRxmIyWmhTypVk2OJO+5YgMTkQ==
X-Gm-Gg: Acq92OHaQIlOY1rs+Ajoa2duwpVyhTbmovEnq1eKaalckFRxk6H4e8LJflABxEQM7Yw
 PkivYLJ2r8Gf6Ry44lGhe0e2CKfOtXw/KfTe0zgAFid+XAVNfcoX+Go+3wtHcIFmaBOxZ08HEUN
 cN3Q7VLxZADUEdNs+onHO0R9We6BwMiCWqahYWc6rnkgiUHbsAztoCjbLDwuMln1zINgrzMW1kC
 PNTlHsVrdxvgCv2IxU1hkfme70BF9ruP1SONFmpjB2ABZWEN87T+H2dqavlcpozETOd8sf4d9wI
 bnxfXbFKdq5XO9Du7RV0R5p2xvzjX3sBBCQM0mRaCytWNFdceMbTp9xlF+4npW52pvI=
X-Received: by 2002:a05:690e:120e:b0:65e:b380:b6c5 with SMTP id
 956f58d0204a3-65eca8a097emr13825216d50.21.1779809016596; Tue, 26 May 2026
 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
 <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
 <CAFEAcA9QeSjN1JV6ieavrr+r7viNo5maAtz5OJctcbWwTNQq9Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9QeSjN1JV6ieavrr+r7viNo5maAtz5OJctcbWwTNQq9Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 16:23:25 +0100
X-Gm-Features: AVHnY4LaWS7UISyviD52vyhNpQr_K1tATa038jJFbtUSLViAahJ4cGY02ONy8OE
Message-ID: <CAFEAcA-bW9zOW6o2OS5uy2Q=dWvq7xQKXeDciDVU5Qs65JekHA@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
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

On Tue, 26 May 2026 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> Some stuff has snuck back into qemu.h again (e.g. the
> prototype of init_main_thread() could live in user-internals.h
> but was put in the wrong place)

I just sent a patchset moving a couple of prototypes out of qemu.h.

> because this kind of "looks like
> a good place to dump random stuff" header is hard to keep clean.
> There's probably a better name than "qemu.h" for it.

While I was doing it I thought about this part. I think in an
ideal world we would split qemu.h into different parts, e.g.
one header for the TaskState struct definition, one for the
user-access functions and macros, and so on (most of the QEMU
source files including qemu.h don't need everything it is
providing, only one of the three or four groups of APIs).
But doing this requires coordination across linux-user and bsd-user
so they both split the functions/types out of their qemu.h headers
together. That doesn't really seem worth doing to me, at least
not now while you still have a large backlog of bsd-user work
not upstream yet.

thanks
-- PMM

