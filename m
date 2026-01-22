Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEECC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqvq-0004C5-G4; Thu, 22 Jan 2026 04:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viqvj-0004B5-Tu
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viqvh-0007pq-Lp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769073879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwuaBABAuNLZcFhAMKw/NMyW/4spMARCLe3BYjcq00o=;
 b=DYKHqPxSvbFw1absNVe/1bv1jNuWi9J0AWCxcJjMqdz3oYhJoVVSv+8JSsgrnX3GcP0yNI
 HGEKW/44nL5JBnuy3F8WokS+advHbWJ2683V+O7LTz747fSxC9LsOIYJACswlKjmS3oWYH
 IBkWHF8PJfl5BJz+BZQ/bBA/ELfvVU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-lAri8eM-OOuSyY_lSRt3pw-1; Thu, 22 Jan 2026 04:24:37 -0500
X-MC-Unique: lAri8eM-OOuSyY_lSRt3pw-1
X-Mimecast-MFC-AGG-ID: lAri8eM-OOuSyY_lSRt3pw_1769073876
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47fff4fd76dso5733285e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769073876; cv=none;
 d=google.com; s=arc-20240605;
 b=czZ9y7z92JczKrIfuYKg0CQoHjL4AP0DvLsTRkrM+8p/nrxuV0TlQ0baPXa5rsgBGg
 yTBkxDam7eJOZ/LwyF894gUdkbuBz3DY6c4ag96GR7MM2YKj5IgXMxjukmcr992DMjNu
 WAHyPPIjrOMW6DxMoJ4G/xR7FQA9l5NmPOmwOnYeNV+bK8xIOXZ8Zk5yE651QFQItgzH
 XNkuxXEBaApmnK8nYwHHcNWoXkJJWJnQwQorkom+0VpEWsuJU0rBBZljYSxh7J4lZRwD
 6j+sPCkwPqrLSbMgpEy8DOP5mNxzv+z2gyBtdXc4L1Z0mpmttqKaOdpjiItEDdy+H7BS
 PdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hwuaBABAuNLZcFhAMKw/NMyW/4spMARCLe3BYjcq00o=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=R9UbLOZrdq28glaVzFTdgBRYQf7AegPZe3GngGe19UxLemUkRM/OOc7hqOmRd6YpoE
 P/o1erqVaiTNzxrXkfanaPrn4bQXZCMqcOFgucmJ3B3fccbMl0e2kEQTLwUpQrBhBd48
 54Jma+aTaIvc4xGf0WkwdocUy0yuHTJ1ToGaJhuavsnQWWzHVTls/6cnilb0KiGg/Kpx
 P1DPE9ljJ8lYFn1zX6Pt2DwKgFYxg7qvYXf+sR0dyHCz8Nym1HKY9miZ1SERo0mN3xN6
 CbKmcYo9XQwW4c/qEsri9xJoW2iSga0GBjlOygBa9TapFhk5X1eXTb2rvRJIsdlPIlAk
 PY8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769073876; x=1769678676; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hwuaBABAuNLZcFhAMKw/NMyW/4spMARCLe3BYjcq00o=;
 b=KXIdWam6WF6QRD0LTcJD1mTAPD03HFUnpD+WZaPVSuaH2C7zliZ5mN7dSAza+4+p01
 nvX0eHPfr+1u78kQxIE8zz4Y8IzNZkrxRSxhycn+1mO8Fk76dXgyMf0S4RNOJeomBNwG
 qOa1nrGEmRHCMGlajqPFHhEmQ1R8FfOBAwJUvM84Mz1dXQAfJFS8SeFnD/EKMqBvFGdC
 IrxCcOyRxwN+7nmzEqm4LoMb/2wzxapMcqaLUn9fEwyARNaDHx0rSVccNftHwfr8Z+i0
 n47vCQ+LVOijGCu+S4mvsjJYkc/HF0LNIuLkXXzCMuY1gHROxNHt9Mf8yHVHLEpnrms8
 OsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769073876; x=1769678676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwuaBABAuNLZcFhAMKw/NMyW/4spMARCLe3BYjcq00o=;
 b=KNA/KX/TKLjz/nngnBKhTRGYkoJvnu/GdBM52hs3zbNqD5ZnfvyhZJf3HrcJ9Mokku
 HFPTa9ESp1YqGd7gDI0qVgM3KIHiPY7TT/FK8Imr5oaT0F6ZNayW1KgnadxnTX/7y/gN
 sTbTCHqVbXLfJjTJDguDjyUiEfYExSvQ6mpKNc0u19PsBoFjHpo3+YMVz+2GBxXI2d7a
 u4xAAp1n1S1sskNrB3BOOnMn1jcibfNNPdeloi/BraBgFmfa0PR6ZzMHfOk0w2uXtJDg
 x6pc9FnYOaM+dCTJCojXAb2hTYNhvf4cpPuj8Fh247wnrUVnpQ8WXN088q3eAdU5fZjD
 ptXQ==
