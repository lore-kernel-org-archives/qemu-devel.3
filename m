Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA159C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtReH-0004ex-QA; Mon, 10 Aug 2026 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtReE-0004Ts-6V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtReB-0001h0-K6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Wji16Z5ZlWZpVjXKO1mZdnmua7yT7+NSgk08FdAF3A=;
 b=Uj8r15yMyc9zBMwb968K9kPFOx5EY3RF+Wj8vylyrPmu2h9GqNQesWUuywd71EBdfe/4b/
 t/mHfiOoR7hupSZhRNk2cay5sR+QnmdZElMk3/S7cYi/gUhJEFyNhcmr7jtJsQXinijt9S
 Mg+o+Bl5zeik56P5HrLwmMnl3/8vWd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-TNbonQTzP3KIXtrEE3HNOA-1; Mon, 10 Aug 2026 11:10:37 -0400
X-MC-Unique: TNbonQTzP3KIXtrEE3HNOA-1
X-Mimecast-MFC-AGG-ID: TNbonQTzP3KIXtrEE3HNOA_1786374636
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so1412172f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374636; x=1786979436; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Wji16Z5ZlWZpVjXKO1mZdnmua7yT7+NSgk08FdAF3A=;
 b=TAv18EaB5u0/SUDOvGP9l5iN1eKtT4aFO3Ky660Yuv5MaJFZM98UlawHAmIUmkfgET
 jii28UGr7lLxypaLlSLdQe4eomKcbcijpVLN0GMCqyDcfw+Tu9PCnonxzmw0UxjZPq20
 MZumH1ZyrLfszxzr8qu2MUR2+cM0FyZWBWNZndCcSBZFp+mNC1zQPAr31wpw1heGVZZL
 qDaeOp/w9C0ITpURnyDgOZndCALabhj5oKzHZvAJcnAtYO5rLrIVxKo1hpZHkZFx3gXF
 2Y1V4XNg0H2h2HlX/4hMAiYiGLOOxCbGgRbkyvETGTQQ0LOuSbh1NDDxW7Y6p/tB4CJa
 Zwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374636; x=1786979436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Wji16Z5ZlWZpVjXKO1mZdnmua7yT7+NSgk08FdAF3A=;
 b=V7UZF4lnJ0wV1ZK2/bJXst4UnXrt8PYGDlt4gLSXtfvsM3dyMd9r2uIsKSwF3DqnYQ
 JmJVhHwFJqxPMImnN+Sd3WhOx669g1h+8Svx5/boaJkOXTfGGnfiaZ261isizVFq7EBM
 adu+hKXacySj77W7VYJwZRsFd42ZkuVZ7SKIb/J9d90JzwFzqHKcYGhD/979bbI6o+qA
 RauEVki9/Kxrp//Fk2TlJx5LBJ9RT6YKW3TrwXa5GY8napF5ZRA1f+4BMFI/HdqCLW1E
 nj5BXG1w9IRaV/r6joWjLxSAg+EaQKpOPRH6MT5RvrhhSmi/imVmTT8LVbWzqYUxj/6L
 EpOw==
X-Gm-Message-State: AOJu0YwQ0yXdPIFbftZ9hmnkfjruAwwbnB61KrN77TVL8MfvRL4IA6Ym
 aNZMxytkw8MP0HKZYGo1TZSi7edcbbDgE2eHRntbiY84bMX06ox+2PNKtofTIQhWwo8Yl04phTr
 Vy4iMUz9ngtZJ2i0NE5jYzIR47vCAqjEQz1Zo3IWVVH6t2TSazEBUTo+9
X-Gm-Gg: AR+sD11ey91/LE7wFUu1mKIbK7obLplv7N97N7voBHcH8Y2aktioEi1Gom4y7AD42fK
 85hCkMwYoLP3M+LKKBetxxrgpbedFXe08s5wtxI/iCoVVGhEm+3fZhr3ONZGb9koOHPLWDZG6WS
 Vx9PlCdzZOJIkw01mvCIn+1gXWrA+Bke6jCwWCOJLbT13FvgHrsxSwdA4dKkKBJSe728kovDbI5
 HGj4XLCh35+hvd882EpChixz60GHUedA3ostSsxuLllDGqG/5rVYurHu1GHuu8A/lQG+7TmK5Eb
 CZtbpF7LBmL29+XYj50ggJkQ3NS8nu1d2VQmRMa8/OcMdQ1A5G9BIwND
X-Received: by 2002:a5d:4242:0:b0:47d:f441:5f93 with SMTP id
 ffacd0b85a97d-48130ff168emr20616342f8f.25.1786374635407; 
 Mon, 10 Aug 2026 08:10:35 -0700 (PDT)
X-Received: by 2002:a5d:4242:0:b0:47d:f441:5f93 with SMTP id
 ffacd0b85a97d-48130ff168emr20616198f8f.25.1786374634544; 
 Mon, 10 Aug 2026 08:10:34 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220727bsm37133789f8f.33.2026.08.10.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:10:33 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:10:31 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 05/11] migration: Make qemu_get_buffer_at() thread-safe
Message-ID: <annp0wm5l_5Fu21F@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-6-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-6-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Remove the internal QEMUFile error state modification from
> qemu_get_buffer_at(). This function is called by two functions, both of
> which already check for unexpected return values and handle their own
> error reporting.
> 
> Removing this shared state modification makes qemu_get_buffer_at()
> strictly thread-safe for concurrent disk reads, serving as a
> preparatory change for the upcoming fast snapshot load feature.
> 
> Removed local error by passing errp to improve on error handling,
> consequently also change caller to use error_prevent and not error_setg.
> 
> Set errp in case of f->last_error as function should set errp in case it
> fails, and caller can simply use error_prepend without checking errp in
> case of error.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/qemu-file.c | 11 +++++------
>  migration/qemu-file.h |  4 ++--
>  migration/ram.c       |  6 +++---
>  3 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


