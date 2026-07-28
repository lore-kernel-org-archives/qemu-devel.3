Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F200C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocDd-0007QF-He; Tue, 28 Jul 2026 03:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wocDb-0007PY-Gh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1wocDZ-0007W1-Pn
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785223632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWZ2IwZRDhsIKjyGu5uUpNcfNA1CEMoAFMEUePFUXyg=;
 b=aEALdmNJEUHhUmTKc2jVNhrcB4KtpPFtVO2awoY5MeY4g/8BxmuwdN1/2sK1NDUHVTKCcQ
 FDn+FFRe+UpkLe2+YUjGpiPaT1MXOlo9K0grGhVw+h4AodLA7S2PUxrXxWrN/z47fSQ69f
 prV0ls+JAFb7rCj8U2btE9NOCuDVG34=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-nVxK7WKKNKircVOK8VLlDw-1; Tue, 28 Jul 2026 03:26:05 -0400
X-MC-Unique: nVxK7WKKNKircVOK8VLlDw-1
X-Mimecast-MFC-AGG-ID: nVxK7WKKNKircVOK8VLlDw_1785223564
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955d314945so24376425e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785223564; x=1785828364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EWZ2IwZRDhsIKjyGu5uUpNcfNA1CEMoAFMEUePFUXyg=;
 b=h6Ez7TSHXjleymLDqj24/Ff7GwVKAOJn5KCIhEys80FHZ4oSCTjv9H6p8yFNi9er4W
 CwhHs9447JqkzCGXFr1w7upM7B9taDI1tD6muMwt2FZy5XaG1EbLSq8cbocT1Q1IRhLx
 xnvDzxpDgAyPgQxSBSdSn6DP/5kNWwqHEDjP4qbvw7FF4ipvKOGzxVc2l2+fJpFISo94
 CT+8TVb7rak9Tg3IklOgZpipXyrsn1KAduHrmXCUe1iISX3LfpNwA2rIYCHEJJJ08OYH
 lVtCoZwE0ZQlvPzNq2tu/+rFfryEU3IYCtb5JfefZt1g5PvHG14nUMSW6/HVfS7YnJTt
 sDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785223564; x=1785828364;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWZ2IwZRDhsIKjyGu5uUpNcfNA1CEMoAFMEUePFUXyg=;
 b=UZbgAWPPmvtjZ66Wh5RODZ56M9re8MH6FFlOZ/2sPeGGe9cPeop6FLOeo9V/NmkgqZ
 AHexZjbOQwL13+M08TSvf1Ko08erB8gvyDxD5nYmscSYM7FTOwI89ZPZiuCzB/aCPOwm
 xMuenh2SyIV+xzE5PM3PpFZ+0VxZ1pdDTR56iz3bQ6r9N406Vs2iQRQc/IeNgKLykb42
 lH1Cor0OK+Rgsi7zw7j5qxI1oYQ1v9fKpyjEor8olmnd3pfxrneoqCT8h6i28YwHCCwa
 Pf1DpSvN9z2uqrJHykozUUu7xK07GvNDrFJpFE70rvWn/yM68ZG2Oz4pVd/VAg32awbS
 3VlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMc01GmqYVDdAUxnoBAeHxmK1pCS/5X0/5LERgavd/7cmkoEWufXGh++q7tWlhRfikjJxuT7ZOMSgX@nongnu.org
X-Gm-Message-State: AOJu0YwyJ+zZsnKdCdOm9DX6HgsCyAhKZovQHgyD36W6/Yqfe9b7maak
 0Zo1c8ixg1/Fajr0nxQBNkj3VyVP/bsowHVGs5HvUUcD0MCsH46+V1ZD0pOpJzv601/LVgx5WTV
 Q+gC0nYOV7WyegzsRSVlMl/ATQa/nw2yof4qYAaL6ci9QSI5rK1vNwXCL
X-Gm-Gg: AR+sD13CRH3gd/9gt9XLbhUz1F/TXTQ9v1qX/BNagBajSj/3GWkNXSfyKBnmWDPMHA1
 vnUqxXKLQpTLxg9+FUXYJnZOvRn8zec5MBuQntAc3YQzd5eUVDCEFL/Dg/eUtwf3F8gnEEtjKpw
 CIiMcApVKaSoDxiUXP/y0RmFuXtSGDUCEdRBPJYiJPIublboY/upUeIQHj/9/a2YKYXxMVP6snf
 edN/9f5ra5Jg/qMpJD0y6hzX5Woja1kqkOpWbEuIvIfHoi9pYSAhDF8GorvV1tkolLh0vD4i7Uq
 6qsqLimw08QVG5CO2ZEqoylo+5LKXTKU3d6wAfR9fgaHtBVjgiTNmkkMr9mPw+yQ9W1hzeNCqSE
 inP0gxV1PPK5Bhb+9qaUuNf92OtLBUUTfh+YU/S/ddF4hf9hX/5BglLUIi6MDERvKYJ/H+jp/xM
 JorQ==
X-Received: by 2002:a05:600c:3f16:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-496c6435aeamr10972165e9.17.1785223563743; 
 Tue, 28 Jul 2026 00:26:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3f16:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-496c6435aeamr10971875e9.17.1785223563336; 
 Tue, 28 Jul 2026 00:26:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d?
 ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm335535145e9.4.2026.07.28.00.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:26:02 -0700 (PDT)
Message-ID: <d1e6a9a5-e6ef-4f6a-82ea-20a55328bf9e@redhat.com>
Date: Tue, 28 Jul 2026 09:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 01/30] virtio: use masked features with set_features_ex
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 huntr bubble <bubblehuntr@gmail.com>
References: <cover.1785179875.git.mst@redhat.com>
 <a6e0519ea8ed6fc84fab9bf9ca82c7a55780f880.1785179875.git.mst@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a6e0519ea8ed6fc84fab9bf9ca82c7a55780f880.1785179875.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
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

n 7/27/26 9:19 PM, Michael S. Tsirkin wrote:
> virtio_set_features_nocheck() calls set_features_ex
> with guest-supplied feature bits, without masking the value
> with host features (unlike set_features which gets the
> correct val & host_features).
> 
> This does not matter if the driver matches spec, but drivers
> can be malicious or buggy and set bit outside the host mask.
> 
> Devices don't expect this, so unsupported guest feature bits getting set
> can break the host. In virtio-net, this can enable RSC without vnet
> header support and cause out-of-bounds reads from short packets.
> 
> Pass the masked features to set_features_ex, consistent with set_features.
> 
> Fixes: CVE-2026-63321
> Fixes: 64a6a336f4 ("virtio: add support for negotiating extended features")
> Cc: Jason Wang <jasowangio@gmail.com>
> Cc: Yuri Benditovich <ybendito@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
> Reported-by: huntr bubble <bubblehuntr@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
> ---
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a3655..7c19080db5 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3320,7 +3320,7 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
>      virtio_features_and(tmp, val, vdev->host_features_ex);
>  
>      if (k->set_features_ex) {
> -        k->set_features_ex(vdev, val);
> +        k->set_features_ex(vdev, tmp);
>      } else if (k->set_features) {
>          bad = bad || virtio_features_use_ex(tmp);
>          k->set_features(vdev, tmp[0]);

I fear this comes too late, but FWIW the fix LGTM, thanks Michael!

Acked-by: Paolo Abeni <pabeni@redhat.com>


