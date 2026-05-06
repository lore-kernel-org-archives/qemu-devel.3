Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdlO-0001lT-G4; Wed, 06 May 2026 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKdlD-0001jz-Vq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKdl8-0001JK-UT
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778079716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ML1IV4kRyj3P8E5QxPHw0AzFmpFmH/dcrFLbsU2iNWA=;
 b=EkkAje1/VOu3O7E6hnQvyI53EUd0ddF+DMmj2wkSHKaPwr3uWgHETaW6BvjVyyYf995PYd
 fXI0i+thK1eyvcDYgDJghofFZuIIq440flq9+HCxyQpe9XnL2/uksbkyYFp79xeiG3i2fH
 GXwwF7kmxJ2rLAtwYqpexiJ5IPj9UF4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-r7pRFVogMVue_mgEWc9JMA-1; Wed, 06 May 2026 11:01:54 -0400
X-MC-Unique: r7pRFVogMVue_mgEWc9JMA-1
X-Mimecast-MFC-AGG-ID: r7pRFVogMVue_mgEWc9JMA_1778079713
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-46f083f82c7so1667727b6e.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778079713; x=1778684513; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ML1IV4kRyj3P8E5QxPHw0AzFmpFmH/dcrFLbsU2iNWA=;
 b=hAzwxs3oDOHdCT0PRtBZHSN8DuMLz+1KrCq24WvxNEYOEGdFsgJpNgZwbaTZKJnsUm
 93AlCogM9XKEM8AOv9xXztnpinLXSdEMIStSg8uGFt1cpK99IXQWncl2PYOm695S7k6E
 Lv/cM28a8leikb+IZ0N/qE6PpYgD8cd8IlIkeMdk9fCSjMRYVjuAp1KSyqVQSkSOR/sg
 vJaUN0GeOG0YrRHquDK+cBjNKLSlxCxIhI3d7jbNpoA/T1S2jQgqFDB6c4sxHfPNaYjJ
 /ANATbJ+Wu57o55ZmJZA1IXMlHENDXee401i/u+esWpisPRtHwnNnqe/0SJHhAc60Ytl
 zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079713; x=1778684513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML1IV4kRyj3P8E5QxPHw0AzFmpFmH/dcrFLbsU2iNWA=;
 b=DeK2S8YCzUf36U//CG1JTZurSOMZbz+ZWcLWrRL/ZCMCj2OFHvixoyiD/3C81OCxk8
 znQwDTqyUTahbyQ6rf1satduJoPEITKfTEK4EpshHlCwcd3x9vFbr6me1nfLdWSi7hJk
 JGteQrDqBKQPyoGFJ07JurMAbenKoyzd0jRpcK46Nl7hew3I//LOmO2rImBwEGZGrfEu
 2algPrD6jU2w4u7dmDrMgzuqFO1UIapLIQbHziK4pEngfkz0GDyQ6QbsfsLS61hQ21np
 n5r5eg1ovPjlyW9NO2LYjOjWRRJiZ69FA8PB7ANeUnBchdquVm635GgoqUYLhDIvBbp8
 MzDg==
X-Gm-Message-State: AOJu0YyWykCu8l7EpezV0qRmejGQtS4G9zVCKVEMTFq1rlIx3cCEvgc8
 mZ6IOINPVQvUS8c30I7CbZ8V+Yy+FdqjVuWrp7x5GfXtApG8jgdrrH2LLR9GfVaqPDro66Zd6/Q
 tvrfGbyIJG8kVAM/SJnwSvf6DGUxRaH0rTOSyGsdBsUqwKXTl80lsfIpH
X-Gm-Gg: AeBDies2VcJNhT+VIonk3obCxA5knwx+w1onUS9h0k5Uc5sTJTDMAtuiU2PgrgZ4o1V
 hEDRCGzQ0uccxIWiLT8vzUJu1E479vjoF/Vuy26gUie/MQKamRTHHCrU+/ovN5eExtfpwPCLp5k
 nTHYftfU+Q9gKoef9rMfjCbVvlzc+2SL/zqJGLE+dD4oRof5zb8a381mKFdrWvzOlTnVB7Qm345
 8NfDlyJMOkP2/pjgM2noybzecSoLaKwMRY20J0ZMrzV6mkWscFjjGnXMDyuGg33GrIIb9sGQHpC
 owCGVLtycLb8byWwXmtn08mfxqUMA1Iai1sa/MQKvuqPb1k33mSy6iZAOohpiYP7dzeHZmpKTF+
 HHmMgL7rTs7Sd5DpaCc2vJYOOhAzfCjwoss+rDAUnsIuhvWyt8n80k4t/hg==
X-Received: by 2002:a05:6808:1917:b0:479:e96e:65b6 with SMTP id
 5614622812f47-480428e14fdmr1723947b6e.13.1778079710694; 
 Wed, 06 May 2026 08:01:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1917:b0:479:e96e:65b6 with SMTP id
 5614622812f47-480428e14fdmr1723773b6e.13.1778079708915; 
 Wed, 06 May 2026 08:01:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76985f8fsm10772728b6e.14.2026.05.06.08.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:01:48 -0700 (PDT)
Date: Wed, 6 May 2026 11:01:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Message-ID: <aftX2XWobWGhKOdC@x1.local>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
 <20260506164252.464bd83a@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260506164252.464bd83a@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Wed, May 06, 2026 at 04:42:52PM +0200, Lukas Straub wrote:
> On Sat, 25 Apr 2026 16:08:21 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
> 
> > I recently took up maintainership for the orphaned COLO migraion component.
> > Here I take over maintainership for replication which is another important
> > component for COLO.
> > 
> > To: qemu-devel@nongnu.org
> > Cc: qemu-block@nongnu.org
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Hanna Reitz <hreitz@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Zhang Chen <zhangckid@gmail.com>
> > 
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> > Lukas Straub (2):
> >       MAINTAINERS: Add myself as maintainer for replication
> >       MAINTAINERS: Rename Replication -> COLO block replication
> > 
> >  MAINTAINERS | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
> > change-id: 20260425-replication_maintainer-c5f63ac49ae6
> > 
> > Best regards,
> 
> Ping.

I assume it's more of a matter from block people..  From migration side you
can take:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


