Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F323C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDwB-00074B-4x; Mon, 13 Jul 2026 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDw9-00073S-E2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDw8-0000wY-05
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783938654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DXRHZsfAapQPGXFOByAdwNsS6K/zYNXLgtamaNoGgoQ=;
 b=DUmSW/cAwaXow+kjAdkAM7cajRh9//bdpIIvhyTEuONOkmdKcGQKbr97EZMnTPokstvKqL
 Yw+G12zHQhV8oemLeTV0M2WSzc7ofN+Zzbe9s2/k3D7ny9LjpYsc512/DylexWjdlc2yDL
 5EkBxyEw+Fmn9afrygbiGqewGfb0hr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-wpv7w0SaOaOSza_qMpZEdg-1; Mon, 13 Jul 2026 06:30:53 -0400
X-MC-Unique: wpv7w0SaOaOSza_qMpZEdg-1
X-Mimecast-MFC-AGG-ID: wpv7w0SaOaOSza_qMpZEdg_1783938652
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso1817723f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783938652; x=1784543452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DXRHZsfAapQPGXFOByAdwNsS6K/zYNXLgtamaNoGgoQ=;
 b=PZQSmATcrrK3p625STKJx5vJCRd1VDcSWY6AlEg4sgkCjWmXvmzRA6QEk4diOrdk6j
 x0zLUV/9NK16Y3QJRulBhc84p3hjuQ83Yo9D309rtnt/geKXpmQqd4mc7rnub+CWe/IO
 de5+gxXmyE6bHRPAYfckk0W0tZ2Qtu40lQwV8VaG1pKa7bCJ32318UAv5bpVjA+eHaN2
 jckzV3wZQ5XvcWvoy47xEGC+OrW+JovpnP5fV71as2GKh75qV6bYEMUkgSksYq46TF5L
 /2yEws88DcAexMAXL+pVNYPqWlL6psf3oZl2SZUoztH/gdTQ0T2/EQE0ViIzqhDG9y3O
 nkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783938652; x=1784543452;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DXRHZsfAapQPGXFOByAdwNsS6K/zYNXLgtamaNoGgoQ=;
 b=P7biSNzYL3zzr78dRWXAE19gsH4vI/AtW6a7rfOcJAiF+kCB/6DQe0utU/D9M35JKq
 mRF4SS9Fltz9WqvSp63Q8danF/IiHe5GjADJ+TYwzhxtymkGWtgC42oTSmkUiuBiu+M5
 0lI+4KQ7uqffNFUInrb8nE3y4+YNxuJd5ZOJVGvdensJhnYLpT1OCtbMeIeLLJ1Cmk0Q
 0Pdm6RkJBceEU0eE3xcJSLK4hW7E2K4lDHDkEyXb9N2weVLnZd6+CMp/nALk2t+2RpCg
 NGza7hFMDMIbPufxvOlbnYIt77ZlXqNzBWRA7YaqjEKJAP3sxZfhaMQRtKRuoJR3DLhW
 evUg==
X-Gm-Message-State: AOJu0Ywqr8eTSu1K+IKiiDR/Fc98+tvJu3hrBK8xUVn70aVpIFuDW5hN
 kB5qo9uEF0iP/PhksJKFXFMQgdmjZkQEG47fDcMPJAlikweC9jm5Tv+/AteF4K0mvMzSO8oLLMp
 VCIU1egMoFhp9mMoc1tC9+g3AxO3uN/CjOct5daU9AJT4NhltQ65yVA6G
X-Gm-Gg: AfdE7ckads12smq8+GpyROIdcYRDgcZDjzw4N7PIX8nUJQR0Lg8+rppgzuf3FHBZ8i4
 E2uaIjrzTU+ur3jPC4Nw0ETcpfAqcLp37y/AW3ROnb8E5a/femfUKDwTnU4xP0vf7Pb+IZS0s46
 ntSnHhXDodGEMdfzkeqTEqjR1L/yAK+sJjNMXt9Wh52U/BaVz57vQxkVvFXaYGD/+vS6aTpU/PZ
 yr7c+O2QiQl3QseBbW58q0csfFBlcxrPWw1gw0DWOcEdg2KqitdpauTUTGhpyFm9RxD3k8h1WB0
 Qzbf/IXN3gT8HN9sajAaFLs4YSeAfAVxyLRUyffIqQUPXBZj29UDitDWz9stRvkI4/UECL9GliF
 9tlAVoSJr
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id
 ffacd0b85a97d-47f2dcd7860mr10545177f8f.39.1783938652107; 
 Mon, 13 Jul 2026 03:30:52 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id
 ffacd0b85a97d-47f2dcd7860mr10545128f8f.39.1783938651645; 
 Mon, 13 Jul 2026 03:30:51 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm87270848f8f.2.2026.07.13.03.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:30:51 -0700 (PDT)
Message-ID: <4e1ec982-c1c7-47b5-94e8-f775d5add64a@redhat.com>
Date: Mon, 13 Jul 2026 12:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/usb/hcd-xhci: Use qemu_log_mask() instead of
 fprintf() statement
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-4-thuth@redhat.com>
 <CAFEAcA8=_3Ofp3KnOXgfk6OSRHZtvSF6L2pb47XfC8b5TTZo+w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8=_3Ofp3KnOXgfk6OSRHZtvSF6L2pb47XfC8b5TTZo+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 13/07/2026 12.17, Peter Maydell wrote:
> On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We've got a proper way for logging unimplemented hardware features,
>> so use qemu_log_mask() instead of the fprintf() here now.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/hcd-xhci.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index ee913d5c4d5..527910d92d2 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -1017,7 +1017,8 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
>>           }
>>           sctx = epctx->pstreams + streamid;
>>       } else {
>> -        fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet");
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "xhci: secondary streams not implemented yet");
>>           *cc_error = CC_INVALID_STREAM_TYPE_ERROR;
>>           return NULL;
>>       }
> 
> qemu_log_mask() strings need a trailing "\n" (as of course does
> printing messages to stderr :-)).

D'oh, I forgot it again! Thanks for spotting it! I'll send an updated version...

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Thanks!

  Thomas


