Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E93D18125
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mnd-0000wd-By; Mon, 14 Oct 2024 11:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Mnc-0000wB-GR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Mna-0008GI-UR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728918954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SwRIbhSQgz00zohy+puFdANXNUN00FcDgWKtUllVlBo=;
 b=DHBAWiJl85LKPSA329baUfiz8q0Tjn4L9EXKb63+WfKftC/if+XBAR66cZhX1vOPxEQn9q
 MpZFieiqscee+Zqybm1eYvLODBmUG9r7nvYXEjLiAcIQMLnoQhctMpHMGhpnaobShn8rk9
 PlWcrQv/zaPZf4nhz43rDvG6ABhUGro=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-AR41EbHEM8KNCQNuyFYpjQ-1; Mon,
 14 Oct 2024 11:15:51 -0400
X-MC-Unique: AR41EbHEM8KNCQNuyFYpjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D17F71955D61; Mon, 14 Oct 2024 15:15:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24DE319560A2; Mon, 14 Oct 2024 15:15:46 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:15:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] ui/console-vc: Silence warning about sprintf() on OpenBSD
Message-ID: <Zw01n0A6xCG9mCm-@redhat.com>
References: <20241014151023.85698-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014151023.85698-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 14, 2024 at 05:10:23PM +0200, Thomas Huth wrote:
> The linker on OpenBSD complains:
> 
>  ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
>  warning: sprintf() is often misused, please use snprintf()
> 
> Using snprintf() is certainly better here, so let's switch to that
> function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  ui/console-vc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 8393d532e7..336a1520eb 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -821,9 +821,9 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  case 6:
>                      /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> -                           (s->y_base + s->y) % s->total_height + 1,
> -                            s->x + 1);
> +                    snprintf(response, sizeof(response), "\033[%d;%dR",
> +                             (s->y_base + s->y) % s->total_height + 1,
> +                             s->x + 1);
>                      vc_respond_str(vc, response);

These two lines are the only place in the code that uses the

   char response[40];

so even better than switching to snprintf, how about just taking
buffer size out of the picture:

  g_autofree *response =
      g_strdup_printf("\033[%d;%dR",
                      (s->y_base + s->y) % s->total_height + 1,
                      s->x + 1);
  vc_respond_str(vc, response);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


