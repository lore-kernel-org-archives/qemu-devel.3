Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A7C5AD4D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUpR-0004mU-CI; Fri, 20 Feb 2026 13:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUpO-0004kr-84
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUpK-0007yN-9e
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771610525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUOY2aZIHBUWkBPwlLed4s2ZeLYN+IYAqrt569tz3Wk=;
 b=HtCa2n8VZDNYwSQta8ewkilgQvSaYS8wQVXn1UyRT3n5pjvE3ZcczVUakXw4WXHZSeSZW2
 wW1hEv8qP3G970y4GVMogBGMHmmRW7IbWKLi0OV6rNLBlCAp+ng8XaHse1NYfG5Bbt0Aph
 +CJJ6SFjeGmd2S7XaBJ1KC4xEzWMc9w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-MW5-caojPsqbIENqi1BzRQ-1; Fri, 20 Feb 2026 13:02:04 -0500
X-MC-Unique: MW5-caojPsqbIENqi1BzRQ-1
X-Mimecast-MFC-AGG-ID: MW5-caojPsqbIENqi1BzRQ_1771610523
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso16410775e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771610523; x=1772215323; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bUOY2aZIHBUWkBPwlLed4s2ZeLYN+IYAqrt569tz3Wk=;
 b=OvLSVmKpGP5KaKcALcSOvGiZW+8zlM2BUdsWcVBfjnnzZyFmwb0KxTU8KcWw7ZcPXe
 MZ90B2BIujxKN2IHp6jTmqUpdd1eXvbIx5yyHiYWC1QL5dxK5t0Eh9dzTEJomnslUL4f
 F7HhOKIve86O0Q6/rgM6jiQnLRx/sOJkcT5sO9XtgR3imPX27DLnyPyPLT1HnG+4ISeR
 hpeR588nqvsWbJGypG9vYFFeGTW6kbm1z5/9h8GzbD4GWs38oX5bSAkLGvtw7bWOocER
 em5ynlSPMAhFaERcg1R19vxEtWTi/A5p4SHyXr73LoXCLgwhEmIPzC5YHYMJpq5U/5ci
 nKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771610523; x=1772215323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUOY2aZIHBUWkBPwlLed4s2ZeLYN+IYAqrt569tz3Wk=;
 b=GxtgjwCkT2qyVsjCTCChVz3MjIqdtsQ0CbEjy7xgHtVJGa626Njbs8bPh5T0SkH05W
 aHj6Qi9voTlLw0JI0PRmjwAzDAp51yVJq9PY39+WSMMwW8daD39ozSL0SCgeHuYTbiku
 TVqSPPEVLhOavmhgNIaMHvQPasbnXXRpKnOoeyKjFUbw1VkC3xSM3mGZnNny/ingzr43
 9Xg8yU0fv2i2I9leCgOUxLs8Iq2yx9wR1YwrqXT81F/0c9nacOZEvlQFH5X3+ymCg4Xi
 kq0FUiTtglMNg/U1LaUe1LThDBMTDwhrx6zov3qf83+hq+pfE8ghFp1w3CwpwC8LWgpD
 Ofqg==
X-Gm-Message-State: AOJu0YwDpoob08C2wOjK+wkHdRvy3Iz+VgfeVCZZ9nLxtQg0GijdnllF
 MT8U+x+BDHOgMrJb7+1ygyknQObgJ+aWoJU52lAgOX1OjnPcW0CyYhYNRe5ynUQ45KvGNQZucfs
 8bGdZ+c3/2mG0FnYArXddFtMH3B+d6HNuXcf/3YUdNggFVLwPyiTW6dIN
X-Gm-Gg: AZuq6aJJ4K9Kh5Az3s++rMink107i5WceCgV1UGbw00fhncESMkmQ9D6Gf4zid6xefo
 2qczc3aB+01/AC81Z0l5ObZv75tYXBlckQT3+xriFXX7K6HVWlBuBNVbmMuevb9oCxFityIOnHU
 qZh4Bw2uQK1387tCK2WE76AcUgHXCGpOEBcGpEhZagtD1M3DHcUfRb/AHjH9/yBGhoKr4inO/Qr
 GW9gCUoDj2wGe/EzXNLimkLkMmGCT1y5V9WzlU7f/BcMZq6i3EDCWcz7AAjw0fgAOQicvhKkIcv
 t+qBDy8a4J5CTJQOmS9WjzCc6jmyDltyQz6W7fZWbvhHU4m6CPQIuveG6xAF+ivzWo7fWcnswSV
 G4QgJwqRNLAsGE2q2rTM2O9TVinvzT3rjTPHl43SxPQk4VQ==
X-Received: by 2002:a05:600c:c8a:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-483a95fc0e4mr6818255e9.11.1771610522624; 
 Fri, 20 Feb 2026 10:02:02 -0800 (PST)
X-Received: by 2002:a05:600c:c8a:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-483a95fc0e4mr6817575e9.11.1771610522036; 
 Fri, 20 Feb 2026 10:02:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c51ddsm87534615e9.8.2026.02.20.10.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:02:01 -0800 (PST)
Date: Fri, 20 Feb 2026 13:01:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 10/13] scripts/ghes_inject: add support for fuzzy
 logic testing
Message-ID: <20260220130138-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <9df9ac7f31295c0d7f9866e8ee5d55a925985d5f.1769175070.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df9ac7f31295c0d7f9866e8ee5d55a925985d5f.1769175070.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 23, 2026 at 02:35:24PM +0100, Mauro Carvalho Chehab wrote:
> diff --git a/scripts/fuzzy_error.py b/scripts/fuzzy_error.py
> new file mode 100644
> index 000000000000..9f80abb72319
> --- /dev/null
> +++ b/scripts/fuzzy_error.py
> @@ -0,0 +1,206 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0114,R0903,R0912
> +# SPDX-License-Identifier: GPL-2.0

2.0-or-later


