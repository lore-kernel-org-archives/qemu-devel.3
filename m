Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0385CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 20:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL67P-0003aY-MX; Mon, 17 Nov 2025 15:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL67M-0003X2-JX
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:46:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL67H-0001m2-JT
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:46:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477632d45c9so35214645e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763412385; x=1764017185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNSQo1Yq46y6cdYoaPpM1u4NjyKNLSN5miPJbDKJFfs=;
 b=JSol9zSTDqVrzpTmxNn6U99z06rBpynqyvddsODlDzRmELuPGPaAih9PPByDg6psYN
 1YRzWcfEBX8yUrEvT/BfZ0w71BFoJ9Zs/LNQWu84rFu34vfyn9GM6skKba0d5Sydwhzy
 iMgxubCV7I7QfrE99Q2DehLtXONDESg4dYjIIldzMoIYS0V5z9yQ/F0wS/xkigw2l2qH
 VpPu26/UTKZbfm5QCSVFQ/OYyrlZg5vRb31pRKddZdFpLMRb4QCwHdg6pxT2maWSB52d
 am3JlBsRak+16XOIw9KMa/VvWgvrv2CjbR2V7KrDUqK84Lzf76jyKWNANuJ8MUOi/iqt
 Bing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763412385; x=1764017185;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNSQo1Yq46y6cdYoaPpM1u4NjyKNLSN5miPJbDKJFfs=;
 b=OW98rvb39zPbCOZgsEG6eexEj7e/6qncOuMuDFppnd92J+D9DST759TUxS1K+Aod9p
 ElrG81HStk2X2lsEhai+8JX1BtOmGAeR1LsDJaKOYRm9XRMGVN8vLkzkkL+LYB1rHjjW
 NTNLPJGu0ZBXqPwjHazsaGPXZRjFhM0uQGsjLWLMKfhcbRCEcCDw8bjkF7RlJwQqIYp3
 f+EmoRaxrCdQm2ezxjSRX8HjVRMrm14CwTsSX/Vi4EYpwQc8ZFZRdmaWgEa0qmU8DlM7
 0kZ4173mHxIwh26VY0Q/pB6AMayNaUxF7TnihYA5ihrcA3gp7wZ7F0M8Vx/Z4GzME09N
 c0iQ==
X-Gm-Message-State: AOJu0YzyZw9UkwBideFp4xj/kCgfnmd3GOdZ9JUZ4/554yFbX9DDiWdy
 u6Pb9N5i92oV9s6JkigAvUupgkiWAWS0vVDsbNNS5eRlW2rza+s8z90zK8JMYFzH52fjpfcEb4n
 sUYRW
X-Gm-Gg: ASbGncscSVEfnA1O0d9hzNw2o9yxdJ3DHiqbZwkGzo6wJP93DKdJUJYj516PCYXCPB8
 XKKFut5bKdWew8GG4FzYvJD7PxxiounORTpRLy+5gN8EUqPpdhLMraJWOXKjWjplVIUMsWq/uyD
 BGEdltzJmLclYyk6MHiW3axdM3wOKwUvp/Kp41UeSeFndphNFSl2LFznWX92aInP8IAFsh9D3/n
 3JjxDGUuikDqXLpXQ9mDsSt0Ci0dWkobLEThmpDGlIaSx8ptGw/nUEYanyV9+p+m7prKCGiJ2iE
 GRUbo8XbkU0mci7lsOjZvPavoOdb3rJo7segJ1bUwj+bednxu2xpqqsBcKsMSlkJY35UHKzascZ
 Co7lfg6w0jQVO4g4foKdmz3oFFMymhrXaXSNmsqM51M45UgnhqJge9/ssVYkFHgWTGhjLwYyGem
 WN
X-Google-Smtp-Source: AGHT+IGpzYiCTC3tUSz3UgYOsJm22Stbtw9VQankI1f+G+So+Np+rcPJ9H3tLF4eu5fkCFbGZKfgzA==
X-Received: by 2002:a05:600c:c4a1:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-4778fe96c46mr121852475e9.35.1763412384601; 
 Mon, 17 Nov 2025 12:46:24 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779f44a0e4sm109326535e9.15.2025.11.17.12.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 12:46:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D847A5F76E;
 Mon, 17 Nov 2025 20:46:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH 0/3] mtest2make: clean up and make dependencies more
 precise
In-Reply-To: <20251117163107.372393-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 17 Nov 2025 17:31:04 +0100")
References: <20251117163107.372393-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 20:46:22 +0000
Message-ID: <87bjl0l74x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> You probably have never thought much about scripts/mtest2make.py, and in
> fact it has seen only a hendful of commits in the last few years.
> The idea is pretty simple: gather the list of testsuites and their
> dependencies, and turn a "make check-*" invocation into calling "ninja"
> first and "meson test" second.  On top of that, it magically turns
> SPEED=3Dthorough into invoking up to three suites named XYZ, XYZ-slow
> and XYZ-thorough.

Hmm this seemed to run too many tests:

  make -j33 -k  -C /home/alex/lsrc/qemu.git/builds/all check-func-aarch64-t=
horough=20
  make: Entering directory '/home/alex/lsrc/qemu.git/builds/all'
  /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson test  --no-rebuild -=
t 1  --num-processes 33 --print-errorlogs=20
     1/1037 qemu:qtest+qtest-alpha / qtest-alpha/qom-test                  =
                     OK               0.50s   2 subtests passed
     2/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/qom-test                  =
                     OK               0.53s   2 subtests passed
     3/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/qom-test                =
                     OK               0.56s   2 subtests passed
     4/1037 qemu:qtest+qtest-sh4 / qtest-sh4/qom-test                      =
                     OK               0.54s   2 subtests passed
     5/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qom-test      =
                     OK               0.59s   2 subtests passed
     6/1037 qemu:qtest+qtest-mips / qtest-mips/qom-test                    =
                     OK               0.62s   2 subtests passed
     7/1037 qemu:qtest+qtest-tricore / qtest-tricore/qom-test              =
                     OK               0.60s   3 subtests passed
     8/1037 qemu:qtest+qtest-or1k / qtest-or1k/qom-test                    =
                     OK               0.66s   3 subtests passed
     9/1037 qemu:qtest+qtest-rx / qtest-rx/qom-test                        =
                     OK               0.72s   3 subtests passed
    10/1037 qemu:qtest+qtest-s390x / qtest-s390x/qom-test                  =
                     OK               0.77s   3 subtests passed
    11/1037 qemu:qtest+qtest-hppa / qtest-hppa/qom-test                    =
                     OK               0.91s   4 subtests passed
    12/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/qom-test        =
                     OK               0.91s   4 subtests passed
    13/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/qom-test    =
                     OK               0.96s   4 subtests passed
    14/1037 qemu:qtest+qtest-mips64 / qtest-mips64/qom-test                =
                     OK               1.03s   4 subtests passed
    15/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/qom-test              =
                     OK               1.01s   4 subtests passed
    16/1037 qemu:qtest+qtest-avr / qtest-avr/qom-test                      =
                     OK               1.08s   5 subtests passed
    17/1037 qemu:qtest+qtest-avr / qtest-avr/device-introspect-test        =
                     OK               0.94s   6 subtests passed
    18/1037 qemu:qtest+qtest-m68k / qtest-m68k/device-introspect-test      =
                     OK               0.97s   6 subtests passed
    19/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/qom-test            =
                     OK               1.76s   7 subtests passed
    20/1037 qemu:qtest+qtest-m68k / qtest-m68k/qom-test                    =
                     OK               1.86s   7 subtests passed
    21/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/qom-test              =
                     OK               1.85s   7 subtests passed
    22/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/device-introspec=
t-test               OK               1.10s   6 subtests passed
    23/1037 qemu:qtest+qtest-alpha / qtest-alpha/device-introspect-test    =
                     OK               1.36s   6 subtests passed
    24/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/device-intro=
spect-test           OK               1.05s   6 subtests passed
    25/1037 qemu:qtest+qtest-hppa / qtest-hppa/device-introspect-test      =
                     OK               1.34s   6 subtests passed
    26/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/device-introsp=
ect-test             OK               1.37s   6 subtests passed
    27/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/qom-test                =
                     OK               2.06s   11 subtests passed
    28/1037 qemu:qtest+qtest-i386 / qtest-i386/qom-test                    =
                     OK               2.27s   8 subtests passed
    29/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test                =
                     OK               2.21s   8 subtests passed
    30/1037 qemu:qtest+qtest-mips / qtest-mips/device-introspect-test      =
                     OK               1.37s   6 subtests passed
    31/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/qom-test              =
                     OK               2.28s   9 subtests passed
    32/1037 qemu:qtest+qtest-mips64 / qtest-mips64/device-introspect-test  =
                     OK               1.37s   6 subtests passed
    33/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/device-introspect-test  =
                     OK               1.38s   6 subtests passed
    34/1037 qemu:qtest+qtest-or1k / qtest-or1k/device-introspect-test      =
                     OK               1.39s   6 subtests passed
    35/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/qom-test            =
                     OK               2.07s   11 subtests passed
    36/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/device-introspect-te=
st                   OK               1.52s   6 subtests passed
    37/1037 qemu:qtest+qtest-alpha / qtest-alpha/cdrom-test                =
                     OK               0.39s   1 subtests passed
    38/1037 qemu:qtest+qtest-rx / qtest-rx/device-introspect-test          =
                     OK               0.90s   6 subtests passed
    39/1037 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test        =
                     OK               2.28s   6 subtests passed
    40/1037 qemu:qtest+qtest-avr / qtest-avr/cdrom-test                    =
                     OK               0.41s   1 subtests passed
    41/1037 qemu:qtest+qtest-hppa / qtest-hppa/cdrom-test                  =
                     OK               0.38s   1 subtests passed
    42/1037 qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test    =
                     OK               0.99s   6 subtests passed
    43/1037 qemu:qtest+qtest-tricore / qtest-tricore/device-introspect-test=
                     OK               0.85s   6 subtests passed
    44/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test=
                     OK               2.47s   6 subtests passed
    45/1037 qemu:qtest+qtest-ppc / qtest-ppc/qom-test                      =
                     OK               3.03s   13 subtests passed
    46/1037 qemu:qtest+qtest-m68k / qtest-m68k/cdrom-test                  =
                     OK               0.38s   1 subtests passed
    47/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/device-introspect-test    =
                     OK               1.32s   6 subtests passed
    48/1037 qemu:qtest+qtest-sh4 / qtest-sh4/device-introspect-test        =
                     OK               1.36s   6 subtests passed
    49/1037 qemu:qtest+qtest-sparc / qtest-sparc/qom-test                  =
                     OK               3.26s   11 subtests passed
    50/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/device-introspect-test=
                     OK               1.56s   6 subtests passed
    51/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/cdrom-test      =
                     OK               0.40s   1 subtests passed
    52/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/cdrom-test  =
                     OK               0.38s   1 subtests passed
    53/1037 qemu:qtest+qtest-ppc / qtest-ppc/device-introspect-test        =
                     OK               1.82s   6 subtests passed
    54/1037 qemu:qtest+qtest-mips / qtest-mips/cdrom-test                  =
                     OK               0.39s   1 subtests passed
    55/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/device-introspect-test=
                     OK               1.35s   6 subtests passed
    56/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cdrom-test    =
                     OK               0.67s   1 subtests passed
    57/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/device-introspect-test  =
                     OK               1.27s   6 subtests passed
    58/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/device-introspect-test=
                     OK               1.71s   6 subtests passed
    59/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/device-introspect-te=
st                   OK               1.32s   6 subtests passed
    60/1037 qemu:qtest+qtest-or1k / qtest-or1k/cdrom-test                  =
                     OK               0.38s   1 subtests passed
    61/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/cdrom-test              =
                     OK               0.41s   1 subtests passed
    62/1037 qemu:qtest+qtest-ppc / qtest-ppc/cdrom-test                    =
                     OK               0.42s   1 subtests passed
    63/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/cdrom-test            =
                     OK               0.39s   1 subtests passed
    64/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/cdrom-test            =
                     OK               0.40s   1 subtests passed
    65/1037 qemu:qtest+qtest-mips64 / qtest-mips64/cdrom-test              =
                     OK               0.71s   3 subtests passed
    66/1037 qemu:qtest+qtest-rx / qtest-rx/cdrom-test                      =
                     OK               0.41s   1 subtests passed
    67/1037 qemu:qtest+qtest-sh4 / qtest-sh4/cdrom-test                    =
                     OK               0.38s   1 subtests passed
    68/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/cdrom-test          =
                     OK               0.81s   3 subtests passed
    69/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/device-introspect-test    =
                     OK               2.21s   6 subtests passed
    70/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/cdrom-test                =
                     OK               0.41s   1 subtests passed
    71/1037 qemu:qtest+qtest-i386 / qtest-i386/vmgenid-test                =
                     OK               1.27s   3 subtests passed
    72/1037 qemu:qtest+qtest-tricore / qtest-tricore/cdrom-test            =
                     OK               0.39s   1 subtests passed
    73/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/cdrom-test            =
                     OK               1.81s   9 subtests passed
    74/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/cdrom-test              =
                     OK               0.41s   1 subtests passed
    75/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/cdrom-test          =
                     OK               0.42s   1 subtests passed
    76/1037 qemu:qtest+qtest-arm / qtest-arm/cdrom-test                    =
                     OK               1.76s   9 subtests passed
    77/1037 qemu:qtest+qtest-i386 / qtest-i386/device-introspect-test      =
                     OK               3.59s   6 subtests passed
    78/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/cdrom-test            =
                     OK               0.73s   3 subtests passed
    79/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/cdrom-test                =
                     OK               0.98s   4 subtests passed
    80/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/boot-serial-test      =
                     OK               0.47s   1 subtests passed
    81/1037 qemu:qtest+qtest-alpha / qtest-alpha/boot-serial-test          =
                     OK               0.52s   1 subtests passed
    82/1037 qemu:qtest+qtest-s390x / qtest-s390x/device-introspect-test    =
                     OK               2.80s   6 subtests passed
    83/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/boot-serial-te=
st                   OK               0.52s   1 subtests passed
    84/1037 qemu:qtest+qtest-avr / qtest-avr/boot-serial-test              =
                     OK               0.62s   2 subtests passed
    85/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/boot-serial-=
