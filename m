Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01EACD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyOp-0007Q2-5w; Thu, 21 May 2026 04:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPyOn-0007PZ-D3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:04:57 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPyOl-0006ks-D4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:04:57 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-303f2fb7225so4094470eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779350693; cv=none;
 d=google.com; s=arc-20240605;
 b=lPFczp4fiuuBZ/SWup1o3fcXVztnR6P2gsbQjj88YT+kTa2m7nzMavIPTcsbtLTc1t
 /2o84yz7vwNI2iN1omn9jLIbjilTS0dIqABxETpOIyf6r1bn3EpF/8dQpExlNLsvJd7o
 6CzTrTiD4jw6tM9hrtr2R06YG0ZM8n06+v16n03oZ0gQmbTyL2vY+idWMm7vqC68ePSp
 mtjVCqyaUNaCVoBAH2WnjdT5noiyW0SG2DxmFCBr2hpdVe+OcHTau+SU49Gtg9m7n7CP
 /KSljUzT046777QYuAfhqkFMkx5UOi5PEe7ktInwFV6h0rieA+jpVyQ83NSsNqfCcRfB
 kmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4yNORtRbqxAXNVHTllcSnV1+At7HwPfpwPX4T3NASmE=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=KNXTjXSStBZBk2g9g5+4JKKEJpHiXmAQ5Tuv0tpc7bbcMWc5C85dpwFiqLpz6NFcXi
 Ez8eufotljIdpPRgn9sP3K9MRrX94ttj29nOM1SXsRnZGuKNKZVArh6NZr/j/dSJiBje
 llbZmpKLXC/aozH199E8xNVHsKO1ncGsVyO8A0tk0bRAOQLRj+GZqaIlgk+AnBbNtxSn
 EjDbPZR5K27jyIVYrwomrACy4Vi4MK6/ihTTk2EuQnyO/9ahN618iw0J44lQR+3OwkWC
 akNkXh2TBzbCwE7fJAY3MjAbf75fZUjszYsnLhZkaLjNGZk9/Ku9QJJviS5N+OnBp9m4
 TuJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779350693; x=1779955493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yNORtRbqxAXNVHTllcSnV1+At7HwPfpwPX4T3NASmE=;
 b=kTnu2uBLaKq9e0HlxdVusxdffloJp17q5rpSnH1z5qb57Jx2oyxKqng7BZd1VyvENj
 ntseTmmPURNwTqPdy5/LaDkm96TyHctKNF4HegiY3ofYNXtQwtMZq/WmhBtw1jy90qyw
 lAw8cM0L5cV0mX83cxW371ARcLNWcsNko6sK8Cus0ZMCOCoqagutckQOQ2KFwR/rxPOp
 mr6xUaSoCKFCOj3ia3h7pMPmseQPT82LS2UNVXAxAaeG1NSBk+xwKSvBAm6BsfYiX6QA
 b/Nti449oZVntX8BU9jur7KWWemjVeVZdFy6EjvofAMT29uibWT3T8/QwrksGB/HXtQi
 vUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350693; x=1779955493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4yNORtRbqxAXNVHTllcSnV1+At7HwPfpwPX4T3NASmE=;
 b=Higp06dpEGuAwex2FZUZzAh3f2Ax4ioUbsy0gODpWE27nCllXqDVeQhlGr6wtwMZce
 mYBTX3dR3Ae5kyJMKREsBF/PB1Y0nCDcfVtjMDJX5eeO3tqkU9b6FVfkVgzouVux9rUg
 aLdsBTRSqWxwo3LzWyhnxZqnVrbAlEUCvYBW1xh6upqCthjIaBbZaZSwa43SbvRChaSS
 IOBPftPxciu7e16bbvgRB6ch+22iu3D0ZyqTAwKedpJANu5N2kXhzklLsLC+SGvubJqL
 QWyowp2aWDuqgRww4W1/OS0X4rOEj1J9QxMYY5nxBZTWAYZKnT/0CALS1mjfyLZBAnJo
 9++Q==
X-Gm-Message-State: AOJu0YwtKYUPZyHAp5vQc8/DGTO1SKrVr+mL4dta46M9DgnmNBtX++ik
 xIzjr+FsHGk1erwYoPdd5XpuLzw3fnP5jGkFHOYjHr1grnpLUrU+M6YLRybSgYcsFktXyjrih5K
 yKvjhxONVuBGlkQlpUvBllsxbmp+Y0qc=
