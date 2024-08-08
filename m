Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54343C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc51H-0003ub-En; Thu, 08 Aug 2024 11:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc51F-0003qj-Pj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc51E-00055L-2L
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723130734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40s7y3yjiQ3kcoKbH3z2AlAuLczFr+zYkcJIoHqFbLk=;
 b=WCBg20fBRLEO82FvJtADtQHSVXSmDVrXlBgfAk43WGaOEnmflCUn4bcIDCMkEHtqQwG/uV
 D57fG2wcoVoKf3ts3tCf+lbwWoOc2IORboRr5bB4NnkaF8JKVeU2pkSqVwug6s4GntIG2w
 3SNUCIUkzAuwTEJQNw8/JH0qfQzzwSY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-mrzz_CJaMp-R3Vgucgq-qA-1; Thu, 08 Aug 2024 11:25:33 -0400
X-MC-Unique: mrzz_CJaMp-R3Vgucgq-qA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5d5b4ffa0c8so149970eaf.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723130732; x=1723735532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40s7y3yjiQ3kcoKbH3z2AlAuLczFr+zYkcJIoHqFbLk=;
 b=lOivg7ewQM8hREmui+u7zSHGmB4grOyomurS5cGEXS6c6cBDcsw6hw+0Kw/ras56GM
 kF/51Suw9FBOL7XxIMj77EwcMlYYLK+Ys9Azys6BNLspe6011g+UyM60yMUX8MsORqLC
 cgLeZZmArg3F0O5nYwJlQM5WQrS+QlDwStxRsDjjxHFUvIXWolfyUF/wCZ+O/+3Pvagg
 Vw8eeVWhW6ATBUdDQ//kO8N/J3y12k8nn148lL8vq75Vz+Zyc/EPo0UhOMQZd+UxhF+F
 1DXIpDZq4SDmbLUJ/e60V+NEtk1kdB3RqdFckq7LGfjQAi0XurXJJ9mCLIvC6Y4dyFGR
 BukA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrjsGb21g5yAiu++bLRaxc79uYMo7o2jkI5S+MywNIZ7Sg7uxMa/ur0jQh8pOCkg9f5yXr0kWXSLlVg68a6JU0B0taMHk=
X-Gm-Message-State: AOJu0YzOM0ueToUNczvHXRVCYR6toYbN0fVr2I+dZhgCRr16XqBZYgJZ
 0LN87x1vcEg86kwAMy7gcfiR8g0W3Gb1C2woy5++GCNuipfLw3noO5P2PkvuV5BYOFple7EPpGh
 9n3safZhTx7StXhwBDIa3AnJ2pTuyIVgzRzeQM1Qz5Z6yJPdC6lTe
X-Received: by 2002:a4a:ea99:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5d855ba00bcmr1435749eaf.2.1723130732638; 
 Thu, 08 Aug 2024 08:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHGPhZCEe+IegUokZrqMGVnnhh0mLBCfHI2VXEJbhwMqkUCEpyEJEU8GMEXbL/Up15ltHiEw==
X-Received: by 2002:a4a:ea99:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5d855ba00bcmr1435728eaf.2.1723130732167; 
 Thu, 08 Aug 2024 08:25:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c7c0fe7sm67865246d6.71.2024.08.08.08.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 08:25:31 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:25:29 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZrTjaZPyjDuJZK36@x1n>
References: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
 <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808104559-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
> > On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
> > > This is too big of a hammer. People already use what you call "cross
> > > migrate" and have for years. We are not going to stop developing
> > > features just because someone suddenly became aware of some such bit.
> > > If you care, you will have to work to solve the problem properly -
> > > nacking half baked hacks is the only tool maintainers have to make
> > > people work on hard problems.
> > 
> > IMHO this is totally different thing.  It's not about proposing a new
> > feature yet so far, it's about how we should fix a breakage first.
> > 
> > And that's why I think we should fix it even in the simple way first, then
> > we consider anything more benefitial from perf side without breaking
> > anything, which should be on top of that.
> > 
> > Thanks,
> 
> As I said, once the quick hack is merged people stop caring.

IMHO it's not a hack. It's a proper fix to me to disable it by default for
now.

OTOH, having it ON always even knowing it can break migration is a hack to
me, when we don't have anything else to guard the migration.

> Mixing different kernel versions in migration is esoteric enough for
> this not to matter to most people. There's no rush I think, address
> it properly.

Exactly mixing kernel versions will be tricky to users to identify, but
that's, AFAICT, exactly happening everywhere.  We can't urge user to always
use the exact same kernels when we're talking about a VM cluster.  That's
why I think allowing migration to work across those kernels matter.

I will agree there's no rush iff RHEL9 kernel won't backport TAP at all,
otherwise this will trigger between y-stream after people upgrades partial
of the clusters.

Thanks,

-- 
Peter Xu


