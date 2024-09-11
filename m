Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F43BEE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLXq-0000I0-Ec; Wed, 11 Sep 2024 07:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLXo-0000AM-KT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLXn-0001MA-4a
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726054194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLEIk5EQykvM6atBBxN6dW4vGPPn78PtDaJfjtd0HrA=;
 b=fMLDFbE3pQkgBoKTgNgw6ncpq2j44nVy2eM0ySs83mFHZXJHtyK2xTnIz8nj8+D5ExsqWt
 dLUb/TjYhaxXy7WVwLBVkeDy0EwnBL9i3Fua/OthYWJ/tr+8x0kEyjXyTP6zvUj/omNtCM
 pqMK+g2TlieO/JnoIxZ1o7IqYARp8X8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-jM6muCCzOFmiZYdBatxo5g-1; Wed, 11 Sep 2024 07:29:53 -0400
X-MC-Unique: jM6muCCzOFmiZYdBatxo5g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8a80667ad8so481466666b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726054191; x=1726658991;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLEIk5EQykvM6atBBxN6dW4vGPPn78PtDaJfjtd0HrA=;
 b=br9AAwPkVezsqBKKqtYbG6UBo8Ox3MJZm2mmLURs0sOGa3iQq+Rsz9vNqKUTQr9xSq
 YUrT9P7VRLIbhkSjySUdKQLBQPqSg12zQVAn3J6hooCz7CTZIacDdwA+u9tyLYlej9Hy
 zq++fVSXL0CPbalpCtusZkj5au/HFGInMaJRZ4kkEbG6g3GQy5A+5sSW9BgXZjzKaPXV
 jj62pU8e3eWni8IHTtrrREC4gg9FvQtHX62IR44DbKpXJyKuIjtC1RqtJVku3ImtbHcN
 QoslIYcC4DBDgQX/5sDCDsjhczoCKjrL8C7+itGxSybK3JWI0fOgYUIERVdEVAfAhrKJ
 MIBg==
X-Gm-Message-State: AOJu0Yw9TKarHCNEd+lKE0oY2sLrn48BJZuSQfhLE1Z+88iWDNN+IaOI
 BdODhg9WR2OnJCFuI7fpRCEdr5MEh4tS1w6Tm7glfDcpujIMjkwkWnErdrPrnfbB+7+JtUb76q2
 Ilfdlw1Tbx6LQ1kXepeCpjBwHN2jQkVMw8cYl8zYqIqLkh8p7j1GXwZFPX93G
X-Received: by 2002:a17:907:9619:b0:a8d:29a2:47cf with SMTP id
 a640c23a62f3a-a8ffad9815emr355970766b.40.1726054191062; 
 Wed, 11 Sep 2024 04:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5rdTlTUMKhcvwiXk86jQW6YI0qWTdWydBYqo68oHNxmoLhSeT7it1GZLZtbvKxYztTvS7Og==
X-Received: by 2002:a17:907:9619:b0:a8d:29a2:47cf with SMTP id
 a640c23a62f3a-a8ffad9815emr355964166b.40.1726054189896; 
 Wed, 11 Sep 2024 04:29:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d64880sm595645066b.219.2024.09.11.04.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 04:29:49 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:29:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, arei.gonglei@huawei.com,
 pizhenwei@bytedance.com, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, marcel.apfelbaum@gmail.com, jiri@resnulli.us,
 jsnow@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/8] qapi/pci: Supply missing member documentation
Message-ID: <20240911072927-mutt-send-email-mst@kernel.org>
References: <20240911112545.2248881-1-armbru@redhat.com>
 <20240911112545.2248881-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911112545.2248881-6-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 11, 2024 at 01:25:42PM +0200, Markus Armbruster wrote:
> Since we neglect to document a member of PciMemoryRegion, its
> description in the QEMU QMP Reference manual is "Not documented".  Fix
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


can you merge this?

> ---
>  qapi/pci.json    | 2 ++
>  qapi/pragma.json | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/pci.json b/qapi/pci.json
> index 78bee57b77..dc85a41d28 100644
> --- a/qapi/pci.json
> +++ b/qapi/pci.json
> @@ -33,6 +33,8 @@
>  #     - 'io' if the region is a PIO region
>  #     - 'memory' if the region is a MMIO region
>  #
> +# @address: memory address
> +#
>  # @size: memory size
>  #
>  # @prefetch: if @type is 'memory', true if the memory is prefetchable
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 7b0e12f42b..baeae5bf52 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -62,7 +62,6 @@
>          'MemoryDeviceInfoKind',
>          'NetClientDriver',
>          'ObjectType',
> -        'PciMemoryRegion',
>          'QCryptodevBackendServiceType',
>          'QKeyCode',
>          'RbdAuthMode',
> -- 
> 2.46.0


