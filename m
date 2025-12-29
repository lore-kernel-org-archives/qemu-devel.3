Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65EE9273A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFEu-0006oP-Q8; Mon, 29 Dec 2025 10:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFEq-0006nn-Nr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFEn-0006L3-Q2
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767022368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErFOgyrhj1ex57WiraNv3/JOI6hxTmjlkQIEGJZGy3k=;
 b=cDi467C5xhrBCsVcjJpu0Z2RkSaND8C8PMlSGMWn6BCtylHiCPXVWppy4qq3/z39C4Qy4+
 foL8Vja01KFpl3ljT0R4IVTnil5HLFgrV1Jl9LlqlEpU+ngJ41RyAdlRKTc4ndI8BdL+XH
 sE6oYj1A0q2lu/zEVfkwB4IDh1OBarg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-eRvgrC8TMzanJLdBPuPcIA-1; Mon, 29 Dec 2025 10:32:46 -0500
X-MC-Unique: eRvgrC8TMzanJLdBPuPcIA-1
X-Mimecast-MFC-AGG-ID: eRvgrC8TMzanJLdBPuPcIA_1767022366
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so2334575885a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767022366; x=1767627166; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ErFOgyrhj1ex57WiraNv3/JOI6hxTmjlkQIEGJZGy3k=;
 b=Yt1To+HLoLXrlco2LUy4JpGTLvGGbSThJrwQhOQEc6N/5z/LyHXBOW8FPfxuBel4AC
 aD2ks2oAGFxbKKThI3GyGMf+4OxfbsnojtmF3hZ1O6g0nIoC+K2y8T3PNlcIQu/BV4uk
 X6+QwXOck5NcGhZ6ooMiR1TcFu/3fCTKZwP9vLh+99CI0N5c/cb/eX7Zpgc2oJfxcUtK
 oLQSARhweYzVxDYOYen/GQGOxBdy9TkhgvNk0OVW85i6J35ofsigyJtn08Pwik4705d7
 WtLZ6XACFMqC2jCii1S4MLy0fFpUZEHWYbpG7lTQwtPk4oXfBZ9+qRVVuX5MAWoM6+H7
 uWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767022366; x=1767627166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErFOgyrhj1ex57WiraNv3/JOI6hxTmjlkQIEGJZGy3k=;
 b=wiFOEFS9I1UvyhfWJsZ06E0nNV7C8v9Yn/DF/HPxaclQv71xzwxzxEUh8BV+8HCZQ8
 Ib7V0Z85khS8gzdFxCHpVdx5FvnwqKBnfGYNxCSQE9AMtAjO2Da1VNoC++KTkDZkedBJ
 VIuqupMEmjA0RTZJJ54z4eldArz2KV1RNdNcNzyYaH/ZVK443HC8kEjk+nOg0zmKR7eT
 NlqpmqoDAEDtHUgFinoOzPG26N15/f9Xahrh7Htp3Vr/9CgYPL5AXs+F9aeDAEJy4sD4
 q4Gf0AtgN0nvzSLHaUugSHljGJeQ4Gwl6Q2UAVZ4T781RuocHJGWCxC7P75hZAXHGckh
 peCg==
X-Gm-Message-State: AOJu0YzJIjZbc6UgpDcN7H4zTw2FuJoccBQFs4taQzOw4ZHQ6osfDr+Y
 pt4PCiati3V4622mSEHw/8A/hkQ2WVvK1xetJsZaRBXrRBErSTflx7n2wiz5dVB9zjFDTrJ9IlL
 IuWB0ZJ7Yy0xrRTiVwSJhvesVn53msuF+g8NGVySPI59+aLu+inN8S1Mx
X-Gm-Gg: AY/fxX7NqfGcatbeDNlHl5gY5kfABxaEP5YN++4ekhaMhR+BjwD+gLJQVvO6TGMta1o
 4INRgeDpNKTPwM2n7/KVXnBkUiwoyReqygaJDnFf2Rm39KW4Slp6nW0itvMk6SaOtodG9JtEcnU
 gTktkGlGXWUpI9SrwVon78YPQXh6PCT+37XhiGD0uKidw5xsn4H5E1bq/wuJbHcEtZlVp1Nqf4m
 IY8ilhVswKRANNuqfR+qlJhLJSVfEctxjZzLH1C6uMgt6TRQ+CK0YzW5J96sVQf2UZUQLk85QAV
 R/NY3/X0702oDljP0L18vZURj+4QJFlcE6Q++9FMm8PuT8X7penZYnEHpT9xhXZXYtOTQRplGEW
 OyWI=
X-Received: by 2002:a05:620a:4108:b0:8b2:71dd:587a with SMTP id
 af79cd13be357-8c08f6550bbmr4402001385a.15.1767022365990; 
 Mon, 29 Dec 2025 07:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBSXqyX3rZxM5d5eOq3IgazLHR4zrRgy9X4elPuJD0DZ5AC99qGnRNTQaH8IsFZy/PxZ9UmA==
X-Received: by 2002:a05:620a:4108:b0:8b2:71dd:587a with SMTP id
 af79cd13be357-8c08f6550bbmr4401996785a.15.1767022365420; 
 Mon, 29 Dec 2025 07:32:45 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0973ef171sm2405566385a.44.2025.12.29.07.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 07:32:44 -0800 (PST)
Date: Mon, 29 Dec 2025 10:32:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 02/25] migration: Fix state change at
 migration_channel_process_incoming
Message-ID: <aVKfHOb6vDtHw-YN@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-3-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:04PM -0300, Fabiano Rosas wrote:
> When the incoming migration fails during the channel connection phase,
> the state transition to FAILED is currently being done in the
> MigrationState->state, but the MigrationIncomingState->state is the
> one that should be used.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


