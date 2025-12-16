Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20C3D609D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYMu-00080G-IF; Tue, 16 Dec 2025 11:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYMs-0007zz-Nf
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYMr-0001uT-5o
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765904263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W6+CIVArLAWLHn7at7PU+qtvo6lfiJ+hBghDyK9N1yw=;
 b=TS8FhR6w/r0u2ipdzjNC/wLJBqmRqVg4eIDpkkLmA8lUKpTnNmiMpeDxiDRCNenfCmiGxf
 c7YPqFE8EwyqdZC0P0isRFbd+BVZPlZGmqHl19948Vead2fy+GC+RiVvEWxGVaQtX6O4+8
 QQZO56UJwPBp2OFLNwGM7cz/ivVHEk0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-VBROhPZJO-6uWHHAXakP-Q-1; Tue, 16 Dec 2025 11:57:42 -0500
X-MC-Unique: VBROhPZJO-6uWHHAXakP-Q-1
X-Mimecast-MFC-AGG-ID: VBROhPZJO-6uWHHAXakP-Q_1765904262
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a2ea47fa5so58100636d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765904261; x=1766509061; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W6+CIVArLAWLHn7at7PU+qtvo6lfiJ+hBghDyK9N1yw=;
 b=JuC28FS6HdGqt/zijSptJ/9FJ3ofWZjeNEw6gErxzHOP4EQMJy2IGuLXao0lF2W/9e
 qhkgnKJAJsjjaaA6C+zo6POkuANloCCCa2bXc9/Hu/izV4kQaQ0nFWXmtGda4hmKMAIH
 fFLYW2SIOw2G6py6n3rOIueFMFSTDvek45fLvHSphwDAHoN9ve2tICWiylHyH+ZDYiVs
 0uTbYGtDv3ovRA0w8B6kZtPJCPQibYhW5nYjLCTvjgrv7fX2Ii8flnXdvpWzd/EmKoLw
 LboSJ31GLxnML2k7cN8EsU3cjflHCwMMdZ0XtljhUU6KUdTx/8yXU3zUm1rv+wDxmkhk
 H0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765904261; x=1766509061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6+CIVArLAWLHn7at7PU+qtvo6lfiJ+hBghDyK9N1yw=;
 b=BmbfZW+KUTYm+fAweI0+uTYysEy5vy9xA3lNryYCkJycPgsztOsGLHe3za7bczlN3A
 e7I8ZClLNIrLTdupo9uTwCeXXeRTt5lFv5tYdi/flalS/GQOJx71J+h3LlaXl36mbZJG
 L1V00iblWSa35TxCofylMB2OkKIksNFRQ2IRA32xh/vi/P1MMMOTm+McJnanIFYcPQKl
 1rRc9iOob4KqgCKNgwBc9wva1nnP+u3rPAKE2jv7DDDdH0Pvdzr6EpHusxhx5PBjphic
 SOnxm1uONnIShdaYW2VTJcYVguw8gJFxsJ8qboUlmVQTV1N2O8u+Z4sO/sEBHUeFTGMu
 kCrg==
X-Gm-Message-State: AOJu0YzCXgL4BZ+XtkYrgMpSHDAhiv5mAMg7kXcOQtyuwKUBub//BNy5
 rQvZCvQftlCPbkUMd+SMPL8Y682bxgQY6WIHMZDUtHzDLGmktd8KqmSzNTrrJUziek1CHyUsZjU
 j1sonaHAVbKRML1VI4L++cF5spjTWOlfGktDCMIEP0HHstkz0cUdL/vz0A3lcsLT1
X-Gm-Gg: AY/fxX6al8E1usqX51h/xFulTDQMy0KM0HOtdsigEmyxP2UxuywCTiRTs5P3gJFh1HO
 16kJIw/RJweLYqold1fEp3rKdtlwfJsdGyOolflgo92JeKz+UJ2logoIr2oHlaWJCK2FhJjv5z1
 htazi/LOR97C7TF+ygHs2wWBauAnyiec4glngAojKn7gmPj6CNYboYXxXVxm9N9xxXvLKjQii8a
 hYdWhAuV8DV/RIsL7gRcpwZ6A7a7NXP8pGwB4YIy/Tb5TSudQlBYVh1JkgMX9Fyr9R2VN3qPVtM
 E30gUZ9w+xHtoLM0Y1nDS5HfUMyixBkIS0VluCmwxPYIP3XPMSwWlgtqhEtzYFtXnYoWQA/E35e
 KRho=
X-Received: by 2002:ad4:5d4e:0:b0:888:7b01:2839 with SMTP id
 6a1803df08f44-8887f241108mr232889746d6.16.1765904261451; 
 Tue, 16 Dec 2025 08:57:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGChzdHyOrz7apYxvm84RjoQh/HvN7rtM1E9G8XoHba8hCnbQUX5tv0kkTDtm485Cwc9+49JQ==
X-Received: by 2002:ad4:5d4e:0:b0:888:7b01:2839 with SMTP id
 6a1803df08f44-8887f241108mr232889536d6.16.1765904261017; 
 Tue, 16 Dec 2025 08:57:41 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993c659d3sm78978086d6.24.2025.12.16.08.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 08:57:40 -0800 (PST)
Date: Tue, 16 Dec 2025 11:57:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 03/51] migration: Add a qdev property for StrOrNull
Message-ID: <aUGPgxXmT6P9fV2B@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-4-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 06:59:49PM -0300, Fabiano Rosas wrote:
> The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
> was done about eight years ago so the migration code could make use of
> qdev properties to define the defaults for the migration parameters
> and to be able to expose migration knobs for debugging via the
> '-global migration' command line option.
> 
> Due to unrelated historical reasons, three of the migration parameters
> (TLS options) received different types when used via the
> query-migrate-parameters QMP command than with the
> migrate-set-parameters command. This has created a lot of duplication
> in the migration code and in the QAPI documentation because the whole
> of MigrationParameters had to be duplicated as well.
> 
> The migration code is now being fixed to remove the duplication and
> for that to happen the offending fields need to be reconciled into a
> single type. The StrOrNull type is going to be used.
> 
> To keep the command line compatibility, the parameters need to
> continue being exposed via qdev properties accessible from the command
> line. Introduce a qdev property StrOrNull just for that.
> 
> Note that this code is being kept in migration/options.c as this
> version of StrOrNull doesn't need to handle QNULL because it was never
> a valid option in the previous command line, which took a string.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