X-Gm-Message-State: AOJu0YwpHD+oX4BWdQ+gXYIZ1tG0pZCRs6HYuYGl9Sxxfgw/UuaxIYZ+
 2Qke6+NrHNoGBfyiiM+N8llb2Io27by5tHzm0AwENjT+tfXM75/fn7FQM7xeBtr7itlT3aAG3rL
 qRQb1HHTOV3lh7uoQZQ5l4cAPOznW8EOzbbXQflFdebj1XvD3zTERmUZiD4fwvi+oHvpFJl9+Cw
 tQj7C0NvBrqrbzcklMHYiyrCn6/4Mp+Cc=
X-Gm-Gg: AZuq6aIAoAWKzul5pRvvh2M1CbYZGyxlhMWTMKBTurgxRTLluyY7SZlv+6nj/P/Lqhh
 Dg4W5pOU1SUOM+6bT3q9EsX80hAXbMmUj6b1cuemYybyOWQZaxoBjgNPeA+zni+Lja8sr11xial
 /r6a9IetNGyQ86sm6R9GQjOUdQdcXQb7TTPO48XT5918SRbhFPYZk6of6l+IlLwZPgYkVfQMvN8
 /M6RMJapziO+tD4/wCclHI/WIceXobtd9qq6xTaYnLPtKAoo5HFyLlC
X-Received: by 2002:a05:600c:528f:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-4804a4fc5c2mr13942595e9.21.1769073875994; 
 Thu, 22 Jan 2026 01:24:35 -0800 (PST)
X-Received: by 2002:a05:600c:528f:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-4804a4fc5c2mr13942245e9.21.1769073875577; Thu, 22 Jan 2026
 01:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-6-farosas@suse.de>
 <CAE8KmOxNPToj2r__BNGMxm=ckGLwbMD2t6_3h=-KVCQxV8RVxw@mail.gmail.com>
 <874ioelip2.fsf@suse.de>
In-Reply-To: <874ioelip2.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Jan 2026 14:54:17 +0530
X-Gm-Features: AZwV_Qiqm4DA5Wh3dTsmvNKrblXmoTREDbkEJAfbTmoSbar1YQTd0FbGgz2ZSlc
Message-ID: <CAE8KmOwGXSXpmFhLod57R8LE6fPEg0rgbOPki7LQ3FAWnCD3gg@mail.gmail.com>
Subject: Re: [PATCH 5/5] migration/options: Use QAPI_MERGE in
 migrate_params_test_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On Thu, 22 Jan 2026 at 03:41, Fabiano Rosas <farosas@suse.de> wrote:
