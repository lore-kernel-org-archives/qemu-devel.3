Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB83FC0343
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvZp-0000H1-3H; Thu, 23 Apr 2026 11:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFvZm-0000FC-PH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFvZg-0005sF-Rx
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776956552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlqxFzLd9mqHQa0AVwC1cwgWvpMpWN+zdB1R6mN7Meo=;
 b=T66plSQuiQow11gOvlWj0F1aJNBM/GdOGXxrYYY76riBGhbtaQcni8A9Zz3M0gCfRMbtPN
 vyfKHH90C6sJVvWgmN9SoNAVdvQjpVBNFmHObB9nzmTYQc2Qic4gXvb1VEZYutGJDZSjRp
 Gre/v7VhvXwwL5QzneEpyzMpQMInTiY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-voICOCLFNdWqj2p36NKkAA-1; Thu, 23 Apr 2026 11:02:29 -0400
X-MC-Unique: voICOCLFNdWqj2p36NKkAA-1
X-Mimecast-MFC-AGG-ID: voICOCLFNdWqj2p36NKkAA_1776956549
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a5f6110c1cso162185136d6.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776956549; x=1777561349; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VlqxFzLd9mqHQa0AVwC1cwgWvpMpWN+zdB1R6mN7Meo=;
 b=LX7++ek5b0Q0b+Ojkx8i0N9tguZLX3bLjyimpUMpcMrSlmTGMmrFQfXPk4IH79TbtV
 r3rkbDxycbL+1WLwJL5kYSBLwX95c1UAHV3Wous3lqDTH8pbtY7a3NKUc1NvFlz/SKdY
 rJBgb0fSdkRBNnPmPE/2FWyURVAscvMQrzU7QmtBAxyfy3BOTFD3W/ZmVpesLANK5Rtf
 z/5eNF1/qAxDJBCRusdm72k+AuAgmU0pAohbvsxImRTYToQ8j01ieTqEqmv/rhJcdZmc
 QmUvVPtNxErwg4SHv4sFHtBUvjANOvmajjcyYmx9OjW4bgk7lRuRNkXtaKt/bfeOHCtt
 0PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776956549; x=1777561349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlqxFzLd9mqHQa0AVwC1cwgWvpMpWN+zdB1R6mN7Meo=;
 b=CMroFcmTIr2LJ/9iPDnA+QrQEnNpKPlnyfbqUnjjB7Yo3SdYCrJ95bKa0DJ8CmdnNz
 vdv29YfrTPB1IfWii1dWo+Qte0ER16edeUDq7KidEtRvWk9/ZFUyKNAoDA8dLaMrEuUR
 /cUy6zxfclsvuDAVuBs0bo3HG6iD16Toa757hoyGyqhEX/PuDwKvsenbSm/eMkqKmCBO
 aQwP1rj5pDOycV3oV2hyKDkpYDDAaOKNQnYbfmq4Byj9LK2Zx9QnE6W11kvJlcv/2NR5
 sYuAssP7kzqJx4f/AIZvFTWvAyyER7wdxXX/73Kp97AMBxAP3bcgUC5JuTriIkpz5VPm
 SLfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uTMUw0zTelyfyc8FLpU6cJpJFbPjqD4XSCu9nn/0taUF1IsqesexBCI/bSqgBb/HXF3hSAbUHpcCG@nongnu.org
X-Gm-Message-State: AOJu0Yw7Mo0+BYI5bdHpaEea4rWY8XY414i71CfaQpFpmujK1kkBly4g
 FmjGakDdmwqPBMZmFjm3JvaYOfM8/EH5G1u+vSXGoQZgNe1xQG+u4t+0Klb/UX4gJvKy8Tfuae+
 2eK1EVRkmaqOb8C/p8fJ1I/7ezm/VTRcYokngIcKvgGTmmaLqR88ooexL
X-Gm-Gg: AeBDiesK8veomfDgwnp/X2SgwYdlnl5+Y0wozu09dwsDm3MbbmnuVMRVfXJFZABcgIw
 TksZmVHjiEgxWQhq0iqCPDO63bxj75l+edrVIxt58FM4chQUku1/NRmnI+YtETg0vhRnpc0XX7Y
 JZoDjUYXNLRIht9ttBZ+KfzZDj/p6cEYfuAvi/5PXc4mG/uPphLADSaINSzbRPfDMhEFGcfDSVC
 xBIaRkAJw9hNzd0abxXNbG55bvF1CE4yrlfqF5Q5v5rlxyAz2LvbJ6bCO9DJ0a/LoVshh+aJf9r
 tHAslJ2EkiJxehnVymqJs4K4v2G8Onjg/zkrI7eo6SpcAe1rd4u3muNOt2DYl4paYFdrNSPZr7s
 z35dBrXDCecCQRVqSEMMK9uPrUVlZlSrgsYosqYpVpMlwmVkm1knkx0xM2Q==
X-Received: by 2002:a05:6214:451a:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8b027fd1cc8mr471955976d6.6.1776956547934; 
 Thu, 23 Apr 2026 08:02:27 -0700 (PDT)
X-Received: by 2002:a05:6214:451a:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8b027fd1cc8mr471955126d6.6.1776956547336; 
 Thu, 23 Apr 2026 08:02:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae97d89sm162365926d6.42.2026.04.23.08.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:02:26 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:02:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] tests/functional: Make socat wait longer in migration
 exec test
Message-ID: <aeo0gHfFFDKC6KPR@x1.local>
References: <20260422230001.3168-1-farosas@suse.de>
 <624cf04d-6188-458d-bca6-dd5ffec877ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <624cf04d-6188-458d-bca6-dd5ffec877ab@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Thu, Apr 23, 2026 at 06:52:19AM +0200, Thomas Huth wrote:
> On 23/04/2026 01.00, Fabiano Rosas wrote:
> > The migration_with_exec test is failing sporadically for all
> > architectures due to a race when the destination socat process takes
> > too long to start listening while the source process is already
> > issuing connect().
> > 
> > The race is inherent because the exec: migration spawns the
> > to-be-exec'ed command asynchronously and returns from the
> > migrate-incoming command. The localhost-only testcase is not
> > representative of the majority of migrations. In a real scenario
> > between two different hosts that race wouldn't happen.
> > 
> > Fix the testcase by configuring the source socat command to wait
> > indefinitely while trying to connect.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   tests/functional/migration.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> > index 144f091ba8..3b7674af3b 100644
> > --- a/tests/functional/migration.py
> > +++ b/tests/functional/migration.py
> > @@ -85,5 +85,5 @@ def migration_with_exec(self):
> >           with Ports() as ports:
> >               free_port = self._get_free_port(ports)
> >               dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
> > -            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
> > +            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port
> 
> Maybe use "retry=90" instead? OTOH, we have the high level timeout from the
> meson runner, so we should not hang here forever by accident anyway.

Yes, IMHO it'll be good to stick with one timeout mechanism rather than
adding more magical timeouts.

> 
> Thus:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


