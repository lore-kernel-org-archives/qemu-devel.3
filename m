Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138FECCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGy9q-0007DL-8k; Thu, 06 Nov 2025 06:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vGy9o-0007DA-96
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vGy9m-00070D-0E
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762428475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0twJYPvHLvVI99xPPBSaoOUC7uVZ6DZS4epy2UMVp64=;
 b=aVcNrR9Ja9/qtQO/BoyXMOik6eH02QT4mC193K1o+Nq137sGCbbLFEPgvBcWZFIuqRUlJG
 vHkMm35z0jJmUpHdE/xas1c6+KDKnaKYo728Hi24zAxi6N7ntUm9CySIzi87v5lO5Ta/kw
 9yBLZ4+8x7DxN+gb3aFAUTDF0zWKRDU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-mIahecuOP1WAg8vzaXl7QQ-1; Thu, 06 Nov 2025 06:27:53 -0500
X-MC-Unique: mIahecuOP1WAg8vzaXl7QQ-1
X-Mimecast-MFC-AGG-ID: mIahecuOP1WAg8vzaXl7QQ_1762428473
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429b7b46eebso861930f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762428472; x=1763033272; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0twJYPvHLvVI99xPPBSaoOUC7uVZ6DZS4epy2UMVp64=;
 b=XLqrTJFrcuO7t4wVAYY67oUsHF8VcFugQkyoVcXSKAXPx5p3tWuKz0inGjHRJy/SSt
 MUwCRRp0105uZu5tFtGm5ZPHPy1v+qGoOumlHENOt0vmHAtN/uy8OZI9MGbVilb1ozc8
 3KHo4oY9Qy+7Y0EP2xcP6RAGJpKZBuUhWilBB2lAPlmXZ+J0Bf7eMDWGhwtAjffH3VAS
 i3JLdoshR9uRTKkYW6P0XtGTdgLhSzj1AFWGTqBeyD3gxx6gN7wd97+OMneGhna5+B3l
 WUVL/DJAzm7yVGxAfYPMHQBlYUbfZXllH/A/vOuG2vC1MOmDfNZ4SlniJQXCWb5UJh4D
 iFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762428472; x=1763033272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0twJYPvHLvVI99xPPBSaoOUC7uVZ6DZS4epy2UMVp64=;
 b=oh8fYiAU1Nhecmv8QWElqwGQuO0Jx2VHB9HSE3E1omhTOJsT3uFvXnzejTRcI36WUz
 lwtxNA0iJsYd1xBgsabjaro2qlj+VMuV9Z17gygL7eKCh1tgD1GLJ7VpuX48BYG3klOk
 jJYHWRcVdDnL2LBZtDyrX9VsbKGBxJaBJ6vj5VxWRr3MKju2QpVU070tLTDHEvYTq4ZI
 GNLTZ2/dqwRj5NfqG/Wrzfwww/24CN+aFC1GrR/hbTaq6Zp/CdWstHtcIdBfKcYzzLzS
 xeb1xHU6/Y45dzpADZ5UtVb9UePoAVH3RGszFO01oUmUbMmKK9S6kgskGElgsTQwqFmI
 5lIQ==
X-Gm-Message-State: AOJu0Yxe1Nc6N7qdKCEouVe/wqjRL6XKVLqg108LaZEZyNStruBjN5K0
 7s5BPD8sIE1YeAMfce2r/cEpI5KILqiazyAJ0ItnnqQcSTuurN8LFun0UcVW+836dZkdSAA8kJv
 KecJAlt/ME/r5Q9MDcNIg7bYK9/TqmxEwHbt8lmxAa5xLGqp/q1n58s04
X-Gm-Gg: ASbGncuRssmnllPrjQVkuDXXFR/ACWN2ZTwv7DiheuMrTM0axytUrjuOVcwUJkeWxvT
 sr1L9qwGZVIPkQOMGCfPQAGghVMA8HyF1uy0YmuOe7ndI8EAEsGriKoPvALywo5mWC5voh5sKz0
 pf00Amk5vb0mixfKQHn8aB8ZrGANTfcN80bnSLUSTKmZKVESQWRdU/4IMNX37CsiZHD/E45IYN2
 XUy3pSkPGEuJUJtm2Qg3BzSbXW/JRsiaolSOmxdfQ7dZkRl7u8/TtTAp57mG/RGviclUffOW6JG
 AznPDbutzxVBZg2aToC9iUqXuGXHHHpYRvNSrVS+wO27N2bjgzqOIPk4z7YzJb/M
