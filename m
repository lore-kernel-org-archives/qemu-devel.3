Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C40C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfem-0004La-Sp; Wed, 24 Jul 2024 13:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfej-0004KU-DM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfeg-0002Zp-Ll
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721841596;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4dszQ8Tyv0MuMSccEjS4xkzUa3TpAP0+CUEYvtdBwT0=;
 b=L6pLJIlHcDPfMPaMwWzxanVS8y1lvd2fUYD55/HhjSHw/trNSytCp9vBlhUkXGH72GlNhm
 lYpiubfmDYZNGlz/rxwafkaCGvlnIJ82RInrC6h8RelyVIE7WpUOc8Vl6XPCcuLRXHqEDb
 OaIuIHyCIjl551pTC/NUEgm1dsGjPkg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-wTH0q-JtORmvc6Dz34mkxQ-1; Wed,
 24 Jul 2024 13:19:52 -0400
X-MC-Unique: wTH0q-JtORmvc6Dz34mkxQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFA971955D5A; Wed, 24 Jul 2024 17:19:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 868093000198; Wed, 24 Jul 2024 17:19:39 +0000 (UTC)
Date: Wed, 24 Jul 2024 18:19:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 06/17] sev: Fix error handling in sev_encrypt_flash()
Message-ID: <ZqE3p79BWyyyJm0j@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <9930eadc36539f6135a0332116a51d48847505fe.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9930eadc36539f6135a0332116a51d48847505fe.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 03, 2024 at 12:05:44PM +0100, Roy Hopkins wrote:
> The function sev_encrypt_flash() checks to see if the return value of
> launch_update_data() < 0, but the function returns a non-zero (and not
> necessarily negative) result on error. This means that some errors in
> updating launch data will result in the function returning success.

I'm not sure that positive return values are intended as an error ?
The sev_launch_update_data method does:

    if (!addr || !len) {
        return 1;
    }

which seems to suggest that passing a NULL addr / zero-length,
was intended to be treated as a no-op, rather than an error.

If that interpretation is wrong, then, I'd suggest that
sev_launch_update_data be changed to return '-1' in this
case, since QEMU standard is to consider negative values
as errors.

> 
> In addition, the function takes an Error parameter which is not used
> when an error is actually returned.
> 
> The return value is now checked for non-zero to indicate an error and
> a suitable error message is logged.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 3ab8b3c28b..491ca5369e 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1542,12 +1542,9 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>  
>      /* if SEV is in update state then encrypt the data else do nothing */
>      if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
> -        int ret;
> -
> -        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
> -        if (ret < 0) {
> -            error_setg(errp, "SEV: Failed to encrypt pflash rom");
> -            return ret;
> +        if (klass->launch_update_data(sev_common, gpa, ptr, len)) {
> +            error_setg(errp, "SEV: Failed to encrypt flash");
> +            return -1;

sev_launch_update_data() calls error_report with the real error
details, and here we file a information-less error message.

Can we add "Error **errp" to the 'launch_update_data' API contract,
and change the error_report() calls to error_setg(), so we have
the useful information propagated in the Error object.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


