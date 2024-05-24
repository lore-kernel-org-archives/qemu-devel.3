Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C151C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXWV-00010k-IK; Fri, 24 May 2024 12:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXWU-00010H-24
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXWS-0005QV-GD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZs06456MpZWCEfJBvTpJcfRIZ64fwVcyCyhJwXD55E=;
 b=E/ahelQlYX43AHdNpHfcQ6OZzvwSLYa7mUd2PvNvRRXCEPzczrRq8cAZCOhllwOCtQRtvC
 03DuIXSn0xrusWkNx6LzTOFUlHpglYkv/3MEQYWpXnBpAu4aClRtCB6ap2omoaX3gIOAIM
 bSYVnmJ18YboBCY26Oevu+c+GYOY5q4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ENb_JdRAPFi-mYUJ4669WQ-1; Fri, 24 May 2024 12:11:57 -0400
X-MC-Unique: ENb_JdRAPFi-mYUJ4669WQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4201248bcd4so2265945e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567116; x=1717171916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZs06456MpZWCEfJBvTpJcfRIZ64fwVcyCyhJwXD55E=;
 b=IbnxIVUfnf4CJaY0//PVleQQyOyKYlOIUJbaR/jy489GA1SWGnaZAReAshVT7OPRVI
 Zk4pnm/x7uUwHOyh0rPgvpItWei6V+VNIuoGTLCaI/Le0K6+W7qnj3/f8pN4EmQWFseo
 Nsy82CRsKJG0281kAIjGK2jmz+4LI40cukKS0MdTQhuyLC0KXRpJLCszT3/YnszvZR7B
 5rdKoGcrDSPN1obaaM+QulLT7XZYRSsBCMRBD/uWEUN/UHexWVJUZMWq6TyXt7ugTeql
 rLxOhnG8QFlULGyr7MmEvPGm35emHvxgRMCsvC4ce2xmq0UGfUlT19TBs2XqfZa5NyPl
 9jnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXesvejb6fuYXpW+4EYrcmGY6vcPu7QQ2jcFvTArIXJhDOIuFGGheLYUPJZkbov4G8CPhOMLwJN/dI3SrrNboLCTczsqSs=
X-Gm-Message-State: AOJu0YxCL2zBcGI+B9SZC+6p39iIRxp/CYgm8uZFraNS6HNqs1xowGtq
 w01k1hrGQmHus2SJp/PUtEAPbkpSbo7lkjw412gcnJTcjkvrjIMy2Bg1zahTuBLo2kmkKB5m7rd
 jgOI0RhNNlyDc0OB+eyximMIBzW5jueVDuT9atQgqEmISqvAzMyG7dCJm6P9d9Z8lWAO/n90kbL
 MCY0yB76f8k6G13DjsY7WTzgtYn6w=
X-Received: by 2002:a05:600c:1d9e:b0:41a:3868:d222 with SMTP id
 5b1f17b1804b1-42108994047mr20117595e9.0.1716567116091; 
 Fri, 24 May 2024 09:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU4nHinG5UwWYfIzzaP4TB6q5N8h7uK09ZIRPsfyGS+poyVFItA8joQq8EIDF7CBO3B42QpM4Casm7ZYe8n8s=
X-Received: by 2002:a05:600c:1d9e:b0:41a:3868:d222 with SMTP id
 5b1f17b1804b1-42108994047mr20117365e9.0.1716567115718; Fri, 24 May 2024
 09:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231221094923.7349-1-duchao@eswincomputing.com>
 <20231221094923.7349-2-duchao@eswincomputing.com>
 <ada42503-dab4-474f-a61a-a9fe3fa63afa@ventanamicro.com>
In-Reply-To: <ada42503-dab4-474f-a61a-a9fe3fa63afa@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 May 2024 18:11:43 +0200
Message-ID: <CABgObfYA3Er1y3R9v0Huf3w43n7oD83UhkqdRk-oBYzyM6O_ow@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] target/riscv/kvm: add software breakpoints support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org, 
 atishp@atishpatra.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 16, 2024 at 11:23=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> > +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoi=
nt *bp,
> > +                                  vaddr len)
> > +{
> > +    if (len !=3D 4 && len !=3D 2) {
> > +        return -EINVAL;
> > +    }
>
> I wonder if this verification should be moved to kvm_insert_breakpoint().=
 Is
> there any known reason why other archs would use 'len' other than 2 or 4?=
 The
> parent function can throw the EINVAL in this case. Otherwise all callers =
from
> all archs will need a similar EINVAL check.

I'm not sure how len is defined in the gdb protocol, but x86 has a
breakpoint length of 1 and an instruction length that can be any value
between 1 and 15.

Most architectures could assume that it's always one value, i.e. just
not care about checking len in kvm_arch_insert_sw_breakpoint.

The patches look good, feel free to take them through the RISC-V tree.

One thing that I was wondering is: could RISC-V just use always
c.ebreak if C instructions are supported, and ebreak if they're not?
But if for example that would that mess up the synchronization of the
disassembly in gdb, it's a good reason to add the len argument as you
did here.

Paolo