test                 OK               0.48s   1 subtests passed
    86/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/vmgenid-test            =
                     OK               1.19s   3 subtests passed
    87/1037 qemu:qtest+qtest-m68k / qtest-m68k/boot-serial-test            =
                     OK               0.64s   2 subtests passed
    88/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/boot-serial-test=
                     OK               0.58s   1 subtests passed
    89/1037 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart-test          =
                     OK               1.26s   7 subtests passed
    90/1037 qemu:unit / test-crypto-block                                  =
                     OK               0.01s   1 subtests passed
    91/1037 qemu:qtest+qtest-arm / qtest-arm/boot-serial-test              =
                     OK               0.91s   3 subtests passed
    92/1037 qemu:qtest+qtest-s390x / qtest-s390x/boot-serial-test          =
                     OK               0.51s   1 subtests passed
    93/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/qom-test                  =
                     OK               5.69s   20 subtests passed
    94/1037 qemu:qtest+qtest-i386 / qtest-i386/cdrom-test                  =
                     OK               2.95s   6 subtests passed
    95/1037 qemu:qtest+qtest-sparc / qtest-sparc/cdrom-test                =
                     OK               2.23s   10 subtests passed
    96/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/device-introspect-test  =
                     OK               3.64s   6 subtests passed
    97/1037 qemu:qtest+qtest-alpha / qtest-alpha/test-hmp                  =
                     OK               0.99s   3 subtests passed
    98/1037 qemu:qtest+qtest-ppc / qtest-ppc/prom-env-test                 =
                     OK               2.15s   2 subtests passed
    99/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/boot-serial-test      =
                     OK               1.95s   1 subtests passed
   100/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/cdrom-test              =
                     OK               3.13s   6 subtests passed
   101/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/prom-env-test             =
                     OK               2.16s   2 subtests passed
   102/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/prom-env-test         =
                     OK               2.04s   1 subtests passed
   103/1037 qemu:qtest+qtest-avr / qtest-avr/test-hmp                      =
                     OK               1.43s   6 subtests passed
   104/1037 qemu:qtest+qtest-hppa / qtest-hppa/test-hmp                    =
                     OK               1.52s   5 subtests passed
   105/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/test-hmp      =
                     OK               1.06s   3 subtests passed
   106/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_pwm-test              =
                     OK               2.52s   3 subtests passed
   107/1037 qemu:qtest+qtest-mips / qtest-mips/test-hmp                    =
                     OK               1.03s   3 subtests passed
   108/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/test-hmp    =
                     OK               1.37s   5 subtests passed
   109/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/test-hmp        =
                     OK               1.41s   5 subtests passed
   110/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/test-hmp                =
                     OK               1.01s   3 subtests passed
   111/1037 qemu:qtest+qtest-or1k / qtest-or1k/test-hmp                    =
                     OK               1.24s   4 subtests passed
   112/1037 qemu:qtest+qtest-s390x / qtest-s390x/cdrom-test                =
                     OK               5.29s   6 subtests passed
   113/1037 qemu:qtest+qtest-mips64 / qtest-mips64/test-hmp                =
                     OK               1.78s   5 subtests passed
   114/1037 qemu:qtest+qtest-m68k / qtest-m68k/test-hmp                    =
                     OK               2.18s   8 subtests passed
   115/1037 qemu:qtest+qtest-i386 / qtest-i386/test-hmp                    =
                     OK               3.13s   9 subtests passed
   116/1037 qemu:qtest+qtest-rx / qtest-rx/test-hmp                        =
                     OK               0.99s   4 subtests passed
   117/1037 qemu:qtest+qtest-ppc / qtest-ppc/boot-serial-test              =
                     OK               4.89s   5 subtests passed
   118/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/test-hmp            =
                     OK               2.45s   8 subtests passed
   119/1037 qemu:qtest+qtest-sh4 / qtest-sh4/test-hmp                      =
                     OK               0.98s   3 subtests passed
   120/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/test-hmp                  =
                     OK               1.00s   3 subtests passed
   121/1037 qemu:qtest+qtest-s390x / qtest-s390x/test-hmp                  =
                     OK               1.27s   4 subtests passed
   122/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/boot-serial-test          =
                     OK               5.45s   7 subtests passed
   123/1037 qemu:qtest+qtest-tricore / qtest-tricore/test-hmp              =
                     OK               1.01s   4 subtests passed
   124/1037 qemu:qtest+qtest-sparc / qtest-sparc/boot-serial-test          =
                     OK               5.57s   3 subtests passed
   125/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/test-hmp              =
                     OK               1.60s   5 subtests passed
   126/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/test-hmp              =
                     OK               2.53s   8 subtests passed
   127/1037 qemu:qtest+qtest-alpha / qtest-alpha/qos-test                  =
                     SKIP             0.17s
   128/1037 qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test             =
                     OK               6.18s   3 subtests passed
   129/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/test-hmp              =
                     OK               3.19s   10 subtests passed
   130/1037 qemu:qtest+qtest-ppc / qtest-ppc/test-hmp                      =
                     OK               4.46s   14 subtests passed
   131/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-hmp                =
                     OK               3.02s   9 subtests passed
   132/1037 qemu:qtest+qtest-sparc / qtest-sparc/test-hmp                  =
                     OK               3.71s   12 subtests passed
   133/1037 qemu:qtest+qtest-avr / qtest-avr/qos-test                      =
                     SKIP             0.16s
   134/1037 qemu:qtest+qtest-hppa / qtest-hppa/qos-test                    =
                     SKIP             0.24s
   135/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/pxe-test                  =
                     OK               9.71s   2 subtests passed
   136/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/test-hmp            =
                     OK               3.53s   12 subtests passed
   137/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/test-hmp                =
                     OK               3.58s   12 subtests passed
   138/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test   =
                     OK               6.35s   15 subtests passed
   139/1037 qemu:unit / test-aio-multithread                               =
                     OK               7.43s   6 subtests passed
   140/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/test-hmp                  =
                     OK              10.07s   21 subtests passed
   141/1037 qemu:qtest+qtest-m68k / qtest-m68k/qos-test                    =
                     SKIP             0.17s
   142/1037 qemu:qtest+qtest-s390x / qtest-s390x/migration-test            =
                     OK              15.30s   9 subtests passed
   143/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/qos-test        =
                     SKIP             0.18s
   144/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test            =
                     OK              16.89s   9 subtests passed
   145/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/qos-test    =
                     SKIP             0.17s
   146/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test        =
                     OK              18.01s   9 subtests passed
   147/1037 qemu:qtest+qtest-mips / qtest-mips/qos-test                    =
                     SKIP             0.20s
   148/1037 qemu:qtest+qtest-alpha / qtest-alpha/qmp-cmd-test              =
                     OK              11.69s   68 subtests passed
   149/1037 qemu:qtest+qtest-mips64 / qtest-mips64/qos-test                =
                     SKIP             0.18s
   150/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/qmp-cmd-test          =
                     OK              12.27s   68 subtests passed
   151/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/qos-test            =
                     SKIP             0.20s
   152/1037 qemu:qtest+qtest-arm / qtest-arm/qmp-cmd-test                  =
                     OK              12.23s   68 subtests passed
   153/1037 qemu:qtest+qtest-avr / qtest-avr/qmp-cmd-test                  =
                     OK              11.23s   68 subtests passed
   154/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/qos-test                =
                     SKIP             0.20s
   155/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/bios-tables-test      =
                     OK              23.52s   3 subtests passed
   156/1037 qemu:qtest+qtest-or1k / qtest-or1k/qos-test                    =
                     SKIP             0.17s
   157/1037 qemu:qtest+qtest-ppc / qtest-ppc/qos-test                      =
                     SKIP             0.20s
   158/1037 qemu:qtest+qtest-i386 / qtest-i386/ide-test                    =
                     OK              11.00s   14 subtests passed
   159/1037 qemu:qtest+qtest-hppa / qtest-hppa/qmp-cmd-test                =
                     OK              11.77s   68 subtests passed
   160/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qmp-cmd-test  =
                     OK              11.81s   68 subtests passed
   161/1037 qemu:qtest+qtest-i386 / qtest-i386/qmp-cmd-test                =
                     OK              12.01s   68 subtests passed
   162/1037 qemu:qtest+qtest-i386 / qtest-i386/migration-test              =
                     OK              22.58s   11 subtests passed
   163/1037 qemu:qtest+qtest-m68k / qtest-m68k/qmp-cmd-test                =
                     OK              10.97s   68 subtests passed
   164/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/qmp-cmd-test    =
                     OK              10.77s   68 subtests passed
   165/1037 qemu:qtest+qtest-i386 / qtest-i386/pxe-test                    =
                     OK              26.41s   4 subtests passed
   166/1037 qemu:qtest+qtest-rx / qtest-rx/qos-test                        =
                     SKIP             0.15s
   167/1037 qemu:qtest+qtest-s390x / qtest-s390x/qos-test                  =
                     SKIP             0.16s
   168/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/bios-tables-te=
st                   OK              29.39s   5 subtests passed
   169/1037 qemu:qtest+qtest-sh4 / qtest-sh4/qos-test                      =
                     SKIP             0.16s
   170/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/pxe-test                =
                     OK              26.18s   4 subtests passed
   171/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/qmp-cmd-test=
                     OK              10.53s   68 subtests passed
   172/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/qos-test                  =
                     SKIP             0.19s
   173/1037 qemu:qtest+qtest-sparc / qtest-sparc/qos-test                  =
                     SKIP             0.16s
   174/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test               =
                     OK              21.48s   75 subtests passed
   175/1037 qemu:qtest+qtest-i386 / qtest-i386/ahci-test                   =
                     OK              21.71s   75 subtests passed
   176/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/qos-test              =
                     SKIP             0.16s
   177/1037 qemu:qtest+qtest-tricore / qtest-tricore/qos-test              =
                     SKIP             0.15s
   178/1037 qemu:qtest+qtest-mips / qtest-mips/qmp-cmd-test                =
                     OK              10.90s   68 subtests passed
   179/1037 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-cmd-test            =
                     OK              10.91s   68 subtests passed
   180/1037 qemu:qtest+qtest-arm / qtest-arm/qos-test                      =
                     OK              21.63s   97 subtests passed
   181/1037 qemu:qtest+qtest-arm / qtest-arm/qom-test                      =
                     OK              33.21s   81 subtests passed
   182/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/qos-test                =
                     SKIP             0.19s
   183/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/qmp-cmd-test            =
                     OK              10.62s   68 subtests passed
   184/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/qmp-cmd-test        =
                     OK              10.98s   68 subtests passed
   185/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/qos-test            =
                     SKIP             0.16s
   186/1037 qemu:unit / test-crypto-tlssession                             =
                     OK               0.33s   18 subtests passed
   187/1037 qemu:unit / test-crypto-tlscredsx509                           =
                     OK               0.39s   46 subtests passed
   188/1037 qemu:func-quick+func-aarch64 / func-aarch64-vmstate            =
                     SKIP             0.12s   0 subtests passed
   189/1037 qemu:qtest+qtest-or1k / qtest-or1k/qmp-cmd-test                =
                     OK              10.79s   68 subtests passed
   190/1037 qemu:func-quick+func-aarch64 / func-aarch64-empty_cpu_model    =
                     OK               0.19s   1 subtests passed
   191/1037 qemu:func-quick+func-aarch64 / func-aarch64-info_usernet       =
                     OK               0.28s   1 subtests passed
   192/1037 qemu:qtest+qtest-ppc / qtest-ppc/qmp-cmd-test                  =
                     OK              10.81s   68 subtests passed
   193/1037 qemu:func-quick+func-aarch64 / func-aarch64-version            =
                     OK               0.21s   1 subtests passed
   194/1037 qemu:func-quick+func-alpha / func-alpha-empty_cpu_model        =
                     OK               0.23s   1 subtests passed
   195/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/qmp-cmd-test              =
                     OK              11.09s   68 subtests passed
   196/1037 qemu:func-quick+func-alpha / func-alpha-info_usernet           =
                     OK               0.30s   1 subtests passed
   197/1037 qemu:func-quick+func-aarch64 / func-aarch64-vnc                =
                     OK               0.64s   4 subtests passed
   198/1037 qemu:func-quick+func-aarch64 / func-aarch64-migration          =
                     OK               1.20s   3 subtests passed
   199/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/qmp-cmd-test          =
                     OK              10.87s   68 subtests passed
   200/1037 qemu:func-quick+func-alpha / func-alpha-version                =
                     OK               0.30s   1 subtests passed
   201/1037 qemu:func-quick+func-arm / func-arm-empty_cpu_model            =
                     OK               0.21s   1 subtests passed
   202/1037 qemu:func-quick+func-alpha / func-alpha-migration              =
                     OK               1.10s   3 subtests passed
   203/1037 qemu:func-quick+func-arm / func-arm-version                    =
                     OK               0.27s   1 subtests passed
   204/1037 qemu:func-quick+func-alpha / func-alpha-vnc                    =
                     OK               0.61s   4 subtests passed
   205/1037 qemu:func-quick+func-arm / func-arm-info_usernet               =
                     OK               0.42s   1 subtests passed
   206/1037 qemu:func-quick+func-avr / func-avr-empty_cpu_model            =
                     OK               0.30s   1 subtests passed
   207/1037 qemu:func-quick+func-avr / func-avr-version                    =
                     OK               0.24s   1 subtests passed
   208/1037 qemu:func-quick+func-avr / func-avr-info_usernet               =
                     OK               0.39s   1 subtests passed
   209/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/qmp-cmd-test          =
                     OK              10.87s   68 subtests passed
   210/1037 qemu:func-quick+func-hppa / func-hppa-empty_cpu_model          =
                     OK               0.21s   1 subtests passed
   211/1037 qemu:func-quick+func-arm / func-arm-vnc                        =
                     OK               0.77s   4 subtests passed
   212/1037 qemu:func-quick+func-hppa / func-hppa-seabios                  =
                     OK               0.41s   2 subtests passed
   213/1037 qemu:func-quick+func-hppa / func-hppa-info_usernet             =
                     OK               0.34s   1 subtests passed
   214/1037 qemu:func-quick+func-hppa / func-hppa-version                  =
                     OK               0.29s   1 subtests passed
   215/1037 qemu:func-quick+func-avr / func-avr-vnc                        =
                     OK               0.60s   4 subtests passed
   216/1037 qemu:func-quick+func-i386 / func-i386-empty_cpu_model          =
                     OK               0.21s   1 subtests passed
   217/1037 qemu:func-quick+func-arm / func-arm-migration                  =
                     OK               1.47s   3 subtests passed
   218/1037 qemu:func-quick+func-i386 / func-i386-version                  =
                     OK               0.27s   1 subtests passed
   219/1037 qemu:func-quick+func-i386 / func-i386-info_usernet             =
                     OK               0.33s   1 subtests passed
   220/1037 qemu:func-quick+func-loongarch64 / func-loongarch64-empty_cpu_m=
odel                 OK               0.26s   1 subtests passed
   221/1037 qemu:func-quick+func-hppa / func-hppa-vnc                      =
                     OK               0.67s   4 subtests passed
   222/1037 qemu:func-quick+func-loongarch64 / func-loongarch64-version    =
                     OK               0.26s   1 subtests passed
   223/1037 qemu:func-quick+func-m68k / func-m68k-vmstate                  =
                     SKIP             0.14s   0 subtests passed
   224/1037 qemu:func-quick+func-loongarch64 / func-loongarch64-info_userne=
t                    OK               0.35s   1 subtests passed
   225/1037 qemu:func-quick+func-m68k / func-m68k-empty_cpu_model          =
                     OK               0.18s   1 subtests passed
   226/1037 qemu:func-quick+func-i386 / func-i386-vnc                      =
                     OK               0.73s   4 subtests passed
   227/1037 qemu:func-quick+func-m68k / func-m68k-version                  =
                     OK               0.20s   1 subtests passed
   228/1037 qemu:func-quick+func-m68k / func-m68k-info_usernet             =
                     OK               0.30s   1 subtests passed
   229/1037 qemu:func-quick+func-microblaze / func-microblaze-empty_cpu_mod=
