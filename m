Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEbFf-0002W1-Iy; Thu, 30 Oct 2025 18:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbFd-0002VY-O0
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbFT-00088u-Nj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761863748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8zIycdbGUB1Bs0Qs6FVJWWP9GldZJEy78Dwszrt0hc0=;
 b=YQCNgb1ZVWnGLSYhDb54bAyEXAUzIObydHOLBqf0avuZ1Dpfbvsi/dXSHpPv082VMY8FqI
 BjCn5oD3WXh50pH8xaJEmaP4qNxXFQqa6YdB/gwKMNLcA7j62rqMCuUN5KpySTAOnrvhZt
 0VpyvE/KDMW9EHO5QA/uqBqhEiSr6lU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Chy-WlN2N9-0fCcHcVdYZg-1; Thu, 30 Oct 2025 18:35:46 -0400
X-MC-Unique: Chy-WlN2N9-0fCcHcVdYZg-1
X-Mimecast-MFC-AGG-ID: Chy-WlN2N9-0fCcHcVdYZg_1761863746
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8801da9d68dso50692546d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761863746; x=1762468546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zIycdbGUB1Bs0Qs6FVJWWP9GldZJEy78Dwszrt0hc0=;
 b=gbK+hLYs76Fzei8YTzJO56Xo+BbAyEfQXUou7HrZMaSaMfuDn4GXyH3F2UkwWFhHFR
 gfk9wITtY8IeVJIsbL+fdEfob+r3Fy2yhQOsaYOXVF6sb1IMObiPn54xfdan9ZBfurSg
 T3oSth1/HVPbYm7JNOO292QTGzuUOS/euv1olXJzgEPG06bkq34CrybQa165ze5LCXpl
 BapHuNVW/XaqT+55h0+xcabEtznOhS7ALSWMK9Ly/FucgckxTZ7OjexbBv/RRXUsMIhP
 mxLsIHswd5PlILcxp3x4HnEOcEGcSEAWG5bq+0vfKc/U8d0wxl0HfIDEA9l/swg+WRwc
 ZWPw==
X-Gm-Message-State: AOJu0YxPsVbyUjHgXJndjBKDxRO9la/if82i2cmBswJEI565pDaN2u5y
 a/c/ucF8ceSDpJAWqwPtBTT1q6AEAZZ6fOaBEAL0Ht8nQ6zTViqxvDQhmSA8epHHnAlBQxC75ov
 iL4F5OwcDK0+pQvY0FJlVXoOZ0ONftEHCi889tX3e+ueAXYYLaDklc5IaBi9c/eu9
X-Gm-Gg: ASbGnctvPaTZqF7MY6+710WQ3/aD6olp7nCftUb5rxoTfIIwITHeYB4tBtZpbH11h/z
 90W14Ec0w7yPorIEr+xNCDh9TpA1IiCiZsyfAOtM6R/SphX/gPvMiL8uLWYJJ5ndIHLdG0/aAhQ
 m2c6u7Vf/h4EBUzuabdoSVoAn+TrYimoGRYBl8rieR8xna35QU0P2WLOKAlPxq2ZIQYt7jAQ8lp
 2seHgHAJPzlaI0/1flp44nrCrvaoPkUK9cbE3OiEE6lBTBCQE4SJknZporN8LC1ZZ5RuioDgl04
 bpQRZtmFpXB77rsP6feKFxecLDezVKoimV4Eh6KLta1z1M3gXR1EnRKdfdc8ofVKqCA=
X-Received: by 2002:a05:620a:448f:b0:891:a6b0:7cda with SMTP id
 af79cd13be357-8ab9b881bc0mr157565885a.81.1761863745613; 
 Thu, 30 Oct 2025 15:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3mgt9KhRc+tiF34Y9/nq1+x5nByQ73wImi/BfC8c/8q5H20PYcwP3a0sJr1GIaFHVFJ82+Q==
X-Received: by 2002:a05:620a:448f:b0:891:a6b0:7cda with SMTP id
 af79cd13be357-8ab9b881bc0mr157563685a.81.1761863745162; 
 Thu, 30 Oct 2025 15:35:45 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f254a297dsm1389167085a.28.2025.10.30.15.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 15:35:44 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:35:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 3/7] migration: Introduce postcopy incoming setup and
 cleanup functions
Message-ID: <aQPoOTbC54KxyaSG@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-4-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030214915.1411860-4-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:49:07PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> After moving postcopy_ram_listen_thread() to postcopy file, this patch
> introduces a pair of functions, postcopy_incoming_setup() and
> postcopy_incoming_cleanup(). These functions encapsulate setup and
> cleanup of all incoming postcopy resources, postcopy-ram and postcopy
> listen thread.
> 
> Furthermore, this patch also renames the postcopy_ram_listen_thread to
> postcopy_listen_thread, as this thread handles not only postcopy-ram,
> but also dirty-bitmaps and in the future it could handle other
> postcopiable devices.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


