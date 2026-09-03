Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9417C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27X7-0007K7-Uy; Thu, 03 Sep 2026 09:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x27X6-0007IJ-71
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:31:12 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x27X4-0003ar-6X
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:31:11 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81f3b227a4aso33746427b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442269; cv=none;
 d=google.com; s=arc-20260327;
 b=k88iEKw965PGolLPUQO4nNLqwmoTSONJablNU1dja2QNzHeBVVB+5BI6Cb4qBjL928
 Z35CVYWYd68HCHTgtQdutVGQ59kxEQhcTPGYg7TkJRC66EROsMpO2u5ANhqFTeYyYG52
 osIGlZ2p4ueOFjQYNr+gKfmxxhEZC+wO10vxCSdyimvHI0s9WD85x/mNmIEcBabVcbk+
 kBKxBubvAwJHNCUSEYVpPfk84PGrRYpcZrKCaPDvaxl2ZYEP4iOV3HcDhue03JR6vREV
 njjwO7vVMkY3uLPtjXXrDRRIrg4ceRLXSBf7PU0HZkjoyJYhUIDDRjOYovMgpxrjDsHF
 Bi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YqeZztMOKco+DFX/y3p5AGARDFmOFBxKqhco5v8whLQ=;
 fh=3SYEFM2DFW8l/P9wfc5zIYNPSbvQFQx7YcwttlvIrYs=;
 b=TWphI9sjVpOuU8zApaj+QBOtIzCOwyAoh59jAnCwRCLKcaRzQtHBEkOwXi3WJ9aPVw
 rd7RilL2uHvmXlJ2DyTpsAwpO+9N0wPzG9l8l3Fdse/fmnhZdgroUHYhqDhPP/bZUoBm
 iC8IR83u482rtZGaNczCZ/jEv7QKlawFle0P/6vK5VxunP+hp3NOByv1EHHl/MU6cCPg
 os6nvlfsFp0xrVGDBWORJbTGory/VrYA0P4AOUmRd2WAT4Xedsp5SxAsAnHqzv5NKSAc
 l5ULYg5keHRciOj+3XtxmBhGfyf74LYx6rajKbFYtVEiH3rgYUXqAyOMOQyFAI6lzDjL
 X4UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788442269; x=1789047069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YqeZztMOKco+DFX/y3p5AGARDFmOFBxKqhco5v8whLQ=;
 b=OOdz8KwqtLpLQIsl1nKdRiJ3NbEXT+CKNXtdeFSP4iRtb6hk66ZWZ/XfamKFxD+x39
 I8VF0uZt4cpZdBd8Oc0kRWj2Rcg0ifKWLpzBV5Aa+6g7hIYTAo2Rwb+3UtA6hdhOMdru
 Sz34foFZ0jdvmXRBeYnKnj3UQoXry9AF/ReDD69gC3gUoimiryvqMKMOIfM9UUyjz6IH
 PG5kwrkaM8Idax3N6uz+haxiPE06y4WKnny1xNq+FnCR35p0nieWB85R5m2CwLvtoeai
 t4ZFzb4+n3/eeN+gQ+npytO+39UP1dVw7B253FTpMTzztgwztd70mWrbEsbNVtLvZ9ik
 T3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442269; x=1789047069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqeZztMOKco+DFX/y3p5AGARDFmOFBxKqhco5v8whLQ=;
 b=OSc/dZ8FQP+dL+4+qQtRT54rF4/h+BzNi/pysyV8fuiwA2njItxDctRpQDHE+u3rtO
 U9q/JMtrx9gNvhy5PzajiRQV/rJdxJL9f4/WA852ZJAfv5Ak/7hRZ6TNUT83yTZaAVhi
 rlKodVZ+tx0nERXr5BX6EuZSk03BY4RIHZJLMbPnioPtg20heyL+BAPxQR0rJmsJF1YE
 vxM3GZub0txYdzPmZN1qzgWjtyTF7S3kT99BdGqGzQFZNKlf4m+pS2WX2ev4SQvoiIXb
 ugPJowmJcHXwy3URIrvXMPbU8gD+fwgJkoZ8qmkNc3FFS8qpMAcYRwFU0RnP/PlaOcV2
 a3iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqM2FycPc9PfKdxIYWdYpWgwDM9VqnHfujNHWJp6AfdMXXU6KfJJ3lMxMH/VR3waOevp1zcpVnZRZr@nongnu.org
