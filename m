Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8678ECD9A9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7eU-0001Lb-9K; Thu, 05 Feb 2026 17:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7eS-0001LE-2v
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7eP-000229-NN
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770329796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4Qa3vrhFhv/ykotU86lonQv68hPh1Fw92b15rdGQaM=;
 b=a5yCHvFUi0hhNdWXc6FoBrLyuU/JqlljXwcnvDbhirZnYfu45rUZSt31hMylg3H7fM10GE
 urDBtdbbCrAGpNFqxxRuFK2DApNlR+XlipSPbdQMkL6+RIz7jUD2DIiX/htpucIvYuijR5
 WrDJS7OMRxwvj6c3jCpdZYM7Che1Q6A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-jSfwtMpjPMOhhqr6Tb7wTw-1; Thu, 05 Feb 2026 17:16:35 -0500
X-MC-Unique: jSfwtMpjPMOhhqr6Tb7wTw-1
X-Mimecast-MFC-AGG-ID: jSfwtMpjPMOhhqr6Tb7wTw_1770329795
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5014c472ad5so42520841cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770329795; x=1770934595; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I4Qa3vrhFhv/ykotU86lonQv68hPh1Fw92b15rdGQaM=;
 b=GLHB+M/WdFjKVh5kJcUm4Z/kAmnI62mil3ibUtjd1gKai5CWQKboJHIn8FEy+WCoUA
 Eayq/6Q0bT82S3aA4e628J9s0xL+SkhU5aGi+Jh+NTvBL5VsQy4V5/ksB0tGopvO+qFz
 oPHzsamiHfPd8hGHotsBUSoPM32o2SLjvErpLEz0BN5E4F4/cPX3rSo4NMqejzYTVEm6
 YigrsY975cOjD0Nbc6iHrt0o22DqvOdvmqFqC5hNL/NpmYYjyFabKZEWoALefGvrLXPr
 6VKn2NFx/bCRIoS0QIqCux8YCrNdfZeyRXO81DrnYDrUhZVvKDp2xN5YCzKKpg4PwdD4
 +GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329795; x=1770934595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4Qa3vrhFhv/ykotU86lonQv68hPh1Fw92b15rdGQaM=;
 b=hEyOnM1T4lf4IQcrQBKmaeFVs3GD+o9aBILRNZxSforQiRQ87LmWT4b2fUGKdjOjoA
 DQJ46gtPMAzmHtIn7yxnCoK7MkrSobUxnnQGqMvG8XejqaOCqdxCweegfqyHInqOupan
 5vudqo39Ga7r0gqEObbARXUYwHCLVynR8aeWMG3J4GpTgrVcsQFnCNxD8fN2xsF4PTJh
 U3PbDDu7d15gJLgecENH0Ju2YFG1jNEKHZGaKoZ1RTyRb1/mtgnyM4y1WloiXkeFdM/O
 8wAbr33fzRbFgoePQTzji7Vk5gvKKwQGIDkptDUl2rnZLP3PhWPAJHx8T2tmiFwCukGi
 9hMg==
X-Gm-Message-State: AOJu0YxlssjxOjGqT7zD4XGrq7czKETkahE8ueveeD2mz2+/hN8qrilp
 H8lRZINjDwEAZ0I58ZcfSB2UHWqNfHdHtmdXuPqftvLIk7HJoN2vQhjhSjKS9DAALVsi40YE6hj
 7o8ElfvI8dpHGrp33c/DFsWYuFDnLBYlQRP2PxA361WLGyGHEAjUd8lB2
X-Gm-Gg: AZuq6aKWPl0DlrJydOC/LQEZRbNBqx35heorBPCN9eYxDnBp2/jYAlv1rDT4SFV/04p
 JUHv2ShJnJi1iRC0pokImf/SeGxS0+d0SyyxAyRTngDoDukZ3FThutl3FZZ6vkOB5cWUxu3A+L7
 0Xp3A2pXL6w1I1V9rvA3vGfizWToPB1A5zYQd0VcMgWZjTsyAcwX6XuOkN/C5sTfkaUAgXpqE8k
 FTjaJLoiDLVLXaqORARbtbVPpKs0Wy266tj7juFiNz3AUwtD6u9o4fFNlKZwAeNThUZ1q5/Fq0h
 uU+K+914WQmqTbfg2zcicUQtwEy5JqXFS/8oTRWZElvS51cUBcuMrPeaxmycSsR23Sogs6B2oPo
 QXCU=
X-Received: by 2002:a05:622a:1a99:b0:506:2041:13db with SMTP id
 d75a77b69052e-5063995498bmr9407961cf.49.1770329794884; 
 Thu, 05 Feb 2026 14:16:34 -0800 (PST)
X-Received: by 2002:a05:622a:1a99:b0:506:2041:13db with SMTP id
 d75a77b69052e-5063995498bmr9407701cf.49.1770329794459; 
 Thu, 05 Feb 2026 14:16:34 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c059cf6sm5007486d6.44.2026.02.05.14.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:16:34 -0800 (PST)
Date: Thu, 5 Feb 2026 17:16:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 8/9] migration/options: Stop freeing s->parameters
 members individually
Message-ID: <aYUWwSxnsWn1Dfu0@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 02, 2026 at 07:41:00PM -0300, Fabiano Rosas wrote:
> Expecting every pointer member from s->parameters to be freed
> individually is prone to leave some fields forgotten when the code is
> eventually updated. Use a dealloc visitor to free them all at once.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 733aae51a8..cc5a66750c 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1002,11 +1002,21 @@ AnnounceParameters *migrate_announce_params(void)
>      return &ap;
>  }
>  
> -static void migrate_tls_opts_free(MigrationParameters *params)
> +static bool migrate_params_free(MigrationParameters *params, Error **errp)
>  {
> -    qapi_free_StrOrNull(params->tls_creds);
> -    qapi_free_StrOrNull(params->tls_hostname);
> -    qapi_free_StrOrNull(params->tls_authz);
> +    Visitor *v = qapi_dealloc_visitor_new();
> +    bool ret;
> +
> +    /*
> +     * qapi_free_MigrationParameters can't be used here because
> +     * MigrationParameters is embedded in MigrationState due to qdev
> +     * needing to access the offset of the migration properties inside
> +     * the migration object.
> +     */

Ohhhhhhhh.... thanks for the comment!

Reviewed-by: Peter Xu <peterx@redhat.com>

> +    ret = visit_type_MigrationParameters_members(v, params, errp);
> +    visit_free(v);
> +
> +    return ret;
>  }

-- 
Peter Xu


