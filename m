Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18F6CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRlv-0001vD-Of; Mon, 11 May 2026 10:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMRlu-0001u9-4L
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMRlr-0007n6-FD
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778510289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bd84mr+O+wQXPhzg9sFPY5yd3qjAprSCaqvDL29vE0Q=;
 b=FLiheDJiHDA+LXvA76CjkSSW54abcMEkwYvpv+C2meL7xp3RiZFcCxvUehFkj+FDsER6Ns
 pp3l0lNzpuVO+ulDwfZgmU3z2hG4gpg4sriOH5WO7/Eokpcj/cuNaNJ25ah4EpN2La1BEe
 NsAO5QMw+Drwl1JxUv7HI/Vuctln4e8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-oqAqyQ-tNgm1RlmBuR0CDQ-1; Mon, 11 May 2026 10:38:08 -0400
X-MC-Unique: oqAqyQ-tNgm1RlmBuR0CDQ-1
X-Mimecast-MFC-AGG-ID: oqAqyQ-tNgm1RlmBuR0CDQ_1778510287
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-366ded3bed0so1837246a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510287; cv=none;
 d=google.com; s=arc-20240605;
 b=AZdKJw7u1zmgOQtUraaaXpoaOo8kgBJDItahXCTbyTanuHbji4n5X+WDBlwXr5uqR4
 klHbArd/elcmDV6IWWBboL6+S+gte/lVBlJUh9TmAAdWYuACE1WRPW2rLIJcyon+QdNo
 tpLlXhRf0fxtcpi4iJEwzi4a4prVLu+aHkK15cEPRRrO5nnoZw+pUZWPwXXjEIBaCiNs
 en1DbdpZUZNe1hXTGJWiA5h7nZYmRO5Mop3L4i6wj2Xm0dKo3eKk4pmGsVJ39dcnH+Dk
 MBl3zFE0/K1/fBTt9WjKLqqnM7I7zqiQmumkg/SCVVwlFjWtPKoI1dIvB+TYQH+Hmfw/
 a0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bd84mr+O+wQXPhzg9sFPY5yd3qjAprSCaqvDL29vE0Q=;
 fh=DE3UAGgJF/+n6TrkTSdcpdsriQ/+3DQh/puSSyhh71g=;
 b=h1fJtWgcJeqX1JSOEwiKBHQIfX7S6zUZ98/iWAgAKrOS8OoMiwBqDdGDlAaj4gJWtm
 iN6J5yGg+XqJk13Nbln7hWoY3WADKMUuewvLhjOmUAfLpd5aJW5mlWj/GnrVV8eut3qX
 lqQz9JAy6W3Bop8JK7i5MNCm7D30psG+tkUM/xy4KzCbBQpo3leYSHojw4NBSHdcs2/M
 VjGmPxxTX/ekcmLntT+qVm5oIbc+gMef99fmgcpKeD/I0lQAihZiBOjRhV3YzoUMOR94
 /y7/AhAX0/ofXS4w7bkboHGuusMDSKqh+fE0oBcCi67NQWN+JwZ7PzlvCOMnmDCWNslP
 LCsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778510287; x=1779115087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bd84mr+O+wQXPhzg9sFPY5yd3qjAprSCaqvDL29vE0Q=;
 b=k2K54rytwYQRjbvww5SdHfgmAvOXEO3F+eZghcNhPC4A9gL0Y1nwEGnYY6g98djCX9
 CGQ3CHV731g5K4sWFZBUSPW7ioivpY0iyWgfr7DA1mQkp6jsONCGqhaN+cuReGBGhKiw
 IuDF52Wud287kF1JpXEpPoe/FLGx9E8FYOz9+FDu9UTk8rOFBOYco2XvK4i8IvwQNWMB
 Di7l+NBGNYoYdaRcMataOeS3wStTdKcjg4oYgiW7i1wzfNpcHXgQMv0+RGps+jKM8z+x
 Vm2HBXmCQUQ+mdXLK2dmv1JAd7VXrU6dU/C1CnmvrDGTJQOAMpbmCEhRfiYIv7EmiU0U
 jbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510287; x=1779115087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bd84mr+O+wQXPhzg9sFPY5yd3qjAprSCaqvDL29vE0Q=;
 b=L+GO2TijJ3SmtGMqso+OEvNFU7ATp0ZpiwlEG1yai/m/OSNMdrakPg5zBeRF9bawco
 6uQLTnYiJtq1VHpqNatLQuu/7cbyNRnqyZ3Fmx9lc7uMc+PkLaItyHUHo/asl4WiP5tg
 MnnI26ymSrIYJdngduO+oaUAAzpUqUqU0pljARReR8DjUYrVyng03/CbhYlURQ30uLoj
 dJ2IUeu28EmtwUj/DKzE4ZoTDG8PmcrnUUo8tc4SoCYpQYDZx/g7MVe0XVovaoNdgQZ9
 PbXPK1idaHAid3mA6EQjsednbjaDcbwD7iJ8jmA6X5jmvd5h0P0IJ6Mr4TX6jYps3KfC
 wMDg==
