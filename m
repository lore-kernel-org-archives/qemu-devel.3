Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3097CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 16:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGgSK-0003Kn-S4; Wed, 05 Nov 2025 11:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGgSI-0003KD-VM
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGgSG-0004dD-ST
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762360429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMZ85aOOoWVEbv8EO5Z7IV7ibmHqwwtEezJJ3LPchYw=;
 b=JQPKZ1D5OaGZFHj+7xDjLo6j8tKGdBlj6GnTNmwsRlu18dhTJPzD7lC8Yy2l4Pws75w6bB
 T6gNZeEBJJynUUZmvhXnw8XFSs/y+xtrl+g3FrYEYXyfRigDDjfSKUXMcavP2CyCUI9cdl
 UBu4SYw2hXPuVCuiDBTbee9eFg9bW7E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-yOARHmEbNnC__NORqCAleA-1; Wed, 05 Nov 2025 11:33:48 -0500
X-MC-Unique: yOARHmEbNnC__NORqCAleA-1
X-Mimecast-MFC-AGG-ID: yOARHmEbNnC__NORqCAleA_1762360428
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4eb7853480dso193654781cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762360428; x=1762965228; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sMZ85aOOoWVEbv8EO5Z7IV7ibmHqwwtEezJJ3LPchYw=;
 b=iXEiLLoJK7Y5I7kk6iwps8QAc4k+Cd8L3wZKuCZSrXbqFttKPs+XO1W0AevZ9PdYyL
 agcOKBX1cbKCR47o076HFiha0UcHIddiJHNuWC8SSu4tkDq1sgA8xk2j3dOFTA55bGVx
 tfyPpfS0EFkAj05NXn/nYf6u2G17BaIjsFOO33RyRR8gUaGou3UFKNHiha3iK90rxvsX
 ZAGCMN9RMj4DBMZo41k88GG+W3cY1//Rz2fMYnI9OINPtH7sWjtalr0n1YQs8UM4T7HV
 +3yhY9l8BufiBOIO5773sV+brz5FrkynMo54t3Yx4Ez2NQ7cP9/YSEExSNPRiCLX86lh
 biDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762360428; x=1762965228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMZ85aOOoWVEbv8EO5Z7IV7ibmHqwwtEezJJ3LPchYw=;
 b=X3BO2S9oecRZBdqJpIa5+QVIT2B5dfDm0cyHx4FmpbBhrN39wVvsY05kYTBL3zB3vE
 B542p/7Vh7fzRF/2xBJ/YznJou0PpeS5hY93mGVrx7Bp+WQXXxdxd6P+14gGi9jd/duO
 ae68MzxUqkYG7pqYreBMI6O2xhCd4zr4fh+h7TLBUILpNwN4pqGjl7jORd/WfyE4LxDi
 MAYbe5REsrSCeKlaKr2wjUpSe2pCeRv4HRx7NpjXDy2mezabbF5uNL/kAMfqyllylIC2
 XerZzaW1Myq9hE4725Htjh+382Uo95STPUE6jTcRs4Zqk9GsrnYJjKO6TdOgY2VOM4N4
 JTog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcKOOoLX73/u+pWAe1zlXdbWX7196ZM/7Edl8+RHc/xVsDUKoYS5BoF8hqrO0vLLXWrG9uB4OcO3z7@nongnu.org
X-Gm-Message-State: AOJu0YyDv8Qhm886XJ5D0Oxnb9JXCdxbP30DOjc/F/m4o4D0GGAxDUF/
 cMWkeMW8t6RH1RD0Kl1dkvfqegZDZ4kb23K+STx8A9zzU627pMJuHPNg81Nij3M/zUFL/qikK0K
 UGB1jX0j4C6zvWFau8Z7M39JdFkDSd8RvBDCs5Uc9v8ZlPaGffFvrzxYG
X-Gm-Gg: ASbGncsRdrCN4WS1v0c01HhHBUDx5mv2JU2/4b7qZKFiJHeE/3HAzK09IApC6+CFCC7
 3uxvsHnX0aPdPrGqMQ0Gxz5beS8JjF+go8+AZ9lQJOIGrZ6O5uiM+yJlwYBuqSYY+dQ8lx2jGR2
 JP3k0VGCMdUo2utv0cs5l3Nxr7lONHyq+swOCQshY9NSH4b7vFl6o/4bDXEcZUndMmib2Z9hRt9
 csIpMtdR9CsAh2cQQLSpEVFW6snoFY4wdAsVFwKJeLUb41s77nT3gXpegCWVYS/2sTOjD3vK4xu
 D/H5b2CBGlSyxfsMl52y2tv7j3KX7F7iOx4RBU6zez+uV11iVvnLknsluu6+rysgOMo=
X-Received: by 2002:ac8:57d6:0:b0:4e8:aff9:a7a8 with SMTP id
 d75a77b69052e-4ed725e18dbmr56100891cf.52.1762360427838; 
 Wed, 05 Nov 2025 08:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHvRbu1eGSyRnSNe7jM10v2kn+YIeuf7dfPKN1+JNdURPd/fNvI0mX7YhxxFga1GE4IpBjUw==
X-Received: by 2002:ac8:57d6:0:b0:4e8:aff9:a7a8 with SMTP id
 d75a77b69052e-4ed725e18dbmr56100371cf.52.1762360427335; 
 Wed, 05 Nov 2025 08:33:47 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed62334f52sm39115771cf.20.2025.11.05.08.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 08:33:46 -0800 (PST)
Date: Wed, 5 Nov 2025 11:33:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/migration: Rewrap to 70 columns
Message-ID: <aQt8aZANQOuMbtw6@x1.local>
References: <20251105134553.354886-1-richard.henderson@linaro.org>
 <87y0oklfw4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0oklfw4.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 05, 2025 at 03:20:59PM +0100, Markus Armbruster wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
> > Avoid
> >
> > In file included from ../publish/qapi/qapi-schema.json:53:
> > .../qapi/migration.json:1750:1: documentation line longer than 70 characters
> >
> > Fixes: ae00f0088ff ("migration/qmp: Update "resume" flag doc in "migrate" command")
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> 
> Commit ae00f0088ff was actually fine when it went in.  However, it
> produced a semantic conflict with my PR (merge commit d752763d0b9).
> 
> > Applied directly to master as a build fix.
> 
> Thanks!

Yeah I definitely overlooked what was happening concurrently.. thanks for
fixing it!

-- 
Peter Xu


