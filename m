Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F9C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtReV-00058X-QX; Mon, 10 Aug 2026 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtReT-000564-Sn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtReS-0001iZ-Df
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yrx8M8Vk3IsULFypRrJcH9qWmMCESUzQ1dG4LmLs6jQ=;
 b=ba7lcnbw316m+KfMMSGEBuZKI/x0zYyZQ9RH9foAEfIjfQkjjJPtAAnUXUlt8xE8ZZWvgc
 Jg8EmE7lsvi6HO824ajlt02ivDOz0i8mqM/D5rVyfHZ4L2aqG0C3dt2+QYD6lD9j/IlS6q
 DIWPno0lgfJmzWbiuMisWVRGy+fdSrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-cA7nLQ5PPI6ggRXG33WjKw-1; Mon, 10 Aug 2026 11:08:46 -0400
X-MC-Unique: cA7nLQ5PPI6ggRXG33WjKw-1
X-Mimecast-MFC-AGG-ID: cA7nLQ5PPI6ggRXG33WjKw_1786374525
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f90dbaf84so1697603f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374525; x=1786979325; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yrx8M8Vk3IsULFypRrJcH9qWmMCESUzQ1dG4LmLs6jQ=;
 b=QXKR8rAxN4vsj7pTew9kpMWVr0OhUiFZDEkAX10gg3lkdxNOwW2ZbZUm85TfZ+7ibL
 oUo6kWApppV5Q29rEuuohucZaYh287VXEVVTWfKeCZcRnRRnjSjvSP0mHPTXaxj3Vzoj
 wkYpUE7HR16VdphS/TbJ2kQ+D8OH/Y1ZnBBP74u3mIpqmR2qWYdk8fCdIM5tkcj0ggBo
 ysmxEhlvd0TtcQ+BfpS21RCwTVeWz/6QZN8JI7/hOglhXtMTCQUwL0v91NDhbvanxa2Q
 oEea0Gfn3P+B15HLAlLtaKKxaNv2PchyEzMSVYBjUfF7rl0ornb5U8G5CfG1oQ9GR2yt
 /uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374525; x=1786979325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yrx8M8Vk3IsULFypRrJcH9qWmMCESUzQ1dG4LmLs6jQ=;
 b=OtJkaIM1kngq+11p+7cx4C2gg8Kqtuxn++gCBoCqNg6JW2IzpLFbgS0SSUZt3YIhux
 CjBxj4H8Mr7e3XEeAJkUVtFWEjvmroBEvEHrFr2FV3+5YqVims2jUAUfUPIWQUZZ258g
 aTozZtZHVRf6Y2gwJiecgBpVxB8DgNobGdC6BJirZZEW8+AMExA0gCS+8ERAQ+5cn1AH
 4/04sRNYhK+IbRRIjuhdmsLp0XKzL0+HcvjchRlRcfMpti5ox7GjXIOMNlFnPWyoerZw
 GKtjY9aZ2CyHoR051cHg9iesv2AdGyZxtMzkjlzSHOkAmXjNjyHQ6fzFjJVcUekPqxR/
 B9xQ==
X-Gm-Message-State: AOJu0YwYG4nYFXACpTgaLBDtJZ3G9FGptzzvJW6k7waSNtXzajnBhgxo
 QrbyIGo4UrmytoJ7nvk0+VTfmW1UEnvuaWjtK5XL/A322ecYsbey4bG6DHPqnIqS2/K00txu/rq
 WyJgiqj2OyuEGVC6gfIiAxrcQnLTb+rdb8t2HUPT0slNUWckKWeW46qON
X-Gm-Gg: AR+sD13NuYhX9ArKKgDo2/1G4rz/hy1ot0DUtNyqSyqosfYjU9rFFAL/upz72jXdo/G
 CKyUBk7o0LgRvDJAWJ//IJEptJPh5luzL3wGIiNHEwc6OKMOi2wik8hXa2LPIGSbeEDfMsJ+RCM
 VgmA3tKyeALEIO25dureLr6mzbfEr4QQhUaLMwKdWBl2Jgyg0tHyT2UNZyeTSCWwQGXGZ3g0Ev6
 YXMmljUD6VE+iGDhAWN55qNWfswEKW/Nv7JbdMxFQbKx9sCsQjCqnZ0U43YpNjgo5hpyXQupOXG
 NH9UqcN+XLC+hPOkE0fJnWSgN+2zwQBZPZFwpTwLYzeqTm+YQC3xQJIf
X-Received: by 2002:a05:600c:8b5c:b0:496:bbce:f3 with SMTP id
 5b1f17b1804b1-4997276902bmr38771955e9.6.1786374525420; 
 Mon, 10 Aug 2026 08:08:45 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5c:b0:496:bbce:f3 with SMTP id
 5b1f17b1804b1-4997276902bmr38771475e9.6.1786374525080; 
 Mon, 10 Aug 2026 08:08:45 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995428f294sm416675945e9.15.2026.08.10.08.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:08:44 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:08:42 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 02/11] migration: Extract blocktime marking helper
Message-ID: <annpZ7a5pohaUJ6h@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-3-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-3-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Use new function try_mark_postcopy_blocktim_begin() to call
> mark_postcopy_blocktime_begin if page was not received and return if it
> actually marked it.
> 
> This will help in having a cleaner API to call
> mark_postcopy_blocktime_begin as it requires the page to not be received
> by asserting on it's existance in RAMBlock->receivedmap.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c    | 24 ++----------------------
>  migration/postcopy-ram.c | 31 +++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h |  3 +++
>  3 files changed, 36 insertions(+), 22 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


