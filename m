Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD7CF58C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmcY-00035M-D0; Wed, 19 Nov 2025 13:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmcW-00034K-Vu
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:09:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmcU-0002tb-JA
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DCGaHtOp5reLxorwEtMOeyn9iP1bnDso8ubGDPMiBA=;
 b=gJ44lrST8kZ6Pb/8sVf1QZIDJnoLF5LovT3lEkXAB5GENhWXS1E4pyqwVa0rLy+J/UDuYo
 4vOJSAXbT4mZtei9/ykeuRa15Jq9zluLjjrK5u/AXAXOVzUjdMskHQgwn4IsDtGltyaQj1
 cO08hCy58gB7tH+QZOwI5+IWrymFy+s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JWEIh1y2OoiYewODW_ikuw-1; Wed, 19 Nov 2025 13:09:28 -0500
X-MC-Unique: JWEIh1y2OoiYewODW_ikuw-1
X-Mimecast-MFC-AGG-ID: JWEIh1y2OoiYewODW_ikuw_1763575768
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88236279bd9so381516d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763575768; x=1764180568; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0DCGaHtOp5reLxorwEtMOeyn9iP1bnDso8ubGDPMiBA=;
 b=oLkMsQJTvKSpOK0RWXn0tISpMAX+J3BYeyP6eftWLaQJoiwdFpqvcxOEtkhlz5Re+i
 UTZsh5SmpcYGFqxibzcBcdMTkFEorqXD0mXWAlfcZD6F7roTl82vdtmQzalQVvbblx8W
 ueG6wVu4qpeBNlTAAmLJbxa6zs59kukeHIAiK6mrDjTYa0AivOkpD/qrV4PR1TuNqdfP
 5vb11yXefVhR4ktkKeHSO9s0YVY8EnGYt/hCcUfTe9VqL36mKxVOfBDFqmI+QeMun75V
 e1AZYYyRAQk35F9ymsjRXXe+GO67XMCRCBrgg8vuD3zLR7FHEe8LUyfkIYWe+0i67A97
 JdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763575768; x=1764180568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DCGaHtOp5reLxorwEtMOeyn9iP1bnDso8ubGDPMiBA=;
 b=DyetusaU0r0kwqTWnzDyrY/PwlSFhq8nonKx4C9PS5gRnEFrk96aeh1GC/dOukcAcc
 oNk4dF/pGivKKCZwKYEby5TIKMS2vLxY6bzT4JSn1WBOSffVK4WevIKSfIV2kuPy/ZBr
 bMqd+rJuxkJS+AAGtHTWSlkN4uIvfb4U8RDurT3edeU766YpFr1eRZf4QjjNvXi+5ImN
 irSEgUY/IcXUHGzA+dV5T8R2DYhMJqr3uLBelCsjcZjLj01p5rJmw9SbIoTAUkzmScRn
 ojw25nYNUUq7QqPIfiKxtB3wOndmv4CeDzDAY2TKl6PGfuM1i9dUJxw4VsHPIoDWVLd/
 +PUQ==
X-Gm-Message-State: AOJu0Yxv2mJ51QnXo6ck+lq8gpw6kftEf9WUaDlHYnj79IfSm+0/4JOe
 tbn8rV5zaBs+xUvLKHrfbNIsFqrmiQUTjOi9ctH/8xHO7X2ybBgTzcsJ8gP6p7qcFog9eV7cfjo
 VCZQW+Mtw+NTBh5iz5mPulIwdkCbqwJL0+uiCay9tTuf7iipzp5zKa3ys
X-Gm-Gg: ASbGncsq1yjGbOyf7jjEl1nI7xqvyJQvraB2JQ0fbFvgEWVZ/gGM0ASW5BBkLb1AXDJ
 7FDHNN2tqzQ3w1qSyARlZqeXBrjo1Y8NcMYGqLZ2GR/2+SjYBgMCnl+YJDqcf51Yg4R2BDFQR8r
 fMTtRBZpWusw52rCA4ivl0QYMsRwNGAEsqMzeTQMl+U531RfyZqGUIcIwVV/IPdjs1Y2n1TzXgt
 /q9Z7z/kRxeEcPdkWel9BfH/IGW1rsA6tU8k2ENavHcG5YOhd/b69RhSo0dFY9Tcv5myGDswkwQ
 mh8J7GgYV94dGUeQHRSk7kl3BjrhOK7OAAgM9KJDzNafCQPRTS3HGil4gt9qf0OBZFRc8SxhFB7
 zoMs=
X-Received: by 2002:a05:6214:3a85:b0:880:5730:d3db with SMTP id
 6a1803df08f44-8846e054d65mr2568526d6.21.1763575767599; 
 Wed, 19 Nov 2025 10:09:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhcLsZHPo01FYGgTUQih5BLapAokqbeuAA+4Y54wTxOgNgHkwNxLSBBg1nI3YTS9Sdt0XpFw==
X-Received: by 2002:a05:6214:3a85:b0:880:5730:d3db with SMTP id
 6a1803df08f44-8846e054d65mr2567856d6.21.1763575767173; 
 Wed, 19 Nov 2025 10:09:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e445b1csm262086d6.9.2025.11.19.10.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:09:26 -0800 (PST)
Date: Wed, 19 Nov 2025 13:09:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/5] hw/nvram/xlnx-bbram: More idiomatic and simpler
 error reporting
Message-ID: <aR4H1FyafbvOUw2c@x1.local>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-3-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 19, 2025 at 02:08:52PM +0100, Markus Armbruster wrote:
> bbram_bdrv_error() interpolates a "detail" string into a template with
> error_setg_errno(), then reports the result with error_report().
> Produces error messages with an unwanted '.':
> 
>     BLK-NAME: BBRAM backstore DETAIL failed.: STERROR
> 
> Replace both calls of bbram_bdrv_error() by straightforward
> error_report(), and drop the function.  This is less code, easier to
> read, and the error message is more greppable.
> 
> Also delete the unwanted '.'.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


