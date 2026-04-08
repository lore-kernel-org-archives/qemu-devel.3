Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcG-0005k9-Ka; Wed, 08 Apr 2026 15:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAYAE-00011E-M1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAXS9-0001EN-4U
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:16:38 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so37799d50.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672196; cv=none;
 d=google.com; s=arc-20240605;
 b=F4JwIfIFEMlve0oYqXNo7jf9sMrHefZkD2t9xbAmCLD4v/X/4hzWBhvbVPO+9vmgyV
 YlEPujlaHjGcQNCIHR4+KrJziGXXIcqAW4efuGtmTvPJsgxFTpXCJbs+iJ5+yfIXzn+G
 rATl5r8qCotiZdu0HllTWtjBA3VXcdqmcXK9E4iV8vSNkYfIuX9PfGkswFCxr0YGzZpq
 RtjIU8m3ZvKOPh72svZNOGc+EtVwbSiu2q9knx7dt0ySX+a8A6v+sT8iu7Kx41Di96zr
 L/+3P+XlV97SxiqlPfPF5TYFhd8FAhIF6tZKQCHNYYlhZpUBLt6grEWzJN5ugENgC0j9
 bFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6kTbeGa/clPqmvVjSOI31yqD62ciz+XvmD/PJQjLDnY=;
 fh=D0886OQT3U9WEUIwxipNu7a8Ru+zpuuSncWDB1+vPmY=;
 b=BSZZZ+LaYveNwhHNuJKEGioqUb4TJCjFoQ0vgdvG+oiKw6miW+xl/rk7jZ3AXNYUcf
 Wth81PPdyaozSLoDZu7KXEXSkmZ+3IpvYQbN9vqNcpjeuloYLSd9ucWdyNp0UYMSniVk
 cesbZ1E1J6f4j6VzWPQ3PSGLatTCIi626Sg7lRUtTwNoeC+HX9A6tw4KwThW/2K46YcX
 AIVByDzfI3+xJh87Gvencrgg9exmoX/oep0k+7/KhuIoIZuyEy7gCo2Kh8kkvDReo3xD
 NkYvxX2fIxCzkojJdmdLlO6MY5CesMsOQ+fmQj1vRyFkxr7MaKMPi1XvXOrgUPTA+npX
 4JtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775672196; x=1776276996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kTbeGa/clPqmvVjSOI31yqD62ciz+XvmD/PJQjLDnY=;
 b=YTC2S/qLjFpP8JdNHZgQb+OQHACz6Z+7MDwULx3LMsWIdzv48KYUz13IbndQYR1tnh
 CbGU8wz3gCE5FQ2une84vJPCk7WGHESi25jGm7YBKuQE7zAupiSgZ057n7YZvbktyB12
 9C9i2Z+aGgJ14ACJS454MjVz291Hk9Ntnvqqy7YczqBoHxq2aGa24bp/Kwxoalnu03+E
 AWVofPgJdFRyQk2MstUDRFVSuh5CWZEiHrIZtA4hSvASjv4IqmUlRapuktih2k65EV/u
 UIIWML3Ahjk5BL7CJIgRar6yJhIlwrEOfxksOpJZz+kTVfqn3Ud3VtYpBmW0fkCYfTMX
 eCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672196; x=1776276996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6kTbeGa/clPqmvVjSOI31yqD62ciz+XvmD/PJQjLDnY=;
 b=Ro/Y5Wh1F+/6Rdat2lA9zIAQBYPU9c7rvc6zXJ22PHhLH5YEacOfTR5UVOpNbm7XwL
 dNVIb95lkrEAuZpnbNQpnRpt3JgBTnJbbpolYZfr1B9E+AUKmIJCuCFTNOay9Q4GgxWs
 FwQsytLUUObr6kz9dWFcsspxNWnZ6SzRdRcRNObyebLVIvUn8TWaqhgnVNTENwmpJP96
 EbAM7UKiSk0NQN8Yjkcsz916l+FeDs32AJ5Fsd1CdArTJwMErflhcBuYwSE926l+fsHb
 cg2uhz17dN9dLA8GClBXMkTWmAPGBWzO3APBaWlCmzR1YO2FDqmF28LrymSxUfxhNGk7
 3vYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6SdufmPotsGjm7WNREavUvqjT65+OBDggyr3jNlnQrao4x0BpzcV+4hl6WShSoRqiSmKpx9Rtq1He@nongnu.org
