Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11850C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNFS-0005lS-Rs; Mon, 27 Jul 2026 11:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woNFP-0005ka-TL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woNFN-00023q-GL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785166083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h3HMoRnNIGDWirxVOBiFeJ4SD10y30K6KdebeJkMxw0=;
 b=QuePW0bXblBh03wuc+kTqNgAiynm1zNx201R4WyErkZi47kfyuK36HR5jFRVho8clEGRyy
 ngR1Wsu2ahObMlSA0rYCl8JiA0lraqUF1PzXKHOZVHFLZe5V2lFOkdMOroqaK3bqEzb0Vb
 GK/Ol8hDpkHocv1noWV0bTOV05Mrt2U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-0EynKE44PfiuFthWcbmwhw-1; Mon, 27 Jul 2026 11:27:59 -0400
X-MC-Unique: 0EynKE44PfiuFthWcbmwhw-1
X-Mimecast-MFC-AGG-ID: 0EynKE44PfiuFthWcbmwhw_1785166074
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-474170b59dfso2040559f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785166074; x=1785770874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h3HMoRnNIGDWirxVOBiFeJ4SD10y30K6KdebeJkMxw0=;
 b=SU+JCBNwDIj8LGo8AwODHwHPHGEGt3jFNmxdrbQhS59NyGbduUE0ytRixj1FwfnxvB
 KyLfs6dqtqXen6B8sgV2TwjCGZW1kJNW4/h49tOk5EpVapwt29SONjNiWyzR7haZiOQc
 T+2lVZOLzVwbiX6DLshWJfbagFiW6p+uMPtYlNaJAtwtzErviaqW4bO/MGb6iaqSQyq5
 kf5MlDnTR3C+uivTLX737z6vLrHioxDy5LSdAFJkTR0rToNTY8rzn06P/j66ibTLUi22
 R+7A0ckYOzbcRwll6f4iHAkRgIW3nyVjffT91sG1YE66TbdPXltjysE8MxFLsd/BMbnz
 8umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785166074; x=1785770874;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h3HMoRnNIGDWirxVOBiFeJ4SD10y30K6KdebeJkMxw0=;
 b=jRyBXrgwhtTBFif8inxkMl7SBHSs8I9LI8njyS5yXN5yzYwFCWPy+HUCiFB2Vi+kW2
 HslzBLZLckNw0hBetx1IgQSodT4+XvQCMqWcPuH6J4m2Zm06M0Lrw8M2toSr7p72ww1G
 2tE8qeFlIzvdybw3UqoR+NBZsH/zrOkolGbiJ4Nsa6iPjH2gjmsI75CGc4Cd77qXMpma
 CAqHQ/7BinIb3u5PnXej7L1LE8Mq4sKy+R8sA5M43ObEkDrA4FNy2JLJ3Sn/vfgxR+Ay
 G3ttTV+2Lrr7VVM5nD6ElVR9bxRQLVdg+o+ds+nKGOf1xg9IEYLCaqShOOVRalGQ5MMp
 KXPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RounvK2U0PKMhF7tyUZn4x2JfvkXmiOqYxidcCg/+fZpAUc3XDhNJkWVwgAhU+uDPf2YT3v+GzHZ8aZ@nongnu.org
X-Gm-Message-State: AOJu0YyTh8vUqyimP3tkFuHJXNArEX3Rf7+DmV+6h8jlSd/LOmi6pbJO
 4Ri9knX2fxexHTkohsGhET2ScWlYYM5BsVbnNrra+GEOzjSb7E4BeJNjDALnMyj//WEJ5yetfCq
 fx+dWeQh/NcIhNBDSlJHlgYw21mUWz5SW57LSw09KwoUKvvMzYE2jrz1B
X-Gm-Gg: AR+sD111xPR+Zc2dum+ApMgsQaX3FR1QJBcOT6ObAfuOoxofjlc2JuUp/Co8dVpJvjB
 hsahzOOOiRJPLEnzTUUsQG/RlpUxvKEG84pMop11/ingQQ/QaG4Rt3EG2V6yYxikZPJeJV5hT4a
 GIvQyIu9X6DQmeU/ciWVZK70uwT1pztKCFQY7KQOsxOXHAjJIS+upcL20SCWHJ9/c2EcT/9iMkF
 pW+x4DsmETAzkSGY4KNdO+sgtWB7g9DrFKww28SVlRlIgAE2ijFb8xXmyhooYsGO47GXJfE/cgJ
 AmENILPzx1fI5HNOt0D3uTDr9oMxOPpZxokXp1iAvTDGaiKI2oKVl5LGEoUJxk5ODqK7LNlZYWJ
 pNkwxAv67PnJGsGTQPnYGAie8yuDqes3RX/BoSH0=
X-Received: by 2002:a05:6000:310b:b0:47f:8e50:93e0 with SMTP id
 ffacd0b85a97d-47f9febcd35mr11885810f8f.39.1785166073858; 
 Mon, 27 Jul 2026 08:27:53 -0700 (PDT)
