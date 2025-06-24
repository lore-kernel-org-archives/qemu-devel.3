Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CEEC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4dv-0007b0-Rj; Tue, 24 Jun 2025 10:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4dp-0007ab-GP
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4dj-0005AB-Dr
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86er4zDBwoN4OLiniiAwU4qG2Nssjuqxo6burDew3l8=;
 b=fp+rxQOltw5yF15/HJ92uA/EG7Br/2dMzFxuiE7OXQBYyv7AbA/NfK3lCbUsQu5QE0tGzt
 TsLpBrN9CZNN12xyNCk9ZsD2L78v2nwJ2QfZNzdSYiSgdnDkJ7xMkvJUrnLwgLBCYntQ8L
 8yN+N8x0WZB2cL/Q2MNOYcSjeiFmFX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-yInpKLo4PWGq9m-qyM9JDQ-1; Tue, 24 Jun 2025 10:28:42 -0400
X-MC-Unique: yInpKLo4PWGq9m-qyM9JDQ-1
X-Mimecast-MFC-AGG-ID: yInpKLo4PWGq9m-qyM9JDQ_1750775321
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704cdbso37307185e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775321; x=1751380121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86er4zDBwoN4OLiniiAwU4qG2Nssjuqxo6burDew3l8=;
 b=RRNxD9sfWS5zXoRW+ZIqlSABJGdofLO+4AVVv8fgU/2uc8NEiiqn7YyH8N58CoIyaf
 1M8h2ICrYj+OvluF+yZY74WA7CP86TGOKJ6A55ydaVSIv69EwrMxmHBr242GkpCtTfZo
 tO7Yup8zyxvodumyoFUxtk+/ZbUqlfpHzAP7B7Jt7eHTtRf6o5pOlKq8L8/058HTkQHJ
 2BgGIEIkAjMAuGBGmp70cz/+PgS2nLbOHjNqCtotWIIfwLjcpu/iNVDbq+Tk9de9JK8R
 n1vKuHghRoJ4fp3i0ANNLI21MCU18rcWq1FBxqeNKurZpmnSLxHvRja903TRaNYJQ50J
 B3xQ==
X-Gm-Message-State: AOJu0YyTOWszbznobkbw7qxKvA90UxN4wAktnomDKcjYhvvd1nElwHjk
 cy4Dl8kmen16QwGioj4TJnmnbNkhQHmqBycW/nx2NR2ii88tA05hzlArPmi4NCLjMoSBrdmaLMO
 Xnm71yDeDixRoPwNd/WGXbLVpPchoOiimbGQhHpYWo4mFGpLA4eFU3MVE
X-Gm-Gg: ASbGnctdDbvMk7hPsDCHgID8rdoCvgAVr1qVAtB5vMkjOQGKAiOuLiZJJUKg6i78Lyb
 DCNVlGiwFELt+PgJVEb5zSg4B+xeI6wgs5N2uV/YO3mwkXPy7Ss2jRcONKD6foA3PVGPomgVxh+
 fX48WGwruVD1xTreZXqTEr+ZkZQX23Y0uALxVBxkwkTud5GXZIXKa1rgS9MxWQwUpOOEPsfAtKy
 TnPDVxJsr5/nXj3IGsrS258VJBC3XwjOvDCrknlB2b1fCXkpdAsyjkKA8TRf5xSeJShyjnjFG2m
 Mcb4dRSTH6E=
X-Received: by 2002:a05:6000:4809:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3a6d128a60bmr15184589f8f.3.1750775320884; 
 Tue, 24 Jun 2025 07:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA7NSZZMFwCZKH49DbCPrDJqZTOod0mJQN98OTXGt3BGOgiWFBpiAr1bdNm9ZKkoyzg3EVuw==
X-Received: by 2002:a05:6000:4809:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3a6d128a60bmr15184563f8f.3.1750775320514; 
 Tue, 24 Jun 2025 07:28:40 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f279dsm2147404f8f.64.2025.06.24.07.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:28:39 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:28:37 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
Message-ID: <3nscucdwhilkjdal2taucpn4mikizh2x5wqym6rhb2jai2kwqc@r7j6re4dtv5p>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613140801.474264-3-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-06-13 10:07, Peter Xu wrote:
> Unfortunately, it was never correctly shown..
> 
> This is only found when I started to look into making the blocktime feature
> more useful (so as to avoid using bpftrace, even though I'm not sure which
> one will be harder to use..).
> 
> So the old dump would look like this:
> 
>   Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59
> 
> Even though there're actually 40 vcpus, and the string will merge same
> elements and also sort them.
> 
> To fix it, simply loop over the uint32List manually.  Now it looks like:
> 
>   Postcopy vCPU Blocktime (ms):
>    [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
>     33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
>     40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
>     22, 3, 0, 0, 0, 0, 0, 0, 0, 0]
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Alexey Perevalov <a.perevalov@samsung.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


