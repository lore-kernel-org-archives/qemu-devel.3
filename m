Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4C2CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 21:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNHTC-0006En-Po; Wed, 13 May 2026 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wNHL8-0004sW-HR
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:42:02 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wNHL6-0000mX-Cy
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:42:02 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8aca6a68de3so10894906d6.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 14:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778708519; cv=none;
 d=google.com; s=arc-20240605;
 b=SqEUiVmHsCY9JGVOjd1+IQRkqg/+e4z6EVKEz21egTqKOpP7APyI37JqOd9KJL1WJ2
 IQH8xBwYDjF2SVEj/nATBEASvP3oqWA9eRh0AVGVVBqB8YmFzzzWmsEF8+fXfMuM/YXh
 rHB6Cxj6mL7BsUAjWvrduvcSm3GR3Iu3j/zsn+IklGAQUFOjeCrWWPtdXGkUD26zscAT
 VR3w6rSSHYY97YrnM8oR7JsJJM+CcFYYcNkhpIjn20n2p+hBK6VyT4UDhCHtGOY7WzKc
 BrOPn1LLJK71Vw5srE0lxV9BCOAKRyn/ZHDG36YpGHjtOY6bu3sYqMc9iueoazPjwXvK
 gDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HKYJNP1lKIjKy+Bnd/DUpm5LlTcnq31BxwFAttyfNDU=;
 fh=D3AGwmq5AO6lsgND4ozRLoUh7IDJifpSBSgY139rfiI=;
 b=YmCALaUWXrymacLf1vbq5c2MDTaCF6EO5CDK4eqR8ZnJ7JlqEo0or5pXzv7ltTjE6M
 vCAO0lFyazNJJ9WGvyXDKaPd4q4GuWrOUYkyKPP8SkEklNphQoAbOqn7mkw53P69KYuH
 ByGlpVSx5AVqUjWsCp5JQ4pppfAwJ7n4HYtAr95aINYdErY0MZ67fdRB5B/zQ0JMMDMB
 wdqCr1zjpMo4kW4L3RySCjvpoTGgUdTdEu17UznHidP0jKMML7pazfkL7zJOFTFK8Uz0
 puUkTUpgLNeIve8PgW2kRhn293zHfSotkE2ahZWo2PCXskk2m/QnhJDIRdtINyp13xzT
 doVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778708519; x=1779313319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKYJNP1lKIjKy+Bnd/DUpm5LlTcnq31BxwFAttyfNDU=;
 b=p2cBpViwzZ99nW5yiHfu8FuITirCv0q3l1H++Ja1i3Zn7PMLs7HAs0cMIjHyiYQDBW
 4oUV3X0qBw8zumzWzSCrQHnvdH0p0V3f1agPqoSFg5K3InO0pNRz1YLZEj06PxStS5wN
 5aHGJLDIvVXrjEzzu8mJQW+dC1LqqawdVF7tnQwz87HMc05hyoxG2N5KDHQNz443RRSz
 R9BEj3ooXjqYf5pL/706mPSQb3XSjkDBiC3ON6ecHAYCGAWCBDTRuBUsOIaz5UL87Udo
 nCzV3GMIKEf7dtcdNn4TddDH/2MAwz5A8q9l2Y1Xb+MXgWIDbSY7rCM/A1wZcqq+4raw
 D8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778708519; x=1779313319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKYJNP1lKIjKy+Bnd/DUpm5LlTcnq31BxwFAttyfNDU=;
 b=clqrZn4jtP0DKtW5U1gwY6Za04+FMHGYseW7U/xUVXjCThKzbGvQ1pQZvsPNKkNLnA
 KktCwh/EqiOOvZKIdIVBijH/Ajto+nfULT0MXX7kYVn6U07QXfn46fz9ySczhcJfx1rD
 V1E9wcBeIzjP5d0oUUK0Cqg7W2unRAR0zDakOXb8ZJPeLt3ujVN+iT6MkC3aU6ZsAc1j
 OysGlLf56UCYYnkyvdPOfsC0jus8RVfpF+fCblv+l1y7QyQ+gFPP5DxTVeZxH2ufRGDL
 REbLK009VuNpNWWZ6T0mfICCUGAKVWuLZO0J8kWLGHS7RK/7D3AqqaTtEUBcnMYL3/9M
 c3rA==
