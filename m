Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4497CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIPBp-0008Uv-Pz; Thu, 30 Apr 2026 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPBa-0008Sh-Mq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:04:04 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPBY-0001aD-3q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:04:02 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so742208d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777547039; cv=none;
 d=google.com; s=arc-20240605;
 b=Gs8J1wl2HwSTUAjLOhHysf99JlW1WrJ9FOyc6QtM9Rn29CWPA/hdKVwQCRVRsIVIr3
 h6+WX/LWz0VFW2IyIo+dcTtgRMPeBPDTh+IOXeOhjoRTM9VspHvq9xsuR+21gEuuxpWy
 MmoINipJIjGcwT/sWi4UsPmdsbb2SoTmZqPU5D1SnZk3Bc6BsxmIPEYsimjEB3QdIPXr
 4aDhctvj9fKAMzqQVS3/Equv6tn0uO6DTb2Fqnh20BrMAlIE6zFO6/0tf86rFTbL5xOl
 lxg0O7xO3sbwnDn6mE/pqwyvBi2Bd9S0vwU37j/eVYDOHNbLANLfywVR4wZMzBCMYirc
 l2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E7q++YOPrYLptnVGanGUQ+j8Ph9Xt1q9SNXtQGZ8Osc=;
 fh=0byzlVstFqngb+1AiUdJWLuz92Tm9uanUlmvpcwzmE4=;
 b=jiiMxbFY9d7VKaCCihprusR6v5MVn2w1A1Ev8u5qdJK9HWZiKjq5Nir/NNDpEpubHZ
 GT6cAI44hmzbDfLyBmvF9P05ag3DIoaOCya8hTGk2/451V1Scg3GSt0rkQrYb1n0nkuG
 v+jdTq9kDAlRkEW/7QXnB28HDA/WuYlZ4cR8GGOSQDeKNOMlsGxZEUOn4pJWIM/VZZg9
 uQCi032zF9s01b/Rx6xTaVq59yif5rVTA7LFi0f7o1A3nqKCDQ3qTDQD/ZZ4VKzj6uL/
 z5QKFofxO4o+K3B2czl385ByMLNWSsSO7tpei32Y/Tzd+unYCBZ1qxdj074ewewJliEl
 Ri3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777547039; x=1778151839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7q++YOPrYLptnVGanGUQ+j8Ph9Xt1q9SNXtQGZ8Osc=;
 b=u7Wsr4o/xnircL6XhLNIZBhac6sRUNvrRAe8QENmlq3RMh3HfG7OX75d4cbJqUhY67
 nDl6hdHPbE2mRmnsb8iQ5BYDrL9IPvfUkG6ye20hvJ4cPeY4giE9JjW3NSUpoRlHrKBN
 TPF94FunZTjreuOPsUSPZIsfvV0MpcGEykgQgkbDfOucTKnGIagyxYbCdNiPLsLDSM5A
 /A0ADKYH5b9xvnVguHVT2hhy5Y6U2Sxu486zcagrpTsVZ+i9KJb4c8l0lCov0kHrF6jJ
 f+T+xUWxlKodN4LdIYSdXlb+CXoqInfSm18t3/+tW8F9GUom57xmhUbcHuU6waFSlOUn
 wXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547039; x=1778151839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E7q++YOPrYLptnVGanGUQ+j8Ph9Xt1q9SNXtQGZ8Osc=;
 b=sRRBo3KW4FaHw74zDL0rbIbDoZEnvbpR5yLI32mC+QZsoOUmqubfy36/WIqFMqsI/k
 MCwpYY8xemNu+eQqBxlX1p+ACHj4roP+e/l+0qcJszhzJZsz6LnbTNk6IsH4HXB662bE
 fB3gykyLDBp6yETskyXpGwbgyLCUv/h8mmD8NU9TuVM6dw1XUMrhvhcTeFm1Nsks1ZCQ
 C7Cv8DgyZ+XrIr3TXHlokDvhUwH2nn+2bb3DtArWQ98KXcbVQTVKI5CoP0GylL+IgKlk
 /s094auGTFQNcEPxCNMEAlfwa/Iu6TDDWp6x7qiCIHm4pM7k2B0Sd98yDNZxwXeFR2Ge
 KTyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gAedyWDuxZXOUQF1ZYZRJ9/n8rTkj1U+r8GvKBaHrJIKjMPWh1GuvGwsqt9qpVy5/Uc1tjBoR3rmx@nongnu.org