el                   OK               0.19s   1 subtests passed
   230/1037 qemu:func-quick+func-loongarch64 / func-loongarch64-vnc        =
                     OK               0.66s   4 subtests passed
   231/1037 qemu:func-quick+func-microblaze / func-microblaze-version      =
                     OK               0.23s   1 subtests passed
   232/1037 qemu:func-quick+func-i386 / func-i386-migration                =
                     OK               1.16s   3 subtests passed
   233/1037 qemu:func-quick+func-microblazeel / func-microblazeel-empty_cpu=
_model               OK               0.21s   1 subtests passed
   234/1037 qemu:func-quick+func-microblaze / func-microblaze-info_usernet =
                     OK               0.33s   1 subtests passed
   235/1037 qemu:func-quick+func-m68k / func-m68k-vnc                      =
                     OK               0.59s   4 subtests passed
   236/1037 qemu:func-quick+func-microblazeel / func-microblazeel-version  =
                     OK               0.22s   1 subtests passed
   237/1037 qemu:func-quick+func-mips / func-mips-empty_cpu_model          =
                     OK               0.18s   1 subtests passed
   238/1037 qemu:func-quick+func-microblazeel / func-microblazeel-info_user=
net                  OK               0.28s   1 subtests passed
   239/1037 qemu:func-quick+func-mips / func-mips-info_usernet             =
                     OK               0.25s   1 subtests passed
   240/1037 qemu:func-quick+func-mips / func-mips-version                  =
                     OK               0.21s   1 subtests passed
   241/1037 qemu:func-quick+func-microblaze / func-microblaze-vnc          =
                     OK               0.58s   4 subtests passed
   242/1037 qemu:func-quick+func-mips64 / func-mips64-empty_cpu_model      =
                     OK               0.20s   1 subtests passed
   243/1037 qemu:func-quick+func-mips64 / func-mips64-version              =
                     OK               0.22s   1 subtests passed
   244/1037 qemu:func-quick+func-microblazeel / func-microblazeel-vnc      =
                     OK               0.60s   4 subtests passed
   245/1037 qemu:func-quick+func-mips64 / func-mips64-info_usernet         =
                     OK               0.39s   1 subtests passed
   246/1037 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model  =
                     OK               0.26s   1 subtests passed
   247/1037 qemu:func-quick+func-mips64el / func-mips64el-info_usernet     =
                     OK               0.34s   1 subtests passed
   248/1037 qemu:func-quick+func-mips64el / func-mips64el-version          =
                     OK               0.24s   1 subtests passed
   249/1037 qemu:func-quick+func-mipsel / func-mipsel-empty_cpu_model      =
                     OK               0.18s   1 subtests passed
   250/1037 qemu:func-quick+func-mips / func-mips-vnc                      =
                     OK               0.62s   4 subtests passed
   251/1037 qemu:qtest+qtest-arm / qtest-arm/test-hmp                      =
                     OK              32.46s   82 subtests passed
   252/1037 qemu:func-quick+func-mipsel / func-mipsel-info_usernet         =
                     OK               0.35s   1 subtests passed
   253/1037 qemu:func-quick+func-or1k / func-or1k-empty_cpu_model          =
                     OK               0.23s   1 subtests passed
   254/1037 qemu:func-quick+func-mips64 / func-mips64-vnc                  =
                     OK               0.69s   4 subtests passed
   255/1037 qemu:func-quick+func-mipsel / func-mipsel-version              =
                     OK               0.30s   1 subtests passed
   256/1037 qemu:func-quick+func-or1k / func-or1k-version                  =
                     OK               0.30s   1 subtests passed
   257/1037 qemu:func-quick+func-or1k / func-or1k-info_usernet             =
                     OK               0.46s   1 subtests passed
   258/1037 qemu:func-quick+func-ppc / func-ppc-empty_cpu_model            =
                     OK               0.26s   1 subtests passed
   259/1037 qemu:func-quick+func-mips64el / func-mips64el-vnc              =
                     OK               0.79s   4 subtests passed
   260/1037 qemu:func-quick+func-mipsel / func-mipsel-vnc                  =
                     OK               0.77s   4 subtests passed
   261/1037 qemu:func-quick+func-ppc / func-ppc-version                    =
                     OK               0.28s   1 subtests passed
   262/1037 qemu:func-quick+func-or1k / func-or1k-vnc                      =
                     OK               0.68s   4 subtests passed
   263/1037 qemu:func-quick+func-ppc / func-ppc-info_usernet               =
                     OK               0.42s   1 subtests passed
   264/1037 qemu:func-quick+func-ppc64 / func-ppc64-vmstate                =
                     SKIP             0.16s   0 subtests passed
   265/1037 qemu:qtest+qtest-rx / qtest-rx/qmp-cmd-test                    =
                     OK              10.38s   68 subtests passed
   266/1037 qemu:func-quick+func-ppc64 / func-ppc64-empty_cpu_model        =
                     OK               0.25s   1 subtests passed
   267/1037 qemu:func-quick+func-ppc64 / func-ppc64-version                =
                     OK               0.30s   1 subtests passed
   268/1037 qemu:func-quick+func-ppc / func-ppc-vnc                        =
                     OK               0.72s   4 subtests passed
   269/1037 qemu:func-quick+func-ppc64 / func-ppc64-info_usernet           =
                     OK               0.39s   1 subtests passed
   270/1037 qemu:func-quick+func-ppc / func-ppc-migration                  =
                     OK               1.17s   3 subtests passed
   271/1037 qemu:func-quick+func-riscv32 / func-riscv32-empty_cpu_model    =
                     OK               0.25s   1 subtests passed
   272/1037 qemu:func-quick+func-riscv32 / func-riscv32-version            =
                     OK               0.22s   1 subtests passed
   273/1037 qemu:func-quick+func-riscv32 / func-riscv32-info_usernet       =
                     OK               0.42s   1 subtests passed
   274/1037 qemu:func-quick+func-ppc64 / func-ppc64-vnc                    =
                     OK               0.85s   4 subtests passed
   275/1037 qemu:func-quick+func-ppc64 / func-ppc64-migration              =
                     OK               1.15s   3 subtests passed
   276/1037 qemu:func-quick+func-riscv32 / func-riscv32-opensbi            =
                     OK               0.90s   3 subtests passed
   277/1037 qemu:func-quick+func-riscv64 / func-riscv64-empty_cpu_model    =
                     OK               0.24s   1 subtests passed
   278/1037 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test              =
                     OK              11.02s   68 subtests passed
   279/1037 qemu:func-quick+func-riscv64 / func-riscv64-version            =
                     OK               0.25s   1 subtests passed
   280/1037 qemu:qtest+qtest-sh4 / qtest-sh4/qmp-cmd-test                  =
                     OK              10.87s   68 subtests passed
   281/1037 qemu:func-quick+func-riscv32 / func-riscv32-migration          =
                     OK               1.16s   3 subtests passed
   282/1037 qemu:func-quick+func-riscv32 / func-riscv32-vnc                =
                     OK               0.70s   4 subtests passed
   283/1037 qemu:func-quick+func-riscv64 / func-riscv64-info_usernet       =
                     OK               0.37s   1 subtests passed
   284/1037 qemu:func-quick+func-rx / func-rx-empty_cpu_model              =
                     OK               0.21s   1 subtests passed
   285/1037 qemu:func-quick+func-riscv64 / func-riscv64-opensbi            =
                     OK               0.71s   3 subtests passed
   286/1037 qemu:func-quick+func-s390x / func-s390x-vmstate                =
                     SKIP             0.10s   0 subtests passed
   287/1037 qemu:func-quick+func-rx / func-rx-version                      =
                     OK               0.25s   1 subtests passed
   288/1037 qemu:func-quick+func-rx / func-rx-info_usernet                 =
                     OK               0.30s   1 subtests passed
   289/1037 qemu:func-quick+func-s390x / func-s390x-version                =
                     OK               0.21s   1 subtests passed
   290/1037 qemu:func-quick+func-s390x / func-s390x-empty_cpu_model        =
                     OK               0.25s   1 subtests passed
   291/1037 qemu:func-quick+func-sh4 / func-sh4-empty_cpu_model            =
                     OK               0.22s   1 subtests passed
   292/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/qmp-cmd-test              =
                     OK              10.93s   68 subtests passed
   293/1037 qemu:func-quick+func-sh4 / func-sh4-version                    =
                     OK               0.20s   1 subtests passed
   294/1037 qemu:func-quick+func-riscv64 / func-riscv64-vnc                =
                     OK               0.68s   4 subtests passed
   295/1037 qemu:func-quick+func-s390x / func-s390x-info_usernet           =
                     OK               0.48s   1 subtests passed
   296/1037 qemu:func-quick+func-riscv64 / func-riscv64-migration          =
                     OK               1.18s   3 subtests passed
   297/1037 qemu:func-quick+func-sh4eb / func-sh4eb-empty_cpu_model        =
                     OK               0.25s   1 subtests passed
   298/1037 qemu:qtest+qtest-sparc / qtest-sparc/qmp-cmd-test              =
                     OK              10.68s   68 subtests passed
   299/1037 qemu:func-quick+func-sh4 / func-sh4-info_usernet               =
                     OK               0.39s   1 subtests passed
   300/1037 qemu:func-quick+func-sh4eb / func-sh4eb-version                =
                     OK               0.36s   1 subtests passed
   301/1037 qemu:func-quick+func-rx / func-rx-vnc                          =
                     OK               0.77s   4 subtests passed
   302/1037 qemu:func-quick+func-sparc / func-sparc-version                =
                     OK               0.31s   1 subtests passed
   303/1037 qemu:func-quick+func-sh4eb / func-sh4eb-info_usernet           =
                     OK               0.53s   1 subtests passed
   304/1037 qemu:func-quick+func-sparc / func-sparc-empty_cpu_model        =
                     OK               0.45s   1 subtests passed
   305/1037 qemu:func-quick+func-sparc64 / func-sparc64-empty_cpu_model    =
                     OK               0.40s   1 subtests passed
   306/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ide-test                =
                     OK               9.62s   14 subtests passed
   307/1037 qemu:func-quick+func-s390x / func-s390x-vnc                    =
                     OK               1.09s   4 subtests passed
   308/1037 qemu:func-quick+func-sparc / func-sparc-info_usernet           =
                     OK               0.75s   1 subtests passed
   309/1037 qemu:func-quick+func-tricore / func-tricore-empty_cpu_model    =
                     OK               0.78s   1 subtests passed
   310/1037 qemu:func-quick+func-x86_64 / func-x86_64-bad_vmstate          =
                     OK               0.52s   1 subtests passed
   311/1037 qemu:func-quick+func-sh4 / func-sh4-vnc                        =
                     OK               1.54s   4 subtests passed
   312/1037 qemu:func-quick+func-sparc64 / func-sparc64-info_usernet       =
                     OK               1.12s   1 subtests passed
   313/1037 qemu:func-quick+func-sparc64 / func-sparc64-version            =
                     OK               1.12s   1 subtests passed
   314/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/qmp-cmd-test          =
                     OK              11.97s   68 subtests passed
   315/1037 qemu:func-quick+func-x86_64 / func-x86_64-memlock              =
                     SKIP             0.25s   0 subtests passed
   316/1037 qemu:func-quick+func-sparc / func-sparc-vnc                    =
                     OK               1.64s   4 subtests passed
   317/1037 qemu:func-quick+func-tricore / func-tricore-version            =
                     OK               1.05s   1 subtests passed
   318/1037 qemu:func-quick+func-tricore / func-tricore-info_usernet       =
                     OK               1.18s   1 subtests passed
   319/1037 qemu:func-quick+func-x86_64 / func-x86_64-vmstate              =
                     SKIP             0.18s   0 subtests passed
   320/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test              =
                     OK              42.52s   93 subtests passed
   321/1037 qemu:func-quick+func-sh4eb / func-sh4eb-vnc                    =
                     OK               2.03s   4 subtests passed
   322/1037 qemu:func-quick+func-x86_64 / func-x86_64-empty_cpu_model      =
                     OK               0.25s   1 subtests passed
   323/1037 qemu:func-quick+func-x86_64 / func-x86_64-pc_cpu_hotplug_props =
                     OK               0.44s   1 subtests passed
   324/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/qos-test              =
                     OK              32.26s   129 subtests passed
   325/1037 qemu:func-quick+func-sparc64 / func-sparc64-vnc                =
                     OK               1.76s   4 subtests passed
   326/1037 qemu:func-quick+func-tricore / func-tricore-vnc                =
                     OK               1.45s   4 subtests passed
   327/1037 qemu:func-quick+func-x86_64 / func-x86_64-version              =
                     OK               0.30s   1 subtests passed
   328/1037 qemu:qtest+qtest-tricore / qtest-tricore/qmp-cmd-test          =
                     OK              11.38s   68 subtests passed
   329/1037 qemu:func-quick+func-xtensa / func-xtensa-empty_cpu_model      =
                     OK               0.28s   1 subtests passed
   330/1037 qemu:func-quick+func-x86_64 / func-x86_64-info_usernet         =
                     OK               0.47s   1 subtests passed
   331/1037 qemu:func-quick+func-xtensa / func-xtensa-version              =
                     OK               0.32s   1 subtests passed
   332/1037 qemu:func-quick+func-xtensaeb / func-xtensaeb-empty_cpu_model  =
                     OK               0.22s   1 subtests passed
   333/1037 qemu:func-quick+func-x86_64 / func-x86_64-cpu_queries          =
                     OK               1.10s   1 subtests passed
   334/1037 qemu:func-quick+func-sparc64 / func-sparc64-migration          =
                     OK               2.40s   3 subtests passed
   335/1037 qemu:func-quick+func-xtensa / func-xtensa-info_usernet         =
                     OK               0.49s   1 subtests passed
   336/1037 qemu:func-quick+func-xtensaeb / func-xtensaeb-version          =
                     OK               0.32s   1 subtests passed
   337/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-test   =
                     OK               0.23s   5 subtests passed
   338/1037 qemu:func-quick+func-xtensaeb / func-xtensaeb-info_usernet     =
                     OK               0.45s   1 subtests passed
   339/1037 qemu:func-quick+func-sparc / func-sparc-migration              =
                     OK               2.69s   3 subtests passed
   340/1037 qemu:func-quick+func-x86_64 / func-x86_64-cpu_model_versions   =
                     OK               1.50s   5 subtests passed
   341/1037 qemu:func-quick+func-x86_64 / func-x86_64-vnc                  =
                     OK               0.84s   4 subtests passed
   342/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/bcm2835-i2c-test      =
                     OK               0.20s   3 subtests passed
   343/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/bcm2835-dma-test      =
                     OK               0.24s   1 subtests passed
   344/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/fuzz-xlnx-dp-test     =
                     OK               0.39s   1 subtests passed
   345/1037 qemu:func-quick+func-xtensa / func-xtensa-vnc                  =
                     OK               0.79s   4 subtests passed
   346/1037 qemu:func-quick+func-xtensaeb / func-xtensaeb-vnc              =
                     OK               0.76s   4 subtests passed
   347/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-t=
