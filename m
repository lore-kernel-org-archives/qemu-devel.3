Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA8C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 12:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvc65-00053w-UP; Sat, 13 Apr 2024 08:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rvc64-00053e-E8
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 08:03:04 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rvc62-0007OK-TU
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 08:03:04 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5aa1e9527d1so1236140eaf.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713009781; x=1713614581; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KT5hlACcL3mhAInSN9kKB7k4XZ6msNdh1OTTC3ApY9c=;
 b=EVOZMQwz6+ODXAq4ddejoegzHhR2xpJXz3lx2wh3F9nSyYjIsDybpFbTmccB/lZ6pM
 /i5axSKh2IX0WtxFc3ATjGfMocKV+ZkgU/KZ6UajzomDf35D2wkCG6OKtL4cwvafKzAY
 moPnqePVlBw8fEUs1CLu+bbmNlpiw7u1FGAeN4lHQVsKeLVCiKQ2er/PeDSRQk8qhaS/
 qTbTvkxvNSl3BdIZrL+4ToEtWpHx1j9pCONS157Jb066tv3AIaWtyZdZPRd9IShRrF44
 JGD4lfXoMu9mc4QiS3SmlmdHXLKivgzhXCUhNHHxcnzEXC/Amfl2CKb4b2+A+YD+MBLK
 3CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713009781; x=1713614581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT5hlACcL3mhAInSN9kKB7k4XZ6msNdh1OTTC3ApY9c=;
 b=A5O2qTaNfj+zepMTEgssKLZIll7cHudJjDO3vohXSxyWjSoaj58FJ80zDXXlRnQo6z
 9oD0JOJdWQ+TzU1Ifeds100JMakNliIAqBq9g0XMDehtxK+Q256gCC7TZ31NMT5ZaXB5
 uFq6OvDt0NMbVfXH0VnvbmxYsd4yolBd61CxKSs3b05cn9NNLIvRQqeob3pcydeK5qL2
 iIFOvPklKoymWVy/emfot1Zv5eA7G5STZM1sJqM1eWh92yzyAlh8d93u3O1TkUkR/dYn
 tQlPDQg8DIKQLG2QP12lqkcZssYdiuP1HXEjyNcVEiJYsRu/ZBgJ+zw/8ZsJR+nXOCfm
 Wj5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVDOCXSb63XE1HIitYM7/Ij8BNlaRY7nps99kl6aDcgSWHRuApAaShTq59C+Mwr5sfPmbWBBtzCHJvMBYJZ1ktBLwJfT8=
X-Gm-Message-State: AOJu0YwoC8AjVhDQRQu/Ls7frSFjOtRnbgVb86ageDPMpy7gYRTQ3Stj
 jFmIp4v9MqX1UbXFnwv5+hqKI+zRlqPKyK8K6AW4ggosOCrSiq+NceHYl1sqSX2ccL+11WL0k3P
 FJz6f/3np+5C0kf+cZGoyWGWCqEk=
X-Google-Smtp-Source: AGHT+IGmVlLRCDItykaxcw2B2K7esQlr2nBc9ltEwdPYYhLt1Vwrlj1BYoqZZPT8nvvuFyyYeWRWXQzME+LkuVeVyVw=
X-Received: by 2002:a05:6870:f613:b0:22e:caed:bc2 with SMTP id
 ek19-20020a056870f61300b0022ecaed0bc2mr5954831oab.8.1713009781043; Sat, 13
 Apr 2024 05:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-4-richard.henderson@linaro.org>
 <698cc16f-cfb4-47a8-86fe-e4c8a6faecb6@linaro.org>
 <738c7ce6-7c09-45fd-ba00-d3f74e1812b2@linaro.org>
 <41518f9c-2e29-4d24-806e-b89e5d4ab278@linaro.org>
In-Reply-To: <41518f9c-2e29-4d24-806e-b89e5d4ab278@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 13 Apr 2024 08:02:48 -0400
Message-ID: <CAJSP0QWSsV6reYfC1bPDMb83QYtWsWgZLH=e1CdSszhy7ADXgQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/27] util/hexdump: Use a GString for qemu_hexdump_line
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Sat, 13 Apr 2024 at 05:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 12/4/24 20:59, Richard Henderson wrote:
> > On 4/12/24 10:41, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> -void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
> >>> +GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t le=
n)
> >>>   {
> >>> -    const char *buf =3D bufptr;
> >>> -    int i, c;
> >>> +    const uint8_t *buf =3D vbuf;
> >>> +    size_t i;
> >>> -    if (len > QEMU_HEXDUMP_LINE_BYTES) {
> >>> -        len =3D QEMU_HEXDUMP_LINE_BYTES;
> >>> +    if (str =3D=3D NULL) {
> >>> +        /* Estimate the length of the output to avoid reallocs. */
> >>> +        i =3D len * 3 + len / 4;
> >>> +        str =3D g_string_sized_new(i + 1);
> >>>       }
> >>
> >> [*]
> >>           else {
> >>             g_string_truncate(str, 0);
> >>           }
> >>
> > ...
> >>> @@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void
> >>> *bufptr, size_t len)
> >>>       *line =3D '\0';
> >>>   }
> >>> +#define QEMU_HEXDUMP_LINE_BYTES 16
> >>>   #define QEMU_HEXDUMP_LINE_WIDTH \
> >>>       (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
> >>>   void qemu_hexdump(FILE *fp, const char *prefix,
> >>>                     const void *bufptr, size_t size)
> >>>   {
> >>> -    char line[QEMU_HEXDUMP_LINE_LEN];
> >>> +    g_autoptr(GString) str =3D
> >>> g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
> >>>       char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
> >>>       size_t b, len;
> >>>       for (b =3D 0; b < size; b +=3D len) {
> >>>           len =3D MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
> >>> -        qemu_hexdump_line(line, bufptr + b, len);
> >>> +        g_string_truncate(str, 0);
> >>
> >> Shouldn't we truncate in [*] ?
> >
> > The usage in tpm puts several lines together in one string,
> > adding \n in between, for output in one go.
>
> I see the trace_tpm_util_show_buffer() call. However this
> isn't a recommended use of the tracing API (Cc'ing Stefan).
> It breaks the "log" backend output, and is sub-optimal for
> all other backends.
>
> IMHO the TPM buffer should be traced by multiple calls of
> (offset, hexbuf) instead.

I think so too.

Stefan

