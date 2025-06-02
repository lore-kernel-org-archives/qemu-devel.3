Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31C8C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2mc-0004zG-RH; Mon, 02 Jun 2025 06:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM2mb-0004yp-2t
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM2mZ-0000ab-Nb
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748861562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aX9Z0D63j0Esz9NQqR9RJjbxzzf0ckrTzB2HkPExJvM=;
 b=MfJuB2TrL3Em1rB0Okd3zgJ8sUOT3WgFRhEDlMsNClFE7epjqc+Ez0rMJpGMK0WWJzJF1u
 WVBOWzb6ArEkTz5Q31iFh2Qo+mALdGiaoGaJV9fw4qeltT2VrC4h68nlQDYwN0oorWAeG6
 XuC8bI6NbWTNvFV3H+Vm647OROm/M+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-BCsT-WMiNEKZ4EiRrdz8gw-1; Mon,
 02 Jun 2025 06:52:39 -0400
X-MC-Unique: BCsT-WMiNEKZ4EiRrdz8gw-1
X-Mimecast-MFC-AGG-ID: BCsT-WMiNEKZ4EiRrdz8gw_1748861558
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F1E71800873; Mon,  2 Jun 2025 10:52:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 589FD180047F; Mon,  2 Jun 2025 10:52:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E37E721E66C3; Mon, 02 Jun 2025 12:52:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 05/14] util/error: make func optional
In-Reply-To: <20250530080307.2055502-6-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 30 May 2025 10:02:57 +0200")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-6-pbonzini@redhat.com>
Date: Mon, 02 Jun 2025 12:52:34 +0200
Message-ID: <87v7peiff1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The function name is not available in Rust, so make it optional.
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/error.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/util/error.c b/util/error.c
> index 3449ecc0b92..daea2142f30 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -24,8 +24,13 @@ Error *error_warn;
>  static void error_handle(Error **errp, Error *err)
>  {
>      if (errp == &error_abort) {
> -        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
> -                err->func, err->src_len, err->src, err->line);
> +        if (err->func) {
> +            fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
> +                    err->func, err->src_len, err->src, err->line);
> +        } else {
> +            fprintf(stderr, "Unexpected error at %.*s:%d:\n",
> +		    err->src_len, err->src, err->line);
> +        }
>          error_report("%s", error_get_pretty(err));
>          if (err->hint) {
>              error_printf("%s", err->hint->str);

This changes struct Error member @func from non-null to maybe-null.  An
argument could be made for a comment there.  But since "can this be
null" questions are *everywhere* in C, it would be a rather weak
argument: competent programmers are unlikely to be misled.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