est                  OK               0.69s   2 subtests passed
   348/1037 qemu:func-quick+func-x86_64 / func-x86_64-migration            =
                     OK               1.66s   3 subtests passed
   349/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-versal-trng-test =
                     OK               0.66s   5 subtests passed
   350/1037 qemu:unit / test-bufferiszero                                  =
                     OK               0.88s   1 subtests passed
   351/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/cxl-test              =
                     OK               0.34s   1 subtests passed
   352/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-i2c-test      =
                     OK               0.54s   6 subtests passed
   353/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/machine-none-test     =
                     OK               0.19s   1 subtests passed
   354/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/vnc-display-test      =
                     OK               0.22s   1 subtests passed
   355/1037 qemu:qtest+qtest-alpha / qtest-alpha/test-filter-mirror        =
                     OK               0.22s   1 subtests passed
   356/1037 qemu:qtest+qtest-alpha / qtest-alpha/test-netfilter            =
                     OK               0.24s   4 subtests passed
   357/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/readconfig-test       =
                     OK               0.35s   2 subtests passed
   358/1037 qemu:qtest+qtest-alpha / qtest-alpha/machine-none-test         =
                     OK               0.16s   1 subtests passed
   359/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-cmd-test            =
                     OK              12.41s   68 subtests passed
   360/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-gpio-test     =
                     OK               0.93s   2 subtests passed
   361/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/npcm_gmac-test        =
                     OK               0.99s   4 subtests passed
   362/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/qmp-test              =
                     OK               0.71s   4 subtests passed
   363/1037 qemu:qtest+qtest-alpha / qtest-alpha/vnc-display-test          =
                     OK               0.19s   1 subtests passed
   364/1037 qemu:qtest+qtest-alpha / qtest-alpha/test-filter-redirector    =
                     OK               0.48s   2 subtests passed
   365/1037 qemu:qtest+qtest-alpha / qtest-alpha/readconfig-test           =
                     OK               0.39s   2 subtests passed
   366/1037 qemu:qtest+qtest-arm / qtest-arm/cmsdk-apb-dualtimer-test      =
                     OK               0.20s   2 subtests passed
   367/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/arm-cpu-features      =
                     OK               1.14s   3 subtests passed
   368/1037 qemu:qtest+qtest-arm / qtest-arm/cmsdk-apb-timer-test          =
                     OK               0.19s   1 subtests passed
   369/1037 qemu:qtest+qtest-arm / qtest-arm/sse-timer-test                =
                     OK               0.32s   3 subtests passed
   370/1037 qemu:qtest+qtest-alpha / qtest-alpha/qmp-test                  =
                     OK               0.66s   4 subtests passed
   371/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-can-test         =
                     OK               1.82s   5 subtests passed
   372/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/xlnx-canfd-test       =
                     OK               1.87s   3 subtests passed
   373/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_gpio-test             =
                     OK               0.25s   18 subtests passed
   374/1037 qemu:qtest+qtest-arm / qtest-arm/aspeed_gpio-test              =
                     OK               0.39s   2 subtests passed
   375/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_rng-test              =
                     OK               0.22s   2 subtests passed
   376/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-smc-test      =
                     OK               1.64s   8 subtests passed
   377/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/numa-test             =
                     OK               1.49s   5 subtests passed
   378/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp              =
                     OK              40.06s   94 subtests passed
   379/1037 qemu:qtest+qtest-alpha / qtest-alpha/display-vga-test          =
                     OK               1.15s   5 subtests passed
   380/1037 qemu:qtest+qtest-arm / qtest-arm/hexloader-test                =
                     OK               0.20s   1 subtests passed
   381/1037 qemu:qtest+qtest-arm / qtest-arm/test-arm-mptimer              =
                     OK               0.20s   61 subtests passed
   382/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test            =
                     OK               0.31s   180 subtests passed
   383/1037 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_exti-test           =
                     OK               0.23s   9 subtests passed
   384/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/qmp-cmd-test            =
                     OK              12.40s   68 subtests passed
   385/1037 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_syscfg-test         =
                     OK               0.19s   10 subtests passed
   386/1037 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_rcc-test            =
                     OK               0.19s   5 subtests passed
   387/1037 qemu:qtest+qtest-arm / qtest-arm/tpm-tis-i2c-test              =
                     OK               0.56s   6 subtests passed
   388/1037 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_gpio-test           =
                     OK               0.21s   14 subtests passed
   389/1037 qemu:unit / test-replication                                   =
                     OK               2.90s   13 subtests passed
   390/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_sdhci-test            =
                     OK               0.78s   3 subtests passed
   391/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/qmp-cmd-test        =
                     OK              12.33s   68 subtests passed
   392/1037 qemu:qtest+qtest-arm / qtest-arm/aspeed_scu-test               =
                     OK               1.11s   4 subtests passed
   393/1037 qemu:qtest+qtest-arm / qtest-arm/machine-none-test             =
                     OK               0.20s   1 subtests passed
   394/1037 qemu:qtest+qtest-arm / qtest-arm/aspeed_fsi-test               =
                     OK               0.34s   4 subtests passed
   395/1037 qemu:qtest+qtest-arm / qtest-arm/vnc-display-test              =
                     OK               0.18s   1 subtests passed
   396/1037 qemu:qtest+qtest-avr / qtest-avr/machine-none-test             =
                     OK               0.15s   1 subtests passed
   397/1037 qemu:qtest+qtest-arm / qtest-arm/pflash-cfi02-test             =
                     OK               1.31s   4 subtests passed
   398/1037 qemu:qtest+qtest-arm / qtest-arm/cmsdk-apb-watchdog-test       =
                     OK               1.45s   7 subtests passed
   399/1037 qemu:qtest+qtest-arm / qtest-arm/arm-cpu-features              =
                     OK               0.49s   1 subtests passed
   400/1037 qemu:qtest+qtest-arm / qtest-arm/readconfig-test               =
                     OK               0.32s   2 subtests passed
   401/1037 qemu:qtest+qtest-avr / qtest-avr/vnc-display-test              =
                     OK               0.17s   1 subtests passed
   402/1037 qemu:qtest+qtest-hppa / qtest-hppa/test-netfilter              =
                     OK               0.17s   4 subtests passed
   403/1037 qemu:qtest+qtest-hppa / qtest-hppa/test-filter-mirror          =
                     OK               0.16s   1 subtests passed
   404/1037 qemu:qtest+qtest-avr / qtest-avr/readconfig-test               =
                     OK               0.28s   2 subtests passed
   405/1037 qemu:qtest+qtest-arm / qtest-arm/dm163-test                    =
                     OK               0.61s   3 subtests passed
   406/1037 qemu:qtest+qtest-hppa / qtest-hppa/machine-none-test           =
                     OK               0.17s   1 subtests passed
   407/1037 qemu:qtest+qtest-hppa / qtest-hppa/test-filter-redirector      =
                     OK               0.32s   2 subtests passed
   408/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_emc-test              =
                     OK               1.31s   6 subtests passed
   409/1037 qemu:qtest+qtest-hppa / qtest-hppa/vnc-display-test            =
                     OK               0.23s   1 subtests passed
   410/1037 qemu:qtest+qtest-arm / qtest-arm/qmp-test                      =
                     OK               0.67s   4 subtests passed
   411/1037 qemu:qtest+qtest-hppa / qtest-hppa/readconfig-test             =
                     OK               0.31s   2 subtests passed
   412/1037 qemu:qtest+qtest-avr / qtest-avr/qmp-test                      =
                     OK               0.64s   4 subtests passed
   413/1037 qemu:qtest+qtest-i386 / qtest-i386/test-netfilter              =
                     OK               0.20s   4 subtests passed
   414/1037 qemu:qtest+qtest-i386 / qtest-i386/test-filter-mirror          =
                     OK               0.25s   1 subtests passed
   415/1037 qemu:qtest+qtest-i386 / qtest-i386/vmcoreinfo-test             =
                     OK               0.24s   1 subtests passed
   416/1037 qemu:qtest+qtest-i386 / qtest-i386/test-filter-redirector      =
                     OK               0.42s   2 subtests passed
   417/1037 qemu:qtest+qtest-hppa / qtest-hppa/qmp-test                    =
                     OK               0.68s   4 subtests passed
   418/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_adc-test              =
                     OK               2.26s   6 subtests passed
   419/1037 qemu:qtest+qtest-i386 / qtest-i386/ipmi-kcs-test               =
                     OK               0.21s   5 subtests passed
   420/1037 qemu:qtest+qtest-i386 / qtest-i386/ipmi-bt-test                =
                     OK               0.21s   4 subtests passed
   421/1037 qemu:qtest+qtest-hppa / qtest-hppa/display-vga-test            =
                     OK               1.22s   6 subtests passed
   422/1037 qemu:qtest+qtest-i386 / qtest-i386/i440fx-test                 =
                     OK               0.91s   4 subtests passed
   423/1037 qemu:qtest+qtest-i386 / qtest-i386/endianness-test             =
                     OK               0.81s   3 subtests passed
   424/1037 qemu:func-quick+func-x86_64 / func-x86_64-virtio_version       =
                     OK               5.45s   2 subtests passed
   425/1037 qemu:qtest+qtest-i386 / qtest-i386/i82801b11-test              =
                     OK               0.19s   1 subtests passed
   426/1037 qemu:qtest+qtest-i386 / qtest-i386/pvpanic-test                =
                     OK               0.58s   3 subtests passed
   427/1037 qemu:qtest+qtest-i386 / qtest-i386/numa-test                   =
                     OK               1.20s   6 subtests passed
   428/1037 qemu:qtest+qtest-i386 / qtest-i386/pvpanic-pci-test            =
                     OK               0.60s   3 subtests passed
   429/1037 qemu:qtest+qtest-i386 / qtest-i386/wdt_ib700-test              =
                     OK               0.88s   4 subtests passed
   430/1037 qemu:qtest+qtest-i386 / qtest-i386/ioh3420-test                =
                     OK               0.17s   1 subtests passed
   431/1037 qemu:qtest+qtest-i386 / qtest-i386/lpc-ich9-test               =
                     OK               0.17s   1 subtests passed
   432/1037 qemu:qtest+qtest-i386 / qtest-i386/fdc-test                    =
                     OK               1.60s   14 subtests passed
   433/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/netdev-socket         =
                     OK               4.29s   10 subtests passed
   434/1037 qemu:func-quick+func-ppc / func-ppc-74xx                       =
                     OK               9.78s   12 subtests passed
   435/1037 qemu:qtest+qtest-i386 / qtest-i386/qos-test                    =
                     OK              34.92s   134 subtests passed
   436/1037 qemu:qtest+qtest-i386 / qtest-i386/intel-hda-test              =
                     OK               0.73s   3 subtests passed
   437/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-hace-test     =
                     OK               4.77s   11 subtests passed
   438/1037 qemu:qtest+qtest-i386 / qtest-i386/usb-hcd-uhci-test           =
                     OK               0.37s   3 subtests passed
   439/1037 qemu:qtest+qtest-i386 / qtest-i386/rtc-test                    =
                     OK               0.39s   15 subtests passed
   440/1037 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test                =
                     OK               0.30s   1 subtests passed
   441/1037 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-test                =
                     OK               0.22s   5 subtests passed
   442/1037 qemu:qtest+qtest-i386 / qtest-i386/usb-hcd-xhci-test           =
                     OK               0.35s   3 subtests passed
   443/1037 qemu:qtest+qtest-i386 / qtest-i386/usb-hcd-ehci-test           =
                     OK               0.36s   6 subtests passed
   444/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-e1000e-test            =
                     OK               0.20s   1 subtests passed
   445/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-virtio-scsi-test       =
                     OK               0.17s   1 subtests passed
   446/1037 qemu:qtest+qtest-i386 / qtest-i386/rtl8139-test                =
                     OK               0.37s   2 subtests passed
   447/1037 qemu:qtest+qtest-alpha / qtest-alpha/netdev-socket             =
                     OK               4.20s   10 subtests passed
   448/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-megasas-test           =
                     OK               0.35s   2 subtests passed
   449/1037 qemu:qtest+qtest-i386 / qtest-i386/intel-iommu-test            =
                     OK               0.18s   1 subtests passed
   450/1037 qemu:qtest+qtest-i386 / qtest-i386/erst-test                   =
                     OK               0.18s   1 subtests passed
   451/1037 qemu:qtest+qtest-i386 / qtest-i386/virtio-balloon-test         =
                     OK               0.36s   2 subtests passed
   452/1037 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-swtpm-test          =
                     OK               0.58s   2 subtests passed
   453/1037 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-swtpm-test          =
                     OK               0.54s   2 subtests passed
   454/1037 qemu:qtest+qtest-i386 / qtest-i386/tco-test                    =
                     OK               2.38s   11 subtests passed
   455/1037 qemu:qtest+qtest-i386 / qtest-i386/fw_cfg-test                 =
                     OK               2.36s   12 subtests passed
   456/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-sdcard-test            =
                     OK               0.58s   3 subtests passed
   457/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-lsi53c895a-test        =
                     OK               0.79s   3 subtests passed
   458/1037 qemu:qtest+qtest-i386 / qtest-i386/fuzz-sb16-test              =
                     OK               0.78s   3 subtests passed
   459/1037 qemu:qtest+qtest-i386 / qtest-i386/machine-none-test           =
                     OK               0.19s   1 subtests passed
   460/1037 qemu:qtest+qtest-arm / qtest-arm/microbit-test                 =
                     OK               3.81s   6 subtests passed
   461/1037 qemu:qtest+qtest-i386 / qtest-i386/ivshmem-test                =
                     OK               0.60s   3 subtests passed
   462/1037 qemu:qtest+qtest-i386 / qtest-i386/device-plug-test            =
                     OK               0.64s   2 subtests passed
   463/1037 qemu:qtest+qtest-i386 / qtest-i386/vnc-display-test            =
                     OK               0.18s   1 subtests passed
   464/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/test-netfilter=
                     OK               0.27s   4 subtests passed
   465/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/test-filter-mi=
rror                 OK               0.23s   1 subtests passed
   466/1037 qemu:qtest+qtest-i386 / qtest-i386/q35-test                    =
                     OK               1.24s   6 subtests passed
   467/1037 qemu:qtest+qtest-i386 / qtest-i386/qmp-test                    =
                     OK               0.64s   4 subtests passed
   468/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/test-filter-re=
director             OK               0.37s   2 subtests passed
   469/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/machine-none-t=
