Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DFAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0H9t-00052c-8y; Fri, 26 Apr 2024 04:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0H9r-00051t-0H
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0H9p-0003WW-4T
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714120932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFyIAYuxwo9CFm0D8FhCCDwxvI1pxlH2mhkaqRspA5o=;
 b=aL8AzDJqv+XUikU4QkBBxYDC1K+Kc4SJOe/vOwkrgTu2+bQViOCXTmUMZSv3X3LCrJI0kK
 U6u1OSVTyqORacG/Baj2LuQxifonNrKNXrcE31HWEzGq1j/CmfUDfBSWVTx+c9qKAn0uhT
 t7H5S99HpWw0Ie8oaTSguQOlw2Muqxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-v6jtalRUOQaZzsdwndn0dQ-1; Fri, 26 Apr 2024 04:42:06 -0400
X-MC-Unique: v6jtalRUOQaZzsdwndn0dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 885EC8943A4;
 Fri, 26 Apr 2024 08:42:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E5BC40B4979;
 Fri, 26 Apr 2024 08:42:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41ADF21E6811; Fri, 26 Apr 2024 10:42:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  armbru@redhat.com
Subject: Re: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
In-Reply-To: <20240424215633.48906-2-walling@linux.ibm.com> (Collin Walling's
 message of "Wed, 24 Apr 2024 17:56:32 -0400")
References: <20240424215633.48906-1-walling@linux.ibm.com>
 <20240424215633.48906-2-walling@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:42:04 +0200
Message-ID: <87o79wy0pv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Collin Walling <walling@linux.ibm.com> writes:

> Retain a list of deprecated features disjoint from any particular
> CPU model. A query-cpu-model-expansion reply will now provide a list of
> properties (i.e. features) that are flagged as deprecated. Example:
>
>     {
>       "return": {
>         "model": {
>           "name": "z14.2-base",
>           "deprecated-props": [
>             "bpb",
>             "csske"
>           ],
>           "props": {
>             "pfmfi": false,
>             "exrl": true,
>             ...a lot more props...
>             "skey": false,
>             "vxpdeh2": false
>           }
>         }
>       }
>     }
>
> It is recommended that s390 guests operate with these features
> explicitly disabled to ensure compatability with future hardware.
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  qapi/machine-target.json         |  5 ++++-
>  target/s390x/cpu_features.c      | 14 ++++++++++++++
>  target/s390x/cpu_features.h      |  1 +
>  target/s390x/cpu_models_sysemu.c |  6 ++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 29e695aa06..3799a60e3d 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -20,11 +20,14 @@
>  #
>  # @props: a dictionary of QOM properties to be applied
>  #
> +# @deprecated-props: a list of QOM properties that are flagged as deprecated

Deprecated by whom?  QEMU?  The CPU vendor?

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

> +#
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelInfo',
>    'data': { 'name': 'str',
> -            '*props': 'any' } }
> +            '*props': 'any',
> +            '*deprecated-props': ['str'] } }
>  
>  ##
>  # @CpuModelExpansionType:

[...]


