Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229BDC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmSs3-0003DA-NC; Wed, 22 Jul 2026 05:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wmSs2-0003Cg-2X
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 05:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wmSs0-00023i-As
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 05:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784711042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrgpIi0HNbumg/z9ek8Waym9B+6vmB3/xyREI80w94U=;
 b=Bu6loNR/x3dff3l1Zr8A/NjA3U2f3BEgqpkX5xshJ0A/ciCY8dnZI9/i80qthSkeFNWV6v
 bBu8PDUdXKtedpbqzYcztFLkQAyILdfVUGVYRxnYCFAfnNJgVzdguExqtXrsrqZXMbfkOL
 w0PeX+GQbGno1lswESwdkWRtFwPXK5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-YGyQsdEQMMSlWQBSljFEdg-1; Wed, 22 Jul 2026 05:04:00 -0400
X-MC-Unique: YGyQsdEQMMSlWQBSljFEdg-1
X-Mimecast-MFC-AGG-ID: YGyQsdEQMMSlWQBSljFEdg_1784711039
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954a93c565so33340785e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784711039; x=1785315839; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JrgpIi0HNbumg/z9ek8Waym9B+6vmB3/xyREI80w94U=;
 b=WyfdLy7SEXZCLTnbASIPMMRAPFaMMgdE05dYkFZ5qjpiKMwQDOQqmneOs4CuLz36fi
 3qTaOpciXNldyEEkT1DzHS6gYq12tCMYLs1b/sTLFqN6XrfGLqSxlnGcbyc0To9aBrdu
 d6cyEX7bZbuj8mm1CunQksLvmbauE9qxYN6aLMBWJEg+qo071vK+l/P+af+eKoxsFzFb
 cDPQHz27znr07tf8SJC091OHoUIGmLLLbzLNwxQSGsN2dnDOxdc6uQAw6m7yWbz6KQl6
 mhRgnVSoaJ1WZwI5dryOS9uJmwVfGLQKDZNWCN+EaH7oF7aFiCTYRF7rFb5LRDYOos0p
 FMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784711039; x=1785315839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JrgpIi0HNbumg/z9ek8Waym9B+6vmB3/xyREI80w94U=;
 b=q/SjzAbF8DrjHLZYS988gDNCdszla7j+xw2yeWp0omS7zUrdbusW7m9RL8Z+G+Lq5c
 PJSlkp5UvlD9KoldvPfEtki6jxb8cazBVq58YB8sUrUDlVg4GDnXBVJA/OmI4fs9wQTu
 vmgQTt0MSigVy3FemPDCaQbZlIjtKJfosYUBeELdCGmVzxWVkydvcUNut2qssHLjWXBP
 GfFzIqItlJs38na42oAd2OZzPEmwW+55uhPuCxqyx/55WB7Scpv9xue0+BN15MyqQIHo
 ytu8bE/4YvMvqoym6fpHjjYvML6ta1rZVBcPbhRRdzz4qbyJjIVgl+imHkV+L9m1A5sW
 tK8A==
X-Gm-Message-State: AOJu0YzwQiQgMUNGHFg9pheqhXg37HHTPnx8vii8upWnE9ZBQAPjL640
 RR0To23/tgcH/iGasJp+MrXjsGf9gvSRUKtHmHsVmVvJSv8yy5wNRhmJSgEzj2j8hlC8GIu2p1q
 kOAbDmr0lp9M0GWWxKc12Hw0NQXbM9YGEZPY8q/1VbNyWRWYx1OQqN8bc
X-Gm-Gg: AR+sD13YYkPpEKttSPuZD1xYxjKAOenlV4ZoqHWBeN9B+Uap5QqdXZVAvLLR0ujoR3y
 u+YI793lV7454+KW3e3L7yr9I28QkMhdEKQTMBqNxJit6N7oFW+Wb/A0w0jQle3ZC/fzVyhxRNc
 6wL81sO5f9xA6b8kNakH2cjHlNtmjHNZQFj6LjKHuSzlromsJMovUhgGtB4H66A0MLVcWWyezvp
 Jm3WToXxqyRWIFDb4oRNyYAAbOZpnY8RgoQx+tHZ8v7pLeOiqxCzB0bwqBFTGlGGQbzN0qBTpyK
 r6fbuKM5BbLLbF0Jp0qt0le7IdYd6KEU2AH7HUUYRDJ6asnoqod4psQXQS5J9KPy/6DvJXM/wk7
 0ZZs1ef0402yLw5UgY37dk61vImMr4QGq1ARO
X-Received: by 2002:a05:600c:4746:b0:495:4d07:4fcb with SMTP id
 5b1f17b1804b1-4954d0784c6mr227222125e9.36.1784711039263; 
 Wed, 22 Jul 2026 02:03:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4746:b0:495:4d07:4fcb with SMTP id
 5b1f17b1804b1-4954d0784c6mr227221645e9.36.1784711038762; 
 Wed, 22 Jul 2026 02:03:58 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd77a9sm4117179f8f.14.2026.07.22.02.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 02:03:58 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:03:56 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mcascell@redhat.com
Subject: Re: [PATCH v4 0/6] hw/uefi: security fixes
Message-ID: <amCHXsudpi4S7LeR@leonardi-redhat>
References: <20260720143244.821889-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720143244.821889-1-kraxel@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=leonardi@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 04:32:36PM +0200, Gerd Hoffmann wrote:
>v4:
> - add fix for CVE-2026-16288
> - fix format string (Luigi).
>v3:
> - just drop debug function instead of trying to fix it.
> - add three more CVE fixes.
>
>Gerd Hoffmann (6):
>  hw/uefi: add sanity check
>  hw/uefi: remove debug function
>  hw/uefi: check lower limit for signature list size
>  hw/uefi: account variable policy entries against storage size
>  hw/uefi: add post_load checks
>  hw/uefi: make SetupMode read-only
>
> hw/uefi/var-service-auth.c    |  7 ++++
> hw/uefi/var-service-core.c    | 14 +++++++-
> hw/uefi/var-service-json.c    |  5 +++
> hw/uefi/var-service-policy.c  | 68 ++++++++++++++++-------------------
> hw/uefi/var-service-siglist.c |  3 ++
> hw/uefi/var-service-vars.c    | 19 ++++++++++
> 6 files changed, 78 insertions(+), 38 deletions(-)
>
>-- 
>2.55.0
>
>

Acked-by: Luigi Leonardi <leonardi@redhat.com>