X-Gm-Message-State: AOJu0YxMW5RRld3fLEYQxHihMlFrBouzUKZS4OjzgnNPSBhIjM+Mgpoq
 pN1dPngQHdqTWPmALCks7ji1o27b//I9jx8KS8k4/W1U3/+hEbiqy1hZ89qiJQ4I5v3C1dD+OUz
 X/yJ890uhd1My+Iu0fRH+GAk3bKHZJoHwgBdlw3meiw==
X-Gm-Gg: AeBDietOS6/VcFMfhbuBVHMCl2v08pPPaNesXvNSMT30GnRtz7oCxAXpa2BBlwfaFRs
 mJ9h7GC/t9xkhvibwUhrrp4AXf/0njPnDl+/+m5EOf3rz3+wc5rU03ptKngxrLYAo0Sk0V4yRX5
 o4RpD/gghTWE/vCudtQAjwgj9/UicaKMEpRWzJFFCmTeIQi3QMprFze5wAodStxjmzSaetr3T7d
 2vFdt4Y71Ii+gcEfuS3jPCezMGd+1GF8JiT903zLeqMvEw0bdB0NoTFhCjoLhugNwN/Pk2een7c
 FcqCcG+L03kQUySXa0Z7hLD3bsluoBH3if12BRCjE4yB8MSzCLL7eipRHBezdI5/VItI4wfVsai
 jBw==
X-Received: by 2002:a05:690e:1588:10b0:650:14cd:6706 with SMTP id
 956f58d0204a3-650486b4c9cmr16063687d50.3.1775672195636; Wed, 08 Apr 2026
 11:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260406050454.284873-2-phind.uet@gmail.com>
 <CAJ+F1CLrs7ph8WE-xunN=xSQMYFeimfHB_F7+RxgroSdvRwyNQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLrs7ph8WE-xunN=xSQMYFeimfHB_F7+RxgroSdvRwyNQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2026 19:16:24 +0100
X-Gm-Features: AQROBzBP9Yj0DykTubh7exc5mziYw4DKKASafAHs7zyF7FspL7j0-JpdrRAqgRk
Message-ID: <CAFEAcA_r_k26SOLmDFToh-MdCMq1+SvsagC4Ngbi-QqKLoQ1Bg@mail.gmail.com>
Subject: Re: [PATCH v2] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: phind.uet@gmail.com, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 7 Apr 2026 at 20:35, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Apr 6, 2026 at 9:05=E2=80=AFAM <phind.uet@gmail.com> wrote:
> >
> > From: Nguyen Dinh Phi <phind.uet@gmail.com>
> >
> > Currently, the readline_insert_char() function is guarded by the cursor
> > position (cmd_buf_index) rather than the actual buffer fill level(cmd_b=
uf_size).
> > The current check is:
> >         if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)
> >
> > This logic is flawed because if the command buffer is full and a user m=
oves the
> > cursor backward (e.g. by sending left arrow key), cmd_buf_index can be
> > decreased without descreasing of buffer size.
> > This allow subsequent insertions to increase cmd_buf_size past its maxi=
mum
> > limit of rs->cmd_buf.
> >
> > Because in the ReadLineState struct, cmd_buf[READLINE_CMD_BUF_SIZE + 1]=
 is
> > immediately followed by the cmd_buf_index integer, once the buffer size=
 is
> > sufficiently inflated, the memmove() operation inside readline_insert_c=
har()
> > can write past the end of cmd_buf[] and overwrites cmd_buf_index itself=
.
> >
> > The subsequent line:
> >         rs->cmd_buf[rs->cmd_buf_index] =3D ch;
> >
> > then writes the input character to an address determined by the now-cor=
rupted
> > index.
> >
> > By providing a specifically crafted input sequence via HMP, this flaw c=
an be
> > used to redirect the write operation to overwrite any field within the
> > ReadLineState structure, which can lead to unpredictable behavior or
> > application crashes.
> >
> > Fix this by adding the guard to check for buffer fullness.
> >
> > Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks; this seemed worth getting into the next rc so I have applied
it directly to git.

-- PMM

