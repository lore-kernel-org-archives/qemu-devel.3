Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A25E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVC3W-0000YY-Hr; Tue, 07 Jan 2025 11:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVC3V-0000Y1-1I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVC3T-00008U-Ol
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736265821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asW1LTV43nxvAamuwi2vYstVviQNdc5YaTrUV6wVhDQ=;
 b=NxFDMMRsSON9uZHRjy0Z9maiobkpW6f13pVncx+AceC+jd+0JAkorMDRo/gFbZiBILjv8q
 RV+gnreVUfhfcTo+V4xAEvsrQNJYlCzuD1TXAGqrnTDtmwl3d6qcn1brwWGyowvNU7/hlu
 k0qpnEJV79hhOKZaJgx9iAkF8NadQM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-7mn3nPvsPwSdCep_CIeZuw-1; Tue, 07 Jan 2025 11:03:40 -0500
X-MC-Unique: 7mn3nPvsPwSdCep_CIeZuw-1
X-Mimecast-MFC-AGG-ID: 7mn3nPvsPwSdCep_CIeZuw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38634103b0dso9295817f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265819; x=1736870619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asW1LTV43nxvAamuwi2vYstVviQNdc5YaTrUV6wVhDQ=;
 b=LukoVCv1AbGy1AZ3lxJ9gvpFgKjAQVaFyTMcv/7qpdvVAI8Cxq7xwJSOhuZwXBEvxp
 hc60oNmR42GrT1BzYPmuZFSCz1AUQAmGnDhbt9ZgAQ9F2/XQ0nQYdu8MuQVhnbRMyc/k
 SBZOOTFqlb0YJsvW7HJOl4XrKdN3QeyngXFaDb+dtQ+FtrcQ1Mejs3C0eQGlcfQ9ptoc
 mFlHfeolfCMoftSWj4Y0qoR223rgHp3f13NbtozC5I2RiI0zdM1D/n7XL1UEsxvaFNzm
 HRr8+UUIg9fkwqUZy9MayQlYx2DB5Oy+HtTJqXpVjSFytG9PrzUnvPzC+HwvVLuwTFIz
 eovw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFEmDIfrskBisEJFJktmNLPSFTf7wAFbT44OmDXLrpKcjlCvLSDG65sVP35Lj9gjmIIrSZveNgAIHh@nongnu.org
X-Gm-Message-State: AOJu0Yxru9PeQEl3bMQEZSHXuQizQd7ktasoZS/Wcbfkt1E97aiP1K+u
 BfP7edRRZi2Vy2wYkTkCkc2tsga6ik3O73jIQC/++klM7H0q1s5KEomqFSc5rg7hgSL0hJ0q7Z5
 yOzZGOPZAMh07XcLF84J7bz4ekH2LvS1JXuHPumEWbKE+vn0usTT2q0orxA3ZzLEfm5HoSxjQAs
 3lP8W9OGUKcLRhVS1KypLOdc8oRDQ=
X-Gm-Gg: ASbGncstllbGPwUTJiOel5cXjhl6l/zShqDNe5qv1E0P5Y7DF1/egxY/IeqWsJTYzUz
 JWfvxCqwSN2n/775po61IOCZeEqjbyETqgogNTw==
X-Received: by 2002:adf:b30c:0:b0:38a:4b8b:1ba with SMTP id
 ffacd0b85a97d-38a4b8b01d1mr25459361f8f.14.1736265817311; 
 Tue, 07 Jan 2025 08:03:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERxQ6/ABSZdv5kOPinZ4nwpr4aJEp4gA0zNHvsvnSnq9SagQx0J4C6bnOL1FH5emPGLbpudobaqz19rhs/JhM=
X-Received: by 2002:adf:b30c:0:b0:38a:4b8b:1ba with SMTP id
 ffacd0b85a97d-38a4b8b01d1mr25459315f8f.14.1736265816855; Tue, 07 Jan 2025
 08:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
 <Z31OiMcYT/66AGDt@intel.com>
In-Reply-To: <Z31OiMcYT/66AGDt@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2025 17:03:23 +0100
Message-ID: <CABgObfZETbD03-H6=qOt6V8GY4ex3WP82i5axzdf_U0GCwsMbw@mail.gmail.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 7, 2025 at 4:37=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrote=
:
> > If anybody wants to do it as an exercise, I am happy to help, otherwise=
 I
> > can prepare a patch too.
>
> If possible and if no one else wants to practice, I would also like to
> give it a try (I'll add it to my list).

Hmm, thinking more about it, it does require a bit that is slightly
more complicated than I anticipated, which is a binding to
object_class_dynamic_cast(). I placed something completely untested
(except it compiles...) in rust-next. It uses a new trait
InterfaceType that can be used as

    ResettableClass::interface_init::<T, DeviceState>(dc);

but I don't really like the two parameters and also I don't like that
class_init is called differently for classes and interfaces. It's
probably possible to design a better API, but I didn't spend too much
time on it because it may require rethinking how classes are declared
(not a huge deal, as we have only four of them).

Feel free to give it a try, but it seems like a relatively low
priority item compared to upstreaming timers (i.e. HPET) and
MemoryRegionOps; or figuring out logging.

Paolo


