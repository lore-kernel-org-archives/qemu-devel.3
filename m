Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E38C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Sk8-0005Vk-JU; Fri, 04 Sep 2026 08:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Sk6-0005TL-2p
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Sk4-0005sr-8j
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788523799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLk+6M0o1KGmtGJAC50vmPmxBikfCFLSYwifBPcjbes=;
 b=NopxMaP1Jib8d85ixlgZzFXXrB/ukXeo0rfBEZdpmW6w0LuBck/8hm2gOozWbJhM++HNIj
 BY8sBEU7YaamIKydcq2yMmjB3lxnoy9JQdXYkpya+t7RHnlMgvMdhDLqt8muKITdJwgtqc
 lXwKjXFEY4rGsmTQx0Awey0LvMNcyBc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-G9-oQnwLPQ6RzhJ7fDjjBg-1; Fri, 04 Sep 2026 08:09:58 -0400
X-MC-Unique: G9-oQnwLPQ6RzhJ7fDjjBg-1
X-Mimecast-MFC-AGG-ID: G9-oQnwLPQ6RzhJ7fDjjBg_1788523798
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936708f129aso126889385a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788523797; x=1789128597; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LLk+6M0o1KGmtGJAC50vmPmxBikfCFLSYwifBPcjbes=;
 b=jKmBRU8i7JVqO6vCgpuUVJTyhWjWGX6WYB291xPkpVhkg62dHSDiVoJEqsPrnRR3d0
 aG1jjrHnXqbrgmO/8pYeLZF3USMB3K2CtTDKq3sqI3RAyGCO2oDNdFabx3cVJEmndPFj
 JWhXl2P28TNoPuaBj0GBt0PoN7P958y2L/kPdXbE8OHcV5hu42D8Ur0LIadclnKNKM5l
 mggievs6TqYHdsidk1jqZ2ISFAxhEB+xtbMjwgAkf0kLQc2R3Puhh9r92xJaNYF9ljC5
 hWcs9nXLn1q2RXIZxz3yVVcluJG9QETe7JnNBiM6cnrDqPDmy93lXqKhgratxN2Xbuo3
 O6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523797; x=1789128597;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LLk+6M0o1KGmtGJAC50vmPmxBikfCFLSYwifBPcjbes=;
 b=BeCOuKCbLOPjAJ7E/fDeGpjI/AwsXW7sd0QFfRgOQUmY+osbMRAh79E7XqBkBgwp1n
 Tjulwg7Pj09GRMJEC4T7F3+t8rbJsGXQYIzqYNRcM8HruQyq2KmxG3qnak+osE77DGD/
 EQChypZAR8TvZQaJ9JZX6WcHpG0Rt1ZtEMYqTgqfRNWV0PS/QWCtu2AxaklPd/ghqEoE
 DKv6AZsrWQiSZJTz3EQiFR4xplm9glAYoaU9t8MInk+2sxmUmK6/+eh8LNQMcWy8uYQO
 9p5dTWruauBDbrcqW8MIvt5xaiC4YaIT4nIMlPKv6YmrSrg+CP15cUDaYz3WOWII0lDW
 BQgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKeGEnye5ft9G9nfQUWwXx2o0L+ozFgKcV/4cgSaVML+P/+yG3X8ykeYzbHWVndMe1dpleb1XTziHr@nongnu.org
X-Gm-Message-State: AFuF++nmidHsqGDxJwhsM2iGpXw+/TWsNTiFK0KkBmL34zl74saX7HUi
 pgOSYxNOeNYQv4bbA2wqrj5bQIJw9mUJcvYSDhzm4xQoGdHmRnKRK3kkfLykYNUfd5q9B8GwJAr
 JK+GKOOAaMbCXLc2Bt5/ywGWW6PvQS5sgm9+61chheONtVVfgvZoplI5S
X-Gm-Gg: AYBFou134LMh9Q+/pCrvA/toM6dntMIvTieX6ap5tDIud8fyTAKKse+kIPQwHtDTO5o
 HtCHQxNRYLoCLaGvYNmav1Zjiw/q4+75Ds3k2x3NXEVgkweHZYtBAYa8boY9PkGGTPR122OJHDi
 nIhbQXR1GES4KSD1nf1FyyRDqnQ+zjgUowVxN/I0PCx9jXt2ou6VdbuMHdm5KrmISQMNiD9sh+3
 jn+l/A9avb9S7NzKnLB/rwxUDz1VHQqg4wLaPiODGG6UHjhCpzRL5AkegsM5Y0pa7yJb6fuqZg4
 KX8JtJp66LtZnJqHxDwu4JESbZqdb14liF9JLQgVAx+iCsymaTTZ/ivk3EZstHtdhkPh
