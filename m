Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F48BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYpf-0000zV-JL; Wed, 10 Jul 2024 11:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRYpe-0000y8-8X
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRYpc-0004RK-J3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720623725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKQSs8FWr7Zn5l+H828xnzTIT8nIZAPC2TEWmBUKCkQ=;
 b=aUz3KWWR+qJw2EouE4DGmMR0VsU5v+IakFpIWaehdWQ5FaMxi9hFT3BPBfAQaECEgFqtnR
 AHH3NrZClcYr4K2CW5xzysnDTexnnuVwXfXcBTJGSSriJSoOp5JJZjC0IOty98WXrLecPy
 jXhSz3PIrU+O2dZGTWv2i/CZ5a2GUZ4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-HrJ6cgBlM42jLKRghP8DJA-1; Wed, 10 Jul 2024 11:02:03 -0400
X-MC-Unique: HrJ6cgBlM42jLKRghP8DJA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79f1b638b6bso4632485a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720623723; x=1721228523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKQSs8FWr7Zn5l+H828xnzTIT8nIZAPC2TEWmBUKCkQ=;
 b=nteRyh+KHifIe12EzebyXOqU0H3h1mgtWybGwx2odqwFx+EP4V1FXYJgy2Nv3N2cLk
 8ZbGFWxpYcHCnRtAk5EAucDrrwm2CqD3V2NqrHzERLJuT1CmzGF+fWW2zlz6dX+oPxjK
 hLjn89iCPMTOblMEH1ulmoptZQrteMV0C7oRb6UJCI1x7rYcgOT/LGkEd6WhUeST6Owr
 yl6A7Z87Q6srhCMxlJ0t9s+jQPNHHl7u16AkGEDCdWrVEbAyrwX7uoi2nlEskWMTdMwX
 5y0cw+tTe4DNMzqwGMGKniy64QMa7r90+DmyQIqPDacmy3nF3nCOCx8MwURVZ4Cs2vmu
 oMFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+KOtprLgLOAo7lfDFtvvRO1dBMCRlGwibiHXiDMU06yKD+nu+bIh3J9p3pRm2LXHGI3EpBrpl/0zlbZxMZJm9VvOqtJw=
X-Gm-Message-State: AOJu0YzJZGLQFG/cKGjMjvrdJTsik5Yozr4aYiQwetKSjpC8J4K+QfIm
 zmC3v/ilbSU51giExAbEn3i9/sV4WIM8h+7yoWllGLByY8MR8z1kQIHk/KfBHRQBB1/lknYwM1M
 42qASSmvh35E/GDOhpNkxHkHZCCRke2S9/G3wQD/8LCPbgY074C5j
X-Received: by 2002:a05:620a:1a94:b0:79f:b3c:8fc3 with SMTP id
 af79cd13be357-79f19bee0d0mr649671285a.6.1720623723061; 
 Wed, 10 Jul 2024 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSzhl0Khbx3PFBWwojh+YkQYtRW+LPaY9KzNilVVBCoiCKCtaRDbKW3+kR1MyemMVyU08VDA==
X-Received: by 2002:a05:620a:1a94:b0:79f:b3c:8fc3 with SMTP id
 af79cd13be357-79f19bee0d0mr649666885a.6.1720623722685; 
 Wed, 10 Jul 2024 08:02:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190103e1sm202838085a.42.2024.07.10.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 08:02:01 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:01:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, devel@lists.libvirt.org,
 Luc Michel <luc.michel@amd.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <Zo6iZjc8YpI1_9dW@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5ipfigb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 11:08:20AM -0300, Fabiano Rosas wrote:
> >> I think it's ok:
> >> 
> >> {
> >>   "field": "unused",
> >>   "version_id": 1,
> >>   "field_exists": false,
> >>   "size": 512
> >> },
> >> 
> >> vs.
> >> 
> >> {
> >>   "field": "vendor_data",
> >>   "version_id": 0,
> >>   "field_exists": false,
> >>   "num": 512,
> >>   "size": 1
> >> },
> >> 
> >> The unused field was introduced in 2016 so there's no chance of
> >> migrating a QEMU that old to/from 9.1.
> >
> > What happens if an old qemu 9.0 sends rubbish here to a new QEMU, while the
> > new QEMU would consider it meaningful data?
> 
> It will send zeros, no? The code will have to cope with that. The
> alternative is to put the vendor_data in a subsection and the code will
> also have to cope with the lack of data when the old QEMU doesn't send
> it.

Ah indeed, that "static const uint8_t buf[1024]" is there at least since
2017.  So yes, probably always sending zeros.

Nothing I can think of otherwise indeed, if we want to trust that nothing
will migrate before 2016.  It's just that we may want to know how that
"2016" is justified to be safe if we would like to allow that in the
future.

One thing _could_ be that "rule of thumb" is we plan to obsolete machines
with 6 years, so anything "UNUSED" older than 6 years can be over-written?

-- 
Peter Xu


