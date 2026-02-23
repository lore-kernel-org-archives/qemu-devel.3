Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AEFEC1127
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 19:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vubkP-0002Zw-9d; Mon, 23 Feb 2026 14:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vubkE-0002ZO-Cf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vubkA-00019u-K8
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771875440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZ0rcDwgLGuF9uxwdMRqeWcbSXkjhcsuOCm64ifuO70=;
 b=JXry7GwDPKUtXa8QHDrxJAb4F4mdjk30/2RvZDDu3adGMtE8NAFILjbTNPYZWW6oInah0z
 bunss/SK1P0bzvejh8V/3zD8DAXzbhEl8a5Mei9PwCNe6J5KLYQcr2GtOwK9va3pzSSOfa
 ruTtOIph5kttx7lSCTru9PWFPynyVXQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-K6FL9UbcNlKReKvFzJ49zw-1; Mon, 23 Feb 2026 14:37:18 -0500
X-MC-Unique: K6FL9UbcNlKReKvFzJ49zw-1
X-Mimecast-MFC-AGG-ID: K6FL9UbcNlKReKvFzJ49zw_1771875438
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8947c4398c4so588408086d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771875438; x=1772480238; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZ0rcDwgLGuF9uxwdMRqeWcbSXkjhcsuOCm64ifuO70=;
 b=WIA4xZ3qlj9nM3ftFvTmKwcpH5e3rRyOPPXy8423uqXSnojBUBYyf4pckZzdghWazo
 ur1IP79P0y+GOZuuYPJ4AeFlwMEkB3PC48VKpTp7yQAck9yJPXCmPdEGmzAYSVADGObx
 zduE0ZtpSfjp5OxMStKW8xKuFHZkZ85X8x1xFMRDQqn7lUo4FtGw0FTodNDbTRYM2JoK
 p9bbpNyAHAsxCl2pmArzO0BpAUtUybyXqxqmmq9z/RA7hBZUlcfFbW1g2oTNy7o15o0c
 sF5dZdpUsCFcPWJRff+alrAotBs7jl+RTIVzjl8N7zw+KlZpg5wEJwJHqoc3lLX2L57U
 AQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771875438; x=1772480238;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ0rcDwgLGuF9uxwdMRqeWcbSXkjhcsuOCm64ifuO70=;
 b=bbEwSRfuczsgC2ZHuwXA42Clbnn6bzMSoD8QmdJrsy73rDdjrRJwtV+KH3bCe8zUTn
 /gbAguptm1dBEC7OmKToOu5LF0wJnogZmIrgoz6LQGyJoZkxOSHr6eOdCVcxlKsmHVPa
 LEUkhoAA/863YmVo0WLaQLm7n5XKmR5L4lXxXhcIxOJWZjUSVc1aBndL7uiriLPZxwRx
 3oboQkIfebP1bZptAp9K4GA0FuPJUkBNTKSZBFFD5sEh1R1RJjohmr9MPkAk4zwb5ptd
 NcToIl0jloOm0TnxLj0MTRj6b4U+7RVTmRgKuI+I02jAQIx7BCfGS024QkmJ/3pzGM9Y
 rLsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5fUOPEY1QGKeJ/NdUuVgL5BPQfiqH10zJXdXxXziIQpgSI1wvlJidow41OPm3bMAV1LwKeQKEN2Tv@nongnu.org
X-Gm-Message-State: AOJu0YyBatLB72RjUHlMo24o2Hdnwcj+HgYTJMp8/+2mpVVQl8cfXWdM
 BPfJKWKnT26+fTIJQMh1vVVkV9MMz1Qy3YW/k585StSpmZwsI5tjR9+TTxIvXxHPjplotPsRmiA
 jxcTBOHqa/+DkduTWAUCO8090tdGacHH3I2IkQQ3ScVojIazg/2KW2ipX
X-Gm-Gg: ATEYQzzKE5UyJrK1wT8mR3uQah0CDpC2dzxqQe2WTL88gc+/xI4EpK3ZVYKYVRm35D3
 Eul2hzmEuoZ5l2SqhPbYPWMLuR48ypHjWQqg4iFhpBM6q9PcJLJP7S+XNgc2ZjIV6BonVdhNhr1
 2iGFjjxwsX7bzhxgFVCWs/buWSSFgkHz5pWqawTFXuHoP20D5Ik3yxe01xntZ/RaIz6ATxDso8K
 SyhoCJG2xiwkrhSSNgz+M2TR0czhZpwYuxvYRvBTBzqBSyf7kw6+6MScX4/769WlkFwiKxHvdD+
 oXX6aQCLhYFeHpBb1VuZmJcAx4uy+w6l7I4DrBsXo+aJRGuTzj0G5LhvDzF+E7EZb5nK6WZiP5j
 DU2yKx6Of6wPaXUSrZhLbJzy07pW0YN+3ZehUB+uis62CSR0tF7wghuiayk8MpzH1TY18namR/+
 GbnCuhlQ==
