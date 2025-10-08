Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7161CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bgA-0006m1-9a; Wed, 08 Oct 2025 17:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bg6-0006lR-20
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bfz-0003Ea-OM
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759958777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8/l5ezATf5Ul3xcL8S/XkKRMX6R8kKSZrW/VEh3t/s=;
 b=h4rusQ6vCIKL3bKSWPK5kZ8Fou3jigoZBLIppcQt72rsvAP5MBPQp3jOnD8aHx634FFLhw
 QWhsFbXLEcqykekempm7c7ABJUDjwFJXXSUp207cZj6kimwT31kklzUwPcJCD7gqssYkB8
 /VA1s4SKeLCZMxrAWAVEHxtXpVSSmzc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-WS0EzMNQPo2QibPtAPlzjw-1; Wed, 08 Oct 2025 17:26:16 -0400
X-MC-Unique: WS0EzMNQPo2QibPtAPlzjw-1
X-Mimecast-MFC-AGG-ID: WS0EzMNQPo2QibPtAPlzjw_1759958776
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4d6a82099cfso8294981cf.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759958776; x=1760563576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8/l5ezATf5Ul3xcL8S/XkKRMX6R8kKSZrW/VEh3t/s=;
 b=PAh88CTPN5NHNZl0nPI9pOcS4YolKeYlcnzSIz9twMcW7lNziHrA8KWsUVx9TViaaN
 fYn3XFAy10W3R+0Qzgz56X62/VT/JNGfB8PGF37T4442u64IHPQlCXvn2YrIibmJG8qX
 1vItTrZAWiTk7bgeGr++pyN3FDF449jxE8Eyg5v9l92ViHB3VHf+n6ySzpAZAngaWMSK
 TZ9Jaze3eGrMDEatAvdLf86CLb36jsaHM7kUhgPg80avwq7QMqskJIP/0OAmoS+Eny+3
 waj/pUzJlITfY0ZVa7p7AChl+Iver5SdUYfRSphXGl+y2hgTgJ/n+5F1JR1u4bb6MTrS
 w+Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPJBX7JvlfuYlrilB/hxTI6Ig9iUgtU9oet+KXSWMsZ5do0sqnivE36mQobO5rhoHvvbefSXL5+SKJ@nongnu.org
X-Gm-Message-State: AOJu0Yyg/zskc5wp0jumtM6LjwZQHmfLgOCv3Gy8rpNXq7Tm4o160a7s
 BtKgr8VXIUQbzO4vr/vPmKe3iuOonYNgkoRGLN2uang7mbWv1xzC5WEQERfGPnqoxstvTL2eBG+
 V5VblPD6lX/4L6SrpDPQ74gzTy4LvP833s9Ozg//rqsTFeVCF+AncmqAf
X-Gm-Gg: ASbGncsotL5Tjz+A1jDNSSOXl0RlXiNpZmg9guKQ0wDrzEIAXdHlOXMJiEQTslOjnHf
 Y+d1wrjCFyzWELJbsunD1kJiynq5rrrtoCg1X9vi0tR8QCM7uA7kxDLDJBZ9FqF4I4c0jPsAJ14
 1RIHwwdx10895F2cxmZhvRvEt6idR4QS9r6GUkxPArp8ZwY90Gykr2DKF12SLt49/lquHFzEumB
 9IGioyuWn++oPg1qEvzUF2/7uDzEVik9umHx0JdnnIxGAtH+R1nqjJkLdKVDMEKQSHeCQBpy3Hr
 vcEHpvDxsX/ejPykDP8zlQxRbKp05mB7IP+q5Q==
X-Received: by 2002:ac8:7e96:0:b0:4b7:9efd:ba9d with SMTP id
 d75a77b69052e-4e6ead54273mr64509501cf.53.1759958775753; 
 Wed, 08 Oct 2025 14:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGteUbtFJhSQlTdgxdvCTRFonpZKOEasMtw7KEA6B02DkF897mfu2kdO5YWT1hBiIVslZbe8w==
X-Received: by 2002:ac8:7e96:0:b0:4b7:9efd:ba9d with SMTP id
 d75a77b69052e-4e6ead54273mr64509171cf.53.1759958775249; 
 Wed, 08 Oct 2025 14:26:15 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55c9e7409sm175555721cf.31.2025.10.08.14.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:26:14 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:26:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <aObW9WrmWzTWs4N0@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 04, 2025 at 04:27:39PM +0800, Zhang Chen wrote:
> > I confess I didn't test anything on COLO but only from code observations
> > and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> > qtests?
> 
> For the COLO part, I think remove the coroutines related code is OK for me.
> Because the original coroutine still need to call the
> "colo_process_incoming_thread".

Chen, thanks for the comment.  It's still reassuring.

> 
> Hi Hailiang, any comments for this part?

Any further comment on this series would always be helpful.

It'll be also great if anyone can come up with a selftest for COLO.  Now
any new migration features needs both unit test and doc to get merged.
COLO was merged earlier so it doesn't need to, however these will be
helpful for sure to make sure COLO won't be easily broken.

Thanks,

-- 
Peter Xu


