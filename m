Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB85D13C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOP4-0004eA-NJ; Mon, 26 Jan 2026 10:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkOP2-0004a5-Mg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkOOx-000636-5G
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769440874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y61c55kL3446JWKUvCwldbqYVrdRdLgemu4paiFkj94=;
 b=gfgVBLRQ7i2ENp9PdnRZGY3t5c8ErK2e9GlfB3WPVDPLJr7qe9Jz4VtdrNN6/Tvy2cjk7W
 ATTiBhK5ajKWVTLiwz6ofNQd61J+klfVju0cBcC5vNYRagZXbEg94HsGDDcNuZD7u45Ai2
 c/UUQrT38TA03rlk3JfW/O56V32GG1w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-_Ybof0yRM2mWX5mnL9ecjQ-1; Mon, 26 Jan 2026 10:21:12 -0500
X-MC-Unique: _Ybof0yRM2mWX5mnL9ecjQ-1
X-Mimecast-MFC-AGG-ID: _Ybof0yRM2mWX5mnL9ecjQ_1769440872
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5014936958cso169411281cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769440872; x=1770045672; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y61c55kL3446JWKUvCwldbqYVrdRdLgemu4paiFkj94=;
 b=A5/ZB1l+020InEtDn95LuEkz3l+IK+gWXOUbUrsTQIoYNY77fMxcyyBnlQYe1OddM4
 x9p8JY16vbJRrP5k9rI81+lJcx0jeNc2MYcBvtzn7o0hLVRpu5bChVvjNUj2wz5lVt3L
 vN+CMzYeRGK/CdIkEzGrZrghfc67WGBm+1HPiNmzQKOo5TjiYfQl5Y9wG7NTENHUmmoT
 /BfhPfAsLl3nI0WoDI2gf4BjYM+wsfdvYfc4Beln15NRgPnXpZfS05u6AGpj89nkXZDx
 Jqc1k7g6QDjcZMpBa/0RiKIm3sU37T/Kq8a6+ex+E7gh9tly0xubpYZj09waIzHpoEMu
 fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440872; x=1770045672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y61c55kL3446JWKUvCwldbqYVrdRdLgemu4paiFkj94=;
 b=fzUbnHf5jlOMP45Det2GknN3s1Snpr9g6eqd1NKeRUAMcHDr9pdQR4qTssMTb9KV31
 hfR1ZZRiwKZ215AK9niiCyf5J2P/zk0Q7sa8x3pO5IxxUbgI4rCAnULMc1rZFTC1i7sf
 4Bzm82FvxXZcJTPN9aQ2ojB0VkRb4B31wt/MiN3CpVsCcAuSsX4RQUl3AfYBh/aHwx6Q
 gTJNk9xrIEXw4Arude5rRmWV9aPQS0SU6Ty6+Fwf0szDIdmNlycoOo+YQAeXF0II5yRP
 T1BKljdm/3RNCxRSy4e/n1/Q1mcOIcSGPalYuuPFJ213IBd3mHqb/AWUsdgE7Sel2c38
 tdZQ==
X-Gm-Message-State: AOJu0YxEByVkdMfvgCDJ9Fj8A+dJLRc2NXH53S8erGlHtU1BMcqENjpd
 7mN0T06h3YjTbGnwol3rSBWRaKglcsbq26Wp2bCLoRy8tBjBVer7UhR2t8LMpQArFMz9UziNHZL
 VwHDYbtvpqrygyrXc7VhbaEBzQouICdqF05YxnJ/T9BCHQ2Nj6VwrUtl2
X-Gm-Gg: AZuq6aIsuHyXRwiFUbqpnVUef/sK6r/4WZAw45Pyn9eg4pvhVGOgoVYUYbJDPpJ2YBH
 B6ergx+5oErr9QuvvtW7aoYfDVrUs72Zj/BZS+S82aWmoOhcAnn1owW0ZSon+TM1fDQ+hR9rf8c
 VM3FW46pSD8X60zaHxyT26riKTvDEB5vBP67hwaxnn9UGxmp+6CxRqZs7ZJXmz+V85as0QYLaW9
 3ypkQvwi/GCbX+fswMBrDCbNwma0XCrt7Z+8cFPdAOuz0C6l3k6Pgw4hbGyhSJpOwvLSzTqF9Vh
 9+hSr4/S+fYsaRHfLuNwG7wLNt52ScUYInfjcqjI36zcuaAOoBvFx01J0+jqy+YfO/Sv6wtaGr+
 6Gv8=
