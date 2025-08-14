Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5919ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 19:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umdZV-0000IE-KA; Thu, 14 Aug 2025 15:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdZS-0000DT-KF
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdZP-0000y7-Up
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755199500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fywHM0eSqmH3qGVIIfRHLgpyT8XlnnlYD1jBOq3gVBM=;
 b=JMhIQ/hBk2IUSX6lL/4jIA0qyntGUBGDgLCgS2rmnBeVvJobXxRS7SBr6ICZKD0f+fj1BF
 J5jPszSdws4cdQEcm4vJ3IENjkoW8YbrThs5HFpzveurJb7QLmGs0Aa2b9tkpZpEEN2mu6
 rkt5u/QGzRrY1qqHBxSa9qNMgBXmmOg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-G5Qc3hKWNE2KSn_fbJ8HTQ-1; Thu, 14 Aug 2025 15:24:59 -0400
X-MC-Unique: G5Qc3hKWNE2KSn_fbJ8HTQ-1
X-Mimecast-MFC-AGG-ID: G5Qc3hKWNE2KSn_fbJ8HTQ_1755199499
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71d603b2fa1so17048587b3.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 12:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755199499; x=1755804299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fywHM0eSqmH3qGVIIfRHLgpyT8XlnnlYD1jBOq3gVBM=;
 b=ek6ykgmDm6jb8EIJVzXXUwCcwjBhn/eTlk0Jfav6Du96xvb7WrAC1pl/h7ER7oYxQZ
 wlj0xzSkgMmyN2oOvFIgEEriWbz5Iy+eUBzj19leYShYTVdTB9A6qYRZH/t4Gj2jXHdR
 yMbVgIc1b+7rYLLOpGA7qa9hMCh0k5wkWTdmw5h+mE/lZkZ+6nL/enTVvSpwmCpdXbis
 9aoFailQ+TEfo99z97kdrhhXcy+MZGLbdTeQ+hrJPtOS1KVwm5YZTLg8rPSUU2+iugtM
 SsCsn46ilu7CEHZeLv8KIv1gVMw+/lCH9rHTWRXXL6NZN5a902pUZxRuFA2OcjdZ83UP
 ptfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiFtLXrZtDL2xfF5fYZD1O+3ROP2Kswrc3y6h+wl7vOkuRdBmswdSqmSgXXWoozUBGE6PTIPsFEwLK@nongnu.org
X-Gm-Message-State: AOJu0YwjL7EUkCwv49p6X34jGOHkYPr6lf/P4mm3U0Gve0zF5OKN/PnZ
 kl3MjMgO9NOMUMKVNNi7tLDuvb09vMWDf0AQXyXE5ef5edSidc4ktJoVCVxjIfprSC/Oz//RUFf
 s/J9PeWvHCsGO+blxGbPyS6paeAM9DKWeKspjYP3tuNJRB7wGJQrJYnxT
X-Gm-Gg: ASbGncuC486j51GcX3rXrLskxGnmbEBAKtZQi5qNW34pb3ZUuG4AxEQDQCvJ6VOrDTo
 U2sjLMLr6Ee028JfPZmE6iNHPDOHChlBZ3NZm7urd76Mc0dfXBqheaMdAMNt3DgKuruYYfIBHxK
 nJnsVmy9tvfeKr7gxqFwm6MkoS9TgHQv4HbTOM/HH2tCdmjJ4dZAalNY67z3qKSs/OzUwZDa9xP
 2Br6Cuap9xiNl/+A2ZHea/mW6o/z4McikHD/bRgcA+2vrlsNHvSdgJig7KixnWF/w+hRXczQMxl
 Fnh9NZoy90LBD7l5xbL6ILQNHSbHbnEt
X-Received: by 2002:a05:690c:6c8d:b0:71c:403d:421d with SMTP id
 00721157ae682-71e47962730mr1976157b3.24.1755199498695; 
 Thu, 14 Aug 2025 12:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfm/23QAl2GFoPog+BKFa9D+80FpJn+PYiNPDmcgMYav2TX1PPRCOh2wAwxBDaTmQfzt72ag==
X-Received: by 2002:a05:690c:6c8d:b0:71c:403d:421d with SMTP id
 00721157ae682-71e47962730mr1975907b3.24.1755199498312; 
 Thu, 14 Aug 2025 12:24:58 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d60d4fb3bsm8134327b3.8.2025.08.14.12.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 12:24:57 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:24:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <aJ43_JQct45mnVgV@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 14, 2025 at 05:42:23PM +0200, Juraj Marcin wrote:
> Fair point, I'll then continue with the PING/PONG solution, the first
> implementation I have seems to be working to resolve Issue 1.
> 
> For rarer split brain, we'll rely on block device locks/mgmt to resolve
> and change the failure handling, so it registers errors from disk
> activation.
> 
> As tested, there should be no problems with the destination
> transitioning to POSTCOPY_PAUSED, since the VM was not started yet.
> 
> However, to prevent the source side from transitioning to
> POSTCOPY_PAUSED, I think adding a new state is still the best option.
> 
> I tried keeping the migration states as they are now and just rely on an
> attribute of MigrationState if 3rd PONG was received, however, this
> collides with (at least) migrate_pause tests, that are waiting for
> POSTCOPY_ACTIVE, and then pause the migration triggering the source to
> resume. We could maybe work around it by waiting for the 3rd pong
> instead, but I am not sure if it is possible from tests, or by not
> resuming if migrate_pause command is executed?
> 
> I also tried extending the span of the DEVICE state, but some functions
> behave differently depending on if they are in postcopy or not, using
> the migration_in_postcopy() function, but adding the DEVICE there isn't
> working either. And treating the DEVICE state sometimes as postcopy and
> sometimes as not seems just too messy, if it would even be possible.

Yeah, it might indeed be a bit messy.

Is it possible to find a middle ground?  E.g. add postcopy-setup status,
but without any new knob to enable it?  Just to describe the period of time
where dest QEMU haven't started running but started loading device states.

The hope is libvirt (which, AFAIU, always enables the "events" capability)
can ignore the new postcopy-setup status transition, then maybe we can also
introduce the postcopy-setup and make it always appear.

Thanks,

-- 
Peter Xu


