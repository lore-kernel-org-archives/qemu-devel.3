Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F8E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQsI-0005zd-V9; Wed, 24 Dec 2025 10:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vYQsB-0005yk-Hr
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vYQs9-00075v-HK
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766590434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=myEQTM9EAlKPT67BQ43n1thKyGeS70j9nVYWeKtmnDs=;
 b=RDqEmvwv3tm4JGwdSB3mixm7r9RCGSuBbdAMPIaxGvySJk3OLex3NsIUPFz8LUvSJEWyr9
 BniaDVa7Eish3bLBI2/0VwJGUteM5EDAT1WVZhFFK0DjST9MfsI5VZpc5/Ajh0guOHhuKn
 vl5M1oBZpukD2hoH8BG89xbE3nnuEY8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-JOJhFbLWNz6LulG9y84Blg-1; Wed, 24 Dec 2025 10:33:51 -0500
X-MC-Unique: JOJhFbLWNz6LulG9y84Blg-1
X-Mimecast-MFC-AGG-ID: JOJhFbLWNz6LulG9y84Blg_1766590430
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4edad69b4e8so126899751cf.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766590430; x=1767195230; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=myEQTM9EAlKPT67BQ43n1thKyGeS70j9nVYWeKtmnDs=;
 b=RhpVdkttKCZzvlHZE1Iq3tDTw3dGPPO6xuocm3u/+kxD1t4KwWVKdaAZ5PO80UK4fR
 aYH49EggTAdyBYxwIqkiLi+oRufmqsf5I/Hf4gSr1Z+mubK3mZT2xcsAsAusBvP28V00
 mGhmUkbqfhs82ktrp4wjgzcQfb9Ux0HRafwaPeMz+gZAnHNZ7FJccNmhP+vFKr2wVL4X
 EpLU79NeudmkA4cqLWtukTr+cTEC8ndToWkbzMgQh9cmIrf7GaC6gCeA1KiKpq3mYTWk
 0qvqz4ZlzADQyUBKk8NyYaPWYhIk6dmU2GbetNNlJfq19Y22SIFivfzwGeqUxmY3l0/O
 bX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766590430; x=1767195230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myEQTM9EAlKPT67BQ43n1thKyGeS70j9nVYWeKtmnDs=;
 b=enXUb97E7YRGnFs0a+PRzkWop+uIrhoPfZ3Uq5d4rUofqPVqOtoS23GK3OYwHDY3lS
 8HPR/b9eJr/nrTundh6XcyjDyI7GxEZlPcFzENqMzTVfC8UNRM0xp3E5U62MoQAzlsBT
 ZHE9MryM4IOzmdAUIQiCT3s2zR2hTjNO633KB6lCUpB+0yykWXjEymkRKqwNNDH28lFz
 oqiWfuKod17GUfmE4idlMiEDGaHniKqhIHCj3mLgPuaDh271T5Mk1vHsIEpTX7gjh1sv
 Codsb0+FeDyX/BBC7s7v3A+RDClWDLwyQXh6sWAiv/k5xhxEFJxyKEMyQiA+oTAX9pig
 g34g==
X-Gm-Message-State: AOJu0YyhOj01LjphPRBW6GNRO8mviKeCvadiqa+nmI/M5GRjdfrlc43X
 FZIm9SqAw7gf9ulLsmAapCoNRTa5JYIQkaqQmH4+UfLsHzXED3M+2RAUqKmwaQdXvO97KOOHr1Y
 GiaGqareNSaCXax0HyKKHkZcIePDP8wMAq70MU2P3angnuXYJrZRcGWWq
X-Gm-Gg: AY/fxX7Jcciab00lClUaDZ5rtWc49EOi3Z2Ku4Wto29P9TJ+QZo/ReQBOons2oG9lNN
 SCWl0RRTafwtMSkYXmnotMNfjRw9jsRKht76j88AGM3WtSBj0kOtsx48wIOkMwG8Jn561TzTurn
 bayKZeGSdNXYAj4GQ8XQrTVCO3+VAGwxiBqdgFBc0qpNwkoZpXtMyT3CoPSRK7U7mlfVL4QFkee
 NEimPezWoQgYXnTIV7lbtRQZAwpy+2W8mO4OIs46rxD+V+fBC6IQ7HGdrdS5DPF86d9qvTJJZ46
 D18oTpn86ul4rpeBn7W1uh0mTxnyS6GmZAsgTtenL+FlCfFAmfIAXfgFujDEg+euVgs7vkEHu7H
 0YQQ=
X-Received: by 2002:ac8:5a0d:0:b0:4f0:22fb:6c14 with SMTP id
 d75a77b69052e-4f4aadb042cmr226797421cf.32.1766590430425; 
 Wed, 24 Dec 2025 07:33:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmmOUjuTDZkzT397MQvDGoY9pTQt38/prS90Jm+i5TlHHe5oXkFjDOAk8J6DTLWKRrjwUiGA==
X-Received: by 2002:ac8:5a0d:0:b0:4f0:22fb:6c14 with SMTP id
 d75a77b69052e-4f4aadb042cmr226797221cf.32.1766590430040; 
 Wed, 24 Dec 2025 07:33:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4c46e4aabsm81159981cf.16.2025.12.24.07.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 07:33:49 -0800 (PST)
Date: Wed, 24 Dec 2025 10:33:48 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@linaro.org
Subject: Re: [PATCH 2/6] memory: Factor out common ram region initialization
Message-ID: <aUwH3O5fgklYuwOh@x1.local>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <c648e425d67ec3a7ebf51e40c2d149beb553569c.1766525089.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c648e425d67ec3a7ebf51e40c2d149beb553569c.1766525089.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 23, 2025 at 10:49:58PM +0100, BALATON Zoltan wrote:
> -bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> -                                      Object *owner,
> -                                      const char *name,
> -                                      uint64_t size,
> -                                      Error **errp)
> -{
> -    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
> -                                                  size, 0, errp);
> -}
> -
> -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> -                                            Object *owner,
> -                                            const char *name,
> -                                            uint64_t size,
> -                                            uint32_t ram_flags,
> -                                            Error **errp)
> +static bool memory_region_do_init_ram(MemoryRegion *mr,
> +                                      Error *err, Error **errp)
>  {
> -    Error *err = NULL;
> -    memory_region_init(mr, owner, name, size);
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);

If this is moved out, the err below will never be set.  Maybe this helper
then doesn't need errp at all.

>      if (err) {
>          mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
> @@ -1611,6 +1594,25 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>      return true;
>  }

-- 
Peter Xu


