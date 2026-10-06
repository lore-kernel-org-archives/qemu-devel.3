Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E38CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvK-0002Nk-7i; Wed, 07 Oct 2026 04:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEGQe-0003T2-0M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEGQY-0006U0-Uy
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791336189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJEa8jPcmamv33hE3a4M2pMX+vcATJA0wStqw3Wx1lE=;
 b=Xi4EHmn85HG9f+vzOXzShcuZc2UTJgn7Vhi0zpIGxZl4craU/JzDAx0lgFkeavTXBIhZ9J
 +H5UsOuILwMcnyo4MN6MR02TY2lsAq1gBFoU1MR0xd0exTI5452KB9yCO/C9WCgKWeZ773
 9yS2T0Z/Bks5U11Z9zS9urH38QsgAM0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-7Ux_bHNnPBSkAkDLesAjuw-1; Tue, 06 Oct 2026 10:14:36 -0400
X-MC-Unique: 7Ux_bHNnPBSkAkDLesAjuw-1
X-Mimecast-MFC-AGG-ID: 7Ux_bHNnPBSkAkDLesAjuw_1791296076
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca9b53afaso748371185a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791296076; x=1791900876; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TJEa8jPcmamv33hE3a4M2pMX+vcATJA0wStqw3Wx1lE=;
 b=OuCZzK5E/iVIvAAVS1Thqsq94Q4RxjJWaHlJAUhSuLoMGENFjDAkLdsCSYqH3LdrhL
 36vqulSsJXWP3V4lORBP3ryAykqdK38Ezax2xIjNmgJvvF4d2ggcHTaLYMFG+oIp0/2G
 iEpIibVtyeTolHVxvtlPGahrytCZLpp9AgsYL1MYtOXfW9f0bj0oVE3+w0xr48ZsJliY
 ZpyQCoyHFr2fT1aGuk2hxuSbTXehHqP7wvB2CSMjdhgXljiaS3QIUwczIZQLIir4C7/B
 zfJvbZ5ZRkdIh7K0CZPeZDqX+BoGeh9XgpsNA3K55CIOuQxkhnzbwJLLlJyCA0zMkrHy
 oTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296076; x=1791900876;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJEa8jPcmamv33hE3a4M2pMX+vcATJA0wStqw3Wx1lE=;
 b=VWiHcf6yxwWlPnOemu3z2Z6WAZnTJ0cigDPR0UVI1aGqhs3nwVzKrXwbBxl0VwRK3t
 bQByIIj7mPfjFrNqO8AeG73hWHwVeBcobZpWw4ZwSl7jyn5Krgw2RRsw6K2s9WCZ6g3w
 7wEJ3RcrB7duVSba1z0RfDD79ArKnaYQxlsQstXRY7TkTah2lQ0m8OpL2M423xZgl8Z9
 M5oQg81xLYNKR+/XKvu/hC7FGVspD31dw4oorXrOWcx3e0UkfSFS836yTTaZWA2zzWuu
 8gNz5K/1L50zN8Ek+QsJ8SOn7KLtQR764yLlt71L/tERvYRmyngq7xWxykc6me5Uaomx
 rbEQ==
X-Gm-Message-State: AFuF++k9ESctDUXJLnOpj4ABl9arnMum6fBaPcnucD7q4i1geuXtUEt6
 Ul56YVS3OX4Dyh/yj7O6gNwyspiRp7+jOeM2QtNXqIS/jUBROg/vR5mszmGtMSsfAXClyzYXnbB
 Ky0YQuFlTc6hNRmXqgzeIu4hHDs0INAneCap25PHvP8tn5dqGOr74RV2B
