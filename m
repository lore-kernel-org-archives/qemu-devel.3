Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B26C47BEA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 10:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4i8-0006uK-1q; Tue, 06 Jan 2026 05:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd4i6-0006ro-DP
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd4i4-0004FI-Tf
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767696884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/d6zsRzw+dwIyt/+Kj0Rrz6svzF0+2HnqjFG88qLCOw=;
 b=SSXZ9WtAvaF3olhwiJlfdnmaTnNCIjO7WZr875si4KfJPS3pD0TagDRKeQxvBDzt29fYWF
 c+F3Z9ugR0nV6m4xH988pXiK44lyzwtKRZEFahhI1YD0m6fbeYF7Wxa771DCPGL8pJ4RLO
 Z23kBvPfQUbtGW2dZzzwi7btJ9rlgcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-N1sDFCnvPI6j_szAHyTpqA-1; Tue, 06 Jan 2026 05:54:42 -0500
X-MC-Unique: N1sDFCnvPI6j_szAHyTpqA-1
X-Mimecast-MFC-AGG-ID: N1sDFCnvPI6j_szAHyTpqA_1767696881
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43009df5ab3so556370f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 02:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767696881; x=1768301681; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/d6zsRzw+dwIyt/+Kj0Rrz6svzF0+2HnqjFG88qLCOw=;
 b=OHXweDQv6OjNHGLTQQJS4c4kXb9udcOeb2MzTA/6T2N7GM9TBJUBRimV2vu7oEqSdE
 jCPjPF+obC8GOoHWCTyEtGBhgV+V1rfZTz0itCjwWJxUDLQf/jQfhZX6fhZz4Utlh0Z2
 WCkpJZsHNFZA1A1xd3qG3FT8cU7TuGA8AteamQnBWoV4IjoO3HICYNEFYB4/uXTlByp4
 0sKgvEGi40SEakjkbXJHg5kH2CmHffb/pizuGvM6FHKAyk7t00IWRLPlxcQTZQ5BE735
 ZKxueF0OSchArgpNi+BTdkcZvee5qtjgU7pHwCyJf5MDmPY1dyf1Z/xpfRxksq84QkR5
 i7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767696881; x=1768301681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/d6zsRzw+dwIyt/+Kj0Rrz6svzF0+2HnqjFG88qLCOw=;
 b=WvIt7VVXqSnRiI/WwOQxhUj7/Dh2MaE6D+f0I7BR9uvd2UfPBzu5KnrpgiJhnJC4k2
 TBuKLPYrTTbbOrwtW/d9MIuOlxFb8Gyoe31jOL5IDYD1txfGW8SJL+oTDKhI1p2U5For
 1IlNMUQ3o1EPWO0FV7gvq0iFUMweCjWqyhuR9rIRaUmgQnIUcleL0MI4Wti/ga3C8bLQ
 eh74ghjSZpMJbMmeDVo9evfvRqbYOHdJ0BSlLDwdO0d9DEHmR5tgJV5CkFqRDy8ry1xa
 qUO0DWGOd6U2lOvZZ4t4HqnZhTu8O3mSgOyBT9D2kOTbFcbfsJ3YPImNdiG/8EDZP9nX
 AVOA==
X-Gm-Message-State: AOJu0YwH6ccqgUot714wGVng/3kPiA/JmTLU/h5Dplpu/ov4rhO5n4II
 s7eRH/mzUF1ZlgtdbHUOLzyqUmzHtqsr/o+OFruyTHIe3zfBi/Kk/yxxeOZ3xPdyc4fMAXB7YlL
 R1a/zve0exyPyD7EFYj3Sw49waw6D26asS/oGDgenZBLED0xxmYtHCJ5dGhvf84pVXsck4noL8V
 xbkN8h2QFLFrLL+PQvLiGlFdWMWvcTFzA=
X-Gm-Gg: AY/fxX7UZIQJU3bR1RGQH9NaPYP70owPrf2vU06ZoMq40qFv0TuLGyIsKlS42rM3c3L
 MtVJXYINC4so+5+m5psRfpFQymLAHu8klWaQlzSzKpqF9Mi3lqP/vvf4+d323cFn0opxtVqJHYs
 qmyNoUFrS6W/ZviA1SkrF92BuvgAUG5nCGKG9y/PkvX/JpPDSmck+1+Vj+CDHo3/eoNMw=
X-Received: by 2002:a05:600c:1992:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-47d7f0a06d0mr25378995e9.28.1767696881472; 
 Tue, 06 Jan 2026 02:54:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyU2HLgMAeueV7IFnvj6PiLwbI+LBGVHSO/K7XxfCUhAH8o9LAqOnmR7U1gv761A7mei7qNO0NkWGcoQFS600=
X-Received: by 2002:a05:600c:1992:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-47d7f0a06d0mr25378725e9.28.1767696881105; Tue, 06 Jan 2026
 02:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de>
 <CAE8KmOweak15R4Ji6F50b_za67q=un_GDSEMGCRTYeQKod7zQA@mail.gmail.com>
 <87cy45kzo2.fsf@suse.de>
In-Reply-To: <87cy45kzo2.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 6 Jan 2026 16:24:23 +0530
X-Gm-Features: AQt7F2o6DSfXTJ4xFmmbF--j23iQGCfl0kwaf097bPmzIRzXVOA-wc3_UzLKJnw
Message-ID: <CAE8KmOwgDboiN-q=jt0Jic4Gqdsp49nyRC7iwKrQokdP3h9yVg@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
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

Hi,

On Tue, 23 Dec 2025 at 20:34, Fabiano Rosas <farosas@suse.de> wrote:
> Yep, 10 years from now someone will look at the code and the commit
> message and be confused when they don't match. Also, for anyone
> backporting or searching for bug fixes, it's good to keep things tight.
>

* Looking at how we are changing function names, I think it is best to
avoid stack traces in commit messages.
...
> Yes, the amount of states migration_is_running() checks is an indication
> that we're making life harder for ourselves. It would be nice if we
> could have some idea how to improve this the next time a patch like this
> comes along.

True.

Thank you.
---
  - Prasad


