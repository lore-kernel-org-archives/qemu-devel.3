Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836CCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvrh-0002q9-HS; Fri, 15 Aug 2025 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umvrf-0002pS-Uk
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umvrc-0006sM-W5
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755269823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMS+/r6G1OK+DIb+PXwS+Y5EaHlj3WM58MrsjZEplNc=;
 b=dfPxuMHN2Pz54F2R38Ve/66nqCdTT5kPzehUobJGpAvoTskNl0lawB7UbpQPaFnvg/HZXo
 76Cm5t9VhWM5cUhEtPClcDMcErjxLy8oy3SO24glWDPH439KQH54JLcbD+TxCPcYJldCiX
 5r9g4Z17rcsjqEvUSQ2i2b0pVD6ZyqQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-bfBLwt4YMpykNaGuBVS6Cw-1; Fri, 15 Aug 2025 10:57:01 -0400
X-MC-Unique: bfBLwt4YMpykNaGuBVS6Cw-1
X-Mimecast-MFC-AGG-ID: bfBLwt4YMpykNaGuBVS6Cw_1755269821
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-71e6eb64938so6708207b3.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755269821; x=1755874621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMS+/r6G1OK+DIb+PXwS+Y5EaHlj3WM58MrsjZEplNc=;
 b=sSm5TlGo/ijFGEhPBkXjzP1lk+o36/thFT1lP21YdRa3hB65SkfsK0mqFs+rwsZkTj
 tlhGGP0v8HJfWXly95nSkllR+wxvmJ7ve6qjPldRVlUI3Ph9FB/LnM6Fi9x4VcBd5fJb
 L6PpUb4KbsmKF2xSAOgB3YrJm3mH3bIHmqgvXAKriIV1hhG6FWNwLMixVvjuX+XdJrHi
 grlnmYGKYMMPr3E2axkht3XmITseKpzEyIhiWxkaGzKsK5p6CVs3YhzOd8m+lCeg2bsL
 1llMJIEKhc9gweQ4mBYFjHzxwy8HSRkIeYgLHT6OtBG0PgV43NKI8BhV9YpGlf3Hx2Bu
 E8Gw==
X-Gm-Message-State: AOJu0YxgfmC/QyzRDYNjQ3YiDOYazjRJF4exewfKMbD/3Sc4kckMYSFr
 2Jwyu5vOqgJDo+pccc0Ge80E58NmixMLil/8sF+XIEPQPB85ibZ6FZg9JmYs7y4Zn45xFtJuwRJ
 nXM7IAe4s1/hRWGZtqfqLMZlI5v4ySnzUo0SAxDAKwyX4QI8hosCC+Aaf
X-Gm-Gg: ASbGncsDvV8iBBY9m1+NSsZmVQJ5T++/E9a4m9U28SDNVJTFtXyJDuqZRPXkAHf6drp
 4LMY1gAYIxekAuwXxgnEIVyCjt5RnwNeenK6gYXZRBNkbUjJtvJ+HzkF46+JNdFOQmF5xe+cSB1
 BtQ9ZqgP0bNQ7WJ8kZoqtU2KchXldFMNcNaW5zVuIBug8d6hVCy5DZ/zeK35RkBaA0WlQsmsbtC
 nKhFOdhdHroftFWlWKdyI9hknjXGPAL61KwKpyVwIZri0FU+v5zpABVOh8T8XI5FIw8Zv0elIXH
 Uw93AnEeKpnmHJdKzvYWoZRbVBkWLMLE
X-Received: by 2002:a05:690c:3501:b0:71c:149b:8686 with SMTP id
 00721157ae682-71e6db0bab8mr26998787b3.15.1755269820759; 
 Fri, 15 Aug 2025 07:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLOMpI+fUpegfy4jb2TNf2kvs8tNKiGB2F04m0oTK1QGH7Zb8jbw350pMhB0iZUZIqzQAeEg==
X-Received: by 2002:a05:690c:3501:b0:71c:149b:8686 with SMTP id
 00721157ae682-71e6db0bab8mr26998357b3.15.1755269820170; 
 Fri, 15 Aug 2025 07:57:00 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71e74ab12bbsm1231507b3.61.2025.08.15.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 07:56:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:56:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v10 20/27] migration: Return -1 on memory allocation
 failure in ram.c
Message-ID: <aJ9KrXdvEgeLWVNS@x1.local>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
 <20250808-propagate_tpm_error-v10-20-3e81a1d419b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808-propagate_tpm_error-v10-20-3e81a1d419b2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 08, 2025 at 12:43:46PM +0530, Arun Menon wrote:
> The function colo_init_ram_cache() currently returns -errno if
> qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
> calls qemu_anon_ram_free() could potentially alter the value of errno.
> This would cause the function to return a value that does not accurately
> represent the original allocation failure.
> 
> This commit changes the return value to -1 on memory allocation failure.
> This ensures that the return value is consistent and is not affected by
> any errno changes that may occur during the free process.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


