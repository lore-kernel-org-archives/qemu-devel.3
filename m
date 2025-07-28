Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03010C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 20:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugU6e-00085c-57; Mon, 28 Jul 2025 16:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ugU5f-0007oC-Kq
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 16:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ugU5d-0008KD-TT
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 16:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753733090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJYyOPwnBjHm4n98+VRKC6aejLGdxif0eJaSD/ahttY=;
 b=BBljXUgWfRY7qjk9o0q1k3s8PqX0DdTyjnM8mL3noeDUxu6XGrT+etP3H2QfuX7WpcTvRQ
 EYfYWAljaiCFdX7hB0ZSs+gfikEKZYKszvTto3T6T7roOCLRAxfuUE1yPZKI/L6HRjpO4p
 XbfPAhuGqnzUa0pNc4qfO0lEkSHZfiU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-QjrGyUEnOo2W7unCdOlUpg-1; Mon, 28 Jul 2025 16:04:49 -0400
X-MC-Unique: QjrGyUEnOo2W7unCdOlUpg-1
X-Mimecast-MFC-AGG-ID: QjrGyUEnOo2W7unCdOlUpg_1753733089
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e1aeab456cso633757885a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753733089; x=1754337889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJYyOPwnBjHm4n98+VRKC6aejLGdxif0eJaSD/ahttY=;
 b=R3Q8N7JrK7R0/Lc9bdt1Swa1SPyDwBXiHuNYHq66n9LpTpNas3iyLtIAhu7UtB7Rys
 /jIrCRjvEPfj+4BNCBi9qw8sCWWErOEAoniUcgfCqAnVzD8nAk2fsWRbZlLZApMaqyFW
 GwrEIpeSsDcZuiIKoHxYLAsB5nhOP+KZDEGd0Fj1jCZY+y3ZBL0XVhGRV1NdAoWOPX3+
 8wk0VEHFcND+8S4Y7vo+n6X42gPF8uYlzywR7/6LBp2m0oRl/q2jCN4MWvvhxGgLeKth
 SrkiGjZ6SJNrWrblvEXjcMubViRKASX9cbk3kCucc2SoV2uHfgGZ04ema3/qH3oH4X4N
 MlOQ==
X-Gm-Message-State: AOJu0YwlAN+OEfzwuP++py5gArZTd+2FIHZBJOdE4TZwVir0i57m8Var
 GdZFiNYkNBgOklykQXf9Mo1zp+wORsa8BGzVngN0SOczWTIB9eSQ7oUwBXWo3ZuMI1U8Qrql9tX
 I/Srx2s7MFcLcopMN32Wi8RBCjlPedA1qtopHd5f396LVuylaEK5XDoMN
X-Gm-Gg: ASbGncsie0UvtDhO8LuTwmyBWVqKN0XmM7Jh+h+zhR1qJai5cmdJsdv1mgWWAVCkvzs
 o4GMAN8KVmvJAZTbPGBgulFYUr+kTcMC4tPTkKpbP4Y0LyICN7VsY1D9jQDsbfbGCFUviLz882Z
 LVFxZuXs8NMg8aB1o8A/lt7YNU4WDFA+0Z4xGScmSXXfjYSpzBVh1OK0/ah9qjRc6yS7v+fwvYi
 jFTQOCm3Gsqy4WQ7WGXw1ySCU0X/ZkLByEQZeRs8RjWy0AJ0hKMidYMtt05HJ98DD37keSy48b8
 J7JWz4skdGXuI1HiGQhm1XWiNhosNkQ=
X-Received: by 2002:a05:620a:2984:b0:7e6:5d4e:7a23 with SMTP id
 af79cd13be357-7e65d4e7b20mr335708985a.7.1753733088710; 
 Mon, 28 Jul 2025 13:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNpJSlSn+FJRrQXt83PZPVWyLoxefjswiy2OI3LaQl+52zwwxe8/KFNBAnd3+B0zZbWOgVWA==
X-Received: by 2002:a05:620a:2984:b0:7e6:5d4e:7a23 with SMTP id
 af79cd13be357-7e65d4e7b20mr335705585a.7.1753733088370; 
 Mon, 28 Jul 2025 13:04:48 -0700 (PDT)
Received: from x1.local ([142.189.11.29]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327de82sm325010285a.2.2025.07.28.13.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 13:04:47 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:04:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/3] single-binary: compile once migration files
Message-ID: <aIfX25N5_vTCaPyR@x1.local>
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 25, 2025 at 01:17:26PM -0700, Pierrick Bouvier wrote:
> This series removes target dependencies in migration code.
> 
> Pierrick Bouvier (3):
>   migration: compile migration/ram.c once
>   migration: rename target.c to vfio.c
>   migration/vfio: compile only once
> 
>  migration/vfio-stub.c          | 16 ++++++++++++++++
>  migration/{target.c => vfio.c} | 16 +---------------
>  migration/meson.build          |  8 ++++----
>  3 files changed, 21 insertions(+), 19 deletions(-)
>  create mode 100644 migration/vfio-stub.c
>  rename migration/{target.c => vfio.c} (67%)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