X-Gm-Message-State: AOJu0Yy0WWXOxHj4lVV1CsT43jry8p759lcEKssE9Vh+o4rovD9QlI/s
 MO+/aftGeedF+YHrGu3ER6LxDP8WOlGW0m0fzwLhRL7Ho6Tf79T9oavztDszsMQcThzEqFemtgr
 JBsKsooiAbaO/UhxInoT2evg5cwaRgkw=
X-Gm-Gg: Acq92OGvfSw9h6rW4XOUARfaHG5aYVhcQu2cfPILAn+y7ESMCH0WrcsE9r2+RwvQmnC
 vHlAskoOaJ1McP/mkBXVXjX/lGnJNhIz3xN3NrWw7FxMj15JlrOenbKsZmaYqUZeg3nDp0iAUW5
 X81DAtoyXJ4vIvbS7UO8ebSWKEq+ukNlPPP6hcWnQaKEZbY+SDOrVvRl+BEAxlpsgO1RsYTeZ+9
 5DMwZ8pyo5DbJyFAGuSzdBGLFuj1Os9jfyfCqSbfyWP1lWAnKXprL3IBhAPyetMxy0qw8l5x+Qp
 8XgfoxBKzMUhJX0gd1k3KthTDtNFs5u4vJrpudpiSa+Hka5sWRRMvq4qBmeal8/jYqtqPxE95h1
 2Mash0igsSTlRcabxuA==
X-Received: by 2002:ad4:4eeb:0:b0:8ae:65b7:1b0a with SMTP id
 6a1803df08f44-8c7b95ace3amr59363046d6.2.1778708518822; Wed, 13 May 2026
 14:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260416200702.2374709-1-git@aaronesau.com>
 <20260416200702.2374709-2-git@aaronesau.com>
 <c18a3fa5-4474-42db-b8be-95f164d1b184@tls.msk.ru>
In-Reply-To: <c18a3fa5-4474-42db-b8be-95f164d1b184@tls.msk.ru>
From: Aaron Esau <aaron1esau@gmail.com>
Date: Wed, 13 May 2026 16:41:48 -0500
X-Gm-Features: AVHnY4ISmPy3carpkroxh0RiUkWwOqxg3TS9IHIKpCWQWVKLQuw7ezPMHuGn2sw
Message-ID: <CADucPGTnQdxsGDkpyfnGUvqWu6Y6Ph_NbAgP4D3=__OpNiJ0Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/cxl: fix OOB read in Get Log command due to
 incorrect pointer arithmetic
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, jic23@kernel.org, 
 berrange@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=aaron1esau@gmail.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 May 2026 17:50:22 -0400
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

Hi mjt,

I haven't contributed to qemu before. Am I responsible for anything
beyond submitting the patch here, to get this merged into master?

- Aaron

On Wed, May 13, 2026 at 1:35=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 16.04.2026 23:07, Aaron Esau wrote:
> > From: Aaron Esau <aaron1esau@gmail.com>
> >
> > The memmove in cmd_logs_get_log() uses cci->cel_log + get_log->offset,
> > which performs pointer arithmetic in units of sizeof(struct cel_log)
> > (4 bytes per element). However, per CXL r3.1 Section 8.2.9.5.2, the
> > offset field is a byte offset into the log.
> >
> > The existing bounds check correctly treats offset as a byte value:
> >
> >      (uint64_t)get_log->offset + get_log->length >=3D sizeof(cci->cel_l=
og)
>
> ...
>
> Ping?
>
> Has this patchset been forgotten, or is it not needed anymore?
> If it's needed, it would be nice if it lands in the master branch
> in the next 10 days.
>
> Thanks,
>
> /mjt
>

