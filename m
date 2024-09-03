Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B25CD37A9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 17:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slX8B-00022z-CO; Tue, 03 Sep 2024 13:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slX85-0001lF-Ku
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slX84-0003Es-0B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725383741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8z9IuWVwM90ATBC0rbg4REiIuxiuTPKKJcmhSRpEp+g=;
 b=L7iKFKod9vbEj17qFC3/9yUJWvQcPEfyN/ZRY95aSudaxOF7dWnDaAE8p2r1EHvMqtE8wg
 F2uDnff9KoB9BUoGIaXvhJYS03ij/Tvs5MO0Sjfy5cGbl3OX3DnCTu2mfrtZBhoVq0CPNB
 opJ3L4YCBvKupxmCvzsM7ErDtRegxP8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-DLCBKUvUPZesRRTN1E241Q-1; Tue, 03 Sep 2024 13:15:39 -0400
X-MC-Unique: DLCBKUvUPZesRRTN1E241Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7d235d55c41so5228749a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 10:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383738; x=1725988538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z9IuWVwM90ATBC0rbg4REiIuxiuTPKKJcmhSRpEp+g=;
 b=riolRpyvsaMVb68QIdPPsLDNkxz6ub4fmTeANCeS66iSKWieiiQJhtKAGmDwyECGc+
 CN4hNbUpYdxItzIbLSQZG7Y+whbn+RSXPjXt4HYD6i5Vo41uGYe1sOpq9pw/d1TM1xDv
 B+tKZoyt6nw36iVuC6Hg/6IozNCZXhJ+3nTzOaCniqHd4FotKk+p+D42ODZj3SEbtsWQ
 VgjmECGRrE+1U+hL3up1EXbb87ObPRptSv2UNSnVi8sDfWTewXJSXiATfK/TnKeRFuRT
 5j5AQ5fs2gQFP3tetg7wNG65vvCx5pcjKwrzBa7v1nuKz8kr5OWXdlNaUl68CLqUaVyZ
 VZZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNG4pRxfDGAijfLgX9uqMDtDGAMvvAnnabeI1FfinE3DFsCLR/WlPOzIKYJorI4bO3sQM6Y0VD0kEB@nongnu.org
X-Gm-Message-State: AOJu0YxIaL09s79iLhk2fIS+LZFrXyqormxqpAjKYGZPCxEUXisXf5nz
 KyPlnXG4S6J95whO5NALB4lhoepi48qLusxoKJRVhxN/V7EKICxeefjGYXG0ExA9eYpL+wZ0HZ6
 sTva5PMP3QggRogT/WeBNllMf2sm/2zfjmtumFQG17ETIP6ihCZAY0qE1OH9GLVjxKv8r/+6V+q
 aTmGgGHIUVdpcJeNB4nTFzOdfmnEg=
X-Received: by 2002:a17:90a:ea93:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2d88e3e64dcmr11303764a91.28.1725383738455; 
 Tue, 03 Sep 2024 10:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLgsy8ehz1wwuFw/yY5qdN4ldUz4Ochb4gKXCTWYG8/2N6AmQqFRUPPT2vt+i53o7NvPJvvxAApa+TOd6nf2M=
X-Received: by 2002:a17:90a:ea93:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2d88e3e64dcmr11303740a91.28.1725383738049; Tue, 03 Sep 2024
 10:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <762867ba-8980-44f6-a9a6-5e766bc6a60b@redhat.com>
 <CAFEAcA-uTqq9Ke4pS59aQ_9t7KObRxff8DN_rY-2JkfSCQkASQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-uTqq9Ke4pS59aQ_9t7KObRxff8DN_rY-2JkfSCQkASQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Sep 2024 19:15:24 +0200
Message-ID: <CABgObfY--e1h=fEC=7TxA9eaHog1N4V4+3oEm+W_RSKEEUSU4w@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 3, 2024 at 7:04=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> The PXA display device doesn't pass anything through to the guest,
> by the way -- it just draws the pixels in the guest framebuffer
> in a different place in the UI window. As the FIXME comment in
> pxa2xx_lcd.c notes, this should really have been done in common
> code, not in a specific display driver.

spitz also passes it through SPITZ_GPIO_SWB ("Tablet mode"), though
it's incomplete because it should have treated 180 the same as 0.

> As we both note, the UI input layer part *is* generic code so it
> will do the rotation regardless of whether the display device is
> also rotating the guest output. But that seems to me more of
> an accident than an intentional feature.

Yes, it is, though it *is* working. On the other hand I doubt anyone
is using it. Since we have in the past removed single options like
-alt-grab, whoever needs it can resurrect the code from git and add
the options to -display. They can also add rotation of the output as a
separate knob from rotation of the input.

Paolo


