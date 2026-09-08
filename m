Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65934C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sXH-0008Fq-W1; Tue, 08 Sep 2026 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3sXF-0008Ff-LJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:54:37 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3sXE-0003Ah-5d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:54:37 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66e611e7c05so3166472d50.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788861275; cv=none;
 d=google.com; s=arc-20260327;
 b=n0zdXYdciOgrtw4djkwIXcS5DQjtGzRwApyk3PL0m5GF6EhlzdQtQEzHzeUg/0b7t5
 7PhcWXjvo9g6gfL4Zd8lbef1TnhCFGqXNhaCWoL6M1FZJInKJ26AZd4fPuuNaJ4g7pf6
 ROeWv1cdZ7s/lSWQpd5KxMWxoph3MtsCvXMlQtFfEQrx3MavQDw06jL2+UtVucto4bSI
 byMTaJK0UhUh4ewlXBmycQiJramht5C7Y9Co2Ss0shG2lXFM8wRjcPmPfoLhMjKtL8pH
 C4FLCMFECBPYsGeGGuPmLSgX5zibYx3lfUX1Mmgnz/rqRuG1Ybjnse8UGu4lfPqDZyaD
 tJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jr7cM+KAWmTxu8hsaiknku2O1wvoAa7r9/msiMS3iRc=;
 fh=JD9EfOa/V7/8s41UybzBVsujwUWftQ0LytYkunVKnf8=;
 b=NHWRz2ifaq90o09bdQNu6l4+MxhY7ouw0l7MfAqUIZGm0yz82h34+pSRoFFk+10+Lt
 c9FwTEUe/9h9+MqX040HXZN0h6S/hW++IaF5j+S5Zok6r1GclHDx2z54WDLMgutqiYdc
 r3XQCGfmkMuWQpIDrtinsQj9cHqz8ISXQvHgVrlowyAsmNIZ+c/RJVexrY4BvSiDjIIC
 8TkWO+uqGJThOrrVDAnMejet+S6JE1MsIaLF/hZSs2G1MaKKoWgS2S8PALsKehgJL7hR
 lmqH733RWhYZT/t68D5c/3BDLWVSyfkBIKYTxbDCKoNCZBWCGgkt+qe7iuL670apIxts
 BImg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788861275; x=1789466075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jr7cM+KAWmTxu8hsaiknku2O1wvoAa7r9/msiMS3iRc=;
 b=XMayApsUL8OL+04l9hHHkPqEDbsSr9lbBaidxFunkwo7aBQMtrwpa48aRURnCgZkzV
 stDyD4jqUiGmfAZkKeZ704z++VPCXGrmfQL14wXTXQ1t3gs14+a7L1rKGn0WQ12qlgJ8
 QOqc3zdNoJAaa10pPgbEd7kNl8TUc/8Wws597OusKVgBM0MYAM1vblq/rmwtjCqNvMbS
 efQCBzF9x1zQaTlyiuMIgMKGSxWwGzIu5d65ZkT73C/zp4h0kfXF49XWT9lBf2v3MTdB
 dy0ec2zjeaGKF4V29wJCq1wyp21XMYcgGmj1qWXCQLTe+O62GvapZ1DIlIynGkdu1g3X
 rUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788861275; x=1789466075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jr7cM+KAWmTxu8hsaiknku2O1wvoAa7r9/msiMS3iRc=;
 b=gI1A0++Wgr/FVcOKUTXHIkDvlrX/nXaQS+X+eMX66zpRN4nvnpDA4qIRZVAL/f8jCM
 jiBFi4vY3eaNEp/KquPjEQG0VB3xWCyAJfzPd/SHsXNKsaCTB7xOOZZ1Ly3O30pu7bae
 r8gJEz7ccEb8lfQX4LTh7YSM0GJLk8gIobY7Knjjk0WbRg5Gx7ec6zEoKtvE5VDujxa3
 psvsw8U9TCxC67XUT9OxwAQSw87hY2ONDoR0PWzHa0fqfWFsy0m3L4Ibaila9CHeHETn
 xo6Avc+qyYOieH25ZcUv1Qj07kM1qFYAtlAV7IAu9aBBbVnsillZKs/XDfkIZj52ISzt
 53OQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLhk0JgK8FLowwfmafFE74juXwSiFUddmo2HiXuoWK9yCrThYZ3JhpubQ9drqkA2G9SdG6YZh1sBC7@nongnu.org
X-Gm-Message-State: AFuF++lj9B+/jL5sGGl3LZVzEQIf13k1OQ2Wsd+8oDuby+j2OapULypo
 RFcQmMTrV3JHWDAQoXBzpkwrDWjIJAPTEvftcV1HcLo1FB35MzMr71mbEY/6q4pwhW90f+tKPSk
 tE64+3OxN17bEYW8DBssaEmaXYEczdYnr8AufpcNlew==
X-Gm-Gg: AYBFou1CV6qIs5Meki4e0vG/bBH9Ng95CSBlOJl/l5m6cJUdExlUPGwjyQce0+iwguH
 dPiEBW4+m2IfEaiKI9FWJpttOZG2rMaOFMLbWeSndPKdFQR5S59Bsv9XUZgcl3qszY/cyTfCwvI
 WuVZdXxIDyCpeF/X+2CI/92qgK+edZUUiSj0MGSFTbnETwImDP4lWBDRTrzz2qW/mlYfIROj9h4
 Bld6lRS6/vDuPOX7r50b1C+HvoHz+WZ/XHndxcMM2TWmCggJYyzdsWYxk9WWu51Z73w1jjeaV6Z
 0wsojDOU5IJIPFm27+M0/EsMt0653LvJD3TYD+zJOxJEIFwPpVnkv+rT0YKssaUfcykdHEeJNX8
 oMLvE6bXK+DzaD9NoB9DsZ9jDWyAy
X-Received: by 2002:a05:690e:b47:b0:66f:b219:9ed8 with SMTP id
 956f58d0204a3-66fc1b95b33mr6827139d50.23.1788861274740; Tue, 08 Sep 2026
 02:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
 <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
 <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
 <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
 <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
In-Reply-To: <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 10:54:23 +0100
X-Gm-Features: AcwNN1X4pI5pEHppN0BrhSOQnBCj-un_kMnHniThDIL7_IyiGTDTk5QQf8VVdq8
Message-ID: <CAFEAcA9mvz4U1v49-Pt20+Zw4LUsaVrOW3LuL0xhT-xHEuM_sA@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Tue, 8 Sept 2026 at 10:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Sep 8, 2026 at 10:40=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Ah, so it is called without the BQL held? That's quite unusual
> > for CPU methods, so we should clearly document that.
>
> I agree.
>
> > I bet also that most targets don't expect it. Picking one at
> > random, the sparc has_work function calls e.g. cpu_interrupts_enabled()
> > which does not look like a function that is expecting to be called
> > without the BQL.
>
> Why? It only accesses fields for the local CPU. The problem is
> interprocedural communication, and only if it does not use
> cpu_interrupt().

Mmm, I guess this is OK: actual TCG code execution also accesses
local CPU fields with the BQL not held, and if we're definitely
always on the local vcpu thread when we call has_work then
this is more or less the same thing. Doing anything more complicated
than "we hold a lock" for thread-safety makes me nervous, is all :-)

-- PMM

