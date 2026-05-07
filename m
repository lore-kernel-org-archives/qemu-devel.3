Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01203CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtnU-0005l7-SW; Thu, 07 May 2026 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtnT-0005kr-Lw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtnR-0006Yt-HU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778141363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mfzdKw8KAt+/Y7qrx2uRs9MRTHX0uvCLpQBf2ntXsgo=;
 b=M1Zz5+U/FRVBCi67zpD1D2pLKnfZwrC1PYSlyetwTFmNQoJFOO5EkEVydg4RK/s2nhqsS5
 aW51M+DTq9f4yU3tmw37U42bdh67JHuc+GZvI0MrYDHn0TE9bsKF1kVgwXWKdqW7PO4vZs
 CKJWGV0G/n+c0yUYsT/CtF92cYTP9K0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-eUInoadpPBSB9Os_C3UL1w-1; Thu, 07 May 2026 04:09:21 -0400
X-MC-Unique: eUInoadpPBSB9Os_C3UL1w-1
X-Mimecast-MFC-AGG-ID: eUInoadpPBSB9Os_C3UL1w_1778141361
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo421740f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778141361; x=1778746161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mfzdKw8KAt+/Y7qrx2uRs9MRTHX0uvCLpQBf2ntXsgo=;
 b=Lrw7kYO+b5oVl2zXlQ4QADBG197QQ+WL5rb0u+S1GcaRi3H+IsgDTBDt4dcvHjWTeO
 To/AKj+nsQYFD2898R8lX+6bslXTWUmeb7gMfKkdnrH9dsZxaKcptrAagAcJ5nxog0CY
 vjd5/0ObFGKBlA7XoXrIhd+hUzDkryKHUKmv6K+t6djcpBhHZSV+eRkAsxzG+hx10rfu
 6ZMt0ET0H2x6kfnnKNxpdFNRYvCzhIY8LOL5aHtiD8GBE6+XZcA6uo6znB23cUO56pPj
 ffviLo2rRL7/QGGab88GR9YogxksqDUjR5VKeKa5i87WiVNv01hvHYi+YV1D7q3c4sef
 hJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778141361; x=1778746161;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfzdKw8KAt+/Y7qrx2uRs9MRTHX0uvCLpQBf2ntXsgo=;
 b=e/1xgc9hSu/WNzBoI7ENQlB+RtZkXp9OKD6TlYN6SN7kVYhi7Cgq6S5Wuunmjlp019
 eeAOE9IHTdCRpth6XAfA3yRRFsLc77Iu0N39rLgvrE6Qb0Hck06v7VieuO9cCvaSqzAJ
 MRmWwwthGgK3Lksj6Mz6IQdQIJgAPWLMfOMC0/bGnKw5sJ1FW/usWicNNYOr6KDQxcPD
 tiAAbE0dkIVnukmnhkgkWL20juxSIo1ityPeMXvGNRKebs56O1bbQMpY+p3kxCq1sCpX
 Txulqr/hO8Oc/m39wth3+uMF1llvi1bUrnOmfdr7ChujD5sosC1iGc8onal4kyaG/UVS
 qCeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MFZ5ewfMbkcMHLVyVmSbqnJjSuSi5NrBnWRHGKWCRC19qJA1M13+dYgMUe3RxXcnz7PgBmc46jvd1@nongnu.org
X-Gm-Message-State: AOJu0Yx3kaE6iYZ4ZmwpE0CT8PTUGrY+rWGjm4Rgvs0VZ1t/koSzw9vN
 JbGSUnj/GiE6LP4Z5qTQj8oEIC/IERHDcx341/mB7zoijWm8azWiBVL9f1f+q6hNw4KLD8wceeW
 lEAaWfWD0hvDKNfSiirz9m46sTpzT97wpYKrR7C4p8qHlef8spYxpN+dO
X-Gm-Gg: AeBDietIRJrLEhMLlPMcK77QK8TqOKWC+ETSWjRINJqUW5k1wjZA4zQ01SjLnlvgNEJ
 4oR1N7gKXDLux5U+CmFjS3icT6rvLusY03zpwngLcYGrNMoexknx2EnfStsTLSK4L8oUqnm38EN
 oVj3sswkzeTJCU7Rbnicoo2wZ5p0h2Vz/tXXsBvRl0gxj6320ng3hJJTRXD2esSPmgF6z3zoVmb
 +ttUemfw14+4356e3B/+96dEglRRgRj0Djujol3QYoJb+5DV/mDDKVS8MG+XUW0KEKYnLWi+uHK
 4L52d2GKwyfcxh6RDM5OfadRLswHGeEkjROD802xAQ3iwB7iE0FF9BzxtwGuIvOD/CUxSQyxJ+C
 y8mS1IHcq8oqrAoFTuOcaEQIlqXMBXZPsEcbLc+CihHGKGl4ILh3EiV3TYZ/9EmjgxpUIQgQ=
X-Received: by 2002:a05:6000:2dc6:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-4515ce1c977mr11450074f8f.24.1778141360636; 
 Thu, 07 May 2026 01:09:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-4515ce1c977mr11450016f8f.24.1778141360101; 
 Thu, 07 May 2026 01:09:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960811sm19264705f8f.27.2026.05.07.01.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 01:09:19 -0700 (PDT)
Message-ID: <3de5f050-f87b-413e-b967-e51e78c5e302@redhat.com>
Date: Thu, 7 May 2026 10:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-5-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505081423.28326-5-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/5/26 10:14, Avihai Horon wrote:
> Pass the device name that approved switchover to
> qemu_loadvm_approve_switchover() and log it in the trace for debugging
> purposes.
hmm, isn't the trace event in vfio_load_state() enough :

	trace_vfio_load_state(vbasedev->name, data);

May be we can improve it instead ?

Anyhow, I won't object to the change.

Thanks,

C.


> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/savevm.h     | 2 +-
>   hw/vfio/migration.c    | 2 +-
>   migration/savevm.c     | 4 ++--
>   migration/trace-events | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..1efbe1d79d 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -70,7 +70,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                              Error **errp);
>   int qemu_load_device_state(QEMUFile *f, Error **errp);
> -int qemu_loadvm_approve_switchover(void);
> +int qemu_loadvm_approve_switchover(const char *approver);
>   int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
>   int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>                                            JSONWriter *vmdesc,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 150e28656e..c3dd30d619 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -818,7 +818,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>                   return -EINVAL;
>               }
>   
> -            ret = qemu_loadvm_approve_switchover();
> +            ret = qemu_loadvm_approve_switchover(vbasedev->name);
>               if (ret) {
>                   error_report(
>                       "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d1dd696c17..bd8c6ada5a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3158,7 +3158,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
>       return 0;
>   }
>   
> -int qemu_loadvm_approve_switchover(void)
> +int qemu_loadvm_approve_switchover(const char *approver)
>   {
>       MigrationIncomingState *mis = migration_incoming_get_current();
>   
> @@ -3167,7 +3167,7 @@ int qemu_loadvm_approve_switchover(void)
>       }
>   
>       mis->switchover_ack_pending_num--;
> -    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
> +    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
>   
>       if (mis->switchover_ack_pending_num) {
>           return 0;
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..d9084a2692 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -24,7 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
>   loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
>   loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>   loadvm_process_command_ping(uint32_t val) "0x%x"
> -loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
> +loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
>   postcopy_ram_listen_thread_exit(void) ""
>   postcopy_ram_listen_thread_start(void) ""
>   qemu_savevm_send_postcopy_advise(void) ""


