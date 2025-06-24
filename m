Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F9CC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4lw-0003b1-Jt; Tue, 24 Jun 2025 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4lo-0003S4-7b
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4la-0006kA-0A
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ej/8iUAJNvUG8nPjdFVjNGbZnsOX6O/xBn+ntGAXUA=;
 b=RBiGCqTI2dldjbm7VLKPVAAOx3rre/6b6vx/Ukyoo+iadvrIo3u1RYAodAHCRC6v+zBUtj
 XZ2A/QLogX0e6G0FqH9cQfg24gQNNS0hEaDKdKDi8xnMlblo0kVnmQs/pjKgdZlc/R9Xfk
 LCpzgCZ/H627gvgjfZDBn5JWJ1jVqZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-CsRjbkBGOR6MFtJFWXTgYA-1; Tue, 24 Jun 2025 10:36:43 -0400
X-MC-Unique: CsRjbkBGOR6MFtJFWXTgYA-1
X-Mimecast-MFC-AGG-ID: CsRjbkBGOR6MFtJFWXTgYA_1750775802
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a578958000so2019325f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775802; x=1751380602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ej/8iUAJNvUG8nPjdFVjNGbZnsOX6O/xBn+ntGAXUA=;
 b=xTWzF/PS+wua2lXL29WoVIYZaLxPja+pQiDPK0wB2VM3AYtMR81nYAExbHcK8H1nop
 vo7mz3b2GHx2QRsV3yFF3a7DNDOvVoKzsT3fVLTKE6uZ+3Wbd2U2L++LpBuP4iZYlwLJ
 C0mhIbZW+uQInJ6YbRQkd6IuM4e1ikD8IYx9rKYy1Z+i8hV5WEI0Ae20mdFpLX+V89X9
 s+tFSq+s1TXjwqHwe+z4DbpCVEWlw9zNnxbvYjYx1yAp3HrMLNbX/2gc9YxmHtjOTJBi
 oRBkE+vuV7Jk+NEHVio+MG8XKVURlgtwYlMcEqct9R0k0v84WtFsaKCHBC58Y1Te2EgQ
 KeCw==
X-Gm-Message-State: AOJu0YzYxOxnW3rpzHpuB0+3TmAvynoRUmTyOtpbZSROU2uJh0fFlC3T
 IhblTDk5JRnK8+yJjM61rzhtyNpPCzXpqfufdRldqfL3qxuz1nZ2QVOaHbux4/4lK1ln7kZ2D0s
 oxVyf/lg+AF3G2ASEZlyDALVKGztlHqG8MoPDDCOg1myPXCHvwTIN1fEa
X-Gm-Gg: ASbGncvHOf02Lze7jK9qS/sCniR+RB5sCoibUcAmPmzaed5bMQPp/+k2RRNBNvKQvaG
 CaW/xlrvoiiBuKAg8OCwsf8GBDhKTDnd+8W2ycMGcvT3GBDwIiuUFmSWmMg89yHDN111ReJYhK4
 eTkke3TAxsFy6yBZUVd8f9iSr6LXtJBvYSAsV0xyAZ4N5EgoxW8ePN7wvZWpQymMxas5tlcwt9R
 7hVLX2TYUaumyhKsYZeAB87L1FONb3ktWItQdCAjAPuxOAhNUhnrw5H5Ydm++5E5BSoffdDTqhs
 xz8M3cmM0WA=
X-Received: by 2002:a05:6000:25f3:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a6d129d7f7mr12181866f8f.20.1750775802274; 
 Tue, 24 Jun 2025 07:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrdSvcrJsESQuiShxDxv/+cW9M2IhVfJVN0Pz5jSuK68KBa9tSrzTs+dplQMP5rd8IgeUjA==
X-Received: by 2002:a05:6000:25f3:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a6d129d7f7mr12181845f8f.20.1750775801808; 
 Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45369eae840sm117495385e9.38.2025.06.24.07.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:36:39 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Message-ID: <oo4t2s5rz4uaivfm3vejlum5c7efsjiysbavtt24rinoefs2tk@ihtornpsiz5q>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613140801.474264-7-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Peter,

