Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9522CCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 21:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umIj0-0005HY-M5; Wed, 13 Aug 2025 17:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIiw-0005GW-Dd
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIif-0000nc-PL
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755119349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRb4wJavwjmDTtSO4J6bU+q6gCyy/O7M1H4pbTMS+bw=;
 b=DzxZ/tFhjzNYdIWFEF/QpL2Q4s21MQ/vXRY/aW/1xYN6p1xoIYwtiCacA6JkSsZuUxPNXu
 pGpkrvz9VXlCDB3HmbD7cvQpPT6vR07VFGueFb6gIzcz5OQAZgPWPvj8OWaAM4VSx341l7
 0qr4p34tn4aG7+XI588l2hSJGmKyupI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-qfIR42clMJimPK1nDB9Xwg-1; Wed, 13 Aug 2025 17:09:08 -0400
X-MC-Unique: qfIR42clMJimPK1nDB9Xwg-1
X-Mimecast-MFC-AGG-ID: qfIR42clMJimPK1nDB9Xwg_1755119347
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71d603b2fa1so4471697b3.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 14:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755119347; x=1755724147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRb4wJavwjmDTtSO4J6bU+q6gCyy/O7M1H4pbTMS+bw=;
 b=WHrSQSZziOTJQFi2lnMo+yX+2sGH1ygrbGA4owRBJjAjTzpY3DpoedDHgZbq/kDW+J
 LZhJjvv2vEn96Bgc2aOOh8OpsNnJ7ZZfU3yYfQXwEzQHegaZOS4H//bad5vJqGAroY+8
 OuA7kZ2bUj2S4qwOCliw8+/woCEyF/Yw3GbRQP7gEjcqihzT9ZPpyef75zY8ZQ2WC1KP
 8sUQRmXg/Pom/0Bp4bvflBPwmX3ft8p5Z5MA4glmXeMdUwpjkPENLS+SZMPOdK8i/Dlo
 4Ez06Gk5mSogL2qMvJgd8UBEttgkSvEwSh+mDIYB+PCTsJdeOq67mC9WzHM24d8+bCoF
 Q4uw==
X-Gm-Message-State: AOJu0Yz8U0Ozh2FOISO77Fp9n5T3troJjG7v+oUKQzxpY6kKu2Yq7E6D
 RRPlt1TEsoAIkLkuH18HfV6fuIoa17fXBqJ8nSw8yDSgSXYNRq2WoFU9Qbnd/CzplNbDuEonvdl
 LI0l2ww116uCUS7Wd3ZrAJ3cfPvp1s5Eu+WcHe6tOHIpy7jEcXUnbj0GA
X-Gm-Gg: ASbGnctsaVWTCTd7ny6K0we3Nnx8vbJKWqX9I77RVV2pzxs3xwSt/enPdEwBliJ5AF2
 REcnRU8V1wQvmzlFVGCBtNo5UrgIF1jq9xYSfYTcfkOzyWa/zCUwI8eFkKuAlnMbL973Vu92s08
 JWKI1oft3u9RvaJcCvdBjruPIag95w7P94Wu0N8d9juSg2X+ETeU1HX+87c8smgQJiWtvvD7rXc
 Aj+zzGADwBuTIsXMifM6RsEdHd9x2zl5T33MlZDR/+N2fQJ1eCOGC8rbmSRq+Fu5f/Yle0ajqCa
 zMWQiqtrr1faKs547sMco5bFjYmLDNEU0sb6i51w1kc8FfYZ+wSD905d6WgSK+m8DUptqKA475L
 m7tF3At+nM2oXcMh9INWNPQ==
X-Received: by 2002:a05:690c:6f01:b0:71b:8cc6:6d41 with SMTP id
 00721157ae682-71d634851e3mr5772157b3.17.1755119347593; 
 Wed, 13 Aug 2025 14:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERtzf4prJmujhGeudvdwLh/C0RLrXwIHNd1i4rT+q66uWvFwabUJTHPxwi1lv+X5BCtitXYw==
X-Received: by 2002:a05:690c:6f01:b0:71b:8cc6:6d41 with SMTP id
 00721157ae682-71d634851e3mr5771907b3.17.1755119347302; 
 Wed, 13 Aug 2025 14:09:07 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d6107e85csm1613637b3.83.2025.08.13.14.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 14:09:06 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:09:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 19/24] migration: Store the initial values used for
 s->parameters
Message-ID: <aJz-78rQmEgrjcCR@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 30, 2025 at 04:59:08PM -0300, Fabiano Rosas wrote:
> Each migration parameters has a default value, store them for later
> use in resetting s->parameters. Values overridden via the command line
> with the debugging option -global migration.<param> will be included.
> 
> Make the structure const and change the appropriate signatures to make
> sure its values are not changed by accident. Some functions take two
> MigrationParameters pointers and it's easy to confuse them.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


