Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D441CD6E4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 12:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJWov-0000Sc-Jj; Thu, 13 Nov 2025 07:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJWag-0005Ov-V5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 07:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJWaf-0000FZ-0G
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 07:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763037493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+wKtsihGtyfb2o533vqP/dPk9DpMIcAdq/GK9bvJLs=;
 b=FJ785d0dQhZ29NWRRDrgwnhUxud5DfEz57ejwrJOkepOta354kyVHXOQ/RdHajFQ3bIRl1
 YHwm1BeUEFOwxPmt3SSOQStzJhu7iTy9jBFdEoFlTcFHZgyojsK/oh7dQOZQ/BpM3RKyzq
 N39ZUQ/LcyYG5psZyLR5j7fJaaF7Rd8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-0QWuUVeBMRGvgI4lmmQ7LQ-1; Thu, 13 Nov 2025 07:38:12 -0500
X-MC-Unique: 0QWuUVeBMRGvgI4lmmQ7LQ-1
X-Mimecast-MFC-AGG-ID: 0QWuUVeBMRGvgI4lmmQ7LQ_1763037491
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b733b21a138so126423866b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 04:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763037491; x=1763642291; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l+wKtsihGtyfb2o533vqP/dPk9DpMIcAdq/GK9bvJLs=;
 b=LtDenMaM4P7OTPefSiEFg9TKFjqWk/8MUZB/YXtCKKtXjFKf4bQXvvupkK499MsVbS
 38JdgFfvN7Wq4zrmJDQ012ZFZn57VbEwYRv7w30ZR3fYs8eptVUK1zAiDAYjKq+uPvsq
 INy8fz1d58ErbCbdL8hdkLnaIbOxq0VwOVj3aD/sL5QufV682M7inUw9EXsWQvIm3Teb
 ByfoPR/I7jXqrnTPmUcG0V3U7wS0nxzbod7y6gtjLsWpodAZsXg3Za+rQSbZpKYHE8iJ
 2/tMz6B+8eS4P/aEtPvyh15I4fJaE/tAvIzUzzMs0lRoRPvRcx9Zo0Lx/Ls1mRYKULUC
 AH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763037491; x=1763642291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+wKtsihGtyfb2o533vqP/dPk9DpMIcAdq/GK9bvJLs=;
 b=A6GcBwfsAuijPz63iy8aP9QkRpjxlAyggMh4NC9nXLh6TpDpYwQJu/78VglzddA+vh
 1naUIu8wA14MHztZVVFnZ8CnRFQXwYA+F+S/GrRn5GPfOZPK9n97G0dz2JFZm7aQiwAD
 qIdU3oIJj+vx9bw2v4ya0kNQV70Sm2nZc6fSOTWaihQgxfaHCj5D18Nz4zK/qiKbJSF7
 uSxAL0Us1pBxF+npQSPAlbprg5AF9iFLyOkb5a+n3xSSmqfhCs28ehWkkGNC9uzkFra4
 4EwOBwG/lOgOKyCckvh1Ot2+sEfniwph6I1fQmQN7gId2OWg2pzUXrslXDbLAQ+jZtF7
 75Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9dqF7+XE2q7Sg5kJL3HjzSz1V0X08delzsVx+HKnPHsUvhk6H/b2gr3/MV7nGmqp15+vQnEYWxgB3@nongnu.org
X-Gm-Message-State: AOJu0Yxj7m3FYKFP9vDbsOnvW7Ejep9Iqp2UJGCNbDpTMVKCF3Le30gF
 uscieF0wa++KKQx2SP0TlljT32gSG9AgINuvxrrPgetZ/BsbFIZEcIVBywrnR2TRxF//wvI5w0W
 V8w9RVLZABLrKUvaDuamHpyHXshY66tkcUB0+2Nm+JNoLfxX3Ic5Szgay
X-Gm-Gg: ASbGncs4VABmqSha7brVJPvPLjzS0Xrz5SHQtdk9aPA4ing0C1JGrLknQeiOnPY7AJf
 BEkGpBvz5Jx9gJkLSp/O0Td5FtJMH7QT5ozkfv4WENzCtCWo9MEprjVP9ZVExIPGdGdPYRmWg24
 +M0DEFnu7NnpMNHYu3xddgET90kR1N3qLgRGaTWIjRoYJX2wKcllVJ4EOWAJNBpsLmG7Qgx8avT
 HeNu2yEVFzPtGMgO+eEj5YTFBu0vpKXUoZO+pbeeVQoRNGl/tRiaBA6h/QefQA7d8S1lQQa75H/
 YtsEEYxljvrwImHOPIPTGNxtRImQ1p6wP3fimb4GpHlQXquri/r32XL2Jm517YJJTXvSBydq9Pi
 VRUFX4Q9s84UHCSmjGIGGcvM+98pvaCjFmohVGZU6alGXgZ2AaMc=
X-Received: by 2002:a17:907:7f24:b0:b72:9961:dc04 with SMTP id
 a640c23a62f3a-b73319e3a65mr592442266b.28.1763037491266; 
 Thu, 13 Nov 2025 04:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFExb+6WeCHAURg3unvhF1hhMkQYILCQ4e541GrELZwLE5O0vht7nPn6L6h0igBjxsOIDjqDA==
X-Received: by 2002:a17:907:7f24:b0:b72:9961:dc04 with SMTP id
 a640c23a62f3a-b73319e3a65mr592440366b.28.1763037490821; 
 Thu, 13 Nov 2025 04:38:10 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa81223sm159850666b.4.2025.11.13.04.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 04:38:10 -0800 (PST)
Date: Thu, 13 Nov 2025 13:38:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
Message-ID: <6wyzsqwlnw2tkkhgfcm62tlen2g56noqaxbau3cn734jsasngo@d5pqtkftefvm>
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
 <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
 <66a5228e-1e21-4c59-8538-3475ea3ca768@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <66a5228e-1e21-4c59-8538-3475ea3ca768@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Nov 13, 2025 at 12:56:39PM +0100, David Hildenbrand (Red Hat) wrote:
>On 13.11.25 10:40, Stefano Garzarella wrote:
>>CCing David
>
>Thanks
>
>>
>>On Thu, Nov 13, 2025 at 11:58:42AM +0300, Daniil Tatianin wrote:
>>>Just having a file descriptor is not enough to consider a memory region
>>>public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
>>>writes to this region won't be visible to the vhost-user backend, thus
>>>causing it to read all zeroes or garbage. Make sure we don't pass such
>>>regions and include that to our definition of what a private region is.
>>>
>>
>>Should we add a Fixes tag? Not really as bug fix, but more to make it
>>clear that this is a followup.
>>
>>Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")
>
>I am missing a description of what this problem is fixing.
>
>The thing is that having real MAP_PRIVATE memory in such VM 
>configurations is usually a strong indication that it is a 
>VM-misconfiguration.
>
>E.g., a vhost-user device cannot possibly read/write that memory.
>
>So before we call something a fix (that was spelled out as a TODO), I 
>want to learn more about the valid sue case we have in mind here.

I specified in my comment: "Not really as bug fix, but more to make it
clear that this is a followup.", so I agree it is not a fix. But, IMO 
it's nice to link a follow-up patch to the previous patch that 
introduced the TODO. That said, yeah, maybe the Fixes tag is not the 
right one, but at least I think we should mention that commit.

Stefano


