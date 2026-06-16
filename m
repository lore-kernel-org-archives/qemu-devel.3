Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11ABCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWSA-0002LS-TE; Tue, 16 Jun 2026 12:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWRv-0002HF-0h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:15:47 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWRs-0001w2-PG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:15:38 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-660512d80b4so50450d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 09:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626535; cv=none;
 d=google.com; s=arc-20240605;
 b=cWWGB0tgAEets0VyFcrBq0Jzp/3aI7NYBJM94kqGj5SoOTdsK2/tQhsYEGl3QR/g4d
 1d8OJH/H+dkSp+q2xbyXPRtkJ4D1UbcESfRkP7Ra9BodKnpC50WJuChqER3eGLl6ic/9
 GViUTxwu+5jKrdB7BK+iZ4Edf5133a4QQdH4NcDpbYDzz2pTfltHbM01DWBlKXxAzU6K
 qSqgczyht2Fy0Lf/T1ZpsNzpgWIq47oCBUl7Rvg5mawEvX/fdMAU1MSPGOmE6pc8rxFV
 68u4W/hzzVhAwiNz9ameDtjtoGFABquLk4jDhE8MsxbzLYHlzmVjB9PJITbRm+hofiom
 vZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LLVwguNlI+Qh2NCF9WaQ5Y8JjgKFIw5l50opkptOCks=;
 fh=XkDcxgI35ocrFMcNShv78moWJRjgxn1fBL8CPzXhL5I=;
 b=CyOrXfM+cAD/vbIhrCskNyJAGMy4ED5OW/MEKWBTLzdE6AH70YLsn0WZEf0ZAjfHUf
 V2OXa++kqDGH9WX5pTCrkGSjMtZ5MVmtAUxwwHDt1tKWB2Ik0X0rd3KsvnyJX2o9dzu0
 Z5eJl8yncQolH/bGTlzA1kLhSKSbEU7TikTmr3NA4YqcWc1Vjfw1us1B8CAgOi9gJ/A9
 ToK38J0IqTly2cZrYUp2kaYQJC3NeRj3mQfMI1NHHGzJD+6YR8pCInHzdqgXqmzNf2ow
 Cni2RTs0u1t3kSOA/EgXT+dWSBo2HpKqARfAsXdVQeKo3/e/QhhVi24SSkEPQJd3WAaB
 Xwpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781626535; x=1782231335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLVwguNlI+Qh2NCF9WaQ5Y8JjgKFIw5l50opkptOCks=;
 b=cuu5+XmhkubCa2Wgf2o9CV9EA1iDk6VNk2w/gjWQLtHzyW22v4xsx/Q+5Qx3MSigwq
 PZeYqMsGSPIKXZ6l+ea36xOlobqzW0mhEmXrScw1V2Te3cO1ChNli+eJNNMNdvmytB8I
 3gWXRDFXVWNN3L8mwPrhbUhiDK8OTNyESVBMC5kmOYi3c6QQstayATri/SeeYj/VK/Bi
 QSBwtQhDo/Iaf65Fl5louN0LpNJVm6vW7qficTu+lWWyaAvFBR9czf79/xqfCjWxGzvd
 wtUHiixIiwRyZd0i1S0O7LnOektv1KRW2SBy61Oxl4HX71Xb5+bz1kPPwxX1dZDrGHnA
 45VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781626535; x=1782231335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LLVwguNlI+Qh2NCF9WaQ5Y8JjgKFIw5l50opkptOCks=;
 b=Pl/SryIeVembpxPrPVI3ESp+Egtm3yRGCZb+ucPsw3nbBrBEsFiWB7oxc6nGgrd6V7
 Zxnh9eCYPoqteyIemLYdO8TkzKqeOFzSLiH+VO+UqsIu7jnEYbcQTkHuoxMNAZmVQ8zi
 rhx794yUhoBLj/lhfqCoL0h5X9p84hdDOVC52drj+uWW1DmTfC2bo8i6pjfTRJwpI7dx
 imH/sf+wqv715g9IrqBDw4z3CncsctuiGI8V/KwrytcvI+tsc5desBlnaTEo/5I6XXUB
 iNM0UZM2OrNlILyVcgQzFkn2fUjyL33xTkMtTW0pvsfwFh5m/OgmRpI1+oyPnIufKlFh
 Ebdw==
X-Gm-Message-State: AOJu0YxXlSa/1EKE8r2EoxJ4K1DY4sCIb9tRwiD102lHvMvvm4PBZrk7
 hTnZDhEvBSjgK2hMaSCPyce6KmrnkyOFl6lnTclj2jMvQZi+1JpTdaRcK0sf1ayE4wbeaS7bCiR
 mpoBNyyI+xsndZ3aTr4LWTHdGYV76SJ+7QLFWPGVtiw==
X-Gm-Gg: AfdE7cndGF8VL+YyonNE5+3sdPcYFHKyyQUTE1Apj/Fdl0YUfIrMxgKxyZGKWmmIC+W
 d4E2E3RAGxd3jqsa8pSHkiLzpcsGvPA+ANdlTkU2grY5Z0aaQ5VB4iuKoQUO7Di4Bt2MrYm4pF5
 btQi55gdQu1/GFdHt0KChFY89/wwk8h6RG5Dv8BPfxP1A1UI5NpG25Qc72gt0oN2pdPnkVlB59T
 RQllTPnZ6bUhjcMu+Fn053q3WYCStoSIgkr0K1DrNtykP+N+2lVuGbd7GwzJHBZDxPbXRWci/uw
 YJoLo79nYHxn6P6HJMU6gWXP3RSDDTtep95tnCNxWStk8sqPJJ2uauemXV9r/L0ZVFM=
X-Received: by 2002:a53:ab0f:0:b0:662:c0f6:77f5 with SMTP id
 956f58d0204a3-662ca40a76emr171083d50.25.1781626534821; Tue, 16 Jun 2026
 09:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-3-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 17:15:22 +0100
X-Gm-Features: AVVi8CdFlr3FYQBf7wBSbIYWZI8KebUltLDrKIvvA-mfqfBGJRgaWBcU3DHCm_Q
Message-ID: <CAFEAcA8twCjEdr6R=JPEuWzf2+Gvuznro290ZZW8Eb0zubLpew@mail.gmail.com>
Subject: Re: [RFC 2/7] qom: deprecated embedding object structs within other
 objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The QOM APIs currently allow objects to be either allocated directly
> on the heap, or statically embedded inside the struct of another object.
>
> For the latter QOM has logic to avoid calling 'free' on the object when
> finalizers complete, however, this is not sufficient to make the
> practice safe.
>
> Users of QOM expect that if they call "object_ref" to acquire their own
> reference, then object will never be freed as long as they hold it.
>
> This expectation is broken when an instance is embedded, as the "owner"
> object's may be finalized, which frees the memory that is storing the
> embedded QOM instance, even if its ref-count is still live.
>
> Worse still is that a user of a QOM object cannot easily tell if the
> instance they're using is embedded or directly heap allocated.
>
> Mark the APIs for embedding objects as deprecated as the first step
> towards removal of this flawed design concept. All objects must now
> be directly heap allocated going forward, and existing usage must be
> incrementally converted.

I think if you mark an API that we call in 800+ places and 150+ files
as deprecated, mostly what will happen is nobody ever turns on the
--enable-deprecated option because the output will be full of noise...

-- PMM

