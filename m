Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D6ACA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcJi-00036U-00; Tue, 29 Sep 2026 14:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBcJf-000368-QQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBcJd-0007ZS-Vx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790705552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/bH+/icoyseQhm0iBo/BYOXClhJ2bM3C7Up5vIbuDU=;
 b=a9CQclwwf6wP9uuDzJc2HZnhzHMR2/r1LiT8kT4+MUb54Zz3bupBgmFzfKWRGzt/mcIYGY
 zVQB9aGIk2Nv+0IS2Glgbw1dQFse/wygdlvrx3LtH+WTUpk41TbtBi9GQWh5MUhocBdQOw
 dG5zHD/939LLPR99ZKEFYoAgsmSRo44=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-DnNElg1YNM2XtO06eG6tUA-1; Tue, 29 Sep 2026 14:12:30 -0400
X-MC-Unique: DnNElg1YNM2XtO06eG6tUA-1
X-Mimecast-MFC-AGG-ID: DnNElg1YNM2XtO06eG6tUA_1790705549
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso197106085a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790705549; x=1791310349; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H/bH+/icoyseQhm0iBo/BYOXClhJ2bM3C7Up5vIbuDU=;
 b=he8+FO8HyHSDZVaxeJw+Qq/5Q40utqA6uyCZBie+ACsSxRZ6mDwCHZkLhvuO0ErTrS
 qE2rT0dDucqlycqmEwUW6so1u4DJfMaAvzWV6KLcXbz+70s5dCQeYyFFL3sfXGFFDjZo
 PgZsvnAY1pZ2PoagGhWmDH5ctxr5OgYowMGSHrgHvmW0bVF0us57GqCTbomrKKAAPAD3
 32hy5kMQtvlByjf5zCklzPLl6/uJ7caugR4ojDnhHX+vGM5yy46WZ87fPLIdJci/PrOu
 sD7onCeXUBvTKNatALN3DTUIsmWo50UB+HUSz8bTgfKYk6nYi/VGVAz6qC55stalnOjv
 tdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705549; x=1791310349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H/bH+/icoyseQhm0iBo/BYOXClhJ2bM3C7Up5vIbuDU=;
 b=npft7MBtsB1kmjh66qzCYrHzw1tO3nD8Yksj17gola72wBitNshRr8x5SHvFZB4UpM
 ItHoiRh9Fzm1vIbSrn8cAGPeKNBuXmQ6B+dexEStutQKTOOBt3OAqA0JEeZfl/DM33EC
 Iv9Z5g9psWiJSkH+Vo3Z0XbF3x0iDWjDehif+G+JHqDlkeR0XbVDxIuZPxIL+Opxa6OR
 pz3VL9soEbUyTVqsnN2n1cm0gfol5SXrRLp//9wy6kbSqvfBUg625FF/OvbG73s9zGRQ
 DSYhsSHTz5TECcp/TX2If0GMCu1fXhVw6JcXc39aEd1a5se/cmLmGxP2dukXLNk/Ntp1
 roLQ==
X-Gm-Message-State: AFuF++m488PUyYdQTApmo9lvxNLBlI4da2pEHv7Iqgg4RHY3u2FtQp5X
 zORSvhUDcygy6WgGZT9lWCyIBfRLcXp4k2/BHrUEm0O41F81VJKmPVCtJWSjLBgeDC/JOgZqhNT
 ewzNYgoHqLKQZjg4vQOFAQ4wqj9MWmhv+3h0WqYgFQqVFEkwi4MK0vQRoWd7iMpYP1UY=
X-Gm-Gg: AYBFou3hqx4cI/tUy5WZnB02xvs6Wat6mnyc8QHdYP45D/VfpWAKR0xUOtpTGNkhWqG
 ZZY4MA5WKjTQJdiY5KlQHWlmhvoa0F8cVZwx48rXPhfYhwkKhTDrfGCMB/JUP54FjznWnfLEHwI
 A1/OgQPrV63IfHdWgXWuATRt3j2gYusc08lWy8hORFr7vFU3xvzIUH4aiUgVqO9H3ANbGuibzXe
 PaenFyx8ZphYWgMiWj9U5fTAHAaa3jPvJKKfS8OmpNYDiVETlWV9p5V8G/N1nhO82RCznz5Y7zW
 jOM9JduIcy81ATbP0gE8Ng5sasUJwQsNkn7BFR7gLHyjmJXujVJwnFEguEpPZpADAx04JVY=
X-Received: by 2002:a05:620a:a781:20b0:93c:8d81:b879 with SMTP id
 af79cd13be357-93c9f9b863bmr58161885a.12.1790705549373; 
 Tue, 29 Sep 2026 11:12:29 -0700 (PDT)
X-Received: by 2002:a05:620a:a781:20b0:93c:8d81:b879 with SMTP id
 af79cd13be357-93c9f9b863bmr58155985a.12.1790705548842; 
 Tue, 29 Sep 2026 11:12:28 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f569504sm27652185a.45.2026.09.29.11.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:12:28 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:12:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v8 01/17] migration/cpr: forbid saving duplicate CprFds
 into hash table
Message-ID: <arv_i9Z03WEby3Yp@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-1-12bcf1c0b84a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-1-12bcf1c0b84a@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Tue, Sep 29, 2026 at 08:23:20PM +0300, Andrey Drobyshev wrote:
> In its current form, the mechanism for saving CPR FDs into hash table
> has flaws.
> 
> The CPR fd hash table uses the same CprFd for both key and value, and
> is created with a key destroy function.  Inserting a second element
> with the same (name, id) key leads to a use after free.  According to
> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
> value with the new element, and destroys the new key.  Thus when
> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
> 
>   g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>   g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */
> 
> Any subsequent cpr_find_fd() for that key then returns freed memory.
> 
> This is reachable whenever two CPR-aware objects register fds under the
> same name, and it happens long before an actual CPR, since cpr_save_fd()
> is typically called from .realize(), i.e. at boot time.
> 
> Apart from the UAF itself, when the user decides to perform CPR migration,
> on CPR target we'd get corrupted FD from the hash table and fail somewhere
> in .realize() for affected devices.
> 
> As a solution, let's altogether prohibit adding CprFds with duplicate
> keys.  Since FDs are being registered for a subsequent CPR right at the
> startup in .realize(), that'll allow us to error out and exit QEMU (or
> fail a device hotplug op) gracefully instead of delaying potential
> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
> instead of 'void' and provide an 'errp' argument to it.  That way caller
> becomes responsible for checking the return value and propagating the
> error.
> 
> Also update all the callers to use the adjusted interface to keep things
> compilable and bisectable.
> 
> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
> 
> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