On 2025-06-13 10:07, Peter Xu wrote:
> Now after merging the precopy and postcopy version of complete() hook,
> rename the precopy version from save_live_complete_precopy() to
> save_complete().
> 
> Dropping the "live" when at it, because it's in most cases not live when
> happening (in precopy).
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h   | 4 ++--
>  hw/ppc/spapr.c                 | 2 +-
>  hw/s390x/s390-stattrib.c       | 2 +-
>  hw/vfio/migration.c            | 2 +-
>  migration/block-dirty-bitmap.c | 2 +-
>  migration/ram.c                | 2 +-
>  migration/savevm.c             | 8 ++++----
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index e022195785..0510534515 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -78,7 +78,7 @@ typedef struct SaveVMHandlers {
>      void (*save_cleanup)(void *opaque);
>  
>      /**
> -     * @save_live_complete_precopy
> +     * @save_complete
>       *
>       * Transmits the last section for the device containing any
>       * remaining data at the end phase of migration.
> @@ -95,7 +95,7 @@ typedef struct SaveVMHandlers {
>       *
>       * Returns zero to indicate success and negative for error
>       */
> -    int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> +    int (*save_complete)(QEMUFile *f, void *opaque);
>  
>      /**
>       * @save_live_complete_precopy_thread (invoked in a separate thread)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 702f774cda..c5d30f2ebd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2518,7 +2518,7 @@ static void htab_save_cleanup(void *opaque)
>  static SaveVMHandlers savevm_htab_handlers = {
>      .save_setup = htab_save_setup,
>      .save_live_iterate = htab_save_iterate,
> -    .save_live_complete_precopy = htab_save_complete,
> +    .save_complete = htab_save_complete,
>      .save_cleanup = htab_save_cleanup,
>      .load_state = htab_load,
>  };
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index f74cf32636..13a678a803 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -338,7 +338,7 @@ static const TypeInfo qemu_s390_stattrib_info = {
>  static SaveVMHandlers savevm_s390_stattrib_handlers = {
>      .save_setup = cmma_save_setup,
>      .save_live_iterate = cmma_save_iterate,
> -    .save_live_complete_precopy = cmma_save_complete,
> +    .save_complete = cmma_save_complete,
>      .state_pending_exact = cmma_state_pending,
>      .state_pending_estimate = cmma_state_pending,
>      .save_cleanup = cmma_save_cleanup,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b76697bd1a..33a71f8999 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -824,7 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>      .state_pending_exact = vfio_state_pending_exact,
>      .is_active_iterate = vfio_is_active_iterate,
>      .save_live_iterate = vfio_save_iterate,
> -    .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_complete = vfio_save_complete_precopy,
>      .save_state = vfio_save_state,
>      .load_setup = vfio_load_setup,
>      .load_cleanup = vfio_load_cleanup,
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 6ee3c32a76..a061aad817 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1248,7 +1248,7 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
>  
>  static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>      .save_setup = dirty_bitmap_save_setup,
> -    .save_live_complete_precopy = dirty_bitmap_save_complete,
> +    .save_complete = dirty_bitmap_save_complete,
>      .has_postcopy = dirty_bitmap_has_postcopy,
>      .state_pending_exact = dirty_bitmap_state_pending,
>      .state_pending_estimate = dirty_bitmap_state_pending,
> diff --git a/migration/ram.c b/migration/ram.c
> index 8b43b9e1e8..ed380ac86f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4545,7 +4545,7 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
>  static SaveVMHandlers savevm_ram_handlers = {
>      .save_setup = ram_save_setup,
>      .save_live_iterate = ram_save_iterate,
> -    .save_live_complete_precopy = ram_save_complete,
> +    .save_complete = ram_save_complete,
>      .has_postcopy = ram_has_postcopy,
>      .state_pending_exact = ram_state_pending_exact,
>      .state_pending_estimate = ram_state_pending_estimate,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3e20f8608a..454e914b56 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1496,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      int ret;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->save_live_complete_precopy) {
> +        if (!se->ops || !se->ops->save_complete) {
>              continue;
>          }
>          if (se->ops->is_active) {
> @@ -1509,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>          qemu_put_byte(f, QEMU_VM_SECTION_END);
>          qemu_put_be32(f, se->section_id);
>  
> -        ret = se->ops->save_live_complete_precopy(f, se->opaque);
> +        ret = se->ops->save_complete(f, se->opaque);
>          trace_savevm_section_end(se->idstr, se->section_id, ret);
>          save_section_footer(f, se);
>          if (ret < 0) {
> @@ -1583,7 +1583,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>          if (!se->ops ||
>              (in_postcopy && se->ops->has_postcopy &&
>               se->ops->has_postcopy(se->opaque)) ||
> -            !se->ops->save_live_complete_precopy) {
> +            !se->ops->save_complete) {
>              continue;
>          }
>  
> @@ -1598,7 +1598,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>  
>          save_section_header(f, se, QEMU_VM_SECTION_END);
>  
> -        ret = se->ops->save_live_complete_precopy(f, se->opaque);
> +        ret = se->ops->save_complete(f, se->opaque);
>          trace_savevm_section_end(se->idstr, se->section_id, ret);
>          save_section_footer(f, se);
>          if (ret < 0) {
> -- 
> 2.49.0
> 

There are still mentions of 'save_live_complete_precopy' in:

    include/migration/register.h:100
        * parallel with @save_live_complete_precopy handlers.
    docs/devel/migration/vfio.rst:78
        * A ``save_live_complete_precopy`` function that sets the VFIO device in
    docs/devel/migration/vfio.rst:198
        .save_live_complete_precopy() is called for each active device
    docs/devel/migration/vfio.rst:200
        .save_live_complete_precopy() until
    docs/devel/migration/main.rst:511
        - A ``save_live_complete_precopy`` function that must transmit the

Also, should we also drop "live" from
'save_live_complete_precopy_thread' as well? IIUC they are called
together with (now) 'save_complete()' during precopy.


Best regards

Juraj Marcin