X-Received: by 2002:a05:6214:301e:b0:895:4bc5:6108 with SMTP id
 6a1803df08f44-89979f35c9amr133597666d6.52.1771875438192; 
 Mon, 23 Feb 2026 11:37:18 -0800 (PST)
X-Received: by 2002:a05:6214:301e:b0:895:4bc5:6108 with SMTP id
 6a1803df08f44-89979f35c9amr133597276d6.52.1771875437675; 
 Mon, 23 Feb 2026 11:37:17 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d6a2299sm74185841cf.19.2026.02.23.11.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 11:37:17 -0800 (PST)
Date: Mon, 23 Feb 2026 14:37:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: migration: stable machine types?
Message-ID: <aZysbHMzin4PYtIK@x1.local>
References: <eabe1076-d30c-4454-8558-a231b9cb228d@tls.msk.ru>
 <aZwwGW7ERvH555zg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZwwGW7ERvH555zg@redhat.com>
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

On Mon, Feb 23, 2026 at 10:46:49AM +0000, Daniel P. Berrangé wrote:
> On Sat, Feb 21, 2026 at 09:55:55AM +0300, Michael Tokarev wrote:
> > Hi!
> > 
> > We had a few examples when a bugfix required for a stable series
> > but it can't be applied because it breaks migration.  One recent
> > example is https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2131822 -
> > the fix has been cherry-picked for 10.0.x but had to be reverted.
> > 
> > I wonder if we can, sometimes, introduce additional machine types
> > for stable series.
> > 
> > In this case, it might've been an intermediate 10.0.4 machine type,
> > which is between 10.0 and 10.1 - with this additional change included.
> > 
> > If this machine is known to both 10.1-tobe and 10.0.4+, all migration
> > should work fine in both directions.
> 
> Yep, any bug fix machine would need to be added to 'master' branch
> too, and any intermediate stable branches - though the latter probably
> wouldn't ever happen as machine version mistakes are usually discovered
> reasonably soon.
> 
> > It is exactly the same situation and solution which has been implemented
> > by ubuntu in the end, but using their own, distribution-specific,
> > machine types.
> > 
> > Why can't we do the same in upstream qemu?
> 
> There is no constraint from a technical POV. The macros I introduced
> for defining versioned machine types in a standardized manner, can
> have variants provided that define "bug fix" machines for stable
> branches. We have a pretty old example for Q35:
> 
>   hw/i386/pc_q35.c:DEFINE_Q35_MACHINE_BUGFIX(4, 0, 1);
> 
> We used to have another example for PPC, which used the _MACHINE_TAGGED
> variant, which added a string suffix instead of a micro version number,
> but I'd recommend we don't use string suffixes again, only micro versions.
> 
> The core reason we didn't do this in the past was the support workload,
> as every extra machine type we add is one more thing to maintain...
> previously this burden was forever, but at least now we have capped
> versioned machines at 6 years / 18 minor releases total lifetime.
> Thus if we did add bugfix machines, that burden is now capped and
> thus more tolerable.
> 
> 
> IOW, if you as stable maintainer want to add a bugfix machine, and
> the subsystem maintainer for that machine is aggreeable to adding
> it too, there is no fundamental blocker here.

Then does it mean we may sometimes need to add >1 new bugfix machine types
for one fix?

Consider if somethinig was broken in QEMU 10.0 release, then in 11.0 QEMU
we fixed it and marked backport (which will break guest ABI).

If we want to backport that change to older systems (that is, in this case
10.0, 10.1, 10.2), IIUC we need to introduce three machines (for example,
10.0.3, 10.1.2, 10.2.1), rather than one bugfix machine type.  IIUC we'll
need all these machine types available in master branch and intermediate
stable branches?

I also don't see if there's any technical issues to solve, it's just that
it looks like we can still grow quite some bugfix machine types all over
different branches.

Thanks,

-- 
Peter Xu


