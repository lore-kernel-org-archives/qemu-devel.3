Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E064D58D73
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdH7-0002u5-4v; Mon, 25 Nov 2024 12:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdH1-0002rS-Ps
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdGy-000221-M3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkl5HBZAUpRAOQEbod4a98Bvzs/LScVoY7WOGUB8xG8=;
 b=hqfvphtB6qTwsq/YyMoSu5IqNPH2Rc9Hyag3gccSLOjm5v7zngW+jAHf5SbSxK/G2FoOjE
 YtzAmvEkTDAuHLZY6FgnBAocGsIxg8ZxxrzSwCtMw2sAbF9d4b9AwLgPEWyohpc5d5q3Or
 pkvoOmVkar9Ge6dV3m+fCDAlexE62/c=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-unhmssbiMxacEDNwG3NVFw-1; Mon, 25 Nov 2024 12:53:17 -0500
X-MC-Unique: unhmssbiMxacEDNwG3NVFw-1
X-Mimecast-MFC-AGG-ID: unhmssbiMxacEDNwG3NVFw
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a76ba215b2so49531235ab.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557197; x=1733161997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkl5HBZAUpRAOQEbod4a98Bvzs/LScVoY7WOGUB8xG8=;
 b=iHY5VZgCs5XgNJ6YjoX2tWnjw1G7t1BC88y7J3osGblzE+i5VDMci7pudXH5CmE+km
 0ftBFEe2ofAHdgs3ezz84QddDzMFcQlcpLLVNB+HlN0HclVU4vAvTIbz6X1HnE43US4M
 fnR4QArdTOPjHX72oIWRGg1n+Er728hXPlRzsIUNxe7g8vC1LLhSUL6vYXkxVZjb+fG/
 FMCWPv7LmcR/7Ds1m0ds7OvMFPhdZ+BR4WOeVyDuQ2MvXxnDVTJ3/9KKQ2fkYeM0/hTA
 asXUwdS7toz4PywuNEuuTcQPVQXsCQ1ZSLbs/1b61g0kudzdbtLzIGqVgeErkFc4smD9
 HbEQ==
X-Gm-Message-State: AOJu0Yy8UabyrYMiSB5jRFfbMB+F6Hknb+UxmIZUeCzyOamSIZQXtIRg
 qqr5fZLHH4Axtt3bZR8z45OGtPstcRGF1qjWPatoO2UNFqVyzpRDgEeFcHNsWYsYCjvDERag9t7
 llWSYH0roDzl/hoRNA2fdPyO5EUMTRXpW7QoVhKQsX+vFIeTqQqp/
X-Gm-Gg: ASbGnctfuLq2Dgyn9OQUzhAzSHl++yfFC9djbuZoQx2qahdCrAItNGUYRpJecDwZYst
 Aka5cSNRH7+nIWcL7UfijAnUKYYsNVK2FgDE5kIwjkal06wKSLiXIbX7YLfRcd6afrZ5VsFNzla
 RtLODstBWDSQpD2knZH4AL2/o8C6dnS4qq05Xt/03Y9VV6w0Et+i/rmVIY/suCTS+OkeVTtmNWc
 U1akvmQLjq4WcfOpVwqTymm1Xi4qI92iFjfybdNZrverg9WpOiYAP8LcW0ovjqGHJBS3Fdsh91o
 b+1EjIRpSoc=
X-Received: by 2002:a05:6e02:144b:b0:3a7:8ee6:cd6e with SMTP id
 e9e14a558f8ab-3a79ad2447dmr172601875ab.8.1732557196812; 
 Mon, 25 Nov 2024 09:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYn1hWZOuCvDH1nA3+a3fgwRsw2atsjGIA5mG9LMsxTfz6TKqEJfHyu9LnoBigHKWExK2Ybw==
X-Received: by 2002:a05:6e02:144b:b0:3a7:8ee6:cd6e with SMTP id
 e9e14a558f8ab-3a79ad2447dmr172600685ab.8.1732557195317; 
 Mon, 25 Nov 2024 09:53:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79ab86da8sm18413325ab.11.2024.11.25.09.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:53:14 -0800 (PST)
Date: Mon, 25 Nov 2024 12:53:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 16/22] tests/qtest/migration: Split precopy tests
Message-ID: <Z0S5iP4jX6Jxhles@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 04:46:24PM -0300, Fabiano Rosas wrote:
> Split the precopy tests from migration-test.c. This is the largest
> group of tests and the more difficult one to break into smaller
> groups, so move all of it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


