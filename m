Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE9CEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniDO-000766-MS; Wed, 04 Feb 2026 14:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniDN-00075m-5T
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniDL-0000LQ-PF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770232018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NAz5ifMyVqO/4MketkO+Niw88qfNwYYGxKO0zM7InWE=;
 b=A4Oc1KOX+pxMMs4O0iKEmsnsPohFFjOqUnb1UL9MlR8NHuxEUlR8KH8eLqI6DB6mPZ4rF+
 fNKO0QpvtnwsyfjDqSekiFEKUKoN5bOe0NUx9AOU5SV9gqYamRC8JD355TgcVRvlG2dz8T
 XELK35vwlbNwe3qDeb5Dq6FiCq3vrtU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-WINxiCw1OiWTWdG-vUoOgQ-1; Wed, 04 Feb 2026 14:06:57 -0500
X-MC-Unique: WINxiCw1OiWTWdG-vUoOgQ-1
X-Mimecast-MFC-AGG-ID: WINxiCw1OiWTWdG-vUoOgQ_1770232017
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89467edcd21so11425746d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770232017; x=1770836817; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NAz5ifMyVqO/4MketkO+Niw88qfNwYYGxKO0zM7InWE=;
 b=kL8Qgv64Oq6/dlCv8FHVkHN5/qXsmEIGF4sdSRvESNQ09+kia1bu5qAuz8wiWMP+Fc
 0yszW77uy0xRXCKvTfrIyEyiXdBbJfd8Dx+mENYZS9o35C3GIrtWDMnoR1Cx/k/YUDPB
 hgfGKVNTD96mRWQ3h72C4kPVTUhbmIDa/xiXvwvp7sBQHi/JPVWM4EAbw+Zz5zpyr49H
 CX8kPewfi/VEKaNGp+fXMTR2gvm4rOT5SS6nejCkb6GkCoIuKC+ymdjqMmU+5zokHK8h
 MRACjQuO16imqkaRzXMfGnGn6coNsVSxCy/zFhIFQABxW7ngUjcVMPl9joz5oaD/RN8N
 4MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232017; x=1770836817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAz5ifMyVqO/4MketkO+Niw88qfNwYYGxKO0zM7InWE=;
 b=JeNzvVmirJGxg2hyFwQZ5f7sumNa/t1kXAa5SUXQzp2Nd48xM3eOPP5WPuJCLW2BzV
 O5Hkrd/rkk+HAd6JoRrdP/phKV+pLIpKDryCQuPQotgs6ODB6aJr5cWw/2+LSaaNZHlu
 CV7/FcwEHeLc10CqZ4uX8PyWItKeEmqZGauufueUyYec/QgSQMawiOVK4a8bKMsdMVvy
 eE0akWijp0UO+wxARuiM3IhQaka8pBaR2GtON17xYUQqG5LFCxW58MBBYZgjUUDUzUQY
 +PcRI4H41+PTUHGvRXIClcHArQ/uUqzBHsCqJ29RByV+8XCzF3xm8MPuRGxS/+wk7MfX
 y3QQ==
X-Gm-Message-State: AOJu0YxQtlyM2XCa7NRa4RFh8ViH8i60lbDFu68kQ0ZlPn6jdx8P7OvX
 oZYplOr8DSXw4xESvBOJLc0V1JEiMM0g5MbWBg9Zg0H+DxZTo8L4Rb22gdbpHitVb7VTpxGXcmK
 nm84T9xBB08qYCxt1d0ih5ogzLLL3tGCVygeoNHOFEYDb4xGXB3luW6kn
X-Gm-Gg: AZuq6aK6S9OLoNyQCZLH3RR3Lew0ToN2jR5kC/OdMPshvzChutGTDQfnvMvMOLP5Gom
 wIWDmajO9jTsgm80xFfB2880/GFlv/R//yrlaVqYVLJt/JTZAZEwETXjuCJ6V8yYDQp4NIxYgfA
 83hzTkcFNtGRS34OjplTxjAzj8Cvvv7jLoTK8HYMQGduITpwAT6QCgUD+lhgSzcxA/QD+oBmv0G
 5VNSywvYnkgG2LscCMgV0gDcAX0s0BYlo84ilSWQIKYL9tT2VTTQPe5dGKBGVtYvesbsw4OoqNC
 +Dbd2q4RK9L1ZVg+pS0WjyY8xlmlajZzSBqfJfJM1DWT8e+xukTAN0dn2NYTi3nHKJUK/ucZ+E4
 17E0=
X-Received: by 2002:a05:6214:5011:b0:893:348e:4126 with SMTP id
 6a1803df08f44-895221c8e2bmr54482286d6.61.1770232016892; 
 Wed, 04 Feb 2026 11:06:56 -0800 (PST)
X-Received: by 2002:a05:6214:5011:b0:893:348e:4126 with SMTP id
 6a1803df08f44-895221c8e2bmr54481836d6.61.1770232016492; 
 Wed, 04 Feb 2026 11:06:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521cf89fasm25232416d6.31.2026.02.04.11.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:06:56 -0800 (PST)
Date: Wed, 4 Feb 2026 14:06:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2 2/4] tests/functional/migration: Add migrate_vms
Message-ID: <aYOYz_lprXaICZps@x1.local>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204172332.21367-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Feb 04, 2026 at 02:23:30PM -0300, Fabiano Rosas wrote:
> Add a migration helper to MigrationTest that uses the migrate-incoming
> QMP commmand and takes the already instantiated VMs. The -incoming
> 'defer' command line option is preferred way instead of the -incoming
> URI syntax that's currently used.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