X-Gm-Message-State: AOJu0YxWURP4GZpQXmx67QY/QvuIJh+2LvsoqS68JsCvOxRtJUjpAE95
 RxOGHYIqev0a+HZk9Lt3BPXtapwLuqtGPRmHXpBdDyYai7O9VF0y/1Wpe/jnQPjnx6n8Bdb1Eqq
 opQdrJCMvq4b/G7DTaeobnAFPSSR1u0RHK8KQ8rjQCBK7Be7dfVLzh1aKAaLpYlbQPT/VkNlAhW
 2IaqSzDTFmzNkb5L3/hSAveBcIvjc8Fa0=
X-Gm-Gg: Acq92OEQwuL0okAfObJ98fLBPMZKF1SKa85Nf9KGy87969gOcLu70bL/6a+q+xqYDb3
 DBedz9lp9y2kAPPEl1G0wFcTgs+6N3b5uAYMKrBZMW3tjB/QcPELE472uLmPSbLqFM7pd6kxCJm
 MIVdUfmqJkgWRZygS19jZ6Y6Es+EDu7LB4rNCMf60RkSPaTdoTv52nt/BYtDAUPHm8RL9jhKLrY
 +A1C435QRKr93UFC7GsygcI2CsPIS+TncMO5regXtiAPk+iE/iwy/D++OhmcYrjGz1v5bYJXd1h
 sz2egzhXY5VRuXVvQzaMCrc=
X-Received: by 2002:a17:90b:3a43:b0:368:4942:50c4 with SMTP id
 98e67ed59e1d1-36849426374mr4395769a91.17.1778510287227; 
 Mon, 11 May 2026 07:38:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3a43:b0:368:4942:50c4 with SMTP id
 98e67ed59e1d1-36849426374mr4395731a91.17.1778510286744; Mon, 11 May 2026
 07:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260511142219.797048-1-stefanb@linux.ibm.com>
 <20260511142219.797048-2-stefanb@linux.ibm.com>
In-Reply-To: <20260511142219.797048-2-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 May 2026 18:37:54 +0400
X-Gm-Features: AVHnY4JJBQSlM1lnyxwN8W6solQOh4qpcGoZFCnsyH8zUYXQBlk5fJgNtDcwcbc
Message-ID: <CAMxuvax=1vyTBQrfzm5ncmL=TPhVD-jcRD7M2dFOMY9mzLNCLg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tpm_emulator: Reject a buffer size different than
 what was requested
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 6:23=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
> TPM backend, then the tpm_emulator (swtpm) could still adjust this size
> of the buffer to within bounds supported by swtpm+libtpms if the chosen
> size was outside the acceptable range. This could theoretically lead to
> the TPM 2 using a bigger buffer than what was requested and memory
> allocated for. In practice this would not happend since the requested siz=
e
> of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB happen in the
> (currently) supported range of ~2.5kb to 4096 bytes. With PQC support
> the range will have an upper bound of 8kb and a lower bound that will
> support the (pre-PQC) CRB with 3968 bytes.
>
> Fixes: 9375c44fdfc0 ("tpm: tpm_emulator: get and set buffer size of devic=
e")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  backends/tpm/tpm_emulator.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 75c33d290e..ac5427b84e 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -364,6 +364,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
>  {
>      TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>      ptm_setbuffersize psbs;
> +    size_t tpm_buffersize;
>
>      if (tpm_emulator_stop_tpm(tb, errp) < 0) {
>          return -1;
> @@ -387,8 +388,18 @@ static int tpm_emulator_set_buffer_size(TPMBackend *=
tb,
>          return -1;
>      }
>
> +    tpm_buffersize =3D be32_to_cpu(psbs.u.resp.buffersize);
> +    /* Reject different buffer size used by the TPM than what was reques=
ted. */
> +    if (wanted_size !=3D 0 && wanted_size !=3D tpm_buffersize) {
> +        error_setg(errp,
> +                   "tpm-emulator: TPM did not accept the requested buffe=
r size "
> +                   "of %zu bytes but adjusted it to %zu bytes",
> +                   wanted_size, tpm_buffersize);
> +        return -1;
> +    }
> +
>      if (actual_size) {
> -        *actual_size =3D be32_to_cpu(psbs.u.resp.buffersize);
> +        *actual_size =3D tpm_buffersize;
>      }
>
>      trace_tpm_emulator_set_buffer_size(
> --
> 2.53.0
>


