Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D67CEED606
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojyM-0004yr-94; Thu, 12 Sep 2024 09:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sojyI-0004xK-W0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sojyH-0007tb-Kv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726148092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5rcG9lzD4F05sYwu5eA1U+Vp3lpTYiZKcFNxAMkStY=;
 b=FVZ1Y+S/A4fls+tA2eIwuJsNWj3CiUhBODxU40Rxd324wB/3sg15fHb4G37054NKTMnycN
 PXddfONwI6dnNo8d6rmGSt47ZL/Xpy+wo3gWxM1DaKWd/xxjNDcxIrNnJiCnUrv7JZd9CP
 hGh5hk3LEENxPPFkJunfYJWL6b4d2Jk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-PawLmpc4MCSkMAi-elmbMw-1; Thu, 12 Sep 2024 09:34:50 -0400
X-MC-Unique: PawLmpc4MCSkMAi-elmbMw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4585eba9b52so24962621cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 06:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726148090; x=1726752890;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5rcG9lzD4F05sYwu5eA1U+Vp3lpTYiZKcFNxAMkStY=;
 b=Y4sHJqCJh5IqY1wqCECwU1a7yOLvN5C9JIpu1/JRvtfCsrqWCP0yjHUQB9ShhKC32O
 ZJq51TEFd/PFeB5Lguf7ycKCFJUOq6zpHlueLZdLmsbVL5aUmZnRE18/5ZzGBG3ql/Yl
 E/1y49kwmIfZMFmNwamwmDBeh3PXR+ceEFBP34Zkpn4eyGZyE64QUALmqy7+kz45zGit
 VX6FfMh+w+yXOkgTdEDq1AM5U1zypRXHDm25Pp/XzJpnAmOsgG1XDAqQSxN10fCbUKOv
 MvyxRaXY6JB0WaZvSZEyOegaDNDGHpKkDTSZjQUOLWEGRCbXRm9TFnxKFkY1qC8XkQn4
 pkMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkTKxL5R0qEn+CR18LszsxoH9DMD9BI3KSVF5wK2/YWlLDvaDzJ6hZb/ZKf8Y5ymJqQj2HOcWCaN6z@nongnu.org
X-Gm-Message-State: AOJu0YzstdbbEskvk+g1GcLaaRRpHJW5CebVDkVAzE21dFIT48AupIsP
 cCerjzIJ7m8R6iUCPyjlF2BJ1QLAPaD43I5TZQJM3ONRdw6D7KuepMtpx142IR3PWx1a+Ov8WMs
 ui4kddVAJVGO6XiirJZpkSfUqrXzpFZm0YkiN9HXrF840Veah1c4G
X-Received: by 2002:ac8:5d94:0:b0:458:156f:965c with SMTP id
 d75a77b69052e-458602de102mr45427391cf.22.1726148089981; 
 Thu, 12 Sep 2024 06:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLmm/DxJ65yRHOiD4VWdc/MylUpsQX+KMLJTCpwrDneBOgcnrBMqj+57SrU2QpuXZYBzdjWw==
X-Received: by 2002:ac8:5d94:0:b0:458:156f:965c with SMTP id
 d75a77b69052e-458602de102mr45427011cf.22.1726148089600; 
 Thu, 12 Sep 2024 06:34:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e9b207sm53312581cf.49.2024.09.12.06.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 06:34:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:34:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
Message-ID: <ZuLt9fDgA9C_nNZ6@x1n>
References: <20240912070404.2993976-1-fea.wang@sifive.com>
 <20240912070404.2993976-2-fea.wang@sifive.com>
 <444dbb46-bee5-4983-aa90-4d88f005c5eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444dbb46-bee5-4983-aa90-4d88f005c5eb@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 12, 2024 at 09:13:40AM +0200, Philippe Mathieu-Daudé wrote:
> On 12/9/24 09:04, Fea.Wang wrote:
> > The follow-up transactions may use the data in the attribution, so keep
> > the value of attribution from the function parameter just as
> > flatview_translate() above.
> > 
> 
> Doh, long standing bug...
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f26404fbee ("Make address_space_map() take a MemTxAttrs argument")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks, queued with these attached.

-- 
Peter Xu


