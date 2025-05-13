Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE6C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErWA-0005bh-Dv; Tue, 13 May 2025 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uErW9-0005ZH-1B
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uErW6-0006Fg-2j
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747149959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCZQVM6dEqnWE/Pj9PJcnFUK3greqEwjIE0wdJI3PrE=;
 b=jOAGhLFQ7NorFapoFAX9L0OY+rwppPEyiTNd0xgZKQtM25ZSlIxzRD/X64K6/wS4m0/tBx
 ekdkxeriPgl8BvPoh/PbxyntlRcM9jnzkUr8+PQt5no6qx8zdxz6MulpoZsZ/yYli6NgWI
 bCG2LbUMk/ieTECj1Q/de40uPfyvnvo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-QGJmA3l_ONCwkQ-1qVwXZA-1; Tue,
 13 May 2025 11:25:57 -0400
X-MC-Unique: QGJmA3l_ONCwkQ-1qVwXZA-1
X-Mimecast-MFC-AGG-ID: QGJmA3l_ONCwkQ-1qVwXZA_1747149956
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAEDF195608C; Tue, 13 May 2025 15:25:55 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B83C1940E95; Tue, 13 May 2025 15:25:54 +0000 (UTC)
Date: Tue, 13 May 2025 17:25:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 06/27] qemu-img: factor out parse_output_format() and use
 it in the code
Message-ID: <aCNkfxXqRlCAyJq-@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-7-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927061121.573271-7-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.09.2024 um 08:11 hat Michael Tokarev geschrieben:
> Use common code and simplify error message
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qemu-img.c | 63 ++++++++++++++++--------------------------------------
>  1 file changed, 18 insertions(+), 45 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 7ed5e6d1a8..08536553c7 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -158,6 +158,17 @@ void cmd_help(const img_cmd_t *ccmd,
>      exit(EXIT_SUCCESS);
>  }
>  
> +static OutputFormat parse_output_format(const char *argv0, const char *arg)
> +{
> +    if (!strcmp(arg, "json")) {
> +        return OFORMAT_JSON;
> +    } else if (!strcmp(arg, "human")) {
> +        return OFORMAT_HUMAN;
> +    } else {
> +        error_exit(argv0, "--output expects 'human' or 'json' not '%s'", arg);

I would expect a comma before "not '%s'".

With this changed:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


