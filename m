Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D88FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2Gf-000789-WC; Tue, 11 Mar 2025 12:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ts2DN-0000rJ-Ej
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ts2DI-00007y-IW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741709535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft2CkcNnu9M/KaFnt2hmzVgvyQHlGCsbTSRZU8Bol7k=;
 b=KZFok0i33I+6TRp3hUB0eWxKRL+y2cTD9JkJhOhHNRj3+6VilF742L18HfBZ/5jEeHP0Zw
 bzzyT5AeEGOgafF+2D0kKZ7mm291dpjYY+r6/wpncYijGNCbhWypGrfNSeyEMbMIEsf3Mh
 dWLq39K3eCDs/RIbwq5f8kyNSvlZSKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-D1ehbVtjNHWu_dvw0XzWaQ-1; Tue,
 11 Mar 2025 12:12:13 -0400
X-MC-Unique: D1ehbVtjNHWu_dvw0XzWaQ-1
X-Mimecast-MFC-AGG-ID: D1ehbVtjNHWu_dvw0XzWaQ_1741709532
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACE6918001E1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:12:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5981956094; Tue, 11 Mar 2025 16:12:10 +0000 (UTC)
Date: Tue, 11 Mar 2025 16:12:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH for-10.1 00/10] Support vdagent migration
Message-ID: <Z9Bg157qSKt2v74Z@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 07:59:22PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 
> iQJQBAABCAA6FiEEh6m9kz+HxgbSdvYt2ujhCXWWnOUFAmfQXbMcHG1hcmNhbmRy
> ZS5sdXJlYXVAcmVkaGF0LmNvbQAKCRDa6OEJdZac5bmLD/49TJdk8vSnG/G53f3Z
> UdUGdDiv98lAr/1wPZvmLPGfxiVLrVQK9Rarjnq9+dzmjoJC+w8THyPIvlvlKAQO
> aNSe5LV2lcYFLZwJqXQdGHTEWWZX3BmXroSFY06F9znX4lrNSg/cxLaI+Lt+dbEt
> BA9IIMzGYB+zhkgJh86Yji1Ioz29qwMgb4etf4OtP3PqT7/djWxxdlYLmyqN7D13
> seHAkvhaA7sqglLcfUv0MjrNA1Yxg3QQmbmiErpyaHo9kQ2AuV49THZl5/Pe3WR5
> FJAeO83G8hdxdqFuDvnXB0ID2klqWYkZTJsTD75F1hU1yqszkVt8k4mUWubTIDNm
> VEFKGz/S+xR2rO0RGgGzMPzEm0FSPbLq1+U2ETRf3xBns0Jbqe6njHeLGAzmOx9p
> 3F8fkM4mzIrs3oOU/e7dlxOl9N6uQhVfJW6G+9QMLPLveIpNR6CGphbgHuMK8PPL
> vZ1WNrGa/xoHvqQi2FvIJJrnKYYBJDXQW1edM+apDgO9jBSmiO5XlKZjeNHwgZ6J
> 0sNmJUKCmk2SPGtFHdpdRfjfYfN2eR07eTVnVgstpHCUZi0nRz+4A6yq4k0SQLQH
> ZWsaq6cdZyfNOOdSHaLfI/2/36eiLpVCAuwn+AjK+XvPR6mQc9rwebV8N5nXLEZ8
> OFcig1i00RhHBRJFPrOjWIFIQg==
> =iTg5
> -----END PGP SIGNATURE-----

Huh ?  I presume there should have been a cover letter here
instead of the tail end of a pgp signature....

> 
> Marc-André Lureau (10):
>   ui/gtk: warn if setting the clipboard failed
>   ui/clipboard: use int for selection field
>   ui/clipboard: split out QemuClipboardContent
>   ui/clipboard: add vmstate_cbinfo
>   ui/clipboard: delay clipboard update when not running
>   ui/vdagent: replace Buffer with GByteArray
>   ui/vdagent: keep "connected" state
>   ui/vdagent: factor out clipboard peer registration
>   ui/vdagent: add migration support
>   ui/vdagent: remove migration blocker
> 
>  include/ui/clipboard.h |  31 +++++--
>  ui/clipboard.c         |  66 +++++++++++++-
>  ui/gtk-clipboard.c     |  13 ++-
>  ui/vdagent.c           | 202 +++++++++++++++++++++++++++++++++++------
>  4 files changed, 268 insertions(+), 44 deletions(-)
> 
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


