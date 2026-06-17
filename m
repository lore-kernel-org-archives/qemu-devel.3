Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF96CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsWJ-0006sv-Mk; Wed, 17 Jun 2026 11:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZsWG-0006qi-9t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:49:36 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZsWE-000472-K5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:49:35 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-660323f7b27so6027785d50.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711373; cv=none;
 d=google.com; s=arc-20240605;
 b=EdwsQcCmPbB8TJ/gQURZZhJgg4SIyNDMCqspwbtbe46wfe5okVBpQtB5SIhgWyE/9B
 No6U7kGqRjyPzfFHDohfv2c87dSZB6fH8Gvnssvvl1GiAEgAOHF8JRSXJkbEl38IZ3Kg
 Sqc4+3W527xWiTAzhqfmSVrJ7DHY3CQr/AHAVKQMg8mutWRwOtPTqJBfD7d/1Fsl3jjP
 7rewJOw1gR2/xp1vyIm+vYDLNBGmv0lev4jqlvWmipg5xlXUzW+hFqvvVZ9UOIxTMRlp
 GOjd3KGNuj0fOdpK5OBnqsQpPhfb1z0y8VD5zczYj1Ynw8/ZPQTXV22HEvCvIj7lXYzF
 9uVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fmVjBGRpq5aNTY+wep2v+n3yJgCjN5SsJ9EhI4qBSA4=;
 fh=fgYeGV39QJ2qK5d8fOTMJurV98iRoQAnl4ZV8KksdLo=;
 b=TzwR+F9tnb+57IKJr8eRsRtL8zxJYD7+WxgwU0gz01HE2l+5I4qEVwxoSIK1fGu9ys
 wjCBCTZVT0XelRw+QHhUtw3347akr414Nw0mPWsmaAHKryLVQVZ6nKUV4X8KvUtm0SRL
 1QpI7B4o2KQFQpX2RqOGK9yAIEl3h/V94y5+7piNsev0HxjjwstfzO93aJeo4ozjwL1w
 IAW9OAOc6Ii2sEzTggMQnv+JoUtCfeTzWbOK5NNI0cGRFfazdKnJ7wQad/YN5hFtfrMB
 51iWlVN/qpButYwynF2AetpEOXydf02klRbS1yKeQ8Cw0GEJeRKJQK+32LJrYhT+Wdzc
 B8jA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781711373; x=1782316173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmVjBGRpq5aNTY+wep2v+n3yJgCjN5SsJ9EhI4qBSA4=;
 b=egfuCeNCvCsVaBBt/drY5kS216gH/bQdS9GXeOMr4CSpnOaWdk1kNQh1riNS88L/ha
 jkyGAqQIOhck9uvuhYN5vamkOj7Gpi6/rOxMYDNZffH+46T/EpIHKFTJbJpkhg/hT9k/
 o3piDEUaRINZ2PZJJvCLxkS4ooajCSjZixir5yHutBtObxd5mtfzRROQBRI7R6ikRrEm
 h+yJVSc+tCdb/B/qJ2TDmVy4Gh7ieH+CFWiy93F/Bp3Crlj1/4VDCi4XaMO7hEVU4p8E
 ShV+i/gzC5ZXO7mPuH28z1DwmCUu/JTm+qmsrnGSAresou8OvyObJaeSpduKfUvpxVW4
 TfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711373; x=1782316173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmVjBGRpq5aNTY+wep2v+n3yJgCjN5SsJ9EhI4qBSA4=;
 b=Kvlxcqt12tTYjstGsj0MHJBc/5D063OEzHR2iCKypfbfrUhCveTGB3OLAaHdhQVVwb
 7v8TuLplBIj9OesSqWay2CRLBGRJlAjqMgroKKMa+6YdRDyFTQBRPOVHDK3DUhGQbtT2
 5g9R+Tk+3yxKRIvFZS/LfirXDZQibPLp7GXz/qZFMVHmTn73rZrQDqy0oqUuUToDR0Ow
 bdU1oiycHud1bdy6IYh/abQ0BnvOlhTGty/LVTs0w20EKu5yQgClgsexOEkRbvbOqopQ
 zvsbMO8quSlNaWHqG45WUYonVmbqQrYSABDFLFNhUXKXnWXBb6I0qrXzwWPtBYmhvNaq
 cfrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8daXBw0A74+bjGN18aMW46JRo/GtGKspJVbHSzbr/MQr4BaHSNN6WxO3JEkA803lUfzVwaqd4Aqffs@nongnu.org
X-Gm-Message-State: AOJu0Yxo21+W3UECGEb8iokk+k9tYStdwaOYWGZ2UPJLopL33IwX0YuZ
 w0TEvsWi0uJoURFKEdNNTfeZJmm96IDE0vCnDAdcLWmQsuqSp7TXIfUJ40jRxAlJ3lYneWfwatl
 NjilJCIzN+50yLwIAhK8ZGfUzOkdP3cV50bSkMPWAlA==
X-Gm-Gg: AfdE7cl/gPCZjq+r7nipp7HjJOBawNOBcLBYr+EqrNOR8INcEyUKc380YSlv5f9DGZi
 AjrraQwy5euq/XAsQ8kOZW1foaifxUNTx1ImTN0JxkiRoHiR3aegIdOKRApoD+Xn2fXBKuyVwOX
 8Kf3OUqJI+c4NwsQkgJBligXCgnITXvOWh7J+qw7B9dytguiOBlyWxY3uhyvuxBn94kugLst9aZ
 RfA0o/lPBfOyopt7iY4yZAukQfC78Y0h8p+PqA77ZbUUa2yiLqOebeBPSTDmt3htNYaDEool/OK
 AjLjqHbHFeRM4ihpzg0nQk4oMLWxenP6MfpE84VTw014RC6hs1K4J5yT
X-Received: by 2002:a05:690e:408e:b0:662:db62:14e0 with SMTP id
 956f58d0204a3-662db621894mr1919618d50.33.1781711372949; Wed, 17 Jun 2026
 08:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
 <ajJdH8XMmfd8RinN@redhat.com> <ajJftnDx2L7PGNuK@redhat.com>
 <ajKy5g3EfdaDicly@redhat.com>
In-Reply-To: <ajKy5g3EfdaDicly@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jun 2026 16:49:20 +0100
X-Gm-Features: AVVi8Ccil9xa3W_JzUtRP1iMI-8gJNb3VCjx5LWSW5NQQgZkB2RwXsiylk266fY
Message-ID: <CAFEAcA-x+fWcX6Z10sX+A5ApNc960Zkd+ZqR+TiFO5KFAuWZQw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
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

On Wed, 17 Jun 2026 at 15:45, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 17.06.2026 um 10:49 hat Daniel P. Berrang=C3=A9 geschrieben:
> > Incidentally does any ever find the CID to be useful in the commit
> > message ?
>
> I've occasionally looked it up during review, but not sure if I ever
> made use of the permanent record in the git history.

I have probably used it occasionally -- the Coverity
web UI lets you look at issues which are marked as "fix
submitted", which means "somebody posted a patch to the list".
Issues that linger on in that state either need the patch to
be refound and pinged/reworked/picked up, or else the patch
did get into git but the change wasn't enough to make
Coverity happy. In either case it's convenient to be able
to re-find commits and patches which were trying to address
the issue by searching for the number.

But it's not something I do all the time as a habitual workflow.

(As a side note, the coverity scan website seems to have been
offline for about a month now...)

-- PMM

