Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF3C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd6Rk-0004cm-BK; Thu, 22 Feb 2024 05:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd6Rh-0004bi-5Q
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd6Rf-0005Xh-I9
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708598209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l+1uwvfY5MewMAvwwE/pzbqQSLCl1gixYPq5UjDny8=;
 b=IfIVtnoZJK/WTGKSASjTH2Ru5B0WIC1belQ9lESwIqBuN5Rj1jz9UPKxmJJLBKbWAYud6u
 pt4wCEZhMzisQgtSoiijKGepkTS6ldAXMhQ/7H5k7YgYL6UbrnMBqmWJbTwNsPL4qMdk0E
 qFTapzhoCWOYY3fQypdEPmjJEmAQV78=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-C5ds3agROliNcJf71SEMNg-1; Thu, 22 Feb 2024 05:36:46 -0500
X-MC-Unique: C5ds3agROliNcJf71SEMNg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e4cc2c9dd7so102617b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708598205; x=1709203005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3l+1uwvfY5MewMAvwwE/pzbqQSLCl1gixYPq5UjDny8=;
 b=VtVfBOibTfXwAQuZWYjkwS2vao0chahFEvIhm0nBtoEp46veBWW9gHjEdFLp1zpusk
 aTyg0i+VEcjJOMLNmpK8fY+Si2AWq6zLx/1yn3tgQ1MS6i9fMxyFmw30KbeHOMlOeaLo
 zJcGoye9q7NJRWvHUNOHWWhSf3sltSQksFErBuVasvk4nLHWGwXT8iyVjCukCrOZhSuD
 7rCZugtp4luL+dKtI6sXUSAvblWM+fcQrUVSt/A8JxxgGU93pXZhxgsby/0ERGCyqpMj
 70mEcNgghbj1zsWXNUQxzJxhXKX0lN6b1HApMFH8anQkvewdEdcrnEZqh1o0Fuh+dS49
 4yXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+DUd5ElYy90z/YHDVM+HVMEGkNUew6M8D/6b+t7SVyRZVwNxB7e4A5p/K+OQctZKBY0V6EaO/1mfxnpItD9m4leNwfUE=
X-Gm-Message-State: AOJu0YyVo4SKagiixPqMFfClj2vBImPdfOHhaYJhQJeZKDvZi/RU7T3r
 bq98dja8cKTLXUYsyX9Gd0WEIsn755AI6xgRUYhlXS6ddKbFfpmnpESaTL01RHvUiap/r1RWSLI
 DgM/kfUuYozHETY3ZpRIFXAV9cIpw4+xk/QOd3fjueIfB+A4S5+68
X-Received: by 2002:a05:6a20:7484:b0:1a0:db7c:df1 with SMTP id
 p4-20020a056a20748400b001a0db7c0df1mr93032pzd.5.1708598205522; 
 Thu, 22 Feb 2024 02:36:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvI8gGf3GgBADLLnR1PaChJtErsqEyeb2Kk3pEuDS5azCUKfIEAtu/NuFcIv1QD0uNT7VTBw==
X-Received: by 2002:a05:6a20:7484:b0:1a0:db7c:df1 with SMTP id
 p4-20020a056a20748400b001a0db7c0df1mr93021pzd.5.1708598205262; 
 Thu, 22 Feb 2024 02:36:45 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c24-20020a170902d91800b001db68d6c4d7sm9531285plz.287.2024.02.22.02.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 02:36:44 -0800 (PST)
Date: Thu, 22 Feb 2024 18:36:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Subject: Re: [PATCH v2 1/7] migration/multifd: Add new migration option
 zero-page-detection.
Message-ID: <Zdcjso7kUcZ5pL2o@x1n>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216224002.1476890-2-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 10:39:56PM +0000, Hao Xiang wrote:
> @@ -1123,6 +1123,10 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>      QEMUFile *file = pss->pss_channel;
>      int len = 0;
>  
> +    if (migrate_zero_page_detection() != ZERO_PAGE_DETECTION_LEGACY) {
> +        return 0;
> +    }

Nitpick: use "== NONE" here seems clearer.

> +
>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          return 0;
>      }

-- 
Peter Xu


