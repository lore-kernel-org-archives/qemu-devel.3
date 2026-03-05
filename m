Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D6CF33A75
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyA2k-0006A4-P3; Thu, 05 Mar 2026 09:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyA2h-000680-Nq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:51:11 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyA2f-0005pp-AI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:51:11 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so1335795066b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772722267; x=1773327067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mX5nnb4TIhx9NznmkOqDU9xD16SMil1/vefItcuXwE=;
 b=zvAhJEpV5N8KSbZxgVndpZMM1xJlY+8OKM6n6PMCd0SEXNv7v3iuLCecXGbgbI8t03
 Hk5fnpYO+l0jfjNYPJBUMsZXN0qqaQVIneNHUMqsZc9FN4BunRhkfJo7yYH4uyBF1Ijn
 C2mqC82jv68wOV/NV7gyFnKCQyMaqPux1XU2rzXafpoAkUv8zDuVh4T9JhjF8aP/+a3e
 vryU2na6a1aFbtX1nc0aMqR8RXmJnuAEyEQqB2jDli2wtCTCAFQio0Qh4gZfgqW99hJo
 JSWpqvjlfUgHIQBS+nzZsmCq5TR+JJKGolGmEUesOjNoclCHcnJns/il9M+FAgZ0///6
 hmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772722267; x=1773327067;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mX5nnb4TIhx9NznmkOqDU9xD16SMil1/vefItcuXwE=;
 b=Y5KzPXko899mlsq7foJaECdY5qKN/Xb142JyZ8TqpeIX+Mo0ZLJTVJzXDpysGy0Tqx
 QildrpK2kJ7pnd83FBRVCjGeQj3Ok7lsyJyzXuTm5K5QVsdr1uhbQW6pQHv18zD8LVJp
 V/j9eseCCdvxMKLvkGuC+rJVX5llo2+oZlkemePRKzwyNJIFQhcNACq6EY3Gi2TxetYG
 o/NCOyWMuMpCccqyvzGjevbtD9oswRbNhix0HBNR07rrBO0ZmezMyzM1kw0/ZjfyqTW6
 5MxxHZmwTYzef/t2S8HNRvgOpKQcRshMPkmwIeO1uXnsdKf4G9r6KGXrHL6STT6A4yyl
 rQdA==
X-Gm-Message-State: AOJu0Yz8wcCH5w4r/Zg4cT2w9Jsoky4lzenL0rbhCdBGpEF0L59Cu/JU
 WmGyJYyGBKF1cfzhaMFhUr6Miz9sdEAS1SRMGZPvm5HZu5JxISoiOOkQZtprNmBs46w=
X-Gm-Gg: ATEYQzy25RviANef/5Gq4HbXQ1C2aQfc+ItYdzccNhAEW4Aqie6anVKMjBdaptDNYQv
 63Yh88FBxBJonkJges9xDQBzGPWOVDcBMCP58JHup53791gsEFljBi0sgrNwGLxDabLanAOpSoS
 EqHYKWbU9E4YfhhdpomoklHWNVuVJxOKbqx9bNzFvjwT0Fu9d68Y2MLBYaVBL7eIgaPz89L2pWI
 5N+3W328gdblsqC1JSx7th+wUfpnSYAAF5R8KhJVdeM/PiCmATkhlEpvvbj2alf4J5ED1fUvu3a
 UZPPfvHStC6AVnYFj/vvDUoqFxt23bLUi55LdWA0KpNPb48yxR8BzB/8LN9lsL1CB0QUUwoIrE8
 OcI9UdLHLIMJaWkawK8ww8DECVHyGp/IEs+vSa+8SMTMD7YxtEvN1gHTUNPL3hQRClBZaIWsQyF
 tEsMjuQHYp6Act03h/Bo7RNrM=
X-Received: by 2002:a17:907:94c3:b0:b94:1871:f222 with SMTP id
 a640c23a62f3a-b9418720994mr91075066b.54.1772722267224; 
 Thu, 05 Mar 2026 06:51:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b94037fca0dsm134678666b.50.2026.03.05.06.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:51:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D5C05F809;
 Thu, 05 Mar 2026 14:51:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Yodel Eldar
 <yodel.eldar@yodel.dev>
