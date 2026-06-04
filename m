Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B67CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Cu-0007hW-Cd; Thu, 04 Jun 2026 09:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8Cp-0007dx-SB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8Cn-0003JA-8I
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADLp4iRNryFqfFW/AbqAfGRCUJLsMNEU7SrJtRQKkj4=;
 b=SRQjUe/OSWZkXqCEkx7jeZRz7z0pdywDMeWqp02WGnpwQwQPXO5WvXhB7fXAQHJmK/Xg6a
 HtC+cngveHLHNqs6mkS+0bt8vDKeGDy1Uk86R1Zn/+FToTVnTjWjmSV4gkVA9tJ7QQYZcv
 Ylb3zGQJUKffRXBYvXjIl62ZIC3t6go=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-MIzkQq03Ob-LX4ThbrI2xw-1; Thu, 04 Jun 2026 09:33:48 -0400
X-MC-Unique: MIzkQq03Ob-LX4ThbrI2xw-1
X-Mimecast-MFC-AGG-ID: MIzkQq03Ob-LX4ThbrI2xw_1780580028
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccd5491db4so5553616d6.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780580028; x=1781184828; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ADLp4iRNryFqfFW/AbqAfGRCUJLsMNEU7SrJtRQKkj4=;
 b=KmFD0mXVm5JhcEUI1JGp08ycvHZDgqtuI22dW9CYSM7MJ688rCw66vIy04uQw5peRj
 8E6Qvr+ADipO7b+TeWno/2jtbm/MHeTY3IGiCsv4nlnZ1AJDsEc1CZG9P5+2FYEN5YyO
 x3pkhavgUcDVlkWucOn6uBkaiRFDMq5tlkYDtlIiCGzuaUVKTJz5xcdDy2Vvd0Ky6+2A
 He3x9gOfN+AdnLzw1sq6JTXvzkYCcnU/EYVthHtyd1fRdQ5W+J+1IiLBxiqxDO7CjMBh
 C0OoHt2NEugcBmG/+VcvfXF6Wb7JDWRwYXSbMNvR+WRnEwA0jN1DGOfHB6zxQgKiCQti
 pjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780580028; x=1781184828;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADLp4iRNryFqfFW/AbqAfGRCUJLsMNEU7SrJtRQKkj4=;
 b=Z/Ocogc3G27nI3jzyww530b794TVQWzeHLuDxfLMG3v5tdBW4XuLVG+lH51RNqOCRv
 FAerA9bFMHrgSehUrv4AMsPZkzWAAiq0cQeun4bZxUQrSl92fTbCbJom2ye9lFWyj0Re
 P1sg0uk0/Jrgu04lI69bBese6nYxwVBoZT57eVkU+qaleeBtNyYgUbhTHxPLNDF91u+5
 jYl/oTLzvKtSM/krsMhWWVDxqtLKI9vq8q0MknCK1lTKO9VBKGlWKb4Pi2h1v00af0Mo
 8CpDqfQJ7BPi/OkehUMoxfT7bieMYdZ4vfnaIMeJACjTGEWcVHilendpFPItNLkqzCvc
 ErHA==
X-Gm-Message-State: AOJu0Yxhi9veBEDksu9YpK4rFSGwMTowbcy4srsZM8OTSoE3keEjB1Io
 w2HNvfjjTGEozSDwe0TXW+IiOuZd2WqeAxX472EodbuQFkSu5AU4uwkmJT8uw2rxqnqjBMWbY2B
 VKQFtSCBajfiKr8lPBUA+ipfuDbyO1l9hHnrHf5pIGULDIO6YnY8LPHoj
X-Gm-Gg: Acq92OG2uF8uMIHHw8eQXgbruQBFeKTUIWE2ZddNKWWe3B0QI9D0aZT9X0sQtyp5+o+
 kvfPTW49nuUKv4o25IPsf3RQxKTtrBH8p+MRoiNDHDcWRGNclDGHnwN4BKZoBvEd8SjNGw0OpQJ
 Op1nsbnUZMbgzcRd2cq8cIBVom9M5bfr1YyNE33f9k/AmBJmlbAq4tV50aCog1lVgalHdcB1bGt
 /ByE8KjybEm8uxYNgZmwKgx7qgbw7lZmbXvTFBUTfcXBozGQzxnla7fOvl6q7ModyhuSVl5VFht
 cVUIUn/bJHEi4pmMSBtMPUTEFvWEnSqy5AtSLn6K5jPOftw+IBFR4QK8wz5BCFwwuPyx7YMUKDf
 rscIGIv1s3KZ61FhpxrD8LzKf2Q==
X-Received: by 2002:a05:6214:540b:b0:8cd:b80e:6157 with SMTP id
 6a1803df08f44-8cecdc2ddf8mr115414316d6.14.1780580027307; 
 Thu, 04 Jun 2026 06:33:47 -0700 (PDT)
X-Received: by 2002:a05:6214:540b:b0:8cd:b80e:6157 with SMTP id
 6a1803df08f44-8cecdc2ddf8mr115413586d6.14.1780580026679; 
 Thu, 04 Jun 2026 06:33:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd06b231sm52923666d6.33.2026.06.04.06.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:33:46 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:33:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
Message-ID: <aiF-uS5MoQfjyY2d@x1.local>
References: <20260601205900.1067714-1-peterx@redhat.com>
 <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
 <ah80T6aIns82fspH@x1.local>
 <622da0a8-8101-4816-bf20-b5c3c9547a5f@rsg.ci.i.u-tokyo.ac.jp>
 <aiBl-hXpmXc8ULSJ@x1.local>
 <8eadb481-6d3a-459e-9db8-a9cca13d1cf4@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eadb481-6d3a-459e-9db8-a9cca13d1cf4@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 02:24:07PM +0900, Akihiko Odaki wrote:
> On 2026/06/04 2:35, Peter Xu wrote:
> > On Wed, Jun 03, 2026 at 02:11:44PM +0900, Akihiko Odaki wrote:
> > > qemu_get_ram_block() may set mru_block during the grace period. Once
> > > mru_block is set, RCU readers can still access the ramblock, even if the
> > > block is no longer visible in ram_list.
> > 
> > True..
> > 
> > > 
> > > When enriching the comment in reclaim_ramblock_prepare(), I think the phrase
> > > “the last reader that can access this ramblock is gone” could be improved.
> > > What matters here is that the last reader that could find the block in
> > > ram_list is gone. The block is no longer visible in ram_list to any later
> > > reader, and clearing the cache at that point ensures that it is no longer
> > > visible through an mru_block cache hit either.
> > 
> > Yes that's ambiguous.
> > 
> > I updated comments in this patch, removed the 1st reset of mru_block, and
> > when at it also touched up the comment in qemu_get_ram_block(), let me know
> > if there's further comments before repost.
> 
> It looks good. You may repost it with my Reviewed-by added:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thanks.

-- 
Peter Xu


