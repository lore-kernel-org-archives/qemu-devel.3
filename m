Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A50CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEq2x-0006LR-F2; Fri, 31 Oct 2025 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEq2v-0006LI-Ko
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEq2q-00072v-5L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761920632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8NsndKxi9wjfiwiNCzQ0sDwvjij+/0YwRPZVMGXiAQ=;
 b=YAHqVDl+iZSv7GYhnlzNRSP0/byHBvTEPYtuhgCn4DKAtJxAWYYku9gO0uAPl20N1chnJl
 q/ftF13jk2e6L2QfbFqW2dQ4QdzmsQoLSoYbSdx6ctHBOwISewpr9v1QEP7CmY2auZAiWN
 qjVDqd2L5kV/MU8pNRIU8zOGiRfKWqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-EGo1fT6oPPGPz0WCD1bsog-1; Fri, 31 Oct 2025 10:23:51 -0400
X-MC-Unique: EGo1fT6oPPGPz0WCD1bsog-1
X-Mimecast-MFC-AGG-ID: EGo1fT6oPPGPz0WCD1bsog_1761920630
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475de0566adso18409755e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 07:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761920630; x=1762525430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8NsndKxi9wjfiwiNCzQ0sDwvjij+/0YwRPZVMGXiAQ=;
 b=ho6rniRTzOKdPC6QycY+UYof4odKaWJJI0RzH9A7LZKFgG0Lbyo4xfZKb4ozYfuTgL
 /uxbCFwF84fS3RolA5LaYTyQHmXB6UpAxuB5i239lYh6qau3les8kef3KX+sH4dkUxbJ
 PQbVSk4IcMPADQO2rrPzzRg9/x2d+h/66IRVknebOo6HlVqro9wvcGnUlgB5EYhNIxkU
 Sa83aFmPVCj5UwX36DOoGjVlEW2HZAgxqDeQSM6sdhFlGCZiWu1hOXEvzBRrydDAqM/j
 cLnmuDXybMpx1x+fV7AAGHPGim/shVnPiXiKJr6qYsHnmFT4S5RXH+JLzXRw5kue6X5l
 cioQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQzRHVF0eRUN5cN6jsZbfPJVJM2ZQoH3ILaC8l/WAVpzGYKI4XzWAXIcDNPHsKyWq3oBYAzWVFcmmi@nongnu.org
X-Gm-Message-State: AOJu0YzYuE3zDElbiGdqsB4Y/r11mbTXQHBKhA8539fnmxN8KEKGLpss
 Mr/ZxaCGQuKLFAVEFW9dm5pg+2Kk+IhXDTESAqA0ujZEE5HSKyKPhhgcpxj1/tbBxWlpWKuF2IM
 r3BEXmrrK0sTShqytPetNooyyamFCnH6GXLdKl6WrWvVqWrLav4mmmo6/aZpzTLgR
X-Gm-Gg: ASbGncstWuBsIz9Xad9BYmMv2OWL6fz5/Q+h/10dO4pi6caSUXjaTsRiL0kd/GCURSE
 taVuxZ32oMegMaJIqP9GPJdKuIBIzAUOwm3dSr29dt7sKSU7lLZ5P+/3oioA0Ea/yugg50FFjbq
 blGGabhj0uvlEWRXdCzFbAW8qR7mAJoGL/PwHH5FrUJZfxepj332ydimPRWJ+AE0XbY07hrgGdY
 b+bbeE8PjWSKOwIhMh122s/eoftyLrMp3xAERSQXQBY1uwiCrudN75QiLbrZ04yXMdcKsfhAfBX
 B+MCUj0qrRWr7Ph/z0kIDXbuGTZfkk4vl609s90cVWNf6bMbnon1GH9nz4JV2+dN2A==
X-Received: by 2002:a05:600c:c16a:b0:46f:b42e:e39e with SMTP id
 5b1f17b1804b1-477308c60aamr38306965e9.39.1761920629811; 
 Fri, 31 Oct 2025 07:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH73DZHEsR+mQzo+LpxpAHYqi6uaGXmBv0wFmteO6GGOwU3gZyA1bUah7DEckHfOtZkUbifcg==
X-Received: by 2002:a05:600c:c16a:b0:46f:b42e:e39e with SMTP id
 5b1f17b1804b1-477308c60aamr38306415e9.39.1761920629398; 
 Fri, 31 Oct 2025 07:23:49 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2ed409sm664775e9.2.2025.10.31.07.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 07:23:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:23:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, qemu-arm@nongnu.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Message-ID: <20251031152345.65b2caed@fedora>
In-Reply-To: <aQTEKyQjqIIGtyP0@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20251031113344.7cb11540@imammedo-mac>
 <0942717b-214f-4e08-9e2a-6b87ded991c9@linaro.org>
 <aQTEKyQjqIIGtyP0@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 31 Oct 2025 22:14:03 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Igor and Philippe,
>=20
> > On 31/10/25 11:33, Igor Mammedov wrote: =20
> > > On Thu,  8 May 2025 15:35:23 +0200
> > > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> > >=20
> > > Are you planning to resping it?
> > > (if yes, I can provide you with a fixed 2/27 patch that removes all l=
egacy cpu hp leftovers) =20
> >=20
> > Sorry, no, I already burned all the x86 credits I had for 2025 :S =20
>=20
> Don't say that, thanks for your efforts! :-)
>=20
> > Zhao kindly offered to help with respin :) =20
>=20
> I haven't forgotten about this. I also plan to help it move forward
> in the coming weeks.

in this case, I'll send reworked patch (not really tested)
as a reply 2/27 so you could incorporate it on respin.

=20
> Thanks,
> Zhao
>=20


