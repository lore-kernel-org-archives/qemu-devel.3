Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A6FCA5FEF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 06:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhivH-00082f-2E; Mon, 19 Jan 2026 01:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhivE-00080s-Ue
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 01:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhivC-0004F8-UL
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 01:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768804769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=0kVb8YfrJWNArcdK5tvNG5PDCxF5rPAW/7RbW0BoDjU=;
 b=LOi1Xu3zsjmJyf1PdD2iDcTNUwW7q9H3zqwt1hIvpFEIccujFvnHBtqjiEYiY/30CVPlk2
 700sFg2wppGgGummp6DJn1Yklat9Btg5CV8j6IhBbNhAzquZJxSjlwW4IoFhVrihjCZkTd
 yWlcn6IJ81w98NEGvoUKlpv0Clgl1U8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-iKk-ZXWePDGtqYV_mOqP4w-1; Mon,
 19 Jan 2026 01:39:25 -0500
X-MC-Unique: iKk-ZXWePDGtqYV_mOqP4w-1
X-Mimecast-MFC-AGG-ID: iKk-ZXWePDGtqYV_mOqP4w_1768804764
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7669C1956050; Mon, 19 Jan 2026 06:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 476351955F22; Mon, 19 Jan 2026 06:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C584F21E692D; Mon, 19 Jan 2026 07:39:19 +0100 (CET)
Resent-To: philmd@linaro.org, qemu-devel@nongnu.org,
 d-tatianin@yandex-team.ru, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Jan 2026 07:39:19 +0100
Resent-Message-ID: <87zf6ap0mg.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 berrange@redhat.com,  yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org,  philmd@linaro.org
Subject: Re: [PATCH v2 2/3] error-report: make real_time_iso8601() public
In-Reply-To: <20251204202653.597319-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 4 Dec 2025 23:26:47 +0300")
References: <20251204202653.597319-1-vsementsov@yandex-team.ru>
 <20251204202653.597319-3-vsementsov@yandex-team.ru>
Date: Mon, 19 Jan 2026 06:52:29 +0100
Message-ID: <875x8yqhcy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> To be reused in the following commit.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qemu/error-report.h | 6 ++++++
>  util/error-report.c         | 3 +--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index 3ae2357fda..bcd542a118 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -74,4 +74,10 @@ extern bool message_with_timestamp;
>  extern bool error_with_guestname;
>  extern const char *error_guest_name;
>  
> +/*
> + * Returns current datetime in ISO 8601 format.

Imperative mood, please: Return current ...

> + * Caller is responsible to g_free() the returned string.
> + */
> +char *real_time_iso8601(void);
> +
>  #endif
> diff --git a/util/error-report.c b/util/error-report.c
> index 1b17c11de1..d6b7448183 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -169,8 +169,7 @@ static void print_loc(void)
>      }
>  }
>  
> -static char *
> -real_time_iso8601(void)
> +char *real_time_iso8601(void)
>  {
>      g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>      return g_date_time_format_iso8601(dt);

With the comment tweak:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


