Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B0EE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhTz-0003Ai-IB; Mon, 09 Dec 2024 12:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKhTx-00037H-8g
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKhTu-0005j8-GI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733765016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caAng7NHpW+PkvK+ZofNHywG/NMaDtJZnzwvTdJObfo=;
 b=HB/XZQRaX7L+BVOJavhkXhssxHD9j1Y2iDGm5GBzSqrLV50uMk57S0bEkfeAXW2e9KKH8x
 EJsEsm00YgD5XIfuSn6VeHsEsazCsosaFNqsZyj+3p6ORiMBQ8dovzsa9Ap0v9J35lmW6m
 3HiynSUSPMewgIcAB71oRJi1gXh1sKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-EyLkHoG7PcehEP7d2_7bOg-1; Mon, 09 Dec 2024 12:23:34 -0500
X-MC-Unique: EyLkHoG7PcehEP7d2_7bOg-1
X-Mimecast-MFC-AGG-ID: EyLkHoG7PcehEP7d2_7bOg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so1821012f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 09:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733765013; x=1734369813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caAng7NHpW+PkvK+ZofNHywG/NMaDtJZnzwvTdJObfo=;
 b=Kmsuw5n8UeCwLz+eLHGlJMF6SNe1vFOsnTLaiulztev4zTIiYtvkY/oVBijLNjafLO
 q34JUr7ftAU6J/5BBcXg4r5wjhp3sJrHMq3uQ+MQT9AxckYsSAjI2Ofuh8R3NkDeg/pT
 SGcV7ELobWN+gF9FqNa7M3Ub2Vn0pQgJZx7G3e+7vZCuB99w0CcpisNwW8bBhdrXo2lk
 DkTVmyL5rFJLxqt3cV1Q5fUf/fRx4s3fA9rwmk7BFvH625cTZOJffu1PeFx6+Eib0cxY
 m/khCySjBF4iMHRG3+1KTiP6TPm+QfVXoSXtwotVh3m42BudBBadOQlwIJQx9WpPwAW4
 i8Bw==
X-Gm-Message-State: AOJu0Yw7OTghoI+URotmw6rBmiAst9shmk1yyyt5DJ5SO0+d1sbgRFj4
 Sx3/GWqpPa1Av35Ed29qiUrFbY3Z8EZgDdfrsmVx8r8uh3yLdBwU1kRQzBtYNRCL3+MB9fTRrZb
 BNUYNbBfT9ymoDBiw6+7fPgH8Jm55DSM0FNyhhuUgp4t/NvfzDI7TWz6S290pLbguh28nHNbO1a
 05Y7qD7Mj1r7ssqd1cE/z5duptKQE=
X-Gm-Gg: ASbGncvXLJ2tjLc5V/+qL7otNiB8bHfPARHjPBZspnSHoR6BihGMW8keNfoATYnlOtz
 lGzw/kaB2GVo4lORUDAyjlaJ9MgvWuHA=
X-Received: by 2002:a05:6000:2b05:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-386453dfdc6mr846067f8f.29.1733765013634; 
 Mon, 09 Dec 2024 09:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv77aktlF1XvHeKZBzLPRlKA2wJFWhx/zBVdL5CyDDIYohIK/8vEVDVfPK33//ePeYjHZ2sszdlI3pfGujFkk=
X-Received: by 2002:a05:6000:2b05:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-386453dfdc6mr846057f8f.29.1733765013333; Mon, 09 Dec 2024
 09:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <f85a2be4-f2ad-4c00-aecf-c045b7cd2e1f@linaro.org>
In-Reply-To: <f85a2be4-f2ad-4c00-aecf-c045b7cd2e1f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Dec 2024 18:23:21 +0100
Message-ID: <CABgObfaT7cSDpuUzZ-imuhdBnsg86Qi7mt7KZ+-V-SU60+TXkg@mail.gmail.com>
Subject: Re: [PATCH 00/26] rust: bundle of prerequisites for HPET
 implementation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Junjie Mao <junjie.mao@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 9, 2024 at 5:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 9/12/24 13:36, Paolo Bonzini wrote:
>
> > Paolo Bonzini (26):
> >    bql: check that the BQL is not dropped within marked sections
> >    rust: cell: add BQL-enforcing Cell variant
> >    rust: cell: add BQL-enforcing RefCell variant
> >    rust: define prelude
> >    rust: add bindings for interrupt sources
> >    rust: add a bit operation module
> >    rust: qom: add default definitions for ObjectImpl
> >    rust: qom: rename Class trait to ClassInitImpl
> >    rust: qom: convert type_info! macro to an associated const
> >    rust: qom: move ClassInitImpl to the instance side
> >    rust: qdev: move device_class_init! body to generic function,
> >      ClassInitImpl implementation to macro
> >    rust: qdev: move bridge for realize and reset functions out of pl011
> >    rust: qom: automatically use Drop trait to implement instance_finali=
ze
> >    rust: qom: move bridge for TypeInfo functions out of pl011
> >    rust: qom: split ObjectType from ObjectImpl trait
> >    rust: qom: change the parent type to an associated type
> >    rust: qom: put class_init together from multiple ClassInitImpl<>
> >    rust: qom: add possibility of overriding unparent
> >    rust: rename qemu-api modules to follow C code a bit more
> >    rust: re-export C types from qemu-api submodules
> >    rust: tests: allow writing more than one test
> >    rust: qom: add casting functionality
> >    rust: qom: add initial subset of methods on Object
> >    rust: qom: move device_id to PL011 class side
> >    rust: qemu-api: add a module to wrap functions and zero-sized closur=
es
> >    rust: callbacks: allow passing optional callbacks as ()
>
> Am I correct some patches are from Zhao Liu and got the
> authorship inadvertently removed?

Just one, which is co-authored; it has

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

So I should have put either Co-authored-by him or left him as the
primary author.

Paolo


