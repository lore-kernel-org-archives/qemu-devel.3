Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57751E68143
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGTJ-0000fp-0F; Tue, 17 Feb 2026 03:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGTF-0000ek-4q
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGTD-00046k-J1
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771317010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Na+pdKo0ZvJMgi+8F1qB43t65VBbm90CG42pK4jkL14=;
 b=eDFNVdW+ZUfjaYlV03APPWDycxn0a2QktQlOrq8L7JQncisolOpbo+mO3qm0BeS/GMFo5f
 GshgFYu1U2POwi77IX/xYzu6utFidr+pLJfX/8RpWU4ue7hRv54kngFFfFKU5hVgCBagbc
 UvBZIdMnvZ20tvmx3l8vcFFN6t9RlkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356--e10ygvEO-ujd0VbBoKfOg-1; Tue,
 17 Feb 2026 03:30:05 -0500
X-MC-Unique: -e10ygvEO-ujd0VbBoKfOg-1
X-Mimecast-MFC-AGG-ID: -e10ygvEO-ujd0VbBoKfOg_1771317003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E81351955DC7; Tue, 17 Feb 2026 08:30:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F5C719560A3; Tue, 17 Feb 2026 08:30:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56EFA21E692D; Tue, 17 Feb 2026 09:30:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,
 david@kernel.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 armbru@redhat.com,  alifm@linux.ibm.com,  brueckner@linux.ibm.com
Subject: Re: [PATCH v8 01/30] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <20260212204352.1044699-2-zycai@linux.ibm.com> (Zhuoying Cai's
 message of "Thu, 12 Feb 2026 15:43:22 -0500")
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-2-zycai@linux.ibm.com>
Date: Tue, 17 Feb 2026 09:30:00 +0100
Message-ID: <87qzqjojqv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> machine. This allows users to specify one or more certificate file paths
> or directories to be used during secure boot.
>
> Each entry is specified using the syntax:
> 	boot-certs.<index>.path=/path/to/cert.pem
>
> Multiple paths can be specify using array properties:
> 	boot-certs.0.path=/path/to/cert.pem,
> 	boot-certs.1.path=/path/to/cert-dir,
> 	boot-certs.2.path=/path/to/another-dir...
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index ea430e1b88..0e0f4fdfb0 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -140,3 +140,26 @@
>  { 'event': 'SCLP_CPI_INFO_AVAILABLE',
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @BootCertificates:
> +#
> +# Boot certificate for secure IPL.

certificates

> +#
> +# @path: path to an X.509 certificate file or a directory containing
> +# certificate files.

You have to indent like this

   # @path: path to an X.509 certificate file or a directory containing
   #     certificate files.

As is, it gets rendered like

    Object BootCertificates (Since: 11.0)

       Boot certificate for secure IPL.

       Members:
          * path ("string") -- path to an X.509 certificate file or a
            directory containing

       certificate files.

Please proofread the generated documentation to avoid such issues.

> +#
> +# Since: 11.0
> +##
> +{ 'struct': 'BootCertificates',
> +  'data': {'path': 'str'} }
> +
> +##
> +# @DummyBootCertificates:
> +#
> +# Not used by QMP; hack to let us use BootCertificatesList internally.
> +#
> +# Since: 11.0
> +##
> +{ 'struct': 'DummyBootCertificates',
> +  'data': {'unused-boot-certs': ['BootCertificates'] } }

[...]


