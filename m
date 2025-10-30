Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A9DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZFQ-00084D-IQ; Thu, 30 Oct 2025 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEZFM-00080C-GS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEZF8-00051J-Py
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761856043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xpCHFq0Iouhpr9AElAblbZqCNXMP+GVLs3QqWVijuk=;
 b=IfFednhNB0OScHoKAshSDMjOF+ETeswrMBpqctLiAsHNuvKvV5ns8MP6JqMgBhSby0Mwi1
 74hzzX8OzPkzZJjpmJw5eSx3tARAnzm6tqwWU12JPUhrnsmL2RWAB1Kgn21XPkLc+jUqIm
 Abk3T2V5t7/L2dtt2vaZRdxQkzaNzM4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-zddiqMCGM_KQbt-pGgZgFA-1; Thu, 30 Oct 2025 16:27:21 -0400
X-MC-Unique: zddiqMCGM_KQbt-pGgZgFA-1
X-Mimecast-MFC-AGG-ID: zddiqMCGM_KQbt-pGgZgFA_1761856041
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e89f4a502cso41440091cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 13:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761856041; x=1762460841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xpCHFq0Iouhpr9AElAblbZqCNXMP+GVLs3QqWVijuk=;
 b=rESdMxmaY4600cuiAcG6XWtpqhF7Dw3IQeu4dDaJBvKuU4kumdos8+ykF6Pb6XMLK9
 aTTfEHJJOWyI/xAzFInNljDTG0Cme3sQzhZrlUVY8eJCPp63Y9awIPgsQHipPL3yyhLD
 xYBNV0DVQz76RsaFyC6UI+JIZTgQaciIMKHfwHTqAdi/YERaLeJf6AcDgVleYQlDSvT0
 yKBn+G7TsBElj6cf1qfGK8nY27v8g27ZciMoPo/zxZBnsL2wfBC2CbeHexoTmJgF7qRs
 vvXe3kjUcd7CMcTz2x3zau+vl26m7OKC01Hah9I8Sqy9UvSna+2MH7lvgUGeT3h7PG3V
 SjfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+w3OhWt6q4QxkgecRNjYcyPUUf9PGiqpdvlLu2VDbnNlb8iRTjsnJITNVcOlSbfYf6GnRZAX5tOeK@nongnu.org
X-Gm-Message-State: AOJu0YwBuUxq+oEezn02/nZAR0hvDb6hyb7FC17SnSZDikDWAm3dOEKR
 GAr+Sm0BsNv5wm5QRllxRXMM0HtQVFpdnFGZCSt2og6gDkXpLxDpILTMhH5FIboNw5h8h8vprJP
 Zzo9s6ddQms1p1aB3AAlPGL8Zagk3KFZ9ukumw4lzmeQ2jz6rORIAT3zr
X-Gm-Gg: ASbGnctWPopYAD7bhfbgX1w95vnXV84bgwEtvUNbS8MdUYD1OS7ep+Ndi8b6B7WyZ09
 y+juKC3WE9SunhLkjEAYiEoX/pAZgCaHwBYTTgSi/CA14f+c+xciZtLy1l/rPNWbBm+fJVW+K2t
 ubtKe86osnDAwv1wd/l7+nAs/39NcLCCo/O21xvL6819KPrwbRTyetpDjWZruPm37P9rVXTgYYN
 Z31ZW2gHI9o55VO7Mh94AbYGxwKySAg9Ji5U2pIH4Z8II6ib23HfrJJ9T82HtxyIDKd0BiT3Kiu
 ZJxUBec1QKUwSq54fHet3fYWpaqLTBoZ6cS/TERdgVUNewdihP6KgQYwp4VkD7jbvi0=
X-Received: by 2002:a05:622a:559b:b0:4ec:d893:a0fc with SMTP id
 d75a77b69052e-4ed30d51233mr11655481cf.4.1761856040711; 
 Thu, 30 Oct 2025 13:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFNNEMJAqphL/hME68WtfNbULn0n2Ot2HZlfHlhj5pL05tkrWMmqYQORBsuIJn5IMiREuBLQ==
X-Received: by 2002:a05:622a:559b:b0:4ec:d893:a0fc with SMTP id
 d75a77b69052e-4ed30d51233mr11655201cf.4.1761856040243; 
 Thu, 30 Oct 2025 13:27:20 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed0817602dsm64475741cf.18.2025.10.30.13.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 13:27:19 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:27:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, armenon@redhat.com
Subject: Re: [PATCH v4 0/2] migration: vmsd errp handlers: return bool
Message-ID: <aQPKJSj0nERfKTKS@x1.local>
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028130738.29037-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 04:07:36PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi.
> 
> Finally, I understood, that there is no real benefit in converting
> these new APIs to bool, as it will break plans of converting all
> other handlers to new API.
> 
> So, only unrelated fixes are kept in the series, maintainers may
> pick them in separate if convenient.
> 
> v4:
> 01: add r-b by Stefan
> 02: rework to better patch (and fix one more similar issue)

Stefan, are you ok on patch 2?

If no objections, I can pick this up for 10.2.

Thanks,

-- 
Peter Xu


