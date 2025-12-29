Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544D3E92733
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFui-0000wR-JV; Mon, 29 Dec 2025 11:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFua-0000w6-QJ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFuZ-0004zZ-4h
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767024956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNKjgL7/p3ZDdIHnXIRowtJnboN7G7ElxhqJFCNCqxw=;
 b=FNWY+kS4j9pK158NtHBOrlqEah+1e0+Duhx+SBT+X11CW5p4w1/XaNKGxyWjY20wiH+aSn
 Bc4b8tLnR9seQU5gEx/MvCkgy08aGsafQ7/A/pbUBzAPoBguhuuOp+eLIHnScanHs5zgg6
 DfPxWz3D9lko43q2aXYfP3q06S6vhKw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-P2z7VT2gMTCmnQGqcuJzVg-1; Mon, 29 Dec 2025 11:15:54 -0500
X-MC-Unique: P2z7VT2gMTCmnQGqcuJzVg-1
X-Mimecast-MFC-AGG-ID: P2z7VT2gMTCmnQGqcuJzVg_1767024954
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bbe16e0a34so2266197285a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767024954; x=1767629754; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pNKjgL7/p3ZDdIHnXIRowtJnboN7G7ElxhqJFCNCqxw=;
 b=pYmCNX+HbBKkDzo9uPYXyRvtJDnHo8vTBPeOYtf0TbRUU97/8uSr05ZONuaFgZ2c7U
 IYZOCELpHMmya/xF2WD7M+uI490pfKSh71+OMcRlRuk1v0AvY6pWASxs5pHb+iQ3sJgR
 wZy2V3tJr7r5vDKoQxdIkKV8REzzJPkRFmBONzWxoiBYChC9c+mz+dtvAg81vuVA4jyw
 +ENLcbIUxuxdQ6zlwBu+0jzmRgmsEQAG8oDq2T9mqzmrS4TbXolz1wrppxSdP94bTxVl
 VxOo66y+zXBPnsPfghqd1VTJ+uNmZO6sG6R3zlutB1fQ3pdovQ4yH6seWqY0CBJyC/+m
 6ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767024954; x=1767629754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNKjgL7/p3ZDdIHnXIRowtJnboN7G7ElxhqJFCNCqxw=;
 b=EChty15cVC2Ch1NyOV9v+sYFu8F/6wGxRodYaTu1Au5fQVNbyddbprv+5+OtRtFfEL
 3Zj3r1x+Djg+SlVw/5YWaiosvLK5NGCOFFcLIunEo4nS4SdMIoExDQPat96L1E3Qna06
 rDzJD1JmeB4RbMGt0ya7ngyLjHK7KC5uGYkzjGddKDmKARIlCVzcpVtNcDijQ6d6G33M
 LEXkgnbw4OEffraf0fHo/omPaJ7KQX1NGdzQ5ZZND2ncO/Ca1sje7hRngHF+124oA1Ec
 HI1Il/csQ5+O3n9ROpJ7zTcXxtNkHwhMWrCXz8xB++Nn7cVY464aWSRTWa97Exxoprki
 9pLg==
X-Gm-Message-State: AOJu0Yy+lvSlRV+zE9bHphLty2EbqobyiuYlwAGKZmNuf3j+RH0uMP3B
 sx4XfZr0BgaBCl5qnTAe0u0Vmu23QMxKlT7srjHQ10XSKRjPfMkCglCXLpnCiZBUg4HdZLaoLuI
 4uXeoc1U8O9WvlGzs1NdUOMk33Rmr32CX4kDFxE0YHMmHQoekI3By2rVzyPPt435V
X-Gm-Gg: AY/fxX7udx3DnjCoogpsSEjbXXF3g3n70iemIBiDKVssgVrqxwT+bnF7EI+QwiD98gq
 cA4NSrRvyM3Lkb58c1JGJySgmo7Ej0TbLlXXTO61htssxN4YL6P0nUmWJs6esSmFjbyYyBFt59V
 LF4+lw/he81EJfip1Vu96JNpV7zrIzEIsJ+gAODS3Li8c8fmoeiIguRR1M56tvu7yQgdwP8eF/r
 AZEEvRFhl90rhV4+hN3M0uMNEIUolgKp+jsTJsSsVmL47DaU4nmQTn7OHIBoU1X+yff+k8bTPIO
 X5B0OpX5e0HZR2GEqqBF96AraXxvEAAzpUqK1NeJJ7jHQW2igGMMUbEbJ+huV0ObgfONRKw61Gt
 Js4c=
X-Received: by 2002:a05:620a:4686:b0:8b2:eb66:c5a with SMTP id
 af79cd13be357-8c08fd02e33mr5194976685a.14.1767024953873; 
 Mon, 29 Dec 2025 08:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4QOTpGqoKWzbXfutp7tdvZMxZlvVJJs+ARKzYZ2TXqiV4VOmiCkWM7ISiT/81OJYNjH+6Rw==
X-Received: by 2002:a05:620a:4686:b0:8b2:eb66:c5a with SMTP id
 af79cd13be357-8c08fd02e33mr5194967985a.14.1767024953327; 
 Mon, 29 Dec 2025 08:15:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0973edecdsm2476741885a.37.2025.12.29.08.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:15:52 -0800 (PST)
Date: Mon, 29 Dec 2025 11:15:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 06/25] migration: Move postcopy_try_recover into
 migration_incoming_process
Message-ID: <aVKpOC7fnhF6S-iI@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-7-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:08PM -0300, Fabiano Rosas wrote:
> The postcopy_try_recover() call doesn't need to be duplicated, move it
> into migration_incoming_process().
> 
> This removes code from migration_fd_process_incoming() so it can be
> removed in the near future.
> 
> (the diff is a bit strange because migration_incoming_process() was
> moved after postcopy_try_recover())
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


