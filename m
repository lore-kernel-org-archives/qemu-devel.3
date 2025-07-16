Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19500C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4Ew-00071o-Tq; Wed, 16 Jul 2025 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc4Ev-0006y2-10
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc4Er-0006ZA-Ie
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752680408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dBjNd/CndD3uek6iJxfxOkcWv1Hs6oT3s4BW+vOB/U=;
 b=QwgYR4ADdnk8CROkwnEXERDTbb0+S6RxOwxn2hXnEc8ExHWdUEf6FTquivViV+6rReUZDG
 3hWf6AK/8gGwAmC5x6Zg1k6EU58dbkBjwdR7C2QO/xi6G3WQb4NxMp4joXz4IZeCNrBQlr
 d5KOYzVesXl1jmauQhaXGmUdrwnPEmc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-KooFVH6LNmedILmTY7xbYA-1; Wed, 16 Jul 2025 11:40:06 -0400
X-MC-Unique: KooFVH6LNmedILmTY7xbYA-1
X-Mimecast-MFC-AGG-ID: KooFVH6LNmedILmTY7xbYA_1752680405
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so4103821f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 08:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752680404; x=1753285204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dBjNd/CndD3uek6iJxfxOkcWv1Hs6oT3s4BW+vOB/U=;
 b=sEydCTQdmglOsrhHgDT9auj+ZHtdUsnjAtz9X2cotqrnXlR1Qs3KoHq9lAjAWdKqKQ
 cF34Ygzugvu6hUdjBh1mWa2Haz0zrKPHdB0UYUAFZjZDknSvCXX4A11jpiQurNvXgUAt
 6mFSN1MfTFqYWy4Wv1NGgXJHF8gIMSIgepuiNLjWMcGSueyba89nj27i13S/y6Uks2Z6
 pFeswxcrXCd4cULXSHf+nwMhSszyMGpzwHCSFyALqbnRxEC8VvPIYQVt/4vBlPNAjCkY
 bUOCBY2ALMYk45VQbNTDXBOF6AdCd+brLP68V5GesrNDp2tzyQ8j2n9fUPBxjxpnBQai
 5ycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUFNhm6f3wqgpt8I8lQ0OHTDdE7DfrcnOpfGDq8ySetgcZgUR3evVxhiOl9Ar6JsVxNvA5Kq4sVc7a@nongnu.org
X-Gm-Message-State: AOJu0YzhW35PaVhyScO5MRg28pNvvjCuPJCP9qT1tWovpW6LySk1ex/9
 q7IvqqHNZlyqtGVY14ECRsMVBolb3QzPmTe6LRTRve4MtMiLPxu87JTKKN/QuCAOun079ma4joL
 xL2RUNNL5XOhFi9BleSGXXbVNkk+l0pEs6lDa/tAN4LsLJ1rPH++cTvUc6D9PttqqoOuS6xoyee
 7LsqBp1UhAzHM+lTn+S/f1+2Xt+CN2V9U=
X-Gm-Gg: ASbGncuajpvg5z4mrml4IF1lb+Qa8+nw/fAHB53N9M3wxmOyyoMbNjaBtYi64EXWqqa
 G/YUWhiXOoCGE7edbzZMsFYKwEDXhBihEysT3jT5OFqXnFoSdefMkpi9JQY2iSJJ3NhujdO8l3P
 lkQrVL1CjVx635zbokw3Kt
X-Received: by 2002:a05:6000:1a85:b0:3a4:f744:e00e with SMTP id
 ffacd0b85a97d-3b60e4be7aemr2660414f8f.4.1752680404524; 
 Wed, 16 Jul 2025 08:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9g4bIIr3TBNe/8NBSeKHoEcaBnpgwtOtIPJF7SaZV0/aK9xoHOcy8hJw4ZNodtGKXXd5HT8+P8UCnx9Ma8H0=
X-Received: by 2002:a05:6000:1a85:b0:3a4:f744:e00e with SMTP id
 ffacd0b85a97d-3b60e4be7aemr2660391f8f.4.1752680404169; Wed, 16 Jul 2025
 08:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
 <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
In-Reply-To: <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Jul 2025 17:39:51 +0200
X-Gm-Features: Ac12FXx6sp_8fhVBKDf6Q745NHydRuwpWbqyXLGetJmtD7I-mOhvA_KLYTaGaoc
Message-ID: <CABgObfbV-V9JC=qAw4UL4pYWv-qcaPCpjSKwP5yohqbFGSnbkQ@mail.gmail.com>
Subject: Re: boot failure on top of current git
To: Paolo Abeni <pabeni@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jul 16, 2025 at 5:26=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On 7/16/25 5:22 PM, Paolo Bonzini wrote:
> > On 7/16/25 16:44, Paolo Abeni wrote:
> >> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree =
at
> >> commit c079d3a31e.
> >
> > No and I cannot reproduce it.
> >
> > What host is it (processor) and kernel version?
>
> Host CPU is AMD EPYC 7302 16-Core Processor, the running hypervisor
> kernel is ~current net-next (v6.16.0-rc5 + plus net-next new features
> for 6.17)

Hmm I have AMD EPYC 7313. I have a 6.15.4 kernel but I will check the
one you gave in the other message. Can you check if

  ./qemu-system-x86_64 -cpu host -accel kvm -smp 4

is enough to reproduce or a real guest is needed?

Paolo


