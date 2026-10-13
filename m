Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8DBCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbOJ-0008Rn-Uc; Tue, 13 Oct 2026 08:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGbOG-0008RY-SF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGbOE-0003oH-Oo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791893633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnA2r3ZOKz8dZvZb240KCGQCCGF9ukjEstgsGQtTy9U=;
 b=gJ8qKq0ran9F3UTLS+wq9I5PST92P2LWT7sVT4vNB8vY62kFPdYTYPfp60LaCq0vPdD7Hr
 Va43k0cJJjtXdMmgXipBm2BTOVkH7K9NTXpKBjZ/bf1ebpFU/FmuHn8WtzZniGt/Im2FyS
 8SA+/+QPMaVTMg5XaJmtCere/+A3ziQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ibTtSf6nPWSdYyvFASbLuQ-1; Tue, 13 Oct 2026 12:13:52 +0000
X-MC-Unique: ibTtSf6nPWSdYyvFASbLuQ-1
X-Mimecast-MFC-AGG-ID: ibTtSf6nPWSdYyvFASbLuQ_1791893631
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48afe67dfc2so3045817f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791893631; x=1792498431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MnA2r3ZOKz8dZvZb240KCGQCCGF9ukjEstgsGQtTy9U=;
 b=J9NnieTdLPQk7bwlTgVsN2n69tXO2us+anHODQxJjn/qSWgtPkvGleEoz8CTbGCnKu
 A4TQT1GeUb9ZiR/nhtMoJbyZCut95uOMHA546yhnCwBygEndKX5FCyztrZ4RaY6mynsj
 QQESYNjdvEraAKHGTrbAhk3rMVGkbDoPercnhDK6tl7QxG4AwQ4qzhLrBMaLb/vmxqbh
 Vd6j1HAiihiMAUfX0G6Cl0ao0EmiFw+YSZbsRpAzH8KI6IQHkUAQRsVWBMbiTQhevtAu
 xWv9YjzhIfFbKA07sazQmR1SEfYC3/1OU9L97DzaeDAfA0gOBL2TzcmLm3IF0Mqq8tF9
 1lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893631; x=1792498431;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MnA2r3ZOKz8dZvZb240KCGQCCGF9ukjEstgsGQtTy9U=;
 b=rN+wccBnwSsO2X1NnfL5/VYwzahftqcTx8/Ol17gRypp0rJ8waVnj5A3hqtwlA1+pt
 3fQfJbIBwE0J0+EEoY9xuo5O56eMTUNbI1v7a04rSkk5rfhlwpcIoYbF0cQ8qM1jNvsR
 snUPtgp6hlm8X1p1YYCQNx1M7jAJIqUzUWCcgZwlYTHQ2pM5PoIY7guvWa9oVz0Gx4Dk
 eu5tOildFtY35gjdlko31EcXPTcjTOgfDK/sZqScy05Ll+79nKKfkifMnIQhj44v7Ljk
 kPGq5Gy6gK4S0/tYe1GAMElffXW6HZVsagf8P7nqEhK9tfWoX+std4cWd6SfA5ePlpeu
 Iwmw==
X-Gm-Message-State: AFq9FYINbQdiAHbU9b8J5sg0lzGqkAsGw/HXesowOXhTtOrawK65kyIt
 pFGpjhGtKuIaHELuxR+PXqI+XUVUyYtVSo5A/zMjwpftaxC3SLNPQ60d/J4XMVB3GZFHO85QWMv
 sJz3dF6n7zqwUeIw03ft5N25Fn4Lc1TzuU7fQSi9E2Odp7LgoUVNn1O4U
X-Gm-Gg: AYBFou1irF3ZeZCrW4+WWljJi4E57BNYhCs/TpgU4eN1kgIWXfZhRuLNzxb7VXHfY86
 taFDkRwKbRRC+gIuIEYG7XxOJDi8Sv//ovztTf5sH7NxcRFV+ZaJ8KOb2EMZ/UWZUZNG4Hy1prI
 GlShpEcmw6eLgHAQuE/f/7hi9bfqxhCcGeisoXYQUZfXGxBMd8FgL38A3wWHJwSZQaw2LJBz+1J
 3JrPXBlOfA0OLIGuUs2MvBjKF1k/NdejFCUeOxP2FsLk+FJeV8fNzmw/dN0uP6i3w+rkJ81ebao
 IK7EcUl1zHtEhV1BG7Vn9mYd4rghKNTj0/BWh6MLtO1BZ/4fEjewG/AmHgx90VYdCcSlEcXlPP7
 FdlpYmBL2huj7qa23SRoVSlG2LVUSuQzfGw5SrUc6
X-Received: by 2002:a05:600c:5254:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a18e4aa11dmr251301245e9.16.1791893630440; 
 Tue, 13 Oct 2026 05:13:50 -0700 (PDT)
