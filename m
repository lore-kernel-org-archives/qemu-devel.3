Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A77105A591
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fcw-0001Y2-8h; Thu, 12 Mar 2026 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1w0YXs-0005Mj-8p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:25:18 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1w0YXq-00064X-2y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:25:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so287060a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 22:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773293109; x=1773897909; darn=nongnu.org;
 h=content-transfer-encoding:cc:from:subject:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Zs7BM+XRrkYkdhZEqv9PJE6354Ee36qnlXKFKMx0bq0=;
 b=AR3Yo23Bu9pmmQ0AwEVlbmX8zo5mY1G50EF6uhrgtbul5oGBkY/UDKeqSa6lmJifEU
 tts3FSOZEqK3Fly0kzp9FNJH22/Ga1JewRzqBPrliVUzKCdX5VfBg7VPrqWUowuQZE9Y
 JMmFYg110yv89ORdNlh30dH6svp9lDlKRNndxU0gZgJc/Q1L0Uc5u2/H93wfFBXDBInN
 0ji18Tfn77ZvXpWMGzCwxN+hrNBxrdyj8OONpJxVeqny0dkugwVrHHzW6gP+2V4tpxCf
 GEpQHnkQ9KZOJzFloN0hsjSd0bmi5H9md7kj8AF96Gor7ItM+klNkbQNOy6gxDO4z/Gg
 K+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773293109; x=1773897909;
 h=content-transfer-encoding:cc:from:subject:to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zs7BM+XRrkYkdhZEqv9PJE6354Ee36qnlXKFKMx0bq0=;
 b=TEjus7G8Hi3x8gpCRnPA7sNTtlN24Fro5eXxhCiAPLP+Ik6arY7JnRZkj8SK50Pftp
 LkMBba0YR7jJFvIz9shYIdvMRJfStVkJA/s4tmai060Zrl55H/GC0nYdFRfGfi3zfVHp
 IWdizcHnuU4pu6WNoYOupbKThcri35YNoQ8SGFoJd3DVPoAKRJK0HQYrN779huy7T5o/
 G9sJOcdIFDvS8sr/XtqTXeWttMKKAFRbKPVu7ZuH4S45XEdKn3sz9PFxxNQlA41nGI4H
 L/PSehBS6OmTjDCwBLjhKjUHrofK+bb6D+FkedcpKuMP8XIGoYT+GZb6RgcVBOu+o3Dd
 UrXw==
X-Gm-Message-State: AOJu0Yxp7ozg9oIBwbrUT+/dj9AbvQwApNsgkRwjt9hKHHL4Som+H0rz
 0+pdh+CsmD+/qUdA0yLzOMP7rHX8cojTA33IqHidY1to/p4WF1bqVHcRyDvJQbv+Dqg=
X-Gm-Gg: ATEYQzzaqoD0MPFO7z6tEvrfKTCfFqGaqypbbVslPWI6C0YMY1tZ5BMOs2VbTrx4nPM
 6vnaGtlTn2SF2T2EzRcCakt/sg0vWxSX5NlK44lrEp9OyJL/wJAe8wPrSDH7g1WSY/bCG2435Qb
 bEmgR4JAbaM5AKCqIfRFdQh3hBF7fqXHYWUEPtWUq92KTGBqgPtpWjH2/a9pDfn8ywAmozhBii9
 53Cyrk7bWJ79n4RdcjO0wfxtDJkrSNVkAan1SNMpYODjusvx17TaWF6VNxncgL1iUG6ivZPAmAv
 O5byreTlRcJn3aZa2S3mt0IHBQ3keLIiy0Xx7kyTKW+n63oi1IzDTMHs/Eh0cSCBiuxmJXj49IL
 c5gvQlTVGFJ+3qcNj7jsiFq9Rrk0b9cyX/h+PW7JQtdz9RMofbCiSchC2z/N+SXblWZpWwfvRG4
 94jR5YQcW+PSKg5tmgfcdAg81SjSyHDdyEvaw=
X-Received: by 2002:a17:90b:4987:b0:359:f7d2:a1fe with SMTP id
 98e67ed59e1d1-35a012248e6mr4546247a91.9.1773293109448; 
 Wed, 11 Mar 2026 22:25:09 -0700 (PDT)
Received: from [10.3.182.6] ([61.213.176.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359f01004f7sm7710998a91.0.2026.03.11.22.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 22:25:09 -0700 (PDT)
Message-ID: <62d074fa-6d4a-4ec7-8c1a-63e7a05c31e4@gmail.com>
Date: Thu, 12 Mar 2026 13:25:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: peterx@redhat.com
Subject: Re: [PATCH] migration: check is_active for old-style vmstate
From: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, caixiangfeng@bytedance.com,
 liwenbo.liwenbo@bytedance.com, yanfei.xu@bytedance.com, isyanfei.xu@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 08:58:54 -0400
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

> On Wed, Mar 11, 2026 at 01:16:58PM +0800, Yanfei Xu wrote:
>>/old-style vmstate doesn't use vmsd and instead rely on SaveStateEntry/
>>/ops. Check is_active for old-style vmstate to determine whether they/
>>/should be skipped during migration./
>
> Would you please dscribe the use case?
>
> We only have two users in upstream tree that provided is_active(), and
> neither of them provided save_state().  IOW, so far it works kind of mutual
> exclusively v.s. save_state(), afaict.

Sorry for the lack of background information.

We follow the vfio SaveVMHandlers and add an extra vfio SaveVMHandlers
variant with is_active. In our internal codebase, we set it inactive
during migration but active in a specific scenario.

You are right that upstream tree works well. I sent this patch because I
assumed the semantics of is_active is similiar to the "needed" field in
vmsd.

I'd like to get your opinion on this. Perhaps this case we used won't
occur in upstream?

Thanks,
Yanfei





