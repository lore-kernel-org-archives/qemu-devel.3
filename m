Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B3BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgp5X-000234-4T; Mon, 06 Jul 2026 15:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgp5V-00021a-8b
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgp5T-00080w-Q1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783366478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9qwNIZLcJkC+kIzZ5p5F8HeCdfRP0EO+fqRt71vwn0=;
 b=KCOaDXIRh76Dv7H4GAOynlL67aq/iUVj7XevI/Q0+cd+FOVbg+/qfqp9lvj+N+QDFbZN7Z
 GKOQzhNH4qxaTbQlKufFbOcoQyhdePenq8mUxrLjfoeElW/rrF+pChDnBNxVuHWGRwWIvE
 23KGcdBrB8SiiDRXU0RsHk+wp5YoLN0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-M5hN7xluOjWILxwjacv8nA-1; Mon, 06 Jul 2026 15:34:35 -0400
X-MC-Unique: M5hN7xluOjWILxwjacv8nA-1
X-Mimecast-MFC-AGG-ID: M5hN7xluOjWILxwjacv8nA_1783366474
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso630275785a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783366474; x=1783971274; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c9qwNIZLcJkC+kIzZ5p5F8HeCdfRP0EO+fqRt71vwn0=;
 b=dgAhlfcnnC6Dn5xp2LuypLEQEXwPWPk5qOyB9KSrn1NugwGpuDTZNQIlFnEhzG/ppZ
 O+FU1qD98MrpLLJhx5qt3RhFD03SKTGfLA218qjsTODc5ZuIYdPFMdwDCAxT6UnuGrU8
 GLmul8MygdPm30GidaQFXkXyUAllBm67n4P1Y26BPK4J7AIjkIxnyL6kG+AkOGx8ggLo
 hGT32MNz+gQ2EQ9yUS7WntKXUSNBvMXJ+5frraM/BVRPn39ohelVHSmsSm2h2FFjI71O
 kIUs7T0dkH587HmipSB/eAqAj6wDztQHJhbB1tIeQ95G2is4gz2ggzx/bEmD286YmCH+
 OxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783366474; x=1783971274;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9qwNIZLcJkC+kIzZ5p5F8HeCdfRP0EO+fqRt71vwn0=;
 b=QzLd3a8VDikmzfzouUHPY4vfpj2BL1N8n8Bha5ROTGnsoPYMZ2+m8F8g1xdm0AJcBn
 MEIfveP9amzYhUx/ZIW+OertnKq/7Xmr9OxGc8X3wU6JNOXu6sGcMRy2EBdqQ89Zgucv
 USnQtmq6ke7mh7XGN5DBj6S+v/hEAbvWlGQH1Z+iL2BRwZ+gRgrut0T150WOoChsRoKy
 9QKcFL3L3KYYCFGvEcDxs5+IP/iSiwfKVChchqyxy8uj3+CH58n0rjyFhBsw5SB8p6O8
 yzN0ySPZ2ph7GwMTQH6CxR6zwM8mkk5xprlKUF+7oV7ZZVALtTQJ2pOX7fk3oN8TdMmc
 V70w==
X-Gm-Message-State: AOJu0Yx/F+PPeVqjhjnxrsc+02qvuRU/jNFBjadx3vSGPgUXUciGuRKk
 B7QAVUyPpl3oaCODt346xkAQfmTybHh+jUtSrsKow6WCdeyg7rdkLBFqhkAh/OuSFNKzQaEIko4
 +FrhWLsI0sUobPGRGzByM1k5F2zKSt7bjxAJZ/cNCcYDeoK5bh8+kKqy6
X-Gm-Gg: AfdE7cnqnWSeFlkbbeFZ5YqMFrDu5YiOpfWze5vBKydscj4NFCSjkPujnjQBC3AzAg6
 qYxvS3np45PxwTqMzC+nwvL/pO7mC81re0IG5EZRM3OAnXvlQb0bqvBxO7EVNaAJiJ6MzBHB5KX
 IiFAlowlWLVey5+avO6qsoYHRaPNTeVdntI2MJnSqCEbMDiEfexPyCN9EZjmkZH6XXZnXFbD65K
 QoIUu5mmtnTI1BJKeulT7ZjVvmgTXMuAI6UmQ1X8Q6IQfBP0nT32OcYbqZW6VhAZlBIE69dCM8W
 HETPMSI9UvlmCw2X/dUPPFg80+5//0WextzxMdO3rK5M2zzrP3RpM+25jpHwIetIxH3Oe4tIOZj
 O1Qc=
X-Received: by 2002:a05:620a:6f06:b0:92e:6a0e:a192 with SMTP id
 af79cd13be357-92ebb57e75emr270891285a.49.1783366472656; 
 Mon, 06 Jul 2026 12:34:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6f06:b0:92e:6a0e:a192 with SMTP id
 af79cd13be357-92ebb57e75emr270886585a.49.1783366471979; 
 Mon, 06 Jul 2026 12:34:31 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b800fasm988176585a.6.2026.07.06.12.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 12:34:31 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:34:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 4/7] migration: Make qemu_get_buffer_at()
 thread-safe
Message-ID: <akwDPP-jG07sUOac@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-5-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-5-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 30, 2026 at 01:49:37PM +0530, Aadeshveer Singh wrote:
> Remove the internal QEMUFile error state modification from
> qemu_get_buffer_at(). This function is called by two functions, both of
> which already check for unexpected return values and handle their own
> error reporting.
> 
> Removing this shared state modification makes qemu_get_buffer_at()
> strictly thread-safe for concurrent disk reads, serving as a
> preparatory change for the upcoming fast snapshot load feature.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/qemu-file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index d5a48115bd..c73f8178d7 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -553,14 +553,11 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>  size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
>                            off_t pos)
>  {
> -    Error *err = NULL;
> -
>      if (f->last_error) {
>          return 0;
>      }
>  
> -    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
> -        qemu_file_set_error_obj(f, -EIO, err);
> +    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, NULL) < 0) {
>          return 0;
>      }

This is better from thread safe pov by removing the function that isn't
thread safe, but it goes backward too by dropping the &err to capture the
verbose error.

I think a better way to do this is having Error** passed into
qemu_get_buffer_at(), to get both thread safety and verbose errors.

I should have suggested that last time, sorry.

>  
> -- 
> 2.54.0
> 

-- 
Peter Xu