X-Received: by 2002:a05:600c:5254:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a18e4aa11dmr251296745e9.16.1791893626462; 
 Tue, 13 Oct 2026 05:13:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm657781905e9.9.2026.10.13.05.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 05:13:45 -0700 (PDT)
Message-ID: <19371f4d-c39d-4d13-a19d-e0fd3e2c658f@redhat.com>
Date: Tue, 13 Oct 2026 14:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Don't reset a device on a declined
 stop transition
To: Pankaj Kumar <pshit@nvidia.com>, alex@shazbot.org
Cc: qemu-devel@nongnu.org, pmohite@nvidia.com, dnigam@nvidia.com,
 avihaih@nvidia.com, alwilliamson@nvidia.com, smitra@nvidia.com,
 kwankhede@nvidia.com, vkale@nvidia.com, targupta@nvidia.com
References: <20261008024329.1996536-1-pshit@nvidia.com>
 <20261013044520.2439021-1-pshit@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261013044520.2439021-1-pshit@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/13/26 06:45, Pankaj Kumar wrote:
> QEMU resets a VFIO device whenever a migration state transition it requests
> fails. This is done by vfio_migration_set_state_or_reset(), which passes
> VFIO_DEVICE_STATE_ERROR as the recover state, forcing an immediate
> VFIO_DEVICE_RESET.
> 
> However, a device may legitimately decline a state transition, e.g. a vGPU
> that refuses to stop while a profiling/debug session is active in the guest.
> Such a device is still healthy and running the guest, so resetting it destroys
> a perfectly good VM.
> 
> Instead of resetting on a declined stop, recover the device to its current
> state. The current device state is always a valid, already-reached state, so
> recovering to it is effectively a no-op transition that cannot itself fail and
> trigger a reset.
> 
> Introduce a helper, vfio_migration_set_state_or_recover(), that selects the
> recover state based on the transition direction, and route the vmstate change
> and save-completion paths through it:
> 
>   - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
>     current device state for the stop direction. The resume direction keeps
>     ERROR as the recover state, since a device that cannot resume is genuinely
>     broken.
> 
>   - vfio_save_complete_precopy() recovers to the current device state rather
>     than STOP. If it runs after an earlier stop was declined (the device still
>     in a running state), the stop-copy attempt is then rolled back instead of
>     resetting the device.
> 
> The existing vfio_migration_set_state_or_reset() is retained for the paths
> that must still reset on failure (save cleanup and the migration-failed
> notifier).
> 
> This lets vendor drivers decline a stop as a matter of policy without losing
> the guest, and lets such drivers drop their own workarounds that swallowed the
> spurious reset.
> 
> Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
> ---
> v2:
>   - Introduce a vfio_migration_set_state_or_recover() helper that selects the
>     recover state by transition direction, and route all three call sites
>     through it instead of open-coding the recover-state selection (Cédric).
>   - Keep vfio_migration_set_state_or_reset() for the paths that must still
>     reset on failure (save cleanup and the migration-failed notifier).
> 
> v1: https://lore.kernel.org/qemu-devel/20261008024329.1996536-1-pshit@nvidia.com/
> 
>   hw/vfio/migration.c | 38 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 73c49d8c24..69d50cebdd 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -246,6 +246,25 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>                                       VFIO_DEVICE_STATE_ERROR, errp);
>   }
>   
> +/*
> + * On a stop-direction transition failure, recover the device to its current
> + * state instead of resetting it: the current state is valid and already
> + * reached, so recovering to it is effectively a no-op that cannot itself fail.
> + * On a resume-direction (running) failure, the device is genuinely broken, so
> + * reset it by using ERROR as the recover state.
> + */
> +static int
> +vfio_migration_set_state_or_recover(VFIODevice *vbasedev,
> +                                    enum vfio_device_mig_state new_state,
> +                                    bool running, Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    enum vfio_device_mig_state recover_state =
> +        running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
> +
> +    return vfio_migration_set_state(vbasedev, new_state, recover_state, errp);
> +}
> +
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>                               uint64_t data_size)
>   {
> @@ -771,9 +790,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
> -    /* We reach here with device state STOP or STOP_COPY only */
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP, &local_err);
> +    /*
> +     * We normally reach here with the device in STOP or STOP_COPY. However, if
> +     * an earlier stop transition was declined by the device, it may still be in
> +     * a running state. Recover to the current device state rather than STOP, so
> +     * a device that declines the stop-copy transition is rolled back to its
> +     * current state instead of being reset out from under the guest.
> +     */
> +    ret = vfio_migration_set_state_or_recover(vbasedev,
> +                                              VFIO_DEVICE_STATE_STOP_COPY,
> +                                              false, &local_err);
>       if (ret) {
>           error_report_err(local_err);
>           return ret;
> @@ -1009,7 +1035,8 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>           vfio_final_precopy_reinit_check(vbasedev);
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
> +                                              &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
> @@ -1040,7 +1067,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                   VFIO_DEVICE_STATE_STOP;
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
> +                                              &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()

Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


