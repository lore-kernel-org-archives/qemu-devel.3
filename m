Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FCECDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd59L-0002pW-VS; Fri, 26 Jun 2026 07:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd59K-0002p0-JN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:55:10 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd59J-0000Db-0A
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:55:10 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-663c66669ddso1002747d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 04:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782474907; cv=none;
 d=google.com; s=arc-20260327;
 b=jQWqHqgah0yl0KrJ/lf+x52P1Oo06Ngwnf01hrFuqHNzQgFqTFSmrcKXjUTlJUGRai
 TVMm+PP2dPzVtl2v0yhqpGq3KNnPiADLvZhoNeheBSxnTg0hefATVbUUjPR22GO6KenT
 9Llot6xUd7IhcRcfDKTFClQyDN6ZDhU885CMlB++SnBQS3O5jhYMSFfMFAwkgz3dzoQH
 B2f5IKBl7faIF8UJ4z8/XFlhIgWVZ+Qe2Xbptm8/KsXG2B9Wp6CV8T0Ccm51mG7FdTgK
 de/H4EgHRxSU5GogwkT2L9zzVQqv34B7khgak2d/nvcFlnmjDdElYwmgkP0GFTMO8xNE
 fjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8yz+i8f6mXle9DeAFygw+Xg//mpzoNUwELr24iqk6lw=;
 fh=gbWWi9Za62AnCULgx+w6TBGf2MhQXzbrtISScxGK8kg=;
 b=PNuCEu9FECWK+egOHAWhOywJFPtpIAaOYeph3PjmIWKlaPgK/l242AnJX1UuRSi0VF
 UvrOGscyQdUJ5/Uu/F5KINC1qco4rR9sQsEZAh6JGrxUUg/OEZ4fxB/OJeeBB5aeRivJ
 ZKZfXzvrQY6Qzn7htoYDM81HQr4xnHiaKG/en0LRclNr5o8XwdXqOrNQbwk0lxE9SJ8t
 j5QvEBdLok8RMrXhQTkvyrnoSb2b1r8t6XHxGK9GUsWviSBKrirDT7tN7+F38YvsVzjE
 6iiqxYz4QNgSbo1D5rhsERpBNUJR3hk94M/P8XJuNRUuWxQncYZr/IRtvTN4Aj5oQ3m2
 xJyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782474907; x=1783079707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yz+i8f6mXle9DeAFygw+Xg//mpzoNUwELr24iqk6lw=;
 b=OKHtt1kEaeRLGsGaTTNt2SrbblW9fajhtSNCEl9Arsz+8UZ9rQYQHOvEMwhEmMzk2c
 G2O/39VwvT8mtZcIw0QzCnP8eVBGm+Wot7LT9wCS1rnFi5B9l1FAJHjSGM2mRRph+jVB
 SyUqqiDBAVZ9UHs02hUy7q1Dj2jiTiYExgIq3BsqDyBLGdAyIO9ihO4E+rfTMqHC6znO
 IcyZR2nV8lPPd5QQPTYLSpxi5kLQLVXvsdhMakwL7tgDOE/XSiOBRxGT/NA1RDfHYW8e
 j5rzMc2YTT6FyjASi3hu9MEsCGJbiryvZ/lZP6ThCiZFbkCm19JFvuddaOx1RsdxZtUX
 N75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782474907; x=1783079707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8yz+i8f6mXle9DeAFygw+Xg//mpzoNUwELr24iqk6lw=;
 b=EtNGf+j4DwTM+Cimai9s81eCXWCfmcEp/7Qm/2MK9d7jgx7A7Y7WajjHbHTtZmz4uD
 uWHjqp5o04qHstQcb78SYrhE+r8m2E+pZ1Z3+Ez7TX7l0PPAZL7kCdFXfDxUftD+BQV1
 JKSddZd8uhCamr3sLydAVWSpm+ncnjNLe8+lpXdPzoTHqxibODn07jDWlcjyjmv+v0Ta
 XzzR4kS/iq7K+NF7922AcKAqKhOpD1akBXCh0jcXSmYi8fsECiHKIpDJuyHlxTv9Dtea
 so1TY3otH1R90AAw2Z8iAO9sjxk6F729h8GvvYA7QKf7bSxGYIxkU901N2fO4HqbiVEu
 UIJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrLvTR60cb8AYpKLwVlqytvsBUfllNAby3XfbZlekL/KlZjCOn+7oC+16yqG0OKoR9/i9CrJPgRzIZ@nongnu.org
X-Gm-Message-State: AOJu0YzyZyzrEt6X/atT6W8pCrAocMdD88nwgDsuzF5Qdbp8biSTa+hg
 C9J9JzBfh4UpYwwFP8n1cMnhANmxwzkWbHR1xfk21etUxqrThYeJ5RefJ5SR3NK0ZPYYXDN2ihu
 VuztO1vj+1OpgUkrJ9MFDE3t2XAA/WJ+pplrr/1iY1FY1orzPChpJj9j2yjCuULs=
X-Gm-Gg: AfdE7cno4PTI8FtuO2gmaobEKofByp4ayd0ewjHasyr2fBx5qi9C70RmH/KwxrxW/oi
 6rSngi4ha3Wj0t0ZIZ2wPXwZ79pntBRYsFxMOHPCkP8CRbFFrSthUstx4KVrYxITRvKXRjGk+es
 JxxHznIQasP4BUE+AGGW2hNOjkguz9z/M0y6bcl2rpfZXQQwDRpyPLh3mR4zj9n/pbIs9Jq+uPJ
 2YRSe0qmyBIUgBp5APh/l5f44mVbQC9ZKts8GQFff6CeyFnDsM2huhc/6RTkfAh3+Q+0eWmk6+X
 VCPu9qBuORI0UCnXARHv6gWpJW1cRJIfeAj4sG+RkxZAcoWJX9eVf9To
X-Received: by 2002:a05:690e:4081:b0:664:a341:4534 with SMTP id
 956f58d0204a3-664a3414862mr1028002d50.16.1782474907339; Fri, 26 Jun 2026
 04:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <87se69haxi.fsf@draig.linaro.org>
 <CAFEAcA9fR=iZ0tqk2xBQixrMdD-JJf6LZCLCArUwWZtQTW_UiA@mail.gmail.com>
In-Reply-To: <CAFEAcA9fR=iZ0tqk2xBQixrMdD-JJf6LZCLCArUwWZtQTW_UiA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 12:54:54 +0100
X-Gm-Features: AVVi8CexCmzHv4FOB7wF_1aUN3EuZo_CX8oubuLcI5vM8qUzlGlq5asGIwJ7np0
Message-ID: <CAFEAcA-co-_x_py1mQwfTiYQKRyN1hoc_OffN99TnuFsr6gVfw@mail.gmail.com>
Subject: Re: [PATCH 00/10] target/arm: Implement FEAT_SME_F8F16
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 26 Jun 2026 at 11:16, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 26 Jun 2026 at 11:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > Richard Henderson <richard.henderson@linaro.org> writes:
> >
> > > Another minor feature working toward SME2.2.
> >
> > This conflicts heavily with master - did a bunch of stuff get merged
> > that broke it?
>
> It'll be based on the F8F32 series that's not yet upstream
> (it's in my target-arm.next queue).


https://gitlab.com/pm215/qemu/-/commits/target-arm.next

including this series.

-- PMM

