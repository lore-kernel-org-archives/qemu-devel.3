Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652D7FD3776
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIl9-0004VQ-Mc; Wed, 25 Feb 2026 12:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIl7-0004Pe-Rq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIl6-0001w4-Dr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772040791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IuTD5bdgCqE1TQ1KMXrQCHgFz4h88scvew6k8sf0d8=;
 b=gNUFZOBIoF3nAlG74YoRYeYec3M/s/FR+XK0PVOuDSGOYGdKaGKmiXOQB+E8G6HwHDwphd
 oiOI0enOvQQkJt8VYBqSEvzveNaMIpWUOCJGhUkvzNdOKjrvXyvZZ/+JVw0XS5McdGKhK2
 wLWaXj5e46mXOR9xinO/aPX7t70HeqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-bwhpNBUsM_KJB_4SY-w_vg-1; Wed, 25 Feb 2026 12:33:10 -0500
X-MC-Unique: bwhpNBUsM_KJB_4SY-w_vg-1
X-Mimecast-MFC-AGG-ID: bwhpNBUsM_KJB_4SY-w_vg_1772040789
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so140865e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040788; cv=none;
 d=google.com; s=arc-20240605;
 b=ZqB5G1HKBs9W5EkmsZv3/IuQQwpK07VRP9je7YDgWDnZf5Y0f5+bDvhMxNeTCm7j6v
 6bwD1nHZPJqPhf127UNQTlRv4n7aIfqRwQ+AOH4GAZe1cUKbgaWCu2bgOQuECbkuoe2z
 pMzfmDWOldVwC8qpSxLg6+v6wYiiAe4CV1Gkhgi8i3w2/IBDVMTjrtvllrh7y7zYuOaS
 SPbHOsjjbZ1JfCFgsNHYPUFUiZ/nRr66JIvLX5Mb2k3XyQHju6jwyRRqDBuu+uQTMMil
 3jlHrxvdfjeZQ2JyqEchHYqeM3iok0k/2j2jc+QK4SKfBr7bWieJq1AC+w8EsnG94mIW
 D9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5IuTD5bdgCqE1TQ1KMXrQCHgFz4h88scvew6k8sf0d8=;
 fh=TDycUWE0uzdQvy+mVsJ/+3GzsWEcaAgbj+auOr8f7+w=;
 b=hl9QVAlUAmNNF9adj+dKJR7eudmxw89faTlCmA8bGyX/oAQVN0+F5hRfT30hSjFPZf
 R3ibP9liqCXum/VyXwtMU9js3SEmf/sDqB8PF5IEM02fgzts0pGl1qIOjrJqjVIkDfal
 yRsoykRqRuIm1+JGicVzjxHxvxDIzZzibD4vcW8Ve4jygOIGUG8kb9S1JtcPG7fpANps
 SDhtUYkAcjiQRKy7+nSqVsKYZJvOdbmvjOTR379xp/Pbals+51TP2Kq/LMkC8mYeq3k+
 eC3jOcElkCx1vyhcPTdGz7RpcoM1ijSvxzrJMFcLtZAgqRFOrvz6N3JAnl7NCZgCdjeC
 m78A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772040788; x=1772645588; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IuTD5bdgCqE1TQ1KMXrQCHgFz4h88scvew6k8sf0d8=;
 b=Wn1Y6uxdMm69TjBjMDUohFNdXHIIkfvTKI2ZD3nM2L699QYbGeatPeEKZbqtQq5mf8
 GSaeVlabtfSKdm976n2mgf4dCYk5fwwCm5tBZ+SDRdYDdOfF1y8M9Z5ErElOFpJUjoxn
 p7M/VUNa/l/2RkAbrATwVc5UtKI8/WNlQzSE/obGiO+eU50ZrqpChXBHezqr8cIEhwT7
 5EzY71ZcH+bEAOvH/Y8WqXoKi8AIvn92EfXLNLmCYRkzc4e5yjiNteaQPxZ0upxxV/Rz
 UuYwjSgfftT9Kxy1C2wAdboOcHX7qdQ/qiESRWltPEL2ZBZSrNx1KX7k8GbPwye6tq5Q
 rDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040788; x=1772645588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5IuTD5bdgCqE1TQ1KMXrQCHgFz4h88scvew6k8sf0d8=;
 b=J7IO9aK0COoIQ3Pq1tnbY9eyFxsJtbGWUawIGG/LbpeJudDRDGRc4XwSbaPY72nvdT
 +S7WrEFAhLhsIv3a+qH18HDtF5PjWJWWq9Kh6MhHpZ80OTy2Xqxzh172bfodgjkIypnT
 Hn52Fv14dJT4yeE/AAVhQi4Qq5eght7uj2+/fFAANCQuxZcWKZGT0jg7gsI73jlXB0MR
 92hdIXAmFgRIQrzYn8rS7PSV8LhZ7GRNdOhcHMapD0dv8wyLvcUBqTrFeq8NbSO3bKUa
 hw9s3Qe2TE+06j1jE6sRiKTh2abD7X5Xb0fHjbgn2DAvXIeyX5ej6cs1sQl7rKYqQeU9
 e9CA==
