Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D411C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZus-0008Ne-4E; Tue, 30 Jun 2026 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weZuq-0008NH-1X
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weZuo-00035j-Od
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782831500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IzULxBEfbcpVZOloIPWWzuh8Tu59yIQd/zon6zQ8Syg=;
 b=PkwUj2uwi3MOMgKqxOSCZm+LhXyPmWUxx8DJLptpd4VdhEKeFfR2sU9QK1/wBmldvxKi76
 zjqCzisSrb9UBaQBl3XDxL40RLz1uPDQU7ponRcNsHowExnaFvN3ZfQbRgzjkuQj7d8ox6
 xGneP7GJJvk9oGnESavj33N3zyWq6TA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-z4lGKDCpM5yceBbCVReSuw-1; Tue, 30 Jun 2026 10:58:18 -0400
X-MC-Unique: z4lGKDCpM5yceBbCVReSuw-1
X-Mimecast-MFC-AGG-ID: z4lGKDCpM5yceBbCVReSuw_1782831498
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec235c7c66so50452826d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782831498; x=1783436298; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IzULxBEfbcpVZOloIPWWzuh8Tu59yIQd/zon6zQ8Syg=;
 b=OaWYyvEvstLEOt3fyE/hktdnDjQP8rQabC5+9pd7Dmb5OvFdYxzY4ncUWqO5kXJ8mo
 1yA6aYrKW5zpc+niZ+ghBuhUkiqvSNjGRClEKBRWc+C7qNhitn7pYmrikIz7Zzfkerdl
 hyh+YdaeEc1t4qLchh2+jadudTPg3shE/oUaKnH4VAG0zKozucAmBnUT6/kK8aZJ7EfF
 wtUaoGI7197IRmGUzRtHveLFkShrp/eUxdXpNOKADMBXuqUZK25X6/EfSDYA0sat7Rnz
 sa81Wy2kog+smFljw/3wLBJG19vxslJLcEAPBb3tp3xt1uT8N+3X2Hzl0C8Kh7u+VoP1
 Ukng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782831498; x=1783436298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzULxBEfbcpVZOloIPWWzuh8Tu59yIQd/zon6zQ8Syg=;
 b=XTCxTeM9U5OxPFbSof1cXe0sP+LwkaU5CUfFzJ3lKQndUvFNAk6NNxf6VvuCJq+kzX
 zO5cY8z2IW/SWI6m3iGtLJHMC63EIpblrIkc73ymMS3pTS3sUqFxu1OEZw97g2iuri4O
 E6kygcExghJOabny6fKHkr/FAhh3yzJNI7IhpzqnBO44kSU15Q9KyvQOm1Lko3V/U0P8
 MlItWbAFV40FvX2d6GgyTiCjzhjarDwZShJg+pj4xqSRynMRHB5WvJLV5mN1x3ORqgvk
 cj05vNdjUaZEbJ3VTSDWq5WBpB5nx4Rj8kXwUI4s/B+qFfp4i/aOrIrWjo4MxKl+/gd5
 RCbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr76HRBzlTZu1PUk/WRqjtKilqeSNUWNAOdAi13NzbdfE0gEQKT435VvRnCP+Da+wqHkE+HINLS4skS@nongnu.org
X-Gm-Message-State: AOJu0YznRLWHsbpa8uhFUA8+vawjTpAPdAAc0+bh5VVQ9+YvFCkXuG2w
 E14oiY6TG94K6TMc+8J3HInZbM+MVmfUPgm6Mn7O41fOzQkNI8M/rNdmn2fINjGK+Bl/dlsOjZw
 vLtk6GHtZZ8tfoPC3sbP/Ti+Yl0Cx39jWrbYo57dLlZvgPFLRw8Nt1mM5
X-Gm-Gg: AfdE7cnP+CCfrBsZlZMk3P5lNfcSauAAsOBzND+0rKfbGR1cxesG3kr8fxMGILANhGA
 RO+88pHxB7A09C6qQDy89kLhzTfTTgXAtFQrYTb5QQnK+Hs2BZexZ2tnSt0Z+QpA3W2O1v3GS9M
 8Agi566WMP/kPj3tHAOfhcHtoVo63gjYSaJZGEYn+SuvUStsa6jQf0bpOwjM50eqEbhGjahonm4
 nh/jBFAP64GYuNaoK/uML/8xmD6Ew21oo2SvSryKWveERQ+yEPeMsYe13Oyrw32TJ0GJIB6xhuH
 hk3JJb6bUNBz1BlYMK/MOEf4lbzv2qzbITrvDGIN/9JJ/euJdc4liGdxjek/djb50xaQwXFnU/i
 6CJE=
X-Received: by 2002:a05:6214:1c4c:b0:8ef:b2f4:c686 with SMTP id
 6a1803df08f44-8f1bb5188fcmr65458296d6.13.1782831498007; 
 Tue, 30 Jun 2026 07:58:18 -0700 (PDT)
X-Received: by 2002:a05:6214:1c4c:b0:8ef:b2f4:c686 with SMTP id
 6a1803df08f44-8f1bb5188fcmr65457736d6.13.1782831497455; 
 Tue, 30 Jun 2026 07:58:17 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f24723defcsm13424456d6.49.2026.06.30.07.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:58:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:58:05 -0400
From: Peter Xu <peterx@redhat.com>
To: yujun <yujun@kylinos.cn>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix invalid %ud format and trace arg typo
Message-ID: <akPZfTuOc45rOLHU@x1.local>
References: <20260630031324.43453-1-yujun@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630031324.43453-1-yujun@kylinos.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 11:13:24AM +0800, yujun wrote:
> Standard printf has no %ud conversion; glibc treats it as %u followed
> by a literal 'd', so postcopy userfaultfd error messages printed event
> values like "5d" instead of "5".  The same typo existed in two postcopy
> discard trace format strings.
> 
> Also rename the misspelled ram_save_iterate_big_wait() trace argument
> milliconds to milliseconds.
> 
> Fixes: 00fa4fc85b ("postcopy: Allow registering of fd handler")
> Signed-off-by: yujun <yujun@kylinos.cn>

queued, thanks.

-- 
Peter Xu


