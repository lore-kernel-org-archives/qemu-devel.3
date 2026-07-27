Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E259DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woN16-0000YG-2Z; Mon, 27 Jul 2026 11:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woN10-0000Y1-H4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woN0z-0008TA-83
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785165192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZcYIKbsklEKFhB9QaVrhqLb/FPCp2kKfy2RcYy9+6I=;
 b=RVr4O46b3Wt4k4/PwWf27a17Km7FUhQGXSP/yncSJgBGBvKl2KWHZq9Zfr5ALgbHz7ikk3
 yhhGOBlbmRqI7JMy/Kgp+sCneecwtcXqvK6qNRKTVAeJapaKeP2U2YLmQN0kYWpeGEZgjl
 i048P2rgX+tXrBzFdsG18AMRin7vY9Y=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Z1-tORwJOOK0Isih3qJU7w-1; Mon, 27 Jul 2026 11:13:10 -0400
X-MC-Unique: Z1-tORwJOOK0Isih3qJU7w-1
X-Mimecast-MFC-AGG-ID: Z1-tORwJOOK0Isih3qJU7w_1785165190
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7fe835353acso41592917b3.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785165190; x=1785769990; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ZcYIKbsklEKFhB9QaVrhqLb/FPCp2kKfy2RcYy9+6I=;
 b=IWpV6ukymg9BHgC7VKEX+pvYrtYgZSOr9qZ/U5oI6xkROGsXhKDsCONvSYMCirdVZD
 dawjKHvBNUttncvlH2imJCLj3B6GxaFhG5iDJ/h4n3fRGCKOzyvrW/Abps51Uhvfi7lG
 07/BZmqzGvGOyh64AdcIeNBxaaK2TADG13bObwtcVtau1gaf+8mBklMsEalYkSLnG0Lj
 8r4roeCELq3BfWo4Dbw9mCa9/CW+T2vdHkA0jqa9ssUO1ilomrsZO4BzNIARnVuWlT14
 0exbKAMDDzqVVzfry4L5ZYmF0JoWrzzHTYLPRjBDA/6eFvoNTHUYnjj+74xrN+yb04wn
 w3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785165190; x=1785769990;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+ZcYIKbsklEKFhB9QaVrhqLb/FPCp2kKfy2RcYy9+6I=;
 b=VD3KGnolwgEZkPvTYROW1mxhuA2KL69ep6CY6pmJSt2CxfWzrjqEqt70/rReqhkuHm
 srl0bo2x0GwjOCz/eMmZqmy3JwL7hwEl+5tOPbqyn//VHJsmvL1UI4dIqtUqGJ/+1KB2
 8LaJTjRfgW4VGm2xIJIKEhCMEO3r7mYDSIzDDAEFcwNjFJe9UBDJfMtWVRdevnEaGshV
 9zmda+OtbNeV33oWB6nc1K9SD1u+BjkCbljIAKS7sOEtEYn4HZVANuMKk4f111nfL4YA
 U1jA4lHTMuDdi4Ovs2QUXK+WF7POQ/iWwmXIVcedLkg9bY52sWQ3PSz5FiWwRGbq9Aq+
 AZpQ==
X-Gm-Message-State: AOJu0Yz9bHsXPyvfA7a7zyVYM6DEhE8ssYd5M9ekvO703QwoajzEETTm
 5+1bIMjWXg3RR4HgyI+xUVlh+yb5sKZjdbqnNvf5GE4iBdgnje2Zqlm60aibBwwtBOqTEWdTi7k
 ArdqOm2WaWQ0O5SJKTjOTnSOQ9o4pbotsycb6Ril+ilB/gmbkdIHZDJCF
X-Gm-Gg: AR+sD12EQnyLcTHlFRVe67SUXx/Cr59JSbbXf+OE9DYj2Uh2j7gpgGu1NoUtcmzgZTV
 vVrbIsEdsp8YYkvjlUqq6QNlQcU4Xt4OL8S1vHcCVGmSjgjFLDYX6rU7yAgKl2/yWgUS7oZCURL
 HMEzCiO+ioRb6elFvWkJmuGBv6GtFhqfCQ2aMs4+ttVzbKtoWiPHXpaYrL7VmzlRI2KczaJM/yb
 uxgIAVN7nhMK5fOnsQcvN7CAeWl3AVzBtzRwavhO69uC0er24W/V4ck+W52wzOdyIrs8ICDxV0U
 zjSHgqbqLjNoWpCsF6CvXNoLeQMRkpsMENRkHWYRDv8/XRDHy8I5AsKzIh17Wd9Ei6EE
X-Received: by 2002:a05:690c:2784:b0:81c:e8ab:c4dd with SMTP id
 00721157ae682-81f69e2e941mr29751727b3.33.1785165189565; 
 Mon, 27 Jul 2026 08:13:09 -0700 (PDT)
X-Received: by 2002:a05:690c:2784:b0:81c:e8ab:c4dd with SMTP id
 00721157ae682-81f69e2e941mr29751567b3.33.1785165189095; 
 Mon, 27 Jul 2026 08:13:09 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f657c52ebsm33369757b3.20.2026.07.27.08.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:13:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:13:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
Message-ID: <amd1f4cW9T7oa_wn@x1.local>
References: <20260721131457.3062767-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721131457.3062767-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 21, 2026 at 10:14:57AM -0300, Fabiano Rosas wrote:
> Add the security considerations that are unique to migration and that
> do not already fall into one of the other categories. Some aspects are
> better framed as security architecture considerations, so extend that
> section to mention TLS and clarify that disk images and guest network
> also need to be isolated from other processes, not just other guests.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/system/security.rst | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

queued for 11.2, thanks.

-- 
Peter Xu


