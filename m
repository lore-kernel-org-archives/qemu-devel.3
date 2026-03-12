Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D734106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mrg-0003v9-Bp; Thu, 12 Mar 2026 16:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w0mrd-0003uT-2U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:42:37 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w0mrb-0001PB-Hl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:42:36 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-509069a7a7fso153321cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 13:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773348153; cv=none;
 d=google.com; s=arc-20240605;
 b=hxexUxCNgmIOR30aruKrdIN9yfN1+Cnbd2IdrI25XqVWm2aUs2SFojP/glBlr2gS6C
 Mi+KS/Ns+7e2gVLc2BtGznprZca0X2CKUxKk6oXnBDFp3Ux7LdoUpi2U2xEBZQYJsKQc
 ZjfwWCS+aAA7mU5BNjH500uAziDwQQ1YYEVSVf0utk/98rfnpxr69hsfVamq6ItIdGpk
 LJsd5JQ2wITeWDw7BBIeBkLU9Wt/NCVkbBgm9CUSjOikXbA67BhOBDiBBNBTXJj3zEDF
 XdeP9YqKFTOQ8DUqtAeu0FeVkOLyV1qWTIJTVTHnsbT9xc95i8QgdRxdcOWTPgIcMZQO
 +pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oeTyD3/F7E+lrQ4jVrllIT3/K44YMIDsTKpQJz2CjZk=;
 fh=jPzHzkbx6rQx2DT6j8zcwXq5Sh0sdqNHDwwbwgXct6I=;
 b=f2cF99rqT3XJoOCuUOt4h9TafBi/4g2rLu3RdDxuDlFImQGc5wdUJd7JXbLLrtJFpu
 xBlgij7KPYv1p2fkzQswkAjPGrqeHqtJnMYsSBYH4KacYhU5LYkejKeh3OkxOoakh+QE
 f6GUYAPNF1UoeP9NWmCrDlkTZVCwtwz1AvZZlLMfWZJlqluwtPPQjWPSNW6GhAmH4E7a
 AxOscJb5laaatHJaVtjUEKf7KOdPeTOIVTfBAre3RASVY4KWJ3avwSqdycNw+vAKycy3
 YSUzdcV3mCYgtOetsI76pPZ5RyMeRMol6YmoOIByOqfSwxftVONs4fBmskfwGlRObmJV
 hEcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773348153; x=1773952953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeTyD3/F7E+lrQ4jVrllIT3/K44YMIDsTKpQJz2CjZk=;
 b=2MwIPvszX5zKWbYV59O1o3YZjFBWBdaKbxJ43rJ6Mi+zJR6da9jxq7xBzoz3zqZsar
 DAfjoKJjV6B6jcNPV8wpVodUnrXbikFyQhNmn/4XxQqGp3yEP6QVGxRCT4fg/J+JSHSH
 TshdsUTH+8Acj+o9zv7QI1sywi5xUiVqm+fmOHBCIJK3YqHxL8eY7POXlvy/z923pDjw
 oHjj6sKBbYGxp13VznorU9TF7rA4OxBefNLaIJMsA6cRMe5Qi1KRvqqdt+gVZ7eCll05
 c8MoX77B1SosRx0aVKIy1fcHUVsNe1R87xjCHp0Tm4nKtFKJIZetpJQVPZ8dndo6peAC
 vPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773348153; x=1773952953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oeTyD3/F7E+lrQ4jVrllIT3/K44YMIDsTKpQJz2CjZk=;
 b=YpzOay4hGPbF1WcptDa2lDFmiIquv2kEyyKpkQ74+QfMqxEw0CMWj0zSXT8fFd4CQS
 MRQTdlSSRL9SLEA6WyifUisQ4sSQGHKwRZaAJLOn3aqrGFRc3di12uqulfnU1K17/Xl+
 pKB0+ATmrHKh5AMVQ8jBHu/W19MlVNk7SPMy2wFg5auu8jImJBRbIT8xFC0AoN1vtV1L
 PgLS2k0dG2rJmmK0cCcIDg9mp0DyWYNQmc+0WOL1KdAniV7AvTOu4PFNiQTmRcEKhiqX
 6IzJ9Mt1phYrSdo1XyoCv11aTIJRNUNWBtXw11dFYwujotSgZc3nMzKHG/nI3c4jvw5U
 NizQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXAkpeSBTapcTAjIy1Ryqw2hDu4DUt2RsT69HWe9wmH9xLbo89MGNz9Qvwh6A6F7gL7ObnE8mPUEHy@nongnu.org
X-Gm-Message-State: AOJu0YxsNKcIhJLq2f3E7exXHeStnkT5jWDFd+iusGs6l3VARpeS+EZA
 KU5yB7JYdb77L12laTtiL4Ud6JG7MPCJYe6/XeHFJ5rJlwySeh9ZUUbYB7vJPEMGrmspjfBGgur
 PUIzuurhnzG5nmT6GIGPfEhVmGOtS9xK+dTr+1wUi
X-Gm-Gg: ATEYQzxYPHboObQADV5HFJ9w00yi/gHwxFRvdCvlqIvUNl9hWSCxLzc5kmhuS4Pcx0Y
 LhVSZ3iFKCKHE7kJMYb161C4ZrNLTAmA2ANOvbEIN5FC7UNJ7PIN2++0zBT8q8pH3WXyqORZ3WW
 X4NRcBJlXtuZAPSLKYhtAGaeWthUVdiii88Dur2UpKpqJh8q3dGQjMSl2X0xsnR7b1DE/RilpQr
 nzEZkhHRRh8GyIuGxtaKVec5mYaeJFPrPBpczTQ8xZGq7eq/wqOVUYeKw+swQ1CTq/5yuqiZSju
 8uwoH4jpBIqibXJrIJc/4nLWxOd8oFjkY9s6sQ==
X-Received: by 2002:a05:622a:1a86:b0:509:1b12:2b28 with SMTP id
 d75a77b69052e-50959e885famr732801cf.19.1773348152901; Thu, 12 Mar 2026
 13:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260309223116.3233668-1-rkir@google.com>
 <abBHWwiqu59wCAOY@x1.local> <87zf4fzfqt.fsf@suse.de>
In-Reply-To: <87zf4fzfqt.fsf@suse.de>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 12 Mar 2026 13:42:21 -0700
X-Gm-Features: AaiRm53ckQlEoDE2cToYQ-tzj4DlgeDoy7FSnVYuJpd6kcFftrFSmoRQ7nBWAiQ
Message-ID: <CAOGAQeqJ6F2UPEVFzEx-9EseB3Ncq4X2ZJGHh3h=EBTgyvomNQ@mail.gmail.com>
Subject: Re: [PATCH] vmstate: assert that VMStateDescription::fields is not
 NULL
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, whollins@google.com, 
 jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=rkir@google.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Mar 10, 2026 at 11:44=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wr=
ote:
> Peter Xu <peterx@redhat.com> writes:
> > Here, the assert() only helps to crash slightly earlier, rather than th=
e
> > field->name reference later..
>
> I'd rather have a (vmsd->fields || vmsd->unmigratable) check when
> registering.

Hi Peter and Fabiano, thank you for looking into this.

Yes, I agree that validating VMStateDescription upon registration is a
much better idea. I will send an updated patch.

