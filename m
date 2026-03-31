Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9416B109B46F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ZXx-0001Cv-GU; Tue, 31 Mar 2026 09:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ZXt-0001Bx-Rl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:54:19 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ZXs-0001th-75
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:54:17 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6501d242e2fso3906016d50.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965254; cv=none;
 d=google.com; s=arc-20240605;
 b=WJ0Wqk8HCaDonVuaSSAKaQzU/lse852eVWtefsOJnpSWvYTKuqzkjVMH4HbweP7zyj
 C2kx4jS17sJ8xlrJsAwhlyNNHqRfkFJ5ArSJv4EPO957PGsEfs5KVzFZKa0E6dxpz1QU
 qlIoldZq/vfi2yPGYfaSpfMSFWuzeN+8eHaONThmifSzRdSZoJWQi3sIvG68aEGK7YCN
 nR22O9plA85OBPvH423H6BJQKDcRkaS+JU/xPJOErVNPs4JkEIZt3FZZQ+99qrBSLqHR
 TbHVECfbArLZOaIZwK4pqHLi4J0oRMP9z2aStd7HdlCzRw5fq0Wd4NUCA/jdLj3SbPW5
 4O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OzoGAuqd+JIW6Qj2wHgdA0P0GfC5Dsn9nRZnPBlQl7o=;
 fh=5gSe9iae03psNksqgjd7tPo7vDgbnkSeGJyGDPz/YDo=;
 b=im3Kr1EWngldG1OKJqS2d5idyZKFmjg7icF9LlO+GV5U66/K9d9Vhcl0YmU89K8LCy
 gk3cpPgM9+XWWsdmHHtJSCE+tmX4fI/5hL+KN/B5uAXNbd6dDWH9Wpei2U8SrC1uVYjg
 LYH8D6c7eGtTtHqRyvMFwkQVqU0DOjqEBZ+strlf1Jk04uK0Wd78fTjPixc8AoxVMeYs
 IB1N0vlTI8aVRU1UJ59yjK/SjKnKTkLy2Mp331U0JWOhpwPQivYbCAe7hD+hgi6KJMc8
 qDj8fa3P0haI/CX5bNlZsCt7AGGym1gKwKcckss3u9qlAApiNnIzq3IEGigFDLj54l7k
 Aywg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774965254; x=1775570054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzoGAuqd+JIW6Qj2wHgdA0P0GfC5Dsn9nRZnPBlQl7o=;
 b=yTuSSXrSMqLK/lQhxnLKL1fgGI4fofK4MIvBVYszbcKM3lBiSOBIeynr3WqV9WKn4x
 y/QU0lt/6PPjoPCF//+cRD0H6mettc3NzplY7L+8X5bz+xfLtDEAPsphRhNhyfYwSC1A
 nptjwtOvjXH+U2ySszyMvT3Q35CYAti+eGSj4LXw872XsI3l4Kbqam/nyxCjz6KwpcMp
 VuAnjU3mqVXZtfFactgZMaxJZsXcs874nTiEx9pvq2po0G5/dbCFVsP0NWEj4waWnOkd
 P5eE/zudiponHiID+UMMuJsRlbAUrplBk6aMZh4t7PqqcXf7TnbOTbCq5ne281kAHbPA
 83CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774965254; x=1775570054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OzoGAuqd+JIW6Qj2wHgdA0P0GfC5Dsn9nRZnPBlQl7o=;
 b=GmYwH0ySkaz15TOl8LPcmKZFwnp+jWJe+Wkt6/6TwN/YLFbX5H+GwzDyN0FB24ArzT
 3o3XdbDIOPkq/uB5aLsEQyBNWxPsBb0waN0slPSNoEl1VN2yvk7/b+2VF6y+lEzgVshs
 +wNGyF5zB5uYzso4c8jMOwrMle/h4FY9wh0gl5+Yy/rp5/kdFneFj6xB2eC0I59jvcOS
 fQRIZHfmB5BHC4SUd/54bJoIWuoaBw4Vo2bE6aZpA70JkzZ61lSsJ69tuvSvHLmnCrMi
 AD+snU3cavlHMUxdnaJTj08s9YXmjiktKe6+x9jGbbFyoX6500qBBmqPoUu49KpOVc5l
 qnyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw3U41VgfE+1ZRZJbDaNkgnAkrtfCLVzi7G/fwoetAiHkMutY+47Sg6vyAfnelKpw2rQR3fFpevPti@nongnu.org
X-Gm-Message-State: AOJu0Yw/CqNk34HOazPNG9/X90FaRi8jHnXhHgVXIG7y+au5lBU0NDEr
 zbA5g8DJS58J+avuvwjNSRVPL6o1suwKeDbmJI9VCg8pnWhbz7DL9XnuJ81gGY0StF0wBNy3s0l
 xYQa0jtT36yS68tH0jy+rDEzAmKgSaku6cnwmphvu7g==
X-Gm-Gg: ATEYQzywLYTieLJi5vXVuvXvSRbMFWKqsbkK0pxaz8fQmimWkGeTtq0/Gy5QhgKfPwq
 iKwQ1w/QjGWNOqYEf9sNYCzJ3UHhk9/yhZdNwB2GcOqbaVw+m+1wZCoGxD8Es4Ap98NCiCeJPyW
 SmQ3qmSkF3eog+GFv52iZcQYNGimnXhPFzqAOByko0m6HXHuX3EnDlrXJs+rEYWwTkhUpTGn6O/
 PXn+jRKczbs/DW5XTyaomdoQrvcjnA6mVuuszg2O5F3GaMr2zwZdTQaZIPUMFCZK+v4RyhJHbtt
 SHkN/Wo46GQPLmb55bUbkhyYc1h73KtyhP0z2rqs+I8e0xuYERN0cOyA/C19q3t5xUU=
X-Received: by 2002:a05:690e:dc6:b0:650:18fc:f557 with SMTP id
 956f58d0204a3-65018fcff27mr9201375d50.56.1774965253988; Tue, 31 Mar 2026
 06:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-73-marcandre.lureau@redhat.com>
 <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
 <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
In-Reply-To: <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 14:54:02 +0100
X-Gm-Features: AQROBzCoQ17WmFe8octDW5PwUdvpQX_lH2QuvWsw73vfdx1lbtsP26mdrKxMLDg
Message-ID: <CAFEAcA-AV2T1wdKueMAWGL8Q8co-kCBxi=fPWDeiNs3WD28y5Q@mail.gmail.com>
Subject: Re: [PULL v3 72/85] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 17 Mar 2026 at 14:02, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Dmitry
>
> On Thu, Mar 5, 2026 at 7:55=E2=80=AFAM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> > Audio (driver=3Dpipewire,model=3Dvirtio) is broken/distorted on staging=
 tree
> > and I bisected it to this patch. Can't see anything obviously wrong in
> > the code, any ideas where the problem could be?
>
> I can reproduce this. I'll look into it for rc1 and let you know.
> Thanks for the report.

Hi -- did you figure out the cause of this? As a regression in
this release it would be good to fix this.

This has been reported also as
https://gitlab.com/qemu-project/qemu/-/work_items/3368

thanks
-- PMM