X-Gm-Message-State: AOJu0YyuSh9+510dyHdI0yltCG7mZVreKlmjw/tYCNO8z7crC0L65Y7o
 7FNVQxNiC4CPb1pJtJiQ4Aq0PV9YDKiRAdiVd5vDkp5v19kExrm8If7nVuOIvtJdAdggZyQQP81
 nNsWt89vjlpKFtyt/An2uOUmgHfjG/qUY8TeILqwyBfKwKkVY4WiUjI0Z+CMTdJKQyTfDH/yGak
 gGowAEjRpHl/d6tp6n+Gb7KHql/rnv9gFvxjy1B1E=
X-Gm-Gg: ATEYQzx1Vl9CVuiRYMYyz6eaGdq7BPEgVvnqY/71hsD/OdO6wAM8TfP8oOuF5FkCYk+
 hjfm8WTXW856keYpPpkjkqhVuB+s7AllhbtkuUtUnX4w8jBb9ugiZJzaTLjO6k2ylmWDJxJTaMB
 Q6fcJ9hlFNaHVgfSa36bms5TccrN/2GM2GSaH+amIti/CYECFDwIpK+wiFQvCCM2Du/RVonRkbi
 TpkqvpAMyS3x+iwxqWRjwmwt/YsrWvDmdyaO3NYrsbjfIGJlR/a4bsmjL4i4rqXfWMdGZd0mDz/
 4ljzzcI=
X-Received: by 2002:a05:600c:5491:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-483c219ebacmr20939115e9.19.1772040788396; 
 Wed, 25 Feb 2026 09:33:08 -0800 (PST)
X-Received: by 2002:a05:600c:5491:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-483c219ebacmr20938595e9.19.1772040787973; Wed, 25 Feb 2026
 09:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20260225173206.418188-1-pbonzini@redhat.com>
In-Reply-To: <20260225173206.418188-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Feb 2026 18:32:56 +0100
X-Gm-Features: AaiRm53NWd-umR1x0tmIITwVVo0GYks99NRI5P9ZSd8bXEkEZtdt6e_yPJaFPqg
Message-ID: <CABgObfbX=64gTY3kXLXpgk2_bLFj5FvtZ-COQTqPRLHFmc1Q7g@mail.gmail.com>
Subject: Re: [PATCH] ff
To: qemu-devel@nongnu.org
Cc: graf@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Note to self, always try --dry-run first.

Paolo

On Wed, Feb 25, 2026 at 6:32=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index ae390cc98ff..b3f1c66f18d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4785,6 +4785,7 @@ endif
>  summary_info =3D {}
>  if have_system
>    summary_info +=3D {'KVM support':       config_all_accel.has_key('CONF=
IG_KVM')}
> +  summary_info +=3D {'Nitro support':     config_all_accel.has_key('CONF=
IG_NITRO')}
>    summary_info +=3D {'HVF support':       config_all_accel.has_key('CONF=
IG_HVF')}
>    summary_info +=3D {'WHPX support':      config_all_accel.has_key('CONF=
IG_WHPX')}
>    summary_info +=3D {'NVMM support':      config_all_accel.has_key('CONF=
IG_NVMM')}
> --
> 2.53.0


