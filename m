Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF8BCD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 19:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJd8t-0005x5-An; Thu, 13 Nov 2025 14:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJd4R-00036W-Me
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 14:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJd44-0006kx-Ii
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 14:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763062356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMNd6K2L6+5dVVi7ASJ8Kq6S4C72esb9kuGXVxdfORc=;
 b=SzTwCIVWZgZyj+kAj+Tgoh6A+OD6/pZDQkkoSqcIECYH+KJpfYEmS6wwncohTrty+twGkM
 ihqjOCY1/spjAL593jqnMLN1f0Xc63fcsuKxM8PKkuhFfEzpFW/H7kiq0cVDUV3bbv6rwB
 jT35L4xDrKqU4a995jjDMD11vPmLwXU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320--Bv8Hz-jPtKgu6MZRJzj_g-1; Thu, 13 Nov 2025 14:32:35 -0500
X-MC-Unique: -Bv8Hz-jPtKgu6MZRJzj_g-1
X-Mimecast-MFC-AGG-ID: -Bv8Hz-jPtKgu6MZRJzj_g_1763062354
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8826fb20ef0so33068026d6.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763062354; x=1763667154; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HMNd6K2L6+5dVVi7ASJ8Kq6S4C72esb9kuGXVxdfORc=;
 b=aIs7Ish+OUBo2eJbXgqg8nS/Y94U7MmAWeZSfoAO8xmZAE8aBqQW3Fq5HcQEpmXsGY
 R0VH0GCFGd3yCK8rI61oVVjmapjnaI/ik/F41+NuFOkMo01YzoEfFuLQ7aL5stEnbcpg
 l5j9jGRquQNmxqfVahgq4MBCto4AkzD+KNYFNlURZ/OH98ZacZIDmTf5At9WpzFGYrgS
 bR8EHmLYLelsGWoKQqHwVm88HD+TmayQBxQpTarl0IbSeRARfVzUHgO2C4yQ8z2epJ5e
 pWMmYgkGNYqKYVJwrrhZf9tytLv47jLr3cn10EZmTyeoOiWwKStWdo6hSw3fiQ7nzGhS
 k0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062354; x=1763667154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMNd6K2L6+5dVVi7ASJ8Kq6S4C72esb9kuGXVxdfORc=;
 b=HbXHINIXAX7/T0GJ4aGEz+m8dwUp/Ozm5VKxC0J2kFSk4Dh9AEr4qtIO/wViEyVqOc
 zMrmmkvNV4yydTJAXTQ0+ZmvuAY+RFu7acBYuaqgEBAynbXEwfv0KwVhIRQOtwfEDEh/
 U5BldyyqCR/dFHGXoS5YqOQFo6wEb9ulaBhbjtHWLNh4ROspYnV20TugMVQn7qwdtq+m
 cqd/ZSCOi0WBFyB+VxrDyAVRkuUb3chZlnYt2ZeSZyrYN36WxIkwNLesdrov9f/pzwDH
 0kehlqHMHx0b/QU5r0BfnnLnakZpJgExW0gIRcq6wITF7vuz/UWr6aOzK7GAYGTTQrIS
 LNqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81JX3RczY0s8XeWEa9DLlSYnW8evsxRNehUUG+PESdEdiOzwQAnr3dHpg9r4qlAq3C9h6kcrWymbS@nongnu.org
X-Gm-Message-State: AOJu0YycVrnTbrkyF+GD7uGp00c5ZwuGmN7+Jg9QF9hp6b4mQiCedXER
 dESwq4Y2ZSZDM3m7bUJRASAjOAnztUu0At9oEhkGmdvNmF1rZea1cYV0WX1QaAvN3y+QyfLTmrz
 80IwlvnySbrpma53zhtX4fDtbfq8fTr/oMnJcbgqyrkQaaRithGAaGJb6
