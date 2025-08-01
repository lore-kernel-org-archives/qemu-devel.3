Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A4DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpbG-00058V-5U; Fri, 01 Aug 2025 09:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhp5r-0003An-NG
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhp5m-0007P4-Gw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754052152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xL3X+MEd7mhNa3yYh8u9N6/AEtSG2cndEGh8Gq1Bbg=;
 b=hZ6yPAws4vZOA/ZoIJIj9blAO77A96ckWHCsW2yHUkhPikaZDhYWMapvNnj8MQqegHJE3W
 HozNA1QK91o8gz2UFKBJ02rPl8/OcZ1NgtRdgzA5hIyUw0VaPAplkedYvkvvD1IWNIPS5Z
 g82l91YiwaxvFSIumRhJc1MaGBE3uE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-gGjI--RuNpqm7mh3TU5h9g-1; Fri, 01 Aug 2025 08:42:30 -0400
X-MC-Unique: gGjI--RuNpqm7mh3TU5h9g-1
X-Mimecast-MFC-AGG-ID: gGjI--RuNpqm7mh3TU5h9g_1754052150
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-456175dba68so5654225e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 05:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754052149; x=1754656949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xL3X+MEd7mhNa3yYh8u9N6/AEtSG2cndEGh8Gq1Bbg=;
 b=fpbRzZQNf7oQ/rDaMTQyEiScCDvlRS/qdYZ7NDIH3Mb5z1a73I9bnfZQBnWX4dAybZ
 7CS1LsKM5SLiAQSdU2TQDhGwWcMxEip62FGZwL9DJeA/wC9Tk5cPDUoUAMgHvDhcTmam
 TF0t7iWfx6J+Mt77n68xO7LsJm9Gc/jtd1IzXaPwVk60TB0ksjTjsrTS3cTYvsnQP44o
 d7OnI5OL3nmeNqOedPih3tyvqL70pNZEX4eXGodsR6bRvlYD2LQ8EwSiU3ORnAxQBswr
 RVY0cygs/C/9L7JZa2d41G2eAagcuLqsgvKv9dZSVNQhN+EYJ52tWdB2yvOJMy/Z95ZT
 OkCg==
X-Gm-Message-State: AOJu0YxjNu3F897Bp1GsrQjBIeS41g2SrKEKLNvdpoBDgmROY1GS6Nvb
 3YuI9PF3TgdV3g8FIuzEeEyDitfdP3EtzHXLlzEUlg3M5UPXOVsHmHH4cl5k+qDs9YJiUa6PizX
 Km3gKXCG/z11GIhS8InX2jVe1LHSwdltNGV5LZxDOh1MFTCWuI8iRlnGx
X-Gm-Gg: ASbGncvWEgVO1pRbDSlbPkQ9KHdOETcq9I0k3nGZx+p9ycO93hUX/nMlwtex5Rg1Kpl
 nofqaM0GF0H89glU3yqApzFGbmMTUW7qEX922PNq3BsnJrjOa2+x+YK7hIBKAP3YVcgItTRi5vL
 X/e56BqYXSMRO6Idr+TZSU4WKQNAZkAV/uYtlMT5fniWR56TF3NHG3mqZ45Chojl7bzjkArmTVi
 dB4XEzmk8lkjjxIj+XP7mHFaSBobxzGrhmHrTCfjxZuCiIAvi7A+CtWg3Hw4e3EdIF0LTMqQuab
 GZZdixeM9T3hQv/TOX2lc7dQwC/hDA==
X-Received: by 2002:a05:600c:6989:b0:456:2419:dc05 with SMTP id
 5b1f17b1804b1-45892b9da97mr121768895e9.12.1754052149108; 
 Fri, 01 Aug 2025 05:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvRK3PpgkwBQmqYvhQQSFJdnyCQJfqJ55eNJuIbZJrXplZJWKJrnXDn1maMLpEhlrnbbcvug==
X-Received: by 2002:a05:600c:6989:b0:456:2419:dc05 with SMTP id
 5b1f17b1804b1-45892b9da97mr121768655e9.12.1754052148718; 
 Fri, 01 Aug 2025 05:42:28 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm5929006f8f.24.2025.08.01.05.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 05:42:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:42:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/6] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250801144226.3063e700@fedora>
In-Reply-To: <aIqTCITI84BNtWnp@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-2-imammedo@redhat.com>
 <aIqTCITI84BNtWnp@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 30 Jul 2025 17:47:52 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 30, 2025 at 02:39:29PM +0200, Igor Mammedov wrote:
> > diff --git a/system/memory.c b/system/memory.c
> > index 5646547940..9a5a262112 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2546,6 +2546,12 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
> >      }
> >  }
> >  
> > +void memory_region_enable_lockless_io(MemoryRegion *mr)
> > +{
> > +    mr->lockless_io = true;

    /*                                                                                                                                       
     * reentrancy_guard has per device scope, that when enabled                                                                              
     * will effectively prevent concurrent access to device's IO                                                                             
     * MemoryRegion(s) by not calling accessor callback.                                                                                     
     *                                                                                                                                       
     * Turn it off for lock-less IO enabled devices, to allow                                                                                
     * concurrent IO.                                                                                                                        
     * TODO: remove this when reentrancy_guard becomes per transaction.          
     */  

would something like this be sufficient?

> > +    mr->disable_reentrancy_guard = true;  
> 
> IIUC this is needed only because the re-entrancy guard is not
> per-transaction but per-device, am I right?
> 
> Maybe some comment would be nice here to explain how mmio concurrency could
> affect this.  If my above comment is correct, it could also be a TODO so we
> could re-enable this when it is per-transaction (even though I don't know
> whether it's easy / useful to do..).
> 
> Thanks,
> 