Subject: Re: [PATCH v2] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
In-Reply-To: <20260305140512.1330691-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 5 Mar 2026 14:05:12 +0000")
References: <20260305140512.1330691-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Thu, 05 Mar 2026 14:51:05 +0000
Message-ID: <87cy1inxd2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> If you compile QEMU with GCC with -fsanitize=3Daddress and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):
>
> ../../hw/net/rtl8139.c: In function =E2=80=98rtl8139_io_writeb=E2=80=99:
> ../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of s=
ize 0 [-Werror=3Dstringop-overflow=3D]
>  2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>       |                 ^
> In file included from ../../hw/net/rtl8139.c:62:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into de=
stination object =E2=80=98ip_ver_len=E2=80=99 of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of s=
ize 0 [-Werror=3Dstringop-overflow=3D]
>  2192 |                     memcpy(data_to_checksum, saved_ip_header + 12=
, 8);
>       |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into de=
stination object =E2=80=98ip_ver_len=E2=80=99 of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of s=
ize 0 [-Werror=3Dstringop-overflow=3D]
>  2192 |                     memcpy(data_to_checksum, saved_ip_header + 12=
, 8);
>       |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into de=
stination object =E2=80=98ip_ver_len=E2=80=99 of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> In file included from /home/pm215/qemu/include/system/memory.h:21,
>                  from /home/pm215/qemu/include/hw/pci/pci.h:4,
>                  from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
>                  from ../../hw/net/rtl8139.c:54:
> In function =E2=80=98stl_he_p=E2=80=99,
>     inlined from =E2=80=98stl_be_p=E2=80=99 at /home/pm215/qemu/include/q=
emu/bswap.h:371:5,
>     inlined from =E2=80=98rtl8139_cplus_transmit_one=E2=80=99 at ../../hw=
/net/rtl8139.c:2244:21,
>     inlined from =E2=80=98rtl8139_cplus_transmit=E2=80=99 at ../../hw/net=
/rtl8139.c:2345:28,
>     inlined from =E2=80=98rtl8139_io_writeb=E2=80=99 at ../../hw/net/rtl8=
139.c:2728:17:
> /home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into =
a region of size 0 [-Werror=3Dstringop-overflow=3D]
>   284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/pm215/qemu/include/net/eth.h: In function =E2=80=98rtl8139_io_write=
b=E2=80=99:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into d=
estination object =E2=80=98ip_ver_len=E2=80=99 of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
>
> This has been triaged as a bug in GCC:
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114494
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99673
> (the sanitizer pass rewrites the IR in a way that conflicts with its
> use by the warning pass that runs afterwards).
>
> Since this is the only place in our code where we hit this, work
> around it by disabling the -Wstringop-overflow in the part of
> the function that hits it. We do this only when using the
> address sanitizer on GCC, so that we still get the benefit
> of the warning in most compilation scenarios.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2: disable the warning rather than using the incorrect attempt
> at a workaround that v1 had.
>
> On the fence about whether this is worth backporting to stable.
> ---
>  hw/net/rtl8139.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 2ad6338ebe..424af73a18 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -2124,6 +2124,26 @@ static int rtl8139_cplus_transmit_one(RTL8139State=
 *s)
>                      hlen, ip->ip_sum);
>              }
>=20=20
> +            /*
> +             * The code in this function triggers a GCC bug where an
> +             * interaction between -fsanitize=3Daddress and -Wstringop-o=
verflow
> +             * results in a false-positive stringop-overflow warning tha=
t is
> +             * only emitted when the address sanitizer is enabled:
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114494
> +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99673
> +             * GCC incorrectly thinks that the eth_payload_data buffer h=
as
> +             * the type and size of the first field in 'struct ip_header=
', i.e.
> +             * one byte, and then complains about all other attempts to =
access
> +             * data in the buffer.
> +             *
> +             * Work around this by disabling the warning when building w=
ith
> +             * GCC and the address sanitizer is enabled.
> +             */
> +#pragma GCC diagnostic push
> +#if !defined(__clang__) && defined(QEMU_SANITIZE_ADDRESS)
> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#endif
> +
>              if ((txdw0 & CP_TX_LGSEN) && ip_protocol =3D=3D IP_PROTO_TCP)
>              {
>                  /* Large enough for the TCP header? */
> @@ -2307,6 +2327,9 @@ static int rtl8139_cplus_transmit_one(RTL8139State =
*s)
>                  /* restore IP header */
>                  memcpy(eth_payload_data, saved_ip_header, hlen);
>              }
> +
> +#pragma GCC diagnostic pop
> +
>          }
>=20=20
>  skip_offload:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