X-Received: by 2002:a05:6000:310b:b0:47f:8e50:93e0 with SMTP id
 ffacd0b85a97d-47f9febcd35mr11885764f8f.39.1785166073433; 
 Mon, 27 Jul 2026 08:27:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6287csm50517165f8f.25.2026.07.27.08.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 08:27:52 -0700 (PDT)
Message-ID: <093da848-d6f9-4d88-a317-6acfac2724bf@redhat.com>
Date: Mon, 27 Jul 2026 17:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/vfio: Fix liveness check in
 vfio_connect_kvm_msi_virq()
To: Tycho Andersen <tycho@kernel.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727150038.2684512-1-tycho@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260727150038.2684512-1-tycho@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

+ CPR maintainers,

On 7/27/26 17:00, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> While working on savevm/loadvm for a new vfio device, I encountered the
> crash below. Since vfio_connect_kvm_msi_virq() didn't check the ->use flag
> for the vector, it would pass an unused vector down to
> vfio_cpr_load_vector_fd() which would crash.
> 
> Fix this by checking the ->use flag along with the virq number to detect
> whether a vector is valid or not.
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555a891ef in vfio_cpr_load_vector_fd (vdev=vdev@entry=0x0,
>      name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1) at ../hw/vfio/cpr.c:44
> 44	    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> (gdb) bt
> #0  0x0000555555a891ef in vfio_cpr_load_vector_fd
>      (vdev=vdev@entry=0x0, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1)
>      at ../hw/vfio/cpr.c:44
> #1  0x0000555555ce64a1 in vfio_notifier_init
>      (vdev=0x0, e=e@entry=0x5555586971b4, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1, errp=errp@entry=0x0) at ../hw/vfio/pci.c:79
> #2  0x0000555555ce721e in vfio_connect_kvm_msi_virq (vector=0x5555586971a8, nr=nr@entry=1)
>      at ../hw/vfio/pci.c:601
> #3  0x0000555555cea5a5 in vfio_connect_kvm_msi_virq (nr=1, vector=<optimized out>)
>      at ../hw/vfio/pci.c:597
> #4  vfio_pci_commit_kvm_msi_virq_batch (vdev=0x55555906de40) at ../hw/vfio/pci.c:822
> #5  0x0000555555cea9f2 in vfio_msix_enable (vdev=vdev@entry=0x55555906de40) at ../hw/vfio/pci.c:850
> #6  0x0000555555ceb152 in vfio_pci_load_config (vbasedev=0x55555906e900, f=<optimized out>)
>      at ../hw/vfio/pci.c:3088
> #7  0x0000555555a8c765 in vfio_load_device_config_state (f=0x5555574a43d0, opaque=0x55555906e900)
>      at ../hw/vfio/migration.c:278
> #8  0x0000555555b3a522 in vmstate_load
>      (f=f@entry=0x5555574a43d0, se=se@entry=0x5555591edd40, errp=errp@entry=0x7fffffffe130)
>      at ../migration/savevm.c:971
> #9  0x0000555555b3ab1a in qemu_loadvm_section_start_full
>      (f=f@entry=0x5555574a43d0, type=type@entry=4 '\004', errp=errp@entry=0x7fffffffe130)
>      at ../migration/savevm.c:2654
> #10 0x0000555555b3e1ee in qemu_loadvm_state_main
>      (f=f@entry=0x5555574a43d0, mis=mis@entry=0x5555571de5a0, errp=0x7fffffffe130,
>      errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:2973
> #11 0x0000555555b3f7b7 in qemu_loadvm_state
>      (f=f@entry=0x5555574a43d0, errp=errp@entry=0x555557157c10 <error_fatal>)
>      at ../migration/savevm.c:3058
> #12 0x0000555555b40863 in load_snapshot
>      (name=0x7fffffffecc9 "foo", vmstate=vmstate@entry=0x0, has_devices=has_devices@entry=false, devices=devices@entry=0x0, errp=errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:3452
> #13 0x0000555555adc211 in qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2817
> #14 qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2802
> #15 0x0000555555adf8ed in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../system/vl.c:3849
> #16 0x00005555558903fd in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:71
> 
> Fixes: 30edcb4d4e7a ("vfio-pci: preserve MSI")
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> ---
> An alternative implementation of this would be to set ->virq = -1 after
> the allocation in vfio_msix_enable(), but since other locations that
> checks ->virq >= 0 also check ->use, I added it here too. Maybe it would
> be useful to do both.
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 380dd8c15f..b5280c3d2a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -589,7 +589,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
>   {
>       const char *name = "kvm_interrupt";
>   
> -    if (vector->virq < 0) {
> +    if (!vector->use || vector->virq < 0) {
>           return;
>       }
>   
> 
> base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587


Looks ok to me.

Thanks,

C.


