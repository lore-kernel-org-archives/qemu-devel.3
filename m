Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E586D0C5EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GAG-0007DV-Lz; Fri, 25 Oct 2024 04:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4GAE-0007Cu-Ae
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4GAC-0006Xb-BZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729846759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QvPSRR4yENVJsjkYB34uVGiHBX+cugnnBBgis9vYV+c=;
 b=huLmiNhhDruxeglWCLqounIh02Duwucg7zpqIlvOxQd8AIk0DZDCo2T1yz4QcZZL2sIq6O
 GE22hsh37RDFJDeWeJizVx4U7r9R9lwxBao0aGhnXtZdxkRAn6tO27RDrZKCnuBDYTOdWn
 48bouB8pqLSy23JuSuTcaC1Fzyb2bPc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-tKD487uXPsOKiGtCORu38g-1; Fri, 25 Oct 2024 04:59:17 -0400
X-MC-Unique: tKD487uXPsOKiGtCORu38g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so13142485e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 01:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729846756; x=1730451556;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvPSRR4yENVJsjkYB34uVGiHBX+cugnnBBgis9vYV+c=;
 b=McnvW007s8Rdpgl3SQFdgh92Ii5YzwfhVzAzdEjWWw/jIQxs2RUP2BUuaGEjCT0B+o
 mNAl59yRQLO+VycmMEgEuFQAHghuSf6TQrt2Q7Z2n16DUYMgkDDu6PSDd8+ZA46f/qHC
 sJOk3BW71KkbgIW6Wo4p9uQFObRTDzQ/eWw7WflVabN5Xmw5ajKNvOhSK95cMfXhC+Ly
 iK7OC6qJDoH43C42kouQuOiUUQVZGphGczQB0V3zYASmMLEbni9KN+f409ag3yJcXp6G
 +2oPQgWEpxtshzMsblm2pJFgRVeLuDiv5dkBFtewTgZOzH20ICda6i6l8pw6KHhLrbIr
 5rxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcJDTMHVnHpm2tXg8rfwlwbyM0S+HcTf2SlSYG8Hyp66Rqmdobi+3axqflyH66eoLEBch7FL3lM2jq@nongnu.org
X-Gm-Message-State: AOJu0Yy9eEM2S0o2AjjUPw/j15jO6qp9mzM2oU/byhGSa3IumyUog7vL
 2XT9hbouaETeBCUkCaDXsfZ/s0NCjbD8TwXH8BM7LvmGOMYuiFYw+J7edTY/uGtszJ1xoKyO73u
 dzqlZ2m3oRSZGP6OMhL2+80FQH7pa5oJilNFXlR4qv7Wn+MGd1Ot0
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr79623455e9.29.1729846756421; 
 Fri, 25 Oct 2024 01:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0+VZ+aMI3Ko06MLzz2mqX/0dM9Pnh8TeKFBjyD+B3m22fIwx/xkGn0tRc0V4FdWjQYtRrHQ==
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr79623295e9.29.1729846756047; 
 Fri, 25 Oct 2024 01:59:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b48231sm990384f8f.58.2024.10.25.01.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 01:59:15 -0700 (PDT)
Message-ID: <a2f5e613-ba2b-4f54-bd5f-8ecd10220e36@redhat.com>
Date: Fri, 25 Oct 2024 10:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] migration: Drop migration_is_setup_or_active()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-5-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241024213056.1395400-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/24/24 23:30, Peter Xu wrote:
> This helper is mostly the same as migration_is_running(), except that one
> has COLO reported as true, the other has CANCELLING reported as true.
> 
> Per my past years experience on the state changes, none of them should
> matter.
> 
> To make it slightly safer, report both COLO || CANCELLING to be true in
> migration_is_running(), then drop the other one.  We kept the 1st only
> because the name is simpler, and clear enough.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

It is preferable to reduce the API of the core migration subsystem.

