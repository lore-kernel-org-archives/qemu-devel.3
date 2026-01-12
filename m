Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7A6CF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLXv-0000oa-NN; Mon, 12 Jan 2026 12:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLXU-0000g8-7N
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLXQ-0008KN-Dw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768238227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbR55RWmy2+YFL3bBwo9GTjTQBKO2lUGM8h9kri2GdQ=;
 b=dcktDard+XWPyRnTzTdb7hgEK13CqCs9lyotDcfYv82f/3kxhATD2tf/RdacCJco0FXf8G
 cgQ25yWb5V/gnJQNFbA/OThADZlS5eZQdBeGAjWH22LujJde0h1vcNMHhSMPxwfkx+sJjM
 2y0VFrJLMTtv0LXxksZ+YfLrYY23Asw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-jdp0QI1_OV-riXvYtUTgog-1; Mon, 12 Jan 2026 12:17:05 -0500
X-MC-Unique: jdp0QI1_OV-riXvYtUTgog-1
X-Mimecast-MFC-AGG-ID: jdp0QI1_OV-riXvYtUTgog_1768238225
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4310062d97bso4587410f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768238224; x=1768843024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbR55RWmy2+YFL3bBwo9GTjTQBKO2lUGM8h9kri2GdQ=;
 b=SYIqq0y9GYpCsqpvYyfqsAkBKLHS9upGP9mxKl7D0fUdf+LGjD2IcO85qJQ4lIPZoB
 /rsklIQfSAIlgaoFVVYZIzebu1ul8ksVKsvmDjkwGX94JOnkkSRsDNT7A6gJXrM8D/YQ
 6j2cTHj372rjr4HUGQLd+dVEI2EMPx1JpKY7J9JMUy0/xo/KG9cQUzjLNKwI3z72wJqN
 EQCRQyzPk+QPBBczs93Az6l3KLi3z4Onf9ckcQl2P6y4NHbaCRyYPjjOROp8quR7Sc0D
 OT6voV4ohg+JwwZNVF47LBuAYk+opkhODiRUb24XAL3f0RH9H+al8v7QPMVDVErDkgFB
 QrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238224; x=1768843024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TbR55RWmy2+YFL3bBwo9GTjTQBKO2lUGM8h9kri2GdQ=;
 b=PlPKajO6bwiV5d4cxlMUOO/X44VYVRRsUyLdKEpKZTn27YRTQgVRs+AzIBexidHLFf
 HfVX84SqawtiFQbAmQQJApv+71ogW8ZFZHvzHzKjix3l5pYoxTPCp8bRkjmivnNRzwBH
 l9G7OpqaMGufdSRQ5/hlDFxxeojCAfSIk0pu++YORiUTyvpFbLi7GbmsNTjz4En+a7lt
 6lWGgWQ9xkHXRaTGEmK0DABMZfJySgeMXDkMpzK+WKAmBUqdgxJBfsXAD0bcwYlf9kXx
 nKk12fmAf2uxQTPgM/UYiSoGgKiH0dRKR3osidLyw9J3lNaYlQDHKptxFvfyus0/56Ds
 3RaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ3qjCvgFNwktCyYqwHQLYjvz1uqRvi54BcoP19YKc6xfxHZXDEhVU7aCtY4QbTXL+SutasTpaNFgv@nongnu.org
X-Gm-Message-State: AOJu0YxXX5ZDpEcU7I8XfV0xfpNx1h+eJxeRzyuseZzEw9Ox5nsBbqVl
 TTyWC23nhoDv8IqVGh1kE0HvM26Kjl2N2AXaL317pfawyEKkaZbHioXCvugtvWppT030uIOgE83
 SYK8rUvLDS1Qeuv3aZmZBqYyWxhpyCd8BHUDv8FnjDZ8MnrKC8HTTDEFKRF6MuWKKA3f8sgjB6r
 WL6umfmOKO7O7XIOnDIG6dJgZ8PWYc+ko=
X-Gm-Gg: AY/fxX6bxAus2Ciw/hSXQVZ2FP5Sgz6VmBRMrI54uPyFiwHNrxJm9SLbo25IiliNRbt
 0KG9rYJcpQSLHypQi9GTJ+J3Pda7cSdNuK1z9Hf/t3nVil7HpeDpVsuomZJXWARBTm0q9HtcR9J
 g1wx/GjZu4qRyQ8X9iMLTzrUC1LlYGupfAxJE9szi2RvuoiBvqj2TqkwcAhLR/5YW/HFCKln/c1
 FsD7LtqQ4pcqo/Q5XrT24xDr62Ajts+65xoe01XWVPtMvr6JW/iANnmTt/IeozP2rtbnA==
X-Received: by 2002:a5d:5288:0:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-432c37cda23mr20069991f8f.15.1768238224518; 
 Mon, 12 Jan 2026 09:17:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECQTb3AWtvZ6WtGUK0wzslRe7ONR7YBquj6IL7iXXYKTj6yVbH5yuysBavac8M4eWjg1M++XI0XSm70YIW+a0=
X-Received: by 2002:a5d:5288:0:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-432c37cda23mr20069956f8f.15.1768238224134; Mon, 12 Jan 2026
 09:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-17-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-17-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:16:52 +0100
X-Gm-Features: AZwV_Qj1S01xS_RuEjlKcw9Q8j5Fzrs_W3hcCm8OfikDDZ1w-idEH_zwen_0kMY
Message-ID: <CABgObfaeyiubq1OZMsbL2h_fgfTrBY+YLJVTLksazCTF0mK9Hg@mail.gmail.com>
Subject: Re: [PATCH v2 16/32] i386/sev: add migration blockers only once
To: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
> @@ -2764,6 +2749,11 @@ sev_common_instance_init(Object *obj)
>      cgs->set_guest_policy =3D cgs_set_guest_policy;
>
>      QTAILQ_INIT(&sev_common->launch_vmsa);
> +
> +    /* add migration blocker */
> +    error_setg(&sev_mig_blocker,
> +               "SEV: Migration is not implemented");
> +    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>  }

.instance_init callbacks cannot have side effects. For patch 17 this
is particularly bad because it causes a dangling pointer (the notifier
is attached to an object that might not be ever used, and instead
unreferenced/freed immediately), here it's just causing migration to
be blocked forever.

If you can find a good place to place these that would be best,
otherwise you can add the usual "static bool first" method/hack.

Paolo