est                  OK               0.17s   1 subtests passed
   470/1037 qemu:qtest+qtest-i386 / qtest-i386/cpu-plug-test               =
                     OK               0.91s   4 subtests passed
   471/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test =
                     OK               0.31s   1 subtests passed
   472/1037 qemu:qtest+qtest-avr / qtest-avr/netdev-socket                 =
                     OK               3.80s   10 subtests passed
   473/1037 qemu:qtest+qtest-arm / qtest-arm/netdev-socket                 =
                     OK               4.02s   10 subtests passed
   474/1037 qemu:qtest+qtest-i386 / qtest-i386/display-vga-test            =
                     OK               1.35s   6 subtests passed
   475/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/vnc-display-te=
st                   OK               0.18s   1 subtests passed
   476/1037 qemu:qtest+qtest-m68k / qtest-m68k/test-netfilter              =
                     OK               0.15s   4 subtests passed
   477/1037 qemu:qtest+qtest-m68k / qtest-m68k/test-filter-mirror          =
                     OK               0.15s   1 subtests passed
   478/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/readconfig-tes=
t                    OK               0.30s   2 subtests passed
   479/1037 qemu:qtest+qtest-m68k / qtest-m68k/machine-none-test           =
                     OK               0.14s   1 subtests passed
   480/1037 qemu:qtest+qtest-m68k / qtest-m68k/vnc-display-test            =
                     OK               0.15s   1 subtests passed
   481/1037 qemu:qtest+qtest-m68k / qtest-m68k/test-filter-redirector      =
                     OK               0.30s   2 subtests passed
   482/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/test-netfilter  =
                     OK               0.18s   4 subtests passed
   483/1037 qemu:qtest+qtest-m68k / qtest-m68k/readconfig-test             =
                     OK               0.29s   2 subtests passed
   484/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qmp-test      =
                     OK               0.59s   4 subtests passed
   485/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/test-filter-mirr=
or                   OK               0.14s   1 subtests passed
   486/1037 qemu:qtest+qtest-hppa / qtest-hppa/netdev-socket               =
                     OK               4.08s   10 subtests passed
   487/1037 qemu:qtest+qtest-i386 / qtest-i386/am53c974-test               =
                     OK               2.00s   11 subtests passed
   488/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/machine-none-tes=
t                    OK               0.15s   1 subtests passed
   489/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/numa-test     =
                     OK               1.00s   5 subtests passed
   490/1037 qemu:qtest+qtest-i386 / qtest-i386/readconfig-test             =
                     OK               1.37s   6 subtests passed
   491/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/test-filter-redi=
rector               OK               0.31s   2 subtests passed
   492/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/vnc-display-test=
                     OK               0.20s   1 subtests passed
   493/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/test-netfilt=
er                   OK               0.19s   4 subtests passed
   494/1037 qemu:qtest+qtest-m68k / qtest-m68k/qmp-test                    =
                     OK               0.59s   4 subtests passed
   495/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/test-filter-=
mirror               OK               0.16s   1 subtests passed
   496/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/readconfig-test =
                     OK               0.29s   2 subtests passed
   497/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/machine-none=
-test                OK               0.17s   1 subtests passed
   498/1037 qemu:qtest+qtest-mips / qtest-mips/test-netfilter              =
                     OK               0.18s   4 subtests passed
   499/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/vnc-display-=
test                 OK               0.19s   1 subtests passed
   500/1037 qemu:qtest+qtest-i386 / qtest-i386/dbus-display-test           =
                     OK               1.83s   4 subtests passed
   501/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/test-filter-=
redirector           OK               0.30s   2 subtests passed
   502/1037 qemu:qtest+qtest-mips / qtest-mips/test-filter-mirror          =
                     OK               0.20s   1 subtests passed
   503/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/readconfig-t=
est                  OK               0.29s   2 subtests passed
   504/1037 qemu:qtest+qtest-i386 / qtest-i386/boot-order-test             =
                     OK               2.17s   1 subtests passed
   505/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/qmp-test        =
                     OK               0.60s   4 subtests passed
   506/1037 qemu:qtest+qtest-i386 / qtest-i386/cxl-test                    =
                     OK               2.27s   12 subtests passed
   507/1037 qemu:qtest+qtest-mips / qtest-mips/machine-none-test           =
                     OK               0.16s   1 subtests passed
   508/1037 qemu:qtest+qtest-mips / qtest-mips/vnc-display-test            =
                     OK               0.17s   1 subtests passed
   509/1037 qemu:qtest+qtest-mips / qtest-mips/test-filter-redirector      =
                     OK               0.35s   2 subtests passed
   510/1037 qemu:qtest+qtest-mips64 / qtest-mips64/test-filter-mirror      =
                     OK               0.16s   1 subtests passed
   511/1037 qemu:qtest+qtest-mips64 / qtest-mips64/test-netfilter          =
                     OK               0.19s   4 subtests passed
   512/1037 qemu:qtest+qtest-mips / qtest-mips/readconfig-test             =
                     OK               0.31s   2 subtests passed
   513/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/qmp-test    =
                     OK               0.65s   4 subtests passed
   514/1037 qemu:qtest+qtest-mips64 / qtest-mips64/machine-none-test       =
                     OK               0.17s   1 subtests passed
   515/1037 qemu:qtest+qtest-mips64 / qtest-mips64/test-filter-redirector  =
                     OK               0.41s   2 subtests passed
   516/1037 qemu:qtest+qtest-i386 / qtest-i386/drive_del-test              =
                     OK               2.65s   12 subtests passed
   517/1037 qemu:qtest+qtest-mips64 / qtest-mips64/vnc-display-test        =
                     OK               0.16s   1 subtests passed
   518/1037 qemu:qtest+qtest-mips64 / qtest-mips64/readconfig-test         =
                     OK               0.30s   2 subtests passed
   519/1037 qemu:qtest+qtest-mips / qtest-mips/endianness-test             =
                     OK               0.67s   3 subtests passed
   520/1037 qemu:qtest+qtest-mips / qtest-mips/qmp-test                    =
                     OK               0.65s   4 subtests passed
   521/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/test-netfilter      =
                     OK               0.17s   4 subtests passed
   522/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/test-filter-mirror  =
                     OK               0.15s   1 subtests passed
   523/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/machine-none-test   =
                     OK               0.18s   1 subtests passed
   524/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/test-filter-redirect=
or                   OK               0.32s   2 subtests passed
   525/1037 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-test                =
                     OK               0.63s   4 subtests passed
   526/1037 qemu:qtest+qtest-mips / qtest-mips/display-vga-test            =
                     OK               1.08s   5 subtests passed
   527/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/readconfig-test     =
                     OK               0.30s   2 subtests passed
   528/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/test-netfilter          =
                     OK               0.16s   4 subtests passed
   529/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/vnc-display-test    =
                     OK               0.19s   1 subtests passed
   530/1037 qemu:qtest+qtest-mips64 / qtest-mips64/display-vga-test        =
                     OK               0.94s   5 subtests passed
   531/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/test-filter-mirror      =
                     OK               0.17s   1 subtests passed
   532/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/endianness-test     =
                     OK               0.62s   3 subtests passed
   533/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/machine-none-test       =
                     OK               0.15s   1 subtests passed
   534/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/qmp-test            =
                     OK               0.61s   4 subtests passed
   535/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/test-filter-redirector  =
                     OK               0.33s   2 subtests passed
   536/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/vnc-display-test        =
                     OK               0.17s   1 subtests passed
   537/1037 qemu:qtest+qtest-or1k / qtest-or1k/machine-none-test           =
                     OK               0.15s   1 subtests passed
   538/1037 qemu:qtest+qtest-arm / qtest-arm/aspeed_hace-test              =
                     OK               7.54s   30 subtests passed
   539/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/readconfig-test         =
                     OK               0.32s   2 subtests passed
   540/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/display-vga-test    =
                     OK               1.07s   6 subtests passed
   541/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/endianness-test         =
                     OK               0.63s   3 subtests passed
   542/1037 qemu:qtest+qtest-or1k / qtest-or1k/vnc-display-test            =
                     OK               0.21s   1 subtests passed
   543/1037 qemu:qtest+qtest-mips64 / qtest-mips64/endianness-test         =
                     OK               1.56s   9 subtests passed
   544/1037 qemu:func-quick+func-x86_64 / func-x86_64-mem_addr_space       =
                     OK              10.50s   15 subtests passed
   545/1037 qemu:qtest+qtest-or1k / qtest-or1k/readconfig-test             =
                     OK               0.31s   2 subtests passed
   546/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/qmp-test                =
                     OK               0.64s   4 subtests passed
   547/1037 qemu:qtest+qtest-ppc / qtest-ppc/test-netfilter                =
                     OK               0.19s   4 subtests passed
   548/1037 qemu:qtest+qtest-ppc / qtest-ppc/test-filter-mirror            =
                     OK               0.19s   1 subtests passed
   549/1037 qemu:qtest+qtest-ppc / qtest-ppc/machine-none-test             =
                     OK               0.15s   1 subtests passed
   550/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/display-vga-test        =
                     OK               0.95s   5 subtests passed
   551/1037 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_smbus-test            =
                     OK               7.73s   40 subtests passed
   552/1037 qemu:qtest+qtest-ppc / qtest-ppc/test-filter-redirector        =
                     OK               0.35s   2 subtests passed
   553/1037 qemu:qtest+qtest-or1k / qtest-or1k/qmp-test                    =
                     OK               0.63s   4 subtests passed
   554/1037 qemu:qtest+qtest-ppc / qtest-ppc/readconfig-test               =
                     OK               0.29s   2 subtests passed
   555/1037 qemu:qtest+qtest-ppc / qtest-ppc/vnc-display-test              =
                     OK               0.20s   1 subtests passed
   556/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/test-netfilter            =
                     OK               0.21s   4 subtests passed
   557/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/test-filter-mirror        =
                     OK               0.21s   1 subtests passed
   558/1037 qemu:qtest+qtest-i386 / qtest-i386/netdev-socket               =
                     OK               3.98s   10 subtests passed
   559/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/test-filter-redirector    =
                     OK               0.33s   2 subtests passed
   560/1037 qemu:qtest+qtest-ppc / qtest-ppc/qmp-test                      =
                     OK               0.61s   4 subtests passed
   561/1037 qemu:qtest+qtest-arm / qtest-arm/aspeed_smc-test               =
                     OK              49.06s   34 subtests passed
   562/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/pnv-spi-seeprom-test      =
                     OK               0.27s   1 subtests passed
   563/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/pnv-xive2-test            =
                     OK               0.36s   1 subtests passed
   564/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/netdev-socket =
                     OK               3.90s   10 subtests passed
   565/1037 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test            =
                     OK              53.53s   53 subtests passed
   566/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/rtas-test                 =
                     OK               0.34s   2 subtests passed
   567/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/usb-hcd-uhci-test         =
                     OK               0.34s   3 subtests passed
   568/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/usb-hcd-xhci-test         =
                     OK               0.43s   3 subtests passed
   569/1037 qemu:qtest+qtest-m68k / qtest-m68k/netdev-socket               =
                     OK               3.88s   10 subtests passed
   570/1037 qemu:qtest+qtest-ppc / qtest-ppc/boot-order-test               =
                     OK               1.47s   2 subtests passed
   571/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/machine-none-test         =
                     OK               0.17s   1 subtests passed
   572/1037 qemu:qtest+qtest-i386 / qtest-i386/test-x86-cpuid-compat       =
                     OK               7.25s   35 subtests passed
   573/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/pnv-host-i2c-test         =
                     OK               0.86s   4 subtests passed
   574/1037 qemu:qtest+qtest-microblaze / qtest-microblaze/netdev-socket   =
                     OK               3.82s   10 subtests passed
   575/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/cpu-plug-test             =
                     OK               0.51s   2 subtests passed
   576/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/numa-test                 =
                     OK               0.98s   5 subtests passed
   577/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/device-plug-test          =
                     OK               1.27s   5 subtests passed
   578/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/vnc-display-test          =
                     OK               0.17s   1 subtests passed
   579/1037 qemu:qtest+qtest-microblazeel / qtest-microblazeel/netdev-socke=
t                    OK               3.72s   10 subtests passed
   580/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/ivshmem-test              =
                     OK               0.61s   3 subtests passed
   581/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/endianness-test           =
                     OK               1.37s   6 subtests passed
   582/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/machine-none-test     =
                     OK               0.16s   1 subtests passed
   583/1037 qemu:qtest+qtest-ppc / qtest-ppc/endianness-test               =
                     OK               1.76s   9 subtests passed
   584/1037 qemu:qtest+qtest-i386 / qtest-i386/virtio-net-failover         =
                     OK               5.77s   23 subtests passed
   585/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/readconfig-test           =
                     OK               0.31s   2 subtests passed
   586/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/boot-order-test           =
                     OK               1.43s   2 subtests passed
   587/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/machine-none-test     =
                     OK               0.15s   1 subtests passed
   588/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/vnc-display-test      =
                     OK               0.19s   1 subtests passed
   589/1037 qemu:qtest+qtest-rx / qtest-rx/machine-none-test               =
                     OK               0.14s   1 subtests passed
   590/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/qmp-test                  =
                     OK               0.61s   4 subtests passed
   591/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/readconfig-test       =
                     OK               0.29s   2 subtests passed
   592/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/vnc-display-test      =
                     OK               0.21s   1 subtests passed
   593/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/riscv-csr-test        =
                     OK               0.31s   1 subtests passed
   594/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/pnv-xscom-test            =
                     OK               1.52s   8 subtests passed
   595/1037 qemu:qtest+qtest-mips / qtest-mips/netdev-socket               =
                     OK               3.77s   10 subtests passed
   596/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/readconfig-test       =
                     OK               0.32s   2 subtests passed
   597/1037 qemu:qtest+qtest-s390x / qtest-s390x/test-netfilter            =
                     OK               0.16s   4 subtests passed
   598/1037 qemu:qtest+qtest-rx / qtest-rx/vnc-display-test                =
                     OK               0.17s   1 subtests passed
   599/1037 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-mirror        =
                     OK               0.16s   1 subtests passed
   600/1037 qemu:qtest+qtest-rx / qtest-rx/readconfig-test                 =
                     OK               0.30s   2 subtests passed
   601/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/qmp-test              =
                     OK               0.61s   4 subtests passed
   602/1037 qemu:qtest+qtest-s390x / qtest-s390x/machine-none-test         =
                     OK               0.17s   1 subtests passed
   603/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/display-vga-test          =
                     OK               1.25s   6 subtests passed
   604/1037 qemu:qtest+qtest-s390x / qtest-s390x/test-filter-redirector    =
                     OK               0.33s   2 subtests passed
   605/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/qmp-test              =
                     OK               0.59s   4 subtests passed
   606/1037 qemu:qtest+qtest-s390x / qtest-s390x/vnc-display-test          =
                     OK               0.16s   1 subtests passed
   607/1037 qemu:qtest+qtest-s390x / qtest-s390x/readconfig-test           =
                     OK               0.29s   2 subtests passed
   608/1037 qemu:qtest+qtest-rx / qtest-rx/qmp-test                        =
                     OK               0.57s   4 subtests passed
   609/1037 qemu:qtest+qtest-mips64 / qtest-mips64/netdev-socket           =
                     OK               3.83s   10 subtests passed
   610/1037 qemu:qtest+qtest-sh4 / qtest-sh4/machine-none-test             =
                     OK               0.16s   1 subtests passed
   611/1037 qemu:qtest+qtest-s390x / qtest-s390x/cpu-plug-test             =
                     OK               0.47s   2 subtests passed
   612/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/machine-none-test         =
                     OK               0.14s   1 subtests passed
   613/1037 qemu:qtest+qtest-sh4 / qtest-sh4/vnc-display-test              =
                     OK               0.19s   1 subtests passed
   614/1037 qemu:qtest+qtest-sh4 / qtest-sh4/readconfig-test               =
                     OK               0.29s   2 subtests passed
   615/1037 qemu:qtest+qtest-s390x / qtest-s390x/device-plug-test          =
                     OK               0.62s   3 subtests passed
   616/1037 qemu:qtest+qtest-s390x / qtest-s390x/qmp-test                  =
                     OK               0.62s   4 subtests passed
   617/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/vnc-display-test          =
                     OK               0.18s   1 subtests passed
   618/1037 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qos-test      =
                     OK              37.93s   127 subtests passed
   619/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/readconfig-test           =
                     OK               0.29s   2 subtests passed
   620/1037 qemu:qtest+qtest-sparc / qtest-sparc/test-netfilter            =
                     OK               0.17s   4 subtests passed
   621/1037 qemu:qtest+qtest-sparc / qtest-sparc/test-filter-mirror        =
                     OK               0.16s   1 subtests passed
   622/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/drive_del-test            =
                     OK               1.72s   8 subtests passed
   623/1037 qemu:qtest+qtest-sh4 / qtest-sh4/qmp-test                      =
                     OK               0.59s   4 subtests passed
   624/1037 qemu:qtest+qtest-mips64el / qtest-mips64el/netdev-socket       =
                     OK               3.87s   10 subtests passed
   625/1037 qemu:qtest+qtest-sparc / qtest-sparc/machine-none-test         =
                     OK               0.14s   1 subtests passed
   626/1037 qemu:qtest+qtest-sparc / qtest-sparc/m48t59-test               =
                     OK               0.35s   1 subtests passed
   627/1037 qemu:qtest+qtest-i386 / qtest-i386/hd-geo-test                 =
                     OK               6.91s   23 subtests passed
   628/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/sifive-e-aon-watchdog-=
