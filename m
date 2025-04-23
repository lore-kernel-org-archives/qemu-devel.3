Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBBDC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tES-00009S-62; Thu, 24 Apr 2025 05:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u7tEQ-00008b-NB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u7tEO-0002wA-U1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745488252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ctzATEo3wfKk0LkewVzzIrTODGgfX/lcFqq8uVOTXmQ=;
 b=bMZjERpeZp2MKHbsm3O3sEFspkXioXB4hmrwo5Vj5pldR8/+uKOHh6FU7eZjsfFp+pSJuD
 RZ0w7jgiqx8vujiKAn+CsX0+ee2EKUtmn0zGf2kyaCOn+EVLMwK7eFG+oTZwN/ctdd9wiD
 OEDcj/Tfd0IicRWVUwR3QlVSbKnww2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-3fWzFL20Mj2LaltMFOFYjA-1; Thu, 24 Apr 2025 05:50:50 -0400
X-MC-Unique: 3fWzFL20Mj2LaltMFOFYjA-1
X-Mimecast-MFC-AGG-ID: 3fWzFL20Mj2LaltMFOFYjA_1745488248
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so3204985e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488248; x=1746093048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:resent-to:resent-message-id:resent-date
 :resent-from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctzATEo3wfKk0LkewVzzIrTODGgfX/lcFqq8uVOTXmQ=;
 b=uQ88JQtYW8ZlEPn1G05V5W8PdGPGm9p2efaCBVnd9OGrkFDA/qeGDlYLE4CFmgexa6
 X0CwdCI+D9DerN7IV9erTejSmFhAQa2ucCi0EvUVRyFmEXJzlVbZ8OWQ7dZWz5Bg74KV
 aWv9fC9thFxhtu54AfNPa7Vxq3+GpphIT4f6cWm0dvVzT18UHkZ7++HHwKT4S2Fqtd4L
 W1EFmbVThJ3ftkrvrpJ+KUmZfzMIWGoS2pmtt/m5McztjOxQXMHV7Fcx7cdPahQs0ODv
 9c9gE+lFYACb/+GafN5esPqiaPtdxUUSur2FcaoV30Yj9EEbUoORDNdmtho9Rocc1KEh
 Tgkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA67vDfX3VcIt1984EwrwTYupMN6Km5MaS0PWyxj1G094MGgmnjddQ8tRy5JCVvsfOZaDRseyIhMDg@nongnu.org
X-Gm-Message-State: AOJu0YznKd0klvXw2aJ2SKAauJ5UZhkz2C/2LB9yPgBEbWOz9B10j19A
 dCytFYvlZLPKBROoUJpAtjy06W57tb/XrYUNe7jZ26dbzjBpoPNsENG5XZxqBeDUCtklodyQeRM
 BlAOEZxqnGdNMtqVm3MTig5/7tPKUaoQkotJnN4ck4NJpXOCXAtRmGP2Kq404fMfpmmZJO3rI5I
 lhBrw4J/mshR1Pslv47FaRBs8SLeRcHHv1RJ0=
X-Gm-Gg: ASbGncsV+YVWJ+rLl7+yWKKABcxKLrIjls5mkFpCLnfsWy7NsgIgVszqwc9GBpYUYvO
 Kmdqju9rwqKBBVtKgR/o4sKE05A83wreL3fEw3tX1zbt22kRSqMMxvhtBmx/VTX8vghyZWxqIbp
 FoBaHOAYJS9J4+YvqoWwslGkA1uofl3pY3T7zvQAbBHvqEI2bNvhRLZjGaga2kXNCUW8orcmtpl
 8AcONn98NnGBs/2dfjaPTqdzU4SGtlNh3LfqHN5K7Ttng9/JRhOaI9gU+sgqdTwCTWq0+KxyLJs
 fvFC3999NsAhYY6NIGXCcroyedD8
X-Received: by 2002:a05:600c:b8e:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-4409bd0fd4cmr19798835e9.13.1745488248104; 
 Thu, 24 Apr 2025 02:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK/en76t9Y/Efke962Sxvdvpuh4X+SruFNN3sv2RdeD7Cyv7QT/s3q66iAMAdI8XiwG/tOQA==
X-Received: by 2002:a05:600c:b8e:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-4409bd0fd4cmr19798575e9.13.1745488247648; 
 Thu, 24 Apr 2025 02:50:47 -0700 (PDT)
Received: from fedora (nat-88-212-16-204.antik.sk. [88.212.16.204])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bfa6sm14250795e9.3.2025.04.24.02.50.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:50:47 -0700 (PDT)
Resent-From: Juraj Marcin <jmarcin@redhat.com>
Resent-Date: Thu, 24 Apr 2025 11:50:45 +0200
Resent-Message-ID: <3gmcd5fups75kbewe4cxqnykmvhykglnprmi7zzdqizeim2o76@aogr7flp2355>
Resent-To: qemu-devel@nongnu.org
Received: from fedora (nat-88-212-16-204.antik.sk. [88.212.16.204])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625a3e4bbsm7286293a12.72.2025.04.23.04.02.52
 for <farosas@suse.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:02:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:02:50 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration: A couple of cleanups
Message-ID: <4oydcm2b533xl2tz2uujgjrmxodhrjigm5ugijwvlwxsqr7pks@qpmvfrtlx73f>
References: <20250416134356.29879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416134356.29879-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Fabiano

On 2025-04-16 10:43, Fabiano Rosas wrote:
> Postcopy code was moved and some if postcopy were left behind.
> 
> Multifd has an accounting issue in tracepoints.
> 
> Fabiano Rosas (2):
>   migration/multifd: Fix received packets tracepoint
>   migration: Trivial cleanups for postcopy
> 
>  migration/migration.c  | 28 ++++++++++------------------
>  migration/multifd.c    |  6 +-----
>  migration/trace-events |  4 ++--
>  3 files changed, 13 insertions(+), 25 deletions(-)
> 
> -- 
> 2.35.3
> 

Both patches look good to me.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


