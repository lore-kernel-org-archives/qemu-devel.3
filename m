Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB82FC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 21:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tigNm-000438-MR; Thu, 13 Feb 2025 16:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigNj-00042X-1k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigNh-000201-Kh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739480659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LfMZsjKFVKfScjbU1Ac+bP8EeSQBEHZnp/YrM33sdK8=;
 b=YvxTEhl/bV3RlckFieD7VOaClIn6czGRjTSAqLWPKNARkhccJ2RFOqffbgAKLQZYM9Mur4
 Mdec0Y5zzVDpxQMv1wX++BR59uoqe0ynMDZNO24aAMgYAfeW/VtU2eGzy2jVOJf1IF8v73
 +OZ+sjxBcTWlt2P5C2ljYusdBNVbU0A=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-evGgf5NTOHWI_HzVt6FY-g-1; Thu, 13 Feb 2025 16:04:17 -0500
X-MC-Unique: evGgf5NTOHWI_HzVt6FY-g-1
X-Mimecast-MFC-AGG-ID: evGgf5NTOHWI_HzVt6FY-g_1739480657
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2aa17fc59d1so1320541fac.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 13:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739480656; x=1740085456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfMZsjKFVKfScjbU1Ac+bP8EeSQBEHZnp/YrM33sdK8=;
 b=kd3393wlychrIy/ISLLRU/80oUYV9pHXqbSmHRn/pOIAL2aqGrkoysZtyFauxIOL7Y
 XK8NZkTxnxauMr2T/Fae1Brt+fRAj/2IBxKNbTpA6Psw2vuEvDc4WMJx4pNNw18KB2Hb
 7ctKumh+5XocKNuWM/vTzMVd76G0av6G5xW0/MNn2bpA5EeOYFfivyg+Nbw8jPYS4c7Z
 FLC4WjYQO+s4dwl9wA31IK3l5+GMqABgbcM3GOUJvU3W/kRM1db2WwvUS3CKG07G//WW
 PULPDBJY30JFib+dtfMNiKQbw1v+7XXmXEdGCIEeoohrEbSnssW7/uHi0qOw79tnbdBJ
 FAAw==
X-Gm-Message-State: AOJu0YyLCKarbmuK45fshlQIdzcSDNPQFAeMJ72xq+Yo3VoQNTlja6Jo
 xi7ILQP4W6KXhUzhUzENqmkEq+LlwVSeSV4DAX88Y+zvqLO2HdFPJaiAV4aCsFQZbf5+pe3RHKJ
 zOUoZ0bk4CARGtRrrUpqn8w7zThDECiq8A1hri6A1WtsPrEU3e2Ne
X-Gm-Gg: ASbGncvWLPl0g4lxuPblqOmEGvdtc64uFpOu81aKEU3wdkLNCDqjTbnipgvLquIjkAf
 Xz3E7kD0P8pOKuBRq60zaevo/FwtIqGXcTPIId3b+mO9muE+Wz4EGLMKhjj32lYi1L9TAmg471b
 rqqCOoFsGszHF0UoC8FtW79La78CusExgOfwSp3XheLX4E5pN018Bmgh6lG2WDKeLqiZZQ3mENS
 nyHB2HOliL9nTcsQtcn3+Gw2SA8rBUjNhogEMC8HIZn2Db3eU4pWlJbrDE=
X-Received: by 2002:a05:6871:a106:b0:29e:6f32:6da1 with SMTP id
 586e51a60fabf-2b8daeffddemr5187025fac.31.1739480656742; 
 Thu, 13 Feb 2025 13:04:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFATZBDDTpm2R+IyT1KIBiMJTjfY4ykh0QX203aJZT2n4JlDc2dpcjYqcCgAJfkQDRpdUv0vg==
X-Received: by 2002:a05:6871:a106:b0:29e:6f32:6da1 with SMTP id
 586e51a60fabf-2b8daeffddemr5187009fac.31.1739480656455; 
 Thu, 13 Feb 2025 13:04:16 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b954820091sm1112185fac.7.2025.02.13.13.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:04:15 -0800 (PST)
Date: Thu, 13 Feb 2025 16:04:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 6/9] migration: Don't set FAILED state when cancelling
Message-ID: <Z65eTACUqiKQaaz1@x1.local>
References: <20250213175927.19642-1-farosas@suse.de>
 <20250213175927.19642-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213175927.19642-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 13, 2025 at 02:59:24PM -0300, Fabiano Rosas wrote:
> The expected outcome from qmp_migrate_cancel() is that the source
> migration goes to the terminal state
> MIGRATION_STATUS_CANCELLED. Anything different from this is a bug when
> cancelling.
> 
> Make sure there is never a state transition from an unspecified state
> into FAILED. Code that sets FAILED, should always either make sure
> that the old state is not CANCELLING or specify the old state.
> 
> Note that the destination is allowed to go into FAILED, so there's no
> issue there.
> 
> (I don't think this is relevant as a backport because cancelling does
> work, it just doesn't show the right state at the end)
> 
> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
> Fixes: d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
> Fixes: 8518278a6a ("migration: implementation of background snapshot thread")
> Fixes: bf78a046b9 ("migration: refactor migrate_fd_connect failures")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Not like migrate_set_state_failure(MigrationState *s)?  Not a huge deal,
though..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


