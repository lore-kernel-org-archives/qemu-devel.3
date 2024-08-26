Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FE3C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicOK-0007LX-1V; Mon, 26 Aug 2024 12:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicOH-0007Cd-NT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicOG-0001Cb-84
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724688982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sW4bDUqC9cgVpxYWlRq8VvtZsFETjITTTcd2iuJa0Tk=;
 b=BYNZiCVua4eLxADjwMIQHhfcJG2RS/oV3tgaKMdF0s51WapQZoZJ/4Q2nVWqOwcbzhFnMf
 Cb0LJokSzAH/3v/mYb+ryn8O4iEH4SGBDxrh61L40hmeo01gxfN2/Y+iZWUsapxXtTtTDG
 9PTaXCScAUE6P6hTBLaF0AgBcWZ5AXg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-4kQIffuKOvu62P_BL4AXbg-1; Mon, 26 Aug 2024 12:16:20 -0400
X-MC-Unique: 4kQIffuKOvu62P_BL4AXbg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a1d108d705so525736585a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688980; x=1725293780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW4bDUqC9cgVpxYWlRq8VvtZsFETjITTTcd2iuJa0Tk=;
 b=YSzJCni53JSKfi2ttWFLifgvZ3PxInUj4SNZrsNrdVvfwie13tegDfWAoEczbR33ig
 ALiDd0pj2d/QP0LfMQd1Yl6meitVb/nDttrn09o6fAFlfbnR9jXZhL4yfyw1tg0CfyTH
 QVzpNTagZlOhrMKBGCe5d80nnKRdpqLLl3d5J5IkJlTRKmz//2WJz0iSR5tr5hI8Bkyr
 u61F645wd8/CWXo9oTGtg5TcZD41uvPPR+8oYQ0mUz/2qFPhxI45iS3F7G/LU499rZnh
 c4AMy72Y0G8ccfmgXGNAIMDyYVLF8rElZn3zfoBMsWwcpKQSb1NnGb4JWIt3l4zjYahF
 4mOQ==
X-Gm-Message-State: AOJu0YylN3Zbe6Rf3yRYocWRhd6aN2idzXAa1NycfsCb12Y4yOf/RXWR
 qPUn+IRDRYEHNzWr+CSZLN7CZ+Mf1USTQpOeP8kybvzLE9oAOLK3IDHigcepnsU9QOyGjXPbFvE
 3nBqIBWC+Zw8V8LRLgZTiy6f3NMCodgVpqSr9o1/pl4c/qYznuAcg
X-Received: by 2002:a05:620a:4002:b0:7a3:49dc:f084 with SMTP id
 af79cd13be357-7a68970d4a1mr1374882985a.35.1724688979981; 
 Mon, 26 Aug 2024 09:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQF6KAyLeHiivpKtdI5r6ToTnPu9LdRSiEOP+87FMQndEeBsv0OFzjzleH6wA7cheA9KdElg==
X-Received: by 2002:a05:620a:4002:b0:7a3:49dc:f084 with SMTP id
 af79cd13be357-7a68970d4a1mr1374879885a.35.1724688979641; 
 Mon, 26 Aug 2024 09:16:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f418814sm467790885a.127.2024.08.26.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:16:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:16:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 16/16] migration/multifd: Move nocomp code into
 multifd-nocomp.c
Message-ID: <ZsyqUbAlipIr0Apd@x1n>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823173911.6712-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 02:39:11PM -0300, Fabiano Rosas wrote:
> In preparation for adding new payload types to multifd, move most of
> the no-compression code into multifd-nocomp.c. Let's try to keep a
> semblance of layering by not mixing general multifd control flow with
> the details of transmitting pages of ram.
> 
> There are still some pieces leftover, namely the p->normal, p->zero,
> etc variables that we use for zero page tracking and the packet
> allocation which is heavily dependent on the ram code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


