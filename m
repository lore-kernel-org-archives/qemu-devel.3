Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90DAC27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 12:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFYaL-0008HM-Il; Fri, 07 Jun 2024 08:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFYaK-0008GV-Bp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 08:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFYaI-0005jk-OK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717762841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPuCgXWTYCvtUTvd2JN9UMsbaVvwUfJec1BJ7ZfWBCI=;
 b=cAUeGGaFlUwi8/43C8NFHfojSlWPqhEMtU/msEwvGfwMwaRNe8QSYfVDxxm4WGFf+rMsSp
 AHxdxYPV7MwIy5IEFjK3oM76cg3NTIUhs8KGU6VLyEqGUdpDDXuw+DLYLIFtocB+hJ1kNk
 p2DFHnDkiCYPADepCwsZCc6Wsp8BA4E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-d_Y7XNuhO8e-cKvatOxSeQ-1; Fri, 07 Jun 2024 08:20:40 -0400
X-MC-Unique: d_Y7XNuhO8e-cKvatOxSeQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so49784066b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717762839; x=1718367639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPuCgXWTYCvtUTvd2JN9UMsbaVvwUfJec1BJ7ZfWBCI=;
 b=C31m7D68fhobW/+6KExG7hBTvso1HRNXHb2c+sjjVfNZSoeQbhiEv6Kl5fJylOROfk
 cTrEZiKe+mlqaFHuFWH5Nk4OJYuZqtw+GNAxha3jlUwcQwrKuXY13rAeT+cuaRvrHS8c
 iYZgG6qGKTrnMzuTbgo84vVDGeR9aTCe07gA7aosTad3ghRJt3lRKqT1tT1NLCvIwiMT
 rbgecfFYy+0wyuOxjrhd9wTK3SlEdT5yM3EqbH2UsQQtFlOFLPvLLPgLRfIdRXffjgKY
 oHvlIJqzOQqeuAX0D4GCJCHNuuDNvdTsiLDgR1TZg3fZzGjHu93fer+M6B40WpO1X0r7
 SsBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7OtTS45cKjlrA7XkD1j7A6vn71XE76IkMIpdSCoGdWbnCWM8KgGyrSEMKJAqtuhIOVRGv+cnyVV8gDEh8QG/xj4Yzsts=
X-Gm-Message-State: AOJu0YwrLs9dT7LB+4fT7jDmM6AEtFwT9ao47tx2NVJbJPyapNqARYt2
 naTFfuYMTsmCJR34pghSVYZN31qhtB0lw2GwVboE8yP3BU5k04eRQHh3KCVBeWnlxPSw0APJmxt
 bC3CKN/zRoSHjVjnrz7zs6HaEyAiHEXKfWzhAKDZgJ62rOpXAAiYTT38MmhL9I8i4rLxo30xuGH
 vBjLyMlHFUPJCViYJftROTg+dU7ew=
X-Received: by 2002:a17:906:a001:b0:a65:ec91:c965 with SMTP id
 a640c23a62f3a-a6cba4a1fa8mr212381466b.10.1717762839334; 
 Fri, 07 Jun 2024 05:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ntsWoujD6b5mc7TfjEAYQxOCQOxDhdim4boA1FTyJkF3TvCe2sG40+1p0r02rVzdnb1GQReXfrUo3b799WU=
X-Received: by 2002:a17:906:a001:b0:a65:ec91:c965 with SMTP id
 a640c23a62f3a-a6cba4a1fa8mr212380066b.10.1717762838943; Fri, 07 Jun 2024
 05:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240606104745.291330-1-zhenyzha@redhat.com>
 <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
 <20240606181338.00003336@Huawei.com>
 <6e67a59a-7ed6-46c1-b9ba-884800005c81@arm.com>
 <CAFEAcA8pWdMF8e_gpP288HUppx=ceAfUGz_GH16hXaSw-aie0A@mail.gmail.com>
In-Reply-To: <CAFEAcA8pWdMF8e_gpP288HUppx=ceAfUGz_GH16hXaSw-aie0A@mail.gmail.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Fri, 7 Jun 2024 20:20:02 +0800
Message-ID: <CAJFLiBKXwQvxE7Pcs2e5Rs5ZqKzJ6x00KkoJuNbCoFYucc=hqQ@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux
 guest on host with Fujitsu CPUs
To: Peter Maydell <peter.maydell@linaro.org>, robin.murphy@arm.com, 
 Jonathan.Cameron@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, gshan@redhat.com, 
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, 
 shahuang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 7, 2024 at 6:17=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 6 Jun 2024 at 22:18, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2024-06-06 6:13 pm, Jonathan Cameron wrote:
> > > On Thu, 6 Jun 2024 12:56:59 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > >> On Thu, 6 Jun 2024 at 11:48, Zhenyu Zhang <zhenyzha@redhat.com> wrot=
e:
> > >>> In Linux, a check is applied to every device which is exposed throu=
gh device-tree
> > >>> node. The warning message is raised when the device isn't DMA coher=
ent and the
> > >>> cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The c=
ache line is
> > >>> sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the gue=
st CPUs.
> > >>> The DMA coherent capability is claimed through 'dma-coherent' in th=
eir
> > >>> device-tree nodes.
> > >>
> > >> For QEMU emulated all our DMA is always coherent, so where we
> > >> have DMA-capable devices we should definitely tell the kernel
> > >> that that DMA is coherent.
> >
> > The trick for that is to put the "dma-coherent" property right in the
> > root of the DT so it plausibly communicates "the whole platform is
> > coherent", and is then inherited by all devices, even those which
> > shouldn't technically need it.
>
> Ah, cool -- that's a pretty small change and it makes sense, and
> avoids us having potential bugs in future where we forget to
> mark a really-does-do-DMA device as dma-coherent. I like that
> a lot better than adding incorrect dma-coherent tags to lots
> of device nodes that aren't for DMA-capable devices.
Hi Robin, Peter, and Jonathan,

Thanks for your suggestions, it helps me a lot!
I will submit a v2 patch that puts the "dma-coherent" property right
in the root of the DT so it plausibly communicates.
Yes, these discussions make sense.
I will modify and test it again on Fujitsu host.

Thanks again
Zhenyu

>
> thanks
> -- PMM
>


