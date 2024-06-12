Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE5DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPus-0007fL-4h; Wed, 12 Jun 2024 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHPuq-0007er-Nw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHPuo-0003OH-VX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718206173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83AuWKs8CK3QhCp7J+sW1I5vZCPrUchZQE6BW36tB8A=;
 b=SkBqnesLx1BwiE2aG8tMVKcKBT1DK1WtSLF7/hkHTKl5AXj0pgTRdh4KCZP7YK0aSdlgWx
 Wh8cUm0EGfWpoKjPCLK6XTU4l3ZPIF7x4HGQdnkeSIDdhfTnPFFElNHMgbZdlW9u1ohnv2
 M1pR8CnkqSQID4lk+0Q+JbOtYfEy+QU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-gwGtIHZJPXicpeZvGFIjxA-1; Wed, 12 Jun 2024 11:29:31 -0400
X-MC-Unique: gwGtIHZJPXicpeZvGFIjxA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35f10585251so2341f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206170; x=1718810970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83AuWKs8CK3QhCp7J+sW1I5vZCPrUchZQE6BW36tB8A=;
 b=ATneiSBbt4f3Pj16ljExzRyy4tO9XYK6enNt5tDQ4ofLviSFJP4F5oe9QiHtC9chvp
 HJc97rGWnD3NFW8PUAAOInSNlzRpHUCL4EWOFD+f0nx6kxbIaV6w5vDFTFgLNn8B+6C6
 +Bx0yYAKXpo8tMbPiBHU+wpf881lAkeFOCyg01QE7WIrb4w1NzLLmZu9bfvvXQnkzkBO
 Fv7lO1KPBXZ/kjyiRx4l7pqNf6PSOslyNUFZa3COCfMW4l5/ACG/kFnwcQelZAzC5TcY
 X5eTTF8DCDJTLXpo9LGRhhqzDPVOZdPibfX5ZnxEI2D1+9yPUPqLoc3Bxj1HpKzHWV+c
 gV5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVRcZwhHzd5EcjtRHAXlbnBkIYIV2UJQ4chLREiXIQsV7GlqH7b8cTBnLg5gOx5TGi5Y8z9jtXyaY0eO/DT5EN+7/uRnI=
X-Gm-Message-State: AOJu0YyTKTPZRn9v+GP2Bay2JAINqfFEPfdM4y/lDTwJq+w76KgtiBgW
 UIQkE/Ug8Ea/5DPsozedcOSo0NppWXY8buncpqWNO4B0oIffJotU2OiSWBO2clgPtvwVM1RjGhY
 +Nef1z5E7zlepVuNnOsuHI34WKusm3frHOmg4JUfyky/TQ5TYOfyfIS9ANG6PC1mjKXb0yAWPnD
 v6HjjKU1LVhfRVNG3/dIqtb6n7g8c=
X-Received: by 2002:adf:e70f:0:b0:35f:2635:5b82 with SMTP id
 ffacd0b85a97d-35fe8937a66mr1666727f8f.59.1718206170724; 
 Wed, 12 Jun 2024 08:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7JOkIAnueBratc4CfQpfaKzumxk9xy8e35FEQp+k6sJhPaiQBH1HN+gwyCSih/c1ilBbirGjhcRRkecLfRA8=
X-Received: by 2002:adf:e70f:0:b0:35f:2635:5b82 with SMTP id
 ffacd0b85a97d-35fe8937a66mr1666715f8f.59.1718206170375; Wed, 12 Jun 2024
 08:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
 <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
 <ZmmSxq7i_tpYj7tw@redhat.com> <Zmm6Kf8PEwZ47bMb@redhat.com>
In-Reply-To: <Zmm6Kf8PEwZ47bMb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 17:29:19 +0200
Message-ID: <CABgObfbkbE_LKD-x3JkM39N10ZqNPU=FCO_9_iTvrbckqst2ng@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 5:09=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> This might suggest we could put a runtime feature check in main(),
> print a warning and then exit(1), however, QEMU has alot of code
> that is triggered from ELF constructors. If we're building the
> entire of QEMU codebase with extra features enabled, I worry that
> the constructors could potentially cause a illegal instruction
> crash before main() runs ?

And I learnt that one can simply add -mneeded to the compiler command
line to achieve that, at least on glibc systems:

$ gcc f.c -mneeded -mpopcnt
$ qemu-x86_64 -cpu core2duo ./a.out
./a.out: CPU ISA level is lower than required
$ qemu-x86_64 ./a.out
1234

$ gcc f.c -mneeded
$ qemu-x86_64 -cpu core2duo ./a.out
1234

Using "readelf -n" on the executable unveils the magic:

Displaying notes found in: .note.gnu.property
  Owner                Data size     Description
  GNU                  0x00000030    NT_GNU_PROPERTY_TYPE_0
      Properties: x86 ISA needed: x86-64-baseline, x86-64-v2
    x86 feature used: x86
    x86 ISA used:

I'm actually amazed. :)

Paolo


