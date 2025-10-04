Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D1CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 16:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v54q5-0006zp-Fs; Sat, 04 Oct 2025 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1v54q4-0006ze-R9
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 12:10:28 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1v54q3-0005Av-8E
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 12:10:28 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-31d8778ce02so3356725fac.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759594225; x=1760199025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwV2VH7YG2Zcc1Y57pIWP8I9hjDK12g+0AZrnxN+cLs=;
 b=ip9qaO/PcDJuAuG+hr99ZmyWzPkv5PVllVdFW3jo9brQbph+lBMY4aeK6i74I8OYWD
 hk2CcIIaHac9ygnOj8+0oyjaBozl756d1LVRYq4FcACe5wjW+/xB/zopBUqs2S/1TGba
 PP36QTf/cwcNMD6Kbe1db8ejmMZTbiqljA+KkteeNdIVWBy8TdnUaFwNIevijF/vI179
 VRQw193X6zBS4K+Is425qw3sPi+ktqR3P7s0DSd6R1LjDjnagziehuHwYSODBP8ylOQD
 qobwKjYLutzOJxajHGJHNAZnTNA7M4k/xbvtUJThNPloXejJZc1f66l1L/f3sBhHsWlx
 W4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759594225; x=1760199025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwV2VH7YG2Zcc1Y57pIWP8I9hjDK12g+0AZrnxN+cLs=;
 b=NhODVNzdsDwT05w7f8OYi9/5yDvURZt4LwmcRZFf/23xL11a+cV74auCrm2DssobnQ
 xTg+5dDYdYN+TQqi86kCepHdF3LRbGPyNPOPtijFyFX7dOa2j0hkqRq20s65NdBEToSm
 nE/ntf+MUE04zFmw6Q0TnJTi5JDDBf7uM8fUCNk1MeyDcgp4wMrZP3iZgeG39//wTusN
 0tEwxyOK54ZRgpR6tYNUWIamGJypofmWnSaF4LQV/gkNYU+ud7ng3lkqrEcAO5bs7eIT
 PeBNRBoBrtK8SBE1ayMMK56b4q5P/g8cGLtu62sWuzD9i5+Ycj0xgSyWD8tkus5f2FHl
 6plA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVA+wiG9g2N/r0iEQq2xZLz5zQt6JzZporQrDt6M0Juql6NnSiSDSMpCJ54iXajBcPZ9G8pHGZwuvo@nongnu.org
X-Gm-Message-State: AOJu0Yx9gwv0BFVXly11HmZFSwXPO4Qp5t2XdcUOFhBNP4rT7tVmxej8
 XUsYNFofIlkciRVBZcyDUE4rWFFDP9tCPdJHkz1CllXQIbgA1Z3BeyFER55HKsei60ZSZJSP78D
 2wO3xH4a9yM8B37B8q7x1j4Cgp4GAYyU=
X-Gm-Gg: ASbGncuInzV8blvTkM+LveFJ1XPDm5d3VHgFCZ4OBwYtLbTjP8Ky6Fq4tIkOSTFmRDK
 Pi1UqMYrl+XSxNwjg2mBkNt/VeTY85j2WgnKmkSmk2i1L9T3kJftBuxC05RBgBaoQpx5zX/whuP
 66RwPrNRNGH3QfmCi+imXk97Ab7H5loRR1kBJy3dS2KFXMTtcjEEipy1Hhx4VPt7TBk1RCljA+G
 AYo1OZG89f0CQQisz4NEf4WJ4YoQ7BdFeCcbm0R
X-Google-Smtp-Source: AGHT+IFBRv6vuqx3RKmMDC9BTCbibO1en1bx7dTwFnmbgQNBApdVZSmmd7SaameactHAtDLEVoG+RxC4ESBAm6tsXOQ=
X-Received: by 2002:a05:6870:e995:b0:315:255c:ced2 with SMTP id
 586e51a60fabf-3b11876ccfcmr3788971fac.2.1759594224902; Sat, 04 Oct 2025
 09:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
 <08EF65B7-ACA6-4AE7-802B-FDEE324CDE4B@unpredictable.fr>
In-Reply-To: <08EF65B7-ACA6-4AE7-802B-FDEE324CDE4B@unpredictable.fr>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 4 Oct 2025 09:09:57 -0700
X-Gm-Features: AS18NWDRmnWkTFoPsAMMih1eljMSZWzZRZVI9_pgigITCLqm7oobAeQDpqNlElw
Message-ID: <CAJhHMCCgv1Knph0vJY6fouimm3u88YZhC14fJkD=krTVKqQ0oA@mail.gmail.com>
Subject: Re: Reg. guest unaligned accesses in TCG
To: mohamed@unpredictable.fr
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=bobby.prani@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Mohamed,

On Sat, Oct 4, 2025 at 12:22=E2=80=AFAM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>

> Hello,
>
> If you=E2=80=99re targeting Apple chips, note that RCpc is really slow on=
 those
> as they expect you to use the hardware TSO mode instead.
>
> But to get TSO mode on those you=E2=80=99ll need to use HVF=E2=80=A6

It is for general ARMv8.4+ CPUs where there is no TSO mode. Hence why
I am planning to use the RCpc instructions.


> > How does TCG check for alignment? How do I check if the guest memory
> > access is within the 16-byte alignment? Will alignment fault be raised
> > if it is not?
> The hardware will raise an alignment fault in that case. Other emulators
> then do backpatching to a barrier-reliant sequence in that case.

Do we have to add support in QEMU to handle this alignment fault? I
recall there being alignment checks for loads/stores but I wasn't
quite sure.

Thanks,
--=20
Pranith

