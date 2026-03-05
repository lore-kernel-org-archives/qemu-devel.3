Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A500AF3092B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5rH-0002J4-Kn; Thu, 05 Mar 2026 05:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vy5rE-0002IX-Lp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vy5rC-0001K1-Bw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772706180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apwCszF6CsScaP/aGHbcVv7yO5ZHGwYjzsniHZ/aoHI=;
 b=EamSu16AqvWcOY240WFAGMIj8uMSvoT8sMI5NfuqojR57uSL+lxL0UX4G/XOPJXirRSg2a
 KYmtW+rsdAPTho3Pl1CIPBZf5jNR3mqYiVoiBhjtq5ULoEWAoHtcUaJF9m2hoRmR16fKyf
 FbeOpBsvf0KVoWvfiH1sa4VxMGXiSB0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Sve2FUX2NOWkVuX3DCsRGg-1; Thu, 05 Mar 2026 05:22:59 -0500
X-MC-Unique: Sve2FUX2NOWkVuX3DCsRGg-1
X-Mimecast-MFC-AGG-ID: Sve2FUX2NOWkVuX3DCsRGg_1772706178
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3598733bec0so23600261a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772706178; cv=none;
 d=google.com; s=arc-20240605;
 b=IvEDKZGQDCl4yKrdZkpxHduB1CYMKjemhQrSr17QkdeZvh3A5xI1/rnJw/9xnvb+LM
 GUz/eLIGXktYhHsQrJ9q3eWf77PkrGQ/iOWlhVW2HWSgl8XUqTJuKA1q8bOo47ILQRXM
 Xi0J9M44aPA6Cl87WodMNvzS8bZDPj6KIvnOfqC2LQdhCdzX5ISHmqeqNjEXEm9D9qkV
 I2ja2RTePBJpoi3JDZKRbQDNdO3rRh9VldvbLKrOA2nCxGs1C/T8nMfBw9mjBJKD+X+E
 tf0YIHJUlgES+zHheNrEU6kW3QrW4IckeGuKlXUk9Vi4IuhIOgzpxoT4UeM2bKILbtrx
 UhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=apwCszF6CsScaP/aGHbcVv7yO5ZHGwYjzsniHZ/aoHI=;
 fh=7S2IgaxyiShzJPOc4Ytvwc0OHZLP27e9oBXA1z9XfM0=;
 b=kbU71zJsI7qQK6IZpAT0RI8ZsmuiLJsj/SNePBEgh2zIsqembj8JJHOyffczE8yXPp
 nX3Y5CpscuYpWbaNj+GcNK7PC7tf1RGAyPU6Cluvoq9EzKtluZgkXD8bzPSqvyA/b0w2
 +dXeZrI61qkX90C8tplhn9oidAYCJAEPxzaE4CQMG85tYcAl5XQN0XQhWNLM03Kj9Go0
 2ppp6SG8hjgXF4MyvIY6bJXPwKam7/6EQJo0KYo6yZ//M3etHMHxaj+koelM8ObawIVD
 zuztRp4ifhFDIP2VixbwyVKccwZ62nsYHewiNcmwKl+oJu27ZmEFViiiLmdcaEwBwNum
 3Exw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772706178; x=1773310978; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apwCszF6CsScaP/aGHbcVv7yO5ZHGwYjzsniHZ/aoHI=;
 b=O4OMgxhHx+9EkcfdI7KjI0229OHTAKqc1NjahvcMNELNR8lPtcb1UWNczFMnRUEgHU
 MEqvwJWUMKWzn5oIRMGpQ5Lqm4qBQjzDMAxT375+yVIln7qZrOG5ho5FxRRdfZgmvPcJ
 MCTUKbkQ/gwrb0Mqf6ARAmIUD1994kZy1JNtagKuzymed9K8FTmiCFgbXyTe0t7zFnCd
 q1InAL8SuHgTvwk8h3T/RGfeBvPREQ/le0eE4oTgY3F/BxQMhfS7WbUBWoZy49p9SZc/
 CBlQJVFzQgWvdCixb/6wO0ft7+NizJrVy453Jrq7VEkjkBjctX0DqiTpJtajSZuPDYeZ
 0pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772706178; x=1773310978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=apwCszF6CsScaP/aGHbcVv7yO5ZHGwYjzsniHZ/aoHI=;
 b=ac75jWeoVfg9fpF7rEsmPch9Min13RBnZFtds1aoUi84QaWgP+z6NzDco1FlgJpOMO
 qXa3DHJsQVZ4CLh/WqGD/B7EgP0bzfi2aNROsXBozLV0YuWJRBTdur+oai4mDGAR+Qxl
 nsnDW6Y6TkhPSH8ZjQ511rxuAk/xjKf5ikSEfWnsOrunI0jdo9J72vl4O4FnSsSCCBHZ
 ZXXhigbLSdu+Sz3kvjQ/XeR1uITboDrXOIy1kX/rKUm8HiW/JGybuKeZp77silkuofxV
 nGYW7NpdZSL3uHHLEFmbMvHqj1O2cl38QVJzoWZKWH5az+NUvS9eHAQSQ1T1AZfi0ezg
 In2g==
