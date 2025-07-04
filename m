Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiUL-00034h-Qk; Fri, 04 Jul 2025 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiUD-00030g-QB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiUA-0006mI-Pq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751643477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2ksY8Fp2uO8mBcppvE25UYfkZuvPfN0axMJ+iX86yM=;
 b=IfPObvB2CgDomWhrrahG6r2LBtmp9ss74/iwnFowcp/mAR54VvoWQ4BVEEXnuH0UGjprDv
 ezxQxbnmXE+Wk4jQXCAbeqvLJ0SieeKmYXZpsaMn9oiCSvOU9EqjrMA7c9knlZEFiUptEj
 K2d5u1dgwodEbIjEmVSDuQGI8LdjWF0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-cV2ccxOSN3iu_ZC-7TQtlg-1; Fri, 04 Jul 2025 11:37:55 -0400
X-MC-Unique: cV2ccxOSN3iu_ZC-7TQtlg-1
X-Mimecast-MFC-AGG-ID: cV2ccxOSN3iu_ZC-7TQtlg_1751643475
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7d40d2308a4so132413885a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643475; x=1752248275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2ksY8Fp2uO8mBcppvE25UYfkZuvPfN0axMJ+iX86yM=;
 b=C1PNLAWQqjZtpPkQMMTitkm5OCLDLQXY8aPjJLTVSbi0jTSuyBj/qCG5TNLCFr0ZDn
 F6/tL9joLBeZGJXxwoTLFyAK52yfwe1Hjgv0OkilyabfHLgyq01K2ts+vcK4M8uynwgH
 1+cmiS5t8ee3d7qIxTmQOP+M6In+t5hVA85u7RjXhHnW5X10Nn8ifzc24o0Cp2X+mgf2
 QgZvGC8lX3IFNy/al6MPK92wdDD+VKMyFC3uI8T3xa/nTs23NtbqJhYANWpaHnpjkCwe
 AkBRqf95CHRlpJtJX1fNw33zLFGHopxKtQT3qXQDm+NsP3MHTe9gdt1gzXqZQdC8e5Br
 1tPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGd4GD+R4abU/XN+T5ddga7PGlP8DVhzFq3Za6Nd27LA+hriE2GlbH0/ryA/INmRdXhITjYTI2x9hU@nongnu.org
X-Gm-Message-State: AOJu0Yxi5vQsRT+thclNwug0YEuLc8PzxlTLDpq4WRtZ87DuqUn+EOFt
 nL9QDjKloJusJaJKuVUzL1lVu38mQ2bMJPfyH9su0Evw32RnNiusaDP/oQK1lWE8cGiPFDrPtCA
 2gdPQ+8zgEAyO8rsT00qW2Yc5GUbKtG9cvW5/1QhGfxKmCPUgZHHyWfAa
X-Gm-Gg: ASbGncs904YqoljpppmOekhzM8zgJGQu3Q/gL1yUq60w3uLAaGZloFAguvYNC2WZkZq
 A+pjgA8VWsCPTmkmlyQ/+PGKxZX+5hgKVmYmVXk6s78rGTQZmu61vZva6a0uJT9v78tsGqr89Vy
 LJWtxJmNhxHmyP8H0KJALNUe2DIW0CMMowXDpDcYuNQZnusSoGdcPJXqPesFA18TrqKg7cGSQk+
 VhYhwE85WI7eZ0YeESAwpHpymSX7L7f5Ne/YRVvlAndSSzteerg8kh7uUlxcZPkyYSXOKUIamj8
 agiwW+8UbS6PEA==
X-Received: by 2002:a05:620a:414d:b0:7d4:4c40:8e02 with SMTP id
 af79cd13be357-7d5ddad8964mr447389485a.23.1751643475248; 
 Fri, 04 Jul 2025 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXzrfplpW8bSmQ3udDKkMQxHNntgTTIldf5h1Kqp2pKQCxNMEyRS6VOZlvC+gJyN/cxNOF1w==
X-Received: by 2002:a05:620a:414d:b0:7d4:4c40:8e02 with SMTP id
 af79cd13be357-7d5ddad8964mr447385785a.23.1751643474838; 
 Fri, 04 Jul 2025 08:37:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbe919afsm158375485a.93.2025.07.04.08.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:37:54 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:37:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
Message-ID: <aGf1T8CAQpyf8YoY@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-4-farosas@suse.de>
 <87y0t81hg1.fsf@pond.sub.org> <87o6u456xn.fsf@suse.de>
 <87jz4o3xry.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz4o3xry.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jul 04, 2025 at 10:12:33AM -0300, Fabiano Rosas wrote:

[...]

> >>> +static void tls_opt_to_str(StrOrNull **tls_opt)
> >>> +{
> >>> +    StrOrNull *opt = *tls_opt;
> >>> +
> >>> +    if (!opt) {
> >>> +        return;
> >>
> >> ... it can also be null.
> >>
> >
> > Hmm, I'll have to double check, but with the StrOrNull property being
> > initialized, NULL should not be possible. This looks like a mistake.
> >
> 
> The code is correct, this is coming from the QAPI, so it could be NULL
> in case the user hasn't provided the option. I'll use your suggested
> wording and the code suggestion as well.

One more trivial question:

> 
> >> Maybe
> >>
> >>    /* Normalize QTYPE_QNULL to QTYPE_QSTRING "" */
> >>
> >>> +    }
> >>> +
> >>> +    switch (opt->type) {
> >>> +    case QTYPE_QSTRING:
> >>> +        return;
> >>> +    case QTYPE_QNULL:
> >>> +        qobject_unref(opt->u.n);
> >>> +        break;
> >>> +    default:
> >>> +        g_assert_not_reached();
> >>> +    }
> >>> +
> >>> +    opt->type = QTYPE_QSTRING;
> >>> +    opt->u.s = g_strdup("");
> >>> +    *tls_opt = opt;

Does tls_opt ever change?   I wonder if this line is not needed, instead
tls_opt_to_str() can take an "StrOrNull *opt" directly.

> >>> +}
> >>
> >> I'd prefer something like
> >>
> >>        if (!opt || opt->type == QTYPE_QSTRING) {
> >>            return;
> >>        }
> >>        qobject_unref(opt->u.n);
> >>        opt->type = QTYPE_QSTRING;
> >>        opt->u.s = g_strdup("");
> >>        *tls_opt = opt;
> >>
> >> But this is clearly a matter of taste.
> 
> This is better indeed. I was moving back-and-forth between
> implementations and the code ended up a bit weird. Thanks!
> 

-- 
Peter Xu


