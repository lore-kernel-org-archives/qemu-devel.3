Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EA10ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67zS-0002mr-Ut; Fri, 27 Mar 2026 10:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67z2-0002bN-Nc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:16:23 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67z1-0006rf-1C
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:16:20 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so1832321d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620978; cv=none;
 d=google.com; s=arc-20240605;
 b=bqWTnGoWI90q78evV1GBqoHfmOwDSbVdwgRH4/peG55h8KnNNvaqsrYSyaBw+XkxgI
 tiioqcRSQPASeKnin3xP+FRcn8ZA0v2Sn2CwDt/OW7IGUj9SG8laW7FVnuOg/R5P5E2z
 M2aaUHF+RVyg7Wxft9xFlk1ATfUq0lro3cdjm8Ix0IZW7tzwUHiIRBfaMFMrSahYJIEx
 vK0HaUSqSTmrhdnMVm3gtA9vFEawrGkabf2fNVF6maRT/QBWo7vIGTsGcBswIKcMLpPX
 FzMG4iz3Vng4WomAjnMjIJvXPXLJZG5pJJZe0cSSSCGERPcl4Koa1xyJLqTUAS0pGAjf
 c3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 fh=KkJih4yJMFskEwiCkuik3qvXYwOpFPYevPVTcsLvDO4=;
 b=cOXP2gF6PcBoKcd1RpOiaVxrXtEzOV9KvodM2JjPUNzBErSnFxrMx8VuCKhO7Li0QL
 xzkbX/TTed7L0z6XWmMA4ZNDLwtZAhnk7P7tOc/GhnpI+ZxOq6AitR0YtCpMqZHTH0WL
 BSF5bNOjq5RI++Bd4jS9Yd3H1fR7cAK6im1YQevGD0dQkuxHdJniNjqVwnRC798Vn2kO
 T2hYOpyb8siM7EAzck4E0wJFWD2TIYe66FNy1ZpefBditrpRME2wbp8sTHE/bYWN02uR
 EqDs7NxsPWokrAcGu4sQwQWzLbmJ7VjiNw3HizpGqoab/EWnOV2M3nPcyqtALfRwAv3u
 uW6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620978; x=1775225778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=TkzYWhTtSpn0knCuLm9iVigwEX4EQgTeUT1aHLNCn8Y+5PDV+DLPT/729ITr+uDrnN
 ILOk5asYDknDuOmMeYK8I6biPtamfQnZW9qRfQJLhQz27tUuvgHjum34rquKUOKbKX/p
 4f7UKeD1jKLs0BExvWkR/2UGSGeLKolhUR0RV7JEWr4HZFM6L8EZUEX7b9Ls2z/WNDfW
 JU+p7Y/TMJnjdZYhbbov0e2a/7Qg8c5nl3KLcwCqZcDgrzqmhBVPBcnYfi4AoQJpvg9E
 bKaKRR8pqJTbVkw1qdmcFtrz1EwYIJFp3w7uDZGEr2eJ1IyiTL21An+OWs8KU7H5SD7Q
 yFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620978; x=1775225778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=WQ8XKwgx2ym0vYzrix7C7n0XCyKOxNiMXa/oDShTVzPqC7mYUEodX+2IyBt3TNA8al
 vK3931x1ZYk1vVt29z3cyxFnnqRSuhKNJq9EASGQoXRlyVUMf23Kv37k4LaKcZxdUwSB
 Mcu6uV6ycW6hNXc9a/Ye1EpREkY1lfln10bLB5veyM0ok2yy3Xp/MYdYYOJ2N5hilBsz
 is8OQ1ITG7yE5JgNgG57DvMzcaMl5XVJp2kiL4zwDUXIP/5+g03cQPiAtCxETgdCmpCM
 ytkN0lKPyACj1KLFEIrK5Pip53AksCL5beL89i0H2p3/0J2GGRkGgT8i6k2QuUZK8K0l
 Ix2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3XNVH/44vvRUZDJHMBwP2kLmtSGYdCY3Emz+9VFl0CuQbF5ErgQhxRy+T2j3kgfUYPoDhU3bkDdMd@nongnu.org
X-Gm-Message-State: AOJu0Yx9ZTtpBiuCHKsKPGpmaSzTEnRH56ea9lrNW6zmtt8kGlIjmmo8
 4TxBQRpz0Pf24oW5ZX3Fy8eVWChPEkMAhJJWjnGePYAKR/vXS2PaEGPpcgPibGprDyWaiK3SS7q
 zOp9z8IyO4nOMX9ck8lS6DvQHJOElI3r5zQ79csjtDjeHfXUlX51Ngig=
X-Gm-Gg: ATEYQzwgHb2PP174y7k9G65sYnv1B3ZaldsqEyocRBvoBtyNWTbcwFtuAEIHLPOTmoc
 1GbGhN4iHfGEmWrll8wn8a+zvecLNw6e4Fzfax2aT+ZpHJjDOWE/Asid7gKbHbmONgXzj7DTLuW
 lHt0NwfOTkiMmehKXLPleN+uNZVHOdz4lOARMt2hiizlrmQlmVyg0lwkZgai9nyj9J5k93l5fuc
 +tlUPeFbx4Kxk1sVJEnmP2CPMQaSiaEKEmL3EaF+yrk++4gl2s7nd9bVEUoBHMZyKvCiNeCtHGj
 vq7QWYsJ97OiSFmyDMbvcswEjTLye/vMSY9YOLfqVrBdeHe1W/vAdX6WITuJTKXhF8Q=
X-Received: by 2002:a05:690e:11ce:b0:64e:e464:12fa with SMTP id
 956f58d0204a3-64ff7186196mr2658872d50.5.1774620977579; Fri, 27 Mar 2026
 07:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-8-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:16:06 +0000
X-Gm-Features: AQROBzB7drqtslZ5P4MR3E6zpMZVuU-zinN5xOcd-ktq5T8QKtXHBkqxN3bKfLU
Message-ID: <CAFEAcA9rGYiN7=819n2Fd-J3pA10ZVd8Tmt4VhHqp+sme2j5qQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

