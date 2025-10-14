Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80242CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aWu-0008Tx-41; Tue, 14 Oct 2025 04:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8aWs-0008Tp-UF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:37:10 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8aWq-0005Ri-NE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:37:10 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-77f9fb2d9c5so45014217b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760431023; x=1761035823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G2wXHawLphgjXMKUIBlNV42EVOVQetLfGGTkt4o3IG0=;
 b=lX8oz2bzDkQTEuC+r6ZWKoyeJswSjYjVmyjV0NfgKWmfeQpagJ1DdvN3/tKiaKXTIn
 6pIvtBdAN8okJT7F9ekT31drRC/QA7MCHpMbElLP2gzvY5Pbo/PHZsw9pD/NfFbcXH7j
 sBDGL+OZ+h47ucsREL2i6ZWf0eKmDi1xaYMTdmOMmT34AUAAbAi2TgayYF7fMDU118qa
 +vNaApA0Gjb4k4KVb6ydk8EAsRYnH1kHkpNEsZelb9F4kZZMCLUUkzOlMXiHkVJz0LX6
 VxTkCZ7fuvXJFF2e3jkZX6incEsa/0Nse2JrQJRqO1UzEUPVeyIRaRZi2SSsXNkg4zHy
 5mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760431023; x=1761035823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2wXHawLphgjXMKUIBlNV42EVOVQetLfGGTkt4o3IG0=;
 b=lgkRhP92uPXs1NEiQyNnT6Ns/comNQkfHAsUbe3E3eIjlFw/SB1puOBeKoXxc0mgiK
 cTlgK269EAfls8vx9VjWd6YKi0n6qnlpCp8k1MDM8nLeVL1gaq8rjpLUn5EkFtwCq+HD
 e89xKQDWPSLIoAb+JFxFGcm/1xecS2YF2pv+AXKGKoNjPd4+QXv+wNTkKV0f+m2Gaa5F
 7Gl7rzCPAxUuOtQOh6KvTCcjPSJoxRYLfsRvVHXzwAdxvVeehwd1o7DXRxJgFr9wKIwS
 S+cdcyG+M7IWQblAHmPa1TkW6lW4tgdyCNsgSCdg/MdBzSQ6//ZH4DB2dY+v8RNbDIZ+
 29kg==
X-Gm-Message-State: AOJu0YyvPRGhPPtFb51lw7lO84QBEauHri/dnS8lQlwwXDlp+P7KRXo4
 P9niPwlVSssNf4MBDPkRUllIPcuH4gfN0QS1sfyWdS3lBDydS3bejlY7MtBK+sThE3GNn/vrbWO
 t3QDlK9L+s3m62JNXJ9kPKtuxCyjYEPIK08v7lqwhsw==
X-Gm-Gg: ASbGnctkNpk1k7UPnh7EtnOmcHHnfPSQ7WBfeqOo/PzqkfxoZ67TD1K9k5NIahno9Jy
 wNjSCwLW3hzrZCduTzYN9FICRK7hmgY9M/RKAAzFNv/EAZgPKuulPvP6g6IXVp/66oOOIR3y9By
 U+DKQ+hqMMEyu3z+JrRqCwsVr2OjZDmSW8eUjFDMdAkhylUCK1KTEFEkm/Fa0gpRJbdovfHKC6w
 K+AuOqPmlnz2VuY1s8ZpdlIXvi+gu8=
X-Google-Smtp-Source: AGHT+IECuBWW7Mr3bdnefo9hCmYHcFbwqlQRLyVDhb767ve9pQExfrgwAwUBBTHQcYKoTbM+UVDSaLdeF/fMGFZKDEA=
X-Received: by 2002:a53:ea51:0:b0:63c:da95:21c7 with SMTP id
 956f58d0204a3-63cda9524edmr14064490d50.48.1760431023344; Tue, 14 Oct 2025
 01:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250729111226.3627499-1-armbru@redhat.com>
In-Reply-To: <20250729111226.3627499-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 09:36:51 +0100
X-Gm-Features: AS18NWDdnneHmaeFVDUQFGdg-xa0DZiF63LABZFsNDGIwihe3MoHxpb_nMM5usM
Message-ID: <CAFEAcA-UrCD7mrmX_4dCK0urMmY5+qs=Y268WerQVq1c+7nB=Q@mail.gmail.com>
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 29 Jul 2025 at 12:14, Markus Armbruster <armbru@redhat.com> wrote:
>
> xenfb_mouse_event() has a switch statement whose controlling
> expression move->axis is an enum InputAxis.  The enum values are
> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
> case for both axes.  In addition, it has an unreachable default label.
> This convinces Coverity that move->axis can be greater than 1.  It
> duly reports a buffer overrun when it is used to subscript an array
> with two elements.

I think also that Coverity gets confused by QAPI's convention
in generated code of defining enumerations like this:

typedef enum InputAxis {
    INPUT_AXIS_X,
    INPUT_AXIS_Y,
    INPUT_AXIS__MAX,
} InputAxis;

Coverity thinks that INPUT_AXIS__MAX might be a valid
value it can see in move->axis, because we defined the
enum that way.

In theory I suppose that since the __MAX value is only
there to be an array or enumeration bound that we could
emit code that #defines it rather than making it part
of the enum.

thanks
-- PMM

