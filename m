Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9BAD13C21
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNcb-0006Ph-VL; Mon, 26 Jan 2026 09:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkNcN-0006OX-Ln
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:31:04 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkNcL-0003ZU-E5
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:31:03 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7942b9663f8so39920297b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 06:31:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769437860; cv=none;
 d=google.com; s=arc-20240605;
 b=XkiYu9K7c83UqQxlBx5VL5aQwY6lSGhu0OzQ91XZP7JdgHKUpAO2oD14TTzqkWhVf1
 m7D2ofVqcGQoiXsT9oWxIWVTWkRD8azb5cBnKvjmUBZijdwFZFOMsXCaFOM4xOZcboIn
 36NNbK/dyR3o7fedvG1XiNjCmB2TVqgQCn2REEmGcIfFusvalzf1omII7DUKdj9mmpDe
 /8qyfZ7Q3UbWvZGYnQY5bCdBaBtA6p4ztXnAvaUGGEvcXLIXO/panlSKc5JbcRI5SyHs
 EY+qZewHmT5Vreodj3jhXxk+DV1jqjO+36xEikHVmQYY6wEF6rMAzASI283dAXPKyWy2
 Q3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jLkgGTkbtfqp2mGuXLFxgS/Ev8xM5jAQw+MQuglaKTw=;
 fh=itvWBW8yTaZK2iy8RSV+f9El6QjlafIJxrPaO0R+0yE=;
 b=jnWEYJCJmdKn9s+NYfcbroRlevg6t/Alvb9g1f5Fs5UwRN3yMQ629QdrmDdJDGxJ8J
 izfibK2AS+burLAqBkgUh4XVChL6yfwZyx3Z7WwWdOutbg8zHKsvPtuPjdi43HTsGDIp
 nthrHj7gE9VY9gUCXnS+7Em6lvPAqcvI758NOis2RxiFVPzDNTV7EzYIp+kGOp/99kVD
 CNI/jFO533Q8J5kOI+1slny60T6PSn7l2HazKg+hMX07T2gVbUMLgBqWfPdXTmVqKMgI
 8/GvfVkDLe3sQ5zubtuU10Lrb/n+FYfj7JdNFQhl7YykEyLWBODl+YJZH1C/JLQ0JZSC
 k2EQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769437860; x=1770042660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLkgGTkbtfqp2mGuXLFxgS/Ev8xM5jAQw+MQuglaKTw=;
 b=wLm98vT1Ri9EiPGSSex+DIp7n9yTPd91JOZ6VErMkEPyKG42vB0Ng0XU5pXyHrijER
 zgGddyrwfn4XQ00++mYS2xsb6W1camQ14pEK2SxavAxspylqagOKkuzM1DGupDqItAJf
 fIM5/mAq7pNC5JH17Qn1AuSE/HfuxhlrcPeakVJOc2gsPkT6OxG6TcIs4ZMcb05O5Y/5
 cCFGapcdbNzMpHONOPyj7hlzBuxUgDX/lve4tWdCcGYufsEYtZm6Up2Bxd/aT7hnzKEQ
 pE0iX3/3O3iNUfAnO2VTJz2b0aERNgawVm7bsTWz1QiGw4HNWBXVRq5A0pv73IpRLevo
 Lt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769437860; x=1770042660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLkgGTkbtfqp2mGuXLFxgS/Ev8xM5jAQw+MQuglaKTw=;
 b=mENoZrSd405xDrD9jV5cEiGuN7Udzoni3vFktXDZRHxlv4yGiG8UMkHcOnfDXQZPBZ
 zp6RKLiFf0GTcqBJdUmL8vo1adJsPJ6X/ga19wDkoUtWSB9C7eW5T3+yxlP4GUgVH3Lw
 mcQRxA9xgYb3gpwxet5hWnbtj1Ma2fdZeNLsD2GRuMWhxcXwEYN6b7RjClKfboDlO3Sh
 pXHPs2t3AdKGVE8HKexZudY9QKEiAQl611ZRensLDuuFUDgg9ZN4CArktpwof1ueJxQ3
 DHS9ATEQvsJKeXhACKxTm9L3TjWwrxeo5y54ae+MzVAkqzAWVaKB42S+jn0FOOf0yXbA
 RrGg==
X-Gm-Message-State: AOJu0YzmbdRfLxo7VtvgwDbWbdjmVVi57VuN5FXY3CNzVyNo6PRGMdnj
 xiVf2Tp/6XdzXR9adZb4tLPowzYOI6yuFG2ChVC01OJEvsEh/kPQJKQg1qswom1KsTxB/0BE+yj
 vcOn5/pvJcahOJGk0cTbA7lecZb2bbrDRrm4U8hZz9Q==
X-Gm-Gg: AZuq6aL7EhSqDecZjHz1D2U9HrdqV6v285GrImtP00Qy9w0ggRGecTORv2IrlLNceyF
 r75z+iU2djHsL5g+vBdlnalU6zF24rwZVxwFQY4sllyT1lknnPYYtAiWWmFcJ64Iw6rfvMiw6G0
 fSIraN1sbNI2xM8I7Qv/MAhLciKW/Cs2K/3x7RUAUSIoH1BhX5fYORKfehvZ7+bDAiyLOVEkptD
 bHdL9GQsuyjyZQ9yfQfHHcmDS0KaqYquDUu6KKzWE8lLJD9pc0sa7U023D0XmC1976gEg==
X-Received: by 2002:a05:690c:6a0e:b0:792:725c:a35b with SMTP id
 00721157ae682-7945a83756dmr32776877b3.4.1769437859784; Mon, 26 Jan 2026
 06:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20260126141820.719492-1-clg@redhat.com>
In-Reply-To: <20260126141820.719492-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 14:30:48 +0000
X-Gm-Features: AZwV_QgfWO9T-zCQFxmSuZ_5v4EERZFEwWgw1qZcWbA-G8V7-i8KfEIOzcR-y_c
Message-ID: <CAFEAcA8xQmUa7DyR7+Nw255e_DW=uzZ-gQT5G6cd-uuWgQBaUg@mail.gmail.com>
Subject: Re: [PATCH] hw/adc: Fix out-of-bounds write in Aspeed ADC model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Elhrj Saad <saadelhrj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 26 Jan 2026 at 14:18, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The 'regs' array has ASPEED_ADC_NR_REGS (52) elements, while the
> memory region covers offsets 0x00-0xFC. The aspeed_adc_engine_write()
> function has an out-of-bounds write vulnerability when accessing
> unimplemented registers.
>
> Fix this by using 'return' instead of 'break' in the default case,
> which prevents execution from reaching the s->regs[reg] assignment for
> unimplemented registers.
>
> Reported-by: Elhrj Saad <saadelhrj@gmail.com>
> Fixes: 5857974d5d11 ("hw/adc: Add basic Aspeed ADC model")
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Seems like a good candidate for Cc: qemu-stable@nongnu.org ?

thanks
-- PMM

