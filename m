Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BFBC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU19r-0004L6-IU; Tue, 24 Jun 2025 06:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU19q-0004Kc-5M
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU19o-0002X0-Ad
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750761932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uXz7IFzR9GjDa2zL4iy3OipDIrLrwmLD8LpsA1EGxc=;
 b=XjXChPuFdYMAiI9PiY+uFtdQy0cQHdy+krFOx80NcDwEhDpBTkcaknjOwvV2IoXfwxO2CD
 JWKhD8WmUdjz7uSJPamUgfnEY1NtoKSriLCUvesnbOcdAN/gRb4trUIXSAemQAr4V+jy9U
 Vs+32My7mDCJMwj0CTBBuCz4nSvfzbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-2agKMk_vNHu3hwaNqPln4Q-1; Tue, 24 Jun 2025 06:45:30 -0400
X-MC-Unique: 2agKMk_vNHu3hwaNqPln4Q-1
X-Mimecast-MFC-AGG-ID: 2agKMk_vNHu3hwaNqPln4Q_1750761929
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so39313785e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750761929; x=1751366729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uXz7IFzR9GjDa2zL4iy3OipDIrLrwmLD8LpsA1EGxc=;
 b=jAGjObOXJEgb3jXaxgjxBUTpmd46NB3PdKd9daZQSlLusI9NCMjvlyQ3cH9kBg0I66
 Xvw+uDxjlmhjFBLxBvLq6UfWe2ekUvRI3xJYbz74gPXqVF6qTqqbbofkZO9gmYnB122Z
 sHde5Z0q4GSfEf3qzLO3dWsdgvqt1+JLOxZfHMLKzcC5agO9SVOMRKrQiFY/ZOt45S/K
 KkbLi5LuPP+7afrUe5+JybgkgWY3xxc71vqsTY0t8/ltfX6j9kt+SKezJZcmSU7q9p7l
 YSq67Ds7IENpMdxITnILjniHxoVsvlxtKRRS+exkdKIKOM8aHI9zJenPw3pgkRVVciSi
 evCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvwSYLGBBzBPWFi66XEaRM93jNTRLzd0xyPhW5t5w9iRoMqEFwZJ1F5BgVKsLOcGyHhz2XW1D/4hWT@nongnu.org
X-Gm-Message-State: AOJu0Yw8LW5KhcqWlx+kXTS8FrgFjtnZyEVpJFoNAebTLWPV1tIv9YvF
 B7LQ3wCrRoeJTRdxW7ymDzMknn1nrlCCN3o8esOh6OFbT1dOt8Z1Zd4KD/7okmdqZX0i5ZE6gn5
 K4iqYDXUj9d8KD0qdoUkbO+PVPaZPHMDm7qrzBah8O4t97V99MGtc44gu
X-Gm-Gg: ASbGncslmFAKNye3MO5i+VQbk1lz7zr4jfUX4nbQTsA5HG6QcpQAnaKxjMKaQMiWTx7
 815MNLY7kYhKycrVw3M+133cBsczUtwO/XpWwtuXUd6pWpVxq36jSHx9zzAhIDS629cKIP/0LVu
 YB0FlduzoV4IXqQxHh0GetnrRf7HpNQMzLEUkNFLSIcE56+GqXkYcqzTDWheXbqRI5KeTDwcxVj
 +1F8tXgwJkPGTTkpmt04Tyd4Wbqp83ahvHWPiWQaDNU+uFvYfYxXrADY9D2EJT9A7K56CY77K80
 CIHF80Ap/5bi
X-Received: by 2002:a5d:5850:0:b0:3a6:c95f:3f25 with SMTP id
 ffacd0b85a97d-3a6d12a711fmr12440564f8f.20.1750761929436; 
 Tue, 24 Jun 2025 03:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt8tac+far+b9fVBERs5vsIbYlme25YHqgyqlGQ7gG7bqluiByD2sKjmD8QtiyKlxlLc/dHw==
X-Received: by 2002:a5d:5850:0:b0:3a6:c95f:3f25 with SMTP id
 ffacd0b85a97d-3a6d12a711fmr12440539f8f.20.1750761929020; 
 Tue, 24 Jun 2025 03:45:29 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e805caf3sm1627851f8f.22.2025.06.24.03.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 03:45:28 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:45:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250624124527.656d567c@fedora>
In-Reply-To: <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
 <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 24 Jun 2025 09:07:11 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > Gerd mentioned this in the relevant bz:
> > 
> >         Note: root cause for the initrd issue noted in comment 5 is seabios
> >         running into problems with ehci -> io errors -> corrupted initrd.
> >         Sometimes it doesn't boot at all, probably in case the io errors
> >         happen to hit the kernel not the initrd.
> > 
> > This seems to be the last piece of information we have had that is closest
> > to the root cause.  
> 
> seabios used to prefer pmtimer back then for timekeeping then because it
> has a fixed frequency.  Doing tsc calibration can easily be /way/ off in
> a virtual machine on a loaded host.
> 
> Meanwhile seabios got support for reading the tsc frequency via cpuid
> (if invtsc is available) or via kvmclock.  If that works seabios will
> prefer the tsc for timekeeping.
> 
> So, when trying to reproduce the failure for analysis you have to either
> use an old seabios version, or turn off kvmclock + invtsc support,
> otherwise seabios will not use the pmtimer in the first place.

thanks for the hint (I've been trying to reproduce with current seabios),
I'll try to reproduce with the old seabios.

> 
> You should have this line in the firmware log:
> 
>     Using pmtimer, ioport 0x608
> 
> HTH & take care,
>   Gerd
> 