X-Received: by 2002:a05:6000:607:b0:408:d453:e40c with SMTP id
 ffacd0b85a97d-429e32eb338mr6401472f8f.25.1762428472590; 
 Thu, 06 Nov 2025 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGagXDTWo3yU7cNXjylIa20U/Dh2kdmWPjoR/572UlNzP10BZ0j9lFe2V4WwW78LgVsmAPLpQ==
X-Received: by 2002:a05:6000:607:b0:408:d453:e40c with SMTP id
 ffacd0b85a97d-429e32eb338mr6401448f8f.25.1762428472132; 
 Thu, 06 Nov 2025 03:27:52 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb410f7esm4489564f8f.14.2025.11.06.03.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:27:51 -0800 (PST)
Date: Thu, 6 Nov 2025 12:27:49 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Message-ID: <zwihgptp2i2syyyakkwefg2pfhihurf6c5wlrvgtlzfydxjzmc@vvwjl6gk373e>
References: <20251031164956.3409661-1-peterx@redhat.com>
 <4r5wbhkkk346usjdgvnc3epcom3he3y547p3smxbkvvnk677tz@e4hsizwn5sfp>
 <aQuq-ONNdEEJKmId@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuq-ONNdEEJKmId@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-11-05 14:52, Peter Xu wrote:
> On Tue, Nov 04, 2025 at 01:35:53PM +0100, Juraj Marcin wrote:
> > Hi Peter,
> > 
> > On 2025-10-31 12:49, Peter Xu wrote:
> > > error-desc should present on dest QEMU after migration failed on dest when
> > > exit-on-error is set to FALSE.  Check the error message.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  tests/qtest/migration/precopy-tests.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> > > index 57ca623de5..5f02e35324 100644
> > > --- a/tests/qtest/migration/precopy-tests.c
> > > +++ b/tests/qtest/migration/precopy-tests.c
> > > @@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
> > >      wait_for_migration_complete(to);
> > >  }
> > >  
> > > +static void assert_migration_error(QTestState *vm)
> > > +{
> > > +    QDict *rep = migrate_query(vm);
> > > +
> > > +    g_assert(qdict_get_str(rep, "error-desc"));
> > 
> > I think it would be beneficial to also check if there even is
> > "error-desc". That way if the "error-desc" is missing, it fails on
> > assert with SIGABRT instead of SIGSEGV inside qdict_get_str().
> 
> IMHO it doesn't matter on how the test would crash.
> 
> > 
> > With this change you can add my:
> > 
> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> 
> I would go ahead and merge a test patch if it had both lines, definitely
> not a huge deal.
> 
> However strictly speaking, qdict_get_str() is actually pretty efficient to
> make sure both that exists && is_string when used in testings. Would you
> agree?

It is an efficient way, I just thought the less efficient might be a
little bit easier to deduce why the test failed. But if nobody else
opposes, you can also keep it as proposed,

> 
> I definitely still want your R-b one way or another!

and also add my R-b.

> 
> > 
> > 
> > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> > index 5f02e35324..87e33b8965 100644
> > --- a/tests/qtest/migration/precopy-tests.c
> > +++ b/tests/qtest/migration/precopy-tests.c
> > @@ -763,6 +763,7 @@ static void assert_migration_error(QTestState *vm)
> >  {
> >      QDict *rep = migrate_query(vm);
> > 
> > +    g_assert(qdict_get(rep, "error-desc"));
> >      g_assert(qdict_get_str(rep, "error-desc"));
> >      qobject_unref(rep);
> >  }
> > 
> > 
> > > +    qobject_unref(rep);
> > > +}
> > > +
> > >  static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
> > >                                             const char *uri, const char *phase)
> > >  {
> > > @@ -784,6 +792,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
> > >  
> > >      wait_for_migration_status(to, "failed",
> > >                                (const char * []) { "completed", NULL });
> > > +    assert_migration_error(to);
> > >  }
> > >  
> > >  static void test_cancel_src_after_status(void *opaque)
> > > -- 
> > > 2.50.1
> > > 
> > 
> 
> -- 
> Peter Xu
> 