X-Gm-Message-State: AFuF++lcI2SD1D+n8Uw6Q8gbVKfwA3P7D+bizaewtVBmngtrWD+4ae0v
 DvFcHz+gdPJ0LaqDhQdTFQIh2ilkm1Esks2PRkbjYGW1bXlzZqEMWWqoxQKrjU6H68y6tIgGusC
 J90xl7xYttu5o2Qts69uUWEq5OeoVlzXDiCGrfBArpgO+4jiYNYyEeM4=
X-Gm-Gg: AYBFou3AmBVxX6GOCc/zhPPmu2DC8QR0d99adlXXl2LslzqVX+k2B2ZRHWPiws4Ravm
 oibCrTnLW8OJ6l/xQxaINgaRKCf+Jvu3A03TmrWROd7vsMGvTDNefgXvOYggF10u4w4JfD1PZHy
 7leeHhEJCswPwH8BR7Jb3thQC6x/4vY4vi96qRQi2pVS/jzcYD+GtBwbyLdcWWzCRprhA8JZrGt
 /umhcL0xJkotnJHOpHvWMe2sKfxXZJav5dvlKOcjOitEsa5C4qajRhIEOaYtRpH6NeB+6s3obVn
 vHqMzSApKkRZLqm43Ytni0xB0UNvB5OWrS8PmPWJcQfJxJZs3B/amXA4WdCW0L6NfQ/dJkIzGi4
 +kH0W34RFOcNB0YvWZIumwwQRdNKc
X-Received: by 2002:a05:690c:a4c5:b0:854:b29d:c670 with SMTP id
 00721157ae682-86c4e3f7510mr48186867b3.5.1788442268649; Thu, 03 Sep 2026
 06:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260903100441.781277-1-pbonzini@redhat.com>
 <824e8ec3-f45e-475b-8fb4-93f2257d20ea@oss.qualcomm.com>
In-Reply-To: <824e8ec3-f45e-475b-8fb4-93f2257d20ea@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 14:30:57 +0100
X-Gm-Features: AcwNN1Xu9W85SEtbjoTq9nFgp6_Al8Owgkq8M4iefn5JlVfAhyx-GfrRszHA150
Message-ID: <CAFEAcA_9p90-VbETCRHX-qrpE3fvoY=c5ittevti-6-kgLdsTQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 3 Sept 2026 at 13:15, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/9/26 12:04, Paolo Bonzini wrote:
> > The QEMU community has broad consent to not accept assisted-by and simi=
lar
> > trailers, and much less fake co-authored-bys, independent of any AI pol=
icy.
> > Implement this in checkpatch.pl already, so that there is another way f=
or
> > contributors to discover the AI policy.

> > +# Reject trailers that credit an AI agent.
> > +             if ($realfile =3D~ /^$/ &&
> > +                 ($line =3D~ /=F0=9F=A4=96/ ||
>
> Few years ago Peter was concerned about using non-ASCII because
> it was not displaying correctly on his terminal:
> https://lore.kernel.org/qemu-devel/CAFEAcA-CJwcE9k+TqQ-vDrevzZPV_+CXAr1j9=
QfR_ivJTJ3e2w@mail.gmail.com/
> (that was using Ubuntu 22.04 which we don't support anymore).
> Should we still worry about non-ASCII in the repository? Having
> a quick look at the OS versions we support it seems all of them
> are ready to handle UTF-8 chars. Anyway I saw various utf-8
> emoji symbols in gitlab issues, and it is likely someone will
> paste one along with the report when filling commit description
> for a fix, so they'll end up displayed in a terminal via git-log.

An emoji in checkpatch because we're specifically looking for it
is probably be fine. Though I guess it's implicitly assuming the
user's locale is UTF-8, which I'm not sure it will be. We seem tu
use \xNN escape sequences elsewhere in this script where we
need to look for oddball non-ASCII, and that would be safer I guess.

In the thread above I was mostly pushing back because that
was a suggestion of using an emoji in *an executable filename*,
which is going to be exposed to many more people than a string
in a script to be run by developers.

thanks
-- PMM

