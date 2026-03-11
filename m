Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC191049517
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0FwF-00076B-SD; Wed, 11 Mar 2026 05:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0Fw4-00075b-Sh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0Fw2-0002wT-3A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773221576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tO5ebZ+W9EIXTBzAhhJFyTUCTD/xNG3yyeK7/htFLd8=;
 b=iIlXLrq6oUX9AeNz/m38UF8PBPtjzRdjDCyu+QzgBqwIUZ6RykQe19/r00J6AL9nrvpCt3
 9qJUkHczaeON48L2m1kEH2I5+soL73ih2MfoLYlodMmBmBV2Dx/IXM8WxTovhL3F40qbT+
 aw8A8MmTFT0yP3KwerwTuyWBKxsn1Dk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-lAB8---UPZG6I0qj6bhY4Q-1; Wed, 11 Mar 2026 05:32:53 -0400
X-MC-Unique: lAB8---UPZG6I0qj6bhY4Q-1
X-Mimecast-MFC-AGG-ID: lAB8---UPZG6I0qj6bhY4Q_1773221572
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso36122885e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773221572; cv=none;
 d=google.com; s=arc-20240605;
 b=XhqFmdDby4fsIOSbeGODttBQFltHf/Ijt5D9oxnWxz/igR0wcfY4hRFodADtwTRJNb
 pjIzIkFzPcDs1sSWHgXGy+t8C+MSdSp4xs1+zGappTuw8EmDcop0obIN75xDSdYTNaJa
 hIQPuu8DuRXhIb1o4Bu/vkJ0TtuPbfkVJFAJytoI16arUY3fyDl1UEHjuyHl+ACBcYgp
 P3vsAcpHRrDhcGTanDNCtfyrBeQJU0drrdqSXbxJp7uH4GQM8ywx9MfYIXhWl+A1XOrt
 zqPmwlkgPS4du0IoVmr4dtJKBcIS1fkfswIWVkyIs3wljJP/VrfnxLJaqVJwbuggWxVm
 H+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tO5ebZ+W9EIXTBzAhhJFyTUCTD/xNG3yyeK7/htFLd8=;
 fh=RW0RVLDdQeqQlxtaU3ic8OVNUMYHPuvD990bp89s7so=;
 b=aEfWevyPJzNqIgDUza35S7xcX1zEgnec/mePMYzOtUOBgnqVje1p1KTtzo2U66JOdW
 SEFrbd9MHviqiMkEWb/WeqKDqT67Mej6sfpqUQae48yP0LOh8rwWEHIe+7wrL338NpsI
 4Fr6vAduWG2IvoJ/q0R+Aqo4s/rguT9EnQwxZEzSt/CO8PKb3jHJaSCSIwZs3fdprW45
 SCpR5oa1eOStwuDbBJNMvIn1tJalMOlSyOK1eLfWdpjTRKdkRHTWNkJ6LomuCwTwUUaq
 KLKsJss4tx6ZZwnoHGGUG1ei3l37n0jlEVs25Uog3BpdMri4z4WaFT3DvTAqfWBGtVdn
 kIeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773221572; x=1773826372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tO5ebZ+W9EIXTBzAhhJFyTUCTD/xNG3yyeK7/htFLd8=;
 b=EWLaF0LeVVK+us5uoEFpE6BvAaUWqQF0D2hWeGrJz6qMU2QGtFiaakOfShd9Mvl9/1
 hpOGuAv4Uk6D6M7jtfld62R6GnOpDhe8RRF9hp4zbTf37WV9LxV1zPMwy8pF8GGkgQtn
 HE/lpW7Ayl8LcVVRMkeGgO2CM46STzypBMmk478yT10K4PAyNMfwavFRiXFlpdg5P3hs
 BuwFWFsUT43WBKDtNGoQwqdHYPA19wFabcP+nu8UHaegSEjKypnfhltk7TGBg5HD8fe6
 KKrTQEWD7H/Wj+EfG/LC6CTTbN48fPYAibzv5nuOQNw93LIzF4n16L3b7M8lfT5xCEbm
 5wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773221572; x=1773826372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO5ebZ+W9EIXTBzAhhJFyTUCTD/xNG3yyeK7/htFLd8=;
 b=qA/4pyc8Ew7Ywzcwfciglydxuc6NC3TjsVDIhMQ80BcoDuMkpUPMkXUxVoGV0WPCbe
 l5vNgXSgflGBb37A0eaouuy/BDiCSSv8xMPUC/DJ5iOEzrStMPZiOiw1UmGwDX48AvwK
 vB5MLl2a7PlU/71Ja5GiU0pJn474+QGQTBg9DtnM2tqDeFLbCI3YJ18CbjVh92Ej7UIv
 YPyu75ws85rsIurQ8isaH8NxTJuQb9moJr0kBW+X7LQF9ZdrGG/FSbVyyx/KR247JSvW
 9DC81or6tYq0hWJMVqenGuSL+x47wj4FN9wgRSXSuhdoIzoN4vzI1kalg1wPklhdI6KW
 dtHQ==