X-Received: by 2002:a05:620a:8f8c:b0:939:2c5c:7977 with SMTP id
 af79cd13be357-9398037b9b8mr343542385a.20.1788523797348; 
 Fri, 04 Sep 2026 05:09:57 -0700 (PDT)
X-Received: by 2002:a05:620a:8f8c:b0:939:2c5c:7977 with SMTP id
 af79cd13be357-9398037b9b8mr343535985a.20.1788523796713; 
 Fri, 04 Sep 2026 05:09:56 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fbcc54dsm196415785a.42.2026.09.04.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:09:56 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:09:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
Message-ID: <apq1Cag3Fh1mYqP_@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de>
 <apmwZbSLZ46yvGmT@x1.local> <87bjae8bya.fsf@suse.de>
 <apm10EPO4vYlZLQZ@x1.local> <87fqzp9yzb.fsf@pond.sub.org>
 <CAFEAcA_N0NciFyg88rfweD_uYeFbtgrP1y3NhmXwhChZGMmxSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_N0NciFyg88rfweD_uYeFbtgrP1y3NhmXwhChZGMmxSw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 04, 2026 at 10:15:21AM +0100, Peter Maydell wrote:
> On Fri, 4 Sept 2026 at 09:56, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Peter Xu <peterx@redhat.com> writes:
> >
> > > On Thu, Sep 03, 2026 at 02:46:37PM -0300, Fabiano Rosas wrote:
> > >> Peter Xu <peterx@redhat.com> writes:
> > >>
> > >> > On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
> > >> >> Using newlines in the g_test_message is fine. It automatically adds
> > >> >> the '#' required by the TAP protocol to the start of each line.
> > >> >
> > >> > IIUC we have such check not because TAP, but because all these functions
> > >> > will append one newline at the end, hence it's not needed.  IOW, if it
> > >> > applies to g_test_message(), I don't see why it doesn't apply to the rest.
> > >> > But maybe there're other reasons?
> > >> >
> > >> > To make it simpler, maybe we just call a few times g_test_message()?
> > >> >
> > >>
> > >> Not sure I understand your point, Peter. I want to be able to print nice
> > >> messages in patch 9:
> > >>
> > >>  g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);
> > >>
> > >>  # HMP output mismatch for entry at line 55:
> > >>  # expected vs. found:
> > >>  #
> > >>  # max-bandwidth: 10356305952768 bytes/hour
> > >>  # ---
> > >>  # max-bandwidth: 10356305952768 bytes/second
> > >>
> > >> What would be the issue of having newlines here?
> > >
> > > No issue here that I can see.  My question was, why you moved
> > > g_test_message() out only, but not all?
> > >
> > > My gut feeling is we check this because people forget that all these
> > > functions includes a newline.
> > >
> > > So if your point stands here that "newlines can be in the middle", they
> > > should apply to all, not one.
> >
> > I'm not sure I understand you correctly.  If you suggest to permit
> > newlines in the middle of error_setg(), error_report() & friends, I
> > disagree.  qapi/error.h:
> >
> >  * The resulting message should be a single phrase, with no newline or
> >  * trailing punctuation.
> >
> > If you want to provide additional information, use error_append_hint() /
> > error_printf().
> 
> Right. These functions have a genuinely different set of semantics
> from g_test_message(), which is why Fabiano's patch only changes
> how checkpatch handles that g_test_message(), not the various
> QEMU error/warning functions.

But in this case g_test_message() implies one message to be emitted, shall
we follow the same rule that we should stick with g_test_message() without
newlines, and use it multiple times?  I don't think I have a solid clue of
such, that is why I actually suggested dropping this patch and just invoke
the g_test_message() a few times.

I'm personally fine either way, if we go with this patch, I suggest:

  - When repost/queue, add some real reasoning on why g_test_message() is
    different from the others.  I don't think it's relevant to TAP format..

  - Please if any of you agree with Fabiano's change, provide one ACK..

Thanks for chimming in.

-- 
Peter Xu


