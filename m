Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27DECD8CAD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJaV1-0000bE-2X; Thu, 13 Nov 2025 11:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJaUO-00081i-Fb
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJaUL-000393-Ch
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763052478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9oyxFnOJxYgofIWWZuM2SWRE4S5lelAixTmsN/iWLBo=;
 b=CQpKxrh3HKm1oKtVtv1011I/6ayC4S6qTMViRmfz79TGvDyyqQ45OcfaF09BrG0TFbfyh9
 qWlx1OoXl4PE3GieUKyT9qKdSRYf9qRLI3a9+y2lrBeWeKGHwwqxelquI2tOhMtjYgnGYf
 oFkN84fXHinDzQhkI++PSm28xPY+wz8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-1Ul9odqyP1is6yFWgGx9cg-1; Thu, 13 Nov 2025 11:47:57 -0500
X-MC-Unique: 1Ul9odqyP1is6yFWgGx9cg-1
X-Mimecast-MFC-AGG-ID: 1Ul9odqyP1is6yFWgGx9cg_1763052476
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so521284f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763052475; x=1763657275; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9oyxFnOJxYgofIWWZuM2SWRE4S5lelAixTmsN/iWLBo=;
 b=RPVsP+Ab806cGdA9eUQQNsQa3xrySpCk14FZxrO8bnBCDrSug7KEWJsZ0fjTPAaAWk
 sV4T+3p7MUta3gajhWXdPWdB6CCNj67C8QChL70IQ4qrkK9JdKXa1DZjgFJuT8anhzEC
 WjccjL0TSnD3QabPLuirSNC2hMgeQ9UicxuxMCnfObN64oTJHvlZUPgK/urxYILfHRnN
 NETzC8pGI/MzRDh96DVzvvHBxwxAJPvJ/f1ypq0f6UFFHhOQC3jNjJpJL7e5cXXldBAG
 IKYDDWGCEeDCtZS/UhABM6rtHWOnRWXzD4nQpxrJtof1NG8MU8lZUF7xhYeHP0aM8QfZ
 GOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763052475; x=1763657275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oyxFnOJxYgofIWWZuM2SWRE4S5lelAixTmsN/iWLBo=;
 b=X578KxzKFfLJJ0mVWqSDg9PK8clzXX0re9/bAKbd9nZyD9tgbsmOjh3ewfZzdN7+fl
 hUqqS3/0g3HIGQw8HqVYv8t+J++cA5fAykpMIK+ouBd/AyrKc+xH7rmIMBEUySUJbrQF
 NNtZKt8tnZ2co43VJVONah+g4SZoozEw49+s411WRtPXmPoB08wZgGEaYhn6JJLFEmXs
 36/bosG3ZTcJmzjWvNkcU1JmBi1+pytFFaJiAYsUUeCLS5xAI5mjqADEdqyelxaA7TE8
 p3nQM9ju0uWGzARgD8tk/NzxP6WyVHfpVDkDaWyNmimiknHJUZD0Xmb2NK2qzb/DEhTm
 kIjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/sK6mNPEFNhz+KzGb6dGFvmmwizBznwAuOX5nk4wwtF7VXLE/Eb6CIPDjuxVe8BlhBzZgn+Rft+wb@nongnu.org
X-Gm-Message-State: AOJu0Yydo1udmIR8mTpjejFwFqWp2L9hu4I3mRI2E1321p1xC36kMNX1
 Sbt6RsmoiUSBdN6LPld37SFUNd0Uw/DccNpKHoqEB1p9SBl6rvW2AtMbLrjNZLIhY62hd9s1T3t
 RTQaEX1TGJlU/1bT7e+Rehw7KRpXUQqYJHL68NBlev2e9jvdvOqSf4RQY
X-Gm-Gg: ASbGncs5Gahf+kZTuuTcVknvu5A501zUm0FuDEjylFYJ1XZWl5rLpq4TURKFz+VJjmk
 44MZHQD/xEz+6QNIwn4N+91osksrea7s29XTT8W40gtkW41UnYPNOxFYCXm6NUY2fYLS+6Msdh3
 OBa2LRg2nWrxx4FYStmGRp5LDdNIcSirNJAg001dO52qQU5WOGtgMB1B+jXL94sKRtHU+iNfwlR
 vlYIxRzKKw6AJNz3wNTkYZ2JxXhRAuwFui7R0UQk+dhh35HMtuDtrGyu4Sj9B+nRivfdjZv4Hm3
 4T6JwRMzkPn/JVcNn2Fddeu54lHhepxp0UnUu8QJZREg8LQW4G1TO0MKwkwIYs/sazetlvsJAdX
 Xx3LhqijcfhBcH39/s+4=
X-Received: by 2002:a05:6000:4008:b0:429:bce4:20bf with SMTP id
 ffacd0b85a97d-42b59385ac8mr32710f8f.55.1763052475629; 
 Thu, 13 Nov 2025 08:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHkX3Z2W3zt22nkqx/escvjFF4/X86zZ37PEs5waZHyLnfKzz6tRlgBA043G4CE032MzReww==
X-Received: by 2002:a05:6000:4008:b0:429:bce4:20bf with SMTP id
 ffacd0b85a97d-42b59385ac8mr32683f8f.55.1763052475132; 
 Thu, 13 Nov 2025 08:47:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b513sm4830981f8f.30.2025.11.13.08.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:47:54 -0800 (PST)
Date: Thu, 13 Nov 2025 11:47:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251113114710-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYJRZyNrDcDzTuG@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > We used to clear features silently in virtio_net_get_features() even
> > > if it is required. This complicates the live migration compatibility
> > > as the management layer may think the feature is enabled but in fact
> > > not.
> > > 
> > > Let's add a strict feature check to make sure if there's a mismatch
> > > between the required feature and peer, fail the get_features()
> > > immediately instead of waiting until the migration to fail. This
> > > offload the migration compatibility completely to the management
> > > layer.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > This is not really useful - how do users know how to tweak their
> > command lines?
> > We discussed this many times.
> > To try and solve this you need a tool that will tell you how to start
> > VM on X to make it migrateable to Y or Z.
> > 
> > 
> > More importantly,
> > migration is a niche thing and breaking booting perfectly good VMs 
> > just for that seems wrong.
> 
> IMHO Jason's proposal is useful in that it now provides a way to provide
> ABI stablility but allows auto-ON to exist.
> 
> If we think migration is optional, we could add a migration blocker where
> strict check flag is set to OFF, as I mentioned in the email reply to Dan.
> As that implies the VM ABI is not guaranteed.
> 
> Thanks,


All you have to do is avoid changing the kernel and ABI is stable.
Downstreams already do this.

> > 
> > 
> > If you want to keep this off by default, and have management
> > enable this if it knows what it's doing, then I don't really
> > care.
> 
> -- 
> Peter Xu


