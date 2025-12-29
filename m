Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE335E9273A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFFq-0007HQ-Lv; Mon, 29 Dec 2025 10:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFFp-0007Fz-7q
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFFn-0006VW-Rc
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767022431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9kfIwKGSeaqCiK6IqvZcvesuHOHu0bMSWBfcHegt5w=;
 b=hvEjQwHRbjeWH833pGzcbuYeTpYPH7oHFy/zf0fyzLBOB0LWb7wlVAyuzUY+lcz5/yHU1P
 wlZQzwNt/DfLCZGwGIC+57bCxA34Mk/Ayshq0G3nWeg62GQkzO6ZyDJ4Qv/wMp1m/0S+9+
 YeizIPopfqXWCW9wVhCHsx5yeIZQ0bo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-mZhaTlIxOlywBxJ0yj0sVg-1; Mon, 29 Dec 2025 10:33:48 -0500
X-MC-Unique: mZhaTlIxOlywBxJ0yj0sVg-1
X-Mimecast-MFC-AGG-ID: mZhaTlIxOlywBxJ0yj0sVg_1767022428
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2ea3d12fcso1159629785a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767022428; x=1767627228; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d9kfIwKGSeaqCiK6IqvZcvesuHOHu0bMSWBfcHegt5w=;
 b=h66SW2IoS8kitBZsWNQ1FoJ4wtNAs3tFYAiFBp1A+dtdFavjjePcdGlw+0uorQYiAl
 ioKiCAp7PLdYcWwfCwNuTEgrLbKqC9rQyr/Lf+06AqFsOEgy/GU0gny4pOOK4x2xjlzb
 PEx3H2v8zTmBXIU8mIDRTNQD7O1O67LN0Qzke3sLbRLe2O2B9kvFJQpJr3VHOQdJI+Ef
 ikSauQVQWXxrP4peQMwzj2BbN3T9P4VLKbp/DoE/Me8OfDk0SVoQJER/5CM/ItlaGHhJ
 zF1X3Svi0bmRwzUvVFSbIwB2Oo96YKb7AfM2RGKIn5fUdx/YWDj/adxoLRWstYVIMGMO
 ANvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767022428; x=1767627228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9kfIwKGSeaqCiK6IqvZcvesuHOHu0bMSWBfcHegt5w=;
 b=nGxshzj+P29naRXsqFQz4YLTmmKb/dpeSZ+GdXjBSa3tmJ0rsq0tkl6asB/WuRbbAY
 CF4u3X21xrJGdYQGI7onKQQLpqDoWmsgo7824MD7slaXy4YvNXT7TrWWzD4Jb7VpBd+g
 1IY7u7fVKZA74kN4BTXyslOR3aQQ8H+9EVF5VLB8icvaQPr16iz8FDPJvKAS2bTvGadB
 TyzOHJDxQid3yhKKWv7qqoaKuQgyR+5CZbMRbjlNJEnqireFn8AIq/n3BTz95sEeYK00
 IY0f81KRXPpBgkFfmUeta309li++aEvxvZNvcFWHvPFYaIqID4g1s3HXcnF5dV+3II8o
 ukAQ==
X-Gm-Message-State: AOJu0YyTcAaZe0RWpN4xD0+8YJuB4SyqUB14nut5rkLi5M1RH5hJFAKa
 4kMuvPJ3sVlspDeb2DLQ2nrCU2UexDx8rmUTd6NMgAxqyLUbTkcqu3cS/RMksZSVHbgNZvZ2lM2
 QdRvcjS7akj7a4sTBBxMUhUuSc5EZCGDd2qjD7kLwLFBk6VnmdHlayFeCyiHOxdw7
X-Gm-Gg: AY/fxX66rEw4fTuZzgm4YxOXE8w3MHdWomyKfPzNvQdQtz/GMHeYHYAS5trqyZuqM2u
 wwTdHNWfWbfm1se8ya1ugQVwpdTjXWu6cGrY+xxftl9NIYOVb7cCDEep+b0xRlc4AVz2nC4iyvd
 pq4hnzMVnbbwxXznfDvXPpct5A8DikwC2dCYK1qN0LjOkx3wiBuemF+rROqXozmh6fb6B1znvSI
 ALYUMTjHZZDiLIwS8yEvbiUhdZ6oyoyliCLO2e3CII764rTLyUldoJNjJqXNLR6QcHBjxWnDTqp
 4XgK+TPHOT2lTMgji2SQBTTaFLYuehDMr0LHDrITR2HTo8DRDNGojfW9OXP9Y24xxWsyKXyXZ/B
 AK1M=
X-Received: by 2002:a05:620a:44d5:b0:8b2:db27:4268 with SMTP id
 af79cd13be357-8c09011f7abmr4658693485a.53.1767022427735; 
 Mon, 29 Dec 2025 07:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGygY/V4xZZIY1+c2XYgBvJ1Bt4maIQFUgIOBbinA/runYKOcP8ZJyun22BK6vgBBOWUgvCCQ==
X-Received: by 2002:a05:620a:44d5:b0:8b2:db27:4268 with SMTP id
 af79cd13be357-8c09011f7abmr4658689585a.53.1767022427336; 
 Mon, 29 Dec 2025 07:33:47 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0973f4647sm2434746785a.46.2025.12.29.07.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 07:33:46 -0800 (PST)
Date: Mon, 29 Dec 2025 10:33:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 03/25] migration/tls: Remove unused parameter
Message-ID: <aVKfWn52m1O93d93@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 26, 2025 at 06:19:05PM -0300, Fabiano Rosas wrote:
> MigrationState is not used at migration_tls_channel_process_incoming().
> 
> The last usage was removed by commit 3f461a0c0b ("migration: Drop
> unused parameter for migration_tls_get_creds()")
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


