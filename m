Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA54BC3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJoq-0003gH-Ed; Mon, 01 Jul 2024 12:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOJom-0003eq-UV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOJol-0007Y4-H0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719851030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kfUx/VBWr7PyXTLY3vkoXaVOy7pT+UgB7PIyc/ZqIUI=;
 b=P2n2hn4pCq5UHdDcpUzJHjSLvUS5jraEOODAhA4W2gv5LCCCmOLKg8KDRLDwDatoL300jL
 sGAxcx2/2frmmRLuKls/XZG905UN+/1poWZckZP9iACBcvc3HpNvSV/QWFQ9zBLV/odE4z
 ETKjYr9VJObdLtygSjE27mPniG/7v04=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-AcCRmy3HOoOyCkuHB1py-g-1; Mon, 01 Jul 2024 12:23:47 -0400
X-MC-Unique: AcCRmy3HOoOyCkuHB1py-g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52ce324c204so3813416e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719851025; x=1720455825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfUx/VBWr7PyXTLY3vkoXaVOy7pT+UgB7PIyc/ZqIUI=;
 b=lfa1R1BvLKf0Z1azrMJZDMUfbTSgdkDYRYxod67wJEQLZZGsa1g5KAajm/O060cFD0
 vv2VDFZdf7MB+7QIZO1jM9u7KlZdVcYDRlW3CG9GZhzvNFYJzCSXKFcG3vHwdnf4hJac
 dBHfCARHd5mg6aPh/D+yIg8TwF0wI3IL2e1wFWFREgxDOsCt4vbFRFVnmBWg98fKQPYQ
 3fwy2p7AkmOkHNgLSABN74PV9fHxO8yv6RYH9CKFsRbn7LJTKRDaJhUk/DORh4Ho3S2b
 i2+4BEt7BYBRqgd+/U/Tylsx7uhK/DwqO4VatwZjgbnsU/5HaeQTcfUdFlWJ14/hsir7
 6UNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSgMSGGAkR2Z+tyx3DtrlZPWGBTcVXz/BV2xHJckMBVnuYooGwxr+rE5Rscd/KaLFqHf1sh4BvUcimUoo5Kj6xNt6VFA=
X-Gm-Message-State: AOJu0YwIvghutMMwS0TvlvHoI+zwaKxVqvzY6QmH7vzvj62uRl/LliJc
 Gi4IhHbMUj58rjPy0q4WOgHTRRvPURf/MJdNh9jNJO2LbcOu7a8Ay7fOPWWa3XwtXKzde3FmGzM
 eNXM+mqpWm3Plo5OH9LaA1iuPVeYTltf7XVQAd6Q1ouv/dlCBg5UFM9zicQJCtVcHXlpCV91rG4
 3OIC/wK8404TtYBUj6Msc04EURMFoTfP8PclQbMg==
X-Received: by 2002:a19:7503:0:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-52e826664d2mr3376914e87.22.1719851025547; 
 Mon, 01 Jul 2024 09:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFw84RntUCdAGcmhKAkx4OVyqHT3Rblx2FKacwmatREcCvWs9MpRrTzjpTNKgagmE2EjhqXzPenYMeNdoB22M=
X-Received: by 2002:a19:7503:0:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-52e826664d2mr3376902e87.22.1719851025181; Mon, 01 Jul 2024
 09:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-2-dbarboza@ventanamicro.com>
 <522ccd9b-8551-49a9-ac01-0c26776a3d57@linaro.org>
 <8c356054-0921-4437-b64a-8bbf68751ce6@ventanamicro.com>
In-Reply-To: <8c356054-0921-4437-b64a-8bbf68751ce6@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 18:23:32 +0200
Message-ID: <CABgObfbZBYXUb4x1jS6f9vGWu2avdfmGw_LW9YBd7WNSgMwLqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] system/vl.c: do not allow mixed -accel opts
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 ajones@ventanamicro.com, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 1, 2024 at 5:53=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> > We use '-accel kvm -accel tcg' to allow kvm to fail (e.g. no /dev/kvm p=
ermission) and proceed with tcg.
> >
> > This patch will cause testsuite failures.
>
> For the issue I want to fix patch 2 alone is enough. I'll re-send.

It doesn't; it effectively changes '-accel kvm -accel tcg' to just
'-accel tcg'.  This is why you didn't see any failures, I think.

Paolo


