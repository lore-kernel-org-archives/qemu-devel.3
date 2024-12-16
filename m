Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E5E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEeE-0002Bv-Sn; Mon, 16 Dec 2024 12:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNEeD-0002BV-AM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNEeB-0008Az-Cn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734369162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDtijvB0H3CuzKuIj5wanuKRK919UJ/LoY7tELIWHWE=;
 b=ag4PzpA8nZZCw3uQMPk/TfRnnkpDCS33MJSncOeHxuSK3T8+fdlCNHasFDues1CmeeY9oj
 MUTuCGkvPf3qxbNWj740ganAymtG5B9wSx4bxJXZFcAMti4PoIj0Q4RNwIyynJP04WO2Co
 Y9ZX9UUTgTiWqufB6ImqBEQkQ0DrExw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-IXa6InRqMIqjoJAN6WR4vA-1; Mon, 16 Dec 2024 12:12:40 -0500
X-MC-Unique: IXa6InRqMIqjoJAN6WR4vA-1
X-Mimecast-MFC-AGG-ID: IXa6InRqMIqjoJAN6WR4vA
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a81777ab57so39243095ab.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734369160; x=1734973960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDtijvB0H3CuzKuIj5wanuKRK919UJ/LoY7tELIWHWE=;
 b=H58zIlWywrBP9uogvXB6pk5fT3BpH+7GtH18FbJ+8Tr8vXF890NT+hSCZuRPpan+Gx
 8+Z3bD8J8Uvfyh4az2Z++oRsAIf1RieCkhwkKzzeSAqPWNX6qiajqcVdeDVBFIKo1BSK
 dX6nx8REvAiSuXqK31hRJjLtcKvDYJO7OJLd3owpZTwCrjVzkPT2BVFE8USCf52K3FyH
 gwIgxz5S7SLk6rOcMzhR8c8aVeO5ImCWc7b89d7BT28cAFDIA656lEycp4uIQc52EHqN
 kQNP15iar+tTM3FI88zWsa41WeMmCabHinNI6wRWL9V3TT5TG+AfocbHR5Eu6E5mk6uI
 At2w==
X-Gm-Message-State: AOJu0YzBdi7nxdbmIZrcL9vNrZ/WTaZ2KtFo2iHLq+Z32Fd6LeP00V7X
 3gN4Kfb3+b3RHXl8eYeVa0d/1vNfTd/nGwPGcG/sRDBDnXAef7cj+u7iJmjsIU38tztW1J0wJII
 PLNIwJKO3fNb6ZLEWmCqzMyy0FCWXZnpUfwiViU2vxKZiXgTffv8c
X-Gm-Gg: ASbGncs6f3Ydto16cnJSpGSiPmtZjiDaKZcPgWSU2jFFDlfPyTzo0paMpqTNE17WKvG
 EHuCObd8eYP1wrXfbHSO+dyKpSdwo1exq9QzAivJvii9QEFfNcyqrPo8qzM94+7STBTLzYimnw+
 LeAzRxBNRpVJLsbmbLxK6GJMrIYkiPEl1YIi3gRgAjnzSjxjeqpGTeP6f9N+cVMdTqW1kQm/sjg
 C+APq9w5Dl3oPJQ6FtLvB9vpkJ1OYVdWORrfo70GxHnK3rHhmworCMwzUFMcaiAP7Kh718ZBeRD
 X3hLPyWdO0MkQo9GoQ==
X-Received: by 2002:a05:6e02:b4e:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3aff470f9d8mr108369195ab.2.1734369160075; 
 Mon, 16 Dec 2024 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHSEFNJVgF8DSph25NAZPsYSIJAulGOctd7pyaUIENL58J3XwC+r+oKXYqieyVXN8L/Tg9nQ==
X-Received: by 2002:a05:6e02:b4e:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3aff470f9d8mr108368845ab.2.1734369159648; 
 Mon, 16 Dec 2024 09:12:39 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e0a3def4sm1301926173.59.2024.12.16.09.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:12:39 -0800 (PST)
Date: Mon, 16 Dec 2024 12:12:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
Message-ID: <Z2BfhvPfYNYoHA5Z@x1n>
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
 <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 16, 2024 at 04:56:33PM +0000, Peter Maydell wrote:
> On Mon, 16 Dec 2024 at 16:14, Peter Xu <peterx@redhat.com> wrote:
> >
> > QEMU uses g_mkdir_with_parents() a lot, especially in the case where the
> > failure case is ignored so an abort is expected when happened.
> >
> > Provide a helper qemu_mkdir_with_parents() to do that, and use it in the
> > two cases in qga/.  To be used in more places later.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qemu/osdep.h     | 7 +++++++
> >  qga/commands-posix-ssh.c | 8 ++------
> >  util/osdep.c             | 6 ++++++
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index fdff07fd99..dc67fb2e5e 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -828,6 +828,13 @@ static inline int platform_does_not_support_system(const char *command)
> >  }
> >  #endif /* !HAVE_SYSTEM_FUNCTION */
> >
> > +/**
> > + * qemu_mkdir_with_parents:
> > + *
> > + * Create directories with parents.  Abort on failures.
> > + */
> > +void qemu_mkdir_with_parents(const char *dir, int mode);
> 
> Don't put new function prototypes into osdep.h, please.
> It is included by every single C file in the codebase.
> There is always somewhere better to put things.
> 
> QEMU shouldn't abort on things that are kind of expected
> OS errors like "couldn't create a directory", so I'm
> a bit dubious about this function.

That's what qga/ is doing right now, rather than a decision made in this
series, though.

> 
> The two use cases in this commit seem to be test code,
> so asserting is reasonable. But a "for test code only"
> function should go in a header file that's only included
> by test cases and the comment should be clear about that,
> and it shouldn't have a function name that implies
> "this is the normal way any code in QEMU might want
> to create directories".
> 
> For the qtest tests, I currently ignore Coverity
> reports in our test code unless it seems particularly
> worthwhile to fix them. This is especially true for
> complaints about unchecked return values and the like.

OK.

> 
> Even in a test case it is still not great to call
> g_assert(), because this makes the test binary crash,
> rather than reporting an error. The surrounding TAP
> protocol parsing code then doesn't report the test
> failure the way you might like.

Hmm, I normally always think crash is better especially in tests to keep
everything around when an error happens as general rule.

TAP parsing especially on errors is more useful to me when we constantly
expect failures, IIUC that's not the case for QEMU tests?  Because I do
expect the CI to pass all the tests always.  But I also admit I don't know
the whole picture of QEMU tests..

If we don't care about retval checks in tests, we can definitely drop patch
1-2 here in all cases.

Thanks,

-- 
Peter Xu


