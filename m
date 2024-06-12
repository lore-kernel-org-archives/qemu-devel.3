Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F771C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMAp-0002S8-C7; Wed, 12 Jun 2024 07:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMAn-0002Rj-Qs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMAm-0007t0-1G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718191786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mSk0is/yOv/WbmvaHtHjmziyZSm3k7CLbkO6t73YaQ=;
 b=XduyHbtfK+IevoXxEOMmOsYQVq3a3yQt75jWZd1wcX3vR3fcAhnakTXqnhYy9OSOcp7i1y
 WiruwLQx0E5C/uM6sVlCj+EjLCck2u8SmgsrF9OYDCEO4iLYrRLjlXGN7VutBiGTnBDSYt
 +SRKW4abmPapBS7eeMJVhmP6wDli5Js=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-T00qbaQWNWOqsvPFlCeEpg-1; Wed, 12 Jun 2024 07:29:43 -0400
X-MC-Unique: T00qbaQWNWOqsvPFlCeEpg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c989652e6so777799e87.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718191782; x=1718796582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mSk0is/yOv/WbmvaHtHjmziyZSm3k7CLbkO6t73YaQ=;
 b=IlMohGKTDbIj8ccZaEp4x6TUGCfPN4d2WLAiVEDV9tOfrdka/EY7drr2EOtNHlGv3X
 3D3JvQwxLnrvQqrdbmpV8pEdCSDVXXYctq3qN3Jh2HdAVYDOjqvz4cImRNVjumE4rbFH
 f28H8g5wASRCFpZu3MjnR9Y36TjarGo17a7kVMZ5cbv55kOKUQgFBlUwNbMw579sUNcU
 SJyuqKamDEU7k3m6sExUSGliRt6c1lbFUJ2rQVi2LHiYLzeelnoLKgOGJvrYuDojvnrV
 eNwRcEIuSj03z2dTNWttBt/d9DlFSoxE5XOgrqnR/H+C4aJoSak3+zoCU4e6Pj0Sk5sz
 HSYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2oD6Crmfzqpdnf1Kb/V3nCbDqPiiADPJ+8jx8sckOLTmt3oICFs/EO50nToUesKiOT4EJFiCzCJh2pGw0tm/INUNRSs=
X-Gm-Message-State: AOJu0YxwSSPYn9/bTCyg0eKS1RSQj0gZpWPZzXHtnOzd86hDk78E7ngj
 ZDrLJXMtFKNzyaURcCmMUCYMKHPxaEl+MYpWgULYxW7lDVRWTyxxjwFFCxMJp0mtRiAQjy/uIlM
 JdvzbcTZrCIWxpUSNEb1LF3iq62nkuVj6oMYnpMlfHyzdjAb5+lv92bDNmDQAD4SNWcSoIYjGHB
 5R3VnwHha0upQIx2LuhSVRk12W9Uk=
X-Received: by 2002:a05:6512:3185:b0:52b:c2db:525a with SMTP id
 2adb3069b0e04-52c9a3fcdefmr1458733e87.42.1718191782270; 
 Wed, 12 Jun 2024 04:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVCfsYsc/GAGTZ/oK1mHXyt+T8FLBVDiQsoqA9J+BbTqOHiRImcmY9CYCxqUSg6s+5++rnp1atcOC2mfLy18E=
X-Received: by 2002:a05:6512:3185:b0:52b:c2db:525a with SMTP id
 2adb3069b0e04-52c9a3fcdefmr1458712e87.42.1718191781917; Wed, 12 Jun 2024
 04:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
In-Reply-To: <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 13:29:28 +0200
Message-ID: <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: Alexander Monakov <amonakov@ispras.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
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

On Wed, Jun 12, 2024 at 1:19=E2=80=AFPM Alexander Monakov <amonakov@ispras.=
ru> wrote:
> On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> > I didn't do this because of RHEL9, I did it because it's silly that
> > QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> > compute the x86 parity flag (and POPCNT was introduced at the same
> > time as SSE4.2).
>
> From looking at that POPCNT patch I understood that Qemu detects
> presence of POPCNT at runtime and will only use the fallback when
> POPCNT is unavailable. Did I misunderstand?

-mpopcnt allows GCC to generate the POPCNT instruction for helper
code. Right now we have code like this in
target/i386/tcg/cc_helper_template.h:

    pf =3D parity_table[(uint8_t)dst];

and it could be instead something like

#if defined __i386__ || defined __x86_64__ || defined __s390x__||
defined __riscv_zbb
static inline unsigned int compute_pf(uint8_t x)
{
    return __builtin_parity(x) * CC_P;
}
#else
extern const uint8_t parity_table[256];
static inline unsigned int compute_pf(uint8_t x)
{
    return parity_table[x];
}
#endif

The code generated for __builtin_parity, if you don't have it
available in hardware, is pretty bad.

Paolo


