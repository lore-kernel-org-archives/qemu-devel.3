Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C9C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3amn-0003ky-6F; Mon, 07 Sep 2026 10:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3amj-0003ke-7S
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3amh-0001oq-Fx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788793041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jyI4WYndUAG9uia6wbIYzlWipnYru8MCmKOtYIiXX+o=;
 b=bV8Fa2BbDNPqh1AYZndy0R1nUkfMzk8AyfKLINqiha1C9YeVtLsztZHSZ1nvT5+RDxMEcx
 dRg81LFtqGHQ2JZPrGJ/DdHyVjm2J8FJZjTcmAPa1+n3i2QSJx6OIEPzZP9/VpsWfiIYzG
 MOIh9zMeq0WQL4T9g9TfZAGyK/31BC0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-6U6E9FrMO36YBpFpIIHbMQ-1; Mon, 07 Sep 2026 10:57:20 -0400
X-MC-Unique: 6U6E9FrMO36YBpFpIIHbMQ-1
X-Mimecast-MFC-AGG-ID: 6U6E9FrMO36YBpFpIIHbMQ_1788793039
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482db84a6eeso3391012f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788793039; x=1789397839; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jyI4WYndUAG9uia6wbIYzlWipnYru8MCmKOtYIiXX+o=;
 b=I0R8O1asEk41LWN8cPBP0qm4Ib1r7sFj8CD7N6bc/FIJsoHTE4JbnWJRitG/7+OPul
 j2Uj2rg3dWxBxz0AombdXLQmoAsRGqLVm9sflHHw3AQFSKlY/rImNNZLJQi3s9+0adjm
 WsLNzty+w2ciVcZwxf8aF8Bh4+Suzz7Og6aV3izKGMYRPDrebVjjWI77cPuQR53TsPfe
 5LldGI8NCtMmPuEglaAfHr58BJfuDlXbP6odzAOumhXP6W2EXhIlyBKblc3A0MWRwslZ
 iRZPnIIj+2x6Zc/ZJLSvtHLVCZeFOwt2Ej55crfCXyTJxVEwhUg4Ti/3YogCDtk5s+Ok
 gNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793039; x=1789397839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jyI4WYndUAG9uia6wbIYzlWipnYru8MCmKOtYIiXX+o=;
 b=O6kfgE6Cxz/Q/5Yj9h4vlXPzE5rDl6G/seRmgxinpgDonu7sCXDMk3yUCabOXlSBod
 lAK8yKKma25BBGrbzYcvyMrl0QReBRd4j4EO1jcve+/OR0qlgUIw2UtCVkwj7pn5sChE
 BadW4IFxzQrj+lOAFWnXYf0qgSE0vv/IFDC3o2lhzERKwuWENug3kRElVfIXE5NBsclW
 GVBshfCGIAQw2Lk6QraZ5VfA7Ywj3Qyl2bXY7eOje9NW36RZUxkz8gFoJv5Hex63kd3E
 KFsnuxdGZShQmI/mbxHHzFd7MyFKHEDT3VsO1haKXN3nE7txrsfVe4cLWU8xisLQJSAn
 xmTw==
X-Gm-Message-State: AFuF++nhm8mE2HGtNBY9iITDcgknJY1sSD1tGnD+dXiKumP2YVa5iD3Z
 c0IhWdKWN/tczbhCi7RlsNjUaKHiK0Ol+CexPySJMWhomdvxcHbH3evXpB8Yiboxau0yIhVLgwR
 41vbqN2Qrr0QHNZQONEs+rqA/wkGLi2nxl22Kl3WC3NtluWjNiuuj+OMy
X-Gm-Gg: AYBFou2tXtO6vYgveEpyux7TVWJSEETtLccmUO9rLcIJPfTWusUAs4G+4+Oatf2+E3O
 vZplpWQ9l8D4nTiG2Ki+4CIrp+DUjD9ltjSRFvreDPEWtaw4HTZ4qcWRejeflsgj0a+WPUd/LR1
 T4r5Owfw4ktP2GZU3QJJb8kLpYBno+Lt+YssPzPUXTR1Bv5DxXtPGYaXzaLmoQj1hmzrHxg4xGm
 rzQpRS+VoQx6zZR7sVu+aWdE3qKTEsFuOJYJt+77bNt+wsyIXyMppDHmMKxYAkxRmefSUtsA1+w
 NvBV/07qIfTmX9k6kGVg3OeyMpHbh8jtEEora62PU2Lkmjgto1oHw+EquY3UjDDL+CsE0oryVYO
 NoVYev5MQ/4AnUUntX13+cV5W7k/d3Ovz2OjkZ23c+VHcAQ==
X-Received: by 2002:a05:6000:2388:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-48586bf25b8mr44929800f8f.0.1788793037464; 
 Mon, 07 Sep 2026 07:57:17 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-48586bf25b8mr44929151f8f.0.1788793032962; 
 Mon, 07 Sep 2026 07:57:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858bc74298sm25952682f8f.6.2026.09.07.07.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:57:12 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:57:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 09/10] vhost: add vhost_dev_is_initialized() helper
Message-ID: <ap7KFvxz4LVR1Hg4@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-10-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-10-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 20, 2026 at 02:39:54PM +0300, Andrey Drobyshev wrote:
>The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
>to .post_load(). On an incoming CPR .realize() only sets up the backend,
>so we need a way to tell a fully initialized vhost device from a partially
>initialized one.
>
>Add an explicit 'bool initialized' field, set once vhost_dev_init()
>succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
>a public vhost_dev_is_initialized() helper.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         |  2 ++
> include/hw/virtio/vhost.h | 14 ++++++++++++++
> 2 files changed, 16 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


