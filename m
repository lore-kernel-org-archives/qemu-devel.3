Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3048C71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDJE-00085J-AA; Mon, 16 Jun 2025 13:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRDJ0-00081V-Qm; Mon, 16 Jun 2025 13:07:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRDIy-0007wC-9i; Mon, 16 Jun 2025 13:07:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso9710787a12.1; 
 Mon, 16 Jun 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750093649; x=1750698449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOo8rSqsKdyCcBpCDqRMCJh2UFcFmNcw+BIDQqIIz18=;
 b=Y9kLPTse9zOfYaAGZEmNsP1kLfSZD/h0lf3QJpk61DoihdqemRhkocSrdY7Fe5+WR3
 BO7zQp+js82oX3FK/iaCH8yghytbsg242KQ+/wJn6eugF0rDrF4fDTAX+gD8PANICgze
 sx1tuZh6Z8Id3WobpLkEffnra5/k87//7MrFk4UPpyQHHI3lmojynE1nAir97bu03cmr
 O8lXDCsf9ku3O6MAd6PVaPZbAS1aJxeEnC7KwulEo41ndyOnrD8ezOOK+DX2CN/3iqbA
 QrH6F3EClGvpLpeNtkav6EmXN1VX8QTalOCFNCv2jwjMSueUegDO8S7CvId3eoEIhy14
 H0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750093649; x=1750698449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOo8rSqsKdyCcBpCDqRMCJh2UFcFmNcw+BIDQqIIz18=;
 b=tsyVon7KJbtmfkib36H33ufWwlAwKeoquQx8hox7s8+dHyg8kAcfB1z8EVMNvJJISh
 pHo2g4b99HDSWn+FTbd7UiQhBbzFlKCsDINnr4e8XVF9Wzk1BM7z8h68jIzMGTVaBhsh
 ns9P+dHxWnsoL2KtJKLxryLc1hxqwln8JghEziAszl0nte19pGDPjDwhMYixGXkVHAfU
 B6klrNimOqcJYPBOG2BTFb9Bc4UIRENAQv6a8ywzEf1J4e/uLS4DfYCEyEy0/W6doaVU
 Z0A9P8mHQYOjs1DVZibKwWvyej3Z5F9EQoJFGkw2ixhjADMlelVMShHV+06cVHDWRuZ/
 Tm/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4jP9OlwY63WqjsdbbMzlEwwF5ZH9QHGpAqrn5lys0ZP/dLkVsVtqqS/Xzw3YJrCDEXYnif1tNvGg=@nongnu.org
X-Gm-Message-State: AOJu0Yyii7mbQfXo3rJ1RhufmLTUA4/0FeBvnwR1i7qGoD1xva8SvzIp
 qcrbTUp7/zSiS6LqZ+kZycW7LYLPkY9Up0eZkKB1v9HsElRzdVGkfeqgSURbId3zyviTPP98rTm
 WL6nv+gl4nCF/mJKy49HfRp8MFeyoN2dnEg==
X-Gm-Gg: ASbGnct22rqLQCTzCoOGbt6Hq7Kpc464nmV+P9umNY6B0YlNzUKFWQKNCrLkkazyEKg
 JXv9ok+8L+HrSSZL6/TApuaQ51fV1mVbJSfKR5RpwWvK55EcQ8hijsmYblBrHQ76ODCVhy0XWic
 5USWoQBv2nDGq0O/GnkCIPTT81lEZWkiwhlG43YAzpzQ==
X-Google-Smtp-Source: AGHT+IFp4xdeIItnCONEuthp6am/jG4GogweqiGRmNTCLSqcBae8qFzTlMAKnA71vxoWVkdtTSuK74OG0/YY/eojNyc=
X-Received: by 2002:a17:907:7ea9:b0:ad4:f517:ca3 with SMTP id
 a640c23a62f3a-adfad363e27mr990033766b.20.1750093648381; Mon, 16 Jun 2025
 10:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QW-3ibYSCL0jYyvm1eADp7fKvLgorGWEk8WXW4SMGfaJw@mail.gmail.com>
 <b23712cc-1291-4b3e-b6c9-2d5c9abc4622@redhat.com>
In-Reply-To: <b23712cc-1291-4b3e-b6c9-2d5c9abc4622@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Jun 2025 13:07:15 -0400
X-Gm-Features: AX0GCFt6NjmU3IML0HyCYUzC4MGsoSZFV32dJdzvwqA3pS88Jia6HYMkHriwhp8
Message-ID: <CAJSP0QWNPuO-Bs3dEs3JbLSgh9HMC3WyPVeJ1j8GLWC0tQ3ndQ@mail.gmail.com>
Subject: Re: New CI error due to mismatched lifetime in hpet device
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

On Mon, Jun 16, 2025 at 1:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 6/16/25 18:46, Stefan Hajnoczi wrote:
> > Hi Paolo,
> > The CI is hitting the following new issue in rust/hw/hpet/device.rs:
>
> Thanks!  I just saw it as well.
>
> As you've noticed, this job is allowed to fail, because it's just making
> sure that we find these issues before they hit the "real" CI targets.
>
> I'll send a patch as soon as it passes CI.  Let me know if you want to
> apply it right away; otherwise I'll send my next pull request later this
> week and in the meanwhile you can ignore the failure.

There is no rush, I just wanted to let you know that the job is now in
the warning state. The next pull request is good.

Thanks,
Stefan

>
> Paolo
>
> > error: lifetime flowing from input to output with different syntax can
> > be confusing
> > --> ../rust/hw/timer/hpet/src/device.rs:770:15
> > |
> > 770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
> > | ^^^^^ -------------- the lifetime gets resolved as `'_`
> > | |
> > | this lifetime flows to the output
> > |
> > =3D note: `-D mismatched-lifetime-syntaxes` implied by `-D warnings`
> > =3D help: to override `-D warnings` add `#[allow(mismatched_lifetime_sy=
ntaxes)]`
> > help: one option is to remove the lifetime for references and use the
> > anonymous lifetime for paths
> > |
> > 770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'=
_> {
> > | ++++
> > error: aborting due to 1 previous error
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/10338038013#L5165
> >
> > Stefan
> >
> >
>

