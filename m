Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2CC5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwH3z-000053-3V; Tue, 18 Aug 2026 06:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwH3t-0008W6-Py
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:28:54 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwH3q-0005cD-Uo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:28:52 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-836ce6cbe1eso57443587b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 03:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787048929; cv=none;
 d=google.com; s=arc-20260327;
 b=sL1Q+Shzm1WO4PA825RaMG3tBANS029EtHJOYBE3C2Us7S0hGuvUuJswYGYlDaSmHt
 2S2XXaGi17yUuCbFEMh4cwHn+TDg8WFGbK35LzN1XHytZgKaWDWMN3DLyLl8hXy/ITrl
 S/olBPHjzl3yOmUkP03/P1ZbdENsbXJpHEIdrbtJMXzgfsQfpxLsmf59uxJKIsfhW7XQ
 MRMhvFgdAD7UaqZFTK55Ii8eCSGM30Id3jymqBEEZek8dbzVwJk0MddtoBuKU8Q8SqKE
 N0oHjQakzFW8nxP5LJnKwhCBjOaH4tdevLpjs8usd5jKavxwm+p3dgQTXr01NYcYL3oS
 ruWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P/yWyFRFveauAzO0eDYwOeiv/EMLqTIMFAPHoNHtuRc=;
 fh=VbZG1/5HL4jT6cvLELGCod+ObUvNI7qxy7VukE4fowk=;
 b=IZg4Ev8VZ7dYhhkvGH4IiJfO+eXb/CwVsfovnwAMAbCd9dEfjhlqo4aCSlCgd2RTge
 XXGZioE58HU/MQetRLQ0/BbOiJYkEOXu+vp6qGkhM1BRjS80RaO1X1wmregKf3UcMOmB
 0eu77QCiISifn3lG5/zGU9wJTs0/8Nz4h4iUV97cs5Nxus7j2mfO1kjlrA41rfLE2IHd
 yCSEfvCRGPHcfDvjO+C3U739UfWQypYpz87/wb/oNutcsHGd5zfNVOdSCq9FaJrHtad7
 RNRYut20ByhKbYyeX5nwE6ypo7ouSNvuypgvqDQF6VgihsPaNr1tfNnnJ25RiluSvq83
 H9vA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787048929; x=1787653729; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P/yWyFRFveauAzO0eDYwOeiv/EMLqTIMFAPHoNHtuRc=;
 b=OuuDXhfwTSpfdWlDuryVkNmeY229drKhrgCZaRQ5mqmidl7eRDQrejt7iodko35X5q
 9pctrxY1f6cSvDLmlx5+G4YSJtVJs6nHsJ6Vxb/tM3fVgt2SoK6+0f8YtFU/fdgBe/C9
 ig0gqVAkMD9yvP8QDG8z9B/NSaQLdSyICeIRYZLuXWTbw9y4XPKbV8Ir0NOQ8PmkDA8D
 4G2KVz1J50E//wGE2jvoAgBRMlOuZ4Ec9J1TqGIi88kNpnG9s7nU0TS0/lvMMnuNmC1R
 PCZR9Y4V+8orROnrPdF/4W/21B6PbHKEj02Q/fEmnCGcXvPcmyVLH9ISpIpftSBQts0N
 39/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787048929; x=1787653729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P/yWyFRFveauAzO0eDYwOeiv/EMLqTIMFAPHoNHtuRc=;
 b=fjgnygWC4tJvlNTXqbn7HbavPxYVztnmuSoK1xxoJAVEB7O7ueHF4/bk3gc6/G3yuE
 d0pytdTQC2+SxCrwg0kVSaXOBpCbM4cjFC38DFvKBXTclESI+rPzk51FU1T03d5FAx9L
 s2ZBnn4a2TtoDF2O10G35nmgUjIki8IGfTI7tkQ7ti6dHP9yE7DFcTaDq6CF/UM8wXbQ
 PC3DdXDCNf3NTrlSotPnULaBxVow9Md8Q/in4juAJvsIYv+bhigmh0tg2O4/6jWSM4Ce
 jQPOYjIqKh5VP2EkF1B/SEkO9ZE/Dcp38MMz+dy8TG3Nd0DKXPuPv3zA9irGbBEf1KU0
 Gmgw==
