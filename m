Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B9CC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57sq-0002LM-H0; Thu, 09 May 2024 13:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s57sS-0002Hk-Bj
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:48:24 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s57sP-0002Yn-M6
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:48:20 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e1fa1f1d9bso21589581fa.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715276895; x=1715881695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCE2iImO22yutwvFxoNmeZDL/AcG0Dli6mz2yal1fnI=;
 b=fHOtAoSH48JFeAINIhQUUTu3D7jyyUP396V/8ZcDGOOGcSSrTa90CJQBlmklNHFsuX
 ioX8Uj5ShEQGtfm+GbJKTuk2tVA2CxUBhPlXEuEnCVWQsZTgPHD8y+5jbs6sLi4fmKdM
 fBNfXmFYwTKheaW5nrAeGZi4iutwn8db0dKoE+4GNkILOpWOkr23MVnHZgfXWGufgxc/
 JVcju+v7ow9De6HY4OEQp7YuV5qCtmW/d3BbF97V5sIUQ1OLzR9A70lGpOJxh91Rq89R
 74qv3KBCXN1AF/3plRcL7JjNHPABc05gX5EhhKO2RHCEKvGxkPvmas9Ftmetk8WBC3lt
 pB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715276895; x=1715881695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCE2iImO22yutwvFxoNmeZDL/AcG0Dli6mz2yal1fnI=;
 b=vCnnc7FqHyY0+/nYnRfP1XA50mc0pdqKJzYaxGrJef6Os5+5wcwVrdUfnMAOJNFfSg
 zbjXM5PEtFTjUOJZm+18BX+yZPxs/IKdK340r3E54Qb2qE3PXWX1O8Pv6SDsT5B6NDaf
 N7OZ7dsWzk2nIZx1ksBNAXXqkD2IkNcdY0pmq5+UDnVFoA5Fpz1uwbtznkrq/ZndqdUc
 iE5RRcxJl2VfZhR57QO5OAqVVyWwHhzb7MMJR6mWDhnvxXUmh+rth2YoZ0EXViy3quP6
 tqLP4GAortS0lwFwbEB2X4Fqwps/XMdIHJUi2PUJj1k/18uWwU9uRb8MM8uuwtkwCooE
 Kw1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnHx55wnw3AZtxabA7bR4AkISJfstfK6f36cwp2KrcQws9aErTZgb8YJ5fkzy283RweYxkBHgCaIHrE0R/vpochOeL5/k=
X-Gm-Message-State: AOJu0Ywfj4OEoapD8GlEbYPJ7avmict9ftWnJpgB2yfYXqR9ClcNXcgA
 acGBlzSQB18A3vQfyWHtquR4jHVWY3cljhWqh/Slk3fpDx47iydOLIo+CZ3L6QzvDNwZVy+q7qA
 V2ztxNj2aNlYdAQPAiH4o6p2dBy117O+fyIoRiQ==
X-Google-Smtp-Source: AGHT+IGs2kbvUQmM3jmITOBFfcbju3tiku9eWgRBlNIXQY0RTvK9HdnOjr4uS/DoDE/fY6vU0+2zd5n1ttwY2Qe80Ms=
X-Received: by 2002:a2e:9ac2:0:b0:2e0:298d:65ec with SMTP id
 38308e7fff4ca-2e51fd45214mr1474831fa.17.1715276894855; Thu, 09 May 2024
 10:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
In-Reply-To: <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2024 18:48:03 +0100
Message-ID: <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>>
>> Your Signed-off-by line does not match the From: line ... could you plea=
se
>> fix this? (see
>> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-ema=
ils-must-include-a-signed-off-by-line
>> , too)
>
>
> I'll submit the new patch request with my pseudonym in the From: and Sign=
ed-off-by: lines, per your request. Doesn't matter to me. However, this ari=
ses simply because I don't give gmail my real name - https://en.wikipedia.o=
rg/wiki/Nymwars

I'm confused now. Of the two names you've used in this
patch (Cord Amfmgm and David Hubbard), are they both
pseudonyms, or is one a pseudonym and one your real name?

thanks
-- PMM

