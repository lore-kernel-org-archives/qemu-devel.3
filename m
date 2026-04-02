Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BF8D6AAE5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8KBw-0006hx-Gp; Thu, 02 Apr 2026 11:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8KBu-0006hZ-AL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8KBs-0001R3-NT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775144559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUuDsFxP5i3qpHzhV4fxu8DyCXzoUzFYDCFlVn0RCbs=;
 b=fc6InaaWJMRQ24Ah6EMksF5vuMdniIO/GRH1oc8AhmgAwwg2muxf38vLDUOCi/6X0NnGTi
 rbHAtEl4yju+ocWgpFNXJw9PcwpIzHBWlo737R5OhFMBj2/UtpldCGYI14bmh6BG+oTMcu
 0FLWruCE9FVv2dbj/O98cdncUiAna4U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-e-Nb64itOuqnafaxKvBi9Q-1; Thu, 02 Apr 2026 11:42:36 -0400
X-MC-Unique: e-Nb64itOuqnafaxKvBi9Q-1
X-Mimecast-MFC-AGG-ID: e-Nb64itOuqnafaxKvBi9Q_1775144556
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a5f6110cadso24377356d6.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775144556; x=1775749356; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gUuDsFxP5i3qpHzhV4fxu8DyCXzoUzFYDCFlVn0RCbs=;
 b=XwjjZPIN0WlberTQr78y2ioetZd2Yjri85MgQGahbOZn4MFjVi9jDaoWWL/8c030yb
 MZPxSdmguUltDpE0O6lZsbz4d06t1uiNbAizlOPug8U+BXiUQ19QX9PHkMi0UB1n2Xri
 7iRHy0epHev6Uqkmo4jhLbjToY7F0DTdFbAL72VZ1R/Rz6C12fE0uHVhJYML5fIQnNhj
 A7UgEJf2Xip86DTsxaFuIJEmwpkUN66QH+rNbqzN0u6YWO9ikXRcB95lO4JjZmssty+u
 kjjs1jmdjU3sgeRiU5IfkL5e9pRdDoN8GBzwomTlPXwpcwnZdW17d/Rur8zSKKp7HVOU
 T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775144556; x=1775749356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUuDsFxP5i3qpHzhV4fxu8DyCXzoUzFYDCFlVn0RCbs=;
 b=Pl/XCzRBilINIPSZVHl7U7t7Ea60mtZMcU+kjZBV+VzW/NeouMVMXQOGrEouYHOU0a
 KLMO9CgIHlDT5rROQDJsyLRDKQA0XFWoQqlaecWffXFCjZ38EEZrI69od+FTYJBAFNom
 guEBtGLk2MgN/jL51FYCmSNHt1wZ8vtPKl5eAJaCZrwxdA6I1r9kW1O0h2Sb2kfssQ8a
 5NBB/zD8ZSDHYUJoieOBH0z0Yg1uheqlL4hbJ9F+bbkafYvPOZ16NmLDJvMQloLNvGyR
 7e20A/F6yjY3TuWaBjXP8PeQtvJzV/IJlzhlZILe45yzQqXtzkEugS6raNlX6yEWDgzI
 g00g==
X-Gm-Message-State: AOJu0Ywmq151BW6O9qbcnSnGSyfQ43Ro/Ecv1RprIy2w/yQ+chiTorgu
 LpqdKr5XZEBRS+zT0KERLHzJVUP1gmHwhMdExc/4yJv6DOKoHUeZUseqDxfh/gYuJ4TpTCAbHU8
 I8cOnLYHcgyvFGpNIzAiHDT0sDKmaZiCtpTCctiggoE2+YiubS93/m+0c
X-Gm-Gg: AeBDietZfjpedd6USQBpS0jFpwSnpMzDJFSfFeXX7zxQw9cyt0o87Tj1JYa7JI6DCB1
 /3PkbmRiNL1dPkTVydwCmlSsqQDPHGe9cJElYRSja+0XZ1TvD/vBtglXm+j98p6G47AMjE50/sk
 tD8LEM59ugjX6bEvzKlxoFKCPhozRF+asd+K5cFXZM3T3qmT5wsyurVBVcbXZthDtOqWjmk2l+b
 Q2LhO02PPXMJlhq6TiygQn7WRAY8ExhgBZob1VM2FOgg8deCQNqu2zEkChQVg/hTWIEoFJ5dbXy
 lGkUM8/whvJOKK3LX0bGeTop+KoRTjY4E8kGseJqw6z1CRgM5AsIUBVUoDb/4IwuEdKdweqKklQ
 WOM15+NgFUW/4+Xr2E0A8qNg1/k6UvaW4rzBFMXfkojCm8g==
X-Received: by 2002:a05:6214:20e2:b0:89c:4f67:8d15 with SMTP id
 6a1803df08f44-8a43ac480cdmr124110526d6.53.1775144555933; 
 Thu, 02 Apr 2026 08:42:35 -0700 (PDT)
X-Received: by 2002:a05:6214:20e2:b0:89c:4f67:8d15 with SMTP id
 6a1803df08f44-8a43ac480cdmr124109936d6.53.1775144555423; 
 Thu, 02 Apr 2026 08:42:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a593331651sm25525546d6.10.2026.04.02.08.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:42:34 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:42:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yong Huang <yong.huang@smartx.com>
Subject: Re: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
Message-ID: <ac6OaY__8Gk61iNf@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-10-peterx@redhat.com>
 <acaz4bJstLXz2Xdt@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acaz4bJstLXz2Xdt@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 27, 2026 at 05:49:46PM +0100, Juraj Marcin wrote:
> Hi Peter,
> 
> Did you maybe mean s/Make/Take/ in the subject?

I was trying to use "take", but maybe it isn't accurate.

I asked my English teacher (Gemini Pro..) and I was told "move" is the
best, "take" worst, "make" OK but only in "dev-talks".  I'll use "move".

Thanks,

-- 
Peter Xu