X-Gm-Gg: Acq92OG01A4BxODR9eebmOw9P24C7DnPOl/k7Y8++Sg3E0GQO+jky4mkctxnOdTGpQO
 1ZyBgH61PnsBH/q+dJRhyNKgRKPKiqa/zDd4SlMowyD/WkLQFhhAubgMtBlU8+X3vru/UuDnaw8
 gD60OyKGZI3YnbBEvgc7wZhgEuejUE1YivOhQsviEZw4WLCJ64DyzBilOFoVVlkXR5B3e/9yMOF
 hB3Bg9CwHQKmz+wS2posUgzimcK9E/6SHhkBUkOk90r8X4K9whMp+kYHba1ASgzCOX1k0FEB9PE
 /AymtDW88F8eW3Bh3VdSntukPyicnAX3w9Fyjk0KqK7CvnhOIXpOvmN719hD
X-Received: by 2002:a05:7300:ca7:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-3042f4770b4mr1019399eec.2.1779350693168; Thu, 21 May 2026
 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <ag66inUz7qe7YwrS@redhat.com>
In-Reply-To: <ag66inUz7qe7YwrS@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 12:04:40 +0400
X-Gm-Features: AVHnY4LhbsJcTtIazX_tDmDPgaXqKXT6OTCISgwKCNpMwfkT518yL_jAARJV2BE
Message-ID: <CAJ+F1CKrERf+fgBXNa8KBB+AS-6L7eRdVmnG21Gyi=+=q7gE+w@mail.gmail.com>
Subject: Re: [PATCH 00/40] Make HMP optional (and later standalone)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, May 21, 2026 at 11:56=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, May 21, 2026 at 01:49:01AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > This series makes HMP compile-time optional via --disable-hmp. The
> > resulting binary speaks only QMP - reducing the attack surface, binary
> > size and enforcing a separation between machine-readable interface and
> > interactive debugging console.
> >
> > QMP offers almost all the functionality HMP could provide, so a separat=
e
> > standalone "HMP-like" console could be implemented on top of it. The
> > rough list of missing commands (+complexity estimation) after this
> > series:
>
> When you say "complexity estimation" is that an estimate for doing
> a well designed QMP implementation ?
>
> My view is that for anything still HMP-only, we should do a quick
> & dirty hack, where we just expose the existing functionality
> directly as QMP without any modelling, but mark it unstable. That
> would make everything be largely easy.

If that's reasonable, we can have more x-unstable HumanReadableText command=
s.

>
> If we expect proper QMP design, then the job will never get finished.

Yeah, I expect to have a bit better than just plain string though, for
some commands. We can do it progressively.

See for example x-query-usernet & x-query-network added in this
series, they are structured, but a few info fields remain "free-form"
(slirp data, etc).

We could work on exposing the other missing commands in separate series.

>
>
> > Debugging / introspection:
> > - info registers (medium) - plus $reg expression handling
> > - x/xp read memory (medium)
> > - gpa2hpa/gpa2hva/gva2gpa address translation (medium)
> > - info lapic (high) - deep x86 APIC state, lots of registers
> > - info mem (high) - virtual memory mappings, different per arch
> > - info tlb (high) - virt-to-phys mappings, also per arch
> > - info mtree (high) - memory region tree, multiple view modes
> > - info skeys (medium) - s390x storage keys
> > - info cmma (medium) - s390x CMMA values
> > - info qdm (easy) - could probably be folded into QOM introspection
> > - info qtree (medium) - same, maybe QOM introspection is enough
> > - info snapshots (medium)
> > - info usbhost (medium)
> > - info via (medium) -- VIA south bridge state
> >
> > Simple actions / settings:
> > - gdbserver (trivial)
> > - boot_set (easy)
> > - mce (easy) - x86 MCE injection
> > - sum (easy) - memory checksum
> > - sync-profile (easy) - enable/disable/reset
> > - info sync-profile (medium)
> > - one-insn-per-tb (easy) - could be a QOM property on the accelerator
> > - pcie_aer_inject_error (easy)
> > - migration_mode (medium?)
> > - i/o ioport read/write (easy)
> > - hostfwd-add/hostfwd-remove (medium) - slirp port forwarding
> > - log/logfile (medium)
> > - trace-file (medium)
> >
> > Also, to let clients do disassembly on their side, it'd be useful to
> > have something like "query-disassemble-info" that gives the client what
> > architecture and endianness is used etc.
> >
> > In the meantime, being able to build without HMP is valuable and helps
> > identifying the missing pieces. The series does so by steps:
> >
> > - preparatory cleanups and bug fixes
> > - add commands without QMP equivalent and needed for tests
> > - convert most iotests and qtests from HMP to QMP
> > - guard HMP-only code paths
> > - make HMP source files conditional in the build system
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

