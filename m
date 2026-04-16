Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF04AF8D76E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSHY-0003yx-V4; Thu, 16 Apr 2026 15:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDSHX-0003yM-3U
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDSHU-0008MG-6a
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776367298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuiIN56V4Kn2uLeM9wkgmdRP0gvzqIG/X6VledVJGIs=;
 b=LQQYPQc1Q7216+KCaX7mmLjTETkvPVWRydL2XC2+BYZd2THxFqUSRET2L/xbtMmL1rik+G
 +4AHSGXzASwg3O9bohSRXYruZnVJBAv0rjhwb7jBd8jzt5Mz0xH//seHmat2MZRk9pVSdR
 50P9ryPUadt/6guet07DS0VZ1PMt3TU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-MD1yN95IMx-NjPMZKPdJZQ-1; Thu, 16 Apr 2026 15:21:36 -0400
X-MC-Unique: MD1yN95IMx-NjPMZKPdJZQ-1
X-Mimecast-MFC-AGG-ID: MD1yN95IMx-NjPMZKPdJZQ_1776367296
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d654ade33aso233989485a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776367296; x=1776972096; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tuiIN56V4Kn2uLeM9wkgmdRP0gvzqIG/X6VledVJGIs=;
 b=W7fYpg5VWNg/MI6MovlDjI1c4v3wPCr6EY0xNjQYfTdFXujTNmHe8wNXZKaJvJFs0M
 t6JuixNMALKKP8dgD+6HVFqrqrvvJ3na9aeXSlJ/rFStmAGBM4Q7rlgpoRvTK+IcavGd
 VUAodfM+5yiYe9fFYheJm2tM8yOgIup6R67JwN1vcI2gt+PpRD2RPsQJtSlZs50ZZoCu
 fgGvGjblnc/G8Zao9gzsg80Lid+Rk7KGybPZg1DDTCAsrBi10G0g2BFxtFlELrDloLa5
 k6g+C2N2Q8vwnZTC1hVvrG1TN/m11TUu1u82uE7y40XkFbQ7PQ/sRiQwwwWrOCUCNIo8
 Z4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776367296; x=1776972096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tuiIN56V4Kn2uLeM9wkgmdRP0gvzqIG/X6VledVJGIs=;
 b=PT/gzrwXgXdZpmKYA5KT7c+oQjKfiVx5RCdb8Xk6qZR0gIHfxA5IvvfvGTHVwR6lB9
 5LWO5ApiHG747MmP7BldhIp1TRoKc1GU1SgiuApwmCeC1aPSUwySptRDEXSXW/qsXfjD
 GW/Kj6N4BQEapEXvgP+/YX3pJssUvSqXyV/gJ2/ouG6hFr75TrSm223Ne/kPYBEPf8n8
 nGNJfeuELh+QbEbdtcLkaLwMsl5eQM0W/m7+66ASbwz0O5Ibf3epGpLEw78ubwcvwgmJ
 njeFe+HE2gTXBcglUlC7n4NuHdEgqw56ltrDTP9cslUL6fK52VlexKYBgVaFoSvlZyoc
 u26A==
X-Gm-Message-State: AOJu0YzqFOSFz0KW4HHk3SxsTG+ao3a0xoT3Tgx7NRrWI8RGhD/cjDmU
 UKvE/n+iZuAhmVLxQJeNAuyaqqqzY0yK9R0fm6iijh/mDI3xSvXLYrFf06O2Sod9Vsgr/ODxV/1
 bCYDldBFqxNRfLm7fXwuDsX8RLj9TP+rgt+QWGFbi0m3dCglHKXfDadqM
X-Gm-Gg: AeBDiesFp3Rs1tpPGyOwmDprUBfGuEoaeCMeXi1QR+AqB7eH82bkGnTvUm6qBvFm2P1
 L5SuFqFxntuT/pW5nPhp/SQ1JtKVkm2AGobJU7IfisEAdo43chNEbophyQlPF1WsKqcZipW3Afw
 h0BK1mP1/8d7tzj2AGPryGMO9MF9Lm/WuguyM6vc101VyZC3Rdiwg/Oq9pW6zb7WEcF1zJh0jWA
 stodilVvPKnWdGHXesLxsCpjvTO2nL3gwh4qbQaAvkTEbHHoxPlb/nrPUU9ReZxuhgRF2p9iyAc
 2F8YasJmKLz+82Gv9kx7CgWIUa8ZzHHL2kSwwx9y4/74JWntOpBC4yAXcE9jv9pFL/hXJ1foMJj
 o4ahNiL9adxJEMfjhe3lPxg7IUaVLjFJ9DHKDwDhnaexq22jw5M8Xjozi6Q==
X-Received: by 2002:a05:620a:6914:b0:8cd:d688:7aef with SMTP id
 af79cd13be357-8e751ffea79mr77695985a.19.1776367296171; 
 Thu, 16 Apr 2026 12:21:36 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:8cd:d688:7aef with SMTP id
 af79cd13be357-8e751ffea79mr77691585a.19.1776367295565; 
 Thu, 16 Apr 2026 12:21:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4ec18f2b0sm428153485a.0.2026.04.16.12.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 12:21:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:21:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration: expose per-device state save times via
 query-migrate
Message-ID: <aeE2ve7YrEXHtvrb@x1.local>
References: <20260416175659.41215-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416175659.41215-1-viking4@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Apr 17, 2026 at 12:56:59AM +0700, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> The stop-and-copy phase pauses the VM and saves all non-iterable device
> states. qemu_savevm_state_non_iterable() already measures per-device
> elapsed time for tracing (trace_vmstate_downtime_save, added in
> commit 3c80f14272), but this information is never stored or surfaced
> to somewhere.
> 
> Expose the result through a new 'device-state-times' list in
> MigrationInfo, filled by qemu_savevm_get_device_state_times() helper
> and returned by query-migrate when status is completed.
> 
> A new QAPI type is introduced:
> DeviceSaveStateTime { 'name': 'str', 'instance-id': 'int', 'save-time': 'int' }
> where 'save-time' is the elapsed time in microseconds.

Hi, Trieu,

Thanks again for your patch, especially during your spare time.

Though I need to say this is another example I want to mention, that QMP is
an API that QEMU relies on a lot, and we're serious on what it exposes.  We
need to justify whatever new info to be exposed.

So if we start to report something in QAPI, we'd better be very certain at
least someone will be consuming this at the very least.  Starting from the
1st day this API got merged, we will need to stick with it and it can be
forever; we can obsolete things, but we need to evaluate risk.  Before that
risk analysis, we better evaluate why an API is needed in the first place.

What is much less controversial is, if you could look at how to improve any
of these numbers reported, say, if we can shrink some device save/load
time, that'll always be a performance improvements.

And just to mention Joao's effort was not discontinued and gone, it's just
done instead by tracepoints here rather than QMP queries (before we're more
confident that we can leverage some new data in query-migrate):

https://lore.kernel.org/all/20231030163346.765724-6-peterx@redhat.com/

Thanks,

-- 
Peter Xu


