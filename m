Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4910CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz8Zh-0006BI-Vm; Thu, 18 Sep 2025 02:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz8Zd-00069g-1Z
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz8ZY-0004Et-Os
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758178609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqktY5JdeXFygaia3GQLB4aau6vb0Kt1rrcW7DF8Uh0=;
 b=FQGhzpzaUswPbGK7phQ3B9R70P7KSery1qh4h7/CFrejldYT+4qgrKwVmpmRQNkH0g8Yp5
 Wze+QolobKlEoTugsoC2ojN5vhWqJUqgj4reaGrAeRV3l3C0QGvA9PfpHntCUyoIaLSAHH
 K40W2/IjOoEVJ5B11WcOOczNSzzCTqs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-zBV0SxF9N8CnjlO3fIM7rA-1; Thu,
 18 Sep 2025 02:56:44 -0400
X-MC-Unique: zBV0SxF9N8CnjlO3fIM7rA-1
X-Mimecast-MFC-AGG-ID: zBV0SxF9N8CnjlO3fIM7rA_1758178603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA1319560B6; Thu, 18 Sep 2025 06:56:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3597B18004D8; Thu, 18 Sep 2025 06:56:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5EF121E6A27; Thu, 18 Sep 2025 08:56:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 david@redhat.com,  jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <20250917232131.495848-2-zycai@linux.ibm.com> (Zhuoying Cai's
 message of "Wed, 17 Sep 2025 19:21:03 -0400")
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
Date: Thu, 18 Sep 2025 08:56:39 +0200
Message-ID: <87ldmcz1so.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Given we can specifiy a directory containing any number of certificate
files, is the ability to specify multiple paths worth the additional
complexity?

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

[...]

> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index 966dbd61d2..51bf791fe6 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -119,3 +119,25 @@
>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @BootCertificate:
> +#
> +# Boot certificate for secure IPL.
> +#
> +# @path: path to an X.509 certificate file or a directory containing certificate files.
> +#
> +# Since: 10.2
> +##
> +{ 'struct': 'BootCertificate',
> +  'data': {'path': 'str'} }

I'd call this BootCertificates (plural), because it can pull in any
number, not just than one.

> +
> +##
> +# @DummyBootCertificates:
> +#
> +# Not used by QMP; hack to let us use BootCertificateList internally.
> +#
> +# Since: 10.2
> +##
> +{ 'struct': 'DummyBootCertificates',
> +  'data': {'unused-boot-certs': ['BootCertificate'] } }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 023a2ef7bc..66401837ad 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -49,6 +49,7 @@
>          'DisplayProtocol',
>          'DriveBackupWrapper',
>          'DummyBlockCoreForceArrays',
> +        'DummyBootCertificates',
>          'DummyForceArrays',
>          'DummyVirtioForceArrays',
>          'HotKeyMod',


