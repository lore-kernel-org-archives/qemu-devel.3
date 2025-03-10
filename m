Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06C4C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgda-0001kR-UC; Mon, 10 Mar 2025 13:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trgdE-0001ZM-CS
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trgdB-0000f1-E4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741626558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgDpt+OER7O9gm9lzamU+IWX4JgB63QnkOewjK3YuXU=;
 b=gLvTAiysioQRMgZdHDf/3WM8Rhe8LRtemgctvMz7vmvleaMcb+zE9ljY96kQuN3+0a5Xi6
 o34vkYwv9uy/Qj5WVLQaitX5A2TqNK8rAo0kbSoDDDNhWXUL6xRRQrGANyLQScbvda/GkC
 8PJlNkEVHIvtaEXaABOhTzfDnO6RBBM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-ciwbeJKLMsmLZWfqONrdBg-1; Mon, 10 Mar 2025 13:09:17 -0400
X-MC-Unique: ciwbeJKLMsmLZWfqONrdBg-1
X-Mimecast-MFC-AGG-ID: ciwbeJKLMsmLZWfqONrdBg_1741626556
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913d8d7c3eso1126650f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741626556; x=1742231356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgDpt+OER7O9gm9lzamU+IWX4JgB63QnkOewjK3YuXU=;
 b=kFSNZqCgF6dHAVyGlEXDNwZoQeIZ9tPR41CKAzKv7D8zIvrx+62vilDCnNkRA0Iwc0
 5ILl9BeHa2CwuLkz5DEqag7P/0zdhdCZoGoIk0s3CLDEvtfk1geMMdg/cxY9cKtL5tNY
 EhcE8X43Dh7l7LEqFpIYkpKxwZDzzTNU1MwKoqiOV1HJzNb+aUGHqd6zDZBYjI8yn3Oo
 xa/eCP4/Qev+zhrk8NG74vJreoIQNTHP/YTJyFTDD0+3ZfnhkX1fSEY9Q52mpGibUN8C
 ZXsjtybJ2CMX3vSnCnHBLSZBOhIGcAQPpV83VdjgR6IORGmlmCLu9S2k3mU5FNLHxbVS
 P4Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGBIlSnEEpj8tayrmLTQ1UhLrNYiwUmptzPKBAiEJipm+ISr5Eb2vvqYI6ZWxGFaeek5ckNpNQQAEq@nongnu.org
X-Gm-Message-State: AOJu0Ywe0/CoecI2zwuV4xH5mrtf7gfjkJvk/TZKDrFAh3mCgx031aqE
 ib2uaf/ZqkmdP48QmwomGkPZY/OrpvfHeK2e8OzyOjIuRn10BFj1a+H/h17txKX7djRHXi1FmAH
 Dr/f7Vf20fu1M93/n+8Q6T3GXeS0kdbWV3evN2pm6bcr4tKlD+BOh0bQbLVHoLav8hK5LnvLoLM
 zLx/d8CGjPjQPmMKO5Vjv43XjPjD8=
X-Gm-Gg: ASbGnctdZGDyUr/ROfT9BvGa5Qdl9ei1oRw8PFdqlDjkx4XFdhyzHxN90/F92l5iogy
 z14us/5Q4yC92CfO6/MgqrRanGNdZhXkaWIAA107gZyXoX+dzw+Q4RbTFwusItaVFFDUtlf/6Oz
 w=
X-Received: by 2002:a5d:6d06:0:b0:391:4bf2:6f0d with SMTP id
 ffacd0b85a97d-3914bf2703fmr2987121f8f.52.1741626556003; 
 Mon, 10 Mar 2025 10:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPQR29IgkRcUkmvegK1T9aS7ylrhRhpuvBBEdEbSS0paaMYSNfW65j6kY8lWpjMTIER35xFWDblzqqHOvVufQ=
X-Received: by 2002:a5d:6d06:0:b0:391:4bf2:6f0d with SMTP id
 ffacd0b85a97d-3914bf2703fmr2987084f8f.52.1741626555684; Mon, 10 Mar 2025
 10:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t4YoPEnwJO0sFP@x1.local> <87ldtdt0g3.fsf@suse.de>
In-Reply-To: <87ldtdt0g3.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 10 Mar 2025 22:38:58 +0530
X-Gm-Features: AQ5f1JrIsEWi7EiZ0rYeL4fBpMtn65ACSv8btj4xoEaZHwFME-XBmyp9ghsCAKg
Message-ID: <CAE8KmOwrbJnxS7How7=dhk2hnUUUjKzgEmvT2iTh+BpUa7n1WA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, 10 Mar 2025 at 20:09, Fabiano Rosas <farosas@suse.de> wrote:
> Good point. Shutdown at random places makes it difficult to protect
> against cleanup races.

* Just to understand, how and where do these races occur?

Thank you.
---
  - Prasad


