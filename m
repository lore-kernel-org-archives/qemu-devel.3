Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGaD-00027q-7Q; Wed, 28 Feb 2024 04:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGa9-00025u-86
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGa7-0002hm-Qd
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709113830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TSN7o4nz7TOjcEGUbsK+srpb68uwqPExedL9QhByc8=;
 b=dz8/F0yGOhqH+xXtY9zhpDdpjJJenSTsjdgjXzBX+Xyl4/KeVh7knkxJsOqCugruHTYX++
 6N/8HeXLI9GSvsEYYK1By+pMlCRP7B2PoSXFsxAvle7OrKpZzWDkvu3xGw7PsMzFv7Zbkp
 gMbIabjm5g9fLUmvsNhzcn6CJvPT00s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-zqWQ5DBsOHO_DQdLR3nFmw-1; Wed, 28 Feb 2024 04:50:28 -0500
X-MC-Unique: zqWQ5DBsOHO_DQdLR3nFmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583DC185A783;
 Wed, 28 Feb 2024 09:50:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30AF8A20;
 Wed, 28 Feb 2024 09:50:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 054D721E66F9; Wed, 28 Feb 2024 10:50:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <20240226195654.934709-3-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Mon, 26 Feb 2024 19:56:49 +0000")
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 10:50:26 +0100
Message-ID: <871q8w29zx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> 1. Add zero_pages field in MultiFDPacket_t.
> 2. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> 5. Adds zero page counters and updates multifd send/receive tracing
> format to track the newly added counters.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1e66272f8f..5a1bb8ad62 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -660,10 +660,13 @@
>  #
>  # @legacy: Perform zero page checking from main migration thread.
>  #
> +# @multifd: Perform zero page checking from multifd sender thread.
> +#
>  # Since: 9.0
> +#
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'none', 'legacy' ] }
> +  'data': [ 'none', 'legacy', 'multifd' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:

What happens when you set "zero-page-detection": "multifd" *without*
enabling multifd migration?


