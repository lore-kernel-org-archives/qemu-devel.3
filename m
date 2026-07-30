Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF7C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRKv-0004re-CD; Thu, 30 Jul 2026 10:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpRKr-0004r3-Ft
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpRKp-0001lQ-Dw
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785420125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mAV/4Rh6IH5DArHhwpHZtNilXFnZlua6gpL7YEZRK9U=;
 b=Jg8KQL7fQ31ioCx/5ptx9xvc7viChbmOsELiPFsxQbRYOGfcS6vq+eMKXsCkuH4u2hR6KL
 cHBxAxePAp4VgUtmFClLTS9Ue/YmTWDuKVzH7o70KME/3O1yuol3B1E+9jM4X7C1uf5ivg
 bGXKYai4KRbQ1fbfMGVY6zbhxxHRFPI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jDBxTmciPJmq69D-qCszrg-1; Thu, 30 Jul 2026 10:02:03 -0400
X-MC-Unique: jDBxTmciPJmq69D-qCszrg-1
X-Mimecast-MFC-AGG-ID: jDBxTmciPJmq69D-qCszrg_1785420122
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8158485eso1817073f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785420122; x=1786024922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mAV/4Rh6IH5DArHhwpHZtNilXFnZlua6gpL7YEZRK9U=;
 b=LglJESw0lQNcEosihJZ6rZU0Wya+JbRqPB74IRK4vLqPiQx+DhnurzWVFJRuAS0zuV
 LgQdyg4iFN2byx0CnhTV+W3LEgXlsQXpduJG4W3YGjsX3iiBHWMqSblC+n5zNCBpzYyu
 IcxypcFWfb2iMhW7NnBz2O9ZStDlz2m22Sfj2JmmUX52cIEkTulMK4jfhNU0X8dRwFk/
 MT95NskS2MUm8xO4Nfl+dZBWnhcdEMhtNE/rrRNklWphPBPAY4y4za07lMyz+AJdJSLp
 DypbLdnd3hrWmr6+bETnrG4O5runeOYQNKwSPRNQWgO9kne83RE+z5vIbxDrHbl9Ws/t
 h6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785420122; x=1786024922;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mAV/4Rh6IH5DArHhwpHZtNilXFnZlua6gpL7YEZRK9U=;
 b=igNnYT5sEg0449qHX6l8MgKiESt8OOtwNetCe+ek0fCr1CeO7eoyIcttGYnigu6/qB
 7SnfJT3AHJpoBtuk1F0kp5ED5sIIVfkt/ALk6mlHQVhmnc1T37NgFiIlrGNrQyImH8Zd
 V5iF0tjO8r3udxqQitkiAc1i06CjDt0dN4pynFsHHcGSvUxvErYCggr9rOlwK0cqv99M
 vVAcTB1eJ6CxmMtkjfbDuxLtsTXLBKeW9BD5A/P1+ZFiVT3n2GbDszvRB8tx8pJHral/
 ht0eZ2IlMsSzbRmeAQ3jw9treNZ4rput3xyoiAxrB7SQsiSfR/l4sVCwoQ8Ry1VYtnQn
 ZXqA==
X-Gm-Message-State: AOJu0YwIVrrTa1V80DYZQtrvrjVywX9fXCIlGGlyziirXt7xbYsT7NLM
 /DZ9ZKeE2DgRHLUwIQCU9scOCUfRaEp76Qfbnm842dqn3/Ta/qK0DFfve/m8wefIh0lHssVvx03
 IBiKPJoS97kz7O5fgQv/qlhcnlekJylCy7Zu4kG698IAUcirdQKmz4FBNdp4/jhYk80SExcmPQL
 ZkYW8NZ7iemZTnAqWh+jU4naq5Y7rj1DELQPd4z5MraA==
X-Gm-Gg: AR+sD12RMDdhhHIvEp2UnbQmaQCh14glO15Up1DWWYSqChCv+eTX2T6UV+hqhULMCLx
 m4uzOFGJ5jx1FdaxT3ec9MO6IK+D7GckO+7vt0FZtAw1xAkjDCn0kdnuD8LZguqHwj7p+lNTz19
 L1EFDxfxtrI0WEcuKVfOOkIz/Gpb7HwTSmNmrQvL/sACDA0Iky3JFZTtB2hw4CL6z1irtBZW/6c
 gzRLbhz8X402avAXl5lmD/Gb4xPfpFu/vEj55/t9CY6/PZral5pb5Q0QY1JCVOHOUyfrkRkdqvZ
 mcUJhGguyZNkqHSpbYhIW8JDriDDdEns4g21K+RIIMrOXCwNy7dUZ8Eef6o67nVaRqICgrY8lp9
 s74qnbyqQ+aG64uYqlhExNn65EYXm7Uvy0XZNEz8=
X-Received: by 2002:a05:6000:258a:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-47fc80c1418mr4282580f8f.12.1785420122231; 
 Thu, 30 Jul 2026 07:02:02 -0700 (PDT)
X-Received: by 2002:a05:6000:258a:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-47fc80c1418mr4282485f8f.12.1785420121555; 
 Thu, 30 Jul 2026 07:02:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc893fe58sm10537643f8f.31.2026.07.30.07.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 07:02:00 -0700 (PDT)
Message-ID: <41256b42-6f83-4509-adf4-7e95076aa101@redhat.com>
Date: Thu, 30 Jul 2026 16:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] mptsas: do not crash QEMU on migration errors
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
 <20260729231904.775331-6-lvivier@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260729231904.775331-6-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/26 01:19, Laurent Vivier wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Currently mptsas asserts on invalid sg list count in the migration
> stream.
> 
> Fail migration gracefully instead.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [lvivier: use errp rather than qemu_file_set_error() to report error]
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>      v2: new patch from Michael S. Tsirkin
>          https://lore.kernel.org/qemu-devel/258d84f5af807e0103bf6f59165dd7450918e58c.1784898250.git.mst@redhat.com/
>          Modified to use errp parameter with error_setg() instead of
>          qemu_file_set_error() to report error
> 
>   hw/scsi/mptsas.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 45638af0afc3..34ceb6b5d25e 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -36,6 +36,8 @@
>   #include "qapi/error.h"
>   #include "mptsas.h"
>   #include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"

When I removed qemu_file_set_error() I forgot to remove this include.
Perhaps it can be removed on merge? Otherwise I will send a v3.

Thanks,
Laurent

> +#include "qemu/error-report.h"
>   #include "migration/vmstate.h"
>   #include "mpi.h"
>   
> @@ -1242,12 +1244,12 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
>       qemu_get_buffer(f, (unsigned char *)&req->scsi_io, sizeof(req->scsi_io));
>   
>       n = qemu_get_be32(f);
> -    /* TODO: add a way for SCSIBusInfo's load_request to fail,
> -     * and fail migration instead of asserting here.
> -     * This is just one thing (there are probably more) that must be
> -     * fixed before we can allow NDEBUG compilation.
> -     */
> -    assert(n >= 0);
> +    if (n < 0) {
> +        error_setg(errp, "mptsas: invalid sg list count %d in migration stream",
> +                   n);
> +        g_free(req);
> +        return NULL;
> +    }
>   
>       pci_dma_sglist_init(&req->qsg, pci, n);
>       for (i = 0; i < n; i++) {


