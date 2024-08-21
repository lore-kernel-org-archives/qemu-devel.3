Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE47C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgt2K-0007lm-BV; Wed, 21 Aug 2024 17:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgt2I-0007lC-DN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgt2G-0006RV-JX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724276310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yzPLeGphznbrFVeiLntbSUTXLxRo60HJZ27GWaBktO0=;
 b=cfdKiXf/+/80B+2x/LkgvvqscJClkNIyTTGgPf0mUCFdU1dgG1oyq5f650CgNee81y22XM
 qEQvKx46JWZACo6fv285ffKwFV/hBpob4p2FSe1gLMrG7La/quIuCmy9wipDxuw3+86kA4
 sRU6Fok82NakVc1wTOBw6P1xTA3iJEo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-vbznpRI4PhSb1yIqt3nS4w-1; Wed, 21 Aug 2024 17:38:29 -0400
X-MC-Unique: vbznpRI4PhSb1yIqt3nS4w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44fdd97e455so2218301cf.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724276309; x=1724881109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzPLeGphznbrFVeiLntbSUTXLxRo60HJZ27GWaBktO0=;
 b=RZh9d5l+gpW7b0FUdhR1CsSnlsIc06ViZiqxK3yz1gCkfw7/FbHx9L/gVkiXTBstd6
 egZDKyVrNU/5j3mh1rW2zpzCX2nOnEfaplHym8AbL6NFLHVON6B+tQMbfdNzwAtCQyEi
 8htwVfnUOlVRpq9eJZgod4UEYNbF9EUEsPXBQv1uDyr2bSufi8b/22H+upWuje1tj5Mo
 ILami7h3oBwuYQLvABKRWCRA6jFvVSCLdHVMtsSuR/U3vW6bEROpjsQtpIWuKYbtCYGV
 hHDXO9qccFGziarIy8d9UW+VirxJ4tRsncqouN7qncyue9VQsDu0xzB9w8TSkPYl0T0+
 el0g==
X-Gm-Message-State: AOJu0YwKOdHB1o5JepSCm1dLJIV9ayRrV50EYIOS+JHWwVKEN5mkoIta
 rbIhgM94D8XJhtUcWt4Oy06KTqYDxId4wCghXAD4BRZFmqe02IJdrdbkpoyago67YuKGBoEOMvI
 +zij879oedQIJr+LN/Ri1BjMF0pTDD+jd/SgdHUk3+OnH7nntC0dh
X-Received: by 2002:ac8:690d:0:b0:44f:ed41:6a02 with SMTP id
 d75a77b69052e-454f227c9a0mr50890021cf.57.1724276309135; 
 Wed, 21 Aug 2024 14:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBhyf5bMlSgG3PpfK9YrCgLOC+sdlfD/Ntp4v5I0wTD99aCMTfiICaLZyoj/9cF23JDbkZiw==
X-Received: by 2002:ac8:690d:0:b0:44f:ed41:6a02 with SMTP id
 d75a77b69052e-454f227c9a0mr50889851cf.57.1724276308661; 
 Wed, 21 Aug 2024 14:38:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fdfc9cbesm335811cf.14.2024.08.21.14.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:38:28 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:38:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 09/14] migration/multifd: Isolate ram pages packet data
Message-ID: <ZsZeUpuZuhbD60YZ@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 09:35:11AM -0300, Fabiano Rosas wrote:
> @@ -1554,7 +1577,6 @@ static void *multifd_recv_thread(void *opaque)
>                  qemu_sem_wait(&p->sem_sync);
>              }
>          } else {
> -            p->total_normal_pages += p->data->size / qemu_target_page_size();

Is this line dropped by accident?

>              p->data->size = 0;
>              /*
>               * Order data->size update before clearing

-- 
Peter Xu


