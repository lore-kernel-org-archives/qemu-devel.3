Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89083E81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpU7F-0004Ln-T6; Mon, 09 Feb 2026 11:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU6j-0004D4-4N
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU6g-0003Im-Ia
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770654445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5orrh4Qmxyy60hHb2j6djXURothn8m3UdWV+/9ZAXEE=;
 b=hem22pC5iugw7fhCiYFBcY2iwdy5qaI0ef7btRLPqZwmek9iFjQ63Fnmj/MAB6GpE22NpU
 KPB69Ilq9kLDCWaRpWzApn2vUfrBa3STPmHUpBZGDqOC2pDhXCSw5UAH7IFzWJk7XUaweu
 ewmG1TKN/vDk+MyTjowSXFIeH2BED88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-gca1quveOXKYIs1aD3KRKQ-1; Mon, 09 Feb 2026 11:27:22 -0500
X-MC-Unique: gca1quveOXKYIs1aD3KRKQ-1
X-Mimecast-MFC-AGG-ID: gca1quveOXKYIs1aD3KRKQ_1770654441
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50341fddb89so146715661cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770654441; x=1771259241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5orrh4Qmxyy60hHb2j6djXURothn8m3UdWV+/9ZAXEE=;
 b=G33eHFQKkPZVD7hZkOsrApnqLO+HYOI4xzeTiTz8mQJwWU9QxYqabHwsBrb917voUQ
 WF9CzyCVoaohOWobcQagSmXs0f97plOn16mXZ87emS7eEkVtL6JUh/PP6XfMDCHRLyT8
 xCbZNrZ9afurzBoTA8mbjNID103A1MXMVDwfzbIAHE68L+p8X4plCOB3mbyV5575XkIQ
 bEYOJv5wWAELG7XGlL1fJAk/LFf1r/4te+sRHls1rKtKHwgMBb9bqbddLRLNeqNXMjGD
 wDYyPed3U6WNKAcVAcgGQFAXnLd1cPjEssO8x8BciFW0h0GxVC3g5Zcnzd6Vzww4cdGA
 3DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770654441; x=1771259241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5orrh4Qmxyy60hHb2j6djXURothn8m3UdWV+/9ZAXEE=;
 b=Zbu75iYSHEMxaz21XyHPLtbC5Lk5IUVEp4a8JhgI37m6PculTEbTCZ2iv4D1Cdj5/t
 INCj2JjXtwW6wkpNya5r0fwAa6zgyNYD/KAItNGFsmap3evXNKzAnu22G2sVhUTbdF8S
 dhoOCJc+3KSnXI1YrrDykfB0tNZ3jkEgybgCkHO4vYaBuotQd/myseB7W18vRvJUt9nw
 F8y+BvvzrcPRCMK1kfNJy8jH8KF2bTXsOO+exnh/+SgZJBrJgPHjw9vqT4xCB443Jljx
 5WXSUWp7fkYwdzJkYFjrWhFfW00Ov+NvXx2L2vIxL+GW81/gwQLtEwV2XWronW8Eizc+
 hBDA==
X-Gm-Message-State: AOJu0YzqVO4IDmE2r1otbiHFFbnu3udUZDprzVaYUV7tEfUV5TPrWHqo
 KxXytpZdTb78cyPsd+IO7YOpH5hltZw6CdtClO2csnSDiUtgAxK1LdJANUA+KJll0u3oOLO/LH8
 0vnIIP9QYyKDOAw0J7GBxuyaBPoBw82L+1A7F9sdJYw9qfWh+uDRyARA7
X-Gm-Gg: AZuq6aJkW/yxda3dp9uYYwQnj2Moywoi21cnT6wTQoN51MvNKB0+rPvfaVqyMYvnZCT
 K/JCKwFDeo1L0NkxrgY9B527hJN9NV+/C5YqBEkEA/CjoZHYDmIiFumo7vaD9NQDxb7GQbNr1UU
 wCLcNRNEVmKMtbCHKJHkUsDacJ6UCRalegDd76GafqffF0Ly7ysaxqalou3rqW9BvBgiB2FXHgu
 2aOANehvBIRA9KImgINhyFpBc/78+ChkxiXnQsPALlga2+QTDPS10Btbudpy7c236BaTjdYF8WD
 XWptCjBC8JIyPXUFbHUllCYX9GzCaqu9+k5qyBHX6rKEd8on6n1BiK/hMyRuFPIXUzmxdVjYuk1
 YKPM=
X-Received: by 2002:ac8:5f8a:0:b0:501:48e9:69e with SMTP id
 d75a77b69052e-5063999bd18mr138226041cf.68.1770654441151; 
 Mon, 09 Feb 2026 08:27:21 -0800 (PST)
X-Received: by 2002:ac8:5f8a:0:b0:501:48e9:69e with SMTP id
 d75a77b69052e-5063999bd18mr138225761cf.68.1770654440703; 
 Mon, 09 Feb 2026 08:27:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f2ad5sm833876585a.9.2026.02.09.08.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:27:20 -0800 (PST)
Date: Mon, 9 Feb 2026 11:27:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 10/16] Call colo_release_ram_cache() after multifd
 threads terminate
Message-ID: <aYoK5wRK6PdqEEDz@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-10-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-10-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Feb 03, 2026 at 11:15:16AM +0100, Lukas Straub wrote:
> The multifd threads still may access the colo cache, so release it
> only after they terminate.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


