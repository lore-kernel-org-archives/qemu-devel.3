Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E621C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRel-0004A9-8T; Thu, 30 Jul 2026 10:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpRej-00049l-2a
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpReh-0004jA-C2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785421357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BPAKJ6kFRcuWJbNPHQpP1XpfGUMJg5PdFE8H6LQBhA=;
 b=g/oy5RbgfPPfUtNO2piNOpTdbuUj1lMSFbYsyzKS6wJM0G+b3xEe2lj2Mw7fbBQO6f/z0d
 3rYpr2tBw9EhPOhfrzKm+61hnxbdqrbZImxV8Bc3oAcE22zvx0RoWo72Wo+IsZxkuI6sEA
 RtEKCk41VJcPxcol3Ct976Elpw/NtYY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-UlAuLrtBM-Ch3iNE2LS8EQ-1; Thu, 30 Jul 2026 10:22:34 -0400
X-MC-Unique: UlAuLrtBM-Ch3iNE2LS8EQ-1
X-Mimecast-MFC-AGG-ID: UlAuLrtBM-Ch3iNE2LS8EQ_1785421354
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so45243341cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785421354; x=1786026154; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5BPAKJ6kFRcuWJbNPHQpP1XpfGUMJg5PdFE8H6LQBhA=;
 b=Y0HO0P3cTHbMfUp6YuYlfiEtC9UXBNQJWAg9jh8VzAELLdgZ8anNYlFCyAZeqC9dbk
 UjuIZ0PgS4ZybQjJQZDpit009rCP3Uk1hUbGuUnG1KA2HvvheO8ZavRLdvU12zPbbA8J
 Swnye1dCSgNUqiTcQ+F4zbxQCQGv+uvwyJe/ROIRV6Awsx2Dl4afTw0vZF6pRsV0Rdid
 yjc33xcB8HorcYDaecCJOgGh7psrSPDYTQfDT3C8NEBuOUUkz176Ry2aRWJdkbjx8G0i
 g/ttNSs6lT4Iy/XwAgEgSthOcXeItAM/StaddYbxtcBX6SShw0VC5r2qZTPcGUX8pwX7
 aq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421354; x=1786026154;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BPAKJ6kFRcuWJbNPHQpP1XpfGUMJg5PdFE8H6LQBhA=;
 b=fVsY2clpkY1cH3Zu0FwsS/NPlE0rH/GlEPGHq3+zkhL9Yvuj2bp4lSkj4wenmd3gk5
 cLdY3tkFx7/boxTlv2mdsuIl3UdBSzm78fm2EMd9y2XtDgaZDkuSCA0thjIo0mHt0EMJ
 ax5nptLpYIXQXC6noJDJLGhsTysg11YGLODYk1zRVlClJsrqv/GINY5S51Ss8BgTcIgb
 jRC5c9OaIDDdxZcDLq6eMhx/OuCfP5Jx4uMbiBFiVrwdrd3IuUTvs9PPRQylBmop3igC
 1K47zWZDOHMq69RYHRHOOJnYFcGpN03jNhjDP7/T6mG8vkUwzRDgwFcnLmZafzchOasg
 g/Aw==
X-Gm-Message-State: AOJu0YyZsuskIYzunPsRju66SgotGZ3XndJU1LSIpR6tsH4jqQ58BsYF
 qrsPLq+BEuiQMgt8InNsxlMSUNOqH5YJGfrzVpdOGvTda4JpYaifVd8QMgOQX9L8M/5jzpT/saM
 L2OOUrJD8OoZIrABlmm5X47CC0qc3E720wEP96ro89uJGweIBYopQXZyn
X-Gm-Gg: AR+sD10oi7pg6NFkXuLvHpbDSqfDi+mUaSdWW5EI2PzBESEom0x9nwUEBxd7NkuSZKN
 oMCAaEVficsnFJB7h+YYxgqWqJho49cDZtYmRz0mnqrrQ6fWlN+SZ3I8atpsd+Ohd5b3/x6pnrN
 FFM71QccJ0t01jvQFz5SAbuhW/dd6at+ES9lT6mjFxO/KbEFjsEkrxTt1PFEDO47YfXdb7qV9lg
 s9CNMXStsG3zIFm4cBgrcXo3v/y8Cu6/kjYcFWDd12Qm7h9rIhpzqXyb/UtgxZElIIDpbZAQjHN
 sXDf1PiN4iuJaIwGDM8egaZLzT5Ox1aTfcsO8fM0Wy4usAnmWqdciRk4yAqAEgAxSwBp
X-Received: by 2002:a05:622a:646:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-52b386a9316mr29579711cf.53.1785421353953; 
 Thu, 30 Jul 2026 07:22:33 -0700 (PDT)
X-Received: by 2002:a05:622a:646:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-52b386a9316mr29579231cf.53.1785421353382; 
 Thu, 30 Jul 2026 07:22:33 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e3993fadsm41624421cf.29.2026.07.30.07.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:22:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:22:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
Message-ID: <amteJEbrPguzFpH5@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amtbGkfKvPCJgDec@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Thu, Jul 30, 2026 at 10:09:30AM -0400, Peter Xu wrote:
> On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
> > Hi, this is basically what I ranted about in:
> > https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> > 
> > I'm replacing the per-integer-size type checks with a single "int that
> > fits in 32bit" check. This allows several lines of duplicated code to
> > be removed.
> > 
> > I haven't changed the macro names in the device code yet. If this
> > series gets positive feedback then I'll send per-subsystem patches
> > doing that.
> > 
> > CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> > Also tested:
> > - migration-test --full --thorough
> > - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> > - s390x compat run forwards and backwards for previous 2 QEMU releases
> > - ppc64 compat run forwards and backwards for previous QEMU release
> > - migration-test smoke ASAN/UBSAN run
> > 
> > Fabiano Rosas (4):
> >   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
> >   migration: Introduce VMStateOffset
> >   migration: Remove redundant flags
> >   migration: Remove duplicate vmstate macros
> 
> Nice work!
> 
> I think I was only looking at VBUFFER side and I thought it was fine
> sticking with 32bit even signed or not, not a huge deal.  But cleaning up
> VARRAY whole thing together looks definitely an improvement.  I definitely
> like your version here.
> 
> I assume with your series I can drop both of my patches here, right?
> 
>   [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
>   https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
>   (I'll still respin with the rest)
> 
>   [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
>   https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com
> 
> The only missing piece would be an multiply overflow check in
> vmstate_handle_alloc(), if you could add that check too while rewritting
> that in patch 1 then I think it'll cover all.
> 
> Vladimir's ask in the separate email makes sense: I wonder if we can also
> do one step further and merge VBUFFER into VARRAY.
> 
> The other trivial thing is, while looking, I found one trivial macro
> VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.

Now officially declare support for u64 on all these offsets, we also need
to double check on our alignment with security issues.

Similar reports will not be a bug anymore but results will be the same I
assume: it's anything the attacker can feed a u64 directly (instead of an
int32_t negative overflow), result is still failing a malloc() with
enormously large numbers, legally this time.

Do you still plan to work on finding per-user upper limit or whatever of
that kind?  I'd say time spent working on series like this worths more than
that, but I still want to check with you while looking at this solution.

I suppose with this, one option is we can close all tickets reporting
security issues while allocating with all u64 fields.

Thanks,

-- 
Peter Xu


