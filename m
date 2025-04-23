Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343FBC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 22:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7iw0-00017y-0S; Wed, 23 Apr 2025 18:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u7ivv-00017W-V4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 18:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u7ivr-0001SG-Ep
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 18:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745448665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L70TUJq8UA2BIR1dSBR4kV9HZb4R9N6ScpqXEDaQW2U=;
 b=ax12cXhFRR23jVejFy+E5SrrvX0k1nY9dA32fFF06Bi48hXC5Z4gOqI9NZ2PAxDY7GLiQR
 X7EKZVJ1X61NOqm0icia5H3jEm1Ke/HI9IBMPj3i50aaKnamDu9zLwTYrL6txgt4KpK6dI
 ajGtiXzbhDqgi9YAGCyeCcfT3qy8fUg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-KFNKUwEVN7GQ3Rt6nnm8wA-1; Wed, 23 Apr 2025 18:51:03 -0400
X-MC-Unique: KFNKUwEVN7GQ3Rt6nnm8wA-1
X-Mimecast-MFC-AGG-ID: KFNKUwEVN7GQ3Rt6nnm8wA_1745448663
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5d608e703so65563785a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 15:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745448663; x=1746053463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L70TUJq8UA2BIR1dSBR4kV9HZb4R9N6ScpqXEDaQW2U=;
 b=bG/QJxCwo/QBgYkaUyCiU6syKa9s4hqqX9ewLrjeDMUZfBUj1YKzPXEZ5IhH9f8OZt
 XZoqK2s+AXeRR4/7moCMru9ByZECkI70UfQhmcH7Thuth7A/GVx2HkWJf9x+D30nJC20
 U9yGqEZbUDdVuLKbki8IyTIYujXH9mTWeGikuXd3k8r9OdZzeEl+POAvW9svW1Kxz9Wn
 MGB51ujOobPc4lvpIQSmFBiChd4cyHnelzNDyzS+fTs8w9Spm9j3Bj8FxsrkbjbGoPnK
 ppdbv8pJ4o9JTJsa1cNR5IX5onO7/0eq5zKAMLQ2upQg0fpoxViCEY6MrH8k6tQCXb51
 8JSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV3CHYesSrflz7l3fKWh95+G9srribfinyYywzfVASmODXLjX7cr9mo/+6ZvC7Jv4jPOsixS5jdW5T@nongnu.org
X-Gm-Message-State: AOJu0Yx+zNXY/QT5VR5TC4DJtLhvIgp0STguy4M1Y1LEjf1qmmQilLeV
 f3C6uoMSWEEhsySlN2visTEh1ZXHYzFbVg9tMdwuFfVoQH1jv4muuv59L3EVICALnuKaNK2MBKs
 ziuvW+tw0hCgIbYTjR6FWoz/TTXXt/l7FHoD0FZyptvzO8iAFYd/F
X-Gm-Gg: ASbGnctqmcva09MkAzNgZQO8fUOAqiE1WX9YF2kY5An1tiZh7V7pqQV7mmGQzh1ZoYo
 xzvCAQu1qM178hNigaElJF1i3BPsT31eGyHOwe8R+w7XENsUmLuYFERwnsCA1XJFCIp1sNRDz8X
 W/uYdhvQN2T836w2yhT686mOLyxZ1RCE60d3PPJFTKUasZVk5yOTgLDFRO523bclXPXqmwBD8Yo
 vFybAxrHWWVRrN9y8b6aWF1bFO0+ewZ+tAwOXNS7wxCi50va3q7kK59o1bYdIlcLp0WDZUjqez8
 MsI=
X-Received: by 2002:a05:620a:371d:b0:7c5:4eee:5409 with SMTP id
 af79cd13be357-7c956f4709amr83105785a.48.1745448663357; 
 Wed, 23 Apr 2025 15:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlKlclMBHJA/Aq1cMtVdWVreRKbQInuwAtGyBdUDmmTuGDVCa3g/KJFmT4JDyUa9M5V6HoCw==
X-Received: by 2002:a05:620a:371d:b0:7c5:4eee:5409 with SMTP id
 af79cd13be357-7c956f4709amr83103085a.48.1745448663019; 
 Wed, 23 Apr 2025 15:51:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c925ac5f78sm741133985a.65.2025.04.23.15.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 15:51:01 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:50:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
Message-ID: <aAlu0hcUCdzmIN4p@x1.local>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0vyepta.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 17, 2025 at 01:05:37PM -0300, Fabiano Rosas wrote:
> It's not that page faults happen during multifd. The page was already
> sent during precopy, but multifd-recv didn't write to it, it just marked
> the receivedmap. When postcopy starts, the page gets accessed and
> faults. Since postcopy is on, the migration wants to request the page
> from the source, but it's present in the receivedmap, so it doesn't
> ask. No page ever comes and the code hangs waiting for the page fault to
> be serviced (or potentially faults continuously? I'm not sure on the
> details).

I think your previous analysis is correct on the zero pages.  I am not 100%
sure if that's the issue but very likely.  I tend to also agree with you
that we could skip zero page optimization in multifd code when postcopy is
enabled (maybe plus some comment right above..).

Thanks,

-- 
Peter Xu


