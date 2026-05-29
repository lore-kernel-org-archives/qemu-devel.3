Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCFACD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 09:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wStLK-0007zA-HJ; Fri, 29 May 2026 05:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStLC-0007z2-Ge
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:17:18 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStLA-0002SW-PJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:17:18 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso2058867066b.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 02:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780046235; cv=none;
 d=google.com; s=arc-20240605;
 b=Nm/xwOolZxkZCS+3jNvSoVqf7sXJqxLsOwykPog+IWhpDyIq5ucKOiUd5WgYjT+Wp4
 xyHy3b7/PuQJbnRLb7zxINQ1/xbyRPdUbYHzpUWi/1umDa9dcpQ0JVu4RyYeuouFQEDt
 hlxR5so7hgfWylrZ8C9ikwDw0BXu450HGQh9GC2mCZQknX70TkFwfzdABSb4VoGy699Y
 7VWLYaclL3t/6tEZuK117dpS39tEiwDk5/UI2XolKYz5EKlU+VBvCKGu6tiTrLOg3z1G
 dWhOLUozu169ad1Il/cVmqJSnoysi5Xr4odlpMRPiXPLv+A56aNR5gZiULopdF0XBbEj
 yMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0GnaGjaG4RESDcoGYwaf8vFzTvOeNPzGpDXrIz7ydWw=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=XrVF5NpeOvgXKKcHmD+DMMsxPHMycpN6efKLahv0Zwroez/DVVRBvz0TUb7ZPIX0Rr
 6RXy2Ot7Fm2XhZgs4AreoRY4qeV3h33eNlC5wspCEMWeNPS/wAXvLJD24JjQw0tbwOWC
 Bc7DswM1PJEH+xx5pIIGUJcY4Cd+FWw9ety8eAkdpnf83eLJ6/8pN6oWeL/S++AiyTPz
 TUeObl3b4pYnYf8K5Hz13TriGA/Ju2p9vEhQ+7D9X2yH0yGwDIG8dg3Z6PEgJX03ZkoR
 FmvewRkQk2CUWMjulvPUMlfUyM1/UB+3lt6ZCGfRxrSUUntNhOEro0iR43X0XWGlwuTT
 xI1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780046235; x=1780651035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GnaGjaG4RESDcoGYwaf8vFzTvOeNPzGpDXrIz7ydWw=;
 b=lYdcJriD94ehuoCndVqScFMqeXnWI7mzB2PH4u6DZVlptK9ZBd1vUvmAXTaDUTE7k7
 ZZ1xKOPT+aynb+ACLAkn7DC1jrKutEzwngpOhctKBM+/xqNBqsRUEBLabzP0FsZFNU2u
 vApkhqMICBJlosxvP4PjXzmDLlMvyRqbNGWvoW7UvDua434sRDXp/7uRrPBmMBv3C7px
 vfQb8S7KNPtWaclY/E8b3HgLZGAoo0IXQ85ZnBSMiJ7TzkoLmifGlIlbi81mQMQwOHVS
 HF2kA/tKZYXTdGVuNFF87paSLT22mRYyg8T39+cJAx+b0sIXPU5yn7jaiPsN/4efrpqP
 OcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780046235; x=1780651035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GnaGjaG4RESDcoGYwaf8vFzTvOeNPzGpDXrIz7ydWw=;
 b=l7NpwNE+Mw/jNYMvSB+Nyq6ykYsYSCgFpD0OVOJgQRtevDBNfiORj8aTRNEb+EHvi8
 f8xCPS4y35FZSJ1k3zC6ZI+1BDeySNHpoh9Wv8wlRgz62zlHz/NHZoNksSs3lEo+03C9
 P8ai47CnAbtD4anY6ULJDfG4zTVB3xFA51hv+nYb82G2nEIl9taKYmybU/73DyWoRTy+
 8Fyf38+o+KRwD00m4Tk8zVpiL1sgk4mNB3XTBjCe5ZWyaXAKshunaLqU+0IDXMPXFxvX
 OtADH/cjh70EtZjhvSqzu8IQvgN+j74Mivyz5b47QM20BhcUd8RCnElPkTpaWO8ac+JE
 spsw==
X-Gm-Message-State: AOJu0Yw0RQIJ488qgOL/9K3kHbdAeL+3q+mbRoJGTKxRpeFKmxB+1S1f
 9F9Sfo2DpiK9jMBsNXnW8l62x7rfqw5ESwX7k46wQtrymxA0MumLmuDHvA0Tjm1l9LluIrs3ofV
 J7UCTgvzZyoOOOsr6jncGYWKzTDnnQ1LY/USHVmmkPvdD3ZEtkS9AEeU=
X-Gm-Gg: Acq92OGk0xae5p8fYsaq2PoZhQfv5mQQ1HFc5FKI+WsDlYIkl7RIuDK8wyeVcvPsqDU
 NR1irgOzceH9qQFgSR1M/XnHeS4CFpp/ZYiS85agGgIM1ILHX1v4ic/YW/cUOBj27cbPujuaOro
 ji5MDRKNfeCkNZOYm9vg95NHFGD6iRtWzyqvAJ+LqkNkXQ/tEU6YEFgkx8UYnc4h7ANGkPQ/5y8
 5BFKO4bF2X0g0N3QJW89ggv2DIWeZMm23lvAfpjYup2V348j/cc225u09nr1o/pA+n1oYsSsPdj
 w17UwrFVL5ug1djdM+z6rosBsA/9O59RCDNsTwticz4YT8Zu9hFSjJqBSIuPARkG5YCR2D/FX7J
 CNw==
X-Received: by 2002:a17:907:a46:b0:bc6:7238:bd57 with SMTP id
 a640c23a62f3a-be9c86942b9mr113537266b.7.1780046234877; Fri, 29 May 2026
 02:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 10:17:02 +0100
X-Gm-Features: AVHnY4I2Qeph73-94YDvG9VaCBTCjfj6IXl6EvSyHazMym0aQYJ0VsiUvAxo0zQ
Message-ID: <CAFEAcA-F0m3qUyoURsax-vC+MbasgcMN_wSVSGJCo2KRES=+uw@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] hw/tpm: free PPI buffer on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Sat, 16 May 2026 at 09:03, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The PPI buffer is allocated with qemu_memalign() in instance_init but
> never freed when the device is destroyed.
>
> Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64=
 virt")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 6bec30c36fc..3984228c42f 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass *=
klass, const void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
>
> +static void tpm_tis_sysbus_finalize(Object *obj)
> +{
> +    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
> +    TPMState *s =3D &sbdev->state;
> +
> +    qemu_vfree(s->ppi.buf);
> +}

https://patchew.org/QEMU/20260528093123.55403-1-mbawa@redhat.com/
(likely to land upstream shortly) moves the allocation to
the realize function, so maybe this free should also be moved to
unrealize ?

-- PMM

