Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F0E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBpk-0004eQ-Hs; Tue, 07 Jan 2025 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVBpf-0004dw-C1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVBpd-0006qv-Mj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264964;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1WumwGpnFuIBztcl4qjZngxaSVLAmn1Sgu72KHgiURs=;
 b=f1amtqePMnwc3sGJcjCzraEDZWLmHvqlbymbFWWeeswailY7IJ6bucGwUl8MXwlOP0z3EC
 HQBnxBbi6pavS2qHq6OweV/9frhW1/5hNTSos/en0VNk1fwdIu+jmCPnNQdspM0s1HQ16g
 jbubqewvcueCP6P66XRGSlzMSX33KrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-Lh7fb98aPGqSgSuuDzKFuQ-1; Tue,
 07 Jan 2025 10:49:20 -0500
X-MC-Unique: Lh7fb98aPGqSgSuuDzKFuQ-1
X-Mimecast-MFC-AGG-ID: Lh7fb98aPGqSgSuuDzKFuQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0193F1956089; Tue,  7 Jan 2025 15:49:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65F391955F57; Tue,  7 Jan 2025 15:49:12 +0000 (UTC)
Date: Tue, 7 Jan 2025 15:49:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 13/21] hw/uefi: add var-service-json.c + qapi for NV
 vars.
Message-ID: <Z31M9Vd37_koWggu@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <20250107153353.1144978-14-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107153353.1144978-14-kraxel@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 07, 2025 at 04:33:40PM +0100, Gerd Hoffmann wrote:
> Define qapi schema for the uefi variable store state.
> 
> Use it and the generated visitor helper functions to store persistent
> (EFI_VARIABLE_NON_VOLATILE) variables in JSON format on disk.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/uefi/var-service-json.c | 242 +++++++++++++++++++++++++++++++++++++
>  qapi/meson.build           |   1 +
>  qapi/qapi-schema.json      |   1 +
>  qapi/uefi.json             |  45 +++++++
>  4 files changed, 289 insertions(+)
>  create mode 100644 hw/uefi/var-service-json.c
>  create mode 100644 qapi/uefi.json
> 

> +void uefi_vars_json_init(uefi_vars_state *uv, Error **errp)
> +{
> +    if (uv->jsonfile) {
> +        uv->jsonfd = qemu_create(uv->jsonfile, O_RDWR, 0666, errp);
> +    }
> +}
> +
> +void uefi_vars_json_save(uefi_vars_state *uv)
> +{
> +    GString *gstr;
> +    int rc;
> +
> +    if (uv->jsonfd == -1) {
> +        return;
> +    }
> +
> +    gstr = uefi_vars_to_json(uv);
> +
> +    lseek(uv->jsonfd, 0, SEEK_SET);
> +    rc = write(uv->jsonfd, gstr->str, gstr->len);
> +    if (rc != gstr->len) {
> +        warn_report("%s: write error", __func__);
> +    }
> +    rc = ftruncate(uv->jsonfd, gstr->len);
> +    if (rc != 0) {
> +        warn_report("%s: ftruncate error", __func__);
> +    }
> +    fsync(uv->jsonfd);

Although the fsync helps, re-writing the file in-place is a ad idea for data
integrity on host OS crash. Especially if the new data is shorter, we would
easily end up with a file containing old and new data making it unparsable
(assuming the parser doesn't ignore trailing data).

I'd like to suggest the write to temp file + rename dance to get atomic
replacement. The problem with that is that it hits the DAC/MAC security
restrictions we put QEMU under :-(

My next best idea is to re-arrange things thus:

   lseek(fd, 0)
   ftruncate(fd, 0)
   fsync(fd)
   write(fd, str)
   fsync(fd)

so we should at least reduce the liklihood of getting a mix of
old and new data - empty file is better than a mix of data.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


