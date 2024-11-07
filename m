Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBC8D5D67D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t96Zy-0008J6-Sx; Thu, 07 Nov 2024 12:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t96Zx-0008Ia-Ej
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t96Zv-00006R-Hk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731001554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rT1XxZue/k2VuOLH/6JIGBrqUjtBbxDQ+He2Lct//54=;
 b=jRLp73WkTIEq4zosg6o9UC37csXnFXH5dxD65mhbPRiYZbovw4xis2HhxsAWE8efCKvcOh
 2ptkjUYU7GsSVDyBp0N8zPjPe+jWJtUldSVvfOa0ByzD9/PB8I+cX3qOA21A3RF2Dq3zxk
 m0O67Fuuy80DKQ76Muc1PjMboluLArM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-ocbEKk9zMUausxJ3sT2SoA-1; Thu, 07 Nov 2024 12:45:52 -0500
X-MC-Unique: ocbEKk9zMUausxJ3sT2SoA-1
X-Mimecast-MFC-AGG-ID: ocbEKk9zMUausxJ3sT2SoA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d35a060aa5so16212676d6.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 09:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731001551; x=1731606351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rT1XxZue/k2VuOLH/6JIGBrqUjtBbxDQ+He2Lct//54=;
 b=tPAowi/AMhD+5QndOOSnn1DgEda2qtaMZC/aPCNNmDhV+LBzN3G+v7VJQIdIm12M4k
 xA+663P/AbsXDN2HwxW7Jc/nlWLmHRX11ymIDnpeOMvvi5pztzkcH4y/iCo34VsgLawz
 braubcpwymAARY3VpMMEytwq7e6/a3PRPaEsImp1TYkCVgr7EJ92A8LA0zZVQusbMo+u
 ydFu+eS+PiNFWjQ+dAsATSBkaW7UNQE42BOsU54icRgPeoDlXqQO1Z+8tr3/gH7s+4Ug
 NZlNEp1LYufM9YIjkE+6XuungROynoHSJoc7sHTLfjginrv6MmN8TdW2G09QKxoBZIgc
 Tw6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX93VE3FTdCNeC5caQ9gt90iV7eUcAMEsOnl1ELlE7y/Dud3hbHCJBBPMy8X49DfDFcP72VN+Z6mzWB@nongnu.org
X-Gm-Message-State: AOJu0Yy7E5ywSaJyE1tuyk78+73CB2Xn2x9Hbwbr12D7X1SwOvjWZG57
 OtO4D30lkO7NlPbdnw9CTT3h57Ua0bSyxpcvJyCJkvPWVBt9CZNXRiGZlt7xtTSo3psAyaxRzmG
 KrTCclPumyb6Z3w7z/7SosWSBcu7SSfjUEO4QHNEC/F+fYmQyFTiF
X-Received: by 2002:a05:6214:490a:b0:6cb:e90c:7c72 with SMTP id
 6a1803df08f44-6d39cf17dc6mr10070666d6.21.1731001551239; 
 Thu, 07 Nov 2024 09:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGvByVA4cDWyScr+iGYnVnMfOy0s8DPeS5b7U4VxiHdhkB3DYY7ygGFVnx9p9Fqprnr8D6tg==
X-Received: by 2002:a05:6214:490a:b0:6cb:e90c:7c72 with SMTP id
 6a1803df08f44-6d39cf17dc6mr10070486d6.21.1731001550928; 
 Thu, 07 Nov 2024 09:45:50 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d39643c6a3sm9808216d6.81.2024.11.07.09.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 09:45:41 -0800 (PST)
Date: Thu, 7 Nov 2024 12:45:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <Zyz8wnTkooE4V4UQ@x1n>
References: <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
 <ZyyzjWY-1nPpPgSW@redhat.com> <ZyzoGvOaybHs4uMl@x1n>
 <Zyzxihj37-pfTQWx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zyzxihj37-pfTQWx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 07, 2024 at 04:57:46PM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 07, 2024 at 11:17:30AM -0500, Peter Xu wrote:
> > On Thu, Nov 07, 2024 at 12:33:17PM +0000, Daniel P. Berrangé wrote:
> > I'll comment on a few examples above, which I think some of them, even if
> > handshake is ready, may still need mgmt layers to involve..
> > 
> > Multifd and postcopy are the two major features, and they, IMHO, all better
> > need user involvements..
> > 
> > Multifd needs it because it relies on the channel being able to provide >1
> > channels.  It means "| nc XXX > file" can stop working if we turn it on by
> > default silently.
> 
> NB, my point was referring to a hypothetical alternative history,
> where we had the handshake at the QEMU level from day 1. That
> would neccessarily imply a bi-directional channel, so the 'nc'
> use case would already have been  out of scope. That said, QEMU
> could identify whether the channel it was told to use was
> bi-directional or not, and thus not try to do multifd over
> a non-socket transport.

Ah, that's true.

> 
> So the general point still holds - if QEMU had this protocol
> negotiation phase built-in, there would be more flexiblity in
> introducing new features without layers above needing changes,
> for every single one, just a subset.

Yes.

Just to mention, we can already do that now without handshake, as long as
the feature has zero side effect, and as long as we don't expose it as a
migration capability (which by default all off).  In that case, we can make
the property to "on", and add "off" in machine compat properties.  IOW,
machine compat property can play part of the role as handshake, based on
the machine type must be the same when initiating QEMU on both hosts.

Thanks,

-- 
Peter Xu