X-Gm-Gg: ASbGncsjemVMzUUIZqcm1hNzGtpR7TAnVHBZX6rIVNvJzikAb/xNNxSEc0fOQoHAem7
 08GItXGg8WJjnynTWWM71qITjPpVX97IKLtwo7K9US4iPdp3KjphclKQiTWzk6aR0qAALpit5gC
 UQur462w0EW/Hq0AWHbwtbhZoU6I6iWJOA3ehIq7f8eO3U2mczjOi5hezLmBe0w56hV+1zDJdbq
 k+qEWjSHqN1R1Y7dMLCk1elYEmBecobK5rLuGP5SSJbUaArB7YDmKH1vqzCJx+izZqVL5rLgq8w
 nPQUK5n1dfN4zZSmvHfRq/Bk7u3Vzm4sBwrVylFg1SzI4WfCBCHsI+QjDhdxOo0E/J6dn/gZf0P
 ZzA==
X-Received: by 2002:a05:6214:c4a:b0:880:57b3:cd0e with SMTP id
 6a1803df08f44-882926d7c5cmr5281056d6.32.1763062354416; 
 Thu, 13 Nov 2025 11:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Yi8U3lX2gGSYA04huNT+3JAWnUaQ+aiwiqjj1eW5UwH/XrUaebtupbQWVk5MbwtHc0YfEg==
X-Received: by 2002:a05:6214:c4a:b0:880:57b3:cd0e with SMTP id
 6a1803df08f44-882926d7c5cmr5280386d6.32.1763062353965; 
 Thu, 13 Nov 2025 11:32:33 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882865a2fb6sm17720186d6.50.2025.11.13.11.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:32:33 -0800 (PST)
Date: Thu, 13 Nov 2025 14:32:29 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRYyTeNNIPW_WIJW@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113124207-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 13, 2025 at 12:46:55PM -0500, Michael S. Tsirkin wrote:
> failing to start a perfectly good qemu which used to work
> because you changed kernels is better than failing to migrate how?
> 

I agree this is not pretty.

The very original proposal was having extra features to be OFF by default,
only allow explicit selections to enable them when the mgmt / user is aware
of the possible hosts to run on top.  That'll guarantee:

(1) explicit failure whenever some unsupported cap is chosen on boot,

(2) default setup should always assume no kernel dependency hence booting
should be all fine,

(3) since all features will be by default OFF or selected by the user with
explicit cmdlines, VM ABI is guaranteed so that migration will work.

But unfortunately that proposal was rejected.

> 
> graceful downgrade with old kernels is the basics of good userspace
> behaviour and has been for decades.
> 
> 
> sure, let's work on a solution, just erroring out is more about blaming
> the user. what is the user supposed to do when qemu fails to start?

This is indeed a good question.  If with strict checks maybe we would at
least want to make sure we throw explicit messages to let user know what to
turn off.

> 
> 
> first, formulate what exactly do you want to enable.
> 
> 
> 
> for example, you have a set of boxes and you want a set of flags
> to supply to guarantee qemu can migrate between them. is that it?

Yes I think that's the case.

That's also why I think the very original proposal still makes sense
(having all defaults OFF when dependent on kernel), because only the mgmt
knows the details about the cluster, so it may make more sense to select
from the top which has the full knowledge base, explicitly enable some sets
of features (not only network, but also CPU feature bits and else).  Then
the mgmt boots the VM, also knows where it can migrate explicitly.

If all things are hidden then the mgmt is almost out of control of this.

That was rejected because there's the need to by default enable new
features if ever possible.  In that case, IMHO Jason's soluion is spot on
where it sits in the middle ground of both, allowing both to happen
(auto-enable of new feats, while keeping VM ABI stablility).

So IIUC there will be a cluster, it may contain different groups of hosts,
each group should have similar setups so that VMs can freely migrate
between each other within the same group (but may not easily migratable
across groups?).  But I don't think I know well on that part in practise.

Dan might be a great source of input from that level.

Thanks,

-- 
Peter Xu