X-Gm-Message-State: AOJu0YzFrMOXh+xT2qqhOOm1ZLb+XnVpVz6gj6avrQ39aY2mPyvP2cmb
 7HWayVpqqNEA45pVAz6lV40Ys+fPFCEuSO53x6BmAkfsLO8VXk1WKanAI5Z5NRYHLgAB8skVw3u
 s0lF9UXKhOKzxRJdqAdQHbYVgoRi3LKx5jIqRGYnN4w==
X-Gm-Gg: AeBDiev+VpdcDppEOhNyqYw2vuKMNv2smbCDk+n99mwrnEn5ORVeMdyLR55AGOWvQpl
 uvDilydbmwDFmViscMYtIl4pMJ1nQHl28Eqe1QyGqOllF6p0vfXYdm2h64PVIwItiVtSnM3q46p
 5H2jbHZiNM/g/0BtGJgGmApmuLoVmk/nYQmckUW83ikkkVyf+8XRf6Vq5HYuIcSToNfAMi9JPZa
 1vhFwvoR6I/JCMNps5GFnNvu2j3P06f+9ZaEMNlGIywrOcDdpZwj4ovSO7nLzC1uU+WYry1VrCw
 jmG3rti5/X37IPZMF3TRbA8TR1cLEYl92B8ky78PLa/bmJykivoar03gx2Sn+03rRVM8VSIsIy5
 vY9vvSalrmLve
X-Received: by 2002:a05:690e:b45:b0:654:c28:598 with SMTP id
 956f58d0204a3-65c18aec741mr1726257d50.9.1777547038679; Thu, 30 Apr 2026
 04:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
In-Reply-To: <20260428055254.76581-2-kane_chen@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 12:03:46 +0100
X-Gm-Features: AVHnY4IFen5KA8fZusdxr76RW5tZDif4YPg0lC7lXI4mYoR7FWcZzQysA2JYDkM
Message-ID: <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 28 Apr 2026 at 06:53, Kane Chen <kane_chen@aspeedtech.com> wrote:
>
> There is a mismatch between the Aspeed OTP model and the Aspeed SBC
> model in how the guest-provided address is handled.
> aspeed_sbc_otp_prog() passes a word-indexed address directly
> to address_space_write() without converting it to a byte offset,
> whereas aspeed_otp_write() expects a byte offset and applies an
> additional shift (otp_addr << 2). This double-shift confusion means
> that an out-of-range word address can lead to a write beyond the
> allocated storage.
>
> Fix this by adding bounds checking on the word offset before
> converting to byte offset and passing to address_space_write().
> This matches the existing bounds check in aspeed_sbc_otp_read().
>
> Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Cc: qemu-stable@nongnu.org
> Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  hw/misc/aspeed_sbc.c  | 14 +++++++++++---
>  hw/nvram/aspeed_otp.c | 13 ++++++-------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 065e822e70..8b74dca13c 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
>      MemTxResult ret;
>      AspeedOTPState *otp =3D &s->otp;
>      uint32_t value =3D s->regs[R_CAMP1];
> +    uint32_t otp_offset =3D otp_addr << 2;
>
> -    ret =3D address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFI=
ED,
> -                        &value, sizeof(value));
> +    if (otp_addr >=3D OTP_TOTAL_DWORD_COUNT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid OTP addr 0x%x\n",
> +                      otp_addr);
> +        return false;
> +    }
> +
> +    ret =3D address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECI=
FIED,
> +                              &value, sizeof(value));
>      if (ret !=3D MEMTX_OK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Failed to write OTP memory, addr =3D %x\n",
> -                      otp_addr);
> +                      otp_offset);

I would stick to reporting otp_addr here:
 - it's the value the guest actually writes
 - it matches the logging for "invalid OTP addr above"
 - it matches what aspeed_sbc_otp_read() logs in the equivalent case

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

