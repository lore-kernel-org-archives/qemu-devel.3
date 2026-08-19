Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2692FC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwg45-0003Si-Py; Wed, 19 Aug 2026 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwg44-0003SX-5N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:10:44 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwg42-0003JE-DB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:10:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69848c9462aso153436a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145041; cv=none;
 d=google.com; s=arc-20260327;
 b=h6Hs2OD/HJ6p8AXFSZROKSpk74nZvgII22fpBp7UuwzZvrt+ewEGZrYUzwFRIivLJs
 9EzUxBFxw0aDyJMPJNBB5KwcYfAq7U9zfr3ISdbVc2a3HFA872myI3LzdiV+bvNklQN/
 VMYGd419I7GunLJhzx9tIOW6CuWChnOGKyrbcRhBOpr3YorjV101bvVYrNMj5HvZ593x
 hDRayKVulcsXGcg0riR6B+vECGQeOAEbP/4RrJRoZL59QXickShp3uVVOCC+ELk67+cU
 v+8JdB9g3x7Yh6EuPgDK/8r6PO4WWz10bYyuc1ruplPmW5cYmO5Qm9mA/NQKbbOMMVJZ
 wQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U1xNtKKCI4lB/Ad5ZAGFZmlgqR84V8M39eKN+2qq08s=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=nrd8nB4J4X5OIfO3WH7VXkqByXdLl0B9JVC74iZk2fVLFCA3ipdriZabg0edWU7+0Q
 FM06Ohenzeb7UfjdR2WxCkemPrlibIOwvVdZWj8Q7W+HFAZvLwvqxGP5fp89GVpPC8tl
 xUzXL15yz9IRTY59L4f4GUWiWm8buiDu57AQdmSaqICo6SO1bvkuVQFrnlDbIByyq+qV
 set666zbXsVKFis+Qep7gYf6vOf39Egn08rq62wpf1Ezyt53iGqkCpi2y29yK1czW8M0
 QMZNGGenZa7v0cFa3NdfrJlPLjxujalPXCN34whsuSs1V167qEyibH7Va7DsxVCT9dVZ
 HqCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787145041; x=1787749841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U1xNtKKCI4lB/Ad5ZAGFZmlgqR84V8M39eKN+2qq08s=;
 b=Ef8IVpiyaxiNxs8dCfurCUPQdp/eeUWjKz5JLLyC+9wlVQuwiyY/ikLgrrSS0RYy/N
 q/xOA2tqcdZ8/6s2l04SQh9SK9hCDSLn7LP5Rao+6WukrgYyULHRuo3PUWd+BN1Hm22V
 yU+bqxtX0ld8iSavXYqZN/VyVyXlGMOxMqAPuzYMKokMCYsC/8iz/14m0CGSg+5bb3FR
 NmHHWsNA4L5hGL6zkPyo2NjHhhAwtOM0MVN9Cyrh8tD2bA3OYft150yGLUn96+3J/0Hy
 gpYAesMHVhF9f17vrJPxZkAdLDtIFEkZ3m2XG8YiZEJRZS3r4QRmqJ3poo1pL9pwV09p
 EX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145041; x=1787749841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U1xNtKKCI4lB/Ad5ZAGFZmlgqR84V8M39eKN+2qq08s=;
 b=QJaO3FFdm+6Zqwd//QrpyITGKZG47tmW2vtnhJt2ftIJ6lZXkmZtDR7R9coV/eWtPk
 p9L+MLQcuL/HTNYQLTYlBpCRcMG0mjr+PxulCOl6xHE3TZXJ3LUvmrf54DZfHOUllK0S
 xkcjkQiSRO6QL1kMP4Y9F9gmIXPT3BLzOw478Jq4qt50k5GlWQQjq/d5L/VlJFzfmkf5
 7x4RaSou27tS9EqqxlAO7RIFS4W7fBomClaSaKmN9bg2hcaLJBHPgslavov6y3iZbf8b
 EsTpJSZEUe/QWPXc6DVxhF0eqRrHiHVmRGuiS0iFyHnVQyVUMVPoqs/O0mvgcnM4xaeB
 iRTA==
