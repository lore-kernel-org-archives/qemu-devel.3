Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE2BEDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUt0-0000LH-AL; Tue, 03 Mar 2026 13:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUsy-0000L1-Kr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUsw-0000aD-8A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+GbHr/Dtjk90aNlY560J5m1qVfPsZuDMczJqN+2Qfc=;
 b=LlQC8I07FKCA1QDOGHd+MR8YBAuG2nu4NyhVssqujofvZ9wwEDt5nZCIv2liJ3r6iXRVgA
 pzUU1SfejDuwdYlFg7vabdVzj2TJi5lEksrJic8IDAQleBOZMPe4BJCmQ5SxekCFHd/3Zf
 Qrqqwj1WHTuJ2sUKtxsMmgflv7ZQlnk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-p1k__TcnP6Kv-j5aqQxkGw-1; Tue, 03 Mar 2026 13:54:18 -0500
X-MC-Unique: p1k__TcnP6Kv-j5aqQxkGw-1
X-Mimecast-MFC-AGG-ID: p1k__TcnP6Kv-j5aqQxkGw_1772564058
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899f92be718so66759006d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564058; x=1773168858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8+GbHr/Dtjk90aNlY560J5m1qVfPsZuDMczJqN+2Qfc=;
 b=snqF7QlV7XfpbjuLXbqO84Y3aiQOhGS6+Qmr8xV6EfaODEZduI72eLjkY2RHxbQuC4
 9/DlbKqrru1oZMyU23VJ8gfEop2Oe4Idx4GKkFTL4IuDLskzqNaKseZSwpnhGj3oTDfs
 Hb/LAB/Dsk+keiV+pH+6iqdSf+mLbNGfa50kfsTGy2KCiTtKGdMFfy3JfAksaI99CmuW
 peT+c8ABZCjaxPGchUFHY/+0vafmDTCoKlj0r0j84IgwlYzSXHQRoRhAWN/cjkSqI4cs
 FJLLeXWX96fubuollZjy5aXwOO9cEfzHODzMrpJRiOPizPbI8HvP68yHcBb8trIqegzj
 qKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564058; x=1773168858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+GbHr/Dtjk90aNlY560J5m1qVfPsZuDMczJqN+2Qfc=;
 b=c78Na+0IYVjLyeyaHe+Hmti1LiiMEFROBltKsd2AkVAIYucGo4DSC9SHzMo0J3Srlv
 /VXqEo964Tiy++OMfV7IREYeliS9k1acfEPpLadpiOc7Eaop3OHBnH/H5aDgHw6u9c2P
 FrEfuv1vLeI7Ar7dT8lZQ5NIsK+m0tacpOcVuX2F9lCcHKlifUdbdwQlNtDTBbhwRGYX
 rhTvjNZWD8fXMD0DsD6FD3rgml+vs/W/RciFR2USvMGDxOk/9Rd3ee80RaXoiPJM0UcJ
 W+FgNI7pxR/geSQrb4+NP2xUzT5F4axmvMxDygQxR7OdBxngyNfeDPKWyFGlofIjVBx+
 1YqQ==
X-Gm-Message-State: AOJu0Yz+pBWZH1zkSaGF/LaDh4MKTIBouF2Ou4A2mpnV99VR24w/FJDg
 Ub26MeqWcrnavZa9zYcCZjqGY3/QRNlr2FmObPzdL5JpFGl/a5AEQOLmXn8F4GcX58O18oA2udG
 mYnpbhbICjLTO1UB+KZ57GFrAhuTpn88sb1RUcMJSxNfhVIU0CION1QsW
X-Gm-Gg: ATEYQzzSaPkHJuA/nHsahCY9H4I27liwSN84nx/48DV1uY71o21Rq/iCqlu7YYGGUlJ
 +kzrdybQsASmGH6vf20UMBAXfq13HVP9SQ/gTX3myzJ2KWUyZn4ENgBTBnP0vkArflE0NWqRGQk
 sQSZA6qKTlT5WfVZ+fCfOxWFu5RvrLfpSwCNSGiKXfn5CtEId25PwWBN+/lBngMha0sddx3PF6q
 gzlSwh16tEfebeZNCIYeDLGWll7cKQP6uNa0pFDNTrwnnr3VOhREsK3gvi49gPc+rZrmDAylpEP
 WcmcV5rU81CVz+22GAVHVubqSotdJTaWUUQDssuAUhPDKoM6RNjpAK+/XbEBRrQWKJboUTyaS6G
 DUGpw0Mqn+1xBiw==
X-Received: by 2002:a05:6214:c67:b0:89a:13a5:779c with SMTP id
 6a1803df08f44-89a13a579bamr25673936d6.21.1772564058377; 
 Tue, 03 Mar 2026 10:54:18 -0800 (PST)
X-Received: by 2002:a05:6214:c67:b0:89a:13a5:779c with SMTP id
 6a1803df08f44-89a13a579bamr25673586d6.21.1772564057899; 
 Tue, 03 Mar 2026 10:54:17 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eb243176sm75152986d6.43.2026.03.03.10.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:54:17 -0800 (PST)
Date: Tue, 3 Mar 2026 13:54:06 -0500
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [RFC 2/2] cpr: use hashtable for cpr fds
Message-ID: <aacuTpoMucQ1wrUN@x1.local>
References: <20260225113620.76926-1-hongmianquan@bytedance.com>
 <20260225113620.76926-2-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225113620.76926-2-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Mianquan,

On Wed, Feb 25, 2026 at 07:36:20PM +0800, hongmianquan wrote:
> Use a hashtable to store cpr fds to reduce the time
> consumption of `cpr_find_fd` in scenarios with a large
> number of fds, which relies on the migration support for
> GHashTable implemented earlier.

A few things to mention.

Firstly, please remember to copy reviewers on the CPR side when you change
something for CPR, especially the ABI:

$ ./scripts/get_maintainer.pl -f migration/cpr.c 
Peter Xu <peterx@redhat.com> (reviewer:CheckPoint and Re...)
Fabiano Rosas <farosas@suse.de> (reviewer:CheckPoint and Re...)
Mark Kanda <mark.kanda@oracle.com> (reviewer:CheckPoint and Re...)
Ben Chaney <bchaney@akamai.com> (reviewer:CheckPoint and Re...)
qemu-devel@nongnu.org (open list:All patches CC here)

Then, please attach a cover letter if you have more than one patch in a
series, including information to introduce your series.  That should
include some explanation on why the lookup can be slow and how slow it is.
It should also cover how it improves after the change.

Regarding to "change it to hash" side of thing, it looks fine, but could
you explain why do you need to migrate a hash?  Can you still migrate as a
list, then reconstruct that into a hash?  It's fine if we want to provide
an API to migrate a hash, but I want to make sure it's required.  Also I
want to see if it's a must to change the ABI.

Thanks,

-- 
Peter Xu


