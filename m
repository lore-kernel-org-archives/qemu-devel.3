Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C75D2A526
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 15:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t15Yc-0001fX-Ew; Wed, 16 Oct 2024 11:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t15YZ-0001fH-SL
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t15YY-0006IK-7n
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729090997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qSSNABudOTZbX+m5um/KScwaoRBno+HubiWq0mpWK6w=;
 b=bd5EaimxLctxHGkYktOZFIUvjV/8lDD/wxtODCJg4XAQbEVMgyueZM+UqZfnBznzbOMZkK
 VDR3yF4ItT7hsSqgpR918J6w5aWf6sw1Xjqt0ESNnixK/LHi7ZV3XwOyffuq/6tm462NyD
 lzVK/C1GCSFC5NbUr6uKTFvNqc0PRmE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-GPiaMPnnNjC_KuRkQIxJHA-1; Wed,
 16 Oct 2024 11:03:15 -0400
X-MC-Unique: GPiaMPnnNjC_KuRkQIxJHA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87DD41955EB5; Wed, 16 Oct 2024 15:03:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 050D11956056; Wed, 16 Oct 2024 15:03:08 +0000 (UTC)
Date: Wed, 16 Oct 2024 16:03:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v3 1/2] tpm: Use new ptm_cap_n structure for
 PTM_GET_CAPABILITY
Message-ID: <Zw_VpwVc_qSpJS6y@redhat.com>
References: <20241016145708.1166471-1-stefanb@linux.ibm.com>
 <20241016145708.1166471-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016145708.1166471-2-stefanb@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 16, 2024 at 10:57:07AM -0400, Stefan Berger wrote:
> Use the new ptm_cap_n structure for getting the PTM_GET_CAPABILITY response
> from swtpm. Previously only 17 bits could possibly have been set in ptm_cap
> (=uint64_t) in big endian order and those bits are now found in the 2nd
> 32bit word in the response in the caps field.
> 
> This data structure makes it now clear that the 1st 32bit word carries the
> tpm_result like all the other response structures of all other commands
> do.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/tpm/tpm_emulator.c | 14 ++++++++------
>  backends/tpm/tpm_ioctl.h    | 13 ++++++++++++-
>  backends/tpm/trace-events   |  2 +-
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 

> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
> index 1933ab6855..ee2dd15d35 100644
> --- a/backends/tpm/tpm_ioctl.h
> +++ b/backends/tpm/tpm_ioctl.h
> @@ -29,6 +29,16 @@
>  
>  typedef uint32_t ptm_res;
>  
> +/* PTM_GET_CAPABILITY: Get supported capabilities (ioctl's) */
> +struct ptm_cap_n {
> +    union {
> +        struct {
> +            ptm_res tpm_result; /* will always be TPM_SUCCESS (0) */
> +            uint32_t caps;
> +        } resp; /* response */
> +    } u;
> +};

The union here is pointless surely, since it only has one entry and
the following patch doesn't add a 2nd either ? 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


