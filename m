Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1790C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQKc-0001KL-VR; Thu, 13 Aug 2026 03:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQKV-0001K5-LK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuQKS-0008M1-Ut
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786607899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUyjJ6YjCKNxtDZ3GWFt1A1GkZXNovc9HPn/DGVTu+Q=;
 b=DN3PXJjKywuUD5u/hXndL5nF5WDesdxZkio5osEzFJKTYhrj8pjiQIbBEE6CINbUkMdTJ5
 sxCVLC2Rp4a5M+JAoFkpzxiVBRrAWv531JXTbKQJVn0bRi4y68b1RRrvF3OunjD9GAg+jB
 MckOnXVifWkqpWD8gcJifFj+J84gVZQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-qGA8gXmZP7OuhotWL9H5Bw-1; Thu, 13 Aug 2026 03:58:18 -0400
X-MC-Unique: qGA8gXmZP7OuhotWL9H5Bw-1
X-Mimecast-MFC-AGG-ID: qGA8gXmZP7OuhotWL9H5Bw_1786607897
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so636855a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 00:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786607897; cv=none;
 d=google.com; s=arc-20260327;
 b=Xxnve7nx8EgW1GKEgO1qTEWH63QaDONAhzNo4bq0/94yEiIlRFCL96f64/NzNDTYso
 +Ab3n6tHkegR5yTAMM7eRUGZNfw8GvAyh5nI8hqRaEkmlegoxdKVTL2B+d3Fj/9jrQoT
 nVT7PInHZ1zJMgA4llDIl+rnwWk/0OMNF6lIW3hQY4PzhGfccxhbAdgJ7tovvqNSiJQk
 nu0+QkzWuT8QuBYpBLVjmHmYDb/xWyEs8Ye7KFU9bKdao5jNFSYJCb1UaXPwSns6W2tX
 TAzi4fhLMBblrvGTPUCaE4vRsJa5MeoBZRhKryzpXGW5163hoj1PjqEwMaCCsbu+nRcs
 xH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eUyjJ6YjCKNxtDZ3GWFt1A1GkZXNovc9HPn/DGVTu+Q=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=gN8oHK7dg+ooM7TRtAPLBgH87V9IjIrnscUeDsGp8WRdyyfz1gIkzfBCQaPvEW4Lto
 sgFi6qPDtu7NiOhUT5HuaTWRHLcgVA/qVh64wyNf6fAPt0Jv7lK+MlvI4lU25ahPGWo/
 gvdIJF40ecJxLqG109y2PpXvk/0pcqga/h9XlRg9ntb8rZeHdgkrB+Jrv2V9W6zJY6Nz
 poQPnqy2zVS2Rf2gg8ziQnz5jSvXHrSPRdhUtnQBhX0O6cMFzikzZBW2quBhuN2FO1wl
 Sxtk58j6cjyCaNn60xSqcPaCQdoETx1QFnQtvOHzFttIkBW3nATq2POtWgR5OUWIov+O
 GDTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786607897; x=1787212697; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eUyjJ6YjCKNxtDZ3GWFt1A1GkZXNovc9HPn/DGVTu+Q=;
 b=PUAm628ktOd+HTrOn47wNtJbg9k8qtPgjjqAcB8iknrcC4QW6zMgTxDpyYgceGYQsq
 aF+9Sa9/C/A37nI2c1mNSywx3zOktYlRYfKlFezkV6jmQdfKwgGV4iRmy2cWX1qlRsWd
 qEo3ZA/zozfXIRZluLMsLLDjiGsUR4wUaXQsp2fZwPKtSUncv2sdxD/zrzFwWOEJzJku
 86IXuFLTcdxnOuRxyLnJfUyGrqwDPRrxvES4Zoa70z3Uq4Ws1ybDtLrdYyWyZ6b4vrrO
 JYHIMtdUuYjgiWtVO4jPeSjpoKv9htaPCkumc+JtTWciH8GrPKJfd6QMNkuf4Mh5HVjn
 ow4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607897; x=1787212697;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eUyjJ6YjCKNxtDZ3GWFt1A1GkZXNovc9HPn/DGVTu+Q=;
 b=dicnw3pX4qo9wm5/kTOh9VJffeYzAuu5DJ2SNM+Y2kYfPQwizCEftirviGQi9ypUhR
 AymJQWqh9j+tcili1DArzCvr9jr1GPyL6XctA30QP49faXl6Coi5g2xh9u4YHcw1NDa9
 WDAFkGpAfc1glIzF7V/X4TrK46oKTVcwqXT0YX5TlPJvFKF/39C17lmvuiCmyJrB+tfx
 hf3m9ujc2eKkx8Ulpe7GouWUDyiybBDWIdnL5Df5fCaV6r/Q1CWa6v1/ZFb6ccMhN7sK
 NpGZNJZ8o2TEzLC+JUUKXgC39cnFAQCLPeOtwiuKbK4eqNi42Gu7L4LoLTW4HGoc3j7o
 4iWg==
