Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4728DFC034E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw4f-0001Go-Ct; Thu, 23 Apr 2026 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFw4Z-0001GD-Mk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFw4X-0007bX-NS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776958472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1vi2s4ZLMrkpkIWuhE+Y2IAXXK453YyJfXd5Ybh++pA=;
 b=SWu0ExIGkwnocNzDeTp+OeETycFkIIJKBuWK5ChBo6EKerGzxIiqOFrBjBtJFcV5EgpQRD
 8jeT469TUE/0NBy0aeMarEs/TtB+ULKD/3LfGgTlnuUTt3T+GpRYQD15kjVeBN4wSe1BQe
 9/Jd+X4XhvjdwtaanTzpxIT2+gIMUUA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-sKn8hflmMiKFbL23xunVuw-1; Thu, 23 Apr 2026 11:34:24 -0400
X-MC-Unique: sKn8hflmMiKFbL23xunVuw-1
X-Mimecast-MFC-AGG-ID: sKn8hflmMiKFbL23xunVuw_1776958464
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f67ce97a7so4525673e0c.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776958464; x=1777563264; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1vi2s4ZLMrkpkIWuhE+Y2IAXXK453YyJfXd5Ybh++pA=;
 b=DIQiYYjjUZP5L5yVZBgCmYtdxCvUUwo9xsZ8jobhf2QTOnnnDtGUzwYQkGLjJXvLXx
 CuAUtISW2SfuZm8e4Rnk7RT7TG5C24yp25duQCk8pSYGdLwC0ojVhLCF9EUv7UvrSllm
 Lhh2S0FuQzHWiKE5yZMViGKVx7KI6BJbHCmaeiDAasxAkIuavVPvSFehQ6xju/+9jss9
 s/dArPkEfB4ZpsbN707+JXQTKeunnwagCciebiwv9bi5jfEF1qBYo6e+uw0BIgk4UaHi
 MWJ+xw5uT4mX8WOQlllWCwK8vRYQT392gdRU4EDBU891L6iVQUS7FqukQWbH6Aq/yUih
 SETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776958464; x=1777563264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vi2s4ZLMrkpkIWuhE+Y2IAXXK453YyJfXd5Ybh++pA=;
 b=PfP6dQYjqvYFXRQ4C8vVvVK9SXHZfkv1bU2BGCkeyAGDILWSiDbh1rkhdJiIoj9gUF
 3b7+OcMInKOe8rrQ+lKdmH3+EesxWwRtYJTkmVkE/Z8Od2wSA9LJlgGjWY9mzUfVG911
 q6csspinzDMQVUJVFGU14Qz2Aj+T9OduVDU/CzMHWYYkyo6F5VWbN6/T4JvjycmAzJkf
 UTFssZqVQXAWQ5YBM/kaHmXCruCzVTuEQLbsTATLjQEu3yifz086YGjwTiM2nSiGeMWz
 NEtiZeFfbvi2zl0wcRzu1SvJCsHt6O0pvanvCW9u8OhR2Bvw7LXivJccJ2PjZOxAVWyg
 8lGg==
X-Gm-Message-State: AOJu0Yw5Fk1jnyVwQoRBN4J6fve4bAcWS2mxZJN2dDpKpMzonFC2fXpO
 f7/9/r2Ns+r1f37pMBEbiQeK9VAn5QKpfiu+QEj6LQxUMRL+d1Syc4rgk80vwU9/vyYEMiHNGCJ
 aBqAhvstiv8dCg4tw9uSJwsUvLXbsQs9ePZwX5tQeHzOjEUGH3Mti0DrI
X-Gm-Gg: AeBDieu1pwQaAhnNFNQac4m7wqoiHZWCsGsGOMTf7skxjQU992u36PEeCTWq2Gfl7aJ
 RiYkljVkthQQSxF+s3BNu4ZiPA5XVaqle3R6uuBBZ7LUSfY4vl2NTGsGuMAHEzDT4cjiCy4fQA4
 CY5je0SXS3pXX9c1yWIc9W+BGejXhJQcZ6vJ3QJA7jdy2meSLQ3yyuE5ScOlJpAt73PJmy3IK4Z
 i1piMO0MfxWvOFFsOJF4Nsp+Nopyk7IuhEJs4gJNB/jQTWf3rJOGXT9t59k76hnvqeNvNlZV59T
 0smTHa9BZnJQvKn8wHTSo9lExklkVYGlw8wCIpGbQmlF2UIdK45hAR9G+MY3UsqancpVx/ZwYy7
 aG0kN7CEoQuz3+zVUAUrjxhJaCYHeUyrg/YgNS2tQ+6wj/hdHly1bFMsSpw==
X-Received: by 2002:a05:6122:4fa2:b0:56e:ded3:98eb with SMTP id
 71dfb90a1353d-56fa585d299mr14144128e0c.6.1776958464078; 
 Thu, 23 Apr 2026 08:34:24 -0700 (PDT)
X-Received: by 2002:a05:6122:4fa2:b0:56e:ded3:98eb with SMTP id
 71dfb90a1353d-56fa585d299mr14144076e0c.6.1776958463553; 
 Thu, 23 Apr 2026 08:34:23 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa92078adsm11328165e0c.7.2026.04.23.08.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:34:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:34:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 1/2] migration/vmstate: Add VMState support for
 GByteArray
Message-ID: <aeo7_YcGk51EeCzJ@x1.local>
References: <20260422082214.10390-1-armenon@redhat.com>
 <20260422082214.10390-2-armenon@redhat.com>
 <aekocd-UQ44uNCWI@x1.local> <aenKIbkSOjjGkg62@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aenKIbkSOjjGkg62@fedora>
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

On Thu, Apr 23, 2026 at 12:58:33PM +0530, Arun Menon wrote:
> Regarding the assert(), Would you like me to remove the
> explicit assert() in put_g_byte_array() as well? Since it is immediately
> followed by a dereference:
> 
> qemu_put_be32(f, byte_array->len);

Your new version looks good, thanks.

-- 
Peter Xu


