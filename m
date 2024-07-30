Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05913C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYg0X-00012g-6C; Tue, 30 Jul 2024 02:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYg0T-000101-KD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYg0R-0006Mi-Tb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722319601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HywbmjddgtngYN0oVDkoOoCPU/ETmtW6kyDDQ/H0O+s=;
 b=HUhIKXLtpCRuAYkfekYxRfx+yFNlXKOd4Z0HoU6u/nCG6APVOK1mtiqdtBOATnZereGHMf
 cu1iyUmqhbkPB0HKBcSiFYLhmbT4jH/9h+KO0ZwHuKAVHbJa35lojNY+K+P/nIo48gmXbx
 cXCBnwqv1Gwy8aFBpXyM5SYjYysJiFw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-m5w0q3oJOfCJp1GZujN6Fw-1; Tue, 30 Jul 2024 02:06:39 -0400
X-MC-Unique: m5w0q3oJOfCJp1GZujN6Fw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-368374dc565so1840485f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722319598; x=1722924398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HywbmjddgtngYN0oVDkoOoCPU/ETmtW6kyDDQ/H0O+s=;
 b=QKmZmF9ChDKqdC+UCIB9P7zpeWpV87aKwNfn+MuKwVs10xkfsDPEdDy/nF6JiBEFOS
 wvcBoslPo1o4ANM8mg461+H4y2zjdDn7lPRuwdSk34pwo2AwcU5P1in/Q6Uh1I4/MKQl
 EtwUxldK71VdEkQq+pX1p7OJ3C9VFqxdEKzYPn0Ik4KOyvqpaTyNKnqCPQ09M9EPZsBl
 olQhP60FV6VCijAXL/uwiTkapR+mA25gQmkRbd+c0MTN3xdpDLOxAeFYm05pZaZQrEvs
 GSn8bJJ4sGqXS1zYdo9OEtdF8hWm6LBAPkNEHtWl4O5aFV8P0sXwdctKscNbqZ6kbHJ4
 l+jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV71TEQIUDimguy3O3WLLDx65zr9Vm0URAVent0GpeOLFyIIjRdH5aaO+U4jbRfS3sQBsFJq8qwQWqjWAug0qeQOY2DEtk=
X-Gm-Message-State: AOJu0Yz0edncbbmb+GPhF5meDUOAqqPHZ9L2eeVc1/GKA1QiuXwKsPnn
 +41GDO+Db24RMxgNtV90OonJz8QkwoxwfWr1vrWcgfkmuWKOH0NVBbtC7fE6/Dp95tk+wASfCXi
 TqB85er3jiDmMumTU02PmooGyZVpbOAzAvoYjZ9qak12xvGOsxf9D+8yfQUOZzmtB5J6WxVRHs/
 qFBnNYZX1i9y1K6zfWMKgCCH0EQK8=
X-Received: by 2002:a05:6000:18a1:b0:35f:2030:d42c with SMTP id
 ffacd0b85a97d-36b5cef9021mr7389840f8f.17.1722319598212; 
 Mon, 29 Jul 2024 23:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLPZalJrLTyeos66N1u6nC9rbJ1iTUCM3oHCr2Ju6+bVTGc6LlU1WPtZXbHzlEsPoUGxHlcQIyhnwcgtDQ+a0=
X-Received: by 2002:a05:6000:18a1:b0:35f:2030:d42c with SMTP id
 ffacd0b85a97d-36b5cef9021mr7389826f8f.17.1722319597862; Mon, 29 Jul 2024
 23:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240729094702.50282-1-kwolf@redhat.com>
 <20240729094702.50282-5-kwolf@redhat.com>
 <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
 <ZqeI8TiHg8caawXr@redhat.com>
 <CABgObfbecac_70Pt4DWKPRm96VCOOCjGOCSB3TkkK490FmvPsg@mail.gmail.com>
 <ZqfJcz6GTsWglrQ5@redhat.com>
In-Reply-To: <ZqfJcz6GTsWglrQ5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Jul 2024 08:06:26 +0200
Message-ID: <CABgObfa=QX6siAnhy-C1jQ0imRxcfxXnJuTPHLZiw_5zeh7Z3g@mail.gmail.com>
Subject: Re: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
To: Kevin Wolf <kwolf@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Fam Zheng <fam@euphon.net>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 29, 2024 at 6:55=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> Ok, so modifying the commit message and removing the 'error'
> initialisation it is. Maybe mention the cluster validation case in the
> comment here to explain why we do this even for non-pr-manager cases,
> but not as a FIXME or TODO because it's not a problem with the
> implementation, but we don't have any other choice. Right?

Yep, go ahead and do it.

Paolo

> Should I send a v2 for this or is it okay to do this only while applying
> the patch?
>
> Kevin
>


