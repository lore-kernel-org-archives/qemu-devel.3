Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFEC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x60xd-00044Y-6h; Mon, 14 Sep 2026 03:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x60xQ-00043c-3O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x60xL-00043q-M3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789370299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Oa1EvBQH+EvY51fHmzjZBL1/LrRXoMt6h/U5sgaYxeQ=;
 b=d5olVE2zxcabWfM4oWsYe9YdusXj9ALdSs3Yn8J4qzr81fEBcJ9jcmEtENJ19xdWu+g0VI
 M/56I480ANsSHbZ9VI6/f8tmRUUwEeuxcVwMKjBWur9QkfItavVmR7psUtNETsQXexOzdn
 jYMQsv/i1V6cbrmKdfmbmh7mJ5GqiTY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-aWacZQeYPuKO8xAaxJohOw-1; Mon, 14 Sep 2026 03:18:17 -0400
X-MC-Unique: aWacZQeYPuKO8xAaxJohOw-1
X-Mimecast-MFC-AGG-ID: aWacZQeYPuKO8xAaxJohOw_1789370296
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e65f2f1baso16686295e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789370296; x=1789975096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oa1EvBQH+EvY51fHmzjZBL1/LrRXoMt6h/U5sgaYxeQ=;
 b=Tc6jUGneFPVnYZkx9kbCNav3wrg+4kp94yDX86dtIssVE3864ZZAKE8heTv02ItvYi
 DtHtPKtmAsfwAAY8wtoSSMVfmTOduIQlGcgQWq4DBA83KH8rTGY5gVChZU4RCO4Fto37
 EjvZdxbwMUsWY9WQ5fVFmONfDLbjAl6HdhsyLe245CRZVK5FJXd5vgYv/JIOV75hIPDB
 1bRXis7CZ039RB5/YfVTQl9Jz0ylDIJ0hgxUkyGk8Vr/ERCLERsA+JAVMY30BB/xLTed
 2IGevcxMdMe7Qh9kLBT52S4gmfkqUcN5VCkWjFUEbKODtvRDayk568qOIoEIW6JauTYH
 M6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789370296; x=1789975096;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Oa1EvBQH+EvY51fHmzjZBL1/LrRXoMt6h/U5sgaYxeQ=;
 b=ADy2E+2vMf2/ZA8oi48c7uZ9+5UjoVS/WC38FcOVBtK7siXnYwLxBHUrTvHv1cYAG3
 OUQMCPuYYL8XD+W5I1tXJDIXs+XvP1gYKdL4EgwDaeGVPokbu+TQkracNwHp+k/Mqwbi
 7cSyqGdksG+/HcAnJW83JEDgtpESZ1JHkZ3wZV3/ulOimr1Pv38G1GrV7CEwqLyqaC6t
 Ie4R0oJTtcxg0fZEIKEirl00L47ONWYa548m3mzihBPrJtuUbOShg6qsawoUfyr7UsSh
 QFfbg+KzHVlsnhA0HzhvxQ7G8oZeqPp35hS+wfIGc+iKstRmxgSUcLSbEgg5v3QCIHLH
 /i6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvwM+79yDjsPhYBR2T7tsRMPFpRMchcI4fzm2fUN26uqyj7RH/acmHUT222lJXZPiTAAnN1Okufb5j@nongnu.org
X-Gm-Message-State: AFuF++nDF7zkIlliULQ2TzpPTvNZP0BWUIbLhePjTyZp8HJQYAmIwKMQ
 JNQ5VzNLkF7spjOTrzZ/Lf+9He5pZGFi+1qEWNY+NtGBpx/zJ4CrMS5cSQCsoiFXTSSpegPHh4o
 +LPw55z91j9Ulw65BBTTYciSmmVF65ID86Guci1c6blmPlUpKrDrMwE5G
X-Gm-Gg: AYBFou0vvwyjCQUMH4t0j+i7EPGk2s1syxo1faxemVR5J6Rf29CF14Y/06NIxVTE0An
 T+R0OOBFOTQEBoKuwi+NLEj5Sk9nfNpLKxVoQ0cwAcwdFuzP0taQ4GPkhc5P3JhEOQ85pRHKIFU
 02G0wiipRdiYhuDV7jxDqTTDw4V3AcNC14JFOc0jy8ypTVEwFHTxoozV2rQ8ohBrls6A44GY29+
 yjLkXWiGxFjwXd3aLzRqC2lPndO4ST6tEYY9NswHDosulg9uHgz6zq0FznRbMK865F3wHlNR2de
 rpwxoGzYrFgb2OA/FMR5fkNGil9cImrSnDSKgHo7oYC7uY6qDWvY4Ebn6Nz6LUdEBaY0EOWvo2W
 BW9fY1psHicCQV1Cq1iamfN6WszHeVId6hlw6JgE7qQ==
