Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7851E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJtm-0005eu-Uq; Thu, 05 Dec 2024 17:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJJtk-0005eJ-Dk
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJJti-0000Mh-0V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733436031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26UVJU46fI7B0y7+RSZoNWD83gW7jD/MekBst2BqTSk=;
 b=JWVYqvCKOTCaZjg2+xXMl6tC5LolkS7NFIw/NWdL/PBmlNRMQHAOtBMT9N4f3V6UbqqqRw
 VfN4m9Kwy4YhK40SR3Y6LzTLKP7g7wZeU1rUGwoUOGlVZf5fy9e7qaYR40/U5edYpmD5P1
 dsN8BFmqRu/yTFGxbCIDNb/HDdV4PSQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-_O81U8IAMRKVC8MAJG_lVw-1; Thu, 05 Dec 2024 17:00:30 -0500
X-MC-Unique: _O81U8IAMRKVC8MAJG_lVw-1
X-Mimecast-MFC-AGG-ID: _O81U8IAMRKVC8MAJG_lVw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d87d6c09baso25066896d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733436030; x=1734040830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26UVJU46fI7B0y7+RSZoNWD83gW7jD/MekBst2BqTSk=;
 b=frnKMBqr6A/vHb/R62CfGfeIuMjaIX6CLQnO5eVg14A7SwnCzYUfL08tlPOwpjbhzw
 UnKBoQmI5E5gQTj8wOh1WcR+yxMD8AOL2YRqcs2Yofuoga7/Jg88cUznaU4GRAoypx0/
 qrsUCZETTLQmlixqQbd5DKKawnWqmNZpO7/K4ce7drDnsE1NhzsJDaFT70CxcAuayNmF
 bjd2zWqS0krqjiGwwHy/LAlClJbf3Joi43DP6q777KnCP8KUeUFNObxnJnV/IPG66tBV
 /JW21FixzKNjV0KvmulG0mXH8jFGNRxfDAcDOObPIiEwL1EQ1ff/Cwajt/g4SmgjBDNj
 C/Og==
X-Gm-Message-State: AOJu0YwGObxMU1RHJmMJXLp0+D597YfH2qp3IiKGYgiVJtcDO9i+BSRd
 PNzs0FXubnE26YYu/MeDAYBJXTTzRRuuhZkWT84EkZY3ndkg/UlsvLjovQVi7lFLpOQSGXrkzKD
 iWL9dw8KjCxHgGs8dxRlPR0WYyZKxi4YDnnlQjNvO77feQPDL7/dz
X-Gm-Gg: ASbGncuNB/82iKRtsr9WkkTwr5QIJbemP6VVnYumZFpxhSDAucyqn1AxbK/e7BwctDF
 C7IcIMx5vNvS2YjYU6Dr9p//unK0N21vWngSXewl38ytb4D76o7w9sq3yt3PV1Sa6SB35AjoaFf
 QeP+WBrWnzV0fzO9VdCjVfD+pzAWcvRhauBpLuwwJWN8Z4nQlGpugqLxJdodTddc54mPhnI+/Rp
 CDYTDR4zrzY6cdIM6PC4tEOrVOLZ06kOcAStrDFO+5VGUMYlHvpmHrdejPZsEx4m3ijdlXmBSwJ
 hMxc1J1z4ss=
X-Received: by 2002:a05:6214:76b:b0:6d8:8165:ef21 with SMTP id
 6a1803df08f44-6d8e727e5f5mr7764156d6.49.1733436029770; 
 Thu, 05 Dec 2024 14:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Q9HHxlxE+cMX7BbeQNqMQSLjpQdyBNdo5M5NriddED4ZUo9XBMsUGQ8Ma29rLgx4ntjxAg==
X-Received: by 2002:a05:6214:76b:b0:6d8:8165:ef21 with SMTP id
 6a1803df08f44-6d8e727e5f5mr7763826d6.49.1733436029483; 
 Thu, 05 Dec 2024 14:00:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfbd14sm10859016d6.100.2024.12.05.14.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:00:28 -0800 (PST)
Date: Thu, 5 Dec 2024 17:00:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Further remove the SYNC on complete
Message-ID: <Z1IieiA5iuvSs1Eo@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-2-peterx@redhat.com>
 <878qstj46b.fsf@suse.de> <Z1ILpzQk6Q8d1cpg@x1n>
 <87jzcdde5m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzcdde5m.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 05, 2024 at 06:16:05PM -0300, Fabiano Rosas wrote:
> > We don't need to flush the last pages here, because we flushed it already,
> > in the last find_dirty_block() call where src QEMU finished scanning the
> > last round.  Then we set complete_round=true, scan one more round, and the
> > iteration won't complete until the new round sees zero dirty page.
> 
> Ok, let's put this in the commit message. As it stands it looks like
> this patch is fixing a bug with 637280aeb2 when instead it's doing
> further optimization, but so it happens that we still require the
> backward compatibility part.

Yes, and as commit message said I didn't attach Fixes and plan not to
backport to stable because there's no real bug that we can hit, as those
SYNCs will always only present at the end of migration, so they cannot harm
anything yet if RAM is the only multifd user.

I can add some of above into commit message.  Since I already started
looking at the patch you posted on putting all sync conditions together, I
decided to repost this series with that, and with the rename you suggested
on local/remote.  Though I can't name them LOCAL and REMOTE because the
REMOTE will contain LOCAL too.  So in reality I renamed them to LOCAL and
ALL, comment will explain that ALL contains LOCAL and REMOTE flushes.

-- 
Peter Xu


