Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E9DC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 21:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFJTX-0002PF-W7; Wed, 14 May 2025 17:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFJTV-0002MG-IY
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFJTT-0004Eo-LP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747257430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JjxGDz/ZMZG1oZxZHYRKYYs5/6n/8rLhPLqVcw2z4WI=;
 b=fYIQLR3xJJTSUYZDfSXo1sm4rQGBGv87lNC9GQhmjr3eLHNHcsbnu/sODNRMBbl1/z/aCG
 +dTUuE55fOczUHBDoZzcVKJSG7CKXEmlE6lvqTfN6hw5s9WHWWjw9d+z2uLP82XPkvsOKX
 yC2th/XuFUqQnt7qrMsOq4FgYuWlsJ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-jnJmnfzSNRW_9_cWGVjYhQ-1; Wed, 14 May 2025 17:17:07 -0400
X-MC-Unique: jnJmnfzSNRW_9_cWGVjYhQ-1
X-Mimecast-MFC-AGG-ID: jnJmnfzSNRW_9_cWGVjYhQ_1747257427
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c9305d29abso38205185a.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 14:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747257427; x=1747862227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjxGDz/ZMZG1oZxZHYRKYYs5/6n/8rLhPLqVcw2z4WI=;
 b=Zifoh5FpC6cOL9nw4cQo3rlqAEMGIkMgwoXAC8lDXowEkddSKo6NHYGWdQNou+uaOl
 6uHNXScQy2no+mL01/SHBxn9UKiZeeBduzl+rQ8FOo82If59EbQV8QjuYIRJ0NBMk9Es
 jBh77W/vTyvis4/2k3IKDPw55113ZpTi1OK5Azy9QI4nFsECyK3WpW0wS4Juwp6mcSKw
 N13P7SHDjLWg0ToTi1Kwm3tikMH3eMD8weAJ+vcsnua65Fefii6NisdVCo2aUpINobV4
 aMgS99pETI7k2N/sObmB32d9OHLzjwteF9q3rFbJtx67wYC6M30nS02V6X/uwnWRF0En
 3EZA==
X-Gm-Message-State: AOJu0YxfwLMjYzO4CLuX4GmNwGjXGf88wXPmY3C2FXAKWVR58MrjMhHc
 rEbuw5mu+DNgUhi9Uv5wmKvXu+wZQ35lTeXqD0zo2SrBL9lTj28JCakt+YqqEYSzTcA3xtVTgga
 JzLozkc7o8mM3WOeAXYMfWuGiCAC+/gU1wVrZ72MDhOPUir4ALbdv
X-Gm-Gg: ASbGncvYIZNrfXsErCLs4skf8atk9vy4aTBN/RAoxL221a1FS0jEZzdX3ujXVjB/gxt
 3cVliwk85yN/QKW4bWATFyzfyE+yfBAFQGi4wZ6cP1BHTI1YnXXpa7TAVhLKkmgG5kSIKZ58kSA
 /WRLgArV2CUhoAlnG9SVGRDMccnrgnIIgFpwSsWbeKU1sH5tNO8Asie4TrPeKMZw5zifOxLYGbc
 FfagGVZbF7CrbcUnopiREPzy1kt5EwORopL99PAgKCJ2VN6tBOSqbHNj7DZaNdckDy1/fPc5X5A
 8tw=
X-Received: by 2002:a05:620a:1713:b0:7c0:c3ea:6982 with SMTP id
 af79cd13be357-7cd287e8c91mr764673385a.14.1747257426916; 
 Wed, 14 May 2025 14:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAU+YtOoXRLqJy6LnGGPjmSaZkRv2or0fq1qZTeUCJAPvaz5suJ6b3zz9/Th5QUCRs+VQqXQ==
X-Received: by 2002:a05:620a:1713:b0:7c0:c3ea:6982 with SMTP id
 af79cd13be357-7cd287e8c91mr764669485a.14.1747257426443; 
 Wed, 14 May 2025 14:17:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd076ca10esm784359985a.48.2025.05.14.14.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 14:17:05 -0700 (PDT)
Date: Wed, 14 May 2025 17:17:02 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aCUITicykC-ppJrv@x1.local>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <aCT9QRPd4cDSshGI@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCT9QRPd4cDSshGI@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Wed, May 14, 2025 at 08:29:53PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > A new parameter "-a" is added to "info migrate" to dump all info, while
> > when not specified it only dumps the important ones.  When at it, reorg
> > everything to make it easier to read for human.
> > 
> > The general rule is:
> > 
> >   - Put important things at the top
> >   - Reuse a single line when things are very relevant, hence reducing lines
> >     needed to show the results
> >   - Remove almost useless ones (e.g. "normal_bytes", while we also have
> >     both "page size" and "normal" pages)
> >   - Regroup things, so that related fields will show together
> >   - etc.
> 
> Thanks for the update,
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

Thanks for the quick comments!

> 
> Note that you did miss the change (which would be fine as a follow up)
> where I point out that I think your unit abbreviations are slightly wrong

Ouch, it's in the spam filter... :-( I would have missed that if you didn't
mention it. I would think any decent AI models would do better than this..
I have no idea how this could ever happen in 2025.

> (although I think I was wrong as well...)
> I think your throughput is in Mbps (capital M or Mb/s or Mbit/s) - ie.
> 10^6 bits/second.
> 
> While I think all your KB are KiB not KB (i.e. 2^10 bytes).

True..

Now I've read the missing reply:

https://lore.kernel.org/qemu-devel/aCSXjRCTYKbDf9le@gallifrey/

So yeh, mbps is in unit of bit, but all the rest needs fixing.  How about
below fixup to be squashed (if I won't need to repost for v3):

PS: in the fixup I also did s/psize/pagesize/ to be clear

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 13e93d3c54..ea76f72fa4 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -111,9 +111,9 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 
     if (info->ram) {
         monitor_printf(mon, "RAM info:\n");
-        monitor_printf(mon, "  Throughput (mbps): %0.2f\n",
+        monitor_printf(mon, "  Throughput (Mbps): %0.2f\n",
                        info->ram->mbps);
-        monitor_printf(mon, "  Sizes (KB): psize=%" PRIu64
+        monitor_printf(mon, "  Sizes (KiB): pagesize=%" PRIu64
                        ", total=%" PRIu64 "\n",
                        info->ram->page_size >> 10,
                        info->ram->total >> 10);

-- 
Peter Xu


