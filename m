Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD34FCF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmWi-0002KG-IF; Thu, 08 Jan 2026 04:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdmWg-0002Jl-GV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdmWe-0007w2-W2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJlbTBuNirU/TpTwLO67ILvmwzAMp/UquDN6BFXOEfM=;
 b=U+bCYgZo4NEtghydAeX3XOfof8HRuzhSYmAnMaCcE+zvVZNHe9M7gIMz6DoE7MV+xLeXMy
 aC/8NfzjfBkmQFQ7HqIP4hLhOogJq9Y9fiDInKjFnWSNcxZGt0Ae5ZCHZYgGfqGbh9C+QC
 9dGHrGturmISQsj/fK1eWHm71WiA+xk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-OQ34l5fKM_O3U8MH2AfRKQ-1; Thu, 08 Jan 2026 04:41:50 -0500
X-MC-Unique: OQ34l5fKM_O3U8MH2AfRKQ-1
X-Mimecast-MFC-AGG-ID: OQ34l5fKM_O3U8MH2AfRKQ_1767865309
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so24223885e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865309; x=1768470109; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJlbTBuNirU/TpTwLO67ILvmwzAMp/UquDN6BFXOEfM=;
 b=SVACYcN+hWlqfEBZ+Y5om828SSkp5RHcOhjhS/dTJOtmvbeLZVnHH+BKUnmXfIfKsI
 hZKsPFW4m6nJAqfGkNkSZDM6ZSIGH81EPqPzaR+Ek74baEb3sz9+RIuMkwKTjLIaBZZ8
 KtkhjPxQtqDf/XHBipOaAOFj6x4+af+xJySUOFUnoBQtJmyq9kvAEDK774BVU4/2fc4t
 o68M4p2GC2Ct+EaTSC5BZ43wXo2L8tsb7AFcjWnuDFhqIXH15FTiJZ7y0FKJS9OgW7ki
 By9xBoX9n5d9atSf5m3FXlDgXtmRaiXty7yabB9ej4I6Uw03xXY6GsHyEXHKJyutG4v9
 s/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865309; x=1768470109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJlbTBuNirU/TpTwLO67ILvmwzAMp/UquDN6BFXOEfM=;
 b=CD/VUmQc1aCg/5v8GUb7mHEDB/heasI/08FH5m7oZdJ28cA9w59at0//HoYdaAWPBC
 UdruDzicbilGzvZg8HCOtfN0NbqxbaQ1cnNYrZII3gPIRXRDqxtzrfDOQXovsNtcOU8K
 ae3j38pjyTNYlWVCCqr+c2XfeVLj6Vv5W3Q7r/nfFI1DYwJ2YfxkypJPR5nofygiH/aq
 GGNNcCaMUwsCskiPKz+6PzRYGZR1QRW820PVXvdujVWTSZUr5nMCgcdUyrqjaz03knI3
 Y9wuwzEN5R6203IsKaOjRIMPDsafGMcmeZW9dwaZcuZf4Vr8Asyid4zCMZwaeQSNv/6B
 4bzg==
X-Gm-Message-State: AOJu0Yy9lcCNfBTq3Il4MTTZ5/JOKJVFckoy2tfuxCBcpWlc2/IqkwF7
 1fa0oTi41jQggVsM8xidYinSa0YXZ4VH12MG5hV8q+3RLzovOVCMsP+Zzx/RdY5hhD+3Glasr3W
 ZWssWRaGKFIhNblfZ9+zuBvXJL0aWFAQcUbpkPB/qrtEK7lMOmMRrb7VgKVlZnmAnTRg1kN3dML
 sJo2uuMynaBPn5uXfs2b/v278vVGqSgLM=
X-Gm-Gg: AY/fxX41kzqvTPHBsSb2yj/hhVOdh45V5ETEdZV+OIHnmbiSPluC2Yzv+izKKoF78NL
 qk4W2dHgkVswDC4TD8PwDN6Ksa6Z4pWLEQmC7uT5yIpQxBTwUMNux6fmCEHCqMQNrZ4dnKJr5Rs
 l+BNu0pGZeNiLz0KvpULrRjbU47K5OQse06KHzuLGxpjO85nvm2BBAG/dTSMjjFjbFAIQ=
X-Received: by 2002:a05:600c:348f:b0:477:79f8:daa8 with SMTP id
 5b1f17b1804b1-47d84b55100mr74400945e9.17.1767865309282; 
 Thu, 08 Jan 2026 01:41:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcqA/TLrX9xDl0Z/8BJhOmHy5DC690FGxTVNDpjdDAteIzX5MKncLaVGmBPc8ibsJemj9GI6RRsfnwaDkusFc=
X-Received: by 2002:a05:600c:348f:b0:477:79f8:daa8 with SMTP id
 5b1f17b1804b1-47d84b55100mr74400665e9.17.1767865308918; Thu, 08 Jan 2026
 01:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
 <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
 <aV6UhNJzQLnDaJvO@x1.local>
In-Reply-To: <aV6UhNJzQLnDaJvO@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 8 Jan 2026 15:11:32 +0530
X-Gm-Features: AQt7F2pDjVPiIYJ8mRxzQshrRKjgz4o5ArabZspwhQWkb8SAk18D1r9AqbSxUEM
Message-ID: <CAE8KmOzPHTf6eaufn3dWTJJ2nsifdxZzwENK2hD_LZLGiE-pcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, 7 Jan 2026 at 22:45, Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jan 07, 2026 at 05:07:40PM +0530, Prasad Pandit wrote:
> > On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> > > The parameter can be instead passed into the function.
> >
> > * It'll help to include - why? pass the parameter instead.
>
> I want to remove special and unnecessary fields in MigrateCommon struct.
>
> I'll add a sentence when repost.
...
> > * To keep it consistent, maybe we can call the variable 'stage' as above?
>
> Personally I prefer fail_stage, e.g. fail_stage=NONE means it never fails.
> stage==NONE is less clear.

* Let's make it fail_stage in both places then?

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


