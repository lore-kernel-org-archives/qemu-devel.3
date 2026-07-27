Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B17C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQ5j-00051l-Mx; Mon, 27 Jul 2026 14:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woQ5b-00050Y-Ao
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woQ5W-0001qP-W9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785177002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSWc/GMSImC7pqT0snauMmWe2Y9An9z92JO0MDCd8nM=;
 b=HgfsPJj6AG7DhNADkoKsZsbnUgVqLslQAgb6OumpSbMxZXuqUkBeD2bhPAxHvjtpZy0jeo
 Z4UiYIxBdyVduRZPzM7/jmV1KYWpXbFfDddnll2CtyhpPBwZuYMTyMN/giwt+jRzCfJPLx
 Yq2Y5RBc6hpsaOYmqIR9cBf0qTYjeZE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-iw2nlVSJP3urzsbUKtwu4A-1; Mon, 27 Jul 2026 14:30:01 -0400
X-MC-Unique: iw2nlVSJP3urzsbUKtwu4A-1
X-Mimecast-MFC-AGG-ID: iw2nlVSJP3urzsbUKtwu4A_1785177000
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so37043421cf.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785177000; x=1785781800; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rSWc/GMSImC7pqT0snauMmWe2Y9An9z92JO0MDCd8nM=;
 b=CAFNTDIhujWTV2VV/JKKkiB/1sRZhWdJMkBoHt5094akIS70Q/DfJRw4VMW10R/AN1
 I1XOsyS8K2knkY1HxhYaXmXVPK5CWBiCmuXhA+64muk2baHJi4FGPaEyMlFNWNGyRjkH
 BhvUWSYB0WOA3PCZ08//KHUbF9/YRQUE6NPVowqR8ETErnuIg9n3cCZqKvzAk23prwTK
 auRXbWbFDZ5Hx+MA98TKChM0fcVPhc/JsG926ov2Y+Bw3/6SPWsOO9WZZPE1m8zUYrrG
 a4lXyYsDcD6l1Xif3/WNU3PoT731qTGcio3/fFuSJNTw7x+1lBAEegi+yhq7ukTTgiiR
 DRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785177000; x=1785781800;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rSWc/GMSImC7pqT0snauMmWe2Y9An9z92JO0MDCd8nM=;
 b=mVT2S/FkIG6tEPoEY+2sOfxEpFJHaBk0opEOV7w43BfrhUsiFVIHsQrgAQJXJ7eG7F
 ynqiqIfH5PzjP72OI7nMmrTgYTfJNOSei7xBAxKPuKXRlt3yOmXmAuimDQViObxZlBFe
 IcPpazNnyrgwXhfQcUuJ3novUgWaMvNa5LCCt0N5AaHshsOFDd7VGTi0USxQGIvBfDPc
 PsPAyJ4zWI3OFTO07oFIXZz33Occ3aGukytBtWqbZVRwnMgAVQxgmnJIfDkG9ThqbNlG
 EU+o0qxDonMdBPth7Buzndn2h2JcU/u5GDWfLbG4ixhiFb0kWJ1cEu85UYRaQ47MXOm8
 gflw==
X-Gm-Message-State: AOJu0Yyhedcueutdp47gomxqTndr45tYAs4EoO2+wUc17ResvpoibMfq
 +Ehu7xTYJztogq7AfyMDFGoLZcuI3sTet+ptRH90mkx7tmQbmZ4KmNevcZyIX4Hb1r0ddhCgHBn
 RLmRVjk9cYngmKLWmpqc+e8sn63+amPssm81VxDGSEi5sQ2R/xQZf3kCl
X-Gm-Gg: AR+sD11t2oNe2QTpIISZWGLajCPdJNCeevw5I20Z77lwxEv97qfbB4SmjLZusta/wKO
 mkJcCMPxuF939WtshGd/a1Z3RjX+iyjtLku4VTY7/ytOLEW1OtzMXPJkvcg1t7Aq8bBy6fQdBlT
 BgxBdm1XhtsCX6DvAsHWTyBS1OH0qDjq4gR3yeQ9JGT0yKNbImIl9nitbRSe5Wyko5sFsq6KwXi
 D9L5D4VYW55vwtnq3Jo0pXkCT4E/LPd5zc98k5jqwAaGCLU75I6sUr6sPwr7Hqq1Lt91EE7OPoy
 ev7CMywjW7L1ANRjgTGh/iI2lMEqjGuG+hOjp0621iUfFgyMOLx2niaRaEjP54Ux7z6J
X-Received: by 2002:a05:622a:4888:b0:517:8e65:68ea with SMTP id
 d75a77b69052e-529d18f1be0mr7679101cf.54.1785177000536; 
 Mon, 27 Jul 2026 11:30:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4888:b0:517:8e65:68ea with SMTP id
 d75a77b69052e-529d18f1be0mr7678751cf.54.1785176999933; 
 Mon, 27 Jul 2026 11:29:59 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e8519ecdsm70394506d6.4.2026.07.27.11.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:29:59 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:29:47 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <amejm_jVnRl6IW5C@x1.local>
References: <801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Fri, Jul 24, 2026 at 06:57:02AM -0400, Michael S. Tsirkin wrote:
> vhost user currently saves the inflight buffer to the migration stream
> using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
> backend.
> 
> But the implementation of that is broken if size is >2G: it stores the
> buffer size in a uint64_t field, but vmstate_size() always reads the
> size field as int32_t regardless of the macro used. This, in turn,
> causes negative or truncated lengths on load, leading to undersized
> allocations and down the road out-of-bounds buffer access.
> 
> There's no practical reason to support such large sizes, so it's enough
> to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
> reject negative or oversized values, and propagate errors to
> vmstate_load_vmsd().
> 
> Note: the large value is coming from the backend, not guest, so this
> shouldn't be considered a security issue. The CVE was assigned before
> the qemu security policy was updated to exclude this class of bugs.
> 
> Fixes: CVE-2026-6426
> Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
> Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Just to keep a record in case anyone needs, the review discussion is in the
pull request:

https://lore.kernel.org/qemu-devel/amdT6P4esRDwyRX4@x1.local/

-- 
Peter Xu


