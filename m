Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD3FCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMksL-0006Hm-Hw; Tue, 12 May 2026 07:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMks8-0006CW-T9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wMks4-0003Xw-CW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778583709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmHPuEn/7Gry1RvBW/FMQh8n+qcPkS49sE/ehIWO008=;
 b=Rg8cZbhmvXJXom/LceJ9Ix2gVUSkVHqoPRt1wgq2SHSwGD8nJcpkQAM/Q63WEmbGHfXkY3
 jd3EXQjeMn9+6DdwHYjTWRcbkECamCI8cDy/a0J3EuAXGJib6pveJYuMPWd91uzYGEqaeT
 2rSAoEZ9uMkmeQPnz6yukYT3QdYX/Wk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-QOXWXyWeN5OqfwhTtFZeow-1; Tue, 12 May 2026 07:01:47 -0400
X-MC-Unique: QOXWXyWeN5OqfwhTtFZeow-1
X-Mimecast-MFC-AGG-ID: QOXWXyWeN5OqfwhTtFZeow_1778583707
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-83536dc3be5so5724996b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778583706; cv=none;
 d=google.com; s=arc-20240605;
 b=EwlAiXRtmToEtmRFPz9XikWbmrOfaEN9aHGyrgQTuX5QF/IR3ws+qFrox8Yh7s3nCR
 cFt/JlW5/KF5wNk2YlW6Qt1UD6EGwJtwp2qQqwpjsXS4TtV88aio1PMJF1nrMJfaUwIf
 Xl5vfnvVwh8YUq3waaWtbL0RmHv0h376ccFL6QCYhUUfDLmIho5h8CZbxIGetUOpH1KI
 jf1k/xCgZo/XdcYEcpG+fuEFEbVuDZ6w4FYhiU6XacKCUnTo8y0V0/fEbxOA4QI5jrQy
 UxF2pPRiEuIJ9e7mlCmCEwQbbjnAy+ljet2ob0g3qD3T0AQ9bk/ANfykhBcbCMR2y2F5
 cnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GmHPuEn/7Gry1RvBW/FMQh8n+qcPkS49sE/ehIWO008=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=CmZkCt74Ainz+Ozr6ndRz0PTdBAEOl/ajpcL0dQRQG9tt2TAjUJNXActUnAMsf3PIO
 wy57czb6XKQIgZ7hpbLUXA2pwAhd9pKq1eArUXDw9p7gQK5ixt+aMrTl9p4wAY9cnC9E
 ezkIS8sVjVpPBGvfzKJYc7zbHFyU+5wKhB3U0pHX6GoUVNGOxs2b5tW1GP6xtcIa6AYE
 +UVR/LSNo93rmhFrCYPJ20YFrMZXB8wymefobJB6KL9kKOy+Q/7jPVj+ICifMqOX+a52
 6zVlXFHIUDRPkz1zKnTo2YiYTLgX9yNv3ZUMWCCajIHUF5GOsLo4nkhIxa1L9/oznUPv
 0W8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778583706; x=1779188506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmHPuEn/7Gry1RvBW/FMQh8n+qcPkS49sE/ehIWO008=;
 b=aLgFblNlI+alibC3DKtTLxp4/Y2voA87XpPTBufg87UOFA9yYOQGbUicEO7QXgTHIz
 3nTe9RQSy8TIym1a7Wzb31FdWINro5g4KyDXTWWe72J6mbZB1zgHVBso5YzF65OKp0nF
 OInmj59oLdbU1kMdAwnpbqZiVjjo0c8GZ5wVS3xdzj2b0KORu/tYv23WTSMDAy8lvXce
 siYeSm65eUzD3m/uBVmwYnaa9nE1ZmTNl9NoTdmNqnnJm8QouwqOWNca8PelE6rTKcn6
 nHssxJtGeKjTeWBWJhXNwVWSkMGIpU9M4bGGT3HCqrd8nVbCQW/gr6bIEXNC4MM1Onsi
 35eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778583706; x=1779188506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmHPuEn/7Gry1RvBW/FMQh8n+qcPkS49sE/ehIWO008=;
 b=Z0VYZEpr8HpfSZKQaFh3QSBkj+RxCsXK6mkF8ez5XQho7IirTdZ/uflis7KDwp3rsy
 oJ+AoTAQssTocZ9tTo0b8pukYorIo95RTyaHjild6XWUiBzvUPIWIqQKU7vVrwo602Ch
 fOLjttS17P/T5B+KZEyCWEqya+sCy76QFUj1El3OmFHD8zmhE/ziavqVCJOs/O3Z+0Mv
 of20kByBupawFZCb1MMhrIX+SayCna6cIusXlNjit8Fo1nVIBxzHr0xRtzCOQqpgVJM4
 vWwQu/pT/djsDVwht2ZUnjnQxVV7E1Q2BPmc3v4wgqYyfGq/ZNIQzwy6KyXj1kJQLKR+
 plZA==