X-Gm-Message-State: AOJu0YzcfLkNnzp1kefWu7vi0dxKomTKo6N9Bw0TVeDEW57zgbs0cWqv
 gdGUsilEP2DyjurGE8Gb73qd7aZ+eXEj74HMwus17h/nkOWYWF1C4zveL7Ote8/swEuAvtIeRuR
 pDZTADppsEm9864jql4HVuV/e3kCILGVZo0WGcAU6ianuyxHn2Mx2ADul/v/rVofxQHSa0/Ys52
 hi/cqLIsRFHSWg3cJxBhSPfUkOtMQl1Xw=
X-Gm-Gg: AR+sD137WBwMQnmnDDJr89clK23nch1o2l3H1mvAx+PeKuJz7BGeQKwhNLut0KRDdHH
 qAj5ocjzALeMe4LCMOr2ZCkGcKTMPMrflzry+OAaicus69C2EBmQI9/EJnx9JArIJfyThILWORP
 3/5eO4qyegfMY7mMboH7VZrwSVEDXwKrt/WVgICfpP27petWmiijV+CMyDXpFbB4cGWcBwrVbfP
 ArGBikm3sEwbEf+CCwFK94k2c7sRCvkaToJLzowUPp96T2Y+Am72XVw97DlVE9v2sbdqlT4k11K
 fg==
X-Received: by 2002:a05:6a20:c6c1:b0:3c3:ac5d:b6de with SMTP id
 adf61e73a8af0-3cc553180d4mr5979546637.22.1786607897279; 
 Thu, 13 Aug 2026 00:58:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:c6c1:b0:3c3:ac5d:b6de with SMTP id
 adf61e73a8af0-3cc553180d4mr5979501637.22.1786607896888; Thu, 13 Aug 2026
 00:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-7-cc9396b9c18c@redhat.com> <87se4qqoiv.fsf@pond.sub.org>
In-Reply-To: <87se4qqoiv.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 11:58:04 +0400
X-Gm-Features: AUfX_mxxTJETVY9N_Oe4NkcU7NUvhm8ZMpB_dq4g3mJWgx8QJX0lfrm4MkY1UVs
Message-ID: <CAMxuvayWNZj5euBZXppptppq4wWdpuus5AbtYkhDd684_RCfCw@mail.gmail.com>
Subject: Re: [PATCH v2 07/53] qom: add qapi_type field to ObjectProperty
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Fri, Aug 7, 2026 at 1:16=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for legacy
> > properties, set by new QAPI-aware registration wrappers.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> "Legacy properties" is mildly confusing if you've been around long
> enough.  They're gone since commit a61383f7ab (qdev: Legacy properties
> are now unused internally, drop, 2025-10-22).  I'd avoid the term.
>
> I believe the new pointer is always null for now.  It will be non-null
> for properties created in new, QAPI-aware ways.
>
> What about something like
>
>   Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for now,
>   but future patches will add means to make it non-null. The
>   QAPITypeInfo will then be used by QOM introspection to tie the
>   property to a QAPI type.

adjusted, thanks


