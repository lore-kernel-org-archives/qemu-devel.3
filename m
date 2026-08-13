Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901DAC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuU3H-000327-GI; Thu, 13 Aug 2026 07:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wuU3F-00031Y-F2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wuU3D-0003hk-8L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786622204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJe7msUc6iCqgNocQ+AIEUd7bKFlS2El/hiN8jVPf/k=;
 b=B98AZbEy2Xe+Jd3ekyW9j76Cm5vqE53BhrZJXf2gSPHfhrrJwdlDgDfFYzIp2otIEMWGmh
 HtXHVym/dnLGEtVpGUAvHYcl9nxIdu0+JHkt+kYJLPAuT5Ueq2BfWM6fqLSffkOMT41RI+
 BQPOVkh54upNH+GvZZU1pWYzfVgrA2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-qRGehuRMOFObvjhqi1GdJg-1; Thu, 13 Aug 2026 07:56:43 -0400
X-MC-Unique: qRGehuRMOFObvjhqi1GdJg-1
X-Mimecast-MFC-AGG-ID: qRGehuRMOFObvjhqi1GdJg_1786622202
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so4834835e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786622202; x=1787227002; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jJe7msUc6iCqgNocQ+AIEUd7bKFlS2El/hiN8jVPf/k=;
 b=I4PFjgOThI6r5fjFHFUAJjUIBs5n66zzzbqyHyKaWypwzu6aLUqp0bOUCMQWFiISGC
 20/Q9vykgdpw3Wn3RgrxrotG1ef1E1xMEY9Pj21y7l1HRlCjfpmddJOqYim89DMiNbiy
 gfHsl9HIkJus5cNPainbv+2P0KkhqKyO5SNQHVeUCDeM8IpT3PH6rofSOrGc6Ulo6gJZ
 zQr6bRNdGYZmk+MC7m9t1g2rHRyeS6VKdoiB6FsUNPzUn0WDhp2tHUPFxFJPxZ5uvnRy
 zgtQFI/TrLjBZH10ct+e7Ke9pvDPmzLWDQ9mpRs5nLNrNQukRd0aB4rDrRlT8aUrdyli
 Yt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786622202; x=1787227002;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jJe7msUc6iCqgNocQ+AIEUd7bKFlS2El/hiN8jVPf/k=;
 b=iu0OIZnaUhsp4xd8/AxtsypqobkFCQftJ70dBZ7ulNdsJcewv9mHhe74frn4+WG7M2
 X9ySijxwe4X11KdOBLBbLvVV48i/4xreDJG5p9R1bK8/bRBFXb1tmY9k7bMur6iM4Tie
 dQwno0MGl0U3xUSpHtKLG5wV/7sVjuWirMz7hDCfjTPQ7eIPDv0v5E5Y3nQipUh5ympl
 hUhdChCOQSGRkOido829KERo5zM5oAK58ut1ogJIDOc5M87kGRlEqMv81LqWwDSGW8Qf
 zjqschgvkvWL4/3qoJQHzuZytoUDc0xkrw+qI0fC2+ecI+ziZNWHTkyxkU3/Eekwj1uU
 R4AQ==
X-Gm-Message-State: AOJu0YyZsHpeVKP0Sm53z5W97tmR1ce76E3lcVHXlR5zCADMMyRchBvK
 uuyTPSek8zpA/svQEnVN7eD7Ezh3RRvbKsV7Fuqtx3VIVqT1cEPeT2+xkpsxQoGCTkFzT0ifdVh
 B71pPSt3d39VMNh4sF8PigCQV2ziDIbPpH5dxJtIeZ5HrYCEXtkt7eXV/
X-Gm-Gg: AR+sD10IciQyDfaffY2h+Sgq4uIWXcHlrl8SeXrmDDgQKQFjNcFeNX+M7VMy8+tHGNh
 U7etwZvNMFj5EbGuIRsLxuIILwTm/2tuvEEXGxGL4tvEglqBP/UFRfNExAUKTLSqMFE7th/zXf6
 54kedCQzxcwgBJPiOOjT2JpMJfeDiCWaBCJsqnRn/52ToAc622qOOxhxEXTGmLabuamWn50FYPG
 ZILwmYJ1aCCOLmRDAyYnQE/OdQ81GOiozmA3zsWCgJvnaRaDNpwSNhrW/4RM6jKx29H5Y/RHFjG
 DtHg9hOh8PgboCRqklCNMGEW15YX91fZ2ScubA5yuwYECFqepRbUcTw=
X-Received: by 2002:a05:600c:5494:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4998218e8cbmr61648155e9.13.1786622202120; 
 Thu, 13 Aug 2026 04:56:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5494:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4998218e8cbmr61647745e9.13.1786622201746; 
 Thu, 13 Aug 2026 04:56:41 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1063esm71204895e9.6.2026.08.13.04.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:56:41 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:56:39 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH v3] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <an2w2jaxQU01O6iL@fedora>
References: <20260812124327.2572363-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812124327.2572363-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On 2026-08-12 08:43, Peter Xu wrote:
> In an unlikely case, when a migration stream is attached to the destination
> QEMU and only send <4 bytes to the channel as magic, it's possible that
> migration_channel_read_peek() may spin forever.
> 
> Fix it by adding a manual sleep for partial read.
> 
> Since the path isn't attached to a coroutine, it means when partial read
> happens, there's yet not much we can do but hang the main thread, it will
> happen even for len==0 case.  It means monitors can hang due to this,
> either partial read or no data arrived (but connection established).
> 
> Leave this for later, the hope is this is extremely rare in production.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> Reported-by: Feifan Qian <bea1e@proton.me>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


