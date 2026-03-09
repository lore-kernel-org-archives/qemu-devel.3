Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D19EF371E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQV-0002SY-Ma; Mon, 09 Mar 2026 04:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQT-0002I0-Ly
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQR-0001TD-TQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTdvl+pIvkwMx6APDggV+CtRr+7XkbGY2IWJS50V6To=;
 b=K00JN1EfSnhNCDe9tSBpfyCsf5vC0T6IpkX2ouj9FffglKv7KmuHxeMHZxQSf//Lf6k5I4
 6u3ZcK7lZQoq8MN57CEs6lwT0D+10Jj8mfMQlmLCOyaaELLUdE48sGSFEybFTmeObm06eg
 Ep8n+Yvz/XjoVRwzoJJHuYfMsOiCtuw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-FKBABz2MMgOp7PUJS7au7Q-1; Mon, 09 Mar 2026 04:57:17 -0400
X-MC-Unique: FKBABz2MMgOp7PUJS7au7Q-1
X-Mimecast-MFC-AGG-ID: FKBABz2MMgOp7PUJS7au7Q_1773046637
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82988b04c5cso10548625b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046637; cv=none;
 d=google.com; s=arc-20240605;
 b=coDG/X1/IToKhJsrQKyoik4Bu62fi6nTFfZEAd6/Q9EGYRRIyXOWr51dOUscd/6y58
 6b0GIs2Qb8v0gdWtThLilBSRVOdyyFvAcxZBa7GeLzs1M7PcAOpNhGiwLyGBWR+/6ZkX
 RCh38IDM21nIEEC1nzsKOEjwUbrLVDneCQcchkT2Rxm9HxxbO7mcWqde9mDTXL1HQaF0
 mIjLZpzEPAHE1Hh9p2af01JBe6nD+XXBUeVsfNkWOo7voMuyZj06rlv7aYbX15LOcHDS
 +C7S48MwUx7kS9laM3hnd0PXOxOM7BjxTM+yE34MT+sDzY6lMnt7arZIq9EBBEvV15zU
 6+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XTdvl+pIvkwMx6APDggV+CtRr+7XkbGY2IWJS50V6To=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=A+1K8W3AUajeiF6p4de4lSUpOlyeQ4HqNCstYRjZ7yvBHUdinmWjdYMjjG8iJxZ0Z0
 Yx/31yOXxhn7zaL2e+m8y89Z1B/xqz/ubahby9L6V+k5efG+oJBIsmoIRIbtt8ezt7Tj
 UMH8L5N1ZET6UaSry8PyxOW2+ZAdUK3r/6lNyM+uoLS7McZCO3mmyXmcnTbQRLYfRayw
 OJlTsoMEzwKPDYwOKvCYKzk6++SYSNrSSG55oLeHI64dxIrm6UgEQfDCJ/wFnte+l9gK
 ogq5jIN4F8m49aJHeXN3Y6of9jacXuV0Tb9NgB7lCL7dRrg4lelX0H4+Z5u0LZw51uHu
 RF0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046637; x=1773651437; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTdvl+pIvkwMx6APDggV+CtRr+7XkbGY2IWJS50V6To=;
 b=j8oGRTaQUaPOthG0/af6a88Vh0XpIlBkBvFvTNldJAiiR9Q7z3G50HLh80ORjngQTg
 c6HE0DpkX7Iay+l8/UGjFbfCwRmSQgxZbxsqATlpwbinzWw4+rDU91xxmq1MSCVh7gIw
 Z1jFjNT30IZT8i0B7yHDWgQuLeRgCxM8wbqgHcwTl7OXztz1yDAx8CHkimA+yNuxtGER
 +Js5dg/VJtBiVa2q1y/xmY4wuwGurNjP079L4q9ucpJehzESrkMVHk4HhHxanVk5cznj
 wUXZZgd5jR7RjSwVrvwvs4sorsBPotAk480zUutTwue8bjRu4DN9yKcBnUT5yJOClCp7
 yEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046637; x=1773651437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XTdvl+pIvkwMx6APDggV+CtRr+7XkbGY2IWJS50V6To=;
 b=wI1RwCq2v/kXITs3UJokct87xVvJ4ZDwUipCILWIHqS2etCa0wk9mPXQeP8HqQCwdw
 AxGqrqRIZ9SvQP/8t49f6xSp41iCryA8PxeGqQ6tqGDLaevzescNzrIzta/1Fwp4dGLl
 ejgn12fE91Vi1cUXjaVq9PZ/ZI0qp3yCyJ0b/NvXn9w5n9iO66YAU+GITf0g71qcwwMz
 8nv3geqyt/CNUU/apALs7OiYQEFLWqJ4TOohUxaLTGoEL5BDDgkJ9DWTLz6+iYI5spxw
 TuD+aXJZssuxVLPAdAfTubu1k3Q0vsKDowmJ+7GBAUK23EwllL6NwbU6t9W4FHnPEE6j
 5P8A==
X-Gm-Message-State: AOJu0Yx9NofroPshzsAIGTruNSGczdkCL0rxFNNHD57PRgf6zYKgtbql
 s2ZLCAC2/L++jYe1yAm2iKlbbN/z/RMIw7Wrzj/ojYQKQa9eZaOzoiwAVULRM7rbydGnWhxV/oL
 1PRp39xDD980QyNRkfpJuryBldnQ4lwIDoNUufhVfFGCTqZPfBx2QSWDI9SFAhnGiKOxFdDb1jJ
 0C51ecVht4NXEFb+MNpRucq2LgQNXUpdg=
X-Gm-Gg: ATEYQzxlvF1Hjq+GqioHpftf0kQZPLrV7jzKWPZilzqiZExVGemJoDM5PF1VduuY5c+
 tnL+CJRy5h/DU7+FCkvnCOWPre3fSky0/WGUzBlm9EKbiU0B524n5pmX71aJ8M5+2EfAZS/+qp1
 ml/3QVQ2nKqxkXtEo3XgtObff9Jxo/drgqTQWS0Sm7vezIXDa7C0+M2gEGoX801QplTm3LijNFN
 lwOkqHH
X-Received: by 2002:a05:6a00:7087:b0:827:2f06:87af with SMTP id
 d2e1a72fcca58-829a2f7d61cmr8312670b3a.64.1773046636918; 
 Mon, 09 Mar 2026 01:57:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:7087:b0:827:2f06:87af with SMTP id
 d2e1a72fcca58-829a2f7d61cmr8312663b3a.64.1773046636571; Mon, 09 Mar 2026
 01:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-3-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:57:04 +0800
X-Gm-Features: AaiRm52YKpEPmqrI2wq4ZJ6rd-Gk0EFVvMD0uRyMvg-UalGZh50J3ifpVIhQnF8
Message-ID: <CACGkMEugD95JBu4=qqyWSo2R=43AMFkRaLC13nxQVNWZmLQipQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] vhost: move svq next desc array to descs state struct
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> It's the right place for it as it is part of the descriptor state.  We
> save the memory management of the array, and make the code changes of
> the next patches easier.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


