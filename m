Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFAC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DWm-0000zD-I5; Thu, 03 Sep 2026 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2DWl-0000xu-3F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:55:15 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2DWj-0001Yq-C4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:55:14 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-87005a0e052so3538257b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788465312; cv=none;
 d=google.com; s=arc-20260327;
 b=Zdl2Omy62OPI84mna2jJeWSs4wr7VjRs8NJ2iMGbsViugYo3iSLgq447Ishdw3ndce
 CbJLrkJ1jbHFS5pJm34+tdQCrDvOlX1BIECgOJru6YmdAtesOfCRZlxyVREY2bQG+4M+
 QelaLt9bRqcNcuKq4620Cg96M9zZIaptlEBXPiP0nkTz8lVogQ7qEPKnj3a9o21Pr3nm
 J0dUGltrz94dwtKPj5HKw++J1hbeJdo+LPXLApm7IIuElnI0Iv3/r+LmCdHBriKSreH6
 jk6xulZRRUY4ANi2ipdYsYTHNcsefzWZhKowVRJ5HXqY3VZ251uiGYfRe6qFLnU7iPkG
 sOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GX528+WCw4LNn2zEBKUrKUMSof0XetDSo8dEl6WOv1Y=;
 fh=t5yxpgBC7geaRk+OtiZTsyGh9USN0c4+Upk7fYT/iR4=;
 b=cdJUuzMfR+v0MvNTShyKjrffdHWYCMdXhsypfgscx0rkjydnbATClsdoZTkekj8bjG
 +4wAl/ruwVAu1+Kude4Gz/N4x1QwiTgxKvRWx6r3u8PWbmZyuPKQUhjjrSbCVtmyt+So
 rWsw1FLth3FRwuksmYMS7nyEpEaqi+0ZCihcgvaF4zYVMe61av5iw+j6UTMbfSwsHUFP
 zJsJHdJjMTmvFA1yW4ZXcCl1s7/gkxlnNmSnpkSQbSzxsBA5q5dPlKM/Y2FYwbSSjdn7
 rl1d8SC5Dg99hqWgMuCIpnQzbJMlMcU6Ddwj/mqGAGOtdafMoBMsncRJghGRAfLjofxf
 dGVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788465312; x=1789070112; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GX528+WCw4LNn2zEBKUrKUMSof0XetDSo8dEl6WOv1Y=;
 b=BBVKqm83Zbm+JHRFzbJ7TR2KdeRnw5Z1f0L5xni9qwMYIEpuygqdm2UMG1pSp2G3Cb
 FwvSaAZ5v53nPSUmr5aXgVjEDJx9/WdRRp/vRN9V3yJjq8DfQQzD/jronZlls4aLqlKJ
 6BcYM0e2sC1oUORob5u+67cXu8+Y/8OK0PwZwrEU2RuKWxCSrG4VwJBz0eNAQM8u+H2d
 harKO1uWR6VhMIYBQHTx6WpzdUqDumoU0jP3gzyEfJY25N8PoWDMqzGW518iaQY1klGq
 oGuK/0Cs0INxp5VXK5t2QO83zMvSw9hnUMTF+Y6zsiH3xCFawAIXAisaFiP4NRaczUd+
 eWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788465312; x=1789070112;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GX528+WCw4LNn2zEBKUrKUMSof0XetDSo8dEl6WOv1Y=;
 b=eB0REqsoRgO5RIpOEZ/RYX1RlON3sbcJ8Xdj88PHKFHul0vrHHqGVNQNep+j3K3waQ
 CNwwOb3fWumsHWjrm7/fEKGJe/ilZyrZmtTlXLtxSqU60WUGcRHOj1PhudkBu7y/wYy0
 GBU6RxGmjc4agrPfZ5464oIVbpmj4wkORzxf4O0S0KJLXBRCMEf8IQO5dk8lAFTxM1eA
 h9kJscbtYVEzL5iY6Uex67Tlb2IXYtMebj6kjJLyZRgH/9zrwNfjq/zUIWu8muz5qRHq
 fDsnuGJEzQVKf4jxM5xa8SnSmeDQw7hO7//3F02iOMfwkfW9/BW9xgIUwrKJF/gacFOO
 VM1w==
X-Gm-Message-State: AFuF++lVoZFFyaAT5leD80KoaE6V0GtTSaJDvCBWiG6Mo9fy90C0L9Jx
 YlBYQTZvN3upwNAzgbTXAutVuWXcgcCs18tQBLXi798Rs0NZ5x70LJmT6j/Thst+IoKltzBJjbV
 VdbkOuJY/SC5jkHyhsgKrjGe9XM752VIqa2RQ1OVlPQ==
