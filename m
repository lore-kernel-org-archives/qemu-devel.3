Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfql-0000FI-1E; Mon, 05 Oct 2026 06:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfob-0003PS-2b
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:21:05 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfoZ-0001Ma-Em
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:21:00 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8925e417565so11299737b3.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791195654; cv=none;
 d=google.com; s=arc-20260327;
 b=LL23DTTpRgIgjCasHOiq6z1eZdDllXvLflUNxSj91O0hfH1YLGtFkbmvJ1i3J7br0D
 8fg05ckAbkAZUlww42r4oR8PyB2M7LVk5maRkdgenoJgePLI7Q/la9cTP3vQXqF8dKm6
 SlSGhR3O97SWtKn3q4G7kVqhYWEm2BQmMkzNdNJCajnaL0SOZUnTn/L57p4Kg7VYmJO2
 hWRCPzdS3cF6IA1DC3N6gswYM4TyN2/mcPY1P2UFzqw2fH7ACBzfCAxECgmwbZWTlchz
 kauRFtr54J3mPidkiTcM1eU635Fwe58wPTYL3P+UG3yEByAE5GmBhNT1RNrIhi2bRUsg
 t9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rsICQAjWvmy+ljjVOj/7u/Nn9zIVoBVRDJL9QHoTuWU=;
 fh=fYbink0dv2K5JH7y7l0ooFc+Kby/5lHeieI3AgvMwzs=;
 b=HFEx6stwBUQeMNAJc4HboaSbKplmlUQwWw4x8MSieFW6qkJ4RUYjkExNDVlyONitHM
 /zV/pRA2R427/Yev9n9Tx+CKnNUItPCFB527vcdslgoSQ7ZZhxuOAnrNDB4ypyYQaBxK
 GJfN+Wfy0Fsg7w5G89ck+JFUIDH/VdbFXZUDhljCE8DWrHVRc4/bVRM/72oMBbEnlpp+
 radLeULLGCPthUq2QPa8S1FimrF7K/gM/QTbX80d8lO/fyO5eMijZoi/CSoiXlcPUZDK
 xyYYdDzyXvrEoU2QH93+znYLBPSY/YCCqsX5ZTLpkxhYjmQd+bMJTg8fJs/qFd93CPKw
 XuEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791195654; x=1791800454; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rsICQAjWvmy+ljjVOj/7u/Nn9zIVoBVRDJL9QHoTuWU=;
 b=Hq21dVXv5so2WaEr3y+PDhJqcQo74tn2VjreaM/yjGphhI7cQ9HYIy/1UJzz003nw/
 j00c10hxjluT3gDkOR+Bjhf/0P0gTcB0m1W4C5GVxZoq18pkzPRZoCpbJFbSGuvVyWko
 DZKgj1e9dLqshYUn13+xX7dnmiU+w4Z5UJWpQMhIpQLdLMZvaSqPSdi9GmOnsVbqA5NB
 dhDzEE5ZPXukZmuSWfnT5vn5wRMH+EkVce09saPoGatJCO7YRtEQsT1zXd9k86HB3FGV
 1/zYvMpn9pwmW+ArqzG0owQwvvXaTljQpjStgnMi+kSBgo5s0fViNuSIdUVSQTXWqMjU
 Mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195654; x=1791800454;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rsICQAjWvmy+ljjVOj/7u/Nn9zIVoBVRDJL9QHoTuWU=;
 b=TgnOpGVlS/Pe6NlhIz6d8mDMFbyZFAXCWwhwoPCRLQQuEK0pm+JRV9Oy1jKnDgoIcy
 TcvlSdn2LOKe3G+LEJMH1GcqbYoAzj6yl4LE9EMAqQuMqAAKa5N0X6iIXAEyfx4RYmmI
 JJI4LtFbfHK3dmn3FkTmTctnIQSDlVcDdbZwYZIo3SCpXOcFCescx5FtVGe1S9DntSaO
 Kb4F+9DyfQ4CpvYLST4NmYpdZVXf2XhMOD1FlFRwjkRJZAWNOibyNNoLALukeXnoJ5Cb
 pVcPtw+cXq+e5AUxSrv4KgXoXZNr2yGzdNN4SaKYG4+2Xl/V5m/gwGLGZbc9gD6ZIo3i
 NOaQ==
X-Gm-Message-State: AFq9FYLMjm5hviMwTT7c81S+rmAcDdmSEzn6f6r6cyLxibguahKA5Xki
 U4w7BiM6MHlSbcwEMUUzDK7wJK7cLXVasqnvzhjMysbC4RtNGFNI0evkwi6AG5gjdoZH1ONnPwf
 tQRvzu9wKawNMWzxdubwFb3qM7ze7jcQJHRTrcS3gDg==
X-Gm-Gg: AYBFou1tsojUNHle+robEvjyEcuAb0YRxJIkJLx1gbLP7m3r5WXWFvNa3WSg6+4iOy4
 b6hwiJN5KN0GTjrnepMOeqZXGH7xBRXoWHQbuuSHnuG7zjGCv778G2zhHmfth57SpYvdoRER7ml
 JFsF/JOhmAztwA7j2pyEGB/1ducJkmrqN0nDtFBf0ayhna0F506gOu0f7tkyK/WJqBJOwDzcc+f
 yPiRBaKnitES+/uruc67qEBsZIyaD4kcvJ6x8+uf3jLM2TISUYRlhKfnMOTJDaJOdGc18+Misew
 tJFlvPXj5kqSZhCNLfYS+pj5TjTa7JaumX74SdH039wgqtLUcTkF3twb+9kDP98xdShkNs6Up/e
 D+T6zZ47jA9VTik/QGo6VBibzLKjtgNnYieThGiQRB/BTPIs4Jg==
X-Received: by 2002:a05:690c:c013:b0:8ae:8021:568b with SMTP id
 00721157ae682-8ae94cecc2bmr15640597b3.55.1791195654441; Mon, 05 Oct 2026
 03:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-2-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 11:20:43 +0100
X-Gm-Features: AclHuK9551smn9ZrHUsIL3a61fGpmqYiwQpUymJOV1A6pTNNN7ZfrEZP4Hoi7i8
Message-ID: <CAFEAcA9w+7kWh4ikMkiRio1xw9iH1OASiK2-NMGPRqLgTOJy-Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/31] hw/watchdog/wdt_imx2: Preserve own locked bits
 in WCR
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 5 Oct 2026 at 11:18, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Apparently there is a typo in the WCR locked bits handling: The locked
> values for s->wcr must come from itself rather than from s->wicr, so fix
> that. Without it, guests such as u-boot may experience inadvertent
> reboots when configuring the WCR register.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
> support")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

