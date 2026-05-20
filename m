Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjf1-0005cs-D9; Wed, 20 May 2026 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjew-0005cW-Oj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjev-00084t-7B
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9Y5I02xB9AzsfYYk2CITppeb6tmT15ZD2zlQeKHLig=;
 b=T8hs+O4mP3PRJBfm+Mr0oh2E+heOBqey4Gp1ySKawYpsr2EliT6B9aVmMdL8umw5zyphOJ
 vDOpeWJFn5V25yqK0XkqKxNgwkSPVqx3AAkMjL9KjRszI2F0+PlrpN8jzMl3/hrg1A80s6
 ktWRy+AfdWm8p7l9Q9R14G6GtkFKBJI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-sdow4XEvPkKLf5thbtqQ5A-1; Wed, 20 May 2026 12:20:33 -0400
X-MC-Unique: sdow4XEvPkKLf5thbtqQ5A-1
X-Mimecast-MFC-AGG-ID: sdow4XEvPkKLf5thbtqQ5A_1779294033
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-515224a8aa0so67723261cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779294033; x=1779898833; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v9Y5I02xB9AzsfYYk2CITppeb6tmT15ZD2zlQeKHLig=;
 b=F2nhQbhL5zZwvQs1kUSwsgt5GTwLm/6KU500ghKN9amSLept8pIMAuvpx8/pobNla2
 P6L6m8StP/HFEd01ab4fjq1QxLknx3gHL8E/M4cojX3wYCbh0WHEM2dkhZYHKhFiCNDv
 xnNvdN4U4Qtw5u/78FU+tkVmbdw5T5LjQNYtXYioeLlHAhJfZSqMLJPkb6wX65fjNQNO
 5craDWV1N0dNwC9sq1nSUO/Avi5iwAgnVceBum+CfzotM++V9zisksifDF0/eGXcQA4t
 lzo8yT4jEQ9UWrzwtPBhRl22EI8JXosa++vhr4msR4MXxdzRriRgv3q0h5WWmSjEHMjK
 MYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294033; x=1779898833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9Y5I02xB9AzsfYYk2CITppeb6tmT15ZD2zlQeKHLig=;
 b=qKeSRpbeItGj/ixfi8qHqUlzGMM27oouvxxRh74QQ+VFp3rGPWBqNdmZIFJ8ybiptJ
 mLMwOZUSrGBGBMXlG6eZ24muGZzfPVUi077BXsWM9unrTtsPGoBSaVrqPrgUgFrJncJQ
 3GRy+3dmfAkta3I9V5qJeWtQsKg6U32ItHhOEGv9hg4i/c7Nrb9ey+OYUuUkuxIBVI/v
 87A+cJkc7Kw1UmwVMOMc+3h7YemtWvccKgrFCR85c4VFAE7gpSObVTznP3uBkxG68a2L
 52DsxNu/9tXVf5l7knSPnvOpZb4+2dC0L937WG6LtgaoABiwFZvsj2mE8EL+dQauFcaP
 7BWg==
X-Gm-Message-State: AOJu0YzAd6AudU3HCIof8m0Qxu0T8Cz2sBu44onPmPZNfCnXoCT1pOPz
 5+YXT2DhYAYPwJ/SkkaZ5towWsfonMxnFedq178XuWM4wYtXhLIx/IHv2l6nqHiiHeXVv0YawSQ
 JBW3EhZw6BXp0TyNZ+sKs25l6oyT2Zppp4ti9tn7lrV8A/G3bZ+tmuCtn
X-Gm-Gg: Acq92OHJVACGM30Uijj2dzwk9SSq7GSYM/1ylTT+dogENeXW18VFxv3cv1fPchtbxVd
 59IYIqtrFvLvSciA82iBHNi/e1/g3j1Y0JBtXFcyQF3doI5q/D/0XYR8GU70DVxtKCGqpBuTl7m
 3f7UGWe2rdQcoUqlM1OwkHOxv+NANfMrmwG0+EfDF7+YfhNKoO9sq1oF/o0hmqqBHSL7EjAHIS3
 51AwjiBrgxt0tMvbU3d49/QbE4FVM5hFRB4B4zIJxsgd1+HHJqh37Goya+znfdUvadxztjQK/sY
 pBk/s8W/AU2mAlgPQu4MtBHOUOmvxdJDVhOxDgvqIDJp1ziMYOgTfMVql1rEIZhH7molnLtL3DA
 aqEO+8zThBTlsVn3jxbO43eDEvx5Q6nxgrBL/U29WtPNqn20=
X-Received: by 2002:a05:622a:4d91:b0:50f:b904:454 with SMTP id
 d75a77b69052e-51659fbdb54mr340378061cf.11.1779294032769; 
 Wed, 20 May 2026 09:20:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4d91:b0:50f:b904:454 with SMTP id
 d75a77b69052e-51659fbdb54mr340377291cf.11.1779294032143; 
 Wed, 20 May 2026 09:20:32 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645687d30sm208048031cf.4.2026.05.20.09.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:20:30 -0700 (PDT)
Date: Wed, 20 May 2026 12:20:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 10/15] tests/qtest/migration: Use defer for all tests
Message-ID: <ag3fTRJ5NUlUH-Uf@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:09PM -0300, Fabiano Rosas wrote:
> Change all invocations of migrate_start to use defer. The uri
> parameter will be removed from that function in subsequent patches.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