X-Gm-Message-State: AOJu0Yy0TtYPr2ZA7ktJM+7LyCWNJ/3hOMdz69OaBXZqezMYD1WkyLF/
 xHGrgHR7GHu0WcGB1eQxd5fML0Ig7uj7C2T7A9rAvfpUHJAx+nPDAfqXcFTWHhjZZnw9QmVH3tG
 72DS3feX3YKk2cWL3Yo6HCMInvF+bfctGMGgmG9iBBFf7t/MH3LIfIE1OW2t/X816v6kS+Mf0AZ
 h8uYB3UpRFjbC8HBg7sRvRY+faE28gq4A=
X-Gm-Gg: ATEYQzx2Dzr+n+DWQoxxJJ49kF8Sx1Y8IHmym6RJi1cmDh9gS8tZn9Pb/YDcpX9OpAE
 JgTqHu/iUiLiIePq/HrpPZCGsMGnXWwLU8bbVQUbLcAAn0JCS7hdsaJd3Ne030U9l/njcbe5WbT
 xhR//yBreryyh5c1j+MzsERhg0BRRISfg9TXrEluM5Qgb4aJjsDZmUK6XY3HdAW3z96Xd8KgDqV
 Ox8Wl+l60NhCzLMtWW1gTrtO3AbJCt0fm9wGIFweHf9UxghX8JzG558dL+4tqQaTvy8
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id
 5b1f17b1804b1-4854b111768mr29688015e9.27.1773221571966; 
 Wed, 11 Mar 2026 02:32:51 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id
 5b1f17b1804b1-4854b111768mr29687595e9.27.1773221571425; Wed, 11 Mar 2026
 02:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-8-farosas@suse.de>
In-Reply-To: <20260310135540.8679-8-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Mar 2026 15:02:34 +0530
X-Gm-Features: AaiRm51GDIcqMRuS7k9ubvsQnvStJMjuJj5ivF_yqv52MndAfzcJWHiqNmit5kA
Message-ID: <CAE8KmOy-KAkJh6kLSWP32ck7KT_U=zJ=11nAQ-d=FVLMsH3ArA@mail.gmail.com>
Subject: Re: [PATCH 8/8] migration/multifd: Fix leaks of TLS error objects
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 10 Mar 2026 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
> The code currently ignores errors from multifd threads that happen
> after a first error has already been propagated. Make sure the
> subsequent errors are freed appopriately.
>
> This fixes a leak of the TLS session->werr when the certificate
> validation fails after multifd threads are already running. The first
> writes on the threads will fail deep into the gnutls stack.
>
> No need to check if(err) because the callers are all under a similar
> check.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 8b9ed84805..035cb70f7b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -412,28 +412,25 @@ bool multifd_send(MultiFDSendData **send_data)
>  /* Multifd send side hit an error; remember it and prepare to quit */
>  static void multifd_send_error_propagate(Error *err)
>  {
> +    MigrationState *s = migrate_get_current();
> +
>      /*
> -     * We don't want to exit each threads twice.  Depending on where
> -     * we get the error, or if there are two independent errors in two
> -     * threads at the same time, we can end calling this function
> -     * twice.
> +     * There may be independent errors in each thread. Propagate the
> +     * first and free the subsequent ones.
>       */
>      if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
> +        error_free(err);
>          return;
>      }
>
> -    if (err) {
> -        MigrationState *s = migrate_get_current();
> +    migrate_error_propagate(s, err);
>
> -        migrate_error_propagate(s, err);
> -
> -        if (s->state == MIGRATION_STATUS_SETUP ||
> -            s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
> -            s->state == MIGRATION_STATUS_DEVICE ||
> -            s->state == MIGRATION_STATUS_ACTIVE) {
> -            migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILING);
> -        }
> +    if (s->state == MIGRATION_STATUS_SETUP ||
> +        s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
> +        s->state == MIGRATION_STATUS_DEVICE ||
> +        s->state == MIGRATION_STATUS_ACTIVE) {
> +        migrate_set_state(&s->state, s->state,
> +                          MIGRATION_STATUS_FAILING);
>      }
>  }


* Look okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


