Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EC4CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNIS-0005B4-N1; Mon, 27 Oct 2025 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDNIR-0005Ak-OW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDNIK-0006GN-43
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761571792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guTZYEdsNDf0yJymuvOdzYDoecGrmzDMiMvpmCuf8B4=;
 b=GdVvoxePxGxkYkqnlCZfTHYaDqZlmucXlP6H3nnYMYsEpUp44bf+0AUlVq9WFzgGscnz4j
 jrDdMLGkr3N/HEYR2IiMpS6dNcvzIZ2AOxD3T5dTK5HUFbLPjfeKu2hCzK3EHIar3Muts5
 aSC3QlRcZyYJM3Q+Xr9fc4h6DkiTU9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-dOaLsiH5Nna4XEcLfGofjg-1; Mon,
 27 Oct 2025 09:29:49 -0400
X-MC-Unique: dOaLsiH5Nna4XEcLfGofjg-1
X-Mimecast-MFC-AGG-ID: dOaLsiH5Nna4XEcLfGofjg_1761571787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0630C19560B2; Mon, 27 Oct 2025 13:29:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF741955F1B; Mon, 27 Oct 2025 13:29:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 903B721E6A27; Mon, 27 Oct 2025 14:29:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Bernhard
 Beschow <shentey@gmail.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  qemu-riscv@nongnu.org,  qemu-ppc@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>,  qemu-s390x@nongnu.org,  Halil Pasic
 <pasic@linux.ibm.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>,  Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v2] docs/system/security: Restrict "virtualization use
 case" to specific machines
In-Reply-To: <20251016131159.750480-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 16 Oct 2025 14:11:59 +0100")
References: <20251016131159.750480-1-peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 14:29:41 +0100
Message-ID: <873474mq0q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently our security policy defines a "virtualization use case"
> where we consider bugs to be security issues, and a
> "non-virtualization use case" where we do not make any security
> guarantees and don't consider bugs to be security issues.
>
> The rationale for this split is that much code in QEMU is older and
> was not written with malicious guests in mind, and we don't have the
> resources to audit, fix and defend it.  So instead we inform users
> about what the can in practice rely on as a security barrier, and
> what they can't.
>
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.
>
> Specifically, we would like to be able to enable the use of
> KVM with the imx8 development board machine types, but we don't
> want to commit ourselves to having to support those SoC models
> and device models as part of QEMU's security boundary:
> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
>
> This patch updates the security policy to explicitly list the
> machine types we consider to be useful for the "virtualization
> use case".
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> changes v1->v2: updated the list:
>  * remove isapc
>  * remove ppc, mips, mips64 (no machines supported)
>  * list pseries as only supported ppc64 machine
>  * list virt as only supported riscv32, riscv64 machine
>
> I believe the list to now be correct, and I think we generally
> had some consensus about the idea on the v1 patch discussion, so
> this one is a non-RFC patch.
>
> ---
>  docs/system/security.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index f2092c8768b..53992048e65 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -35,6 +35,32 @@ malicious:
>  Bugs affecting these entities are evaluated on whether they can cause damage in
>  real-world use cases and treated as security bugs if this is the case.
>  
> +To be covered by this security support policy you must:
> +
> +- use a virtualization accelerator like KVM or HVF
> +- use one of the machine types listed below
> +
> +It may be possible to use other machine types with a virtualization
> +accelerator to provide improved performance with a trusted guest
> +workload, but any machine type not listed here should not be
> +considered to be providing guest isolation or security guarantees,
> +and falls under the "non-virtualization use case".

"Virtualization use case" becomes a bit of a misnomer.

> +
> +Supported machine types for the virtualization use case, by target architecture:
> +
> +aarch64
> +  ``virt``
> +i386, x86_64
> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> +s390x
> +  ``s390-ccw-virtio``
> +loongarch64:
> +  ``virt``
> +ppc64:
> +  ``pseries``
> +riscv32, riscv64:
> +  ``virt``
> +
>  Non-virtualization Use Case
>  '''''''''''''''''''''''''''

Regardless
Acked-by: Markus Armbruster <armbru@redhat.com>


