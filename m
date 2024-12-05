Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CDE77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJHW-0006sI-DH; Thu, 05 Dec 2024 16:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJJHU-0006rC-G0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJJHT-0004oq-7X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733433661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43Lc1qkqIGe8YXJdAU6bbqzg75+1s7x6Dpw0bghVJn4=;
 b=emJ93fW9DFrknot6M+P2QPuhV8nZiprdKVT7miDnKvQMjENafeuiM0XAdbMJ3MAvto0Yid
 lSY5r0p+Ef1c6mxqflrk/Imp8wGXz7HTecU8oueRy1ACNi58VYQt7g9GSNkM5Lh5EDWiht
 mPY1N/n6YunHxvkwOm5/+lych3Az2u0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Ic-95BhwM-2tM7VUrotk_Q-1; Thu, 05 Dec 2024 16:21:00 -0500
X-MC-Unique: Ic-95BhwM-2tM7VUrotk_Q-1
X-Mimecast-MFC-AGG-ID: Ic-95BhwM-2tM7VUrotk_Q
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349df2d87dso13152565e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433659; x=1734038459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43Lc1qkqIGe8YXJdAU6bbqzg75+1s7x6Dpw0bghVJn4=;
 b=I+Mg3emHmq9bEl56/yvYoyzMy9+yXyD67mVMR2hNGwAph0nkmdEAit3MxPs7aVjXf/
 H0PQaWwYvKU7o3UKHfDr0QixZ4OFPmXHbl10Oq6tHYDv0iqXV0EbAnMUel5HnmKAlN/g
 7lI1vQDrRJC2JuQS0LH86mV7ECFq9GdsOvT+DsjcaBt9ovw+1r2cs8uTUDMRy5hBGVSG
 Uh9JM3xRp/kPggkxtmgfOzP9mXW2GjUrX1TcnMCUzAH0SH6fhsvKo2fo4lGZgqXgTown
 t2E0mK+bHlOm73X1Hn8bqb+/rlHAs3EYdjpCpooYWMCrYNkvtMtEB889NBpGLAr0Numo
 9phw==
X-Gm-Message-State: AOJu0Yz9z/5Rgs2NQmXsqTkW3OJYRj4HbfDdIAcnCqcvvEYXsJs7TS6Q
 u8lZo6nhngP2hF+rJvRLwWcicPXW6ynt7qtmHNC10gI9fmWNdh7cv2lWeoHSAyFB1ZpQWuAF7Dd
 c5u8AlkKWLQ7Zest4RWh/Dkumhswclz8O5d1Fe62spKUEPspilxsKmSu+106spqH5tTTcz5qyIw
 c2pL0k8oDeP7GOwtWwS7Nn3GW6J00=
X-Gm-Gg: ASbGncuYNQhjCIfvq/XOj5wwPIRQazCi3pu8OFLzVs809s3LGJQwZo3wnS5FpaCDluT
 4TzRHASbtYX279Qhv3gUPFZ7J5u78wGo9
X-Received: by 2002:a05:6000:18a7:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-3862b355428mr549539f8f.14.1733433659583; 
 Thu, 05 Dec 2024 13:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiv9rD97P0nB7n+IyFpR02kYuXC5B89tPtfRxH4yNU0toswWiLkYb3XpDcPSrdpA5/qH81l8PERW45wC3jpMc=
X-Received: by 2002:a05:6000:18a7:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-3862b355428mr549522f8f.14.1733433659231; Thu, 05 Dec 2024
 13:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-12-zhao1.liu@intel.com>
 <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
In-Reply-To: <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Dec 2024 22:20:47 +0100
Message-ID: <CABgObfbojr4fkXq8tuuXCAGUdr3Vefddx=ERtMUx9w6Bqy0a3g@mail.gmail.com>
Subject: Re: [RFC 11/13] rust/timer/hpet: add basic HPET timer & state
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 5, 2024 at 9:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> > +    /// Instance id (HPET timer block ID).
> > +    hpet_id: BqlCell<usize>,
> > +}
> > +
> Like flags this does not need to be a cell.

Well, this *should not* need to be a cell (ideally fw_cfg would call a
C function to generate FW_CFG_HPET) but it can't be done yet, so you
can keep it. flags need not be a BqlCell though.

Paolo


