Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFE8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUbV-0007uB-7D; Fri, 08 Mar 2024 02:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riUbU-0007tZ-1K
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riUbS-0004Io-Lk
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709882713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUCX38nsfWLGd1zur03ZYboPhZ72697LbB/4iuf59Xw=;
 b=MmQYX+iiX2kMYLYziAn2U89EgdIrt/Ry0sgUubnFhQb9hXtYWa5Q+qEqHzz1leGgB3LMrh
 ha1rGeLcyYIbDbg1dNmAdub0GUCYQGosPEzd9rsvxLPvraYn5bHhX3RRg+5D0Vhdimk4cy
 icUTMW4Lm2TY5P2Nqq5pTT2niyUkk80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ZiwKoPKJPyq9JWpdHOpcgQ-1; Fri, 08 Mar 2024 02:25:09 -0500
X-MC-Unique: ZiwKoPKJPyq9JWpdHOpcgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B1C489CECA;
 Fri,  8 Mar 2024 07:25:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F4B1C05E1C;
 Fri,  8 Mar 2024 07:25:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA81321E6A24; Fri,  8 Mar 2024 08:25:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  pbonzini@redhat.com,
 mst@redhat.com,  gaosong@loongson.cn,  alistair.francis@wdc.com,
 palmer@dabbelt.com,  bin.meng@windriver.com,  liwei1518@gmail.com,
 dbarboza@ventanamicro.com,  zhiwei_liu@linux.alibaba.com,
 anisinha@redhat.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 eblake@redhat.com,  qemu-arm@nongnu.org,  qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: Re: [PATCH v2 14/20] smbios: extend smbios-entry-point-type with
 'auto' value
In-Reply-To: <20240305155724.2047069-15-imammedo@redhat.com> (Igor Mammedov's
 message of "Tue, 5 Mar 2024 16:57:18 +0100")
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-15-imammedo@redhat.com>
Date: Fri, 08 Mar 2024 08:25:06 +0100
Message-ID: <87jzmd6v8t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  qapi/machine.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index bb5a178909..6bdc71dc8c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1797,10 +1797,13 @@
>  #
>  # @64: SMBIOS version 3.0 (64-bit) Entry Point
>  #
> +# @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be
> +#        described by it and 3.x otherwise (since: 9.0)

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