> See if the following looks better to you. It's not one single function,
> but I folded what I could while keeping the distinct function names.
>
> static void migrate_params_apply(MigrationParameters *new, Error **errp)
> {
>     MigrationState *s = migrate_get_current();
>     MigrationParameters *cur = &s->parameters;
>     MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);
>
>     QAPI_MERGE(MigrationParameters, tmp, new);
>
>     if (!migrate_params_check(tmp, errp)) {
>         return;
>     }
>
>     migrate_ptr_opts_free(cur);
>
>     /* mark all present, so they're all copied */
>     migrate_mark_all_params_present(params);
>     QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>
>     migrate_post_update_params(new, errp);
> }
>
> void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
> {
>     /*
>      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>      * though NULL is cleaner to deal with in C code, that would force
>      * query-migrate-parameters to convert it once more to the empty
>      * string, so avoid that. The migrate_tls_*() helpers that expose
>      * the options to the rest of the migration code already use
>      * return NULL when the empty string is found.
>      */
>     tls_opt_to_str(new->tls_creds);
>     tls_opt_to_str(new->tls_hostname);
>     tls_opt_to_str(new->tls_authz);
>
>     migrate_params_apply(new, errp);
> }
>

* I'm thinking as:
===
v0:

void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
{
    /*
     * Convert QTYPE_QNULL and NULL to the empty string (""). Even
     * though NULL is cleaner to deal with in C code, that would force
     * query-migrate-parameters to convert it once more to the empty
     * string, so avoid that. The migrate_tls_*() helpers that expose
     * the options to the rest of the migration code already use
     * return NULL when the empty string is found.
     */
    tls_opt_to_str(new->tls_creds);
    tls_opt_to_str(new->tls_hostname);
    tls_opt_to_str(new->tls_authz);

    MigrationState *s = migrate_get_current();
    MigrationParameters *cur = &s->parameters;
    MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);

    QAPI_MERGE(MigrationParameters, tmp, new);

    if (!migrate_params_check(tmp, errp)) {
        return;
    }
    migrate_ptr_opts_free(cur);

    /* mark all present, so they're all copied */
    migrate_mark_all_params_present(tpm);
    QAPI_CLONE_MEMBERS(MigrationParameters, cur, tmp);

    migrate_post_update_params(cur, errp);
}
===
v1:

void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
{
    /*
     * Convert QTYPE_QNULL and NULL to the empty string (""). Even
     * though NULL is cleaner to deal with in C code, that would force
     * query-migrate-parameters to convert it once more to the empty
     * string, so avoid that. The migrate_tls_*() helpers that expose
     * the options to the rest of the migration code already use
     * return NULL when the empty string is found.
     */
    tls_opt_to_str(new->tls_creds);
    tls_opt_to_str(new->tls_hostname);
    tls_opt_to_str(new->tls_authz);

    MigrationState *s = migrate_get_current();
    MigrationParameters *cur = &s->parameters;
    MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);      ...[1]

    QAPI_MERGE(MigrationParameters, tmp, new);
                 ...[2]

    if (!migrate_params_check(tmp, errp)) {
        return;
    }
    migrate_ptr_opts_free(cur);

    /* mark all present, so they're all copied */
    migrate_mark_all_params_present(tpm);
    QAPI_CLONE_MEMBERS(MigrationParameters, cur, tmp);
       ...[3]

    /* update MigrationState after parameters change */
                     ...[4]
    if (cur->has_max_bandwidth) {
        if (s->to_dst_file && !migration_in_postcopy()) {
            migration_rate_set(cur->max_bandwidth);
        }
    }
    if (cur->has_x_checkpoint_delay) {
        colo_checkpoint_delay_set();
    }
    if (cur->has_xbzrle_cache_size) {
        xbzrle_cache_resize(cur->xbzrle_cache_size, errp);
    }
    if (cur->has_max_postcopy_bandwidth) {
        if (s->to_dst_file && migration_in_postcopy()) {
            migration_rate_set(cur->max_postcopy_bandwidth);
        }
    }
}
===

* I'd go with v1 above.
* Reasons for folding migrate_params_apply() and migrate_post_update_params():
   - Both static functions are called _only_ from
qmp_migrate_set_parameters(). They are not reusable from elsewhere.
   - Earlier migrate_params_apply() was quite long due to  if...else
conditionals, so it made sense to break one long function into 2-3
smaller ones.
   - Now with QAPI_CLONE/MERGE changes qmp_migrate_set_parameters() is
concise and easy to follow.
   - Reader can see all steps (1,2,3,4 above) together in one function.

* Just sharing my thoughts. You pick what you think is best.

Thank you.
---
  - Prasad


