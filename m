Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA565C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloQy-00024O-KL; Mon, 20 Jul 2026 09:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wloQs-000230-JX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:53:24 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wloQq-0005Ka-Vb
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:53:22 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-81e86df8987so42655757b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 06:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784555600; cv=none;
 d=google.com; s=arc-20260327;
 b=joA3P2DVWP4WfRftqoXlmViJsSoVtWruiaYOYFmNdLSA4sYklORaAFQj8FLn1xWxFE
 xLN7h3AiZCQNCeZ7OUcVx75IHCDKIk2MxtEd81vc4sQOqLYvRxFRcIJJpZUNCVSIF6XI
 YxRsCuG6UskVP23DLkGXfUYdHqhaVzes+qr4TPKkCpr/pByMBJ/HUeR3+ad9cAGrBEdQ
 Tg9+H+ZmfO7LipFzpXzSDdq79RVL+wjaHz5kj369hPz/0H5Wq4gzWeilIfARJPqK3v8E
 wcEvk5xiphwUkDuXAwf66yHlIg+amUXWjy5wIahtezbguHUHK4TMj1MOaVqDkTQt3nuR
 BgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VsF8+WvlAP/vFdQx/E9qmJQEh1BnVZwItrm31veYphs=;
 fh=al5FSA0QDJIfPMoyjfWiwC7oXFj+LfcBdbFSSZtoaSQ=;
 b=h9hQPlw1no7VNZYrds6UBKZwurxZqOOwe3JfEnXVpkC8EsMq5Q1xyCf+LdPLaJL5NK
 GLgSHqfB0yPF0znjdhOjh6IZ6z6Srx7dnRdTUr4x4BA21PTMB61yCcqw6Khgjwj9AnNK
 SWAqPP4nevPFfqDX8Xa4zUaYlZT5ocvWvBfNSvtQgIUvwc1PwrRlPrpCk+AiDGimlTOg
 BAAcdUesEOT+ISODjHnSo+TdcEdeiFkXm5Mt+xkEUmVhfaoAm1f71bxJTs1DzNxrmVsQ
 wHecYdsK3h3PHkk1YfETDqNweW2DiwC3oMWlrB//bCmkzRfSp4IGlxPxjrbB9VT6hFhf
 PuKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784555600; x=1785160400; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VsF8+WvlAP/vFdQx/E9qmJQEh1BnVZwItrm31veYphs=;
 b=fLplYeMBOSEMb5uvZsV6qAkylrT5d/iKpOeTyvbdbPHLl6V+EzEKDSK1M1dBH9XIDT
 okwUq0g8ehUNrTWreEjuBPjBWCUkPDi9KPN4IFtbY3sPOUEhdI0jupVNNGmvcRoRawPv
 q0pMBfqg7Ax9xicQ7z+Rla1+fIQJ8B4wkozgit9PX8K6wHp5URy6yMViLOreS63otMR5
 MlDfyxQ8h9Z2+CjdZCbYQ3vIUkRX1eLa77g3iSO5X9Na+aBtvRC/qvdsuRYwgc2Pjbmb
 eOwkDxsC9rwutVJpX/Xq9lBHr5rsfOoKlEwGCdNfZd594BFK3hPDMhtFXWcxHZVaiyap
 Q6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555600; x=1785160400;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VsF8+WvlAP/vFdQx/E9qmJQEh1BnVZwItrm31veYphs=;
 b=ZvUhbcxtEu9gUymWUNq5BLKCLPHHOBGaCLciitwVpP/OTKK3UyZsX7t38vRkGdrtf1
 DK8F/MLtWi3wW9dvnwNoa8SnBC0Z1ZkteSdMVPB0BbePgja8XkVS+Q1gvIwA+gqpWbgQ
 Y/UPOtgzxQWAz0zJQTX82k1Y+b+GIW50akJGSN44TnhfqirrB4WFKMcem4elB45PZX4K
 SmOPQowKLA44ctLShvACPPFJeFNVJieWCTWa3ChccEYAygavCq3Zl6GeliuJcDh+qLCy
 Zk21RMhdXDWZOr95pktjh4H2r411uX/mlRus0I+WfwniJSYeOb5hHZRwpZqJI3rvMj5O
 GgMA==
X-Gm-Message-State: AOJu0Ywx+dPsVriak8Jn0x68npdovJyU2uX4Rd4OdHAYWueArKimu0em
 dVUKWcXhPeLvQn9CWHESYvDpvAQAf4PIJN5OyMpsuTUU7OmqhznzT0DfJZjMoQ3DpjsjA5AT6uJ
 H30HcW7SBEioota+eMILdnGeonWeXI0l12zwEgLXHJQ==
X-Gm-Gg: AR+sD10/trrj1fOf7oQYvG8aL0+ZwUqJCFq0+vCK0TBBCxVJ95Hp5CZ8Y9x/uoJiCKw
 6bZu2bL5yMKH2jY1FvFZw+Ll5ppqxy3qKdn9PhBUamBaBOz3i98GFOsmCpKWkBlTY0KiRI2Jukt
 BPYaYtAVxCRuBHUJvlwzD96r0LkrRxYLF6yQReSaeoZdfmIwV7Rn1giGyqrpOV0fYqA6fBV5I4m
 CbosA1f5aWkoD9ln+kxYBNbImIg7SxWdbfRlFla6BHxpk7NREDxtFCcUDZB+Th0L+Bz/z3rl8GC
 rX7BHNwbyJJUFd0rhP6NYdnF27zYoq8pWUasko6pudK7QQ==
X-Received: by 2002:a05:690c:6d86:b0:81e:ac09:c89d with SMTP id
 00721157ae682-81ef27361camr44563567b3.4.1784555599515; Mon, 20 Jul 2026
 06:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260720134809.573757-1-thuth@redhat.com>
In-Reply-To: <20260720134809.573757-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 14:53:07 +0100
X-Gm-Features: AUfX_myU3C_0dq-sjokmPRTN5nLEptMZwu79CmcFeTCzsfCzjctAZQHCMSe-4mk
Message-ID: <CAFEAcA8TSyt8xa1=vKoDND4ExuPXT8rzavZdAqBaaWn3NbCogQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 20 Jul 2026 at 14:50, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The stream ID is under control of the guest, and some spots in the
> code currently use it for indexing into the status3[] array without
> checking it for being in range first, so the code accesses the heap
> beyond the limit of the status3 array.
>
> Since our status delivery code depends on having a valid stream ID,
> we must not try to generate a fake sense code in this situation.
> Simply log a guest error and return early in usb_uas_command().
>
> And to make sure that we really cannot access the status3[] array
> beyond its limit anymore, add some assert() statements in the
> affected functions, too.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
> Reported-by: Reported-by: huntr bubble
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Refuse illegal tags already in usb_uas_command()

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

