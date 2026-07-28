Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B968C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wop1h-000749-F0; Tue, 28 Jul 2026 17:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wop1c-00073W-ID
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wop1a-0004PY-Ul
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lupCBJWz5Jm4q83lgBdtnVQAvIY+UMv/u8+1D/HDGdg=;
 b=AkPkMmIqA+oJEhK126jeBsPiOkdhg3vcW++mqv/xTybQE1dglGf3e6IQ/GVa3xn2IAGcwh
 Ayo33TXKI7tOrgyQEGkKn+P941p1Kz0VKlzBcdG23csFcJ8TpOJpITnxhtXiEd016/CqCa
 OXr+sFuZfE+SBm+CZoEt/sWgnCBQM6M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-cD3SZ_acPbeoRuBNTvc4rQ-1; Tue, 28 Jul 2026 17:07:39 -0400
X-MC-Unique: cD3SZ_acPbeoRuBNTvc4rQ-1
X-Mimecast-MFC-AGG-ID: cD3SZ_acPbeoRuBNTvc4rQ_1785272859
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so42766785a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272859; x=1785877659; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lupCBJWz5Jm4q83lgBdtnVQAvIY+UMv/u8+1D/HDGdg=;
 b=amHTOoJgziK0BZ+1iEnCcZVccZLILHu8N48botvgr+BFBfPivNc+9TmSFeQKe/FMp9
 qEKAqP9MBrHchC6zQLr1U7jve1Lya1slT+OtvGlqwpvXN/h1UWmTCK/QnD6MHQr1O5/2
 i3yAvI6TuZRtp6Uvsfr+CzrtLBJM4s0lwaWo4Ggfb0+isIPFrQsspz8hRO+LuE/MBU0V
 i3IWdv3br6WhGX/JUNbXZ/uGrRf5w/Qc2hzFOfijXB5nlwayxx+su4I4+xD9wUh6WoNw
 l7cyCf1qW5SQE05W6v5Fi4UnxCYGuGlwxlRHL5jEUVAvtv6C+VUBsA4p3rghT/j5J5+f
 HzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272859; x=1785877659;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lupCBJWz5Jm4q83lgBdtnVQAvIY+UMv/u8+1D/HDGdg=;
 b=RQN1p99/UP1+C4TdE2l4tIWCAFrhW+fSjvX1yFjlqi9htT5v9Big4tHHbKeh3pV2Eh
 jAgxJLu+AXTy4N/i5jXF0hVp4o3zUEKG3iRpHDoIiEP/OBpXaKOJiFf7xu9zwFW0PME7
 pXubQeD4PqLw8ZUJXZIMczIDYejkQQp7RkJ5UY71e6ipNNaJds/ZzUxJL01KqwlteDnH
 VhhnVFCATNdmMnZfcDEmAJfXmUPQgbLtalphqbXHZlslYD9BxolnItkbZsLp1O2YlI//
 jsYTlX7kc1AaJY1RthdjKb99uaoyxevSWaSSB8I0YvOxOIShAOCW3niuVNikfSDbwFKf
 G+KQ==
X-Gm-Message-State: AOJu0YzMyAhBtAX3Z3pfpeQl/LNYRZKSemKs7MtrNwEgY3Lmgt8uJaPH
 CI6Pj8fbGTfVH34+McPx/gGYHSl/ES+E6+D7g7u/Vbt6WePktBnD2U6vEyeMvyOOH5tB8vsWR/2
 JGFQ2Fae1m+vyUTVDRDSjpwzB7LxiwGHvdPu0kzOCzVVi9dY8DGMUI3E7
X-Gm-Gg: AR+sD12AZp+UBcfYcjpggR5HNXwW8bvQOLgq2UB5pjP56P8XlerbEtAMf/sYgn27Yfa
 Kof7YXb/LePRIjvU4Olrw1JZf+tM5B1cHDb48BqHXOEBxatOEfkMSIPHSDygGTY/gZdhxk5VLcZ
 UOJihb93KrLvmFjFg24exXf+ff2JdKy58cE5WQL0BY1rFB2Mh5hvXP1mMnsDOTAYuBn+PScV65g
 IBfP4n0brQzJvdsb6gwOYjULdphWy+5rgUiJYiM2wdIEpodQEfTrzwZJ6AwHuZSDxjeGC29KRyE
 Tlj1/zW86FDU4LHJ9SYzdvGKiVXiq8ZUkiL0cNRwSos5yejyQdZbYsA3ZNr7ctxjBZUoe5/tClz
 o5vZMhXJro37YNoi9WE42JSztls3nBB7mIs+oDcjodpf0AWR3SsUgalW2j14=
X-Received: by 2002:a05:620a:6cca:b0:931:62d:6c3e with SMTP id
 af79cd13be357-933026a88eemr433985285a.86.1785272859193; 
 Tue, 28 Jul 2026 14:07:39 -0700 (PDT)
X-Received: by 2002:a05:620a:6cca:b0:931:62d:6c3e with SMTP id
 af79cd13be357-933026a88eemr433980485a.86.1785272858492; 
 Tue, 28 Jul 2026 14:07:38 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3257522sm21329285a.11.2026.07.28.14.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:07:37 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:07:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Yuan Liu <yuan1.liu@intel.com>,
 Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH 3/5] migration/multifd: Replace assert() with
 error_setg() in recv paths
Message-ID: <amkaGO1kQYrHquMe@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-4-peterx@redhat.com>
 <87tspiopuc.fsf@suse.de> <amkQ0JzADdKbhsOJ@x1.local>
 <87h5liomod.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5liomod.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 05:59:30PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jul 28, 2026 at 04:51:07PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > QPL and UADK multifd backends use assert() to validate wire-controlled
> >> > fields like per-page compressed lengths and packet size consistency.  These
> >> > asserts will stop working with released version of binaries, so may stop
> >> > working.
> >> 
> >> This is not true, asserts are always on. Same for the similar comment in
> >> the previous patch commit message.
> >
> > Shall I perhaps replace this to "when compiled with -DNDEBUG"?
> >
> 
> It's not allowed as per osdep.h:
> 
> #ifdef NDEBUG
> #error building with NDEBUG is not supported
> #endif

I shouldn't have sent v2.. I'll wait for a few days for sending v3.

-- 
Peter Xu


