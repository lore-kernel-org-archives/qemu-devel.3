Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91642D5E13D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 18:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVa8Y-0001SS-O3; Tue, 16 Dec 2025 13:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVa8N-0001RZ-9h
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 13:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVa8K-00011f-W6
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 13:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765911051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/fOSDXWu+EjBQqql2JQ71490x0+G0k/2IfhkTPq4P0=;
 b=WDdw3EpqyvADSeIJ5NSrejFeJMauwJYJ5uI5xI0OniwPuA7+GjeMQttkafdSktEGbOKpkT
 eBnIsAfD6IzY6FFHNN3PdFDYYHDYk9A8meSNvRqW1RLCQBlLujsLFmnaqkgyOAUx4hg6iz
 g22CzjRCnfU2/bGLxqTNKVyqFSP6sRo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-o6DfCqmbOpex_cfgeGV-xQ-1; Tue, 16 Dec 2025 13:50:50 -0500
X-MC-Unique: o6DfCqmbOpex_cfgeGV-xQ-1
X-Mimecast-MFC-AGG-ID: o6DfCqmbOpex_cfgeGV-xQ_1765911049
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a3356a310so74096136d6.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765911049; x=1766515849; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P/fOSDXWu+EjBQqql2JQ71490x0+G0k/2IfhkTPq4P0=;
 b=VLKUofo9JL9SAj0zwlB3Jxo7H6ZIK9IBG+VCfsgWuOxep6u7KCKrhHovGprb/0c9MR
 nF1OsCcO9r0ZPITtWIwtfsc16HGUSpr/l5bej8ZlcDNe1z46QJO3w9XlnhxNVyfhEFJ6
 pbg20LV7pKuKUvgJwYK2gmi22zpC4o1JDGd8prkW1uOsxVZSolrceq49zVlVFQRpTvCR
 mPLGU9fs7AFLGUWWVU7uCg1mIO96EXkylUXWuzrA5pCLMypnSA10jV211K/ET6VFEst9
 0gS2xkbczrB0ieY8Vpr/QF3NvraIohvvB7IHyBBFGZHggz9ZhgFVgovn9z91uesBLPeq
 w1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765911049; x=1766515849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/fOSDXWu+EjBQqql2JQ71490x0+G0k/2IfhkTPq4P0=;
 b=i8JA61S5F0axnA0u/0SUHBZ6bqy652Hu0Q8q498H5fuGdz7z7a/p0Nav37zxmBve+p
 dGlZr5Av7hMgpvUYIYrddALKMeLFaaoAcaeIG08AKEfeoWLI7QFYItY3p3oo+XgdEKQL
 GZj+aowpUVlH2aRt5VD4Q6PJCGFKygMcKSe0qzGqVwbOPwS4rIU7koVRo3iM95ieVgy1
 GQLVqIg0Spm6yXxmup1l39T7NFGPOvpPzDdPJg6a6sFFb5ZndskMkoWcdFMnk9BhjuNE
 UGz7obsGqv1dL9+oI8YVHKRcgz2BIZge5B4fyMymUCpE8yzhjGVKLtmQA/RDbexFHwxD
 tBaw==
X-Gm-Message-State: AOJu0Ywwb690aOGLi6abPZ+e7zxvK4nnvL84DBseOi2dix1B1uLkYSnd
 jF84NW0/VH9s4OsjEAlqtX5nc9cqVfHfPGjPq804JjUevn9rkqkbUhvYmGlbz5oI83iQaPMa+BR
 nn+1JQbwBfhFFY7rN2pQ5PhPuLk/N3OomgCJ/eyWz+lR3toC6mLZkzQhp
X-Gm-Gg: AY/fxX4wqnM+XjV8s4IcJoheL4PwoaWu8iFSr+SqnrH15SFP+U6dOTIuy8pjF8PxuAg
 1w6n8vM2h/pcWKi1qI5PEpTulztgE2dK44ypT5QU3WlMty9/ZJRcKhGURnnm/H9tk8cGz2/WUKN
 p0NBB4bPWZUmn0kTsR3oI/RytO51TaVU0VOvPjA69SbOjVhG4WWWDP8l/o+c2xnLfrUJFqiD215
 DIyI4Yz+m6oeH/cDRxeuK9tH4Krxep1HmUrITJhEqmikVuj6Mm9mTQQzuVl9iKygQGONvp+jEh0
 6fFHK5N9TqiCKqXwxGVIVGDXt4kr9NpGP/0ZeL7zCehPKCli4Z9GAwwaWL53tVOeUfvSNx8rq1i
 d9bM=
X-Received: by 2002:a05:6214:509b:b0:793:dce5:4540 with SMTP id
 6a1803df08f44-8887dfec0a2mr275667696d6.2.1765911049525; 
 Tue, 16 Dec 2025 10:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMgZQ59ts91VKyn+RIAMxvR7drvO3Hi2MjalVeArBVwGdCIxZcUs/AO/49TjtxBRnsJn1tw==
X-Received: by 2002:a05:6214:509b:b0:793:dce5:4540 with SMTP id
 6a1803df08f44-8887dfec0a2mr275667416d6.2.1765911049108; 
 Tue, 16 Dec 2025 10:50:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899f5bbba8sm79060876d6.34.2025.12.16.10.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 10:50:48 -0800 (PST)
Date: Tue, 16 Dec 2025 13:50:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 10/51] migration: Remove checks for s->parameters
 has_* fields
Message-ID: <aUGqB1V_ulqZ03T3@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 15, 2025 at 06:59:56PM -0300, Fabiano Rosas wrote:
> The migration parameters validation produces a temporary structure
> which is the merge of the current parameter values (s->parameters,
> MigrationParameters) with the new parameters set by the user
> (former MigrateSetParameters).
> 
> When copying the values from s->parameters into the temporary
> structure, the has_* fields are copied along, but when merging the
> user-input values they are not.
> 
> During migrate_params_check(), only the parameters that have the
> corresponding has_* field will be checked, so only the parameters that
> were initialized in migrate_params_init() will be validated.
> 
> This causes (almost) all of the migration parameters to be validated
> every time a parameter is set, regardless of which fields the user
> touched, but it also skips validation of any values that are not set
> in migrate_params_init().
> 
> It's not clear what was the intention of the original code, whether to
> validate all fields always, or only validate what the user input
> changed. Since the current situation is closer to the former option,
> make the choice of validating all parameters by removing the checks
> for the has_* fields when validating.
> 
> Note that bringing the user input into the temporary structure for
> validation still needs to look at the has_* fields, otherwise any
> parameters not set by the user (i.e. 0) would override the
> corresponding value in s->parameters.
> 
> The empty migrate_params_init() will be kept because subsequent
> patches will add code to it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


