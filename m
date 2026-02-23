Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F2EA4FD8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYJB-0007Fk-4q; Mon, 23 Feb 2026 10:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuYJ9-0007FN-D4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuYIx-00037N-GQ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771862218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPZJN9YT78TG5DnhilLicuFtx4VPZnVCtxPDb7pgeLE=;
 b=JRTSm0wt+DS7sCP+Ozk+NZ56DRKuX0Blo2s0PiZI3PPU9bQi+widsP4qkQAJCaraZTG4tq
 om0c0UGjDL+R6g3VP64RJljaf+krgz2QA+cOjHHnyK1TOYsyeEW4yAa699CiH4HRfV1NTV
 vRfzPcZn72jHRr8oz19kCqWOvPNgTQU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-DkW3MNlvNn2JKZ6hI0Qtrg-1; Mon, 23 Feb 2026 10:56:55 -0500
X-MC-Unique: DkW3MNlvNn2JKZ6hI0Qtrg-1
X-Mimecast-MFC-AGG-ID: DkW3MNlvNn2JKZ6hI0Qtrg_1771862215
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8954ac30d79so599275526d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771862215; x=1772467015; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rPZJN9YT78TG5DnhilLicuFtx4VPZnVCtxPDb7pgeLE=;
 b=t0j6blViJFVDCPanik6joR3qHOMShwUb+OBDIDNQNZv6P5Jzn4FBIb5w+0EJL0zmg0
 NpewGlHEh77PF7Yzyjhem0oJkQ9DFaZnj+Gvx2m2xFhvHtuiRvv6tEU9fzQIMy+FX6e9
 dQNwxf4uyHTgh9IG7lLWfDMm7BqD81BeGwTORMIAocP55/0QiuaAXKvgOcgDGx1zVe/c
 xfGODwKgazO2gcvk1DqaKaqTOHiPAVX9yHLwgvBHvvKOcSePJlyte6a/I9/tBkW9uwWK
 /nPNylpeZ1FLOXpG5xQlOWScNGwULMGyp+tHia++NqXhnEASasWZZh+CScA38DMa/6Lc
 P2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771862215; x=1772467015;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPZJN9YT78TG5DnhilLicuFtx4VPZnVCtxPDb7pgeLE=;
 b=P1qxE2EMW9tiw8uE9GSg9oRtShB+5ymRLMSkB193KfDRozUw0acduRE0IAr6ZeEeAM
 Y7l2OqeCEA1S9RJB0n8vnj0ucu84Vriu5y37PvmQZm01AFzG61SFqWVp4HksWeJNa2ab
 Y+3u/ko5lGtV8UCyFXVnzuim9IW1KlaK3D+Q6ZxlH/A0xJ+s1mS4VQn76aYY7dYD4Zu1
 v0PLd0A3nz4MVsycKNhPu1YQo3U2IQ7Df3QLX2ZaF7aJ8LhsUC4mBYVggquS1P/UJufQ
 6GmAkWEx4MMEnAmaCzfuWlyrdN1bMyWhcT8vP0L+7uzIvpoPvc70d4Sm0v4JbQlFno6a
 nUGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyjKMgQpD8icirY+mOLadP2DyB/MQXOqIp9I463TSZCKXNov23pQInSlcN/vzGISPeA4QT5lOlr7Dr@nongnu.org
X-Gm-Message-State: AOJu0YxGDnKj65q77vme3zndQx8Co2Z8do8Mbbt409dTHZWjYthFPjr/
 D0ir9UKQEM+LH8SdPYWXiJA6oQwNOpfDlloJ6VrVgrhA4+tvqYBI5SkMCW68IMYbPxZpeJ0xFcY
 PLE2qZyVG4cvwO5jD3XFaY7aZs9CFglgyHB/I2qJtMWwTMalj+Dua7fxW
X-Gm-Gg: AZuq6aLi5T3vBUF1tMYFaS1Bt28jJFmlTMoBCmhkEyyO00p4LE+pptDC8zF8G5ySqNO
 tiz3nJOIjPRJVKH6O/1LsiCQqUIkF2c9OXBckurxWyfJYgE2gJ1SmrF5NDvSc35LhkK0g7QAd2u
 /lsaNtHb9bVGB8HgHinO0ErUhqO/GrywOIWxu+JgQsV18MmXngG05itLaRLrTnsY4epqjFDlL6f
 mlGjpb4N65SvvfAV/ChFdeFTOnEWiF7ohR7OdhnT2X5EuWuIznmepshr3dJNIBI+gDfUXzgbZIz
 UBtyy+WVsipb47gvpDGVvCvsKTtwTUpWyX1KpcIkdjbRLLzWFXhseuYSaWMN9gaq5uVFVuuypy7
 BqUGyZMy5TQ6YWAWS14jaNmIt57Qt6wmmk3WZbqq3dHeVQxVe+tCAjj9jQK8s820cyVGetFi3t0
 EjMQ2t6Q==
X-Received: by 2002:a05:620a:f04:b0:8ca:305b:748e with SMTP id
 af79cd13be357-8cb8ca769c1mr1287587785a.57.1771862215164; 
 Mon, 23 Feb 2026 07:56:55 -0800 (PST)
X-Received: by 2002:a05:620a:f04:b0:8ca:305b:748e with SMTP id
 af79cd13be357-8cb8ca769c1mr1287583985a.57.1771862214616; 
 Mon, 23 Feb 2026 07:56:54 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d04498csm817547085a.9.2026.02.23.07.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 07:56:54 -0800 (PST)
Date: Mon, 23 Feb 2026 10:56:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZx4wguQHBtH47Ze@x1.local>
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk> <87ms17lihr.fsf@pond.sub.org>
 <aZYtQLZfhRr61Dvh@x1.local> <87jyw96vtx.fsf@pond.sub.org>
 <aZwlLFddXXnbBYyj@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZwlLFddXXnbBYyj@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 10:00:12AM +0000, Daniel P. Berrangé wrote:
> On Thu, Feb 19, 2026 at 08:23:06AM +0100, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > > I don't know if that'll work because logically we can also copy anyone or
> > > lists only when sending patches (e.g. with "git send-email --cc")..
> > 
> > For what it's worth, scripts/get_maintainer.pl would have told us to cc:
> > libvirt with this line:
> > 
> >     devel@lists.libvirt.org (open list:Incompatible changes)
> > 
> > > For now, I'll just remember to always copy libvirt list on touching
> > > deprecation file.  My apologize if it caused any unwanted surprise.
> > 
> > We cannot and do not expect a patch submitter to know and remember
> > everything.  We rely on tooling and review to catch misses in time.
> > Doesn't always work, because nothing and nobody's perfect.
> 
> If any contributor is sending patches to QEMU, please don't use the raw
> 'git send-email' command directly. Instead use 'git-publish' which wraps
> 'send-email' with logic that automatically consults get_maintainer.pl.
> 
> This means you'll always CC the required people by default, and have
> to conciously make an effort to drop them from the CC list.

I am using git-publish, I found that it's because I have my own profile
setup so it didn't use the default profile provided in .gitpublish, which
offered cccmd=.

Now I've added that into my setup too, thanks for the suggestion.

-- 
Peter Xu