Looks safe for vfio.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/misc.h |  4 ++--
>   hw/vfio/common.c         |  2 +-
>   migration/migration.c    | 35 +++--------------------------------
>   migration/ram.c          |  5 ++---
>   net/vhost-vdpa.c         |  3 +--
>   5 files changed, 9 insertions(+), 40 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index e8490e3af5..86ef160f19 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -52,11 +52,12 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>   /* migration/migration.c */
>   void migration_object_init(void);
>   void migration_shutdown(void);
> +
>   bool migration_is_idle(void);
>   bool migration_is_active(void);
>   bool migration_is_device(void);
> +bool migration_is_running(void);
>   bool migration_thread_is_self(void);
> -bool migration_is_setup_or_active(void);
>   
>   typedef enum MigrationEventType {
>       MIG_EVENT_PRECOPY_SETUP,
> @@ -95,7 +96,6 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
>                                    MigrationNotifyFunc func, MigMode mode);
>   
>   void migration_remove_notifier(NotifierWithReturn *notify);
> -bool migration_is_running(void);
>   void migration_file_set_error(int ret, Error *err);
>   
>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 36d0cf6585..dcef44fe55 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -149,7 +149,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>   
>   static void vfio_set_migration_error(int ret)
>   {
> -    if (migration_is_setup_or_active()) {
> +    if (migration_is_running()) {
>           migration_file_set_error(ret, NULL);
>       }
>   }
> diff --git a/migration/migration.c b/migration/migration.c
> index e82ffa8cf3..3365195def 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1116,33 +1116,6 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
>       migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
>   }
>   
> -/*
> - * Return true if we're already in the middle of a migration
> - * (i.e. any of the active or setup states)
> - */
> -bool migration_is_setup_or_active(void)
> -{
> -    MigrationState *s = current_migration;
> -
> -    switch (s->state) {
> -    case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> -    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> -    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> -    case MIGRATION_STATUS_POSTCOPY_RECOVER:
> -    case MIGRATION_STATUS_SETUP:
> -    case MIGRATION_STATUS_PRE_SWITCHOVER:
> -    case MIGRATION_STATUS_DEVICE:
> -    case MIGRATION_STATUS_WAIT_UNPLUG:
> -    case MIGRATION_STATUS_COLO:
> -        return true;
> -
> -    default:
> -        return false;
> -
> -    }
> -}
> -
>   bool migration_is_running(void)
>   {
>       MigrationState *s = current_migration;
> @@ -1158,11 +1131,10 @@ bool migration_is_running(void)
>       case MIGRATION_STATUS_DEVICE:
>       case MIGRATION_STATUS_WAIT_UNPLUG:
>       case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_COLO:
>           return true;
> -
>       default:
>           return false;
> -
>       }
>   }
>   
> @@ -1661,8 +1633,7 @@ bool migration_incoming_postcopy_advised(void)
>   
>   bool migration_in_bg_snapshot(void)
>   {
> -    return migrate_background_snapshot() &&
> -           migration_is_setup_or_active();
> +    return migrate_background_snapshot() && migration_is_running();
>   }
>   
>   bool migration_is_idle(void)
> @@ -2335,7 +2306,7 @@ static void *source_return_path_thread(void *opaque)
>       trace_source_return_path_thread_entry();
>       rcu_register_thread();
>   
> -    while (migration_is_setup_or_active()) {
> +    while (migration_is_running()) {
>           trace_source_return_path_thread_loop_top();
>   
>           header_type = qemu_get_be16(rp);
> diff --git a/migration/ram.c b/migration/ram.c
> index d284f63854..5646a0b882 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2860,7 +2860,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>       size_t used_len, start, npages;
>   
>       /* This function is currently expected to be used during live migration */
> -    if (!migration_is_setup_or_active()) {
> +    if (!migration_is_running()) {
>           return;
>       }
>   
> @@ -3208,8 +3208,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>       }
>   
>   out:
> -    if (ret >= 0
> -        && migration_is_setup_or_active()) {
> +    if (ret >= 0 && migration_is_running()) {
>           if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
>               !migrate_mapped_ram()) {
>               ret = multifd_ram_flush_and_sync();
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 46b02c50be..231b45246c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -375,8 +375,7 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
>   
>       assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>   
> -    if (s->always_svq ||
> -        migration_is_setup_or_active()) {
> +    if (s->always_svq || migration_is_running()) {
>           v->shadow_vqs_enabled = true;
>       } else {
>           v->shadow_vqs_enabled = false;