X-Gm-Message-State: AOJu0YyMxOXuAWlDIAv4gso96vzOHnNzow6lIMcsYCE1x03ZxcqQnszf
 Dxu1kfCw0An7HFw2oDjHO8AThkF5DYKji+BgNTzsVeUw3K/4SNO3eoC19ITggWxNS+UEdsvqMix
 KHj2nq1p+IAmMVMX/dUF2sp+bM6pDqGlKOaWyZcPL2B3388q33hcP6C05BkYLOkwpWZAyLxKmBH
 e47JOiFNG1YLhyt/1rGBS1GVcm6CbokUQ=
X-Gm-Gg: ATEYQzwtvWAUdbrjQdWld4iDrcusd1rrY6zgyviQRL4sQCHg/fUj+zlU/EnchD5NrKZ
 /njvyEMfVYioSLu5bAvIwFol1LqQcLIcekOZNw140YNnWb6hK3AhQDlk0f+vnxNO/l9gvVfN9C7
 O7sh6aAwpTydL3wTm8zI2aOY8HV6eXHvNMAhzrfL5S+kvIbQOz1hzMHs3L19ag+9MNJrCx1otkX
 RpEbDGd0XGjTKx0EJwk9y2ftgjBWqfXgAD/rdIF4BTWm2aAczMwnEKfnBL3iiRwZtY=
X-Received: by 2002:a17:90b:3a50:b0:359:9014:99e7 with SMTP id
 98e67ed59e1d1-359a6a66f35mr3722385a91.29.1772706177966; 
 Thu, 05 Mar 2026 02:22:57 -0800 (PST)
X-Received: by 2002:a17:90b:3a50:b0:359:9014:99e7 with SMTP id
 98e67ed59e1d1-359a6a66f35mr3722378a91.29.1772706177595; Thu, 05 Mar 2026
 02:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20260305003012.108262-1-matt@matthewpenney.net>
In-Reply-To: <20260305003012.108262-1-matt@matthewpenney.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 5 Mar 2026 11:22:46 +0100
X-Gm-Features: AaiRm53suoMfiw2kgezE1F9URpIfAWnW65vB8qh-RDO35wUC9B_s_OoSa1QChnI
Message-ID: <CAMxuvazif5c-wpPCG4dce-jm_G4MRxkZqP0qyp5TucudmwDLMA@mail.gmail.com>
Subject: Re: [PATCH] hw/char: clear dangling GLib event source tag
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

Hi

On Thu, Mar 5, 2026 at 1:40=E2=80=AFAM Matthew Penney <matt@matthewpenney.n=
et> wrote:
>
> Clear dangling GLib event source tag when virtio-console is
> unrealized. This prevents a stale tag from being used, and
> maintains consistency with the rest of virtio-console.
>
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> ---
>  hw/char/virtio-console.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 25db0f019b..11bf51e3ea 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -258,6 +258,7 @@ static void virtconsole_unrealize(DeviceState *dev)
>
>      if (vcon->watch) {
>          g_source_remove(vcon->watch);
> +        vcon->watch =3D 0;

The glib >=3D 2.56 way is:
g_clear_handle_id(&vcon->watch, g_source_remove);

We could do a bulk change for the whole code base imho

anyway
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>      }
>  }
>
> --
> 2.53.0
>
>


