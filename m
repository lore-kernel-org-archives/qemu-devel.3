Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2819C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVGO-0006Gm-Jf; Mon, 10 Aug 2026 15:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtVGE-0006EN-0C
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtVGC-0004DI-GL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786388527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHFKJHN+Xq2dSc3ZMPQ5wy9jmRtgzNaGe3ZsiNbk41s=;
 b=b5rcBtflhk5AXGI+hRszcEF3JCYVgnciwRQYixKlqN60yEbX+6eK1/K1sBiIFywRHS89f9
 suSGx5fgXH0d5Kr2fAuQvF/0MbKHj0n09qZ3GdR28VoPmElCGaDoUqHk74LwEXiact+0eM
 lCsrTrrPdodDSoChkcpYKY52s3nBvfw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6sMolV_CPl2GFuo_fx7v2g-1; Mon, 10 Aug 2026 15:02:05 -0400
X-MC-Unique: 6sMolV_CPl2GFuo_fx7v2g-1
X-Mimecast-MFC-AGG-ID: 6sMolV_CPl2GFuo_fx7v2g_1786388525
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec3146553so367613085a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786388525; x=1786993325; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fHFKJHN+Xq2dSc3ZMPQ5wy9jmRtgzNaGe3ZsiNbk41s=;
 b=OGdaY6d6CgpnKYSoRjt7unJ9wZP7OXj/DSe4pUjgALWOrCbRsIS7kLIykM5YspoqFD
 hlb6iQjUijIuj9NY6uwigVElIs08LvZCyAE14V1W489L8RP9N9ijSLACGzf7FXANlh8L
 MR+nx4SA/qnX5K8bIQ6h0JiQhIDcN58UsU9vC25dCas/yOPilVL/OPiHRm/2zWk1meTT
 U+N+yO8aa+oZo9QheXsIVhZ0ZRF8/I210IN0Yb303/D1wW22mMX5AbCsnr8QZks2jwkC
 IaiyKygrlokfNsKJQ8v86dc555vfSf/p8Dd4t6dJ7R9F7wotBlGofsxNgs536looWwap
 +Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786388525; x=1786993325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHFKJHN+Xq2dSc3ZMPQ5wy9jmRtgzNaGe3ZsiNbk41s=;
 b=aJ8LQ/RCCMq5f6qA4MY3wQpo+btHsM844tW/idg5XsvZI1vYmHxDAsXUex9jZYNKtt
 8WNrzoWBilbcZ+nzzZwtEaRJCfH+kmmRqzBHDTIaZQwrAM6WMoSJVL2XFs+GzBRegwyH
 58xYdhFFzqI3qvELemUBlYvKAAkoURleeeYUekDTfwwsu5z2iGCyrwdrh2j6VBDtob70
 k4QS8BBEpa16RngIaUvewNs+oy1BzxpRrnn9cjwLDZpPJRkDdz+HhN5UgfZ4SocfFn5L
 7lwxj4mRUn4QQB83pHpu/qCiWd7HFEAZc1fvXONMgqYOeuqQ78OcIGqHkUwVH968UbQ7
 t1rQ==
X-Gm-Message-State: AOJu0Yy+BsikasGfO5siuYrG7TFdiQXCsywQmUILvMgGjD2nMApzZj3c
 JjrTZRkgmWYW7aSv0QJR17//fwa9e7H9AZyptjFJB3RW8alwpjOOjIo6yn3UFcjmrY8AOlOs9yJ
 JOqeN+zuVtPxCTZfCU3EFvx/32cpl9LQSQBa+iHcNWzlLKgpBYih2qs1D
X-Gm-Gg: AR+sD125J8AajJHJ6+vYRl1I00EdZ2vGiLTFlcqG9loxpzMlGwjBvxQGq7I9wLERait
 sRz98Y9MsKcvOEEkDEghfGSB0flJY+zcZ99lPApr+ksUfV3vwkMP6ra2mje/k3fAYjcM5LSwonV
 g/wlOAJXj2XDrwEDdMR1JpzPWSdzRvR0ii+JvTSiVRbT0QeykLyQ9LF8s81CyLLzWVYjEt+HWvI
 dVb4HpzCvfbDU709V3nWFKVfxbDPITTkyVVcL6Qcl3hQwbpcxCzkaiBMA+mEqrqMuEri28OTXN2
 8zbvc//8tyOfQ9JkppEAMwHB9DhXGiy0usNYwgeu1W19leS9OgQv65DEQvgdMpg1Uur9
X-Received: by 2002:a05:620a:4549:b0:92e:6637:da8 with SMTP id
 af79cd13be357-9369d124a29mr343609385a.28.1786388525020; 
 Mon, 10 Aug 2026 12:02:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4549:b0:92e:6637:da8 with SMTP id
 af79cd13be357-9369d124a29mr343597385a.28.1786388524366; 
 Mon, 10 Aug 2026 12:02:04 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936a16dcb0bsm37071785a.47.2026.08.10.12.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 12:02:03 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:02:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 00/11] migration: fast snapshot load
Message-ID: <anogKPQgWvLLjOH3@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On Sat, Aug 01, 2026 at 08:06:17AM +0530, Aadeshveer Singh wrote:
> This series implements a "fast snapshot load" mechanism to
> significantly reduce the perceived resume time of a VM from a snapshot
> file.

I gave this one a quick shot, it ran all fine here.  It's a bit of a pity
that I still almost need to rely on postcopy-blocktime to get some more
info out of the async load process.. but I think it's still OK.

One other issue I found though, after applying this patch, QEMU will also
allow me to use QMP/HMP "migrate" (rather than "migrate_incoming") command
when both postcopy and mapped-ram are enabled, which will ultimately leads
to an error:

(qemu) info migrate                                                         
Status:                 failed (Unable to read from file: Bad file descriptor)

What we can do is to disable it for qmp_migrate(), e.g.  migrate_prepare()
can bail out for outgoing migrations of such setup.

Other than that (and the page size issue I raised in the separate email),
I think it's ready.

Thanks,

-- 
Peter Xu


