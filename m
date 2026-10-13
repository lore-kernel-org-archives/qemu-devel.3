Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692CCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfDO-0002ho-8E; Tue, 13 Oct 2026 12:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfDJ-0002hd-Su
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:18:54 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfDI-00038A-CV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:18:53 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab395abf79so23512987b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791908331; cv=none;
 d=google.com; s=arc-20260327;
 b=bvHRdK9lY+VOYCGPJYpm1UggxSYmtwmrZZYK2stXc2pKVF0sM58SSs513orMf8iyCZ
 mU46JQuvQ+7yIV6XpKots2Mz4pkti3h+wDtwW5S1GthJP9tI9i0RilyZwoA/CxS/5mZ9
 fG62m9Ay2xPkEjgigyUDHmK3TpH4kdeZnAg9/Wpq2Q8+bBF4oLhPB34+QwF6AaB9phuC
 NfOMAbU0xMN+M/pko3Csvxy9YIkgBEFzcDEpU/FSl1PG2W/T/0bI2ylQHv1i71t4zBQq
 XKNYtW+hpRGoLK9HGdqWSkj9Jz8WCXU7jevLi1ArTpVnA28DcSsicQJNcEc6ZC5P4Xra
 tUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uSFyrq7MF/+dr64UynPLy/FZzbgropuXsz8I5b5n0xU=;
 fh=yE29BN9YPiN03txJamUTxK3vbnoWj0oSbgyMr6VNYLY=;
 b=Ktf3FlsPdcPMopmZUxM3kftY3NT0TiPPBN184RJCKznZnYs1sefAsFSJxr7K+I6b9r
 PwDijWX6hsPXEt+8DYlTddBzCr+L+3v4nfaELZpWYq/X9UnJKYhJ3U8wR4T1Acj261PV
 9RtL3Su0AlJADOVmsLlVnovtzxIzRI+JK2oEA3S52pJ8aanL4N7UNqEHUnZ7glgJTo1u
 FCR/EWTZuCQ2ykkLZ5LvK7by2E2P2j9seaB95e3DN8ZSlA7PUogtgfUMYknhOhkrBcX3
 Ep8MH4nHLllyMkqZ459Od9vHSVOaIVu2AG3lQkS8YWKP8hmzUgcFE0LDjLhpQ1MN4oH6
 /b4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791908331; x=1792513131; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uSFyrq7MF/+dr64UynPLy/FZzbgropuXsz8I5b5n0xU=;
 b=pQ2WmjcJz2l6RWPrzK4PgX2J9U6DzHO5qIZnH8tyX4ygHrmeVXoHpX3EUhQr3m7NBU
 bTu59SiosUF7KJY08In9xz9JEU71FiUeLE5d0QcY2YbdaiTnInaz6+Dd0VndKW+4sITJ
 vp51cpsc6C7scY2BB2Tax12F5SKp0QGu4uPmV8Xi1k34z4G9rI8HNaRUHlA6F+AcNEUS
 vd+KbhZ62ge/D1b3hIOq6F/0S+P074KExCKXynnxNeodJAhuBhbt2/rnBlB+d+hV/0wB
 j1M/mMV2xwB8XqdngCbs2WSFimdoNDaZGw6xi9a6fM46FUnlAV+Artzx47hgEi25AsA4
 4M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908331; x=1792513131;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uSFyrq7MF/+dr64UynPLy/FZzbgropuXsz8I5b5n0xU=;
 b=WJ8o/fz+zBtHpKOnV4SqH6yXZnecdkd8y+hYbl0Q5TIu5KBj0hV0b+WT3YIgfLIo3p
 AGojaEr+5iePaJiWWAdcsm3f6nw5MHuvtaILsbqWcTWtVdBjcZjNaRp9kSEKoaS2QXfI
 IzZZ7BamPyhbSEuTh4GT0d/Pl5cnmt5bW7NPYjgIpq3+mvML7YPCtIYjbxFEDEzWobAh
 WIwdYJVT5wEdSjpu8oFmdl2IftQPirsYHFROlfY19bQb8EyeoKQiGXTeuGSeA2ukxM0f
 wZ1bibV1P6JvssiS43e73qYoQT9FUo2IvlVVu/pcn8WMiUQGjRhETl+qOCs4+FLOHuYE
 WNpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBqNKDyXhMLpO2wcYQ5RBW45T7Q/t5dJcmzh0x8d8ALHqn6d7bzemdeS6O943KtmpQW+nk4rEqbenu@nongnu.org
X-Gm-Message-State: AFq9FYJ8cyNQoTeW3z/9LZFO4mCcWjskZhk9Mk1txKLWc9kWpqBM4hUi
 Aej0MSQz+57ffH7ASkMF3dlH0TnKmXFIZe5RhvStuniVmD2rlKVJWqgtJYimb4FQEMxioL8cegx
 jQv+D+wNiIQlJYX2mUKwF2ZMjdsJ77u4259BiJngknA==
X-Gm-Gg: AYBFou1w+83dqJKLq+H+5+2Slu4EE7fYnuIsuGKyCi6hIEaMoGtil4pConsRHNEW+QZ
 lEv+2nK6wUICTGvFiNl66RkY5Zu1TR6uezTVGfPK4gQ68TYO5anzw4jKeRL+boQOBQoETEZHcAs
 V1Ic4AP5ew9jIb6QNxfseMvqoTKwdUwzvPLCK5W8RtI2qYaEX6RJyBVEqcGIuP3wBALCP3HwvYw
 /hfIDUwJg0o+9Z/fYEg72V4lKuGHALodSExiwMQpuO3yUqCiE2g+QrLa4uUDgGKsNQkswmqcac+
 puRWqbcOab2rVqrn6mpnjoSiDz3/HbzG/ftEQRRpdRMWqwQjO3XkYA/MgrWqEFDycd0VvxuqJp2
 MtfBF/Eb+9U69c+qrmeRiASKEWDs2B5E4qBNRCXQ=
X-Received: by 2002:a05:690c:dc7:b0:8b0:ad5b:d485 with SMTP id
 00721157ae682-8b0ad5be51emr22293767b3.41.1791908330676; Tue, 13 Oct 2026
 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-15-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-15-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:18:38 +0100
X-Gm-Features: AclHuK9Uj62eefTNn2tV-70nIiu-sZcGTBekM1cKcu4c-u_DW2QPHqh2o45UiIc
Message-ID: <CAFEAcA_fv66MxW4QKHjUypSwTZL=LK6YVLgNvoMH83ivn=EMbQ@mail.gmail.com>
Subject: Re: [PATCH 14/22] i8259.c: properly cascade secondary i8259 from
 primary i8259
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Currently the cascaded output from the secondary i8259 is returned directly in
> the pass_irqs[] array, instead of being connected to the relevant input of the
> primary i8259.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index fcc94e12f8..964ceb04b2 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -501,7 +501,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* Wire up secondary cascade */
> -    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
> +    qdev_connect_gpio_out(sec_dev, 0,
> +                          qdev_get_gpio_in(pri_dev, 2));

We just added this line in the previous patch, so we might as well
squash this change into the previous one I think.

-- PMM

