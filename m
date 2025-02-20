Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81244C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9tY-0000TY-Fj; Thu, 20 Feb 2025 11:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tl9tR-0000T5-Pb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:59:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tl9tO-0006Zg-Je
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740070755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2pOswoV/jNAQJ99RtMmVoMXOlGFEyfgUrOiQnmVoG8=;
 b=D+R2tc22DJdCS8Y/VlbFrBTiIOSzQCKFu5iWQMBP5huoPJ1HoAAXC3lVruNqspCwsxx4KM
 atouriMcvVu1aD5wdKdYT4JRYPGH4WGLqDFU+FXk0oBd3MJ9oQ5fqdWg77QEhXkHa3GUWa
 5pEHZmQV537TVChAoV/LO3JPLKIpgjg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ixJeeQMNPomxCdsgvmnNoQ-1; Thu, 20 Feb 2025 11:59:14 -0500
X-MC-Unique: ixJeeQMNPomxCdsgvmnNoQ-1
X-Mimecast-MFC-AGG-ID: ixJeeQMNPomxCdsgvmnNoQ_1740070753
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43988b9ecfbso6653275e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070753; x=1740675553;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2pOswoV/jNAQJ99RtMmVoMXOlGFEyfgUrOiQnmVoG8=;
 b=T2PHcxQtPFc5sxwOHwbiJfQkYHCUC9zMek6tkzSD0U5ZM15Aul9cwJHPrJEQ9PNRGO
 z4q/elZ6V4qaEAzE5Z3/5LW61scfATNHYWVxJUKzRket8a9JKb+Rd5LHhF7/6HFIc7rQ
 QLLtoNjsXVfaB7+LKC4tuhGx/TFNJVuubpkg16VYgIqOuduj7KMVVJsngTNGshldlQKD
 rjgVU8RVnor9rclmfjT1u5fOMqrQI+ZEz86f3ZOGe1ZDdo0Jbq4US2rZbQju4/+lbZW0
 sPPjWMeXmobbkEDpnd7VGXldAa4GrDWKN8Hb64e1jyTHRbrKcHLATjTq8sltmIU1oyWA
 W5JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV82+NOFDO+rXr+vhsZK4CjIw1a8eAFGwaUgwekcRgeU9cj2C1XCIkdO1VgUVcBgzVxgsn/G50vfLLL@nongnu.org
X-Gm-Message-State: AOJu0YwD/RzEb/q9hCGD+YwTA3FDheYxozb9gjSl9/8JCN9ka481taXQ
 uS19QHVvI8IcjEOTDLa+QffmC9iviyjRvsehLCNKEScgo7cly0GMwo8AT3GKJ4f8mJqh1xm/eXv
 820aqY8FfXRWxDhSoC+xgYCJmaTJc1vYi7C3d5ZPGRBskab620l5H
X-Gm-Gg: ASbGncs6+BC3/g7FmvxmCakFHVdtm96EzQ9igSRxoa9FvKaFKse/U1oxQu9XKr4ulUC
 F8HlSyMNxLCuGIuXFEmXcnDG29uRh3Qpd74IS82sKIg01eabjeauDrXKq/HvAdzz7yzUYn90HkE
 6Wa+SgzmUimVyAsrtJZLC48EK9kyxpDAExM0ng+TGUjhqOl8L1s/gTny08ykIUHMUJW13oB7QKs
 G25X2QRHfWfjuxFEakcfbEIPXtyBYEccyfW1bbRBnEws0SqGuxm/OYaYlzeHG6KPft/MH+EkZlZ
 7np/FGs28VDO2kTo
X-Received: by 2002:a05:600c:4f0b:b0:439:88bb:d024 with SMTP id
 5b1f17b1804b1-43999ddadecmr68948035e9.25.1740070752925; 
 Thu, 20 Feb 2025 08:59:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyuaToKIhqojTI6gmEqL9UpBvsE916k2+sVLqAiz70N8Kf3A7bXIVCl7DKJaD87Y8xtj9xRw==
X-Received: by 2002:a05:600c:4f0b:b0:439:88bb:d024 with SMTP id
 5b1f17b1804b1-43999ddadecmr68947815e9.25.1740070752583; 
 Thu, 20 Feb 2025 08:59:12 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee48sm249806045e9.3.2025.02.20.08.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:59:12 -0800 (PST)
Date: Thu, 20 Feb 2025 17:59:10 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, qemu-devel@nongnu.org, Jason Wang
 <jasowang@redhat.com>, Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250220175910.25688823@elisabeth>
In-Reply-To: <20250220102724-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
 <20250220102724-mutt-send-email-mst@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 20 Feb 2025 10:28:20 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:
> > But I don't understand why we're leaving this as it is.  
> 
> So that people notice if there's some backend problem and
> announcements are not going out. should help debug migration
> issues. which we had, so we added this :)

The message mentions that the back-end fails to do something it didn't
and can't even do, that's (one reason) why it's wrong (and confusing)
and this patch is obviously correct.

Perhaps the commit title isn't entirely accurate (it should say "when
unsupported", I guess) but it's somewhat expected to sacrifice detail
in the name of brevity, there. A glimpse at the message is enough.

Laurent now added a workaround in passt to pretend that we support
VHOST_USER_PROTOCOL_F_RARP by doing nothing in the callback, report
success, and silence the warning:

  https://passt.top/passt/commit/?id=dd6a6854c73a09c4091c1776ee7f349d1e1f966c

but having to do this kind of stuff is a bit unexpected while
interacting with another opensource project.

-- 
Stefano


