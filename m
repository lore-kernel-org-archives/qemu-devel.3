Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF98DD609C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYTZ-0001xH-AD; Tue, 16 Dec 2025 12:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYSi-0001LX-KA
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 12:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYSg-0002tO-7R
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 12:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765904624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7qZ7UxYiGdBlyOgz+7qqmEtLVJfxOUf/KEg4jRxAY0=;
 b=AZ9SgpMvPznWnDMtgFsl7haler/S/OlLmWFPNxdfaEVFseWoVaQDRWp5CJ0nEVsavxuU55
 QTqp5esEVXn/5uN2Zlx3fj2QCtqqH/vcggA99hYqCbllxzTjlhFaaOi6SBKpVFRNxTWWmO
 IyN6jaPMDxLro7is23PxzGTdW4dEsSw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-AY0-1EdpNsCDJ9q4EyKszw-1; Tue, 16 Dec 2025 12:03:42 -0500
X-MC-Unique: AY0-1EdpNsCDJ9q4EyKszw-1
X-Mimecast-MFC-AGG-ID: AY0-1EdpNsCDJ9q4EyKszw_1765904622
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4f1dea13d34so79563721cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 09:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765904622; x=1766509422; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E7qZ7UxYiGdBlyOgz+7qqmEtLVJfxOUf/KEg4jRxAY0=;
 b=nXwiAQ1RW31ZcgkThGDbu51fwdrmXA3XUGtxARTJk3u7SeirRxe/EgyEeCcSetho4f
 OZXwM5j3I3W4T0ZZ2Do6Acon8Q/dICmCEBX9RsK0oNqLR/PwE+BIiOLgDXMNV5l4vXrX
 3dWenCA8bnrmxdTYQq8fXyZVWYNlVybSwpf5J5RJMSjWO+HmZ/8wFuuiPASaWzJ44K+A
 4Lc0JwvxmWFAZcGPJG4JmyEHm/ik6as0Xwc8X7KrGp+J4JiEU76YHiLhmJXjlczlKcvx
 wX6bBlvpEqHKY/INy4DCSXR5iBXi6/iGi6GSjlsddKD1ehVvCY6ufE1dAC/KdUEDhETh
 g9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765904622; x=1766509422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7qZ7UxYiGdBlyOgz+7qqmEtLVJfxOUf/KEg4jRxAY0=;
 b=oOUPDXvGeDvIQyAd4Opb/IC97Ol0l6QKG5+dHma3jizss9xbXwMK0bMZoigAQNtB8l
 D7cBNhGkSO9fY2ca8U4TZ/7kzH8UuvULowWd8Z+yWwIedHuSzbnCCV8lTIPjIF9+GIfG
 kywEo80e+ooH7YrGB5eFunnq2ZgwaLxC82SOGXAkTojTgEQt1wcRKy07fP8zABYe0NUq
 7uSn94jMpD/Iyr7cV/f6TEo5lPd22RoxJmTRfHDelOoYtCS7L4+vJFvymIt29jzNUWvU
 4pOwr92sP8u3XiLX/WC6udPT0ykUAVxIzT+P8vEqxTV7r4ytFBVsJ42ySLNKCN+wt+xa
 agwA==
X-Gm-Message-State: AOJu0YwcCHynq7Hqe+vTBnh0/h/INvfBKItKtzifayQJIrNa+wCtY3m9
 6+PJ0qsXgmg51W4LtdXfBQEC7rm0Efw/8/xfzTgd1JjvWkmETdAABEv+UP59qyq2M/r+UbFjoXr
 mnVgMrN4uYAvWRKg9Ft8bpgv63guyNZXBpA1Z0SqKnMwEEtYLJGE0tmW/
X-Gm-Gg: AY/fxX7OPhnV0FlA/44wo958xcCVBiVP4NQ92JsRh6j4OJEDIzBVYrGO0cRB2uilqRu
 2WzfTi5Y/r6Jzb/QaSRZorcwHDLmdLSW2/2QDvwxsK+SGixvgUpR6tGQGoTZ2nHixjiOihHPIyX
 9JQRyuIgZ4vzqYR8PxDOi0O/lI+ygskBrufql4lfh5btrI4rbIbcJqcipyYAGvELAa1AXkfxh2c
 esTJAUbjGTT870Yi6lLgmAjQlBkthpJwWgGq3eFfPKJ9HiVsUeQyic16T7oBGEp6IVODdFyJbqa
 SLYg/Qv8MFl/MG0xzq+fv6IoRoPKYLdTNSFfLRVcDjnkww95EGWoQnEnj0deSvgYIGzl+B2RbKE
 kLBM=
X-Received: by 2002:ac8:7d41:0:b0:4e8:8934:6df1 with SMTP id
 d75a77b69052e-4f1d066f011mr214829501cf.79.1765904621981; 
 Tue, 16 Dec 2025 09:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6qAJgCBHJDO+Gz/4nTuSx0rOrykJRm+Bk7VnyA4cf5IueyXQOioPPP57rB+J29QKsE6DB2Q==
X-Received: by 2002:ac8:7d41:0:b0:4e8:8934:6df1 with SMTP id
 d75a77b69052e-4f1d066f011mr214828501cf.79.1765904621085; 
 Tue, 16 Dec 2025 09:03:41 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f345b16d72sm21509861cf.1.2025.12.16.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:03:40 -0800 (PST)
Date: Tue, 16 Dec 2025 12:03:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 04/51] tests/qtest/migration: Add a NULL parameters
 test for TLS
Message-ID: <aUGQ6hVOsK1szBc0@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 15, 2025 at 06:59:50PM -0300, Fabiano Rosas wrote:
> Make sure the TLS options handling is working correctly with a NULL
> parameter. This is relevant due to the usage of StrOrNull for the
> tls-creds, tls-authz and tls-hostname options.
> 
> With this, all manners of passing TLS options are somehow covered by
> the tests, we should not need to do manual testing when touching TLS
> options code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