X-Gm-Message-State: AOJu0YwCRHQ7iXp3ZhxuIiq9H4nkk/kXfoL069fUp2jVj/LjvAYOmEO8
 Vn08zBzUcme3xwF9HAhg1UknlFriG/UoneJAewMIYNJh2scc3jA6S0invdd4yGfw7+wCO+KwaIB
 ksE8JMZUNQclGP14KkWoIVSqYrYZ6CxPScF2oj+m2hw==
X-Gm-Gg: AR+sD10FNisFyDf1oUaSLhdOhyKFu8RyIhMfUIqnQgQ22Oq6Ea3t3V1XlGY9KVdS2Vh
 wZiNpOm3srNzYG/ZX0+z3iGXImZzxgXGmONdXt2jF00K7ghhyNirWCQpAAhGgq0PidsW/IF+m9I
 z4zT/iBn75texVxM90d8pnsqKYL0cIcsiVU/lxAaZtog0ZYasany4XgQpOIyLPDT8dxZz/yjqX9
 RP90qSQEARuwO8n2e2yc84jvkfZSDdNiEjXFrE0OgbMTyykWTFsUcpuOIJgZvAJOuZOkReM9TwD
 3z0MgyEtVX+NsH8wBp/7LYmw48OTx1MG559cUzplF6GkLopWmG6I40iG
X-Received: by 2002:a17:907:6d21:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c242e204bddmr161818466b.2.1787145040510; Wed, 19 Aug 2026
 06:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-11-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-11-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 15:10:29 +0200
X-Gm-Features: AcwNN1V1ZY90DZ0RdkWfpGqPuObSsOBWl6nJJ2sk5MxFrKZGKI-petUh0TNGwOM
Message-ID: <CAMGffE=w67685o4JXYkJqXbQQnJ+YOguKX0=LeJ2L+5rn5W2Xg@mail.gmail.com>
Subject: Re: [PATCH 10/10] migration/rdma: Sanity check compress request ranges
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::533;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> The offset/length ranges are not sanity checked in RDMA requests, add the
> checks.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4005
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 13dd60c11b..699aaa9903 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3200,6 +3200,28 @@ static int dest_ram_sort_func(const void *a, const=
 void *b)
>      return (a_index < b_index) ? -1 : (a_index !=3D b_index);
>  }
>
> +static bool rdma_compress_range_check(RDMALocalBlock *block,
> +                                      RDMACompress *comp)
> +{
> +    uint64_t block_end =3D block->offset + block->length;
> +    uint64_t comp_end;
> +
> +    if (uadd64_overflow(comp->offset, comp->length, &comp_end)) {
> +        goto fail;
> +    }
> +
> +    if (comp->offset < block->offset || comp_end > block_end) {
> +        goto fail;
> +    }
> +
> +    return true;
> +fail:
> +    error_report("%s: compress request range outside range"
> +                 " (block=3D%s, offset=3D%"PRIu64", length=3D%"PRIu64")"=
,
> +                 __func__, block->block_name, comp->offset, comp->length=
);
> +    return false;
> +}
> +
>  /*
>   * During each iteration of the migration, we listen for instructions
>   * by the source VM to perform dynamic page registrations before they
> @@ -3279,7 +3301,9 @@ int rdma_registration_handle(QEMUFile *f)
>                  goto err;
>              }
>              block =3D &(rdma->local_ram_blocks.block[comp->block_idx]);
> -
> +            if (!rdma_compress_range_check(block, comp)) {
> +                goto err;
> +            }
>              host_addr =3D block->local_host_addr +
>                              (comp->offset - block->offset);
>              if (comp->value) {
> --
> 2.54.0
>

