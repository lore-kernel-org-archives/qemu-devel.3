Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46821CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1hz-0002yD-Fh; Mon, 17 Nov 2025 11:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL1hm-0002w8-G7
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL1hj-0001tU-E9
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763395425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixnBnEDcyhqGSjIqb8oaUVlj1aWiU/ebISr+Uks4CUQ=;
 b=Nws01TuV041LbYvUNjaDj6/+nIicpk0FDRIF9Gidps4Ff55sCU4zmF78qJuLOWhlTdfkIk
 3a877QHXba8/01WWCBLOYWbDH7kWO5JljItkC1gXEMCu0g/BfhO1h9pHPtbP5zeLXs/DWB
 Zl3sgVSrttyXdOBBu2RCQCv2ZrcDK1s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-l5yc4cegP3WiDzaYA4141w-1; Mon, 17 Nov 2025 11:03:44 -0500
X-MC-Unique: l5yc4cegP3WiDzaYA4141w-1
X-Mimecast-MFC-AGG-ID: l5yc4cegP3WiDzaYA4141w_1763395423
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2e19c8558so575962285a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763395423; x=1764000223; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ixnBnEDcyhqGSjIqb8oaUVlj1aWiU/ebISr+Uks4CUQ=;
 b=n/BvAGoYxcqM1Mbo3NmDPSBbYx13JKF8XG4Y6kgdJlMQ36a67H7BC94v2OJQR83vXX
 zs5hSpDwEoxR4Ti8rtBpWtFzN/EQRy+VpR7gsLQzDvbHiBqzwnT8lSCQcV7EGnaxRCPt
 nosD3NTyePl4FGGbi995VP+jwE69zhi3v5kRY5ohaHp9uCyxeO5bWmmx0d70JUANTM9s
 Szaez7teVmn8DVyILRyWEwDffViZXLe004jvkI+7H4JTz4xAtx2V3FonewhSrLt68DxX
 G9ZYCKVjR/PL/1Rv4H/3z/HwT3yv4/90u1UHZCHMLQ5d2HckCbLdBwiza3u0mPByFbaH
 2YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763395423; x=1764000223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixnBnEDcyhqGSjIqb8oaUVlj1aWiU/ebISr+Uks4CUQ=;
 b=RAeuA4YXQzix9P1ZHG/+41ZK6Jsbpq9QuHxRM01reO52PBRQKhO2uHASW5TytdFTd4
 2ZcY+sX6zsCj4bdk+T62CuFy2JNbOWmK2JjCv3D0grpCQ+oLwPI2wEvTGS2hJCcuJ9ZG
 y5dvtFMfqkgppfOyyFs3Ql9d+LfSRDHp2G34p5HLMPHe6BeozWuUJlx2eD1GhMIu9gHe
 twTersbtMyZYv0ylCRTROUknjg+X9RniyY2udK6ospV1GSlKzjIinANUpJxDV8G0q0nM
 EkMFf6hFKRY/HufGoiuWZtHV9mvRxt+kO5xwaQ334LqiUJG7hz0/mTBUAAvnJCBK7vZr
 UJOA==
X-Gm-Message-State: AOJu0YxpHtpdV4YnfQhInoR6prBkT1MjeHVqzzw6Q+Yts27wuuZLZpU4
 3p90x5Cg2QcUdU8m7WKhq0fQ0ywwvldrBpBr8vi8xYCCUAmvDuJrECHifIx06Qwhfu5acJKFQZe
 RL5FExSGZjAKeBMsce8ofBGltINegcqqkkgktZKvkIPKVQyKd9MS0Zyhk
X-Gm-Gg: ASbGncs+uabvkBmSa1bNjwz9nrKs4QqYZjDQbqv24IxJX+TZh3xa1F3aKrIYXkzXsL6
 DO/0EctIiEW33cPX9YDCWwG9thMgXNCEmULhHHninbSefQc/0i4dJkwBEtd8DFR7NLaEQBwDeag
 YoB9XTONui8EiXBfQwX2n1+bHjYj64Rqf0AThT9zecrCV7tyQZZIB+VZdNcUz8D7p0zzXqyb+xZ
 DyfXj86EKBom8dE99urCpKwgEwx222AHae+tikUo+GMAyZBYT2ONo15sSCvOrqRUBoIhPGEgcNe
 Hep31DPmZ7MivZN9Xm+zH7aSDPHtb+gCOtUbjIXukLAetvd6z2GcQBJwkkWnpxhRj9clD5vYTki
 ZGA==
X-Received: by 2002:a05:620a:462c:b0:8b2:6b9e:5383 with SMTP id
 af79cd13be357-8b2c31db7cdmr1864288685a.85.1763395421976; 
 Mon, 17 Nov 2025 08:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlUy0eCOG8prl7p4TzxmqndLVgjsS9Gj2h75HogZmugPzfW6bnW7IxOSlzqWwC2YS1ydZ7og==
X-Received: by 2002:a05:620a:462c:b0:8b2:6b9e:5383 with SMTP id
 af79cd13be357-8b2c31db7cdmr1864277885a.85.1763395421294; 
 Mon, 17 Nov 2025 08:03:41 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af044e3asm995848385a.41.2025.11.17.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:03:40 -0800 (PST)
Date: Mon, 17 Nov 2025 11:03:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251115083500.2753895-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Nov 15, 2025 at 09:34:57AM +0100, Markus Armbruster wrote:
> Maintainers decide what to take for 10.2, if anything.
> 
> Let me know if you'd prefer the "perhaps should take ownership" idea
> in PATCH 1's commit message.

I recall I had such patch previously, so I digged it out:

https://lore.kernel.org/all/20230705163502.331007-3-peterx@redhat.com/

I found that I dropped it in v3's post of that series, where I mentioned in
the change log that either way is not clean, so I dropped that until I
could have a better understanding:

https://lore.kernel.org/all/20231004220240.167175-1-peterx@redhat.com/

I think at that time I should have hit an use case where the caller forgot
to error_copy(), hence passing it in causing an UAF.  Then I thought memory
leak was better in error path comparing to UAF if the API was used wrong
either way.

But feel free to share your thoughts.  We can definitely revisit this.

I queued the series for this release, thanks Markus.

> 
> Markus Armbruster (3):
>   migration: Plug memory leaks after migrate_set_error()
>   migration: Use warn_reportf_err() where appropriate
>   migration/postcopy-ram: Improve error reporting after loadvm failure
> 
>  migration/cpr-exec.c     |  3 ++-
>  migration/multifd.c      |  6 ++++--
>  migration/postcopy-ram.c | 17 ++++++++---------
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> -- 
> 2.49.0
> 
> 

-- 
Peter Xu


