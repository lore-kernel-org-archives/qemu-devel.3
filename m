Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5983FC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5f4-0004AO-RL; Mon, 16 Jun 2025 04:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uR5cz-0002uy-O4
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uR5cx-0005RL-Tb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750064135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TB8pH9CIWgvd8G0LKdKNGhXRV9n9BvvHO5KW78+WfW0=;
 b=fabGI020Ga8lJEpzCVhsiex7boSQ+fadd8U/gpBkSFcsUgThPUA0u4JUjKmQlRh5Ptf5KC
 +1Us7mbrys6ko/W2vGcg1etTT1sKlkGzGprgGJpyzvMo1N5jOaDpCT58Xh87KpXeDSK+t3
 HaOJxDv+thnba0ekDiSLLAw4eIeSeTw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-1dHZYmq1PJW1D_Ql0ecycg-1; Mon, 16 Jun 2025 04:55:32 -0400
X-MC-Unique: 1dHZYmq1PJW1D_Ql0ecycg-1
X-Mimecast-MFC-AGG-ID: 1dHZYmq1PJW1D_Ql0ecycg_1750064131
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso2772466f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 01:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750064131; x=1750668931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TB8pH9CIWgvd8G0LKdKNGhXRV9n9BvvHO5KW78+WfW0=;
 b=WBCx2L7Sqejc6TYkyU4jpffCSepYm4K9zP8vam6t876MPflu/3CaqGYgY9mEsqT4BG
 XKUKcFdvINZcAowDruCsLmZEJnIj+knqWsXd8yhEYptDMSnUJxfUmVae9cx00aeAbmx5
 GbfiQYpjH4dGS6bynnWK+g2viBzwM2ZmnVEQdkdmjKJugStCGj1zfc+mH5lP9iA9F6UX
 xMrXEkuQOqs5rN+w0Upmw3R0oAlcHGcdbNsHTZRWNSw9Th5zmBVoqVPWQk7hAW7TajXu
 bhZVAoCPfXVneAGxcPewRFgYL/ogBsHJpT59TS75eOisK/pBS4Hlyl8Y/EDsuOzSkZPN
 pvtg==
X-Gm-Message-State: AOJu0Yyjnx+kwjZKjaf4UxOVKoJECLLorBWwoGxmuq+NhXLRGECJ3bQM
 qFjiqjOzODBXDvPkxrUeF8cXQpK2yo3n4EZZaQidduEW1T7au/xfezYd62moHz3bAQDSqbZoulq
 9EZWgauDppr95pFHQlyfEmi9zsJZF5highWWEnajAPW8DEUASr94Eit6+EYHTJUHHe3kAaWsqCJ
 tMLTZZWUBitUc5ntKRZiSrWnl0HGMCtZQ=
X-Gm-Gg: ASbGncsWSZ+EgxfPyHWotlEgJo/jxw/0Jaef+MZrzJI1Z/L1H6T6BeEcvMmLx7F2UZ3
 6IYo3VRdg3c2qKb+VA5RMjq78Q246kAlB324k35sBPn9M4XmaqKNSSELB29JnwTIo/LWIVDh6eZ
 ESwDZC
X-Received: by 2002:a05:6000:4818:b0:3a5:2e59:833a with SMTP id
 ffacd0b85a97d-3a57238b9fcmr6751165f8f.1.1750064131349; 
 Mon, 16 Jun 2025 01:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQYhPA8JnZ3ZEVz3jqhLHCfDT5W28ZUUGCyW+IeL741cQBAC8pJh3aNW0lRe1o1Kbiob/B+rTJfN/y0BB2uo=
X-Received: by 2002:a05:6000:4818:b0:3a5:2e59:833a with SMTP id
 ffacd0b85a97d-3a57238b9fcmr6751152f8f.1.1750064130995; Mon, 16 Jun 2025
 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
 <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
 <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
 <aEu90HVJsySBHJKz@intel.com>
In-Reply-To: <aEu90HVJsySBHJKz@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jun 2025 10:55:18 +0200
X-Gm-Features: AX0GCFvMsH4ieTPhQ_OjiwbHWb6zj-Pu8gMH6MxR9xy0Jupm12-TEsSD6va9AxM
Message-ID: <CABgObfYZO7bd41CNo9c7dg+mDYXAUhv_5+rkW22oq5AaxSXkCQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org, 
 armbru@redhat.com, mkletzan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 13, 2025 at 7:36=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> > 1) everything is done through an intermediate QObject step (e.g. for a
> > setter: Visitor->QObject with an input visitor, and QObject->Rust with
> > serde deserialization).
> >     + easy, Rust only sees serde
> >     + QMP commands use a single conversion step
> >     - inefficient
>
> This sounds like a natural approach.

Yep, serde is complex but the result is very natural. In some cases
serde has different defaults than QEMU, but attributes like
#[serde(skip_serializing_if =3D "Option::is_none")] can be automatically
generated by qapi-gen.

> > 2) everything is done through an intermediate C step (e.g. for a
> > setter: Visitor->C with a visit_type_* function, and C->Rust with
> > generated code that does not need to use serde).
>
> I understand this step indicates to use bindgen to generate visit_type_*
> bindings...

More than that, it's using qapi-gen to generate implementations like
the *Foreign traits used by Error. Marc-Andr=C3=A9 wrote his own traits but
I suspect a lot of the code could be reused.

So I must give credit to Marc-Andr=C3=A9 that there is a big advantage
here, in that a lot of the code is already written and it is simpler
than serde.

Paolo