X-Gm-Message-State: AOJu0YxF3B1Nmbnu5llBdD0DavfR/x9mSPOliRXVr4UGdobXOGd1J8nV
 ZM7xr4fB2yrnRE+mPlT8hhryxUhEhMTAyTUF4ae6NJqQlke5dFVGuJCRz0nkf/MyWn4lF/6FOmS
 bGSLJdt9FGR0J0RfLlCXakobWPVCbLyud06qkn2QzVLE0Fs8eLoHsA7wrtUcAfkUZsxL0+BW+IM
 zTGHVIzpbK7D3O8rBgmkaHkUb8L2BvKTg=
X-Gm-Gg: Acq92OExwdhr47aXn/9NtgxDHDsE+44a2LSBnUEp6fbgYKv0YP7j6L8paaKCYQcr4K1
 bbJljUcis+20kTXXljS37nz6ak6ZPTQzIa9WcHImUPKK96AUZ+OorsCLytJ7llN/X0n0mhDznJm
 7lHXr5PBmf+UAXBxDm0q/0v5avmdwxek4zCu4loub6uh/WJEMe2KFxqWciziNmOvt6nHU4yFWHZ
 Z4nbGhWI8uXRrKy2nhgp4sCoMqV6AUCy2jEP89d9Id9jqA29El9Hq7+2CS5MqhFz2ClYN3dVv3m
 Ic2H7450YyVBGludK6LatIw=
X-Received: by 2002:a05:6a00:2d12:b0:82f:4a4d:377e with SMTP id
 d2e1a72fcca58-83a5d873344mr28498781b3a.28.1778583706169; 
 Tue, 12 May 2026 04:01:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d12:b0:82f:4a4d:377e with SMTP id
 d2e1a72fcca58-83a5d873344mr28498727b3a.28.1778583705645; Tue, 12 May 2026
 04:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260512104210.3330835-1-peter.maydell@linaro.org>
In-Reply-To: <20260512104210.3330835-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 12 May 2026 15:01:33 +0400
X-Gm-Features: AVHnY4JLlpqhoFu4ac54wBkw9HGUUTbbNXiOV6Sl_t1PdmlDQNvl08QSSD8_mlk
Message-ID: <CAMxuvawNHwQjJ3JUU=Z=jni=5mo24fbqMXx5mWkhhnAPzoORYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ui/vt100: Use uint8_t for byte data
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 12, 2026 at 2:42=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> This patchset is prompted by a Coverity issue CID 1659590,
> where it thinks that we use tainted data from the guest to
> index an array in bh_utf8_decode() without bounds-checking.
> In fact I think this is a false positive because the array
> is 256 bytes and the data from the guest is always a byte,
> but both Coverity and I get confused because the chain
> of functions operating on this data switch between "uint8_t",
> "int" and "uint32_t" types to hold it as it passes down.
>
> The patchset standardizes this all to uint8_t.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Peter Maydell (2):
>   ui/vt100: Standardize on uint8_t for "ch" byte variables
>   ui/vt100: Take byte as uint8_t in bh_utf8_decode()
>
>  ui/vt100.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>


