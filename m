Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D761C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BkC-0000sD-9V; Thu, 03 Sep 2026 14:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2BkB-0000s4-9A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Bk9-0000Xz-5q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788458455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcT2yrDtRhT/a1K8KpH3AbYvi7cN/hlWJMbET45TrxY=;
 b=TEXSkFuE2qTpXl1xW3A4bdr3UsnasuAvO7uGqci+/HWJaY61RP9ph+N6kR280Pyh7juQmF
 bp5+MI2LUZ3j5E9B84sQBMblNp+fzX7OTxdtL59Xu5dtwmi3Q6NEPFxS1ih9GPtW0JUXxV
 jnaSo//n9KxVYomuVFKGho/3bcHxT4c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4YQN0uvmN2i0cId1cr_Ohw-1; Thu, 03 Sep 2026 14:00:54 -0400
X-MC-Unique: 4YQN0uvmN2i0cId1cr_Ohw-1
X-Mimecast-MFC-AGG-ID: 4YQN0uvmN2i0cId1cr_Ohw_1788458453
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9103c9c0b34so3166556d6.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788458453; x=1789063253; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CcT2yrDtRhT/a1K8KpH3AbYvi7cN/hlWJMbET45TrxY=;
 b=ZkYLeW5GDFufZoS5OvaVWeChr8QQoeBdY4OXXaBffShre9mb1fYWfH1Fi2lRQ2CG4V
 vAyfd6WnYwwRMnoNHQykHPnuPI0iq0KUDRgqGYEfJV1I1rsX3m1BGkIniX8FYHaypIYs
 K/Ybqu92M+yfb2GF/ybpE1k84/T7MYcXBF/ykrC6MtTTI0Z/EVNtYSfm9E4y00YNyBo7
 YYnWAAy4xqH4aDhjXYsBXMhyg4BkTCn1VhdEiXI51fq7jFrKpOMQFdIY8t5h1DUrfz59
 6ZIN+0KbWlVh7RwiHdEL8bULwVtiIumXZPKJbAgp/IgwsgxQLg+BwHktUgsz0Ljiiesz
 ACPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788458453; x=1789063253;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CcT2yrDtRhT/a1K8KpH3AbYvi7cN/hlWJMbET45TrxY=;
 b=I9fFE4w5fOkh2SfvuKmF2LYxd9tciHl2+AawId2c1R5o2kH6R0O34hTeRxrZk085s4
 OSlaUWfH+toz7qID7Uo/n+ikEgfpUks8fyRPq538jrTncr/8nq5S3utgn0ra8Y33eSr7
 xZV3mofSaGAQ7RjHTjiocaqBpoCt/LE4/Du4O8I8hNcQR+qi5B+myBRjptdYzGBA86N3
 9mRVftCj2/nMsk+OmFz33G++Xays5MusyqBHd09nfN2/X6QdMThDX89MBD7vexk+QwVR
 HNSU4jrwTt5zgqmEmM9639Nj/wQwhC9txu3xBTJlGUbWNWDy7oyJaUc4BoWL22OkUHHp
 UEeQ==
X-Gm-Message-State: AFuF++l0+Xkc22hDduAvahyEeOkx9gqjCuVbd0jQlCKk/u5rmq6v2u9n
 xyJScUIYAux5OjuF4ZZshhDlXUnJCT3oXcpJEUuLMSOOUjk5ry9Bjuzp7Q3ERbgSeBZlAv2Tgsy
 yxSwO2UXKSxbB8Px5Hq1aZm6Uj+xgdDENO/1mbVEiozH87CsqxbyMhCAJ
X-Gm-Gg: AYBFou3AKLqnfx5kezSPl9f+6yfGo7+D6gUbOTeJ3yqILe36rwhYAmeeE1/B1+DuWNL
 roRVCpTSzWI3l209nvTGu9G6QWtXNOO5vewiSOjvyq0Xua2T8KHhy2ovThNrmX5nJJwD3OJFQGs
 x0qmR8RogCLLipZNTI9Ta3/WYZqQdN9p+P5Iw8zk2wHmN+yPeaw9YHI+XP2WCPSpvpzYfe6bjyu
 OwtmdhBwS75OKfZfRb1bRWxYjyUR3zOcG6nW54YDsH57hfFvWWcnwod2q/Ov244YKw0bjft122P
 kPPS8H/Ka2+CpFFNPdV0+F1s9npgyHVkWBzhbp6fiqktv0mz6a28C5P8r/3KEAhwkOOrXoTBQku
 LdjzxClSLPmfukIpu+adEZ2ZhcEyAbdgRFH+wTRfeY/lKFdgL5VMTerByUGM=
X-Received: by 2002:ad4:5749:0:b0:90e:8e12:d337 with SMTP id
 6a1803df08f44-9103ef7489dmr10603526d6.2.1788458453344; 
 Thu, 03 Sep 2026 11:00:53 -0700 (PDT)
X-Received: by 2002:ad4:5749:0:b0:90e:8e12:d337 with SMTP id
 6a1803df08f44-9103ef7489dmr10599406d6.2.1788458451299; 
 Thu, 03 Sep 2026 11:00:51 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406625d9sm26186d6.20.2026.09.03.11.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:00:49 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:00:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
Message-ID: <apm10EPO4vYlZLQZ@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de>
 <apmwZbSLZ46yvGmT@x1.local> <87bjae8bya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjae8bya.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 03, 2026 at 02:46:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
> >> Using newlines in the g_test_message is fine. It automatically adds
> >> the '#' required by the TAP protocol to the start of each line.
> >
> > IIUC we have such check not because TAP, but because all these functions
> > will append one newline at the end, hence it's not needed.  IOW, if it
> > applies to g_test_message(), I don't see why it doesn't apply to the rest.
> > But maybe there're other reasons?
> >
> > To make it simpler, maybe we just call a few times g_test_message()?
> >
> 
> Not sure I understand your point, Peter. I want to be able to print nice
> messages in patch 9:
> 
>  g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);
> 
>  # HMP output mismatch for entry at line 55:
>  # expected vs. found:
>  #
>  # max-bandwidth: 10356305952768 bytes/hour
>  # ---
>  # max-bandwidth: 10356305952768 bytes/second
> 
> What would be the issue of having newlines here?

No issue here that I can see.  My question was, why you moved
g_test_message() out only, but not all?

My gut feeling is we check this because people forget that all these
functions includes a newline.

So if your point stands here that "newlines can be in the middle", they
should apply to all, not one.

But still, I also don't see why we can't invoke g_test_message() a few
times here too, if we want to avoid any global touch like this to land the
whole thing faster..

-- 
Peter Xu


