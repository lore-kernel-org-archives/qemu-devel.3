Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF3DC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKy2E-0004cS-N2; Fri, 30 May 2025 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy2D-0004cE-Rb
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy2B-0001lX-JA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748604982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZGaCvT1hf805LS3c2IZQI4zTa0xVczwlkRKDJpY5kg=;
 b=P4FC9Ci3uCLjvRTsMx2Bl0cASEE5PPO/tESCZvjJ2oFxcw3X7jfNfFMmpuipJXSAZf70dh
 ZAtJwFHz4b2HV6g5d1TKxmI15si8I0S67SlTW+3MM0exn8xJQMoZl82nqcsW5BaUFa18D4
 2NgAziSwbtpHz5aGvOsK9xITm14Ynmo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-CpQLiE__NAqT84xmtrB3Hg-1; Fri, 30 May 2025 07:36:21 -0400
X-MC-Unique: CpQLiE__NAqT84xmtrB3Hg-1
X-Mimecast-MFC-AGG-ID: CpQLiE__NAqT84xmtrB3Hg_1748604980
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a367b3bc13so816878f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748604980; x=1749209780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZGaCvT1hf805LS3c2IZQI4zTa0xVczwlkRKDJpY5kg=;
 b=thRWUnkK3y4RmnAyhLqdbCssZdcOulW8eWa74IWV4lUqGw5/OW+avHIOHzfmm7KKP+
 yypQ2aDmUqc/WUeEFb0lf04QnT6lYZbJ/CHrddMKOq4E4Ycnkv87mA97rZYX9uONoCCk
 FP5LUZLiYvmrWZurYf0B+aWRQrBoa8RjDw+bo8Glfu0+CJUb1MVhcF/F9WBKOnMGBNHT
 FXjkUbURaO/IAgLcj5wlQL4/8/nplza6OhiZbCp3DFXUTT5grQWAY6IDZrvUdnZNzTqA
 9lw/IpOURT6AuenetWI0G+T/jRYfImJeY38SpxsifnAihJ06I7Nz8qaM4Ay0J5Ja2iVL
 n61Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNNFvDZMcTJ9JZpQD2P453ylD7ErEonGNB6aw5rvwvJVgrFG8XAK1z90J9k3qBi5YtQqWAjbAcLgG@nongnu.org
X-Gm-Message-State: AOJu0YxxBLZxKtpmVJfWAxOdBij17vbpW1XEj1EQQfy07+kbFwfcIqSc
 l2zdBSYR/MMgdsN6+iaF2B51T6k2w7v+tzDBRpTZXcYOYE5XN0xvtXKkA91xtzfmdwUaY5VI+fI
 xUxidq3hQReAWjYcRxYMIuX9ORkMuosg8q+aQnu5VYBweTiDUxqbli+w1
X-Gm-Gg: ASbGncupGAzRYpTZyQ9+ishngfQVaCj7qt00ILQ4DZZMalqmGOH+nynxgQN0cnpXFOJ
 6e/v7E2/FqO6/CNF+AuLRWFuG9L/1kd5DzspeXL966DxQdhbCRqEevXbdxoJEXHpTOZhQzzMkU1
 bAOU7QgTA1eTsjkEku6HIJDE69zE+h0i2ZyVUqJOU1wXT0iNk4KFWjdubLJNAP7mX5hF/ziH3nD
 OehdYcglt8Oa3OHT5mLqD0cUwVOEuaeM+r8NeLfDPTmRPp+qJHVqmMIrzwEFfRJg6rW6ewHqvQY
 kmQsHQ==
X-Received: by 2002:a05:6000:1250:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3a4f7e74172mr1727163f8f.16.1748604980217; 
 Fri, 30 May 2025 04:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXcASeMzXMDzODPM4fuQlpnS1jP9D0+iuownCalxk6dbVntj550zH5bR+pHVBbmE6ahK6khA==
X-Received: by 2002:a05:6000:1250:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3a4f7e74172mr1727151f8f.16.1748604979840; 
 Fri, 30 May 2025 04:36:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c9d4sm4637732f8f.38.2025.05.30.04.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:36:19 -0700 (PDT)
Date: Fri, 30 May 2025 07:36:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250530073603-mutt-send-email-mst@kernel.org>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
 <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
 <20250514111224.7fb1263f@imammedo.users.ipa.redhat.com>
 <acc02028-89ac-49ad-9c5c-d6973738b113@redhat.com>
 <20250530071844-mutt-send-email-mst@kernel.org>
 <b89fc010-cf76-4951-8d06-80dd7c2ebc8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89fc010-cf76-4951-8d06-80dd7c2ebc8c@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Fri, May 30, 2025 at 01:28:58PM +0200, David Hildenbrand wrote:
> On 30.05.25 13:18, Michael S. Tsirkin wrote:
> > On Wed, May 14, 2025 at 11:26:05AM +0200, David Hildenbrand wrote:
> > > On 14.05.25 11:12, Igor Mammedov wrote:
> > > > On Tue, 13 May 2025 15:12:11 +0200
> > > > David Hildenbrand <david@redhat.com> wrote:
> > > > 
> > > > > On 13.05.25 14:13, Igor Mammedov wrote:
> > > > > > On Mon,  3 Mar 2025 13:02:17 -0500
> > > > > > yuanminghao <yuanmh12@chinatelecom.cn> wrote:
> > > > > > > > > Global used_memslots or used_shared_memslots is updated to 0 unexpectly
> > > > > > > > 
> > > > > > > > it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> > > > > > > > It's likely a bug somewhere else.
> > > > > > 
> > > > > > I haven't touched this code for a long time, but I'd say if we consider multiple
> > > > > > devices, we shouldn't do following:
> > > > > > 
> > > > > > static void vhost_commit(MemoryListener *listener)
> > > > > >        ...
> > > > > >        if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> > > > > >            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> > > > > >            used_shared_memslots = dev->mem->nregions;
> > > > > >        } else {
> > > > > >            used_memslots = dev->mem->nregions;
> > > > > >        }
> > > > > > 
> > > > > > where value dev->mem->nregions gets is well hidden/obscured
> > > > > > and hard to trace where tail ends => fragile.
> > > > > > 
> > > > > > CCing David (accidental victim) who rewrote this part the last time,
> > > > > > perhaps he can suggest a better way to fix the issue.
> > > > > 
> > > > > I think the original idea is that all devices (of on type: private vs.
> > > > > non-private memslots) have the same number of memslots.
> > > > > 
> > > > > This avoids having to loop over all devices to figure out the number of
> > > > > memslots.
> > > > > 
> > > > > ... but in vhost_get_free_memslots() we already loop over all devices.
> > > > > 
> > > > > The check in vhost_dev_init() needs to be taken care of.
> > > > > 
> > > > > So maybe we can get rid of both variables completely?
> > > > 
> > > > looks reasonable to me,  (instead of current state which is
> > > > juggling with  dev->mem->nregions that can become 0 on unplug
> > > > as it was reported).
> > > > 
> > > > David,
> > > > do you have time to fix it?
> > > 
> > > I can try, but I was wondering/hoping whether Yuanminghao could take a look
> > > at that? I can provide guidance if necessary.
> > 
> > 
> > Guys?
> 
> Is the original author not interested in fixing the problem?

Given the silence I'd guess no.

> -- 
> Cheers,
> 
> David / dhildenb


