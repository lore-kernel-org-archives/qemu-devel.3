Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DFDCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3j8-0007fy-4P; Sat, 17 Oct 2026 08:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3j6-0007a4-9N
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:28 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3j4-000485-Ky
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:27 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ab3d3c5761so5796777b3.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240884; cv=none;
 d=google.com; s=arc-20260327;
 b=sOaOWdmHUoB+c4aKuRbLRA7wYuYxaFh9IB8HYzIqvYN8i6UTGXi3seZh1cTUs85SoD
 FuzFBJDkVvDWHo3OhANDN5jiOndY8aplhtlJTvv+o2W0ZsmIgsnRETtC9REw4hkqW/Op
 e98IQyk6Mw/ea/w1Q4OxRpplWDgazcpxVt9uEugyRNVJrALcHubNBlXAxHpssdejSDvs
 wqBbNckIs2cYGdilDd824LOTJxyEMSy1LEmwVgJSZJQxYvv+obaQmB25eb0I36P8jJWG
 9ZptQpQ+hzZ2DfJn+heUnXgPj/qfn/aZZEQI8q8RPkIlcITGsZyXwgsEypKbGCnHmtF6
 JdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BnxfMvd8hzhoJRjxUTNsa+DrzjsydedZmNeDt5wN43o=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=Nqm0ut6AHLohq8e9Dvb4A6tZJcDeF+BKYR1f3QNeDJwNUY0XhwpVffcSv3615YOvVJ
 7PMMnz08Y2jNSWTT4WkSPwwNbCEe7IR3yp8162mOqKYef9u0tTqRTBL7xrgajGm2TshS
 mFgWZl2MEpw/YUf8RHDohbhR8/ymWBk6Rn4TXOVdatAOb29GZqCnEjQ2ZttBWdtsUe8B
 sUibdAaZdTzz2glQaHDrzZKvw4r+LZKp+zjDILVnj5TESEEbK9dIohITV3m8aJOLKQTG
 S4Zn56oKBpcHDkuwtjSuy47ETdfRTHO+VtG4SJYYExomi9nQ8i5PMbgkwP/roHdrBEU8
 +Y4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240884; x=1792845684; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BnxfMvd8hzhoJRjxUTNsa+DrzjsydedZmNeDt5wN43o=;
 b=iD/6PIzzbf69sJmnhPI45HE0qcIPZfvsADcgKOxSWRG7vPRwHygbRaMJN2/eAdVTPH
 5g9uVhkuS7y/5//yd3WHTnDLMQLVOHy0gHhnDj8dhwAcy97+fzLYreysSo+4XJNY7h2w
 Wy5itUqVRZjj+GenrXmhm8gsflv4nI9cqaJvsyyYyeXbzAaZtdCwhJpWxbnoS7zQRw7H
 DTs86jSZ5JasKzim7MWm04uxP3QEOYGSNDCvqZ/lzmqWzTpzMc2Xi7NuTotO3BrqTMx6
 gEyhv+BHAkgNHnFTdESerxpNA2kdrFdHiVi5gdjoWLTbeiRltzteoq0SRpa9gjT5MMTX
 NT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240884; x=1792845684;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BnxfMvd8hzhoJRjxUTNsa+DrzjsydedZmNeDt5wN43o=;
 b=BwO2TIVTuGrz7/7yFo32mbfE6ECq6k50Q4NVDY9AJBxZTttToDEsx3n4nQoQOy+d1s
 ZNFY2xod8NTC6owqm5HLKHvKYhWkUt47V35oKosksJXBlpjp+8PsjlGQZdpTtMX4/ngt
 U4Dr3qQJLWeKPxqkjMcNf2S5jM/2gj/z7PFk2BZkraN0sCvC1+MAMvWORFe12r5BxwmU
 RS/S04SXdl1aN2pby/gDs+BvhOOuhK5niEMGsOWp4DdSJwmo+Fdf8oviiN3dEYh9lzuj
 vSw9KAJZ3wWi1TyU5VWVZ7e/evPd+0ORWxU+FSeshUu7EpmD2Y+2s4UoqYX2x3jFRng+
 JkQg==
X-Gm-Message-State: AFq9FYJ6gtHt1TTErPlt4lHGKcdTwZF9AzGBrKC/TVCNV9hItChgDxkg
 yDreOvjEIRws1+PN2Tu1J/sxb03sIiZ81bikI5wQikkvElRTfsGp6XyZlh6S4Zhl51mpHsNv505
 PPfYAztbVuNscZnVkLq3fh88NCmxumq3pj26JDbJROg==
X-Gm-Gg: AYBFou31nSn72IAep7swgdd4knm56BRMYqrPvv/FebEKWowQS8SSqaLdNWfE7ql0/im
 78kEFhU36G4NDoTi7jvi/pSK/Pou/25ZADBS2rBgEZWke3qstPHpWmOBwg8+WJ0z4S+zlPl4CNv
 uip1uXm0znIbpOsj9WZJDgRJEp5VcypGPlzpwmhflBl5bpmAo9CAzNatYC93u9PLZz6osDt3j+R
 7IK+TiaSCD+TExv65cMsJvtvLdA4G0XQcrAbjLmbbj+oy9QNy/sD6FaXSEuh8lVZaYZG4KlHUkS
 XYJD9OXPH4jr/p3P6q45i/HvmzsEMeP0V/gJg7nJMv4VTU0KGabRaV1MvY3Iyn0vCeQyP9WxiOc
 R7oEd+nlyGi9ZcQA5SVyeXmZKZiBy55rYGJgjpQk=
X-Received: by 2002:a05:690c:dc7:b0:8b0:a64c:bb37 with SMTP id
 00721157ae682-8b0f21d78b4mr10467927b3.43.1792240884274; Sat, 17 Oct 2026
 05:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-7-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-7-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:41:12 +0100
X-Gm-Features: AclHuK8s_6G-7H-gcymbN_BdTHpDigsmc-tqiQK5w4TQHN0NJBnDkWMl-K1kUrs
Message-ID: <CAFEAcA_8t57R_zRkP5Y=5H=aidoTp1Q9pfk0Z1-mdV3tex-riA@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] hw/net/bcm2838_genet: add GENET register
 structs, part 2/4
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add the UMAC (CMD, MAC address, MDIO command) and DMA (ring config,
> control, producer/consumer index, status, RX descriptor
> length/status) register layouts and their field accessors.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

