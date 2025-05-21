Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF569C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHk32-0006eh-Jq; Wed, 21 May 2025 10:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHk2x-0006do-Gg
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHk2v-0007yJ-D9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747836227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nj3Cr5O7+VIr+S/NpyOCvDyye8CJ1wdlT0fpt/PGmQY=;
 b=gTsm1euZs+65BIpzNzlZv6DFh53b3IsavBaS/awn7wmsgPhrt3WjakGeDKTBrAnMfbK8fl
 c04jZh7RoNFmxGmq/WMDpFX0LzUOANtHBzyyChlBGgXy/yV5aSMnNJKWP2i5booQeBd0G9
 C4u9UxCsxcVpNrgd0YcFFViQkfx7UhQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-DzGXMM7vMG2I8ons5PEpjg-1; Wed, 21 May 2025 10:03:46 -0400
X-MC-Unique: DzGXMM7vMG2I8ons5PEpjg-1
X-Mimecast-MFC-AGG-ID: DzGXMM7vMG2I8ons5PEpjg_1747836226
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f2b50a75d8so96728996d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747836226; x=1748441026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nj3Cr5O7+VIr+S/NpyOCvDyye8CJ1wdlT0fpt/PGmQY=;
 b=HoPa5qs499FRYcsoOixmjFXy97p1VJRPx4KYsxwuU7zGhliEKxsshRnTms1tPcoP0x
 tSFOuvfvG7YNODSHZUdFDrGWXQB7VikVLvAxPkGRZNVkQHBh9oaUWafzhEdBEul0mSfC
 r5c9sWOiRb9UFr/LIteeDMv6qHsraewgrh1c6QeaVAhzWQUFS9FOz6VmYArnlhELCyw8
 FYqwiNjlWZ43cXE/3Juay6DCkFYlmkq3Q5fCmY4VWLcPtrE1e+heGwRU1W1ysMQqDGeK
 npGUnApLVz/tIpUM2AyrjbwXdn1l6eXp9uoa0ZeQQPD0Z0MmdxKD9ZW9y6mC6ukxrCgN
 MwLg==
X-Gm-Message-State: AOJu0Yzxzm0cEbX+4Pp6CncsIXsMoEW3eIzXVKtqqr/iT5ELiU+zgLkn
 mvFK4mGKYjqMqUlIy3QvsotIL0Q74RUp2nnzpDishCcv+YTbOZmjIFgvezia4uDJaVcwBmaq7OI
 UQTb1h9c4OkQWBXqiOTUMmre2CnYox7E6seC4F6WAA04U9nsn5CqDt5JynrvWv0TW
X-Gm-Gg: ASbGncvHKqMJ93L+AkQLmcBYjdbV2YH6m/1Dq2dtE46diWTDMdpqKHdpvp08S84Gh2q
 9xaJttwZj4f2lWT8FRwvy6WSZLfRyj6QYfAJfpo6YB3E6PwwNAfGxmz/2jx8lSYbW5LkWxoTwuz
 1kWKb9Fl74IZkVj1n1Af+xxhoU2TC8dkQSZmEGv6a/xJAVCVnymR6r0s6fRm+57HIJRybIn5m0Q
 IkPnGq9v7nYLrw5WK1FH1pfAPOidKfnBDjDk3t1XQoHxhVCOh2XfjnMKobr5CNZHKnfObVPjV4p
 shc=
X-Received: by 2002:a05:6830:6513:b0:72b:81df:caf9 with SMTP id
 46e09a7af769-734f987df08mr16457516a34.8.1747836214540; 
 Wed, 21 May 2025 07:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRaMkAyrIIiH7U2oQJ5mxJycDYPP5qqlhktBrhlgWTs1xui1tiCsLCti/u/efD9UKdEoNcAg==
X-Received: by 2002:a05:620a:448f:b0:7c9:245f:bacd with SMTP id
 af79cd13be357-7cd47fef380mr3033728285a.58.1747836202183; 
 Wed, 21 May 2025 07:03:22 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bde34sm887633585a.8.2025.05.21.07.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 07:03:21 -0700 (PDT)
Date: Wed, 21 May 2025 10:03:18 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aC3dJvwXK9eW1YO6@x1.local>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

On Wed, May 21, 2025 at 08:43:37AM +0000, Zhijian Li (Fujitsu) wrote:
[...]
> > After this change, sample output (default, no "-a" specified):
> > 
> >    Status: postcopy-active
> >    Time (ms): total=40504, setup=14, down=145
> >    RAM info:
> >      Bandwidth (mbps): 6102.65
> >      Sizes (KB): psize=4, total=16777992
> >        transferred=37673019, remain=2136404,
> >        precopy=3, multifd=26108780, postcopy=11563855
> >      Pages: normal=9394288, zero=600672, rate_per_sec=185875
> >      Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078
> 
> (Feel free to ignore my comment if you have reached a consensus.)
> 
> Putting multiple fields in one line is a true need for human reading?

It definitely helps me but I agree that can be subjective.  So I'm happy to
collect opinions.

So my above layout was trying to leverage more on screens where width is
bigger than the height (which is pretty much the default).

> I don't have confident to reorg them so I feed this request to the AI,
> he suggested something like this:
> 
> Migration Status:
>    Status: completed
> 
> Time Statistics:
>    Setup: 15 ms
>    Downtime: 76 ms
>    Total: 122952 ms
> RAM Transfer:
>    Throughput: 8717.68 mbps
>    Page Size: 4 KB
>    Transferred:
>      Total: 130825923 KB
>      Precopied: 15 KB
>      Postcopied: 13691151 KB
>      Multifd: 117134260 KB
>    Remaining: 0 KB
>    Total RAM: 16777992 KB
> Page Statistics:
>    Normal Pages: 32622225
>    Zero Pages: 0
>    Duplicate Pages: 997263
>    Transfer Page Rate: 169431
>    Dirty Page Rate: 1234
>    Dirty Syncs: 10

I would trust you more than the AI, so feel free to share your opinion next
time (which won't hurt if it was a result of AI discussions, but only which
you agreed on :).

It's already in a pull, let's revisit whenever necessary.  Thanks for the
input!

-- 
Peter Xu


