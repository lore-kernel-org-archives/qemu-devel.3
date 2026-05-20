Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E29CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmqD-0003Lx-QV; Wed, 20 May 2026 15:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmqC-0003Lh-0V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPmqA-0000Bo-DN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779306265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7miFgHTUf5OvqQSkSaWKeAxOARukKuS7yacpLVTvuLg=;
 b=SeudB/v82KaajaHtwxzfnp38Zi3NHUGtKWN+Xn0SDLaQTsNeNVdq+XMhLIrDrI1z6eWm8O
 tGO5SS2xARG2ZjU9cxBoMCBpATVq+LPZeZPYc5jrUJpXZso+FZjr692ONVD5yz/w92shQx
 l9oeXpJF1CEqEJrnRExc0uYWh1VbO2Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Jjg2WT6FNCu0i6FaUQi_xA-1; Wed, 20 May 2026 15:44:23 -0400
X-MC-Unique: Jjg2WT6FNCu0i6FaUQi_xA-1
X-Mimecast-MFC-AGG-ID: Jjg2WT6FNCu0i6FaUQi_xA_1779306263
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ca1e4eeadaso149680126d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779306263; x=1779911063; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7miFgHTUf5OvqQSkSaWKeAxOARukKuS7yacpLVTvuLg=;
 b=EQiy1YmKVdetfQXnwSGZ7/31z5OkiaOEs9lA5Ea2gBqKUb+CsIW1LflGKbzOtKgRlW
 6m+3NGb7x71J9i7S76sLXVIsneWK1RnsnX36014g0yskvXyLB6E2yfQBP88nuf9IZv9t
 b3e1mti9CNp+TlpGADnOB4gBXzJdR69w1MGJH65N4LRIkopFaehSPKNO6tdqiKvQEWTo
 N4JQzdVfg7DDWbO8JtaCYa7P8Y4D3qXcbhEBIAWZTGyevO9kLspNRxzwh+bepD9OpWcR
 85TexlwlZbYfdB8vuSawAcDQix4zNvSz++lMBzFNFWb0sUR1fk4Dpm8V79vLAR5mCKsI
 Nxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779306263; x=1779911063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7miFgHTUf5OvqQSkSaWKeAxOARukKuS7yacpLVTvuLg=;
 b=ZZsDb4RXaYjbioRaMkAMqAeCUv7wGsjqtnXaYup4k4I/TmV/bgyUqWvvg3geU9zuP/
 08sQ9D3QqIhCgm/3AqyDY0RJ9wqLYRwbJNVdw8aHyGQnUoNhCfzJMOFREykzEz9mBXxo
 xLszTTOHIJFeoGnNukRhbC9KlE1l9Y53n4rySnmqVME926CGf0YS7bVsLp20NdH3bVGN
 B/6aqPf7umUIbkVlbBGF2tACs8+gx6wGVQ/MYa4KrzvFvJrQReTJVI6aOROrcNXpjT6B
 R6oWjn0e319gXevGuL5qT05C+TfPh9gNRUECzq+W/M/hKE/493g2vBqii7aNIobrfKKD
 kQKA==
X-Gm-Message-State: AOJu0Yx/nSyIK1m5OWCZH6Qc3JI4nYQWnRrgCVQGeAdzWM4X6WOgitBb
 SbdKLwGf1k36QBPL326mJ94EfK5XMJV4R25NdtL4rJDzXQQPZWrcaS4WQq9UMkmyo+mGDb62Ln/
 QERqJtUQqxrL5M6DsZ5SDe1bMGisguTLzdi6hbnzcDUu1VDrBj2O7fL5q
X-Gm-Gg: Acq92OGVeaAbAmEPCej6ZunJDWsNr8LVs1ss7IIgnaTt9A14A6cWvPyRQpM3VhZ4G0g
 4ttvDT95Lg0DFS2re0X/bVK4HsT7KncCAWkYZ8TvY/teHecX/SYJ6r0cNkkiFodGuGIIYg7N7bt
 9TPfgJVU/RCe9qTmVvckGbi3rjRLzz+aoSKvNMQTCbpZRsFPmr5Yeg/vJF9jqSVZ1/GgoAgpIlQ
 HsdIHV3x1KpT1JjgNp/NlpDwrjJjX0++E4MtC2gtIXVJ7+djfpmc/pEKJf85uW6hvQ2Zya8eSzt
 wfGraK2bzA52UKCXNpD1PGdMSNoeulGS+5Ugk0XoAD+gBDlp6VCtzkSADHmwy6QvoRCyle1WZPg
 2ayaRqzNS/b/VwKaGBUMkm4ZaqXXuYzxMrdaof5sT71TmO8w=
X-Received: by 2002:a0c:c243:0:b0:89c:df61:7a06 with SMTP id
 6a1803df08f44-8ca0f7063b8mr312464246d6.48.1779306263099; 
 Wed, 20 May 2026 12:44:23 -0700 (PDT)
X-Received: by 2002:a0c:c243:0:b0:89c:df61:7a06 with SMTP id
 6a1803df08f44-8ca0f7063b8mr312463846d6.48.1779306262547; 
 Wed, 20 May 2026 12:44:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361a7284sm137462386d6.40.2026.05.20.12.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 12:44:22 -0700 (PDT)
Date: Wed, 20 May 2026 15:44:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: use eventfd functions instead of bare
 read/write
Message-ID: <ag4PFEdJ9yIhtB_E@x1.local>
References: <20260514075136.301706-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514075136.301706-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 14, 2026 at 01:21:37PM +0530, Aadeshveer Singh wrote:
> Replace read() and write() syscalls on eventfd with glibc wrappers
> eventfd_read() and eventfd_write(), to make code more robust, readable
> and future-proof.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f5ef93f193..16113b166d 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1330,12 +1330,12 @@ static void *postcopy_ram_fault_thread(void *opaque)
>          }
>  
>          if (pfd[1].revents) {
> -            uint64_t tmp64 = 0;
> +            eventfd_t tmp_event = 0;
>  
>              /* Consume the signal */
> -            if (read(mis->userfault_event_fd, &tmp64, 8) != 8) {
> +            if (eventfd_read(mis->userfault_event_fd, &tmp_event)) {
>                  /* Nothing obviously nicer than posting this error. */
> -                error_report("%s: read() failed", __func__);
> +                error_report("%s: eventfd_read() failed", __func__);
>              }
>  
>              if (qatomic_read(&mis->fault_thread_quit)) {
> @@ -1773,13 +1773,11 @@ void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page)
>  
>  void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>  {
> -    uint64_t tmp64 = 1;
> -
>      /*
>       * Wakeup the fault_thread.  It's an eventfd that should currently
>       * be at 0, we're going to increment it to 1
>       */
> -    if (write(mis->userfault_event_fd, &tmp64, 8) != 8) {
> +    if (eventfd_write(mis->userfault_event_fd, 1)) {
>          /* Not much we can do here, but may as well report it */
>          error_report("%s: incrementing failed: %s", __func__,
>                       strerror(errno));
> -- 
> 2.54.0
> 

Unfortunately this will break win builds.  It's because these functions are
compiled even for windows, and windows doesn't have eventfd.

Ideally we shouldn't compile postcopy code in windows at all.  So it's not
really this patch's problem.  But fixing that would either need temporary
CONFIG_LINUX check here just to use the glibc API or a larger refactor to
opt-out compilation of postcopy.

I'll drop this patch for now.  Aadeshveer, if you want you can try to have
a look later on how to not compile postcopy code for windows.  For now, I
suggest you stick with the gsoc project.

Thanks,

-- 
Peter Xu