X-Gm-Gg: AYBFou2KLd9Lw34jlx8Q6hxNlUaAHj4l81U3tRqYGQLbZJl67+yzrWg91SEvD9hcpU9
 LuzLNyDoKipR2l9qxWgGJ+xG5FdeivFobvufsOZ9V9PZAWkLzoflYE8PerkXQaTRx0W8+dGxcdG
 zq6quoBUbn+V1MMZ93V41tO7LYaj1i6bTsPwXGik1UKMSaY9OayuPOhw0h0eLqiwGZ+AhqvlyGv
 K43T1WQyvfFB1aIrOGAoQVo78MvSSEmrrsQc1OGupFbqbRlr5Ax5XEcNQuwW0lQ8YI5kKVND0F5
 x4F+T3fLFOxPzUKnI8Vw3nrDfG4sum2g3VLEJSVrIS7OPtrg/Rm2w1c/E7MBbgPDdc5OtjV1Low
 achfQrjRUdvD2y9kMGjj4x7V1BukI
X-Received: by 2002:a05:690c:9e:b0:870:8e6e:307e with SMTP id
 00721157ae682-87125c157c0mr6739227b3.17.1788465311842; Thu, 03 Sep 2026
 12:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
 <20260902044231.843004-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260902044231.843004-10-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 20:55:00 +0100
X-Gm-Features: AcwNN1VXLL_f20c2UT4J3BdoDNwOjzhBQwUzmrFzmvUehP2BoGF27fc0_1YZQpI
Message-ID: <CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com>
Subject: Re: [PULL 09/28] target/hexagon: add main arch-specific semihosting
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 2 Sept 2026 at 05:43, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>
> The Hexagon semihosting ABI extends the arm-compatible set with
> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
> that baremetal programs using the standard Hexagon simulator ABI can
> perform file I/O when running on qemu-system-hexagon.

Hi; Coverity points out an issue in the filename buffer handling
in this code.

> -    /* TODO: implement other hexagon-specific semihosting calls */
> +    case HEX_SYS_OPEN:
> +    {
> +        char filename[BUFSIZ];
> +        target_ulong physical_filename_addr;
> +        unsigned int filemode;
> +        int length;
> +        int real_openmode;
> +        int ret, err = 0;
> +        int i = 0;
> +
> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
> +        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
> +        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
> +
> +        if (length >= BUFSIZ) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: filename too large (%d)\n",
> +                          __func__, length);
> +            common_semi_cb(cs, -1, ENAMETOOLONG);
> +            break;
> +        }
> +
> +        do {
> +            hexagon_read_memory(env, physical_filename_addr + i, 1,
> +                                &filename[i], retaddr);
> +            i++;
> +        } while (filename[i - 1]);

Coverity didn't notice this one, but I did. We read into a local
buffer from guest memory, so we can't trust that the guest actually
put a NUL byte terminator in. If it doesn't, then we'll happily
keep loading from guest memory and overflow the filename[] array.
This needs a termination check involving sizeof(filename).

> +    case HEX_SYS_STAT:
> +    case HEX_SYS_FSTAT:
> +    {
> +        struct stat st_buf;
> +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
> +        int rc, err = 0;
> +        char filename[BUFSIZ];
> +        target_ulong physical_filename_addr;
> +        target_ulong statBufferAddr;
> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
> +
> +        if (what_swi == HEX_SYS_STAT) {
> +            int i = 0;
> +            do {
> +                hexagon_read_memory(env, physical_filename_addr + i, 1,
> +                                    &filename[i], retaddr);
> +                i++;
> +            } while ((i < BUFSIZ) && filename[i - 1]);

This one does have a check on BUFSIZ, but if we terminate the
loop because of that then filename[] won't be NUL terminated
and stat() might blow up when we pass it.

> +            rc = stat(filename, &st_buf);
> +            err = errno;

> +    case HEX_SYS_ACCESS:
> +    {
> +        char filename[BUFSIZ];
> +        uint32_t FileNameAddr;
> +        uint32_t BufferMode;
> +        int rc;
> +
> +        int i = 0;
> +
> +        hexagon_read_memory(env, swi_info, 4, &FileNameAddr, retaddr);
> +        do {
> +            hexagon_read_memory(env, FileNameAddr + i, 1, &filename[i],
> +                                retaddr);
> +            i++;
> +        } while ((i < BUFSIZ) && (filename[i - 1]));
> +        filename[i] = 0;

This one is wrong in yet a third way: we do check against
BUFSIZ, and we try to add in a possible missing NUL terminator,
but if we stopped the loop because i == BUFSIZ, then we will
write the NUL terminator off the end of the array.
(This is the one Coverity found: CID 1685942.)

Better still, can't we use the lock_user_string() handling that
the common-semihosting code does? That avoids all this need
for tedious manual byte-at-a-time looping and fixed sized buffers
and potential for bugs.

thanks
-- PMM

