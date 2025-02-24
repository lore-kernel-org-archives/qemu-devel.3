Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D38C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmeeH-0005NK-BB; Mon, 24 Feb 2025 15:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmee1-000593-Ab
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmedy-0007zg-7U
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740427293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8os7CYmOIBlfUYUS4rI4CncpuaS0vvYGy5DOH7VCX4=;
 b=KXwWJ7acM5Cvwct55rJf7u9gAWGwRKy4UZV3mubZVkrNe6RNB+a1GOg/Z5eWMc7aNZlyRT
 aNHynxMxetf/HoSt3pxRXN28pAvvEFqJekPoXkK2PL4i3vykti6ABVMlOk1xS9Pfkp1sHa
 fKzFNCX9rzSJixaolDEayYiHvjdI2VQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-XQrCmBUEMuqsbM2194fz0Q-1; Mon, 24 Feb 2025 15:01:31 -0500
X-MC-Unique: XQrCmBUEMuqsbM2194fz0Q-1
X-Mimecast-MFC-AGG-ID: XQrCmBUEMuqsbM2194fz0Q_1740427291
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e65e656c41so101920506d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740427291; x=1741032091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8os7CYmOIBlfUYUS4rI4CncpuaS0vvYGy5DOH7VCX4=;
 b=bBtQXCkS30yN0liIiWl1eS7CGj09Xg8CW8kbtm920GUJI9UmPRebdX11PuJu+aaXCR
 MCl/YSfEE75jI2FFdLdZ/2VJEPlzwHLUprlbhYuAJtX3ILTs0mZDrc005LelAX4FOeOy
 1Y0JaoaT9SoeyWJKQW/ASHWGa9+U4QlHNNRo6Hd85/jZyzwf9KSQ3SqGYf/InNv1lDbM
 O/RsdNjQlJFPp/VT3rOTm0pYC5F+E/PujonY8EokJd4f92bt+QaFQY9Hp1h0yv15CGcz
 IMNuUPLAMXA3Y5mTM+wlcobuos4u7ZcibGA3bBqkVs1zcciuZqnBXDIrl8vaRZrK+QN7
 af7g==
X-Gm-Message-State: AOJu0YwdKZRAtiMEyUWy8NjX42hLVO/4NGOLOfzh7TaA97AKQ7vE6OJp
 CjpMPQ8pj/uG4TSX3z/mEcTcsBztS2vbKV7hcnCcF1oT7Ywc1O94JMi0uyz5BQkx4azkUpFktSc
 +KU02zb/0we/30NXidV/YHMPTAzel12m+tTCt3fE4jmw71m6S0rEU
X-Gm-Gg: ASbGncvrpBRhEkzA5PfZsG0bQUgGkfG2EeWrn2AxIScRGcNXUD6PlFqqCwYsIljaeki
 lj/Wg4VseAtVoMNsawrcuMCNWIK4VDcAoeXzWR3IsVp7yZ5tEP8DZD9ogDIYk9NHA89VQELdhwZ
 qZO/8Iwf7KUz56aDCYjNdbVLrx/UKcM2nqR75jP6n+eDnmI/c6IBmN+OkJ1ZjZxXy3YX7JXe4vL
 Zuavx/BfxPEOdIkfyTf9g/es/LhMh9M+p6lxmFJSoCA6sNz9Ztj769wKTyBOV7wibxSow==
X-Received: by 2002:a05:6214:501c:b0:6e6:5d61:4f00 with SMTP id
 6a1803df08f44-6e6ae7c9624mr175612426d6.4.1740427290936; 
 Mon, 24 Feb 2025 12:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1wU4AoYyZMidP31s0e7umUb2YWRfWiTg4pEOBLSdjdGLaE8/urI2uxz4AB3e9+FnQzOddRQ==
X-Received: by 2002:a05:6214:501c:b0:6e6:5d61:4f00 with SMTP id
 6a1803df08f44-6e6ae7c9624mr175612126d6.4.1740427290660; 
 Mon, 24 Feb 2025 12:01:30 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87b171962sm726316d6.106.2025.02.24.12.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:01:30 -0800 (PST)
Date: Mon, 24 Feb 2025 15:01:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/8] migration: Add qtest for migration over RDMA
Message-ID: <Z7zQF4e_GQwjkaOR@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-9-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063612.695909-9-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 21, 2025 at 02:36:12PM +0800, Li Zhijian wrote:
> This qtest requires there is a RDMA(RoCE) link in the host.
> In order to make the test work smoothly, introduce a
> scripts/rdma-migration-helper.sh to
> - setup a new Soft-RoCE(aka RXE) if it's root
> - detect existing RoCE link
> 
> Test will be skipped if there is no available RoCE link.
>  # Start of rdma tests
>  # Running /x86_64/migration/precopy/rdma/plain
>  ok 1 /x86_64/migration/precopy/rdma/plain # SKIP
>  There is no available rdma link to run RDMA migration test.
>  To enable the test:
>  (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test
>  or
>  (2) Run the test with root privilege
> 
>  # End of rdma tests
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