X-Received: by 2002:a05:600c:c8a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49e7a6386d4mr13249085e9.2.1789370296068; 
 Mon, 14 Sep 2026 00:18:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49e7a6386d4mr13248585e9.2.1789370295551; 
 Mon, 14 Sep 2026 00:18:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7723d458sm91307095e9.0.2026.09.14.00.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:18:14 -0700 (PDT)
Message-ID: <0f4573f5-2828-4cae-9bab-2ec1a975c4eb@redhat.com>
Date: Mon, 14 Sep 2026 09:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] vfio: route device_feature through io_ops
To: Hugo Komatsu <hugo.komatsu@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>, Thanos Makatos
 <thanos.makatos@nutanix.com>, Tony Krowiak <akrowiak@linux.ibm.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
 <20260911140710.2348139-4-hugo.komatsu@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260911140710.2348139-4-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 9/11/26 16:19, Hugo Komatsu wrote:
> The generic VFIO migration code in hw/vfio/migration.c issues kernel
> ioctls directly for VFIO_DEVICE_FEATURE. Route these through the
> existing vfio_device_get_feature() wrapper, which dispatches through
> VFIODeviceIOOps so alternate transports such as vfio-user can supply
> their own implementation.
> 
> This is a pure preparatory refactor: the kernel path is unchanged.
> 
> Co-authored-by: Rafael Castillo <rafael@trfs.me>
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
> ---
>   hw/vfio/migration.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 73c49d8c24..6db4c2a216 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -168,33 +168,30 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
>       mig_state->device_state = new_state;
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    if (ret) {
>           /* Try to set the device in some good state */
> -        ret = -errno;
> -
>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_setg_errno(errp, errno,
> +            error_setg_errno(errp, -ret,
>                                "%s Recover state is ERROR. Resetting device",
>                                error_prefix);
> -
>               goto reset_device;
>           }
>   
> -        error_setg_errno(errp, errno,
> +        error_setg_errno(errp, -ret,
>                            "%s Setting device in recover state %s",
>                            error_prefix, mig_state_to_str(recover_state));
>   
>           mig_state->device_state = recover_state;
> -        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -            ret = -errno;

There is a little difference here.

The code used to return the errno of :

         mig_state->device_state = recover_state;
         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {

as introduced in commit 31bcbbb5be04 ("vfio/migration: Implement VFIO
migration protocol v2").

Now it returns the errno of :

     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
     mig_state->device_state = new_state;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {

You proposal might be better but it is a behavior change and should
be introduced in other patch. Or keep the original behavior in this
patch.

Thanks,

C.


> +        int recover_ret = vfio_device_get_feature(vbasedev, feature);
> +        if (recover_ret) {
>               /*
>                * If setting the device in recover state fails, report
>                * the error here and propagate the first error.
>                */
>               error_report(
>                   "%s: Failed setting device in recover state, err: %s. Resetting device",
> -                         vbasedev->name, strerror(errno));
> -
> +                         vbasedev->name, strerror(-recover_ret));
>               goto reset_device;
>           }
>   
> @@ -347,13 +344,13 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>       feature->flags =
>           VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIG_DATA_SIZE;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    if (ret) {
>           /*
>            * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE
>            * is reported so downtime limit won't be violated.
>            */
>           migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
> -        ret = -errno;
>           warn_report_once("VFIO device %s ioctl(VFIO_DEVICE_FEATURE) on "
>                            "VFIO_DEVICE_FEATURE_MIG_DATA_SIZE failed (%d)",
>                            vbasedev->name, ret);
> @@ -1094,11 +1091,13 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>       struct vfio_device_feature_migration *mig =
>           (struct vfio_device_feature_migration *)feature->data;
> +    int ret;
>   
>       feature->argsz = sizeof(buf);
>       feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        return -errno;
> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    if (ret) {
> +        return ret;
>       }
>   
>       *mig_flags = mig->flags;
> @@ -1137,7 +1136,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
>       feature->flags = VFIO_DEVICE_FEATURE_PROBE |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_START;
>   
> -    return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +    return !vfio_device_get_feature(vbasedev, feature);
>   }
>   
>   static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)


