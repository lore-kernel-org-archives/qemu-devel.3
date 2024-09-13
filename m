Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6ACFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp7oL-0002nl-J1; Fri, 13 Sep 2024 11:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7oG-0002WK-W6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7oF-0006Ov-3w
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726239726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIXVHYkKVAOcWl5My6U+kkcZfRR0QV7Mba9k+0IaY8U=;
 b=BwJp9y1JiPECNnrJiI7s5LZ+6CZZf0U6CEeguRPYeDkb6RZW1R82SWr2g2rXEkglW+btOT
 IjfeS65DlZiH4CPzG2Yupa0DTg9QZuD9JYSpzP5NUy7NeKcJi6EbnMxS1m4b7is71xXb1+
 KkZeYs9VucPnuzuEpELTEl1TpY0knyc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-uHDaddkaNjaRCPzHsL9KuQ-1; Fri, 13 Sep 2024 11:02:04 -0400
X-MC-Unique: uHDaddkaNjaRCPzHsL9KuQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c353d32ea0so29116916d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726239724; x=1726844524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIXVHYkKVAOcWl5My6U+kkcZfRR0QV7Mba9k+0IaY8U=;
 b=ig2owY4a6Z1b7gNf0AJJh12WBxfoeIqNHDnd+n4Pl1lTHWp0CQ9Ya61NwVyN5IAfWu
 1gG0baU5a32QJxT4rglS76NBp3socg/nvYyqG0XEpjfmAcvwTC33+U2RZ995ftxYAcK0
 9Z8/wpwJAUZmKXH4CFQ7C2xoeFHvFmT6tDN+ZztjoGryb6Pa+etAClU/rXqzezbxbdEM
 C2tjTXIwPTia4/FK16b+JUFCa8lMfHFl/ts9PhQw42lgBJx0rlsGLkvsLJ/FwCQt8oJl
 numXPmJ08OJLm2iiHJbwNQfApmba3tYua5l+Bx/hfOMLcdCxrb23oe//bTGU5coq/F/4
 CCzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO2fl2hRoBZLnCRW2o6MkUV6/3VnyH58NgMMKxzd6eRgSl6nT4ZhveGDvDGSwFTkMCBqQIsDZvrvRb@nongnu.org
X-Gm-Message-State: AOJu0YwqcgnwoFYyrO61Udu4QYeBWeNOLFfDmc54y+QhQd7N7d4pDTOW
 dQYhCyQA8Zv+bHcQyJV4hPrS2HccOS365WgoE6guOk1XTwQZ5KzysThHPQy2RBpraGcqtHDCN0W
 WWuLJPzUQTIYHay5YDzOV/au/K3AyI+3F26ymgGh1tQZ7sa2vmZPB
X-Received: by 2002:a05:6214:4883:b0:6c5:f46:ced2 with SMTP id
 6a1803df08f44-6c57357a6damr88036956d6.35.1726239723875; 
 Fri, 13 Sep 2024 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Si6SQev+/BDAOCE1IH8E87SeffxyYqlpt1XJAwaEuDJgu+wGt8AtPA6m7wxQsCy5BtDV0Q==
X-Received: by 2002:a05:6214:4883:b0:6c5:f46:ced2 with SMTP id
 6a1803df08f44-6c57357a6damr88036516d6.35.1726239723417; 
 Fri, 13 Sep 2024 08:02:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d749sm67665736d6.92.2024.09.13.08.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:02:02 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:02:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Message-ID: <ZuRT6C8y4gZHQvHh@x1n>
References: <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n>
 <87ed5qq8e2.fsf@suse.de> <ZuH_pvnTCumKuXTh@x1n>
 <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n>
 <CAFEAcA9Bevk6Go_AgvjAhzyE-P_u6W0JS8deau09cU5zrPJkgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Bevk6Go_AgvjAhzyE-P_u6W0JS8deau09cU5zrPJkgg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 12, 2024 at 04:14:20PM +0100, Peter Maydell wrote:
> On Thu, 12 Sept 2024 at 16:09, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
> > > On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
> > > > I don't think we're discussing total CI time at this point, so the math
> > > > doesn't really add up. We're not looking into making the CI finish
> > > > faster. We're looking into making migration-test finish faster. That
> > > > would reduce timeouts in CI, speed-up make check and reduce the chance
> > > > of random race conditions* affecting other people/staging runs.
> > >
> > > Right. The reason migration-test appears on my radar is because
> > > it is very frequently the thing that shows up as "this sometimes
> > > just fails or just times out and if you hit retry it goes away
> > > again". That might not be migration-test's fault specifically,
> > > because those retries tend to be certain CI configs (s390,
> > > the i686-tci one), and I have some theories about what might be
> > > causing it (e.g. build system runs 4 migration-tests in parallel,
> > > which means 8 QEMU processes which is too many for the number
> > > of host CPUs). But right now I look at CI job failures and my reaction
> > > is "oh, it's the migration-test failing yet again" :-(
> > >
> > > For some examples from this week:
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <--------[1]
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <--------[2]
> > > https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
> >
> > Ah right, the TIMEOUT is unfortunate, especially if tests can be run in
> > parallel.  It indeed sounds like no good way to finally solve.. I don't
> > also see how speeding up / reducing tests in migration test would help, as
> > that's (from some degree..) is the same as tuning the timeout value bigger.
> > When the tests are less it'll fit into 480s window, but maybe it's too
> > quick now we wonder whether we should shrink it to e.g. 90s, but then it
> > can timeout again when on a busy host with less capability of concurrency.
> 
> For the TIMEOUT part on cross-i686-tci I plan to try this patch:
> https://patchew.org/QEMU/20240912151003.2045031-1-peter.maydell@linaro.org/
> which makes 'make check' single-threaded; that will help to see
> if the parallelism is a problem. (If it is then we might want
> to do a more generalised approach rather than just for that one
> CI job.)

Sounds good.

> 
> > But indeed there're two ERRORs ([1,2] above)..  I collected some more info
> > here before the log expires:
> 
> > So.. it's the same test (multifd/tcp/plain/cancel) that is failing on
> > different host / arch being tested.  What is more weird is the two failures
> > are different, the 2nd failure throw out a TLS error even though the test
> > doesn't yet have tls involved.
> >
> > Fabiano, is this the issue you're looking at?
> >
> > Peter, do you think it'll be helpful if we temporarily mark this test as
> > "slow" too so it's not run in CI (so we still run it ourselves when prepare
> > migration PR, with the hope that it can reproduce)?
> 
> If you think that specific test is flaky then I think that's
> probably a good idea. As usual with this kind of thing,
> probably best to have a comment next to the test noting
> why and with a URL to a gitlab issue for it, so we don't
> forget why we disabled the test.

Looks like Fabiano root-caused the issue.  We'll see how that goes, or we
can prepare a patch to make it optional with the comments in place.

Thanks,

-- 
Peter Xu