X-Gm-Message-State: AOJu0YwGZ0P5QwsKYOPtbCSvJZsHZ7aLs4rLP0MUS9xIgXErhBzLj6C8
 52pnHZARl2IF98Y58dMQeI6lKflHp0fRfsY99rmSRPdtNvSinIvCtM0nkFPi/QUZbeBbRihdwCA
 cmNpXWjnELihY3g2l4v7CGQBBWp0OjlD0ISWYwMtgbg==
X-Gm-Gg: AR+sD13/kWLoL8aapv9g1O+h0TmBGYE9Lo5mzBlUYkVGK/LZLRIJnsUg2lpnjmjqov+
 eyOo/dA2uW55rOYaAWE307C0FXYpqpqHfvNP9XO601KxuoNNPcsNcprUqNdXMI44oz/cgdD5gHj
 t6Bi2yChLYsdMt4VnUQhcbiSGOfLL8Rfdrv6hkHPXn8fzp3x126xoFXswaU9I3Bp0Sv1tTWJ0wS
 i6jOiL+rla3KplxDscP2nXKNK9ZZG2LK3nBO3ZXWQ+RPNGLFm1i95C168oiB0FlweUlzBRtpAVB
 yZocD9mKvd2qmOPakQ8nWW1ef8LITC3eBIG7wm8gCXMfGntC7efRmfhYObfCAtjqnYgQQmWAg/5
 NbzuJoKmLTqSg9gSe/BPXPKD0UAn5
X-Received: by 2002:a53:e030:0:b0:667:f3d7:eb35 with SMTP id
 956f58d0204a3-66cb9c71f1amr2027567d50.6.1787048929263; Tue, 18 Aug 2026
 03:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <LVXPR21MB70090B04FF7397B0F2A201C8ADA72@LVXPR21MB7009.namprd21.prod.outlook.com>
In-Reply-To: <LVXPR21MB70090B04FF7397B0F2A201C8ADA72@LVXPR21MB7009.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2026 11:28:37 +0100
X-Gm-Features: AcwNN1XjRcslc7vivVTNrr9NC3TBS32u7gxt2W21SASs6ChkYX8hG0dC5rvlWYQ
Message-ID: <CAFEAcA8Tynp5mqj9rRip-Ws-d6=e-kVb0BkZQ2BX=GmLVbK1GA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/ax3000-soc: fix heap overflow from missing
 class_size
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Pedro d'Aquino Filocre F S Barbuda" <pbarbuda@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 17 Aug 2026 at 22:30, Doug Cook (WINDOWS) <dcook@microsoft.com> wrote:
>
> TYPE_AX3000_SOC declares an Ax3000SoCClass via OBJECT_DECLARE_TYPE() and
> ax3000_class_init() writes to it:
>
>     Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
>     sc->num_cpus = AX3000_NUM_CPUS;
>
> but its TypeInfo omits .class_size, so type_initialize() only allocates
> class_size inherited from the parent, i.e. sizeof(SysBusDeviceClass).
> The store to sc->num_cpus therefore writes 4 bytes of the value 4 just
> past the end of the class allocation, corrupting whatever heap block
> follows it.
>
> Fix by setting class_size.
>
> Fixes: 33a71a68c6e1 ("hw/arm: Add Axiado SoC AX3000")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4197
> Signed-off-by: Doug Cook <dcook@microsoft.com>
> ---

Applied to target-arm.next, thanks. I took the liberty of fixing
up the Author line to match your Signed-off-by: (i.e. removing
the "(WINDOWS)" tag. Let me know if you'd prefer otherwise.

-- PMM

