Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E011FFED3CD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGH7z-00019p-QW; Fri, 24 Apr 2026 10:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGH7w-00019L-Bd
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGH7r-0005qG-Ag
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777039401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FN7UDKC0D0XlNKYn7DoLgNGO92GIKAvMKYSFHNAB+cM=;
 b=ZbLHijvolz7FDlWlAxUNAUHNSlnQEHPRhpP0Fw6iLdIQ23yPXaaGrdyVyueGWGLwfJ1Hxr
 MKGIaa4/90OO5rP458a42qgBobn58fLpZShEoKadg2MXPytdY0t01p6Q61KussGzF2B6vX
 bf2CI8B1+QoHtW4H6/uBWdpH1hwDwoM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-GfEizOhmMT6FD29RQ51gaQ-1; Fri, 24 Apr 2026 10:03:19 -0400
X-MC-Unique: GfEizOhmMT6FD29RQ51gaQ-1
X-Mimecast-MFC-AGG-ID: GfEizOhmMT6FD29RQ51gaQ_1777039399
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-467e8ec004dso10005505b6e.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777039399; x=1777644199; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FN7UDKC0D0XlNKYn7DoLgNGO92GIKAvMKYSFHNAB+cM=;
 b=c3eyXN75CIC4Xquk3/mYRJASojDA5gWTgrY3oeK3py8LO/wDbSKprU3oEo1BRHh9Hg
 hijeRTkXNFF7HMnLUzIGXbhlj1ALOxeKdg02sT7nBxf6YUSiLiQxsYcM2JiW8188VJKL
 QTmMxO+91a29pAYqylpoF5Ol2clsII7f6K28eC2eQp4xcv9utyTS0C3COphySrY8+uJ2
 lfx0e/9V+RWURMVjiti/MI54aReqe+JU/XCgDLiTdY98jY5VrTQHfFcZ0z0WVVWd19P8
 E6VecZ7y5TrUp349bonYKKmpGiU+5P2ioTOBHuAT6Wj4gVUMINpOdfDarsCDIyT3Sgdf
 q1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039399; x=1777644199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FN7UDKC0D0XlNKYn7DoLgNGO92GIKAvMKYSFHNAB+cM=;
 b=aYN9J7eqDmSJU3Cu/W9faO510Fw1JJxJTLv2Pu/pHlOcBl7qmTAHW7PCd/e9I//xR6
 pL1/2PmZeH5cpvmUsYLJ34YlLJR7Ck7iJvnpw48zyOKcNs70/uiOAN1XODOucZakyxfg
 QVv8g4yXBIo6RHUUJm6V7HG1wJukfCgIDJvYIj28xKeFyvpL5z51PQpL+1v2I/4jbH8T
 DJIWyLoQUqZAIYYBePXNtTW5nU0r01JLqIbVLhkPj0f+CaOlriEMklyGTImghgvB1I07
 s6pUq5pW95lE8jghrV3t2q8HUpBTjiqqxhG48bjmbybGW1azCQLW+ULLnuAqFNBkeWIe
 /BKA==
X-Gm-Message-State: AOJu0YxsIDs/RuvBHfFmyH8C566n6u6kdl9swHUth2uIxxD2/L60MPqd
 fruaV+uLz+k3ZwZ5glI8KhILuf/Sylgh+jezZGOGyxpU7+GUd7sW2W81MU+TsHzCJBILFNARAZ9
 YHs+DgAGYWEqFf4HCZV9nPhuvBbLjVuW2O+YwFUYUKD+WqSHQy8qRvZvE
X-Gm-Gg: AeBDies8i70fxkfkHuQCkYVhiQOtmFyUtlb//IMtcUljE4S2tf6JLulHu8cL+u/3UJ7
 a23AnOhrla9+2vv0JeZ4x4R8UckXHf6XINrG5Ah1PevjghxH++p04yg/Ru5e7nur2aFhDyjuJhi
 z57XdN1cv9fERncHeEtZuvcJi233Cc8wbKpdtNaQ1Tt3y0ZdxzHmmmLnqtkvouU3IxvUPe6same
 +B1N3Xu6X3GPPqCunoe6VZUJjMrG5OR+TkfKT58jAM7KWvQeYxdeapyZr425WaonVDdsK2xQieT
 QKm/AyvU273zH5SNa/IBXf2lz7Bl85GMqkAkei8WdRpnsBNVGApuPogV+FkFaqhKFzpPtGQxmgd
 3z0ZO9eWPlyUP5WbWtz/ihBrAIwsM1IbsFdgUcg9HgpXOfeWYGjH8wSfAYQ==
X-Received: by 2002:a05:6808:8484:b0:467:bfa:bdae with SMTP id
 5614622812f47-4799c975e4cmr12360405b6e.20.1777039398871; 
 Fri, 24 Apr 2026 07:03:18 -0700 (PDT)
X-Received: by 2002:a05:6808:8484:b0:467:bfa:bdae with SMTP id
 5614622812f47-4799c975e4cmr12360347b6e.20.1777039398274; 
 Fri, 24 Apr 2026 07:03:18 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac429ffsm187482036d6.2.2026.04.24.07.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:03:17 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:03:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Message-ID: <aet4JNhPwnbQA9DI@x1.local>
References: <20260414223718.23965-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414223718.23965-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 14, 2026 at 07:37:18PM -0300, Fabiano Rosas wrote:
> Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> method makes the handling of the TLS strings more intuitive because it
> clones them as well.
> 
> This also fixes a segfault when a NULL TLS option is accessed as part
> of a validation check for another option (e.g. in the zero-copy +
> multifd compression case). Details follow:
> 
> Currently, after copying s->parameters to the temporary
> MigrationParameters object before migrate_params_check(), the
> references in temporary object to the TLS options are dropped, either
> because:
> 
> a) the user set a new option, in which case that's fine as
>    s->parameters still holds the reference to the old memory or,
> 
> b) the user did not set a new option, in which case keeping the
>    references in the temporary object would later cause them to be
>    freed along with it, leading to double-free when s->parameters is
>    also freed later on.
> 
> In this second case, it was overlooked that the TLS options can be
> accessed already during migrate_params_check() as part of validation
> of another option. Those pointers should not have been cleared.
> 
> Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
> is not stealing a reference from s->parameters anymore.
> 
> Fixes: aed97f0563 ("migration: Normalize tls arguments")
> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Queued and added cc:stable.

-- 
Peter Xu