X-Received: by 2002:ac8:580f:0:b0:4ff:a40d:d2b2 with SMTP id
 d75a77b69052e-50314ba106fmr60605491cf.16.1769440872025; 
 Mon, 26 Jan 2026 07:21:12 -0800 (PST)
X-Received: by 2002:ac8:580f:0:b0:4ff:a40d:d2b2 with SMTP id
 d75a77b69052e-50314ba106fmr60603741cf.16.1769440870071; 
 Mon, 26 Jan 2026 07:21:10 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f72b66sm110761271cf.17.2026.01.26.07.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:21:09 -0800 (PST)
Date: Mon, 26 Jan 2026 10:21:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/5] migration: Notify migration FAILED before starting VM
Message-ID: <aXeGYwSleEXznWJh@x1.local>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-4-peterx@redhat.com>
 <874iocjxhk.fsf@suse.de> <aXOWgOAWqjy7rHV7@x1.local>
 <87sebwgrj7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sebwgrj7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jan 23, 2026 at 02:36:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jan 23, 2026 at 09:59:35AM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Devices may opt-in migration FAILED notifiers to be invoked when migration
> >> > fails.  Currently, the notifications happen in migration_cleanup().  It is
> >> > normally fine, but maybe not ideal if there's dependency of the fallback
> >> > v.s. VM starts.
> >> >
> >> > This patch moves the FAILED notification earlier, so that if the failure
> >> > happened during switchover, it'll notify before VM restart.
> >> >
> >> 
> >> The change to FAILED in patch 2 should come to this patch to avoid
> >> having a window where the notification only happens at the end.
> >
> > Hmm.. Isn't that expected?  Even after patch 2, we still notify FAILED at
> > the end for precopy.  It's the same for postcopy.
> >
> 
> Sorry, I meant: s/at the end/after vm_start/.
> 
> > For a failed postcopy we have following behavior:
> >
> > Before patch 2
> > ==============
> >
> >   - notify FAILED (during switchover)
> >   - vm_start()
> >   - notify FAILED (during migration_cleanup)
> >
> > After patch 2 
> > =============
> >
> >   - vm_start()
> >   - notify FAILED (during migration_cleanup)
> >
> > So patch 2 fixes the duplicate issue, and only fixes that.
> >
> > After patch 3
> > =============
> >
> >   - notify FAILED (during migration_iteration_finish)
> >   - vm_start()
> >
> > Patch 3 changes the place of FAILED notification so that it happens always
> > before vm_start(), for both precopy and postcopy.
> 
> Right, my point is that with patch 3 we're establishing that the correct
> place to notify is before vm_start().

Yep, likely not strictly correctness in terms of current notifiers, but
since Stefan may have yet another use case that may require a notifier to
be done before vm_start(), it makes more sense for us to move, IMHO.

> But after patch 2, *if* any driver actually depends on being informed of
> failure *before* starting the VM, that will not happen. I think both
> changes could be made at once so that this intermediate state never
> exists.

I see what you meant. I think there should have no such user.

It's because we always notify FAILED at migration_cleanup() for precopy, or
even postcopy before the cpr-exec work (before QEMU 9.0).

That behavior of "notify FAILED before vm_start() for postcopy" is very
specific and only added after commit 4af667f87c ("migration: notifier error
checking").  IOW, before QEMU 9.0, for both precopy and postcopy we always
notify FAILED in migration_cleanup(), never before vm_start().

I mentioned this in the commit log of previous patch too, where I bet the
additional FAILED notification added in 4af667f87c for postcopy path is an
accident (to make it pairing with the "reused DONE", however it turns out
we likely shouldn't do either of them..).  So I don't expect anything will
depend on that behavior, and only for postcopy.

The benefit of splitting this patch and previous one is, the previous one
is a "fix" of duplicated notifications, hence if we need a backport that
can be done without this one.  Said that, I don't think one should need
it..  It should also make each commits slightly easier to follow, because
they're fundamentally two changes.

Let me know what you think after reading my explanations above.  I prefer
the split like as-is, but I can still squash it to close the trivially
small window that you described.  I'll make sure if merged the commit
message contains separate discussions on two problems.

-- 
Peter Xu


