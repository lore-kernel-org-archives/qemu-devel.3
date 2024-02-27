Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE0C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0pC-0001KU-6C; Tue, 27 Feb 2024 12:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rf0os-0001Dp-L4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rf0or-0005ii-1J
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709053239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dc5uEDKmUP6lkgd5F+ELxhywGff4XDS5bKezLevdlDc=;
 b=SdjPdBLqb/2zY5dR5ofI9+pmZ/9oTiM1gFviDKfjRHWWPQFWXAf6HUAjSBl9yeLtZBryp4
 CQcjbSs+U55YFG7GghibmlEHLIsN5MS1E2iB4p1NrTc2FuDUft5clAcd2sU479j/PLyYVC
 RUe2zGpqeixtc9EPBW/Wve5/Hpg+uKc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-7O-1_E-rPlmSEC-NF5eE8w-1; Tue,
 27 Feb 2024 12:00:38 -0500
X-MC-Unique: 7O-1_E-rPlmSEC-NF5eE8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D590329ABA11;
 Tue, 27 Feb 2024 17:00:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04FBFC185C4;
 Tue, 27 Feb 2024 17:00:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C514C21E66D0; Tue, 27 Feb 2024 18:00:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  pbonzini@redhat.com,
 mst@redhat.com,  gaosong@loongson.cn,  alistair.francis@wdc.com,
 palmer@dabbelt.com,  bin.meng@windriver.com,  liwei1518@gmail.com,
 dbarboza@ventanamicro.com,  zhiwei_liu@linux.alibaba.com,
 anisinha@redhat.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 eblake@redhat.com,  qemu-arm@nongnu.org,  qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: Re: [PATCH 13/19] smbios: extend smbios-entry-point-type with
 'auto' value
In-Reply-To: <20240227154749.1818189-14-imammedo@redhat.com> (Igor Mammedov's
 message of "Tue, 27 Feb 2024 16:47:43 +0100")
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-14-imammedo@redhat.com>
Date: Tue, 27 Feb 2024 18:00:32 +0100
Message-ID: <87o7c1970v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> later patches will use it to pick SMBIOS version at runtime
> depending on configuration.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  qapi/machine.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 93b4677286..4c68528507 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1802,10 +1802,13 @@
>  #
>  # @64: SMBIOS version 3.0 (64-bit) Entry Point
>  #
> +# @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be described
> +#        by it and 3.x otherwise (since: 9.0)

Please format like

   # @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be
   #     described by it and 3.x otherwise (since: 9.0)

> +#
>  # Since: 7.0
>  ##
>  { 'enum': 'SmbiosEntryPointType',
> -  'data': [ '32', '64' ] }
> +  'data': [ '32', '64', 'auto' ] }
>  
>  ##
>  # @MemorySizeConfiguration:

With that
Acked-by: Markus Armbruster <armbru@redhat.com>