test                 OK               1.50s   10 subtests passed
   629/1037 qemu:qtest+qtest-sparc / qtest-sparc/vnc-display-test          =
                     OK               0.18s   1 subtests passed
   630/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/test-netfilter        =
                     OK               0.16s   4 subtests passed
   631/1037 qemu:qtest+qtest-sh4 / qtest-sh4/endianness-test               =
                     OK               0.82s   3 subtests passed
   632/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/qmp-test                  =
                     OK               0.62s   4 subtests passed
   633/1037 qemu:qtest+qtest-sparc / qtest-sparc/readconfig-test           =
                     OK               0.28s   2 subtests passed
   634/1037 qemu:qtest+qtest-sparc / qtest-sparc/test-filter-redirector    =
                     OK               0.33s   2 subtests passed
   635/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/test-filter-mirror    =
                     OK               0.17s   1 subtests passed
   636/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/machine-none-test     =
                     OK               0.14s   1 subtests passed
   637/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/endianness-test           =
                     OK               0.75s   3 subtests passed
   638/1037 qemu:qtest+qtest-tricore / qtest-tricore/machine-none-test     =
                     OK               0.14s   1 subtests passed
   639/1037 qemu:qtest+qtest-s390x / qtest-s390x/virtio-ccw-test           =
                     OK               1.21s   7 subtests passed
   640/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/test-filter-redirector=
                     OK               0.31s   2 subtests passed
   641/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/vnc-display-test      =
                     OK               0.20s   1 subtests passed
   642/1037 qemu:qtest+qtest-mipsel / qtest-mipsel/netdev-socket           =
                     OK               3.77s   10 subtests passed
   643/1037 qemu:qtest+qtest-tricore / qtest-tricore/vnc-display-test      =
                     OK               0.18s   1 subtests passed
   644/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-netfilter          =
                     OK               0.17s   4 subtests passed
   645/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/readconfig-test       =
                     OK               0.29s   2 subtests passed
   646/1037 qemu:qtest+qtest-tricore / qtest-tricore/readconfig-test       =
                     OK               0.28s   2 subtests passed
   647/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-filter-mirror      =
                     OK               0.16s   1 subtests passed
   648/1037 qemu:qtest+qtest-sparc / qtest-sparc/qmp-test                  =
                     OK               0.58s   4 subtests passed
   649/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/vmcoreinfo-test         =
                     OK               0.20s   1 subtests passed
   650/1037 qemu:qtest+qtest-s390x / qtest-s390x/drive_del-test            =
                     OK               1.51s   8 subtests passed
   651/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/endianness-test       =
                     OK               0.62s   3 subtests passed
   652/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/qos-test                  =
                     OK              32.12s   120 subtests passed
   653/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-filter-redirector  =
                     OK               0.33s   2 subtests passed
   654/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ipmi-kcs-test           =
                     OK               0.18s   5 subtests passed
   655/1037 qemu:qtest+qtest-or1k / qtest-or1k/netdev-socket               =
                     OK               3.84s   10 subtests passed
   656/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/qmp-test              =
                     OK               0.58s   4 subtests passed
   657/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ipmi-bt-test            =
                     OK               0.18s   4 subtests passed
   658/1037 qemu:qtest+qtest-tricore / qtest-tricore/qmp-test              =
                     OK               0.60s   4 subtests passed
   659/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/i82801b11-test          =
                     OK               0.19s   1 subtests passed
   660/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ioh3420-test            =
                     OK               0.18s   1 subtests passed
   661/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/lpc-ich9-test           =
                     OK               0.18s   1 subtests passed
   662/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test            =
                     OK               0.23s   1 subtests passed
   663/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/rtc-test                =
                     OK               0.33s   15 subtests passed
   664/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/pvpanic-test            =
                     OK               0.50s   3 subtests passed
   665/1037 qemu:qtest+qtest-ppc / qtest-ppc/netdev-socket                 =
                     OK               3.91s   10 subtests passed
   666/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/usb-hcd-uhci-test       =
                     OK               0.34s   3 subtests passed
   667/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/i440fx-test             =
                     OK               0.74s   4 subtests passed
   668/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/endianness-test         =
                     OK               0.69s   3 subtests passed
   669/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/pvpanic-pci-test        =
                     OK               0.56s   3 subtests passed
   670/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/usb-hcd-ehci-test       =
                     OK               0.36s   6 subtests passed
   671/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/usb-hcd-xhci-test       =
                     OK               0.34s   3 subtests passed
   672/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-e1000e-test        =
                     OK               0.16s   1 subtests passed
   673/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/wdt_ib700-test          =
                     OK               0.70s   4 subtests passed
   674/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/intel-hda-test          =
                     OK               0.67s   3 subtests passed
   675/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/am53c974-test           =
                     SKIP             0.01s
   676/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-test            =
                     OK               0.23s   5 subtests passed
   677/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-virtio-scsi-test   =
                     OK               0.18s   1 subtests passed
   678/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/rtl8139-test            =
                     OK               0.38s   2 subtests passed
   679/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/erst-test               =
                     OK               0.18s   1 subtests passed
   680/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/intel-iommu-test        =
                     OK               0.19s   1 subtests passed
   681/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-megasas-test       =
                     OK               0.39s   2 subtests passed
   682/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-balloon-test     =
                     OK               0.34s   2 subtests passed
   683/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fdc-test                =
                     OK               1.18s   14 subtests passed
   684/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-swtpm-test      =
                     OK               0.54s   2 subtests passed
   685/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-swtpm-test      =
                     OK               0.54s   2 subtests passed
   686/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-lsi53c895a-test    =
                     OK               0.62s   3 subtests passed
   687/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-sdcard-test        =
                     OK               0.49s   3 subtests passed
   688/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fuzz-sb16-test          =
                     OK               0.64s   3 subtests passed
   689/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/machine-none-test       =
                     OK               0.15s   1 subtests passed
   690/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/numa-test               =
                     OK               1.58s   9 subtests passed
   691/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/q35-test                =
                     OK               1.01s   6 subtests passed
   692/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/tco-test                =
                     OK               1.92s   11 subtests passed
   693/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/fw_cfg-test             =
                     OK               1.96s   12 subtests passed
   694/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/ivshmem-test            =
                     OK               0.84s   4 subtests passed
   695/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/vnc-display-test        =
                     OK               0.16s   1 subtests passed
   696/1037 qemu:qtest+qtest-ppc64 / qtest-ppc64/netdev-socket             =
                     OK               3.82s   10 subtests passed
   697/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/machine-none-test       =
                     OK               0.14s   1 subtests passed
   698/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/cpu-plug-test           =
                     OK               0.80s   4 subtests passed
   699/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/netdev-socket         =
                     OK               3.73s   10 subtests passed
   700/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-test                =
                     OK               0.59s   4 subtests passed
   701/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/device-plug-test        =
                     OK               1.03s   4 subtests passed
   702/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/machine-none-test   =
                     OK               0.18s   1 subtests passed
   703/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/vnc-display-test        =
                     OK               0.21s   1 subtests passed
   704/1037 qemu:unit / check-block-qdict                                  =
                     OK               0.01s   10 subtests passed
   705/1037 qemu:unit / check-qdict                                        =
                     OK               0.01s   15 subtests passed
   706/1037 qemu:unit / check-qnum                                         =
                     OK               0.01s   8 subtests passed
   707/1037 qemu:unit / check-qstring                                      =
                     OK               0.01s   4 subtests passed
   708/1037 qemu:unit / check-qlist                                        =
                     OK               0.01s   4 subtests passed
   709/1037 qemu:unit / check-qnull                                        =
                     OK               0.01s   2 subtests passed
   710/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/netdev-socket         =
                     OK               3.79s   10 subtests passed
   711/1037 qemu:unit / check-qobject                                      =
                     OK               0.01s   7 subtests passed
   712/1037 qemu:unit / check-qlit                                         =
                     OK               0.01s   2 subtests passed
   713/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/display-vga-test        =
                     OK               1.14s   6 subtests passed
   714/1037 qemu:unit / test-qobject-output-visitor                        =
                     OK               0.01s   16 subtests passed
   715/1037 qemu:unit / test-error-report                                  =
                     OK               0.02s   5 subtests passed
   716/1037 qemu:unit / test-clone-visitor                                 =
                     OK               0.01s   7 subtests passed
   717/1037 qemu:unit / check-qjson                                        =
                     OK               0.04s   31 subtests passed
   718/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/readconfig-test         =
                     OK               0.31s   2 subtests passed
   719/1037 qemu:unit / test-qobject-input-visitor                         =
                     OK               0.02s   42 subtests passed
   720/1037 qemu:unit / test-forward-visitor                               =
                     OK               0.02s   7 subtests passed
   721/1037 qemu:unit / test-string-input-visitor                          =
                     OK               0.03s   8 subtests passed
   722/1037 qemu:unit / test-string-output-visitor                         =
                     OK               0.03s   14 subtests passed
   723/1037 qemu:qtest+qtest-rx / qtest-rx/netdev-socket                   =
                     OK               3.73s   10 subtests passed
   724/1037 qemu:unit / test-visitor-serialization                         =
                     OK               0.03s   156 subtests passed
   725/1037 qemu:unit / test-bitmap                                        =
                     OK               0.04s   2 subtests passed
   726/1037 qemu:unit / test-resv-mem                                      =
                     OK               0.04s   3 subtests passed
   727/1037 qemu:unit / test-x86-topo                                      =
                     OK               0.04s   1 subtests passed
   728/1037 qemu:unit / test-cutils                                        =
                     OK               0.03s   179 subtests passed
   729/1037 qemu:unit / test-div128                                        =
                     OK               0.03s   2 subtests passed
   730/1037 qemu:unit / test-shift128                                      =
                     OK               0.03s   2 subtests passed
   731/1037 qemu:unit / test-mul64                                         =
                     OK               0.03s   2 subtests passed
   732/1037 qemu:unit / test-int128                                        =
                     OK               0.03s   11 subtests passed
   733/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/vnc-display-test    =
                     OK               0.17s   1 subtests passed
   734/1037 qemu:unit / test-qdist                                         =
                     OK               0.01s   8 subtests passed
   735/1037 qemu:unit / test-qtree                                         =
                     OK               0.00s   4 subtests passed
   736/1037 qemu:unit / test-bitops                                        =
                     OK               0.00s   6 subtests passed
   737/1037 qemu:unit / test-bitcnt                                        =
                     OK               0.00s   4 subtests passed
   738/1037 qemu:unit / test-qgraph                                        =
                     OK               0.00s   23 subtests passed
   739/1037 qemu:unit / check-qom-interface                                =
                     OK               0.00s   2 subtests passed
   740/1037 qemu:unit / check-qom-proplist                                 =
                     OK               0.00s   9 subtests passed
   741/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/readconfig-test     =
                     OK               0.29s   2 subtests passed
   742/1037 qemu:unit / test-qemu-opts                                     =
                     OK               0.01s   19 subtests passed
   743/1037 qemu:unit / test-keyval                                        =
                     OK               0.01s   13 subtests passed
   744/1037 qemu:unit / test-qapi-util                                     =
                     OK               0.00s   2 subtests passed
   745/1037 qemu:unit / test-interval-tree                                 =
                     OK               0.00s   6 subtests passed
   746/1037 qemu:unit / test-logging                                       =
                     OK               0.02s   4 subtests passed
   747/1037 qemu:unit / test-fifo                                          =
                     OK               0.01s   10 subtests passed
   748/1037 qemu:unit / test-qmp-event                                     =
                     OK               0.01s   6 subtests passed
   749/1037 qemu:unit / test-seccomp                                       =
                     OK               0.02s   12 subtests passed
   750/1037 qemu:unit / test-coroutine                                     =
                     OK               0.02s   12 subtests passed
   751/1037 qemu:unit / test-throttle                                      =
                     OK               0.02s   17 subtests passed
   752/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/qmp-test                =
                     OK               0.61s   4 subtests passed
   753/1037 qemu:qtest+qtest-s390x / qtest-s390x/netdev-socket             =
                     OK               3.78s   10 subtests passed
   754/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/qmp-test            =
                     OK               0.61s   4 subtests passed
   755/1037 qemu:unit / test-qht                                           =
                     OK               0.32s   2 subtests passed
   756/1037 qemu:unit / test-bdrv-graph-mod                                =
                     OK               0.03s   5 subtests passed
   757/1037 qemu:unit / test-blockjob                                      =
                     OK               0.02s   8 subtests passed
   758/1037 qemu:unit / test-hbitmap                                       =
                     OK               0.14s   40 subtests passed
   759/1037 qemu:unit / test-blockjob-txn                                  =
                     OK               0.02s   7 subtests passed
   760/1037 qemu:unit / test-block-backend                                 =
                     OK               0.02s   2 subtests passed
   761/1037 qemu:unit / test-crypto-hash                                   =
                     OK               0.01s   6 subtests passed
   762/1037 qemu:unit / test-write-threshold                               =
                     OK               0.02s   2 subtests passed
   763/1037 qemu:unit / test-bdrv-drain                                    =
                     OK               0.11s   30 subtests passed
   764/1037 qemu:unit / test-block-iothread                                =
                     OK               0.04s   22 subtests passed
   765/1037 qemu:unit / test-crypto-hmac                                   =
                     OK               0.02s   4 subtests passed
   766/1037 qemu:unit / test-crypto-cipher                                 =
                     OK               0.02s   17 subtests passed
   767/1037 qemu:unit / test-crypto-akcipher                               =
                     OK               0.02s   16 subtests passed
   768/1037 qemu:unit / test-crypto-secret                                 =
                     OK               0.01s   16 subtests passed
   769/1037 qemu:unit / test-crypto-der                                    =
                     OK               0.02s   4 subtests passed
   770/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/readconfig-test         =
                     OK               1.22s   6 subtests passed
   771/1037 qemu:unit / test-authz-simple                                  =
                     OK               0.02s   1 subtests passed
   772/1037 qemu:unit / test-authz-list                                    =
                     OK               0.02s   6 subtests passed
   773/1037 qemu:unit / test-authz-listfile                                =
                     OK               0.02s   5 subtests passed
   774/1037 qemu:unit / test-io-task                                       =
                     OK               0.02s   5 subtests passed
   775/1037 qemu:unit / test-io-channel-file                               =
                     OK               0.02s   5 subtests passed
   776/1037 qemu:unit / test-io-channel-buffer                             =
                     OK               0.02s   1 subtests passed
   777/1037 qemu:unit / test-io-channel-socket                             =
                     OK               0.03s   9 subtests passed
   778/1037 qemu:unit / test-io-channel-null                               =
                     OK               0.02s   1 subtests passed
   779/1037 qemu:unit / test-crypto-ivgen                                  =
                     OK               0.02s   9 subtests passed
   780/1037 qemu:qtest+qtest-sh4 / qtest-sh4/netdev-socket                 =
                     OK               3.74s   10 subtests passed
   781/1037 qemu:unit / test-timed-average                                 =
                     OK               0.02s   1 subtests passed
   782/1037 qemu:unit / test-crypto-afsplit                                =
                     OK               0.03s   4 subtests passed
   783/1037 qemu:unit / test-uuid                                          =
                     OK               0.02s   6 subtests passed
   784/1037 qemu:unit / test-nested-aio-poll                               =
                     SKIP             0.02s   0 subtests passed
   785/1037 qemu:unit / test-crypto-pbkdf                                  =
                     OK               0.02s   17 subtests passed
   786/1037 qemu:unit / test-image-locking                                 =
                     OK               0.03s   2 subtests passed
   787/1037 qemu:unit / ptimer-test                                        =
                     OK               0.03s   576 subtests passed
   788/1037 qemu:unit / test-io-channel-tls                                =
                     OK               0.05s   1 subtests passed
   789/1037 qemu:unit / test-io-channel-command                            =
                     OK               0.09s   4 subtests passed
   790/1037 qemu:unit / test-xs-node                                       =
                     OK               0.02s   7 subtests passed
   791/1037 qemu:unit / test-virtio-dmabuf                                 =
                     OK               0.02s   5 subtests passed
   792/1037 qemu:unit / test-opts-visitor                                  =
                     OK               0.03s   33 subtests passed
   793/1037 qemu:unit / test-qmp-cmds                                      =
                     OK               0.02s   10 subtests passed
   794/1037 qemu:unit / test-util-sockets                                  =
                     OK               0.02s   21 subtests passed
   795/1037 qemu:unit / test-base64                                        =
                     OK               0.02s   4 subtests passed
   796/1037 qemu:unit / test-smp-parse                                     =
                     OK               0.02s   10 subtests passed
   797/1037 qemu:unit / test-vmstate                                       =
                     OK               0.02s   23 subtests passed
   798/1037 qemu:unit / test-yank                                          =
                     OK               0.02s   6 subtests passed
   799/1037 qemu:unit / test-xbzrle                                        =
                     OK               0.04s   6 subtests passed
   800/1037 qemu:unit / test-qdev-global-props                             =
                     OK               0.01s   4 subtests passed
   801/1037 qemu:unit / test-util-filemonitor                              =
                     OK               0.08s   1 subtests passed
   802/1037 qemu:qtest+qtest-sh4eb / qtest-sh4eb/netdev-socket             =
                     OK               3.73s   10 subtests passed
   803/1037 qemu:unit+qga / qga-ssh-test                                   =
                     OK               0.07s
   804/1037 qemu:qapi-schema+qapi-interop / QAPI vhost-user.json regression=
 test                OK               0.04s
   805/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test        =
                     OK              58.77s   62 subtests passed
   806/1037 qemu:qapi-schema+qapi-interop / QAPI firmware.json regression t=
