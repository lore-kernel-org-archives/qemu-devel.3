Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED08CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHq8-00048v-Rp; Wed, 24 Jun 2026 03:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcHq7-00048n-Dh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcHq5-0004YD-Vi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782285360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JN1Ao6WEVvEQ7sk5rN2xxsW4b8vgnEjZfLFDDL3tjGY=;
 b=BHFMaH3rMJbs5jJNgYIc/a0T3qTA35rgOIWM8nZgtYdt2ATwQ2w4qBlamtykQ1KcupAgeP
 N0bLctnS3skB96nxxERPHqiz0auVZyoS124O2nlJgup18HAxxMI6U2aLqdoIhROlxmF9Hn
 YsSpJ8D+RH/K+qfreWB9ARaTWZciAe0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-p6DhJNlaN4ajt0afoMhTSg-1; Wed, 24 Jun 2026 03:15:59 -0400
X-MC-Unique: p6DhJNlaN4ajt0afoMhTSg-1
X-Mimecast-MFC-AGG-ID: p6DhJNlaN4ajt0afoMhTSg_1782285358
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso5090605e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782285358; x=1782890158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JN1Ao6WEVvEQ7sk5rN2xxsW4b8vgnEjZfLFDDL3tjGY=;
 b=lJjQEEKo2Mardp51uwUx1YfuXPjdTWB6Qs0b0r6AA14F8HItoCyF1KYyVx8F3ddptM
 i4H0O+63Tm1YLcvohqk7l3qHNFrw+IeAdOJ4d+dvqCOiYkIi8lDoQDXKIFSNkdzA5rnt
 tdGfbE0j/qp0L9BhuLO0CaCyPl/bxBmSkWPc2d4Z046qcvfdIVWjp28BrIv9zFBOpfXm
 jN4XcOebbiWq50AWkqL0tkkLiiZ2mBvtC2k+iQNNkFr7q1/EC90xlOQif/ZMDYTJPuV7
 htjFBy/bcv/KEcs1pr24mls/kYdwhjw/H7bhhM4prgfoCKeWiew+H5aNBMwNDnqJ6/4j
 OOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285358; x=1782890158;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN1Ao6WEVvEQ7sk5rN2xxsW4b8vgnEjZfLFDDL3tjGY=;
 b=As0VRT0fcI+qRwAAl2UZPgm1+CYz6EXOaVinhCDBWK0Jv3+m/GRDjR5N9wlQuSzLc6
 jz2b2mkppM9jXynVUxBykzgOefWRGWnrEQPJ2Gz0pgLWgiEJyEJRt5Qr7GQGAj2CHqmz
 f1adtLTEnn+0ZTXCCPo8xB6CQlFX/XLM9+8GjGVjx6MXeDReAnjUT/Pt8BoVx5Zi3Y2t
 iwJK1PWwApt4IfhjmVc9TKsHFMkNibXGjiLYaTFm8DLicoY9Ddr2xBIYGaIM6GicSNhf
 s8kmcoBgkfORFPu51FzhWBJBeSy9WenfXH21Ayy+kQkngHgSkVwQvqeHVwI3DZ97eudh
 K1Mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tfPqb0ESwJGvGl1vhwZd4TvXs2ADru9QnOx4cmljLrbM0paduRgr7dJEMOWVK65FyzsyVhyXQP6Mq@nongnu.org
X-Gm-Message-State: AOJu0Yx7GxGXOZP7Fpr5S5DdSoqHDWegVj+c53XLUQxJ//DV2MS0i6kv
 ZElqw7Z9E8ov3dvH9R4IUl7s49M3iKndcg8c4GcTJeHgZ6eX/jfS1eMRes24I7dGCgblqoo59zK
 +afwJKtcpIk7tC/GVkjCPTlnjq78NDzO4nzWOpfXtXEQutS5LsqXGPFc0
X-Gm-Gg: AfdE7cmuSS0Sx2lOxAXtMzaWF5LJmH4EhiUDQxiugqnYGzmM9ERO5xsxK0A0J2zqciM
 4zZcV2zd//sOEbgmpkg0Oghi7IlPjr66A2/zArQHp2/5byN+WejfcgAoukHsaRsO2r7ckWDdRWg
 G9J107Jy0anLDkMd2SYAtEZeTsPbUyhDEdJ14/ExhMdOEjSiCz5i4r52obmNl7IIiWrz0ijqRQI
 N5Po5RHHLqkBimecw0eL5z36NVuhCbc1mPP7zdZQWO4ty5fS5VQTHtP59rwrWFXKUffO6ddggxo
 RNBEsBHl5GXhbCb7YAEYn2+lwkTsDRP0mlcdftTWJ59WoIj8gx15ZYkNqG5wD4T8aKWM2+zei1o
 X0Xj5ZHhfJGhXiLEJItwblbt5p3IFfXXYgQwOATM8MmBdZRkULEgXJaA=
X-Received: by 2002:a05:600c:4fc8:b0:491:ba04:2ce4 with SMTP id
 5b1f17b1804b1-4925b364cc4mr91976265e9.16.1782285358197; 
 Wed, 24 Jun 2026 00:15:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc8:b0:491:ba04:2ce4 with SMTP id
 5b1f17b1804b1-4925b364cc4mr91975635e9.16.1782285357699; 
 Wed, 24 Jun 2026 00:15:57 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49260915286sm75277075e9.1.2026.06.24.00.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 00:15:57 -0700 (PDT)
Message-ID: <1d32c715-877c-4587-b161-99452d170db5@redhat.com>
Date: Wed, 24 Jun 2026 09:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] migration: Propagate errors in
 migration_completion_precopy()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-2-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260622101214.25770-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

>       if (ret) {
> +        qemu_file_get_error_obj(f, errp);
> +        error_prepend(errp, "Failed to save iterable device state: ");
>           return ret;
>       }
>   
> -    /* TODO: pass error upper */
> -    ret = qemu_savevm_state_non_iterable(f, &local_err);
> +    ret = qemu_savevm_state_non_iterable(f, errp);
>       if (ret) {
> -        migrate_error_propagate(s, error_copy(local_err));
> -        error_report_err(local_err);
>           return ret;
>       }
>   
>       qemu_savevm_state_end_precopy(s, f);
>   
> -    return qemu_fflush(f);
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        qemu_file_get_error_obj(f, errp);
> +        error_prepend(errp, "%s: Failed to flush QEMUFile", __func__);

This error_prepend is not consistent with the previous. When applying,
I will change it to :

         error_prepend(errp, "Failed to flush QEMUFile: ");


With that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


