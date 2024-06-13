Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F499C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmm9-00018H-4D; Thu, 13 Jun 2024 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHmm7-00017u-Cl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHmm4-0005Jx-5l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718294042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8C1XspQbhhvri9zWTxpWf3cAiXNMfrfu0wDCsFbg+8=;
 b=DlAQZDOyO4mMJDIhDHWOQd+rGkH0AjXrLDQAbKV4b9alfBn/G4tpAX1Z83lIwg63OcbtXv
 43l1b5aCZTaJGRWP0DyxE4g49i6dmjEVL7E5vAp27uDS+Fhweyvrz9smMXcElZstZGBqJg
 FPkdZitQ7J4suaZEDNMTsNUsIQ24K20=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-tZeD93yAMmOgjGkzGLZy0Q-1; Thu, 13 Jun 2024 11:53:58 -0400
X-MC-Unique: tZeD93yAMmOgjGkzGLZy0Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dff03d8af14so191609276.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718294038; x=1718898838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8C1XspQbhhvri9zWTxpWf3cAiXNMfrfu0wDCsFbg+8=;
 b=QnKoxqSCGrNwbgj11b4LLZYO/205iyKBbR5nShMr5JtAiBVnU0t60cTI2nlELO71FE
 3gh6JMZXNDHu2Uqw3M9v5gBGW1Rq4uiJvHIUe8m/GygCY6d451PDzIoPVpXm3hpV8d1M
 mkT35o4weAZzqp2s62XgsZqo22kEOX5F0bDCS2O+xS1gAPEjA6P3L1IbhIRxwVt5G4Pu
 r2y2Dp315P2RWzb7lAWrJ0Rre0NEFDyeYVs+YGjn+MzVNRMB4UFKndPxEFbvppM2QWYl
 xKJ1j8wdp2CNim+7hYq3Z+x1gZ85aYmbEjZ/UFPremTxfe6TmdQMBYoNq5TG2poKrd4O
 l/4g==
X-Gm-Message-State: AOJu0Yz08h1KjfuWDe8qP6Vtg7SKy7oVlisCfe1MjKIJ4O31Iv+u/ieQ
 9PMfjqY/LgHZF/SAUII3P5Yi69/pK4VEhoKWSH4e7+YGyG7SZg0xQyjeqrOtNHwiBiDxO/Axusd
 2ArWJIzWnTY32yLZqGITLt2yAEbV9d53QCBs60fReWvFznh+Hppm3
X-Received: by 2002:a25:dd42:0:b0:dfd:b41d:4a98 with SMTP id
 3f1490d57ef6-dff0fb6b14cmr817880276.3.1718294037952; 
 Thu, 13 Jun 2024 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOM6hMijKQggEcI5/ayB4/5Evnezxa5ErgPU/5EY9LwRIGm0joZFBdw3yAJ4yChBIcPBGtPg==
X-Received: by 2002:a25:dd42:0:b0:dfd:b41d:4a98 with SMTP id
 3f1490d57ef6-dff0fb6b14cmr817853276.3.1718294037400; 
 Thu, 13 Jun 2024 08:53:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f2fcca84sm7182821cf.74.2024.06.13.08.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:53:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:53:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 1/4] migration/multifd: Avoid the final FLUSH in complete()
Message-ID: <ZmsWEmJRjYdX8J2Y@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-2-peterx@redhat.com>
 <875xudc5pv.fsf@suse.de> <87zfroc2pp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfroc2pp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 13, 2024 at 11:54:58AM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> We always do the flush when finishing one round of scan, and during
> >> complete() phase we should scan one more round making sure no dirty page
> >> existed.  In that case we shouldn't need one explicit FLUSH at the end of
> >> complete(), as when reaching there all pages should have been flushed.
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Actually, let's be more clear and make this a:
> 
> Tested-by: Fabiano Rosas <farosas@suse.de>
> 
> That way I'll remember this went through the same tests as the other
> multifd sync changes we made.

Or... could I take both? :)  And thanks for checking that.

-- 
Peter Xu