est                  OK               0.07s
   807/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/dbus-display-test       =
                     OK               1.66s   4 subtests passed
   808/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/boot-order-test         =
                     OK               1.90s   1 subtests passed
   809/1037 qemu:unit / xml-preprocess                                     =
                     OK               0.14s
   810/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/cxl-test                =
                     OK               2.01s   12 subtests passed
   811/1037 qemu:qtest+qtest-sparc / qtest-sparc/netdev-socket             =
                     OK               3.71s   10 subtests passed
   812/1037 qemu:block / io-qcow2-009                                      =
                     OK               0.22s   1 subtests passed
   813/1037 qemu:unit / test-iov                                           =
                     OK               0.53s   6 subtests passed
   814/1037 qemu:block / io-qcow2-005                                      =
                     OK               0.37s   1 subtests passed
   815/1037 qemu:qtest+qtest-tricore / qtest-tricore/netdev-socket         =
                     OK               3.64s   10 subtests passed
   816/1037 qemu:block / io-qcow2-004                                      =
                     OK               0.47s   1 subtests passed
   817/1037 qemu:qtest+qtest-sparc64 / qtest-sparc64/netdev-socket         =
                     OK               3.77s   10 subtests passed
   818/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/drive_del-test          =
                     OK               2.37s   12 subtests passed
   819/1037 qemu:block / io-qcow2-012                                      =
                     OK               0.26s   1 subtests passed
   820/1037 qemu:block / io-qcow2-010                                      =
                     OK               0.38s   1 subtests passed
   821/1037 qemu:block / io-qcow2-008                                      =
                     OK               0.69s   1 subtests passed
   822/1037 qemu:block / io-qcow2-001                                      =
                     OK               0.82s   1 subtests passed
   823/1037 qemu:block / io-qcow2-003                                      =
                     OK               0.78s   1 subtests passed
   824/1037 qemu:block / io-qcow2-011                                      =
                     OK               0.69s   1 subtests passed
   825/1037 qemu:block / io-qcow2-002                                      =
                     OK               1.10s   1 subtests passed
   826/1037 qemu:block / io-qcow2-027                                      =
                     OK               0.39s   1 subtests passed
   827/1037 qemu:block / io-qcow2-021                                      =
                     OK               0.69s   1 subtests passed
   828/1037 qemu:unit / rcutorture                                         =
                     OK               2.02s   2 subtests passed
   829/1037 qemu:block / io-qcow2-017                                      =
                     OK               0.95s   1 subtests passed
   830/1037 qemu:block / io-qcow2-032                                      =
                     OK               0.31s   1 subtests passed
   831/1037 qemu:block / io-qcow2-018                                      =
                     OK               1.05s   1 subtests passed
   832/1037 qemu:block / io-qcow2-025                                      =
                     OK               0.85s   1 subtests passed
   833/1037 qemu:block / io-qcow2-031                                      =
                     OK               0.58s   1 subtests passed
   834/1037 qemu:unit / test-char                                          =
                     OK               2.06s   40 subtests passed
   835/1037 qemu:block / io-qcow2-019                                      =
                     OK               1.48s   1 subtests passed
   836/1037 qemu:block / io-qcow2-038                                      =
                     OK               0.58s   1 subtests passed
   837/1037 qemu:block / io-qcow2-007                                      =
                     OK               2.26s   1 subtests passed
   838/1037 qemu:block / io-qcow2-020                                      =
                     OK               1.73s   1 subtests passed
   839/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/netdev-socket           =
                     OK               3.89s   10 subtests passed
   840/1037 qemu:block / io-qcow2-022                                      =
                     OK               1.92s   1 subtests passed
   841/1037 qemu:block / io-qcow2-036                                      =
                     OK               1.09s   1 subtests passed
   842/1037 qemu:block / io-qcow2-034                                      =
                     OK               1.27s   1 subtests passed
   843/1037 qemu:block / io-qcow2-042                                      =
                     OK               0.40s   1 subtests passed
   844/1037 qemu:block / io-qcow2-037                                      =
                     OK               1.25s   1 subtests passed
   845/1037 qemu:block / io-qcow2-047                                      =
                     OK               0.31s   1 subtests passed
   846/1037 qemu:qtest+qtest-xtensa / qtest-xtensa/netdev-socket           =
                     OK               3.87s   10 subtests passed
   847/1037 qemu:block / io-qcow2-046                                      =
                     OK               0.60s   1 subtests passed
   848/1037 qemu:unit / test-aio                                           =
                     OK               3.53s   27 subtests passed
   849/1037 qemu:qtest+qtest-xtensaeb / qtest-xtensaeb/netdev-socket       =
                     OK               3.89s   10 subtests passed
   850/1037 qemu:block / io-qcow2-054                                      =
                     OK               0.27s   1 subtests passed
   851/1037 qemu:block / io-qcow2-053                                      =
                     OK               0.42s   1 subtests passed
   852/1037 qemu:block / io-qcow2-052                                      =
                     OK               0.59s   1 subtests passed
   853/1037 qemu:block / io-qcow2-033                                      =
                     OK               1.93s   1 subtests passed
   854/1037 qemu:block / io-qcow2-050                                      =
                     OK               0.65s   1 subtests passed
   855/1037 qemu:block / io-qcow2-043                                      =
                     OK               0.98s   1 subtests passed
   856/1037 qemu:block / io-qcow2-062                                      =
                     OK               0.37s   1 subtests passed
   857/1037 qemu:unit / test-rcu-list                                      =
                     OK               4.01s   3 subtests passed
   858/1037 qemu:unit / test-rcu-simpleq                                   =
                     OK               4.01s   3 subtests passed
   859/1037 qemu:unit / test-rcu-tailq                                     =
                     OK               4.01s   3 subtests passed
   860/1037 qemu:unit / test-rcu-slist                                     =
                     OK               4.02s   3 subtests passed
   861/1037 qemu:unit / test-thread-pool                                   =
                     OK               4.02s   6 subtests passed
   862/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover     =
                     OK               5.59s   23 subtests passed
   863/1037 qemu:block / io-qcow2-069                                      =
                     OK               0.34s   1 subtests passed
   864/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-x86-cpuid-compat   =
                     OK               6.51s   35 subtests passed
   865/1037 qemu:block / io-qcow2-072                                      =
                     OK               0.43s   1 subtests passed
   866/1037 qemu:block / io-qcow2-039                                      =
                     OK               2.02s   1 subtests passed
   867/1037 qemu:block / io-qcow2-090                                      =
                     OK               0.36s   1 subtests passed
   868/1037 qemu:block / io-qcow2-029                                      =
                     OK               2.69s   1 subtests passed
   869/1037 qemu:block / io-qcow2-086                                      =
                     OK               0.54s   1 subtests passed
   870/1037 qemu:block / io-qcow2-074                                      =
                     OK               0.63s   1 subtests passed
   871/1037 qemu:block / io-qcow2-048                                      =
                     OK               1.35s   1 subtests passed
   872/1037 qemu:block / io-qcow2-104                                      =
                     OK               0.33s   1 subtests passed
   873/1037 qemu:block / io-qcow2-107                                      =
                     OK               0.30s   1 subtests passed
   874/1037 qemu:unit / test-qga                                           =
                     OK               4.12s   29 subtests passed
   875/1037 qemu:block / io-qcow2-063                                      =
                     OK               1.03s   1 subtests passed
   876/1037 qemu:block / io-qcow2-111                                      =
                     OK               0.17s   1 subtests passed
   877/1037 qemu:block / io-qcow2-089                                      =
                     OK               0.88s   1 subtests passed
   878/1037 qemu:block / io-qcow2-105                                      =
                     OK               0.56s   1 subtests passed
   879/1037 qemu:block / io-qcow2-024                                      =
                     OK               3.57s   1 subtests passed
   880/1037 qemu:block / io-qcow2-110                                      =
                     OK               0.51s   1 subtests passed
   881/1037 qemu:block / io-qcow2-099                                      =
                     OK               0.85s   1 subtests passed
   882/1037 qemu:block / io-qcow2-071                                      =
                     OK               1.28s   1 subtests passed
   883/1037 qemu:block / io-qcow2-117                                      =
                     OK               0.51s   1 subtests passed
   884/1037 qemu:block / io-qcow2-103                                      =
                     OK               1.00s   1 subtests passed
   885/1037 qemu:block / io-qcow2-120                                      =
                     OK               0.56s   1 subtests passed
   886/1037 qemu:block / io-qcow2-114                                      =
                     OK               0.81s   1 subtests passed
   887/1037 qemu:block / io-qcow2-066                                      =
                     OK               1.66s   1 subtests passed
   888/1037 qemu:block / io-qcow2-143                                      =
                     OK               0.26s   1 subtests passed
   889/1037 qemu:block / io-qcow2-126                                      =
                     OK               0.77s   1 subtests passed
   890/1037 qemu:block / io-qcow2-138                                      =
                     OK               0.57s   1 subtests passed
   891/1037 qemu:block / io-qcow2-140                                      =
                     OK               0.52s   1 subtests passed
   892/1037 qemu:block / io-qcow2-150                                      =
                     OK               0.41s   1 subtests passed
   893/1037 qemu:block / io-qcow2-133                                      =
                     OK               0.89s   1 subtests passed
   894/1037 qemu:block / io-qcow2-127                                      =
                     OK               1.00s   1 subtests passed
   895/1037 qemu:block / io-qcow2-174                                      =
                     OK               0.20s   1 subtests passed
   896/1037 qemu:block / io-qcow2-035                                      =
                     OK               3.81s   1 subtests passed
   897/1037 qemu:block / io-qcow2-137                                      =
                     OK               1.05s   1 subtests passed
   898/1037 qemu:block / io-qcow2-134                                      =
                     OK               1.15s   1 subtests passed
   899/1037 qemu:block / io-qcow2-073                                      =
                     OK               2.25s   1 subtests passed
   900/1037 qemu:block / io-qcow2-170                                      =
                     OK               0.73s   1 subtests passed
   901/1037 qemu:block / io-qcow2-141                                      =
                     OK               1.17s   1 subtests passed
   902/1037 qemu:block / io-qcow2-181                                      =
                     SKIP             0.49s   0 subtests passed
   903/1037 qemu:block / io-qcow2-184                                      =
                     OK               0.67s   1 subtests passed
   904/1037 qemu:block / io-qcow2-158                                      =
                     OK               1.12s   1 subtests passed
   905/1037 qemu:block / io-qcow2-187                                      =
                     OK               0.50s   1 subtests passed
   906/1037 qemu:block / io-qcow2-156                                      =
                     OK               1.33s   1 subtests passed
   907/1037 qemu:block / io-qcow2-192                                      =
                     OK               0.34s   1 subtests passed
   908/1037 qemu:block / io-qcow2-098                                      =
                     OK               2.38s   1 subtests passed
   909/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/hd-geo-test             =
                     OK               7.82s   23 subtests passed
   910/1037 qemu:block / io-qcow2-220                                      =
                     SKIP             0.16s   0 subtests passed
   911/1037 qemu:block / io-qcow2-226                                      =
                     OK               0.35s   1 subtests passed
   912/1037 qemu:block / io-qcow2-177                                      =
                     OK               1.34s   1 subtests passed
   913/1037 qemu:block / io-qcow2-203                                      =
                     OK               0.60s   1 subtests passed
   914/1037 qemu:block / io-qcow2-217                                      =
                     OK               0.59s   1 subtests passed
   915/1037 qemu:block / io-qcow2-195                                      =
                     OK               0.88s   1 subtests passed
   916/1037 qemu:block / io-qcow2-229                                      =
                     OK               0.66s   1 subtests passed
   917/1037 qemu:block / io-qcow2-179                                      =
                     OK               1.60s   1 subtests passed
   918/1037 qemu:block / io-qcow2-249                                      =
                     OK               0.65s   1 subtests passed
   919/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test                =
                     OK              32.63s   134 subtests passed
   920/1037 qemu:block / io-qcow2-268                                      =
                     OK               0.32s   1 subtests passed
   921/1037 qemu:block / io-qcow2-265                                      =
                     OK               0.46s   1 subtests passed
   922/1037 qemu:block / io-qcow2-161                                      =
                     OK               2.24s   1 subtests passed
   923/1037 qemu:block / io-qcow2-252                                      =
                     OK               0.70s   1 subtests passed
   924/1037 qemu:block / io-qcow2-214                                      =
                     OK               1.32s   1 subtests passed
   925/1037 qemu:block / io-qcow2-049                                      =
                     OK               4.81s   1 subtests passed
   926/1037 qemu:block / io-qcow2-251                                      =
                     OK               1.16s   1 subtests passed
   927/1037 qemu:block / io-qcow2-299                                      =
                     OK               0.57s   1 subtests passed
   928/1037 qemu:block / io-qcow2-256                                      =
                     OK               1.16s   1 subtests passed
   929/1037 qemu:block / io-qcow2-292                                      =
                     OK               0.75s   1 subtests passed
   930/1037 qemu:block / io-qcow2-097                                      =
                     OK               4.23s   1 subtests passed
   931/1037 qemu:block / io-qcow2-detect-zeroes-registered-buf             =
                     OK               0.29s   1 subtests passed
   932/1037 qemu:block / io-qcow2-283                                      =
                     OK               1.04s   1 subtests passed
   933/1037 qemu:block / io-qcow2-nbd-multiconn                            =
                     SKIP             0.24s   0 subtests passed
   934/1037 qemu:block / io-qcow2-iothreads-resize                         =
                     OK               0.46s   1 subtests passed
   935/1037 qemu:block / io-qcow2-313                                      =
                     OK               1.22s   1 subtests passed
   936/1037 qemu:block / io-qcow2-nbd-qemu-allocation                      =
                     OK               0.63s   1 subtests passed
   937/1037 qemu:block / io-qcow2-190                                      =
                     OK               2.89s   1 subtests passed
   938/1037 qemu:decodetree / err_argset2                                  =
                     OK               0.03s
   939/1037 qemu:decodetree / err_argset1                                  =
                     OK               0.05s
   940/1037 qemu:decodetree / err_field2                                   =
                     OK               0.04s
   941/1037 qemu:decodetree / err_field1                                   =
                     OK               0.06s
   942/1037 qemu:block / io-qcow2-290                                      =
                     OK               1.59s   1 subtests passed
   943/1037 qemu:block / io-qcow2-qsd-jobs                                 =
                     OK               0.42s   1 subtests passed
   944/1037 qemu:decodetree / err_field3                                   =
                     OK               0.04s
   945/1037 qemu:decodetree / err_field5                                   =
                     OK               0.04s
   946/1037 qemu:decodetree / err_field4                                   =
                     OK               0.05s
   947/1037 qemu:decodetree / err_field6                                   =
                     OK               0.04s
   948/1037 qemu:decodetree / err_field7                                   =
                     OK               0.04s
   949/1037 qemu:decodetree / err_field9                                   =
                     OK               0.04s
   950/1037 qemu:decodetree / err_field8                                   =
                     OK               0.06s
   951/1037 qemu:decodetree / err_field10                                  =
                     OK               0.05s
   952/1037 qemu:decodetree / err_init1                                    =
                     OK               0.04s
   953/1037 qemu:decodetree / err_init2                                    =
                     OK               0.05s
   954/1037 qemu:decodetree / err_init3                                    =
                     OK               0.05s
   955/1037 qemu:decodetree / err_init4                                    =
                     OK               0.05s
   956/1037 qemu:decodetree / err_overlap1                                 =
                     OK               0.05s
   957/1037 qemu:decodetree / err_overlap2                                 =
                     OK               0.04s
   958/1037 qemu:decodetree / err_overlap3                                 =
                     OK               0.04s
   959/1037 qemu:block / io-qcow2-regression-vhdx-log                      =
                     OK               0.45s   1 subtests passed
   960/1037 qemu:decodetree / err_overlap4                                 =
                     OK               0.05s
   961/1037 qemu:decodetree / err_overlap5                                 =
                     OK               0.05s
   962/1037 qemu:decodetree / err_overlap6                                 =
                     OK               0.05s
   963/1037 qemu:block / io-qcow2-287                                      =
                     OK               1.96s   1 subtests passed
   964/1037 qemu:decodetree / err_overlap7                                 =
                     OK               0.06s
   965/1037 qemu:decodetree / err_overlap8                                 =
                     OK               0.05s
   966/1037 qemu:decodetree / err_pattern_group_empty                      =
                     OK               0.05s
   967/1037 qemu:decodetree / err_overlap9                                 =
                     OK               0.06s
   968/1037 qemu:decodetree / err_pattern_group_ident2                     =
                     OK               0.04s
   969/1037 qemu:decodetree / err_pattern_group_ident1                     =
                     OK               0.05s
   970/1037 qemu:decodetree / err_pattern_group_nest1                      =
                     OK               0.04s
   971/1037 qemu:decodetree / err_pattern_group_nest2                      =
                     OK               0.04s
   972/1037 qemu:decodetree / err_pattern_group_nest3                      =
                     OK               0.04s
   973/1037 qemu:decodetree / err_width1                                   =
                     OK               0.04s
   974/1037 qemu:decodetree / err_pattern_group_overlap1                   =
                     OK               0.05s
   975/1037 qemu:decodetree / err_width2                                   =
                     OK               0.04s
   976/1037 qemu:decodetree / err_width3                                   =
                     OK               0.05s
   977/1037 qemu:decodetree / err_width4                                   =
                     OK               0.05s
   978/1037 qemu:decodetree / succ_argset_type1                            =
                     OK               0.05s
   979/1037 qemu:block / io-qcow2-iothreads-commit-active                  =
                     OK               1.27s   1 subtests passed
   980/1037 qemu:decodetree / succ_function                                =
                     OK               0.05s
   981/1037 qemu:decodetree / succ_infer1                                  =
                     OK               0.05s
   982/1037 qemu:decodetree / succ_ident1                                  =
                     OK               0.06s
   983/1037 qemu:decodetree / succ_named_field                             =
                     OK               0.06s
   984/1037 qemu:decodetree / succ_pattern_group_nest1                     =
                     OK               0.05s
   985/1037 qemu:decodetree / succ_pattern_group_nest3                     =
                     OK               0.04s
   986/1037 qemu:softfloat+softfloat-conv / fp-test-float-to-float         =
                     OK               0.03s
   987/1037 qemu:softfloat+softfloat-conv / fp-test-int-to-float           =
                     OK               0.03s
   988/1037 qemu:decodetree / succ_pattern_group_nest2                     =
                     OK               0.06s
   989/1037 qemu:decodetree / succ_pattern_group_nest4                     =
                     OK               0.06s
   990/1037 qemu:softfloat+softfloat-conv / fp-test-uint-to-float          =
                     OK               0.04s
   991/1037 qemu:softfloat+softfloat-conv / fp-test-float-to-int           =
                     OK               0.04s
   992/1037 qemu:softfloat+softfloat-conv / fp-test-float-to-uint          =
                     OK               0.04s
   993/1037 qemu:softfloat+softfloat-conv / fp-test-round-to-integer       =
                     OK               0.04s
   994/1037 qemu:block / io-qcow2-iothreads-stream                         =
                     OK               1.27s   1 subtests passed
   995/1037 qemu:softfloat+softfloat-compare / fp-test-eq_signaling        =
                     OK               0.05s
   996/1037 qemu:softfloat+softfloat-compare / fp-test-le                  =
                     OK               0.05s
   997/1037 qemu:softfloat+softfloat-compare / fp-test-le_quiet            =
                     OK               0.05s
   998/1037 qemu:softfloat+softfloat-compare / fp-test-lt_quiet            =
                     OK               0.05s
   999/1037 qemu:softfloat+softfloat-ops / fp-test-log2                    =
                     OK               0.01s
  1000/1037 qemu:softfloat+softfloat-ops / fp-test-sqrt                    =
                     OK               0.04s
  1001/1037 qemu:block / io-qcow2-244                                      =
                     OK               3.11s   1 subtests passed
  1002/1037 qemu:tracetool / ftrace                                        =
                     OK               0.14s
  1003/1037 qemu:qapi-schema+qapi-frontend / QAPI schema regression tests  =
                     OK               0.19s
  1004/1037 qemu:tracetool / log                                           =
                     OK               0.12s
  1005/1037 qemu:tracetool / dtrace                                        =
                     OK               0.22s
  1006/1037 qemu:tracetool / simple                                        =
                     OK               0.14s
  1007/1037 qemu:tracetool / syslog                                        =
                     OK               0.13s
  1008/1037 qemu:tracetool / ust                                           =
                     OK               0.16s
  1009/1037 qemu:softfloat+softfloat-ops / fp-test-add                     =
                     OK               0.56s
  1010/1037 qemu:softfloat+softfloat-ops / fp-test-sub                     =
                     OK               0.57s
  1011/1037 qemu:block / io-qcow2-172                                      =
                     OK               4.64s   1 subtests passed
  1012/1037 qemu:block / io-qcow2-mirror-sparse                            =
                     OK               2.05s   1 subtests passed
  1013/1037 qemu:softfloat+softfloat-ops / fp-test-rem                     =
                     OK               1.05s
  1014/1037 qemu:block / io-qcow2-060                                      =
                     OK               7.28s   1 subtests passed
  1015/1037 qemu:block / io-qcow2-013                                      =
                     OK               9.78s   1 subtests passed
  1016/1037 qemu:block / io-qcow2-314                                      =
                     OK               3.24s   1 subtests passed
  1017/1037 qemu:block / io-qcow2-186                                      =
                     OK               5.22s   1 subtests passed
  1018/1037 qemu:block / io-qcow2-080                                      =
                     OK               7.40s   1 subtests passed
  1019/1037 qemu:softfloat+softfloat-ops / fp-test-div                     =
                     OK               1.86s
  1020/1037 qemu:softfloat+softfloat-ops / fp-test-mul                     =
                     OK               1.95s
  1021/1037 qemu:block / io-qcow2-qemu-img-close-errors                    =
                     OK               3.24s   1 subtests passed
  1022/1037 qemu:block / io-qcow2-267                                      =
                     OK               5.22s   1 subtests passed
  1023/1037 qemu:block / io-qcow2-061                                      =
                     OK               9.11s   1 subtests passed
  1024/1037 qemu:block / io-qcow2-079                                      =
                     OK               9.00s   1 subtests passed
  1025/1037 qemu:block / io-qcow2-159                                      =
                     OK               8.17s   1 subtests passed
  1026/1037 qemu:block / io-qcow2-191                                      =
                     OK               7.51s   1 subtests passed
  1027/1037 qemu:block / io-qcow2-copy-before-write                        =
                     OK               6.14s   1 subtests passed
  1028/1037 qemu:block / io-qcow2-154                                      =
                     OK               9.02s   1 subtests passed
  1029/1037 qemu:qtest+qtest-riscv32 / qtest-riscv32/qos-test              =
                     OK              47.36s   187 subtests passed
  1030/1037 qemu:block / io-qcow2-176                                      =
                     OK               8.87s   1 subtests passed
  1031/1037 qemu:qtest+qtest-riscv64 / qtest-riscv64/qos-test              =
                     OK              46.97s   187 subtests passed
  1032/1037 qemu:block / io-qcow2-108                                      =
                     OK              14.72s   1 subtests passed
  1033/1037 qemu:block / io-qcow2-040                                      =
                     OK              19.06s   1 subtests passed
  1034/1037 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test          =
                     OK              77.81s   64 subtests passed
  1035/1037 qemu:block / io-qcow2-271                                      =
                     OK              19.80s   1 subtests passed
  1036/1037 qemu:block / io-qcow2-041                                      =
                     OK              26.04s   1 subtests passed
  1037/1037 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test      =
                     OK              89.67s   14 subtests passed

  Ok:                 1005
  Expected Fail:      0=20=20=20
  Fail:               0=20=20=20
  Unexpected Pass:    0=20=20=20
  Skipped:            32=20=20
  Timeout:            0=20=20=20

  Full log written to /home/alex/lsrc/qemu.git/builds/all/meson-logs/testlo=
g.txt
  make: Leaving directory '/home/alex/lsrc/qemu.git/builds/all'

  Compilation finished at Mon Nov 17 20:45:34, duration 0:01:30


>
> But even this incospicuous script can harbor a bug, or rather an "I
> didn't really think too much about it" situation.  Dependencies are added
> to suite XYZ independent of the speed that is used in the meson.build
> file: add a dependency to a func-thorough test and "make check-func"
> will build it at any requested speed.
>
> Fixing this is a one line change, but it is easiest with a small cleanup
> on the front, which is patch 1.  This (at least to me) makes the generated
> Makefile.mtest file a little bit easier to read, which is also nice
> to have.
>
> Paolo
>
>
> Paolo Bonzini (3):
>   mtest2make: cleanup mtest-suites variables
>   mtest2make: add dependencies to the "speed-qualified" suite
>   mtest2make: do not repeat the same speed over and over
>
>  Makefile              |  4 +++-
>  scripts/mtest2make.py | 43 ++++++++++++++++++-------------------------
>  2 files changed, 21 insertions(+), 26 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