X-Gm-Gg: AYBFou3Q68S0hgSeyQZrfSMWnlmhwonjwh/67v9dly74vRdBVWh6cBB29EDKYAKcqql
 nvy1KDmNa7yFocSKtac/lYZfVLAGEEHZX8cCx09/zt+lyoyxNo51lNb2Fq5G02v+wKoUxbysnud
 q1dp+fFBRsBqJF8Eo+fu2otyBN7uyqanrsaTK+5qdokIgqcV1fVuwvaA8Nm6p+5sUIeCfz2x+8h
 WujCXF16BXL954ggKySX5QfIdcqtB97Zj1F2sEbVbx4defcKpXm9Y9sDT3/p0Apsg4FcGAKhKGo
 c+Jdg0ctlGAtOngc3t+60pzTa1a3SN6pUYBxi/ZMszFPw68oWDJm2Ckkzjn4yU3xohUSZ/E=
X-Received: by 2002:a05:620a:608b:b0:93e:653e:698b with SMTP id
 af79cd13be357-93e8f4fd61fmr292872985a.55.1791296075539; 
 Tue, 06 Oct 2026 07:14:35 -0700 (PDT)
X-Received: by 2002:a05:620a:608b:b0:93e:653e:698b with SMTP id
 af79cd13be357-93e8f4fd61fmr292867285a.55.1791296074941; 
 Tue, 06 Oct 2026 07:14:34 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e4e96acebsm914024085a.21.2026.10.06.07.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:14:33 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:14:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org,
 dongli.zhang@oracle.com, bchaney@akamai.com, den@openvz.org,
 farosas@suse.de, clg@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
Subject: Re: [PATCH v13 16/22] migration: add incoming migration failure
 notifiers
Message-ID: <asUCSERCr0EkHu4j@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
 <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 06, 2026 at 04:58:39PM +0300, Andrey Drobyshev wrote:
> A device may take over a resource from the source in post_load(), e.g.
> vhost-vsock acquires the device ownership on a CPR target.  If the
> incoming migration fails afterwards, there's currently no way for the
> device to give that resource back before the source is told about the
> failure, over the return path or via the MIGRATION event, and resumes,
> or before the target exits.
> 
> Add a notifier list for that, called from the failure path of
> process_incoming_migration_co() before the failure is published.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Should we better reuse migration_state_notifiers[] and introduce
MIG_EVENT_INCOMING_FAILED?

> ---
>  include/migration/misc.h |  7 +++++++
>  migration/migration.c    | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 019717f4cda..08d110750fc 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
>   */
>  void migration_remove_notifier(NotifierWithReturn *notify);
>  
> +/*
> + * Incoming side: @notify is called when an incoming migration fails,
> + * before the target dies or before the source is told about the failure.
> + */
> +void migration_incoming_add_failure_notifier(Notifier *notify);
> +void migration_incoming_remove_failure_notifier(Notifier *notify);
> +
>  void migration_file_set_error(int ret, Error *err);
>  
>  /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
> diff --git a/migration/migration.c b/migration/migration.c
> index fab7949fe11..01e11f91fd9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -71,6 +71,8 @@
>  #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>  
>  static GSList *migration_state_notifiers[MIG_MODE__MAX];
> +static NotifierList incoming_failure_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
>  
>  /* Messages sent on the return path from destination to source */
>  enum mig_rp_message_type {
> @@ -815,6 +817,16 @@ process_incoming_migration_co(void *opaque)
>      goto out;
>  
>  fail:
> +    /*
> +     * Allow the devices which have registered their callbacks for
> +     * migration target failure to undo the changes they may have
> +     * done in post_load().
> +     *
> +     * Do that before the failure is published in any way: the MIGRATION
> +     * event emitted by migrate_set_state() below, the return path (if
> +     * present) in migration_incoming_state_destroy(), or the exit().
> +     */
> +    notifier_list_notify(&incoming_failure_notifiers, NULL);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_error_propagate(s, local_err);
> @@ -1590,6 +1602,16 @@ void migration_add_notifier(NotifierWithReturn *notify,
>      migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
>  }
>  
> +void migration_incoming_add_failure_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&incoming_failure_notifiers, notify);
> +}
> +
> +void migration_incoming_remove_failure_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
>  void migration_remove_notifier(NotifierWithReturn *notify)
>  {
>      if (notify->notify) {
> 
> -- 
> 2.47.1
> 

-- 
Peter Xu


